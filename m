Return-Path: <linux-kernel+bounces-516388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0F5A3707E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 20:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822A63AE808
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 19:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430FE1FC0F5;
	Sat, 15 Feb 2025 19:59:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7648C1DB346
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739649544; cv=none; b=A23syPYImJxpQmr7lfGNp/Z5ZwsW7RrBZF9KVaVd1tSSNxudwFgDwNnUzY9fGobQBrujKFYQC5AuT/c0FZxCt+9ZzEiDpmFx//PtEkdyi5VLa3Yg/LC/Wd7qnrobRa8dBWSWsFP7Svn0DH0DfI9QNPyTNlReI4hG/9b9zG2uOXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739649544; c=relaxed/simple;
	bh=cjmLZcRAlefbwU0nv/Qg2Y9Rr8pWmnHARLkL+GFHg9Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nO98KwBDx3Es9IVz/n/3Jt7xyzrPaq/R4yIq3odFmF5eS2765UktQaSe9wT3JiRrcPwvITWqUVnB+3SH0kXPKtkxBGw5+xPGBO1QRVsA15sLlpzTrk1qiEi68bmQ/ImeuJtZs2q/sVDYS5h+uYFKajcb0WI3OR+Z+ASkhQfhRKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d187cab068so50399995ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 11:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739649542; x=1740254342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vsSGdGLxp83+EP5yVNQjXJBE2N1zKb2aPVpOLY4p7Xo=;
        b=fsBXWDKY3v7lv2WpNSwpqi/RSZuv2ZQwKO3Y4cTmfr7xuTXur4sLCD3NathlsL4D5J
         ykQCzl3aHOMzjom1ejFHfP1J3hl708ekQUgPWcIVYbzhJNDzilWbcQZWxtJ4E8X4Gdom
         AoyDA7YshflGdl+S8PQrTF8dMTbGcWr/y4VcGHiRrs6jBXF9Y8hjZqSmbjuPdgshrGIR
         5oAoAlCxz7kKMvqPW/wi6rz29SOIYxri4U3qvvqI0Q6A7UCvCpUGV+xJo5Kgpr5pT6jk
         DwdaA8FHERAHjHpmSzwAAcGTUsJveWYpROQRNPShh5eQAk97i19xc8vvJHE94xyerEuo
         V5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRgRRQOV7kAxZkx7nykKclLfCVvEWT58cF/LgBqPcq9xpmiRFxHaLXIQZ/i4z4lxL9g9YCrZsG8/mYzSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmDqz63wojOQrH/1oZJt1yZ0S95fGbsMjAQ7+j9Rvc2+zFy85a
	RZ46+V7FPBHwgxpWjfmJ51Y6K1wtdBl5m8ABzoCttKaJisvYVKuKPCVZmHLP41EXdwbGGmOE3w4
	ToEtwQ828OAb4wt7BOdAW/0wAD/3RLM+4c//dQfxbBfvafrLDmQccfDw=
X-Google-Smtp-Source: AGHT+IGED8qB1mXWmmt+c7K6nBjduh4vT+n1AH1rSM0vh+OCwjQiG/6k5zmPAwYHWeUR2vWHB4xIUymZW+id/66hrnU6uPwYIiVw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:240b:b0:3d0:e52:7d33 with SMTP id
 e9e14a558f8ab-3d2809d114bmr38457015ab.22.1739649542676; Sat, 15 Feb 2025
 11:59:02 -0800 (PST)
Date: Sat, 15 Feb 2025 11:59:02 -0800
In-Reply-To: <673de7f9.050a0220.363a1b.0011.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b0f206.050a0220.6f0b7.001c.GAE@google.com>
Subject: Re: [syzbot] [media?] WARNING in iguanair_get_features/usb_submit_urb
From: syzbot <syzbot+e3ae1e7f4b88f3e696f5@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-usb@vger.kernel.org, 
	mchehab+huawei@kernel.org, mchehab@kernel.org, oneukum@suse.com, 
	sean@mess.org, stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit b98d5000c50544f14bacb248c34e5219fbe81287
Author: Oliver Neukum <oneukum@suse.com>
Date:   Tue Nov 26 13:17:22 2024 +0000

    media: rc: iguanair: handle timeouts

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1007f098580000
start commit:   f868cd251776 Merge tag 'drm-fixes-2024-11-16' of https://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=e3ae1e7f4b88f3e696f5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10edf1a7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d892c0580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: media: rc: iguanair: handle timeouts

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

