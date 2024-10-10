Return-Path: <linux-kernel+bounces-359550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6435D998D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E48285D43
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEF71CDFC2;
	Thu, 10 Oct 2024 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUN3kgnT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442D11C5781;
	Thu, 10 Oct 2024 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577152; cv=none; b=ox1cQgbiMRjaeKurfVUPuikXan2h2ZeOoa0uopmb9JW2jZRnlOERX06OUObfJlaNnlv+7odTNIg64eINKenlys1GGIB0xTb/MGIG8v53830pa4bxjtrvAuNxn+3J3V32+ckHN4Pb9TiReFHAbTjjf3PEYFyL40prfttLzikqav8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577152; c=relaxed/simple;
	bh=bZF3l92VFF3sTRPd2QvKJgiWWBI1vZuFkAWAOS127Z4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Sf8Jvhrb9kpST+c52Wt7MZQIm4xDv0AclGcvbNRHF3mckoHFNn8QQ+wQmnBVlkcMlBE0GxaJ6e8ZahHIYoDw1OPWiBBP1EwsP+5ymc+xl9397N1ac4UlPrmKAoMhAO8ZIEJQUJLwuJG7nSh5YZ3CHMtkB8wUhX1Bv0x/wx7uNJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUN3kgnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7730C4CEC5;
	Thu, 10 Oct 2024 16:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577151;
	bh=bZF3l92VFF3sTRPd2QvKJgiWWBI1vZuFkAWAOS127Z4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hUN3kgnTo3eAnFiBJAWsRHhkzn9bCD19LvMM4ETzI1N16ftI/GiP8wHoETUeAh3Pc
	 jsiL5RtB8wVTtlEdJu1kUS9p09nvyVvfMtrCTPSJIqFwYi+6+i8CBeuNaQo4G83Ejn
	 4dHLAbH80NtEVNgDKwEQie40bH0OVXuukHsBcOMpcZmUGcP85h78ZiGIu32yoZl6Cc
	 zxIfHyYu0PD46x0DhOXg2btApEcG80M9H5vyxdofRv44PDinMYObyxH3v2PSyTmrGm
	 37VYc+Z4nWnd/YUULRfdE4BeL9kPlUqpIKn/BldhLFI8OSFz0ViSXNk+xUmBLC+pxU
	 +4EZXLvfJLnLg==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-usb@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20241005193029.1929139-1-andriy.shevchenko@linux.intel.com>
References: <20241005193029.1929139-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/4] mfd: intel_soc_pmic_bxtwc: Fix IRQ domain usage
Message-Id: <172857714957.2687257.4921456811511949312.b4-ty@kernel.org>
Date: Thu, 10 Oct 2024 17:19:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Sat, 05 Oct 2024 22:27:03 +0300, Andy Shevchenko wrote:
> It appears that the driver has been developed without proper thinking
> of what the difference between HW IRQ and Linux IRQ (also known as vIRQ).
> This misunderstanding led to the 0 being used as vIRQ which is no-no and
> platform APIs unveil this after the commit a85a6c86c25b ("driver core:
> platform: Clarify that IRQ 0 is invalid"). With this the Intel Broxton
> Whiskey Cove PMIC driver has to be fixed all over the places.
> 
> [...]

Applied, thanks!

[1/4] mfd: intel_soc_pmic_bxtwc: Use IRQ domain for USB Type-C device
      commit: 59703271a86fee0fb2087d3a9990068fa0f147fb
[2/4] mfd: intel_soc_pmic_bxtwc: Use IRQ domain for TMU device
      commit: e005ef9f90c045dc284589ece4d6d14af3462a32
[3/4] mfd: intel_soc_pmic_bxtwc: Use IRQ domain for PMIC devices
      commit: 8db3d3e5439808cd899d14fb80e0b01beb9f6379
[4/4] mfd: intel_soc_pmic_bxtwc: Fix IRQ domain names duplication
      commit: 673f0f9a8db71c94e1eb880d1a88204c334710c9

--
Lee Jones [李琼斯]


