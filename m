Return-Path: <linux-kernel+bounces-371818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 783389A40CD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E661C25BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22091DF24F;
	Fri, 18 Oct 2024 14:10:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F7384D02;
	Fri, 18 Oct 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260632; cv=none; b=dv8EGs9Jg6ecBY9M+qFw9TyOefj5nrk5zNlaqifYaU4ZzbBOPPMwGd6ikZO1ehLiUBQFGv87qNOOpiI7WrIdvOtwn3EyG5nE6+7ttLZ9zaxU8f/R2RNFWF4ITjHZkfgzyYHZ5qj8YOXUni81PtgZeSylg8MSgfLol3DOfT+50BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260632; c=relaxed/simple;
	bh=LAQgeEAlcW2yjN1UqXgmAghx/dQhsP8nXKDlbuyHbC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzSaHXMJrDPXc9wasnf9+TkzajHoc7OTRVxlss41ggRo9nKLqAg4At/Mm4uDQhJFwUEjN+RFB9TOzePpxGUzI1y7jnXEMKHj/au9xRoz4Y0CeShdQS16XBEqVZk4yRCSYzZts+LrFvh2AvnAS6QT45Z++kND4CpNpMUW0Wffcfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E4C5497;
	Fri, 18 Oct 2024 07:10:59 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED8593F58B;
	Fri, 18 Oct 2024 07:10:26 -0700 (PDT)
Date: Fri, 18 Oct 2024 15:10:18 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Rob Herring <robh@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, dan.carpenter@linaro.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 3/5] dt-bindings: firmware: arm,scmi: Introduce more
 transport properties
Message-ID: <ZxJsSggCLCCoaC2m@pluto>
References: <20241018080602.3952869-1-cristian.marussi@arm.com>
 <20241018080602.3952869-4-cristian.marussi@arm.com>
 <20241018133340.GA72220-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018133340.GA72220-robh@kernel.org>

On Fri, Oct 18, 2024 at 08:33:40AM -0500, Rob Herring wrote:
> On Fri, Oct 18, 2024 at 09:06:00AM +0100, Cristian Marussi wrote:
> > Depending on specific hardware and firmware design choices, it may be
> > possible for different platforms to end up having different requirements
> > regarding the same transport characteristics.
> > 

Hi Rob,

thanks for having a look.

> > Introduce max-msg-size and max-msg properties to describe such platform
> > specific transport constraints, since they cannot be discovered otherwise.
> > 
> > Cc: devicetree@vger.kernel.org
> > Cc: Rob Herring (Arm) <robh@kernel.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  .../devicetree/bindings/firmware/arm,scmi.yaml   | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > index 54d7d11bfed4..42852ed887f2 100644
> > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > @@ -131,6 +131,22 @@ properties:
> >        be a non-zero value if set.
> >      minimum: 1
> >  
> > +  max-msg-size:
> 
> Vendor prefix needed.

Ok, but these are common properties like max-rx-timeout-ms and others in this
bindings so I did not expect to have to explicit set a vendor...well I
really dont know what's the rule here, so I went for similarity.

> 
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      An optional value, expressed in bytes, representing the maximum size
> > +      allowed for the payload of messages transmitted on this transport.
> > +      If set it is recommended to be greater or equal than the minimum size
> > +      required to support all the messages defined by the set of protocols
> > +      implemented on this platform.
> 
> Sounds kind of broken if less than the minimum...
> 

Well, absolutely but the minimum payload really depends on how many
protocols the SCMI server in firmware supports on this platform...the
set of implemented messages (some are optional) AND the spec version
number...so I cannot state really a fixed safe minimum here...it was
just a polite warning for the user not to shot himself in the foot...
..but whoever missteps over this will see a lot of comms errors
indeed...I will drop the warning in V2

> > +
> > +  max-msg:
> 
> Vendor prefix and could be a bit more specific what this is.

Ok I will explain more in v2.

Thanks,
Cristian

