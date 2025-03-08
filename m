Return-Path: <linux-kernel+bounces-552678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E359A57CC8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 19:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8223D16C060
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E4B1EB5EA;
	Sat,  8 Mar 2025 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JNtpSbwW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28E04B5AE
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741458456; cv=none; b=BFEd8aQptpJLXZH+RdYnPN0VriQPEKxsx3xj3yeeNO23zxYt5SWgsAbTezjJAUov5wReIVX9hbENszsvcgVA2LRMGEsK3Vbx8MDZhkMx3SVLijSsZG3Qfzy6hlYHerb4OUhdxGIc3axbGLpbEkOlFEJD5KIOzypTFM+OpJXvGTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741458456; c=relaxed/simple;
	bh=mZGJjE9J6nPENdw3R6qHpn+oUR2EHsw7Roao2Jmba9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qS6wxASJlj8yiqQpxwk7iMKThZA0/EIFj5/+A9otcVm/WbpCAV2c4Zy/dg1/yye9ReVIhDXuN4P3w1tGm6GIHEj0MrCdrzTEGwKDeLtQRgMD994qjbrmrChycM3F3qB4XT4AZDGW48iWCs9Z8ztYiQ45ajThvNA/u2lDFkQWUBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JNtpSbwW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528HdPhq032514
	for <linux-kernel@vger.kernel.org>; Sat, 8 Mar 2025 18:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zm0fIbKt1P+B2YQrFVSHiI90y5gg5UDdQQYWtWf2GJI=; b=JNtpSbwW8dsjbr/H
	f19TfEd8t7QRUnEu/7BCBDxqsGHsTXBGIppFMznXS9cZpRGjP2mc340LJ474hRIH
	SjQjqsqaIeJsoevM98BL5jGVZD3sW+9/b84ut5aj2yG0J2s4f9bjiOx0nJLj4U2T
	46mHiWjxi3zIDr7qOMksuw47IRiRvMmnoTPHL/T9I4/zUsfMuEmmap8Qu25j4SNJ
	pPAybhpmhvANMhGvRMm8dOqQKVkPYiPUCjV3G8UYp4/5yv7/6CgZO+Dn7eBtfdhn
	hwF7DERyStMp0C5M92xkDvlxazcADd3hDVyhDHXJdXwv5PJv30V8mRYZFZWn8b6z
	KrcIig==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f0pry6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 18:27:33 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8fb83e15fso7827966d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 10:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741458452; x=1742063252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zm0fIbKt1P+B2YQrFVSHiI90y5gg5UDdQQYWtWf2GJI=;
        b=Ezsv6hCm9h6vvlertCIkcWNUwnPntkDfmMfnLKBBC1DJWhQLbifbTeqR5e40db7BQ3
         2ZSpXcBuEBRISTF/kyzgfcljAyReUUir/hJxZyywJ3AX/f+vsvSKf8x6JwzByXfI+HeX
         9jY7vfB49OvR0z3KspFPXM9c/LzWzuZwCRbqxg4id+hhNPJctxgVYA2LWmrkr7fbYqkI
         GnOMKBd2FkcCGUSOS26vdr7RSjrZqfzAaoW1S9Nq4kNzv7FbEqwxWwNIGNTLqfOND/gR
         tCq9EmoJaB2+oCz0oxUYANFosLpAfaLt9VxrBltojHcerU691MAk+Ul4Kw8GIT2ho3YI
         4EqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvb6ra+tbh+YcDAXRnfr5uxPbKbpqrCxTq+OxNeEQF16PNbInP04ANMeVW27m6+lUglnGwiu71nX4OPok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2b4TRlQMFBX8HbDPGlhF2WXWP+Ip8W8JEFtFAsoNFpkgQHK0s
	6aVE5ij/qVcGAXj7V8qBJ6+893f0ydTpB6G4s4wvkIkfevI8KM/GG3OsU9XH0J2ghyMWaLMqExQ
	lxApKOjpXivftOeAAnlJXoL0nVWzRQp/i6dlZ+ZN07vvgcen78v9vYEWLrCeFc3A=
X-Gm-Gg: ASbGncvid74qqHuzLs3Bgm6O6zV3jm4z16WsoBVYmvmfTjUHpZmbVpIrsAGSYJGrPHl
	9rnh1uGe0cLk+V40rlGVmEksF8zatvpYV7lhC/MApfbtgOsL+mGk6szIUC9anyUUZwbrE34dmSY
	Ki9HF6pQIsBY90zJLFrqMG/9lSBxwqRmU4+70Mx+BEVsqn09ndbk397pfUXXKS9EnvLCX3ESN0E
	gQkYBIp92QiEZ2fIDIQxt/zUdCr5AAQLpSsGJe8fa4o5+EcyvuSOFIZN7O7wLoAU6NVQMdVSYh4
	iVAxwucTExDbIIOw1V/GfgyLFBiZcL8reBe3pMzSCiwfBVXQxqm3g4kE0u9cchS2G6zQoA==
X-Received: by 2002:a05:6214:501c:b0:6e6:60f6:56dd with SMTP id 6a1803df08f44-6e908daad6amr19154996d6.7.1741458452570;
        Sat, 08 Mar 2025 10:27:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuhNwOobWK10InZ0rt9nJA/hwpNz+zn+BWgUcVkO6LwDiLCRj4SL3cJNEIriGAfDjmRZv6Xg==
