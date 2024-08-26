Return-Path: <linux-kernel+bounces-302396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C82195FDC1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 01:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90545B21AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F207A19B3ED;
	Mon, 26 Aug 2024 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nz4aLsgm"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F813DB90
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 23:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724714644; cv=none; b=tnqQ27j5VhE0RQOWN+gZud+Qgy7Ehi7MysviHZq5TRpPYQVuGaxCCJlk+ILw1NSTR+4gwuKzLs1g/bp15Ev1JXsbUXfcGB7GmvNGDVigasQw0iPKfrVx0wFS6ntEyRbCBWL7CGDnufMETUIkB3Z/qayVduuzJZpy94xAuhvWKa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724714644; c=relaxed/simple;
	bh=IrnZKj7bKoT/emq2wfML03dDliUODz1gsmIyDXuGV/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8XVQ2ISe0lbEBb0AVj/0Bd59GgaswCW85Zh+Z/Be6JH2fL+UHhD4eRzhri3M0TbSJuE4LsDzCALsOBlajhbXTHTOBHPSKxKBC8bl9CHMfDwoTFMuY7+KlnYxZMCvNyw4bHm+6fadr7xRL8tGS+A84u/kHmYPg+a9MjxIivYY74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nz4aLsgm; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Aug 2024 16:23:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724714640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s6utSXoLOnJ8vChXECY5Wtvo0Ej0aSPRXGraJkv73B4=;
	b=Nz4aLsgm4Wwd8OIFVJufwbtRddwG4VougUS3TM5wDlT4zuSZ6etoSRIDEfzwYEIqBSOrGs
	7bBjIQG+qNWOVBR/lfCnZ9sP8PDG8eA3s0ftFT/pJFDUU/RZxeKvqQNimZW3QRjHwOlvc/
	JmIqf1rvsTxVC5chgoidyVgMylPRWaY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: D Scott Phillips <scott@os.amperecomputing.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Rob Herring <robh@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	linux-kernel@vger.kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH] arm64: errata: Enable the AC03_CPU_38 workaround for
 ampere1a
Message-ID: <Zs0OelXKn_-6jtqN@linux.dev>
References: <20240826215933.1263453-1-scott@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826215933.1263453-1-scott@os.amperecomputing.com>
X-Migadu-Flow: FLOW_OUT

Hi D Scott,

On Mon, Aug 26, 2024 at 02:59:33PM -0700, D Scott Phillips wrote:
> The ampere1a cpu is affected by erratum AC04_CPU_10 which is the same
> bug as AC03_CPU38. Add ampere1a to the AC03_CPU_38 workaround midr list.
> 
> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
> ---
>  Documentation/arch/arm64/silicon-errata.rst | 2 ++
>  arch/arm64/Kconfig                          | 2 +-
>  arch/arm64/include/asm/cputype.h            | 2 ++
>  arch/arm64/kernel/cpu_errata.c              | 1 +
>  4 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
> index 50327c05be8d1..39c52385f11fb 100644
> --- a/Documentation/arch/arm64/silicon-errata.rst
> +++ b/Documentation/arch/arm64/silicon-errata.rst
> @@ -55,6 +55,8 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | Ampere         | AmpereOne       | AC03_CPU_38     | AMPERE_ERRATUM_AC03_CPU_38  |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| Ampere         | AmpereOne AC04  | AC04_CPU_10     | AMPERE_ERRATUM_AC03_CPU_38  |
> ++----------------+-----------------+-----------------+-----------------------------+

We tend to stick the marketing term for a part in the second column so
it is more recognizable for the user. Is this a placeholder for something
different from "ampere1a"?

> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index f6b6b45073571..748aa536446ae 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -773,6 +773,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  		.desc = "AmpereOne erratum AC03_CPU_38",
>  		.capability = ARM64_WORKAROUND_AMPERE_AC03_CPU_38,
>  		ERRATA_MIDR_ALL_VERSIONS(MIDR_AMPERE1),
> +		ERRATA_MIDR_ALL_VERSIONS(MIDR_AMPERE1A),

This will break the workaround on AC03, since the second macro reassigns
::midr_range.

You'll want to use ERRATA_MIDR_RANGE_LIST() instead w/ an array of
affected MIDRs.

-- 
Thanks,
Oliver

