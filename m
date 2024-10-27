Return-Path: <linux-kernel+bounces-383659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 477679B1ED3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001AB1F21731
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B05B166307;
	Sun, 27 Oct 2024 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmGmZcDn"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954B016BE2A;
	Sun, 27 Oct 2024 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039832; cv=none; b=Lq62rJrLGR7jgCTk08SO8PicDnfVLfPv4bYT7pkiVw3u/7QXCO14ZkOe6Dxzi22vLMMi/lipMcmwKEfkKGhxmmFajzJxxeQGoeWDP4KTBbkT9KJEA0Oe//DWFqwx7F1tJe385BrbGHBG2V23bQ83zA52EGrA/k3M6nD46Ai1IAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039832; c=relaxed/simple;
	bh=Ek3f9IntqkTVZaMM5+9uMLvwBlmFC1g5tii851ibiMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=REjDBgo32GVp5SwdzwL1eQsLufKfRtqREhUWV7NsIomMoIJv2oCLlgNyl7xJ83u2z8GZFA9QVkrziy4zL6jn7PPOdBR2XLxquJEjAnXbx580/eS17QvdJZnoClycTP64iVm0QzwGg2+AEm0umUNczJWTGaG4Bb47dmzffnFFOdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmGmZcDn; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c93346dfc8so439944a12.3;
        Sun, 27 Oct 2024 07:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039829; x=1730644629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxrWAGvbebnl7bShJIljz1Nm6dGXiAY6T1E3WWpWzg0=;
        b=NmGmZcDnBPW6RlFD9QZd+ngfTQfXty53NxwB4i5mTE+yaZqhppHwPmHc4B7wXcgFEt
         /kWi095bvHrMQadWm6Y0z9ghFhMAPaSFcLUqF/CFmPmQULgLvM/dx5YtzeZyULUURfDK
         7o3/q2oxdTnaKZdpiODcSV6q8GFEtirL3K9TFx2usfT/b1eeUluDXl0iU2HumYt/8HPu
         TngEYvEPD/4VLiEWpE5uzjFlScv3d4SeudT78gCPv2R3GkXdqoFTYNZ5H5IyHNY9RQn0
         ZkOnrePdnODUAjviUnFLQo+0bjkNFB//aa6H3lEbMVknijzSmIaJELb6OP6sTZFEIqQX
         BPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039829; x=1730644629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxrWAGvbebnl7bShJIljz1Nm6dGXiAY6T1E3WWpWzg0=;
        b=JDREZylQuiymfeiHYYeCOPfJK+PD7gr8M6scv5F0Jze/koKA2qR7UusGtI6H31ItZt
         bq2baPGtWHsK2QfqaZzSntZG05DIhbThGL1KRjip65maA+TlnjLu9Wi7y2MsPGjXDxr0
         zyN3+CJZPUXGnB0QTTkYLS6kU00xqp+RbgRvd5WUhZU6s2woLxNn0RgyKXgT6dm1S1LS
         LXLr/d6j8sBcLiFRDvztpFPFk1x2a301Pnm4q9jTjF8RUCZSLrchKhZ07wfkgZbhkAz4
         KoiDju1g275GDM83Ig+1Uh2wHWlIMgSIPROxlad/pPIRL2U2D0zBGj4RlzNvdDdtv37q
         JIqA==
X-Forwarded-Encrypted: i=1; AJvYcCUW025So2cPYxB7ufN9LqTE214/btFxILzV+fwpTmuzB5nqoo2lG3katOWwUvKq3Fa7Z/YBuafatcUv@vger.kernel.org, AJvYcCVggSe8U9oIq/oT/G7rdbCHX59JbYY9nEgRIWINFVWPIoWsO17k1pWhYSvyETtluSTwZSlo9kqWyshlMlXi@vger.kernel.org
X-Gm-Message-State: AOJu0YwsN5o/kt1z3M1soHUUgj8wx55oGPakCIQpiBmMw4N2Y8daa0R1
	x4D8S2eROIIJH5wUBddkdeY82VQPK/BS3NnYe9cTLTXD9CTogFvQ
X-Google-Smtp-Source: AGHT+IETuQshlPZqNCPXWVTwiqOC89FiAISLisVuq0sLvAjg6bOHaNi5XZVV7rgtSNaIEig0IX+2mw==
X-Received: by 2002:a17:907:7d92:b0:a99:5f45:cb66 with SMTP id a640c23a62f3a-a9de6175f4cmr239115166b.11.1730039828475;
        Sun, 27 Oct 2024 07:37:08 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:37:08 -0700 (PDT)
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
Subject: [PATCHv3 09/22] ARM: dts: socfpga: add ranges property to sram
Date: Sun, 27 Oct 2024 14:36:41 +0000
Message-Id: <20241027143654.28474-10-l.rubusch@gmail.com>
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

Add 'ranges' to the SRAM node as it is a required property by the
dtschema.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 5f4bed187..6a2ecc7ed 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -691,6 +691,7 @@ ocram: sram@ffe00000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			reg = <0xffe00000 0x40000>;
+			ranges;
 		};
 
 		eccmgr: eccmgr {
-- 
2.25.1


