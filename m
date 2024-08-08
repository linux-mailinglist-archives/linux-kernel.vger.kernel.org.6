Return-Path: <linux-kernel+bounces-279163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DEE94B9C2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9AB2810FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591A61494A6;
	Thu,  8 Aug 2024 09:36:46 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FCC42042
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723109805; cv=none; b=Oe0fV53ywVlQTwPoYM1pd66Y4/wvve75rYQwrb+reSENvHW1wWvzUTEi+RL9LuRUuf/LJ+srU9BiipffguGRDXk36TzCLXnXWFRT1u9yDg7P/kp37+eZdkopmaQX8Ll2QpQh2rXuN5b0IK1Lj9q3uXetea2kidIkGCpTSA61jlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723109805; c=relaxed/simple;
	bh=baZ20uRIKRl+GYdW3mAv3xAqey6J71Pe8woE7c32JAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFMPgzg2qxNahvyEtXVHfSGC0k8vZiuntqozCuivBqkPb3OQY+ntXK6EfJUheC6b4cfDoeHp2CAdfCoGRk4dKgAppwfExC7iyzA0wJSgh0f0KQnelhenIHlP8DXrz/WEF6FtWM/pyjaTJrDY07vb/RENg2pwitQmScjC9sbbQzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wfhkx58QNz9sPd;
	Thu,  8 Aug 2024 11:36:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WhyHdBxXIhK6; Thu,  8 Aug 2024 11:36:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wfhkx4Kt2z9rvV;
	Thu,  8 Aug 2024 11:36:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 820478B76C;
	Thu,  8 Aug 2024 11:36:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id okyHh3OtlL_d; Thu,  8 Aug 2024 11:36:41 +0200 (CEST)
Received: from [192.168.234.168] (unknown [192.168.234.168])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 17AC38B763;
	Thu,  8 Aug 2024 11:36:41 +0200 (CEST)
Message-ID: <17eed040-969e-4d2c-b20b-ecfd93450901@csgroup.eu>
Date: Thu, 8 Aug 2024 11:36:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/23] powerpc/e500: Switch to 64 bits PGD on 85xx (32
 bits)
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Oscar Salvador <osalvador@suse.de>
References: <cover.1719928057.git.christophe.leroy@csgroup.eu>
 <ca85397df02564e5edc3a3c27b55cf43af3e4ef3.1719928057.git.christophe.leroy@csgroup.eu>
 <2c7adbc9-609d-41a9-8a3b-a63d59e21a1f@roeck-us.net>
 <AM0PR07MB496234BE973D5458C53517F29BB12@AM0PR07MB4962.eurprd07.prod.outlook.com>
 <4f46d614-0fbb-452b-a778-b7b3a7f6da8b@roeck-us.net>
 <b73e991e-5f66-455e-a271-e10511ebeaef@csgroup.eu>
 <5cc43ed9-b4f8-49f5-99ee-b411bb144085@roeck-us.net>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <5cc43ed9-b4f8-49f5-99ee-b411bb144085@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 07/08/2024 à 16:51, Guenter Roeck a écrit :
> On 8/7/24 03:11, Christophe Leroy wrote:
>> Hi,
>>
>> Le 31/07/2024 à 18:35, Guenter Roeck a écrit :
>>> On 7/31/24 08:36, LEROY Christophe wrote:
>>>>
>>>> Hi Guenter,
>>>> Thanks for this report. I'm afk this week, i"ll have a look at it in 
>>>> more détails next week.
>>>> But to be sûre, does that Oops match the bisected commit ? Because 
>>>> pmd_leaf()  for e500 doesn't exist yet so pmd_write() shouldnt be 
>>>> called.
>>>> I did validate all my changes with mpc8544 on qemu when i 
>>>> implemented this séries, using map_hugetlb mm selftest. What test 
>>>> tool are you using ?
>>>
>>> Nothing special; it is just a qemu boot test with various module test 
>>> and debug options enabled,
>>> using a root file system generated with buildroot.
>>
>> I still don't get anything with mpc85xx_defconfig.
>>
>> Can you tell with debug options you use and which module tests ?
>>
> 
> Please see 
> https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fserver.roeck-us.net%2Fqemu%2Fppc-v6.11-rc2%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cfd337af1375448bcda1508dcb6f06644%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638586390853555531%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=7kihrxw5%2FrCI6TzmxGM56tEmghc1Bj7b1czXuM0%2BVrk%3D&reserved=0.
> 

Thanks,

CONFIG_SLUB_DEBUG_ON is what exhibits the problem.

I sent out a patch: 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/1cdaacb391cbd3e0240f0e0faf691202874e9422.1723109462.git.christophe.leroy@csgroup.eu/

With that patch I can successfully boot your config.

Can you give it a test ?

Thanks
Christophe

