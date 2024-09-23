Return-Path: <linux-kernel+bounces-336317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA8C98391E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D55C282AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11B6823AF;
	Mon, 23 Sep 2024 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DdQT62f8"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5826076F1B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727127209; cv=none; b=WuWHgQocr3puYZStEioKJo2hr2RzWiXzLUf77wJ1ZFTzWnYMiuRdA4TlWf+V6LGZF9NKNg27G/iVyu44YufLpeH9FMX+1V97bEdGaeZR0irSkLT9x79lzbB33fBcx54lmZkBRk3W0iXyduHB9zV9ErxcOYaf+fv1680kWnWSH64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727127209; c=relaxed/simple;
	bh=vjhYh6hcH8/7VxfNe2wp7ly9zc0buL0j6DU0Na40oF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdbJmNGSc5h+JK8Hg1ZDYcUtVtgqOCHN2v+Saxbg30Yg6F8w8FxCNyQ1KpbfL0J4h7vBYUz1m9CS9AwHQJbJn4WHjrYyRuekY/CMANCoICuVRYu+S3Qd0xMlFOLd8x995T4hlTJs3ygWxbeR79/71b6b4gpPHjkVtxsqf331SNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DdQT62f8; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so3951457a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 14:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1727127208; x=1727732008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSO2oM4clsB/fWSgry40Vq5NPBXMY7dIH/csJJ3ySMQ=;
        b=DdQT62f8CfBQbHpOJqU30yB1ZUdfwXrASzwlahM728sjljJr/8TZnaGVkBUkgnydo6
         jgZVlfJwrX+39Zx9RlFwYopVm33sSVEvrKnTJt0Y4n0NmWnROXC3HGHW3qlJd3tHVeeP
         nRbs63j7dLFf/nRw079i3tShWvcJ6sN+W3pLOiBthT5xxFb9t2Td8I9Tsh5F8qw5NR87
         7t71KV7Mo2GjAw3qn9sbEcqsvQHLnR0yLGLURzGQuysdwTp4SIdjzQCcM0QFTIUwSc4J
         cv/mo8sYmBy/7PhhrhSk4g9CxQgFSl/KnuT1rhOhhtslyRgLeovpxzqPJ1nYDVQJqgGP
         1LNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727127208; x=1727732008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSO2oM4clsB/fWSgry40Vq5NPBXMY7dIH/csJJ3ySMQ=;
        b=OGYDPbfUH29N/XXidEVv9CkSLFkIFAH5r9YcX4pz2f4JIR4skgqbZE7KWirt+9cPHn
         V1mQc/2Ide/jK18xmnOnnQJCO8fzvBYguSDiR7AWOFNsh44QInP71dHnRMcZo4BwVz6B
         aZyOjG5JoCOufB+JAS3sTB9LsebX8uANHA30/Lq2+rDV6UxPvKLoO8XconJYnWcryOu5
         S5E3DSVQ5N4jdPy39ubO23drJAjixBlcpAkF5oB+9tDChIBISsbOxUOuAokHH4i8ByTE
         5KWGQE75amP1vdaFjkZKb2TntMFZOSF+GnVeL4jCQdlmWOsvH7c7ia7XsQm8csqrz+X0
         /3sg==
X-Forwarded-Encrypted: i=1; AJvYcCXUiGx1A1sYrusd56KP4VWCTtTF0MSf5FpUlhHJ6/Z7k+HSxHVkaap9XFFZ3sybIM34pDqizwye36iX5tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmeUEvyCpqPVvrKxK881GVLt+uiMZLJpuciA5D7D9XQ+V7TBfG
	ZAXMA8SXZTI5fX11v1uOISFkMhap0bfvzqKuoWUoir2vaBsEQjyKVbZ8bsRq+xLv6B2u+4R8SaB
	ITSsPU/vFLwIy7CL0f3gIkLF3+cajdf1Mml1zfA==
