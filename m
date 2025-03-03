Return-Path: <linux-kernel+bounces-541459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 934BBA4BD1F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06221737B9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE65D1F3D59;
	Mon,  3 Mar 2025 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYXOpK6W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27311F3FC3;
	Mon,  3 Mar 2025 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999237; cv=none; b=BMEYjX2Mkz0eYYZPel3EUfh+hRVBDb6N/XGZPv9JEdkOTR88wREtNDW1fUFzr7aH80hy5S7FudzCR7e9vkeajKieJTgmCa1qBObxfPGKQzt9SmiUcdLSTv3P1bxTkaQH4NVEI2tAAY6GnfL4WXjvjkc3yLnS8WNNM1BMqpKfKww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999237; c=relaxed/simple;
	bh=VMZ6P21zLGokAbk3qLQTO7rUfuCl1QNxio6tcJmjd5Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f0fzjUqWqNQY4R+hepK1lOqnS5IOQVgL4qvWPNzmvMiUUMpuN0q0s7f30XBPK9wM7cWZBPqeMj/IA5h00qs0J77oK81d37I4EIORsBgDMONWZ6FO6Y3O+XylYTw6mo8r20a5eoh+6AXdPDPUdPyBD9/fMHX8YOCaKtUjwQ1WN1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYXOpK6W; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740999236; x=1772535236;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VMZ6P21zLGokAbk3qLQTO7rUfuCl1QNxio6tcJmjd5Y=;
  b=JYXOpK6Wdd74/M9k6oh2wAZqSoNdRO9pxO38DOcJM1sS2Dp7hISVOy2V
   aXgkg6vXlM6rBjnK1HYZRWwex+tahd8ncq4nX/vaRdawWQGw4aSSp2bIy
   UZMakOSCE6PkAG4AzLhz4S+Ux7cdtcd4nxU/90VXLIv7PL9RldU4yQipE
   4i1go0I8slbme+nNp8peTTt8BB0AjMnvZqCSJ5DEJ7OhLCGUidjXRe7uF
   Jn9d5fIlXEIgwu5w5UArZhGVL+GtBip+IpFEHgPycmZWNdIerqMAJE+tK
   hu3el6/S6m0fu32pvnBIBEWKaX+d3zHz8s7NKdgOFSpiOgU8cIWaqjoca
   A==;
X-CSE-ConnectionGUID: Ymf8joAWSNqmP3wfMSDYIA==
X-CSE-MsgGUID: NUgUradOQ2aR+e7j8mjeaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="53258533"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="53258533"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 02:53:56 -0800
X-CSE-ConnectionGUID: JpC5ORU9TLmq/rqCzYzogw==
X-CSE-MsgGUID: VSMXvOS7TkiNIpPkvYrSgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="118003775"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.14])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 02:53:52 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 3 Mar 2025 12:53:49 +0200 (EET)
To: Joshua Grisham <josh@joshuagrisham.com>
cc: W_Armin@gmx.de, thomas@t-8ch.de, kuurtb@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: samsung-galaxybook: Fix block_recording
 not supported logic
In-Reply-To: <20250302205350.32509-1-josh@joshuagrisham.com>
Message-ID: <fd539f15-8b47-3708-6905-8c6aca38c213@linux.intel.com>
References: <20250302205350.32509-1-josh@joshuagrisham.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 2 Mar 2025, Joshua Grisham wrote:

> Fixes logic error when block_recording is not supported but the fw attr is
> being added anyway (reported by GitHub user bbregeault).
> 
> Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>

Please add a Fixes tag.

-- 
 i.

> ---
>  drivers/platform/x86/samsung-galaxybook.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platform/x86/samsung-galaxybook.c
> index de1ed2dc6..5878a3519 100644
> --- a/drivers/platform/x86/samsung-galaxybook.c
> +++ b/drivers/platform/x86/samsung-galaxybook.c
> @@ -1100,11 +1100,13 @@ static int galaxybook_fw_attrs_init(struct samsung_galaxybook *galaxybook)
>  	}
>  
>  	err = galaxybook_block_recording_init(galaxybook);
> -	if (!err)
> -		galaxybook->has_block_recording = true;
> -	else if (err != GB_NOT_SUPPORTED)
> +	if (err == GB_NOT_SUPPORTED)
> +		return 0;
> +	else if (err)
>  		return err;
>  
> +	galaxybook->has_block_recording = true;
> +
>  	return galaxybook_fw_attr_init(galaxybook,
>  				       GB_ATTR_BLOCK_RECORDING,
>  				       &block_recording_acpi_get,
> 

