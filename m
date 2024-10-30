Return-Path: <linux-kernel+bounces-389590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151829B6EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3861B1C204F5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E0A21500E;
	Wed, 30 Oct 2024 21:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAfDBiJs"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8E213EE9;
	Wed, 30 Oct 2024 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323486; cv=none; b=RMfHExAFvfauZ6UU+fukealkhQDg2wwr3iIdkYa6PSnXPecLyX/iAfvMd3n/g86OeacuFxix+NadHQpS2IPosoVbcTe87mpdM5RNAkSdfE5FJrRJfxFDpvPTJ4/B6TOND2Uwpgtru5d6l0XPZnHzTRSDhAmkIcarNlZUQinVQw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323486; c=relaxed/simple;
	bh=n93CEEahd8VxqSiFl9szevpdxFdLeUpXJxvSKDff000=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhB6Y8QwrXdvNN4GNcwQeIYINDYTM0yLmCpR07ghn29zthUyhv4lMWtmoUYbJQtx4jzAQWRuanANWUYFNPvbQrYbi7LBoQWx1odW34NBMIVnudY7f/5HMH+ts6pFy22c208OsoeS8vLxv689SfZFVlnTQmeO0llASZ8f9sxfDxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAfDBiJs; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea6a4f287bso249076a12.3;
        Wed, 30 Oct 2024 14:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730323482; x=1730928282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Pp4oSFAiGAKpC31qg9yCNB2vIfjLrT0F51HX+8+W8F0=;
        b=OAfDBiJsXqy+8XpF5uZ60zkl0I491rjYNvSpcEzRzpPhJGLxUMDrWC4/+O4loF6etN
         Dx2qHQa02zYgFBJ3B8ivk4648nCtAhsAbETgsNqCUhxZXOmfNzQTU5NAQJVB/sCytg45
         dscj28E+rbpHdcui/Qx6VWkC1J20ILSBdpg0T79r8agbP1pT/Ysih1CXNzc8r72wQfrc
         qZc0P9bt6JtccITCFEYPnDBqXqOZ+YzI1iapFMGCSpdwiV52OUCAdqw/vVu7AvkaFhR2
         TVI2h1r6m4j8dzbtDT3XtN+of7+Mroin8yTWWu+XYTTUee37TU3qul4A8zWqg44TLw/+
         Y8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323482; x=1730928282;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pp4oSFAiGAKpC31qg9yCNB2vIfjLrT0F51HX+8+W8F0=;
        b=qIniME58yw3w8IO+8s2egSTXfNGO0yer6AFVpKLrX+upJQufr6OBFu98Gc11sxC6Rs
         BR1D2jGHTNt7gAYTagLSTFP8t2zmXESolC1P3DHdBfUxqajFwcWXHTO/ONbLNJgmGwd5
         cOciz5GTo+YChPPkaFdiOlYsRth9nTa3t+obfiKfWGpSy7LdW+C5AFjIx0KlEqxhpCer
         1ArA6qmduvpi3F0d7rT2CRuXNLbPDdCWckDyDo0QIIPwARCp7oCOQBEc0OyVtmL+8wn1
         MUbVKgAPnchYKlhprP9fKfG9fzGe73Me7L8heVl3okUQ/A1kgcezTG2262kMcBa0RKOs
         6IMw==
X-Forwarded-Encrypted: i=1; AJvYcCWpW/hQlyXZPpCfJWbnQxvtAAgksmShy4AeBDcgtTJU3WGPAk3zIdM27WncHi/ehPjZ6weO21apNiQ1vLaG@vger.kernel.org, AJvYcCXHiefWiOEA88NMkfwqcuAoS1Db4Pjpuu5uWYf3rUmVCWiy/bLMUTOX+rMadggsiRrZn0i118fZjDKDgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfXfaPWFV9MQ8PzR6wLBw1CCI/Jf9i16h/qeC2DsXrysvrNzl1
	IjFp+sZeCdO+8+4wVdhYEwjhNlHS2yoxR5kle3rOe1CZjLl7k5AQ
