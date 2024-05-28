Return-Path: <linux-kernel+bounces-192894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD998D23A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E021C21C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663DD16FF4F;
	Tue, 28 May 2024 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AUkN9NUF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B1438384;
	Tue, 28 May 2024 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922869; cv=none; b=iw0C/VllGa8VZcgOcI80yIdE918TmJ8UYcgbkF28lrYjCf0bgJ0DKSt8qHqEt90GlHQlJQ2HsvJDn5a1rw1aS282vvVzUMox42w9cL5VXe2SEPJJ+lsKDjBVFBUEuyngccv63U6yV1QhVnmG+Oon62YnGUtt2CUMeHioM0V7eSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922869; c=relaxed/simple;
	bh=v2Ps8vw965nwPRGF+CGbeADDlCaTl8TAmm5pcwPfnYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMrAb1aJndJM9KV3H0i/mueVppakBIdJE04nHtb+gmVh4idlSrUVUoC3f2iIjDdYoB3k+beh55gmsgCQcw9aPq05IF0WLbUGwqif9BkwleQaWGNwEEkeaY3tVowOJ0b3oIBl8zCM8ExsRDwVVlofZsvupiqA9xOxjxzMlswher0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AUkN9NUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E68C3277B;
	Tue, 28 May 2024 19:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716922869;
	bh=v2Ps8vw965nwPRGF+CGbeADDlCaTl8TAmm5pcwPfnYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AUkN9NUFe+w/vVL6Aim3THJLe+QCMfmGdrQcsIluv2mJ7n0Mc2IZQWLa3wL59hV8D
	 d9QBNXQS7qXDGEQ+LSbm3B7h/zDEnbg8FP6L9FUfkrGa3D3TNkdLQGQVG//tqXZGbK
	 ChsHBC1kpfDiQyi0RS9Q2gX+Z/lNfMlq528mOwnA=
Date: Tue, 28 May 2024 21:01:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: linux-cve-announce@vger.kernel.org, cve@kernel.org,
	linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: CVE-2023-52685: pstore: ram_core: fix possible overflow in
 persistent_ram_init_ecc()
Message-ID: <2024052811-cornfield-monday-8bb9@gregkh>
References: <2024051752-CVE-2023-52685-64c5@gregkh>
 <87jzjeojwp.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzjeojwp.fsf@mailhost.krisman.be>

On Mon, May 27, 2024 at 08:32:54PM -0400, Gabriel Krisman Bertazi wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > Description
> > ===========
> >
> > In the Linux kernel, the following vulnerability has been resolved:
> >
> > pstore: ram_core: fix possible overflow in persistent_ram_init_ecc()
> >
> > In persistent_ram_init_ecc(), on 64-bit arches DIV_ROUND_UP() will return
> > 64-bit value since persistent_ram_zone::buffer_size has type size_t which
> > is derived from the 64-bit *unsigned long*, while the ecc_blocks variable
> > this value gets assigned to has (always 32-bit) *int* type.  Even if that
> > value fits into *int* type, an overflow is still possible when calculating
> > the size_t typed ecc_total variable further below since there's no cast to
> > any 64-bit type before multiplication.  Declaring the ecc_blocks variable
> > as *size_t* should fix this mess...
> >
> > Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> > analysis tool.
> 
> Hi Greg,
> 
> [Cc'ing Kees, who is listed as the pstore maintainer]
> 
> I want to dispute this CVE.  The overflow is in the module
> initialization path, and can only happen at boot time or if the module
> is loaded with specific parameters or due to specific acpi/device tree
> data.  Either way, it would require root privileges to trigger.

Normally root privileges isn't the issue, as many containers allow root
to do things (including loading modules, crazy systems...)

Anyway, I'll defer to Kees as to if this should be revoked or not.

thanks,

gre gk-h

> 
> -- 
> Gabriel Krisman Bertazi

