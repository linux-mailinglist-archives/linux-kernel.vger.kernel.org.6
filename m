Return-Path: <linux-kernel+bounces-521794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDC8A3C262
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5FB1889AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EBA1F2BA9;
	Wed, 19 Feb 2025 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCOt9Dr9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300D71DF962;
	Wed, 19 Feb 2025 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976103; cv=none; b=Quk7KW3CSkafP+Tbyxc2p583wpwyCUB6ZnECfsF0+qYCSEkD4sHl5kgcl6YoxfOYtQ6J+gVj4wd29wneyDeg4vsvaodgfLd25E4w5DVyVBA5HjBgnMJoMoSFClG42hnQ4/u99K4pKw1hlTgR/Gm9ppzUoXZo3IMaM/VTJXu31F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976103; c=relaxed/simple;
	bh=aFHJFUNnj/uP7yBlq1BkIXXCtxRzsu5EjMkpUsUP6II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTTCFZ6bHv8vTgbJaA+7x2WI4822siJgzSyHE35N1kaeQO4LhxQ6hXnAZqmeCDAwcwutPJlarOUH/ZLe/c+dcH0xM2u70n1PCZxRg/IvSA+1q9w2QFxxJCXdeOkcAiUjXXk5kTPfRaOinCTpLsCO5ozlYsoPwKKja+mR62yHQhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCOt9Dr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CA5C4CED1;
	Wed, 19 Feb 2025 14:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739976102;
	bh=aFHJFUNnj/uP7yBlq1BkIXXCtxRzsu5EjMkpUsUP6II=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCOt9Dr9NDbDXH91HqKrsnZsbzj/3OE8QEvCLlJsOx5kkzzDh+iUJKK54rYIbuhRk
	 14SfhFJeXnDIrjK0bdajREetLXDSheDMpkgZ1sfpdsokOUfTkjxPcUOaNPSW9S++0G
	 UYJsmwAXz8PNB+CP8q2hXIP7GgcNxnfx5k2Vt7pzBEY9vPRTycyr56vmH9jdXEa4yj
	 MZ51rVDcyyJDTn+MjsWfPX1gi4LvuowaIj3iQQakGGHt393n8maIA/4Y7cRKCB6Dko
	 2CPkGbqBjt9rTLf10BQZiQIVbZ9mTCitQadXtvGrSSPhGkzRHIk8mzHAForC1wKtTb
	 SuUABbialD5tg==
Date: Wed, 19 Feb 2025 14:41:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	hpa@zytor.com, Marc Zyngier <maz@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v6 02/10] irqchip/irq-msi-lib: Optionally set default
 irq_eoi/irq_ack
Message-ID: <Z7Xto0WZ-Crxunik@finisterre.sirena.org.uk>
References: <20250217085657.789309-1-apatel@ventanamicro.com>
 <20250217085657.789309-3-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mBaqZzvs8jn0KJbF"
Content-Disposition: inline
In-Reply-To: <20250217085657.789309-3-apatel@ventanamicro.com>
X-Cookie: A little pain never hurt anyone.


--mBaqZzvs8jn0KJbF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 02:26:48PM +0530, Anup Patel wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>=20
> Introduce chip_flags in struct msi_parent_ops. This allows
> msi_lib_init_dev_msi_info() set default irq_eoi/irq_ack
> callbacks only when the corresponding flags are set in
> the chip_flags.

I'm seeing boot regressions with qemu on arm64 in -next which bisect
down to this patch.  We hit a NULL pointer dereference:

<6>[    0.898900] virtio_blk virtio1: 1/0/0 default/read/poll queues
<5>[    0.910197] virtio_blk virtio1: [vda] 3906250 512-byte logical blocks=
 (2.00 GB/1.86 GiB)
