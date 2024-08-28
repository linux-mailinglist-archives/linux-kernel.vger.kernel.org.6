Return-Path: <linux-kernel+bounces-304500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2649F962100
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B29B22766
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641A0158848;
	Wed, 28 Aug 2024 07:27:28 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FBD156230
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830048; cv=none; b=EsRmANK/qxt6VM00VeQ+YeeLHCG5ZN+ub5h3cVo/fab1/t6imkqFRuYL0XNgq2MrPXIkZqPjG1vFAVi4uDehEf2KYeVk9Bwdot/8cCsrncL92JSM4wfMzEm3Lo28FqnPq8g/eqB6qds6uBfbev2Do1QTbJQwiRmHPgNg/FOuShk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830048; c=relaxed/simple;
	bh=vrWm6f3JAavZTpDlxJBcpicVXqMjCXT7GsiCXw4QIWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suUMO24fjunqz9g3nMKj9hNa1S6u1g4zPCH+virR6t1wGukRIN7iuc5UC9zcVN2/SL9AKyJmuhld/TS+VrBn9AyR3PaSqXvkGdfwNqeme1dEO4UU3nnIIgcOX+NIDF3e1lIOums12vJjCJEh9bGthOyZbhUj0NnLO8emPYSwxXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WtwwX2MSgz9sRy;
	Wed, 28 Aug 2024 09:27:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id osLUnOEKVhtf; Wed, 28 Aug 2024 09:27:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WtwwX1S0jz9sRs;
	Wed, 28 Aug 2024 09:27:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 213588B77D;
	Wed, 28 Aug 2024 09:27:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id zSyAyn1xnuEH; Wed, 28 Aug 2024 09:27:24 +0200 (CEST)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id ECE9D8B764;
	Wed, 28 Aug 2024 09:27:23 +0200 (CEST)
Message-ID: <3fbdc957-2db4-4148-b325-263384f9a196@csgroup.eu>
Date: Wed, 28 Aug 2024 09:27:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] powerpc/debug: hook to user return notifier
 infrastructure
To: Luming Yu <luming.yu@shingroup.cn>
Cc: "shenghui.qu@shingroup.cn" <shenghui.qu@shingroup.cn>,
 npiggin <npiggin@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 mpe <mpe@ellerman.id.au>, "luming.yu" <luming.yu@gmail.com>,
 =?UTF-8?B?5p2o5L2z6b6Z?= <jialong.yang@shingroup.cn>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <B375A36C9C4D73FF+20231218031338.2084-1-luming.yu@shingroup.cn>
 <8734vzsw0q.fsf@kernel.org> <8734vyn1ky.fsf@mail.lhotse>
 <2acd6623-952b-4659-bc26-c632e94560a8@csgroup.eu>
 <0638f0a2-782b-411f-9937-c62d99e9562b@csgroup.eu>
 <tencent_4F2B3C0025D5A1722470D582@qq.com>
 <bd4908d2-cea9-406b-902f-618626e74c88@csgroup.eu>
 <B6A4506E3DD1F93F+Zs7Iq_EF799NyWHK@HX09040029.powercore.com.cn>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <B6A4506E3DD1F93F+Zs7Iq_EF799NyWHK@HX09040029.powercore.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 28/08/2024 à 08:50, Luming Yu a écrit :
> On Wed, Aug 28, 2024 at 07:46:52AM +0200, Christophe Leroy wrote:
>> Hi,
>>
>> Le 28/08/2024 à 05:17, 虞陆铭 a écrit :
>>> Hi,
>>>
>>> it appears the little feature might require a little bit more work to find its value of the patch.
>>>
>>> Using the following debug module ,  some debugging shows the TIF_USER_RETURN_NOTIFY
>>> bit is propagated in __switch_to among tasks , but USER_RETURN_NOTIFY call back seems to
>>> be dropped somewhere on somone who carries the bit return to user space.
>>> side notes:
>>> there is an issue that the module symbols is not appended to /sys/kernel/debug/tracing/available_filter_functions
>>> which should be sovled first to make it easier for further debuggig.
>>
>> As far as I can see, user return notifier infrastructure was implemented in
>> 2009 for KVM on x86, see
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F1253105134-8862-1-git-send-email-avi%40redhat.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C260e5ecf10764312459c08dcc72dc2f5%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638604246584044745%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3hjAzcVu3xOq0QNK5WINQ8trLd9Xp7XCiQjw2htabpQ%3D&reserved=0
>>
>> Can you explain what is your usage of that infrastructure with your patch ?
>> You are talking about debug, what's the added value, what is it used for ?
> one example: I was thinking to live patch kernel at the moment that all cpus are
> either returning to user space or going into idle. But I'm not sure if it is truly
> valuable. secondly, it can help us get more accurate user/system time
> accounting via tracing rather than through sampling technique.
> The third: it could have similar usages in kvm for ppc as x86 for tsc_aux.
> etc :-)

Thanks.

Don't we already have a very accurate user/system time accounting with 
CONFIG_VIRT_CPU_ACCOUNTING_NATIVE ?

Christophe


