Return-Path: <linux-kernel+bounces-389970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A70E39B73EC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 05:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03FE1C21B28
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 04:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE34713A256;
	Thu, 31 Oct 2024 04:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="iMRNIdtu"
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29BD2AD18
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 04:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730350080; cv=none; b=Ztc5PpKq5JU/ubS5jDKsnUaHJXpvfzAbMxx+WCRxVH+OPYg8MhqXxDFE39ablkELbZbF1JCbQ+ErQMfqJpJHzlkCgrOctXfgNC889VLQT5T6q5FIi6n5xocSu07JD69O0qJbjBQgAQqGtaBl1zeLt9M8X8+z8/0ALqKOEM9oBqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730350080; c=relaxed/simple;
	bh=VxRvxeJt23ScGPNCK+TPtJcPoXangFHHf2a2fin5yA4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NC8t2tSUUsYK3h9Jn9zoVVS0FiK9HYOd87UWGnSiRWCpQyL8LZR9dWE/3TBUPV9z4IWGMvfSOsSggeg3rFKvliGROikp1kOD56hxRwTq9psuX9Uo/8fxJXK3Reg3wPMZkMA2Ph06rwlcPxOkntlswW0nA0YxQiu++NCTiodg5TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=iMRNIdtu; arc=none smtp.client-ip=185.70.40.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1730350074; x=1730609274;
	bh=VxRvxeJt23ScGPNCK+TPtJcPoXangFHHf2a2fin5yA4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iMRNIdturSNxfa2cV4aE3RANq90ivscQzArSwBgN/ydT9ZWh947CwTnFzG0h/sOHv
	 96eSUmKqiSL+/n5BG6jyywiHSN4fTV81bLwLbPwgQhGFgOYbmvBd2rDEl+JutuNabB
	 2vVR51UVgYgXuoKMMxcPckn+gs1DnJ1QdBv9kneRbvTLkQmhRnJYwVAouxnQ6s30h3
	 nXVRxqWSt9mAhsPBVEZesd/Dui++ltObbQydYKJU1xkSCUp6FMWvlvT97qVrQc/2SR
	 pmLZnGv7lFZG0OpM4oXVHjoAHLeYUQuqs9qqlvNxliABVwrYG97CzKa8tW0awOQBY4
	 pqqwxVvNYzlRw==
Date: Thu, 31 Oct 2024 04:47:50 +0000
To: Guenter Roeck <linux@roeck-us.net>
From: M3 <mys3lf@protonmail.com>
Cc: "jdelvare@suse.com" <jdelvare@suse.com>, "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "christian@heusel.eu" <christian@heusel.eu>
Subject: Re: module nct6775 reporting wrong values after resume from suspend
Message-ID: <mnheUmdqjrbjzj_b0GKn0aEWPg2bcHoTaIfMuzpeLYS1skS3zXlJ-zfeFlCLg5k94y4U49t-m9LqXsJEcIwjU9-XWKUhOsJo9na_KI_kYkY=@protonmail.com>
In-Reply-To: <8d4f8eb5-e74f-4fe2-a103-2093939b3662@roeck-us.net>
References: <H72gIiX824bcqCLZswVX0V1dfbF-tiUMcWeoPM6-EzxaqNQQNaVn9NPsuDJ0_wyOxhf3gfiIUBtR-L9fEEvpnFWMzDHHyePvTBvl1xfiCeo=@protonmail.com> <193d6c42-7e0b-49c9-9e95-db458d4baaa7@roeck-us.net> <4HSarOaep_et3LczEcUF4Lh9A_pdubxt7V6hoFo6p58U1g122wUcZkg0qZ-_mCgWOntT1KpU3n1nRSGEaNTt2WfWiuMUo61rfkxQAB36OTc=@protonmail.com> <f7deecc7-cb88-4de9-942d-5db9fa903707@roeck-us.net> <Z5-0Xhu6ktFbb5Qqlw0q2sShCgCm2SPAZvnyReOZI3jZ7HbCZmFXgiI4kzVDABv9E5B-KkvgQpf6OEyHkaSHq3AEG6NsyU7rGKtbd7GVY7Q=@protonmail.com> <8c86b8b1-55db-43e1-a1ab-4b65905f7f05@roeck-us.net> <f37xE-WxXY0daAFO1Mi_Q_7IxzSWn2u29oqeJ2v7io0Gt_Ta6HS4P6P-bps1aendiUo6ivNsbPKvl38f7uaSeNrhE_6ZFj56PcYSI572L9E=@protonmail.com> <8d4f8eb5-e74f-4fe2-a103-2093939b3662@roeck-us.net>
Feedback-ID: 1225101:user:proton
X-Pm-Message-ID: f2d4fb7f891c658eb9089be8ad688131081f8659
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I cannot offer insight to an impact. Actual or possible.
When I reported the issue to archlinux forum (https://bbs.archlinux.org/vie=
wtopic.php?id=3D300507) the fan rpm had also dropped by ~20% but it is not =
reproducible every time.
If you take a look at the link you will immediately observe the rpm differe=
nces. It is not what you asked (grep) but the fans are revving slower.

