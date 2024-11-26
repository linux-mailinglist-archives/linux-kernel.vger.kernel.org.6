Return-Path: <linux-kernel+bounces-422428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DB79D9998
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C01C3B22881
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A101D5AC2;
	Tue, 26 Nov 2024 14:24:09 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7441E2EAE6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732631048; cv=none; b=qNQRfXdx27jtzOUAF/oRFQty82aeFsgSSpKYOOTi2iTdxkaJmaM/vrZtCj0lwICTgPtczL6vQAzURAsuiX47Kc9RJZCY0YLNNWpk+Rp42bKlhw3/xUtoI+FWvD9SZ7CQFydbyZ/4azu+dR7MPvzn1c3BbJkmTiG+uDSmC1bfTsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732631048; c=relaxed/simple;
	bh=zbXV+L7MwoLZKChDBfQNPpwIHPvIgYaxAMf9TaNMm6E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=otv8o2+wiKr9S3y0KlCdjKSnVBFsC4vd3RTGUEXI2XFtyGE/FdeTWySmh/T2cRvpXycLDW11cDRxZn95lE/nbL2gOQUQe99VrxkDuVuJE08BPOZUgPGeUA01c5Tg2ZdfcxU+q0W7Pm6bV/DIfm58W6ty/h/68L9KMDCYLgSik7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a77a0ca771so39358115ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 06:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732631046; x=1733235846;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RbwSlpx0JxOOG/QIfPBgxR7FjegQyCdVo54JAHKqNU4=;
        b=Qb8SgMbh71mnGBcyYW/Hts13Yd4WDdgxl+4mMFX/dXqOVxguOIhwJa7Zo8lDDxZfBA
         A5Mgd13jpW1nr5jTrzQrimLphnOb4jxg7IOLZispjLLwIMSqDTTa1m5DZGJssZp437g/
         G69qlrFio8+DPZnEQG0181TVgfrMLa9EOnV82BZHohIJ3TEXGnbCnfD4HIBMbPfGRz3v
         QYtqmVRjZAIUNMYGpBQiefkwU72mWdKh4HTNxE9kXLBEp+i4nxnvhU64TvloW3i/lbR4
         xLgtA4NmvHQjqodH5tJnbpuoCmTxCaIAq+XlgtTxTLUEW0h+FbsmsBoFtrfCUhExjW60
         V8bQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+DPP3UtN1etbcj3ThJGIsRyDb/JMzP4noCPlIiJ6iumyVVKMvlVDyf2Sc0CowmLvDXNDgc6O4AbEZLWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk36EzPeynIWALTQhvmw0rh0bVKlzs9c/5qq0vFKn4Z3ByDFr/
	vExYZAvoX+07q78DsiR6TQhb/X1UQ7R8A96kxXyOJ02yhCtO0sco+IDG9uTxm0gr/NTLbIcChbJ
	c9xlQz4bKq8rWBG2VJXgVF1kWF2QCXcIttcERRRMep/JHocdcR47Thfs=
X-Google-Smtp-Source: AGHT+IGFP+jT1z0zEfotOxocuElKBVsiZu+rEtdAdSP45JbOgsdPy+Gm91Sy5bDiK+msbCwzbgDUFbDFaTU+8Me573D36Okj1pYM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1789:b0:3a6:ac4e:2659 with SMTP id
 e9e14a558f8ab-3a79ad6917bmr191836395ab.6.1732631046684; Tue, 26 Nov 2024
 06:24:06 -0800 (PST)
Date: Tue, 26 Nov 2024 06:24:06 -0800
In-Reply-To: <673f4bbc.050a0220.3c9d61.0174.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6745da06.050a0220.1286eb.0018.GAE@google.com>
Subject: Re: [syzbot] [kvm?] WARNING: locking bug in kvm_xen_set_evtchn_fast
From: syzbot <syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, boqun.feng@gmail.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, dwmw2@infradead.org, hdanton@sina.com, 
	hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	longman@redhat.com, mingo@redhat.com, paul@xen.org, pbonzini@redhat.com, 
	seanjc@google.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 560af5dc839eef08a273908f390cfefefb82aa04
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Wed Oct 9 15:45:03 2024 +0000

    lockdep: Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=162ef5c0580000
start commit:   06afb0f36106 Merge tag 'trace-v6.13' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=152ef5c0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=112ef5c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95b76860fd16c857
dashboard link: https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142981c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1371975f980000

Reported-by: syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com
Fixes: 560af5dc839e ("lockdep: Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

