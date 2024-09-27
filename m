Return-Path: <linux-kernel+bounces-341710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBEF988403
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D1D1F22673
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A5518BBBE;
	Fri, 27 Sep 2024 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJkxumxG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F2215A87A
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439413; cv=none; b=u4/WtyclQhrzV443N1RkIeFa2j6pnoP29lX1uedsk/tCSPmR3Ef80YmNR24ubo+sZWosaFn32rVvJf04P4RARekWPS/R0IirrtoICCjCaQXgcQGbQks2hIpUAxd2CFTUCJ/v5XAWGq9MMqjfobVfSqJbOA+GXP7VE9ZpEKkl7J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439413; c=relaxed/simple;
	bh=/Ykho+qaYOtvyXMi6cQV6rnj4Tk09WcqcuOGHuiZI74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrjyCEKPOnVC5kaxHRwQsE84JaFP8Alhsva/a4IOC3OkkbZsAsp/DoWj0QkhVkGU6KtiAeSNXJQXmMPaZbbCikAAj4ukzwfpShmBXvGjsOUFYflz0+kiajwG7g7WTn9rdso4BNscbu4dmAxT/A8Xf4MEIpyLKA9oWkcvNECXtL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJkxumxG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727439411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WAAkiOCQE5UA2hm+aqB5QWZB5bbCEUg3W+OTA8bXhFo=;
	b=TJkxumxGR0RSQ97ls6GHnHZ5LZYCSoyRQ8SYHs9rTTBdkwKm+vgVnXj/cL7pkHow1weXOS
	wQ2wN0i5odJK0QAOYUFg90Ks3HlppA1tduwNIX15QR8iJG9tLhvfFUiHM9LLj4b9kBVCXo
	3AiWriH0VOJ6RMdKgrbtUsXhJtqQY/4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-Z95qbaRXMZmV49sxgCCpXg-1; Fri, 27 Sep 2024 08:16:49 -0400
X-MC-Unique: Z95qbaRXMZmV49sxgCCpXg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42ac185e26cso15113075e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 05:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727439408; x=1728044208;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WAAkiOCQE5UA2hm+aqB5QWZB5bbCEUg3W+OTA8bXhFo=;
        b=GuuQ1qhq1mxSk47zLDiVTBxAbGHAbsUZWDq6TJGTfe3UyhN82hrph5SNXN+k12sphg
         Mpp/E4bAIvVMwlWRcTZGGGFaVT7zjARGa7Jmrnkh3i1TNw/BVvc0hV7xi9Oiu43Splhu
         sDXvOIVdHaoBry823V6WM1//PrBfSKMNixEoQX7DlY+qMNK8Ua0DFEYJPCbZIO8LEzbF
         yHKrUY0DOe3dyHNcUNfT2hKFE73KzCOkXxImyEK4MyhgBgGpF9t0f5LQNM3QsvoJHvFO
         HPUB3MJZCLtQRVsi5tX/UdTOM4KnJFbowwT+0I1rCAti/z3YBlLJTH6mFSBwbx4iiUI8
         fjNA==
X-Forwarded-Encrypted: i=1; AJvYcCXve6AYjYfeAdABgmrcq03+AU7/rvd9fGvxde9ztXOKPnGgzLTZyTLgp1RqOxnZJmLDt3cIsZhFQXjJBAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywri6agpEH4g7aBLVApS/SnKvXnzTaZAQajiBUMxNn6FTM6cE9K
	DdXwI1u7FtUGWczk/7CoufI7nQzb98henMTEGbjbkOzKPKgizTzKvLqiJ4dZV37TNnNpwKTbJ6P
	v2AqQMweLgr3YkOzFypj+NpYRfpdSvLdoqk9ejxZsGL0udtn8uXSO3qDJu5FnkA==
X-Received: by 2002:a05:600c:4e08:b0:42c:bad0:6c1c with SMTP id 5b1f17b1804b1-42f5844b3b4mr23604955e9.18.1727439408440;
        Fri, 27 Sep 2024 05:16:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1bBzrLNFPj4HFDqWJwoBMrBp1+V2tGMNaB4pJ3N5o5MVALSeUU1l+xJfb0q8hor0hPBZNag==
X-Received: by 2002:a05:600c:4e08:b0:42c:bad0:6c1c with SMTP id 5b1f17b1804b1-42f5844b3b4mr23604785e9.18.1727439408013;
        Fri, 27 Sep 2024 05:16:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:8000:b502:8c1c:3624:99d4? (p200300cbc7098000b5028c1c362499d4.dip0.t-ipconnect.de. [2003:cb:c709:8000:b502:8c1c:3624:99d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e13a1dsm25603395e9.32.2024.09.27.05.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 05:16:46 -0700 (PDT)
Message-ID: <923dc5fe-644d-4671-92fe-6c542fbd0f18@redhat.com>
Date: Fri, 27 Sep 2024 14:16:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBbRXh0ZXJuYWwgTWFpbF0rIG1tLWNt?=
 =?UTF-8?Q?a-print-total-and-used-count-in-cma=5Falloc=2Epatch_added_to_mm-u?=
 =?UTF-8?Q?nstable_branch?=
To: =?UTF-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240926202540.E47E3C4CEC7@smtp.kernel.org>
 <e02aa8d24a254f36af5132925be4075b@xiaomi.com>
 <20240926171747.bacbd2b5d62d4a34926f0d4f@linux-foundation.org>
 <cb640f960feb43bc8cc280474314e52f@xiaomi.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <cb640f960feb43bc8cc280474314e52f@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.09.24 02:46, 高翔 wrote:
> If you pass the regular integration testing, it will be classified as 
> 6.13 material, and then finally merge into version 6.13?

That's the usual flow.

-- 
Cheers,

David / dhildenb


