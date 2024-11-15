Return-Path: <linux-kernel+bounces-410688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EAB9CDFCA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3DB28393D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00351C07FC;
	Fri, 15 Nov 2024 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZRupQ3g6"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC81BCA0E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731676995; cv=none; b=FkVkzXRB2GHIpx9rq8H9letE0pGTMKcMmggLsP2SDt0XPneWhf2FLQaLm3n8yxmqSJ/0LWGVjLMdx2YY0waAO2YYgfYDgiiF0t/0CsaOAZyfjDTTq6HY792t5yCac22gYtHGl62m8bT52CF5ZwCgagVK5732wqFyZYDrcRx7DsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731676995; c=relaxed/simple;
	bh=0Q/CxoVEhocZ6ezfGf1u7ZNO4bfBmEBX2SgfqPCZuS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFpIBbvW1sEMVC2M38Ny/Wa7dua8nqL9yVVI05Bkg7h9d1bgSYq/MbCUViEI13VgV29XiZWbMC+QN3LmF3NhvsLoVvTW9oJsfA9U8mu2LLAE8l9Ih8oHSNkEdShdDVZMf4yVztwEn/wuRH6bKj9dQc6OqRm1oVKqqlORJx4B9eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZRupQ3g6; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e38193093a7so1437894276.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 05:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731676992; x=1732281792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mFcf9RJcjAVItM51bFy5niFyrBA5g5XDe+IUsN6u8qg=;
        b=ZRupQ3g6D2eV4OSzfODLyDHMmITCiAymIh00vfDOJC9DjLtpmpCM7B8BrPfYGE+ksj
         0JS97fajwNmMLgouauNi+ltdAUvzEGXamLATQMm7xy7aEtNawL4rTMkR/1k/cHcKClJ8
         JsHDIj7DjrXhX+UK6o9+iSsoSYLfeo0hLbwJBxtdLyYeRtYZ+/4nLlB/aAOW6ldr3a/r
         qC314maFW8wJoCf2jhN+8fOP8FM8Q6lUkqyW1bqeeZxlPn22y921k8Y5h7UhVXxpPGK/
         hTrlZJJOTSsO2/ucnaZOA/pSNo7ZbrLAsa1RvvtzNoFNjLOXh69VWdNd4l6MgoXAThMd
         cYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731676992; x=1732281792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFcf9RJcjAVItM51bFy5niFyrBA5g5XDe+IUsN6u8qg=;
        b=m7qVNkVFibvoix0i03aa8t/Wv941p463IBPrZjhODQgfxtR0kgtSkjw1t+hCZXXqPS
         +B3BXMHEP/mF8JFAG2HavAdPRCQHT0HvE5OF7FjHjX/pos8vO41Icn+2aC8uyB9tCgGB
         xSD4+qPB8rXIjjbpFE9vQ6FvYkPQSWvl0MA7AdvDkPAp9nz6gZfnhHrAG/ZVyp4bV/L2
         UBlcPHvJApZ8/U1hWoXDxuncquE2hK/HZesRPrWaP9LGjPLfD1NNYslWpDNEwAqzC28E
         ETCf42JY36DR/gRI6vaicl4Ke59EXBufZgtlL/MBqo8vpJPPAuRvpbnU1ctMIUcG53K1
         QkLg==
X-Forwarded-Encrypted: i=1; AJvYcCUDcwAU3MFyqhGTZKjEKCH1Ia7jS8POi92N2k90GQHL7E21y+QuQ/r8By/m8sbtpDaAmoy6/QHT34maU7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoeLV8pFzia5y42n/m9WqJ0j1O/DMI2IsXTZpCFB5gmdTcV3b6
	HP3ugSuzCD6i9DseD6XiXTX9PKo6xpQC1jP2mup9AJ5VB8ASuljXkwCpirIHlXMndHA2WNYjZqW
	8/m1WuNQpMOsF/5rsibjvFu7E8yQ1j1qpANrbkA==
X-Google-Smtp-Source: AGHT+IHCgG2uruTWqMGPEa/kjxndenrmy3iqrUer02q4NYfZY7sfxcicR/uF3A5MhOvjIYFRPv2PSm5gVYMIbtpw4V8=
X-Received: by 2002:a05:6902:e06:b0:e2e:49f0:fc26 with SMTP id
 3f1490d57ef6-e38263e1858mr2271366276.49.1731676991883; Fri, 15 Nov 2024
 05:23:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104060722.10642-1-quic_sartgarg@quicinc.com>
 <konkbi4hvd7qc4rhokwrymzqntroy7gijk3ndwv5rluswdrykp@xsafrtrjzmuq> <10c90fee-ce7f-4034-9028-4252f19cb67f@quicinc.com>
In-Reply-To: <10c90fee-ce7f-4034-9028-4252f19cb67f@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 15 Nov 2024 15:23:02 +0200
Message-ID: <CAA8EJpoLLDXFQk-ViuaioKrECzMV0aUrcOj4v+Ufs4oHY53mrw@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-msm: Enable MMC_CAP_AGGRESSIVE_PM for
 qualcomm controllers
To: Sarthak Garg <quic_sartgarg@quicinc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_cang@quicinc.com, quic_nguyenb@quicinc.com, 
	quic_rampraka@quicinc.com, quic_pragalla@quicinc.com, 
	quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com, 
	quic_narepall@quicinc.com, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 12:23, Sarthak Garg <quic_sartgarg@quicinc.com> wrote:
>
>
>
> On 11/4/2024 4:19 PM, Dmitry Baryshkov wrote:
> > On Mon, Nov 04, 2024 at 11:37:22AM +0530, Sarthak Garg wrote:
> >> Enable MMC_CAP_AGGRESSIVE_PM for qualcomm controllers.
> >> This enables runtime PM for eMMC/SD card.
> >
> > Could you please mention, which platforms were tested with this patch?
> > Note, upstream kernel supports a lot of platforms, including MSM8974, I
> > think the oldest one, which uses SDHCI.
> >
>
> This was tested with qdu1000 platform.

Are you sure that it won't break other platforms?

>
> >>
> >> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> >> ---
> >>   drivers/mmc/host/sdhci-msm.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> >> index e00208535bd1..6657f7db1b8e 100644
> >> --- a/drivers/mmc/host/sdhci-msm.c
> >> +++ b/drivers/mmc/host/sdhci-msm.c
> >> @@ -2626,6 +2626,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
> >>              goto clk_disable;
> >>      }
> >>
> >> +    msm_host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
> >>      msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
> >>
> >>      /* Set the timeout value to max possible */
> >> --
> >> 2.17.1
> >>
> >



-- 
With best wishes
Dmitry

