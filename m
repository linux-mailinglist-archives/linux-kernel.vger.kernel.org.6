Return-Path: <linux-kernel+bounces-280574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F18694CC4E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB61FB2225A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E71A18DF90;
	Fri,  9 Aug 2024 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="vZcAWGpi"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C60C161314
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192453; cv=none; b=DfWXlHUoV2RMsw1dzvkufWgyjsFb7EwPy+KzxwY8KW8A58OyBnVfaO5O5+cHqc0dL10uxJMfNm/Iq9+hNYVkgmMfB5Dj891GBZBucVHSwTknRciwV+M2YOiLkhBVsVFKOemLCF5VoxwdTR7NJfrxdvxfyllgjEwfMGXq+POQztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192453; c=relaxed/simple;
	bh=AYpUK+lsd5PQ6SJlU43+rLfSAt/aIyQe9U7/8RSvafE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aouT2H+ReNR1tAPRhwhJDba/Mu91IdfKqBfBza/pD8sfbfqsmD4EbvgikSEQ6kHh1YC5ehgtYmuAdzkjlMvxV7ovRhruCMR7lhoB+Cr5kOjiN6HpVE2yQBEeLsabDPcUI2EDnY0M1TuqaiM34bP+03sqaLyqM091TpzBQTX7ljs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=vZcAWGpi; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6117aso721240a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 01:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1723192450; x=1723797250; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hzfw/96lJb4bQMm0DPGLtxg5MZTXy4gKlDaf+3Ud31A=;
        b=vZcAWGpiM81IUctCARvc+qcwMX3DTFi0ygcqF355ho+DlnGd2u3QTuru4mSggp+/nj
         9B1SyY7bVS96dwByhz7tlNmkBguR4OnhUM2F5vfM5x09MnPcdAQA06jtiFrkmWkLEFXC
         OaueYBbcj8/vqVBqkRM/ZoxPDy5g3SRkXyUiTnPc5nNO76ltSxhER/f/gCVKXE4hW8Vx
         m3AW7ozKPK9fAoVy/c+xfsuHclzOKE1JOriqEZyevP145rodpIX9wHBakkuNRyZkeIhC
         5a43RpUac7WXTJ6GbZ5cLFW5nSyjNgzfFhXnl304e093h0NDfByEX1aQ6ZB/5OHNEBgJ
         UBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723192450; x=1723797250;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hzfw/96lJb4bQMm0DPGLtxg5MZTXy4gKlDaf+3Ud31A=;
        b=lSexSav8nDhklw2pVP80HObrRVZ0Z2ipDs3iWOTes1uThh6m+EvUxTVMLfduSmMvs/
         1yCvdhUkS+ArlmG0BlN1fCYCvhHSh0ifojK0ysYAWu3fxkSZ9/eYaMAXOZwGLWoVIXFs
         iDP4Z0bkUPcSxqUI8lLjb5K3+MXy2CgRjTVEng/f07ocQqXtKBLbEP17TB7pI3iEmwl4
         WcDz77fm759We/D8J112QYkh4wtenNshOIn/rUMd85VxUJbB0DBUsQEdB6rfuTQ1cvKI
         fTWy9n8k8E0mEHGrypd5YXhaGLdRRheSwJex57jjQODEL4731vvR/WkDFEJ4BEHo3mZG
         KaEg==
X-Forwarded-Encrypted: i=1; AJvYcCVLdpfLApMeVh36FFzC2dhxygWrwU8B/AitdiB73SriBBwTnZbCI1K9SffZkcTMZbF21pADyDSOC08eOYOin/KElQepSY7GVvHHiSph
X-Gm-Message-State: AOJu0Yz9BvXJYyjkMWW7HXagefYyq7rKWKnxGxadBiZ5IhUIoLhBvpWx
	6sNbHljOZa+4+pzL+8yYcqx3YT3HZdNEkLHov2CHtJ+T3WaCS5+u/uFwBEMrvpc=
X-Google-Smtp-Source: AGHT+IHunt1rt24Z66zT/GRjyNQR/iZlMfySgAZmzArvUQ0sChkXB8EfaUarNZjHNUHUBwjWkQ08Lw==
X-Received: by 2002:a05:6402:13d1:b0:5a1:f9bc:7f13 with SMTP id 4fb4d7f45d1cf-5bd0a577dbdmr755422a12.22.1723192450418;
        Fri, 09 Aug 2024 01:34:10 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c41916sm1336288a12.41.2024.08.09.01.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 01:34:10 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/3] Add DisplayPort sound support for Fairphone 5
 smartphone
Date: Fri, 09 Aug 2024 10:33:56 +0200
Message-Id: <20240809-fp5-dp-sound-v1-0-d7ba2c24f6b9@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHTUtWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwNL3bQCU92UAt3i/NK8FN0kY3MzizRjA0PLpBQloJaCotS0zAqwcdG
 xtbUALdDLb14AAAA=
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.1

Add the necessary sound card bits and some dts additions to enable sound
over DisplayPort-over-USB-C, e.g. to a connected TV or monitor.

The UCM files can be found here:
https://gitlab.com/postmarketOS/pmaports/-/tree/master/device/testing/device-fairphone-fp5/ucm

Two extra notes:

1. I don't quite understand whether the sound driver should have
   SoC-specific compatible or device-specific compatible. Some earlier
   patches by another author for a QCM6490 board and a QCS6490 board use
   device-specific compatible - but from what I can tell this is not how
   it's generally done for other sound drivers?

2. Unfortunately DisplayPort enablement itself for Fairphone 5 is not
   upstream yet. This is blocked by DSI display bringup upstream which
   is blocked by DSC 1:1:1 not being supported upstream yet and just
   working with a hacky patch. Nevertheless, DisplayPort audio was
   validated working with no additional sound-related changes so once
   DisplayPort gets enabled, sound should also just work upstream.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (3):
      ASoC: dt-bindings: qcom,sm8250: Add generic QCM6490 sound card
      ASoC: qcom: sc8280xp: Add support for generic QCM6490
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add DisplayPort sound support

 .../devicetree/bindings/sound/qcom,sm8250.yaml     |  1 +
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 37 ++++++++++++++++++++++
 sound/soc/qcom/sc8280xp.c                          |  1 +
 3 files changed, 39 insertions(+)
---
base-commit: 6cdb38a56eaf615abc60fbeec0e4ccbdf93468e3
change-id: 20240809-fp5-dp-sound-b3768f3019bd

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