<1>[    0.924459] Unable to handle kernel NULL pointer dereference at virtu=
al address 0000000000000000
<1>[    0.924508] Mem abort info:
<1>[    0.924521]   ESR =3D 0x000000008600002b
<1>[    0.924559]   EC =3D 0x21: IABT (current EL), IL =3D 32 bits
<1>[    0.924580]   SET =3D 0, FnV =3D 0
<1>[    0.924597]   EA =3D 0, S1PTW =3D 0
<1>[    0.924616]   FSC =3D 0x2b: level -1 translation fault
<1>[    0.924667] [0000000000000000] user address but active_mm is swapper
<0>[    0.924833] Internal error: Oops: 000000008600002b [#1] PREEMPT SMP

=2E..

<4>[    0.933487] Call trace:
<4>[    0.933767]  0x0 (P)
<4>[    0.934028]  handle_fasteoi_irq+0xb0/0x1cc
<4>[    0.934296]  handle_irq_desc+0x40/0x58
<4>[    0.934502]  generic_handle_domain_irq+0x1c/0x28
<4>[    0.934686]  gic_handle_irq+0x4c/0x120
<4>[    0.934866]  call_on_irq_stack+0x24/0x4c
<4>[    0.935034]  do_interrupt_handler+0x80/0x84
<4>[    0.935233]  el1_interrupt+0x34/0x68
<4>[    0.935417]  el1h_64_irq_handler+0x18/0x24
<4>[    0.935573]  el1h_64_irq+0x6c/0x70
<4>[    0.935775]  blk_mq_dispatch_rq_list+0x29c/0x6f0 (P)
<4>[    0.935964]  __blk_mq_sched_dispatch_requests+0x460/0x57c

Full log:

   https://lava.sirena.org.uk/scheduler/job/1126644

bisect log (there's a bunch of good commits added at the start since my
automation harvests results it already knows about to feed bisects):

# bad: [8936cec5cb6e27649b86fabf383d7ce4113bba49] Add linux-next specific f=
iles for 20250219
# good: [67961d4f4e34f5ed1aeebab08f42c2e706837ec5] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
# good: [d1a09c610027e446ed30c21f61c2f2443bf92a3f] MAINTAINERS: adjust the =
file entry in SPI OFFLOAD
# good: [a78f244a9150da0878a37a1b59fb0608b1ccfb9d] ASoC: SOF: imx: Fix erro=
r code in probe()
# good: [b20be2c77ce5341ded1a2d8aec119f6dca8ef1ad] ASoC: SOF: imx: Fix an I=
S_ERR() vs NULL bug in imx_parse_ioremap_memory()
# good: [5d9fca12f54d3e25e02521aa8f3ec5d53759b334] ASoC: amd: ps: fix incon=
sistent indenting warning in check_and_handle_sdw_dma_irq()
# good: [3f02dedf1566858736f351a8d4a3ce91375e48f1] ASoC: random cleanup
# good: [0770b7cc095e015af302f0758d3d85c7f17c719a] ASoC: tas2764: Random pa=
tches from the Asahi Linux
# good: [e0f421d73053eaeb441aa77054b75992705656c7] ASoC: SOF: ipc3: Use str=
_enabled_disabled() helper function
# good: [5c7e4c4da8586d2ef55a11a9f4df626b8ea9a146] ASoC: dt-bindings: wlf,w=
m8960: add 'port' property
# good: [783db6851c1821d8b983ffb12b99c279ff64f2ee] ASoC: ops: Enforce platf=
orm maximum on initial value
# good: [9f25b6f2568d50c247a8e3b031a0a5caee8c17d2] ASoC: wm_hubs: Use str_e=
nable_disable() in wm_hubs_update_class_w()
# good: [9dc016eaba3a70febcd1db5f1a0beeb7430166aa] ASoC: SOF: Intel: Don't =
import non-existing module namespace
# good: [e08fe24c34d37d00e84009f2fb4c35f5978041e6] ASoC: SOF: Intel: Use st=
r_enable_disable() helper
# good: [1c3b5f37409682184669457a5bdf761268eafbe5] ASoC: tas2764: Power up/=
down amp on mute ops
# good: [f37f1748564ac51d32f7588bd7bfc99913ccab8e] ASoC: tas2764: Mark SW_R=
ESET as volatile
# good: [7e1caa679686dde5c24d60b139f234568045758f] ASoC: soc-pcm: makes dpc=
m_dapm_stream_event() void
# good: [d64c4c3d1c578f98d70db1c5e2535b47adce9d07] ASoC: tas2764: Add reg d=
efaults for TAS2764_INT_CLK_CFG
# good: [40b1f89a1691c4b7740bec2c868f1e4c60346353] ASoC: remove dpcm_proces=
s_paths()
# good: [42da18e62652b58ba5ecd1524c146b202cda9bb7] ASoC: soc-pcm: cleanup d=
pcm_fe_dai_do_trigger()
# good: [3aebbcba4baaa81bc8c83f2229ed8e774cf40618] ASoC: soc-pcm: cleanup d=
pcm_dai_trigger_fe_be()
# good: [1248d29464cc682c2a1793cfc5d4ebeb374c6738] ASoC: soc-ops: makes snd=
_soc_read_signed() void
# good: [7f1186a8d738661b941b298fd6d1d5725ed71428] ASoC: soc-dai: check ret=
urn value at snd_soc_dai_set_tdm_slot()
# good: [238c863eb3d3c6ed58493bacfd1f4b36bdcfa92f] ASoC: soc-core: makes sn=
d_soc_set_dmi_name() local
# good: [0c4a06395156d16ea33e959fccea84e4cfec04c4] ASoC: soc-pcm: remove du=
plicate param from __soc_pcm_hw_params()
# good: [08a66f55f7246d477b19620a953476dfc02beefc] ASoC: tas2764: Wait for =
ramp-down after shutdown
# good: [257a060fe219bb0dcb98f12ce34f04eca6d08352] ASoC: remove update from=
 snd_soc_card
# good: [11c1967f1a796bf2ff56a7118147f1d39d9f5ee0] ASoC: soc-pcm: no need t=
o check dpcm->fe on dpcm_be_connect()
# good: [994719ed6d81a6f4677875ab6730254c0bc484ea] ASoC: Intel: avs: Use st=
r_on_off() in avs_dsp_core_power()
# good: [ae575d2145d1a2c8bb5d2835d7d54751f3b0bace] ASoC: tegra: Remove the =
isomgr_bw APIs export
# good: [828c0aa63706410503526d0ee522b9ac3232c86b] ASoC: amd: ps: use switc=
h statements for acp pci revision id check
# good: [74e0fcbd705d4277267311f8f26a00bb8ce93820] gpiolib: add gpiod_multi=
_set_value_cansleep
# good: [f22ba3561daa792dd138ed543e0bf48efe0b999c] ASoC: SOF: imx-common: s=
et sdev->pdata->hw_pdata after common is alloc'd
# good: [ad0fbcebb5f6e093d433a0873758a2778d747eb8] ASoC: adau1701: use gpio=
d_multi_set_value_cansleep
# good: [c6bb909b8f11b9403715a325b51c2bcf01e2bbc0] Merge branch 'slab/for-6=
=2E15/kfree_rcu_tiny' into slab/for-next
# good: [e957c96455e8f4c630d5e374312cad0633ca7e17] spi: offload: fix use af=
ter free
# good: [d795a052b0ddad3da83dda6ff522c1b1aaa4a525] spi: fix missing offload=
_flags doc
# good: [91931af18bd22437e08e2471f5484d6fbdd8ab93] gpiolib: add gpiod_multi=
_set_value_cansleep()
# good: [ff4d4158ef9143327a42f7be4298751cb0d1be69] spi: spi-offload-trigger=
-pwm: add extra headers
# good: [fcd7ace9a725ae034ff9f24cb94c9fe12a1f02da] spi: offload: types: inc=
lude linux/bits.h
# good: [21aa330fec31bb530a4ef6c9555fb157d0711112] ASoC: fsl_micfil: Add de=
cimation filter bypass mode support
# good: [e97d06cb4386af4e069a2dc713de70500538d0bd] ASoC: tscs454: Use str_e=
nable_disable() in pll_power_event()
# good: [ad1212a9cc24b740b2711014933fac6ace32aa2d] arm64: dts: rockchip: Ad=
d SPDIF on RK3588
# good: [d1541caab053cf94b114582a23b51a8cb90f4a46] Add SDCA DisCo parsing s=
upport
# good: [f46eb2bfb878ce3345725252f77fa3ba36a0f087] spi: axi-spi-engine: add=
 offload support
# good: [c5528214c7c0a753c908a7b353309ba665985fb4] ASoC: codecs: wcd93xx-sd=
w: fix of_property_read_bool() warnings
# good: [2c17e9ea0caa5555e31e154fa1b06260b816f5cc] dmaengine: idxd: Delete =
unnecessary NULL check
# good: [3c331bdeececb629669961a80c0f929301c088d2] Refactor imx drivers and=
 introduce support for
# good: [93354d866ac44d0f9d65b2e4adb5cc9a1c1912c9] prandom: remove next_pse=
udo_random32
# good: [330cbb40bb3664a18a19760bd6dc6003d6624041] dt-bindings: ASoC: rockc=
hip: Add compatible for RK3588 SPDIF
# good: [2f9523091a97abf8584a79ed406fd8ffe9063ec0] Merge branch 'misc' into=
 for-next
# good: [651e0ed391b148f83afba0bfbd8a56e38e58c34d] ASoC: SOF: imx: introduc=
e more common structures and functions
# good: [005859a2cf7aa349fbbfe433ab1769b15c535b72] ASoC: amd: Add support f=
or ACP7.0 & ACP7.1
# good: [563e40153a56cbfae8721f9591022df5d930f939] ASoC: SOF: imx8: use IMX=
_SOF_* macros
# good: [700a281905f2a4ccf6f3b2d3cd6985e034b4b021] spi: add offload TX/RX s=
treaming APIs
# good: [629dd55cf77bd3a8f80049150d3c05fef6d3b468] ASoC: SDCA: Minor format=
ting and naming tweaks
# good: [d7231be4b4657e5f922a4c6dc11e8dffc71fee87] spi: offload: add suppor=
t for hardware triggers
# good: [d920908fe36c2b3a1c6fe444831e0c8c2a995fd1] Merge branch 'for-6.14-f=
ixes' into for-next
# good: [07e3e514dd385300bd08da4a8df09240d272821e] ASoC: SOF: imx: merge im=
x8 and imx8ulp drivers
# good: [645753d01356ff1a756812f1c69c53eb5c9081cd] ASoC: SOF: imx8: use com=
mon imx chip interface
# good: [f98d42000216677d177384f202ff1cc896a7395f] ASoC: Intel: soc-acpi-in=
tel-ptl-match typo fixups
# good: [5a19e1985d014fab9892348f6175a19143cec810] spi: axi-spi-engine: imp=
lement offload support
# good: [896530b7b0c08ee8b3296d5f012bfe1b0a979b86] ASoC: SOF: imx: merge im=
x8 and imx8m drivers
# good: [19f6748abbab8523a7b32a5e371e39d4d8d4aba5] ASoC: SDCA: Parse initia=
lization write table
# good: [9ee6d50ae4b0fe14ed70a5265a05874d41e10848] ASoC: SDCA: Add support =
for Entity 0
# good: [f87c2a275033120e15213f3d65234d98e726c4b7] ASoC: SDCA: Add Channel =
Cluster parsing
# good: [ebb398ae1e052c4245b7bcea679fe073111db2ce] spi: offload-trigger: ad=
d PWM trigger driver
# good: [8e02d188698851436f76038ea998b726193d1b10] spi: add basic support f=
or SPI offloading
# good: [5c93b20f6de4478e1fbcfb38eb46738bca74180e] ASoC: SDCA: Add support =
for IT/OT Entity properties
# good: [42b144cb6a2d87385fa0b124c975d6cf1e3ec630] ASoC: SDCA: Add SDCA Con=
trol parsing
# good: [e1101373df5cd7672d988bb4e9cdd5eb97003165] spi: dt-bindings: axi-sp=
i-engine: add SPI offload properties
# good: [e80b8e5c53c30df1cba45258d10b04872b7eea67] ASoC: SDCA: Add support =
for clock Entity properties
# good: [9da195880f167ab7c2d595388decf783c9920121] ASoC: SDCA: Add support =
for PDE Entity properties
# good: [83f37ba7b76ab17e029ab4127ec64ccccce64c00] dt-bindings: trigger-sou=
rce: add generic PWM trigger source
# good: [45e02edd8422b6c4a511f38403dbd805cd139733] ASoC: SOF: imx8: drop un=
needed/unused macros/header includes
# good: [6cf5df1040ba0694aea6a5edc6f31811a442ea36] ASoC: SOF: imx: add driv=
er for the imx95 chip
# good: [64fb5af1d1bbcf1b808e9bb092b22fa1b691ae63] ASoC: SDCA: Add parsing =
for Control range structures
# good: [996bf834d0b61cb5a1389356c1ed7db1230139d7] ASoC: SDCA: Add code to =
parse Function information
# good: [d0252b0b945ec67fd09fc764dcadf445fb7757ee] ASoC: amd: acp: amd-acp7=
0-acpi-match: Add rt722 support
# good: [187150671d83324f1ca56f7ab5e00f16a3b9f2a9] ASoC: amd: acp: add RT71=
1, RT714 & RT1316 support for ACP7.0 platform
# good: [fcb754602724fa2a1d0db72f13ddc3ef0306f911] ASoC: amd: ps: store acp=
 revision id in SoundWire dma driver private data
# good: [43d6140cedad9f031b47dfde6f85856e007b3f04] ASoC: amd: ps: refactor =
soundwire dma interrupts enable/disable sequence
# good: [31e3100d5e1fe69f944f84867be0cbfa5fd380c8] ASoC: amd: acp: amd-acp7=
0-acpi-match: Add RT1320 & RT722 combination soundwire machine
# good: [491628388005a26c02d6827e649284357daec213] ASoC: amd: ps: add callb=
ack functions for acp pci driver pm ops
# good: [1c35755f46423150e19ff57448786b4bb48fdb46] ASoC: amd: ps: implement=
 function to restore dma config for ACP7.0 platform
# good: [0b6914a0121b4c9fc8f575b60a5dd43b74612908] ASoC: amd: ps: add sound=
wire dma interrupts handling for ACP7.0 platform
# good: [0eb8f83c055cb3461734710d1b1ce2dd4f01806e] ASoC: amd: ps: update mo=
dule description
# good: [852c0b7204ded184924c41ab99b2ac7a70ad4dab] ASoC: Intel: soc-acpi-in=
tel-ptl-match: add rt713_vb_l2_rt1320_l13
# good: [3898b189079c85735f57759b0d407518c01c745e] ASoC: amd: ps: add sound=
wire wake interrupt handling
# good: [c878d5c1a525b88807d9d79888fe8340bcbf1aa3] ASoC: amd: ps: add ACP7.=
0 & ACP7.1 specific soundwire dma driver changes
# good: [4b36a47e2d989b98953dbfb1e97da0f0169f5086] ASoC: amd: ps: use macro=
 for ACP6.3 pci revision id
# good: [fde277dbcf53be685d0b9976d636366c80a74da8] ASoC: amd: ps: add pm op=
s related hw_ops for ACP7.0 & ACP7.1 platforms
# good: [91f505dc3a94c04421a2a51e8c40acf7ea67ecbc] ASoC: Intel: soc-acpi-in=
tel-ptl-match: add rt712_vb + rt1320 support
# good: [552f66c40134542f15d4302837e7d581a0b8e217] ASoC: amd: update Pink S=
ardine platform Kconfig description
# good: [638ad2bdb2f994c8bd99cc40e0c4796a8617ccf3] ASoC: amd: acp: add mach=
ine driver changes for ACP7.0 and ACP7.1 platforms
# good: [4bb5b6f13fd83b32c8a93fbd399e7558415d1ce0] ASoC: amd: amd_sdw: Add =
quirks for Dell SKU's
# good: [e2ceac2f323625632f12dd5333092976298a0cde] ASoC: amd: ps: rename st=
ructure names, variable and other macros
# good: [0fa0843db17ccd427fc7a23d313aafa88fc89e04] ASoC: amd: ps: refactor =
soundwire dma driver code
# good: [7c0ea26c57b0bb72d503fe27d6533f5addc5e3a3] ASoC: amd: ps: add pci d=
river hw_ops for ACP7.0 & ACP7.1 variants
# good: [f1e91acacf86fb2cd7478af490326cb9aa63e8ae] ASoC: amd: ps: update fi=
le description and copyright year
# good: [0a27b2d7a224326fab543ca586d501fe1857b655] ASoC: amd: ps: add sound=
wire dma irq thread callback
# good: [6547577e94ae3d9f8ff30d3267fe7ec394e3b20d] ASoC: amd: ps: add callb=
ack to read acp pin configuration
# good: [605aab3b3ca83f58681841b2dd16d4a7baefde6c] ASoC: amd: ps: rename ac=
p_restore_sdw_dma_config() function
# good: [4516be370ced14c4fb454fd6cc016e47bffe109e] ASoC: amd: ps: refactor =
soundwire dma interrupt handling
# good: [db746fff89a14419379226ce0df8b94f472cf38c] ASoC: amd: ps: add acp p=
ci driver hw_ops for acp6.3 platform
# good: [a23ff143804d3b8c27157ffa19e48b4e22939115] ASoC: Intel: avs: Add su=
pport for MalibouLake
# good: [f0703ce627a25b4a1307d8a92cfd6d6bf7e27e7a] ASoC: cpcap: Implement j=
ack headset detection
# good: [5585e342e8d38cc598279bdb87f235f8b954dd5a] cxl/memdev: Remove unuse=
d partition values
# good: [f2d161e5804d8da070988624b9edd179ef31b478] ASoC: and adn use snd_so=
c_ret()
# good: [6b8f162bd3fa82c3c1b3653100d04172c1dbd8a5] ASoC: SOF: Improve the s=
pcm and ipc4 copier prints
# good: [46ab7d80ed4f378e02cb249bd49a76026a2d683f] Add static channel mappi=
ng between soundwire master
# good: [cb161c333927142818d6bf22a4da2b023fb2b8c9] ASoC: tas2781: Switch to=
 use %ptTsr
# good: [96dd187c93afe0ae0535276a92ed488759ace5a2] This is continued work o=
n Samsung S9(SM-9600)
# good: [153dbf4adad0082d030c30d20541df2b1af52db6] regmap: irq: Use one way=
 of setting all bits in the register
# good: [861e232e15c278d6cfc5a675efe393b4838b1773] Merge branch 'for-6.15/f=
w-first-error-logging' into cxl-for-next
# good: [5ea46b4360791345bd0bf4c7bf8fff5151374ea1] ASoC: SOF: ipc4-pcm: Mov=
e out be_rate initialization from for loop in fixup
# good: [0e9a970d7b2cb98d741bc0e32ad8c8f30c009c63] ASoC: qcom: sdw: Add get=
 and set channel maps support from codec to cpu dais
# good: [0a7c85b516830c0bb088b0bdb2f2c50c76fc531a] regulator: ad5398: Fix i=
ncorrect power down bit mask
# good: [315c2f0b53ba2645062627443a12cea73f3dad9c] acpi/ghes, cper: Recogni=
ze and cache CXL Protocol errors
# good: [2466b62268c020606d20b45e007c166399e639ee] ASoC: dapm: unexport dap=
m_mark_endpoints_dirty()
# good: [583348bd65ceaf4a5067a6267dd236929e1b4b37] ASoC: SOF: ipc4-topology=
: Improve the information in prepare_copier prints
# good: [ecfcee245cc99def0f6bf84ac75ac372f8ab65eb] ASoC: dapm: unexport snd=
_soc_dapm_init()
# good: [a0ef5b4b101424b8a666ed56bf1717dafe2d37f5] ASoC: simple-card: use s=
nd_soc_ret()
# good: [4c7518062d638837cea915e0ffe30f846780639a] ASoC: SOF: ipc4: Add sup=
port for split firmware releases
# good: [3f78762d17701f0435ad958b2821dc3243ff34b3] ASoC: dapm: unexport snd=
_soc_dapm_update_dai()
# good: [9bbbf33a5ab84c0f3643f43350b0f473b60af5b8] spi: gpio: Enable a sing=
le always-selected device
# good: [062b7ef6b103dcbcb3c084e8ace8e74e260b2346] ASoC: soc-utils: care -E=
OPNOTSUPP on snd_soc_ret()
# good: [c06c4f7cbea1d8dc71485bfddef2849a1b721e67] ASoC: codecs: wcd937x: A=
dd static channel mapping support in wcd937x-sdw
# good: [943116ba2a6ab472e8ad2d1e57a3f10f13485cc2] ASoC: add common snd_soc=
_ret() and use it
# good: [7796c97df6b1b2206681a07f3c80f6023a6593d5] soundwire: qcom: Add set=
_channel_map api support
# good: [78e66dd5f32a1a8e5ee6decadd4e4dffa7d2c40d] ASoC: mediatek: mt8186: =
Remove unused mt8186_afe_(suspend|resume)_clock
# good: [61eac5f7f6439e8fe99b5fb29406acb0fd7b83c6] efi/cper, cxl: Remove cp=
er_cxl.h
# good: [860693187c597645b28a421d8acb26428b8afd3f] ASoC: SOF: pcm: Add snd_=
sof_pcm specific wrappers for dev_dbg() and dev_err()
# good: [2d7395b23dbf4c2d60be49b73e4c4705fc446662] ASoC: simple-card-utils:=
 use snd_soc_ret()
# good: [be61cd4242e4a53f5cf989ee7573121d041444bc] ASoC: soc-pcm: use snd_s=
oc_ret()
# good: [72826381215e2f9d2bd2f32f63f76a80942b7fdf] ASoC: dt-bindings: wcd93=
7x-sdw: Add static channel mapping support
# good: [4d2ea16576c8aa1437048cf436bff85653f139fe] ASoC: SOF: pcm: Move per=
iod/buffer configuration print after platform open
# good: [169ec0a541aac8afb215ab591b0fd53276686014] ASoC: SOF: Relocate and =
rework functionality for PCM stream freeing
# good: [74a0ca4c7f19f1b273d665b3b53f7ae8af879658] ASoC: audio-graph-card: =
use snd_soc_ret()
# good: [8d83282e53185ec257a4ce08812e8fabee2c7212] ASoC: audio-graph-card2:=
 use snd_soc_ret()
# good: [43ca2463df9de2c192b03a0f4dc964e6ba7d7993] cxl: Refactor user ioctl=
 command path from mds to mailbox
# good: [b3d993c7566fed1c027c5c18f3ef482ba8e6307a] ASoC: amd: acp: Use str_=
low_high() helper function
# good: [215705db51eb23052c73126d2efb6acbc2db0424] spi: Replace custom fsle=
ep() implementation
# good: [c108905a7423d44237d17374f845fc5bb9cb9728] spi: gpio: Remove stale =
documentation part
# good: [185ac20a7b055e025027d303b63dab456b4f5d5e] ASoC: rt722: get lane ma=
pping property
# good: [3f75771987f32a9f512c8944e70e343f8c6d71c1] ASoC: SOF: mediatek: Use=
 str_on_off() helper function
# good: [6603c5133daadbb3277fbd93be0d0d5b8ec928e8] ASoC: dt-bindings: atmel=
,at91-ssc: Convert to YAML format
# good: [678681828bf4abfd3c31f36390d2097682141d11] ASoC: dmic: Add DSD big =
endian format support
# good: [25fac20edd09b60651eabcc57c187b1277f43d08] spi: gpio: Support a sin=
gle always-selected device
# good: [991d98f17d31644826977e49477544987000a08a] cxl: Make cxl_dpa_alloc(=
) DPA partition number agnostic
# good: [78d9ee370ed33cd8b662981fe1f47cff7b4f0e43] dt-bindings: eeprom: at2=
4: Add compatible for Puya P24C64F
# good: [e27c125040b1e1f26d910b46daabbe55e67fdf3b] ASoC: codecs: wcd934x: u=
se wcd934x binding header
# good: [c2a756660324fceca26780a50950e6d91dfdc210] counter: ti-eqep: add di=
rection support
# good: [8478dadc8148af311c3d43d4867cfb6632686ede] ASoC: dt-bindings: Add b=
indings for WCD934x DAIs
# good: [e3cd85963a20d2b92e77046a8d9f0777815f1f71] x86/mtrr: Use str_enable=
d_disabled() helper in print_mtrr_state()
# good: [652ffad172d089acb1a20e5fde1b66e687832b06] spi: fsi: Batch TX opera=
tions
# good: [b2f10aa2eb18d289e48097e0ed973e714322175b] x86/entry: Add __init to=
 ia32_emulation_override_cmdline()
