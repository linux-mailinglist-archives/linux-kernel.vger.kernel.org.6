Return-Path: <linux-kernel+bounces-311739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEC9968CF7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3031F232D5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7601A2640;
	Mon,  2 Sep 2024 17:52:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2581CB52F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725299533; cv=none; b=cy1VS0/tcJL9zG/fJ3KzoLwoSeKqyfQtSG4MRxI3tOFqbiBodrtEK3wRvSfT5gQ/vb/Xu/X6+GM+fLfhBVjT4t+bvWWgwQwkx66GoyggYyIeCckwjySw2acLmqpI0Tpy4RYlVFqkML3K7O0HkS1fQnGxIwynBBcI1OKqaZeEcFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725299533; c=relaxed/simple;
	bh=18EsnKwXoR/NZy/FYnJ0l1mxBoJEyAi3aHTvpmylmn8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k0FqMpeuwPlvz3wEV4VgSkl0CkMynsk4DkyaGH2QQUHb9BmODdyisVghKMc8l2lQHc9Tnq21W/GIr6gFyAL3vunzduEvs2U8LOhNgYghS4KpHIMMxk9TVk+8ltM/3GY0u08Oz79o9HRvB+wX7aR6oKRiyk9qAdhyXCwOHgK4fa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BAFAFEC;
	Mon,  2 Sep 2024 10:52:35 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6308B3F73B;
	Mon,  2 Sep 2024 10:52:08 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ilkka@os.amperecomputing.com
Subject: [PATCH v2 0/8] perf/arm-cmn: Fixes and updates
Date: Mon,  2 Sep 2024 18:51:56 +0100
Message-Id: <cover.1725296395.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-arm-kernel/cover.1723229941.git.robin.murphy@arm.com/

Hi all,

Here's v2 addressing Mark and Ilkka's comments. I hope I've added
sufficient clarification to patch #5, but at worst I'd be OK with
landing the rest while that discussion continues.

Thanks,
Robin.


Robin Murphy (8):
  perf/arm-cmn: Refactor node ID handling. Again.
  perf/arm-cmn: Fix CCLA register offset
  perf/arm-cmn: Ensure dtm_idx is big enough
  perf/arm-cmn: Improve build-time assertion
  perf/arm-cmn: Make cycle counts less surprising
  perf/arm-cmn: Refactor DTC PMU register access
  dt-bindings: perf: arm-cmn: Add CMN S3
  perf/arm-cmn: Support CMN S3

 .../devicetree/bindings/perf/arm,cmn.yaml     |   1 +
 drivers/perf/arm-cmn.c                        | 308 ++++++++++--------
 2 files changed, 175 insertions(+), 134 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty


