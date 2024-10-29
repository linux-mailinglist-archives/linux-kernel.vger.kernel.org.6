Return-Path: <linux-kernel+bounces-387194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4419B4D78
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF4D1C20DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C406A193434;
	Tue, 29 Oct 2024 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E0ZkPk9I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033C194A64
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215181; cv=none; b=X5dyGTD6IALQFAV2zRunwsXxwutSWyhaHczyLWaja2g/ZPCZUV0dcJYcahW2sNYzxKtvI27G8s3JMHshPduy3NkGrGVc8V1/QrC54bRr4pfrJy2IhiCQgXtuEjJGvFf4OSgijYmFBlRKyaFrD94mz0bTkcbGBP8HaYB5XH0+tB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215181; c=relaxed/simple;
	bh=CeX8zlMZMDkbqdbEs9CqI77OcEYfSEtTr17gf/4fyxY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XIETelw+zkLnac2UMYu87zJAazio2IWf/iyOwuN37QmKtX8VjxNyMmDqlxHwIxlSUasQF3i/StDaXKqJ/ISL2BPRYDcm/GVzbqenPHAVjedJhLYU/nQ8EuyKqdLSFcSx6J6UO7t3ekSqPUODa0ysfdEYSC6yvmSOJpmir/ZzAgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E0ZkPk9I; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730215179; x=1761751179;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CeX8zlMZMDkbqdbEs9CqI77OcEYfSEtTr17gf/4fyxY=;
  b=E0ZkPk9IWHWGfnoTLf9ZkCPE0bTkd+ynICs9ifFonZjUY++GS+jmgL/P
   49+okGfffbbUqnGSdLfrYesx30pIY4ELx/2ujaMnM1g/QCkIghXDUkdCj
   44cWLjMl1IaaDnXsXptgh6APwr3HdT2HDZh03OduPseaE27jNacO6SeX9
   7IydJqYPhpOSyeqJ+Vq0BngqCC2gZzfhpKvGgbXI4kQnTO9k3erCeD9kQ
   l4k40asE02O249+L5NlbBb0EoLhH70Bpb9WKv+zAsKUfHqRgKBkc5BZYc
   lGE7jyGWAwdhqZVoBK7h+b3nWXDFV6fD8qWtK2nQKbNcPTJVpPtbI9+a1
   g==;
X-CSE-ConnectionGUID: 9+I/fciMSHG2jaggFqVB0Q==
X-CSE-MsgGUID: KHJ1b091StCa0RX5glpxkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="33658969"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="33658969"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:19:39 -0700
X-CSE-ConnectionGUID: 3dgvZijTSaWkO/+y0MiGvw==
X-CSE-MsgGUID: 1ISaot3sRpGTSdCroy8r7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="112808357"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:19:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 29 Oct 2024 17:19:30 +0200 (EET)
To: Borislav Petkov <bp@alien8.de>
cc: Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
    "H. Peter Anvin" <hpa@zytor.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Yazen Ghannam <yazen.ghannam@amd.com>, 
    Suma Hegde <suma.hegde@amd.com>, 
    Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86/amd/hsmp: fix compile-testing without
 CONFiG_AMD_NB
In-Reply-To: <20241029151149.GMZyD7NakGOHgkEw4f@fat_crate.local>
Message-ID: <d93061b0-8cdf-a427-dc93-707af6282886@linux.intel.com>
References: <20241029092329.3857004-1-arnd@kernel.org> <a6f9a5aa-3208-7d03-93a0-768fd0805fdc@linux.intel.com> <20241029151149.GMZyD7NakGOHgkEw4f@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1339104167-1730215170=:951"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1339104167-1730215170=:951
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 29 Oct 2024, Borislav Petkov wrote:

> On Tue, Oct 29, 2024 at 02:39:41PM +0200, Ilpo J=C3=A4rvinen wrote:
> > I don't like this very wording because what the code very much does is=
=20
> > NULL check on node_to_amd_nb() which leads to immediate failure of=20
> > .probe(). (We don't call other deferences after a NULL check "NULL poin=
ter=20
> > dereference" either so none is introduced by this patch, IMO.)
>=20
> I was wondering that too: where does this line
>=20
> =09 sock->root                      =3D node_to_amd_nb(i)->root;
>=20
> quoted by gcc come from?
>
> IOW, what is the correct Fixes: tag?
>=20
> The commit 7d3135d16356 ("platform/x86/amd/hsmp: Create separate ACPI, pl=
at and common drivers
>=20
> is only in next AFAICT, so I'll drop the Fixes: tag when sending...

To clarify,

The assignment line is old (from 287a821c76be8 or even before that in=20
some form which would have not lead to compiler warning though).

It's the COMPILE_TEST that got enabled in 7d3135d16356, before that hsmp=20
depended on AMD_NB so the condition could never trigger.

--=20
 i.

--8323328-1339104167-1730215170=:951--

