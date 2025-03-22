Return-Path: <linux-kernel+bounces-572263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30DEA6C862
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 09:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641DD3BAAAB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 08:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030581D7E37;
	Sat, 22 Mar 2025 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fJ+jkRci"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0FC22612
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742633010; cv=none; b=Dx370Cp8LC8tS9D3B0h5VubIlLjmlS3UofE6/UWgHW7T86NX4UjAyeSrwqqlaJxEXbo6v9oKOBYk1jhO1o1XJOIzSN1hjaWbxNYtylVGu6wzr7Y5S63/ELXTZB/NEey46COgAPYpCQe7e/CR+NUNh6578CXvi7MlNRmWHH/l5Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742633010; c=relaxed/simple;
	bh=79q86sP47+TMIn/uTfCtYiovB97H76IMWYtEB91sf2s=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YY2eZhR/Sh79MD5dyd3zlu3G+WySZlbjsdG1BR0jwVFSIss0eSxIamKi/DNYkb7DcwrGyW7IqoBagE0blBmqNYeZSocZrjO5vUAIPrfBTRhdElIOaoOJk9ijPxxBlzadKQ9C6o83EBGWj/ADjPgpgF+mmVGEGsbVlmw07u05fO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fJ+jkRci; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742633000; bh=ffcFwV994HQStTPFaMJwa1Yx3W96Xv9TQasgZeexpx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fJ+jkRcib6MSiAhauee5rNud4Y5h9RCOi7wPS5wNYYl3zzfNUSYCYEaGLw9KdTAPj
	 NiHEwXQGJk3elLLHpICv/1ELvdbGQONEa7ZfjfAwLgly8M5zKB8jrQ6uQsQonlS2ZW
	 rrnnaBWywK/sA2bIJsb9SqaH2PFAqKNjdzbmmZAg=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc11-0.qq.com (NewEsmtp) with SMTP
	id A7ABACFD; Sat, 22 Mar 2025 16:41:58 +0800
X-QQ-mid: xmsmtpt1742632918tp4zxp4g9
Message-ID: <tencent_FFC5C6E792E24668C997EEDB6ED34CA52706@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmaueLbjxtaREgkqd+Kf1xYZIuXKOhdwsrA/tFdRVCT6cRzxg4IIS
	 oKJcgVT8AomRohBiVMtIRmuUk8utL7mD5lN+5h6ZZYHxSNHKHpS2pa6qZGwizC+nsom/et6wHGS5
	 CFZb+h/VSp+NKyfm4m1kiAgTHQVGsJC935JyqOhvYFIp5EquzVpebTrHyzE/3y5lT54VRQ091FpG
	 omsE03TFjNIvz3sxcIeRr+0OD64heR+nRDb98jeb0B7dxnFDGAHiVThT4KpF6gPTNBoFOESNdkP9
	 b+ASbubp/w8Fsxn+tmUFDbekk43tsg6NNaDyTaE0/HnKtdsMrbYS0vqXXdIPjOgl907q3hrVkhu7
	 iAralRBzSsjJXHJf/6bw8fEw9wV4+ihW/pLjFPbtCWWemQPWhF6mraxg8MbACbM4Sn7DuPwhETfJ
	 WkcBdtYxa4swUgiwAR9J07vYMYlfCieO3xaDVS0mxVoX67Mf88m6KogQ5moDhKJsdGfD92u9eE9+
	 TAxczPv8ouQkLLIOwwa6tEyC9e9VCBhLb7Z4t9H2UwCwtqQsiYQSpsvL2NGDr+xEVBkrrDWxKLt2
	 Cn1xkGYO3KhN8ukPNKY/53acwHSsbcoPjzcsqlgc0uX1yn2dEEmA+Xma/Y28BFclzM58H1T0x+KX
	 QK8kuR3qjiltmCp30hDZt/4VOhYzRnOahnIzGKxotQcNx/6rq9SU/mSd6KqEr118WcyGfw/SOQb4
	 CHVp5lYsQAGFK2N3zSlPcXhOccMp3Fig+EAVpQ3zbtSw9hxOW16HZf17l/GhEDI/XN8A9edukc/A
	 66BiradKkAK9oZvx5By4Uw9OfnOfvSaAlezy+blflSw1wVBKe+sC+sqDRnjpl1GIKMXEPbzmDI39
	 PaUAWq1G8LIgHFJADXB4gaIzUAEry57Ljsf9YgEJda
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
Date: Sat, 22 Mar 2025 16:41:59 +0800
X-OQ-MSGID: <20250322084158.394153-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <67ddd191.050a0220.25ae54.006a.GAE@google.com>
References: <67ddd191.050a0220.25ae54.006a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 2956d888c131..03a66d75be8b 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -307,6 +307,9 @@ static int ocfs2_add_recovery_chunk(struct super_block *sb,
 		kfree(rc);
 		return -ENOMEM;
 	}
+	printk("ents: %u, sb: %p, chunk: %d, blksize: %lu, rcb: %p, inited size: %d, %s\n",
+               ol_chunk_entries(sb), sb, chunk, sb->s_blocksize, rc->rc_bitmap,
+               (ol_chunk_entries(sb) + 7) >> 3, __func__);
 	memcpy(rc->rc_bitmap, dchunk->dqc_bitmap,
 	       (ol_chunk_entries(sb) + 7) >> 3);
 	list_add_tail(&rc->rc_list, head);
@@ -485,6 +488,8 @@ static int ocfs2_recover_local_quota_file(struct inode *lqinode,
 			break;
 		}
 		dchunk = (struct ocfs2_local_disk_chunk *)hbh->b_data;
+		printk("ents: %u, sb: %p, chunk: %d, blksize: %lu, rcb: %p, offset: %d, %s\n",
+                       ol_chunk_entries(sb), sb, chunk, sb->s_blocksize, rchunk->rc_bitmap, bit, __func__);
 		for_each_set_bit(bit, rchunk->rc_bitmap, ol_chunk_entries(sb)) {
 			qbh = NULL;
 			status = ocfs2_read_quota_block(lqinode,


