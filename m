Return-Path: <linux-kernel+bounces-382934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 876979B152B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 07:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C7C1F2168A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 05:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEF614EC47;
	Sat, 26 Oct 2024 05:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hSQRyF4s"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98F86A009
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 05:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729920945; cv=none; b=MTrpQZgtWs+9P4xuivggVLWJLorUpATKZLZp5I6NvQEN+4rTK+PZLEc0qeRPrEEo3u67hPyHLR+3EvR2rB6+iNE+0GMYCSgNtuKsVXEroPqNf658TNal6GC6TcWp2bDTaVhB90r5OJRjy6PqhFUSN2TDTDImeyaf7b1ofEA90TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729920945; c=relaxed/simple;
	bh=usAzsghngYuQwiNyWCZJNau2Hf3WPP04SV2qw79Hq10=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F4gFNrfYN/PIj5EFaRu5d4dpg8vl3/1xeEZYYDn0ChTNAWl3soPkSA4FB4IEExiSfqkd/Z/CfSBbu5DDcpRHjTl1dLmhYPHU9HOcB6gakwef97cTfbJRGjqjT+eHUQpDV8t0FOGxhVC9DlRAEZcHMMhob5ZWa6150DUcZCsH6p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hSQRyF4s; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ca03687fdso55715ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729920943; x=1730525743; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zAEivNXk9T6Y1/iQJj7zUHpciM/prWWnjcYMP1R7sik=;
        b=hSQRyF4sV71MuBh8tqskCYg0e4XPV7sg/KORmxwaQifozSqE3UrgJ8NyPIW96oiSpm
         K4vFuZ+iHBPGslPPdUa7mkaNvVCpHiMgk2aZ8sbbAGCoTM8NZ5PX6JNGp3G1h0R24AYO
         uGffl3P56eZppgvUCGGTkFWOjST+K0V8R9lz0nmKmMGQHZe70q82EQfR0NEddldqW2tZ
         wofUHY+mwCzlPdBugFIq+pzflyTUn+Y/EOD9156GOR/7O5nszphMrSDTrFkJJCklaTV8
         1hGXV8CfBjp2B/bLMRSyAYAdOt1Nw2rWBVgSEUnStIF0km4UeFtld0v4/xdQH4e0N2KA
         VDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729920943; x=1730525743;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAEivNXk9T6Y1/iQJj7zUHpciM/prWWnjcYMP1R7sik=;
        b=M7zLmq3iP39oJtxny2IFq05UpOgt/VXfXgfc5dhun6+CVvKTX7r5YeTKrwK6GGfjII
         ZD62fB96DPf9sSQY24PaoxF4f0Oi5/G8GzvdACxMwqEtQCGgZXPWH/t23KpMmSRpEhv+
         Cdo3dfSO4M69O6rcHkKg3R1ISdrRZvhinRvM4TkAtgxZoAGI10bTRrlNM+rea102U/Mk
         q8TLS+SSsLMGkRx9NGT2K4u26d2CG2jUmN+icgnaizdeeTN1ypeP1P83m4te6bArJl4K
         +6uPtVk5xiwpfyVYNSiNRKttwwas80JG2GIEIG+QDnE6T+R6WdvvxpMx6KMGhbwZcxfY
         dm5g==
X-Forwarded-Encrypted: i=1; AJvYcCWzmh3qxixXNT48m46iU9vDwuCjuwzvaUD29OKhFL+2K0YOvV5f4Vsig1/ogCfiZ2/3b/CCkLGH1g9cNog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx0bfgBTwu41vvPyW3X7UE+/6zY36kvhzTouAvtzl6wHoca7Iu
	wLiD8+zJXYbuYXIgybHtghfRH/w3gKzLgSTDvJzZhiCY0rO2od6PdgiS5qdmdEEkhslg1393s3s
	DjQ==
X-Google-Smtp-Source: AGHT+IF3/5gd/9ow/KXULsF4GA6z8DPDcI/7jJhdYqT/oBsP3+4SDFUpQdjd92McUYwWON6IfKML1w==
X-Received: by 2002:a17:903:1c3:b0:20c:675d:920f with SMTP id d9443c01a7336-210c7bd6333mr827035ad.25.1729920942674;
        Fri, 25 Oct 2024 22:35:42 -0700 (PDT)
Received: from [2620:0:1008:15:a73a:2b46:3ef7:2150] ([2620:0:1008:15:a73a:2b46:3ef7:2150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e36a3114sm2562794a91.29.2024.10.25.22.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 22:35:42 -0700 (PDT)
Date: Fri, 25 Oct 2024 22:35:41 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Yu Zhao <yuzhao@google.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, Link Lin <linkl@google.com>
Subject: Re: [PATCH mm-unstable v2] mm/page_alloc: keep track of free
 highatomic
In-Reply-To: <20241026033625.2237102-1-yuzhao@google.com>
Message-ID: <4abac91f-bb15-b6d3-4c9c-fd66fae39243@google.com>
References: <20241026033625.2237102-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 25 Oct 2024, Yu Zhao wrote:

> OOM kills due to vastly overestimated free highatomic reserves were
> observed:
> 
>   ... invoked oom-killer: gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0 ...
>   Node 0 Normal free:1482936kB boost:0kB min:410416kB low:739404kB high:1068392kB reserved_highatomic:1073152KB ...
>   Node 0 Normal: 1292*4kB (ME) 1920*8kB (E) 383*16kB (UE) 220*32kB (ME) 340*64kB (E) 2155*128kB (UE) 3243*256kB (UE) 615*512kB (U) 1*1024kB (M) 0*2048kB 0*4096kB = 1477408kB
> 
> The second line above shows that the OOM kill was due to the following
> condition:
> 
>   free (1482936kB) - reserved_highatomic (1073152kB) = 409784KB < min (410416kB)
> 
> And the third line shows there were no free pages in any
> MIGRATE_HIGHATOMIC pageblocks, which otherwise would show up as type
> 'H'. Therefore __zone_watermark_unusable_free() underestimated the
> usable free memory by over 1GB, which resulted in the unnecessary OOM
> kill above.
> 
> The comments in __zone_watermark_unusable_free() warns about the
> potential risk, i.e.,
> 
>   If the caller does not have rights to reserves below the min
>   watermark then subtract the high-atomic reserves. This will
>   over-estimate the size of the atomic reserve but it avoids a search.
> 
> However, it is possible to keep track of free pages in reserved
> highatomic pageblocks with a new per-zone counter nr_free_highatomic
> protected by the zone lock, to avoid a search when calculating the
> usable free memory. And the cost would be minimal, i.e., simple
> arithmetics in the highatomic alloc/free/move paths.
> 
> Reported-by: Link Lin <linkl@google.com>
> Signed-off-by: Yu Zhao <yuzhao@google.com>

Acked-by: David Rientjes <rientjes@google.com>

