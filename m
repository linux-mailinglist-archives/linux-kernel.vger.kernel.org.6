Return-Path: <linux-kernel+bounces-271245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3EB944B91
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB701C2552B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502C21A0702;
	Thu,  1 Aug 2024 12:42:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E57919FA96
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722516125; cv=none; b=Y2EnGtuXGtcXoCUzFbqWXTC4rUyEMhPkUPAhOyyEcciHJKhAH705xt8bpeBYDA7Ss234fZIJPQmn6LW/Uv2Mc5lsRFLXjS0AVd+nyat6Lhrnw10m8o07jEuQgbgc5KJFYf2CLmyzI+tX6c3K4Py8KQg46I4AYw1uEouSQjoc0lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722516125; c=relaxed/simple;
	bh=EWTxw9Ww9BbIyR3X/GeDhobdYUG5WCBPi0ChEFTtJns=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nFv4KqURmVmtXSNqAChJ5V/V/qMU6TdfSNYvtLmHaIdonHXdXK1YnOLk3G/iloMZ12ExYj/5RdECWi2FsoHMxfui6bOMOkT8K9bYNRpN+V26fyjckLcHR2vXQ85BUnNPzbKZYRYH4j96xtfThKcnmH8jWYYntb5ICGmb2o86gAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81fc0896188so342953239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 05:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722516123; x=1723120923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5X+pLFpq/vuBTbwifUGvHlkCxHru4nkpS+hjibV6fc=;
        b=GoP5K1lY6Rs9TdTKrw5FSdzoU16DlYoiXGqev/wBPPHnMd26et4eJCY6g12pFc2ycR
         goer3nDly2eLVp9lANKS/dDmXFWBZUrYhCtzFi6Zcqf9429d5BwXEj9yD4DgxYG1OogL
         3FgrzfazXh3dfBRFJ1Xodb6wBOlAktr60Kv36tS06zMvCJ0lfCInh8IfbJHYnxlV3pkQ
         vBH6+FXiYmRHd+xrQ/uh4CtbQjHOMyjKmYQbgRX+UAwtB5myWt23+cMCOIqMcBq4wsP1
         rIbb3LIi6dLw68zrdTQfYoehXN0Zf57v37+korNuFKJI2WpcEI5iTwdEBc8W3NjHUJM4
         opqg==
X-Gm-Message-State: AOJu0YzPwmurrYDuak7Pmcy86kPfKz3qKE561LnMBjaEfC0b58P9zH9r
	ftzsomD6PMpQK2BoMSCtsPoxPjUZitewJokp78cxQwcuBn2kYZMAPkOzv6Meyzwjqh09BsbDR7/
	vquCCiFrBsBri6weCr1kNAcsP8Ei8Toiq3KeLoBOPACLBTINsu53zbT8=
X-Google-Smtp-Source: AGHT+IFKv5USCSrU2fOPFh+LD6Yn1tHDV6Axmw7Ug2qN0lznhuwd5v8yD7m4ANcCuNdVWqemcZBGu3hed2zhwr0kXAGED1ggH1WH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2115:b0:4c2:8a0c:3815 with SMTP id
 8926c6da1cb9f-4c8c9b3a13amr96673173.2.1722516123593; Thu, 01 Aug 2024
 05:42:03 -0700 (PDT)
Date: Thu, 01 Aug 2024 05:42:03 -0700
In-Reply-To: <20240801120853.2962357-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aabe1e061e9e89a5@google.com>
Subject: Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

.......+mm/filemap.c:3757:88: error: use of undeclared identifier 'filter'; did you mean 'filler'?


Tested on:

commit:         2f8c4f50 Merge tag 'auxdisplay-for-v6.11-tag1' of git:..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea3a063e5f96c3d6
dashboard link: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1031cef9980000


