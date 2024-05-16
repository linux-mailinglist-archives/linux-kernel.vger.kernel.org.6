Return-Path: <linux-kernel+bounces-180985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B828C75C8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F1D0B2149C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBDF1465AE;
	Thu, 16 May 2024 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD1F1biw"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26A145B0B
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861723; cv=none; b=GG2sfWtA4wmwNozJ7iASfQKyJHBMZSInDpib4bnfmR3qunZV6gx2Slz6ofpyBpj1nFW+tQASIYD8SU3JyeJ8EHtdxPyGhWDTld0xxjmpE/6YREZ2EmWrVQ39ojywnw3c+JTfZuLjSG8AnY+jlOiAwgNW/Jcn68FmhXCiIKrFOBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861723; c=relaxed/simple;
	bh=SozYuVoGZ82/hBbj9pOn4i71JXr39J4rb8Fda1/HF2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OXtHn1TxHptBm2juw9NTfc5GQvBO1LpxtQ+NORW4Z41WuzY4DJ8TcxGqawu8F0hTzlmTtfqx0itXNR88amu5XyY9Fq8GOh6pqgVdk/DEEBdQR1DjVVsXUoX2qPy1Ta7ydTnw+TI3zmU9lPdCEpoomPhU1STUDKyeR6tlWdyMCx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dD1F1biw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e3c3aa8938so55658755ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 05:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715861721; x=1716466521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ioNigop+YRs/yu7C5J4vy2YtEovm2LIax4d5nifJqE=;
        b=dD1F1biw9wmmMzezgUGsNJsB9QR2x+uhGcLVt5DLyd9NDwY9x8ff0BYq7iWdUY0GJJ
         lw45fuMYzgBwkuendqUpdsEx4eiQT/0P/mofpkiGqo/iYurEG7iDb1uGLYwWKWz8d41c
         /E3zj9aly52lVIzcbVsJzcMpTt/kaJ9X1Mv80zLksgaSdEkHZxFPfXbMNX0HLHPilVju
         lqXvJOMafvzeEKrn0m+sBqqIX+95T7iYJ9fAHtKFWLB3kC+xQpLK+EA/IJJIy98Tk+pL
         Qht2zkcuecFGOxBnAtzdUNrEiFBg/9VBOvRe9apNmwjMdfZSIhgfAnHOB7BbxQtxaIw6
         Q+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715861721; x=1716466521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ioNigop+YRs/yu7C5J4vy2YtEovm2LIax4d5nifJqE=;
        b=QdcySZsHcYPh6mW+rHpSeKrOPoH1WMrx0U2GLxRloT6WXEtS0x+aGvFmGlg4FtH9mb
         GxOi6+yWS5QP5DV434gtKKRvZ3mTtVhWrrmc4C7D0Gy9+3oisxxeqSeFd9BEDetHyI6j
         CyaRQ14mBEzWYIW7MdHsyn+OnKz8he01mbGick2FHOBNyTfh4W15jrOLEyKH4sbCLMQm
         GjLva4++biUM8rwMLcI1y5i0Ti6LU6TsdHFNoe1MYbaIndoejbSIkCPTtLlMZqetrZWa
         nSgQ/u5FjX2wXShOJETSVyBRDkZ2XWHehJsMtJuEU0kKDP0xsTf7jZhTLfGTVBKRoSHw
         rvdg==
X-Forwarded-Encrypted: i=1; AJvYcCX9teY3nxvQ/m3Eq1bE91RyoCvYUoxfnrAhevSO+eEvdkFPv3W7a/vsBBvuwpQNyUywnRoHnGRSeH86r1LJ7lmPTJHcDO6a6Q3JllzG
X-Gm-Message-State: AOJu0YyOQxB0PwBaybJXErijhEKfMZV2OQURUmdOCONy5M48w55aqTRG
	l0v5h36m8thL267/RPF+ll1uqviXc0TvuRon2D/xUkD3JeaH/COO
X-Google-Smtp-Source: AGHT+IGV6HzPxZ3Fqfjo6kNHJDzLjJZs4he76NtC0LWoZCoSKgKfFZ54pjEXlzHLBo1kc50FRScyGg==
X-Received: by 2002:a17:902:ecc7:b0:1ee:fc5e:5cfb with SMTP id d9443c01a7336-1ef43d185f5mr234625965ad.19.1715861721116;
        Thu, 16 May 2024 05:15:21 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad61c7sm137634015ad.68.2024.05.16.05.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 05:15:20 -0700 (PDT)
Message-ID: <4c255baa-99e3-4f48-9303-13edb99adc89@gmail.com>
Date: Thu, 16 May 2024 20:15:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm/ksm: rename mm_slot_cache to ksm_slot_cache
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, willy@infradead.org,
 izik.eidus@ravellosystems.com
References: <20240428100619.3332036-1-alexs@kernel.org>
 <20240428100619.3332036-3-alexs@kernel.org>
 <2e074a0b-7ab6-4381-9216-31f68a738a07@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <2e074a0b-7ab6-4381-9216-31f68a738a07@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/30/24 8:57 PM, David Hildenbrand wrote:
>>
>> @@ -2972,7 +2972,7 @@ int __ksm_enter(struct mm_struct *mm)
>>       struct mm_slot *slot;
>>       int needs_wakeup;
>>   -    ksm_slot = mm_slot_alloc(mm_slot_cache);
>> +    ksm_slot = mm_slot_alloc(ksm_slot_cache);
> 
> Similarly, this makes the code more confusion. The pattern in khugepaged is similarly:
> 
> mm_slot = mm_slot_alloc(mm_slot_cache);

Could we rename it to khg_mm_slot_cache in khugepaged?
 
> 
> I don't think we want these renamings.
> 
> E.g., "ksm_mm_slot_cache" might be a bit better than "mm_slot_cache". But then, we are in KSM code ... so I don't really see an improvement.

Thanks for comments and sorry for response late.

yes, ksm_mm_slot_cache is better even in KSM code. As a cscope/tag dependency patient, this change could reduce much of confusing in name searching. And that's why a one-side change satisfies me.
Yes, maybe better naming could make it more readable, any more further help? :)

Thanks a lot!
Alex

