Return-Path: <linux-kernel+bounces-313993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E258196AD6F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470751F256A6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357E9A23;
	Wed,  4 Sep 2024 00:42:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CC3646
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 00:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725410524; cv=none; b=BxQdI+3+QHjJsVrd4ryp5HKl9ST4KlizvHpf8gYhSKtqU41DT3Hfccxt43vw6ZTYY4EotLCnpVG3Z7D2+QGHrhInUZUncWXaOIA1NrUtKkdKaXhkIC+gngpArhAc3r5NMbnAHRPyvtEj8g8wbcvUbwt20RIPZU5Qpe7tSOJgI4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725410524; c=relaxed/simple;
	bh=OFtniahcqcfacPW0dAnh9+73e/NGQ+wEDzH3TQgmfPM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kMiSp0zYZMlIu4QhhFSLV8sJZM8xgFh3+EFPOD0xcKziHUWj4L8nKsM1ypgvBDkChNYEqqkJtEKxMva/Q3uIJJliNEFKLjW5NPuyJ+8S2Ed48u/pGZ3Bv/yFxjaj7dJQeTqhQoHBpsLxM/+TfWlCfqAG9P1D3DWRABvHGELLNJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a1c81b736so686066739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 17:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725410522; x=1726015322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3WXt4Ex6VS3UcGyHdp1rHM+NUWPCgEsXSC1Q3/0EBF4=;
        b=KmHAzarehp5yqIFzUiUUDmAzWNIQBae3RhWl3k6t/4//LdsahHMbDYGtAQnFNvub32
         v/so3or14kTBMVNlooy15TwlIF4d8AWv2J0prW27belYrufiFBWXDtclUg3ljOh3tRA7
         1m+fBQip0P5cTQjpaVJb18EPGQIAI5WjBn8tf9fFaqXyH/uxv3klYHtLQ2jBd68IpxOa
         nZ300li4F8BIr/7tTMaTP8kDEy4vGFChmyqkIV06WaiWJWCodVwy6+iGMSY0NQY31ln9
         3lrdmeSj5nb8iNuMi9JxobLAetxdBz159MRjUDYNvrXnVstDA6MoAmdSpMAq1uTv1TsE
         tn/g==
X-Forwarded-Encrypted: i=1; AJvYcCWX2Ri8ixq3rVz+hCPCiaRE3y/ljAU9J6Uyza8ZaZT+fGKAGgRx4oITM8aJKAktEjBIIt4X2JP6bx0HDd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9X+UaZT3FZQHYJPH8ZCZWvzHYUthCx6Wxw5KZ9dhz7nC3TsMW
	d0IAqHwfqzx5a4DaHU9ln5pOx6T8pZGeXHJqL0a0yOb9QvarmCX2CnCmyO+ewQIeNpDpUULSbeO
	0vdrFf25FjxWnz4VuenOpoVg5B/ewNajrJZUMPHMC72vZePH2pd5sX/E=
X-Google-Smtp-Source: AGHT+IEkMNKldOyHxUs+jhIuNr5gdxcMCCBznEuScTEHcD3EonElsYBDSKQClw+jeC9jnRYYqwCjaoKjWpVIK7C8t9wZaoETzS6E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0e:b0:39f:7050:6f69 with SMTP id
 e9e14a558f8ab-39f70507014mr1643915ab.0.1725410522583; Tue, 03 Sep 2024
 17:42:02 -0700 (PDT)
Date: Tue, 03 Sep 2024 17:42:02 -0700
In-Reply-To: <tencent_DD4C79766E502D6D6E1494B4E88AED6ECE0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a68010621407136@google.com>
Subject: Re: [syzbot] [mptcp?] KASAN: slab-use-after-free Read in __timer_delete_sync
From: syzbot <syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Tested-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com

Tested on:

commit:         88fac175 Merge tag 'fuse-fixes-6.11-rc7' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=119dcd63980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=124282ab980000

Note: testing is done by a robot and is best-effort only.

