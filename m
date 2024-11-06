Return-Path: <linux-kernel+bounces-397605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC95D9BDDEA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 05:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B61F1F23831
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 04:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B95919066D;
	Wed,  6 Nov 2024 04:18:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64E83211
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 04:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730866686; cv=none; b=kuEPN1V6ZWGfNJGy4wboHP/NSkcUshRa5bHcK8t9Xxv+kYWz7FLPNMGxf4IXKMeQ7QFBoXpgvLWegTa0yFWwPpQWYnp7WDb2VdINu9iois3WJ4hzgU9kzf3reJ8vNzlz+CSzheIVznbFkRoZ5c9d743SJeZHSATwctsHyAtI0FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730866686; c=relaxed/simple;
	bh=UsvyeQwFOXvv6+VXcRzjvnK6RKi6GGF11RmCxqB8K0k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lcMir4pCY3GaXGPTF5NTkscCx6rWVu1UhbDvO5ARWI4Tw1i0NvoS/SIspMllZC/VlE5GLLr0Qys2fwLZP4WHrLrsNfxbfaeJofOAZ3YtDFtdkFkPs/JhFFWkWEsfOkFZSSTmTazvy3oAKS4ZdhUoZWEblIviFbAlnh3e9EFBobA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6bb827478so46949415ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 20:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730866684; x=1731471484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ky0pjP0MyMB/9Y+3wQlKW8z7mKjqaQGMXxUNw6OuBtY=;
        b=MuhpwRL/ndbKlT4PDzX3oNYkDGXk40osaWUXqu32w4NDPGoxKuTBhJZjTS+aMMKTrl
         SR63uOvBI5gHoXGmSwMKFAPLD6xqisU8afxdlNLTC3OFsf6o497507wCGDmT1z7LWCMW
         g2ZIVBhPBbWZrPy6O60LnqctBaZX7cAlOo7cNVFVMKsVwibwxFaKV3E4ujJbvl+85wt4
         C91bsOFbdCRrUR3uW0q4WjlK0h4TDPr5QTCVOxFVftqgvwiwRn1Lx7IqIwuopjURX/lN
         Y5jpS4jAoGORGkc+pUSjMxQsoBxleTXfg255goruiYwh4SAolXDCWHJ+bwYZSOnP2X8n
         rGqg==
X-Forwarded-Encrypted: i=1; AJvYcCU3c9tWq/sPg6eJmB9tykYjTB2M6d2nSE/Gfxdgtbn5mq3lnqeGpzrRL7vJjvZdGYjfv8kzsuLgmyFuL2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIwlmutbqljFdNLsA/Ci4wr1xe2ua7SLH9n7u1q66rTyVTVxLS
	FLGAl6bltsUhkP6Yq2lmf1j5vixzMJSoyXsS7HHlHWBAHyPqvbVcb/QEXcddiy3LaWl3s9bFUNa
	84DpSQpaMlDR0EShrhQwgghzXg59x+cXaVIKLsbBXTtsRVrGLoDBwYHc=
X-Google-Smtp-Source: AGHT+IF9DA3K1n/dhePvzfFzpVBSG/hE0HFkSo+hk+R0r0yj/kZKXbSM2S8qmluaj9BUmbOqKtIVuy7jKBUS8RwFrT/Jx3REKKnW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c41:b0:3a5:d2a:10e0 with SMTP id
 e9e14a558f8ab-3a6b0229ecbmr171859145ab.5.1730866683853; Tue, 05 Nov 2024
 20:18:03 -0800 (PST)
Date: Tue, 05 Nov 2024 20:18:03 -0800
In-Reply-To: <Zyrm8uw204eZW9wF@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672aedfb.050a0220.2a847.1b23.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in blk_mq_alloc_request
From: syzbot <syzbot+ca7d7c797fee31d2b474@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ca7d7c797fee31d2b474@syzkaller.appspotmail.com
Tested-by: syzbot+ca7d7c797fee31d2b474@syzkaller.appspotmail.com

Tested on:

commit:         72697401 block: don't verify IO lock for freeze/unfree..
git tree:       https://github.com/ming1/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=172b9d5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfea72efa3e2aef2
dashboard link: https://syzkaller.appspot.com/bug?extid=ca7d7c797fee31d2b474
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

