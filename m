Return-Path: <linux-kernel+bounces-226807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693AC914431
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22753282F04
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2134965C;
	Mon, 24 Jun 2024 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PU88W3z1"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E221F93E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216362; cv=none; b=bD/nSK4gyeXmlPtybmVx+xPu7wxtnsLEGntX3lVEl1YUNmLQQro1XXq7uC2VgpvirvtoRuDuTNf9QJ7XOtLlZQ4JhAS7QEDcX3+7Gh81wOMEzC+knGJLgQ4h8i7VZ2PdiwPjg1zPf1uD5425ULFLZYRKv9c5twtWWA8D6INWQ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216362; c=relaxed/simple;
	bh=fROqvB+Ad/dr3e9qH35hLJWAl9z4Z2lzPyO6crozWGg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Uqt2gzKCEHUDr3LouWUyfUSWNJXrtIsUQE9GXTdTtHcuMglI72ULq3PKLQagx5YBRm4AB99AoipxJW6tJAXgAmFn0envPH6/HW2gzlcVVSEDoJRNGtSn83DnKjZAxdFi9H2FR4N2bphH10JbVdLcpnfLfSb8QvHba3hXGL+6enU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PU88W3z1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3632a6437d7so2284610f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719216358; x=1719821158; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=odzDRTU41Zr89t9SLoKeOkPoH6J2FAkixD8virEXbx4=;
        b=PU88W3z1uEX/C5c0DJ6MrdWLpB8Tw55Tj2WgGOA/2qG6lsb7M64lCFIJ20jZapsXX+
         wSxbN25JXAl2B8wt9dD0l8yP3mtrbTLqiSVGSyWR3WkU9x4gWavV5X+HWGz7S/5iZbs0
         OLmiPDsqis8jMJRcNWn9YZfDVGH8fv4w2lMyArIoEip7Mz1kbAIrw2klESEDPOXjTgcZ
         V+dF8l1aBeLxRt/wWbU6TIEnUaAH94kh5SGxVI5kyY5uT4BJPG0tRtv8B1UINOqVBykD
         n62d3LaZkAPVV/3ouSTgVB+Dh55JHJz6H2+2iGVzdHu/pKxKSy/ekTOo05cDl1VWpOo/
         LiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719216358; x=1719821158;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odzDRTU41Zr89t9SLoKeOkPoH6J2FAkixD8virEXbx4=;
        b=J12r+yRhaTBBNyKZvRRyQwGPb5h971Nt1mKf/6KYinKFMxiV1JqtfFl4ezzMtNKYfi
         F+1vm7Es942WxCsHXjysAtdeeBWZW7HnX6Y24xQqaN24YgvSrao82ujPF1yTNtV/dO0Z
         d8aF7YHSvkvU05P/ZR66rrNb5WdmTIhW0BES9cL0DCoxxRfqC8nEMRPSSVptlRInFkfo
         m1UmL2w7nkrZoLnoBxa+mmSUcYUN4Tgz6x7XZgWIBDEHt9eJWh/elxeT6lYtxJn4XnJx
         ll3Hb/L6AhNrFA1PvrfkOiN4j+TT+H6W3FcZG7+U2kZwhGNHqgL2HB6N7U1UnKPL8Ps+
         Ldog==
X-Forwarded-Encrypted: i=1; AJvYcCXe9SPW/9BRgTudEHwfBkAbdrFY8kNqwVsvBDxz4tpfr0Xr4E7Ugmoq5g5QotARgwMuu2eguxZXLbnaWu/s2mZEM/U23dtjidyEYm4N
X-Gm-Message-State: AOJu0Yzu0iXzh+I2jwNEdnsbp+XRV3WBgQbjzlr1zXEZx9tkFGzseEpS
	JaYVVaHDDumZWvbpWrAr6/mWhZ2cpcnGGShNuSmA7tq9cOlpbjcVT2VU4isFayI=
