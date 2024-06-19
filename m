Return-Path: <linux-kernel+bounces-221074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEB290EB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E251C21909
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48C6143885;
	Wed, 19 Jun 2024 12:54:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C06FC1F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801680; cv=none; b=LzKICKOca8wevUWkoeN8WHV7k13iWqznXOwDgN6D72X5P81D55yFJm7rLlVhtpN7DVgDpOTsdECSkNA6A54bg35SmOFwBcb08CL/ePlD9wALJGCgkKn8q9fkWjeO/LM22BWca4uWef5t+AYNBIm8Jrpi207NQSHrBgo1BXwi+hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801680; c=relaxed/simple;
	bh=RntI/0TdKoLCLMlqDzvPcVr40RqcqOzFflQWDwxtsTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCv+ehy/vm+GM33badDrDQSna/jx9g84UzQrjikZAat3/KVVFIehRGMjQWy4YbADwmgpAMSlcvPw94lQXdpBeJro0IuMNKAaEi05I6C2u4DlscNQz703BLJdxeHsND5QSe8bHo6O+rb1qBvSJSQ7/jTpT9gub6o0306RBl33D2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BCD31042;
	Wed, 19 Jun 2024 05:55:02 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A0CA3F6A8;
	Wed, 19 Jun 2024 05:54:34 -0700 (PDT)
Date: Wed, 19 Jun 2024 13:54:31 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	Peter Newman <peternewman@google.com>, dfustini@baylibre.com,
	amitsinght@marvell.com, David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH] x86/resctrl: Don't try to free nonexistent RMIDs
Message-ID: <ZnLVB1Cvy8PXhaMv@e133380.arm.com>
References: <20240614160843.11006-1-Dave.Martin@arm.com>
 <1e3bba2e-5cf6-4a77-b92d-5c7ab1661d17@intel.com>
 <ZnAkOhFWzDqhlSyt@e133380.arm.com>
 <a37917d2-8ad9-4192-a3f8-9789193d53d6@intel.com>
 <ZnFTnzm/jctgN2wf@e133344.arm.com>
 <d476585b-3cfb-494d-b25c-4aeb6244e21d@intel.com>
 <ZnGy8B4FA+q3YkhC@e133380.arm.com>
 <f30c9a16-27b5-44ab-a55d-b2f9f3e4258e@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f30c9a16-27b5-44ab-a55d-b2f9f3e4258e@intel.com>

Hi,

On Tue, Jun 18, 2024 at 10:08:47AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 6/18/24 9:16 AM, Dave Martin wrote:
> 
> > 
> > Either way, I don't think this impacts the tested-ness of this patch,
> > but please shout if you have concerns.
> > 
> 
> I agree. The submission stated that it was tested on x86
> "for the monitors-present case". When booting with
> "rdt=!cmt,!mbmtotal,!mbmlocal" (as I did in my test) resctrl
> is not able to discover monitoring support and it
> thus tested the "monitors _not_ present case".
> 
> Reinette

Ah, right.  I missed the significance of the options.

Thanks again!
---Dave
> 
> 

