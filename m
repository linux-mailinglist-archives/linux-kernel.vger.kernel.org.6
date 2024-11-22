Return-Path: <linux-kernel+bounces-418728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC149D64C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3943E2831F0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A0A1DF252;
	Fri, 22 Nov 2024 20:09:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA215531A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732306144; cv=none; b=rb1uoq5IlJ+72pPph7P6lTMMvu9ZPRF2J+UsiXBQvLguuPy9eWg+gydTohBtD8h83VVT7lCRytc28bSPnnGA7dcdaARW4Pl/iT67E1KLZhMcJiOJ5XDE6dHnvk9KF+Ul79bcxkrsd+y6jFKXyoeeACDbcTHRCR+1YecNNsaP9oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732306144; c=relaxed/simple;
	bh=lyA0acKPHFB46Dj6KAIXSRljdhcLZZoKUPEsPFaV28A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nYYyXeHmpHAcf+nE1W9saq/IY1EQ66xkJgf7+6euRjtXobrxwFpXZR0ZawvelNGZGnuG5flAbYU8/BaK2Adc/qfUts5jxxNiuWq27gDbXE1mPY8alkrej27AKRtLitUjoikkjZyTFBd59la7h9N3SCITwHqze7f9TJS3gj063cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a77a2d9601so28282285ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732306142; x=1732910942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58SCDLaWkyq8lsn7RlK3u+rHQGNuSjz1RzgtYEi4xVs=;
        b=oVSW4YzPDnr5JcAJySb/tLT1QXAdb64ZsGv/E5e8kTp9pQQ31Yjj2vRAG7LSThjOg2
         Kr81MMEixW6LyZ5V6hoKNVp95K5/HwwH+/O6SAjrdMJfca6W2wftPl/o9+clxXfrzSfr
         TwZCWEWRbFluOcdYOzQgSQUbrxetoSulul/WW2swss/dVH0TdJOcmjIx+DrinnBN/oPp
         P9hutFpr/U6b6XPCzUu0RJVVM4YLEUIEkUBcqUxxg9yKIaOYh9lR01ifLMKk4lztwPWC
         DLbgGF76L8JuxcMnX4nceUsIaDuQUuCvIpjWewz1u0AOaBUjHbgYUt2byqtayKm3FPI3
         QV4A==
X-Forwarded-Encrypted: i=1; AJvYcCU+U5LA05IYfc7BS8P1Jhh+jbOwjIR0eVSbcKIXxb3F/Qerlyj2ho/XfgqEHcS3gS92c1ft7cQPMYCbK9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkUiLkN6NiOC2WNBl56qPTp3veDog2G5nYS4ud3KDvPxPwpsW1
	C2W6eEnB2FRicNzmQqgi8Acrx2w/gI0Vsn4feqaTNNZKfGySJkoN7JZpHGlQSkx1NBjnjXIlLTQ
	+KdS2cxEfp7H5Pt0+7eID03tH8dK7VlmycQjhrWCuUxhu5zv7FOxSuec=
X-Google-Smtp-Source: AGHT+IEGssrnS0PAb1y8IDbyTCQzbN1sZcIvw6+FMkKx0kZX/wTktYFsHnLEeavRV1vgdw/dv+gLZ8/yyKiYQuPDyt2z/V+EFi8m
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1563:b0:3a7:7ee3:10ae with SMTP id
 e9e14a558f8ab-3a79af5dc55mr45985105ab.16.1732306142641; Fri, 22 Nov 2024
 12:09:02 -0800 (PST)
Date: Fri, 22 Nov 2024 12:09:02 -0800
In-Reply-To: <CAPXz4EOBuYqN4tDBuMyZ=z3wivp1cohdLt6TX85aXiFdEHwDog@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6740e4de.050a0220.363a1b.014d.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (2)
From: syzbot <syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com>
To: bretznic@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com
Tested-by: syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com

Tested on:

commit:         28eb75e1 Merge tag 'drm-next-2024-11-21' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127f7ec0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=461a3713d88227a7
dashboard link: https://syzkaller.appspot.com/bug?extid=fe2a25dae02a207717a0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12a586e8580000

Note: testing is done by a robot and is best-effort only.

