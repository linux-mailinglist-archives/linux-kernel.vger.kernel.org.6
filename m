Return-Path: <linux-kernel+bounces-213539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473419076A0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D08288683
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F44514A609;
	Thu, 13 Jun 2024 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiheRMhf"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2F614A4EF;
	Thu, 13 Jun 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292405; cv=none; b=blq0NUsLOrCoaeBAaYCwhy8drDdCRwfS1uvEznKudJ70XPA7EWpjg1JlMeI3adL3V4H+JsGp+CWnJ92iDsM4LLDIWhB/yLx9eiL6mrMsEYmJekB2/Sab63JC22mjl0hCtaMrR5JcoyEgM8/0YaGhvs38Q6y9oUuyULuS4OU00qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292405; c=relaxed/simple;
	bh=WPTMl2tdkxclvKDnSXx2avKp0y2CXojK7eOMTWr+giY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HVkObpdotQ328IV7zU9cbYq4Ub7viiELIpmOMn6Pt80/k1SNIrTXaQvOcs0vZf7w5popcu5Bq9HuQct7aCET2t6vXs+m4zcTFss6s26ebWgidct6/W09HkssKkD+iVARVgscViK8E7LQ5fiXPMW+ZjbLqbNoIgr4QD5xhXciOII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiheRMhf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70436ac8882so906418b3a.2;
        Thu, 13 Jun 2024 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718292404; x=1718897204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HyReb+tsuJSpMD3xfx85u7ltZSRlX7HpcM+n+BHg+0=;
        b=PiheRMhfLVAESlR/NULsnokPXcpZShF8rzcX5yhd3ZGDlEUTV1HacvCHNt3NWosYHI
         XbMK5l1jXW2MN9xLVjm3TIH01aWAxnAniebpHH5WITj6rxRjT6edBmBMDz4MuBS+5bO5
         h6LNeYWZqIwkWtqq9m5+CVCFux0MgdIvy6g0yfVxfAF13IlGHNVZXkfdyWazTcF8LNuI
         WmjBZho0fTg0/53mBl1lvnlbWjxuqOURUU8sERIWQMek1XCR2k6ELzq3PEFDy11G9T9q
         W1HqC84Ndjh5Ovl6Q+a4z6ZY4iCwL0cyD3wkXlqxDqRsfFQ2WpMJcxOzVUfpS8mkzi4D
         o8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718292404; x=1718897204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HyReb+tsuJSpMD3xfx85u7ltZSRlX7HpcM+n+BHg+0=;
        b=NXOIGKtSfsAZnzdx30PUAyLAGi01Lv07mih7fYkVL3zS6uLAuyhmXq+TUoTQ1Tm6GY
         GwNZwxkSKWYgIBVH0zI8nrxBKz78+fkpYewL8iwyyUxEqSIKb1oBJ6r4KXDpz87d4PPj
         QWH+Pyo0N7YRS4viE+q17xT1Djn9VtLLBQhHCQrh/5IYxt7JAYGYLeugHMzzEZQ6vvG/
         bWw+RJ2JByg9NG9EZZISUs+aixsCTbbwb/Ci1a30ExUxcNhrqRtA99Fe5viyWa9DtRcL
         LGqZT8z0ooaTXd2Q34g4CJdVfQlW0yRmktRJyVFpyOm3O43BtUj6l767rMOeFH0fxgOH
         dZHw==
X-Forwarded-Encrypted: i=1; AJvYcCXOt05DS17BwFi5sBvi9lvSaubLfULFQON0Bf0/zoczLisciIPLg/DPs1Hyiq0rMVDPcSkmVhFIyIomXGPjZH7XaBb/drbFZV/zqv3lFQWOrathSThoZE+d1Ax3HtsRJM0JlBUJNgB74g==
X-Gm-Message-State: AOJu0YxG/9NerVcsZqZrWgDzyBybVNhRiBQJkaf1SnB8VfCDoyGqeGJY
	UgEpzbYCzSPJ0/9QmoaZLz2pIj/QfmhtJXB5+Y5ybPLdwVNSHbOz
X-Google-Smtp-Source: AGHT+IGZ7dDSpB0gDemGbrl1Ls8xaQvWnphT8vuiHuA6tgCXfC9dRPueqxT/h9PdKJgQ/EMmxevOFg==
X-Received: by 2002:a05:6a20:3946:b0:1b3:d59f:2d87 with SMTP id adf61e73a8af0-1bae82f6f36mr169561637.55.1718292403843;
        Thu, 13 Jun 2024 08:26:43 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee41663d2sm1198183a12.92.2024.06.13.08.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:26:42 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/7] ARM: dts: aspeed: Harma: add power monitor xdp710
Date: Thu, 13 Jun 2024 23:24:23 +0800
Message-Id: <20240613152425.1582059-6-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613152425.1582059-1-peteryin.openbmc@gmail.com>
References: <20240613152425.1582059-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add HSC xdp710 device in i2c4.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 05020e23a901..a9caa66a59da 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -329,6 +329,11 @@ power-monitor@44 {
 		reg = <0x44>;
 		shunt-resistor-micro-ohms = <250>;
 	};
+
+	power-monitor@40 {
+		compatible = "infineon,xdp710";
+		reg = <0x40>;
+	};
 };
 
 &i2c5 {
-- 
2.25.1


