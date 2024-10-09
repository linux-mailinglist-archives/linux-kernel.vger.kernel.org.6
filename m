Return-Path: <linux-kernel+bounces-357034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728F1996AB1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387A4289026
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E162619D098;
	Wed,  9 Oct 2024 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KAf7at1M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3808B19C54B;
	Wed,  9 Oct 2024 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477946; cv=none; b=gZOYk+NdvBR/AKTsDypwOyCK6QBQessYssUuiEIPAkGGwOBW4o7ov9lXwqnA33fWdBD93Mp78rLrd0u595Q7AoeOqAFbs0cfxVYvAShOISpB2OwNYStzbk3BpmoFe2A6gkJNzkOfbHwYnwdXySXKllDP/1Z3yOmW20JjK3n1qlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477946; c=relaxed/simple;
	bh=JQz865SG89xt5Csce8+yHvEzIjSSz5CbO708670oQto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lraJTshQ45OUo+Hu311hWBhD0mlzhJZU7GIZyWoeIttZ00Z//Sg6Hf29lnVU+Z3nPZk5XV9rhre2PVP5nbnk9ZVPp6IoA2YPEl+5q7v1bRuG0ATb0Bq2ng7wENLbUVE9l4mnKbe4O5PSqTME+shxI8rCQCPE05ZaYSzwmaj5YDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KAf7at1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666E6C4CEC5;
	Wed,  9 Oct 2024 12:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728477946;
	bh=JQz865SG89xt5Csce8+yHvEzIjSSz5CbO708670oQto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KAf7at1MsvDw/kZfIdQdL3jw2pNWUO8KtN1vvPUVquNnpzb39R48h/tA9klNAs2n6
	 ilYR1KDWmnOEYfIgpK+4oYOkykk76Z8IIcNJbEoVirKq7JouKgx9/muZ1JxrUCE2ap
	 S2VQiaqY7lANoBBM1MOGh2hCw7QY/Hix6E7z67+Y=
Date: Wed, 9 Oct 2024 14:45:42 +0200
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
Subject: Re: [PATCH v4 1/5] usb: dwc3: separate dev_pm_ops for each pm_event
Message-ID: <2024100943-gallantly-animosity-2822@gregkh>
References: <20241009054429.3970438-1-guanyulin@google.com>
 <20241009054429.3970438-2-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009054429.3970438-2-guanyulin@google.com>

On Wed, Oct 09, 2024 at 05:42:55AM +0000, Guan-Yu Lin wrote:
> Separate dev_pm_ops for different power events such as suspend, thaw,
> and hibernation. This is crucial when dwc3 driver needs to adapt its
> behavior based on different power state changes.
> 
> Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
> ---
>  drivers/usb/dwc3/core.c | 77 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index b25d80f318a9..2fdafbcbe44c 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -2582,6 +2582,76 @@ static int dwc3_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static int dwc3_freeze(struct device *dev)
> +{
> +	struct dwc3	*dwc = dev_get_drvdata(dev);
> +	int		ret;
> +
> +	ret = dwc3_suspend_common(dwc, PMSG_FREEZE);
> +	if (ret)
> +		return ret;
> +
> +	pinctrl_pm_select_sleep_state(dev);
> +
> +	return 0;
> +}
> +
> +static int dwc3_thaw(struct device *dev)
> +{
> +	struct dwc3	*dwc = dev_get_drvdata(dev);
> +	int		ret;
> +
> +	pinctrl_pm_select_default_state(dev);
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_active(dev);
> +
> +	ret = dwc3_resume_common(dwc, PMSG_THAW);
> +	if (ret) {
> +		pm_runtime_set_suspended(dev);
> +		return ret;
> +	}
> +
> +	pm_runtime_enable(dev);
> +
> +	return 0;
> +}
> +
> +static int dwc3_poweroff(struct device *dev)
> +{
> +	struct dwc3	*dwc = dev_get_drvdata(dev);
> +	int		ret;
> +
> +	ret = dwc3_suspend_common(dwc, PMSG_HIBERNATE);

Why is power off hibernate?

This needs an ack from the dwc3 maintainer as I can't determine if it's
correct at all...

thanks,

greg k-h

