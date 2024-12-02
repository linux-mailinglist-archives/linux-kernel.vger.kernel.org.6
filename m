Return-Path: <linux-kernel+bounces-428029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 138499E090B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28DBFB2C672
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C861D935C;
	Mon,  2 Dec 2024 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHORyuYb"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6962E3EE
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158131; cv=none; b=frgeKsiSRQ0sUb1UK8fnhVpmNcS9HwGz6R5dIbhoYjkcXQ7g+WxOWuzLt3shjeT3yinBIMAFh+a+l4nWcWMH2HgZ3Yly+wTMS1SdisvxAt/nKbLZWD0WlYHoZ7HdDG1rPbs96O2D+tmMSxNhDo6J2iS0yKpp6MOeoSh9X7CCbGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158131; c=relaxed/simple;
	bh=bpVRli4h8Lo/f2lR7WVh6p9Lbd72h+5B4J53q13cFrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWKKqDdvoV6odxo9s6zrs8Xz2GS12YesO+2WomcbpqaS92+MS17j2rkXI/ncntNZojCdnpT9QWhge2j6YlqfGfQxB1RNKcwA0Vu18SPJ8lKZE8FOxQD736O3I8g4pLX0iHgK7GKhhf7fPuOF+d+CroFACa50r87MDt1bl3BhAMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bHORyuYb; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fc1f1748a3so2801636a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 08:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733158129; x=1733762929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Klyt3BeokDN44ugCW3DvcncSUZPVR3R8tgu53HoR6yc=;
        b=bHORyuYbpd3nfHUGsiu3VwsL9SOom/aWXr3DJfCYL1i8g5/0DzFNsKb/mo8DJf0Yme
         cYNN8DbKcYZ5KiaiekeJTbspSf8hoMtQEaQrpnc/f7cghgTqKvokUcPuAmCapEuCr/gy
         wA3zXyZn/GYY5aNV8QFIrTxVa6QGCmIWYFYF3sNZbqggXQVRkXct2M7eRzjE4+GHZXkM
         Z2bKNzlceK6hyR4AV+zOobZ6zaVtcqrs2SbMTUF6tnp9ljSkKKrCEBMRsY5CecRLfKLw
         5sf+cFlmweWmhoH247AxOedsf35dhjpjtyWe/+/mkRyzQ63XjZ5RJJtGu4AqBMNXv6Ql
         CVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733158129; x=1733762929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Klyt3BeokDN44ugCW3DvcncSUZPVR3R8tgu53HoR6yc=;
        b=Vsf8pphPC6Kp0WX9pErF4Ki6IIcRwuE/gI6tOhpfiC8DufCoDOBh4IybYr36ZMQbwG
         ErtMH9pMGXjFYK7SeT/yusOD+PrIcFa/QvPwh7m8xk5uY4JyAX2dwo0LFDNTgfCAYCNA
         5yNrrJDVnBQDRknK5c1VJ3nn1p6m+5EZA/31n640EymxS7L1vmyDD73z2H7B1cM3FNKh
         HOWkiCoimNJiqS5uuTF6w794S/DRDwi/huGB+inL6dB6lCkLaFilmtCdfAJ19drxXb3F
         B4f1lnNSZlkbmdzvT/BqLtge7djfh+V2+Oqg2qt73xDKWSfkw18t5uukBnDi0gRcrg9Z
         V2iw==
X-Forwarded-Encrypted: i=1; AJvYcCXvA0B4mYPJW3onm9HjLEPFSPXtYGV0tvTLJDe1JxvCFpLR2W306c8qVHqDlFxGYKFTYhJqYfd+wrEzVZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/ObchB23J24B/imimEO/xSsMMhvZq2lvvfZ3NhW4wg1AgfD0
	cl8PWMQz82sVw388XpwJap/t+XAO0Uwa0mJQ4TCNRQ+D+Uq8bcObukDaLy20LmQsZuC423Sc3oH
	n
X-Gm-Gg: ASbGncsiF17jRHr5+aXnazgyIs7HfwUKA1MIjyJUgnvnk1gOEFbAAKiiwdPb0GT/YfE
	LxKWoI6U6RK0huT4RHcxXVH9LBLnfVklzlUGVQ/0MoWLaOhmbX0zYC1xCtlohxgpGkxnClJ/Imb
	rD5xix6fg+naj2ICvpTrzkR2vphdPrVLBNuboRkSg/P8M497HYsnknUQws5hKvaabYflAlu6nAz
	3AFx1f4EVIYRcAS/IJ7KQsq/1/CeT5bv2wes2G6YRtQP1RbBjFYww==
X-Google-Smtp-Source: AGHT+IH0BcQMvBTUCDM/IzMifwY/P/r9GOVp7WKhH22kmbfItDPKR+9O2x4fGXRN0aWb5E49FibgUA==
X-Received: by 2002:a05:6a20:158a:b0:1cf:27bf:8e03 with SMTP id adf61e73a8af0-1e0e0b10997mr34022178637.26.1733158129360;
        Mon, 02 Dec 2024 08:48:49 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:813b:da83:de65:fc6a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541849509sm8706120b3a.197.2024.12.02.08.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 08:48:48 -0800 (PST)
