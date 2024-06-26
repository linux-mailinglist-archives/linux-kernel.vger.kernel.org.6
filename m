Return-Path: <linux-kernel+bounces-230775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8A99181C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8914C1F24CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA22187332;
	Wed, 26 Jun 2024 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9C9RYdB"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A380186E5B;
	Wed, 26 Jun 2024 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407154; cv=none; b=S1GXKUYMpHhB0l2WyJ6Boa2Fnrlw+zwYzURZ5i6xQ1+scTxodX/FFskCX8dKrKjGD3AtuZfR4hQeeJQjde+HDlBmjWICuafXkhfl9rhv6FtoKQ0dui8cHxpwEIQ8g06zOjyeSY320K1RLRJzRMMTtzsyZcTpqa07fcY3Vtgrz64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407154; c=relaxed/simple;
	bh=DTRJF/NDQiZw9xnLVAeiJGHMWWVMFRdCNPj9XxigePI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fMk4Cv59m4g3lMrhwAlPRx7beOUKuL43CzpzImvudhDslZsackPLI0a7sd+hRP4/miM0krNGWUus4HPXVCT6r295kamZ9ZNFePwgG0rB+2c9XysPKf08XgPV26HOukfF/0/6Xim9Bot6qdSrmlF+Ov2r9DqpL+qRiQkRheDDGI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9C9RYdB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f70c457823so46653365ad.3;
        Wed, 26 Jun 2024 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407152; x=1720011952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eq7Km+kNindSOJ7hf0QT9SRfkWv9U1E4WEwZCW/4V7k=;
        b=c9C9RYdBHIIk+TP1Hp35ghNlnnHCXhC8XB/DMstl7x3c3akAaazuzxlhMKPEVW3iQ4
         HAyh7ju3VmM7DE0HKrPGB6E3Yq7fpxT1cNtgAWGjX/S1NziJNrBNWw7E1eRRwImURhfT
         7Vd5WoHgfC8peEz4U1HpRpIdzUTB7vXSGzDTvcFnGC8XY9kFoJRe246AGw1WKGLIy1xQ
         32AE5brcYp0/3TzApNNL9QQS9uZRUTZKqH8YqulCnpUk3v5wkT2VCr7AnPR3+kq2+v8b
         n6+9liz3kGBJKU0rdJ2hgTUH71FHfqnFIrNlEs+czY/8M9dirTmDNMhr3mMArs9hAlzc
         hgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407152; x=1720011952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eq7Km+kNindSOJ7hf0QT9SRfkWv9U1E4WEwZCW/4V7k=;
        b=V/jNeogRs7No2Jh/DjuAb5dalK7bDvDcSofouZLryRwn2gIuXbiCTRO5RZJPbjctWx
         TfIkXUtLOH2OoySi8HxJZakmFpoQsQUKPiLcqUgygljFnWzPbyt0PkVXg+xRSQijvKOn
         RxPPB8BzbsydaAHmM7BtWPiFxlC4sWORqC/8gM30afsQ0dZ5JKzcMO/gdWDTWKQ69HUE
         G9j4RtL6Wf/uvAqZk6eK3FcyDNM4Ry8d+M2q3SyrC0q/JKZKk5Rsfpa+AsdeaG18LlxX
         9mbWniI0Y0UiEpC4TDrtimRs58WJo6ma9yOpqHbz963ebkQvcJPKKLNTBT7VYGagFxfv
         vGnA==
X-Forwarded-Encrypted: i=1; AJvYcCUyXbJlgT/2GHyAq355vrbE4MnXvCl1P/3i4bfo2U1uovooKny9SJI5MYHidmsvtO5cp47id1SxqSVHKcTMXtig6Gp57qmiyFS2wkytbLkblnCkM8hmbXr4gpku9KK0tFcW+n8RvarIpg==
X-Gm-Message-State: AOJu0YzzOFXL1QO6l0EPOdtAypp2rf92FHakeQN/XbWrAFL0Pbc5kyek
	eq/NRde9CELbuZLMmdIIMCrAK9ukOZaL436tIydNim5UDBrcPRFH
X-Google-Smtp-Source: AGHT+IHxteW6OXgJmxn9+nKwB1bp/8Nb3CWl02MbFlYO8kguOCc6ybzpAkgE/yaguzdD7oHK/flDRg==
X-Received: by 2002:a17:902:e5c1:b0:1f9:c6df:a84e with SMTP id d9443c01a7336-1fa23f3638fmr125852215ad.64.1719407152195;
        Wed, 26 Jun 2024 06:05:52 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf885sm99112395ad.224.2024.06.26.06.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:05:51 -0700 (PDT)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Jerry.Lin@quantatw.com,
	yangchen.openbmc@gmail.com
Subject: [PATCH v1 06/17] ARM: dts: aspeed: minerva: remove unused bus and device
Date: Wed, 26 Jun 2024 21:03:21 +0800
Message-Id: <20240626130332.929534-7-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
References: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Chen <yang.chen@quantatw.com>

Remove unused bus and device.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 13819bc166cc..bc323bfbe514 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -315,10 +315,6 @@ rtc@51 {
 	};
 };
 
-&i2c10 {
-	status = "okay";
-};
-
 &i2c12 {
 	status = "okay";
 };
-- 
2.34.1


