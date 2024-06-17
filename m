Return-Path: <linux-kernel+bounces-216713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0BE90A4EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64601F21277
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7AA186E3D;
	Mon, 17 Jun 2024 06:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSEQlESI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D21836D1;
	Mon, 17 Jun 2024 06:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718604438; cv=none; b=EATalrRHjEUbExSV7HyEDO7t/lpqUQ2ffavXXtpxojYY1EjdJxAj+Kix9xkH13Ak9u1N9aH9jhKCZz9Dcwhq7l23rO5pPkGnLKcMmJMLdmESYeSSudARO9Ziwv/UAgMHkZ6J/KAEoA8yg/X8TtNqQYi9LuiLI30KxSFk0b72XpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718604438; c=relaxed/simple;
	bh=NNsPPqiSrvvuFwSe4UAIdhuXIJlWS36wlTYpAXt95ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ovQqms17BLrUrAoIOAcibGqb30srYNSxZMZPhRZtzlBOcf5t17QSWKmOUMNiWg3KZU83tYUjf7AFhT7IsMQh4VpY7RhaSAXiNtPnbU+JFFEjT+HjcjhEXjtD/2tMgGEOKxoGZAzzRkuhrmZohQyhVoqrzofF3RaSu2aGFXAADR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSEQlESI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718604437; x=1750140437;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NNsPPqiSrvvuFwSe4UAIdhuXIJlWS36wlTYpAXt95ac=;
  b=QSEQlESI9MteuLl4fVGlaHDp1cGVPxlqyV5elGX9Ynd58VzTHAWA8OXn
   7LKA2IcCBzaFGuUtv2Tjz2X0Ml1aBydq2Z8p3lRTBIagCfvU/YSggTWhA
   dmMu9Oj2N8wTrU8D0oybHxD8W5Q/1dIDuPmF0xOIp4VCaUKVGyTlT7gxH
   o95KYSkCIsFH6nuvZSRhU7+mD73qskB5wwWucUx273hH0bEQlbZHvB17E
   5A1W68aj/E/kJ6cvl51+FR4nk3gIGvH/zR0nKofUEjj8OInsUcNkZh2SS
   1lxsjTfHMpakJ7p9c7G6yJZujdfF26FNejMY7ZhVyAag4nU6briUj9ix8
   Q==;
X-CSE-ConnectionGUID: Y11t0h5CQAisbUmiMP5aNA==
X-CSE-MsgGUID: gY4R2k90S/mx6pw9dGm1NQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15138447"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15138447"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:07:16 -0700
X-CSE-ConnectionGUID: hWinG30gQIGWSriBa+NIEw==
X-CSE-MsgGUID: +0GcBE7tToKR1mbogEiH/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41028161"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.69])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:07:14 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: hdegoede@redhat.com,
	srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/7] platform/x86/inte-uncore-freq: Cleanups
Date: Mon, 17 Jun 2024 09:04:33 +0300
Message-ID: <20240617060708.892981-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series introduces some cleanups for the code and driver level APIs.
The purpose is to improve the maintainability of the code and make it
easier to add new features in future.

No functional changes expected from any of the patches in this series.

-Tero


