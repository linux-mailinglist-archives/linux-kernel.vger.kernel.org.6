Return-Path: <linux-kernel+bounces-397680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2BB9BDEF4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF73A1C215AA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E136192D6B;
	Wed,  6 Nov 2024 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="MXoHcu3W"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B93824A3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730875235; cv=none; b=bonZ4+EX8J1DObWwyPYRGM5/oPMrOndaLIoEYHk8i+J16xQSFFRH/OcZJZ0w46akyDgciWluX9Uoo28UbWGV3vBwqcu8i3GXEi4X90asbIZxadChONREOY9W1MfcrjsVUXxKKYi/yV5BWF1y+mWbPG2671z+pHHrKBv0WE0DktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730875235; c=relaxed/simple;
	bh=rz9S3ScpICYzE+0PGpF+JEkPkOVUE3qh6SphvrTPkIs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=oat2cUR15Hpd4Qvm+F5Q3ZvLsf9LMCOW+nRPzVZ8NoVNNVN53S29iCfc+jKdLyD/PH+g/EdaIjWAjfwx2ZtUXcHAulQlV9Uws9MC2CGEBXgsRZCvOMfXluL9taUEAH49Cdd3ZA6PgEoAVy1xDkHvIfmcvRKb6SmGA6UPOWDfe3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=MXoHcu3W; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730875212; bh=aYZep8nd9xbQMiAZljVVU/z/rQgJ00os6jqqil7+Yug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MXoHcu3WOzEp+e6FyztDbXdqBAUOHivW7s/NvQi66giIkp75MFmmkzShsDb3LSAoP
	 S8hgCkJXoiXo4VuwreHDiTuwnREWgF3aI0dfVyn2UrqMHW7Obyu6JBe7Oc/p+XyyyS
	 psdHiBd5TrFHeOIojPMbaz8u5TyaFm98AZ3zsryQ=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 7EF9B233; Wed, 06 Nov 2024 14:31:47 +0800
X-QQ-mid: xmsmtpt1730874707tvf178do1
Message-ID: <tencent_536FC3A5A458D765576F66CF736AC3616905@qq.com>
X-QQ-XMAILINFO: OGZxhFXqN7PJO9fwN0NmcXGeuJ6O3N/FXdmxc249bYjKYvjMH5z93ggepz2Htz
	 qHg5NSL+x3P+MD/lsfms1hqIc32hyQVe+TRptdicGOpDUx3iopa7665QbOpBN7lCw4D9sTWxYQgd
	 9Eh8oS/D5ECRHYUzVPzA9CvJDkdDpRFWGo9fD79twTSDdyKUydUrjU/ajvp8jC2h1P3w8nEiifke
	 X++Kn0Fzn2WH25WHBRJVyhgsgYJ40MzNQ3g9GZJUTv/p3SsVSn0Xvy1v+8TAmhh+Qph39uMQkwae
	 hX4NC/Su19yoROhVvvfMBQsZHTD2YYlMLMK3EZjqM0TZ0mZhRlSZzoSSuOloU6DH7Bu3EndxqVuu
	 67nwdgzgY7/F2FBX6tQjKYbRF538KN+A42yP9X+BCgetzJmcCT0IAn5psMLPC5pXVZz6rjLHb8uf
	 Cnl3KfzF/qz0WyouJzyhIU0IkCr8MZ3p7gPAhpfNj7+UA+UVEXLoBhvf+jSYQNcKFDjc11qPtniD
	 JWOAtFpPxSkNZjhmFwhUCZwZQD7pFEfOfjMsrlI8p55JprigIVu3OXkDlJLSkrX2EMrBx+k/FePz
	 0jMvA2SMdjk/yiclLZEGZr6YD61Dk2JcUxIaRbcmtbuMrXdhV/L8sKRlpLapEsrIqTSbpPQuiSkx
	 Q2Wf6bBgfedO5ZKh14gseWk+xj75UaVz+JFBuTCjjkNh7CANDCKmWXCdQvuyF7BbpaPDWRdjA7DM
	 8RpJf7PQ2Mk+Z3cBF9XBSNfFpxgiZDjDH9oVFLmrQSWKt1Pq+6/K4l3UpvRz1FFegA4wyQiRUJ02
	 0Etj7DjbOFokE3nvX4pKm542+xBn29tlZn7fuXlsngsyJQwGrKhBL3Y3WPRdTwEkXtYcUYzRD6cK
	 Gq0OLAMaBQDK6I/2sUtLaxr4WuKh8NqazcvvjqCFHc
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+968ecf5dc01b3e0148ec@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_cat_bin_cmp_key
Date: Wed,  6 Nov 2024 14:31:48 +0800
X-OQ-MSGID: <20241106063147.2500734-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <672af85a.050a0220.2edce.151c.GAE@google.com>
References: <672af85a.050a0220.2edce.151c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnode's record key length is smaller than 8?

#syz test

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 901e83d65d20..70deb143e518 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -116,7 +116,8 @@ int __hfs_brec_find(struct hfs_bnode *bnode, struct hfs_find_data *fd,
 		rec = (e + b) / 2;
 		len = hfs_brec_lenoff(bnode, rec, &off);
 		keylen = hfs_brec_keylen(bnode, rec);
-		if (keylen == 0) {
+		printk("keylen: %u, off: %u, key: %p, %s\n", keylen, off, fd->key, __func__);
+		if (keylen < 8) {
 			res = -EINVAL;
 			goto fail;
 		}


