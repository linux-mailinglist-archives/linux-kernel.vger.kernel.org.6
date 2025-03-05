Return-Path: <linux-kernel+bounces-546909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C282A50080
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5869B3A388B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C50F24887E;
	Wed,  5 Mar 2025 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Byw7q/iu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C05230BC6;
	Wed,  5 Mar 2025 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180961; cv=none; b=ni3lDCfB8q2gCjEPmv/c1gbMEt/GlZe9+znyplHoYtixMhZgZBVEwzMV0j7RHJoKMBoSt8T8+Y3B7AmBWcvanOzsGC644ET9vC/KeteGR9KheQdwke/oQ2FDBV+tAOGgRNSVUlfJS1nnB4Txna9qlrlbpVagc5KGLwtBcxD6TMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180961; c=relaxed/simple;
	bh=2Bu2IgsWQfcgd5O+NbADT2ErcKX0Ld5Byc6D0Elm9wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mT/ZkSLSWGeX1YWNqUH0tAnOnBySnlFscL7Y0wEODWlYs70xNvT1ySHKhZvn8iRaV6RPyvQVKzVyPLEuJDpeaMViCghkU7tqUwyU5I/Ob/WQsY6hMcPbA1MyISK/Futasi+VO65HwwQVLkA8j5YUqF5JOMPPmdN4MLQ7/84mecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Byw7q/iu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB336C4CEE2;
	Wed,  5 Mar 2025 13:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741180960;
	bh=2Bu2IgsWQfcgd5O+NbADT2ErcKX0Ld5Byc6D0Elm9wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Byw7q/iuGLgydm3rTrQ6qR3u96o6B1oen331kBCeZ5OEEffcSIhz4RnvZZ3JVjdV9
	 WyrB2S3IxQbCMdz3S6JGvj9M6MpTbJqcKcMVHy9ishP0rpU5b98W9sHS4M+fxW50W4
	 9y1kF0UfcGQgYXHUBL1ol7PYdpCYLUCFIrYMBVZuaETGvoEJIOIT0WnVF0CO0xr5YQ
	 0ZOVMpMi2zaLEN0wNB4HOHdT8+TU31SmSQN6KcZMagI55muKwYR2Z3Ciak1VII9lKn
	 6BV+jWmg5263OmehDaDffOsMgl0zUaoSnc10VVVU63tGW76OTaFTNjrQH8nqWuGJ0d
	 uTqpSRcL0JKhA==
Date: Wed, 5 Mar 2025 07:22:39 -0600
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
Message-ID: <20250305132239.GA1415729-robh@kernel.org>
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
 <20250227-apple-codec-changes-v3-17-cbb130030acf@gmail.com>
 <20250304135050.GA2485358-robh@kernel.org>
 <CAHgNfTyVKFuT0fZ3Qj=MdcXs67KscwkSepAH95xkAAKWM1g8Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHgNfTyVKFuT0fZ3Qj=MdcXs67KscwkSepAH95xkAAKWM1g8Xg@mail.gmail.com>

On Wed, Mar 05, 2025 at 01:19:15AM +0000, James Calligeros wrote:
> On Tue, Mar 4, 2025 at 1:50 PM Rob Herring <robh@kernel.org> wrote:
> > Can't you align this with the other property you added? Or extend the
> > existing TDM properties we have.
> 
> I don't think either option makes sense given the functionality. This chip
> behaves differently to TAS2764, and instead of using a bitmask to determine
> which slots to ignore, we only get a single bit to tell the chip whether we want
> it to fill or pull down *all* inactive slots. The property being a u32 mask
> therefore does not make sense here.

If there's a single bit control, then that just means there's only 1 
valid value for a mask in that case.

Or maybe a mask is overkill. What's the usecase for fill or pulldown 
*some* inactive slots?

> Building the logic off the existing generic TDM slot properties would alter
> behaviour of existing implementations where zero-fill and pulldown may not be
> required or even wanted. This may continue to be the case going forward so I'd
> rather make it an explicit opt-in rather than some unconditional thing we try to
> turn on heuristically.

Existing implementations would not have the new/extra properties and 
would continue to operate as before. Or those drivers could simply 
ignore the properties.

> I gave some thought to flipping these bits if a TDM slot mask is passed to the
> driver, however it can still be the case that we don't want both zero-fill *and*
> pulldown active at the same time, or as above some implementations may want
> neither, so we still need to be able to specify them individually.

This just feels like something common because any TDM interface may need 
to control this. It's not really a property of the chip, but requirement 
of the TDM interface.

Rob

