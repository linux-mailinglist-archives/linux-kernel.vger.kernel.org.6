Return-Path: <linux-kernel+bounces-408871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2216A9C847A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD7828521F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2B01F5858;
	Thu, 14 Nov 2024 08:02:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30CB22611
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571326; cv=none; b=Xb8QK457070jYl6rJo/2RqU92zd2HoIHkJrj8d01gGLooiiF1ordd1qr4TU0WOVxBPiPzJfT8POVsex6yunV2ylMgpfn5XpkO4hfL9y0j2Kcycxtz+tRnCtxU0kNdL18mP/wEhfn5fP4M4OyuOjt1obeBCHAv83GPis7oSt/RX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571326; c=relaxed/simple;
	bh=WDYvRyvAY/tAXN49nAqsUWcZFM7exWHCT0vfyMZ+y+o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qWYfxajce+Euk/nWA0FhF3IEbkEh2weFewZzs7JrxD69Z3Jp3kqUEqWSy+o+toiVhyrcPXXppdtopY2cWMo1boiVoJeI0BanfXvi1pTHD8QZDBD40OeFRDjHgJV2+xn/pv6G0vM6S+zZ88qWmzDk5BYhUrqDO8/sjE2286jA5e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c3ecaaabso4933045ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 00:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731571324; x=1732176124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8C63pbKikR63X6q6+ORA9DKphbwUzHq5mk8VFFXiUsw=;
        b=HJvRmMqz4BduVd916MxtbW+TJPhKfIz52W2EV/spbmNbLGAV4pCU6u3HjoFq4n79PK
         IOSRAXUfhqDn29sr/Wi71eRA9tqBK/k5WFvPLYj6MvBykfImroEGaF6uyJpnZvE16CAJ
         I8C57pWXr4BdELzYoV21U5+mwJuODaOWhSOuwfBmfuALkHJHQVuV5XOtW5C5dOz7qNh8
         4z9u1OThDWFOKZcNgrxwMHd2KTfCeS9W2n+sIfk9oktKhrlXPRKF+mwJt/4SJu1Z939M
         3K1BetF8QZ9mASTNsmL0DFXNLlK9paX1ekQ+ijZoHCePh/8svKg/54s1UJATRm/kiGSo
         OsLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAEG89K0YkTmS+QP9iXQ7N9yutURJnasA8XPyfjqDHBrdp9WJWvYXkOVqAisPL3mjQ4l+iOa3YMnV6zVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmWs0jwa7CurjEJc2FWlcVlK3Q52wUnFjIqKgRFED2aWEdmMbS
	iFqAh8VTgEaP8EzPzgCoazOOg1862UvSLYmUdI2gI/RDLxpeGFtDYLEALyL7qZsjrW369euBCVV
	RlsxGAetzXxPRSGQXFqC7e82KyM/CGeHWj/5EV9L0iUZyS2LuRv83mws=
X-Google-Smtp-Source: AGHT+IFMpWZcx+0zhMSQ3Us2BSh/ewkyJpVdS1ZdtuSj9SMnbIniHzoXXMPL3xV+GDa31wnprCTKYAnm6OKxcdwCSLemnZBi291f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c265:0:b0:3a4:db10:742d with SMTP id
 e9e14a558f8ab-3a70c7f9043mr102731865ab.3.1731571323821; Thu, 14 Nov 2024
 00:02:03 -0800 (PST)
Date: Thu, 14 Nov 2024 00:02:03 -0800
In-Reply-To: <20241114025937.MnEIT%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6735ae7b.050a0220.1324f8.0093.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_set_new_buffer_uptodate
From: syzbot <syzbot+453873f1588c2d75b447@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+453873f1588c2d75b447@syzkaller.appspotmail.com
Tested-by: syzbot+453873f1588c2d75b447@syzkaller.appspotmail.com

Tested on:

commit:         0a9b9d17 Merge tag 'pm-6.12-rc8' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12eb4b5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65582325943dbb6
dashboard link: https://syzkaller.appspot.com/bug?extid=453873f1588c2d75b447
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=105eace8580000

Note: testing is done by a robot and is best-effort only.

