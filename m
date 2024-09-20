Return-Path: <linux-kernel+bounces-334259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8400697D4B1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 13:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E0D1C22709
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A8B14F136;
	Fri, 20 Sep 2024 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBPd6Q+F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6808314D6EE
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726831142; cv=none; b=Yn0J3sZ150gqKaCAghlrWYIuikxbb9cUzwyUBpcwgRQaePmTLkcHthHORoghkOnls3tkc24suiY7I40boVxfw5xlil/kpi5RH2kEk4DWdMNHuRLh2kHNe+qvST6hA7G7Ve8zDTx3vCm565J+hit2Af5t0A7xKKLpjovqjZPpgIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726831142; c=relaxed/simple;
	bh=YmmdShIqKaT2yeZj5698K3XwhwhdWq1wQAnhjNAgSoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CQVb/jO0Mqb5nFjXdBcRaVzs5MN3BU89rCZ8rejtHHQaCXrkw+S98MUwMOzO+IO7VKYRySnK0A0BzMGENi6klgE/ePxpGuKFwKlfdcMm2hfXcj5l5OaANJrJdf4XVWcXb1HJV4De0f8HogIpHDWX5XtLgE+vdfUa5nc4kUBuUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBPd6Q+F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726831139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxgxgQuUGZxly+q+gkXNqzmcxuR4gi3wEXVTHNlpL88=;
	b=aBPd6Q+Fa2lUg5KThfL/Gj6/g1Dmn+s2pTHbGxN37fPjP94P3jFqAsy3oTsyWWIAYYw24W
	Wtr/xrSkZe3MPKYMBR280r6HEmRHbMnkuOI0eLO47eqWDdBhX4AVvrN5+5PcqxpQ5oyHnY
	TICnbL1JI0eBNumJx0bhv4Tayddc3ts=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-ipJljnfkNjeGoqNrNhiM6Q-1; Fri, 20 Sep 2024 07:18:58 -0400
X-MC-Unique: ipJljnfkNjeGoqNrNhiM6Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb6f3c476so14798215e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 04:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726831137; x=1727435937;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxgxgQuUGZxly+q+gkXNqzmcxuR4gi3wEXVTHNlpL88=;
        b=T+z9TePzNQSvlVxe4w9lsZksJI1TYpOCUmZv4KkUDgugPmjLwQ+HyRUnYyvFhP0IbU
         EZT5XFR7i4gGPP49DKmrN0nn490jxiIqgVwuN/C10fnq/dQNgCnj86kpfcZTtOKnUQat
         lENw6VvIrmRq/U7kne0rSeLE8SQcTMZEueipetw6fy1TEdVczxpbQHaLhn2JrjMDTb8y
         JDXh/HxUoDDWMEGgbHlfRs8kVSps2O1HO14kypuMdFKaneil/+yRYimAWmu3u/PVhM00
         eVptdDWUBc7a9B2zZcoGyXC5vPEzn2gH6VPfXb4LQHGywD5UNwUrCx3lrvQvAusmaJhi
         K7yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIIvCZPeNNv+h/xDzItTAi1yYDWOnWCX2wh1um2x6dDLXbuvb8MmpAb9WoEWYPFhttyRYF2rmFY+TV6ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOR0Wptdj2Vj9w3JtJFwr5M7BCPhGsttJbwjhU9t2ZnRb4KhKR
	aLLxIoerr/E6ZA1V23FAvA7dyjm5dzEnZgEdmXZsqyysk8CP/OPFrg3DyHiW+gJ8IOrjeIntFgO
	qXPMdD52eieD5uQn2n0zdGzGlecL0dXQBjhj/v63Q0/NOYgcJF34sEZKbQU4lcg==
X-Received: by 2002:a05:600c:458d:b0:42c:a8cb:6a75 with SMTP id 5b1f17b1804b1-42e7ac35e0fmr21768565e9.17.1726831136856;
        Fri, 20 Sep 2024 04:18:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXXwA+/Lq7Qwx1kLgvjWo7woGE50UmLK6Xj0kazKJTf8V2gCF2e1kojmPEmHDGLe0sv5hiCQ==
X-Received: by 2002:a05:600c:458d:b0:42c:a8cb:6a75 with SMTP id 5b1f17b1804b1-42e7ac35e0fmr21768345e9.17.1726831136470;
        Fri, 20 Sep 2024 04:18:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754516e7sm46430025e9.27.2024.09.20.04.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 04:18:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C14DA157F76D; Fri, 20 Sep 2024 13:18:53 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, syzbot
 <syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 michal.switala@infogain.com, netdev@vger.kernel.org, revest@google.com,
 sdf@fomichev.me, sdf@google.com, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in
 dev_map_enqueue (2)
In-Reply-To: <20240902080232.wnhtxiWK@linutronix.de>
References: <00000000000099cf25061964d113@google.com>
 <000000000000ebe92a062100eb94@google.com>
 <20240902080232.wnhtxiWK@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 20 Sep 2024 13:18:53 +0200
Message-ID: <874j6aindu.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-08-31 13:55:02 [-0700], syzbot wrote:
>> syzbot suspects this issue was fixed by commit:
>> 
>> commit 401cb7dae8130fd34eb84648e02ab4c506df7d5e
>> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Date:   Thu Jun 20 13:22:04 2024 +0000
>> 
>>     net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.
>> 
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12597c63980000
>> start commit:   36534d3c5453 tcp: use signed arithmetic in tcp_rtx_probe0_..
>> git tree:       bpf
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
>> dashboard link: https://syzkaller.appspot.com/bug?extid=cca39e6e84a367a7e6f6
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13390aea980000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10948741980000
>
> This looks like ri->tgt_value is a NULL pointer (dst in
> dev_map_enqueue()). The commit referenced by syz should not have fixed
> that.
> It is possible that there were leftovers in bpf_redirect_info (from a
> previous invocation) which were memset(,0,) during the switch from
> per-CPU to stack usage and now it does not trigger anymore.

Yes, I believe you are right. AFAICT, the original issue stems from the
SKB path and XDP path using the same numeric flag values in the
ri->flags field (specifically, BPF_F_BROADCAST == BPF_F_NEXTHOP). So if
bpf_redirect_neigh() was used and subsequently, an XDP redirect was
performed using the same bpf_redirect_info struct, the XDP path would
get confused and end up crashing. Now, with the stack-allocated
bpf_redirect_info, this sharing can no longer happen, so the crash
doesn't happen anymore.

However, different code paths using identically-numbered flag values
in the same struct field still seems like a bit of a mess, so I'll send
a patch to fix this just to be safe in case we ever move back to sharing
this data structure.

-Toke


