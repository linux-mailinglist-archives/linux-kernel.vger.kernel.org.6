Return-Path: <linux-kernel+bounces-284784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D5C95051B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1233A1C209A1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFF6199E93;
	Tue, 13 Aug 2024 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cfe31hxg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA6319AD6A;
	Tue, 13 Aug 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552376; cv=none; b=ACeZxcWUxAWKBx0CVa6RPd16MLNgJq3xsIowJ+gHXT27Kytpw121wyQoyUJnAxLWTWO73n+seJBkQutZ2hPYp06j5A4o0WSlXSVZrRMm/CsX8kHyu/xhsDjE0Cg7I7rgJw3cQiR0Xs8o00FHyRNYd1ujNovVcVC7NhXjt+ugZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552376; c=relaxed/simple;
	bh=rWHptO4ILHYisfbYtoMmHf0mrhvaSphbwM91ej5HbZQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xbp5PyLMqkSdT/LCu1hl7DElB/1EkrxZ31ARRNow0n5aKbQbW6Mln4yLPr3Rn7PRM0I6edrtTEt+RG2Vq75ORMRueWf+B9kbBqVMzAzGXkBFHpB05ISfXr6Cq+NrbeG1c7vuIU21leppIm0Loot994iKffaK3rFa38P/ft/0Mi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cfe31hxg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723552374; x=1755088374;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=rWHptO4ILHYisfbYtoMmHf0mrhvaSphbwM91ej5HbZQ=;
  b=Cfe31hxg13gZcjEzGql60e/2C3es2y+jJjOMwWXJ1KbMmSspwarlhmNH
   SLGjp6UM2PHMMNv/1HES0Jt/fo1w1PkUwseNpaXxMuSUOSaBGRihQm98Y
   3WQmP21ZjjeFtIK/UzlHcFd3zdXbcF4xcIgLey7zq4+EiKBQkK27JutoD
   zrqs5MXe6suK9DS8aBXdjaAC08CpzmML0p8adhQZKnRXG37fm8O1ClFmA
   NelY87zCorG3vcyzqsxwTEy4LsoICu3qY2rE3xSHrk6WTQmQv1E5UfUUM
   QlUNYr4n6wDleHE6mYvCfUykWDo8zZzMmKpDwzBM4cNAQPJyCJW4zBqBe
   Q==;
X-CSE-ConnectionGUID: YP5CZnvgRASvHRIftp3Q0A==
X-CSE-MsgGUID: KkAxKstURmyVNtIl3I9T0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="24621085"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="24621085"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 05:32:53 -0700
X-CSE-ConnectionGUID: iQ7gEKo4RKywxnOMFR2hRw==
X-CSE-MsgGUID: 18rTvv8zQSmVQl8wMppmHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="59218495"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.169]) ([10.245.244.169])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 05:32:50 -0700
Message-ID: <cc50eeb7cf3e6a89e66920f498b24a3ef8fa7746.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] drm/xe: clean up fault injection usage
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org
Cc: intel-xe@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, akinobu.mita@gmail.com, 
 akpm@linux-foundation.org, lucas.demarchi@intel.com,
 rodrigo.vivi@intel.com,  robdclark@gmail.com, quic_abhinavk@quicinc.com,
 dmitry.baryshkov@linaro.org
Date: Tue, 13 Aug 2024 14:32:47 +0200
In-Reply-To: <20240813121237.2382534-3-jani.nikula@intel.com>
References: <20240813121237.2382534-1-jani.nikula@intel.com>
	 <20240813121237.2382534-3-jani.nikula@intel.com>
