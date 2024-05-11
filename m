Return-Path: <linux-kernel+bounces-176622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304CB8C3244
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 17:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1ED71F219E6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C9456772;
	Sat, 11 May 2024 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="L8duePli";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AmPZo2F9"
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130138DD3;
	Sat, 11 May 2024 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715443165; cv=none; b=rfaHp2tU3sZ2CjSoDw7Lw+QeVMpTk5YCaRorqdT9GrLtNKQJA+WbxaI7rgSN4vyi7IRAH0zSbT0If8P3W8cGV732E5vB8vMBdjzRD8IfiDctEO1nBMZy1JflgaFQ0zOFozXirEmcyKAZVuFud9pY18jnPq6RQUTvKkSsbyDgwHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715443165; c=relaxed/simple;
	bh=8fdI5btSJ8wBtS+ARNjrMABQaygaLLumhMpn15wsBlE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZOyVX4zIND6976i4+EGYsv/w/e61Zpvg4GzljTLPyK3tdOm0hWe6yUVZ5dbuAd2IhVG46Vv0JsmHl0UV4nI5w5H1qfFuSAjcz+SnYcQAqwvlaF8TH/jBABc7Af2TTeD3Qbfk7zp2L2LklvkXGIM+zVPb7eRQcNflqzjOLSqjs5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=L8duePli; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AmPZo2F9; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6252A18000A6;
	Sat, 11 May 2024 11:59:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 11 May 2024 11:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1715443161;
	 x=1715529561; bh=AsFLjIbl1PlnGOLMFGf5URbJHr0n2Ljb5G43R67ojGU=; b=
	L8duePlini7wnBp8r5ZKtH55+0A+dHyfTB4XR3LgYjX5/EaKiIvTIdxU+1JO+dLB
	xlRX8QUUzJOJYRLzvqWWvjElUqfNB9plCQIjCVhFwqImQ0Ea9iUjbvStBOHpu8XM
	GnuI5opyWpNrU68sjwQT64TscmWtGoRZDJ0vE6hCxV3S2eW4V+byCMFLA3OxlTv6
	4yH3o9KSW1jU6TJ/UoD8C/iPweYHOEl7pb1Oz+JotN8PFlSnjJB7dK3G0CrBahNv
	PpwAAoAojkFd6kif/UbCTaPjP6ysbulHyB801TikEn7ojo1wEUKDdogzbPMIs/wp
	vfc7l7DVxDEW/dYh/1pHxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715443161; x=
	1715529561; bh=AsFLjIbl1PlnGOLMFGf5URbJHr0n2Ljb5G43R67ojGU=; b=A
	mPZo2F9zFYcQEDsunsYhM6yUrb+v9BcWmVJwveGrLsmGUqpZNfugn8h5x6x4Rl6N
	reANyv4qrIECEflICek4qqccDyGmkkoVw3bzznN653lQjjHcqwge0eO56C6tfjej
	sIxFFCvBPbyMCy6zrji4+FvWS7S7ciLjAye6/5kqoyr9lrttozampJTKwQ46TmxI
	4M6HtAZU/qLnP25n9ktlCeg460m6Xyg9y87ICuYMA4HnmxfjpxBWXHAG+tV9gKSC
	HSRTrgfQjySAkouyiP6YrJV+UGhX9fRB08dsAst5GSLlGfqKQaVyXPdQQRA2dn9A
	tDnyGYzuhYwt5WZrPbiyA==
X-ME-Sender: <xms:2JU_ZrrmKWqOmmqUg0f46-ExkGDLLkBCi3FrzWb5RZlVhGu-Em0aOg>
    <xme:2JU_Zlp1kCC21eNJxDumYb7E5AlhQaxQWGof5NAyTFeT48tHUZuO7xz8zzTf_HYOy
    6oQHccSms2Hs_wb9wM>
X-ME-Received: <xmr:2JU_ZoMrSdkyIwAacnmtE38cUtkUZuH2aVaTV1iXidBuzXRa-UGD8M74JY9zPjzBPuiPK05SDJl4wEzAoo64xXDaAIdK_GIaBYM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegtddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgfjghfkfggtgfgsehtqhhmtddtreejnecuhfhrohhmpefnhihn
    ughonhcuufgrnhgthhgvuceolhhsrghntghhvgeslhihnhguvghnohdrtggrqeenucggtf
    frrghtthgvrhhnpeetieduveegueffhfefudetjeegtdefffehvdelveelueeviedukedu
    tdejkeevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehlshgrnhgthhgvsehlhihnuggvnhhordgtrg
X-ME-Proxy: <xmx:2JU_Zu6k5jyXk-ZKSwHj8XE0LsRV_RVXXF9DaC2otl-EsE9Es3gc-A>
    <xmx:2JU_Zq7RDdLTuVrNYkzvsqlJitNvSN9hcgywgNEY28b0Zk5NOgtzVQ>
    <xmx:2JU_Zmg3k4uvbKJxqdE2lwO8_CguaRsioejS6FxRSRUY7gr87Gn2xA>
    <xmx:2JU_Zs6Y82e6659nqK2whNHzW7jco463wjx_c5kLaPrbN1xjWK2_kQ>
    <xmx:2ZU_ZmrTduj4nUPvRzuiMBhj7QIak-Ng2xE5xaO02iF_F7R5zecPtCiP>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 May 2024 11:59:19 -0400 (EDT)
Date: Sat, 11 May 2024 09:59:17 -0600
From: Lyndon Sanche <lsanche@lyndeno.ca>
To: "Limonciello, Mario" <mario.limonciello@amd.com>
CC: pali@kernel.org, W_Armin@gmx.de, srinivas.pandruvada@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, lkp@intel.com, hdegoede@redhat.com,
 Yijun.Shen@dell.com, Matthew Garrett <mjg59@srcf.ucam.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>, Vegard Nossum <vegard.nossum@oracle.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_2/2=5D_platform/x86=3A_del?=
 =?US-ASCII?Q?l-laptop=3A_Implement_platform=5Fprofile?=
