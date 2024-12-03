Return-Path: <linux-kernel+bounces-428979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65CE9E15C9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC52161543
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E378C1D79A0;
	Tue,  3 Dec 2024 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIGQfMtT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D5F1B6D0A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214596; cv=none; b=i1osjFtTCll3Kt6hWyOg8PCe1zBC/eZykoMMTr6i09JbB7rGB1vwzr11uvSEPChHgrZENvU6zUNICuxO4Xd84s7KDpWiynXCAbK5YfGllekBwNKaGKvzj6EmBN/IrCkOpBGVU62UJo1dU3CK+1iw7xC4+LbKh8yrQRdvG87gp9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214596; c=relaxed/simple;
	bh=NO547c6AwhSnBtNYnul0xBOpNPuAaqz9ORX+ALUuMlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVLXH3m7N2EGlQx9mw63CyRyQTo5gkNqZtMr1JGkSL/KZQTJeovKWRd87DFzt0zW1X7qmHWMhKtqJTBGDv5QhzhFZOvDLm8Yz+PKOqvKo6xy2u9U0KTltRKNGT7k6GonbgVZ8m/zWhvQkTyXognODzF8kpDwVWy0ROz1OKrkL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eIGQfMtT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733214593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cL7v3oc5fMJ4viLddVGUsjohS5uWgp/SM7upP9Q9RVU=;
	b=eIGQfMtT8mpjR6fHuSaixEUJfehZvhklCwkA2T7rPtFgYJSu4U0e2LTMG6Zw4RTvkhZ1A4
	tfJ/PA4EYARY3s/aG8lIDAe841Xy95SIDtAIeAGuuGYqEk6DV73rENQjyY6ok0Jmk6KFzC
	G9boJspBulP39QPM4v7ESSpO+1kF7+4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-lpMLyipVMlGvqdZ_YRSYVg-1; Tue, 03 Dec 2024 03:29:52 -0500
X-MC-Unique: lpMLyipVMlGvqdZ_YRSYVg-1
X-Mimecast-MFC-AGG-ID: lpMLyipVMlGvqdZ_YRSYVg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434ad71268dso28853985e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 00:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733214591; x=1733819391;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cL7v3oc5fMJ4viLddVGUsjohS5uWgp/SM7upP9Q9RVU=;
        b=YQOU1ryE+ZDT/OkS5BGVfaod7R6gRz0AaZRp/oXRMDwcQqeb8Z2+CS0KegYGRA0TGD
         +uyTzjMl4Hnq4lUX2D0QP4P7ML5IjaPQItb0H53nAhONBUSL7OYDHb02uSvAtl9zbLrM
         HCpAfOxN+wMbIJdvpLW1ar5YQroc0ZQG5x3v7h8OpgQuY5JKV8Zd9RXcHvgUJBYX6AtE
         UbLfIsriOYfrjP5nmYSdzNaG43+YemW/w48P1re3SJPWxtdSPHQ9S8vKFauv4velEpcb
         gS7pCRLk4vCs/sUOCGz79OR9WQDD3wdEyHG4CSIBbwE3ZhRq9c6HB0+OnacaMFb3AUrn
         9HFg==
X-Gm-Message-State: AOJu0YyO5Lc2Hy5TSoyZuD3rkfFiNHNcktc/I7gLuCNTRz4EE6uYlxa6
	+TDHYXXMPQiZcNHrVeYDRJyzVcCDOZ7C0AbJVZ0qS1iHKG6aAKtMIO8+jpXFBaxq9yOXhBaTxJu
	kQIpG7XpxWD6QE1gCRY1CYTLoghme8AiZpKU2Sm5KFYg7sfSuSRS47LE1RVV90Q==
X-Gm-Gg: ASbGncsJwQ8+gEQyjqbWGC2p71E2RzbZlq8osSuEsm2y60Gy2cZj3PDaJP4C2Ox2xKN
	rPTG56aizqWR9xVdIjBIRti2JRPqPakPgcAe8bi7CfGUO9P6LytbcCiDcRZNDFdNP3hyU28BHMA
	VjKj9DGVu7VMFJje5CUPNst1ixAA+6eM1E0qzJDVt6BuI7qOMhJzDq5hbyP7CGi4SMoZDV+A/r6
	E7WId//l51fe3WusubIWtN8zjvVVlfV9M/NqePTJ2pPXjbBz37vbMrOP8g4v307VHFy5z7pp7CT
	mdp3GyMl/Ut7m20MyHVaOTtxQiRBK/7GxuzI+YFnWEFmJ9X24DildMWtw0Gn3R+KCpyJLA3mtqf
	jnw==
X-Received: by 2002:a05:600c:5593:b0:434:a33d:ba44 with SMTP id 5b1f17b1804b1-434afc44167mr187239965e9.15.1733214590833;
        Tue, 03 Dec 2024 00:29:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWDIsqECcfy6rPlhtUK9y0qN4FnZDKURgqLcZP2VHBBvbbgteOyKLxNnJsZYkBuDbBUXDFYw==
X-Received: by 2002:a05:600c:5593:b0:434:a33d:ba44 with SMTP id 5b1f17b1804b1-434afc44167mr187239765e9.15.1733214590500;
        Tue, 03 Dec 2024 00:29:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c746:1b00:fd9e:c26c:c552:1de7? (p200300cbc7461b00fd9ec26cc5521de7.dip0.t-ipconnect.de. [2003:cb:c746:1b00:fd9e:c26c:c552:1de7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dc99b3sm179813635e9.24.2024.12.03.00.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 00:29:50 -0800 (PST)
Message-ID: <dd45ff45-8894-4502-a4ee-ca4cd927662b@redhat.com>
Date: Tue, 3 Dec 2024 09:29:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] mm/page_alloc: gfp flags cleanups for
 alloc_contig_*()
To: Zi Yan <ziy@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20241202125812.561028-1-david@redhat.com>
 <6CE8BCE0-BDBE-41BB-9998-D9165CF05A1F@nvidia.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6CE8BCE0-BDBE-41BB-9998-D9165CF05A1F@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.12.24 23:07, Zi Yan wrote:
> On 2 Dec 2024, at 7:58, David Hildenbrand wrote:
> 
>> Let's clean up the gfp flags handling, and support __GFP_ZERO, such that we
>> can finally remove the TODO in memtrace code.
>>
>> I did some alloc_contig_*() testing with virtio-mem and hugetlb; I did not
>> test powernv/memtrace -- I cross-compiled it, though.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Cc: Naveen N Rao <naveen@kernel.org>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> 
> FYI, linux-mm does not get any of your emails: https://lore.kernel.org/linux-mm/ECFA727B-F542-42E5-BE32-F9FB27F5DCDB@nvidia.com/, but linux-kernel has them.

Indeed, linuxppc seems to have them as well.

Guess I'll have to blame it on linux-mm, then ;)

Let me resend with #5 patch description adjusted. Thanks for the review!

-- 
Cheers,

David / dhildenb


