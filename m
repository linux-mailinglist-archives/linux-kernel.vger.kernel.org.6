Return-Path: <linux-kernel+bounces-262510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4266593C7E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2C3281FE1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEF719DF76;
	Thu, 25 Jul 2024 17:58:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58E026286
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721930285; cv=none; b=BA0BtgJl6nNCpW3aOt2bwD0XrA68zYbZrNjJrAHQoqGB1AKvzJ8n/ffWsyn9M+ep9fa2sZiitqlRitn8PkBRZLHIHAYkRTk4lxgI1aoP+0IZQs0GCYYt8kYBs0erDz8QYp7/vYoeTE298mJKVKYflNX/5znl9iPJz/p3ApndIgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721930285; c=relaxed/simple;
	bh=6NEaq4l2buYl7x6xZlTTaT6BpFMzae8M0kCG8Y65iXY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K6gIylLMkP8aQsp0mLJ0kVtqHLewQ1vs8KY3qCwJ9ay0B7Hmywnd5DAPQ5OBV3dOeujr+zSwn7T4Gw8ByfbYXHpCt1Vy6fYfARxBGkNhva7ZpM91xAk2ubyvYr/ExXZVCYCn8d7wVi9yRpD3vdF3Oc5I9z0uzlITl3KrFYA/61s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-396fa3fe46cso11222845ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721930283; x=1722535083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5RXFrLVSSr1jSw7Uaz4eXW9EXsQq3IlHIBCkGDlAtAM=;
        b=APV1Ppmp4Z7iSBiylGB/h3UZ3vh8Gi5Bq3uvwhgzdZgEeM56nXoLsArDt1tp4AECp1
         wtNfTd65FLbXynxH3zXfCXWuX84peuhcEQIQPGhZzFtSxtLRUslv3m0wai8l3qRzyCql
         P6jxL4Dy6pEpqlfaCoj7ouJWmjF3eWg/Hi91Y3R3f99mVPzCQWA7X65fzs8oTTRbpVlM
         db4j0aFIXMi+gaV2vDS1G0YsE3V71iygbAMlcwB0npQxj9hI6Rei7el57JIYISgPcelk
         DISiy4W1ba0L3V+vqtrY9OgG+s9+JtbFxlHhPICjVxLY/3eDQXB72uVim+f4wzU2O3Db
         Tn2w==
X-Forwarded-Encrypted: i=1; AJvYcCX/D5VxJ6zaQjCA8B5hd5f7lYlPcMv4C40+h6S8HzmG4mZOMq3hr79wTEGaLvEnRNw689ekPnEMgQG0onqIsStxUgVVYZ7ZU+cf5LGw
X-Gm-Message-State: AOJu0YwbWrF43IglWeddays12kvtltUjfqs7uu2RGK97prKknhEl2/PY
	tR8bTjz10RsWnBJTR1Hjf6Zl2UIk2rKHzAqj8bfC8Eb7cTsYnFmTUFz9mn/PP4Sn38yDQRIrLUh
	oCWx3KOy/P67/DoUnTd8iqA/ug8djXCLj+Mvnpc5UEGxSBwdm9A5BLCI=
X-Google-Smtp-Source: AGHT+IGy60XSGeuDOQ4SWc/8GWLd8tzn06zYwWaag80jd6LgfVewTl0FI03n97VgjxChNqiwfFOpnH5wKGrpHcQCHUXZLfczoqG2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1389:b0:382:feb2:2117 with SMTP id
 e9e14a558f8ab-39a23ff3907mr1875685ab.6.1721930282924; Thu, 25 Jul 2024
 10:58:02 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:58:02 -0700
In-Reply-To: <d39434bc-430f-4c84-b1ca-1025f55bedb8@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d78ec8061e1622b3@google.com>
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_req_cqe_overflow (3)
From: syzbot <syzbot+e6616d0dc8ded5dc56d6@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e6616d0dc8ded5dc56d6@syzkaller.appspotmail.com
Tested-by: syzbot+e6616d0dc8ded5dc56d6@syzkaller.appspotmail.com

Tested on:

commit:         0db4618e io_uring/msg_ring: fix uninitialized use of t..
git tree:       git://git.kernel.dk/linux io_uring-6.11
console output: https://syzkaller.appspot.com/x/log.txt?x=124e0dad980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf984d38d0f9fb49
dashboard link: https://syzkaller.appspot.com/bug?extid=e6616d0dc8ded5dc56d6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

