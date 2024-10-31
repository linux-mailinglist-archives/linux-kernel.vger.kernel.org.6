Return-Path: <linux-kernel+bounces-390296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E289B7809
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B6828989E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E9A1991C2;
	Thu, 31 Oct 2024 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PoK4tQVQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF8419581F;
	Thu, 31 Oct 2024 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368365; cv=none; b=DOQFzOtJ4mzPxuss31wz6ysLtZPKYzaMgagYwO5l7EaMroBD2LorHFDOK3yWUexJh8zgHYCgbE34DrPwC1etu9R/pqqG5VRpvTAZH2LXs2U8ci6gKbzbWH5NmiwiuB6bFGrqcWmsUtFzh6oAENRvQQbkJlJfDNas3mnaqct8E9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368365; c=relaxed/simple;
	bh=b1smCTn4I/y2j/amA5bA7acxeoS1NFp64xphyaolsI8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A95RVwH3X2Y+Zt6U/HMVesl1ggkHoB+Fuf4HAxt19wYZu01TDExS7FERLjuHmCwtnIGTlQAEh7wylKfM5FRRWArffkEa+zqgmR716WuAoFIapN/2T1waRjnaeFxOmCkcRax090XEayMM+4H8T9Hz8Z047YECjFsVyY7TVlXba44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PoK4tQVQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730368361; x=1761904361;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=b1smCTn4I/y2j/amA5bA7acxeoS1NFp64xphyaolsI8=;
  b=PoK4tQVQs0G+t9McQ3Nx4DWlTp3CVFdECIDHOfn0XDsQigx4B+l1pvAj
   cBkG5fHZ+a3MlR9THOIGcu06gvivUida1gQPUH8/qhw+kvfvJSVTwPIW5
   6XUx8xhzciEqfQ3zg5zMarY4ubYX0v1FJEU4m0mOH0mCBJYu+YiyE0HUI
   fPPzVF7f7cgphidW7hnNhNzRDK5gDkdi6AlFFdpMQsHWpPJpa5DmiKZWF
   qzraC4KuNBL+mbpfqYuLlEPzspS3RQj9Vy6k74frmmHrZoT7u9j3IkOmZ
   dGTEOJKkM2t2ZLidas4o0W8iRF+BjwRVJEcndvWPfTUOMiWqwUkAVXhCr
   g==;
X-CSE-ConnectionGUID: 8Gg7jslXRnGfVOXmCIVxJg==
X-CSE-MsgGUID: /ZbDnDrKTsSpCdLjiDHJoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40645355"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40645355"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 02:52:41 -0700
X-CSE-ConnectionGUID: mGPvCDm7SJSlJCXKChK2vA==
X-CSE-MsgGUID: jTTQcuK8TjGl52KuNbbSEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="83382963"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.160])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 02:52:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 31 Oct 2024 11:52:33 +0200 (EET)
To: Arnd Bergmann <arnd@kernel.org>
cc: Hans de Goede <hdegoede@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
    Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, 
    Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    Suma Hegde <suma.hegde@amd.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] platform/x86/amd/hsmp: move hsmp_msg_desc_table[]
 to hsmp.c
