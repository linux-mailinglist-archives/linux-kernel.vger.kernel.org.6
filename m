Return-Path: <linux-kernel+bounces-243323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2C1929499
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 17:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20FF1C2132B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 15:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B73133439;
	Sat,  6 Jul 2024 15:37:39 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1F44A32
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720280259; cv=none; b=ZT7oOGoh6VY3n401dr9sMxdp613ImlkFE3xk8x6LoG2q6h3N29hAS0SK6tIH9zXFprbEyU7Qi6sf52+BNZlLL/JnAN12wEIwOLm2BZ01RI2v8QUVRT5TWUH4x/xui72OhpZHrg9lqZQ9U/BfVToOs7zgNPl0BuVmPoqtZw7YRdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720280259; c=relaxed/simple;
	bh=ygkX3FavOK0XkyzNnYVUHnyHU0xvG6SG+nWJxa3irQo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=C1Y1XtVzyXEvy+IY7bGf9/l5GLMbjib+eWYV7gyO+lAKP+unswNTq1ktGqj0REK2w36Pxh6SEKXkQXKHFO/se2XvSWZpGlH2lqQRSN6O0UuZfY60E7jioib0VQ2/zy85fKJ+SDf9+wDiY/oKAMLXp2+L5DvaC1Jdz5jThPwyBPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-381dd2a677bso31803075ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 08:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720280257; x=1720885057;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ygkX3FavOK0XkyzNnYVUHnyHU0xvG6SG+nWJxa3irQo=;
        b=Pe2rYXokhmURzdGm6xWP+zDDdeO/Z17uP+MJpf8320kSrtIUO6Mn1p3eO88ZWAo4Y3
         nu4M4Z4w11x6gSoJE7p4JSVr242PfB1hp3rV4yJBRVssSHSeQTLTQTA9MqJas2rHOifj
         J4SEXGqFisqqKq2jv5AYSRHZvP97FsIQUlkQoRGA+aektrsiq6/CRnoauEgOxEgte6nk
         eq2WgzXe+UxqjVTbHBMAbWjpSpW+WHqirEHPdROIkS4f+nZuBVPfDy09yHHmM5l4qShU
         ACNT708Z3RkNHJwXFlgEOnqlihGMRz1kom4KIPSl5vVwU7pHr/U+JB/wDJ6KGA23O4rG
         j6Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVXDdtAtBVJXPaPQHSxo3foNB4z0AO9MYNO7hlNPMx742RyTsnPWU94msSXRrLbBU/ksOFEPX6OGKT7aAAPZtOS2MlegoXm5CaSzSoW
X-Gm-Message-State: AOJu0YzbbaE8ax+s9hcwtN0Im8moAE8zscV3FErj8oZEWAFfSVQFaFl/
	qZ5rZxTnFdQvgxasQLfFmbVjrMF3DwJ4wWHkRCMKAHz0qzpHn8d/bYb03kyYlBa6u2/PyWzV0Bn
	2sMdhlYybAgIk2Y/X7JWz5dvc4N4UHpqVddoC6fZY2gLuxI4D19+UQd0=
X-Google-Smtp-Source: AGHT+IFR7zJGKSSePPVhM4ecmxUYF6muuq3IEt/AZlHd3+J0PtSHrgsB8ZbpNuhFxsXubaUFAWWe/7YRiRwduRmVJ3H4A8yNhMWC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d86:b0:381:24e:7a8c with SMTP id
 e9e14a558f8ab-38398331b46mr3127325ab.1.1720280257460; Sat, 06 Jul 2024
 08:37:37 -0700 (PDT)
Date: Sat, 06 Jul 2024 08:37:37 -0700
In-Reply-To: <20240706153734.yETtZzPN@linutronix.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a91141061c95f5a4@google.com>
Subject: Re: [syzbot] [net?] [bpf?] general protection fault in xdp_do_generic_redirect
From: syzbot <syzbot+380f7022f450dd776e64@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de
Cc: bigeasy@linutronix.de, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz fix: tun: Assign missing bpf_net_context.
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
>
> Sebastian

Command #2:
This crash does not have a reproducer. I cannot test it.


