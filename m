Return-Path: <linux-kernel+bounces-190155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB688CFA52
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABCF11F21831
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49692E40D;
	Mon, 27 May 2024 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z29yhp09"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5A010A0D
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716795937; cv=none; b=MoBwej0UhZgCiDxh7NCh7Xc/OhrEfCM064/SxiX5mcNh/Oc9QFgEb9+BjiQXQhXzQaoOsecb2LRMR/Z5Ke9dDoi/yDWLtwkE03wU59QnPF6SYJegHLWMLPHapKZyL81Et3YZcmEBy41d81Rb/QiyoDVO/Lpj/orKlDNakZZLvyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716795937; c=relaxed/simple;
	bh=L25LeAJvksa9NHLEzSxruzChrK53a1cBjhUfyi0GPpI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W1FsKck+Q7BGy+139jzWBhP3GQ3tc0WWR8JqT/U2iCqp/9CeLy+342muWhR3JGzh6YoNWHo//aeCwmQTGQ5x/PK7jIOtqbIxaFqxFNS2/iqVi26nVjxVWGDQDaaUkxfMVywXyUF+0oWthoXXP/pHsARTZPTCvRSt0SRboL6mOko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z29yhp09; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3588cb76276so399090f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716795934; x=1717400734; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r3W0IRzbYrdpGZO/IX0+cL20f8hz6Rtqdx3NFjQ6cU0=;
        b=Z29yhp09xiVc6+Lpj9OvByrDJjANJ4nF8Kx45ea4z4lOTl4FMNl3J4I67jFiqer8m6
         UYPeiSS4FDJ0Hc+8sn+fUxoJEJoEQFasrW6W4PGtYopUk1+KLu2UHns2rmVeftYGT0aH
         Cnxb+o22ezB14mPpfNduj6U/5lftZhrf6bQ3fn4JL9zsXMHqbVE9CW/ntuorlECGKNDl
         cR3SLgJC7K9AuTrlKzkGF4caX0IHKv7szpnkP0W4Q69QDSIWoYBbMD/ejlX8L/QcpHNR
         7sKJdN4EzgW0KPWYu8PaadkvO5rIHBclW6LBY2ppIEvruK1sfLh8N99lsrZUiGMLzYy9
         Bdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716795934; x=1717400734;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3W0IRzbYrdpGZO/IX0+cL20f8hz6Rtqdx3NFjQ6cU0=;
        b=YojUnDNYnufZy9HBuuEukdAOY8pZZutjP0pEqOsDifvwvZF2fglfULdWwUB/60RSPN
         zLwWN2H2YxlNws59JM8Qa7Us2WwOA8CNH9nF4uQ6EGyYL+s3NbO/M8FaUzaqxZ3aQHg9
         05ZIvj1GTm7idoElVMj6GV2+OrcdnZD/ScibC3WJoxrkXgk94ZV4RI8yYDaqN4BghYLK
         2h4bOUq2xfhzsy2Gv/hvJKz4RbdfiuIcHjoX3TuakuuoRPXBZHYa/i6CnIDKqqh9kRlU
         6Viz96e75IqyzaZip3UH0sJobcqFoWHEU7IAAF+QXiM+BamfIWJHA7zHGFennorPOdyI
         Al6w==
X-Forwarded-Encrypted: i=1; AJvYcCWKwpVA4sV7qdHILQKCAYP76a/EgvZ0G2/qO79GT2Nx1YIvDUzZgZWD2eUcNPKLXqHsrUhTPXPVMaqc/tIJr0EpNMZqqYRkP3MpB18K
X-Gm-Message-State: AOJu0YxqoGuicOeVMG9kKJwN6vG/DwA++f8KZzI6fhIbGvEp7gq6hwH8
	Zew7PIyxUruf84RLfbuBUuY2MudGWRgKiCLkRkiXJko6baEQmqcQzyraVjypLRZ2RN/tfHU4fxO
	8uUA=
