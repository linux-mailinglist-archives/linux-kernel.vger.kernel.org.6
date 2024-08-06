Return-Path: <linux-kernel+bounces-275615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB909487A6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63FA31F2261B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D0BAD51;
	Tue,  6 Aug 2024 02:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LFXcaoDo"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBF718641
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722912035; cv=none; b=EKTuh5DMJLkt2SD/x3FqjrT4s4quFEIHvLHS1w0T8NOOa5e2OvUKo7kDckGiUiBvvsV31PBqxyGSl6s9RZvsN9U6H4n/UKMTrVTTzxuzakmHuwrZwIMiGjmxC2Tb6tQaNoXv6+Y3vdHuOirethBIOVky10cyWEArhxCfBG2GOU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722912035; c=relaxed/simple;
	bh=5MTMVph7LtnkZX63sSSa6T4cy8LDC764kZisWlBMnLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zv7Q0GrnMe6MmhIkRoRQGnmpfgJBT16u0D6GRyXQVPnySnv/opKto6s7AUy4KlL5wB01phk/S/1Rqwn9T96cn1MYu4W0M2RWnZpIZgrbH/jbpp//7Tcf361VGITroHsQ8enErkN8DZ871wFGiSwe4yQFIFVObmed0VyYqqINolo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LFXcaoDo; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cdba658093so105570a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 19:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722912034; x=1723516834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QfqtmhKjwXadJEr1/A8ZX2NKOYaGeD18Xw5OiqWCDqc=;
        b=LFXcaoDobMUKqxgnJeAaDV6Yb8zBYwxwQ8ebXtxMs+H5zWMGLKjrSxUAjDAG2pk4RT
         8HnG96mPipqM7XZoq8YaihFUsJM6Z3V2RYzKdkbDN0F+w5c3XYlZMHvZsEkxkUtjcrap
         3x2tb0z9IjZI842E09pWRJnszHTSQoQYiW6MELRo+L/SP3RRlw91x+BQx5uoL1lCg+tF
         mEoay5JNWpee7fTjG0885inylkSrTus/E8gREUqmlR0R3jchULXZ+GZHHeoBOY2/mA5x
         hTwtAS9KxH/kIi9pGpBJOw2rbmzlzeWXujfy5yUdgo/R2wOzUYn6vvf+0Um/g+Jyuqzt
         6NDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722912034; x=1723516834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QfqtmhKjwXadJEr1/A8ZX2NKOYaGeD18Xw5OiqWCDqc=;
        b=WiVgbboQz/H1fuCBQyTnWlhIuECdTONONlgwMUklh5lZ2kwO7j4lEIM+hUKQgKeHmJ
         dSl6IGBg+OQWnv383gyJE35IGr8nQ56h2L4JupPjzwYikdHjx9S5SBm1mZCCDOQS4EsV
         ZF8wo1VXJ7F1fydZgDYT8PwjcvTDjqsdvyB74LB9bZviHk7yQEy/kPrsO7z1V7TOCzao
         Is8LygG/OUDqgcCw3Ns4r2K/ViMQeZUDKHst4GeTtJ737Sz33iT/ty8ghL9XB/01CUyi
         +h6Zksp1VfDZ/73ArF/afTBK+6LFeYgeGfLl3gRKh3hTnP6orsxvQWmTGcHUN8T6e/Fm
         vfcA==
X-Forwarded-Encrypted: i=1; AJvYcCVowpb9gWEIyKXl1xhbDym+u3zp1vGmlMK81Lwuul0M0HzlBlTG5V/JlEojKOyy/buDJ+hkrvQaFJXkn50OSMsslv2ts/7Mf2aw4nk2
X-Gm-Message-State: AOJu0YygHNwIG/hdY4bHzAEpXg1HYjt5FRk284pYt4Op64dTT5rtTN0I
	WxrK0Z73rA2mioafu+vMAOazJ7wCmrSVGu2ReJ4XhCAdfKvGkNfN8PbCIkBcw/E=
X-Google-Smtp-Source: AGHT+IHqm7MshXB3UiU4CIgrouYuZ7e9nw2w4o/q8nt2g394H5dg9aV2iU3PiPgVb+aLMZiI7T6uFA==
X-Received: by 2002:a17:902:cec8:b0:1fb:31a7:e663 with SMTP id d9443c01a7336-1ff573cc12bmr107107895ad.4.1722912033582;
        Mon, 05 Aug 2024 19:40:33 -0700 (PDT)
Received: from [10.255.168.175] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f556a5sm76532965ad.83.2024.08.05.19.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 19:40:33 -0700 (PDT)
Message-ID: <39281a4d-d896-46fd-80a5-8cd547d1625f@bytedance.com>
Date: Tue, 6 Aug 2024 10:40:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/7] mm: pgtable: make pte_offset_map_nolock()
 return pmdval
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
 <d101b185eb55438b18faa2029e4303b7453bd5f5.1722861064.git.zhengqi.arch@bytedance.com>
 <0e8e0503-5796-4b61-bb5b-249e285f5d21@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <0e8e0503-5796-4b61-bb5b-249e285f5d21@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 2024/8/5 22:43, David Hildenbrand wrote:
> On 05.08.24 14:55, Qi Zheng wrote:
>> Make pte_offset_map_nolock() return pmdval so that we can recheck the
>> *pmd once the lock is taken. This is a preparation for freeing empty
>> PTE pages, no functional changes are expected.
> 
> Skimming the patches, only patch #4 updates one of the callsites 
> (collapse_pte_mapped_thp).

In addition, retract_page_tables() and reclaim_pgtables_pmd_entry()
also used the pmdval returned by pte_offset_map_nolock().

> 
> Wouldn't we have to recheck if the PMD val changed in more cases after 
> taking the PTL?
> 
> If not, would it make sense to have a separate function that returns the 
> pmdval and we won't have to update each and every callsite?

pte_offset_map_nolock() had already obtained the pmdval previously, just
hadn't returned it. And updating those callsite is simple, so I think
there may not be a need to add a separate function.

Thanks,
Qi

> 

