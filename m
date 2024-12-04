Return-Path: <linux-kernel+bounces-431157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E099E399E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A1D161A03
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04901B85D7;
	Wed,  4 Dec 2024 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWXrO8cJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CBC1AF0A9;
	Wed,  4 Dec 2024 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314406; cv=none; b=IotY7wwreqKddhbwsgwijaeygfQ0ewdZ98LlVJ3kXySa3IZwQH7bBUdEhqsxCcpgR6KqTQTCzNy/c9k4UpmhYL1vqrY16Zo0EnT0hzegh5QYCDP2p18f4uUCfd27wD15e7Al9klM2qmsQ6NJwxm7ADAQ3SVB0IgcJnI4yb7EQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314406; c=relaxed/simple;
	bh=F/PGUjJpR/GznCOjIscqm2kL6oAgWba4NmiPD8rhYLM=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=bLDSwWI+V+J0rTsunrmKFjTRv/QC+VPrvc+3npxpyZOgjVgzBbQJ7e7pY/06samuDSsMuJ7h+C6PHTfJcJGg7nJOec9nyuJfZeIVJWGLDJSP+Nl/aN5CyKJxScxB7QyXV/WEmQ8MsrA/vtL0PPuWZ19Q4ajYfkDyFStxR4FvLKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWXrO8cJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733314405; x=1764850405;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=F/PGUjJpR/GznCOjIscqm2kL6oAgWba4NmiPD8rhYLM=;
  b=dWXrO8cJo3FjGCjK4kt4HOTr8OjQ/cFUMTLx6hhVib9p4NguFaM/KrBP
   gp+X5QMZ+TjYPdOf++fyx4m3lmNnBIwSLmR5RJfPJdVGaLJXRouEd1J5T
   XTolMzv7LPFWJ1weY/KqLqKZHILAde5Qnprr8bgOJF1mhbnTCdqOsP4Ab
   twJSybR1AAcxj+MdNuQN4HXahOOEpyw3aQPnV/w11QLdi6BLI89oMN3US
   7Se21cerwnYNsGBYkyE2h9pPkbZ9VY1RnPLNhL1j5hLCzfIjq/DWoF685
   USr/pR3cJhQ2+YHiZE/uE/aMUiyJT6Stby3AEW2xUx+0c/O4PmMkISw7e
   w==;
X-CSE-ConnectionGUID: +DqmSnx9RaCNnichsLKwPw==
X-CSE-MsgGUID: q7t+NEI9QhyR7f0XtuHZMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33825953"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="33825953"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 04:13:24 -0800
X-CSE-ConnectionGUID: fljyPwKxRuWyX0HBXtD+GA==
X-CSE-MsgGUID: 639ol/leQLm0MLx0Ta0pOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93933839"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 04:13:21 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Wed, 04 Dec 2024 14:12:06 +0200
Subject: [GIT PULL] platform-drivers-x86 for v6.13-2
Message-ID: <pdx86-pr-20241204141206-1813515751@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is a platform-drivers-x86 fixes PR for v6.13.

Fixes:

 - asus-nb-wmi: Silence unknown event warning when charger is plugged in

 - asus-wmi: Handle return code variations during thermal policy writing
   graciously

 - samsung-laptop: Correct module description

Regards, i.


The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.13-2

for you to fetch changes up to e9fba20c29e27dc99e55e1c550573a114561bf8c:

  platform/x86: asus-nb-wmi: Ignore unknown event 0xCF (2024-12-02 18:57:17 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.13-2

Fixes:

 - asus-nb-wmi: Silence unknown event warning when charger is plugged in

 - asus-wmi: Handle return code variations during thermal policy writing
   graciously

 - samsung-laptop: Correct module description

The following is an automated shortlog grouped by driver:

asus-nb-wmi:
 -  Ignore unknown event 0xCF

asus-wmi:
 -  Ignore return value when writing thermal policy

samsung-laptop:
 -  Match MODULE_DESCRIPTION() to functionality

----------------------------------------------------------------
Armin Wolf (2):
      platform/x86: asus-wmi: Ignore return value when writing thermal policy
      platform/x86: asus-nb-wmi: Ignore unknown event 0xCF

Sedat Dilek (1):
      platform/x86: samsung-laptop: Match MODULE_DESCRIPTION() to functionality

 drivers/platform/x86/asus-nb-wmi.c    |  1 +
 drivers/platform/x86/asus-wmi.c       | 11 ++---------
 drivers/platform/x86/samsung-laptop.c |  2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)

