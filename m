Return-Path: <linux-kernel+bounces-205924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0DA900238
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB94A28550B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22C6188CD5;
	Fri,  7 Jun 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fGJPZJKX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F561527A4;
	Fri,  7 Jun 2024 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760021; cv=none; b=u+2mpFVjysdZ5aHS2U73blLoqRFQyShHkF6b0C2eSDtoHng5mDDf7JxVqUKIjFP1qzFoPw0VPlDLeHcp1B1MzJNhmDY8vOSk4dN1f3Yf2LT5tHrBHTMY65vYRRsTkCuXN4m0TF1WGqCB/fMv4rKSBLv77TA0QM09rzVCBuqyWLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760021; c=relaxed/simple;
	bh=lmeLmrkt77xAEI5HQicNk9Kh8JwT3RwO1QyYGKfkfBI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=r6tGhcCIbHwgD0eR8JPBvCkKccyq5j5kRD33A92eNfibDgph/A73FN3EHyOjhiDSfY3h3NIioEudUjuuSwr5C0xYUGR4M0aTsGaDSDLBn02kbgM89YlQjDL1kY5pY+oTOvlyN3HcPIaxZq1krBCUu8pc60LuebutSeKJJnyu/iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fGJPZJKX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717760020; x=1749296020;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=lmeLmrkt77xAEI5HQicNk9Kh8JwT3RwO1QyYGKfkfBI=;
  b=fGJPZJKXdNx4a3Yf7d7BmgVBxiRn3BxNPF5w8AwJGZ3WNrlQvxsPrMQ3
   OK1OabjF8OWfXLKu+tIuVxk9cT2jd9HlfzsmQBZF67sB2bQ5MU4Atkdnm
   r2HXDR1nUN0iKHcqtBoI549JdCAs/jOqSSFdqXpooJUjlVwZvjcZYaFfh
   aB8N4bIdmyitqaFbQnu4OixbisSwNz2esQHBldL/IwxnBHfc4D1MbDxYg
   DY7pVKYtMlGKFvqnRn+23UAqSLemnMv4h9qvh731fxverOxIlfI/53O1p
   BPPrwilBjFETWl57DYpP/pIz8dN4PGhIMA7dMwkFFSFkdOFaXnmlbN8Ev
   A==;
X-CSE-ConnectionGUID: l6N/GdbpRAeuviwOK97tsA==
X-CSE-MsgGUID: wHHwzHHFQiqjjvDY7EoQrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14610292"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="14610292"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 04:33:39 -0700
X-CSE-ConnectionGUID: 0sb3C8dJSw2yMtJ/h7scvw==
X-CSE-MsgGUID: KMkrV5kqQP6Cs5lyb23+Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="38234611"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.184])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 04:33:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 7 Jun 2024 14:33:32 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: matan@svgalib.org, agathe@boutmy.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] platform/x86: lg-laptop: Support 2024 models
In-Reply-To: <20240606233540.9774-1-W_Armin@gmx.de>
Message-ID: <99d78b65-2257-ea3d-3368-4e794f68296e@linux.intel.com>
References: <20240606233540.9774-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-763177767-1717759999=:1044"
Content-ID: <11aac74b-6a20-49cd-b921-581e43af0881@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-763177767-1717759999=:1044
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <e270cf5c-c038-852e-977c-56b51ecdf42f@linux.intel.com>

On Fri, 7 Jun 2024, Armin Wolf wrote:

> A user complained that the lg-laptop driver does not work on 2024
> models like the LG Gram 16Z90S-G.AD7BF. The underlying reason turned
> out to be that the ACPI methods used by this driver where not mapped
> under \XINI, but instead under \_SB.XINI. Those ACPI methods are
> associated with the LGEX0820 ACPI device, which was not used by this
> driver until now.
>=20
> The first three patches move the airplane mode hotkey handling out
> of lg-laptop and into the wireless-hotkey driver. This necessary
> because the airplane mode hotkey is handled by a different ACPI
> device (LGEX0815).
>=20
> The last patch finally fixes the underlying issue and uses the
> LGEX0820 ACPI device to find theWMAB/WMBB ACPI methods.
>=20
> The modified drivers where tested by the user which created the
> bug report and appear to work without issues.
>=20
> Armin Wolf (4):
>   platform/x86: wireless-hotkey: Add support for LG Airplane Button
>   platform/x86: lg-laptop: Remove LGEX0815 hotkey handling
>   platform/x86: lg-laptop: Change ACPI device id
>   platform/x86: lg-laptop: Use ACPI device handle when evaluating
>     WMAB/WMBB

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.
--8323328-763177767-1717759999=:1044--

