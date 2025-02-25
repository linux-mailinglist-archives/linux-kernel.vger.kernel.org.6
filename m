Return-Path: <linux-kernel+bounces-530373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 789A9A4329E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63ECF189CA28
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0242149E13;
	Tue, 25 Feb 2025 01:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B0fJUYY9"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764F57DA73
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740448113; cv=none; b=bv329S8I5xUQfjscg4+WT2k4SiUPzamaqKlwyRQFh/ZX5WMDzXVnSShfbk5MkMZRwa54nf8q7HB33ym8pNWWrtayhoxsq3pMbnW2paQbUIiY8Ag/bJoJVRnUBTRmnIUAuAz0CHLsUBxzB2Gl6tzh3LumIplvLRPSSVYvRuMTuGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740448113; c=relaxed/simple;
	bh=c4anI0ppkEyU8s1QPXkM2U43MHW3YTHuNeOkaKXZjpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4dXVIeN+b9z97YbMWInmaKhKM2Unc5/zIPST0wTILNxiPswwEsD9lbqqYK8RI6k8f2HfZimVZ19Kh8P5watF8Wq5YCy9mthVlF382VNi8TCMiKMx+SmPUGteMP1RXSBOJsMUaBzPgo1KZisCgnbCFrsQyo24DXuYWI07LyuTIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B0fJUYY9; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30930b0b420so44277631fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740448109; x=1741052909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiZFDEoMMUeQmVYehoWgRQ2XvY7Zgjn8HI/dvzzcXBQ=;
        b=B0fJUYY9eoJRwelDmfyToZt/Ac4MU3CZ6FleYQpbddKO586XPEpMVZFyhIRLLD5k/w
         te1/PbZq5SN5xy/KPnxLSd7qB5SzYTs0rPapWSPIDjPtMEJUr603FdaJKbL5+/voZ9IO
         CtUKR2/vbbOv1uSlNCFQ243ydrhat1UbSI4aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740448109; x=1741052909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiZFDEoMMUeQmVYehoWgRQ2XvY7Zgjn8HI/dvzzcXBQ=;
        b=CfdXOsd0nQWFXB4DFbzvXZpEARjHom79mDmHsvcsM982cHfl7vBsW6gbHmypRw4Xd+
         LTrnU7bd+SPDDr+29aRitVxZDglB/yzN+GBtssH16Gt75LSyPJMftjOjF983szrBsRM4
         XYfM09Hf/xvWOcxzvrLGcRd0vAB+zgc8/zHiPZ8xPfjPrO7vHjh2WHHze+X+l0O/eCsP
         Frs5ltaKfVX2+/7FiCFIwBn+wqSRhd1VFmmh/VfzzYB5OzTzgMpUXqwKynLkEbJ5ySDr
         F+cS6R7JipLS70ByMoGMtsbxvq28swdwAgVeKv2GP+sgZ9/ffGjaxV1RHWxIejNXWKKO
         Dkxw==
X-Forwarded-Encrypted: i=1; AJvYcCUNY3Wt/emGyiiBQtzG61tF/T+S0zxhTRpJI7WtWJJS7jQVV7FVEbfB9LNJV1tpWocBG8PfZEdF/kipsUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPgPTCBdgJ5m7CUTdx7mBm68Ab9akoBk+HppokVE9q7MdKMnhO
	EGSHBfwh64Dssq/1w52ZiAwUasIamrDzucaGkkHO/iLBkEJyFmfdC5jxfptDUg9nACE2RLUyl/c
	pPFFW
X-Gm-Gg: ASbGncu4f0x6wWUkcPRE5lFsABrDFkxKehh4Qx0p/G9ikWYzy+ptBZQOp31Oc5E2qsV
	RRhUJvyByNaUAqult8ZtEAp9p2WwXGQEWTf4lQQGAS0VQPCuorStZisOBcEIgzGTgrbc39fVc5+
	Ev5V+OE9qHPeXn9gbyeVtCnqnDYUn5SG68+5TX8DXqoBoATRABgfRxuNhqDUkG873zsbMfHqWes
	We//asMPtuzEEtyWAxTcnXzQzPXiLP1XTfQ3qkn0EH3418vCfsUzWHNKk2KT3MdFnax0i++ik4v
	HstGuhlxZQ5LWgENlvbuw6KkVE1KPlJKPE4sl/gv+68QT7YgVPYkyfnaS05VNsF+MPqJvg==
X-Google-Smtp-Source: AGHT+IHTgIhmhRcEGu50KYnJa6g92HhRnJsw4fNQel4BIC1BNInmQ91lLSSbofiNXTyujYUdd98f5g==
X-Received: by 2002:a2e:9909:0:b0:30a:45af:c18d with SMTP id 38308e7fff4ca-30a599899eemr52430311fa.25.1740448109230;
        Mon, 24 Feb 2025 17:48:29 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a81ae8163sm827771fa.102.2025.02.24.17.48.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 17:48:29 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30930b0b420so44277431fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:48:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrxla7hsuAwh7Qu/gktggg6p81+9SpYHAcFR4VJpDsOlKvj5JcYguGZjk9bt2a8m6zoX2NlzOreqFg/l4=@vger.kernel.org
X-Received: by 2002:a05:6512:1591:b0:545:102f:8788 with SMTP id
 2adb3069b0e04-54838ee917cmr5921345e87.19.1740447651791; Mon, 24 Feb 2025
 17:40:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224081325.96724-1-damon.ding@rock-chips.com> <20250224081325.96724-4-damon.ding@rock-chips.com>
In-Reply-To: <20250224081325.96724-4-damon.ding@rock-chips.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Feb 2025 17:40:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UJb=-TsXS3bgv-rgiON5-4icGgh81gYEJuA=ieDaBT+Q@mail.gmail.com>
X-Gm-Features: AWEUYZnEpuNKLIwyvEJM2DgjUifuLCeYu_2BU0vlX35x8eRwRX1_fUCYojEGI6Y
Message-ID: <CAD=FV=UJb=-TsXS3bgv-rgiON5-4icGgh81gYEJuA=ieDaBT+Q@mail.gmail.com>
Subject: Re: [PATCH v7 03/15] drm/bridge: analogix_dp: Add irq flag
 IRQF_NO_AUTOEN instead of calling disable_irq()
To: Damon Ding <damon.ding@rock-chips.com>
Cc: heiko@sntech.de, andy.yan@rock-chips.com, hjc@rock-chips.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	dmitry.baryshkov@linaro.org, sebastian.reichel@collabora.com, 
	cristian.ciocaltea@collabora.com, boris.brezillon@collabora.com, 
	l.stach@pengutronix.de, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 24, 2025 at 12:14=E2=80=AFAM Damon Ding <damon.ding@rock-chips.=
com> wrote:
>
> The IRQF_NO_AUTOEN can be used for the drivers that don't want
> interrupts to be enabled automatically via devm_request_threaded_irq().
> Using this flag can provide be more robust compared to the way of
> calling disable_irq() after devm_request_threaded_irq() without the
> IRQF_NO_AUTOEN flag.
>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Suggested-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

