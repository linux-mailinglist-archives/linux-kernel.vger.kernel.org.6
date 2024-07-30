Return-Path: <linux-kernel+bounces-267321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A840394101D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63587284A68
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4039F19DFAC;
	Tue, 30 Jul 2024 11:00:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AA7199389
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337206; cv=none; b=jpwsvroX7eDIIeFrmIJDWBCgLf1ndzWcRVOs3wsEoH21QQIiOwRQGGV7CFr4zDALcgFPIUzCzhIS4lP2kVnyBo4srTAzjdkggV9nRPgKErC1UgMPnPq5dq1MCx6Ard32+Qn9rIS5ekXi2wLDj0rFST770k9JpkihjQKXmZkqrBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337206; c=relaxed/simple;
	bh=7/zSghOsO/+ohSfNdiHJsYt37rEBzzUbEVydMJXZiks=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=I1nrFWWPsNRI0qD8RsFneDdznfMZ1fB6EDpKHHgwdQ7oQTslSVo5+wzwokMwjQgFcELp1r1p1BPxnJbrEcJZ67bTVSqg0l2RFYNIYKA9DMPW8iM1YqKWx+MilNhE0ZW+1xCLJmbzsbz58rAzK7wJN3fzhKTRtn1+PwQJThsIcZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f8c78cc66so674032739f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 04:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722337204; x=1722942004;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXNGiiF6PZnIEppYDKDeXtIbd3Wz+BDRNBDIPWnAEGs=;
        b=TA5/2Iw/JjTIC6gQTU/CxHZLFPkd4kgaLkFBjMq0sG3yW2VhSqxJPzseNO9+jEkAQb
         4Wk0/t4oV4ORKw6S7B10lbR/A2y8CW+wrBXa83fQI9IP2CDSYFmp3kcLffgIbKbgeFZ3
         czgnI72ahNprOqcOStpR+WVrY1JXaVhvApd1YUYaN5R1TbZeU8NUZCqxjAeVrLGFZ9PR
         sNmMnBY/ntvB97CH+BaUlcPOitg7iaqetSlKoq/RdCp9unmsFFDK1f6rIp7M0SDjrHyh
         +Vi6lA/O3iGxQYrgoVT/pmXFZXBk2rRH6D7BKusfQFGi5YDPFWqPh6KVaYjeMWEKYezI
         EtTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWopzRZNJH+aaevKQ48ULjjiIr1XekDPRrit/P8N7gyvfBSZtWlNmedQZmkRH3jnfD0fILgHFl+D7UC83elfjyEun/W02dOMZROZulT
X-Gm-Message-State: AOJu0YxNZ0qubxnPUHevxkb5bCjFQCZfQXV58f8t6Bvtc4KYEvPYSKuv
	fcbdFuSEGZL3KcOIEVp4MnjatjZHnRgHL4YUsjip7eOPQ638qMMo3mJQUFbSxjk47Rby8NZxlLT
	Q01zZW6fMlqGi3fU/tmiZtlS/RkNZrIFIpruDq1oe3Xz9xeY/PfDqByE=
X-Google-Smtp-Source: AGHT+IEDysm6wtaPUGs0aWDcCep4e8pdGPJs61zCKGHHToRahzqlvZu05LqbuKTZg30Zm6FMNmjZDMgRwiHaMri2DpS1/Wzn3wGU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178d:b0:397:3a28:94f1 with SMTP id
 e9e14a558f8ab-39aec4177b3mr8138805ab.3.1722337204064; Tue, 30 Jul 2024
 04:00:04 -0700 (PDT)
Date: Tue, 30 Jul 2024 04:00:04 -0700
In-Reply-To: <20240730102200.2312-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b634b061e74e106@google.com>
Subject: Re: [syzbot] [wireguard?] WARNING in kthread_unpark (2)
From: syzbot <syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5301
 } 2655 jiffies s: 7261 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):



Tested on:

commit:         dc1c8034 minmax: simplify min()/max()/clamp() implemen..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1547f655980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2258b49cd9b339fa
dashboard link: https://syzkaller.appspot.com/bug?extid=943d34fa3cf2191e3068
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=136148d3980000


