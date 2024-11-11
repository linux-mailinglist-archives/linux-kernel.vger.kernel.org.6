Return-Path: <linux-kernel+bounces-403818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1909C3B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3AED280EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C721714C4;
	Mon, 11 Nov 2024 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgsvkN/q"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7A5137747;
	Mon, 11 Nov 2024 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731318360; cv=none; b=lC7p+64KQjsMdTMY89U6EXZeeZcCOjy72rAoe5cutnkFK/o6hnXWVpAIfQfEV+nV0e/BqVcfeu4o3OEtUqSv9nPDj2rupGGCbl0kZBk+e9fLJvSUUDaz1R22b3clObHdKw5NcOrRYGVT7lSKu8g+3Gms4G8n5bEknSiFuf5XeTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731318360; c=relaxed/simple;
	bh=V1hOGXGZiBL/idQ/It2mFYhUKDhAasilhxXrcPpY+xs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cMoe+ea9M7QwBTA0EsqxBuaNjmej6h778m6rkFXYf+dJFVL6z8qHtSjAHxIkplSXyTFJxIzfPX+4DVDeJHZnpeKniGiKqKir8GCnTar17Tap+8DnnUCk3rvJyLNay73+TqgnwaD23kzpKaYG/RjCFUW2C+RhlLJpa25zCEQoCEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgsvkN/q; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cb47387ceso44132275ad.1;
        Mon, 11 Nov 2024 01:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731318358; x=1731923158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qh0sbGLe3R9T6iLNooRlLszG+yIe2rtAwnz37rl7QI0=;
        b=DgsvkN/qXD91bqQ6xhBGlgG2q4vjYd+MVYvxyAKA7/iA/frHR/VK+WdnURfsirYsox
         K8xT2HIxGEjRO6cb0Vk0NGZQB3q0JcmphruBCcchvafdGJQ0mYbbX6Z5E8oPV/mDBc4E
         /t+pH6VFBuNPXi7xBESJD5a8K0eoUXUAMX8JUMwGmYegMrMMZFvW4sATQMVIdvJaT4bc
         xhGXqrC4V2QtKP4R26PA0CJAm2tL2sNfBBxwzQ75aS9Si5gj6Bd61s4uXELtL/uGxco7
         AflKVJolw5Ld4hE1TZOKD9BmUfeCb4aICdEwu6AXEF/NkfuGdE/nkGH5C5fFJY9Xojl1
         FJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318358; x=1731923158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qh0sbGLe3R9T6iLNooRlLszG+yIe2rtAwnz37rl7QI0=;
        b=T7pfD9ftk+RWwW1awiYPoxOIA2VJwNtKKic984/MgZ/KXaJp1dtnFdKKyRWopXIQKy
         /72N1ao7eNS+1OmL0Nj59XLj448Uw+K3z+CH5AyUUUBOBrHckFxSQnJBkXhy2gw6mngb
         jIElfknIC9FhlZsTCy4fw4kbT7wnxei5uFTNDssH7GGpwun4NOP37krri2n0Xv0LpDWF
         UiEvZe+iG/7MliBkmcQPJY9uBsSi0z3t49aovyuv3zPf1SGz2EI6O07MC5Gz8jNLzQp+
         +/166t2EAycgdd+Nvr0FF6ufov+tDsnNb1DXdN3TvJiBZhFjYKzPGS02x/GZSvTOvPMo
         AFzg==
X-Forwarded-Encrypted: i=1; AJvYcCUW/nQcYhifhUKhAIE9cPVzhhSVHpf0YQIlOdh1hnR8h0YUN6YRDwAwiBxFjRi4g8g1CQ6v/wvNHVditC/Y@vger.kernel.org, AJvYcCWKrPE50VeKT9teGb5NEcOZkws+ZONBhw+CWMMea/kx9+JZOJWRfvTLH0rfw70GffBluLA4bYH7kr9/@vger.kernel.org
X-Gm-Message-State: AOJu0YwXxtFDYmTb3CnakoJxNU1kz6Q72K4AIrqnjZa1/mch/3Gjc0vt
	W3ue17tk63tMH11sSAQqgezizMgabFrgTobrge6K9MQeJ0RaLtZ/
X-Google-Smtp-Source: AGHT+IEduPFER/8zbCIpz3Qeo+YquIeSgZo4edxmkNCTUQhErCW4SvbzAD9W8yw8RfIcEx/aOFKrAg==
X-Received: by 2002:a17:902:db0d:b0:20c:6b11:deef with SMTP id d9443c01a7336-211835bb654mr154930535ad.48.1731318358386;
        Mon, 11 Nov 2024 01:45:58 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc826fsm72248725ad.11.2024.11.11.01.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:45:58 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] ARM: dts: aspeed: Harma: Add retimer device
Date: Mon, 11 Nov 2024 17:43:46 +0800
Message-Id: <20241111094349.2894060-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
References: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pt5161l device in i2c bus12 and bus21.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index ccb45ca840cd..fd85d5e34a55 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -299,6 +299,10 @@ imux21: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+			retimer@24 {
+				compatible = "asteralabs,pt5161l";
+				reg = <0x24>;
+			};
 		};
 	};
 };
@@ -429,6 +433,10 @@ eeprom@52 {
 
 &i2c12 {
 	status = "okay";
+	retimer@24 {
+		compatible = "asteralabs,pt5161l";
+		reg = <0x24>;
+	};
 };
 
 &i2c13 {
-- 
2.25.1


