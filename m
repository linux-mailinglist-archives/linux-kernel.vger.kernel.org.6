Return-Path: <linux-kernel+bounces-556229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847EAA5C2E4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178D03AC641
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C2E1CAA99;
	Tue, 11 Mar 2025 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LciQ4bMH"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A59B1917F4;
	Tue, 11 Mar 2025 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700492; cv=none; b=j2vuQYsGg8Of5CTbjfXs7tLp4A2H6ohf8ru8Nim65ubOKWXay7Qlfm8FQPDbLD9/gOnCeOm+ceVRs5jwmS1W4h0kNKJ0donJp7awq4v/jESkSPUOKL5naKLQJvHBUtkITifZNy5BLf5rd29lcL5rd9IFGemcQff9LrJdODp4a3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700492; c=relaxed/simple;
	bh=NPuBGYE3sFyHND9ej2ajMNi2JPTBhERUIG1ACiXM8Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnNW1lOlu34lqf6tAPlKSmo81ia6Jm84kkrgFa4hnBShIYqECKSzQksZBzyJLONGbRXpwg+30Hyn9gbsrW6HhiDxiIxXbMDnU0rm2kjKEDXxupXQaYA4+3lG2u0Yf5Pi87u8wkcu3ASkyygiTcLOGn0h9IsAIOUJvwkIg3mwDjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LciQ4bMH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1089477566b.1;
        Tue, 11 Mar 2025 06:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741700489; x=1742305289; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TueZFVSlfkUTp0jdNfdYcZQNu83RAWuxPbzRk33Y34A=;
        b=LciQ4bMHE3ixb0ZDjiWK53kM1bzAZHyPpgg/yDZAphjG2MMYAlCs4ab+jqJniHgqfM
         LEXjd2dywRxvUugZ2ryJ8pvO5+hzozPsyWMK5VWlCMZD45mQRpaajZQ0VmdAPVCAaqCj
         Q7ObFXR2lr3nN3WEdqcaBb26Rt3EBpDnwZCL2VEF9t1PvE9rZlUCdDJdgINFhRYMFijV
         a/xXpWJRDFqMv3bLlv+MDoZlgIUxSBRXVTKi5gPV5tEJfdFBWywITpCxnzGt3VrmdZWI
         9bwv23xDph4CtvdGkJ243DF+h/KMV0ZdQglPf7TEE3pJUK/Fux95h9M2uSjBd1a/c2j2
         wE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741700489; x=1742305289;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TueZFVSlfkUTp0jdNfdYcZQNu83RAWuxPbzRk33Y34A=;
        b=eAYB2XH3wMNFUY6puGfR5msSisN0YalyEQQgzisoSWRZrYo2vSYCf9NCDUyXH1/Es2
         /ZvynXwK1aMT+JKE3xIcqTPH+GRPibsMqX5HTw+IL7KMo94m71B/XL15PvsjwjvKVV/N
         P4/Q6bv0BkHUpELfhaLCvXxTv2lzw0zWqASH3T1nwCk0yTaO63/Bb3PqSByaW3q+uATU
         deJEWPRRWcQp00y7lAs30UpaQp+EsGaym0MynJCYGA/L0R76k78a/u8oQz9yiPaSlegz
         q4FwG8062TzV2fL7PtWA8gb0q/cjcW+GGZuky3ECI8KP7ImRqfcqU4/lDcwG3UyWVDbe
         pKZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC4oxQl56vI+vlPIhiCGjRSYSxjtX4rDgVDIIE4t0erF4/eZjsGJsOB6T6Tk8Vo/xS9ujVBn2wG8iI@vger.kernel.org, AJvYcCVhffQAQZ7o1hQAsClPDV59CVClIQh8daSdF4FakKYfNlVygrjnCEPfiufOmGrlRx8vBCmqHOdSSmH8CEqn@vger.kernel.org, AJvYcCWEHzkWfUnJyicUgkqllD7pqZUvbbRtrbxoQEhxune5//hkp9dyRPFnd5U6q/CCCZEumWe7SIWQmz4V@vger.kernel.org
X-Gm-Message-State: AOJu0YxNoTY6SXle2njKDD9tmLPoluqbH0dl3KIEL8bfvbtTAIlvmNLA
	uTofK4yX+FWtqyJNdoRQnkpw02T6mQ2EdhsbKQqgrlym7Q+D6Ceu
X-Gm-Gg: ASbGncvnvJysBjYPyBmBqv8/qrXPmN84/cc3KFOXj6dQUyw8G4xgrR39bXe2siS13na
	tgeVxTzv9Mf6j4nw91Yv09JM0AnMTRmzg5O3teWf7jLkWsp5bdgFr/0S7E+rpHexQP7uqtQZK6M
	jjo8yZJdacrmipcgRz+waUcuqj3cQ3VmCsyfPOFIkcjqBPx+R0ttn0OglJsAv5aWCMu/9yeQHgI
	WTXD+N0+Gh0gxQI5V20fBoZjXB6YcZ5Iq+hH50gvqNpZtVbNv3OJyOXeift+1K7gmtmnMhZpPn1
	JIYAjlx46RW/WKSnPaUrLJUwDy4Z/XtFjq4j/28+gLV7quv30CbOEkQ=
