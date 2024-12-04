Return-Path: <linux-kernel+bounces-431022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2CC9E3841
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3FA28620B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9491B3928;
	Wed,  4 Dec 2024 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8QXX9uD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FCC1B3949
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310343; cv=none; b=JqojMIMOI0TDdJy7wRz7tbtel/i4EgTQN/mWxWUbSyY6Ojs3xtm30y5apeR/kHrmDYU6HSZLn5lCsY18EWgpvq34SWAYEqh6t8FVEyR36gTsKTQ51xPSRPRmS33HT0ADQc8V8gBU35De69nEPi8Cv8Q+vE/kGm44nw7LGGbjijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310343; c=relaxed/simple;
	bh=zgzaEQAYZLs92wt5M7EAoDuGBcs31mzeCPRI5Vf+jW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d2md5XbJjp05uCnqmokvm8gb4m3SEeEH+4EDv7TVJdovyLzRowqZeob1EyUiJ8tFLlD+/xHXvMgU0NGeeRwBG7+Saxp+CjdPwRGu3p9DlrF5uEEZXszl2Lvo9VDUuRQhoHjq1rAD+6sKeVpe+sNk37+dlEABX4RRDexCvjjuBek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8QXX9uD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733310339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pYs9v+5xS9o1woYf9AwDTUqR002kQs92H7EyPMP95fA=;
	b=G8QXX9uDG3E5o7bbwSL5fweLLO0lSRRAdq/oCUheQdItVcDuVj0N/gO36U2RL0AQX/ahsd
	wQCwRwRqUmcO8L7dsUucI388cIt6xntbknDHzhrnyy9Z57c2Pt7Tk5fYn4aywBpE5vCi2f
	D1fv4qOHDKKhKia3CEeakRaOoifcOs8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-1vRtzhZMNJycHbxK-uQGBQ-1; Wed, 04 Dec 2024 06:05:38 -0500
X-MC-Unique: 1vRtzhZMNJycHbxK-uQGBQ-1
X-Mimecast-MFC-AGG-ID: 1vRtzhZMNJycHbxK-uQGBQ
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-466d3ec228bso8612541cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:05:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310338; x=1733915138;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYs9v+5xS9o1woYf9AwDTUqR002kQs92H7EyPMP95fA=;
        b=sJnH6WDEHvsob3bEhXELnOIJpMdqss9EvnApZ188mV1os6P3oDl/RWr6CpUOQ4nQwX
         wNenoDa4dXgtI4dtPYe6caeD0KNFC/VhUL7ZdpFjZ5YVGzC7mgv95JDIRzvERLWaHLzW
         hM5x6FKuMbojk1Xkz8JZlxOEWdD9aBDnC6ZAgHP9OfFekj3B8ObAKhkjD5Cs3llXjLLs
         S2bKg7YwD1N1Pes9422V1LOBIUQY5+eUTgo7f+Orf4rOfjnzsfJOiDVdoJwxcSDt7Hrt
         gdJBtmet/z3Vws59EKdIfh5iYE/plFv8IBP9ivfuF1ax78+j+PHlDA69T/F2g6HpQXOL
         XIEw==
X-Forwarded-Encrypted: i=1; AJvYcCW5oZ0I52zpnXUNMd254SJQX26K+2YdAuUw/gU38ZFFkbv58kxvWU8dkc/1mjJe4K7jng1qFI32f2lxyq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywU8IHm/zfaBWmEVdz3S3VPL6uYMpUh3FGGIHIy10m8LUjpfsl
	qNc+l/IlAojisE6eSyItNEhefOaQ6PT+XgwGnyFdj5aK7NrHTk9QokN4mLUhE8RMoF2nw65E9XD
	92KAX9Uqof966wy5m7jKumEpDNwgUj/RSMk5bXAjdaUJcuBu5hJ7U0uknF+veiA==
X-Gm-Gg: ASbGncumakI1Ecnc1XY7xrOgJvOTf4mZpUl0brvm0aoFIHbiIz48Nf5QpXOxrmwQ1H7
	ccxumWkhozgIwyQL26o/TGEP3kOWW7BHyfIA7rASaDfTMt1jHux4qI8GJ8PcEO6dEnkQI9SMA9H
	byDL1oc/ugOHSg/jycj14KFYme2Sb3tVxy8GfCO3lqYPLERK+RQC8SjoLFs3bWSVr/QlFxJTT4V
	ol520xcqsaBgkHCFKbDy0FOpzSVDOwddeFJR8lFjI5uKT2RaHo=
X-Received: by 2002:ac8:7f88:0:b0:461:653a:eab with SMTP id d75a77b69052e-4670c36962cmr38331911cf.6.1733310338012;
        Wed, 04 Dec 2024 03:05:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOpNUOSt5wAKrvynr/39CNBeGiecoP/HZQKzUprTjksMnD7nDIzipnydiPdmgrbnAKZRyvKw==
