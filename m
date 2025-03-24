Return-Path: <linux-kernel+bounces-573526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39300A6D8AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601783A65A8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C1025DCE5;
	Mon, 24 Mar 2025 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FO47BT2+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC20433A8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813562; cv=none; b=ZLyCSItORccpwMsigmDwejEwFmSx3BpqBipTvGmFtxhJxoYckAUyIZ8S/sGD07/SLRSIR6uKg7BSdVUCAwdn3ekp+gnlI+650qjoiZiozYn4DA5V4nSYNP3QV0f3PRM4k/6QcVIYS+EaqdqCNdBeUH3+CDGZg1V+WwZYk4uwdi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813562; c=relaxed/simple;
	bh=A5RRwdnpqR5WLgCZQLOgX5qokTzTLYK516/ftCIDwrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cThriflVNlaqfMSGaMr8GkrOKMaX+TAURkqSCCYE3u0YHBODZVmRjMDU9bOBKyvMIdvZgtJjdVifkVNQY1E173neXvtt2w5FWs47NPxE4qSon4Ua+iRK87Sq0R0T3pM6K6ELAW59+pYLNHcdI3DT6SU3sDtoe4PGGDjgGOuE5rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FO47BT2+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742813561; x=1774349561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A5RRwdnpqR5WLgCZQLOgX5qokTzTLYK516/ftCIDwrA=;
  b=FO47BT2+O/JqFJG9su62tQtxogUiRFRtGdOjCf0TS6LbIDyRNjbCtMyF
   LoouwoYQ800MGb77f2DVK/ebRih0eGo6U8LCjA/7TcvnZviQkAOM7deAo
   a5oJQaCG1ecBj7njV7QK/DXOfR+bs0eh4GNqB3ZCkhtppVmZoM8jMiIfG
   lNaE8BU6q+tL4y+2hFSErgt6MM9lcLr2zDU/MN8DQ6iKY2HF/SlKSUriU
   Ja630LJeQFOs+MuzE/F7QpJ18GcwZsufdndeMVlM1xGpUb2nAGygVPj6R
   P6nvPpQ45GPQIMcu4kXdHsRiDTf6AjQtOwcc9JGQ8j/XWXlnABjufmuTh
   A==;
X-CSE-ConnectionGUID: csWxjLJrTgWn2ZJtp4TfbQ==
X-CSE-MsgGUID: 6Ljf/RG9TxyhqkIeoJ+z1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="46756882"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="46756882"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 03:52:40 -0700
X-CSE-ConnectionGUID: ByUJ0DUwRMmiMtTYk4HceA==
X-CSE-MsgGUID: nRNXJyfzQrOR/SLX/3WpXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="154916397"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 24 Mar 2025 03:52:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 42C0A109; Mon, 24 Mar 2025 12:52:36 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 0/2] kernel.h: Move out a couple of macros and constants
Date: Mon, 24 Mar 2025 12:50:23 +0200
Message-ID: <20250324105228.775784-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel.h hosts a couple of macros and constants that may have been put
to a better place. Do that. Also add missing documentation.
No functional changes intended.

Andy Shevchenko (1):
  kernel.h: Move PTR_IF() and u64_to_user_ptr() to util_macros.h

Ingo Molnar (1):
  kernel.h: Move READ/WRITE definitions to <linux/types.h>

 include/linux/kernel.h      | 14 +-------
 include/linux/types.h       |  4 +++
 include/linux/util_macros.h | 66 +++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 13 deletions(-)

-- 
2.47.2


