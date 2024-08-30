Return-Path: <linux-kernel+bounces-309092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAEA96661C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB93F1F215C8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A14B1A4ABC;
	Fri, 30 Aug 2024 15:53:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C164DEEC3
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033184; cv=none; b=GwjlZ+xqZhyeXBT8UMvR031zbak7D/q/ULKFAyxRdWgd4mHwOmNHhb9ulmO0sIJhQJesO6CwRha8+QUcQFPJo9uIXi6LyS0Py+zIzPvzyIGpWuErPI+qPa4DpUCetj6LvnvjZ029vJ+qULW+HrMnfW40yaPEdxWxHXG3SEKJHIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033184; c=relaxed/simple;
	bh=RueS7JnGk0i21951pS8Z1lfcC7Kbynif6BpXcfUivBw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rNvIK5Cv7BCX/xXpSFDkNl9kg7C1qnrgxb5mnmXykhQdXbCeZjS4ZcejH6y48FFieZPE3ZkEh0m5uZBqm+WmpgXDhGwTGXK/2QZKJmWihRyKshg5XuG076Kp0ctmMMDjJQJIhV/HXDHX8MEuGkPA4fM3AedYC4pkrrjTmuI+Dl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d55a00bd7so21851875ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725033182; x=1725637982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJXna8UgM/TDpAaQDndMkHe5nsCGxVc7RnSON73+sAg=;
        b=M0zJNPnBBF3vVSTB8gCw56Og0BqW0WNodJLioP2d6H8IHa35dHI2NjQHHwBHNcXDI8
         f2azY9CsRIH5SAM6i7DXvLdj1wKXshghTrwQ/7B/3zheioU+PeQFbjtmxDKLkXja7UrX
         3RklLomqj9YlcbzMTWi+/UehJOUXfawcW4aSJXOvn8ftCJyEwooHgqx2/uNmyf8JBXUG
         nLiD1UDtDqEik8SMtDvxrpYtaSqngVxmF7HHFpJbUVBH0y5T8Jqk6B1oSBdV7qjtwLDP
         o52bk1hpuIWcFsQm4VELund6lseMrkGxmsnfqnk1+v8txnp358jSqkpM+CBs8nKf7Wu9
         GjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8qrTKNLCqIVTdKQtXUGOCdk3O27p6EDokDUAopDAdbwcXwiq8qia4tuZuTXgv6vFAI+KH/Ac9tJva3vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn9UnWswGK3K7USDgER58JoSavQmyx14BMugNNNAOFiItk4ZgJ
	yjAngrc2A/jVrclVwUD9XpK3s02c3KdvfLXw4wQyKDpUGVL2CgT4b0yewYP7Bit+KME188ETDEZ
	tur+XXmTzG/xTJo2wpLt14ZqePPwtyhNSMbQjR8dPpcsOfB5oUWoA7Uc=
X-Google-Smtp-Source: AGHT+IGPpVlc3Cxm6Tux+LHq6e+MRTFLxLn/5DXrJAeoqCb32DWphMPOMPxIk8n+X7k27SklSmmZR3EaWfZ2PeBC8hU238on18Dk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1986:b0:398:b1d3:7c9d with SMTP id
 e9e14a558f8ab-39f4108d9c3mr786575ab.3.1725033181727; Fri, 30 Aug 2024
 08:53:01 -0700 (PDT)
Date: Fri, 30 Aug 2024 08:53:01 -0700
In-Reply-To: <00000000000040b643061ca951fe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005da6a0620e8961e@google.com>
Subject: Re: [syzbot] [usb?] possible deadlock in assign_fw
From: syzbot <syzbot+e70e4c6f6eee43357ba7@syzkaller.appspotmail.com>
To: akinobu.mita@gmail.com, akpm@linux-foundation.org, alinde@google.com, 
	dakr@redhat.com, glider@google.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, mcgrof@kernel.org, 
	rafael@kernel.org, russ.weight@linux.dev, syzkaller-bugs@googlegroups.com, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 4d0e9df5e43dba52d38b251e3b909df8fa1110be
Author: Albert van der Linde <alinde@google.com>
Date:   Fri Oct 16 03:13:50 2020 +0000

    lib, uaccess: add failure injection to usercopy functions

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132abd2b980000
start commit:   d5d547aa7b51 Merge tag 'random-6.11-rc6-for-linus' of git:..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10aabd2b980000
console output: https://syzkaller.appspot.com/x/log.txt?x=172abd2b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d76559f775f44ba6
dashboard link: https://syzkaller.appspot.com/bug?extid=e70e4c6f6eee43357ba7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ee2b7b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177c7b7b980000

Reported-by: syzbot+e70e4c6f6eee43357ba7@syzkaller.appspotmail.com
Fixes: 4d0e9df5e43d ("lib, uaccess: add failure injection to usercopy functions")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

