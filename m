Return-Path: <linux-kernel+bounces-566840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87400A67D2B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537E73B4735
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FB51DED62;
	Tue, 18 Mar 2025 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9a/QhYV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC981A23B7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742326551; cv=none; b=qfgdEJFPis9Q8b3z1vlUQtkzMduhtclrN05Dg666Hn+Wz5TniYa3PX+8FVSCAX+8TMYK4m4v97w8hzTszfRx3BmHqafexwePLAJZyDat9QJMYIDf02s4OxTvUAYMfwDErEgBur5/uS7KNmUxH1vODq9sNp757iAXEgoR8UePMOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742326551; c=relaxed/simple;
	bh=f/QBz6IfVnIR29svc7lqf0vNczo7C6hhmWyX6/PY1AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BuDLFFzF8S/Rw9y1Zt2fuxcvVAflla9OjuJMWkSVhLvN7zbUl+fWeUSyv+/yJ+t6FrXaq9Vbif/pmkIY9++UYsGYxHX2DlGuh3JH7+IH3eaDuBE1BgvDW0HHWDGHi/ji6lPXZuZZ4k3TBCAoLYI4RXI7HNBWK0cZA6iAWot0NeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9a/QhYV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742326544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xLs+LXq8C98//OO0HbKq7CS3xV3X6jR9yyM2sWWpf8E=;
	b=e9a/QhYVVipkU7a8im4x2vXtDczCH7MdEYvmW+ETP9+SFLmhCNN3Wl/kmU6RxqImpOn/JS
	TUAes9LlRRRMGsrQu6pwgtbaDfCpIGcCnXXOlhYsO1dhIhdfEHilnk6/JggfGPJ3tBmaUS
	b1NoGB4vNHHztErSg7maPsTvyYLFou4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-Q0jpbW47Ol6TO8Jglno_-A-1; Tue, 18 Mar 2025 15:35:43 -0400
X-MC-Unique: Q0jpbW47Ol6TO8Jglno_-A-1
X-Mimecast-MFC-AGG-ID: Q0jpbW47Ol6TO8Jglno_-A_1742326542
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43bc97e6360so19982535e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742326542; x=1742931342;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xLs+LXq8C98//OO0HbKq7CS3xV3X6jR9yyM2sWWpf8E=;
        b=Yv/sLnv9IrhR4NKFi8G3Zl4wTw/sPSaUk/U/yRggQ4l3Vyc8NlZZxmct8DxDI25tK3
         SFDm4rdkDKZc8pfWo94ySajncvyMDxLUvJyxe6dvRZO/yHKSTJLQ8vq0OTFncXpJDv8J
         ntZhRMS6AFPK8FIASteRGGmK/E4jJAqVA4cmgjahUsqVcjVHtUgn9vKdCVMmGWHnJDNY
         M1Y4c6le0ArfgyWrEbeIzKk+ZazwGDM+mGb90qdQNU6151GdnjEfpJlWtLHGxkqDZ1uv
         a100WHMylOao3DeHnrCrIns0+A3lbyW3FNDJhTW3d+MKGHMGbXhrYrxfzn0AzcrzZWCG
         ov0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCunLYub1cBKF4biAOZTeqInfrv3M+2wkcPcODrlDVzHyc64Tk7l0fRL+y4m1fBzCo2NAbXUOyRhAfjH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUkW545Yy12tFuUDNQ4UmkRHakrVH4X8mLp2pgn7lhfbU1npNu
	Xn4TB9qX0ULh4tGO2JC7oyZDOy0+wzv1b8a8cn7proKH0Re4UUeYxq+5LlLE7HBH1zrgkXvBmpL
	XmpJ4HZcn8ltK4dS1jDxekRTZJXOONFjEOTUTlo6mJmBXhQX35ZMnt64v/NrVLQ==
X-Gm-Gg: ASbGnctfb3cA1XOZpw9etwLR6akzzpbcASv7U/3Be3GLPxNNkyNuojOpRKKWLqQ2mcH
	7ZwPky82LjC6/ifvffjJmxk26FLDCRDYPtzQVUJY6dCfItU9VxPiDXVLQENn5cNuhniteAt7dmH
	Q+TygCPjpdYrZ+OtW+KDPedh6unzpTmV7sOdXPNZXrRIhV+DwTUc++r5IZah030nM8ByDqXu3vU
	Hy8xGJ02A5cysETFXd0pJklr74vPoF7saVSao51nH8QgAmuj7cRiDPA6Ly8nOy+Y1woHcjJ6BK6
	APwf5PXhBn2cAZ7zMbP4kppOtj5LzHWwcYE+efQfa3JAY50c+neCoWak5ejuU4v5RKPGEXKowCn
	TVRl9lVUf8z34I8NRokMZ1TpV/jP+8OSSa8jnBKGeeWA=
