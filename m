Return-Path: <linux-kernel+bounces-322577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30026972B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51A41F250DF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26AF1865E1;
	Tue, 10 Sep 2024 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxdSSrC2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A69185B51
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954132; cv=none; b=OfHTz5N2XGZ7Zw94tCSjLodpw7LdU+nAFjOv05byu++MwtKytcQOr3NdrFMFkM8TdGNSRpvfFXvwapHY/mR3+w1Gtyf34oKp+Og+vNyApZ2GCGfLAAe4YZ7KY4EITeqcCP4z8TX8pHz5e/IBNsl+87uxZR1aaYyTioUSgPEIbQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954132; c=relaxed/simple;
	bh=Qyl+jeM29UcIUIpBkMaXSrvyQbplQx2dePM9hleo3fk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mukg3XoaeVf/RlQVjhScHAE156JlTgSoWeq6ZU8vp4asRpRXYorWJ0R4Z2ZMlSdM9WzlWNPm9XfLsmXsFkvJ35v7LRzh96b99P78l/6GqEGntzJlinGXdmlJFvvh0mg9bHFeeTerGa0UcQNIV6jPppy5hCd33yIIS0eJGljmE/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxdSSrC2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725954129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vuOGAWKRYAVrkFr1NxQHAvJfBsIuxorao5YMycZLxA4=;
	b=fxdSSrC2brIzX5y+XbwI4AQ3s8a1G2kvC67BNnKAVAgDFtA2uYAOwmMgVi9sLn2hDc57UG
	Ho4Xwj8gGeK4VWON50zUwNxbtovwhf7L/WNCp4Itd4D1vfR1hPe2uuEwLKVB/cNPShSTIY
	v+mtfE23uRWJrAhkdZaZOVYRVfHAtqM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-FhjREanKPDSVS8I84y2esg-1; Tue, 10 Sep 2024 03:42:07 -0400
X-MC-Unique: FhjREanKPDSVS8I84y2esg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c25680de68so256406a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 00:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725954123; x=1726558923;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vuOGAWKRYAVrkFr1NxQHAvJfBsIuxorao5YMycZLxA4=;
        b=abMc4iZ/qrZFKafvGf0GfIOJxq3lECDanPoCRxiSeLdRo3yY+p3jLa56MCDGM3kYaJ
         5X8CHTAf+nq4xFFIZx3WkOa5s2mOwn54PvcFJ31fVAAJ18oi57KzefTQKP+wbEf1w18v
         dW+QGC6cmHLuKr20XcFe/cCZ1LRM0cfs4qYFH+FrNi7BnUqXIYNFSOWtL1aOnpwaFwBr
         tCu60eM18PeTPux0ku50bVVM6OvoNykiVSWA2zovtdng/gySFJ7Id/4+FsUj1vvr8E42
         0E1KjS70zMqvF4sJuj+8KDWdGxL6DaHfUmM94ZvvBnLhADWkS6uEETBfk0iEuWGjkO7U
         D/0A==
X-Forwarded-Encrypted: i=1; AJvYcCXCH9Juvd0+9hY03l/4yzi+/gWH/+IRXKsdKgyaw88QsuERVjdHlBuuuEojd91uSe/e0oyfaYK2r+QUIX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye/6mVGXCRObxVvxIY1WSaT0nGmMgy/fWxmf2doTQc5s6tdjze
	6BjkgAhqrpzYNTU0LwynGSMjaVPIqelb2gMIhtG/tgxBzk61wWpFaWcjCsr+prfzsOLLhrWDJv2
	trBw4UIw0Zqqu4pE2e2zQagbpFw91uWfB9G4yBxBPskerxmSP+8UeijkZuWjMMg==
X-Received: by 2002:a17:906:d555:b0:a86:9fbd:5168 with SMTP id a640c23a62f3a-a8a885be012mr934459966b.10.1725954122693;
        Tue, 10 Sep 2024 00:42:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlH0u6x8kCMDvPcDbginVMnhXO4lApiSQpceWmr1sBGfZmmYznkDhVeEEVWw9Lf1VtTtVaBw==
X-Received: by 2002:a17:906:d555:b0:a86:9fbd:5168 with SMTP id a640c23a62f3a-a8a885be012mr934451466b.10.1725954121495;
        Tue, 10 Sep 2024 00:42:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cf03fcsm438718266b.162.2024.09.10.00.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:42:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 18BC7152C346; Tue, 10 Sep 2024 09:42:00 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Florian Kauer <florian.kauer@linutronix.de>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, David Ahern
 <dsahern@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, Mykola Lysenko
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
 linux-kselftest@vger.kernel.org, Florian Kauer
 <florian.kauer@linutronix.de>
Subject: Re: [PATCH net v3 2/2] bpf: selftests: send packet to devmap
 redirect XDP
In-Reply-To: <20240909-devel-koalo-fix-ingress-ifindex-v3-2-66218191ecca@linutronix.de>
References: <20240909-devel-koalo-fix-ingress-ifindex-v3-0-66218191ecca@linutronix.de>
 <20240909-devel-koalo-fix-ingress-ifindex-v3-2-66218191ecca@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Sep 2024 09:41:59 +0200
