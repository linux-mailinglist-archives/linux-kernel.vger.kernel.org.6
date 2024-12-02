Return-Path: <linux-kernel+bounces-428060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFBF9E09A4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E630D282320
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616C81D9350;
	Mon,  2 Dec 2024 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yr4nFWly"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3D7152532;
	Mon,  2 Dec 2024 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159773; cv=none; b=QgT5cwAcOuYlManme7pIy8nzPK1qypictw3qUjbVa5RzM+YAt5AJByiRArxO/UvJnCGN/7MtY9b7KtTOUq/XiMW+MdchxJEmuLj8Rd9RT6FDS59t6+epKOelw8KnBoHJJDj6ZEEElbjpFAbPjWIt5qsKGi+p/FuMWg67rvbJlC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159773; c=relaxed/simple;
	bh=+G8j5nAkaC74LsuwNyJXVh4hwyCn0lUQ3BaUZTvD7xY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=T1PnJVQPDJbjMl60mmYSWdzjkLxdlBK8GP2IYIt45d9JsbAo3NPG3XeR5j3m1EBBH4ePZf0YtGJgo8hKGmR5dJZW86X0QAFzvao2Y1hv8lb0ltt4Jp4ViBlnAgELJhmob6NUp36Tb4YDXj9Z9/kipoF3Hm+JKdnLvTgzGdWmBEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yr4nFWly; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733159772; x=1764695772;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+G8j5nAkaC74LsuwNyJXVh4hwyCn0lUQ3BaUZTvD7xY=;
  b=Yr4nFWlyPVEPL0R2FYo6dY/eyBZBFSV5J+07E2de5uMZG4wm0pTQDMmu
   kBomp4iEQMebQuPyvqllXsWBcI79Xl1+ZFDzjFyRFv0aA9ErOpzXISIMS
   0CWPubkx1yNy2oBSDvsqxxICe3H/5pX4tLnijF6qt1Ue4Ih4FDi6hhLjL
   chFeWrBhuG/5Zvq82cm+czoVpb0pvHGtV/2T+q8UOoFPC4k6ymJVX+lsL
   k0HOjHN0gRttE1tV17V9L7TpNvSoSu1KmfCalE7mV0i0z88qMRholiUZz
   tDaWhlFgPt7ZPttYDrzAtuSaruyxrjJREbnbvcKTN0/S49o4YycIIkXb/
   A==;
X-CSE-ConnectionGUID: wCn5R19tSkOfMir59nkYTg==
X-CSE-MsgGUID: X3OkZqPYQ3Cus0WMAWrcSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="20932436"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="20932436"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 09:16:11 -0800
X-CSE-ConnectionGUID: vZe1SJrWScKCiW4CLWwfZQ==
X-CSE-MsgGUID: 5T6QAl5bTA6zbmEQgEuZHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="92990298"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.61])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 09:16:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 2 Dec 2024 19:16:06 +0200 (EET)
To: Pei Xiao <xiaopei01@kylinos.cn>
cc: Hans de Goede <hdegoede@redhat.com>, vadimp@nvidia.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    davthompson@nvidia.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] platform/mellanox: mlxbf-pmc: incorrect type in
 assignment
In-Reply-To: <fece26ad40620b1e0beb733b9bba3de3ce325761.1732088929.git.xiaopei01@kylinos.cn>
Message-ID: <364568ce-140a-85f5-4bf4-1cc641175015@linux.intel.com>
References: <202411121935.cgFcEMO4-lkp@intel.com> <fece26ad40620b1e0beb733b9bba3de3ce325761.1732088929.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 20 Nov 2024, Pei Xiao wrote:

> sparse warning,expected 'void __iomem *addr',but got 'void *addr'

Hi,

Thanks for the patch. I've applied this patch to review-ilpo-next branch 
but I had to reformat the commit message. Please make sure you use proper 
spacing and put warnings like that on their own lines in future.

-- 
 i.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411121935.cgFcEMO4-lkp@intel.com/
> Fixes: 423c3361855c ("platform/mellanox: mlxbf-pmc: Add support for BlueField-3")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/platform/mellanox/mlxbf-pmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
> index 9d18dfca6a67..9ff7b487dc48 100644
> --- a/drivers/platform/mellanox/mlxbf-pmc.c
> +++ b/drivers/platform/mellanox/mlxbf-pmc.c
> @@ -1168,7 +1168,7 @@ static int mlxbf_pmc_program_l3_counter(unsigned int blk_num, u32 cnt_num, u32 e
>  /* Method to handle crspace counter programming */
>  static int mlxbf_pmc_program_crspace_counter(unsigned int blk_num, u32 cnt_num, u32 evt)
>  {
> -	void *addr;
> +	void __iomem *addr;
>  	u32 word;
>  	int ret;
>  
> @@ -1192,7 +1192,7 @@ static int mlxbf_pmc_program_crspace_counter(unsigned int blk_num, u32 cnt_num,
>  /* Method to clear crspace counter value */
>  static int mlxbf_pmc_clear_crspace_counter(unsigned int blk_num, u32 cnt_num)
>  {
> -	void *addr;
> +	void __iomem *addr;
>  
>  	addr = pmc->block[blk_num].mmio_base +
>  		MLXBF_PMC_CRSPACE_PERFMON_VAL0(pmc->block[blk_num].counters) +
> @@ -1405,7 +1405,7 @@ static int mlxbf_pmc_read_l3_event(unsigned int blk_num, u32 cnt_num, u64 *resul
>  static int mlxbf_pmc_read_crspace_event(unsigned int blk_num, u32 cnt_num, u64 *result)
>  {
>  	u32 word, evt;
> -	void *addr;
> +	void __iomem *addr;
>  	int ret;
>  
>  	addr = pmc->block[blk_num].mmio_base +
> 

