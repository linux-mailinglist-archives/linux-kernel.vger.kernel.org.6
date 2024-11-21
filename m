Return-Path: <linux-kernel+bounces-416502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179D29D45F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F276B22547
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC1815539F;
	Thu, 21 Nov 2024 02:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wkms7zqe"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A7716DC36;
	Thu, 21 Nov 2024 02:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157623; cv=none; b=bQyQunKgqMlyrUXvdplMV0WQgsAeT/pWZ+GvGD7cWaCAf5o+GcQsgtw9JM+uf5tJQe2qZXgA8XHuFOcQvBjWEPlKBZG2Ab2UtQ3V0SyuU+Oqn33EIRRseopu/joze7MoUjVnfxf2K20YQGIj3XN36kiMR1WT5U5PmaJ2NAY4Nm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157623; c=relaxed/simple;
	bh=/GpinvJD+IE1gFPCcRsT5yiq3ogqQ+inUNNKgo7ReqM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H91wb/pBxLgYgtj9Kx3IHR8dtM+Ct6BRfIW6UTkFyiTzDu+nnhniQon9WfBvEg7WKujJPiRprxYdFP3Z6mMzB+tCZfYyVILjc7nl8d6nLiTWecU5AJVdP4K6mDnpdVHvGMjjMdMsaS/PcskDHshG2PZ17JXv6ZWOuBAwE4Po1qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wkms7zqe; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ee9d50efaaso3811557b3.1;
        Wed, 20 Nov 2024 18:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732157621; x=1732762421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Moeko09cNn/tBMWxRyaAP4nMoxzoQVrPZMKwS5ag9u4=;
        b=Wkms7zqeGgXzThiJFEBrM4V3fsYynSvATsIStsFbiMjC0nJuE7bLVmkF+SiYQOuvCc
         +4xS4n3C53Hh3LYAF/SWR8cjaUtN0NUB6omd+Jxq8Y/IRehnc6iv0/GgDzM/XORQZ6Dp
         tGg+FM4Lr6Lk60NBU9stYCGNQpQaIUEAgFS/arLkQfqmYHwEkHq68WAAV8ZvdHdM011w
         Fl0L78i47ghoUwkYXLQWmB4NEXiPJWveWGwaC3ajwYpFjHWHABmhEInnDruupm/Sdkik
         i//hIcMTZ8pJMUOQrEKUrPewlpRN2i1vyjuI15UxiINZaXIgQlaIAH/evOw8Lsc6iO/r
         Pfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732157621; x=1732762421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Moeko09cNn/tBMWxRyaAP4nMoxzoQVrPZMKwS5ag9u4=;
        b=plU9Uwycu0h05xzFfaJANWebVYUt7xBvXU4obZGS2PksHk2yktHu+OHSRBV6iR9P1z
         DAXpdQFfPnlSBY2ZTl3qA1MiRaHnDVou0XQryUpmbmMdAX6/JHOw/6CLe5yTGdSugM3D
         PAAdDdBpmYgew45E8ALYpC2SxhcLZfmiVlz3EJkVnguSmW8pEARp/e7KpgxhfbvfYiYG
         I141ILBzd2wjiwnTUM1gUhRW8n9hGsVJMd2w63vkSzbdGue2mopMFpCBHSHAMAiNN2IF
         CbgsHsiby9qpWKl2zaGfg+YBd+kflpNYv1D7mCR3Wl1h09FkN7VS0sljk7VQfZ32ACWH
         j+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl0pCIW8oUzuc5byRk2TEnky6DTHgL/V3Yd6COJjVViK+/5XwWgMmjrAcgw7W/3Gd/xvC3Yktp4ez1@vger.kernel.org, AJvYcCWYhNXBFJyZkKCBRnjXBZ36Dx02WOuXoUd7XrttoSY2oMRPH7VVDOjDj1rN82S7GJWKVhytTgEow8WO0RKV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Hcwb9EnA+iyvI89wDuarfKSrZFWeiMNQ+bnv44S5dRemgIGC
	x7t6xLSGNIWktVZTGElIDDdi7U04Y+XgVoqAKcK3ODhkR1317ZTo
X-Google-Smtp-Source: AGHT+IHfi9U3ChAkSgcxwjTETaNCq22J6zc0QHGyI9uwWq7ryknGbpWpSp8Z2Ihu5uyhiDydYDfSfg==
X-Received: by 2002:a05:690c:4b11:b0:6ee:b43b:62fd with SMTP id 00721157ae682-6eebd2d1a9amr60919277b3.41.1732157620851;
        Wed, 20 Nov 2024 18:53:40 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e309-7a4e-e779-1177-8427-3602.emome-ip6.hinet.net. [2001:b400:e309:7a4e:e779:1177:8427:3602])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64f5514sm285513a12.34.2024.11.20.18.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 18:53:40 -0800 (PST)
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
Subject: [PATCH v2 4/6] ARM: dts: aspeed: Harma: add e1s power monitor
Date: Thu, 21 Nov 2024 10:53:21 +0800
Message-Id: <20241121025323.1403409-5-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
References: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
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


