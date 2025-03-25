Return-Path: <linux-kernel+bounces-574629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C83A6E7C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC38B17536D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BAB7F7FC;
	Tue, 25 Mar 2025 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YRYOJ3Hj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD23125D6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863961; cv=none; b=XemRDRyjfPKbID1XU1pDWhcBCzYqR6z87kKB1jIpD5SS/LhqnvMjNqozJX4+ooE45kVrZbHh70WnLrTpb+KcVpdyYVZ9yBImrXkeyNwymQa0OWDtFaBQn20itR+HDg/W0XRWdNgQsXqsOal9/8VG+DtVLi/4xnbgi1iquxQY9Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863961; c=relaxed/simple;
	bh=Ob78+tbnQMGlB5beES+uCyBPJqMz19XSvQosd5J0uwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGJCTHG8MRXd918MDW3yV6TZnv7fzU3YRu31UkED3Si+ot52IHegrAAz72UaSAkG7KpEwxp1kNdOuQxdpPGT9Ul03gqYanvvTJhdhRRVh0BP82v/0oSFnWLZE+0phzBtYErohb0cslPEtrOVBreuxWbiD3X74Mku4yYf2Cb9ecA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YRYOJ3Hj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742863961; x=1774399961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ob78+tbnQMGlB5beES+uCyBPJqMz19XSvQosd5J0uwU=;
  b=YRYOJ3Hjubja4g4yCRtnKxbmRpuMoU0Bsi9lb7XGkTFoaFnZWp7cv+xj
   715ZUT2H4CBrZPTxFl4dKUkDLO8DQ+mVUxHZsrMtwaOFcBqhXEgnAUvGo
   JjiLVCR18dVd+NYIi3XYNssqAzAxolgRPDx8S24OpjckmZ41Q/xnSlFOg
   z4CKbbZNKpSnbQaD7OHLVo4st1NxSjrMTSWhzN8aEEsFKtcmfV6m/gO39
   sb3eTD5pd7Lcx6GxuhXzvXRU43Z5v5AOB3aHu8OI0rv/VxHoKwLf6Arg8
   8WuV8qZSIHffrlu2vMZQ7dNsyQj91nK7olLndzinWC1LDbrIffdCd9oca
   Q==;
X-CSE-ConnectionGUID: 92Rkb+S+SiO4o7E4aDwX/g==
X-CSE-MsgGUID: aP+5ZLWATWuv0JYE3/ucVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="61484981"
X-IronPort-AV: E=Sophos;i="6.14,273,1736841600"; 
   d="scan'208";a="61484981"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 17:52:40 -0700
X-CSE-ConnectionGUID: TBZdFiqvQg+VREbxlYoztA==
X-CSE-MsgGUID: V3pdKtQEQ0KTPt7/3Wpv/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,273,1736841600"; 
   d="scan'208";a="128384903"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 17:52:38 -0700
Date: Mon, 24 Mar 2025 17:52:37 -0700
From: "Luck, Tony" <tony.luck@intel.com>
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
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com
Subject: Re: [PATCH v7 37/49] x86/resctrl: Expand the width of dom_id by
 replacing mon_data_bits
Message-ID: <Z-H-VesKknnUMmpb@agluck-desk3>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-38-james.morse@arm.com>
 <e1816cbf-e2a7-44cf-92f9-bbd24d9e264b@intel.com>
 <a54fe3e7-19cb-4f84-9189-f0e3853e98fe@arm.com>
 <9e47d037-a47c-4869-8ac1-2ab151608b08@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47d037-a47c-4869-8ac1-2ab151608b08@intel.com>

On Thu, Mar 13, 2025 at 08:25:08AM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/12/25 11:04 AM, James Morse wrote:
> > On 07/03/2025 05:03, Reinette Chatre wrote:
> >> On 2/28/25 11:59 AM, James Morse wrote:
> 
> ...
> 
> >> With all of the above I do not think this will work on an SNC enabled
> >> system ... to confirm this I tried it out and it is not possible to mount
> >> resctrl on an SNC enabled system and the WARN_ON_ONCE() this patch adds to
> >> mon_add_all_files() is hit.
> > 
> > I hadn't realised the mon_sub directories for SNC weren't all directly under mon_data.
> > Searching from mon_data will need the parent name too. What I've come up with is:
> > -------%<-------
> > 	snc_mode = r->mon_scope == RESCTRL_L3_NODE;
> > 	if (!snc_mode) {
> > 		sprintf(name, "mon_%s_%02d", r->name, d->hdr.id);
> > 		kn_target_dir = kernfs_find_and_get(kn_mondata, name);
> > 	} else {
> > 		sprintf(name, "mon_%s_%02d", r->name, d->ci->id);
> > 		kn_target_dir = kernfs_find_and_get(kn_mondata, name);
> > 
> > 		if (snc_mode && !do_sum) {
> 
> snc_mode should always be true here?
> 
> > 			sprintf(name, "mon_sub_%s_%02d", r->name, d->hdr.id);
> > 			kernfs_put(kn_target_dir);
> 
> I think this needs some extra guardrails. If kn_target_dir is NULL here
> it looks like that the kernfs_put() above will be fine, but from what I can tell
> the kernfs_find_and_get() below will not be.
> 
> > 			kn_target_dir = kernfs_find_and_get(kn_target_dir, name);
> > 		}
> > 	}
> > 	kernfs_put(kn_target_dir);
> > 	if (!kn_target_dir)
> > 		return NULL;
> > -------%<-------
> > 
> 
> This looks good to me. In original patch a NULL kn within mon_get_default_kn_priv()
> was used as prompt to create the private data. It is thus not obvious to me from this
> snippet what is being returned "to", but I do not think that was your point of sharing
> this snippet. 

Is this all overly complex trying to re-use the "priv" fields from
the default resctrl group?  Would it be easier to just keep a list
of each combinations of region id, domain id, sum, and event id that have
already been allocated and re-use existing ones, or add to the list
for new ones. Scanning this list may be less overhead that all the
sprintf() and kernfs_find_and_get() searches.


Something like:


static LIST_HEAD(kn_priv_list);

static struct mon_data *mon_get_kn_priv(struct rdt_resource *r,
					struct rdt_mon_domain *d,
					struct mon_evt *mevt,
					struct rdtgroup *rdtgrp,
					bool do_sum)
{
	struct mon_data *priv;

	list_for_each_entry(priv, &kn_priv_list, list) {
		if (priv->rid == r->rid && priv->domid == (do_sum ? d->ci->id : d->hdr.id) &&
		    priv->sum == do_sum && priv->evtid == mevt->evtid)
			return priv;
		}
	}

	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
	if (!priv)
		return NULL;

	priv->rid = r->rid;
	priv->domid = do_sum ? d->ci->id : d->hdr.id;
	priv->sum = do_sum;
	priv->evtid = mevt->evtid;
	list_add_tail(&priv->list, &kn_priv_list);

	return priv;
}

Maybe just ignore the "domain goes offline case" there's not much memory
tied up in these structures (and the domain may come back).

Just free the whole list when resctrl is unmounted.

static void mon_put_kn_priv(void)
{
	struct mon_data *priv, *tmp;

	list_for_each_entry_safe(priv, tmp, &kn_priv_list, list)
		kfree(priv);
}

[Lightly tested the "get" path. Haven't tried the "put" code.]



-Tony

