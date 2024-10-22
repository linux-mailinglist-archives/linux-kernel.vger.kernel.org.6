Return-Path: <linux-kernel+bounces-376431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779739AB159
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B75284DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38A81A38C2;
	Tue, 22 Oct 2024 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b="t7FFmX+K"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01441A3047
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608562; cv=none; b=t1yR4SO21QzgPcw2Teym3fyXRCpTZ5bpHbp1Un3ILurMf+8AYofBWw9cKcssdpU5fdQmok+mhcrPVD4fWdc4vkbxE+cHnfvjtiq1vGEWEAPyGFjrnA3jkQxYprt1igNb48D0pMUye22/d+pBEBs8+JGctmSOyuH1XxMVs0ITmaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608562; c=relaxed/simple;
	bh=4OEr5DlA2GJoYYQduLmLnz2yUHPnnHV7+HNBrHK40y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxSDVSmrgjNFtnFrq2ItetStXE2+BhtWg8Ik1SvaOGGJ5L6eqKHTATIN+TNYyZ/nJ55XFX7DQ6xd7/TsVCJzJcx5h0R8YpSdvuRa9xNIidH8WSoySeyns6uvIz0ReYNMgfSzB4K5Cy0xzRrena54/6w6JxzgN+Dcj1z4wArq+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com; spf=none smtp.mailfrom=batbytes.com; dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b=t7FFmX+K; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=batbytes.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6c5ab2de184so33879326d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=batbytes-com.20230601.gappssmtp.com; s=20230601; t=1729608559; x=1730213359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUIHvjCHyF6SlVUAxO2Vzn0YEoHF5gMFXLys0iHDmcY=;
        b=t7FFmX+KGk9OKSkIJZOJDWrQ5kuJt6OlBJxmBKu09bpSpDAt6mUVbmjrX09eQM9zyF
         zrkPvvdCP2wVPU55hLTcAUtt+mARuBGGDMhR6fnLu8Yii/LalUSjc2NVG6I8fCcVW8G4
         GiC7F/aX40bsJntb9j/Z/Bv0FrcI6dptfrRt28wJL/iTdpEDwHhcycTMy4ekem9sKDam
         uZnMOSkv5rh7ivtxEAtMOuG0dn7Js9Rw6poxvvNoeATtujVM2BvZIM9nToxyfZGP9pko
         FzRuSkcQlYexydcEZnJeztjTAmXA56vOB2DvALh2FmKbogg0l3ASHJOnBSWzQVelCGMJ
         Lk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729608559; x=1730213359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUIHvjCHyF6SlVUAxO2Vzn0YEoHF5gMFXLys0iHDmcY=;
        b=n01m/lHWMhS0j0WSEa7M6FI4pQAsZrMjQSkK5vrCdMiPfecUv5YCQ8ueDjNqG2QyHI
         L45NwGDibcQ2BOKDxKGeSPU40Gfv1XcThcTSeSeis9ey7I5j9UW22hwwKn2ORL/UtIQF
         LPem6k0iToFbKUzoj5y/tmCPfqWYjr5d6rLn3MauXkogrpbhk31dxLchJ16JS5C3ri4t
         htS4yexFK+T2ScmTbqzXEWccG49QAswaPPVM6elqmGiTX7iVshfqpcGSk8/ltedLTMW5
         6RreZ5VRPZweC1w+uA06toBf7TDEeNi+M4xxhoj6NJGqCzJ2QmW7/drMtI5Pa3Xi3TPd
         f02g==
X-Forwarded-Encrypted: i=1; AJvYcCVspHpTt5dCozGMmle/BmugH4+WsuWIQIoMSWVosm9921ZCXgr7B5a1t2dFhScgIi+4NJjIYQalqTYYBvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+wxgYQaTrsYYsCzEO/BwuRjwtwXkly+9gzX5FRx4yND2KOBAK
	4xw4EKDNUUi642M5U/TbvShqf4ZB/VQgnC9ZpFWpdn17Ddo2ojWNBbbb6Vh4nw==
X-Google-Smtp-Source: AGHT+IH3GsDmqjG7wCDqtCT6s5bIQ7bSl7g/uLVQ9ufgCfUrWcFOgQzIsrGJDmIGgT4w6Y6GpQAnMQ==
X-Received: by 2002:ad4:4b6e:0:b0:6ce:2f4e:40f1 with SMTP id 6a1803df08f44-6ce2f4e43d0mr10514266d6.26.1729608559507;
        Tue, 22 Oct 2024 07:49:19 -0700 (PDT)
Received: from batbytes.com ([216.212.123.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008fb5e0sm29567476d6.33.2024.10.22.07.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:49:19 -0700 (PDT)
From: Patrick Donnelly <batrick@batbytes.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>,
	ceph-devel@vger.kernel.org (open list:CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] ceph: improve caps debugging output
Date: Tue, 22 Oct 2024 10:48:35 -0400
Message-ID: <20241022144838.1049499-4-batrick@batbytes.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022144838.1049499-1-batrick@batbytes.com>
References: <20241022144838.1049499-1-batrick@batbytes.com>
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


