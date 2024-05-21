Return-Path: <linux-kernel+bounces-185290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 833D48CB31E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD431F2266F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D3C14883E;
	Tue, 21 May 2024 17:55:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4556130A4D
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314105; cv=none; b=mQEQ5q5ILzWBJTe1thxtV8Q+ltFeJD95Ep9OGgUi8Gi4qizN7S8bI2I3e1OK3Sj2me6Qr54jul4AWj6hn4cmHUlCtFW5dF0Ky/fMFFpnnusAWYNQ4E54HunyNGg9F6h5mM8nkJtHOTfeChwpudUMuuWjBpGU5A7LyNSxMXMhzKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314105; c=relaxed/simple;
	bh=zoIdtgb34NADuLjc3tV+N7aGplUZrQnoZrFXqAvUrMw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YE4pJYQ0cRDQ6/zpeRvXoFKkSAtqb3q61Lxkcg1k1bWZDV9t1LBxzIFNGlzHGunVF45W3VXQLU1xqWKui71ek4hDjN3XCMgtyJ/qmHPT2FrJmM9qt531q3BHmQ/qPOtGGmbQJ5xVwHf0XUeexWGC+B71vTMP2RtLxJ+uksC0O1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1db7e5386so1255148039f.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716314103; x=1716918903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWWQLx0u45d0F/7cndUkioBv+DcKIil18vzCB0kWDY0=;
        b=ijEeoEPvCfrfFaJA8mNVhdZ5t6n/K1+2pnFKAX1OGRgsWSssw9P8xzsJUkCWoMca5j
         42RKqJFtrnAYlko7cGEgp08UkG/k020iVP6+6Cr9QDG9G6EJlyMofiD/YqmPCrOQU4vL
         mgyVkejRFRFH1GxIy58sfzjTjyJBiQSrfmqPNT20RMdNfOMWZGKwRU7q/BvBQ0JGKi1g
         25AhsouejOl2z7yaWLiiEHuVjWOsDeXjwcKPqqunulxnqFoB86NTPHrADrUm9Nsim3FN
         Ygt+2FEPU5uaB2tg+53JfPvm61tz8UOar7zgliBZ0H3aQWa0VVrTJEvkCzXPLwxEFE4t
         J8KQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8RsD6JVDHMQgsXvzV1Qs/abL7qamARnI/cikZgDX1C0E9y97vrKfF92HzxUbmcPF0m89cBF9jlTwvGfq6hJy5ReIHNPJwuUJOgyPX
X-Gm-Message-State: AOJu0YyxTIu55D+qhMJkfoxsKGOjkZTuRfyZoBLxo/xMK3MDl0J5WUNF
	iHznLQarXURzJAGKcw7MxWBzii41fk4XmeCYUUBv2ti0K4SeDQW0CrO8NBkIFz33ctK4LmRtIZn
	jPN5Po9NXjjPPieIGWayFmP46cGzpa/sOx+n9jybBuHD6bPxpkCDeI28=
X-Google-Smtp-Source: AGHT+IG8Ql4z9HzJhkI0jOEQuDwYKu1tx4wtIVtXYjZPGYlAVV52rq2rg+5tujQGh1Dx5VbozJX4mR6bvWCsHCXQtZv6kZaztANH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8725:b0:488:5e26:ffb5 with SMTP id
 8926c6da1cb9f-48958694bafmr2302849173.2.1716314102929; Tue, 21 May 2024
 10:55:02 -0700 (PDT)
Date: Tue, 21 May 2024 10:55:02 -0700
In-Reply-To: <87o78zxgvq.fsf@cloudflare.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006dab5b0618fa8405@google.com>
Subject: Re: [syzbot] [net?] [bpf?] possible deadlock in sock_hash_delete_elem (2)
From: syzbot <syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/main: failed to run ["git" "fetch" "--force" "9bf55af7188d6db60300eb8cc78d9b6572cad83d" "main"]: exit status 128
fatal: couldn't find remote ref main



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git main
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d14c12b661fb43
dashboard link: https://syzkaller.appspot.com/bug?extid=ec941d6e24f633a59172
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1136a5cc980000


