Return-Path: <linux-kernel+bounces-572414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DA8A6CA1E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D73448007B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 12:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A024210F53;
	Sat, 22 Mar 2025 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krHmuajY"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591A11BD9C6
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742646192; cv=none; b=LpUtOKzBoGFTj4SY+zVk2YnwRKXL0AoHlwc4Z9FynVAVsAPTp7juCMqAdCPS/o51DGjF1orgwTsF8L++QFeDSExuF4S/jg7B5YJtEVGmyFq95WGwvjBOXdHgzCCut15JIAABpWxKe+SZE9BumcafyX/T/t7Q+0OGoyIptiX2BoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742646192; c=relaxed/simple;
	bh=d8JWowr8kapn+ItQ75V7lDUdSp55ahF3wxgME/NB5PM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J2mtgm2ewWwnibUASZpNz1/oSQSCUC+KTsbI3gq8eotEcuKGObPBIIRzNOmCRfia5J6nL8JpRXdeJ5FwqbvmnQxGGGxhc+ZiT+pVciCzHE4kD+g10Z3EauCNZ9LsFTqSFVRyw3Z+R0XNtEakcQiFYGoFiXLlmXCa4K9FFMWd4Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krHmuajY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-225df540edcso79838865ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 05:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742646190; x=1743250990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RReRKppMWF+uD20FTGYQunGgSKM48G7FV/uL2ubzV4=;
        b=krHmuajYeyVbTKCPNEkboXvDK+ScdR/27GSgDNAvDWMKJdJeA9Hz6kONPWMfuN2HLf
         GBe6+jno1/Y5tP4GECyTCz3DR1EDExhTfm8dbR2a5tNbZjStBDt+tFZjvXDeS+a8757E
         k57Iz3pHizVoDT+FQME0IgpzR3RA5hHRimRALGaiRs3hyZPire7s6uf3C2e4FZovDUZM
         vkX+CsQZipmKDZrlIxuF8HbV4X91/KVp/VMnqRAXYSjuW8iWo6Y/8/NGjUeW4IVMM0Pr
         VhTJgp5YwOmypCGpK3mywv+FYaj+SJO6GiVJrpdQQD0p1UURpl2lg6daBcWeippks6G2
         SDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742646190; x=1743250990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RReRKppMWF+uD20FTGYQunGgSKM48G7FV/uL2ubzV4=;
        b=QHS46Dl1mh/z4MDWWxXTcdN+oz/UcrDGwvZKFTWRWnXF++7d4ft+V9DV/u7v/D0HeM
         arRZydf3k4IcB7hWht1UYV4MipA9iaAXdkBiICwqtiYQdU99zjTAtkNC0R709duwtp01
         VxgrsiELuGszfekvJEeJaRjJPXIQpAWkEZqr56ON6pEqSSUIewMK1myzpLm99iDkh1Mt
         ZN6aIanquhtgIAYyc2AW2ATIb3bhaXkjdgCClPR+8IdVyyKudAHuILNPgZHGT9PFfp8o
         v0eJH70I7+QGHLSNYEq0BzpxpaWxP1qXmbPs5totCgUXqHvV9m8CjnGH/N9A89LksQ0z
         psRA==
X-Forwarded-Encrypted: i=1; AJvYcCXxSc78dQpTEE3xbHVmBVcQPhXLtkeeCwu9DqYxHORzcE2TyEEYR7uqSObg2iN8m9veTES3Y0pIZajEJNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZNq5xH2v+P+FqJRrBwxOphErE88+QWt5/n+tR7Uh1q9KefHZN
	oTQHPo30PUAP/GOMIlZaiIQxBE/KfQ/8B/DuEUmgzjA5PHVDf3i8
