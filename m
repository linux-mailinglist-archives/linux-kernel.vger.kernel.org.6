Return-Path: <linux-kernel+bounces-553892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F52A5904A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D637A16BE1C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786B92253FD;
	Mon, 10 Mar 2025 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl6366UW"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CC42248A8;
	Mon, 10 Mar 2025 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600297; cv=none; b=M9vdWwZmQMFqH/bTHt8Drt5a6BCblPw1aHFBn+D4hIFi57LY7qT+manxqima57Yx/Vji4RFAEurGOqO1mJDDJt8lkKWnBRpBlSAXf5HwtkWRtR+YwBkl7uJ90RdLfK1X3FG14cwcDHa6HnJxS5kQwLaFzdIa+Nd3Zqwal1zXXis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600297; c=relaxed/simple;
	bh=KcsuoE5oc+tflOf5s+fkW50lshhYKgljE2mWx5LItuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0GJWuNPwPJCSGSehNG6xdTVv5gvQhEj2hT2tzVV8qUhotAs3+OInThAumJbcx/jNfL0kjufD7UyO9afag94fywHvvm/dA3Q14utPkJ5yNw7rhekFnxjMSfejq8Ipxy9hMEFl2cFb1wCECRk5nOE3IJqLz8zZeSMy4XALkdT+Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cl6366UW; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abf4b376f2fso750590066b.3;
        Mon, 10 Mar 2025 02:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741600294; x=1742205094; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fIk/wLn8siLSomZZskx1hmM4iyC641S3xGJlKKijlM=;
        b=cl6366UWtMCfZLO1rHOgXS7DihlEtSbIlvmgXfCK/TTp7e879cYQ/fMO/1QfrgSahQ
         EWRX+ckMiP0lJZzdkapUiT4ulNP8UHaxnQ5fpQKw4p0dkcaHqlxve8yOGHrhXnAxgf2X
         plq9tKh0a8sR8WhFjPPTfhs7sV+ZC+5omeQlk+aM5aTd7/C4KhFSe4We9nXsoR4gyj1Y
         QXYf4d/fwQay6q3VSOfnAhk85AI0vCcKcsDJkSdbzmOqO2vr8SlTJ2zb3hRoStLCd4cU
         RoilNsv3clVOJawPXcuBOYMzULuU1zQfo6KB2rCaHu17EsRhG6RIQKMsfBrWSFBWcrm/
         EYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741600294; x=1742205094;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7fIk/wLn8siLSomZZskx1hmM4iyC641S3xGJlKKijlM=;
        b=WHzrqGR68pC9JKfMB1Br947PJ8U7N3TJvHdo/64IBl66BOidfMkD5o2LNQux9lm5uZ
         lIYefm0/D7O8mh73ZW3A6aXCzvN9jOZXhMkUOOq8Oup5h5d4N5xS6qmSM20GRtGcbnvg
         Ho6b7usCFvEMLeWRe8FUAMyDyxr/G/hHf8vX4IIZCe6jGIoYyiu/57fuAFi2nlQSvSYh
         pguQ7L6uzEkxIxgdT8RprzdVLIuw7DTHVNxdnSunw7EaLQonJHkTx9TjBW1D5KP0+0kH
         tbWEyOD7lZ7ReziVo/DWhzbbZLLHG2/BRzxD7hOs9djwEVWc3hwVKFXR/al4ucZ8h8cS
         334Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxWrCMX7+imHK5yid25aSgePBgXXPtSdQt29iBlmuW0T7q/AXcRsfh1i5g2OFpjQu/r+TY5PWm23Mp@vger.kernel.org, AJvYcCW0kflvjg8MEvnJiJEuT92INi6dNxy9P1cJIB/8Fx128iKY7NHDJTqqoe1wLKUDyWaulY1UvFMVq6bU@vger.kernel.org, AJvYcCWpW7fb7rj3k9qiS4qGEgB9CA0fLeEquy+3/Xu/dqQTshKPmDehAo+4nXqeptEkDJbP3C0tSgPL4HJqG4DD@vger.kernel.org
X-Gm-Message-State: AOJu0YydbIZWWHU52nCwLlyaUqvLWudGAFzr8CLVRl6yJubXNkXOO6rt
	uFyV472ASbwuEkFD+LssO7NiHGFee67ndzXNJ0BzpRJFJ3WwQpcC
