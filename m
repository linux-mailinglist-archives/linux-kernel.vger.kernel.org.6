Return-Path: <linux-kernel+bounces-362672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F1699B7E5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 03:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693E81F235E0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 01:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693C1266AB;
	Sun, 13 Oct 2024 01:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b="g6qGtfNg"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D4D1B963
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 01:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728782218; cv=none; b=pipHKurJUaWaiuLBf+9Ra+w0pnFArZoEkx3+j3KetWMLjWLRS659Ff17GaIFd23nRM69Wyt3lF0qTN2gIaobQIv25Gv0Kk3ysZ8AJohtrtnSp500vQc1KX+xvVKZf/byqFidXhd5Myy97z6Hke+38oh9+2qms98181/EQWqU+QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728782218; c=relaxed/simple;
	bh=4OEr5DlA2GJoYYQduLmLnz2yUHPnnHV7+HNBrHK40y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWemkHo6wRPQ8gkfqukE4fB8E0ZbPR7n55Fi8rrZIM03CRrNHHg0xww/0F0FcGfgFtqrOG1o0jfugb6LSQDi60Yo60SqwMBPDs1tOv3IFZP4MA6ga3irJla4OO7V44FGmPih0xwjIf7uWKlBdOcpbLoXEwfkLqTmDNIXR5RglIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com; spf=none smtp.mailfrom=batbytes.com; dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b=g6qGtfNg; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=batbytes.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46042895816so38726821cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 18:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=batbytes-com.20230601.gappssmtp.com; s=20230601; t=1728782216; x=1729387016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUIHvjCHyF6SlVUAxO2Vzn0YEoHF5gMFXLys0iHDmcY=;
        b=g6qGtfNg2h30KOtWd51z0o+unIz7SjRbY9xp/akVt01wu97vD6V4m8YKi96mZ1+lOr
         lJDrrZeCY1zKeLgn1oxTJtKH5cS5Rk57mZa7xcRcYLd5bjCoM8G1z7Dh/mPsVS5EvFtq
         xlLdYgFI/S+sacQbvDDpgOkRw/ouOxKS6ReWjxa16efQyH9SfyVVK3RkT7BtAaueEHGq
         hGfDMRT7r+OO9TbSj5G43reqoIuPTjT+nkuamPZqj0RdvObWLdKDNQysfXC+5R5vwfq3
         1kG1a47N123ra84GcpK/YdT6hisP+bLJ+U2qSrjzAQBowYzWb1uWzYZspSGDcjLt/5RR
         a+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728782216; x=1729387016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUIHvjCHyF6SlVUAxO2Vzn0YEoHF5gMFXLys0iHDmcY=;
        b=Ad/z4e/NJai248GNh/vNm3RaKCAY58lxTdcFnkJZlWBR9KPhE8vWvCMb9BlV1mytfR
         e2yfvuakJ5Dnh+vP6p5Nj6Vc0UVXJ3bkvmCEBJb3te8hMBQmN4Lhsp1BqVD4GDmTK1SJ
         e7X05U++ltJ5yic7nn4A5rOLz0o9TCtprRgnNGUFtNWjn2Mje0aXtR34AV2XJs7SaD5y
         pmBM3llodg8ijhY5/Jaf/utQAcVb3szFUhL7FhTRqap1ydQs5Go1sGd+y0qEYMiPB0D6
         vvCxnLVJnuoknz1d98uqAAPNsoucQCv4J36s8IRcb6Sq/+QlKxPqxNb4mWE1/2B0Tyyz
         n6kg==
X-Forwarded-Encrypted: i=1; AJvYcCXcu2tbIOQHx/WdnpeVGAWKgFBi0MBxvwaufGpv04+9PMeW4dDiD5BXqcoDg4jk4fB5getvy/m/wM9Xyaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/kpgpdt7FPJepEeNCuQuIfg6evOPrVsVBFcqEVQY0kV3yAq24
	ey0ZDTZLq7fxb1KDCrxlRFupGQGeHscRaf1HbEl3DTz/Z8JJ2zn5agOa6FBwCw==
X-Google-Smtp-Source: AGHT+IHn4LCLgxo14mU0Up+yvCPuFH04RlZj1o65iOO7Ykv1NsrbROwX+W4sfFnTSPqmfXiG303lWQ==
X-Received: by 2002:a05:622a:d2:b0:458:34df:1e5c with SMTP id d75a77b69052e-460583e8b4amr84213601cf.12.1728782216149;
        Sat, 12 Oct 2024 18:16:56 -0700 (PDT)