X-Gm-Gg: ASbGncsI4R9sidA7dVmto0yNit2eLC3RjJ7AaAdWRIwKhd1O+jlIEmxbewx6HJczcvz
	QLFtAwCxvp56ouTTz95nkeD/mXLisXwNw2OCAa7APVKuxbwKqNrc8U5HUwiz/+x4IxJtpjg9RNl
	0h3au2EJWNirTKeGI9JL3u/EGrAODjgg23/UIU5P+lWGIYyWyE/acAgHtD6G5LDByXAdy9lwrwV
	d6KVNWLsydt/3wDN4lRcXupw0kJaald0KHA/evuhjMoc0wAauZbMPzZpnKqOBpMU+rLmqCwVDWG
	9lUsPhKzFJkCl9kNxJdN4tQw6V0dT3GTUq5PPgmMtxOemSA=
X-Google-Smtp-Source: AGHT+IFM6C6nsADkgGmSagtKIrEtTJsOZ73L79oOwyzmajb4Oh5MtqhqzzRCf/RiRGLEbixg+ziq9g==
X-Received: by 2002:a17:902:f603:b0:216:271d:e06c with SMTP id d9443c01a7336-2278067c0b2mr108319725ad.4.1742646190356;
        Sat, 22 Mar 2025 05:23:10 -0700 (PDT)
Received: from pop-os.. ([2409:40f2:1044:5619:882a:31f8:4de1:77f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811d968asm34198795ad.162.2025.03.22.05.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 05:23:10 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: syzbot+b974bd41515f770c608b@syzkaller.appspotmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in add_missing_indices
Date: Sat, 22 Mar 2025 17:52:33 +0530
Message-Id: <20250322122233.218306-1-duttaditya18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6745ebeb.050a0220.21d33d.001a.GAE@google.com>
References: <6745ebeb.050a0220.21d33d.001a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

diff --git i/fs/jfs/jfs_dtree.c w/fs/jfs/jfs_dtree.c
index 93db6eec4465..de33026d18d2 100644
--- i/fs/jfs/jfs_dtree.c
+++ w/fs/jfs/jfs_dtree.c
@@ -2613,7 +2613,7 @@ void dtInitRoot(tid_t tid, struct inode *ip, u32 idotdot)
  *	     fsck.jfs should really fix this, but it currently does not.
  *	     Called from jfs_readdir when bad index is detected.
  */
-static void add_missing_indices(struct inode *inode, s64 bn)
+static int add_missing_indices(struct inode *inode, s64 bn)
 {
 	struct ldtentry *d;
 	struct dt_lock *dtlck;
@@ -2622,7 +2622,7 @@ static void add_missing_indices(struct inode *inode, s64 bn)
 	struct lv *lv;
 	struct metapage *mp;
 	dtpage_t *p;
-	int rc;
+	int rc = 0;
 	s8 *stbl;
 	tid_t tid;
 	struct tlock *tlck;
@@ -2647,6 +2647,16 @@ static void add_missing_indices(struct inode *inode, s64 bn)
 
 	stbl = DT_GETSTBL(p);
 	for (i = 0; i < p->header.nextindex; i++) {
+		if (stbl[i] < 0) {
+			jfs_err("jfs: add_missing_indices: Invalid stbl[%d] = %d for inode %ld, block = %lld",
+				i, stbl[i], (long)inode->i_ino, (long long)bn);
+			rc = -EIO;
+
+			DT_PUTPAGE(mp);
+			txAbort(tid, 0);
+			goto end;
+		}
+
 		d = (struct ldtentry *) &p->slot[stbl[i]];
 		index = le32_to_cpu(d->index);
 		if ((index < 2) || (index >= JFS_IP(inode)->next_index)) {
@@ -2664,6 +2674,7 @@ static void add_missing_indices(struct inode *inode, s64 bn)
 	(void) txCommit(tid, 1, &inode, 0);
 end:
 	txEnd(tid);
+	return rc;
 }
 
 /*
@@ -3017,7 +3028,10 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 		}
 
 		if (fix_page) {
-			add_missing_indices(ip, bn);
+			if ((rc = add_missing_indices(ip, bn))) {
+				jfs_err("jfs_readdir: add_missing_indices returned %d", rc);
+				goto out;
+			}
 			page_fixed = 1;
 		}

