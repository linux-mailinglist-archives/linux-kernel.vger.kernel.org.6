Return-Path: <linux-kernel+bounces-522940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3450AA3D05A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB5F189D718
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21B11DF992;
	Thu, 20 Feb 2025 04:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TZf73HGj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8F61922E7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740025088; cv=none; b=bEvZgnwuLB9he2VMpkBOj+5rmCARCSjEMfBxHuPMq5d1TJU5Y3VfSNSd5sf/T4X/axq8TJFggA3tzpF42RhBB1JUJXWDA6pOjAmvG4DuiBzezX29KAUSdGgeUOV5jFv1wfGcNxKzV3SnjZ+Pbbk3jaIHDFtn+923kp1r6A7NF+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740025088; c=relaxed/simple;
	bh=YSEjraTqXDeRQBh8CNH5p+277cVhLpkvPPYGjeg65IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaq4D1xkAbzSL2ZZ8Qa8v1KWIQoxZe7aSLzgh+vXEPVmSs+upIJtn73SmSJ5YDwHkw6dSUeadfV0zmUuQYHqZqm52wl4IInACW7eLYSD84yP5E7xiYL6yNHqDC6zwhty/vuaxqAkOLP/z/oeJvJlaWgcFK2dIV1xIDN96t4pbSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TZf73HGj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JGdEH2016840
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xrKJIPHCFT6rlsmSWrKg/q/1/2FaZ14FL8GOa1MNCoo=; b=TZf73HGjsb+qg3wZ
	+1d5Jtj0BNMnP7S3YZjDbFqkVR3rzPRg5/zyILZptIL4TiogMLZr1yTDB/tNzoR2
	+3PfgBFJ0eRqh4Ry6TrykpnfEnXX7NpCifKuqehVz94/siVo/1EjwqCX1S3YKA0L
	cmI7oH8nxHf71SJxL9T20hjogxgljjs0oNJ/+NBGc/+e5lZcT5TmbWvj3TT2QTlk
	Ohq3KeE0bVAFH8IRShzWim0mJ5uCQTnBbGHKdD8/a5iVsl0ciEysTbpBr00XXmrz
	DLmwUDNL3kytO3yJeHevnu0V6Op0iH8LC5oZvYnJvbpvRi2MnfYsm6Go5hlB6Jsy
	1391vw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy0crjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:18:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220cb5924a4so16777655ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740025084; x=1740629884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrKJIPHCFT6rlsmSWrKg/q/1/2FaZ14FL8GOa1MNCoo=;
        b=U8X7bI7ZtkKgEXVNqzp9Q7paIPL+rdGFG37xIS2wbMsEzObWeRrs2W0gMGqjmFwTS3
         Jq79C8i+9uz0Mm9qebFpyKHvNAVbmGfYSykf62ZT4vHL1/0lk7P5XjFJ1MCaJPyaFHu1
         PgIzLEiybuF9uIatvdr1RHukoQlPAF05hJHP1g/FBI4NEJ83qlm/AeVU/2+8Pduwr5lG
         BQA4VwQHqRO+Ev3hMQOoJHbKp4RozVTYDyX4t7fv0FEXknfwHh1WO+0OX4PQdSXZAJAV
         h2pxE4dcQMSguB/maQQi2q+WlaaWJWvHfl2j3Blj107CfD4c8NtIFVMUW7+heA96dnmn
         rJdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnObCPMvV8ChhOF4O+x8EEUV+vfsVfuSdAEI3III+UOkQYNXCY4wPi0Vm0fWBqJw4EkyNfaQzcxx2Mg2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYjW7IIJRIyQQguPygl+EWGHo/N4hW9ScviqCObLmAllCR6JHN
	KUrtrGm06QncRQZFuligbNm6x9YIBT2DX866cZmy0GpOfsQ0AmbNsH50SvOzhQblVDV7B3PI++K
	7LQ3aAaY1QPfgTtCvG9XgDGEPuXtIT0546PLWztfJqgdnGV9jHV2Dpulj865gvBA=
X-Gm-Gg: ASbGncvkUwRpMt7YA8uwSbNP7hDXXBUGoVp6NlANZAhZEOOUCceuaLlopqKSW+XkOTu
	xL7GfdmMomKBo1PSY2RfgMRntLCPJ/0LQ9zvxYNkfuoZuRq3HqK3EzkndLqOZmDkEd9pTDe+chZ
	VnFXL2/Pu+OYTmeUS2ni3zytnhmViZIVQOfaJXlEoKGFzKcz9UnghtQQhW8B4NilAuecAHyIaBl
	vMHyOhdWqaRM4uWRB1PeXiWoJc67k631lUmc0dHwAjOQsK1k+krDvyskVMORjdjKdjzHH49IEgZ
	G8+roGXYFexnZs7dp0dlnucM6DFp9Q==
