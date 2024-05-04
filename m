Return-Path: <linux-kernel+bounces-168775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C5A8BBD8B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 20:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA821F21512
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 18:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1FB6BFB0;
	Sat,  4 May 2024 18:03:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B9166B5E
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714845784; cv=none; b=AZ50P2rI2+MT+u9oENCw+iHThv5dd2vBwzixCTU2LL+Ccr21dfy7+WRAzDJJOYVdqfZF8DIUPQZlzFNIzgIUy4lWuTX5prkYMr1IQmKGvnJdV/mUkl5zkZ4k/a6UPAAyUZyFEI4e5faiWGrwnNgxC/hYYSNPsl1MzAibBpO/wj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714845784; c=relaxed/simple;
	bh=TGOyrg0sf81JB2aKmDNGGn/8jsML6d2k85Lh7p/VWc0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vAyqlZCmiJtBrp7uekv5CSn7BOv5Sv3ZBBg48ARPUrBthREP1cV5CDe+OGHDbMIRxw9K2Gz/QNVPtfGLbwG+dO446Aic4UXNK8d54ShvFEa0D6LdhJu2Ykw33UYBuaqhERJbhoVO35hrV0Hj/RPzLDwLPVYQ+VHC1OATbPZrFPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dece1fa472so66198239f.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 11:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714845782; x=1715450582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUPcGyTMIX5rtLi/ARCE2IxHHhgwhiuh+5Rloinf3xA=;
        b=flIy4VzYxXIu1y1wQwUOalkj1xYq+O83JvvsBSBZ2KirQQCGoDV7YJJ3pnzpHIEz8d
         xCHm6jQfc2XwbDzKOJqRUgnKdSrWKzp5TS01DMp+ioxs+a3hHzglMelvAx0vG6Xwr+II
         xiVu17RmnLpf8ZauGctXNx7Af7Dscz9qPNAjaxebu2FnumKmqa5Tif8xs0EV+2wQPvdJ
         qlZSkfEOZtFWJlo0ujBSejiGjkiVkF2Pc2S/mQ4JMgtjqfVVZG2tjsAu2EX5INoL1Mrw
         0a3Om1I0G24OpHrSPf2lVHLGaiVINtmeHHwhh5s3Xlw0sufxQrJsUZI9GQHAV/SjZyxA
         S5Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUdezWoXpuTkvJFrWWeaLgAow3NAz1e058EcC/YVpsvVUJptS9pfm15BAQlD9n0oMuiiS1RlrmogBM5LZwjBSnG10PVArx8U8OiJXvp
X-Gm-Message-State: AOJu0Yxk45ebT5vYQM7JSZhm25LMR2gUIYCD+3o296fHPyjBoCBEoVYR
	5kSkK+e1HijO8x8pdYKPkEGQ7u9/VRGYemLfpaIlDcLvaosTzHWPQJtiZzLuycDS5cCKHQO6qIC
	KpsPMwNn7CitPrTN6i+jEAXMAK4BSSkBQ5GLaa82FpJqwvjykWfCUkxU=
X-Google-Smtp-Source: AGHT+IHexZQjdMJ0UcNQiKItATZihzTrma90QUok5tG6gn9gMnSrxE72OaHcLmP4TLDaWgpBh6OjwcQtZdjnOXhshwTFiadLwhWr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2489:b0:488:75e3:f3ce with SMTP id
 x9-20020a056638248900b0048875e3f3cemr9923jat.0.1714845781990; Sat, 04 May
 2024 11:03:01 -0700 (PDT)
Date: Sat, 04 May 2024 11:03:01 -0700
In-Reply-To: <0000000000004cc3030616474b1e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae301f0617a4a52c@google.com>
Subject: Re: [syzbot] [bpf?] [net?] WARNING in __xdp_reg_mem_model
From: syzbot <syzbot+f534bd500d914e34b59e@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	hawk@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, lorenzo@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2b0cfa6e49566c8fa6759734cf821aa6e8271a9e
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Mon Feb 12 09:50:54 2024 +0000

    net: add generic percpu page_pool allocator

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=151860d4980000
start commit:   f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=171860d4980000
console output: https://syzkaller.appspot.com/x/log.txt?x=131860d4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=f534bd500d914e34b59e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ac600b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1144b797180000

Reported-by: syzbot+f534bd500d914e34b59e@syzkaller.appspotmail.com
Fixes: 2b0cfa6e4956 ("net: add generic percpu page_pool allocator")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

