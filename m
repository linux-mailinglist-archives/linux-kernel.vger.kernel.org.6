Return-Path: <linux-kernel+bounces-516068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC59EA36C97
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00164169BA8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 08:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1025919ADBF;
	Sat, 15 Feb 2025 08:15:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A877198850
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739607305; cv=none; b=oz9Eqk9LIEoA73EEeiBGfNHb/LGkBkNsO+jW4IO5nPec4oiVMvk1WIge21zo/s7rrjV5EeYQoVmC8WclozQNYeWTWmhj8ubWnc4v1ym+ZcaE2CdN6j6nJ0Ca1OluWv9teJKL5e7yBHhkmwyP7mEmB434MgRd7BFT/RJ3CvP1VJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739607305; c=relaxed/simple;
	bh=7Itf4rqZwXMoT/PHSJnE23rA8GPvyQBiXHo98sj6ggI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CZKRPCZeAUCW9VP3rdkxRdsYs1T55WG8MwRSrvZJdDYvB5AkQvluq/nYZe9udnAAN5IiTnDfG7J093g738mgHFm2+teAAkU2JdpGB5qE4wpYUv4XLzpI21ewIsZcYhzdYntPqSDIIUxHirXr/yjq5VOGd2ElqYY+npMeiAoNNRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d16acfdddaso48861765ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739607303; x=1740212103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mV7T/y8qROV9YQ0nJPl9kv2TEGQEGOLsCOUIMXOcDY=;
        b=w3aYw3j04cVL3IbXarsogCXJt9Xi3kvy/JUex72TiFKeSyB4I6HDcW5wup2dPMdMj9
         5diy8WM/qUJWFDMQR9LF1G724a/aYZfbq1G7JpE05tyWzcYI6JRt+0FKnnnwMq3NJb7l
         jC9aKH7VVzFATatLE1kj+NwolovWPVjZx7Tl+w+Ox6gpnw2f5EWcDStUpTTQQ/q00qcd
         bioWhsxYJEW79+7ILtakqj6+lDan7FHVKrslll6xB3Z3OHrs/1PuVpKS2skRRhEUA2Jm
         zOcszn+PCRWX8CuxtkxErSfzVN+4pgcOvfyltkoX1FI2uIxzBiw6QfwZZxTyLEPPkB7y
         Zi2g==
X-Gm-Message-State: AOJu0YwW6HZhjWLPL0JWmb5d3l5Cprc5MCw55eg3j8JNkqmcc3lc+f1M
	UbywjQlZH08xTzwV1gESt6yuGUEcondKo5/Z+aRav2+bsyEmHt5XNFY3Cw3tN1FaPHd9uKnRvzd
	tYRwrOhcBNkoKTGqfsTHg8TEuskp3PaNLDgOD0/El1K1A7euuF9Da83g=
X-Google-Smtp-Source: AGHT+IFrcedOgJHNBH/5edWuVKCyM24yMeB0BnHENHnE420ATvwk9UJxtQV/bRKTxHnBu0CmeJcEiHQ46EVWpNdfN1h/4lts9Sry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:398e:b0:3cf:ce7c:b8b7 with SMTP id
 e9e14a558f8ab-3d280809327mr17364145ab.10.1739607303376; Sat, 15 Feb 2025
 00:15:03 -0800 (PST)
Date: Sat, 15 Feb 2025 00:15:03 -0800
In-Reply-To: <CAMp3bLU9jH2+OpnNdBavixXFxLSXD2zKyp=ajmB8sDN87pj7mg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b04d07.050a0220.47157.0002.GAE@google.com>
Subject: Re: [syzbot] [ppp?] KMSAN: uninit-value in ppp_sync_send (2)
From: syzbot <syzbot+29fc8991b0ecb186cf40@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, purvayeshi550@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/net/ppp/ppp_synctty.c:502:43: error: too many arguments to function call, expected single argument 'length', have 2 arguments


Tested on:

commit:         7ff71e6d Merge tag 'alpha-fixes-v6.14-rc2' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f20bce78db15972a
dashboard link: https://syzkaller.appspot.com/bug?extid=29fc8991b0ecb186cf40
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c5dce4580000