X-Received: by 2002:a05:6214:501c:b0:6e6:60f6:56dd with SMTP id 6a1803df08f44-6e908daad6amr19154896d6.7.1741458451981;
        Sat, 08 Mar 2025 10:27:31 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239482f9asm479537266b.51.2025.03.08.10.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 10:27:31 -0800 (PST)
Message-ID: <5ef97125-2b27-4961-8755-09fcea062f78@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 19:27:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] usb: common: usb-conn-gpio: switch psy_cfg from
 of_node to fwnode
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Samuel Holland <samuel@sholland.org>,
        David Lechner <david@lechnology.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Purism Kernel Team <kernel@puri.sm>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-3-d5e4369936bb@collabora.com>
 <2025022542-recital-ebony-d9b5@gregkh>
 <lhtljyn52wkhotaf2cn6fcj2vqx3dzipv2663kzwtw2tjjlxye@5l3xytkyvocy>
 <2025030845-pectin-facility-a474@gregkh>
 <0401fdf9-7665-40d6-9ec7-7222b2eda866@oss.qualcomm.com>
 <eqfqv2tkfretqzvt74o5dvj5yixkfc3h3my4bhskvhtsrbmtwp@poryvs4oipnp>
 <2025030831-various-monthly-4ae0@gregkh>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2025030831-various-monthly-4ae0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xt-it-6Qbp7igmFmc-2uS4mML2TQZhsc
X-Authority-Analysis: v=2.4 cv=KK2gDEFo c=1 sm=1 tr=0 ts=67cc8c15 cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=QX4gbG5DAAAA:8 a=ag1SF4gXAAAA:8 a=A6-iuEzwBZR8Vts4HQEA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=AbAUZ8qAyYyZVLSsDulk:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: xt-it-6Qbp7igmFmc-2uS4mML2TQZhsc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080142

On 8.03.2025 6:27 PM, Greg Kroah-Hartman wrote:
> On Sat, Mar 08, 2025 at 05:33:05PM +0100, Sebastian Reichel wrote:
>> Hi,
>>
>> On Sat, Mar 08, 2025 at 10:34:45AM +0100, Konrad Dybcio wrote:
>>> On 8.03.2025 6:57 AM, Greg Kroah-Hartman wrote:
>>>> On Sat, Mar 08, 2025 at 02:10:29AM +0100, Sebastian Reichel wrote:
>>>>> On Tue, Feb 25, 2025 at 04:32:50AM +0100, Greg Kroah-Hartman wrote:
>>>>>> On Tue, Feb 25, 2025 at 12:21:36AM +0100, Sebastian Reichel wrote:
>>>>>>> In order to remove .of_node from the power_supply_config struct,
>>>>>>> use .fwnode instead.
>>>>>>>
>>>>>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>>>>>> ---
>>>>>>>  drivers/usb/common/usb-conn-gpio.c | 2 +-
>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
>>>>>>> index aa710b50791b0282be0a6a26cffdd981b794acaa..1e36be2a28fd5ca5e1495b7923e4d3e25d7cedef 100644
>>>>>>> --- a/drivers/usb/common/usb-conn-gpio.c
>>>>>>> +++ b/drivers/usb/common/usb-conn-gpio.c
>>>>>>> @@ -158,7 +158,7 @@ static int usb_conn_psy_register(struct usb_conn_info *info)
>>>>>>>  	struct device *dev = info->dev;
>>>>>>>  	struct power_supply_desc *desc = &info->desc;
>>>>>>>  	struct power_supply_config cfg = {
>>>>>>> -		.of_node = dev->of_node,
>>>>>>> +		.fwnode = dev_fwnode(dev),
>>>>>>>  	};
>>>>>>>  
>>>>>>>  	desc->name = "usb-charger";
>>>>>>>
>>>>>>> -- 
>>>>>>> 2.47.2
>>>>>>
>>>>>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>
>>>>> Please just merge this patch through the USB tree.
>>>>>
>>>>> There are no dependencies and I will send a new version for the
>>>>> later patches, but they won't make it to 6.15 as I want enough
>>>>> time in linux-next for them. This patch is rather simple and
>>>>> getting it merged now means we avoid immutable branches or
>>>>> merging through the wrong tree in the 6.16 cycle.
>>>>
>>>> Attempting to merge a single patch out of a series is hard with our
>>>> current tools, you know that.
>>
>> Sorry, I did not know your tooling has issues with that. AFAIK most
>> maintainers are using b4 nowadays, which makes it really easy. Might
>> be I am biased because I mostly work on ARM stuff where series often
>> have patches for the driver and the device tree and thus merging
>> partial patch series is basically the norm.
> 
> I do use b4, but it wants to suck the whole series down.  If I want to
> pick an individual one out, I have to manually cut the message-id out
> of the email and type out the command and pick the individual commit
> out (or use the -P 3 as was said).
> 
> But that's a world away from me just hitting a single key in my email
> client to suck down the whole thread and apply it to my tree.
> 
> For those of us who have to apply a lot of patches, automation is key.
> When sending a patch series that wants to be split across multiple
> trees, that makes it harder for everyone.
> 
> Anyway, I can take this as is, I've spent more time typing this than it
> would have taken me to dig out just the single email.  Give me a few
> days to catch up with it...

Maybe +Konstantin has a better idea, but

b4 shazam <msgid> --single-message

works too, provided you use the very msgid of the patch (i.e. not a reply
to it or so) and should be easy to add a keybind for

Konrad

