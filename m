Return-Path: <linux-kernel+bounces-260204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3383E93A478
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CB81C22804
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87781581EB;
	Tue, 23 Jul 2024 16:38:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C685153810
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752685; cv=none; b=oHRsWRlInlX1/K+7vJNEnAvsZ9HG+M8arDJuJeqShjpUdl9nI1u3TjpPTYt95/cm4KgccawIBKQMQd0eO/tvlL+hRIsh5d+OR/F6veK1Ro8vJsGYaJCyMnvOrHlKEYTkKbh35DAr8SN3A/DPuEJbM956SX1mOes1zEwor5izi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752685; c=relaxed/simple;
	bh=plV4BceroFrnmWBRfhXLDVP+3O0ly2TNvFFNbqKdCOs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZVUw83/+0OhYSLJI1ZRl4g3NV2ydyt9W0c9NMLazdIP2dt746vkj8In0zjtsesK5QSBWa24gTTWvXhY6FPRKuGbVpsLJcFwoyktORkPP4LLx3+YWXvcFhsJMK2qkSUR4k434WobfJkWlsZ0DSlN/0hGKeibpcAbBoesO+N8MDys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3988d01a236so68498095ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721752683; x=1722357483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOwvnEes1AoJ6Xm8Fqr+kATxyUNQFm03988xjJMTQpo=;
        b=jv/mBfqkzKJOc7265tEGSAAbtsHUq2QwNisRXWSi2eDlylkKagRTZnPtP3xLkajxUZ
         oK8zOZcPy8inmyaeNWsnjY9CYzRQ7q74wCCae/8wqhh/vNYPJkVSYEXE+NfxYYSadpPH
         H9jsSZd/5Y4riMh7URab9dietfwvA1sp+/mdq37fK1cug8Z5lu064tk2psuV3I40uKnn
         9wi4+T8vSYCkneL9uPToqM8qk0pHtSNTPy/s19VO8QdJ1sv5RLIorf1IEHl1x2KVmIX7
         Uag38kZdyhKHR5uzchx10nDxWBRUrKKFoCsHzp+xRDmI86PVS51w/J5sFrv5eEyRqyui
         hcng==
X-Forwarded-Encrypted: i=1; AJvYcCWXuNA18kLoxWnymS1SVHOZBXhzDCOFfpVcCmyH6Hhz6M+IgHRZM0cMMM/+RksAj6R5RWAGHi55MumsIpfURE2E6F1RvORCpYxxvF1z
X-Gm-Message-State: AOJu0YxcebY0FZ2zM+TCG4kbFv8CZDixSG2vi4XRU6yZAH76QQsklIaT
	Wrgt1/A9bY6X2AjGTsFGmO9dGNDnWUFQKJxhWt3DHXtfU6upSMKGviPtd7ak6tMKswlkfYTsFov
	x1ZYRFn8okASARmOdS0G+uCDHnyu/m0q0JoBPpIrlBgvLXeSrF3o1VTw=
X-Google-Smtp-Source: AGHT+IHmKTpEoL/u8HxW20QMHzQChFfEbFqk5CrIYfeFt8pDRZQTpH9Phal6Z6oPt9uUkMBLQzkbhyYXBOSfDsFRxST5CVr5G1Vm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35a2:b0:4c0:9a3e:c264 with SMTP id
 8926c6da1cb9f-4c28a0a0340mr15248173.2.1721752683165; Tue, 23 Jul 2024
 09:38:03 -0700 (PDT)
Date: Tue, 23 Jul 2024 09:38:03 -0700
In-Reply-To: <0000000000005736990617c4fa63@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000124c1f061decc9d5@google.com>
Subject: Re: [syzbot] [net?] WARNING in inet_csk_get_port (3)
From: syzbot <syzbot+2459c1b9fcd39be822b1@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	eddyz87@gmail.com, edumazet@google.com, hdanton@sina.com, jolsa@kernel.org, 
	kuba@kernel.org, laoar.shao@gmail.com, linux-kernel@vger.kernel.org, 
	martin.lau@kernel.org, netdev@vger.kernel.org, olsajiri@gmail.com, 
	pabeni@redhat.com, sdf@google.com, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 543576ec15b17c0c93301ac8297333c7b6e84ac7
Author: Stanislav Fomichev <sdf@google.com>
Date:   Fri Apr 26 23:16:18 2024 +0000

    bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type enforcement in BPF_LINK_CREATE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12f0b0c9980000
start commit:   977b1ef51866 Merge tag 'block-6.9-20240420' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=85dbe39cf8e4f599
dashboard link: https://syzkaller.appspot.com/bug?extid=2459c1b9fcd39be822b1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126c6080980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11135520980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type enforcement in BPF_LINK_CREATE

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