X-Gm-Gg: ASbGncs/6jZrbXnAJJGaVbN6Roji4ySRxUrFhHF5/L7XSuvU2RIoW6poqSLoq33KTho
	gmGlLxTPdiQIuL9VsgJ69U7YtdnXL7siMxLhjzOXCtuNIUgXzy4nDFT3IWRD/HSTZ5mnw7QLwLe
	qh+W5xZ0ciIwoancG123tmNTIFGAOPJzEDd205gVdX6AVle/m+SAI2fqj2Zf++N3FE2+h2e5vku
	npsP3DHA2uSklL6TS8lq+LMNEwaLyBWfHOUzqUUpWO1u4k9G1lA6fKnERyHQReMXWMHuNKygann
	MOfCZege2v9SeiNFKOUGfiifIZIYSA50+mkDfJthLrPSHoWbREaxqQE=
X-Google-Smtp-Source: AGHT+IEnsaBC89bibOD1BqC+ZZ1kovv3JGu+umNRENY/jx8wzQl9KTymklI/3Rp6DH54iA+FTxPRUw==
X-Received: by 2002:a17:907:3f2a:b0:abf:5fa3:cf96 with SMTP id a640c23a62f3a-ac252a879d7mr1234111666b.14.1741600293920;
        Mon, 10 Mar 2025 02:51:33 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac255589a30sm594247266b.107.2025.03.10.02.51.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Mar 2025 02:51:25 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:51:24 +0000
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
Message-ID: <20250310095124.pa7dwgqhxglqrfes@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
 <20250223002229.xuk6xlp23zr72hkc@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223002229.xuk6xlp23zr72hkc@master>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sun, Feb 23, 2025 at 12:22:29AM +0000, Wei Yang wrote:
>On Wed, Feb 19, 2025 at 09:24:31AM +0200, Mike Rapoport wrote:
>>Hi,
>>
>>On Tue, Feb 18, 2025 at 03:50:04PM +0000, Wei Yang wrote:
>>> On Thu, Feb 06, 2025 at 03:27:42PM +0200, Mike Rapoport wrote:
>>> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>> >
>>> >to denote areas that were reserved for kernel use either directly with
>>> >memblock_reserve_kern() or via memblock allocations.
>>> >
>>> >Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>> >---
>>> > include/linux/memblock.h | 16 +++++++++++++++-
>>> > mm/memblock.c            | 32 ++++++++++++++++++++++++--------
>>> > 2 files changed, 39 insertions(+), 9 deletions(-)
>>> >
>>> >diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>>> >index e79eb6ac516f..65e274550f5d 100644
>>> >--- a/include/linux/memblock.h
>>> >+++ b/include/linux/memblock.h
>>> >@@ -50,6 +50,7 @@ enum memblock_flags {
>>> > 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>>> > 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
>>> > 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
>>> >+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
>>> 
>>> Above memblock_flags, there are comments on explaining those flags.
>>> 
>>> Seems we miss it for MEMBLOCK_RSRV_KERN.
>>
>>Right, thanks!
>> 
>>> > 
>>> > #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>>> >@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>>> > again:
>>> > 	found = memblock_find_in_range_node(size, align, start, end, nid,
>>> > 					    flags);
>>> >-	if (found && !memblock_reserve(found, size))
>>> >+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))
>>> 
>>> Maybe we could use memblock_reserve_kern() directly. If my understanding is
>>> correct, the reserved region's nid is not used.
>>
>>We use nid of reserved regions in reserve_bootmem_region() (commit
>>61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")) but KHO needs to
>>know the distribution of reserved memory among the nodes before
>>memmap_init_reserved_pages().
>> 
>
>I took another look into this commit. There maybe a very corner case in which
>will leave a reserved region with no nid set.
>
>memmap_init_reserved_pages()
>    for_each_mem_region() {
>        ...
>	memblock_set_node(start, end, &memblock.reserved, nid);
>    }
>
>We leverage the iteration here to set nid to all regions in memblock.reserved.
>But memblock_set_node() may call memblock_double_array() to expand the array,
>which may get a range before current start. So we would miss to set the
>correct nid to the new reserved region.
>
>I have tried to create a case in memblock test. This would happen when there
>are 126 memblock.reserved regions. And the last region is across the last two
>node.
>
>One way to fix this is compare type->max in memblock_set_node(). Then check
>this return value in memmap_init_reserved_pages(). If we found the size
>changes, repeat the iteration.
>
>But this is a very trivial one, not sure it worth fix.
>

Hi, Mike

I have done a user space test which shows we may have a chance to leave a
region with non-nid set.

Not sure you are ok with my approach of fixing.

-- 
Wei Yang
Help you, Help me

