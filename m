Return-Path: <linux-kernel+bounces-374148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1578F9A658D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1902283252
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E541E572F;
	Mon, 21 Oct 2024 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H5rhc3Bf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D09BE55B;
	Mon, 21 Oct 2024 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508047; cv=none; b=ZeZGcZETDPM2bPIlDKhvw7udTf7MahvWHV+84QM3vXIFhfdgtNQszrvB36wilfOc741ZrvNjT5SDYWmMIHkjoxyzc5FzEi7IMgd4SAE9z1WtBijfTFZznutXkJBbS72i1O3iMTxDGmDhPlVoJK/NpyMDtMJnjlPtsuMDDKPKLYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508047; c=relaxed/simple;
	bh=b9FbXkE5pu8aHcs8QYvHaBCFDkSag9y7xanRzpEOVPo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PRnHUC6turjXA87rlbGv3bGFpwl+I6Kko5ecOLgyZNYmwMVDRwgqXRaWv+tSkJiPhMYU+d+OUfaIZtZibz++fNf/B7MpSByLg5TElPOX/L0Q0T1Jod8p4NKn+YDrZCM8l4y9SnGmOZzrZFLSUFxrQJ+s3rKOJjUK8a4s2Yya2DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H5rhc3Bf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729508045; x=1761044045;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=b9FbXkE5pu8aHcs8QYvHaBCFDkSag9y7xanRzpEOVPo=;
  b=H5rhc3BfrkxcHzV8UGvSU34Y9pG37vK/Jn0HOm7RxRYhMvyoGnFIBjg4
   N93Aukaq5GUEq3dS3T684CBgm9YHM079BSJ4fTcE6XQh84AOGSMdfqmSk
   3MuoWKsHLO/jHy07HEy/wHHQelBfXZEp7A7mMdQYYWh1SuAfYctffLsjG
   bhSftyRqr70Pm8AMcqOky/Tqi8RkYCrdKTcRSqMhF1BXcYKz+moph2nuv
   K7RFFewRY1epTP6AeuNf4RCK7ofiMbPi8zpPcI3kEPecaFRQJ/utbo4fo
   LXiWjIEE5sbk4rCRcqvMBMPnuX+sEuPeuSS10txBPFmd5Gc4/J/G3BidH
   A==;
X-CSE-ConnectionGUID: v9BIY/3dS7+MDPWEgdxJIQ==
X-CSE-MsgGUID: CWxvlKP3RT6fErH5gY0T2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39522552"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39522552"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 03:54:04 -0700
X-CSE-ConnectionGUID: hXfEpZ/rT6OZWWlLg5dJFQ==
X-CSE-MsgGUID: b6hIArXrSaCX3KDZ5zq/og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79895227"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 03:54:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Oct 2024 13:53:59 +0300 (EEST)
To: Hongling Zeng <zenghongling@kylinos.cn>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    stuart.w.hayes@gmail.com, Hans de Goede <hdegoede@redhat.com>, 
    zhongling0719@126.com
Subject: Re: [PATCH] platform/x86: dell-dcdbase: Replace snprintf in show 
 functions with sysfs_emit
In-Reply-To: <20241021021412.5728-1-zenghongling@kylinos.cn>
Message-ID: <49db5473-c7cc-b4e5-6166-cb56ba3dd7b0@linux.intel.com>
References: <20241021021412.5728-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 21 Oct 2024, Hongling Zeng wrote:

>   show() must not use snprintf() when formatting the value to be

Please remove the extra spaces.

> returned to user space

Missing .

> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>  drivers/platform/x86/dell/dcdbas.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dcdbas.c b/drivers/platform/x86/dell/dcdbas.c
> index a60e350..143fd0a 100644
> --- a/drivers/platform/x86/dell/dcdbas.c
> +++ b/drivers/platform/x86/dell/dcdbas.c
> @@ -132,14 +132,14 @@ static ssize_t smi_data_buf_phys_addr_show(struct device *dev,
>  					   struct device_attribute *attr,
>  					   char *buf)
>  {

Add #include <linux/sysfs.h> (I did this for you in the other patch when 
I realized it's missing).

Once you've fixed those 3 issues mentioned above, please send v2.

-- 
 i.

> -	return sprintf(buf, "%x\n", (u32)smi_buf.dma);
> +	return sysfs_emit(buf, "%x\n", (u32)smi_buf.dma);
>  }
>  
>  static ssize_t smi_data_buf_size_show(struct device *dev,
>  				      struct device_attribute *attr,
>  				      char *buf)
>  {
> -	return sprintf(buf, "%lu\n", smi_buf.size);
> +	return sysfs_emit(buf, "%lu\n", smi_buf.size);
>  }
>  
>  static ssize_t smi_data_buf_size_store(struct device *dev,
> @@ -200,7 +200,7 @@ static ssize_t host_control_action_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
>  {
> -	return sprintf(buf, "%u\n", host_control_action);
> +	return sysfs_emit(buf, "%u\n", host_control_action);
>  }
>  
>  static ssize_t host_control_action_store(struct device *dev,
> @@ -224,7 +224,7 @@ static ssize_t host_control_smi_type_show(struct device *dev,
>  					  struct device_attribute *attr,
>  					  char *buf)
>  {
> -	return sprintf(buf, "%u\n", host_control_smi_type);
> +	return sysfs_emit(buf, "%u\n", host_control_smi_type);
>  }
>  
>  static ssize_t host_control_smi_type_store(struct device *dev,
> @@ -239,7 +239,7 @@ static ssize_t host_control_on_shutdown_show(struct device *dev,
>  					     struct device_attribute *attr,
>  					     char *buf)
>  {
> -	return sprintf(buf, "%u\n", host_control_on_shutdown);
> +	return sysfs_emit(buf, "%u\n", host_control_on_shutdown);
>  }
>  
>  static ssize_t host_control_on_shutdown_store(struct device *dev,
> 

