Return-Path: <linux-kernel+bounces-236205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E555391DEBA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D961C210BA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32334149DE8;
	Mon,  1 Jul 2024 12:06:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707216F077
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835566; cv=none; b=T7/oQ8Au5GIxkDmhY1IZF8aDysLco3AntqwHUxrwBdXy+tAXGLALpNw0UgfTXIFfJuTpu9Ey7/OMaw3CLcW+qwEggdzzVeVUZdA2YHjLzlszzF1dMFBqcoK+Ei1Chgz33H/a7eCQ05nvzivyj5iBbCqkA52S00bV8p6Nn3QJ2yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835566; c=relaxed/simple;
	bh=BvZsNB70fxhNeFw1zbn79XcoYQs60rfka3E5dZ7T2E8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Nlh6Tf9v/btQtlc56NJZ30BrCY/CkpmXTVy25VT2KpxHwNZjY386JlFC+b0B4kRmRaBz0YQAi+WJbp/7WHSFJfxhvBRozN1j/J0E+qnv4xx/1tfswIC3y8gKfw6Rvrbn5GauvOKGsXg0Cbi8mAJu1smj4MHl/albJVct4u2npNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f439f51960so367086539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 05:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719835564; x=1720440364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5PM26cv4UY0Scv9w49ZqcoPyvc6Ja9WnVMYVSvpLBjY=;
        b=TFKg5C45no0XoEGON1uezY2Irov1kmlr1sREpHzhyKPwF58oZBoJZ3j5GSPEFuT+rq
         TZF1DNqeVBMwminaUM6qtmsYUsy8K24KVkZ/m/2QBULmAos0G5P3rTuap2YgW3lWao0n
         j8MNTW7scnzxZ8hQTAm/b09+q9eZSJ+55w6uoY3YIW0EvehJamr4hpUQo1VW78xm5dyD
         42WBZK9ysnq9wQQNJ+8eIOJLhVJEPbyo2uE2ri5phRMMGakop1V21pHhlgshN6ay6IsF
         pUW9N5i9KifOT3kYGy0IgMGHHStScywl5bAwG9ujRB/NenK1qedR/ktXVTLtk96VXUhV
         Whrw==
X-Gm-Message-State: AOJu0YwhglpwsMPHPe/uCFSRdxes608hjm1rKG0wYXOgxyhhNHbZSRLK
	jjoDZnFeNjrCqmNjXTjOPEX01eXW5enVjqfUItfKy966ZY7LvBKWbDhUVMF1ogPJH5lISbn9KNU
	/q1diVGxT184kPIKqzCYbvFd3zFnf6DEIUaT3KBmNyfBxaVllZd3JZ2Q=
X-Google-Smtp-Source: AGHT+IEh4YhO0ycmwjEiE7ldvbsuzMAr3r3ifHXnkoceUnoBjz4JsUQI9z6R4B1h289rj1PDxfstEHs06kf39rjb5WjM2WqhLzfm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:641c:b0:7f3:9d18:8e7c with SMTP id
 ca18e2360f4ac-7f62ee11b40mr47717839f.1.1719835563193; Mon, 01 Jul 2024
 05:06:03 -0700 (PDT)
Date: Mon, 01 Jul 2024 05:06:03 -0700
In-Reply-To: <20240701100153.10990-1-wojciech.gladysz@infogain.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d10874061c2e6b2e@google.com>
Subject: Re: [syzbot] [net?] [bpf?] KMSAN: uninit-value in sock_hash_delete_elem
From: syzbot <syzbot+c33bff5d5da1391df027@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c33bff5d5da1391df027@syzkaller.appspotmail.com

Tested on:

commit:         e478cf26 Merge branch 'bpf-fix-a-couple-of-test-failur..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=1398c4be980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2599baf258ef795
dashboard link: https://syzkaller.appspot.com/bug?extid=c33bff5d5da1391df027
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=123bb5ae980000

Note: testing is done by a robot and is best-effort only.

