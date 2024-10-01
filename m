Return-Path: <linux-kernel+bounces-345098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BAD98B1F9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 03:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55731F2369F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1BE286A8;
	Tue,  1 Oct 2024 01:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fxMehmws"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDA63839C
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 01:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727747901; cv=none; b=GEW0kR/IuxY0wDe3fTfrGp/DB/IE7NcLm8ZlC99eb332ZXOjJyvVC33s2Ki9hRuUd0K+VQwqjTBt503LBh2bGIHNrerdM8bMSKdpRh+mhplEpuAQgoj3vyJpylZoCNZsvtHfXnxCj3Fl0Hnj+lGQPojICN8pKfOhHhk8OlYpBU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727747901; c=relaxed/simple;
	bh=8Y+WnIyKoqdfaJlKH+KC75pnTaZZbappW+5Vga7ETag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHXaOIAfPA6KNh0NYj3KnuNy31NwQGpo0T7RY2dERtGvwozKjoy8bhMNp/JvVCKbsJnlVqS8U58gRQNaeafRovZ524B52ga7R0R06f1xdr/JttNZ1ORbgMRNEl4z+6nb9j9bQ/iHK3HtjsdKz7cLOoTy1RzgqTBMLbi3lPM6UoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fxMehmws; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <075e314c-3aa5-4f7b-81f7-3bc0e055334a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727747897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lnIHn0BF5I13YOzLPkhPaKL/Qst4Kg2kv0TRJKsCPcA=;
	b=fxMehmwsRJzfvj0Vi78qAXO/boLwVzMUeDJPechQuFoncZIMJhXrwupLTgEFoSNr0fp5S6
	b+b8M7kywArhMwJCxkvx4+6kYuOAlk+Ktn4OMINxIMBtctRA79wiEicMNKknIq9eKeh6uB
	X19GsyjjZeOI61WdUt+nH0QmRFZX0gQ=
Date: Mon, 30 Sep 2024 18:58:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] bpf, selftests: Add test case for cgroup
 skb to get net_cls classid helpers
To: Feng zhou <zhoufeng.zf@bytedance.com>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
 shuah@kernel.org, geliang@kernel.org, laoar.shao@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
References: <20240918074516.5697-1-zhoufeng.zf@bytedance.com>
 <20240918074516.5697-3-zhoufeng.zf@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240918074516.5697-3-zhoufeng.zf@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/18/24 12:45 AM, Feng zhou wrote:
> From: Feng Zhou <zhoufeng.zf@bytedance.com>
> 
> This patch adds a test for cgroup skb to get classid.
> 
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> ---
>   .../bpf/prog_tests/cg_skb_get_classid.c       | 87 +++++++++++++++++++
>   .../selftests/bpf/progs/cg_skb_get_classid.c  | 19 ++++
>   2 files changed, 106 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/cg_skb_get_classid.c
>   create mode 100644 tools/testing/selftests/bpf/progs/cg_skb_get_classid.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cg_skb_get_classid.c b/tools/testing/selftests/bpf/prog_tests/cg_skb_get_classid.c
> new file mode 100644
> index 000000000000..13a5943c387d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cg_skb_get_classid.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright 2024 Bytedance.
> + */
> +
> +#include <test_progs.h>
> +
> +#include "cg_skb_get_classid.skel.h"
> +
> +#include "cgroup_helpers.h"
> +#include "network_helpers.h"
> +
> +static int run_test(int cgroup_fd, int server_fd)
> +{
> +	struct cg_skb_get_classid *skel;
> +	int fd, err = 0;
> +
> +	skel = cg_skb_get_classid__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return -1;
> +
> +	skel->links.cg_skb_classid =
> +		bpf_program__attach_cgroup(skel->progs.cg_skb_classid,
> +					   cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.cg_skb_classid, "prog_attach")) {
> +		err = -1;
> +		goto out;
> +	}
> +
> +	if (!ASSERT_OK(join_classid(), "join_classid")) {
> +		err = -1;
> +		goto out;
> +	}
> +
> +	errno = 0;
> +	fd = connect_to_fd_opts(server_fd, NULL);
> +	if (fd >= 0) {
> +		if (skel->bss->classid != getpid()) {
> +			log_err("Get unexpected classid");
> +			err = -1;
> +		}
> +
> +		close(fd);
> +	} else {
> +		log_err("Unexpected errno from connect to server");
> +		err = -1;
> +	}
> +out:
> +	cg_skb_get_classid__destroy(skel);
> +	return err;
> +}
> +
> +void test_cg_skb_get_classid(void)
> +{
> +	struct network_helper_opts opts = {};
> +	int server_fd, client_fd, cgroup_fd;
> +	static const int port = 60120;

Running a test with a specific port without netns could fail when test_progs is 
run in parallel (-j). e.g. cgroup_v1v2 is using the same port.

> +
> +	/* Step 1: Check base connectivity works without any BPF. */
> +	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, port, 0);
> +	if (!ASSERT_GE(server_fd, 0, "server_fd"))
> +		return;
> +	client_fd = connect_to_fd_opts(server_fd, &opts);
> +	if (!ASSERT_GE(client_fd, 0, "client_fd")) {
> +		close(server_fd);
> +		return;
> +	}
> +	close(client_fd);
> +	close(server_fd);

imo, this connection pre-test is unnecessary. I would remove it.

> +
> +	/* Step 2: Check BPF prog attached to cgroups. */
> +	cgroup_fd = test__join_cgroup("/cg_skb_get_classid");
> +	if (!ASSERT_GE(cgroup_fd, 0, "cgroup_fd"))
> +		return;
> +	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, port, 0);
> +	if (!ASSERT_GE(server_fd, 0, "server_fd")) {
> +		close(cgroup_fd);
> +		return;
> +	}
> +	setup_classid_environment();
> +	set_classid();
> +	ASSERT_OK(run_test(cgroup_fd, server_fd), "cg_skb_get_classid");

Please run this test under a netns and without specifying a particular port. 
connect_to_fd_opts will figure out the port used in server_fd.

Patch 1 lgtm.

Please add a few words to the cover letter also.

pw-bot: cr

