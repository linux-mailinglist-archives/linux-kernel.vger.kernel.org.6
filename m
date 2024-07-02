Return-Path: <linux-kernel+bounces-237860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C897C923F0B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D892280EEA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B2C19D8AA;
	Tue,  2 Jul 2024 13:33:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BFA14F135
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927187; cv=none; b=LH71TAJOiXFKXMGT/WuKkTi0hRLkSI0VnbQAyEcDSlUtLNDkKN7KhoUXHZ3mWOOMPcqArf08nYSsu9ylYjZyJaAP3WSpGAjdC9WEKmy0DQ9rzc8zU8lPQV2UekHzouOHDf4+CoZzq30HCqc6n/BojNB3HckWaJKJytfbapZs6Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927187; c=relaxed/simple;
	bh=20Kkrm23qgejHBoyel6r4nfAeasaVt5MUm6Yy0Atgq4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Fdl6Jd6T1HaP8uEJwOSVb3HC9ikLRbnNzh0yc/Hc8zxStcM7+2cnK5jGMwii0Z4zpB1R+HgvAEt21k6GJKXctGMBxBi6+qECv/sT75daaNUTI9XIRMsmmDqIRiI9cVaB7a8WFKtyYB2SNUZDAGDp6fW3x+Tcmz5Uz1QydlL4rbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-376117f5fcfso43538545ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 06:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719927185; x=1720531985;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXxjWYLK2hikszDBEvP1bt1ek4sdC1AB6fJ+CO7Oll4=;
        b=aQZRUwotpimRRabUspE4PsrHey+USnGdddPK/jA/8RjT22M2k9GsjEn5sMxKJyBVf3
         hSxRtMmZlpSg8TG9shBXJfnjn06ydcBIyZpbgH6zz5/h4qnRY9efWsCOKHq9rMpLM5AW
         ld058aSZWqq7SxlrUlVasDlpUTWGk/Px0VvYaEcWfUWC0wWuA3by9Isx3e77CmjhcisZ
         VWXxGYDIeOk5U0Xx94sHEQgTFwPVTcFVdb638nJn3TT1KcL0v57p8KU8SbFf0ppOsTUK
         EmvpDXiT9L6Fvxz1lz1aCn7mklHdNliEPzQ+0PvjimN5GGWyHwb5/kgF4ib1FhYh52hv
         iPPw==
X-Forwarded-Encrypted: i=1; AJvYcCUUtXnpS8PUPB2xpEWxRG0uwJI973jcwLPGQHcRst+mmZMHAafFODgXz2LHtYdTTaFHve2m3z4w4JrNv8hXdYST5F0udJWlPoV8F9kJ
X-Gm-Message-State: AOJu0YzK2VXlz65f2M5f9gPilU9H4QWSbA704vKolA19iuVOwILTgugp
	qr2vHIBBHR3DyTcS7Y9vqgPDle3jCGDAm91X2T1uGoahiV+m7Vb5WkJoQHoi3IeePAiuuXtgBdq
	h+xPqpW9BD06g6moUOTs5iGuFvtumbOxlJ6Oqs4fCGhkQKgr8BMs+t4c=
X-Google-Smtp-Source: AGHT+IFXvsRhRrRwydDgyI5edXkLiGc++YdPfyAvz6uG9T9FmZ6dcuYuSVSrnHNc2tzZTP5e+ySLK9Y6VXBU4Hdph0xcHVc70L3c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11a8:b0:380:f12f:30d9 with SMTP id
 e9e14a558f8ab-380f12f324fmr262165ab.2.1719927184416; Tue, 02 Jul 2024
 06:33:04 -0700 (PDT)
Date: Tue, 02 Jul 2024 06:33:04 -0700
In-Reply-To: <20240702093924.GA23593@breakpoint.cc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ddef5a061c43c0c0@google.com>
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in nf_tables_trans_destroy_work
From: syzbot <syzbot+4fd66a69358fc15ae2ad@syzkaller.appspotmail.com>
To: fw@strlen.de, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4fd66a69358fc15ae2ad@syzkaller.appspotmail.com

Tested on:

commit:         f2a491c9 netfilter: nf_tables: unconditionally flush p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/fwestphal/nf-next.git flush_uncond
console output: https://syzkaller.appspot.com/x/log.txt?x=1626b9c6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=4fd66a69358fc15ae2ad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

