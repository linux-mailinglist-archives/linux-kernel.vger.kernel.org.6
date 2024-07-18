Return-Path: <linux-kernel+bounces-256214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368D4934AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94D0287911
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A769823DD;
	Thu, 18 Jul 2024 09:25:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F58E28DD1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721294705; cv=none; b=Oi0kLhQm7RtQF3oo+jBusk0Z8kkAKaVfW6V0TBXSNh0IFJtqVUW1dlktEFV8ht7sNtobz74HVBg7ppBz1vp1n7PiExE5eT2ZeTUEKMH7WcaZskob7cSB5gnGqyDSSl81Uvw/EHB2MVpxvozAOV7iou1js2jctgGLFcnD/QyBpng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721294705; c=relaxed/simple;
	bh=EAUinRQviMvDujUv3R7ipwJOCnMA9iLRBAFx+AvKvtg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NKIF0GpxepEW111tI8VHp/2bSovxQWMZQpF56rwgBxVAA3VfBLWoxtURWWlkWeTEHDbW8ykneRfiOWa1Vfaq5k+dZ5jZHeLdKv7ldAG/Ctkh915mM7c/271I25qhS+rUsamXz5q3W0CpnjBIzjKrsjaqXM2Q6aYT68NwfXLAxJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8152f0c4e1bso105205239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721294703; x=1721899503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rGyXWRLrvwl7ym9gYBnNhfugsOfnDeqOLsViPL9q/g=;
        b=VnaEX4dsbXFYBh0Smd6hwk1D2brECKvtilSGGben4s0qc2YMuV4ID+TEw/8Z/QBvSk
         UdLqsUGrR0sPm4sXZ+yh8/0+OomQNvS9Oc2oKmfRl9Fc3o57FrLGHi5dMs07qE2xwm/a
         FFlR81znjyD2IBeHkYQf/YpCPa+nmjMFIiFbdn2tPUXZjj4CvCWt/H0VjqPAsjwnb6A0
         ff+/HvXJXJkvQURx2une61ORw5b0fT1h8ofUbnriNhyNpyAcM+8Nf9JUZUzqJykxv9nl
         ammkyvbbzxgKOcEWG6DDMTDF0/objz6Ni5nrWv6pgoggvjUc7TJhAq0DXjowNnCGnp8s
         2pwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPCTFvpAgH4M5dF9f65aIzBrrho8bYlEB7B86AC1GzHrvyd5neRjFZ2/TEQsLCiF7XE3j9uVbvSOxlQ+4vMwprcY2ROM4BMiPln3ez
X-Gm-Message-State: AOJu0YziqekyHZ+t8CIs8G05E5cMhuihCvwKqgX5VpSzIcNw0xyYEZSB
	vmSLCOFFSzUGY/9pqdafPLLetv0dthiKBOxCF/kcxcBFwWhJ7Iev+IvayTu5PX5BTAjHP95zVXr
	X+Nh2o8BfP++a6emxBypjUkfhDFgXrh3oZ2FtoQcFvFTaHHFRqgvPNNo=
X-Google-Smtp-Source: AGHT+IGz25YUIa6vXqL1eZi/FObkUR9B/7QK8k4uQaFLAqvDLyFpspVztyFv/qtJeUG6Z3FXvnmr+ma8VvHFLQjQ3qYbN6/6uMgQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a46:b0:374:9a34:a0a with SMTP id
 e9e14a558f8ab-395594e4481mr3546915ab.6.1721294702813; Thu, 18 Jul 2024
 02:25:02 -0700 (PDT)
Date: Thu, 18 Jul 2024 02:25:02 -0700
In-Reply-To: <000000000000233ab00613f17f99@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050b78b061d822720@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in sock_map_delete_elem
From: syzbot <syzbot+4ac2fe2b496abca8fa4b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 98e948fb60d41447fd8d2d0c3b8637fc6b6dc26d
Author: Jakub Sitnicki <jakub@cloudflare.com>
Date:   Mon May 27 11:20:07 2024 +0000

    bpf: Allow delete from sockmap/sockhash only if update is allowed

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15df62b5980000
start commit:   4c639b6a7b9d selftests: net: move amt to socat for better ..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d14c12b661fb43
dashboard link: https://syzkaller.appspot.com/bug?extid=4ac2fe2b496abca8fa4b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153e3f70980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174ac5d4980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: Allow delete from sockmap/sockhash only if update is allowed

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