# good: [fb6ec1d27608c008bfe1ab0dfec3720990eb2451] ASoC: mediatek: mt6358: =
Remove unused functions
# good: [1a4a5a752fcd60797ed2cb7c06253c6433d13f63] ASoC: soc-ops: remove so=
c-dpcm.h
# good: [e92f042642aed6f6206caace892d9df2d0166841] ASoC: codecs: pcm3168a: =
Relax probing conditions
# good: [4a91fe4c0d683c56044579fb263c660f5d18efac] ASoC: tegra: Add interco=
nnect support
# good: [79ebb596201c86712fe38b0ef73d25d07b932664] ASoC: Intel: avs: Add pc=
m3168a machine board
# good: [f0173cbe7fa79eafbdf32eed32337209f84ddacd] ASoC: Intel: avs: New ga=
teway configuration mechanism
# good: [cbe37a4d2b3c25d2e2a94097e09b6d87461b8833] ASoC: Intel: avs: Config=
ure basefw on TGL-based platforms
# good: [320155a61f7fc810a915644e9e2a451bdcea90b1] ASoC: Intel: avs: Remove=
 unused gateway configuration code
# good: [e995c51903384be1c7aead246dc30cb5244179ac] ASoC: Intel: avs: Move D=
SP-boot steps into individual functions
# good: [7d92a38d67e5d937b64b20aa4fd14451ee1772f3] ASoC: codecs: pcm3168a: =
Allow for 24-bit in provider mode
# good: [6eab7034579917f207ca6d8e3f4e11e85e0ab7d5] ASoC: soc-core: Stop usi=
ng of_property_read_bool() for non-boolean properties
# good: [856366dc924a9561dae39f252b45dfd6cc6895ce] ALSA: hda: Select avs-dr=
iver by default on MBL
# good: [3c32a4386909e8023b3c49253fec33d267be16bb] regulator: Add device tr=
ee support to AD5398
# good: [299ce4beaf714abe76e3ad106f2e745748f693e9] ASoC: rt722-sdca: Make u=
se of new expanded MBQ regmap
# good: [a05143a8f713d9ae6abc41141dac52c66fca8b06] ASoC: SOF: topology: Use=
 krealloc_array() to replace krealloc()
