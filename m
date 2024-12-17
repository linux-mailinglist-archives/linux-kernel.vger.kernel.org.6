Return-Path: <linux-kernel+bounces-449946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9E99F5896
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E98188A27D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76D31F9F68;
	Tue, 17 Dec 2024 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggAFY+MB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E9A1D5CCC;
	Tue, 17 Dec 2024 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470019; cv=none; b=WlK8+vB2t+B2OWyDgUAV8y52CQXMjs+u01eF7B4/I3k7bJf7u41ma5A28PBTom3/BKUaAfPK695C1wHtAEJol89oMzzJC/3p3Is8qtTU/gT2o/wtyLVG07mIsprKviu9r8Q+XQE6r7wtfNbXNGuEYtaukplbGBroA+dQ7T4vN18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470019; c=relaxed/simple;
	bh=wX6gB4JEoi8YSueg1I9r/GKQrj4KC/fiiMyeaqRMZtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBJKjXIeF+KvSddbZ5CH6sHcmfbbCJjiPE0MZchHStOEb1BwYSvnPGFt5EoC6mIItJK26Hu0Mp99dW12vxjXKNubg8OmGMIRvoz/C+auDvzPFA8qw6n/CsnGW+GAvOz2466XZ7P6mOnOcN0KWPQ02wthPvv9G3hAve5eCquH7RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggAFY+MB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15F8C4CED3;
	Tue, 17 Dec 2024 21:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734470018;
	bh=wX6gB4JEoi8YSueg1I9r/GKQrj4KC/fiiMyeaqRMZtA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ggAFY+MBG/SD9hOMHVvXG5PJ7ENsvjNXAkBh1+aCO2FenmrieIMSX5uq/y1klKvuS
	 Z4YWyQecucUj7fgqQ+6o566lEuwNgItCgfASMPnuyxT9lblvPFJh1CD9GG2cJMj8uf
	 QHg9NG3tIkAkf5EsI59GqVE+9/HRcc7zudmFcpnFGlBAd4j3/X2Bn/7eaE7spvJDTZ
	 5th2eRQVbkj1sOA+OqOIOKIAAwdAG2fvTdmuhHcWS25KYzSmKKhYb7hPvCCCFcwJaB
	 PTlDqFrSpReICQ4igUoWoRl8U05BqFNyKmWuFCSK0YKbYVkR/ReMnZcKzeEb142PDC
	 eWmUXE5kelNDw==
Message-ID: <8a1ed4be-c41c-46b6-ae25-33a6035b8c8d@kernel.org>
Date: Tue, 17 Dec 2024 23:13:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] usb: cdns3-ti: run HW init at resume() if HW was
 reset
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
 <20241210-s2r-cdns-v6-2-28a17f9715a2@bootlin.com>
 <4e1eb8d2-c725-4572-8419-3027cac10c92@kernel.org>
 <D6AOGW7IXUEK.1AKKZZT0LAF0Q@bootlin.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <D6AOGW7IXUEK.1AKKZZT0LAF0Q@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 13/12/2024 17:28, Théo Lebrun wrote:
> On Thu Dec 12, 2024 at 1:18 PM CET, Roger Quadros wrote:
>> On 10/12/2024 19:13, Théo Lebrun wrote:
>>> At runtime_resume(), read the W1 (Wrapper Register 1) register to detect
>>> if an hardware reset occurred. If it did, run the hardware init sequence.
>>>
>>> This callback will be called at system-wide resume. Previously, if a
>>> reset occurred during suspend, we would crash. The wrapper config had
>>> not been written, leading to invalid register accesses inside cdns3.
>>>
>>
>> Did I understand right that the Controller reset can happen only at
>> system suspend and never at runtime suspend?
> 
> J7200 + upstream kernel => if the power domain is cut off (it is
> implicitly at runtime PM) then it resets. This is 100% board dependent.
> We just never let it go into runtime suspend, for the moment.
> 
>> If so do you really need the runtime suspend/resume hooks?
>> you should have different system suspend/resume hooks than runtime suspend/resume
>> hooks and deal with the re-initialization in system resume hook.
> 
> The patch series works in the current setup with the wrapper that is
> never shut off. But it would also work if someone decides to use RPM on
> the wrapper.

But will it work? if we let it runtime suspend and controller looses power,
even though we restore the wrapper, who is restoring XHCI controller on
runtime resume?

Also we would be interested in wakeup events at runtime suspend
and by loosing power it doesn't look like it will ever wake up with any USB
event.

> 
> Overall, the current kernel-wide strategy is to minimise
> suspend/resume-specific code. Having only the concept of "runtime PM"
> and triggering that at system-wide suspend/resume is easier to reason
> about. It unifies concepts and reduces the states a device can be in.

or we just focus on system suspend/resume if the driver can't do
meaningful runtime suspend/resume?

> 
> We could even imagine a future where ->suspend|resume() callbacks
> are pm_runtime_force_suspend|resume() by default.
> That'd be the dream, at least.
> 
> Thanks,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

-- 
cheers,
-roger


