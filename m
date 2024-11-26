Return-Path: <linux-kernel+bounces-421955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6DB9D928E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98CB5B24EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEDA192B77;
	Tue, 26 Nov 2024 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D1mcp90A"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC119342D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606633; cv=none; b=ZyAoxNUxOKbQqOxJcSjlGwDT7mIngZrmGkQyeRId4YjuoAeqfEi3U6hrS72fEvT2gpVPRLdcY4rCDO+Tg0rLuDz6liLaNZGV0YWk3B40iV/5icG8RfZveeH+nVSkVC5D+R8g9wsJN/aDwsmV20U1nAJLCdmkBSHS2tTQRYEOn1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606633; c=relaxed/simple;
	bh=HPkAK3QEMU6lCsGXsxTqREhr6LO7OphIHM/w0+Xd9CA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=J1Rz0sFJhpDQT6voFSv82MBtjJ6R9rBXpHs/84FDBSIv33n1Sg5PcahaIluAtkYmqH6EbSkPVQ3gXny+EhEHDx0mfpvv8r5eoj255hhReGCN9CxdYSzLMlz2O0DmG9Uiwz48NzqxNypCU/ez4ojmt+i6OtZsCvyJzyuBRhd7aDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D1mcp90A; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53de4ee13c0so2232040e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 23:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732606629; x=1733211429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GsR2P0A0wrOmr1JPLEVXtmhySrfq3zBbwdUpNA8MBR4=;
        b=D1mcp90AJRLLKMIJbmWYr5EbFyjGSLVRi3WL6ZYY4+//Ao2qnPQhYRzbuiUcsW5m1v
         jFEK8n8wQdX8g5l/esgJPu2tdv2zvmq1qdRSDJgsZ3/ku76JmbbI75kVu6GIS6XeZSoF
         8/noCdBj/i1hVSIM32n7BpbaQOVcV1XPnUtDY5K5dl383AQHmJbLwgjJiHRHzUTkZE+T
         cBxiDQ5TVRpY5AYapaQjz6l14zlO4Wq+OorCTx1kPWT7714hgc6L0ZO6nfGGOPHKx35i
         z3i7nDDAjNOhQtLUEkjyETFgvKAQhTCYPi1xhMozxvythHyoTENmx6y4d4ym4yD0dCEo
         HlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732606629; x=1733211429;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GsR2P0A0wrOmr1JPLEVXtmhySrfq3zBbwdUpNA8MBR4=;
        b=CizA7gBQe6lO1PB+Qh4i4ewRqFwIHvYK0cX8BbfPVGBKG342X/bQuBLxf91o18Ai04
         DDVHh1ETiapYOjv+vOe/J3EALsX3kYEfdrrFG8HNRgxU0sfOQhOmrEGOECpT5Q9g7owA
         1Apo7mPm2cFvAPkevczwS185Ng1J2tgZqSQvxAw5f1TyUVJr0suK5DsbMQWMeEQlbQlq
         ZxoYDMWOpQd+i39dpSlB+lL2etQ40xbMFmGs0B5csan8O49hAAwaqWeq+yhu5dPqnX/a
         2BzpNxQzFxPK+Ifb7WFDnTnh4xP6quVJI9IbXRblrzS8snW6K26ucYpfWIRu1hkZP6wO
         rrow==
X-Forwarded-Encrypted: i=1; AJvYcCV5QDojaAPJhYZfKgaWDvvf4XFgTts0xZP4bKMNAYbIAM5VGbInzNcUNJAaNSK/SuTx7/+4LOCrXw/d+z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YweQdqjbKNsPAa7VgQgV82T7v1lKwFp6Sl3WoN56miNUBq6tOzO
	RmM0Io5qFTCS4Kok/Rj93i5ZDrrxBsNYUdY1UiPXGzmjKNCz5yYUnrwfJSrSXqI=
X-Gm-Gg: ASbGncvLAhqM/HGm3cb2HvajINxVk/tYD3Om8pZezQZD1R5cBV7Hq7qOvdUEmC7X/9/
	gJAGUf48FtMSbj84X8IzFAua9b4zHP9l6w6sI9r5N9DWme5+NCGGprWv5m3P3GXsbcm+je0Y0rZ
	1StOkxyynE5fxbd8o4aiDX8IxmyTRcircpTkjkBCWUteYbI9WTb6FV+KfRbKUyR4+ajmNs4arch
	0CjbKz9dxfzLTMXALJlhR0BWvXeL5+lt27QLu+6GI0arz+asfZpwdgM0qIJPv3Zt0eWMVwJvrep
	dGMsXnejh66uO3U=
