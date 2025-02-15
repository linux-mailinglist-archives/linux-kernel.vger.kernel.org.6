Return-Path: <linux-kernel+bounces-515955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 533D6A36B05
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1EFA3B1EEA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0C715A842;
	Sat, 15 Feb 2025 01:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/pEEj8S"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A332151985;
	Sat, 15 Feb 2025 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739583036; cv=none; b=TIzCzsGTitnrclWl8keF/qBwYKoewA4IHm5RKCtR5C2tL4Hby81+8ER3cN0lPjZ4bkxM75/jqdpXnCSRB1MzTb3Zyr9UOZtgGYBiGzNulBnWVFREXcahk5FZf1Ze5FHO7B5PV6WANLGworAM5x0ScePzLw1qqsbDqMvnhM2u5Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739583036; c=relaxed/simple;
	bh=Spjd0+CPKcnwg6LOWxgLFJqDtJsQv/sjsOlQKMMo/oU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=cN6zN+S+793hLqc0qupQkgXkHTK07YkeJbGcrTL+E+FVH45MskUds5LDMHYCJh+m0Fv8MjQX4H1bIp99Ca/WN//XzvPt7mC88u8LmMnuH1Zw56Z2AhdHlgS4XGtTGSd8P2+V0chVd0flCEnBht8LC+u7SQ8hTAXjdc31hCKFsC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/pEEj8S; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-51eb1818d4fso1700948e0c.1;
        Fri, 14 Feb 2025 17:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739583033; x=1740187833; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSGM5ho1Yts9mu8HW67wgopxLYvRJsKN317227YXOfo=;
        b=G/pEEj8SCv6HLLY9k/9u5FmsNOM6uJzYwdturi8zXkbEhd68NJ6aeS4CFI6XT8DcnU
         u/lbsSljclOGEPDwHIbOpVeWrcjxyybwL7dVevU1mDY2QiefeigPBKwPlQEEE96u2clR
         0ulcJRwWqwTtuyP79NffxTCqyxOUn+gjQHlIpgcs1kwHw50PhGMhO+u0bIzWQKSK2F+h
         dWNNZGsMcV6UxAThWxvIU99cfp1Ab0m8hmWmZFnV7VhSMtC7y9wppSvQT/oDxauFHX6/
         C6RH7b87av2aUmj6TAX50z3iTzX47n58U1JbkUhyzcbX6LkZGbDgdvjtwQxNiIuZYeaQ
         lKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739583033; x=1740187833;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TSGM5ho1Yts9mu8HW67wgopxLYvRJsKN317227YXOfo=;
        b=QhnfJtFnKjqN/6cMQnDnjoOdQHxJr8n7rXI2pyVvxrZxNMeByjHK8rcKM23GqvTNQx
         SwPr6uRIraCpTtnRSRDPzwivB+sz1ah6/hqfym7mrlPud+t7BeyPBBqfT1pRQtwFLuGC
         k37qxwPCwOs5esH7wSlDoYMqQuJw4sEDysUsjp/cXVHNGPS4oCTckSs88a8j+0rFFNBM
         D8c040yyNrMuViNwiJUFBhcS/q3AHkx8lYj7kelZAWx+XbCnn2zPYwH/8GL+p4A1RdxZ
         Mji0ajvFPiERPTFCGG37qWpV+N/LE8DMo52xB8+5zOsRhfCSK+HGN8UgVWMLmiXe3kQP
         rmIg==
X-Forwarded-Encrypted: i=1; AJvYcCVc/8RyeqcUTqfmgRmuRBfALLlmPmYu7hbmaKjRxueOYqdaDPL6O5zth7sUfq1Hllgq+AHa1UR2un6h13L6imqlAjqnpw==@vger.kernel.org, AJvYcCVmtOSNQKrs+/6Zqf5+9LTzHoyTfkzcW7ovjLDuIlz/azAK3QUq1vOAQBQFWPhFAAZOa9HPOKJOV9c8pUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz85qUvRCpKywJUW0z1b0vcchuNMa2PD7CM4603Id9qCai+7b1
	23WCjMw4x1mAG+opRCLI+FGMpGfiw25d8ob3nRI/yNU0gJA0f4Ja
