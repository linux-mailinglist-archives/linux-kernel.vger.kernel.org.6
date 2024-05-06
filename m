Return-Path: <linux-kernel+bounces-169218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1628BC4FC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 03:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481091C21069
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 01:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3B93B79F;
	Mon,  6 May 2024 01:04:49 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2D06FBF
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 01:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714957489; cv=none; b=NniEuxb78hMW3/HaUOmtCGKGpD5gVHRAFEBMGRntmYXnSgkbKpZQzEr6uK+pm/yEq06OUN5rwBbggYfO4lxfK43DzzR2UblcK3gX0+d29z+cOoy2xa/scpS00xi4UzkWZdwJY5Buw3VtIsACCE+WP3P5k+4yGd7D7u5SJwwNxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714957489; c=relaxed/simple;
	bh=2xaAwOXDoxpsY3oIsibI4NWl1MwDWFpCXdFaT0HaBq0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=drAMczyfieFWHvKdTN0lcHtz/2IrJF0kQhA1CI7fwZIT1WeP4Dx2fY0V6+x5+qDodK7jwHx0LqWebTp5iewqNRUtqhxNQAliTP/iaOSfisAKviDxWdJiqRflVGf2GLMxiEfYwsaZ/78o1IO7e9Ggr7KJhq/TN27cbWG4sBcQqgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7dec3c5ec72so192903039f.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 18:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714957486; x=1715562286;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZwooSF6JNScgbnDloJcJT9Ooy92PX+xv5XwI308Vxc=;
        b=p86LvbvNQOwJsJdm2ViSMBJ0A3m5ZT0Yv1KdOisv+JTtScam7wY2syXLU+n5Q5b2XW
         BgdZtGnrANAlYrWGbZ+BIIsjKHb9aBUSQ7Y0CDbg8X/Yfd8gAj3b/jatlrR5ETxvh2v6
         JHwtp7MnlJZbF3XenCmxJ66QkPktgobQzVSllByNPk0cvciez+0FtRrU/yVSANzABLYZ
         pqbY989kYn878WySCA2kDmZIn4zP1cnM703U2sA5YStMTjNHyQojl1z6isl9xKiewpTX
         2A9Hi7Llu1S745bl+ocHguyweAFkS/KNhxT7N3Sb8u0358rPs7jY6AzvvM+3cZvEJVN6
         1Ffg==
X-Gm-Message-State: AOJu0YwPINN1RysTfoK+d4D3A/xkjowin1vS1zYOZvf++Qdv/QWZjSzY
	qCI8L4YNkFhgW5wkipJrNP8+jH7u7yEGWjr+yrFSv6oTW7lz3l/gfU0iDka3KMWNxEyQHU4452D
	PsdQSsHeY8kkqhsNS53LtlP7FBmclIZk0DpslckUpp6KVhU8Scz9Ctj4=
X-Google-Smtp-Source: AGHT+IFKIbok4pFKkX/uL1MiVA0CXEhGmCLL4BZbnBQnhPGdjjIgyp22H8xh5snKFLtNvZo/+XhK/BW00yZIckZkdCte8pjS5O8+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c02:b0:36c:5520:9597 with SMTP id
 l2-20020a056e021c0200b0036c55209597mr320739ilh.6.1714957486797; Sun, 05 May
 2024 18:04:46 -0700 (PDT)
Date: Sun, 05 May 2024 18:04:46 -0700
In-Reply-To: <0000000000000498630617b740d3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce43380617bea7d1@google.com>
Subject: Re: [syzbot] [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in rewrite_old_nodes_pred
From: syzbot <syzbot+594427aebfefeebe91c6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in rewrite_old_nodes_pred
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7367539ad4b0

diff --git a/fs/bcachefs/move.c b/fs/bcachefs/move.c
index bf68ea49447b..1768d46980e9 100644
--- a/fs/bcachefs/move.c
+++ b/fs/bcachefs/move.c
@@ -983,7 +983,7 @@ static bool bformat_needs_redo(struct bkey_format *f)
 		if ((f->bits_per_field[i] == unpacked_bits) && field_offset)
 			return true;
 
-		if (((field_offset + ((1ULL << f->bits_per_field[i]) - 1)) &
+		if (((field_offset + (1ULL << (f->bits_per_field[i] - 1))) &
 		     unpacked_mask) <
 		    field_offset)
 			return true;

