Return-Path: <linux-kernel+bounces-207218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD8E901403
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 01:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FB81F2232B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 23:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6081CA96;
	Sat,  8 Jun 2024 23:51:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA2024B28
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717890665; cv=none; b=MGtQ+PbzBn46TllLJonyY0zQZudDWocniExucnKeIUYa0kk6O+DH7SR5CXyY+Ttn+f/Maa7uLdA2dxgYhNgzqkGPcF1xuGA5jiySI6RRPX2qgiGfaqlOtswgvDv4dcNIZ+qKiQ5zi9waLUrKMP7+FrFJCNHhvvS7hR3AfHlZ0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717890665; c=relaxed/simple;
	bh=d0niSI0BPqgORWJ8d6uor4Qauk2a0PRIg7Z3CF9XdmY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BYmVHybRSSv7f7cZhLUoA6fXKgkVca/wfR1Xh9GEh6D3S9Qd+kxoAA5sUfpSOWSi9a6OzZgPB/LGDAectqz4uRzShHQDVrQNhgLHtheFzlFnjLztGHiwraeOwMojz3BP7CEVV6zWrNfNLA/X8C6cw+2P3m/Z4LIqnj/+v94FPT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3737b3ae019so33957815ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 16:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717890663; x=1718495463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1VLo2KJi9o9tzQVg0N1w+H/e9lvP5uDzyw9PtVc0as=;
        b=LuhfoqALCoKi7NUKHR1PLK8W6FCsOzI3Vs1yDrFgUvKZUuFvV7t8mNiyfkpBsZQMWT
         gx8aWgJwwAJr0rwajgUl+RaK0CatKsm3o1VHmR9xQ8XdnhpVnnNJMs50CxeGsADxHEGF
         wb6EZ00OG/V4dRMG66lDlkq7Oz7GINF7kFfXr/yFC7gMKdrEj1HyW2hdbXHl8uiC2MLX
         SgZwx/y2GrCOFgJtgCB1NbbhlwTntNOq95qw0aK9KFcWn/pwm3q7ocLnWca77dQdVnuU
         KKnwVT2vrDKewO9l5k3oFvu/k7Sn+3ZwY1yjKXY10zaKY9JCjb/9uR7kVdQNx8nwQLTI
         7qkA==
X-Forwarded-Encrypted: i=1; AJvYcCUkI1WnXuXTyUS1U6gja21Kkn4ptIj952P1Stdc0BPiYzTgWD7GSbQ/ctCsU272Ta5zhnC55rnigxC5lutK+fn3rGlmMa/GKqk//EVg
X-Gm-Message-State: AOJu0YyMcH+r0NKqMNtHB/oggl838wXWPn1e/yMrCJ+SiSzHMHjkttcd
	si4TJxzsrnJsVJtu8ky0RYR2l1sB2hnoIwQZlEqqcm1Q7jd3kZmyG+QAbw/uEADaGxUOvpLEsyz
	vybWzb4zHjv43JFsKjdzv3d+HCqt4AdOHadoFsyeFhKypcBMNEkIA2tM=
X-Google-Smtp-Source: AGHT+IHJ8bs/U3I3g1f4q/Xp24Ah0Qnma9lKdfqjhw9W8j5aEoYUBtabb+mH1Cbm0PU1piVVmfgBeW2+PGKAZvVoTvSuYOx3fOwS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c49:b0:374:9a34:a0a with SMTP id
 e9e14a558f8ab-375803d3e9bmr5712495ab.6.1717890662891; Sat, 08 Jun 2024
 16:51:02 -0700 (PDT)
Date: Sat, 08 Jun 2024 16:51:02 -0700
In-Reply-To: <0000000000008b96230610c6b3fe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b99437061a6996df@google.com>
Subject: Re: [syzbot] [media?] [usb?] possible deadlock in vb2_video_unregister_device
From: syzbot <syzbot+3b1d4b3d5f7a358bf9a9@syzkaller.appspotmail.com>
To: benjamin.gaignard@collabora.com, hdanton@sina.com, 
	hverkuil-cisco@xs4all.nl, hverkuil@xs4all.nl, 
	laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-usb@vger.kernel.org, 
	m.szyprowski@samsung.com, mchehab@kernel.org, syzkaller-bugs@googlegroups.com, 
	tfiga@chromium.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 65e6a2773d655172143cc0b927cdc89549842895
Author: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Date:   Sat Mar 2 10:37:08 2024 +0000

    media: usbtv: Remove useless locks in usbtv_video_free()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1009e6f6980000
start commit:   b401b621758e Linux 6.8-rc5
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=eff9f3183d0a20dd
dashboard link: https://syzkaller.appspot.com/bug?extid=3b1d4b3d5f7a358bf9a9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ffaae8180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ef909c180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: media: usbtv: Remove useless locks in usbtv_video_free()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