X-Google-Smtp-Source: AGHT+IGkzWSnsjufHAximoid8vNHundw9/i+nltBwcS6TsKnKakK96mNlpwPHzX/lcnxGDafUauW8IGdLt/lXsPZBVo=
X-Received: by 2002:a05:6a20:9f4f:b0:1c0:f114:100c with SMTP id
 adf61e73a8af0-1d343c762f5mr1620096637.17.1727127207585; Mon, 23 Sep 2024
 14:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALrw=nGoSW=M-SApcvkP4cfYwWRj=z7WonKi6fEksWjMZTs81A@mail.gmail.com>
In-Reply-To: <CALrw=nGoSW=M-SApcvkP4cfYwWRj=z7WonKi6fEksWjMZTs81A@mail.gmail.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon, 23 Sep 2024 22:33:15 +0100
Message-ID: <CALrw=nEoT2emQ0OAYCjM1d_6Xe_kNLSZ6dhjb5FxrLFYh4kozA@mail.gmail.com>
Subject: Re: wireguard/napi stuck in napi_disable
To: Jason@zx2c4.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	wireguard@lists.zx2c4.com, netdev <netdev@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, jiri@resnulli.us, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 7:23=E2=80=AFPM Ignat Korchagin <ignat@cloudflare.c=
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

I've been also trying to reproduce this issue with a script [1]. While
I could not reproduce the complete lockup I've been able to confirm
that peer_remove_after_dead() may take multiple seconds to execute -
all while holding the rtnl_mutex. Below is bcc-tools funclatency
output from a freshly compiled mainline (6.11):

# /usr/share/bcc/tools/funclatency peer_remove_after_dead
Tracing 1 functions for "peer_remove_after_dead"... Hit Ctrl-C to end.
^C
               nsecs                         : count     distribution
                   0 -> 1                    : 0        |                  =
  |
                   2 -> 3                    : 0        |                  =
  |
                   4 -> 7                    : 0        |                  =
  |
                   8 -> 15                   : 0        |                  =
  |
                  16 -> 31                   : 0        |                  =
  |
                  32 -> 63                   : 0        |                  =
  |
                  64 -> 127                  : 0        |                  =
  |
                 128 -> 255                  : 0        |                  =
  |
                 256 -> 511                  : 0        |                  =
  |
                 512 -> 1023                 : 0        |                  =
  |
                1024 -> 2047                 : 0        |                  =
  |
                2048 -> 4095                 : 0        |                  =
  |
                4096 -> 8191                 : 0        |                  =
  |
                8192 -> 16383                : 0        |                  =
  |
               16384 -> 32767                : 0        |                  =
  |
               32768 -> 65535                : 0        |                  =
  |
               65536 -> 131071               : 0        |                  =
  |
              131072 -> 262143               : 0        |                  =
  |
              262144 -> 524287               : 68       |**                =
  |
              524288 -> 1048575              : 658      |******************=
**|
             1048576 -> 2097151              : 267      |********          =
  |
             2097152 -> 4194303              : 68       |**                =
  |
             4194304 -> 8388607              : 124      |***               =
  |
             8388608 -> 16777215             : 182      |*****             =
  |
            16777216 -> 33554431             : 72       |**                =
  |
            33554432 -> 67108863             : 34       |*                 =
  |
            67108864 -> 134217727            : 22       |                  =
  |
           134217728 -> 268435455            : 11       |                  =
  |
           268435456 -> 536870911            : 2        |                  =
  |
           536870912 -> 1073741823           : 2        |                  =
  |
          1073741824 -> 2147483647           : 1        |                  =
  |
          2147483648 -> 4294967295           : 0        |                  =
  |
          4294967296 -> 8589934591           : 1        |                  =
  |

avg =3D 14251705 nsecs, total: 21548578415 nsecs, count: 1512

Detaching...

So we have cases where it takes 2 or even 8 seconds to remove a single
peer, which is definitely not great considering we're holding a global
lock.

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

Ignat

[1]: https://gist.githubusercontent.com/ignatk/4505d96e02815de3aa5649c4aa7c=
3fca/raw/177e4eab9f491024db6488cd0ea1cbba2d5579b4/wg.sh

