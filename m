Return-Path: <linux-kernel+bounces-361402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8CD99A7B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AEF91F23384
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA0A194C73;
	Fri, 11 Oct 2024 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="NycKO9b2"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C47194C94
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660584; cv=none; b=Lslmfu9+UJVuW7bAaVzeAkTeYY8wqpMNl9mUwogaV8tB97LxPMu+/0vK6SunyBPInE/uwkLTpGZbDqLR/mBY3nwxOCHUV2fb258oJw3ReBVYTNEqmNNWK5NmTjTNAp3GcjYpbI1w2nyhOwMvQLieA+NHEd3pL0d5aIREfpkeiRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660584; c=relaxed/simple;
	bh=L+1vIZ1LGvXuZQq8x99G7kK5sIk7Bhl5Usj3xUZX794=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3WWPgM5r/RtDVi5cpkePUA3+4uWfPuRtdxW7yi91RVYQ/hO0FMd5NwZVk8I6ejpoUGw/YK6fI/9ZqtEARPPa81j47MW63zwutQ/r6iwN6cMTg92R0u0qMa43iZiNuOsbtkagMhmxGDdH66rmR/uiVClaWolQIiquu3HdOBBgp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=NycKO9b2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e221a7e7baso1517056a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1728660581; x=1729265381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OfEakMtjipcZbjXlN6+R0PDo0Z9g86WwST3PngXMQx0=;
        b=NycKO9b2BIx8v0+JqOCpzYkycgK1qceNSMy/8pAlEbccJ9NzSiF6UVQo+nGtC04wlw
         AKf9pifUQ65DjwRfJsVgrvJ9y1Oq43//xVCF13BO70yUZ7C1c/G9J+iE1nsgRz5jcJEx
         +J97Hyr2VSAf1rmUDzh0z6fj5k4M2JWRnMXe0XjsAPO+cySzpuoIOaS45ftr1F6x++2W
         kK2hK9yeElM9V8O+vbwTn54odNlu2FsFXI8rmw//yxJxMzefOXR/+vL3EtaSyqOMKojL
         r6BZ+X9rC4sWqEb30fbZlMwYdd9jqK7Xez9tx+o665xGI2/FRT7NhjzC9Q6DVP49r2Xo
         YudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728660581; x=1729265381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfEakMtjipcZbjXlN6+R0PDo0Z9g86WwST3PngXMQx0=;
        b=lpFwXaMEXKDC1x4UfnrTVptGpRKYtqhJbXse9MyTRtxhpNJMY98xHZeBFJCiXY4RCE
         a3f6R9LPeWigRiW9+nlAlpFWDE2TYRH2HpeUMirTipfppHIDiKoOm9Gnjzs0Z3TDhLzo
         wpAOm4BdTTeqNRUHlqkzcqme9zvXutmSmDpKFdFoTOsL2R9ttpKAMO/wV0T88lq7mFm6
         0tbAG++rCqtuWheH2385Qcz00NgzbbUQuxAfCaMfSn8TLOCf8JVXYcWEZdZbzjwXmD+O
         96aJTBZFtX5gM8BoDXep77m5e1x/1bUTFjbb1RyCXoA7egb3NAxsSHyCzosnL89EcGFj
         t7+Q==
X-Gm-Message-State: AOJu0YwWna96iF5/rGX8P/U2jlD9A7IdMGj6pk7eE728lxlR7owc8V5u
	eQyPRxir9NVUXUNjhxKfwm+mb+sVpu7TfZEMXdg8/vbLkV7tD1+W1Ott4LqQPYc=
X-Google-Smtp-Source: AGHT+IHgtz1x0nXARrJgLDPonSVb2k7CZhKElZ+N4WzyvXUVmzhbMekGN14tBxZaVtYhG/oDkXvWBQ==
X-Received: by 2002:a17:90b:4a08:b0:2c9:6a38:54e4 with SMTP id 98e67ed59e1d1-2e2f0dd81efmr3710515a91.41.1728660580594;
        Fri, 11 Oct 2024 08:29:40 -0700 (PDT)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5eeafe8sm3361493a91.13.2024.10.11.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:29:40 -0700 (PDT)
