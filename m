Return-Path: <linux-kernel+bounces-352559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9789920BA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 21:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5327F1F216CF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B660A18A6DE;
	Sun,  6 Oct 2024 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hl20Dg0P"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D818991E
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728243267; cv=none; b=JVmRwuHIYcwZrL7VQWORr5rtZX4by4SmUHz2XNWiDbDfiaPstBjcMN18nrGTaXmcsY/uQ59iBc4cPknhSzhqk8sB3q6BtFqQ1nv58X3EFrOcG58hbH9oC3tm0wypQwJOrvEMA/jJeV6YS30XUlHWK1V3qB4bsAv44UoB+RnO+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728243267; c=relaxed/simple;
	bh=yPzaunxJaneO/099P+GEkSWTX5DT9FS9497uaVPrAtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcwzQQ/5ItkCLiOx8Hi0q4T8mD2u1/wZzJq9k499jgfjy9ralYdaj7eEiqfMpM39p8XOwrRz8odzrmZTgaQIaNWoRiZPyw0rvyZofTgqXtHL1kyCS339vaFRvI2CMu4naITe5brKOh8b6Co7eHQULY6WF6p0+Bmnphkr3uTCgvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hl20Dg0P; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5389e24a4d1so4463531e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 12:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728243263; x=1728848063; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R8q3dDlB0727MfbgdMqebUn7s4vTdoYhqoyoWQRyPuQ=;
        b=hl20Dg0PCCmnBMmkC+uVKHpGe0VrhmXiIMXJ4pBoYejM+4tDCUzPsPs8uCmF8PR/9+
         Y9TeMWJ4T5JIsiQf+P4gTsv1NfkzgJWL/Jfb4arxf3JkyCrlA3e39qssAB5F+mej/uNj
         ROlNJm/rXp7i/Z+RJkCqpX/BpcDQHFMuyqG4nrKtcjsk5Mr9B4ThvQrLUJwYjYDXu85U
         dGhoawpbiHPK+4M8qDe4sZxH09yJviKE0SFmO/thN0qfXJ3IOZlfSHBWZeGb2ysqBkA6
         UOq2tr8FyFsWAnA5gN39kCVxMSZqVDMx41PMSMIzfkj3Eo56WBCNIfPdEtiYd79iSMNo
         1vCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728243263; x=1728848063;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8q3dDlB0727MfbgdMqebUn7s4vTdoYhqoyoWQRyPuQ=;
        b=HmLVfI58bs6aIdN08QFgFfbh8nSEuDUlooCgWUbGeHDvaymsbluNLvtoSBW7W/5K/r
         tL1+K1yIiqypHVzBXNr02J6xGdFLDuzzL4N8p5umExfRCxKxZtrw33Dez4dmUe++dbdg
         1fvow5SBWn+wA2BWEqUIwbi1iYJURtmMymbL6/VQG2MAZ876LZo9D2POjNShHMP/kbHB
         Tr39qT3uMjP5sbZPzeCalGkSBevz37Z0tTD8Sznv9HmPben5Gj8mcFtXlgzaQWJ7PaEY
         9LsNPqwRkHyvZ8xsId3+Vy7gNmJZeqxWv0mmeSvCeCS9MNK05XYNICCsYPPVkkxMHsAY
         82mg==
X-Forwarded-Encrypted: i=1; AJvYcCVzKScrXQrGMzurR6AQMz4eccRx0x45wDWOFAAcMK4T4BDVoy2v6Y6+P9EHfrBpYQi/YP9KaydlD7mxQiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJX/DOTuUx+EjuUQQfGm/sYCIdVafCqix5PwaWxKEtrjofeOo6
	ihCYvYAGeXyoe0FROpKJ7Jso8mGRMmzZ6P/fKQ9yhVA4tiGliXTlQC1jjKB0jv4=
X-Google-Smtp-Source: AGHT+IFoPrYElR5M4WSqZpXWHN+3fySqpZ3zqAu1PEK8VTNMZekBd0rQ4ZV63xcbV97yoSotb4lYPA==
X-Received: by 2002:a05:6512:3b21:b0:535:45d2:abf0 with SMTP id 2adb3069b0e04-539ab8adcb6mr4175272e87.39.1728243262892;
        Sun, 06 Oct 2024 12:34:22 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff2831fsm607332e87.264.2024.10.06.12.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 12:34:21 -0700 (PDT)
