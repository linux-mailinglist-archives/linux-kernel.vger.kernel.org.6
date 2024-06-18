Return-Path: <linux-kernel+bounces-219466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5107F90D2EE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084CC1F21EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A700C15CD60;
	Tue, 18 Jun 2024 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="P7Bvzv8P"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F5A15D5DF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717471; cv=none; b=r7/8+fEH84L8VthfF2IRGPnIDbiW0GxU/P3R/W+vVrslzZxLhYAICSTa+j6lFjutnp2/lfk6DNiME/H9uHwmCV0R7ExKUQrwrHezhk29bPHf6QnaJtXUyfosnT3Fqcu8tzypxpH61zqV8cC057fqPi5NChzST98eftBE+A2zAaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717471; c=relaxed/simple;
	bh=9dL3D/FY2UQlJeFNSfOZwIBirUv1VOhd/HW8NFB4Hik=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e3KkZ/+c5uwkdsL5P6ikuhIHRx4K4Cxdkk4ie84OCrVWYoaHofaUoMnQNTDnKJOQ9qncIe71GwBQYgzxbhZBTQ77/lvG0ApDi0QbieJjuKnZsN/qNoishQFgyRT3S8IT1lmQrTxMdPw+ne/VK9Yd99PtK/0P8FsjWBjfmF4P1uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=P7Bvzv8P; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57c76497cefso6432837a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1718717466; x=1719322266; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MgII99Py7AejfkT5wEBcEQing1ENE+rjGC2Yt+MvufI=;
        b=P7Bvzv8PNGe9+6bUt3g+qbw0O612DzUGQSRIoZ1a/PoHivkFmEHPYPfP4yQL5SEcPM
         bPH8IhFeDPBpbjxGV/x/Wi8Fi7N0sZWJkqb0p9HWjMHzCA6csfgQYTo7oaPMQbdpmURx
         ssWLSoFheogVXIo5qVmOQoct70v5bVH1ZeR7mewgZO3CYzGC0TNAfS0S9iVKLZ5fc90E
         +2Jp26QPds9q7cSD6u2hLQgrGVE8c37I8fWeNrE9QbDGlZuy00nnxdV54BqPi2N0OpNI
         GG6Syl0NIzOnn1zqWprCHHCgMG3VIzEwFDQYv10q3R3FZqOpqfojzDj3/1LjMkadoTF7
         KrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718717466; x=1719322266;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgII99Py7AejfkT5wEBcEQing1ENE+rjGC2Yt+MvufI=;
        b=TvGbwQjfx8MWEZ9/F1v4hqAo8NCpwmRyaf71J80xORAhsS3abN4faukISQ80TEQnV9
         Sn1PXiRAt/E+yp2A9P7Zq346ROC925xdprjrqM5l1zhQndK53WUXR7IdmeEHJt0W47WS
         z1CfDEbY+UofXhOaSXNsOIGzxlycxrfj5oXKufCLLA0iKQcvMT400YSmA+Lcjmh+E/Sz
         oPAyo1LJ+pXC7ALqpfwQHBKly8wY7snPjVJJJZlKWpb21KBv2bbeTqg9P8oQh+0rf7or
         HXFOMBP/AEeJO8eQx1AiVMCKJvN3lzvqO82cREMamfwdj0QHC9z4+26Kk6kohcXj8DVP
         uVUw==
X-Forwarded-Encrypted: i=1; AJvYcCWJG4EvAS1gavi5FhL1tZydUzfn1w59nkRyYg28IppFAzM1p+VSPvbzPNR/oiUZ5F/7bhuQVwHkb0Sk98juUBkzsg+CCEdGwYbJ8wki
X-Gm-Message-State: AOJu0Yx0bGwPCnIvS1xfVcdIyi/AC5/cyXKoli9Ro+6jnxjeA/sa6o6Q
	qRtj0GZCtFpr/qhKeiVAa/da/6ki4BYL71K85zIORF/5knnA7cDSc4Mwfgr0hy+vuy5gBjLFHSN
	N
X-Google-Smtp-Source: AGHT+IHfSXaYJLdelb204AVXLxNCDDXv09yJDE8i/s7J2Hl0+SN5774Er0lO3roZCzYdJRKnKiCRpA==
X-Received: by 2002:a50:9b18:0:b0:57a:2e93:fe80 with SMTP id 4fb4d7f45d1cf-57cbd66349bmr7978378a12.18.1718717466497;
        Tue, 18 Jun 2024 06:31:06 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72ce12fsm7774862a12.7.2024.06.18.06.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:31:06 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/2] Name the regulators for QCM6490 Fairphone 5 &
 SHIFTphone 8
Date: Tue, 18 Jun 2024 15:30:53 +0200
Message-Id: <20240618-qcm6490-regulator-name-v1-0-69fa05e9f58e@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA2McWYC/x3MTQ5AMBBA4avIrE3SNv6vIhbFYBKKKSIRd9dYf
 ov3HvAkTB6q6AGhiz2vLkDHEXSTdSMh98FglElUpgvcuyVLSoVC4znbYxV0diFse6NsMeg8TzW
 EeBMa+P7HdfO+H4ZrX0hoAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Caleb Connolly <caleb@postmarketos.org>, 
 Alexander Martinz <amartinz@shiftphones.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.0

As per individual commit messages:

Without explicitly specifying names for the regulators they are named
based on the DeviceTree node name. This results in multiple regulators
with the same name, making debug prints and regulator_summary impossible
to reason about.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (2):
      arm64: dts: qcom: qcm6490-fairphone-fp5: Name the regulators
      arm64: dts: qcom: qcm6490-shift-otter: Name the regulators

 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 35 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts   | 35 ++++++++++++++++++++++
 2 files changed, 70 insertions(+)
---
base-commit: 76db4c64526c5e8ba0f56ad3d890dce8f9b00bbc
change-id: 20240618-qcm6490-regulator-name-bd20a8f17751

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