X-Received: by 2002:a5d:5886:0:b0:391:47d8:de3e with SMTP id ffacd0b85a97d-39973b0a885mr27230f8f.46.1742326541932;
        Tue, 18 Mar 2025 12:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ1yPH0fDVPiavpoowLztyi/zjpyp6XUZXcFalnE3ESvYjVfIFP6FPmuLR2D4oULPZhko2Ow==
X-Received: by 2002:a5d:5886:0:b0:391:47d8:de3e with SMTP id ffacd0b85a97d-39973b0a885mr27214f8f.46.1742326541578;
        Tue, 18 Mar 2025 12:35:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72d:2500:94b5:4b7d:ad4a:fd0b? (p200300cbc72d250094b54b7dad4afd0b.dip0.t-ipconnect.de. [2003:cb:c72d:2500:94b5:4b7d:ad4a:fd0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3978ef9a23bsm14708842f8f.15.2025.03.18.12.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 12:35:40 -0700 (PDT)
Message-ID: <ed25f5a6-dad6-4b5e-b42b-58e6ced6c7a2@redhat.com>
Date: Tue, 18 Mar 2025 20:35:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] KVM: arm64: Allow cacheable stage 2 mapping using
 VMA flags
To: Catalin Marinas <catalin.marinas@arm.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Marc Zyngier <maz@kernel.org>, Ankit Agrawal <ankita@nvidia.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "joey.gouly@arm.com" <joey.gouly@arm.com>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
 "will@kernel.org" <will@kernel.org>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "shahuang@redhat.com" <shahuang@redhat.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Dan Williams <danw@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>,
 Dheeraj Nigam <dnigam@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "sebastianene@google.com" <sebastianene@google.com>,
 "coltonlewis@google.com" <coltonlewis@google.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "ardb@kernel.org"
 <ardb@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "gshan@redhat.com" <gshan@redhat.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "tabba@google.com" <tabba@google.com>,
 "qperret@google.com" <qperret@google.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <861pv5p0c3.wl-maz@kernel.org>
 <SA1PR12MB7199DD985C45943A663E7003B0D12@SA1PR12MB7199.namprd12.prod.outlook.com>
 <86r033olwv.wl-maz@kernel.org>
 <SA1PR12MB7199500A3683B15A64B663D6B0D12@SA1PR12MB7199.namprd12.prod.outlook.com>
 <87tt7y7j6r.wl-maz@kernel.org>
 <SA1PR12MB7199B320DAE42A8D7038A78EB0D32@SA1PR12MB7199.namprd12.prod.outlook.com>
 <8634fcnh0n.wl-maz@kernel.org> <Z9h98RhunemcFhhz@arm.com>
 <86wmcmn0dp.wl-maz@kernel.org> <20250318125527.GP9311@nvidia.com>
 <Z9nJH38Em9XEx3U7@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z9nJH38Em9XEx3U7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.03.25 20:27, Catalin Marinas wrote:
> On Tue, Mar 18, 2025 at 09:55:27AM -0300, Jason Gunthorpe wrote:
>> On Tue, Mar 18, 2025 at 09:39:30AM +0000, Marc Zyngier wrote:
>>> The memslot must also be created with a new flag ((2c) in the taxonomy
>>> above) that carries the "Please map VM_PFNMAP VMAs as cacheable". This
>>> flag is only allowed if (1) is valid.
>>>
>>> This results in the following behaviours:
>>>
>>> - If the VMM creates the memslot with the cacheable attribute without
>>>    (1) being advertised, we fail.
>>>
>>> - If the VMM creates the memslot without the cacheable attribute, we
>>>    map as NC, as it is today.
>>
>> Is that OK though?
>>
>> Now we have the MM page tables mapping this memory as cachable but KVM
>> and the guest is accessing it as non-cached.
> 
> I don't think we should allow this.
> 
>> I thought ARM tried hard to avoid creating such mismatches? This is
>> why the pgprot flags were used to drive this, not an opt-in flag. To
>> prevent userspace from forcing a mismatch.
> 
> We have the vma->vm_page_prot when the memslot is added, so we could use
> this instead of additional KVM flags.

I thought we try to avoid messing with the VMA when adding memslots; 
because KVM_CAP_SYNC_MMU allows user space for changing the VMAs 
afterwards without changing the memslot?

include/uapi/linux/kvm.h:#define KVM_CAP_SYNC_MMU 16  /* Changes to host 
mmap are reflected in guest */

-- 
Cheers,

David / dhildenb


