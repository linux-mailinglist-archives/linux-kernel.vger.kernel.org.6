Return-Path: <linux-kernel+bounces-269460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E400A943307
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E8D284049
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757D81BC089;
	Wed, 31 Jul 2024 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sEM5sj5N"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B6C1BC063
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438915; cv=none; b=LYfoaP/eHzHZirPz+uMxxnZtN7bgsUVfR6HngWBrPgRgRGPzggbJeezAdDqi606gIjfNQObh0vmZyhPD+tJXaGfsZPw6vuE59O8QZrp3+3dPoeVu/ibNv3cL77TMbhSqAMEcqeNRFNS4pPjMH2Ialp0RBelH+y2WxmoZOGTr0zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438915; c=relaxed/simple;
	bh=VpgY0Xg6DfUwXevHJITHSptNpZ/KejiVVBO0M9I7wcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzTj/gphrVzb1cA6cMnXsc+odgM59VOeFHn53o5Jm9KKPV+72xbof57+aF7bQ9zOPv9jQVSdjk5qDygmbLXM02OANPyN/mX6btYmKqd5XvJHfsa4CQXvPTB14knmm1kDCdjk5WJRtFGoNCBqUKxs2U87UelwCwi6rNSGsGM45D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sEM5sj5N; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7a1d48e0a5fso3444777a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722438913; x=1723043713; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A7L5Do6ql/oByA0Og1lQHP5Zdt58GNPzs9bcb2110UQ=;
        b=sEM5sj5NYGYb+rUnHGpCMbfl/hEsSkYUl9x8wWdIlbJSIexIP3afYESisa+An8ocPI
         cOePFTIrqk+31MapWL/9IQ+HM7rI90KG9KVQHr4iSelxrBQjT4P4Ol1RACW/S916bgCr
         k5PofrfFYM5uYOipDc4UtIsu9BP2YXNFvZRQPPMVFRXHYd6WnSnN9DboxLmrqcWCHULy
         Zd5fTadYXM+nnVWNIcEiUWL/2JOZan6SsuGuAHLaoyz/ah47ipVFL4b8TTFWOeboRh4V
         2b+2OJ+idBMvIDZMuZEyn5VfYRolU3sTZgYuGYLtNE5bhzBGgO6Tneof6C5Yw9MyWYxp
         ngWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722438913; x=1723043713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7L5Do6ql/oByA0Og1lQHP5Zdt58GNPzs9bcb2110UQ=;
        b=VgQTNfShv8jFBMK+lt+nWEsyOJdGLe6qWfdEqoEVUljMk/dFLmSoeeSb5puGJkcvgL
         iRUtDli/zrsBBPHBeIkLZ+w/Zb8GpHWzn3fQhvinpIZk06UqD2Z+MoyDDqM4K3BDIoQf
         PWMSf/YczrfvMsyf9WUZyjU7vzIrh7izflHkDkEIJtIAKjjgfL4rp8Yl7oRg2Cv7Ggx9
         QN0bPBKNyCa8RX+w6Ulp00dqvROn0DhVSHVgqTHvWAzBePLKS4qcElrmaB6jOQQRXgS9
         meUzTMaLMWvbx7P1ae8+nMmgZtZ4Bk1KUVAVUGiSvOcsFIVIA3R5Zm/g1dlTjRlmT8hG
         lLHA==
X-Forwarded-Encrypted: i=1; AJvYcCXx92GuUYKPAouEbwGWaBnSm0GooU/ShttozJpz3wG9/GyX4/xG8XRMQ/AnMVB8qzRe/KB7fmG9CrBZjdN78jxEsfYvvTOOGq7lFn/8
X-Gm-Message-State: AOJu0Yyyo80DMfkBZAu2FlBQ1HFldwrfnE/xGR6mVcQVpaZuM2inPULE
	UlGqHXZZaY69Gf5yrWas7F+oHpFkROaN8Eyibdw+NrDInSlJ9qUW04v3wfLWYyw++epgS5yzmoB
	yp266OTpaYJvsyZRJ4XznneO8vL308Nh0WiTyxQ==
X-Google-Smtp-Source: AGHT+IGOWnZACRw0j7R7sCt8gjeIABsJBlUfMD6ugy5Yf6aBd2+UubVXWPKVHQfhzdmGpu+w3Qe6DXJGRnK/31tW6FI=
X-Received: by 2002:a17:90b:3b51:b0:2c9:a3d4:f044 with SMTP id
 98e67ed59e1d1-2cf7e1c6781mr12380574a91.11.1722438913083; Wed, 31 Jul 2024
 08:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703122340.26864-1-quic_jinlmao@quicinc.com>
