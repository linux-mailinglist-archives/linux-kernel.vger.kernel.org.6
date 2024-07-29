Return-Path: <linux-kernel+bounces-265825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42D993F67E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1EB1C22D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA241527B1;
	Mon, 29 Jul 2024 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ha+FX9OM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0023F1487C3;
	Mon, 29 Jul 2024 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258479; cv=none; b=AO3f4zkW2F0bogkDWBOjFZyEY5fWqnGXNadqz1zUy4t2c8GpEAJKl1D63GGTMlbWCeqv0ripst7pP8rQkIsUVbUOUIXE/OsXiKiw5thgvPW6jWE++dkd7xFMdv+jwrKp7ZSOFHYjaA5qaMJVWNEZt0qsz91HbQG/VYa5VREo2Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258479; c=relaxed/simple;
	bh=q2fn1DENSO460i6FaQEI/jbS5l3LlkB4Dcvk3RhD7kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgHWkJtdT1jadJAfRYFjS2GoD7lD583XU26KxHXOulyON/4cW6UV8Afffo26YNfOYHswHqtJnbv7Bwr+0lOJa7/EhlJDHMruUwAz8uzW17DFsOYW61otolwpBbjz3fiRfpM+W8IRe5wQwKa0pdN63CgnC/ZK6e8aFMLGEa4odzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ha+FX9OM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0132FC4AF09;
	Mon, 29 Jul 2024 13:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722258478;
	bh=q2fn1DENSO460i6FaQEI/jbS5l3LlkB4Dcvk3RhD7kE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ha+FX9OMrpp8fXI0vt9rR97f9CcXKuSsIjnpwR6RUy79h8l0u2DBm4GsRd4oLiHCL
	 QZs3NAzoLOy8X9EQyXh+lZYaTN4VV0Rk/DEh1G/yOvGmUUvqjDzcJ94zX4g9346KPr
	 sr5OUJqmJR6jB/vXB2AA4EGNv+XyIvGaQF2mCuLU=
Date: Mon, 29 Jul 2024 15:07:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Filipe Manana <fdmanana@kernel.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-26905: btrfs: fix data races when accessing the
 reserved amount of block reserves
Message-ID: <2024072933-conical-chevy-f9c4@gregkh>
References: <2024041746-CVE-2024-26905-69f0@gregkh>
 <ZqePLSiplMVebl39@debian0.Home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqePLSiplMVebl39@debian0.Home>

On Mon, Jul 29, 2024 at 01:46:37PM +0100, Filipe Manana wrote:
> On Wed, Apr 17, 2024 at 12:29:20PM +0200, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > btrfs: fix data races when accessing the reserved amount of block reserves
> > 
> 
> Greg, can you clarify why is this being classified as a CVE?

The text of the changelog made it sound like a race condition that was
being fixed, except for this bit:

> > So add a helper to get the reserved amount of a block reserve while
> > holding the lock. The value may be not be up to date anymore when used by
> > need_preemptive_reclaim() and btrfs_preempt_reclaim_metadata_space(), but
> > that's ok since the worst it can do is cause more reclaim work do be done
> > sooner rather than later. Reading the field while holding the lock instead
> > of using the data_race() annotation is used in order to prevent load
> > tearing.

That paragraph explains that this really isn't a vulnerability, sorry
about that.  I'll go reject this CVE id now, thanks for the review!

greg k-h

