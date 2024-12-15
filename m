Return-Path: <linux-kernel+bounces-446309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C21AA9F226B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 07:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9DD1660FD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 06:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAD422334;
	Sun, 15 Dec 2024 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CpjkcEp5"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199742030A
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734243867; cv=none; b=DqO+/lbGXYhRBmYIhZ9KhPT/8wiz//vi1PwHuhi4GJaUjAkpIdt6gFTgS6gPeLpYl7lNgXF86ZrY+U8FGnufibgVZPoW26cageWssKDLHX2mIOynogP51GgYesxKms7wI2ecCujdudaFsmcLVSAfc0SZ1LNUECUZ48xGRTPtH/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734243867; c=relaxed/simple;
	bh=ZQTShHvCH16Q6A/sVemmtq5YmZn5Eet7FPxts66Rjtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YbDv/iW1DJaS+1E6ebM6l+kQLKFoAQ3HoOlHm+lTfyLIpNaiig/SyIVjuObm4kQTt+1u5i4SRY/Bm0+PuDJAxCSiffc/KDmMDhTh613y+2iFtLOwojdygY6Ocb6w5XO6EEkfnicLbyjH+TlqrobSEdjQSkKTlo7DoGJ7EN8aZ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CpjkcEp5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21683192bf9so28885385ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 22:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734243864; x=1734848664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4SAJQvXzymBH1K/3pvDxzFBA5BN9QQVDFta4CsgF/cA=;
        b=CpjkcEp5Y1UOxbikBK6iXNSkbXsO6eJ0T+B44+ZjiQG+BG/3gXTASXNxf654uZ+Jyj
         Bj1RLrPudQACYLR0Wgm7hKmUNrPIh2WJQpdFMHiI/6qzIbnIXdEhQhMWwLAMulSj4pL7
         JpBAN6n9irmkqSyt5AYPQLkSBcSTpR50+XHUFV0pyunGAOEEoQj9egnAgSI6ydTU1V2u
         uA/J2J4oPrCgfxq23RsqO3voqGDFI10GfgRqbFjGOR/pQMaAuQb2mvMDp8Yj4qv2fQoX
         DDCJogD1kptOoOuBccq31UQST69Q3eUJMKJZWd1u4PzJF8sppc6NWwWUOqhLApueAQZj
         NuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734243864; x=1734848664;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4SAJQvXzymBH1K/3pvDxzFBA5BN9QQVDFta4CsgF/cA=;
        b=h+d2q23R1PhH0QvuyL2f4np7/lAh4tOs6dZrYAz2bbw3S7YDXjw+Sr7UyHrdGWEii8
         ipIgWEz6E1LDtxjBXeV5d9F8AEiYq9zucQjk0xvwryt2iPi3/JBt3Wpn73rtyOB0k1Gb
         KKeNewVgYqTMH891j6a0f2eKeBUCGA2ldKrvJWkfqh4OEaBnO3udfK6HMrmjZn9yOyK4
         pGFRYaIMQZrgxDN5D04mHaVscgsorTclAJ3lhiwr6P250pOczah3/61GqWQ3cPwPplTi
         mgD5/Jw1ELqWob7/uR7m7I6Lp0EvJIZH73MAxYk4k1MiV7dTkRoVe6Iahudy56oe5k21
         aTug==
X-Forwarded-Encrypted: i=1; AJvYcCUTFoJgDFvN6/jZBarlJMYFZ7PoZhCCGkRcL9kfqiXCi9avtFUSIggVLxHLPd0Z7zzvAyoowpuaddF++SI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj06IEuPwIEcJ8IYK35s+3DbBKG4ZtgTtEctc1zB0mwQjxXudb
	+Mg+Cv5DsN2iz1LY8rdy1JDpJGWEIxupTCJMDmIRfp6zfevLbp7d4xzbQpsCxEQ=
X-Gm-Gg: ASbGncs+QZTDDMA9564DTCCoGyL2//kVo7IvDXsQqjWUg9iTHKrMpaBRhqaRu69ONmW
	7uG6xXPQVqqcioHnDxKMdmHc4E1Dd7CNJG5A6j4T/88yq2oU7IhjNQyLMEwG19HlbtbAe3TD8rI
	e8W+qW4Se28y14QnLdTYnHKr1wGXmVAetoZlxCTHEsNFGH5UvWSBwnIYfK/vfCc/vSiaTPefqCU
	MROlHK2IQz6BFI/tj/VpUVZCT7WtR316IMjPhSF29crRngeCRkcxWBUhWTuHOhWl2iPSiIhAc2t
	CpllNr+gINKMVlMub0HD4W1HDZguPLZ1fl9oVIZs47Ya1GGc/LK6zLg=
X-Google-Smtp-Source: AGHT+IEJMRdDDD6ihEEKBvCjk//M8WTTQOqdmcPzFG0Vq6NdBzL99WFtGq34scEZzQIahLUfq8EbyA==
X-Received: by 2002:a17:902:f646:b0:216:1ad4:d8fd with SMTP id d9443c01a7336-2189298a2bfmr127837275ad.8.1734243864448;
        Sat, 14 Dec 2024 22:24:24 -0800 (PST)
Received: from ?IPV6:2409:8a28:f4f:a9a4:11bc:4825:e7fe:2e0e? ([2409:8a28:f4f:a9a4:11bc:4825:e7fe:2e0e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e50a97sm21471645ad.149.2024.12.14.22.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 22:24:23 -0800 (PST)
Message-ID: <3e790063-dea0-4ba2-9d25-4abcc072fba4@bytedance.com>
Date: Sun, 15 Dec 2024 14:23:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] move pagetable_*_dtor() to __tlb_remove_table()
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
 <20241214185511.GF10560@noisy.programming.kicks-ass.net>
From: Qi Zheng <zhengqi.arch@bytedance.com>
Content-Language: en-US
In-Reply-To: <20241214185511.GF10560@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/15 02:55, Peter Zijlstra wrote:
> On Sat, Dec 14, 2024 at 05:02:46PM +0800, Qi Zheng wrote:
> 
>> As proposed [1] by Peter Zijlstra below, this patch series aims to move
>> pagetable_*_dtor() into __tlb_remove_table(). This will cleanup pagetable_*_dtor()
>> a bit and more gracefully fix the UAF issue [2] reported by syzbot.
> 
> I'll go over the patches in more detail on Monday, but at least the
> first few patches should probably carry something like:
> 
> Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Right! Will add this for [PATCH 02/12], [PATCH 03/12] and [PATCH 05/12],

> 
> Since you extracted it from my half-baked patch, the rest could probably
> do with:
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>

and add this for [PATCH 04/12], [PATCH 06|07|08|09|10/12].

> 
> Anyway, thanks for doing this, and so quicky! As said, I'll read more on
> Monday.

Thanks!



