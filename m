Return-Path: <linux-kernel+bounces-564905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCE4A65C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1E83B7D25
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8AE1DE884;
	Mon, 17 Mar 2025 18:30:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0951DD529
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742236204; cv=none; b=CNKh7sXyVG6eXhO/9OoCS+bZTKsDlosuiGEQWOXM6SiUXxBCwLt7sRDQdP7AUEzXMFnIVdQ+UuJnx+/cjfqAD7ZFMS3D+IegeWo5TMam2P4GpScLgE1RGhlg0gQVqY/VNfZ0TlLWxKAJffyDzvw5cM/PtpSODs6QLjYVzWy8kT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742236204; c=relaxed/simple;
	bh=SwbECmA+mx0FgvO55OhdvqalxHC2zQXXTODO6O+8PZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FG5N1SpQxpBaJc4Gz+pQbvlQiayl7rTGwUQW18ZtL0K/uWhDwc3G3phcbaf0Ukdye3S1l6sRosoVsP3wszxDrDxuFUsGRV4hURKcxsuuw8TIAYLGagW7thKQoDy19v60f8To7VSHkmrAAVsWAJrxoCOOSBlhbXQKflfWmP4AsD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19E7D13D5;
	Mon, 17 Mar 2025 11:30:11 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D57943F63F;
	Mon, 17 Mar 2025 11:30:01 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:29:57 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: lcherian@marvell.com, coresight@lists.linaro.org,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2/7] coresight: Convert disclaim functions to take a
 struct cs_access
Message-ID: <20250317182957.GL2487211@e132581.arm.com>
References: <20250211103945.967495-1-james.clark@linaro.org>
 <20250211103945.967495-3-james.clark@linaro.org>
 <20250313145456.GR9682@e132581.arm.com>
 <c6a86373-64be-4101-a08a-74aa302bf64c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6a86373-64be-4101-a08a-74aa302bf64c@linaro.org>

On Mon, Mar 17, 2025 at 11:36:40AM +0000, James Clark wrote:
> 
> 
> On 13/03/2025 2:54 pm, Leo Yan wrote:
> > On Tue, Feb 11, 2025 at 10:39:38AM +0000, James Clark wrote:
> > 
> > [...]
> > 
> > >   static inline bool coresight_is_claimed_any(struct coresight_device *csdev)
> > >   {
> > > -       return coresight_read_claim_tags(csdev) != 0;
> > > +       return coresight_read_claim_tags(&csdev->access) != 0;
> > >   }
> > 
> > Likewise other claim functions, can coresight_is_claimed_any() change its
> > argument type from struct coresight_device to struct csdev_access?
> 
> I only wanted to change the ones that I had to. I think we should prioritize
> passing csdev as much as possible in the coresight framework to make
> everything consistent. Otherwise it's extra churn for no benefit, and if we
> need something from csdev here in the future we'll have to change this one
> back again.

The function coresight_is_claimed_any() has been deleted in a later
patch.  So this is fine for me.

In theory, claim tags are low level operations and don't need a
CoreSight device context, I prefer we can keep them as simple as
possible.

With this series, we can see coresight_claim_device() and
coresight_disclaim_device() are inconsistent for their parameters:
one is using "struct coresight_device *" and another is
"struct csdev_access *".  Maybe we just proceed to use csdev_access
for all claim tag functions?

If later we need to use a CoreSight device context when operating
claim tags, it means we might have different scenarios and we can
handle that separately.

Thanks,
Leo

