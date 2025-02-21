Return-Path: <linux-kernel+bounces-526508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A38C9A3FFA6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02D819E079D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969DF253F39;
	Fri, 21 Feb 2025 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWetsClV"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57524253F0C;
	Fri, 21 Feb 2025 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165601; cv=none; b=OzniWXc26SxpkH42EL3VBI5ID6rH/LWVKdC0IEaOzn08wt4UMrdALrdE7ZWfxi+3wpa08SR3VzGLK/GZW1Ve/neCZfDLEdFmOWooL5FJb+4Qo0tIEol36otcmHcnePx07Epi1yH6rsz34Pxvlc6+412fJhhr0ILdlT9UlPxHZWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165601; c=relaxed/simple;
	bh=kOraS8IqYhByuh3EYq/JHZv1tOR/Rwv4bGyv8G1S23I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u9eo7T2jAQmKOFIM8iaODKj3lUykmK1NSBIU7irM58f2aGIQVGYZQRb7OGnHDvArL/+AUvA5TcDolHT4jldhnbXycKawV/7YAk+skMN1j3e3xdPhoIDDcK52OtSM3iTixH9Od8JuMqBmuayJaM3nZMY26OiJ+zuf12vhwtxCpa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWetsClV; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dec996069aso3976646a12.2;
        Fri, 21 Feb 2025 11:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740165598; x=1740770398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PW85pz5cGLvJh0OtF1LDKynxXRX33ioDpLb0ZUqgao=;
        b=OWetsClVZG3c568ymgE9fLvpPaDSQizmYfEk2NbAcnWezI8SCYbf8CJOToRRD4Ttrz
         eTB+SbWW5NPvH9+Mxon/KZTaIjdHbcH1f0cEu21xu9Ae0gYMMTLXCG4IFlQLLZZgUvF6
         FsaBc866erMp/zPjM5eblfx6f3l9junk9BGYJmFfED0vcqgHgTtScHX3gab3oVYzT2hI
         qcKNoP/aBhD+t7lUv+v29B6IZQW1HIgZmGAxfkihfPHvAeoXjam1LPgYMEQy2uSh4VUR
         862uuW45goKtXaFtl4WyCwQJTSsaM1MiFjkfIiVKZW0F8Sr6DpTYfo7X310R2MTs3UI2
         c3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740165598; x=1740770398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0PW85pz5cGLvJh0OtF1LDKynxXRX33ioDpLb0ZUqgao=;
        b=Hh6uoqJvOB9hiYtRBFQGo4/S/G24k8Kad21wKh10gsYI8lSWFPmA/hbMyU/HQWLds4
         wl3Ej2R2dpl6nK1fTxBi5zsuOBQTy87lsHd3OFgMdJGWhlh+t29fTDT9Gq8NCCHLatpO
         ie16mp/l+f+Pk3wZ7WPV+ucBxgAr6R+JTcMRbDhL5TlMv97s7R99IDvQKCA9JMP+lE6Z
         UR19xZQmaBXt40z/P+HTQQXUKiBsuFhN188KUEPsubMGOL3pfTIBm5tZ3u+MWnbPsZoP
         4JP/m7vMLzzmmrnzSF8g1ecF+TNtqIERUM8P5I4StmmwgWWjF10gom0pajMpZq3XW+OD
         sRTw==
X-Forwarded-Encrypted: i=1; AJvYcCWCRuBERirsa+n0xRYursm12E+auqIEqUvfSZjfQF3HWfC4iHr4fmQyG9DWdtXbMsl5YEqzA8bIhXSot2c/@vger.kernel.org, AJvYcCXpbvY5ilAHdh1/9V6t+FCYx2vBQ33MvG1pcAjXtQkcBHekMzMXoJTxo3gFJZ9VcDE7p5LJyBKURH4D@vger.kernel.org
X-Gm-Message-State: AOJu0YzhgfmOfLal448aNUMPYN7tWLOVJhlyPc6R+m/VpnYy83Wi9r9t
	9j/jai3Ql80bFszUbgl0Og6UxnHPTcJp3wkPIW4Ymf2OLU736DTd
X-Gm-Gg: ASbGncur9JmS/aKnY79FpxXLOU/5OilX8KqU/n3JpAV12sY9HxL4jO8aNYHIoVrI3ZM
	LQLVDhhzs3WGjo6IPeHcJduZ4OpH8mm06WXARy2zRClG1vrQ6QW9LAHfF5c+fAxzIBC/yemxtae
	LuKulaFaScXNweRfqxBFhXUB8RKnVEbDy99xuD74/Ab5mu+xsaEKEVMcEdychRuSqHORQh2NNyg
	QnHKz55KD4LhcfOaG28iVDHWEQqRaCeslLF+sIa3my6521As0rs9/78ososwsqxQZkWXxe5sLgo
	zY9chpYQef94OMBfV/fkS+LI2dTKnbcZR7PVgT+ua5qqwgHmtjqOwhYU5aA=
X-Google-Smtp-Source: AGHT+IHGNlBjv0prPEJON601/v7KmS0YwqUhGMf4lS65c24qSw6LwRCeA8Y99uRFtQLi0vwiyNDqXQ==
X-Received: by 2002:a17:907:6e8a:b0:abb:e95e:f2c3 with SMTP id a640c23a62f3a-abc09d356f1mr472726066b.41.1740165597467;
        Fri, 21 Feb 2025 11:19:57 -0800 (PST)
Received: from playground.nxp.com ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9cee79fasm995276266b.129.2025.02.21.11.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:19:57 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: imx8mp: make 'dsp' node depend on 'aips5'
Date: Fri, 21 Feb 2025 14:19:09 -0500
Message-Id: <20250221191909.31874-6-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
References: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The DSP may want to access peripherals on AIPSTZ5. To do so, the
security-related registers of the bridge have to be configured before
the DSP is started. Enforce a dependency on AIPSTZ5 by adding the
'access-controllers' property to the 'dsp' node.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index a1d9b834d2da..9ec51e7e6678 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2423,6 +2423,7 @@ dsp: dsp@3b6e8000 {
 			mboxes = <&mu2 2 0>, <&mu2 2 1>,
 				<&mu2 3 0>, <&mu2 3 1>;
 			memory-region = <&dsp_reserved>;
+			access-controllers = <&aips5>;
 			status = "disabled";
 		};
 	};
-- 
2.34.1


