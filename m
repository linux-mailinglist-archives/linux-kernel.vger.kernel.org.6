Return-Path: <linux-kernel+bounces-196907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0C58D6359
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BFB1F27595
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBB915A4BD;
	Fri, 31 May 2024 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BteDAl8A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31702158DDD;
	Fri, 31 May 2024 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163161; cv=none; b=cxDip9bEUfzteN/q9DwPzMUGMmDRC54W9g7VSOMqFLa7RpFyRKKcA1vSmtbjc8n9GCE1dDiT6exaBlpNz0BcWCNSxKDXXrXs/mSmgpG8JT8d3fw+ZZxtWyPzjCwg+hvX9QwPCf08RviqK8h52creEGGLGQcIT7zrarsawoXLr1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163161; c=relaxed/simple;
	bh=cWnIx0pyk+ybibf+oi8lx+duY34BnRyVbbOBK4s2TKY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iOWqtOOVxSAxffzSQ/FuJnnL3MiJhKPyUOAFSzw69C3vCfdy8TwIETANrS1ANUW4Yigo2YA+pMeBdhMYj7cl9Umf9iSDnDsPeMvocYHVgXSxDyVJ8QPN/Ikbc16zZE55MFySffGhgI87EdR9VyPm/F7b4koVz8gF5KPPwiynOqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BteDAl8A; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717163159; x=1748699159;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=cWnIx0pyk+ybibf+oi8lx+duY34BnRyVbbOBK4s2TKY=;
  b=BteDAl8ANcnivGM9Lg+leP3wmCAtengKEhIozpUNgZwQjcvCO/mhtQ4E
   dI5cTUzXMlVDkY7e1HiZOxBeNbVaEtJ3bFx67aOq3d5vvH6Pa0s6aLxhM
   bsfstks/QfzjUrB/9ro5lgDPwAuQTYEoXRZHAkRDiSG2ZOIf6/+OOfsTm
   c4nSNNH5OjkaoKeFcLqPQxPmbV3C7yXx7mGo7BYVjerD0/xFffQ74HA/j
   NFkM1y6HZk5u8dGesA/GH8JBZzcWmSwD6mTn5p07gKlw6bFqtAex2eFD5
   p/jcksvkvj2PkLVtLeU6fX+A/BoY8en6LQuPiz+scKwPNGUkUJHya2eC8
   g==;
X-CSE-ConnectionGUID: 3xs3qAO9RGy6GGE6f19Mdg==
X-CSE-MsgGUID: YBiQk6CyS1aIY2dGCSv+bg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24366294"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="24366294"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:45:58 -0700
X-CSE-ConnectionGUID: l47dWwZcSTaifA3MgLaYrg==
X-CSE-MsgGUID: 5PmUI4yMS5mD5Da/DqHT5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36631271"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:45:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 andriy.shevchenko@linux.intel.com, rui.zhang@intel.com
In-Reply-To: <20240531083554.1313110-1-srinivas.pandruvada@linux.intel.com>
References: <20240531083554.1313110-1-srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 0/3] SST improvements with TPMI
Message-Id: <171716315056.14224.6737878292317791994.b4-ty@linux.intel.com>
Date: Fri, 31 May 2024 16:45:50 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 31 May 2024 01:35:45 -0700, Srinivas Pandruvada wrote:

> These are some improvements to SST with TPMI, which makes sure that SST
> is not available when all model specific parts are not ready and prevent
> legacy SST driver to load on some platforms.
> 
> V2
> Split V1 patch 1/2 to two patches
> Use new family model check macros
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/3] platform/x86: ISST: Add model specific loading for common module
      commit: 1630dc626c87b300627fe7591f4f63f8f136f935
[2/3] platform/x86: ISST: Avoid some SkyLake server models
      commit: 3ea025fb4b5f1a0b66df25eba50b2a1071f01080
[3/3] platform/x86: ISST: Use only TPMI interface when present
      commit: 2f9514f005530502452c34295e77bdfb395b5bc6

--
 i.


