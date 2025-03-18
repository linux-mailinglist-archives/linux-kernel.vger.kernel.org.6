Return-Path: <linux-kernel+bounces-566143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237FAA673CB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB233B51D8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C24C20C00E;
	Tue, 18 Mar 2025 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cOiLivVL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D655B20A5E2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742300596; cv=none; b=TrKwlv78/fzMoEOxQ+Ezx/Yo84idYS4qHP3Hh6gYHXEQjZdOUEZHqvZD380/lq8Q34rh+R/1HyQ4vtugN9JtFSwsxP+4UAtr688BdAXN8i/VbZdGLXFwWlUlxv8cgA1t0rM4CjZ6bq2kM4rumqVMfMqEQoo/2oGbCYbmeWsnV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742300596; c=relaxed/simple;
	bh=Nm5lWHhR2bSNlHHJ1i5GaLxw46Jh/lbrsRa24gtvpno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBbnF5JMA6Fz0bp7jJQNlnpzDYDYsRckp10cmQsqZA7YDwjpNKVo5S/aujmnq8NpkCO48wChIe3uPOJIS5nnsC7FUiEK/5KWFwyhtpHoNY7etkWjVBjTzK/EGPfWbEr5zeTp7wl513JUyBP0GVgkvI390sU/0PHDFXTdsmf2+a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cOiLivVL; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742300594; x=1773836594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nm5lWHhR2bSNlHHJ1i5GaLxw46Jh/lbrsRa24gtvpno=;
  b=cOiLivVLwOBvE4x9UK88XqBChjYg+ED3Mp195yKO5vemiT1Ovs4sBpj6
   rkjiVsTOKh+bWCf70fwsyJ2yrdLdxGnKvXm9o1T4IAtI1S0oSAvy6+Nmx
   31gpbQKtcRYVZUtaPErBdR7hCQmglJATtLaibL0bIwjtKnxZ3ItKA32T8
   LVeroYEBcjQdbmO+VtYvMG2CfXqKhDy2gGliQz0jv8uzXc+88rtyyPhNW
   4QzMG2R0x8C/1ciOfyS+0GmBqAXPpCAg+6QX93EjVg9/QjRR7sqJ7cCT+
   KpPYnf3qvbtDRAXUiI5fClPrdtoCUxqH6QUQRYTVUfGxUxM5UGyYVyKdb
   Q==;
X-CSE-ConnectionGUID: PbDkECNyR2Wq+kG/HdYm+A==
X-CSE-MsgGUID: P/24193JRtiTGzRcFmsRlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54113102"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="54113102"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 05:23:14 -0700
X-CSE-ConnectionGUID: QNvabbolSsaOb2TkfNNgQA==
X-CSE-MsgGUID: ChNxU6OPS36tWUHDkvR6BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="127283744"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 18 Mar 2025 05:23:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 489AC1D8; Tue, 18 Mar 2025 14:23:11 +0200 (EET)
Date: Tue, 18 Mar 2025 14:23:11 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	x86@kernel.org, linux-kernel@vger.kernel.org, vannapurve@google.com, 
	Elena Reshetova <elena.reshetova@intel.com>
Subject: Re: [RFC PATCH] /dev/mem: Disable /dev/mem under TDX guest
Message-ID: <guatjzjzipzjzvj4oou2gktxmzileawshxmxj22hsa5kmet5g4@2rhf7tzaiytw>
References: <20250318113604.297726-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318113604.297726-1-nik.borisov@suse.com>

On Tue, Mar 18, 2025 at 01:36:04PM +0200, Nikolay Borisov wrote:
> If a piece of memory is read from /dev/mem that falls outside of the
> System Ram region i.e bios data region the kernel creates a shared
> mapping via xlate_dev_mem_ptr() (this behavior was introduced by
> 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()"). This results
> in a region having both a shared and a private mapping.
> 
> Subsequent accesses to this region via the private mapping induce a
> SEPT violation and a crash of the VMM.

Crash of VMM or TD termination? If VMM crashes in this case, it has to be
fixed.

> In this particular case the
> scenario was a userspace process reading something from the bios data
> area at address 0x497 which creates a shared mapping, and a followup
> reboot accessing __va(0x472) which access pfn 0 via the private mapping
> causing mayhem.

I think it should lead to unrecoverable EPT-violation, but not VMM crash.

> Fix this by simply forbidding access to /dev/mem when running as an TDX
> guest.

I think we need to think wider. What about applying a subset of LOCKDOWN_*
in all coco guests by default. Many of them are relevant for the guest security.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

