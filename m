Return-Path: <linux-kernel+bounces-526856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AA4A4047B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 02:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349EA4225EE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107CFC139;
	Sat, 22 Feb 2025 01:01:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D44414
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740186067; cv=none; b=oFEqpyY1WVPIznZiD/lHabV2krmwHbSAk7PAMP7AOrRgQdlcXFCBlyCLDGdLslwcHYNwyVnXQQbuJHSuD0SsfMGdkzx2llA9k3m5VDvC6F/HRr55bxt6Gc3eZFB468CBr3ZWttZ12wHGkvODXm3+ohAHOpDy8UMa1D4aN8/8B/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740186067; c=relaxed/simple;
	bh=fBCMcXRPLtFr7kTbuvv2zc6MOF5uzJoIw3tIBZVBRJA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nj4ZU6D9NYL55OjDVRdSeZc5rG6I023+dzyfWkFuEydkAWcTyFelMu2xHSavgCBLXd7ix5OdFGPm+Fyp+mO7+w8anSJp/Vf3hP1T/t/69Ab9H3Cwk1wnNLQ1wuCrfiRlErowfVcf24BQlUP5LMkTz3AZvgL3nMVd6YiTIcuRcp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d2b6d933c1so44343445ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740186065; x=1740790865;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/g4S0rtmAw1ot+JHLgqMoNm8oJhYI82knnP6GthPD8=;
        b=e+l0LDdTjaVL8gWUgESQQiwJPfoRqYHK568hMyROHBzeXMgJMP6rt/2NKUwRnSf/mW
         zDPSdlt0BGbfPpmtutWy9H2ePND/6pv8D3iSzoRZtsQQW+9hr30XXPZQwLEusgClTfKh
         lJpTnJZkUTf1LjaO8T3JNm60CyaVQgw/thYma5tEAbkyIyP9K+h+kVpiy5X/4bWck4Gd
         R7qag9qKFKc8cD08teo3PAAuTh2d/67OlUG808bDhtNeoZo4NSQbhs0d8fmkvfB2p4iT
         DVvCES71ou+2hun9kvdAuy5ulYhFSDCvAtZPCYGajzQjRGez/EtJPXw6mfCFEL7/gUd5
         cyCw==
X-Forwarded-Encrypted: i=1; AJvYcCVasBK8nbH85lawM610DL52J8ssQjwD/G8xqvKIY7kg2rLCNuVCWb48YacRo1rRjhDduMkBoXcpEcUpy7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+b5Qj+7ziTcFNPbYvg8y5nUwyWXSFdjtHHfvR7cvJDQv4YDC
	Qn3HyotIhCOJa+NBNoWy6ROYgFTmeS9u1htiVLw9cFasg4Njy04vNhcgtvZji8OhJY2UOtDAItl
	vkZe9jz9Qp3cFPwiQ69i0HvL//OG/6Oi3h/YvO9YfgvoF6v66jjX+34Q=
X-Google-Smtp-Source: AGHT+IHgoyRHGT8n2U0f5nj6pPzqwrGKygIICQiEr2OtsSPaOB+ITbxhNydQsZDxgGQfDtmdo9Zxgj/pJ5wVYO0LRhPBmI7sHNy8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe6:b0:3d1:9cee:3d2f with SMTP id
 e9e14a558f8ab-3d2cb51e40amr59265405ab.18.1740186063888; Fri, 21 Feb 2025
 17:01:03 -0800 (PST)
Date: Fri, 21 Feb 2025 17:01:03 -0800
In-Reply-To: <67b8a9a7.050a0220.14d86d.0578.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b921cf.050a0220.14d86d.059a.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: use-after-free Read in check_dirent
From: syzbot <syzbot+87078ad27cd8af3263cc@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit cf3da2d627037a0848e25dbaeaedfadfe534c7c4
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Mon Dec 16 18:58:02 2024 +0000

    bcachefs: Handle -BCH_ERR_need_mark_replicas in gc

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10e887a4580000
start commit:   27eddbf34490 Merge tag 'net-6.14-rc4' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12e887a4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14e887a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b03346163189483c
dashboard link: https://syzkaller.appspot.com/bug?extid=87078ad27cd8af3263cc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ce6ba4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11300db0580000

Reported-by: syzbot+87078ad27cd8af3263cc@syzkaller.appspotmail.com
Fixes: cf3da2d62703 ("bcachefs: Handle -BCH_ERR_need_mark_replicas in gc")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

