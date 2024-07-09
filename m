Return-Path: <linux-kernel+bounces-245307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBAF92B0F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DB3281FFA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF3A13D880;
	Tue,  9 Jul 2024 07:20:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D5F1DA303
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720509607; cv=none; b=Z55ZGPG050GoPKj0f8qyIYjCr729YqDWp59keeyJhIP0qpmpj2+EgzNN5FWXRqHk2uou7f0KWW/tjYp6k1mc7IJ9a0PJWKgYSEKFbsWZjARwrPNiADXIdvJQZCeM/cpmouoEkBqMdXOqqHTpDUmH2odZnhrijndjb3l8p5YpAjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720509607; c=relaxed/simple;
	bh=DnvLGnicbmiYfIqz61udK8HB+zsRCUfv0QDXsIay5O4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D9LA5SNOxINP6LBAlXrtwK6esue1P44ldma2GF9kMf3tsE7rmi/VM4eZfNizXp3IXN9+YzYjzswYYqKTCYYGIjsq6GGcGy/uRGrcHcpmYxy3QhQV4suaMWiOTAe5Z8iFn4bMt395FboxZNyxeUL54aEzGBAOtzQVp7ecqvGNnsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3b0bc9cf6so600513139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 00:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720509605; x=1721114405;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzvn5wJSg31aYIZFNCGyZmbYBaCQNY0Jc7WmVYNaI74=;
        b=qnrh2zmyyC/Rc1pByPIfHZrdC1kiYAnVsf6mVtxSSjVUaQ1hzsJELjDIN8ZE2bktQ8
         PHo3G7hPdOOgrJ3ncv4N1HTancJFmyqzgnb7yfdKjes+3qQq4xrBhU/+wNH6R/6aOCJo
         OIWsI96D4mX9r/vhvELeY3K8tOD9UBy5/9X2GLGulEH4G/QcoT+89Png1xptmgdO7NZ1
         gCWxyS3CfFHqiKArpoep6gp+j34GTmWqZYesLi+2ZH/G5e9LG5FxCsZAdMra3dI82xOe
         c4/w/WHt/30IeumA71P0lnL5AXTbRz4YOtmleBeInAp+RQ5iAzgzVdhUobtqk49Zr3Qe
         7pag==
X-Forwarded-Encrypted: i=1; AJvYcCWanms/SyBKG7uNMDINx4xP/MmRoSvgsHPmpBDsJ56psBxhPfm/lKok+VhyIejVAIFSdg9P+e6dSbJkI3E3SkhI0lsjNa0ENeygm36/
X-Gm-Message-State: AOJu0Yw+NNZU4kvKmu++n4iXZwkyxfhFkftmjrjNZXPqdWgsghPAIuFz
	rRXtT8wXP+mvTe82HM+NtyYxdmM6x0G2RudzSUK07F/Zvrv6OexbamMXSl8Q+4Qv+iEqzlXd36P
	JGUkXb+HUusc0aAjwXdHj2vCg2Z5Rcqeo11bcUKqYU5QxySajT8oWdcg=
X-Google-Smtp-Source: AGHT+IEwrGLocv2v7P1tQnDnDxza0l2WMX69HWMBD3DDTBkNGTZFpIoimehItrBvSBMKGNSJXM1ZxsbkPh0IW+avtuByeBAwJ449
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:160f:b0:7f6:85d1:f825 with SMTP id
 ca18e2360f4ac-7fff9979c70mr9105839f.0.1720509605223; Tue, 09 Jul 2024
 00:20:05 -0700 (PDT)
Date: Tue, 09 Jul 2024 00:20:05 -0700
In-Reply-To: <IA0PR11MB7185EF69D19092412AC55B66F8DB2@IA0PR11MB7185.namprd11.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da3147061ccb5b55@google.com>
Subject: Re: [syzbot] [fs?] [mm?] INFO: task hung in remove_inode_hugepages
From: syzbot <syzbot+f1d7fb4f94764243d23e@syzkaller.appspotmail.com>
To: airlied@redhat.com, akpm@linux-foundation.org, kraxel@redhat.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com, 
	vivek.kasireddy@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f1d7fb4f94764243d23e@syzkaller.appspotmail.com

Tested on:

commit:         581a87b1 fixup! mm/gup: introduce memfd_pin_folios() f..
git tree:       https://gitlab.freedesktop.org/Vivek/drm-tip.git syzbot_fix_remove_inode
console output: https://syzkaller.appspot.com/x/log.txt?x=145a8535980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=409b5fcdf33b7555
dashboard link: https://syzkaller.appspot.com/bug?extid=f1d7fb4f94764243d23e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

