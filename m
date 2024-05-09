Return-Path: <linux-kernel+bounces-174595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1378C114F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6762F2854C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D97B39852;
	Thu,  9 May 2024 14:36:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883951E49B
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265365; cv=none; b=FDQpvDNkpVC7Ac9NOeF/tB3ZmczXhclPBILc2qeAVwrjs4sLTyZYREr9Ks/f+nr4rjuwW/EpmQVeGC6oYaK0dk7g7BL1zjocRAkSAWU0iCRqB2jymTOVQXXZJdCj2SV68O8fxW2ekpSCrqrG+T3tZStjoOVFztdHGFC1kZ9KVJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265365; c=relaxed/simple;
	bh=rt5PATXtgqvidD0vIbThIoVaGgjahZKF8YuAO7DGNVs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a2AxoYuzgtnajzayTgxtRca32fciwMA9007/G3M5CAKMTBqyFWJtV6DFCyCCU7D+ov6+Nh/vMBCWFcDiH9l4aDeHMiKNeTcbk87ZnPg/I62PN9zEEKBclzRSNlRBe2y3wUMo2RKnmhv/QJzgHdgXhP67g95byIn67bDRdj88sHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da4360bbacso97581539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 07:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715265363; x=1715870163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X32bctqqt9YMYnQBW0Lg5lwXOgThd7oCwO6YJh7J808=;
        b=szqbnHeH916/qiKDFDchO2rI9JPeVF/rd+rzum70l0F8gYv9io4lFkbyQJCxKOAFJI
         TU7DKnO4UFjKATqRP4m3oijRezkEz/OMOZsSV4kLBkR6gTdJOsws1KPHlqJaTqsAMxK2
         OxIf8KUTDUHin6b6CgDbwCsOEmFcKsRnOgASLPiNofn7goQzaWtA78crekjKjIsGDdRa
         twkS5eTEJaMXxaw5WavTnPBxYpVMRjvgXPJ227XqNCwSs0UK59XVaA1zDTKREPqd/P9X
         j6Kt195PR/fegPd9keSAmBteKKV/78kEG2VIy84YNEY64yQiEX7J710e7jE6uVrKbjPm
         cOzw==
X-Forwarded-Encrypted: i=1; AJvYcCVp0xD5cjVPRGFBeqwJGbAjxgaN1IqeVyjYjRRtRV8+3TTidD3LROAerYXGxjtmeuwhGFXRg79Iz9R+ujTt7A9OoYKL7UjvAoDCYB22
X-Gm-Message-State: AOJu0YxYV1SDVZCoJBQc5WXf6veoEgaihi8MCKW38ZDGeyaim8ptjgTt
	jDxO1TIYMZu5OerG0O2cnFJ2WxfOU96kgxvmcPA9L2rfRFBDAsgOrUHQiuMjUvt7cyI9qcc1NZd
	ifDzCLNicKEBAdPGFbAR5JeWBAcc8sDov1CkYnA26w5DDK9amGHwnHtU=
X-Google-Smtp-Source: AGHT+IFimP6/xLNj6bRq14TVADGedsYjqOqb/Ip4x4SwfekNgdENtprvWAAa39kLDpMwHtQipO9EAyntjoMdl6ej5XC0oqgaAmGw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3429:b0:7de:e75e:6170 with SMTP id
 ca18e2360f4ac-7e18fd9b171mr5574039f.2.1715265362643; Thu, 09 May 2024
 07:36:02 -0700 (PDT)
Date: Thu, 09 May 2024 07:36:02 -0700
In-Reply-To: <0000000000008ac77c0615d60760@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a2dd340618065661@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in sys_wait4 (4)
From: syzbot <syzbot+6969434de600a6ba9f07@syzkaller.appspotmail.com>
To: alsa-devel@alsa-project.org, broonie@kernel.org, lenb@kernel.org, 
	lgirdwood@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	oder_chiou@realtek.com, perex@perex.cz, rafael@kernel.org, 
	shumingf@realtek.com, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 51ea51b18904cd1a0fb244ce41dfd903c2ada628
Author: Shuming Fan <shumingf@realtek.com>
Date:   Fri Dec 23 05:58:46 2022 +0000

    ASoC: rt711-sdca: add jack detection mode for JD2 100K

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=123e6f88980000
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=113e6f88980000
console output: https://syzkaller.appspot.com/x/log.txt?x=163e6f88980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=6969434de600a6ba9f07
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1091a5f6180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a22c13180000

Reported-by: syzbot+6969434de600a6ba9f07@syzkaller.appspotmail.com
Fixes: 51ea51b18904 ("ASoC: rt711-sdca: add jack detection mode for JD2 100K")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

