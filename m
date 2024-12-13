Return-Path: <linux-kernel+bounces-445150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B51B9F1205
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB56328151E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE981E3DD7;
	Fri, 13 Dec 2024 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gXeXRSbk"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D218B1E0B75
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107118; cv=none; b=usmWgUjcPC1y9sT43ihxJZXjDvsDzREvUD9fgWvA39MENDnbd+Zac1lKrLdo7EDyIq6wBWdi8a/4MXoAX0PuGItdooUaOgBeNDuxWzse+tobu/xtZF9xCmTn6K/+xBk6HPg8YIbcYMaLKO22mb42X5iTyyjXuY5zRssuI7YnZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107118; c=relaxed/simple;
	bh=bDjkS3RDqhwYRFVzlNvwMie4dPIqpYOro2gNb2FIpSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6rztaiMK36F8NNdywwDlRvDwEfFK1M2gfbOnP08DdONdjh/yM4V6L5BPY7Fm8SdcYcXc76dTVTho2NXqu8uvT+x52MX+Fkk/oI5WJ4UAHi7JyqyJfkr8T91GQ2vSrrXVNCTE2Do5QUeqvDaWEx7AeEA/ziKAYfr1NQeLNHC/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gXeXRSbk reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C82AD40E021C;
	Fri, 13 Dec 2024 16:25:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6eXq1q5xaKRH; Fri, 13 Dec 2024 16:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1734107100; bh=ZoDsQO4cyfeT8yDah74VHVU469XgFdH46Pk4xGycjQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gXeXRSbkdUoxD3Gv9B6PFcdX+GWQ5u48Cn7WA3rOdTGsecPwS9kHsLszWvZRrPpVQ
	 +MVnvsDalGzMeK+ANcUtaisoeexUcbJddx6zTPD8yWzqAoDOGcl0WrjC/sP4/8u1dU
	 P+4CBbEAF6xdUDi3IKbL1+lLUX5U98LDDk5PS9eCdKzRZQf7c1TpHkGw+QbYTmRhc6
	 t7m4Vt+zd+cdopyPXVcphUqvfzwMu+xJ7uZeNG7h1pYoyla51sXIvGAJYqmBbm7POE
	 rLVnn8LkNC5i5HDHtVdL9bye8y4y+L5b43XP/HUtPFrNZiktVZ4Ol8YcCM0ktS2pS7
	 ECE794m2fLXdjVNwa5wCZqGuYfvclf7lBUz3cekIYNQmQSDqK4bs5Qj5PmUHXQ7bRn
	 qGUnBTBPbfHvTuYsoi5weexFdeYiO1wxlnA0SUhV485N6xkoeSdBkC7/V+w1CN3z5C
	 ADcrkzX8YiShSfH9evfwT+fs5Uwf8s2Ufhf4zKD7kwk4KK44+SoaK1IFGBQy6OvFLt
	 LSIwqSExYz02P1cq1+32dtKpYq2vY9/iyiM3aJnjmnldgiAD1KMMhnf23jLxdtvsH2
	 FmsQLaprVu+V706JmGMmk0iL7h0mQP8aUOUAbfeDge/50hzugKy7CKrMi5P0a7q7jn
	 /DtjzLQX3/8yVYoIAHYg/+bs=
Received: from zn.tnic (p200300eA971F9372329C23ffFEa6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9372:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 259B740E01F9;
	Fri, 13 Dec 2024 16:24:51 +0000 (UTC)
Date: Fri, 13 Dec 2024 17:24:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	kan.liang@linux.intel.com, mingo@kernel.org, peterz@infradead.org,
	tony.luck@intel.com, pawan.kumar.gupta@linux.intel.com
Subject: Re: [PATCH 2/5] x86/cpu: Expose only stepping min/max interface
Message-ID: <20241213162443.GGZ1xfyw_EZBrn1i4B@fat_crate.local>
References: <20241206193829.89E12D0B@davehans-spike.ostc.intel.com>
 <20241206193832.DCF208DC@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241206193832.DCF208DC@davehans-spike.ostc.intel.com>
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 11:38:32AM -0800, Dave Hansen wrote:
>=20
> From: Dave Hansen <dave.hansen@linux.intel.com>
>=20
> The x86_match_cpu() infrastructure can match CPU steppings. Since
> there are only 16 possible steppings, the matching infrastructure goes
> all out and stores the stepping match as a bitmap. That means it can
> match any possible steppings in a single list entry. Fun.
>=20
> But it exposes this bitmap to each of the X86_MATCH_*() helpers when
> none of them really need a bitmap. It makes up for this by exporting a
> helper (X86_STEPPINGS()) which converts a contiguous stepping range
> into the bitmap which every single user leverages.
>=20
> Instead of a bitmap, have the main helper for this sort of thing
> (X86_MATCH_VFM_STEPPING()) just take a stepping range. This ends up
> actually being even more compact than before.

Yap, better.

> Leave the helper in place (renamed to __X86_STEPPINGS()) to make it
> more clear what is going on instead of just having a random GENMASK()
> in the middle of an already complicated macro.
>=20
> One oddity that I hit was this macro:
>=20
> #define VULNBL_INTEL_STEPPINGS(vfm, max_stepping, issues)              =
   \
>        X86_MATCH_VFM_STEPPINGS(vfm, X86_STEPPING_MIN, max_stepping, iss=
ues)
>=20
> It *could* have been converted over to take a min/max stepping value
> for each entry. But that would have been a bit too verbose and would
> prevent the one oddball in the list (INTEL_COMETLAKE_L stepping 0)
> from sticking out.
>=20
> Instead, just have it take a *maximum* stepping and imply that the matc=
h
> is from 0=3D>max_stepping. This is functional for all the cases now and
> also retains the nice property of having INTEL_COMETLAKE_L stepping 0
> stick out like a sore thumb.
>=20
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> ---
>=20
>  b/arch/x86/include/asm/cpu_device_id.h |   15 +++---
>  b/arch/x86/kernel/apic/apic.c          |   18 +++----
>  b/arch/x86/kernel/cpu/common.c         |   78 ++++++++++++++++--------=
---------
>  b/drivers/edac/i10nm_base.c            |   20 ++++----
>  b/drivers/edac/skx_base.c              |    2=20
>  b/include/linux/mod_devicetable.h      |    2=20
>  6 files changed, 69 insertions(+), 66 deletions(-)

You missed a spot:

drivers/edac/i10nm_base.c:951:90: error: macro "X86_MATCH_VFM_STEPPINGS" =
requires 4 arguments, but only 3 given
  951 |         X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_DARKMONT_X,  X86_STEPP=
INGS(0x0, 0xf), &gnr_cfg),
      |                                                                  =
                        ^
