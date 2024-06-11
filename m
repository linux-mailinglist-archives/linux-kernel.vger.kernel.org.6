Return-Path: <linux-kernel+bounces-210080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB6F903F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0CB61C23111
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8CDC8FB;
	Tue, 11 Jun 2024 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbSEq6gq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE0B11712
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117186; cv=none; b=seRzQ7r59swvv0UHHFBIU0Hs0vs3dRYF+pJlFYzUMWAPruyU0m0TMcj5Hi5nXg+DqHYEjxKYMR7PYncIU6odMSNDFwkb9Z5vY+jFfc+TkhYo9v+vt9+UXrrvMUSQdWadNgNUXA6T6D/gosPSm80j/gE6CjQ6YpfnncM7vG++yw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117186; c=relaxed/simple;
	bh=ZRBJzYpQdu6w/3iYK8r4nBiCfts+nOEgNXblqHGw6rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3J1BsqwVmgb7YG09bN00YYX5Of1aK/J3ygctFLekoHowlHloOq9DLd5zCtJ7q2bxJyMASS0rdBOKCL9lxuEGZzQnUbp0zjGtOdyxTi3dh6Er8bciA4Di3KFuXYe/iYpUEt/IDjdTphn2V5Rejun+kPbKF5OQIzJQw5f48JkDMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dbSEq6gq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718117175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Jce3pdkqdZlrremKxwghUc29odD6rN0pClyz6qq6WC0=;
	b=dbSEq6gqZV6Byi/yQfiUaVVZodW9Luzfx6nk7KepKRkLrTGI/bMCgL08sX5bmZFFRnXu0z
	oYDO0D6Guh7l0rcxexW24LrQlf5mSJylt/6ZNcvnYVcbQ1CSlV1gAeUDicJILsCzTKcKcL
	RgEBkeeh9TuCCY+ujTtHA7KeoA0tSq0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-fnpVGqIvNq-kMOdyWt6MBA-1; Tue, 11 Jun 2024 10:46:05 -0400
X-MC-Unique: fnpVGqIvNq-kMOdyWt6MBA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42120e123beso50891615e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718117163; x=1718721963;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jce3pdkqdZlrremKxwghUc29odD6rN0pClyz6qq6WC0=;
        b=VhZTeBPHsFSh5OLk5uDiw08N+XPxpkPfSgtRVHU2zorhgkyHEjiUSV6MORhhHLUhiC
         SbEQxJxBX2C2RaeacvvCFukjLglrSy1XLpUqZyutTbaCnlc1lub1gAcpAppUTELQbSZz
         FBH278kpih+bCpVkX+BcLlSZ9S0GuiJH+OUKUUwp7uPu25nKj1xk/UZiSDReDSg5wkcJ
         kaS2kPiZMHTCVYUkbZRmxK4YJkIENprP6IR+tQia3/nE+f1p6+axk1SbqNURpyvcS3tU
         y/yKR6MgKggY8K+9dIVS6QdnZFAG1Cs0FSuS4rHeHrp7n6/B+FvExTnNMMG6Yku7omSw
         W5Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUb7eP3tQgG7ioWaD4fCFPnAo6waPmRMAShCvUZHXX1f5lzz+IgHIk9VYpzM6nNgbHgWp6FipfU0RaCphDMbjRkhq8hdjw56uruRDsd
X-Gm-Message-State: AOJu0YzsJ8Juw+IIQZi3lKXlZ0R/yI5C7ftrEbidU/HEotlV+/R4afbL
	GJpev4HlLXYrNUDzbhkCxqNHwFompFYM6rM1Gohs6VeIwqWONc2l7Cqxrnu76IA6C8u59yckUyV
	fCqzwTHRNcoqOPbzI+oiALvKVDunGdd2zS7gT3gLHK9oyfJNxlZle6AR74TiByQ==
X-Received: by 2002:adf:e385:0:b0:35f:1b08:8b9b with SMTP id ffacd0b85a97d-35f1b088cefmr7253038f8f.34.1718117162754;
        Tue, 11 Jun 2024 07:46:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECp8jAMekTi1TiI9P/squ83h89VUg7WD+tZRwORo4P4MPUGAvcLMBRnI/9kmj6Oou9/jx21A==
X-Received: by 2002:adf:e385:0:b0:35f:1b08:8b9b with SMTP id ffacd0b85a97d-35f1b088cefmr7253006f8f.34.1718117162079;
        Tue, 11 Jun 2024 07:46:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c748:ba00:1c00:48ea:7b5a:c12b? (p200300cbc748ba001c0048ea7b5ac12b.dip0.t-ipconnect.de. [2003:cb:c748:ba00:1c00:48ea:7b5a:c12b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1c423932sm8262043f8f.114.2024.06.11.07.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 07:46:01 -0700 (PDT)
Message-ID: <6b5392f5-209d-4d3e-b5c3-ba875bf8416d@redhat.com>
Date: Tue, 11 Jun 2024 16:46:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory: Pass head page to do_set_pmd()
To: Andrew Bresticker <abrestic@rivosinc.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>
References: <20240611141849.2788693-1-abrestic@rivosinc.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240611141849.2788693-1-abrestic@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.06.24 16:18, Andrew Bresticker wrote:
> The requirement that the head page be passed to do_set_pmd() was added
> in commit ef37b2ea08ac ("mm/memory: page_add_file_rmap() ->
> folio_add_file_rmap_[pte|pmd]()") and prevents pmd-mapping in the
> finish_fault() path if vmf->page is anything but the head page for an
> otherwise suitable vma and pmd-sized page. Have finish_fault() pass in
> the head page instead.
> 
> Fixes: ef37b2ea08ac ("mm/memory: page_add_file_rmap() -> folio_add_file_rmap_[pte|pmd]()")
> Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
> ---
>   mm/memory.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 0f47a533014e..f13b953b507c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4764,7 +4764,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   
>   	if (pmd_none(*vmf->pmd)) {
>   		if (PageTransCompound(page)) {
> -			ret = do_set_pmd(vmf, page);
> +			ret = do_set_pmd(vmf, compound_head(page));
>   			if (ret != VM_FAULT_FALLBACK)
>   				return ret;
>   		}

That certainly makes the "page != &folio->page" check happy.

It is *likely* incorrect if we would ever have folios > PMD size (which 
we don't have on that path yet).

I assume that the thp_vma_suitable_order() check would detect any kind 
of "different placement of the folio in virtual address space", where we 
could mess up.

Question is: should we instead drop the "page != &folio->page" check 
that I added?

I think I added that check because I saw the "compound_order(page)" 
check and assumed it would return 0 for tail pages, but missed that we 
get the compound head first.

-- 
Cheers,

David / dhildenb


