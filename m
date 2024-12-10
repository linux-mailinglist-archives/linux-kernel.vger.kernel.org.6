Return-Path: <linux-kernel+bounces-439237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57D49EAC9D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99368188C203
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B328C215777;
	Tue, 10 Dec 2024 09:38:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEA8215766
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823486; cv=none; b=gEznkKcJtWPtS/GUEH4MCD2Ch8gQvfvP9879I6FwO+iU0An5FbLF3SvCtxaslgO4t+PYdScbDCGTm6z0lQGiswb9CneQwseM+kJB9tdnp+7gS5AjgXTnj4vSLT9IU25nFK1+qxA32276Rkwzx57S3uSCpIQSZFcJ+oa0aQpWkUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823486; c=relaxed/simple;
	bh=hnH4kevc6kex4L+RzlRqFCWeJulTQq6H47qyNdG6MMU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qJqYdFXqFnT9H+o46xVB3YkeeS9UiOMk/4glkRP4ci9IwVd4v2H7mXYWbYD8DPK4+1CgOZ7CHaBzHICL+uKI/DWZtMfZJYz4UUzRjDvyOwxORCuuH3Wx2zcBbUqbkllK0k4B1qiDvvLGhONYQEKs5TUI3VlHThIdMn7cAUuOpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a817be161bso32459555ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823484; x=1734428284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0eziENA1csK0hH7tHldiihGt97BRbYtyrISTtW9X48=;
        b=Jow7RTAAVDhmWNmG+kIAxqHV1CDjvr8IwYSn5c8Hr/w1L/sB4Enzbe2e9fA5RCz2G+
         wukMOsX0O/SJ8+pEY46lGTG6ue9NQTTWuFIXraEqbUR7C7Xdwv3bk3KW/Af2RV4lYlPf
         Gtjbk3YawlbcuwyL5bmWG18quHv9TjvH0DQBYuLhOPd+wdZ4KwzpIQsrShnF1mYOKTcy
         OQ0qNrEMDbcI0wnCtzU5u0ZyUC8ToYwRF3GYaS+iJmouWE4bGr9gn504XKA2x4OXnTLy
         Y868f06+fpnfHXOgWNyFgtryy1h0dPd6/F32Xf2Q9yIPY32WGsD30YUcFr3BXhPSuMtC
         5Snw==
X-Forwarded-Encrypted: i=1; AJvYcCXJFn0Z/hi8u2hubgHJb1ENBuvuGNXg+K9fi2eqWf6srvduEWYVhVm6uvdbofGLaWPcrMVCwM/6JT38bBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTRU4/jK4YGA+QC2tjIswqqiwQypAmjAGmH7ee8KgPnLQI10Zl
	b4Y35helAT4jMbPOpmrVtZH5s0DS+glRYLLTdUTtMo2nZlLBu0UUZDulh33S2Opl5wgY1MeYXww
	onokSeYenAo/wtL56XbAngSBFRHYBwfRdHX9cQB/krsYzMITILJaQAzg=
X-Google-Smtp-Source: AGHT+IHIzZV1uS4FARf7vLtejhT9vxSjcap83WYIYeYrAO4ZSQLSUIg6JmKOPCjRtDk7/akheUbpa+jYYegxUly+YlWJRFjvtaQk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa4:b0:3a7:ccb2:e438 with SMTP id
 e9e14a558f8ab-3a9dd3bc479mr26328655ab.11.1733823484045; Tue, 10 Dec 2024
 01:38:04 -0800 (PST)
Date: Tue, 10 Dec 2024 01:38:04 -0800
In-Reply-To: <671bc7a7.050a0220.455e8.022a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67580bfc.050a0220.a30f1.01c7.GAE@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in vcpu_run
From: syzbot <syzbot+1522459a74d26b0ac33a@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 45405155d876c326da89162b8173b8cc9ab7ed75
Author: Sean Christopherson <seanjc@google.com>
Date:   Fri Jun 7 17:26:09 2024 +0000

    KVM: x86: WARN if a vCPU gets a valid wakeup that KVM can't yet inject

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11ac34df980000
start commit:   ae90f6a6170d Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13ac34df980000
console output: https://syzkaller.appspot.com/x/log.txt?x=15ac34df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=309bb816d40abc28
dashboard link: https://syzkaller.appspot.com/bug?extid=1522459a74d26b0ac33a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158d0230580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f8de40580000

Reported-by: syzbot+1522459a74d26b0ac33a@syzkaller.appspotmail.com
Fixes: 45405155d876 ("KVM: x86: WARN if a vCPU gets a valid wakeup that KVM can't yet inject")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

