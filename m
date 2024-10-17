Return-Path: <linux-kernel+bounces-370153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6161B9A28B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9351F22D74
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4AA1DEFFB;
	Thu, 17 Oct 2024 16:26:09 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ED15FDA7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182368; cv=none; b=BOeGYm0A71UMHkhhfeh8k6hI046YsDhHXP3hdt+xhmHQXHwhrsMNbYcBKUC7iNMlyf9jAgiDyMju1S6Kiz0s9WcZXHPiKi72Y7BD/jKzQ/+XomFPf3zJzEZrya0tk2grAlJy+161Ejm/ggQMMBHPKuviVOiGJ099WqV7PAoiGoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182368; c=relaxed/simple;
	bh=jZqYaASwFN5pk61821GxRntzutfBJW9ngXWf/RaygdY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BMvwVzO8utU9nfP5PZeyiQgg7WgKzFbe9atYGVGJCn9ZwQBzmP70YAQnUQWvlExpER+BHn02gKfUB0aOfww7wcchq5du6aZvnsZHSBn0SaJBsy1mOm+DSE3bufgdQ1ipEa2Cl4zsvztrYzq7cEE6H6dYRdrlxu5Qfk41RUZSKlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3ba4fcf24so12413115ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729182363; x=1729787163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSQfMl7wT4AnTkv3ptUGBPCOzzIApk2g7ikdQXHIvow=;
        b=UNaWLmodq8aAvl7gGrYPGerxV06nOEBW7/jhEwBV0vwsiKUlrR3+cY8ZclU3M3e0SK
         vtTLNMevegtVfRLCjsmfLYBAkYD/tOWo92gX2id5Z/R2LYZtMFNeFcvuaUySwex3go/5
         LiMyCYO4kshrrqXhnKToIFaThdOAuqrdhwJfoblXBkN7a6LzdDfkqT4jUEn6E86DPpsJ
         Rntkjb7b/RQsAU68Je3Eb9CcYux53iu9rw22hxPe1ieU8vS4jer4yC3FodEBfwLmq/1A
         SHeL9MW9Z5scWX0Tni2mJsEHKa5OIGxxGLorSXAM3ST0gofBhi843l/skrl0iAetmGz4
         FEzA==
X-Forwarded-Encrypted: i=1; AJvYcCWIZWl8F8hq8Lf3C0QwddRS8e7LmaxZ/PA1C0CI3lig+1z1eU426emdtNJyY8Bp/YdnpYdtupaNtPmeboY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+r+w1jhePhdKWk4yub8eqzhMydjDuRgFb9Deg7CnH7OKEEqha
	WudQSq7nVWaYmVYBFOn7rVVguZbU92Y23pA+WzIwWs3/PH1Ne4neAWolJcGf2GFBQG09y9jSOpR
	j/rj/yJZwlg35KRbq9kmm0J0vB4njD024wUZ6rIh+6ItQhz+lfDXTSEc=
X-Google-Smtp-Source: AGHT+IF7y5MKwXBQUTu9GbAEz+WyJ8+G0m0XYKlsG6Ufoicqpa8oE4ODgBcZfwwrzTeUwnIBYlq0cnDOMk7hmC9wpxJF//LjrP6i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2163:b0:3a3:b143:98 with SMTP id
 e9e14a558f8ab-3a3b5faabf5mr183255395ab.15.1729182362911; Thu, 17 Oct 2024
 09:26:02 -0700 (PDT)
Date: Thu, 17 Oct 2024 09:26:02 -0700
In-Reply-To: <b810ba13-2818-4fe0-aa8a-758fa1057267@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67113a9a.050a0220.d9b66.018b.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] kernel BUG in __block_write_begin_int (3)
From: syzbot <syzbot+d6ca2daf692c7a82f959@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d6ca2daf692c7a82f959@syzkaller.appspotmail.com
Tested-by: syzbot+d6ca2daf692c7a82f959@syzkaller.appspotmail.com

Tested on:

commit:         c964ced7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14592f27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbd94c114a3d407
dashboard link: https://syzkaller.appspot.com/bug?extid=d6ca2daf692c7a82f959
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11088240580000

Note: testing is done by a robot and is best-effort only.

