Return-Path: <linux-kernel+bounces-236966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 481DC91E92C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D121F22F0F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1749816F840;
	Mon,  1 Jul 2024 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pV7iWmMn"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2C416F908
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864436; cv=none; b=QsNbMzTjjvF9Xwl4gFv3kwOW6KIiWpGItRzS7bk5vQlQ9pZLpOFouMGXit7GWw0/5JigVvovWChD2b3RR4GhTK93qcqSrEDVzyT24EnxwCc++hJMDQhfPiaQnA0ArNoCLRvjJjdhy6QzJS8Bm8qTf/zakIoWymPTIVbjq7cjRb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864436; c=relaxed/simple;
	bh=DTx0TnMXknMnU1py/GEV3TbUeQ0A4+c8OwKWSEIEY60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYTjkk7tmwpnYHaf8Hqgx21hAQgyeg/O7EdaV1d3vtbtOfVuRqPvUYXUgxcQbaJeEyFvs2QrhxXTOABuIB4cpL2KtUxqVd9TA11y4OX7DLiqXvGmY1uFYGl1bFYB7E9fstSIG8RA7VMatLntuREgTdvq5aPXC6b/RmL3h0fAoho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pV7iWmMn; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d119fddd9so10819a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 13:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719864433; x=1720469233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HA1dU22m3UNj5lyj13MGSrb+8h3p7MYcfXDGMuEpnwo=;
        b=pV7iWmMnE4CLmq/TiV0X7tzonmq/wxD24BAM1cWI/CSi7jua2bZ+hR/8iqNnZvmmCD
         lqfrr8GMbU9DCJpVX3xmkkMZPAmd3kJImpE/q9WXkjnSZxlwd3WYd3Ay/r1od6cJWll7
         p6XX92skCQsVjeyAB6JEQuuBNPPtUGq4tvFpVRLtmHPgFxHr67+njCHPsasnMnCD6ji/
         T7D2HQ+O/ZRAozy5waDZoewOIK/hmXFu65GgxBVv9Wzsl/E99kKQGBQRWBExOBWRy6Xg
         GLhw2ySClsWGHZDTmrbVIkwm0r0/GcijvTusNEuaVAGv+zYb5MptAp3y9KMXp/IEwpsU
         0fBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719864433; x=1720469233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HA1dU22m3UNj5lyj13MGSrb+8h3p7MYcfXDGMuEpnwo=;
        b=g0/3RyPpUnsj5D+I7vZqNixhNP5lEi5qvLuhYuvkqgTemr60AurU/5LVIYPkvR0Xln
         wmnT382trAvv7dmLa+PR1YvWPE/425SuYVYulrQ50FLYPCv1yctXF593fuyBxrFaqH6h
         WDeNEMQ8jdL4/tpvwf5J6rBefJeKnbZIv+l1/VClO1ugB2Y+ovYFe/CcArP3d4vgwAR/
         GID/KBg/NHtuPdsEYhYhZT2QZX8EP55ZG+mPszqLlUGkoh59HL/IlNkplzORjdIOOyED
         4LC5576brDfnYTRu9Uzy0Tbem+kr6bQ/FRFdRWt7XDyvt2PPI/zUTuom3GvXnXsvXmea
         KNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfJC6Z7E+dDbnBpWAkRh93tOewENi26bK+nMbHiXxCm+hQjpCzKKltPVi8mp1K8bXm7pSWZI5ec/1fhMaAvPuI93mN0TSZnBGNDPcm
X-Gm-Message-State: AOJu0YyXBg9vdN+ZC0Z+FK1WJsvi1GdtniWx9znR7O0Vs+vC2U2vzoig
	Sofoyar3XXC0x2qg5kji07y3dGlXPh3Ls/JW+4jkB4YSEKSMs3hlwAF6cMQ/tCHYSrejX+ID90D
	SvNkGk2/lvUWAQKP8dSU15Bj8oCaveMP1IWOE
X-Google-Smtp-Source: AGHT+IH9YyeTHtOmKWNRjWDZNOFaOcyjCIO5hmhn2IbnyBQewSRB362+m++tv5m6fkb6HeoZ2TpHUYTYJYIbCgB85hk=
X-Received: by 2002:a50:d799:0:b0:58b:93:b624 with SMTP id 4fb4d7f45d1cf-58b0093b6fdmr89607a12.1.1719864432894;
 Mon, 01 Jul 2024 13:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701162025.375134-1-robdclark@gmail.com>
In-Reply-To: <20240701162025.375134-1-robdclark@gmail.com>
From: Pranjal Shrivastava <praan@google.com>
Date: Tue, 2 Jul 2024 01:37:00 +0530
Message-ID: <CAN6iL-TCsS1dxwZngJ77J1MJcBeRsZW22W9uNLG59Z-isy9J5w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] iommu/arm-smmu: Prettyify context fault messages
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Clark <robdclark@chromium.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Georgi Djakov <quic_c_gdjako@quicinc.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jerry Snitselaar <jsnitsel@redhat.com>, Joerg Roedel <jroedel@suse.de>, Krishna Reddy <vdumpa@nvidia.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>, 
	"open list:TEGRA IOMMU DRIVERS" <linux-tegra@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:50=E2=80=AFPM Rob Clark <robdclark@gmail.com> wrot=
e:
>
> From: Rob Clark <robdclark@chromium.org>
>
> v3: Split out the reg bitfield renaming, rework
>     print_context_fault_info() helper
>
> Rob Clark (3):
>   iommu/arm-smmu: Add CB prefix to register bitfields
>   iommu/arm-smmu-qcom-debug: Do not print for handled faults
>   iommu/arm-smmu: Pretty-print context fault related regs
>
>  drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c  |  2 +-
>  .../iommu/arm/arm-smmu/arm-smmu-qcom-debug.c  | 66 ++++++-----------
>  drivers/iommu/arm/arm-smmu/arm-smmu.c         | 74 ++++++++++++++-----
>  drivers/iommu/arm/arm-smmu/arm-smmu.h         | 71 +++++++++++-------
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  4 +-
>  5 files changed, 127 insertions(+), 90 deletions(-)
>
> --
> 2.45.2
>
For the series:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

