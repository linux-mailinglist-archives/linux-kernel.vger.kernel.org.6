Return-Path: <linux-kernel+bounces-543966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8609A4DBF3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364643B1E6B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6866B20011E;
	Tue,  4 Mar 2025 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wdwDPQ5J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MUzrvEzP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wdwDPQ5J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MUzrvEzP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247631FF601
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086549; cv=none; b=YCk9mJCQXkccf6jRBlsiP9pl4aLIHTLoGZTdEwkVH5hOPJ7TAKOTeLU2USK6qR1vtexkUmkgpJqqTlF35ew9lmunjmx2sRkxdXijfDHK4/OAkobI1tp5vKOSgz7eQzACPy1V8+gsPllToLf1qQTyyCtvHtRWgAnFnShY+Cycwfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086549; c=relaxed/simple;
	bh=u0YmdJFlgr6Ci4zwZEY7A4+gyfwZZMpZ49LowVF7sWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwF+jvqXQQJBwpbmpoSy8bvcpw5DZfKjFe1dRZ8Ouhtmo85CbUmd5B4iaKqxArALpRSH+dfTdzj8fKMmej3zEgv/xa0CXmlhJGZvKEVNTzP9jmXzWJew2j+xjZN5E7q+SMJJsDmgbHIBVUGuK5cFHt9AmmxDaeIfEIw+iR7LVno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wdwDPQ5J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MUzrvEzP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wdwDPQ5J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MUzrvEzP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 58F731F74D;
	Tue,  4 Mar 2025 11:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741086545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+fxtDaCqIKsV3/+j7+mbgqDngXaphwg7nZVJK1S25Y=;
	b=wdwDPQ5JW3v6aP23c0Qc7mf9sHv06uXuwAvObmCFRx+XNMUn4SNGdQyUBjNY4KkTlMa1VX
	o6roVTvCwxek25YNVYLHd1FaKCZsVl9lPIro57lz/HFWkr9FPhkqsQ5Qn4hMPlQcBe0W/L
	GHvAhscu1yPo+IpKC7jXJpySzek8nyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741086545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+fxtDaCqIKsV3/+j7+mbgqDngXaphwg7nZVJK1S25Y=;
	b=MUzrvEzP6KOiJdBfdKfbDY1afQgc6OxZ1PwrgIo8wnFfhWj2V6Cc8zhSEcALBzV7oNbrb+
	5xisIk3apOtPgQDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741086545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+fxtDaCqIKsV3/+j7+mbgqDngXaphwg7nZVJK1S25Y=;
	b=wdwDPQ5JW3v6aP23c0Qc7mf9sHv06uXuwAvObmCFRx+XNMUn4SNGdQyUBjNY4KkTlMa1VX
	o6roVTvCwxek25YNVYLHd1FaKCZsVl9lPIro57lz/HFWkr9FPhkqsQ5Qn4hMPlQcBe0W/L
	GHvAhscu1yPo+IpKC7jXJpySzek8nyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741086545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+fxtDaCqIKsV3/+j7+mbgqDngXaphwg7nZVJK1S25Y=;
	b=MUzrvEzP6KOiJdBfdKfbDY1afQgc6OxZ1PwrgIo8wnFfhWj2V6Cc8zhSEcALBzV7oNbrb+
	5xisIk3apOtPgQDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37CA913967;
	Tue,  4 Mar 2025 11:09:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YX+UDVHfxmdIbwAAD6G6ig
	(envelope-from <iivanov@suse.de>); Tue, 04 Mar 2025 11:09:05 +0000
Date: Tue, 4 Mar 2025 13:09:04 +0200
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v12 1/5] Documentation/firmware: add imx/se to
 other_interfaces
Message-ID: <20250304110904.qr5rtsvkqa3l64t4@localhost.localdomain>
References: <20250120-imx-se-if-v12-0-c5ec9754570c@nxp.com>
 <20250120-imx-se-if-v12-1-c5ec9754570c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250120-imx-se-if-v12-1-c5ec9754570c@nxp.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lwn.net,kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,imap1.dmz-prg2.suse.org:helo,i.mx:url]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Hi,

