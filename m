Return-Path: <linux-kernel+bounces-289460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DB6954671
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5502886BB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B03816F0E4;
	Fri, 16 Aug 2024 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRo9eGmf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B9313212B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802613; cv=none; b=M/LKtPhJZ2qQGyG/d0HX7tQjr4qGwtg6EOTvsprj9HD1rn1wiSQQfidKau1sRPhiNI/Gq26niNP01aCfZb+9hxT9q+1n+wQ/0VndpeDy5kjz8ztZ9nfJHzfiV/sQ9kxnhTViFuzKviSn3PZWOV/n92Cp9+w0sN9eMsC4DFK60hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802613; c=relaxed/simple;
	bh=dFV2xXpzCSqLKMv+RqYrQmtXh/Q8qYxxSKiWRcfq0RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOJViSIF9DLTv+T3jyfmvpSVVPmH/+qDial0G2BY1Im9DJ8+DsFsuwsL65540vglyzSdtoLFoEBoH3mekihjAu3x0LOulQFTylvWE37GtX3JXwhbT7n9cG4OvyBvXHrffQaEcUXZTqUYwnYYAgR8RGtRYBQs3DNMadXGAY+e0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dRo9eGmf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723802610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bv6JgxmPLtyRzlbyORAKaq3kd+Y6V2I7i4+A+vo1K+8=;
	b=dRo9eGmfe0Z/iEQLnlwQ5ncWXfp+yuuMBnQDLO4mni+BrPok80xkSsIga80/SBohNtzqzQ
	lh9X/UayT/xFvE+jUy+Qj2eJbl5cIOZzVXPsc8zBhx7ClmACySQ6fm7G+w/2jJbVMsRidr
	uhbGIfIytoyU6L3Z3o79MIweoQopzMk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-OEl4R2VEM-KP-TXU7iDIqA-1; Fri, 16 Aug 2024 06:03:29 -0400
X-MC-Unique: OEl4R2VEM-KP-TXU7iDIqA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3688010b3bfso1199011f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723802608; x=1724407408;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bv6JgxmPLtyRzlbyORAKaq3kd+Y6V2I7i4+A+vo1K+8=;
        b=jlvOCMd/azqLG1rTZwH9PXKukU0/7WsdCvW9JenSS08NEKHnhSO94Ull23r6VqYbwQ
         xi7tbgxqN0f/vOpAsgbnCYIu31a3+tNnnNFT+C8TAqUeFOFKz7MAqVFiGlyfnfDAODNs
         7tkxvBDrsryawMYyE5AwgQyvjXg7/2OXGazbiKiIMlZ5bBDIStJurfco5AMkwe0cR/cV
         KbvBaM5X0pdJHu9HiQGp0615KrCydlQsQr5oJ7CvGxa78i825vNhhI9NI+pH+jbYfpgf
         PpWG9EtOVjBTHzd8vcp65oCnQ+7FlXrwcU7D0hvRrat0DZCgviYGMY7fiaut5F97W/Wn
         aD9A==
X-Forwarded-Encrypted: i=1; AJvYcCWFlBjlw21rbkFjfdvrUAIYDCtMDYxcRe+qYyGRki+VfLa/BMnBweqOAJbNTPl0RmTI2owMpRn0Ky5JDQqdszsc3qtKnlh3Wpmtgt/0
X-Gm-Message-State: AOJu0YyznIsizsUJgYMxRGH1dhq2fMVdJ7lHnhbCbMPe6H9NALVeRIL6
	sG88uahfL8bQSUS9iny2fIonMmMOtHtxtuYPDEskk87MZHgOcS5JUYZyqudc7ocHMErye0xMW+F
	nl4R6xSCUwcCL+lMVZrGaXcQQRvd294pIV0x7018qI7DNyELCmVLul0WoiubiCQ==
X-Received: by 2002:a5d:560d:0:b0:368:6b56:641b with SMTP id ffacd0b85a97d-3719469f928mr1509445f8f.47.1723802607843;
        Fri, 16 Aug 2024 03:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETi46kqfEBkFh4u49j/5op4vzbNMLN9Z3tAoQyciXdDZKygQwBSvR46xbaomGg9eGCApAc9g==
X-Received: by 2002:a5d:560d:0:b0:368:6b56:641b with SMTP id ffacd0b85a97d-3719469f928mr1509421f8f.47.1723802607348;
        Fri, 16 Aug 2024 03:03:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c721:b900:4f34:b2b7:739d:a650? (p200300cbc721b9004f34b2b7739da650.dip0.t-ipconnect.de. [2003:cb:c721:b900:4f34:b2b7:739d:a650])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded19670sm72644465e9.9.2024.08.16.03.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 03:03:26 -0700 (PDT)
Message-ID: <2d757ddb-cd20-4695-a978-ea413881d9b2@redhat.com>
Date: Fri, 16 Aug 2024 12:03:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/7] mm: pgtable: try to reclaim empty PTE pages in
 zap_page_range_single()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
 <9fb3dc75cb7f023750da2b4645fd098429deaad5.1722861064.git.zhengqi.arch@bytedance.com>
 <2659a0bc-b5a7-43e0-b565-fcb93e4ea2b7@redhat.com>
 <42942b4d-153e-43e2-bfb1-43db49f87e50@bytedance.com>
 <b0b39543-498d-4b08-a864-b05be45f617d@redhat.com>
 <860f45d7-4d75-4d67-bf2a-51f6000cd185@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <860f45d7-4d75-4d67-bf2a-51f6000cd185@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>
>> (b) if we didn't have to drop the PTL, we can remove the page table
>>       without even re-verifying whether the entries are pte_none(). We
> 
> If we want to remove the PTE page, we must hold the pmd lock (for
> clearing pmd entry). To prevent ABBA deadlock, we must first release the
> pte lock and then re-acquire the pmd lock + pte lock. Right? If so, then
> rechecking pte_none() is unavoidable. Unless we hold the pmd lock + pte
> lock in advance to execute the original code loop.

Try-locking the PMD should work, and succeed in many cases, right? And 
if that fails, we could fallback to what you describe.

-- 
Cheers,

David / dhildenb


