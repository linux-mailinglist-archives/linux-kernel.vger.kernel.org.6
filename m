Return-Path: <linux-kernel+bounces-517731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B32A384C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8697D166EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2563D21C9FE;
	Mon, 17 Feb 2025 13:36:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D0D21A44D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799377; cv=none; b=FQOSfqH/SIQ0aEIksY6GrjVhSIw8pJPiBt3GT0RbHMhCKUhRmmDzaFS3A3CBMzZuThjc8gl3pBmUJ6YzvJoMWGepPsMcZXteux6ZHJ+THl8aZy0FaUSnYGURZ86BlR4jiP2uESZ9MJmyz1kJW1fLTcseFsbHfTGz9dBrEWMhpko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799377; c=relaxed/simple;
	bh=tz0LkNVtJUv6tJOv13c+7itHnzABgVw6BZR5ypOky/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGj9rfq7Hu4LUXe8pQRPsE6iJFF/86HnBkdTlzCgcmnxhXMw9JR9coIVyTlyW+FdwOrfteprgnH17+GkaBU1EBWP5nMX5OWktAgLMODvXd1K9TiPx3pRRiDna/LpIoVLs6EESkuhN7Jt6Kzmbv+YY2zlwYPIcZro+ct95s/tQ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C59CE13D5;
	Mon, 17 Feb 2025 05:36:33 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC9EB3F6A8;
	Mon, 17 Feb 2025 05:36:13 -0800 (PST)
Date: Mon, 17 Feb 2025 13:36:07 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Zeng Heng <zengheng4@huawei.com>
Cc: james.morse@arm.com, bobo.shaobowang@huawei.com,
	jonathan.cameron@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mpam mpam/snapshot/v6.14-rc1 3/5] arm_mpam: Provide
 conversion method for new closid/rmid pairs
Message-ID: <Z7M7R8uf4g2C68cO@e133380.arm.com>
References: <20250217031852.2014939-1-zengheng4@huawei.com>
 <20250217031852.2014939-4-zengheng4@huawei.com>
 <d7069933-903e-9e1e-d7a4-5a6a9fa53064@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7069933-903e-9e1e-d7a4-5a6a9fa53064@huawei.com>

Hi,

On Mon, Feb 17, 2025 at 02:18:44PM +0800, Zeng Heng wrote:
> Hi Martin,
> 
> On 2025/2/17 11:18, Zeng Heng wrote:
> > The MPAM driver statically assigns all reqPARTIDs to respective intPARTIDs.
> > For the new rmid allocation strategy, it will check if there is an
> > available rmid of any reqPARTID which belongs to the input closid, not just
> > the rmids belonging to the closid.
> > 
> > For a mixture of MSCs system, for MSCs that do not support narrow-partid,
> > we use the PARTIDs exceeding the number of closids as reqPARTIDs for
> > expanding the monitoring groups.
> > 
> > In order to keep the existing resctrl API interface, the rmid contains both
> > req_idx and PMG information instead of PMG only under the MPAM driver. The
> > req_idx represents the req_idx-th sub-monitoring group under the control
> > group. The new rmid would be like:
> > 
> >      rmid = (req_idx << shift | pmg).
> > 
> 
> To consider future compatibility with dynamically allocated reqpartid,
> should I refactor the rmid?
> 
> Instead of defining rmid.req_idx, we could place the entire reqpartid
> directly within rmid. In This way, the allocation of reqpartid will no
> longer be constrained by the static allocation of closid, facilitating
> future compatibility with dynamic allocation mechanisms.
> 
> In this case, it needs to refactor the resctrl_arch_rmid_idx_encode()
> and resctrl_arch_rmid_idx_decode(), and we can simplify
> closid_rmid2reqpartid() to rmid2reqpartid().
> 
> What are your thoughts on this idea? Thank you in advance for your
> reply.
> 
> Best regards,
> Zeng Heng

Does this mean that the RMID must be expanded to cover all possible
(reqPARTID, PMG) combinations?

A single reqPARTID cannot be allocated to two different resctrl control
groups at the same time, even though a PMG value can be reused across
multiple control groups -- so it sounds like your proposal would
require changes in the resctrl core code as well as possibly requiring
a larger rmid_ptrs table.

But I might have misunderstood what you are proposing here...

Can you illustrate with one or two examples?

Cheers
---Dave

