Return-Path: <linux-kernel+bounces-436854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045AD9E8BB3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB7C1883FD4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B6E2144D1;
	Mon,  9 Dec 2024 06:50:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629551D555
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733727003; cv=none; b=hIc5fjw7H1Edb/Zw9/cVVXGp+pTD6lpJrGbRciymmCQmTJtt6GhrLaPTzKPToVD/ozbHcE2UfWgUraI5IabvBLH+3mbo2CmD9bhGdy3NFaTCyGOSDsxYXOnlQhuMpC3j1JAhCf/lTmRxQvLGuVs3nu2ncC3ZSUhcsxSQnV4eTNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733727003; c=relaxed/simple;
	bh=RN7MmEIA9x70rhmuW1jVFpW08GLPlax98hEts7jam7s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S2MWPWW7n35QbJgm1DW1pL3UwtL/nTlPbqMH7RwDMTo+NERqHuMwAVCnhd6ZfALfTwbHBd+DasbfK/yNmUk0AeaN8Bn1q6eqBfJ9OnGSMb+u3X4Rd3VeX6oJ9DpwaKeXbbKVq98cVHoZdS026DJny8f4VDWd6M1bOvQRWu0gfbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a9cd0b54c1so11064455ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 22:50:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733727001; x=1734331801;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qN51rnMTI3HMs3eyHHMOrqKiKs7nWEUtaQFI2TqbFSA=;
        b=fXVZVA0n8JZox56Lg/2ACc3/jYhUu052EYM2dtc1C7pxOnqWLvle3Ih3ESnlBYB8nm
         UCnRbf4/fGWQK7Nyitkg6gmj3Bb8f1TY8aiwGvegtUIyk9FiY02RMVhQ/HzkAAhwSIeW
         dJJAqTiDAikeNi6aPNbx76DBSNviSlaZK9Ld5bpHm8+/uWCl3CIOY+whlcIIeDBPwyOh
         MNM91Oe1rrN6pi1xbMkf2ifLMuv6nETERtbTPMwmmWKjJh+VPqdRK/4XAHwmU6r2IDtJ
         03R8wvy2QvJA6iQr4XtEaqhZOzPJOk86GniNYEMfjuLcCe5T+5akX/AJsdCeITPVO0nZ
         5JCw==
X-Forwarded-Encrypted: i=1; AJvYcCVwCmvW3umj4TMf2qOjg9o19noVjdKOOyHAxHgQ04UfFyZHTVNdVsjwM318nHbwEom14VaBoDlMI+MhNb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDKQWjBAXzL6Ebz5qcO0v1obP3cUMoCyK9I97S0sOKVtT8IZW+
	LU9iaxOHzqxwMqcC4jxyCND+m/iyDu2uw+8qXrFvbdccgytUMloe4TCJ2/A+WP+xM/e6F6TGilI
	3mokGU8D+Sa1iVKCOwfeslYRNJ/qVqTYvmyWAjvJPiCPmqsaTQ+fsFtc=
X-Google-Smtp-Source: AGHT+IFck6njrydiWJAMENEKoDUWoUSNjh/iT/3K+YNPC4oaO8c0DE+E4GiuYRtNeoZJWbs3ONjek09fLp0dZBoQ2MZSk+TBnMxA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cc:b0:3a7:1c73:e18e with SMTP id
 e9e14a558f8ab-3a811e2cbefmr100722815ab.21.1733727001543; Sun, 08 Dec 2024
 22:50:01 -0800 (PST)
Date: Sun, 08 Dec 2024 22:50:01 -0800
In-Reply-To: <c4122d03-2a5d-49cd-8ca8-c39cc1ddd2c0@bytedance.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67569319.050a0220.a30f1.0190.GAE@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in move_pages_pte
From: syzbot <syzbot+1c58afed1cfd2f57efee@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	david@redhat.com, hpa@zytor.com, hughd@google.com, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com, 
	muchun.song@linux.dev, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org, zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file mm/memory.c
Hunk #1 FAILED at 7014.
1 out of 1 hunk FAILED



Tested on:

commit:         6e165f54 mm/page_isolation: fixup isolate_single_pageb..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
kernel config:  https://syzkaller.appspot.com/x/.config?x=76f158395f6f15fd
dashboard link: https://syzkaller.appspot.com/bug?extid=1c58afed1cfd2f57efee
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13302b30580000


