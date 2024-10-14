Return-Path: <linux-kernel+bounces-364021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E500299C9FF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DEB51F23006
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C5C19E7F7;
	Mon, 14 Oct 2024 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jfUo5Jbg"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CE0156F3F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908584; cv=none; b=h/9tVNk++CiXHIBxEj5HTnepTE4JlrWVk3t+b/vYpL63QOZrOLwzrXJ/ymdakgeTN7xhDrkf2liq7ot/cxaf3tdohW/lGEk27k9K8LbcQXkUX4cvQW+FU5GwS7LOLKi5RXhprH3kfemC0LSN4WpeOxrHc4HL5sT2247BPov1oAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908584; c=relaxed/simple;
	bh=/t+NgTaA1O61+C6GOXGVB3E7nwGJQe2W1TYCLhCGnH4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ZxmtE+KX/EjwgZ7Z4dC4E0nTnH/WSCiAzB/Wx/l+Rb7ybGm7eRDuWLsptn/Oej54sIUYxt/ZS5yfuApm1Y+yhDVyJ7NLxmX5iJ4PH6dEaRovB/PiCdYVgGhgV/zek5vOHtl8lODmXWCtJrT4sNbOIsjHOoebzBA/+ygq7Wy1L9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jfUo5Jbg; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728908576; bh=4HCykBH28vledngsFUmD4YXkYerFdTE4qgvqgqxi7rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jfUo5Jbg5veFS99J8XqZfl3NL0WQgOi0AwqJj9+hxUD0WHgvubnBMCfzWewXxxmI2
	 F/MONebXRm08omychRWt5szquSWFODK2Tv99Pziyl6l5D0QiSK+PJeOZ/j94/CK3/q
	 gT+8b/HfkDA7BPeggF8eld46OPk+kGP2p/2KScfM=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 425A6A9D; Mon, 14 Oct 2024 20:16:37 +0800
X-QQ-mid: xmsmtpt1728908197tdz7iw01b
Message-ID: <tencent_52D2C2064D49A96EDAEECB8C93A7C486C906@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9EjBHd0TTbrm1+xYycH76X0HNjKDgqNQ0LRu0Y/SnxSrCy2/NMQ
	 r0TGgE/ADXODk/BAt6kCBh1StYOnPTi7rjaQiJAQ9+vw6uvxLyVuMNP5+txXCUtbqd160JuLdpEC
	 k4x7eE1WjZuNP0h9t8Pzm3A1ouWMKFcAYgztPcmItfUfMdKfY6+nALvXUkGVIqjQ/iSCy/TOb5aj
	 88pQMrDzUAaYDGZ75Ew7HPGTd1kqihFGOH13+rwg3dZU6rWlUB+GzYbgAj7ANfmhP/Ku6+OQLPB4
	 0vRJh76U4RAIoxl7dlpfSSJRQm0XL4k0hh1K02pgESLaTWBXOZ3ce9bjRvgDxelIOQcv+JJ6Ht1d
	 Qoi6k4wW7CUtXpS/s3FecjiB48rBKgGyl41Z2xAb+XOibU8SqulbDxC4HdI+tTW9ACZAP0YR29U+
	 7woqbxl27H0HPdTd21mXvb+XPCjiVNB4CIXT6WE8KWDidlFTMEjAZqpx/dVudbQ8z0In48UUlWU0
	 2ucJLU3Sd62iUvHFTLliBorT6ZALY2+668d9gqliKqQQE+7RTflMOEjE8/vSQ/e9gxvJaxWq0o6L
	 ERgeGV3myGI2W9hOLemHOO3Y5kVyfIiqTKRcQ/t2dzmjgOPb7FX04Nl1BnOFHTxuDqRieyFMp05Q
	 eb151k9TXOn/l3A09I1w0an8Fyw+SUar+Mn/0C5tV0q+P7HTZsg2bF+ig5l4XXJeM6ZXNk08SQGm
	 88pNgbC0wbB7986ZgLNjR6o/VSSbEe6ADOSE/ZF72GP/O3MYl8H7FqcpkaU78itf/0JitXgicXo8
	 vq20fljUQG7uaRyb6pErP7EJPGMradqZcAdC8MMurFvAjFgmdCKLLR4I7Je7GUeTtcDvPHc25pOt
	 4dRhX9me67qFuU8iMmuR9Blpf7KLzq3nkYyIL2C8BwlrR/t7nAHgKakUdXXifVVux3VK6kWMKkLC
	 4LojNhLuPLoXUlTyt5vTv5jRMbUEOxuTAtsr/4StmSt+iANaMyoQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: lkp@intel.com
Cc: almaz.alexandrovich@paragon-software.com,
	eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	ntfs3@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	syzbot+e37dd1dfc814b10caa55@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V2] ntfs3: Fix WARNING in ntfs_extend_initialized_size
Date: Mon, 14 Oct 2024 20:16:38 +0800
X-OQ-MSGID: <20241014121637.3511987-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <202410101748.6VtnyCOG-lkp@intel.com>
References: <202410101748.6VtnyCOG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a WARNING in ntfs_extend_initialized_size.
The data type of in->i_valid and to is u64 in ntfs_file_mmap().
If their values are greater than LLONG_MAX, overflow will occur because
the data types of the parameters valid and new_valid corresponding to
the function ntfs_extend_initialized_size() are loff_t.

Before calling ntfs_extend_initialized_size() in the ntfs_file_mmap(),
the "ni->i_valid < to" has been determined, so the same WARN_ON determination
is not required in ntfs_extend_initialized_size(). 
Just execute the ntfs_extend_initialized_size() in ntfs_extend() to make
a WARN_ON check.

Reported-and-tested-by: syzbot+e37dd1dfc814b10caa55@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e37dd1dfc814b10caa55
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V1 -> V2: typo for ni->i_valid

 fs/ntfs3/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 6202895a4542..c42454a62314 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -178,7 +178,6 @@ static int ntfs_extend_initialized_size(struct file *file,
 	}
 
 	WARN_ON(is_compressed(ni));
-	WARN_ON(valid >= new_valid);
 
 	for (;;) {
 		u32 zerofrom, len;
@@ -400,6 +399,7 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
 	}
 
 	if (extend_init && !is_compressed(ni)) {
+		WARN_ON(ni->i_valid >= pos);
 		err = ntfs_extend_initialized_size(file, ni, ni->i_valid, pos);
 		if (err)
 			goto out;
-- 
2.43.0



