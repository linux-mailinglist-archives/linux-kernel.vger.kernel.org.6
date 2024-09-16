Return-Path: <linux-kernel+bounces-330920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D244497A61A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1072E1C24BCD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D7915C125;
	Mon, 16 Sep 2024 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzksN/1y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA3B15A868;
	Mon, 16 Sep 2024 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726504409; cv=none; b=iUjPchwUuvdgDlMcoQiT1qBCLuVQn5Fxm8i817ySxHn+E/2ow/lgPHo0Ufz+1nXy6rjA5SZdq14nn+Fx7oNPZCcK77T2kP0kAmRg023pclCvHfGjx4Bf2bijf/jvi1Di6fK4bLgkrV07PrIk9+w8G4ejlrHxC5BrKI24TDhESLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726504409; c=relaxed/simple;
	bh=LTV/SK281Cal42wiKOz53x0IXLkVChSABC/BP/VI3wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaUTIYDz1oPT4eHIlr9XTFvXEJueRgvkkD5taFTkuZYAWOf7vVNOZnSbBLHnjor7PMufG+MFt/AvkQ5wlKk2x8zLsf/4VYkJz2zM/ZTWv4gtmihDqnWvc9IVL695O9sBIPEwiajPuKK9f1c739PxrUp1lVGPRnG74dnUl8mYFtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzksN/1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B802C4CEC4;
	Mon, 16 Sep 2024 16:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726504409;
	bh=LTV/SK281Cal42wiKOz53x0IXLkVChSABC/BP/VI3wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SzksN/1yUwTTjiHJfNWPLZHQgGbkSr7E/90kQw06Xwe7N5Z2EZoLxJiVRJ31roHVI
	 8utPbOyizgkAZI+5jt3cAAheM8RjiXHG6gpVBiNHhNA//R0iMZTVoj6n+WVpvmKy7V
	 wpGe7iEsGCVW9v1q+tjZB5gk1gS6kwn3x45zAvC8YRP1tZ9IPkF3Vq9UYZZXdD9/q0
	 29czTIzPvs1rJ9XW5dDq36WxGONwQBOP8Wt9jAvYm6z+2/LyPo9qdY51dBU4FZ5PtI
	 QMuSiFs6Wt4AkdrErdQCvSEhfUAGhoUlegPPjEXclAo/URbH3l8SLW6a8t+tlsCmjx
	 gFuMvCe28c7DA==
Date: Mon, 16 Sep 2024 11:33:28 -0500
From: Rob Herring <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Amit Sunil Dhamne <amitsd@google.com>,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, kyletso@google.com,
	rdbabiera@google.com, Badhri Jagan Sridharan <badhri@google.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC 1/2] dt-bindings: connector: Add property to set pd timer
 values
Message-ID: <20240916163328.GA394032-robh@kernel.org>
References: <20240911000715.554184-1-amitsd@google.com>
 <20240911000715.554184-2-amitsd@google.com>
 <5iakowhmqc3hbstmwbs6ixabr27hf2dfz2m4do4qvsrtgrdn72@r7xqawwgebla>
 <dc323138-3bbb-4e23-91f1-d6b80cb7bb72@google.com>
 <ascu5yztalk62fernydttkywnqemnmjlcflzdyfmt7dzuzngho@vvxrnvwhfdmk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ascu5yztalk62fernydttkywnqemnmjlcflzdyfmt7dzuzngho@vvxrnvwhfdmk>

On Fri, Sep 13, 2024 at 07:34:27AM +0300, Dmitry Baryshkov wrote:
> On Thu, Sep 12, 2024 at 04:26:25PM GMT, Amit Sunil Dhamne wrote:
> > Hi Dmitry,
> > 
> > On 9/12/24 3:05 AM, Dmitry Baryshkov wrote:
> > > On Tue, Sep 10, 2024 at 05:07:05PM GMT, Amit Sunil Dhamne wrote:
> > > > This commit adds a new property "pd-timers" to enable setting of
> > > > platform/board specific pd timer values for timers that have a range of
> > > > acceptable values.
> > > > 
> > > > Cc: Badhri Jagan Sridharan <badhri@google.com>
> > > > Cc: linux-usb@vger.kernel.org
> > > > Cc: devicetree@vger.kernel.org
> > > > Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> > > > ---
> > > >   .../bindings/connector/usb-connector.yaml     | 23 +++++++++++++++++++
> > > >   include/dt-bindings/usb/pd.h                  |  8 +++++++
> > > >   2 files changed, 31 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > > index fb216ce68bb3..9be4ed12f13c 100644
> > > > --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > > +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > > @@ -253,6 +253,16 @@ properties:
> > > >       additionalProperties: false
> > > > +  pd-timers:
> > > > +    description: An array of u32 integers, where an even index (i) is the timer (referenced in
> > > > +      dt-bindings/usb/pd.h) and the odd index (i+1) is the timer value in ms (refer
> > > > +      "Table 6-68 Time Values" of "USB Power Delivery Specification Revision 3.0, Version 1.2 " for
> > > > +      the appropriate value). For certain timers the PD spec defines a range rather than a fixed
> > > > +      value. The timers may need to be tuned based on the platform. This dt property allows the user
> > > > +      to assign specific values based on the platform. If these values are not explicitly defined,
> > > > +      TCPM will use a valid default value for such timers.
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > Is it really necessary to use the array property? I think it's easier
> > > and more logical to define corresponding individual properties, one per
> > > the timer.
> > 
> > Thanks for the review. The reason I did it this way was for
> > convenience. If in the future someone else wants add a new timer,
> > it'd be convenient to just add it as a new macro definition in pd.h
> > rather than having to define a new property each time, especially
> > if folks want to add more timers (scales better).
> > There are 3 timers already and I am working to add a fourth in a
> > follow up patch if the current RFC gets accepted.
> > 
> > Please let me know what do you think?
> 
> I'd leave the decision to DT maintainers, but in my opinion multiple
> properties scale better. Having a single value per property is easier to
> handle rather than changing the tagged array.

I agree. And it avoids what looks like a made up number space with the 
defines.

And note that an array of tuples is a matrix in DT defined types, not 
an array.

Rob

