Return-Path: <linux-kernel+bounces-557749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0AFA5DD34
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C381691F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA2E23F38F;
	Wed, 12 Mar 2025 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUFClxaC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F5324292B;
	Wed, 12 Mar 2025 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784314; cv=none; b=YsW58+OJghSDkBUWE/s9zmvIfADfSkvTRbK5wknCSCrAiTHbKzfkJesh86WHkB5Ii6D/T0W4pAg+TDW4TvvM0ZxkX/UL5mU0JGY1kE6sk0dyUKRR77QH+PfUHjfvmSjVerSHd7/bs2QDKtWr/6EfbXYTx5038YAv8WHEGTHH9EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784314; c=relaxed/simple;
	bh=wKnXEfj46C5JCUUeX24Q1CC3iBZKwBrzqxVRa0EWDNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noyRqW1Fpe43VOQUFVz2AkoiiUPDDYSMa7cmyl12ou/AgIxfW+DOTtyFmHOdV4ka8f/f7SQhGJUV+tnBIwOmzuX45hk/oiyw0by9Nsy3/F8d1HkQ8l166UaNrbl+v4XO5erh9PTjmRFsoMYFW0Tv+/4olWuVtbfqrgUJ93C4Yxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUFClxaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1F1C4CEE3;
	Wed, 12 Mar 2025 12:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741784313;
	bh=wKnXEfj46C5JCUUeX24Q1CC3iBZKwBrzqxVRa0EWDNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUFClxaC9gCg4LEeM1MRRO6F5PHlrsBIZOoWiN5hbwK6rKr1wKPB9KcKai2iqWdQ5
	 /WXW/ZGPO64SVFiZwg6NUQBJoVVUyHMBArTXQOORlLOuRhTLuWQfXdCLBsLlvSdZx7
	 kFADtJkPStuW0RCdP8ENLg0xkQUzUV1Qs35XhX+SL2EtfDhZZoZMnXIjPKWyQNFjst
	 jB5UFrSwfZwjHo6jXW31QBBc7IbbsFnfdlCrma9mfADz3HPqxcomlO9keYgYl5o5Oi
	 8ZvcdhC+5GOrXMPIFHIWDNgsQLb/JM/1Jrz2IdVgHK+9aQXfkYmKV3F1feviJmuEfT
	 kgwB4lSt4rENw==
Date: Wed, 12 Mar 2025 07:58:32 -0500
From: Rob Herring <robh@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Fu <shifu0704@thundersoft.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 17/20] ASoC: dt-bindings: tas2770: add flags for SDOUT
 pulldown and zero-fill
Message-ID: <20250312125832.GA359842-robh@kernel.org>
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
 <CAHgNfTxS1Q4PPsw520-J4Yn6xg+QZOYFkYhg5yv-uZFu5waN_g@mail.gmail.com>
 <20250307205156.GA583954-robh@kernel.org>
 <5996925.DvuYhMxLoT@setsuna>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5996925.DvuYhMxLoT@setsuna>

On Mon, Mar 10, 2025 at 07:30:07PM +1000, James Calligeros wrote:
> On Sat, Mar 8, 2025 at 6:51 AM Rob Herring <robh@kernel.org> wrote:
> > How would it work when you need a mask? "dai-tdm-slot-tx-mask" is
> > enough?
> 
> The existing TX/RX slot masks are used to control which slots the codec
> is operating on, AIUI. I don't know if it makes sense to alter how codecs
> deal with this. Could we combine the suggested dai-tdm-slot-tx-idle
> with an optional dai-tdm-slot-tx-idle-mask property? From the machine
> driver's perspective, the API would then be similar to the existing
> set_tdm_slot ops. The current downstream macaudio machine driver builds
> its links by allowing multiple codecs and CPUs to be linked to a DAI,
> like so:

Wouldn't the NOT of dai-tdm-slot-tx-mask be the idle mask?

Don't think about the Linux APIs here. The DT is separate. So think in 
terms of what you need to describe the TDM timing/waveform.

> 
> dai-link@0 {
> 	cpu {
> 		sound-dai = <&cpu0>, <&cpu1>;
> 	};
> 	codec {
> 		sound-dai = <&speaker0>,
> 			  ...,
> 			  <&speaker6>;
> 	};
> };
> 
> In this case, the codec-specific mask property was added so that a mask
> could be applied to a specific codec rather than the whole dai, however
> from upstream drivers tt looks like the way this should be handled is to
> have "dai-tdm-slot-tx-idle-mask-n" properties at the dai level, then have
> the machine driver set the mask for the appropriate codec during setup. So
> for macaudio, assuming speaker5 requires this zerofill mask, we would
> have something like this:

I'm now confused why you need n masks and what does n represent?

Rob

