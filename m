Return-Path: <linux-kernel+bounces-553488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE1AA58A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 03:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7492B188CDFB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 02:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D223F189906;
	Mon, 10 Mar 2025 02:18:13 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E8CA935
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741573093; cv=none; b=WOimuBTwjf2XnYOE5FfVF36yUVgPThPMQ0cJyBeAFFWLKdnZRAnSbDV3Zi4LVADjPOxj4yfQOp/7J71fZyYCXiiT0na3Emgjx5g6swMRS258hXl2zOYrb9r/IHKl2UPK3G5OORqseNyOJ+ODO2og4/yYWs55/16Ggnjcv697PcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741573093; c=relaxed/simple;
	bh=mbtf9veYrCrRfgqvsdsnXp9xr2jROJgHfnuNE3rNgVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nRnsAl+/hjbspAgmmnKGsdYPlNVEc4+4vzkUaWsQDg5QmI6vga4X4lAS4+RsPR5vPgO73P4A1oesDB4nEhDaQnhCkZQo+ZsgthRiD5zCOWCQTtZsElmvhsLnhR+IC43MQ6x3yohUXCy+t+Pofb/cLkhY0zEp6dJ7pwa+YLv1NC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2bc4590efd5511efa216b1d71e6e1362-20250310
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:714a792e-d65d-45f2-acdb-0f73a9af7f3f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:b1d969583b6a59686ae824acd623b8e7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102,TC:nil,Content:0|50,EDM:-3,
	IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 2bc4590efd5511efa216b1d71e6e1362-20250310
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <luyun@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 857193283; Mon, 10 Mar 2025 10:12:52 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id CBA4FB80758A;
	Mon, 10 Mar 2025 10:12:51 +0800 (CST)
X-ns-mid: postfix-67CE4AA3-712602477
Received: from localhost.localdomain (unknown [10.42.43.204])
	by node2.com.cn (NSMail) with ESMTPA id CD518B80758A;
	Mon, 10 Mar 2025 02:12:50 +0000 (UTC)
From: Yun Lu <luyun@kylinos.cn>
To: syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in mas_preallocate (2)
Date: Mon, 10 Mar 2025 10:12:49 +0800
Message-Id: <20250310021249.2624454-1-luyun@kylinos.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <6756b479.050a0220.a30f1.0196.GAE@google.com>
References: <6756b479.050a0220.a30f1.0196.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git  master

Signed-off-by: Yun Lu <luyun@kylinos.cn>
---

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index a68e17891b0b..7d3769e0ac0b 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -104,6 +104,7 @@ struct taprio_sched {
 	u32 max_sdu[TC_MAX_QUEUE]; /* save info from the user */
 	u32 fp[TC_QOPT_MAX_QUEUE]; /* only for dump and offloading */
 	u32 txtime_delay;
+	ktime_t offset;
 };
=20
 struct __tc_taprio_qopt_offload {
@@ -170,6 +171,19 @@ static ktime_t sched_base_time(const struct sched_ga=
te_list *sched)
 	return ns_to_ktime(sched->base_time);
 }
=20
+static ktime_t taprio_get_offset(const struct taprio_sched *q)
+{
+	enum tk_offsets tk_offset =3D READ_ONCE(q->tk_offset);
+	ktime_t time =3D ktime_get();
+
+	switch (tk_offset) {
+	case TK_OFFS_MAX:
+		return 0;
+	default:
+		return ktime_sub_ns(ktime_mono_to_any(time, tk_offset), time);
+	}
+}
+
 static ktime_t taprio_mono_to_any(const struct taprio_sched *q, ktime_t =
mono)
 {
 	/* This pairs with WRITE_ONCE() in taprio_parse_clockid() */
@@ -918,6 +932,7 @@ static enum hrtimer_restart advance_sched(struct hrti=
mer *timer)
 	int num_tc =3D netdev_get_num_tc(dev);
 	struct sched_entry *entry, *next;
 	struct Qdisc *sch =3D q->root;
+	ktime_t now_offset =3D taprio_get_offset(q);
 	ktime_t end_time;
 	int tc;
=20
@@ -957,6 +972,14 @@ static enum hrtimer_restart advance_sched(struct hrt=
imer *timer)
 	end_time =3D ktime_add_ns(entry->end_time, next->interval);
 	end_time =3D min_t(ktime_t, end_time, oper->cycle_end_time);
=20
+	if (q->offset !=3D now_offset) {
+		ktime_t diff =3D ktime_sub_ns(now_offset, q->offset);
+
+		end_time =3D ktime_add_ns(end_time, diff);
+		oper->cycle_end_time =3D ktime_add_ns(oper->cycle_end_time, diff);
+		q->offset =3D now_offset;
+	}
+
 	for (tc =3D 0; tc < num_tc; tc++) {
 		if (next->gate_duration[tc] =3D=3D oper->cycle_time)
 			next->gate_close_time[tc] =3D KTIME_MAX;
@@ -1207,6 +1230,7 @@ static int taprio_get_start_time(struct Qdisc *sch,
=20
 	base =3D sched_base_time(sched);
 	now =3D taprio_get_time(q);
+	q->offset =3D taprio_get_offset(q);
=20
 	if (ktime_after(base, now)) {
 		*start =3D base;

