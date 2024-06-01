Return-Path: <linux-kernel+bounces-197633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99778D6D4C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 03:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE991C215C6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557CE63D0;
	Sat,  1 Jun 2024 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YZGOMqCU"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD2A55
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206166; cv=none; b=c+4fmNjqRU0gdo9F5KX+F0S87ezkFLsbSt+c5bSdHcET4G9nCngXoSULrxliAq8VhWsdASKs4f+qMWiCGrImBLa5YfTOWlyGsDdd8rXWu/gBRDm6bwzoG5kvGNgvM9yb3GJKg8ixt27UInscsPbe91++XrkRTyhWEgOlDuAX5JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206166; c=relaxed/simple;
	bh=RtPBGDrjxHAF9pAAHS4/V3G72zZ9pxbAwV6Wa1ILOXI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZXZjidhCq67JgLGA/lCVfQjWi1nXUBwsjT2ppsveRo0YGgDKu8hatZl6u9Ykh4Vfda59iQo7UwTOBYYxX0IA96itwDgCv+Ko3P0hZ+2H3sH7wyOwOqiM8Z8eo+FRrNtEnWawYBswql+3jrJBdcHt27qkp44MwBo0Io6PAAaO2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YZGOMqCU; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-627f3265898so26600387b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717206164; x=1717810964; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8cHPMeLcn44EVetD1HkMPMRNrtYI3nYnKi2QgdwWdQY=;
        b=YZGOMqCUpj0mhzwc5yc54DDa8OKa+pUngzFTy8bHBvKFF2M6l3tk6FAaVJWDLvPm0v
         9+gXSOOgYItVvXVeC7dVBU3kg9bsPxQQu0W0bXu1mhFGbafJZwx1UkmnwTN7gCu0+gfd
         fXc2XPy8FWZacnFjUZ4kYVI8cf9I4silQh5FjA3+qrN6kdGl1lUriH9Tkndta1cbq4th
         +buvxxQu4setuWfzA6lCmkbJhmv8G7eKqciiTzARQU3jEzW7om3aYhmJNMK/6/VvVKs5
         q5/U28/YR0GWrb2P88v2YL0J0dive/M6QUH7X5W5WroMXvpGqqQdMNLVCHMPRBrIcmcK
         uP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717206164; x=1717810964;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cHPMeLcn44EVetD1HkMPMRNrtYI3nYnKi2QgdwWdQY=;
        b=tL9N2TocS3ZnaUpoXGh5NzIidKQlboGRZfOtwa9N+5usT51ewfTcZl2gvT2C352YHs
         zN7QQ4WuiUq+9qlm61mynUaNg+IVoaWuij+Niq0qaMQ5vFanPbiKCnd6sFYyQMqCHXaT
         3UvN8rm5f3bVV5spi7oLbTyGh2cDeBqJUW8Z06N8Yf/nER8VJkqz6wjsVRWoLldLIeo/
         C6PxiXBV3ybwcODaIP7bjuZYaRPz8Qve7zFA5p1qf85TwFvaBfnKEbzkUCcLYhvoOYx/
         fmVdxEDN9xzhAiF3hsTAupQ/SfRbHlWlJ8P7Ui8sWWEsaTI+FCJDFywWyGLVpbp887ly
         D5fw==
X-Forwarded-Encrypted: i=1; AJvYcCWPX7e8LQIQeSX2qofDUWSk0qrSaAhfyEPJKLSNRu7ejInqDLM0+2PuEDdLe2j22WjHU2yPTZJZaMFCWinmkdf147b9bDAGGhYHej1d
X-Gm-Message-State: AOJu0Yy3mvQUxZ2wxjcPvriMxEtrC2o1Wr7yeFOdtx2omEkCUbO7FE7F
	8W02f09SobRFtbNXamtPvBFWewpdItp3KiJ8EgHpMeB3IhV4mhGe0m0b2zKrwS4=
X-Google-Smtp-Source: AGHT+IG7sanvx5FAHKJW1bxvvxPFu/J+Chdp5KgLHMLXg3dhzqi/Xmmf5bGO2qo5XX/yN4elKZ1zBQ==
X-Received: by 2002:a81:400a:0:b0:627:dca5:407b with SMTP id 00721157ae682-62c79708770mr35288347b3.13.1717206163692;
        Fri, 31 May 2024 18:42:43 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62c766c9ca5sm5321317b3.143.2024.05.31.18.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 18:42:43 -0700 (PDT)
Date: Fri, 31 May 2024 18:42:40 -0700
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
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: [RFC v2 net-next 0/7] net: pass receive socket to drop tracepoint
Message-ID: <cover.1717206060.git.yan@cloudflare.com>
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

V1->V2: instead of using skb->cb, directly add the needed argument to
trace_kfree_skb tracepoint. Also renamed functions as Eric Dumazet
suggested.

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
 net/packet/af_packet.c     |  6 +++---
 15 files changed, 57 insertions(+), 46 deletions(-)

-- 
2.30.2



