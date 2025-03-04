Return-Path: <linux-kernel+bounces-544043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C39BA4DCCA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC4D176ABF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498DC20013D;
	Tue,  4 Mar 2025 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YE7VUCI7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AE31FDE27
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088397; cv=none; b=FEKpk4nDgTSvrgFSkWwwwsbUUpL9wqtf2MDlMsjxke7JhhUh38GqnTypvsvm/XJtRdol4Sse8rEXlbvHSdAmCKet2tvMwYVcqeX3XlhgIiovZt7KsBu7hA0/O7ftleTrvwoP6zFGmsgfuFRv0eeJ5lC8qT6HzH+Q1vRDVGDmNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088397; c=relaxed/simple;
	bh=Pet6msmAnBNCWNPcprQAH+0FzVtjVOU/qcl3s7u8JWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGmBd9cbf2R1+HfM3qptZFoD7HiT61q0diBU37/v9JP3HMGAJIx01jA6+Zfm2HIDOXBsdfiQNCpYNP+J+pEdZn0W99vYM6ufOmuEaoZrSYW9MNTx3hKA3T87Awiffpy3g4pTZxKEjuzFlQ2+ESXLV93VZ0HqBbKTlTOINOUPf7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YE7VUCI7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741088394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hntXZpQfa271EvBEp9eoZmK+pCjo6fsW/klFtftWSNM=;
	b=YE7VUCI7QoxM9jxp1gs1O8oQrffYwutQRgA326Z/rBZA+AzbfadIxliwPPSWtBdhT0gHnL
	OnADjNyODFAhSPYtE3/1odJlrlIKY275XccPOda8nrREEbqiq5nSeO7+0/pkXXNBbZC2sP
	54lbRN25rleotnqR8ud06ujV+mlXG/w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-0IVJF4fIN-KKN6uA2lSsEg-1; Tue, 04 Mar 2025 06:39:43 -0500
X-MC-Unique: 0IVJF4fIN-KKN6uA2lSsEg-1
X-Mimecast-MFC-AGG-ID: 0IVJF4fIN-KKN6uA2lSsEg_1741088383
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43bce8882d4so1275595e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741088382; x=1741693182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hntXZpQfa271EvBEp9eoZmK+pCjo6fsW/klFtftWSNM=;
        b=K3Om+6UAKiIUFM4hOhF4fe2XJ645yuLP/WIy5ENzHqFv0V872l/oyf5KldadnA/qlY
         zrIFr71b0cKl6csxURaKdnCQTi9o+vgx0Knhr8XTnuO0fSFPRqUstGBI9LLI8ChqLPPm
         OyE6KJyZ14dGvVTFceoxNiUQnPpCvZF0CYJbRbJaQzxQIz82vopqcqD0vJ7HxeHqcFvs
         MKMo+185ACMXf9iMwubttgUMPYg26+pplQWMDOmY09QO4tSo9SPXI45wmhpP7IZW0VXZ
         vmEWUbYzkf9KwOR73xPPjR6L4g5N89hw4z+zUuFARgY8TwYWMo7O2Cqho0WBWgn/Y+xr
         Zbmw==
X-Forwarded-Encrypted: i=1; AJvYcCUiHHxHYehtxV6/3MZFt1FG7YFQwq+YWTkZaPyneul0rQUtevCspju0wxxbnYI3acKJEjF1+KdSqjJZibc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwICxa/OxK3V9RNnNFNaevo9IBbzJt+acw3jfCrMfZJcj3DgzvZ
	MYz+TOyFaRoHmIZicBtkG0skWDzU1JrJwCyj/R7IB+7DDJfeV9EG5zgQGg4fmLE+awHAb3FQTMn
	zXiafFz6IZBYAizacZRGzxvoO+oqzr61PW/FkUTwMhzmk4tkmoAZbe0nl/PVHEj8mSKk2Ug==
X-Gm-Gg: ASbGncvwdTbwpszGnsQ7vLETezdmRYF7ymxwKjYy/ThiSVoMoYtQUurs1u5sudhAQhB
	ipuMaNPpf68zvCS2KKvWj2eeS06BA2R5cQtvzVbR4Ii/JW+N4MPqDGf95rf4ZwLBptagzqubYq4
	tmOJZYoMsRLcg99PDHhUrnYhCOn+ZxOqQ3kSiDu/DUT5XF1HGZjgOyYGLgBq4OCU5XP39HEVUe2
	Lxteemt3iFvMfAjZs5BSOIsJ47H/vy+UwnP8SmHQ3Wfy8iSTfzM3ElnTa7dmhMiOt39ZDgUV0DR
	F0jboMeH29uh3UWTimwcx6pir4HOYMr/3vcVWEHZlONDNA==
X-Received: by 2002:a05:600c:1384:b0:439:9f42:8652 with SMTP id 5b1f17b1804b1-43ba6704748mr155318235e9.17.1741088382346;
        Tue, 04 Mar 2025 03:39:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvEFgiDy7ba5K1ePVI42ersngV+bgTh0BsGa2h1RJF6kOEPu7Gge8cE7SX90ZY6smvmrEHow==
X-Received: by 2002:a05:600c:1384:b0:439:9f42:8652 with SMTP id 5b1f17b1804b1-43ba6704748mr155318035e9.17.1741088382013;
        Tue, 04 Mar 2025 03:39:42 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6cd8sm17197430f8f.44.2025.03.04.03.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 03:39:41 -0800 (PST)
Message-ID: <5ec0a2cc-e5f6-42dd-992c-79b1a0c1b9f5@redhat.com>
Date: Tue, 4 Mar 2025 12:39:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/1] bnx2: Fix unused data compilation warning
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20250228100538.32029-1-andriy.shevchenko@linux.intel.com>
 <20250303172114.6004ef32@kernel.org> <Z8bcaR9MS7dk8Q0p@smile.fi.intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z8bcaR9MS7dk8Q0p@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 11:56 AM, Andy Shevchenko wrote:
> On Mon, Mar 03, 2025 at 05:21:14PM -0800, Jakub Kicinski wrote:
>> On Fri, 28 Feb 2025 12:05:37 +0200 Andy Shevchenko wrote:
>>> In some configuration, compilation raises warnings related to unused
>>> data. Indeed, depending on configuration, those data can be unused.
>>>
>>> Mark those data as __maybe_unused to avoid compilation warnings.
>>
>> Will making dma_unmap_addr access the first argument instead of
>> pre-processing down to nothing not work?
> 
> I looked at the implementation of those macros and I have no clue
> how to do that in a least intrusive way. Otherwise it sounds to me
> quite far from the scope of the small compilation error fix that
> I presented here.

I *think* Jakub is suggesting something alike:

---
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index b79925b1c433..927884f10b0f 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -629,7 +629,7 @@ static inline int dma_mmap_wc(struct device *dev,
 #else
 #define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)
 #define DEFINE_DMA_UNMAP_LEN(LEN_NAME)
-#define dma_unmap_addr(PTR, ADDR_NAME)           (0)
+#define dma_unmap_addr(PTR, ADDR_NAME)           (((PTR)->ADDR_NAME), 0)
 #define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { } while (0)
 #define dma_unmap_len(PTR, LEN_NAME)             (0)
 #define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
---

Would that work?

Thanks,

Paolo