X-Received: by 2002:a17:902:e841:b0:21f:564:80a4 with SMTP id d9443c01a7336-221040a9a0emr339499415ad.33.1740025083663;
        Wed, 19 Feb 2025 20:18:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0vXRoyxvwqbbblzXnK13q+MpjTSXUGq/NUysKQUCJgl+Rkbw2yURC2qoquAwYe7kkwpg46w==
X-Received: by 2002:a17:902:e841:b0:21f:564:80a4 with SMTP id d9443c01a7336-221040a9a0emr339499095ad.33.1740025083308;
        Wed, 19 Feb 2025 20:18:03 -0800 (PST)
Received: from [10.218.35.239] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5a92b959sm11605161a12.63.2025.02.19.20.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 20:18:02 -0800 (PST)
Message-ID: <158c9087-8252-432d-92a7-dad69add1133@oss.qualcomm.com>
Date: Thu, 20 Feb 2025 09:47:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: Increase the limit of USB_GADGET_VBUS_DRAW
 to 900mA
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simona Vetter <simona.vetter@ffwll.ch>, Takashi Iwai <tiwai@suse.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250120111702.3738161-1-prashanth.k@oss.qualcomm.com>
 <894f42a7-50a5-401e-a705-a06eafd6161d@rowland.harvard.edu>
 <1b1587e8-5c38-4138-a27a-1de71ff07ce3@oss.qualcomm.com>
 <e36303c0-9d1f-4c66-bc40-891958507275@rowland.harvard.edu>
 <d308300f-2559-4d13-8d15-5a2416ac00c9@oss.qualcomm.com>
 <e823a961-a0a1-46c3-84a9-7da3cd718f4c@rowland.harvard.edu>
Content-Language: en-US
From: Prashanth K <prashanth.k@oss.qualcomm.com>
In-Reply-To: <e823a961-a0a1-46c3-84a9-7da3cd718f4c@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fNHcMu7Qgce3k8TfiT8OxIWbE0gHDq6E
X-Proofpoint-ORIG-GUID: fNHcMu7Qgce3k8TfiT8OxIWbE0gHDq6E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_11,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=319 clxscore=1015 mlxscore=0 lowpriorityscore=14 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=14 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200026



On 22-01-25 12:56 am, Alan Stern wrote:
> On Tue, Jan 21, 2025 at 10:19:08PM +0530, Prashanth K wrote:
>>
>>
>> On 21-01-25 08:36 pm, Alan Stern wrote:
>>> On Tue, Jan 21, 2025 at 09:50:08AM +0530, Prashanth K wrote:
>>>>
>>>>
>>>> On 20-01-25 08:17 pm, Alan Stern wrote:
>>>>> On Mon, Jan 20, 2025 at 04:47:02PM +0530, Prashanth K wrote:
>>>>>> Currently CONFIG_USB_GADGET_VBUS_DRAW limits the maximum current
>>>>>> drawn from Vbus to be up to 500mA. However USB gadget operating
>>>>>> in SuperSpeed or higher can draw up to 900mA. Also, MaxPower in
>>>>>> ConfigFS takes its default value from this config. Hence increase
>>>>>> the allowed range of CONFIG_USB_GADGET_VBUS_DRAW to 900mA.
>>>>>
>>>>> Is this the sort of thing that really needs to be a Kconfig option?  Why 
>>>>> not make the decision at runtime, based on the needs of the gadget or 
>>>>> function drivers and the connection speed?
>>>>>
>>>>> Alan Stern
>>>>>
>>>>
>>>> Right, set_config() in composite.c does this in runtime based on the
>>>> values of MaxPower (from configFS), VBUS_DRAW defconfig and speed.
>>>> If we don't set MaxPower from configFS, this config helps to set it
>>>> during compile time. In fact MaxPower in configFS takes its default
>>>> value from CONFIG_USB_GADGET_VBUS_DRAW . Sent this patch because Kconfig
>>>> has this limitation where it's only allowing values upto 500mA.
>>>
>>> Why does MaxPower need to be set at compile time?  Why not set it at 
>>> runtime instead?
>>>
>>> If MaxPower gets set at runtime then it can take its default value to be 
>>> 500 mA or 900 mA depending on the connection speed.  There will be no 
>>> need for CONFIG_USB_GAGDGET_VBUS_DRAW.
>>>
>>
>> Yes, agreed. Can we mark CONFIG_USB_GAGDGET_VBUS_DRAW as legacy and
>> maybe also avoid configfs/composite from using it?
> 
> Indeed, the whole idea is to avoid using CONFIG_USB_GADGET_VBUS_DRAW in 
> configfs and composite.
> 
> If nothing will still be using it, just remove it entirely.  No need to 
> mark it as legacy.
> 
> Alan Stern

Hi Alan, small doubt, I see that gadget/legacy/webcam.c is a super-speed
gadget which uses CONFIG_USB_GADGET_VBUS_DRAW. I'm quite not really sure
if anyone uses it now, but if someone uses it, then wouldn't my patch be
applicable there?

Noticed this while preparing a patch to remove dependency of VBUS_DRAW
config from configfs/composite layer. Its ready, will send that after
some testing.

Regards,
Prashanth K

