Return-Path: <linux-kernel+bounces-405583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351BE9C531A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0AFC282624
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55302123DD;
	Tue, 12 Nov 2024 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ctn1FXj3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF6F21441D;
	Tue, 12 Nov 2024 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406788; cv=none; b=WZWq7+Rkv48/7hehiG6r02p9f/Z9nGdb3Qm8uPdj8lsVIu/EjbVtv7v+gqE2KOh+4putqWfxt+fj0G72BeYhaT6o7kFRADHmisLEigXHEk5so2EZh4juhUvFAJ23HAEmqKV7DcL9hgPZZRvVq+GqfmF5QOMY4iCrMPpSFhXOaJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406788; c=relaxed/simple;
	bh=KwSrUpFEqvOnd6VotMijoA8CBoz5ElYLUEX5k5rtjVU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GHrolZBgckxluWiqxPGlXqfFHovFYGX800Zf5FziscKYEGzuhU5klxVdZWaIjtcZ5i3DXfLQS1tHlMifDDjpylpdtT6pdfqC1cyo9S3oqQ7HWPi+fio1N0Rlls2TyoWbFhokNPaFgbx823zMs+ByWA78ow3PzgUPV3Y/tc6DKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ctn1FXj3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731406786; x=1762942786;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KwSrUpFEqvOnd6VotMijoA8CBoz5ElYLUEX5k5rtjVU=;
  b=ctn1FXj3ZApIA3Df4O3FVuCBu/w7slqNfmk7AweBAi3myJzlc2suSaV/
   qJTeQfgHJFnOEKKx+GlCtrdioNAp4+pFT93tt4br8Dp343eADDF67Hk+D
   AOnT3+XYenXpfTQwgzW5A+n6IQqWi56C9Xshc4UvorgWN0SF4AjyCUJM2
   A2UwAzjzr/JqPYFb185ukqDHtzytMuI1kA8F3sZViRIDxxd5LZEH7/j4X
   sVgoxC8oMWV9T2B08JooBwo5fYny+UTylWMkkWOI3rOyBd5ShT3dHwA3f
   AB9/Rgl5aqQeX3YgP7Ja6+ody90nOQUBg9JxEuwjxD1lenLOv2/H/Oilm
   g==;
X-CSE-ConnectionGUID: LsZYMiHoRRear6MyOd7Vtg==
X-CSE-MsgGUID: N77MEFaeSGmaET24Ivgzgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="31328126"
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="31328126"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 02:19:45 -0800
X-CSE-ConnectionGUID: ypB9yLikQ8apBRutXdtttg==
X-CSE-MsgGUID: qPsMIZQ8SymCKTh+OxxAUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="87811319"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 02:19:40 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 Nov 2024 12:19:37 +0200 (EET)
To: Suma Hegde <Suma.Hegde@amd.com>
cc: Arnd Bergmann <arnd@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
    Arnd Bergmann <arnd@arndb.de>, 
    Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, 
    Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    song@kernel.org
Subject: Re: [PATCH] [v2] platform/x86/amd/hsmp: move hsmp_msg_desc_table[]
 to hsmp.c
In-Reply-To: <e7a45f09-16fb-4d15-b1e4-0a3ef3f25dda@amd.com>
Message-ID: <39140d31-7cf3-fca0-ad84-1cb033b045c7@linux.intel.com>
References: <20241030210019.2858358-1-arnd@kernel.org> <582e3574-1823-0c1b-25a8-6a4a6bf73f63@linux.intel.com> <e7a45f09-16fb-4d15-b1e4-0a3ef3f25dda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1493538551-1731406777=:961"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1493538551-1731406777=:961
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 4 Nov 2024, Suma Hegde wrote:

