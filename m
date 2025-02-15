Return-Path: <linux-kernel+bounces-516370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A3BA37038
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 19:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF0A1893B05
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BC51EDA2C;
	Sat, 15 Feb 2025 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkG+eeF3"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5F41EA7C3;
	Sat, 15 Feb 2025 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739645479; cv=none; b=BCanBXdbzra4wsO1+/kXeyky3dV2DYI3X12w4FYi6gOl4MRWb1QTKOHoMjPyH3Sfj7tOjoS4KJWTWoNzaY4MoU/n7AGZhAW6jN+ogcQzX2p5Rh6dbCDRoPX0+oSY6KX53+Gqsmv5lBvl+xByJadaNjxhLZIaZY2r+qfIG1+UrsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739645479; c=relaxed/simple;
	bh=VqfAAO+2ewg+TcOxFizGqtH28+ZDnMmepkAm8+hPYl4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=h/NexXk3t5tZoD5FGA9ZeQ3S37GmVNgSwFqPxn06/IQux2J1RcidSXY4ocAeRKRFq16v2BNjm4IUJejOw168BJQ25aKxQoI/IReoAZrXQjqyXrMokH3LVr/z7/BuI3X++8O4nowDprAhkXuwa844CHbpVQrpQ0tHJ8l+EJIRD7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkG+eeF3; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso2382079276.1;
        Sat, 15 Feb 2025 10:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739645477; x=1740250277; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq/MoOIXpfTdeb4jarHso8EP6qw+0UFsOxxZD4ZjqQU=;
        b=SkG+eeF3w9soFetfTDnFyDROuNNMel9VMdnungjsgGqRndzSjJpq6ZwAO92PCwFSas
         +JOZvLlOfkjO3fXeohYDcmhajs/JJt/jOAoJrrksJwu2zUmZLvq1dkYsVbhNnfimtc+y
         9dczv7PNSgPFpJbLNUNoBe1QdfnUOzfUUJjCF1bA1N2Ku0ssCs6/jMZb4CQoJEtpLPx5
         qertsZ0ZRcIh394IJiuL2Ok4Aax1YOK8NdySknR/pNQw7qwKdj/eO5mZLkNJs0e7NhYa
         gEdePUscLzhoGry4cIJxcwQph6rYvN0CeCXbBp/DiYIDEY65tnA7dWvMNkvKlqQ6DMt/
         7XIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739645477; x=1740250277;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bq/MoOIXpfTdeb4jarHso8EP6qw+0UFsOxxZD4ZjqQU=;
        b=EQeq/Vh04pdMg6JhGwXDDV1yWKmSdoZRFkXpKVH5Q6ap9mzkfpWG2EgBSq0B3a1IfO
         02xUnFv9zPtDHoM+rQaStsjHD9rxdy10Jev2/IDRufnemjdxZlxzU1uVsScmb7BIFAPz
         W63fvCNVdjMy5DWQSBNLwRzV7Ie+HeKxq3/VwLmyXDbCeo37mNTCuRUIp8aayYo0GXpY
         oSLU0PTNVLU0rcPTmfaiIyC1sEEEnTddQI/gg0B9u1NCXLbXepCInouzgsCc8dp1Wk1K
         9LJrpzEhRfGVVRWavxT3FGn0JbRn2wWbOCHrfgfbEBOCDMCp8UHavpGESzajZpCHMvuh
         yGlA==
X-Forwarded-Encrypted: i=1; AJvYcCUN8sRy7w9zR2WkmFsh0Kbjc/g6B3axLksK2tc9V4iUfi3ycMzNxtt3NT1/XPRVrbJ7y+URTE5eIcGm98qBqf53wdJshQ==@vger.kernel.org, AJvYcCVxW5MNppkWBrXchybCrof9ZFdNXaxZephcDXCKnCcCXWwupDiuHVPCTnj9m4gpDiYjPCnchmLHEBXpnhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+n59TlVTJbFGSZa+TflbObuVMamLEv/qHtsgva15AZfgPlLOB
	awg+INtm80iiptyOFtpAPcuTybey6U/oQKaKJuxHBoUn4IZj5Xuv
X-Gm-Gg: ASbGnctTRHhQYVu53x79jfF9ZjGqsdYp/tEcLyRL39qsLGP7esytqUJJO/VPJz/jaVi
	NG3b1rshG4Tdv7HhwLbinFfhBqzneJI6RhAEw9uXMy7T+ihr4FzdSQ24EuBJRDB9TbiFaD4r3x+
	IztxwAmA7+vHKnBQgJ5cAKee91sFgF9rw1ZxuxkdqEiAJffFYzntblyzMQcE5BbtL5P2vKeb6sm
	lZyzJ4y+YR6Kv2Eamlz5vj1hy1rCt/Icbtnx5ng1f/Tcg7PJV+XRWn3u+ArmVuOKART3TIn7IoI
	t81dl2q11A==
X-Google-Smtp-Source: AGHT+IEyys7tKIG0kBY4I3W6XkKrEnILjGfWxwyTqcAV/GwKFueV94RK7E6dYmvlAadB0Cu3Ic8avQ==
X-Received: by 2002:a05:6902:11cd:b0:e5b:3c71:4b2c with SMTP id 3f1490d57ef6-e5dc902a5a1mr3464602276.6.1739645476900;
        Sat, 15 Feb 2025 10:51:16 -0800 (PST)
Received: from localhost ([2800:bf0:179:113e:cafc:c7f7:3156:ba62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5dae0da0e5sm1695454276.39.2025.02.15.10.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 10:51:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 15 Feb 2025 13:51:14 -0500
Message-Id: <D7T8UQ8PJ7BH.3DGKE2REW8025@gmail.com>
Cc: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
 <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/3] platform/x86: acer-wmi: Fix setting of fan
 behavior
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Armin Wolf" <W_Armin@gmx.de>, <jlee@suse.com>,
 <basak.sb2006@gmail.com>, <rayanmargham4@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250215174544.8790-1-W_Armin@gmx.de>
 <20250215174544.8790-2-W_Armin@gmx.de>
In-Reply-To: <20250215174544.8790-2-W_Armin@gmx.de>

On Sat Feb 15, 2025 at 12:45 PM -05, Armin Wolf wrote:
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

I guess this is missing some ACER_GAMING_FAN_BEHAVIOR_STATUS_MASK
handling right? This shouldn't mess with testing tho.

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

I agree on with your explaination in the previous thread, so after the
TODO is addressed:

Reviewed-by: Kurt Borja <kuurtb@gmail.com>

I do wonder tho, isn't there a WMI operation to get the bitmap of
available fans? Like in the case of available thermal profiles and
sensors.

--=20
 ~ Kurt

> -	for (i =3D 0; i < quirks->gpu_fans; ++i)
> -		gpu_fan_config2 |=3D 1 << (i + 3);
> -	if (quirks->cpu_fans > 0)
> -		gpu_fan_config1 |=3D fan_mode;
> -	for (i =3D 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
> -		gpu_fan_config1 |=3D fan_mode << (2 * i + 2);
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
> --
> 2.39.5


