Return-Path: <linux-kernel+bounces-574028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA29FA6DFC0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8B8170E61
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D921264A6C;
	Mon, 24 Mar 2025 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQXijb/6"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14241264624;
	Mon, 24 Mar 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833822; cv=none; b=XKta+r8jCGlNlXFjbmMmDXoAHJ3x4hHoIY5qhDrQ39Bx73iEMh+8DAfb2IvEFkTwUm0dCbewgPDF3djgGQld5BBAOA/nfdq8Oplrid/q9ejbHOeAz9nlYPaxs2o2GC2AxsiCAqmeB49Ur5B99PPOtmFxX/OexABUT2hsZEzWXJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833822; c=relaxed/simple;
	bh=8TTMenqqnPPI38gwxk24+UYMgJl+buQli4nIdMttr4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YW0bQ78j7g5dLSPjADzo0JMWK2fcYymJI0K//jTTHHo6w3j2EVw/3VB2sKsm1BCC7OvYb5R8YZWGUk58veg4iFnZRjY+kINrzpvehkfHl6/ojJ8hcA/N4/zPBEh1+DTafGdUeziA4osyo+yPcbvYSLYbaw34g05IyoryAA1XiBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQXijb/6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso4389060f8f.2;
        Mon, 24 Mar 2025 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742833819; x=1743438619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meQ0Mipo8UgEq53792yFhZe7Xcnc763+mjkb31Obgck=;
        b=MQXijb/6a48AFsDFXAv+brQI3tb9fma70K9Z1FoDE3z0Gs9L1gw3dGw+uJr5McirSY
         Q9lafOaQaCsl1X7Sakx3iv4JCCUoEEX654HORI9PHc+ONfrzpLUe5JdmjCvzuZDNzEqs
         W5rcbOQCTJSj2Mlt0K7cF964JneAVI1fdQ/XNrrFrtrkc/mJi2igr7scj/rNCCwrhht4
         BTq4jK3BIxAe5G/xw1scV4wFyBaRSCoKQgfzFw43SWHTKYEVNlHxXC17lQgWmIsjDXVc
         KZiyDWbN3RfEeWbrSlwUk/Rphuzc4gd39FwYS3z9eo87pV4Medc9ockoquGcqGFz+i4l
         lEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742833819; x=1743438619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meQ0Mipo8UgEq53792yFhZe7Xcnc763+mjkb31Obgck=;
        b=MTkPXzFNGOTe3BcBI7bRcTgSPoGgvEo9hg2y2HpS1Z5DducVjfZjmH5xWh10QvnuJW
         eohttBuzgJfGIUW/5Oid8nM0Kn1kJrpUD2r3HiDZeRz7JfuRkNEfou88e3POZs+tSZz7
         BbH5etIM7N7vaQFRPgOWBtRB1vm+81t5Q20+m1JkkyWKofAohjl6XjJ5DzT8AOr/2Get
         KsnMsDeCDmfKXLwNkoYjaYSNmcxEtNXMu0JOnJl19B6Zx1nEesZhE1KK7ZYPEkJ+29CA
         kVpUpWOxg+pLY07XqD3crjzPy8PkXU/UUF8nAT/eRpURFNI7DDsmlSIw+4woEeD0mAuL
         vFjA==
X-Forwarded-Encrypted: i=1; AJvYcCX5yW3LaSiMCPJaM4ifmyZ7+4uXXK/NQ+S/n7/WE3JilF0T/BJDiKD6YFq09mWxafGW4/awvcvSBlN1hUQF@vger.kernel.org, AJvYcCXTC1Xxxi49uJbDTB3jJRB1kEdLU0Bk40zA2vmkFdFhLz7LHluy4yASw3tvlXN+KcqIN57HRpGwzo9g@vger.kernel.org
X-Gm-Message-State: AOJu0YzJXs7fzwxYiYUFLZBX+xPLtFEymMOUEkO/Hk42+4qQtxfnIuAu
	H3Xr9AmJKiabdbswiye+0WhSmM8ODO2NOiQGi1vUM3n/bIHHFvo+HPBiCYRj
X-Gm-Gg: ASbGncsQfYp3jOV3KR5fiX2QMzJfzE+0zdDoQaYUmZUkD8QPDB0d5GpD3CoFPRImlnq
	tZV4CFzToFNFPwZxtv9wFPKbbjw41LJ5aoD//uVllw/MaqwCdZn3eVQRwTKxeEAwTH5nbagBzem
	xXvAV4vPnhQK5qRg3UEKhikLgj+fnKVDLBl6hKBQiF7rsykvKu3e378WceSoEoxyvT0IiitLsHE
	jV+5uzr1VU+PAJm9ihs7q6rcgqGTIot1a8M/Q+F+HHoT/3UMJB73NZBJIU7XvIro7EfBUB1wrC0
	bj1vI3shjdmyYrjMAVpPUmrvtcFvT6xDZonTIYvsvcARV1mjkhbhEARFiag0iRkUVlz4U5t5Pxu
	1Yz8NF3U=
X-Google-Smtp-Source: AGHT+IE66Gqa84UGtwTooRZYvTVucmMfLSU4uitXios1JhaytT2gQ5+HpqGU4z5hPX3SCx18hnX4JQ==
X-Received: by 2002:a5d:47c6:0:b0:399:6d54:25ce with SMTP id ffacd0b85a97d-3997f8f9cc4mr9475035f8f.7.1742833819118;
        Mon, 24 Mar 2025 09:30:19 -0700 (PDT)
Received: from playground.localdomain ([82.79.237.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdb0669sm124106765e9.34.2025.03.24.09.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 09:30:18 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] arm64: dts: imx8mp: make 'dsp' node depend on 'aips5'
Date: Mon, 24 Mar 2025 12:25:56 -0400
Message-Id: <20250324162556.30972-6-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324162556.30972-1-laurentiumihalcea111@gmail.com>
References: <20250324162556.30972-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The DSP needs to access peripherals on AIPSTZ5 (to communicate with
the AP using AUDIOMIX MU, for instance). To do so, the security-related
registers of the bridge have to be configured before the DSP is started.
Enforce a dependency on AIPSTZ5 by adding the 'access-controllers'
property to the 'dsp' node.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index ce9f6da1e257..db14e85023a0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2425,6 +2425,7 @@ dsp: dsp@3b6e8000 {
 			mboxes = <&mu2 2 0>, <&mu2 2 1>,
 				<&mu2 3 0>, <&mu2 3 1>;
 			memory-region = <&dsp_reserved>;
+			access-controllers = <&aips5>;
 			status = "disabled";
 		};
 	};
-- 
2.34.1


