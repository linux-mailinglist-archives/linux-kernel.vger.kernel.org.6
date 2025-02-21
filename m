Return-Path: <linux-kernel+bounces-526160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECA1A3FAE9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5647F7A538A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83402286298;
	Fri, 21 Feb 2025 16:11:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C13F211A29
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154305; cv=none; b=cx39k0rVh8qFmLJibOjrXJ1sZBsrs8f36ZHYrhmyBVy+PPmUGPTdGFxzqwP3mk3xrWhY0STGv/0cJwauxW+amwtwiK6kNTDqpsejIYMxQTrb2DMymMeKQVa96mRUwRHoCH+yhyVnupUsKdRZxxGsxMomsOo4g5XpKDaTIPLdb5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154305; c=relaxed/simple;
	bh=jPzhQLziuukG5FdheaOtRYonGAgmyp9BzYy+rI+G5/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZQCmiA9AyREEazBoBTLcvpKQDgRNYnz/y3hKfJnqp/naCfVEbLqWAsJxFGmNe0RFJTlW1yizlDLr3x1V1GeSnWR2kfBdYhFE1SeEmeq29ZKEFID1vDpaU9Y8AOfKBWkc/DP9ldZ5xdpRfbB+vAa52X04EaPIqhIXvCIrrU6ufI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 691C9168F;
	Fri, 21 Feb 2025 08:12:00 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 846A43F5A1;
	Fri, 21 Feb 2025 08:11:41 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org
Subject: Re: [PATCH] coresight: catu: Fix number of pages while using 64k pages
Date: Fri, 21 Feb 2025 16:11:34 +0000
Message-ID: <174015423971.1326003.7421875844813609772.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250109215348.5483-1-ilkka@os.amperecomputing.com>
References: <20250109215348.5483-1-ilkka@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 9 Jan 2025 21:53:48 +0000, Ilkka Koskinen wrote:
> Trying to record a trace on kernel with 64k pages resulted in -ENOMEM.
> This happens due to a bug in calculating the number of table pages, which
> returns zero. Fix the issue by rounding up.
> 
> $ perf record --kcore -e cs_etm/@tmc_etr55,cycacc,branch_broadcast/k --per-thread taskset --cpu-list 1 dd if=/dev/zero of=/dev/null
> failed to mmap with 12 (Cannot allocate memory)
> 
> [...]

Applied, thanks!

[1/1] coresight: catu: Fix number of pages while using 64k pages
      https://git.kernel.org/coresight/c/0e14e062f5ff

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

