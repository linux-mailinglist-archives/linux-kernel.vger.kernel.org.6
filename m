Return-Path: <linux-kernel+bounces-242387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5516492876C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9DF4B221B8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC49C1494CB;
	Fri,  5 Jul 2024 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuG//H9w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E87D14830E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720177287; cv=none; b=c7nLgI5q2QLxVK+GDJIyNtmczikDUIRId7JQ8/ZJ8/gVaanavrH6Zceh9bxuTzP8b8UoMu1ClJZI6t/vfD5DYjiqJK28Wy5Lrs2YolN/2EBdW7rCgQh6cHdbsU50JTiPrF1WGA0xTX++nCae1N9c4VYnftEQkhXyNZJ2/ej0umo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720177287; c=relaxed/simple;
	bh=HJLmxBNBhQfKAg6xP07Wabw1Q9MIdul+vdU7VL1GiVY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NjbnNkncomvkcoqVxdocJyFs7OHAne+oyb7+8+Hxp0sK5gwmSF3aBqZB/fFBzeu1l0CvkBKK2nyJqgQ82mcQGFpiE57z36Qa7fglsE/VEpAjfcI18JbM2bCfVA6VdytikR3POUe2zVIkvWVxBbNqnR6eokOzB0rGZ/TC1gDwdFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QuG//H9w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720177284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jsdOBGQRbEZiuJVFLzl7TXLq8jlmfbnrL+M6I+EjsqI=;
	b=QuG//H9wwJ5NbC8GiTH7qO1AXaB9xiNCSSOL9ImOMo7xDt12fGeEOa/tDbyeTPjsjZEgfV
	zdBLkdJbswlDWsCgrkh5hzp2uQQN8defcoYPLKzMMe1B+WQwLj1n5WSQjGjX8cBw+p1tjF
	j0mXmXgKU8uOsEdadpgcih21z3v4Pk8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-cthHdqghPsmGqVFW0sK6Lg-1; Fri, 05 Jul 2024 07:01:21 -0400
X-MC-Unique: cthHdqghPsmGqVFW0sK6Lg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4264dc624a5so7248545e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 04:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720177280; x=1720782080;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsdOBGQRbEZiuJVFLzl7TXLq8jlmfbnrL+M6I+EjsqI=;
        b=qHUfg5zPmZPwXmNafWMPe5HH97j2bQZTFIJZCbJYTc4S5kB+DLrSLon8TOL8tvpvxO
         Mpf8yE7oZv1G3Qa4vsn+vyL5apVWSjIX0bQtA66KYLXPPYKDOIKMfmngaztX/Bg8thiJ
         ZYU/itXf9/2bM+h30DNt7NDyTzarOa43aJgC6QlJXfg6gHJuEsgW8lHBLzOKRPxhZXkS
         k2zgICx72+yKVe8ktU+dFsfVlaEartR6QXCRRXD9ozr2Xc1n3eh1Xy288wQQkLaIcbSL
         4JjSj5l79j/4ZKFm12u5+PBAsvcNga/QmDS6eOPj1RlUHXQ1zT+ZpX2pKr7c2H58fo05
         Sw6A==
X-Forwarded-Encrypted: i=1; AJvYcCU68PmbU9ycV8tXN8tsc56kn+eOJVN7i2zbSijPVTOYHFmRzQmEBLgbMGfs6CKXP5fRQhogw/ebAFm0/kGGFO3ZK+jQPl4boB7Cba5J
X-Gm-Message-State: AOJu0YxN1rYmY6JQQ2witEpvv/MgwcKtSlwxEpc47xxlOWmlAGb0hqRk
	a9+OTWIQgWLPTiiq67/K8tvn0ArFjGB5lC1/uvzUDCu48vVR/vKL6ecjnHI4cIHwZMMGGz818Ni
	n6iuFhjls66Iuje/uxKRYQAQCbOLl9X03UFhg4HFA1WKHavsUxUDjQorrWdGStA==
X-Received: by 2002:adf:f28e:0:b0:367:4dce:1ff5 with SMTP id ffacd0b85a97d-3679dd36309mr3209444f8f.32.1720177280122;
        Fri, 05 Jul 2024 04:01:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGapJ7br0AVN/5buxgLShDBUUn055ES3+7oIVK/jWrV2wiSwwyFSGSxAPMocNKmomK6HoVOqQ==
