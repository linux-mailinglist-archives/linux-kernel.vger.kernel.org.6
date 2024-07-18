Return-Path: <linux-kernel+bounces-256338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C772934CA7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD028281566
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C10139563;
	Thu, 18 Jul 2024 11:36:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8C912C470
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721302565; cv=none; b=kfho991xp9k6pHZbyNrcUfGlBIkHzRFUCh81KtXdPfGSkFJ1b7/ULvR+NzKrqlcIm9I89hwnrKUbrSgNmesf9jha/5xKOvjFoTlpz5OVcO1M63XroYk/CspqVbeh6OKyFElB2zDaWbF1yWJqxiZ/h5Cbax5UunHXiLcwpinfIJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721302565; c=relaxed/simple;
	bh=3zTnNYraMSYKgMmU9Rr4+Osvwgctu0CInt3rFTFmORY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=thiFN0mmRMdde+cRSp0BnWNb5orxpdrnmX5YI4gRngm4MvakqknxjzQbkPqeIZfRYjstCHyat5hCm6oxJ0iBy6XaW3a9MWBnBYGPdo2ugrVwbRJ3gZoclOfPBt/C51nxyjFpNfd5v1TM8yTBDIaHrj2o1u8BURsx1l0bPEP03no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-803bafb0b2eso116675339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 04:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721302563; x=1721907363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/UXWMjuE0F6exYzPZGp+5pjnOadLLZUQTGYLO5C83s=;
        b=HsHSEM4KxH6D67bNGyNtFbresOIKnxGPhp7Rlg0Dk5Nrz4EhQgS030Y44QRcOt0CQh
         YPgo1tXnKgwWm6hjmgPsE7QBn/egmxjYraus0sROorDvAjP2JRxoP+0WEdgd1KBC7Pnt
         R+90vjU5yzTHUlAklXbRF7A7/lvzjM50Ya2XaHMnYUnHE/oJNU5A2DxWaM41sAR1lKXJ
         vDcbBqk8Jm5dSo7wXFm8kD304urlc+zy8uSLMUm6ylZCQ0gGVnqUQxRuPLpuic4m55X4
         Oacsc0BquSx/PCKGJ2p0XJCqfPCGZYzmsQo2pPXbtPLX9toBCQdVGwBoBWmqkxCCkC9u
         H74w==
X-Forwarded-Encrypted: i=1; AJvYcCVemahu0fYb+HZf9wF+Roc5CF6E3ffqFK1akpJl2PJbn2I4KQbxKxRRzf76hm4rvVGA0aqXjSq19GOwLGs5zzHZ4IGhZuDWj3efluId
X-Gm-Message-State: AOJu0Yz7sn3YTc4aGNhD7V9z1gG8vETBkZsSeJKof4/WC5EMUQ2x67HH
	iPM6LLFjgoS8tV2ENlh571pGjVsUz5VJt/4+HVDuBpdxI1YZZ3TbgVJi4dV2RAjD1Ezjg0z7G0A
	KWaebdbZIvDGn3SMDDO9E13oSxw7UnQVWVC56BXRGQ1UjHDAJlxS4Rvw=
X-Google-Smtp-Source: AGHT+IHnCRhm4vRM+6ssV2qBJEdreRvcEI37wOVSBy/7ghxI1vNFCO26gMx9A0RpNoj9BOEVdEtF369nbDaN7170+dW6dREk4j0P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e4:b0:381:24e:7a8c with SMTP id
 e9e14a558f8ab-395553333c8mr3545635ab.1.1721302562857; Thu, 18 Jul 2024
 04:36:02 -0700 (PDT)
Date: Thu, 18 Jul 2024 04:36:02 -0700
In-Reply-To: <20240718105248.1380-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf70b8061d83fbdf@google.com>
Subject: Re: [syzbot] [net?] WARNING: suspicious RCU usage in dev_deactivate_queue
From: syzbot <syzbot+ca9ad1d31885c81155b6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ca9ad1d31885c81155b6@syzkaller.appspotmail.com
Tested-by: syzbot+ca9ad1d31885c81155b6@syzkaller.appspotmail.com

Tested on:

commit:         523b23f0 Add linux-next specific files for 20240710
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=108d825e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=ca9ad1d31885c81155b6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16bf4f31980000

Note: testing is done by a robot and is best-effort only.

