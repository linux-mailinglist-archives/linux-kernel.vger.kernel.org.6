Return-Path: <linux-kernel+bounces-368464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C695B9A1012
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB611F22EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9002071F7;
	Wed, 16 Oct 2024 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gN3+fXCK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A65213C807
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097426; cv=none; b=mGzunHDIpZoNyLJKby5RG/bjPj/2xyGtpw1Qd8CKChQhOy9jj4vTlKIpf6c8rQdpJEeSnFOvY+yO0nIrwMt5+O6Pks0Q+FpVb6X0QagzCYATuwzNSWKL1IBlGBbN0LeZJq/X5WKLxcs/e1s2hX++CbW2sNddZK3lGmGRbOejsDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097426; c=relaxed/simple;
	bh=K9eIX5MfeH32r7tBiJ4JGhvGWPS5CeYA5aN466AAKb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cp0A7Re1mq4+zIwyR1XfmBEWl9udx+4eCEXV29JzhikqG3dzTLtdWh7grB6pfocRuCxgQcFrYBywtVtvpb/oX34s8/rYaxil+VNQ0G/ysxQJl2aFwtPlJRg5FSR01KA40GTajRyDSGDuMGdoetvt2qQ+B2Lxu5OmjX47+J4RGeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gN3+fXCK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729097424; x=1760633424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K9eIX5MfeH32r7tBiJ4JGhvGWPS5CeYA5aN466AAKb8=;
  b=gN3+fXCKGcRhzoMeI2Fk5ui4/FDjAK/D6ZobWcKR5sCSUO6gZ7gKa6Ot
   9G5eKLusCZPKgcrMdeAdEbwwMGf01H4w94aJUxXx1Lr9yZuoQcKWORuoL
   gi9fxeI4AbLV5WtGU7Cvuz9jSvu0tCVydMYbyFJxbt4WRuLWM07MV2Ert
   J3DlrWe866kGkP4hmIpADK58TJ6Q67jbWqhA6rCB4DV7cRY43cCzG2o4T
   m4MLk3/WPmvY2e2UXptdjsxnLcbs3cftr1TASidiOx/l3YQP9S25iPekf
   MTv15OBcZ2QbqASiMVlulTQawhsAJ9vcYnzFPbYv6Sv+x7qAGzgM+vR9z
   A==;
X-CSE-ConnectionGUID: TsQqw03jS+6CJmUXcm+cCg==
X-CSE-MsgGUID: pqtu61LeQn+MlGdN+4AlIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39105590"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39105590"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 09:50:23 -0700
X-CSE-ConnectionGUID: g2FmSw5iRdmTO2jrJiGrMg==
X-CSE-MsgGUID: VBa1k62uT5mbRRJ6fiemog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82953364"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 09:50:23 -0700
Date: Wed, 16 Oct 2024 09:50:21 -0700
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
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v5 20/40] x86/resctrl: Slightly clean-up mbm_config_show()
Message-ID: <Zw_uzXu_wpzH67aN@agluck-desk3.sc.intel.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-21-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004180347.19985-21-james.morse@arm.com>

On Fri, Oct 04, 2024 at 06:03:27PM +0000, James Morse wrote:
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> 'mon_info' is already zeroed in the list_for_each_entry() loop below.
> There is no need to explicitly initialize it here. It just wastes some
> space and cycles.
> 
> Remove this un-needed code.

Boris has applied this one to tip x86/cache. Drop it from the series.

-Tony

