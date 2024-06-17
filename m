Return-Path: <linux-kernel+bounces-217253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA7790AD6D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443951F238D1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C394194C70;
	Mon, 17 Jun 2024 11:55:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3793194C63
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718625352; cv=none; b=m+ReUsL8yixbSV86jOYaFS/cVPnk1YxJRy4aZD4R35Ib3CjSUNAOhi2qAcc3jJXpHhQtO+Ee0fXZBYexXGtMcpvCcyB44nAUraSLtmMfm4Mdcg0v5ox7eDu6WS/EiuLlEIPfFdvEIid5BNbWxXtBl+HoIhrJ2lTzwLdvFTQG1Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718625352; c=relaxed/simple;
	bh=hzbdzCNgOajYMka/w3WGxrit2ajekIZLVxfqwUc2JGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAtvOqXPzbhHKTaqbIBMPxqu1FPnBrdvjuJE0LFOJ0IJYikvNhfJkkUbany6upR6hJHlDqcXB/YBSdveUWGD8lBUwpydq1wfSn7XUQ23lLm+Fw+yUcGQvJtDQx8+kv2CC9rYavo3WdkJ0nISulOCTeVgkDAy75KFXwTsJe6BpMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6629FEC;
	Mon, 17 Jun 2024 04:56:13 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA4813F64C;
	Mon, 17 Jun 2024 04:55:45 -0700 (PDT)
Date: Mon, 17 Jun 2024 12:55:38 +0100
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
Message-ID: <ZnAkOhFWzDqhlSyt@e133380.arm.com>
References: <20240614160843.11006-1-Dave.Martin@arm.com>
 <1e3bba2e-5cf6-4a77-b92d-5c7ab1661d17@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e3bba2e-5cf6-4a77-b92d-5c7ab1661d17@intel.com>

Hi Reinette,

On Fri, Jun 14, 2024 at 03:47:58PM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 6/14/24 9:08 AM, Dave Martin wrote:
> > Commit 6791e0ea3071 ("x86/resctrl: Access per-rmid structures by
> > index") adds logic to map individual monitoring groups into a
> > global index space used for tracking allocated RMIDs.
> > 
> > That patch keept the logic to ignore requests to free the default
> 
> keept -> kept
> 
> nitpick: I actually do not know if "that patch" gets same hate as
> "this patch" so to avoid any potential feedback about this I'd like
> to suggest that this is rewritten without this term. Perhaps
> something like: "Requests to free the default RMID in free_rmid()
> are ignored, and this works fine on x86."
> 
> > RMID in free_rmid(), and this works fine on x86.
> > 

How about recasting the first paragraph into the past tense (since it
relates a past commit), and rewording as "Requests to free the default
RMID continued to be ignored in free_rmid(), and this works fine on
x86."

(I agree that "this patch" would have been ambiguous.  "That patch" was
an attempt to be clearer, but felt a bit clumsy.  Naming the commit
again felt worse, though would have been clearer.  I've noticed that
people who do not have English as their first language tend to use
"this" and "that" a little differently from native English speakers, so
there is probably more scope for confusion here that I like to
assume...)

> > With arm64 MPAM, there is a latent bug here: on platforms with no
> > monitors exposed through resctrl, each control group still gets a
> > different monitoring group ID as seen by the hardware, since the
> > CLOSID always forms part of the monitoring group ID.  This means
> > that when removing a control group, the code may try to free this
> > group's default monitoring group RMID for real.  If there are no
> > monitors however, the RMID tracking table rmid_ptrs[] would be a
> > waste of memory and is never allocated, leading to a splat when a
> > free_rmid() tries to dereference the table.
> > 
> > One option would be to treat RMID 0 as special for every CLOSID,
> > but this would be ugly since we still want to do bookkeeping for
> > these monitoring group IDs when there are monitors present in the
> > hardware.
> > 
> > Instead, add a gating check of resctrl_arch_mon_capable() in
> > free_rmid(), and just do nothing if the hardware doesn't have
> > monitors.
> > 
> > This fix mirrors the gating checks already present in
> > mkdir_rdt_prepare_rmid_alloc() and elsewhere.
> > 
> > No functional change on x86.
> > 
> > Fixes: 6791e0ea3071 ("x86/resctrl: Access per-rmid structures by index")
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > 
> > ---
> > 
> > Based on v6.10-rc3.
> > 
> > Tested on x86 (But so far for the monitors-present case.
> 
> Tested by booting with "rdt=!cmt,!mbmtotal,!mbmlocal".

Thanks (I take it that's your test, not a request to be more specific
about mine?)

As it happens I tested with rdt=cmt,mbmtotal,mbmlocal,l3cat,l3cdp
(though I made no effort to exercise these features other than running
the selftests).  I can note this in the commit if you prefer.

> 
> > Testing on Atom would be appreciated.)
> > 
> > Tested on arm64 for the no-monitors case.
> > ---
> >   arch/x86/kernel/cpu/resctrl/monitor.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> > index 2345e6836593..366f496ca3ce 100644
> > --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> > +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> > @@ -519,7 +519,8 @@ void free_rmid(u32 closid, u32 rmid)
> >   	 * allows architectures that ignore the closid parameter to avoid an
> >   	 * unnecessary check.
> >   	 */
> > -	if (idx == resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
> > +	if (!resctrl_arch_mon_capable() ||
> > +	    idx == resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
> >   						RESCTRL_RESERVED_RMID))
> >   		return;
> > 
> 
> Thank you for catching this. This reveals how subtle resctrl is by
> calling free_rmid() in paths for convenience and then relying on an
> uninitialized variable for correct behavior.
> 
> This replaces this subtle assumption with an actual check.
> 
> With changelog comments addressed:
> | Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> Reinette

Thanks for that.  I'll wait for your reply before respinning this.

Cheers
---Dave

