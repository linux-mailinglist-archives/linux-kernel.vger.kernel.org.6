Return-Path: <linux-kernel+bounces-512091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF5CA333EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48C916753F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3C01CF8B;
	Thu, 13 Feb 2025 00:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRql5tcK"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89BE4A29
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406048; cv=none; b=hQ4rFHjurJOFash/LMSQwZViVfN8MV53EBWCV0PP9s4lloevEx6fwUU8I50sgtjIFbK/fyURjoMQcBmCd0OIXC/adZzs5IoUwlTtorkaP2P3fgO/dcwAof9qpiRIyLwyl5t2iVx2MnyqbBic3PEWu7FbCexQbMZS+3rpxbeM31g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406048; c=relaxed/simple;
	bh=QiyX/b7o6aoVr7+FLINVljRVt+/cZ0yqMI8VVVXXSbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HqIjh9sf095hJ8VZXc35bCq6rsU+e00gRbpgek7d11k2CrnzyvyFaXmWx68nlpWCPmIwKcvpDoQsogSAu0iHCB2tsDPasyK+jhyg05fmRCsPEWrrwranHL569oV49iO5p/KJ4gwoU45spRyNn8LLkUaICl/ZdKmPlT5+HuZE7GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRql5tcK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4395561ab71so3102405e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739406045; x=1740010845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X84lYtUnaPKcu+sxp9VlxXdEt5jePr1I7AgWIclWzJo=;
        b=CRql5tcKi81tgFBCK3mK+7Q1ZpwqpftD06KMwUx+0h44WeP/M27NvFO4jHDqiX1NXl
         GwvC/pxOh+k/dHHMIkvdGrRm+3bgPDSPkt1h05Jh8whNmVmCLAgajyhSYPoI+vWCqr6c
         kCFbj2+cZKwCKEYZdN7PIvEPxWmFK2J44RO6emhDYZaawBGREq5/LjZNJ7g834zgXrTP
         3DVkfm/Zn9gP+CE61NJC+seN6anpvWtY4a55PA3/aRmK6ocixEqtgbiXdkydsxX/VsbO
         s5gGiDqMsU7inA1MhQY7WCHdlAp03jxMNaahhNi6a4z8oKW3ur+GQxuWTtW60LR2cwyj
         PNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739406045; x=1740010845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X84lYtUnaPKcu+sxp9VlxXdEt5jePr1I7AgWIclWzJo=;
        b=DU59elUWJjekeozxDGWeTAaIL/9xqerwcMWIbY1kHJtSnS3dWTtzt7rU4+cj2sgbC6
         Fu7gJ8IofGCoLeKxi8QnOXNPNIWbztEwj0SuX6mGu4dnFeyIMV8mlF6VQ2bla+CYJMvD
         aSCHsXG8NzQ4H8T0uYlNb4VTw+hgODSqGNnYdKDC2tWSfGRgRVNb+Uf8WREv/SrKFHyx
         watvLeG0ih5AQKHjAYkfd52J+uqJ8XYQFHbCCATcK9rOo/m/xGLYP9Ws/u6eCxDV13Lv
         Xyid/3qfkuq03EF6zIL3nfUQ4v3AY9S21/V4KSs0N4oq9n2hf1VtZ8vTz1GXoPrO38t1
         FrIg==
X-Forwarded-Encrypted: i=1; AJvYcCVhGvy7wdn/oSQk1k9AlC1N5Xe30iHtrxgcjyDo1lwmTCtur1j6bD+EvuIXEqutDjTC5DYZuvXHbXImxOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI6lA5ehEQ1niV4SmEUgsMZoT9rWvEJxKP+4pku5BB6fziFj3p
	hCsIWq6hHZsPOXP3+bE+962ODsU91Zp0UAiggfqPX6vtCHN/cLWL
X-Gm-Gg: ASbGncuEmzyq1zmxRlATBTqXzT/HFSRKby3wItRu6JaOpWv1xi1MsVchBsGjq8/EmOO
	HWAPF3QwBoy05X3tZFlg2XiZyw9aPGE1x2Qi3QfP8yeHrBBauRZ6WjZNQZhwOSYWl6pAZuqxmCs
	dDCAM0sFPkvjubxALb6enI4RR1gGPm/9sjY6l4CgGWh/KZHk4mW+7ce6LT7ZiqNBMVcPOG3uUwr
	7vG25Js344WOWkfJ/aC8AIJngzADMLPrfr82SMA5drb3WmKq6MR/HcJdeukvJxgvs/s1eCqxtyA
	DkFEHzpbzXcdKjXg