X-Received: by 2002:adf:f28e:0:b0:367:4dce:1ff5 with SMTP id ffacd0b85a97d-3679dd36309mr3209415f8f.32.1720177279667;
        Fri, 05 Jul 2024 04:01:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36783e9faa8sm9483845f8f.64.2024.07.05.04.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:01:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2EA9E13FDC30; Fri, 05 Jul 2024 13:01:18 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Florian Kauer <florian.kauer@linutronix.de>, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com
Cc: Florian Kauer <florian.kauer@linutronix.de>, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 xdp-newbies@vger.kernel.org
Subject: Re: [PATCH] bpf: provide map key to BPF program after redirect
In-Reply-To: <20240705103853.21235-1-florian.kauer@linutronix.de>
References: <20240705103853.21235-1-florian.kauer@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 05 Jul 2024 13:01:18 +0200
Message-ID: <87zfqw85mp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Florian Kauer <florian.kauer@linutronix.de> writes:

> Both DEVMAP as well as CPUMAP provide the possibility
> to attach BPF programs to their entries that will be
> executed after a redirect was performed.
>
> With BPF_F_BROADCAST it is in also possible to execute
> BPF programs for multiple clones of the same XDP frame
> which is, for example, useful for establishing redundant
> traffic paths by setting, for example, different VLAN tags
> for the replicated XDP frames.
>
> Currently, this program itself has no information about
> the map entry that led to its execution. While egress_ifindex
> can be used to get this information indirectly and can
> be used for path dependent processing of the replicated frames,
> it does not work if multiple entries share the same egress_ifindex.
>
> Therefore, extend the xdp_md struct with a map_key
> that contains the key of the associated map entry
> after performing a redirect.
>
> See
> https://lore.kernel.org/xdp-newbies/5eb6070c-a12e-4d4c-a9f0-a6a6fafa41d1@linutronix.de/T/#u
> for the discussion that led to this patch.
>
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> ---
>  include/net/xdp.h        |  3 +++
>  include/uapi/linux/bpf.h |  2 ++
>  kernel/bpf/devmap.c      |  6 +++++-
>  net/core/filter.c        | 18 ++++++++++++++++++
>  4 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index e6770dd40c91..e70f4dfea1a2 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -86,6 +86,7 @@ struct xdp_buff {
>  	struct xdp_txq_info *txq;
>  	u32 frame_sz; /* frame size to deduce data_hard_end/reserved tailroom*/
>  	u32 flags; /* supported values defined in xdp_buff_flags */
> +	u64 map_key; /* set during redirect via a map */
>  };
>  
>  static __always_inline bool xdp_buff_has_frags(struct xdp_buff *xdp)
> @@ -175,6 +176,7 @@ struct xdp_frame {
>  	struct net_device *dev_rx; /* used by cpumap */
>  	u32 frame_sz;
>  	u32 flags; /* supported values defined in xdp_buff_flags */
> +	u64 map_key; /* set during redirect via a map */
>  };

struct xdp_frame is size constrained, so we shouldn't be using precious
space on this. Besides, it's not information that should be carried
along with the packet after transmission. So let's put it into struct
xdp_txq_info and read it from there the same way we do for egress_ifindex :)

>  static __always_inline bool xdp_frame_has_frags(struct xdp_frame *frame)
> @@ -257,6 +259,7 @@ void xdp_convert_frame_to_buff(struct xdp_frame *frame, struct xdp_buff *xdp)
>  	xdp->data_meta = frame->data - frame->metasize;
>  	xdp->frame_sz = frame->frame_sz;
>  	xdp->flags = frame->flags;
> +	xdp->map_key = frame->map_key;
>  }
>  
>  static inline
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 35bcf52dbc65..7dbb0f2a236c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6455,6 +6455,8 @@ struct xdp_md {
>  	__u32 rx_queue_index;  /* rxq->queue_index  */
>  
>  	__u32 egress_ifindex;  /* txq->dev->ifindex */
> +
> +	__u64 map_key; /* set during redirect via a map in xdp_buff */
>  };

Maybe make the comment a bit easier to understand? Something like "key
of devmap/cpumap entry that is executing"?

-Toke


