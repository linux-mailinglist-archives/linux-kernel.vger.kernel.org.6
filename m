Return-Path: <linux-kernel+bounces-338317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD49985658
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6AC1F21784
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5684A15C12F;
	Wed, 25 Sep 2024 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e68pSZL2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8569E15B972
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727256555; cv=none; b=OIkh+UulEwPipQ+DpkAsF93KiEjy4TuOzhLpPrgVOrv5aLBo3gzyegh2a9UMvC4UZcJhfn2Ga31irIzzSm0H0pmI+5oOUqqVKTkMW13ZBHikHFVo971B4o1aXtFbKrd7Gg5i0kz11rMr33qyUOOnm8ja61gwcOGg9MMh+Lw1mWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727256555; c=relaxed/simple;
	bh=eMhbrFVorCUcB+bdzryCwpTOvnjXWyhp4ukLuhEbuEA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dovYwNk69d8EIzHv4f5aaduoeH3OKwj4TKR8C9dkS6KfF/7EySW3aL1J3/6ZZx0Ukdvx9QXVByPv+uavpzhZWyCO5i4ByGJRH4WufEG5IEuRfcLBrWPlD+yzflXP18M4D3BgPeDayFF3/zFyVCEXZ815nY4epr2WI2frInvqGk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=e68pSZL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED7FC4CEC3;
	Wed, 25 Sep 2024 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727256555;
	bh=eMhbrFVorCUcB+bdzryCwpTOvnjXWyhp4ukLuhEbuEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e68pSZL2oz+VPNyWp2fvN5Xn47uaRol62aicXRCKBSPGNcHxfd42hB8So0AjowS/2
	 xTHNnCqHsZ3H9aVXXt/VWoIICM2PzhW2hTZDjXUJk0PSuqUJRfNq3HHjLmQETt3XdW
	 laulko/THHBPi+f8LM87Np1qq8we87lYaLQ3wew8=
Date: Wed, 25 Sep 2024 02:29:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: liuye <liuye@kylinos.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: Fix hard LOCKUP in function
 isolate_lru_folios
Message-Id: <20240925022914.7c4033c9bb1206ad149ba69e@linux-foundation.org>
In-Reply-To: <565bae19-889e-57df-42ff-70728cfb818c@kylinos.cn>
References: <20240814091825.27262-1-liuye@kylinos.cn>
	<20240924172205.5068e86430873b09b75f8538@linux-foundation.org>
	<565bae19-889e-57df-42ff-70728cfb818c@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 25 Sep 2024 16:37:14 +0800 liuye <liuye@kylinos.cn> wrote:

> 
> 
> On 2024/9/25 上午8:22, Andrew Morton wrote:
> > On Wed, 14 Aug 2024 17:18:25 +0800 liuye <liuye@kylinos.cn> wrote:
> > 
> >> @@ -1669,10 +1670,12 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
> >>  		nr_pages = folio_nr_pages(folio);
> >>  		total_scan += nr_pages;
> >>  
> >> -		if (folio_zonenum(folio) > sc->reclaim_idx ||
> >> -				skip_cma(folio, sc)) {
> >> +		/* Using max_nr_skipped to prevent hard LOCKUP*/
> >> +		if ((max_nr_skipped < SWAP_CLUSTER_MAX_SKIPPED) &&
> >> +			(folio_zonenum(folio) > sc->reclaim_idx || skip_cma(folio, sc))) {
> >>  			nr_skipped[folio_zonenum(folio)] += nr_pages;
> >>  			move_to = &folios_skipped;
> >> +			max_nr_skipped++;
> >>  			goto move;
> > 
> > This hunk is not applicable to current mainline.
> > 
> 
> Please see the PATCH v2 in link [1], and the related discussion in link [2].
> Then please explain why it is not applicable,thank you.

What I mean is that the patch doesn't apply.

Current mainline has

		if (folio_zonenum(folio) > sc->reclaim_idx) {
			nr_skipped[folio_zonenum(folio)] += nr_pages;
			move_to = &folios_skipped;
			goto move;
		}


