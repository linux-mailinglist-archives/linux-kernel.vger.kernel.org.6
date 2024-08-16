Return-Path: <linux-kernel+bounces-290016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA83F954E77
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934191F258BB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8B31BE85D;
	Fri, 16 Aug 2024 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxh871gz"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C637710E;
	Fri, 16 Aug 2024 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723824520; cv=none; b=R6FNC5h81NzZ9t4sJWEoQ4dExPcRs/7h792Gm53NmY0SJbQ4I/MEZUfI9WL0MlLVDhQqQhtStBTQYr/6GfQc3s7F1WG+7UjlZpa3cDgegKw9Bj5zVQRZoYGpzpbeyVjpzuYYGWZ4ux2LyyTdfc+wVWhlKGyLrcK9nIuFREFq4pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723824520; c=relaxed/simple;
	bh=MwxEKjluJYnjjK6SG8S5QqCvIGD4zYXPGjil01esQYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGBhKUygbd8CuWMbcbDS2kGtEuS92xUlxmTQmQxMxCuIaOCtj7CxheE/Dj9EoRFitKEXaQ5aU+EfLUna5sIF3MvUueaoO1okuqa6Tgs+/4RTkP6BXmZs8DlGfv2CyoFuyX/xGZOfVtA1VSft5lqw/IFstno/PfYNAFaRmCcMR/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxh871gz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso15066995e9.0;
        Fri, 16 Aug 2024 09:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723824517; x=1724429317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BoQuglTR2707KDAr9BZEhvLM8HQTGX4jqaDuOUHIqAU=;
        b=Yxh871gzowVAZBkit4AExGsTYcKbjEMHFmZrgAodoKFp3rK+EWbAD3NqQhtOmz+1u9
         07bXAY9c8VK+s3Wt08ABk1jrpNardCeXyHgWsIxk3wJ2ZSnJJ1VQQ2jF4D0FYWphCt20
         /t4XgBPoORmWK8NNBBsFy+3OfLZxt7enf3tX24q8I3yV039hpWGLGu7vMexyru+44wTy
         TOr4/Ti3wWwvb6vCPGxR5b0uxqgCrfcAJMPGzaTCe2dH/z02QIPKh2JyqAtpraUcBjmo
         SeOViebQJqiF+N676l2+Z0mdrg4IA1cuWww4Zob6oC2HjLedrdYgxmzwSD0dfhzRXVSN
         qheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723824517; x=1724429317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BoQuglTR2707KDAr9BZEhvLM8HQTGX4jqaDuOUHIqAU=;
        b=Hxdvt6f8ZaTYhI98mq9kM9vn7PyDhhLqQZTSfKNVRrhaM7XBg1iEF3k/cWgpzxpzIO
         myAkK4FMXIHXMygSiR8TA8jpsZsOcpYuUdntNXgeF632hJfCX3IuicrmmK4xL2YJUUsO
         TnTedeJ69qs0zq70qI2xXFeEElTlujzO4gnlvRmY5pGDbrxgAbykzdOaS8nhYsYlC8/V
         Fc9ERQ0s6TGHrwPMXYfRnNuw5tYMb9CARMDtUidEQU5G6i98Ht29TCtdVF8EnNM4jfBJ
         eticygz2R1h40UuMWSovkWzd0zms14aBcDM4OCPHCpRV2I6wwFN0eWT8Zk1t4SewFiA0
         2VRg==
X-Forwarded-Encrypted: i=1; AJvYcCWD3QhD+1mml3cTTDRnKYTeTIS7kq+ALQbHkAu/B4eqsPxtzRwDttUoUaI0MERTEjXaTVxlRaeilGl2V5VQy4DiUCkJC2G1Y+Ey8ShoAvKc8c3jTIN9b6IK87EVEHGDNNL2RiGsepOP
X-Gm-Message-State: AOJu0YwJ4oEe3Rpspk0bhMyYDtMME3RUdKob/njNObTPkBHIPx4vWHkk
	oGFVLIwdIiIvzQPWAcHr7q6HA/rjCkvgbRmtcAUWiYwQs3p2DkpH/TLZoA==
X-Google-Smtp-Source: AGHT+IG2Y4HdfNYzOBBlcW0Tnko8Gn/wnNXv/YCdNorvpUhvEhG2/993oKzszSutxRsnnl0xLO+qpw==
X-Received: by 2002:a05:600c:470a:b0:428:3b5:816b with SMTP id 5b1f17b1804b1-429ed785f71mr21260095e9.3.1723824516848;
        Fri, 16 Aug 2024 09:08:36 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985a6d1sm3956387f8f.57.2024.08.16.09.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 09:08:36 -0700 (PDT)
Message-ID: <7e9e209b-b6b4-485b-ad43-9e1efbd63a7d@gmail.com>
Date: Fri, 16 Aug 2024 17:08:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] mm: Introduce a pageflag for partially mapped
 folios
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 yuzhao@google.com, david@redhat.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, cerasuolodomenico@gmail.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
 <20240813120328.1275952-5-usamaarif642@gmail.com>
 <Zr9zx74W6-oRwKXB@casper.infradead.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <Zr9zx74W6-oRwKXB@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/08/2024 16:44, Matthew Wilcox wrote:
> On Tue, Aug 13, 2024 at 01:02:47PM +0100, Usama Arif wrote:
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index a0a29bd092f8..cecc1bad7910 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -182,6 +182,7 @@ enum pageflags {
>>  	/* At least one page in this folio has the hwpoison flag set */
>>  	PG_has_hwpoisoned = PG_active,
>>  	PG_large_rmappable = PG_workingset, /* anon or file-backed */
>> +	PG_partially_mapped, /* was identified to be partially mapped */
> 
> No, you can't do this.  You have to be really careful when reusing page
> flags, you can't just take the next one.  What made you think it would
> be this easy?
> 
> I'd suggest using PG_reclaim.  You also need to add PG_partially_mapped
> to PAGE_FLAGS_SECOND.  You might get away without that if you're
> guaranteeing it'll always be clear when you free the folio; I don't
> understand this series so I don't know if that's true or not.

I am really not sure what the issue is over here.

From what I see, bits 0-7 of folio->_flags_1 are used for storing folio order, bit 8 for PG_has_hwpoisoned and bit 9 for PG_large_rmappable.
Bits 10 and above of folio->_flags_1 are not used any anywhere in the kernel. I am not reusing a page flag of folio->_flags_1, just taking an unused one.

Please have a look at the next few lines of the patch. I have defined the functions as FOLIO_FLAG(partially_mapped, FOLIO_SECOND_PAGE). I believe thats what you are saying in your second paragraph?
I am not sure what you meant by using PG_reclaim.

I have added the next few lines of the patch below:

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a0a29bd092f8..cecc1bad7910 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -182,6 +182,7 @@ enum pageflags {
 	/* At least one page in this folio has the hwpoison flag set */
 	PG_has_hwpoisoned = PG_active,
 	PG_large_rmappable = PG_workingset, /* anon or file-backed */
+	PG_partially_mapped, /* was identified to be partially mapped */
 };
 
 #define PAGEFLAGS_MASK		((1UL << NR_PAGEFLAGS) - 1)
@@ -861,8 +862,10 @@ static inline void ClearPageCompound(struct page *page)
 	ClearPageHead(page);
 }
 FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
+FOLIO_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
 #else
 FOLIO_FLAG_FALSE(large_rmappable)


