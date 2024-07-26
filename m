Return-Path: <linux-kernel+bounces-263164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC52493D1E3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88481283223
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DE6148312;
	Fri, 26 Jul 2024 11:15:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2504C13AA2E;
	Fri, 26 Jul 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992510; cv=none; b=S5Vmu9DoCKqHIZRjkMZXitf0F5AHK44xrPIjpjpPsVUVWyP4aQQnQ/e1EDasuly/f/MeaCX18ViZ5RmemV0zc5Bvfwy/EpSf/GOFvHXRQSTKor9iIQbwVWwj8PRIxZln2RmB3PkCKOEK4p3LpxI9XT+s6vLbUaYoIwNECTE0iMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992510; c=relaxed/simple;
	bh=U/A4P0CoigDbV1ejmZ7BxeHst+hyAfD6fCPKi/Z8Lbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3JliRyrs4MMeZGng5cqSdRs4B8mvX5q2B0cWAQ4/Rba1ONsH7RTxFVotQdXAEhJD6zD8xNU4p1Y5ucOrXMELVj8Rl4p44u4LWFvBIZhy1y90h5JVb8kdAGaeKjxD2fu6STSEf0tj1w1yY/TwEz/AF2zEmEDwvJjGaXfJhhTOtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCE021007;
	Fri, 26 Jul 2024 04:15:33 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E65EA3F73F;
	Fri, 26 Jul 2024 04:15:06 -0700 (PDT)
Date: Fri, 26 Jul 2024 12:14:54 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, mturquette@baylibre.com,
	sboyd@kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] clk: scmi: add is_prepared hook
Message-ID: <ZqOFLgJiYDrSIDm5@pluto>
References: <20240725090741.1039642-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725090741.1039642-1-peng.fan@oss.nxp.com>

On Thu, Jul 25, 2024 at 05:07:41PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Some clks maybe default enabled by hardware, so add is_prepared hook
> to get the status of the clk. Then when disabling unused clks, those
> unused clks but default hardware on clks could be in off state to save
> power.
> 

Hi Peng,

seems a good addition to me, I forgot to add supporrt for non atomic
scenarios like for clk enable/disable....

...having said that, though, you basically copied the original ATOMIC
version of this function and changed only the ATOMIC -> NON_ATOMIC param
for the state_get() call...

...unless I am missing something, this sounds to me as needless duplication
of code...please rework the original existing function to be an internal helper
acceppting an additinal parameter (ATOMIC, NON_ATOMIC) and then build 2 wrappers
omn top of it for the original and your new function...

Thanks,
Cristian

