Return-Path: <linux-kernel+bounces-271401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44073944DB2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CD8289C4F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2B41A4878;
	Thu,  1 Aug 2024 14:08:38 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCC81A3BC3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722521318; cv=none; b=nf8VXXItzdcSI+/QAbPM67MceagW4P5xjoGMB1qMbTEV3NX4GMG5wZLCvlxy0TqS0x28iX6pzau7tc9lkKU/Oar1S3836x/xPjsjidJ8nPGOvHIEck6VIFxrnLXA54m8qBaZjjZkJv+4iwwE6QW5u7kb6S30hvZ9J9JwTRLzLh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722521318; c=relaxed/simple;
	bh=2vlGomB5qVmR7oICm7Ih+YVFpQUbmj89UkCR8fAyJfc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cY3a+F1mR2oSAGj82labmJDy6+rHALx4fFfM9eEh4gTkzSdhYyrTN012HICfwTqNoxKfSXQDArF2vzrxIz6PDIkPcVG1atmdVeJZzWCeIswJOFJJ20a2vAeEab1Fu33ULAj2dgXZguP3Itz7qgoPUKXC46X464Brnk1vWtysvEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39a06767cd3so109087555ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 07:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722521316; x=1723126116;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QoylRnG5C5nKVUZ+5+1nIu/C2zIp1wF6KWaA9o/Y+pQ=;
        b=soepKdI6atbDlsSpI6GpR/SKzz7sR9kbBFFVkrWKk7kqN7OPHSYVPJzqe0QZtUJFMU
         ROAgqsqN1j+1dZe9HGGnXmIb4SJyhER+thwAjf92VGsytUEYrIVbDSaaxA54B/gZWCdd
         99WkLZm1iYYprNDsJUqydxphegtBQdHMbG8ltwiEBWHyR8X1BQefYRS231WCmPiP98n/
         C/pNNICBwUtXDHlv/tYqlxB6dDW715SB6c7UupS22fnF6PkFOTOz4YJP0nrXASs19EYq
         Dgk0iE3ZDgJHmL885xIpPJzfEHL/9OCVivJEnb6XyBnR4K3+hxPxTsT7R8b36YZXh1EV
         UeZA==
X-Gm-Message-State: AOJu0YxXEWD22EOBT52QW0MEvbgNaaguYkC6ZICw7BhEm4v88kLTW8EF
	x6CFkx0HgVYjVxEAojsLUxt29CMjQ5e/IntVg5bGcm6L9wXWIDNdXjlZ0NkO+v9U+xgOKq28aPC
	hSusO0USJkeIFF8RPQb00TCs5hGk2DAev2gm2eGWdAI0s9J61na74TfY=
X-Google-Smtp-Source: AGHT+IGcivzNqv9eOpvBrSPURLELDXszgKr49wyKAmxhJt7kywIYW2Sew+7rSKh6rzlQxKHqH/QWeZWAa60eOGb3hT0pbPHW3sXs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6f:b0:398:b1d3:7c9d with SMTP id
 e9e14a558f8ab-39b1fc1fd7dmr98955ab.3.1722521315635; Thu, 01 Aug 2024 07:08:35
 -0700 (PDT)
Date: Thu, 01 Aug 2024 07:08:35 -0700
In-Reply-To: <000000000000a90e8c061e86a76b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002302d2061e9fbfdf@google.com>
Subject: Re: [syzbot] Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
Author: lizhi.xu@windriver.com

why folio not inited?

#syz test: upstream 2f8c4f506285

diff --git a/fs/squashfs/symlink.c b/fs/squashfs/symlink.c
index 6ef735bd841a..ddd980d75334 100644
--- a/fs/squashfs/symlink.c
+++ b/fs/squashfs/symlink.c
@@ -49,6 +49,13 @@ static int squashfs_symlink_read_folio(struct file *file, struct folio *folio)
 	/*
 	 * Skip index bytes into symlink metadata.
 	 */
+	printk("folio: %p, isize: %d, idx: %d, length: %d, %s\n",
+		folio, i_size_read(inode), index, length, __func__);
+	if (i_size_read(inode) < 0) {
+		error = -EINVAL;
+		goto out;
+	}
+
 	if (index) {
 		bytes = squashfs_read_metadata(sb, NULL, &block, &offset,
 								index);
@@ -93,6 +100,7 @@ static int squashfs_symlink_read_folio(struct file *file, struct folio *folio)
 	flush_dcache_folio(folio);
 	error = 0;
 out:
+	printk("error: %d, %s\n", error, __func__);
 	folio_end_read(folio, error == 0);
 	return error;
 }
diff --git a/mm/filemap.c b/mm/filemap.c
index d62150418b91..ac4675d76e2c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3787,6 +3787,7 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 
 filler:
 	err = filemap_read_folio(file, filler, folio);
+	printk("err: %d, folio: %p, folio uptod: %d, %s\n", err, folio, folio_test_uptodate(folio),  __func__);
 	if (err) {
 		folio_put(folio);
 		if (err == AOP_TRUNCATED_PAGE)

