Return-Path: <linux-kernel+bounces-253247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89368931E91
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11BB1C21B8B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6ED4A32;
	Tue, 16 Jul 2024 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJBX4TXC"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA94E322B;
	Tue, 16 Jul 2024 01:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721094626; cv=none; b=IKcIjHUNOZGL4+QGREYAPSzIbozbarocPkux7qqghseGIVyVuEE0K95/WJPNBPZCZaLx4YFfO6g/dZWzj/6Df+pYhikfIIEwRHqCXajknGsNvsBTo9gSFJRSPCegdSMO5y/365GE6K17ze4XomTle1/ejscXmWX+BxOYly9aios=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721094626; c=relaxed/simple;
	bh=NbxExGiGYA8cRfXkTxyvsjJQkGIt7pvHcQuUS2+31uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBg9aeB3p5mPl38KywpmUmJ6sXzz5hlxvX4GAzi24x75OP01mfKJw2XhasLzGYY1ygw2KXuI4hgGtHgy8lXVrfmhAL6KCyoTVu9ntf9DP6gxn0Rk98a/iBA6x6vClN10t2G5iPg3TAXomxr8vLvMau4ctZM4WC2BPxTLyGUJ5no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJBX4TXC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b07bdbfbcso4445990b3a.0;
        Mon, 15 Jul 2024 18:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721094624; x=1721699424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF76jgngFNSA0+6Yc/C9VyeZCVr+gqQa8EoK0I1uvRg=;
        b=NJBX4TXCahAduF63BTubp1RCtw8K41yF0TZ6osB83pcsDvfF15oMGZ4DtaY4RR+x0n
         PouI6BVl31PHIJngpDQnVOy7MASQOBFf9ROxP1IPK2s2IeDCIPvn1yced+PztJMuWlgP
         yKampePFzDNgWTTBh2DZRzpnMVQdogiX2C3OjPJJsXNPY1/Zty5/X+apKwWoQM3icYP5
         VwBk2MoYrRUK/NhgKy0qYqvbdOo9mTvsZSuKn2dT/unGsXUj1gxo6RMYpAKc5gt6iApM
         cS2wCPETu8nty2Yfi8GHENLIOkKvPX38gIFiorsqiQ3EMtlmG0f2HENvfrAYPAS7Z4T5
         Wmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721094624; x=1721699424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kF76jgngFNSA0+6Yc/C9VyeZCVr+gqQa8EoK0I1uvRg=;
        b=LnB6e7ZZ3V9wa+Rjnyp5BmQH6idXBTFTT9/xoWJzAroQQ67f5xkbNuAUQWlMwvfEWk
         rpY4j78vNC2Epo1zfo7MxJynuxV3Gq81c20jRM+VAWKtwy80vZ8npmJVDEU6FYtmXv/Q
         +f1piVeeQLUQt7rylbyKjHiDRpV64qhtJSCwRoBuTa8oIXm/5xXMtE1fEV2bPSfDOelk
         3aqVoDsP7xTy2NFvnvVxinjy6qC3Yshp4o/+IQFg4FBMncUn/FJzU26KIepg7pQlSU5X
         bzp2kiK0LcPTrEe7KQd7j503f3GXAdP5CkZpqFBKw4Tfkt3HUhKu+xYdRC/2HEB7xVkM
         /XtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKCq50Mf+glVWOHoFEGz4zL9PtJ7fhwBB6YlaP293YW/tDYIw44FJWADqplt2Drj0u0VNtnGbS/z1yj2yx2u7JFgX8CWo9sFrNQOO/yGM5j6958gNG3NctVZosMO0IeG7CQM/DiyK5
X-Gm-Message-State: AOJu0YwGACUlCUDTS5f5LKDnFaWbZAwab26H8vb33V0VnmHvCw7oL0V8
	9FFqVVcNLg/SmJjQXq4TFLmcR6LMyQJ6Vf6Oe1qJ1GmgI0FtY2lQUTclvu51Hvvn7/+KvE30/rH
	gVF653XqjA364mqOI7E7Kcuy2ooY=