X-Gm-Gg: ASbGncuWp9ipHWeP/g6BxLdv7LMmIxld9vMkrXSKaDwb9sZQVwj3MRLpKBZgAUlrdWn
	i8y2DUwvXfa4/n6bs5+pYyKW6nOrSOZnFrkcu1I4oo6IRCAtTwdlzBwOacnAPW4fCFawGCgxGeu
	2q4ynrG6+UfGYE42edMHJgIyeoi57xNQyQjwSYX2kaewm6Sw997soDZs9kAlB3324Oa7uXc4bQj
	F6rtVnWQCFoat6zP6AMAAkf3VIAYq3AYoYAii4ymNZ0mvOqoBnkDoqwsZORvn44g3RK8DJW76Xe
	BE+OYtE=
X-Google-Smtp-Source: AGHT+IHqvEQ4auzkcaLR2teW9yEnTAwZ5BacKnVAy+LW2WTgyrGiPtTi7NFoVsIbxQj+wr4MPSvXsg==
X-Received: by 2002:a05:6122:2701:b0:520:6773:e5ba with SMTP id 71dfb90a1353d-5209da6bf7emr868075e0c.2.1739583033152;
        Fri, 14 Feb 2025 17:30:33 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52097e27968sm463557e0c.18.2025.02.14.17.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 17:30:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Feb 2025 20:30:30 -0500
Message-Id: <D7SMPVK7KM8E.3VYTBGLEVS109@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Armin Wolf" <W_Armin@gmx.de>, <jlee@suse.com>,
 <basak.sb2006@gmail.com>, <rayanmargham4@gmail.com>
Cc: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
 <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] platform/x86: acer-wmi: Fix setting of fan
 behavior
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250214221322.47298-1-W_Armin@gmx.de>
 <20250214221322.47298-2-W_Armin@gmx.de>
In-Reply-To: <20250214221322.47298-2-W_Armin@gmx.de>

Hi Armin,

