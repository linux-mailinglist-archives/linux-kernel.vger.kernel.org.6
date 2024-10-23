Return-Path: <linux-kernel+bounces-378366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77E49ACEF9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D871C20DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4691E1C75E6;
	Wed, 23 Oct 2024 15:38:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E75E3A1DA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697884; cv=none; b=snl9nYnUITlklKSFiZm84vZ+H8jcN6zt1PUA8h/RvM52481Z9LHxHiSKAjDUMu0VogbAdAzKo2y47uvkHs+ojiesWWLkirMQSdad9KnJUYNthqKjKQU4J7To+DWYe6+1frMISziJOl+fCCjv+ql0RRD67DYEoF0eaTvpFGh3KIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697884; c=relaxed/simple;
	bh=ba4bwJtQvd0r4w6c6NG9md0Qeci/H0xP8HHhZZ5mIdc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oQ3F3b3hmo0SRKbQyPWZStfiQMMS2ljyCcsn+dj6ymcgOXJDjELVMlYX4gHufXDy78Zh+FYPrS88rp9kWFGRA+k0xEXtwh4oj9BWUnzqz+ntwEO85m/ZPTqTMycOe93rqBAv5NyMo3i9T28J0JNnctFxg1cjX2kY/P8ml3fNXpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c24f3111so68672295ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697882; x=1730302682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ER8a/BFRBva1YE5+IJmQ/NCGnUlgKneuoMtMsPsDi1U=;
        b=I/PS77ITgFxMaOqD/jbCpzSlWgvSyOpFe1KG7lAxpy3oWJSzr+pvPKCTFVMUK+4eJq
         IyrEM7VFfLbWQLesWjpYLx1s3v2obfbffRr/DZwa6FfTK9BgvGFrkQaOfJ+j/8msG0Cs
         zLVy1PTi4/ELNGVDrPwybpkkzf7KNWz0hiXafxMJ04KJV1RrD6vOKQgiVOzXhG+haMGJ
         2jXIkvF4wug25Dm7IaCvHGvDxViw1knDq6NEkdXkvpSkwqR9PnHDrg7hVMfCZN/tRqGl
         5OVlhOGX6fxs/gAJyMGafB9l6r6Blv0BcD79tBKWFOFvnswV1eDC2yWMXL3+XL/UDSKy
         eNGw==
X-Forwarded-Encrypted: i=1; AJvYcCW614xPjdPTlPQzYXpwa3es6XMfmnkuPQNgo92Az+HPWuIY76k22p5vEi5SQYWAm5vJ2lFjPPA3vDiZjUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzKgjDi3S+StgVqCwNY+R92E5xDW/ZUKN+DQxe01G6D0i7vMMd
	jwyKYZfi2146x3VsOxAR0SGxgePgXRBGa40sHlK+Tuk8gbkj0fOCZrWv9z1jdB5Xq2/BCtklEs7
	5gAlaUBx7p32Z725GtTxVhbrA5lyi8D2Z0lpX2zn8GvgQUGBsGBeOkHc=
X-Google-Smtp-Source: AGHT+IE+knpFY8Up6lXbbcbaYCfAoQJpwz84ICm5HX6poBDYEABqgZjRnglaJGw4MT6ibNDoOXsp+M9v8cXtS02fagWfKS68/mXJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1848:b0:3a1:a293:4349 with SMTP id
 e9e14a558f8ab-3a4d59af493mr35730145ab.18.1729697882582; Wed, 23 Oct 2024
 08:38:02 -0700 (PDT)
Date: Wed, 23 Oct 2024 08:38:02 -0700
In-Reply-To: <20241023151800.61444-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6719185a.050a0220.1e4b4d.0092.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: null-ptr-deref Read in bch2_sb_set_upgrade_extra
From: syzbot <syzbot+b468b9fef56949c3b528@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b468b9fef56949c3b528@syzkaller.appspotmail.com
Tested-by: syzbot+b468b9fef56949c3b528@syzkaller.appspotmail.com

Tested on:

commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e5c287980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=b468b9fef56949c3b528
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14fe4c30580000

Note: testing is done by a robot and is best-effort only.

