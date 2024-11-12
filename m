Return-Path: <linux-kernel+bounces-405337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7759C502B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3F47B2BEF4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F235920B80B;
	Tue, 12 Nov 2024 07:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="EW0hYoyp"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A3E20A5FB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731397953; cv=none; b=IW0DWzeWVHs4EK+aW613op99Zd+Q+60nBD1qH9mCvNGZbBam1WwxMa5aCXQGfMeGzyVLUVfPuGrKaf35ufX6a31AkfFSjI4gOW2hvhT6D6U+v53bBSy0UAjOh/24YbX8XJfyOUo37brEvnEnBUnwK1X1M1NmVMuLikdddTW1Sfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731397953; c=relaxed/simple;
	bh=z3WR9KzI7l5LiqVtZYynfLAHz/kXtDppxOFH3VB4fnU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pr2J3iFZr5lyAIAV8ScddE2MA6vJE9ZwL5bcbFnJhEOVt7HtFdPKAmpRYJ5Qk5ZlEjxx+yNyDQmrotqtsPSnI0a8ZfER27LHVW8NLS00aLpsknhTzPrBs3xmCDHDToHf8KOtuuqIMWbSk/y/9snSOUHQfM0m1j7IENLE2W/u208=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=EW0hYoyp; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1731397944; bh=2vbR2/qcNnaF1ZIMH82U9pMzO8VYgoI0AFu2rqp3jJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EW0hYoyp/Rn6FR0Rq5dnclYj2oN0YJthSpXNS0cL7cmtC0vRp7k4WLVdV3rxBsHJn
	 hsNJppFf7phAtssB2VF8p9ARugBwILtPbuK0XXgodS5npk6aRpc/E/L+APGmcIFGAi
	 YqsDKPKyalOQ3Bv3j8mjymOPTpvFxISux9t6gLrY=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id D16B5029; Tue, 12 Nov 2024 15:52:22 +0800
X-QQ-mid: xmsmtpt1731397942ti9d34800
Message-ID: <tencent_5074A97043AAA456F764576E46C7137EC305@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeG6JtRWKoTqnQvC876yRiKSgnzyFOKMTkU0i55F5F48sIgrlrpX
	 qv2gQV1UuafmyV98312Dqic4aN4i639etxn7saR2KhQI8H7r0BIv/HWW4Mr4sci9epMxH6zLMUzT
	 drCNNrsK/tDeq7ZhXcIedR33ZdJ0f0MVEDIjQCP9LBl80h0t1FqqzSK/lb1zqQSMLcRhFMctZuDi
	 ZQjgpayAS90JVLTFqh9vkcZcFxz+HUFoKzdj8s6bPynfrRlojw6xLfO6YZYjM9vasj4awzjff1y6
	 88otZqeEPPvJXpeQB2F0/Wv2J3JrhyL95exZfmbFxvT9X1nXw0K3qbefFCZBqpV/WqOi30V5lgmZ
	 CVPQ1aw219QjL22z8/uM+Tt8o0NOWDNfB/T8r79LapHQ9IlUTWaenSYVyaI1vfL1NluboJL8DvAB
	 bqb/8Ns/L3hXY0hTAhVSIRJ5ToB1uqMbh4J9pGT0wvvf6AW+FEMwwzD4wI+M40nph8DTSHCPrjAR
	 IupKss4YzZGb69tDTBgIZyNTKDZYGBkELAQy6kY8odj/JrpkcC5JZkqJ3X97pURtLTgQeC/NbCPE
	 r+aJEZAroF+U8PLrLJMdOQGshPY668FvS6b3Rix/DW1wrCXmUFe1R/LlsF1obrZfy2ffd+/AS2o1
	 GJxNuIm6T/J9Un3yqI5kLcg/AA4LC7hGZOpk6bjZXBpLvsNij/KPVEuUBu5LYEf/4hF4NHcXgTrY
	 ZXZyti4nOsjWpuHL6AEvdqmzav1rXWsrxeUMrmJwnWwvmsbS7n0J8xddYldHA+Hw+3lXhMd/2+SO
	 7yngWiBdz7s51gOLIgX86efi9AJcaiN+ZSsBQabCqiyLxGmosUuZpIUgxgQiEFEZmPXN+W/PcDiQ
	 mwt48v40fPMD/4X1PLno54J1kaXCjVaQRmAlB43lzB
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+96d5d14c47d97015c624@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] KASAN: use-after-free Read in nilfs_find_entry
Date: Tue, 12 Nov 2024 15:52:23 +0800
X-OQ-MSGID: <20241112075222.1365869-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <6732e1d8.050a0220.138bd5.00d3.GAE@google.com>
References: <6732e1d8.050a0220.138bd5.00d3.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

next de space is not enough

#syz test

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index a8602729586a..09a24c81dc7d 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -317,7 +317,7 @@ struct nilfs_dir_entry *nilfs_find_entry(struct inode *dir,
 
 		de = (struct nilfs_dir_entry *)kaddr;
 		kaddr += nilfs_last_byte(dir, n) - reclen;
-		while ((char *)de <= kaddr) {
+		while ((char *)de + sizeof(*de) <= kaddr) {
 			if (de->rec_len == 0) {
 				nilfs_error(dir->i_sb,
 					    "zero-length directory entry");