Date: Sun, 6 Oct 2024 22:34:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Peripheral Image Loader support for Qualcomm SoCs
Message-ID: <r4zkfioctmlatxkb4lqmfc7vk7cdenenihoicq2k37wvxeihss@gtkzxr26p6ei>
References: <20241004212359.2263502-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004212359.2263502-1-quic_mojha@quicinc.com>

On Sat, Oct 05, 2024 at 02:53:53AM GMT, Mukesh Ojha wrote:
> Qualcomm is looking to enable remote processors on the SA8775p SoC
> running KVM Linux host and is currently trying to figure out an
> upstream-compatible solution for the IOMMU translation scheme problem it
> is facing when SoCs running with KVM. This issue arises due to
> differences in how IOMMU translation is currently handled on SoCs
> running Qualcomm EL2 hypervisor(QHEE) where IOMMU translation for any
> device is completely owned by it and the other issue is that remote
> processors firmware does not contain resource table where these IOMMU
> configuration setting will be present.
> 
> Qualcomm SoCs running with the QHEE(EL2) have been utilizing the
> Peripheral Authentication Service (PAS) from its TrustZone (TZ) firmware
> to securely authenticate and reset via a single SMC call
> _auth_and_reset_.  This call first gets trapped to QHEE, which then
> makes a call to TZ for authentication. Once it is done, the call returns
> to QHEE, which sets up the IOMMU translation scheme for these remote
> processors and later brings them out of reset. The design of the
> Qualcomm EL2 hypervisor dictates that the Linux host OS running at EL1
> is not allowed to set up IOMMU translation for remote processors,
> and only a single stage is being configured for them.
> 
> To make the remote processors’ bring-up (PAS) sequence
> hypervisor-independent, the auth_and_reset SMC call is now entirely
> handled by TZ. However, the problem of IOMMU handling still remains with
> the KVM host, which has no knowledge of the remote processors’ IOMMU
> configuration.
> 
> We have looked up one approach where SoC remoteproc device tree could
> contain resources like iommus for remoteproc carveout and qcom,devmem
> specific binding for device memory needed for remoteproc and these
> properties are optional and will only be overlaid by the firmware if it
> is running with non-QHEE based hypervisor like KVM.

Can you follow the approach that has been implemented for existing
systems (ChromeOS) not using QHEE? See drivers/remoteproc/qcom_q6v5_adsp.c
If this approach can not be used, please describe why.

> 
> - Patch 1/6 adds the iommus and qcom,devmem binding for PAS common yaml.
> - Patch 2/6 and 3/6 add helper function to IOMMU map and unmap carveout
>   and device memory region.
> - Patch 4/6 adds a function to parse individual field of qcom,devmem property.
> - Patch 5/6 add helpers to create/destroy SHM bridge for remoteproc
>   carveout and to get memory from tzmem SHM bridge pool for remoteproc
>   firmware metadata.
> - Patch 6/6 enable all the required support to enable remoteproc for
>   non-QHEE hypervisor based systems like KVM host via parsing the iommus
>   properties and mapping/unmapping carveout and device memory based on
>   it.
> 
> Komal Bajaj (1):
>   remoteproc: qcom: Add iommu map_unmap helper function
> 
> Mukesh Ojha (2):
>   remoteproc: qcom: Add support of SHM bridge to enable memory
>     protection
>   remoteproc: qcom: Enable map/unmap and SHM bridge support
> 
> Shiraz Hashim (3):
>   dt-bindings: remoteproc: qcom,pas-common: Introduce iommus and
>     qcom,devmem property
>   remoteproc: qcom: Add helper function to support IOMMU devmem
>     translation
>   remoteproc: qcom: Add support to parse qcom,devmem property
> 
>  .../bindings/remoteproc/qcom,pas-common.yaml  |  42 +++++
>  .../bindings/remoteproc/qcom,sa8775p-pas.yaml |  20 +++
>  drivers/firmware/qcom/qcom_scm.c              |  29 +++-
>  drivers/firmware/qcom/qcom_tzmem.c            |  14 +-
>  drivers/remoteproc/qcom_common.c              | 148 ++++++++++++++++++
>  drivers/remoteproc/qcom_common.h              |  38 +++++
>  drivers/remoteproc/qcom_q6v5_pas.c            | 140 ++++++++++++++++-
>  include/linux/firmware/qcom/qcom_scm.h        |   1 +
>  include/linux/firmware/qcom/qcom_tzmem.h      |  10 ++
>  9 files changed, 423 insertions(+), 19 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

