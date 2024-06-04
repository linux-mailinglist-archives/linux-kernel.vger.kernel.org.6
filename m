Return-Path: <linux-kernel+bounces-200705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABD88FB3C8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF511C213F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD2A146D7D;
	Tue,  4 Jun 2024 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb6t7siY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DA0146D77
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507736; cv=none; b=rMPNYxSUvNwtjwhODVe+jZnkAcij1YV8OH4d4mHtFu0CoChE6MLYh9vNNHLFWijXe0o4B5bLZUt7SFnYiLFNJD3F0t2jbOcGxavBnq039N68czC2N/lP37U/TbHT3WrVeN6hClIL/thQ7PWoMB0sZQfre2HXBUGKl3j8+0twb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507736; c=relaxed/simple;
	bh=tEP4FxvSBnrhpDRl6WQ4IKX33lUXJ8VWdEL2T2jp8dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q5OBQf6v/k+L6YQ2C825cxHovOJn+EaYXaCoVlZfzOt7tHcoskDAJNyoh/3z9yjhSVmZLIgegbrx0AmS00+vRufd5WduNECgvSf0ynR0glkhJX7u8KPJpszEUhe6qGBI1mXoD4kBUMUzsuCIErmTbPG65ELff+X7+DGFP+eDMMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eb6t7siY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717507733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=42V/ockWwxrYy/bRQBVw5gjEZCwTD2Wh2lZUM6jdqB0=;
	b=eb6t7siY1wxL50RGSA/cmKJXLZ3LfaFBGouXl0oKZ3olr+KvHS72G6nP0szGosAHW5miw4
	TsIPHIAA0fYNeXjB8MporL7suSCPigaqHpqEL7KXaVd66wG08XEa3TGkXaNAetU4q0WqTX
	cnmzlvcVDdgDqTwjUGwhD5vRyIxvY4Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-ZtPJYv4sPmiRPJUFVNSvRA-1; Tue, 04 Jun 2024 09:28:52 -0400
X-MC-Unique: ZtPJYv4sPmiRPJUFVNSvRA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35e0e59dcf7so2508216f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717507731; x=1718112531;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42V/ockWwxrYy/bRQBVw5gjEZCwTD2Wh2lZUM6jdqB0=;
        b=FYemzM64BurVtnvr2/V4Aum/q90Vz2yYZIaLLYED+m4GRHo8SVqSsXfNco7mrKA4U8
         pNpT2OOSPMg1DlFxAko2ZfnhT6Xge/JnLGcAQTnSJA6FE67QxjUna/TussUxsCKgQcph
         +Kuuv9Hb7GhknpqUY7txnq8Oaj5491ygRuHoi1t59L4arRxvWhTcoU7U91hCsI4zOeG0
         x75zT0170wGHurNrLRLxGa1agquFq9fjhynVROFPbLT+9xQOer9POshyfeH25GgoQW8Q
         NIl9nezZrcPYCH5UW4M7bYxB3uGdvK3QMAZVOybev9RcQHe3uvWoZP/la/9Rb9V4zajC
         pIQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlMj+4OjkH692eEkEP0d9BF+m0Jf5IBk1MxBjoufTUaX68jMNwhhnsCfVAdncadhhEkltTuSCVZ0Ctbqlo4OcwimqdUpEiDQ0f6Y4x
X-Gm-Message-State: AOJu0YwYivStoWksZE+Fq4zrqKEflkKhGnrT2HoiEjCQtLsGz+mQBvNi
	zxC4kzAA3yC2VIAQPI89+lBQcMtcaiH6SV7MkXl5u2WHAbhYLFqdAHuYTtZmz9PZjQ9UwN2tQ6y
	iY54kei/9CQJ11+9dBJth56V7K8LAEDyiBiEzHy8lxo2rqJvCZWK2M6FP2MjKJA==
X-Received: by 2002:a05:6000:1207:b0:354:c8d7:e0af with SMTP id ffacd0b85a97d-35e0f2947e1mr7516454f8f.35.1717507731234;
        Tue, 04 Jun 2024 06:28:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFktQuvCXtauGgJWzfxv770xS8RoIJMbHbbiuUoVp/Wok6oTrNjlNqZ9HXfUP6Mz6SK/umj6Q==
X-Received: by 2002:a05:6000:1207:b0:354:c8d7:e0af with SMTP id ffacd0b85a97d-35e0f2947e1mr7516431f8f.35.1717507730838;
        Tue, 04 Jun 2024 06:28:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73a:3a00:a025:9b06:549e:c16b? (p200300cbc73a3a00a0259b06549ec16b.dip0.t-ipconnect.de. [2003:cb:c73a:3a00:a025:9b06:549e:c16b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd064b5e9sm11590372f8f.96.2024.06.04.06.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 06:28:50 -0700 (PDT)
Message-ID: <9bc7eb69-47a7-4565-8672-636273967dc3@redhat.com>
Date: Tue, 4 Jun 2024 15:28:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] use folio in ksm
To: alexs@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 izik.eidus@ravellosystems.com, willy@infradead.org, aarcange@redhat.com,
 chrisw@sous-sol.org, hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240604042454.2012091-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.24 06:24, alexs@kernel.org wrote:
> From: "Alex Shi (tencent)" <alexs@kernel.org>
> 
> This is the 2nd part to use folio in ksm, it saves 82kbytes in ksm.o and
> passed all ksm testcases in kselftest.
> 
> KSM still split same folios to single page if they are good to be KSM,
> but will skip the rest subpage checking if a folio couldn't suit for
> ksm.
> 
> Alex Shi (tencent) (10):
>    mm/ksm: reduce the flush action for ksm merging page
>    mm/ksm: skip subpages of compound pages
>    mm/ksm: use folio in try_to_merge_one_page
>    mm/ksm: add identical_folio func
>    mm/ksm: use folio in stable_tree_search
>    mm/ksm: remove page_stable_node
>    mm/ksm: use folio in unstable_tree_search_insert
>    mm/ksm: use folio in try_to_merge_xx serie funcs
>    mm/ksm: calc_checksum for folio
>    m/ksm: use folio in ksm scan path

I skimmed over most patches, but I'm afraid you introduce quite some 
subtle problems.

Part of the rework should not be do convert things to folios that really 
operate on pages (of possibly large folios).

We really have to be careful about pages vs. folios before we have KSM 
folios. Only then, we know that we have small folios only.

-- 
Cheers,

David / dhildenb


