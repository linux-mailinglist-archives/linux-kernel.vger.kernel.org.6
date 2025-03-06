Return-Path: <linux-kernel+bounces-548708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9172BA54872
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF403B058A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80BB20551E;
	Thu,  6 Mar 2025 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uFDE1ciW"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959EB202F92
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258433; cv=none; b=ksedC0vWyU1tMUQ7SvMPHUXEcGYSxa9QsImx6FpT0whHz7d5wRPAKrZo+xoixv96q0/FBHvi0ru4mywa/qMRCDMxiyxD+k+FDBciBCKZOfwx112bbK5PIzyq9dPyU65/Qv1bI+j911VQHJXlK8pNN4acVH/4VlCEtAthbeak+BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258433; c=relaxed/simple;
	bh=BjCm5PBqyHKmjMucOFRQC1jdtY0RK6Pqe0onnAO5mwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slhAOhaR4VMBc28doELNWzxnLZm7fhvzw4v3Y1KlbPGy6O03gEJ7qUNNCanlW3S0VrxPQQgg7GLR4z2i+5yfSYq8atc602I1SM4TAMTT7I9gOEt1GC4PcwrdqvPt8EjDDEfT3piDuHcHSNhj62GB+osLUSEP9GncGoK9tCeax+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uFDE1ciW; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fda22908d9so3714647b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741258430; x=1741863230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l3kxF9s0s10HtMJFdaStPVy028iaechePMj70+RdBiw=;
        b=uFDE1ciWDJlFtboEWAIvsZI2uxRdZ+8LVVpUhrImVRQ7V2BKQMMYBHLTIT7UZVxzEO
         KuZt8MnZgND/hCY2TpAM6zEo90IxWF+b30tTmwjqTguqQ4LTolRXF/r49X7xkgzrbmQn
         XMRUrs1HSbhRllXxdzHlrSWCVCGsv/KOKvMJhqUl6AEZVZ79IH31oxdKZut71+H3M/C2
         pbHMrlA281UwnWHp7KuU/swZvj0O7m0wLA3Mzz+iQziBdHc7a5wdhehFRn0g+Kwqs3Mp
         CJOAkkvb/g/tf0vFrx4sKQZ/pZOUaChpHVGESuah/8zGljTUZCWy52E45lB4OciL2bJU
         Pi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258430; x=1741863230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3kxF9s0s10HtMJFdaStPVy028iaechePMj70+RdBiw=;
        b=SPfLfXiAgY6AtEJoCp5jmxxrcK+eBsHHZbS2dvc1SX56TQukFRtEw+KLDqluhU0sB9
         fzNwoSzs7KqlY0FoY3QTakmzBCnlMLUaawHNS+xk/kEgpXXpT40l+7i/RbswFVmSHoeD
         zoELIW+SmdxybbjFA8SPQGWVC69PzeTe3oYeC3d1Wn6cVRxtBDTqT0g7RNRzOAatEeu7
         8bPzJBarJjhoFcCs5Iv3H/ZZ+MVvx2f5R4Gpi2jZ+Zxr2BtrDWer6argGdhOUKAasrpR
         9ImnGU+9fANQ2GNsaIzXSqlt3oU/tj0XA3N1nxFt+gaM+iR+f5sgJihbvLuQDtkgyKAf
         o39g==
X-Forwarded-Encrypted: i=1; AJvYcCX9VEP+TwbbJH9ai5eeX7YPWe9dLzbdn1vAzz0qp2NGPlFK2dAPVdhBoSmd412L9EZOwl634XWfGJF3i8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxthnsz5SMlypxQTTwX2Et6MzbySOIkNM3DX2V+Z7bBPDy5e+sT
	pqzOB+oJ4qTkKvaBbhOVSLDjs9SqiQDutY3ALMhqhDR0SgI9ltVBQ/2auOXmzFxKpKj+Sirz/kh
	WZK1wFDFHX4DlpxtpkcRN0/Pps4AsYYbdMwGo0Q==
X-Gm-Gg: ASbGncuNQAd46X/hOA6Iyps8Wl0loQhOo3jZnGN6rJjdNfqssTlMDXt3vTFi6sjTpNW
	737e8F7QAMGhJugseHjBY6i7eXCSLGCFJOHZgUgqRa83iSKwOej9ANhn1LIjDOG65Pch24etTq9
	dc5So1DBoXt8JDQdZ9FtcVlnruOdM=
X-Google-Smtp-Source: AGHT+IHveALh7pfAJxb1zQDrWysmjfRsRboRORBFdyusSPBVnlo9Xnd8mhzTm+ZPYxFyYXm4hgY3Nu9iytramRNs4y8=
X-Received: by 2002:a05:690c:64c1:b0:6fd:44a5:5b68 with SMTP id
 00721157ae682-6fda306fffbmr91783397b3.35.1741258430563; Thu, 06 Mar 2025
 02:53:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306061805.2318154-1-ping.bai@nxp.com>
In-Reply-To: <20250306061805.2318154-1-ping.bai@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 6 Mar 2025 11:53:14 +0100
X-Gm-Features: AQ5f1JoVI52ootMQgeP7Rja3_fKhyfkFzcUyyz4qn2NojBs4a97d8HfR3zSlUrg
Message-ID: <CAPDyKForY4VNZtqietDPt2FQM3p4OsaoE_oJb0PPLUAh98WsHQ@mail.gmail.com>
Subject: Re: [PATCH v3] cpuidle: psci: Init cpuidle only for present CPUs
To: Jacky Bai <ping.bai@nxp.com>
Cc: lpieralisi@kernel.org, sudeep.holla@arm.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, james.morse@arm.com, d-gole@ti.com, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, khilman@baylibre.com, 
	quic_tingweiz@quicinc.com, quic_yuanjiey@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 07:17, Jacky Bai <ping.bai@nxp.com> wrote:
>
> for_each_possible_cpu() is currently used to initialize cpuidle
> in the PSCI cpuidle driver.
>
> However, in cpu_dev_register_generic(), for_each_present_cpu()
> is used to register CPU devices which means the CPU devices are
> only registered for present CPUs and not all possible CPUs.
>
> With nosmp or maxcpus=0, only the boot CPU is present, leading
> to the failure:
>
>   |  Failed to register cpuidle device for cpu1
>
> Change for_each_possible_cpu() to for_each_present_cpu() in the
> PSCI cpuidle driver to ensure it only registers cpuidle devices
> for CPUs that are actually present.
>
> Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in GENERIC_CPU_DEVICES")
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Tested-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>

Is this problem specific to cpuidle-psci?

Others are using for_each_possible_cpu() when registering their cpuidle drivers.

Kind regards
Uffe

> ---
>  - v2 changes:
>   - Improve the changelog as suggested by Sudeep
> ---
>  drivers/cpuidle/cpuidle-psci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 2562dc001fc1..00117e9b33e8 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -410,7 +410,7 @@ static int psci_cpuidle_probe(struct platform_device *pdev)
>         struct cpuidle_driver *drv;
>         struct cpuidle_device *dev;
>
> -       for_each_possible_cpu(cpu) {
> +       for_each_present_cpu(cpu) {
>                 ret = psci_idle_init_cpu(&pdev->dev, cpu);
>                 if (ret)
>                         goto out_fail;
> --
> 2.34.1
>

