Return-Path: <linux-kernel+bounces-263435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D85B93D5CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8BF1F243CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D4E1EB31;
	Fri, 26 Jul 2024 15:16:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B241168C7;
	Fri, 26 Jul 2024 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006969; cv=none; b=RhCQfYrOLlVoiKGivXLSQhHqPi7yemc2uVM0C3g/yhoj60cpU+VsZ5SyEOGD3JQUCDlt0XDKDKHHwkDjbmzx1yTsjZulLSskFhxGuTOjK+EaluuDWLviHCu2ClDND43AX3mq3FuuFM7BlazkykhDi7GVlEtUPZJk2xNYYpMA2yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006969; c=relaxed/simple;
	bh=SjYuF0wHvMidJzi2rqAX+BCgJqz8mbzUz6DGGs/7Ki0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMTt7RmYz4Q6Jmr1IPrNoC1XObKjpzzXXWvdiLXnBvBsDX7KJ6hHktY7HMRadGdZeTddtIpMVTpjPwxidETfY94lGcyRAlQu5iFrh+mbFACb6tQgxoRV8uV7qHDDLspv6GLWJqITM78fdOYzSF+iJJLBeJqAzmmAChbd1SA80KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54A7A1007;
	Fri, 26 Jul 2024 08:16:32 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 161E33F73F;
	Fri, 26 Jul 2024 08:16:05 -0700 (PDT)
Date: Fri, 26 Jul 2024 16:16:03 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Etienne Carriere <etienne.carriere@foss.st.com>
Cc: <linux-kernel@vger.kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	<arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] firmware: arm_scmi: fix voltage description in failure
 cases
Message-ID: <ZqO9s9YzYjaCHSap@bogus>
References: <20240725065317.3758165-1-etienne.carriere@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725065317.3758165-1-etienne.carriere@foss.st.com>

On Thu, Jul 25, 2024 at 08:53:17AM +0200, Etienne Carriere wrote:
> Reset the reception buffer max size when a voltage domain description
> request fails, for example when the voltage domain returns an access
> permission error (SCMI_ERR_ACCESS) unless what only a single 32bit
> word is read back for the remaining voltage description requests
> responses leading to invalid information. The side effect of this
> issue is that the voltage regulators registered from those remaining
> SCMI voltage domain were assigned a wrong regulator name.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> ---
>  drivers/firmware/arm_scmi/voltage.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
> index 2175ffd6cef5..f1a7c04ae820 100644
> --- a/drivers/firmware/arm_scmi/voltage.c
> +++ b/drivers/firmware/arm_scmi/voltage.c
> @@ -229,8 +229,10 @@ static int scmi_voltage_descriptors_get(const struct scmi_protocol_handle *ph,
>  		/* Retrieve domain attributes at first ... */
>  		put_unaligned_le32(dom, td->tx.buf);
>  		/* Skip domain on comms error */
> -		if (ph->xops->do_xfer(ph, td))
> +		if (ph->xops->do_xfer(ph, td)) {
> +			ph->xops->reset_rx_to_maxsz(ph, td);

I am fine with this to keep it simple, but thought I will check my thoughts.
We usually use reset_rx_to_maxsz in iterators as we don't know the expected
size of the response, whereas here it must be max sizeof(*resp_dom).

That said, we don't have any helpers and changing xfer->rx.len directly
doesn't looks good ? Or may be it is OK ? Thoughts ?

--
Regards,
Sudeep

