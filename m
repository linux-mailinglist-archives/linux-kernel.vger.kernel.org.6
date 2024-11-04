Return-Path: <linux-kernel+bounces-394710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9119BB316
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83349B2896D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120131B6CF1;
	Mon,  4 Nov 2024 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="VaJDNFhq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="tnrZODSP"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA6C1B4F1A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718851; cv=none; b=opSyB9QTBtkjVDce7MFuWJxYkujMT8uqMI9+6+J+v+2zpM3cmj1slBHKKygNmxVgnuFa1o6RJ1rVByJ1mmEz3V9BshzQESd3oLqyP7dlOauU06gQVwaQ9Z+38FRzX7oiGsqUzRnCeXY8nAQ1yRVZUQ8lLc7EbO64fj2IJXi5bDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718851; c=relaxed/simple;
	bh=QJeUvBluegdItMpgUwyoqMVpfqBzO+kuVhCQNc09jRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1SMHLskrz8SH+uSgRNFQoKa1VpBifhFg8dNlKAcWTIGYer76SbTln1eJrWwuLtRd9TRq087+iny61elBQbnh21ZZFdOPXx5OhSOHZeXn1AnvLO7nnF3q6ww+7eaxOuKZ18wH4nYTRmu0/x3Y98HvclRSYmPYMk7EPxTWliAHnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=VaJDNFhq; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=tnrZODSP reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730718848; x=1762254848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D3YWv+Tb4Tb0J6UXqkPRQMhka0vbADfJliqcOUGLvqQ=;
  b=VaJDNFhqc7U6YHfDISZKDKivHgkp2oUXDAZ4eyokdKgBeINcn+lThNx9
   ZzgqdSUlQb6Uga+X+Szmuu1Sj03zUsKR3ZRb/P/eyrN4nW3Bwo7wNGV7S
   N5NVv7Nlf73d1+wIQXb4a8pLJbRTH+SB4PwAjxSTQiz1nM6l8BBZQDOel
   Rl6av0OpkylxpuniRcJWgru9n5cbuXWVMCIdfb/giF0Qrtm/1NQAmTBBN
   3EmtOpB3eReM5numAd1mu7EIOgJ4ojhRpGJXJ+bn9qHwpUi/u59Oj8c86
   1C4/Rs9ktJevmdrNA2AoFIALZyLjWmJdpCn1JjrAGFCJy7Ryb+Ad5d9i7
   A==;
X-CSE-ConnectionGUID: 0++yl3ECTqiEB+j3E0jjbA==
X-CSE-MsgGUID: K/xsdAOmSqC8klYqVy07aQ==
X-IronPort-AV: E=Sophos;i="6.11,256,1725314400"; 
   d="scan'208";a="39829939"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Nov 2024 12:14:05 +0100
X-CheckPoint: {6728AC7D-3B-D31EDE1A-D52D6119}
X-MAIL-CPID: D9607CFAC80A223701AAEB72C0DB3F49_5
X-Control-Analysis: str=0001.0A682F20.6728AC7E.0012,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7930E167F00;
	Mon,  4 Nov 2024 12:14:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730718841;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=D3YWv+Tb4Tb0J6UXqkPRQMhka0vbADfJliqcOUGLvqQ=;
	b=tnrZODSP0cpSb+rs7QsS8ijbk5b1Dm+a+w5Q9ZGMfpm+J9laGwJkFT8c6Xqz1IqGffqbKD
	Ygq08OArViUvsUGk4ng6lKwn0yh6m8MMiSAHLoJ1DgDLfrWz7+26o0XCqRha4yuj1RnqEK
	P1SQIMr7p6k0ZH8/3OTDDOXaQtXgMM66NXUADoqRo+3TeW1xaEGEngpgYKvKdI7QOk7QxW
	so6u+Kub/NaE/0nz6SuuJEV1cDkxKVrVeY55UdMYd0DUwOWBL2Gv/jYu4M9b1zx185Oe96
	O7F3oViALC9mh/e/7v4unPnb/+KqLDIwiQ4Mhv7q4Lp8cvOKQA8Tptaz93f1TA==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v6 1/5] mfd: tqmx86: add board definitions for TQMx120UC, TQMx130UC and TQMxE41S