In-Reply-To: <20240703122340.26864-1-quic_jinlmao@quicinc.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 31 Jul 2024 16:15:02 +0100
Message-ID: <CAJ9a7VhwD6kFHPTgrfs+7fNx4nXZPqXTLK0ObmJM3A6mQfmuyQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] coresight: core: Add device name support
To: Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Tingwei Zhang <quic_tingweiz@quicinc.com>, Yuanfang Zhang <quic_yuanfang@quicinc.com>, 
	Tao Zhang <quic_taozha@quicinc.com>, songchai <quic_songchai@quicinc.com>, 
	Jie Gan <quic_jiegan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

1) As per Krzysztof comment - use the standard "label" property

2) Do not use the label string as the node name - there is no
guarantee of uniqueness which will cause issues. Please add the label
as a sysfs file to the standard node.
This uses the existing standard names, allowing any scripting based on
this to continue to work, and will not cause issues with uniqueness

e.g.
This will allow :

cat cti_cpu0/label

to extract the additional hardware context information that you need.

Thanks

Mike


On Wed, 3 Jul 2024 at 13:24, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> With current design, the name of the non-cpu bounded coresight
> component is the device type with the number. And with 'ls' command
> we can get the register address of the component. But from these
> information, we can't know what the HW or system the component belongs
> to. Add device-name in DT to support it.
>
> cti_sys0 -> ../../../devices/platform/soc@0/138f0000.cti/cti_sys0
> cti_sys1 -> ../../../devices/platform/soc@0/13900000.cti/cti_sys1
> tpdm0 -> ../../../devices/platform/soc@0/10b0d000.tpdm/tpdm0
> tpdm1 -> ../../../devices/platform/soc@0/10c28000.tpdm/tpdm1
> tpdm2 -> ../../../devices/platform/soc@0/10c29000.tpdm/tpdm2
>
> Change since V3:
> 1. Change device-name to arm,cs-dev-name.
> 2. Add arm,cs-dev-name to only CTI and sources' dt-binding.
>
> Change since V2:
> 1. Fix the error in coresight core.
> drivers/hwtracing/coresight/coresight-core.c:1775:7: error: assigning to 'char *' from 'const char *' discards qualifiers
>
> 2. Fix the warning when run dtbinding check.
> Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml: device-name: missing type definition
>
> Change since V1:
> 1. Change coresight-name to device name.
> 2. Add the device-name in coresight dt bindings.
>
>
> Mao Jinlong (2):
>   coresight: core: Add device name support
>   dt-bindings: arm: Add device-name in the coresight components
>
>  .../bindings/arm/arm,coresight-catu.yaml      |  6 +++
>  .../bindings/arm/arm,coresight-cpu-debug.yaml |  6 +++
>  .../bindings/arm/arm,coresight-cti.yaml       |  6 +++
>  .../arm/arm,coresight-dummy-sink.yaml         |  6 +++
>  .../arm/arm,coresight-dummy-source.yaml       |  6 +++
>  .../arm/arm,coresight-dynamic-funnel.yaml     |  6 +++
>  .../arm/arm,coresight-dynamic-replicator.yaml |  6 +++
>  .../bindings/arm/arm,coresight-etb10.yaml     |  6 +++
>  .../bindings/arm/arm,coresight-etm.yaml       |  6 +++
>  .../arm/arm,coresight-static-funnel.yaml      |  6 +++
>  .../arm/arm,coresight-static-replicator.yaml  |  6 +++
>  .../bindings/arm/arm,coresight-stm.yaml       |  6 +++
>  .../bindings/arm/arm,coresight-tmc.yaml       |  6 +++
>  .../bindings/arm/arm,coresight-tpiu.yaml      |  6 +++
>  .../bindings/arm/qcom,coresight-tpda.yaml     |  6 +++
>  .../bindings/arm/qcom,coresight-tpdm.yaml     |  6 +++
>  drivers/hwtracing/coresight/coresight-core.c  | 37 ++++++++++---------
>  .../hwtracing/coresight/coresight-platform.c  | 31 ++++++++++++++++
>  include/linux/coresight.h                     |  3 +-
>  19 files changed, 149 insertions(+), 18 deletions(-)
>
> Mao Jinlong (2):
>   dt-bindings: arm: Add device-name in the coresight components
>   coresight: core: Add device name support
>
>  .../bindings/arm/arm,coresight-cti.yaml       |  6 +++
>  .../arm/arm,coresight-dummy-source.yaml       |  6 +++
>  .../bindings/arm/arm,coresight-stm.yaml       |  6 +++
>  .../bindings/arm/qcom,coresight-tpdm.yaml     |  6 +++
>  drivers/hwtracing/coresight/coresight-core.c  | 37 ++++++++++---------
>  .../hwtracing/coresight/coresight-platform.c  | 30 +++++++++++++++
>  include/linux/coresight.h                     |  3 +-
>  7 files changed, 76 insertions(+), 18 deletions(-)
>
> --
> 2.41.0
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

