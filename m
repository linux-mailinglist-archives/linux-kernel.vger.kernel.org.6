Return-Path: <linux-kernel+bounces-541732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C30CA4C0EE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBD13AA89F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2658211A04;
	Mon,  3 Mar 2025 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1er3q+I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C401D4879B;
	Mon,  3 Mar 2025 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006028; cv=none; b=ejSwNoobeon04lufM6/Z4CoDK1LNPf36+nH8/AigIZlK718D/hHZvvGBWQCXsIazY76HurxngXCNc+nnxKL8tWm4CGTMeYlg922TEcmHUCnOiSmZcdfXovxFXxjETsTrnA0hACLZStp7FOoK/Y9iWjnrAZosAW9mvp+U7iq+wEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006028; c=relaxed/simple;
	bh=zR9AwK/TqOfsEdmmJ+RU6wWSpzM7PwyFsIOaHiujQEg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PuTEwJN2XhADskfqzgVjHBF+HYhJhIp+i+9850LnG9TzlnR1OWPFoVIGozJCDqDfLrs0x/4+xR19+m4BvyuvI/u9HK6VrkUevZjRuzHQ0VWjV1PNqA+R12rAn9S8a8zG0VntmxCpU08qBh/dWIgPUapIlPCOBr2EpJC86NLk1KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1er3q+I; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741006027; x=1772542027;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=zR9AwK/TqOfsEdmmJ+RU6wWSpzM7PwyFsIOaHiujQEg=;
  b=m1er3q+IfMMXFjFMSUsLObTnM66QP/9TZFWBFIStt1V6RPEtdUUNtqhQ
   J0NmiL8A7SUIEe/WhTArcdZrz7lNBSj5JgTYIJvUhi9eufwpYJYp8P7jX
   QUf6JnwzapLdnCInpbr65hHVxZRj7HHmxn6QEn2F6QFxuNSFoENFjk2bd
   7rlRVBu1n9DBYhE4aEPOeptK9Oc24ln7aW1aB9P8rzR04yJbXBthNKdjF
   5aOcGd0jv77M6hBPkadOhrHDcGZp3DynBl0Jhw1wM1gqcxf8EkoAZt5B7
   LxbQYJCDNrnCdzprjwR4EMQhUmUpqvzKkc6V+tortjmc7kzgXsyNkmULU
   g==;
X-CSE-ConnectionGUID: RGb8IQbcSXe6zpQ/fZpjjA==
X-CSE-MsgGUID: y+dsS52mT82nEWJ3oyC8uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52855698"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="52855698"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 04:47:07 -0800
X-CSE-ConnectionGUID: FeysetlMQv63UfTR25D7lA==
X-CSE-MsgGUID: W46yijhHRYWM6A2iWpzqMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="148809811"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.14])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 04:47:05 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>
In-Reply-To: <20250226214728.1256747-1-david.e.box@linux.intel.com>
References: <20250226214728.1256747-1-david.e.box@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel/vsec: Add Diamond Rapids support
Message-Id: <174100601913.2518.6036767377648999712.b4-ty@linux.intel.com>
Date: Mon, 03 Mar 2025 14:46:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 26 Feb 2025 13:47:27 -0800, David E. Box wrote:

> Add PCI ID for the Diamond Rapids Platforms
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel/vsec: Add Diamond Rapids support
      commit: f317f38e7fbb15a0d8329289fef8cf034938fb4f

--
 i.


