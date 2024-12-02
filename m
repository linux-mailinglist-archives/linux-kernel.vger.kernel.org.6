Return-Path: <linux-kernel+bounces-427417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C14A9E0100
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353B1B2758E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF401FECD2;
	Mon,  2 Dec 2024 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZYwWEpon"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01671FE457
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138817; cv=none; b=LcPiTXrXOhpVPa324HkOkfpjrUV5cU6dzIwY8GdY6+ss3AhRe9HT9HEZL/9JAmX56aJA7Xp9veJfYRRJAKof33b3zE0ja3CNaBuUrtj68XIPxmBz5i7JvqEn1E7IpXnseRE8ICNYX0zZ4g9w53vt14nODiEaVC1O/pjb9roC018=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138817; c=relaxed/simple;
	bh=dTbW9WH8iV44QNUaqfXXpQ+d7TfLVjs921a0DJ2BEqQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=pFYh95srhBhEu1I7QhDi6cduw3xRIPz+Pzi449MYzfhsHRPIZYgg6kgUUrv6HOyVKm4+W1LfBbqST+iVq2ohmCyPMtCnY90gjgVDMg2vHDmsKC3cJQIhdLv1a5Y8k6kjudUQmKLGJsH9VTZ037qx+DDxGc4GJoIKRAMsrXl5iBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZYwWEpon; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B28oa0Y004179
	for <linux-kernel@vger.kernel.org>; Mon, 2 Dec 2024 11:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NdR39HmW7zxxIIftOBgqz9ic
	yfJX08U76Xc+eWA70r4=; b=ZYwWEponam54KZdsDLSlZ8rT4yki9Xqx8uBDaW1Y
	pvD86XHOn2qltFQdjil0M7SDMnLBCwFUHaNgo3m5wCOLZuo4DJ2Kk0ZpEHypbdyy
	nZKmJyGyawX5vPJoao+VWJdjh2zzhc4H0023z1DKv0n6xL+M1xVl7bcEgjikollF
	1yJO9cmIW7N1stOGUEJMjFce2QwA02LI8EGl6TGz0vl30TwnEy59HGfc30B20r8Q
	oq/Tv7CD6MjqcVOaB6GXe75a8BKidEWH8Fxe9RjHbgNVubev2kq5E6A2QMKhR112
	6/TS7L+i1RFcMjS09j61f1kOKt5MHILySo7BIB4fwoJMsg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437rdecsqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 11:26:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4669114c62dso4673901cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 03:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733138812; x=1733743612;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NdR39HmW7zxxIIftOBgqz9icyfJX08U76Xc+eWA70r4=;
        b=UkdW0CwxhkZyBAmnrpJgtiZsydV2k81BTvNb0a6MIMpp8FpyR2SgXAbzL+H1DhT/rC
         yVlRqWDlQ19wdoP2aZtU7kEMnA0pmKNa9uxuroaK2VeylbR10fj7o7kT54VGHxql0RZZ
         BHJ2qtZmKGJQmX221LMkVkeHieEnOGjmLiqJ3xWIFy1UrN7J7ByqtsHiSq58dRZgTSUc
         9kfGHqXkggH1ep1DTPgYVcnlKiU7AWnaol7yJ6ZwjKlUD5ZVlJdbQJMeU4UlhGjcwJ44
         HwTn6ITLRx1j6xW6cXDyNWVTLUWbz4oKeBPPcJYEGMii4n6skQ1cNcC1LFB75/SyKIAd
         ibQw==
X-Forwarded-Encrypted: i=1; AJvYcCWsQ9wws/CzjDAE2s2HeEMzpZdKu83ZrTDdaLD2bkRB5XLx4WyIcdD2DImn8N4QfZwb1Sf6jOcBW6Tyzmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNqyB3xISXU5a2BtPj3j+XSMZ2zDuupHctZBeKoXAqxi19Nw3s
	qiBUEv0NkIGG9L+RRk8cvpRtiH7JcIg0Xn2/jlWpbyAGe5nsG/d2dv3fCi9OU5vNWgM5H7VCbkZ
	/lyKV2H2Qdn16dyh6nHGm8Qnes8r6g9Ip36KcKFrwwWjjAsXEKkqe+QPDrln3N2s=
