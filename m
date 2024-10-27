Return-Path: <linux-kernel+bounces-383662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D58A9B1ED9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02941C2178E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35D9189913;
	Sun, 27 Oct 2024 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqAKEKZE"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AFB1885A5;
	Sun, 27 Oct 2024 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039837; cv=none; b=rE+XlMSfd7g1XZfEeVHAhzRu0kfVSK+PFAAvh5bMnZnKnXxGYdiKjpRXXU8ucgtC7R658lQz0wcdDxUkGDIzHlFUrykVOYQJNbm2wxaKrx+ByWM3uy4rMSto0b0UuBmB8w1gP49f2Xk5GXf6fx6UWGp9mcnXDWKUtSEiYUg1Iwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039837; c=relaxed/simple;
	bh=uNUTiA0HvI5A7c5xE1I8y5ErznWdRKyRHGjQDeKPcAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HKll/22ZfAWbutZ3jYLUlZWuKLbfhJLnU/JuK9ki84wY6tgXm9SArefPfTWwC555T1JruGlbixGD7IFzndQ3pL1mWavv9PmCzcDri2eW1r0ivbuVKErVM6BBFsoSAGYFAAvCDehiMPSLMV/EvnWRbGHd6s0WiHYHGYULshltbtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqAKEKZE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c933d5bdf1so595522a12.0;
        Sun, 27 Oct 2024 07:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039833; x=1730644633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx0eMLUEzhYETTDB2Dx4nHIilzNRVf/VQgEFIdoul78=;
        b=DqAKEKZEDwFRD0mfbK1d6w3t9Kpob5yDy96mvjeN3dTc3/b7pGYY7kPIS8HW6zETRe
         KkrZESzkxCNFzY6VfHQiEkk6iDN9zodj5xxDeK1WajdbcLGxlNf2OS2L8brXD8gGsMIu
         u9RKJMuE4RrS74+tffXNJQHu5fNiiWEV1s6nRffMffEIoTiBeN9Zv2UaqX3OYwvjqoyF
         k/R2jnRya3Teo+d6435VLMOKS70hFlQnF0AFQEvNNJWAV50fGJlacMyLth3pctPqPcvR
         Ms60gvngeRmD3ZKZKkUiKplC/JaUwx947WGS1XRU7DwhOPXJWjWyr0yitLhwR5cpgZDv
         2xkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039833; x=1730644633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rx0eMLUEzhYETTDB2Dx4nHIilzNRVf/VQgEFIdoul78=;
        b=mXMPOAFN7OGCy0QamkNuB7I2ovavLfhh9iWVd3rmc/Gtp7ZobG8gT84KOu8bxYPo18
         2nxHbfEKWSgH/h5nN4HJdaiZPVk0TlcEEg7MXdysHO9zIKMSEYZ4d+U0us/VfYK2O20V
         lX6OnPYMCQIF8phmOdlWiDHsOCDuyoEwGpSvQPDUYrhZifWDQx2pEF9F50tCrGp5wobR
         tF9G4Or+GYyqtjIgOAtIIth/yqNE6yDZRsOQBcnsmuDW2kkAFyIPMxjvDkCE+cFW0Dk8
         Yv5S7HFMnkvNUu7ZvDYJ/uF4eHYbFeglMmdl8BT86PozuOfG3gCo6VbDo7t7S7qk4pKT
         DKrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5PZCODEMZyyeM8WQhKbdcDeifQjj0GzpfaCsorfiR1K8HqDeXUze29Ewwan3l5VJ3ZAzNdUEATVhMMMk5@vger.kernel.org, AJvYcCVxJxtmhplyljrQNfPXONir4tHsPcbCTi0FW/w9wdcZYBpTGkIJw/9TDSDmxBCMfgAMTGzC9rmrq9ZF@vger.kernel.org
X-Gm-Message-State: AOJu0YxlJCMOHZ9T8TIJdmqQ3kzzoX5m+3odVc+GRppXzlK4b79MLK41
	bPpF53S/uinU3x6cAOHRVCpwqzvdeXbgo2my0dmi7XTLCdndD/XJ
X-Google-Smtp-Source: AGHT+IEkxF5cW4beSYYEtxHyjAeTnq8ebNdUGgPAh31LieegcmV6+T0Nnx4rqWTO1nnGW7STvmCkOg==
X-Received: by 2002:a17:906:d554:b0:a9a:130e:120c with SMTP id a640c23a62f3a-a9de631e898mr229504666b.12.1730039833183;
        Sun, 27 Oct 2024 07:37:13 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:37:12 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv3 12/22] ARM: dts: socfpga: add Enclustra boot-mode dtsi
Date: Sun, 27 Oct 2024 14:36:44 +0000
Message-Id: <20241027143654.28474-13-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241027143654.28474-1-l.rubusch@gmail.com>
References: <20241027143654.28474-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add generic boot-mode support to Enclustra Arria10 and Cyclone5 boards.
Some Enclustra carrier boards need hardware adjustments specific to the
selected boot-mode.

Enclustra's Arria10 SoMs allow for booting from different media. By
muxing certain IO pins, the media can be selected. This muxing can be
done by gpios at runtime e.g. when flashing QSPI from off the
bootloader. But also to have statically certain boot media available,
certain adjustments to the DT are needed:
- SD: QSPI must be disabled
- eMMC: QSPI must be disabled, bus width can be doubled to 8 byte
- QSPI: any mmc is disabled, QSPI then defaults to be enabled

The boot media must be accessible to the bootloader, e.g. to load a
bitstream file, but also to the system to mount the rootfs and to use
the specific performance.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../socfpga_enclustra_mercury_bootmode_emmc.dtsi     | 12 ++++++++++++
 .../socfpga_enclustra_mercury_bootmode_qspi.dtsi     |  8 ++++++++
 .../socfpga_enclustra_mercury_bootmode_sdmmc.dtsi    |  8 ++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
new file mode 100644
index 000000000..d79cb64da
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&qspi {
+	status = "disabled";
+};
+
+&mmc {
+	bus-width = <8>;
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
new file mode 100644
index 000000000..5ba21dd8f
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&mmc {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi
new file mode 100644
index 000000000..2b102e0b6
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&qspi {
+	status = "disabled";
+};
-- 
2.25.1


