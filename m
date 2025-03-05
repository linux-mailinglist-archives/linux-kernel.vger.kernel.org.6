Return-Path: <linux-kernel+bounces-546884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E627A50026
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9279218968FD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB9624E4A0;
	Wed,  5 Mar 2025 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkK7CZ4V"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7339D248885;
	Wed,  5 Mar 2025 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180200; cv=none; b=msn87PQe/MN5/eR1fMCeUf5uhlTbMUrxuGkc0WARlaXqTRN1Tjk8cZ1z7Y+yfRwnEg2mzmArUZgmY/cKKXeIhTeJ4ysTbkMPBhwibNZhYkIaKEXkpEBfF1KdjX6BJdjBA0oqOmDou0do4rGMBIX1NNJN+uN5pGET1nboZYn1iqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180200; c=relaxed/simple;
	bh=Vf2ZdakHj8hyPkcOAJYexy+b1okFyPgd9TLAqM5lZGg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UFOdDwaU6/jjP3vHK+PTMeZzbyAEWItAEOb/S1jN7OhsstnKE3qMJLO6MLmEBehMIWS+4M4qjSUpcvI7qV7juv31oG72eos8Q3U/sUOZWUJdUvD+FxjdVhacu+flYdzMKHjZyDVX5f+YdN4MCGSLdlMLbW8m+AucYtdu2RH5LmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bkK7CZ4V; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741180198; x=1772716198;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=Vf2ZdakHj8hyPkcOAJYexy+b1okFyPgd9TLAqM5lZGg=;
  b=bkK7CZ4VbZAPSFXDiVpJMIGjKGNfidL22WiDcC8nysyUNPI5lwgCth9k
   ixFelif0hwMC+YiJJgVQzUqufTn+xLP6KOlnO0KoPyDQKCmMsEO4LvJjz
   XMTOAPurVU6bK25HgYmQz93p/oXtGhY1ltKixCiq8BdgdDhnCgeoPsdS9
   rm+7ecjqqxYn0nDuzxq9cDuyTQzL6oru09FO44x6oFinnEpZhuyJtyigc
   VbuM/4p8bRKU+mrQWRHovJ9/uO3V1pv+Rkm6bTnoYCENACbLsrBq0GbBY
   U5moQB/Zvb66ET39Cm5qQMELvkzPWHfbCo6ZiPQDeGs7rKKDDrWDpKPSp
   g==;
X-CSE-ConnectionGUID: oGgdKq+fR2meXTWUVyxgbQ==
X-CSE-MsgGUID: vQzxN3ejR0CMRPkhZ23KOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53129592"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="53129592"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 05:09:57 -0800
X-CSE-ConnectionGUID: VrLFLksOQ5qPBe3YOhgSSw==
X-CSE-MsgGUID: 7f7hQC09TbyQ+LxpUjLU9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="149445396"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 05:09:56 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20250304160639.4295-1-ilpo.jarvinen@linux.intel.com>
References: <20250304160639.4295-1-ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 1/2] platform/x86:
 lenovo-yoga-tab2-pro-1380-fastcharger: Make symbol static
Message-Id: <174118019152.7167.18327410510217708022.b4-ty@linux.intel.com>
Date: Wed, 05 Mar 2025 15:09:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Tue, 04 Mar 2025 18:06:38 +0200, Ilpo Järvinen wrote:

> Sparse reports:
> 
> lenovo-yoga-tab2-pro-1380-fastcharger.c:222:29: warning: symbol
> 'yt2_1380_fc_serdev_driver' was not declared. Should it be static?
> 
> Fix that by making the symbol static.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger: Make symbol static
      commit: 886ca11a0c70efe5627a18557062e8a44370d78f
[2/2] platform/x86: dell-uart-backlight: Make dell_uart_bl_serdev_driver static
      commit: 4878e0b14c3e31a87ab147bd2dae443394cb5a2c

--
 i.


