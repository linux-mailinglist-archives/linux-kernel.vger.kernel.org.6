Return-Path: <linux-kernel+bounces-520997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6489A3B270
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BF8188AEE6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8794A1C1F13;
	Wed, 19 Feb 2025 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA71nhcL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBBE17A307;
	Wed, 19 Feb 2025 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950372; cv=none; b=eaNgB89r4S+bcN5i6xMDkPXrBam/F9zs01Sm03lG5SMB2ymGgifJLCwtkPrgzy8uyuSF0RKra1JojnqA2nEDFS56W8SIwq1fKpcqjGVtb+SVrgtUCbAuGKdvywl4zzoKOgvqBZyggH+nGaA1qpRZkWXpc3RZA7iQecNlyvcf4KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950372; c=relaxed/simple;
	bh=IU+pHUXldmRuJqluDgSiOT9EDGFnrS7y3gSj3xCGbVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gE9DRKUH9EoTFMmt3i4S1vkJoinby0DJcKKOzjztUIYF2p08h3Hmr42JAdJR/exQflXrJSkK2yQ1dGyagyLeAn6VBp3/bBDHcAwstg5m5RtqCLlrNahdndreABU0WdDDvMBkJrrk5bLwDvCXCKfHc7cYnZ3tyQKWaaR+ajexXvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA71nhcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F07C4CED1;
	Wed, 19 Feb 2025 07:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739950371;
	bh=IU+pHUXldmRuJqluDgSiOT9EDGFnrS7y3gSj3xCGbVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bA71nhcLnBv4vVc6bzgMzt4pcW92PdxJcYfbTt8KMC68oKcFO7FfjZsO6EXrZWchl
	 Nmf7yFEHV+k3l6FR4r5n/w9/dOE/MgAfqavsjDv3Gxl6m2kgk0td6LefolW/tdq4vk
	 IQGJ71D7cCbtmVBKFWdpdylHgF1T4KHDqMxX/3ifie06MKaZHrdtFXOMHJVsfhd2gu
	 4P4M5HUSM3yduXdDxCu6tEG4DMvehgF39yoJqdbeJUI5cTCWgLsXZpSwZcWgYKkLNm
	 FTFZnXtSVFsFSCIsXBBp5pAB1gXIC0M5l2+gRyX7OFT9Mo9AFvCtwqfqTYSiu7XvFT
	 Ds0vM/Iq+dYLA==
Date: Wed, 19 Feb 2025 09:32:31 +0200
From: Mike Rapoport <rppt@kernel.org>
To: RuiRui Yang <ruyang@redhat.com>
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
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
Message-ID: <Z7WJD6eBLuIRnLwk@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <CALu+AoRMQyRDFS_4L0KQkmrFT_S+yk=uZ-Mqt86JQYKKnj-5Ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALu+AoRMQyRDFS_4L0KQkmrFT_S+yk=uZ-Mqt86JQYKKnj-5Ug@mail.gmail.com>

On Mon, Feb 17, 2025 at 11:19:45AM +0800, RuiRui Yang wrote:
> On Thu, 6 Feb 2025 at 21:34, Mike Rapoport <rppt@kernel.org> wrote:
> > == Limitations ==
> >
> > Currently KHO is only implemented for file based kexec. The kernel
> > interfaces in the patch set are already in place to support user space
> > kexec as well, but it is still not implemented it yet inside kexec tools.
> >
> 
> What architecture exactly does this KHO work fine?   Device Tree
> should be ok on arm*, x86 and power*, but how about s390?

KHO does not use device tree as the boot protocol, it uses FDT as a data
structure and adds architecture specific bits to the boot structures to
point to that data, very similar to how IMA_KEXEC works.

Currently KHO is implemented on arm64 and x86, but there is no fundamental
reason why it wouldn't work on any architecture that supports kexec.
 
> Thanks
> Dae
> 

-- 
Sincerely yours,
Mike.

