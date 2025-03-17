Return-Path: <linux-kernel+bounces-565181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 922CDA66281
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0381D17C337
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1186204851;
	Mon, 17 Mar 2025 23:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jytu1tqV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2281FECBA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742253317; cv=none; b=e9oKYL5DpPEckS2XizMZ3gap6A4X1GaVSgbs2ks7tDcvVU4FCWQ0oncQTC2xmNEhAd8MA66lI+g/ImX2CDgAT+cKx7X57Gho74DkVl0hr/PP+DCL9hgF6PfqRO3KQ/Iqz9CmrFp/InjyDIAN0Vs0fcUzbf3478pNzgyeZDZT5OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742253317; c=relaxed/simple;
	bh=MzWNzuJI6VEPxWYJV1nrzHEx5PZZDvQKAuseLGVZ1Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMabSyOzUQGvQxk0RNUbZynTj6HACXRC8D+b1f/tEx1bQXEMJxXrdEZyBlGJ+OeAELX7GK5FZTudusNoykbP25VaHJs8+WJQpnOx/ZN0Lj3z/AvdNrvfrbehr4Cvk1kFbPv5XYOC6fD9dmP5JNGypzuN7yy7g2JegOX+MI0DSwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jytu1tqV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742253316; x=1773789316;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MzWNzuJI6VEPxWYJV1nrzHEx5PZZDvQKAuseLGVZ1Qw=;
  b=jytu1tqVVuovlwzcMoQIeK7BqTeEF3K1+IEhmUcajKGRDyOGiiYyQ0hY
   UDMQCuRDO6W6D8KY/WxlrXHUP30MMJk6PmlkfZp7FKS7qDibwVvvLDeSH
   g4wGyTZjhg1wTb4s1OKhq+8JLCu2y+5U+IM1erj3WNkEcb7s4t9/s8yuZ
   p1t59F+BlnMhsIO7g0d+hjdv7KyVXYT9XkeCx54rShD4oAth0p3++Yf8n
   uo6DPtOwD9UNXraYJ3mflLD4QCZfRHU9ekWdAs70p0HmHy20xL8aZbz4X
   424YOr4siWKLnATQIgLDfGTcPVClIk6w/2erhbMdAzIhv50cwg5v4KXUI
   g==;
X-CSE-ConnectionGUID: lZYaIRv9SIeIzJXeA0EFrw==
X-CSE-MsgGUID: pkCZwy+HTda4PQJ2PVPFVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43109339"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="43109339"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 16:15:15 -0700
X-CSE-ConnectionGUID: PtP25NO8QlyjwYAjJLnucw==
X-CSE-MsgGUID: eBOI8D5xQ1GzewUSv6FDaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="145257535"
Received: from spandruv-desk2.amr.corp.intel.com (HELO [10.124.223.123]) ([10.124.223.123])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 16:15:13 -0700
Message-ID: <8e188239-44d2-42ad-9fa9-b46ad0a5b5bb@linux.intel.com>
Date: Mon, 17 Mar 2025 16:15:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] tsm: Unified Measurement Register ABI for TVMs
To: Cedric Xing <cedric.xing@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Dan Middleton <dan.middleton@linux.intel.com>,
 Mikko Ylinen <mikko.ylinen@linux.intel.com>
References: <20250223-tdx-rtmr-v2-0-f2d85b0a5f94@intel.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250223-tdx-rtmr-v2-0-f2d85b0a5f94@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Cedric,

On 2/23/25 7:20 PM, Cedric Xing wrote:
> NOTE: This patch series introduces the Measurement Register (MR) ABI, and
> is a continuation of the RFC series on the same topic [1].
>
> This patch series adds a unified interface to the TSM core, allowing TVM
> (TEE VM) guest drivers to expose measurement registers (MRs) as attributes
> (files) in sysfs. With this interface, applications can read and write
> (extend) MRs like regular files, enabling usages like configuration
> verification (e.g., verifying a TVM's configuration against digests stored
> in static/immutable MRs like MRCONFIGID on TDX or HOSTDATA on SEV) and
> runtime measurements (e.g., extending the measurement of a container image
> to an RTMR before running it).
>
> Patches included in this series:
>
> - Patch 1 adds TSM APIs for TVM guest drivers to register/expose MRs
>    through sysfs.
> - Patch 2 provides a sample module demonstrating the usage of the new TSM
>    APIs.
> - The remaining patches update the TDX guest driver to expose TDX MRs
>    through the new TSM APIs.

Any comment on the missing event log support? Extending the measurements
without logging the event should break the tractability feature. Can you add
info about why it is ok to just add extension support for now?


>
> [1]: https://lore.kernel.org/linux-coco/20241210-tsm-rtmr-v3-0-5997d4dbda73@intel.com/
>
> Signed-off-by: Cedric Xing <cedric.xing@intel.com>
> ---
> Changes in v2:
> - Added TSM_MR_MAXBANKS Kconfig option
> - Updated Kconfig dependency for TSM_REPORTS
> - Updated comments in include/linux/tsm.h
> - Updated drivers/virt/coco/tsm-mr.c to use `IS_BUILTIN()` for determining
>    if static buffer addresses can be converted to GPAs by `virt_to_phys()`
> - Renamed function `tdx_mcall_rtmr_extend()` -> `tdx_mcall_extend_rtmr()`
> - Link to v1: https://lore.kernel.org/r/20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com
>
> ---
> Cedric Xing (4):
>        tsm: Add TVM Measurement Register support
>        tsm: Add TSM measurement sample code
>        x86/tdx: Add tdx_mcall_extend_rtmr() interface
>        x86/tdx: Expose TDX MRs through TSM sysfs interface
>
>   Documentation/ABI/testing/sysfs-kernel-tsm |  20 ++
>   MAINTAINERS                                |   3 +-
>   arch/x86/coco/tdx/tdx.c                    |  36 +++
>   arch/x86/include/asm/shared/tdx.h          |   1 +
>   arch/x86/include/asm/tdx.h                 |   2 +
>   drivers/virt/coco/Kconfig                  |  17 +-
>   drivers/virt/coco/Makefile                 |   2 +
>   drivers/virt/coco/tdx-guest/Kconfig        |  24 +-
>   drivers/virt/coco/tdx-guest/tdx-guest.c    | 115 +++++++++
>   drivers/virt/coco/{tsm.c => tsm-core.c}    |   6 +-
>   drivers/virt/coco/tsm-mr.c                 | 383 +++++++++++++++++++++++++++++
>   include/linux/tsm.h                        |  65 +++++
>   samples/Kconfig                            |  13 +
>   samples/Makefile                           |   1 +
>   samples/tsm/Makefile                       |   2 +
>   samples/tsm/tsm_mr_sample.c                | 107 ++++++++
>   16 files changed, 789 insertions(+), 8 deletions(-)
> ---
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> change-id: 20250209-tdx-rtmr-255479667146
>
> Best regards,

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


