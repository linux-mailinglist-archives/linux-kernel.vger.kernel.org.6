Return-Path: <linux-kernel+bounces-284308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C269A94FFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D551C22EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DFA17C21C;
	Tue, 13 Aug 2024 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVGAzPRx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E417B4EC;
	Tue, 13 Aug 2024 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537292; cv=none; b=aHtXNbDxmvyQOZ16t/fgt//oDllxWAFBWz6750zj5LLAl0LI/aLV7CMcgqyel1BquW3X9ssADFD+DtTG1SekHnbqj4iiyI7lBmaKJhSWguk+aZrFQQFWDTB2oW3vRwXSXveDpjqA1VISQonB6+ndVx4E9PPibUNmiryYJqJEu0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537292; c=relaxed/simple;
	bh=hfP+klCJIbRMUzY5y+T4cr2E0QYjMW7xsiUC1CPXZNU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n+Pz9RXbrVNYBOyK4Ctn4rqwCWWJgo/bmD+vSh6+dwWb8F1itswMgCaWvfObMtsPPBzmXePHg+bj2g5hEvB5h4TSZtyxp/fdO0Eu52jHUTX94XOkNW4/r8A7N1xem+9v0+fYpu4pEWFPWKA+F1RqJADZIHxRNfYOAOGZXK4cJ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVGAzPRx; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723537290; x=1755073290;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=hfP+klCJIbRMUzY5y+T4cr2E0QYjMW7xsiUC1CPXZNU=;
  b=UVGAzPRx5K0f2G5I/xdn6pxGY9+E/SmijWadXBwra5A+HPoNWpkDb1AA
   JglCDdouh7D6uIDnX/SR64vLiAzhaDRF2v4Pu5edCFeSPOkDM3BbUH33i
   FMeUCj+R7BKZFun1j3Jhqd6eGvhEOxUP4Y/0xNUPp2k2pjEn4WbQbHPTm
   sMgFgv3igMPgxJNKtjiJeII/m6/WC6RHxfeQ/seTYpJC1QxQ0Uf6Yd8g4
   n63U9Xut30rWYLG5Z18harcOmYlC871rqGjJaMMWvcO2+fSr4jv8UOcmX
   s5GOJaMbyeOZDpoqXOa6AWrh7ITKvCsaBSmhgHCDncosXvDuWQT4lh40H
   w==;
X-CSE-ConnectionGUID: lvGPh9inR+mkBIipT8BxBQ==
X-CSE-MsgGUID: tBidvHmvRpSjAA8l/cNPVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21327823"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21327823"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:21:30 -0700
X-CSE-ConnectionGUID: N76Oda6bQlmZjX9ZCeutRw==
X-CSE-MsgGUID: VAEWTBguTFGF3tEm513tfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="81817263"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.153])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:21:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Maximilian Luz <luzmaximilian@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240811131948.261806-1-luzmaximilian@gmail.com>
References: <20240811131948.261806-1-luzmaximilian@gmail.com>
Subject: Re: [PATCH 0/5] platform/surface: aggregator_registry: Add Support
 for various devices
Message-Id: <172353728282.2056.13578794179710168032.b4-ty@linux.intel.com>
Date: Tue, 13 Aug 2024 11:21:22 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sun, 11 Aug 2024 15:19:43 +0200, Maximilian Luz wrote:

> This series is basically a collection of SAM device enablement patches,
> for which I only now found the time to clean them up end send them in.
> It adds Surface SAM support (enabling battery status, keyboard,
> touchpad, and more) for the following devices:
> 
>  - Surface Pro 10
>  - Surface Laptop Go 3
>  - Surface Laptop Studio 2
>  - Surface Laptop 6
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/5] platform/surface: aggregator_registry: Add Support for Surface Pro 10
      commit: 9c8e022567bbec53bee8ae75c44b3d6cd2080d42
[2/5] platform/surface: aggregator_registry: Add support for Surface Laptop Go 3
      commit: ed235163c3f02329d5e37ed4485bbc39ed2568d4
[3/5] platform/surface: aggregator_registry: Add support for Surface Laptop Studio 2
      commit: 28d04b4a2cc20981c95787f9c449e6fc51d904f9
[4/5] platform/surface: aggregator_registry: Add fan and thermal sensor support for Surface Laptop 5
      commit: 002adda09bc1c983c75c82a7e12285c7423aec31
[5/5] platform/surface: aggregator_registry: Add support for Surface Laptop 6
      commit: 99ae7b9ba047ad029a0a23b2bd51608ce79c8e97

--
 i.


