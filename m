Return-Path: <linux-kernel+bounces-402504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1BA9C286D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E7A1F22F3F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAF820B7EB;
	Fri,  8 Nov 2024 23:51:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8EA1E411D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 23:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109866; cv=none; b=c0fOl/p/xarj9OxntgDwFPErMeBLh0TqrrUspTed2/9jsc5oCXZttvTmuv6L3ANXxZTc4NhcZPCenvxiChIpNTgvgX0ruMUImp5w/ysqPHVofJCioUlYEFAwShuuckuiUiSHnkT0Ym9KWkn/WFltWeI56mv+3V3mB9mZu/5oCb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109866; c=relaxed/simple;
	bh=HiH2qlupQxQPieaGXKhfvWeznPMibZvKUbzp7Is28jI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XTNBTc+BqTwFq1IKMfkbUNP94opkBvCi/Nw35BaTRr75D6VwS0g8ic9wIYSYS8EcmvnpgD98vyNRhYDmfUMpk8Xhk25Ev2b/zAgtQwN0k8mBlvBMktxhR5gkigw3E0UpHkQoEmdTJkTZUKChIbGfdKYpQ+fPfM66OWl0sep1a4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ab369a523so285807739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 15:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109864; x=1731714664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvF4VJedp4bx4uz37YIn4+DjpxeEyou5tUhiLHk+GAE=;
        b=d6I6sXcMnGyRRw/X7Dux2y4pnUIUrNDde0r+p37ECE+tDeIrAQjQAP4sU2q6bbsvLP
         loz52+f+dTI6zBHWiKiEEwlPk2UE3WLHruQ33yeXJQnyus1FRmCYM/hkLsSNmMamQXUl
         NdgZUogTOnTSezZ3VJL31TKxoLhlcU/s9rX5VUPJDyZ/5pKjPtgZBFmgGOLHygZp1PMB
         2gsTHyXm9CyqkW5ZEoCHwdtT4liGtP7kpx1yb7NDOoDvEAJXN75U31zwPe8mv74QoTvv
         3o+5VYRgSH+zUoR5yS0KjqRleCftESyxkAbLe94h/nl7xktr0EDvV+y36PlTb6SkO+uB
         /lVg==
X-Forwarded-Encrypted: i=1; AJvYcCUODkzAnVxGO2RmhDFI+8CBUG9GyLUUQ1iC56eHjz7NFAQjE7ZF5L4UVUXIRwV12KYODek9FCw1r0D7Xy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLzejYnkswHy31KFOioku/6c+wumkYjsRq7tGWrfoDMb4GB8uv
	+7QLOxooBLXmondhPWYZBAWs7KZP+23Neb7m6YnQNgmIC0g+WIfYSR1TUFU4FHQDTZ4/y2A5gaw
	sh2ncPkT9v3SIC8xQrPS0Wdj6YE2h/Icbvn1ZVTrqrPmUyW+6TUvjEsI=
X-Google-Smtp-Source: AGHT+IERJFWzWIGcTUBjgtYqdu1hGfdOtjkge/3BgAEtB3Yhrd2DlQJiOYVXj74pVu7Yv6h9qUT+xQ42/XKV4IPh1TeIsFzUVqmi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c7:b0:3a0:9952:5fcb with SMTP id
 e9e14a558f8ab-3a6f1a2e2b3mr60836775ab.17.1731109863988; Fri, 08 Nov 2024
 15:51:03 -0800 (PST)
Date: Fri, 08 Nov 2024 15:51:03 -0800
In-Reply-To: <20241108232901.3631-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672ea3e7.050a0220.138bd5.0036.GAE@google.com>
Subject: Re: [syzbot] [mm?] general protection fault in swap_reclaim_full_clusters
From: syzbot <syzbot+078be8bfa863cb9e0c6b@syzkaller.appspotmail.com>
To: daan.j.demeyer@gmail.com, hannes@cmpxchg.org, hdanton@sina.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryncsn@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+078be8bfa863cb9e0c6b@syzkaller.appspotmail.com
Tested-by: syzbot+078be8bfa863cb9e0c6b@syzkaller.appspotmail.com

Tested on:

commit:         da4373fb Merge tag 'thermal-6.12-rc7' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11de435f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e568a63823509f1f
dashboard link: https://syzkaller.appspot.com/bug?extid=078be8bfa863cb9e0c6b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a72ea7980000

Note: testing is done by a robot and is best-effort only.