On Fri Feb 14, 2025 at 5:13 PM -05, Armin Wolf wrote:
> After studying the linuwu_sense driver
> (https://github.com/0x7375646F/Linuwu-Sense) i was able to understand
> the meaning of the SetGamingFanBehavior() WMI method:
>
> - the first 16-bit are a bitmap of all fans affected by a fan behavior
>   change request.
>
> - the next 8 bits contain four fan mode fields (2-bit), each being
>   associated with a bit inside the fan bitmap.
>
> There are three fan modes: auto, turbo and custom.
>
> Use this newfound knowledge to fix the turbo fan handling by setting
> the correct bits before calling SetGamingFanBehavior(). Also check
> the result of the WMI method call and return an error should the ACPI
> firmware signal failure.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/acer-wmi.c | 75 +++++++++++++++++++++++----------
>  1 file changed, 52 insertions(+), 23 deletions(-)
>
> --
> 2.39.5
>
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-=
wmi.c
> index 69336bd778ee..f20a882e3650 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -68,10 +68,19 @@ MODULE_LICENSE("GPL");
>  #define ACER_WMID_SET_GAMING_LED_METHODID 2
>  #define ACER_WMID_GET_GAMING_LED_METHODID 4
>  #define ACER_WMID_GET_GAMING_SYS_INFO_METHODID 5
> -#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR 14
> +#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID 14
>  #define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
>  #define ACER_WMID_GET_GAMING_MISC_SETTING_METHODID 23
>
> +#define ACER_GAMING_FAN_BEHAVIOR_ID_MASK GENMASK_ULL(15, 0)
> +#define ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK GENMASK_ULL(23, 16)
> +
> +#define ACER_GAMING_FAN_BEHAVIOR_CPU BIT(0)
> +#define ACER_GAMING_FAN_BEHAVIOR_GPU BIT(3)
> +
> +#define ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK GENMASK(1, 0)
> +#define ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK GENMASK(7, 6)
> +
>  #define ACER_GAMING_MISC_SETTING_STATUS_MASK GENMASK_ULL(7, 0)
>  #define ACER_GAMING_MISC_SETTING_INDEX_MASK GENMASK_ULL(7, 0)
>  #define ACER_GAMING_MISC_SETTING_VALUE_MASK GENMASK_ULL(15, 8)
> @@ -121,6 +130,12 @@ enum acer_wmi_predator_v4_sensor_id {
>  	ACER_WMID_SENSOR_GPU_TEMPERATURE	=3D 0x0A,
>  };
>
> +enum acer_wmi_gaming_fan_mode {
> +	ACER_WMID_FAN_MODE_AUTO		=3D 0x01,
> +	ACER_WMID_FAN_MODE_TURBO	=3D 0x02,
> +	ACER_WMID_FAN_MODE_CUSTOM	=3D 0x03,
> +};
> +
>  enum acer_wmi_predator_v4_oc {
>  	ACER_WMID_OC_NORMAL			=3D 0x0000,
>  	ACER_WMID_OC_TURBO			=3D 0x0002,
> @@ -1565,9 +1580,6 @@ static acpi_status WMID_gaming_set_u64(u64 value, u=
32 cap)
>  	case ACER_CAP_TURBO_LED:
>  		method_id =3D ACER_WMID_SET_GAMING_LED_METHODID;
>  		break;
> -	case ACER_CAP_TURBO_FAN:
> -		method_id =3D ACER_WMID_SET_GAMING_FAN_BEHAVIOR;
> -		break;
>  	default:
>  		return AE_BAD_PARAMETER;
>  	}
> @@ -1618,25 +1630,42 @@ static int WMID_gaming_get_sys_info(u32 command, =
u64 *out)
>  	return 0;
>  }
>
> +static int WMID_gaming_set_fan_behavior(u16 fan_bitmap, u8 mode_bitmap)
> +{
> +	acpi_status status;
> +	u64 input =3D 0;
> +	u64 result;
> +
> +	input |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_ID_MASK, fan_bitmap);
> +	input |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK, mode_bitm=
ap);
> +
> +	status =3D WMI_gaming_execute_u64(ACER_WMID_SET_GAMING_FAN_BEHAVIOR_MET=
HODID, input,
> +					&result);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	/* TODO: Proper error handling */
> +	pr_notice("Fan behavior return status: %llu\n", result);
> +
> +	return 0;
> +}
> +
>  static void WMID_gaming_set_fan_mode(u8 fan_mode)
>  {
> -	/* fan_mode =3D 1 is used for auto, fan_mode =3D 2 used for turbo*/
> -	u64 gpu_fan_config1 =3D 0, gpu_fan_config2 =3D 0;
> -	int i;
> -
> -	if (quirks->cpu_fans > 0)
> -		gpu_fan_config2 |=3D 1;
> -	for (i =3D 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
> -		gpu_fan_config2 |=3D 1 << (i + 1);

This was not replicated bellow. Just to be sure, are there no fans at
BIT(1) and BIT(2)?


> -	for (i =3D 0; i < quirks->gpu_fans; ++i)
> -		gpu_fan_config2 |=3D 1 << (i + 3);
> -	if (quirks->cpu_fans > 0)
> -		gpu_fan_config1 |=3D fan_mode;
> -	for (i =3D 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
> -		gpu_fan_config1 |=3D fan_mode << (2 * i + 2);

Same as above.

--=20
 ~ Kurt

> -	for (i =3D 0; i < quirks->gpu_fans; ++i)
> -		gpu_fan_config1 |=3D fan_mode << (2 * i + 6);
> -	WMID_gaming_set_u64(gpu_fan_config2 | gpu_fan_config1 << 16, ACER_CAP_T=
URBO_FAN);
> +	u16 mode_bitmap =3D 0;
> +	u16 fan_bitmap =3D 0;
> +
> +	if (quirks->cpu_fans > 0) {
> +		fan_bitmap |=3D ACER_GAMING_FAN_BEHAVIOR_CPU;
> +		mode_bitmap |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK, fa=
n_mode);
> +	}
> +
> +	if (quirks->gpu_fans > 0) {
> +		fan_bitmap |=3D ACER_GAMING_FAN_BEHAVIOR_GPU;
> +		mode_bitmap |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK, fa=
n_mode);
> +	}
> +
> +	WMID_gaming_set_fan_behavior(fan_bitmap, mode_bitmap);
>  }
>
>  static int WMID_gaming_set_misc_setting(enum acer_wmi_gaming_misc_settin=
g setting, u8 value)
> @@ -1923,7 +1952,7 @@ static int acer_toggle_turbo(void)
>  		WMID_gaming_set_u64(0x1, ACER_CAP_TURBO_LED);
>
>  		/* Set FAN mode to auto */
> -		WMID_gaming_set_fan_mode(0x1);
> +		WMID_gaming_set_fan_mode(ACER_WMID_FAN_MODE_AUTO);
>
>  		/* Set OC to normal */
>  		if (has_cap(ACER_CAP_TURBO_OC)) {
> @@ -1937,7 +1966,7 @@ static int acer_toggle_turbo(void)
>  		WMID_gaming_set_u64(0x10001, ACER_CAP_TURBO_LED);
>
>  		/* Set FAN mode to turbo */
> -		WMID_gaming_set_fan_mode(0x2);
> +		WMID_gaming_set_fan_mode(ACER_WMID_FAN_MODE_TURBO);
>
>  		/* Set OC to turbo mode */
>  		if (has_cap(ACER_CAP_TURBO_OC)) {


