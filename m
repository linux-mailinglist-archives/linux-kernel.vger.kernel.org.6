Return-Path: <linux-kernel+bounces-182750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4D28C8F47
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 03:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D200F1C2114A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E5C4C6C;
	Sat, 18 May 2024 01:58:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C98F64D
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 01:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715997485; cv=none; b=RZhFN5GPKKRZ+JcgsL4ctzwv1bmeMnVAIF0D0j30mE3wHxJ3iCi5JwqFuhMs+pwjqrrP0nHgqQ6lgO7YCG9HWqvB+k/xd5PPAzRpzZM85r0+GFXV5hnxzEsVqDEJAU/AKZYSp0a2NZoQBkW4HMuaZhm71YmSgPkuWhTVEWruzPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715997485; c=relaxed/simple;
	bh=myMueikt4kKiCpIfrw74qgCDqNcAHKLgitIvmad3/aI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R6Q/3yroFd3hjqr+Z2zmSP4kg8uCwXJdbaubJQzmPpIItkTZwJDyn0vAcgeyrT5mye+rKbIRM+QvdjUiNug3UUtayEQgJR/Hdnd3e9hblhiy679dFg+nSfCQGXLFx/twJrfLGL9XxhCeJiB13dpd20tJf3a2f102qQn8b8ZqV2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1bbace584so966772539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 18:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715997483; x=1716602283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXqu11nVZnUM5PHpduPEg4/TmxY1GUfGIl6qFL3whSg=;
        b=RJNgrq0JzmDGVDz/EopBeusHxLq3OnAj0Jfyw7185SHaIzX5TtZgYoFMuwhmXrS0eJ
         NHpF6G0fDLL+L14tIsNnS3133sGM7AC3OgoDvqmmyywJOmoQ52mM82gfBV3ysfLuHXpk
         iM3nBjIQwkM2JF1fsFkEZhETpvz1DSqeUdJTULMcfkg0xu5HghGu4k1ExR2LTMy0lRDC
         bpIMbIrE08uhB6o5OsUEtoUHmR+HPzPykqo5tJ0PxqcBENskoQ7pzv5tZQXOEL1FX1Si
         rq0izrs9hRCZ3PNzReVzDUkCu2F7FybjoEpo8EN1AIjnkbBpzctI0U4oxklo4LPGdpGc
         L3mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWId5vcRgIhSlitwynoPig9G1sEP5IAAo2ozlH87PVxKyno4Fq5qoIsSs93YW8g+roL9e+qmp00EdtWvipQAdb67S9A6wuf/i7P14aR
X-Gm-Message-State: AOJu0YywKzT1SarrypEOA1ykFkcNLlmsqmgSROBvb9B6sHJ2MiQ6qNLB
	3Qh3E82xRDQaoqihwhP8gPeXI0/sIkak2p8JdfYQhg/4QrU+OGmJeRwWKYLVDL9c0NuehwEkkHf
	4AGatFR6qwAjI9KdjOKOR6wxqAPP5sMla+OpJBSUz9zNfeg2fu96zehY=
X-Google-Smtp-Source: AGHT+IF7rh/XLw0ulNNx0+u1TOH/gUdBJmwxa51O+WpEtiKcKbgLmuRfaQUVxBNq83QCLC5rne/02fEiy4nJ8TGSc4EBdoVeuTbL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:210d:b0:488:c345:73bf with SMTP id
 8926c6da1cb9f-48958576d7dmr1983998173.1.1715997483637; Fri, 17 May 2024
 18:58:03 -0700 (PDT)
Date: Fri, 17 May 2024 18:58:03 -0700
In-Reply-To: <20240518013341.1649-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072ae2c0618b0cce7@google.com>
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_fid_destroy
From: syzbot <syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com

Tested on:

commit:         ea5f6ad9 Merge tag 'platform-drivers-x86-v6.10-1' of g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16900458980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1cd4092753f97c5
dashboard link: https://syzkaller.appspot.com/bug?extid=d7c7a495a5e466c031b6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=140d6b5c980000

Note: testing is done by a robot and is best-effort only.

