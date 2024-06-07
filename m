Return-Path: <linux-kernel+bounces-206114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2EB90046D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7FC1F24D08
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E523C194157;
	Fri,  7 Jun 2024 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgHxPZt2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674BD1940AA;
	Fri,  7 Jun 2024 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766081; cv=none; b=JJIJpdZSYsM1oO5kLuHDP0sa0ybjCiPnMRqTSS2LhEKssKb2yffv8zno/sRaRROz7AV2mDuQKtlTEMqDbZUspCR+oVKnntxZX+09lTmNPoH+P+ILV2GpxXEgIOUQth8SuR6kvxVImMY70nNE1y277BQtSwIdnLYkYs2svn/kNDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766081; c=relaxed/simple;
	bh=ABua8CX7aHFShIRy1tF0NN3EsSEVeFn4ti8y8bQ86LI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DT472yQ/NxTuez/fguHtBt/JkkLBlFKD1kDXap+6XZLRBdLgfqI3ppCdoB5ocsKtWQ4xKtIOXFYYHo3GnZ9vEbJ2j+M6HEiq+HKtSHCrrsIaHqxyFLdGxWqChWGo7sCCpoS/sqZzuCodmYCPeiENJFCyolMAGDiqZCqWl4KHAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgHxPZt2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717766080; x=1749302080;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ABua8CX7aHFShIRy1tF0NN3EsSEVeFn4ti8y8bQ86LI=;
  b=PgHxPZt22JXZugfVwlbzaIYTId4dCKy3xecpLaqRw5fiY8o3nYzjHu9c
   rwndPRfsuk2DZ6RlH179VPouCOHPe77rm7tBpoNEAc7D1NWD5b6eSE5Sz
   jIRigo7OV/yA1gHs4V5j6GvwP3vxsz8u6ztve/1IZ9+NeWd4vd6CP9Iao
   BZqDUw8ULjEm0rfTdzgeZsSk3v2j9xAisET8jDYW1urkjxuCBGqtu08zV
   7+J3Zhqr2dPhgrZJkTsqOs83uiTmsZD3f/vQbYs9+g5DIRIVE2jW7Mxs+
   +36KI7w6jPvMGl68FK0DaP1SqlKeBs5FE4VEUKX1Q453qPo3FgsnC2MJO
   Q==;
X-CSE-ConnectionGUID: uFKubQRRSYW8kvT8L38SLQ==
X-CSE-MsgGUID: c5hfHB+ST1WXu42ZT1Lleg==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14439371"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14439371"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 06:14:39 -0700
X-CSE-ConnectionGUID: bZNr/o6LQJeUN3T2eDzpfA==
X-CSE-MsgGUID: i+N3Z6ggQ2+Wz4+Q7tsZkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38440144"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.184])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 06:14:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 7 Jun 2024 16:14:33 +0300 (EEST)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: linux-doc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH V3 1/3] platform/x86/intel/sdsi: Add ioctl SPDM
 transport
In-Reply-To: <20240606011617.557264-1-david.e.box@linux.intel.com>
Message-ID: <b32cd809-7aed-62ed-1b6e-550221a3acbb@linux.intel.com>
References: <20240606011617.557264-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 5 Jun 2024, David E. Box wrote:

> Intel On Demand adds attestation and firmware measurement retrieval
> services through use of the protocols defined the Security Protocols and
> Data Measurement (SPDM) specification. SPDM messages exchanges are used to
> authenticate On Demand hardware and to retrieve signed measurements of the
> NVRAM state used to track feature provisioning and the NVRAM state used for
> metering services. These allow software to verify the authenticity of the
> On Demand hardware as well as the integrity of the reported silicon
> configuration.
> 
> Add an ioctl interface for sending SPDM messages through the On Demand
> mailbox. Provides commands to get a list of SPDM enabled devices, get the
> message size limits for SPDM Requesters and Responders, and perform an SPDM
> message exchange.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.0.1.pdf [1]
> ---

> +static int sdsi_spdm_do_command(struct sdsi_priv *priv,
> +				struct sdsi_spdm_command __user *argp)
> +{
> +	u32 req_size, rsp_size;
> +
> +	if (get_user(req_size, &argp->size))
> +		return -EFAULT;
> +
> +	if (req_size < 4 || req_size > sizeof(struct sdsi_spdm_message))

Hi David,

Is that 4 actually SPDM_HEADER_SIZE?

If my guess is correct, no need to send an updated version, I'll just fix 
it while applying.


-- 
 i.


