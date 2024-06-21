Return-Path: <linux-kernel+bounces-224270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB91A911FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7622F28F5C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D4416EBF9;
	Fri, 21 Jun 2024 08:58:19 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4327F16EB66
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960298; cv=none; b=le5DD41h0xESHCmL0sT8UuJMtVQoje2Sek+lP+P4DwBUD9dVk+GXvDgJ+e+gSaLB9EEO9EOljebpqrgF+YqtyuixpChLHM/IEnSvNo4RJh3PHlFiV/WjGTow/3/4IPzz2UKQzhDzhK4+pcJs0F8q9+5yc8KgHJhdoDSIb9evUss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960298; c=relaxed/simple;
	bh=BLTehQEdJrW3fIi3v3Y+wm3wt0cAfMi83DPSOPAZgOA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xeqx72hqXcHAIlOwFJqVG8zHZOxYwAwy+S37rhOeYArYPNXNJsskUERFxbYmCtYpx3o5MDs3cC+lWe4Flqpl9zhZ9ZgeFq23VPKw94fBIvSVkIITHre+pKFhewZU7ZOZMTfdooSFSFP6nSoy4Yb5zdGd+RmEoGGJCh9PYc4SJZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-37492fe22cdso13799925ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718960296; x=1719565096;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmj7aqV7u1iAmkPbqp9Zt3GKW/lV4myzNbN8/hKUz/s=;
        b=HW0/XhwOc344NNc0ZsdN4TTk4eNBedVyM5P9PBSebq/5Syssv0RRsCcrz/rO9Q1nTU
         /BK3aoD5hb8Fdk3tayNsn1puOWvBucqXwob9FrmkI6AQ1eqnjCQqfFwzxmNEBwFKPPFo
         X5jdSxrMnEiIZIDEsNlxNSwsjg45B/4c0EwBA7Pzqg2qQ5PCvRKn9goKfZm1wzwzP7s8
         XIxAICXIpyuAkmDdhTUPWJbMi9qlQobibP1KUKgWpYRm5s389loLuoEeaBRSVRfR8mXB
         HSQzglUeihtHXXZG4X/8yeJZmX6MCeUl+ovCfHo8GnySNICwbo3MtQTMrSIej0osxwo8
         okHQ==
X-Gm-Message-State: AOJu0Yxd0Xa+6XoKDHYOHU7rrMYZuorUbe4OMZbpgSDf0hY4+9Q1L4Q4
	OZUHOfpy5KRKMm1wWzL8oD2AEUvmbBwo1n9LNGeBp96kxQQORrB04e6u/vQg0At+BzVfAsKZ3oQ
	fQyeV5IoVMwhjrcjuKJ0D+Gw8Pep6I3RTnwRpwedrJp1upMwQBTC21Yg=
X-Google-Smtp-Source: AGHT+IE6+us8rjAJCPrOEgCWRgYt7MkKFWoF9NRNRMPqboog7pI9E8U2i1fvmBXUQu74jhWZEYZeaKmfj1wkKxQAVihAiT6Sc79y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c564:0:b0:375:cfd0:393d with SMTP id
 e9e14a558f8ab-3761d14694emr4982115ab.2.1718960296419; Fri, 21 Jun 2024
 01:58:16 -0700 (PDT)
Date: Fri, 21 Jun 2024 01:58:16 -0700
In-Reply-To: <000000000000aa7cb106196f6883@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9f2fb061b62a1c2@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] possible deadlock in bch2_gc_mark_key
From: syzbot <syzbot+050e797ad21ccc3f5d1a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bcachefs?] possible deadlock in bch2_gc_mark_key
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 50736169ecc8

diff --git a/fs/bcachefs/sb-clean.c b/fs/bcachefs/sb-clean.c
index 47f10ab57f40..7a75615ba745 100644
--- a/fs/bcachefs/sb-clean.c
+++ b/fs/bcachefs/sb-clean.c
@@ -373,6 +373,7 @@ void bch2_fs_mark_clean(struct bch_fs *c)
 
 	entry = sb_clean->start;
 	bch2_journal_super_entries_add_common(c, &entry, 0);
+	mutex_unlock(&c->sb_lock);
 	entry = bch2_btree_roots_to_journal_entries(c, entry, 0);
 	BUG_ON((void *) entry > vstruct_end(&sb_clean->field));
 
@@ -383,6 +384,7 @@ void bch2_fs_mark_clean(struct bch_fs *c)
 	 * this should be in the write path, and we should be validating every
 	 * superblock section:
 	 */
+	mutex_lock(&c->sb_lock);
 	ret = bch2_sb_clean_validate_late(c, sb_clean, WRITE);
 	if (ret) {
 		bch_err(c, "error writing marking filesystem clean: validate error");

