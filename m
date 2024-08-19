Return-Path: <linux-kernel+bounces-291443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1B19562AD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 06:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C332823B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A287A14883B;
	Mon, 19 Aug 2024 04:40:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C664228373
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724042404; cv=none; b=aVHY6H0/cLp1bGB/ksoCyuI4Eo+zSpJpqIqM6bWfD1DwZPZQs0GzB0GuM66G1dK5NzlLwgntGOm/uo5BtEOHvYRAaXGVuKy+t4x7gFfiH9Q1CKCXHvrV08LC9g2ZcR4vOEiYcWCmuxS0cnqD8I3aS3GWu364ihWfqlgq2l5p/QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724042404; c=relaxed/simple;
	bh=ndPGcz+uTi/bIYAnyjXxTlLhFjz2KeP5UQ4eUxYbKxE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MKZJQqiaibs/ASYH7Gufnb+yxftNzgeIJ0dpqDY7kdJiVHX72cyDqOtTnLY9QhflaHZuRb84cEiPwQIncQoKUcGCfBEretIr4NjFURjPqjTWglT3U1ut159oPJi7O3sAZ+UAvo4Vid0P31yn3MfTPah7fHa8lBauyI+rh+rYlLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81fa44764bbso427889939f.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 21:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724042402; x=1724647202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QxjT7FBtIf+YOOl5Ydo57Y1HRHDgzWdhn/AVlpRKbU=;
        b=s++uxt6qmSz/2AdU+k3gFD54R0WbDNg8Ptp5azcWB5GDxnQI5yWG/ZRXLodnChfAX5
         MiCZh6MLqKrYZJte4DWCHqsprdBEnDqQJ2q2FPGblNQbAQ7fBVUOrozFVUUBvXHcWptB
         sld0n1vTvUSVydDtLM1qvvCpTrc/IIGDFkRV3eNzv4UK1Vv3H1p3ZrAOoJd4j7zoYi+r
         cZaU6Kj5DvtyZ7iT3oOSqy568Jc8k6xSdbwsr/coYOSJr6a274FawAcVnTP2JvPKX7um
         DkTMlfPn3IX528FRm2OgJc430Tw+G+LSX8Ff0YBtRnUJ2xvgh/s3i34sWJ+NypxYkcSn
         gXSw==
X-Forwarded-Encrypted: i=1; AJvYcCV5ROg6djcfAkpNQxyr8XoGYFBbCkfNHnk0Fe4QX9Dq4nsqB4yoEJ4NoD2A1s6I+PIME/ySE/Ql+LjYIx1IYBI+wqnwFiYHG5wTqFnJ
X-Gm-Message-State: AOJu0Yzz9tlSJt5BP8dUA9Kmx1ZFGtwe+xl6pzQeYxnjFhrQceGiGMer
	ydcp+fdDeYLseeHh93ERAbhEEF0Ue8QXOrz3/5Ixo4Hhh/eFM1wBwXVF7r9yAzMlA/l83Irfl+c
	LWrm9nTjhC8VkLa6e5D5hAEcdTRxBPnGzabFlML+4tzOVFbLFbIY0mf4=
X-Google-Smtp-Source: AGHT+IH316qYQj7K/SEBVPvVeG35zflMK2F/Sc4nwXd5p9/IyQ5MeXxoQPgP4Q0j6l2BAJ0YCA/7X4FcoFqLlYh6md2L53cvBiuo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:370f:b0:4b9:e5b4:67fd with SMTP id
 8926c6da1cb9f-4cce15cdbd5mr504210173.1.1724042401927; Sun, 18 Aug 2024
 21:40:01 -0700 (PDT)
Date: Sun, 18 Aug 2024 21:40:01 -0700
In-Reply-To: <0000000000002be09b061c483ea1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1e97e062001e6b2@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in __mmap_lock_do_trace_released
From: syzbot <syzbot+16b6ab88e66b34d09014@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axelrasmussen@google.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, hawk@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, lizefan.x@bytedance.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, netdev@vger.kernel.org, 
	nsaenz@amazon.com, nsaenzju@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, 
	penguin-kernel@i-love.sakura.ne.jp, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 7d6be67cfdd4a53cea7147313ca13c531e3a470f
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Fri Jun 21 01:08:41 2024 +0000

    mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d48893980000
start commit:   a12978712d90 selftests/bpf: Move ARRAY_SIZE to bpf_misc.h
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=736daf12bd72e034
dashboard link: https://syzkaller.appspot.com/bug?extid=16b6ab88e66b34d09014
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125718be980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14528876980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

