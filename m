Return-Path: <linux-kernel+bounces-372607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DA79A4AE8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 03:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA46428456F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD8D1CC897;
	Sat, 19 Oct 2024 01:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmiNoVH1"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD60192D98
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 01:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729303065; cv=none; b=seIH+InlQc1skXiKXMRfL3KaAbh1rvlPOCR23owp2YXxFhB9+miX+YdtGbRx37CupjkWAPpHlqfRNZcgCVl5BNnxRA9GlXhCEfwxWBJLMZ7d0L4VgEslj9bQ7OnHmPe09NfOS6LdHcn0WB+WaPTByL16yt7I7rAHZ8M3SfGzl+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729303065; c=relaxed/simple;
	bh=VegzcmNKSCsDw6nnEH9RQsjVDD/QUcApo+a5M39zyK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPxwHjq9S0zeSUBP1okuHabgZ/GxskHzvnMLF7evVbdOa4JJL8HIRE3xQMf/rf1psw7qBML2dYgOK+6WzccF2V21qxfD929owoLeOjuGFEtydEMEU27YnBcmzEE8fJuur8NZLx3g0BcLR81AeN040UFIF4rrNGwGwkePCQhKOPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmiNoVH1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c96df52c52so3349477a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 18:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729303061; x=1729907861; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EsGhrsXB+GEbAkiYIA6Lsvq2VDZw4frkC3ls3LwMZRU=;
        b=cmiNoVH1EXNvItPU6omx/lZ9VHYb1Z7etO11JDK4mleEV6a/HfE7Nl2rMBRHhsTOv0
         lGDLMBAEELY89owWIf/kz14NOLq5qOa32NbuYyAcqqmMuiLfVuGsglsaesApR2MdFP3i
         Jh+4nWui0Fa2IIXZGJr4eqzOa7wXtnl0yyhdHt9iP8MZOKYSbeKRJctCnnteGovYnOBH
         4Vvt5QhcZgvqvBDydaE4E/lCr/FjIc5Rzj9RO7fRNl2Ljxa/rwTou13UnkU1nQ/99Chj
         YyxFYzaxJPmQX21BYBkxI3boIBlBAuE8cefDnjwcRmawYGFrXn/eXT8D5LxkMNsXQUFX
         pNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729303061; x=1729907861;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsGhrsXB+GEbAkiYIA6Lsvq2VDZw4frkC3ls3LwMZRU=;
        b=rjidqxwq9fwrijKyFfSsK34an5RFlbj8UymqknQYlrOl6V/+1dNqQFYookJ6EfyXas
         KO5xG3KocA1oZ+GRknEU+l7WIFCvcaZkf2WA9nvHmBcPAzdIAidFL3BwmjsESgxYOqz9
         APhQ40M9fES4K0FyHMnki2XmHD7GCICAqfByKkY7wP1XUK8DFibai5EcYCrInMxNAs7n
         kVf63CSPBzmPW+kWGD66Bddobjw/TUsSrI8uso9DnsMOn6jTizQsh0VLmBVV4xrQl8Zm
         nCsnMBILQfeelFn8qX4/QRLMy5zxvYDyqAk4w3xP1LrDXjWXyL+nWG7r9XdJpsCea01T
         y6ww==
X-Forwarded-Encrypted: i=1; AJvYcCUXAPkbkz5kQXrGrKrDqcCX3JtJyq7rDfzGYDhKJnm57plFCvUi0WlLw7Wu9ogGn7l7cU8g12cakpbvVOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIz7WRnBS7YfmtjZrQo1JybyUEv8oiJxwSqtGoMIuY7JuXuGwT
	aKoCxcLUhxArjD5Bdm8dQVKb2QogCtDUVlYwszY9F3PcfONJxhTnVts2TMYj
X-Google-Smtp-Source: AGHT+IGzN92B0YhZid6l/XPw1axH0jrfo8cRbNJwxi4WWYg/jDIZN0nTlcnXM93mtqlVGhTwhKg+nA==
X-Received: by 2002:a17:907:cf8a:b0:a9a:835b:fc77 with SMTP id a640c23a62f3a-a9a835bff99mr21814866b.8.1729303061306;
        Fri, 18 Oct 2024 18:57:41 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68bc46fcsm157715866b.111.2024.10.18.18.57.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Oct 2024 18:57:39 -0700 (PDT)
Date: Sat, 19 Oct 2024 01:57:38 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: suhua <suhua.tanke@gmail.com>
Cc: rppt@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, suhua <suhua1@kingsoft.com>
Subject: Re: [PATCH] memblock: Uniform initialization all reserved pages to
 MIGRATE_MOVABLE
Message-ID: <20241019015738.5oy7l6fzbmpeixgk@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20241017064449.5235-1-suhua1@kingsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017064449.5235-1-suhua1@kingsoft.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Oct 17, 2024 at 02:44:49PM +0800, suhua wrote:
>Currently when CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set, the reserved
>pages are initialized to MIGRATE_MOVABLE by default in memmap_init.
>
>Reserved memory mainly stores the metadata of struct page. When
>HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=Y and hugepages are allocated,
>the memory occupied by the struct page metadata will be freed.
>
>Before this patch:
>when CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set, the freed memory was
>placed on the Movable list;
>When CONFIG_DEFERRED_STRUCT_PAGE_INIT=Y, the freed memory was placed on
>the Unmovable list.
>
>After this patch, the freed memory is placed on the Movable list
>regardless of whether CONFIG_DEFERRED_STRUCT_PAGE_INIT is set.
>
>Eg:
>echo 500000 > /proc/sys/vm/nr_hugepages
>cat /proc/pagetypeinfo
>
>before：
>Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
>…
>Node    0, zone   Normal, type    Unmovable     51      2      1     28     53     35     35     43     40     69   3852
>Node    0, zone   Normal, type      Movable   6485   4610    666    202    200    185    208     87     54      2    240
>Node    0, zone   Normal, type  Reclaimable      2      2      1     23     13      1      2      1      0      1      0
>Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
>Node    0, zone   Normal, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
>Unmovable ≈ 15GB
>
>after：
>Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
>…
>Node    0, zone   Normal, type    Unmovable      0      1      1      0      0      0      0      1      1      1      0
>Node    0, zone   Normal, type      Movable   1563   4107   1119    189    256    368    286    132    109      4   3841
>Node    0, zone   Normal, type  Reclaimable      2      2      1     23     13      1      2      1      0      1      0
>Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
>Node    0, zone   Normal, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
>
>Signed-off-by: suhua <suhua1@kingsoft.com>

Looks good to me.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
> mm/mm_init.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/mm/mm_init.c b/mm/mm_init.c
>index 4ba5607aaf19..6dbf2df23eee 100644
>--- a/mm/mm_init.c
>+++ b/mm/mm_init.c
>@@ -722,6 +722,10 @@ static void __meminit init_reserved_page(unsigned long pfn, int nid)
> 		if (zone_spans_pfn(zone, pfn))
> 			break;
> 	}
>+
>+	if (pageblock_aligned(pfn))
>+		set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_MOVABLE);
>+
> 	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
> }
> #else
>-- 
>2.34.1
>

-- 
Wei Yang
Help you, Help me

