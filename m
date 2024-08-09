Return-Path: <linux-kernel+bounces-281370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF2F94D622
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3DDF1C21599
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6023F14EC62;
	Fri,  9 Aug 2024 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEwgObld"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AAC86AFA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227176; cv=none; b=G4CxB9vEHZUxkhn2P1Dj5NlnfxUd8sygKA5ezcOqmMDjtZSWcRsXqEmaE+nv7DBHN0KiHqnCFCRLy4p/8QlhFebK+SAfqJaJi+XXP/xmmMkGSiTM/GNqGvu/yLZB56owaAMFxLZCF7hpjBgaOPBRyW3YZQqDN2h4YMtP2/VUpa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227176; c=relaxed/simple;
	bh=HvU4o23BD7dxBO7vy83K1DpjpuIc0W2NPIUW4O+CV30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsVjVsIPHhrVzsyUxKGXiEuMT/QEIUEH2hwKm6eoQ6uCPGax2CunDnQtKiEnKkWfhBY6dWoXazdbR82PYZSyah5K4rhwff0YRpPNdbvuM5JZGMjNEMOuxKkxmfUIGEyq1VyFK0RJtzTOfSCsueA9uKJ2fpA5fbC4+ZFa3dsBMyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TEwgObld; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723227174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sj323lvxf0uig7IQaCEIEkKo11cOnZra8FRSfSMp7Hc=;
	b=TEwgObldVoYmNAl7iwyFdfSVBzmqT1TyRNFDk3W8d9XyPgpZDFgWMH8Q/CsmDzXqbncPvy
	XUaDAogyoQlyvxU4dIr8/ee5BCW8o3eCUV3i1U8a0+k0cDLqOH4Ca56Ltqplf4WM4k8xaT
	VGJo0N0KOap9LVUSjk/U+BPNZwI7MTk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-OFxI83SzPHmhOiJNv3bWhw-1; Fri, 09 Aug 2024 14:12:52 -0400
X-MC-Unique: OFxI83SzPHmhOiJNv3bWhw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36873ed688dso1105321f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 11:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723227171; x=1723831971;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sj323lvxf0uig7IQaCEIEkKo11cOnZra8FRSfSMp7Hc=;
        b=o/YNAGQeudjnQmBK0xAv3zkbBEwal1pxU8WT1GhiIz3ky+KeIE1FuyHzlsvFumsMrK
         M+CFux5fAaD0wbJS/xZy51vhpEO3Mv+3uwHojIQjJWHN9ASpbvF8NV1AYVPYnt4j40tM
         jxLovSwfra6qqEVN2un1uHqkl6BLZWWNuleAIkEdMq8soQzS0ihrMjPhRdH2t+tS6JQm
         vVljKReW0NT8dQCKXGtSROVWiBQK2kKsio1J64RtrU949cTMMJ4p9SYE4uyv+Y5hpoBG
         7tERTKeURvUNgxxamS/hUGFEy6FOgN3aRaR2NxbXgykCrYuo4CL6QT/mwJBBpgOs5Fr7
         5R+A==
X-Forwarded-Encrypted: i=1; AJvYcCVxz2nlaDXadA9GQJl576BEeM9TEJan81c8OUYSUO4YyHESOdwbDVd43HOynKfm8yh8XMEZzdtQZXKTrzfUjEnFFIt3+4DAJ860Z72F
X-Gm-Message-State: AOJu0YwN0Qpe3VZEPX2a2Nm5LY25j5UcMlO4WgtRLTc7iUqe1B1Y+1Wf
	DURB/XO8DjqS2mxi45DEDdmTG7Rb8mu/rrlSIB0AM8MKAs8N66IKGKAGYbtfMfLwRtpdmliJrl+
	sOMCq5ZX+81OQMgj5WMyfGNexxKB6yTwVEVooWYa9xsr9tDe2ylP+n5bMLXIopw==
X-Received: by 2002:a5d:42c7:0:b0:368:48e6:5056 with SMTP id ffacd0b85a97d-36d5e4d0a3bmr1431699f8f.22.1723227171310;
        Fri, 09 Aug 2024 11:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG95222Q+0PbLU7RiUlrzkUH89jAPp3LdPm9sektMv/8EYFoJqVRLu3+zBYOk/k/n5Zh3vKXQ==
X-Received: by 2002:a5d:42c7:0:b0:368:48e6:5056 with SMTP id ffacd0b85a97d-36d5e4d0a3bmr1431671f8f.22.1723227170716;
        Fri, 09 Aug 2024 11:12:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c937b23sm136980f8f.35.2024.08.09.11.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 11:12:50 -0700 (PDT)
Message-ID: <6313b27c-342f-4c7e-bba4-085f2ca2cd2b@redhat.com>
Date: Fri, 9 Aug 2024 20:12:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] mm: Support huge pfnmaps
To: Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
 Oscar Salvador <osalvador@suse.de>, Jason Gunthorpe <jgg@nvidia.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Alistair Popple <apopple@nvidia.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>
References: <20240809160909.1023470-1-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240809160909.1023470-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.08.24 18:08, Peter Xu wrote:
> Overview
> ========
> 
> This series is based on mm-unstable, commit 98808d08fc0f of Aug 7th latest,
> plus dax 1g fix [1].  Note that this series should also apply if without
> the dax 1g fix series, but when without it, mprotect() will trigger similar
> errors otherwise on PUD mappings.
> 
> This series implements huge pfnmaps support for mm in general.  Huge pfnmap
> allows e.g. VM_PFNMAP vmas to map in either PMD or PUD levels, similar to
> what we do with dax / thp / hugetlb so far to benefit from TLB hits.  Now
> we extend that idea to PFN mappings, e.g. PCI MMIO bars where it can grow
> as large as 8GB or even bigger.
> 
> Currently, only x86_64 (1G+2M) and arm64 (2M) are supported.  The last
> patch (from Alex Williamson) will be the first user of huge pfnmap, so as
> to enable vfio-pci driver to fault in huge pfn mappings.
> 
> Implementation
> ==============
> 
> In reality, it's relatively simple to add such support comparing to many
> other types of mappings, because of PFNMAP's specialties when there's no
> vmemmap backing it, so that most of the kernel routines on huge mappings
> should simply already fail for them, like GUPs or old-school follow_page()
> (which is recently rewritten to be folio_walk* APIs by David).

Indeed, skimming most patches, there is very limit core-mm impact. I 
expected much more :)

I suspect primarily because DAX already paved the way. And as DAX likely 
supports fault-after-fork, which is why the fork() case wasn't relevant 
before.

-- 
Cheers,

David / dhildenb


