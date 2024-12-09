Return-Path: <linux-kernel+bounces-438526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C37189EA257
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1339162AEB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD5119E975;
	Mon,  9 Dec 2024 23:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4C7/opO"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5050019E82A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785329; cv=none; b=pJg1vh84Nba01FrB7JQ/ma6RJ6VKl+qUgrpsdVcz6qoP3RP65ORPsnS9Kj+Ry3MGyVDrX5IrNAkNtSy6+uaAATODY1p52JcO32dSpD0ytYQrVuRWnpt6itqT9wmFGDvZExtRUBFTb8BrBmqBiWaAYa6Jm7FsWTqoEzk/A9ZzXNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785329; c=relaxed/simple;
	bh=liVgg1Un+JU5vW6EYLPj8di7vygEt5iqSY9bAiVog34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqntdbjvLew9E96pFwc7rTunz8wmpARx8w4OKeqrqxSwcvty/+JyxGjWld6jvr1wpYqKUHkwCYOKgM59CZvKL5zkKWZr9pJ8Gzl8Hmr/uyeTPVI+zEta8UnnfOzQiYHEWCsccK5y5jF6zj+Fm4z7wzsHJbBcGhi4bm43A4q5qMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H4C7/opO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30033e07ef3so35688221fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 15:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733785325; x=1734390125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZK4h9MVOu/9hHVaZl4zKkp7NLqwJGJJgqac6hR7MTzI=;
        b=H4C7/opO6VRlO1FOruHjjKT+5sRaz+Z1bOwuetx89+wRwiCDJeYC25VGFEq9oXb7oM
         l6s91X4z4wb0A0C/w2AU1NIMRnim1aUHESYQtlLOCWoC4j25EDBbB/Lxmzoz3TBMc5od
         pMkCnqKdpfxSM3u952XJjB5elM2Zh7Cqgb41cnuJWMd3WAKp4SbsAHQliEm/VNTKzfAU
         t4QVQEgkftv3WZV0+tbCtg6VuMF5gl9IC5x/sGFZk8JR5dz4QdjXx+YuuPdGqXFlPWmP
         Ytlo81VWlbr5crnDKkwMce4e/5uc649cNMdP9uMfNLqVe+XWFkCcTGBEhoFJ7Ihakbox
         PbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733785325; x=1734390125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZK4h9MVOu/9hHVaZl4zKkp7NLqwJGJJgqac6hR7MTzI=;
        b=Wycoa+Eg5diaz8SCr5FgELWyXmRDe5sS2asKhDbOppY7eHM/FM4YlSFzf+DBsC3qoB
         pRbI8kAKbNjpkto6+Cz58F/gI9eBnrGpR29BmHqtJnn/YeteY2n8Nwqw4zw1EjoEkhO8
         xRiH8xcEQNT4CEgYdc4CUhlfmHsxoC0j0tVnMjEb7PLaQFwwjJAtUUdWUGvZH4sxxUbv
         kjouzHY4UXJWKFqXzFNdwiYbxfNO18gRMemPrVEz8S4/neoRL8zy2+r1QGyZuBVd/jzS
         l7ECyNxpCtx/qzD3rWDBB3Z+dltuRVhjC64cvaS8Zvz0ROkd/Y7FmyBMxGC3wz0M1DYJ
         tjNA==
X-Forwarded-Encrypted: i=1; AJvYcCV+8sePir66iIgycq2TNR6QT6DH4dfTmPfI1xTPdwL940/eEVL10IJsy3r2wbSdQnHGU8QduldzhnkIOuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPXzdfhrtIpbFZGZ4mI9MA3fY2j7Ff9SsWQ+FXTuyT6BDhuv1O
	AF0l+VqJEiWoqM9UmMH2SsKnB8gkMJx6M2ctci+jYqOQty6oalMyQ+XBwTTTeFE=
