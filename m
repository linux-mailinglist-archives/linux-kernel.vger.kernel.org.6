Return-Path: <linux-kernel+bounces-218084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E399B90B91D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EB128B8B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365CB194A7C;
	Mon, 17 Jun 2024 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FxTmM0sR"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AF51946DB
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647747; cv=none; b=NvRb4tEiehZZZeX7Yl0tYkJhUmHitB1iL4WjpSi3I9irPq3Rh7H/2Idp+jHEl1C777uHW6OiQHi8atrpQTy7+VoYcAKAdveYAiWQC/G0qW3AruScYCmMl69KK2guflHla6LafgXSMadTamxrbCxkbLM3kQgKPEz/xcyDTujSDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647747; c=relaxed/simple;
	bh=b+D/bTjJmd9oRoUJip9jd5YaP8VulajMm2JIH4GtR6k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qhsZOug53lwzqEyE59Runz84uxE9xDJeyvbPiYn00cjwQUv6uxyXIj6KBp8QgEillvt9mu0l05V3W7v8Z4YkgG8d0HFW5nYU5/QPsWDrA9WoCzdlcyIPU7lxLU3qnW+AAX3UdOuM8jZIgt5q6t6/Y7AS6xYc5na014LmDoIN+Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FxTmM0sR; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-43fdb797ee2so23310731cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718647745; x=1719252545; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+UXAeJHazaKB0tl8krC6xVJ8wj4OwafBBT2mwF8+dZc=;
        b=FxTmM0sRd6GBucAiAfv8sfCDtlihU8Bv/ofwZ9zD9dSphven7LH/dt9VFBrw05+x7g
         XPvQkQY0sIBWSEo6PyQXffMUTOLO4QY4zUQ59Vbhk98gKzTZq4bcF0pgUukNkgmdq5Zg
         X2Hdu7mZmtmGwdq429/1vlNW6sHBdzd6Mxoqd+k06hfCyS0M33d+59kfuspPbtmGF5xd
         o1I0c/yWMWhTxv9UNIzkAs4LYJYa7VtSj+m1M4wTBQAsWOloDRk+tZWO8uTiT2y8Vlh3
         Fgl1fBPOaBWgmI0XHCF10jQijBN78i1mYF1bQrsyFahwz5tFwMnflu9ZmPIkdZRk3QJc
         Vh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647745; x=1719252545;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UXAeJHazaKB0tl8krC6xVJ8wj4OwafBBT2mwF8+dZc=;
        b=o/ytqBnO9EuNELqX9HcGIzXSM3AxAG6AcIGhBwdPdnkCIC9mHOevO7HUcPSY70aI4A
         vXoyMJqz6R9xCEDqSoNUKyfoHElKMHt5sqFlP2/RrRozggaVWhTkPbnrBRCTVQZNbUk0
         FxoKwEMpE5RtmMGebWzwns3YybUy2PVWZ04YrJZYdBjcm9AJnUAaXrfeg5C+v8cd5KH4
         ciZhT2Pgxsk3WumlcVGJ8jpZwUBCz62Lx9QpVWORh/9cDEXXGZXYY1TgKGf2BxkkcZgE
         WUXbPwY6tczluxfcBRmSj7DCOt32HfMvu4P30QW1B3BRDeqAX2CXmhcGsu7PDZofejIe
         ZstA==
X-Forwarded-Encrypted: i=1; AJvYcCUv1vKWE+p6o6HKNYuhIeP46n+3YN/ytthQvpkLX+gW0AMaQJDXdqBawHLGdHHHKsOKK3FXjN/59IX3ZeX4fcSbZ6sGLLvCXRyLoW2u
X-Gm-Message-State: AOJu0YxGHRgiEAe0KxjAnLH+EoQORrVp+qaMD/Wkv+kjCKV/WSf225cn
	gczVFEnEBTSLow4z+KkrCO6OeIBW12CB/Yc0/Lf1XH4hPATLfiNbC3OeQ5WnRt0=
