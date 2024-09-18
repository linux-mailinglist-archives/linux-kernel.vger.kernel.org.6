Return-Path: <linux-kernel+bounces-332247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F8E97B72E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 06:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747BC281FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 04:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD8C1386D8;
	Wed, 18 Sep 2024 04:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtW2JiDn"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DFE5588F
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 04:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726632245; cv=none; b=mA+nRa+Yfat5DLXLLAIBzqxdOOyRyuH8t6Rs3E6Ledk/AwFRZxUgcu5zsoGLhdc5jfjgwB4/q/kqMsR2YAiY6K7/+mtaP25WGRQOhRIypY4jY1PjDlqyS0mO+N8o9Hq5KQXxxYcEg17nGQWySX2DX/Fiwp6ZDojQLJv5dZ11gYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726632245; c=relaxed/simple;
	bh=g8aCclcIOoxlTxgin7zj4UlRLEDM0xID/ZCMXRhbS94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pkzXOodKY1p2L6vhRCaepviXRmHzWpsyLG5sDDKJtL2z9VmLHm+nHlwRn3LSUGLKjYFs5j/ZVYF2P3038lKRAZXdPeUaV8zniFJuo/u6xvh3i4d4L2KOyX/6qZic6ZiheGhdefoXCf9Sglt1smqvg5+1uUPooR3HLLyrjdtMjfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtW2JiDn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-206aee4073cso63869795ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 21:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726632243; x=1727237043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+lE2AlQ2VhUnUgBUO0LtM4gZBxdX1Qi7kt/dc8W54Y=;
        b=EtW2JiDnA/n3Vdj5Isa72jU6pl8L4mmv8yeHiZDKFinBbyhNXhREGsAn58HxoiGHmO
         FrbK9AsyZEH9GstlaD6GbcRLydH8ldotTSgU1vW4XNdiAXd8Ty5qoCISlhWs4AbYirub
         cDDNTL4aBvpUNhD9Dt7p3p3r6Ho4qFvTjAkIGipv38HN46GWA6oB4V9r1BEH+0rBMMJ+
         i0cLt3PK+ixMYpPc0v54p2NVVxwl8x9YULtuuMg16CarR0AFxHlqbb54K57oKzve3amF
         JU6Xqy7wa2cbRkpNZHWmo6uYDKq7yNNcm6QUwXF/wTJq7OclRLbaA96spfzFalKdNscu
         /x6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726632243; x=1727237043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+lE2AlQ2VhUnUgBUO0LtM4gZBxdX1Qi7kt/dc8W54Y=;
        b=PPBYBzgAAIRnzLDNKdDKH1JwMfzrNknCTXn1viAfi2nVMklRHK/bE+re97DNgojwBK
         LVamV/IrxntjcaIrVP0NMiKTUjb7xWFdkHv56H5vnBc0I/SNtaTVCvUw9f/lGLT03jKO
         oQxbHnExov4DNSwqzJv7HuYamr81TlRL9FxeyL78eXiz9/arVsO5clEWR1K9fElEXhxZ
         SrbAVpb85kF6sGXLGPBf4ojdbfh8Wu/74EYHxPpiu+K0jv7udeK1klIegsWuXo5zKCMi
         8X3WHZ0F/hKgY5FS2Sbkf2e/fhbQrGqoOzcH42TfWHBe+jrlyGEMAGUrOsfkTVs2jb6e
         //Tg==
X-Gm-Message-State: AOJu0YwCV6bUaFdudJ79DWSz7ztd+wIXiph9XTs5Hioyd0wetERzn3vr
	J1nM2qdiFq9bXL35xDno649Ouk2l+npoUr3jmNfo45lHa9N8cGFbd0VZZNWq
X-Google-Smtp-Source: AGHT+IFabt3/Yn9O5YMpz7E0q/NmSZRR5sNZEFGvt/CaiORbUjdfYhkUWyiV+YqXWE3Y6JVG8CVXKQ==
X-Received: by 2002:a17:902:ecc4:b0:202:508c:b598 with SMTP id d9443c01a7336-2076e447f9cmr343542035ad.59.1726632243197;
        Tue, 17 Sep 2024 21:04:03 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794603792sm57160435ad.106.2024.09.17.21.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 21:04:02 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
Date: Wed, 18 Sep 2024 13:03:59 +0900
Message-Id: <20240918040359.189212-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000007337c705fa1060e2@google.com>
References: <0000000000007337c705fa1060e2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 fs/ext4/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e72145c4ae5a..466aece8518f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -338,7 +338,7 @@ ext4_fsblk_t ext4_inode_table(struct super_block *sb,
 __u32 ext4_free_group_clusters(struct super_block *sb,
 			       struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_free_blocks_count_lo) |
+	return le16_to_cpu(READ_ONCE(bg->bg_free_blocks_count_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
 		 (__u32)le16_to_cpu(bg->bg_free_blocks_count_hi) << 16 : 0);
 }
@@ -394,7 +394,7 @@ void ext4_inode_table_set(struct super_block *sb,
 void ext4_free_group_clusters_set(struct super_block *sb,
 				  struct ext4_group_desc *bg, __u32 count)
 {
-	bg->bg_free_blocks_count_lo = cpu_to_le16((__u16)count);
+	WRITE_ONCE(bg->bg_free_blocks_count_lo, cpu_to_le16((__u16)count));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
 		bg->bg_free_blocks_count_hi = cpu_to_le16(count >> 16);
 }
--

