Return-Path: <linux-kernel+bounces-438209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D68A9E9E40
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F131886351
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31614197A7A;
	Mon,  9 Dec 2024 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhIjm9b8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1E117836B;
	Mon,  9 Dec 2024 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733769795; cv=none; b=SPd0AAA+WKPNWIZU5J8O0yTIsBc+nxkhUIb2n9rYVQJNmgH9SkjzuOIZY1dwC3ZJ+mZ+BfLCDwEbJL4mzWHlvGUOBdfkAZLpg1imdjMMYhP82nU9ZevRQRnPIwjgZb177/VwieluMyqv2VrBYYds3d8Bn05P/52L/b4FwO1ykw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733769795; c=relaxed/simple;
	bh=oidCVoBY0zjgPWvYnf0lrXH8tzAXlscQHGGvf0VyRRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctUg/qSDgm1nZ0TygIwkiHsS07h0F+PlqxbUtiWSyN/AE1Nr4xI6SDMYAa61O3k1Lg+dXcJN7g1AX74zyzC9jWqulqct5sIoyKLhjmP8Z12lYOY4onz7eSqb/AywZ6seVouu3zp/LGajA9wdsc/b5ym/1PrXH5G8E39Rj5GheRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhIjm9b8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97D5C4CEE0;
	Mon,  9 Dec 2024 18:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733769795;
	bh=oidCVoBY0zjgPWvYnf0lrXH8tzAXlscQHGGvf0VyRRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OhIjm9b8V3uwZoGM9Z5C1oceZArVlNvZeiuYjFsATerVU3Fnu3xg04UlebQYS2T2y
	 egJaFuX9+EedqhbL90l+5iXWIb5VQDTUmL/DC1rJO/GmdpPAHB5mpXLkkAwsEVHnZo
	 e51ZILSCURsCdnEgYDEJnL0cl2+MvgMLai7D5/BHlGnLvmbC8uqMM1ChSCSh8OlBGV
	 OSAEhNGzyvXiC5wwlfArFOHS3f82BZ7aQAbVAPPEThC8BGPDHnFndXS+Z/UZDtf50P
	 WbtUVNoctf/rbkoejEX0lC+7XIA0mNoLKe2/Bo9ivQuK3JusU2OK1ouZ4bQ5Kx23/M
	 oX5V0eBWHk7bA==
From: Will Deacon <will@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/2] perf/dwc_pcie: Fix the swapped event numbers as well as the documentation
Date: Mon,  9 Dec 2024 18:43:03 +0000
Message-Id: <173375912254.1125785.1872820731502163004.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241205061914.5568-1-ilkka@os.amperecomputing.com>
References: <20241205061914.5568-1-ilkka@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 05 Dec 2024 06:19:12 +0000, Ilkka Koskinen wrote:
> According to the versions of Designware Cores PCI Express Controller Databook
> I found, the eventid for "L1 aux" is 0x08 and "TX L0s and RX L0S" is 0x09.
> 
> Shuai and Jing, could you verify that your document matches ours and the events
> are indeed swapped in the driver at the moment?
> 
> Cheers, Ilkka
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/2] perf/dwc_pcie: Fix the event numbers
      https://git.kernel.org/will/c/e64c22cc2e61
[2/2] Documentation: dwc_pcie_pmu: Fix the mnemonics and eventid
      https://git.kernel.org/will/c/8632306e093c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

