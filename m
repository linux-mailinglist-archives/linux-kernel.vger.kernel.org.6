Return-Path: <linux-kernel+bounces-557238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F72A5D57E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFD8189AD92
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224081DE4F3;
	Wed, 12 Mar 2025 05:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJLi4J2x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A1DF9D6;
	Wed, 12 Mar 2025 05:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741756973; cv=none; b=rTfgHnZ/tzZvHkTsc7gwtO+gBW1JXKLtzdTuKpkRM+i3odu7aq6GmatkkREREYZo4A6oMSvqCpS6fUnybCRjXyWm3PCFusUrI8OxuhZvsZ/vcQ5OLhGinOtkzDOVQIrcY6g8MT4x9La1S2M9/q7/B1LBx17i2iCNIFFyAeOad7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741756973; c=relaxed/simple;
	bh=MX9hYn1R3GA95hwjkNf4w1qXBrTQlxYINeZ/wUzSEoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZBd6cov6z4C4HZMsrG4lJY0u70SK1LS9MLh3+iyTQ7MG/Xm6b6YiNnCACCP2M3A3hNRU5aNWu7xfNJ5AIgZdj3HhI4kcQNzZNd646mhWHgebgjTR5oWA+nFyJ76BQpkLdzdWRJ+vha/wjsU2k7Bbz3ONnesmEYbR6GqgphN4pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJLi4J2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02259C4CEE3;
	Wed, 12 Mar 2025 05:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741756973;
	bh=MX9hYn1R3GA95hwjkNf4w1qXBrTQlxYINeZ/wUzSEoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJLi4J2x24E0OjEkqPuO1haW7AHR6DGYru/D1S6ptUFAvXbp8in4nAmGLKr2pOUg7
	 Z1J0plTI95OI5ebPj6ikSorMqIzs0QJEWTxu/wtkocmIXt2J7MukuodYaHq6AaCIbe
	 jjFPMJdAZgZHtTYJTVSEXf37NEP0oaHu8LCtGp5IhwCZJzWVAmRXwqDqvijPZiTaRi
	 K6OyYLahKkCniytb67C66EIRERf+81EC2yi2+TksactycCQF2RWhWrZFsp/iCcTi9a
	 JhFxt5gH9x92KyCsM0hxvS6FcRsy7ygG829sFZf8gGkI7EAo1Jz2UNTLaIb/g4ITvo
	 6pD0U/hv4Ofow==
Date: Wed, 12 Mar 2025 07:22:30 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
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
Message-ID: <Z9EaFhviaZHOqs8j@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
 <20250223002229.xuk6xlp23zr72hkc@master>
 <20250310095124.pa7dwgqhxglqrfes@master>
 <Z8_Ju0p63GBCdSG9@kernel.org>
 <20250311134126.xfjdq6sq7jtcotck@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311134126.xfjdq6sq7jtcotck@master>

On Tue, Mar 11, 2025 at 01:41:26PM +0000, Wei Yang wrote:
> On Tue, Mar 11, 2025 at 07:27:23AM +0200, Mike Rapoport wrote:
> >> >> 
> >> >
> >> >I took another look into this commit. There maybe a very corner case in which
> >> >will leave a reserved region with no nid set.
> >> >
> >> >memmap_init_reserved_pages()
> >> >    for_each_mem_region() {
> >> >        ...
> >> >	memblock_set_node(start, end, &memblock.reserved, nid);
> >> >    }
> >> >
> >> >We leverage the iteration here to set nid to all regions in memblock.reserved.
> >> >But memblock_set_node() may call memblock_double_array() to expand the array,
> >> >which may get a range before current start. So we would miss to set the
> >> >correct nid to the new reserved region.
> >> >
> >> >I have tried to create a case in memblock test. This would happen when there
> >> >are 126 memblock.reserved regions. And the last region is across the last two
> >> >node.
> >> >
> >> >One way to fix this is compare type->max in memblock_set_node(). Then check
> >> >this return value in memmap_init_reserved_pages(). If we found the size
> >> >changes, repeat the iteration.
> >> >
> >> >But this is a very trivial one, not sure it worth fix.
> >> >
> >> 
> >> Hi, Mike
> >> 
> >> I have done a user space test which shows we may have a chance to leave a
> >> region with non-nid set.
> >> 
> >> Not sure you are ok with my approach of fixing.
> >
> >Wouldn't it be better to check for a change in reserved.max in
> >memmap_init_reserved_pages()?
> > 
> 
> Sounds better.
> 
> Previously I thought we need to hide detail from user, but actually it is
> already in memblock.c :-)
> 
> If you agree, I would like to prepare a fix.

Sure :)
 
> >> -- 
> >> Wei Yang
> >> Help you, Help me

-- 
Sincerely yours,
Mike.

