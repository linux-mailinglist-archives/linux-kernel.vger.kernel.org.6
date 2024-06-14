Return-Path: <linux-kernel+bounces-214751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 733B090898B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28FA61F27E13
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A80B19412F;
	Fri, 14 Jun 2024 10:18:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF17E574
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360284; cv=none; b=cIcpMmg3cdNf1aDNSSJMWktahoHkf3Zf51JTQ39GguyF9TZZSJ98mhmuNfO4xCvZm+esUtWUVjccz2xiyKJVB8jb97c9icnB9Ft2cr4FtcCNrWMx478QCSUzs/mCyxCK2Y8kvdkLLprO5/uOTnNEkDNrkO4pPJj/NTFHPGigSVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360284; c=relaxed/simple;
	bh=4G+914elYXMeWW+C/AaXZxtLt0Gt0mRHwzM4WKL9Euc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d7tpftkC5QRCui9gsYQ9iQR/87Q8nB7XVoBo/ttFRcO6eVsjjiBMXSOyzzH0Qui3W0BrgGmgTLm6gCdaS6ZBoOkiPbTXnzQyvCZ7ykpsqHYAW/UQOf4REGrKZ3JeM4mrQgiC/LXPNmSa//BNxbB6K3pLjBeWlTK0Ml8isdW/x+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ebcbef22c8so203964139f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718360282; x=1718965082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YV80qxKF+oHGlNR5edDZVi5v7ORv7cKhK2eY2MZxvMU=;
        b=DByElSnbnVA1nbQYh9mRkYcUhszhDYcAOQt21LsndwHbFOdD2RvpnU1nKcV99368Rn
         7UIrSGaauwxRpskXT+G0iE1O6jSoAMUzfb1k25hb7pHCLb0Cnzmr+P0zcYjbM7XfOfnk
         4mapVmEp2PPxG7YMbFkmXOiJcGQzDCR3lKCd5L17hJG0e2QdyYqp9CKKI38rv4SC1Y3X
         SM3OHMdHoiay3HUeNq08ZyFh8RZOslfbtVAyTq7M93sFIUFuYWZaThkhBgwyC0OSO8kJ
         BVlRwF3e5UgG5j80FNStY8Mls5ow0V0dOXkqmNf8sLLG3hioJQoRfNuvMMiQEgNSKbil
         HUuA==
X-Forwarded-Encrypted: i=1; AJvYcCVjlUfUif8anXVxPRaNUsnepHTQPBy5U1LxGY9H240DSRKp3zNv6liR+85XGVOb0eCaN3Mlb8scCIQrjV8ATn1aVag2ryMUuQdQ6iKN
X-Gm-Message-State: AOJu0YzGDLVtRylEbb5I2pUHASojWvrqIJbXNH/fRe/LsNJZo42HT1yh
	d0WeSssiyDzxgvloieKEqX7U3jafo/osNLiNtBriZmTK4vKDdoUY1XPpwWS/uTkWJ0eXgWs9l9M
	sLJYXcuQeXpQDyxTe3rwAWBfisXZ1QiFmItGuXXRUvOJJ2jfP31i9mz4=
X-Google-Smtp-Source: AGHT+IF6FEIajU3aE0lAs/p561HSiklP+Ko1QGAmxnmqzC2Rq5zwDYqKiEBTeCQqp9y3Ia7qs+sCY2/ttlVH5iB8sCM3RgMhLynF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f90:b0:7eb:8530:810 with SMTP id
 ca18e2360f4ac-7ebeb64474emr4768839f.4.1718360282632; Fri, 14 Jun 2024
 03:18:02 -0700 (PDT)
Date: Fri, 14 Jun 2024 03:18:02 -0700
In-Reply-To: <3cdc2784-6c02-e251-579a-24df9036424e@netfilter.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e238a061ad6ee64@google.com>
Subject: Re: [syzbot] [netfilter?] net-next test error: WARNING: suspicious
 RCU usage in _destroy_all_sets
From: syzbot <syzbot+cfbe1da5fdfc39efc293@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/netfilter/ipset/ip_set_core.c:60:4: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Werror,-Wimplicit-int]
net/netfilter/ipset/ip_set_core.c:60:9: error: expected ';' after top level declarator
net/netfilter/ipset/ip_set_core.c:235:2: error: call to undeclared function 'ip_set_type_lock'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
net/netfilter/ipset/ip_set_core.c:236:7: error: call to undeclared function 'find_set_type'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
net/netfilter/ipset/ip_set_core.c:240:3: error: call to undeclared function 'ip_set_type_unlock'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
net/netfilter/ipset/ip_set_core.c:246:2: error: call to undeclared function 'ip_set_type_unlock'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
net/netfilter/ipset/ip_set_core.c:905:8: error: unterminated function-like macro invocation
net/netfilter/ipset/ip_set_core.c:2453:69: error: expected expression
net/netfilter/ipset/ip_set_core.c:2453:69: error: expected '}'


Tested on:

commit:         0e728dae netfilter: ipset: Fix suspicious rcu_derefere..
git tree:       git://blackhole.szhk.kfki.hu/nf main
kernel config:  https://syzkaller.appspot.com/x/.config?x=7266aeba025a54a4
dashboard link: https://syzkaller.appspot.com/bug?extid=cfbe1da5fdfc39efc293
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

