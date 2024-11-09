Return-Path: <linux-kernel+bounces-402615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3BB9C29B1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 04:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A4B1B22332
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 03:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2363C463;
	Sat,  9 Nov 2024 03:22:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452E815D1
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731122525; cv=none; b=gX8QwFHRiG8Ccutkug5/6apQuc/elY3sJd1IpO3Hb502teCNTdFXbPxs+6z3dUj0xm2qqozXQG88Zt7Bn/OsGEphEgQvFsNeHstEa4udi8bpw5vMrAV5uVazYc4id/MGsEK1FiK+2Z/twlJ9q0pO5DOX4zqnQXdu99VBnyzC/rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731122525; c=relaxed/simple;
	bh=d2+p0NXseDTeHjU0iL7kM321bPlJGbzkfJHWvWv8Gs8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=otpaAdDF1lPCyx5QDQxjWcQdFfu4SySKVnoEfMCFl5KvWqe9jbGFWi3tT5lg+Hr3AFJWlooXXbRKweSCzvhpEeoEO/chq0m9oWRWSG8Ksy+yJQISYJ7sSwsMgbhVitQ24DYZ3A6VTtUNbFkpR22FLbMa/Qoi16ehciogs0OolZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ab3d46472so305221939f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 19:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731122523; x=1731727323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9EGL5LU50m/RXbfJ+isJcGfJZe0VqOQ0duf39ERFJv4=;
        b=hAOKUwMtFZxhyd68UZiPWKnjQwdVQsZwcJcGT/8WCQiaEP35FtaUDrm4eWLN0qSFBO
         jp6f08qbfCxfDvMuRDTP9KZJgBZdbbvF4luLCqc5UTcIlTmbZF3q8gvovq+0TJX4hGSr
         sz7dLOTeqAMB4eesQp6efqqgHCBjLxwj2KMn2QiEDh5Gl381alBCgvMYF2rUVFCj9646
         8SCmwOXvHjrtZkm0E2TnpxyRubWFUIZ1nttLtpOYBM7Aw/FQTcQ6YU8jpaqTwltdahVx
         9Km+NmkYIkFG9f9ChWRaor1570LNW01KBtAnDkupEDzwfoV3khg9ESQxWpAyRsEmQZWe
         nxvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX37K8/tJ61mSLW1Oe5PF0nXhTfi4ubWPBMIsvl5CDyGSuDL/XcPkH0b7rk5c7tjvDtMlq/XRcYKWHiX1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf/XeOoKIVnrGgHJjVGhmbMH0V2IOg0HPysTJfrg5vOgQcbU9c
	kwa6kud651yRaq4IxXqbOWchDNVhqhMNH+PhBr3Og4sa42ppT3HSq3jiAKwTHz2+VvZ8AByy5ra
	tMQUhrbl38ISH+Bsxyy29Kigo9f/7xeq7OAeHtwHZgmgjomgLp59+qY4=
X-Google-Smtp-Source: AGHT+IG14Vqoag0Clw1Z1m0xZk7z37f/Z/OwoE0bjjuhvcdpt9P3pLgSiEajxySVo6ktqdu9xtDaLFEGYcJDozy2COzrVEjRxJad
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c8:b0:3a6:b3bd:e92d with SMTP id
 e9e14a558f8ab-3a6f19c615bmr65440555ab.12.1731122523291; Fri, 08 Nov 2024
 19:22:03 -0800 (PST)
Date: Fri, 08 Nov 2024 19:22:03 -0800
In-Reply-To: <20241109025121.EE-Gi%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672ed55b.050a0220.320e73.030e.GAE@google.com>
Subject: Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com
Tested-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com

Tested on:

commit:         da4373fb Merge tag 'thermal-6.12-rc7' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16a3a0c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=347f0ef7656eeb41
dashboard link: https://syzkaller.appspot.com/bug?extid=985f827280dc3a6e7e92
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162aaea7980000

Note: testing is done by a robot and is best-effort only.

