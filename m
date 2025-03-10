Return-Path: <linux-kernel+bounces-553838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A8EA58FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3123A5D60
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E33A225413;
	Mon, 10 Mar 2025 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZSvSpB0"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B67223322;
	Mon, 10 Mar 2025 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598965; cv=none; b=JZYCLBPn5QEeHMxdJf2Irs7lU+P9c4JVzzQTiDNL9Vwh2L73GakPukfb42mhai49Z8mXv9YWm5NoOs4O72klZaadQREdD6AK86YLY5WXDM8HkCwFOj9oRijVVplTC53y2jnzUBtyQcgf8rpSYN0i9Xw5yzQBHYTvdx3nIODYs2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598965; c=relaxed/simple;
	bh=J4CXKEEuJ6tiTl5L6qEaOGNZZupbK7uRsbw2Rjp3bGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dc0AOVr79TFoYRxrkm3vxne6Hf9AkPaK8yNIbmU6LR+Ac9eiqxObj3c/bpr0ny6gwvE7YVo+VNjrEYvOy+Zyewf9q89ctY+Sg/szdlSKptRYJJuwcUuHxCVBy9VG3qfipPz/HQm3jiohGN3x8GvGM45/hXUP4csSYQFyvNwfX/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZSvSpB0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22349bb8605so69987685ad.0;
        Mon, 10 Mar 2025 02:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741598963; x=1742203763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sTcSQFFnbluJf997mBXCx9e7ML1rsrCKL4zkfh+WiK4=;
        b=gZSvSpB0x0Xd+n/mqFn2VGWAi49C65ypv4YjipBYwNVBDFP70HQezep+29fiW9UzIB
         +6NBL4EF7N9niDam9qazRT8nEficVxg3yyUu7pmY71+2oHOirUqPUJhXJjor1SVg1cRb
         NcD8qkPkyKwc3H7+bgwFO7AMuutgUe70UIV0FmXUfQ+VpD+EOEAsWozb60pc92qmszbG
         UAc2KyTZNrQp/IZxD4vwgBWBpT3yv4If8haWlWxTBIYxHsk0ocJmY9R096e9YNmu23S/
         x5wNfEdFhE9ROJlZiHc4gmv2nOkpkH9w0GLXIooHn7r23UwKOyKHpJb6cpF3qmVLoN3m
         /XbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598963; x=1742203763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTcSQFFnbluJf997mBXCx9e7ML1rsrCKL4zkfh+WiK4=;
        b=dabKf7LluomTpOzD4/MrT504TDj3skGAXySZ6CmLF4IoqyEVVXqOXli/AWOWarhK1H
         0DGwDaJw65s0gpk/u6GHxCeS+EV/C+LnJa/ToJYTVOOD7uob/V69XGpa5lEngCSgzFCu
         OVZ/dT/1NAv3bA4DzyLzcUbTxszIY/rQ3Qs/m7naH1L1R9iLgWm8USvbM3UaRGnQQkPB
         i4GxmN8Ue5yahO7uo0P41OIRYV1/3+x9R6GLclyldg8EsaGcOBuTzCNxNpJ1z+bqBSEy
         p0botj+vlN1F8vGb8piKyHiwJbOAtTSBYh3qbMwWYuB8qMT47sZZpxeJorco58iNx9d5
         TFww==
X-Forwarded-Encrypted: i=1; AJvYcCW7MSMSKKIAiQRAMtuz/uNqCqamHGgPpKg061p9bCnMVFnEh+BggWE3zdvqH5E/GEqouWUlv+End+Y=@vger.kernel.org, AJvYcCXrdOdwd/5AMxdZ+rGntUrTklVTVBzi607HDARKr1cK/67yRhenvvTmhL7R9Iy+XKEGYDKdTqytQLNTK7aM@vger.kernel.org
X-Gm-Message-State: AOJu0YzjK/DynyGkNWwwSSkM3z/Ua6KklNch2Jb23XyTg+fJ37Thd4Jb
	msZDWU2mVHQOfJQZBHupsqcezsLQ+tTr7LeQnmznZV3HUD4dxdFC
X-Gm-Gg: ASbGnctXRDImsyQTWKwO9CYOGymLs48vgWU/hSMf/9wp1jPaDPRu8fue2u5EGaia2Jh
	Gx8IG1FCmSitnGx1dZ4faKhrEod5IsCH+sg7oD0z8u17roHxpyyUTo8Xe+wj1o9x6pvBn4L1zQj
	FDBotVBsvY3awxQ60hSn5T/aOCE7sWxh6+etFWDwRV/au3XyHWObFjYhQNmdv4qU+FEFAvaM29O
	zxRn6nWUeTcro+s0NRk4yaqmRlhr38RKTiv7Y12liRgu1VyaKY8M1UQgxVVVctTrYTobD8UHht2
	j02Sf+TKCt/gmA09g9tVdUnm6vwdVUWEyF/taK1ISTCbSwE4+q1D0JF78XNs8xLTutOVvagq6b+
	uaX6KPr/+a4kGJ/A=
X-Google-Smtp-Source: AGHT+IE+jPUAkXMj/tZzLRiCinBwXqUVE1rT1pab6rDJzc+t7jOXtlgTB8K+q6LEChcjppH7Kx19CQ==
X-Received: by 2002:a05:6a00:23d5:b0:736:9fa2:bcbb with SMTP id d2e1a72fcca58-736aaae5325mr23864989b3a.24.1741598963132;
        Mon, 10 Mar 2025 02:29:23 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736b5cef0f1sm5276686b3a.25.2025.03.10.02.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 02:29:22 -0700 (PDT)
Message-ID: <ed8add50-b146-4741-8ddc-010eea3ce169@gmail.com>
Date: Mon, 10 Mar 2025 18:29:20 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] cpumask: Fix kernel-doc formatting errors in
 cpumask.h
To: Viresh Kumar <viresh.kumar@linaro.org>, Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>
References: <cover.1741332579.git.viresh.kumar@linaro.org>
 <f4ad81150eaa00b43c161f0d1f811f8ecfe21889.1741332579.git.viresh.kumar@linaro.org>
 <Z8snakYmzhaavkKN@thinkpad> <20250310061540.zpfyisvchyua2cuv@vireshk-i7>
 <20250310090319.olwxrcqczwjla2jm@vireshk-i7>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250310090319.olwxrcqczwjla2jm@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Viresh Kumar wrote:
> On 10-03-25, 11:45, Viresh Kumar wrote:
>> On 07-03-25, 12:05, Yury Norov wrote:
>>>>  /**
>>>> - * cpumask_weight - Count of bits in *srcp
>>>> + * cpumask_weight - Count of bits in *@srcp
>>>>   * @srcp: the cpumask to count bits (< nr_cpu_ids) in.
>>>
>>> Here nr_cpu_ids is also a variable. Why you don't prefix it with @?
> 
> Hmm, I thought @ is applied only to function arguments. Not sure what
> should be done with nr_cpu_ids.
> 
> Akira ?

Section "Highlights and cross-references" in
Documentation/doc-guide/kernel-doc.sty says:

    ``@parameter``
    Name of a function parameter. (No cross-referencing, just formatting.)

It's just formatting.  Putting "@" to a non argument name won't result
in any warning.  (At least current kernel-doc goes.)

kernel-doc is just our own convention, which can change any moment,
hopefully in backward compatible manner.


