Return-Path: <linux-kernel+bounces-200248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3831A8FAD86
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023601C22907
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354651428EF;
	Tue,  4 Jun 2024 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgCR/VqG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C451411FA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717489560; cv=none; b=CuAm0hzem2IWH1Bokw7U0WeYDiAumXoww/LGbnlrcFoHCKUr5c+kdK5fKAGE8EGhMhGzDFYiCivjP11HHDP3k01UOwDtbB9zbFTk4vTIN+s6kWGYkPKiUeyoNVfiA83dJNQRKifRt/9dlyzkrJ46Mnt7xvUbQKQ97DKRHikMyV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717489560; c=relaxed/simple;
	bh=qNxnzDKy53PIFkgS58gs2jeYVswgw2Z+GmAq3OnnYzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tU+K/b33wxABbN7MpHFAc7GrOxG47o/gxP+c1Kb2zziYLGnGFVgb/dPf/coog2yCiNdHApGN24Mgrxz3C0N2/Fhsio86Pnq9XhbIlkYcdeKoRivwmmlZUIaLexhJ/JOYWDcRPXtKWGz33BFTY2vw2SNIL+vI3yEgzAi/4/ENcZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgCR/VqG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717489557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jE0tOEDBClU1MS1+Di3jUPhchVgVg3cJr0Jgy7Lz5TU=;
	b=dgCR/VqG7XdjvxBckhIDxpRB/mz0hdNdIBmHpGCrcYnqTK85CruVH2/sIQfu5oVQbM51SB
	vypQARZrREeXYKOXqSTElm0+lfElf/hkt+I5lOwgwUo9djduSNPIEapGTjgmMPly3Ty0+Z
	u/JoPjzcJKFKwUN4xeCOAH14/zx5aGk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-ivD9wTZ2NZOA8-8t1JlAuA-1; Tue, 04 Jun 2024 04:25:56 -0400
X-MC-Unique: ivD9wTZ2NZOA8-8t1JlAuA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2e95a1fae88so41658481fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 01:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717489554; x=1718094354;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jE0tOEDBClU1MS1+Di3jUPhchVgVg3cJr0Jgy7Lz5TU=;
        b=M2gWA3XrPcsXW9mIFKDXOEEWieKpkrR/Zl98ZQ0oEmQ+4E8Q0jDhDkRiRmOvK1UKgr
         KSm7u2N3zubxZOcZo0riJS1DCURo+By249JGcYj/qwK5ixfSrOXcYKW2qnTc0yUugZ+Q
         pMHjvAlIN4ZAUhdq7JETDIAt3pDb6NYo5v48lexHqjOTWCW0IzsOmTN+N8fzHSfa5cnx
         rVaHOAEmM1Fw8WLINCXUq+n+ZbebPOFXvhrTUNGMASKcKqBvPYRQK+jPWPikwJFqjr9c
         V3PJ8wbgbUIhJtZyqRkpYpHf4+7dyMHFwPIFlvWUik/wBFGvsjwN2lQh083u4+VyBh+m
         9zAg==
X-Forwarded-Encrypted: i=1; AJvYcCV5bi1AvOxPy3ukAtcG3/yuqcMoywtB27Ftme+akxSUiAiJaC7RM4460TacTNXf1+f1biaYBJDyikTztIyeLodJoCDwC1E5q5qL7tAI
X-Gm-Message-State: AOJu0YwbaEICVuUIANzXKuHozrPwz5RJbUSdxjKXIuEt0HRWXO3Vf2sk
	Uu8dmG2Bb5x6UNhJiHWEzwdTlcO5e8f5rZkCvvmnJ+BNBd+3EtRUMTd+j53PmH3RZPseJArOwn4
	esJ4pWBDkBxIju4lUH1wtzAfctO3J4rEB2z7NWzthflioXy10vLvrlWZTIDxJNw==
X-Received: by 2002:a05:651c:b07:b0:2e4:45a6:cdcf with SMTP id 38308e7fff4ca-2ea951d251fmr77496951fa.43.1717489554616;
        Tue, 04 Jun 2024 01:25:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjytfx8z1Khf9Tiglv0YUT7Gv0TPmiZstiW9ofhmV2Hwnq8a0q6P6Ju89FbC+QISlCs98siQ==
X-Received: by 2002:a05:651c:b07:b0:2e4:45a6:cdcf with SMTP id 38308e7fff4ca-2ea951d251fmr77496771fa.43.1717489554178;
        Tue, 04 Jun 2024 01:25:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73a:3a00:a025:9b06:549e:c16b? (p200300cbc73a3a00a0259b06549ec16b.dip0.t-ipconnect.de. [2003:cb:c73a:3a00:a025:9b06:549e:c16b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42132d5308csm129525955e9.35.2024.06.04.01.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 01:25:53 -0700 (PDT)
Message-ID: <fd64e502-d40d-4380-830b-2f630de4dac9@redhat.com>
Date: Tue, 4 Jun 2024 10:25:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] mm/ksm: add identical_folio func
To: alexs@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 izik.eidus@ravellosystems.com, willy@infradead.org, aarcange@redhat.com,
 chrisw@sous-sol.org, hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-5-alexs@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240604042454.2012091-5-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.24 06:24, alexs@kernel.org wrote:
> From: "Alex Shi (tencent)" <alexs@kernel.org>
> 
> To replace pages_identical() func and further reduce the 'page' using in
> try_to_merge_one_page function.
> 
> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
> ---
>   include/linux/mm.h | 17 +++++++++++++++++
>   mm/ksm.c           |  2 +-
>   2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9849dfda44d4..2d1f16ffc6ac 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4164,6 +4164,23 @@ static inline void setup_nr_node_ids(void) {}
>   
>   extern int memcmp_pages(struct page *page1, struct page *page2);
>   
> +static inline int identical_folio(struct folio *folio1, struct folio *folio2)
> +{
> +	int i, nr1, nr2, ret = 0;
> +
> +	nr1 = folio_nr_pages(folio1);
> +	nr2 = folio_nr_pages(folio2);
> +	if (nr1 != nr2)
> +		return 0;
> +
> +	for (i = 0; i < nr1; i++) {
> +		ret = memcmp_pages(folio_page(folio1, i), folio_page(folio2, i));
> +		if (ret)
> +			break;
> +	}
> +
> +	return !ret;
> +}

We never get there with large folios. So handling large folios is 
completely unnecessary.

Keep it simple: either VM_WARN_ON_ONCE when a large folio is passed, or 
simply return "false". Then, check only a single page.

-- 
Cheers,

David / dhildenb


