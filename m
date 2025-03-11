Return-Path: <linux-kernel+bounces-556177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B19A5C1F6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820D33A6C05
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F064E6088F;
	Tue, 11 Mar 2025 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMvpxQs+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7175288CC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698534; cv=none; b=MBoBwAE6N2ESmzMXAK9BAw3gJTN3pNTNHhcEMcFrOkA28+DrZqkNYWVAfL0o50VL54PdUvib7DYDzas4ZfSriP3f+94wZeAfpnucyjApZZFLjmweprnoKHhAB6dxoLiwjiXP9pQALbBzSz4wUBAQXR20+vThmvKSzQ6UgtaFAR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698534; c=relaxed/simple;
	bh=NY1wpa0KtsBaIPbsx0L2RVvkqMHjLmULXkYd5FOpTXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GX9g7Z4bJM+mFhDWu0ksfh5hAI/2VLuc4+VdZAN0at2gp9Hvu6tHjcwri1lqcUh9gW8znvvqOJFtuPaWbcNG2LDI4AoAQuWtEuF87rAVD5hse4ZbbWvuuGRxYxgDP+bR2R5BxLxURkfvaHydcJ5qIucYrbKf4i2iqUbqVDFTU9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMvpxQs+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741698531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSr0TDQLJaYD83EU6zHlB1nKsxywhTiBP95UqC0cvIM=;
	b=fMvpxQs+GB6S/JBWRzyvuIsXaDIhMYK6Oh/TSG7jQcBQ94iGoTymc6kuzLn2jU1Aa3QUpf
	8/GBE6lknhDAdw05M6Y5kzUwygQCRuzVCr+GLRsTeUG+LF6PVOwIlgpm1dV/WOLhFiE3VT
	xczcwEuXLdCwzxaGLcSlLu6rZ+Ipymc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-L3qPiHWcMsGqk9oVfQ24AA-1; Tue, 11 Mar 2025 09:08:50 -0400
X-MC-Unique: L3qPiHWcMsGqk9oVfQ24AA-1
X-Mimecast-MFC-AGG-ID: L3qPiHWcMsGqk9oVfQ24AA_1741698529
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so15515435e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741698529; x=1742303329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSr0TDQLJaYD83EU6zHlB1nKsxywhTiBP95UqC0cvIM=;
        b=qdSRmEp8rJUQO9MPXXHn7D5kIy0CmQ2UhDp6xoTUUDMhWboEur57C/sJX/kktBCkYn
         0mn5uLAcAaTWTMZ3Ng0kTiGxHY730XpBXgXa909l1EpesN3Ugg0RIASHbDJy7yPdjBuH
         Ue05rgX+eGjlGTrPu728QkEuJwIoBEQEN3sAETu0MpZrwKhWuLtAL8sWAAGyUMzBaupf
         tCBAc829H0ugVZnN8FW50dQ0feGCo0VlNcg3TMHaBbd+8zbN7c0AChMxg5s92VZI4hLM
         4phPSZdVYTN7LdbG7BPlLiPYNmXOOq42bK3i4jRm6ibZhOPky95lYPbxhW7U9FNnQ9pS
         RDNA==
X-Forwarded-Encrypted: i=1; AJvYcCUFAyiVRyR3rTA26cqmgMDxamcT3wryhOsPclD3oE8Hm7Jodp4wI+4ddEHw+yRwTzQEAwMkAwr69SYWoz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzId7iFq2cY4yH4lHmF2m4FrOtCPAW+lqnLB/1lXUn843HEoIgA
	Ulcb05ftkH7AjxXnHMUo9yDFVIWUkQG3PqI4EUF1kzg/Oe5xeANb9QJ7YPvaVAZ8sNuQbuQ6Isl
	47ILP9GMA56kOlXRbWECSITM7FxrxpO4UT6IggtkeLgvignKpR6YQ+zrYwag0Mg==