X-Google-Smtp-Source: AGHT+IE1mO2+CX9wL+NojM5BPJsyPS/lvw8H6+0UnsGMmqXi+RdZzBKUihgzoN7JyuYxuCHKW8Qr2A==
X-Received: by 2002:a05:6512:1092:b0:53d:e70d:f3cf with SMTP id 2adb3069b0e04-53de70df552mr2268057e87.24.1732606628484;
        Mon, 25 Nov 2024 23:37:08 -0800 (PST)
Received: from [127.0.0.1] (85-76-116-93-nat.elisa-mobile.fi. [85.76.116.93])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53de4cba7b9sm603704e87.111.2024.11.25.23.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 23:37:07 -0800 (PST)
Date: Tue, 26 Nov 2024 09:37:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
CC: Renjiang Han <quic_renjiang@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_clk=3A_qcom=3A_videocc=3A_Us?=
 =?US-ASCII?Q?e_HW=5FCTRL=5FTRIGGER_flag_for_video_GDSC=27s?=
User-Agent: Thunderbird for Android
In-Reply-To: <5be1ca54-6a9c-46da-81cc-882ae1596cae@quicinc.com>
References: <20241122-switch_gdsc_mode-v1-0-365f097ecbb0@quicinc.com> <20241122-switch_gdsc_mode-v1-1-365f097ecbb0@quicinc.com> <zhco37pigrp4fh5alqx4xfxx3xhjitqlgw552vwiijka22bt4u@sl4ngzypwh4x> <1d9aa2e7-d402-42dc-baa6-155f01b132ca@quicinc.com> <23ho25gl3iwyi2jspb6a2x5bv76fco5pkg2x5ct4gu3c44dbiq@yec6evx5sihm> <5be1ca54-6a9c-46da-81cc-882ae1596cae@quicinc.com>
Message-ID: <EE235E3C-D327-4483-9C44-DBB72B0DDEA0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26 November 2024 06:04:12 EET, Taniya Das <quic_tdas@quicinc=2Ecom> wrot=
e:
>
>
>On 11/23/2024 5:35 AM, Dmitry Baryshkov wrote:
>> On Fri, Nov 22, 2024 at 10:25:44PM +0530, Taniya Das wrote:
>>>=20
>>>=20
>>> On 11/22/2024 4:29 PM, Dmitry Baryshkov wrote:
>>>> On Fri, Nov 22, 2024 at 04:01:45PM +0530, Renjiang Han wrote:
>>>>> From: Taniya Das <quic_tdas@quicinc=2Ecom>
>>>>>=20
>>>>> The video driver will be using the newly introduced
>>>>=20
>>>> 'will be' or 'is using'? Or will be using it for these platforms? Is
>>>> there any kind of dependency between two patches in the series?
>>>>=20
>>> The video driver will not be able to work without the clock side chang=
es=2E
>>=20
>> Will enabling this flag break the video driver until it is updated?
>>=20
>
>Yes, my understanding is yes it will break=2E When we first introduced th=
e flag we had got the driver and the clock changes together=2E

Please clearly document this in the cover letter=2E Can venus changes go i=
n first? Or they will also break without the flag? The kernel should not br=
eak between commits=2E

>
>>>=20
>>>>> dev_pm_genpd_set_hwmode() API to switch the video GDSC to HW and SW
>>>>> control modes at runtime=2E
>>>>> Hence use HW_CTRL_TRIGGER flag instead of HW_CTRL for video GDSC's f=
or
>>>>> Qualcomm SoC SC7180 and SDM845=2E
>>>>=20
>>>> Is it applicable to any other platforms? Why did you select just thes=
e
>>>> two?
>>>>=20
>>>=20
>>> The V6 version of Video driver is already using them, now the video dr=
iver
>>> wants to migrate to v4 version of the HW to use the new flag=2E
>>=20
>> I mean slightly different issue=2E We have following drivers:
>>=20
>> videocc-sa8775p=2Ec - already uses HW_CTRL_TRIGGER
>> videocc-sc7180=2Ec - being converted now
>> videocc-sc7280=2Ec - already uses HW_CTRL_TRIGGER
>> videocc-sdm845=2Ec - being converted now
>> videocc-sm7150=2Ec
>> videocc-sm8150=2Ec
>> videocc-sm8250=2Ec - already uses HW_CTRL_TRIGGER
>> videocc-sm8350=2Ec - already uses HW_CTRL_TRIGGER
>> videocc-sm8450=2Ec
>> videocc-sm8550=2Ec - already uses HW_CTRL_TRIGGER
>>=20
>> This leaves sm7150, sm8150 and sm8450 untouched=2E Don't they also need=
 to
