Return-Path: <linux-kernel+bounces-214342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D948490830F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7132928416C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A713A1474CF;
	Fri, 14 Jun 2024 04:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MrXkLg84"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AC5146D65
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 04:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718340040; cv=none; b=obeEo7n2VL8ZuWJ/XGnNBYhK4xd9fri0BPOKg3SfOQXyntwB/F7qxRehSdKpsIK2f5iZTkapNSYq7TY4WCC4Q/c+jayPtR5J+QLYLjnOK+7OTruxG78dIbtBCys3oh1aXs9Qzlga62joDKNKnwvJh7y+aFOLrBKwIX2g73oyLK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718340040; c=relaxed/simple;
	bh=eNn5sF/0OujnxZsAQT7n4zaO4fElnsdrJ3NYPpfOQHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slvEtx1G32GmXzdTh+Vx5LyDn8oeX+bhUV5CLqx8S7aIaULe8lx4rSPoTk1LaYY7G34agVSeVnfP/Xxv8/4nw7dgV3ntqXn2WgsIki/0ew1XPzRUX2LYC40p4NRa4BJZeDX5T9FnFzvrOa1+YQ1u8ymbB5sXeIpGZ1pvv0OqhJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MrXkLg84; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52c82101407so3198668e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 21:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718340037; x=1718944837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kR7b6aZyZ2ErhsA0LvgqlgbPkmTng+vkDIc2255311w=;
        b=MrXkLg84ZY8N2IswP1VtCmWEMTWgpWhAr/qg3y8gs/+8Wx/oebkTeiuJu+6sJ1EvEw
         YD+tIMD0SMCaEoPpULoSZLbbWootuBMNRs9rOQF1RUN1mihgSq5XfzJQ7aVPG8BaWahT
         FqvAnprGnMXDtl7l2CZ0Zy5UyQRJ/oINfqieGSf2YX2j724AcEsQSRKj2jHxlAGXBSNl
         8jkIVFH9GtMS2wGn5UfBZ4Ziqg9DgOtozLEmmt0Xv/uLq6j72M6kfLPFfEe9qkYaeNV7
         6M8cPpy9I8Hm4BN12Z9kO8m5CdMyJ2SOzblaIDSJ6wuinw8Oz/OD5Rl4ertjC0OOVXI5
         zuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718340037; x=1718944837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kR7b6aZyZ2ErhsA0LvgqlgbPkmTng+vkDIc2255311w=;
        b=EXVEXJsmoy3llRxee+MK2p6iDtNGss+v+PLOti9TO10X5J0hZ+Qu0yCemXMEDobgJ3
         onUp1Nw6BAc4Few/RHnA7ZHs3Gs8bvTFusE6lQR0si6oNk2kl0whI8zUWREvmxqBTYxe
         DbaTMUufQUX2guSwbXGNuJT415dhdKtbLcApHdsIURzC2jIZOlfhxaXoez0SxDfZOn56
         LYIvrNo2LaKSNnVSyA7R+L68/sOlC5di95qfLwlpkHmHo7+DUS5wJLV8tPHWj/u3fO2h
         OVclNJDJm0M99Wh5o0WEpk54UTDnxWP8CEWXUimVNNDP+R6CZnMaHrmzU4jqNIDLs8dy
         V2Pw==
X-Forwarded-Encrypted: i=1; AJvYcCW+S+0MDQSjm8usz/BqjXcSiMbNNVnodvRVnIf2aNBK9J79Lj7okFlEyR0S42tIT+XeOGY5rsSSn8UhYFqrOFo4U7tsX0DfVLLk7gME
X-Gm-Message-State: AOJu0YwEQmDB8icaJZBKAc0Mbft+tjP0Xa4VwKRl1LSPklrXy7EqWPyi
	WQeMjMjU+ZGDRiARbBv6/tuBavFxmBjHFueajc/bRU/pSfYxcIEEgd/gtPWqk6o7FIJCIkMCT/8
	OaXcyIX8IuJ/f9rcSCJZ5MptaiYLHDy08c86v
X-Google-Smtp-Source: AGHT+IF+QwVsnGgzoMf0Qw+xtz4R8CDXmuxU4LRGzv8WS6/BQHNgwgM8v9u52HDoANwX7UmBcb4VUEBhXtKfrjHouB0=
X-Received: by 2002:a19:6449:0:b0:52c:84ac:8fa2 with SMTP id
 2adb3069b0e04-52ca6e56eb8mr1005405e87.7.1718340036348; Thu, 13 Jun 2024
 21:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613013557.1169171-1-almasrymina@google.com> <20240613183453.2423e23b@kernel.org>
In-Reply-To: <20240613183453.2423e23b@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 13 Jun 2024 21:40:24 -0700
Message-ID: <CAHS8izNqMOAONExpBwtJBqseRnyv+ukw5LbFdevQXD4zc+7thg@mail.gmail.com>
Subject: Re: [PATCH net-next v12 00/13] Device Memory TCP
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 6:35=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 13 Jun 2024 01:35:37 +0000 Mina Almasry wrote:
> > v12: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D8597=
47&state=3D*
>
> patches 5 and 6 transiently break the build
>
> ../include/trace/events/page_pool.h:65:23: error: use of undeclared ident=
ifier 'NET_IOV'
>    65 |                   __entry->netmem & NET_IOV, __entry->pfn, __entr=
y->release)
>       |                                     ^
> ../include/trace/events/page_pool.h:91:23: error: use of undeclared ident=
ifier 'NET_IOV'
>    91 |                   __entry->netmem & NET_IOV, __entry->pfn, __entr=
y->hold)
>       |                                     ^
>
> Looking at NIPA status the builders are 12h behind, so please don't
> repost immediately. This series takes a lot of compute cycles to build.
>
> FWIW there is a docker version of NIPA checks in the nipa repo.
>
> https://github.com/linux-netdev/nipa/tree/main/docker
>
> IDK if it still works, but could help avoid mistakes..

My sincere apologies. I have trouble with the patch-by-patch
allmodconfig build being very slow on my setup with the headers I'm
touching, and I've been running into false positives with the C=3D1 &
W=3D1 checks. I've been trying to look at the nipa scripts and porting
them over to my setup. I'll take a look at the docker image and if
not, at least make sure the patch-by-patch allmodconfig with C=3D1 and
W=3D1 is working.

--=20
Thanks,
Mina

