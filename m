Return-Path: <linux-kernel+bounces-358970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 574AE9985DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB4D8B223EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED6F1C5799;
	Thu, 10 Oct 2024 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aD/6Qcgt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C11C462A;
	Thu, 10 Oct 2024 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563152; cv=none; b=g/F9Fv/+DqgB0pcAT4IlyyrHLauQ7/n/SdnBYlhW25VxlLgDsph6GJPOLeirBipzr9NTHDNnIWiAewDFjJiA5iaZhioHT6Aav6D/ntG48Z4lv1f1/nRWHxCZJo+eZmQelXl+RuulMj8ltLWDhbGIhY+3YfJIP8EZg6pW3S4o2Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563152; c=relaxed/simple;
	bh=nm09FEO+6GkoggqETkjCn/NtWaoWHclU9qh4LQ4l3lA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FfiXFAS4KsnSWEp5o/2lirRq+0HEuPpQ0/a2HfUxe1BAv8ZlwhQx5siCBvWJv8HxsqpRmkxt+EXzLFuV66W8CyxfZn8YiO+yE9AEj1tezj6CIuvEl/Xqwj6OTd+pWUr0Q8PDt6EWc4wMIuDo7hzYo55ennVH4X9Be3gIN0gSd7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aD/6Qcgt; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728563151; x=1760099151;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=nm09FEO+6GkoggqETkjCn/NtWaoWHclU9qh4LQ4l3lA=;
  b=aD/6QcgtszNQ1RX1galZmpejq5u0hX6FxU6GIL5xomF3DQAamWoTdNja
   9lOTzg2n+iZtRHTOFyGDKnX1eBOUY302FIuPqfUdMO51NEVZDI4MfHqjn
   w4N/23g5bZs1aBnG2bGcJTjkR9hF4TAryfAkxVCK5wdOnAN/gUFgEbULj
   zMkd7t1kfQQ5TiPXi0WgDgIIhfYCH/B0WtvWkjap/bPTAg6lhAJusSRlh
   /dN/oz4SAq+n+eQ7FovWjxG5CtzPQVTdDAooRPjjGemtHIzfzCkxH5Bpo
   3Umf1RKJ7RHaBoWaT5n2DRDma9qOPUpJiLyp1jwlbQqyHOtNTVEiUt3gp
   w==;
X-CSE-ConnectionGUID: FLaz3lFvQz6jIKn56G18zA==
X-CSE-MsgGUID: 5x2LWT66TpuWsJ4MtT2Gbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27386099"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="27386099"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 05:25:50 -0700
X-CSE-ConnectionGUID: 6G2iYIBTSuSMPhLP6gUiIQ==
X-CSE-MsgGUID: 3ppPgMquSvWf9SZHSP9sog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="99913528"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 05:25:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: corentin.chary@gmail.com, luke@ljones.dev, hdegoede@redhat.com, 
 Abdul Rahim <abdul.rahim@myyahoo.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241009230558.51892-1-abdul.rahim@myyahoo.com>
References: <20241009230558.51892-1-abdul.rahim.ref@myyahoo.com>
 <20241009230558.51892-1-abdul.rahim@myyahoo.com>
Subject: Re: [PATCH] asus-laptop: prefer strscpy() over strcpy()
Message-Id: <172856314314.1946.14702947705883158463.b4-ty@linux.intel.com>
Date: Thu, 10 Oct 2024 15:25:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 10 Oct 2024 04:35:58 +0530, Abdul Rahim wrote:

> The function strcpy() is depreciated and potentially unsafe. It performs
> no bounds checking on the destination buffer. This could result in
> linear overflows beyond the end of the buffer, leading to all kinds of
> misbehaviors. The safe replacement is strscpy() [1].
> 
> this fixes checkpatch warning:
>     WARNING: Prefer strscpy over strcpy
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] asus-laptop: prefer strscpy() over strcpy()
      commit: 8150408bfdb2f9c17970295427cf91470189e6d0

--
 i.


