Return-Path: <linux-kernel+bounces-179452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C908C6016
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C661C221F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED913BBD6;
	Wed, 15 May 2024 05:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y6RbVJhk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3273E3BBC0
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 05:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715750098; cv=none; b=RAqh8oPMFKdU5ludBzRFHhR78Zy66XtPtSkB6AYNLPpiTT/5ASnDBwKMj2GcZFnNLxwJpeLne736auOVMX/Y6DOHWKQ7A/wlumhXLkeAnPH29iZGtJKiZngdHaQUCzhNKhovZ7mp5rt/SDhHz9a6IOjSmUt++O/ZR4L0HSSqTuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715750098; c=relaxed/simple;
	bh=eckvt/j+ok6jhw/n0OE6TkB1kQA6KiUoQbxrQRc6elg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=az3X/cmrwnbIPobtPXRTjBEyxr1o8vltxg3Gk2JmKR3eOh63EKqBD2GvjoSik5fnNzGT3MJWmnM/RnkHc+sxmJC65siUTQK4/Z/3JJBZLOUP+Cu31Glt3uoM1F2ElTwXp4Q1bHGrXhNmJh7oFZdSelXPt7iNN3exz5XymC+SDPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y6RbVJhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A96CC116B1;
	Wed, 15 May 2024 05:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715750097;
	bh=eckvt/j+ok6jhw/n0OE6TkB1kQA6KiUoQbxrQRc6elg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y6RbVJhkG1dKA06uvdj0C/6xBCFgNJ4oCyZ5UNTUT6b4g1ZUMMX1wEc/TqfQ09FmR
	 whHYS7sFRbuqshhgFvmg0Ir5r8MOvJYvwxnzN0KUQ4e30AqZrsyBf1q7qXuTvRxX4z
	 dKA/7Q0otadbCKThyPh6aEj++KnRwPQdmAFXU0tc=
Date: Wed, 15 May 2024 07:14:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: ntsync: mark driver as "broken" to prevent from
 building
Message-ID: <2024051521-mankind-borough-f773@gregkh>
References: <2024051450-abrasion-swizzle-550b@gregkh>
 <12433821.O9o76ZdvQC@watership>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12433821.O9o76ZdvQC@watership>

On Tue, May 14, 2024 at 04:45:13PM -0500, Elizabeth Figura wrote:
> On Tuesday, May 14, 2024 2:16:51 AM CDT Greg Kroah-Hartman wrote:
> > The ntsync code is only partially enabled in the kernel at this point in
> > time, creating the device node and that's about it.  Don't confuse
> > systems that expect to see a working ntsync interface by teasing it with
> > this basic structure at this point in time, so mark the code as "broken"
> > so that it is not built and enabled just yet.
> > 
> > Once the rest of the code is accepted, this will be reverted so that the
> > driver can be correctly built and used, but for now, this is the safest
> > way forward.
> 
> Reviewed-by: Elizabeth Figura <zfigura@codeweavers.com>
> 
> --
> 
> I was even thinking of suggesting something like this myself. Sorry for
> taking so long to get the rest of the patches into acceptable shape...

No worries at all, I'll go queue this up today.  Thanks for the review!

greg k-h

