Return-Path: <linux-kernel+bounces-239077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFD69255DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8781F266C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE7D13B592;
	Wed,  3 Jul 2024 08:50:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0A37D3E8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719996604; cv=none; b=ECNIppZJ2fnhHtDaPHH+8w+4dw8AAG7zBmWNAo28zVgXZ1o4mCxz4C7sGfg6gVork3N2rfXDH2O3cItwuC8SRf91AilbnduYre/dOvsN3oIz9qYVjqSq7USXPz9mLTSmBb400DRW1h35Acg9REByT0thu/7T5tY4mZr407KC0cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719996604; c=relaxed/simple;
	bh=0KmqXJIwas465Pd6Ig+he0rI84A+feRQYx8yF/KG7UQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gLplcjux39jTd7bWHMDOtDLTeBUY3QcRhhEYjs2KauOAKZV820UVyNChPACnJAo2AOIL508EfuhfTc2R2NNIGLKk2jhPiV30WJuN+EQfUc8t6ohJZzwqVkCD2rkBGon1Yqb3u2aaotywDm7YdLCr/Ur4t32dxZtBzbxAC2cxJws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f3d5b154f5so548702439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 01:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719996602; x=1720601402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6EFT6GO8Fnbo/i8FyhNtvwKcBJKjbKjsOZb/mMNeoII=;
        b=LCHwwkuA+MHvmHvw6Mpg6c2OvsnO4Nc9OpV7H32SJMQr+On9HG2TLGb/goEHNdrEHd
         CfalHCGDJg2omc71HP4B55fqD0PWa5kdSp5barrPZilIF8G8Wx8EJbledo3jef3hgRPy
         toKt4/l54q9fLDWVqM+JH6srHhBvrYKTIdi/Exbo3EisQa9R2fW9I2e88KnhXAAKOCxP
         Oj7sqD6twAg9TLa5A/upshtZrS2rXz7bI7ZxlRuKOrd22RtNMt/VobV94IKCI5lHe3q0
         yym418/1PbbyQhUB4zOOck3UjhFjL2DhhpQadNE7YWCaEfnZqO7mtzjvxCQ02wZ1Btk9
         jKZA==
X-Forwarded-Encrypted: i=1; AJvYcCUbqfmb0CAVPzXIFQoQ9WM7BSF3/H3r9eXgeHWSEVIGPu5gH8qKBekJO+kyMou2X0LbDP9bAwFiUIC4qUstQG1ZFP2qUOi1fulgXPax
X-Gm-Message-State: AOJu0YyYWV3ZmskMwtfzpffkisSJOqQMgEc5CVx+4rwudN5ZK1n5ebGK
	/gZCDC+YpIfPoRG8cZ66MjFqfs7tgUecGmrwy0jdgz0WZoh7C9oEo+o5weYVpglHXXuVX52m99K
	O3Wt/b2v13cmGozR4LMAh5V+3IVzPo4RfrXG3b8DF2gLNylHrV1q9XhM=
X-Google-Smtp-Source: AGHT+IG/FQ6e15TxuL2cn/sm4lmiOxZphSI5Cl7arOGZ8/cpm4rP3OBlA/YD+/9c+bnYARBVpaMTmq82175KXH8oq9eqAz/ULJ/4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2103:b0:4b9:2092:c7c9 with SMTP id
 8926c6da1cb9f-4bbb6fbf587mr687696173.5.1719996602576; Wed, 03 Jul 2024
 01:50:02 -0700 (PDT)
Date: Wed, 03 Jul 2024 01:50:02 -0700
In-Reply-To: <CA+6bSaugC6skN9XBTqnfOZ4n8zep6+D44fwxYFE4Y0KbBREwSw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000831ef0061c53ea31@google.com>
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in ext4_move_extents
From: syzbot <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
To: bottaawesome633@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com

Tested on:

commit:         e9d22f7a Merge tag 'linux_kselftest-fixes-6.10-rc7' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ac84e1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b7408f3dc4fedee
dashboard link: https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a0a9c1980000

Note: testing is done by a robot and is best-effort only.

