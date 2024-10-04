Return-Path: <linux-kernel+bounces-349797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CF598FBA9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EE90B22C35
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B656D1870;
	Fri,  4 Oct 2024 00:41:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCBC1862
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 00:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728002466; cv=none; b=PJN33FNCmrzKZsrN9CUSbHYGmL0CxIBDy9IbflZoWvNtP0FckurOlg7mEWWWPCHIzyoLEN7KayZYlhAJRekhg0fQd8Q6M5cD1wnbtYiIT2T9T3ApmdfzDElrfR7HQM2e+WkPvbzsIyTkDtRQD4binsCtzyKLg8CnsX0djJ/gIBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728002466; c=relaxed/simple;
	bh=XTywmJmi9q2rA8dl4WPOEg6+IMBIE3mBSVwmn0/krnA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mWmM67VQbJ7Wwx6GHuqK71HlCgX+Wfv/NhoYOCDvm6P/wIChyX8EhdQ91PULW4qAZ7fvmfyzlsCBHIqFnKFzogoqC/Af9UmXVvsNm9yJheRjdzePU9DeDR0zO/PDarPFiob6/VWbxENi2KQZjEi/4cuyrTz9ME6QNJjGDh2EFFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a2762bfcbbso21053085ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 17:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728002464; x=1728607264;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iM9iNcCamtNgxyZYYPkV53lbIHBJZFp8od8beCxadIc=;
        b=awROiA+Nxbclg7iL7H8lhI9qC6fjKmV7eDlLYogIVD2uwa3joWy/Sc0GvHjXdRsbqQ
         dDuRfC9SSrESo/7CyS+k6qdLPIQM/qhft0yFLlr4wUB5KdQG0Ep3ZfwpNnQ0B3M9z1F6
         dS0srW5dR5crp+fw52DbHjzLu/7iJgPNa9s/YB/9gsyGAREu604yc90q9BO2bNy6VP49
         cEvuT0fGOqNgS/VsY1orf8XMw9xuhMkBZyBJKpJHZFPPVqrkfgpwxtg0BX5BeGuGKMeU
         /0RqM+lO08Yx3R0v4Y43No2Cd55eI07Ckj52C6EFyAsGX3ZKD2IU5YTNLyrxetSQcl6a
         68QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyBavgQcwBBFKayYvozkdMxEJupSvSU4ZVhJobmslWywBDRAW5PPljX4D0jF6dfOLON+NSYUXld5LEiK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKJ8fOYwE1VfTpk5LYvEQfF00aTuM1hquYc5zwLFmBHw90uQZP
	ZsIL049DJtWTPzPAKan1ql8Sc1kKtUQsqpQYSPjRS6UWBF5DDbNZL6ee37pTURoNakpu1SUz7p5
	ffb9cEe1FfN7l8l8pVA7pLSGLrT3YlzpwnyHoU5WfSIVbmQG0H1mMrAY=
X-Google-Smtp-Source: AGHT+IG5Yr8P5cxcO+X/4TssQmbshF/d9tMk6PoeHlyG+jbyzgIHZbJ/3roeRO8zVl/98p3QsRJfY1B/xCF0CY21WOKxlXyWbqNu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c9:b0:3a2:6ce9:19c6 with SMTP id
 e9e14a558f8ab-3a375be2ec4mr8386695ab.25.1728002464048; Thu, 03 Oct 2024
 17:41:04 -0700 (PDT)
Date: Thu, 03 Oct 2024 17:41:04 -0700
In-Reply-To: <20241003233452.2044-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ff39a0.050a0220.49194.03f5.GAE@google.com>
Subject: Re: [syzbot] [can?] WARNING: refcount bug in sk_skb_reason_drop
From: syzbot <syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
Tested-by: syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com

Tested on:

commit:         3840cbe2 sched: psi: fix bogus pressure spikes from ag..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128dd3d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ee84829c35501a2
dashboard link: https://syzkaller.appspot.com/bug?extid=d4e8dc385d9258220c31
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17122b9f980000

Note: testing is done by a robot and is best-effort only.