Date: Fri, 11 Oct 2024 08:29:38 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: Re: [PATCH v1 1/3] pinctrl: th1520: Fix pinconf return values
Message-ID: <ZwlEYi/AFCTWVOl5@x1>
References: <20241011144826.381104-1-emil.renner.berthing@canonical.com>
 <20241011144826.381104-2-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011144826.381104-2-emil.renner.berthing@canonical.com>

On Fri, Oct 11, 2024 at 04:48:23PM +0200, Emil Renner Berthing wrote:
> When Drew took over the pinctrl driver he must have changed
> all the -ENOTSUPP returns into -EOPNOTSUPP. This subtle change
> was most likely not spotted because it was never mentioned in the
> changelog of the patchset, but it breaks all the places in the
> pin control and GPIO frameworks where -ENOTSUPP is expected.
> 
> Fixes: bed5cd6f8a98 ("pinctrl: Add driver for the T-Head TH1520 SoC")
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---
>  drivers/pinctrl/pinctrl-th1520.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-th1520.c b/drivers/pinctrl/pinctrl-th1520.c
> index c8d2ee6defa7..03326df69668 100644
> --- a/drivers/pinctrl/pinctrl-th1520.c
> +++ b/drivers/pinctrl/pinctrl-th1520.c
> @@ -591,7 +591,7 @@ static int th1520_pinconf_get(struct pinctrl_dev *pctldev,
>  	u32 arg;
>  
>  	if ((uintptr_t)desc->drv_data & TH1520_PAD_NO_PADCFG)
> -		return -EOPNOTSUPP;
> +		return -ENOTSUPP;
>  
>  	value = readl_relaxed(th1520_padcfg(thp, pin));
>  	value = (value >> th1520_padcfg_shift(pin)) & GENMASK(9, 0);
> @@ -636,7 +636,7 @@ static int th1520_pinconf_get(struct pinctrl_dev *pctldev,
>  		arg = enabled ? 1 : 0;
>  		break;
>  	default:
> -		return -EOPNOTSUPP;
> +		return -ENOTSUPP;
>  	}
>  
>  	*config = pinconf_to_config_packed(param, arg);
> @@ -661,7 +661,7 @@ static int th1520_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
>  	u16 mask, value;
>  
>  	if ((uintptr_t)desc->drv_data & TH1520_PAD_NO_PADCFG)
> -		return -EOPNOTSUPP;
> +		return -ENOTSUPP;
>  
>  	mask = 0;
>  	value = 0;
> @@ -676,14 +676,14 @@ static int th1520_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
>  			break;
>  		case PIN_CONFIG_BIAS_PULL_DOWN:
>  			if (arg == 0)
> -				return -EOPNOTSUPP;
> +				return -ENOTSUPP;
>  			mask |= TH1520_PADCFG_BIAS;
>  			value &= ~TH1520_PADCFG_BIAS;
>  			value |= TH1520_PADCFG_PE;
>  			break;
>  		case PIN_CONFIG_BIAS_PULL_UP:
>  			if (arg == 0)
> -				return -EOPNOTSUPP;
> +				return -ENOTSUPP;
>  			mask |= TH1520_PADCFG_BIAS;
>  			value &= ~TH1520_PADCFG_BIAS;
>  			if (arg == TH1520_PULL_STRONG_OHM)
> @@ -718,7 +718,7 @@ static int th1520_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
>  				value &= ~TH1520_PADCFG_SL;
>  			break;
>  		default:
> -			return -EOPNOTSUPP;
> +			return -ENOTSUPP;
>  		}
>  	}
>  
> -- 
> 2.43.0
> 

Reviewed-by: Drew Fustini <dfustini@tenstorrent.com>

Thanks for the fix. This was something I changed due to checkpatch
("ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP") wihtout
realizing the implication.

-Drew