X-Google-Smtp-Source: AGHT+IFj+R6GJjErEFXCYOwuCqc81WElqAiJQxu7NSpX7bYMWQ4J+j+nmqST0FvFGCIQ9s7DgtosYQ==
X-Received: by 2002:a05:6a20:b58b:b0:1d9:2bed:c7e8 with SMTP id adf61e73a8af0-1d9a84de05cmr24310212637.35.1730323482073;
        Wed, 30 Oct 2024 14:24:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a0dfd7sm25567a12.82.2024.10.30.14.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 14:24:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8d4f8eb5-e74f-4fe2-a103-2093939b3662@roeck-us.net>
Date: Wed, 30 Oct 2024 14:24:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: module nct6775 reporting wrong values after resume from suspend
To: M3 <mys3lf@protonmail.com>, "jdelvare@suse.com" <jdelvare@suse.com>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "christian@heusel.eu" <christian@heusel.eu>
References: <H72gIiX824bcqCLZswVX0V1dfbF-tiUMcWeoPM6-EzxaqNQQNaVn9NPsuDJ0_wyOxhf3gfiIUBtR-L9fEEvpnFWMzDHHyePvTBvl1xfiCeo=@protonmail.com>
 <193d6c42-7e0b-49c9-9e95-db458d4baaa7@roeck-us.net>
 <4HSarOaep_et3LczEcUF4Lh9A_pdubxt7V6hoFo6p58U1g122wUcZkg0qZ-_mCgWOntT1KpU3n1nRSGEaNTt2WfWiuMUo61rfkxQAB36OTc=@protonmail.com>
 <f7deecc7-cb88-4de9-942d-5db9fa903707@roeck-us.net>
 <Z5-0Xhu6ktFbb5Qqlw0q2sShCgCm2SPAZvnyReOZI3jZ7HbCZmFXgiI4kzVDABv9E5B-KkvgQpf6OEyHkaSHq3AEG6NsyU7rGKtbd7GVY7Q=@protonmail.com>
 <8c86b8b1-55db-43e1-a1ab-4b65905f7f05@roeck-us.net>
 <f37xE-WxXY0daAFO1Mi_Q_7IxzSWn2u29oqeJ2v7io0Gt_Ta6HS4P6P-bps1aendiUo6ivNsbPKvl38f7uaSeNrhE_6ZFj56PcYSI572L9E=@protonmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <f37xE-WxXY0daAFO1Mi_Q_7IxzSWn2u29oqeJ2v7io0Gt_Ta6HS4P6P-bps1aendiUo6ivNsbPKvl38f7uaSeNrhE_6ZFj56PcYSI572L9E=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/30/24 11:00, M3 wrote:
> I added the other participants because I erroneously replied in the previous message. Sorry about that.
> 

Maybe one of them sees the problem. I have no idea why the reported
temperature is wrong after resume; I don't see another attribute which
might be wrong and/or which might trigger the wrong value.

What I do see, though, is that pwm1, which ties to temp1, still reports
a value of 158 at the "wrong" temperature after resume, even though the
lowest pwm limit temperature is set to 30 degrees C and the reported
temperature is 21 degrees C.

 > pwm1:158
 > pwm1_auto_point1_pwm:153
 > pwm1_auto_point1_temp:30000
...
 > pwm1_temp_sel:1
...
 > temp1_input:21000

I don't see any differences in other pwm values (of fan speeds) either.
The only "off" value seems to be the reported temperature for temp1.

That makes me wonder: What actual impact do you see from this problem ?

Thanks,
Guenter

