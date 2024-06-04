Return-Path: <linux-kernel+bounces-200511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E21638FB10C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE341C21F3C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AF914535E;
	Tue,  4 Jun 2024 11:26:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E5B145335
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717500364; cv=none; b=j3XYTeH/q94n1/sD6VFDickm/4CHQmLDII0lvtLuQYZYP4jnLjlBZWUVcdYh4J+5nhc3XNqvZNr81bl+A+eB9sy/2EMKKhjMxxq0dE4h8D/5UiMYkIVIQIzEZk927XcriqfGIEgf55tE1lLh1c/Y7udCkMNQanS8nMjmypS1mxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717500364; c=relaxed/simple;
	bh=GRpZtExmKZkFFuBkT38w2ZzBsG54iEBNWsQimsUe2yI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qiJ0IwbZH5taBTkLBVQYBmenT8hxisXFWaf6m8qWnPOxigmSta9foBCB4oIv6LcWgSlF3ZjGW1jBlIMPG2oV680t0JkcvtKDlkIMPqccuo1lSqIa0p4S4ryEE1spJx5cmD/yp3ElnRv4w22XdRWVKEskWp+hvLQulGPvfM7oMb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb314a0cecso51731139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 04:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717500362; x=1718105162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDWs8Qf6oC8uzuae/Q/CxGzelgua/8H3R+rkuuIVFeY=;
        b=BomYw2uGbP8HdpUhhWQoC51QfTReAtIHQ6I9xZbB00H9xDJ+vH4vVainoq3mFlqUYk
         Zm/ObwkJXCBvmUM/uxStaIYpCd1Xzrm6fpWZQYhldN5rPZHVQH53lvgvfL42UzGsK4FA
         d7WVUdAmhUs9hgioxhied1+Vu/dPnjiSjO+Ybh5mLL1vMc7W/0/AxwAX7bk1VoSoQwbp
         hOOYhMMp28Y3bRaPkmhDZzjTlM4qPlu4YD9H2BiktN9vCSPpZIXHBsi07jTfLSL3lsFq
         hNG8NQUxrPJU1tyM297D51mMr+3uF/AS6wMDqt+K3x3zj+IVl08SxsreC0JS9s4ouTwv
         QO8w==
X-Forwarded-Encrypted: i=1; AJvYcCVrd1MB8h3deTSU+AZpf4tlFWOnNeSJtGyvN5VJq0WZuxudAqy2O2mU9q5B0lQIY6c1gup2aK+LoSfyXMDXgi9X0+1DE7ThlMHPJGNF
X-Gm-Message-State: AOJu0YwGEcYj5fkDvUIKfdUB7EZq/9k0vS5HrSwQDX0mo+d15VX+L0l5
	8m3FMNy23MHk+AmzDAvk2Rg2V7bxCVPjkNoBXOKzRSulY705iKzObMpr0/dLSlPf1iAGscq5LWS
	Lz2tEozYLnlCsZqoMawVJJryc4I3pWogT6CdQtq/7j5+pTiA2lzKecpE=
X-Google-Smtp-Source: AGHT+IFqjayrCHItg5/UFPa9My7gZ+vTAstDursZj5wFpPAiNxTgpNaNTd6nnx4LypkdJBWeZEL2bJGFuJXvEXIUiSgKTiFpzhMA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:871e:b0:488:75e3:f3ce with SMTP id
 8926c6da1cb9f-4b53e35e64fmr296451173.0.1717500362096; Tue, 04 Jun 2024
 04:26:02 -0700 (PDT)
Date: Tue, 04 Jun 2024 04:26:02 -0700
In-Reply-To: <000000000000e9b6ff0618356b26@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc10a4061a0eb684@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in bch2_fs_read_only_work
From: syzbot <syzbot+8996d8f176cf946ef641@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1526df2c980000
start commit:   f06ce441457d Merge tag 'loongarch-fixes-6.10-1' of git://g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1726df2c980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1326df2c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb72437243175f22
dashboard link: https://syzkaller.appspot.com/bug?extid=8996d8f176cf946ef641
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164255f2980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16174432980000

Reported-by: syzbot+8996d8f176cf946ef641@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

