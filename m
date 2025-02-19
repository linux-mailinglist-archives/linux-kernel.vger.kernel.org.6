Return-Path: <linux-kernel+bounces-521420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A06EA3BD0C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 452027A66DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F731DF737;
	Wed, 19 Feb 2025 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q5kQ4XCM"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A101DDA3B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965014; cv=none; b=a1/vQ/0AVPol7Bg0XhaoOeIy8Ju+A46XT6W9hM0foDwSUEiQmb5SURfEO23B/gClyQA97an6Pp42hfiSnRmpbKo9BvjM38bkw6K9rPS7MOZof0F2Dr/5+n7CNT7DuOFPdQuspr8rFKsSyRjcPSw4H7SAbYx78HrmJP/kJBPuHQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965014; c=relaxed/simple;
	bh=iZrgBM//167wPR0zsBWkWKvKI/i6DaxXBXDrsaYFLII=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Zbn+OydQUlIeC2sOjEWHRfKAy5w/Zwh1V1Dq9dEi1XD8Y91TQS7ex6SJgQ9f78EjU9Oiu2cY2ze3D1gcv+lsw4aT2Xgo2a2QaMTZNKjYcaSvP6oVZkS449ss3AWpxujOpxGde1t020DCrgpeF1zgD4x5VqOi392B94t/YXj0Nys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q5kQ4XCM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4398e839cd4so4379195e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739965010; x=1740569810; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l3hrqKpucUA63MqyDzmKkOY4RhGhYMWg+g6q4LxLXOk=;
        b=q5kQ4XCMJBSOKmtODBnxa58O0fWiFeYNyRsiNwLo4kn6XmWg1SVNnmdixw+N9tMMPL
         8uTfX+xpjGHqLlPQYTZIoVaQUP+z7yVB6AoNxJjLadSspoak3qmKZqi0g2swVV4NykV2
         6XcKmb/b4s5IG7DVACjn/u115N7fN+tRtw4GzTwYJ2nT9iu5sjESuNKxV3xP96/W7MFA
         REFgRwaOQwtns7/EyAZkcgzRe6hiXaE8TGTkpRAcVJFG5o2w+cmntt8iYfRKIsIXidnJ
         fYMjfNTpHMphbgjvPMGpm6JbYoZTEMEvPQ5bdjVxUEAHC7+Wq6Ns+jLKSTm/C09W2PlW
         UG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739965010; x=1740569810;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3hrqKpucUA63MqyDzmKkOY4RhGhYMWg+g6q4LxLXOk=;
        b=RvCFdCCO2kVFW0j555VZz3rAMbbbnc5HUyhvNn/oFmsFravFehEdrhF4I1pgpWKWR7
         jSXwrHap1bWtgFCXXMwT8INRGsUw5k1KL0tXcu3gify0CZm896YXVaNTsx0pdFTqry5a
         MuLvCndhmPG6LH9tpM/PTFH5K0MB+WMdjXxltafvU4sNawDSK0CN/i9Rspik3clL7zkJ
         ZZqxmL6vTv0cgWJi1rPGFhMm/ZOGwuqVfp6JUUT5K47ZeibvGNJ3HW9Sb663gpXzDgTL
         haV0kWAw9W5i2M9cs9Ebt3KovdnhhdiTtXvCie/rBm28KM3k/SeMkbAVKo8JPp6qn+FU
         i6Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUekTmsbqFK+yQQ9Z0dRpJ7WKGjEeDgrfebWzlRzchvyUKz3VEPCEYY/T6vzEOdSVFMOBmAkXySoyQtG1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUWCcRBHv4n+Q91aandYBEDI40pU5lNiXTbzmMZMXKe9+X1gav
	xuHuJGCz+qLBWTh2qQ0U3EO8sNGpontd89LphwHFX+tvgnRM/A7XVg+ILhN1lB0=
X-Gm-Gg: ASbGncuAYOp6fpjLKISTv5pWvJoqrnjYF7Ciurh6HK/JPlD5GQytJ8y6kgVUvLAHnaN
	FJoR/eyULs7a7VpfgLAYP8gxN2a0yS9lk6otwCIH2vh21xiIKXPqQj5hCslWnkmstz41wgXnNPn
	/J2yD+Bfdf+5Esx93gXOQwsgDXmNM/vkYY5rVZefmJqAXtFC22LYlCZcTsLfnuD3tecFO5Jyyk0
	xiiFaWc+3P5LwS8jc5RTXy2qMNIvbxvRqUTObrix41IF+B2ZiRXBbtfR8468qthgaXKtL/wFYiQ
	fAq+x2pvjF2ZBB/jdqbwYtUYO1ID6A==
X-Google-Smtp-Source: AGHT+IGFzF5HoEkc5QW9xKy8r+v6LMQ5QmeA1OFi3LefcjtgsIdfpa9GKpxun66J9kkK0Rwa0bOljw==
X-Received: by 2002:a05:600c:6d4a:b0:439:5d00:e78f with SMTP id 5b1f17b1804b1-43999b7ec7emr30047155e9.11.1739965009642;
        Wed, 19 Feb 2025 03:36:49 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:8630:e1af:c2ac:8a22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399600257asm42437905e9.4.2025.02.19.03.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 03:36:49 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH 0/4] arm64: dts: qcom: x1e80100: Fix thermal trip points
Date: Wed, 19 Feb 2025 12:36:17 +0100
Message-Id: <20250219-x1e80100-thermal-fixes-v1-0-d110e44ac3f9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADHCtWcC/x3LSwqAMAxF0a1IxgbSqljcijgQ+9SAP1oRQdy7x
 eHhch+KCIpITfZQwKVR9y3B5BkNc79NYPXJZMVWYo3j28CJEeFzRlj7hUe9EbmuSy/Oo0QxUJq
 PgD+kt+3e9wPE0mWDaAAAAA==
X-Change-ID: 20250218-x1e80100-thermal-fixes-774d08de4e3c
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Akhil P Oommen <quic_akhilpo@quicinc.com>, Johan Hovold <johan@kernel.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2

There are some mistakes in the thermal trip points currently used on
X1E80100. Several of the critical trip points are too high, so the hardware
will trigger an emergency reset before the kernel has the chance to
shutdown cleanly. We're also missing GPU cooling in the device tree, which
prevents running certain GPU-intensive applications without reaching the
critical shutdown temperatures. The CPU on the other hand throttles itself
automatically, so we can just drop the passive trip points there.

This series addresses these problems. It's quite similar to Neil's thermal
zone rework for SM8650 [1], which provides some extra background on the
mechanisms behind the throttling.

[1]: https://lore.kernel.org/linux-arm-msm/20250203-topic-sm8650-thermal-cpu-idle-v4-0-65e35f307301@linaro.org/T/

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Stephan Gerhold (4):
      arm64: dts: qcom: x1e80100: Fix video thermal zone
      arm64: dts: qcom: x1e80100: Apply consistent critical thermal shutdown
      arm64: dts: qcom: x1e80100: Add GPU cooling
      arm64: dts: qcom: x1e80100: Drop unused passive thermal trip points for CPU

 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 679 ++++++++-------------------------
 1 file changed, 160 insertions(+), 519 deletions(-)
---
base-commit: c177fed7617d6306541305e93e575c0c01600ff0
change-id: 20250218-x1e80100-thermal-fixes-774d08de4e3c

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


