Return-Path: <linux-kernel+bounces-266162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EB793FBD0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B30A1C2103E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9AF15F41D;
	Mon, 29 Jul 2024 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELLXluRt"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E6315F301;
	Mon, 29 Jul 2024 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271675; cv=none; b=O4IOSopGx0ExRtXmQiyoDqn4CBB2oDyzBKm0HXFnIDe3rczF/WJy/99JhOr4CNpJbiSXuV1vXpXB1w4dylmSdGlr8Ud+71Zx52ENYgbDpYnR8CMMuEpubD+0+D8LETtSXohqdlbcUjkMuEi9ZuKb0vAwyfvpAfl3r4IXZcxI6z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271675; c=relaxed/simple;
	bh=J0gsZdvM4TTjvgwxecx1IeUq/HrBdJag42zJRTAFvQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=unscrL/KwMN103s4nBfSWQqZ1X+O13L8thLNRaqnz4h2fVQJkjd10r5qz4m5UGfjL6aeIqJwIvTyu5Su8Gb5jUY5twhWEknYUQLhPb2un1LWorkGTxF3RdB/Hd2rpSwSwzXkiqAWPfGDY3tCh7egUkowqCKCrcEi6gaK4+m/9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELLXluRt; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e05ef3aefcfso2265005276.2;
        Mon, 29 Jul 2024 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722271672; x=1722876472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9gwTCEqRccgI7/MSiW2vw7+v9RTbvBSGbIl8hm42GSQ=;
        b=ELLXluRtdSJBlKEfggVSK/hqJuvG0n1bZCvxuYN5rUTqnwn4K20KExEUKdCDGlG2mR
         M+zH8/frPRyMameJ7+xQ2F9uMtH/XyZnxBT4QMXWdmU+DS+Q1ScFkQqqAtCUXAyzmTkW
         L/yB0M+uTI/79Y6YaaSWYPQ5aH5TcOlWreTzLXT5v+QKmlo6eKqS5jE2hkIGRPb5a9wO
         1yNZ6IcAqxR4WmidDGMNcfWEzUJhoWaqBiV/YaogI8O53Y1jehaOsOxeszsxLsuKmDsA
         ifDkBH3PQS2gCzbLXx7MWygGeeuR6Iiu7+cb/4rO+CffuPFtuluyOSGq0d0s1EFVcVzh
         psEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271672; x=1722876472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gwTCEqRccgI7/MSiW2vw7+v9RTbvBSGbIl8hm42GSQ=;
        b=CVbSLOpQ2m3Wn++fv0B1iBFUsENZPXJcaX6tFckdYkkwJOPv6s9Lo29154CChvpm48
         RsIpp3Dg2D80U2YPmZaV9KqmU14FkSmLWOkOvBRH41IcPUP6GV74AIM+9Dj0lQUXD5LY
         zVGBVvq5FpTiapaYJWY3BYKuDz5YoALE6u5v3DfxsjczrvAAfZz4iy2mWjV9ss4uYz17
         TrPoBm2fxsPw+C4mOZr6CL/vNPPtnPgVSrNO/J19/MeULLnygqT8E5KrTiAZ8G5ttEwy
         ckSJVAYXfTHxth1hPF8xioAj6jkamG7hjxM7XFvWlAb/QXcD/vmSG7xz+SNcXsi45xbr
         MIgA==
X-Forwarded-Encrypted: i=1; AJvYcCVuEfKefislrMSJ05/GLF3SGXASgQRtgGjlWNSPRy7VRHO3z3vPPajV/5eV/k0I2d4oRVs+MD6XVAuL0VIZMpYcl876HfDO9VVmpH/BwF3mUr0jgoTMzwZMhZul645G+NlXUj0R2cD8mY76SF9Fo4K3L2JIaChVqkiMoCrEiFy6FEBAIscWdE+6e2/A4w==
X-Gm-Message-State: AOJu0Yyf2sIOkUVwxmf3+TQUs0wwDb6NfpXtdaA6X7QxcVBtkhl0U9mM
	NcrF2IjCaGir9dP9apAzK4wFbXMgMVfpe1TnOoB6HUX4l3ByW1nI
X-Google-Smtp-Source: AGHT+IE5UVYmoHRsexfFfroI43G1rYzF/zk88j0ZYLtr35hJAqGMYetGXwFHEEgR28JfJC7Iu/v8cg==
X-Received: by 2002:a05:6902:260e:b0:e06:d61b:2c17 with SMTP id 3f1490d57ef6-e0b545adb76mr9313644276.40.1722271672362;
        Mon, 29 Jul 2024 09:47:52 -0700 (PDT)
Received: from x13.. ([157.23.249.83])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b4ebc5d8fsm1237833276.3.2024.07.29.09.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:47:52 -0700 (PDT)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: W_Armin@gmx.de,
	corbet@lwn.net
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] wmi: Fix spelling
Date: Mon, 29 Jul 2024 12:47:18 -0400
Message-ID: <20240729164721.125708-1-luis.hernandez093@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
---
 Documentation/wmi/devices/msi-wmi-platform.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/wmi/devices/msi-wmi-platform.rst b/Documentation/wmi/devices/msi-wmi-platform.rst
index 29b1b2e6d42c..31a136942892 100644
--- a/Documentation/wmi/devices/msi-wmi-platform.rst
+++ b/Documentation/wmi/devices/msi-wmi-platform.rst
@@ -130,12 +130,12 @@ data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
 
 Due to a peculiarity in how Windows handles the ``CreateByteField()`` ACPI operator (errors only
 happen when a invalid byte field is ultimately accessed), all methods require a 32 byte input
-buffer, even if the Binay MOF says otherwise.
+buffer, even if the Binary MOF says otherwise.
 
 The input buffer contains a single byte to select the subfeature to be accessed and 31 bytes of
 input data, the meaning of which depends on the subfeature being accessed.
 
-The output buffer contains a singe byte which signals success or failure (``0x00`` on failure)
+The output buffer contains a single byte which signals success or failure (``0x00`` on failure)
 and 31 bytes of output data, the meaning if which depends on the subfeature being accessed.
 
 WMI method Get_EC()
@@ -147,7 +147,7 @@ data contains a flag byte and a 28 byte controller firmware version string.
 The first 4 bits of the flag byte contain the minor version of the embedded controller interface,
 with the next 2 bits containing the major version of the embedded controller interface.
 
-The 7th bit signals if the embedded controller page chaged (exact meaning is unknown), and the
+The 7th bit signals if the embedded controller page changed (exact meaning is unknown), and the
 last bit signals if the platform is a Tigerlake platform.
 
 The MSI software seems to only use this interface when the last bit is set.
-- 
2.45.2


