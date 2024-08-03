Return-Path: <linux-kernel+bounces-273295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E39D946701
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 05:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2919A282103
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 03:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14828CA40;
	Sat,  3 Aug 2024 03:14:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD2311725
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722654844; cv=none; b=hFZOCm+B1d9Cpw8lbqie6LYeh044filjz/mVeW5urYFyt4aDxy6/fjZn73IMTkkaUUxY+VQ3xltz/FpZFmXDwDFjxh6Ot53XV5j7tjXvbreWTKf0WYka61MPI5FbHckUMm7mIB91DZ+H+c4iUopVStko6C3ZhKQXz8ObJFKoWdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722654844; c=relaxed/simple;
	bh=VsaNai06oj6YT6civouxKbGBTjW47jqM21yC6LPUweo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S7OjhVRsxRBgA3wakFrwMLme2Wxu847rCMrxbP/y7iy2LzxqTf61ZQucHbrkVS2f1wfT8PDpneZLt6Y2JAFT5GMBAm3F311y6aa/Z3wLtkOsy7C7XxMsuobBNXkbdnRn0hgHAa53HhbkX8+so9vStIPLjldDfFl4+DKve3nibac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39aeccc6479so119705655ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 20:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722654842; x=1723259642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/bQ5yNZ8dwiFZq2DW4vqqKfsJPE4w/fY4rbOwaz+NA=;
        b=HcbQZ5Q6JOMDkxsk0o6FOKjyV45eN6SRnLDQycJK4xwzv+NLit73lT65f+oMLxvtxB
         E24DU1fIwY4fvNP84LtsQ+VNDGVp4wlHJ3HTg4jEuDzYSm8THNmStXwjeNr4gaD006B5
         6fEzfWM+i8mqC5lMVoUjTyOfMQcj+vBOrPWxu+xbeuuGvQls6EH/au5LEMIRYEqOb82R
         YmjlOvogQOKV8i/Pi7IRU5VmCi9Rhuz5bjzSPZyCIZhBon2/Zy7ZW+yGKykHp4ITHZpm
         0xyewmGLb+Am7C0axyej6E04a8bpHiQwzJ4FwPj22ofJGsucbOWYOd/PUpPa8S/twgTw
         Qikw==
X-Forwarded-Encrypted: i=1; AJvYcCVyyGdIUo8AcJos/kbEgshyPbMIKNn9f9kFr5Okh7pgT0cehhhrt1qQ/08aok7aMv0WO+kwHyxLlYipi6r3kvEMp1QHwVGCAexPZhcJ
X-Gm-Message-State: AOJu0Yxl10wXAE+kuTE9iY2nB55lTCRch74KTc4LMWlz4BRC9IBC/zJa
	moIHrKsYN10i9X8o4WTVmFLt2xm78f2aslQ6mKpOLoqSJ4CiuYcoIe7zW3capHUSRnu1ztep6nK
	DmUYDSwcJG1bwhn+eN8BoZHrFnIIJG/AzvncPJ/L/SNk3rR98CDjZZ0M=
X-Google-Smtp-Source: AGHT+IEGFx8No2Q5aQX8591NyBh1V6G24E+F8EvYexl2Z8V8DVWE92cVXWRMibu1xYu5xAGknJJvYVtNgI6jA220f1ykqm/sGKN7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c9:b0:374:9a34:a16 with SMTP id
 e9e14a558f8ab-39b1fc6891amr4026115ab.5.1722654842415; Fri, 02 Aug 2024
 20:14:02 -0700 (PDT)
Date: Fri, 02 Aug 2024 20:14:02 -0700
In-Reply-To: <20240803024329.2596-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3ff7b061ebed57f@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: stack-out-of-bounds Read in __show_regs (2)
From: syzbot <syzbot+e9be5674af5e3a0b9ecc@syzkaller.appspotmail.com>
To: andreyknvl@gmail.com, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e9be5674af5e3a0b9ecc@syzkaller.appspotmail.com
Tested-by: syzbot+e9be5674af5e3a0b9ecc@syzkaller.appspotmail.com

Tested on:

commit:         931a3b3b Add linux-next specific files for 20240729
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14e78d11980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91dc4a647da4c251
dashboard link: https://syzkaller.appspot.com/bug?extid=e9be5674af5e3a0b9ecc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10936c7d980000

Note: testing is done by a robot and is best-effort only.

