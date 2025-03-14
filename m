Return-Path: <linux-kernel+bounces-561547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4253A61356
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22EF81727D8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8DA1FF7BB;
	Fri, 14 Mar 2025 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwzxfG0f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3F61BC3C;
	Fri, 14 Mar 2025 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961236; cv=none; b=PnbrKRSA6eqytPENl/w8GJpcCLdme9RPrZU044u8GsC49FEdb/L2FqCZvnC9ODjD+vmuIv8Y92F1aRK4YjBZ+1F/Grlevt6Br2Sto9d96iEOs/yBBaki6lp5NIYdgsA5LsBNxUaEv24049sQhi8/k2zf0eWkchg6O3F8d55Y6sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961236; c=relaxed/simple;
	bh=rhUA3z8BXwjy0zlJdSes9rJ3iMj7HZR+0wHVZCshF1g=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E0QuUUCNEGUkVena2IE3Cwh/TpZZS0EV6+Mx03ZEGXxQOiA5DRXj2yCFGY0NkN+GfTHUKgK1gdMfff1HGiLzaWn7rnMO/eP9KGZmbv76p3AmEfPFSycIJFs0I0XkU/ARdczFDqCv6/MztdhgaYBzF8++HYQmXn8mZEfLg0azehE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwzxfG0f; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741961234; x=1773497234;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=rhUA3z8BXwjy0zlJdSes9rJ3iMj7HZR+0wHVZCshF1g=;
  b=QwzxfG0f5ki3oZPhzllxskOtO7AHAkyUCoCFc20LoAkt60JPxNudgVYd
   BJBVrXkXladybKdJWp2N6QwBZ3bMAswfERa7YEEFtRtPJzvFkaDHKQ3/f
   G8WT/ePVuG7jf5W2goj7VEAEzO4J1rWz3VCFXGNZkPv8F3cT2U60io7I3
   ssQDUfsM2IPOZyU3/weBScALtikrRe5f6BbyvwK0P3YirQJrCwDWr3g9n
   oLQEC/lfB7bUY7lmMTH8JPopHUp0aED3Fn2PYiJ+MYZCmsCd5YfZrACi+
   reLdzaliKR1UNC+r40kKjgcm9Zbix4vVfVsRxIsA/zLCPkFbYdnv1hYm5
   w==;
X-CSE-ConnectionGUID: k9iZli4/Qtm5lb9TzXkSGw==
X-CSE-MsgGUID: PocxXGoKSnyYaHObSiin8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="42362268"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="42362268"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 07:07:14 -0700
X-CSE-ConnectionGUID: wiGGv2RDQlSaof953JrqPQ==
X-CSE-MsgGUID: 6/rBsFksRwaEeIda6wHFgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121251168"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.56])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 07:07:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Hans de Goede <hdegoede@redhat.com>, Ike Panhc <ikepanhc@gmail.com>
In-Reply-To: <20250314045732.389973-1-ike.pan@canonical.com>
References: <20250314045732.389973-1-ike.pan@canonical.com>
Subject: Re: [PATCH] MAINTAINERS: Update Ike Panhc's email address
Message-Id: <174196122708.2469.1417521291075836840.b4-ty@linux.intel.com>
Date: Fri, 14 Mar 2025 16:07:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 14 Mar 2025 12:57:32 +0800, Ike Panhc wrote:

> I am no longer at Canonical and update with my personal email address.
> 
> 


Thank you for your contribution, it has been applied to my local
fixes branch. Note it will show up in the public
platform-drivers-x86/fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] MAINTAINERS: Update Ike Panhc's email address
      commit: 03fc0a2dc9f8c292fad8a1bcfb6d1f0dec1824be

--
 i.


