Return-Path: <linux-kernel+bounces-411931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8919E9D0174
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 00:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9514281E92
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 23:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7C238DE1;
	Sat, 16 Nov 2024 23:33:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B236E194C7A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731799984; cv=none; b=A8calaTzl+Hp1Zhjcut5V2rDbtumGkZq3NUCOaYBDLa4ckK0GGmArmNuPOP9dFeW6nFEkIQjRYFFCWK3hEil9nO6sz9oqUAF0npcFzowyI2dykAUyw5nzSJHrWi3Hle3FrBA6rHM0vXpJs0vrS/xMi71tBe4WYfm9SPUMEC0LQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731799984; c=relaxed/simple;
	bh=ozfUCCvHD7H7cQd7d43iIoXCIgVvNpJ7H82PLjvW++Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iK+ldoP+mBl/HFe56PUZXTwLRkppLZ2EMkZ+LyyjZCyHtFrmstxCbOPOhaZQVxVhQN+5LsfstMVnx521vCTDDBryQQwruYSPolo+IzInb5UoHhcnu7L06YVRWJ2GdqleQ7iZcaQhUWdkEqc3kVhEv9jVtIWFBw49dG2kjxwIHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83ab3d46472so309663739f.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 15:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731799982; x=1732404782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pPDlMybPfT5VSrJgcwp4WOC86rQWqblOSy8gJogtjg=;
        b=S296TGFJww4IKtlm5irikoGPS5RT9uaYpM0VUpTOrtDisK1RMLr7xiqdLFGKoadds1
         i4q8TuSmAyOyTcmpNeOIcR3mBgq0zmtbNS/tbv+ccqSR/E3o6AK7fDC9CZCgHLz49fF/
         oPAe9CAHORxKWyx4xnuGVhXtrezKNeNLTpJEJUtppH61Dn82O3tNSdH2fz5vhK4CPNBK
         22/8ysY11mgB91E9zQH9t7g7InO3c2DT//RxIyKuHQPl0Me98Mwwe/RLZq9H5fNFXYJN
         00unIBVipxRIW/SRoC0RX1jDbhO/U7UKU5obpp9wVFxa2T8kpVQTBx7j27T4SDPF0XjS
         X/uA==
X-Forwarded-Encrypted: i=1; AJvYcCWwQ77M9NN5BrRG2XWqvNl9kR3C2cvA8NdyVmFLqgJjwbzsfVe4SwVsdZ9c1vXdef2USd14/4bnYypHUSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOb6QmNsltLvuckFpQw8pHnyFD7tgIchUGoC9RhTUokHNqehsH
	wSAg6Kal1oEfnnfFzivkMuWO5PkRxJha8IW8+zOp9UsesDA54nRdQWx+omkYy5pjb3gdni0z0jN
	Qomv5kwfbYQrmEWarYcaF7z4xMQBuq+34XB2VE+m3IGjdjPUsXlYbiz8=
X-Google-Smtp-Source: AGHT+IHxQ9I2yZYOzjRu/LCFRev0gwqeF6CbR7jTx9glbHmeTnAWQobIRQzimgpPUOzK4oLe2zqzYITldOsYwITjPA3qJEI3bt+k
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b43:b0:3a7:158d:6510 with SMTP id
 e9e14a558f8ab-3a74800e163mr69240285ab.5.1731799981891; Sat, 16 Nov 2024
 15:33:01 -0800 (PST)
Date: Sat, 16 Nov 2024 15:33:01 -0800
In-Reply-To: <67336557.050a0220.a0661.041e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67392bad.050a0220.e1c64.0009.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in loop_reconfigure_limits
From: syzbot <syzbot+867b0179d31db9955876@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, ming.lei@redhat.com, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Oct 25 00:37:20 2024 +0000

    block: model freeze & enter queue as lock for supporting lockdep

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129b52c0580000
start commit:   929beafbe7ac Add linux-next specific files for 20241108
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=119b52c0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=169b52c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
dashboard link: https://syzkaller.appspot.com/bug?extid=867b0179d31db9955876
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b520c0580000

Reported-by: syzbot+867b0179d31db9955876@syzkaller.appspotmail.com
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

