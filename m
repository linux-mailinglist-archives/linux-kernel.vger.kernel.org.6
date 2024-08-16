Return-Path: <linux-kernel+bounces-289499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FDC9546C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C84F1C21D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC3718FDC0;
	Fri, 16 Aug 2024 10:29:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1953158DC8
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723804157; cv=none; b=DO1jxHcMTuJLLd6n09grmBDgd/oROy1V5ciQCoyLEC/scJKhwzcMM/TMefiOo57wSMKTkqEST2aWhjV1xV1hwKXDlac27dgDkiqAbhqxkywqLSgEvW0Pi+wDhA+K4DP7WnXFz8LsSN58w3Sd2lbC+Z9ofH+MdXR9oscHN+Vz/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723804157; c=relaxed/simple;
	bh=K8dqxeXKA29tN29ULaYL+8szjBEw8jk+eOv9t8Uh5ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4fR/Bv6zBHtlFQ+W18tbciGN+Gn3XqL74Pd1hQK0hy/8AgrfTz+ZFSMf8ihjD7yf9pY5fnJewPw8MUPlghuMJev2pSDF/4MlAj2Jk6muJC1MWikjZ8ttIj+orXD94ZFbsjxRPmb156RQOUVLuCZR//ufQErF38f4X8E61I4mKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18E7C143D;
	Fri, 16 Aug 2024 03:29:41 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 154F53F73B;
	Fri, 16 Aug 2024 03:29:13 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:29:11 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, ilkka@os.amperecomputing.com
Subject: Re: [PATCH 6/8] perf/arm-cmn: Refactor DTC PMU register access
Message-ID: <Zr8p96jwMHepFeq7@J2N7QTR9R3>
References: <cover.1723229941.git.robin.murphy@arm.com>
 <e1aac7d482e6f4a75819edcde1fd3198099a658c.1723229941.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1aac7d482e6f4a75819edcde1fd3198099a658c.1723229941.git.robin.murphy@arm.com>

On Fri, Aug 09, 2024 at 08:15:45PM +0100, Robin Murphy wrote:
> Annoyingly, we're soon going to have to cope with PMU registers moving
> about. This will mostly be straightforward, except for the hard-coding
> of CMN_PMU_OFFSET for the DTC PMU registers. As a first step, refactor
> those accessors to allow for encapsulating a variable offset without
> making a big mess all over.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/perf/arm-cmn.c | 64 ++++++++++++++++++++++++------------------
>  1 file changed, 36 insertions(+), 28 deletions(-)

Aside from a minoe comment below this looks fine to me.

>  struct arm_cmn_dtc {
>  	void __iomem *base;
> +	void __iomem *pmu_base;
>  	int irq;
> -	int irq_friend;
> +	s8 irq_friend;

Unrelated change?

AFAICT there's no reason for 'irq_friend' to change from 'int' to 's8',
and nothing in the commit message explains it.

Otherwise this all looks fine to me.

Mark.

