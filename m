Return-Path: <linux-kernel+bounces-193309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D11228D2A20
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 03:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD7D1F2620D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 01:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F8815AAC2;
	Wed, 29 May 2024 01:54:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5B228F3
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716947645; cv=none; b=AR3+DgIx48DaR8DgofTxxD/rzoehUIma+qGoHItAFyJP8MK/IZK9PN0YSvOE6fA+ZWBzbDYw8J+8fItta+FSvROrnI1rA5VfNBJkxsfctXGHDxTuKpH6n8b7a4oCQYzk1D3GxZJpeeke2YXviB5/iSKnfV0WXzjx7UuE9+xhSr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716947645; c=relaxed/simple;
	bh=VXy4JWVb5/Gfi5dltPT0RKx5cI9NMNy7tTi5LD5VKvg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YyB/W212uZINDjCx9NHyFxqrk36dW5oFEHiJ5L4B0MjefNRUjyDkvl0vwpecawZg0AVa5S6jZ06wCJyT3KDPbqlSg9zzcfzqvAqIXj3wctV2QJrwTH9tQQThqUgAGBRq9ltwDPKhFp8b1vX0WoqIPIZThquKkX89Kjh755OedzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eaa9ddad99so165625339f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 18:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716947643; x=1717552443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2xytC8M2ngtyDtIOSc+tWSOAuAaWplC6NhaLDoLfAI=;
        b=Q2KMD528jHJvw334gwZqdQ5+2jkC+PTy0ueq9qga2sYORG9sJnCZrDTeh020SMLbGT
         zCMOPzRT03aibOqOPYh2d7op01RjqkqXGdFpCBmOFyPpF+EzN3WslvM5QCvyWUob6b3l
         NYkjQkQRYJAtOPXaVlU1XZvvc2NFK72ya51/Y9wq2ZSw/4JL662wIVhC5ClQLEDi4a6w
         AubNSSCi3pdna2xL8zMS+5a/bgL5g1yOl0jIJev/cZvEnD95x/ekShrQSiSjWSSTJIvy
         18ouRepVmuqJg+A4dfQlmvbObVnXQ9PFnypZCMVjX7Qz5KGVaIIyr47w+6+wgrsqq2EA
         xFng==
X-Forwarded-Encrypted: i=1; AJvYcCW6Z9LhHJSXuwJ2GMJ26lgXNPcvGBKCxe4f48R8crwUDKV5qeDYtrkVhum5P4gzaQuq65U31QXG6/bzy2u4fqTTx2Fkb9J938M2CE1s
X-Gm-Message-State: AOJu0YxETb0X/I1k8EGiNg4Ef5hATLqbOOAlg8aeMPEjUEsBcPc9wGtH
	amj2pks1JzlXm0Mdl38RRruVQebulsx2uxYS8AmDKKNN3wKBBl8bmP75sv9saMY0nZeXd3/tUq6
	wyHo12zaD1YPX+nALb8GxNbLvrI2wD6ckASlaGTep/p6hstN6ppF93Jc=
X-Google-Smtp-Source: AGHT+IGZhMoLPuh+0ph2MK4lHBBhpzUdpL2h3o/Lx4gUBueLJTovG5vWE5StwsY0ZePBK7YocNJO0x20Euq3vo8YaKJKE9zbUAnw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216e:b0:36b:2731:4084 with SMTP id
 e9e14a558f8ab-3737b2bdafemr8108755ab.2.1716947642911; Tue, 28 May 2024
 18:54:02 -0700 (PDT)
Date: Tue, 28 May 2024 18:54:02 -0700
In-Reply-To: <0000000000004d74b30619866a7f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a9fbd06198e06b4@google.com>
Subject: Re: [syzbot] [mm?] UBSAN: shift-out-of-bounds in try_to_shrink_lruvec
From: syzbot <syzbot+17416257cb95200cba44@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@surriel.com, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 6be5e186fd655df4b3ba267054de2eaaadc71340
Author: Johannes Weiner <hannes@cmpxchg.org>
Date:   Tue May 14 20:26:41 2024 +0000

    mm: vmscan: restore incremental cgroup iteration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=179315c8980000
start commit:   6dc544b66971 Add linux-next specific files for 20240528
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=145315c8980000
console output: https://syzkaller.appspot.com/x/log.txt?x=105315c8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a363b35598e573d
dashboard link: https://syzkaller.appspot.com/bug?extid=17416257cb95200cba44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e41b72980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f3d2d2980000

Reported-by: syzbot+17416257cb95200cba44@syzkaller.appspotmail.com
Fixes: 6be5e186fd65 ("mm: vmscan: restore incremental cgroup iteration")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

