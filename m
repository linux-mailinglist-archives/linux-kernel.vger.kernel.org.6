Return-Path: <linux-kernel+bounces-300228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA26995E0D6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 05:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838D428263A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 03:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6C7C8E0;
	Sun, 25 Aug 2024 03:37:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A7A1D69E
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 03:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724557026; cv=none; b=VHK+2U2ubOm5i+kGyChqoPUdYUKJO29HHsjBQ/N07m3GEK+knjYi0yxK8KXh+lTXu1ZUUBoGwk6MYoBVSiQgZuAcLagz3sUOAUv6LOr9Iuha6b/P5p95AtN8CMBfLmyHKIlrlpmRr9ruciKsQnxSid3iV9QCvJ8QihBjsc+9phs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724557026; c=relaxed/simple;
	bh=qs8x+3+P7R5Yu46yXDf1sNvEY3Wimh2kH94I3uOLjq0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lN9pgBHzmsNbG+ThVnjspAr2YfG0PNxKLb+xK+BZ6zEPU327+rleKdi0KFLtrCD+RPmOhRrEahSp8FmxIFhqCgm3YVW8U6VhtcYCknmfeUbhbb9Owj49NvzIwknzTEKVwBnaCPyf5Lmk0ywJBjKU9mbvjbHQbPMJRvTeAuFUrDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d4c0fc036so38046145ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 20:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724557024; x=1725161824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9Y7prTirX60Zjf7MKnC93bQnU3UQk7j54mGU0BXZMI=;
        b=T8do0GExiBVwBdwPCi37e/SSuKMczWfmAznwWedgpT59LDQ7ENExZvTiq58QCcPI3p
         Ew37nzNEX9HoSeZXKGR3Tc4EsNhCt4J4tFpSRjAEXDgqnz4qjUTlh3BHXiQYK2BuOBRo
         xEg9FRjjazTyRq8Dbzlrzbw5lMhLmE8dgfzhtW1wju4q3ueYgXZ9E0I+NrTNSPTrohS0
         WkZvvj/9SIRUrxvalONSBIHdpbTQyrQASl2jGMaXue9DfXRhZc3K8ZpWkNvAiwmPOSNo
         AGlU+pOEzggaW5GgtsaeiVTLJ6U9zwIz1ENrC3+wHbGnFpjQ8jo21zJRKaI0p8zDyLi0
         M7Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUPATYWK2kErHN3uYNGYEqBiyhgWn7eqt4gYZRzGQQyZBD0b3iDG/6jymreguaEF+7dVdqenYEO/SQ1LZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQx0LqyM5w5knEcSg3W+tmwJ73z8GfQlfr3G2uN2iI4E9q6fxD
	iWtQmI5kJRJB3+S+EhSRpXFBdb4xH3G7e/h4vym62dvQzmQxeFxEV1DIApcrk5YKkrmQG3ESBkL
	vWax/kO/ne20JWwkVvgQz2SJyV6JcL3eC1MzobK3/2GQYCyNeGuNZRm8=
X-Google-Smtp-Source: AGHT+IG4h7J5l4jttEEali2eWLWHbj4PjUwD+750YNkmr8ye40PAEwm3+AmjpuzBBHHVSW6sVcYvyyKkJNP/kSyTJnB4YaI/A0Rt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4b:0:b0:397:2946:c83c with SMTP id
 e9e14a558f8ab-39e3c9f5955mr6047325ab.4.1724557024186; Sat, 24 Aug 2024
 20:37:04 -0700 (PDT)
Date: Sat, 24 Aug 2024 20:37:04 -0700
In-Reply-To: <00000000000039e8e1061bc7f16f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d26462062079b885@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in do_ip_setsockopt (4)
From: syzbot <syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, davem@davemloft.net, dsahern@kernel.org, 
	dust.li@linux.alibaba.com, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	schnelle@linux.ibm.com, syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d25a92ccae6bed02327b63d138e12e7806830f78
Author: D. Wythe <alibuda@linux.alibaba.com>
Date:   Thu Jun 13 18:00:30 2024 +0000

    net/smc: Introduce IPPROTO_SMC

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e95825980000
start commit:   d2bafcf224f3 Merge tag 'cgroup-for-6.11-rc4-fixes' of git:..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17e95825980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13e95825980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fc2afd52fd008bb
dashboard link: https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e70233980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a44815980000

Reported-by: syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com
Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

