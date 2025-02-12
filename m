Return-Path: <linux-kernel+bounces-511441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44AAA32B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433981888C95
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2306121129F;
	Wed, 12 Feb 2025 16:04:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323B21B21AD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376288; cv=none; b=rl0TIXHMxkYvlK0yDjkJyKe8R7qcfD/cYJFRQTcdmMo6vbXejstmDm6C50lvVJM1nRdo6I+D+vSz/tnIt78m07ZQCNsOulWP6RyRj6+r6DKKIL/GDzIpNb/2iV34Cb/qXDvziQusyfB2FV2lI9ZruRAary4Q/rBknOtsYrR8Pqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376288; c=relaxed/simple;
	bh=Izu8+8AVwa31bmhTtnBGHdn4X5X+mHWpyK2P8FpTRlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdlMNHEejX9hzxvdZlf7c8V3J2y3VX/sD20MqkCxUpV//xS/DGzpw+jAEgZOpNNLijxbRiM9dmC45ui16pVwdcOedfoSEFRcR5woG8u57MG84VkvdNCY5uXpixWUiylJ+oCZFN6EMkF/mqu+nbprkInEl46juD/vadQRGwG2J7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77F3712FC;
	Wed, 12 Feb 2025 08:05:07 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14FB43F6A8;
	Wed, 12 Feb 2025 08:04:42 -0800 (PST)
Date: Wed, 12 Feb 2025 16:04:36 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>, Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH v6 00/42] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Message-ID: <Z6zGlIHkuGB42kUP@e133380.arm.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <f600712d-d089-4285-8d04-e12f53a61572@intel.com>
 <0a7cf2ef-55d9-470f-a2cb-03655a6329d5@arm.com>
 <1e3f655f-3e94-4da8-a5c2-0fbbffdb1d40@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e3f655f-3e94-4da8-a5c2-0fbbffdb1d40@intel.com>

Hi Reinette,

On Tue, Feb 11, 2025 at 11:29:18AM -0800, Reinette Chatre wrote:
> Hi James,
> 
> On 2/11/25 10:37 AM, James Morse wrote:
> > Hi Reinette,
> > 
> > On 10/02/2025 17:24, Reinette Chatre wrote:

[...]

> [...] the new version you sent hinted to
> me that you were able to come up for air to give some attention to resctrl upstream and
> I grasped the opportunity to get your input on this item that moved along while you were
> busy elsewhere.  
> 
> > 
> > This is still on my todo list, I think Dave is planning to look through the ABMC series
> > too. I had previously sent some comments, (words to the effect "works for me"), and shared
> > a branch with the MPAM tree rebased on top.
> 
> To me the primary concern is the new resctrl files introduced by this work. To get an idea
> of the work and the new files you need only consider Babu's detailed cover letter. These files
> have changed since your previous comments so a fresh "works for me" will be appreciated.

This is roughly what I was planning to try to do, so I will go ahead
with that.

[...]

Cheers
---Dave

