Return-Path: <linux-kernel+bounces-425451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94F49DC23F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F912283409
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DA41925AC;
	Fri, 29 Nov 2024 10:38:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC2F19005D;
	Fri, 29 Nov 2024 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732876708; cv=none; b=EJJrv3KDybegmOvLzdG1MxQanhZuZWtDw9mNzzIvxYFcr1JbsZ2I5QftUV/z/+ThjCOylQg9aztqSu/SH11qe/ajZLU01EiR5uC5UZAosxWAodqD3mfDjc3N5WvtcfN6IrYGs3nTXQ6Vcux4d23B9cISIRLNddMebewEy8IGlP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732876708; c=relaxed/simple;
	bh=aspTb+RCvvhCA9qbPnw2Q73M8tb+WaJ8RsI6eVXHo/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRkULEx5AX+M92ic/82ViUoRppB8uvJdzms8AZC6/NyTmrQVBUBVoP3SnCK8UWezrC4eSCVAEYPWJ08XATu/BM6zdWVZFBl9NO+9k1n4iWeAXo2xTWal0Ihju9ZhHMUpCnF5z0V8FIx/h18ekLYwWP2CG956oGtl9aldOT7c1gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48F7112FC;
	Fri, 29 Nov 2024 02:38:54 -0800 (PST)
Received: from bogus (unknown [10.57.89.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7A2E3F5A1;
	Fri, 29 Nov 2024 02:38:20 -0800 (PST)
Date: Fri, 29 Nov 2024 10:38:09 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Peng Fan <peng.fan@nxp.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: fix i.MX build dependency
Message-ID: <20241129103809.vhsugby2q3fbe5fn@bogus>
References: <20241115230555.2435004-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115230555.2435004-1-arnd@kernel.org>

On Sat, Nov 16, 2024 at 12:05:18AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The newly added SCMI vendor driver references functions in the
> protocol driver but needs a Kconfig dependency to ensure it can link,
> essentially the Kconfig dependency needs to be reversed to match the
> link time dependency:
>
> arm-linux-gnueabi-ld: sound/soc/fsl/fsl_mqs.o: in function `fsl_mqs_sm_write':
> fsl_mqs.c:(.text+0x1aa): undefined reference to `scmi_imx_misc_ctrl_set'
> arm-linux-gnueabi-ld: sound/soc/fsl/fsl_mqs.o: in function `fsl_mqs_sm_read':
> fsl_mqs.c:(.text+0x1ee): undefined reference to `scmi_imx_misc_ctrl_get'
>
> This however only works after changing the dependency in the SND_SOC_FSL_MQS
> driver as well, which uses 'select IMX_SCMI_MISC_DRV' to turn on a
> driver it depends on. This is generally a bad idea, so the best solution
> is to change that into a dependency.
>
> To allow the ASoC driver to keep building with the SCMI support, this
> needs to be an optional dependency that enforces the link-time
> dependency if IMX_SCMI_MISC_DRV is a loadable module but not
> depend on it if that is disabled.
>
> Fixes: 61c9f03e22fc ("firmware: arm_scmi: Add initial support for i.MX MISC protocol")
> Fixes: 101c9023594a ("ASoC: fsl_mqs: Support accessing registers by scmi interface")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I'm not sure this is the version we want to go with in the end, without
> having read the code in detail, but the version in linux-next is clearly
> wrong in multiple ways and this is the best I could come up with so far.
>
> If we can agree on this approach, it needs to go through the ASoC tree
> as that contains the 101c9023594a commit at the moment.

Sorry for the late response, was away for a while. I am fine with the
change, but bit confused as Mark Brown has acked the change instead by
which I assume he is not taking it through his tree.

I can can take it at -rc1 or if Mark B is happy to pull it, here is my ack.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

