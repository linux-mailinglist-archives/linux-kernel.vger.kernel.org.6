Return-Path: <linux-kernel+bounces-286948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3939520AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C191F24183
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E5D1BB69C;
	Wed, 14 Aug 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="sQ5edDfk"
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0382E3E5
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655090; cv=none; b=ctBFKEwqcY2TX9U2cqZDqCrxQKmdrnlc17IySNop9L2+Y17WA1l8xKj5EaSZnBo6cUtuQBFafdnY5QHQIvaLWN3rUJj8oDqHCx4busgSSoHlc37V/DTwh0iHqOp+e53GpWKSt5FZ2wEE+WMr8WRmvPmK9N7hFmdM5jeCMDKsM+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655090; c=relaxed/simple;
	bh=w6DukgVdh/SeaYiuJZwiSsb19olegSRrDqb9Lls4kO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nkft/K7lPC0oBdrO3EA9lgb1KEgvPFgPzAO8CquiGytwn9cBjr3AgggJjKSffNrCZoG3OekJaWcop/HCfO34cX08u63VY80xrsJ7l5N3aaUypRvy2wLbKLUiodwNiqbroUlNfDBIynbgVTJELMoYyMqt2IYzwHuEQMha8kgk+9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=sQ5edDfk; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1seGeX-00H0zF-Jj; Wed, 14 Aug 2024 18:15:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=8gEuZoqquS008o2flgsV7w+43AvF3jk+PJRlBs+g2p0=; b=sQ5edDfkRzc9YUM4Nk/REh0Inu
	f9DlCRgI9C1WcPcuDVa3dOe+fflSCNMCq4Y7cBkeFwBKas6iQCWoBUKkHBV0twXBtYw1a8C3UHYUW
	uSGqZt80FwF3nFxwMq0F9VaQ4qBJ+SxcTQ6ax1+FHFwp5eTi/rq/j23cx1CZG7z4rv3qFhrh0b5zT
	S/2zMG6l5YIzOqUXJMlY9IbRiLYBHtCLFY5VMK3Sj9wwd3gPCbC8jtbl3LcpoeGRWlu0Nmxtuk00P
	ogGYsU8isI2SSBEfsU5PHrczKZbt79pqBDPaF602HapFg9iHTeUTUWxZGq8xlXs6hNa5VzbkmFbRr
	EmNnS9fA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1seGeR-0003LT-GH; Wed, 14 Aug 2024 18:15:07 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1seGeH-00EOaa-Nw; Wed, 14 Aug 2024 18:14:57 +0200
Message-ID: <42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co>
Date: Wed, 14 Aug 2024 18:14:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related
 fixes
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
 <87y159yi5m.fsf@cloudflare.com>
 <249a7dc3-34e2-4579-aae7-8b38b145e4bb@rbox.co>
 <87ttfxy28s.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <87ttfxy28s.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/24 19:45, Jakub Sitnicki wrote:
> On Tue, Aug 06, 2024 at 07:18 PM +02, Michal Luczaj wrote:
>> Great, thanks for the review. With this completed, I guess we can unwind
>> the (mail) stack to [1]. Is that ingress-to-local et al. something you
>> wanted to take care of yourself or can I give it a try?
>> [1] https://lore.kernel.org/netdev/87msmqn9ws.fsf@cloudflare.com/
> 
> I haven't stated any work on. You're welcome to tackle that.
> 
> All I have is a toy test that I've used to generate the redirect matrix.
> Perhaps it can serve as inspiration:
> 
> https://github.com/jsitnicki/sockmap-redir-matrix

All right, please let me know if this is more or less what you meant and
I'll post the whole series for a review (+patch to purge sockmap_listen of
redir tests, fix misnomers). Mostly I've just copypasted your code
(mangling it terribly along the way), so I feel silly claiming the
authorship. Should I assign you as an author?

Note that the patches are based on [2], which has not reached bpf-next
(patchwork says: "Needs ACK").

[2] [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related fixes
    https://lore.kernel.org/bpf/20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co/

