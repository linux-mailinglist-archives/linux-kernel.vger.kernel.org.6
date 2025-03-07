Return-Path: <linux-kernel+bounces-550133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E14BA55BAE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9319D3B63A2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D813847B;
	Fri,  7 Mar 2025 00:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3VwixgS"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2DC4430;
	Fri,  7 Mar 2025 00:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741306617; cv=none; b=ZjsbqoEH2/FhWsJWk8cdHQHXLfEzdxdIT24yOremwP95JOnonmLKyjVfkCIGVzEBO9V5IOTK5D3L8SjJL2i/haAfhbX4Gx6HlYrQ2BVkTtmICC702q1YnnwCnghk0nrTpFnNfMeK8NeDqJ3rMu9AODHtrhwZMO6gIxEvBBYiBaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741306617; c=relaxed/simple;
	bh=twsT9Oo/Us9O7jUvQGjCKb7htDJjyL+JsvOWkId6PNo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Qhw7oOpVpF2wsdPfalpGyDeCASpWGhXQYZfCKJxvn6I1Jii77QF7xSwZmpSXH7+AiH+i2IRhjwb5q/jzkNf0JBwi+zxzAol1aP1suU7F1Xse1iMkjzL6wFKTSvTYzmxm/jDeVcB50ndJByFhV+mZ8sPuXGB78UFr9dGW+bVGrdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3VwixgS; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f679788fd1so10145787b3.2;
        Thu, 06 Mar 2025 16:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741306614; x=1741911414; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Elvo9kYm6JDwLbjCIV9FHjgmEXldhwO9y61s5I5jGbk=;
        b=A3VwixgSjkpEQf9QrTPmluUtZbrtqsIu+T8qk8rC1vRk8+yNWzbJC2MVzxwCJmNJRt
         GpmCv+BeNHNrcZvRUS0r6jr0SEnGVxU3R4aMLNOWfRMTzjF8KsKMJgewz5eXt/Awqfr7
         srbMo5gyy5DW7iidlfQc8TaPKWGToQHxY744aUscs9H/BCgkuqJrdwGGVnrFxiOTAXHr
         baL3CwFMHB8fmCsTIJ1gfX0f1QQ71cMYhhXb+0NCZEvPPm97XFTJ+pvmKXr8pb2/IxCY
         AqHzg4sySpXW83ZEjPjywb+QycxPNtWCVNIbZ+nbDAvzjpU7VS5hzsK1zvDamFMHeu5m
         Dlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741306614; x=1741911414;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Elvo9kYm6JDwLbjCIV9FHjgmEXldhwO9y61s5I5jGbk=;
        b=v8fOgs+X/V7TejQpuiiR2flVvT6qFDypOyGW8B5PRNr8IG6fs9pKyahROpFVg1e708
         cKfyj/RiSnpECFZVExOI5vgHTNyKDgRptx1Oul/5w95WxTEX5cghEFIyjC7IG1l3d3zj
         YJ/b80PlT5GkTJiCNn4649jbCV1eopNW9UWJmgkepkFef0AAxw+J7v60eQ0hY4B672KW
         kKPzr8wTqlL6Ehs2Hl2XBAM4+FMZboAeuEkBj09zFlY2RlXHmyyKUvwku09N05WQjNAP
         VkBpSc/D4wjaM13rHe2qu02gzGNlAsOaULt/9APJq7obrB74yzmXfbtiu1smOCLWkN7L
         V7HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxP3Boh9SPGSKSfAdVMx5TQAH6dorg+mjDQMCdB5KqoEqX0r/EY6bflWOpEuRqugQL5BL57LsZnBf5cmO3@vger.kernel.org, AJvYcCVBUWQx1faJyD/pi4TN3j4V4NiTJG4jtj3r5kwRjEx6i7IfBND0eZbG+4VwkKjN99LPjq6usjRdAp90DDxadwX6yFsjkA==@vger.kernel.org, AJvYcCXKJb/dQDWU6xFJS08urk96RMzMJ5f8x65WqXzxredxpMQXGoppumYkDJywufDTxJIRlrnsXDI2nfZYDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCzB856axHp8w8dqxWFppJMLa1FbJpIWrVuU72w6JwltWap491
	fk8y8yqCMyStEo4eNi20XLAY5CxYpP8SUcxQ7ZF6qL4M7FGNpAvU
