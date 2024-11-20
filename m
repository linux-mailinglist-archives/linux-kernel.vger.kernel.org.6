Return-Path: <linux-kernel+bounces-415647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85929D3952
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F072B2ED2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0505119E7E2;
	Wed, 20 Nov 2024 11:15:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF1719D8A8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101306; cv=none; b=QPlTuCDIc/QP9zYA5QNQlwoCnULJZXPEKymYL9BFjkHUvWB9x9f380Vw4EHXy15e5TtG8gGeCWn+iLk75PygMKDVspsFls4AGYSXnZUxbKfw3yma+bX8wrLu9ZqKjENo/HXGUJq4iWKFGJN6zKvb2qCud340gcxOYmZ7R7hjlTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101306; c=relaxed/simple;
	bh=EEgQz6oEZVSbRIyoUnwgZi4PoVPYKe3HRFDJNq+gyJg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u9TKSPiU4UJNQhXMtx6+x7ZbGzk7ad1UbJ46h0jWP1M/rWfzsE3Lk9gsKWdGWM8/EloiXSfLvMlEZmoG5VZnetPupiBFA9XKbXT8KlTiosMJZ8zmzuBssC22k0YcKaFUfP4mdDrlsKMzhOpYwmBo5n+PkC3ByVWegugZZMOBslg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83ac1f28d2bso217738039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732101304; x=1732706104;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zq4gyqxmIIsL4eL3mPm5xdtNCsgKf8h/v2jT2n7LX2Q=;
        b=X9mU5HdHatXJkx8LJHcXp+RMerw50rpLCWb6ZtN7CC8X4EYz1BzVKO/M9Cm6XjBdjg
         Vm6CRALN3CUw/hlHQreDDe0et6K1ox9LHqws/qgIM3xBagVD0ywzbWepGdg30w2UcrRZ
         +OdsDxzPSb+0+qXWwEcZDdjE664uP9btsRQyc/gSjlsMfvWd6dkngwrAZmkd1a4OhI/Y
         F3zHHUb8tkZrnYVWfxXhjGXsC+yDNTOw4GP7e8S4Z8xuKhrAZ4C7QbEWQOigksjsqWiE
         NESwHF3W8YliOkDx6cSJ+b1bQXtxRWov0MKnaXA/9vkK9Ab1SIGEhEfWtsii4VIBpDLn
         Fu5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZ0lm1uUpH7HqERb3iySlXR6paVWCeAtXeGRqUf2ztq+JqpWtgeRJahcf4vELQVY0N4Bt+bSnV546eZX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKGbUvlzsijFNkJyhBJR2Ue2qr2OtzwrPkw6P7gvwTECPEIRUT
	6OTAgVK0oeBXoAQ+ryBi2f5AfeBReoSJbIgMK3H6oGg4LwyiavwbMieaFHHqQEju28gV/f4h7GJ
	mkCDuTW8pK1NZ2l5vZ0luX3mJmyN+VZLQiIDnKgj6AUOC9zv3Nit6gV0=
X-Google-Smtp-Source: AGHT+IGJYCxMIQmN0zoXOSPoeBsWXw+nVOdAvWLuTncR9FAqxJw6x2GXEzmCY3OBRfzp9ek2AMeoiR9yj2j0yCGZsBY4NDumgCuI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ae:b0:3a7:8270:4050 with SMTP id
 e9e14a558f8ab-3a78656eb7amr23669565ab.18.1732101304185; Wed, 20 Nov 2024
 03:15:04 -0800 (PST)
Date: Wed, 20 Nov 2024 03:15:04 -0800
In-Reply-To: <20241120104212.1462-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673dc4b8.050a0220.3c9d61.015f.GAE@google.com>
Subject: Re: [syzbot] [keyrings?] [lsm?] KASAN: slab-use-after-free Read in key_put
From: syzbot <syzbot+6105ffc1ded71d194d6d@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6105ffc1ded71d194d6d@syzkaller.appspotmail.com
Tested-by: syzbot+6105ffc1ded71d194d6d@syzkaller.appspotmail.com

Tested on:

commit:         bf9aa14f Merge tag 'timers-core-2024-11-18' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a2e930580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b2ddebc25a60ddb
dashboard link: https://syzkaller.appspot.com/bug?extid=6105ffc1ded71d194d6d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ad4ae8580000

Note: testing is done by a robot and is best-effort only.

