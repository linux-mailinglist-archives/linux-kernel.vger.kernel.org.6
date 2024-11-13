Return-Path: <linux-kernel+bounces-406958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DC49C66AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7702284CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9E21C695;
	Wed, 13 Nov 2024 01:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pkm-inc.com header.i=@pkm-inc.com header.b="gjS9Yk6U"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8CB382
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 01:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731461130; cv=none; b=KbilfV3nH8UdaC8epNl78GNrSWWJP3c1yFKJH8pctkDNypBD9ykekYnVElZctca1iJ3zO8p+u5MgI3BlcH6DQYRJiTIfAvzQYMn8Ef/WecK84eeSVIZuoA6iDFKIFFCOYyXH9bZYnKZ/QCwl22QM3URyV3dZTwIa7gCVZ0clVlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731461130; c=relaxed/simple;
	bh=vbgdxFKygzTwH0fH+i8mYqKSSbV8H0qFEv/FemMPSKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2TAPkpgZRdOSB9MbuZgM9o1zJcrLqMsnrQy+RnGtlp2q3sm89qfEthHHU7VMHXABS3vfS6aoxwjyWhDb5UGNL2J9mFjI8xBhkpbKmeZbb0DGtTlLr5DUJVXKdVu3roPWfYluEn+pRcrjT+VK7KescSl+3I8/Kh0Qfi00xe5tTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pkm-inc.com; spf=pass smtp.mailfrom=pkm-inc.com; dkim=pass (2048-bit key) header.d=pkm-inc.com header.i=@pkm-inc.com header.b=gjS9Yk6U; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pkm-inc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pkm-inc.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9ec267b879so1120468666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pkm-inc.com; s=google; t=1731461126; x=1732065926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqbVv1BV13hd7p0GTnuathse5wdeIz+hilMwxG9iDfc=;
        b=gjS9Yk6U9UsAIDRivKQRXOn0t1tgIoRAKAlZ5H1+gO5K1ButAQoQMe85M6PZ8rNReD
         1/+IZsrPAQ4xR3I9P0+pQfGHaf2thCUmmSxxAdYBzyuAyETGqKKebzlsCuOR6EUHmrdp
         NecKyMT4wAFWg3JKnQx/2hgbJKmqwzXA6GB/RwO2lQ6xYmRB8i5KC50F+MCE6TF5F10n
         99dgKLRJ9UpvuPTHi9zfj+Zq/7Xo9+uoiqSeTID/9tYwLvFBIxduqRU4AH0HpPmCSmJT
         C4cSVqp+OhK39lQeJasoak6SGq0mmwlUeVKWYip8JQEYtASnrdAfv2Oxrrvyn4mqRyD6
         gYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731461126; x=1732065926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqbVv1BV13hd7p0GTnuathse5wdeIz+hilMwxG9iDfc=;
        b=WI18yfxzHObMG6+lPdAM+xNUgMuJF6NFqnH+TK4KpnTTX6uAoiHB6/F01Cyo5buuQt
         iPfLkXby6A7AHm67FhbIhUUK/RszHvcXVPcBaKBCo4u2R3Gb/QO1f4KEhraGtqdkK2Dx
         Lztlzz/R9uHSeUeae5mjK3FpkkA9rE9GQJvLXlTsSt4uclXMN8liWIgF1j9WDeOSH8j+
         7UYuf4QNnZuZrgpe7acxYJhXpDGkxb2uEeG+LYnPDRuBGGlHtI2xjvc7EZiC4cv24smQ
         vDaZBQTNyYnp849F4gkxFqe470ba6dE2j1uqwn9erpLB0zuAcrav0fniXaMakz9nhZjJ
         dd6w==
X-Forwarded-Encrypted: i=1; AJvYcCVCj7gmvxeDyZxyD43Ahj2OnMXgLaJWFZu8pCPR+yZsT954SMjeJrZYEU2XhLSyL+IfOZ/1Vsa65w8dzbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyml2cZcXezg4Sbh0Cl93ke/ca4OtCd2FHfp+Ty0kq9Mw3F8I98
	n/o9keFxrMIsPLXYuAG8GDKGraNDv849yx9SC7PNOtJq+waFrYO5RSaYAmRRIHU=
