Return-Path: <linux-kernel+bounces-395824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97B99BC392
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3C4282FCD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88A1757F3;
	Tue,  5 Nov 2024 03:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dP8wL5NQ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75ED2A1CA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 03:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776098; cv=none; b=L8Eejfi35zTMn96uetQjBWowVCVGnlH65XawzBL+Rzi+7f5Q+SXqW1fULCSYu9q7A/RBhJ2n229nYmlFGHSzfNm7Zol7IfpwCTf5mHrjayE7BoC6jN8qOeWp6s0WWEBgJ11ZGMhVpIgRo0Aio3wFEHjKVn9/GiNedD64qb49+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776098; c=relaxed/simple;
	bh=XJsufPU8oDUNT2IVUxN0YngUgeNFIQN/QtzNcOQLQoA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uk0uyan64QDoqioaerX03A/DDtnuJktBG9W9Cd530rz9t6hdTBubija7mZ10/L4fGC0uqVDb2K2jH48BUavxud5ZS7gNV8W46i7adjsl/WzPZZ5ANmRFAAOqJdEgXtxk33LgBV9E5MKFCe7Ngktjta5Hfh8SeCT9dvDbZUmOc2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dP8wL5NQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20e6981ca77so51647285ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 19:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730776096; x=1731380896; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/IpCOxbbfuWTu34K+8DA6jyFkd8ceqHknAK97seFFAo=;
        b=dP8wL5NQGpFl5N7a1cJowvYtuKl8+IwUv4u4ACeTkcgjbu7PM1ocY0sAfd37PCdBBF
         zaITnkGpTgp2X1naSCpklCj6ZCO86tv3ThkDreSXTJM9Y6jOWWP1uAOT5yuN7fqansUT
         z/fxuEhMvKVDZGw5S8VP6OfEyHupugO5VN4gA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730776096; x=1731380896;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IpCOxbbfuWTu34K+8DA6jyFkd8ceqHknAK97seFFAo=;
        b=R06x2IKZ6OsX+jtB4c26IXjYwjturXko3p3S6V6/z8rad8z2yEZU+T1t0KNWOahUdi
         Oy1kriR5T07hakrdnlWU+t3yv/384aIHFRm62m+e7VeN2ifDV4cIYfE31T6gLpjGZ2Ee
         7DOCTP6pK+FYoSCiSXrXLveja2/ENBR5oUyWpihcp4EJc9E5LhO00NHuKYAB63imUZWX
         lfS/jhI3x7AZgCyu+oRadg2A3LrBjUolMvXdmI6wAP7w6Oe/eiSwVWXg0lAEJNZjm1ro
         UunmDfbWV2BC0Vftgk9qZEw8p7pUx1zSqmDxlJpV+LeeVV3eN+XKV92+IMZqO6N8TIZP
         s41Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6UQQAGG560Hxh40Q7xo8qYGnwpTriQTLuN+kiYxKIyPxjU4nO5w7Zm3q5LXqCDVTXZxvPiVrBcw8AF/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0IMjQQlR0QSjSRhIvSgpuIC3JrKLRoGHu2mzMHlqHHd/EIVb
	ee8lIJzqK481FwbSnx1MUfJDio/D/jR6mPa7H3wRe2uE7OiZl0ZcrSxgrWNqoA==
X-Google-Smtp-Source: AGHT+IF6jS3xzGt+Zxr6gzcjbNP+fJbgJb8X0AuhlKcyg9Co9aLJH6t+hhtXNPcGCoVxjkWAw9u6CQ==
X-Received: by 2002:a17:902:cf12:b0:20b:6d47:a3b0 with SMTP id d9443c01a7336-21103acdc86mr237288275ad.21.1730776096189;
        Mon, 04 Nov 2024 19:08:16 -0800 (PST)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d8d4dsm67497885ad.270.2024.11.04.19.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 19:08:15 -0800 (PST)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Subject: [PATCH RESEND v2 0/4] Using i2c-hid-of-elan driver instead of
 i2c-hid-of driver
Date: Tue, 05 Nov 2024 03:08:10 +0000
Message-Id: <20241105-post-reset-v2-0-c1dc94b65017@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f

After commit 2be404486c05 ("HID: i2c-hid-of: Add reset GPIO support to
i2c-hid-of"), i2c-hid-of driver resets the touchscreen without having
proper post-reset delay on OF platform.  From the commit message of that
commit, not to decribe poset-reset delay in device tree is intended.
Instead, describing the delay in platform data and changing to use
specialized driver is more preferable solution.

Also workaround the race condition of pinctrl used by touchscreen and
trackpad in this series to avoid merge conflict.

Adding other second source touchscreen used by some mt8183 devices in
this series since this should be based on the workaround of pinctrl
issue.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Changes in v2:
- Add second source touchscreen patches since they should based on the
  first patch of this series.
- Link to v1: https://lore.kernel.org/r/20241018-post-reset-v1-0-5aadb7550037@chromium.org

---
Hsin-Te Yuan (4):
      arm64: dts: mediatek: mt8183: Fix race condition of pinctrl
      arm64: dts: mediatek: mt8183: Switch to Elan touchscreen driver
      arm64: dts: mediatek: mt8183: kenzo: Support second source touchscreen
      arm64: dts: mediatek: mt8183: willow: Support second source touchscreen

 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts |  2 --
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts  |  3 ---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts   | 12 +++---------
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts   | 11 ++---------
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts   | 11 ++---------
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts   | 11 ++---------
 .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi |  3 ---
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper.dtsi      |  3 ---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts   |  3 ---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts  |  3 ---
 .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi |  3 ---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi       | 10 +++-------
 12 files changed, 12 insertions(+), 63 deletions(-)
---
base-commit: eca631b8fe808748d7585059c4307005ca5c5820
change-id: 20241018-post-reset-ac66b0351613

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


