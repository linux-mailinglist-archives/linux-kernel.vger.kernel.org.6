Return-Path: <linux-kernel+bounces-539227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B1DA4A23C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E91B17426D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9DF277033;
	Fri, 28 Feb 2025 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JiW3mquv"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE327700B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768934; cv=none; b=QzgNjJfZRZ/DlKLKg5zXpykThdlATzVHWAydSDWdo4vSZPs6dbGxz7RH1ePalGZU4yXETnfs0/zYZgfv9RocNYBn3Qo58bvsxvpkjhO8YXVvWLv30Ndty4NPNcB1vznGNV59CSqZvqTAs2PcR+Y5CtKx01kNozSURI2p+iFNcmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768934; c=relaxed/simple;
	bh=/KcXav0rabKJcPCYp34mQZzZViXUMDBOctIouFNUP98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkF6dDHZ83Z4DDKqW+zjD57/84gPdylv6582b8d63bWUGGNIwhH3xtj3IRPmtVPXW/GLB+NJX1P3uNwmt4LzSul28MBDZGIff/gA9HI6m26vfV+O1Ov9NyJzvRu6KAOjw5C7pcy2WQVQd2sU+AHTK38Pj//HzKSpSigkRtc9u6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JiW3mquv; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <331d97f7-c1de-4b46-a1e5-75a3261d4e97@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740768929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1iKOUsrjeukuigNTKIIt0ORYtWT59cRVVyENYRJLiyo=;
	b=JiW3mquvsYYc9+1X3hlSZ6D3wCDFr3YthSmAfPn2WKNtyuXY5diXF9fTzP/3k7YagJDkV1
	AX0eb51cjtxIsG5kFnYBxVX8I0btbzILvOQ8EMHaKmq47f7ykhmHx8VslkRmkWxw+YP+21
	Ani+b4ufzj/fMQxszueUhOr2es1MUeo=
Date: Fri, 28 Feb 2025 10:55:19 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: filter: Avoid shadowing variable in
 bpf_convert_ctx_access()
Content-Language: en-GB
To: Breno Leitao <leitao@debian.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250228-fix_filter-v1-1-ce13eae66fe9@debian.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250228-fix_filter-v1-1-ce13eae66fe9@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2/28/25 10:43 AM, Breno Leitao wrote:
> Rename the local variable 'off' to 'offset' to avoid shadowing the existing
> 'off' variable that is declared as an `int` in the outer scope of
> bpf_convert_ctx_access().
>
> This fixes a compiler warning:
>
>   net/core/filter.c:9679:8: warning: declaration shadows a local variable [-Wshadow]
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Make sense to me.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


