Return-Path: <linux-kernel+bounces-214893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FE2908BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA4A2837F1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F10197540;
	Fri, 14 Jun 2024 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqooB21x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5914885C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718368157; cv=none; b=bPpLcreTnJeWvNMBQMJL214a5r7kLXNb0cIAQdul8N9kGkeryIZRHhhc3n2Jl0RU6PrYZHFcLgQakN0rgHoU+ptpcINau1qnRfbZBhTlc1auZLTZ8EO2LTGH1q4MQ8shrlrNosdmvf2T/bk3HyjCdcP9eTmL4pbU/bu/ZZWYav8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718368157; c=relaxed/simple;
	bh=DGLKkYNVGH2/85QfKWu18CEyWYVgyRB7Mj7BL+je7sA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNWdfHAjtemcHoKyeMnVnopjFkQHojdII+Hjswq517k6ZLFX+HfamR/ODqkdT8APGYwKolngzXrEh2gKBXe5mCfXz4w54xZQ81D9bAxu4oK2f2MdSew7wPCefLjmc063V8BEl74XqUYdjxTeYIZdTgMNkVctn1Mh3fUE8GEs+ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqooB21x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718368154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OpzfGazkoadY+952z1FT0R3Qu7RnAvh/9ItP+vL8jvI=;
	b=iqooB21xG5MiZX6O4i/jSaRVrZ1jJ7NHTBJmMj6uOeRdYkTjSwcRYjajqjAswLqJt+g9H0
	nOtI0VxcZc2MtE9yeTMK891vpWAIyKLDxoa4uSgiAXtyjnvA6VABpoXMBRABNZat4T0abY
	ZSiuII6wK8YUyQVr1Q7/CzxQKZ5RYVc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-EQblI1oHNVG4lTLSqwJ1yw-1; Fri, 14 Jun 2024 08:29:11 -0400
X-MC-Unique: EQblI1oHNVG4lTLSqwJ1yw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2eb6f6b1b2dso15921951fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718368150; x=1718972950;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OpzfGazkoadY+952z1FT0R3Qu7RnAvh/9ItP+vL8jvI=;
        b=dkukpFWrv7Pby6Ul7kqnRS5Ut34sWdrrJ/A5pose8IS0S+SqlzyzaGURHoGAe1txAR
         jbezUeV+KSUq7a+BDcpEMDhqKBvUjkIVsWjFWudg1r/5gs5bA6Gl6iT+xA2mihaQvPrm
         d8QTnrD5rXA6BLis7Ez9Wm/UeLlAp17PDX+oDI0sKgbgTlS176LDCGiSG8wy9NE83kG8
         SBytN9oLw5NRrHH9eBNPGv+GYM91l6ii3V4LbuszPcbbo1rPJFD0kpaSY9evAZhtyNuj
         I+RdN7GXiXsmJPVWCyK/D+S+oe6fgnb954WHaKnv0Jq3dWqqV+KW01+LsZ7WePIWxK7v
         bqXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLol7OnXB3bP70cdklxxJESIe//mObVlGMmUI6/0CRPk8+b4jBiFztOAwff3i7SWKgfP8nYhnQKb2hGcaoRxrbXaXaG9T5M4NnIa1f
X-Gm-Message-State: AOJu0YwibKWEtti3cfnP+PZz2s1Y2vl0QFf5QxqMts/BYF+X5QWqPEKO
	ciW3KrA/YJaiE2+1hp7+wNCCvPb9VBTLR4ey+bVZzGwrkoKR7sQfHwrWdTiCNLr0azVXmiwMyAN
	de3n5thA2NV+6cVZsK5ZXmXXxL68PPtYaeB785iVSowQd/khM87/56L2Y2hPSvA==
X-Received: by 2002:a05:6512:1190:b0:52c:81d5:6d0e with SMTP id 2adb3069b0e04-52ca6e564f1mr2297916e87.2.1718368150001;
        Fri, 14 Jun 2024 05:29:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEotTRtVSpcxjjzjpcv2rVBi6RzQ8yY693fx2HYwiN5VURefKq/pVJyEgxat33d284A0inBtQ==
X-Received: by 2002:a05:6512:1190:b0:52c:81d5:6d0e with SMTP id 2adb3069b0e04-52ca6e564f1mr2297891e87.2.1718368149424;
        Fri, 14 Jun 2024 05:29:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:2b00:69b5:3684:56c:6dd5? (p200300d82f4f2b0069b53684056c6dd5.dip0.t-ipconnect.de. [2003:d8:2f4f:2b00:69b5:3684:56c:6dd5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c8cdsm4273908f8f.35.2024.06.14.05.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 05:29:09 -0700 (PDT)
Message-ID: <fec9c02a-1639-47d0-b192-430d05899758@redhat.com>
Date: Fri, 14 Jun 2024 14:29:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] selftests/mm: mseal, self_elf: rename
 TEST_END_CHECK to REPORT_TEST_PASS
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240614023009.221547-1-jhubbard@nvidia.com>
 <20240614023009.221547-4-jhubbard@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240614023009.221547-4-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.06.24 04:30, John Hubbard wrote:
> Now that the test macros are factored out into their final location, and
> simplified, it's time to rename TEST_END_CHECK to something that
> represents its new functionality: REPORT_TEST_PASS.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Reviewed-by: Jeff Xu <jeffxu@chromium.org>
> Tested-by: Jeff Xu <jeffxu@chromium.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


