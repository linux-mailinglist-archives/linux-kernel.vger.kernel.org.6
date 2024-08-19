Return-Path: <linux-kernel+bounces-291757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C44956675
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E793D1C21732
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82D515B992;
	Mon, 19 Aug 2024 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZECZoQ9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75490148FE0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058715; cv=none; b=bisrv00Xyv05wceUH2f2P83zGIpQF53O9vyX/9APeJSl9HiD1Qj3uYZ4VF8oM0817nrtfMVzkV0qWEPN+v/aF0y9idh5rw5T613maZtLyicyv9JNz27sxgt+lbaAo3APL0zI9N9XMh9ai/1X7RYX9PPYTQngUVVs4B2D+bf6gwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058715; c=relaxed/simple;
	bh=cU+GULorzuIRpvgz12CY8tG8QN5uNdGXcllh8/L+TbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RD8xOZtZwR6R3sMOA3ebVHn70Sj9g/IGtEb9H+5h3zJxv+2rJybAUCD3jsV5JTT4XFUKBwnf1ctJjXIL8DFK9wFJjXGPfGNHjfe22hbrQt+kQH2WhOIrEW89/r48vq+anEUyuL3O+Le/XVaXul7cdNQL3b55HaO+sT8Ki4WHsn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZECZoQ9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724058713; x=1755594713;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cU+GULorzuIRpvgz12CY8tG8QN5uNdGXcllh8/L+TbA=;
  b=AZECZoQ9gAlRFFNVcFk2CL9QLl7f4zjGHKDzeu1r7lECM0qAyiCwsXK5
   10Y2pmYvd1cLBjMSodX610v+VkD6Itiuuhs267M0oZjkOEJxWU4kdffd2
   yWq90JO9ys9Mxj2fTUinZf8u3BaaXbgGZjuCNzvorEUabyzfc685GwBj5
   nDHj9EDsAUs3QYcPbwLjDzFY3tJogZsthLYLu95kPgaO6qYa+9yM4arpm
   u5yOsVo+tzOIZxPmHiXBrD5ewrR7IOhmMfPSGLYhsGZnTAsWYwfoZEDqn
   SamhU2yz3D+kfVMYVbrCHTOa22SCBFnprdYaG2ROyNfK1hMlxbqyxunC/
   g==;
X-CSE-ConnectionGUID: Iw17GuKUTPGK5Ho7c7iwAQ==
X-CSE-MsgGUID: QDx791Y+RPme2jNIu+sfBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="33446089"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="33446089"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 02:11:53 -0700
X-CSE-ConnectionGUID: /TjkbNvWRyC/N4dbdo2ikA==
X-CSE-MsgGUID: XUAtds7CQuGevWvuJfe8QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="61086694"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa008.jf.intel.com with ESMTP; 19 Aug 2024 02:11:50 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Yongwei Ma <yongwei.ma@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 0/4] Enable PMU for ArrowLake-H
Date: Mon, 19 Aug 2024 14:55:39 +0000
Message-Id: <20240819145543.1833126-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes:
  * Change PMU name of 2nd atom uarch cores to "cpu_lowpower" (Peter)
  * Rename "hybrid_small2" to "hybrid_tiny" (Peter)
  * Rebase to 6.11-rc4

History:
  * v1: https://lore.kernel.org/all/20240808140210.1666783-1-dapeng1.mi@linux.intel.com/

Dapeng Mi (4):
  perf/x86: Refine hybrid_pmu_type defination
  x86/cpu/intel: Define helper to get CPU core native ID
  perf/x86/intel: Support hybrid PMU with multiple atom uarchs
  perf/x86/intel: Add PMU support for ArrowLake-H

 arch/x86/events/intel/core.c | 129 ++++++++++++++++++++++++++++++++---
 arch/x86/events/intel/ds.c   |  21 ++++++
 arch/x86/events/perf_event.h |  34 ++++++---
 arch/x86/include/asm/cpu.h   |   6 ++
 arch/x86/kernel/cpu/intel.c  |  15 ++++
 5 files changed, 187 insertions(+), 18 deletions(-)


base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
-- 
2.40.1


