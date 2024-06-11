Return-Path: <linux-kernel+bounces-210558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5313590458C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991301F258AD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C14C150992;
	Tue, 11 Jun 2024 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EyShCcyP"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083192628D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136686; cv=none; b=PwSZ5koc0fkfApZ96FVF3qcPXpaJNTtMEZyxWvOVzdTjtaoiYOyI5Mtd5hSAsrjRevVsq2V2tVLbNjB51Io/iNgri7LlnAgRKxqj8wfBD1qMBkKlZAuC5TNkCvw1u2MQ5Xd6TkIQQkMRwd6NZT8vNpun6rVQVRhiky6Fz8j1t0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136686; c=relaxed/simple;
	bh=cMK1CclC04MqeTJsWHlOEoNGqcBkfXz7uVhSatuhjZs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R5h3EI82L2LEiF+9FB/Yzi8BTH2rNviYXsX3ny9PiAiBPUj3lq94MnNOwEK6kRcPMAC5YR/oQhq0C+HDAGWSsnleboxsD7klAFBVkNPu6zUK8s5BPvAiHITro8Fp9/4kdQJV9SPxg4Z2Jtk2LgsZlsMdOlZs4kJ45J88fUWP6K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EyShCcyP; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f95be3d4c4so803701a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718136684; x=1718741484; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qjr4bFDIJ+rHSyjjaa7KT8dWhd5ireGzkoHLGps+PSs=;
        b=EyShCcyPpRX4D/EoeHsgCuop8yzU60B1oo8qKOJ5mSbCZh8350MEnv6zzsPts9f68a
         3pRNsY0LpRlg5fKGMjUcLSAliMQa6Zq2qXY2jUU++A8o4esvK6OG4Ns3zbkR13iHL1/7
         8ZAv2a1MvhwGxVGci/lZRUvIxMV8BznrGENmPj1x51+5mcDlzDOamGESP/kLZvrlajJv
         mf0zz7LZrl/YOjqhvJxkvfbeMctO/3+GnTkNLJYobL7yTasyKiOCPDTTPw1gc7J1YsO/
         wPMYeJos7zQRftdkAtz4kvahO1l7ZXLsnB3D0c6nuajSnsq0H2IRyTddrgY8qC60aZJJ
         zJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136684; x=1718741484;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qjr4bFDIJ+rHSyjjaa7KT8dWhd5ireGzkoHLGps+PSs=;
        b=i9yLVy4UOW4REprV4tP5xlGEiqHbmgiNKb7cCZ4PN9tlMuGCJf9g0qvcXq2BMavjb2
         s3TH1isMgKd7kkDk2hHonRi51FLEOG0C0CAdh0vbn7+e73Dd899nLr4YtetweyTCD9hx
         jzMI1mYtgcPCUk5kNL/YzObAufjKtP/FxjP2aTrnloSy9V8UpJtltQZA7WI9ixXFxVyx
         8YfX9CjlTk0lh01mvvihIjefSNGS5KW1RGrUGn/k9q84EaOwVsWzxJBTIOEbZG9Ou7X9
         wv8Z8BKnoug62dNG3A7IJ55mxiruazmIr6V1Rxj5N0nvl3mnlpOES1zeJuSKBqCNhfd7
         xr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEnesFBK6mZ8u08xPUI064zB16CHmAz99ak9YD+FwUYKXcNbt0+QsgBKFNtR2vJTTmRanNy/6lsuw8KZ1AkpePdsNEOCkJDvOz9wP8
X-Gm-Message-State: AOJu0Ywmn7bh1oo8WuWH0vmkAOFJ/c+uZYs5S6v4xOjhot6sqVlSeTVs
	T0DGG6SLzc5EiNecuTMw73rBScuTgOqwka1AzTDomONF3LYKv1sxA8NNU5OTCvg=
X-Google-Smtp-Source: AGHT+IFz1Ms0snKjZtG9L+HNZ1t6P1akSp4QJpXcnWnIlLYJv61LFdwm5UM+mEJAFbBnr90b6HVUUw==
X-Received: by 2002:a05:6830:e82:b0:6ef:9ec1:2bf8 with SMTP id 46e09a7af769-6f9572dcbefmr13810482a34.23.1718136683902;
        Tue, 11 Jun 2024 13:11:23 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-440c9fed96asm22522311cf.17.2024.06.11.13.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 13:11:23 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:11:20 -0700
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
Subject: [PATCH v4 net-next 0/7] net: pass receive socket to drop tracepoint
Message-ID: <cover.1718136376.git.yan@cloudflare.com>
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

V3->V4: adjusted the TP_STRUCT field order to align better, suggested by
Steven Rostedt.

V2->V3: fixed drop_monitor function signatures; fixed a few uninitialized sks;
Added a few missing report tags from test bots (also noticed by Dan
Carpenter and Simon Horman).

V1->V2: instead of using skb->cb, directly add the needed argument to
trace_kfree_skb tracepoint. Also renamed functions as Eric Dumazet
suggested.

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



