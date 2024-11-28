Return-Path: <linux-kernel+bounces-424686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA5B9DB80F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D931B280F98
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF7F1A00F0;
	Thu, 28 Nov 2024 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k7+e5P8A"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAC81494B0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798660; cv=none; b=tWVfav03C644uslUzio2BUBKjnlLae0h9ehUcJcC4rKmJ7FuYhiTlOf/rn94Qd44WsXu9ZxK+ujFhBE4ckfIcLcxVRZfK7Ynu4wv8x7TGlMraoFrpCiSFTpBGO65mLfgp9W/Jh5XCSIZS/TF02q37QL0zkGYjivjvSQ/n8BjRy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798660; c=relaxed/simple;
	bh=TES8Wi12UE3TlsFyqRY9CW1oUL36H+zyEy+z8lBJnAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufE40AuwHaAYM/MsQi2YgkBhEXFtSc/J+StMpLes/iKeWPrJZSXeoLumMr/RFWqMzInQwI05MmdfBVIzT6mJwbHGzWkxFymK6s9dc7pdhV28mcnT9yErAVGbSJhUWXzsWtqFP/ChL72BUtpynF8cjysqNiV0aCmVDIIptxbwXBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k7+e5P8A; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53df1e063d8so915761e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732798657; x=1733403457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qki2u+kwWDyi8TzZ2JdL7JQpuZVyny19681QMuSukyk=;
        b=k7+e5P8AKm4JDSXdjb3PhsT5UWVR6wrTgsL6Wh7qMip/mlgbv5+2OWNVhcMD7+CbUG
         qpoTi3snJQjBmKW0/PRgvRdK/V2sf38IaWFqdU+S+HfUIKq9MiXmISiNUGKNrgkY3Fuk
         K8qOVR88EywD/WikaMO2nHeWFGHPhZvuhJBHfyxX1f625lqcM4NLbCDw5sUmngtQeLFr
         i5/n6Q6dXZTXth9hrv7c4ALZAb/No0D+2vfJwqxu9/X6cCPW3KmXiZfPeg4wRsbeJwdN
         FGo61IsYtxQMtiM2tMhn6gVyEefqSvsnM81X7wAH1vnk4d6AFkFzjsyicHuM2MlTCqWZ
         xQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732798657; x=1733403457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qki2u+kwWDyi8TzZ2JdL7JQpuZVyny19681QMuSukyk=;
        b=KsxdXbgr6sqhsDd9UmmfDpw981o5mGGAkZNfbZqyA0Rybxb0p+Z0zEj8L+Sb+JJeqN
         orVN/F1cwuT6Nvw0koS+zg8KntSPXsLsivmSqR9ckWmY7uGvioIWBRcWYXOgTsd3hB97
         FCJt+easeR1AIMAhLc/+p+Kwoud9T7A1jZXINby5IfnDuMhBw2aOhHjGgKhC+avjOJ3K
         /t48gbEWuQ1TiVHdzMTA7LGZypIfm491PcpTyJabqU8Y99YWc8duRB2OckIkbUqm6vRg
         ur4+aV7vxaa4eAPbrIdoLZf249pO11D2nzBCMNqYg8q5waIRRMpWTYKSEIVIA/Xz6Heo
         SbFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk19qifL/M5GnPBsR3FVhWxJ2PSeNZ12/3Y+SxqBgHwk5vxuKkoZtAWfyt7pJgxIhlyKj64LZylb11sZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7PCTUSN1w9QC2IqQwSfe5N5yXkaxixHCzpB7v94p3GWxGTMQ2
	NmTvluf8Kvpvdn5KnhnKGvy3ew2QiLrDkRaoHsubLYFY9lNmi30CC135mWBnD7o=
X-Gm-Gg: ASbGncsgLtlzIJYadgF4IH3Pvli1JW9KLmvMcFJl2fzPndl2y8aZwig88U1/OvDLBzE
	xuf9ZEFK1RQOmhZO7c1RoOKwHqzFgCRXVp35ZWL5okB4W2Me5rl4yxKDNkK0E5EGySzI6MfRC+n
	fhJFJsxOTe+Mql+zv4ykyKLm+ZifdJxLz8DXUi139p5MZd++YzkUaqKsmP3jAQz5A/XCqoIuytT
	S1WZIYApvlaW/kZ0BM7LmjJX6CN4a+AwdJNRSVOyEHu1k5ZogJDYQ6izFi7fNMxuimDGbhDlv3H
	IOyoHGFHCSIgMuallWL5kTgrw/eJpA==
X-Google-Smtp-Source: AGHT+IECIQcECexv3ZWrGXtrg2eYyzQpDGCf9tAuxX5po1WqGjNDN92Z3qKgjKOHRVwveciwYoFhsQ==
X-Received: by 2002:a05:6512:3d1f:b0:53d:e52e:9176 with SMTP id 2adb3069b0e04-53df01122f0mr4059032e87.57.1732798657052;
        Thu, 28 Nov 2024 04:57:37 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df643149asm175922e87.37.2024.11.28.04.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 04:57:35 -0800 (PST)
Date: Thu, 28 Nov 2024 14:57:33 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_bt@quicinc.com
Subject: Re: [PATCH v1 0/3] bluetooth: qca: Add QCA6698 Bluetooth chip
Message-ID: <2qhdqirb6yin3fro6kckqwrbexmi6j5gwl4qfntgo6ctcfc3jj@727464znj2r6>
References: <20241128120922.3518582-1-quic_chejiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128120922.3518582-1-quic_chejiang@quicinc.com>

On Thu, Nov 28, 2024 at 08:09:19PM +0800, Cheng Jiang wrote:
> QCA6698 chipset shares the same IP core as the WCN6855. However,
> it has different RF components and RAM sizes, so new firmware
> is needed.
> 
> This change allows driver to distinguish it from the WCN6855
> and load the specific firmware. As the RF performance of
> QCA6698 chip from different foundries may vary. Therefore use
> different NVM to configure them based on board ID.
> 
> Cheng Jiang (3):
>   arm64: dts: qcom: sa8775p-ride: Change the BT node
>   dt-bindings: net: Add QCA6698 Bluetooth
>   Bluetooth: btqca: Add QCA6698 support

Order is totally incorrect:
- dt bindings
- driver changes
- DTS

> 
>  .../net/bluetooth/qualcomm-bluetooth.yaml     |  2 +
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi    |  2 +-
>  drivers/bluetooth/btqca.c                     | 47 ++++++++++++++++++-
>  drivers/bluetooth/btqca.h                     |  1 +
>  drivers/bluetooth/hci_qca.c                   | 36 +++++++++++++-
>  5 files changed, 84 insertions(+), 4 deletions(-)
> 
> 
> base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
> --
> 2.25.1
> 

-- 
With best wishes
Dmitry

