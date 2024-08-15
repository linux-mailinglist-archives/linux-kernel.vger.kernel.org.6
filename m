Return-Path: <linux-kernel+bounces-288619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EF8953C83
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3332813B9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EFF14F9FE;
	Thu, 15 Aug 2024 21:19:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE5C78C9C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756745; cv=none; b=EtsIuJFOsoYICd38+HicvDQe3Zb5CZgmhGAfaRwM1cEJUhQkOjUJ6vDtA2HEi0Pwf20gpmh0AH6bHHguCl+oVVi/ia/1M694DfIIR/jWtrBIlHaeXbc04ktjnk0fXC3VzUlOYEA9IOVOzlSz8sx+FSILbFf9H+H0NeQwkpt2cbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756745; c=relaxed/simple;
	bh=aArgchPkT95Q1Ukr/lBmxz3QXXDbxFb1p0bAQs5jXAU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E6BtpnyoA51Xrd1jfnLiGv/uFgZu7XgXt+x4v5xzLTaFgxNiKJMAVYltpR1MXFOroHx1Vfppdz0Mt/xOrosmLXceOp+0OmXTp+Lp4r3eXzEv5EH2xSpBSuII+yuB+5GaRpBJXCo1aETQKg3vzNXB7EVRKyZRQzQr8b+o3mtlpBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81fb21a0e41so131106539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723756742; x=1724361542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+0T+XqP4Bz2F831yO3gHfxchaB60QBso5aYHjU9iOU=;
        b=kt8LSvaGG37nBvPDzfiXNyRXDvX+XzKFBVWDpXVQv3nztnlT5psxhkLM3I0NBl1wS6
         SBL0fBUXGsVKwOqEoHZ/ZVO6Qgs42PgqmS/IB+pGZC+2nD58/WYtaxZooqwV+aM24pnJ
         kAcMGWGKefhRYY+o/reDJfTnpYAljC952zVfaj2ImekMaWU64ClTKDdFXeIgq5WyT3Cz
         5bZLBDppebAuWGPggAR+5bnM+TOotL7Oys+jcCJtrqoy4I502SzTPmASX5V2rJweW9HV
         YQeeh3NdKK9lZLQ43CA/B/eCQaRsL5XbwrNrRa3wQXj6YSVREwa4coPyoasFzsWsHgaB
         7I0g==
X-Forwarded-Encrypted: i=1; AJvYcCVpqLm/0pWvkFs4sdbsyNnujZFaOhK/Y/CMjsZh5KHbpFPjEnRpZf0B/qOUE6TJdy02xznNR8xGeaKcfkjey6PsLMDzdPdGQVygyRMF
X-Gm-Message-State: AOJu0Yx7Hx3mqzs28G0B9j/Y8ssBLJoQG8jkxax94kH+mhDYHP0MClH9
	h1SAxVjZ0WzcftZC3aZ5BkMNNrld9UEioYXgIkVXUwqUqMare/LgOxvHc2OqVP5FygLbaqTrAaG
	Uyc7fQfRM9n9TMhds3mehiGpQadq3VZoZ1fYKE8CaXCah2gjNaw8e2is=
X-Google-Smtp-Source: AGHT+IECJpjiH24a4azW6T2it93pL2Vz92fb+fUnHvZ1hsjPUnB7XczcG1ri/D4d96bHBQnwiyElvwOKW6CIMrcvQgrv5Efg0dXb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35a7:b0:4c2:7179:ce03 with SMTP id
 8926c6da1cb9f-4cce15d7b63mr20874173.2.1723756741579; Thu, 15 Aug 2024
 14:19:01 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:19:01 -0700
In-Reply-To: <20240815200418.44944-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042e430061fbf64e0@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in kcm_release
From: syzbot <syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com
Tested-by: syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com

Tested on:

commit:         9c5af2d7 Merge tag 'nf-24-08-15' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git HEAD
console output: https://syzkaller.appspot.com/x/log.txt?x=17c3f583980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60413f696e3b4be4
dashboard link: https://syzkaller.appspot.com/bug?extid=b72d86aa5df17ce74c60
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1568c18d980000

Note: testing is done by a robot and is best-effort only.

