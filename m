Return-Path: <linux-kernel+bounces-392925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1D39B99B4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010F4282C80
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C27A1E2617;
	Fri,  1 Nov 2024 20:54:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDFF1CCB50
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730494446; cv=none; b=fpw2p+oCtJbAv+ZCcdYngSZhKtRQ7Dvdal4Emh9tBCZUw1NyUNljQ9dbePslTkbCTvd+WSqxhKPDjrkbYeijNjnEUiOupnR60jqYFldV56CQS8kL7dL+hqxleNmRuQFR0VEa9qQOg529KrV3xSSjkC/zSATBe1rpsfH31I7bMmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730494446; c=relaxed/simple;
	bh=kZJMeUwq6BfXnNDCNqrO6cUSq0z1D/YwlmwI2+6lKN4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K14oNyUSrBjIYcBzHfR5n9JV8FmQR8KKNmuSnnQTdkL1/UWoGYYgaUxTogC/zY0na3uMDwdwlZCh+qhixXpqrNssSCUgUOQpN6kCqbRR3mMXTcXm369bi3QdPcGfpjj24J2i79R2pquUNxBqxVTKTw42N92o+wmljG/KaOOtLdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a4daf7174eso23476085ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 13:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730494444; x=1731099244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zYGTXETVjU1EyAT+YMEHC6pldiUtC2fofBVRE3p8Ho=;
        b=OenhS8N7oH2un/lNby8jKiEJxUDGsbElAJIg3JAPVk+Ha0wN2tanJZQvbYyDOJbyW0
         QebI91RDceY+kGduLl7M1Qw+PsNSURg//kRnvqXjawfoUPgmKei32AZlF0Vv4JTRpdUI
         W1U40z+Y0oiot0HTkJtD7fZdkAq9LorfydqiU5BhTKQoRnqd4JscJx9b6+SN/hDSo799
         k9cL3ly/vDUCcXawgfyWyGbXjQf/NIeoC6wM+tPt83vxkeOL5lRcD8UbHVAAkq0WsO3t
         b9yR0ITTG5bZccheTdny4tA4b9CEEE5Ahh4rk3jMiO53iStdvPO13MZV+bmhL1QoQeSO
         Xihw==
X-Forwarded-Encrypted: i=1; AJvYcCUP8p3ptLbm6cv5h2ZObEwqXyXlFLewAGmUjvGokewiop5DGBDwMAZ9DMfpSiyPLg4pwR9mFepPTABJwdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqNU+aVHwxuxPa59tqYsaLEqMVc2ij/vauDS1D4dDPCZtLGEkd
	Wa0LYFpgAFPSbUMHntlWGsUn82+ZzV7wkEyV2JFEt/vc45K04bjLmbr9unIJNXILEjFufhFgUij
	IljNZ2Gc0qcQv3hQKZzClEme4jfFS9Mq2TXj7C+XeeqDzHbUjTlOD5Ls=
X-Google-Smtp-Source: AGHT+IF835Gf8jxK9c9oKhwRcXBUKFFOJdDs3mVGGOLi0NDw7H0LxUhGG3Fpy1L/PIKJqsTCFX4oAls524+fI6LsjYVb1nKSreBW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:b11:0:b0:3a6:ab82:db58 with SMTP id
 e9e14a558f8ab-3a6ab82dfcbmr54224685ab.23.1730494443762; Fri, 01 Nov 2024
 13:54:03 -0700 (PDT)
Date: Fri, 01 Nov 2024 13:54:03 -0700
In-Reply-To: <8fb2e8a3-c46c-4116-9f5e-0ab826ec9d22@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67253feb.050a0220.35b515.017a.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] general protection fault in io_sqe_buffer_register
From: syzbot <syzbot+05c0f12a4d43d656817e@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+05c0f12a4d43d656817e@syzkaller.appspotmail.com
Tested-by: syzbot+05c0f12a4d43d656817e@syzkaller.appspotmail.com

Tested on:

commit:         6b1c1819 io_uring/rsrc: fix headpage checking for spar..
git tree:       git://git.kernel.dk/linux for-6.13/io_uring
console output: https://syzkaller.appspot.com/x/log.txt?x=10ced340580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37061a3807403bdc
dashboard link: https://syzkaller.appspot.com/bug?extid=05c0f12a4d43d656817e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