Date: Mon, 2 Dec 2024 09:48:46 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] remoteproc: core: Fix ida_free call while not allocated
Message-ID: <Z03k7v6JuA2bCj9x@p14s>
References: <20241122175127.2188037-1-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122175127.2188037-1-arnaud.pouliquen@foss.st.com>

On Fri, Nov 22, 2024 at 06:51:27PM +0100, Arnaud Pouliquen wrote:
> In the rproc_alloc() function, on error, put_device(&rproc->dev) is
> called, leading to the call of the rproc_type_release() function.
> An error can occurs before ida_alloc is called.
> 
> In such case in rproc_type_release(), the condition (rproc->index >= 0) is
> true as rproc->index has been  initialized to 0.
> ida_free() is called reporting a warning:
> [    4.181906] WARNING: CPU: 1 PID: 24 at lib/idr.c:525 ida_free+0x100/0x164
> [    4.186378] stm32-display-dsi 5a000000.dsi: Fixed dependency cycle(s) with /soc/dsi@5a000000/panel@0
> [    4.188854] ida_free called for id=0 which is not allocated.
> [    4.198256] mipi-dsi 5a000000.dsi.0: Fixed dependency cycle(s) with /soc/dsi@5a000000
> [    4.203556] Modules linked in: panel_orisetech_otm8009a dw_mipi_dsi_stm(+) gpu_sched dw_mipi_dsi stm32_rproc stm32_crc32 stm32_ipcc(+) optee(+)
> [    4.224307] CPU: 1 UID: 0 PID: 24 Comm: kworker/u10:0 Not tainted 6.12.0 #442
> [    4.231481] Hardware name: STM32 (Device Tree Support)
> [    4.236627] Workqueue: events_unbound deferred_probe_work_func
> [    4.242504] Call trace:
> [    4.242522]  unwind_backtrace from show_stack+0x10/0x14
> [    4.250218]  show_stack from dump_stack_lvl+0x50/0x64
> [    4.255274]  dump_stack_lvl from __warn+0x80/0x12c
> [    4.260134]  __warn from warn_slowpath_fmt+0x114/0x188
> [    4.265199]  warn_slowpath_fmt from ida_free+0x100/0x164
> [    4.270565]  ida_free from rproc_type_release+0x38/0x60
> [    4.275832]  rproc_type_release from device_release+0x30/0xa0
> [    4.281601]  device_release from kobject_put+0xc4/0x294
> [    4.286762]  kobject_put from rproc_alloc.part.0+0x208/0x28c
> [    4.292430]  rproc_alloc.part.0 from devm_rproc_alloc+0x80/0xc4
> [    4.298393]  devm_rproc_alloc from stm32_rproc_probe+0xd0/0x844 [stm32_rproc]
> [    4.305575]  stm32_rproc_probe [stm32_rproc] from platform_probe+0x5c/0xbc
> 
> 
> Calling ida_alloc earlier in rproc_alloc ensures that the rproc->index is
> properly set.
> 
> Fixes: 08333b911f01 ("remoteproc: Directly use ida_alloc()/free()")
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> Note for backporting to previous kernel versions: The SHA 08333b911f01
> seems to correspond to the last commit that updated IDA allocation.
> The issue existed before, but the fix could not be applied without some
> rework.
> ---
>  drivers/remoteproc/remoteproc_core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index f276956f2c5c..ef6febe35633 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2486,6 +2486,13 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  	rproc->dev.driver_data = rproc;
>  	idr_init(&rproc->notifyids);
>  
> +	/* Assign a unique device index and name */
> +	rproc->index = ida_alloc(&rproc_dev_index, GFP_KERNEL);
> +	if (rproc->index < 0) {
> +		dev_err(dev, "ida_alloc failed: %d\n", rproc->index);
> +		goto put_device;
> +	}
> +
>  	rproc->name = kstrdup_const(name, GFP_KERNEL);
>  	if (!rproc->name)
>  		goto put_device;
> @@ -2496,13 +2503,6 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  	if (rproc_alloc_ops(rproc, ops))
>  		goto put_device;
>  
> -	/* Assign a unique device index and name */
> -	rproc->index = ida_alloc(&rproc_dev_index, GFP_KERNEL);
> -	if (rproc->index < 0) {
> -		dev_err(dev, "ida_alloc failed: %d\n", rproc->index);
> -		goto put_device;
> -	}
> -

I have applied this patch.

Thanks,
Mathieu

>  	dev_set_name(&rproc->dev, "remoteproc%d", rproc->index);
>  
>  	atomic_set(&rproc->power, 0);
> 
> base-commit: adc218676eef25575469234709c2d87185ca223a
> -- 
> 2.25.1
> 