X-Google-Smtp-Source: AGHT+IEewCQaS2JXdMuRvuS5ujtjvCFY3WzcrznMhPgggMKCeN4AQiw2HzeSuItoWxarSft/mG7ZXg==
X-Received: by 2002:adf:db49:0:b0:34c:600b:b016 with SMTP id ffacd0b85a97d-35506dc5898mr7269721f8f.27.1716795933614;
        Mon, 27 May 2024 00:45:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7d96fsm8293353f8f.12.2024.05.27.00.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:45:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] usb: typec-mux: broadcast typec state to next mux for
 ptn36502 & nb7vpq904m retimers
Date: Mon, 27 May 2024 09:45:28 +0200
Message-Id: <20240527-topic-sm8x50-upstream-retimer-broadcast-mode-v1-0-79ec91381aba@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABg6VGYC/x3NQQ7CIBBA0as0s3YSRCmNVzEuKEx1FhQyg6ZJ0
 7uXuHyb/3dQEiaFx7CD0I+Vy9pxvQwQP2F9E3LqBmvs3TjrsZXKETVPmzP4rdqEQkahxpkEZyk
 hxaANc0mEfnTW+HEK8bZAT1ahhbf/7vk6jhMC9fVpfgAAAA==
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=L25LeAJvksa9NHLEzSxruzChrK53a1cBjhUfyi0GPpI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmVDobN1E65KFEsCOFpO948mxbN9rt74AlIlIzWnLp
 /r7tDV2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZlQ6GwAKCRB33NvayMhJ0eemEA
 CjdAr8cskG36GuOGrPp/Z5zZ3qN3RkJjH27XcPdWxw/+LKZNoSpyD2nxSDXXgIHn2mEPAOwNUy5dO1
 LPoGPM8xdng3JK7/dt++JVHJLPR4EH4gw827tWHsFTf6y6GIiZhPqQZcsSdQ+N8Y/4bp/6SUORE2Uo
 eYMebd1p8JX23qUfDJ/LKh42iB2fJF06wDCuuoCipDYvrUnmRCGHkGMhrProSsm65E5olPIj9GR/wL
 djUx+2E0xvjHN/SXy9Oz1NAelstFXvBFoLtLiLXH2QwAWWDkoWrzemJcxBWldqvjq7xL+d/y6kIYhp
 G4pavDoPm1aSoLa7lz/eX1ejryvkkS1kSssb0jao+CVaAnmyxuM96hA2eWEv6+mQg43bXR9HvIaNSr
 q3vhbOnnvmp24+cDIhCqtdWMKw8NRGp3cd9q6cHUNqAYx8DnFJyw5VwOCI+UYCWCGlZ2GRKhpYPOOG
 WUf2gwttxXMzpWHlViZN8yLpKeO4hMMgLkx9KKyZNAkpaF3NxbI3IfG4jtUG47maMPt5dXVtsckR5W
 jO+ysITtwnIXD8yz7SEuFaRNK2fd+zf1PMNNqyHewD4ZKU7QWlMOb/A+SUsC0jwNWDteGJPZ/JY8hb
 x5UVZyq2LDlzPdgylzV+rEGbai0fRhpXYG5PRHucYqWcWsW4foII+mODNJQA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

In the Type-C graph, a retimer is usually in between the USB-C
connector and the USB3/DP combo PHY, and this PHY also requires the
USB-C mode events to properly set-up the SuperSpeed Lanes functions
to setup USB3-only, USB3 + DP Altmode or DP Altmode only on the 4 lanes.

Update the nb7vpq904m & ptn36502 retimers to get an optional type-c mux
on the next endpoint, and broadcast the received mode to it.

This makes it possible to support 4-lanes DP altmode on Qualcomm platforms.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      usb: typec-mux: ptn36502: broadcast typec state to next mux
      usb: typec-mux: nb7vpq904m: broadcast typec state to next mux

 drivers/usb/typec/mux/nb7vpq904m.c | 29 +++++++++++++++++++++++++++--
 drivers/usb/typec/mux/ptn36502.c   | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 57 insertions(+), 5 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240527-topic-sm8x50-upstream-retimer-broadcast-mode-76520768ac3f

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


