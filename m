Return-Path: <linux-kernel+bounces-404184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D309C4064
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F79B2821CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FC119F118;
	Mon, 11 Nov 2024 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="TaMtH6j/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="WWYWSnS4"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6043C19D078
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334285; cv=none; b=TC9/qCkxvu95aMA4ZrmDU9pr8LPXbncPua0l3wSs/jC5UtSMDMru0dae50EoE9BMznissw9kaGkMTtGM4uy7IlzFCjKMCumXIS80SRPqJmt4fasCwRtGr7K6xIgeT7N+OaLxNPhCH558zBR9Ob8mimulsYsiolTlFuYAAv/RaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334285; c=relaxed/simple;
	bh=tFDdPnJpJFb5KEqvjcByjDv09O6pfXBrWj4CYx3HQ2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuoRpSV6SdFSVL+NuydIUaqJ9t+lDFz4pBCX1EIUUV8S0vtWm+DwiN225gRb9MVYJMezwERMd2sfCxkY7aAN+wmKiMJrnh9fWhj9+0rdZkdslVSuFBHYYpdOLPmnv/XeFma+Bj3GllXcLjg+EF3DuRqgsS0lMmSgTwxUWmLU3D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=TaMtH6j/; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=WWYWSnS4 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1731334282; x=1762870282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mdJ0HsavbtI5RLxUlcwKb2h8lymAfGCEIXL8a653/I0=;
  b=TaMtH6j/3xErAakQMjHis9jHZWD3vykP0pkgLQFPGw0HSMzSa1auqw+C
   k3CoX9o9uTbpHTwRyMx/OA86CZWNWYLy/mJaD1nzAEK+FmddW4AkK3fCI
   4wrBeL8HOWm3CL/LPMW17CzSwOF73Z8HiJ02feva4WAabO3fmXdgpaXys
   Bg9Dn3qUhPBp5aRB4YKz9ue38vdJ1Icv0uMZCzizujqQZy4oW4YMI+tXI
   IUdd37DlvFRox/jj3770so3sAzfY+lOAxBBJbCUGbZ2afhXRNZpVObMNJ
   cslgXqpv4+jRfGymnm6QUF3xtWFQhE5GNUp5NVouKlKFk31bZ/mRLAUz2
   w==;
X-CSE-ConnectionGUID: RYJ3cKfzRd+DpMtigNLbBA==
X-CSE-MsgGUID: 8FxeysbSTHi8xpKRE+BPzQ==
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="scan'208";a="39967034"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 11 Nov 2024 15:11:20 +0100
X-CheckPoint: {67321088-8-1E10F2A5-CC0651E5}
X-MAIL-CPID: 8BC1050CDF161D905C987A30343FDE61_4
X-Control-Analysis: str=0001.0A682F16.67321088.005A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8F29166FA1;
	Mon, 11 Nov 2024 15:11:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1731334275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mdJ0HsavbtI5RLxUlcwKb2h8lymAfGCEIXL8a653/I0=;
	b=WWYWSnS44Hvwl1Clt3Tw7X3eq3C/VAh3JsOKrjR+jMh8g+ehSQUYBkwvTKt2j8++nHrtK9
	JmGNMLQ6i9mU6u7sYks2y5Cxg8BLvqrDo5OO0VwUFC6G7EKzozrZm3hF30SlOrrppwrPcx
	+ZFc8E36+KUc+yyMQu2ijGGQowCSoBzMvbb7WFMKWQSapQxGIXBqFinLzwbQXD3ql37iZM
	xZjFCTcanVLLHAqts/SdXXtSN7ZJHpOubmEheoDEoLw+7iNsyPkXUvmSAxyzgMAJiuOlD1
	QvB328TaLKHt+5K/caoiMk1NyTcDtkxS8+KRmrsmpFLoH6B8/3st/RCBmBPVOA==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v7 1/5] mfd: tqmx86: add board definitions for TQMx120UC, TQMx130UC and TQMxE41S
Date: Mon, 11 Nov 2024 15:10:28 +0100
Message-ID: <90ddebda96d29246992b58ae0231a511f6424211.1731325758.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731325758.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1731325758.git.matthias.schiffer@ew.tq-group.com>
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