X-Google-Smtp-Source: AGHT+IGVnrS9IFTkUf5iQxnTJvMhFKWWjlFoG1vmOIjQd2oqxf/RQpUp7yIejwA3PnMQ3A9mBW7nQQ==
X-Received: by 2002:a05:6000:1a8c:b0:363:776:821b with SMTP id ffacd0b85a97d-366e31bc9f4mr5357152f8f.0.1719216357797;
        Mon, 24 Jun 2024 01:05:57 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c8b27sm9280284f8f.104.2024.06.24.01.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:05:57 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/3] clk: qcom: dispcc-sm8650: round of fixes
Date: Mon, 24 Jun 2024 10:05:49 +0200
Message-Id: <20240624-topic-sm8650-upstream-fix-dispcc-v2-0-ddaa13f3b207@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN0oeWYC/5WNQQ6CMBBFr0K6dkxbEKgr72FY1GmBSYQ2HSQaw
 t2t3MDl+z95bxPsE3kW12ITya/EFOYM+lQIHO08eCCXWWipK1lrBUuIhMBTW18kvCIvydsJenq
 DI46IYJUxlSxblLIUWROTz++RuHeZR+IlpM9RXNVv/UO+KpDQPLRpnDM9oro9abYpnEMaRLfv+
 xelPG+g0QAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=fROqvB+Ad/dr3e9qH35hLJWAl9z4Z2lzPyO6crozWGg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmeSji622feuGnejMViAuO0ml63MAo/iS2It7g0EpP
 J8dkTqaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnko4gAKCRB33NvayMhJ0W5HD/
 4i2AzY1GczoM93DAhbkb2LNUpHRWWU950qeHoXS20r2k+oRX2MO+gBw4WQEmbBJwHbaxBpKeSzzWcM
 RglN9DpLFZ7S/Pk11+ljtxsfRmQWNEtzXH9kbCiX5szJ0g8MKViiWgFVb5Ss+yxRTVj8GGOgWXD7wi
 YS14KP1KpHghPZNT1ee+o6jqavYVwwZsvfEEskzVmIBTciYW2AM5fBKcdaduAk3FXuKx4Ut4/rxJVY
 Cf9czwg4eyfNLT/+01MMrRg4CMuIGXqWQ4SRDe6XAQXWVLqMGXD8RBeBP7BDnCt/kXKNEDzDLatYFc
 ymIwMnCAXxZ+PPt0Xc6rrQmQmHu6FMrn5h15332qBcerWjnQZLRksCkuktVeafQ/INHiJOvnLR9CKj
 HiGIPhUebYQFuqLiXkznHLo3VZwXC0IWaY8YkOe/QXC5yKEKGkI1tVAYtliaHOcz+0CVpfxFTHdKXY
 cpk/waCtRhg7TjOEUwIXbDBem6H+YUdn8zDV4bo5cjLacSnd7i5Nx5B4podhpYorYAKx4WAXDd3hvb
 xUjWUVMPyXN70xY3KQDJ/tHi/r+C16pjgLk3tNFIb5lq7ET5qGUUKVIhT8VuajcR/CH1IJIw57BW9N
 Q+JtGNz/CAvekpMr5C1ZnDASeZIwLh1bpoKcThBe3FyrMXCY4s8Vh+yP60mw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

While trying to fix a crash when display is started late in the
boot process, I ran on multiple issues with the DISPCC clock
definitions that needed some fixups.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Squashed patch 2 into patch 1
- Dropped shared_ops to disp_cc_sleep_clk_src & disp_cc_xo_clk_src as Taniya recommends
- Dropped patch 3
- Removed  wait_val fields updates from GDSC, this requires a larger solution
- Link to v1: https://lore.kernel.org/r/20240621-topic-sm8650-upstream-fix-dispcc-v1-0-7b297dd9fcc1@linaro.org

---
Neil Armstrong (3):
      clk: qcom: dispcc-sm8650: Park RCG's clk source at XO during disable
      clk: qcom: dispcc-sm8650: add missing CLK_SET_RATE_PARENT flag
      clk: qcom: dispcc-sm8650: Update the GDSC flags

 drivers/clk/qcom/dispcc-sm8650.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)
---
base-commit: b992b79ca8bc336fa8e2c80990b5af80ed8f36fd
change-id: 20240621-topic-sm8650-upstream-fix-dispcc-a1994038c003

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