Message-ID: <87seu8dkfs.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Florian Kauer <florian.kauer@linutronix.de> writes:

> The current xdp_devmap_attach test attaches a program
> that redirects to another program via devmap.
>
> It is, however, never executed, so do that to catch
> any bugs that might occur during execution.
>
> Also, execute the same for a veth pair so that we
> also cover the non-generic path.
>
> Warning: Running this without the bugfix in this series
> will likely crash your system.
>
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> ---
>  .../selftests/bpf/prog_tests/xdp_devmap_attach.c   | 114 +++++++++++++++++++--
>  1 file changed, 108 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
> index ce6812558287..3da45f719736 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
> @@ -1,6 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <arpa/inet.h>
>  #include <uapi/linux/bpf.h>
>  #include <linux/if_link.h>
> +#include <network_helpers.h>
> +#include <net/if.h>
>  #include <test_progs.h>
>  
>  #include "test_xdp_devmap_helpers.skel.h"
> @@ -17,7 +20,7 @@ static void test_xdp_with_devmap_helpers(void)
>  		.ifindex = IFINDEX_LO,
>  	};
>  	__u32 len = sizeof(info);
> -	int err, dm_fd, map_fd;
> +	int err, dm_fd, dm_fd_redir, map_fd;
>  	__u32 idx = 0;
>  
>  
> @@ -25,14 +28,11 @@ static void test_xdp_with_devmap_helpers(void)
>  	if (!ASSERT_OK_PTR(skel, "test_xdp_with_devmap_helpers__open_and_load"))
>  		return;
>  
> -	dm_fd = bpf_program__fd(skel->progs.xdp_redir_prog);
> -	err = bpf_xdp_attach(IFINDEX_LO, dm_fd, XDP_FLAGS_SKB_MODE, NULL);
> +	dm_fd_redir = bpf_program__fd(skel->progs.xdp_redir_prog);
> +	err = bpf_xdp_attach(IFINDEX_LO, dm_fd_redir, XDP_FLAGS_SKB_MODE, NULL);
>  	if (!ASSERT_OK(err, "Generic attach of program with 8-byte devmap"))
>  		goto out_close;
>  
> -	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
> -	ASSERT_OK(err, "XDP program detach");
> -
>  	dm_fd = bpf_program__fd(skel->progs.xdp_dummy_dm);
>  	map_fd = bpf_map__fd(skel->maps.dm_ports);
>  	err = bpf_prog_get_info_by_fd(dm_fd, &info, &len);
> @@ -47,6 +47,23 @@ static void test_xdp_with_devmap_helpers(void)
>  	ASSERT_OK(err, "Read devmap entry");
>  	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to devmap entry prog_id");
>  
> +	/* send a packet to trigger any potential bugs in there */
> +	char data[10] = {};
> +	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> +			    .data_in = &data,
> +			    .data_size_in = 10,
> +			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
> +			    .repeat = 1,
> +		);
> +	err = bpf_prog_test_run_opts(dm_fd_redir, &opts);
> +	ASSERT_OK(err, "XDP test run");
> +
> +	/* wait for the packets to be flushed */
> +	kern_sync_rcu();
> +
> +	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
> +	ASSERT_OK(err, "XDP program detach");
> +
>  	/* can not attach BPF_XDP_DEVMAP program to a device */
>  	err = bpf_xdp_attach(IFINDEX_LO, dm_fd, XDP_FLAGS_SKB_MODE, NULL);
>  	if (!ASSERT_NEQ(err, 0, "Attach of BPF_XDP_DEVMAP program"))
> @@ -124,6 +141,88 @@ static void test_xdp_with_devmap_frags_helpers(void)
>  	test_xdp_with_devmap_frags_helpers__destroy(skel);
>  }
>  
> +static void test_xdp_with_devmap_helpers_veth(void)
> +{
> +	struct test_xdp_with_devmap_helpers *skel = NULL;
> +	struct bpf_prog_info info = {};
> +	struct bpf_devmap_val val = {};
> +	struct nstoken *nstoken = NULL;
> +	__u32 len = sizeof(info);
> +	int err, dm_fd, dm_fd_redir, map_fd, ifindex_dst;
> +	__u32 idx = 0;
> +
> +	SYS(out_close, "ip netns add testns");
> +	nstoken = open_netns("testns");
> +	if (!ASSERT_OK_PTR(nstoken, "setns"))
> +		goto out_close;
> +
> +	SYS(out_close, "ip link add veth_src type veth peer name veth_dst");
> +	SYS(out_close, "ip link set dev veth_src up");
> +	SYS(out_close, "ip link set dev veth_dst up");
> +
> +	val.ifindex = if_nametoindex("veth_src");
> +	ifindex_dst = if_nametoindex("veth_dst");
> +	if (!ASSERT_NEQ(val.ifindex, 0, "val.ifindex") ||
> +	    !ASSERT_NEQ(ifindex_dst, 0, "ifindex_dst"))
> +		goto out_close;
> +
> +	skel = test_xdp_with_devmap_helpers__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "test_xdp_with_devmap_helpers__open_and_load"))
> +		return;

This should be 'goto out_close'.

-Toke


