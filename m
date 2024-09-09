Return-Path: <linux-kernel+bounces-320843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B7997113D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3221F25543
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F001B2EF3;
	Mon,  9 Sep 2024 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUELvTy6"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3761B2EE6;
	Mon,  9 Sep 2024 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869227; cv=none; b=awz0jrpQNq1mEUrnr37h4CprlrPJz+dQb/i/ZkA4LpST8ieofoLiFcaKGpjIRTQvlsRAEWphmPKADEkTSl4BBX+juJE/q/fFaQCEvAm2RB92hkSEaEexDPYLupkGZzE0ZT/GFweMLGCha5vHGH0xXbwwojtSROot6/l1CnDGCdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869227; c=relaxed/simple;
	bh=zKeP+r4fvJneoNGNPQMbNW1OqefKUqpy3W7f9cHPgaw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dX0I+xG8EmhzLTiXCaEE94eOUGy9t4rCb5/yrairgwvyvz56wKetue9JGnn3sHFC9d98PXJr6QAbZua9GtRnMHHfkfXj4a+Ov+mx0PuYEVZOtPjtgw7MWohijD5fd3UGtFvHCEYQ2nzqwST6iVGZCMb8FUqe4+qURY934tylbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUELvTy6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2da4e84c198so2735261a91.0;
        Mon, 09 Sep 2024 01:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725869226; x=1726474026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24ONLHDIg4IPXcssauearHwBYBXH9GZM3HUtiuvktw0=;
        b=dUELvTy6F4sjTUtDRUVCCzd7ixVrNJefXujei+5fMtqXpZ+JLwAHLgeG1EaOqxNXR4
         FgBTggOZPNEZvwgZSPto9oyxtAIMcw498duoX2NW3YdiMHA4af9H5HmtnX0aN9WR2oK/
         aZ2bO9jtNkZu/hOAVT3ldrSEwe0W0KSJbaXrSAYfPWfFgQhBo3yotkV17gjcVSWl3mXE
         3HES0QD8UaL/aUssgQdRkYbX+zIqNaZNGPeYxRQ5w+aVjlwQaEVofrjur3oQEUeSAPcZ
         QgWokTuGUzrd0l2IKB+x4UywnEDqVdVZoBmun1BB1rZ1PVM2dBPCff6ZE1M17/qTxPJq
         DrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725869226; x=1726474026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24ONLHDIg4IPXcssauearHwBYBXH9GZM3HUtiuvktw0=;
        b=Rw3nGyXlvMDHbPMLZsH2VH7agBEqkmc8MVzSkIZwNbRoOzxL8ncYwgoC+CJmiyD2ve
         zVDhwqNCVSovlW8w4caEbXmCSIAPFNDl6No8FDMq2WzJ+6fgrsTiaNQe1Ptb0fSnTV0l
         B2wuV/PgnStntzrZrGHkmq0xwAeP4B84hLtU+EQkQVMygQEPwdm52xT38mBvZnlTOoqn
         nbTA7mgHYTHLssLyFLpDzDDr1ZoBOzVQbmI9mcSLomps0AJ09uduT475FrWRSkBEPQj9
         dDE+hiXEkHc7gRYqQoL9LwyYyGGm2yjMmxLZPyNL4QdaVNyFF3XMglfFCjTmYjYiWVTT
         esYg==
X-Forwarded-Encrypted: i=1; AJvYcCURIIekJHqx5092gbxeNoeyNH/lG5yMZTWZWj7X8Lme396CW58gPt/zNgDkGxlvyAMFAKRsdJZN5SpQ@vger.kernel.org, AJvYcCWYjBfv1nWrBP3kcyhb188D2x4bhhjy/7FgTQbDNNNTlSDPv4Uhv8/nj0VBWKDDWrZ0Y+OjgBD+eCu8asV0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7HIrDhwIsATwRp+XtRN5GyC0yzk38mKz/hvkrY7h5oKTHVosg
	XgRK1hbvhysSGgKNIQXEo8zGmgMMy0VS7yADxUh6Y8ZmLFgYbmiU
X-Google-Smtp-Source: AGHT+IEdKA0Mj8kqr2gQb9Emszupt1dYbedGxfzDQBaFa7+PrIovDCecyCTxdD7JFKncezaQB2ahRg==
X-Received: by 2002:a17:90b:3b87:b0:2d8:9dd2:b8a1 with SMTP id 98e67ed59e1d1-2daffa3a9dfmr7828719a91.9.1725869225521;
        Mon, 09 Sep 2024 01:07:05 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db043c4916sm3917541a91.31.2024.09.09.01.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 01:07:05 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] ARM: dts: aspeed: Harma: add rtc device
Date: Mon,  9 Sep 2024 16:04:58 +0800
Message-Id: <20240909080459.3457853-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240909080459.3457853-1-peteryin.openbmc@gmail.com>
References: <20240909080459.3457853-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "nxp,pcf8563" device and the slave address is 0x51.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index cf3f807a38fe..92068c65eae4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -135,10 +135,6 @@ &mac3 {
 	use-ncsi;
 };
 
-&rtc {
-	status = "okay";
-};
-
 &fmc {
 	status = "okay";
 
@@ -506,6 +502,11 @@ imux31: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
+
+			rtc@51 {
+				compatible = "nxp,pcf8563";
+				reg = <0x51>;
+			};
 		};
 	};
 };
-- 
2.25.1


