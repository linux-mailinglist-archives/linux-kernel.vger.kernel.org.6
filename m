Return-Path: <linux-kernel+bounces-215221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CECF1908FF0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E84284793
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6A016DEB7;
	Fri, 14 Jun 2024 16:18:40 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247A72B9A5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381920; cv=none; b=BM4MN2xYDCMgDmEZ1KRxXEfwvOh/LKlQFeuapzvXa7CFDYkjaXOiAoir5wvug24cvUjEnH2EpPhYzFtmL5z6NEFrn5/melCTOR95jQt7icR6H9m+Jm4Huf3afRflj1awiI+3k0afVUN9K0Nok3Q7kj/HAtsxjco8ISsrPOAv0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381920; c=relaxed/simple;
	bh=d9q8NhmHT7fhQbN8sORGWV+zeXsbe/oYJmEtluU60qA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P+giBfbrRngZ9NV0EZZF8W/ndvFt8mAhkNIi3xsZ7BCYbo+UYcFHBwuWJX2f66nYcfLy8ihTm1TldA2DkYsKcUp34NExHQamxtj4qThsZJvepiw752o1POgSHT/DxdFViezpXPcfPI2PHIBhZVZHh4Zq15EG/otA6OJ8jywJpkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45EFFQvn027838;
	Sat, 15 Jun 2024 00:15:26 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sat, 15 Jun 2024 00:15:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45EFFQEA027835
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 15 Jun 2024 00:15:26 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <52d3d784-47ad-4190-920b-e5fe4673b11f@I-love.SAKURA.ne.jp>
Date: Sat, 15 Jun 2024 00:15:24 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: don't call mmap_read_trylock() from IRQ context
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <4b875158-1aa7-402e-8861-860a493c49cd@I-love.SAKURA.ne.jp>
 <3e9b2a54-73d4-48cb-a510-d17984c97a45@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <3e9b2a54-73d4-48cb-a510-d17984c97a45@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/08 20:04, Tetsuo Handa wrote:
> On 2024/06/08 19:53, Tetsuo Handa wrote:
>> inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> 
> Oops, "inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage." example was
> found at https://syzkaller.appspot.com/text?tag=CrashReport&x=14f0179a980000 .
> 
> Then, do we want to
> 
> -	if (in_hardirq()) {
> +	if (!in_task()) {
> 
> instead?
> 

"inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage." upon unlock from IRQ work
was reported at https://syzkaller.appspot.com/bug?extid=40905bca570ae6784745 .


