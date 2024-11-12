Return-Path: <linux-kernel+bounces-406409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DC39C5EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4CE28335C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468A22123D9;
	Tue, 12 Nov 2024 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYeiuo2/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A4020D51A;
	Tue, 12 Nov 2024 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431840; cv=none; b=HjYx0RoyHawfNfIiK9LyCU+FhiQ7onD/HSWzgyF1QDgx9h0BjVax40abrSwG4Xyv7QnanMUcNGA8wUN23cfUKiiU1BC/CsxwsbouJU3TeP9fSMWKCycWpVYE5h4DrHVGCjHy+OslYzFn9hktbmYxSH54aSdTLqqBZ9g1i/NYDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431840; c=relaxed/simple;
	bh=HGzPPuT/0kXFNgvNGXBwULpCnuRiJXROhPsz7b7L/9M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W+FrdTh3C2Kxr9tCXIuaGWAw+wIko9UfrL0584hyAAs3tUoZ4KIGPHbMvzLpsJxSblQ9e+HzookxPhvQTS0226L8mwU2jN5aKNDdzkFyG7dCN0meqWAdiCEKmnj92TPGINNS07SjC0BMOJfLqn3xv9I20hPDA/4eXdhxtn/jQR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYeiuo2/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731431839; x=1762967839;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=HGzPPuT/0kXFNgvNGXBwULpCnuRiJXROhPsz7b7L/9M=;
  b=DYeiuo2/Ub7wz3LdP0Akj9o9H6llSLVPzNuEN61Hm3bRBY2ZnHOPbU8R
   4P+F6jdnC6XcgGXwkKOdaNNW1ynqJY0ILLZZe2I4u3Y4fb/hcBTlDkmEp
   WPFEeFBnT6I5A75UpXv6WrMaKnEaY6g6ThBhqjlupMmPLZE+MzDTiNat/
   TQx+qx5l5zYbqSfDLrEKGhXkSv6EvMy+D5o4kbUTBqQz5GCk/ReUpJpso
   NQ2fnvZuWVjj8XBGChS1WIbzFLrWx+CT/W/lO9Hvcxbb6N3TpicLac2m+
   G6zptUkLiyRJAO3agMJfBuR3qBp5xPBw30pEr4k44la6uA7v7/wQoGcZN
   A==;
X-CSE-ConnectionGUID: 43P38NNUR0CTPfLyEKovGQ==
X-CSE-MsgGUID: 6uHEAdKVSgiWu2CuCcPpgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31157121"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="31157121"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 09:17:19 -0800
X-CSE-ConnectionGUID: pFiGNtS5Qui19BuzzUxlnA==
X-CSE-MsgGUID: IKwhAHedTWeFE8hhQKAj/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="87141262"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 09:17:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241111185456.331071-1-srinivas.pandruvada@linux.intel.com>
References: <20241111185456.331071-1-srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] MAINTAINERS: Update ISHTP ECLITE maintainer entry
Message-Id: <173143183174.3180.10471321140800311706.b4-ty@linux.intel.com>
Date: Tue, 12 Nov 2024 19:17:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 11 Nov 2024 10:54:56 -0800, Srinivas Pandruvada wrote:

> Sumesh K Naduvalath doesn't work for Intel anymore. Adding myself as
> maintainer as this is related to Intel Integrated Sensor Hub, which I
> maintain.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] MAINTAINERS: Update ISHTP ECLITE maintainer entry
      commit: a8e03d821d6a72a72fdc0ea1809a21e815a3fd19

--
 i.


