Return-Path: <linux-kernel+bounces-426506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B23A49DF42D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 01:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C8DB21118
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 00:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983B823A6;
	Sun,  1 Dec 2024 00:11:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDB6382
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733011865; cv=none; b=qGktmtpFlXHLc5PGk0Zx1D8B2/tnxobX+q845rhLW3IyJHuyOuuTapL4UCOqxnw8tDiQdIJkGBYTEv/zEjJ+YuFTo+KxI57P58H9ftdfIgKq3kPhte5Su/I/AJh8KV4rlvPHpivwnjBB+1VnxrlwTxfiiY6L5oivpaW4ivfkXWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733011865; c=relaxed/simple;
	bh=UnACCVA7tlVE0+snJs6hfFSd9q31mo6Bh2V0d/9WTZY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TkGgFVaS+zcky364twpQ9seqMzxzbKgardTbTZSjRoKAqkCqADp6iO3kF3N+0KXHKNxHgYFhmkzs4rSkGvVZ2xracLCC6Zf0xL3OmgC5T4dWoeCJBvys3CrogWMpNJJ1jZxS+xnLXwCFb0q3hRpFq4mNX96Z84N91qN66+Liy2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-841963a1fb4so277498039f.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 16:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733011863; x=1733616663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LIUUZTeJmZPeG8SX0991wAnoGzqpU1DgWIAyiJ4/+4Q=;
        b=xE9secSB52qm6eHCEKFt6PrPq+3kOnjUrOB+7A6PmVidPdErsQKuSdHSAdcpQRUkMh
         VC1XpOIO0mZk0+WPwcI/MKFDxN2GDDuzyXCd3OHm746aBtFtEp4Oi7HPVEemUXIKPRAc
         MR+37rTmKCPI3wax8bjod+vorLxAJQYrZdmNaYoMwqvgfK/As8xPAevn63+FwpwV5VJu
         sCUT+EnUOi2kTSsc3BNqj/9Ut26GvGf6O+37oD2B6lh4L8ISpnicuaMVWEvkg8fv09ue
         4gPSlOYQcbo4DoA1yeKSXc7VnAfqfS4Es+WnUJwWqJHmAiCr+fCLaMbcG+eac9g6xsVV
         +DiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAK6ppsC0HcEwbIvxYazt5OomW7P8soLf94QO2RA8ZPkDnsLFOtpMj/cFyj9Kv21Y/enI2m6AmD51HYR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIdmBTTfcc/s47moqCHdAsW0dA1p+l4RBgpZEijs4UpWIdiXUt
	pmWFeveVsIHfsayDmM8ftd1mkeKFRDRPzfpsbs92oAQftBnQEPgcjg0BBm3orMmA52VgDswVaP6
	+O0zHCRhGu1PnhNs3nf31I8UzjNYJGsS8Pgy3Vz9w74F1dT3NllyTsT4=
X-Google-Smtp-Source: AGHT+IG13qg4YGnamlxKBNo4M0YAZ13YlT7S2DJYFqwTqU+6UUSxHU9xeLnGlTqgpnCs3Zo680wJlcaOZX3SmT9ezGeM/8L/4Vcz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190c:b0:3a7:6a98:3fdf with SMTP id
 e9e14a558f8ab-3a7c5580ea4mr170467365ab.14.1733011863168; Sat, 30 Nov 2024
 16:11:03 -0800 (PST)
Date: Sat, 30 Nov 2024 16:11:03 -0800
In-Reply-To: <20241130231432.2296-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674ba997.050a0220.48a03.0000.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in loop_reconfigure_limits
From: syzbot <syzbot+867b0179d31db9955876@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+867b0179d31db9955876@syzkaller.appspotmail.com
Tested-by: syzbot+867b0179d31db9955876@syzkaller.appspotmail.com

Tested on:

commit:         98c00f3a blktrace: move copy_[to|from]_user() out of -..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-6.14/block
console output: https://syzkaller.appspot.com/x/log.txt?x=121205e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=131aa7b77993ec3e
dashboard link: https://syzkaller.appspot.com/bug?extid=867b0179d31db9955876
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

