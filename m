Return-Path: <linux-kernel+bounces-329308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C62DA978FD7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 12:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87806283C9F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36701CE714;
	Sat, 14 Sep 2024 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsdoPM0M"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F3146D5A;
	Sat, 14 Sep 2024 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726308427; cv=none; b=sNVif947KgqDNV5DHHvskC+kN/j4WUdq34tsngCv6usOfi9yvuNdIMT/Ref9PPYnHM1rR2DvmAkpD7A6yxkDEV4vWvsfAXCgdNm5FojsD5lNI28qLJl8Ivc7jvBGDWW99KsferGoelgdORJKwp4AFznhDzfgpVEXKDSoUqNXlVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726308427; c=relaxed/simple;
	bh=B2uo95TFjLNThhU6mneOTIuZhASXTkzS/sf9qt5JAbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RtX1/wx4GsFuWf+dYHC4HiWejrieeb2y4GG8sncZFkgtYqmGGDNARR8uKbqV6p/XYZ0q6oq3UA85DKaGHOwhWaFPB2sVco+Ba59tZVw4IN+t1zCRvtLgf7Yom7Dgxxjpnikt4qt/cCEKbR5J5o0bCvul2sXgkFJ3Dy4wQpOZtTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsdoPM0M; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a843bef98so210029366b.2;
        Sat, 14 Sep 2024 03:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726308424; x=1726913224; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oEIrC6fkjUDhUytmEyujyx/BPZ/Dm0y8aAc80KqecXk=;
        b=IsdoPM0MgQ4/YgPVShnbSlMCgHXe9rf8vUPdFXosO+3kSmb6HovmkSCVEblR2cbIZd
         u0PojGy2HWlApR7Wiv0+xiIbaYrfAOTe3D4sLLoep6Zw5MjkgLFegHjGGpWeX0+JjKRq
         56AnRAyhF5emjIzTpYSmaABekD3pluGWb1xkcMAQIy0L+/WqRi/NDDifNPxfqogcSPFj
         1QJ67IjDACz+fGebK7YDPBsWPYX9f0XnGPjvX/jlSZ7XovcxjWCOL81syUG8uM1azttA
         7tRHA7Q7ZQUaaFQKrmttkAV5fgEnEEMYLK8mWF8u98tyc0aLSHRa0YHRJz0ORKCVizJN
         aDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726308424; x=1726913224;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEIrC6fkjUDhUytmEyujyx/BPZ/Dm0y8aAc80KqecXk=;
        b=AoMRJkCdW/cilfETPlvBp0g2IUXuSgVRxsRxrf0+rc8da/hU0HwnOmPLXfXDiPBzMj
         gcXQoT8wS9KJozPPqp9BmCu9WnsVqPfiHoMhyVPjGPuVkTiZDBzO4ofoc2SUslGvUHJJ
         KXU+PI60d67hDkHAGVkEZkZZ5K8qSsT+0fK2TgUjamaMrQESh5DRzfpf0Q17KAo6rk6W
         wUmBz3V781YDJnlNHSROoub+CLcN0t0ehG/mzlsb7OzyzhZKQqrQWQ9rjHK5JttzX/PU
         qdtgvlydD/3RyDjk0fGi8Cz8UZAvujGxfx0Ow0YZBc/fJpbsMfWCc18SAuw7czOP2kWZ
         k52g==
X-Forwarded-Encrypted: i=1; AJvYcCUq6NZYPJEMOh9BZTDy5L2SveuhI/iVjaime+x46DblKuxxwY1Q9iT1m163Bwo23eMM7qMegn//DX0Tntk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvJKFVdSUK8nJoGBTDiQcYJIcJO/C406ncdyhPx/GjzLHW5saa
	UMkYG7P0nxIOgcSY2GlkpJpYA8NbMLkwP//5wYqjnMaxmsxO24MH
X-Google-Smtp-Source: AGHT+IGXhJKaMfZi7R0EnhsiSO5qMw+KJZP5yHlgmcZg4J4vj0+/2FLyveFNjO4NJ+/HQOISxQcnNw==
X-Received: by 2002:a17:907:94cc:b0:a8d:6921:e17d with SMTP id a640c23a62f3a-a9047d1adf4mr547920966b.33.1726308423034;
        Sat, 14 Sep 2024 03:07:03 -0700 (PDT)
Received: from cleve-worktop. (cst-prg-101-230.cust.vodafone.cz. [46.135.101.230])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a906111aa91sm61961666b.97.2024.09.14.03.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 03:07:02 -0700 (PDT)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Date: Sat, 14 Sep 2024 12:07:00 +0200
Subject: [PATCH] arm64: dts: allwinner: h5: NanoPi NEO Plus2: Add
 disable-wp to mmc0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240914-b4-nanopineoplus2-fix-mmc0-wp-v1-1-12f54f0d6620@gmail.com>
X-B4-Tracking: v=1; b=H4sIAENg5WYC/x3MTQqDMBBA4avIrDuQpGklXqW48GfSDugkJKgFy
 d0NLj8evBMyJaYMXXNCop0zB6nQjwam3yBfQp6rwShjldMWR4sySIgsFOKyZYOe/7iuk8Ijopv
 b1o+O3i/9hPqIiWq+/5++lAuw8lKSbwAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726308424; l=918;
 i=cleverline1mc@gmail.com; s=20240824; h=from:subject:message-id;
 bh=B2uo95TFjLNThhU6mneOTIuZhASXTkzS/sf9qt5JAbM=;
 b=5Lrk4c31YFwAF0a+C3UhpMwhNyIjmtsc4QT30mPA4izeJ8UHvH/xMLNfmKhpSYe3KIDe0hyIO
 tiZn1Q+K3/0DbIMaaW9nHZBO+HNrRs5ChBEj9/rFZggux9tF1/X5LOw
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=CQifx5FUgTQKAoj5VCYrwYHi235AkXQ5yT1P6gkaBxM=

The board does not have wp pin/switch for micro SD card (mmc0).

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index 526443bb736c..18fa541795a6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -136,6 +136,7 @@ &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	disable-wp;
 	status = "okay";
 };
 

---
base-commit: 57f962b956f1d116cd64d5c406776c4975de549d
change-id: 20240914-b4-nanopineoplus2-fix-mmc0-wp-9d77fb9e6513

Best regards,
-- 
Kryštof Černý <cleverline1mc@gmail.com>


