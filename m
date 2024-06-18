Return-Path: <linux-kernel+bounces-219012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B4590C8C2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A97A61C20ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C508C20D4B3;
	Tue, 18 Jun 2024 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XXtrwUQM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719C120D499;
	Tue, 18 Jun 2024 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704835; cv=none; b=gTvwCvEHYSYVdoKpvZKHjnhX8QFR5CIa1zVsXdCU1sk1sjJVLM9A4wkoYKHHE2B/DsvapRyV9sFnlNkNxYZI+BVV0xm6BumqJQTv7BAFWylIXWcUR+Fc7DmxQLQ7e6wO8Zqz/QkXFHFZadTIUMY7U3W6NkyAPnQrGN3TWMZa330=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704835; c=relaxed/simple;
	bh=AhG8we5h4n16salK/pFbz1vkQfKuhsSE3lmMldwb1B0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q52JP4Xq5GVAkjobAeTSr520g7u90HIb1kSkhCn1DUEHpGIHR+p11+er2zCXApKKLElhNnqERQjXdRJCtkn6Wh6R2gA3s/fWsBDgTyFNojdlvi/2QOAQE21O3dhQPma90LlYKG74ShA8qjTs/AcsmOlQ7Fq0xNNd2YlnccNzGBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XXtrwUQM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718704834; x=1750240834;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AhG8we5h4n16salK/pFbz1vkQfKuhsSE3lmMldwb1B0=;
  b=XXtrwUQMJxIEc5ayb7sHE83WwQtu45EmXz6X8p6XdTtVPbvBgntLEVg9
   JTY8owfO4l0u40PZeWcAeeDQ3GBLj7RnPyyaqxQiSHLQWTijPiK97Khxk
   uGKb4EwrnCXdE5XCVOlVyfZsqzNBF4ShqTvkCYNFLHHbASCZE9t7PBk4w
   /nFwI0CtUPyj/d0NFIONOim98xcjffdMp6lGax6Ed2zaghP2wN6nSkzGb
   Wn5H99at0IOwPuYTqEm/RM63vOM5TmpKQJ720a5iU023eeT2R/g3nGvZt
   K45pwbeC0MrWsLXaU6qbG0PSfvGQiHSFEOVQSIeLn92vhbPtr6PPZmIFZ
   Q==;
X-CSE-ConnectionGUID: Gfq5efqDQOKZB1j4kU0tDg==
X-CSE-MsgGUID: XrlY1h7OQ9mnIwtPwGkA+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15696453"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15696453"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 03:00:33 -0700
X-CSE-ConnectionGUID: F1Nn4x6sRmWlwDUi/9ynAA==
X-CSE-MsgGUID: Y64T+9jPStyNsUfix1hHzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41352989"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.7])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 03:00:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 18 Jun 2024 13:00:26 +0300 (EEST)
To: Tero Kristo <tero.kristo@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, srinivas.pandruvada@linux.intel.com, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 0/7] platform/x86/inte-uncore-freq: Cleanups
In-Reply-To: <20240617060708.892981-1-tero.kristo@linux.intel.com>
Message-ID: <1c180de1-0cad-82c4-b7e9-d951331725d6@linux.intel.com>
References: <20240617060708.892981-1-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 17 Jun 2024, Tero Kristo wrote:

> Hi,
> 
> This series introduces some cleanups for the code and driver level APIs.
> The purpose is to improve the maintainability of the code and make it
> easier to add new features in future.
> 
> No functional changes expected from any of the patches in this series.

Nice cleanups, thank you.

I've applied these into review-ilpo branch with the following 
modifications:

- I fixed my name on Reviewed-by line. Please don't corrupt my name if
  handwriting a tag instead of copying it. While I don't care that much
  if my name is not always written 100% correctly, an incorrect rev-by 
  line causes my tools to add the correct form one so the rev-by line 
  gets duplicated (luckily I was paying attention to the non-critical 
  part of the output of my tool this time around so I caught it).

- I renamed _min, _max, and _value variables to min, max, and v, 
  respectively, because the reason for using underscores got removed by
  the change.

-- 
 i.


