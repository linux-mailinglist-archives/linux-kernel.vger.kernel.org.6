Return-Path: <linux-kernel+bounces-187222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F898CCEC0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8167C28221E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A151413D264;
	Thu, 23 May 2024 09:06:21 +0000 (UTC)
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72D613D240
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455181; cv=none; b=N85HZAbMjv5+Oa0yfLa/uYxxc18z8P1rOyiN1l/4twQ9jtASYlwZOmHLnOakOGX1Kxh2wsL6frYRPc0cSLI3sYQ88yy1QagRCElB32GJaIqTUcjTp8tQs6c0RMQXGyw+tiPuHV+dgfJqI4VHGw42UrKgtB7CvDXFicp4xY7zX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455181; c=relaxed/simple;
	bh=OdtdJzYAd+u/w7dWIA7qTe3r8kOCrHwkEaugXhg4x3M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RFzY1xTF+Vkf2IcaAdcZ109h22SfVmyKcN5wUzJ0Acw//jk95/Yhexm1NsCUl6PgGEmkyvT3tK//8TYvrrAkj1yBGShMyL5XYX8sp3+AWqyWax3iCv9z6KquDgi/e8/P3LfFS9tKD9SdR3i1LWoInYuqMW8Cws1D4sHWdDkVqDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.221.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4df94adb21fso8171928e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716455179; x=1717059979;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vt9OxSenwNMjUZTwsENcm967tzGPQ6ORh01FGIrbvJY=;
        b=VdbXlNk6fxAQj+Zw1/uwjCVJYERpTwafTOT3xxsapbgmkqYX3ybrxv8FpdqenuIRrQ
         SEaPjsQMZXxTQHwnR+ebf0WxkvtoTCgTdVZc0qfjk31Tg+KEAv2hdshTa5wyeZo6SdLB
         T4/3945PIOIPTrxEJPv+92RCGE9f5TtvKF2e0gmSREpTXasNKcwU7Ylavs4eDdv/i8hM
         ZmcofAYrMOeU3YfTlmh/wULIMsEpWpWLlgpOPwWt2DDjRiXniBfJEQ5MRQk4asMfifd5
         AYJ7iDVFZ2FYYzIzQtF4ajpwDGmAxAfN4mdlZjTXGQmwiYqe1VhIhqeqlkv/WP5PrWpk
         yntQ==
X-Gm-Message-State: AOJu0YxjfVQ27fubwOJfm3aCvt/nhlf++UdqPf/h3a+psjZHpy1jCuzy
	P6DwQju0/V/vUYUXrU3Aa1hyLA0nm34bm8uXjrehfNnMVk4rU2PIYPBiszh1FIkhVL8bMB1FaiT
	r8SUrjxUceAhy/LiiRrlsSX876hSJqqdhac4k8nNxfkPAjHgwI3M5eCc=
X-Google-Smtp-Source: AGHT+IG3ZeB4Al3FXr3rW+0fVUTT0GZl85iR0ZJk1ujBdS7m/Pr2Tn0LebZXAr+dGO3sNXsjnGA2xmVE9HXNldwDvrLZUux9keD4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20eb:b0:36d:e026:88f9 with SMTP id
 e9e14a558f8ab-371fa9746d9mr3751495ab.4.1716454683388; Thu, 23 May 2024
 01:58:03 -0700 (PDT)
Date: Thu, 23 May 2024 01:58:03 -0700
In-Reply-To: <20240523083332.761304-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad3d1306191b3fd3@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com

Tested on:

commit:         33e02dc6 Merge tag 'sound-6.10-rc1' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12096df0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25544a2faf4bae65
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10f9903c980000

Note: testing is done by a robot and is best-effort only.

