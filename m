Return-Path: <linux-kernel+bounces-355762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE689956B7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1869A1F25E19
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052D0213EDA;
	Tue,  8 Oct 2024 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cm393imY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B77212D14
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412539; cv=none; b=qRKyMK1j63JTMRC3ntQG4Amt20uRSiWD3YVFbdrP6DmMIw2LqZk17DAL1hth2ue4uWGQRy8JXBfX/6SbDX6/1mpeU3JGgi0io3IQ9zuM+cbcIedhvjk/iAKZWafa/UwjDZusjSCS0diLfS1IigpPTwfkTiucx74UtWiz2zhdXyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412539; c=relaxed/simple;
	bh=JT/kMTegZkoHlsBIWkFdpOtllJr0mz1LgdCh8oSg2pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VmypxQWcEi+g7sQ9EVv5e8gQXUUIxCLyvxRn6GcwGHEMgwvfPZdZqZcLMiM5KII8pRI0wxOz9HCNJK3tdSrBPMOLA1ys49t/QHrnQ+86jwqvO3EJVp3soKd4cL264vq3bXAvDUFiaw88GSsb6ITns3KdSA1bYCkdIGgGDKjG77w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cm393imY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728412538; x=1759948538;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JT/kMTegZkoHlsBIWkFdpOtllJr0mz1LgdCh8oSg2pQ=;
  b=Cm393imY79tWn4yhwYQFDPx1h5LZHHYkOpBLaxvxJFMYvnb8WISW1WYU
   cMqFZCYRzJkFW5jq5VBLcuuKf6fNd1EkyV4VWYD4l7jJuteXbmdqtkHyt
   am94VJnBsxi7XS6S6PQwub7U6cCZZaUfdCEqZIq8F7wYOvyf5D0nCZyeN
   hrvhn0k/WhK4IbEgrtphktS95O6Smth5CX0r1YceGHXvIdmGYsx9a+Tkh
   gWhkwscBxt8z61vttJv5HpUvvVFKuOtDCmTKfVCLEq7PSJNvv2PpqYaUB
   qo+mrnGS9NHkglknwi6LpleT3T4lvbzphpop1SeK/FLuDCV78MUziasSt
   A==;
X-CSE-ConnectionGUID: UYy8qewZTNqY3d7oUkJDlg==
X-CSE-MsgGUID: fn6S8IQNSUaFjJ4ZT4iXfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38295321"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="38295321"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 11:35:37 -0700
X-CSE-ConnectionGUID: jMDKuuGjSZqpnDo8TXaBZw==
X-CSE-MsgGUID: LYmuLAj3T62xJr6Sz72U0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="80530898"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2.intel.com) ([10.125.110.138])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 11:35:36 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Ian Rogers <irogers@google.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 0/5] perf: Fix pmu for drivers with bind/unbind
Date: Tue,  8 Oct 2024 13:34:56 -0500
Message-ID: <20241008183501.1354695-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 of my attempt at fixing how i915 interacts with perf events.

v1 - https://lore.kernel.org/all/20240722210648.80892-1-lucas.demarchi@intel.com/

From other people:
1) https://lore.kernel.org/lkml/20240115170120.662220-1-tvrtko.ursulin@linux.intel.com/
2) https://lore.kernel.org/all/20240213180302.47266-1-umesh.nerlige.ramappa@intel.com/

WARNING: patches 1, 4 and 5 are NOT intended to be applied as is. More
on this below.

This series basically builds on the idea of the first patch of my
previous series, but extends it in a way that

	a) the other patches are not needed  (at least, not as is) and
	b) driver can rebind just fine - no issues with the new call to
	   perf_pmu_register()

Another difference is that rather than mixing i915 cleanups this just
adds a dummy pmu with no backing HW. Intention for dummy_pmu is for
experimental purpose and to demonstrate changes tha need to be applied
to i915 (and probably amdgpu, and also in the pending xe patch).
If desired to have an example like that in tree, then we should hide it
behind a config option and I'd need to re-check the error handling.

With this set I could run the following test script multiple times with
no issues observed:

	#!/bin/bash

	set -e 

	rand_sleep() {
		sleep $(bc -l  <<< "$(shuf -i 0-3000 -n 1) / 1000")
	}

	test_noperf() {
		echo 0 > /sys/kernel/debug/dummy_pmu/bind

		echo 0 > /sys/kernel/debug/dummy_pmu/unbind
	}

	test_perf_before() {
		echo 0 > /sys/kernel/debug/dummy_pmu/bind

		perf stat --interval-count 2 -e dummy_pmu_0/test-event-1/ -I500
		echo 0 > /sys/kernel/debug/dummy_pmu/unbind
	}

	test_kill_perf_later() {
		echo 0 > /sys/kernel/debug/dummy_pmu/bind

		perf stat -e dummy_pmu_0/test-event-1/ -I500 &
		pid=$!
		rand_sleep
		echo 0 > /sys/kernel/debug/dummy_pmu/unbind
		rand_sleep
		kill $pid
	}

	test_kill_perf_laaaaaaater() {
		echo 0 > /sys/kernel/debug/dummy_pmu/bind

		perf stat -e dummy_pmu_0/test-event-1/ -I500 &
		pid=$!
		rand_sleep
		echo 0 > /sys/kernel/debug/dummy_pmu/unbind
		rand_sleep
		rand_sleep
		rand_sleep
		kill $pid
	}

	test_kill_perf_with_leader() {
		echo 0 > /sys/kernel/debug/dummy_pmu/bind

		perf stat -e '{dummy_pmu_0/test-event-1/,dummy_pmu_0/test-event-2/}:S' -I500 &
		pid=$!
		rand_sleep
		echo 0 > /sys/kernel/debug/dummy_pmu/unbind
		rand_sleep
		rand_sleep
		kill $pid
	}

	N=${1:-1}

	for ((i=0; i<N; i++)); do
		printf "%04u/%04u\n" "$((i+1))" "$N" >&2
		test_noperf
		test_perf_before
		test_kill_perf_later
		test_kill_perf_laaaaaaater
		test_kill_perf_with_leader
		echo >&2
	done

Last patch is optional for a driver and not needed for the fix.

Open topics:

	- If something like the last patch is desirable, should it be
	  done from inside perf_pmu_unregister()?

	- Should we have a dummy_pmu (or whatever name) behind a config,
	  or maybe in Documentation/ ?

thanks,
Lucas De Marchi

Lucas De Marchi (5):
  perf: Add dummy pmu module
  perf: Move free outside of the mutex
  perf: Add pmu get/put
  perf/dummy_pmu: Tie pmu to device lifecycle
  perf/dummy_pmu: Track and disable active events

 include/linux/perf_event.h |  12 +
 kernel/events/Makefile     |   1 +
 kernel/events/core.c       |  39 ++-
 kernel/events/dummy_pmu.c  | 492 +++++++++++++++++++++++++++++++++++++
 4 files changed, 539 insertions(+), 5 deletions(-)
 create mode 100644 kernel/events/dummy_pmu.c

-- 
2.46.2


