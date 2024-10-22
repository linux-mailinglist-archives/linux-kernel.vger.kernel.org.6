Return-Path: <linux-kernel+bounces-376430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352709AB158
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B081F243A5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0601A265E;
	Tue, 22 Oct 2024 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b="mXlTSl1f"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF591A2653
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608559; cv=none; b=F9QbonskcAMdNMgsWIZdGcdr7ckmGw/d6Z7Z1DSbNhg4kWyy4I2Xe9S8hmmJezG22w7F89D0UssNsnKG5XoojkFyfnxSaML2bBVLiMdtNRyFkSdq4QWtad9H3CaoBumQyMDSp3I3HTaFmqpQwFc8q3W0vsjvqtaC8weoke3NIaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608559; c=relaxed/simple;
	bh=B4/JBdGM31QVKWtGy9/jYiS1rDqbLwKvIygE6O9yYRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kq5//ByvKnYlAMYcGYLCU24U5LPQn10yBfanHfBP37zR+baFd7a78uDV/Pv4uvnW01PHR3PcnxhvccISgN8Z98hhmHLVvMMlZRXfSi6obyUeOtmO6ibRkLp1pIMktivolQN+pQH9uJdUoTgOpqg4sdEoe5Ikz6H+vYS9HA/8250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com; spf=none smtp.mailfrom=batbytes.com; dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b=mXlTSl1f; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=batbytes.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cbcd8ce5f9so42460196d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=batbytes-com.20230601.gappssmtp.com; s=20230601; t=1729608557; x=1730213357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao33/Ao6F4cGAA89YWrjFOas+y1/CWWJL3mox+XBbjc=;
        b=mXlTSl1fnTW0aUFzgbuwqW0N6nlgDP8fdzi5Y72/c16b5czYfey1C9MFd+1cknohik
         0DVhjSP1CsoknxMWZdpjZ6SAjgl5QKDRbKTodsTpj1l9EA9RDHwbjD+00euZ90MzmKlN
         RLAiCvmC7VlpMX5dmSmvqm6vtju7gz+BH8IcXyusoZrWPKSEhyBhXlDVKh3W8gTx9poM
         ocDrES5FVD3hZB5p3aN0UV6AIZkyUCWnd0JNOVe1z28URgqKCmAgi5BfS0s/RSKpwLlC
         Bub4sFTSPQ+5Pbdm3VESUKbM1DretIbbOASdA9ptmKp4aqf+2+8SHiK+YRsfG3rYejKr
         cZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729608557; x=1730213357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ao33/Ao6F4cGAA89YWrjFOas+y1/CWWJL3mox+XBbjc=;
        b=JHZ23qPiW8ncpFgLNiqmpOnmQDlLXImefzoHa7Va3wro5UsBQ2IcMXhKc/Gl1aRyKQ
         uUnApDfAva4GkeLCKlEtrOUDnY3hGT0avF3RgKc55MqpNAn9ttd3ORV1gVq0qJKVCZCQ
         yHjMqLzPbpkdajcErTJrWqqQl3DoK+B1mL5kdrqG6Exwhb1vf1WsRH5RSqGLceBftj8+
         MXzqxkhtrKCw7c7prqZ83fcE1TSikO5B9eD5RepzOrdj1IUS2SGdVJfBY8ulGxtSgJ7K
         YgDGbRw/dhYWrjErCiuBAozxXzkvDVR/L2OtOK9T19/LBh5Q8a8DrTECzQ4vVoxs0nwd
         hj5A==
X-Forwarded-Encrypted: i=1; AJvYcCVQXyKaJCVY1VYbE0ATEW4yGXUye2N366VDMMBoAFszrau8qkCaPOJ4NBshCs+A5o/CXr0xSlJqdRSXDd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycD3qB4esPHOnOnQRP12+tvkb05vnprdjm1zckrCop6yQqcEiv
	Ns14RXn7Jv7Bn9dSe8ipzvV9bTDIvRPechnHCAR3DYrVO60AvqUqFvJm49n+Fw==
X-Google-Smtp-Source: AGHT+IEQvf5cTMPWOx5JdiKcQp2p2AUl+navPVpwui70L5Ta37U4YKujOI9u35XkgTY1mpQRh+hL+g==
X-Received: by 2002:a05:6214:2dc8:b0:6cb:5418:4523 with SMTP id 6a1803df08f44-6cde15d31a9mr294382766d6.40.1729608557223;
        Tue, 22 Oct 2024 07:49:17 -0700 (PDT)
