Return-Path: <linux-kernel+bounces-297110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF44995B33F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843AF1F237BC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAB9183CB4;
	Thu, 22 Aug 2024 10:53:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70FB181B8D;
	Thu, 22 Aug 2024 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324020; cv=none; b=FL9VYqiEo6UHWNWrNCORWTeGjPL+CJs68bE8+bGvQplHzk1/UEJBMO1bap1YGiFLanrIc8T5OoBFmFdw7iU070AmuY9070afJ8eckwqDqDTvkbP8sEVfX5iMZQEm2a2oWQQwIZJhBjSc6NxgzI1EMkEz0obRPb/BFI5SdHXZ6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324020; c=relaxed/simple;
	bh=iPVlGgZyU8HblskgKh2r3WLM6fRW2ymeJAAHJf7S6Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYXf13e9QLW0jLHV1Vrml2bjl5AsEdCxRlqc/+R8EVf19+pDZL5SFpKjopwcCuEWdZ2q8FsodT/APtJxbtmtiBipcwbK7bjIiBXgy1y83QJHZ0NmluonSeqE96xCSam3n9CPdCD0NhVmWfX8ZWacEGKOQ7/ss6WQHkwUqx+7gVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19BEADA7;
	Thu, 22 Aug 2024 03:54:03 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.198.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB4023F58B;
	Thu, 22 Aug 2024 03:53:34 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:53:31 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: cristian.marussi@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, d-gole@ti.com,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3] clk: scmi: add is_prepared hook
Message-ID: <ZscYq5rFUKJiHR5y@bogus>
References: <20240806145601.1184337-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806145601.1184337-1-peng.fan@oss.nxp.com>

On Tue, Aug 06, 2024 at 10:56:01PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Some clocks maybe default enabled by hardware. For clocks that don't
> have users, that will be left in hardware default state, because prepare
> count and enable count is zero,if there is no is_prepared hook to get
> the hardware state. So add is_prepared hook to detect the hardware
> state. Then when disabling the unused clocks, they can be simply
> turned OFF to save power during kernel boot.
>

LGTM,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

IIUC, there is no dependency on any SCMI changes, so this can go alone
via clk tree.

-- 
Regards,
Sudeep

