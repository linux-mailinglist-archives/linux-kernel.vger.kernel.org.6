Return-Path: <linux-kernel+bounces-190739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 998C48D0202
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14B72B247C0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3596215FA80;
	Mon, 27 May 2024 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEf6kgG7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A3E15EFA7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817176; cv=none; b=klL69pWgNAB9LP/pd8C2sBQWKIp408u0lMMtOBYx/I8QuuGSq2Lrq7He6WJPIqFI6WTJYPwQ/vTYd7eTZhxDqLQFymFEXuY/b5swNOKHSYWCkmCMErYISW/Gp0IB8XePOJ94xkNATb5/q4G6+GslZrG5g4qlzVqOeuqS8tgVFEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817176; c=relaxed/simple;
	bh=KDhroGorFCsdiRgWfSYZTVn5iZsTxCHBgOFLmn8xgPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9bc/1hMjnZNePfuwIZl2yWpoL7z/1khRzsamuWmwJl5lJg+P9H8TKIz4jrPFqk9CZWzykwqABhMHDsZAf4HmlxAy1VCFgkUMrSBj7zqaGKugPoE4g4VFR0R36KPD+EFU6+kAF9N9RThdMs6UZLnbbrVzs9tkDa7XTPp6lEPiMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hEf6kgG7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716817173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2eC1AqL9QH4TVSIhzgj/eAmDmIh2MF6QUCJEMwiWIh4=;
	b=hEf6kgG7EQWP9OOLF1Barx7+2rADwTNJck3TjD6IqcFK/VexArPDxo7d1yhzBqNGxDF6sW
	U64i3XodQKDx3Jb2BBb12njLyz+4R+hqwLs8krqGVgP+bD8xxurMQSSr8ia7HZ08QbbEK3
	0UgQKETcFoCOZgjVvbF/WJo2tDuH/G0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-0msaVNylNYGy-P2zf0-8RA-1; Mon, 27 May 2024 09:39:32 -0400
X-MC-Unique: 0msaVNylNYGy-P2zf0-8RA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-354dd6b61f8so1652909f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716817171; x=1717421971;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eC1AqL9QH4TVSIhzgj/eAmDmIh2MF6QUCJEMwiWIh4=;
        b=FLuw59ZpapRE4St7pNAkjuYvvMXc2nT7IFPrSdioN200W0KXc+GOJHoMphSGssOhwn
         cVsnhvKA68RlxM9ZPKtR5L6ZUmCqb9+HnLCW+QtPMbenoDOeavjSgqZyUuXpSL4+woup
         nSD+8eVh+XQ5eUjkTKHi5YkLKGBm0w34frnsbvuHyexL/zKf8Y1IPxC+RNTAEotWNg6Q
         890FLAlB0dvs/dDRQNWgkuTDqoSXWL9YBqMPeqg8kIE5k//pz4r4cNlNAZF15+asJK2C
         bzjuY/LRDDxLSEIzBozNflVpWdKhliGQw6nDEj35OXmDsDNoEn0d1t+msP0s/iepi7G8
         igCA==
X-Forwarded-Encrypted: i=1; AJvYcCWYtOZeiAr2D9gABH1dmpwegwVlSjMFNOuXani5eWb9V/z2AN5VSY2xFrWneCZrCbtHIIsCOsNmEcDLU/hE24+WSi29JiAYDN2RzMFH
X-Gm-Message-State: AOJu0Yxq0pBjeBDJCEgpaE3Y8QcC6uBZyNfq9TiQUKn5EnQrUfMnWBet
	gmVQcaPPWbw8CgITqQbdYA/TES3l3aQN9Ms13NTtCwSltHQEWk2A4NSz4BiMpImtahq1pkndDbz
	siRhhBTzAQ072x7rzHW5oZXksOqoarVYVTvAzmfOPPQtXLjCRU5E4tXzIdQ5hgDfgkJs9hg==
X-Received: by 2002:adf:ce91:0:b0:351:dab1:1c72 with SMTP id ffacd0b85a97d-3552fe19370mr5518355f8f.47.1716817171286;
        Mon, 27 May 2024 06:39:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJi2vIIxWHVtVaqrk9KpM8qaLYbVgc0Qr6RygT7+fixJZT0bBXLoaHrSAeKoaGf+A5cmf0/Q==
X-Received: by 2002:adf:ce91:0:b0:351:dab1:1c72 with SMTP id ffacd0b85a97d-3552fe19370mr5518342f8f.47.1716817170911;
        Mon, 27 May 2024 06:39:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e? (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de. [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557dcf08basm9271206f8f.108.2024.05.27.06.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 06:39:30 -0700 (PDT)
Message-ID: <6f2da186-be75-44de-bc3a-e7f6d0e23498@redhat.com>
Date: Mon, 27 May 2024 15:39:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: hugetlb_madv_vs_map: Avoid test skipping by
 querying hugepage size at runtime
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, shuah@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com
References: <20240509095447.3791573-1-dev.jain@arm.com>
From: David Hildenbrand <dhildenb@redhat.com>
Content-Language: en-US
In-Reply-To: <20240509095447.3791573-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Am 09.05.24 um 11:54 schrieb Dev Jain:
> Currently, the size used in mmap() is statically defined, leading to
> skipping of the test on a hugepage size other than 2 MB, since munmap()
> won't free the hugepage for a size greater than 2 MB. Hence, query the
> size at runtime.
> 
> Also, there is no reason why a hugepage allocation should fail, since we
> are using a simple mmap() using MAP_HUGETLB; hence, instead of skipping
> the test, make it fail.
>   
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---


Likely it would make sense to rewrite that test to try with all available 
hugetlb sizes (like cow.c does).

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb


