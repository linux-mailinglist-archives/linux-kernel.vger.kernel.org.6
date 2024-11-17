Return-Path: <linux-kernel+bounces-412047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4F29D02E8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 11:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D762B2484E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 10:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397AD143748;
	Sun, 17 Nov 2024 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YCe1xk09";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cSJCmSdB"
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA6E482ED;
	Sun, 17 Nov 2024 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731838637; cv=none; b=QefDweSXV47Hgn6lI84KmluSgVJLFvB5u2L2lWSsRBBw0YlKBRp7bUxaWFVjSLQbpOjAGTt5HS1wx5l+GbhnRQhm593ddYxDtvEzocde6rwiDzcUyIqJ5KjwB4eEV3PRNhgQZdVfdCdXUP4PjqEXICGH7YTBwUfKglTAEEhZfOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731838637; c=relaxed/simple;
	bh=elp7ESpeTDRyvlbmxVAUhprzfT8LEZKIr3gdfoVranY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SoJIXlPK1PhWIebvAjkflO2ju+k/q6LSYtr+IBWB6zujxVr4J2ZVlSNUZO+hZHQJ/Rk9pEKy8h8DnEHzwmIo8+xGoNMPKts83IekA/0IrK8p/tA8hx3PWXSi+oQKEoMssdd1ZZUx+BmQ2sC9Mz2vRsM0nX052jh85tFlzcgcb6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YCe1xk09; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cSJCmSdB; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 64E9A2540088;
	Sun, 17 Nov 2024 05:17:12 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Sun, 17 Nov 2024 05:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731838632;
	 x=1731925032; bh=PYcx8Jr5yUiktUasgz5b5XQtP7bTYoN5a4bcgqpVpuE=; b=
	YCe1xk09UAc666jKEwasOftYhYuiHV2LzAWg7lnaBuGYe7FhJ5hqDdqz0A0UaatY
	7peGQCQdzrKwO0vzq2i1w1YB2CHzl2wuVPRC9j4/aA+OpZbnkfFxdFYDywbIBND0
	dzKEttcDhkHq4+KnnYFKHS/72ztZzYt3Y/O9uGJ/8oVNu+6ClqZ0UJR5jnabxySu
	/pWqEPnf10XvABlLR61hNKwczvAph7hi4aMZBeoVi8LLps1CXxs5cwhbFXgzx324
	83REJNe0fYPX6TgEYqPtuFjA25fRzzxJvxV0aooFwSBDP36g5EQrUpmOG1lSbG2p
	i9NhVEVwRahSNGEDbylMww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731838632; x=
	1731925032; bh=PYcx8Jr5yUiktUasgz5b5XQtP7bTYoN5a4bcgqpVpuE=; b=c
	SJCmSdBVsElQFPWJRzH4fOyiT/kF29Qo2/BCQsYRosU/bWNQOb+boZnrV3JYvPBO
	yUPAX8alYPYpUhKXLSPYj705onP6ekrX+5tAeTkh2051IufGkHKucZOvCrvsSK6J
	KvtmIW2xTzfbJU94zYi7t6dDBew2swTF9kZkiYS713YWeBb3iMw67YIyjiTABMSD
	b42XOgkDTslJ/+8TFTu5A8Kn3H2JkEiikSakhg45f5lMuT34x5H9ySGVLfo3uSkz
	EK0nydhF+y+p8MOSx2VbArOYY9xzChZsPRjoEkBbuLeaB2/AwKltY26sTHOrWxvN
	EDVlP3C/L+gkVSBcl6xyg==
X-ME-Sender: <xms:psI5Z3fUNbdJmGf5Cz0622QM_VWBUZvD5G_2VhkB99JTf4odEV2PXg>
    <xme:psI5Z9N8eLaeAtN0DdAV5WL0NFrfPTfGGt-OKndrYLT_VjdwtWbnV-WDfqV0Jkwe3
    R2U2ownJ73iYTKjr4c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdekgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffg
    vedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedujedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghrihhsthhirghnrdhmrghruhhssh
    hisegrrhhmrdgtohhmpdhrtghpthhtohepshhuuggvvghprdhhohhllhgrsegrrhhmrdgt
    ohhmpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eplhhgihhrugifohhougesghhmrghilhdrtghomhdprhgtphhtthhopegrrhhnugeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhhrgifnhhguhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopehimhigsehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:psI5ZwgQV_Ui7wklb8FQqU5xVJ4WpX_JHzzpPDGenV7M0ipeLm6rvw>
    <xmx:psI5Z49vvKoC-Swy9ipgErz5w1wnTocSbaqfkUIqenWud-QWqQgChw>
    <xmx:psI5Zzu-jRQMYewOVt3ezijq4NPm6bNYgNs-8i4Z3tkFr6WxZs89Vg>
    <xmx:psI5Z3GdjSImVBoynfXzL2nXerVHd-lv2nMeHQZNfVNzv6dmtpuVXA>
    <xmx:qMI5Z8820RpC-2VoNKHPcWA3Lo1BLgGn5qSSHf5bL_T2vz_3mYIEecpx>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D13482220071; Sun, 17 Nov 2024 05:17:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 17 Nov 2024 11:16:49 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Cristian Marussi" <cristian.marussi@arm.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Sudeep Holla" <sudeep.holla@arm.com>, "Shawn Guo" <shawnguo@kernel.org>,
 "Sascha Hauer" <s.hauer@pengutronix.de>, "Mark Brown" <broonie@kernel.org>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Fabio Estevam" <festevam@gmail.com>, "Liam Girdwood" <lgirdwood@gmail.com>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "Peng Fan" <peng.fan@nxp.com>, arm-scmi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Message-Id: <40fd6f5c-e3d8-4e75-b479-00d3f81423a8@app.fastmail.com>
