Return-Path: <linux-kernel+bounces-359339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CBC998A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19361289F51
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145BE1EABB2;
	Thu, 10 Oct 2024 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JX4wU7yW"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD811CCEFA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571016; cv=none; b=kmqnt9zDtd5MEUOay0ZeYCAuXPS3LZpe2CsvlRhnbzZQ4G/I77PCUxaNbyNnY1CDpuIcWjRzFSU0tvPxnMlKNVO7afndwHn+BJhX6tWC9ups9o27qH0XKxwIfz41tZOwBZu929d1b0csl1P65GcMUydOb9zJmpjPzYN7mqtO8Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571016; c=relaxed/simple;
	bh=txlyT3GHoAhZkaFW4SYoPs4Bvp+H3a0QYp57uQlCREs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hcv4iy2YgmT77wB0inx9kZtx0Z/kZI0HgJCRxLggd9I4GWIZChprMU743ke1CsR+K8Pbl5YoZddc2jt3lU4yJtftw8Or+R5zaeWW68FXarXphkGLblRzqN5xFZFygtTpoWKCdv0Xhjts0a8qpfStMT0DaRje0w6oPOhGKZs9ass=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JX4wU7yW; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728570708; bh=g0y/cEOvnaqK6OOd1oFB/hUbOfbURM/ZcWSW/KxXpvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JX4wU7yWlV0BfZfDECWxfj4+RKY7GLszwx5MhOxhmLNAu7Ts2H9xqqxkgHiadoe84
	 Y/D2EHmMI+JHM13D8e+g82J29uKPZjJc3fMmaJtfAThPkYXZL9KaOROqOK4OV5IPHR
	 alXJZu1lPAmBZJwP+Yayx0jtybuqZh/b2rrf9QXE=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 7ED860CF; Thu, 10 Oct 2024 22:31:45 +0800
X-QQ-mid: xmsmtpt1728570705t7wzq2o6a
Message-ID: <tencent_91D2962236324AA47465761367183C8F3709@qq.com>
X-QQ-XMAILINFO: N5sfBKY/oC4k1aCS0+w/FKbM/g539tKAPAp1pzDCW7cNRk1gJ5T5/NoSbo298J
	 b61glLPeDkxttenA7ychwnWxw9YzkpiMKqSeDglTKJ2yR6zvEgs/eyfdeMaR0oRbtEf2VALsNkiO
	 SVyT7x3GFIQa/hWjBNZ3DhzBz6R+DLym1oMqv6gQYZMjw1xIg8SRLUAQmPXx9y+ip5hqYGYj95Sr
	 aChXXgGF82DEIJZRi18CXv+cpkOkhGe7oMaxPMaWdhQvrak6m7NzW0xA6cwkbGBQUt7gaz33C8jc
	 FU5QQW1MQnsq0yV6ozLRXNm91dT0emdpBUynSknXQfodlBEQbyUBAcmN9CtG4nQ1B+l132dFzsTD
	 rm1vyREUaPAsAcAl74fsTBWxuvUcxWcaEBmqtSr6tXYftDW9iVbORH1Ryi/SjqNZYfyvlIEB6Cfz
	 E4Q40VNd2MAeddbKed3Ggv/b027YWv28mQC5mdjarZt70/i0KtBzSExzbXmD20+vOs6V3divj+oA
	 qDnOLH4iQw8WEqKHRNwLV4oCoMFMBbO4uwPKsFh4oVaIIh/qrvRXxror7ZWI3wULCR+P9oKmHxbC
	 R9YuFeaamCyxrhzbTRdoJ66wKehTnCtCrFdnSlj1RGJbRbYK4b/RgCtT9cNLvBienF4bJrAyjmml
	 e3AlR9m4fCMDUq7l6t3vis+7Xbwu16AZCBTMi8rHCjPY7JfkInsdquj1BivuEVgGPJmYxNVh9kG3
	 flDCVqRF/jTDKV54uHwG8tE559ffAcefUoKMBLPzff1BGAa/TcycZxuPUnespysBNSc1+JNYVhrP
	 IdpMiPZkYUptgusOXYhZ+CfKGhmghfZlf6Mw5phNmIT/V5DDlVh6l+KS0mDFwbgYYo8PY7WGmGvG
	 idZxiz1Vyx+317QTLVC0txMvL/+At04ck6Q2I5rLl5nxDb365npMUPYa/cJr+s24evfZbai7xAEP
	 RXxFyMiiCZeR15nIbtNQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: joseph.qi@linux.alibaba.com
Cc: eadavis@qq.com,
	jlbec@evilplan.org,
	linux-kernel@vger.kernel.org,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev,
	syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V2] ocfs2: pass u64 to ocfs2_truncate_inline maybe overflow
Date: Thu, 10 Oct 2024 22:31:46 +0800
X-OQ-MSGID: <20241010143145.1813560-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <4195446e-2d2b-442c-a1ad-b1498d243a70@linux.alibaba.com>
References: <4195446e-2d2b-442c-a1ad-b1498d243a70@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a kernel BUG in ocfs2_truncate_inline.
There are two reasons for this: first, the parameter value passed is greater
than UINT_MAX, second, the start and end parameters of ocfs2_truncate_inline
are "unsigned int".

So, we need to add a sanity check for byte_start and byte_len right before
ocfs2_truncate_inline() in ocfs2_remove_inode_range(), if they are greater
than UINT_MAX return -EFBIG.

Reported-by: syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=81092778aac03460d6b7
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V1 -> V2: move sanity check to ocfs2_remove_inode_range

 fs/ocfs2/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index ad131a2fc58e..05d6a8acfcda 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1784,6 +1784,11 @@ int ocfs2_remove_inode_range(struct inode *inode,
 		return 0;
 
 	if (OCFS2_I(inode)->ip_dyn_features & OCFS2_INLINE_DATA_FL) {
+		if (byte_start > UINT_MAX || byte_start + byte_len > UINT_MAX) {
+			ret = -EFBIG;
+			mlog_errno(ret);
+			goto out;
+		}
 		ret = ocfs2_truncate_inline(inode, di_bh, byte_start,
 					    byte_start + byte_len, 0);
 		if (ret) {
-- 
2.43.0


