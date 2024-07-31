Return-Path: <linux-kernel+bounces-269394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BE194325A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04171F270FE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E9C1BBBE9;
	Wed, 31 Jul 2024 14:44:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BFD1BBBE1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437046; cv=none; b=CQDEUh+pi8C5OVoDAJTbiSwwfc98upa04KIhaLgkLBraml8jBzPXswmQ4G+78qAz/SvjFw2NJD8I25jnhP5rXOiitBSctDvYcyFaHU/tN4vzblUNwiyLQ5cLpShTr9QS3kMtdlnp/ON7olj0B7GyO+kodKh+lk/Zwj92IhEcvAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437046; c=relaxed/simple;
	bh=s7m4s2FZYBGd5Z40l8pzGnNV87BwvcwBuBEi541hEI4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FVSrD+pEICAYOLTCH34ikD5W0TfwkvQcpGi2L2m1frRG7/f62U0rWPD6+B5Z6b1/TgTC9YYj9uNRj4ItGwTonGT9wbw5uFTzQCUb/2Aea9sDu3Qdx14A3Q1eHzvEj5QNMfTeMzxap3BBV2pEh7m0jxzi22SgyG7ZND7Ync86Vgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-398ae4327f1so14173125ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722437043; x=1723041843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jTWL3cAg/lsgXr8CYr/GswsrzlpXURT3ZzXs3HSNVo=;
        b=W+HzwlObsRic6lfngVhWbHRNtPoofUJn1Y+5OyDjAGdQzfgPId91rAw+PxM5EMtDah
         Iicn80Ic+/vvB1AQajDkEswiN4x/GFqTsKkauwVD/7WAimFkMucaiJsvixjtbM0xILsx
         6q7yTbymkAWBn8xGQwkOKyjvnR1aKrc+D+bFwyufRelhopqWvuaNVHuLBHDOWhLS5Ome
         juilVzMFJuNF5ngpFaBbXJcvWmJMmjYsGPfNfw6c4oGEmtIlD+wY0OdFy17WX6tU4py2
         ePCTGffW4z0+TewCv6BUiPJfFIGxoMJl9RGisvsuxLI5MA5pp6GA7lflw3UoOHQsSf/W
         NqRw==
X-Forwarded-Encrypted: i=1; AJvYcCXi+TnsHUDLJVWSKJ5pITLKbyYZ4AV5yGzVzoJzAdh3X6hH6/rmH2xL6V2Ub4aMVbQYnnqQBY7xfyB/NkAcKlQnsMw9zMhl2MU88X7P
X-Gm-Message-State: AOJu0YzMfMxtNfqQsPU2dRYTkZ6r5uMjriRg3LwEYsExRPdpVcl4c1TF
	Pe3hnpfZBYNUS9buc9T2w7bUfsHbQrpqFDoInA7EO3dry6/jwdjOO8XVWfCssLDhbKC5AOUiRCh
	KHBTDpsJGj1HAFkRDpFyeSH/iqGhv4iiJc5CMyw2hnVQzGAUaSvsl0eo=
X-Google-Smtp-Source: AGHT+IEW2WNDMoJVNc+XCDY8HK1IHQkKOedfDe/QltFdvvE7ezy9fqkdxv4PWI3Z+7hzqlh4M8LybKGUHa3d70g8VBm+0ee0pxIx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca4:b0:396:256a:2e01 with SMTP id
 e9e14a558f8ab-39b06ae112bmr4092625ab.1.1722437043712; Wed, 31 Jul 2024
 07:44:03 -0700 (PDT)
Date: Wed, 31 Jul 2024 07:44:03 -0700
In-Reply-To: <20240731141548.13707-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002389a1061e8c206e@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in team_device_event (3)
From: syzbot <syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Tested-by: syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com

Tested on:

commit:         e4fc196f Merge tag 'for-6.11-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104c7e4b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c04fc17f2c61c03
dashboard link: https://syzkaller.appspot.com/bug?extid=b668da2bc4cb9670bf58
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=124f29f9980000

Note: testing is done by a robot and is best-effort only.

