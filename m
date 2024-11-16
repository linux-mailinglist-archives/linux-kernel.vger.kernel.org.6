Return-Path: <linux-kernel+bounces-411774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206499CFF66
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 16:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B1B1F22D6F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB42F18052;
	Sat, 16 Nov 2024 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KriBF2km"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19827D515;
	Sat, 16 Nov 2024 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731769420; cv=none; b=rtBIoew2YJFuzqKEK818D+auXMtY+SxpdG0WbuUyDD3AsZIgYvWtG+notCW9J02NImEIvD7HBRzQDwZ2LJ9oEKiLu6e204USCEc8/huFhsLuTyS6ATylRZXZqIwmk91lbaNciXqsGhUHkAwWYqXhSnDNDSOqoDr22NNWSj4/wLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731769420; c=relaxed/simple;
	bh=NTPxabpvESPhRXzLMftp5Cp8UwSPOsil8d8sr9batis=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h/2bB1EJnh5LGTxi638rPMhytbH/DMVXONPQu0gd8RkAE/gCgxkDkj6CWY+cdEBZLmC2rD60rD/MyPiUl7kDVfeOoOjdO6ue+jdVz0brW6rT0kVI2BvcD2QYH0X4CcQFuWj73ZRZQJTxPSC8u2/jbmzsMhONFx/WEevB2bvrHVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KriBF2km; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731769419; x=1763305419;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=NTPxabpvESPhRXzLMftp5Cp8UwSPOsil8d8sr9batis=;
  b=KriBF2kmYFBxRW4lg9vwGdU4PY7waQO7Y5Maneo2/KZ0uOou2JEC3/4/
   4FYZ5DyFDxHMpjy/x60zlR9ZUXQghcb+zsKnvKNZ6vPHFwdYybnhyzfRA
   /m+csdPiHJ5Vp2wRzkEaHyhce9KR9074rbuPGTbS3afXx5H2oA9XkCCd5
   LkcwMBVX8S4jo2BV90B1L5zYZXmFgy+vN1VJZGREiGPZ+N9G4TSNrGUW0
   dWXMqpHFpeQp1yjG+80hMUX0DVPuFlFc6L/SVjPJi8p80aVw8yJV6FLeK
   qoGesk8024UikaUN6tVFy00dkTWYcodcbNf0Kr1q3PMOVwwbXusET1O4B
   A==;
X-CSE-ConnectionGUID: N6P4ugJRR56/0FmsTryJSw==
X-CSE-MsgGUID: lN/Ler1TT+iKr5B8C7SzXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="43163392"
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="43163392"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 07:03:35 -0800
X-CSE-ConnectionGUID: lXVhT8voSkW/pEwPVQbeqA==
X-CSE-MsgGUID: E1bd3GhxQjySZ/zKYgAVcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="93760651"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.42])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 07:03:33 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: w_armin@gmx.de, hdegoede@redhat.com, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com
In-Reply-To: <20241111183308.14081-3-kuurtb@gmail.com>
References: <20241111183308.14081-3-kuurtb@gmail.com>
Subject: Re: [PATCH 0/5] Better thermal mode probing + support for 9 models
Message-Id: <173176940782.1711.698562469347976245.b4-ty@linux.intel.com>
Date: Sat, 16 Nov 2024 17:03:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 11 Nov 2024 15:33:10 -0300, Kurt Borja wrote:

> I added models for all the acpidumps I could find. Also I find a way to
> not brute force create_thermal_profile and that's always a good thing.
> 
> I hope you all have a great week!
> 
> Kurt Borja (5):
>   alienware-wmi: order alienware_quirks[] alphabetically
>   alienware-wmi: extends the list of supported models
>   alienware-wmi: Adds support to Alienware x17 R2
>   alienware-wmi: create_thermal_profile no longer brute-forces IDs
>   Documentation: alienware-wmi: Describe THERMAL_INFORMATION operation
>     0x02
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/5] alienware-wmi: order alienware_quirks[] alphabetically
      commit: 2b8dc45b8ca31e3a0ed1d71cfc042b9b7af85dfb
[2/5] alienware-wmi: extends the list of supported models
      commit: 1c1eb70e7d235f5feb7b68861637a5fd0b52a9fd
[3/5] alienware-wmi: Adds support to Alienware x17 R2
      commit: 01bd181d21cf65e43f30948f9216571218732a12
[4/5] alienware-wmi: create_thermal_profile no longer brute-forces IDs
      commit: bfcda5cbcdb642a64d5b8a0229842dca7917ac6e
[5/5] Documentation: alienware-wmi: Describe THERMAL_INFORMATION operation 0x02
      commit: 6674c5a0eeb55143cd10514d0083624e056e7d13

--
 i.


