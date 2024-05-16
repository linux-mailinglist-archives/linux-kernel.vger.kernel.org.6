Return-Path: <linux-kernel+bounces-181312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2F38C7A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE76A1F2104F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F79114E2E8;
	Thu, 16 May 2024 16:24:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35D51509B4
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715876646; cv=none; b=Xj2acNrVLu5Q3H5Q7yYFesoSaUqyIG7mua2zKOTHnEpNZjL0xeIahqyo5zEeic3PK10okTklL6TtPXV13EPJAdWfUbKAGTZzS5ds3ns4loB0Jgu2fGzapR7idYHJpE2z5mvcGXSnmKUOMhtZYGd+jcQIdUrRc9o3pzCNmEQTgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715876646; c=relaxed/simple;
	bh=N9Q5eZU2lh2dYRP9HlEtwsTGhXkQOT//WA/lxls36vE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mohQWezDLxSkJnebCLOj+VZdCw7esQx276rPAhZmIww1tnDveKU4YtjFQbabw1k09jv/mfjCh6lgTcelOeP1l880HDrlAncEV/py8htfYB82uhiPe36MAihnrGkL57wXvwx233vT7mA2DFcv70PfUPqsRbrC0zyvIdlkViT9/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dec4e29827so883579339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715876644; x=1716481444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nr6JJb9HvcXlnsAr2v/f4ooQdjs1u/TPigABWNyF7MI=;
        b=pI7OoJ+MNnSC6jcv9MU85v30SMZOjZAcHozU3PCjFptw0iQi2Rj4A+dwkCwSzRJNUO
         SRoEeUW23FJ3F/NU05QB+tpKgJJQr9QB8fQQz48bmuzu4Y/nYCDYgjxX+R2iYp8QWARZ
         Zz7UqxRpUnSwm1m3yG2T+6WLUb8SMsofRaSh6O6taTcOJnqg5DALF/qMwwScE29vab9S
         Jd8Z7Y+LXpTxqzHdMXgdzTI9IhkJ1RuETKmxtae0pOA65YNCwV3xAZ17ZPDtAOhFrfGo
         NCf6suPdisbO0VlH48zfkwvw8+zsJd4sezO4ulNr5vJtdOtubApQ3dNBiW7D8irHoa5y
         q5xA==
X-Gm-Message-State: AOJu0YxMiXOD+GebrDmAKaAa5UOdDchvGjdljyk95QsVNl6cqCl0Zbb5
	21Uqua3GKoLMKcLCjDJPz8iunWrn7XPsy7muWnVrr64E6W0mwyu+X+Q8TtpJIrhqmPwkoOoYHQE
	CK/Le8MhccgFJkA3jTnubi7qtfrOQU0POYC6utvEnhz0phidvywRDtNw=
X-Google-Smtp-Source: AGHT+IHJAOjgs3aPlJcbDgGjrdNmy/24pL+tuzpOaPHerqso3GdlfoU/EX2XCwlQ/G+BOti+N3C4GfbAamLKHcTAF1eJcxKYqfiK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:408a:b0:488:8256:987d with SMTP id
 8926c6da1cb9f-48959248768mr1199000173.6.1715876643688; Thu, 16 May 2024
 09:24:03 -0700 (PDT)
Date: Thu, 16 May 2024 09:24:03 -0700
In-Reply-To: <20240517.004903.736683498204817840.syoshida@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d36786061894a987@google.com>
Subject: Re: [syzbot] [can?] KMSAN: kernel-infoleak in raw_recvmsg
From: syzbot <syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syoshida@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com

Tested on:

commit:         71b1543c Merge tag '6.9-rc5-ksmbd-fixes' of git://git...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17cf9ed0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=776c05250f36d55c
dashboard link: https://syzkaller.appspot.com/bug?extid=5681e40d297b30f5b513
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=106cbf70980000

Note: testing is done by a robot and is best-effort only.

