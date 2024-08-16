Return-Path: <linux-kernel+bounces-289472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCC8954691
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49DD1F21BCD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCEB172BD3;
	Fri, 16 Aug 2024 10:14:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D169B170A2D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803249; cv=none; b=Sy9ZjYCicH2ZM/bHyRFwVqrtWGduAqDpg0G3SPSWJ8ymrDZbyYqThbwZK38VxDCBLfUBTrVRol/g3WbjkcG4aMD98FCCAIT6k2EG/6UYAO2A6KHzQhqEfscfZsKFtooQASw43UBlRkBUbN3J+sFr3jz53r1vMOQ+3LM9w9pRn6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803249; c=relaxed/simple;
	bh=tx/dcmsU+tFgdO7XfR9YBzsxiTLSPpsz3toUIowCo44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCXaH0HpIx9SEH/xk7GPU/y9blomHFwI38f22ftHvuKI+acAC78a0DwZVfSyrwHqhiagER3sGa+p87jlO9dPMxeKk+W4575/Ht/9N356Y4XjYE5SUS5rVDh/76/DLQ6RDRqPddCsuAHbeLDgHXBTzcUVe6yYfhcTe6nQsIB0gHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EEF6143D;
	Fri, 16 Aug 2024 03:14:33 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C6333F73B;
	Fri, 16 Aug 2024 03:14:05 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:14:03 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, ilkka@os.amperecomputing.com
Subject: Re: [PATCH 3/8] perf/arm-cmn: Ensure dtm_idx is big enough
Message-ID: <Zr8ma7pt7te0qxNG@J2N7QTR9R3>
References: <cover.1723229941.git.robin.murphy@arm.com>
 <aa9d45b10814dc6b2c59dfb2c1be49f333dae1dc.1723229941.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa9d45b10814dc6b2c59dfb2c1be49f333dae1dc.1723229941.git.robin.murphy@arm.com>

On Fri, Aug 09, 2024 at 08:15:42PM +0100, Robin Murphy wrote:
> While CMN_MAX_DIMENSION was bumped to 12 for CMN-650, that only supports
> up to a 10x10 mesh, so bumping dtm_idx to 256 bits at the time worked
> out OK in practice. However CMN-700 did finally support up to 144 XPs,
> and thus needs a worst-case 288 bits of dtm_idx for an aggregated XP
> event on a maxed-out config. Oops.
> 
> Fixes: 23760a014417 ("perf/arm-cmn: Add CMN-700 support")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/perf/arm-cmn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 0e2e12e2f4fb..c9a2b21a7aec 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -563,7 +563,7 @@ static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id) {}
>  
>  struct arm_cmn_hw_event {
>  	struct arm_cmn_node *dn;
> -	u64 dtm_idx[4];
> +	u64 dtm_idx[5];

Can't we size this based on CMN_MAX_DIMENSION (or CMN_MAX_XPS or
CMN_MAX_DTMS), to make that clear?

From the desciription in the commit message it sounds like you need 2 *
CMN_MAX_XPS bits, i.e.

	#define DTM_IDX_BITS	(2 * CMN_MAX_XPS)

	u64 dtm_idx[DIV_ROUND_UP(DTM_IDX_BITS, 64)];

Mark.

>  	s8 dtc_idx[CMN_MAX_DTCS];
>  	u8 num_dns;
>  	u8 dtm_offset;
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