X-Gm-Gg: ASbGnctQptXfqx54cM1ApXgkd9C2V5itAVRhvmGMMUuoOlllNhKK2EjRiQmoTzckuv/
	iX7gn2bTQBhZy9DmE6B6yOGKfHuCOyLvPj8YcOL2psBMuorQEBhhjhQH8pBUM6wGgdcew5rnIn2
	aueATnsJOIBciqmNbAfSEzG+5NwvPseFX6QKRFu5InwvRisFEyDwEUHlpZkZ82UOmWpDWia2kXH
	eTPN4DU42XnNM44K0gcK5Bzi6es9sEY5vmF62ecaeOs+YzWUu492QneE7KXNX0qjqcaREuCut2I
	tmKn2vPj2WjAuWxAF/LINKea2HdRgEb6H6KFMA==
X-Google-Smtp-Source: AGHT+IHXPZp8rOFCJiSBB+K3TmJJodLqHdDMDj32MX6uDtjE5aBP4LLJyK5buWMxi5LKcudIYQBGjg==
X-Received: by 2002:a05:690c:6f0a:b0:6f0:23da:49a3 with SMTP id 00721157ae682-6febf295f42mr23201597b3.8.1741306614078;
        Thu, 06 Mar 2025 16:16:54 -0800 (PST)
Received: from localhost ([2800:bf0:61:1288:2be8:bc29:ad13:842f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2a1c276sm4991197b3.13.2025.03.06.16.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 16:16:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Mar 2025 19:16:50 -0500
Message-Id: <D89LODODY167.1VG4P7K7X2BZO@gmail.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 <platform-driver-x86@vger.kernel.org>, <Dell.Client.Kernel@dell.com>,
 <linux-kernel@vger.kernel.org>, "Guenter Roeck" <linux@roeck-us.net>, "Jean
 Delvare" <jdelvare@suse.com>, <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v3 08/10] platform/x86: alienware-wmi-wmax: Add support
 for manual fan control
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Armin Wolf" <W_Armin@gmx.de>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
 <20250305-hwm-v3-8-395e7a1407e2@gmail.com>
 <e8a44866-602c-47bb-8b11-7ba59c3d346f@gmx.de>
In-Reply-To: <e8a44866-602c-47bb-8b11-7ba59c3d346f@gmx.de>

Hi Armin,

On Thu Mar 6, 2025 at 5:35 PM -05, Armin Wolf wrote:
> Am 06.03.25 um 01:56 schrieb Kurt Borja:
>
>> All models with the "AWCC" WMAX device support a way of manually
>> controlling fans.
>>
>> The PWM duty cycle of a fan can't be controlled directly. Instead the
>> AWCC interface let's us tune a PWM `boost` value, which has the
>> following empirically discovered, aproximate behavior over the PWM
>> value:
>>
>> 	pwm =3D pwm_base + (pwm_boost / 255) * (pwm_max - pwm_base)
>>
>> Where the pwm_base is the locked PWM value controlled by the FW and
>> pwm_boost is a value between 0 and 255.
>>
>> Expose this pwm_boost knob as a custom HWMON attribute.
>>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Jean Delvare <jdelvare@suse.com>
>> Cc: linux-hwmon@vger.kernel.org
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>   drivers/platform/x86/dell/alienware-wmi-wmax.c | 223 +++++++++++++++++=
+++++++-
>>   1 file changed, 220 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pl=
atform/x86/dell/alienware-wmi-wmax.c
>> index 20cf3371ee3c0e1ea038b3ca517e831f3b30dc29..de4e8f177aadc9552b05cc73=
2e41ee458b761143 100644
>> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
>> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
>> @@ -13,8 +13,11 @@
>>   #include <linux/bits.h>
>>   #include <linux/dmi.h>
>>   #include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>> +#include <linux/minmax.h>
>>   #include <linux/moduleparam.h>
>>   #include <linux/platform_profile.h>
>> +#include <linux/pm.h>
>>   #include <linux/units.h>
>>   #include <linux/wmi.h>
>>   #include "alienware-wmi.h"
>> @@ -179,10 +182,12 @@ enum AWCC_THERMAL_INFORMATION_OPERATIONS {
>>   	AWCC_OP_GET_FAN_MIN_RPM			=3D 0x08,
>>   	AWCC_OP_GET_FAN_MAX_RPM			=3D 0x09,
>>   	AWCC_OP_GET_CURRENT_PROFILE		=3D 0x0B,
>> +	AWCC_OP_GET_FAN_BOOST			=3D 0x0C,
>>   };
>>
>>   enum AWCC_THERMAL_CONTROL_OPERATIONS {
>>   	AWCC_OP_ACTIVATE_PROFILE		=3D 0x01,
>> +	AWCC_OP_SET_FAN_BOOST			=3D 0x02,
>>   };
>>
>>   enum AWCC_GAME_SHIFT_STATUS_OPERATIONS {
>> @@ -248,6 +253,7 @@ struct awcc_fan_data {
>>   	u32 total_temps;
>>   	u32 min_rpm;
>>   	u32 max_rpm;
>> +	u8 suspend_cache;
>>   	u8 id;
>>   };
>>
>> @@ -627,6 +633,17 @@ static inline int awcc_op_get_temperature(struct wm=
i_device *wdev, u8 temp_id, u
>>   		.arg3 =3D 0,
>>   	};
>>
>> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args=
, out);
>> +}
>> +
>> +static inline int awcc_op_get_fan_boost(struct wmi_device *wdev, u8 fan=
_id, u32 *out)
>> +{
>> +	struct wmax_u32_args args =3D {
>> +		.operation =3D AWCC_OP_GET_FAN_BOOST,
>> +		.arg1 =3D fan_id,
>> +		.arg2 =3D 0,
>> +		.arg3 =3D 0,
>> +	};
>>
>>   	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &arg=
s, out);
>>   }
>> @@ -656,6 +673,19 @@ static inline int awcc_op_activate_profile(struct w=
mi_device *wdev, u8 profile)
>>   	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL, &args, &=
out);
>>   }
>>
>> +static int awcc_op_set_fan_boost(struct wmi_device *wdev, u8 fan_id, u8=
 boost)