# good: [26a756fc10fac6f133ef47f12362a39769dfe24d] spi: zynqmp-gqspi: Clean=
 up the driver a bit
# good: [dc561ab16d8be9cbe8f07a49a7b2f5428fbcfeea] ASoC: codecs: pcm3168a: =
Add ACPI match table
# good: [c9e9aa80022c6db71bc097a621a6145f39aa0ade] ASoC: mediatek: Remove u=
nused mtk_memif_set_rate
# good: [b9fb91692af881736f8fa1741fa0dbadf07d99ee] ASoC: Intel: avs: pcm316=
8a board selection
# good: [4343af66b8e1df1d3a2e6f1f8612506cb45b2afd] ASoC: Intel: avs: Add WH=
M module support
# good: [f9a5c4b6afc79073491acdab7f1e943ee3a19fbb] ASoC: rt722-sdca: Add so=
me missing readable registers
# good: [b5ec74c2aec76fbdff9bc16951455602e11902bf] arm64: dts: imx8mp-skov-=
reva: Use hardware signal for SD card VSELECT
# good: [c73be62caabbec6629689c705aea65e5ce364d5d] Revert "regulator: pca94=
50: Add SD_VSEL GPIO for LDO5"
# good: [9b32c86e40da792544c53076f5ec43f115e56687] spi: zynqmp-gqspi: Clean=
 up fillgenfifo
