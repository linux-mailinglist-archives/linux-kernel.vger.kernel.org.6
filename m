Return-Path: <linux-kernel+bounces-370427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6259A2C47
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81171F21B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4429518C337;
	Thu, 17 Oct 2024 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXWnkIY1"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F484183CB0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190255; cv=none; b=JjD+uNm05cf/GqiEeh2KHtR7o9NTcKWypujHy23H4IN7U0wWqA/rsWFASinyFCW+rA2KeE07gs2MyXrTvPlSfx4Ap4D+q111+zt5uErMxmg7S6ZtYIddGZj6emj1CvaJxPz7fJFS1sIZMKShRfQ9qn1lH7PvJ0n5sL9sZqWUUTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190255; c=relaxed/simple;
	bh=GDnCviHCLXAmzJoLdIKU2zfOrI2/epa6FA/FjUWKUM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NU9bg7m0FNRe8027h3okboAiOrQkg4i0IEEV5T5EJt31M/h+eM0PTVZ9ouGc47R7PagxnAxFgrOLhdI0FQcHS20FaxE81px4WazcFO+Gc7t+DPNSp9SYbdp/dN+ifm/5YF2DGnVyjuqo3a2KB4aSRKxtwsv3Ngs54Kk5op0NOQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXWnkIY1; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so2080720e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729190252; x=1729795052; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=shUsrE0U6Ism8xV7T8jvrxBc+yHbE3QtMiBXDOtC8xA=;
        b=XXWnkIY1jo/3crRa1ylQGMGEZ0gGQNIZfBLGPMqYI2MfeU/J4o+LXXAVm+Zy8b4K1G
         uE4Jo7BdCaJstGyLdKY00vM+DPVsKt/SPk5kSXHF6asmBJQe1kfkjiTdlRw+5hlirgYq
         z6mb1l8eRjRcYQpWvVW8/qs9qWyHAomnmlJoIzi+U7hCzjsqoiMSyiKWafoRhYeN/2+1
         mY5NJVV0seCRwTw7b8OgLJaurl6vD0SuzHKR6utCvmpIjngCDxOlygeOBkLzYbgE9GuK
         6ne6wGOiV9IB4RrBrXj3t9vaVUe9HQ87IQpQqNhTeLxhFKoqCt2y/PuxDyLW0867G+Tr
         5dAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729190252; x=1729795052;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shUsrE0U6Ism8xV7T8jvrxBc+yHbE3QtMiBXDOtC8xA=;
        b=Xn2IFLsH9e9jxaPv9FRWWFLL+xCJXx3BzI84W35jn3omcBdGSoIsdbTGrRzfDEIfL/
         p/wG2HYYgVdrwxNC2nPdWWP5GwQj7EhY004w+vbSDOc6TCcxNY0GVPP//yVXAxCaP0ny
         K8ChIuGDs7HqScvlKjc+CIETaUQGAX0v0q/U4OTn3EkHA0QxHWITqiaE5/F6HJPXawQL
         Ak8OGjlu4o5BYFtBJRV5Tq8Smbv5yPK2RBIZxQYYpR/p6J5B9er9OrAgQ/IwxjEZLPy5
         4stTJtxBWCGjZGSsjrFHwl5kOs0nrt/JekO+aI5WjQHrTnfEIpxxYx5eZiIX+cy6Rp2a
         DAUA==
X-Gm-Message-State: AOJu0YxSuUnZbV9JA9/Zqk7gxtl83vejpSxkJeRGYXcg/H6FvOrGMZaU
	sBtYZsXGpI4cDAV+R0nOZyHWQ0BHYGWhUYUmzS9vR9eL+JZ9MgqA5lTdy7hy
X-Google-Smtp-Source: AGHT+IHhBzPjkxhlbfY6H4Eei5Q77fOwDnyHdTDBz+JMJFUw9lIwDAYZZXy5mysMhlAATzd9pRSapg==
X-Received: by 2002:a05:6512:68a:b0:539:e776:71f2 with SMTP id 2adb3069b0e04-53a03f82444mr6217384e87.52.1729190251921;
        Thu, 17 Oct 2024 11:37:31 -0700 (PDT)
Received: from razdolb.local (static.40.223.216.95.clients.your-server.de. [95.216.223.40])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a0000abcdsm841221e87.210.2024.10.17.11.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 11:37:31 -0700 (PDT)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
Date: Thu, 17 Oct 2024 21:37:28 +0300
Subject: [PATCH] regulator: rk808: Add apply_bit for BUCK3 on RK809
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-rk809-dcdc3-v1-1-e3c3de92f39c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGdZEWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0Nz3aJsCwNL3ZTklGRjXWMLCzNjoySTlEQDYyWgjoKi1LTMCrBp0bG
 1tQDo2FVYXQAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Mikhail Rudenko <mike.rudenko@gmail.com>
X-Mailer: b4 0.14.1

Currently, RK809's BUCK3 regulator is modelled in the driver as a
configurable regulator with 0.5-2.4V voltage range. But the voltage
setting is not actually applied, because when bit 6 of
PMIC_POWER_CONFIG register is set to 0 (default), BUCK3 output voltage
is determined by the external feedback resistor. Fix this, by setting
bit 6 when voltage selection is set. Existing users which do not
specify voltage constraints in their device trees will not be affected
by this change, since no voltage setting is applied in those cases,
and bit 6 is not enabled.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/regulator/rk808-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 14b60abd6afc..01a8d0487918 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -1379,6 +1379,8 @@ static const struct regulator_desc rk809_reg[] = {
 		.n_linear_ranges = ARRAY_SIZE(rk817_buck1_voltage_ranges),
 		.vsel_reg = RK817_BUCK3_ON_VSEL_REG,
 		.vsel_mask = RK817_BUCK_VSEL_MASK,
+		.apply_reg = RK817_POWER_CONFIG,
+		.apply_bit = RK817_BUCK3_FB_RES_INTER,
 		.enable_reg = RK817_POWER_EN_REG(0),
 		.enable_mask = ENABLE_MASK(RK817_ID_DCDC3),
 		.enable_val = ENABLE_MASK(RK817_ID_DCDC3),

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241017-rk809-dcdc3-388632b4da03

Best regards,
-- 
Mikhail Rudenko <mike.rudenko@gmail.com>


