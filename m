Return-Path: <linux-kernel+bounces-310217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F66596766F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 14:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E5E9B217B6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4609616EB79;
	Sun,  1 Sep 2024 12:33:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDB121350
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725193983; cv=none; b=szjIWKpDGWfbuZHYK1JH/aNIld/V4A8veOkpltuCLkxCiKPoEPt3xG9zWe4x5k3QwylK8m1UVcsGlrz6A2qH02htnJdl0jj0s9sAUt5EsvngmPPdw/DZ1qKtv7geYhmfHrAWGvlYLn6iQZx+65+MN/iDUNFOr/xmFfcM5jf/uRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725193983; c=relaxed/simple;
	bh=ixkdGeEngVm5xr7HmZ0WTKZoXch6b7Xq6g5VTEOFTro=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k3br5BvU4n/fzfZ/RPFfVU654XgnaQI65ZPUxMleGsfDE0Fh9gCZsMRutSy6EPYX3NNEqddQuLJ9VkJu/vL8BWNFpOJJ4fHWk5LwLoFzdDe/010nvNgXIiDHDMuBhQ7Y640qh33cWlH7r67TqnmAEydFTRvpTWViPrSWHfidKcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d2044b532so35990705ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 05:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725193981; x=1725798781;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dsf76XOi18sDlzWPnp/w2OUoT/b0L7CVzSVkCPBeCho=;
        b=uytkpzjkUxoXcdcd9nMFP7tfkdTyQgjne2yVANiMTNPzLh4yVABG1LV79J0Da6AB7D
         /pYFqyZbcYE3u4WtUA/d1uXQGbI2qwNXdpthogxxbBOesTmN4/tCe1N3Kcan3eVvBY3e
         mWBiFrDwPFcYPzTNMhSYsE5VkJ9qR+QUbzwqZa9WeSVouWfRTtzttFnvmx4s/tI/YkLR
         J09sj3tk/0P5tJTLXerA1sCFpjYI1l4P4XgZsqMG/9sUssJis7spwhQ0PAUlDUB9g0uf
         lC25E02hl3KDBjTSzI+YYvTXetOokJuFeikSL+JPoCYNKEiqYFxVWm3Fc+wwkwV7MYvi
         vkQA==
X-Forwarded-Encrypted: i=1; AJvYcCVHe5fp2GCr/MKKkbDixoxCUCPUNShm9E/RbLaHPwLDQEJWl9oBpckZ1kyaZVo1TdF+qjPNlETbA+wIGT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcH9nHGRz9njOQ4IS74zyU5XbQE1hVy+LwHj/z4/is6DnmP78r
	EoOW5/JJwxGnW6+p8NZeCNtGk23tgPKp0a1iJLwMgBBFNIoa/Uod9KxsYSUWIVsVnTsa8QZIvYF
	gNNrj4mXevssvyWdU3lQ9sw5vYgMd/MwlcS3rV2P3ZohbbBBDbAYYWIg=
X-Google-Smtp-Source: AGHT+IEkUyHneMcYWtZzqmRBF4oOvFFey4Nb1xV6ud+JAu/hfT2YQC0yLLN/Vj9297WU9mhWgOT9JyB50ZikRo+S7gzL/OnPBA5x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a3:b0:4b9:ad96:2adc with SMTP id
 8926c6da1cb9f-4d017e9afc4mr408834173.4.1725193981595; Sun, 01 Sep 2024
 05:33:01 -0700 (PDT)
Date: Sun, 01 Sep 2024 05:33:01 -0700
In-Reply-To: <20240901111346.1560-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071231f06210e069b@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_recv_frame
From: syzbot <syzbot+5c915dc5dd417b83b348@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5c915dc5dd417b83b348@syzkaller.appspotmail.com
Tested-by: syzbot+5c915dc5dd417b83b348@syzkaller.appspotmail.com

Tested on:

commit:         e8784b0a Merge tag 'usb-6.11-rc6' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15b1272b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3e19fd08b312452
dashboard link: https://syzkaller.appspot.com/bug?extid=5c915dc5dd417b83b348
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15dc43db980000

Note: testing is done by a robot and is best-effort only.

