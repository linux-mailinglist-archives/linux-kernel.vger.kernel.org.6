Return-Path: <linux-kernel+bounces-567496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D939FA686EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2304C17B7FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5B82512E8;
	Wed, 19 Mar 2025 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJYYznFa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFCC24E4D2;
	Wed, 19 Mar 2025 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373243; cv=none; b=AGszSCQ8f5h7PIp31U41zb9ccH1PioEv1OrV2SbW9mRJ5lHIXS0MBjR1hDYhw6fR58FJdq2GhlY/HbDLEEObal5lpGuCegmWC2ivBA0h+AZag6aEjOFnXYWn0EVUMemRAt4ShRcIpUJDvrwwwsjX8chvxFFMG2iVsLAJMdO1I/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373243; c=relaxed/simple;
	bh=uHvP5v7oifXK6felVK4bK42cu7yy9x6VTVSPes59okU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9JR1qkXqh5SHMfd8ZONIHgZUqmeha4iqFQYcnNOT5AP2YA2Idgc9VJGfuJrlZw+FPn0Hmb+GQnSh/f1Cz/UM2Z/krn7JRqHZdN3PV1bNWRc/nh6ghn/wc4qsVPdcM7sNnlTQOmKGL4mWQNm/7iZf5zhHocSY7mMjF2OYYmaqHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJYYznFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487C9C4CEEF;
	Wed, 19 Mar 2025 08:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742373243;
	bh=uHvP5v7oifXK6felVK4bK42cu7yy9x6VTVSPes59okU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJYYznFaUu+VoupKyTZDR38lR2kdDtpPfGJfuqyBdYqwj+lYgFFggKrK4wWhos2cl
	 aAb93us0ya5aY809KshBxieVJB935C1RYf2coB2dGTUcT16dPduenoP1PumfYxHYap
	 wtc667FkA24dYiwNhn3p0Ea/TpVwl0NEprbtTnKLTa2VsNvOvO224zTp3ZvXg0s7mG
	 0e+lGFa5v38rPF98/FsREiEAtNK6JZVodh/xGTy6ugnmkSnXyAi50zHSQPfe6wDGLc
	 mGEb5/aZzI3wjfCRRkIAivwjYWdcz2XbJbPvRtG5uZBy5DU6vWx8rhW6LwwM3x6QPD
	 lizlcx6I6/SyQ==
Date: Wed, 19 Mar 2025 09:33:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, florin.leotescu@oss.nxp.com, 
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Shych <michaelsh@nvidia.com>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viorel.suman@nxp.com, carlos.song@nxp.com, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, festevam@gmail.com, 
	Florin Leotescu <florin.leotescu@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: hwmon: Add Microchip emc2305 support
Message-ID: <20250319-auspicious-sparkling-dachshund-ef0eed@krzk-bin>
References: <20250318085444.3459380-1-florin.leotescu@oss.nxp.com>
 <20250318085444.3459380-2-florin.leotescu@oss.nxp.com>
 <7afcd224-1154-4e2f-b383-10f6a89fdae0@roeck-us.net>
 <CAEnQRZBmYdLh29ha1FKz8=CbxjFBFFTgDkjrEmwTxW2WcxodfA@mail.gmail.com>
 <ca734f66-593f-4e7c-bc76-e343a7eb88d7@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca734f66-593f-4e7c-bc76-e343a7eb88d7@roeck-us.net>

On Tue, Mar 18, 2025 at 09:37:29AM -0700, Guenter Roeck wrote:
> > > > +patternProperties:
> > > > +  '^fan@[0-4]$':
> > > > +    $ref: fan-common.yaml#
> > > > +    unevaluatedProperties: false
> > > > +    properties:
> > > > +      reg:
> > > > +        description:
> > > > +          The fan number used to determine the associated PWM channel.
> > > > +
> > > > +    required:
> > > > +      - reg
> > > > +      - pwms
> > > 
> > > Is it necessary to make 'pwms' mandatory ? The current code works
> > > just fine with defaults.
> > 
> > The code adding OF support is added just in the next patch, so the
> > current code isn't event
> > probed when trying to use dts.
> > 
> > Or am I missing something?
> > 
> 
> The patch introducing devicetree support to the driver doesn't evaluate
> the pwm property. That makes it quite obvious that, from driver perspective,
> it isn't needed. I don't immediately see why it would add value to _force_
> users to provide pwm frequency, polarity, and the output configuration
> if the defaults work just fine.

Indeed. PWM source is actually fixed and rest of pwm argument could be fine
with defaults.

Both options are fine with me, so keep my tag.

Best regards,
Krzysztof


