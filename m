Return-Path: <linux-kernel+bounces-242191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156169284CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83126B260DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF96C145FFE;
	Fri,  5 Jul 2024 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGXcW9rO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B881145FFF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170598; cv=none; b=eJIQsdE3xSpR8q2c5jch2cYDHWURPwrL75SSBNmC7F1jr5O/DNpAWGtaMgxagqmnft4GkjO5+k7/uR6a2tB/aTxL4BSlZGZsKIhuQuR0PM9qsDOGJZuh8eleyNjp2AKrjTIasTa72nkJly033v3sc7zHOTDOh86UrxK/2adQw1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170598; c=relaxed/simple;
	bh=l+jHq9fn81UhHpV8E6Q9Ndw+zI2ygoQDRF6TUweEXwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kn+5frzhlEj+7BEM/7O6r/01/RRVNlzCEo5G5hT+6KbpQREbHIsaXue+dKMPPkhd+gLgMO0vZAFl+M6mBSlsM/RlGf700kN5h2cohanzCJ0gEfTF6ABe5/SV5Z64iBHM1p42XbGWGyCibnI+pmPhl4WnygEeOi1TRCfjF+OTRps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dGXcW9rO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720170595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aFJYg4m2e2eg3RsBdIgmHBTdxJExCb6R9/Wx7tT8KRg=;
	b=dGXcW9rO90+a4VC/wXQNYVHQQ8sLrYuj3q7ec1ij8uA8+TYllnNzzdk+g8kisO1OM9T97m
	9wbA9pGGecNMPMKIF0a/KPdvUq9t2Mcnre2bQfX0G4SEWa9Rfuh4BrJ6XpYPSEZAbzDeJE
	oae+dA86xX1HbhqtrOyWOXfDBXGjdbA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-i1zEz4YrNoKk9e1CmRot8Q-1; Fri, 05 Jul 2024 05:09:54 -0400
X-MC-Unique: i1zEz4YrNoKk9e1CmRot8Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-367962f0cb0so1007229f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 02:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720170593; x=1720775393;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFJYg4m2e2eg3RsBdIgmHBTdxJExCb6R9/Wx7tT8KRg=;
        b=YFmtEIQ29cUtLGMFSjikgu20vzsu90TFFJb4ENt/HCjBfUfxTzLTQjEzM5f2O0Rb77
         ZWK5Fzo3FnqLKSTWiIRTOL85rShDP6FuZS0em/ZiS+2txxEut6pAQm95tDY/teax7vPk
         bUw7/B1lR3jB4BE/mMepm+WBQldYSWqk2EoCVSjh0SCu+smg4XtJsBO7JTikScnX4ssb
         Vmus45jdZq+AXBntZ2mGpr6XbBsZeXBF55P6AkP4P0Ap8vic/9XlKLh2ArYB1umtiMnn
         krhLTUu85paDl/WBxD7F3NqhZcCDPMdxBCjD8+yr71IU8Unv/4l6hje7Yq8KTPpkWnK8
         taLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMnTP9ggw2IcI1HnCM4RBhIq5cjZUoQC44x1bEb2XEfT65k1b2tnvFveHaRB7dgxW11r9z/eORBDk+K/GWj4N7q9QRX7D7PVFrAoX2
X-Gm-Message-State: AOJu0Yx79yBOAID38zLf9ViLfuoRw0shDNC7eEiXLdt8LGPpu2LPES/r
	b1GKRz6hD5PD7aizOmeG3XvQfdDwp2pHJfkye7xOpoDbDmoCtj3wc6NWCYk1YLq5LwhxJjkcRmA
	Z8+kVwFYwNjAavuNQU/X1ULs6DsScl5er2B7dRV2LCU3nmv/Ztw0wDRy8yTBiJQ==
X-Received: by 2002:a5d:4588:0:b0:35f:208e:6172 with SMTP id ffacd0b85a97d-3679dd23984mr2305903f8f.27.1720170592911;
        Fri, 05 Jul 2024 02:09:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWCVMiu2eBNN+sKndXDaoR4kVsqkmRb0xwI/eDn0KBHjwCpgzn5GIqq+vsy6s2YdaGbBI4UA==
X-Received: by 2002:a5d:4588:0:b0:35f:208e:6172 with SMTP id ffacd0b85a97d-3679dd23984mr2305893f8f.27.1720170592485;
        Fri, 05 Jul 2024 02:09:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:b500:3ed7:a1c7:447e:2279? (p200300cbc702b5003ed7a1c7447e2279.dip0.t-ipconnect.de. [2003:cb:c702:b500:3ed7:a1c7:447e:2279])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36797bff8cbsm4838919f8f.14.2024.07.05.02.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 02:09:52 -0700 (PDT)
Message-ID: <fe3ccab5-25bc-4cd3-9628-60fe6e8e3cf5@redhat.com>
Date: Fri, 5 Jul 2024 11:09:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: add docs for per-order mTHP split counters
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: dj456119@gmail.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
 shy828301@gmail.com, ziy@nvidia.com, libang.li@antgroup.com,
 baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Barry Song <baohua@kernel.org>,
 Mingzhe Yang <mingzhe.yang@ly.com>
References: <20240704012905.42971-1-ioworker0@gmail.com>
 <20240704012905.42971-3-ioworker0@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240704012905.42971-3-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.07.24 03:29, Lance Yang wrote:
> This commit introduces documentation for mTHP split counters in
> transhuge.rst.
> 
> Reviewed-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>   Documentation/admin-guide/mm/transhuge.rst | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 1f72b00af5d3..0830aa173a8b 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -369,10 +369,6 @@ also applies to the regions registered in khugepaged.
>   Monitoring usage
>   ================
>   
> -.. note::
> -   Currently the below counters only record events relating to
> -   PMD-sized THP. Events relating to other THP sizes are not included.
> -
>   The number of PMD-sized anonymous transparent huge pages currently used by the
>   system is available by reading the AnonHugePages field in ``/proc/meminfo``.
>   To identify what applications are using PMD-sized anonymous transparent huge
> @@ -514,6 +510,22 @@ file_fallback_charge
>   	falls back to using small pages even though the allocation was
>   	successful.
>   
> +split
> +	is incremented every time a huge page is successfully split into
> +	smaller orders. This can happen for a variety of reasons but a
> +	common reason is that a huge page is old and is being reclaimed.
> +	This action implies splitting any block mappings into PTEs.
> +
> +split_failed
> +	is incremented if kernel fails to split huge
> +	page. This can happen if the page was pinned by somebody.
> +
> +split_deferred
> +	is incremented when a huge page is put onto split
> +	queue. This happens when a huge page is partially unmapped and
> +	splitting it would free up some memory. Pages on split queue are
> +	going to be split under memory pressure.

".. if splitting is possible." ;)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