X-Gm-Gg: ASbGncvuXLrTX0fFKe/SVXewIrxpK5gk7ILfdmb7+VOSjirMqAdlTgp+EUq/4jdHxMb
	ohK1WzAC1GtnUvXQhwtTHz+7069uDIioZwOQIizO/CKftdfIzy6WE/Rbs9SwkzJqqx8I3izpdrR
	YE6zfXkNO3Rdaf3TKUvRd7vfqsfoEV1GCgJlqbmYH0BQNY6HWelgyTMcuU09/8C/lL0B8IXLqGg
	WoG4GA/Z44yJu64EvpptQeeDMvHbrPsm5yKrcWCa3t3PnMK+VXLkJrzsur1L2mnRLapiuhSrN6k
	lB6wXayJwBRG7VuF/xV+1iCD/G7XgT8vQdAPCUjinz/w9w==
X-Received: by 2002:a05:600c:3b04:b0:43c:f44c:72b7 with SMTP id 5b1f17b1804b1-43cf44c7703mr98398905e9.14.1741698528851;
        Tue, 11 Mar 2025 06:08:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHg2xJEtdcFy90P2VzdKFh3p/fCZJcgu7H/volTSsPrNEA8I4PMuG+4jYjYdTWL3xOUsvL7A==
X-Received: by 2002:a05:600c:3b04:b0:43c:f44c:72b7 with SMTP id 5b1f17b1804b1-43cf44c7703mr98398315e9.14.1741698528418;
        Tue, 11 Mar 2025 06:08:48 -0700 (PDT)
Received: from [192.168.88.253] (146-241-12-146.dyn.eolo.it. [146.241.12.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cf3ca4f5asm82801875e9.12.2025.03.11.06.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 06:08:47 -0700 (PDT)
Message-ID: <72cd7f5a-ab92-494c-b7f8-4696d23ed4b1@redhat.com>
Date: Tue, 11 Mar 2025 14:08:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v11 0/4] fix the DMA API misuse
 problem for page_pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Yunsheng Lin <yunshenglin0825@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Gaurav Batra <gbatra@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, IOMMU <iommu@lists.linux.dev>,
 MM <linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Eric Dumazet <edumazet@google.com>
References: <20250307092356.638242-1-linyunsheng@huawei.com>
 <87v7slvsed.fsf@toke.dk> <40b33879-509a-4c4a-873b-b5d3573b6e14@gmail.com>
 <875xkj1t70.fsf@toke.dk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <875xkj1t70.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/8/25 3:40 PM, Toke Høiland-Jørgensen wrote:
> Yunsheng Lin <yunshenglin0825@gmail.com> writes:
>> I only took a glance at git code above, it seems reusing the
>> _pp_mapping_pad for pp_dma_index seems like a wrong direction
>> as mentioned in discussion with Ilias above as the field might
>> be used when a page is mmap'ed to user space, and reusing that
>> field in 'struct page' seems to disable the tcp_zerocopy feature,
>> see the below commit from Eric:
>> https://github.com/torvalds/linux/commit/577e4432f3ac810049cb7e6b71f4d96ec7c6e894
>>
>> Also, I am not sure if a page_pool owned page can be spliced into the fs
>> subsystem yet, but if it does, I am not sure how is reusing the
>> page->mapping possible if that page is called in __filemap_add_folio()?
>>
>> https://elixir.bootlin.com/linux/v6.14-rc5/source/mm/filemap.c#L882
> 
> Hmm, so I did look at the mapping field, but concluded using it wouldn't
> interfere with anything relevant as long as it's reset back to zero
> before the page is returned to the page allocator. However, I definitely
> missed the TCP zero-copy thing, and other things as well, it would seem
> (cf the discussion you referred to above).
> 
> However, I did consider alternatives: AFAICT there should be space in
> the pp_magic field (used for the PP_SIGNATURE), so that with a bit of
> care we can stick an ID into the upper bits and still avoid ending up
> with a value that could look like a valid pointer.
> 
> I didn't implement that initially because I wasn't sure it was
> necessary, but seeing as it is, I will take another look at it. I have
> one or two other ideas if this turns out not to pan out.

Another dumb option would be storing directly the page address in the
xarray, and avoid entirely going through an ID. I guess it will use more
memory (the array will be more sparse) and will have more overhead, but
could be possibly simpler?

/P


