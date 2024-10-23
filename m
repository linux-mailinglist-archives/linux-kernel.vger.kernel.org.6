Return-Path: <linux-kernel+bounces-378768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052199AD543
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08421C20F26
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88571E0DFC;
	Wed, 23 Oct 2024 19:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGKLw5Mi"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16A81DB344;
	Wed, 23 Oct 2024 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729713561; cv=none; b=pwfRX/XjuXvEm4yM5cpr1ZClstc2ImsNIVaxypG7Ws1+jr74VdFMTVxn/4jWU/XSFfeEnx/fPxZKR+vOl8P3kpued7KvNhqPQBb7iu4y4IKELSDMbmH9yqOzfa5N52ENOSpYf4mpOUjQW0gje/geMGT8/f0phJmrg/5R9OMpgKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729713561; c=relaxed/simple;
	bh=+I4mSgQGwe3ATxt7P/1IrYf44EOzS5wwDRtQixzVzns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWPhfrEEUhoq3nfEgxHt7tGWrc6BTHrGKoeOnOfqiPcmmKn8kFy0JzKI/clFSX/vSpLDqciM7ozZC9DCca22Ta2q8KiKcsxxS/eFr8axlOi8+BKJtRS9aGBj7FmAkRXGGRgyWDlmFZI69ncK51UqN9+V6JUwMC/lKoXX0NKkIUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGKLw5Mi; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so64901f8f.3;
        Wed, 23 Oct 2024 12:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729713558; x=1730318358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Prb/5U/d1UncvwAF9dWqt2zvDqK9JgjuoQ+MlopXH8=;
        b=jGKLw5Mi041iMg88fpKpOw4SxhSBQVJ3NXpQRKY/Ec76qJkOA7pPwva/Jtvg06eobh
         I9vliuUDZfcJ6vcGC/+DQYZ/N4Eoz4Se3mjl3D6BAcrKXOFHUF5cUngdqZFOk6FeAeAy
         jATf+cZg+qRdN8nega2LdlA94mJnQ0tCdAqSTtyTP5JA2xzdn87IQNS/WM6Ei5/UUa5W
         PjP94ElNmFldDAeGBIYmJ/ys62RRzO9cVM+Yb2bTa1filhOAX3OSwFk6BGemiYQ09dKo
         yhNYJ+wCuo0pvRGl0IFD8UVwsJjvoQeh+GwSBjXd5wBZ/R89IY/AOyFzjE6z5QOb4Wk0
         JhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729713558; x=1730318358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Prb/5U/d1UncvwAF9dWqt2zvDqK9JgjuoQ+MlopXH8=;
        b=PvIguXZYztclgNhEYRv/LruY/6Mry72ncr2Qcx/TgaXQGpusEc4Vw7Fwdirk5IJ3md
         gBofsX2nWhq4FNBpd4sg9jOsOsJPirJ2cQqJcNRNWPQIRHN6vJFTSMqiMl4VmX7YQHKU
         a7WfTrQkOYIZmibnmXKWcnaMZzm4PmvcE5cCfYOw9VqZl1W+W0u4/d+CWwqNKtSTqpbZ
         La9zbd4m93VaF0dcx0TLc0j9gP40/OgQMJFTvPB3hpWZJ6mRoI7lEJutnc/F1vgih/4+
         I0D/W46xy5dDCYzqWL0YLOVNofFg1j8TYb981RGLoSRxK/q1+i8iGq5AA4PAR1P8c9Ah
         /hgg==
X-Forwarded-Encrypted: i=1; AJvYcCVC4r1rhQf+/jbcHPo2GgxxbSPMRl0cSNX93A6c2OGNfKEQJmmcsy/EmlVsm5HveW1kV78B3Q3ABCQ=@vger.kernel.org, AJvYcCWixtemE1rFyK9YkDXnXEfGfKEXX1bycXP6dFkE8rsxpGsHltGwcMgIgtDxD6SeAPGenMCpe6Dc1jJaqh5G@vger.kernel.org
X-Gm-Message-State: AOJu0YzVi++27UwEEvY/mUB+xO4YJ/Q00TD2q9vGywOV/WSmXfEwKzah
	H1FS1+y7voU2D9Rj5BhYvAG5oenDwlRgvmUw4CfPRaCBITgB1Sy8
X-Google-Smtp-Source: AGHT+IEB5S3o5SgNjIEFoWd9QQ1pAsLV3sBqn3y25leZXJvbeZg5idbz4Svpm4ePBGHIc+ywtbIx0g==
X-Received: by 2002:a5d:6acf:0:b0:37d:4517:acdb with SMTP id ffacd0b85a97d-37efcf06b85mr2192664f8f.20.1729713557762;
        Wed, 23 Oct 2024 12:59:17 -0700 (PDT)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a5b98asm9646228f8f.61.2024.10.23.12.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 12:59:17 -0700 (PDT)
Message-ID: <71c0c05b-d731-48c2-8023-5c7cda3518a1@gmail.com>
Date: Wed, 23 Oct 2024 20:59:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: avoid VM_BUG_ON when try to map an anon large folio
 to zero page.
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: baohua@kernel.org, cerasuolodomenico@gmail.com, corbet@lwn.net,
 david@redhat.com, hannes@cmpxchg.org, kernel-team@meta.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, npache@redhat.com,
 riel@surriel.com, roman.gushchin@linux.dev, rppt@kernel.org,
 ryan.roberts@arm.com, ryncsn@gmail.com, shakeel.butt@linux.dev,
 willy@infradead.org, yuzhao@google.com
References: <20241023171236.1122535-1-ziy@nvidia.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20241023171236.1122535-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/10/2024 18:12, Zi Yan wrote:
> An anonymous large folio can be split into non order-0 folios,
> try_to_map_unused_to_zeropage() should not VM_BUG_ON compound pages but
> just return false. This fixes the crash when splitting anonymous large
> folios to non order-0 folios.
> 
> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/migrate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e950fd62607f..7ffdbe078aa7 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -206,7 +206,8 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>  	pte_t newpte;
>  	void *addr;
>  
> -	VM_BUG_ON_PAGE(PageCompound(page), page);
> +	if (PageCompound(page))
> +		return false;
>  	VM_BUG_ON_PAGE(!PageAnon(page), page);
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
>  	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);

Thanks for fixing it!

Acked-by: Usama Arif <usamaarif642@gmail.com>



