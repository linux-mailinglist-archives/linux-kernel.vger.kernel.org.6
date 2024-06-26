Return-Path: <linux-kernel+bounces-230261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A55D0917A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0955E285DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1304E15F3EA;
	Wed, 26 Jun 2024 08:10:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9FD13AA3C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719389405; cv=none; b=eOLa4sOhaDdDZF216nSBEP5LFq30t9xd2Z+dyf18D+YnFHZtwaDOg10hsRyDvN4yvs2SBXCskp8Hfvm64O0sC96CgJxdZKXuAK54v5uis6T+TwBhgKMaXhuduSmSg2J+VvDwj7wBNw+/1OhHj4EW7IElCcIAi//4EkDFC8X9qeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719389405; c=relaxed/simple;
	bh=OltwFc/x15/iZLd0YPcbFvGCljpBTFvkv1Q9f3PemFY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QrEXg2Nfh7itwEggsWXtzJ54GomIZN+yErmKfnBUk3WSqdn4t5ReP0Et/gPGX0u1qCYDdyHjzxlmH77zA0PL+lNK9S+JUwgxFUrc65wgB7KMrNt0t+IGjE6DNiXOim7ohmRgsFd4G8NVnF2212HcXc5oJbgEIyEBDWsOFJed9e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eee7741583so918678639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719389403; x=1719994203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQTkJrmhIUVLsdm9nRsFX4x+gNMbnkIJAoN7clXZIC0=;
        b=MQP/03Vb8til3ogc4vlnJvgwWlMDJAP2LWO59iw/RVMAHL2XoBce3hT0f+mXYRQ/Nw
         tPLQcASr8ik2UNTErv6yEhH4Zg7JMwzy/bChJkBAF7XSnLKi1MtMwWPSA/tFksUWDP1e
         M5vm0Q7tPFaHkIIzRjezbGx/FwyJpPLLgN7k64zCKVNMpMTk2aAi1kPuuSQzeaqtnNoC
         Prmmu5D510cPOZbkwVAvhr+IqpWpnIJ2mdD+H5cpsROGmZRjo9MfIaBCEyVDtey5a8T7
         XdLbRPoIRLBGuEY3uPG8YM+HKENjzbMGAGkRkE6+nkirXIgkp6JsRiYcFhfx91nefLtu
         gN7w==
X-Gm-Message-State: AOJu0YwUxD5efyypWeslvMdWgKUMi1Jgm7AVpOVN3ehCufU1kP6FWXTP
	epGHF4VHNYKPrdcT1J8wETcQjsdsJKpxrVasyKkq/ch0dWS/eU4vS78Wl76ixhghuzI8BzfXw8M
	081FobAleBy8HBTI4NaRp60rsfHe8HhULnuw4bdSfdU/pPT8d/a+9KjU=
X-Google-Smtp-Source: AGHT+IHOLPKvZgk6NWggpMCqli6tY3jJ3KdHfxIIM8AqmyNcXLfL7K1gS5LgBfc9D0vC5film1MqU9VmqEFe8p3TWB49QqqYzo2f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8906:b0:4b9:2bc3:46ba with SMTP id
 8926c6da1cb9f-4b9efc00420mr411190173.3.1719389403336; Wed, 26 Jun 2024
 01:10:03 -0700 (PDT)
Date: Wed, 26 Jun 2024 01:10:03 -0700
In-Reply-To: <20240626080337.32736-1-norbert.kaminski@infogain.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009de4dc061bc68ac3@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in
 __ext4_check_dir_entry (2)
From: syzbot <syzbot+11af34d3c0711f233fd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, norbert.kaminski@infogain.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

scripts/extract-cert.c:46:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
scripts/extract-cert.c:59:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
scripts/sign-file.c:89:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
scripts/sign-file.c:102:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
orc_dump.c:106:9: error: 'elf_getshnum' is deprecated [-Werror=deprecated-declarations]
orc_dump.c:111:9: error: 'elf_getshstrndx' is deprecated [-Werror=deprecated-declarations]
elf.c:135:9: error: 'elf_getshnum' is deprecated [-Werror=deprecated-declarations]
elf.c:140:9: error: 'elf_getshstrndx' is deprecated [-Werror=deprecated-declarations]
subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]


Tested on:

commit:         e40ff213 ext4: force revalidation of directory pointer..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=11af34d3c0711f233fd4
compiler:       Debian clang version 15.0.6

Note: no patches were applied.

