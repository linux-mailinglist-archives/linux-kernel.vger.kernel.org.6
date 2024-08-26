Return-Path: <linux-kernel+bounces-300700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D23195E755
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 05:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCEFD28029B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 03:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B67374C3;
	Mon, 26 Aug 2024 03:32:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02B10A0D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 03:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724643123; cv=none; b=jt7eGAU54ioms+TRkPkW4ciCW2Sqpj3ZAeWzDWXs2SUiT7Oh5Ewq7P7ItXqFSDsvgRH2/xKrLMvG/SgRkZASSwXjX/Qra0j8vBev5tWiRZxqhqI6X1vmIDzyWuurJ9hmw8cp5PHyKLpcHK4MdETODcCdi1P25AmVDJ/fScrZwS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724643123; c=relaxed/simple;
	bh=+8yDqNMBMZzrHcXeLinY1P35asbAlrXJIGjPeOuN200=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o1XHJ6pgSiMZQIbpr3YhmUL71RXVK9nDAKFS2b+wNtD58UWHOIJMrYQjPpi1s2ezpJoA8x9FiRtqo9KPPSqIV8vHa6QhdKw0GHRUmQF5XEkGw83UqU2XYMokVG9eEgZBj5EaDi4q6TfICuiYgwHViOKpSIjSiAsuyPlhpFb4kD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d2044b532so37045075ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 20:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724643121; x=1725247921;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lEhT19D3jxJpq5MiRiJj/oy8okfkwj2gpyZ8RiJEPt0=;
        b=xMJRIrTW+LWAdOrts8u7aiaMzs+pj5corbBmpvCvYo0tSF0CD0bIinuhaGPmwkApbk
         Pg+vCBWahvoXAzUNNHEdMxp6ETMwP5UZDPIrEUj9HgrQwSdV9uV+u3kXU3eDtd/ODT5+
         liZ2NHzpTXDIlnDgfXKh6k3TPdS9ekDYBliD/8i6tE4OI+X4eHBTkxZ17kWMAWJlpnCL
         IHaEG4rsE6y8IcHFqxEXW6XRsjMY9UEhKO5FA2wCj7Gynswtn4TYEc3Mb1ZL4qFPNLGY
         3okXg1/gTPTtka0ptffSN9ecORhBkKTa/lLbenz5dLo1lHOzANa1/Hsh+FP5hQmx3HwM
         L1tw==
X-Gm-Message-State: AOJu0Yx7wSVBgJSPoWOGYePT9LiCTw9KnVYeqZwtEkeMRViVqWEMCXi4
	SkN6hoOiOgp7HNFkjPQ7J049phahAxcmpUVZdxDrkpWdJi/6I51RWQgZqPT5AqX2tvqcUht4lJW
	LA8LaRkC89h1FzSdGIKRbyr0cQ7vJ6Bh+UYLee9ULZt6DSSuI15CEVdA=
X-Google-Smtp-Source: AGHT+IHiw9JvIcRBlho+gRbloDMiQCKk/wa/xrepOgoue6jyiT6C9nIH9czwQetImDPqDlB+uqCnG8Jl8UqlO71ykBhXbPM0BFx9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1446:b0:396:1fc1:7034 with SMTP id
 e9e14a558f8ab-39e3c8e51b7mr6535885ab.0.1724643121542; Sun, 25 Aug 2024
 20:32:01 -0700 (PDT)
Date: Sun, 25 Aug 2024 20:32:01 -0700
In-Reply-To: <b0d4c21a-33f4-4e94-83e4-88c9e1f1c468@lkcamp.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fd09306208dc473@google.com>
Subject: Re: [syzbot] [ext4?] [ocfs2?] kernel BUG in jbd2_cleanup_journal_tail
From: syzbot <syzbot+8512f3dbd96253ffbe27@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	vpeixoto@lkcamp.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8512f3dbd96253ffbe27@syzkaller.appspotmail.com
Tested-by: syzbot+8512f3dbd96253ffbe27@syzkaller.appspotmail.com

Tested on:

commit:         5be63fc1 Linux 6.11-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17cbfa7b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8605cd35ddc8ff3c
dashboard link: https://syzkaller.appspot.com/bug?extid=8512f3dbd96253ffbe27
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c11d8d980000

Note: testing is done by a robot and is best-effort only.