On 01-20 22:22, Pankaj Gupta wrote:
>=20
> Documents i.MX SoC's Service layer and C_DEV driver for selected SoC(s)
> that contains the NXP hardware IP(s) for Secure Enclaves(se) like:
> - NXP EdgeLock Enclave on i.MX93 & i.MX8ULP
>=20
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  .../driver-api/firmware/other_interfaces.rst       | 121 +++++++++++++++=
++++++
>  1 file changed, 121 insertions(+)
>=20

<snip>

> +
> +- c_dev:
> +  This layer offers character device contexts, created as '/dev/<se>_mux=
_chx'.
> +  Using these multiple device contexts that are getting multiplexed over=
 a single MU,
> +  userspace application(s) can call fops like write/read to send the com=
mand message,
> +  and read back the command response message to/from Firmware.
> +  fops like read & write use the above defined service layer API(s) to c=
ommunicate with
> +  Firmware.
> +
> +  Misc-device(/dev/<se>_mux_chn) synchronization protocol:
> +
> +                                Non-Secure               +   Secure
> +                                                         |
> +                                                         |
> +                  +---------+      +-------------+       |
> +                  | se_fw.c +<---->+imx-mailbox.c|       |
> +                  |         |      |  mailbox.c  +<-->+------+    +-----=
-+
> +                  +---+-----+      +-------------+    | MU X +<-->+ ELE |
> +                      |                               +------+    +-----=
-+
> +                      +----------------+                 |
> +                      |                |                 |
> +                      v                v                 |
> +                  logical           logical              |
> +                  receiver          waiter               |
> +                     +                 +                 |
> +                     |                 |                 |
> +                     |                 |                 |
> +                     |            +----+------+          |
> +                     |            |           |          |
> +                     |            |           |          |
> +              device_ctx     device_ctx     device_ctx   |
> +                                                         |
> +                User 0        User 1       User Y        |
> +                +------+      +------+     +------+      |
> +                |misc.c|      |misc.c|     |misc.c|      |
> + kernel space   +------+      +------+     +------+      |
> +                                                         |
> + +------------------------------------------------------ |
> +                    |             |           |          |
> + userspace     /dev/ele_muXch0    |           |          |
> +                          /dev/ele_muXch1     |          |
> +                                        /dev/ele_muXchY  |
> +                                                         |

I tried these patches on FRDM i.MX 93 board using this
devicetree excerpt:

	ele_if0: secure-enclave {
		compatible =3D "fsl,imx93-se";
		mbox-names =3D "tx", "rx";
		mboxes =3D <&s4muap 0 0>,
			<&s4muap 1 0>;
		memory-region =3D <&ele_reserved>;
	};

	ele_reserved: ele-reserved@a4120000 {
		compatible =3D "shared-dma-pool";
		reg =3D <0 0xa4120000 0 0x100000>;
		no-map;
	};

Unfortunately I do not see these device nodes, but only /dev/hsm0_ch0.

=2E..
fsl-se secure-enclave: i.MX secure-enclave: hsm0 interface to firmware, con=
figured.
=2E..

This matches SE_TYPE_STR_HSM, so perhaps documentation needs updating.

Then I build imx-secure-enclave user space tools. I have to update device
nodes ELE_MU_HSM_PATH_xxx to match what c_dev exports, hopefully I
patched it in the right place :-)

Unfortunately just starting  nvm_daemon gives me following kernel
crash [1].

Please could you point me to the proper instruction how to test this?

Thank you,
Ivan

---
# ./usr/bin/nvm_daemon  ./etc/file ./etc/ 0

