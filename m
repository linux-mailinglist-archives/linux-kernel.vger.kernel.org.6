Return-Path: <linux-kernel+bounces-302720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13F4960281
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D61B1C223AC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A07F148302;
	Tue, 27 Aug 2024 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MLLHmcXY"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23614158D66
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741558; cv=none; b=jtWI6hp+okTxIOwd+PFi7/8whRn6oBPRUWpCjJGtWFQsgfleqgLeb/kVb/s9CbnOt5ZE6z2e4bmo7C6bWwTQ1wjUO0ftuEdlii5349aYNnDC6yx14AMiGr6ck2KhqhtBUpShv6gjI62Jks6C+V5SZoVkhgkNreBWXaHzhbrOJlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741558; c=relaxed/simple;
	bh=A4CTf0DLhYer1xZF1R9Z55HMF2sNTGOIgBjJ553bW/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YZ8SiUCGz0HHQ0PnOahEADbxzB/nHf+PWNwrMbB9gtNHSs1POb4iALY2l4usZw06zYlqTOJGAxrJAbGCB8gdt8oq9B4sAvLyvMjtSMljuCWfM3F3WokNHWNc0TIOR+4na09IGNT7pEWBCvxHBp+RjQY1TFo11Yj4PfJA19PXapw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MLLHmcXY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3719896b7c8so2639053f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 23:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724741554; x=1725346354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yuw2oLlN9u82x2mFgTSDv2ugVj/bF45+93q+DnAX7Jo=;
        b=MLLHmcXYN6dHWPhbW3CLchYT0Qv3NpTWbWiJN/MvF5Y2nx1UNRyRTTxEb1MYG/evr+
         OZ7+IhErjfP5Y32yyitnJtm2JjcJOULP6TTTAK2kw5VGWMgoz21vxIZEVRvKtBkpF/oh
         wU+Qs2f2XdYOgdvhqlHTCCEk3mpm9xN1GwyMJbcA2apzAH1cZib5KuJG7+8edioa1wbO
         CW8h28uMbjYv55ovO3fTY75LsqtYgnaS2O/aPdO3jhNaBsLrlqTJudoE/OFiKxbKZk6n
         lVE5Jim32Feich8y1Hq88Ie93mZS/N4AHYtXRlTL2ChQb9KIWg6cVHuv/myQsfmGnb30
         +aCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724741554; x=1725346354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuw2oLlN9u82x2mFgTSDv2ugVj/bF45+93q+DnAX7Jo=;
        b=wncNX+llzNmw83JHuwP3TZxIe8TB5vzW5XUqovZnMmh4Ixm83EWKSNu+/mcXRFERIC
         upUcxaLWjONkJtBIPBTx79Di2gihlrAHSclMghz/uYhb9Yoe2UrSsVwRr0ADgDLNH7LK
         xa0EXzAVHzuN5t9w23YWBI5aEEfduuquvzt9fOydxvoikz20vx1H+phD71GSGM/TT6NE
         6sDb1Mxd41U7y1TtfzY7yzJvXdDixlBdviTkjSGONhHh9AJspYMzwLusmA87Vp2NywjL
         f3ENPMhZof9VW3sRJG6ATx7fnvq69nHT2nxcOaDOJU6TtkyaDdwaBmj8qJxmTL28M7kc
         /hag==
X-Forwarded-Encrypted: i=1; AJvYcCUxqBSmE0KtT5MagxYtLnmbkTMIGHooXO2LvuF5iyGbbKxIfjG7ppqiBT4YfviWwDh9wmniOc143GMt/KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEMtLeUmPgmY3H4PjOnxRFp2Kd7sZa56qkOEulZSZlTAD39rR9
	tg4HjTkzSRs71KZdxX2F6K5+AZa3Yzt+SB5tLHjqiYaIR3f/tgvVSYCp+Iflq8ALilnPJVj+hPt
	5
X-Google-Smtp-Source: AGHT+IHiegBfHEhtotIT7zxmJuyDa/Og31R4YqQ6HjoIOWt9SPxnrdpek3pUJcpo9wW6hsYtmnZX2A==
X-Received: by 2002:adf:ebca:0:b0:371:8319:4dcc with SMTP id ffacd0b85a97d-37311840562mr7699202f8f.2.1724741554108;
        Mon, 26 Aug 2024 23:52:34 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162609sm173951365e9.27.2024.08.26.23.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 23:52:33 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	David McKay <david.mckay@codasip.com>,
	Stuart Menefy <stuart.menefy@codasip.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH -fixes] riscv: Do not restrict memory size because of linear mapping on nommu
Date: Tue, 27 Aug 2024 08:52:30 +0200
Message-Id: <20240827065230.145021-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It makes no sense to restrict physical memory size because of linear
mapping size constraints when there is no linear mapping, so only do
that when mmu is enabled.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/linux-riscv/CAMuHMdW0bnJt5GMRtOZGkTiM7GK4UaLJCDMF_Ouq++fnDKi3_A@mail.gmail.com/
Fixes: 3b6564427aea ("riscv: Fix linear mapping checks for non-contiguous memory regions")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index eb0649a61b4c..1785782c2e55 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -252,7 +252,7 @@ static void __init setup_bootmem(void)
 	 * The size of the linear page mapping may restrict the amount of
 	 * usable RAM.
 	 */
-	if (IS_ENABLED(CONFIG_64BIT)) {
+	if (IS_ENABLED(CONFIG_64BIT) && IS_ENABLED(CONFIG_MMU)) {
 		max_mapped_addr = __pa(PAGE_OFFSET) + KERN_VIRT_SIZE;
 		memblock_cap_memory_range(phys_ram_base,
 					  max_mapped_addr - phys_ram_base);
-- 
2.39.2


