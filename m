Return-Path: <linux-kernel+bounces-355807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E2C995764
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F2C288A1A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBC32139C7;
	Tue,  8 Oct 2024 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ozaItHFB"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33DE1E04A0
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414371; cv=none; b=FHZ0Fg45z2UXZrW94DDnEc2onD39twKjfachrMOUfC9CGOBNpoXxWr7R9pPlCOZOFqoEM14q8y9yHI4IEEmVuISGG/dQJqtyV/Pu3t7cDtx6AgI2l4a8UQigalEjEywFal/+42o+3ZpwGSHjYopCxY7hd5U+KQ8b7mXs3nzYDv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414371; c=relaxed/simple;
	bh=5KvCDrYsmVEvQOJdpgcn18Q0pvxqfpe7WxBjVnVzH9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkIki3iOpa0gVVpZNDgMAEFQa8FjjA9OB2VVGPOP+Lwt3QDzx/LB+FpUWA/j+SNOqOzEr58c6KDTClMIU6XnFUoudCCO4XiqBv2VXQ1gE1VJ4adbvt5Bb3frFOkIRsWsjk929F5LFrLc+W+1KCpKlLpRwHRxD5h8AC/qULc2DDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ozaItHFB; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <80cb3d4b-cebb-4f08-865d-354110a54467@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728414366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ni+aJGRqa2mg0vHffyWRXur4SC1MH0dJEEbAGiR80M8=;
	b=ozaItHFB/2BGM61ilYRQ2zY795ImSAUTnTY/dkYyvwBA/g6z6LzkTFpdLf7IbYUJAoO7CA
	1E6CxZl47f3x5o0LGIXjFAB9CU3cEFDukfauyKw9/+woKhDZxkiFCtw781VzVBsYqQXdtv
	TkNcQZQ0U99fNZVegPgCRDvYrnvLKf0=
Date: Tue, 8 Oct 2024 12:05:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Add rcu ptr in btf_id_sock_common_types
To: Philo Lu <lulie@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, xuanzhuo@linux.alibaba.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241008080916.44724-1-lulie@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241008080916.44724-1-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/8/24 1:09 AM, Philo Lu wrote:
> Sometimes sk is dereferenced as an rcu ptr, such as skb->sk in tp_btf,
> which is a valid type of sock common. Then helpers like bpf_skc_to_*()
> can be used with skb->sk.
> 
> For example, the following prog will be rejected without this patch:
> ```
> SEC("tp_btf/tcp_bad_csum")
> int BPF_PROG(tcp_bad_csum, struct sk_buff* skb)
> {
> 	struct sock *sk = skb->sk;
> 	struct tcp_sock *tp;
> 
> 	if (!sk)
> 		return 0;
> 	tp = bpf_skc_to_tcp_sock(sk);

If the use case is for reading the fields in tp, please use the bpf_core_cast 
from the libbpf's bpf_core_read.h. bpf_core_cast is using the bpf_rdonly_cast 
kfunc underneath.

pw-bot: cr


