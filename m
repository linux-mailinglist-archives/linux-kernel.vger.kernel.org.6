Return-Path: <linux-kernel+bounces-276314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC1E94926E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08D94B230A7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683351D47D3;
	Tue,  6 Aug 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvbCcLFy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293681D54C3
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952105; cv=none; b=sBI1zcxAQqkp4Mhs7IV92Nt9ous00jX3L7IxNsdVNuS3Y0V7orhAbpOWD92yXsx47NDw6Zr2wyNCiuRZAuhMaxsPPvVcvHMrVqfzLdeggCFV4CyFUbNRJ8oh5tZVjpuLYDStS8Xyu0cS7WZpOYQZPlbi2WmsI4NfUFkq8Abj2Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952105; c=relaxed/simple;
	bh=xrxM1SqhWYYYwZ09b4/BbXYkJmOGRhJ6d/k55zrOR+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRkN8EiytiUUQEA8X/dXNQsLZ/mHmbg2ce6xFhQOiOWU0g/wWXadm1QXtSh0HxCsQpmeTAGZbaR076ZW2T361HlIi16MVFIoSWFAMCbKLeGXZoQC+MXgwZIaijODDTJopix/FKngQLMRfPFusfovlbP5qYxtvtrc7B1k/OQIAOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JvbCcLFy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722952103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gtpU5qSprfJ+UldEW+4kFQXg1kf7NdDamMPmiVRXcoY=;
	b=JvbCcLFy45H9oRclbDwKkFIbV833D9Kb1KM2R3M2ouuQiZbKbeUXgX+IxQWfZVByE9Wucl
	IFtL9EcHEHaNJh462oxmoj9jaXuJtdfAcgOh+2a6YnyOy8X8+dfiHV7K7EZfOfo0wbXc/R
	xpgYHc1A150uthtFQDavn2LPCqfeIzk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-exCP9StKOa2KSYDo-IKghA-1; Tue, 06 Aug 2024 09:48:21 -0400
X-MC-Unique: exCP9StKOa2KSYDo-IKghA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3685e0df024so373200f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 06:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722952100; x=1723556900;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gtpU5qSprfJ+UldEW+4kFQXg1kf7NdDamMPmiVRXcoY=;
        b=ACJBwszKdyzlkugHSt9GALc8ZYlCytqVEx9TwFgZdKCh5uhPhvFdK10hxmkZHnLdEC
         QLR8VMoCeZkUXxSXt3qtnFLEZNWzBenY+fntTMr22iAVLkwpPcSuoeyhU81z48OBoQsR
         9VbBlNy7ldxCVNbSrJSfbeAIG7r7wNA49nBS5r6tuFm6tSo4uhie7B+JDJLI6zQpNuf9
         4u3Q8GAJs5r4+JSZqiF3VJMVZuSzfzesvumaPOeoyvq4r+rQbc7maeoTMD19UjkbHzqq
         cB/rnd/T+igLxiYxP0kEmwUOPGG2Dg5c8gWnscwmvAh7e9JQr3vAI7pxA7bXgSAmSGRB
         BBlg==
X-Forwarded-Encrypted: i=1; AJvYcCU6eorvDqb2Pn81BgYU98Y2nK93hwbe8kzKdZZNw3761UwHU8aJD5Hax6ha72whHYRmX2z07oelkTLph/xvzU0JcWOjWSu94TYx6FcT
X-Gm-Message-State: AOJu0YxY0SGrI5+kTLRNXK9N7FQJJdwnPk3rbot+cAsWT3M30TSDUQEH
	oL9tO2g2uDqjFdTduRJIpf7e9HluNqAAUvOmR2vKTk0FMB/vBPyWwMe6WyWsiOS45yGyTXVwEpx
	+pqkguAAGyFV9NwCAULFN1LEj06sQYTR/C88jFy3QnI5vO2vnwVnX0Bxzghn/4w==
X-Received: by 2002:a5d:464b:0:b0:367:8e18:535c with SMTP id ffacd0b85a97d-36bbc14f832mr11022293f8f.43.1722952100702;
        Tue, 06 Aug 2024 06:48:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPRXCbw4R3JVze/f37dPQWjpfsvw8RLVk7FJ++mKPigRKg6a0Bo+6mw0dqBpIa26xORe/xBA==
X-Received: by 2002:a5d:464b:0:b0:367:8e18:535c with SMTP id ffacd0b85a97d-36bbc14f832mr11022274f8f.43.1722952100155;
        Tue, 06 Aug 2024 06:48:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af? (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de. [2003:cb:c73f:8500:f83c:3602:5300:88af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0cc58sm13109166f8f.2.2024.08.06.06.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 06:48:19 -0700 (PDT)
Message-ID: <03db8091-d563-402b-9eec-ad36a364e5d9@redhat.com>
Date: Tue, 6 Aug 2024 15:48:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/4] mm: Introduce guest_memfd
To: Elliot Berman <quic_eberman@quicinc.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Fuad Tabba <tabba@google.com>,
 Patrick Roy <roypat@amazon.co.uk>, qperret@google.com,
 Ackerley Tng <ackerleytng@google.com>
Cc: linux-coco@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org
References: <20240805-guest-memfd-lib-v1-0-e5a29a4ff5d7@quicinc.com>
 <20240805-guest-memfd-lib-v1-1-e5a29a4ff5d7@quicinc.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240805-guest-memfd-lib-v1-1-e5a29a4ff5d7@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.24 20:34, Elliot Berman wrote:
> In preparation for adding more features to KVM's guest_memfd, refactor
> and introduce a library which abstracts some of the core-mm decisions
> about managing folios associated with the file. The goal of the refactor
> serves two purposes:
> 
> Provide an easier way to reason about memory in guest_memfd. With KVM
> supporting multiple confidentiality models (TDX, SEV-SNP, pKVM, ARM
> CCA), and coming support for allowing kernel and userspace to access
> this memory, it seems necessary to create a stronger abstraction between
> core-mm concerns and hypervisor concerns.
> 
> Provide a common implementation for other hypervisors (Gunyah) to use.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Instead of "Introduce guest_memfd" and "Convert to use mm/guest_memfd", 
I suggest a single patch that factors out guest_memfd into core-mm.

Or is there any particular reason for the split?

-- 
Cheers,

David / dhildenb