X-Google-Smtp-Source: AGHT+IHcfGp9iJW0VdcIMWymDr0AR0L6zRxuo6IjAzSntlZqX5icUcE0L8rNMuficyU4mrPddXwArw==
X-Received: by 2002:a17:907:36ca:b0:aa1:e695:f84 with SMTP id a640c23a62f3a-aa1f80801fbmr78837566b.36.1731461125580;
        Tue, 12 Nov 2024 17:25:25 -0800 (PST)
Received: from [10.8.0.8] (178-221-200-39.dynamic.isp.telekom.rs. [178.221.200.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4c210sm788701866b.78.2024.11.12.17.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 17:25:24 -0800 (PST)
Message-ID: <0889814a-615a-491e-86ff-aaa7b9518dec@pkm-inc.com>
Date: Wed, 13 Nov 2024 02:25:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH md-6.13] md: remove bitmap file support
To: Yu Kuai <yukuai1@huaweicloud.com>, "yukuai (C)" <yukuai3@huawei.com>
Cc: Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "Luse, Paul E" <paul.e.luse@intel.com>
References: <20241107125911.311347-1-yukuai1@huaweicloud.com>
 <CAPhsuW7Ry0iUs6X7P4jL5CX3+8EGfb5uL=g-q_8jVR-g19ummQ@mail.gmail.com>
 <ef4dcb9e-a2fa-d9dc-70c1-e58af6e71227@huaweicloud.com>
 <CAPhsuW4tcXqL3K3Pdgy_LDK9E6wnuzSkgWbmyXXqAa=qjAnv7A@mail.gmail.com>
 <CALtW_agCsNM66DppGO-0Trq2Nzyn3ytg1t8OKACnRT5Yar7vUQ@mail.gmail.com>
 <8ae77126-3e26-2c6a-edb6-83d2f1090ebe@huaweicloud.com>
 <CALtW_ajYN4byY_hWLyKadAyLa9Rmi==j6yCYjLLUuR_nttKMrQ@mail.gmail.com>
 <36659c34-08bf-2103-a762-ce9e75e8262e@huaweicloud.com>
 <CALtW_ai-xfkphuch64f2n544cfWzg__59bwX3Yxkf-N61K-SvA@mail.gmail.com>
 <8dc1ee79-fd64-70d7-bb48-b38920c1cddd@huaweicloud.com>
 <cf00703f-f4bd-4b6a-9626-72d839ebaf7b@pkm-inc.com>
 <e9fd5484-619b-e8a9-984c-359bf5475b9f@huaweicloud.com>
 <e32688e7-310e-49fc-9f52-44dd183f9666@pkm-inc.com>
 <adae6bff-8401-b641-438c-d212b20a7430@huaweicloud.com>
Content-Language: en-GB
From: =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <galileo@pkm-inc.com>
In-Reply-To: <adae6bff-8401-b641-438c-d212b20a7430@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/11/2024 02:18, Yu Kuai wrote:
>>> ram0:            981MiB/s
>>> non-bitmap:        132MiB/s
>>> internal-bitmap:    95.5MiB/s
>>>>

> 
> So, I waited for Paul to have a chance to give it a test for real disks,
> still, results are similar to above.

That is interesting. How are you running those tests?
I should try them on my hardware as well.

> 
> You can see examples here:
> 
> https://github.com/brendangregg/FlameGraph
> 
> To be short, while test is running:
> 
> perf record -a -g -- sleep 10
> perf script -i perf.data | ./stackcollapse-perf.pl | ./flamegraph.pl
> 
> BTW, you said that you're using production environment, this will
> probably make it hard to analyze performance.

I may be able to move things around for the weekend, we will see.

Thanks
Dragan


