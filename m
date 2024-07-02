Return-Path: <linux-kernel+bounces-237992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DCD9241D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD112816D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3561BB6BE;
	Tue,  2 Jul 2024 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UeSaeYie"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75281DFFC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932568; cv=none; b=VaLNSDx15lNovV9bsrqnBN5D+FsZwLxVLt22WvVK7UrlBuTaR7m09IvngDt4iMpkjUNoG2d93Sxf/8CKM6CZKQjmfUC2vfEKC/G1/YaRyz+e15TY0YmJoLxrzcgDuR6b/h+2qgDFZP0iewE+TREFc0cYkXgG9HwAtID7HnVfvNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932568; c=relaxed/simple;
	bh=fr9y7zaKBJWd5Nq+J5D0Htxix9ZN96bhg/tbL+wNefI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=VP9VBeyjjHoVfE8lSsTmwWBaO5e8KoUr2nDYJAGZCv5WxJLdJAOYLYXpdD8KCWd94VbGevAE8bn4Ft/9YbbtXVUUurJo5JOAjif+LOuY4owpABb2MnUJ6fzrxI+FTYCS+bCZvKwY7OlQRnFUQdaPCAumU54+/80YLcAsDPOiWmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UeSaeYie; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719932555; bh=O4ypknQaGzJdIqqc9/A2hiRqkd8JeZFBfl4wuZsE6Iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UeSaeYie1uHsW1tzw0PdBLQ/QQU+pdgtSCh31BbgoB4mKfq3A9K4Hcy10b7t1JGiB
	 KqcarFZroGl/VOuDtTYSZZasrFBGbgKa81v2RTy3d1pm1PkE7ZSBmgG0txds2LEv7S
	 O6NVQFcGIwZS8jH/CexI1ILA/31LcbF88F9QsFt8=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id DC89D2F9; Tue, 02 Jul 2024 22:55:08 +0800
X-QQ-mid: xmsmtpt1719932108t83bauouw
Message-ID: <tencent_922C096E68955CEA7AED66CC3079766DA40A@qq.com>
X-QQ-XMAILINFO: OP9Dqbc7TEr/t0FY5px6FxuBcMpGgxXlQF7VfRv7WXFFx5Akdi7cP85s7ZjtU9
	 Pt2iospx3YBnLiSxhU5S2W8eDBJQKZF87hW4oPWEjUw4ccIFEVm8Bpg9N+EYmNdK4p43lPNJhOtF
	 U4APEOrX/dy4H/D5FBzkOW/vHQ83y/mcyDK2emTN98VqXA1QcQb5KYinyioGdWPrJ91fqoMcFB8U
	 JK58FM1045u2FoQ+/VyPzcXIRKl7w10xJ8wHerpCvZvja21cghnhuhRr7QX1/mD+hHrYuJa2oEWT
	 MC85/JmpZkEPhpVasIn6+h0L+IL+Ffzak2cSiIai7QLiRZz0b1obdk63s5SgGA3xSndALJR6X1Cg
	 UdnMXetTPmhGRviYjMCjwy0UomaHyYXpdXQFt7XMcYS5gNZPil0yHvpaIMHc0K5WKk1qSSnjn7RL
	 BQBc33O8XvSdaC18aFwvn2QVPopgy116fPaJ4DCIWd1/3XhO/QSZWTeXN7YbQSoQkBLo+WFVkna8
	 /kPTtwzVCK3KekjTvqZtXfe6WOokqwP1EqcVBANVZxwmoR57S3m4tyi+mLb9yqEInpvgeha4/IgZ
	 f+2TdR6xsDNQ9JfpvHqp+H/AlWnM0KLMPpgkZnsfoOeLsLUa0xP8C16SkKyDl3ED7lt8pt1oFBzV
	 +faQ+0TxzgNetgRjAS3Vc6bLaHZVd4ripQfgelPLtionOHGkKjO2vQrDKY7uQ+GmBwG7tsNUi8NP
	 fpBvMrgcGCgtIjVvrQom5Ns4Wn+nhnffQG2MlPTmKb1j7dlUGoDJUKVJzquz2X6LuKXEPom4CPRg
	 mF7HGvubGcza/C8raw5mH0GLvI84GT2icB+hutxdMFhTP8m6cC4U0o8oaKpTMc+NR0sMxfwTFn4Z
	 R+8U4FyeHamomp8X39rokayttWNxFMtFWcD3jcKW6ORihB8f2bzVtli7UtaXRyOCf1epBy2P2jRk
	 IcDOkDyMg=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+4fd66a69358fc15ae2ad@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in nf_tables_trans_destroy_work
Date: Tue,  2 Jul 2024 22:55:09 +0800
X-OQ-MSGID: <20240702145508.3938445-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000aa1dbb061c354fe6@google.com>
References: <000000000000aa1dbb061c354fe6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unbalanced increase and decrease of use in the table

#syz test: net-next 1c5fc27bc48a

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 70d0bad029fd..33139e1b6d46 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1498,6 +1498,7 @@ static int nf_tables_newtable(struct sk_buff *skb, const struct nfnl_info *info,
 	if (err < 0)
 		goto err_trans;
 
+	nft_use_inc_restore(&table->use);
 	list_add_tail_rcu(&table->list, &nft_net->tables);
 	return 0;
 err_trans:
@@ -9529,6 +9530,9 @@ static void nft_commit_release(struct nft_trans *trans)
 
 	nft_ctx_update(&ctx, trans);
 
+	if (trans->table)
+		nft_use_dec(&trans->table->use);
+
 	switch (trans->msg_type) {
 	case NFT_MSG_DELTABLE:
 	case NFT_MSG_DESTROYTABLE:


