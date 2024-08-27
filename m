Return-Path: <linux-kernel+bounces-302736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 831BB9602B2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA7A1F230EF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFBC149DF4;
	Tue, 27 Aug 2024 07:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="2FQcnv+v"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3971428F3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724742481; cv=none; b=CudStbQTrqHfd7E125/wnrVjSm9IcFs7tI7mwScvM9NWRBKCly8uj+1J6/aDBd4Vl6T67DSOZ2f3DcUPP2GrZHVRfc/wpk/z5WWj5TulatgYLmojWq4InVDhk+YDQLAc9x2PuXTg3xMXC+J+dAcrOF3NgW+CixijgySXeFx0lC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724742481; c=relaxed/simple;
	bh=v3oMDBXISh7mOqH4SIKSXdEp5TdADu27D9kqCT3a+yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1rPi/zLf4vbwOu/lC7Woft65fyaA47RZPPNJtSlGZbAQhEzuUzV5DE8vehFYBbqFPqaTTE5Nm2WoibhLQvAiPYvIBEP/9mnF2mzExJcDpgGbsRSmCddZbTUuos2jf5YCLoWKmB5TiHCs7JAYxCrmV+Fygs5zP82EpYkY6biOxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=2FQcnv+v; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A85CB2842E6;
	Tue, 27 Aug 2024 09:07:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1724742478;
	bh=v3oMDBXISh7mOqH4SIKSXdEp5TdADu27D9kqCT3a+yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2FQcnv+vR+F+r2tu2zzJ/FaLSxMX8Wrtm3XL2y1wAGjMG8UTNu2seNZBkulvBY2yL
	 4xcvNjWUpk0D3fark/ti4n7SW7hc5YUtifl2pnLxWjtJuo2o/tP8i5zPLaF4iNV4H9
	 kAb9HI+g28PuA/vGNf79jYK+2CVaSEcyCK5piZUOUQ7PfBYNcp8cxorew2YYASzO9h
	 zLDG8XZ2pt3ugMpJMAAqeeJeC4g9qZs+DCY599ENEoNj6VxAzKQEtwVTStJzPyDeoc
	 IGOFASzwVoJE4Bs858UEGdketXr02agbnltPyF3IqJXJFBEpNpo9n32g9i7VEQxnB6
	 RBxcOzTwb8KVA==
Date: Tue, 27 Aug 2024 09:07:57 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect domain ID in context flush
 helper
Message-ID: <Zs17TSaW-GW7DYj4@8bytes.org>
References: <20240815124857.70038-1-baolu.lu@linux.intel.com>
 <2h2gyzr3anhcpyiorkrjp3o4cdg7sg2rmrvgzmkxopabdsr3ph@jlhq77xjtcdf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2h2gyzr3anhcpyiorkrjp3o4cdg7sg2rmrvgzmkxopabdsr3ph@jlhq77xjtcdf>

On Mon, Aug 26, 2024 at 09:15:06AM -0700, Jerry Snitselaar wrote:
> Can this go into a fixes pr for 6.11?

It is already queued for 6.11, will send the PR in the next days.

