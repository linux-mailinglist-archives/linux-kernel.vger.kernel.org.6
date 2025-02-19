Return-Path: <linux-kernel+bounces-522685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9976AA3CD48
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA8116E14B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0729214A7C;
	Wed, 19 Feb 2025 23:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="sOhnvKkv"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FD71DE4D0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007104; cv=none; b=f5GSSJI74fEjZ85FhA66IHEjVBTLWYL0XKkZlAjj8g3vdO/ZCPkYLswjIp1jWB3duZ7OQPYw+LOmsyuhwq25WGvU6lRAfCBGJ0PchpMmcVBfYTHS298JVWsVaWHcFPlJD3xK70qrNDK2A2Z/KrdiyWJjNIElMa8cN8k5DCGFhxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007104; c=relaxed/simple;
	bh=4IpTPQ5TXOtbKQMBzrWbzJwZmlxwtbHaHeYdoo9kmSc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=RO792HlttNmO2s0SjJJ0e21IUKuat3hU1HNfRU/B9fzO9sMiIQkeAA31/ZSIn4G2sa2YJj+T0a/ixDznRdVS35TCqxdorjNKQE0A0bDNAVDd7/O1iHBweKEf4NWHKPqquzD5Q0XPGo4ZDnOV+mMnIm+X/buDrkq7tGuF7NwohsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=sOhnvKkv; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1740006793; bh=MJUOyjdZuMzoAjYbJxeN7aB/+BN+k6oUQOA42HZaNVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sOhnvKkv/9wx57mrYxl35ik1ToVnc2ewZwWT0Rxaz/z9zp7KjCWxGcCWItsCWjv5d
	 ERtHhQb522HR3u+n1caI6LZh4QrLkINd0UW2Xl+fHn7bOyln1XeizMo35zPUkvo/Ca
	 CdxgnAx5VPm2NY3/rcegg/4Zqs5BjRnNXyeFDJpc=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 34C05CB2; Thu, 20 Feb 2025 07:13:12 +0800
X-QQ-mid: xmsmtpt1740006792tuqonxyca
Message-ID: <tencent_14375A4BEC7483764966023C0136D4968209@qq.com>
X-QQ-XMAILINFO: OJV4F5WcWfWaUa7PU7ZBC1YgAsNB3z51RdUGfs6cH3s+9/pbk0bsab+GhKh/eU
	 XjC/vug9jDFYfGIzY9gsp02iL6D1z70he9uOuj07YvTwDt4/KCHXWo/UAFxxriHjJhslNcfkRbXA
	 WSqXm9ykuJzTB0VzVMaJSI6LCSEPYD8t5bspt8DRiiVqj1QqY5gsDcS/PZz6NZzGCMNemMG8FdFj
	 widLoW0Hj/15Sbg5wxrcWW59/r64wuW158U9YdZ3+g6qxLjsloo9Im5kS2Mfa6Lt49SashXa8X2o
	 3xpGdAQJZdf16cH4QAMfS4oTz69ib/RzMyzH1+H8cpiv0QxFZ9lzjzbeQNLM+Jo0gxhS+kmYGMDN
	 DQ+jccmcM18eWzQ5qY6wGUCsiqNfgyi0rSGBxQyhhJNs3QNwDSjdLbSilzTMlIqBlGOQWVB61lQN
	 W8gFlO6q3wB6i3aQsW3DDoPXItBqsQ9qEIWxdH8DRMsr1B7q4JOS2aUeoB4MgEV6usdh8ecFMrFc
	 y4V1Or0trthQpl+saDL7ZyRFWRq/OJuC5DGR5aj3VjE9M6Oyi/sYWgR+ew8fGQ2K8ldU5aY9leke
	 MGehSbvVsqBx52+KFN99K1EkefHfxgat1kQETSVlW/nXX/6etCvzPXrgY1C0dBxWlXCT1Zl2e18l
	 XXDJrxXUtokO95EUJeiNMvFspNSbsVLl0zjw4wn3G4EEcoPWZgSOWWR3q/2Q28OwaZRs2wa3lASF
	 iglHg7yoOmsFhnYUBOdGy3UmzBs4lb5rhuC31Zql6hjZDIO/kj9CWSDXg7Q9f2O7pYSdM3bBuLlo
	 pd9tTP5AKCvknZg3ynu0Efkv+1nhYIA9jwn0b9Rai/TXmn1WasTBPEOIgRWtiMVL6yJUcrFjwvPh
	 YwR15ONaSqmKaR8v99q4cc5ExheUyWT4pXQme3XRopzZ9DMUk0DTA=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+df6cdcb35904203d2b6d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] KMSAN: uninit-value in diFree
Date: Thu, 20 Feb 2025 07:13:11 +0800
X-OQ-MSGID: <20250219231310.1651557-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67b5d07e.050a0220.14d86d.00e6.GAE@google.com>
References: <67b5d07e.050a0220.14d86d.00e6.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index a360b24ed320..0cedaccb7218 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -134,6 +134,10 @@ int diMount(struct inode *ipimap)
 		imap->im_agctl[index].numfree =
 		    le32_to_cpu(dinom_le->in_agctl[index].numfree);
 	}
+	imap->im_diskblock = 0;
+	imap->im_maxag = 0;
+	imap->im_enuminos = 0;
+	imap->im_enumfree = 0;
 
 	/* release the buffer. */
 	release_metapage(mp);
diff --git a/fs/jfs/jfs_imap.h b/fs/jfs/jfs_imap.h
index dd7409febe28..9af1da2e4591 100644
--- a/fs/jfs/jfs_imap.h
+++ b/fs/jfs/jfs_imap.h
@@ -144,6 +144,8 @@ struct inomap {
  */
 #define	im_diskblock	im_imap.in_diskblock
 #define	im_maxag	im_imap.in_maxag
+#define	im_enuminos	im_imap.in_numinos
+#define	im_enumfree	im_imap.in_numfree
 
 extern int diFree(struct inode *);
 extern int diAlloc(struct inode *, bool, struct inode *);
-- 
2.43.0


