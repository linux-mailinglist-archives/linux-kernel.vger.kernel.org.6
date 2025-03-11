Return-Path: <linux-kernel+bounces-556615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0C9A5CC67
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B11189EE2B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7940262D25;
	Tue, 11 Mar 2025 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTOMEQmU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BED262D12;
	Tue, 11 Mar 2025 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714785; cv=none; b=DQeirSOFOrK4F2aHec4eyU4wX9U662+NzvahI7nf5uVVbJQI7W+p4jQrHy4hwsdZexanFLr/TjvEkvaMUKgsoo3Mj06Mz5l1i9c2+EDAW049EnyuHB4lB7g12LOOUz7v1ohU5RhhEWX27bTuF744mrYbGXAjUQscjk53Dp04MKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714785; c=relaxed/simple;
	bh=IeWCd5sfoCg8CSR+Iz2QRSrggMUl6XhZmTLS/YHVWME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bYBTAvwzGf7rJ0ipZ/uHYfTaM1U4Pap4vmvKKHQoGHwkbnhiTm77r3WBhvkLMm6XHkR005z6oICUOLkyU3v9EEEPMfGYyFnZnDXEmKjGhQoens6mlczZwWG9C7PSvkKIvChkV9Bpc6i1RRJObORGpKNtan92dUK7uDsA6qLjVLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fTOMEQmU; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741714784; x=1773250784;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=IeWCd5sfoCg8CSR+Iz2QRSrggMUl6XhZmTLS/YHVWME=;
  b=fTOMEQmUdidg6PP4f16/chvgxfH/lumFsHmnKyHnnSmQf+o7odDqPQMu
   XPEsPtbYmaibzzNS6lgOQJXDerKV+GC5RkvUDPcAZrw62GRCjeMLg4ndp
   kAfEmWUOWwb3QtkqFD8nuDpotONFq9HWDypAOSwfzVUNQCLT52FOF8aEO
   gaNHtzE1zFyfS5zOo4wlV2p57IQ3H91mil4KCeeA2uJqGRyeQaoBSYWOw
   MrGsvLDSqFsDxrxoiekT3pRVOHOY6AghDX/hQL3jJ1JLJMyZ5b4UXfnGo
   +OBn22xIq4ZzPzEcOMLUDQecX5P2uU38g/I2gekLfhEufS/Gsr6deJkOS
   Q==;
X-CSE-ConnectionGUID: LYblxAxTTNSIE0xCEInWlA==
X-CSE-MsgGUID: GZ3+v90GQpm0/Q9g+IORqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="54152003"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="54152003"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 10:39:44 -0700
X-CSE-ConnectionGUID: SOTPiEwPRu2EyiylX95JKQ==
X-CSE-MsgGUID: o7fWhYmURaWzIqaNoc3yYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="143583743"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.251])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 10:39:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Lukas Hetzenecker <lukas@hetzenecker.me>
Cc: Maximilian Luz <luzmaximilian@gmail.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250310232803.23691-1-lukas@hetzenecker.me>
References: <20250310232803.23691-1-lukas@hetzenecker.me>
Subject: Re: [PATCH] platform/surface: aggregator_registry: Add Support for
 Surface Pro 11
Message-Id: <174171477730.1715.10000974680416502932.b4-ty@linux.intel.com>
Date: Tue, 11 Mar 2025 19:39:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 11 Mar 2025 00:28:03 +0100, Lukas Hetzenecker wrote:

> Add SAM client device nodes for the Surface Pro 11 (Intel).
> Like with the Surface Pro 10 already, the node group
> is compatible, so it can be reused.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/surface: aggregator_registry: Add Support for Surface Pro 11
      commit: a05507cef0ee6a0af402c0d7e994115033ff746b

--
 i.