>> +{
>> +	struct wmax_u32_args args =3D {
>> +		.operation =3D AWCC_OP_SET_FAN_BOOST,
>> +		.arg1 =3D fan_id,
>> +		.arg2 =3D boost,
>> +		.arg3 =3D 0,
>> +	};
>> +	u32 out;
>> +
>> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL, &args, &o=
ut);
>> +}
>> +
>>   static int awcc_profile_id_to_pprof(u32 id, enum platform_profile_opti=
on *profile)
>>   {
>>   	switch (id) {
>> @@ -717,6 +747,7 @@ static int awcc_hwmon_read(struct device *dev, enum =
hwmon_sensor_types type,
>>   			   u32 attr, int channel, long *val)
>>   {
>>   	struct awcc_priv *priv =3D dev_get_drvdata(dev);
>> +	enum platform_profile_option profile;
>>   	struct awcc_fan_data *fan;
>>   	u32 state;
>>   	int ret;
>> @@ -765,6 +796,28 @@ static int awcc_hwmon_read(struct device *dev, enum=
 hwmon_sensor_types type,
>>   		fan =3D priv->fan_data[channel];
>>
>>   		switch (attr) {
>> +		case hwmon_pwm_enable:
>> +			ret =3D awcc_op_get_current_profile(priv->wdev, &state);
>> +			if (ret)
>> +				return ret;
>> +
>> +			ret =3D awcc_profile_id_to_pprof(state, &profile);
>> +			if (ret)
>> +				return ret;
>> +
>> +			switch (profile) {
>> +			case PLATFORM_PROFILE_PERFORMANCE:
>
> The hwmon sysfs docs say that 0 means that the fan is spinning at maximum=
 speed. Does PLATFORM_PROFILE_PERFORMANCE
> guarantee that all fans are always spinning at maximum speed?

Yes PERFORMANCE is full-speed for all devices I know. Manual fan control
is completely disabled for that profile too.

In fact I'm thinking about adding a module parameter to suppress this
behavior. Not everyone may like that. That's outside the scope of these
series tho.

>
> If no then i suggest to drop support for 0.
>
>> +				*val =3D 0;
>> +				break;
>> +			case PLATFORM_PROFILE_CUSTOM:
>> +				*val =3D 1;
>> +				break;
>> +			default:
>> +				*val =3D 2;
>> +				break;
>> +			}
>> +
>> +			break;
>>   		case hwmon_pwm_auto_channels_temp:
>>   			bitmap_copy(val, fan->auto_channels_temp, BITS_PER_LONG);
>>   			break;
>> @@ -840,10 +893,48 @@ static int awcc_hwmon_read_string(struct device *d=
ev, enum hwmon_sensor_types ty
>>   	return 0;
>>   }
>>
>> +
>> +static int awcc_hwmon_write(struct device *dev, enum hwmon_sensor_types=
 type,
>> +			    u32 attr, int channel, long val)
>> +{
>> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	switch (type) {
>> +	case hwmon_pwm:
>> +		switch (attr) {
>> +		case hwmon_pwm_enable:
>> +			/*
>> +			 * We don't want to duplicate platform profile logic, so
>> +			 * we only allow enabling manual fan control
>> +			 */
>
> I do not think that having pwm1_enable brings any benefit, as the pwmX_bo=
ost attributes
> behave differently than pwmX attributes. I think it would be enough to do=
cument that
> pwmX_boost settings will only reliably work when the custom platform prof=
ile is selected.

Now I realise I completely forgot about the admin-guide documentation!
I'll include it in the next revision. Is this path ok?

	Documentation/admin-guide/laptops/alienware-wmi.rst

Or should I add driver specific ABI documentation? (or both ofc)

I don't want to name the file alienware-laptop because this driver is
compatible with Dell G-Series too.

>
>> +			if (val !=3D 1)
>> +				return -EINVAL;
>> +
>> +			ret =3D awcc_op_activate_profile(priv->wdev, AWCC_SPECIAL_PROFILE_CU=
STOM);
>> +			if (ret)
>> +				return ret;
>> +
>> +			if (priv->ppdev)
>> +				platform_profile_notify(priv->ppdev);
>> +			break;
>> +		default:
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>> +		break;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct hwmon_ops awcc_hwmon_ops =3D {
>>   	.is_visible =3D awcc_hwmon_is_visible,
>>   	.read =3D awcc_hwmon_read,
>>   	.read_string =3D awcc_hwmon_read_string,
>> +	.write =3D awcc_hwmon_write,
>>   };
>>
>>   static const struct hwmon_channel_info * const awcc_hwmon_info[] =3D {
>> @@ -864,7 +955,7 @@ static const struct hwmon_channel_info * const awcc_=
hwmon_info[] =3D {
>>   			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX
>>   			   ),
>>   	HWMON_CHANNEL_INFO(pwm,
>> -			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP | HWMON_PWM_ENABLE,
>>   			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>>   			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>>   			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>> @@ -879,6 +970,75 @@ static const struct hwmon_chip_info awcc_hwmon_chip=
_info =3D {
>>   	.info =3D awcc_hwmon_info,
>>   };
>>
>> +static ssize_t pwm_boost_show(struct device *dev, struct device_attribu=
te *attr,
>> +			      char *buf)
>> +{
>> +	int ret, index =3D to_sensor_dev_attr(attr)->index;
>
> Please initialize "index" on a separate line, can remember the reverse xm=
as-tree order for variables.

Ack.

>
>> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
>> +	struct awcc_fan_data *fan =3D priv->fan_data[index];
>> +	u32 boost;
>> +
>> +	ret =3D awcc_op_get_fan_boost(priv->wdev, fan->id, &boost);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sysfs_emit(buf, "%u\n", boost);
>> +}
>> +
>> +static ssize_t pwm_boost_store(struct device *dev, struct device_attrib=
ute *attr,
>> +			       const char *buf, size_t count)
>> +{
>> +	int ret, index =3D to_sensor_dev_attr(attr)->index;
>> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
>> +	struct awcc_fan_data *fan =3D priv->fan_data[index];
>> +	unsigned long val;
>> +
>> +	ret =3D kstrtoul(buf, 0, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D awcc_op_set_fan_boost(priv->wdev, fan->id, clamp_val(val, 0, 2=
55));
>> +
>> +	return ret ? ret : count;
>> +}
>> +
>> +static SENSOR_DEVICE_ATTR_RW(pwm1_boost, pwm_boost, 0);
>> +static SENSOR_DEVICE_ATTR_RW(pwm2_boost, pwm_boost, 1);
>> +static SENSOR_DEVICE_ATTR_RW(pwm3_boost, pwm_boost, 2);
>> +static SENSOR_DEVICE_ATTR_RW(pwm4_boost, pwm_boost, 3);
>
> Since those attributes are working differently than the standard pwm attr=
ibutes, i suggest to
> instead name them fanX_boost.

I went for pwm*_boost because we also export pwm*_auto_channels_temp,
but I'm ok with fan*_boost too.

>
>> +
>> +static umode_t pwm_boost_attr_visible(struct kobject *kobj, struct attr=
ibute *attr, int n)
>> +{
>> +	struct awcc_priv *priv =3D dev_get_drvdata(kobj_to_dev(kobj));
>> +
>> +	return n < priv->fan_count ? attr->mode : 0;
>> +}
>> +
>> +static bool pwm_boost_group_visible(struct kobject *kobj)
>> +{
>> +	return true;
>> +}
>> +
>> +DEFINE_SYSFS_GROUP_VISIBLE(pwm_boost);
>> +
>> +static struct attribute *fan_boost_attrs[] =3D {
>> +	&sensor_dev_attr_pwm1_boost.dev_attr.attr,
>> +	&sensor_dev_attr_pwm2_boost.dev_attr.attr,
>> +	&sensor_dev_attr_pwm3_boost.dev_attr.attr,
>> +	&sensor_dev_attr_pwm4_boost.dev_attr.attr,
>> +	NULL
>> +};
>> +
>> +static const struct attribute_group pwm_boost_group =3D {
>> +	.attrs =3D fan_boost_attrs,
>> +	.is_visible =3D SYSFS_GROUP_VISIBLE(pwm_boost),
>> +};
>> +
>> +static const struct attribute_group *awcc_hwmon_groups[] =3D {
>> +	&pwm_boost_group,
>> +	NULL
>> +};
>> +
>>   static int awcc_hwmon_temps_init(struct wmi_device *wdev)
>>   {
>>   	struct awcc_priv *priv =3D dev_get_drvdata(&wdev->dev);
>> @@ -1011,12 +1171,50 @@ static int awcc_hwmon_init(struct wmi_device *wd=
ev)
>>   	if (ret)
>>   		return ret;
>>
>> -	priv->hwdev =3D devm_hwmon_device_register_with_info(&wdev->dev, "alie=
nware_wmi", priv,
>> -							   &awcc_hwmon_chip_info, NULL);
>> +	priv->hwdev =3D devm_hwmon_device_register_with_info(&wdev->dev, "alie=
nware_wmi",
>> +							   priv, &awcc_hwmon_chip_info,
>> +							   awcc_hwmon_groups);
>>
>>   	return PTR_ERR_OR_ZERO(priv->hwdev);
>>   }
>>
>> +static void awcc_hwmon_suspend(struct device *dev)
>> +{
>> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
>> +	struct awcc_fan_data *fan;
>> +	unsigned int i;
>> +	u32 boost;
>> +	int ret;
>> +
>> +	for (i =3D 0; i < priv->fan_count; i++) {
>> +		fan =3D priv->fan_data[i];
>> +
>> +		ret =3D awcc_thermal_information(priv->wdev, AWCC_OP_GET_FAN_BOOST,
>> +					       fan->id, &boost);
>> +		if (ret)
>> +			fan->suspend_cache =3D 0;
>
> Please at least log a warning here that the fan boost value can not be re=
stored properly.

Ack.

Is not propagating errors a good approach here? My idea was to try to
turn off fans no matter what.

>
>> +		else
>> +			fan->suspend_cache =3D clamp_val(boost, 0, 255);
>> +
>> +		awcc_op_set_fan_boost(priv->wdev, fan->id, 0);
>> +	}
>> +}
>> +
>> +static void awcc_hwmon_resume(struct device *dev)
>> +{
>> +
>> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
>> +	struct awcc_fan_data *fan;
>> +	unsigned int i;
>> +
>> +	for (i =3D 0; i < priv->fan_count; i++) {
>> +		fan =3D priv->fan_data[i];
>> +
>> +		if (fan->suspend_cache)
>
> How does the driver restore fan boost settings with a value of 0?

We set to 0 when suspending so I don't think it's necessary to restore
to 0 again when resuming.

>
> Thanks,
> Armin Wolf
>
>> +			awcc_op_set_fan_boost(priv->wdev, fan->id, fan->suspend_cache);
>> +	}
>> +}
>> +
>>   /*
>>    * Thermal Profile control
>>    *  - Provides thermal profile control through the Platform Profile AP=
I
>> @@ -1233,6 +1431,24 @@ static int wmax_wmi_probe(struct wmi_device *wdev=
, const void *context)
>>   	return ret;
>>   }
>>
>> +static int wmax_wmi_suspend(struct device *dev)
>> +{
>> +	if (awcc->hwmon)
>> +		awcc_hwmon_suspend(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int wmax_wmi_resume(struct device *dev)
>> +{
>> +	if (awcc->hwmon)
>> +		awcc_hwmon_resume(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +DEFINE_SIMPLE_DEV_PM_OPS(wmax_wmi_pm_ops, wmax_wmi_suspend, wmax_wmi_re=
sume);
>> +
>>   static const struct wmi_device_id alienware_wmax_device_id_table[] =3D=
 {
>>   	{ WMAX_CONTROL_GUID, NULL },
>>   	{ },
>> @@ -1243,6 +1459,7 @@ static struct wmi_driver alienware_wmax_wmi_driver=
 =3D {
>>   	.driver =3D {
>>   		.name =3D "alienware-wmi-wmax",
>>   		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>> +		.pm =3D pm_sleep_ptr(&wmax_wmi_pm_ops),
>>   	},
>>   	.id_table =3D alienware_wmax_device_id_table,
>>   	.probe =3D wmax_wmi_probe,
>>


--=20
 ~ Kurt


