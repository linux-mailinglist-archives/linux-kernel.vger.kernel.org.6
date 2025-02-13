Return-Path: <linux-kernel+bounces-513027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DF6A340B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250DF3A9503
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D71C171E43;
	Thu, 13 Feb 2025 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FkFK6As2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6408C1474A0;
	Thu, 13 Feb 2025 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454357; cv=none; b=AFZ0o4uPeYoCGwAnIbTEfW5GTgmS60IOjsKiVSOJYcPsjOi9I8wEPc/smhQ+RWgxVFmBCBFy8YFMnG1m2r09JxdoOin+CGyBtpupYhzG5Jjj/FHe64FaSiMgKl12i6JRDYHGE2Ev1M+K8BIdfPf0NtTEQgYsdaq0mtRtLCptnV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454357; c=relaxed/simple;
	bh=j1aSFt36HM2c5iHOTQHGyMqzUANlsSsBiXmUQrTtruo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mEGSDHMHZWW9rbmLgpy01qPhp0SjOg5EpN0XFzqrN5GYbcwkZ0Q/ZM98NA9LD/8A5H04ZnB3QMLqQEJVfhJ+u9l/UhMSo8Are6p77oaTdH51BiUc5wT9YRGG2LNM/53COyLue/PHB47cm1mAnoBSCUwWpINPUR33AoqWwMSHAyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FkFK6As2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739454356; x=1770990356;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=j1aSFt36HM2c5iHOTQHGyMqzUANlsSsBiXmUQrTtruo=;
  b=FkFK6As2MivcBB0WPZmG6QXeLAoCf7OE07eX8ZYa3jwXAmCcNnXEVepG
   Ik9tBqKsFO7tc05NLnI5WY7p7V/vCrGL0WzI7kwumXXge6twImWNMdu4z
   er1iearUWl5kktEnmKKBs2ICJ/5UyNeKiC61dlKSTZaJkfFrM//Y7fLLW
   7G22lxN7PBBNPyMQecfKpgpvRwBplTUzrvZ0NOtYCsSMFvwoixe/tTBjM
   cUfoRfbRsfG81ewZbccyEC4kXZ696Kvdve8bhCPr1ykrlddZvM2vy0QKq
   FMtl37VYxTs9qzRA9uZs+l6B4poaumgdAzlRzilDU91RgJPBKmsuZp/pG
   g==;
X-CSE-ConnectionGUID: 5n8UxO1sQ2ygyOzoc835JQ==
X-CSE-MsgGUID: JCkAKPByQUKMfbPYBwo4OA==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="39342927"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="39342927"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:45:55 -0800
X-CSE-ConnectionGUID: bYz6HajlRLSIlHPrujpVog==
X-CSE-MsgGUID: mHaZ3GkITPmqdLBfwxvaKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="112903671"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:45:53 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mattia Dongili <malattia@linux.it>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250210123103.112938-2-thorsten.blum@linux.dev>
References: <20250210123103.112938-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] sonypi: Use str_on_off() helper in
 sonypi_display_info()
Message-Id: <173945434632.30492.2226152929366583533.b4-ty@linux.intel.com>
Date: Thu, 13 Feb 2025 15:45:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 10 Feb 2025 13:31:03 +0100, Thorsten Blum wrote:

> Remove hard-coded strings by using the str_on_off() helper function.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] sonypi: Use str_on_off() helper in sonypi_display_info()
      commit: 9cf1c75bfda5168b82ba19576267d5cad0327b9f

--
 i.