[  597.387002][    C0] Unable to handle kernel NULL pointer dereference at =
virtual address 0000000000000010
[  597.396866][    C0] Mem abort info:
[  597.400347][    C0]   ESR =3D 0x0000000096000006
[  597.404775][    C0]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  597.410764][    C0]   SET =3D 0, FnV =3D 0
[  597.414499][    C0]   EA =3D 0, S1PTW =3D 0
[  597.418321][    C0]   FSC =3D 0x06: level 2 translation fault
[  597.423877][    C0] Data abort info:
[  597.427438][    C0]   ISV =3D 0, ISS =3D 0x00000006, ISS2 =3D 0x00000000
[  597.433600][    C0]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[  597.439329][    C0]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[  597.445318][    C0] user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000a=
04ac000
[  597.452433][    C0] [0000000000000010] pgd=3D08000000a04b0003, p4d=3D080=
00000a04b0003, pud=3D08000000a04b3003, pmd=3D0000000000000000
[  597.463728][    C0] Internal error: Oops: 0000000096000006 [#1] SMP
[  597.469985][    C0] Modules linked in: af_packet trusted caam_jr caamhas=
h_desc caamalg_desc caam error crypto_engine asn1_encoder authenc libdes bt=
nxpuart snd_soc_fsl_asoc_card snd_soc_imx_audmux snd_soc_simple_card_utils =
snd_ac97_codec snd_soc_fsl_sai bluetooth fsl_imx9_ddr_perf imx_pcm_dma snd_=
soc_fsl_utils qoriq_thermal ecdh_generic rfkill snd_soc_fsl_mqs flexcan snd=
_soc_core snd_compress can_dev optee sec_enclave(OE) imx_rproc ac97_bus ffa=
_core snd_pcm_dmaengine tee snd_pcm snd_timer snd soundcore nls_iso8859_1 n=
ls_cp437 vfat fat uio_pdrv_genirq fuse dmi_sysfs ip_tables x_tables spidev =
mmc_block rpmb_core tcpci tcpm typec rtc_pcf2127 crct10dif_ce pca9450_regul=
ator ci_hdrc_imx 8021q ci_hdrc ghash_ce usb_otg_fsm garp gf128mul ulpi mrp =
sm4 sha2_ce udc_core sha256_arm64 pwrseq_simple roles ehci_hcd sha1_ce dwma=
c_imx usbcore phy_generic gpio_keys usb_common nvmem_imx_ocotp_ele usbmisc_=
imx sdhci_esdhc_imx stmmac_platform sdhci_pltfm stmmac cqhci sdhci pwm_imx_=
tpm mmc_core pcs_xpcs i2c_imx_lpi2c phylink spi_fsl_lpspi imx7ulp_wdt
[  597.470224][    C0]  fsl_edma fixed overlay btrfs blake2b_generic xor xo=
r_neon raid6_pq libcrc32c sunrpc dm_mirror dm_region_hash dm_log dm_mod be2=
iscsi bnx2i cnic uio cxgb4i cxgb4 tls libcxgbi libcxgb qla4xxx iscsi_boot_s=
ysfs iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi sd_mod sg scsi_mo=
d scsi_common br_netfilter bridge stp llc efivarfs aes_neon_bs aes_neon_blk=
 aes_ce_blk aes_ce_cipher
[  597.595841][    C0] Supported: No, Unreleased kernel
[  597.600794][    C0] CPU: 0 UID: 0 PID: 1912 Comm: nvm_daemon Tainted: G =
          OE        6.12.0-g6dd51d0 #1  (unreleased) 1bbfa4b46f0796a1c0b0ab=
ee639edd3b3230f00f
[  597.617891][    C0] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
[  597.623877][    C0] Hardware name: fsl NXP i.MX93 11X11 FRDM board/NXP i=
=2EMX93 11X11 FRDM board, BIOS 2024.04-00004-g27baba14a58-dirty 04/01/2024
[  597.636801][    C0] pstate: 804000c9 (Nzcv daIF +PAN -UAO -TCO -DIT -SSB=
S BTYPE=3D--)
[  597.644443][    C0] pc : se_if_rx_callback+0xa8/0x1f0 [sec_enclave]
[  597.650709][    C0] lr : mbox_chan_received_data+0x24/0x40
[  597.656187][    C0] sp : ffff800080003e20
[  597.660182][    C0] x29: ffff800080003e20 x28: ffff000085e60080 x27: 000=
000000000001b
[  597.667999][    C0] x26: ffff0000e89f388c x25: 0000000000000004 x24: fff=
f0000996a4ac8
[  597.675816][    C0] x23: ffff0000a43e3810 x22: ffff0000996a4ac8 x21: fff=
f0000996a4a80
[  597.683634][    C0] x20: 000000000000000c x19: ffff0000e89f3880 x18: 000=
0000000000000
[  597.691451][    C0] x17: ffff80007d89b000 x16: ffff800080000000 x15: 000=
0000000000000
[  597.699268][    C0] x14: 0000000000000000 x13: 0000000000000000 x12: 000=
0000000000000
[  597.707086][    C0] x11: 0000000000000040 x10: ffff0000801fab30 x9 : fff=
f800080cbfbfc
[  597.714903][    C0] x8 : ffff000080400948 x7 : 0000000000000000 x6 : 000=
0000000000000
[  597.722720][    C0] x5 : 0000000000000008 x4 : 000000000000000c x3 : 000=
00000e1100307
[  597.730538][    C0] x2 : 0000000000000000 x1 : ffff80007bb5fb98 x0 : fff=
f0000a43e3810
[  597.738356][    C0] Call trace:
[  597.741485][    C0]  se_if_rx_callback+0xa8/0x1f0 [sec_enclave eaa590c7f=
5850e16202e831d5a0ef9bbd976ab91]
[  597.750957][    C0]  mbox_chan_received_data+0x24/0x40
[  597.756087][    C0]  imx_mu_specific_rx+0x1ec/0x280
[  597.760958][    C0]  imx_mu_isr+0x314/0x340
[  597.765135][    C0]  __handle_irq_event_percpu+0x58/0x240
[  597.770526][    C0]  handle_irq_event+0x54/0xd0
[  597.775041][    C0]  handle_fasteoi_irq+0xac/0x1e0
[  597.779825][    C0]  handle_irq_desc+0x48/0x70
[  597.784254][    C0]  generic_handle_domain_irq+0x24/0x40
[  597.789549][    C0]  gic_handle_irq+0x11c/0x260
[  597.794073][    C0]  call_on_irq_stack+0x24/0x30
[  597.798684][    C0]  do_interrupt_handler+0x88/0xa0
[  597.803554][    C0]  el1_interrupt+0x44/0xd0
[  597.807818][    C0]  el1h_64_irq_handler+0x18/0x30
[  597.812602][    C0]  el1h_64_irq+0x7c/0x80
[  597.816684][    C0]  _raw_spin_unlock_irq+0x14/0x70
[  597.821555][    C0]  wait_for_completion_interruptible+0x28/0x50
[  597.827544][    C0]  ele_msg_rcv+0xa0/0x100 [sec_enclave eaa590c7f5850e1=
6202e831d5a0ef9bbd976ab91]
[  597.836488][    C0]  se_if_fops_read+0xc8/0x1f0 [sec_enclave eaa590c7f58=
50e16202e831d5a0ef9bbd976ab91]
[  597.845779][    C0]  vfs_read+0xcc/0x320
[  597.849696][    C0]  ksys_read+0x78/0x120
[  597.853691][    C0]  __arm64_sys_read+0x24/0x40
[  597.858207][    C0]  invoke_syscall+0x70/0x100
[  597.862644][    C0]  el0_svc_common.constprop.0+0x48/0xf0
[  597.868034][    C0]  do_el0_svc+0x24/0x40
[  597.872038][    C0]  el0_svc+0x3c/0x170
[  597.875869][    C0]  el0t_64_sync_handler+0x120/0x130
[  597.880913][    C0]  el0t_64_sync+0x1a8/0x1b0
[  597.885258][    C0] Code: b9400263 2a1403e4 f0fffe61 912e6021 (f9400842)
[  597.892035][    C0] ---[ end trace 0000000000000000 ]---
[  597.897330][    C0] Kernel panic - not syncing: Oops: Fatal exception in=
 interrupt
[  597.904878][    C0] SMP: stopping secondary CPUs
[  597.909521][    C0] Kernel Offset: disabled
[  597.913691][    C0] CPU features: 0x0,0000000c,00000004,00280928,4201721b
[  597.920468][    C0] Memory Limit: none
[  597.924205][    C0] Rebooting in 90 seconds..


