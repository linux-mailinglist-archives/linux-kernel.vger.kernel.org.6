Return-Path: <linux-kernel+bounces-362670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1D499B7E1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 03:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98862834CF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 01:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BD010A24;
	Sun, 13 Oct 2024 01:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b="X0K+zrKf"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E407AC8D1
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 01:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728782214; cv=none; b=t6uAaqbFhn6mSDbGAwyWr3EXuarulwPWuLdem8D6rwkqgGdENqlZYRajU3Gn4OvB6YI2F8Lndp4Gn1xwC0rje/ucuKaS7N/nX3VbnRJ/0Jf6z7YRadwhL1JKUrs1P1gnX6QvPtqH1wZpwEsyBrw91ZKppooq5wY2j+YBZndQpHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728782214; c=relaxed/simple;
	bh=B4/JBdGM31QVKWtGy9/jYiS1rDqbLwKvIygE6O9yYRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMz3ezTg7fh9mFN957mICvGKUirBUkx5Ag0V0/pXYyNbMuKPDOQGw16Z742wJAlfYgva3MzSvNHZLTTl4pNTWZFnPNOlW1jauZfBvtlWZpb4zaWRQEPne5EmcOvGleurfqWSmj5jwnAc/bTPpI8QdxdnOJS1zHnA51JBoU9ggB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com; spf=none smtp.mailfrom=batbytes.com; dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b=X0K+zrKf; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=batbytes.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b1109e80f8so242474785a.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 18:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=batbytes-com.20230601.gappssmtp.com; s=20230601; t=1728782212; x=1729387012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao33/Ao6F4cGAA89YWrjFOas+y1/CWWJL3mox+XBbjc=;
        b=X0K+zrKfXGi1TlKJuF2Amy1NExFrSdeWEgHwpwqC4vSdbIDSgeplEtLIQOxLMA625p
         YruaZ/vqO5H6f369aIyfxVeN1zTFPb2U+gYJJgZ40ntdvvF0TlY6q1doQTy40ag08MYn
         S5/NijBeTR3Y7HLMssRC5/kpvw1JL4QF0PJRx75awhg8BAH69xeHHuPc4FWQuwiB0PRk
         p+H6utGmJqMXMnvLYrp4lSixJVCyouMUq3CIlgXLauVRG/ubfCTo2jYd1WOa2puatULM
         hy4CBIJq31YkJBJ/vcp5q/JoBZ/YP1xMJoDPiSTqcdlNVcZ3I8na77uOg169YD3xYGdc
         k1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728782212; x=1729387012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ao33/Ao6F4cGAA89YWrjFOas+y1/CWWJL3mox+XBbjc=;
        b=DQ/bMeCgMNfc8RHJybTxdt0gU5PPnZ3aZ2KJ9ybigXdIo/2NGKZzRIxh1E82mdjg+4
         FNrrOEEfIGCmDtvIcIErR5lFH6Re7yrlyv8tJYkgNyYZki89yM1WJb17BOyniyvF+q26
         gLkwN882jP1a8uOshc+NACdUslcr9jSVsQeALd8oIBz+Vvx5naMgc0AsIh/m88RdihLY
         44ZIIxotC+k8jSYtRYDWSBAimXT5iYQ1U2v50M5oKVXqjJsK7tBXCqaK+WGdsN6gPqo9
         1ZSYhYTxaTL8jGnJVnkurrDjTpS/5ETRrrxmf2Mn8G9z6jwngR3a3l2IRwHMDFM37R41
         HKJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6DxfuRffxixCZOK2/A+BFwg+YZYo5HExVvQe2Q/8XROR3JPOuZysQ6ccqP93sDZ5W2kMJb+3145aS/0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz10V/AXFfybaiez2c5boh1fsxuFb+jeGKa8Ad6peIaAWy3t6i
	dYLY0Qj6iWDNrQ63m6Ul4LyE2iBUk5mU+znwkcyb2qAvy9Ypfv87H6n3PJRuPw==
X-Google-Smtp-Source: AGHT+IFJEb+9QlegsG9tlU60TN/xXY4vaGD3+cebeFjdCh6B+MYUYbiA8cyUAOY4hpAseLavrfwDww==
X-Received: by 2002:a05:620a:46a8:b0:7a9:a7aa:4bb8 with SMTP id af79cd13be357-7b12101b4fdmr803680985a.55.1728782212065;
        Sat, 12 Oct 2024 18:16:52 -0700 (PDT)
Received: from batbytes.com ([216.212.123.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11497704dsm273414185a.101.2024.10.12.18.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 18:16:51 -0700 (PDT)
From: Patrick Donnelly <batrick@batbytes.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Patrick Donnelly <batrick@batbytes.com>,
	Patrick Donnelly <pdonnell@redhat.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ceph: correct ceph_mds_cap_peer field name
Date: Sat, 12 Oct 2024 21:16:38 -0400
Message-ID: <20241013011642.555987-3-batrick@batbytes.com>
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


