Return-Path: <linux-kernel+bounces-320949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CFB971261
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71F3CB23FBA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BF91B1501;
	Mon,  9 Sep 2024 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YN7fbRHh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092F41B14F3
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871443; cv=none; b=DwbT0P5IVj9QplmzJsGPgSoH/NUPBDUiyKHlI8bw1YgvgWMReQgWXpDDW/slzlRvUoggQ84sLEGva6h5aM/Za1/huzNVHbG3bs3FYDYesxKWzv50Jw5kjKIutEF5MJ0z8q2ULGmBPP4u2L5JPZ+PQprQ8ZVSOqW929sHDjrhYU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871443; c=relaxed/simple;
	bh=Stp4wCMyYI8dv+Q2/9icRB5f3t5M9HSvRdUihIv100s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BeSsJ2VA7ct7NWGTuL7lfIppM/tjekfFblvEVooL+dB4+VYWZr8dhiN0KU3HM3Kyz2R/zja9PJyemWzPRmznvjrCVRx4sqGq+7cKkkEnISYGeCZQd7AhvGU1MJSfml+q4RxNx6nh4OCVLW0zDE8354UzlfssZYGhMNSk1sBpoGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YN7fbRHh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725871440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bIGG+CElM48qLihkEZ32AwWc+f9AkoD1sYmGSkn/dNY=;
	b=YN7fbRHhmz1avAyMKN7O1KkWifutAawwygBhEPi5YxO4AOboicuwrOOtlzNBB26u0kdLcL
	Psf0oBpS/2x0YTheIkZea9WtyFLd+b0gqZ43Db/fi4tUJaG+JM0pOaGk50sc/6Bb/QX4/h
	mdL+MCXVcf8gMyJUfdPMlmpCKTYaLJg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-EhAJvI6sMvWhbfHn58Pk-w-1; Mon, 09 Sep 2024 04:43:57 -0400
X-MC-Unique: EhAJvI6sMvWhbfHn58Pk-w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb808e9fcso5177285e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 01:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725871436; x=1726476236;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bIGG+CElM48qLihkEZ32AwWc+f9AkoD1sYmGSkn/dNY=;
        b=PKPRbu2NLUysCPi8EDyKYmrN8awU1y3UdvqQJPAF8VkBPcKTs799T44qM0+Dlb+hFx
         D1k+G+lKnIJtQtnWOowUlAHzcoQWAJPiFr+ph7ddkG/yzewkDX2A+qrmsH1/hG4ZWsvX
         o3V+RD5w8r8hpgW9r2Mj+VJ5fEGeGGqcQLlfjVH3O2+LzZ+FDHvDtwpWHBTu2xClTjGG
         HV65MZ1v9RukWDZzfNQKGkauwBaFNHw9yRIeqsKn4tisApTx5QE8oeAzPC3e+KO8G5wX
         plqfQh7GyE2AFw4ss3uAz1Qe5F7RlGUSBedS7l3aLol7TYsBB7r+6R7OrhoDTiocVNze
         YWxQ==
X-Forwarded-Encrypted: i=1; AJvYcCULKIrQ0iajB8NU18Pi6wChJzPAdtRabom9wVfbWuxPEAJMatOG8w9MMZxTQURHcDoO9QZ/1oz7sE52ZUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoj6LnVXDU9/8ND5kM2ZqxTYyv5r2Z4AJ596j09mAQSY4CcqRh
	LZQXgteduLvrrjnkAvoqWCj3lCUpMzKhBpWqNbPCDWECiIU6XOiRdA/1fHvze61/XG4ULx1fgdw
	lJdg31i43YhqR8bt2+8YmW2pKF5hVOM4JF1LoeZEz789zcRgjZDJhBJoZKrRZJNurEuXsHQh0
X-Received: by 2002:a5d:5091:0:b0:374:bb34:9fd2 with SMTP id ffacd0b85a97d-37894a07c41mr4111918f8f.36.1725871436296;
        Mon, 09 Sep 2024 01:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRKS1yjzCb0Cv/1o8R2oGtcT1BWWCgvk/7O5sMv1R1dnWWaXGx+ZY9qmpMJUIspWGJMh88Ew==
X-Received: by 2002:a5d:5091:0:b0:374:bb34:9fd2 with SMTP id ffacd0b85a97d-37894a07c41mr4111879f8f.36.1725871435354;
        Mon, 09 Sep 2024 01:43:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c729:d800:d3b6:a549:7878:a6ee? (p200300cbc729d800d3b6a5497878a6ee.dip0.t-ipconnect.de. [2003:cb:c729:d800:d3b6:a549:7878:a6ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b21sm5421583f8f.49.2024.09.09.01.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 01:43:54 -0700 (PDT)
Message-ID: <7714d0c2-e317-4024-910d-bb6c57d9b6fd@redhat.com>
Date: Mon, 9 Sep 2024 10:43:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page: Drop has_unaccepted_memory() helper
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20240909081930.748708-1-kirill.shutemov@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240909081930.748708-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.09.24 10:19, Kirill A. Shutemov wrote:
> has_unaccepted_memory() has the only caller -- cond_accept_memory().
> 
> Remove the helper and check zones_with_unaccepted_pages directly in
> cond_accept_memory().
> 
> It also fixes warning with clang 18 when kernel is compiled without
> unaccepted memory support:
> 
>   mm/page_alloc.c:7043:20: error: unused function 'has_unaccepted_memory' [-Werror,-Wunused-function]
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409061101.Jlx5z2fI-lkp@intel.com/
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


