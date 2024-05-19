Return-Path: <linux-kernel+bounces-183031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B3B8C9391
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 08:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6143D1C20922
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 06:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD94811185;
	Sun, 19 May 2024 06:17:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311CDB666
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716099425; cv=none; b=JShkp0utEMjGYAdCP6A6eV8l9n7z5steRms9LhYmRjc8V3wAIpMPNO5v/H3oJjLLNy/bipZttkaY17QCaxKQOmLlZ3OK2+qNX9iX5VF6yOcmJkXklMCiXdyiFoIS00RJqNViDLF+mGCFQ50UouLjRTXc+vex+5fXU4jIZc6o3QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716099425; c=relaxed/simple;
	bh=upnj9sIDKBQKvktjW5D5mM1nysA+VId2rm87bwfVzGU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=t/Zt4CIw/NOykdFm43u4fy4KDgej3GGxNZ5itUTpTnQHtLRI5F0ZmUQWEwzXbxQq0zvbt26G38JXNN5CCuWuAs6kJ0WCcjSrnLVM8iS74XbTGOI7HzUC7cCeDd5q3R/5+6yXgW/dbuvf5BUmeXT1Et5vl5r4glhGcKAO7xI14gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d9fde69c43so1129157339f.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 23:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716099423; x=1716704223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGcBIqdreX/QMjvOY7bI8q7tkb6+gIy5H6UWHjLtIsI=;
        b=I1JiZOfavC8rDHgbljhX0T7VhJe3O0mfYMzimtHS+KvRZySglaKzAieAJspVeKQvcN
         WFkjC/Rg8Zoj9ZMCeapycjSzNQORV6QHWC/BhAnXJpUjiex0eGpZcd1JLyo/WAkZUdso
         LbwO0j4sjF6XKFkJoR16J/c9fqqw2ZcnP/wHadUd/EYUIFWoAUMeXIrbwJ+1INkvituj
         GFl/PVS254ulbn2zpKxWj6hlkTavIY8nkbSNmlvjLSyznEtkR0oiYFQVp+tYE/tTnezS
         0txMC9AKBD3ccJTWqUn7m87FcyWZBrernGB6IP65H/zy/IZffnZePELcxVtLnWneeUZX
         KSQA==
X-Gm-Message-State: AOJu0YwUUen0ZBDktzaWMG6ptwA7dRwSghdmzgZzgMn3TdQsmbOZFLG5
	IrCQT2XX1vj93zm/443Y6CCl7FpuHUY1dRawvbvspYHR262sU7VGZMq0+E2rYfeKpenrFP0jddV
	dHSAds/G9RplI41A0ZMCi+AKH1T4lH8mXMBjj7S+1T75Mq3TEKCjRJtE=
X-Google-Smtp-Source: AGHT+IGNQDWrRLJu4X3Is98ST2VfzQH9epEbG4tfc8zG7JqfTUYAllBIVE9c2MPr/v5JhH7TjljkK7uh+7BqAP1dYQuC9/aW0GpK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ac:b0:36d:e026:88f9 with SMTP id
 e9e14a558f8ab-36de0268a74mr31195ab.4.1716099423421; Sat, 18 May 2024 23:17:03
 -0700 (PDT)
Date: Sat, 18 May 2024 23:17:03 -0700
In-Reply-To: <ZkmH5ZWG2Zq7rTGc@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000885ba50618c88815@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/master: failed to run ["git" "fetch" "--force" "675adff2843877c2da27b36b2517f827bc9915ea" "master"]: exit status 128
fatal: couldn't find remote ref master



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d47374ae24e4470
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10cbfd68980000


