Return-Path: <linux-kernel+bounces-434970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395509E6DA4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ADF9164CDB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D639F200118;
	Fri,  6 Dec 2024 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fU6MsdnZ"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6244E1FC107
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486232; cv=none; b=ife5SAJLx89YpOio9wzcDchQKxQSmgL5A90QmpBmbAkdz9lGMtR2W9cgq5SMJETW87x3HKyqyAu/fhKNNbd5X7HDg47q5Yk50ciO6hioKYy4y7x1ug5JZEK1a8UzJqXM0B94CooNBhARxy2YaY+67qZix7gF0W1NWTxovtsm3a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486232; c=relaxed/simple;
	bh=Accix36M+AxTmcfmBGlQ59iJFKXYFsUKU86Dgc5lV1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mATEKO36RCF5IkIpOpQprOySWkHgWImUnLPE9piIuYd89zhKw4x7SA7Y4ackzpBdj+oKBCyPiFPgc5/069AjD++C16+Vl9eAfgqTzyAb3OSXJ4CBcuX58Ul6Sz8vB3Bb1NpjOr/GQEv7r3uDUWW0E1vSLXbqGlKWl6vipkIXzBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fU6MsdnZ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733486225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZZpO9SIbEhiQV9ViJKVsnJwYEYoj5NMepZbe4iuQWaQ=;
	b=fU6MsdnZvR4aMHp9fxO9v9vE6eBn46NYZkQ1G+A9BDovLLykjjRRqNEgs20IKiSO5ylf5R
	5PMgSsqLv6q3u8sKno0abgTqs358QeYcje1b3CMMvS31hsUqnIDFBKa6ekupqjciYjX5uG
	jBd+P8N71Ev3xDGNWBgmZO6CW4P3v7s=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] m68k/atari: Use str_on_off() helper in atari_nvram_proc_read()
Date: Fri,  6 Dec 2024 12:56:32 +0100
Message-ID: <20241206115634.47332-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_on_off() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/m68k/atari/nvram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/atari/nvram.c b/arch/m68k/atari/nvram.c
index 7000d2443aa3..da490392e994 100644
--- a/arch/m68k/atari/nvram.c
+++ b/arch/m68k/atari/nvram.c
@@ -198,7 +198,7 @@ static void atari_nvram_proc_read(unsigned char *nvram, struct seq_file *seq,
 		seq_printf(seq, "0x%02x (undefined)\n", nvram[1]);
 
 	seq_printf(seq, "SCSI arbitration : %s\n",
-		   (nvram[16] & 0x80) ? "on" : "off");
+		   str_on_off(nvram[16] & 0x80));
 	seq_puts(seq, "SCSI host ID     : ");
 	if (nvram[16] & 0x80)
 		seq_printf(seq, "%d\n", nvram[16] & 7);
@@ -236,7 +236,7 @@ static void atari_nvram_proc_read(unsigned char *nvram, struct seq_file *seq,
 		   vmode & 16 ? "VGA" : "TV", vmode & 32 ? "PAL" : "NTSC");
 	seq_printf(seq,
 		   "                   %soverscan, compat. mode %s%s\n",
-		   vmode & 64 ? "" : "no ", vmode & 128 ? "on" : "off",
+		   vmode & 64 ? "" : "no ", str_on_off(vmode & 128),
 		   vmode & 256 ?
 		   (vmode & 16 ? ", line doubling" : ", half screen") : "");
 }
-- 
2.47.1