Autocrypt: addr=thomas.hellstrom@linux.intel.com; prefer-encrypt=mutual;
 keydata=mDMEZaWU6xYJKwYBBAHaRw8BAQdAj/We1UBCIrAm9H5t5Z7+elYJowdlhiYE8zUXgxcFz360SFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCBMaW51eCBlbWFpbCkgPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPoiTBBMWCgA7FiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQuBaTVQrGBr/yQAD/Z1B+Kzy2JTuIy9LsKfC9FJmt1K/4qgaVeZMIKCAxf2UBAJhmZ5jmkDIf6YghfINZlYq6ixyWnOkWMuSLmELwOsgPuDgEZaWU6xIKKwYBBAGXVQEFAQEHQF9v/LNGegctctMWGHvmV/6oKOWWf/vd4MeqoSYTxVBTAwEIB4h4BBgWCgAgFiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwwACgkQuBaTVQrGBr/P2QD9Gts6Ee91w3SzOelNjsus/DcCTBb3fRugJoqcfxjKU0gBAKIFVMvVUGbhlEi6EFTZmBZ0QIZEIzOOVfkaIgWelFEH
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-13 at 15:12 +0300, Jani Nikula wrote:
> With the proper stubs in place in linux/fault-inject.h, we can remove
> a
> bunch of conditional compilation for CONFIG_FAULT_INJECTION=3Dn.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>


> ---
> =C2=A0drivers/gpu/drm/xe/xe_debugfs.c |=C2=A0 7 +------
> =C2=A0drivers/gpu/drm/xe/xe_gt.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++---=
-----
> =C2=A02 files changed, 3 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_debugfs.c
> b/drivers/gpu/drm/xe/xe_debugfs.c
> index 1011e5d281fa..b381bfb634f7 100644
> --- a/drivers/gpu/drm/xe/xe_debugfs.c
> +++ b/drivers/gpu/drm/xe/xe_debugfs.c
> @@ -6,6 +6,7 @@
> =C2=A0#include "xe_debugfs.h"
> =C2=A0
> =C2=A0#include <linux/debugfs.h>
> +#include <linux/fault-inject.h>
> =C2=A0#include <linux/string_helpers.h>
> =C2=A0
> =C2=A0#include <drm/drm_debugfs.h>
> @@ -26,10 +27,7 @@
> =C2=A0#include "xe_vm.h"
> =C2=A0#endif
> =C2=A0
> -#ifdef CONFIG_FAULT_INJECTION
> -#include <linux/fault-inject.h> /* XXX: fault-inject.h is broken */
> =C2=A0DECLARE_FAULT_ATTR(gt_reset_failure);
> -#endif
> =C2=A0
> =C2=A0static struct xe_device *node_to_xe(struct drm_info_node *node)
> =C2=A0{
> @@ -214,8 +212,5 @@ void xe_debugfs_register(struct xe_device *xe)
> =C2=A0	for_each_gt(gt, xe, id)
> =C2=A0		xe_gt_debugfs_register(gt);
> =C2=A0
> -#ifdef CONFIG_FAULT_INJECTION
> =C2=A0	fault_create_debugfs_attr("fail_gt_reset", root,
> &gt_reset_failure);
> -#endif
> -
> =C2=A0}
> diff --git a/drivers/gpu/drm/xe/xe_gt.h b/drivers/gpu/drm/xe/xe_gt.h
> index 8b1a5027dcf2..ee138e9768a2 100644
> --- a/drivers/gpu/drm/xe/xe_gt.h
> +++ b/drivers/gpu/drm/xe/xe_gt.h
> @@ -6,6 +6,8 @@
> =C2=A0#ifndef _XE_GT_H_
> =C2=A0#define _XE_GT_H_
> =C2=A0
> +#include <linux/fault-inject.h>
> +
> =C2=A0#include <drm/drm_util.h>
> =C2=A0
> =C2=A0#include "xe_device.h"
> @@ -19,19 +21,11 @@
> =C2=A0
> =C2=A0#define CCS_MASK(gt) (((gt)->info.engine_mask &
> XE_HW_ENGINE_CCS_MASK) >> XE_HW_ENGINE_CCS0)
> =C2=A0
> -#ifdef CONFIG_FAULT_INJECTION
> -#include <linux/fault-inject.h> /* XXX: fault-inject.h is broken */
> =C2=A0extern struct fault_attr gt_reset_failure;
> =C2=A0static inline bool xe_fault_inject_gt_reset(void)
> =C2=A0{
> =C2=A0	return should_fail(&gt_reset_failure, 1);
> =C2=A0}
> -#else
> -static inline bool xe_fault_inject_gt_reset(void)
> -{
> -	return false;
> -}
> -#endif
> =C2=A0
> =C2=A0struct xe_gt *xe_gt_alloc(struct xe_tile *tile);
> =C2=A0int xe_gt_init_hwconfig(struct xe_gt *gt);


