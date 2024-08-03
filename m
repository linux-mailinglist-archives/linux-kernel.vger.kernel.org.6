Return-Path: <linux-kernel+bounces-273292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CE59466FD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 05:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79E32827A5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 03:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4784FF9F5;
	Sat,  3 Aug 2024 03:04:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ADBCA40
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 03:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722654244; cv=none; b=Gtv4+pNdwnra5v+REpulFsUnugLF6mgfG3xN6qK0HNb0gPetx081987heCokTMmIHjOc3xCugtvZ0Er9i3oRAHzrhmfWimN4zWp77oCX3JOqWc97XDeEI88IJRXsFmK7/40mM+VxLVPSFR0R95GsT/7UjJEAuRjuNu1zqWsyw2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722654244; c=relaxed/simple;
	bh=Sin5d4m6BgLj37XqqR35/sNiLa17MoVVgF7T+Xm3IXY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HGs0T0WtnWup87nREAjMwATaupa+omRj3KiG+vUlJDhiGJfr95OswBDepQ2p2arrwoDLPxxB8rFzZ0YbFIAWufXAafoi8GVGmTHk1PFtrAgEeNloEu2w7zfbdnt0SARYAFcOaEAxCQT/5Ozlf2LByP7JxI2cU094B/BbUTI5iTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-397a7f98808so174812265ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 20:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722654242; x=1723259042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqpQoA4cSxYIbdR/jLLqjdVvJwf1HpbyLK7Dj8YqtnQ=;
        b=JJt/vJoV6QvtIhqA1+hnQDkphw03KgTp0DWUb1qoFKlV3owQeqo46Hh1W97/hnLm3o
         hofmUFCStnIqCfZKmmcQx9S3Ci+iTwycf43ZxNX1JXhKlKTuvNkr2b+iuMq1Yu0zD+F/
         Mzdk47156tHfmUpA2+VSbKgBtuSGfmru59CrvVSVPCnTaBfv6CJBtgBuC60ugIape68I
         oyt+5qqmMm8rjG2Lg3O5xzGWffwcJhDQCvo+WeAsMZD2RWcmtor1celHWpcrttA0N7VT
         2JIp6weZyW+ImgkQSoUQzDbziAt4kRc13FGDuk4dDJ37uPkyvuF5AMe4b482DdTFcvJj
         lqrQ==
X-Gm-Message-State: AOJu0YyS/iASWjvsozBXGANDQSm5+prK9pGoJGA1enb6wAK/4/cIuto9
	bELQ6pSsfVhA64DtO8kU+gjkcpyWRwXnBq0MPQgCOTY5HG5H5JDjkEql1mU1Nvu/Nx69o7Xc3kO
	0DJlqw/7U80p+iC6pqxPmJgw89vr0BC7rZ+9eZ3xBtUvrQqamDWiXawo=
X-Google-Smtp-Source: AGHT+IFND4IQle8TJqQpMqbANOFmo9uhFA2YdGB4yfzRzp4XOwlirAP+eQLHvOKez8cgKUEiFZI6R4Np1i9cPfaIfjjUbOrifTnh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d03:b0:382:56bd:dfbc with SMTP id
 e9e14a558f8ab-39b1fb83a10mr3186695ab.2.1722654242593; Fri, 02 Aug 2024
 20:04:02 -0700 (PDT)
Date: Fri, 02 Aug 2024 20:04:02 -0700
In-Reply-To: <000000000000a90e8c061e86a76b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003373ab061ebeb2fa@google.com>
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
index 16bd693d0b3a..6c4316d7dd24 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -279,6 +279,11 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		if (err < 0)
 			goto failed_read;
 
+		if (le32_to_cpu(sqsh_ino->symlink_size) > PAGE_SIZE) {
+			ERROR("Corrupted symlink\n");
+			return -EINVAL;
+		}
+
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		inode->i_size = le32_to_cpu(sqsh_ino->symlink_size);
 		inode->i_op = &squashfs_symlink_inode_ops;
@@ -287,6 +292,11 @@ int squashfs_read_inode(struct inode *inode, long long ino)
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