X-Gm-Gg: ASbGncumTc4VisSxSWLmtwiHymKKpUfyxNJq6+dvHIVm08OznFJqIKJX1iWUVqFI75B
	3nzNNMbipuCDG2RyMMMUe9nI7KB1+uxD8BSO5YkpIUuMXJv+OdYFtWjk8U5tofTcpcgjOXC/vlU
	BZIAUhcT2nxcI8XTy38ycoNc/VcHnd00nFWKoIi9auOwoduZWnFSpbhT8ZbQwL46MF4V2fz1a+h
	xW6S156XY1tUcmqwcK4soeV3wDNE7YLOZNevaqSMGPRtEoF1IbM/qrB8s3TnYA5iq/USz2hh6mn
	SL0GQ4uU9zYwVpTPrPnKwCQEeUS1W4s=
X-Received: by 2002:a05:620a:2a11:b0:7b3:2107:302c with SMTP id af79cd13be357-7b67c471d58mr1188590585a.15.1733138812195;
        Mon, 02 Dec 2024 03:26:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRZon7sa9KOdQRz5kupzrOIszKjCWkZoAuM6of5NdC7MVNKFSYAWFVGHkG+qrtDxpktlo8Og==
X-Received: by 2002:a05:620a:2a11:b0:7b3:2107:302c with SMTP id af79cd13be357-7b67c471d58mr1188587885a.15.1733138811735;
        Mon, 02 Dec 2024 03:26:51 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5999058e0sm498969566b.139.2024.12.02.03.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 03:26:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------1TAgxLQql009S0B6wFpCivJo"
Message-ID: <3f0b67f7-32ca-4b5a-a655-df6f92258cce@oss.qualcomm.com>
Date: Mon, 2 Dec 2024 12:26:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: qcom: qcs6490-rb3gen2: enable Bluetooth
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com
References: <20241022104600.3228-1-quic_janathot@quicinc.com>
 <dd008ff5-ee2a-47be-8a5b-d4f3a1e2bac3@kernel.org>
 <75dc7814-a55e-4a6f-9df9-39b7c875dee9@quicinc.com>
 <6a40b442-6c4e-4abb-aeba-54ff9e86dfde@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6a40b442-6c4e-4abb-aeba-54ff9e86dfde@kernel.org>
X-Proofpoint-ORIG-GUID: 19kIBLbTtg31OXwKbOX6sUYAzqBTc3yi
X-Proofpoint-GUID: 19kIBLbTtg31OXwKbOX6sUYAzqBTc3yi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 mlxlogscore=973 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020101

This is a multi-part message in MIME format.
--------------1TAgxLQql009S0B6wFpCivJo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2.12.2024 10:36 AM, Krzysztof Kozlowski wrote:
> On 02/12/2024 10:32, Janaki Ramaiah Thota wrote:
>>>
>>>> +	pinctrl-names = "default", "sleep";
>>>> +	pinctrl-1 = <&qup_uart7_sleep_cts>, <&qup_uart7_sleep_rts>,
>>>> +			<&qup_uart7_sleep_tx>, <&qup_uart7_sleep_rx>;
>>>
>>> This could be just one phandle to state node with multiple pins subnode.
>>>
>>
>> Since we have different configuration for 3 GPIOs, it’s not good to 
>> combine all 4 GPIOs into one common sleep configuration. Each GPIO 
>> configuration is having separate requirements based on the Bluetooth SOC.
> 
> I did not propose that. Please read bindings and other existing DTS sources.

Janaki,

you can refer to my older patch (attached)

Konrad
--------------1TAgxLQql009S0B6wFpCivJo
Content-Type: text/x-patch; charset=UTF-8;
 name="29a6e0ddbaf7bafc22b44062890bb9915eb665b6.patch"
Content-Disposition: attachment;
 filename="29a6e0ddbaf7bafc22b44062890bb9915eb665b6.patch"