# good: [d61009bd578ee7381a3cce5c506190ecb8f9d6e8] spi: zynqmp-gqspi: Refor=
mat long line
# good: [7ed1b265021dd13ce5619501b388e489ddc8e204] ASoC: cpcap: Implement j=
ack detection
# good: [c1ac98492d1584d31f335d233a5cd7a4d4116e5a] spi: realtek-rtl-snand: =
Drop unneeded assignment for cache_type
# good: [5a6a461079decea452fdcae955bccecf92e07e97] regulator: ad5398: Add d=
evice tree support
# good: [d2ead60d853189f8e5ec6b301fac1e60e0b4b47d] spi: zynqmp-gqspi: Add h=
elpers for enabling/disabling DMA
# good: [f5aab0438ef17f01c5ecd25e61ae6a03f82a4586] regulator: pca9450: Fix =
enable register for LDO5
# good: [19d022d67d7353f0e6e9ba255435d3de93862ac4] regulator: ad5398: chang=
e enable bit name to improve readibility
# good: [02d4a97ce30c0494ce6a614cd54d583caa0f8016] dt-bindings: mfd: motoro=
la-cpcap: Document audio-codec interrupts
# good: [3ce6f4f943ddd9edc03e450a2a0d89cb025b165b] regulator: pca9450: Fix =
control register for LDO5
# good: [89785306453ce6d949e783f6936821a0b7649ee2] spi: zynqmp-gqspi: Alway=
s acknowledge interrupts
# good: [f9cbf56b0a1966d977df87d15a5bdbff2c342062] dt-bindings: regulator: =
pca9450: Add properties for handling LDO5
# good: [5b4288792ff246cf2bda0c81cebcc02d1f631ca3] ASoC: cpcap: Implement .=
set_bias_level
# good: [995cf0e014b0144edf1125668a97c252c5ab775e] regmap: Reorder 'struct =
regmap'
# good: [ba54629287f58b22c1d37f80f1875373e4b51ea6] spi: zynqmp-gqspi: Add s=
ome more debug prints
# good: [aefadf03b3e319fe5c406a6e41a9eecd90ac423c] ipe: policy_fs: fix kern=
el-doc warnings
# good: [3566784817aeb1a733c95953998a29adc386d2ff] drm/i915/display: Update=
 DBUF_TRACKER_STATE_SERVICE only on appropriate platforms
