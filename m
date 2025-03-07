Return-Path: <linux-kernel+bounces-551584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C557A56E3A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E15168919
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD0123E251;
	Fri,  7 Mar 2025 16:49:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECE521C9EA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366145; cv=none; b=YKBQaYASsRa8kYydNXBaEYpHCtqdMszq68/FBPu6Sp+ob3PgS/1Ud9kka0mmpYyTftvAx2R5vNu4Sg+guXeW2Zgip1G481LuPVw+QLtFR8iqo7X6sZYNFFTanl6cB33a8h9PlMqFwV+M8ubGSxjPzLZ7IAl2lcS9yRi9T2F8wk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366145; c=relaxed/simple;
	bh=/wJpuBYFGqyGsKcbfLoTIr0DnUogrkKUH5AuAlKld8E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZW8x1Hwx4wNyaaA0l1R7UHQsOsfXKaaxCpeGK2fB/YfkRzSuHoXgrE/GG6W1tZdmjBe59GAwYo5RYim3lpO6Bg/eDtmg4DJ7QBC9gsuZ6ozeSaUt8pk5MTPX/qdNZUv1fPIMIwBz+vvkQ0YICcNEbFgXyhhf44KJkVndMpLtoGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2a63dc62aso14126305ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741366142; x=1741970942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IStmfP5lSAveeL/IsEub3Jooz8LSUrjwYZpqh/aSwSc=;
        b=WXwEZc20HK2xxxwx0k3y170GJAjvJIjuef61/OZRqwjvdNOAGA7Jl5IH4uEDhx43up
         IdrWqiXDogY4xASwPvZUU3y/9ufrrNoKIRmipc5r2D6tsCdpcZYkE5qhR8XG3aqSpwsb
         32VfoTkBh+q5vGFQHroP6AaePfXp1uNZyUAN610B7bc7wudusqa8Bt1ivElRU9+IYY37
         bHQxOaw4j9XU+nBi9NiYHiKS5yc9RZ32v7PYAj9ZHsAcsxbE6L2MDqxBTmu+9C5dO6pJ
         wnD32SV4xPwsAc7H02qcRdNo8hBmeN0Eo8kYQ1jVBVH8nCglrF2xR7iOZ3XNT7TE3Lmw
         NAQg==
X-Forwarded-Encrypted: i=1; AJvYcCXH1VY+jtyLS6UB+B/oqQQZmdLPROY9x35+BTiq4RtTf3Rru8bNZ4YocwcULwO8yAsYfbWV1bk/ca7Bd7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO61biPPATDa8JbF1+CMnKhjST8gbLdFurfb+6tZzUruI34PoV
	R77kwIUwZUP2C58i2lzlz+Czfv5kO2buxzdD+L40OHO0Lc5mAZhuov1MrdXtcLhGmIBr5sPeUNG
	A8ErJF068e+J6xdIg/ynRXDQC9xU6EqwTCWWbj25EjImiNDYKEAJIaXM=
X-Google-Smtp-Source: AGHT+IEQEA3LcE1eWTG3gvh0ZwCgkrms9t2GE5rGU0lzz95rIXyhA51eK+YLb5oJtrQ5onsKI2ZsJZJE+ZXfTS9GGEQJuyO9T+Vh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174b:b0:3a7:820c:180a with SMTP id
 e9e14a558f8ab-3d441a12ce3mr52846825ab.19.1741366142691; Fri, 07 Mar 2025
 08:49:02 -0800 (PST)
Date: Fri, 07 Mar 2025 08:49:02 -0800
In-Reply-To: <CAOQ4uxjxbhJPDCBnuMMmkPchFiDOwX82-35jbhbrQkbp2Rsy6g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cb237e.050a0220.15b4b9.0083.GAE@google.com>
Subject: Re: [syzbot] [xfs?] WARNING in fsnotify_file_area_perm
From: syzbot <syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, amir73il@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, cem@kernel.org, chandan.babu@oracle.com, 
	djwong@kernel.org, jack@suse.cz, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com
Tested-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com

Tested on:

commit:         ea33db4d fsnotify: avoid possible deadlock with HSM ho..
git tree:       https://github.com/amir73il/linux fsnotify-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=12494878580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afb3000d0159783f
dashboard link: https://syzkaller.appspot.com/bug?extid=7229071b47908b19d5b7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

