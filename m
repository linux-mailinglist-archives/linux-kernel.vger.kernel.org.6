Return-Path: <linux-kernel+bounces-549564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03530A553EF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9CB3189BA73
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE23F27C15F;
	Thu,  6 Mar 2025 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="kIMMxIC1";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="LzMTo7U+"
Received: from bayard.4d2.org (bayard.4d2.org [155.254.16.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE47426BDB8;
	Thu,  6 Mar 2025 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.254.16.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284010; cv=none; b=FBO0FIHRpDuKsX7WfiuaJWU/C+a+GZ8OdH6BY1AMWr6miuyadY2SaWR99K8xOlVYFABK2F5hRfxxNE/gHGZl+N+ez8+JvRL50RLFFQ8TDgt4QvB0fcoIDKikPMl66YBbk2mgUxN1Q3H72zlyY0CtHKfnw8rF0YnYQRClOSA2Zh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284010; c=relaxed/simple;
	bh=BB4k9sCGkbf5g+pYpRa3583GKVlEvttSm9LNXnS04YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQpEEjb0+BlGpkrYcGeo2mwmjHextMSg6oZWGemaLyTzhyvFUF2Bt7zPAXVFFicn3VF6RZs8LKd2WMda+Dj0h+kw6OnV8hjS6s6HMYhB2fyharxNfF1jjVWL22JYYTqE6W5KSL//kC0+HLXmJU4hR60+zb8EBUA9VRdGDjZuLP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=kIMMxIC1; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=LzMTo7U+; arc=none smtp.client-ip=155.254.16.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 9530AEC59F6;
	Thu, 06 Mar 2025 10:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1741284008; bh=BB4k9sCGkbf5g+pYpRa3583GKVlEvttSm9LNXnS04YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kIMMxIC1TbcgCGUkVm86XhHmJ+cPzlaWghHeUSSBC/ZysmOVgw838PblEQ5n4LzUc
	 PMoAm9msDybc3+WcGMGQidRwlldnVVR+nyB+1BZkbmjem+PQETYGidqT6bd3LPGgU7
	 hN7RsHZcPOePep4rhCIlynksokLzyn5jXX3yXgvaLsvst8mMOlyiB0U4yaM/zuetDf
	 6Q8oPdFyfbwEnotun/SkphYZ7HN7Ozsz7NXEVDPTew1krBI+KZI3np6cXV2TDkvHML
	 tjqc0CHiKQqLAVLT9z23Sqz90gxRc1ZS0FG4g6fzxMDsxJJt9Qjw69CojAhr7ADjxU
	 krcctv+Y7NBcg==
X-Virus-Scanned: amavisd-new at 4d2.org
Authentication-Results: bayard.4d2.org (amavisd-new); dkim=pass (2048-bit key)
 header.d=4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3YlUjIGyC8xF; Thu,  6 Mar 2025 10:00:07 -0800 (PST)
Received: from localhost.localdomain (unknown [183.217.80.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 76327EC59F2;
	Thu, 06 Mar 2025 10:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1741284007; bh=BB4k9sCGkbf5g+pYpRa3583GKVlEvttSm9LNXnS04YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LzMTo7U+pM1z1Yty+35WwORlLc/o/yp0orzGEexss4SgJRQX/2n4gO/rJjIcWSUi/
	 3ncA8ru/ERZXpFm3O+pPR4/p6StRos7wNOvFr9R8Ve/RAkwPIbHf55P4F0MJhGKGu2
	 tJBwG/urk21ybQf18D8xRVmiUQURSbxO/xuv0Fct+/CvoR6qIb++6aY2l6/Pch58u/
	 lWk6e4mg0BjPhd66yZPQKe/17v1sakRIZJ4cUsNTyfUxxGStZV3Rva1W0NGRtPJfh1
	 v/BRWhT2fHVgUdCA/9PEAE6eOZ+9KadmiZI39YFtIrZZrt4AszfItriESeBt9mfcdP
	 lFliMpi7iJjnw==
From: Haylen Chu <heylenay@4d2.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>,
	Yixun Lan <dlan@gentoo.org>
Cc: linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	Haylen Chu <heylenay@4d2.org>
Subject: [PATCH v5 4/5] clk: spacemit: k1: Add TWSI8 bus and function clocks
Date: Thu,  6 Mar 2025 17:57:50 +0000
Message-ID: <20250306175750.22480-6-heylenay@4d2.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306175750.22480-2-heylenay@4d2.org>
References: <20250306175750.22480-2-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The control register for TWSI8 clocks, APBC_TWSI8_CLK_RST, contains mux
selection bits, reset assertion bit and enable bits for function and bus
clocks. It has a quirk that reading always results in zero.

As a workaround, let's hardcode the mux value as zero to select
pll1_d78_31p5 as parent and treat twsi8_clk as a gate, whose enable mask
is combined from the real bus and function clocks to avoid the
write-only register being shared between two clk_hws, in which case
updates of one clk_hw zero the other's bits.

With a 1:1 factor serving as placeholder for the bus clock, the I2C-8
controller could be brought up, which is essential for boards attaching
power-management chips to it.

Signed-off-by: Haylen Chu <heylenay@4d2.org>
---
 drivers/clk/spacemit/ccu-k1.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
index 5974a0a1b5f6..44db48ae7131 100644
--- a/drivers/clk/spacemit/ccu-k1.c
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -558,6 +558,10 @@ static CCU_MUX_GATE_DEFINE(twsi7_clk, twsi_parents,
 			   APBC_TWSI7_CLK_RST,
 			   4, 3, BIT(1),
 			   0);
+static CCU_GATE_DEFINE(twsi8_clk, CCU_PARENT_HW(pll1_d78_31p5),
+		       APBC_TWSI8_CLK_RST,
+		       BIT(1) | BIT(0),
+		       0);
 
 static const struct clk_parent_data timer_parents[] = {
 	CCU_PARENT_HW(pll1_d192_12p8),
@@ -795,6 +799,8 @@ static CCU_GATE_DEFINE(twsi7_bus_clk, CCU_PARENT_HW(apb_clk),
 		       APBC_TWSI7_CLK_RST,
 		       BIT(0),
 		       0);
+static CCU_FACTOR_DEFINE(twsi8_bus_clk, CCU_PARENT_HW(apb_clk),
+			 1, 1);
 
 static CCU_GATE_DEFINE(timers1_bus_clk, CCU_PARENT_HW(apb_clk),
 		       APBC_TIMERS1_CLK_RST,
-- 
2.48.1


