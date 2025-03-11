Return-Path: <linux-kernel+bounces-556678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AF4A5CD49
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7198617B18C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0DA2627E7;
	Tue, 11 Mar 2025 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="At4YJ3V5"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9F2262D32
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716620; cv=none; b=ptySOr7UkpYMLXzCvTFIhR4QWQotdUPB8YZpx+HfJXk1uMSbHscO0A0uaA64ube4hiUcLBbLIix9Hsv8sByO0TVrBdBeOfGN15te1P0/MHbHscdg81AZYqL80SZd7/m3HJNpt54iF+hLDViSKXpZsgLPSL2n7KPj9gan42NfS9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716620; c=relaxed/simple;
	bh=coAzhB0hx7rYebe0dMRnAoaKwZDK9rhElFVz2wVG6jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXyUtPBZJj30Btuxy+pGf/At0MXx5i3O840VG2sSTkVUrPGB5NzPzs1bwmPVK0HY+Z5XId0nwtaFt8qcS+7q8eCfJ3nd5J3KeZn2pXogEvNmDWjujwXMMOGrqoRKW7injPIwgaltOMWkilgqqAD2UZI7m1JZ+RTFROIBWrDI5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=At4YJ3V5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-391342fc0b5so5107287f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741716617; x=1742321417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7tecvAy+u2nTgNfC9RdDCsqyar8u41Y2yinoQJZWxPw=;
        b=At4YJ3V51CeWCPyLfE0DJVp//Dep8xz9zqENUdX0gbpbeWvp1hGWhYmta56PGiu1d/
         Q9rqu/Ld1nwCoUauIk9PM/AnWH6A2LXYvEOG6MHAQ0xbJ5dzjszKvbHq6+8y6WJs5pY4
         C0APWZOoS5kLoYZEqpN1Ofwn1TOFHmbYf2SZYSjNk/AtIUarR06HCmxwRJ9+LBeabcBF
         cvpi8LdZogC9/PGhF028kHFS8h9jtEVni7XIRiE9LQoFOJv5zbuMbojFzoWxfGJcw2rV
         XkBHVY9ZOE/T7hPvHW1IjUxAu6syOsBi2DvXcR5qeo6z0pOkAB0/zz+fdQKuE+VHjMOx
         xTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741716617; x=1742321417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tecvAy+u2nTgNfC9RdDCsqyar8u41Y2yinoQJZWxPw=;
        b=t+Vi8XlaAKJuZNl1IT9zRXKl2VuMBwX+iQYwkY6ftsLUHZEB/g1mJZ9vPuhcA5vyd7
         fm32hOPxthVLPCu9VQwcP/N60Ryj9Iet/QmDX+aWALyZly+3AkFH828A/tZ7w6zuGIzQ
         /czT9XG2cTjDIySUC21O0SLRzp+2WncETaLlb8/Q3apIDvw0pHBVwVRFqY7BeYSIrtGe
         aqb0pMwwWpUcVB7pbstgUqNp1Pm80VYoZx7yiRNVkRh8orL1DCmUoj6BhR/PpXs5e/kn
         XW62vdewzkswfK1NvLIh9aFxDsyXEq9yFkuZL/XIK0yfLFY+vXCCfRgVm4qqafmmrXMH
         a04w==
X-Forwarded-Encrypted: i=1; AJvYcCWdzdojAAAt/O4OPJEUTSEw0VQvHOmDN0P223L1ARZ4g5qYhAbqwroXKZ/kxGbhq5PiuSJUSa0mruUdg5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4frbihVJMbmKaCpzvxNg/r5SvHkF3kCpDOPybvXgBQeqFD3KA
	NPRCbNOt/Bi9QBiCxgZ/sIeJxescss5yyEBFyUiuHnCfZsOGlv+DOHNpJPDf0zmEDE//vwznqcU
	DNP82B6zOFkPNrihHI6H0ZhdBWzbvNZDOstH2qw==
X-Gm-Gg: ASbGncvm7i6YAoR3AZEhtd/BxApt7l5RS73lJzfWe27Z6s1M6wOchZrw+hiizc1QXOS
	D3xLrpB+Oim2y3Xy7IC4RjI9yIJr9ZGndTrc1oGi1gqL6Fs7+wOiTdPDSKoXz8y3ggJrFE+p+Lg
	OxF2u8zNihpuMHepzbTIzf0e1tP4I=
