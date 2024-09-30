Return-Path: <linux-kernel+bounces-344311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E3798A821
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AAA4B282CF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BB6190671;
	Mon, 30 Sep 2024 15:08:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A4D71747
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708884; cv=none; b=FnGlmVSlUbHYPxbGpCirW7FqkEAiK8DJ0+UOhqRoa/5eShJ6/WRl30wbLpjzM+A4cXVOBRQ7CQelwAAWX4idJNaHnFaAq25KEVs/bKh71a8bZ5hO1de+wJHj2BprUlXlkzZrsgb3f5d+EH+bOZ1tFpUvx0SqiKpKhWsAy1nxv44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708884; c=relaxed/simple;
	bh=aGK0pnPr6rrlqD1xpbY95Yi1v+5A1hF7AEnI2u4ZTjc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZP8nGFYmb3PBgg8dEGY60l6xP3jVirkKQ8UtSqezi1SdiUrBHKXWuyCMc12uoc0jUrDagxQ4Cqyrgki7UfsYfrPwLaT42CrqaBX4ruBY65Rx3wHCchkQ1ctQVH1L4s3NpQF0J7lm0Fuv5+bmScwiAnnKxvzNZhx+ggkIXiUii9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a343860e72so38697175ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727708882; x=1728313682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9UyhbAXmW4md45P6Yxg6aNQjeuz+AilgpyxM4XPnvo=;
        b=KekDFEpxfj0OFUyEWJGBgyDyrG66w5Hyo/C4M43GBBr+5aQR85bv3EF5EptpoVrM++
         /U7btpWehEF1QZ0MFH1Hh7tziTJhq49qGUI2GiGXL1MSv0n9IBTWXnNf6WAAA+VgKBXY
         D1A5jaewC2sAagPRx3R0R/0k7rwFkIxRSDZxnpmbGGR6DTwWEpn1OyAhSx2rGMNham4v
         5Qn87tH2zRjOO8RcAkTad0bP1z+6T8vxOGZPza/ETlInyIYUR/WhAXlm8I3WfcuJa0Ta
         /sfUYNwXiN89kOg1YPw3FB9sBXX3RhGs08zia8fjQnTT+YBkY3TPuB5/uYqmG4dtQlh8
         +pOA==
X-Forwarded-Encrypted: i=1; AJvYcCXWXKQtZPDt4xNYqW3znIExRvxP05KNEVGmSyUAY2Uvbsi1fD+QU/29uvgXFJ2xJFW7E2Hiby0qBe/uw2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw5UDcfdpFcQ/H9up4L3dnnnbEjTfGgvhFNMA33X4zE/4JSLBE
	ExX5Arq68NUxi3TIryw1EkupEOXuuPErXzqm8gPWo39gfu0aOc8Ac3yELAiJKJDR1cFohk2G/3b
	yapf+UndyegXTSyQa1RxXs1U8Wpo9rTPdshB9GocBbML6u4XG9GeN9HU=
X-Google-Smtp-Source: AGHT+IEIjoX03FOCcejOiJCCtzSKmdRpnzIB9ApW/gPmSPaYdxrb9egSnE03mNcOSfARU7gzDU/NpKPi2y9SnB9M3pQwpe4w8SFg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0d:b0:3a2:7651:9867 with SMTP id
 e9e14a558f8ab-3a34517269bmr107469905ab.13.1727708882362; Mon, 30 Sep 2024
 08:08:02 -0700 (PDT)
Date: Mon, 30 Sep 2024 08:08:02 -0700
In-Reply-To: <20240930111450.649145-1-dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fabed2.050a0220.aab67.0035.GAE@google.com>
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

commit:         d505d359 net: wwan: qcom_bam_dmux: Fix missing pm_runt..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16a1e980580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3d24cafc43e7624
dashboard link: https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=148ccea9980000

Note: testing is done by a robot and is best-effort only.

