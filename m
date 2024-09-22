Return-Path: <linux-kernel+bounces-335322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A9397E417
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 00:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A00D2812DC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 22:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDDF7DA81;
	Sun, 22 Sep 2024 22:45:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C877711F
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727045104; cv=none; b=SKKgtVrnyf5sUkJG1PFxOuxwaGycbaLioXhuODR/qBTAC8VHFOpE56pwC2THPwe1pJU01ryd5+QiPVwQzTUXAsa7J87VBdn56hQJuXjgOhe+agAqsl/G2GPbixy5eRIR0vcs0lqGlTKC2v1aJeyBdShUIcddpuBTV810OlmSaYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727045104; c=relaxed/simple;
	bh=OEDG/BvuDgICtGHAiDm1OAnNHey4PHCRDp55AsJxVbE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PWmnQXhB++G5dNCnZcz7mTSweGxHn7OLGH9oZsRp/T4aAb+Q+tiz6GVDfPzljxeI3B5NNJGNcCvCqVxWveJyPRVYY6z5dLvg6rsNgBVzSfKPeBGC5ukVDH4ZBFRQzmKMILYbU3b/EvlW+e8JjwlxN5w+U9QzJrYLwf8UvS2DIO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a195122f09so8549805ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 15:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727045102; x=1727649902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6epvmkcx0DNV6MYkuIx20m5d9Ex6Fo9NBiXQ26uPd0=;
        b=wSuSj1o8imV3OM6iGtETaFgp75l5+dDPMDheXUJjBXtLYrgPStD5NpyQnoQM5KdBkY
         ++DG1H0F01C+Lb6NRi1V20fYfsCZ3ZUueQhXswUN8Sd9QPEAJJ0DaayaKANLWgQg4q7+
         EXynfP3S4RrtnC8T5OgLZG91Gzz7O+rklwhoiUT9pmUU+qTnQ4aid7E1GzyJ6hz4N44D
         3HPkBRWoEZssDU0xmcS0OD8R03X17sh5ROQVdQmWrSlRKrigq0FLahKL6i1KipSvoZ60
         GAbC87fsvYBhaV92Wg/2ZSyMJvS5A7mnjhODsLs+e7ni2DRHfLc0QLR6uYY2j6ptehzI
         tPpA==
X-Forwarded-Encrypted: i=1; AJvYcCXAuElEoKi/TjpHc/nJS5vnPxyXwtdR6ajRw/SBgSuJZa5eLJdzu+e8/ugb2qSBb4G4awwK56nZ5hI8ncQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrTnqpneHeBkOlGPQvz2v8SEOAz7C69Tx4U75MBUYwjCp6h/rA
	/AGR0EKqKwBH+xeKNBd6zOvRIgdyeJnhDNo6xAeMfIISl61z8yK8UL+wF64QryA+OUuhNw99cHC
	mJm19AlK8EpQYCUVYWQ0PX7l838EUXGn3ezTcSvpF8oM1AM4z4lqjfD8=
X-Google-Smtp-Source: AGHT+IEg31oToMUph2W8XQQBPcOt0acreoXu0Sa+bdw0u3ScT0JX/+p9M+6Bn072KzhTaipmQ1A8oocscDM/NnXgfMsJmkT/rbKg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e3:b0:3a0:a311:6773 with SMTP id
 e9e14a558f8ab-3a0c8d3ace3mr76687665ab.21.1727045102536; Sun, 22 Sep 2024
 15:45:02 -0700 (PDT)
Date: Sun, 22 Sep 2024 15:45:02 -0700
In-Reply-To: <20240922222313.115922-5-dennis.lamerice@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f09dee.050a0220.1b7b75.000f.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] divide error in __bch2_strtoh
From: syzbot <syzbot+24beef64217854da05a4@syzkaller.appspotmail.com>
To: dennis.lamerice@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+24beef64217854da05a4@syzkaller.appspotmail.com
Tested-by: syzbot+24beef64217854da05a4@syzkaller.appspotmail.com

Tested on:

commit:         de5cb0dc Merge branch 'address-masking'
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16423880580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e851828834875d6f
dashboard link: https://syzkaller.appspot.com/bug?extid=24beef64217854da05a4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14cc3880580000

Note: testing is done by a robot and is best-effort only.

