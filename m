Return-Path: <linux-kernel+bounces-379399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D419ADE28
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2465D28321D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59B61AA7B6;
	Thu, 24 Oct 2024 07:49:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B6F171E6E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729756147; cv=none; b=FHR76muVJgHry9GxxhH9uNHPkhInoH4ZngRe0ieOZAcB5BFPlbJwfVhziou+WYRal1MFPdaepA9Uk3l/pUFBhNLtXtoNIeiX1YcGTEIGujlrMU4LEWY7zuPxv7v7Z31EQM7GgJUvFvJnxHvebFbPEyoSaSjZOZF87xg01hR3D+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729756147; c=relaxed/simple;
	bh=OwrYu1JIneil6AEd729hYwKSogvKc3IlE4QCuiMO4jE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=enKAIaVye20cvX32uXi0y3U8eapdFDkjZJOpnHRvj53cvuo3sZbnQErNhHkJjEUKhvGq2PmO45OD3OFMAuaT3bKyd11rqya/VzFSuZXfPwvBXBSyZskSo/tDTaSbBvkqq3P8cQAVvVJ4D2QYtGaQIQqHSqsyHFPT7xH1WQl0pg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3f7b8b116so13169415ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729756145; x=1730360945;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8J+aA5u6HqJPaYz2e2sNeYlLBOe+Fz+3WCPSNrBAeI=;
        b=foZgnPxVi4EUZgOMhqUgR9Z83omSisxC1+NT5a87HQGyULEFvsUD5WwZ1k9wdlBbb6
         68tf3+VL7eb8+v77Q9JmNtpwyjmJ2GN3J2eBOV/ukGaZr7ZtSZyEj7DS+oDERavdEVOf
         TfkDEkcqr0ELepFjZRdYwXmf/JKmAmlNYkcoyK8niUIY9f8a0BBzkY/HnIZ5jEsUddEy
         IKFOnNScwik0IvR8KIwN+sJF0CYeuRDm9USBsyH181oAKDHcXHuVTzFFmLjagKKzXFpz
         +63bW7Z2c9eZwrD/Dc1kylSPz+qvW0ZlmFUcW/LUb1aR7c6OAClnb2ahj7J1SKEbSRR+
         /fmg==
X-Gm-Message-State: AOJu0YxD59R25gTmtKm/s7jbpjs33tVxmKi7oT0IpMNq77VGPpvqnTDw
	LN8mqrqAYxPEHlO1ADIg5QwzUyuz+YXePUAMo5cuEhOsMyfYHLWCo9gwxoVDmgC6YAe7+GmJ7TI
	CJ04B7ZEuK3vy3o+e2ISFqL+ZNpV+xI14gdbC8EKYXW58pcpBB4xQ+/0=
X-Google-Smtp-Source: AGHT+IHt/K1AHDqZYo0XjQY+T0G2sT38qwzidzRhUPZS/s9IARFby8zKznLFR60sl4WPrJHzzJqmKYu6q6zxlweyqFigonyOxbfv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5aa:b0:39f:325f:78e6 with SMTP id
 e9e14a558f8ab-3a4de685e50mr6518815ab.0.1729756144787; Thu, 24 Oct 2024
 00:49:04 -0700 (PDT)
Date: Thu, 24 Oct 2024 00:49:04 -0700
In-Reply-To: <20241024064539.2963555-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6719fbf0.050a0220.10f4f4.01e6.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in bch2_reconstruct_alloc
From: syzbot <syzbot+9fc4dac4775d07bcfe34@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9fc4dac4775d07bcfe34@syzkaller.appspotmail.com
Tested-by: syzbot+9fc4dac4775d07bcfe34@syzkaller.appspotmail.com

Tested on:

commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155a2c30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=9fc4dac4775d07bcfe34
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1792a287980000

Note: testing is done by a robot and is best-effort only.