# good: [589c30de062eb4029f84ba4064209b4db153ac95] Merge branch 'for-6.14/i=
ntel-thc' into for-next
# good: [9fbf78b6d6cecc2e9833c2f74eb2edc027c9b4cb] Merge branch 'for-6.12/t=
rivial' into for-next
# good: [5dcf8655cc80a48065ba0a224e794106c147c14b] Merge branch 'for-6.11/t=
rivial' into for-next
# good: [7e17e80c3a7eb2734795f66ba946f933412d597f] Merge branch 'for-6.14/s=
tack-order' into for-next
# good: [9871e6af43db3892811f5a4ed0ed2e2d7cf6cf3c] Merge branch 'for-6.11/s=
ysfs-patch-replace' into for-next
git bisect start '8936cec5cb6e27649b86fabf383d7ce4113bba49' '67961d4f4e34f5=
ed1aeebab08f42c2e706837ec5' 'd1a09c610027e446ed30c21f61c2f2443bf92a3f' 'a78=
f244a9150da0878a37a1b59fb0608b1ccfb9d' 'b20be2c77ce5341ded1a2d8aec119f6dca8=
ef1ad' '5d9fca12f54d3e25e02521aa8f3ec5d53759b334' '3f02dedf1566858736f351a8=
d4a3ce91375e48f1' '0770b7cc095e015af302f0758d3d85c7f17c719a' 'e0f421d73053e=
aeb441aa77054b75992705656c7' '5c7e4c4da8586d2ef55a11a9f4df626b8ea9a146' '78=
3db6851c1821d8b983ffb12b99c279ff64f2ee' '9f25b6f2568d50c247a8e3b031a0a5caee=
8c17d2' '9dc016eaba3a70febcd1db5f1a0beeb7430166aa' 'e08fe24c34d37d00e84009f=
2fb4c35f5978041e6' '1c3b5f37409682184669457a5bdf761268eafbe5' 'f37f1748564a=
c51d32f7588bd7bfc99913ccab8e' '7e1caa679686dde5c24d60b139f234568045758f' 'd=
64c4c3d1c578f98d70db1c5e2535b47adce9d07' '40b1f89a1691c4b7740bec2c868f1e4c6=
0346353' '42da18e62652b58ba5ecd1524c146b202cda9bb7' '3aebbcba4baaa81bc8c83f=
2229ed8e774cf40618' '1248d29464cc682c2a1793cfc5d4ebeb374c6738' '7f1186a8d73=
8661b941b298fd6d1d5725ed71428' '238c863eb3d3c6ed58493bacfd1f4b36bdcfa92f' '=
0c4a06395156d16ea33e959fccea84e4cfec04c4' '08a66f55f7246d477b19620a953476df=
c02beefc' '257a060fe219bb0dcb98f12ce34f04eca6d08352' '11c1967f1a796bf2ff56a=
7118147f1d39d9f5ee0' '994719ed6d81a6f4677875ab6730254c0bc484ea' 'ae575d2145=
d1a2c8bb5d2835d7d54751f3b0bace' '828c0aa63706410503526d0ee522b9ac3232c86b' =
'74e0fcbd705d4277267311f8f26a00bb8ce93820' 'f22ba3561daa792dd138ed543e0bf48=
efe0b999c' 'ad0fbcebb5f6e093d433a0873758a2778d747eb8' 'c6bb909b8f11b9403715=
a325b51c2bcf01e2bbc0' 'e957c96455e8f4c630d5e374312cad0633ca7e17' 'd795a052b=
0ddad3da83dda6ff522c1b1aaa4a525' '91931af18bd22437e08e2471f5484d6fbdd8ab93'=
 'ff4d4158ef9143327a42f7be4298751cb0d1be69' 'fcd7ace9a725ae034ff9f24cb94c9f=
