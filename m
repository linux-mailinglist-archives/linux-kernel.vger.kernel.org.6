Return-Path: <linux-kernel+bounces-530668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FF4A4366D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA27166D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947D825A32D;
	Tue, 25 Feb 2025 07:50:05 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994D7204C31
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469805; cv=none; b=d8qSJI/wnaWnTQhtkpctGvChtfBrIjQRDSIl991llVBfQDwtXAkDlWfZctyqhTOZnqRUHljfmLDltfcgxQjtHwVjyX6RUnmDNBjwYw4TyVIAu3SoxYiw9dcdsFbR8jBiW4GVqwzdwkM5kZ8e0fcTprX3T2qvrEwlZINzuwg/BOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469805; c=relaxed/simple;
	bh=09ibOkxEH89zpgu/YOvZXAOdkjAqyD57M71vN9DlDIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XaLm0UWPGBagvDyPdcgogLw0iGYN24KxJLbX+cD9OE+SB2yjYQTlKO4mEGJJavuTE9d8s6Se7heidc248VKjk1cDCKWJ+gTreJgcRjBWc183AKc0AdGThImWXRa20Q33MIBxUaQCywTOOXIqAiwfMtRgHQ0IZDt8lf/XtQZBf+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Z28XW5p6Cz9sSH;
	Tue, 25 Feb 2025 08:35:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LNoX8tsTPzIV; Tue, 25 Feb 2025 08:35:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Z28XW50Xsz9sS8;
	Tue, 25 Feb 2025 08:35:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 98D598B780;
	Tue, 25 Feb 2025 08:35:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id D597ggcl3448; Tue, 25 Feb 2025 08:35:39 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 283828B77C;
	Tue, 25 Feb 2025 08:35:39 +0100 (CET)
Message-ID: <7d23db63-6909-48e2-8262-fb000aa714a5@csgroup.eu>
Date: Tue, 25 Feb 2025 08:35:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] objtool: Skip unannotated intra-function call warning
 for bl+mflr pattern
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sathvika Vasireddy <sv@linux.ibm.com>, jpoimboe@kernel.org,
 peterz@infradead.org, npiggin@gmail.com, maddy@linux.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 llvm@lists.linux.dev
References: <20250219162014.10334-1-sv@linux.ibm.com>
 <3223ec0e-c445-4bbf-ae72-276688e40908@csgroup.eu>
 <d5ada017-1ba2-4a89-8a58-4555f09f9d97@csgroup.eu>
 <8f4ec6d4-2646-4a87-b3a1-edfaecff2a01@csgroup.eu>
 <20250224170922.GA585841@ax162>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250224170922.GA585841@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 24/02/2025 à 18:09, Nathan Chancellor a écrit :
> On Mon, Feb 24, 2025 at 02:19:14PM +0100, Christophe Leroy wrote:
>> Well, this problem already exists on clang 18 it seems:
>>
>> 00000004 <btext_map>:
>>     4:   7c 08 02 a6     mflr    r0
>>     8:   94 21 ff e0     stwu    r1,-32(r1)
>>     c:   93 c1 00 18     stw     r30,24(r1)
>>    10:   90 01 00 24     stw     r0,36(r1)
>>    14:   93 a1 00 14     stw     r29,20(r1)
>>    18:   48 00 00 05     bl      1c <btext_map+0x18>
>>    1c:   38 a0 00 00     li      r5,0
>>    20:   7f c8 02 a6     mflr    r30
>>
>> While GCC generates:
>>
>> 00000418 <btext_map>:
>>   418:   94 21 ff e0     stwu    r1,-32(r1)
>>   41c:   7c 08 02 a6     mflr    r0
>>   420:   42 9f 00 05     bcl     20,4*cr7+so,424 <btext_map+0xc>
>>   424:   39 20 00 00     li      r9,0
>>   428:   93 c1 00 18     stw     r30,24(r1)
>>   42c:   7f c8 02 a6     mflr    r30
>>
>> So lets make the kernel tolerate it allthough it should be fixed on clang at
>> the end.
>>
>> I can't find any related issue in the clang issues database
>> (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fllvm%2Fllvm-project%2Fissues&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C3c10d37fecd94c692acb08dd54f5ff51%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638760137702082512%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=qOjbONjWUuXFKUNb42yEPXgXmvU6x%2BuwbGSg2Ep6WRk%3D&reserved=0), should we open one ?
> 
> Yes please, especially if you happen to have a simplified reproducer
> (but no worries if not). I can make sure it gets labeled for the PowerPC
> backend folks to take a look at.
> 

Done, see https://github.com/llvm/llvm-project/issues/128644

