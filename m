Return-Path: <linux-kernel+bounces-568438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B35B2A69573
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3641462616
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1512046BF;
	Wed, 19 Mar 2025 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn9xknp3"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B2A1E2850;
	Wed, 19 Mar 2025 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403008; cv=none; b=ZimrtGRznYIRB3VaO6WsGxPW8+rs+8nK1F9k0nA+tlttljRkVgP/zM1EDXU+Df0QKYbvbguyPJZJYGaLdiL0wmaLS77CNq8YBny4QJqTMiIlYtrknCKZ9MDUf0mb106t8lZS3uwab8olJDUmWcgF0HfQINUd4Q2/5L2+oqN1EqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403008; c=relaxed/simple;
	bh=EmGOWWjDA0fpNSOealsYbgx+a6lgY/GG4Rr46Ji+D/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L5xjFeD8qtbtFZJl66TH34JemrgqODJxoM0yCPtDwXToLiyBvR23OI8msImBZIrebtsyKoMpQcCQ3g4b4xf8ZKpCmDLVmek0zk0vlJSAshIBaTuE0Z0Misqjf1Gw4GTilTx7J6DM/t0SFfJjv2b8oPCoZ68x5dtAxS20VahSpOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cn9xknp3; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30185d00446so1543504a91.0;
        Wed, 19 Mar 2025 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742403007; x=1743007807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hlvFZ7mJmXGztCrB9tJtvEfBnNtJllCq8zyvSsEbwU=;
        b=cn9xknp3l9iEg3Znirq/69QE1uUfj/ULCIUykIbvoVPgitoPXtnitOyxp19OKpER4/
         fb7x0knkUI9IZzGl8HbBoePtyRWPQaZxTleNd1ZJFKCopTkMM9owt1b83gvkuPISXnZp
         brkWif4YXYKn3yc0HyU/52Bk57Vh7rGbAhWSTFTWWQC1OtpYLWzDodnz9bbaDKRGYTJQ
         ZQBG+kaUEjwCI0fplJZwi1YCUf9/uUtKJXqJJgJFg7yK4QxARdkqQM1zAkHIFE7pqbuk
         c/Zr3a3dydUc6ChGMVgm1bAgGAsPfqELERyQ1AMFg3uQEG7AWPF/kTonYwglOozcvXXR
         8xKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403007; x=1743007807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hlvFZ7mJmXGztCrB9tJtvEfBnNtJllCq8zyvSsEbwU=;
        b=wi4z+CkZc8C1fjhTC38CcOJgGD3Tjm/QNWBC+LvNx7xtA/HihQiZejei55vafgx8s+
         aUlin300JODdNcAGNFPJErnm52JbQmI9DdCH8xJOieEATCAItRiAOscB6E266EiHzBW+
         jzkWBVl2z28/bdz1zjOnHkOl8rC+ivdYSlYuoSkQNrrqG6XgmTFVfmhIpHYh612vGZIp
         pxnpKfWDD1LlFNGGLrmKLLxT4cDDRfss1GdIpj2ZSb3IBM9KqY4bedpX8bG3VqHHiwUZ
         pgs/8OIscpoLME9wLfFsD5kGsBvPFSgvne/GUrFJZZKJIWi3tKYgWQWXEQiOE7D4v5Ii
         t2hA==
X-Forwarded-Encrypted: i=1; AJvYcCXRfn6mCDN8BlPGblz53mP9w1/2360iI9QbH7LxgecbYihXjN2qYCnCrELubaYYgU6gKv7ISkqaaShdj/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsGpM5UNLYxARe8E2yTbfCZdHmrhbjFkqVq7lafDV3SfC9yhqy
	GbgxuIDNhi/i+FZoruFRNmABshG83y39QrXhCB+J2f0qDTYYedNX
X-Gm-Gg: ASbGncsMLz6RYEhGENYVXq18WVl1Gz+2FB+2QboWvL11mEdj7CLz2wmRq5exfq7ygBN
	wWLzcFQGlPnYDYO7m2xCJWyi/x0gXX0e19n5IHEh5NpIBKBcf56guL3B0zGO3Xo36Nj2lqR624P
	Hg2vjFg2NL6f3dzZ8P7Pqbyhv3wHOmvBHa213mPyLtn7SxvG2RPnqxjz/0ZhW1sDAWsXD+fJRA6
	122N2Gy+RWvOufjlmE2us6MdwoWHYbTF5pHdjzigYEiXi8AltxWCOErOlxwHgf16AkdAwg7+Ux2
	t+t3NOXHH0ICni7jHhvPE7kCYsVJ4LFbNiI5g1bdzWLVsB7RFdmX2LjmCqW/opYkuQPyqJRVOYJ
	o5q840hhC6mbnrsz0KkByJQ==
X-Google-Smtp-Source: AGHT+IGtqikS9EAzHW75N6WWgahv90tvLMFLTPMgePX/nxiz4HcBVay/Xc5zfuHq3w1gvckMkZ6jTw==
X-Received: by 2002:a17:90a:d2cb:b0:2fa:42f3:e3e4 with SMTP id 98e67ed59e1d1-301d426aa83mr319281a91.3.1742403006734;
        Wed, 19 Mar 2025 09:50:06 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bc2sm1863641a91.5.2025.03.19.09.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:50:06 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 00:47:27 +0800
Subject: [PATCH v4 6/8] ARM: dts: aspeed: catalina: Add second source HSC
 node support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v4-6-7c34b8139014@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742402988; l=979;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=EmGOWWjDA0fpNSOealsYbgx+a6lgY/GG4Rr46Ji+D/c=;
 b=LM3piKFik6LqjhP+loPzjTwCLNJ3u41AW30F1XD5GbKl2D+juoRBF/cT2O2koL5Efx0o0WRzx
 TbVnsGq7dT1B/g1284v3Q1rAdRyBJNRqQsKv6JiychDpyuECfJWwylY
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add device tree nodes for the XDP710 Hot-Swap Controller (HSC) to support
the Power Distribution Board (PDB) with a second-source configuration.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index e11be815a6af..fb4b236d36c0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -622,6 +622,14 @@ i2c1mux0ch4: i2c@4 {
 			#size-cells = <0>;
 			reg = <0x4>;
 
+			power-monitor@13 {
+				compatible = "infineon,xdp710";
+				reg = <0x13>;
+			};
+			power-monitor@1c {
+				compatible = "infineon,xdp710";
+				reg = <0x1c>;
+			};
 			power-monitor@42 {
 				compatible = "lltc,ltc4287";
 				reg = <0x42>;

-- 
2.31.1


