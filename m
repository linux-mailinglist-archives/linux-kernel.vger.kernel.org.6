Return-Path: <linux-kernel+bounces-218941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 414CD90C7F7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8F4281594
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E056D1B14F2;
	Tue, 18 Jun 2024 09:30:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109EE15381F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703023; cv=none; b=Z1U7sWx0ToglIepveo+RweqwkOXTSiMcHS1a1mIKb44l3ZSW4kfTUjDqTlma7ZytsZgmj89fJOQoCKE6fdtySE1IlgaglTpBgqjvEbLOCAH8gETMfygCbQB0F8827rp1UZNLauspcuYAzm/hjShS/yJo7DyGJBR2Km10SLlodeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703023; c=relaxed/simple;
	bh=VpqATmY4KjFpTaddmRIycfLEE2w5IFvvlgBNPkIm9QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7CJJdbvg3rr336Nnrb5CJi/bXpaZ6SEW1y4xE3Ad4ZvtQQAjx80F+JkPKWcRaOK5gxE2qmsZblYYvm4QXrNoFmzo1ba5XUZL9uEU+Bt7rCvQEOOYZJmI4cxWBZrVxx1g560b4WrOEMDTH8VxTGINQxN8FLkTi1zvxAlOEvwzug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 909F8DA7;
	Tue, 18 Jun 2024 02:30:44 -0700 (PDT)
Received: from e133344.arm.com (unknown [10.1.33.195])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 611723F64C;
	Tue, 18 Jun 2024 02:30:15 -0700 (PDT)
Date: Tue, 18 Jun 2024 10:30:07 +0100
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
Message-ID: <ZnFTnzm/jctgN2wf@e133344.arm.com>
References: <20240614160843.11006-1-Dave.Martin@arm.com>
 <1e3bba2e-5cf6-4a77-b92d-5c7ab1661d17@intel.com>
 <ZnAkOhFWzDqhlSyt@e133380.arm.com>
 <a37917d2-8ad9-4192-a3f8-9789193d53d6@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a37917d2-8ad9-4192-a3f8-9789193d53d6@intel.com>

Hi,

On Mon, Jun 17, 2024 at 08:53:38AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 6/17/24 4:55 AM, Dave Martin wrote:
> > Hi Reinette,
> > 
> > On Fri, Jun 14, 2024 at 03:47:58PM -0700, Reinette Chatre wrote:
> > > Hi Dave,
> > > 
> > > On 6/14/24 9:08 AM, Dave Martin wrote:
> > > > Commit 6791e0ea3071 ("x86/resctrl: Access per-rmid structures by
> > > > index") adds logic to map individual monitoring groups into a
> > > > global index space used for tracking allocated RMIDs.
> > > > 
> > > > That patch keept the logic to ignore requests to free the default
> > > 
> > > keept -> kept
> > > 
> > > nitpick: I actually do not know if "that patch" gets same hate as
> > > "this patch" so to avoid any potential feedback about this I'd like
> > > to suggest that this is rewritten without this term. Perhaps
> > > something like: "Requests to free the default RMID in free_rmid()
> > > are ignored, and this works fine on x86."
> > > 
> > > > RMID in free_rmid(), and this works fine on x86.
> > > > 
> > 
> > How about recasting the first paragraph into the past tense (since it
> > relates a past commit), and rewording as "Requests to free the default
> > RMID continued to be ignored in free_rmid(), and this works fine on
> > x86."
> 
> Please keep it in the present tense. I do not see this as relating to
> a "past commit" but instead it is an existing commit responsible for
> current behavior. Documentation/process/maintainer-tip.rst contains
> some example changelogs created by x86 maintainers that captures their
> requirements. The beginning "context" portion is always in present
> tense.

Fair enough.  I'll reword this as per your suggestion.

[...]

> > > > Tested on x86 (But so far for the monitors-present case.
> > > 
> > > Tested by booting with "rdt=!cmt,!mbmtotal,!mbmlocal".
> > 
> > Thanks (I take it that's your test, not a request to be more specific
> > about mine?)
> 
> Yes, I did test it with those parameters. You are also welcome to
> add:
> Tested-by: Reinette Chatre <reinette.chatre@intel.com>

Ah, right.  Thanks.

> > As it happens I tested with rdt=cmt,mbmtotal,mbmlocal,l3cat,l3cdp
> > (though I made no effort to exercise these features other than running
> > the selftests).  I can note this in the commit if you prefer.
> 
> hmmm ... those parameters should not be necessary unless the system
> has those features forced off by default because of errata. Doing
> functional testing on these systems via such enabling is fine
> though.
> 
> Reinette

I got these kernel args from James.  Apparently some of these features
are defaulted to off by the firmware on the box I'm using, but we're not
sure why.  I haven't dug into it.

Cheers
---Dave

