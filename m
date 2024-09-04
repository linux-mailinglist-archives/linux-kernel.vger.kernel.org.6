Return-Path: <linux-kernel+bounces-315273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0E596C044
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE3E28ECD9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBE51DC1B1;
	Wed,  4 Sep 2024 14:22:26 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7CA323D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459745; cv=none; b=X+CZ/v4zwUK0sXA46cAsYPIepWWHwttPYz19fDz8w0XS5YDmhotlQJnp849eQIrp/pNIM2QQYkCxEToSdR5lXKyqrWZm+Af4f7DpfkOarE8R5XDJMiVwkDJGLuFNR0o4838F7/o9MH1ouELK8OzghjPJHwcfH2UIQcPZdu+fM9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459745; c=relaxed/simple;
	bh=gRgRvNNoCpCPZ7MOeaA0wmrhKGOg0ElPGlLUFez3pr4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s4jb6J5oVnL/LgRRTowHlq3u7d4gy2gKlI1h06+oWJAH6AxAuRB3u9hpibX6xh67iYQbflY9nrN94Iz604I9yVbkEKg8R/SpDGh4YKr3n/Jzh2bI8CwqxECBMnZ1K5Ja7xXAJXZbiseOXAdA0Q1RF1RPVVIhadV2g2Wm3bErITU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39f510b3f81so12012475ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725459743; x=1726064543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/kz6Bck4HlQlw7EBItThHdws6wLUHokXLC4/YKs8ls=;
        b=PTLyT09K5FRIcCsVbWyNKbAyrr4PLPDwpQT/azSTi+PWRpOjaHPG+o3phzDfHP5brq
         TYaqKYT7I8vBksUvocRjnD9B/bMaMf0irQftfQYtrBJmRbbt1aGfaJmO1T5vv5c88ZTJ
         Jqj5hcG9Q0H5FClpkf1a+CpFkNJ7ouFLX+EzqCLtjc9s519L8Ovcn2FS7s+ISJa+QcGV
         1ne7g04Gqq74IgI+qDvyDFol416vpPOTcNtRWy8zkvaPuRg4K6KF286vDkh5gCRSV3J2
         oqlXkaCvzcDSAMWxILJbfQJPxyM1bNGPsQ2r6o6LRIagVSYNHFAo8R3rH9ZnetJ3v2X1
         rucg==
X-Gm-Message-State: AOJu0YxZHWZABPYHLgFvdEyY+D/AC1lvpZP8FSlwBsXbjJfX2oJccsnp
	lK9t01r0e13SZxDfRHVEdS+6sE1yE3H6YvxRuQOBxSg7MEvyJErJVxYlH1sv+VuWT2wtwD9W1D+
	+mJRQ/1Ye2Mdwgsk+pzPX94Xv6/bkchm3fPx2NNJJwYahKH9751pQvvU=
X-Google-Smtp-Source: AGHT+IG76uQjw9mRE7EFSi6soz89yXP+2LvVubTco87TZTegCOiyoLzpoJmC288PduTg9GVNW/pQh77QEWq5hRz6Jr2ay3sJuvNA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda4:0:b0:39f:4fa5:de74 with SMTP id
 e9e14a558f8ab-39f797af4dfmr695415ab.3.1725459743765; Wed, 04 Sep 2024
 07:22:23 -0700 (PDT)
Date: Wed, 04 Sep 2024 07:22:23 -0700
In-Reply-To: <000000000000acfa76061fcca330@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a047f06214be71f@google.com>
Subject: Re: [syzbot] check
From: syzbot <syzbot+4d2aaeff9eb5a2cfec70@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: check
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 128d49512f5d..a5df8f4c0150 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1472,7 +1472,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode = ntfs_iget5(sb, &ref, &NAME_UPCASE);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_err(sb, "Failed to load $UpCase (%d).", err);
+		ntfs_err(sb, "Failed to load UpCase (%d).", err);
 		goto out;
 	}
 

