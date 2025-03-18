Return-Path: <linux-kernel+bounces-566953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC198A67EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F1C3B0EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D292063C6;
	Tue, 18 Mar 2025 21:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="TLFcM4E4"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAD01F8758
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334008; cv=none; b=Gor+iWbuBPAimrVLLmQeRHQt+VfFB9ZCPU0+S0gLcaY7x9L9EJOO22DzLcxjK9lRvLMtlMM6/6gur2gEnJjpQUX6n2YHlElF1LVJdWiu1+Qt1BCcwlY1v0GyqZUcsljJnHtSG2imZLnobV1T+F9jiCz8TZv2xVDGRdwEyVc0LRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334008; c=relaxed/simple;
	bh=svKDdvW9PxA2BAq1vnizll3MRYiwphrpq4h+SIM66ko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Abl0NvTZR6ylQJckMdnEJNZPeJtLVfoGQ9yB8Uh47bRy/8jQ2b9Y/iw73MNz9+bxOyq8KE5fIQfZvojcklEytkSkkr6ZNfEhb9icg997F9ayHKTsTj/Nfxp6zn9GpvFKMTGfxvii5b5VU/2+1XnHPlx5CYvsf3J8osqAC69lF2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=TLFcM4E4; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1742333991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tcdRdc/J1ZCSv1ssITMDV1GQ06l6DuoiBSFRfa6vlnE=;
	b=TLFcM4E4/5yRfPZDEayxjJjSwi8HWNVKgSemCzRAtwtcgEgg2bKB62AhNvuf84JkOCPC46
	sCpdmCduaxroe/GvZqjqyIdH3vsx1nvh7cBLF/41JOsW1ly5QC1zujbalE6U+r+61YKxpJ
	hokkMBVnLM67EnQsYBL1j8QsqUAs6nOZLHFiU1yECayfCcqdXJVsihHA3hjKGrGLupDVHf
	RaXaqkp5/Hdarg9JRXFccyt+6eSsP/jbDJ9QiTs7O/7wBAjQioI52gjgEGTxf7iq+StxMv
	0k0BJGjv7X3iJxrkp76//79l08Q8Sch2RmGGttWkJMjOuSUS5fBr1T1p7kGCag==
From: Ignacio Encinas <ignacio@iencinas.com>
Date: Tue, 18 Mar 2025 22:39:02 +0100
Subject: [PATCH v3] 9p/trans_fd: mark concurrent read and writes to
 p9_conn->err
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-p9_conn_err_benign_data_race-v3-1-290bb18335cc@iencinas.com>
X-B4-Tracking: v=1; b=H4sIAPXn2WcC/43NsQ6CMBSF4Vchna0pxQo4+R7GNL3lAnewJS1pN
 IR3tzAZFx3/M3xnYREDYWSXYmEBE0XyLkd1KJgdjRuQU5ebSSGVqETDp1Zb75zGEDSgo8Hpzsx
 GB2ORy1o1PTYA2AmWiSlgT8+dv91zjxRnH177Wyq39U84lbzktWxR1Z1qKglXQmfJmXi0/sE2O
 8kPr6x+eDJ7AqDtT6o/A8gvb13XN+1HcPQbAQAA
X-Change-ID: 20250308-p9_conn_err_benign_data_race-2758fe8bbed0
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Sishuai Gong <sishuai.system@gmail.com>, Marco Elver <elver@google.com>, 
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, 
 syzbot+d69a7cc8c683c2cb7506@syzkaller.appspotmail.com, 
 syzbot+483d6c9b9231ea7e1851@syzkaller.appspotmail.com, 
 Ignacio Encinas <ignacio@iencinas.com>
X-Migadu-Flow: FLOW_OUT

Writes for the error value of a connection are spinlock-protected inside
p9_conn_cancel, but lockless reads are present elsewhere to avoid
performing unnecessary work after an error has been met.

Mark the write and lockless reads to make KCSAN happy. Mark the write as
exclusive following the recommendation in "Lock-Protected Writes with
Lockless Reads" in tools/memory-model/Documentation/access-marking.txt
while we are at it.

Mark p9_fd_request and p9_conn_cancel m->err reads despite the fact that
they do not race with concurrent writes for stylistic reasons.

Reported-by: syzbot+d69a7cc8c683c2cb7506@syzkaller.appspotmail.com
Reported-by: syzbot+483d6c9b9231ea7e1851@syzkaller.appspotmail.com
Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
---
Changes in v3:

- Introduce a couple of extra READ_ONCEs to maintain consistency across
  m->err reads (noted in the commit message too for future reference)
- Remove racy read from p9_fd_request by reusing the previously read
  error (arguably, the lock was never of much use)

- Link to v2: https://lore.kernel.org/r/20250313-p9_conn_err_benign_data_race-v2-1-0bb9f45f6bb2@iencinas.com
- Link to v1: https://lore.kernel.org/r/20250308-p9_conn_err_benign_data_race-v1-1-729e57d5832b@iencinas.com
---
 net/9p/trans_fd.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 196060dc6138af10e99ad04a76ee36a11f770c65..791e4868f2d4e16b87bfc6038132b4e8a2a5fb9d 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -191,12 +191,13 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
 
 	spin_lock(&m->req_lock);
 
-	if (m->err) {
+	if (READ_ONCE(m->err)) {
 		spin_unlock(&m->req_lock);
 		return;
 	}
 
-	m->err = err;
+	WRITE_ONCE(m->err, err);
+	ASSERT_EXCLUSIVE_WRITER(m->err);
 
 	list_for_each_entry_safe(req, rtmp, &m->req_list, req_list) {
 		list_move(&req->req_list, &cancel_list);
@@ -283,7 +284,7 @@ static void p9_read_work(struct work_struct *work)
 
 	m = container_of(work, struct p9_conn, rq);
 
-	if (m->err < 0)
+	if (READ_ONCE(m->err) < 0)
 		return;
 
 	p9_debug(P9_DEBUG_TRANS, "start mux %p pos %zd\n", m, m->rc.offset);
@@ -450,7 +451,7 @@ static void p9_write_work(struct work_struct *work)
 
 	m = container_of(work, struct p9_conn, wq);
 
-	if (m->err < 0) {
+	if (READ_ONCE(m->err) < 0) {
 		clear_bit(Wworksched, &m->wsched);
 		return;
 	}
@@ -622,7 +623,7 @@ static void p9_poll_mux(struct p9_conn *m)
 	__poll_t n;
 	int err = -ECONNRESET;
 
-	if (m->err < 0)
+	if (READ_ONCE(m->err) < 0)
 		return;
 
 	n = p9_fd_poll(m->client, NULL, &err);
@@ -665,6 +666,7 @@ static void p9_poll_mux(struct p9_conn *m)
 static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
 {
 	__poll_t n;
+	int err;
 	struct p9_trans_fd *ts = client->trans;
 	struct p9_conn *m = &ts->conn;
 
@@ -673,9 +675,10 @@ static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
 
 	spin_lock(&m->req_lock);
 
-	if (m->err < 0) {
+	err = READ_ONCE(m->err);
+	if (err < 0) {
 		spin_unlock(&m->req_lock);
-		return m->err;
+		return err;
 	}
 
 	WRITE_ONCE(req->status, REQ_STATUS_UNSENT);

---
base-commit: 2a520073e74fbb956b5564818fc5529dcc7e9f0e
change-id: 20250308-p9_conn_err_benign_data_race-2758fe8bbed0

Best regards,
-- 
Ignacio Encinas <ignacio@iencinas.com>


