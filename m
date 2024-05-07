Return-Path: <linux-kernel+bounces-171215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEBF8BE14A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733A1281333
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C7D152DEB;
	Tue,  7 May 2024 11:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLTe9Fpj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185B6152DEA
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082246; cv=none; b=n/myauhCfNrGcnwZMuidpuDvkS4OMHsuNHaugOFgzeQ9CUwFtip8Z6etq+HZx+Nf9VIM5iwfVwQEpTn9unwfJt07FkmU+mdySjYDqJlVYtyZ8NG62rmEYyXcH8TphLyX1G8an5EETnlo2sNKrYni1vG4AP33Qqu/W7eq7L+Bg5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082246; c=relaxed/simple;
	bh=zeSc0zMRaHwEe3WALkGgrfChiRHog7dzLDFVfwgftZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5dx/Qh+fWNpfkwW641M1tyyG/AML/mgEUctvmWNy2sPLvx9732hGZQROBCDSY3RQrg8XTOM75o4N6hy0SkahE4fp5++3ZLclOTz/zTSxIhZx8TG1A7qxviXQzPwJoWHV4wYkD3WlbVHHqn0wWH6ec6VtaO7hHVxJRqCCXOENJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FLTe9Fpj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715082243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nUVaoXiu44BiAXrCqxjBhtMw9DuZOXrqazpAQ7VM7I8=;
	b=FLTe9FpjUwbd53JyQKuTy2Br6dJX/iL3HZnU0IakaySak6FmZXnDndQwex9Dd3wNoTOOY6
	gS1QPRxIAaurGK75pjviSZUPx5vEnynUuVUZU9PkqFVlsebPKw1+k4bDG4aBIJNxN1CDOP
	+5pB6AG5j09ZFLTmw3rOJXpe8IeZMs8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-DqLPgC7IPPijUX7Lee0nYQ-1; Tue, 07 May 2024 07:44:02 -0400
X-MC-Unique: DqLPgC7IPPijUX7Lee0nYQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2e0b3a7ffbeso28408971fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 04:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715082241; x=1715687041;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nUVaoXiu44BiAXrCqxjBhtMw9DuZOXrqazpAQ7VM7I8=;
        b=rjLV4Eihh27EvvRlt1v2V+PO6HLLdk2I3H4hmqsh3qo8rs9QeVkncc6Svrwgy5SC+v
         E05E8negUf/z3a1gcolHmJoCMVywgl+A0VmuDYC2xhatsiEy38gvZDQflAdEPxVhyMaU
         wJMGJCE0lDsurwMwOXaYqU3z5iN5gnK9az9BtNMxJZ7l+XWtRwDRmz9QSP5A5P/c4bcz
         J5W/tYjYxjcUzYMCJCY+iq+Ffxn/YCSRy4QdPVPedoHWeKXu/lbYcP38c6expqaBBXjM
         KrT++LPxryLjEcKgn6D86Byyi7w0mkcHqnZq+sqkf+yO3AsR/nqQ1VJk+OV0kvK+qA0v
         PqAg==
X-Forwarded-Encrypted: i=1; AJvYcCVJh7dQHToWtbUbu10PrUh1z3HpMP+YI9dPeCEEhTnXArtBBg8zUGbpsbJfvCAByN2qSHZ//ya7G9buvgbZ0bnPxnvIH/+fcVTKIYex
X-Gm-Message-State: AOJu0YyZrQSMQd73UrnixpS57fvxRBsdqjPkqamQsXcuqCXkQSl/xKRZ
	SWLaAnOYNPKIDlD2MrM8Rc1ROT0D5N6rt2SWZUcsLBGYcTJv1ltmW/jdBlmESxoKGXJRqlMol55
	zz1SvSkkG5tlOo/UJhQ5Y/Ep4L1xtiz4jAcEtN/sFurvk9wsp0AcjYA3z3DeWYw==
X-Received: by 2002:a2e:bc17:0:b0:2e0:ffea:4282 with SMTP id b23-20020a2ebc17000000b002e0ffea4282mr12472816ljf.38.1715082241120;
        Tue, 07 May 2024 04:44:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXiobUMXBsnzvzTaRV2RyJbn/Jcl7YQwJTWJBf7/3DtlmUbe5NKbis1Ej662Ax3vTU437XmA==
X-Received: by 2002:a2e:bc17:0:b0:2e0:ffea:4282 with SMTP id b23-20020a2ebc17000000b002e0ffea4282mr12472794ljf.38.1715082240635;
        Tue, 07 May 2024 04:44:00 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c35cd00b0041bf45c0665sm23129210wmq.15.2024.05.07.04.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 04:44:00 -0700 (PDT)
Message-ID: <d6763648-86fd-40d2-b261-eb59a4721d91@redhat.com>
Date: Tue, 7 May 2024 13:43:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] arm64/mm: Move PTE_PRESENT_INVALID to overlay
 PTE_NG
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Peter Xu <peterx@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Shivansh Vij <shivanshvij@outlook.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240503144604.151095-1-ryan.roberts@arm.com>
 <20240503144604.151095-4-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240503144604.151095-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.05.24 16:46, Ryan Roberts wrote:
> PTE_PRESENT_INVALID was previously occupying bit 59, which when a PTE is
> valid can either be IGNORED, PBHA[0] or AttrIndex[3], depending on the
> HW configuration. In practice this is currently not a problem because
> PTE_PRESENT_INVALID can only be 1 when PTE_VALID=0 and upstream Linux
> always requires the bit set to 0 for a valid pte.
> 
> However, if in future Linux wants to use the field (e.g. AttrIndex[3])
> then we could end up with confusion when PTE_PRESENT_INVALID comes along
> and corrupts the field - we would ideally want to preserve it even for
> an invalid (but present) pte.
> 
> The other problem with bit 59 is that it prevents the offset field of a
> swap entry within a swap pte from growing beyond 51 bits. By moving
> PTE_PRESENT_INVALID to a low bit we can lay the swap pte out so that the
> offset field could grow to 52 bits in future.
> 
> So let's move PTE_PRESENT_INVALID to overlay PTE_NG (bit 11).
> 
> There is no need to persist NG for a present-invalid entry; it is always
> set for user mappings and is not used by SW to derive any state from the
> pte. PTE_NS was considered instead of PTE_NG, but it is RES0 for
> non-secure SW, so there is a chance that future architecture may
> allocate the bit and we may therefore need to persist that bit for
> present-invalid ptes.
> 
> These are both marginal benefits, but make things a bit tidier in my
> opinion.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


