Return-Path: <linux-kernel+bounces-415845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2379D3D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79A01F2227D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355AB1BDA87;
	Wed, 20 Nov 2024 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="U+ubVhvL"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8441CB328
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111659; cv=none; b=lwdtzLDCZfn23zGu17IfLfvDnRzsLjQrkZXO8rwrk+W0NtrQNqqUCIttJe8IVLONy/xZcuYDv1V2XKlPn+yzba/8E+wS3+ovjpQeqK3R01+Nuna976CHj6uz5E22v1R0TL5N2nW+q+eT+wTFTE8wPp+ZSOZlwqfKruCCLEMEZg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111659; c=relaxed/simple;
	bh=yPWH5BbYvZQzKT4XZKsH3Lkntk3W+CBpWBfedkE+RYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzQeXuY3//BwslBs5Ps5bc9co/yJJbs5dBKZxNOh9LcOKcrJxPnmxlpAj2oiFkP6j4BPltSiIo7RPi3EckLPAgvEIDOvlo+4Sfh1d7UxD2nCPS7NUeFh5MAi03TEzkVqOw61uFVVGJqR7SsFTDrDMghpaSizygsvxeBKrebwY3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=U+ubVhvL; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e59dadebso2888560e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1732111656; x=1732716456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KI/xaFgppdO+gE0cZzeDEPSWwSf0mLTY9cnAOBa5yWM=;
        b=U+ubVhvLFNpjwFhVkllfUtpQ8VPJ4IZScnyad8RDk+bMP7ANhoPpvxKJKKqfLMjbr3
         yIINBux+3fSUuxJWxKB6yegYAbYiaKKtX21JlykSg2r80lwns1yzOAIiWB0cU8uEl538
         s4EHBEl3qwww8Fc1PIYYW8M6c7RuLPsG4JwaU5H8gTnUHE+mOxK7Cgh1ibsx/8bfhAvi
         OXnRHrxUSZOfsAzV65Pn+Ryh0LG4nOuNHneIejsKeZgZBqvAI8Xd0OMoS59Hc+QwruB7
         hAv7q9k7ty1w87oPNwkcj8I/3EwNP2VvPqna/Nb6mmd1Tzuvzv/vRhvcfLEd5m4/BqVe
         36Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732111656; x=1732716456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KI/xaFgppdO+gE0cZzeDEPSWwSf0mLTY9cnAOBa5yWM=;
        b=AdIkEVPaXDHZdMlIHq3IBwXRiTWFEv1eLSBGUz3eNiP5JMBvJYJDQ/edIinpvmMYQV
         5vr3PgBcM/+oLLBW1+DARIUGldDad6PrlPp9Ozx1P4Hvz0dkjHx3gHw7rHXsH9rBtl9O
         4FXkqOd+z9OUpZLYcGlST2tfBOrRKgkKhWiyroDD09cYVU4KAtLV5201hOlPVzroo7N2
         oNFacYbUflPch31rB8qdMcScEOHWYNkK3OZw5XTa7wcpzhcFEuzIX2lwvN9fG5g+xw6r
         CTQKMTFwPDRzKK3I7a5ZeM8aFl+56ymwYyZTvmxAgp0Y/gOLViDwGaYsJkF7NAULxrzP
         59ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXvw8gXC/tjcYrP+mWNycAKIW6GJO580stqqPRG3MLZiicNvjr3ouWHFiCApE746JjRM0BQk//taTKfoPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuyioTOYHEyjQ1bBDP8E/UwS9HIbk/JwhenT/DQLAhDuCMbrSg
	9Cl6zsRkGkJEIkpwh7anGiFLz+Aiv84BEmzUfU4f9j5BKCm+Tw9VyJUMcqMykcVi4gbxo26fSAD
	IGZE1LfZH1ukFo1FcsSQ2xDKGl0b19lZfCTIttQ==
X-Gm-Gg: ASbGncuW7W6cq8XzkO1B0DqHBoeCvYv6VVNpuNW8tZgB+OL0BCFVMuY2334TwUusxDY
	4wdHxn7EmM30lwDtoXKAVJ5mGEGh4t1xdPLNV2o/KP6TI+f4y5rYh9mY16kXx1j0=
X-Google-Smtp-Source: AGHT+IFKgxNSKwbtSzBNKNLLTIQE4JJpKE33C1dK0JAtnRSxVqVfqAZCSb1tyvUX+Ky6nt/MRup21tUZ9IbFHz1NYGg=
X-Received: by 2002:a05:6512:3292:b0:539:8f4d:a7dc with SMTP id
 2adb3069b0e04-53dc1374d55mr1253738e87.48.1732111655972; Wed, 20 Nov 2024
 06:07:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org>
 <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-3-7056127007a7@linaro.org>
In-Reply-To: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-3-7056127007a7@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 20 Nov 2024 15:07:24 +0100
Message-ID: <CAMRc=Me=Eu6+SpdguKurWgQDrpuo4qTCwWO6GfzS=YuA9vUzOw@mail.gmail.com>
Subject: Re: [PATCH 3/6] firmware: qcom: scm: Handle various probe ordering
 for qcom_scm_assign_mem()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Mukesh Ojha <quic_mojha@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kuldeep Singh <quic_kuldsing@quicinc.com>, 
	Elliot Berman <quic_eberman@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Avaneesh Kumar Dwivedi <quic_akdwived@quicinc.com>, Andy Gross <andy.gross@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 7:37=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The SCM driver can defer or fail probe, or just load a bit later so
> callers of qcom_scm_assign_mem() should defer if the device is not ready.
>
> This fixes theoretical NULL pointer exception, triggered via introducing
> probe deferral in SCM driver with call trace:
>
>   qcom_tzmem_alloc+0x70/0x1ac (P)
>   qcom_tzmem_alloc+0x64/0x1ac (L)
>   qcom_scm_assign_mem+0x78/0x194
>   qcom_rmtfs_mem_probe+0x2d4/0x38c
>   platform_probe+0x68/0xc8
>
> Fixes: d82bd359972a ("firmware: scm: Add new SCM call API for switching m=
emory ownership")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> I am not sure about commit introducing it (Fixes tag) thus not Cc-ing
> stable.
> ---
>  drivers/firmware/qcom/qcom_scm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qco=
m_scm.c
> index 5d91b8e22844608f35432f1ba9c08d477d4ff762..93212c8f20ad65ecc44804b00=
f4b93e3eaaf8d95 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1075,6 +1075,9 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_=
t mem_sz,
>         int ret, i, b;
>         u64 srcvm_bits =3D *srcvm;
>
> +       if (!qcom_scm_is_available())
> +               return -EPROBE_DEFER;
> +

Should we be returning -EPROBE_DEFER from functions that are not
necessarily limited to being used in probe()? For instance ath10k uses
it in a workqueue job. I think this is why this driver is probed in
subsys_initcall() rather than module_initcall().

Bart

>         src_sz =3D hweight64(srcvm_bits) * sizeof(*src);
>         mem_to_map_sz =3D sizeof(*mem_to_map);
>         dest_sz =3D dest_cnt * sizeof(*destvm);
>
> --
> 2.43.0
>
>

