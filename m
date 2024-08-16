Return-Path: <linux-kernel+bounces-289054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD07795419E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC64283E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DA38063C;
	Fri, 16 Aug 2024 06:18:42 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA3340875
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723789121; cv=none; b=Gw18QfNH/A0xc1X0K1UuIFwt+dcWMFxdjLASjMcHUAY1IO7BDD+Lf4nFVz7A/0tXTFMkHWjSQCrosk5saNM9IYUCGfuV5OFaRrkAqsk2rnS8aIHksNJWbZasr4b4zVg3awLjvq/gPJE9xuwo+Oz6JVuI+n8y9TuDMSy3890iiAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723789121; c=relaxed/simple;
	bh=4PnhomWjvHjmfhLok4Pw+fzpwpONCTTj8kay929zFTs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ry0D/txCio6FAOknTY2xHLtd4VttiYdhqjcqwP0qT+LBVbvsGfK+uJIkDHP//3iWRAAPh9Mz+SvkJIDR93gqqUkIevtcIaukR5ttLV1Duy7RKN6edDeN9BEF+RE2Duqo6+nkMymaLRtAxzGj2axMoWpEjhMoflzvqFMtEwSmUqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8223aed78e2so182954939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723789119; x=1724393919;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkIxNx9ZL4GvKOcAjOtXGpvDrGo/l62k1FZPfL8X3sg=;
        b=Up5h0rWUtQ0439RvzhLaCIGJ3pJw61At9WFbJ6I3avSYuTX+oUh7LaTxnQukG1ozk5
         n4SFQLyTjnL2PvlgGYN+bwx60wSlvqHvk6qp+88/cgFCcKXQmBVRL7+/T6B4i99lVmI7
         KDzmphPx+hBTIa8BJAryo68OteFjSuGTw6QtfrJQvmBXFNGKAkQLsfPpbpDiUaUqIfYu
         O1cncyu4EQ2LRNMLTdR14rOfwKZuwT06N2D7SEHrIrhz6nc+mizHfyOlK3mFhJN5sPoQ
         fIUM3vmFybUP5ogeRicZfEhsu7gM6JqRlG+/Ui6dmDU1d1NI1Kt9VVvhWZIsXOHihsOA
         cbrA==
X-Gm-Message-State: AOJu0Yx/yxvwZFZlHYTS0cdHPXp+aKQIskUUmgGWr5h8EnG74VlMfMwN
	Eaec7tQKYEgxQZ4afP7wjTUXv0vAyw8I0ajrF+MyHkAzUJcMramBrnLJXj13G/SS+TeGr5TNe3d
	0L13ySAsTJmvEKDbo7A2oZP34n1P+aJJArwqoGXMuk3VPzT5sTzQs/lY=
X-Google-Smtp-Source: AGHT+IHjhRtPpAhLurqhWbEyFgjT7MBueOtddOk+fUZy0nCcYa+KixltoLzX/n6FWfrwPwnE8PxM2I/rfBopKeUkyX2BeiV3dTTB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24d2:b0:4b9:6f13:fb1a with SMTP id
 8926c6da1cb9f-4cce16dd597mr88236173.4.1723789119364; Thu, 15 Aug 2024
 23:18:39 -0700 (PDT)
Date: Thu, 15 Aug 2024 23:18:39 -0700
In-Reply-To: <0000000000004e582f061fb691ff@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020aff6061fc6eef7@google.com>
Subject: Re: [syzbot] Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_iget
From: syzbot <syzbot+5bdd4953bc58c8fbd6eb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_iget
Author: lizhi.xu@windriver.com

BH_Lock state check micro buffer_locked not work?

#syz test: upstream d07b43284ab3

diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index cdb9b9bdea1f..f67f82adfee2 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -148,6 +148,8 @@ int ocfs2_read_blocks_sync(struct ocfs2_super *osb, u64 block,
 		get_bh(bh); /* for end_buffer_read_sync() */
 		bh->b_end_io = end_buffer_read_sync;
 		submit_bh(REQ_OP_READ, bh);
+		printk("bio, jbd: %d, dirty: %d, i: %d, bh: %p, buflocked: %d, bfl: %d, status: %d, %s\n", buffer_jbd(bh),
+			buffer_dirty(bh), i, bh, buffer_locked(bh), bh->b_state & BH_Lock, status, __func__);
 	}
 
 read_failure:
@@ -170,9 +172,15 @@ int ocfs2_read_blocks_sync(struct ocfs2_super *osb, u64 block,
 			continue;
 		}
 
+		printk("rf, jbd: %d, dirty: %d, i: %d, bh: %p, buflocked: %d, bfl: %d, status: %d, %s\n", buffer_jbd(bh),
+			buffer_dirty(bh), i, bh, buffer_locked(bh), bh->b_state & BH_Lock, status, __func__);
 		/* No need to wait on the buffer if it's managed by JBD. */
-		if (!buffer_jbd(bh))
+		if (!buffer_jbd(bh)) {
+			if (!buffer_locked(bh) && (bh->b_state & BH_Lock) && bh->b_end_io == end_buffer_read_sync)
+				lock_buffer(bh);
+
 			wait_on_buffer(bh);
+		}
 
 		if (!buffer_uptodate(bh)) {
 			/* Status won't be cleared from here on out,
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index e022e40b099e..33c179fa522e 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -411,7 +411,7 @@ map_bh(struct buffer_head *bh, struct super_block *sb, sector_t block)
 static inline void wait_on_buffer(struct buffer_head *bh)
 {
 	might_sleep();
-	if (buffer_locked(bh))
+	if (bh->i_state & BH_Lock)
 		__wait_on_buffer(bh);
 }
 

