Return-Path: <linux-kernel+bounces-202210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C562A8FC934
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D712822B0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52FC191478;
	Wed,  5 Jun 2024 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJCvmtGz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AB118FDD8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583864; cv=none; b=tYvCc62nGmf3UjZKAVCIPnGatiOwvZVyjCfIUI/lbRm2UDcdl0aYb8UmxhP9b/Q2ZOfOyNQiuoLGDgA4gK6oDAqgHmk10kqrE7+8iUNSNHtQ1z5dHdtTxdfmUYE0yDRVbnMgY/kIQ1d01bhPLBcK9eBU923biQk+/B+kE8wgbUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583864; c=relaxed/simple;
	bh=mhePjjOWJijsByiVLZ5nqSDunxe3JEHHTJ2OBLVs9LY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SdYKnAmIYl2kwKZ3/HNcPI0MdOs90oMhG6IsXQ3I/Tr64WMUk1rx4cUrRIiYBBeuFlzK7rnZF75Kiwragm28/rpbiRVQhGhwCOLeYixkiykNTMPVuRwAmJVSH+ZcsAXgNTGYgAt+K6vWgmsIykqjpVUDQm/79Jo+HMY3u30DCcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJCvmtGz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717583861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HOuK2cqI4c7KL2BWpDNCdpK3QljK3hDq+BToleThPj0=;
	b=NJCvmtGzmsancJ9ZXRp/qfp68yHA8MjBFKRkJzHPor/JgdItjjRwNKRfybdVozrqAdUs5p
	uzj01+Eekr8NFecqsAMR3EtZwNCwRcQY48tOfeohPqh4nOumvqwNsWA8hUh1bWgO2y1FZI
	tDGrD88+2rfHNJ0JNXFlOHVoceSGx+A=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-K0oYcvxfPI2Egdg1cc6IWQ-1; Wed, 05 Jun 2024 06:37:39 -0400
X-MC-Unique: K0oYcvxfPI2Egdg1cc6IWQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52b890339d9so4414051e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 03:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717583858; x=1718188658;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOuK2cqI4c7KL2BWpDNCdpK3QljK3hDq+BToleThPj0=;
        b=ZMYChKp/EFRKrNztWkIgfISxGA+nR5934SNcwv7yjMUYphOu9cnaa6fFpS3JQjj2pp
         2How2zK8X+5fKL5uM6XHf25EdytiUFKS4gV216AfpWNZeSVJPp0FIIx5qPTVfMAUM4HI
         t38cTUdPF+SyGhh9DzSVq+W3xMV0EyCOKOyw/1oZBOG+3T20KQZfvExZ1WewtmXBvOxf
         ViK0V62i4MfbrXSCOZ4SPcxKNEK0O7AwpaQMV6pFJY1WpNdPyS4BQiWj889nUgMoAm1B
         dalUz2sggYgU7rvalzE+11OFk/vDEBw7XV2d3JkG8BPxSR3/ioougk8G8Bev8egIgh9L
         R6Ng==
X-Gm-Message-State: AOJu0YzhhndiztHcJW3iscY63Gd5+YDCScqsP3lvLngKA8Szi6P2jFUS
	7IBNONQWP2UVZVBzGylGyIpsGXdIkvYKY6TnP4GJMogwThwIWEAVRuip3TpbrPUtThsD5wSQgd6
	S7HOa53xuS0o/9lQiL5ZbzxmFtqSVZwx3gcfkEnpKVw1iE97tS1nrH+6yg65qng==
X-Received: by 2002:a05:6512:110f:b0:52b:8435:8f26 with SMTP id 2adb3069b0e04-52bab4f43b5mr1651649e87.44.1717583858221;
        Wed, 05 Jun 2024 03:37:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIB3f5h9VIv9ftObM90qzaaplOueJP9zCegw13CgZoRfjLUxHIuKEU/8+3apf8GnzLwLliRQ==
X-Received: by 2002:a05:6512:110f:b0:52b:8435:8f26 with SMTP id 2adb3069b0e04-52bab4f43b5mr1651629e87.44.1717583857818;
        Wed, 05 Jun 2024 03:37:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d8e405sm1762081e87.284.2024.06.05.03.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 03:37:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DBBEE1385513; Wed, 05 Jun 2024 12:37:36 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v3 net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
In-Reply-To: <9afab1bb-43d6-4f17-b45d-7f4569d9db70@kernel.org>
References: <20240529162927.403425-1-bigeasy@linutronix.de>
 <20240529162927.403425-15-bigeasy@linutronix.de> <87y17sfey6.fsf@toke.dk>
 <20240531103807.QjzIOAOh@linutronix.de>
 <9afab1bb-43d6-4f17-b45d-7f4569d9db70@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 05 Jun 2024 12:37:36 +0200
Message-ID: <871q5bad5b.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 31/05/2024 12.38, Sebastian Andrzej Siewior wrote:
>> On 2024-05-30 00:09:21 [+0200], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> [...]
>>>> @@ -240,12 +240,14 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_m=
ap_entry *rcpu, void **frames,
>>>>   				int xdp_n, struct xdp_cpumap_stats *stats,
>>>>   				struct list_head *list)
>>>>   {
>>>> +	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
>>>>   	int nframes;
>  >>
>>> I think we need to zero-initialise all the context objects we allocate
>>> on the stack.
>>>
>> Okay, I can do that.
>
> Hmm, but how will this affect performance?

My hunch would be that this would be in a cache line we're touching
anyway, so it won't make much difference? But better measure, I suppose :)

-Toke


