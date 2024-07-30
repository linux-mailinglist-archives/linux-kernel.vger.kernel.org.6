Return-Path: <linux-kernel+bounces-267762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FD894152E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A031C2290D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8691A38C9;
	Tue, 30 Jul 2024 15:12:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14941A2C26;
	Tue, 30 Jul 2024 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352328; cv=none; b=MSnrpzwEGCZG5jMLbtn3f2VSk0fTGz8OQb+jojud09HGHxSbOiEXxlA4tQaNxV74PPG9ZmH1E603iPrSktndrpo44+1kodKms9r7Biw9X8xmWXJPRkdgYE57/43rVkN+iaMWP2BihUVTYF3tM+IUCrO/ijzhAXBiWecez3l02kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352328; c=relaxed/simple;
	bh=qxz6p8grmCQWOTDlMrTVHcIPl3gIUw0pdskVXQHBGSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upLwvtJbrnhEnDLlAxEy+ix9/+LphgjhVhJJE2URxCHLsIh2dKK6AZUEvZLvvtuWqHZxrHEn6KOsGezUpeC9RN5/iftlF4NWDvjW2YLJDzreowBvHuyCXtP5kytBmHbWTska+izALmPV23DqDBNOVplVv+ZMfOXMNsaW9m70ri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 031C51007;
	Tue, 30 Jul 2024 08:12:32 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C03C73F5A1;
	Tue, 30 Jul 2024 08:12:04 -0700 (PDT)
Date: Tue, 30 Jul 2024 16:12:02 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Etienne Carriere <etienne.carriere@foss.st.com>
Cc: linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: get only min/max clock rates
Message-ID: <ZqkCwk4jrLUm20in@pluto>
References: <20240729065306.1210733-1-etienne.carriere@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729065306.1210733-1-etienne.carriere@foss.st.com>

On Mon, Jul 29, 2024 at 08:53:06AM +0200, Etienne Carriere wrote:
> Remove limitation of 16 clock rates max for discrete clock rates
> description.
> 

Hi Etienne,

> Driver clk-scmi.c in only interested in the min and max clock rates.
> Get these by querying the first and last discrete rates with SCMI
> clock protocol message ID CLK_DESCRIBE_RATES since the SMCI clock
> protocol specification states that rates enumerated by this
> command are to be enumerated in "numeric ascending order" [1].
> 

While I understand the positive optinization of not having to query the
full list of clock domains in order to retrieve just min/max (that are
the only interesting clocks for CLK framework), and the removal of the
artificial 16 clocks limit, I would NOT drop in its entirety the original
well tested code used to query the full list (based on iterators), because
it will be most probably needed anyway in the future to implement
determine_rate via bisection (if I udnerstood correctly what you meant
in our offline chat) and because it would be needed anyway for testing
purposes.

IOW, why dont you do exactly what you did BUT within a new distinct
scmi_describe_min_max_rates() helper, WHILE keeping the original code
scmi_clock_describe_rates_get() unchanged, and start calling your new
method at init to retrieve only max/min ?

So that we can attach anyway (now or then) a new 'lazy' ops to the old
method and use it to retrieve the full list of clocks when needed (for
testing or whatever).

Thanks,
Cristian

