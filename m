Return-Path: <linux-kernel+bounces-386930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5086B9B49DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EE39B21C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B989200C91;
	Tue, 29 Oct 2024 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9nlIVki"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A9632
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205593; cv=none; b=a1ZNWlhKhWgiPsm0iFHr4KdOsCnvx29Y8FAWwyLHKD2/p0LMQCW5uHRxFu+ys2RyrBK5vfqky3/tmS2e/+VwnM3KRugCVAHkTB6sAk9RndVT5bhJRFyi+QMsDK2EIAdLPSlAw5WT4LLY1a7hfAbg6QawF2qbpOb8FJ02EHpRFFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205593; c=relaxed/simple;
	bh=dG5CpD+fKgmIPPgZlSWExZUn+iNKJyGi6MiY9nxeyBI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rWKUCsjJUdQ1bukQaVb4hLlFJ3t1hVjnta5t38IncOK/ZCy/NTuBm8nCMIB5tqDEYuATBPnEI7NZm71wXPttcmlZOuF4tb2acrtX+feM7KEKELnj6a0YA2PuGfmmfknhW6vpuLzYD8BfXHihfxNIU13uh3WVwEPWxY/I40CD3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9nlIVki; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730205591; x=1761741591;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dG5CpD+fKgmIPPgZlSWExZUn+iNKJyGi6MiY9nxeyBI=;
  b=h9nlIVkinqSQp9PQxO5ajnhnYsjE9boSPysaK9uEWfrnUjchglUKRCUy
   aSQSUEpTEqdrk1ofxgY169NwoFGgniRcQWWHzLMSZ/3ZAoNAfKelqFI12
   1Q6/fQpk+fLlnJCdxMko9rkA+as1iLeJqPYrYy5OehrUJ+o5U7WFxqfed
   kb2sak/tmEARNBZ4ozsGlxODpsg+LDfLjzJyRLtMahwz0lQYhphjAmjMJ
   uYSNnB7/l9uXA8kVivZqNLN6dep7PhwBhgXFtgd2Na9MS4TwjWaTxv8jN
   q3YS0T16Zf6l2aDh3ANxQpXy/MALBKGKEI0zX5te9+3sKgry4V+0iv56g
   w==;
X-CSE-ConnectionGUID: ogbHgZlCRuqDpRBED8B18A==
X-CSE-MsgGUID: E+aWRQIHQum/6OwqVcOS2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29617344"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29617344"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 05:39:49 -0700
X-CSE-ConnectionGUID: +7qCp9e1Sje4T1sMVtJDnw==
X-CSE-MsgGUID: F0/yF/+dQaGx4tEqmcoE9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="112751595"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 05:39:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 29 Oct 2024 14:39:41 +0200 (EET)
To: Arnd Bergmann <arnd@kernel.org>
cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, 
    Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
    "H. Peter Anvin" <hpa@zytor.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Yazen Ghannam <yazen.ghannam@amd.com>, 
    Suma Hegde <suma.hegde@amd.com>, 
    Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86/amd/hsmp: fix compile-testing without
 CONFiG_AMD_NB
In-Reply-To: <20241029092329.3857004-1-arnd@kernel.org>
Message-ID: <a6f9a5aa-3208-7d03-93a0-768fd0805fdc@linux.intel.com>
References: <20241029092329.3857004-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-787387698-1730205581=:951"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-787387698-1730205581=:951
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 29 Oct 2024, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> node_to_amd_nb() is defined to NULL in non-AMD configs:
>=20
> drivers/platform/x86/amd/hsmp/plat.c: In function 'init_platform_device':
> drivers/platform/x86/amd/hsmp/plat.c:165:68: error: dereferencing 'void *=
' pointer [-Werror]
>   165 |                 sock->root                      =3D node_to_amd_n=
b(i)->root;
>       |                                                                  =
  ^~
> drivers/platform/x86/amd/hsmp/plat.c:165:68: error: request for member 'r=
oot' in something not a structure or union
>=20
> Change the definition to something that builds. This does introduce a
> NULL pointer dereference but the code is never called since the driver
> won't probe successfully.

I don't like this very wording because what the code very much does is=20
NULL check on node_to_amd_nb() which leads to immediate failure of=20
=2Eprobe(). (We don't call other deferences after a NULL check "NULL pointe=
r=20
dereference" either so none is introduced by this patch, IMO.)

With that fixed,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> Fixes: 7d3135d16356 ("platform/x86/amd/hsmp: Create separate ACPI, plat a=
nd common drivers")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/include/asm/amd_nb.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.=
h
> index 6f3b6aef47ba..d0caac26533f 100644
> --- a/arch/x86/include/asm/amd_nb.h
> +++ b/arch/x86/include/asm/amd_nb.h
> @@ -116,7 +116,10 @@ static inline bool amd_gart_present(void)
> =20
>  #define amd_nb_num(x)=09=090
>  #define amd_nb_has_feature(x)=09false
> -#define node_to_amd_nb(x)=09NULL
> +static inline struct amd_northbridge *node_to_amd_nb(int node)
> +{
> +=09return NULL;
> +}
>  #define amd_gart_present(x)=09false
> =20
>  #endif
>=20
--8323328-787387698-1730205581=:951--

