Return-Path: <linux-kernel+bounces-295561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CAE959E54
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F3E1C2267F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A49A19ABBA;
	Wed, 21 Aug 2024 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ysw3siPV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B3199FC7;
	Wed, 21 Aug 2024 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246021; cv=none; b=lz9opnMDU3FXUUBc7O8D2rhT0pgNvVc96bkBJeQFo59CGoHn8ndTUVeXPFvRx5JjjlpImTgGDAkwXd1QNsZ2oe3ap3vGKr4tWfRj0RF1ASA/+RC6X+MoOW0hY7yCyWAUhp6U5i0EaaWHPHV2bsEzSu206zCdirWPSyUHKnZCqo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246021; c=relaxed/simple;
	bh=FG9EKt8B87nm6Bm6dMO1i09C+ZRKUDwGyc4dd5Vh7ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=svnJ18xDScjywVCyEzftUy0pQcLHZ4dqSBxLsZU8N0f4fecc4r+Nl7+EMTP3SjK2DQI7bQFL+dQAiMzL3u+5bXy5oHHI75V/jdgzle7p8WO8rVJnWAEK86Vb+brtrWfsK80+rfhfjqNTd6UMvxxHr3rNSs/r4SR5GYFr11pvbXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ysw3siPV; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724246020; x=1755782020;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FG9EKt8B87nm6Bm6dMO1i09C+ZRKUDwGyc4dd5Vh7ZA=;
  b=Ysw3siPVxYCTyZRvLU/GA9SWOySjj2prWWsIp5mLXBPNEDYWViAd+iNW
   kznobF9a7y8xBx8MHNo2HL4JpCMaHlp+X/SJ+ln0E7H1PmgswOn4AS/0G
   myTt+MvRFj/TR2c/FQtTHRJLE7b+TrVC0YIzER2YF6LJlB2NEv+Y61wDy
   e2f3LC7e8ambLK1EhzZHe3VIzruLw+pdbdkFLA3ErJ9NE8wsxoRKdOFRD
   3kRgZY63BNT7Vr+0dAc9Far7YlxYfdDCjxewNqO8WJriNnifF3pQE6UY3
   t1fVSOMGs4/DrU8F0bht3qzHZ5pMnLbMlFSMccTsY/r6VAQa+SngY5YuW
   Q==;
X-CSE-ConnectionGUID: zW5sSIMtR5mE+wsvCX2rHA==
X-CSE-MsgGUID: Xw9Am/cLQTuMXprcHWAowA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="26399016"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="26399016"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:13:34 -0700
X-CSE-ConnectionGUID: FfUTcZBFRVGRXzSOXgu/4w==
X-CSE-MsgGUID: beYkfBnCRLuAYmIZenT/qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="66047764"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.10])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:13:32 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] platform/x86: Add support for Intel uncore ELC feature
Date: Wed, 21 Aug 2024 16:10:27 +0300
Message-ID: <20240821131321.824326-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds ELC (Efficiency Latency Control) support to Intel
uncore driver. This is a feature supported on newer SoCs, and it
basically acts as a way to fine tune efficiency vs. latency tradeoffs
wrt. uncore frequency scaling.

-Tero