>> use HW_CTRL_TRIGGER?
>>=20
>
>Yes, I am okay to add the flag, but looking for the Video SW team to conf=
irm they are well tested on the rest of the platforms=2E

Thank you! Let's get confirmation from Vikash or Dikshita=2E

>
>>>=20
>>>>>=20
>>>>> Signed-off-by: Taniya Das <quic_tdas@quicinc=2Ecom>
>>>>> Signed-off-by: Renjiang Han <quic_renjiang@quicinc=2Ecom>
>>>>> ---
>>>>>    drivers/clk/qcom/videocc-sc7180=2Ec | 2 +-
>>>>>    drivers/clk/qcom/videocc-sdm845=2Ec | 4 ++--
>>>>>    2 files changed, 3 insertions(+), 3 deletions(-)
>>>>>=20
>>>>> diff --git a/drivers/clk/qcom/videocc-sc7180=2Ec b/drivers/clk/qcom/=
videocc-sc7180=2Ec
>>>>> index d7f84548039699ce6fdd7c0f6675c168d5eaf4c1=2E=2Edd2441d6aa83bd7c=
ff17deeb42f5d011c1e9b134 100644
>>>>> --- a/drivers/clk/qcom/videocc-sc7180=2Ec
>>>>> +++ b/drivers/clk/qcom/videocc-sc7180=2Ec
>>>>> @@ -166,7 +166,7 @@ static struct gdsc vcodec0_gdsc =3D {
>>>>>    	=2Epd =3D {
>>>>>    		=2Ename =3D "vcodec0_gdsc",
>>>>>    	},
>>>>> -	=2Eflags =3D HW_CTRL,
>>>>> +	=2Eflags =3D HW_CTRL_TRIGGER,
>>>>>    	=2Epwrsts =3D PWRSTS_OFF_ON,
>>>>>    };
>>>>> diff --git a/drivers/clk/qcom/videocc-sdm845=2Ec b/drivers/clk/qcom/=
videocc-sdm845=2Ec
>>>>> index f77a0777947773dc8902c92098acff71b9b8f10f=2E=2E6dedc80a8b3e18ec=
a82c08a5bcd7e1fdc374d4b5 100644
>>>>> --- a/drivers/clk/qcom/videocc-sdm845=2Ec
>>>>> +++ b/drivers/clk/qcom/videocc-sdm845=2Ec
>>>>> @@ -260,7 +260,7 @@ static struct gdsc vcodec0_gdsc =3D {
>>>>>    	},
>>>>>    	=2Ecxcs =3D (unsigned int []){ 0x890, 0x930 },
>>>>>    	=2Ecxc_count =3D 2,
>>>>> -	=2Eflags =3D HW_CTRL | POLL_CFG_GDSCR,
>>>>> +	=2Eflags =3D HW_CTRL_TRIGGER | POLL_CFG_GDSCR,
>>>>>    	=2Epwrsts =3D PWRSTS_OFF_ON,
>>>>>    };
>>>>> @@ -271,7 +271,7 @@ static struct gdsc vcodec1_gdsc =3D {
>>>>>    	},
>>>>>    	=2Ecxcs =3D (unsigned int []){ 0x8d0, 0x950 },
>>>>>    	=2Ecxc_count =3D 2,
>>>>> -	=2Eflags =3D HW_CTRL | POLL_CFG_GDSCR,
>>>>> +	=2Eflags =3D HW_CTRL_TRIGGER | POLL_CFG_GDSCR,
>>>>>    	=2Epwrsts =3D PWRSTS_OFF_ON,
>>>>>    };
>>>>>=20
>>>>> --=20
>>>>> 2=2E34=2E1
>>>>>=20
>>>>=20
>>>=20
>>> --=20
>>> Thanks & Regards,
>>> Taniya Das=2E
>>=20
>


