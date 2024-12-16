Return-Path: <linux-kernel+bounces-447812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EA29F3755
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1EAE1885A98
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306AE206281;
	Mon, 16 Dec 2024 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XV71N4K+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0FF207641;
	Mon, 16 Dec 2024 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369452; cv=none; b=by+HCVLEDFkO23PN+SPc8jxniCd31bjp9wGy9FPmorpyMuanO4l5Zri+uitT2lnUgtVF3DRhTwHwaoS8ZUgcb7KMdYQJdNTID94OAKidZ6EUb0SGE4kRtYQzlXFN3UHIBJp5CuEBo994fbj6dN8+cepYIm1RCO5H1Ce2OskQRWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369452; c=relaxed/simple;
	bh=C6bXikWwQGtJktZn7Ohoru7n07oBeXdl3JsEttKFmN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sLH2kaZ7ZxtPqifXDP7R8dXKM3Wt1mNDA2qx/oGGHqv+MJhWzymCEui6IH59DmnT4EmrZz3ULEKH6fxGCIlYNHnHwe7J8YeowYl9pzxrvfGPGCp8pnlmzUfcdocGwSAP9Zly7s1YPNAQqBye2cW/Vhno2F5Kssx0dYWL953qUkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XV71N4K+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734369451; x=1765905451;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=C6bXikWwQGtJktZn7Ohoru7n07oBeXdl3JsEttKFmN0=;
  b=XV71N4K+/my4/UOV1OyQgFIxjDOzpoipKZbrN2Sljp8WSQm3ttqqpZsZ
   tk0pGF9lC4xWybCNqulWFOQyH6rbi1e3VhEtT+yCdGkm2P30V0zyltxAx
   HYglbCK7y89z6u58St90YV/5YK1ebZIPqCIQgTsg8oDDs81+JZAn31mSA
   4cac3fO5F1Fic1j4SWrAEGWozMrLftBYbpqvBxpBhdRwuds8aIWcWT3Ll
   rS4AOJtdqRbRB7GhkGoHnWlm+MHrURK4jj2my4YAljZ9IHKMw22nM/0Jz
   pLxzWJa3VhvPGXh5sUBEvBTEUQNP4vzmv7QsaYERjRrhzReWwM9GmzCfU
   w==;
X-CSE-ConnectionGUID: AMOb4fK9QDqCQTy/p3HCfQ==
X-CSE-MsgGUID: YvuXojVkTV+TzHxVN4CANg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="46156591"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="46156591"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:17:31 -0800
X-CSE-ConnectionGUID: b2NFSO9QSOq4N2DFzMl66g==
X-CSE-MsgGUID: oFl0Znh8SgiKoBdL+It5HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98051783"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:17:29 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, 
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20241213100647.200598-1-tzimmermann@suse.de>
References: <20241213100647.200598-1-tzimmermann@suse.de>
Subject: Re: [PATCH] platform/x86: dell-uart-backlight: Use blacklight
 power constant
Message-Id: <173436944396.2913.8003278536272929976.b4-ty@linux.intel.com>
Date: Mon, 16 Dec 2024 19:17:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 13 Dec 2024 11:05:51 +0100, Thomas Zimmermann wrote:

> The backlight subsystem has gotten its own power constants. Replace
> FB_BLANK_UNBLANK with BACKLIGHT_POWER_ON.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: dell-uart-backlight: Use blacklight power constant
      commit: d44e3c57abc78cd3736197bd7800a7d5716ea8fe

--
 i.