Date: Mon,  4 Nov 2024 12:13:29 +0100
Message-ID: <90ddebda96d29246992b58ae0231a511f6424211.1730717841.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730717841.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1730717841.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This adds support for 3 new TQMx86 COMs:

- TQMx120UC/TQMx130UC: COM Express Compact Type 6 modules with 12th and
  13th Generation Intel Core CPUs ([1, 2])
- TQMxE41S: SMARC 2.1 module with Intel Atom x7000E and compatible CPUs [3]

[1] https://www.tq-group.com/en/products/tq-embedded/x86-architecture/tqmx120uc/
[2] https://www.tq-group.com/en/products/tq-embedded/x86-architecture/tqmx130uc/
[3] https://www.tq-group.com/en/products/tq-embedded/x86-architecture/tqmxe41s/

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: no changes
v3: no changes
v4: no changes
v5: no changes
v6: no changes

 drivers/mfd/tqmx86.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index fac02875fe7d9..e15b9be98c2db 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -35,11 +35,14 @@
 #define TQMX86_REG_BOARD_ID_E39C2	7
 #define TQMX86_REG_BOARD_ID_70EB	8
 #define TQMX86_REG_BOARD_ID_80UC	9
+#define TQMX86_REG_BOARD_ID_120UC	10
 #define TQMX86_REG_BOARD_ID_110EB	11
 #define TQMX86_REG_BOARD_ID_E40M	12
 #define TQMX86_REG_BOARD_ID_E40S	13
 #define TQMX86_REG_BOARD_ID_E40C1	14
 #define TQMX86_REG_BOARD_ID_E40C2	15
+#define TQMX86_REG_BOARD_ID_130UC	16
+#define TQMX86_REG_BOARD_ID_E41S	19
 #define TQMX86_REG_BOARD_REV	0x01
 #define TQMX86_REG_IO_EXT_INT	0x06
 #define TQMX86_REG_IO_EXT_INT_NONE		0
@@ -132,6 +135,8 @@ static const char *tqmx86_board_id_to_name(u8 board_id, u8 sauc)
 		return "TQMx70EB";
 	case TQMX86_REG_BOARD_ID_80UC:
 		return "TQMx80UC";
+	case TQMX86_REG_BOARD_ID_120UC:
+		return "TQMx120UC";
 	case TQMX86_REG_BOARD_ID_110EB:
 		return "TQMx110EB";
 	case TQMX86_REG_BOARD_ID_E40M:
@@ -142,6 +147,10 @@ static const char *tqmx86_board_id_to_name(u8 board_id, u8 sauc)
 		return "TQMxE40C1";
 	case TQMX86_REG_BOARD_ID_E40C2:
 		return "TQMxE40C2";
+	case TQMX86_REG_BOARD_ID_130UC:
+		return "TQMx130UC";
+	case TQMX86_REG_BOARD_ID_E41S:
+		return "TQMxE41S";
 	default:
 		return "Unknown";
 	}
@@ -154,11 +163,14 @@ static int tqmx86_board_id_to_clk_rate(struct device *dev, u8 board_id)
 	case TQMX86_REG_BOARD_ID_60EB:
 	case TQMX86_REG_BOARD_ID_70EB:
 	case TQMX86_REG_BOARD_ID_80UC:
+	case TQMX86_REG_BOARD_ID_120UC:
 	case TQMX86_REG_BOARD_ID_110EB:
 	case TQMX86_REG_BOARD_ID_E40M:
 	case TQMX86_REG_BOARD_ID_E40S:
 	case TQMX86_REG_BOARD_ID_E40C1:
 	case TQMX86_REG_BOARD_ID_E40C2:
+	case TQMX86_REG_BOARD_ID_130UC:
+	case TQMX86_REG_BOARD_ID_E41S:
 		return 24000;
 	case TQMX86_REG_BOARD_ID_E39MS:
 	case TQMX86_REG_BOARD_ID_E39C1:
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


