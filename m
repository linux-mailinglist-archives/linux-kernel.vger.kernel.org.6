Return-Path: <linux-kernel+bounces-278164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA7C94AD06
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B475B2D94C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422F385931;
	Wed,  7 Aug 2024 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiXzupRb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DEE78C84
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044740; cv=none; b=PVtLzfPE7H4fmFgnDPd/ASVr2FdvaQJsHjsKINMpqmIfVaH+aLV6GdFBOMO1jMbtTvFpBT4NNveYeAUe9u6ZsV8YnpgwFEAFRfMidp6bRRZjbzd9Fq8VONTXsYk3yAamx5QwjFFWOrYwbmgwHdi97+qCX3Bt0FhGIKu417EcOFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044740; c=relaxed/simple;
	bh=7L4eGSY4O4z4RLBTWo3YiYX/+M/exkbeUvbiTe8zeQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKh6btBsZPBrPjjSGq+NIOcVrQy7gJ1r/Wf0DK90bRN1jCYazyFwJY84MLEPasnIsGgRtNTyfz6st8EPdo4qb/lQGKZUZdvVbiDc1sQ2VPnGfkbtom4FJQ4HcZNPidOa88a6x642C/ATZC6l/pazkbmq2KJ8fE/XB8FUFr4gY+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LiXzupRb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723044737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sq5YuaqDwPgWwWgWl1dZQMpc9N72YWJDiW5Q5wpx46w=;
	b=LiXzupRb1fbkT/qDABJ9vvodDZtQiG1F31wVBRXMfz+MD7JZcMC7eWDywwYYu8Bkww7ieg
	XOnXoFClx4Cl38abqGa5/48irxypClLlIETzevD/TerSJDWUUns5UZI9QseKIK9Mth2wgJ
	Oth4PGF4zmt72i06G2GaT2oFUn/NUgM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-P4DI8O6JOsCyBZiRI3moFg-1; Wed, 07 Aug 2024 11:32:16 -0400
X-MC-Unique: P4DI8O6JOsCyBZiRI3moFg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36bbcecebb4so1426719f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 08:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723044735; x=1723649535;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sq5YuaqDwPgWwWgWl1dZQMpc9N72YWJDiW5Q5wpx46w=;
        b=CE5NOLCC0P1COYs89V3/HZHYqpZ3n3rr6rklJYZYTCEc3NIwwDVRgkP+1+kgMISrSG
         L5PmgwMTaU1+PRA69A+v0pKtk8pHXWb0CvvQhAzhUI8EnMiSOythxTwIdQ7Pj+X47wxs
         9CHxDkId7vzLwzc4J4GOIgkJLR82ng+7LyFpxM0rlzBmu4tBgkY9Je1XqHSqtoGes8bD
         H0LacTGBEKqYgQ4a8Gqz3sDCI7T8A9XQmhgoQIlyTCiWEmItEml39lF2tgi/G42mZIsQ
         ffWHdrutPydLdXu4v4trUhUchpjgbMh4ecSshsz0BeRS+6tUkUin//0u2kEE8zpqkJK+
         +9xw==
X-Forwarded-Encrypted: i=1; AJvYcCVRnQ8Bw4m8Ixi8vstvQInrsnx9aGoPF1jIzI+5wHBWy1ZAKcvJn8aK8psLBNAgrEWeagxwZX6EMGmUknc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKjbNqv84JclSJhmJzKxkWdvxfl+gBEl40vcJ71IaALWDs60jj
	StX+gBOBpjDt1DDAX3JVMPan0K/k0PQgKQkByJZFEd4VTd81Os/ZE173PFl9O63wx0GwpaRNZzf
	FvoVnohdADHfEcwLYovgs4v8WlLt/34SjnnArAnRTUbu9xMg9SYcFTAzikxMCQw==
X-Received: by 2002:a05:6000:402b:b0:368:6633:e23f with SMTP id ffacd0b85a97d-36bbc1a6749mr20316055f8f.38.1723044735255;
        Wed, 07 Aug 2024 08:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB9wUohEToqk0eFBraRwm9P/2alU1eR63wSGxUjjwYuWy2SzxEeeFaSalEjRxSpsWOwGvekA==
X-Received: by 2002:a05:6000:402b:b0:368:6633:e23f with SMTP id ffacd0b85a97d-36bbc1a6749mr20315995f8f.38.1723044734674;
        Wed, 07 Aug 2024 08:32:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1a00:df86:93fe:6505:d096? (p200300cbc7081a00df8693fe6505d096.dip0.t-ipconnect.de. [2003:cb:c708:1a00:df86:93fe:6505:d096])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905796974sm36299085e9.6.2024.08.07.08.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 08:32:14 -0700 (PDT)
Message-ID: <1b0e07fb-33fb-4397-b03e-65698601bc70@redhat.com>
Date: Wed, 7 Aug 2024 17:32:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm: Add optional close() to struct vm_special_mapping
To: Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org
Cc: linuxppc-dev@lists.ozlabs.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, christophe.leroy@csgroup.eu, jeffxu@chromium.org,
 jeffxu@google.com, Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, oliver.sang@intel.com, pedro.falcato@gmail.com
References: <20240807124103.85644-1-mpe@ellerman.id.au>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240807124103.85644-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.24 14:41, Michael Ellerman wrote:
> Add an optional close() callback to struct vm_special_mapping. It will
> be used, by powerpc at least, to handle unmapping of the VDSO.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   include/linux/mm_types.h | 2 ++
>   mm/mmap.c                | 3 +++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 485424979254..ef32d87a3adc 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1313,6 +1313,8 @@ struct vm_special_mapping {
>   
>   	int (*mremap)(const struct vm_special_mapping *sm,
>   		     struct vm_area_struct *new_vma);
> +	void (*close)(const struct vm_special_mapping *sm,
> +		      struct vm_area_struct *vma);
>   };
>   
>   enum tlb_flush_reason {
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d0dfc85b209b..24bd6aa9155c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3624,6 +3624,9 @@ static vm_fault_t special_mapping_fault(struct vm_fault *vmf);
>    */
>   static void special_mapping_close(struct vm_area_struct *vma)
>   {
> +	const struct vm_special_mapping *sm = vma->vm_private_data;

I'm old-fashioned, I enjoy an empty line here ;)

> +	if (sm->close)
> +		sm->close(sm, vma);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


