Return-Path: <linux-kernel+bounces-253184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700C8931DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A6B1C21CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 00:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7211B567F;
	Tue, 16 Jul 2024 00:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbRvFpgl"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B71CA9F;
	Tue, 16 Jul 2024 00:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721088178; cv=none; b=h1OosmsDnVd/rccG2xvZO/Z0Bfnq4HK2ODlebjkFJVHJ+he7vhmAfo6RFvG/pawRsTFzLGOJsOYSPHxy3tuynYbNAWUxZ8Ozhy04U792vIcTW5mzwlUXRg1XAqeHCbl/n5tKFooUrG6jzsbtzvSeIsbN7dmEMNgguTjK3Bfa6JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721088178; c=relaxed/simple;
	bh=zSeIktFotF7MC0Z1hV2Kez5mmgh32C6omUyLCRc5ZZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uC9+7aPvhoG8MSu+Cawa0vU9CSkTM1P6b1Rdqc+0ktdLx7yW5ie3Kspz04k0bZ1VBR6okTZg0uAjNDkAKpQPlYEZVg4CSRIwVWqzRBl6xJkW7J96u4gWuB3WBLxE73ZYk3Ayn5314+1jm8d6TVLwaoj/3iA3hJOFFyNRhbUABrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbRvFpgl; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70af8062039so3264685b3a.0;
        Mon, 15 Jul 2024 17:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721088176; x=1721692976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OllUJ9VLJq55ccW5uQ5M246KQQ6K4mJU68va+dsYyM=;
        b=dbRvFpgl4Qzz/GS2STgWSZCPk2mKpNUWcJRQT7y4zJ7BMlL4Lx8MtnVnSLLi+H17vN
         JE4jhuSLT5rNEbxW34iz94toDckjS74qWOl9eatS+X7Eq5zXLYEbSCwHUXjJw8nv6YDW
         lZavJFkbJw4AgvpUIvMr56KEuqslag1BPWLXc+OgznlzHk2bEMUHwimi32ZaW93a0WO7
         DyvLKHrd9I8JOYQuEbTkvkXMpY/5mGKSvP8DtiULQoc3FZC+yYd8O12ken/5Aa947K1/
         yVBUnhQQNAdg6lRhAU/cBzubirEutth/ReXKAlmIHPuQxeZ6qwMFQnKSPhS80OHFA7pg
         NTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721088176; x=1721692976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OllUJ9VLJq55ccW5uQ5M246KQQ6K4mJU68va+dsYyM=;
        b=QjBqUQvKvS50Ah/CGqq7B1T6y8sihAgRcfqY7OGah3NLs8t0pmMAeX9grwMzxcpUjY
         +m5ae0XXSCM1afxLarHDzOvJve41oEaq3Oz1A9rtyUBfOLjtri0Ytt+isSEi/xw2N5bJ
         YtTKfgE4xp1M3ureUPMDxW2AH5JW/MlTWQGkArRkZ3Zil/Auy+6Wb/ydlfO6gVzeIUsN
         QHO98xph1iUNPj/Uvgf7h4OVh/vDHJItlcCB8Q/4cBwt++1BDEIjaCzMIS4c25AkuNcR
         8WPgWWs0fI3+3odW8KKn4tP6Ct/UU0ixxTiu7SzNyiF9TYRZAFBvv9xMjiuilv8r4FBQ
         Xjbg==
X-Forwarded-Encrypted: i=1; AJvYcCVNHpnGMMTcv8inYvM++3kneQ0LAxxmHM3TvDwJhD+4KfRUU7dm0aEfWLf1+gjUITEkq6TibtYwsdh3tKcFqXWEIGTO+GBT1uj7qE9wSTcKUJsLYBMiazF/uhhbFNHAAbpp7Qf24aQU
X-Gm-Message-State: AOJu0YwpKIB13xeil6z/65iN00nczisDfJf+3Rn3az43UG96JaSmtKo+
	SNQsQ8IV9CQ8NKkzV3eYIjLtfo2xUdq4bM9zEQh9/eWvT43Yf/SFaz8BXfwSwPObHSnq6PJx4IP
	9Yt7aXua4gwpJ858SxhNYou/Zl0A=
