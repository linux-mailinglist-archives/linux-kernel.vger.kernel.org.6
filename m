Return-Path: <linux-kernel+bounces-202159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEF08FC87A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C0A3B226B6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DCA191480;
	Wed,  5 Jun 2024 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHEzxeB+"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE819147E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581496; cv=none; b=AMZEB44gBYUHiv3mSkxuYa4fReF/InAlkkWntAQeyK23UKYcMQodyV7cvpFEOJdmwJr4px60Vd1d9LtWhHIA58LqjDOIbihrdi9fjBf5a5HmjpUfejIZHQ4kQGS90sO7kaXV2Ldl3/21tE+iBQeBy2TLIFu+einWqSQYTgQ0I4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581496; c=relaxed/simple;
	bh=hDA71fRwtUYEBuYxCMd/F/n8HA3nU7ezWt1QeUFZ3Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SL+hwST6bTveenO4LGEvCGdQ+i3bxKZmy/B0nuC3fc7ii9gxm+alMynE2qTqNcammVh9ddkdolSVG6K6CK0T6Wftgd7bINQ8qu4LJaAl7AD27h51b77RkZDNHzF7fpNoARu/NrJng+sueRaNuf6Id8jaLNBOXAVDHfL+1apkuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uHEzxeB+; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dfa59c35e44so2126788276.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717581493; x=1718186293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BaOO1MZ5brJXt2IuBE79MJkWfpJ44KhCLFOE62rdqkI=;
        b=uHEzxeB+YaaHMrf7crpk9SxBfCJ6MsmoFqEY49wnjbe+Tpp2Pv+fzIQt2mlKF5WJWg
         0SZgm35+vzZmJmRVkfHu1CDUqUzgLnyOtApr6ebAxGwZUEJGBdaVemla3Ew6+hnORTwu
         waUb80yGK0pSx4ijx2CI6cCmDoZsa2+0HHUHi/QPIrqgG/sLBlbvD76qX3myZagPl5qs
         Mz/Nii+XmPERh6lsBkjRm/chGpLz887W1XpdTjVdAx05EpE6uvy3oSC9WxAF++kX2LC1
         PB5WDH27zG+9d+O5u3rIzu/j187yJqtjJpt1AwKpyMf8SfzuLxbzxFojPUp+b/y82FJH
         Lrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717581493; x=1718186293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BaOO1MZ5brJXt2IuBE79MJkWfpJ44KhCLFOE62rdqkI=;
        b=i98wC9yK3NiO+90DTGWNhbbcxLH4HIFgB3e5lR0vTV66I60hdyMgI6zoxdYP5+LnU0
         UX05v5i+BlNLgtSFEr5svu4xmm9D8DDGxJUZFhsWIsbZLWRua1fpeKkaiJXKQBzGPsYz
         LofstnUNQM/m0kUlydUX44vs+7an7AwmS/XWZBjUkZnl4U7FDfuGBjR2pTwsDUbOtm4s
         GxjxtcoDA5unvcL/llUDVsXvcotxHHPZ9uFadJdd+Z9Swc/6zj1EnppspLwUQSbRxLZd
         mkkdrIRmVk+kbHyX8/P6dPN8Jj1WHyfT7xTkBw3zqTC9znXWD1QB70hkPTJSSn39ZSe8
         psWg==
X-Forwarded-Encrypted: i=1; AJvYcCVSGOkcI7gYLfnc4pmX1/mvggycYNug4h0B+YOLkB6Q0E1UnKsqVWcYWCy67v+74FLmJg03Av1xGF+/MzhLu5otrBC1wBIEFL48F06A
X-Gm-Message-State: AOJu0Yz9FizE1ioWh4TNA9yiS5nSzyXLfJCBGnGj1Q6x4QTuSILay3/1
	pi0t5Yct7vv7ksUvMLyAluaykrlH9ypI9xrtngElOPvgU5FjUMfdUXR7t8Ycb6X3MrJZaN60edD
	UyVsllW1EUsti7+cvh6l28i5aHAb9vBDvxEnI4w==
X-Google-Smtp-Source: AGHT+IEdBB7S8dTAffaTqVKyoAg42mxePBAC5qgCxYIc7hXyLIMAXwcRWrwgP4N3N9dB3leYuKj1mXl+ldO5b05Fl/Q=
X-Received: by 2002:a25:c544:0:b0:df7:955f:9b99 with SMTP id
 3f1490d57ef6-dfacaced9aamr1925384276.47.1717581493556; Wed, 05 Jun 2024
 02:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514131833.911703-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240514131833.911703-1-peng.fan@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 5 Jun 2024 11:57:37 +0200
Message-ID: <CAPDyKFrs1YjPOEW9eVa4HK+Ct-gnBWB6nRCAvNGvmwBYqnCPZA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: set flag GENPD_FLAG_ACTIVE_WAKEUP
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 15:10, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Set flag GENPD_FLAG_ACTIVE_WAKEUP to scmi genpd, then when a device
> is set as wakeup source using device_set_wakeup_enable, the power
> domain could be kept on to make sure the device could wakeup the system.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/arm/scmi_pm_domain.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
> index 0e05a79de82d..a7784a8bb5db 100644
> --- a/drivers/pmdomain/arm/scmi_pm_domain.c
> +++ b/drivers/pmdomain/arm/scmi_pm_domain.c
> @@ -102,6 +102,7 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
>                 scmi_pd->genpd.name = scmi_pd->name;
>                 scmi_pd->genpd.power_off = scmi_pd_power_off;
>                 scmi_pd->genpd.power_on = scmi_pd_power_on;
> +               scmi_pd->genpd.flags = GENPD_FLAG_ACTIVE_WAKEUP;
>
>                 pm_genpd_init(&scmi_pd->genpd, NULL,
>                               state == SCMI_POWER_STATE_GENERIC_OFF);
> --
> 2.37.1
>

