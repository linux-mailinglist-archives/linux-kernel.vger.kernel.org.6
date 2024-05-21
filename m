Return-Path: <linux-kernel+bounces-185441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9906D8CB4F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39AABB23734
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345A57F49F;
	Tue, 21 May 2024 20:55:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CD0149C42
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324907; cv=none; b=F1Q5ySCGGKw4/QGvxnSo+4+qVN943FwTQ4Jytsd8b1r2J+HZ9KtsG5wqvAqTAzB44nRjWWrjYc/tP2MaBLPsOHuHPSvOU/dss5NB9VqzWkBJm1+rt1uLr/Hz1PV22GseKNN8l6g0qtpDrfIDE2xhJaQ889NaYNGicDoeeH4eiJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324907; c=relaxed/simple;
	bh=R3fCvTgotTxLXsi65QkeFqLB7siU1DAP4itw793zAbc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GW6aGodPCVvNLKMPvRE3N563Gu/Vm5J35ripVldID903+PTKEUB9Vtn37/PQbUngiVJpOMRgCSOfkiIZ187gBGDNEMeUNIPSNSnC7IFHcA+bToBNpPm45IurJkH7NaTib9ywhHUE7OCwdJdzEr77sLwiTQXKR47sxmdD7ZEZICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3705289d46fso798005ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324905; x=1716929705;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEiS+NAbk5RMjDOg7D+8NkoQTQW7Txc26tuIznMSR5s=;
        b=QjMG7vttYlY5jccL1dgxm8S7ElDnJmHL7HRwmrP/ev0t8TZ/09+uy6SHxARu2kyFEv
         ZDPYkjPCik5mkGVviAjwKYgWDmS50PlG3Ab6sOcKug6Zm2bA6SGUEXciILVqa0iAyJGB
         4mk6OblPe34ZqxPypgrpSHRNaaOWH5M1gPGjCrmWyYQb7B8u9le+t/ui/uOi1Aj7LtNa
         k4oBXTgF7IkKACIUaayGzE+bi1ls0ViayezRJ4sP20px+2r5sVDK8Vl21lA2CjbDekCw
         DHBz+mOksZlsFSc6oQeE7IzzLxgNSCGS8SVAHYPGeHS9NOEo1g0BBwa/iXCAEON8HcZo
         rwOw==
X-Forwarded-Encrypted: i=1; AJvYcCUjZDlgeQp/WQfOtgt5laUoBLPK0w3luZ4wylLJFjQyUZDwHBgrixA77D9pIMA5jExD3kzsx+K4U7VqfN/0xwmYxM+TT5WlhvgI/Mq7
X-Gm-Message-State: AOJu0YwY54sIkuE5Vv07sWNShgF9wWf0YXH6gx4N7+SQm5N82RL/3uvx
	RueCflTxMGSOKNiu/Al1XpFWUjlnDPxbYFm2JbRnQYEzQBYj754R0SmhFU3k3NDixh+KE00m/rZ
	Gr9UB0eQm0GjG1Ip/z5zhPFsJTivl/UAH+oU2SrgRAbLZI2UE3KsNDfI=
X-Google-Smtp-Source: AGHT+IF7myKplMlP2iRDvN1xabnHS0FA63h1KOBMghTZeFYqaElRBXr7o65M7k9nw8WSfPfwjJ6wDj86smTt4N+eBmVJhPMRD2fe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20eb:b0:36b:f8:e87e with SMTP id
 e9e14a558f8ab-371f6e0e1d4mr205215ab.1.1716324905771; Tue, 21 May 2024
 13:55:05 -0700 (PDT)
Date: Tue, 21 May 2024 13:55:05 -0700
In-Reply-To: <87jzjnxaqf.fsf@cloudflare.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053f7c10618fd0878@google.com>
Subject: Re: [syzbot] [net?] [bpf?] possible deadlock in sock_hash_delete_elem (2)
From: syzbot <syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com

Tested on:

commit:         8d00547e MAINTAINERS: Add myself as reviewer of ARM64 ..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=133dc97c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17ffd15f654c98ba
dashboard link: https://syzkaller.appspot.com/bug?extid=ec941d6e24f633a59172
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11caabe0980000

Note: testing is done by a robot and is best-effort only.

