Return-Path: <linux-kernel+bounces-263395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C3E93D549
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28A51C23339
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F7B1CD16;
	Fri, 26 Jul 2024 14:44:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF5E17583;
	Fri, 26 Jul 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005053; cv=none; b=mjKQ7qzCJvgY+UU9036zmayRZT317CAFBB73vGPEeLXNhDk4ziprAXLmGJNMbbUNGPvMe2mww5flSVWiY/kvodAQeHPPalnL5ljehfY0PmqnBb8XGBv7crkqc7Rzk4l54ppNGYykPSDcy6QP4JqTJXt3YJW1XQnh5GPPlKLHUBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005053; c=relaxed/simple;
	bh=iBdRYYu80R4lr4jNQXogJH/5xWStbjyUPmDLyowpDvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmV1PDhh55QKU4wEo9cLg4lyohuAaQGHHG95DEv4El7XKc5jn5j58j2tpQtEfvQsQMOywyA/3Gy1A830Cytq2Lz/mo8q4iy47Ks4lblAqSQ+3B3dkW0rSgAbVHwwslNYMfp2D8VljdaIPRlXsEem72nSVjQS/gxAHuYJBHSDY7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 592611007;
	Fri, 26 Jul 2024 07:44:36 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E46A3F5A1;
	Fri, 26 Jul 2024 07:44:08 -0700 (PDT)
Date: Fri, 26 Jul 2024 15:44:06 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, <cristian.marussi@arm.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] clk: scmi: add is_prepared hook
Message-ID: <ZqO2Nn7Wofs_wfkQ@bogus>
References: <20240726131007.1651996-1-peng.fan@oss.nxp.com>
 <20240726135231.hhzp3dqgx64e6kiw@dhruva>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726135231.hhzp3dqgx64e6kiw@dhruva>

On Fri, Jul 26, 2024 at 07:22:31PM +0530, Dhruva Gole wrote:
> On Jul 26, 2024 at 21:10:07 +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > Some clks maybe default enabled by hardware, so add is_prepared hook
> > for non-atomic clk_ops to get the status of the clk. Then when disabling
> > unused clks, those unused clks but default hardware on clks could be
> > in off state to save power.
> 
> Just a nit - reword the commit message as:
> Then when disabling the unused clocks, they can be simply turned OFF to
> save power.
>

Ah this was what it meant. I couldn't parse the original text and was about
to ask.

> Also if you can make it still verbose, explain when you expect this
> disabling of unused clks to take place exactly? During boot?  Driver probe sequence?
> or By some user commands?
>

Agreed. Being little more verbose here would be beneficial IMO.

-- 
Regards,
Sudeep

