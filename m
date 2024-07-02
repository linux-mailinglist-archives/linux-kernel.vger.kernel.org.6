Return-Path: <linux-kernel+bounces-237825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95383923E95
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21934B26D40
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEEE19DF6C;
	Tue,  2 Jul 2024 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P2e3SWN+"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEA115CD7A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926081; cv=none; b=MwhCOD4u4jHI0SIEENsxlfNOuiCZ7dh6taxskEAaNKVncGdSCYwywHT4V44++knxDiTunZeYoBb9hfNnK/Nab6vQ/JegN17NV0LtMtXDXYTUkm0zHpSliV5UFFuhWU33gwhWrViyzMC9ZVeNj9q+imqBwmqXK04YxJduREiX6QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926081; c=relaxed/simple;
	bh=qcbSk1txeKGjtUgrI5TEa2OFa9eUbMFBvTxpismD3E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQPRikielt0qeu4OBhlCnIp7QQLdd4/YXnFAXzRxNRqbfLHHu1Pq+LKCFL1FW9IU7QeZX1Ooh242+uR1HWZoDq4rtxe6z2iwBqSfgUkfrYI2IySFOCyrRBEspwa86XS7XemRScigLR5J1rPwyJl+nmLdPmOsGAtG+K9bLoh4c84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P2e3SWN+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58c0abd6b35so4016a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 06:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719926078; x=1720530878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcbSk1txeKGjtUgrI5TEa2OFa9eUbMFBvTxpismD3E0=;
        b=P2e3SWN+yseDMp90p9VEzZHdkGUJX9Ld0Lj6dP8ekUsLe8WFMUvAkLLe78MDS5i4EN
         tR404H/0eeBkXwqz6cEs0wa8kKW0z3UTY4UZ/Z2VHDf9iA94POb9ISGx+gxT15YkEzv/
         WmZ3qHVASbx8qKTwDFYpM8WY0IUd7M0XZYIHHxmOLGp3HsBz1gJM+bvXXvIKLLEq51UY
         UK2jscCD6GaFo29bpNziVw68wgEtOjjhlNCcjACm1kB3mVAzPq17QH7ewZq15jN4VR3Q
         SxTV1baqz7uqrV15hW4+z0toLL/X1R4jw8Cgsc0bmvj2xTdgtrRgIRz5fH/9T2GwHcum
         MWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719926078; x=1720530878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcbSk1txeKGjtUgrI5TEa2OFa9eUbMFBvTxpismD3E0=;
        b=xR/W9Opd6zrpx2cuFkCfJmujpgcqFEU+HUMlHI9VsSFm/tuZ1Kdlf5zKC62DeHZAUP
         sU4TaofCW1NnuebQRJDPmiBlaFtcvz9mqZ593D8qs1UYfXeozscpsBLWXOS9em+lvChK
         UXPuIhWyTJ+B2NkeKRTNcaMkgKdCViMpg3yfjqCW6iDtXOxJMCiZu2CuTapQX/+4ogu5
         nK7Yct5lta8qc10DB7/bxSihlnANfYWVIMl8LGpDs/ghSHQjNQ1fXH4U/ubuDnk5IRUU
         6NigeYJShJdssjLTW2NS4amysop/YNXvHTAMWgf/BI7436EzgTi4YOhu1l/Tfq0T1WUa
         7V4A==
X-Forwarded-Encrypted: i=1; AJvYcCWCMefvaFd7nVh+u7YbYslrPdywHS8MVPwUbSaSglNNteQyYzob5adVWkfrYBOeHEwvfTjmoIG9gQcKg6bYWr4sER8yGqv5+hXaCeph
X-Gm-Message-State: AOJu0YzYQSYPSaF26j3tgkcggz/sev4TZgf0AwlHueEnllH4s6C7v08q
	ixK1Do5lHu+eEGYgJMScxSUFwYFST+isf3cFVpZThPgH31hpHSfSVlNPOLT8xDwrNgplzzhu+Rm
	kkwvuyNka81ocKs6E+FrumFyQ/naPnVAQX9h8jnew/SwRWAnEDg==
X-Google-Smtp-Source: AGHT+IERKkCVpVomNRYr8KNFI5e5JCBWRQ7HMLMgDv1aOW++vU+Fu31VZ6RrRqWEtIXBu1Sq7l+LYKSRxYEU9Pq/83U=
X-Received: by 2002:a50:9308:0:b0:57d:32ff:73ef with SMTP id
 4fb4d7f45d1cf-5872f79a720mr634350a12.6.1719926077342; Tue, 02 Jul 2024
 06:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628003253.1694510-1-almasrymina@google.com> <20240628003253.1694510-9-almasrymina@google.com>
In-Reply-To: <20240628003253.1694510-9-almasrymina@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jul 2024 15:14:22 +0200
Message-ID: <CANn89iJ1ys-eNyM3BGQ1PuLKsbo+Kcj78wfoAtaFPygQdYawkg@mail.gmail.com>
Subject: Re: [PATCH net-next v15 08/14] net: support non paged skb frags
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
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

On Fri, Jun 28, 2024 at 2:33=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> Make skb_frag_page() fail in the case where the frag is not backed
> by a page, and fix its relevant callers to handle this case.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

