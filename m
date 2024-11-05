Return-Path: <linux-kernel+bounces-396266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620AF9BCA6B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938551C22863
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87051D2700;
	Tue,  5 Nov 2024 10:25:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5AE1D1F46
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802307; cv=none; b=kB5BTPGHnwIxS8T4o3z/xMvs4/6XIOBnqYdClMXm6UPhUxDxRWhrMgXeQh01Sg8xQBsia0tfAOgrwSy0kRnPj0tyx8pKl9/TI8PrOl2NZG32HYSCPyvaDQdDxX0p0piVvApfPptynRInUd6H86WGc5QtFhxQB6nlVK+ZqSUs0yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802307; c=relaxed/simple;
	bh=br4qTfis5VwzyQvCidJGTpgCvfTHMV5xea1xHxhG+Wc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q9S58pUQ/fbK7wsVX/6wBGRblxIIbe65Sb9Dn+Ff82dDFTIfpg5yb4iuYoO+LQg3psbUbiKPa+M0JqAE/nmVrUpxY/CmeOhGQSxiOVWXCeKy78ILkTog5MwSrhPgWYS/RqFZdqinqDyjc4vTAt3Kef1X3pSOKmEgRTlxxNnQwPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b506c87cso54587315ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 02:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730802305; x=1731407105;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKXPzEUvtMhcuobeMQREudKabsryi6AjOhfeEMPoeDc=;
        b=EqUk9WeqA/YXzFkXAjXGf0RCqEV8KzAxZhJ9zbAJSdNUdZOYxe3hNW8j5OLHeWhat2
         3elCJuEcP03obFUwoPcXlqL1Q11ibJHjsjuDIPZxDtMvfeH1NKSIRSO2AM716AIpluTe
         L3U/2YBC/j6038VQdoTfCG+qm7U0PtmwrhCa9PNi2lT+brFQKPc+UlYf/Av2XDuOLSfO
         JQeDBYvhVxL08IVNkfjwVEu3iB7iGl00SxjEIGl1DmnawxlZD2h9ZECQdAkX3ui3ZnwT
         mO/zgd0eIpxrIeqG6xU5bx5ergz3LlbiPfvUrxs7TipVqnhysmo2RwM8CybtWLt0onwE
         rLXA==
X-Gm-Message-State: AOJu0Yxg/q7TbT1tp/KGDlggFuzLXbK6HElhxndb3LPu3w5Caab5bxHR
	42jsuRMM4g8pnbIJcCAGYq9iivWceKKI9a1F6aCpgjNXkCLBsuWgkH8jU57fk3O2R8GULZw/+BJ
	mTOMUK/92rZzfrJTgveNiNE+MnrCsQ88GgHjQ6TUUcfMrl9gSdJyuCVo=
X-Google-Smtp-Source: AGHT+IF7r9lm8y5ib07YsOUfJ3rhuUDKAxjFVvakDbEZH0UwbJZUoumO6Yu/kNE3ej2II26GI8vbpYLz1Y5BdBhaXEI1LxEv7bZN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1746:b0:3a6:c716:ab1f with SMTP id
 e9e14a558f8ab-3a6c716ae23mr91733285ab.9.1730802305013; Tue, 05 Nov 2024
 02:25:05 -0800 (PST)
Date: Tue, 05 Nov 2024 02:25:04 -0800
In-Reply-To: <CAN=OONzfDPeFZ-BnRd53psEUgv2-wLFxq299SLLK9UqG_iZ4NA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6729f280.050a0220.701a.0018.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in __hfs_ext_cache_extent (2)
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, sarvesh20123@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/hfs/bfind.c:26:21: error: invalid application of 'sizeof' to an incomplete type 'struct hfs_key'


Tested on:

commit:         2e1b3cc9 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=85d8f50d88ddf2a
dashboard link: https://syzkaller.appspot.com/bug?extid=d395b0c369e492a17530
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=154a96a7980000


