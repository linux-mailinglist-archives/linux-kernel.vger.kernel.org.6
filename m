Return-Path: <linux-kernel+bounces-546885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5214A50028
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760A11898BBA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBE924FBFB;
	Wed,  5 Mar 2025 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NaoDYEtq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430DA248885;
	Wed,  5 Mar 2025 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180208; cv=none; b=rm8//iDKQm46CfOguElOJhzDabTtahsoSKytAvVZ+iwvD3VWQQwVKBBNq3tOd4h00JjLrqXm+Z4V5ZuLf086i70UTen1BI76T5H0uYUNdU7q4vs7sYDjvA4JuVmLFSxhU6TkMUV8poYa4RN8fEWFozynL18fjiZ+ashKi/WcCWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180208; c=relaxed/simple;
	bh=Ppu6hH6zWyIYOsIMbZoPZ/8t2tNhJAxLl4MjDk4Xylg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NP6/3XU8fjtH8uEMQTw+fLeIZqZyPBruaoZKliJevMnDxMsuI5T5GkqcakpBJAtERZLq7fNwyVxBwjXPI8G2HWsr6sETtlBcytOeS8UL3TU9EP8yZ8ozDpRAirxzjuK3bacYLUokRIDER8oUZW0XXhVGxHJywCrG/Ew2MTeic/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NaoDYEtq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741180207; x=1772716207;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=Ppu6hH6zWyIYOsIMbZoPZ/8t2tNhJAxLl4MjDk4Xylg=;
  b=NaoDYEtqQwpgHlytNBVAZ9XoydVpVSVCYxRUO94oCgo4fxJr4g73S90t
   OZN0ZMUtY+cYRQK/CcamvvAqVrLwv2nxHrsfN4s7DpII9eatdeqbVd1P2
   X6GEu628STQMi2TqL0c1dY9NlwJ0lBEhp45Ix8HAzV1gNmB7Nr2aCVc3y
   pVe8LsZZ8GNUQF3jVg2XrIrGu1IOmpRN9IL9EFR8TWdXmgMw1oxr3fJop
   HyZDuAk4pVt4PHXSfV3U07OAksdFcJYbcPS7CEoGlk7r+IGyHxz32STXQ
   i4nirVqyLAG0H3OtOpkoBOxdLNe6KKWVhaJkcgbViDyKCTWwcZqJtWgCk
   w==;
X-CSE-ConnectionGUID: HI/GMev/TkaWgb2g8P1c+A==
X-CSE-MsgGUID: mwSyXOvpRYq5d+P7/Zf37Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53129600"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="53129600"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 05:10:05 -0800
X-CSE-ConnectionGUID: 2EuezKZCRvCj51U2Fo/TVA==
X-CSE-MsgGUID: 4bJ0o1bBTiyOVlBF58hS/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="149445401"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 05:10:04 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: W_Armin@gmx.de, thomas@t-8ch.de, kuurtb@gmail.com, hdegoede@redhat.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Grisham <josh@joshuagrisham.com>
In-Reply-To: <20250303132433.348653-1-josh@joshuagrisham.com>
References: <20250303132433.348653-1-josh@joshuagrisham.com>
Subject: Re: [PATCH v2] platform/x86: samsung-galaxybook: Fix
 block_recording not supported logic
Message-Id: <174118019816.7167.17907645476691400709.b4-ty@linux.intel.com>
Date: Wed, 05 Mar 2025 15:09:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 03 Mar 2025 14:24:32 +0100, Joshua Grisham wrote:

> Fixes logic error when block_recording is not supported but the fw attr was
> being added anyway (reported by GitHub user bbregeault).
> 
> Tested myself on a Samsung Galaxy Book2 Pro (has block_recording) and by
> bbregeault on a Galaxy Book2 Business (does not have block_recording).
> 
> Fixes: 56f529ce4370 ("platform/x86: samsung-galaxybook: Add samsung-galaxybook driver")
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: samsung-galaxybook: Fix block_recording not supported logic
      commit: 7bb84ca9b8d0cfff76a6108636aec1a5a8cdcd49

--
 i.


