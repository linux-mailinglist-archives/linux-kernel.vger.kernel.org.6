Return-Path: <linux-kernel+bounces-242244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 704FD928552
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD9C1F24891
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092D8146D7C;
	Fri,  5 Jul 2024 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GP0atmwu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49826146A8D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172542; cv=none; b=knU4J+KtRnFuBjeQw5PnpnCjdKK9Sk2ak92SmlJbOrGUgLUSHSxILdW2FxHTklbPYCtqmSkh13pfP4KgifcsJnfSw3Q+L5DaA58ZTBtMkEjE3oQ3gh6U+HwPxwXEwcVbF9IVPe+v5xyWMN4oGYWtq1jUoxOajM+KFAouIYOa7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172542; c=relaxed/simple;
	bh=Lh+w/2dBdW+n7UwNayV6mIOdMGjyzUOrp9uaxha2w0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aelfOSacrhgjfhAFQyj0BvNoIVZ54Xptg79TAU18AjiMr6o0gnSt4v2AzcNHgLahLoTdni9V9lNpFkZpy1KYsxCA55WsT/6gmfetvjADjJ5R3xsO25ZkYbIe+UKvqaW4/kFwfhAYfbBwbMMmgwaQFmpvIdHMNqyUNe+nrBHWQH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GP0atmwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D40AC116B1;
	Fri,  5 Jul 2024 09:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720172541;
	bh=Lh+w/2dBdW+n7UwNayV6mIOdMGjyzUOrp9uaxha2w0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GP0atmwueKM9WMMz9d9e97JvDe3vGLDQdtQvO3t/uU/qgmo6VYBRsvnz8XyEHR5Ii
	 WTHqeMrxbEAMs81EuFGCaK6I40SNa9nMEZ9ICHB0sb+lgEGSJypKu/JHHPqUemnVZi
	 eaIc5YdmBOhxffc1n8afsHdAZzgfxgmi9bjSicYo=
Date: Fri, 5 Jul 2024 11:42:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: tuhaowen <tuhaowen@uniontech.com>
Cc: alexander.deucher@amd.com, huangbibo@uniontech.com,
	linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com,
	wangyuli@uniontech.com
Subject: Re: Re: [PATCH] dev/parport: fix the array out-of-bounds risk
Message-ID: <2024070523-singer-dweller-f1bb@gregkh>
References: <2024070503-concert-mummify-dcbf@gregkh>
 <20240705085834.17224-1-tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705085834.17224-1-tuhaowen@uniontech.com>

On Fri, Jul 05, 2024 at 04:58:34PM +0800, tuhaowen wrote:
> On Fri, Jul 05, 2024 at 02:45:45PM +0800, Greg Kroah-Hartman wrote:
> 
> > I'm not disputing that this change looks correct, I'm asking that you
> > redo it and properly check the array size when writing to it so as to
> > ensure that it really is correct in case our math is incorrect
> > somewhere.
> 
> Thank you for your feedback. I have redone the change and 
> ensured that the array size is properly checked when writing to it. 
> Please find my updated patch below.
> 
> Thanks,
> 
> Haowen.Tu
> 
> 
> >From cfdf8445987147f3a7e4f1232a8c6e8a271e4a6d Mon Sep 17 00:00:00 2001
> From: tuhaowen <tuhaowen@uniontech.com>
> Date: Mon, 27 May 2024 14:34:32 +0800
> Subject: [PATCH] dev/parport: fix the array out-of-bounds risk

Sorry, we can't take inline patches like this, please read the
documentation for how to submit a new version of a patch.

But, some comments below:

>         for (dev = port->devices; dev ; dev = dev->next) {
>                 if(dev == port->cad) {
> -                       len += sprintf(buffer, "%s\n", dev->name);
> +                       len += snprintf(buffer, 64, "%s\n", dev->name);

Don't use magic numbers here and everywhere else, use sizeof() to
compute these properly everywhere.

thanks,

greg k-h

