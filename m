Return-Path: <linux-kernel+bounces-318867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D227696F456
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B25E1F2460B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE361C8FA6;
	Fri,  6 Sep 2024 12:31:33 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE0916A95B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625893; cv=none; b=Sd9pz3pR7hDqN8cwVLnnJ8ZNMrUuEFQCKdr5JjgspsUJ65KpJsenZzYCO7TgEJC8cnLrohrfikgwVYQWQA2Seoqfi1vEs2KKMINlWl8nDizrTsRhdtoZseDLX1ZYPZQLh+ZTsfGzbQGctKkrHpvdVUl0pUSqCWTE7YOkyWW1j8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625893; c=relaxed/simple;
	bh=z2ufVmS0fef0LAToiMLzzgXEkidsJ6pbr8Q5gbrHjG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGegi0XWAHrSKEpfH0kLNRHlxMXqxTjYPHDT7wUMYseRq5dwBFb2cEVDyLEmI5SYGhasT+1G3wl1i7FJUet+d/+6gssXHQ52ZtagrsZqw1QRah9z55LicgY33uyOYuVm2w7WnZadoR4j2nabbdkBy6AbU9Hj3zF4k6+t72VpIpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X0bFF6wc3z9sRy;
	Fri,  6 Sep 2024 14:31:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sevjizfciI8Z; Fri,  6 Sep 2024 14:31:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X0bFF683cz9sRs;
	Fri,  6 Sep 2024 14:31:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C21C88B778;
	Fri,  6 Sep 2024 14:31:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 6C9CitRpM0wH; Fri,  6 Sep 2024 14:31:29 +0200 (CEST)
Received: from [192.168.235.70] (unknown [192.168.235.70])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5E7E48B764;
	Fri,  6 Sep 2024 14:31:29 +0200 (CEST)
Message-ID: <19f6a089-caa8-4d91-951a-d9a25e05ba94@csgroup.eu>
Date: Fri, 6 Sep 2024 14:31:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powerpc/vdso: Fix VDSO data access when running in a
 non-root time namespace
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrei Vagin <avagin@gmail.com>
References: <700dbf296d02e32376329774be35cfbead08041d.1725611321.git.christophe.leroy@csgroup.eu>
 <87r09x3r9v.fsf@mail.lhotse>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <87r09x3r9v.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/09/2024 à 14:23, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> When running in a non-root time namespace, the global VDSO data page
>> is replaced by a dedicated namespace data page and the global data
>> page is mapped next to it. Detailed explanations can be found at
>> commit 660fd04f9317 ("lib/vdso: Prepare for time namespace support").
>>
>> When it happens, __kernel_get_syscall_map and __kernel_get_tbfreq
>> and __kernel_sync_dicache don't work anymore because they read 0
>> instead of the data they need.
>>
>> To address that, clock_mode has to be read. When it is set to
>> VDSO_CLOCKMODE_TIMENS, it means it is a dedicated namespace data page
>> and the global data is located on the following page.
>>
>> Add a macro called get_realdatapage which reads clock_mode and add
>> PAGE_SIZE to the pointer provided by get_datapage macro when
>> clock_mode is equal to VDSO_CLOCKMODE_TIMENS. Use this new macro
>> instead of get_datapage macro except for time functions as they handle
>> it internally.
>>
>> Fixes: 74205b3fc2ef ("powerpc/vdso: Add support for time namespaces")
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>   
> Oops.
> 
> I guess it should also have:
> 
>    Cc: stable@vger.kernel.org # v5.13+
>    Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
>    Closes: https://lore.kernel.org/all/ZtnYqZI-nrsNslwy@zx2c4.com/

Jason only reported a problem with getrandom, the other three are 
"cherry on the cake".

The bug has been there for 3 years, I'm sure it can stay 3-4 more weeks, 
I'm not sure there is a need to apply it in both trees.

As far as I understood Jason was about to squash the fix into his tree 
so I was expecting him to apply patch 1 before "vDSO getrandom 
implementation for powerpc" patches and then squash patch 2 in place.

> 
> Jason how do you want to handle this?
> 
> I can put patch 1 in a topic branch that we both merge? Then you can
> apply patch 2 on top of that merge in your tree.
> 
> Or we could both apply patch 1 to our trees, it might lead to a conflict
> but it wouldn't be anything drastic.


