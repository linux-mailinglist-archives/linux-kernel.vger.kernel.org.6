Return-Path: <linux-kernel+bounces-523189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB09A3D354
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1EC189D601
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091901EB189;
	Thu, 20 Feb 2025 08:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEBquWKT"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9D11E571F;
	Thu, 20 Feb 2025 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040566; cv=none; b=CRecd3pIjjYmZIh67jBzj9GuYhodsOyW1Cz0SobDS/aOoXnbOVGpCPZzGK5QFA/Se9RuTNvcTWCvN1sB5q+xmialG+H1YQPyugxCWolJ+z9rDCfdFxowZWSj5RdAZLcJ2Ix+4sHjunIQeT46h1oTipggCu3Xlr1bHEETwbg/55s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040566; c=relaxed/simple;
	bh=stqDS9AX3y7H3mWwV3DJihDNRqA9BbbNBvl1ESip09w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmZYGYdCzO2NDMKL4tw4Ckzn6icwjYrb0snoRaA2J4rcEv6aWyqd7wtvrKyMoD4b7/N35SspJJ2oTCeTuQnSJ3iHtAwycjFOkNdWJshcaB/fTDb8XBO4ZhLfEbgVQIGgVwpCXlT8dQLd1JO28fcB0dZysduJ9ZlWjVO6MbgTiVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEBquWKT; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso124767866b.1;
        Thu, 20 Feb 2025 00:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740040563; x=1740645363; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEaHAsDM2MLSNpt7MvRkD4rjd16wxN3bWpPMinYr6Xg=;
        b=lEBquWKTdixtltA15hhm18jZYNX6B9IlErqxHdkIg35tfxy0MFkhsrRWll8gGs4brv
         obwSbGZR/GQNZU+O2jLaueBh9wfFRww/SaO8jg0PSuJC5Mxd2rzy7VJZFv2DyeCnNg0j
         RxUoja5KjrKx3cF7dTUULSFvmGkq0crtIS06T8Sv3uSY2iYVGJw/bttc2Hn6RfMP8yXk
         Xayomqa90ATbfo2GindG+r8U021pIUAAAcx/WBTdqLv/wQLVTy6r01n/hPZH95puYlgw
         5jcKdzBjzBGBObZep7PfDP1vxGS4GxRB5OF3kD3vFVzyUavGli1N/zd4bbQ4FnX5D4ct
         QK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740040563; x=1740645363;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SEaHAsDM2MLSNpt7MvRkD4rjd16wxN3bWpPMinYr6Xg=;
        b=UT7zQfin+9oEKDCYXBWMD5ppRLPJVp0AWUaDo6n78yMl4+ceG6UMJEa3ib3UznK6WD
         xB9dbrqsiGkgVKf/pjkbk7vhgk+j2c7xCDHs6mN0UhmuLFXsmlxXVE5kDBzldSuzAVNA
         fykeiJib1Jq92ZaizJQgUySUGxv9lqNc4yBXf4cLNMDQR2gLixA503mW7h+fo86UrIgs
         w38f0n6ZrWe9DTdvmSEpSitCpM7WVRJMPW9SV4yOIC/jIU4oWwxCDaDhDsGTRk6ZJlQj
         P64igDqvYl5hCQYWZHEDstErYI7lz0GanXLnTLJIsfst886CTyfQrTAZbxuh1akNAQaP
         URvg==
X-Forwarded-Encrypted: i=1; AJvYcCWYarqlMvswyZ8tYCuVMkpmAxyO6ag5Tq8nDcR18CgWPMvVlZNOw2YRvy3DKx6D3jT9lSoEe19socEO@vger.kernel.org, AJvYcCWrc0aPjj1UFIloZI4u3uMRWvnHnDmIy2zibWJcN/ZdXqRG7F2JqGhhrdMoPpAG1rgUcPihwOJDFinK7ZRB@vger.kernel.org, AJvYcCXJ5XLnibiGLk6j0zbl5TnH0NDYtAgIHJJsfBZrXoWXGJdihVJ+qMw/jC06W9NHqvuXPFcINrJThxJ7@vger.kernel.org
X-Gm-Message-State: AOJu0YwiOUS24HGKkDbY4Uc1vb2OXcThBIWiaYho3vNiCEUCYmsPOULx
	peZr9Nzde7RDj70Jn9GEmXlEvCnk2rpXpBJIk387stSAkBQVmCq8
