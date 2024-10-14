Return-Path: <linux-kernel+bounces-364277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B35E99D00E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF0A1C22FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59101B4F2E;
	Mon, 14 Oct 2024 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m7lcTqyF"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492F31B4F07
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917915; cv=none; b=BTtaXuX563+WePAw04aYLnIcR33siiCx+tB+fZiKnPdtSeN/RpkEBqVZ5RQYhxeO5MwWcJTPN0TTUCXK3WYv8OW1WLbaOHsw8soO503LSfAJh+Recg1yZov/lcyE5QlphJpRU0L+4uil6B1WHdnHgU8EGsuG8GztXzqLMQqU3wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917915; c=relaxed/simple;
	bh=JRZ44OBgoYCaaa1ufOrPbwGLSAjE/5hwJtri2e3BNE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QHcG28DlTt0RRsOLATuPCvk65u+1PCmNe3kY1u9rlsDLGrxkwk1gRep59uL7OzVjf1rS2ud3AGnH0Mb7A3+tzNvXlaQ0omDHPTDcbqMVcjACXCN83TICFtN9kdngk33hInb+qWcF2vGuaIJeFSLxpHnoVXCHU+MMAEYYRfBydAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m7lcTqyF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43116f8a3c9so49487805e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728917911; x=1729522711; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YKYB8mEjtXz7ct2qSBsLGSgrI4XH9iDG6oysqr2Frdo=;
        b=m7lcTqyFLSdUSPDFxxVH+4SzXC13xoUmO56ZpzSQ26fLWgaSvWeiCr4f0qY8xz7MGj
         uDr+iR+rZjdPLh0izbaTy61URABz2Rl6P/mL0kYvei+K5q8K/273Im+3e5xrgc7VyY69
         jVGhLNxgL0vV08cKKckjwuBa+AIY7XuBEG/1m0mq8hgLEgN1Sg8JxS1wV6YXYuTLbeDQ
         iekOAk/+xMpwdYOefEhIhUsHsQwG7QPSKn3esb64JWMi/iCJplokmzQOzsmW62bwsIOp
         y1L9Aj5REVda6hFFw1O0SSxYA9xQgQ6KPdDQNM05CXS6nkmZAfYOU+IYTa+QcQr4Fper
         l/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728917911; x=1729522711;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKYB8mEjtXz7ct2qSBsLGSgrI4XH9iDG6oysqr2Frdo=;
        b=wKLH2wJkOxrJ0C4XLpKlt50R6TF6z/6Pv+83W3P5nGvQfb3SmaR4M8taXGxi9yeJcA
         fjehHaDIRrJyWKt0ZVFxH4iwnAQ1Z2gS/kSP5av1eFMYyL8lCTcM+HxhiK/nriB2KoOx
         TjnXS42swYo/q3HGpodAy6yi8/gwp5RV7oD7i86ghyY1R8UIPyIhjoMcU1u3f3W0a4gC
         EaCu3XuEKaXDAMq3YCBEHzgRasVAj8c5OljeSMKVSJf1hY5BM7NAk9T0q1AZYadI+6si
         Gb35TVQikrT3vwv9zhVetmfC+BO78EAC74jM68h4RJfEAybf3wgMxWoVrGTjJIpK4wYm
         LTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCeFl12JR50AIdIQNk1GqKBQgjC7OIKbQ1yty+pPhHq350hmOPFlGem3YathwzC8LnUX8fua8sJqLK2DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmGcl/sq7or+ZrE8vssbiJ1kY8WV7qy18aCaFArcuRkQfgZPvA
	bCRfuonqfB8ryqyobSkEl1EqHUOeMN/FVm4ME9ht95ItG/TmSnwvgf1ZEA0e00I=
X-Google-Smtp-Source: AGHT+IEYBbeD1Q7jGz6lVOjhol2kYRgWUCHVlTzN3f+mTJX4UKbUMDS1lgLp9CNDHtS5N/8wVLAhCw==
X-Received: by 2002:a05:600c:1c09:b0:42c:aeaa:6b0d with SMTP id 5b1f17b1804b1-431255dac21mr101952935e9.9.1728917911532;
        Mon, 14 Oct 2024 07:58:31 -0700 (PDT)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf45dacsm154167905e9.16.2024.10.14.07.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 07:58:31 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 14 Oct 2024 17:58:23 +0300
