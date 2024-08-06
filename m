Return-Path: <linux-kernel+bounces-276586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9609C9495A3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2459A280208
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FCE3D966;
	Tue,  6 Aug 2024 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFbtzxU/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145BE2CCB4
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722962106; cv=none; b=hprAu1qKIHpir3Bpm4Mk4urEFbc/4q//HfPYaZ+94p+p0b07KBHIKLNWt/62ZbhhYvRMuqMltNiw14WzkKzEcBdonaGe56+twZzyb1GnwBwF9pL/nc6Gx4IY4HYmdpCAjdvM++Zb3FxmldSHcUXWpU9CwuPHHjQrP2OwMzbgoVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722962106; c=relaxed/simple;
	bh=uQqSa2ju/OwNtv4V5r1lb+pBWDYjfdDGks/rRhWKkQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pj95GeTdh9HSkuc7LM7hAOfuokZtJ67oBGfrZWiiI0j8J30wdLFPFzLkUbkalXp6eJee7pu98qU7numD1PFFkTtgCLSdYI3T0Ol+Fy00l8EQdgRFdIwVhUM2fZqd6cbHI1I2aR6Ej9C3krsnMOfZzkB9BxMZX+8r4YXmbSJLzks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFbtzxU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09AAC32786;
	Tue,  6 Aug 2024 16:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722962105;
	bh=uQqSa2ju/OwNtv4V5r1lb+pBWDYjfdDGks/rRhWKkQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rFbtzxU/9vfJ1XsILpQQPsivG1Pyogx2CI6NstcraYijdi2mzSCTxW4WvVPUs08Ko
	 6z0T8GGW5fCwuNikTj97SLFnGlJu3JkkfFsXiXnyII7JsnfqT1RxUwAQgkWX9v/zhS
	 4lGBViEWOHfWrzNRBp/GU5zVFKovj0T5LsBLwbtM/S0raRISU/kgybv+XkL39qeII1
	 vUpfdm2a4Z1/px0JCHRgBvGxTHDKC3dP8BFcfDo8iWier3zg/ajS+ejh6Oz+MzSPUt
	 yXkh0sFiqQ3wf+mN4LIb2snalsqq3hDlVCEbir0xKdtHa95lfwG+CoGXv8lXzKI+TU
	 4EntyrvOy7bkQ==
Date: Tue, 6 Aug 2024 18:34:58 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com,
	sunilvl@ventanamicro.com, xiaobo55x@gmail.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/2] arm64: ACPI: NUMA: initialize all values of
 acpi_early_node_map to NUMA_NO_NODE
Message-ID: <ZrJQsuOguTkbpMI2@lpieralisi>
References: <0d362a8ae50558b95685da4c821b2ae9e8cf78be.1722828421.git.haibo1.xu@intel.com>
 <853d7f74aa243f6f5999e203246f0d1ae92d2b61.1722828421.git.haibo1.xu@intel.com>
 <ZrDt_isszRHkFuLu@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrDt_isszRHkFuLu@arm.com>

On Mon, Aug 05, 2024 at 04:21:34PM +0100, Catalin Marinas wrote:
> On Mon, Aug 05, 2024 at 11:30:24AM +0800, Haibo Xu wrote:
> > Currently, only acpi_early_node_map[0] was initialized to NUMA_NO_NODE.
> > To ensure all the values were properly initialized, switch to initialize
> > all of them to NUMA_NO_NODE.
> > 
> > Fixes: e18962491696 ("arm64: numa: rework ACPI NUMA initialization")
> > Reported-by: Andrew Jones <ajones@ventanamicro.com>
> > Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/arm64/kernel/acpi_numa.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> > index 0c036a9a3c33..2465f291c7e1 100644
> > --- a/arch/arm64/kernel/acpi_numa.c
> > +++ b/arch/arm64/kernel/acpi_numa.c
> > @@ -27,7 +27,7 @@
> >  
> >  #include <asm/numa.h>
> >  
> > -static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
> > +static int acpi_early_node_map[NR_CPUS] __initdata = { [0 ... NR_CPUS - 1] = NUMA_NO_NODE };

Bah, silly me, sorry.

> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> The patch makes sense but is there any issue currently without it?

I suspect there might be - a cpu associated with NUMA node 0 when it is
actually unspecified in ACPI tables (well, probably not even a real
world bug - I don't know, that's why it was not caught earlier I
believe) but still.

> Trying to assess whether it needs a stable backport.

Whether that's a real bug or not depends on deployed ACPI firmware
tables; if all cores have a proximity domain assigned in the
respective SRAT entries this patch is irrelevant but
technically it is a bug to fix, yes.

Backporting would make sense, it should be innocuous.

Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

