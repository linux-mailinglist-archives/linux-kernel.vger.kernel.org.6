Return-Path: <linux-kernel+bounces-170581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1EC8BD959
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B62283F7F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 02:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829964C85;
	Tue,  7 May 2024 02:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="U3cbMHAZ"
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3994C6B
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 02:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715048294; cv=none; b=STg/Cx4mW2yPajBUvEOXqGqv5UUAqXL5h+W7QYuuyrD5mgvk/1g+IzDwc6acWrvggqM/QJHb9b71MIrwpiS0TbpMTb2kP1JtBMHMpkE1rIzu7cBRNx8YYfXf1r9TbXPOiOikxL56tDQYJFzd1vZonce02fAMqp1BPpBbB5HGbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715048294; c=relaxed/simple;
	bh=6N3eSGRIs2Lgdif3lial3CflgiIAiBBtEuGf86Bw6a0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=BSmXUVDQ4OfI5+UNRnWJUrgnKrNHjaacl9+QqjQBQeJUPCBruT97y6grud6vZLlgai6s9v/qLL6KM4Axs8CFXiookBwXKKAiyboe2cTv5Fc6Y1iMoNJtwNrhLssgMyKuGDx/rEFhEjLCucckExnDzATzlP5PnebByQ51bKaAHbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=U3cbMHAZ; arc=none smtp.client-ip=203.205.251.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1715047983; bh=L68AxZj7zxXZVvaTdJ2toeMLjEVIi/d7IVdXQbKaP4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U3cbMHAZfG4e/V+mIS/dbmjHwoJbNESF6hCezBr/Gb1Ey6GKwV27XkhA00mWGlWhP
	 pyF9Z2h8XDakVh0EujSvVuGFzSUhD+yKkeomZEqDZsVC2T+FTJpkJEeXXCXySjPf50
	 AgRPCJg7v5tpeB9JRDOWp1cHMe8xZWWLz6l7gBYM=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 342072A6; Tue, 07 May 2024 10:13:02 +0800
X-QQ-mid: xmsmtpt1715047982t7oj7skn9
Message-ID: <tencent_456D1097D0EAEAEEAACDD47B526E602F910A@qq.com>
X-QQ-XMAILINFO: N26DAMVpW7UEELg1dy+GMZD+00lIRCqP/w497FA+m7In7SmTs+b53VTThxdjI4
	 RYqD4F4eFb/r9PUFAyWv3As47O7DN7unXY1sD4AJlpmPmX6Afm5/JF9B14XCRxO5LSJjGw62opqN
	 b4t7TfwwpSGivC0CVvNlnbNpPs5DWTR7Sr8CDVe61qj3Gv07tAAq4yaFZk55zvaiGt1zLKSJM7xX
	 cZcssu2UuTxPTUgu9IjJKzpUh8cnZbz6N3v/MLk2qdThxkkJOAVOAkFrcDlBVzU91QgNYfosUpzR
	 BSKGOyj/fwdhW2jsz/49M/I6TPVDa8IVaBOQi6QyESxPf/pBoX6ZqE462G4Aj53rxhk1gkEjklbi
	 6SXwTcOBH7RVu8F25JHvYPZJJV5gqcz5XFHdwP7LWU++0qvca9+VTW1JaUYxBfPpkt1jm0+wJ4Jx
	 6KK3aZgnVFousOAJC3pm9A9dGvy0Ue+FtjHGWM/Wbf/99+Jc6iYzFZV5AoQph1Kpf+ElMjOPNkDM
	 9ur6moGs3uPmSI7zCO55DU+MjrKRFdDzjTddbB9Eiz5PuAGK3G6clEzeQdCIEGSEkuogHEcCe3/x
	 OchmIzRhPZSTh8jgwN/9+uCpzmkodeB25W+uT/j9VaV9FcfVjKCNwCeztyMkPvGSExFGLxbcbqTg
	 VSUruY3cQkhtk7Ki89NMD/sOkgHg5LDgTBZicnaUh1Ohfew1BNGU6VorM9nlBm+p0sb/02iANA0T
	 oBU4AhBBK8b/r7Kt+Yexu0bnXehFGQwjl+WYDDZURioh5zwLYC3AmtvqCy3l1b4kUM/M2p46wLhQ
	 oatPC7SVyfZyR8B2t0zszzGDq5ihQ54nvwHCNyEU8ZbKFHfVtdj8Lr5toVfBnOXyyx5TfrZ+9tHJ
	 c6QNuSAURs0XBA/nMXZhB/fQPHYWXUKGV4+TWTpU5IKtYaVSbBTZwUlpLU3zZUuw==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in bch2_sb_clean_to_text
Date: Tue,  7 May 2024 10:13:02 +0800
X-OQ-MSGID: <20240507021301.2217091-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000918c290617b914ba@google.com>
References: <000000000000918c290617b914ba@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test oob in bch2_sb_clean_to_text

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5eb4573ea63d

diff --git a/fs/bcachefs/sb-clean.c b/fs/bcachefs/sb-clean.c
index 5980ba2563fe..02101687853e 100644
--- a/fs/bcachefs/sb-clean.c
+++ b/fs/bcachefs/sb-clean.c
@@ -285,7 +285,7 @@ static void bch2_sb_clean_to_text(struct printbuf *out, struct bch_sb *sb,
 	prt_newline(out);
 
 	for (entry = clean->start;
-	     entry != vstruct_end(&clean->field);
+	     entry < vstruct_end(&clean->field);
 	     entry = vstruct_next(entry)) {
 		if (entry->type == BCH_JSET_ENTRY_btree_keys &&
 		    !entry->u64s)


