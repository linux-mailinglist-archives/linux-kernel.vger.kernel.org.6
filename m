Return-Path: <linux-kernel+bounces-276295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B6B9491D1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E7A1F23AC8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BDE1D2F7A;
	Tue,  6 Aug 2024 13:42:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D4E1D2F56;
	Tue,  6 Aug 2024 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951728; cv=none; b=F6UNfz+GURncVUSDXT61n+987wNvmZS7pjUEqC+9TqVrbjhtBLSZVilmpZkTAtttIbJVWtzhScPtvBehdRojkphq0LLc7hxoOQDgUVjPhh9dCUu4jU7k5eFRfa4VMEgxEYELh6kADJL1gvhTh3jy6r0GUDSbSEcnuu+lRldAHkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951728; c=relaxed/simple;
	bh=pzyYkc0zT5UTgprpaHKFqWUJ4uyiWupZGk5utdJHzLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftbVEYdfU7z3KJCesQaJFpocGM+hYrcQufncwRkxDECaW3qxkIQVD19KfnZFm9GFKi+Og/GsGh8pwdM0WxJHWjDHcxvvEBlAq+/Zxt2rZ4z3AALXlP82U8TQfUF+nl6X1vlPrkOXt2uy+FFe6eX/0Jb0jAntyRaUV3AFEcoQyzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACBEEFEC;
	Tue,  6 Aug 2024 06:42:31 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AFD13F766;
	Tue,  6 Aug 2024 06:42:05 -0700 (PDT)
Date: Tue, 6 Aug 2024 14:42:02 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Etienne Carriere <etienne.carriere@foss.st.com>,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] firmware: arm_scmi: fix voltage description in failure
 cases
Message-ID: <ZrIoKiQVLKuA-YWh@bogus>
References: <20240725065317.3758165-1-etienne.carriere@foss.st.com>
 <ZqO9s9YzYjaCHSap@bogus>
 <ZqtqS9x65zs4qXdt@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqtqS9x65zs4qXdt@pluto>

On Thu, Aug 01, 2024 at 11:58:19AM +0100, Cristian Marussi wrote:
> On Fri, Jul 26, 2024 at 04:16:03PM +0100, Sudeep Holla wrote:
> > On Thu, Jul 25, 2024 at 08:53:17AM +0200, Etienne Carriere wrote:
> > > Reset the reception buffer max size when a voltage domain description
> > > request fails, for example when the voltage domain returns an access
> > > permission error (SCMI_ERR_ACCESS) unless what only a single 32bit
> > > word is read back for the remaining voltage description requests
> > > responses leading to invalid information. The side effect of this
> > > issue is that the voltage regulators registered from those remaining
> > > SCMI voltage domain were assigned a wrong regulator name.
> > > 
> > > Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > > ---
> > >  drivers/firmware/arm_scmi/voltage.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
> > > index 2175ffd6cef5..f1a7c04ae820 100644
> > > --- a/drivers/firmware/arm_scmi/voltage.c
> > > +++ b/drivers/firmware/arm_scmi/voltage.c
> > > @@ -229,8 +229,10 @@ static int scmi_voltage_descriptors_get(const struct scmi_protocol_handle *ph,
> > >  		/* Retrieve domain attributes at first ... */
> > >  		put_unaligned_le32(dom, td->tx.buf);
> > >  		/* Skip domain on comms error */
> > > -		if (ph->xops->do_xfer(ph, td))
> > > +		if (ph->xops->do_xfer(ph, td)) {
> > > +			ph->xops->reset_rx_to_maxsz(ph, td);
> > 
> > I am fine with this to keep it simple, but thought I will check my thoughts.
> > We usually use reset_rx_to_maxsz in iterators as we don't know the expected
> > size of the response, whereas here it must be max sizeof(*resp_dom).
> > 
> > That said, we don't have any helpers and changing xfer->rx.len directly
> > doesn't looks good ? Or may be it is OK ? Thoughts ?
> 
> We do not access those xfer internal field explicitly from the protocol layer
> (beside once in Base)...and surely not on write....in the past I was even
> tempted to try to make these internal stuff untouchable by the protocol layer...
> ...that's the reason of course for the existence of reset_rx_to_maxsz() helpers
> ....not sure if it is worth adding another helper for this, given that the
> using the maxsz should have any adverse effect (unless I am missing
> something of course :P).
> 
> This kind of 'issues' are really common whenever in the SCMI stack we
> reuse the same allocated xfer across multiple do_xfers in a loop
> (reusing seq_nums is another thing...) since we wanted to avoid the
> penalty of resetting some of these automatically on each do_xfer()...
> 
> ....we could think of some mechanism to transparently reset/fill such xfer
> fields automatically if the core detects a 'reuse'....got to check first,
> though, if this does not break some of the current usage patterns...and
> I would not say it is a high prio thing to explore as of now...
> 

Fair enough, I will merge this as is. I think it should be fine. My suggestion
might simply complicates things unnecessarily. Lets not do it unless this
becomes repeating pattern.

-- 
Regards,
Sudeep

