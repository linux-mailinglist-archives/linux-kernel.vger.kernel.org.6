Return-Path: <linux-kernel+bounces-205259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033548FFA12
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8364D1F24C4E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 02:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB63175B1;
	Fri,  7 Jun 2024 02:51:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C309D2F0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 02:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717728664; cv=none; b=vFXmwtiGJg2qm7MAClSKEbHGpylRDrTuKjayzLxzeHqsb43v/BKGy0K+wwB4muOrS8LfQZE3Vhu+AxZCLnEXpGJbEm0tQEO3UGcP5NQ7r88mhvc64Wb60U0msHXm82KkyRcBaBhjjxw3T9RoFEX+CMiUnp9H4ndcOeWghvBX/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717728664; c=relaxed/simple;
	bh=si+N1wuZ74OQmZXqp5VNrMsebBeEF3HgK7mZflWf8Ro=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tvztczCo+9F+qlmyEYNSIFn2XOYveq0xrdNJTlnSsKBcbaikjl1w2vPhHFnFRazsXUb1kcmhHstKmMLOzvuO2m0ajIW2oZw5gfcJBffGEmsV4RO+yDCt7lRgFf78f4ANZhEmthkpz2y09FZge8s3UOCcmd9iREoGSrvvChDP998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3745fb76682so15416745ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 19:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717728662; x=1718333462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoJDbmOuZCo7DgFMWx4zQY5bK5409kRcjvDvOGHuIw8=;
        b=Mv3VGa4SdiyrW7g24VpE/o2eC2QJvN63VkkCvRpNoqsyGxazpcyVz6qKmyvi1X6fSf
         769Gj79deeKGJVzMOdeD9YrtKZf98RnO8C3DJ0sb2zv4d0uaKyK1ZKeRBzRp27A+6sqb
         2pHMAT46TajzMNOsHMXCx19aHlfetyPICi9ro6Fn9iXy4zQV0/qej4pjX+bU6ZWoygSF
         xVyHJOY3HL7MosHxRl+cdQW+EB3dPDJ878r7S92TXWwdI3zjCWEgJ4I1L5962Fckvi2U
         0pA6Yv2XiV5bCbc0WcN8USsO5c6kVHSR/JQFw/CZRd+Kbn9yDvYeKaQorUhuFU7T+sHg
         i2kw==
X-Forwarded-Encrypted: i=1; AJvYcCV1+ouLoAgpfjI7Ng8ChrMvCsnz4V5qz8e0EVdzR34vdP2jl9pc7d39Ljpl3QDnmjD8mN8zgGFlXO2IS8/AjucUi95DJ1pY2zPIXOWn
X-Gm-Message-State: AOJu0YwwDHKg2pa4IUm3lzVVZiJ6jcxY7LeoN4GAg6+LsmJ5TCpsbmYi
	1m3YbS5ReD3VyOXs3StdIoEzP37ZLNWS/XOBghQXRqtCdpWO+2qeqroV6k4PX8vCMPCFaRLMzVH
	NeKeDXYgzvDSeuxHBduRHfZ9wU4N8bhitIVx5ZQc0cHnsXJ1WiPDIA2o=
X-Google-Smtp-Source: AGHT+IEIUXUjMuT4JzACmagoV0Bo3SJsrvzkbMMX8Ie8P7ZaGp2FbUDMzisZObkuWRNwNUQdRkPEz5ZA6ZM2UMMjTWxNqJzvzG71
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d92:b0:374:9abd:2788 with SMTP id
 e9e14a558f8ab-37580242e2bmr1025575ab.0.1717728662718; Thu, 06 Jun 2024
 19:51:02 -0700 (PDT)
Date: Thu, 06 Jun 2024 19:51:02 -0700
In-Reply-To: <00000000000002a89b06146e6ecb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c31e9f061a43de90@google.com>
Subject: Re: [syzbot] [kernel?] possible deadlock in __hrtimer_run_queues (2)
From: syzbot <syzbot+bacb240dbeebb88518ae@syzkaller.appspotmail.com>
To: boqun.feng@gmail.com, daniel@iogearbox.net, hdanton@sina.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit ff91059932401894e6c86341915615c5eb0eca48
Author: Jakub Sitnicki <jakub@cloudflare.com>
Date:   Tue Apr 2 10:46:21 2024 +0000

    bpf, sockmap: Prevent lock inversion deadlock in map delete elem

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1169a80a980000
start commit:   61df575632d6 libbpf: Add new sec_def "sk_skb/verdict"
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=bacb240dbeebb88518ae
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1793a2e6180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c8dac9180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf, sockmap: Prevent lock inversion deadlock in map delete elem

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

