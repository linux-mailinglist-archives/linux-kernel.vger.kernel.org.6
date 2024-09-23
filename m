Return-Path: <linux-kernel+bounces-336226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CDF97F0D7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28921F21C27
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F08719F419;
	Mon, 23 Sep 2024 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EP0qpPWE"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D60F17BA2
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727117221; cv=none; b=riBCWoNGp4C+OnURORDCXOkCq8j5+Fyn0BRKxiNKFMIxYDkl8KL/lNlYeTlRBqp3yXVrz0GPaiqiU+2zNtSIk5f6qUaYGdrZNtxQobhD4U7lw1L6o3+wI+Rc5PMdgwCiv0luAvA2KmREoqeKODgnY5VDg677x/3FvVAJglGuTmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727117221; c=relaxed/simple;
	bh=DtQ+HnhI8KP8gv+zLVSZ4exfL0ZJE1UvPYQYsjLzcMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBb9WJVa3wXxyu1BM65gG//UzS08Bjx3j6iXOvluROx2OajMuT03POSX7FF3/gLywCVzjZH3rg3iLOVri7DTfFy1EBfNg4QAZXtD2oVf8rdS+46qrm1SyLvUWpG9yyI88G+BbS0B4tx2PyoLWTjCIvtWRM2/Qrq/IQF/70sPNmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EP0qpPWE; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5356bb5522bso5540665e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727117217; x=1727722017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9SxBKtVnKUNRcU2l8i9+tr7LGseNTvA1HmjIgiJZ6c=;
        b=EP0qpPWE3N8IbfBZZl0xdJMm3jeG6lrEsGpjWgr+dLSY+HGnDHEzxDj0T5LmJNnENi
         WNeZf9TXc6uU+P8fm18eHjPyrIi3oMVXd0Mu+tTSAPIA4XCOXiMGhTrRArUOWEIG6BNM
         x6mw1SBweKtBWw6Uo9OPRTi+X/vM+/XicdrBiKzvKro/ECKg8cdj3wyoWbmmxFWEWYUp
         jNRAOc7FBnTHyiEuH4crztb/9HsW5c/1JOdCeIpd0YFrJXqBRisAH5LB4Y7oVBBqAMIt
         hL3yw1/QjVfDyjkujp0vxw4RTbDrrblw9hOE7Zv+/nm8wWPCHgORBp60Hs5lQfuJwfuR
         LI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727117217; x=1727722017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9SxBKtVnKUNRcU2l8i9+tr7LGseNTvA1HmjIgiJZ6c=;
        b=WCZ2Qyn+sAA/nzuBow4pTvz7YJJKRvWAJhXNouQ4uLB3SNdiiWlzcAKcj4+Wizid2F
         NPOc3qaPS5e99CV7gi7YRltv2CI4k+7oauo/pyzFIpb+8Z2iKLWWmAuT80OO5WRelEnb
         Zf3pqbrSp54pvLk5e3XnRjYOlf+Houfaz5qT/TTraQx5URvxwdQoSzliJ+EF1yPP+VeS
         CZgiYJLfp90MYxEGgmFwaX9/nlrYYz22tegIu4z86s9EM+vCQeabTMKCLND2v+kZKxy3
         MkGVCKKBCG5P/P8OhS+Kw2AsKYlpJqR+5G5XyvpZsdJMxS6AU3HJuzh3io/yKLRiyp8w
         ocGw==
X-Forwarded-Encrypted: i=1; AJvYcCUkLM1jarPR9EcVl2Jv8clC5/fgy59qMA2RH8aBPTSIx5TFw9UQ+7WOyL2ae/AC4CPDx1rhNLcwIX1fW3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YySIZhbPb+gYw5H35Rb9dssUzd+4ApNF/AcDJDj/RkPHQtlTDgn
	ufPn1HjJndIH07vXkLc865M8lMczk/jBQ1RhqIRqXFR9qIKXvyKGbfOcQHsAjWFB9YlEQT95xNK
	rVgsrQ5S+V5aclPRGd5JMdVIYTihYwd31rYEk
X-Google-Smtp-Source: AGHT+IEdUO93R9RfshiaEfkPtfC8Xl5uT3xw9/r+1yE0jsL1ViaO/11BK3hy0Now0uX6vpEhuQza2skF49C4GNi/gfc=
X-Received: by 2002:a05:6512:1293:b0:535:82eb:21d1 with SMTP id
 2adb3069b0e04-536ac34094fmr5590163e87.57.1727117217312; Mon, 23 Sep 2024
 11:46:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALrw=nGoSW=M-SApcvkP4cfYwWRj=z7WonKi6fEksWjMZTs81A@mail.gmail.com>
