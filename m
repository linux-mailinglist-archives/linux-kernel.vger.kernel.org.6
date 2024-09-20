Return-Path: <linux-kernel+bounces-334408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC1A97D6DD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653591F25058
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D1417BB32;
	Fri, 20 Sep 2024 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5jGgydf"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C2717BB21
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842474; cv=none; b=IJor4NpAEr6EkYXmTE1T0doPrd3Q1kPFfULroI6rsLmZZegITGGvgUOoBnyg4UvwlpewlkCRkoIrbSumoGxn2+oalpJATM07bFw2MUYvrAqBFOGhAz1n5+pSTZdo+2+0xZ9C4DglLrNCMIOIdhnoOrrxRvZolAXD0dJMdeZcYYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842474; c=relaxed/simple;
	bh=nXqcKMX8l84O0EWGsTXDGtGnVtyKw0L3t/YNS4fAb8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NmXUCmRws52UdxWgobmlTRUnhhGM8e/dyC28fIh3SYoHUBqewWNDxk3x2JLX/A8W23oZwuRzWf/XbGHY6eqh7knr/4Vp0OFJE33dmVh4X+3jqZsb5SHO/eVLk54N/3pDc7FckTcxv9Ixzh9fd3IY8+LnytNhA6WRBMNVAfrfGlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5jGgydf; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a097ff7d89so8655115ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 07:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726842472; x=1727447272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Orf+9b50XSAOeUj43sWwW4I9/EjMmG9gMm3IkdJWZTc=;
        b=g5jGgydfwILDVUucvefOzy43dL5FxYFkFTmdMMc7tjOy0oPJmPfuevzfZrXaa0TV6e
         ZX48wI5y3CWq/1+NRO7CxKg/TZ2xcDjSnehPgZpF7iUWKwZqrbSucLBIP6h4ehvlaDBO
         WYBl1DVeh20F26fFmfGavvJXi/wMmCLDRscjFO4UqRTwljuUDLDQV28xeyYWCkEM0YN5
         Gq+l+blnasp+Km9cbHXm4hL9pM9dUCIJg/ZOTCthRwlkfbGSP7gGVAIJT5A3cYhr5dnM
         ZYPmrptO+XJ84NicPqxo06LhNQ15wJP+DpPdoaHyGCXw7e77CwG19nYK9Lm4cajS0OWo
         FrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726842472; x=1727447272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Orf+9b50XSAOeUj43sWwW4I9/EjMmG9gMm3IkdJWZTc=;
        b=FYPmNqTfwziKjf9jNrhcMGgU222iTBUA3LmXvFRYOg29TTTLUNHikaQRByiwC6pxiu
         i2Qwo6xyInV6HLQwO5kdsdhXZDrdaJ6ber84MYbuC8ChyqBvAtQFaT+URzBcETyKfjdJ
         dL/r6VtdxPcYP21QxEgtFt4A51YgIvEYni9YeE7GEtefh+AaHv+w9lhqKhn9+5VR+Llb
         xH3swidpITI84zV3yhXKEXdK1h94t8PfKGtPJQrtqIf81qxif0CP1737N3UeBsnOWS8j
         N3jmLZWYlt9zEk9Qh88j3NvmRjTYUI6uTrzycVknTT3dYtU7G+NEDZd44OOWvFB22/B2
         FNSA==
X-Gm-Message-State: AOJu0Yx82orASPODPB+2aQWHNoKKDC5hjtWz8RMCx8CV3nOOlN94e2Zq
	8bn7a80E5kj7eOT+CzvD8AKySJBqPlmSseQhkbO8ia0r6Enllcg0
X-Google-Smtp-Source: AGHT+IH6ZaA2djEXQ3smu1PF+CCahOWqm11GAoVybEIkhjRNF1KvGo64TP0+xlRLPV5kpoFnC8ddjQ==
X-Received: by 2002:a05:6e02:1b0d:b0:3a0:9aef:4c2 with SMTP id e9e14a558f8ab-3a0c8d3379fmr36840035ab.19.1726842472034;
        Fri, 20 Sep 2024 07:27:52 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4998e21dsm10980797a12.75.2024.09.20.07.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:27:51 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