e12a1f02da' '21aa330fec31bb530a4ef6c9555fb157d0711112' 'e97d06cb4386af4e069=
a2dc713de70500538d0bd' 'ad1212a9cc24b740b2711014933fac6ace32aa2d' 'd1541caa=
b053cf94b114582a23b51a8cb90f4a46' 'f46eb2bfb878ce3345725252f77fa3ba36a0f087=
' 'c5528214c7c0a753c908a7b353309ba665985fb4' '2c17e9ea0caa5555e31e154fa1b06=
260b816f5cc' '3c331bdeececb629669961a80c0f929301c088d2' '93354d866ac44d0f9d=
65b2e4adb5cc9a1c1912c9' '330cbb40bb3664a18a19760bd6dc6003d6624041' '2f95230=
91a97abf8584a79ed406fd8ffe9063ec0' '651e0ed391b148f83afba0bfbd8a56e38e58c34=
d' '005859a2cf7aa349fbbfe433ab1769b15c535b72' '563e40153a56cbfae8721f959102=
2df5d930f939' '700a281905f2a4ccf6f3b2d3cd6985e034b4b021' '629dd55cf77bd3a8f=
80049150d3c05fef6d3b468' 'd7231be4b4657e5f922a4c6dc11e8dffc71fee87' 'd92090=
8fe36c2b3a1c6fe444831e0c8c2a995fd1' '07e3e514dd385300bd08da4a8df09240d27282=
1e' '645753d01356ff1a756812f1c69c53eb5c9081cd' 'f98d42000216677d177384f202f=
f1cc896a7395f' '5a19e1985d014fab9892348f6175a19143cec810' '896530b7b0c08ee8=
b3296d5f012bfe1b0a979b86' '19f6748abbab8523a7b32a5e371e39d4d8d4aba5' '9ee6d=
50ae4b0fe14ed70a5265a05874d41e10848' 'f87c2a275033120e15213f3d65234d98e726c=
4b7' 'ebb398ae1e052c4245b7bcea679fe073111db2ce' '8e02d188698851436f76038ea9=
98b726193d1b10' '5c93b20f6de4478e1fbcfb38eb46738bca74180e' '42b144cb6a2d873=
85fa0b124c975d6cf1e3ec630' 'e1101373df5cd7672d988bb4e9cdd5eb97003165' 'e80b=
8e5c53c30df1cba45258d10b04872b7eea67' '9da195880f167ab7c2d595388decf783c992=
0121' '83f37ba7b76ab17e029ab4127ec64ccccce64c00' '45e02edd8422b6c4a511f3840=
3dbd805cd139733' '6cf5df1040ba0694aea6a5edc6f31811a442ea36' '64fb5af1d1bbcf=
1b808e9bb092b22fa1b691ae63' '996bf834d0b61cb5a1389356c1ed7db1230139d7' 'd02=
52b0b945ec67fd09fc764dcadf445fb7757ee' '187150671d83324f1ca56f7ab5e00f16a3b=
9f2a9' 'fcb754602724fa2a1d0db72f13ddc3ef0306f911' '43d6140cedad9f031b47dfde=
6f85856e007b3f04' '31e3100d5e1fe69f944f84867be0cbfa5fd380c8' '491628388005a=
26c02d6827e649284357daec213' '1c35755f46423150e19ff57448786b4bb48fdb46' '0b=
6914a0121b4c9fc8f575b60a5dd43b74612908' '0eb8f83c055cb3461734710d1b1ce2dd4f=
01806e' '852c0b7204ded184924c41ab99b2ac7a70ad4dab' '3898b189079c85735f57759=
b0d407518c01c745e' 'c878d5c1a525b88807d9d79888fe8340bcbf1aa3' '4b36a47e2d98=
9b98953dbfb1e97da0f0169f5086' 'fde277dbcf53be685d0b9976d636366c80a74da8' '9=
1f505dc3a94c04421a2a51e8c40acf7ea67ecbc' '552f66c40134542f15d4302837e7d581a=
0b8e217' '638ad2bdb2f994c8bd99cc40e0c4796a8617ccf3' '4bb5b6f13fd83b32c8a93f=
bd399e7558415d1ce0' 'e2ceac2f323625632f12dd5333092976298a0cde' '0fa0843db17=
ccd427fc7a23d313aafa88fc89e04' '7c0ea26c57b0bb72d503fe27d6533f5addc5e3a3' '=
f1e91acacf86fb2cd7478af490326cb9aa63e8ae' '0a27b2d7a224326fab543ca586d501fe=
1857b655' '6547577e94ae3d9f8ff30d3267fe7ec394e3b20d' '605aab3b3ca83f5868184=
1b2dd16d4a7baefde6c' '4516be370ced14c4fb454fd6cc016e47bffe109e' 'db746fff89=
a14419379226ce0df8b94f472cf38c' 'a23ff143804d3b8c27157ffa19e48b4e22939115' =
'f0703ce627a25b4a1307d8a92cfd6d6bf7e27e7a' '5585e342e8d38cc598279bdb87f235f=
8b954dd5a' 'f2d161e5804d8da070988624b9edd179ef31b478' '6b8f162bd3fa82c3c1b3=
653100d04172c1dbd8a5' '46ab7d80ed4f378e02cb249bd49a76026a2d683f' 'cb161c333=
927142818d6bf22a4da2b023fb2b8c9' '96dd187c93afe0ae0535276a92ed488759ace5a2'=
 '153dbf4adad0082d030c30d20541df2b1af52db6' '861e232e15c278d6cfc5a675efe393=
b4838b1773' '5ea46b4360791345bd0bf4c7bf8fff5151374ea1' '0e9a970d7b2cb98d741=
bc0e32ad8c8f30c009c63' '0a7c85b516830c0bb088b0bdb2f2c50c76fc531a' '315c2f0b=
53ba2645062627443a12cea73f3dad9c' '2466b62268c020606d20b45e007c166399e639ee=
' '583348bd65ceaf4a5067a6267dd236929e1b4b37' 'ecfcee245cc99def0f6bf84ac75ac=
372f8ab65eb' 'a0ef5b4b101424b8a666ed56bf1717dafe2d37f5' '4c7518062d638837ce=
a915e0ffe30f846780639a' '3f78762d17701f0435ad958b2821dc3243ff34b3' '9bbbf33=
a5ab84c0f3643f43350b0f473b60af5b8' '062b7ef6b103dcbcb3c084e8ace8e74e260b234=
6' 'c06c4f7cbea1d8dc71485bfddef2849a1b721e67' '943116ba2a6ab472e8ad2d1e57a3=
f10f13485cc2' '7796c97df6b1b2206681a07f3c80f6023a6593d5' '78e66dd5f32a1a8e5=
ee6decadd4e4dffa7d2c40d' '61eac5f7f6439e8fe99b5fb29406acb0fd7b83c6' '860693=
187c597645b28a421d8acb26428b8afd3f' '2d7395b23dbf4c2d60be49b73e4c4705fc4466=
62' 'be61cd4242e4a53f5cf989ee7573121d041444bc' '72826381215e2f9d2bd2f32f63f=
76a80942b7fdf' '4d2ea16576c8aa1437048cf436bff85653f139fe' '169ec0a541aac8af=
b215ab591b0fd53276686014' '74a0ca4c7f19f1b273d665b3b53f7ae8af879658' '8d832=
82e53185ec257a4ce08812e8fabee2c7212' '43ca2463df9de2c192b03a0f4dc964e6ba7d7=
993' 'b3d993c7566fed1c027c5c18f3ef482ba8e6307a' '215705db51eb23052c73126d2e=
fb6acbc2db0424' 'c108905a7423d44237d17374f845fc5bb9cb9728' '185ac20a7b055e0=
25027d303b63dab456b4f5d5e' '3f75771987f32a9f512c8944e70e343f8c6d71c1' '6603=
c5133daadbb3277fbd93be0d0d5b8ec928e8' '678681828bf4abfd3c31f36390d209768214=
1d11' '25fac20edd09b60651eabcc57c187b1277f43d08' '991d98f17d31644826977e494=
77544987000a08a' '78d9ee370ed33cd8b662981fe1f47cff7b4f0e43' 'e27c125040b1e1=
f26d910b46daabbe55e67fdf3b' 'c2a756660324fceca26780a50950e6d91dfdc210' '847=
8dadc8148af311c3d43d4867cfb6632686ede' 'e3cd85963a20d2b92e77046a8d9f0777815=
f1f71' '652ffad172d089acb1a20e5fde1b66e687832b06' 'b2f10aa2eb18d289e48097e0=
ed973e714322175b' 'fb6ec1d27608c008bfe1ab0dfec3720990eb2451' '1a4a5a752fcd6=
0797ed2cb7c06253c6433d13f63' 'e92f042642aed6f6206caace892d9df2d0166841' '4a=
91fe4c0d683c56044579fb263c660f5d18efac' '79ebb596201c86712fe38b0ef73d25d07b=
932664' 'f0173cbe7fa79eafbdf32eed32337209f84ddacd' 'cbe37a4d2b3c25d2e2a9409=
7e09b6d87461b8833' '320155a61f7fc810a915644e9e2a451bdcea90b1' 'e995c5190338=
4be1c7aead246dc30cb5244179ac' '7d92a38d67e5d937b64b20aa4fd14451ee1772f3' '6=
eab7034579917f207ca6d8e3f4e11e85e0ab7d5' '856366dc924a9561dae39f252b45dfd6c=
c6895ce' '3c32a4386909e8023b3c49253fec33d267be16bb' '299ce4beaf714abe76e3ad=
106f2e745748f693e9' 'a05143a8f713d9ae6abc41141dac52c66fca8b06' '26a756fc10f=
ac6f133ef47f12362a39769dfe24d' 'dc561ab16d8be9cbe8f07a49a7b2f5428fbcfeea' '=
c9e9aa80022c6db71bc097a621a6145f39aa0ade' 'b9fb91692af881736f8fa1741fa0dbad=
f07d99ee' '4343af66b8e1df1d3a2e6f1f8612506cb45b2afd' 'f9a5c4b6afc79073491ac=
dab7f1e943ee3a19fbb' 'b5ec74c2aec76fbdff9bc16951455602e11902bf' 'c73be62caa=
bbec6629689c705aea65e5ce364d5d' '9b32c86e40da792544c53076f5ec43f115e56687' =
'd61009bd578ee7381a3cce5c506190ecb8f9d6e8' '7ed1b265021dd13ce5619501b388e48=
9ddc8e204' 'c1ac98492d1584d31f335d233a5cd7a4d4116e5a' '5a6a461079decea452fd=
cae955bccecf92e07e97' 'd2ead60d853189f8e5ec6b301fac1e60e0b4b47d' 'f5aab0438=
ef17f01c5ecd25e61ae6a03f82a4586' '19d022d67d7353f0e6e9ba255435d3de93862ac4'=
 '02d4a97ce30c0494ce6a614cd54d583caa0f8016' '3ce6f4f943ddd9edc03e450a2a0d89=
