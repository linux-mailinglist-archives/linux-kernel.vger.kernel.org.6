Return-Path: <linux-kernel+bounces-391039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE979B81AB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9061F223CE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA2D1C57AD;
	Thu, 31 Oct 2024 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aH7mIWdm"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C98B1C2456
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730397199; cv=none; b=XR34jaGA7Y/HI7RWXe31FkjHxsysuDmPGG+qr7yYYv9Qh3WhfHNQAjoLFfVHYA/rVXNUlHbgaWpVqpL3OQ0aUfCAvOqq99HLodUOJ4QI8ejWJRk75txr1nNLNFIpvTpf9BQlMpInH5XtIN0+kLwvarVttCNRqdO3OyLdfbD4rpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730397199; c=relaxed/simple;
	bh=16heonn6bCASaqUGb0FQp5zbeBvs9p0wRP4nLfuzvgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpwlvrB6MsJehm4+h0SsI8z4X9aBTCUnqPE5JClic/KhoFF441OjgMr7tsxdFLGkT0MrQllAx4Hb5wSG1UlCX+uBYUzBnodjxyLC35SG8FcbibF56IQUDHfeljb3KTZA3srZlrYbd5g1GVMcfpf28kmG929htjYrWx67wbBPdxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aH7mIWdm; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so12113351fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730397195; x=1731001995; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a1fXJfoBuk9F3isji/b29JProAzLl9eviUjDe1dQzEw=;
        b=aH7mIWdm6l0cMOCpQslJFfSRue7NEwFSN3jDiW7By4hop03xr3WLzbuBLIBxIoQlWt
         H7p3NBsJH6HTyLwon5CMoEmDWWWGXRGakXxkeIu96v1Y+021XvJML1zvx/dgligBh3jE
         3Ah6mr2VU5NML5uxPp8Wu4Dpzm1Iq4Rdx3u8SV5eb1GR3iUKmuzAmquxXtOKUHPXtPQ6
         lzXAH2jMusp43ebqOclAT5PQZYhFPhVbJX0OV0FrbLSDjj29yp/mF2rTJo8z5UGwbRQF
         CKNicBv3kWJ+kxQhtPG29Lnqt+cvhuuw4bwvZL8+37c06wSlOwFK7o+eX8qTkqbNj4oO
         AHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730397195; x=1731001995;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1fXJfoBuk9F3isji/b29JProAzLl9eviUjDe1dQzEw=;
        b=jUkCnOmMQMh3ZYaOwpLbZb5GCN6q/UpBfaYtaDUFirkedZYJJEhl64jGe7p6iclrQU
         V+OHgW3KAfAVlVcaCG/p2c7PtBqz1psvHTqMxXB/TCm8DPm8wUl9cr/41cLIS1P1RcJy
         eCpIKEfdtdHlPpeZ3Q+8AVTf7kHrQFFbxbfJJDm0QpFSEcpcrFhnuirEE9S+huzbLaBT
         9r6v1UEDukutCEW1CIypL1H0b/s6zh5Bv1CY/LxWQ8hhEyoS2vN4BOs+shT5k2byXud/
         UPOhNorjGz7MKmLfbAlSPcV4jSATRTVrVY4vTCJUOh5s0uvHdpj7V/EdWagTHYXjOEsI
         J4jg==
X-Forwarded-Encrypted: i=1; AJvYcCWulDAxRWDR1OtPO657JJ1j5PzWO70e3IRI96t0Sg28CB3o7YaYSr/O4w0sja2L0biw5FUol9QLZLPdGgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyxUW39K23bgmVNdeHNX7aDzrX3eENAektytHP9uNTi6Uys8bP
	g5PdSqpjBPXWD4RYqYydy6lFzqJgdmLOBHRcuMd4wfe6pTIteOKAe8xvZx2DjrY=
X-Google-Smtp-Source: AGHT+IFk+AxdkKYlXoXc02MYAfV8BR2Zt3Gl084Fy5JnF8f0wBqkE9kj0nXJrHlcrTNrRoRUVok2sQ==
X-Received: by 2002:a05:651c:210a:b0:2fb:266b:e3b2 with SMTP id 38308e7fff4ca-2fdecc3051dmr24108801fa.36.1730397195143;
        Thu, 31 Oct 2024 10:53:15 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef3bbea1sm2883421fa.24.2024.10.31.10.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 10:53:13 -0700 (PDT)
Date: Thu, 31 Oct 2024 19:53:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 10/15] thermal/drivers/qcom/tsens-v1: Add support for
 MSM8937 tsens
Message-ID: <dtmmxkolciktgedsrddp2m6fvd4v5mobtg3tq7bq3564buxitj@7vphzljzey36>
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org>
 <20241031-msm8917-v2-10-8a075faa89b1@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031-msm8917-v2-10-8a075faa89b1@mainlining.org>

On Thu, Oct 31, 2024 at 02:19:51AM +0100, Barnabás Czémán wrote:
> Add support for tsens v1.4 block what can be found in
> MSM8937 and MSM8917.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  drivers/thermal/qcom/tsens-v1.c | 13 +++++++++++++
>  drivers/thermal/qcom/tsens.c    |  3 +++
>  drivers/thermal/qcom/tsens.h    |  2 +-
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

