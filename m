Return-Path: <linux-kernel+bounces-258933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30448938EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D201F21CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD8216D4C0;
	Mon, 22 Jul 2024 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+F8P651"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F741754B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 12:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721649847; cv=none; b=mTA4p4Vi1QRPxzk8HNrS5L1ej8Qsiji91rEbf1GxCwWK3l06BdHDCLEDR3SE7hR53UuyqsBuWHY5FQg3adazxx7LGJ0dzdCY+ZJVYg+USjZv7Nhjzsg2V1cig8hqmLwBy3fakenGuKX1rAN/kztOnX2du2tTuOU8uKQh5yE5idg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721649847; c=relaxed/simple;
	bh=+poxpydFNsDN9+rLYnkNysjpro6vmt+U1yehTFBYSzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oz8BUqJd+dDIVh6vEEOtC2/+5LcUh7W5uYxwJAdY1+gOH6YQEssNUJCSAxmZi1mGW7HAmtVkqajLlt5gN35l2VDcUQQza2hD2wCXEssSTK/uAWVdLek42Q3tZYihybouAFS5bQSEfQzIaEX330uhzWP1dnMHZScfNbM7R0H1txc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+F8P651; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721649844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjtiCCVxlK03Sif39cATMUIQHMJq3V+Lc8eZLki69Ug=;
	b=C+F8P651XMYtJ/udq9xNoLEGwxsHkGMqO7qoNqvuD9/GfntK8T6XNKJ3lNWfO5sy3xqdYl
	0gaMtGDg88Seq6YRodk9hsM6x4a1AnFUF2x84EEqvw5j0aKjPCOHF48cZmpvAlGwes7xoA
	U/EL3iafZ38LgfqUlgVpYWkYPhCxIzM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-XMGDrCpTMZGxnLLn2NjCFw-1; Mon,
 22 Jul 2024 08:04:02 -0400
X-MC-Unique: XMGDrCpTMZGxnLLn2NjCFw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F266D1828925;
	Mon, 22 Jul 2024 12:03:23 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24C1730001B7;
	Mon, 22 Jul 2024 12:03:17 +0000 (UTC)
Date: Mon, 22 Jul 2024 14:03:15 +0200
From: Artem Savkov <asavkov@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix compilation failure when
 CONFIG_NET_FOU!=y
Message-ID: <20240722120315.GA3265959@alecto.usersys.redhat.com>
References: <20240718143122.2230780-1-asavkov@redhat.com>
 <005ef8ac-d48e-304f-65c5-97a17d83fd86@iogearbox.net>
 <CAADnVQKjgQg9Y=VxHL9jrkNdT6UKMbaFEOfjNFG_w_M=GgaRjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKjgQg9Y=VxHL9jrkNdT6UKMbaFEOfjNFG_w_M=GgaRjQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Jul 19, 2024 at 10:09:35AM -0700, Alexei Starovoitov wrote:
> On Fri, Jul 19, 2024 at 8:45 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> > Hi Artem,
> >
> > On 7/18/24 4:31 PM, Artem Savkov wrote:
> > > Without CONFIG_NET_FOU bpf selftests are unable to build because of
> > > missing definitions. Add ___local versions of struct bpf_fou_encap and
> > > enum bpf_fou_encap_type to fix the issue.
> > >
> > > Signed-off-by: Artem Savkov <asavkov@redhat.com>
> >
> > This breaks BPF CI, ptal:
> >
> > https://github.com/kernel-patches/bpf/actions/runs/9999691294/job/27641198557
> >
> >    [...]
> >      CLNG-BPF [test_maps] btf__core_reloc_existence___wrong_field_defs.bpf.o
> >      CLNG-BPF [test_maps] verifier_bswap.bpf.o
> >      CLNG-BPF [test_maps] test_core_reloc_existence.bpf.o
> >      CLNG-BPF [test_maps] test_global_func8.bpf.o
> >      CLNG-BPF [test_maps] verifier_bitfield_write.bpf.o
> >      CLNG-BPF [test_maps] local_storage_bench.bpf.o
> >      CLNG-BPF [test_maps] verifier_runtime_jit.bpf.o
> >      CLNG-BPF [test_maps] test_pkt_access.bpf.o
> >    progs/test_tunnel_kern.c:39:5: error: conflicting types for 'bpf_skb_set_fou_encap'
> >       39 | int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
> >          |     ^
> >    /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:107714:12: note: previous declaration is here
> >     107714 | extern int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx, struct bpf_fou_encap *encap, int type) __weak __ksym;
> >            |            ^
> >    progs/test_tunnel_kern.c:41:5: error: conflicting types for 'bpf_skb_get_fou_encap'
> >       41 | int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
> >          |     ^
> >    /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:107715:12: note: previous declaration is here
> >     107715 | extern int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx, struct bpf_fou_encap *encap) __weak __ksym;
> >            |            ^
> >      CLNG-BPF [test_maps] verifier_typedef.bpf.o
> >      CLNG-BPF [test_maps] user_ringbuf_fail.bpf.o
> >      CLNG-BPF [test_maps] verifier_map_in_map.bpf.o
> >    progs/test_tunnel_kern.c:782:35: error: incompatible pointer types passing 'struct bpf_fou_encap___local *' to parameter of type 'struct bpf_fou_encap *' [-Werror,-Wincompatible-pointer-types]
> >      782 |         ret = bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_GUE___local);
> >          |                                          ^~~~~~
> >    /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:107714:83: note: passing argument to parameter 'encap' here
> >     107714 | extern int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx, struct bpf_fou_encap *encap, int type) __weak __ksym;
> 
> It's a good idea to introduce struct bpf_fou_encap___local
> for !FOU builds, but kfunc signature needs to stay and
> __local variable needs to be type casted to (struct bpf_fou_encap *)
> when calling kfunc.

Casting won't work as the compiler still have no idea about struct
bpf_fou_encap.

I think I'll need to fix this by adding '#define
BPF_NO_KDUNC_PROTOTYPES' to the test. Daniel has done this for other
cases like this in the series introducing bpftool kfunc prototype
dumping (https://lore.kernel.org/all/cover.1718207789.git.dxu@dxuuu.xyz/)

-- 
 Artem


