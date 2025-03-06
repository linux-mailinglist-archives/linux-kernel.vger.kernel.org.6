Return-Path: <linux-kernel+bounces-548586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB318A546BB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E403A7738
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0979209F52;
	Thu,  6 Mar 2025 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Ib8Tm0jI"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54680209F24;
	Thu,  6 Mar 2025 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254249; cv=none; b=VVOvVsFTGhsCQaWBVcJaNkE8L2qySWVrvwVX9MJTKCApVIBNjS4cEGdye7WQupMODoQ76K0gFTOiMokEt1aJvfMUjvKzJm4qbaR66/Jw4NjOD7PGv9DkK/YkoevySubxlOdNgbfFR+JsON1IFh6M5ntgk3K/gKhSiVtCAL6Iv/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254249; c=relaxed/simple;
	bh=VX2kzKllbsoP91Bapt2Ap7Ihl2O/6a2B1r5piUQLUNM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NL/p4dhGBK5XqT9X8HC6I7NAnnUsF9rc1BV7VNLusAMqjauLYIONUgXd3/rLQ+8/x58l+yXm4c5ZoJ4mI/r0p006ZRdbni/q50/wKkOJpZs/Ui93rGm074HVdMamTP9k154NN5hIz2wjnb6690KZODRseq04ZLzGndQwvdgxK2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Ib8Tm0jI; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52611Gqd023438;
	Thu, 6 Mar 2025 03:43:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=zXAUqowniBqDMvitnE
	LMJZCDJMuQN3t+0nVrR0rbEH8=; b=Ib8Tm0jIBGnxqgBqlviDOahXwQwTC5WZCv
	KlHtT1enVfLSH86TABQ17szuCQVQusPj2vZWW8/MfpKHLYxwm63iS/N4fVsUxTMS
	TbfsRvaidcgdHJ49LT31mLxol9UXFauCSJlZfSZvAnHu49BWK5IbDwMu/lModhHe
	lfxEHIeT3MF0V7uzWY7WKXdvXjdbqLPHY5kvSBqIshRYzx4LO91T8gqxpmfI5FUH
	AcnDRQUvT3DxNxjQ5N6XTLvDRloJRAMSwVXtXP8eXk1XD7soA+nDsUyaYEWtnCig
	FBmtdV5gHMS6V8H2EJZWyhEgKMxKAo62OLfjGf8YtpDjtx5qXFIw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4571nu0qmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 03:43:46 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 6 Mar
 2025 09:43:44 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 09:43:44 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id B5657820248;
	Thu,  6 Mar 2025 09:43:44 +0000 (UTC)
Date: Thu, 6 Mar 2025 09:43:43 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Arnd Bergmann <arnd@kernel.org>
CC: David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        "Arnd
 Bergmann" <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>,
        "Peter
 Zijlstra" <peterz@infradead.org>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: cs42l43: convert to SYSTEM_SLEEP_PM_OPS
Message-ID: <Z8luTwJBC3BdYZ8R@opensource.cirrus.com>
References: <20250305172738.3437513-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250305172738.3437513-1-arnd@kernel.org>
X-Proofpoint-ORIG-GUID: d9JYD0GO_g0eNORQvEZZpeGt52mC5fUv
X-Authority-Analysis: v=2.4 cv=Lqxoymdc c=1 sm=1 tr=0 ts=67c96e52 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=pspjf_nruJqWOfkU2jsA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-GUID: d9JYD0GO_g0eNORQvEZZpeGt52mC5fUv
X-Proofpoint-Spam-Reason: safe

On Wed, Mar 05, 2025 at 06:27:32PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The custom suspend function causes a build warning when CONFIG_PM_SLEEP
> is disabled:
> 
> sound/soc/codecs/cs42l43.c:2405:12: error: unused function 'cs42l43_codec_runtime_force_suspend' [-Werror,-Wunused-function]
> 
> Change SET_SYSTEM_SLEEP_PM_OPS() to the newer SYSTEM_SLEEP_PM_OPS(),
> to avoid this.
> 
> Fixes: 164b7dd4546b ("ASoC: cs42l43: Add jack delay debounce after suspend")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Apologies I should have spotted that in my review.

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

