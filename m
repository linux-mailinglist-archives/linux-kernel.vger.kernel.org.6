Return-Path: <linux-kernel+bounces-246974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F76092C980
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A3C1C22EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830F93D96D;
	Wed, 10 Jul 2024 04:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkFlOd0z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF372BB04
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 04:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720584443; cv=none; b=GJe+C15ROjJRS0v+z0IRVkZcLvBSyF5G6NIzvy8KSoDBd1z8rytFLskuawD330XOWyOPeHy7rwKZ0JTopDPEhhWm8MD57P6JL1P8pHAsnFQUseXkkwQ4ZhbaELqXvyNS2yQICRNiE7EKy4Os/iJXU8F1QgXLUDuZ1nd4HHTkmjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720584443; c=relaxed/simple;
	bh=6C/zfirQyq6m6PQ2ie5sKNrqCqnMEGBVl959DNIy4sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eM+TypiCEQedvF6TlYif9XUaqZvVX4r2eIK9a4qjmljB/KjmVZXKmyc29qywVLuYffKFqNHn98Fjlgwd9Afal+Gi1Ksw2vVadcKZzuwyHtm5j1C+sFGOVOOIHjW7p9GUVJ+Hs3Av6SdnDpevjrW2PpxcwJ0O4Paox09JYuaMnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GkFlOd0z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720584441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4Hmp8L/082HRxXsOQKXBMeEH8mcc0CR8XLOKRVBeYOU=;
	b=GkFlOd0zBItLL0BWiNg7DtQNdUCvuPii0XE2BS6SdaNLFZzQ9rYIkekyCQz1Tq/bklAFig
	n4Rz4XdIRe5Ylgmbg0A0dxP+AwnCIW26U3W3tI3Xgvrbz26uuNnR2sVsofc1O1ad1+KaVe
	WayfuZ7CRYIFBA7fC+7mKP+2iQMewlc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-5K-pwh7vOCKvnHuG70dV-w-1; Wed, 10 Jul 2024 00:07:17 -0400
X-MC-Unique: 5K-pwh7vOCKvnHuG70dV-w-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c96e73c886so4317382a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 21:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720584436; x=1721189236;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Hmp8L/082HRxXsOQKXBMeEH8mcc0CR8XLOKRVBeYOU=;
        b=bWJ6LoSy3VyY8VmaoEmn25q99yZLxoqXEBnrP4hgO4u6zx3NEzWwiCPlk7FS0vHiXz
         CQ/UpOCwVgvPEHxkMGZ9PneXgZsqmIs2bXQK+GKqnn5044I45KWFJSa2X+f4zG/vGsDw
         dI8/mvyb1iPbOvLcIn6IhStiuvk29n2W4A1dJw/BCLcvzVDQi39MqY1SSa1vSq4p2i5/
         Ozv2bR8TRoPww0SYFuu+667CVpBKjx36xdtl5YpSs47fdaez0uyr5hcRMxqXfvXQi7BX
         WYPWXFV1uOsUB13JWsZPAHsJXlQqwu1Bki+YpuNNYYUtBFWq50VoKSSz06Xkt50slDNS
         qtNg==
X-Forwarded-Encrypted: i=1; AJvYcCVKjiYx1hs9c8nYH9DYvP/ouzCq4am/oIwK3Uqx6EYZlbhxg9/c/rNnitzzLYwErBPWEiUm7ZYv9WNMj3x/CDx0cwgblYawWElN+9rw
X-Gm-Message-State: AOJu0Yy2ppb6Mrk9LIhhi2uY05j6Ky9Bbnj69i0pBagOWx9A2sj+NkgY
	iwxyq3sJs4rCLvNq+W6r2uYHdUqSE9oulaxtcwvfSdQKyS7DQFdxkQIUORT2cM18ZoexidbQbDY
	n3+DX/5vni83HeswPiK97Kh6FioKCWYMdihbG0fJATDS79ki323cYaOYJyZ/POw==
X-Received: by 2002:a17:902:ec8a:b0:1fb:9b91:d7db with SMTP id d9443c01a7336-1fbb6d3d3b6mr44602025ad.19.1720584436222;
        Tue, 09 Jul 2024 21:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVPYdr4bPLEq6M4tEtg9rbxzBv1IyFaW+LEhahGAul2R/CZttE0zE6k2ed4WL4HvkfL/CfIg==
X-Received: by 2002:a17:902:ec8a:b0:1fb:9b91:d7db with SMTP id d9443c01a7336-1fbb6d3d3b6mr44601915ad.19.1720584435800;
        Tue, 09 Jul 2024 21:07:15 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab7d38sm23489205ad.137.2024.07.09.21.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 21:07:15 -0700 (PDT)
Message-ID: <c3d96f76-abd2-48d6-a20b-86cdfb91f122@redhat.com>
Date: Wed, 10 Jul 2024 06:07:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix PTE_AF handling in fault path on architectures
 with HW AF support
To: Ram Tummala <rtummala@nvidia.com>, akpm@linux-foundation.org,
 fengwei.yin@intel.com
Cc: willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 apopple@nvidia.com, stable@vger.kernel.org
References: <20240710000942.623704-1-rtummala@nvidia.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240710000942.623704-1-rtummala@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.07.24 02:09, Ram Tummala wrote:
> Commit 3bd786f76de2 ("mm: convert do_set_pte() to set_pte_range()")
> replaced do_set_pte() with set_pte_range() and that introduced a regression
> in the following faulting path of non-anonymous vmas on CPUs with HW AF
> support.
> 
> handle_pte_fault()
>    do_pte_missing()
>      do_fault()
>        do_read_fault() || do_cow_fault() || do_shared_fault()
>          finish_fault()
>            set_pte_range()
> 
> The polarity of prefault calculation is incorrect. This leads to prefault
> being incorrectly set for the faulting address. The following if check will
> incorrectly clear the PTE_AF bit instead of setting it and the access will
> fault again on the same address due to the missing PTE_AF bit.
> 
>      if (prefault && arch_wants_old_prefaulted_pte())
>          entry = pte_mkold(entry);
> 
> On a subsequent fault on the same address, the faulting path will see a non
> NULL vmf->pte and instead of reaching the do_pte_missing() path, PTE_AF
> will be correctly set in handle_pte_fault() itself.
> 
> Due to this bug, performance degradation in the fault handling path will be
> observed due to unnecessary double faulting.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3bd786f76de2 ("mm: convert do_set_pte() to set_pte_range()")
> Signed-off-by: Ram Tummala <rtummala@nvidia.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


