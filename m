Return-Path: <linux-kernel+bounces-368288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BCF9A0DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A061F2661D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F9A20E022;
	Wed, 16 Oct 2024 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="Ie8Bkr/u"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F620C006
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091510; cv=none; b=b8DGjbHhHkFbgu/GlKViYCfQYP7Y9OXTFMqwvJ4xXQVocb0aVBD50OIqgX8MnZPrAZdFSI1DWD6dAnOIo/Up6e2Mr8i47QDJ9bZ2hUZRIukaydNGwvQu+7IvsXPiakAwHcfnobOgoZJASkpjJPnB0xEYnjM3e+QCo8ND2I2JrG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091510; c=relaxed/simple;
	bh=ckxdzGByTXJUietXC5uAvZOJ6fBo9bKDj5epsvwfcw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lhzlS9Id+PXzMo20UStOEj8qnRdD90+OKwT/7HBisPmXW4IAnLxxQhCo5ihT2fYzg9OR6s5fGTvjAASNBTCnQs7lfOW06OggaU44Ig90Ero7ng4zB4CKTos9vkVegGQXjhJQIcBArmIBBb1CG4U26FCqXn8lLCRV/iUIxp/9gOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=Ie8Bkr/u; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c9978a221so60757205ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1729091508; x=1729696308; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hEOEoYJF2/Ff1J+c4cDFgOoOmZPcjeqN5UTMVGgmwos=;
        b=Ie8Bkr/uHLDpuEruVeg5GgTUdCIaP1spd0ATZ3M+JQVBE/mscGlYVxjg3UMOoHwaX2
         XvhOZ5EHq5cBwaPz5+1aJAdqQRkOANMxO2bmJvOuvuVagpczXctkSyMzT2hBvkrcxdRq
         Jig3ix1/wOtEOsyadvLFk3ogfQjH6FswTrJOsXm6romKDD5chPYQmbc+dzOQKm3ZVWhf
         EhMDC4sx3USuJ7eAgUhN6nDZ9JBcdRFcSkhk57k0R7599K1q41nEPMdWAw3Wqn+s7pkP
         DUg4vX6jEc+LJzL+DA0V67cIHzDwC6idTYQfC/+zumF8U733Bbk7AMYi670h+Nry7PGC
         vM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729091508; x=1729696308;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEOEoYJF2/Ff1J+c4cDFgOoOmZPcjeqN5UTMVGgmwos=;
        b=d5abc4o2pP4WntHn/rKatmCU5HxhZGRMjRO0tydY/m87eS6Uq88iNjyx0E/rTcRbkl
         PQnU5cqflQnZWotEp4fsBaZKXJbon9SHR3IUASB0km4FCeI4oOUyUr32PeiwgN1o3ENu
         8FnKVz+D13c4fnpZDjZ0nKXxXJNnSerrityKTDla5jOmpJEd/1wttHQslbT3XoR6vWVM
         QYxR55VoepxQaf51haIzSHh/hWnTUVHpbAQAO6GruWoIpr5E82+92uX0ZlIrulTHrJUD
         qWzk21Bu3a4oLFFDHOj4TByUAVFe6F4lOMmqYMMBR6vWTS1JxmgV3rLxwXm3rujaaJjk
         OqNw==
X-Forwarded-Encrypted: i=1; AJvYcCU489ZvriDjGtQ7Xh1LkrtiBmSPelUj5XG1s9LJzGWYXb6G2TbSFw/q/vHD7vGzzX603YTBG7hxcL52jys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPI8N0405a/+dBcYoBYweeOc0rnjIPOr9Mbwzka2TvHxqhduw0
	hR3zfA6hZOZ2hW24OmP09bSoWcGF7WwAeVNJ+lAlBFLH9R3q7rcbmjwiVTW5mA==
