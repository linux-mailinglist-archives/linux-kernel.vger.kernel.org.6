Return-Path: <linux-kernel+bounces-526859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694A7A40482
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 02:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B553B6F3F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74CD15854A;
	Sat, 22 Feb 2025 01:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T2M1WL+O"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4419615689A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 01:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740186421; cv=none; b=BoH47X+x4AM1knRvuYTAhiyR4R47PGAtOarRkmWBO4C3u/Fxm/4jhNw+bmArnjnLfytJzeUoYHoJWs+sTPWVuRRsW5/yvGNwt5Q2Qb63d2qLF5+z1oXvo3pn/r8b9VEXZsXxBjeoz/8bkTTXQOob1+tVqi/GxXpAejU3BJI80sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740186421; c=relaxed/simple;
	bh=oWNjA4iAb86TL9euhzKXI+ikt4IOF7STMLKlY2f/5Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBGX+w1uxL8X1qv7RZYpkrgbtAHJAa/UL7MQqAAqIrhQ8/RQkBorPJgHzgtw0ICOrs4iknqP8kR0fjQUuuQmvGhC87K6/reV2ZXXRSeSV6MEysTinbZi4+En3Tz8tF5Xbj4wzEsyaVjGP2HtmLajGNJ7JTXRu3hTj/HhEznkrbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T2M1WL+O; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so3050592e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740186417; x=1740791217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SXPIaDT705xuetNhhFasT7VZfBwG839I1ETVy1U9JU0=;
        b=T2M1WL+OQCezs9X6uQsXyfVuar8bbfB7qZLDjwJVCs6wCdR0EMJXi8sZ2/8Yz2QUwO
         C3KLTupYXVyK5T0abivr+XyEFWP5DYgRTD41HVkYT7bHIm+d1vKGoa5smSrKSg9/ab4y
         VgrlwqxWy1pOqZhgdPiGqvAept+ngle5rYLR9GN5CDnnhdGHyPgC5D3PKogKoQiibpL4
         gs/+sjsntGsEfxewj3+6lXzh0u94TIGk92Qc9eAYmXemSf2j/hIpkZaWCav/tEUoBz28
         qezxudzzIutHPyiisII9hryeotOBL2XVn/CaH+jqWOR+AQa44nHMFAwDJZT9K5s3z+l3
         4tZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740186417; x=1740791217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXPIaDT705xuetNhhFasT7VZfBwG839I1ETVy1U9JU0=;
        b=kzR2O37TWTi7KaIxGmpvv9D7uKT7ICEpDvypWpwtbXMl9DosaRhMIhLOTJORSvKc+0
         i48H9j5EDN7KFbmlVTR/BTcvhay5JSxvBijPT4RWLXMwIn0Hi2Jb8rxDF1GEq7hzQP+A
         AKp6nat5dfbydgHanHOanTs9/wU6BwyzIQdluXJ6aZRtwoRMB64lMRsAZvsNjLGjVN62
         iDxXLxhk9tdg+C63N3+FFEbFIBWl26jYLA0A6QuQMiA6wi/JyeKbMmLjHcTE8jyQK5dO
         L2Qv1vUCC6y5vAkpng/G/VVatZQRW+XX+FMEEvjIs1j6POZucESFkV6kihszkm4+pcMN
         s8sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMpmqyCouN5cfDuxPCHUB7xm+jvBGAYOxnuY99PJMoYVx+/l3gOmEtevXv1bDFb9tMOKMesHN4h/VqqpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygiViz9N1KgpVTz7hVbhf/LtrgSjhO8n/B94Yrl2g84s4KGZM0
	mrfiq1azVod+hZveIIJ3O2pMLP9oWF4PpdFPcNqoIy5ECpJuWg7mY7ck04fKt/s=