Content-Transfer-Encoding: base64

RnJvbSAyOWE2ZTBkZGJhZjdiYWZjMjJiNDQwNjI4OTBiYjk5MTVlYjY2NWI2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLb25yYWQgRHliY2lvIDxxdWljX2tkeWJjaW9AcXVp
Y2luYy5jb20+CkRhdGU6IEZyaSwgMjMgQXVnIDIwMjQgMDI6MDE6NDkgKzAyMDAKU3ViamVj
dDogW1BBVENIXSBhcm02NDogZHRzOiBxY29tOiBxY3M2NDkwLXJiM2dlbjI6IENvbmZpZ3Vy
ZSB0aGUgYmx1ZXRvb3RoCiBtb2R1bGUKClJCM0dlbjIgZmVhdHVyZXMgYSBXQ042ODU2LzY1
NzAgV2ktRmkgKyBCbHVldG9vdGggY2hpcC4gQ29uZmlndXJlIHRoZQpsYXR0ZXIgcGFydC4K
ClNpZ25lZC1vZmYtYnk6IEtvbnJhZCBEeWJjaW8gPHF1aWNfa2R5YmNpb0BxdWljaW5jLmNv
bT4KLS0tCiBhcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vcWNzNjQ5MC1yYjNnZW4yLmR0cyB8
IDczICsrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNzMgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9xY3M2NDkwLXJi
M2dlbjIuZHRzIGIvYXJjaC9hcm02NC9ib290L2R0cy9xY29tL3FjczY0OTAtcmIzZ2VuMi5k
dHMKaW5kZXggZGE2MWU3YjkwNzk4ZWQuLjJjNjFkNDJkZWQ1NTNiIDEwMDY0NAotLS0gYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vcWNzNjQ5MC1yYjNnZW4yLmR0cworKysgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL3Fjb20vcWNzNjQ5MC1yYjNnZW4yLmR0cwpAQCAtMzMsNiArMzMs
NyBAQAogCiAJYWxpYXNlcyB7CiAJCXNlcmlhbDAgPSAmdWFydDU7CisJCXNlcmlhbDEgPSAm
dWFydDc7CiAJfTsKIAogCWNob3NlbiB7CkBAIC03ODEsMTIgKzc4Miw4NCBAQAogJnRsbW0g
ewogCWdwaW8tcmVzZXJ2ZWQtcmFuZ2VzID0gPDMyIDI+LCAvKiBBRFNQICovCiAJCQkgICAg
ICAgPDQ4IDQ+OyAvKiBORkMgKi8KKworCXF1cF91YXJ0N19zbGVlcDogcXVwLXVhcnQ3LXNs
ZWVwLXN0YXRlIHsKKwkJcXVwX3VhcnQ3X3NsZWVwX2N0czogcXVwLXVhcnQ3LXNsZWVwLWN0
cy1waW5zIHsKKwkJCXBpbnMgPSAiZ3BpbzI4IjsKKwkJCWZ1bmN0aW9uID0gImdwaW8iOwor
CQkJYmlhcy1idXMtaG9sZDsKKwkJfTsKKworCQlxdXBfdWFydDdfc2xlZXBfcnRzOiBxdXAt
dWFydDctc2xlZXAtcnRzLXBpbnMgeworCQkJcGlucyA9ICJncGlvMjkiOworCQkJZnVuY3Rp
b24gPSAiZ3BpbyI7CisJCQliaWFzLXB1bGwtZG93bjsKKwkJfTsKKworCQlxdXBfdWFydDdf
c2xlZXBfdHg6IHF1cC11YXJ0Ny1zbGVlcC10eC1waW5zIHsKKwkJCXBpbnMgPSAiZ3BpbzMw
IjsKKwkJCWZ1bmN0aW9uID0gImdwaW8iOworCQkJYmlhcy1wdWxsLXVwOworCQl9OworCisJ
CXF1cF91YXJ0N19zbGVlcF9yeDogcXVwLXVhcnQ3LXNsZWVwLXJ4LXBpbnMgeworCQkJcGlu
cyA9ICJncGlvMzEiOworCQkJZnVuY3Rpb24gPSAiZ3BpbyI7CisJCQliaWFzLXB1bGwtdXA7
CisJCX07CisJfTsKKworCXdjbl9idF9lbl9kZWZhdWx0OiB3Y24tYnQtZW4tZGVmYXVsdC1z
dGF0ZSB7CisJCXBpbnMgPSAiZ3Bpbzg1IjsKKwkJZnVuY3Rpb24gPSAiZ3BpbyI7CisJCWJp
YXMtZGlzYWJsZTsKKwkJb3V0cHV0LWxvdzsKKwl9OworCisJc3dfY3RybF9kZWZhdWx0OiBz
dy1jdHJsLWRlZmF1bHQtc3RhdGUgeworCQlwaW5zID0gImdwaW84NiI7CisJCWZ1bmN0aW9u
ID0gImdwaW8iOworCQliaWFzLXB1bGwtZG93bjsKKwl9OwogfTsKIAogJnVhcnQ1IHsKIAlz
dGF0dXMgPSAib2theSI7CiB9OwogCismdWFydDcgeworCS9kZWxldGUtcHJvcGVydHkvIGlu
dGVycnVwdHM7CisJaW50ZXJydXB0cy1leHRlbmRlZCA9IDwmaW50YyBHSUNfU1BJIDYwOCBJ
UlFfVFlQRV9MRVZFTF9ISUdIPiwKKwkJCSAgICAgIDwmdGxtbSAzMSBJUlFfVFlQRV9FREdF
X0ZBTExJTkc+OworCisJcGluY3RybC0xID0gPCZxdXBfdWFydDdfc2xlZXA+OworCXBpbmN0
cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJzbGVlcCI7CisKKwlzdGF0dXMgPSAib2theSI7CisK
KwlibHVldG9vdGg6IGJsdWV0b290aCB7CisJCWNvbXBhdGlibGUgPSAicWNvbSx3Y242NzUw
LWJ0IjsKKworCQlwaW5jdHJsLTAgPSA8Jndjbl9idF9lbl9kZWZhdWx0PiwgPCZzd19jdHJs
X2RlZmF1bHQ+OworCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOworCisJCWVuYWJsZS1n
cGlvcyA9IDwmdGxtbSA4NSBHUElPX0FDVElWRV9ISUdIPjsKKwkJc3djdHJsLWdwaW9zID0g
PCZ0bG1tIDg2IEdQSU9fQUNUSVZFX0hJR0g+OworCisJCXZkZGlvLXN1cHBseSA9IDwmdnJl
Z19sMTliXzFwOD47CisJCXZkZGFvbi1zdXBwbHkgPSA8JnZyZWdfczdiXzBwOTcyPjsKKwkJ
dmRkYnRjeG14LXN1cHBseSA9IDwmdnJlZ19zN2JfMHA5NzI+OworCQl2ZGRyZmFjbW4tc3Vw
cGx5ID0gPCZ2cmVnX3M3Yl8wcDk3Mj47CisJCXZkZHJmYTBwOC1zdXBwbHkgPSA8JnZyZWdf
czdiXzBwOTcyPjsKKwkJdmRkcmZhMXA3LXN1cHBseSA9IDwmdnJlZ19zMWJfMXA4NzI+Owor
CQl2ZGRyZmExcDItc3VwcGx5ID0gPCZ2cmVnX3M4Yl8xcDI3Mj47CisJCXZkZHJmYTJwMi1z
dXBwbHkgPSA8JnZyZWdfczFjXzJwMTk+OworCQl2ZGRhc2Qtc3VwcGx5ID0gPCZ2cmVnX2wx
MWNfMnA4PjsKKworCQltYXgtc3BlZWQgPSA8MzIwMDAwMD47CisJfTsKK307CisKICZ1c2Jf
MSB7CiAJc3RhdHVzID0gIm9rYXkiOwogfTsK

--------------1TAgxLQql009S0B6wFpCivJo--

