Return-Path: <linux-kernel+bounces-437244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629559E90CF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FA12812DE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15571217F49;
	Mon,  9 Dec 2024 10:46:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855EE217739;
	Mon,  9 Dec 2024 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741210; cv=none; b=oBQKi9EsUPBhRrMrG3a5B93oRJGgZKwE1FRbKvR0e5t6iX+NSYYr3c18HJt3h0VeOF7t4CTyjZbBB/cKcHyLZfAzusHE/4FVCI2oQ1pu4n4ILCTPtU1LoRf6MeRN3Fx41kxcC446D1+HLSjmt43M4KDso1/qTrbdJqXR9T0//g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741210; c=relaxed/simple;
	bh=fTFYkbL9/wsQkx54YhY2KnzAwaijQwihIUPEg/UzVAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL9GnhSylfmuj9bGhmnxXwQx2WWr8hB1FIxV+GXE7OjbYWKR1xAf1KE7hNOGPAlmI5RQbyRkL1W0euPD2Q2zAPcUSA0DcWQ84G6svpm7dyO5pe/qjTTVdhQZwBL5uLxobb40BBw2JjO+iLFe+aOFpia8PRc1fF+rtrrPSWu10QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEC04113E;
	Mon,  9 Dec 2024 02:47:15 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B09D03F720;
	Mon,  9 Dec 2024 02:46:46 -0800 (PST)
Date: Mon, 9 Dec 2024 10:46:44 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Etienne Carriere <etienne.carriere@foss.st.com>
Cc: <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, <arm-scmi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: round rate bisecting in
 discrete rates
Message-ID: <Z1bKlOeHJFHpe9ZU@bogus>
References: <20241203173908.3148794-1-etienne.carriere@foss.st.com>
 <20241203173908.3148794-3-etienne.carriere@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203173908.3148794-3-etienne.carriere@foss.st.com>

On Tue, Dec 03, 2024 at 06:39:08PM +0100, Etienne Carriere wrote:
> Implement clock round_rate operation for SCMI clocks that describe a
> discrete rates list. Bisect into the supported rates when using SCMI
> message CLOCK_DESCRIBE_RATES to optimize SCMI communication transfers.

Let me stop here and try to understand the requirement here. So you do
communicate with the firmware to arrive at this round_rate ? Does the
list of discreet clock rates changes at the run-time that enables the
need for it. Or will the initial list just include max and min ?

> Parse the rate list array when the target rate fit in the bounds
> of the command response for simplicity.
>

I don't understand what you mean by this.

> If so some reason the sequence fails or if the SCMI driver has no
> round_rate SCMI clock handler, then fallback to the legacy strategy that
> returned the target rate value.
>

Hmm, so we perform some extra dance but we are okay to fallback to default.
I am more confused.

> Operation handle scmi_clk_determine_rate() is change to get the effective
> supported rounded rate when there is no clock re-parenting operation
> supported. Otherwise, preserve the implementation that assumed any
> clock rate could be obtained.
>

OK, no I think I am getting some idea. Is this case where the parent has
changed and the describe rates can give a different result at run-time.

I need to re-read the part of the spec, but we may need some clarity so
that this implementation is not vendor specific. I am yet to understand this
fully. I just need to make sure spec covers this aspect and anything we
add here is generic solution.

I would like to avoid this extra query if not required which you seem to
have made an attempt but I just want to be thorough and make sure that's
what we need w.r.t the specification.

-- 
Regards,
Sudeep