X-Received: by 2002:ac8:7f88:0:b0:461:653a:eab with SMTP id d75a77b69052e-4670c36962cmr38331741cf.6.1733310337586;
        Wed, 04 Dec 2024 03:05:37 -0800 (PST)
Received: from [192.168.1.51] ([83.45.91.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c407e11esm72245921cf.42.2024.12.04.03.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:05:37 -0800 (PST)
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Wed, 04 Dec 2024 12:05:26 +0100
Subject: [PATCH v2] arm64: dts: ti: k3-am69-sk: Add USB SuperSpeed support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-am69sk-dt-usb-v2-1-d59b2ac45c6e@redhat.com>
X-B4-Tracking: v=1; b=H4sIAHU3UGcC/3XMQQ7CIBCF4as0s3ZMIVLBlfcwXdAyCDEtBpBoG
 u4udu/yf8n7NkgUPSW4dBtEKj75sLbghw5mp9c7oTetgff8xBgfUC+DSg80GV9pQqmY7MkKaaW
 B9nlGsv69e7extfMph/jZ+cJ+6z+pMGSotRCazHmSiq6RjNP5OIcFxlrrF8JCOICrAAAA
X-Change-ID: 20241126-am69sk-dt-usb-89180ef58f8d
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dasnavis Sabiya <sabiya.d@ti.com>, 
 Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733310335; l=2663;
 i=eballetb@redhat.com; s=20241113; h=from:subject:message-id;
 bh=FMm9H6sLzpHevS+BDD1ZhChgz+IY/7iaPRnVhXYcLc8=;
 b=4mJOPQHNLdI0jquYC0yWN66Urs5UsMcZCIcQ7ufmqldmUjbtjc5nmPxy0Lo9kBftq27tGXGyv
 6Wq10Ov1mjzBotzxZIFBNGQOFnYtMXLNGUm2mAm7c483cKISscpv0Mw
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=xAM6APjLnjm98JkE7JdP1GytrxFUrcDLr+fvzW1Dlyw=

From: Dasnavis Sabiya <sabiya.d@ti.com>

AM69 SK board has two stacked USB3 connectors:
   1. USB3 (Stacked TypeA + TypeC)
   2. USB3 TypeA Hub interfaced through TUSB8041.

The board uses SERDES0 Lane 3 for USB3 IP. So update the
SerDes lane info for PCIe and USB. Add the pin mux data
and enable USB 3.0 support with its respective SERDES settings.

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
I've been carrying this patch for quite long time in my builds to have
support for USB on my AM69-SK board without problems. For some reason this
patch was never send to upstream or I couldn't find it. So I took the
opportunity, now that I rebased my build, to send upstream.

I have maintained the original author of the downstream patch as is
basically his work.
---
Changes in v2:
- Set dr_mode to otg to fully describe the hardware proprieties
- Link to v1: https://lore.kernel.org/r/20241126-am69sk-dt-usb-v1-1-aa55aed7b89e@redhat.com
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 1e36965a14032ca07143230855e04b9549f1d0d1..353579dedb19a4f9809913570143666f4c4ec53e 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -484,6 +484,12 @@ J784S4_IOPAD(0x09C, PIN_OUTPUT, 0) /* (AF35) MCAN7_TX */
 		>;
 	};
 
+	main_usbss0_pins_default: main-usbss0-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x0EC, PIN_OUTPUT, 6) /* (AN37) TIMER_IO1.USB0_DRVVBUS */
+		>;
+	};
+
 };
 
 &wkup_pmx0 {
@@ -1299,6 +1305,14 @@ serdes0_pcie_link: phy@0 {
 		cdns,phy-type = <PHY_TYPE_PCIE>;
 		resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>, <&serdes_wiz0 3>;
 	};
+
+	serdes0_usb_link: phy@3 {
+		reg = <3>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_USB3>;
+		resets = <&serdes_wiz0 4>;
+	};
 };
 
 &serdes_wiz1 {
@@ -1339,3 +1353,22 @@ &pcie3_rc {
 	phy-names = "pcie-phy";
 	num-lanes = <1>;
 };
+
+&usb_serdes_mux {
+	idle-states = <0>; /* USB0 to SERDES0 */
+};
+
+&usbss0 {
+	status = "okay";
+	pinctrl-0 = <&main_usbss0_pins_default>;
+	pinctrl-names = "default";
+	ti,vbus-divider;
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "otg";
+	maximum-speed = "super-speed";
+	phys = <&serdes0_usb_link>;
+	phy-names = "cdns3,usb3-phy";
+};

---
base-commit: 7eef7e306d3c40a0c5b9ff6adc9b273cc894dbd5
change-id: 20241126-am69sk-dt-usb-89180ef58f8d

Best regards,
-- 
Enric Balletbo i Serra <eballetb@redhat.com>