Date: Fri, 20 Sep 2024 23:27:46 +0900
Message-Id: <20240920142746.3370-1-aha310510@gmail.com>
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
 fs/ext4/ialloc.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 9dfd768ed9f8..fec01c64443a 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -500,11 +500,14 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
 		for (i = 0; i < flex_size; i++) {
 			if (grp+i >= real_ngroups)
 				break;
+			ext4_lock_group(sb, grp+i);
 			desc = ext4_get_group_desc(sb, grp+i, NULL);
 			if (desc && ext4_free_inodes_count(sb, desc)) {
 				*group = grp+i;
+				ext4_unlock_group(sb, grp+i);
 				return 0;
 			}
+			ext4_unlock_group(sb, grp+i);
 		}
 		goto fallback;
 	}
@@ -544,14 +547,17 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
 	parent_group = EXT4_I(parent)->i_block_group;
 	for (i = 0; i < ngroups; i++) {
 		grp = (parent_group + i) % ngroups;
+		ext4_lock_group(sb, grp);
 		desc = ext4_get_group_desc(sb, grp, NULL);
 		if (desc) {
 			grp_free = ext4_free_inodes_count(sb, desc);
 			if (grp_free && grp_free >= avefreei) {
 				*group = grp;
+				ext4_unlock_group(sb, grp);
 				return 0;
 			}
 		}
+		ext4_unlock_group(sb, grp);
 	}
 
 	if (avefreei) {
@@ -590,11 +596,14 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
 		if (last > ngroups)
 			last = ngroups;
 		for  (i = parent_group; i < last; i++) {
+			ext4_lock_group(sb, i);
 			desc = ext4_get_group_desc(sb, i, NULL);
 			if (desc && ext4_free_inodes_count(sb, desc)) {
 				*group = i;
+				ext4_unlock_group(sb, i);
 				return 0;
 			}
+			ext4_unlock_group(sb, i);
 		}
 		if (!retry && EXT4_I(parent)->i_last_alloc_group != ~0) {
 			retry = 1;
@@ -616,10 +625,14 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
 	 * Try to place the inode in its parent directory
 	 */
 	*group = parent_group;
+	ext4_lock_group(sb, &group);
 	desc = ext4_get_group_desc(sb, *group, NULL);
 	if (desc && ext4_free_inodes_count(sb, desc) &&
-	    ext4_free_group_clusters(sb, desc))
+	    ext4_free_group_clusters(sb, desc)) {
+		ext4_unlock_group(sb, *group);
 		return 0;
+	}
+	ext4_unlock_group(sb, *group);
 
 	/*
 	 * We're going to place this inode in a different blockgroup from its
@@ -640,10 +653,14 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
 		*group += i;
 		if (*group >= ngroups)
 			*group -= ngroups;
+		ext4_lock_group(sb, *group);
 		desc = ext4_get_group_desc(sb, *group, NULL);
 		if (desc && ext4_free_inodes_count(sb, desc) &&
-		    ext4_free_group_clusters(sb, desc))
+		    ext4_free_group_clusters(sb, desc)) {
+			ext4_unlock_group(sb, *group);
 			return 0;
+		}
+		ext4_unlock_group(sb, *group);
 	}
 
 	/*
@@ -654,9 +671,13 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
 	for (i = 0; i < ngroups; i++) {
 		if (++*group >= ngroups)
 			*group = 0;
+		ext4_lock_group(sb, *group);
 		desc = ext4_get_group_desc(sb, *group, NULL);
-		if (desc && ext4_free_inodes_count(sb, desc))
+		if (desc && ext4_free_inodes_count(sb, desc)) {
+			ext4_unlock_group(sb, *group);
 			return 0;
+		}
+		ext4_unlock_group(sb, *group);
 	}
 
 	return -1;
--

