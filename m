Return-Path: <linux-kernel+bounces-447810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E017E9F374C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33BCA1886AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18954205E31;
	Mon, 16 Dec 2024 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKPoFGHO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065B9204573;
	Mon, 16 Dec 2024 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369447; cv=none; b=pKxV0FRsEuftpmJE98+RuvJqn+xax5YjD7ocA1v+6w3+OrQky6GWPjsQAHYJAIWMsGY+oacFYCoh8x81LNhcai8wni0rq3iT8cQxLx5l+1c6GD+Hz7GypXZ5E309u7VUqhs9yHJ8LuT+XEQ1/FIjlyivPjup4u2M8XqOXvdCLoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369447; c=relaxed/simple;
	bh=+Sw4d76FX88JaJ01fe11KLu5i7IHpBu0QI4QA4OLGLY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Iffpt673mNk6LJ3jQIjCn+0TWGydlSQPNOE8dJgPAoSEOCLSHfokW780bV6m9nVTmgQhWAQUT+JIRbcEMNxGTujPTovJQb96xMW8Fz5ZHNQV1IREQIJuuK1qYIAkrXpUksWBAqMfpYUjusJzEj/gcgGCd+IpcVR5rDL1is+srGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKPoFGHO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734369446; x=1765905446;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=+Sw4d76FX88JaJ01fe11KLu5i7IHpBu0QI4QA4OLGLY=;
  b=KKPoFGHOd79ADf7Sn2OEJR1rNm0MrDC3OZ+SzzptE9f3ty9P7Tytn0mF
   30ABcsoKH+YkM3H5HqFgA56kRo6RIHXaKKRCjPZr8UPA4SmclpdMHnIs5
   /gnYOaVBzKy6kYc0ao/DRoyX7fe5hLGoLczzk9mlfj/0H3ctMMwm1RYFw
   GOD08b72AP7vn9yAWQV+K0UdTpMeYtYhKO6MYW1ufN4eG3GLpxLAz579h
   IbSpIMK7FUyFFjuNhq5/HAMdRWEd3QTuidDH4+TYms7jym0d91umvLYz7
   CRzunO57Yu4SSYbSnas3MfI/+g+i+cVo3ScXo8nzw09I5zquqIALxF58b
   g==;
X-CSE-ConnectionGUID: YiKDCeqrSnyeobi1Lu8FcA==
X-CSE-MsgGUID: /LVsSpXzRt2kPZx3ByCwcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="46156576"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="46156576"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:17:24 -0800
X-CSE-ConnectionGUID: ptg30/+CTd6F5TRXkMMXYg==
X-CSE-MsgGUID: v0Yw8T11Q5mDU9xTtQaXYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98051775"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:17:21 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux@weissschuh.net, Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241206215650.2977-1-W_Armin@gmx.de>
References: <20241206215650.2977-1-W_Armin@gmx.de>
Subject: Re: [PATCH] platform/x86: wmi-bmof: Make use of .bin_size()
 callback
Message-Id: <173436943618.2913.18179554039365422820.b4-ty@linux.intel.com>
Date: Mon, 16 Dec 2024 19:17:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 06 Dec 2024 22:56:50 +0100, Armin Wolf wrote:

> Until now the wmi-bmof driver had to allocate the binary sysfs
> attribute dynamically since its size depends on the bmof buffer
> returned by the firmware.
> 
> Use the new .bin_size() callback to avoid having to do this memory
> allocation.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: wmi-bmof: Make use of .bin_size() callback
      commit: 2e6be3376e689b9021a9619e03e3bc0d195c4235

--
 i.


