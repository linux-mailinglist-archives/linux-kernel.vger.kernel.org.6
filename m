Return-Path: <linux-kernel+bounces-528365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4057DA416F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94AA83A733A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91538241675;
	Mon, 24 Feb 2025 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgFqjvSn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DAE17548
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384666; cv=none; b=jDp/K/nwiAqC6Dcl9XljsNYq1UtaDmmCVGx98TkgqMTs6uOyWzRjEztCrPyg5EmEtN9HqUTwplEqdRMu/Pw2l7SYB8XtWmI9OvtVXrN4iPWvlc3UR7kkEiB+xtFHOrRAKdtpFT7Z/ckaKeJSRXORgwvOSFotSN8z4wzpDjQAmVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384666; c=relaxed/simple;
	bh=wpaTUIwidiE3GZ8YUXT7uXhOSdSbxhbvnoqkGr7J4/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amyHeZQXezKF1lxbF96R7Ev/X/AVpIRSVLWSJ+ez7dJsi4jGUYaJUS9wB0rSlvoKTsPFAuMGojo9/h8lHFrQkt9C+UnyS+sRHdquOOu64YWNLDwMjEXIOqTwFVDG/eCiO6rlV4YBvtMi90iPzXh+/T659oazPdijcsg3up4QLK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgFqjvSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73853C4CEE6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740384665;
	bh=wpaTUIwidiE3GZ8YUXT7uXhOSdSbxhbvnoqkGr7J4/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MgFqjvSnEXfT2dN4JbrW/VYqYgG0nWOsQqlUPQ9awS2RrhQZZkwg2OtAbIQLfcY7P
	 tmsnful6TtvtS4w6HHnFxFlDrugVAC3GoSEtUbRJonDvXS2eElxEb5eqcI6VYxVsCj
	 3sSUMT+fkiS1zfZhpJIrexfUdY7cl6RnZ0p3HD3ZgaDgklHkiUtE1fM4kpOxe6cPv3
	 yyCBCIvdRTFbTEbCeJXshwAP6fr2U177a81O0o6wUp76E+U0eybAZ3PAjr0JuX6UGo
	 03moZsKieEmNVnbMZ/Q+aH69KZK4RC9v1/OH3RdWLpiqERS7ufPP9WkuKKnEaGWrZS
	 QbcQLVyKeM8xw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5452ed5b5b2so4154310e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:11:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2UxPoI1ob+6b4vdpokm/+4uR2HtJ1aE0xhehEoYT//jzr9ACa+KgyYb4dm6ngzc0IIodZEhKaxo2xH1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YycNDnxK466Q09XkoaYxmvHairs2DvXfWy++iMBpfw+hqU054Ho
	Hpb4BS6umv+iYo+ZG/ROVuFhbmGZM/gZetF7NcFd2QNKAMILjx+6EYULl/k0C63xt807dcnB4hh
	+27+ePAFkeROyvHMv+sGvHiL3pFs=
X-Google-Smtp-Source: AGHT+IGWAdvh8Uk5kDUolWyUpntZPHToLER0sCEfBzrsbMTUct8qTsWzLwAR4xPwH4meMXT3mHvjOWDudLYqwdHehTo=
X-Received: by 2002:a05:6512:2211:b0:545:58e:e543 with SMTP id
 2adb3069b0e04-54838ee9334mr4265598e87.21.1740384663815; Mon, 24 Feb 2025
 00:11:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224062111.66528-1-kpark3469@gmail.com>
In-Reply-To: <20250224062111.66528-1-kpark3469@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 24 Feb 2025 09:10:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG5uTUH3--A3OtPQcMqj4hiNrONL6tUKkmwqmjkOYMuyQ@mail.gmail.com>
X-Gm-Features: AWEUYZml3zcWsZttkBGhQ352lKORrZnbm7B76-btGrHm4knlWfWj1Hj1AfPuHtk
Message-ID: <CAMj1kXG5uTUH3--A3OtPQcMqj4hiNrONL6tUKkmwqmjkOYMuyQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: kaslr: consider parange is bigger than linear_region_size
To: keun-o.park@katim.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	catalin.marinas@arm.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 07:21, Keun-O Park <kpark3469@gmail.com> wrote:
>
> From: Keuno Park <keun-o.park@katim.com>
>
> On systems using 4KB pages and having 39 VA_BITS, linear_region_size
> gets 256GiB space. It was observed that some SoCs such as Qualcomm
> QCM8550 returns 40bits of PA range from MMFR0_EL1. This leads range
> value to have minus as the variable range is s64, so that all the
> calculations for randomizing linear address space are skpped.
> As a result of this, the kernel's linear region is not randomized.
> For this case, this patch sets the range by calculating memblock
> DRAM range to randomize the linear region of kernel.
>
> Change-Id: Ib29e45f44928937881d514fb87b4cac828b5a3f5
> Fixes: 97d6786e0669 ("arm64: mm: account for hotplug memory when randomizing the linear region")
> Signed-off-by: Keuno Park <keun-o.park@katim.com>
> ---
>  arch/arm64/mm/init.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9c0b8d9558fc..2ee657e2d60f 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -290,6 +290,11 @@ void __init arm64_memblock_init(void)
>                 s64 range = linear_region_size -
>                             BIT(id_aa64mmfr0_parange_to_phys_shift(parange));
>
> +               if (range < 0) {
> +                       range = linear_region_size -
> +                               (memblock_end_of_DRAM() - memblock_start_of_DRAM());
> +               }
> +

Please explain how this ensures that hotplug memory still works as expected.

