Return-Path: <linux-kernel+bounces-437203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB59D9E9044
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB632818E2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734C2217667;
	Mon,  9 Dec 2024 10:33:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588F512D758;
	Mon,  9 Dec 2024 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740425; cv=none; b=ieJY2abXgE2b7coKMNvopY5/ufmhayDNVTj+xqtLgUMeVZx4Qe0C2HI3PAda/NGzm5r899+iee4fLji7JV2P0XeWRktTRGlSQn1OrvVMnpICTuTTeSLcRbOQq7FhVtptBwp5tQ3GWMfIqkibOILpZH9iBGNN2lxwoqKHNmiGb3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740425; c=relaxed/simple;
	bh=UaZ8G9DX7Of7P+UA09Bxzh2wWuKF9zAhcVH8zF55BeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TA4iFH9O4uNuwYJ85SkjEoFSe7a7NOuKhdHapzJQYpAmBVOTmtigz19kEJvATYILyvlkvKRJlA1UqIGV7/2MnEs8B5r4ryS0WFYP+Zz32Adw7NYW6+n8N8pWxPfaPbytSRNtffcZmULvnYlu4SfiTHatgEnjqjd98SX9CU60GdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0EAA113E;
	Mon,  9 Dec 2024 02:34:09 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06C4C3F720;
	Mon,  9 Dec 2024 02:33:39 -0800 (PST)
Date: Mon, 9 Dec 2024 10:33:37 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Etienne Carriere <etienne.carriere@foss.st.com>
Cc: <linux-kernel@vger.kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, <arm-scmi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] firmware: arm_scmi: get only min/max clock rates
Message-ID: <Z1bHgf_4qqZgSnDt@bogus>
References: <20241203173908.3148794-1-etienne.carriere@foss.st.com>
 <20241203173908.3148794-2-etienne.carriere@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203173908.3148794-2-etienne.carriere@foss.st.com>

On Tue, Dec 03, 2024 at 06:39:07PM +0100, Etienne Carriere wrote:
> Remove limitation of 16 clock rates max for discrete clock rates
> description when the SCMI firmware supports SCMI Clock protocol v2.0
> or later.
>
> Driver clk-scmi.c is only interested in the min and max clock rates.
> Get these by querying the first and last discrete rates with SCMI
> clock protocol message ID CLOCK_DESCRIBE_RATES since the SCMI
> specification v2.0 and later states that rates enumerated by this
> command are to be enumerated in "numeric ascending order" [1].
>
> Preserve the implementation that queries all discrete rates (16 rates
> max) to support SCMI firmware built on SCMI specification v1.0 [2]
> where SCMI Clock protocol v1.0 does not explicitly require rates
> described with CLOCK_DESCRIBE_RATES to be in ascending order.
>
> Link: https://developer.arm.com/documentation/den0056 [1]
> Link: https://developer.arm.com/documentation/den0056/a [2]
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> ---

[...]

> +
> +static int scmi_clock_get_rates_bound(const struct scmi_protocol_handle *ph,
> +				      u32 clk_id, struct scmi_clock_info *clk)
> +{

This new function seem to have unwraped the scmi_iterator_ops(namely
prepare_message, update_state and process_response instead of reusing them.
Can you please explain why it wasn't possible to reuse them ?

--
Regards,
Sudeep

