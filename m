Return-Path: <linux-kernel+bounces-424714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D8A9DB868
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5903FB22608
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E441A0BFE;
	Thu, 28 Nov 2024 13:18:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FF719E99F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799884; cv=none; b=tmDtgBuiGLGMp9VEshoXoHqNXKVXzoZ/reL7IAwpTWmS3JDJLELaaHrEMM/9acjZJXFr/XtYcpr5pCNRqMJH+slzwF5030Q8FU0JgQVxcy1mjwQcU+d7ek1dBmlVpE7JBkJRA6C//mtgw1UCNHb+Ubh7+pF/4CFkcPd8C6QWlk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799884; c=relaxed/simple;
	bh=JQK0VN3JluinxjpBcFRZHImvV1QppJI2DGwMzd5J8jw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o5pf/yDOZuT5nxW/OCXdeyxcB0F9DX28h363FSjHm6PnPskLpa+Hq0+2DjicRNC3kioTMtWXc9PVMnjLu9aFp0LYkyvqjVg25gxaaLy3uDtIgh8X5ep+eYRkn+3znwMZvP7KPMBvtYMwj2zGjBHtFA4O9H9Tb7CStAzuisYtF2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83e5dd390bfso139638739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:18:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732799882; x=1733404682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmEsidu2CXOf4h9+VW3wI1mkudivi3naDlgMD4CUsMo=;
        b=iLycDjBMXP4FIMn1+1a/bAMuaJHoOQlj5I0pegiBCY9C3p0331HSsW/i26Qy5z/24R
         LEXpBOLqnK9YICw/xbdXizL5R4ROQm7CAt+JetctA/lT5MWQN6YUMvt+FC40hfyClnFr
         8WJH3N13tOBNbkbi5PQYqTMrnoLYS1pILaM3yeDWninFrYuzJBE4HiJE0mWqVRh56Rt5
         Vi2K26BRk23z6u+5JL4qq5KEO95qz2Ar7wqfgw0DzWaDuwY1rA3wUWoHlrgJ9Q3qKgL1
         3OyPBO4KgfuieO95+7ks2OKvrqyhMfttwKUhdLWaIZz6dCeRf0tP80gHJfzCxjBuApCM
         EfqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHnthLiyHo0mv2BjY93+4fWb/ulV+LBMCvOEV/DQeze6ZdmSuzHkqt9X/CBPkOYqQ6tDbI3kyAiKIfnIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdFn1GijX/kgS9rQFcFoS29QerSR4aFNOuQMCJ0s2rGR3MsVJA
	CNLucmpFiyFj7AgEs6uZoqwHp1nb7tEjzyXxsfvnpNW9LLAWQIeyGLSEtNoUUzS8KNuz1U3ReXa
	1AlZXYCRHbdT1MWPoUfPYS6cUQ5V6RIv1xWVrxWeV6nZjy6uMJXyDwRQ=
X-Google-Smtp-Source: AGHT+IGiIMRfRZLM4G4wgiSP/kYQE7e/PvX9SGx/SAu4YzTSPrhIUwlQNu3OaZZoaEAL+EkrPH3OFJ1VNXhm4hb7MqrC9EyDY+Pn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b43:b0:3a7:a58b:557e with SMTP id
 e9e14a558f8ab-3a7cbd2fbd5mr22988135ab.12.1732799882108; Thu, 28 Nov 2024
 05:18:02 -0800 (PST)
Date: Thu, 28 Nov 2024 05:18:02 -0800
In-Reply-To: <57f0859b-4c30-4c72-9796-e8e6f836e509@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67486d8a.050a0220.253251.0085.GAE@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in const_folio_flags (2)
From: syzbot <syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com
Tested-by: syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com

Tested on:

commit:         fc0a5b9f mm/filemap: don't call folio_test_locked() wi..
git tree:       https://github.com/davidhildenbrand/linux.git filemap_test_locked
console output: https://syzkaller.appspot.com/x/log.txt?x=132f200f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3a5fdacfe3dee51
dashboard link: https://syzkaller.appspot.com/bug?extid=9f9a7f73fb079b2387a6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

