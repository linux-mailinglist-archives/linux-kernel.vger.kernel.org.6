Return-Path: <linux-kernel+bounces-378867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33D49AD678
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827B91F213C1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983D11FB3DD;
	Wed, 23 Oct 2024 21:16:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7EC1F9A9F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718166; cv=none; b=Rtj+e7F4IyEoAPkpupUJglNo7l2yPIocstiTgZ55qNFpmd7OReKOcACqYziZHPtDzNMgymzbWk+fQ60KPCWiTsOR580K6FqqXdmoKNg66L5vZoqOLJIntlsD8dakumTtK69UnqpRp3a2C7fT+tqH5Y21oV+JJE8ohNXcSYc5WMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718166; c=relaxed/simple;
	bh=hIjNRfSoc/8nccRfh5ac2kal8Tk6TaVwrgpkPT8kLgc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NUQZPhdATbBrkKWuUVKtxQNbXpDFxMYUFgNTxWiWH3MzIaNDWA9rC/BIaEwJ8/omgQqFzLZyYbwltGJLjEDUt9EZrI9uBGEjHQF51rV0pShcHUpRm5wsjMstqv0ilzgp3YCFtir/gKxA705VewHey0/OycMHxsBrC0sRoi2g1LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83aac7e7fd7so20955539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729718163; x=1730322963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOqZtYtvJG/MRqdt+QqIV5emQxBmRTkY28ai1ScbwFc=;
        b=tp6vvc4YEpGv+8+WxnHpqIbRjb0NXuSkvndE6iAWSLMLYXLvYBz4ejbWcwO2ZPxaKK
         AzkPymeAPBUxTngmUAxv9kVo+Vb1mFKQ3NkPyqIDqttoJMcuW9Z7aquGoH2YPsrbhAup
         D7WZ5pjOc/sw5nX4dMgRos+PMA0Subfqve2PNXSjIuNWFZwC7FSaVSGTPk4SNj9bwHQA
         +dvKhiZYjHO93OKjviSPuVqTOotjpwAuyS7GzM41GMAYJN7JUriOpMtp0qO0Eyr9ADaz
         GCJi9kYVyfOoIWuyPL/5jBPjF50NG/9SJN9ziHPP8yoKkUdLwhC8H+xPZZnFnrkU/gRT
         8gFA==
X-Forwarded-Encrypted: i=1; AJvYcCVteTgL0qJxg/4ibklM39Llyumib0t6EYRUdAMONIiTSl0Ec7z8++oY1QSs0P3/3nUbaf1KnmaFx0gMoik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/no4OxXOyDOlt3ZlmgHi0QsMstcyz3wDcQeMyQ4/XEXlQpqz
	EMGqP0Kf7QGoJAgpSi/LIwRPKUiXftPURT09bqY+K1ljDjWa4ua8xUg0SMIok92s4D1e3wN4oCN
	doG1x1JACvpVDzEoMfGhiqRVfqh41VV/xKbcVkY0pXh/UKS+FIeAtwNo=
X-Google-Smtp-Source: AGHT+IHjpLzZea7VTuKmO77qGv4sp9lLcABQw5+m0gZnKV1/DgSAIzpn8jRY0ScyHOmTnm0cqND9R/iX2UZgdenU4ChuC2+FiA9v
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d90:b0:3a1:a243:c7a6 with SMTP id
 e9e14a558f8ab-3a4d5975e59mr49016035ab.10.1729718163604; Wed, 23 Oct 2024
 14:16:03 -0700 (PDT)
Date: Wed, 23 Oct 2024 14:16:03 -0700
In-Reply-To: <671907d4.050a0220.1e4b4d.008e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67196793.050a0220.10f4f4.01ca.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in validate_sb_layout
From: syzbot <syzbot+089fad5a3a5e77825426@syzkaller.appspotmail.com>
To: bfoster@redhat.com, gianf.trad@gmail.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12accc30580000
start commit:   c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11accc30580000
console output: https://syzkaller.appspot.com/x/log.txt?x=16accc30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41330fd2db03893d
dashboard link: https://syzkaller.appspot.com/bug?extid=089fad5a3a5e77825426
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109dd640580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f288a7980000

Reported-by: syzbot+089fad5a3a5e77825426@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

