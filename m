Return-Path: <linux-kernel+bounces-405211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAC09C4E65
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6040282C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223AB208960;
	Tue, 12 Nov 2024 05:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="p7hFymDo"
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233721C303A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 05:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731390313; cv=none; b=IDnRuU+ABB5y7s3oTdBDYJ74J15F/Lx9RHkmL51uF1pvzfcOFP18xcdgn7Kwwl7gS9pEWTmlIHdiJVA3ty5CZJjgo1fIYVeayDcw+eK2pZjpdmp5Deq7DjjEh5OuTZYDV5N4Nol3/0/nSoKPzssK7lKQst0DPVa4EkguYelZGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731390313; c=relaxed/simple;
	bh=lMYx1wI5yAftJ1VX/M7hyaGnYeT03ICbkFk/0Q/zBMw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=TJ+0eOgs3qBGyJzifzREw01fVtxRNgIO9rXDP/4N6gATU2VgB35cfPrdvrTf4a+h93L9lHMuxaWSl00TAmmuNu4iF5BF8G9KEITqxTg3giFrEIkYvtJPkHIZfds9VemyP+Qb6ofNSNxLo1DAKiNPtnjEKCYR/eoatIMevu44WHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=p7hFymDo; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1731390301; bh=HfP1gRhEftvbZKlcQgm6x38nsY7fLBNPxMS2muoUTrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=p7hFymDomUzGng/p0i5+D1ro/KqXXzDvzE9wud3FazSKp0FhONL5/6s1nNXQGo2O3
	 Oc2PTjCpsOGqMXrDZj2n37RG6JzHO64tG1GdVjHT7b/bEYriEhy9AFLilIZwBM3idM
	 Y9vDmDHYfGgYykJq0p8fcDoprsqv8DivEe2lnRN4=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 9B3A985F; Tue, 12 Nov 2024 13:38:51 +0800
X-QQ-mid: xmsmtpt1731389931trf9u9kew
Message-ID: <tencent_202369496E43BB4449F766177026C5536F05@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAj8gq92irCC25XUuMf0U/zcYR1o8ZHFHFV3E4kGVM1DmU65i8ld7
	 sc0YmXdu670XVg3LPL1oVcmJfM7GBoshwKqoPct5yyoSrizpchCx5JMrWc35lZ9gC4V9k/OsZElC
	 w1ox8DRQzkVRDHeZFNtEYotChu/n+hYeehEaaviCv3XuJv8Hk2FMzXNEtQaJORS6/NPbqzuxFnJb
	 4XyqtPYWgZJbS8SSdEQxF036x+CJnCjsX17In9Mv5mCSbWBQjwRaXMZT7OPcf3dxXVmiKZUVoe9e
	 O4dXh9BMFIu6nQwn/K0Ox+KPfnEIOHC6ZBpWz1vJ4Wzi2QvWJ/MA6TqoZdo6Fz+G/yYXNx1j+Unx
	 q6eT6ESuNPcwNpuraDgF3MTeoyEr2qCoN5tc03qzzCDDOYMOLhREWJ1DJTksZDNo2WeLyD1BHeHD
	 0l1rdDbE+H8kQC+Zm5+B0Kgp0T6KD2//050PEc1gp1PbgOb5CtiiIG0f6KzmC+wNyMhfIQBX8zl4
	 fmAfHXXRIPa4cpid8MkNn6j/+kmpiar0nYcA/2aIWdeslhpmByoff3Sc3DvPFjnlW9w1/f7ICwVR
	 wJynwnOv0vt4mCA3FVpEPZ2uprsq1Ca2/fuYAZMTA1KJZGemOjMNTo4F5RKueSKMOff4yRp1uMH+
	 UwhdfUnBo1Uk9c3mcfdddbhJ4WEdX04TbPbASt29w/JWq7PRH+lKBHyZl7rO/hK5pAfEQ8vRKqYW
	 mjSLToO9Oxx1JQtfTdnew83IM/bdYNeIEsQakGSr2Ntyavwe2fSjf1dtVlLpfm1XxcKRicNJMM4U
	 iJLLGsfZwivmVyINMsEOlYep8KWUBiRWqmlmfS5Fpk4MJ2uNKjYmdj048C5QJIPkmTPVpbO0i6zZ
	 swYf2hHln9STQSjp1nwNZ72qyGn1ezTqDjgo5KRDj/
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+4cba2fd444e9a16ae758@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] possible deadlock in hfsplus_file_extend (2)
Date: Tue, 12 Nov 2024 13:38:52 +0800
X-OQ-MSGID: <20241112053851.1239918-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <6731ef89.050a0220.a83d0.0013.GAE@google.com>
References: <6731ef89.050a0220.a83d0.0013.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AA lock, unlock for hfs_bmap_reserve.

#syz test

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index a6d61685ae79..90366e2da3c7 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -101,7 +101,12 @@ static int __hfsplus_ext_write_extent(struct inode *inode,
 		if (res != -ENOENT)
 			return res;
 		/* Fail early and avoid ENOSPC during the btree operation */
+		mutex_unlock(&hip->extents_lock);
+		mutex_unlock(&fd->tree->tree_lock);
 		res = hfs_bmap_reserve(fd->tree, fd->tree->depth + 1);
+		mutex_lock(&hip->extents_lock);
+		mutex_lock_nested(&fd->tree->tree_lock,
+			hfsplus_btree_lock_class(fd->tree));
 		if (res)
 			return res;
 		hfs_brec_insert(fd, hip->cached_extents,