> After resume from suspend
> 
> /sys/class/hwmon/hwmon5]$ grep . * 2>/dev/null
> 
> beep_enable:0
> fan1_alarm:0
> fan1_beep:0
> fan1_input:0
> fan1_min:0
> fan1_pulses:2
> fan1_target:0
> fan1_tolerance:0
> fan2_alarm:0
> fan2_beep:0
> fan2_input:1162
> fan2_min:0
> fan2_pulses:2
> fan2_target:27000
> fan2_tolerance:1082
> fan3_alarm:0
> fan3_beep:0
> fan3_input:0
> fan3_min:0
> fan3_pulses:2
> fan3_target:0
> fan3_tolerance:0
> fan4_alarm:0
> fan4_beep:0
> fan4_input:0
> fan4_min:0
> fan4_pulses:2
> fan4_target:0
> fan4_tolerance:0
> fan5_alarm:0
> fan5_beep:0
> fan5_input:533
> fan5_min:0
> fan5_pulses:2
> fan5_target:0
> fan5_tolerance:0
> fan6_alarm:0
> fan6_input:534
> fan6_min:0
> fan6_pulses:2
> fan6_target:0
> fan6_tolerance:0
> fan7_input:759
> fan7_min:0
> fan7_pulses:2
> fan7_target:0
> fan7_tolerance:0
> in0_alarm:0
> in0_beep:0
> in0_input:696
> in0_max:1744
> in0_min:0
> in10_alarm:1
> in10_beep:0
> in10_input:1056
> in10_max:0
> in10_min:0
> in11_alarm:1
> in11_beep:0
> in11_input:848
> in11_max:0
> in11_min:0
> in12_alarm:1
> in12_beep:0
> in12_input:1000
> in12_max:0
> in12_min:0
> in13_alarm:1
> in13_beep:0
> in13_input:472
> in13_max:0
> in13_min:0
> in14_alarm:1
> in14_beep:0
> in14_input:1504
> in14_max:0
> in14_min:0
> in1_alarm:1
> in1_beep:0
> in1_input:1680
> in1_max:0
> in1_min:0
> in2_alarm:1
> in2_beep:0
> in2_input:3424
> in2_max:0
> in2_min:0
> in3_alarm:1
> in3_beep:0
> in3_input:3392
> in3_max:0
> in3_min:0
> in4_alarm:1
> in4_beep:0
> in4_input:1000
> in4_max:0
> in4_min:0
> in5_beep:0
> in5_input:904
> in5_max:0
> in5_min:0
> in6_alarm:1
> in6_beep:0
> in6_input:1360
> in6_max:0
> in6_min:0
> in7_alarm:1
> in7_beep:0
> in7_input:3424
> in7_max:0
> in7_min:0
> in8_alarm:1
> in8_beep:0
> in8_input:3248
> in8_max:0
> in8_min:0
> in9_alarm:1
> in9_beep:0
> in9_input:1056
> in9_max:0
> in9_min:0
> intrusion0_alarm:1
> intrusion0_beep:0
> intrusion1_alarm:1
> intrusion1_beep:0
> name:nct6798
> pwm1:158
> pwm1_auto_point1_pwm:153
> pwm1_auto_point1_temp:30000
> pwm1_auto_point2_pwm:255
> pwm1_auto_point2_temp:70000
> pwm1_auto_point3_pwm:255
> pwm1_auto_point3_temp:70000
> pwm1_auto_point4_pwm:255
> pwm1_auto_point4_temp:70000
> pwm1_auto_point5_pwm:255
> pwm1_auto_point5_temp:100000
> pwm1_crit_temp_tolerance:0
> pwm1_enable:5
> pwm1_floor:0
> pwm1_mode:1
> pwm1_start:1
> pwm1_step_down_time:400
> pwm1_step_up_time:400
> pwm1_stop_time:24000
> pwm1_target_temp:0
> pwm1_temp_sel:1
> pwm1_temp_tolerance:2000
> pwm2:101
> pwm2_auto_point1_pwm:51
> pwm2_auto_point1_temp:20000
> pwm2_auto_point2_pwm:178
> pwm2_auto_point2_temp:70000
> pwm2_auto_point3_pwm:255
> pwm2_auto_point3_temp:75000
> pwm2_auto_point4_pwm:255
> pwm2_auto_point4_temp:75000
> pwm2_auto_point5_pwm:255
> pwm2_auto_point5_temp:100000
> pwm2_crit_temp_tolerance:0
> pwm2_enable:5
> pwm2_floor:0
> pwm2_mode:1
> pwm2_start:1
> pwm2_step_down_time:800
> pwm2_step_up_time:800
> pwm2_stop_time:24000
> pwm2_target_temp:50000
> pwm2_temp_sel:7
> pwm2_temp_tolerance:2000
> pwm2_weight_duty_base:0
> pwm2_weight_duty_step:0
> pwm2_weight_temp_sel:0
> pwm2_weight_temp_step:0
> pwm2_weight_temp_step_base:0
> pwm2_weight_temp_step_tol:0
> pwm3:175
> pwm3_auto_point1_pwm:153
> pwm3_auto_point1_temp:30000
> pwm3_auto_point2_pwm:255
> pwm3_auto_point2_temp:70000
> pwm3_auto_point3_pwm:255
> pwm3_auto_point3_temp:70000
> pwm3_auto_point4_pwm:255
> pwm3_auto_point4_temp:70000
> pwm3_auto_point5_pwm:255
> pwm3_auto_point5_temp:100000
> pwm3_crit_temp_tolerance:0
> pwm3_enable:5
> pwm3_floor:0
> pwm3_mode:1
> pwm3_start:1
> pwm3_step_down_time:400
> pwm3_step_up_time:400
> pwm3_stop_time:24000
> pwm3_target_temp:0
> pwm3_temp_sel:7
> pwm3_temp_tolerance:2000
> pwm4:158
> pwm4_auto_point1_pwm:153
> pwm4_auto_point1_temp:30000
> pwm4_auto_point2_pwm:255
> pwm4_auto_point2_temp:70000
> pwm4_auto_point3_pwm:255
> pwm4_auto_point3_temp:70000
> pwm4_auto_point4_pwm:255
> pwm4_auto_point4_temp:70000
> pwm4_auto_point5_pwm:255
> pwm4_auto_point5_temp:100000
> pwm4_crit_temp_tolerance:0
> pwm4_enable:5
> pwm4_floor:0
> pwm4_mode:1
> pwm4_start:1
> pwm4_step_down_time:400
> pwm4_step_up_time:400
> pwm4_stop_time:24000
> pwm4_target_temp:0
> pwm4_temp_sel:1
> pwm4_temp_tolerance:2000
> pwm5:94
> pwm5_auto_point1_pwm:51
> pwm5_auto_point1_temp:20000
> pwm5_auto_point2_pwm:178
> pwm5_auto_point2_temp:55000
> pwm5_auto_point3_pwm:255
> pwm5_auto_point3_temp:60000
> pwm5_auto_point4_pwm:255
> pwm5_auto_point4_temp:60000
> pwm5_auto_point5_pwm:255
> pwm5_auto_point5_temp:100000
> pwm5_crit_temp_tolerance:0
> pwm5_enable:5
> pwm5_floor:0
> pwm5_mode:1
> pwm5_start:1
> pwm5_step_down_time:400
> pwm5_step_up_time:400
> pwm5_stop_time:24000
> pwm5_target_temp:0
> pwm5_temp_sel:1
> pwm5_temp_tolerance:2000
> pwm6:94
> pwm6_auto_point1_pwm:51
> pwm6_auto_point1_temp:20000
> pwm6_auto_point2_pwm:178
> pwm6_auto_point2_temp:55000
> pwm6_auto_point3_pwm:255
> pwm6_auto_point3_temp:60000
> pwm6_auto_point4_pwm:255
> pwm6_auto_point4_temp:60000
> pwm6_auto_point5_pwm:255
> pwm6_auto_point5_temp:100000
> pwm6_crit_temp_tolerance:0
> pwm6_enable:5
> pwm6_floor:0
> pwm6_mode:1
> pwm6_start:1
> pwm6_step_down_time:400
> pwm6_step_up_time:400
> pwm6_stop_time:24000
> pwm6_target_temp:0
> pwm6_temp_sel:1
> pwm6_temp_tolerance:2000
> pwm7:157
> pwm7_auto_point1_pwm:153
> pwm7_auto_point1_temp:30000
> pwm7_auto_point2_pwm:255
> pwm7_auto_point2_temp:75000
> pwm7_auto_point3_pwm:255
> pwm7_auto_point3_temp:75000
> pwm7_auto_point4_pwm:255
> pwm7_auto_point4_temp:75000
> pwm7_auto_point5_pwm:255
> pwm7_auto_point5_temp:100000
> pwm7_crit_temp_tolerance:0
> pwm7_enable:5
> pwm7_floor:0
> pwm7_mode:1
> pwm7_start:1
> pwm7_step_down_time:400
> pwm7_step_up_time:400
> pwm7_stop_time:24000
> pwm7_target_temp:0
> pwm7_temp_sel:1
> pwm7_temp_tolerance:2000
> temp10_input:0
> temp10_label:PCH_CHIP_TEMP
> temp11_input:0
> temp11_label:PCH_CPU_TEMP
> temp12_input:0
> temp12_label:PCH_MCH_TEMP
> temp1_beep:0
> temp1_crit:100000
> temp1_input:21000
> temp1_label:SYSTIN
> temp1_max:80000
> temp1_max_hyst:75000
> temp1_offset:0
> temp1_type:4
> temp2_alarm:0
> temp2_beep:0
> temp2_crit:100000
> temp2_input:21000
> temp2_label:CPUTIN
> temp2_max:121000
> temp2_max_hyst:111000
> temp2_offset:0
> temp2_type:4
> temp3_alarm:0
> temp3_beep:0
> temp3_crit:100000
> temp3_input:7000
> temp3_label:AUXTIN0
> temp3_max:80000
> temp3_max_hyst:75000
> temp3_offset:0
> temp3_type:4
> temp4_alarm:0
> temp4_beep:0
> temp4_crit:100000
> temp4_input:23000
> temp4_label:AUXTIN1
> temp4_max:80000
> temp4_max_hyst:75000
> temp4_offset:0
> temp4_type:4
> temp5_alarm:0
> temp5_beep:0
> temp5_crit:100000
> temp5_input:34000
> temp5_label:AUXTIN2
> temp5_max:80000
> temp5_max_hyst:75000
> temp5_offset:0
> temp5_type:4
> temp6_alarm:0
> temp6_beep:0
> temp6_crit:100000
> temp6_input:-1000
> temp6_label:AUXTIN3
> temp6_max:80000
> temp6_max_hyst:75000
> temp6_offset:0
> temp6_type:4
> temp7_alarm:0
> temp7_beep:0
> temp7_input:38000
> temp7_label:PECI Agent 0
> temp7_max:80000
> temp7_max_hyst:75000
> temp8_alarm:0
> temp8_beep:0
> temp8_crit:100000
> temp8_input:31000
> temp8_label:AUXTIN4
> temp8_max:80000
> temp8_max_hyst:75000
> temp9_input:0
> temp9_label:PCH_CHIP_CPU_MAX_TEMP
> 
> Issuing rmmod && modprobe module nct6775
> 
> /sys/class/hwmon/hwmon5]$ grep . * 2>/dev/null
> 
> beep_enable:0
> fan1_alarm:0
> fan1_beep:0
> fan1_input:0
> fan1_min:0
> fan1_pulses:2
> fan1_target:0
> fan1_tolerance:0
> fan2_alarm:0
> fan2_beep:0
> fan2_input:1165
> fan2_min:0
> fan2_pulses:2
> fan2_target:27000
> fan2_tolerance:1082
> fan3_alarm:0
> fan3_beep:0
> fan3_input:0
> fan3_min:0
> fan3_pulses:2
> fan3_target:0
> fan3_tolerance:0
> fan4_alarm:0
> fan4_beep:0
> fan4_input:0
> fan4_min:0
> fan4_pulses:2
> fan4_target:0
> fan4_tolerance:0
> fan5_alarm:0
> fan5_beep:0
> fan5_input:536
> fan5_min:0
> fan5_pulses:2
> fan5_target:0
> fan5_tolerance:0
> fan6_alarm:0
> fan6_input:535
> fan6_min:0
> fan6_pulses:2
> fan6_target:0
> fan6_tolerance:0
> fan7_input:754
> fan7_min:0
> fan7_pulses:2
> fan7_target:0
> fan7_tolerance:0
> in0_alarm:0
> in0_beep:0
> in0_input:696
> in0_max:1744
> in0_min:0
> in10_alarm:1
> in10_beep:0
> in10_input:1056
> in10_max:0
> in10_min:0
> in11_alarm:1
> in11_beep:0
> in11_input:848
> in11_max:0
> in11_min:0
> in12_alarm:1
> in12_beep:0
> in12_input:1000
> in12_max:0
> in12_min:0
> in13_alarm:1
> in13_beep:0
> in13_input:472
> in13_max:0
> in13_min:0
> in14_alarm:1
> in14_beep:0
> in14_input:1504
> in14_max:0
> in14_min:0
> in1_alarm:1
> in1_beep:0
> in1_input:1680
> in1_max:0
> in1_min:0
> in2_alarm:1
> in2_beep:0
> in2_input:3424
> in2_max:0
> in2_min:0
> in3_alarm:1
> in3_beep:0
> in3_input:3392
> in3_max:0
> in3_min:0
> in4_alarm:1
> in4_beep:0
> in4_input:1000
> in4_max:0
> in4_min:0
> in5_beep:0
> in5_input:904
> in5_max:0
> in5_min:0
> in6_alarm:1
> in6_beep:0
> in6_input:1352
> in6_max:0
> in6_min:0
> in7_alarm:1
> in7_beep:0
> in7_input:3424
> in7_max:0
> in7_min:0
> in8_alarm:1
> in8_beep:0
> in8_input:3248
> in8_max:0
> in8_min:0
> in9_alarm:1
> in9_beep:0
> in9_input:1056
> in9_max:0
> in9_min:0
> intrusion0_alarm:1
> intrusion0_beep:0
> intrusion1_alarm:1
> intrusion1_beep:0
> name:nct6798
> pwm1:158
> pwm1_auto_point1_pwm:153
> pwm1_auto_point1_temp:30000
> pwm1_auto_point2_pwm:255
> pwm1_auto_point2_temp:70000
> pwm1_auto_point3_pwm:255
> pwm1_auto_point3_temp:70000
> pwm1_auto_point4_pwm:255
> pwm1_auto_point4_temp:70000
> pwm1_auto_point5_pwm:255
> pwm1_auto_point5_temp:100000
> pwm1_crit_temp_tolerance:0
> pwm1_enable:5
> pwm1_floor:0
> pwm1_mode:1
> pwm1_start:1
> pwm1_step_down_time:400
> pwm1_step_up_time:400
> pwm1_stop_time:24000
> pwm1_target_temp:0
> pwm1_temp_sel:1
> pwm1_temp_tolerance:2000
> pwm2:101
> pwm2_auto_point1_pwm:51
> pwm2_auto_point1_temp:20000
> pwm2_auto_point2_pwm:178
> pwm2_auto_point2_temp:70000
> pwm2_auto_point3_pwm:255
> pwm2_auto_point3_temp:75000
> pwm2_auto_point4_pwm:255
> pwm2_auto_point4_temp:75000
> pwm2_auto_point5_pwm:255
> pwm2_auto_point5_temp:100000
> pwm2_crit_temp_tolerance:0
> pwm2_enable:5
> pwm2_floor:0
> pwm2_mode:1
> pwm2_start:1
> pwm2_step_down_time:800
> pwm2_step_up_time:800
> pwm2_stop_time:24000
> pwm2_target_temp:50000
> pwm2_temp_sel:7
> pwm2_temp_tolerance:2000
> pwm2_weight_duty_base:0
> pwm2_weight_duty_step:0
> pwm2_weight_temp_sel:0
> pwm2_weight_temp_step:0
> pwm2_weight_temp_step_base:0
> pwm2_weight_temp_step_tol:0
> pwm3:175
> pwm3_auto_point1_pwm:153
> pwm3_auto_point1_temp:30000
> pwm3_auto_point2_pwm:255
> pwm3_auto_point2_temp:70000
> pwm3_auto_point3_pwm:255
> pwm3_auto_point3_temp:70000
> pwm3_auto_point4_pwm:255
> pwm3_auto_point4_temp:70000
> pwm3_auto_point5_pwm:255
> pwm3_auto_point5_temp:100000
> pwm3_crit_temp_tolerance:0
> pwm3_enable:5
> pwm3_floor:0
> pwm3_mode:1
> pwm3_start:1
> pwm3_step_down_time:400
> pwm3_step_up_time:400
> pwm3_stop_time:24000
> pwm3_target_temp:0
> pwm3_temp_sel:7
> pwm3_temp_tolerance:2000
> pwm4:158
> pwm4_auto_point1_pwm:153
> pwm4_auto_point1_temp:30000
> pwm4_auto_point2_pwm:255
> pwm4_auto_point2_temp:70000
> pwm4_auto_point3_pwm:255
> pwm4_auto_point3_temp:70000
> pwm4_auto_point4_pwm:255
> pwm4_auto_point4_temp:70000
> pwm4_auto_point5_pwm:255
> pwm4_auto_point5_temp:100000
> pwm4_crit_temp_tolerance:0
> pwm4_enable:5
> pwm4_floor:0
> pwm4_mode:1
> pwm4_start:1
> pwm4_step_down_time:400
> pwm4_step_up_time:400
> pwm4_stop_time:24000
> pwm4_target_temp:0
> pwm4_temp_sel:1
> pwm4_temp_tolerance:2000
> pwm5:94
> pwm5_auto_point1_pwm:51
> pwm5_auto_point1_temp:20000
> pwm5_auto_point2_pwm:178
> pwm5_auto_point2_temp:55000
> pwm5_auto_point3_pwm:255
> pwm5_auto_point3_temp:60000
> pwm5_auto_point4_pwm:255
> pwm5_auto_point4_temp:60000
> pwm5_auto_point5_pwm:255
> pwm5_auto_point5_temp:100000
> pwm5_crit_temp_tolerance:0
> pwm5_enable:5
> pwm5_floor:0
> pwm5_mode:1
> pwm5_start:1
> pwm5_step_down_time:400
> pwm5_step_up_time:400
> pwm5_stop_time:24000
> pwm5_target_temp:0
> pwm5_temp_sel:1
> pwm5_temp_tolerance:2000
> pwm6:94
> pwm6_auto_point1_pwm:51
> pwm6_auto_point1_temp:20000
> pwm6_auto_point2_pwm:178
> pwm6_auto_point2_temp:55000
> pwm6_auto_point3_pwm:255
> pwm6_auto_point3_temp:60000
> pwm6_auto_point4_pwm:255
> pwm6_auto_point4_temp:60000
> pwm6_auto_point5_pwm:255
> pwm6_auto_point5_temp:100000
> pwm6_crit_temp_tolerance:0
> pwm6_enable:5
> pwm6_floor:0
> pwm6_mode:1
> pwm6_start:1
> pwm6_step_down_time:400
> pwm6_step_up_time:400
> pwm6_stop_time:24000
> pwm6_target_temp:0
> pwm6_temp_sel:1
> pwm6_temp_tolerance:2000
> pwm7:157
> pwm7_auto_point1_pwm:153
> pwm7_auto_point1_temp:30000
> pwm7_auto_point2_pwm:255
> pwm7_auto_point2_temp:75000
> pwm7_auto_point3_pwm:255
> pwm7_auto_point3_temp:75000
> pwm7_auto_point4_pwm:255
> pwm7_auto_point4_temp:75000
> pwm7_auto_point5_pwm:255
> pwm7_auto_point5_temp:100000
> pwm7_crit_temp_tolerance:0
> pwm7_enable:5
> pwm7_floor:0
> pwm7_mode:1
> pwm7_start:1
> pwm7_step_down_time:400
> pwm7_step_up_time:400
> pwm7_stop_time:24000
> pwm7_target_temp:0
> pwm7_temp_sel:1
> pwm7_temp_tolerance:2000
> temp10_input:0
> temp10_label:PCH_CHIP_TEMP
> temp11_input:0
> temp11_label:PCH_CPU_TEMP
> temp12_input:0
> temp12_label:PCH_MCH_TEMP
> temp1_beep:0
> temp1_crit:100000
> temp1_input:30000
> temp1_label:SYSTIN
> temp1_max:80000
> temp1_max_hyst:75000
> temp1_offset:0
> temp1_type:4
> temp2_alarm:0
> temp2_beep:0
> temp2_crit:100000
> temp2_input:21000
> temp2_label:CPUTIN
> temp2_max:121000
> temp2_max_hyst:111000
> temp2_offset:0
> temp2_type:4
> temp3_alarm:0
> temp3_beep:0
> temp3_crit:100000
> temp3_input:7000
> temp3_label:AUXTIN0
> temp3_max:80000
> temp3_max_hyst:75000
> temp3_offset:0
> temp3_type:4
> temp4_alarm:0
> temp4_beep:0
> temp4_crit:100000
> temp4_input:23000
> temp4_label:AUXTIN1
> temp4_max:80000
> temp4_max_hyst:75000
> temp4_offset:0
> temp4_type:4
> temp5_alarm:0
> temp5_beep:0
> temp5_crit:100000
> temp5_input:34000
> temp5_label:AUXTIN2
> temp5_max:80000
> temp5_max_hyst:75000
> temp5_offset:0
> temp5_type:4
> temp6_alarm:0
> temp6_beep:0
> temp6_crit:100000
> temp6_input:-1000
> temp6_label:AUXTIN3
> temp6_max:80000
> temp6_max_hyst:75000
> temp6_offset:0
> temp6_type:4
> temp7_alarm:0
> temp7_beep:0
> temp7_input:37500
> temp7_label:PECI Agent 0
> temp7_max:80000
> temp7_max_hyst:75000
> temp8_alarm:0
> temp8_beep:0
> temp8_crit:100000
> temp8_input:31000
> temp8_label:AUXTIN4
> temp8_max:80000
> temp8_max_hyst:75000
> temp9_input:0
> temp9_label:PCH_CHIP_CPU_MAX_TEMP
> 
> Sent with Proton Mail secure email.
> 
> On Wednesday, October 30th, 2024 at 7:36 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On 10/30/24 09:42, M3 wrote:
>>
>>> I have no clue what you are asking. I am happy to provide but...
>>> Could you please guide me ?
>>
>>
>> cd /sys/class/hwmon/hwmon5
>>
>> grep . * 2>/dev/null
>>
>>> Sent from my iDev
>>>
>>> Sent with Proton Mail secure email.
>>>
>>> On Wednesday, October 30th, 2024 at 6:34 PM, Guenter Roeck linux@roeck-us.net wrote:
>>>
>>>> On 10/30/24 09:19, M3 wrote:
>>>>
>>>>> ok here are the temps of motherboard.
>>>>>
>>>>> After resume from suspend
>>>>> $ cat /sys/class/hwmon/hwmon5/temp1_input
>>>>> 20000
>>>>>
>>>>> And after rmmod nct6775 && modprobe nct6775
>>>>> $ cat /sys/class/hwmon/hwmon5/temp1_input
>>>>> 30000
>>>>
>>>> That is even more useless. I see that below. I would need to see all values
>>>> to be able to determine if there are some discrepancies (for example in
>>>> temperature offset values).
>>>>
>>>> Guenter
>>>>
>>>>> Sent with Proton Mail secure email.
>>>>>
>>>>> On Wednesday, October 30th, 2024 at 6:08 PM, Guenter Roeck linux@roeck-us.net wrote:
>>>>>
>>>>>> On 10/30/24 08:36, M3 wrote:
>>>>>> [ ... ]
>>>>>>
>>>>>>> sensors reporting before systemctl suspend
>>>>>>>
>>>>>>> $ sensors nct6798-isa-02a0
>>>>>>>
>>>>>>> nct6798-isa-02a0
>>>>>>> Adapter: ISA adapter
>>>>>>> CPU Fan: 1162 RPM (min = 0 RPM)
>>>>>>> Chassis Front Fan1: 495 RPM (min = 0 RPM)
>>>>>>> Chassis Rear Fan: 491 RPM (min = 0 RPM)
>>>>>>> Chassis Front Fan2: 742 RPM (min = 0 RPM)
>>>>>>> Motherboard: +30.0°C (high = +80.0°C, hyst = +75.0°C)
>>>>>>> (crit = +100.0°C) sensor = thermistor
>>>>>>>
>>>>>>> ----------
>>>>>>> sensors reporting after resume from suspend (fan rpm's are now similar)
>>>>>>>
>>>>>>> $ sensors nct6798-isa-02a0
>>>>>>>
>>>>>>> nct6798-isa-02a0
>>>>>>> Adapter: ISA adapter
>>>>>>> CPU Fan: 1165 RPM (min = 0 RPM)
>>>>>>> Chassis Front Fan1: 494 RPM (min = 0 RPM)
>>>>>>> Chassis Rear Fan: 510 RPM (min = 0 RPM)
>>>>>>> Chassis Front Fan2: 716 RPM (min = 0 RPM)
>>>>>>> Motherboard: +21.0°C (high = +80.0°C, hyst = +75.0°C)
>>>>>>> (crit = +100.0°C) sensor = thermistor
>>>>>>
>>>>>> It is impossible to say what might be wrong from this information. Any chance to provide
>>>>>> output from hwmon device attributes (from sys/class/hwmon/hwmonX/) from before and after
>>>>>> re-loading the module ?
>>>>>>
>>>>>> Guenter


