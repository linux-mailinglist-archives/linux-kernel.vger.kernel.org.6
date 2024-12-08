Return-Path: <linux-kernel+bounces-436509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA429E86E9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 18:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54152164477
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8DC189BBC;
	Sun,  8 Dec 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0J8yNG+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178F818C008
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733677409; cv=none; b=NzDyuoMVWC2vg+8akiLkkrXVCvj2UwLW1PvaOhyCgG2/pnkJkcf3vMulWO968g2z/zWh/qwl0oMZtPAFiITyhOyE+8Ivjk8K4OTkTvveO+26NGJ98Nb6Wdf80YWG56Jj0MIInPMGE6gszUp6roEKIX/CD6rZyKT3GqYJgXDlXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733677409; c=relaxed/simple;
	bh=sHIkSbw7nWpfbHmQZRYAI3MdpoJo1KSdJZW3Q2Bqyn4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VXxUgzBR2+SCEsb90v3ccIU6UKi0cVaTYke48MizqoC/AHbzD7JxC9SXhGQYCnfZQ1wJlUost3eq+PTn7jvMZU49HrWMGeS7BmDwoZeHEc0cx4zk49AtvtfzuFMsvG421Vdq4rZsfPDC9jV1frV8QncbE6eHltMIGc5Imbx1aOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0J8yNG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AF0C4CED2;
	Sun,  8 Dec 2024 17:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733677407;
	bh=sHIkSbw7nWpfbHmQZRYAI3MdpoJo1KSdJZW3Q2Bqyn4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=s0J8yNG+BW4sEna4PRqEhwlX3CEgpwtOyHhscxFFM7HmiOa8fiVdGoIqa4F8gzT5E
	 FVonSsHl3QLcf6H4MrZHdqjyRp/fm5myCXPRtEwF5G4AJ/qt2HqHNtIHg0029/djOt
	 bhZCZGz4Hei8RzA8kNcUBblER+5aJ4CxWjA+dlGO/GVFoMptP4DqKOuXiXjQE5c9te
	 KuLcPeksQ0CBPmkt4sGoiIbeMr/e/yi+fx3fqNlCbeGY0Eo/HkYIX0HF0MDto5LFRC
	 FiicCgewRP4wET0FtogWvl/H5eZAk4iFAdajRO2xqyi1nGnUYYDoNfmCbId2aIuHdI
	 459vz2LvmsTbA==
From: Vinod Koul <vkoul@kernel.org>
To: linux-phy@lists.infradead.org, Adam Ford <aford173@gmail.com>
Cc: aford@beaconembedded.com, sandor.yu@nxp.com, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Dominique Martinet <dominique.martinet@atmark-techno.com>, 
 Marco Felsch <m.felsch@pengutronix.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20241026132014.73050-1-aford173@gmail.com>
References: <20241026132014.73050-1-aford173@gmail.com>
Subject: Re: [PATCH V2 1/3] phy: freescale: fsl-samsung-hdmi: Expand
 Integer divider range
Message-Id: <173367740360.1042266.11639537170918514814.b4-ty@kernel.org>
Date: Sun, 08 Dec 2024 22:33:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 26 Oct 2024 08:19:57 -0500, Adam Ford wrote:
> The Integer divder uses values of P,M, and S to determine the PLL
> rate.  Currently, the range of M was set based on a series of
> table entries where the range was limited.  Since the ref manual
> shows it is 8-bit wide, expand the range to be up to 255.
> 
> 

Applied, thanks!

[1/3] phy: freescale: fsl-samsung-hdmi: Expand Integer divider range
      commit: 2a9868d69be26e623dd0bf4231d5175f0ccf5d6f
[2/3] phy: freescale: fsl-samsung-hdmi: Stop searching when exact match is found
      commit: 1b9b8b159601d174526ce1c3a62ebe3a7286003b
[3/3] phy: freescale: fsl-samsung-hdmi: Clean up fld_tg_code calculation
      commit: d567679f2b6a8bcea20589bbea6488c0236886cd

Best regards,
-- 
~Vinod



