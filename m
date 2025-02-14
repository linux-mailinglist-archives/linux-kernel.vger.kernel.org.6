Return-Path: <linux-kernel+bounces-515179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E803A3615F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05ED87A5C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346732676D8;
	Fri, 14 Feb 2025 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Duov3jGr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AAD2673A8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546262; cv=none; b=CODVNtkhCravLZaT2kmGkdaefQk0nkSe+F4H2ekegpmOQHNXLPxOpO9VoLiZs6u9qMmUCOezZdmZkLDn+JKTl/KVtGbNd11zwRZv90XyMW6b2GZMcy3Hv0sp/X0FoXVFZFDqMlwqKYH2XkyoieLfbsKNRv6HprlYA7/xpSdTEPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546262; c=relaxed/simple;
	bh=JW1oohGJWsBc3d6n5iD7RAtqQIWyKDAHKpAXb1hkGTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9MtcKRN7cq9N8hgPf/KUwraKYYJvU2eUJarPc7xmNhzO0q5SkSOrmQ8jSkkdddFl88GJW3utKAD+dxgg7/wUmbKuBMcoSnI64cYLIGgXncKLLGwsnxqCx0qoJQOXq7MmzP7amJFehC2G20dTUT/JpEbCXnzFe4eW9L+R0HH7kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Duov3jGr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739546260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0SshwRt8Gl3GApBo9RGajwM4sy4zKiOT3YLnoVCQViY=;
	b=Duov3jGrIxLrR+PWeg0gXFNwaS0DFdXhucQdQBHxgKmQwLsWUOo9yR+JthRs3/Rqks36cI
	Yf1gwkOerFgfNwu1ooCReQWntwtFg//XMX6dqgcrSMbJyrf90bnp6jNcnAp9D0RT8MjPP8
	8+BAeeVut3GTjNGxaOXuX9AUjTL4rhw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-C3d7cYumODuR3mBe5epPlg-1; Fri, 14 Feb 2025 10:17:39 -0500
X-MC-Unique: C3d7cYumODuR3mBe5epPlg-1
X-Mimecast-MFC-AGG-ID: C3d7cYumODuR3mBe5epPlg_1739546258
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4393e8738b3so17628625e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:17:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546257; x=1740151057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SshwRt8Gl3GApBo9RGajwM4sy4zKiOT3YLnoVCQViY=;
        b=mjf4P7uZfAU75YV7eeV3Tka5bfaP8VvJ802LR6KLNJxTUPpJZeP0O5oXtOa4vtqvzA
         4Xy7T+xAsv3z/G8SjWUukDExMJ05MR4wTa1pON2FGRNfvl/2nVHM7z7HF/7e9Rp8JuAe
         8jrzTlf4Xp4f6cJj+FDkHEfXwGFyzYzSvVmKsf+sg8Sgid12xhYi42sRW7v7RBJBD4tg
         IxMmDH/IUAMJK0kVour6TcQr/6mMsGLpHKSsGLIMuKIO30u4c5+6It1Y0g/4IAlRSVla
         XJlJDMrdtARHJQBMzE1lQOh3rakhT5ROOkCEKYBgpngk0MBxC/HAtXmQ/A7ZX/mQVH62
         6Vcw==
X-Gm-Message-State: AOJu0YywRKmb8r4RZfxmrROUCVv6mdU8xh67aBlYMp9K7wfDjyKF1lP+
	s3Na/ri1XiOClTkPEtbQGEOYMviRofNB0wMBjEg08YtAJxjIYpg7CDaBy5MBErDK7//Wtfymd1O
	rKTYdsLFcKpzD/Kf1un0N5XaTZuK89ruWLVinkf+1FUTw8FRRNKOipIS0DURYUCEXUx5JIrs1aK
	DUnGQoL98OKaq37xoU3MkGnQR6rzd97VnSAnWgFYqZa9/C
X-Gm-Gg: ASbGncvqPAlg9T6UhhyhHdUaO2BNCIOLdpuJR/orVrpHrnSA4aC/N76ok8LeEDVi9wT
	oGRz8FG4ahJ3ZJhFOI6vopFLiy7/GhzyLE1JtVVIizSqqhwKvr5zn+4mMHLO8pl/ZreQFYONs/k
	fFQ3aeWg6wS2ijEb1fdhEAipP6mzsLhglIWSHk0IvUjwwWFBLztrLIcfRUQT9e60hdCEqckIjCW
	9KF0+V2n6TXFU6VvWB2dTrTchuokM5SgA5i4whMYMTccJb2tN1+6c45yvmZ/gGxzXqM8RPe6S0l
	zLUmp0O6dKRG5X0Mqf+3FzHFUPq8Yw==
X-Received: by 2002:a05:600c:3542:b0:439:6e12:fdb4 with SMTP id 5b1f17b1804b1-4396e13034cmr4525e9.14.1739546257030;
        Fri, 14 Feb 2025 07:17:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3/3JFKYy9eGyD7IGPX1BVb9PSRrb5ZVdMvOU2CUr5TK3oN3GiUFe6oGPOq5SoYQYtuJNygg==
X-Received: by 2002:a05:600c:3542:b0:439:6e12:fdb4 with SMTP id 5b1f17b1804b1-4396e13034cmr3705e9.14.1739546256365;
        Fri, 14 Feb 2025 07:17:36 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5ef9sm4841762f8f.76.2025.02.14.07.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:17:35 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: javier@dowhile0.org,
	rjones@redhat.com,
	abologna@redhat.com,
	spacemit@lists.linux.dev,
	Javier Martinez Canillas <javierm@redhat.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 2/2] riscv: dts: spacemit: Add Milk-V Jupiter board device tree
Date: Fri, 14 Feb 2025 16:16:38 +0100
Message-ID: <20250214151700.666544-3-javierm@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214151700.666544-1-javierm@redhat.com>
References: <20250214151700.666544-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support for the Milk-V Jupiter board [1], which is a Mini ITX
computer based on the SpacemiT K1/M1 Octa-Core X60 64-bit RISC-V SoC [2].

There are two variant for this board, one using the K1 chip and another
using the M1 chip. The main difference is that the M1 can run at a higher
frequency than the K1, thanks to its packaging.

For now, only a DTS for the K1 variant is added since there isn't support
yet for the X60 cores operating performance and thermal trip points.

The support is minimal, but at least allows to boot into a serial console.

Link: https://milkv.io/jupiter [1]
Link: https://www.spacemit.com/en/key-stone-k1 [2]
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 arch/riscv/boot/dts/spacemit/Makefile         |  1 +
 .../boot/dts/spacemit/k1-milkv-jupiter.dts    | 27 +++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts

diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
index ac617319a574..92e13ce1c16d 100644
--- a/arch/riscv/boot/dts/spacemit/Makefile
+++ b/arch/riscv/boot/dts/spacemit/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-bananapi-f3.dtb
+dtb-$(CONFIG_ARCH_SPACEMIT) += k1-milkv-jupiter.dtb
diff --git a/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts b/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
new file mode 100644
index 000000000000..448319214104
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
+ * Copyright (C) 2025 Javier Martinez Canillas <javierm@redhat.com>
+ */
+
+#include "k1.dtsi"
+#include "k1-pinctrl.dtsi"
+
+/ {
+	model = "Milk-V Jupiter (K1)";
+	compatible = "milkv,jupiter", "spacemit,k1";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_2_cfg>;
+	status = "okay";
+};
-- 
2.48.1


