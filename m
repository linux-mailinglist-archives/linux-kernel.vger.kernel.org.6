Return-Path: <linux-kernel+bounces-523499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5562DA3D791
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ECD8189C963
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFB21F2C56;
	Thu, 20 Feb 2025 10:58:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77331EE032
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049115; cv=none; b=Lu0T0Dw4Ie8ihCXQaKPWDiViK1Gh89j6iJVeKWqT8dfPGrHR1kLtKR0hpQlIU3s/T+8b5xj3HOYA6kyZPTiUNoBDjmrEvC+Akd+uJJuTZr/9KKj0/7Jw/mb3y5SN2vY9HDeSDYOCJ/O+rV+cBOTf1fVs03GEzIUJ9E2VBXIZnhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049115; c=relaxed/simple;
	bh=3CYUtr3rabXNf+6vQSehNTpFnXZLwkaA902jt7XoupE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blikA6hxhLJR2Pdidg9OFQOkf7BTk3bJovX1jEweAPvRpT9FeoTnKENsrbroVQkH66YqO0WpYOib5NPq3rYFijDVut3NsVCL5KiMnD/JNpWXDoZbYYYHWH3dl6biMmRb6GjvrDjjmPQvWRRZ/mvzv5jTycRpLAmFx1xtSKLgCeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E055C4CEE3;
	Thu, 20 Feb 2025 10:58:30 +0000 (UTC)
Date: Thu, 20 Feb 2025 10:58:28 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
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
	Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH v6 12/42] x86/resctrl: Move rdt_find_domain() to be
 visible to arch and fs code
Message-ID: <Z7cK1FpQCgBVSGHq@arm.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-13-james.morse@arm.com>
 <acdfa4ee-e293-49f3-8e53-900b9db63ddb@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acdfa4ee-e293-49f3-8e53-900b9db63ddb@intel.com>

On Wed, Feb 19, 2025 at 03:24:06PM -0800, Reinette Chatre wrote:
> On 2/7/25 10:17 AM, James Morse wrote:
> > rdt_find_domain() finds a domain given a resource and a cache-id.
> > This is used by both the architecture code and the filesystem code.
> > 
> > After the filesystem code moves to live in /fs/, this helper will no
> > longer be visible.
> > 
> > Move it to the global header file. As its now globally visible, and
> > has only a handful of callers, swap the 'rdt' for 'resctrl'.
[...]
> > --- a/include/linux/resctrl.h
> > +++ b/include/linux/resctrl.h
> > @@ -372,6 +372,40 @@ static inline void resctrl_arch_rmid_read_context_check(void)
> >  		might_sleep();
> >  }
> >  
> > +/**
> > + * resctrl_find_domain() - Search for a domain id in a resource domain list.
> > + * @h:		The domain list to search.
> > + * @id:		The domain id to search for.
> > + * @pos:	A pointer to position in the list id should be inserted.
> > + *
> > + * Search the domain list to find the domain id. If the domain id is
> > + * found, return the domain. NULL otherwise.  If the domain id is not
> > + * found (and NULL returned) then the first domain with id bigger than
> > + * the input id can be returned to the caller via @pos.
> > + */
> > +static inline struct rdt_domain_hdr *resctrl_find_domain(struct list_head *h,
> > +							 int id,
> > +							 struct list_head **pos)
> 
> Could you please provide a motivation for why this needs to be inline now?

It's in a header now, to avoid the compiler complaining about unused
static functions wherever this file is included. The alternative is a
prototype declaration and the actual implementation in a .c file.

(drive-by comment, I don't really understand this subsystem to make a
meaningful contribution)

-- 
Catalin

