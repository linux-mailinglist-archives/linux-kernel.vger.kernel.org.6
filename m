Return-Path: <linux-kernel+bounces-280340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0898F94C8F4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 05:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD96628599D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D641B964;
	Fri,  9 Aug 2024 03:50:19 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FD514285
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 03:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723175419; cv=none; b=CX3+sAuG0Ib3ZM/FXXu7A+IEwALc0loFXE+Uwpri/gvFHutIcYpKbKuWtZLzXhEMx6N5cZEvuZyM/OOkio36TntjbwMFp8vqt/SqxUpcCijoQ6sRzXM00IWpsej9Q7c/DY3WHwiw2N/OYCJGu1QCwX5ZKA+HGorKjamwi+n3mfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723175419; c=relaxed/simple;
	bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z5rZDQbDl29Yt+MrTyVyCFg8VJ/HmGv0Pqs4fRovpnj667RIODDFpWoFfjNZPBqna10urn6ESomyPhl1wgQFVzMToawMAfOAq/OrlMc+WWRf8PjtBC/R5Njbq4b2mgtDChRrWwNSBUTkoGLo4QmXli5isflhhmxWM9M9/bDVjik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39b3cd1813aso19855745ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 20:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723175417; x=1723780217;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
        b=EhHBp2LTbKK05iiGNRB2PwYsVW7BVVghg3W3H75gOQhVMgbh3jOn7xOXhzMLqIXXp1
         cQ0sYsiHakMSl/+fqe+tLo3ktR33Ydt3EMx7wKv7MZvi2lwnqO30jvUMQJYxpnRNekRc
         eETTTDP7AFwJYcfuRuOM1xh8RGGw1LCiIovIXRCIJunM57aYzojhqYixGrWw7+Y9xQXw
         Zu4tlgniskhjDjsUCkeobuFxPQ6DgfO7p1zKFkqgptoxOIIm2n3xEqVfUDBgLrjKUzQD
         duZ+2QoQ5zeZywe2XRPATHOuzbwRGUaQQlT35gPGnWN4tboeD8Y9hpPyLzvF7Pmb9JbG
         uNkw==
X-Forwarded-Encrypted: i=1; AJvYcCWzwNNJGNl7u82vc0xZyZv6FmKhf0dIpsFhwFDreTJyfRCLxM8jBh26wj80Rp8XQf3KfnLrRtH8aVKrLIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZmkrlkcI2CacFdi7KtUgwL57PoxX1VZqkPRTfMLVyPiNzr2g
	QkO9LGyZM8Xe8T3+As1+WNxmEqQhIzYSnDepVKma/VDXc6j9BbKwVrP/p2HiMIpca/Vg2FBM/it
	9t43mxXfM1zq2qSAHEKsPQZpc1jOIZQpkCt8h8vDSRwQ3tnzuAuzVhvc=
X-Google-Smtp-Source: AGHT+IEhfZW6ZwPLwMEdatuWL8mACVJv/vGSrmoYB+9RCPKIz1Pld9ffsCQYIrDsLJeKZpfgMIlDUdXIn+peTo1c2iEuyDmsTbmb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a26:b0:39a:ea86:12f2 with SMTP id
 e9e14a558f8ab-39b8c785092mr363745ab.6.1723175417242; Thu, 08 Aug 2024
 20:50:17 -0700 (PDT)
Date: Thu, 08 Aug 2024 20:50:17 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a17b01061f380ade@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos

