Return-Path: <linux-kernel+bounces-365671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBC999E5B1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E31E280DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892431D89F8;
	Tue, 15 Oct 2024 11:31:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A417113F435
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728991866; cv=none; b=cCdy7daA3QqY3qMmg+f6Y+sDPwJ1qmGo65nTJV1cBxdp9Mj3U9xDwmpoVPivzZhLOgMpzaHO8vX406uIR2K5QuagCDdZY99FHPAgeILm/1RdYJBSd6G9RTzy2aYHIyg+ORlRGuZzEDMbVQb9HREoavFqCVY4AX4mZCkUCZaHpog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728991866; c=relaxed/simple;
	bh=lbMANV6i+vFbwLAM/G1QAPyKJ6sE3XA7EOdDQXG5nUM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uD+uEfibFscR/uXM5z4L+XvuWaYp9Fpcim9wB2ED3HrWCm1ULDAq+Gj91v5ZpCtKwl/yG1RMcx2FOaeJ0ebRkpllqT0G1FBGP7jVjFxEGKIlijCDUTVBMmynWybBYyybHdM3VvDfyP6a7wB21CLg9rB8Dt9c9By0F/7XhXVIKao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c70e58bfso14060895ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 04:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728991864; x=1729596664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+krgq/2z1Q4xwidgLSWThtCh/McBHQeyUArhpH3pCs=;
        b=BgjqlRE8HieYpySNMr2y0jalD9jFdEpgXt8AevNlcFILRnCX/VzRJVzI9iVsw+23o5
         cXwDeepuo310cDarLKX06RaDXWq7LnqPHVwZdFCLQi9xWjGHk/TUFmyP5rGv5xlOkrYc
         YokI0eCInlDIIlVclSEhxnzHaoDQHVo5pPhluX6m+/GRCSfJu904c4gyZUrmNGol385q
         wBGn0md7nejCC5hJBUpbVOU1qHQAyjTvlpDZpu4N4lcIMPtD6tm+EhJwYQjitOcgea5V
         6KtcBaCWf5Gm4h23Mt8F0As4Rk3EsxHVI6ormD3pHgU8MRXkRIAlbtUwrhnpvUU/we41
         DKCw==
X-Forwarded-Encrypted: i=1; AJvYcCXqI3zaTvKrJJXuCwsx4fEGFj9zz3sTc2TSYleHQL12UPkXCWZkfcL8s9DvNKzegOwFmY3ew1OKP+cO8BU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeez2eo3S248rSsO2t02a016Oc1pkPzdRinY5ONMEfrwSj7ah0
	+tBluo7qQfr/wE4phttN3T3I+oJz527eh3ll7O2rn+U7XMZC+jM6ppHefP+KPUz1EwAdQm6pWEx
	chWEVeLOlztHCnIitdLs3AGhLlItNOfNSewyYBQP9Ag8L6Cm2LHgd76s=
X-Google-Smtp-Source: AGHT+IGzaxf430CJXWqCwUwhi7z2ON7qpFJLdTX1WUISZdYLLmVfVNPjvQm2XMzGckdLKn7bV/Z7p0Os87fFoGjvguNJiapl9Vq2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ca:b0:3a3:35f0:4c19 with SMTP id
 e9e14a558f8ab-3a3bcdfe2c3mr68524175ab.21.1728991863707; Tue, 15 Oct 2024
 04:31:03 -0700 (PDT)
Date: Tue, 15 Oct 2024 04:31:03 -0700
In-Reply-To: <fe328157-01ab-4e51-95d5-957a1cc6362d@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e5277.050a0220.f16b.000d.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer
 dereference in read_cache_folio
From: syzbot <syzbot+4089e577072948ac5531@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4089e577072948ac5531@syzkaller.appspotmail.com
Tested-by: syzbot+4089e577072948ac5531@syzkaller.appspotmail.com

Tested on:

commit:         eca631b8 Merge tag 'f2fs-6.12-rc4' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1551045f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15af561474a22223
dashboard link: https://syzkaller.appspot.com/bug?extid=4089e577072948ac5531
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=142e045f980000

Note: testing is done by a robot and is best-effort only.