X-Google-Smtp-Source: AGHT+IGCUVe+Ux+j+DZ1FKTLw0r3CHgPgOvQ82gXSKD5wF8W9vFcZRxf3i+t6ZxmWpO4wnzXVNIsZg==
X-Received: by 2002:a05:622a:5296:b0:444:93e0:61d3 with SMTP id d75a77b69052e-44493e062afmr26734751cf.43.1718647743690;
        Mon, 17 Jun 2024 11:09:03 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef3d85e8sm48916491cf.2.2024.06.17.11.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:09:02 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:09:00 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Mina Almasry <almasrymina@google.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	linux-trace-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net-next v5 0/7] net: pass receive socket to drop tracepoint
Message-ID: <cover.1718642328.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We set up our production packet drop monitoring around the kfree_skb
tracepoint. While this tracepoint is extremely valuable for diagnosing
critical problems, it also has some limitation with drops on the local
receive path: this tracepoint can only inspect the dropped skb itself,
but such skb might not carry enough information to:

1. determine in which netns/container this skb gets dropped
2. determine by which socket/service this skb oughts to be received

The 1st issue is because skb->dev is the only member field with valid
netns reference. But skb->dev can get cleared or reused. For example,
tcp_v4_rcv will clear skb->dev and in later processing it might be reused
for OFO tree.

The 2nd issue is because there is no reference on an skb that reliably
points to a receiving socket. skb->sk usually points to the local
sending socket, and it only points to a receive socket briefly after
early demux stage, yet the socket can get stolen later. For certain drop
reason like TCP OFO_MERGE, Zerowindow, UDP at PROTO_MEM error, etc, it
is hard to infer which receiving socket is impacted. This cannot be
overcome by simply looking at the packet header, because of
complications like sk lookup programs. In the past, single purpose
tracepoints like trace_udp_fail_queue_rcv_skb, trace_sock_rcvqueue_full,
etc are added as needed to provide more visibility. This could be
handled in a more generic way.

In this change set we propose a new 'sk_skb_reason_drop' call as a drop-in
replacement for kfree_skb_reason at various local input path. It accepts
an extra receiving socket argument. Both issues above can be resolved
via this new argument.

V4->V5: rename rx_skaddr to rx_sk to be more clear visually, suggested
by Jesper Dangaard Brouer.

V3->V4: adjusted the TP_STRUCT field order to align better, suggested by
Steven Rostedt.

V2->V3: fixed drop_monitor function signatures; fixed a few uninitialized sks;
Added a few missing report tags from test bots (also noticed by Dan
Carpenter and Simon Horman).

V1->V2: instead of using skb->cb, directly add the needed argument to
trace_kfree_skb tracepoint. Also renamed functions as Eric Dumazet
suggested.

V4: https://lore.kernel.org/netdev/cover.1718136376.git.yan@cloudflare.com/
V3: https://lore.kernel.org/netdev/cover.1717529533.git.yan@cloudflare.com/
V2: https://lore.kernel.org/linux-kernel/cover.1717206060.git.yan@cloudflare.com/
V1: https://lore.kernel.org/netdev/cover.1717105215.git.yan@cloudflare.com/

Yan Zhai (7):
  net: add rx_sk to trace_kfree_skb
  net: introduce sk_skb_reason_drop function
  ping: use sk_skb_reason_drop to free rx packets
  net: raw: use sk_skb_reason_drop to free rx packets
  tcp: use sk_skb_reason_drop to free rx packets
  udp: use sk_skb_reason_drop to free rx packets
  af_packet: use sk_skb_reason_drop to free rx packets

 include/linux/skbuff.h     | 10 ++++++++--
 include/trace/events/skb.h | 11 +++++++----
 net/core/dev.c             |  2 +-
 net/core/drop_monitor.c    |  9 ++++++---
 net/core/skbuff.c          | 22 ++++++++++++----------
 net/ipv4/ping.c            |  2 +-
 net/ipv4/raw.c             |  4 ++--
 net/ipv4/syncookies.c      |  2 +-
 net/ipv4/tcp_input.c       |  2 +-
 net/ipv4/tcp_ipv4.c        |  6 +++---
 net/ipv4/udp.c             | 10 +++++-----
 net/ipv6/raw.c             |  8 ++++----
 net/ipv6/syncookies.c      |  2 +-
 net/ipv6/tcp_ipv6.c        |  6 +++---
 net/ipv6/udp.c             | 10 +++++-----
 net/packet/af_packet.c     | 10 +++++-----
 16 files changed, 65 insertions(+), 51 deletions(-)

-- 
2.30.2



