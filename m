Return-Path: <linux-kernel+bounces-511511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7EDA32C08
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53E5168B36
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20C22505B3;
	Wed, 12 Feb 2025 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwS+nkzE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812E21D59F;
	Wed, 12 Feb 2025 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378366; cv=none; b=or5tDALZtHDBHqvDTx2Hwqf1CpyS1Vg68idZsAE6qaC0jx60KcvauWZ/36zfgNUT1bfVoou9kGRj0CyKTjy7B0GSJB/rPqZKHCxc3hF/59nx8aXaZcrhs+MNZ6OEIRvL3oFKDCYj2aZYdxjyb3DqwxmM6RdkhKy+KFukjWSYkAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378366; c=relaxed/simple;
	bh=zfEIpiTrcj/R2Ru79c+QdETWalY9N06YUbZ/uIkxoRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouMkRc1IdQFW9foD5Jwj1kinCEjhoWbTyYoIv2Agkv1xv0FkbY1ocVKcpMjpRHyuZSpHGzl7Rueign0AOE0kFZYLWuaV7Ij4gQ4YnPsSM3ogWq+Lb03GK4unqlIkG6u0/ewYeGCcILqEmNb55pADrC4BFDrRTK39kyPzo3NNUPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwS+nkzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45E0C4CEDF;
	Wed, 12 Feb 2025 16:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739378365;
	bh=zfEIpiTrcj/R2Ru79c+QdETWalY9N06YUbZ/uIkxoRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LwS+nkzE62iYAWY6oMvTiOE2hZdqZW4je7lUt/Tn8svDT0aqJyRSG1Te50dWeoSK6
	 yZO90wTxRzWvs64nxtq+JimjJqslPOcN7j/gDEv42ILOhCNdmCR6wWLQcePUqYZ0Yz
	 uadqjYhtm/BeUJnOKtwxaC2USAWhcuMi9AeP4KLnjL50JLMhS7jyRHMJsejxavbVDh
	 sV1QU2dtmz9BzlPJHJQTzkrOQXYWw8C3AzJ/mP1FzbO60nnOuds/LnOuA/bs/jEEl1
	 +GgoenuPWq9nhK1ojBt2vq5J0TI5Wg9+EvPg0Lk5i7f20zfeNS5Qm+VHUuZdt6qoTp
	 WjzuuOLLR6qTQ==
Date: Wed, 12 Feb 2025 18:39:06 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
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
Subject: Re: [PATCH v4 05/14] kexec: Add Kexec HandOver (KHO) generation
 helpers
Message-ID: <Z6zOqtaLQwnIWl2E@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-6-rppt@kernel.org>
 <20250210202220.GC3765641@nvidia.com>
 <CA+CK2bBBX+HgD0HLj-AyTScM59F2wXq11BEPgejPMHoEwqj+_Q@mail.gmail.com>
 <20250211124943.GC3754072@nvidia.com>
 <CA+CK2bAEnaPUJmd3LxFwCRa9xWrSJ478c4xisvD4pwvNMiTCgA@mail.gmail.com>
 <20250211163720.GH3754072@nvidia.com>
 <20250212152336.GA3848889@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212152336.GA3848889@nvidia.com>

Hi Jason,

On Wed, Feb 12, 2025 at 11:23:36AM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 11, 2025 at 12:37:20PM -0400, Jason Gunthorpe wrote:
> 
> > To do that you need to preserve folios as the basic primitive.
> 
> I made a small sketch of what I suggest.
> 
> I imagine the FDT schema for this would look something like this:
> 
> /dts-v1/;
> / {
>   compatible = "linux-kho,v1";
>   phys-addr-size = 64;
>   void-p-size = 64;
>   preserved-folio-map = <phys_addr>;
> 
>   // The per "driver" storage
>   instance@1 {..};
>   instance@2 {..};
> };
> 
> I think this is alot better than what is in this series. It uses much
> less memory when there are alot of allocation, it supports any order
> folios, it is efficient for 1G guestmemfd folios, and it only needs a
> few bytes in the FDT. It could preserve and restore the high order
> folio struct page folding (HVO).
> 
> The use cases I'm imagining for drivers would be pushing gigabytes of
> memory into this preservation mechanism. It needs to be scalable!
> 
> This also illustrates my point that I don't think FDT is a good
> representation to use exclusively. This in-memory structure is much
> better and faster than trying to represent the same information
> embedded directly into the FDT. I imagine this to be the general
> pattern that drivers will want to use. A few bytes in the FDT pointing
> at a scalable in-memory structure for the bulk of the data.

As I've mentioned off-list earlier, KHO in its current form is the lowest
level of abstraction for state preservation and it is by no means is
intended to provide complex drivers with all the tools necessary.

It's sole purpose is to allow preserving simple properties and ensure that
memory ranges KHO clients need to preserve won't be overwritten.

What you propose is a great optimization for memory preservation mechanism,
and additional and very useful abstraction layer on top of "basic KHO"!

But I think it will be easier to start with something *very simple* and
probably suboptimal and then extend it rather than to try to build complex
comprehensive solution from day one.

-- 
Sincerely yours,
Mike.

