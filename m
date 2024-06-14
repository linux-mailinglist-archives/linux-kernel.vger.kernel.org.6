Return-Path: <linux-kernel+bounces-215271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9AB90907D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7072845F5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EFA19D091;
	Fri, 14 Jun 2024 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="FlN+Hvdt"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF5019ADBB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382956; cv=none; b=qKz2fcU3a6YCFvgcrfzIRlzXk2UqjQg9EnN4sbAetA/t24kQlOaLpDLHnLvscakcsrV5U/BC4WHB5tTij5XfKbekpUvsJawn11wQ35uGv8giex5aN+dSM7zJQjOEM9qnfoZwUw4TEdY2//8kI04rHC/9a7ZSjU0g0NlXjsg5NLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382956; c=relaxed/simple;
	bh=9Uv//PIDIhNFrEud7zayoVo2Y2+fPu69lRG3uydiDVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qPQgBWCTNumzXVP7GvIDTu//VdHQfNNfzNAl3wIfuQ3YMoC37SPOfmxP4k8DPlABa4gqmedecQySa2CLO20KsYUvN3WFCh8Mw5aCeFcey/QCsNU/+Zpac/1AM97B7LdajYEvvmpffZMdpiIuqaXdjm5ZgMBgdqzr6K8rd7B1MVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=FlN+Hvdt; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a4d7ba501so2966281a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718382952; x=1718987752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1mZ6Xg3BCF5HN9VBGCY2svS6vlfsx+tF7JIqIcFeQo=;
        b=FlN+HvdtSGBu3ZoVYasoq53tKWVh8YG5HPCcuazoJOxw/pH1eyhCVCBnvCjdwJk/Ku
         GkZQzH7xZDroCNXD38HmvPCLIEf6ui4J6GdeiqVYsiaLshSQdMXhrSCRMXVeKVLj9adu
         WNW8WRbgpectAczzvgBgISvFZi9GWvIFjcLA5vm8oKCtgERGWBRxZuNlkxarmMLA+uI1
         HKZN/0wBPDfDPk/bDL5OF1Mp3Ofq2OGBbIPbaujjH5N+kkmI60bRoL8rAf/jxdpKDBwF
         fyeuklTLvbvLw5U61r7FFD8O+ojKTxJtoTKucdiwqVb42xUedqI+Mlo47bTTrVBarFK9
         s2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382952; x=1718987752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1mZ6Xg3BCF5HN9VBGCY2svS6vlfsx+tF7JIqIcFeQo=;
        b=NfjCwbpaF7ee7XIE6IpZ21U+z4DmWGdVUoM7FiSTtpVXlHaOuf/FGCxKSR3cU5ly7g
         483awt5JBDWsObC7sbzhAry/BfG5LKVXPuCdhD2ISeD5gX+v3vh5k7gY4IZ3seUsbnVt
         8TL5ArpeYG/pf8LhbuCC59YSIUIYmFd+yh54HHGuembyv56kFVLzivxKMvRVKOW6g213
         w/nI5asidWWHzr0WPpS08qr4iNAFrV/m+oLcAntOaClk7wXgOI+UBCL0OW5m4B5PdIC7
         9KCZFt1O9SzIPisRuboY68lXtUQRxKmWmnafPhNYK6txKuLAXAaiEio2BTxgEwpQGaCG
         7jzA==
X-Forwarded-Encrypted: i=1; AJvYcCUts2yAg4yhqpc6qAuAsVkv4qt17otfBV1rMT6IrF1EP1OTgijAfXuBDEr5vX+FRdHLiKP6ELGFNu3OG2/OIbnb0OP3SMKaiyHokBRX
X-Gm-Message-State: AOJu0YyGFG9Z/yJlZ6f8wnLJI9N2ZT8/uvEIjcFAjQClKSEmoSnuPHbE
	QNByuHBeu8Hgsp9KCgxML9x2zrhfTY6Z5ItZXSFl1dEEYPGbmT7pY/fX5W/Km2c=
X-Google-Smtp-Source: AGHT+IFU7jz24QjE0aD7m2kTzDTqVT4xFAQAa5WztkGdzqrtdSmWclJ5lx57DK5AVkuZNzL75iIn+Q==
X-Received: by 2002:aa7:d298:0:b0:57c:c3db:2a5c with SMTP id 4fb4d7f45d1cf-57cc3db2c52mr1787153a12.10.1718382952002;
        Fri, 14 Jun 2024 09:35:52 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm2462893a12.22.2024.06.14.09.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 09:35:51 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: 
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Russell King <linux@armlinux.org.uk>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"J.M.B. Downing" <jonathan.downing@nautel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Chancel Liu <chancel.liu@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 2/4] ARM: dts: lpc32xx: Add missing properties for the i2s interfaces
Date: Fri, 14 Jun 2024 18:34:50 +0200
Message-Id: <20240614163500.386747-3-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240614163500.386747-1-piotr.wojtaszczyk@timesys.com>
References: <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com>
 <20240614163500.386747-1-piotr.wojtaszczyk@timesys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'dma-vc-names' correspond to virtual pl08x dma channels declared in
the 'phy3250.c' platform file.

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---
Changes for v3:
- Split previous commit for separate subsystems
- Add properties to match dt binding

 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
index 974410918f35..bbd2b8b6963c 100644
--- a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
@@ -221,6 +221,10 @@ spi2: spi@20090000 {
 			i2s0: i2s@20094000 {
 				compatible = "nxp,lpc3220-i2s";
 				reg = <0x20094000 0x1000>;
+				interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk LPC32XX_CLK_I2S0>;
+				dma-vc-names = "i2s0-tx", "i2s0-rx";
+				#sound-dai-cells = <0>;
 				status = "disabled";
 			};
 
@@ -237,6 +241,10 @@ sd: sd@20098000 {
 			i2s1: i2s@2009c000 {
 				compatible = "nxp,lpc3220-i2s";
 				reg = <0x2009c000 0x1000>;
+				interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk LPC32XX_CLK_I2S1>;
+				dma-vc-names = "i2s1-tx", "i2s1-rx";
+				#sound-dai-cells = <0>;
 				status = "disabled";
 			};
 
-- 
2.25.1


