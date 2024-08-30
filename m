Return-Path: <linux-kernel+bounces-308491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4AF965DAB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08ED286CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D29170A06;
	Fri, 30 Aug 2024 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mTZcP1KG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95C013A261;
	Fri, 30 Aug 2024 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725011933; cv=none; b=Z+NRFgVjoJ81yWQjNxxFU4yWMgVeEbLrnR6WPStQ3PboPo3YPHPLWklLqcWM7UZiFbiulZ+7PFOIc6L+mWBP+MNJGVprH3FTRqhoY4XPx8iSA9XH19P7Ykpqai8tN9Rjkg54lpcdRkQ8AEesRJTDLYFePkH0F5rbdxP8AIQejMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725011933; c=relaxed/simple;
	bh=hNcWXKXPljKMMTaiuj2FwIzf/cG9xCpa3MYHuuKBZAU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BprJJZRWZf82xNwqNxJBjc1MMjPipYLPvTsI4GW33Hx2QAKZIzgxv6WFRAtdDzXzhUBes4LiCTFXsYITVd6IsS0NtjN91r68gKhosNEVum/WjdoSVPQl80VvyzTgxwfoFK2lKUwdFMz2xgLDnnMeOmiHh32NGhZ3iy5z7/8zPVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mTZcP1KG; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725011932; x=1756547932;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=hNcWXKXPljKMMTaiuj2FwIzf/cG9xCpa3MYHuuKBZAU=;
  b=mTZcP1KGMObAdF5oMOZvSA8Ms9K37E7q+8caMkrhH+l6Zd9Fuadk3om+
   eSBEyCHp4XTcroMBAYhYrX3Uvx2rwa2WpEPhubOu6Z3wg0V2dTCkaBaxD
   y/FIs83rRKh6vPOPw9pHlP5V0jfoxeWu8VgBbfPBHeikns5uhTfiKElo1
   9u7DwV0GbbplLTeRKC1lLUZfoCRzoRLO9qSHkvtgNd1pfF5YQsnJWcRWx
   JFLFldWK+OBsFlPx+z9HP3FAqZQ4mhx40v+bIP2/XMiZkWNkO6v5vNTC8
   VMKZaAcChnuLcfclcpyTMuq6gkYFrqEG/rKTR4BJWGy9do9T/SotUlKXf
   g==;
X-CSE-ConnectionGUID: YCyeyG7ESG68K315hRvyeQ==
X-CSE-MsgGUID: GmMLD9P4QrqXi7vS+OZaAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34217070"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="34217070"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 02:58:51 -0700
X-CSE-ConnectionGUID: 20VvXWCMRHSGH2lcjaBWFQ==
X-CSE-MsgGUID: 8Y6pJx6GRQuRvaF2FEWXhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="63478010"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.174])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 02:58:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mario Limonciello <mario.limonciello@dell.com>, 
 Aleksandr Mishin <amishin@t-argos.ru>
Cc: Hans de Goede <hdegoede@redhat.com>, Lyndon Sanche <lsanche@lyndeno.ca>, 
 Armin Wolf <W_Armin@gmx.de>, "Darren Hart (VMware)" <dvhart@infradead.org>, 
 Edward O'Callaghan <quasisec@google.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org
In-Reply-To: <20240830065428.9544-1-amishin@t-argos.ru>
References: <20240830065428.9544-1-amishin@t-argos.ru>
Subject: Re: [PATCH v2] platform/x86: dell-smbios: Fix error path in
 dell_smbios_init()
Message-Id: <172501191967.1828.1763222607712237074.b4-ty@linux.intel.com>
Date: Fri, 30 Aug 2024 12:58:39 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 30 Aug 2024 09:54:28 +0300, Aleksandr Mishin wrote:

> In case of error in build_tokens_sysfs(), all the memory that has been
> allocated is freed at end of this function. But then free_group() is
> called which performs memory deallocation again.
> 
> Also, instead of free_group() call, there should be exit_dell_smbios_smm()
> and exit_dell_smbios_wmi() calls, since there is initialization, but there
> is no release of resources in case of an error.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: dell-smbios: Fix error path in dell_smbios_init()
      commit: ffc17e1479e8e9459b7afa80e5d9d40d0dd78abb

--
 i.


