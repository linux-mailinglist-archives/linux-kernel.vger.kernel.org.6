Return-Path: <linux-kernel+bounces-529679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445E4A429CF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F4417AEC3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47641264A96;
	Mon, 24 Feb 2025 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7hb9FbG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD1263C7F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418226; cv=none; b=H6D33a5XwAN0M/a1BbADGH/UkwCQK8r3z+s0wOcHwLcCZrAYIi7WOKv8krb1BOi78nNdtZHbh7hj2W+mL2T/64Oshi59Ap6hyZHFVkhRHtlVDt+yW+iXHaNmCJJmRIqoovfZB9BxlIfEViWg3PP2HIBNyW2u49cnt1i1g93IlD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418226; c=relaxed/simple;
	bh=GPGKkagmcjYKsQKj5FmSjkg6CmTdTg5ahDEuI4qF+Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ju1iuRv3cdCE8H9EL6u8SqIVT/MPtxG8jkkz92+evwejumRpkLGLR/9i1vtzeqxlHBi+UdDs2B4+8hW0yS0UPaZl64ZBzOObdgF6OC6aCO/G81OyGHNR5zU1EHn5T5p/Hj+9sKuKEyqErcZ3+92QKRs/uSFFerE8hr+bEcB4Oxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7hb9FbG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740418225; x=1771954225;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GPGKkagmcjYKsQKj5FmSjkg6CmTdTg5ahDEuI4qF+Ec=;
  b=d7hb9FbGxeRFEpx0WIDK5W5a7DDn1Uh0hpZi0EFXwzxqOIQS3jBv6W8W
   D5b9/sLZLSFniVOWSkisu3moOut9ayU5hbxpu5HywF1gIIQMxefnsWWkk
   Ff1prfjOPWxKoeZWnpqOL67ch2irIfJ/sJcZQhIW/m1v+PPA/eyzek8z4
   COrWkoJaVeuU4HxDGDiDhhtR7rTL1vQ2626j13PEe9ZTopJDjNFAvTRUI
   xQiP5WgQJMyOz6f8ioLPWUcvlAgPOVUI5bnjdNKC1wUHONVrEqAdbNB+K
   aS0vfo+MQ3LO8NM20e87CxgBVwX/SGdJPcg4rdrNQeajy2S7JOxHP7ws3
   A==;
X-CSE-ConnectionGUID: OJpHygDIRfGozxPCIgs1xw==
X-CSE-MsgGUID: UfQU7UM2RMqbWhp5LqKVfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41307947"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="41307947"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 09:30:23 -0800
X-CSE-ConnectionGUID: llZceKu5R2i/JiM1o98q6w==
X-CSE-MsgGUID: Mw6W9xCmQhupBwmG07d6vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117027889"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 24 Feb 2025 09:30:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D1B3619E; Mon, 24 Feb 2025 19:30:19 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v1 0/7] auxdisplay: charlcd: Refactor memory allocation
Date: Mon, 24 Feb 2025 19:27:37 +0200
Message-ID: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.45.1.3035.g276e886db78b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The users of charlcd_alloc() call for additional memory allocation.
We may do it at the time of the main call as many other APIs do.
For this partially revert the change that brought us to the current
state of affairs, and refactor the code based on the original implementation.

Andy Shevchenko (7):
  auxdisplay: charlcd: Partially revert "Move hwidth and bwidth to
    struct hd44780_common"
  auxdisplay: lcd2s: Allocate memory for custom data in charlcd_alloc()
  auxdisplay: hd44780: Introduce hd44780_common_free()
  auxdisplay: hd44780: Make use of hd44780_common_free()
  auxdisplay: panel: Make use of hd44780_common_free()
  auxdisplay: hd44780: Call charlcd_alloc() from hd44780_common_alloc()
  auxdisplay: hd44780: Rename hd to hdc in hd44780_common_alloc()

 drivers/auxdisplay/charlcd.c        |  5 +++--
 drivers/auxdisplay/charlcd.h        |  5 +++--
 drivers/auxdisplay/hd44780.c        | 19 ++++++-------------
 drivers/auxdisplay/hd44780_common.c | 24 ++++++++++++++++--------
 drivers/auxdisplay/hd44780_common.h |  4 +++-
 drivers/auxdisplay/lcd2s.c          | 12 ++++--------
 drivers/auxdisplay/panel.c          | 17 +++++------------
 7 files changed, 40 insertions(+), 46 deletions(-)

-- 
2.45.1.3035.g276e886db78b


