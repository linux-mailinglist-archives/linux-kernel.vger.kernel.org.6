Return-Path: <linux-kernel+bounces-290913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E71955B1F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 08:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3846282542
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 06:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76916DDA8;
	Sun, 18 Aug 2024 06:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YX1OY92x"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93054944F
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 06:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723961851; cv=none; b=ppiX2Obrz6LnIXFeR4EXmi25lGfuREF6u9MUt+FMsKN7mRQhkhJkRxwL0KN51q9YCbwB0aGmjzsBH9pVMgq7ifuNbpHhnOj4WLDMpEma3TNKrfYV8zVdw+9Jgv6qHQuE33oJ+pgra/wFfa/r3r9Aq3c6NTMePf8jPBxOSXdc5ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723961851; c=relaxed/simple;
	bh=oOGDZD/wdXb4QFfc/oKPu3+MuFOtbGpBFYaC/iwKBLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MV8kVqC0VsTtl9avbIz+ywkfOLsrP7yuGMT6sWQym9UK0oETCRgICRQ2Q5DRr/SWDGDk2OFjPMNYrWnSoKnLCjMdxr8T51U4rV8+q/2ll+Xp1uRu95LLsZb1EaAZ6ZOttkK4iFwBQBWi6Mog1YPG7qen/+i8xFGlmP/dPwvce70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=YX1OY92x; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 47I6GfGW299775
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 17 Aug 2024 23:16:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 47I6GfGW299775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1723961804;
	bh=wIslcl7OOpcz8rPD/i3Svi+vXIL54ttTesBrOTxqguo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YX1OY92xGWbBUTAcIWBGZWjUYTgCvXF1MnWsHDDioN72xjJ8SsMfDXryUVP1MaAqq
	 nwOiqdoQ9LHMFKFdRVxHN4lBhZMY9wjHjHCwk6rXssdAwMv2PziUw63LH1jp9J8Ga0
	 IzY0G5hhbUEvyV1MEo9wMWXWgEFx4qi6NZZgs5Yv8pAjam753KN+AYWKj+zAdxVMLQ
	 1JWuanS9H38u57v3VO2XU7imkMMSeD6Zd/+EtPfRnc6fAidyav82XlXHknfMBcDdoc
	 Cez2qqtV6HTfs1FhfGkfeQh4ihw+vY3OtzHQ2CLd9IFQgrchfReaf0y0lPtDMCVh9h
	 mOtw9Ca4F/8tQ==
Message-ID: <b5221fb0-a198-4c76-ae47-906c42442f5c@zytor.com>
Date: Sat, 17 Aug 2024 23:16:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] x86/msr: Switch between WRMSRNS and WRMSR with the
 alternatives mechanism
To: Borislav Petkov <bp@alien8.de>
Cc: Xin Li <xin@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        seanjc@google.com
References: <20240807054722.682375-1-xin@zytor.com>
 <20240807054722.682375-3-xin@zytor.com>
 <e18cd005-24ef-497d-b39c-74a54d89a969@citrix.com>
 <7c09d124-08f1-40b4-813c-f0f74e19497a@zytor.com>
 <DAC74A8B-DDE4-450E-93A1-EFD7D47B25F7@alien8.de>
 <CC9FA68B-551A-4357-9088-D199C5859356@zytor.com>
 <20240818054911.GAZsGLV1MAEMLk9RiP@fat_crate.local>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20240818054911.GAZsGLV1MAEMLk9RiP@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/24 22:49, Borislav Petkov wrote:
> On Sat, Aug 17, 2024 at 12:22:22PM -0700, H. Peter Anvin wrote:
>> The padding avoids unnecessary NOPs.
> 
> And a NOP vs some other prefix to have one less insn matters practically
> how exactly here?

Pretty much nothing, but it is zero cost and possibly some insanely 
small gain.

	-hpa