So my concern is whether this leads to an overheating of the box?

If you think it is of minor importance, I guess we can drop it.
By no means do I want to occupy your valuable time.

I dealt with the issue by means of a systemd service.




Sent with Proton Mail secure email.

On Wednesday, October 30th, 2024 at 11:24 PM, Guenter Roeck <linux@roeck-us=
.net> wrote:

> On 10/30/24 11:00, M3 wrote:
>=20
> > I added the other participants because I erroneously replied in the pre=
vious message. Sorry about that.
>=20
>=20
> Maybe one of them sees the problem. I have no idea why the reported
> temperature is wrong after resume; I don't see another attribute which
> might be wrong and/or which might trigger the wrong value.
>=20
> What I do see, though, is that pwm1, which ties to temp1, still reports
> a value of 158 at the "wrong" temperature after resume, even though the
> lowest pwm limit temperature is set to 30 degrees C and the reported
> temperature is 21 degrees C.
>=20
> > pwm1:158
>=20
> > pwm1_auto_point1_pwm:153
>=20
> > pwm1_auto_point1_temp:30000
>=20
> ...
>=20
> > pwm1_temp_sel:1
>=20
> ...
>=20
> > temp1_input:21000
>=20
>=20
> I don't see any differences in other pwm values (of fan speeds) either.
> The only "off" value seems to be the reported temperature for temp1.
>=20
> That makes me wonder: What actual impact do you see from this problem ?
>=20
> Thanks,
> Guenter
>=20
> > After resume from suspend
> >=20
> > /sys/class/hwmon/hwmon5]$ grep . * 2>/dev/null
> >=20
> > beep_enable:0
> > fan1_alarm:0
> > fan1_beep:0
> > fan1_input:0
> > fan1_min:0
> > fan1_pulses:2
> > fan1_target:0
> > fan1_tolerance:0
> > fan2_alarm:0
> > fan2_beep:0
> > fan2_input:1162
> > fan2_min:0
> > fan2_pulses:2
> > fan2_target:27000
> > fan2_tolerance:1082
> > fan3_alarm:0
> > fan3_beep:0
> > fan3_input:0
> > fan3_min:0
> > fan3_pulses:2
> > fan3_target:0
> > fan3_tolerance:0
> > fan4_alarm:0
> > fan4_beep:0
> > fan4_input:0
> > fan4_min:0
> > fan4_pulses:2
> > fan4_target:0
> > fan4_tolerance:0
> > fan5_alarm:0
> > fan5_beep:0
> > fan5_input:533
> > fan5_min:0
> > fan5_pulses:2
> > fan5_target:0
> > fan5_tolerance:0
> > fan6_alarm:0
> > fan6_input:534
> > fan6_min:0
> > fan6_pulses:2
> > fan6_target:0
> > fan6_tolerance:0
> > fan7_input:759
> > fan7_min:0
> > fan7_pulses:2
> > fan7_target:0
> > fan7_tolerance:0
> > in0_alarm:0
> > in0_beep:0
> > in0_input:696
> > in0_max:1744
> > in0_min:0
> > in10_alarm:1
> > in10_beep:0
> > in10_input:1056
> > in10_max:0
> > in10_min:0
> > in11_alarm:1
> > in11_beep:0
> > in11_input:848
> > in11_max:0
> > in11_min:0
> > in12_alarm:1
> > in12_beep:0
> > in12_input:1000
> > in12_max:0
> > in12_min:0
> > in13_alarm:1
> > in13_beep:0
> > in13_input:472
> > in13_max:0
> > in13_min:0
> > in14_alarm:1
> > in14_beep:0
> > in14_input:1504
> > in14_max:0
> > in14_min:0
> > in1_alarm:1
> > in1_beep:0
> > in1_input:1680
> > in1_max:0
> > in1_min:0
> > in2_alarm:1
> > in2_beep:0
> > in2_input:3424
> > in2_max:0
> > in2_min:0
> > in3_alarm:1
> > in3_beep:0
> > in3_input:3392
> > in3_max:0
> > in3_min:0
> > in4_alarm:1
> > in4_beep:0
> > in4_input:1000
> > in4_max:0
> > in4_min:0
> > in5_beep:0
> > in5_input:904
> > in5_max:0
> > in5_min:0
> > in6_alarm:1
> > in6_beep:0
> > in6_input:1360
> > in6_max:0
> > in6_min:0
> > in7_alarm:1
> > in7_beep:0
> > in7_input:3424
> > in7_max:0
> > in7_min:0
> > in8_alarm:1
> > in8_beep:0
> > in8_input:3248
> > in8_max:0
> > in8_min:0
> > in9_alarm:1
> > in9_beep:0
> > in9_input:1056
> > in9_max:0
> > in9_min:0
> > intrusion0_alarm:1
> > intrusion0_beep:0
> > intrusion1_alarm:1
> > intrusion1_beep:0
> > name:nct6798
> > pwm1:158
> > pwm1_auto_point1_pwm:153
> > pwm1_auto_point1_temp:30000
> > pwm1_auto_point2_pwm:255
> > pwm1_auto_point2_temp:70000
> > pwm1_auto_point3_pwm:255
> > pwm1_auto_point3_temp:70000
> > pwm1_auto_point4_pwm:255
> > pwm1_auto_point4_temp:70000
> > pwm1_auto_point5_pwm:255
> > pwm1_auto_point5_temp:100000
> > pwm1_crit_temp_tolerance:0
> > pwm1_enable:5
> > pwm1_floor:0
> > pwm1_mode:1
> > pwm1_start:1
> > pwm1_step_down_time:400
> > pwm1_step_up_time:400
> > pwm1_stop_time:24000
> > pwm1_target_temp:0
> > pwm1_temp_sel:1
> > pwm1_temp_tolerance:2000
> > pwm2:101
> > pwm2_auto_point1_pwm:51
> > pwm2_auto_point1_temp:20000
> > pwm2_auto_point2_pwm:178
> > pwm2_auto_point2_temp:70000
> > pwm2_auto_point3_pwm:255
> > pwm2_auto_point3_temp:75000
> > pwm2_auto_point4_pwm:255
> > pwm2_auto_point4_temp:75000
> > pwm2_auto_point5_pwm:255
> > pwm2_auto_point5_temp:100000
> > pwm2_crit_temp_tolerance:0
> > pwm2_enable:5
> > pwm2_floor:0
> > pwm2_mode:1
> > pwm2_start:1
> > pwm2_step_down_time:800
> > pwm2_step_up_time:800
> > pwm2_stop_time:24000
> > pwm2_target_temp:50000
> > pwm2_temp_sel:7
> > pwm2_temp_tolerance:2000
> > pwm2_weight_duty_base:0
> > pwm2_weight_duty_step:0
> > pwm2_weight_temp_sel:0
> > pwm2_weight_temp_step:0
> > pwm2_weight_temp_step_base:0
> > pwm2_weight_temp_step_tol:0
> > pwm3:175
> > pwm3_auto_point1_pwm:153
> > pwm3_auto_point1_temp:30000
> > pwm3_auto_point2_pwm:255
> > pwm3_auto_point2_temp:70000
> > pwm3_auto_point3_pwm:255
> > pwm3_auto_point3_temp:70000
> > pwm3_auto_point4_pwm:255
> > pwm3_auto_point4_temp:70000
> > pwm3_auto_point5_pwm:255
> > pwm3_auto_point5_temp:100000
> > pwm3_crit_temp_tolerance:0
> > pwm3_enable:5
> > pwm3_floor:0
> > pwm3_mode:1
> > pwm3_start:1
> > pwm3_step_down_time:400
> > pwm3_step_up_time:400
> > pwm3_stop_time:24000
> > pwm3_target_temp:0
> > pwm3_temp_sel:7
> > pwm3_temp_tolerance:2000
> > pwm4:158
> > pwm4_auto_point1_pwm:153
> > pwm4_auto_point1_temp:30000
> > pwm4_auto_point2_pwm:255
> > pwm4_auto_point2_temp:70000
> > pwm4_auto_point3_pwm:255
> > pwm4_auto_point3_temp:70000
> > pwm4_auto_point4_pwm:255
> > pwm4_auto_point4_temp:70000
> > pwm4_auto_point5_pwm:255
> > pwm4_auto_point5_temp:100000
> > pwm4_crit_temp_tolerance:0
> > pwm4_enable:5
> > pwm4_floor:0
> > pwm4_mode:1
> > pwm4_start:1
> > pwm4_step_down_time:400
> > pwm4_step_up_time:400
> > pwm4_stop_time:24000
> > pwm4_target_temp:0
> > pwm4_temp_sel:1
> > pwm4_temp_tolerance:2000
> > pwm5:94
> > pwm5_auto_point1_pwm:51
> > pwm5_auto_point1_temp:20000
> > pwm5_auto_point2_pwm:178
> > pwm5_auto_point2_temp:55000
> > pwm5_auto_point3_pwm:255
> > pwm5_auto_point3_temp:60000
> > pwm5_auto_point4_pwm:255
> > pwm5_auto_point4_temp:60000
> > pwm5_auto_point5_pwm:255
> > pwm5_auto_point5_temp:100000
> > pwm5_crit_temp_tolerance:0
> > pwm5_enable:5
> > pwm5_floor:0
> > pwm5_mode:1
> > pwm5_start:1
> > pwm5_step_down_time:400
> > pwm5_step_up_time:400
> > pwm5_stop_time:24000
> > pwm5_target_temp:0
> > pwm5_temp_sel:1
> > pwm5_temp_tolerance:2000
> > pwm6:94
> > pwm6_auto_point1_pwm:51
> > pwm6_auto_point1_temp:20000
> > pwm6_auto_point2_pwm:178
> > pwm6_auto_point2_temp:55000
> > pwm6_auto_point3_pwm:255
> > pwm6_auto_point3_temp:60000
> > pwm6_auto_point4_pwm:255
> > pwm6_auto_point4_temp:60000
> > pwm6_auto_point5_pwm:255
> > pwm6_auto_point5_temp:100000
> > pwm6_crit_temp_tolerance:0
> > pwm6_enable:5
> > pwm6_floor:0
> > pwm6_mode:1
> > pwm6_start:1
> > pwm6_step_down_time:400
> > pwm6_step_up_time:400
> > pwm6_stop_time:24000
> > pwm6_target_temp:0
> > pwm6_temp_sel:1
> > pwm6_temp_tolerance:2000
> > pwm7:157
> > pwm7_auto_point1_pwm:153
> > pwm7_auto_point1_temp:30000
> > pwm7_auto_point2_pwm:255
> > pwm7_auto_point2_temp:75000
> > pwm7_auto_point3_pwm:255
> > pwm7_auto_point3_temp:75000
> > pwm7_auto_point4_pwm:255
> > pwm7_auto_point4_temp:75000
> > pwm7_auto_point5_pwm:255
> > pwm7_auto_point5_temp:100000
> > pwm7_crit_temp_tolerance:0
> > pwm7_enable:5
> > pwm7_floor:0
> > pwm7_mode:1
> > pwm7_start:1
> > pwm7_step_down_time:400
> > pwm7_step_up_time:400
> > pwm7_stop_time:24000
> > pwm7_target_temp:0
> > pwm7_temp_sel:1
> > pwm7_temp_tolerance:2000
> > temp10_input:0
> > temp10_label:PCH_CHIP_TEMP
> > temp11_input:0
> > temp11_label:PCH_CPU_TEMP
> > temp12_input:0
> > temp12_label:PCH_MCH_TEMP
> > temp1_beep:0
> > temp1_crit:100000
> > temp1_input:21000
> > temp1_label:SYSTIN
> > temp1_max:80000
> > temp1_max_hyst:75000
> > temp1_offset:0
> > temp1_type:4
> > temp2_alarm:0
> > temp2_beep:0
> > temp2_crit:100000
> > temp2_input:21000
> > temp2_label:CPUTIN
> > temp2_max:121000
> > temp2_max_hyst:111000
> > temp2_offset:0
> > temp2_type:4
> > temp3_alarm:0
> > temp3_beep:0
> > temp3_crit:100000
> > temp3_input:7000
> > temp3_label:AUXTIN0
> > temp3_max:80000
> > temp3_max_hyst:75000
> > temp3_offset:0
> > temp3_type:4
> > temp4_alarm:0
> > temp4_beep:0
> > temp4_crit:100000
> > temp4_input:23000
> > temp4_label:AUXTIN1
> > temp4_max:80000
> > temp4_max_hyst:75000
> > temp4_offset:0
> > temp4_type:4
> > temp5_alarm:0
> > temp5_beep:0
> > temp5_crit:100000
> > temp5_input:34000
> > temp5_label:AUXTIN2
> > temp5_max:80000
> > temp5_max_hyst:75000
> > temp5_offset:0
> > temp5_type:4
> > temp6_alarm:0
> > temp6_beep:0
> > temp6_crit:100000
> > temp6_input:-1000
> > temp6_label:AUXTIN3
> > temp6_max:80000
> > temp6_max_hyst:75000
> > temp6_offset:0
> > temp6_type:4
> > temp7_alarm:0
> > temp7_beep:0
> > temp7_input:38000
> > temp7_label:PECI Agent 0
> > temp7_max:80000
> > temp7_max_hyst:75000
> > temp8_alarm:0
> > temp8_beep:0
> > temp8_crit:100000
> > temp8_input:31000
> > temp8_label:AUXTIN4
> > temp8_max:80000
> > temp8_max_hyst:75000
> > temp9_input:0
> > temp9_label:PCH_CHIP_CPU_MAX_TEMP
> >=20
> > Issuing rmmod && modprobe module nct6775
> >=20
> > /sys/class/hwmon/hwmon5]$ grep . * 2>/dev/null
> >=20
> > beep_enable:0
> > fan1_alarm:0
> > fan1_beep:0
> > fan1_input:0
> > fan1_min:0
> > fan1_pulses:2
> > fan1_target:0
> > fan1_tolerance:0
> > fan2_alarm:0
> > fan2_beep:0
> > fan2_input:1165
> > fan2_min:0
> > fan2_pulses:2
> > fan2_target:27000
> > fan2_tolerance:1082
> > fan3_alarm:0
> > fan3_beep:0
> > fan3_input:0
> > fan3_min:0
> > fan3_pulses:2
> > fan3_target:0
> > fan3_tolerance:0
> > fan4_alarm:0
> > fan4_beep:0
> > fan4_input:0
> > fan4_min:0
> > fan4_pulses:2
> > fan4_target:0
> > fan4_tolerance:0
> > fan5_alarm:0
> > fan5_beep:0
> > fan5_input:536
> > fan5_min:0
> > fan5_pulses:2
> > fan5_target:0
> > fan5_tolerance:0
> > fan6_alarm:0
> > fan6_input:535
> > fan6_min:0
> > fan6_pulses:2
> > fan6_target:0
> > fan6_tolerance:0
> > fan7_input:754
> > fan7_min:0
> > fan7_pulses:2
> > fan7_target:0
> > fan7_tolerance:0
> > in0_alarm:0
> > in0_beep:0
> > in0_input:696
> > in0_max:1744
> > in0_min:0
> > in10_alarm:1
> > in10_beep:0
> > in10_input:1056
> > in10_max:0
> > in10_min:0
> > in11_alarm:1
> > in11_beep:0
> > in11_input:848
> > in11_max:0
> > in11_min:0
> > in12_alarm:1
> > in12_beep:0
> > in12_input:1000
> > in12_max:0
> > in12_min:0
> > in13_alarm:1
> > in13_beep:0
> > in13_input:472
> > in13_max:0
> > in13_min:0
> > in14_alarm:1
> > in14_beep:0
> > in14_input:1504
> > in14_max:0
> > in14_min:0
> > in1_alarm:1
> > in1_beep:0
> > in1_input:1680
> > in1_max:0
> > in1_min:0
> > in2_alarm:1
> > in2_beep:0
> > in2_input:3424
> > in2_max:0
> > in2_min:0
> > in3_alarm:1
> > in3_beep:0
> > in3_input:3392
> > in3_max:0
> > in3_min:0
> > in4_alarm:1
> > in4_beep:0
> > in4_input:1000
> > in4_max:0
> > in4_min:0
> > in5_beep:0
> > in5_input:904
> > in5_max:0
> > in5_min:0
> > in6_alarm:1
> > in6_beep:0
> > in6_input:1352
> > in6_max:0
> > in6_min:0
> > in7_alarm:1
> > in7_beep:0
> > in7_input:3424
> > in7_max:0
> > in7_min:0
> > in8_alarm:1
> > in8_beep:0
> > in8_input:3248
> > in8_max:0
> > in8_min:0
> > in9_alarm:1
> > in9_beep:0
> > in9_input:1056
> > in9_max:0
> > in9_min:0
> > intrusion0_alarm:1
> > intrusion0_beep:0
> > intrusion1_alarm:1
> > intrusion1_beep:0
> > name:nct6798
> > pwm1:158
> > pwm1_auto_point1_pwm:153
> > pwm1_auto_point1_temp:30000
> > pwm1_auto_point2_pwm:255
> > pwm1_auto_point2_temp:70000
> > pwm1_auto_point3_pwm:255
> > pwm1_auto_point3_temp:70000
> > pwm1_auto_point4_pwm:255
> > pwm1_auto_point4_temp:70000
> > pwm1_auto_point5_pwm:255
> > pwm1_auto_point5_temp:100000
> > pwm1_crit_temp_tolerance:0
> > pwm1_enable:5
> > pwm1_floor:0
> > pwm1_mode:1
> > pwm1_start:1
> > pwm1_step_down_time:400
> > pwm1_step_up_time:400
> > pwm1_stop_time:24000
> > pwm1_target_temp:0
> > pwm1_temp_sel:1
> > pwm1_temp_tolerance:2000
> > pwm2:101
> > pwm2_auto_point1_pwm:51
> > pwm2_auto_point1_temp:20000
> > pwm2_auto_point2_pwm:178
> > pwm2_auto_point2_temp:70000
> > pwm2_auto_point3_pwm:255
> > pwm2_auto_point3_temp:75000
> > pwm2_auto_point4_pwm:255
> > pwm2_auto_point4_temp:75000
> > pwm2_auto_point5_pwm:255
> > pwm2_auto_point5_temp:100000
> > pwm2_crit_temp_tolerance:0
> > pwm2_enable:5
> > pwm2_floor:0
> > pwm2_mode:1
> > pwm2_start:1
> > pwm2_step_down_time:800
> > pwm2_step_up_time:800
> > pwm2_stop_time:24000
> > pwm2_target_temp:50000
> > pwm2_temp_sel:7
> > pwm2_temp_tolerance:2000
> > pwm2_weight_duty_base:0
> > pwm2_weight_duty_step:0
> > pwm2_weight_temp_sel:0
> > pwm2_weight_temp_step:0
> > pwm2_weight_temp_step_base:0
> > pwm2_weight_temp_step_tol:0
> > pwm3:175
> > pwm3_auto_point1_pwm:153
> > pwm3_auto_point1_temp:30000
> > pwm3_auto_point2_pwm:255
> > pwm3_auto_point2_temp:70000
> > pwm3_auto_point3_pwm:255
> > pwm3_auto_point3_temp:70000
> > pwm3_auto_point4_pwm:255
> > pwm3_auto_point4_temp:70000
> > pwm3_auto_point5_pwm:255
> > pwm3_auto_point5_temp:100000
> > pwm3_crit_temp_tolerance:0
> > pwm3_enable:5
> > pwm3_floor:0
> > pwm3_mode:1
> > pwm3_start:1
> > pwm3_step_down_time:400
> > pwm3_step_up_time:400
> > pwm3_stop_time:24000
> > pwm3_target_temp:0
> > pwm3_temp_sel:7
> > pwm3_temp_tolerance:2000
> > pwm4:158
> > pwm4_auto_point1_pwm:153
> > pwm4_auto_point1_temp:30000
> > pwm4_auto_point2_pwm:255
> > pwm4_auto_point2_temp:70000
> > pwm4_auto_point3_pwm:255
> > pwm4_auto_point3_temp:70000
> > pwm4_auto_point4_pwm:255
> > pwm4_auto_point4_temp:70000
> > pwm4_auto_point5_pwm:255
> > pwm4_auto_point5_temp:100000
> > pwm4_crit_temp_tolerance:0
> > pwm4_enable:5
> > pwm4_floor:0
> > pwm4_mode:1
> > pwm4_start:1
> > pwm4_step_down_time:400
> > pwm4_step_up_time:400
> > pwm4_stop_time:24000
> > pwm4_target_temp:0
> > pwm4_temp_sel:1
> > pwm4_temp_tolerance:2000
> > pwm5:94
> > pwm5_auto_point1_pwm:51
> > pwm5_auto_point1_temp:20000
> > pwm5_auto_point2_pwm:178
> > pwm5_auto_point2_temp:55000
> > pwm5_auto_point3_pwm:255
> > pwm5_auto_point3_temp:60000
> > pwm5_auto_point4_pwm:255
> > pwm5_auto_point4_temp:60000
> > pwm5_auto_point5_pwm:255
> > pwm5_auto_point5_temp:100000
> > pwm5_crit_temp_tolerance:0
> > pwm5_enable:5
> > pwm5_floor:0
> > pwm5_mode:1
> > pwm5_start:1
> > pwm5_step_down_time:400
> > pwm5_step_up_time:400
> > pwm5_stop_time:24000
> > pwm5_target_temp:0
> > pwm5_temp_sel:1
> > pwm5_temp_tolerance:2000
> > pwm6:94
> > pwm6_auto_point1_pwm:51
> > pwm6_auto_point1_temp:20000
> > pwm6_auto_point2_pwm:178
> > pwm6_auto_point2_temp:55000
> > pwm6_auto_point3_pwm:255
> > pwm6_auto_point3_temp:60000
> > pwm6_auto_point4_pwm:255
> > pwm6_auto_point4_temp:60000
> > pwm6_auto_point5_pwm:255
> > pwm6_auto_point5_temp:100000
> > pwm6_crit_temp_tolerance:0
> > pwm6_enable:5
> > pwm6_floor:0
> > pwm6_mode:1
> > pwm6_start:1
> > pwm6_step_down_time:400
> > pwm6_step_up_time:400
> > pwm6_stop_time:24000
> > pwm6_target_temp:0
> > pwm6_temp_sel:1
> > pwm6_temp_tolerance:2000
> > pwm7:157
> > pwm7_auto_point1_pwm:153
> > pwm7_auto_point1_temp:30000
> > pwm7_auto_point2_pwm:255
> > pwm7_auto_point2_temp:75000
> > pwm7_auto_point3_pwm:255
> > pwm7_auto_point3_temp:75000
> > pwm7_auto_point4_pwm:255
> > pwm7_auto_point4_temp:75000
> > pwm7_auto_point5_pwm:255
> > pwm7_auto_point5_temp:100000
> > pwm7_crit_temp_tolerance:0
> > pwm7_enable:5
> > pwm7_floor:0
> > pwm7_mode:1
> > pwm7_start:1
> > pwm7_step_down_time:400
> > pwm7_step_up_time:400
> > pwm7_stop_time:24000
> > pwm7_target_temp:0
> > pwm7_temp_sel:1
> > pwm7_temp_tolerance:2000
> > temp10_input:0
> > temp10_label:PCH_CHIP_TEMP
> > temp11_input:0
> > temp11_label:PCH_CPU_TEMP
> > temp12_input:0
> > temp12_label:PCH_MCH_TEMP
> > temp1_beep:0
> > temp1_crit:100000
> > temp1_input:30000
> > temp1_label:SYSTIN
> > temp1_max:80000
> > temp1_max_hyst:75000
> > temp1_offset:0
> > temp1_type:4
> > temp2_alarm:0
> > temp2_beep:0
> > temp2_crit:100000
> > temp2_input:21000
> > temp2_label:CPUTIN
> > temp2_max:121000
> > temp2_max_hyst:111000
> > temp2_offset:0
> > temp2_type:4
> > temp3_alarm:0
> > temp3_beep:0
> > temp3_crit:100000
> > temp3_input:7000
> > temp3_label:AUXTIN0
> > temp3_max:80000
> > temp3_max_hyst:75000
> > temp3_offset:0
> > temp3_type:4
> > temp4_alarm:0
> > temp4_beep:0
> > temp4_crit:100000
> > temp4_input:23000
> > temp4_label:AUXTIN1
> > temp4_max:80000
> > temp4_max_hyst:75000
> > temp4_offset:0
> > temp4_type:4
> > temp5_alarm:0
> > temp5_beep:0
> > temp5_crit:100000
> > temp5_input:34000
> > temp5_label:AUXTIN2
> > temp5_max:80000
> > temp5_max_hyst:75000
> > temp5_offset:0
> > temp5_type:4
> > temp6_alarm:0
> > temp6_beep:0
> > temp6_crit:100000
> > temp6_input:-1000
> > temp6_label:AUXTIN3
> > temp6_max:80000
> > temp6_max_hyst:75000
> > temp6_offset:0
> > temp6_type:4
> > temp7_alarm:0
> > temp7_beep:0
> > temp7_input:37500
> > temp7_label:PECI Agent 0
> > temp7_max:80000
> > temp7_max_hyst:75000
> > temp8_alarm:0
> > temp8_beep:0
> > temp8_crit:100000
> > temp8_input:31000
> > temp8_label:AUXTIN4
> > temp8_max:80000
> > temp8_max_hyst:75000
> > temp9_input:0
> > temp9_label:PCH_CHIP_CPU_MAX_TEMP
> >=20
> > Sent with Proton Mail secure email.
> >=20
> > On Wednesday, October 30th, 2024 at 7:36 PM, Guenter Roeck linux@roeck-=
us.net wrote:
> >=20
> > > On 10/30/24 09:42, M3 wrote:
> > >=20
> > > > I have no clue what you are asking. I am happy to provide but...
> > > > Could you please guide me ?
> > >=20
> > > cd /sys/class/hwmon/hwmon5
> > >=20
> > > grep . * 2>/dev/null
> > >=20
> > > > Sent from my iDev
> > > >=20
> > > > Sent with Proton Mail secure email.
> > > >=20
> > > > On Wednesday, October 30th, 2024 at 6:34 PM, Guenter Roeck linux@ro=
eck-us.net wrote:
> > > >=20
> > > > > On 10/30/24 09:19, M3 wrote:
> > > > >=20
> > > > > > ok here are the temps of motherboard.
> > > > > >=20
> > > > > > After resume from suspend
> > > > > > $ cat /sys/class/hwmon/hwmon5/temp1_input
> > > > > > 20000
> > > > > >=20
> > > > > > And after rmmod nct6775 && modprobe nct6775
> > > > > > $ cat /sys/class/hwmon/hwmon5/temp1_input
> > > > > > 30000
> > > > >=20
> > > > > That is even more useless. I see that below. I would need to see =
all values
> > > > > to be able to determine if there are some discrepancies (for exam=
ple in
> > > > > temperature offset values).
> > > > >=20
> > > > > Guenter
> > > > >=20
> > > > > > Sent with Proton Mail secure email.
> > > > > >=20
> > > > > > On Wednesday, October 30th, 2024 at 6:08 PM, Guenter Roeck linu=
x@roeck-us.net wrote:
> > > > > >=20
> > > > > > > On 10/30/24 08:36, M3 wrote:
> > > > > > > [ ... ]
> > > > > > >=20
> > > > > > > > sensors reporting before systemctl suspend
> > > > > > > >=20
> > > > > > > > $ sensors nct6798-isa-02a0
> > > > > > > >=20
> > > > > > > > nct6798-isa-02a0
> > > > > > > > Adapter: ISA adapter
> > > > > > > > CPU Fan: 1162 RPM (min =3D 0 RPM)
> > > > > > > > Chassis Front Fan1: 495 RPM (min =3D 0 RPM)
> > > > > > > > Chassis Rear Fan: 491 RPM (min =3D 0 RPM)
> > > > > > > > Chassis Front Fan2: 742 RPM (min =3D 0 RPM)
> > > > > > > > Motherboard: +30.0=C2=B0C (high =3D +80.0=C2=B0C, hyst =3D =
+75.0=C2=B0C)
> > > > > > > > (crit =3D +100.0=C2=B0C) sensor =3D thermistor
> > > > > > > >=20
> > > > > > > > ----------
> > > > > > > > sensors reporting after resume from suspend (fan rpm's are =
now similar)
> > > > > > > >=20
> > > > > > > > $ sensors nct6798-isa-02a0
> > > > > > > >=20
> > > > > > > > nct6798-isa-02a0
> > > > > > > > Adapter: ISA adapter
> > > > > > > > CPU Fan: 1165 RPM (min =3D 0 RPM)
> > > > > > > > Chassis Front Fan1: 494 RPM (min =3D 0 RPM)
> > > > > > > > Chassis Rear Fan: 510 RPM (min =3D 0 RPM)
> > > > > > > > Chassis Front Fan2: 716 RPM (min =3D 0 RPM)
> > > > > > > > Motherboard: +21.0=C2=B0C (high =3D +80.0=C2=B0C, hyst =3D =
+75.0=C2=B0C)
> > > > > > > > (crit =3D +100.0=C2=B0C) sensor =3D thermistor
> > > > > > >=20
> > > > > > > It is impossible to say what might be wrong from this informa=
tion. Any chance to provide
> > > > > > > output from hwmon device attributes (from sys/class/hwmon/hwm=
onX/) from before and after
> > > > > > > re-loading the module ?
> > > > > > >=20
> > > > > > > Guenter

