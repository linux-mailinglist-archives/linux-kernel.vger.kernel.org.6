Return-Path: <linux-kernel+bounces-348267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC87198E4D4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56DE7283FC2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C9F21731E;
	Wed,  2 Oct 2024 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F9EBj7y9"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960A1946B9
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 21:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904261; cv=none; b=eba+u5ucWSYPH/mQDy+HSckmx/wnRGznNhn6feFzfRVqora6IPHIsiFd8K5bk7EemDkdfzKhmJDtdxOyMQ8+wgF8suA7I6Mgb4zyVS9YqanKVlQ55mcxpTJUdZQgALuLjXFB4z1/r+/i/pIxVPRvNfBT3AmAVhxXLAcW1e88r+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904261; c=relaxed/simple;
	bh=d4U3RojMz/eNE93mws2Q+0pKSf58wykiAO9y5d3i5VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWadBUpBlSinobZ3WFGBAGeAx5mnauMmHnvX7BqfpjwI4Y4COXzF6Zcj4ENKSpf5L+Af4D1GFzLKWN6akDJk2RzK9a5FoOQlXX11H0fD4U7anY2YKKfuSgbnKpYmjT5AOLNfWFTtwSftieVfJT0MEVxreOEy4LhsyC9UU659ssA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F9EBj7y9; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c4ee29b6-5dfc-44f6-af5c-02d042b42cc0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727904257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzrFlAl+U9N/Vy9YLPbpe2/5D1bNUacg3gz/EIn3Ehc=;
	b=F9EBj7y9tzDZaNghtcYY8ER48y+QN4OJ3arZmeBjwomgtm67pOgn4ruOgihm2w3Ye/X/Xk
	MThy3N76+BM9JYP/tz+ywTp6x4GfLETs4CXG4zbzwLgNtt2K6kQpxN837yhRo88IRKQeUn
	d1mk7kzQPU556EQqIB6wMrtt/YEqAP0=
Date: Wed, 2 Oct 2024 14:24:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4 2/2] bpf: selftests: send packet to devmap redirect
 XDP
To: Florian Kauer <florian.kauer@linutronix.de>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 David Ahern <dsahern@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jesper Dangaard Brouer <brouer@redhat.com>, linux-kselftest@vger.kernel.org
References: <20240911-devel-koalo-fix-ingress-ifindex-v4-0-5c643ae10258@linutronix.de>
 <20240911-devel-koalo-fix-ingress-ifindex-v4-2-5c643ae10258@linutronix.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240911-devel-koalo-fix-ingress-ifindex-v4-2-5c643ae10258@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/11/24 1:41 AM, Florian Kauer wrote:
> @@ -25,14 +28,11 @@ static void test_xdp_with_devmap_helpers(void)
>   	if (!ASSERT_OK_PTR(skel, "test_xdp_with_devmap_helpers__open_and_load"))
>   		return;
>   
> -	dm_fd = bpf_program__fd(skel->progs.xdp_redir_prog);
> -	err = bpf_xdp_attach(IFINDEX_LO, dm_fd, XDP_FLAGS_SKB_MODE, NULL);
> +	dm_fd_redir = bpf_program__fd(skel->progs.xdp_redir_prog);
> +	err = bpf_xdp_attach(IFINDEX_LO, dm_fd_redir, XDP_FLAGS_SKB_MODE, NULL);
>   	if (!ASSERT_OK(err, "Generic attach of program with 8-byte devmap"))
>   		goto out_close;
>   
> -	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
> -	ASSERT_OK(err, "XDP program detach");
> -
>   	dm_fd = bpf_program__fd(skel->progs.xdp_dummy_dm);
>   	map_fd = bpf_map__fd(skel->maps.dm_ports);
>   	err = bpf_prog_get_info_by_fd(dm_fd, &info, &len);
> @@ -47,6 +47,23 @@ static void test_xdp_with_devmap_helpers(void)
>   	ASSERT_OK(err, "Read devmap entry");
>   	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to devmap entry prog_id");
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

I am seeing pr_warn on "Driver unsupported XDP return value on prog 
xdp_redir_prog...". There is an existing bug in xdp_redir_prog(). I fixed it 
with this:

SEC("xdp")
int xdp_redir_prog(struct xdp_md *ctx)
{
-	return bpf_redirect_map(&dm_ports, 1, 0);
+﻿﻿	return bpf_redirect_map(&dm_ports, 0, 0);
}

and also wrapped the above "lo" test in its own netns also.

Applied to the bpf tree. Thanks.


