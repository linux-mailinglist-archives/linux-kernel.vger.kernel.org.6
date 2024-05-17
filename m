Return-Path: <linux-kernel+bounces-181894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89588C82EE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97D01C20E29
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7753F21101;
	Fri, 17 May 2024 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="QNEjG5K0"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351C51B809;
	Fri, 17 May 2024 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715936748; cv=none; b=ls19j+FT3JSJZCgIrRIVPUOvJVT1JhJxhtP/rgayXPd0EFPHDqlcobWg59M9cHNIVAHMyxO03TBk+Jw3aH5l0FIt4Hk1oWG7GhAogd5qpIsF95NiSZCpX3ZF0zprIRYiilxZcpSDKMCGU8P1MXVmLNWUrOkzEAwzhtQelJd5Sdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715936748; c=relaxed/simple;
	bh=qaI1HGeZwQBBafuZfT3T7gHh0pYBlXpnWAg7pywFKjM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=S7l0nr1pqggnAsxF+hFGhTsX3nd9zZNxj87IL6yq+/qsQQOzPEdE5RHq6m0xwiyoJhbuVuD9URUBQSu0JJ+1IVyOIgvQ4LRRxzJPCD5rTYSSHXJ+ti6EBKOJInHi8ODofkpobPRsd6fZpuFEJk8zCjuo85w8O2mjSA/DG4fVeZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=QNEjG5K0; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 68ACA9C57A6;
	Fri, 17 May 2024 05:05:39 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id j0EVtTFCV_in; Fri, 17 May 2024 05:05:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A809E9C5864;
	Fri, 17 May 2024 05:05:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com A809E9C5864
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1715936738; bh=8SLwMepymaYZWEVQR9qjp1ldhDA0f4QIis7dKy4nHYQ=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=QNEjG5K0CVnFA9ZM/PRvc2Zh6zP52Jks46QB+HzouGEwR8al3i5mGFG0E5hvkLxtW
	 jfJ0SmCrlxlkZjINYMKaDg0MzSgXZF+dWcIR+U5mF1YLwKUQqxSR/rNglVfpOYRRHe
	 Q8j7N0STKjp3oer40wADQ2Z3ri5pzW/8IgB9iMEWVcZtBZvRiCaSlT5SxwyLb18z3l
	 jb4pS4ZMdyOkK+SG2G5CSZn3dOpF0dtrQ4GGm5L2T2yGSMa1QovS+6jG5alPggxGy1
	 bRttWhmsfaminOQaDm/e93JkQ62jvrh3sCo/c3AU/rSd1IcYreNd6bkHhTYfERy/ds
	 epm+dfcegME8w==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ydHCeB7dNc_i; Fri, 17 May 2024 05:05:38 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7254F9C57A6;
	Fri, 17 May 2024 05:05:38 -0400 (EDT)
Date: Fri, 17 May 2024 05:05:38 -0400 (EDT)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	shengjiu wang <shengjiu.wang@gmail.com>, 
	Xiubo Lee <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-sound <linux-sound@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	alsa-devel <alsa-devel@alsa-project.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <1607626951.349332.1715936738428.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <20d8eb96-6346-4341-95ee-74729001c01a@sirena.org.uk>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com> <20240515135411.343333-9-elinor.montmasson@savoirfairelinux.com> <20d8eb96-6346-4341-95ee-74729001c01a@sirena.org.uk>
Subject: Re: [PATCHv4 8/9] ASoC: fsl-asoc-card: add DT property
 "cpu-system-clock-direction-out"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - GC112 (Linux)/8.8.15_GA_4581)
Thread-Topic: ASoC: fsl-asoc-card: add DT property "cpu-system-clock-direction-out"
Thread-Index: GFI3lOelC49AXb+0LrXDbBRGlEMPdA==

From: "Mark Brown" <broonie@kernel.org>
Sent: Thursday, 16 May, 2024 14:18:00
> On Wed, May 15, 2024 at 03:54:10PM +0200, Elinor Montmasson wrote:
>> Add new optional DT property "cpu-system-clock-direction-out" to set
>> sysclk direction as "out" for the CPU DAI when using the generic codec.
>> It is set for both Tx and Rx.
>> If not set, the direction is "in".
>> The way the direction value is used is up to the CPU DAI driver
>> implementation.
> 
> This feels like we should be using the clock bindings to specify the
> clock input of whatever is using the output from the SoC, though that's
> a lot more work.

Similarly to patch 7/9, I exposed this parameter because the driver has it, and
because there might be CPU DAIs needing this parameter.
Otherwise the cpu sysclk direction will always be IN as a default.
This parameter could be needed for cases with CPU DAIs, such as an SAI,
which can provide or consume Tx/Rx clocks.
For these devices I know the sysclk direction should correspond to
what was set in the dai format.

This new compatible is intended to be used when there is no codec
device/driver. There is technically no codec device/driver for which
the clock input can be set.

Is it a bad idea to allow setting the cpu sysclk direction only ?
Should the compatible be limited to use-cases where the cpu sysclk
direction cannot be set by the machine driver ?

Best regards,
Elinor Montmasson

