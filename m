Return-Path: <linux-kernel+bounces-198182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 734F68D749D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 11:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10EA2B21199
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5339229CFB;
	Sun,  2 Jun 2024 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IbovmvmQ"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA20374EA
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717320894; cv=none; b=OdHUlq2t6qhM8QwGV9cbKYUBqFYomY9AysDbLntkbyoGxJDRQFKiSTWhILri3T3BIqkL0mAVD3TivdDUycbmCQR5n5EnHwpgCm6XpCmP6OVEYY+BdCfmHYAjYEwiFK91yvlrZLRbV+dPVhVjI/cmopdDeNP2YlbhuWvk2SnKZMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717320894; c=relaxed/simple;
	bh=DG07kVu5uLEH6rCgib444jqlM+vqDCQhpyzL5KaG49A=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=aNXVTnrNfdzLZTqQv3e7xaFu8IyOvhhBU7CM9rvY4rfXbxNUDSrqDMzAIqbedhs3Hy2VriuSR5UdP8l5Rx0IaqtwCI7vrAZAEJcASudM3ICMToR3Bvbnx6wnhEL0/KLP/9g/KP/F+bExF3qJmdxztbhBacDnAu0R1rfMudzQ3Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IbovmvmQ; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1717320880; bh=1eR/ssQy8r6gHuYs6EKlYygeauTKQA7qHnuWA58hTXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IbovmvmQ26KIsyr/hvym0GhvKK7giLtcq2e1HS69PEWtjlVENH2lo8T1a2+ZzgRhP
	 qNgQHYEI8Y44FOZMU2FJs6jzKHAzm+M4vnZ7rTMiAS7kQX06YO7EC/ZTqtEPucKcGT
	 jaaeikoskX4x0SDCvUXDrKzZQ3iLKt5v0jkgQLFw=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 5943AE37; Sun, 02 Jun 2024 17:22:20 +0800
X-QQ-mid: xmsmtpt1717320140taqnx0a2i
Message-ID: <tencent_D0FA12FAC65F09B4AEC6AED04C8C67C38606@qq.com>
X-QQ-XMAILINFO: MgAERLP4sJkUfzd64tplZ5GwFRzfCv0BJcRDVT8fxbNsZuZQqDOCRiYgepdP2G
	 JLl66RoogXXcA3ZnsbvX23tSk2w4nqhuLIkJuq4rbvDXo7UcapWemHti0VP7Li231iOqzCiyy0te
	 E+3liaTV6KWTG5NPtgb1d7dwSt2p7AruImFi7G3rH/SGkp2CyQkoHj3zvum6r4IXPHueF8SAKzoA
	 As0HlGIESubZH/jbvyoPc6SSLCpH/GLm9EXAe7XyTCxShutNjabubqfkyFDmM5VhUVNcpaEBm3r/
	 8bqHDLcy8orwyCglbYKx/MRx1LtD0RzhDFRSbJi6LEttWmH+WAghepz1nZjjUTpV0V6m303t0YCp
	 qgqmjyGPqryRlm2x/ciAZtd/uUbPZry+LweB1lCotC0DfZ+JYTFG2b1+7Z4P9KZMGxkYqNKdzlxN
	 u7EgrjR4fiTYRCViA+BMo79yZFKfREp8VJS1i4FwQZkl2pVD1OkJ2D7DpaIk82KNrWBz4lly1PYy
	 22z9wkBdHxJ22NO1VLexl69uOm6hZppljdYTfuVsBOj+M2LDx81j1xIUXUxy6ee+LZ2wbHR0VBVC
	 9O3SI2DX2M/Y3sjB6uMIbVSNdDF0NlkYmYpUctmN1d7YeGN8hd9Y/bu7MEXnGo5MGFJL6g1PiGcZ
	 /eINv/K8xERpEwVwdVtk1q3VtcA2mbPEu5xFqg4FuZmHY0RJNJal1vLKSDrcWUvQwFcZPmNkCT3S
	 aH1GJ2WnsIJ7BRVFXBovRAY0LLxPd2JpGVt7X0LhWZmrdM75xelLl+zip/jhsUNKRLnwuiIa1rpX
	 1W6MRqbv72RG1QfDjvZV64fCPivBLc4ftauR1yzBaTwOefs9aekxWtr0VcgLRoh1cdbEMR8Ra0/b
	 5dDVAcuWcEa68GSkIB9sDw8kBXxGTPCwF58Dr4WmQi5WJtpvCm4/SvJ4M+AjzA9F7JEMLG6sVgKB
	 QWoUWGW34=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
Date: Sun,  2 Jun 2024 17:22:21 +0800
X-OQ-MSGID: <20240602092220.1495349-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000f386f90616fea5ef@google.com>
References: <000000000000f386f90616fea5ef@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uaf chrdev_open

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e33c4963bf53

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 084d19d78397..293c37171d97 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -93,7 +93,7 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 	 * If the MFT record of ntfs inode is not a base record, inode->i_op can be NULL.
 	 * This causes null pointer dereference in d_splice_alias().
 	 */
-	if (!IS_ERR_OR_NULL(inode) && !inode->i_op) {
+	if (IS_ERR_OR_NULL(inode) || !inode->i_op) {
 		iput(inode);
 		inode = ERR_PTR(-EINVAL);
 	}


