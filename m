Return-Path: <linux-kernel+bounces-421857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5193D9D9100
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173A328ADA2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25003130A7D;
	Tue, 26 Nov 2024 04:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hj/hsJqU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB9C58222
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 04:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732594778; cv=none; b=YCzRL+zBDrtahky4O8Q9jQxjN3nCXxXfCSSJ/NrLyZvS6MgY8SJhcBE/jbDcoCvTu/kGNAk/wMkO9TPa548hDgiVucyMhmIEBsCjJOLbSvxn6uVDwBlXV1/Jeaa0KZ3jEJExEyKRwZghBsuRYRL0tUzvcO4lDhK2mdKs+b4ynfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732594778; c=relaxed/simple;
	bh=frfncE3AoglY03qJwD8O9QoKXrrUIq2iGRcdZpNI8a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLkJVVb+LIFttTffxSRS1oksSP63R/AL7gPLlyXLZSSYx/nYLW2kKRB4QxGJmXbK0UeYrKnQ2fqaepL1QPA/2QZRq9qL3CtLb6ppVmUl3YgNaiva/uuwxIB85SAf9blKb39HQU9ZJfhqLovSSXbd0fL+Qkm4hQA3eIpH90Y2o1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hj/hsJqU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732594777; x=1764130777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=frfncE3AoglY03qJwD8O9QoKXrrUIq2iGRcdZpNI8a4=;
  b=Hj/hsJqU8tdSnm6yz/PpoFcOxPaehR82t1SmGkF2aFwrMiW5YEPV2yPo
   g1t/Ot+3+6l9dTdZxaLuVXm8nNzVq9C0T8qVZ5m6UGxPqBwMTAZ0tpDH6
   WCyTxVzReT/0w+9MsRTcPW2od+ZMKMcqmn6qHqWsRzxcmoBueAd5Qlv1W
   eltw/hhWQgMjkCQPU5jy1yv122eVh0k2D4LH15qlrfE0bqwV8n85H2V8y
   HY3uHkmw6MSs4ZL7Ft3/oz+l/90jgY29/AXugSpuLUv1gRfcK97bXQ4y8
   fPgj+10po0SoSWdQvDq7ROsycNsPV2Y4D1oGbKKV3PGKzwWFl05TUHh0k
   w==;
X-CSE-ConnectionGUID: wMGPM4J0QMmJ88O+PK/hpQ==
X-CSE-MsgGUID: 7wGsrrquTkKZnY6hu+xHww==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32791456"
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="32791456"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 20:19:36 -0800
X-CSE-ConnectionGUID: S+ZbSAIOTseeM10B/uh6+A==
X-CSE-MsgGUID: 5Liokl9YQMSaGOVPqWrzWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="91103203"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.36])
  by fmviesa006.fm.intel.com with ESMTP; 25 Nov 2024 20:19:33 -0800
Date: Tue, 26 Nov 2024 12:37:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	bp@alien8.de, rafael@kernel.org, lenb@kernel.org,
	dave.jiang@intel.com, irenic.rajneesh@gmail.com,
	david.e.box@intel.com
Subject: Re: [PATCH 08/11] x86/tsc: Remove CPUID "frequency" leaf magic
 numbers.
Message-ID: <Z0VQlg++mRUtmFvz@intel.com>
References: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
 <20241120195338.D035B080@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120195338.D035B080@davehans-spike.ostc.intel.com>

On Wed, Nov 20, 2024 at 11:53:38AM -0800, Dave Hansen wrote:
> Date: Wed, 20 Nov 2024 11:53:38 -0800
> From: Dave Hansen <dave.hansen@linux.intel.com>
> Subject: [PATCH 08/11] x86/tsc: Remove CPUID "frequency" leaf magic numbers.
> 
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> All the code that reads the CPUID frequency information leaf hard-codes
> a magic number.  Give it a symbolic name and use it.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
> 
>  b/arch/x86/include/asm/cpuid.h |    1 +
>  b/arch/x86/kernel/tsc.c        |   12 ++++++------
>  2 files changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