Received: from batbytes.com ([216.212.123.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008fb5e0sm29567476d6.33.2024.10.22.07.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:49:16 -0700 (PDT)
From: Patrick Donnelly <batrick@batbytes.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Patrick Donnelly <batrick@batbytes.com>,
	Patrick Donnelly <pdonnell@redhat.com>,
	ceph-devel@vger.kernel.org (open list:CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] ceph: correct ceph_mds_cap_peer field name
Date: Tue, 22 Oct 2024 10:48:34 -0400
Message-ID: <20241022144838.1049499-3-batrick@batbytes.com>
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

See also ceph.git commit: "include/ceph_fs: correct ceph_mds_cap_peer field name".

See-also: https://tracker.ceph.com/issues/66704
Signed-off-by: Patrick Donnelly <pdonnell@redhat.com>
---
 fs/ceph/caps.c               | 23 ++++++++++++-----------
 include/linux/ceph/ceph_fs.h |  2 +-
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index bed34fc11c91..88a674cf27a8 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4086,17 +4086,17 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	u64 t_cap_id;
 	unsigned mseq = le32_to_cpu(ex->migrate_seq);
-	unsigned t_seq, t_mseq;
+	unsigned t_issue_seq, t_mseq;
 	int target, issued;
 	int mds = session->s_mds;
 
 	if (ph) {
 		t_cap_id = le64_to_cpu(ph->cap_id);
-		t_seq = le32_to_cpu(ph->seq);
+		t_issue_seq = le32_to_cpu(ph->issue_seq);
 		t_mseq = le32_to_cpu(ph->mseq);
 		target = le32_to_cpu(ph->mds);
 	} else {
-		t_cap_id = t_seq = t_mseq = 0;
+		t_cap_id = t_issue_seq = t_mseq = 0;
 		target = -1;
 	}
 
@@ -4134,12 +4134,12 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 	if (tcap) {
 		/* already have caps from the target */
 		if (tcap->cap_id == t_cap_id &&
-		    ceph_seq_cmp(tcap->seq, t_seq) < 0) {
+		    ceph_seq_cmp(tcap->seq, t_issue_seq) < 0) {
 			doutc(cl, " updating import cap %p mds%d\n", tcap,
 			      target);
 			tcap->cap_id = t_cap_id;
-			tcap->seq = t_seq - 1;
-			tcap->issue_seq = t_seq - 1;
+			tcap->seq = t_issue_seq - 1;
+			tcap->issue_seq = t_issue_seq - 1;
 			tcap->issued |= issued;
 			tcap->implemented |= issued;
 			if (cap == ci->i_auth_cap) {
@@ -4154,7 +4154,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		int flag = (cap == ci->i_auth_cap) ? CEPH_CAP_FLAG_AUTH : 0;
 		tcap = new_cap;
 		ceph_add_cap(inode, tsession, t_cap_id, issued, 0,
-			     t_seq - 1, t_mseq, (u64)-1, flag, &new_cap);
+			     t_issue_seq - 1, t_mseq, (u64)-1, flag, &new_cap);
 
 		if (!list_empty(&ci->i_cap_flush_list) &&
 		    ci->i_auth_cap == tcap) {
@@ -4268,14 +4268,14 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 		doutc(cl, " remove export cap %p mds%d flags %d\n",
 		      ocap, peer, ph->flags);
 		if ((ph->flags & CEPH_CAP_FLAG_AUTH) &&
-		    (ocap->seq != le32_to_cpu(ph->seq) ||
+		    (ocap->seq != le32_to_cpu(ph->issue_seq) ||
 		     ocap->mseq != le32_to_cpu(ph->mseq))) {
 			pr_err_ratelimited_client(cl, "mismatched seq/mseq: "
 					"%p %llx.%llx mds%d seq %d mseq %d"
 					" importer mds%d has peer seq %d mseq %d\n",
 					inode, ceph_vinop(inode), peer,
 					ocap->seq, ocap->mseq, mds,
-					le32_to_cpu(ph->seq),
+					le32_to_cpu(ph->issue_seq),
 					le32_to_cpu(ph->mseq));
 		}
 		ceph_remove_cap(mdsc, ocap, (ph->flags & CEPH_CAP_FLAG_RELEASE));
@@ -4350,7 +4350,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	struct ceph_snap_realm *realm = NULL;
 	int op;
 	int msg_version = le16_to_cpu(msg->hdr.version);
-	u32 seq, mseq;
+	u32 seq, mseq, issue_seq;
 	struct ceph_vino vino;
 	void *snaptrace;
 	size_t snaptrace_len;
@@ -4375,6 +4375,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	vino.snap = CEPH_NOSNAP;
 	seq = le32_to_cpu(h->seq);
 	mseq = le32_to_cpu(h->migrate_seq);
+	issue_seq = le32_to_cpu(h->issue_seq);
 
 	snaptrace = h + 1;
 	snaptrace_len = le32_to_cpu(h->snap_trace_len);
@@ -4598,7 +4599,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		cap->cap_id = le64_to_cpu(h->cap_id);
 		cap->mseq = mseq;
 		cap->seq = seq;
-		cap->issue_seq = seq;
+		cap->issue_seq = issue_seq;
 		spin_lock(&session->s_cap_lock);
 		__ceph_queue_cap_release(session, cap);
 		spin_unlock(&session->s_cap_lock);
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index 4ff3ad5e9210..2d7d86f0290d 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -808,7 +808,7 @@ struct ceph_mds_caps {
 
 struct ceph_mds_cap_peer {
 	__le64 cap_id;
-	__le32 seq;
+	__le32 issue_seq;
 	__le32 mseq;
 	__le32 mds;
 	__u8   flags;
-- 
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


