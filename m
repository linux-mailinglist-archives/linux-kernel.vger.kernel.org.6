Return-Path: <linux-kernel+bounces-278081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7500D94AAA0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973E71C20FC8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F4380BEC;
	Wed,  7 Aug 2024 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5Y9DfSh"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA81A78281
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042281; cv=none; b=Yksb8CqVer7ToyxIE+w+e30P3/VY3G257Zo9QVbjBoWgwvVYK0THS5TxKkIJBdEuzqUAlGw447xz9nRFUR4gEwEU0vvnT8kXnTFPkXgPqW2hfMkxAlLdUwBIxvPNct6NA4aW52kdtb0W3BaVgqJ0Pq/JOmAHk5vKDXAxtb98s8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042281; c=relaxed/simple;
	bh=jXzllFmlCYPGCf1n/wBOuxhFMMy21gaDr7qlaM5aYD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMTmkMNxSkZ0NZBB9h75XTVgIwnhM1Sk17KJcUI+gLhTX/30YHxSJtarPw3y5YFcONkm25Roa8SdIIbHF/jH21TH/Mpsy9RnwFpihyrvgurs2OlAaal/WR8sknh9TWm9iwHyMutycG2u8ZYsqx+ocpbhen6hkyXs0utoBzORF1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5Y9DfSh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc56fd4de1so7375085ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 07:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723042278; x=1723647078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BDY7J9/W8/VU13G8TqO3gSsNHmFTzvPA7EjNyvdNsjA=;
        b=I5Y9DfShWc7tdOPQx6gX4WWi6YThpZRKpUjTu0VqlSeXvxPg5rniIOFhhAgBv9sZ86
         JZPIPaR8yGRE/DHB/BLBg6P3CSfk45b2E41RLhyfRUC++W/YbUjzzm9gU+yfnjJuCgMS
         vhqH0l0MfKOVovnPR/Qofwqu1V+xyF5/OOXq1KZxd1oMvdPRK0QfAo17BwtDQnzAk9MM
         MITqW1yY7dnADdfrme7UcYDOysTmd2IVKntOcOzvycISmDZ5NnOSkMVLvoFWyGNgg5A2
         4Qc0lGBYITH5QpeUSwT6+Ej6oVsqI4IAwlwacUy2kT3/rxnAQh5zNiRWSbH/2clM35aK
         u+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723042278; x=1723647078;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDY7J9/W8/VU13G8TqO3gSsNHmFTzvPA7EjNyvdNsjA=;
        b=g6A/a8975Z5vuirJRVLC4T7EFJ5tVtRTUwScoMTBxpFzPCnnnzm7Z38GtvM386Jwhg
         /klbRTfHzGgaa563WV6sfvA7k1YyVA1teZEL3skIFnIep8oi4JiQtmBCXrUyTRqFrEXg
         etvOoI/CUGXA5rrIWf/c2dCTUE5RiSQ0UH9amRabOXSEjBPFjHRttiQmeTsnmnGWrmST
         h2pqSbkfAUqm1QHYf0i9QNnWkuHp893cjlrqvNP1nYs++1GytKZQdKghDAPLrI6oTSUE
         +YXCAR4MCChNUd3iXGg7MLNMEZJIDXmPXYDYcBnd6H2mOf8yjlYWCFtWbpkhWLbnCpSP
         M+RQ==
X-Gm-Message-State: AOJu0YweyA4hzdRY6cn0A8BEfJRwdr4IJ3GMrGdoeKAn8GHsf/iT7wk7
	DFh6t/o+TBSwRqzyB4Yamqfpk1+Z4Rvhe4ffSksmcDR6QX1nkBdx
X-Google-Smtp-Source: AGHT+IE2NV4rr0g1/11a1aKAvLCV87PMjl+pIpr+3Z4hPKHGfZAvPqsdzuPXdheQ2SyYk7IR/MwzcQ==
X-Received: by 2002:a17:902:e541:b0:1fb:4f57:6a65 with SMTP id d9443c01a7336-2008555ec6emr36244045ad.30.1723042278039;
        Wed, 07 Aug 2024 07:51:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592b3643sm107035815ad.290.2024.08.07.07.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 07:51:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5cc43ed9-b4f8-49f5-99ee-b411bb144085@roeck-us.net>
Date: Wed, 7 Aug 2024 07:51:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/23] powerpc/e500: Switch to 64 bits PGD on 85xx (32
 bits)
To: Christophe Leroy <christophe.leroy@csgroup.eu>
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <b73e991e-5f66-455e-a271-e10511ebeaef@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/24 03:11, Christophe Leroy wrote:
> Hi,
> 
> Le 31/07/2024 à 18:35, Guenter Roeck a écrit :
>> On 7/31/24 08:36, LEROY Christophe wrote:
>>>
>>> Hi Guenter,
>>> Thanks for this report. I'm afk this week, i"ll have a look at it in more détails next week.
>>> But to be sûre, does that Oops match the bisected commit ? Because pmd_leaf()  for e500 doesn't exist yet so pmd_write() shouldnt be called.
>>> I did validate all my changes with mpc8544 on qemu when i implemented this séries, using map_hugetlb mm selftest. What test tool are you using ?
>>
>> Nothing special; it is just a qemu boot test with various module test and debug options enabled,
>> using a root file system generated with buildroot.
> 
> I still don't get anything with mpc85xx_defconfig.
> 
> Can you tell with debug options you use and which module tests ?
> 

Please see http://server.roeck-us.net/qemu/ppc-v6.11-rc2/.

Thanks,
Guenter