X-Google-Smtp-Source: AGHT+IE4QMrZIlQ8B9v5YVwd5uq0vAhpYI3DROGAOO5sccBX4Fr/1ACHq+awzUc5R+yepVZ63AaSJQlFxKsCm5ZNTXA=
X-Received: by 2002:a05:6a21:6b0a:b0:1c2:8949:5ba1 with SMTP id
 adf61e73a8af0-1c3f12b4f4emr602954637.53.1721088176180; Mon, 15 Jul 2024
 17:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607133347.3291040-1-peng.fan@oss.nxp.com>
 <20240607133347.3291040-6-peng.fan@oss.nxp.com> <CAHCN7x+pzcdwSq19LefsyYAPUp8=kQYJeVbHm9sgSeaKXigMZg@mail.gmail.com>
 <PAXPR04MB8459E0FEFFFC4F7FB257F32B88A12@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB8459E0FEFFFC4F7FB257F32B88A12@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 15 Jul 2024 19:02:44 -0500
Message-ID: <CAHCN7xLDqLOe9Y8J7R5cEij9Xq=GS1Au8t3hrayf=-zSyorG-w@mail.gmail.com>
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

On Sun, Jul 14, 2024 at 8:11=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH V3 05/15] clk: imx: imx8mp-audiomix: remove
> > sdma root clock
> >
> > On Fri, Jun 7, 2024 at 8:28=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp=
.com>
> > wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > There is an issue:
> > > SDMA3 can't work without setting AUDIOMIX_CLKEN0[SDMA2] (bit-
> > 26) to 1
> > >
> > > The workaround is:
> > > As the reset state of AUDIOMIX_CLKEN0[SDMA2] is enabled, we just
> > need
> > > to keep it on as reset state, don't touch it in kernel, then every
> > > thing is same as before, if we register the clock in clk-audiomix,
> > > then kernel will try to disable it in idle.
> > >
> > > Fixes: 6cd95f7b151c ("clk: imx: imx8mp: Add audiomix block
> > control")
> > > Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> >
> > With this patch,I found it broke the imx8mp-beacon board when
> > running audio through a codec connected to sai3.  Reverting this patch
> > made the crash go away.  Is there a way to mark the clock as critical s=
o
> > it doesn't get idled?
>
> Mark it as critical means the blk ctrl needs to be powered on always.
>
> You driver touched the SDMA2_ROOT clock?

I have a WM8962 CODEC connected through sai3.  Without this patch, the
sound plays just fine.  With this patch, I get the following:

[   73.245199] imx-sdma 30e10000.dma-controller: Timeout waiting for CH0 re=
ady
[   73.252197] ------------[ cut here ]------------
[   73.256816] WARNING: CPU: 1 PID: 1080 at kernel/dma/mapping.c:586
dma_free_attrs+0x94/0xc0
[   73.256832] Modules linked in: overlay af_alg dw_hdmi_gp_audio
dw_hdmi_cec tpm_tis_spi snd_soc_hdmi_codec caam_jr tpm_tis_core
caamhash_desc caamalg_desc crypto_engine authenc libdes hantro_vpu
v4l2_jpeg v4l2_vp9 v4l2_h264 v4l2_mem2mem videobuf2_dma_contig
videobuf2_memops videobuf2_v4l2 videodev imx8mp_hdmi_tx btnxpuart nvme
videobuf2_common dw_hdmi mc nvme_core etnaviv imx_lcdif bluetooth
fsl_imx8_ddr_perf drm_display_helper dwmac_imx gpu_sched
phy_fsl_samsung_hdmi imx8mp_hdmi_pvi drm_dma_helper samsung_dsim
snd_soc_fsl_sai stmmac_platform snd_soc_fsl_xcvr snd_soc_fsl_micfil
snd_soc_fsl_aud2htx stmmac adv7511 ecdh_generic imx_pcm_dma
snd_soc_fsl_utils ecc pcs_xpcs cec tcpci flexcan tcpm hd3ss3220
snd_soc_wm8962 spi_imx can_dev typec at24 caam rtc_pcf85363 rtc_snvs
error snvs_pwrkey imx8mm_thermal crct10dif_ce snd_soc_imx_hdmi
coresight_tmc snd_soc_imx_card snd_soc_simple_card coresight_funnel
snd_soc_simple_card_utils display_connector snd_soc_dmic coresight
drm_kms_helper imx_cpufreq_dt imx_sdma mwifiex_sdio
[   73.256997]  mwifiex cfg80211 rfkill fuse drm backlight ipv6
[   73.257015] CPU: 1 UID: 0 PID: 1080 Comm: speaker-test Not tainted
6.10.0-rc7-next-20240709-ga90ee5931efe-dirty #9
[   73.257022] Hardware name: Beacon EmbeddedWorks i.MX8MPlus
Development kit (DT)
[   73.257025] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   73.257031] pc : dma_free_attrs+0x94/0xc0
[   73.257037] lr : dma_free_attrs+0x50/0xc0
[   73.257041] sp : ffff800084f6b980
[   73.257043] x29: ffff800084f6b980 x28: 0000000000000010 x27: 00000000000=
003c2
[   73.257051] x26: 0000000000000005 x25: 0000000000000010 x24: 00000000000=
00000
[   73.257057] x23: 00000000c5504000 x22: 0000000000000000 x21: ffff8000831=
83000
[   73.257064] x20: 00000000000000c0 x19: ffff0000c0e54410 x18: 00000000000=
00006
[   73.257071] x17: 0000000000000000 x16: 0000000000000000 x15: ffff800084f=
6b330
[   73.257078] x14: 0000000000000000 x13: ffff8000826845d8 x12: 00000000000=
00639
[   73.257085] x11: 0000000000000213 x10: ffff8000826dc5d8 x9 : ffff8000826=
845d8
[   73.257092] x8 : 00000000ffffefff x7 : ffff8000826dc5d8 x6 : 00000000000=
00040
[   73.257098] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000c55=
04000
[   73.257105] x2 : ffff800083183000 x1 : 0000000000000000 x0 : 00000000000=
000c0
[   73.257112] Call trace:
[   73.257115]  dma_free_attrs+0x94/0xc0
[   73.257121]  sdma_free_bd+0x60/0x6c [imx_sdma]
[   73.257130]  sdma_transfer_init+0x1e8/0x270 [imx_sdma]
[   73.257137]  sdma_prep_dma_cyclic+0x74/0x200 [imx_sdma]
[   73.257143]  snd_dmaengine_pcm_trigger+0xd8/0x18c
[   73.257152]  dmaengine_pcm_trigger+0x18/0x24
[   73.257159]  snd_soc_pcm_component_trigger+0x170/0x21c
[   73.257168]  soc_pcm_trigger+0xdc/0x1c8
[   73.257175]  snd_pcm_do_start+0x44/0x70
[   73.257183]  snd_pcm_action_single+0x48/0xa4
[   73.257189]  snd_pcm_action+0x80/0x9c
[   73.257195]  snd_pcm_start+0x24/0x30
[   73.257203]  __snd_pcm_lib_xfer+0x6a4/0x7d8
[   73.257208]  snd_pcm_common_ioctl+0x1140/0x1780
[   73.257215]  snd_pcm_ioctl+0x34/0x4c
[   73.257222]  __arm64_sys_ioctl+0xac/0xf0
[   73.257231]  invoke_syscall+0x48/0x114
[   73.257239]  el0_svc_common.constprop.0+0x40/0xe0
[   73.257246]  do_el0_svc+0x1c/0x28
[   73.257252]  el0_svc+0x34/0xd8
[   73.257260]  el0t_64_sync_handler+0x120/0x12c
[   73.257267]  el0t_64_sync+0x190/0x194
[   73.257273] ---[ end trace 0000000000000000 ]---
[   73.565659] fsl-sai 30c30000.sai: ASoC: error at
soc_component_trigger on 30c30000.sai: -12

Write error: -5,Input/output erro[   76.767120] imx-sdma
30e10000.dma-controller: Timeout waiting for CH0 ready

No sound is heard.

I haven't looked far into the driver to see what was touched, but I
was able to reproduce this by enabling and disabling the patch several
times, so it's repeatable. imx-sdma 30e10000.dma-controller seems to
correspond to sdma2.

adam
>
> Regards,
> Peng.
>
> >
> > adam
> > >  drivers/clk/imx/clk-imx8mp-audiomix.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > index b381d6f784c8..88d8ba975b5a 100644
> > > --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > @@ -172,7 +172,6 @@ static struct clk_imx8mp_audiomix_sel sels[]
> > =3D {
> > >         CLK_GATE("ocrama", OCRAMA_IPG),
> > >         CLK_GATE("aud2htx", AUD2HTX_IPG),
> > >         CLK_GATE("earc_phy", EARC_PHY),
> > > -       CLK_GATE("sdma2", SDMA2_ROOT),
> > >         CLK_GATE("sdma3", SDMA3_ROOT),
> > >         CLK_GATE("spba2", SPBA2_ROOT),
> > >         CLK_GATE("dsp", DSP_ROOT),
> > > --
> > > 2.37.1
> > >
> > >