X-Google-Smtp-Source: AGHT+IEoMIu2qa0ouzgu4WMGPB2l4x9tF1jT5ThBiiWJB8oICkXYch22N7BWvOSIBrMFeOfJO4XpxafHp8QkcQy5AgE=
X-Received: by 2002:a05:6000:402a:b0:391:888:f534 with SMTP id
 ffacd0b85a97d-39132d39209mr19655289f8f.20.1741716617093; Tue, 11 Mar 2025
 11:10:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311-wip-obbardc-qcom-defconfig-interconnects-builtin-v1-1-675b6bc57176@linaro.org>
In-Reply-To: <20250311-wip-obbardc-qcom-defconfig-interconnects-builtin-v1-1-675b6bc57176@linaro.org>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Tue, 11 Mar 2025 19:10:06 +0100
X-Gm-Features: AQ5f1Jog8mLk3h4VXg6PLgDM_85qkXGsgrKxdx2EG0uqVayo6r93gzulMiKOPb8
Message-ID: <CACr-zFC=mPNeeHMp9XnSby+cMQaPWt_3s8iUiCN+EnVPeGad8Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm interconnects as built-in
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I sent this patch to start the discussion, some things I found:

1) Some interconnects are missing from arm defconfig. Should they be =y too ?
$ grep CONFIG_INTERCONNECT_QCOM arch/arm/configs/qcom_defconfig
CONFIG_INTERCONNECT_QCOM=y
CONFIG_INTERCONNECT_QCOM_MSM8974=m
CONFIG_INTERCONNECT_QCOM_SDX55=m

2) Some interconnects are missing from arm64 defconfig (which should
probably be in there) (I have included just two examples):
$ grep CONFIG_INTERCONNECT drivers/interconnect/qcom/Makefile
obj-$(CONFIG_INTERCONNECT_QCOM_QCS615) += qnoc-qcs615.o
obj-$(CONFIG_INTERCONNECT_QCOM_SM7150) += qnoc-sm7150.o

I can handle these in follow-up or v2 of the patchset as follow-up
commits, please let me know what you'd prefer.

On Tue, 11 Mar 2025 at 19:03, Christopher Obbard
<christopher.obbard@linaro.org> wrote:
>
> Currently some Qualcomm interconnect drivers are enabled
> as modules which isn't overly useful since the interconnects
> are required to be loaded during early boot.
>
> Loading the interconnects late (e.g. in initrd or as module)
> can cause boot issues, such as slowdown or even not booting
> at all (since the interconnect would be required for storage
> devices).
>
> Be consistent and enable all of the Qualcomm interconnect
> drivers as built-in to the kernel image.
>
> Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 219ef05ee5a757c43a37ec9f8571ce9976354830..6582baee2ab02ecb2ff442c6e73aa6a23fee8d7f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1656,11 +1656,11 @@ CONFIG_INTERCONNECT_IMX8MN=m
>  CONFIG_INTERCONNECT_IMX8MQ=m
>  CONFIG_INTERCONNECT_IMX8MP=y
>  CONFIG_INTERCONNECT_QCOM=y
> -CONFIG_INTERCONNECT_QCOM_MSM8916=m
> +CONFIG_INTERCONNECT_QCOM_MSM8916=y
>  CONFIG_INTERCONNECT_QCOM_MSM8996=y
> -CONFIG_INTERCONNECT_QCOM_OSM_L3=m
> +CONFIG_INTERCONNECT_QCOM_OSM_L3=y
>  CONFIG_INTERCONNECT_QCOM_QCM2290=y
> -CONFIG_INTERCONNECT_QCOM_QCS404=m
> +CONFIG_INTERCONNECT_QCOM_QCS404=y
>  CONFIG_INTERCONNECT_QCOM_QCS615=y
>  CONFIG_INTERCONNECT_QCOM_QCS8300=y
>  CONFIG_INTERCONNECT_QCOM_QDU1000=y
>
> ---
> base-commit: b098bcd8278b89cb3eb73fdb6e06dc49af75ad37
> change-id: 20250311-wip-obbardc-qcom-defconfig-interconnects-builtin-258fcc961b11
>
> Best regards,
> --
> Christopher Obbard <christopher.obbard@linaro.org>
>

