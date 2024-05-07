Return-Path: <linux-kernel+bounces-171363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C675D8BE347
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6736E1F27D58
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9292315DBDD;
	Tue,  7 May 2024 13:14:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6002C15E810
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087646; cv=none; b=VTPq+3j0qHHLsMXZxSkmx27MyERJkVO9HvKDQ8Wf4xmKpEk9ZPosBTlt2/+pKEIuMXQK71xo1aCGXCpQUdU24+QH8Axr1KH1aVI4ilmC+nmL9KHGadif8KHaakMlN/mNfkrPU2o+pAorh6rT2UCQTnS7l6zfSsxzSm1mrKGX3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087646; c=relaxed/simple;
	bh=MBVFigmtXp+fa1asaeuDh6UbDMKNYhBh484SRpNvfBQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kP/r9hKBoy3FTLJ6uDyCW7BK1bGmKBl0W8bGo+EuxDkYBesVsx7Qt4r5gZp3auCYrv6ljTpyzV9HuPYqFlSikuddFmEOhOzencl6GFZt2NwR3hHK5Al1eCoasOLr37btnXqDsr1LjuW9sBuSX5fZ/L1TgrLRTaMXIqTBYqErAdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e18055c2dfso117632339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715087643; x=1715692443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLJ+z7LiDDY0HOHJwBMnTZsmDE8ItBIhU+B6/yu3WkY=;
        b=GN8EHC4+WSD42AFzp0/+8/VjaH3MV+v9J1bXi8mC1x4CLOZU4SFVacDl3gKoraJKh1
         eUnyMz4pX2AxHEExNPKb/Ic6JH70QfReffKj33ukYttCIiXEnEqvwY2ORpWUcxtY0C6m
         GA2Np71LcYdQJb2Ldf2VcfvIbwqPpIUrj2ARQb4F/8YKn2f4OHp1hLGlWjqor/j8jXts
         WnXrq0Jl7/ZeybVJA4+qVsd1tZcXJ90khY8zvU0aTi/1Elv0Q3UjgEqv/nreJHibsyc0
         6TpLSBbB3ypw6tjL7nO54BzcakOgF+FxSEkfDleoAN2B2tPKs2hBRp/pbSS6tzQgBHZ1
         f0Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVU930i1GSYTfJQ65YswjaP0L4DN+En18xuJSQjRB4iFQ8XG/x95xYOQ6hZL2YLo9x8XrO0VrkDEtgfNhYECtNJ+ZivVLkQtInhtYBT
X-Gm-Message-State: AOJu0Yxui2NGXjNsR87CQYjiwgTLOk/Mxt8C+3hMiSA9Qv26tBAbWm/M
	FSp+oZfj6oy7jBPhn+uEv/25kJBSEsPItV3xqKuqHJscqnfpSdr6vIqEQKtyx7wSWzjTHm25NYP
	/YFMYDKCWqT8d9XA/LFVAzBJ5qz7CybaOLmEFcCGKFOwmi95WTrgQ0eE=
X-Google-Smtp-Source: AGHT+IGa21QCk3sWiFYZGFqpbaNRCFKMKPO28VWuuTQBFB+DP7EdYgN29hplV7/2tnE6LjIpupawkAU815VnCoXIErk4yk20HYat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:a58a:b0:488:59cc:eb41 with SMTP id
 kd10-20020a056638a58a00b0048859cceb41mr184770jab.3.1715087643594; Tue, 07 May
 2024 06:14:03 -0700 (PDT)
Date: Tue, 07 May 2024 06:14:03 -0700
In-Reply-To: <20240507123456.2204-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c162cd0617dcf580@google.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in sock_write_iter (3)
From: syzbot <syzbot+2b5fbaaa4280010beda7@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2b5fbaaa4280010beda7@syzkaller.appspotmail.com

Tested on:

commit:         7367539a Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10c8bfdf180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3714fc09f933e505
dashboard link: https://syzkaller.appspot.com/bug?extid=2b5fbaaa4280010beda7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a5c104980000

Note: testing is done by a robot and is best-effort only.

