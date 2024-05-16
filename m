Return-Path: <linux-kernel+bounces-181602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600228C7E71
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 00:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1506B281868
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 22:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4871586C7;
	Thu, 16 May 2024 22:01:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7882F157E82
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715896864; cv=none; b=Y0DfFpakXy9Pd5hNDmMq8YLad1r9Z9j6uLbSnRN70hyz8/hcmAPnocTgeqeLLNQCe27T+oGT9qJZpsQfHu7VqwNLFLOTcHlF1UZyr6Oy249yGPpJKwEg3UwEXEG2oR4XgRDxYd9EWSeoRYW734ewQrhoZeLrb35r8+AsKk0SAT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715896864; c=relaxed/simple;
	bh=5ApjjVyG5kOb2GvSyJn4jbkb/QGye5113VwQa+dzRSA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MJ1XV7XKRymsTwzbwroHjE7l4VuIxSp9PcSbSebVKnOSPWcQn8ij/ztBgoWMZ4+DzIe1Yizt4uoGVYZdIOxBDC68P8kWZzrEwXc4wOqCwLrrZxRqYF9H4Az6QRF2VoirsVyLCVYvz4M8u79OPZk3c05to2tmKQnKQkcSYjTAJ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e1b65780b7so907740139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715896862; x=1716501662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ij9UOEi/rvEspETVKvgQxDYWhFL0r2IXg+Lgbvqktpc=;
        b=n3TB7asKGLwPBPpZUxIOl1iLGcXjGitJQ1jRNOyY8SNlqsUfS5OcpSru/UoNPEFC/c
         eGlFZ3EaviiU2Uh+v1uA83yzGd6iaWoPB3tlIFsjrUL+Xn/B0B2hR8aMnajof8FG+/kA
         Q1diNewD4T4ihiLRIEcPP9X08pn6+Va4scPm86us96P4fRoZLHKc+Qlu8FsgnSIWGUAi
         b24mVWWZBFGHkS4X/5XC79swHuuN3BSWF9slI6kHgVIykH6FUqzvk85boKhZNHwt9UkC
         wCKr03g6h7ZiSh1ebI4fF1uXHU/gieWsjAaR2el5rrjJXLeusxKGHB0V1dBElp5Q2KKX
         8j9A==
X-Forwarded-Encrypted: i=1; AJvYcCVlAZ0Kkt/39CSkQurxxmVtEjFNhpVVPVpUZT/i64yPoKvDESCtU3UwNJzi8xo7GjHhB62cAPJNUbUNnrlNwGIkyuRaPyU6nWLs0DdY
X-Gm-Message-State: AOJu0YzD3VEsoz0VcCAVTR1UUxpXLyMfpcrTMnKFQftyNDbXxz4vDCNY
	dEZ0VTtWtoO9s8YQUl4M72m3EgPLk8FqIwxWWK2+79h4L0uzGraTa85/SP7/4yW6ARw9BKy8RGu
	4ualX6Pu6qzV9JeHFeF2qUHl3JZJR9UFW/sSiAWSswAclpstzEdzb/qg=
X-Google-Smtp-Source: AGHT+IF4FYXyVi+PNgCKKVgxVWjwAbrtBw5UnExXmcnE5b/QOXgG13UczkaJ42LJBz1xoWmDg6pwDEsXRfDUDYXY3d/3NYS8VAyl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3ca:b0:7de:e175:fd2d with SMTP id
 ca18e2360f4ac-7e1b521f29dmr162925539f.3.1715896862636; Thu, 16 May 2024
 15:01:02 -0700 (PDT)
Date: Thu, 16 May 2024 15:01:02 -0700
In-Reply-To: <000000000000051b2d06189716c3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8112e0618995e6e@google.com>
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in schedule_timeout (6)
From: syzbot <syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, gregkh@linuxfoundation.org, 
	hpa@zytor.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	marcello.bauer@9elements.com, mingo@redhat.com, stern@rowland.harvard.edu, 
	sylv@sylv.io, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a7f3813e589fd8e2834720829a47b5eb914a9afe
Author: Marcello Sylvester Bauer <sylv@sylv.io>
Date:   Thu Apr 11 14:51:28 2024 +0000

    usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119318d0980000
start commit:   75fa778d74b7 Add linux-next specific files for 20240510
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=139318d0980000
console output: https://syzkaller.appspot.com/x/log.txt?x=159318d0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccdd3ebd6715749a
dashboard link: https://syzkaller.appspot.com/bug?extid=c793a7eca38803212c61
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dcd598980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151d9c78980000

Reported-by: syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com
Fixes: a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

