Return-Path: <linux-kernel+bounces-191445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBAC8D0F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543961F21999
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16650481C4;
	Mon, 27 May 2024 21:23:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5203917E8F6
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716844985; cv=none; b=EN+/AEehS35K15KLBsCJyuSfKBvd+UoY9wVIDs95uLOS6r4XwtpJnc0DT8qKl2wIpIhJBcGk5TtevNmmADEftz9joq4ALaq33swZjs7bcQ05Jd63dTOq/iT4y3sZulEUQT4SJXp/9W5sE/0KTZW0niBxNw6g2E4XhS6gRrcpkGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716844985; c=relaxed/simple;
	bh=JjIeu8SKzrnUr+OAE8wN45tD6u9grQo4tQnnpIQKon8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Bgu7jywFXQTTf92LR+Zx107OM/64uOqWMwsZ4Q24UpMwu+6vitEqewqbupewrqoDpJyvLgP6UAoTwJQYR9XNxyflea4RnNnBBBZS50LSXpJh+aSPbjVxm0jSPi4fsnpYFJBk8XC2PZHp7P2u45Es0xK2pal0zdgrSu859PB1108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e92491e750so12517839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716844982; x=1717449782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CD165r83BJ3NGOv8FSD6HcGsqAipbpgpTmbowPj+440=;
        b=LHa/67EJtDw+bHh0S7dDhbvEfYCJhAbP6cv+IhxM2ecITFIDQbSc0SkEV5G2Gd1FI7
         h28pC4VXA+1LWJZIrXFfuVeR9gATPRgijySGuogVavW2nHNTm4+koN++AFM8QXuPEwi+
         OFprEzyndDUXSOlf9O0sfJZzy3yHr8Sd511JDFyNg/Ltu/C0S/6rLBEStETIy+C1+O5P
         fsfuYnepOgYbnv7arO3oKWrHpWA4msWN7oaCmBUe7o0uugZYB95C4zDVg6PJurLz1n/F
         ml0fJDfJ+VH8k+EpSVflhWb+Hl5NhS6HWsa0F2W4f8kdL1I1tUnNKC2SxoSZPlIsHjj+
         zMTw==
X-Gm-Message-State: AOJu0YxVtc4oDXhVLfEM7AHfT20brX8exRVLdj+jnSWLQ+w1fCxjKzua
	se5za46qfMWcjh6wJg3T5kHojgq6Sr9aE2oM75uNgJ4EKCiupG7z2Izb7oXWXcFrPAqNogxam+W
	/RW3MUzyee6bkp7G1z5+tStjokuF1UXqSDyr5F+2lqW+kE/BO/BIRzoU=
X-Google-Smtp-Source: AGHT+IEOwt5oL2/XvxRKOjA8WF5cBZkk5uSCTihNSIlud6mXWU1/zy7m0t0jPLSgkAe+t/O/Rzd55Ww2tLPto5jARKFJyEsPEdGO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:a79a:0:b0:488:59f0:b4a3 with SMTP id
 8926c6da1cb9f-4b00efebe09mr308176173.3.1716844982520; Mon, 27 May 2024
 14:23:02 -0700 (PDT)
Date: Mon, 27 May 2024 14:23:02 -0700
In-Reply-To: <20240527122916.12518-1-radoslaw.zielonek@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051676b0619761f8a@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_clone (8)
From: syzbot <syzbot+c4c6c3dc10cc96bcf723@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, radoslaw.zielonek@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c4c6c3dc10cc96bcf723@syzkaller.appspotmail.com

Tested on:

commit:         71b1543c Merge tag '6.9-rc5-ksmbd-fixes' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17ba210c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=c4c6c3dc10cc96bcf723
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=151ae572980000

Note: testing is done by a robot and is best-effort only.