In file included from drivers/edac/i10nm_base.c:10:
./arch/x86/include/asm/cpu_device_id.h:221: note: macro "X86_MATCH_VFM_ST=
EPPINGS" defined here
  221 | #define X86_MATCH_VFM_STEPPINGS(vfm, min_step, max_step, data)  \
      |=20
drivers/edac/i10nm_base.c:951:9: error: =E2=80=98X86_MATCH_VFM_STEPPINGS=E2=
=80=99 undeclared here (not in a function)
  951 |         X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_DARKMONT_X,  X86_STEPP=
INGS(0x0, 0xf), &gnr_cfg),
      |         ^~~~~~~~~~~~~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:194: drivers/edac/i10nm_base.o] Erro=
r 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:440: drivers/edac] Error 2
make[2]: *** [scripts/Makefile.build:440: drivers] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/mnt/kernel/kernel/2nd/linux/Makefile:1989: .] Error 2
make: *** [Makefile:251: __sub-make] Error 2

> diff -puN drivers/edac/i10nm_base.c~zap-X86_STEPPINGS drivers/edac/i10n=
m_base.c
> --- a/drivers/edac/i10nm_base.c~zap-X86_STEPPINGS	2024-12-06 11:33:16.1=
87148838 -0800
> +++ b/drivers/edac/i10nm_base.c	2024-12-06 11:33:16.191148995 -0800
> @@ -938,16 +938,16 @@ static struct res_config gnr_cfg =3D {
>  };
> =20
>  static const struct x86_cpu_id i10nm_cpuids[] =3D {
> -	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_TREMONT_D,	X86_STEPPINGS(0x0, 0x3)=
, &i10nm_cfg0),
> -	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_TREMONT_D,	X86_STEPPINGS(0x4, 0xf)=
, &i10nm_cfg1),
> -	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_X,	X86_STEPPINGS(0x0, 0x3), &i1=
0nm_cfg0),
> -	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_X,	X86_STEPPINGS(0x4, 0xf), &i1=
0nm_cfg1),
> -	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_D,	X86_STEPPINGS(0x0, 0xf), &i1=
0nm_cfg1),
> -	X86_MATCH_VFM_STEPPINGS(INTEL_SAPPHIRERAPIDS_X,	X86_STEPPINGS(0x0, 0x=
f), &spr_cfg),
> -	X86_MATCH_VFM_STEPPINGS(INTEL_EMERALDRAPIDS_X,	X86_STEPPINGS(0x0, 0xf=
), &spr_cfg),
> -	X86_MATCH_VFM_STEPPINGS(INTEL_GRANITERAPIDS_X,	X86_STEPPINGS(0x0, 0xf=
), &gnr_cfg),
> -	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT_X,	X86_STEPPINGS(0x0, 0x=
f), &gnr_cfg),
> -	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT,	X86_STEPPINGS(0x0, 0xf)=
, &gnr_cfg),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_TREMONT_D,	0x0, 0x3, &i10nm_cfg0),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_TREMONT_D,	0x4, 0xf, &i10nm_cfg1),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_X,	0x0, 0x3, &i10nm_cfg0),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_X,	0x4, 0xf, &i10nm_cfg1),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_D,	0x0, 0xf, &i10nm_cfg1),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_SAPPHIRERAPIDS_X,	0x0, 0xf, &spr_cfg),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_EMERALDRAPIDS_X,	0x0, 0xf, &spr_cfg),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_GRANITERAPIDS_X,	0x0, 0xf, &gnr_cfg),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT_X,	0x0, 0xf, &gnr_cfg),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT,	0x0, 0xf, &gnr_cfg),

Aren't those supposed to be:

	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT,	X86_STEPPING_MIN, X86_STEP=
PING_MAX, &gnr_cfg),

And while we're adding new defines, can we shorten them too?

	X86_MATCH_VFM_STP(INTEL_ATOM_CRESTMONT,	X86_STP_MIN, X86_STP_MAX, &gnr_c=
fg),

all that "STEPPING" is screaming at me! :-P

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

