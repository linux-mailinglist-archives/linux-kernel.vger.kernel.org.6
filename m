Return-Path: <linux-kernel+bounces-417674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DA49D57D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B41D1F23517
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5D8155308;
	Fri, 22 Nov 2024 01:50:09 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428E44CB5B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732240208; cv=none; b=A2b/RXNgompA+ejJHw99v5IIZf+bdQ1AyA+F5VBzN2BmZ6kLDdBUxbNKtao3wcsX4gaOtRzI4SIk0D9WeS26Pdl5vJ8PuMRlKoEIjQvnwr4Mfw0x2tcqJCfdU1VPKb9rWQOC3jeJwSNN4wYMAW8Y4gWD2ri4Vy0kJqG6l4Cqq0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732240208; c=relaxed/simple;
	bh=AIB6lRUMxRZwkfTp483ALegbrF0HxUXosDls1nJebxw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nBXj2xGlE5Hwzi+62fnv/2r0Gi6qXP6WcL8wdD2IHpCD2DJ050mrZoUkDEprD6qf3C9Av0c2k5cD2hmd0TwUINOm1iDxL0ZNl3vSjGwGvO7unV71Vzy45I5uKO20L6zs6fdd2+5ykkgaWL0xwyHlQo7zKLBjyz/otYN/nem0HXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a743d76ed9so24729895ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 17:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732240206; x=1732845006;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hM1WsEEJmOW2Pp68a59mfzUdGKJRy1OSlW0Y4+BZe1E=;
        b=CvQC9ds/283dJEnWS7veK4oaDdzp2GZ6VEpwCMrsgRJsx/zVspqsGQUuIuFrPEAcdC
         Cyk01UHPdXtDVWtX81nHC9j5XzrZQtQG1IBjWiuw8rc1JyG8qk51mZ2EYuKQ0WmFQ0Ez
         apbKr87OxlJtEibVZ5W5O/vsn41enqKaoTcpKy6+J6OEuQEAksaSjYbfGYlyFwhEHHGW
         tW3MCj+fV2WwKucbvhdG+4s4nXAM3xgVitUdkR8dBQU1esBOG1Y728K+7ZmHkmxQxShi
         O1WSPoj52ltGDdy6MVtW9QC9MqAYeQ4nwCg9D/iXDum3+qCjw1+fcMf36VspnhF6yL09
         Tgsg==
X-Gm-Message-State: AOJu0Yyu2SsYmtPYS9BSgeWbb9q4uTQxNnLdcbFQTz0AENcMp7tSSAZK
	hsr1aTXG6ohJuNKjpRhXyLvmu1V9le8f52a9AGzthmN7ViJXaGvJi76ekHjOKrkfXCYhXzPV6F6
	34XyxchnPtAnq/kvxSlResZ88ye86Ec+K35wUzBmjHTYx5UzncGJjvzE=
X-Google-Smtp-Source: AGHT+IGB/7oVM2ArV/6t04U33fh2ki84SMSswxlSEv1sxlKYGW6oGmZgMMMzNoacCy1ZpEaJNfPlGj/8zBdefJKZmpKs6Nmz4uoj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ce:b0:3a7:91c0:dd4d with SMTP id
 e9e14a558f8ab-3a79a5e20fcmr15053395ab.1.1732240204988; Thu, 21 Nov 2024
 17:50:04 -0800 (PST)
Date: Thu, 21 Nov 2024 17:50:04 -0800
In-Reply-To: <20241122011436.4005307-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673fe34c.050a0220.3c9d61.0185.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_nop
From: syzbot <syzbot+9a8500a45c2cabdf9577@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9a8500a45c2cabdf9577@syzkaller.appspotmail.com
Tested-by: syzbot+9a8500a45c2cabdf9577@syzkaller.appspotmail.com

Tested on:

commit:         28eb75e1 Merge tag 'drm-next-2024-11-21' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a14ec0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef9abe59471e0aee
dashboard link: https://syzkaller.appspot.com/bug?extid=9a8500a45c2cabdf9577
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f64ec0580000

Note: testing is done by a robot and is best-effort only.

