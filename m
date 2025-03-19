Return-Path: <linux-kernel+bounces-567644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07070A6889B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F33717789A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394E9254AED;
	Wed, 19 Mar 2025 09:40:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79930100
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377205; cv=none; b=Mb+lG8FpSDT65syMr1sbjhlpEMoud1LOw+e4/i/ISVLZrAqD6QufK8Qz6MT8TCpy2Wsb+n/cKNH8yeq80l/V7RBhWZGOU32mHGFBohTe+r/UQRvk4otlPUxQ3hwg8NZu4eyghXHnwUZM3vh6E/eJ/qiLK6fbbxMfJS3owIRtLsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377205; c=relaxed/simple;
	bh=MUIdGfHqdt7bgez4R5hVp0jGJaNO3W5wLDchdmLq48M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PWU5TrtRm+Yp+6mSME4Lq/DbzUT0zhO5n4QAC6xt09UPWkGz5mC/Jg3tMuG3SfvVMcc8sQI6evojInbQFtaBeIKTpNDjzCWaZccpCOKs23xvFYDqb40VcINRTWw9IVveHV1jZptOItzgNKPEjwUwme4tXye2yyz+hTVEn6NLnuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-851a991cf8bso45184839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742377203; x=1742982003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjBe+XHI3ciJhsIHuXrQ+GA2Y7SNLmT3NwnpfP+m5c0=;
        b=JUQHoi+lGJxp2jdEbfSRouW6hWaQRPD22eVyPZTfQqzM1y7LOzlThnicN9QSxz5QJ5
         PUNQ0MNcM7CaVzCzE2Tv4fiCHgHA2RYVKv+BmnvxUYhtuDB1Up0RZkkQBtG/3zdmlJ4a
         Lpmno3aPm5oqKfW2AH76b0Sd8abvPX7m4K3YC6+y9v4NSvT+or4jQWiocIybReXCOpel
         6syOipogEJwJIGlqeU4erJgp+/1SMdjjUqnlA/g/nwv7RWlJ6APFMCqNLXk/eVpCieIP
         ubjv92mllbcs5lEzNfN/jGmHNarotOdhkmZQHPHgA6wH+w+ffIqODjNesURZyI1hBUDQ
         6yMg==
X-Forwarded-Encrypted: i=1; AJvYcCV5Kl3HNK7s1FrfUzVxAP8Oywox+yCxM67lBk9gsQd3Xg77KhvQXHJKo5YuxY8ls1KZLJC9d9C164dqbnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybqxlZkAeGeSoecloARedweggwRkq9AWbxb9A6OhNmZdvLdgpH
	KbK96fr8qWZ1E1u5KJ0/Spr2qgOFcgh2gBnPMTq/kd6pbSBlqQ6H/jTnEwCLT/cCdu4SOZAiYd8
	2hz5UmokRQkab4xFXQDVkVPH+5iduKstmRbmkWW7r0pIDB1GC/WB/iM0=
X-Google-Smtp-Source: AGHT+IGEbYzJWOz86GSJH3d+H/uesMTKCNrZ4yEyh/GDkdwj2Kg7c34kkrPiiVjmgyRe5xz43NyJttqmOUCx3cgB3iWPOfUr81YW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3388:b0:3d0:26a5:b2c with SMTP id
 e9e14a558f8ab-3d586ec873cmr16492115ab.8.1742377203511; Wed, 19 Mar 2025
 02:40:03 -0700 (PDT)
Date: Wed, 19 Mar 2025 02:40:03 -0700
In-Reply-To: <67afa09f.050a0220.21dd3.0054.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67da90f3.050a0220.2ca2c6.0194.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] [kernfs?] UBSAN: shift-out-of-bounds in radix_tree_delete_item
From: syzbot <syzbot+b581c7106aa616bb522c@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	gregkh@linuxfoundation.org, horms@kernel.org, kent.overstreet@linux.dev, 
	kuba@kernel.org, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mmpgouride@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 3a04334d6282d08fbdd6201e374db17d31927ba3
Author: Alan Huang <mmpgouride@gmail.com>
Date:   Fri Mar 7 16:58:27 2025 +0000

    bcachefs: Fix b->written overflow

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176e8e98580000
start commit:   09fbf3d50205 Merge tag 'tomoyo-pr-20250211' of git://git.c..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c516b1c112a81e77
dashboard link: https://syzkaller.appspot.com/bug?extid=b581c7106aa616bb522c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e449b0580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bcachefs: Fix b->written overflow

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

