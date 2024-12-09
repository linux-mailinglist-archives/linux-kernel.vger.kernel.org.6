Return-Path: <linux-kernel+bounces-437888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9568D9E9A27
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777BA162DA2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5961C5CAC;
	Mon,  9 Dec 2024 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZuLuFD/"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6787F1BEF9B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757311; cv=none; b=bDipXxWWNVpwg7mW+JZAJPu1y90fQqTafLdJPVlRf1hC5l128RAHcGHoMcdijKj3/Rrs4QU7HvJZuRkwPQXLXEnF2oZOeHkuEoD311oZoWGuD5YwZHP9kaBcT5I8pDsMjxLUJc1aSK4a6b7H706mKHGKyZyQltJnhoEu3zymWnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757311; c=relaxed/simple;
	bh=giYJMMFxAcT7bJn/ZT2Ij8F4WbQ9ZNFzbR5iQsND47w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaNPGhbaDm+Rv04UJtuXcoauPQC6REvjVzD7nRARuc/HCnPDTuVvsc/+PGhaMKK2c5R7GSPmxPL9917JMKPP0bQCGoge1mvYW27VoApzy6LiC37dJPhEfRhbTQmJ+imd6gBETo95NDZUHWo9t0rMBBpBKxZN5aKv8kK9fkteFXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eZuLuFD/; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ef7c9e9592so41480777b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 07:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733757308; x=1734362108; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=79FjHzmk+8gNH6FLPZtW1LA4qvljbcXHoaAkCRGOlJY=;
        b=eZuLuFD/G3Th92cexRMTs+DDBlIvMrvhQLc3Hbpfyl27Uo8QcuZ1Cys1nRN+mJWGk5
         VaClr13OzMLyTyfb4/WNa+Tkx9tqnoEEfnhUBh3hW1dZ1FepbGWTLPwJsK/0Wle5VmqH
         xiaXl05aUm4hTuHuq/Wx8D2IxKqInLkg+0YTDJQK30FZcC+3Tr5cGrP/k13FA73ow2XU
         K4F8j6Snq0t9Nkx6g4i2f4ARiXFEFuuN+vjk/XOjlt/pk9zQWhrOlaj0GmO9BgRJ3+Cs
         rG1tVWKOjgGiXdb6f7PJAEoljc00NLAPJIcBcCrWsTWH3dHix6rV+8eeOaGiqG7ukOW2
         5iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733757308; x=1734362108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79FjHzmk+8gNH6FLPZtW1LA4qvljbcXHoaAkCRGOlJY=;
        b=w2sI7t3pOYyryM3Ol8VgG1c03ADky0+FIwQK8rA3YHCejVoQFPJ18n8XTChkghcKgR
         xxSaNcynNtkVxifAiRm35DTM9QQPnCnqgw+GrvQjeDBpz5N3ciUOfbWOgC1CdmHdkBty
         RGJVJJw27FrwhOENgMaTOAClidNZcY0bb8/s1defIH+a1N466AnOsgfF3EQbnd7UZGMl
         GkEnPL/oPXFH9/uMMyuQ5DUZIRnb5wm8wy0aCK9uBNCMdJIzCE8wSE5q1qEYYzZZgGT8
         t9aXAlc496g6Wkv/cfFFhpY/hWnl8b9Dznz63pm/pmJtP7I4VYC77yWWLNnRNSYowyQh
         lirA==
X-Forwarded-Encrypted: i=1; AJvYcCXChEtWaujRV3N5E2in9+GJtfnie0urjQ6muHHG1J4bYC4tpJAqBrp2mNpb8G2kakMhsM7g//IOldjrCgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL9GuNlOymDeVu5ItG8anFqZFIF5r6HKsqSMkEpyIqBh1p/Zfz
	gggRG1Tv11C5ZaJkX/qfKcehkvQmxVsB0xBmYiUie+CepGseuVinRTbMqGkYdqb5KmvRX7GewI3
	vGytLLfoJAc+NnyFqXszmNEcBiH/EYKux0SLjZg==
X-Gm-Gg: ASbGnctg/c8QydiBT252A8oZ3oDU4ZK7u5nTWNkH94xhFnNsNT2SGceJm0ga9I9qnch
	st8puDI8nSTlALz1kBF01SNPuUNzng7OlAjuoOVqbkRtI1Pxw4M1oQYmuufc1/f8=
X-Google-Smtp-Source: AGHT+IFy3RwQr2sUIlpt53uiHIi1MMG4K8VGA3uVdd9gLgjmNQyY8wIL1JDnIoJTEc/VtRo9eJdlgbr7XTcFzsgGGSM=
X-Received: by 2002:a05:690c:6103:b0:6e3:37a7:8a98 with SMTP id
 00721157ae682-6f022e840d5mr10212517b3.14.1733757308349; Mon, 09 Dec 2024
 07:15:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-qcom-scm-missing-barriers-and-all-sort-of-srap-v2-0-9061013c8d92@linaro.org>
 <20241209-qcom-scm-missing-barriers-and-all-sort-of-srap-v2-5-9061013c8d92@linaro.org>
In-Reply-To: <20241209-qcom-scm-missing-barriers-and-all-sort-of-srap-v2-5-9061013c8d92@linaro.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 9 Dec 2024 16:14:57 +0100
Message-ID: <CACMJSeuge3vd7UbhQq6XfFUGbCwUbEa6wOAB_u8=Ovfs7O0BJw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] firmware: qcom: scm: smc: Handle missing SCM device
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Mukesh Ojha <quic_mojha@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Kuldeep Singh <quic_kuldsing@quicinc.com>, 
	Elliot Berman <quic_eberman@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Avaneesh Kumar Dwivedi <quic_akdwived@quicinc.com>, Andy Gross <andy.gross@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Dec 2024 at 15:28, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Commit ca61d6836e6f ("firmware: qcom: scm: fix a NULL-pointer
> dereference") makes it explicit that qcom_scm_get_tzmem_pool() can
> return NULL, therefore its users should handle this.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_scm-smc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
> index 2b4c2826f57251f25a1bc37c3b467dde28e1268b..3f10b23ec941b558e1d91761011776bb5c9d11b5 100644
> --- a/drivers/firmware/qcom/qcom_scm-smc.c
> +++ b/drivers/firmware/qcom/qcom_scm-smc.c
> @@ -173,6 +173,9 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
>                 smc.args[i + SCM_SMC_FIRST_REG_IDX] = desc->args[i];
>
>         if (unlikely(arglen > SCM_SMC_N_REG_ARGS)) {
> +               if (!mempool)
> +                       return -EINVAL;
> +
>                 args_virt = qcom_tzmem_alloc(mempool,
>                                              SCM_SMC_N_EXT_ARGS * sizeof(u64),
>                                              flag);
>
> --
> 2.43.0
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

