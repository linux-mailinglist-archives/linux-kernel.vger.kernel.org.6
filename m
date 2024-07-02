Return-Path: <linux-kernel+bounces-237830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC91E923EAD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B50284867
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1D51B47D4;
	Tue,  2 Jul 2024 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZElrYb39"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F551B4C41
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926272; cv=none; b=PxNNSAupI+BG5fBWHaINKiqOEQ7HSnhuA+jiDOvVLGpzgFC9kTGu2lmfLiKfk/zFzxOhLVBY2ucLBn1KL962OPM2oCsxbRU32EwRfrayi9K6Gxh0/NM6AL0sxwxg2saUGnm7WjrlfGdzfxNai0gtrZg23cxzqOOEE5nv9ZaX5WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926272; c=relaxed/simple;
	bh=56D3oFUPXB12nDvAZQIXxt0iogBKNk73+4BwzOU+G/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o06C1GYtZAb6qPF3HLgorXCDUwyDE9EFi4GSRiItzoVLbmUz8/nMgDdHhwbctl3eIIlE6wkv1kPjrlUHUSd4jcAjIkloYTOC0JjUV8lbtkTFooblYw6s3SXahJOWeFkkNOIshVXortWLm/C+vGfzVrnoaSwuyjHTYull/ykvke8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZElrYb39; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719926270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=r2p9uBmenVl5aAeKfTbtNeRdv1FGbf5smq3mGsQuJ+g=;
	b=ZElrYb390esAhU1mahPlGiovdBN4IXHVFaLxk6SPstkH6mBrSY3k758gBnwr0PnGJvt/yO
	dzqVbS1cnx/wWN6o1K5NyZFN36yMDPlN9CBTYZdzLaJEQgS2nIlC0N9DXowGoUEHaysPEZ
	HeRzw1HKgz7SxCIX9836kbGtkLijmE8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-4-KEeDsfMXahCywpCThgOw-1; Tue, 02 Jul 2024 09:17:48 -0400
X-MC-Unique: 4-KEeDsfMXahCywpCThgOw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42566c4aa0fso33558375e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 06:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719926267; x=1720531067;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r2p9uBmenVl5aAeKfTbtNeRdv1FGbf5smq3mGsQuJ+g=;
        b=dMUEkTJhL6mN/CxWolzQbOMVp2lrAPRbKjvM/wUMz4d64RbLZsDK4FVMcdJKDWvHyZ
         T1IwOORWS4P7QNEHhfTHBnvqsuTlC45j3sM+CDdQ8Dx935GgQt5d+idFEXI8L2nvx/yN
         4oeNYNzRRNfaWAeq0dmCaUFNwtLaGPr/Z610xU5OqZkGlcaiMvDPgozU4K/cHHV1i1Af
         5ZC0qRQXOgY+ZrWbGTiJjR9vhxc5Gatg5HV88vwATM1tg5qeKZ5u8msLDSlw9Ue96PWg
         MiADJKmPmh2LcDuGmNw6L3O1aFnHNy0ONSd96tNe6671WY1uLIbfs1t6UDSffjJ1g2LG
         ta1g==
X-Forwarded-Encrypted: i=1; AJvYcCUYgVDo+KcQ37Wa6mpAD/jV8Rk0pBIVojTrcLCncfOlqlbAwBiudBQ4+l6LfAJv6NKM7FLpVXhqMpDOC+yiiUbyeZ3CZwM2g5HkfKMX
X-Gm-Message-State: AOJu0YziCtJUHSgJvrApZ5U185fceN5rYKbGbfPKBl09GbytvXQ7Jjgg
	xku18NxoAGna5KhhGvwJekiOsDSs5VjDFiZywolgI3OV7VEbmGon2KZLqarHY6lAdV990tagrC6
	ukrwVSN3RAGqNzqyRq58ZjWFyCjhgyk1C/vtyvbOEYJDII3u0reMrMWFlIPw2hQ==
X-Received: by 2002:a05:600c:63c8:b0:425:7974:2266 with SMTP id 5b1f17b1804b1-4257a03a58amr60218315e9.24.1719926267656;
        Tue, 02 Jul 2024 06:17:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZSyo/GPdMeFh9+/jb/swoMKCwXF3lTMsSpqIL3VWN0OM+Ynzh0EQWu+uY7PgSuw3FzktIiQ==
X-Received: by 2002:a05:600c:63c8:b0:425:7974:2266 with SMTP id 5b1f17b1804b1-4257a03a58amr60218005e9.24.1719926267149;
        Tue, 02 Jul 2024 06:17:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:2400:78ac:64bb:a39e:2578? (p200300cbc739240078ac64bba39e2578.dip0.t-ipconnect.de. [2003:cb:c739:2400:78ac:64bb:a39e:2578])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af5b66csm194551335e9.18.2024.07.02.06.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 06:17:46 -0700 (PDT)
Message-ID: <b0c3ab9b-6115-4ffc-88a4-f0c3640b9c62@redhat.com>
Date: Tue, 2 Jul 2024 15:17:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: remove CONFIG_MEMCG_KMEM
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240701153148.452230-1-hannes@cmpxchg.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240701153148.452230-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.07.24 17:31, Johannes Weiner wrote:
> CONFIG_MEMCG_KMEM used to be a user-visible option for whether slab
> tracking is enabled. It has been default-enabled and equivalent to
> CONFIG_MEMCG for almost a decade. We've only grown more kernel memory
> accounting sites since, and there is no imaginable cgroup usecase
> going forward that wants to track user pages but not the multitude of
> user-drivable kernel allocations.

Absolutely

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


