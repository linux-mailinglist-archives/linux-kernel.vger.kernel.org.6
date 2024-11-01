Return-Path: <linux-kernel+bounces-392235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B03B39B9151
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E243D1C21112
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F3419F436;
	Fri,  1 Nov 2024 12:52:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B01F9D9
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730465526; cv=none; b=ItJB6Jkntd9Uh6NGlQJqH9YFg33NRQ2nFUXQe8el5ZvAx/ArlB/Boc3jsaV9HANvJGBM2swgBN8WO5ugSa0n3OKgnjTv5x5ycGSck5Jlu5nRrlJBF/MrFjmmUvT/pksQVac4fNZBcJLViHnv3hps6R5bGsCGmp9PT1jU1t3fc6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730465526; c=relaxed/simple;
	bh=MY1JuwzLIkP5t5Cr55MZm4xU3jbAwFV0dXz3R97RVlc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SZjpU1AGfgDWoHOC8K/7QLXGzEWkTk8gArLG/FqNIm0Gn0YxjuNljpW7caEcXnUDaM9ZjQqOL7LR+K3IONG4tIEP8MnABfietWyKYC85M5HqrgZPL+XS4RQHV8RPjpCFTp34NDzT1mUJB8CR16i6rwLf11oY1YMc734Y2Dk2V5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c5a6c5e1so23836415ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 05:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730465523; x=1731070323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azporNFTFIO2k+0mEq99MaN59MOSliWpjC6OvmTPJFc=;
        b=bC/eB8fJ/sjvlwTAgojctILzwL3NTniPC4Xay0qIbnLoQqHHzFhkgZxp5T0vyT+Ai8
         YfZkvyLiD1nNPVgfy7cvuEBcjpHGZPRFCqVRqbiorQtt07TBW0oX78FUBKeYBcZl/G+f
         5wC7K/f0rVFVnxDaJg4vhSalcovpgYYsh0C2zEDQagQYM5wqiKN9BTqpqNq84ahCM4Kb
         yJL+Kfy/iUNalkqRfLMqisGqmRAuiE+s/Z3lQxnLnMzL3C5VBxZukvnNNiFTkvC0l3P3
         tRIKDkmCZxtlQXw/0ahIYACCaAtDpXSilPGPeO9CB2fUAk91f7lCOZXSeQQDZDLsoJ+h
         FrBw==
X-Forwarded-Encrypted: i=1; AJvYcCVCqKcr0j4kjot40jKneZ+Uxjj5ZJoaXCU7+xVf1ZAPdESeQ28uQ9q1bSxSzsmAAnxbgYLMWj6FRy2qB0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN86UYUkVgmaLOWUDTAF5PvpHQKGiMBgPjF1f3731ndt3W1UFF
	Gje9izs2G8xFgMkQRZ9lAGluJA2a+xuXBalo4K52I0PH8i+gaDjwXxJbewU5aNJrLsbjdvLtGSt
	AX8sswGIL8H/3DppJqgG8Dkwt7cuXy6pwuZP6fevtggT78Jab/ZBmyTU=
X-Google-Smtp-Source: AGHT+IFCEINjrruxUOVhTdJlSxsMu6nE0QStDgfxd3vBsaNqtmWxt92TNL4EQZRENplnpiOweIwQ0Sn8kubgFvurP8ZgsTc3V1mn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180f:b0:3a0:8c68:7705 with SMTP id
 e9e14a558f8ab-3a5e262e863mr120760515ab.21.1730465523694; Fri, 01 Nov 2024
 05:52:03 -0700 (PDT)
Date: Fri, 01 Nov 2024 05:52:03 -0700
In-Reply-To: <20241101115926.vYGxC%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6724cef3.050a0220.3c8d68.08a0.GAE@google.com>
Subject: Re: [syzbot] [pm?] KASAN: use-after-free Read in netdev_unregister_kobject
From: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
Tested-by: syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com

Tested on:

commit:         dff8a642 Bluetooth: btrtl: Decrease HCI_OP_RESET timeo..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
console output: https://syzkaller.appspot.com/x/log.txt?x=144816f7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36917d9184c65129
dashboard link: https://syzkaller.appspot.com/bug?extid=6cf5652d3df49fae2e3f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=161c955f980000

Note: testing is done by a robot and is best-effort only.

