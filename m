Return-Path: <linux-kernel+bounces-172686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA678BF563
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 06:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F25F1C232AC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 04:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DF617741;
	Wed,  8 May 2024 04:59:16 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E09717559
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 04:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715144354; cv=none; b=NiGBhfEFxHDfa2v8SpGOFA8ZjPvvbHAp4tR3Cm3H4Pe8WozMDRGqmbvLdKCR0eGSZKDZ5FS2uUL5HNoU2kh4fCTWFqV5Mj2AQXF26/23TIqdoO4bYbSaDe8GnDCraXTNqreNNhdk53zRn54oWqsfhEz+FRytzjhy/T/qdC9p8H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715144354; c=relaxed/simple;
	bh=grguybPX+h2UCon/cjSOa+mzA0KlDjT4Z0Lej2+UKKs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L2+51serTvcHnZJZhMFL1rlj4AEgiVSQMrQEmol1KvvY1h4TG7t2nKdmk2mmDCfCHVsn+1yU0yffDgKWlyhsGrs+gvRrL3KXZm5USV1uxgccKGletiEJL75iKz0rQ3JvjAL0ROa7iSDQ31210fnDgSeW0k/nl6rrq67a1Hcg+Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36b2eee85edso48294575ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 21:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715144344; x=1715749144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+fjCTSoU5FfUWAA20oSxRWPOgaxuApk8TbKtRkB800=;
        b=RJbTyDaAMm0ciNDinoGb6SDXMEKyMEjdDb792eynkwzgBylrgSyrsmba9cmPuB4czx
         dBzgsqiXxn4DPhFqump/2n67wbti8nKr5alBmTK7bcKpSbHap2fLiybhPYcxAwZcBhGy
         hQ7OQ2woCnC/3gS7NDsn2w7NChHlF9coGWZ7AA6gCwC31CYX5b9p5RbuIdoMFJC2ugZy
         SPKth9lokBfzJuOz50V8WfGTEbvK76qnboQ81zeUQdzMG1Z1Me5xFSSEILIbVR04MNgy
         DDr73eYNV7kdot1n49PRX1JOUIsz8r/WbsqoVF2O/Ehq/aARr/5mBxx2bAzn1vkHjDJ8
         2O+A==
X-Forwarded-Encrypted: i=1; AJvYcCWOlRosmDHAf0qRqSwngP8T0lrmc3gutgKuHG3kSyVTVwo0AiSPNiNdgXAZqkiLQOYSKijKi9JRkgfOufoLoQzod+20iMRvo6jk/aQL
X-Gm-Message-State: AOJu0YxmluYFziuNLMhnjU5mMiTFeU9WeVdobEQv8xvVAyHzLVBtGM6N
	KQhSjfGcI/xbzXtnNmTc+dZpVM1Cpq8Kn1CF0qVTWCCcsIgcfpb/DTCbFixdMSNUhvpXzkfb0rg
	8c1JXZKGU82fzv2elOveiCYJLSgiiDNLM+A6H6Fmh1FHugaEHJz8+Jew=
X-Google-Smtp-Source: AGHT+IEvpfUKYLFR6Yt0QR5x4KvFKT/3f/v/oGP7ub1t1z3lYGWgIabF/NIxLsvTG2D6jXzDlmXD9R+tRGTWmddwCniMs6ACFlAW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2194:b0:36b:3b10:7425 with SMTP id
 e9e14a558f8ab-36caedba2cbmr263145ab.6.1715144344615; Tue, 07 May 2024
 21:59:04 -0700 (PDT)
Date: Tue, 07 May 2024 21:59:04 -0700
In-Reply-To: <0000000000008160ad06179354a2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006650ea0617ea29e9@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_fs_recovery
From: syzbot <syzbot+05c1843ef85da9e52042@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14fdf9a8980000
start commit:   ddb4c3f25b7b Merge tag 'for-linus-6.9a-rc7-tag' of git://g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16fdf9a8980000
console output: https://syzkaller.appspot.com/x/log.txt?x=12fdf9a8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=05c1843ef85da9e52042
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1464ea2f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130db31f180000

Reported-by: syzbot+05c1843ef85da9e52042@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

