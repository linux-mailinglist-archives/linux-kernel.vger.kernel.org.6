Return-Path: <linux-kernel+bounces-245860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 870AB92BA92
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B721F215FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D6415E5C0;
	Tue,  9 Jul 2024 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XNLCTR/F"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54EA16C866
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530355; cv=none; b=iCkBquAtMoOb5LVyVHJPsR6JLV/WogZVRy98BxBlxHxOqGNvHiG+Z9oRfSxEloAgfDVgCkhfB5aCpU/HgD1USNcmQJL6chVq0AErk7R0Cew3ircMCFhttFjd+4+KlHI1cGSWZ/uiPLP48NaymbnwYG39j8NhCq+xxFaWHZS1JCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530355; c=relaxed/simple;
	bh=y/kAQ0zrsn4Fn6QnpD2wQSaWn2gFgqCN+RBsS7/Zy4k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fq0oYOSPRNADcNlb4rep8VjJdKLwXfC4NpeZoljEZ2hA0XXQ1NZ1p2lwEmN1uodW3D0gVVUluj2VomPnb1kxEIOnaDSEbu73/6Z0nnV9I1ctNoh56+6dVBXaVpPsIypACXzT8vvmshkUf4PYPuTnMMhIikLyTZY+oPhop/eN5rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XNLCTR/F; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266182a9d7so18853265e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 06:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720530352; x=1721135152; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RNYTbjIMKVSDiH/xJuw3Zytc6A7ArsYi4rf3qcOyoPw=;
        b=XNLCTR/FZzUbD2u7b4eLs35BGwia0UB5jzBEzlWhrzhUmRPC6KzLaZvORkRcwSBj52
         7rbjf9UCnbfkD1Pu1zI4XV+a5mlZF5sf/6kcWmOrRgjuw7HUiYNtxD7TL1ar6aPJ3xk6
         odsn0VMH1Uc1oIjrkBtlloSPzO7tqV6xasr+GyiPRNjOQPQp/wjuo+7IOTuMWUbPH22h
         1V2cwcSHXrSad1BLGJg6Gas8yQwHDjpN7L1I8D6fqFwNU6X2D9JcLAR6N+c+4ruC3O6f
         4WOFG2UGdNC0Mu9swJWGJYJ2EEv+OEnPCC1skaYlnsIoRcVtDhY62XhmMMWmJ9ANTcse
         M5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720530352; x=1721135152;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNYTbjIMKVSDiH/xJuw3Zytc6A7ArsYi4rf3qcOyoPw=;
        b=LrVatXgt0dtlYIjRoqmIKmEEtJjwO/Uv/ySacRCN6+aXgF322zu6XnV4qijoDf1ED3
         S8tioOnQWZ9O6TkrO71RAx10A3auPPuR1leRv+44NqoWcEnO5kKs5atpViLkifATjZ3l
         LEAOlVl8Py6pNaiMy8L7YI+lS/dfpHVyYG3hHf0pzYVs6IUSi7BtGLLtb9ONE+x0F+cr
         yoeoTyV5qMlqxzE5C+ueqU09/5CXExDDNN7U4jZosvqHblPYqCBD+ABnqOUv0j++uVtS
         urQOu0HZfLRwmduWIPthCkgPJRbN4NjgC9hwzuGFUM/n6rg+fj1uQ+m2fTvUipSQDZtG
         XiyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5t8CyCHIhweDnHSG5fM42f5muY+9k1DJ6bTqruxamQYVqC9sHEnZrrGXClypNPj0Tx3onJliPOkbDHWfQGMjjBuMkdpI57U5CQ2eT
X-Gm-Message-State: AOJu0YxQB2KCwRWV6MFRY8OKmCI34boBAuwV99Kw/cq0Uttv2I9hFz6O
	3MGPGn5oCZyt3qBwF5/erbweYNemg7kB595g2P2fahbCB80QNe2OD6UjZmyGHkU=