X-Google-Smtp-Source: AGHT+IEqvcT3nUuyCclAJyMA5I1jSzcLHsXRqFYyLbC3aVoohYneT0bwBO9KyAHB0hhKMZdf6pm4uw==
X-Received: by 2002:a17:906:6a07:b0:ac2:c75d:f30a with SMTP id a640c23a62f3a-ac2c75dfff9mr258917866b.37.1741700488456;
        Tue, 11 Mar 2025 06:41:28 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac287653d1esm481132766b.125.2025.03.11.06.41.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Mar 2025 06:41:27 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:41:26 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 02/14] memblock: add MEMBLOCK_RSRV_KERN flag
Message-ID: <20250311134126.xfjdq6sq7jtcotck@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
 <20250223002229.xuk6xlp23zr72hkc@master>
 <20250310095124.pa7dwgqhxglqrfes@master>
 <Z8_Ju0p63GBCdSG9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8_Ju0p63GBCdSG9@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Mar 11, 2025 at 07:27:23AM +0200, Mike Rapoport wrote:
>Hi Wei,
>
>On Mon, Mar 10, 2025 at 09:51:24AM +0000, Wei Yang wrote:
>> On Sun, Feb 23, 2025 at 12:22:29AM +0000, Wei Yang wrote:
>> >On Wed, Feb 19, 2025 at 09:24:31AM +0200, Mike Rapoport wrote:
>> >>Hi,
>> >>
>> >>On Tue, Feb 18, 2025 at 03:50:04PM +0000, Wei Yang wrote:
>> >>> On Thu, Feb 06, 2025 at 03:27:42PM +0200, Mike Rapoport wrote:
>> >>> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >>> >
>> >>> >to denote areas that were reserved for kernel use either directly with
>> >>> >memblock_reserve_kern() or via memblock allocations.
>> >>> >
>> >>> >Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> >>> >---
>> >>> > include/linux/memblock.h | 16 +++++++++++++++-
>> >>> > mm/memblock.c            | 32 ++++++++++++++++++++++++--------
>> >>> > 2 files changed, 39 insertions(+), 9 deletions(-)
>> >>> >
>> >>> >diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> >>> >index e79eb6ac516f..65e274550f5d 100644
>> >>> >--- a/include/linux/memblock.h
>> >>> >+++ b/include/linux/memblock.h
>> >>> >@@ -50,6 +50,7 @@ enum memblock_flags {
>> >>> > 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>> >>> > 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
>> >>> > 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
>> >>> >+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
>> >>> 
>> >>> Above memblock_flags, there are comments on explaining those flags.
>> >>> 
>> >>> Seems we miss it for MEMBLOCK_RSRV_KERN.
>> >>
>> >>Right, thanks!
>> >> 
>> >>> > 
>> >>> > #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>> >>> >@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>> >>> > again:
>> >>> > 	found = memblock_find_in_range_node(size, align, start, end, nid,
>> >>> > 					    flags);
>> >>> >-	if (found && !memblock_reserve(found, size))
>> >>> >+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))
>> >>> 
>> >>> Maybe we could use memblock_reserve_kern() directly. If my understanding is
>> >>> correct, the reserved region's nid is not used.
>> >>
>> >>We use nid of reserved regions in reserve_bootmem_region() (commit
>> >>61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")) but KHO needs to
>> >>know the distribution of reserved memory among the nodes before
>> >>memmap_init_reserved_pages().
>> >> 
>> >
>> >I took another look into this commit. There maybe a very corner case in which
>> >will leave a reserved region with no nid set.
>> >
>> >memmap_init_reserved_pages()
>> >    for_each_mem_region() {
>> >        ...
>> >	memblock_set_node(start, end, &memblock.reserved, nid);
>> >    }
>> >
>> >We leverage the iteration here to set nid to all regions in memblock.reserved.
>> >But memblock_set_node() may call memblock_double_array() to expand the array,
>> >which may get a range before current start. So we would miss to set the
>> >correct nid to the new reserved region.
>> >
>> >I have tried to create a case in memblock test. This would happen when there
>> >are 126 memblock.reserved regions. And the last region is across the last two
>> >node.
>> >
>> >One way to fix this is compare type->max in memblock_set_node(). Then check
>> >this return value in memmap_init_reserved_pages(). If we found the size
>> >changes, repeat the iteration.
>> >
>> >But this is a very trivial one, not sure it worth fix.
>> >
>> 
>> Hi, Mike
>> 
>> I have done a user space test which shows we may have a chance to leave a
>> region with non-nid set.
>> 
>> Not sure you are ok with my approach of fixing.
>
>Wouldn't it be better to check for a change in reserved.max in
>memmap_init_reserved_pages()?
> 

Sounds better.

Previously I thought we need to hide detail from user, but actually it is
already in memblock.c :-)

If you agree, I would like to prepare a fix.

>> -- 
>> Wei Yang
>> Help you, Help me
>
>-- 
>Sincerely yours,
>Mike.

-- 
Wei Yang
Help you, Help me

