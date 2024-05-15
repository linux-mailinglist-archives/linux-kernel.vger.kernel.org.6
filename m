Return-Path: <linux-kernel+bounces-179777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DA08C652C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550911C21D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4D65FBB2;
	Wed, 15 May 2024 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="OCTHiuq0"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964B45FB87
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715770327; cv=none; b=IV4dd7enuE3Q9nOoryTlXZeTghDpnyQKuRz72fJ5BBmg9iNc9j9PRBe/vtu4Pipefg24EdjZxASuz/jZ/dbACg/hPwN4LDeivP3jdtpKuO0GqnWtbBkknRizQ2yu48xEsHk1cSnLDXA8FwYcWMOgliezf0Wy7wNg6m4dLiJcF18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715770327; c=relaxed/simple;
	bh=Amxzkpd0XRX4qZOytRPaUSydb/KElzd8Fly+25Pwt8w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F1gMH1B/esPMcjPLHYJGIJ/EAWn6C+jOViDelZL+reMw/a1DzXnlScJWkcP41vbKR+RxixnVRk/34qELDAjFY6QTCRBE8YCdD4W6x18kU4/3me95MMhYcGSXm7qASpwtdpP5dEBRCRzeteY7gQINuuNaBCo1EJkKxu1FvkY47f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=OCTHiuq0; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1715769986;
	bh=Amxzkpd0XRX4qZOytRPaUSydb/KElzd8Fly+25Pwt8w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OCTHiuq0xcxXDzWFNb2YzidBdd/UCbfzGmEDoMNiByUGDHctOQz+x2vbobzPv095/
	 In1Ipl7jSdqwZ2ZYyDz4PDkyVFsC77QgxCXQ4G2/TAhJNyVAaw9FFyw37m6wqtXo28
	 CVMBsa76/VYUDfZIOiR32EXgvcv3C9D3SLd3MsYY=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 741E866433;
	Wed, 15 May 2024 06:46:09 -0400 (EDT)
Message-ID: <32e53b74f382f691fb8f60d68b093901964bd1c9.camel@xry111.site>
Subject: Re: [PATCH v9 1/2] x86/mm: Don't disable PCID if "incomplete Global
 INVLPG flushes" is fixed by microcode
From: Xi Ruoyao <xry111@xry111.site>
To: Dave Hansen <dave.hansen@linux.intel.com>, Michael Kelley
	 <mhklinux@outlook.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>,  Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin"
 <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Sean
 Christopherson <seanjc@google.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>
Date: Wed, 15 May 2024 18:46:04 +0800
In-Reply-To: <20240418205414.67735-1-xry111@xry111.site>
References: <20240418205414.67735-1-xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Linux 6.9 is released.  Is this suitable as 6.10 material or do I need
to update something?

On Fri, 2024-04-19 at 04:54 +0800, Xi Ruoyao wrote:
> Per the "Processor Specification Update" documentations referred by the
> intel-microcode-20240312 release note, this microcode release has fixed
> the issue for all affected models.
>=20
> So don't disable PCID if the microcode is new enough.=C2=A0 The precise
> minimum microcode revision fixing the issue is provided by engineer from
> Intel.
>=20
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Michael Kelley <mhklinux@outlook.com>
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306.t=
ip-bot2@tip-bot2/
> Link: https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files=
/releases/tag/microcode-20240312
> Link: https://cdrdv2.intel.com/v1/dl/getContent/740518=C2=A0# RPL042, rev=
 13
> Link: https://cdrdv2.intel.com/v1/dl/getContent/682436=C2=A0# ADL063, rev=
 24
> Link: https://lore.kernel.org/all/20240325231300.qrltbzf6twm43ftb@desk/
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
> =C2=A0arch/x86/mm/init.c | 34 ++++++++++++++++++++++------------
> =C2=A01 file changed, 22 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index 679893ea5e68..c318cdc35467 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -261,33 +261,43 @@ static void __init probe_page_size_mask(void)
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -#define INTEL_MATCH(_model) { .vendor=C2=A0 =3D X86_VENDOR_INTEL,	\
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .family=C2=A0 =3D 6,			\
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .model =3D _model,			\
> -			=C2=A0=C2=A0=C2=A0 }
> +#define INTEL_MATCH(_model, _fixed_microcode)	\
> +	{					\
> +	=C2=A0 .vendor	=3D X86_VENDOR_INTEL,	\
> +	=C2=A0 .family	=3D 6,			\
> +	=C2=A0 .model	=3D _model,		\
> +	=C2=A0 .driver_data	=3D _fixed_microcode,	\
> +	}
> +
> =C2=A0/*
> =C2=A0 * INVLPG may not properly flush Global entries
> - * on these CPUs when PCIDs are enabled.
> + * on these CPUs when PCIDs are enabled and the
> + * microcode is not updated to fix the issue.
> =C2=A0 */
> =C2=A0static const struct x86_cpu_id invlpg_miss_ids[] =3D {
> -	INTEL_MATCH(INTEL_FAM6_ALDERLAKE=C2=A0=C2=A0 ),
> -	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
> -	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT ),
> -	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE=C2=A0 ),
> -	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
> -	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
> +	INTEL_MATCH(INTEL_FAM6_ALDERLAKE,	0x2e),
> +	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L,	0x42c),
> +	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT,	0x11),
> +	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE,	0x118),
> +	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P,	0x4117),
> +	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S,	0x2e),
> =C2=A0	{}
> =C2=A0};
> =C2=A0
> =C2=A0static void setup_pcid(void)
> =C2=A0{
> +	const struct x86_cpu_id *invlpg_miss_match;
> +
> =C2=A0	if (!IS_ENABLED(CONFIG_X86_64))
> =C2=A0		return;
> =C2=A0
> =C2=A0	if (!boot_cpu_has(X86_FEATURE_PCID))
> =C2=A0		return;
> =C2=A0
> -	if (x86_match_cpu(invlpg_miss_ids)) {
> +	invlpg_miss_match =3D x86_match_cpu(invlpg_miss_ids);
> +
> +	if (invlpg_miss_match &&
> +	=C2=A0=C2=A0=C2=A0 boot_cpu_data.microcode < invlpg_miss_match->driver_=
data) {
> =C2=A0		pr_info("Incomplete global flushes, disabling PCID");
> =C2=A0		setup_clear_cpu_cap(X86_FEATURE_PCID);
> =C2=A0		return;

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