Received: from batbytes.com ([216.212.123.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11497704dsm273414185a.101.2024.10.12.18.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 18:16:55 -0700 (PDT)
From: Patrick Donnelly <batrick@batbytes.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ceph: improve caps debugging output
Date: Sat, 12 Oct 2024 21:16:40 -0400
Message-ID: <20241013011642.555987-5-batrick@batbytes.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241013011642.555987-1-batrick@batbytes.com>
References: <20241013011642.555987-1-batrick@batbytes.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrick Donnelly <pdonnell@redhat.com>

This improves uniformity and exposes important sequence numbers.

Now looks like:

    <7>[   73.749563] ceph:           caps.c:4465 : [c9653bca-110b-4f70-9f84-5a195b205e9a 15290]  caps mds2 op export ino 20000000000.fffffffffffffffe inode 0000000008d2e5ea seq 0 iseq 0 mseq 0
    ...
    <7>[   73.749574] ceph:           caps.c:4102 : [c9653bca-110b-4f70-9f84-5a195b205e9a 15290]  cap 20000000000.fffffffffffffffe export to peer 1 piseq 1 pmseq 1
    ...
    <7>[   73.749645] ceph:           caps.c:4465 : [c9653bca-110b-4f70-9f84-5a195b205e9a 15290]  caps mds1 op import ino 20000000000.fffffffffffffffe inode 0000000008d2e5ea seq 1 iseq 1 mseq 1
    ...
    <7>[   73.749681] ceph:           caps.c:4244 : [c9653bca-110b-4f70-9f84-5a195b205e9a 15290]  cap 20000000000.fffffffffffffffe import from peer 2 piseq 686 pmseq 0
    ...
    <7>[  248.645596] ceph:           caps.c:4465 : [c9653bca-110b-4f70-9f84-5a195b205e9a 15290]  caps mds1 op revoke ino 20000000000.fffffffffffffffe inode 0000000008d2e5ea seq 2538 iseq 1 mseq 1

See also: "mds: add issue_seq to all cap messages" in ceph.git

See-also: https://tracker.ceph.com/issues/66704
Signed-off-by: Patrick Donnelly <pdonnell@redhat.com>
---
 fs/ceph/caps.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 88a674cf27a8..74ba310dfcc7 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4085,8 +4085,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 	struct ceph_cap *cap, *tcap, *new_cap = NULL;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	u64 t_cap_id;
-	unsigned mseq = le32_to_cpu(ex->migrate_seq);
-	unsigned t_issue_seq, t_mseq;
+	u32 t_issue_seq, t_mseq;
 	int target, issued;
 	int mds = session->s_mds;
 
@@ -4100,8 +4099,8 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		target = -1;
 	}
 
-	doutc(cl, "%p %llx.%llx ci %p mds%d mseq %d target %d\n",
-	      inode, ceph_vinop(inode), ci, mds, mseq, target);
+	doutc(cl, " cap %llx.%llx export to peer %d piseq %u pmseq %u\n",
+	      ceph_vinop(inode), target, t_issue_seq, t_mseq);
 retry:
 	down_read(&mdsc->snap_rwsem);
 	spin_lock(&ci->i_ceph_lock);
@@ -4228,18 +4227,22 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 	u64 realmino = le64_to_cpu(im->realm);
 	u64 cap_id = le64_to_cpu(im->cap_id);
 	u64 p_cap_id;
+	u32 piseq = 0;
+	u32 pmseq = 0;
 	int peer;
 
 	if (ph) {
 		p_cap_id = le64_to_cpu(ph->cap_id);
 		peer = le32_to_cpu(ph->mds);
+		piseq = le32_to_cpu(ph->issue_seq);
+		pmseq = le32_to_cpu(ph->mseq);
 	} else {
 		p_cap_id = 0;
 		peer = -1;
 	}
 
-	doutc(cl, "%p %llx.%llx ci %p mds%d mseq %d peer %d\n",
-	      inode, ceph_vinop(inode), ci, mds, mseq, peer);
+	doutc(cl, " cap %llx.%llx import from peer %d piseq %u pmseq %u\n",
+	      ceph_vinop(inode), peer, piseq, pmseq);
 retry:
 	cap = __get_cap_for_mds(ci, mds);
 	if (!cap) {
@@ -4268,15 +4271,13 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 		doutc(cl, " remove export cap %p mds%d flags %d\n",
 		      ocap, peer, ph->flags);
 		if ((ph->flags & CEPH_CAP_FLAG_AUTH) &&
-		    (ocap->seq != le32_to_cpu(ph->issue_seq) ||
-		     ocap->mseq != le32_to_cpu(ph->mseq))) {
+		    (ocap->seq != piseq ||
+		     ocap->mseq != pmseq)) {
 			pr_err_ratelimited_client(cl, "mismatched seq/mseq: "
 					"%p %llx.%llx mds%d seq %d mseq %d"
 					" importer mds%d has peer seq %d mseq %d\n",
 					inode, ceph_vinop(inode), peer,
-					ocap->seq, ocap->mseq, mds,
-					le32_to_cpu(ph->issue_seq),
-					le32_to_cpu(ph->mseq));
+					ocap->seq, ocap->mseq, mds, piseq, pmseq);
 		}
 		ceph_remove_cap(mdsc, ocap, (ph->flags & CEPH_CAP_FLAG_RELEASE));
 	}
@@ -4360,8 +4361,6 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	bool close_sessions = false;
 	bool do_cap_release = false;
 
-	doutc(cl, "from mds%d\n", session->s_mds);
-
 	if (!ceph_inc_mds_stopping_blocker(mdsc, session))
 		return;
 
@@ -4463,12 +4462,11 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 
 	/* lookup ino */
 	inode = ceph_find_inode(mdsc->fsc->sb, vino);
-	doutc(cl, " op %s ino %llx.%llx inode %p\n", ceph_cap_op_name(op),
-	      vino.ino, vino.snap, inode);
+	doutc(cl, " caps mds%d op %s ino %llx.%llx inode %p seq %u iseq %u mseq %u\n",
+          session->s_mds, ceph_cap_op_name(op), vino.ino, vino.snap, inode,
+          seq, issue_seq, mseq);
 
 	mutex_lock(&session->s_mutex);
-	doutc(cl, " mds%d seq %lld cap seq %u\n", session->s_mds,
-	      session->s_seq, (unsigned)seq);
 
 	if (!inode) {
 		doutc(cl, " i don't have ino %llx\n", vino.ino);
-- 
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


