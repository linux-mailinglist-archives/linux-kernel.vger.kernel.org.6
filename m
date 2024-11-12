Return-Path: <linux-kernel+bounces-405779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF549C56E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DB21F22A13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE061BCA11;
	Tue, 12 Nov 2024 11:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O0pUXGRL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B9A19E992
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411932; cv=none; b=ayjzdiFeGK+h1xQaaGIj8eaW2sQU09HRArby82PnGuCpEi55UE2fQo/yCTG3QuxjjYpfxutoyUxf5sW4AvHfSncvETFviU+12HByCsdMoAp8Htq4WkiPo+GbETgYkRW0MZhdij+psMe1qhDjOMiPviaoRa9Nr0h9O2e0XX2Rgqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411932; c=relaxed/simple;
	bh=7LI280z4fmODV2SHNnr/yWCyaQ36kuShQQJYP5jJPDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLexefG94En1H0JCXqan9x/xunN6YvUtOUmh2gtFuCNKdxEHzfLHu65goZA6B9hPHzMdBY4AlsR6YxbV5nEyNxThgW+P4/7XwJnxAGy16BmoVtoq9RZYrkqRfC2bIdQ+SJp4VMZfDkVIBJ34jHD+v7htvNSETv8oVXrVoQ9+0Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O0pUXGRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94087C4CECD;
	Tue, 12 Nov 2024 11:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731411932;
	bh=7LI280z4fmODV2SHNnr/yWCyaQ36kuShQQJYP5jJPDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O0pUXGRLhCM8PDVlopg/DMcLkRuFJEcBROtqMnyk8L9zXmUCuDrVys+qBiboT00ZV
	 uaBGdTM0baEX8qXDeZ5bbT6Gy2hK0ArFAYczse+SLpJPwiaM8rk0zdoLyWNzymBifx
	 yaF6SBO2dmMvIVYQRudiFwUkoaz3L/HpLczvx+as=
Date: Tue, 12 Nov 2024 12:45:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 3/3] driver core: class: Delete a redundant check in APIs
 class_(for_each|find)_device()
Message-ID: <2024111230-diabetic-stubbed-102b@gregkh>
References: <20241105-class_fix-v1-0-80866f9994a5@quicinc.com>
 <20241105-class_fix-v1-3-80866f9994a5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105-class_fix-v1-3-80866f9994a5@quicinc.com>

On Tue, Nov 05, 2024 at 08:20:24AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Delete redundant check (!@class) in both API class_for_each_device() and
> class_find_device() with below reasons:
> 
> - The check is covered by later check (!@sp).
> - Callers are unlikely to call both APIs with NULL class argument.
> - Make parameter check consistent with all of other class APIs.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/base/class.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index e81da280af74..120d3aeb52fe 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -408,8 +408,6 @@ int class_for_each_device(const struct class *class, const struct device *start,
>  	struct device *dev;
>  	int error = 0;
>  
> -	if (!class)
> -		return -EINVAL;
>  	if (!sp) {
>  		WARN(1, "%s called for class '%s' before it was registered",
>  		     __func__, class->name);

Now, if I pass in NULL for class, I get an odd warning, AND the kernel
crashes with the dereference of class->name.

So this is not ok :(

> @@ -456,8 +454,6 @@ struct device *class_find_device(const struct class *class, const struct device
>  	struct class_dev_iter iter;
>  	struct device *dev;
>  
> -	if (!class)
> -		return NULL;
>  	if (!sp) {
>  		WARN(1, "%s called for class '%s' before it was registered",
>  		     __func__, class->name);

Same here, this change is going to break things if people get it wrong,
please leave both of these as-is.

thanks,

greg k-h

