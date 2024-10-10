Return-Path: <linux-kernel+bounces-359110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0AE998799
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E20BDB259D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4B11C9DC6;
	Thu, 10 Oct 2024 13:27:22 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6FD1C2457
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566841; cv=none; b=HmjtnJyai5qhudMnMf9NmnxrMauwTMQYe5rMQ0gGOxGNf9W++H11kYCL/jfVXCCj0crVFE8FG6xBw+LPyFWYJdoVbhnowruVja7GNalLge2EyeSHC/KkilGaSLbSor1WQHXcp1AOebuPA11JjKr2QIXu878WvCTGukgrZw5gLZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566841; c=relaxed/simple;
	bh=UhXQFHs84V8s6kt/M2mBog53NsfNJ/wX6DTO1iRzP/c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KMNKa7zT9IuTxQkr+WPZalk69hckEhRjD5VOIWSTn2vK/DpXziTmKHgQDn6NWVd7V97cksvKDDZR84TC/iUzCAZdGcaVoqQzBrPg3e0SfJCxxkITAyZHtasWBLE7VSXEU0QatOeo9mjK+CsBbJnB4UvPl16Z9UylGVI7a3uxuyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3453139c0so12449995ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728566839; x=1729171639;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhXQFHs84V8s6kt/M2mBog53NsfNJ/wX6DTO1iRzP/c=;
        b=mnpjmiRg702rvgIY0sHW6ynwrp2HjcH30xZz3al1zOQGzrCoLd62JAttW70RWVE6SA
         2CRk6YEOe7Qst9RAw5DGtco5oxsasclo9qpV3kNKXTmg0JWqsBT4EL+ameNyslo4QxHw
         lqttYdZ95JoMsVwafBQNcmBNlkUYC7TrRPDCCKNG0WZp2QtoNmR/+19EMd5qAOYTGy4J
         kSYESfzLrnUhB/57GawHX8k3D1kRzReZ8QM93ffQbn5x0pjbC2UfOIst20f+na5xJkqJ
         LgezCk6YW8fKn0rCKHl7vTBp9TxUM8jSuO+c6klwi8iCgBMn6aWCO12s/lZJ0SG6Jr0O
         W9MQ==
X-Gm-Message-State: AOJu0Yxi5PPQI7r6EA8WmbdyYr4NoaGB05VfGJlhIK4cE4tZ7C4cbQPy
	fWoR2WpFK3BwWq6Xk21RQ9svaJF9ulkaFp59NSKZJ9XtGzklAwGlbHKYH3HOXr/U5WQG+ZbYamk
	EYULcfApgI1kqD8vyspV54U0uVRzExPNhdWLmnF17xUucw9shZFGmuzI=
X-Google-Smtp-Source: AGHT+IHeEfjZJZQcT/z9ntfw1dOzPatxkNjDi54xzBAoCYyxoDVyb506eXsAf5n4r/fnwRhP8Ix/l1QucZwIFwl7TYcnxAfiCw5h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fce:b0:3a3:3e17:994e with SMTP id
 e9e14a558f8ab-3a397cfc554mr66220495ab.9.1728566839545; Thu, 10 Oct 2024
 06:27:19 -0700 (PDT)
Date: Thu, 10 Oct 2024 06:27:19 -0700
In-Reply-To: <000000000000657ecd0614456af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6707d637.050a0220.8109b.0009.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
Author: cmeiohas@nvidia.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next

