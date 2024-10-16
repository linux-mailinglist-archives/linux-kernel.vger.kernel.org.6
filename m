Return-Path: <linux-kernel+bounces-367178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3716A99FF83
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1501F25487
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E44187332;
	Wed, 16 Oct 2024 03:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="S1p1dXun"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB99185B7B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 03:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729049394; cv=none; b=tyhhKIkkKnKYSJZwnWDdi/KuHuJEC+1x2Lwxi2SSmI/kH9oxXJZHF6E75rQK8qujjLbcQOkNvtX4fWftW8o4HH6oR1ECA1AWPmP9X9mYB8SmJ1oCmVKaneqrnibSM0lbpvdLMg7lc6BiGESUmPmtFTpAbO8EozVpeSQGPJCwDAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729049394; c=relaxed/simple;
	bh=jJJYDFIKRwXx5LDAm+Odp6cq0PMJh7HVTjbTq/g5bew=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=HoiB+APLfEWviCfXgH5Pb+jtdBa9tIHFEf5Add7dEUXJwbi/yt5aw9Zg9GwqowgEbfkqZkngAIgl7Vxd1PgNgY2ht1nuT+WODkKz1GvZ6aA6lwX/xlKW9zhTXqwLaKRRKQ4auOqNHPwiOMFTMgWGp7Aw/ahTgX43ZzvgXRsIIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=S1p1dXun; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1729049389; bh=Fo3oaTqWXD0i6gTB0n0hXf6PcFYh9T56B+wMkIEHb/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S1p1dXunHEBQcGnJl0eXHpC2N6XJqiFaBNC1qlGneCqWzvP05DVdw4SfFOPs/FMKb
	 ozoLyz+cQ9kHnwT/VrCImXazOqufeD54A42zoH+afEUOIu5tPKlm7bABkKDhcmkRQA
	 xUZItcBLqmB8tnqsb3Cn8hSr1RQJbGCKAqDl0+Ww=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 7702183B; Wed, 16 Oct 2024 11:29:48 +0800
X-QQ-mid: xmsmtpt1729049388t6bnkrhcr
Message-ID: <tencent_696EDEEECD8C8067C286EC12EB4651899506@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70bRn5JPUnCZuv6ykz1KWEDuExxZfoZ6yHFizJVyAORduWJ4lo/6
	 4JTGmstY4QYugocnst+loL13DMzToXPxuUbV9tr8ORXh4q6t6jVvWq/5JpeCYpyRnAlttGwEu6q2
	 NQhPzo3KAMP4YS2mYSmlG7sIiRqGPr+n5n7Hlsb4bE4lJY/GEiH40r+e7c+qzbSPMAKF9xFEPQ54
	 7BARLXhXmjpsVwUNHosQOn6/+Ln04uN9J/YF7T+mihwDujZlBnJhNLnZypA0ithkIkCz4SDN6byJ
	 iCiQdqRdv/d3qUDzhcAyLaQO3ilX3+8e/KYv+b+Z1OShZ6RptStiYy+ZeKe4GiSq+gYg1wGPGxla
	 UCDMIVVEXhqq2ehhmM9F8B/qjvCcBvJ4wkGAG689dr0eiTyVI4TyKfFmrGeLvh8q99vgNmGPC/co
	 JFgitkDEQl4aX5vfE6+1YAZnY2G9B9gayBsUkoXcabso3zdyLuGYQdy7J4XjCNgvfe51/xjfIFwp
	 2W0XRhrwv/+6HyPpZdMIO3dQaWghCld8tsM+seiqYJPbXFGbwQzmP9Xwr3ubBGD0Of/Tgap5HlVg
	 +e032ZLEIC1BRMqmoJa+Pr/EOJx/x73cftGqaVofjuoIcJ9GaWP1Lj/uMmZDXHVA7KBzzd3Oaake
	 6Ldomue14FXN8ckOMW//seq4NCfDN9E+ev7MCm7Fnwb2t1RWJmIyalwaK9AC+DMgNJIN0jMI/WdA
	 CVPgh3/ROmDtJG79GBZw7zs7TPABfKKYraQjpCehr4++qPTmvWuDLFodfZfrHfFM9DgYGzvx6YNH
	 dDVtGYs26PrXDTnFfSj9OifDjG94M4F8WIMnkiQlaDjAgT4VXFbzN6Hh0Oze2TppuVaroKgZVxIm
	 sMRNcCCnlVUGs5wBQvsCRrvZ+YvzU+EF7+pNnqD9GHOVz2YyRt85EQXgUy9pDF3pXoxKzOOm5ia/
	 rQDjxRpL9KQGkG+k9jzA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [ocfs2?] kernel BUG in ocfs2_truncate_inline
Date: Wed, 16 Oct 2024 11:29:48 +0800
X-OQ-MSGID: <20241016032947.434083-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <67062030.050a0220.3f80e.0024.GAE@google.com>
References: <67062030.050a0220.3f80e.0024.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

offset or offset + len greater than inline data max size, if true, it will
overflow in ocfs2_truncate_inline.

#syz test

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index ad131a2fc58e..9327aa2f1bf4 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1784,6 +1784,12 @@ int ocfs2_remove_inode_range(struct inode *inode,
 		return 0;
 
 	if (OCFS2_I(inode)->ip_dyn_features & OCFS2_INLINE_DATA_FL) {
+		int max_inl = ocfs2_max_inline_data_with_xattr(inode->i_sb, di);
+		if (byte_start > max_inl || byte_start + byte_len > max_inl) {
+			ret = -EFBIG;
+			mlog_errno(ret);
+			goto out;
+		}
 		ret = ocfs2_truncate_inline(inode, di_bh, byte_start,
 					    byte_start + byte_len, 0);
 		if (ret) {


