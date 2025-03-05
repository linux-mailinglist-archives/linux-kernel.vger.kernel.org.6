Return-Path: <linux-kernel+bounces-546442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E201A4FABB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A46164D80
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E29205E1C;
	Wed,  5 Mar 2025 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTtk0aMm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059EB2054EF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168440; cv=none; b=NMc1hoEMmuk013JSj7j1clXkr/hOtSNWcvy7rJN7jURdfE6MQOJXlzZLVWoU7cNMblhX/jJm77Qhp+8MEx9xlXa0PIHWHZJs/bSP30hMQoNrGStJby5PUjvPZoXKi1fhb0PRjlNDL1/Hy6i+1TyhzXBHsH0ykxCaRFzWqT5ROw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168440; c=relaxed/simple;
	bh=61itoehDo/+0AMvhVCNYYRR2REnhSzSWwlWLoqMvDto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u33GIYsClQBiZfSKAfA6jdG68NVXaYa4iMe6+VvDFFC7Jg5AcpIl+TZjr4MsGax3lDE99kTYOxWxd389b06UUkJLbRyElymbkChUYRPJ3C4Ow1s0IPw9Rdh+TDhI4yGwFRSNhfJhopo2wx0uXyBIVo574lai9Wkm4I1WI5AuP8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTtk0aMm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741168436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KZUbRmh1B4qOIuBb44nafoTkzo3Y9FAH9V3whMAn34c=;
	b=PTtk0aMmFSkoRnINcp2WGx3k/NivfRYFiRl5Zr3kjT6WH0ws75ahUNHCoLAHI1c2xQg67j
	MUxZBOLaP4s9CYlG2lYSecPykFGab0h8eo+pPFBvo3yrCPK9TgTdSGczQhMa72ZkG4PotS
	1S1GGJQsCMVS7hqgm2cYsv5nAWPRTC8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-UJVViJkjNa6CSpwZL8U3cA-1; Wed, 05 Mar 2025 04:53:40 -0500
X-MC-Unique: UJVViJkjNa6CSpwZL8U3cA-1
X-Mimecast-MFC-AGG-ID: UJVViJkjNa6CSpwZL8U3cA_1741168419
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac21ef37e38so19461266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 01:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741168419; x=1741773219;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KZUbRmh1B4qOIuBb44nafoTkzo3Y9FAH9V3whMAn34c=;
        b=TCC/dyT4jHXlXqbcZCcqtuA2DGNKp2U/BDndqJuX1Em+KodIfkpNu9xHc0IOpn93Zw
         Tt0hseAKJvQzU+UMLap4dUc9JOJyR5nRqcy0qsakR+RnXBqjp3AcZJwyjUMKIKoMJ5FJ
         LDQqS0GFOYKaea0z3h9+U+26fbEfihvTa/usGgnOko5DGyDnFSOPVI9qH9y1je67og4V
         0CXavu78so3TsH3MnFd+482FIsBuT1swSoi13gLKwVFdLAXpGwb0HE22eqfRur2bYg7r
         XsbLyDgaG/ovIZFVcg1j/wPpgrre+Lf0O+JhT6BMDVMSsYY/XcUxNzZe7QTY1A+lig3X
         oRtg==
X-Gm-Message-State: AOJu0YzGW51m0qmJYd/+2CMEpWvK+O2hU6XOS2G/ccM2/HIs1ZnB7Xk2
	r08Qz4HwV136M39fG62hUQWBkjUdwdiCVagdmSmTYojvwb0Xtk0l0YagQr137bspbU3Fr3Kj0Kz
	/GBhW06zbr5AEv/l0CW+Q7H0O0CReNhxz/zb1Hk3QX73PDAq1Ociah9YMODOafQ==
X-Gm-Gg: ASbGncsx2I+IcebU/4Kk7//iEBc3c6bmqUxdogMaIDO6oczjF5SCDH5D9Hte9FaEonY
	SuRP/NzaZ+v5Iy0Y1Am3TFOteQuCL5Y9XoeynfItU2u2IjuLlyBdKzlLJV3EwynadGd2zdAnalQ
	DKiu/UCA8uqa6YyDX2R36FyAXAt4lOVfK070eoh/O+bUxx2dPx6ejUtJD32s5qwhUhiDP4rIPo8
	p2XO1FiukqTQYlDW593R/HUocqCbKmmkektVg4Ymw+Eegr0yXskjhbnlJp4/6j14Wash1Gl3vr1
	GyMnY/ngowAY+3LvDr0ZBkwGmbtTOfvh1ZiiPtxHMv5irrJkag==
X-Received: by 2002:a17:907:9628:b0:ac1:f002:d85d with SMTP id a640c23a62f3a-ac20da4267fmr225772566b.6.1741168419164;
        Wed, 05 Mar 2025 01:53:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4fThcJunLaYFnyAZ4NBO3mfl6nINuYRG54xpBa6CGqbfms1JCJEFzRseCiwKWwERlTipSKw==
X-Received: by 2002:a17:907:9628:b0:ac1:f002:d85d with SMTP id a640c23a62f3a-ac20da4267fmr225771166b.6.1741168418744;
        Wed, 05 Mar 2025 01:53:38 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf5d0bcb77sm677668066b.49.2025.03.05.01.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 01:53:38 -0800 (PST)
Message-ID: <016b7cb8-451c-4d81-b3c2-e98fa0bc330a@redhat.com>
Date: Wed, 5 Mar 2025 10:53:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warnings after merge of the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250305204243.0458b36e@canb.auug.org.au>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250305204243.0458b36e@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.03.25 10:42, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (htmldocs) produced
> these warnings:
> 
> include/linux/mm_types.h:482: warning: Function parameter or struct member '_usable_1' not described in 'folio'
> include/linux/mm_types.h:482: warning: Function parameter or struct member '_mapcount_1' not described in 'folio'
> include/linux/mm_types.h:482: warning: Function parameter or struct member '_refcount_1' not described in 'folio'
> 
> Introduced by commit
> 
>    bbde3b621cf7 ("mm: let _folio_nr_pages overlay memcg_data in first tail page")
> 
> from the mm-unstable branch of the mm tree.

Hm, we also don't document other dummy placeholders like:

* _flags_1
* _head_1
* __page_1

So I assume there must be one way to silence these warnings, let me dig ...

-- 
Cheers,

David / dhildenb


