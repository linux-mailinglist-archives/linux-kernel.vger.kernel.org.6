Return-Path: <linux-kernel+bounces-335844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE23B97EB6B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E8D280CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D645197512;
	Mon, 23 Sep 2024 12:18:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE6419412F
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093884; cv=none; b=QJDsEeS/HS3LalTyRaFelgZIVXRm60S8eBjYOn0xMo4Yu1PkLpwQJ22pF6E2qKXv2l0pEsTTRTHntsjQEgJxSrFm6039H1dMdvHPXpoXw8afb7394Sk1DitduUiL+Yppu504yF/alwAbRAlCO0O2TRHB/VKHALBNcDI4Zn5eFUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093884; c=relaxed/simple;
	bh=UUgoWwG9cyOyTxT5rHwFS64RIjNw+yXdlzBhw+l+sP0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AzhP7rhIls1aESKljpdzQEEfT1DG/WbGIhHmYNQLou3NuGzW83Y5zIx/c0g5D/SDRAB4ELmhkF9Q/4aBDnuyl4+/tSV9O1oOaVrOvjTtvg4Hqq33zARwZEkqPhjUB/E/N2G/eMUFXoKncn1HZt+nI51znLV53J4cpo/bNF/MK5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0a4db9807so72653715ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727093882; x=1727698682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WH0M7YG4k9VcjZ9VMvOxdD7Y/VL084p8eNMnZVUQoHY=;
        b=TxOn43uHLfjN7IkDED9MUlAHEE4yNXEPWsg2CaFBpvLO/yIaG3nOPyXEJswElcZGlg
         LG1lCUJL7HLpDvXqurfnZgeMKUPrznEE1ivu32nasnFlXUVDm4O4oMLW4EkcSRQkycWS
         XeqCwQkaVF1gEf/DhEoN670DPMSTKRRK9lJEcMoepDYJlgifxBgyFffqjqrd70vzPvIu
         bD8cu5Aucq4YRrRk+jvGYcMwrEXoum2B0zs5ghwUnSFDX8UAjjK4D9ZvXsj2c5UDQdhl
         Al83ON0U1rZmDaDDQQVDBAVCFBVr3FMWNwwtFM0YcSVmSi/6areEFzDJKGuolp11fpeu
         dM4g==
X-Gm-Message-State: AOJu0YxLRB5hOKp3AFX8vB8CyruH06vzWWGzRxH1HY66HwqRUhvK7NKs
	okOOzP2Ed/aipFjh2EXrHGAcnoUrsT/fnLhFWQTTSu22vHGJc5GyKbufQygdrhxoElFLevy3C+C
	nXMcCHJDwtyhEKm/76M9xZjNhTclKdr54z6bby72G4BHmvBBKyij7CcI=
X-Google-Smtp-Source: AGHT+IHY5BMmdL4fd308FvhC+tw1nKca1z6ZBuCzsQqJ5yM37COnR5f7cjKn4BtPaI3qcyeTvKyX4heITMw7/pI+OzN6nTnch2cI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cc:b0:3a0:9f96:5bbd with SMTP id
 e9e14a558f8ab-3a0c9d16185mr94248765ab.10.1727093882511; Mon, 23 Sep 2024
 05:18:02 -0700 (PDT)
Date: Mon, 23 Sep 2024 05:18:02 -0700
In-Reply-To: <CAABpPxQg+RmC_7udiOmj49MuP3E1B+6bbQQiyTrzzEz0Qei1QA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f15c7a.050a0220.c23dd.000e.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_get_system_file_inode
From: syzbot <syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pvmohammedanees2003@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com
Tested-by: syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com

Tested on:

commit:         de5cb0dc Merge branch 'address-masking'
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17cef480580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=74ffdb3b3fad1a43
dashboard link: https://syzkaller.appspot.com/bug?extid=e0055ea09f1f5e6fabdd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f07ca9980000

Note: testing is done by a robot and is best-effort only.

