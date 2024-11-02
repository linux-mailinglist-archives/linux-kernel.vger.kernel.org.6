Return-Path: <linux-kernel+bounces-393382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 884289B9FD4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 12:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B4B8B219AF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 11:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CA4189521;
	Sat,  2 Nov 2024 11:57:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821AC187844
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548627; cv=none; b=K2sULCe26csVT/6KByUDMKkHo1TAZQWZq5LCDqjJLP0z2WlyTIJXwVuCj16xVpmDl7Vb2Af7nMBL1RFByLevqGf0q/b3f8GXKWZIqTBcZY2wl7+5fZotqT8y8mbSHMwBSwMwuYrZj6OFEZbqU+C5pezvvOFFJOR7NkWA1Gn7d4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548627; c=relaxed/simple;
	bh=hY7Qp0LVBzkxDGAGCzMbU3IbUplH3cDlFNADtweXEZc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Pm/BSGi/q7W9ImbWr9bmJiQUWVzkzt5YZvM8RrutOn9LWqGIjLAGfhkYAFrWYIxw0rd5PqPkXhTW/DcMwDyR44ljeW8fqlzbXoxxNO4XMkYnZIYU68Dp4zdn1GZzgfjf5vQ8gHLDyOciXr5nw4mfahIsJ/ouRa48rr5CDMEuTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ac1f28d2bso258479939f.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 04:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730548625; x=1731153425;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQgRivpVF9UQ7N/9UZp37aX+ZdPtlXZX6nCsGrsrK7A=;
        b=XFo3eHPUd4iEWueIPVnpcCAb7YhhJ5P7wNJY1C3+ZNvTY91RGnCIYqKfix6qehQQh7
         ufOsaJSni+zQTJKQn8Aa0zaXNnUUV+R7/eEck72pUpYBWlO0GtbrVGVPHEbaFmj1OwVf
         LBvUzoeki/NdvmLnK/VDiSPUGevkh5gRR6rpeWt+MkGVLc5SSQA4BVkmIHfuqPqrv1aT
         jagyj6Qhc1AAt3uNtMdgFMio8V3727BrZuYGF+DGDLopQiD8OFB+OprgslOaMPvtjup0
         Bmj+VDAPN+sU0DBMYWH4RGofMZPB7WOEyCkwQdgRuvbKDFAgLE2wWDsUhPyL2V/4gFA3
         SUTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDd4S5pQ60awK6qFqTSNml11FrNeFeWq3BJPjNipg0je8Mgwa3d9MrdHyG325tUfN/YWe4YBRhLVB8cbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEuZ64VafD25VQeJTFYmklb6wHtxn59EyShlyOhzwaIijP+jfi
	zgzrS2cSTA9NGnCs7DQ0qKcZKpFpaReR7qMD1IqC/r8cW6G5Fi9mO67594bNmjyMWbRGZyNeqba
	+9c3Amrr7My+eCDQtc3KNTfSjLU2hjM1Gl6P5bnKYgoLumFjSCPkGofg=
X-Google-Smtp-Source: AGHT+IFmFNjiUlFoZ19V4DOoAQ7Yfyn3jBQxK76YJvFOFc/MWy6VS9PygxeZAEgcCOGek4QuT953M5xXCWp1GzRzKm+B7wTJlhH1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcc:b0:3a0:49da:8f6d with SMTP id
 e9e14a558f8ab-3a4ed3057c0mr239739905ab.22.1730548624722; Sat, 02 Nov 2024
 04:57:04 -0700 (PDT)
Date: Sat, 02 Nov 2024 04:57:04 -0700
In-Reply-To: <6716521c.050a0220.1e4b4d.005a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67261390.050a0220.3c8d68.0976.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_dev_btree_bitmap_mark
From: syzbot <syzbot+e8eff054face85d7ea41@syzkaller.appspotmail.com>
To: anupnewsmail@gmail.com, bfoster@redhat.com, devnull@kernel.org, 
	john@stoffel.org, kent.overstreet@linux.dev, lihongbo22@huawei.com, 
	linux-bcachefs@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	manas18244@iiitd.ac.in, skhan@linuxfoundation.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 60f2b1bcf519416dbffee219132aa949d0c39d0e
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Tue Apr 16 23:33:51 2024 +0000

    bcachefs: Add asserts to bch2_dev_btree_bitmap_marked_sectors()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d4cb40580000
start commit:   6c52d4da1c74 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1034cb40580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17d4cb40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f527353e21e067e8
dashboard link: https://syzkaller.appspot.com/bug?extid=e8eff054face85d7ea41
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e972a7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ead340580000

Reported-by: syzbot+e8eff054face85d7ea41@syzkaller.appspotmail.com
Fixes: 60f2b1bcf519 ("bcachefs: Add asserts to bch2_dev_btree_bitmap_marked_sectors()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