X-Google-Smtp-Source: AGHT+IEH7Pz0+M8TK9vfrdLutYz/7p0g+XzWbqP83luKBEpdMLNXXHy0QG2/ZEccF49uIZncRRjm0N9o9za0XZqoPqY=
X-Received: by 2002:a05:6a20:1593:b0:1c0:e1a5:9588 with SMTP id
 adf61e73a8af0-1c3f1e7721fmr757612637.2.1721094623616; Mon, 15 Jul 2024
 18:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607133347.3291040-1-peng.fan@oss.nxp.com>
 <20240607133347.3291040-6-peng.fan@oss.nxp.com> <CAHCN7x+pzcdwSq19LefsyYAPUp8=kQYJeVbHm9sgSeaKXigMZg@mail.gmail.com>
 <PAXPR04MB8459E0FEFFFC4F7FB257F32B88A12@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAHCN7xLDqLOe9Y8J7R5cEij9Xq=GS1Au8t3hrayf=-zSyorG-w@mail.gmail.com> <DB9PR04MB8461113195809FE1680E5FA488A22@DB9PR04MB8461.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB8461113195809FE1680E5FA488A22@DB9PR04MB8461.eurprd04.prod.outlook.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 15 Jul 2024 20:50:11 -0500
Message-ID: <CAHCN7xKSzfqBSnLrr7rxa2NC+kkwpK0JmueiY4aXBH4A+oTBjA@mail.gmail.com>
Subject: Re: [PATCH V3 05/15] clk: imx: imx8mp-audiomix: remove sdma root clock
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "abelvesa@kernel.org" <abelvesa@kernel.org>, 
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, 
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "S.J. Wang" <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 8:25=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH V3 05/15] clk: imx: imx8mp-audiomix: remove
> > sdma root clock
> >
> > On Sun, Jul 14, 2024 at 8:11=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wro=
te:
> > >
> > > > Subject: Re: [PATCH V3 05/15] clk: imx: imx8mp-audiomix: remove
> > sdma
> > > > root clock
> > > >
> > > > On Fri, Jun 7, 2024 at 8:28=E2=80=AFAM Peng Fan (OSS)
> > <peng.fan@oss.nxp.com>
> > > > wrote:
> > > > >
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > There is an issue:
> > > > > SDMA3 can't work without setting AUDIOMIX_CLKEN0[SDMA2]
> > (bit-
> > > > 26) to 1
> > > > >
> > > > > The workaround is:
> > > > > As the reset state of AUDIOMIX_CLKEN0[SDMA2] is enabled, we
> > just
> > > > need
> > > > > to keep it on as reset state, don't touch it in kernel, then ever=
y
> > > > > thing is same as before, if we register the clock in clk-audiomix=
,
> > > > > then kernel will try to disable it in idle.
> > > > >
> > > > > Fixes: 6cd95f7b151c ("clk: imx: imx8mp: Add audiomix block
> > > > control")
> > > > > Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > ---
> > > >
> > > > With this patch,I found it broke the imx8mp-beacon board when
> > > > running audio through a codec connected to sai3.  Reverting this
> > > > patch made the crash go away.  Is there a way to mark the clock as
> > > > critical so it doesn't get idled?
> > >
> > > Mark it as critical means the blk ctrl needs to be powered on always.
> > >
> > > You driver touched the SDMA2_ROOT clock?
> >
> > I have a WM8962 CODEC connected through sai3.  Without this patch,
> > the sound plays just fine.  With this patch, I get the following:
>
> Try use this for SDMA2.
>                                 clocks =3D <&clk IMX8MP_CLK_AUDIO_AHB_ROO=
T>,
>                                          <&clk IMX8MP_CLK_AUDIO_AHB_ROOT>=
;
>

Unfortunately, that didn't work either.  Changing the SDMA2 clocks to
the above yields the following:

[   20.714987] fsl-micfil-dai 30ca0000.audio-controller: failed to pcm regi=
ster
[   20.728904] fsl-aud2htx 30cb0000.aud2htx: failed to pcm register
[   20.755070] fsl,imx8mp-audio-xcvr 30cc0000.xcvr: failed to pcm register
[   20.766373] platform 30c50000.sai: deferred probe pending: fsl-sai:
PCM DMA init failed
[   20.774497] platform 30ca0000.audio-controller: deferred probe
pending: (reason unknown)
[   20.786387] platform 30cb0000.aud2htx: deferred probe pending:
(reason unknown)
[   20.793761] platform sound-dmic: deferred probe pending:
asoc-simple-card: parse error
[   20.806374] platform sound-wm8962: deferred probe pending:
asoc-simple-card: parse error
[   20.814526] platform sound-hdmi: deferred probe pending: imx-hdmi:
snd_soc_register_card failed
[   20.826370] platform 30c30000.sai: deferred probe pending: fsl-sai:
PCM DMA init failed
[   20.834429] platform sound-xcvr: deferred probe pending: imx-card:
XCVR PCM: error getting cpu dai info
[   20.846402] platform 30cc0000.xcvr: deferred probe pending: (reason unkn=
own)
[   20.858378] platform sound-adv7535: deferred probe pending:
asoc-simple-card: parse error


adam

> I will give a look and see how to address the issue.
>
> Thanks for the report.
>
> Thanks,
> Peng.
>
> >
> > [   73.245199] imx-sdma 30e10000.dma-controller: Timeout waiting
> > for CH0 ready
> > [   73.252197] ------------[ cut here ]------------
> > [   73.256816] WARNING: CPU: 1 PID: 1080 at
> > kernel/dma/mapping.c:586
> > dma_free_attrs+0x94/0xc0
> > [   73.256832] Modules linked in: overlay af_alg dw_hdmi_gp_audio
> > dw_hdmi_cec tpm_tis_spi snd_soc_hdmi_codec caam_jr tpm_tis_core
> > caamhash_desc caamalg_desc crypto_engine authenc libdes
> > hantro_vpu v4l2_jpeg v4l2_vp9 v4l2_h264 v4l2_mem2mem
> > videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videodev
> > imx8mp_hdmi_tx btnxpuart nvme videobuf2_common dw_hdmi mc
> > nvme_core etnaviv imx_lcdif bluetooth fsl_imx8_ddr_perf
> > drm_display_helper dwmac_imx gpu_sched phy_fsl_samsung_hdmi
> > imx8mp_hdmi_pvi drm_dma_helper samsung_dsim snd_soc_fsl_sai
> > stmmac_platform snd_soc_fsl_xcvr snd_soc_fsl_micfil
> > snd_soc_fsl_aud2htx stmmac adv7511 ecdh_generic imx_pcm_dma
> > snd_soc_fsl_utils ecc pcs_xpcs cec tcpci flexcan tcpm hd3ss3220
> > snd_soc_wm8962 spi_imx can_dev typec at24 caam rtc_pcf85363
> > rtc_snvs error snvs_pwrkey imx8mm_thermal crct10dif_ce
> > snd_soc_imx_hdmi coresight_tmc snd_soc_imx_card
> > snd_soc_simple_card coresight_funnel snd_soc_simple_card_utils
> > display_connector snd_soc_dmic coresight drm_kms_helper
> > imx_cpufreq_dt imx_sdma mwifiex_sdio
> > [   73.256997]  mwifiex cfg80211 rfkill fuse drm backlight ipv6
> > [   73.257015] CPU: 1 UID: 0 PID: 1080 Comm: speaker-test Not
> > tainted
> > 6.10.0-rc7-next-20240709-ga90ee5931efe-dirty #9
> > [   73.257022] Hardware name: Beacon EmbeddedWorks i.MX8MPlus
> > Development kit (DT)
> > [   73.257025] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS
> > BTYPE=3D--)
> > [   73.257031] pc : dma_free_attrs+0x94/0xc0
> > [   73.257037] lr : dma_free_attrs+0x50/0xc0
> > [   73.257041] sp : ffff800084f6b980
> > [   73.257043] x29: ffff800084f6b980 x28: 0000000000000010 x27:
> > 00000000000003c2
> > [   73.257051] x26: 0000000000000005 x25: 0000000000000010 x24:
> > 0000000000000000
> > [   73.257057] x23: 00000000c5504000 x22: 0000000000000000 x21:
> > ffff800083183000
> > [   73.257064] x20: 00000000000000c0 x19: ffff0000c0e54410 x18:
> > 0000000000000006
> > [   73.257071] x17: 0000000000000000 x16: 0000000000000000 x15:
> > ffff800084f6b330
> > [   73.257078] x14: 0000000000000000 x13: ffff8000826845d8 x12:
> > 0000000000000639
> > [   73.257085] x11: 0000000000000213 x10: ffff8000826dc5d8 x9 :
> > ffff8000826845d8
> > [   73.257092] x8 : 00000000ffffefff x7 : ffff8000826dc5d8 x6 :
> > 0000000000000040
> > [   73.257098] x5 : 0000000000000000 x4 : 0000000000000000 x3 :
> > 00000000c5504000
> > [   73.257105] x2 : ffff800083183000 x1 : 0000000000000000 x0 :
> > 00000000000000c0
> > [   73.257112] Call trace:
> > [   73.257115]  dma_free_attrs+0x94/0xc0
> > [   73.257121]  sdma_free_bd+0x60/0x6c [imx_sdma]
> > [   73.257130]  sdma_transfer_init+0x1e8/0x270 [imx_sdma]
> > [   73.257137]  sdma_prep_dma_cyclic+0x74/0x200 [imx_sdma]
> > [   73.257143]  snd_dmaengine_pcm_trigger+0xd8/0x18c
> > [   73.257152]  dmaengine_pcm_trigger+0x18/0x24
> > [   73.257159]  snd_soc_pcm_component_trigger+0x170/0x21c
> > [   73.257168]  soc_pcm_trigger+0xdc/0x1c8
> > [   73.257175]  snd_pcm_do_start+0x44/0x70
> > [   73.257183]  snd_pcm_action_single+0x48/0xa4
> > [   73.257189]  snd_pcm_action+0x80/0x9c
> > [   73.257195]  snd_pcm_start+0x24/0x30
> > [   73.257203]  __snd_pcm_lib_xfer+0x6a4/0x7d8
> > [   73.257208]  snd_pcm_common_ioctl+0x1140/0x1780
> > [   73.257215]  snd_pcm_ioctl+0x34/0x4c
> > [   73.257222]  __arm64_sys_ioctl+0xac/0xf0
> > [   73.257231]  invoke_syscall+0x48/0x114
> > [   73.257239]  el0_svc_common.constprop.0+0x40/0xe0
> > [   73.257246]  do_el0_svc+0x1c/0x28
> > [   73.257252]  el0_svc+0x34/0xd8
> > [   73.257260]  el0t_64_sync_handler+0x120/0x12c
> > [   73.257267]  el0t_64_sync+0x190/0x194
> > [   73.257273] ---[ end trace 0000000000000000 ]---
> > [   73.565659] fsl-sai 30c30000.sai: ASoC: error at
> > soc_component_trigger on 30c30000.sai: -12
> >
> > Write error: -5,Input/output erro[   76.767120] imx-sdma
> > 30e10000.dma-controller: Timeout waiting for CH0 ready
> >
> > No sound is heard.
> >
> > I haven't looked far into the driver to see what was touched, but I was
> > able to reproduce this by enabling and disabling the patch several
> > times, so it's repeatable. imx-sdma 30e10000.dma-controller seems to
> > correspond to sdma2.
> >
> > adam
> > >
> > > Regards,
> > > Peng.
> > >
> > > >
> > > > adam
> > > > >  drivers/clk/imx/clk-imx8mp-audiomix.c | 1 -
> > > > >  1 file changed, 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > > > b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > > > index b381d6f784c8..88d8ba975b5a 100644
> > > > > --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > > > +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > > > @@ -172,7 +172,6 @@ static struct clk_imx8mp_audiomix_sel
> > sels[]
> > > > =3D {
> > > > >         CLK_GATE("ocrama", OCRAMA_IPG),
> > > > >         CLK_GATE("aud2htx", AUD2HTX_IPG),
> > > > >         CLK_GATE("earc_phy", EARC_PHY),
> > > > > -       CLK_GATE("sdma2", SDMA2_ROOT),
> > > > >         CLK_GATE("sdma3", SDMA3_ROOT),
> > > > >         CLK_GATE("spba2", SPBA2_ROOT),
> > > > >         CLK_GATE("dsp", DSP_ROOT),
> > > > > --
> > > > > 2.37.1
> > > > >
> > > > >

