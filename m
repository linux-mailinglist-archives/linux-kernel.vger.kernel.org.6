Return-Path: <linux-kernel+bounces-301401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE8A95F00F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B7F1C219F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0141715534E;
	Mon, 26 Aug 2024 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBKhC4eJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEBF1514F6;
	Mon, 26 Aug 2024 11:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672648; cv=none; b=Bzj9w+jqennWLj0nyvQcygpLUKJMTGy9UwGuY+26KynYeU3+MsBpzfcS0HURK1iCnJbsByKyYLSdePLkZbl9igEJGeRqq9p+FapLLQiA91LgNlZyCrdB7cu+nUwnpt0YaYpoOSV5T+vBG+b35FX+dEb0eYVYHZ/GZYu4FtDMw8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672648; c=relaxed/simple;
	bh=lXAtLG8ATP3RkXvAe63qleJe9gcAHgbYkMGPFMzlK+E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PZkuWr92Ciuoz1IYPVJWUpyw80QddfIugVV9c84jLnFUHKgfuWz9DXu0uPznkLjl7x1oM7ryPpRaVJJfcjaKrtJz4/V9G+yirxlMidl+DBpf1EvxZY2JMawXzR+hUgrSpJV2VZvZt5l6U+bCJpEi1RUHL3J5X65dsiAy99psKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBKhC4eJ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724672646; x=1756208646;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=lXAtLG8ATP3RkXvAe63qleJe9gcAHgbYkMGPFMzlK+E=;
  b=eBKhC4eJmAxMC+TvughW7jtZlXxxI6z0FAlg2TUDRToNzRERyaNQLDes
   IR07vKcxQSqu6mQS5qiPeDKSqdsYK/hj65d/HBhFJVlMxf5WE2u7giztb
   QSAHOmhase+/5DTEiOo1Dil9g/dona8iGz0k4aIH4cTMW2KYaZsMWFmMX
   dO58e4BU0E7sszkrlOMoDnGVUpy+/g7sRWOnzlsXrh6bQt8fDcN/QveMA
   KOGajPnFWQnAsPrHFsCAw04yP5ZWkIVZkFkXPkEOWYIs7TLIH93hWnJ9c
   DTLXwzNWhFtsLYN4baPnlOX9ER8Fvvtq4gyEofr1J/LREn/orl/T0q69J
   Q==;
X-CSE-ConnectionGUID: BPXk9LHNSCOKA0l6mHZFkA==
X-CSE-MsgGUID: xkwRgvefTgWrTOwv0cxviQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="22611114"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="22611114"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 04:44:05 -0700
X-CSE-ConnectionGUID: lIm5DtRkTjy4VguqPColtQ==
X-CSE-MsgGUID: 192hwr2OQECo7LCNaSbCEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="85667412"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.174])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 04:44:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mathieu Fenniak <mathieu@fenniak.net>
Cc: Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240823135630.128447-1-mathieu@fenniak.net>
References: <45764fd3-f715-c461-1f6f-071bad742460@linux.intel.com>
 <20240823135630.128447-1-mathieu@fenniak.net>
Subject: Re: [PATCH v2] platform/x86: asus-wmi: Fix spurious rfkill on
 UX8406MA
Message-Id: <172467263739.1877.1744107740712485288.b4-ty@linux.intel.com>
Date: Mon, 26 Aug 2024 14:43:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 23 Aug 2024 15:56:28 +0200, Mathieu Fenniak wrote:

> The Asus Zenbook Duo (UX8406MA) has a keyboard which can be
> placed on the laptop to connect it via USB, or can be removed from the
> laptop to reveal a hidden secondary display in which case the keyboard
> operates via Bluetooth.
> 
> When it is placed on the secondary display to connect via USB, it emits
> a keypress for a wireless disable. This causes the rfkill system to be
> activated disconnecting the current wifi connection, which doesn't
> reflect the user's true intention.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: asus-wmi: Fix spurious rfkill on UX8406MA
      commit: 9286dfd5735b9cceb6a14bdf15e13400ccb60fe7

--
 i.


