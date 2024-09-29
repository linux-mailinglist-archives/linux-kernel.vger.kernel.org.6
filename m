Return-Path: <linux-kernel+bounces-342835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F3D989374
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 09:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448EF2812E1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 07:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514452F9B;
	Sun, 29 Sep 2024 07:25:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4043513A271
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727594704; cv=none; b=kfR7GPIhxfsrHLKvac8Veeka1E9zKWYWNgF6EqZwlwFS79/nG9NCNA3xzp0rkl+M4olh6z2oZqrYTa01fiS/WGUmtcRrz69SIjA6f8bLjD9M4XsvKJPAAuA/1J3yK4XM8lpk9D5ofDLri5UFuU3RJyaiTLUHZ8hBIj8fP3Bcl70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727594704; c=relaxed/simple;
	bh=QUQFLsgcakmOxqNIX/ly7cXSo4bace+PZlvi10aC2bo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fTZJa8A3ursiJAUX7XSh7j5mbrectSK7hwHJsyB9toHDSER2D5THw9qFosOBpLHLcnbhJs7HBzM6Mae5je/wSSav2ET68DGrxlbp5zPlODyAUg5X/ofPybj49xHHr39u2nqtlXevoB5wuHFpl/ibqHX7eutQLFi2TCPGnanu1iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a344da7987so29959745ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 00:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727594702; x=1728199502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RiNNBzBiCFuCTjOXv7t2eBGAGAquTt6DCpiBL4q1mkY=;
        b=DMdmaNi7HMB2vnnnihv0LKU9JizKJmv2QKuDb6/Ip6+nBbL0wrQ3j5EHglg+X9m8ca
         DUUGn/9+CIyy8iYIkINd8RIHm3CY67r1tcC5OyGehNFa4hdiXxoXDLeISRPwTCiLyMfr
         7VQqn8gUJy2Im9n3MWHBXWdN4ueYxIGVxXSLVESnM2SF8k/2E7ZRiUWdwSMDJY32PsPH
         67tnQsspD+xGIW7Tt9/lse3w3A5regxOSvu1tyRloll9Fm2+Cm6FEQX8JtP1JstA128C
         sab4/gjPUSM4rgCIHpH2tzjKaurz6KxU7HQBf7uMxDLmrseNvaNnJcF4xAbCO5cs3z/p
         soUg==
X-Forwarded-Encrypted: i=1; AJvYcCUKBuIcSVDDuiBNVxdxQCQzYDZlk1DUfTDOLIubKoux/f9HIowqpxjR5rQJ/SM+p8VnIWW7kLX51kUs/TA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztr0tINl11MjRRGlm1sbHXllaEZI1A9IX3Q3d8rIYmK6jaS3US
	1rv1AmyHri+jR5FGrObRpYtxidm+ii0oKlS7ScJhibhIgtCZASDNzVDdWF6mcRk5BZ1zjdByi/v
	PGhjcRqwC1+9CC6lp2/foqIgmIHq7i/biGAMPxYreM08pkrkkcDz6nw8=
X-Google-Smtp-Source: AGHT+IGsVR0t+nezjz6+3pfe6BUp37rUtReguQpi53jhig1iod5w55MHl/Xa3NwmTZ7SLsC3SAYBD2PdWw2EVHSR5Yo91lGDCLvk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a05:b0:3a2:74f8:675d with SMTP id
 e9e14a558f8ab-3a3451b01c6mr78897085ab.20.1727594702296; Sun, 29 Sep 2024
 00:25:02 -0700 (PDT)
Date: Sun, 29 Sep 2024 00:25:02 -0700
In-Reply-To: <66f62bf3.050a0220.38ace9.0007.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f900ce.050a0220.aab67.000f.GAE@google.com>
Subject: Re: [syzbot] [bpf?] BUG: MAX_STACK_TRACE_ENTRIES too low! (4)
From: syzbot <syzbot+c6c4861455fdd207f160@syzkaller.appspotmail.com>
To: andrii@kernel.org, asml.silence@gmail.com, ast@kernel.org, axboe@kernel.dk, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mingo@kernel.org, netdev@vger.kernel.org, peterz@infradead.org, 
	riel@redhat.com, sdf@fomichev.me, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, wander@redhat.com, yhs@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 893cdaaa3977be6afb3a7f756fbfd7be83f68d8c
Author: Wander Lairson Costa <wander@redhat.com>
Date:   Wed Jun 14 12:23:22 2023 +0000

    sched: avoid false lockdep splat in put_task_struct()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a00127980000
start commit:   abf2050f51fd Merge tag 'media/v6.12-1' of git://git.kernel..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16a00127980000
console output: https://syzkaller.appspot.com/x/log.txt?x=12a00127980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc30a30374b0753
dashboard link: https://syzkaller.appspot.com/bug?extid=c6c4861455fdd207f160
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ee7107980000

Reported-by: syzbot+c6c4861455fdd207f160@syzkaller.appspotmail.com
Fixes: 893cdaaa3977 ("sched: avoid false lockdep splat in put_task_struct()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

