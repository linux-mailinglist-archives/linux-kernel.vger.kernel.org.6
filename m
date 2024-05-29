Return-Path: <linux-kernel+bounces-193274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F008D29AB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 02:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7601C225C9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12E115A841;
	Wed, 29 May 2024 00:53:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74BA1E4A1
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 00:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716943985; cv=none; b=AFOdXM1bF92d22XGqcbryPZHh3aJkWAygm4eUl78tGUoCkHr3dfA7+nzGOtfJX+k8Cg77JWyLGYCSf6iQP8Nyypf9jUwp+9OCD77HrTW06dINpAuQK+ndE1g+sr7PirP7aXdcSdcJm//Vkk6VN1a+TRU8pixQC6Nc/XV8ZBh6/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716943985; c=relaxed/simple;
	bh=QfNNoDpQ1b2yEAFCXnWz/DcuXgbBA3uWR+9V9L0+SsE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kvXGVnJdBS81osv7Nr01lOsqBPR16WvZBCK9H6RH++h+lx6AcbUiC9a0Lxj+642ktH3zzDfHPaQAUzJ8F7T0pcWRhWWXwlEI7AU2fhGjCAfev8r38GOJzrl6/6MeKhudst5MNCyDumRuB8bHt2LGZ56U/7m3/CmiFZ2eTQvwdFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e1fe2ba2e1so179923239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 17:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716943983; x=1717548783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLtGFd7Q4MbjCB6PgsFocCocPjmstbn93ZjipRuyOZw=;
        b=E769vTKvvHezgx4QVQgR5VnLC1NpUDt3yO9qIdF3N9CB4qlPRQDJNnQCVEWNgYCWp0
         8rXTh+9tCzZp4aJ09xKrlFwB91JDjlOq/UjBe9Ex6WWbotubo4C85m9RzZCBu2QCumqe
         /cvUZ38KoBlugTt/KqntDzfFLctsiiuwFZn1ucwXfvS2FPkwKrHkD3yOa6vHgbsPiu33
         YeXSh38k/Ljkjyid8z0RfhDPots4K2AMnYcxgqnACXXtQeygxNKlZCa5UpoZVjsQdRwm
         /p/bD0fttRP45CRcmphvcdUhtHYPD143IqtlcKo0qR5Ziw6wD4HGbw5PRJ1YAx8C7nui
         RB0A==
X-Forwarded-Encrypted: i=1; AJvYcCXRtDBMfDtiItYk4zQ61xL+iiZ1+5JIKlESsHfwmzSchfmo8/Ep7j7iI9MeUMaq9kJG4xUO5drNQPRDLsr7u/xMHrJjxVCitfNy9Uag
X-Gm-Message-State: AOJu0Yz0CyArTiOI/LMn/godeoBYv+AX9HrX03E4IXvuyebahF0M8m/W
	W+Tlxa4A4G+KsGdULHjXtVcIxP76XNL3lpuUhZhrlgcb7vVqRFT11+/LmAMzfkX+Fh03ceYT+/i
	B2xYefRLdpKtG060UtA84eO6J6LVDadRTpSD01cNu8QOFxN/FIUR/w8k=
X-Google-Smtp-Source: AGHT+IFACHATZcN5gcaNqm4HIF/euFsbR+qx5A1S8ViUShNCc3LnDNd0GWwC+O3PmWoRom5pRxfrS+0afEmSuLEvTNOeAIr2bWHu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c07:b0:36c:11a0:7878 with SMTP id
 e9e14a558f8ab-3737b2c2bb8mr10363945ab.2.1716943982969; Tue, 28 May 2024
 17:53:02 -0700 (PDT)
Date: Tue, 28 May 2024 17:53:02 -0700
In-Reply-To: <tencent_A00DB025D08D8E12005DA45DED1965CF9C07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034566006198d2cc2@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_xattr_inode_lookup_create
From: syzbot <syzbot+fe42a669c87e4a980051@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+fe42a669c87e4a980051@syzkaller.appspotmail.com

Tested on:

commit:         8f6a15f0 Merge tag 'cocci-for-6.10' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16382592980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6be91306a8917025
dashboard link: https://syzkaller.appspot.com/bug?extid=fe42a669c87e4a980051
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10aa5864980000

Note: testing is done by a robot and is best-effort only.

