Return-Path: <linux-kernel+bounces-267337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3082F94106D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627D81C2238F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C78C19DF73;
	Tue, 30 Jul 2024 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0PC9Yzk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570DB18EFED
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722338658; cv=none; b=jrD0cnT4C6LVTFP5P9u1r4dRIDD7FfzXM41GvlVBn61Y0imknESXp5X1Co6crCPMy94B5ZLFA/RkRHLFXdferiYsDTJwPdhirqouD9HNhBKbBUU8kld7dLcv0xiCt18pPEk+wo0EqlKE6ImSgFbZHeQgoLcWK0j3nkl5mNkv0TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722338658; c=relaxed/simple;
	bh=FstNwrfsX5X7GY12ufzHw8RhOHEWqp+Zb6hF3L2QyEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gQu7S+v98uJOHnxLGgYJ2aecLI9hp/l7BwcAgTWiMf7EFfzqOqOBFLudpFlOTrGhl6z2rn5ebX7taLSD0GXmVhGlqm7qzkheWXVAxlWAYxIqKzt2yg0cT4MTvsk4HKZ5V9jI/KKWFDd2WP8pOmM8db+GBIThrMjUHHTDZoQP6io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0PC9Yzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8819AC32782;
	Tue, 30 Jul 2024 11:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722338658;
	bh=FstNwrfsX5X7GY12ufzHw8RhOHEWqp+Zb6hF3L2QyEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=q0PC9Yzkm8atb0xilzRFm0z9wGS/xfgYkjlkMxV3TVh2roxXMFMIZBFvo/v8pgR9l
	 wh9xfiIP9GwXvDvE5HIn0DHHmUzOdggPa8ycSXB0bNN0tUi4n3UThc4uXAfPJY86IX
	 NR93f07dSVaIJQkmR0TXtgLOwtbA8X7nt5xCl09XcpbbmKo2oswSsM7/hKsU4Wrx6N
	 H6lTIeE9dLWVPF3axeanttYRCpaqYwZrXhmDY8dwtOIFjtAU7A1Nr6IAgQbZJRQhOS
	 kB8VaDtruP8Q+fgNN+VOEm+tVCBSOgD8fWqf5bFLBZScAL6W0fIp6vjGCObQY0tmNR
	 sbwNvx8SK02Tw==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Brian Norris" <computersforpeace@gmail.com>,
  <linux-mtd@lists.infradead.org>,  "Miquel Raynal"
 <miquel.raynal@bootlin.com>,  "Pratyush Yadav" <pratyush@kernel.org>,
  "Richard Weinberger" <richard@nod.at>,  "Tudor Ambarus"
 <tudor.ambarus@linaro.org>,  "Vignesh Raghavendra" <vigneshr@ti.com>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: micron-st: Add n25q064a WP support
In-Reply-To: <D32OADQF733D.3CVS3ZRPEBL2O@kernel.org> (Michael Walle's message
	of "Tue, 30 Jul 2024 08:51:05 +0200")
References: <20240726185825.142733-1-computersforpeace@gmail.com>
	<D32OADQF733D.3CVS3ZRPEBL2O@kernel.org>
Date: Tue, 30 Jul 2024 13:24:15 +0200
Message-ID: <mafs034nr2kdc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 30 2024, Michael Walle wrote:

> Hi,
>
> On Fri Jul 26, 2024 at 8:58 PM CEST, Brian Norris wrote:
>> These flash chips are used on Google / TP-Link / ASUS OnHub devices, and
>> OnHub devices are write-protected by default (same as any other
>> ChromeOS/Chromebook system). I've referred to datasheets, and tested on
>> OnHub devices.
>
> Out of curiosity, there is also a hardware write protect switch
> somehow, right? At least that's my understanding how verify boot
> works.
>
>>
>> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
>
> This looks good:
> Reviewed-by: Michael Walle <mwalle@kernel.org>

Applied to spi-nor/next. Thanks, both!

-- 
Regards,
Pratyush Yadav

