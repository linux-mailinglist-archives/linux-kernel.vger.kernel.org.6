Return-Path: <linux-kernel+bounces-533528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD18A45BB2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94DCE7A63CE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE6C238171;
	Wed, 26 Feb 2025 10:26:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600A71E1DE1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565581; cv=none; b=LqbJi7wf4Ng4kpHRprDQHjEg3RgIZVKfcKrLCeYjIC7+I+Sdxzwdf+jfpmJ8T1PpiP4V1gA7vmwjvjks2gWJNDnVVNz0ZJpziRZ3zOgwzMXrJMU9OKYUnor0diWDrUjS6435DTzQKJBR40V//aEW3qjvk+B7Su0e5mGeXd5crBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565581; c=relaxed/simple;
	bh=ZXCH/7yRwlRW+bd48KB7gPCKxzcfW06BFnSMRuuPl9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2odrRVNW7uoAWGAK8GG0qhjySfFTal2OGNIKU8B+bvPrTs6z2WH+YnKZU3fu/OCaCOz4kwZoTL8ognqgntKH8ZmGzND+Oy/CF+Xmoa8pO7S8EPWMHb1FV7ZneSPjHx0Fr8vp8Erx5FI8DdX2Sw7RlbZQtYKoLARaawUxQz9M1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F1121BA8;
	Wed, 26 Feb 2025 02:26:35 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 40F503F6A8;
	Wed, 26 Feb 2025 02:26:18 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Yuanfang Zhang <quic_yuanfang@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	kernel@quicinc.com,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] coresight-etm4x: add isb() before reading the TRCSTATR
Date: Wed, 26 Feb 2025 10:26:09 +0000
Message-ID: <174056556176.1596152.13438853429197428752.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116-etm_sync-v4-1-39f2b05e9514@quicinc.com>
References: <20250116-etm_sync-v4-1-39f2b05e9514@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 16 Jan 2025 17:04:20 +0800, Yuanfang Zhang wrote:
> As recommended by section 4.3.7 ("Synchronization when using system
> instructions to progrom the trace unit") of ARM IHI 0064H.b, the
> self-hosted trace analyzer must perform a Context synchronization
> event between writing to the TRCPRGCTLR and reading the TRCSTATR.
> Additionally, add an ISB between the each read of TRCSTATR on
> coresight_timeout() when using system instructions to program the
> trace unit.
> 
> [...]

Applied, thanks!

[1/1] coresight-etm4x: add isb() before reading the TRCSTATR
      commit: 5bb4fbbcaa3a66c0fd9347a19e6dae86a48e63ab

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

