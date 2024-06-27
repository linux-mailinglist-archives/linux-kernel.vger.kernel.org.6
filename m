Return-Path: <linux-kernel+bounces-231763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D05BC919D95
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 04:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0C61C21371
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 02:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A791125D5;
	Thu, 27 Jun 2024 02:53:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5E3101EC
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719456783; cv=none; b=nRQQETdPZ5z0KULUr05jZJNqSavkeHBbdZz41Nz/eVhqNP6QZNHIRQqN/Op4hG+jC1IGJOeGcB1NPG5g7fIh2beWsOZhjo7AimhdG75nb4cUsyMWI0ojYPktjK4FApWz/fo3DNdjCk1LyemAq1yitvq8AelXL44znr8IDHjKWLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719456783; c=relaxed/simple;
	bh=o98+BimdjZ90Sr0eiLzEh5iHbiYXMs72o9xIeWp13bo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cGqs/0C+fwnNUUSMvO2RO0fDZNILEINz6LKfmsfISqk7u3exc0jHkn63RvIsogsicIeDQorejxeZodbYvhAXQWlt24LMqk4KPzmLjFyA/cXhUYqe10x5A8ziahNvBjTuw10u+Pgb3RVwH83ELZS7QWmFtM59UL8uyOkXItgUK+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb73f0683cso1066119439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719456781; x=1720061581;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21JnBvhbP0T3+7EHQJxi11Y+NMnulkZVK+fNWbrUCNk=;
        b=Gttd96gEphOK1WVRf147hnIHqNszDUHUNEILD7YIaz6Zuee0fV3p1UwhEWaTwikKdN
         Rob/IUqN2duSZon7XfRvUhkqaDm/A2oqjG3m4ck9hcyha25W+ETw6p8KC37E3wb4L0lB
         kYvIbHNtL/jSpS4oddjrV82ZCSIXeKrrbIQ2gntwyESreBcfzA0eMXYRFALBQwlpI+k3
         5qSG2QnnLSwd/5EfYXIolfEYh9SCJyMAgQ81QkdoBTSyedHEV5GoJNVE8txCDH7VSZwg
         xZ4cnKW+U177W1O+2wvMpMfFfSjUaSNlgt9zTEMib+hV1A4O/1v2BBnaIZOnG7vdjJCn
         m4+Q==
X-Gm-Message-State: AOJu0YwqLuBVkKfEhcDb7WKx7ZMpEcfJVGXwFSI1kLBRdqVpshvO4vvZ
	cr2eVvUuVTGSETF+depBgfNNFBWiaUVig8ahqGZ90hqR9AnGBIQ71cFhLQ6QVCTk7aEDQKRv7+d
	8JeRUe/dwuMLz8o2i9iiH5seCanTnpnyy+NkCQ2+VNNrdiUJ8IUYLyNk=
X-Google-Smtp-Source: AGHT+IE5x6BlmjLKR0GcVI6Zuf/1wE3UgDz6LlG3/qJhgnQ10JD9RSnU7btL1ezhSJP+DGXjGxLZDrU0wOVpGNUSbEvMhCBazOfW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54c:0:b0:376:417e:c2a6 with SMTP id
 e9e14a558f8ab-376417ec6d3mr9581325ab.4.1719456781237; Wed, 26 Jun 2024
 19:53:01 -0700 (PDT)
Date: Wed, 26 Jun 2024 19:53:01 -0700
In-Reply-To: <0000000000001f253b061bb8a953@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a70fc1061bd63a5a@google.com>
Subject: Re: [syzbot] Re: [syzbot] [jfs?] INFO: task hung in txBegin
From: syzbot <syzbot+eda89a33c5856f66f823@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [jfs?] INFO: task hung in txBegin
Author: lizhi.xu@windriver.com

#syz test: upstream 50736169ecc8

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 92a5b8283528..04ccc85c80b4 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2076,8 +2076,11 @@ static long wb_writeback(struct bdi_writeback *wb,
 	long progress;
 	struct blk_plug plug;
 	bool queued = false;
+	struct super_block *sb = work->sb;
 
 	blk_start_plug(&plug);
+	if (sb)
+		down_write(&sb->s_umount);
 	for (;;) {
 		/*
 		 * Stop writeback when nr_pages has been consumed
@@ -2162,6 +2165,8 @@ static long wb_writeback(struct bdi_writeback *wb,
 		/* This function drops i_lock... */
 		inode_sleep_on_writeback(inode);
 	}
+	if (sb)
+		up_write(&sb->s_umount);
 	blk_finish_plug(&plug);
 
 	return nr_pages - work->nr_pages;

