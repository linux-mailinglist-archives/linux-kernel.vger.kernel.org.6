Return-Path: <linux-kernel+bounces-324960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4D697532C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491901F272EF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230D2188A05;
	Wed, 11 Sep 2024 13:04:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A5817F500
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059844; cv=none; b=BPXrPkIhJCVtrFJJJMLKEG4kfQhwfxyD0iT54wI2DNeqx/BQmpJ4jZmx4nRTWBXHMKv1/0NFDCoU0DMR3FeMkXO4qA8YKkqZfyW36YeOrJ32Q3yiNtJnQJxgX5AsWLov/8KDPhpg1w6glAehikPo7Njt/u1YI/udktL9cJn9u34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059844; c=relaxed/simple;
	bh=59NNKj2Aff6CvAxFNMeXG3ODKc7xCJb0WTJTjX8MUBc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=csjAasnjXlqXa2Ra0K+xH2ySSod93jOYRrFRG6tnkBNNcmrUJ/Z0ZTqyWn8SKDFN8P92u4tpRyCQE47FnZRNnkvi5wehsJ0e4vflV2e2tA7a5sGMEjOQ2oiIq01inSIgnf0DAAZdS4q7VOYw68XpiS3wwP3A0pUhd4OA7VD8LC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a045d88853so121399405ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726059842; x=1726664642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEWuHmSfY5aL9jwx3TogH+Y+4XLiXEd0WjEMQlUki/Y=;
        b=C6Z40ja2zAo0qWeW5lXuNnwFjwj8rcKVV5fCiNJkauZJAmhXN2vKLITNHyIt7nE2V6
         fv605zI0Sjg/InZEt3uGLsfsKtA//qylWi+l7Ni4TFYcYS8CEMFr9LHDYTZcPbSKYQZY
         LS68YET8qijc7Xmvlu764vHsrcRH4zpvnl9lNxyJz9aup4z5Kfn8FCjLiwC7aQR/2V0i
         9CgSWPHDLa0tUsYwUttoDWnUSDpUG42JQDeE6woGDtvRobUnKqTQLH9pP2s5GIMraIiB
         we1W/kEDm8XkrQHQP+uNwmdeaPF47j5XMyxPgIiRm6Sfy09P0yOD8BuBePUN98i6JXwi
         Cvng==
X-Forwarded-Encrypted: i=1; AJvYcCXu8IiaR9amr2qfb71XBgtA6Xwq9xt7o1udNOynOTMTe5shdfxs/jTF2N89uDiD1DXUBsUFBrlAwCEvwxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpC7WsD5HjklQvFRodD+u+BNH7VSDSiYTTVWPdbZJinU5n2KKU
	wFE5vd8CqpBlZ4zSQuefwxhH45uX5o7bs4Ed4FVsTInIaeij0e6EplMjip8WkBnaXCL6uYnURP6
	VizSgWgxs4EDTOSxYcz0FPTSS+pqN2i+vVWWRSddaP+zCElf3bJC1Nk0=
X-Google-Smtp-Source: AGHT+IE9hU37nbQq/8eq8xqqdwVrvZikDR/LS+COMZcGwPukBSI5AV0Kx2AUklYx0PUsy25r0XFviRE56/GDe4lOycr6742k/wSZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2166:b0:3a0:49da:8f6d with SMTP id
 e9e14a558f8ab-3a0576ae034mr165020635ab.22.1726059842412; Wed, 11 Sep 2024
 06:04:02 -0700 (PDT)
Date: Wed, 11 Sep 2024 06:04:02 -0700
In-Reply-To: <a05c9ba4-d7e3-4c0b-859a-3f55ad6e594e@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4bb0f0621d79f6f@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
From: syzbot <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com
Tested-by: syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com

Tested on:

commit:         7e3e2c7f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16f9a49f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=921accd5d8340211
dashboard link: https://syzkaller.appspot.com/bug?extid=51cf7cc5f9ffc1006ef2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=142d6100580000

Note: testing is done by a robot and is best-effort only.