Subject: [PATCH] clk: qcom: gcc-x1e80100: Fix USB MP SS1 PHY GDSC pwrsts
 flags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-x1e80100-clk-gcc-fix-usb-mp-phy-gdsc-pwrsts-flags-v1-1-241a68c02be7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAI4xDWcC/x2NzQ7CIBAGX6XZs1/CIhrjqxgPlC6UWCth/alp+
 u4Sj3OYmZVUahalc7dSlXfW/Jgb8K6jMPo5CfLQmKyxjg07LCwnw8YgTDekEBDzgpf2uBeU8Ys
 0aED5VH0q4uSTYi8Hjr23R+8dtW6p0pz/83Ldth/C0EnegwAAAA==
X-Change-ID: 20241014-x1e80100-clk-gcc-fix-usb-mp-phy-gdsc-pwrsts-flags-3e51fba26aa4
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1362; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=JRZ44OBgoYCaaa1ufOrPbwGLSAjE/5hwJtri2e3BNE0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnDTGQvx3yS/HPkaxmpQyopjFM5rcV4BlLoesuq
 fppq2x6h6eJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZw0xkAAKCRAbX0TJAJUV
 Vnw2EACeMKXytIIIRe4ajQ44hotO3jfSvrbMHHcjZ1CNrYlATE7F04YkbF6Hl/D95pTKV9hMEou
 DjPOJWWBhnS45ko0DKd7KUtHkDvCU1S+eoIkxJEAjU1pzgVZ1ARnVQFGRiLb52cSMgNcDS6s1UV
 b8mkjlKsaDYFyPQ+dQo5HGvQrilHqw8w9e/cPrqIJMdDMBhFV4ntDiN7f9YbxrRjRYOfcQjouew
 gKolCsLASKG7TkhPxxRiJjxoOVNxzBHWJ4IQhg6EovGujgNATZgh4rTA84xwEqdsmQaw75MmJKK
 xz9YgVwcd8yIE4Onypn32EAAiKMMB9rCCgi4puakM4abJI7LAYNTCldY8jbrSG+UjG6hK4u6if4
 GHPOMt9OAr/EEx2bwoXtKpI+6H7W7bAP+GKwdBv0tVwdX9e70PSj/b+dC3bpDoyNvvx9SL4B7EH
 6oPE7mnVJfnDBnoDEIBTNB7o3sMURlIl9r/Au0gBk0YUKTgCnzg8Zi84DkIZkiLDwG0oHr0aqW6
 UdvoQ/IXn09k3fN63sKUynohIR7KcZK8DCREQTJJZobdsMeHiQW4/ihO/cXFeC4ClyuL7oQxwv6
 FFrrRGv1clx1ClC+t9NDaFmWlNLMZhDAfxa64xpYZfl/GLlxyzVQ8Qh2INUyyKsj31i5zalr07r
 lMVWtV3jqE8SlyA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Allowing these GDSCs to collapse makes the QMP combo PHYs lose their
configuration on machine suspend. Currently, the QMP combo PHY driver
doesn't reinitialise the HW on resume. Under such conditions, the USB
SuperSpeed support is broken. To avoid this, mark the pwrsts flags with
RET_ON. This has been already done for USB 0 and 1 SS PHY GDSCs,
Do this USB MP SS1 PHY GDSC config. The USB MP SS1 PHY GDSC already has
it.

Fixes: 161b7c401f4b ("clk: qcom: Add Global Clock controller (GCC) driver for X1E80100")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/gcc-x1e80100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
index 0f578771071fadb0ea7f610f04c5510a85a8485a..33afad9c878d30f487f63b311bcea6296d0653fd 100644
--- a/drivers/clk/qcom/gcc-x1e80100.c
+++ b/drivers/clk/qcom/gcc-x1e80100.c
@@ -6155,7 +6155,7 @@ static struct gdsc gcc_usb3_mp_ss1_phy_gdsc = {
 	.pd = {
 		.name = "gcc_usb3_mp_ss1_phy_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 

---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241014-x1e80100-clk-gcc-fix-usb-mp-phy-gdsc-pwrsts-flags-3e51fba26aa4

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


