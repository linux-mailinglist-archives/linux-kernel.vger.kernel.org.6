Return-Path: <linux-kernel+bounces-441198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB439ECAF0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61F42859D7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190A61EC4F2;
	Wed, 11 Dec 2024 11:17:10 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86510239BDA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733915829; cv=none; b=P1hmBCVrvitMOzdfgkjBMrwruxJsmJjUWsR67gZSBv095LZ9APT2uyPdZFzaiI5erZJ50Qp/IBhYleZmiFUpFZFGMq1OXLG3WBkpot9vR2BlcXbAc/SOdcmsb90dWUXopo4FmoQYfa5vZ2BMhDdmXef858OXKrxtYOdhT5pTZYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733915829; c=relaxed/simple;
	bh=c4BnXmgYxYe0yWZE168Zvg6DDn6B6qwJ1/JrV/rTa7Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ryxBuMlaR8O3VJFO7r5DzH+5X43WI/J8OofAQXvPLdW0Sc21eb+ieAbHbX7WV+BVmi2MKazr2ZYCsNVl8qXl6VF4M+UlhzSeCkDKc6eefHHTfusp1AZH2vVmInNdOtkCqURtloZ4Dm1QgysycO2ofdESW9yeK4PSbydCeZ382Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-844d02766ebso35575039f.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733915825; x=1734520625;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHOzKcnbQs180NH8xgUeDZcmje0GjXSOnMZDD83SFDc=;
        b=r1u9EY6D5LEiPfo2FBmOiN7D3pKhDGB0gxU/AE3x5JuluH9KK1sochBVnMfOMcDRdd
         HA49v/KfmC07GRS+EGnkBfQQcfVd1RdjkctTg7hM1qosXVISbHHLLqvEUwINYYnPoGDy
         QfnUQiJAwa8jgavdeRnZnuynsx0hT5QAsbksOynajd7yeh7Kov9IQApc0WbOTB0PfP2Q
         R3lNTZ0K2qBjPbIJpP5RQiIKONIPjEXaw1f7qhu61ctFQaPfbpsPzK90O7mrv7064giq
         Am9RNrBfUDHsSabovS5z+JgEJ2YpAZ5Zmr/zaAQkW+ai9CqioRz0M4Z0sh66fdCxdRkP
         UV1A==
X-Forwarded-Encrypted: i=1; AJvYcCWHwayBQchI0FpAl+lSNKFe0qjQF0sp2MWyCKWZ6hWBMECwqz3lDGAKzQJjDyTM+yDeCW/ge6BUO7AOmCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPb8p7Yew5IdjdDf6KAKzY1q0wGM3nH1n2PwaN9hyOpXwgNQJ4
	5uNSekri+oG4TiEo92afTJuBzTI36QxnYbSZXbEsQdcLi5XXc70Go5W3pdeEGk2BpcTtP5zVsWQ
	h+bd3Vgk7DB9DXUFurOWysGXUPhHA7IRzxITmECMi8TNzOLYF2C7Ztao=
X-Google-Smtp-Source: AGHT+IEqPanBuktD8gnfs8MRp6Jz2fqprEU7fyRpw7gAyJujAkB3c8hea+7Oc8UywbQbqkf84pQiqijKBsaFm0ESfX0O8JbZ1UaU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8f:b0:3a7:e0a5:aa98 with SMTP id
 e9e14a558f8ab-3aa06fbfd1cmr25599385ab.13.1733915825705; Wed, 11 Dec 2024
 03:17:05 -0800 (PST)
Date: Wed, 11 Dec 2024 03:17:05 -0800
In-Reply-To: <67436e63.050a0220.1cc393.0048.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675974b1.050a0220.1ac542.0009.GAE@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in flush_tlb_func
From: syzbot <syzbot+2f32bc207cbe5ca4b7a2@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, luto@kernel.org, mingo@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, riel@surriel.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 209954cbc7d0ce1a190fc725d20ce303d74d2680
Author: Rik van Riel <riel@surriel.com>
Date:   Thu Nov 14 15:26:16 2024 +0000

    x86/mm/tlb: Update mm_cpumask lazily

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13b9b3e8580000
start commit:   f486c8aa16b8 Add linux-next specific files for 20241128
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1079b3e8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17b9b3e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e348a4873516af92
dashboard link: https://syzkaller.appspot.com/bug?extid=2f32bc207cbe5ca4b7a2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c16fc0580000

Reported-by: syzbot+2f32bc207cbe5ca4b7a2@syzkaller.appspotmail.com
Fixes: 209954cbc7d0 ("x86/mm/tlb: Update mm_cpumask lazily")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

