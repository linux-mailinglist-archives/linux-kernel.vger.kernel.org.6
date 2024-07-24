Return-Path: <linux-kernel+bounces-261035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D7D93B1F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC20C282EAE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733C6158DB2;
	Wed, 24 Jul 2024 13:51:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E702D030
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829065; cv=none; b=mVLrIPXLMCT8lmJ4kztN5rlbQXRdPTsj1FEV0ptbAfWDe/geWIDaXEe6ZE2r5IPeCwQCNAlwskVHi+nzgfF4/DEZeii6a1vMtBhyXoUHKMDAgn7sNM55VP58sF5yvGClrrEeqNsxdv/rzwGO6YKuqcULGNIMPyiQ2q/v3pgqQPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829065; c=relaxed/simple;
	bh=NMY6ljdp18R6+7jqNVk8m0zx8HRAb8o+n23ussykr1o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W62DP+9pDxGzBGE1wZJzjpcPh2ULIwxmTl7HVl8d5roaNspOhnbieuG1+IsyPTS8lMV/iR1mDEbawGcFCYkqbpfW76k6mqd12EV6E577Nc/1ZarLUzaH5q03Q8LFWBMf+rW5Fa4wxlxbtDNjfo6fdxW8tUyxZzkjM6n8quJ+tTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39915b8e08dso84758685ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 06:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721829063; x=1722433863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cPoSLpi8b6uCkMe6dIrfanig8Y0Nu9y27psqlQTHTs0=;
        b=rO6xwJi/0w6Uf9ttUdocE5r2QQrqnpMGXvC+PQgS9pDlv7FJu9Tl2CZ5GHWlZMUjd3
         axrg4fkgTBwWBjGyMx2Uv/x6yx0E+S3lp109JB6QK8H26Ix9CedKlWDLCPYUb0PJW8Vu
         Y5rsd7kdeIyzYZpUci+hl31vSzVVqZbqUHlOuDm8+WoJ9nKCjxaX/TDEYiF04zXyME7t
         DCA4LMxMK7CgPBZ5CxtGdiagmOdZfO4YlrtnEXtqw9QJNxUeca3xzRWLZYQa7+MlEScy
         EBQNx0pJwpIdTKlie2pQJ/Q36Qt/kBW7QkcIWM1V2Fe4D2ltSgWaZ4hERzTK1mEALxoo
         jFpw==
X-Forwarded-Encrypted: i=1; AJvYcCUKAqEe7+M0Nx+/qOo449EJ8JK1tQ46fJGkGbgg3W8GoKYiEOdiV32Ij56FneLNpsWbXYwbw7ZETfL1UybzMO10SUbfU0SV5uIj6rWQ
X-Gm-Message-State: AOJu0Yx3NgJ2TzhSWa3gBCrReY0AOuq/+Z2z9h0NaviLzrbTk/FHUkcE
	tzNTg4W1RP0zUyauVxK5Z4cR9jdT63wl1MBfAfX1TSfo80F4k3vF3WJHDNptYY39LevOY4snd2h
	8Ef2wD0NbquWwNQH+iHsnnF+Wm9zRQ6i3gCfOEgtqiAFKrSdAJnytdPg=
X-Google-Smtp-Source: AGHT+IFYG7n/nXloA91q0/fpPcrwFfwsLD6/RUQjSqSj9/xSF2kRJdJ1nXR61YzrTjqEicUt9I2mxE/it7SnQdlmDbYMhm2omqIH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d15:b0:398:8121:5de with SMTP id
 e9e14a558f8ab-398e7de7ac0mr11127915ab.4.1721829062902; Wed, 24 Jul 2024
 06:51:02 -0700 (PDT)
Date: Wed, 24 Jul 2024 06:51:02 -0700
In-Reply-To: <20240724134011.10477-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a89a53061dfe91b2@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in __dev_flush
From: syzbot <syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/core/dev.c:5476:17: error: 'bpf_net_context' undeclared (first use in this function)


Tested on:

commit:         786c8248 Merge tag 'perf-tools-fixes-for-v6.11-2024-07..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=be4129de17851dbe
dashboard link: https://syzkaller.appspot.com/bug?extid=44623300f057a28baf1e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ad573d980000