User-Agent: K-9 Mail for Android
In-Reply-To: <9ba4a500-9d88-4630-bd94-99f07dd51abe@amd.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca> <20240511023726.7408-4-lsanche@lyndeno.ca> <9ba4a500-9d88-4630-bd94-99f07dd51abe@amd.com>
Message-ID: <B3AA4333-03DC-47D6-9519-7FA9496220E5@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On May 11, 2024 9:16:56=E2=80=AFa=2Em=2E MDT, "Limonciello, Mario" <mario=
=2Elimonciello@amd=2Ecom> wrote:
>
>
>On 5/10/2024 9:36 PM, Lyndon Sanche wrote:
>> Some Dell laptops support configuration of preset fan modes through
>> smbios tables=2E
>>=20
>> If the platform supports these fan modes, set up platform_profile to
>> change these modes=2E If not supported, skip enabling platform_profile=
=2E
>>=20
>> Signed-off-by: Lyndon Sanche <lsanche@lyndeno=2Eca>
>> ---
>>   drivers/platform/x86/dell/Kconfig            |   2 +
>>   drivers/platform/x86/dell/dell-laptop=2Ec      | 242 ++++++++++++++++=
+++
>>   drivers/platform/x86/dell/dell-smbios-base=2Ec |   1 +
>>   drivers/platform/x86/dell/dell-smbios=2Eh      |   1 +
>>   4 files changed, 246 insertions(+)
>>=20
>> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/d=
ell/Kconfig
>> index bd9f445974cc=2E=2E26679f22733c 100644
>> --- a/drivers/platform/x86/dell/Kconfig
>> +++ b/drivers/platform/x86/dell/Kconfig
>> @@ -47,6 +47,7 @@ config DCDBAS
>>   config DELL_LAPTOP
>>   	tristate "Dell Laptop Extras"
>>   	default m
>> +	depends on ACPI
>>   	depends on DMI
>>   	depends on BACKLIGHT_CLASS_DEVICE
>>   	depends on ACPI_VIDEO || ACPI_VIDEO =3D n
>> @@ -57,6 +58,7 @@ config DELL_LAPTOP
>>   	select POWER_SUPPLY
>>   	select LEDS_CLASS
>>   	select NEW_LEDS
>> +	select ACPI_PLATFORM_PROFILE
>>   	help
>>   	This driver adds support for rfkill and backlight control to Dell
>>   	laptops (except for some models covered by the Compal driver)=2E
>> diff --git a/drivers/platform/x86/dell/dell-laptop=2Ec b/drivers/platfo=
rm/x86/dell/dell-laptop=2Ec
>> index 42f7de2b4522=2E=2E07f54f1cbac5 100644
>> --- a/drivers/platform/x86/dell/dell-laptop=2Ec
>> +++ b/drivers/platform/x86/dell/dell-laptop=2Ec
>> @@ -27,6 +27,9 @@
>>   #include <linux/i8042=2Eh>
>>   #include <linux/debugfs=2Eh>
>>   #include <linux/seq_file=2Eh>
>> +#include <linux/bitfield=2Eh>
>> +#include <linux/bits=2Eh>
>> +#include <linux/platform_profile=2Eh>
>>   #include <acpi/video=2Eh>
>>   #include "dell-rbtn=2Eh"
>>   #include "dell-smbios=2Eh"
>> @@ -95,6 +98,7 @@ static struct backlight_device *dell_backlight_device=
;
>>   static struct rfkill *wifi_rfkill;
>>   static struct rfkill *bluetooth_rfkill;
>>   static struct rfkill *wwan_rfkill;
>> +static struct platform_profile_handler *thermal_handler;
>>   static bool force_rfkill;
>>   static bool micmute_led_registered;
>>   static bool mute_led_registered;
>> @@ -2199,6 +2203,236 @@ static int mute_led_set(struct led_classdev *le=
d_cdev,
>>   	return 0;
>>   }
>>   +/* Derived from smbios-thermal-ctl
>> + *
>> + * cbClass 17
>> + * cbSelect 19
>> + * User Selectable Thermal Tables(USTT)
>> + * cbArg1 determines the function to be performed
>> + * cbArg1 0x0 =3D Get Thermal Information
>> + *  cbRES1         Standard return codes (0, -1, -2)
>> + *  cbRES2, byte 0  Bitmap of supported thermal modes=2E A mode is sup=
ported if
>> + *                  its bit is set to 1
>> + *     Bit 0 Balanced
>> + *     Bit 1 Cool Bottom
>> + *     Bit 2 Quiet
>> + *     Bit 3 Performance
>> + *  cbRES2, byte 1 Bitmap of supported Active Acoustic Controller (AAC=
) modes=2E
>> + *                 Each mode corresponds to the supported thermal mode=
s in
>> + *                  byte 0=2E A mode is supported if its bit is set to=
 1=2E
>> + *     Bit 0 AAC (Balanced)
>> + *     Bit 1 AAC (Cool Bottom
>> + *     Bit 2 AAC (Quiet)
>> + *     Bit 3 AAC (Performance)
>> + *  cbRes3, byte 0 Current Thermal Mode
>> + *     Bit 0 Balanced
>> + *     Bit 1 Cool Bottom
>> + *     Bit 2 Quiet
>> + *     Bit 3 Performanc
>> + *  cbRes3, byte 1  AAC Configuration type
>> + *          0       Global (AAC enable/disable applies to all supporte=
d USTT modes)
>> + *          1       USTT mode specific
>> + *  cbRes3, byte 2  Current Active Acoustic Controller (AAC) Mode
>> + *     If AAC Configuration Type is Global,
>> + *          0       AAC mode disabled
>> + *          1       AAC mode enabled
>> + *     If AAC Configuration Type is USTT mode specific (multiple bits =
may be set),
>> + *          Bit 0 AAC (Balanced)
>> + *          Bit 1 AAC (Cool Bottom
>> + *          Bit 2 AAC (Quiet)
>> + *          Bit 3 AAC (Performance)
>> + *  cbRes3, byte 3  Current Fan Failure Mode
>> + *     Bit 0 Minimal Fan Failure (at least one fan has failed, one fan=
 working)
>> + *     Bit 1 Catastrophic Fan Failure (all fans have failed)
>> + *
>> + * cbArg1 0x1   (Set Thermal Information), both desired thermal mode a=
nd
>> + *               desired AAC mode shall be applied
>> + * cbArg2, byte 0  Desired Thermal Mode to set
>> + *                  (only one bit may be set for this parameter)
>> + *     Bit 0 Balanced
>> + *     Bit 1 Cool Bottom
>> + *     Bit 2 Quiet
>> + *     Bit 3 Performance
>> + * cbArg2, byte 1  Desired Active Acoustic Controller (AAC) Mode to se=
t
>> + *     If AAC Configuration Type is Global,
>> + *         0  AAC mode disabled
>> + *         1  AAC mode enabled
>> + *     If AAC Configuration Type is USTT mode specific
>> + *     (multiple bits may be set for this parameter),
>> + *         Bit 0 AAC (Balanced)
>> + *         Bit 1 AAC (Cool Bottom
>> + *         Bit 2 AAC (Quiet)
>> + *         Bit 3 AAC (Performance)
>> + */
>> +
>> +#define DELL_ACC_GET_FIELD		GENMASK(19, 16)
>> +#define DELL_ACC_SET_FIELD		GENMASK(11, 8)
>> +#define DELL_THERMAL_SUPPORTED	GENMASK(3, 0)
>> +
>> +enum thermal_mode_bits {
>> +	DELL_BALANCED =3D BIT(0),
>> +	DELL_COOL_BOTTOM =3D BIT(1),
>> +	DELL_QUIET =3D BIT(2),
>> +	DELL_PERFORMANCE =3D BIT(3),
>> +};
>> +
>> +static int thermal_get_mode(void)
>> +{
>> +	struct calling_interface_buffer buffer;
>> +	int state;
>> +	int ret;
>> +
>> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
>> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEM=
ENT);
>> +	if (ret)
>> +		return ret;
>> +	state =3D buffer=2Eoutput[2];
>> +	if (state & DELL_BALANCED)
>> +		return DELL_BALANCED;
>> +	else if (state & DELL_COOL_BOTTOM)
>> +		return DELL_COOL_BOTTOM;
>> +	else if (state & DELL_QUIET)
>> +		return DELL_QUIET;
>> +	else if (state & DELL_PERFORMANCE)
>> +		return DELL_PERFORMANCE;
>> +	else
>> +		return -ENXIO;
>> +}
>> +
>> +static int thermal_get_supported_modes(int *supported_bits)
>> +{
>> +	struct calling_interface_buffer buffer;
>> +	int ret;
>> +
>> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
>> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEM=
ENT);
>> +	if (ret)
>> +		return ret;
>> +	*supported_bits =3D FIELD_GET(DELL_THERMAL_SUPPORTED, buffer=2Eoutput=
[1]);
>> +	return 0;
>> +}
>> +
>> +static int thermal_get_acc_mode(int *acc_mode)
>> +{
>> +	struct calling_interface_buffer buffer;
>> +	int ret;
>> +
>> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
>> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEM=
ENT);
>> +	if (ret)
>> +		return ret;
>> +	*acc_mode =3D FIELD_GET(DELL_ACC_GET_FIELD, buffer=2Eoutput[3]);
>> +	return 0;
>> +}
>> +
>> +static int thermal_set_mode(enum thermal_mode_bits state)
>> +{
>> +	struct calling_interface_buffer buffer;
>> +	int ret;
>> +	int acc_mode;
>> +
>> +	ret =3D thermal_get_acc_mode(&acc_mode);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dell_fill_request(&buffer, 0x1, FIELD_PREP(DELL_ACC_SET_FIELD, acc_mo=
de) | state, 0, 0);
>> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEM=
ENT);
>> +	return ret;
>> +}
>> +
>> +static int thermal_platform_profile_set(struct platform_profile_handle=
r *pprof,
>> +					enum platform_profile_option profile)
>> +{
>> +	switch (profile) {
>> +	case PLATFORM_PROFILE_BALANCED:
>> +		return thermal_set_mode(DELL_BALANCED);
>> +	case PLATFORM_PROFILE_PERFORMANCE:
>> +		return thermal_set_mode(DELL_PERFORMANCE);
>> +	case PLATFORM_PROFILE_QUIET:
>> +		return thermal_set_mode(DELL_QUIET);
>> +	case PLATFORM_PROFILE_COOL:
>> +		return thermal_set_mode(DELL_COOL_BOTTOM);
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +}
>> +
>> +static int thermal_platform_profile_get(struct platform_profile_handle=
r *pprof,
>> +					enum platform_profile_option *profile)
>> +{
>> +	int ret;
>> +
>> +	ret =3D thermal_get_mode();
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	switch (ret) {
>> +	case DELL_BALANCED:
>> +		*profile =3D PLATFORM_PROFILE_BALANCED;
>> +		break;
>> +	case DELL_PERFORMANCE:
>> +		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
>> +		break;
>> +	case DELL_COOL_BOTTOM:
>> +		*profile =3D PLATFORM_PROFILE_COOL;
>> +		break;
>> +	case DELL_QUIET:
>> +		*profile =3D PLATFORM_PROFILE_QUIET;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int thermal_init(void)
>> +{
>> +	int ret;
>> +	int supported_modes;
>> +
>> +	/* If thermal commands not supported, exit without error */
>> +	if (!dell_laptop_check_supported_cmds(CLASS_INFO))
>> +		return 0;
>> +
>> +	/* If thermal modes not supported, exit without error */
>> +	ret =3D thermal_get_supported_modes(&supported_modes);
>> +	if (ret < 0)
>> +		return ret;
>> +	if (!supported_modes)
>> +		return 0;
>> +
>> +	thermal_handler =3D kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
>> +	if (!thermal_handler)
>> +		return -ENOMEM;
>> +	thermal_handler->profile_get =3D thermal_platform_profile_get;
>> +	thermal_handler->profile_set =3D thermal_platform_profile_set;
>> +
>> +	if (supported_modes & DELL_QUIET)
>> +		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
>> +	if (supported_modes & DELL_COOL_BOTTOM)
>> +		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
>> +	if (supported_modes & DELL_BALANCED)
>> +		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
>> +	if (supported_modes & DELL_PERFORMANCE)
>> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
>> +
>> +	/* Clean up if failed */
>> +	ret =3D platform_profile_register(thermal_handler);
>> +	if (ret)
>> +		kfree(thermal_handler);
>> +
>> +	return ret;
>> +}
>> +
>> +static void thermal_cleanup(void)
>> +{
>> +	if (thermal_handler) {
>> +		platform_profile_remove();
>> +		kfree(thermal_handler);
>> +	}
>> +}
>> +
>>   static struct led_classdev mute_led_cdev =3D {
>>   	=2Ename =3D "platform::mute",
>>   	=2Emax_brightness =3D 1,
>> @@ -2238,6 +2472,11 @@ static int __init dell_init(void)
>>   		goto fail_rfkill;
>>   	}
>>   +	/* Do not fail module if thermal modes not supported, just skip */
>> +	ret =3D thermal_init();
>> +	if (ret)
>> +		goto fail_thermal;
>> +
>>   	if (quirks && quirks->touchpad_led)
>>   		touchpad_led_init(&platform_device->dev);
>>   @@ -2317,6 +2556,8 @@ static int __init dell_init(void)
>>   		led_classdev_unregister(&mute_led_cdev);
>>   fail_led:
>>   	dell_cleanup_rfkill();
>> +fail_thermal:
>> +	thermal_cleanup();
>>   fail_rfkill:
>>   	platform_device_del(platform_device);
>>   fail_platform_device2:
>> @@ -2344,6 +2585,7 @@ static void __exit dell_exit(void)
>>   		platform_device_unregister(platform_device);
>>   		platform_driver_unregister(&platform_driver);
>>   	}
>> +	thermal_cleanup();
>>   }
>>     /* dell-rbtn=2Ec driver export functions which will not work correc=
tly (and could
>> diff --git a/drivers/platform/x86/dell/dell-smbios-base=2Ec b/drivers/p=
latform/x86/dell/dell-smbios-base=2Ec
>> index 6ae09d7f76fb=2E=2E387fa5618f7a 100644
>> --- a/drivers/platform/x86/dell/dell-smbios-base=2Ec
>> +++ b/drivers/platform/x86/dell/dell-smbios-base=2Ec
>> @@ -71,6 +71,7 @@ static struct smbios_call call_blacklist[] =3D {
>>   	/* handled by kernel: dell-laptop */
>>   	{0x0000, CLASS_INFO, SELECT_RFKILL},
>>   	{0x0000, CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT},
>> +	{0x0000, CLASS_INFO, SELECT_THERMAL_MANAGEMENT},
>>   };
>
>So when Alex checked on v5 that this doesn't load on workstations, it has=
 made me realize that doing this will block the interface totally even on w=
orkstations=2E
>
>So I think there are a few ways to go to handle this:
>
>1) Rename dell-laptop to dell-client or dell-pc and let dell-laptop load =
on more form factors=2E  This would require some internal handling in the m=
odule for which features make sense for different form factors=2E
>
>2) Add a new module just for the thermal handling and put all this code i=
nto it instead=2E
>
>I don't have a strong opinion, but I do think one of them should be done =
to ensure there aren't problems on workstations losing access to thermal co=
ntrol=2E
>

A dell-client/laptop separation makes more sense IMO=2E I don't think keyb=
oard control would belong in a the dell-client module either=2E Separating =
just thermal control would be easier, but not as clean I think=2E

Thanks,

Lyndon