X-Gm-Gg: ASbGncv88Z+k/NHgOQH1V/En46qGlg7EdYHsymXolyz48+2kx0ZXfR2IS9WB0KTeyd/
	odF+8HRd94d/aBlMb+GbjErAAasHoqtFKbqpG0HQNI4+loxozRmCovqYwnyHIaUv5ncV6gnsgka
	jlb6827WiaGTIYA3mpcKKpX+hD6sJmrNYb3ASLwiC2RBLTG3xAybxtNNFpxxXaFVZjzbfx6ha5G
	J7ixjVk2D7X4+NYsom92NqNpN1ON4hRO0poD8BOKRfor7KtSOlshI+Nm5va5lITCltyjpVeqmxp
	KDEm0/OThR/HEMKKsiciH/kr8LmA+wN/cjUAhilARydiyf3sSDHHNHnuCWNFT609yE5qu/YG4Dv
	I8Wf1RQ==
X-Google-Smtp-Source: AGHT+IHi+ordHXE50By3g3XEuMDzRdPKjNWp+dXW81whZVyJYjc5ubTtNYsiZV1PtpJnAOhMKIvswQ==
X-Received: by 2002:a05:6512:3c87:b0:545:d54:2ec6 with SMTP id 2adb3069b0e04-54838ee2884mr1658130e87.2.1740186417340;
        Fri, 21 Feb 2025 17:06:57 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54527b7961dsm2518317e87.46.2025.02.21.17.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 17:06:55 -0800 (PST)
Date: Sat, 22 Feb 2025 03:06:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/6] Bluetooth: qca: add Qualcomm WCN3950 BT/WiFi chip
 support
Message-ID: <3s36j75eoqszm5hiftia543h2a6nxaa74wubrr6nq4akzq4hta@wyuwa5onjauz>
References: <20250207-rb1-bt-v4-0-d810fc8c94a9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-rb1-bt-v4-0-d810fc8c94a9@linaro.org>

On Fri, Feb 07, 2025 at 10:41:14PM +0200, Dmitry Baryshkov wrote:
> Qualcomm Robotics RB1 platform uses a new member of the WCN39xx family
> of BT/WiFi chips. Add support for this member of the family and enable
> it to be used on the RB1 board.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Changes in v4:
> - Added empty line before status property (Konrad)
> - Reword Bluetooth commit message to follow linux-firmware changes
>   (cmnv13t.bin and cmnv13s.bin were merged).
> - Link to v3: https://lore.kernel.org/r/20250202-rb1-bt-v3-0-6797a4467ced@linaro.org
> 
> Changes in v3:
> - Mention new firmware files.
> - Link to v2: https://lore.kernel.org/r/20250201-rb1-bt-v2-0-fd44011749bb@linaro.org
> 
> Changes in v2:
> - Corrected QUP interconnects (Konrad)
> - Added /delete-property/ interrupts and an empty line before status
>   (Konrad)
> - Enabled downloading of different NVMs as required for v1.3 of the chip.
> - Link to v1: https://lore.kernel.org/r/20250201-rb1-bt-v1-0-ae896c4923d8@linaro.org
> 
> ---
> Dmitry Baryshkov (6):
>       dt-bindings: net: bluetooth: qualcomm: document WCN3950
>       Bluetooth: qca: simplify WCN399x NVM loading
>       Bluetooth: qca: add WCN3950 support

Gracious ping, these patches have been sent two weeks ago.

>       arm64: dts: qcom: qcm2290: fix (some) of QUP interconnects
>       arm64: dts: qcom: qcm2290: add UART3 device
>       arm64: dts: qcom: qrb2210-rb1: add Bluetooth support
> 
>  .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |  2 +
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi              | 31 +++++---
>  arch/arm64/boot/dts/qcom/qrb2210-rb1.dts           | 83 ++++++++++++++++++++++
>  drivers/bluetooth/btqca.c                          | 27 +++++--
>  drivers/bluetooth/btqca.h                          |  4 ++
>  drivers/bluetooth/hci_qca.c                        | 25 +++++++
>  6 files changed, 157 insertions(+), 15 deletions(-)
> ---
> base-commit: a1d1e1f2fae5fcb5f2e43b81afa9596c606e683d
> change-id: 20250201-rb1-bt-cec7a314991d
> 
> Best regards,
> -- 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
With best wishes
Dmitry

