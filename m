Return-Path: <linux-kernel+bounces-553679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC27FA58D59
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C57169EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4CA2222A9;
	Mon, 10 Mar 2025 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbXzM2Zz"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C1B40BF5;
	Mon, 10 Mar 2025 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593392; cv=none; b=jQfjfsKKj19fSOiwfuVmQFEPDKHFzm18BPPjUfO7QTDpN22kn0NDPJXsCOr72PDCbq4bB3uqATLGEIexR+QyDCuMcBBiVrhlOYUthdBkBWS1fozAnLJsRXMS9uGR6OHUKYGMylYZh7UG8pYbbGaL4vhSwczeZWd2WdW17GIYhpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593392; c=relaxed/simple;
	bh=VGCbjL1HdMAREmVoEIFT6XGS9lZ7z8a47y+hv6zkmR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxGeAbuvhGVR5ESuLqqJnIOEIF0Heak96eqBCzowuTa9ku7n1CfrmJfzHZ9lHF9JkbaA3tD+hqN2Ls+skwCEjy9Kez1isMZeonfz5A/0SJWBof+W4Yv7z1PFs9DS4PW+1ndXEdAu98rMJMvs56xqOploJ6ntGjmWVg+fyX+dXow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbXzM2Zz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac298c8fa50so132320266b.1;
        Mon, 10 Mar 2025 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741593389; x=1742198189; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJwceBGDF2wkWgWu1pdO+uwWw+syZobUsImQSfkS6Tw=;
        b=cbXzM2Zzbip0vgDuX1cFpHSDprfRv2FURvUfC2o2dE2aOO2WLaaiU5Yek0DXn/625l
         A4KwqnYqu5kj5RUhLU6Uf6fRVcIzAupQ0zeirqucpjZSW8r1//bDGxzKEjtf9zWqViNP
         E6jniTHtCBKpUgm9iGMWhA620izVc6eG2Vw0FaRTIZ+QA+YWZhHoA3LXfww5ahK550+I
         +XVlQuYfQP9u8VvcEQx+ZFJ+H53p3I+noFuzORAKh4He9MbxpzDXktDi47hf5AZuhPRq
         85wlUrR/jz/V2F2993Wjg05/2P8zSU14L6ziRuMkW+7bzCDvQtYzL0jqs7BftDzj6Oqf
         DWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741593389; x=1742198189;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FJwceBGDF2wkWgWu1pdO+uwWw+syZobUsImQSfkS6Tw=;
        b=TEBx05Ts7oxbk2shci1BmjiHaIzASD0xIPAoskgBOX88WWZmPr7bEDVubgCJaqKLbV
         eUJFj0AY7mZRe0haRYSGmu+3fWeRg0f1GPYNpeSGJL5YVojaVurQ7H3fTbYiy0J2QVef
         WPIJOLKT2fT5Z2YQO98lDHCiNExBYZYkmVPJfCvH2cEI43KWpbOHjNJGWibbnjuf9Tsh
         1p+SEl/A61kAtPHbpNW2T+ghn+3XnsXRfFhQMdLVa2woSG6qtwrq69klhS2x/54btrNf
         yTqXPgFAAPsJiXL1xEViyMWQpUwo0t1mKRoNA8o5z5BoG/ZGZ0j7ECYEKbIC6y3e3VXC
         XWJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2NCjHB02Uvl71Bx9i/JnOO9sossf/SnYCh4fMXB9R+FW4rSZMZT7bHQttXI4LoHQn3kdE8vDsErQt@vger.kernel.org, AJvYcCWb1EOvtGdIfRiJ4k82XXc3JDy70twcDaY9R42rbdKG136tlmlcshdvUdkSnh/W5uBpFA8m27AmzHzL@vger.kernel.org, AJvYcCXUlzR+Kf3uerjBGQyHLhfrvrERRrilEzFVOnVFrtXyYfzpuY0kRQhHHEVt21uiFjS5ZrIpAq5pnWFO8Av4@vger.kernel.org
X-Gm-Message-State: AOJu0YzCcDB9STjT8eLEEWFWm8FUADeSxVILr3G7JzGb8qykipZrHKbJ
	XG4C/YraknHMvyO4u1BveNm6KPSfS2E5JEKxqhXq+nTy0Ni7Cv/f
X-Gm-Gg: ASbGncvKSomL8i3CGj3zKwN+QMMpJ3n72WQDvI23oU8yU3h8UV6xVArFewSlDXSFJKp
	Dp7W7vSObREG6yGqRF2/kPGQsOUZHJaEvsYEdmdLbC0bzxE2gIdEoZosmX2DC/gPfGMufHzbueB
	K0OARaIRxAYpGClB8ibR7xJaSYwVF1TxfnwCpMr5oUVGazIeA2b5/0KbFJSApE+yTtPsGXcdI6P
	KZc6MS4rJXYrsG3gC3RzK2OE89reeJ+fLIVFPXpIeLifNr0nHHG0TvY8A20CR9ESjCbvsl1ZZ91
	ZRwJnSS0Q8KoMx2a2Cl0gewg2tCmE1A8zbNhqDz6btZa