cb025b165b' '89785306453ce6d949e783f6936821a0b7649ee2' 'f9cbf56b0a1966d977d=
f87d15a5bdbff2c342062' '5b4288792ff246cf2bda0c81cebcc02d1f631ca3' '995cf0e0=
14b0144edf1125668a97c252c5ab775e' 'ba54629287f58b22c1d37f80f1875373e4b51ea6=
' 'aefadf03b3e319fe5c406a6e41a9eecd90ac423c' '3566784817aeb1a733c95953998a2=
9adc386d2ff' '589c30de062eb4029f84ba4064209b4db153ac95' '9fbf78b6d6cecc2e98=
33c2f74eb2edc027c9b4cb' '5dcf8655cc80a48065ba0a224e794106c147c14b' '7e17e80=
c3a7eb2734795f66ba946f933412d597f' '9871e6af43db3892811f5a4ed0ed2e2d7cf6cf3=
c'
# bad: [8936cec5cb6e27649b86fabf383d7ce4113bba49] Add linux-next specific f=
iles for 20250219
git bisect bad 8936cec5cb6e27649b86fabf383d7ce4113bba49
# good: [4aa591507214c82976992e1810d5ac121a8545d2] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
git bisect good 4aa591507214c82976992e1810d5ac121a8545d2
# good: [38f28c2c14f7b6a204097792474f3f3fe8f87cd4] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
git bisect good 38f28c2c14f7b6a204097792474f3f3fe8f87cd4
# bad: [f300530bbb82416019ae01536ad40532d574bff0] Merge branch 'next' of ht=
tps://github.com/kvm-x86/linux.git
git bisect bad f300530bbb82416019ae01536ad40532d574bff0
# bad: [5e8357bc3db2c901b02c62cfe7ff29831865440a] Merge branch into tip/mas=
ter: 'x86/misc'
git bisect bad 5e8357bc3db2c901b02c62cfe7ff29831865440a
# good: [ce68de08a2cc95dc2cb6018a22673beed52f25c3] ASoC: fsl: imx-pcm-fiq: =
Switch to use hrtimer_setup()
git bisect good ce68de08a2cc95dc2cb6018a22673beed52f25c3
# bad: [4e3434bf99d811d00ece73028c77d6a81779557f] Merge branch into tip/mas=
ter: 'timers/core'
git bisect bad 4e3434bf99d811d00ece73028c77d6a81779557f
# bad: [96bda1071c815489bd6678eb38670c4fec7e37ce] Merge branch into tip/mas=
ter: 'irq/drivers'
git bisect bad 96bda1071c815489bd6678eb38670c4fec7e37ce
# good: [999f458c1771354371ba367dd84f55f9a62a4233] irqchip/riscv-imsic: Set=
 irq_set_affinity() for IMSIC base
git bisect good 999f458c1771354371ba367dd84f55f9a62a4233
# bad: [213ea5f92da586fe137dfa55004ed0f7706cfae5] RISC-V: Select CONFIG_GEN=
ERIC_PENDING_IRQ
git bisect bad 213ea5f92da586fe137dfa55004ed0f7706cfae5
# bad: [44b70d9abe4c83a04804975f50fdf7c5594cb443] irqchip/riscv-imsic: Move=
 to common MSI library
git bisect bad 44b70d9abe4c83a04804975f50fdf7c5594cb443
# bad: [1eb4e8fdac707e9e7766c6e1cd1f7cbaaee4eac4] irqchip/irq-msi-lib: Opti=
onally set default irq_eoi()/irq_ack()
git bisect bad 1eb4e8fdac707e9e7766c6e1cd1f7cbaaee4eac4
# first bad commit: [1eb4e8fdac707e9e7766c6e1cd1f7cbaaee4eac4] irqchip/irq-=
msi-lib: Optionally set default irq_eoi()/irq_ack()

--mBaqZzvs8jn0KJbF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme17aIACgkQJNaLcl1U
h9D9Rgf+ISnh//EHBVBVENpG3G9t4URP1f2kkhIt1yGNuCSxCU2yysQRb+Sz/MZ+
61cjCHjraP7n4ofse9YjLSYv16y4JHgMa+48LvJ8jyOAJrau+bIYjr6VXcklFIwm
bLPGSXIu3FfRAIqiyKoZ5aeOJqTACoGryk7jA3Vm/S2rQGVK7GBm9AVlX1XmQRA8
7fq0cvUo9tiypjBtzlQqaKxgUnx+naOg9FbIzgWYhJFUmjzRzO843bI15xz31Pa6
3JK7HAIojKJgCxLoBkUBP0Rajc+FWLza5BYzWyPLnA/U37m/VcIf4pYbE4Fbiacm
fwT8xwz8DxQ+CZvHknFAmH/fZiqMvA==
=6Z+4
-----END PGP SIGNATURE-----

--mBaqZzvs8jn0KJbF--

