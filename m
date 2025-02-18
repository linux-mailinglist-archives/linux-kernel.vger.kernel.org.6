Return-Path: <linux-kernel+bounces-518511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61047A39032
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 02:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A78B1893119
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 01:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF65A53E23;
	Tue, 18 Feb 2025 01:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DV0IESXq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83042481B1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739841057; cv=none; b=gmzhCGzYij8AF1NboxnqrVbI3TBb87BdHlGGer8fxEYqJGmWltcAmCuKbw0u3in+nIGXsRDBBJtZYl7hMW0C2yoyK3gBtb+DpZjt5Y8eeHV+sDImIr4VYPGDCKEes70etb7ZrdaPl6TE/oauYWNQxKAxmIvdY6kyEkiJYVqBz3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739841057; c=relaxed/simple;
	bh=Hthi+u/pk9oskxpUkrntpRUwzCWA5xDB00b8r/zqPHo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lP+uLHjhOupJmZ8eeYYnKsKI17ahCpjJQdy3GL2U0m2XfLwAUe5WNN5k+2cA1i5ekEBsCpjSE6IRCpCCjnFmUVkttBESGrnMtV34iAfsPl+mJRi3CjassvPx8E7zza5EsigFFHbAOLiOWro5wyB9Bnlaq2etVmQyT12O6Cshhvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DV0IESXq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739841055; x=1771377055;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Hthi+u/pk9oskxpUkrntpRUwzCWA5xDB00b8r/zqPHo=;
  b=DV0IESXqMVgNdk30JbYqiSOkrVMQhyfftUnPI7EUN0k3q+8Q/91u44ps
   OI+xFsCzRNP6wxVva7Umk8BEC5aklJuvch0a7vYWMchdfIP56EOJbLIgn
   57Pya60oSUhRbmV+p3XgFvlCpksUZ5Nno7o9fTXzy8hiCxqGqY08/6TgM
   c37gv9VLBDwR4kRW1+72tpAVfXYX31MV8vM/p0UPCDE0EA1vIBxKg9c7A
   AK3vCESw0WX9iUY5V6QriRrAYi9QTp1eiTNoXuyLX4z7GMJLKf+9zpu7m
   v6z6qAcSLbZDbEzCKpBAVBbSnNaWS2NGghAzHMy0luTAkQNV3m2d+BFzi
   w==;
X-CSE-ConnectionGUID: N4XUXNWSQPasYFwewd0f/w==
X-CSE-MsgGUID: 00PU91MgQCeKK4ZX4X1pew==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51510007"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="51510007"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 17:10:55 -0800
X-CSE-ConnectionGUID: +zBGZKCdSBmGwt1gd3/T/A==
X-CSE-MsgGUID: wXcUzglGRcSiDxiU9dvFgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="137487308"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.124.220.114]) ([10.124.220.114])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 17:10:55 -0800
Message-ID: <42c5eba9-381b-4639-9131-f645b375d235@linux.intel.com>
Date: Mon, 17 Feb 2025 17:10:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
To: Cedric Xing <cedric.xing@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
Content-Language: en-US
In-Reply-To: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/12/25 6:23 PM, Cedric Xing wrote:
> NOTE: This patch series introduces the Measurement Register (MR) ABI, and
> is a continuation of the RFC series on the same topic [1].
>
> This patch series adds a unified interface to TSM core for confidential
> computing (CC) guest drivers to provide access to measurement registers
> (MRs), which are essential for relying parties (RPs) to verify the
> integrity of the computing environment. The interface is structured around

I recommend adding information about possible use cases and how end
users might use it here.

> `struct tsm_measurement`, which holds an array of `struct
> tsm_measurement_register` and includes operations for reading and updating
> MRs.
>
> Each `struct tsm_measurement_register` features a `mr_flags` member that
> indicates the MR's properties, such as *Readable* (`TSM_MR_F_R`),
> *Extensible* (`TSM_MR_F_X`), etc. Please refer to Patch 1 in this series
> for more details. Patch 2 adds a sample module to demonstrate how to define
> and implement MRs in a CC guest driver. The last patches add TDX MR support
> to the TDX Guest driver.
>
> MRs are made accessible to applications through a directory tree (rooted at
> `/sys/kernel/tsm`). An MR could be presented as either a file containing
> its value, or a directory containing the file `digest` under a subdirectory
> of the same name as the hash algorithm. By default, an MR will be presented
> as a directory unless `TSM_MR_F_F` is set in `mr_flags`.
>
> [1]:https://lore.kernel.org/linux-coco/20241210-tsm-rtmr-v3-0-5997d4dbda73@intel.com/

I know that this patch set does not support event log extension for RTMR 
extend.
May be you can add some info about why we cannot support it now and any 
issues
with not supporting it now.

> Signed-off-by: Cedric Xing<cedric.xing@intel.com>
> ---
> Cedric Xing (3):
>        tsm: Add TVM Measurement Register support
>        tsm: Add TSM measurement sample code
>        x86/tdx: Expose TDX MRs through TSM sysfs interface
>
> Kuppuswamy Sathyanarayanan (1):
>        x86/tdx: Add tdx_mcall_rtmr_extend() interface
>
>   Documentation/ABI/testing/sysfs-kernel-tsm |  20 ++
>   MAINTAINERS                                |   3 +-
>   arch/x86/coco/tdx/tdx.c                    |  36 +++
>   arch/x86/include/asm/shared/tdx.h          |   1 +
>   arch/x86/include/asm/tdx.h                 |   2 +
>   drivers/virt/coco/Kconfig                  |   3 +-
>   drivers/virt/coco/Makefile                 |   2 +
>   drivers/virt/coco/tdx-guest/Kconfig        |  15 ++
>   drivers/virt/coco/tdx-guest/tdx-guest.c    | 119 +++++++++
>   drivers/virt/coco/{tsm.c => tsm-core.c}    |   6 +-
>   drivers/virt/coco/tsm-mr.c                 | 375 +++++++++++++++++++++++++++++
>   include/linux/tsm.h                        |  64 +++++
>   samples/Kconfig                            |  10 +
>   samples/Makefile                           |   1 +
>   samples/tsm/Makefile                       |   2 +
>   samples/tsm/tsm_mr_sample.c                | 107 ++++++++
>   16 files changed, 763 insertions(+), 3 deletions(-)
> ---
> base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
> change-id: 20250209-tdx-rtmr-255479667146
>
> Best regards,

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


