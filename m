Return-Path: <linux-kernel+bounces-293632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C180958232
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC38F1F2157E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5469918C004;
	Tue, 20 Aug 2024 09:27:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DE018B493
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146073; cv=none; b=BU5To+4Vi2dqrFrwUPC0sGsW7J8zcSEx5t4Ez+FYihUq6isMhuK5T2yAtBDooqBCfufdsgs6tbsLcd/RJSSKqtsM5zOoOng9+azCl+X5zZf9Q1dZjmZ5wEqUaQegNDAoXESAGzsFywybLNhoXoCD0tRXorHxURmCRzhF7f4lcLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146073; c=relaxed/simple;
	bh=bwJU2U5b9R+mDM0VP1Xsu2MihbQDPE/Bf125+n+DSYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqBac7wxWO0R6LyVNEI5k6bOecye+DDQmz2IZW03mJLXcBuPDI+ulFTmiOEgdielhUsj63KY6G8DTD9Z19C3TMk7KgsByu99/u0AWUverLwVgm422k+hYW9HRbEc34J1PZCWIYlcfRq8siv+S4lvdVX5DripUBgIGq0300tgVro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08BBADA7;
	Tue, 20 Aug 2024 02:28:18 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E745B3F66E;
	Tue, 20 Aug 2024 02:27:50 -0700 (PDT)
Date: Tue, 20 Aug 2024 10:27:48 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, ilkka@os.amperecomputing.com
Subject: Re: [PATCH 3/8] perf/arm-cmn: Ensure dtm_idx is big enough
Message-ID: <ZsRhlInugQJiDb_R@J2N7QTR9R3>
References: <cover.1723229941.git.robin.murphy@arm.com>
 <aa9d45b10814dc6b2c59dfb2c1be49f333dae1dc.1723229941.git.robin.murphy@arm.com>
 <Zr8ma7pt7te0qxNG@J2N7QTR9R3>
 <22b69400-af16-4e78-8f72-c10564d7cc6c@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22b69400-af16-4e78-8f72-c10564d7cc6c@arm.com>

On Mon, Aug 19, 2024 at 04:00:06PM +0100, Robin Murphy wrote:
> On 16/08/2024 11:14 am, Mark Rutland wrote:
> > On Fri, Aug 09, 2024 at 08:15:42PM +0100, Robin Murphy wrote:
> > > While CMN_MAX_DIMENSION was bumped to 12 for CMN-650, that only supports
> > > up to a 10x10 mesh, so bumping dtm_idx to 256 bits at the time worked
> > > out OK in practice. However CMN-700 did finally support up to 144 XPs,
> > > and thus needs a worst-case 288 bits of dtm_idx for an aggregated XP
> > > event on a maxed-out config. Oops.
> > > 
> > > Fixes: 23760a014417 ("perf/arm-cmn: Add CMN-700 support")
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > >   drivers/perf/arm-cmn.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> > > index 0e2e12e2f4fb..c9a2b21a7aec 100644
> > > --- a/drivers/perf/arm-cmn.c
> > > +++ b/drivers/perf/arm-cmn.c
> > > @@ -563,7 +563,7 @@ static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id) {}
> > >   struct arm_cmn_hw_event {
> > >   	struct arm_cmn_node *dn;
> > > -	u64 dtm_idx[4];
> > > +	u64 dtm_idx[5];
> > 
> > Can't we size this based on CMN_MAX_DIMENSION (or CMN_MAX_XPS or
> > CMN_MAX_DTMS), to make that clear?
> 
> Fair enough, I did go back and forth a little on that idea, but reached the
> opposite conclusion that documenting this with the assert to deliberately
> make it *not* look straightforward was nicer than wrestling with an accurate
> name for the logical quantity here, which strictly would be something like
> CMN_MAX_NODES_PER_TYPE_WE_CARE_ABOUT (there can already be up to 256 RN-Fs,
> but those aren't visible to the PMU).
> 
> I'll have another think on that approach - I do concur that the assert isn't
> *functionally* any better than automatically sizing the array.

FWIW, I'm happy with the value being an over-estimate, and with needing
a comment. What I'm really after is that the sizing of dtm_idx is clear
at the definition of dtm_idx, without an arbitrary-looking number.

Mark.

