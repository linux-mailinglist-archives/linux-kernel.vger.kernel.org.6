Return-Path: <linux-kernel+bounces-186179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92FD8CC0B9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D991C219A8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDA613D534;
	Wed, 22 May 2024 11:56:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E74757FD
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716378966; cv=none; b=iuNHc1I/w22ssZxB73NyWaic89lFjT1x2jiAZbdMVU1Lzb9R6bDyrX7csYFFqRC4zl4F4i4CUyhA3T7f7IABZkW4MkhqnLI0L02E2/WBh+bfnH6967UVUhjtTw3u0vLYxUuGj0BwYZwHssOvwwIEqLhw0ptMjMKCyc+wiXY2HpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716378966; c=relaxed/simple;
	bh=/uxNzhuEpEuNDt2jpdc27me5iRGt1/3VuDrhzDVcBoI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MB+xLNe+6sNrqulTxO4OUZQoVIs66kGyCNG0hTzJK9oKivYE3asRFLKI6rc/YkneIm5D5KySMHdQXjUlhxkCHrUIku7ARmFHq82TTzFMbh2prxXsOu9upnxm+qTReav2uP5eDSCWDIz6uJmBNogy1xmYOiARF0UaGfnXXep8HEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7dabc125bddso16754839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 04:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716378964; x=1716983764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGSGt5zkHSQc1VjNVftzodvlANt3bWCgcnLgMe4H7pg=;
        b=aj6cG1Zlv1Hidx7R6DLo53hjjQDrZpUR9nO/qe9RPXzmFwNt6ZL5I8stTIMvDexPx1
         lIJz4Wyj/q0FkbAHrRsUz7JXoIopINRyUPT8F0RzOJ0U4VNOboK0dgnMByWfPdIVXvlh
         pILPq4XTlFwWx/2LwD53q4yO63eG5wLLXNRfr++Fj+eWbYWDUmkHQ6RRlC4lfZLCxIaA
         GNebwIqYTHvkjQPf3ESjFqzDBFeXEu+2EXV/RHp8/XABmrdFKc+zJ45suxWSnII1j8v3
         2sYJl9xbK2sP8vISv1L4PhLrfadI4kJ7/OjHszLTlRDw9weM+NeROa6+4yc7SD/aJP+z
         ACKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZCZUt1OOQxNFrrZlKHMfDX7D9GwvTL76gvT1Dhs+314XyMHE/a0qi8QZkut4ytVCRCesWPS8KeCTPPWNZ3PThBlkvb/LoYFZJpNuX
X-Gm-Message-State: AOJu0YwCL5h24Z7qUjeOV7CbOhzA8rpWJEGbhOlzNESL1zkx/iw1MA8w
	uFohNWjjeD3N196kfcc7tzT5WlxyXJx++PZ56rfiXmxMb9OCDqGlJXXDatTrbn/s5nzW/YLcNNa
	3+0El2oTatV//rAU+VirY9l6eMf98/CVia4A/Rm3pEevHhOCUMFmRPF4=
X-Google-Smtp-Source: AGHT+IFaQR/wwwjXbBcPunurewHyTe2Ekd6xHwwWmKJKFeUo5uMbGdlyh35IOS3lAzg8WzKW5qfXqTcnk2nIT5Tm0aLNAO/iYIoN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f87:b0:7e2:2c72:c60f with SMTP id
 ca18e2360f4ac-7e39df9d37cmr6970039f.3.1716378963666; Wed, 22 May 2024
 04:56:03 -0700 (PDT)
Date: Wed, 22 May 2024 04:56:03 -0700
In-Reply-To: <tencent_7BA1330A9E431B2B4B071B6B2518BA37BB08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006df71c0619099e75@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com

Tested on:

commit:         33e02dc6 Merge tag 'sound-6.10-rc1' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15025ca4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25544a2faf4bae65
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10592b58980000

Note: testing is done by a robot and is best-effort only.

