Return-Path: <linux-kernel+bounces-319120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF19096F7F9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1BE284764
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1041D1F77;
	Fri,  6 Sep 2024 15:14:49 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7B8266AB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635689; cv=none; b=LbAtY0MjAJhkVqysOFed7eW+bR+jXsiseOm2gO2B8Qp1GYoyrNWJovy4jVOfBTpn0CsZ6PnMGlnh2wnIaBXzQE4d63OqO66I/xNuBpvTf4vgiiptsfGiNQIGjbyKQPwR8kV+s5aZHZVcEpyMSysujKu3cphlmHzKaXIn55AN7GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635689; c=relaxed/simple;
	bh=M7GMR5fXeA8VMjMsf7JZB1XxCLrdb9oZwFoKAQvTLbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgNNqkKq1vpQCJCBVIB1Dk9fEew0ufbWpOXdDU/BcTAiJO+WYF66F+MsJu8Z4ZsiiUIQLs3Wv7D/Q6+OEYQC9WL/XcDNIfdXHVYiKIwqOoJHmT4zm3u9Nboq9WU1JkHAWNqONjpMXDJqWliia8Jo4/NvWiKZSwb6QB/CmOUFjpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X0fsc1PHVz9sRs;
	Fri,  6 Sep 2024 17:14:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UNbein6IwXot; Fri,  6 Sep 2024 17:14:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X0fsc0dFPz9sRr;
	Fri,  6 Sep 2024 17:14:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 05C4A8B778;
	Fri,  6 Sep 2024 17:14:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id kShRiX5vNBN2; Fri,  6 Sep 2024 17:14:43 +0200 (CEST)
Received: from [192.168.235.70] (unknown [192.168.235.70])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 960F18B764;
	Fri,  6 Sep 2024 17:14:43 +0200 (CEST)
Message-ID: <8d0a8d03-95b3-40a8-85cd-5c2e6f92eb6b@csgroup.eu>
Date: Fri, 6 Sep 2024 17:14:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Fixup for 3279be36b671 ("powerpc/vdso: Wire up
 getrandom() vDSO implementation on VDSO32")
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrei Vagin <avagin@gmail.com>
References: <700dbf296d02e32376329774be35cfbead08041d.1725611321.git.christophe.leroy@csgroup.eu>
 <ffd7fc255e194d1e2b0aa3d9d129e826c53219d4.1725611321.git.christophe.leroy@csgroup.eu>
 <ZtsMpcV7iLYoytdJ@zx2c4.com>
 <795db5f1-c266-4fb3-a51b-c2b3745d334b@csgroup.eu>
 <ZtsVry_LL2jjeLJ3@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <ZtsVry_LL2jjeLJ3@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/09/2024 à 16:46, Jason A. Donenfeld a écrit :
> On Fri, Sep 06, 2024 at 04:26:32PM +0200, Christophe Leroy wrote:
> 
>> On the long run I wonder if we should try to find a more generic
>> solution for getrandom instead of requiring each architecture to handle
>> it. On gettimeofday the selection of the right page is embeded in the
>> generic part, see for instance :
>>
>> static __maybe_unused __kernel_old_time_t
>> __cvdso_time_data(const struct vdso_data *vd, __kernel_old_time_t *time)
>> {
>> 	__kernel_old_time_t t;
>>
>> 	if (IS_ENABLED(CONFIG_TIME_NS) &&
>> 	    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
>> 		vd = __arch_get_timens_vdso_data(vd);
>>
>> 	t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
>>
>> 	if (time)
>> 		*time = t;
>>
>> 	return t;
>> }
>>
>> and powerpc just provides:
>>
>> static __always_inline
>> const struct vdso_data *__arch_get_timens_vdso_data(const struct
>> vdso_data *vd)
>> {
>> 	return (void *)vd + (1U << CONFIG_PAGE_SHIFT);
>> }
> 
> It's tempting, but maybe a bit tricky. LoongArch, for example, doesn't
> have this problem at all, because the layout of their vvars doesn't
> require it. So the vd->clock_mode access is unnecessary.
> 
>> Or another solution could be to put random data in a third page that is
>> always at the same place regardless of timens ?
> 
> Maybe that's the easier way, yea. Potentially wasteful, though.
> 

Indeed I just looked at Loongarch and that's exactly what they do: they 
have a third page after the two pages dedicated to TIME for arch 
specific data, and they have added getrandom data there.

The third page is common to every process so it won't waste more than a 
few bytes. It doesn't worry me even on the older boards that only have 
32 Mbytes of RAM.

So yes, I may have a look at that in the future, what we have at the 
moment is good enough to move forward.

Christophe

