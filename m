Return-Path: <linux-kernel+bounces-395358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38F49BBCD8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40748B23741
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9128D1CB9E2;
	Mon,  4 Nov 2024 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ge8JaytE"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801151CB33E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743491; cv=none; b=XuKhzADVDKB92mETuiYbt5hRra2N1MMXhbZB4ixf+R2yqMepFEFjTzwNkxKOf/A20WxqznDUWAu3Ikxweu3JLa96Neg5FO1FyFRKKeWsF5T3IoMn2w3sFR0CIZ16YnVvHJ4eigYc+jvT+fKJb9lNXp53prTQ2LdfNAba0/bE3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743491; c=relaxed/simple;
	bh=GVl1UEr0NWZX9IevbvvM2P+0VKWLEsKWWi7/kLeYQ/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sz9vb9DFt6L8hAxYhixCtC+JBITa/0rMpBvWqI6hkqCSPM339FtdEYEwSkQMuHPIBVJjdEeWBb9nVVcE9iOydmWGW13ZdAZfS4mdxHE83W1PNuTlExWF9VxjPBNjU73ZuD8di4E1Qg9zHvsvYsbFsHGhqHio8I1hFy6diqa02xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ge8JaytE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cf6eea3c0so35613825ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 10:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730743489; x=1731348289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRvQf1xuqfHPBwS7luz0cb6H5Ugq9JMPjVW+YufCtSs=;
        b=Ge8JaytEEaAH6vCxwNZm8IcfvdwY00Rx2DT/rhn2sEvr3LT/9dlImoTSf+pxYFkQ/h
         AAAIvVvyuY26pStdt9fMoe6e9wC9JnrSCS1RB0pffHyBtkEL0Zhwq5bIy94JtW7RH3xG
         dQtPWGNqHzcgPOQJ+TOQvh/FJAFbTqEIazLkFZJSRQjJuY7nOGW6nH1wvws0YcYS22Wz
         csi52ldxj2n3dPMD9oD4o9Nxzc207XvdbU3xraI9s+LykwodzrK8d7XklpvBaKtcmLUm
         yWZ6ivmWSZ/a7lcrQMtDWTKKbGwRD2gtpNtUwZDYrhEhzuC5J+2DSWCFa0AOa7k/s7iC
         fQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730743489; x=1731348289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRvQf1xuqfHPBwS7luz0cb6H5Ugq9JMPjVW+YufCtSs=;
        b=ngOsEE5wKauqR30Eq8N2iE6IPOyyEBfZX2ZUaLuZEIGbTR3/NjMGrTP8uX+Z1+Yi2i
         wG20IfMl3Awz5r6AiGAwsw/QG5d6a/7Dzv3iJYnLzpcKUmM8BlziqTrV2WJYGSet5rhN
         ALl/WlAQSFEfy2fyOFt91Zap1MIm5clWQ27KCg/OcACKJKaUwEC/FMwaChlTrMPdYTbt
         jWHQEg84u+CryNdWMQJTGpENWyR22TuVOJBZUEwPPgveZchhUS9HA3sk6ZU2deSN1ulv
         iHK2iDuBgc004Xk74gANDD1Rxs6X+zaEFLVWxkkJ/wvD2PwJwqBXbHQdrOjsS6GTB7Cf
         /oJw==
X-Forwarded-Encrypted: i=1; AJvYcCVhi6/EQWVOUUsJ/vE+TjyPhhRNh0B/9dNx8SQWpUQgm263G9dxmpU+4q+sBrP6sJcQ+7LYLNOdVjjXPrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiec8h6oLH9KpblfJKfU0D+Et4rKbChADeaMq5Bt+K10qKALP9
	c9EEjkawMpI29cu8xf6fPnV946RrP9eoX7mKQc7j8uCZNCP/b7Fp89w9JvFkXg==
X-Google-Smtp-Source: AGHT+IFvuvps9+tEEfjMCZ4O3+x8fIkpxluQUBg5LTSx8jxApvw7eE44IevfvcA3aT6CY7QxgNhUjg==
X-Received: by 2002:a17:903:182:b0:20b:8a71:b5c1 with SMTP id d9443c01a7336-210c6872b1amr454253325ad.1.1730743488429;
        Mon, 04 Nov 2024 10:04:48 -0800 (PST)
Received: from google.com (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057063f9sm63286905ad.65.2024.11.04.10.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:04:47 -0800 (PST)
Date: Mon, 4 Nov 2024 10:04:44 -0800
From: William McVicker <willmcvicker@google.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dhruva Gole <d-gole@ti.com>, sashal@kernel.org,
	Chris Morgan <macroalpha82@gmail.com>,
	Vishal Mahaveer <vishalm@ti.com>, msp@baylibre.com, srk@ti.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: fix fault at system suspend if device was
 already runtime suspended
Message-ID: <ZykMvEXywBRuhZAM@google.com>
References: <20241104-am62-lpm-usb-fix-v1-1-e93df73a4f0d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104-am62-lpm-usb-fix-v1-1-e93df73a4f0d@kernel.org>

Hi Roger,

On 11/04/2024, Roger Quadros wrote:
> If the device was already runtime suspended then during system suspend
> we cannot access the device registers else it will crash.
> 
> Also we cannot access any registers after dwc3_core_exit() on some
> platforms so move the dwc3_enable_susphy() call to the top.
> 
> Cc: stable@vger.kernel.org # v5.15+
> Reported-by: William McVicker <willmcvicker@google.com>
> Closes: https://lore.kernel.org/all/ZyVfcUuPq56R2m1Y@google.com
> Fixes: 705e3ce37bcc ("usb: dwc3: core: Fix system suspend on TI AM62 platforms")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

I verified the patch works on my Pixel 6 device with runtime PM enabled. Thanks
for the fix! Feel free to add

Tested-by: Will McVicker <willmcvicker@google.com>

Thanks,
Will

> ---
>  drivers/usb/dwc3/core.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 427e5660f87c..98114c2827c0 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -2342,10 +2342,18 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  	u32 reg;
>  	int i;
>  
> -	dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
> -			    DWC3_GUSB2PHYCFG_SUSPHY) ||
> -			    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
> -			    DWC3_GUSB3PIPECTL_SUSPHY);
> +	if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
> +		dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
> +				    DWC3_GUSB2PHYCFG_SUSPHY) ||
> +				    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
> +				    DWC3_GUSB3PIPECTL_SUSPHY);
> +		/*
> +		 * TI AM62 platform requires SUSPHY to be
> +		 * enabled for system suspend to work.
> +		 */
> +		if (!dwc->susphy_state)
> +			dwc3_enable_susphy(dwc, true);
> +	}
>  
>  	switch (dwc->current_dr_role) {
>  	case DWC3_GCTL_PRTCAP_DEVICE:
> @@ -2398,15 +2406,6 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  		break;
>  	}
>  
> -	if (!PMSG_IS_AUTO(msg)) {
> -		/*
> -		 * TI AM62 platform requires SUSPHY to be
> -		 * enabled for system suspend to work.
> -		 */
> -		if (!dwc->susphy_state)
> -			dwc3_enable_susphy(dwc, true);
> -	}
> -
>  	return 0;
>  }
>  
> 
> ---
> base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
> change-id: 20241102-am62-lpm-usb-fix-347dd86135c1
> 
> Best regards,
> -- 
> Roger Quadros <rogerq@kernel.org>
> 



