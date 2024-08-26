Return-Path: <linux-kernel+bounces-302332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A799395FCB9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6356D2836F9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3805919D896;
	Mon, 26 Aug 2024 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QDJbzEGR"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E1619CD1D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711243; cv=none; b=R+88VENxTbHuey7RQ7SZHHuCs7m6rUKx0zLZ25+2QYHAnnp+0lLBibh3WX2diiBGG3dTti7D2H2MZVYj7J4YEgslnrXP+ECBW03oMT83m8pi+E4Z9XGmHNGiz/Zm08p7jkNJfxF1ldmEbNKaEae/T5HYtE2Gr5WNwWCWHIx8Rco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711243; c=relaxed/simple;
	bh=7knaidMnlelJb7eQ1hfz+yPYhdm4IjSTzrkXIedXWEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDfytYat28ZrwSwv1/jCWLOQERJ6iUAXkL5nvDk/urc957hVsn5vWIumHERhldkSd3CwkD6yQgJOZwhhn43P8fGhnelTW0H9lRiMmvSLQt53lwM3t+6FR41NeVOkCvpQIb0AYFkzDG7EM9LtUNA4A0/55IIbbuAKTsZ9zMz5FR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QDJbzEGR; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-27032e6dbf2so3199255fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724711241; x=1725316041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TSaDBvyq/bFcO3OcsC5ci/zFSviUd1t2kxCPPZcFB+8=;
        b=QDJbzEGRfUIkge9/E+fpTfpBRRZWgnA9rNab97DhRMaPhjeXKd4YUea6mNere7Wj/Y
         02z5hChMEPSguKTjhdQBCbhDsK88s9avRBiuqc2+33Ku9mQSqEjiJ+CRSXchku8NOuMI
         LSbCW6GjufziFy9zvDGEvh8ETihsJZeU45GHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724711241; x=1725316041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSaDBvyq/bFcO3OcsC5ci/zFSviUd1t2kxCPPZcFB+8=;
        b=M9vW37hibjnjvSdDg4N0lrV+52ODFGp0zAlzi0l8K96ePBjz/9vuMOKNW10TY11zpM
         W02zj9mpwdWMNbCgGU9l/HkK9d5RABmXcAn3sqDKrcI9II8ImaUakXpU3kSb8MQRSmIh
         81mmSvalnJEDMDkc3MY3icU/6Rbiclk5zE3SK35BW5ZCPD1tLod7IFum5gzV3WNwLGjT
         6M0yE+BZrqfXI0p+jF3vMt5lFxD2n74GiDCEBzVjRKuAXTjrX5537Y3snu0Bnru3hf8M
         nMWQze5Xmheju+Qwqwql9Ir1xb1bEPlHEY5bIrDtbCROLVZpWt7hgau/TrX2OMJ/duRf
         ecsw==
X-Forwarded-Encrypted: i=1; AJvYcCW+fFs9O7VOWof6wOYS6KrI147bQmXqlZV4om+HuVJzKnuWRfPKg5ETWg2OXVGCmTIsX9LvtCyjE8BevGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyADM7gUG9D4IqSuTdzGclFkmYSw8BAaWyg0Wz2uQTnsshpcMvg
	2K7KNqasCu59HNuQeuV+evwcEFIFz0iarr4m5B++1/57Bq3u+f2KNaHCEfWOtw==
X-Google-Smtp-Source: AGHT+IFUHF3HtJhxNyKdeJjkwJ+tECgitLmEFbmHNSQGwUUS7HccdzeehXGx7JgW5MXroG3lwlDQqQ==
X-Received: by 2002:a05:6870:2108:b0:260:df8a:52bf with SMTP id 586e51a60fabf-273e64697eamr11748626fac.2.1724711240763;
        Mon, 26 Aug 2024 15:27:20 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:7e40:430b:848a:1da6])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7cd9acddb57sm8107858a12.54.2024.08.26.15.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 15:27:20 -0700 (PDT)
Date: Mon, 26 Aug 2024 15:27:18 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jon Lin <jon.lin@rock-chips.com>
Cc: broonie@kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org, heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: rockchip: Avoid redundant clock disable in pm
 operation
Message-ID: <Zs0BRsNdZdI69aXM@google.com>
References: <20240825035422.900370-1-jon.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240825035422.900370-1-jon.lin@rock-chips.com>

(NB: I have several nearly identical copies of this email. I'm replying
to the latest one I see.)

Hi Jon,

On Sun, Aug 25, 2024 at 11:54:22AM +0800, Jon Lin wrote:
> Fix WARN_ON:
> [   22.869352][ T1885] clk_spi0 already unprepared
> [   22.869379][ T1885] WARNING: CPU: 3 PID: 1885 at drivers/clk/clk.c:813 clk_core_unprepare+0xbc4
> [   22.869380][ T1885] Modules linked in: bcmdhd dhd_static_buf
> [   22.869391][ T1885] CPU: 3 PID: 1885 Comm: Binder:355_2 Tainted: G        W         5.10.66 #59
> [   22.869393][ T1885] Hardware name: Rockchip RK3588 EVB1 LP4 V10 Board (DT)
> [   22.869397][ T1885] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
> [   22.869401][ T1885] pc : clk_core_unprepare+0xbc/0x214
> [   22.869404][ T1885] lr : clk_core_unprepare+0xbc/0x214

I appreciate the snippet of a WARNING trace, but I'd also appreciate
some actual explanation of what the problem is, and why you're solving
it this way.

> Fixes: e882575efc77 ("spi: rockchip: Suspend and resume the bus during NOIRQ_SYSTEM_SLEEP_PM ops")
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> ---
> 
>  drivers/spi/spi-rockchip.c | 57 +++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index e1ecd96c7858..043a7739c330 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c

> +#ifdef CONFIG_PM_SLEEP
> +static int rockchip_spi_suspend(struct device *dev)
>  {
> +	int ret;
>  	struct spi_controller *ctlr = dev_get_drvdata(dev);
> -	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
>  
> -	clk_disable_unprepare(rs->spiclk);
> -	clk_disable_unprepare(rs->apb_pclk);
> +	ret = spi_controller_suspend(ctlr);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Avoid redundant clock disable */
> +	if (!pm_runtime_status_suspended(dev))
> +		rockchip_spi_runtime_suspend(dev);

It seems like you'd really be served well by
pm_runtime_force_{suspend,resume}() here, and in fact, that's what this
driver used to use before the breaking change (commit
e882575efc77). Why aren't you just going back to using it? (This is the
kind of thing I might expect in your commit message -- reasoning as to
why you're doing what you're doing.)

And in fact, I already submitted a patch that resolves the above problem
and does exactly that:

https://lore.kernel.org/all/20240823214235.1718769-1-briannorris@chromium.org/
[PATCH] spi: rockchip: Resolve unbalanced runtime PM / system PM handling

Do you see any problem with it?

Thanks,
Brian

> +	pinctrl_pm_select_sleep_state(dev);
>  
>  	return 0;
>  }

