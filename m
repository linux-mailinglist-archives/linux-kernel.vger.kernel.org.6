Return-Path: <linux-kernel+bounces-387730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313379B556E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93F11F23099
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2823320A5F5;
	Tue, 29 Oct 2024 22:00:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C0120822D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730239205; cv=none; b=HlEFWLCUf405HsUfVfl80Y7DPUw4p3E0cHcCUEaSlIZIGZQkBB6JBCMBnwXYlUde7D2Jra/Vvj0UKb7nguTMoHKYFNXk1GvBDWNiu/afYtVX6YWG+YJX607whrQV6uiOGy9/30Q1KTcUYCpSRZ3+jfQPYbNKu58Q4SYhPSk5h6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730239205; c=relaxed/simple;
	bh=CYr5QeZ8SvEWA6sjlNnGEPjYo7vCN62NiCQrn95RsQg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GeyjvcMr2GD2/bQLkrZiJYXBkN42tSf02OMER02QSe1RHJIKoZYWpAujEnvZ3LKqE6MmA2ob8YpMNBCex1JvGZtaZZZtncQ+N0/wSkhayxGSv+RiwYmqi7RQFFBlFL63IHvsWqmuE36ncmozz+0FHBzJtAY/lr+NJ9dGohOfM0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3f7b8b116so2460045ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730239203; x=1730844003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IhL3wYBGuK2DxxRqfIHM4QyAvlx0F+wkZe3xZguvlk=;
        b=YccKPf55mAFX4AzKxqroAJjJOKfkwtYCJUCESV7PWuSPIjqGTFS3ihq3j6eB+dJ40Z
         Osmi6589TAoWYWgL9UnwAxlClaH5Ap+Plk+x3IroD5ZMVkkhLfEoBZm3zUHLXgLvbNxQ
         z4UFzQprP/VEkH75aRJ8YIzqVd8uPuyKl7nGwDQUzw6op45zbjcqRvr4uqi5BsUFZ7BP
         ZFUVUcJyXqfDAz4wSHGh6KJFv+27o3aI5zfWK4juQSabmfZqjPiFm7xT+DbsL2hrQpb1
         bGvWSM23Odr4VRNd1TdNQT5P0NJwxzkfSW1bLkVnMyRJLr/ItYRHy8Z/AQrEKCLUvmOt
         73jg==
X-Forwarded-Encrypted: i=1; AJvYcCUKv0IvLUpC2qgE/Cb+684Roo2DhG+LEn2LOEPJlCF+8KdvishLyB9o2meHwsq/pXNptBJmCEjebxzRBg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr7boQpfEqJz/Vgf9LyxNIKHn9B4oy+ehhZnpTcQwRhHMsnBu+
	RWS9CQczBmyo5VLW1tMhqpPn+J1A+KhYu121RjqIqUQoZ917Lh9QWeaudmXtcLNjJDgYkCsZ3YD
	BjtW5zZyyOK9WZi0+J1QbehrbTpucsETkQse0sZviHYa+GtmdgSWpRlA=
X-Google-Smtp-Source: AGHT+IEIDwF+LiumiuvOkSi9J6GWFcFv4dZv29MjYkHCppS2JDBS2kY1Yhk9ErM8YLSUnWGsIz2cwfyLXkYLP/mvYnzC27n20qrC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2e:b0:3a4:e377:d8d3 with SMTP id
 e9e14a558f8ab-3a5e3a0f7e4mr1963555ab.0.1730239203093; Tue, 29 Oct 2024
 15:00:03 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:00:03 -0700
In-Reply-To: <67215651.a70a0220.31b018.c8d7@mx.google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67215ae3.050a0220.24951d.0078.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_xa_block_wipe_namevalue
From: syzbot <syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com>
To: andrew.kanner@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com
Tested-by: syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com

Tested on:

commit:         e42b1a9a Merge tag 'spi-fix-v6.12-rc5' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1727eebb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35698c25466f388c
dashboard link: https://syzkaller.appspot.com/bug?extid=386ce9e60fa1b18aac5b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=168ff0e7980000

Note: testing is done by a robot and is best-effort only.

