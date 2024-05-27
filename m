Return-Path: <linux-kernel+bounces-190979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBDC8D0594
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D6C4B34A86
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E900416C685;
	Mon, 27 May 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzAdraRG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391E15F3EE
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716820409; cv=none; b=GrMA7ZgTt09JbtkpPs4OEt9J0yV/yOKYvisXRdY78Tefd9kTOBoU8PJUMVIEv8p6Tn6W3FMlkN+Rm5ksdLaC2naN5642XZLHEDv4hj/okpdM0NQ8SGyhSMBTCLDUs6ErPGPPhuRr/0cZu1z0xcv52ssBnnHZInolcw8wgFY+hRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716820409; c=relaxed/simple;
	bh=S0TBfxjUtfuVEbYgXZOiLFontODzcJL+M7Q4Hl3IXRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fgvv0iWGZzYcJpdZa4guiPSbE3k0B8hQKmJW+l7lR7WXEuEtD8aIC+ZCEqs205+fWmXfVEnMqXyFmFbpxPV6DFZRDBkAuAbsoffMtE/bsXbSOgw65WA88PIJjTDhr88DQeb1xYebTTQlvYqWd3QTwT+Ghq4Qmawl9dVVrnawsGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzAdraRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778C7C2BBFC;
	Mon, 27 May 2024 14:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716820408;
	bh=S0TBfxjUtfuVEbYgXZOiLFontODzcJL+M7Q4Hl3IXRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bzAdraRGohEIH3y+D1Vl5PXrkEGVsueuZciQhCH0pHkrz1zTJoJ9c+AfE/p1ZH7Wy
	 1UVDEP11Z89Zbrj/a2XL5PDFU1PD8j0lMO64aR6Li76qX8X4WvZZEHfeK+vxixENPw
	 ROFu6qkY6rxmaZeD0fYzoBF1ccjMsMfsUaGccNTjOTe5f4q4eVhjaeB3qXDhfyYfSR
	 8ab6Us7ChKC8p4lrShwl70/46ZlhxFYaQ5tNcOTuYnnyvmLbLcxs2d+hvk12H71jTO
	 IBWtXH+SaJznQsDR/0uQBmSEmXkymZXicM56gE95nL/L0iYR42Q93aCc+KxwVuH1Pq
	 yL21heGWNLkkw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Michael Walle <mwalle@kernel.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Ricardo Ribalda <ribalda@kernel.org>,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 4/6] mtd: spi-nor: get rid of SPI_NOR_NO_FR
In-Reply-To: <494daaab-a93c-44cd-a437-d306a8269251@linaro.org> (Tudor
	Ambarus's message of "Mon, 22 Apr 2024 06:59:56 +0100")
References: <20240419141249.609534-1-mwalle@kernel.org>
	<20240419141249.609534-5-mwalle@kernel.org>
	<494daaab-a93c-44cd-a437-d306a8269251@linaro.org>
Date: Mon, 27 May 2024 16:33:26 +0200
Message-ID: <mafs0ttij1g09.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Apr 22 2024, Tudor Ambarus wrote:

> On 4/19/24 15:12, Michael Walle wrote:
>> The evervision FRAM devices are the only user of the NO_FR flag. Dro
>
> everspin is evervision?

Looks like a typo to me. Evervision seems to only create display panels.
I can do s/evervision/everspin/, both in commit message and in code when
applying.

>
>> the global flag and instead use a manufacturer fixup for the evervision
>> flashes to drop the fast read support.
>> 
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
[...]

-- 
Regards,
Pratyush Yadav

