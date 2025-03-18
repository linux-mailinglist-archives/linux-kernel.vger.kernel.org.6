Return-Path: <linux-kernel+bounces-565977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBAEA671B2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E47619A383A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D48A2080E8;
	Tue, 18 Mar 2025 10:43:10 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB72F20966B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294590; cv=none; b=CEJ4JAPNJHzIPOpgrIinR+2svsYqRQodX9H+3GVocCSvQZpyBdh58NuUAyqeh6E4JkpZjYHPZnthtHgqthApVVszVrLMdd/AoDNmkL/mlP5ifd2apbSss2HD28P5mjY3ylU24/OqCHN+eBHT+kbW0Qkkvi3JpNrMJS7qKffScaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294590; c=relaxed/simple;
	bh=h/yR1izxvHKATEBf38IQTms4KD4sEfWBa+m7Q7F0MXg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r3Fs3MDW9gFiBFTIMlVLsbxEhPAS2ieRt+Uc8oF7P5OcdQiUYEPGJAkVxo/iyk/cfzbJh01nw87UQxxuiIoAT9wMJpm0HsgL6ANUo2qX81K9Hm3Cptfw5VO7+4rlXXOPy7Nvuzphj4RMuS7sE3A2q8iw3GtkwnYGeaDMp2Hg+3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-851a991cf8bso556706539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742294584; x=1742899384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T007/HEqle2rRgZnfvEehBiwKgMFtIfdqKP3NTZAeGE=;
        b=Oyea8ed4FrE1wFPbCKy+BBUsJcoUiNjtSEeyo+UCCgs5x+NDHiqqkev1qjBlGDdiuf
         mcrkuuz/nmn+y9NjfeW9o+Wc+Z6EQjm8D4b407byisYPI6Y5kOb6BBtN5MmucAjhvAoe
         sCeI6JU8IQk4yvKTToGJB4ByJLMuDyakbqf59N18SpJdO03AMYr4TIHKad9VdqrbOlVs
         wNhYxy+eTefvBo3ING+KlKW1SMX17h9tDLE9JuAmjuW9PWuDsG8+g+Rx2zFdQ7jyfTjC
         +I984UrNf0dDBvQAtV3LMGg70KRBoFzR9jWXTRh/bMXVD7c7wEjryGHc/GELuNvSOVyD
         D41w==
X-Forwarded-Encrypted: i=1; AJvYcCWrKFQooy2DFc4vj7t5JTp3k2reEaK1MKp517o7wJHmbe3ft7Iigachuq9CFed2VEiilG74lwDYs3H3Jvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMIztrbXY2m26LH7vqcYK5C2vlBfXefw8jK6qe61WmiqFDqWWR
	2KLLpo68F5KwfypWrizhRT8kyCzxrs8elzXheYaLfawdkwX2+W4ACnvoMir+bgDxyw7WtLX637Z
	RDgBtN84sj3tFZ1gNgudowfM1LQB40Jh14kDRO3SUrzQ1yIAUuKg8w0g=
X-Google-Smtp-Source: AGHT+IHAyYQyThrgYUqxHvUgNtBBqDHM3D+l6yPNH+CRaesYx/iGfbJPUFVs0RlwaE20dtplSMSxL84KIljthWA+II55hfQjKd9R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170a:b0:3d2:ed3c:67a8 with SMTP id
 e9e14a558f8ab-3d57c1c33dbmr29225835ab.4.1742294583838; Tue, 18 Mar 2025
 03:43:03 -0700 (PDT)
Date: Tue, 18 Mar 2025 03:43:03 -0700
In-Reply-To: <2477988.1742293427@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d94e37.050a0220.2ca2c6.0172.GAE@google.com>
Subject: Re: [syzbot] [afs?] general protection fault in afs_atcell_get_link
From: syzbot <syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com>
To: dhowells@redhat.com, enjuk@amazon.com, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com
Tested-by: syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com

Tested on:

commit:         76b6905c Merge tag 'mm-hotfixes-stable-2025-03-17-20-0..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164d45e4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e330e9768b5b8ff
dashboard link: https://syzkaller.appspot.com/bug?extid=76a6f18e3af82e84f264
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1184f278580000

Note: testing is done by a robot and is best-effort only.

