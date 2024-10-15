Return-Path: <linux-kernel+bounces-366910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9AF99FC2A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A4C2858FF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEE11B2182;
	Tue, 15 Oct 2024 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDtdGJjl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE14021E3DB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034144; cv=none; b=kP1Ue1Rkh+YOcVmWhefi0GIO+m7CbiXqH57tWF6ksyq93EIB4PQsNwKle9jSS9DC7RinYWPOAGKnCd8FA7GJlVNlJw1LifIwFx2EQfKaHhUa7F+mPwazJ5E0VWyJ5/Ni5qR9c72ODT7HoMD0hUSb5mh6SdkLRp1er8uqjou+MDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034144; c=relaxed/simple;
	bh=mGe2rKgaiKcA3xD2R7YinzDavJD1djvGopuMSR0eCHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKCc+NhkrjCr753eVj84/BOOtaNuJb/AA+gW3EEPzlBhxoXFlDtRrOLP13aO/a2Q9IibmBTXNrq3ok0oef44Y+JQl8zIFsZWArWzCPZ9hhd4SqnnCzXEtBz92MRRkfQRgD45kKSTE/ma+mmEZWAzAf5P0vwozhFX3VmYsCJmrIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDtdGJjl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729034142; x=1760570142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mGe2rKgaiKcA3xD2R7YinzDavJD1djvGopuMSR0eCHA=;
  b=eDtdGJjlAu+WFKQIMsRD3y4ikFHrShg5LxncPxyI46JAeREfxz7tnwVO
   mfrDG9jFlZJBDwmn8Cvg9qjjSqsxasc+Ki2U1t+2hBA7L+tlamBe1dPf+
   Wd95PsowBcYuDdTTj77QchPqCyNYp0kDiQw8ly6px5xK7FditWAt2Pme9
   Cq0bOSQInkTNLIKzaiqO58/I4bKQ86R9+2FMY7iHbuAVl+eVDM25cINnh
   JqKbgGDXIFPsBSaCoOvexxRYCsGqkOpCMrJdGeS+upIE2AYloT4HdleXY
   uV98dPesEIBqbmMqabT1zNgeJw2MffTDujE4UmCAinaKJamd6M/lILvs0
   A==;
X-CSE-ConnectionGUID: QHppbs5zRbWLnJBqnq8VUw==
X-CSE-MsgGUID: YFi4tEVXS2S5i+7By5oBfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28601234"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28601234"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 16:15:42 -0700
X-CSE-ConnectionGUID: xkqxDEdwRfi6FApwoNBWsw==
X-CSE-MsgGUID: UctY3xNcQAi0kbxeQZWuog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="83120844"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 16:15:42 -0700
Date: Tue, 15 Oct 2024 16:15:40 -0700
From: Tony Luck <tony.luck@intel.com>
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
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
	Dave Martin <dave.martin@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v5 04/40] x86/resctrl: Use schema type to determine how
 to parse schema values
Message-ID: <Zw73nIUgPPQSa_ug@agluck-desk3.sc.intel.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-5-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004180347.19985-5-james.morse@arm.com>

On Fri, Oct 04, 2024 at 06:03:11PM +0000, James Morse wrote:
> +static ctrlval_parser_t *get_parser(struct rdt_resource *r)
> +{
> +	switch (r->schema_fmt) {
> +	case RESCTRL_SCHEMA_BITMAP:
> +		return &parse_cbm;
> +	case RESCTRL_SCHEMA_RANGE:
> +		return &parse_bw;
> +	}
> +
> +	return NULL;
> +}

Is it really worth making this a helper function? It's only
used once.

> +
>  /*
>   * For each domain in this resource we expect to find a series of:
>   *	id=mask
> @@ -204,6 +225,7 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>  static int parse_line(char *line, struct resctrl_schema *s,
>  		      struct rdtgroup *rdtgrp)
>  {
> +	ctrlval_parser_t *parse_ctrlval = get_parser(s->res);

No check to see if get_parser() returned NULL.

>  	enum resctrl_conf_type t = s->conf_type;
>  	struct resctrl_staged_config *cfg;
>  	struct rdt_resource *r = s->res;
> @@ -235,7 +257,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
>  		if (d->hdr.id == dom_id) {
>  			data.buf = dom;
>  			data.rdtgrp = rdtgrp;
> -			if (r->parse_ctrlval(&data, s, d))
> +			if (parse_ctrlval(&data, s, d))
>  				return -EINVAL;

Without the helper this could be:

			switch (r->schema_fmt) {
			case RESCTRL_SCHEMA_BITMAP:
				if (parse_cbm(&data, s, d))
					return -EINVAL;
				break;
			case RESCTRL_SCHEMA_RANGE:
				if (parse_bw(&data, s, d))
					return -EINVAL;
				break;
			default:
				WARN_ON_ONCE(1);
				return -EINVAL;
			}

-Tony

