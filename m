Return-Path: <linux-kernel+bounces-425368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B919DC114
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B2A8B22CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ABE16E863;
	Fri, 29 Nov 2024 09:10:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568FF143C40
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871405; cv=none; b=InfZ8tKoVWliUYyM95C2iGxUQgLNWuh7kfjVjt16uLfHTlc5Y2uUwmdcbTQwXS5Ql6GbmNlgxGWKomV6tTSthg5a2KScoYD4r551fmRM8lC5f6xtWE7sigPb9Hs+NozZ+X45JgcOTjLpCyi7tH2zYmq0nHfrIh+JxbGPjYxARak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871405; c=relaxed/simple;
	bh=HvfWtN8ovSVZLDaF0djhaWUwPTTRulGA5u2ywx+UVw0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Bffm2FLeByKejkQ4EnTvKZFkaoxzKbqXMEuge6ZGW48ilbfjdsBus2lTxu1LFNBlv4jj4DOdpfP4csbjh8CqUyZDIsKdqtasPotxKrtT4y3qkUJ/CdmFoOOFBcioHDIuHyN3YfMQREu9cH1qNUHOtuywI5TpFWqF5bDC4nA1r4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-84193bb7ed1so134904239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 01:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732871403; x=1733476203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EToBKhzt7IlOG/uSFwY/2vdJ+cXtPPsnLRADhuODpxQ=;
        b=ZRyBSNMvYiIexWtZFXu7wQRCBeWGmWeg4vv8De3cLpqrbkdUdNVXIAd7vK4xaH6iCj
         /ur6knufSJVxzs7Ze7+xE0contPuWTO4x4bPsxVnc5szmNCCgU/VO7YaphJZ4IN81/Aa
         xj+DqGvfPKbv0hdsA2o7V27M2xmJO0ahrx5COuHxJ9q5rBPo94w04bgfBh8As03qNl7b
         8gAgRAWM+GpF9MF90a92u2qr7PxdXcNuC29gWkE4BCvLR/iZ3SBbJrgCmjmtdpYv/XdC
         Zyffg3qLxqMnL2NB4anqGPoTJy2zbxPOJY3IY6Lp83xpl4MTkl68SwRnEbiLqC+St6VD
         ux8g==
X-Forwarded-Encrypted: i=1; AJvYcCV/dRbQC5GL7+T5D56+/FTaiwNz4vZfKpPde1Ez1giDw6tPb66NeoGqybcASTdhMFbOZhVhkXvv286Rshk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUwe4yBRgpEhIvckZaNkp9ncqbXdTPIpR0SqTO6/h1/n1jbveI
	htcWSSzqr0J0wnRFE+YT0CrVVsaLyZ2V5+OWdw+0NVPKOTe7NE4b2AiL+mTLvuSfrWb0CZWJquf
	u4u6U5ZX4qgQ/Wg0I02No/Ki9XugJP+7eZMfiSuWmGwpNFc9mXMQZwlM=
X-Google-Smtp-Source: AGHT+IGMS7E56/u5abAaKAFggVP9bzNdZXMLLB4/oh4uWG9StDDyd/ITP9+I0RSXrIDU54aRrtVNTPuaY1is9co+z8xVueaVxY0j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2143:b0:3a0:8c5f:90c0 with SMTP id
 e9e14a558f8ab-3a7c555eef0mr106325195ab.10.1732871403606; Fri, 29 Nov 2024
 01:10:03 -0800 (PST)
Date: Fri, 29 Nov 2024 01:10:03 -0800
In-Reply-To: <20241129084122.3D4HV%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674984eb.050a0220.253251.00aa.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] KMSAN: uninit-value in gfs2_quota_init (2)
From: syzbot <syzbot+9fb37b567267511a9e11@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9fb37b567267511a9e11@syzkaller.appspotmail.com
Tested-by: syzbot+9fb37b567267511a9e11@syzkaller.appspotmail.com

Tested on:

commit:         7af08b57 Merge tag 'trace-v6.13-2' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17c849e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d66c9f9a88c492bd
dashboard link: https://syzkaller.appspot.com/bug?extid=9fb37b567267511a9e11
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=143b100f980000

Note: testing is done by a robot and is best-effort only.