X-Google-Smtp-Source: AGHT+IF9zrFLHKVKmPSx9KGxXSoCk0hMnf8jkpOryo17zak+fTnqo0TeSRGwZkokpw4GpxYL4MZ87g==
X-Received: by 2002:a5d:588a:0:b0:38f:2073:14a7 with SMTP id ffacd0b85a97d-38f24526be2mr1294596f8f.47.1739406044857;
        Wed, 12 Feb 2025 16:20:44 -0800 (PST)
Received: from qasdev.Home ([2a02:c7c:6696:8300:a5eb:311f:6a00:dedb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f2591570esm332014f8f.59.2025.02.12.16.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:20:43 -0800 (PST)
From: Qasim Ijaz <qasdev00@gmail.com>
To: shaggy@kernel.org,
	zhaomengmeng@kylinos.cn,
	llfamsec@gmail.com,
	gregkh@linuxfoundation.org,
	ancowi69@gmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot <syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com>
Subject: [PATCH] jfs: fix slab-out-of-bounds read in ea_get()
Date: Thu, 13 Feb 2025 00:20:25 +0000
Message-Id: <20250213002025.6602-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the "size_check" label in ea_get(), the code checks if the extended 
attribute list (xattr) size matches ea_size. If not, it logs 
"ea_get: invalid extended attribute" and calls print_hex_dump().

Here, EALIST_SIZE(ea_buf->xattr) returns 4110417968, which exceeds 
INT_MAX (2,147,483,647). Then ea_size is clamped:

	int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));

Although clamp_t aims to bound ea_size between 0 and 4110417968, the upper 
limit is treated as an int, causing an overflow above 2^31 - 1. This leads 
"size" to wrap around and become negative (-184549328).

The "size" is then passed to print_hex_dump() (called "len" in 
print_hex_dump()), it is passed as type size_t (an unsigned 
type), this is then stored inside a variable called 
"int remaining", which is then assigned to "int linelen" which 
is then passed to hex_dump_to_buffer(). In print_hex_dump() 
the for loop, iterates through 0 to len-1, where len is 
18446744073525002176, calling hex_dump_to_buffer() 
on each iteration:

	for (i = 0; i < len; i += rowsize) {
		linelen = min(remaining, rowsize);
		remaining -= rowsize;

		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
				   linebuf, sizeof(linebuf), ascii);
	
		...
	}
	
The expected stopping condition (i < len) is effectively broken 
since len is corrupted and very large. This eventually leads to 
the "ptr+i" being passed to hex_dump_to_buffer() to get closer 
to the end of the actual bounds of "ptr", eventually an out of 
bounds access is done in hex_dump_to_buffer() in the following 
for loop:

	for (j = 0; j < len; j++) {
			if (linebuflen < lx + 2)
				goto overflow2;
			ch = ptr[j];
		...
	}

To fix this we should validate "EALIST_SIZE(ea_buf->xattr)" 
before it is utilised.

Reported-by: syzbot <syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com>
Tested-by: syzbot <syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=4e6e7e4279d046613bc5
Fixes: d9f9d96136cb ("jfs: xattr: check invalid xattr size more strictly")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 fs/jfs/xattr.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 24afbae87225..7575c51cce9b 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -559,11 +555,16 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
 
       size_check:
 	if (EALIST_SIZE(ea_buf->xattr) != ea_size) {
-		int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
-
-		printk(KERN_ERR "ea_get: invalid extended attribute\n");
-		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
-				     ea_buf->xattr, size, 1);
+		if (unlikely(EALIST_SIZE(ea_buf->xattr) > INT_MAX)) {
+			printk(KERN_ERR "ea_get: extended attribute size too large: %u > INT_MAX\n",
+			       EALIST_SIZE(ea_buf->xattr));
+		} else {
+			int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
+
+			printk(KERN_ERR "ea_get: invalid extended attribute\n");
+			print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
+				       ea_buf->xattr, size, 1);
+		}
 		ea_release(inode, ea_buf);
 		rc = -EIO;
 		goto clean_up;
-- 
2.39.5


