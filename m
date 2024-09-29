Return-Path: <linux-kernel+bounces-342836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F884989375
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 09:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D541E2814DD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 07:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287F513AD29;
	Sun, 29 Sep 2024 07:28:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2C029CE8
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727594884; cv=none; b=fNeH7fvOvAfh/amITptcutluLi2qP1gfmgKShMZ7+CHuG0CIyhgVQmP39HrCJDA4Zo7qUSnQAX/SUPVpDYFb7ALvq2fiS+cR9TNm4qQijVLZi8w6Q6KvWNGLdVUvTZDzyvgng0TyUnG1AW6/8kpkH9hkrNgBwzD5/XAu8bTruyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727594884; c=relaxed/simple;
	bh=D0f0JngKS9vM6m4p6b4eqZ//KcfC7dTDIrQ4MQNLMmY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CvEfn9N4LezDUb3d3moOmIaj5ANOsrGNlb0mgXNfP4rMzeV5MqzEzvl4P7g77lgvDDS9ccIifpEfCFW0UnCZoSRBlq7pXpH8+z40G/1m+shP/xTGrcmBB9fqpp0WzTkoM0ug/LnFQUHSCww5nzKTZCGjHwOzEOcAnEC8rQdtb1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a34ebe595bso12825545ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 00:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727594883; x=1728199683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZQOrBnRRLRoipx6pmRkgEgCTe+4V3ousUZTXEBFjJ8=;
        b=CKUfdVxDtxXvmtT01LjFAgNF63IIeMxBi0esExqFT4LgOG0anz3c26mDd9HV2E1lGB
         p4RlKcujIQTJgt8XrlJA/F605bwgI+1qndk5Nbjw/+1sm6IEb/EFvd9Tu5QUCwNBwoCC
         SwSqkD3P2GAfvNP9VcjpztEGCIYW+xysjPVrqruXtDYJCA4QxMgF4u9ErFWUEi6vtqpF
         g9CNetkMkfxkdXnWAZSnXtQRFosJNF/I2mdeJzL4Uqz7Dhg/tp8GpT0o3DWBQ1KENeXT
         UqrzklTDFCjlG7enqgoV+fYqPLf4+Fa5dGy61SogOWjWW/9rXI9JUfUlfaitV4S67DSb
         ng8A==
X-Forwarded-Encrypted: i=1; AJvYcCXmg4AEdqAKYiYaL9Rt/NNyxX/j9X1W25HA+SFa/+hM8s6fUFXGcmtoVgw8KyWVnsuD3cxbAJ5Kqf0PRZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE3pM5h33VsP+9zVTS8bYzcTQGnylluj4vYXv2VM26+V7te44O
	GH8HqRlPVZNwH1+8g//CACN2kcS1pA9K760iHFdLulBiCbxFyKpvXlydSXBSzgqqB+VkE50fw9A
	C25ToK+TqPO8NSajOC5hbEJKPVlJ5ASM7kJQjLvj+H9K9ZOK3pqKQjoM=
X-Google-Smtp-Source: AGHT+IHZjBv2kLweSPvvYEqUMYojV7jh9P68h92HKb0xtENthnSuxE79mfYmj0YFqXPLNfJ3oNcpLelDMNl49/iJ+/ooSK9TapOO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2195:b0:3a2:7651:9846 with SMTP id
 e9e14a558f8ab-3a34517ab68mr65912765ab.13.1727594882762; Sun, 29 Sep 2024
 00:28:02 -0700 (PDT)
Date: Sun, 29 Sep 2024 00:28:02 -0700
In-Reply-To: <66ee8204.050a0220.3195df.0041.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f90182.050a0220.4a974.0017.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in bch2_journal_reclaim_thread
 (2)
From: syzbot <syzbot+820dc3b465c69f766a57@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b1d63b06e8398eb048dcc455acc628e6655d7499
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Fri Jun 28 22:10:47 2024 +0000

    bcachefs: Make read_only a mount option again, but hidden

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10c6de80580000
start commit:   ad46e8f95e93 Merge tag 'pm-6.12-rc1-2' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12c6de80580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14c6de80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4123da9de65c5cb5
dashboard link: https://syzkaller.appspot.com/bug?extid=820dc3b465c69f766a57
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149c5e80580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149f8d9f980000

Reported-by: syzbot+820dc3b465c69f766a57@syzkaller.appspotmail.com
Fixes: b1d63b06e839 ("bcachefs: Make read_only a mount option again, but hidden")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

