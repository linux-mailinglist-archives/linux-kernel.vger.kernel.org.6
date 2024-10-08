Return-Path: <linux-kernel+bounces-354816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFAC9942EE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E80284A3C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DC6178CF6;
	Tue,  8 Oct 2024 08:43:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8A13AA47
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376985; cv=none; b=gfPL3GaykdOWvdGSfs1sTVBqYj5I2CCF5RwNQrfGdoIiEMhiP6kdcNP3d+xJx9PAy1DNqU0Bwmytxt5DREgFlybN8IsXP+4UEpp5gOAu3d1HunYwLm7JH7vKOPOXi3usMx4upOKOJlNbFGXpI3UmwB+7VoYAyVcKZxGx/WGMl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376985; c=relaxed/simple;
	bh=WlKEQjsIZXvP+MqHhNtD7QBSr9iZ9S5Dnqi5AAZN05I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y/yizlu33AdOqq4KU23RHyUTH2W0v7/K8YSSMYnrNgZ7lD0Lbrn6VhWENMazbx9jIxlP98qKX+ZtjH/kCCfpCPmCsdCMNQmFBSmZXC6z6DgpK904oSizUyI3Hgt7yWD8j9pBwqi1jGLr2B/N1PzIbULcb+cM4Kfe8k6JYIYR8JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a19665ed40so39835405ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 01:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728376983; x=1728981783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVS7fVKH71Pe8fCQ0Gmt8UDN3roCi4HGtPl5gMiYBCw=;
        b=O1XzsYxqcjd5Q5QLpTE9vD5J4HZbha5xJ8rfKX2Iq9kBWjltdAesXrf/9cVBsCEAN8
         7CL/n7D3miVxLX1NC/tvg+dy+P64o4ArAFBKoip0GOnvutkUChVAfeY7LhOpEvHJzKO/
         yj6gxD/32mI6yzBfY0dxbO9GjbzluMjEtkg9S4v1EbBhflNkW3mEgsZP+4ikzJ2/jCVy
         uS+50xfoCU1Me+PoHDOKNM2moSlP9ppY0u1SykGs60N7hI4hdjZzgE3gpLHQX1TABk81
         S1NhZL0aE82IMdHOScsiSA4kxaSGZ1jZlry1/0dG6FIxeI+HmOj1jp3sxVoKy06onjGC
         WFgA==
X-Forwarded-Encrypted: i=1; AJvYcCV74E2Gih7dp0gxsHqvbSZD73Jl1rCwyaem7ho156SHog8uupAaIudVJPzCicUlX70SzE1CqeOwg+tR2NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBTyHHaJ6KfTY5ozvQZbim5RkwdGc4N4KsW6HHTr0ahFkvKYFk
	/R0FPy1hRzHs43jPacoa4AF1UovWgRiuBkSWmRR9m1FaBRI2qX/cY8ySwn6/78GVE7t5Dk0PBfE
	14sQP4g6wGckQLoKQsfTLpKgLkRyIdCzobfEbZnbP6Azu+MzAe5ZrvJ4=
X-Google-Smtp-Source: AGHT+IESTZbom871uQ+CoDIEKTNpyDbqRog3FH6w1KkzIBYyio92XHoOeJntYRpQKOQLJq+XZRNOtpp4hxIcrguae0Kq4CtaquDu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:870a:0:b0:39f:325f:78e6 with SMTP id
 e9e14a558f8ab-3a38ae3fa4amr17042185ab.0.1728376983353; Tue, 08 Oct 2024
 01:43:03 -0700 (PDT)
Date: Tue, 08 Oct 2024 01:43:03 -0700
In-Reply-To: <670429f6.050a0220.49194.0517.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6704f097.050a0220.1e4d62.0087.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in push_jmp_history
From: syzbot <syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com>
To: 42.hyeyoo@gmail.com, akpm@linux-foundation.org, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, cl@linux.com, daniel@iogearbox.net, 
	eddyz87@gmail.com, feng.tang@intel.com, haoluo@google.com, 
	iamjoonsoo.kim@lge.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	martin.lau@linux.dev, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d0a38fad51cc70ab3dd3c59b54d8079ac19220b9
Author: Feng Tang <feng.tang@intel.com>
Date:   Wed Sep 11 06:45:34 2024 +0000

    mm/slub: Improve redzone check and zeroing for krealloc()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11ddbb80580000
start commit:   c02d24a5af66 Add linux-next specific files for 20241003
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13ddbb80580000
console output: https://syzkaller.appspot.com/x/log.txt?x=15ddbb80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94f9caf16c0af42d
dashboard link: https://syzkaller.appspot.com/bug?extid=7e46cdef14bf496a3ab4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b82707980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f4c327980000

Reported-by: syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com
Fixes: d0a38fad51cc ("mm/slub: Improve redzone check and zeroing for krealloc()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