X-Google-Smtp-Source: AGHT+IEQ2uBHwcOdkgr7aGqLMWG+rbjuDIjMsdHGAG+hCMaeoXtOhIX4RmiolWfrWI8fpuA/uaZyUw==
X-Received: by 2002:a05:6402:268a:b0:5e0:49e4:2180 with SMTP id 4fb4d7f45d1cf-5e5e24688d1mr34122496a12.25.1741593388499;
        Mon, 10 Mar 2025 00:56:28 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac279b3e463sm371805666b.72.2025.03.10.00.56.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Mar 2025 00:56:28 -0700 (PDT)
Date: Mon, 10 Mar 2025 07:56:27 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <20250310075627.5hettrn2j2ien5bj@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
 <20250224013131.fzz552bn7fs64umq@master>
 <Z711VP45tjBi0kwx@kernel.org>
 <20250226020915.ytxusrrl7rv4g64l@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226020915.ytxusrrl7rv4g64l@master>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Feb 26, 2025 at 02:09:15AM +0000, Wei Yang wrote:
>On Tue, Feb 25, 2025 at 09:46:28AM +0200, Mike Rapoport wrote:
>>On Mon, Feb 24, 2025 at 01:31:31AM +0000, Wei Yang wrote:
>>> On Wed, Feb 19, 2025 at 09:24:31AM +0200, Mike Rapoport wrote:
>>> >Hi,
>>> >
>>> >On Tue, Feb 18, 2025 at 03:50:04PM +0000, Wei Yang wrote:
>>> >> On Thu, Feb 06, 2025 at 03:27:42PM +0200, Mike Rapoport wrote:
>>> >> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>> >> >
>>> >> >to denote areas that were reserved for kernel use either directly with
>>> >> >memblock_reserve_kern() or via memblock allocations.
>>> >> >
>>> >> >Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>> >> >---
>>> >> > include/linux/memblock.h | 16 +++++++++++++++-
>>> >> > mm/memblock.c            | 32 ++++++++++++++++++++++++--------
>>> >> > 2 files changed, 39 insertions(+), 9 deletions(-)
>>> >> >
>>> >> >diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>>> >> >index e79eb6ac516f..65e274550f5d 100644
>>> >> >--- a/include/linux/memblock.h
>>> >> >+++ b/include/linux/memblock.h
>>> >> >@@ -50,6 +50,7 @@ enum memblock_flags {
>>> >> > 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>>> >> > 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
>>> >> > 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
>>> >> >+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
>>> >> 
>>> >> Above memblock_flags, there are comments on explaining those flags.
>>> >> 
>>> >> Seems we miss it for MEMBLOCK_RSRV_KERN.
>>> >
>>> >Right, thanks!
>>> > 
>>> >> > 
>>> >> > #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>>> >> >@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>>> >> > again:
>>> >> > 	found = memblock_find_in_range_node(size, align, start, end, nid,
>>> >> > 					    flags);
>>> >> >-	if (found && !memblock_reserve(found, size))
>>> >> >+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))
>>> >> 
>>> >> Maybe we could use memblock_reserve_kern() directly. If my understanding is
>>> >> correct, the reserved region's nid is not used.
>>> >
>>> >We use nid of reserved regions in reserve_bootmem_region() (commit
>>> >61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")) but KHO needs to
>>> >know the distribution of reserved memory among the nodes before
>>> >memmap_init_reserved_pages().
>>> > 
>>> >> BTW, one question here. How we handle concurrent memblock allocation? If two
>>> >> threads find the same available range and do the reservation, it seems to be a
>>> >> problem to me. Or I missed something?
>>> >
>>> >memblock allocations end before smp_init(), there is no possible concurrency.
>>> > 
>>> 
>>> Thanks, I still have one question here.
>>> 
>>> Below is a simplified call flow.
>>> 
>>>     mm_core_init()
>>>         mem_init()
>>>             memblock_free_all()
>>>                 free_low_memory_core_early()
>>>                     memmap_init_reserved_pages()
>>>                         memblock_set_node(..., memblock.reserved, )   --- (1)
>>>                     __free_memory_core()
>>>         kmem_cache_init()
>>>             slab_state = UP;                                          --- (2)
>>> 
>>> And memblock_allloc_range_nid() is not supposed to be called after
>>> slab_is_available(). Even someone do dose it, it will get memory from slab
>>> instead of reserve region in memblock.
>>> 
>>> From the above call flow and background, there are three cases when
>>> memblock_alloc_range_nid() would be called:
>>> 
>>>   * If it is called before (1), memblock.reserved's nid would be adjusted correctly.
>>>   * If it is called after (2), we don't touch memblock.reserved.
>>>   * If it happens between (1) and (2), it looks would break the consistency of
>>>     nid information in memblock.reserved. Because when we use
>>>     memblock_reserve_kern(), NUMA_NO_NODE would be stored in region.
>>> 
>>> So my question is if the third case happens, would it introduce a bug? If it
>>> won't happen, seems we don't need to specify the nid here?
>>
>>We don't really care about proper assignment of nodes between (1) and (2)
>>from one side and the third case does not happen on the other side. Nothing
>>should call membloc_alloc() after memblock_free_all(). 
>>
>
>My point is if no one would call memblock_alloc() after memblock_free_all(),
>which set nid in memblock.reserved properly, it seems not necessary to do
>__memblock_reserve() with exact nid during memblock_alloc()? 
>
>As you did __memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN) in this
>patch.
>

Hi, Mike

Do you think my understanding is reasonable?

-- 
Wei Yang
Help you, Help me