In-Reply-To: <Zzm_X0o-TkkGQeAN@pluto>
References: <20241115230555.2435004-1-arnd@kernel.org>
 <Zzm_X0o-TkkGQeAN@pluto>
Subject: Re: [PATCH] firmware: arm_scmi: fix i.MX build dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Nov 17, 2024, at 11:03, Cristian Marussi wrote:
> On Sat, Nov 16, 2024 at 12:05:18AM +0100, Arnd Bergmann wrote:
>> 
>> arm-linux-gnueabi-ld: sound/soc/fsl/fsl_mqs.o: in function `fsl_mqs_sm_write':
>> fsl_mqs.c:(.text+0x1aa): undefined reference to `scmi_imx_misc_ctrl_set'
>> arm-linux-gnueabi-ld: sound/soc/fsl/fsl_mqs.o: in function `fsl_mqs_sm_read':
>> fsl_mqs.c:(.text+0x1ee): undefined reference to `scmi_imx_misc_ctrl_get'
>> 
>
> The SCMI drivers, like the newly added IMX_SCMI_MISC_DRV, generally make
> ue of the related vendor protocol like IMX_SCMI_MISC_EXT, BUT the SCMI
> stack is designed in a way that NO symbols are needed to be exported by
> the protocol layer (to avoid a huge and growing number of symbols
> exports)...so usually the current DRV-->PROTO dependency is fine.
>
> In this case, AFAIU, it is the SCMI driver that in turn exports a few
> helpers that are used by another driver fsl_mqs, which in turn could be
> compiled and work with or without the SCMI stack, so with this patch we
> are artificially reversing the DRV<--PROTO dependency to solve this
> scenario in all the compillation scenarios...
>
> ....BUT given that the IMX_SCMI_MISC_DRV is the one that should export
> the missing symbols could NOT this solved in a cleaner way, without
> adding the fake reverse dependency, by instead modifying the header of
> the driver with something like the classic:

> --->8-----
> diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
> index 9b85a3f028d1..3a7a3ec367c5 100644
> --- a/include/linux/firmware/imx/sm.h
> +++ b/include/linux/firmware/imx/sm.h
> @@ -17,7 +17,19 @@
>  #define SCMI_IMX_CTRL_SAI4_MCLK                4       /* WAKE SAI4 MCLK */
>  #define SCMI_IMX_CTRL_SAI5_MCLK                5       /* WAKE SAI5 MCLK */
> 
> +#ifdef IMX_SCMI_MISC_DRV
>  int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);
>  int scmi_imx_misc_ctrl_set(u32 id, u32 val);
> +#else
> +static inline int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
> +{
> +       return 0;
> +}
> +
> +static inline int scmi_imx_misc_ctrl_set(u32 id, u32 val)
> +{
> +       return 0;
> +}
> +#endif

This usually doesn't work if the provider of these interfaces
can be in a loadable module. The #ifdef above means this won't
be usable when CONFIG_IMX_SCMI_MISC_DRV=m, while changing it to
IS_ENABLED(CONFIG_IMX_SCMI_MISC_DRV) still produces a link error
when the consumer is built-in. Changing it to IS_REACHABLE()
in turn is even worse because it avoids the link failure but
makes it silently do the wrong thing in some configurations.

>  #endif
> ----->8-----------
>
> ....to just support compilation in all the scenarios.
>
>> This however only works after changing the dependency in the SND_SOC_FSL_MQS
>> driver as well, which uses 'select IMX_SCMI_MISC_DRV' to turn on a
>> driver it depends on. This is generally a bad idea, so the best solution
>> is to change that into a dependency.
>> 
>> To allow the ASoC driver to keep building with the SCMI support, this
>> needs to be an optional dependency that enforces the link-time
>> dependency if IMX_SCMI_MISC_DRV is a loadable module but not
>> depend on it if that is disabled.
>> 
>
> ...and maybe with the above additions you could avoid also these other
> dep changes...
>
> ...not sure if I am missing something and I have definitely not tested
> any of my babbling above...

In my experience, there is no way to avoid reflecting the dependencies
correctly in Kconfig: if one driver has an EXPORT_SYMBOL that
gets picked up by another driver, you need a matching 'depends on'.

       Arnd