X-Gm-Gg: ASbGncsFyRPO0Z/JwvXveg/jbu+s1XnGGHuAMWJQQ6Jy0MkTFawIO+Gq1gxZ+ufQ28U
	WBZxYyZ4crx1IwSXgOEstYkjYQmCmghPK0FuZeAQIv6qQJHB2MkVerFd3X0/uIVAndEhSi6dv6f
	EqE/zhu9mXR9uGbNrjp9lg5jy9sUKrRiy2iCsI8bivG+QnRK6W7FUDwX2z/etcttH/B1JLyWCM3
	J778Ix7rOERtihECsq8jNe9+8LunwYL4XBT9tHC91Ji9WTdzuu/Gs6Ki/YgBaVzKM1BK5oKGBX1
	LTodjfQvZx3mjkebwtcu+Db+//aUxrUSjA==
X-Google-Smtp-Source: AGHT+IGnzZ2PJOWGOC6WltKgaOFUzxo3aZDddEYLzVRS44dM7WNYY9fUmV4e2qc5kDuxOcyc0FX6/Q==
X-Received: by 2002:a2e:be0b:0:b0:2ff:b8f5:5a17 with SMTP id 38308e7fff4ca-3023282c1femr3802651fa.5.1733785325460;
        Mon, 09 Dec 2024 15:02:05 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30038ce97b4sm10022871fa.118.2024.12.09.15.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 15:02:04 -0800 (PST)
Date: Tue, 10 Dec 2024 01:02:01 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Julius Werner <jwerner@chromium.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
	Roxana Bradescu <roxabee@google.com>, bjorn.andersson@oss.qualcomm.com, 
	linux-arm-kernel@lists.infradead.org, Trilok Soni <quic_tsoni@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Besar Wicaksono <bwicaksono@nvidia.com>, D Scott Phillips <scott@os.amperecomputing.com>, 
	Easwar Hariharan <eahariha@linux.microsoft.com>, Oliver Upton <oliver.upton@linux.dev>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] arm64: cputype: Add QCOM_CPU_PART_KRYO_3XX_GOLD
Message-ID: <k64saaxnipegp4ot636apzewrs7dz2j7xdpqxg6iotbaderuia@hxqf63bwwztf>
References: <20241209174430.2904353-1-dianders@chromium.org>
 <20241209094310.3.I18e0288742871393228249a768e5d56ea65d93dc@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209094310.3.I18e0288742871393228249a768e5d56ea65d93dc@changeid>

On Mon, Dec 09, 2024 at 09:43:13AM -0800, Douglas Anderson wrote:
> Add a definition for the Qualcomm Kryo 300-series Gold cores.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I have no idea if this is actually right and no way to test it, but it
> fits the pattern of the other definitions. Someone from Qualcomm ought
> to confirm this.

This matches what I see on SDM845.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
>  arch/arm64/include/asm/cputype.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 488f8e751349..c8058f91a5bd 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -119,6 +119,7 @@
>  #define QCOM_CPU_PART_KRYO		0x200
>  #define QCOM_CPU_PART_KRYO_2XX_GOLD	0x800
>  #define QCOM_CPU_PART_KRYO_2XX_SILVER	0x801
> +#define QCOM_CPU_PART_KRYO_3XX_GOLD	0x802
>  #define QCOM_CPU_PART_KRYO_3XX_SILVER	0x803
>  #define QCOM_CPU_PART_KRYO_4XX_GOLD	0x804
>  #define QCOM_CPU_PART_KRYO_4XX_SILVER	0x805
> @@ -195,6 +196,7 @@
>  #define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
>  #define MIDR_QCOM_KRYO_2XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_GOLD)
>  #define MIDR_QCOM_KRYO_2XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_SILVER)
> +#define MIDR_QCOM_KRYO_3XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_GOLD)
>  #define MIDR_QCOM_KRYO_3XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_SILVER)
>  #define MIDR_QCOM_KRYO_4XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_GOLD)
>  #define MIDR_QCOM_KRYO_4XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_SILVER)
> -- 
> 2.47.0.338.g60cca15819-goog
> 

-- 
With best wishes
Dmitry

