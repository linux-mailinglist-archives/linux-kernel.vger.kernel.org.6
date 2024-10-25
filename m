Return-Path: <linux-kernel+bounces-381881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630049B05DC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E651C229BA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BC0206513;
	Fri, 25 Oct 2024 14:30:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1FF4204D;
	Fri, 25 Oct 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866653; cv=none; b=KRfFMcLZLS1Hl2pJFvv2Fzptc6IYzlqmJk6iv12Q+4oTgtOEaUCiXwcc2tVjUyeQ1SEEJqMwlcIqp+7T1l68TS5OMgva3WmtVpOgQeSaxW7vALMgXfc82pKVPuf5y6XuTrQ97Pk3pTzzOSlL65Fl+e6xU0vNdc640+4LfrCInZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866653; c=relaxed/simple;
	bh=mPUPmKeL6ZXcb5ZSM0wWX/IhZGDoVeZn6LNpnUkFjho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=feCElTW+3j3bZ5rhdvXvBkrXp09dd8EZyyNxUlMDAAEKcRfMmz9GBsPUilRVNOmuMN1GjVSC3cSrNU41dPuZKXoRU6GErj5O/nRJNEIpGHUAFcoHGq9+K/AHCHamEgtIwlkCDHrMPYylxF0TfX7y1NsjkRNp26hI2ekq+VhIFvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C30D1339;
	Fri, 25 Oct 2024 07:31:20 -0700 (PDT)
Received: from VDW30FN91H.arm.com (unknown [10.57.79.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C32CF3F73B;
	Fri, 25 Oct 2024 07:30:48 -0700 (PDT)
From: Graham Woodward <graham.woodward@arm.com>
To: acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	jolsa@kernel.org,
	irogers@google.com,
	james.clark@linaro.org,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: nd@arm.com,
	Graham Woodward <graham.woodward@arm.com>
Subject: [PATCH v1 0/4] perf arm-spe: Allow synthesizing of branch
Date: Fri, 25 Oct 2024 15:30:05 +0100
Message-Id: <20241025143009.25419-1-graham.woodward@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the --itrace=b will only show branch-misses but this change
allows perf to synthesize branches as well.

The change also incorporates the ability to display the target
addresses when specifying the addr field if the instruction is a branch.

Graham Woodward (4):
  perf arm-spe: Set sample.addr to target address for instruction sample
  perf arm-spe: Use ARM_SPE_OP_BRANCH_ERET when synthesizing branches
  perf arm-spe: Correctly set sample flags
  perf arm-spe: Update --itrace help text

 tools/perf/Documentation/itrace.txt       |  2 +-
 tools/perf/Documentation/perf-arm-spe.txt |  2 +-
 tools/perf/builtin-script.c               |  1 +
 tools/perf/util/arm-spe.c                 | 31 ++++++++++++++++++-----
 tools/perf/util/auxtrace.h                |  3 +--
 tools/perf/util/event.h                   |  1 +
 6 files changed, 29 insertions(+), 11 deletions(-)

-- 
2.40.1


