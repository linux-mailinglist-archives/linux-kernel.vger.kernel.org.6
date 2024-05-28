Return-Path: <linux-kernel+bounces-191981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 410D18D16D1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9222829DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727E113CF9C;
	Tue, 28 May 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BnkMV9hv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D5B4F1F2;
	Tue, 28 May 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887023; cv=none; b=sKl2EYB3kI1bhAxuttj/6A2KUN45BjlosIVAMfq3NgrgYO4mHLn4RQgt9JeQ92qhu9QhBwemzXq7Glok47J0cNVK7/mpfeLD0Ee5leAywaxC9RZqIWn88C+lqhUAgWpbCmsaP+xYELjMunMPEW5hHWV0eZAWAuC1eWJflsy7B24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887023; c=relaxed/simple;
	bh=teeUheOljqFb2hcomKXmIJhytknDsw4tjSuKwHD03RQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=I5qTfAZY/ZvWr7tIGLofPQDJx/cSWbE9YXjneejIw75XqrFFBuoKjbixv1Gm2PWNTWeELjOue081a0blpAH47K2NM/bwcuFCom3vJ43sCdkxS9zKcgrNdPAn4PhtidRCOkLdm40THwfHJWGiGwhdPB3hmVLKxAP/siQq5NmcgB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BnkMV9hv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716887022; x=1748423022;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=teeUheOljqFb2hcomKXmIJhytknDsw4tjSuKwHD03RQ=;
  b=BnkMV9hvziyxZgBOwjb1xKDVjeZpetz/pp5u8FDEjqJpqS9C87BSVnyW
   9YAklou1NRKz5aBDpd46k/ffgpGb++NvAqd8uyXsNjHxDr3dhEn2PIGf5
   jkRqTw+nLvC8id/Woe1IRoCSXzWMnyL971ZDL4DMHQoIdAep0bUrVsILi
   fb1jx9aFPdvgNmoXBJuuS/oCxGqxlUHSLuyVrn58ItqinkkZ17VLu102a
   uhCrfVHepW6q5kKhHCCSitmhBgctorubzAeTcNUvowY1JpWbr2l4aaKeC
   K+Z4ThQx3HBQCYA8J7eoFmB1PSlwWaLR2zxBgFlB3xHsEnoJNZ9Kvl3Ow
   g==;
X-CSE-ConnectionGUID: DHuXWic1SIqnfJyTXcK4NA==
X-CSE-MsgGUID: J8c4IKlMTNWRcgc/iJXxiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="16167055"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="16167055"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 02:03:41 -0700
X-CSE-ConnectionGUID: aNvGzNnlQiyaDyNsUFfnSg==
X-CSE-MsgGUID: 2nPZbomLRrmleX2j+hiozQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="34991828"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 02:03:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 May 2024 12:03:34 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] platform/x86: asus-wmi: reduce code duplication with
 macros
In-Reply-To: <20240528013626.14066-5-luke@ljones.dev>
Message-ID: <f07c4980-9adc-96a2-4b72-c5db850e44c2@linux.intel.com>
References: <20240528013626.14066-1-luke@ljones.dev> <20240528013626.14066-5-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 28 May 2024, Luke D. Jones wrote:

> Over time many default patterns have emerged while adding functionality.
> This patch consolidates those patterns in to a few macros to remove a lot
> of copy/paste, and make it easier to add more of the same style of
> features in the future.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---

> +#define WMI_SIMPLE_SHOW(_fname, _fmt, _wmi) \
> +static ssize_t _fname##_show(struct device *dev, \
> +	struct device_attribute *attr, char *buf) \
> +{ \
> +	struct asus_wmi *asus = dev_get_drvdata(dev); \
> +	u32 result; \
> +	asus_wmi_get_devstate(asus, _wmi, &result); \
> +	if (result < 0) \
> +		return result; \
> +	return sysfs_emit(buf, _fmt, result & ~ASUS_WMI_DSTS_PRESENCE_BIT); \
> +}

One more thing. To improve readability further, add also normal newlines 
into macros like this (obviously with the continuation backslashes far 
right as already mentioned).

-- 
 i.


