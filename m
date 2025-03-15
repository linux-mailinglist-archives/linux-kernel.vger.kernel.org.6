Return-Path: <linux-kernel+bounces-562433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FD2A62750
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 07:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAE3A7A5771
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 06:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA82619F461;
	Sat, 15 Mar 2025 06:27:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D2A19F116
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742020025; cv=none; b=liJ4KE64X0j8uXWpH+fUZLnTRqBqapxEEJnl9y61Kajil7tgjWvTovET1NzhqoYJPos/aDEPrv8a+SBnQmdVGs9jH0otjamSemRHgVqgiNhbJYWfCZMHC/TjXZNmfEfBl0ARvIgDh2IuaMkhkNQsRJtW0fiuToVeezBtMDwNzUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742020025; c=relaxed/simple;
	bh=8c8BP0ZMGpck2i/dkvXUZ8GUM3AehfiBO2W2XuuOlrs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=obZCGXP7vnO4vtYwF4J4MRdGqpIZ4Gw6+nbkAfkrm56JtdjwNHU+C4287SLhkmnjeYWynbRufEBriRfMLgxmH1Wri9Co91tKV6aTMLwtwVqqjAYOOh3r6Oufhv3PxOug1LL7qUvlrmy94B0G886aiheKA/XPEpKKZikCXtUvDTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85dad593342so289926839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 23:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742020023; x=1742624823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVtpvCBBSFNWY2hi10N0rrWtsxl0Zv5MnCY1nXMRHOg=;
        b=gZKppznu/NnUrIuZi62m26MlcecvTAn35NlOXpzj70NxaY52FzUpiUCwjDUtT4wpIZ
         NIfCj6BH/VkI9E4pkhtCUGNy159s/KMQWn2p34OrFUp0D/92FykRXG5h7NQZZtNYXOjx
         XlMyvNP1SX+hpqARxERK+/5UbZw2q5dq0cNsIAcJF8XkkKS0pI8Jsez/5hStatI5BDzQ
         xfytHFQT+jyuM1Bo7iW5ublgrhNz8DyFFMaTxSm8mqAP3rscmeNHWyODxusJmt9DggRz
         v5sI8oj05tvqdLzaJkSXIVkc+8W4uZKWsm208KFnzfAOBxG1ShPbv8DtfV+Bh7JOp/eA
         xySA==
X-Forwarded-Encrypted: i=1; AJvYcCVLF01juO5dsQzNrC31taa476g/Vry8LYnXaYVIuTC0kz39zul0vWAdDQ1e/5Q3C4fWrI6nVo7NX9z5IjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUYYV6YDWZczUfcvTZw1J4iooyG6/ZX0vIiY71RUdngRTFpmwx
	6QoolaQXx0qO8/i7FJTDbolpCOFTUqKmcFueG/laMJhguUtscAagdSBqGFLRZCFKq3UIEaiD0GV
	cKcgfoHYGYLL3tNNiX4QDXxyIsdJhJXaESZwFUYAhbr351Il+3N+OE+0=
X-Google-Smtp-Source: AGHT+IHc/Hlt9d/2Xcr2kHdqr9oeeMai8KZOoyvDaGLKjBOLJUUUPVjAKnMWCJKX9sd5n0l/KK74b5/g18o59nKXQM7eSaHz3zM5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d06:b0:3d3:fcff:edae with SMTP id
 e9e14a558f8ab-3d4839f5d33mr41770635ab.3.1742020023054; Fri, 14 Mar 2025
 23:27:03 -0700 (PDT)
Date: Fri, 14 Mar 2025 23:27:03 -0700
In-Reply-To: <20250315055941.10487-2-enjuk@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d51db7.050a0220.1dc86f.0002.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Read in atomic_ptr_type_ok
From: syzbot <syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, enjuk@amazon.com, haoluo@google.com, 
	iii@linux.ibm.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yepeilin@google.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com
Tested-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com

Tested on:

commit:         2d7597d6 selftests/bpf: Fix sockopt selftest failure o..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1397704c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=a5964227adc0f904549c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1188ae54580000

Note: testing is done by a robot and is best-effort only.