X-Gm-Gg: ASbGncukNjSTJO/K3hkgdmEuLm8YKXbYjjL9xsXUYa3WJLEWzLDkZ9e4OdfL04Q6ZNa
	CqGZ+Mubt1ijNWnI5xOF5pwQfsnN52DPkGz6I9OWFsDrISYznclC9pKmLtGW1G87E0Ku/WsW0FK
	z7Ry3dCHoHSAgGkJjSj1VgAmGj9BHqMv7YS0ARr2L5c23K4+zp2PnRYXmY4lZE8tD8aPfIOV5Sd
	WmDUi2QmQmMd9C0MAV8i6bAj5IIAxdrCohEMGHiVJdRGJUelGZdb9GtWNXi62SnAYWj/SjictAP
	PBuGMo/p/Z+rqxk=
X-Google-Smtp-Source: AGHT+IE9Q2O6cgNo6w+VEkK3+GcOBd0W7VIAg8ovqvSo1Dx6kdse3rC3i3ABuRQoN+lqO1U9Ke9Kyg==
X-Received: by 2002:a17:907:60d6:b0:ab7:f0fa:1340 with SMTP id a640c23a62f3a-abbcd0b2d3dmr769569466b.50.1740040562436;
        Thu, 20 Feb 2025 00:36:02 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb86c9320csm915498766b.55.2025.02.20.00.36.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2025 00:36:01 -0800 (PST)
Date: Thu, 20 Feb 2025 08:36:01 +0000
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
Subject: Re: [PATCH v4 01/14] mm/mm_init: rename init_reserved_page to
 init_deferred_page
Message-ID: <20250220083601.4p6ehmfhyvs5q5io@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-2-rppt@kernel.org>
 <20250218145904.x57chhz3whvckzu3@master>
 <Z7WEktyNoCPylytL@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7WEktyNoCPylytL@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Feb 19, 2025 at 09:13:22AM +0200, Mike Rapoport wrote:
>Hi,
>
>On Tue, Feb 18, 2025 at 02:59:04PM +0000, Wei Yang wrote:
>> On Thu, Feb 06, 2025 at 03:27:41PM +0200, Mike Rapoport wrote:
>> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >
>> >When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, init_reserved_page()
>> >function performs initialization of a struct page that would have been
>> >deferred normally.
>> >
>> >Rename it to init_deferred_page() to better reflect what the function does.
>> 
>> Would it be confused with deferred_init_pages()?
>
>Why? It initializes a single page, deferred_init_pages() initializes many.
>

See below.

>> And it still calls __init_reserved_page_zone(), even we __SetPageReserved()
>> after it. Current logic looks not clear.
>
>There's no __init_reserved_page_zone(). Currently init_reserved_page()
>detects the zone of the page and calls __init_single_page(), so essentially
>it initializes one struct page.
>
>And we __SetPageReserved() in reserve_bootmem_region() after call to
>init_reseved_page() because pages there are indeed reserved.
> 

Hmm... I am not sure we are looking at the same code. I take a look at current
mm-unstable, this patch set is not included.  So I am looking at previous
version with this last commit:

  8bf30f9d23eb 2025-02-06 Documentation: KHO: add memblock bindings

Here is what I see for init_deferred_page()'s definition:

init_deferred_page()
  __init_deferred_page()
    __init_reserved_page_zone()   <--- I do see this function, it is removed?
      __init_single_page()

What I want to say is __init_deferred_page() calls
__init_reserved_page_zone(). This sounds imply a deferred page is always
reserved page. But we know it is not.  deferred_init_pages() initialize the
pages are not reserved one. Or we want to have this context in
__init_deferred_page()?

>-- 
>Sincerely yours,
>Mike.

-- 
Wei Yang
Help you, Help me

