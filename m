Return-Path: <linux-kernel+bounces-572719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7318DA6CDBB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 03:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881523B5B43
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 02:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323061FC109;
	Sun, 23 Mar 2025 02:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AJTEY9I2"
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C5C381A3
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742697402; cv=none; b=nhapQdkwn9l0VRGHHwkPb4saeS7OPi2+YSOeUmyY7zSQ3b6mzhwQLDMHoN6PhZmtbev70Smc8BifbXC+2L26g/Lh7a8v9ALg9t/G8XrvtUd8VA9jSQDqrCgszSW4itmGVPTdGMMyzrf9Xw4TsiZlBksrq2i+C6ULomFC9yXanYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742697402; c=relaxed/simple;
	bh=CCBuRYeQmuK2kKjAQACg8oLm9t6QC3JNMaL4gO2m9IQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Zy22s82OF6pP1j5bKwVHnQYRNOXM324e7F0hpaHuoZRPs/fmdp7TW6tgaDIrqvfpawswF2Rn7l0MhuN3cbk6UaffGOqr8+dRA9ZrKIMZ8ePcl6p1c+noX6COVVbcFkL91PrJfp/JUTbfoA+nIk4WMDkN/+tXaUmRzsaXLn50YdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=AJTEY9I2; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742697385; bh=FcxMdPiYLxUkQQiGmAgNYuquyDpmYNSzcPsl7DqRlSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AJTEY9I2wU7xVvIeVBsA1lWQqR9kf36Gdkg418FzimLUnlQNHWSDs28ZPxsv17Rmm
	 dRj5H15oSVZ8z0y2hUWTuRxkAo5JYldbz97mimV3qff5CNMIHQcMqihin7NZpxflYO
	 wi2AMfETeljDnK5BMWCbL74ET4kn0zWnj3FLK2gA=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc11-0.qq.com (NewEsmtp) with SMTP
	id 9180FAA8; Sun, 23 Mar 2025 10:36:24 +0800
X-QQ-mid: xmsmtpt1742697384tuxx3i4x7
Message-ID: <tencent_4D4C8BE7C706C952C2066109A76EFE2ED406@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmaueLbjxtaREgrBvW4l7ojx08CVA+cAtr6bhiVmeJJpoYqOuUYPH
	 QPFDO33RCmH9FlSUGr/FNXXlRZ+KJi4xdhX+7r0w+jue/4T70OeBYiyRuMdlmIhKCuLUzD/XESox
	 CMOAy/N9Gb5/S1zsKzlZXNIvr+rtBrrbCZzCLPvhIfGhLOFC5DQHvm2EPB848Yw7EUweKUwVuFXA
	 bPxr9cFyT8UzLARSO1QzjjaI+ye2JoyIfMkdeuKh5iw+P+h8Bepn4yonmFiutQ6PmKIrqI3KguLO
	 MUDlOJTSCwpyZ1clEmcLCsc/66OB8LD0OMLONoqcNBXWVfahy+9OAevWnzHw0iOmc/STz28gTpx7
	 c5+WT6tNd1wPPid3nUML+Czr8j2SnAul19ZxPkCvIprjfhkKAhelGeXqFUTV+xKB+5csutmfJ/vD
	 U74l/BgQnLbvblA/Frcg71n73wLbbPY0BT8f2sYCOEx3wcnR0aXgEZn8O+cxV3yEzjuIq3qIbxqM
	 N/Q1aZ8/q3TJuS0NQfcui+geyVQ49nwedeAmOuHHI+NSc034fGV/mwncpUOo4fQewSgNEQT6xhdx
	 d1dXAWJ/4FIrwOWAc+EcFzHA4Zu89ZD5C4s3Kxmd8WpKEWTWDYLmfZaBXSEnIvq0Kwb9GgO+O/xM
	 p55BlSF59vWfMzQfXpUaMn2gozKqE23VvuSmuLyVBldSsctl04gUmyeLGLLwZQd3fwVWrj8pEYaV
	 dJ4ALsqQyIWTlXHBkrvCl/w2qo/yIjowHBaM5sYNU+36Ef4zGd5TwWaqveFQ2aHBLnHqopUts8Vf
	 ADUQu4DbpCH3zYP+CBBNuAcnOKKcTdbYCZNTAnP8EC2tEbXop6ik+z72jyU+Zc/I3DQLPfohrxjj
	 wV3kfUpA98RrF2x0dmo5oPLX/MDvSNmg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
Date: Sun, 23 Mar 2025 10:36:24 +0800
X-OQ-MSGID: <20250323023623.836224-2-eadavis@qq.com>
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
index 2956d888c131..0543362d7d9f 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -307,6 +307,11 @@ static int ocfs2_add_recovery_chunk(struct super_block *sb,
 		kfree(rc);
 		return -ENOMEM;
 	}
+	printk("ents: %u, sb: %p, chunk: %d, blksize: %lu, rcb: %p, inited size: %d, %s\n",
+               ol_chunk_entries(sb), sb, chunk, sb->s_blocksize, rc->rc_bitmap,
+               (ol_chunk_entries(sb) + 7) >> 3, __func__);
+	ocfs2_test_bit_unaligned(ol_chunk_entries(sb), dchunk->dqc_bitmap);
+	printk("?warn here: %d, %s\n", ocfs2_test_bit_unaligned(ol_chunk_entries(sb), dchunk->dqc_bitmap), __func__);
 	memcpy(rc->rc_bitmap, dchunk->dqc_bitmap,
 	       (ol_chunk_entries(sb) + 7) >> 3);
 	list_add_tail(&rc->rc_list, head);


