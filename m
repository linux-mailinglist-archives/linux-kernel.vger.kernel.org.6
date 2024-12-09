Return-Path: <linux-kernel+bounces-436834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCF39E8B76
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8A01629D0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AB72147FA;
	Mon,  9 Dec 2024 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIvRbPYm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EC320FAAE;
	Mon,  9 Dec 2024 06:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733725461; cv=none; b=aVeMwKZKv7cz2oBFUsmzXtgSqLZGTZ127UF10qmFGZdsCHUroXfm0P/sPcZ/Sw705mO0ypVd6/Kq9q206xXPHCgkyWhWkMrdtaHM3vezWfRECRXlN2LS81x0ZpEKJihJ3OUxEX20N9ncNW/bb1sdxLnqBdB7yeyrDyCOmm9UBbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733725461; c=relaxed/simple;
	bh=FQfbj4zVf9aROxsrkzjQ011Ql/GUnDTiTcj2kpiDxq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reC26uI37jcPt0hdO/pw9noYIjHVi4eRkxAVghkC1UwzH8rGzvja2qBPuVnFajw2YiL8bi3Ns4KmOavkJXJO4PixkMIvI05fSPDCLovgfkpasHaaK2mFi6Pl5rxJF+ZOm3sGqSxI4/96+NLr1xlPvm1z25zR0MC1RnqdAxlsCkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIvRbPYm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733725460; x=1765261460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FQfbj4zVf9aROxsrkzjQ011Ql/GUnDTiTcj2kpiDxq8=;
  b=TIvRbPYmkbXqhUYQHVIXSKPhmtM8JKjF1Y3ypyQSVcCKa+HGwBvI0Icp
   CH6p7X+K5tpWQQd2qFATUat0C5OmWoMbx75CEBnut0MYCy1xz+7KOlE33
   +NPHNzOlkXQ/gN+rLW1QK1MadcQ7DDUuDDEtfcf+oOdFlLqX8tWKpTInB
   uPVJp6cDQUTIYgkAotKANTa0k/okU06PhRbVQoWXVEuMf3pQNkqZfni4k
   lvSaq/EKpvX9Md89RJIaNiB6hnGB16q9vTn1X0mgEy7zWmqaTBVRzn07u
   U8CqTrJ7qkSE9EKRQCGoIdi4DakSdhxhbqa4i+ZLOOJb/728X9lzUoCoQ
   Q==;
X-CSE-ConnectionGUID: ejHA5g9OTeOO6r/JmCgw1Q==
X-CSE-MsgGUID: dxx+Pfo2QAu5yuuSzolNaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45387764"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45387764"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 22:24:19 -0800
X-CSE-ConnectionGUID: Z+XJzFntTGmEbaCk9F6+JQ==
X-CSE-MsgGUID: lQl9WmidSzuGjvJv0+v90g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="94788192"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 08 Dec 2024 22:24:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id EE42F1FD; Mon, 09 Dec 2024 08:24:15 +0200 (EET)
Date: Mon, 9 Dec 2024 08:24:15 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH] thunderbolt: Don't display retimers unless nvm was
 initialized
Message-ID: <20241209062415.GG4955@black.fi.intel.com>
References: <20241206183318.1701180-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241206183318.1701180-1-superm1@kernel.org>

Hi Mario,

On Fri, Dec 06, 2024 at 12:33:18PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The read will never succeed if nvm wasn't initialized.

Okay but we would need to understand why it was not initialized in the
first place?

I see this is ThinkPad Thunderbolt 4 Dock so probably Intel hardware? You
say you can reproduce this too so can you send me full dmesg with
thunderbolt dynamic debugging enabled? I would like to understand this bit
more deeper before we add any workarounds.

> Reported-by: Richard Hughes <hughsient@gmail.com>
> Closes: https://github.com/fwupd/fwupd/issues/8200
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/thunderbolt/retimer.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
> index 89d2919d0193e..7be435aee7217 100644
> --- a/drivers/thunderbolt/retimer.c
> +++ b/drivers/thunderbolt/retimer.c
> @@ -321,9 +321,7 @@ static ssize_t nvm_version_show(struct device *dev,
>  	if (!mutex_trylock(&rt->tb->lock))
>  		return restart_syscall();
>  
> -	if (!rt->nvm)
> -		ret = -EAGAIN;
> -	else if (rt->no_nvm_upgrade)
> +	if (rt->no_nvm_upgrade)
>  		ret = -EOPNOTSUPP;
>  	else
>  		ret = sysfs_emit(buf, "%x.%x\n", rt->nvm->major, rt->nvm->minor);
> @@ -342,6 +340,18 @@ static ssize_t vendor_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(vendor);
>  
> +static umode_t retimer_is_visible(struct kobject *kobj,
> +				      struct attribute *attr, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct tb_retimer *rt = tb_to_retimer(dev);
> +
> +	if (!rt->nvm)
> +		return 0;
> +	return attr->mode;
> +
> +}
> +
>  static struct attribute *retimer_attrs[] = {
>  	&dev_attr_device.attr,
>  	&dev_attr_nvm_authenticate.attr,
> @@ -351,6 +361,7 @@ static struct attribute *retimer_attrs[] = {
>  };
>  
>  static const struct attribute_group retimer_group = {
> +	.is_visible = retimer_is_visible,
>  	.attrs = retimer_attrs,
>  };
>  
> -- 
> 2.43.0

