Return-Path: <linux-kernel+bounces-319244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6BE96F9AB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B6E285658
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD851D45E8;
	Fri,  6 Sep 2024 16:59:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319851D3634
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725641944; cv=none; b=U4u58mQGKOtAUPC/uMh6Gm+gzwV7cDX9HdEsJTQ4Ck/ab2+xDqaVX8M6uLBwaaGVTO6qGDGrgijZK5V8wMBD51Nfy2PbOHQ3RQxa+yW1nClJXKLSd7JyYhGl8bdy1V/vEfUynqGZprAuuDodc5EzKlgYXuN5qBB3XZtJLJdHmjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725641944; c=relaxed/simple;
	bh=e5hMLYOMgd6fSUDyoYUu/wSyazrWKfKq+ppB4d0SBZQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q85CA70Nzh7vBqEaaqpdLZxjXo6bYyFPZIXAF/XtCdGu4FeSk2+QpZ0Y3lvc5l/2m96z5dmHorAin2/ZDVEPXqEFT92uQnIv4M7LY/g0iJ5HjDfuv36oCtZwf8lsZzJn1vy07C92Liaj+Z52NU/uN1pkMiqhyaQjzRGYUNfj6/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a3fa4edbdso526908239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 09:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725641942; x=1726246742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7mtYQk7Eetq9jvIgimP8N8vZdUqiRvnKLLxGUtIQtg=;
        b=PwYvu9KkZ3wZ+OFX0pCPE+5Oo/I04FB182EMxSiqGoiGt467t+IOJgVurkp9G+dcnz
         2HE+TCWisvzhL9WVJTJ+00OnE/FkYAUQMnLdHjVH8MHYBS6r9jyQJ/vfeBeln6j97gEL
         rY1G+zc8jp+JgdSo3FNEkgeTZ+emnGHqYsybe3L8N5fQkcSvhqbPnv4ErDPNMkF7Q3mk
         2mD9r3lozsWmUrq/gErLI949UQIQqEuX6quC57BRn9oM13E5VEkdUwgWEfVfVj1nRfni
         ZlBNbD/SJT54l+dJEi4nMKLlqEBD3e7hAg+sBa/9ePUv8wAzKV436Ndnd3ZlnQP9qAXo
         kdcw==
X-Forwarded-Encrypted: i=1; AJvYcCW21TyiUAST4Jyxz0sZItzeDhbZuINw5VApFgZarlNvADACAUJ8OSD5D3baFp34mRlVQlI5C6jFgkrRwxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp5qDvVbFpShICCG4BduI9XtLrD20aTQm7IpZVu8B88NXojLLO
	qyF3Nrhey2gxeIdsN0RkvazN1LBklABRG/KCsbLg5sFIOM4Kkkaln3WO1v2lIg84CVek5LWPciQ
	9MDSw54rxnwAHnqS3mpiAz7ee4aDonbFtAaiYZFaL2G1h285j3L05WUk=
X-Google-Smtp-Source: AGHT+IF1npguOCicLVvB4f/bQKVyMCjyUoDNmxl9SBB3iYqULav0t5dWBHvjnPBUh1iVyIAioTn2/XQ7X+Nb3DjKgI9v317wX4gc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ce:b0:3a0:4646:8a7d with SMTP id
 e9e14a558f8ab-3a04f10e30fmr1278305ab.5.1725641942241; Fri, 06 Sep 2024
 09:59:02 -0700 (PDT)
Date: Fri, 06 Sep 2024 09:59:02 -0700
In-Reply-To: <tencent_08AE7451777167B63C51364097F8363A4A09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa27700621765237@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
From: syzbot <syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com

Tested on:

commit:         b831f83e Merge tag 'bpf-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a09167980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35c699864e165c51
dashboard link: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b20709980000

Note: testing is done by a robot and is best-effort only.

