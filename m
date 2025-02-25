Return-Path: <linux-kernel+bounces-530665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB48A4365E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7EE17A7B29
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515A425A2DB;
	Tue, 25 Feb 2025 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfehpgzA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74AD1A5B89;
	Tue, 25 Feb 2025 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469685; cv=none; b=R8uQGVieeW55HuZfrlA1zpLu/IrMOsR+zAjYax1OD2GmGnRjwZCA6DYNZBJsWbnPHsr5PWSf4F/a/UfpVoWrSQrZ2hAZndxY079sKn1RmYlYe25jX/DoWP+iQLy3dFzgxMEKdfZk7Ct8xySyEC0ZynSerOlWXUqrV1mHuLBXsiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469685; c=relaxed/simple;
	bh=eClZUkFpGoFoPisFcTGx3FOMVVxAN549qNzYuXDaN6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFgCpRWjl9/HQBhyozIjLGjV2MDBt0iXd5Ej55O81TGvaCA90auUc5jP/885D3JA6QHGkZHwdByLSpDdygaeuj53PVcHsL3zFNt72Zbv0zjQTTaOuT6UOb+Bd30IYZERqwWjTUEghSaYrEJnN2P81tOc2tKj2ID70+TDrNC1AVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfehpgzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7196C4CEDD;
	Tue, 25 Feb 2025 07:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740469685;
	bh=eClZUkFpGoFoPisFcTGx3FOMVVxAN549qNzYuXDaN6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MfehpgzAULJOLOZKi9leXW7NoihGeIwZGfgqqDeu5KiV1mGWrDwPVnYfTRgxdvz/x
	 eUEiMbxM3XxYo/gmkSSg4xx8xTFkRQppUlh3HUxKONPfFFg/CDnfnacUmmTxgJ/Nl0
	 p03c6jGvE33coM+dHriSIwpAGcEALD6rf9GR0yiK3xOwkPBH/7Aw7fEccJA5pPsujz
	 ioZNQPMfXKd7AoR2Kqkh+jT67yt7GirH7eFeS9NW11qqcNBhAVIKkRdeHuNLA4FcsI
	 VWFcsDgf2SamOyzaQaxOBPvKzWILeKBO0pYTSGt//hRXbLnUc8avjE5frZYFP0WbVU
	 ypiGxCjITbKtg==
Date: Tue, 25 Feb 2025 09:47:44 +0200
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
Subject: Re: [PATCH v4 03/14] memblock: Add support for scratch memory
Message-ID: <Z711oEMpogAHohs8@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-4-rppt@kernel.org>
 <20250224025034.g4htzqgm3r3ja4yy@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224025034.g4htzqgm3r3ja4yy@master>

On Mon, Feb 24, 2025 at 02:50:34AM +0000, Wei Yang wrote:
> On Thu, Feb 06, 2025 at 03:27:43PM +0200, Mike Rapoport wrote:
> >From: Alexander Graf <graf@amazon.com>
> >
> >With KHO (Kexec HandOver), we need a way to ensure that the new kernel
> >does not allocate memory on top of any memory regions that the previous
> >kernel was handing over. But to know where those are, we need to include
> >them in the memblock.reserved array which may not be big enough to hold
> >all ranges that need to be persisted across kexec. To resize the array,
> >we need to allocate memory. That brings us into a catch 22 situation.
> >
> >The solution to that is limit memblock allocations to the scratch regions:
> >safe regions to operate in the case when there is memory that should remain
> >intact across kexec.
> >
> >KHO provides several "scratch regions" as part of its metadata. These
> >scratch regions are contiguous memory blocks that known not to contain any
> >memory that should be persisted across kexec. These regions should be large
> >enough to accommodate all memblock allocations done by the kexeced kernel.
> >
> >We introduce a new memblock_set_scratch_only() function that allows KHO to
> 
> memblock_set_kho_scratch_only?
> 
> >indicate that any memblock allocation must happen from the scratch regions.
> >
> >Later, we may want to perform another KHO kexec. For that, we reuse the
> >same scratch regions. To ensure that no eventually handed over data gets
> >allocated inside a scratch region, we flip the semantics of the scratch
> >region with memblock_clear_scratch_only(): After that call, no allocations
> 
> memblock_clear_kho_scratch_only?

Right, I missed those in the commit message.
 
> >may happen from scratch memblock regions. We will lift that restriction
> >in the next patch.
> >
> 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.

