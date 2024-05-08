Return-Path: <linux-kernel+bounces-172578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B639E8BF3EE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652C01F249FB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E504C6E;
	Wed,  8 May 2024 01:11:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A22622
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 01:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715130665; cv=none; b=pACXOxWi1RPY7yqlylb/imEDOGNe+G3YuJZExjgSK1HRz22S81mB4Pvv1Jfkdm6uMGy30NLs/6kz6V0ciSZ+cDBCfbAUVOj9xO77N4cWTFXBHUqXNN2gpUH2tK4yhiuJAVpjHnACRGbTOFyCfEzKSaMu38MXsF5BsNqhZuMnlig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715130665; c=relaxed/simple;
	bh=ComJ7Mq6e1Rkio2gqje2gB81UYrfcIxLx2vomWU3nHw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Znu2QvjJP2vf/ZblcdITumpGEdgV71W+oPx9yXPOhjj4ZiDMZrsr16gmWeIGytIt5iEzyy2Ywk743sXM9GRrOhhTzN+4MRE1cVuM17srqHKnHAlMW0aWR9ooX/XlDpP/FvI83vPQLRFw29TzGUvVYTl/U+oNsvpySgo52RwN/bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7da7d4ccb67so442858739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 18:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715130663; x=1715735463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCDXw2gQqk3jTpIqfVkM1qGItUI3O219WvpvPgx8/w8=;
        b=iSiQXt5n2c6IjJpem5FdFa+oWXaAD9Ll/7jjTbHilGzQbnLmeiVlj7IDKcllt+7vMz
         NgysYSTibuU2YflbFybf5zsmHOpRu8NHly5C6BUEZeTHjIB4JanbU12yhuZUBJrxgYI3
         dm9ILWQG4xUqTLmmPiEEPEgeWzxR6ziqe33YPN5xeBFliSobBbBA7wQr/wdO82MRcyuy
         uh/0QIOvuEDEuEo7XynFwg80bUOjIWwG5br2VvkDrbzRFoNGWuLPKWSZgpCraWXwf5XK
         jq9v04sc/sAdDrlEFf0euA5Nqrgt/u6ilCSgIc+7Axg3D7Vf9ZQuKkHPip3h0ZjHQuPb
         TwDg==
X-Forwarded-Encrypted: i=1; AJvYcCUh4deYM1CwXYqd4m9BjerVQjwQ+cz9HzfKJNI2x4qOU6wcQm6S3YHVCaWzw0CiuLSHrlGB+m7jjvrObptre+90dnZysyVpbJrnIZTq
X-Gm-Message-State: AOJu0YwEG49+C9LMGzyUGojUA/ao6AT9uHKYzW6uGZiB6T8wKY4CHwRo
	6g+dVnuVPvMXJindCpkX/inCbNUvxDpjJeo1q6be+xSarAxY59BbI0ErkM5Fv2p6YrNCDJ28NEQ
	5GyTRrbjKZlspxmSoAqTwJdWBp4q9kZ41ZV3zfFqqsl0Pnt69HQ8d+c0=
X-Google-Smtp-Source: AGHT+IFi/rL2dWS/0pnDUEdd2wPnRN+7V5vGNWHm9uVNPfzIngyJWfb44KXU1GTbEffnrKm23GEwVf2CLP3TXushn//Y6+TOg1o7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:270e:b0:488:75e3:f3c5 with SMTP id
 8926c6da1cb9f-488fd34f405mr72866173.0.1715130663577; Tue, 07 May 2024
 18:11:03 -0700 (PDT)
Date: Tue, 07 May 2024 18:11:03 -0700
In-Reply-To: <0000000000007558ae061553f41b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2475f0617e6f9ea@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in hci_sock_setsockopt
From: syzbot <syzbot+837ba09d9db969068367@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, eadavis@qq.com, hdanton@sina.com, 
	johan.hedberg@gmail.com, jolsa@kernel.org, laoar.shao@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3505cb9fa26cfec9512744466e754a8cbc2365b0
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Wed Aug 9 08:34:14 2023 +0000

    bpf: Add attach_type checks under bpf_prog_attach_check_attach_type

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=158aedbc980000
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=178aedbc980000
console output: https://syzkaller.appspot.com/x/log.txt?x=138aedbc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=837ba09d9db969068367
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15807005180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1777929d180000

Reported-by: syzbot+837ba09d9db969068367@syzkaller.appspotmail.com
Fixes: 3505cb9fa26c ("bpf: Add attach_type checks under bpf_prog_attach_check_attach_type")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

