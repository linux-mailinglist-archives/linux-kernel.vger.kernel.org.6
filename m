Return-Path: <linux-kernel+bounces-272044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE41945632
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928BD1F20E7A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D419E199A2;
	Fri,  2 Aug 2024 02:00:43 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8E517758
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 02:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722564043; cv=none; b=HUQYb6qDojvI0YyfSTqaD3iYgD4Vaey58bxWjGs0N5zWyTWr36SMKj5rvDkSYNJRhLFlKiNT1SpdBjBl7J6cizFxxpU+b36aaR4FPpp12N6a9XCAnqNQtjsobXuONORdqj/NE2ktmSll/eKN8XIsNO99iEKBSCjrTOs3kI9GG1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722564043; c=relaxed/simple;
	bh=nYnftO0UIRk60GN9PxkVC7kInF8cDzj96YTMm92dm0Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rQZprA3xTlu/PmTYr/0aRo5BPbyITdFZDkZqyVV4mZKpBwtWUA1/JSJrc6ry4u4ABZg3i0+ZFIiQ2KT0yjzVHb2G8etC1HBgWtDJA2Yr3HnQXoBPg5W6ogfaJG4mRP5QsUXE47bLeDp/UzQVtcojyXAzYoaqmbq2ou0TXDzS68Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81fa58fbeceso763230839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 19:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722564041; x=1723168841;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4IdDfj7aJ3KYs8GvuJmtQfDHZe30Ze74paHAlfljTI=;
        b=wIrMNwsu1zzPaahyfPllDo2eKIN6wXZeQPZX6bzCOTXJQsATiql7fxO0mSqwGBYbH5
         KQvT3bU6r6Czmhls9tBKw7tBnrxs5N0mEZqaTTdKxG/CI0onvkPtV5cCt+xFeXgSk4A8
         uQngkhgYLrqOOo+KJF4Q7iVa3dH7LoU8iIhMJJsbiLrqyid+xBuwSJe5J7SG1TQ9llmn
         stJmeooDLnlgXZKvt4B+USWwtt8CJRmBbiwYy1nelIxZun915qNG/LHhWn15670AEuCj
         UdetrM90GRSWKv0JI3K/mcANCQpoBCu3P+EDCeA4ttrkg/rFqxh9AlBaf0aRovWI0qta
         4TuQ==
X-Gm-Message-State: AOJu0YzOADUd8A7FM9U4GK6yYv3HQ9qjWsz9pEbI+qnPVTvz/5RFaLb+
	xD6Q0oXcHGw16NCh8o6GUS31J2L21nNYfI3RsC/Oup+9VuGgGhTNUYT0CNHhFheZNX47zP3DUWh
	/28xn3D7pc8X2lOYcmc/p+IHWqVn0rCCKu3P3FKdddGihVJ0UocdcWjg=
X-Google-Smtp-Source: AGHT+IEUIeYR0NCrMK5S5qvvEBndj6UtkLvOoc98cqPumqN6txndNshGC9tIoNXA8xN5RHmH+Cu16lgQtKkZHw0k1prvMFDHTfOe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9806:b0:4c8:d4a7:898d with SMTP id
 8926c6da1cb9f-4c8d540892amr49915173.0.1722564041102; Thu, 01 Aug 2024
 19:00:41 -0700 (PDT)
Date: Thu, 01 Aug 2024 19:00:41 -0700
In-Reply-To: <000000000000a90e8c061e86a76b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5e490061ea9b10f@google.com>
Subject: Re: [syzbot] Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
Author: lizhi.xu@windriver.com

when i_size in read_inode, check it

#syz test: upstream 2f8c4f506285

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 16bd693d0b3a..6c5dd225482f 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -287,6 +287,11 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		inode->i_mode |= S_IFLNK;
 		squashfs_i(inode)->start = block;
 		squashfs_i(inode)->offset = offset;
+		if ((int)inode->i_size < 0) {
+			ERROR("Wrong i_size %d!\n", inode->i_size);
+			return -EINVAL;
+		}
+
 
 		if (type == SQUASHFS_LSYMLINK_TYPE) {
 			__le32 xattr;
-- 
2.43.0


