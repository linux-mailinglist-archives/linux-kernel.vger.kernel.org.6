Return-Path: <linux-kernel+bounces-235713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 922F891D8BD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B432B1C20FFC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B21F6EB4A;
	Mon,  1 Jul 2024 07:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FoLty7Cb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C30237142
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818184; cv=none; b=h8fZ6gREAbvfBKbUOy5roqJ6xiMp+Eb2yY9HLuluhoOBjrgaijBoeEsRPkeoaXCm86xmRTl+xj6Is+ArCtGFoEEOKJOS0gVIiKFDRQ3CbEqrmSjb2TTWkqwDu+1siyMNdskdBS6/QNDZlQ3nhQ9C9aatVMmbvW57Mcx0y/t55X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818184; c=relaxed/simple;
	bh=dOMarBKZ18jQPZN369QghDnyCX3tWfI8sJ3G1laylaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDaAU46oJEIER+IPJzkquMtvaAu4bOFv7ZuRwaPhR40C4IGJm53sOonqYwj/arbGVRJ90rpRtk4kOmIYL7LFTStk1RD2H3D0thioKWTbsRPfaej3udQjLXf6dTesc4RNPOROkg7fj3JSn5BxaZjhJogtJ132bVSuCW++81WAWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FoLty7Cb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719818182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8JfdcBztykHv7SZCf3/9h0jEo4muyHDDQXPVpChEDAA=;
	b=FoLty7CbiP8ay6Jq+IHG+U5NPoRNb9yZWmcCwmQZvS3tezGige+efwnwyV/yUqE2glpwLG
	bc1kp/M4Fzq6bCw02CguT/tUKs7ah8YmcTcziCVj8tn0mRQK92205Vdl7TuQWFrIokKKJL
	C6Yk8fOQf/Ky1kSVAU35dybuo/yiqBg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-r9qwSPXrNiWyc6bHZurSOQ-1; Mon, 01 Jul 2024 03:16:19 -0400
X-MC-Unique: r9qwSPXrNiWyc6bHZurSOQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52e71284e6bso2905232e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 00:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719818177; x=1720422977;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JfdcBztykHv7SZCf3/9h0jEo4muyHDDQXPVpChEDAA=;
        b=nL8yXUTfc8+pPAyFXY850+zIDcoN6Js7fp5OaiR5ebOPoiXQF2fCMq3DC3fbirfQii
         BZ+BR8i3Vb3v2sMCoAmmaGvpc4oTlQhbz1zpS2qNGXx6Qdwku/+uf8lnN6295Oj8YsRe
         zc5m3LhbljtrX92XzKpNp1GtkgjH6SMPqkmgDQOFMYwJ7v+Sj3tnAw1MOA2iAqH2NTvq
         QwgzO4/7gNF4tIZeUjjCc5k9H+++HIEq86sS+z9VVmhZL1DA7LqLlz4YW9WqTbZAzh7S
         eoHncoDMPR2FYwbUTExOzvClk/HT54d3BHNyoxGmTusQbatw/cc87j9FxnYnLtZjXngg
         n2ng==
X-Forwarded-Encrypted: i=1; AJvYcCU+9I+z9StSt3jlHhEfURxYmdwzKlxlogL4uKUI8k9Bq3lR+9vr/Fy5S1minsZy0cPjFJOJWNvepgZpuySok+DMfSI/RcFC0THAsCBh
X-Gm-Message-State: AOJu0YxAVkDJFrwEf+opOKVgVjOE2rs5H9UTUl9xTIJeeZv2Q9GyrcxZ
	8oTLpsINO9a3KeW/hCjBmtF4P+U1IBVW0p2ZTU/fhBs/otJqJ/9G4vu9dKP+3zocqO/SI2wcUw0
	PPsQRJLsJSnJmYzTCU6RGMEc7bmxE9dWeerUeqpPOcTCggIgQXeVcrRJ3uYaSltdo9F8cxA==
X-Received: by 2002:a05:6512:acd:b0:52c:caa6:13b4 with SMTP id 2adb3069b0e04-52e8264e4ecmr3267626e87.3.1719818177610;
        Mon, 01 Jul 2024 00:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT2V5ZaKNBGJqnuJOddd7plBXqWkJgxY3Mpne6UC9CIUcuEK6PRcUrym0jM3JMNWkpytfwdQ==
X-Received: by 2002:a05:6512:acd:b0:52c:caa6:13b4 with SMTP id 2adb3069b0e04-52e8264e4ecmr3267580e87.3.1719818176150;
        Mon, 01 Jul 2024 00:16:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72e:2200:7ed7:c239:d423:3b31? (p200300cbc72e22007ed7c239d4233b31.dip0.t-ipconnect.de. [2003:cb:c72e:2200:7ed7:c239:d423:3b31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257cad6beasm61234835e9.47.2024.07.01.00.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 00:16:15 -0700 (PDT)
Message-ID: <5b9dafac-1561-4dfa-a0ff-9445cddc0932@redhat.com>
Date: Mon, 1 Jul 2024 09:16:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: gup: add forward declaration for
 try_grab_folio_fast
To: Zhao Mengmeng <zhaomengmeng@kylinos.cn>, akpm@linux-foundation.org,
 yang@os.amperecomputing.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240701034052.9988-1-zhaomengmeng@kylinos.cn>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240701034052.9988-1-zhaomengmeng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.07.24 05:40, Zhao Mengmeng wrote:
> try_grab_folio_fast() was used in gup_hugepte(), while itself was
> defined after gup_hugepte(), so add a forward declaration to eliminate
> the -Wimplicit-function-declaration warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407010039.D3sIu3fu-lkp@intel.com/
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> ---
>   mm/gup.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 7439359d0b71..222b83a87d7d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -488,6 +488,9 @@ static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
>   	return (__boundary - 1 < end - 1) ? __boundary : end;
>   }
>   
> +static struct folio *try_grab_folio_fast(struct page *page, int refs,
> +					 unsigned int flags);
> +

This function should really be called "gup_fast_", just like all other 
gup_fast_ specific functions. I might send some follow-up cleanups later.

-- 
Cheers,

David / dhildenb