> Hi,
>=20
>=20
> On 10/31/2024 3:22 PM, Ilpo J=C3=A4rvinen wrote:
> > Caution: This message originated from an External Source. Use proper ca=
ution
> > when opening attachments, clicking links, or responding.
> >=20
> >=20
> > On Wed, 30 Oct 2024, Arnd Bergmann wrote:
> >=20
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >=20
> > > After the file got split, there are now W=3D1 warnings for users that
> > > include it without referencing hsmp_msg_desc_table:
> > >=20
> > > In file included from arch/x86/include/asm/amd_hsmp.h:6,
> > >                   from drivers/platform/x86/amd/hsmp/plat.c:12:
> > > arch/x86/include/uapi/asm/amd_hsmp.h:91:35: error: 'hsmp_msg_desc_tab=
le'
> > > defined but not used [-Werror=3Dunused-const-variable=3D]
> > >     91 | static const struct hsmp_msg_desc hsmp_msg_desc_table[] =3D =
{
> > >        |                                   ^~~~~~~~~~~~~~~~~~~
> > >=20
> > > The array was never meant to be used by userspace code, but was
> > > left in the header as a reference for userspace programmers.
> > >=20
> > > Move the contents of the array into the one file that actually needs
> > > it, and instead leave the URL of the new location in the uapi header
> > > in case anyone is looking for it.
> > >=20
> > > Fixes: e47c018a0ee6 ("platform/x86/amd/hsmp: Move platform device spe=
cific
> > > code to plat.c")
> > > Suggested-by: Hans de Goede <hdegoede@redhat.com>
> > > Link:
> > > https://lore.kernel.org/lkml/046687d8-1e2d-435b-adcb-26897bfd29f7@red=
hat.com/
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> >=20
> > I'll leave it into patchwork for a few days if somebody has some still
> > unvoiced opinions on this.
> AFAIK, Song Liu might be having some user space tool which makes use of t=
his
> hsmp_msg_desc_table[].
>=20
> Please refer
> https://lore.kernel.org/platform-driver-x86/bfee54fe-1779-fea2-8365-31167=
cc06972@amd.com/T/#mb563e1e07183e6bb5f85ab2cba4afe0deca1d3c3
>=20
> for the discussions on having this table in UAPI header.
>=20
> @Song Liu, this table is moved to hsmp.c now.=C2=A0 Please raise your con=
cern here
> if any.

Given what that thread says about tests, I've decided to take careful=20
approach of v1 instead of v2.

I'd still appreciate if Song Liu could confirm if this is relevant for=20
some tests or not. We can proceed with the move to .c file later if it=20
turns out unused.

--=20
 i.

> > >   arch/x86/include/uapi/asm/amd_hsmp.h | 255 ++----------------------=
---
> > >   drivers/platform/x86/amd/hsmp/hsmp.c | 245 ++++++++++++++++++++++++=
+
> > >   2 files changed, 255 insertions(+), 245 deletions(-)
> > >=20
> > > diff --git a/arch/x86/include/uapi/asm/amd_hsmp.h
> > > b/arch/x86/include/uapi/asm/amd_hsmp.h
> > > index e5d182c7373c..dfa6aa985ac4 100644
> > > --- a/arch/x86/include/uapi/asm/amd_hsmp.h
> > > +++ b/arch/x86/include/uapi/asm/amd_hsmp.h
> > > @@ -1,5 +1,15 @@
> > >   /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > >=20
> > > +/*
> > > + * See hsmp_msg_desc_table[] in:
> > > + *
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/platform/x86/amd/hsmp.c
> > > + *
> > > + * for some information on number of input- and output arguments
> > > + * for the various functions.
> > > + *
> > > + * Please find the supported list of messages and message definition
> > > + * in the HSMP chapter of respective family/model PPR.
> > > + */
> > >   #ifndef _UAPI_ASM_X86_AMD_HSMP_H_
> > >   #define _UAPI_ASM_X86_AMD_HSMP_H_
> > >=20
> > > @@ -81,251 +91,6 @@ struct hsmp_msg_desc {
> > >        enum hsmp_msg_type type;
> > >   };
> > >=20
> > > -/*
> > > - * User may use these comments as reference, please find the
> > > - * supported list of messages and message definition in the
> > > - * HSMP chapter of respective family/model PPR.
> > > - *
> > > - * Not supported messages would return -ENOMSG.
> > > - */
> > > -static const struct hsmp_msg_desc hsmp_msg_desc_table[] =3D {
> > > -     /* RESERVED */
> > > -     {0, 0, HSMP_RSVD},
> > > -
> > > -     /*
> > > -      * HSMP_TEST, num_args =3D 1, response_sz =3D 1
> > > -      * input:  args[0] =3D xx
> > > -      * output: args[0] =3D xx + 1
> > > -      */
> > > -     {1, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_SMU_VER, num_args =3D 0, response_sz =3D 1
> > > -      * output: args[0] =3D smu fw ver
> > > -      */
> > > -     {0, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_PROTO_VER, num_args =3D 0, response_sz =3D 1
> > > -      * output: args[0] =3D proto version
> > > -      */
> > > -     {0, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_SOCKET_POWER, num_args =3D 0, response_sz =3D 1
> > > -      * output: args[0] =3D socket power in mWatts
> > > -      */
> > > -     {0, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_SET_SOCKET_POWER_LIMIT, num_args =3D 1, response_sz =3D=
 0
> > > -      * input: args[0] =3D power limit value in mWatts
> > > -      */
> > > -     {1, 0, HSMP_SET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_SOCKET_POWER_LIMIT, num_args =3D 0, response_sz =3D=
 1
> > > -      * output: args[0] =3D socket power limit value in mWatts
> > > -      */
> > > -     {0, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_SOCKET_POWER_LIMIT_MAX, num_args =3D 0, response_sz=
 =3D 1
> > > -      * output: args[0] =3D maximuam socket power limit in mWatts
> > > -      */
> > > -     {0, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_SET_BOOST_LIMIT, num_args =3D 1, response_sz =3D 0
> > > -      * input: args[0] =3D apic id[31:16] + boost limit value in MHz=
[15:0]
> > > -      */
> > > -     {1, 0, HSMP_SET},
> > > -
> > > -     /*
> > > -      * HSMP_SET_BOOST_LIMIT_SOCKET, num_args =3D 1, response_sz =3D=
 0
> > > -      * input: args[0] =3D boost limit value in MHz
> > > -      */
> > > -     {1, 0, HSMP_SET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_BOOST_LIMIT, num_args =3D 1, response_sz =3D 1
> > > -      * input: args[0] =3D apic id
> > > -      * output: args[0] =3D boost limit value in MHz
> > > -      */
> > > -     {1, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_PROC_HOT, num_args =3D 0, response_sz =3D 1
> > > -      * output: args[0] =3D proc hot status
> > > -      */
> > > -     {0, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_SET_XGMI_LINK_WIDTH, num_args =3D 1, response_sz =3D 0
> > > -      * input: args[0] =3D min link width[15:8] + max link width[7:0=
]
> > > -      */
> > > -     {1, 0, HSMP_SET},
> > > -
> > > -     /*
> > > -      * HSMP_SET_DF_PSTATE, num_args =3D 1, response_sz =3D 0
> > > -      * input: args[0] =3D df pstate[7:0]
> > > -      */
> > > -     {1, 0, HSMP_SET},
> > > -
> > > -     /* HSMP_SET_AUTO_DF_PSTATE, num_args =3D 0, response_sz =3D 0 *=
/
> > > -     {0, 0, HSMP_SET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_FCLK_MCLK, num_args =3D 0, response_sz =3D 2
> > > -      * output: args[0] =3D fclk in MHz, args[1] =3D mclk in MHz
> > > -      */
> > > -     {0, 2, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_CCLK_THROTTLE_LIMIT, num_args =3D 0, response_sz =
=3D 1
> > > -      * output: args[0] =3D core clock in MHz
> > > -      */
> > > -     {0, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_C0_PERCENT, num_args =3D 0, response_sz =3D 1
> > > -      * output: args[0] =3D average c0 residency
> > > -      */
> > > -     {0, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_SET_NBIO_DPM_LEVEL, num_args =3D 1, response_sz =3D 0
> > > -      * input: args[0] =3D nbioid[23:16] + max dpm level[15:8] + min=
 dpm
> > > level[7:0]
> > > -      */
> > > -     {1, 0, HSMP_SET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_NBIO_DPM_LEVEL, num_args =3D 1, response_sz =3D 1
> > > -      * input: args[0] =3D nbioid[23:16]
> > > -      * output: args[0] =3D max dpm level[15:8] + min dpm level[7:0]
> > > -      */
> > > -     {1, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_DDR_BANDWIDTH, num_args =3D 0, response_sz =3D 1
> > > -      * output: args[0] =3D max bw in Gbps[31:20] + utilised bw in
> > > Gbps[19:8] +
> > > -      * bw in percentage[7:0]
> > > -      */
> > > -     {0, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_TEMP_MONITOR, num_args =3D 0, response_sz =3D 1
> > > -      * output: args[0] =3D temperature in degree celsius. [15:8] in=
teger
> > > part +
> > > -      * [7:5] fractional part
> > > -      */
> > > -     {0, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_DIMM_TEMP_RANGE, num_args =3D 1, response_sz =3D 1
> > > -      * input: args[0] =3D DIMM address[7:0]
> > > -      * output: args[0] =3D refresh rate[3] + temperature range[2:0]
> > > -      */
> > > -     {1, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_DIMM_POWER, num_args =3D 1, response_sz =3D 1
> > > -      * input: args[0] =3D DIMM address[7:0]
> > > -      * output: args[0] =3D DIMM power in mW[31:17] + update rate in
> > > ms[16:8] +
> > > -      * DIMM address[7:0]
> > > -      */
> > > -     {1, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_DIMM_THERMAL, num_args =3D 1, response_sz =3D 1
> > > -      * input: args[0] =3D DIMM address[7:0]
> > > -      * output: args[0] =3D temperature in degree celsius[31:21] + u=
pdate
> > > rate in ms[16:8] +
> > > -      * DIMM address[7:0]
> > > -      */
> > > -     {1, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_SOCKET_FREQ_LIMIT, num_args =3D 0, response_sz =3D =
1
> > > -      * output: args[0] =3D frequency in MHz[31:16] + frequency
> > > source[15:0]
> > > -      */
> > > -     {0, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_CCLK_CORE_LIMIT, num_args =3D 1, response_sz =3D 1
> > > -      * input: args[0] =3D apic id [31:0]
> > > -      * output: args[0] =3D frequency in MHz[31:0]
> > > -      */
> > > -     {1, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_RAILS_SVI, num_args =3D 0, response_sz =3D 1
> > > -      * output: args[0] =3D power in mW[31:0]
> > > -      */
> > > -     {0, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_SOCKET_FMAX_FMIN, num_args =3D 0, response_sz =3D 1
> > > -      * output: args[0] =3D fmax in MHz[31:16] + fmin in MHz[15:0]
> > > -      */
> > > -     {0, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_IOLINK_BANDWITH, num_args =3D 1, response_sz =3D 1
> > > -      * input: args[0] =3D link id[15:8] + bw type[2:0]
> > > -      * output: args[0] =3D io bandwidth in Mbps[31:0]
> > > -      */
> > > -     {1, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_XGMI_BANDWITH, num_args =3D 1, response_sz =3D 1
> > > -      * input: args[0] =3D link id[15:8] + bw type[2:0]
> > > -      * output: args[0] =3D xgmi bandwidth in Mbps[31:0]
> > > -      */
> > > -     {1, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_SET_GMI3_WIDTH, num_args =3D 1, response_sz =3D 0
> > > -      * input: args[0] =3D min link width[15:8] + max link width[7:0=
]
> > > -      */
> > > -     {1, 0, HSMP_SET},
> > > -
> > > -     /*
> > > -      * HSMP_SET_PCI_RATE, num_args =3D 1, response_sz =3D 1
> > > -      * input: args[0] =3D link rate control value
> > > -      * output: args[0] =3D previous link rate control value
> > > -      */
> > > -     {1, 1, HSMP_SET},
> > > -
> > > -     /*
> > > -      * HSMP_SET_POWER_MODE, num_args =3D 1, response_sz =3D 0
> > > -      * input: args[0] =3D power efficiency mode[2:0]
> > > -      */
> > > -     {1, 0, HSMP_SET},
> > > -
> > > -     /*
> > > -      * HSMP_SET_PSTATE_MAX_MIN, num_args =3D 1, response_sz =3D 0
> > > -      * input: args[0] =3D min df pstate[15:8] + max df pstate[7:0]
> > > -      */
> > > -     {1, 0, HSMP_SET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_METRIC_TABLE_VER, num_args =3D 0, response_sz =3D 1
> > > -      * output: args[0] =3D metrics table version
> > > -      */
> > > -     {0, 1, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_METRIC_TABLE, num_args =3D 0, response_sz =3D 0
> > > -      */
> > > -     {0, 0, HSMP_GET},
> > > -
> > > -     /*
> > > -      * HSMP_GET_METRIC_TABLE_DRAM_ADDR, num_args =3D 0, response_sz=
 =3D 2
> > > -      * output: args[0] =3D lower 32 bits of the address
> > > -      * output: args[1] =3D upper 32 bits of the address
> > > -      */
> > > -     {0, 2, HSMP_GET},
> > > -};
> > > -
> > >   /* Metrics table (supported only with proto version 6) */
> > >   struct hsmp_metric_table {
> > >        __u32 accumulation_counter;
> > > diff --git a/drivers/platform/x86/amd/hsmp/hsmp.c
> > > b/drivers/platform/x86/amd/hsmp/hsmp.c
> > > index 82d8ba2e1204..5d21bc8b2fd7 100644
> > > --- a/drivers/platform/x86/amd/hsmp/hsmp.c
> > > +++ b/drivers/platform/x86/amd/hsmp/hsmp.c
> > > @@ -37,6 +37,251 @@
> > >=20
> > >   static struct hsmp_plat_device hsmp_pdev;
> > >=20
> > > +/*
> > > + * User may use these comments as reference, please find the
> > > + * supported list of messages and message definition in the
> > > + * HSMP chapter of respective family/model PPR.
> > > + *
> > > + * Not supported messages would return -ENOMSG.
> > > + */
> > > +static const struct hsmp_msg_desc hsmp_msg_desc_table[] =3D {
> > > +     /* RESERVED */
> > > +     {0, 0, HSMP_RSVD},
> > > +
> > > +     /*
> > > +      * HSMP_TEST, num_args =3D 1, response_sz =3D 1
> > > +      * input:  args[0] =3D xx
> > > +      * output: args[0] =3D xx + 1
> > > +      */
> > > +     {1, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_SMU_VER, num_args =3D 0, response_sz =3D 1
> > > +      * output: args[0] =3D smu fw ver
> > > +      */
> > > +     {0, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_PROTO_VER, num_args =3D 0, response_sz =3D 1
> > > +      * output: args[0] =3D proto version
> > > +      */
> > > +     {0, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_SOCKET_POWER, num_args =3D 0, response_sz =3D 1
> > > +      * output: args[0] =3D socket power in mWatts
> > > +      */
> > > +     {0, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_SET_SOCKET_POWER_LIMIT, num_args =3D 1, response_sz =3D=
 0
> > > +      * input: args[0] =3D power limit value in mWatts
> > > +      */
> > > +     {1, 0, HSMP_SET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_SOCKET_POWER_LIMIT, num_args =3D 0, response_sz =3D=
 1
> > > +      * output: args[0] =3D socket power limit value in mWatts
> > > +      */
> > > +     {0, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_SOCKET_POWER_LIMIT_MAX, num_args =3D 0, response_sz=
 =3D 1
> > > +      * output: args[0] =3D maximuam socket power limit in mWatts
> > > +      */
> > > +     {0, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_SET_BOOST_LIMIT, num_args =3D 1, response_sz =3D 0
> > > +      * input: args[0] =3D apic id[31:16] + boost limit value in MHz=
[15:0]
> > > +      */
> > > +     {1, 0, HSMP_SET},
> > > +
> > > +     /*
> > > +      * HSMP_SET_BOOST_LIMIT_SOCKET, num_args =3D 1, response_sz =3D=
 0
> > > +      * input: args[0] =3D boost limit value in MHz
> > > +      */
> > > +     {1, 0, HSMP_SET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_BOOST_LIMIT, num_args =3D 1, response_sz =3D 1
> > > +      * input: args[0] =3D apic id
> > > +      * output: args[0] =3D boost limit value in MHz
> > > +      */
> > > +     {1, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_PROC_HOT, num_args =3D 0, response_sz =3D 1
> > > +      * output: args[0] =3D proc hot status
> > > +      */
> > > +     {0, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_SET_XGMI_LINK_WIDTH, num_args =3D 1, response_sz =3D 0
> > > +      * input: args[0] =3D min link width[15:8] + max link width[7:0=
]
> > > +      */
> > > +     {1, 0, HSMP_SET},
> > > +
> > > +     /*
> > > +      * HSMP_SET_DF_PSTATE, num_args =3D 1, response_sz =3D 0
> > > +      * input: args[0] =3D df pstate[7:0]
> > > +      */
> > > +     {1, 0, HSMP_SET},
> > > +
> > > +     /* HSMP_SET_AUTO_DF_PSTATE, num_args =3D 0, response_sz =3D 0 *=
/
> > > +     {0, 0, HSMP_SET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_FCLK_MCLK, num_args =3D 0, response_sz =3D 2
> > > +      * output: args[0] =3D fclk in MHz, args[1] =3D mclk in MHz
> > > +      */
> > > +     {0, 2, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_CCLK_THROTTLE_LIMIT, num_args =3D 0, response_sz =
=3D 1
> > > +      * output: args[0] =3D core clock in MHz
> > > +      */
> > > +     {0, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_C0_PERCENT, num_args =3D 0, response_sz =3D 1
> > > +      * output: args[0] =3D average c0 residency
> > > +      */
> > > +     {0, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_SET_NBIO_DPM_LEVEL, num_args =3D 1, response_sz =3D 0
> > > +      * input: args[0] =3D nbioid[23:16] + max dpm level[15:8] + min=
 dpm
> > > level[7:0]
> > > +      */
> > > +     {1, 0, HSMP_SET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_NBIO_DPM_LEVEL, num_args =3D 1, response_sz =3D 1
> > > +      * input: args[0] =3D nbioid[23:16]
> > > +      * output: args[0] =3D max dpm level[15:8] + min dpm level[7:0]
> > > +      */
> > > +     {1, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_DDR_BANDWIDTH, num_args =3D 0, response_sz =3D 1
> > > +      * output: args[0] =3D max bw in Gbps[31:20] + utilised bw in
> > > Gbps[19:8] +
> > > +      * bw in percentage[7:0]
> > > +      */
> > > +     {0, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_TEMP_MONITOR, num_args =3D 0, response_sz =3D 1
> > > +      * output: args[0] =3D temperature in degree celsius. [15:8] in=
teger
> > > part +
> > > +      * [7:5] fractional part
> > > +      */
> > > +     {0, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_DIMM_TEMP_RANGE, num_args =3D 1, response_sz =3D 1
> > > +      * input: args[0] =3D DIMM address[7:0]
> > > +      * output: args[0] =3D refresh rate[3] + temperature range[2:0]
> > > +      */
> > > +     {1, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_DIMM_POWER, num_args =3D 1, response_sz =3D 1
> > > +      * input: args[0] =3D DIMM address[7:0]
> > > +      * output: args[0] =3D DIMM power in mW[31:17] + update rate in
> > > ms[16:8] +
> > > +      * DIMM address[7:0]
> > > +      */
> > > +     {1, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_DIMM_THERMAL, num_args =3D 1, response_sz =3D 1
> > > +      * input: args[0] =3D DIMM address[7:0]
> > > +      * output: args[0] =3D temperature in degree celsius[31:21] + u=
pdate
> > > rate in ms[16:8] +
> > > +      * DIMM address[7:0]
> > > +      */
> > > +     {1, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_SOCKET_FREQ_LIMIT, num_args =3D 0, response_sz =3D =
1
> > > +      * output: args[0] =3D frequency in MHz[31:16] + frequency
> > > source[15:0]
> > > +      */
> > > +     {0, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_CCLK_CORE_LIMIT, num_args =3D 1, response_sz =3D 1
> > > +      * input: args[0] =3D apic id [31:0]
> > > +      * output: args[0] =3D frequency in MHz[31:0]
> > > +      */
> > > +     {1, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_RAILS_SVI, num_args =3D 0, response_sz =3D 1
> > > +      * output: args[0] =3D power in mW[31:0]
> > > +      */
> > > +     {0, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_SOCKET_FMAX_FMIN, num_args =3D 0, response_sz =3D 1
> > > +      * output: args[0] =3D fmax in MHz[31:16] + fmin in MHz[15:0]
> > > +      */
> > > +     {0, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_IOLINK_BANDWITH, num_args =3D 1, response_sz =3D 1
> > > +      * input: args[0] =3D link id[15:8] + bw type[2:0]
> > > +      * output: args[0] =3D io bandwidth in Mbps[31:0]
> > > +      */
> > > +     {1, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_XGMI_BANDWITH, num_args =3D 1, response_sz =3D 1
> > > +      * input: args[0] =3D link id[15:8] + bw type[2:0]
> > > +      * output: args[0] =3D xgmi bandwidth in Mbps[31:0]
> > > +      */
> > > +     {1, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_SET_GMI3_WIDTH, num_args =3D 1, response_sz =3D 0
> > > +      * input: args[0] =3D min link width[15:8] + max link width[7:0=
]
> > > +      */
> > > +     {1, 0, HSMP_SET},
> > > +
> > > +     /*
> > > +      * HSMP_SET_PCI_RATE, num_args =3D 1, response_sz =3D 1
> > > +      * input: args[0] =3D link rate control value
> > > +      * output: args[0] =3D previous link rate control value
> > > +      */
> > > +     {1, 1, HSMP_SET},
> > > +
> > > +     /*
> > > +      * HSMP_SET_POWER_MODE, num_args =3D 1, response_sz =3D 0
> > > +      * input: args[0] =3D power efficiency mode[2:0]
> > > +      */
> > > +     {1, 0, HSMP_SET},
> > > +
> > > +     /*
> > > +      * HSMP_SET_PSTATE_MAX_MIN, num_args =3D 1, response_sz =3D 0
> > > +      * input: args[0] =3D min df pstate[15:8] + max df pstate[7:0]
> > > +      */
> > > +     {1, 0, HSMP_SET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_METRIC_TABLE_VER, num_args =3D 0, response_sz =3D 1
> > > +      * output: args[0] =3D metrics table version
> > > +      */
> > > +     {0, 1, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_METRIC_TABLE, num_args =3D 0, response_sz =3D 0
> > > +      */
> > > +     {0, 0, HSMP_GET},
> > > +
> > > +     /*
> > > +      * HSMP_GET_METRIC_TABLE_DRAM_ADDR, num_args =3D 0, response_sz=
 =3D 2
> > > +      * output: args[0] =3D lower 32 bits of the address
> > > +      * output: args[1] =3D upper 32 bits of the address
> > > +      */
> > > +     {0, 2, HSMP_GET},
> > > +};
> > > +
> > >   /*
> > >    * Send a message to the HSMP port via PCI-e config space registers
> > >    * or by writing to MMIO space.
>=20
> Thanks and Regards,
>=20
> Suma
>=20
--8323328-1493538551-1731406777=:961--

