Return-Path: <linux-kernel+bounces-383579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423949B1D8F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 13:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBB71C20FB4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 12:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB1A156F45;
	Sun, 27 Oct 2024 12:00:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512316F2FE
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730030406; cv=none; b=YEzWIN0KmVnC34+NvRR5g0LVH5BpHi+kiRLAU3lUyQzZ40OHk87LKSECjq9FcBDEOOIAXt/IGu6S3pLgBG1e/n7IHMlHWiVe848LUgQiGHnfx0xCl3hVWinpYL60Ts1YHjpL6I/F39r7PmIDFBg2ZjlmQ8g0D0+bnocvyRhuVfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730030406; c=relaxed/simple;
	bh=XO1lGRkxLeB+9+Bplf2WMXDq+XPLUt8XczjTuzuUnQ8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CMbR8xHeAOyRHKJK4kTMx4VJ1z/8SRK4zZ6R0JNoYe3fHBIdKyNAlimdp49wIO3vSuUBcrcm2mltSPfQoCtlzilrQgFct8lQgZnsweKkr1k6t6qecXh6TzAR8U4HLD+9TPPRS0UlLc2/XWuwcOibrkQzxUp2cjmFxc761QlQL30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a4e41e2732so21498445ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 05:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730030403; x=1730635203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=no1ZFOGLUySkY+ghDrsyWwT3pLKnG1CnPDNFguvuHe0=;
        b=Dvi9qLioPhRbknGgIFlcDWlqbYrDxZZjFAWFkz2AQtbmgGDgGKV4u+lMdZ6pNDhT11
         ZewfTAnYnzBnChWOEamIthy3IsK0WSfNf+wx9l+DhVos1cojjn6Id3RL+26YEv49e2a3
         dQPCpXo7MKjeP4HoXd6neb9+iSEBwqJl4Glao//lyPSGly9cFRsQFYZmL01dJR/Cx4ho
         492c/VpfgDHu4+k3PidK0BN6jqPXiW8UwLH0oiAqcbB+vmhWkOdIXc403gr1KyWNTGkT
         21C0frA+T56rAipCN/sLIhXDGguOZQl4b8kGHVAPipsxTtmXs5mKmUcMJ9ZQtreCKWAL
         bfvA==
X-Forwarded-Encrypted: i=1; AJvYcCXHM8A2qMDJQQRV98yre+M6AAVOS+WEeIo7gykPFKAE6ep0EIW+aNDeY0nvzFLBC41p9kqT07dx9F8AicA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6lDlisVb7fTUqKYZmhdbaoap08RtawkIcjtdurTEiSdbUx2kt
	x7IRGY1VaTOUukS/qLMGyGntEaapB087Fk3ZiICBYruqoi9CrPVwXdtEWeHSLE7VugfNVaxoA/q
	zflyg2KqiP2mOhkqRnsDHB4OhJk6j/iJiRyN1FbheRbRdp0v2RkETEUA=
X-Google-Smtp-Source: AGHT+IHN18d5nvGLfk1zOtpizfizKtdkWBBv3m/+dQNMHigd0YvrEMcYJQnZmE4RBIDiNkwypEIJqmOf467eaXwhojoR4OTkPxAl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca08:0:b0:3a0:4e2b:9ab9 with SMTP id
 e9e14a558f8ab-3a4ed26642amr35233065ab.5.1730030403309; Sun, 27 Oct 2024
 05:00:03 -0700 (PDT)
Date: Sun, 27 Oct 2024 05:00:03 -0700
In-Reply-To: <66fdd08c.050a0220.40bef.0026.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671e2b43.050a0220.2b8c0f.01d5.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in genl_rcv_msg (4)
From: syzbot <syzbot+85d0bec020d805014a3a@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, davem@davemloft.net, edumazet@google.com, 
	kerneljasonxing@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d15121be7485655129101f3960ae6add40204463
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon May 8 06:17:44 2023 +0000

    Revert "softirq: Let ksoftirqd do its job"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1492cca7980000
start commit:   c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1292cca7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fd919c0fc1af4272
dashboard link: https://syzkaller.appspot.com/bug?extid=85d0bec020d805014a3a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d40230580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d40230580000

Reported-by: syzbot+85d0bec020d805014a3a@syzkaller.appspotmail.com
Fixes: d15121be7485 ("Revert "softirq: Let ksoftirqd do its job"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

