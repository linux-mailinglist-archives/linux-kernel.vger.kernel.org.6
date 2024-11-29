Return-Path: <linux-kernel+bounces-425965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10F19DED05
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 22:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76577282147
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD131A264C;
	Fri, 29 Nov 2024 21:50:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7970145B16
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 21:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732917004; cv=none; b=RsDE0uGNy4b6chDQDW4ED7FyAc2qDnB7DzQalcp2VAYSsLNQsFtBKMqPOAhWYep7OHPGu7KCLt0rOuQhlIjhw//h0oHy3ltR9Jrj1Vwz8Cc8ts7D2WtFziKFy19bLmPb8qZjoaClXCnEMpWEc2m+o7NSaWTNSgqYjNx2A0lsNlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732917004; c=relaxed/simple;
	bh=HLybwCwa+a3/JjWsDYolVotDpk17b8m/rovizSWwS/w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=awhP/il0n06Q/LIfuK7VR1R+hRpWWJFfHL0/yMfynQzXB58slRiI5hKF0PipPt3ahVnReT4NzTK9JyEKqdSFca7uXsVxmCkxjswbjw8gdP3OVqRSELcvvEZh2dJVKazFIPUcnlpBVpvWNWWL1ykeZ8fU76IHJp1n0fN3HDN619A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a794990ef3so27562775ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:50:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732917002; x=1733521802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ReOz98nJbClMkoql6G/8CNTB8vZuZXht6BvTL66hlE8=;
        b=qHAYVdanXr572mISwoxf4Vtbkfz0Z8PFnhM+sGeVR7YqMV7EAVbfykYeDeQtUu+I8b
         TS+wKK0PpGbxd0GZfT11+Ggd5r3SEFTLtxotiBD5tI0EuJgyptCQ3l5aMdEoq3Ercsvf
         68LjECuM4OuFOt2xDlGXe0i3IgYz88pXh8NI5CymQwJhODYbHgK0ow+t9nD9OW3obV+C
         4oRj9eTBFfC/ziuXI/LrjnH4tmtFjAVaOGylpB+cnTFvNj70/e0+XSoh2wTQ/LcSP+Eu
         yL+g0LDwpXBiih34TI3qxD/CbHJu4dblQxyYTUO6k9y1Dhi0UaRagImnRRCTuh2a/DuJ
         YwQw==
X-Gm-Message-State: AOJu0YwAg1n1k3DBfLTIKbuIb2aG+c+OqzZgFYLdSmmg4yjXOr7i7GCy
	mUposTlGdCjjr1igmVz5BVLXC0N7j8te3Y6ZFCaDhN/+zy+5Fa09Hhc+Jx0dHVuLVdUXXLGgaCK
	7Epf32w7UdaMs8qBkHtiZgunjFPtN+itSIcM1HC1Hmy2hfqn0j5UgbSA=
X-Google-Smtp-Source: AGHT+IEUJZzTcaF3o1Ndisq9GZQW5b0C8F20TjOCpAyY9EOzPXEDQkjXgNsnVr7Tw5nxQ5q/+aqU4wcrHL5aeDl9UpZNuWcWuYld
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c103:0:b0:3a7:cf75:30b4 with SMTP id
 e9e14a558f8ab-3a7cf7531a7mr68946115ab.10.1732917002023; Fri, 29 Nov 2024
 13:50:02 -0800 (PST)
Date: Fri, 29 Nov 2024 13:50:01 -0800
In-Reply-To: <1120cfcf-75d7-49ec-a19b-fbcf43a4a1f5@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674a3709.050a0220.253251.00cc.GAE@google.com>
Subject: Re: [syzbot] [fuse?] KASAN: null-ptr-deref Read in fuse_copy_do
From: syzbot <syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, niharchaithanya@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
Tested-by: syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com

Tested on:

commit:         2eff01ee Merge tag 'char-misc-6.13-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=111119e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92c00fea95836451
dashboard link: https://syzkaller.appspot.com/bug?extid=87b8e6ed25dbc41759f7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12dc19e8580000

Note: testing is done by a robot and is best-effort only.

