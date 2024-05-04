Return-Path: <linux-kernel+bounces-168578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FD68BBA5E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 11:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2D97B21C95
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 09:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5058517BA6;
	Sat,  4 May 2024 09:48:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8983B1A716
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714816085; cv=none; b=PCuHIadxOoqQ5KfKlG+F0g6cZalz04tKLMKChIy8aZm8FGQIAJiq94H4Bht0I1m0Sj6bQ7EYbJrudA5YjqNHvTiMkrfkSZ/GMcxo87OMG73s2Zmn4MjM3sd+8hDlK/XzKs7N0ACZaJQ3HCs1D5+209MdLp8Iw3xr5NDp4mETKrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714816085; c=relaxed/simple;
	bh=mhuJM+GfCQH5IMMrJMXVP9OBz/wYR8fa+oIkbwJ0sFM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fJjNgJiOUUgWXm6egkD8TTSVq2OWMNafIIGYecUjqyaEJNb/isErowWtqUFM2rph1Iy6yPqK5o7KkOqAUBCbeeMm7Bf6J90uoE7DTw16QTJmEBUNl0C1oe7NVl8fK7PMOFn1YgaX8Mj7dShRdyetu06RX38e6qzWIc4CxRvI7Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dec39bc0a4so50365139f.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 02:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714816084; x=1715420884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vMfvjlUyZ95gb2Bl4Phjw9KVzOE/POZUXc/tMc9CNs=;
        b=Fa77UZfD+QWa+yC0vE++h+aSsNJpxDhLa7UoFGKG0ju6zyyA5P6BJ6BPZO9CJy2D0h
         wScORIElKmk/LUwF+AGW308/tM8UN4f5HZRT7kF0UOWpIxvF/QJdXUngRrFPiUydYy9I
         ewU2fGYf0HvdYKh/UtACnXAp1k8GbqznR2DtR+b200USV5FLrTdUwGwLIR5jg+lGWxG/
         LTpFQ8B+5RiOwYWpxddf/+D3eoU3ETDEbhuzwViP54AoaatGQMWqsCl3OqH9v2r4JDNV
         o0yt+cyrSja/19EZq4WO93nBPHOUTPU0jMfIlDsKbkYyh0jFZPt0Ed4uNJUEC4tpXAIP
         ComQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkoXVxP+vvIIPfCa8t31noRhfCT2sVRe/LPW7v6XO9Wim2ip8kWqclOMNuS/K41S3n2n8RzDAuovyHKc827vW00An0ru/qsTIpRhUc
X-Gm-Message-State: AOJu0YzNIG4MjmXGlHgE1/+im1Bu9pNU0bA3aOJ1SQD3kn4ZNzWPjzTD
	+bYN9Rh7/mfnVyAymmy45mCVzgt9/BnxBYShsbQeX06OvwBTZ39ueJv92RpUOpzMdzrj9NKXiba
	rnEBsYdorpGhNbu98FCeRy6ytdGyo8I/DCZsixdWtEeAPmvY27HnmX4M=
X-Google-Smtp-Source: AGHT+IHQXiciJ6Z11FdD4VBp4JCah2SN9/cx2OFqZQ7b69cg3huTCXgpZXSYi/CyAHP6kwLDQ3n7Nn+vJOJX7J3D0KyvntiXiiQT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:a58a:b0:488:59cc:eb41 with SMTP id
 kd10-20020a056638a58a00b0048859cceb41mr36069jab.3.1714816083873; Sat, 04 May
 2024 02:48:03 -0700 (PDT)
Date: Sat, 04 May 2024 02:48:03 -0700
In-Reply-To: <00000000000078baec06178e6601@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088e7bf06179dbbe8@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_trans_srcu_unlock
From: syzbot <syzbot+1e515cab343dbe5aa38a@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=147f3908980000
start commit:   f03359bca01b Merge tag 'for-6.9-rc6-tag' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=167f3908980000
console output: https://syzkaller.appspot.com/x/log.txt?x=127f3908980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=1e515cab343dbe5aa38a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d42c70980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ce8250980000

Reported-by: syzbot+1e515cab343dbe5aa38a@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

