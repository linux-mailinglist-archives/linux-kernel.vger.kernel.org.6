Return-Path: <linux-kernel+bounces-323860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EBE97445A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478E7286D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB16F1A7AFA;
	Tue, 10 Sep 2024 20:54:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D416188014
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001646; cv=none; b=WARJ2e/cpl15Cgu1JU3z9PQgIZin+q75vetzf57bnVgR/DFOPXb/pOsdqyXqJYtgC0OAPyWSHzJ6T/z4icpptoCLhwukl+Q97Nr0t9Ty5NwOXpu2NvYvDWSCZphFCPTE0exKelpiFHTmrGn+iRTsXBYF+ZEv6eUAatthtce1mc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001646; c=relaxed/simple;
	bh=RwzGvapeeRH7XetFACT0uewYHzVn3oFojveFEc8hBUw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZBkm5h3laEpJ2pZV0DlQmi1lBxSJPob/Co3lrFLkcvP0IwycVrnDgZcX0HcHNlhFknCqIew4ZC+ASGpY7TNIpK+/9uVMKZcM29iCr3LCmJuSAVNecr4kcTzHBEqIb0cEt32MXCK2wH/io0/3nzxjR2DvaF2jnS1hbj73S2OuxUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a05009b331so91404595ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726001644; x=1726606444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RyV96vAFTl+By8ihu8Tu0CdZO9CWmRcTNtoodB/548E=;
        b=vFZDV9YjtdOT40WjW6mzax7zeBSC3NYhtfdI3yCGegKvg64RrtySIIfU9zkdX7QFO9
         j2dcgNb5O9HvuTq89tRXecpmH9OmNS0xHVYQu7ybbpeI6CL7ksmVSDeeTsR1Ewyokn+S
         B4GBNYrO1WQsMflQU0pn4pFJJjRPYnAoQEoZcmSn9eoN85RIkFzBLZbLYXFpayzSRcS+
         KAKsumQ6zMRs08AW0ci/Ws4b3K0g0qG5GV887p5eRkscIImLZRwlMwkHCl65y5D2XsKh
         O4GMndJfhtvhqmCuVAChx1iPe/ASwUdktw6/ApnLIZD4JZCR0BVF/9Oot/bCPA4gJELp
         TCpA==
X-Forwarded-Encrypted: i=1; AJvYcCUO5R2cIwOlSA9MipwhSKeYPj2h8p1vC5NEm9Rd2rhVbVNYWo/M3obX3YBmvNcfweD9sMT1lHrnYc78mcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YybMNWqExwoItnh0vu3dn+8sGPuEBc/y0Xd/7etsZ5yJxb9wmVO
	m/Kp/ncKAQob15iFfU1b7ozP6TYsL/asbBufB7dDK9tBWbRMvidAwBXPtcwd5mnZdZnOHdhMK+8
	ZTtYSwYqWjHJAE1wgbMZ7/okO9CWl5lnWX0pTNpUb3k0DTW+Wo0f9gcM=
X-Google-Smtp-Source: AGHT+IGV0ogP4Dpm4jWtocRMUFmVFaIT3ElV1jVGQGN1wLWr78W5eUJgGDLJZPgE/htDkGlm5K+QeRdxGwK/pH2t1h0q5PBxj+tj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b06:b0:3a0:4a63:e7b3 with SMTP id
 e9e14a558f8ab-3a056868d66mr121774505ab.9.1726001644091; Tue, 10 Sep 2024
 13:54:04 -0700 (PDT)
Date: Tue, 10 Sep 2024 13:54:04 -0700
In-Reply-To: <20240910203231.92230-1-djahchankoike@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0cfd40621ca1231@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in bch2_fs_recovery
From: syzbot <syzbot+1cecc37d87c4286e5543@syzkaller.appspotmail.com>
To: djahchankoike@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1cecc37d87c4286e5543@syzkaller.appspotmail.com
Tested-by: syzbot+1cecc37d87c4286e5543@syzkaller.appspotmail.com

Tested on:

commit:         8d8d276b Merge tag 'trace-v6.11-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1080249f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=1cecc37d87c4286e5543
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b0bf29980000

Note: testing is done by a robot and is best-effort only.