X-Google-Smtp-Source: AGHT+IHNFfZ8Imho4YOAv0s3tUMWoLPXD/ZhUSm7DPCRIhLtXTaXR3/u1W15BCKmwDmXqQPINHdiXw==
X-Received: by 2002:a17:902:e752:b0:20c:a7d8:e428 with SMTP id d9443c01a7336-20d27e59bebmr66237125ad.7.1729091508137;
        Wed, 16 Oct 2024 08:11:48 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1805d070sm29583625ad.282.2024.10.16.08.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 08:11:47 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Wed, 16 Oct 2024 20:41:15 +0530
Subject: [PATCH RESEND] arm64: dts: ti: k3-am625-beagleplay: Enable
 MikroBUS PWM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-beagleplay-pwm-v1-1-245ae88859bc@beagleboard.org>
To: d-gole@ti.com, lorforlinux@beagleboard.org, jkridner@beagleboard.org, 
 robertcnelson@beagleboard.org, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=ckxdzGByTXJUietXC5uAvZOJ6fBo9bKDj5epsvwfcw8=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBnD9etsj1ViSMU4ImyLpm/OOwYvVrE1H+1dt1X+
 yROjMz+FHyJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZw/XrQAKCRAFzvXHieVa
 dMhiD/9DfQbiuPmywZaAmQZQhL+/sx6A8UMRKa+bo/73/SBfvdL0XYvP7x2B9bbTel3Bwu5uo/c
 Guc6WLjRozoux9uz4gT12khIEAYEAqoVrTwbKH4vssOoWDlRYDfZ2jJg1l94aQ/fbe7RSafDGv+
 cM57MI2R6cO1PYkU9+pVcrCPe4IDrKJjaZW6LTn/EQM0sSCVlDVUUHhYwT0JtVo3vJlK2BFEGGw
 QHC3UPD+At1Q3MNqsfM46L4P2O+Jc7Tn7F/qvBjF696dt469glm0WTqLQgtGzLsZHXgvLk3l3ny
 G79vXl9B4qtVdRWTHujZfiIDLMZEnkIhelG8rIbFMcHtjBTK8L0NgrhOXyVjXYtdj0u91Jk0IUf
 23oSkHBhT1xylSVZxXhnLx3eKWWoYW/vtn5Qs1l7GkCNEE5p95XzSongYjD0bAv+rRxBG5BY63x
 ZmWWXcaPT1ug72GzonpRLo7GOHxsczm6qJ+FGtoyHhXDvy2Cqo56JDvdEGidSV4jsuOtCInByFY
 jlIDPHLTasSfLVIBnU3itDlz5AjIEhNfscxmAc4toYSiMfiHbmV0VSs35SeX5nAe215sTOKuspb
 fvTT35aKQ72FfBEka3xDxynXIHu+Ld+V5nsnWgEcDA8Ynqj+6IkGTXJyA+BORl0LWezAboThC8v
 NwVuE/jYdrsvfjQ==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

Add pinmux for PWM functionality of MikroBUS PWM pin and enable the pwm
controller.

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
Add pinmux for MikroBUS port PWM pin. Also enable the pwm controller.

Tested with the sysfs interface [0].

[0]: https://docs.kernel.org/driver-api/pwm.html#using-pwms-with-the-sysfs-interface
---
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 70de288d728e447d5053eab3c1417f23212a66e4..2dbb8930be3f2ea72f1c502233f303934c83c46c 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -419,6 +419,12 @@ AM62X_IOPAD(0x01a8, PIN_INPUT, 7) /* (D20) MCASP0_AFSX.GPIO1_12 */
 		>;
 	};
 
+	mikrobus_pwm_pins_default: mikrobus-pwm-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01a4, PIN_INPUT, 2) /* (B20) MCASP0_ACLKX.ECAP2_IN_APWM_OUT */
+		>;
+	};
+
 	main_uart0_pins_default: main-uart0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -925,3 +931,9 @@ &mcasp1 {
 	       0 0 0 0
 	>;
 };
+
+&ecap2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mikrobus_pwm_pins_default>;
+};

---
base-commit: 57f962b956f1d116cd64d5c406776c4975de549d
change-id: 20240913-beagleplay-pwm-b859db19318d

Best regards,
-- 
Ayush Singh <ayush@beagleboard.org>


