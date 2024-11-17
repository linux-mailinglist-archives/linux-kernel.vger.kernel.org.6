Return-Path: <linux-kernel+bounces-412041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6E69D02B2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 11:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD1F1F233A3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 10:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5BE139D07;
	Sun, 17 Nov 2024 10:03:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFE538C;
	Sun, 17 Nov 2024 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731837814; cv=none; b=cLPRgci0XhUJtqFXFtxqp6nJfmciXY1b5MAcFJKxXh5sIFSZtv4eOn8RiwLNRSCxuNVA4o1RytsIQJicrPEVErrub5FWhsNuxNpg3QTJZIEomv/s5P1LV6vvQeapX9hviMNYRdbugnO1jEF47b0uMBSAOqZKqgzvIYOHQ3VLuCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731837814; c=relaxed/simple;
	bh=wLngz+w8R8ARLEGH+KooMXrrnp/v/UtKleyZ2Ad5FW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlfwuYPivf4RzOzVEfolmhhRB3mGJJxUtBOYOZAw1w8X8rw3tIs7eX1WUqdHWZIk5qCbjCz4nbiLmpSfbHuP6HOCbF37ElzolNzCRhs5zBDXoBiIahd8kD4ii+Tbus1oPBmzoHN2P93ie2rmEC/5maLAYGqdlM6tsk/dXQnuJuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B76E1424;
	Sun, 17 Nov 2024 02:03:54 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBAC33F6A8;
	Sun, 17 Nov 2024 02:03:21 -0800 (PST)
Date: Sun, 17 Nov 2024 10:03:11 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
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
Message-ID: <Zzm_X0o-TkkGQeAN@pluto>
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

Hi Arnd,

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

The SCMI drivers, like the newly added IMX_SCMI_MISC_DRV, generally make
ue of the related vendor protocol like IMX_SCMI_MISC_EXT, BUT the SCMI
stack is designed in a way that NO symbols are needed to be exported by
the protocol layer (to avoid a huge and growing number of symbols
exports)...so usually the current DRV-->PROTO dependency is fine.

In this case, AFAIU, it is the SCMI driver that in turn exports a few
helpers that are used by another driver fsl_mqs, which in turn could be
compiled and work with or without the SCMI stack, so with this patch we
are artificially reversing the DRV<--PROTO dependency to solve this
scenario in all the compillation scenarios...

....BUT given that the IMX_SCMI_MISC_DRV is the one that should export
the missing symbols could NOT this solved in a cleaner way, without
adding the fake reverse dependency, by instead modifying the header of
the driver with something like the classic:

--->8-----
diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
index 9b85a3f028d1..3a7a3ec367c5 100644
--- a/include/linux/firmware/imx/sm.h
+++ b/include/linux/firmware/imx/sm.h
@@ -17,7 +17,19 @@
 #define SCMI_IMX_CTRL_SAI4_MCLK                4       /* WAKE SAI4 MCLK */
 #define SCMI_IMX_CTRL_SAI5_MCLK                5       /* WAKE SAI5 MCLK */
 
+#ifdef IMX_SCMI_MISC_DRV
 int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);
 int scmi_imx_misc_ctrl_set(u32 id, u32 val);
+#else
+static inline int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
+{
+       return 0;
+}
+
+static inline int scmi_imx_misc_ctrl_set(u32 id, u32 val)
+{
+       return 0;
+}
+#endif
 
 #endif
----->8-----------

....to just support compilation in all the scenarios.

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

...and maybe with the above additions you could avoid also these other
dep changes...

...not sure if I am missing something and I have definitely not tested
any of my babbling above...

Thanks,
Cristian

