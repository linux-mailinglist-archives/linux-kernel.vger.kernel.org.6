Return-Path: <linux-kernel+bounces-560921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 246E5A60B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B08E19C1674
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F91219CC24;
	Fri, 14 Mar 2025 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mixaill.net header.i=@mixaill.net header.b="pOtrRZ6I"
Received: from mail.mixaill.net (mail.mixaill.net [144.76.234.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD646146D57
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.234.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940213; cv=none; b=b9s5LqnKg4W8BHlvxa+kk0X28sFf200aRJ6lkTSPhjMCqQX2pCTs3+tUIW0WA+2PhPHnMyUmh/rV2iblV/DQBOHXQnYkINdCFxu7PEgkI53Cf92qEGyGVrbZAFGXDBcx9qVtTwKS9MPW60c5O8IUKlsN/Wessm08syzEkx64eWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940213; c=relaxed/simple;
	bh=qtEM2RgClCdglNPiuqQUBYADihyceogRF/upsA6Xjbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qm1cP/ufwMC0SvM/vR1ogb+bhcuP+C1NUBCOH7GpNG4XzlzQ6Feaj6DGP+0pNwiha+F28NnKnIOc9zK4bzNEOn69yRkN0uPZmJGmcCrZWc+iwcSyH3RSBDBlKM8Siji3w6ORr+UrEkwit9amu46sO+Ie/hYmcG/D9vf301r74ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mixaill.net; spf=pass smtp.mailfrom=mixaill.net; dkim=pass (2048-bit key) header.d=mixaill.net header.i=@mixaill.net header.b=pOtrRZ6I; arc=none smtp.client-ip=144.76.234.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mixaill.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mixaill.net
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F99C6C954;
	Fri, 14 Mar 2025 08:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mixaill.net; s=dkim;
	t=1741940203; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=w1uvea5ckxLu4teNZEVtDlewztPYEl58uFFERrRbb1o=;
	b=pOtrRZ6I3cJS5Rcp3pA9D4p5K/8Ql3L0SZUifeOzaAcOay7MwSbXMLLVoSXaSBQ+Gd/kar
	6SzCBjX/Sx2vo5S9cnW15tC9kPf2uVXDsVCmgrzpP4q1BCDF6JoStTJAdgfvtdAToC8a8J
	r2HxxT//q7ow5EHLccD5RfWcIbDwEbnVgSVH7q4b6hU1TaA+ZhnKALgFMWMHOi5RreWLL/
	p/DKeVGSMFGMXE8LLXMoPhkaztleJbBoSKNzh78uzeGqnJRh/ERE7LNrEBPzLghw13/oGN
	iOkWQrhQveKcegZtinZoAUEGcWLArk//rnA110bcARmF0vaOze1N+/J95xQgtA==
Message-ID: <4aa902e5-24f8-4ae6-bc6b-485b7578fb27@mixaill.net>
Date: Fri, 14 Mar 2025 11:16:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] x86/rdrand: implement sanity check for RDSEED
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <20250312123130.8290-1-me@mixaill.net>
 <20250313173205.GIZ9MWlT9ElklGPSrD@fat_crate.local>
Content-Language: en-US
From: Mikhail Paulyshka <me@mixaill.net>
In-Reply-To: <20250313173205.GIZ9MWlT9ElklGPSrD@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 3/13/25 8:32 PM, Borislav Petkov wrote:
> On Wed, Mar 12, 2025 at 03:31:28PM +0300, Mikhail Paulyshka wrote:
>> On the AMD Cyan Skillfish (Family 0x17 Model 0x47 Stepping 0x0), which
>> is a Zen2-based APU found on the AMD BC-250 board, there is a situation
>> where RDRAND works fine, but RDSEED generates FF.
> On every read? Or only sometimes?

I didn't find a situation where it returns something different, so yes, 
I believe it happens on every read and tested on 3+ hardware samples.

> Is CF clear when it returns FF?


Just right after rdseed %edx


# info registers edx

edx 0xffffffff -1


# info registers eflags

eflags 0x203 [ CF IF ]


