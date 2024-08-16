Return-Path: <linux-kernel+bounces-289485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A67C9546A9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E67A1C21C11
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DC317C98F;
	Fri, 16 Aug 2024 10:20:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D83E17BED0
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803631; cv=none; b=JSgyRmkW7bwOBp4D0chSNasUCA196HsC/2szLoNkB4mSwKXWhRLTqbBvZgw2cvmCRJ+KQ5UoCwVBQ5lRKmuloX6g9U7jq65PUpFVZgq70RnrqRaqnAwN1iSUg8CEX6JdMtI5fLVqfb9p1NFPDDWxDxWCnysW9QjVldUWyqEI0bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803631; c=relaxed/simple;
	bh=bqnCku14slsduUKfTS2Z1RCyidEJxKbMoo5x/z7LqYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXmeJihxWGT5fSyd0PirwwM1/oZZNICuT4LBm56NLdMu1se1az/C0JjdmbMSw+WWuVyX0lZZ7iA2cc6mgC1VlvepzWD0D2hCP//AArUSQekcRfW9xtRaB0hMvVwZqx5wcvexf5+jql7mh+or/loSpW1DuWXG2fsHBqKuMOG9iy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68DBC143D;
	Fri, 16 Aug 2024 03:20:55 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 866CA3F73B;
	Fri, 16 Aug 2024 03:20:28 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:20:26 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, ilkka@os.amperecomputing.com
Subject: Re: [PATCH 4/8] perf/arm-cmn: Improve build-time assertions
Message-ID: <Zr8n6jliwJXqq7aZ@J2N7QTR9R3>
References: <cover.1723229941.git.robin.murphy@arm.com>
 <2aabebd619b65416a6cd2ca7058ca85fa3656958.1723229941.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aabebd619b65416a6cd2ca7058ca85fa3656958.1723229941.git.robin.murphy@arm.com>

On Fri, Aug 09, 2024 at 08:15:43PM +0100, Robin Murphy wrote:
> These days we can use static_assert() in the logical place rather than
> jamming a BUILD_BUG_ON() into the nearest function scope. And since it
> is now so convenient to do so, let's add an extra one to reinforce the
> dtm_idx bitmap as well.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/perf/arm-cmn.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index c9a2b21a7aec..8f7a1a6f8ab7 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -577,6 +577,9 @@ struct arm_cmn_hw_event {
>  	bool wide_sel;
>  	enum cmn_filter_select filter_sel;
>  };
> +static_assert(sizeof(struct arm_cmn_hw_event) <= offsetof(struct hw_perf_event, target));

Moving this out seems fine.

> +/* Currently XPs are the node type we can have most of; others top out at 128 */
> +static_assert(sizeof_field(struct arm_cmn_hw_event, dtm_idx) >= CMN_MAX_XPS / 4);

I reckon we can make this true by construction (as on the last patch),
and avoid the need for the assert entirely.

Mark.

>  
>  #define for_each_hw_dn(hw, dn, i) \
>  	for (i = 0, dn = hw->dn; i < hw->num_dns; i++, dn++)
> @@ -587,7 +590,6 @@ struct arm_cmn_hw_event {
>  
>  static struct arm_cmn_hw_event *to_cmn_hw(struct perf_event *event)
>  {
> -	BUILD_BUG_ON(sizeof(struct arm_cmn_hw_event) > offsetof(struct hw_perf_event, target));
>  	return (struct arm_cmn_hw_event *)&event->hw;
>  }
>  
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