In-Reply-To: <20241030210019.2858358-1-arnd@kernel.org>
Message-ID: <582e3574-1823-0c1b-25a8-6a4a6bf73f63@linux.intel.com>
References: <20241030210019.2858358-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1957550909-1730368353=:939"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1957550909-1730368353=:939
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 30 Oct 2024, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> After the file got split, there are now W=3D1 warnings for users that
> include it without referencing hsmp_msg_desc_table:
>=20
> In file included from arch/x86/include/asm/amd_hsmp.h:6,
>                  from drivers/platform/x86/amd/hsmp/plat.c:12:
> arch/x86/include/uapi/asm/amd_hsmp.h:91:35: error: 'hsmp_msg_desc_table' =
defined but not used [-Werror=3Dunused-const-variable=3D]
>    91 | static const struct hsmp_msg_desc hsmp_msg_desc_table[] =3D {
>       |                                   ^~~~~~~~~~~~~~~~~~~
>=20
> The array was never meant to be used by userspace code, but was
> left in the header as a reference for userspace programmers.
>=20
> Move the contents of the array into the one file that actually needs
> it, and instead leave the URL of the new location in the uapi header
> in case anyone is looking for it.
>=20
> Fixes: e47c018a0ee6 ("platform/x86/amd/hsmp: Move platform device specifi=
c code to plat.c")
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Link: https://lore.kernel.org/lkml/046687d8-1e2d-435b-adcb-26897bfd29f7@r=
edhat.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

I'll leave it into patchwork for a few days if somebody has some still=20
unvoiced opinions on this.

--
 i.

> ---
>  arch/x86/include/uapi/asm/amd_hsmp.h | 255 ++-------------------------
>  drivers/platform/x86/amd/hsmp/hsmp.c | 245 +++++++++++++++++++++++++
>  2 files changed, 255 insertions(+), 245 deletions(-)
>=20
> diff --git a/arch/x86/include/uapi/asm/amd_hsmp.h b/arch/x86/include/uapi=
/asm/amd_hsmp.h
> index e5d182c7373c..dfa6aa985ac4 100644
> --- a/arch/x86/include/uapi/asm/amd_hsmp.h
> +++ b/arch/x86/include/uapi/asm/amd_hsmp.h
> @@ -1,5 +1,15 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> =20
> +/*
> + * See hsmp_msg_desc_table[] in:
> + * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/platform/x86/amd/hsmp.c
> + *
> + * for some information on number of input- and output arguments
> + * for the various functions.
> + *
> + * Please find the supported list of messages and message definition
> + * in the HSMP chapter of respective family/model PPR.
> + */
>  #ifndef _UAPI_ASM_X86_AMD_HSMP_H_
>  #define _UAPI_ASM_X86_AMD_HSMP_H_
> =20
> @@ -81,251 +91,6 @@ struct hsmp_msg_desc {
>  =09enum hsmp_msg_type type;
>  };
> =20
> -/*
> - * User may use these comments as reference, please find the
> - * supported list of messages and message definition in the
> - * HSMP chapter of respective family/model PPR.
> - *
> - * Not supported messages would return -ENOMSG.
> - */
> -static const struct hsmp_msg_desc hsmp_msg_desc_table[] =3D {
> -=09/* RESERVED */
> -=09{0, 0, HSMP_RSVD},
> -
> -=09/*
> -=09 * HSMP_TEST, num_args =3D 1, response_sz =3D 1
> -=09 * input:  args[0] =3D xx
> -=09 * output: args[0] =3D xx + 1
> -=09 */
> -=09{1, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_SMU_VER, num_args =3D 0, response_sz =3D 1
> -=09 * output: args[0] =3D smu fw ver
> -=09 */
> -=09{0, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_PROTO_VER, num_args =3D 0, response_sz =3D 1
> -=09 * output: args[0] =3D proto version
> -=09 */
> -=09{0, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_SOCKET_POWER, num_args =3D 0, response_sz =3D 1
> -=09 * output: args[0] =3D socket power in mWatts
> -=09 */
> -=09{0, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_SET_SOCKET_POWER_LIMIT, num_args =3D 1, response_sz =3D 0
> -=09 * input: args[0] =3D power limit value in mWatts
> -=09 */
> -=09{1, 0, HSMP_SET},
> -
> -=09/*
> -=09 * HSMP_GET_SOCKET_POWER_LIMIT, num_args =3D 0, response_sz =3D 1
> -=09 * output: args[0] =3D socket power limit value in mWatts
> -=09 */
> -=09{0, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_SOCKET_POWER_LIMIT_MAX, num_args =3D 0, response_sz =3D 1
> -=09 * output: args[0] =3D maximuam socket power limit in mWatts
> -=09 */
> -=09{0, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_SET_BOOST_LIMIT, num_args =3D 1, response_sz =3D 0
> -=09 * input: args[0] =3D apic id[31:16] + boost limit value in MHz[15:0]
> -=09 */
> -=09{1, 0, HSMP_SET},
> -
> -=09/*
> -=09 * HSMP_SET_BOOST_LIMIT_SOCKET, num_args =3D 1, response_sz =3D 0
> -=09 * input: args[0] =3D boost limit value in MHz
> -=09 */
> -=09{1, 0, HSMP_SET},
> -
> -=09/*
> -=09 * HSMP_GET_BOOST_LIMIT, num_args =3D 1, response_sz =3D 1
> -=09 * input: args[0] =3D apic id
> -=09 * output: args[0] =3D boost limit value in MHz
> -=09 */
> -=09{1, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_PROC_HOT, num_args =3D 0, response_sz =3D 1
> -=09 * output: args[0] =3D proc hot status
> -=09 */
> -=09{0, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_SET_XGMI_LINK_WIDTH, num_args =3D 1, response_sz =3D 0
> -=09 * input: args[0] =3D min link width[15:8] + max link width[7:0]
> -=09 */
> -=09{1, 0, HSMP_SET},
> -
> -=09/*
> -=09 * HSMP_SET_DF_PSTATE, num_args =3D 1, response_sz =3D 0
> -=09 * input: args[0] =3D df pstate[7:0]
> -=09 */
> -=09{1, 0, HSMP_SET},
> -
> -=09/* HSMP_SET_AUTO_DF_PSTATE, num_args =3D 0, response_sz =3D 0 */
> -=09{0, 0, HSMP_SET},
> -
> -=09/*
> -=09 * HSMP_GET_FCLK_MCLK, num_args =3D 0, response_sz =3D 2
> -=09 * output: args[0] =3D fclk in MHz, args[1] =3D mclk in MHz
> -=09 */
> -=09{0, 2, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_CCLK_THROTTLE_LIMIT, num_args =3D 0, response_sz =3D 1
> -=09 * output: args[0] =3D core clock in MHz
> -=09 */
> -=09{0, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_C0_PERCENT, num_args =3D 0, response_sz =3D 1
> -=09 * output: args[0] =3D average c0 residency
> -=09 */
> -=09{0, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_SET_NBIO_DPM_LEVEL, num_args =3D 1, response_sz =3D 0
> -=09 * input: args[0] =3D nbioid[23:16] + max dpm level[15:8] + min dpm l=
evel[7:0]
> -=09 */
> -=09{1, 0, HSMP_SET},
> -
> -=09/*
> -=09 * HSMP_GET_NBIO_DPM_LEVEL, num_args =3D 1, response_sz =3D 1
> -=09 * input: args[0] =3D nbioid[23:16]
> -=09 * output: args[0] =3D max dpm level[15:8] + min dpm level[7:0]
> -=09 */
> -=09{1, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_DDR_BANDWIDTH, num_args =3D 0, response_sz =3D 1
> -=09 * output: args[0] =3D max bw in Gbps[31:20] + utilised bw in Gbps[19=
:8] +
> -=09 * bw in percentage[7:0]
> -=09 */
> -=09{0, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_TEMP_MONITOR, num_args =3D 0, response_sz =3D 1
> -=09 * output: args[0] =3D temperature in degree celsius. [15:8] integer =
part +
> -=09 * [7:5] fractional part
> -=09 */
> -=09{0, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_DIMM_TEMP_RANGE, num_args =3D 1, response_sz =3D 1
> -=09 * input: args[0] =3D DIMM address[7:0]
> -=09 * output: args[0] =3D refresh rate[3] + temperature range[2:0]
> -=09 */
> -=09{1, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_DIMM_POWER, num_args =3D 1, response_sz =3D 1
> -=09 * input: args[0] =3D DIMM address[7:0]
> -=09 * output: args[0] =3D DIMM power in mW[31:17] + update rate in ms[16=
:8] +
> -=09 * DIMM address[7:0]
> -=09 */
> -=09{1, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_DIMM_THERMAL, num_args =3D 1, response_sz =3D 1
> -=09 * input: args[0] =3D DIMM address[7:0]
> -=09 * output: args[0] =3D temperature in degree celsius[31:21] + update =
rate in ms[16:8] +
> -=09 * DIMM address[7:0]
> -=09 */
> -=09{1, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_SOCKET_FREQ_LIMIT, num_args =3D 0, response_sz =3D 1
> -=09 * output: args[0] =3D frequency in MHz[31:16] + frequency source[15:=
0]
> -=09 */
> -=09{0, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_CCLK_CORE_LIMIT, num_args =3D 1, response_sz =3D 1
> -=09 * input: args[0] =3D apic id [31:0]
> -=09 * output: args[0] =3D frequency in MHz[31:0]
> -=09 */
> -=09{1, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_RAILS_SVI, num_args =3D 0, response_sz =3D 1
> -=09 * output: args[0] =3D power in mW[31:0]
> -=09 */
> -=09{0, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_SOCKET_FMAX_FMIN, num_args =3D 0, response_sz =3D 1
> -=09 * output: args[0] =3D fmax in MHz[31:16] + fmin in MHz[15:0]
> -=09 */
> -=09{0, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_IOLINK_BANDWITH, num_args =3D 1, response_sz =3D 1
> -=09 * input: args[0] =3D link id[15:8] + bw type[2:0]
> -=09 * output: args[0] =3D io bandwidth in Mbps[31:0]
> -=09 */
> -=09{1, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_XGMI_BANDWITH, num_args =3D 1, response_sz =3D 1
> -=09 * input: args[0] =3D link id[15:8] + bw type[2:0]
> -=09 * output: args[0] =3D xgmi bandwidth in Mbps[31:0]
> -=09 */
> -=09{1, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_SET_GMI3_WIDTH, num_args =3D 1, response_sz =3D 0
> -=09 * input: args[0] =3D min link width[15:8] + max link width[7:0]
> -=09 */
> -=09{1, 0, HSMP_SET},
> -
> -=09/*
> -=09 * HSMP_SET_PCI_RATE, num_args =3D 1, response_sz =3D 1
> -=09 * input: args[0] =3D link rate control value
> -=09 * output: args[0] =3D previous link rate control value
> -=09 */
> -=09{1, 1, HSMP_SET},
> -
> -=09/*
> -=09 * HSMP_SET_POWER_MODE, num_args =3D 1, response_sz =3D 0
> -=09 * input: args[0] =3D power efficiency mode[2:0]
> -=09 */
> -=09{1, 0, HSMP_SET},
> -
> -=09/*
> -=09 * HSMP_SET_PSTATE_MAX_MIN, num_args =3D 1, response_sz =3D 0
> -=09 * input: args[0] =3D min df pstate[15:8] + max df pstate[7:0]
> -=09 */
> -=09{1, 0, HSMP_SET},
> -
> -=09/*
> -=09 * HSMP_GET_METRIC_TABLE_VER, num_args =3D 0, response_sz =3D 1
> -=09 * output: args[0] =3D metrics table version
> -=09 */
> -=09{0, 1, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_METRIC_TABLE, num_args =3D 0, response_sz =3D 0
> -=09 */
> -=09{0, 0, HSMP_GET},
> -
> -=09/*
> -=09 * HSMP_GET_METRIC_TABLE_DRAM_ADDR, num_args =3D 0, response_sz =3D 2
> -=09 * output: args[0] =3D lower 32 bits of the address
> -=09 * output: args[1] =3D upper 32 bits of the address
> -=09 */
> -=09{0, 2, HSMP_GET},
> -};
> -
>  /* Metrics table (supported only with proto version 6) */
>  struct hsmp_metric_table {
>  =09__u32 accumulation_counter;
> diff --git a/drivers/platform/x86/amd/hsmp/hsmp.c b/drivers/platform/x86/=
amd/hsmp/hsmp.c
> index 82d8ba2e1204..5d21bc8b2fd7 100644
> --- a/drivers/platform/x86/amd/hsmp/hsmp.c
> +++ b/drivers/platform/x86/amd/hsmp/hsmp.c
> @@ -37,6 +37,251 @@
> =20
>  static struct hsmp_plat_device hsmp_pdev;
> =20
> +/*
> + * User may use these comments as reference, please find the
> + * supported list of messages and message definition in the
> + * HSMP chapter of respective family/model PPR.
> + *
> + * Not supported messages would return -ENOMSG.
> + */
> +static const struct hsmp_msg_desc hsmp_msg_desc_table[] =3D {
> +=09/* RESERVED */
> +=09{0, 0, HSMP_RSVD},
> +
> +=09/*
> +=09 * HSMP_TEST, num_args =3D 1, response_sz =3D 1
> +=09 * input:  args[0] =3D xx
> +=09 * output: args[0] =3D xx + 1
> +=09 */
> +=09{1, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_SMU_VER, num_args =3D 0, response_sz =3D 1
> +=09 * output: args[0] =3D smu fw ver
> +=09 */
> +=09{0, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_PROTO_VER, num_args =3D 0, response_sz =3D 1
> +=09 * output: args[0] =3D proto version
> +=09 */
> +=09{0, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_SOCKET_POWER, num_args =3D 0, response_sz =3D 1
> +=09 * output: args[0] =3D socket power in mWatts
> +=09 */
> +=09{0, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_SET_SOCKET_POWER_LIMIT, num_args =3D 1, response_sz =3D 0
> +=09 * input: args[0] =3D power limit value in mWatts
> +=09 */
> +=09{1, 0, HSMP_SET},
> +
> +=09/*
> +=09 * HSMP_GET_SOCKET_POWER_LIMIT, num_args =3D 0, response_sz =3D 1
> +=09 * output: args[0] =3D socket power limit value in mWatts
> +=09 */
> +=09{0, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_SOCKET_POWER_LIMIT_MAX, num_args =3D 0, response_sz =3D 1
> +=09 * output: args[0] =3D maximuam socket power limit in mWatts
> +=09 */
> +=09{0, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_SET_BOOST_LIMIT, num_args =3D 1, response_sz =3D 0
> +=09 * input: args[0] =3D apic id[31:16] + boost limit value in MHz[15:0]
> +=09 */
> +=09{1, 0, HSMP_SET},
> +
> +=09/*
> +=09 * HSMP_SET_BOOST_LIMIT_SOCKET, num_args =3D 1, response_sz =3D 0
> +=09 * input: args[0] =3D boost limit value in MHz
> +=09 */
> +=09{1, 0, HSMP_SET},
> +
> +=09/*
> +=09 * HSMP_GET_BOOST_LIMIT, num_args =3D 1, response_sz =3D 1
> +=09 * input: args[0] =3D apic id
> +=09 * output: args[0] =3D boost limit value in MHz
> +=09 */
> +=09{1, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_PROC_HOT, num_args =3D 0, response_sz =3D 1
> +=09 * output: args[0] =3D proc hot status
> +=09 */
> +=09{0, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_SET_XGMI_LINK_WIDTH, num_args =3D 1, response_sz =3D 0
> +=09 * input: args[0] =3D min link width[15:8] + max link width[7:0]
> +=09 */
> +=09{1, 0, HSMP_SET},
> +
> +=09/*
> +=09 * HSMP_SET_DF_PSTATE, num_args =3D 1, response_sz =3D 0
> +=09 * input: args[0] =3D df pstate[7:0]
> +=09 */
> +=09{1, 0, HSMP_SET},
> +
> +=09/* HSMP_SET_AUTO_DF_PSTATE, num_args =3D 0, response_sz =3D 0 */
> +=09{0, 0, HSMP_SET},
> +
> +=09/*
> +=09 * HSMP_GET_FCLK_MCLK, num_args =3D 0, response_sz =3D 2
> +=09 * output: args[0] =3D fclk in MHz, args[1] =3D mclk in MHz
> +=09 */
> +=09{0, 2, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_CCLK_THROTTLE_LIMIT, num_args =3D 0, response_sz =3D 1
> +=09 * output: args[0] =3D core clock in MHz
> +=09 */
> +=09{0, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_C0_PERCENT, num_args =3D 0, response_sz =3D 1
> +=09 * output: args[0] =3D average c0 residency
> +=09 */
> +=09{0, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_SET_NBIO_DPM_LEVEL, num_args =3D 1, response_sz =3D 0
> +=09 * input: args[0] =3D nbioid[23:16] + max dpm level[15:8] + min dpm l=
evel[7:0]
> +=09 */
> +=09{1, 0, HSMP_SET},
> +
> +=09/*
> +=09 * HSMP_GET_NBIO_DPM_LEVEL, num_args =3D 1, response_sz =3D 1
> +=09 * input: args[0] =3D nbioid[23:16]
> +=09 * output: args[0] =3D max dpm level[15:8] + min dpm level[7:0]
> +=09 */
> +=09{1, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_DDR_BANDWIDTH, num_args =3D 0, response_sz =3D 1
> +=09 * output: args[0] =3D max bw in Gbps[31:20] + utilised bw in Gbps[19=
:8] +
> +=09 * bw in percentage[7:0]
> +=09 */
> +=09{0, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_TEMP_MONITOR, num_args =3D 0, response_sz =3D 1
> +=09 * output: args[0] =3D temperature in degree celsius. [15:8] integer =
part +
> +=09 * [7:5] fractional part
> +=09 */
> +=09{0, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_DIMM_TEMP_RANGE, num_args =3D 1, response_sz =3D 1
> +=09 * input: args[0] =3D DIMM address[7:0]
> +=09 * output: args[0] =3D refresh rate[3] + temperature range[2:0]
> +=09 */
> +=09{1, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_DIMM_POWER, num_args =3D 1, response_sz =3D 1
> +=09 * input: args[0] =3D DIMM address[7:0]
> +=09 * output: args[0] =3D DIMM power in mW[31:17] + update rate in ms[16=
:8] +
> +=09 * DIMM address[7:0]
> +=09 */
> +=09{1, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_DIMM_THERMAL, num_args =3D 1, response_sz =3D 1
> +=09 * input: args[0] =3D DIMM address[7:0]
> +=09 * output: args[0] =3D temperature in degree celsius[31:21] + update =
rate in ms[16:8] +
> +=09 * DIMM address[7:0]
> +=09 */
> +=09{1, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_SOCKET_FREQ_LIMIT, num_args =3D 0, response_sz =3D 1
> +=09 * output: args[0] =3D frequency in MHz[31:16] + frequency source[15:=
0]
> +=09 */
> +=09{0, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_CCLK_CORE_LIMIT, num_args =3D 1, response_sz =3D 1
> +=09 * input: args[0] =3D apic id [31:0]
> +=09 * output: args[0] =3D frequency in MHz[31:0]
> +=09 */
> +=09{1, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_RAILS_SVI, num_args =3D 0, response_sz =3D 1
> +=09 * output: args[0] =3D power in mW[31:0]
> +=09 */
> +=09{0, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_SOCKET_FMAX_FMIN, num_args =3D 0, response_sz =3D 1
> +=09 * output: args[0] =3D fmax in MHz[31:16] + fmin in MHz[15:0]
> +=09 */
> +=09{0, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_IOLINK_BANDWITH, num_args =3D 1, response_sz =3D 1
> +=09 * input: args[0] =3D link id[15:8] + bw type[2:0]
> +=09 * output: args[0] =3D io bandwidth in Mbps[31:0]
> +=09 */
> +=09{1, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_XGMI_BANDWITH, num_args =3D 1, response_sz =3D 1
> +=09 * input: args[0] =3D link id[15:8] + bw type[2:0]
> +=09 * output: args[0] =3D xgmi bandwidth in Mbps[31:0]
> +=09 */
> +=09{1, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_SET_GMI3_WIDTH, num_args =3D 1, response_sz =3D 0
> +=09 * input: args[0] =3D min link width[15:8] + max link width[7:0]
> +=09 */
> +=09{1, 0, HSMP_SET},
> +
> +=09/*
> +=09 * HSMP_SET_PCI_RATE, num_args =3D 1, response_sz =3D 1
> +=09 * input: args[0] =3D link rate control value
> +=09 * output: args[0] =3D previous link rate control value
> +=09 */
> +=09{1, 1, HSMP_SET},
> +
> +=09/*
> +=09 * HSMP_SET_POWER_MODE, num_args =3D 1, response_sz =3D 0
> +=09 * input: args[0] =3D power efficiency mode[2:0]
> +=09 */
> +=09{1, 0, HSMP_SET},
> +
> +=09/*
> +=09 * HSMP_SET_PSTATE_MAX_MIN, num_args =3D 1, response_sz =3D 0
> +=09 * input: args[0] =3D min df pstate[15:8] + max df pstate[7:0]
> +=09 */
> +=09{1, 0, HSMP_SET},
> +
> +=09/*
> +=09 * HSMP_GET_METRIC_TABLE_VER, num_args =3D 0, response_sz =3D 1
> +=09 * output: args[0] =3D metrics table version
> +=09 */
> +=09{0, 1, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_METRIC_TABLE, num_args =3D 0, response_sz =3D 0
> +=09 */
> +=09{0, 0, HSMP_GET},
> +
> +=09/*
> +=09 * HSMP_GET_METRIC_TABLE_DRAM_ADDR, num_args =3D 0, response_sz =3D 2
> +=09 * output: args[0] =3D lower 32 bits of the address
> +=09 * output: args[1] =3D upper 32 bits of the address
> +=09 */
> +=09{0, 2, HSMP_GET},
> +};
> +
>  /*
>   * Send a message to the HSMP port via PCI-e config space registers
>   * or by writing to MMIO space.
>=20
--8323328-1957550909-1730368353=:939--

