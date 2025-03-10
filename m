Return-Path: <linux-kernel+bounces-553725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30B0A58E23
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3542E3ABB6D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453CB223337;
	Mon, 10 Mar 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dt+61OBu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8451D54FA;
	Mon, 10 Mar 2025 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595303; cv=none; b=dT3n1k4vGgi36HDvQzi+JLJKxAffI01ms4FnzlTvrnzCACwwVfNJJMdZtNhU2c+5TquT0h7BnbMUnCkh4+uBIIiApDCp+yGnCoWGO3wsVdVJCl09XgilgNeIq/PDLnAKJh4E/9DWawY6F7kcP4zJak79AFyNs5YaI+WH7VRF9VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595303; c=relaxed/simple;
	bh=7uCFQcex+j6cpQPJF/6LfRBEaDs9jns/4ey91A2Sm5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLFjUHdFQo9/XyDWZRIIrUQn/sDUHV8ZAnxjCr7ahbhY03rzYD7qefrLl+VpY+XcoPaOKhV/gcOyfsRcmbKbHfy5lAFOxru24YGnYVYZg1nWtDVMxLVkwaGO9NVDXWWd0JLI90cTjPX4eZAgXOGA+IU4Ab6ku3b2R1Mzg4KLXds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dt+61OBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20474C4CEED;
	Mon, 10 Mar 2025 08:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741595303;
	bh=7uCFQcex+j6cpQPJF/6LfRBEaDs9jns/4ey91A2Sm5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dt+61OBuhSx0XzWa7kuR97NtRZolf+Ni76hFMdBs33YLt/1k+RMsxShKq8ywE5izv
	 Xq0lyi+y7SJzKRcmF6pLe0/pMIp2CN1NtohvIhp4Lfz70fUXaKP8fdlcvDgL6nFqFz
	 egPccLakn6UNDZwAc49vCsDGQvAccm2S6VOGcQu87kNkGYRfcWBfvdZMHBeMdQgSn4
	 J/L+XCc+GdJd0FpcGKyrg/IzPOfmKo79PxsSU2iqjEbBsVqKufsF8EZdPd3pBHuFq6
	 ipnF9XH2wTyTICRsMyZozegPxkb/EOVYqYIAdiNDHZduHzAW48E8qnjKEoT8Kf1pgw
	 OUmx0WBZnksfg==
Date: Mon, 10 Mar 2025 10:28:02 +0200
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
Message-ID: <Z86ikkLVHQhLmBWj@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
 <20250224013131.fzz552bn7fs64umq@master>
 <Z711VP45tjBi0kwx@kernel.org>
 <20250226020915.ytxusrrl7rv4g64l@master>
 <20250310075627.5hettrn2j2ien5bj@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310075627.5hettrn2j2ien5bj@master>

Hi Wei,

On Mon, Mar 10, 2025 at 07:56:27AM +0000, Wei Yang wrote:
> On Wed, Feb 26, 2025 at 02:09:15AM +0000, Wei Yang wrote:
> >>> 
> >>> From the above call flow and background, there are three cases when
> >>> memblock_alloc_range_nid() would be called:
> >>> 
> >>>   * If it is called before (1), memblock.reserved's nid would be adjusted correctly.
> >>>   * If it is called after (2), we don't touch memblock.reserved.
> >>>   * If it happens between (1) and (2), it looks would break the consistency of
> >>>     nid information in memblock.reserved. Because when we use
> >>>     memblock_reserve_kern(), NUMA_NO_NODE would be stored in region.
> >>> 
> >>> So my question is if the third case happens, would it introduce a bug? If it
> >>> won't happen, seems we don't need to specify the nid here?
> >>
> >>We don't really care about proper assignment of nodes between (1) and (2)
> >>from one side and the third case does not happen on the other side. Nothing
> >>should call membloc_alloc() after memblock_free_all(). 
> >>
> >
> >My point is if no one would call memblock_alloc() after memblock_free_all(),
> >which set nid in memblock.reserved properly, it seems not necessary to do
> >__memblock_reserve() with exact nid during memblock_alloc()? 
> >
> >As you did __memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN) in this
> >patch.
> >
> 
> Hi, Mike
> 
> Do you think my understanding is reasonable?

Without KHO it is indeed not strictly necessary to set nid during memblock_alloc().
But since we anyway have nid parameter in memblock_alloc_range_nid() and it
anyway propagates to memblock_add_range(), I think it's easier and cleaner
to pass nid to __memblock_reserve() there.

And for KHO estimation of scratch size it is important to have nid assigned to
the reserved areas before memblock_free_all(), at least for the allocations
that request particular nid explicitly.
 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.

