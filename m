Return-Path: <linux-kernel+bounces-287732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B606952C03
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0099C1F24796
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2951BF309;
	Thu, 15 Aug 2024 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zcq6hIT0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E731BBBF0;
	Thu, 15 Aug 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713630; cv=none; b=gM75Pi3c1o7EF6LWvLsRd8UM69loZniw2xIh39C0hORzk+978AOm66uKovUX0wN4DZI+f1GVyYZ+xoQetEY0qjrKyKg4ecUrkCzR1L8Xv5SffIZg5X0+JeUlUaeZbwWc1aUiZxAN2HaKvolNpQeZPhEU3uGvQrKqSwKdYePS9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713630; c=relaxed/simple;
	bh=fCPEKdvZte72nEo47KA/kZnx4XIPsFUVSnD634fu6gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OT4LvnyLeNqRG9PJS+3AoSv7F3RdiNCpQNAl+iaARzFIzCKy1YF5ymvfFZMeqnUyDjKt9NoSq3vg/5Yem+bK0sUl5CUjIWFsetImqSKa+KJ4mF6XzFbhfWswIQf07umF1001D9Fi4m2EKSx8boBPWuDVOpypYnV56TbX+F/QjJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zcq6hIT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE69C32786;
	Thu, 15 Aug 2024 09:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723713629;
	bh=fCPEKdvZte72nEo47KA/kZnx4XIPsFUVSnD634fu6gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zcq6hIT0G/Kulf+4TPYAmpBxlcytmgbiXR5YQ0pz6wQoLX1H/jq70wYR0M2o3vNGO
	 X1Jm6qIATKY+ivVIO1qwYCb15KpnjvLh58WdHSXVnIJsgfRvrJE8mWMPAHbLP41gog
	 e6QX2U6qCxQBaDsacN/3vYeRpJg6p/YFZdb28bPM=
Date: Thu, 15 Aug 2024 11:20:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
	dan.carpenter@linaro.org, linux-usb@vger.kernel.org,
	skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: uvc: Fix ERR_PTR dereference in
 uvc_v4l2.c
Message-ID: <2024081501-pried-rewire-e229@gregkh>
References: <20240815071416.585559-1-abhishektamboli9@gmail.com>
 <2024081518-fracture-thousand-c20e@gregkh>
 <Zr3B9Sccu+1FHW2z@embed-PC.myguest.virtualbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr3B9Sccu+1FHW2z@embed-PC.myguest.virtualbox.org>

On Thu, Aug 15, 2024 at 02:23:09PM +0530, Abhishek Tamboli wrote:
> On Thu, Aug 15, 2024 at 09:59:35AM +0200, Greg KH wrote:
> > On Thu, Aug 15, 2024 at 12:44:16PM +0530, Abhishek Tamboli wrote:
> > > Fix potential dereferencing of ERR_PTR() in find_format_by_pix()
> > > and uvc_v4l2_enum_format().
> > > 
> > > Fix the following smatch errors:
> > > 
> > > drivers/usb/gadget/function/uvc_v4l2.c:124 find_format_by_pix()
> > > error: 'fmtdesc' dereferencing possible ERR_PTR()
> > > 
> > > drivers/usb/gadget/function/uvc_v4l2.c:392 uvc_v4l2_enum_format()
> > > error: 'fmtdesc' dereferencing possible ERR_PTR()
> > > 
> > > Also, fix similar issue in uvc_v4l2_try_format() for potential
> > > dereferencing of ERR_PTR().
> > > 
> > > Fixes: 588b9e85609b ("usb: gadget: uvc: add v4l2 enumeration api calls")
> > > Fixes: e219a712bc06 ("usb: gadget: uvc: add v4l2 try_format api call")
> > > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Add check for dereferencing of ERR_PTR() in uvc_v4l2_try_format()
> > 
> > You sent 2 copies of this, which is the correct one?
> Sorry about that. Actually, I forgot to add the maintainer: Laurent Pinchart 
> in my first Patch v2 mail.

Ok, then that would be a v3, right?  Please remember we get hundreds of
patches a day and keeping them all straight is important :)

thanks,

greg k-h

