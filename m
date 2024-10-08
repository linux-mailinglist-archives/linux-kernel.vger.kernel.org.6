Return-Path: <linux-kernel+bounces-355633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4239799551A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096252845BD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFC91E0E15;
	Tue,  8 Oct 2024 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S5Ml9LV7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F61E0DC3
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406482; cv=none; b=XXYo/f7E98xGWITKUuP56+9bBnloUxxo9H3PfLCiUyFWGxOlUHyfk1mK4w3iebxzbVmKn6KWqGkUDh2nIsmjIVi786oC8D4DlVDpLU14/fmhIvcZYOTtc9I6sjQ8Seyqbx6g1tB3hhtv0HnZjs27C9Ah44ulnpjTfOoxE41pMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406482; c=relaxed/simple;
	bh=AmrGfG7Zuo+YxId5wPfF6uG8BrrY9vTDPH0WxlRp8qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dU82pC4ATUZiwr/1iTfQCA0vn3aYaRQv/HyTJMuX3PH4QO1pQyv8fDz0zu4f46gsYT+QvHou4YU5ADwRE3V/Z1qGf1w26F+0lf5VTxri2abxwovwKh3qfCLKjFI4Pe/ZaDnFGm+Emm/4OBJmedq0pFBIOZGE53LU1mSNndiIGLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S5Ml9LV7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728406481; x=1759942481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AmrGfG7Zuo+YxId5wPfF6uG8BrrY9vTDPH0WxlRp8qw=;
  b=S5Ml9LV7Z779vDvSZvZkhs5Q3lhd9aAHQrSUhscimkn/35v1lxQtF8fE
   dGkOZS+chEJYwvXRXNZnHM68X1NapKn/YwzM0UJfe0H4+6KlmMLjiRxzu
   EktdP+9VA7+xVbuvtLoEoVtncO/ZEKahwuhk7Ww5IOk/6IDy7oM9D/bSf
   8uDu6RviEYDOr14LbkT1If7t1yngydifBwnms1oE6gVZq+FzqHfEbVRNI
   Mf3BeTWLWnYmoMlIvsm/iJvgmWb+0neOkf7DxRgFezaYs7vOG2KdnqEgI
   ie1PJl78mcwXe5r38AfRhH/pvzPQoDD7v+yYqSReqEEKXCWsw6+XBwmva
   A==;
X-CSE-ConnectionGUID: ICm/QMzJTYGM982P3AorVg==
X-CSE-MsgGUID: mif8sCBNRqi7rNcPtOSEMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27501948"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27501948"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 09:54:34 -0700
X-CSE-ConnectionGUID: XcDyNtj0SXmdNjjfBfIGyw==
X-CSE-MsgGUID: GybRok1vRO+uL5FxpdVQkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="76011804"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 09:54:27 -0700
Date: Tue, 8 Oct 2024 10:00:15 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] cacheinfo: Allocate memory during CPU hotplug if
 not done from the primary CPU
Message-ID: <20241008170015.GA24312@ranerica-svr.sc.intel.com>
References: <20240913083155.9783-1-ricardo.neri-calderon@linux.intel.com>
 <20240913083155.9783-2-ricardo.neri-calderon@linux.intel.com>
 <20241008155106.GMZwVU6gjw45z2gn8x@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008155106.GMZwVU6gjw45z2gn8x@fat_crate.local>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Oct 08, 2024 at 05:51:06PM +0200, Borislav Petkov wrote:
> On Fri, Sep 13, 2024 at 01:31:53AM -0700, Ricardo Neri wrote:
> > The motivation for commit 5944ce092b97 was to prevent a BUG splat in
> > PREEMPT_RT kernels during memory allocation. This splat is not observed on
> > x86 because the memory allocation for cacheinfo happens in
> > detect_cache_attributes() from the cacheinfo CPU hotplug callback.
> > 
> > The dereference of a NULL cacheinfo is not observed today because
> > cache_leaves(cpu) is zero until after init_cache_level() is called
> > (during the CPU hotplug callback). A subsequent changeset will set
> > the number of cache leaves earlier and the NULL-pointer dereference
> > will be observed.
> 
> Lemme get this straight: this NULL ptr deref will happen after your changes

Yes. It does happen only after my changes.

> so we don't really need this patch in stable and thus no Fixes: tag at all,
> right?

IMHO, this patchset is needed in stable kernel because /sys/devices/system/cpu
cpu0/cache would be broken on Meteor Lake and processors like it.

This patch alone is not needed in stable kernels.

Thanks and BR,
Ricardo

