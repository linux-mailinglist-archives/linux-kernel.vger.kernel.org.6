Return-Path: <linux-kernel+bounces-256470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5238934F00
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013191C21E35
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3568913E021;
	Thu, 18 Jul 2024 14:18:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584692AEE3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721312284; cv=none; b=E2icyTsZOqbMLyMOi+WJNp91NV8AeBm/PFiEYsLUhOuOKaXDAf0FJeZJLr5J/x/fzk4AcyXeqY6OmsPwxHVus6+Sdzy0BuXIsaLwKJf0Owx/D8tpr6l4ZvDE6tHRuZFnTq6cxoFrcMbwDMGtFml8EcIPbf1HCmxCNeJ5hYkjv0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721312284; c=relaxed/simple;
	bh=8uSh4nbszjk1vi8Jomyl020PZUDhzOmFnMABAmRBs3s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PlYrM4ERWEeTh2hb00R7MlhJY+vpIa1a43qqFAi7FV1+DtdZSVzE5JAGTdQ3vNJ7UHxU0KVY91/twEd00g8HW7RbHJsnpCtFymp5P1aAK6rFuszwwwTXa9fH4K3YK7CIoU8sH2gPYOaXyPMx8mSfQI5JC5Sr1m2Ml8PQKQe4oMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-800e520a01dso135404939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721312282; x=1721917082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5ak2g7K4GZezFXrsLLIUk5Z1/yciMp7JX46vxt4qgM=;
        b=eFNwP7wNCZYE3edo3/63pkl/lDHsDxdxPN5dnYLtNWYomb6kM6yFTTsL/9W8WJ6GY/
         4fxYtPIX6bwFrSl/WOMXBtJgH1dYbuqB50XxiXA99F//PEm6qZ2uu1Rh+oDx8E40W/Dw
         LOvRWvgrdKTzWmbe7iHqhfEr8G7Xx0sv0ZLoRzBzdgzDOUi+aQ+SRqHZTSd3K/HFB3Xv
         2gb0t8C3bpuPX8ZqREShU5PThYRu8qXdr50L1BeJ7hI4JTr6559s0Y7Qjzt5ujDA1XAH
         zlJX5ZxL/CdKywM2SyD2WX3kjurcxVjkXzRDJWzPZRv0dF+B7uYrc8arFwp8sZv3wyEx
         1mPA==
X-Forwarded-Encrypted: i=1; AJvYcCW2EdcyAdbbIoH1bWivHxkfcD4g2qq2TfYPBU7hz6lqaaiZID2kG/p2OxQkIjjZqy1UFKEO7qmn1OglXSevWQnywbU9wVWACJ9hXkvR
X-Gm-Message-State: AOJu0YyhPJzoShbp8ZZJ0vb28KL9p0hhAUXE3Du0F1eihD2LAbfmq76S
	AvySdGDa4hzCvvCterEGHfx48nLZAO+v/hzxkiBnzfL8zJAki9HwiwQnCa+OawzxQkJEZ9gVFIQ
	vwjsEUPYa2bAj2t/6DU05N2mAh8ICOM3LS3Ow4Tdh8SkzrH79al24KHg=
X-Google-Smtp-Source: AGHT+IFYNx6QrghjgJciGNc6qXbezM6leaYOefRTUk6OGlct8iN83pn0xrdJIYpWkLA3abI90Da9SofKA7r2vRAsqxoFXpj5Y0qn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3706:b0:4b9:6637:4913 with SMTP id
 8926c6da1cb9f-4c215add2edmr253935173.3.1721312282500; Thu, 18 Jul 2024
 07:18:02 -0700 (PDT)
Date: Thu, 18 Jul 2024 07:18:02 -0700
In-Reply-To: <20240718103953.1323-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000256e74061d863f41@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in lockref_get
From: syzbot <syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com
Tested-by: syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com

Tested on:

commit:         58f9416d Merge branch 'ice-support-to-dump-phy-config-..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12d9e159980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db697e01efa9d1d7
dashboard link: https://syzkaller.appspot.com/bug?extid=d5dc2801166df6d34774
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=111a7b2d980000

Note: testing is done by a robot and is best-effort only.

