Return-Path: <linux-kernel+bounces-407290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 663DA9C6B69
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1878A1F23F40
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A951F77BE;
	Wed, 13 Nov 2024 09:25:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCC81F77B5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731489906; cv=none; b=LJZZA+i3KH6J677YZTFDZt700at68UJSOBcGxVKQSsDOA69pqBi+kSWbh1kBLdXaaKRJUZp3zrCYVDi8Dd7ZrOnvSHs40oNafo+FbA9ZTfiZW2UhzSrSCU2w5TQQkQjJFgoVkK/ipwCh/xDRcprpnCoaykDkgvTFVksZu63VxgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731489906; c=relaxed/simple;
	bh=e3UrNK+8NPWtavtHg92BvMz6xoPfhy5/J5qU32bVb60=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gaeSWcjVLfZY5rDlKIyO9E265y/lDq1rPw8vl6UQP5gZzr8S80yh2IHzA8Xq40T2Bqf9Kql92oV15W6MsAlDAyKgciRYTFjZsD8IvS6GFdgvFSmXpIFFZWLB6jBFSPzmyxGiGuwrjqdbS06B4CV3tPsJ9qev+7PjMIAk1iWQ7CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6b963ca02so69881925ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 01:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731489904; x=1732094704;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayS9w16ckU16tbXa/VPShI2venzkxWB0dzj3Wvipfb0=;
        b=njGiDp+tTqHVYk05NvVWCYAMphE1mu0+AL8q04MIxeGYE5WS+hacy/qjFHwzqoC1Do
         Tozza8eECagq5ILvKmLd7AkBlvyfXQ3WXmTv8jixTXCyaWzSLA6nLILpgXc1wePfPrv4
         4NkvKj4+YeNjLJ8LMu/gEBrlHI1v2q59hImz0N5J51uCLDCKcdEkl6Gf6H/bcxAGBQhV
         eQXn0nzQ9ZJ734zPIgQJhzhKwFtaYgTWr+YHnxQWvJUlRwtMGgnpitCtBcKLM6Asul+z
         xGbEPSTF0WBA+qLzkTJPYyypu4qpF12t6u8tXgqMzne1gxAbt6dF9GNc5N0bqF7d2HBQ
         25tQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9TiwnSHYGWOsAp1Xze5SDLll83uaCZ2Q3a13L2AVDQamfthQKzrw+3Qt1jxctKIFemtHPz8gA2TJEenQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/cYOgYP0QohQapqpY1VtXFNYD6d/l4knQ74Q3AjSm/BObWSm
	L80ZOlh2/HCKmdh/hbabclaxHWeaVDfIddi9MeUIbwmJ6LexwrRs1sQOm2969tweT9RLsbt6yzR
	95axjGpjLmF7qcEXcR2SdJq9uugvnG9QDqtyhZ6Ua2n0g5h2RQx03a3o=
X-Google-Smtp-Source: AGHT+IGuJj1OS2MF+6vk+YiGvRYN6Tf067M2YWDsI74/oewrrtGSF4Ccm7971A7xBXi/M6rdvPHJtthKe8IAJxKXq6PatAIRxB8M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c03:b0:3a6:bb36:ac3c with SMTP id
 e9e14a558f8ab-3a71577274dmr23393925ab.15.1731489904585; Wed, 13 Nov 2024
 01:25:04 -0800 (PST)
Date: Wed, 13 Nov 2024 01:25:04 -0800
In-Reply-To: <CAFj5m9+j=KNhaRruRZ7p0Nnt6PiqOVQN00vhgcwEgfKji=rJEg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67347070.050a0220.1324f8.0009.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in loop_reconfigure_limits
From: syzbot <syzbot+867b0179d31db9955876@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

security/apparmor/domain.c:695:3: error: expected expression
security/apparmor/domain.c:697:3: error: use of undeclared identifier 'new_profile'
security/apparmor/domain.c:699:8: error: use of undeclared identifier 'new_profile'
security/apparmor/domain.c:704:11: error: use of undeclared identifier 'new_profile'


Tested on:

commit:         bd05b9a7 Add linux-next specific files for 20241113
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
dashboard link: https://syzkaller.appspot.com/bug?extid=867b0179d31db9955876
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