In-Reply-To: <CALrw=nGoSW=M-SApcvkP4cfYwWRj=z7WonKi6fEksWjMZTs81A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Sep 2024 20:46:44 +0200
Message-ID: <CANn89iJRoJQ5XXZxbC4mA=-N2sHyY8QNG-ftyQZT7w3RUw-g6w@mail.gmail.com>
Subject: Re: wireguard/napi stuck in napi_disable
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: Jason@zx2c4.com, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, wireguard@lists.zx2c4.com, 
	netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, jiri@resnulli.us, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 8:23=E2=80=AFPM Ignat Korchagin <ignat@cloudflare.c=
om> wrote:
>
> Hello,
>
> We run calico on our Kubernetes cluster, which uses Wireguard to
> encrypt in-cluster traffic [1]. Recently we tried to improve the
> throughput of the cluster and eliminate some packet drops we=E2=80=99re s=
eeing
> by switching on threaded NAPI [2] on these managed Wireguard
> interfaces. However, our Kubernetes hosts started to lock up once in a
> while.
>
> Analyzing one stuck host with drgn we were able to confirm that the
> code is just waiting in this loop [3] for the NAPI_STATE_SCHED bit to
> be cleared for the Wireguard peer napi instance, but that never
> happens for some reason. For context the full state of the stuck napi
> instance is 0b100110111. What makes things worse - this happens when
> calico removes a Wireguard peer, which happens while holding the
> global rtnl_mutex, so all the other tasks requiring that mutex get
> stuck as well.
>
> Full stacktrace of the =E2=80=9Clooping=E2=80=9D task:
>
> #0  context_switch (linux/kernel/sched/core.c:5380:2)
> #1  __schedule (linux/kernel/sched/core.c:6698:8)
> #2  schedule (linux/kernel/sched/core.c:6772:3)
> #3  schedule_hrtimeout_range_clock (linux/kernel/time/hrtimer.c:2311:3)
> #4  usleep_range_state (linux/kernel/time/timer.c:2363:8)
> #5  usleep_range (linux/include/linux/delay.h:68:2)
> #6  napi_disable (linux/net/core/dev.c:6477:4)
> #7  peer_remove_after_dead (linux/drivers/net/wireguard/peer.c:120:2)
> #8  set_peer (linux/drivers/net/wireguard/netlink.c:425:3)
> #9  wg_set_device (linux/drivers/net/wireguard/netlink.c:592:10)
> #10 genl_family_rcv_msg_doit (linux/net/netlink/genetlink.c:971:8)
> #11 genl_family_rcv_msg (linux/net/netlink/genetlink.c:1051:10)
> #12 genl_rcv_msg (linux/net/netlink/genetlink.c:1066:8)
> #13 netlink_rcv_skb (linux/net/netlink/af_netlink.c:2545:9)
> #14 genl_rcv (linux/net/netlink/genetlink.c:1075:2)
> #15 netlink_unicast_kernel (linux/net/netlink/af_netlink.c:1342:3)
> #16 netlink_unicast (linux/net/netlink/af_netlink.c:1368:10)
> #17 netlink_sendmsg (linux/net/netlink/af_netlink.c:1910:8)
> #18 sock_sendmsg_nosec (linux/net/socket.c:730:12)
> #19 __sock_sendmsg (linux/net/socket.c:745:16)
> #20 ____sys_sendmsg (linux/net/socket.c:2560:8)
> #21 ___sys_sendmsg (linux/net/socket.c:2614:8)
> #22 __sys_sendmsg (linux/net/socket.c:2643:8)
> #23 do_syscall_x64 (linux/arch/x86/entry/common.c:51:14)
> #24 do_syscall_64 (linux/arch/x86/entry/common.c:81:7)
> #25 entry_SYSCALL_64+0x9c/0x184 (linux/arch/x86/entry/entry_64.S:121)
>
> We have also noticed that a similar issue is observed, when we switch
> Wireguard threaded NAPI back to off: removing a Wireguard peer task
> may still spend a considerable amount of time in the above loop (and
> hold rtnl_mutex), however the host eventually recovers from this
> state.
>
> So the questions are:
> 1. Any ideas why NAPI_STATE_SCHED bit never gets cleared for the
> threaded NAPI case in Wireguard?
> 2. Is it generally a good idea for Wireguard to loop for an
> indeterminate amount of time, while holding the rtnl_mutex? Or can it
> be refactored?
>
> We have observed the problem on Linux 6.6.47 and 6.6.48. We did try to
> downgrade the kernel a couple of patch revisions, but it did not help
> and our logs indicate that at least the non-threaded prolonged holding
> of the rtnl_mutex is happening for a while now.
>
> [1]: https://docs.tigera.io/calico/latest/network-policy/encrypt-cluster-=
pod-traffic
> [2]: https://docs.kernel.org/networking/napi.html#threaded
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tre=
e/net/core/dev.c?h=3Dv6.6.48#n6476

Somehow wireguard continuously feeds packets without checking it
should not (IFF_UP or some other bit)

napi_schedule() detects NAPIF_STATE_DISABLE, and
napi_disable_pending() is also used
from __napi_poll() to avoid adding back the napi if the whole budget
was consumed.

Not sure, more debugging might be needed.

