Return-Path: <linux-kernel+bounces-230802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D103F918209
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EBA5286BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07DE522A;
	Wed, 26 Jun 2024 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="aedsXHku"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AF118F2C5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407412; cv=none; b=FF4Yr4NR5GLU87y6PSLCuMvX8W4nBi0AQVhbTGz7bLjPlIgpOlOgSZGkGLcFm21j58ZfYFKAII4zOgh70k8x8iRq54ZNLa0cuPQJ52SnGc9UOxGtO/yEjRCH7pMXymRnXRSdot/m4oK9+flUbv8LQ0kbzwNTM1gHcG2x+mZDSR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407412; c=relaxed/simple;
	bh=uI7uICh3QWYQ3PoeaRNCqqwcXlPwlqJh/NEA/nWP9do=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZqvAtPzkfahLZsGBhzxJS+5aFfz/yLaBdTGrw6lkK6YdoxptzmxZds2eJ/s3LAaOhbyORmZY8s3LqaeA8mpe0+z0jBJJkBfb8IrDwS77DTxpfIPh7nRCJMeAJHsIHHkJbKhS+j412Oxk3JM8Njb5rFyTmGOuSJvUTpdvHY6DIog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=aedsXHku; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1719407406;
	bh=uI7uICh3QWYQ3PoeaRNCqqwcXlPwlqJh/NEA/nWP9do=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=aedsXHkuASzFpY4i6ioxEzGJ7nTaJz4zBH5USamhk/PaFjZB9bvFI6pRk2DOvXWvk
	 R3GDET207804W989m1sEN0An6V4vAv7GybzQW0vKHOhBPUKgZZjOJE4KHHxPOYEUHD
	 JtJ+JZcoJbrJpvhavz2tQh0OZCZK4yZJTYk/o9Cg=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 55FA06707C;
	Wed, 26 Jun 2024 09:10:03 -0400 (EDT)
Message-ID: <b901776293d19271a34bb14f79639c4b574b6174.camel@xry111.site>
Subject: Re: [PATCH v10 1/2] x86/mm: Don't disable PCID if "incomplete
 Global INVLPG flushes" is fixed by microcode
From: Xi Ruoyao <xry111@xry111.site>
To: Dave Hansen <dave.hansen@linux.intel.com>, Michael Kelley
	 <mhklinux@outlook.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>,  Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin"
 <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Sean
 Christopherson <seanjc@google.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>
Date: Wed, 26 Jun 2024 21:10:01 +0800
In-Reply-To: <20240522020625.69418-1-xry111@xry111.site>
References: <20240522020625.69418-1-xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Ping.

Ok to queue these two into some branch for integration?

On Wed, 2024-05-22 at 10:06 +0800, Xi Ruoyao wrote:
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
. 13
> Link: https://cdrdv2.intel.com/v1/dl/getContent/682436=C2=A0# ADL063, rev=
. 24
> Link: https://lore.kernel.org/all/20240325231300.qrltbzf6twm43ftb@desk/
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
> =C2=A0arch/x86/mm/init.c | 22 ++++++++++++++--------
> =C2=A01 file changed, 14 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index eb503f53c319..e960196e8058 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -264,27 +264,33 @@ static void __init probe_page_size_mask(void)
> =C2=A0
> =C2=A0/*
> =C2=A0 * INVLPG may not properly flush Global entries
> - * on these CPUs when PCIDs are enabled.
> + * on these CPUs when PCIDs are enabled and the
> + * microcode is not updated to fix the issue.
> =C2=A0 */
> =C2=A0static const struct x86_cpu_id invlpg_miss_ids[] =3D {
> -	X86_MATCH_VFM(INTEL_ALDERLAKE,	=C2=A0=C2=A0=C2=A0 0),
> -	X86_MATCH_VFM(INTEL_ALDERLAKE_L,=C2=A0=C2=A0=C2=A0 0),
> -	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, 0),
> -	X86_MATCH_VFM(INTEL_RAPTORLAKE,	=C2=A0=C2=A0=C2=A0 0),
> -	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,=C2=A0=C2=A0 0),
> -	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,=C2=A0=C2=A0 0),
> +	X86_MATCH_VFM(INTEL_ALDERLAKE,	=C2=A0=C2=A0=C2=A0 0x2e),
> +	X86_MATCH_VFM(INTEL_ALDERLAKE_L,=C2=A0=C2=A0=C2=A0 0x42c),
> +	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, 0x11),
> +	X86_MATCH_VFM(INTEL_RAPTORLAKE,	=C2=A0=C2=A0=C2=A0 0x118),
> +	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,=C2=A0=C2=A0 0x4117),
> +	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,=C2=A0=C2=A0 0x2e),
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

