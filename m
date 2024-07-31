Return-Path: <linux-kernel+bounces-269601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1189434B3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABBE284E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933ED1BD028;
	Wed, 31 Jul 2024 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0XnQs4/"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532561B140E;
	Wed, 31 Jul 2024 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445715; cv=none; b=jLvmxUeFm5HjHPi7Qsw83M7nbTUizl6fR2kM7tHoCbEzorH19RuL0bjMvjV8IWe8nnfw4rTe6qIiwU+7Oekcx+horx1La+8+t3iQbDMoMInxr828TLQ0WeWxDY+bHscun6+yTOd1uZZEpaGqIKvVgwUmqrVd7+Bms68VxXXEugY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445715; c=relaxed/simple;
	bh=5cnwLrXYPh3Ta06LQU7jBRW6dCIY+6ckfiq72SQKcO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGS1MTImbkNEqGLSPbpb3aY8yyn2M1JG3a6h98/SLSPF6FogLGY8SWITK+Wfhvm/YV+uIdBoo/Ubb7uITebLRpWkQRmgZDoLsK3VpmYW6ni4mCmTwObdcoGXkcmJmZSaW95JGEznZRZpmql9vWMhs1a3YSR73ycUQwmMVvp7msI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0XnQs4/; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f0277daa5so9497870e87.0;
        Wed, 31 Jul 2024 10:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722445712; x=1723050512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zmIGMZF3Ex14yn497tyJfAPQiN0Wn1Jw1t4lzfHLCxA=;
        b=F0XnQs4/qi1gMW65sN2Wzk/xEfMANIdsYTrRCBLPJTWMnByQsLop2Xk17Gm85+P1Da
         LGvaDjrCpJ2XOVyRDHsIv6mtToKM6FyCcdtA1CLS7Qkv9GLrON72g0ALmNBOQLqdagvM
         mW1bwNIzaYj5vk1lNCJ8r64BtI94Lt9W4PiwQ+CkanP1sEsfmQKUuDrzzFfF4wUevz0t
         Yg0bJJZYEZQrfGdO9EbjsijSqbk4AKaaOnUgzrEiXjfjqgJoxfMPc80KC6ltC6hxg8NC
         QiQPtIktjqTzsBroX6PJAUH6ARXdVanlYeLqY3+4QfA6BTHtvvCM34RiKY4nNMzVgAGG
         aHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722445712; x=1723050512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmIGMZF3Ex14yn497tyJfAPQiN0Wn1Jw1t4lzfHLCxA=;
        b=Mc0HuDAVOSbxpSQGfvJC6V9TF9EXVRbYtN2iE9NBGWYk/orQE1/p3ivYgFqLkf4lIa
         fhoRXWXRbCKmTOLYrKpKAlrGaGnZ2pUDNrLu2zp0W4tF+2BUduhbIdhXYrQd7efJOTtQ
         FWzQNJ+VGZNs4vMO3vt5+jeoTkc0/SirCCheHc+NgOSlRglgH9YP7A0ZLchyIvfq5nGh
         D3GixslS93y3gILxFrm1ThzdgED2bnCZUeZdwauWd/eKEl8Yvg6M11Kx0mrB+jy2j7um
         1Bv3nGPpS7vjpTlPdbJrd39Z/4jrSiNSvvQe2RkZMVfcEn2Q1DyMN+eYbRg4+K9VAoPn
         PvQA==
X-Forwarded-Encrypted: i=1; AJvYcCWO0agZW+CtGIzbhAq1khasC7anhaXocCNGBbEkNQlaeq8jGSX1LXtdQInGBn37YSry5d3/A/wIqkSMeVZpjCJLzyQqfcS2U4wsCBT7aLESO1q21QGwl97cCdw9ldIIxLt06E5wZRxb
X-Gm-Message-State: AOJu0Yx464EwsQIryg3xuus3dDuozVCSYcv6xBfRvkdtiG0Uqvr+3khj
	ng+ZAZjHK7FPos8thzcFcDE0nqwmsCxwmdZUViWexSMIZg+yD67n
X-Google-Smtp-Source: AGHT+IFvLikjy5iAvItD9OZu/l9FEMFWYDL31zzz4N5CGYhaoKVDqoSajOIqehvx27ZmeoE6iugGgQ==
X-Received: by 2002:ac2:5a4b:0:b0:52c:dfe6:6352 with SMTP id 2adb3069b0e04-5309b2bcc1dmr10379583e87.48.1722445712194;
        Wed, 31 Jul 2024 10:08:32 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::6:b6e0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad91005sm794069066b.173.2024.07.31.10.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 10:08:31 -0700 (PDT)
Message-ID: <042be214-e51c-4c69-9839-329f206dc8f8@gmail.com>
Date: Wed, 31 Jul 2024 18:08:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] mm: don't remap unused subpages when splitting
 isolated thp
To: Rik van Riel <riel@surriel.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 yuzhao@google.com, david@redhat.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com,
 Shuang Zhai <zhais@google.com>
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <20240730125346.1580150-5-usamaarif642@gmail.com>
 <20df6650c834b3d2d6e5d7062876ee6a1e997dba.camel@surriel.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20df6650c834b3d2d6e5d7062876ee6a1e997dba.camel@surriel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30/07/2024 19:07, Rik van Riel wrote:
> On Tue, 2024-07-30 at 13:46 +0100, Usama Arif wrote:
>>
>> +	/*
>> +	 * The pmd entry mapping the old thp was flushed and the pte
>> mapping
>> +	 * this subpage has been non present. Therefore, this
>> subpage is
>> +	 * inaccessible. We don't need to remap it if it contains
>> only zeros.
>> +	 */
>> +	addr = kmap_local_page(page);
>> +	dirty = memchr_inv(addr, 0, PAGE_SIZE);
>> +	kunmap_local(addr);
>> +
>> +	if (dirty)
>> +		return false;
>>
> 
> A minor nitpick here. The word dirty has a few different meanings
> in memory management already.
> 
> Could it be clearer to use something like "contains_data" ?
> 

Thanks, yes makes much more sense, will use contains_data in the next revision.

