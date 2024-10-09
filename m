Return-Path: <linux-kernel+bounces-357035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B93996AB3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DCC289F34
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D00A19885D;
	Wed,  9 Oct 2024 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oTxOrEDc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541CE197A9A;
	Wed,  9 Oct 2024 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478048; cv=none; b=T0O/EGs7OJKniFqZEo0Ig3rRkRol10JiMMeSBlfi3OmsZR9hBMDoyxtmDpYyncsRB1k0K+/UqKmKhwQUxm/+0BufJMupd4KIhkDyku4kKFLZHTv1hs2i/zQsu4kyDzRhKkGkX0SgZvC1/nTNdfeejSVf9eqrILgxknYKLHpryaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478048; c=relaxed/simple;
	bh=0Ny/4Agj0+0aY3yUg1HSXqsuQipGIwnDusKrrI1nAag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0sT8yWoAsk6aaph8ZyNrItw/KGXorguHKmdmjzdL2fJwBIwnatFgslvKo/wjTmfBLSRjwfR3cqmbSnFwK96iHAv0MoFIHoM+o4ESQH6PFezDkIGtNtEfcxyQjXVHq3LROxs6+XeD/1rBoMju6EwYcGQXz5CZ1Z6fsc1CGnWPtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oTxOrEDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2505FC4CEC5;
	Wed,  9 Oct 2024 12:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728478045;
	bh=0Ny/4Agj0+0aY3yUg1HSXqsuQipGIwnDusKrrI1nAag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oTxOrEDcKX41Av/zpEZDJB1qiRJhNzr+ZSu9raZFhEH1gsNMOgUCQPZdUZwZJkT7b
	 0v7fjjtTl8nlz7SU3dhJtC21G5LwxGnfvFf4ksedTh91AczEV+3ROhHBvJjl25Vgrn
	 UwBD4a7cAxquUyo36l5t1AT5Es4kYVzPP58YgIE4=
Date: Wed, 9 Oct 2024 14:47:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: Thinh.Nguyen@synopsys.com, mathias.nyman@intel.com,
	stern@rowland.harvard.edu, elder@kernel.org, oneukum@suse.com,
	yajun.deng@linux.dev, dianders@chromium.org, kekrby@gmail.com,
	perex@perex.cz, tiwai@suse.com, tj@kernel.org,
	stanley_chang@realtek.com, andreyknvl@gmail.com,
	christophe.jaillet@wanadoo.fr, quic_jjohnson@quicinc.com,
	ricardo@marliere.net, grundler@chromium.org, niko.mauno@vaisala.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, badhri@google.com,
	albertccwang@google.com, quic_wcheng@quicinc.com,
	pumahsu@google.com
Subject: Re: [PATCH v4 5/5] usb: host: enable sideband transfer during system
 sleep
Message-ID: <2024100931-blabber-wilder-1ad1@gregkh>
References: <20241009054429.3970438-1-guanyulin@google.com>
 <20241009054429.3970438-6-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009054429.3970438-6-guanyulin@google.com>

On Wed, Oct 09, 2024 at 05:42:59AM +0000, Guan-Yu Lin wrote:
> Sharing a USB controller with another entity via xhci-sideband driver
> creates power management complexities. To prevent the USB controller
> from being inadvertently deactivated while in use by the other entity, a
> usage-count based mechanism is implemented. This allows the system to
> manage power effectively, ensuring the controller remains available
> whenever needed.
> 
> Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
> ---
>  drivers/usb/core/driver.c         | 10 ++++++++++
>  drivers/usb/core/hcd.c            |  1 +
>  drivers/usb/core/usb.c            |  1 +
>  drivers/usb/dwc3/core.c           | 13 +++++++++++++
>  drivers/usb/dwc3/core.h           |  8 ++++++++
>  drivers/usb/host/xhci-plat.c      | 10 ++++++++++
>  drivers/usb/host/xhci-plat.h      |  7 +++++++
>  sound/usb/qcom/qc_audio_offload.c |  3 +++
>  8 files changed, 53 insertions(+)
> 
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index c1ba5ed15214..83726bf88fb6 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -1583,6 +1583,11 @@ int usb_suspend(struct device *dev, pm_message_t msg)
>  	struct usb_device	*udev = to_usb_device(dev);
>  	int r;
>  
> +	if (msg.event == PM_EVENT_SUSPEND && usb_sideband_check(udev)) {
> +		dev_info(dev, "device active, skip %s", __func__);

When drivers work properly, they are quiet.  Why all of the loud
shouting in this patch as it goes about it's business?

also, __func__ is redundant in dev_*() calls :)

thanks,

greg k-h

