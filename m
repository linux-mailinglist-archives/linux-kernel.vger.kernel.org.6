Return-Path: <linux-kernel+bounces-549160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F798A54E5C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD9A16699F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349DF18B463;
	Thu,  6 Mar 2025 14:54:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744FC1865E2;
	Thu,  6 Mar 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272898; cv=none; b=eqTFhvWO9I7mLj5UCuaJynlq8xPWkTVvGEaIgUaQbyirqOYbai/MjnZMe43sDV6kN3n/Wtw7F2S00ZUJ+ySsY7rCIzomxOKa6NpxNTZiQfggom5U5R/N+Nsv6IK13SbXk/J4+5r0PWT2PZp7ZmOVrVF1ZxvB4sdni/6nhYUaXQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272898; c=relaxed/simple;
	bh=G/7ufUZAgQpnpck1JlJdbyEAj4moMXPcIbdHDJkvMRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpmREIdDEPotyag2l1ZsFwu96YVzZu8JONiwOW4Cla4Akw6E0ZqqYGpku4lgPsCoRvLPx1gypyINrCyCn5cPypGGokVnUyWUOgllKT2INB8ZNJQ1Ymlk7IG2LbDY4DjL4BwIa2B76GhZTtW8aLRBAx6Od0GMM+96Thaxw+vo4Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B15B1007;
	Thu,  6 Mar 2025 06:55:08 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C57E93F66E;
	Thu,  6 Mar 2025 06:54:53 -0800 (PST)
Date: Thu, 6 Mar 2025 14:54:50 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>, Yao Zi <ziyao@disroot.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-rockchip@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: enable SCMI clk for RK3528 SoC
Message-ID: <Z8m3OkHAedbQyKbu@bogus>
References: <20250306131016.281290-1-amadeus@jmu.edu.cn>
 <20250306131016.281290-2-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306131016.281290-2-amadeus@jmu.edu.cn>

On Thu, Mar 06, 2025 at 09:10:16PM +0800, Chukun Pan wrote:
> Same as RK3568, RK3528 uses SCMI clk instead of ARMCLK.
> Add SCMI clk for CPU, GPU and RNG will also use it.
> 

It is highly recommended not to use clock protocol for CPUs and GPUs
especially if the plan is to drive regulators separately. Please use
the performance protocol instead which can abstract the clock and the
regulator details for the OS.

-- 
Regards,
Sudeep

