Return-Path: <linux-kernel+bounces-284337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218A595000C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98EB1F233C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BFA14D28F;
	Tue, 13 Aug 2024 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZHsKWfs7"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EF713BC3D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538404; cv=none; b=qifBQWEXjU0F8nlpXn9TCVGOPg5ELaZfIY6rmonmBJTu6I0vvxOLXsxBb7q/kLxOqv9Uh2/18HvFqy1al28jGffCw4P4MSHRHJJx60Rtrno9yYm6XR6PTcT0QyAhyOtm5CFr+wk4ByfqfIHkG+SRE5Fu9ErdA1tnGId2ML0g31k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538404; c=relaxed/simple;
	bh=h+dDRWN8jV1nwMrGh+WAeD+/RlJnf+Y+F73/jQ+w7EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzPUPP4v1PFOdYiNzr73oMjfpv0/2roPnmVlAHfnCeT4SrstiZBj72sbpvhvt/Ut7+UxkTvSH2PbuHcvzvCjyQl9F//jiIAUPS+4mDMq9AkkmjxJY5UZiAvH8Fut8A1M8rLzc6TpMOHuoyHmwdMoaQHdbd7DWKLm7II6lx4zN0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZHsKWfs7; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b7a3e468a9so35720416d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 01:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723538402; x=1724143202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfIvxCWgLL4atIJlIA0PqbGSOJqgAf1LTciUfWWJUn8=;
        b=ZHsKWfs7XtacxS/e4HWnhLfpJeF1dQI15r6Gs+SssFzW1ORp9CSZbLkX+hPNmtz1dI
         V/lKHrB3TsgX8KaIlDbgXULOr+QMVyve7FGhCEdOpMzW50ZHiBDmeqtCdpCfKixVqWD5
         5LWzxX4XqIisrqFfOshRHqnT26ZngO/8W9Ofc2CqNzF8YR2uslGYCV7JWJ13iJRSywjP
         IxsvzFhdPlhFF/JnUoJzWVYzIdQVNb2KxpFfMSwvEFXT2sZ9przycdnLBZyTnjglCt4/
         aAnWg8QyMuVtxMlIa3PyPKlJROi745DjcQvbz/HiBkixIKxV/AxIC7aBz/jcE0tM9gvZ
         cwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723538402; x=1724143202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfIvxCWgLL4atIJlIA0PqbGSOJqgAf1LTciUfWWJUn8=;
        b=ejtNbvGy67gZv3T7B0zF1N66nm2LJx813ONKQbIDW97/8uELHqJrrlEpMlSjPW4k9T
         bYpf3CS9goV5BfBtws6V+2A5CbGMKmoJtTX16um3ID5ctXfPKXlkmReeYHWV6hW3MKnS
         XsrwUcsZWDN/wO5NGikOYB09o9JFsJPrEa+E8ciOdFIUPBEFZ/wU+LhWTUKRS1pIvsRs
         lgpKNwtQRXtmZxgNyNUjtREypgx87fJWeiSVHc+7SaIHxCQnQAJ3iXSNT8UNeItr8H6A
         oe5f128td9gGPTBJWBo588sLi7tFQE5B+dHoLbLAIacFTYyNxbOjtPYtxicOv/An/G0z
         tKyA==
X-Forwarded-Encrypted: i=1; AJvYcCUb9StGeg/HXLxxp/JHNj61WPgpq3oJfy1T2mWTwofMWewUNIveTRJ24/i+VyD5pXzjlILJNOUIq2KDoNFQyTabcAgJmeVd0QlFcEgW
X-Gm-Message-State: AOJu0YyNNnBCWHGV8nPDooSjF2w/yCuOWJYuXm+A05N2zPSQa20C7fb4
	unfzh9J3MDWTT8HTkNmB9zX6JYLCESBRLtlz6Tq4Rysp81nIuTabE43VioMjU8CTtikprcxWRxQ
	uqISP2G0+J9/AaEtMcJPLFB6TS1j9t2VGQPaw
X-Google-Smtp-Source: AGHT+IF5vZpwMEwyKOsMjByGok50VQq9OHjXt2iZMdoR51xqc5PshbKjWlTOU09k9dSw6zDIWNspGRLkyEdh4LkEteM=
X-Received: by 2002:a05:6214:4410:b0:6b5:e2da:8bec with SMTP id
 6a1803df08f44-6bf4f89a375mr28560176d6.55.1723538401526; Tue, 13 Aug 2024
 01:40:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805212536.2172174-1-almasrymina@google.com>
 <20240805212536.2172174-8-almasrymina@google.com> <20240806135924.5bb65ec7@kernel.org>
 <CAHS8izOA80dxpB9rzOwv7Oe_1w4A7vo5S3c3=uCES8TSnjyzpg@mail.gmail.com>
 <20240808192410.37a49724@kernel.org> <CAHS8izMH4UhD+UDYqMjt9d=gu-wpGPQBLyewzVrCWRyoVtQcgA@mail.gmail.com>
 <fc6a8f0a-cdb4-4705-a08f-7033ef15213e@gmail.com> <20240809205236.77c959b0@kernel.org>
 <CAHS8izOXwZS-8sfvn3DuT1XWhjc--7-ZLjr8rMn1XHr5F+ckbA@mail.gmail.com>
 <48f3a61f-9e04-4755-b50c-8fae6e6112eb@gmail.com> <20240812105732.5d2845e4@kernel.org>
 <7e2ffe62-032a-4c5e-953b-b7117ab076be@gmail.com> <71260e3c-dee4-4bf0-b257-cdabd8cff3f1@gmail.com>
 <20240812171548.509ca539@kernel.org>
In-Reply-To: <20240812171548.509ca539@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 13 Aug 2024 04:39:47 -0400
Message-ID: <CAHS8izPyGwe_i4eNemW+A+MgMVHqJ0fdp=+-ju2ynqgc0mb_Ow@mail.gmail.com>
Subject: Re: [PATCH net-next v18 07/14] memory-provider: dmabuf devmem memory provider
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 8:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> BTW, Mina, the core should probably also check that XDP isn't installed
> before / while the netmem is bound to a queue.

Sorry if noob question, but what is the proper check for this? I tried
adding this to net_devmem_bind_dmabuf_to_queue():

if (xdp_rxq_info_is_reg(&rxq->xdp_rxq))
                 return -EEXIST;

But quickly found out that in  netif_alloc_rx_queues() we initialize
all the rxq->xdp_rxq to state REGISTERED regardless whether xdp is
installed or not, so this check actually fails.

Worthy of note is that GVE holds an instance of xdp_rxq_info in
gve_rx_ring, and seems to use that for its xdp information, not the
one that hangs off of netdev_rx_queue in core.

Additionally, my understanding of XDP is limited, but why do we want
to disable it? My understanding is that XDP is a kernel bypass that
hands the data directly to userspace. In theory at least there should
be no issue binding dmabuf to a queue, then getting the data in the
queue via an XDP program instead of via TCP sockets or io uring. Is
there some fundamental reason why dmabuf and XDP are incompatible?

--=20
Thanks,
Mina

