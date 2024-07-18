Return-Path: <linux-kernel+bounces-256133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AF2934988
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352981C21C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2057578B60;
	Thu, 18 Jul 2024 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCdJAACV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5AF1BDD0;
	Thu, 18 Jul 2024 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290022; cv=none; b=McLJy/H/ob3Kc/dpiEOxj1pIxMeHqAfwqvjYg71Ln+rtZtHcS0iqlaGXvdXuLWlyvETJmSui2daBXiufbXqvVTHTeZKRx/28TuTots5grl2PhA9gS0QcyrnFJ+ehyyZkcXRgodvHbQm3/W1whwgEcaUenbYbzAiSX9wEp8Q124M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290022; c=relaxed/simple;
	bh=wnRuSTdKIbDNjaks3CW4d+zeKSfYQX2gNoliQr3r92Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fVfLMwe5MnW4rYw4e4Io/zoncVqin2ESgtoGB/nYYXhyRfl7s81hRAdmfvuIhA5CikJvNwRIbZUwaeBsfZ25U7so/QqjTc0QRDZOboy7Q488JbsohYRdQgRSufdF8Q4prdf8LeiOG7h41iikCpFgcVZ4TDGi6K9NtNi/94D4ia0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCdJAACV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721290021; x=1752826021;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wnRuSTdKIbDNjaks3CW4d+zeKSfYQX2gNoliQr3r92Y=;
  b=dCdJAACVTjVd4IXpeOIv5aApc++P73/35RNGPx/CXa9TQDvrX0XaJbY0
   Vi9XIZj238WDao/CHXyOPL/Ng9AUpxqlFuAI/ymgfpK/o8XY7mVZGefde
   1ESu4XjJMt1bo2ey0Z4mGuFkE0J2Q6Po4fdcWtAMIoQqVk6vRwIZJpbrs
   9kC5NXMq8fFvcjOG0WQk1r26H6oUC3hiSZ2IGjUYacGxnm2wQq9Vq9qUP
   eud4P3a0avaB7z9R2a8phyrcynITgxmzGTTQUhjasoACQE+CEFtJB0hDQ
   VRNEZ6L8iuGTSNruTHoEeY+FDFK6y1s/AF4yZn9pZdR815gKpD2iOUVsq
   A==;
X-CSE-ConnectionGUID: Ug7k5oNMQQyOSNQ821wDWA==
X-CSE-MsgGUID: E2+kuMQpSTm5d1gLaGrHaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="12604700"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="12604700"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 01:07:00 -0700
X-CSE-ConnectionGUID: CqKhrZj4SciWKPIq0UhHbQ==
X-CSE-MsgGUID: ECPY3HY/T1+0Wu+ZB8eH7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="50555722"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.139])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 01:06:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 18 Jul 2024 11:06:55 +0300 (EEST)
To: Gergo Koteles <soyer@irl.hu>
cc: Hans de Goede <hdegoede@redhat.com>, Ike Panhc <ike.pan@canonical.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] platform/x86: ideapad-laptop: add a mutex to
 synchronize VPC commands
In-Reply-To: <70d3957b315815085cdd8cb04b002cdb4a372ddc.1721258854.git.soyer@irl.hu>
Message-ID: <06e44cdc-b984-23ea-2d89-b4489bce2c27@linux.intel.com>
References: <cover.1721258854.git.soyer@irl.hu> <70d3957b315815085cdd8cb04b002cdb4a372ddc.1721258854.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 18 Jul 2024, Gergo Koteles wrote:

> Calling VPC commands consists of several VPCW and VPCR ACPI calls.
> These calls and their results can get mixed up if they are called
> simultaneously from different threads, like acpi notify handler,
> sysfs, debugfs, notification chain.
> 
> Add a mutex to synchronize VPC commands.
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---

> @@ -2027,6 +2053,8 @@ static int ideapad_acpi_add(struct platform_device *pdev)
>  	priv->adev = adev;
>  	priv->platform_device = pdev;
>  
> +	mutex_init(&priv->vpc_mutex);
> +
>  	ideapad_check_features(priv);
>  
>  	err = ideapad_sysfs_init(priv);

mutex_destroy() missing from rollback and ideapad_acpi_remove().

-- 
 i.


