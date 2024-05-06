Return-Path: <linux-kernel+bounces-169294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B1E8BC669
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9321F21B8C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 04:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C747B44C67;
	Mon,  6 May 2024 04:16:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4241E4BF
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 04:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714968965; cv=none; b=DsomvlI+0t7R9PCG6YpQ4qp0rbWJJ/8tnPJglmPta3yzWnKtYDOjt6bJMs1QbmQ/9Yg6cfvnqhgfSyH2QK6FRB6Od1KZWWtKYARgostlHuZ8/GeNGD5DjYeM0uGfavcItic/d0zxza4C6jJBRmlu+idr6pJdghqMkMUMOuubKNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714968965; c=relaxed/simple;
	bh=e7d3eUevSjyBi1+UMir/tIUoeUJ0gThJDxFrmjgtjFM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cU6cG+BWo7cWI6ZsVE2jKwWFy02DquEnna6QT5vxCl6GimXLnqp8cFHPzkrlx2PH5kuQyJbC/S8/vHt0ERAbpdPHX96kPgW5/bxI9bkSPiKNX6sqlPBzSZXinTFTlUJjoV8j3y0HSrDKcTHUsTIHRe8stTN9o7pt/fbK6y71qhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dec58efbfaso197965439f.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 21:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714968963; x=1715573763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6sYdOPnTbd11s8yXYICIhsmoL2HnQkl/tBOTzLZOD8=;
        b=iYkqjpzTuwse1iFZFPlkunXLnNcgoMEak7WFcc4VBlPdFILVQUzDjwHIOc3mMDYFc9
         kXuShr/1lmLzY2k0fTKXNWVGLHRhsI45NPa9pBo+tWAX4G+ID2KmExWh7/xAWnnurtr7
         AFvmBX1KVcOSw4/8Ab4Rbq1FjbqAhb1uAH7qCg/dGdhrxL+aU50EPmPntLOrpPAeMl71
         mkjDxjZSnWJGDQZC9KORTU6TzJQSQeBDLMI1keJjWGiuXOTlTqb0ZjYS4IAl9tGnY/w2
         8ToxUguZ2f+4d5Mcd61g72zYcyMqHLptaTmk6b1CFCzLojTqQ39Q1Pb3c+Tilp1oGHM5
         yFVg==
X-Forwarded-Encrypted: i=1; AJvYcCWSS0fISvYQIW83sYzYj4a/+7u6dpHY/p5pmrPJNTrpi2PA+HFwMMi9DwEpD3d+2rWlQRN2S7ttZMLxwItiMjn/iFSnoiGpx69MU33l
X-Gm-Message-State: AOJu0Ywn85j/QQkW4bEIJAw1DViNXncWTi/8KOJ5DnjavZqsmD/cikAy
	99u6szdVwgLrUMYJZIOhe0KDRrljJ7XKFkbRvhtwccUDReqyF1rLCM6lmANGHZ9uSd6mmTtro19
	rgO+4n1aHftLZeevr26o1+unW3J5iftGZ+1bQx6r6xDaURkp/y/SnaSk=
X-Google-Smtp-Source: AGHT+IGBk4Y+VQkB5ysWua6toZHslQvpRpftX5qlHvumtyLVnI52zH0H+bBch9oaAmKS7e+ZtCr14q2TWHBub43ps5U79ZwBI6at
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3e8e:b0:488:5ae4:735c with SMTP id
 ch14-20020a0566383e8e00b004885ae4735cmr440652jab.2.1714968963314; Sun, 05 May
 2024 21:16:03 -0700 (PDT)
Date: Sun, 05 May 2024 21:16:03 -0700
In-Reply-To: <000000000000918c290617b914ba@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc06ed0617c153e4@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in bch2_sb_clean_to_text
From: syzbot <syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e58a70980000
start commit:   7367539ad4b0 Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17e58a70980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13e58a70980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=c48865e11e7e893ec4ab
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1043897f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145c078b180000

Reported-by: syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

