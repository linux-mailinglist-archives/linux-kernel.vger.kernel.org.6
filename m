Return-Path: <linux-kernel+bounces-344328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7EA98A85B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04981C226F1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E0519258C;
	Mon, 30 Sep 2024 15:22:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080AD1922ED
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709724; cv=none; b=NhYE1jVrvszI9Fy2V3mxJKzOeSrV3+wrH14Z9YDILIR/GfoersYMJPQvmrZKMQcozWrbc5EucpydwyXXVMVa/gPnP0zhUWzCu8Ted041ryookAAQ41re6O6/v1Ahcym/Lla0Yl1p/KyF+fDfAXoGnZaeUlk6hMeT48JhIjb31jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709724; c=relaxed/simple;
	bh=+dEHOTGhikDQKNbJft79iQ66k2rI6UASiJdxSoBSYmk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BkesDByt9bsuccsnvJiGo4ZXYIqPvYJ2QOaPVakckw9KX6J9nIlzoY06ipM7y6uzf4ajAhH1CrvJRheiRKUuyWGza2OHHGaAvRuI3n8E8l01/kFFA5QBpB18KPV0W8VuTDqhUWAIxkyCyqNrAwIJbc7ozGgE8EkPCElVQLZaBDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0ce3a623eso41795725ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727709722; x=1728314522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJNOHk0jW5vydbjr+ziCKYLVeSFsRDBuRcESVl4A5hQ=;
        b=ge6qtD169PL5yqNJHCz3TJC1H2rL3Rg9CtG/4VsQpCMBYVpiPXZvPtxEnKu0V+4T10
         SCiCh7j+OX50F7ugU6HljmNHejmmEKyvFrgtxQoa2hXlcGm975XhMn/xGmCg4URgWXBk
         Y3Q6lVvsrG0SWBSm8qBFBXcZMtnPDPjGPmqi6bCz6rC8Gf4Mobs3elyN17SjmlezWeDz
         IN96Nn9iI0TpU4U3mnlJ1CA0ViBJiNc6tcn02AWOrcKFXE9YL4AtF6n8SKI2rEwNviPo
         t4PDxQI4bgMHJJmxjoLAZWOwoJKVE75UJdaFeh6nyG8uTrFh5prZfao1BVRIunXBlWij
         8xPg==
X-Forwarded-Encrypted: i=1; AJvYcCUXQLWtWXi78O9AbBIIW2umuzmRKTh5Rf2ZRZmlFFZSM/5ZwJ50DZ8b3YhEIThrkMka7uZjLVn4L3X88wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRyUKUd42RIlOgibEucEuNUpwLXjLsJzZDBXnsJb5Y/m10iE5F
	XM0JFcbjuNV8bf/GhY1eK7Qi4/blhTSefey/8LiqK8g7mY7o5Li7wRCigCw/GpoWOTvuT0yKew8
	0jzK2v2evJBpB+WUgMqQgGClTV75CvtKzBEzQLeuHLhNkFi1O6BY5vzE=
X-Google-Smtp-Source: AGHT+IFn+8dtpXbvvbK9w/IOfN+ctEWBKXn/fd97WVfdPI8PsahRtW9x2wBJaLFeR1iR7i/fplHROYFtjDPnUVcjnr1rgxycr8AJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190a:b0:3a0:9829:100b with SMTP id
 e9e14a558f8ab-3a3451be445mr94233885ab.21.1727709722056; Mon, 30 Sep 2024
 08:22:02 -0700 (PDT)
Date: Mon, 30 Sep 2024 08:22:02 -0700
In-Reply-To: <20240930114812.653517-1-dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fac21a.050a0220.aab67.0036.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in advance_sched
From: syzbot <syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com
Tested-by: syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com

Tested on:

commit:         75078ba2 Merge branch 'for-next/timers' into for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=15dd039f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d87d55001548536
dashboard link: https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1532039f980000

Note: testing is done by a robot and is best-effort only.

