Return-Path: <linux-kernel+bounces-403820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548B79C3B42
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C93E7B22FCE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165D117DFE3;
	Mon, 11 Nov 2024 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs/ooUz3"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3D617A90F;
	Mon, 11 Nov 2024 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731318365; cv=none; b=qjIqyp4G/Hejofqh++CO48nndhpfcWb/cbuN6Vo+8jSTA1YIMe4z6uFAiAi5D0qbAHhtLyz8WTU+0q7QJ2UElhvQvCttOL48v1s4V5ywzDFYiHOMdbSQJjUtPzvOwQZMVKW5YBhAEma4T7ADa2UgMBNpIWX1zU/24nvL7yeeWsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731318365; c=relaxed/simple;
	bh=/GpinvJD+IE1gFPCcRsT5yiq3ogqQ+inUNNKgo7ReqM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f/GJ1qYto7oA60nfNHmLrcUKeMKtUFxihQKLPMUOjfjXUVlRwJwODhbtFBKidAbYRbW8J/ec8caoE+3ljiZzW0n942nWpni8fP+W0CtGgIpkkLzTuIN4OUw4aAjoeEZavNwbf+k7UYpO3jLQfbwCIESbIaEzdwxYwA6Y+0s4X4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gs/ooUz3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ce5e3b116so38638785ad.1;
        Mon, 11 Nov 2024 01:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731318363; x=1731923163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Moeko09cNn/tBMWxRyaAP4nMoxzoQVrPZMKwS5ag9u4=;
        b=gs/ooUz3m3UQaX/YZZayg2twIEa7y+43QWvWFUcBqqHv1pqWvm/riBDGdL9Je3R/eB
         oCToIWK2egc+Q1m+Ltg5O89XSRzrt1Q54lkrZSbYxsUviMW1DnGqSNUkMm39M0VwtrSy
         383EBcizfi3gwuW8SqQ4r2i7M1GyasrcPvONuSIZpoypDwJ5BCAXf/JtquPPGNL30Co5
         z/FMCnC49TyiR5/mnHfGvghQuJs9UBF9pHHWhWtAfq9G9NU700mUbnMSjMrARrEPEC/W
         b5Y4ofXkEjK+ibXHIGRdcITi70acD0YT9SvDIzApm1Io/TXZxL/ePHO32rJqXsdTNmfd
         DenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318363; x=1731923163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Moeko09cNn/tBMWxRyaAP4nMoxzoQVrPZMKwS5ag9u4=;
        b=koErLwfa8NjwY6jF5TFpZzfk4+KlUwhHHwKd/lrGtUoTXd4e7q1SnsBgR8wMMPQA33
         OzvC/PCZQmSqL3ppDUyt2ZDUrM4lHQwY4YuCK06Qkueu1EI2Th/ecUneMR4bYie2ZKdU
         ubA8dTVv3ifE9BFvZtA3k2lxczgaCGs7HfaZQ2Wgw/6zht3G1OzYLlDRtg5KvfL2f5Aa
         Z9eFdU9OYZ6XDac+AM7jcDcFdoHizrjDuakdwhd8SNuDfUKF6V2dVY0FR1dJF7vJERjx
         pOF92cGt7AWKmTuyBBEP9loLO/woYw22UhBixkgQbg07r/Q+idKGD1LMMj3pklxvmVZB
         xCTA==
X-Forwarded-Encrypted: i=1; AJvYcCVsOq6eHk1ShckDTzhai9k5U30yo7cmQrepEm7sS2Jz/mirrXDfljbc64qGIfr7oRYxsNIuGXhGJYzR@vger.kernel.org, AJvYcCWdu9weGL3JuoS0hmpQggnfcb7QbbRts8ILcNo1Qr3dvAJnlVbJwF8wgsK7zzK6MSwsFjUYSzmHAiWvTp56@vger.kernel.org
X-Gm-Message-State: AOJu0YzHQ3iBvM1NM0l9XpBqNcX0oovblr1G6sKfQX4NF8UBrml2lbof
	kAaYNnrMewXj61NKdcMnbYaKTLgdDcuMQiGCJ5Wyu3FBfjVLEh0F
X-Google-Smtp-Source: AGHT+IESsUyRzaYuCfvnsyqDABRyOahsKXzjXNQUOb+dN8bhzGQnX6lynJCsKMqXKxgd1GTq7ZrUHA==
X-Received: by 2002:a17:902:fc4b:b0:20c:f9ec:cd8a with SMTP id d9443c01a7336-21183d11392mr184701115ad.7.1731318363232;
        Mon, 11 Nov 2024 01:46:03 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc826fsm72248725ad.11.2024.11.11.01.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:46:02 -0800 (PST)
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
Subject: [PATCH v1 4/5] ARM: dts: aspeed: Harma: add e1s power monitor
Date: Mon, 11 Nov 2024 17:43:48 +0800
Message-Id: <20241111094349.2894060-5-peteryin.openbmc@gmail.com>
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

Add E1S power monitor device.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index ce1731bdc1af..9d7e7208562b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -354,11 +354,22 @@ imux22: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			power-monitor@45 {
+				compatible = "ti,ina230";
+				reg = <0x45>;
+			};
+
 		};
 		imux23: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			power-monitor@45 {
+				compatible = "ti,ina230";
+				reg = <0x45>;
+			};
 		};
 	};
 };
-- 
2.25.1