X-Google-Smtp-Source: AGHT+IGsaR2SEoZuwYFEX2b7nxfECWW4MF8SmNYbk80FEK7DTzyDt3HJTX3f37ZEIT193q+ytjYC0g==
X-Received: by 2002:a05:600c:178f:b0:426:5f8f:51a4 with SMTP id 5b1f17b1804b1-426707d89e4mr16302355e9.12.1720530352023;
        Tue, 09 Jul 2024 06:05:52 -0700 (PDT)
Received: from [127.0.1.1] ([2a0d:e487:133f:fb1b:7fc5:f63a:ac6f:62c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f736939sm40812395e9.37.2024.07.09.06.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:05:51 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] drm/panel: add support for the BOE TV101WUM-LL2 DSI
 Display Panel
Date: Tue, 09 Jul 2024 15:05:43 +0200
Message-Id: <20240709-topic-sdm450-upstream-tbx605f-panel-v1-0-af473397835d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKc1jWYC/x3NwQrCMAyA4VcZORvIZqroq8gO3ZpqwHWlqTIYe
 3eLx+/y/zuYFBWDe7dDka+arqmhP3Uwv3x6CmpohoEGpivdsK5ZZ7SwsCP8ZKtF/IJ12i7kIma
 f5I2xPwfn4hSYGVopF4m6/S+P8Th+N/uTzXUAAAA=
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=892;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=y/kAQ0zrsn4Fn6QnpD2wQSaWn2gFgqCN+RBsS7/Zy4k=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmjTWq7u/vRFdMHqQR+TZnokI/grdUcCqWI2cfT
 H25cPhA1Z+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZo01qgAKCRB33NvayMhJ
 0WepEACBeuFsTRLqDMmX2eb/KI/eFXarGJKIihJqFEGfJ7B+D10dFVnA6KBs3qcf+5w2kS5j/2f
 9NJ+SMfE/P7jUDJ8sxb3SXQiCTIm2Y7hEIpqLfOl769d8rGOkmdVjaayw3Ll7JK2Xsd5/gTV4nP
 TIObSgUodofSrjd8/K3Bzp7Ax4pwzeB6Jl32BJKVfgMF76qlCE0YMMG7H1+LUh0XMOeEdTXK2B9
 b5Oy9TLfkBHsU8qhZEqSTcQ3J9aOVYaFnIue6ouybhCk1KTmsnFtfi+v0C4EUAwrYLn0peDTvLv
 ngMz1yBQudmSVaTBTuMbF1ht8ytISzbWmDNsSUYn9sMnAwd0jrrQukz/3n/BVVz8ToTMGjgTRtq
 EQZtqqdnWDUvojyjZZHp/7uQjfDKQrwD5vGdo2rVkSq2izNld88uR6glMknaf1p9cyoCCABde0V
 6BabSkH4CaMf0PO0wt3cAS1l0zCkRMkiqaNFJi4PS6Ywi04GqBtsXlLKnRGyqkDGYFyeeNmzPUG
 yIrw9qGe/ZHTvqV1veR1YnOmo47arg+cPj3lATL2wUEVcnM4GxpK+ZHz8KgcWH2Q879WLW/lXEk
 BBdLKNxCfjl56fXGiQq6ogeuJcuuN6rurfyGotbK138HRA6Kc77wNBHSpT8DXq3ZpwRXBT4+2xs
 2RK5jOLaVsJ8x8g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document and add support for the 1200x1920 BOE TV101WUM-LL2 DSI
Display Panel found in the Lenovo Smart Tab M10 tablet.
The controller powering the panel is unknown.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      dt-bindings: display: panel: document BOE TV101WUM-LL2 DSI Display Panel
      drm/panel: add BOE tv101wum-ll2 panel driver

 .../bindings/display/panel/boe,tv101wum-ll2.yaml   |  63 ++++++
 drivers/gpu/drm/panel/Kconfig                      |   9 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c     | 240 +++++++++++++++++++++
 4 files changed, 313 insertions(+)
---
base-commit: 97e1ea2dc264da85da53b6ae5726a130bef690a3
change-id: 20240709-topic-sdm450-upstream-tbx605f-panel-f13d55fbd444

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


