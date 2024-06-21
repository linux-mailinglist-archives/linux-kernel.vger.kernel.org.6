Return-Path: <linux-kernel+bounces-225155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 304CC912CD1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5637B2811B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2BF16A941;
	Fri, 21 Jun 2024 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZwcYW0v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953CB15FD1B;
	Fri, 21 Jun 2024 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718992699; cv=none; b=KBmkh8JPqZ9Aak1UgMRKv/oKYjcZp/hT9THMHz5P8iRwoKOVuzwpeI/bWvb+Y1SQMa3ic/pbo9cyzbe+9J58qK5lA8CwCA49JNdxbqYBp7hIuGYZzodX4jc8q5TVx0hsI7cusaDQGqAkJqRg35/8/qT/8Rys2kiwsCxZrWC4q0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718992699; c=relaxed/simple;
	bh=FHCBOkmJKRXejruoqMXNQNRLqnkS19ln5GOhpLntUOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X91ZLCrrH170XQi30utFbYylLdlY+FgAl8JFo8vQ21YxBWePQBtBxFFe8Lxx9/oQmEqKLi2TLQEUtFQl4dgnVmdUUFlPlJDP5x4PbOjJAdeSHVQdNnxqHj+HyG4FlewKIXrrbC3uv81VG/7VBQEkZVmuV7RY5teBqzjw93Wy1B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZwcYW0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F035C4AF07;
	Fri, 21 Jun 2024 17:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718992699;
	bh=FHCBOkmJKRXejruoqMXNQNRLqnkS19ln5GOhpLntUOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZwcYW0vdtdGiwivQzAapn+QuTm1F5qT9YogaDVOkQPvAOHFGHo/TD1yXTOIhQxED
	 9slb9Mq0ZwpuYHMLk/F/tEMI8Sl9UiAmZZRzjP4RRj7476xWi6bLJKx1uBwAD/apxj
	 pna10eP8Wl4mSDvfqLOZPl422ANzIrBJmCp/erieV9zDcSQeQmrogL6QAMO+oqfvqe
	 0C6DMu84ZP9VHVWuQEVZW6dZlQ1l41Va3CMSUZJhdFvPgP3HwOblS+0OdZVGC9K3Ev
	 36qeFf3WbMJO5kfvyK4NOp/Xr8BH5qVnqMNyP6GQORj+XR/iVWpU3G8s11oGcQHdKr
	 bPWgAeak4uyBQ==
Date: Fri, 21 Jun 2024 10:58:16 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/6] RISC-V: Detect unaligned vector accesses
 supported.
Message-ID: <20240621175816.GD2081@sol.localdomain>
References: <20240613191616.2101821-1-jesse@rivosinc.com>
 <20240613191616.2101821-5-jesse@rivosinc.com>
 <ZnDmRK0ZtKzmWN5S@ghost>
 <ZnDsdzv4o/Xz9kWm@ghost>
 <e6f7a061-50f0-4a6a-a09b-468502703c20@rivosinc.com>
 <ZnSptpobfqjik3RM@ghost>
 <20240621-reveler-underfed-37600a9f16d5@wendy>
 <ZnW130PqW56CnZT8@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnW130PqW56CnZT8@ghost>

On Fri, Jun 21, 2024 at 10:18:23AM -0700, Charlie Jenkins wrote:
> > Additionally, what are we doing in the kernel if we detect that
> > misaligned stuff isn't supported? Are we going to mandate that kernel
> > code is aligned only, disable in-kernel vector or some other mechanism
> > to make sure that things like crypto code don't have/introduce code
> > that'll not run on these systems?
> 
> UNSUPPORTED will still be set by the quick probe so it would be possible
> for the kernel/userspace to avoid running misaligned vector when it's
> unsupported. Any kernel methods would probably want to always run
> aligned vector unless misaligned support was determined to be FAST
> anyway, I am doubtful that code will have different optimizations for
> FAST, SLOW, and UNSUPPORTED but it is possible. 
> 
> I would prefer consistency between scalar and vector misaligned support,
> but this is not a deal breaker for this patch. I am not convinced it is
> the best choice, but I am okay with leaving this option in the kernel.
> 

Note that most of the vector crypto code (in arch/riscv/crypto/) assumes that
vector misaligned accesses are supported.  Many of the RISC-V vector crypto
instructions require using SEW=32 or SEW=64, and as a result, loads and stores
of data can be misaligned unless the code changes the SEW to 8 and back again,
which would be inefficient and add extra complexity.  I don't anticipate
workarounds for CPUs that couldn't be bothered to support misaligned accesses
being added.  So what we'll probably have to do is just disable the vector
crypto algorithms if the CPU doesn't support misaligned accesses...

- Eric

