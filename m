Return-Path: <linux-kernel+bounces-546886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A052A5002D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD2A189D4FF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A716248885;
	Wed,  5 Mar 2025 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8IwLKF+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC0222E400;
	Wed,  5 Mar 2025 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180216; cv=none; b=SrrUnwrRmcgqPTCSa9EnUooU2OVDB4+k6qRM8Ab9Jfv2120fqtSBJvC6wT0R4txFIowlYN8ZDccvkSa/4SrlV+RpuuwACIlmuV8oeMVRhzFvyf8DgyfwnFRJpHKANTuMvn1TBSu1BOaC9sVj3bo6sC1Q1xmP2M4YGe8Xvpj4vHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180216; c=relaxed/simple;
	bh=8d8ylUJyDsei6kIozSi5l4XRNcRjN2gQ/ycwpZTfjIk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=evBgI4iSZrZy6YDJIO6iJ4iT4l10SAyrc8olCb4HcV9gbuea+mP7a6tk5r6ytByXynXeDmgUb8RzP+L9YPlm39blgxeT7d2dc6Uo2pwMAowKElzAYjrbyQEiMS+mw1vv3Z9/E7q7q/5xBrpKfUCPErDpLht9SH0RmykgMxVTRYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8IwLKF+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741180214; x=1772716214;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=8d8ylUJyDsei6kIozSi5l4XRNcRjN2gQ/ycwpZTfjIk=;
  b=L8IwLKF+i6AmdLAESA3QXvJ8lfuqD3YF7AjzGKh86EOpurp6CTlw0DDn
   OFmkIuGHuqYPK0qawKH9jaesZL/qMj6rQclTrlaGIwGUtL67gnfeOpLsR
   gRNlx2uHxXPCTh1G5DkjIK3MNUDUrB9bmiAqJO1js7anlU5gyiTXpbvrN
   om4QODaZ3aslDXB4QpQy6ZbzUxDbdAzJ3AfUW0twSp3Mca0IiVdLwUMq2
   B8p3LmmYJ0+0MIyDaszYY1AlHXoxxuFgAv/u1TeLsu3HZ7fOs0yLnXhgE
   l1yD8bOsIR49rer+kLnnZRuZqEFOXW4iqUL6wWaEPpYmYsAad93BZC7a0
   Q==;
X-CSE-ConnectionGUID: eUEwqSLgSZWIYjKn7AZTaw==
X-CSE-MsgGUID: e24tSwe6Tpy7/hBYzm6E3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="64583732"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="64583732"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 05:10:14 -0800
X-CSE-ConnectionGUID: bRdBNT1zToavUXA0QDXakw==
X-CSE-MsgGUID: KPW4JaZTQde2kO/glfaSEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="118700882"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 05:10:11 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
 Hans de Goede <hdegoede@redhat.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: ibm-acpi-devel@lists.sourceforge.net, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
In-Reply-To: <20250305103146.53221-1-brgl@bgdev.pl>
References: <20250305103146.53221-1-brgl@bgdev.pl>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: check the return value of
 devm_mutex_init()
Message-Id: <174118020623.7167.10717246619889529907.b4-ty@linux.intel.com>
Date: Wed, 05 Mar 2025 15:10:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 05 Mar 2025 11:31:46 +0100, Bartosz Golaszewski wrote:

> devm_mutex_init() can fail so check its return value.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: thinkpad_acpi: check the return value of devm_mutex_init()
      commit: e57eabe2fb044950e6ffdfe01803895043dec0b7

--
 i.


