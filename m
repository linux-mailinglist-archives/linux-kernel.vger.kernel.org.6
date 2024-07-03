Return-Path: <linux-kernel+bounces-238887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0AE9252C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA1C1C22D88
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972E73C684;
	Wed,  3 Jul 2024 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="HaJxDqud";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hh5dS5O8"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B182034CDD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 05:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719983267; cv=none; b=Nd7z9ANVvc5+DxmNLa7VsBo4rZRjoo/Scw5HK1bFiSdSqjvdxL1bW8ht0MgTCpL0xJdxzMcVXA8SuhPRhfHXhHALSgiXPj+5hMxjAZ4O64Dsb9EDa0IY3NTGBQXI/CsrtE8tvBp6rlT81YUkYruK7F8j/g0Z84VI4n44+JGRn4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719983267; c=relaxed/simple;
	bh=6MD/DRLdYQPovJzVd5/MvYLNcpmbtl4BuogSMuQPXHA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=i/V21FnrbUaai9/2xSDpAw6XXymgIvnmxjx0jGtxF2hawZUE9aEdeYRzKn5ivKvR5tZe7zIQP1Acmlqhx2E4dbtLzU2uMpLKlF3FgF0tjjZ9zrtubpJZmfRa+KvBRapKX2eHoRldt/KB9cqquC3GwnHtppdINzfgx7t3fNriI5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=HaJxDqud; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hh5dS5O8; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C2F021140184;
	Wed,  3 Jul 2024 01:07:44 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Wed, 03 Jul 2024 01:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1719983264;
	 x=1720069664; bh=zEgmw8gCyzGHEfnIbZbtI1k6cSxuGg4UDUHDyWAu3Ps=; b=
	HaJxDqudNr/T8caD5M0KSaDMX0H3lOUv0g0dNLEOo/mLyHB1JHSMraFtQ4GuA2+t
	SXULuj3VN3D/c5TKePIusHQEO3miNp/Z83OWZUy1/l7UQvsFANI4QegN/Iq41O5l
	F1jvtLM7E+BX0kKmmwXXiCQ+fZBQeU5fJpE0q89k7ZJOIlQM8Dkp2/DxaAwl5xgZ
	x4awCCPGwALEl1VRV3jUHd967c+rVPRig0H1LgsU60O+UB8zizVYf/NQRLb/Ugg1
	Ye5fuhua0z70x9pt67QKHCkHDKwRvVqxXUYl0KWkZP5Ded5PIZDoZFKZXRfbvWPC
	v960PtbyTHrRor9aXNJwag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719983264; x=
	1720069664; bh=zEgmw8gCyzGHEfnIbZbtI1k6cSxuGg4UDUHDyWAu3Ps=; b=H
	h5dS5O8kixKLLbwRCEEhLFBf8C0zCx8Tnn1SB4WRDZ1TpV83T0MiTm8HQY0GzCCm
	3njbiLIs2hxbVFAmKVzOqMULAhW36XpodoajG+LITvHeEU/HccUSbUM6Z80/F38p
	3P0zAEUJjtEE5gthCPZw/rnOEj86N9oxBobySYCBDt2NcMCNJMmd2Ekwv99y+idp
	W5hvzwTdWi9JE12GdJqLUV9yVi2wFXYGQRoIs2oRXXu+5ZkamLu/SIOR8KKKhGCH
	WIfqVBWpOvpXhx2+zFiMKO51ZBqKx+Gr/s2aynoNAllrYXDnmOL3nmVsyRUuaz5p
	nx0qbMtDebYSZ0jZthS9g==
X-ME-Sender: <xms:ntyEZqRMMvpvsBvito3QueMEZFoeoX_WitziIws06yN_pqtIpXjZ_w>
    <xme:ntyEZvwVbN-wKbPmK34H762i4q-G9gkTXA47kOrUZuWXX3LQ2mKowvb7owYbEAh_d
    fkkzyEJYuDDU96Z3hM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeigdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
    geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:ntyEZn0cdgC4pM3btS0_ERSWN9MO5iHCf6ElMTHi9OxclZl2gF-7PA>
    <xmx:ntyEZmDbAT4PztRfg4ADGSWi9MVe9BBva-NGN_n-5f4wnvSCMBQT_g>
    <xmx:ntyEZjhspsoTFevQZ3dOmED1qBgAbe9JmsdaLr62KJm6bjsBNsWpMA>
    <xmx:ntyEZioAnaJX_GM6PSyszOvboj-ge3gwvSNQ-CryR_gCFbq1RftrnQ>
    <xmx:oNyEZjgXN_tr-7ocoFv0LjdXQ4bd76DcebGWJzVogpc7ygjryeNG8V1O>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AC5D336A0074; Wed,  3 Jul 2024 01:07:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a012763d-d1d4-4e70-b8fc-173b8a915af9@app.fastmail.com>
In-Reply-To: <20240702151415.1160566-1-chenhuacai@loongson.cn>
References: <20240702151415.1160566-1-chenhuacai@loongson.cn>
Date: Wed, 03 Jul 2024 13:07:20 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Huacai Chen" <chenhuacai@loongson.cn>,
 "Huacai Chen" <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, "Xuefeng Li" <lixuefeng@loongson.cn>,
 "Guo Ren" <guoren@kernel.org>, "Xuerui Wang" <kernel@xen0n.name>,
 linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] LoongArch: Use correct API to map cmdline in relocate_kernel()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B47=E6=9C=882=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=E5=
=8D=8811:14=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> fw_arg1 is in memory space rather than I/O space, so we should use
> early_memremap_ro() instead of early_ioremap() to map the cmdline.
> Moreover, we should unmap it after using.
>
> Suggested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks for correcting that.

> ---
>  arch/loongarch/kernel/relocate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/=
relocate.c
> index 1acfa704c8d0..0eddd4a66b87 100644
> --- a/arch/loongarch/kernel/relocate.c
> +++ b/arch/loongarch/kernel/relocate.c
> @@ -13,6 +13,7 @@
>  #include <asm/bootinfo.h>
>  #include <asm/early_ioremap.h>
>  #include <asm/inst.h>
> +#include <asm/io.h>
>  #include <asm/sections.h>
>  #include <asm/setup.h>
>=20
> @@ -170,7 +171,7 @@ unsigned long __init relocate_kernel(void)
>  	unsigned long kernel_length;
>  	unsigned long random_offset =3D 0;
>  	void *location_new =3D _text; /* Default to original kernel start */
> -	char *cmdline =3D early_ioremap(fw_arg1, COMMAND_LINE_SIZE); /* Boot=20
> command line is passed in fw_arg1 */
> +	char *cmdline =3D early_memremap_ro(fw_arg1, COMMAND_LINE_SIZE); /*=20
> Boot command line is passed in fw_arg1 */
>=20
>  	strscpy(boot_command_line, cmdline, COMMAND_LINE_SIZE);
>=20
> @@ -182,6 +183,7 @@ unsigned long __init relocate_kernel(void)
>  		random_offset =3D (unsigned long)location_new - (unsigned long)(_te=
xt);
>  #endif
>  	reloc_offset =3D (unsigned long)_text - VMLINUX_LOAD_ADDRESS;
> +	early_memunmap(cmdline, COMMAND_LINE_SIZE);
>=20
>  	if (random_offset) {
>  		kernel_length =3D (long)(_end) - (long)(_text);
> --=20
> 2.43.0

--=20
- Jiaxun

