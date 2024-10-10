Return-Path: <linux-kernel+bounces-359342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3575998A65
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6585D28273D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0441CDFB9;
	Thu, 10 Oct 2024 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nDnmi5fU"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A12F1CBE83
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571082; cv=none; b=Tfx/HYmgIPKq3bOVtCwYZPnYe6Erjfr6z+QmUS/N4t8DPXWylK8w6i1IoNETEeoGYSV0pnqDpQm3MPIn9zg9369o/dqNZvjNLlDQy4hyb80G0VPjNzLT3nBSqFPHB6byji/z0slURJj/aysSLsReFmnMaFCPmMxfVDHIMO4c0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571082; c=relaxed/simple;
	bh=mH4Be2yJhgiF2i9P9P38P9r2ucKw71C/Rsz/G5M/iFY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=oBqOCXKpNtUrjB0Q1VYErpFmSxGwRvZOL0VzRcbid1dhVj4R0zxFCqzlxjlgRTV41PoWwtZ5VdTozWKGGO2eIjS+104mWTsqBzgRrS5KDTMs4tXmkb9O7jVwhtfnZ+u4cVxo+Hmdcky3CRzTcQ4dY4DUpSu00NLW0yA9iKF5auY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=nDnmi5fU; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728570771; bh=qYbaBkOzlRAS7/XGImNK8GZXuIWeWJrro2hRvz7Tce4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nDnmi5fUIboAXXLoY+prjxacw302FYuxHrdXR/ckqLaCrTt8TQLwRY7so1QusKlFv
	 sYpVeXGi7BM6/japDl2PI8/DUYsRRshmkLZJqGN72nMUl/Q/L/WiD0AFQ5zssVeInw
	 FB7nMulDlvdJnOAvkjIiNjMm3J89s7rwOtCXvFws=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszgpua4-0.qq.com (NewEsmtp) with SMTP
	id 8319C4DB; Thu, 10 Oct 2024 22:32:49 +0800
X-QQ-mid: xmsmtpt1728570769tsem68f2b
Message-ID: <tencent_31E392D2C64C4983AEF8EED04C8CA7C8C606@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jEDksENgzSbQI9313YbtOjwXvQuA1NtHtSiDrQnopFIPPBdWhG3
	 pivKKTovXe3/M8r6+vDfVXEtx6Gla2jDuPH5Gtb5Iak3iV5cP8885/F23E7Rh17b8Y/zpoGeIVqE
	 cd5EBVz4DkFLQuZ4cBSDWzd/sV4EEWPQPta1Mxq8LcEKLbimN+4KozQteSkbw49X7LBTKo5KVdrr
	 JhbqQzwk0JhmBxNz+LTtMvQfSJnpxaiObogwC7gcVcFZg9OHLv+B12y8r7hqUeUxZvZN3MDACTLq
	 tcm/Lg62fYpPEoMBol8ZFjut+Dgv4P7fKiHK8CJb21mTqgAh3A1z1Ge0a7w+ebndEFD1r2q42IEd
	 LHdiBJMUClQvJ5KFsYGf1lcfIjI4zw0SxqyVcHARkzxvzHL7h6lloNMOgKYCj7JAhZQjyJFe0U+B
	 4S+IlCdATWtBjmLpFmUQmrG5JWXYI/cIaVpgoC23AHdhZpBiS3ywzXn7OjDQ+xejx8hrIoQoOeX7
	 3lphbU6U59iDWMZQzvAkdWHWcLr14K3voJ8AbBDOHcgA2PAtfdq4qrc8vgNmZ23vLAmtj6OYWpCl
	 t1gqxoS4c9Ihy87UPloNB8QMrBPrC46AtUq5RZxCBOskdt0sLe01Q12oBgr/1xGK125eG/G2wQX7
	 JPA8iDYg8KI6bwFGEBANSy1gDn69V73/ZwC2boBOaw4UOiQEdYpc2cUzInFWpJ6deW/4MXkpuakS
	 yeCafiNHICBZ0I4+3WJGst7w2AL9qi1OZCAxkTU13oWpUQU91/L0FLqUUD0o6UVCgaR+cdHPwMGb
	 SKq0p1Of4qi0yEAsOp1fFVn/NskbrND0MCDPj4emeF57CdeP5+ESJe3clSVHPi0+xqB5u9A4by+9
	 CGemwQegiIrvdsNdRlL5/AAX3L6fyE20Nl79DnTKqyWAt+c+AgP7j3+zCFiXlbLVGyR7W1KiRzgm
	 LJKzveLiw=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [ocfs2?] kernel BUG in ocfs2_truncate_inline
Date: Thu, 10 Oct 2024 22:32:50 +0800
X-OQ-MSGID: <20241010143249.1814347-2-eadavis@qq.com>
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

offset or offset + len greater than UINT_MAX, if true, it will overflow in ocfs2_truncate_inline

#syz test

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


