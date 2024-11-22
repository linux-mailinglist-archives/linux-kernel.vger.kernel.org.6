Return-Path: <linux-kernel+bounces-418260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 172689D5F7D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB14828212F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955A01DE886;
	Fri, 22 Nov 2024 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f6vlWPsy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B671DE4D1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732280764; cv=none; b=gFI3Q188ET4QpHobUq17w8Ti5uk4/yrN71tnvr2TO6M7aOe5CEcYl8UEDW5GBbxpfbm6c1ANcF5x5qnM/zhYuT9p+zM7hybv7YfG4l8wRiEwhIl6091t5ucdvmaT4RAZOAgwR0HUOhipvlSE/bP4jSfMhpJ+eOBSGOO02HzL97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732280764; c=relaxed/simple;
	bh=/dlSRdirAmXldQET2Ge72ybo3eTzSkqiDtwo9z4OH6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYNQk3g1z7Jn8tPGWI/AbZ596wxt5VkdrxoUNWBd3dPDC6woKsj4tRflN4x/i5NTtIO2nZ3/4fUWeC1TE+twiUwBZ0cXjT2C50OyfPLhaIWoIh6P6bBfa2tF8bvz7n/2KrueoA7VjS69CDfFNK5H+lJf6EeCACkJLucAJeBsaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f6vlWPsy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM7DFrj021158
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AaHOhFj0Pi9aA28279AVxSRISiCPQlgDopG/l4doSPc=; b=f6vlWPsySXRWFdVI
	5d8H0BCO81pc9bio5up7KvMApRgzFdoP2+MX4H2BW2GCIQx7TMqAkQMeNBQu9QnA
	rLy2KKkDYX1+vSzZPM9rZYx2VoWkdjmbQyNdCIblYgEqaAADrHGH8HXKYdtLJDzG
	ZpvHzrC5Sq+E8TqWZifEHXGgwBz2Aifv9Nokb+YHE8zkmgNtH0+QKGSqc+slNJfT
	sE+QI5Q33jtEuRYedFzimpK6viF96ooEOut7pGqD0BWcvzkYuRAOyJAk5Ai1S90O
	EhwJMtZDSsCItq5NIos8x3lejiTa2v6849Jv754+80PRCaljX0SIlNrkvtnO5lrd
	fRvqOw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4320wk49ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:06:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b145f2d7bdso14499085a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 05:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732280761; x=1732885561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaHOhFj0Pi9aA28279AVxSRISiCPQlgDopG/l4doSPc=;
        b=wZi0PRtmjMO2b6zHJfpT2Bbi3ERrxKtqY2srQtyVG7NcP9d5U3c1QLUUyePeBTe7H6
         b6dCL5O16YifpJTZZushAro8dekzkXT5Scm9+ozLGZ+uzI1yrwVanulljqu5Zpio0Jen
         IjTvHqn4hofVI1VTjRm6pUHbm/32403GhhhJoNyJrXw4HD7+QCwFiTas+CQ/c8ZBKTUC
         k5NeJXNWS+3JkwtvCXW7kKvPx54kyxTHQz+3AbUgIXpyzsV77MLuaz10sguyB98yezYf
         4/3tpAWa2877VaaYw1MHNsFiTc9ezULOz/zS8nrapJeGhC0Q/VNA/AfFpjsLnx6t/A3N
         IGrw==
X-Forwarded-Encrypted: i=1; AJvYcCVk09z+G1TpCSHCwD+m1yGqaC3tWbrNTq8VN+jwV3wcpEbf/YmVPI7+X7RTIQV5wN7xIwJn3bzCcR45a5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYyRIrNPhg563FotrplyYP6WP8WjQkATRGUcYVc+PuWL4mh3Rl
	21CxxbTbXRr2I7kD+jG2IB4xstGM8iOdqo+6kPmak3uaLSmv30Ho6pF0fKi7OoerXQ7cbcbAVDR
	UG1kIB3MA2t1E06yW/SDl6bSnxw0JPfY8Wut3tI+0Gz32DJZwpxbt/RvHn9wCxgo=
X-Gm-Gg: ASbGncvNSqD2gGkZ0jkrMQRWN0i/bDUsetXtVdwocW8cuy26+5GRky+M3Z27E5Hwb6d
	tYW2OCrskowlVA1WQbQfHcSg4ugjjh15l6Kqmc+AyqOXcb/ui7WokWQG6QVZi9iCOXzA55dGtCS
	/86GescRTiV9kUIV8V0fHxoiLM2HJHpOHJYdH7pK8JBfUWD/GkfNaH2kl3eZhrKaFntJN3IFnen
	cJ1izSrjRLEZPyvZC+lrbiwpvHD9Rgm/O567ie6IBlUoPrEHPA116usP4fEjOldSIUx1xS7HUT/
	Uk+mDT9NQJrqRyy+4yiqtSMqTOB3eI0=
X-Received: by 2002:a05:620a:2982:b0:7b1:4920:8006 with SMTP id af79cd13be357-7b51459e2fcmr143209185a.11.1732280761250;
        Fri, 22 Nov 2024 05:06:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7jXetbMhOkrobfsZwzS9OMeNJtv9q6mIqwiOPbk/X99BrgD/3iA9g6QNlS2xUlHcrhl5i0Q==
X-Received: by 2002:a05:620a:2982:b0:7b1:4920:8006 with SMTP id af79cd13be357-7b51459e2fcmr143205685a.11.1732280760662;
        Fri, 22 Nov 2024 05:06:00 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2f41d1sm96992966b.59.2024.11.22.05.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 05:06:00 -0800 (PST)
Message-ID: <0eaa951b-5eed-44eb-95d8-8220bc6c0ca8@oss.qualcomm.com>
Date: Fri, 22 Nov 2024 14:05:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: sa8775p-ride: Enable Display
 Port
To: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_riteshk@quicinc.com, quic_vproddut@quicinc.com,
        quic_abhinavk@quicinc.com
References: <20241120105954.9665-1-quic_mukhopad@quicinc.com>
 <20241120105954.9665-3-quic_mukhopad@quicinc.com>
 <lkovymvjsbd44v2huij7paikvnmo7i7rrmkmvpha2wn5sc4hr3@ppr2dgvhzy6d>
 <a741b71b-af04-44aa-9e08-a3f852b8a801@quicinc.com>
 <qpdponpaztryzacue5vtythr4b4cu6fohmgiwlzredm7ky7caw@eose6vpy4e7y>
 <4da87d98-823f-4781-b138-c6f6caae38fb@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <4da87d98-823f-4781-b138-c6f6caae38fb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WyFtTSLWRp9NRIQub9E-yH59z80Vy4gz
X-Proofpoint-GUID: WyFtTSLWRp9NRIQub9E-yH59z80Vy4gz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220111

On 20.11.2024 12:53 PM, Soutrik Mukhopadhyay wrote:
> 
> On 11/20/2024 5:13 PM, Dmitry Baryshkov wrote:
>> On Wed, Nov 20, 2024 at 05:05:50PM +0530, Soutrik Mukhopadhyay wrote:
>> > > On 11/20/2024 4:42 PM, Dmitry Baryshkov wrote:
>> > > On Wed, Nov 20, 2024 at 04:29:54PM +0530, Soutrik Mukhopadhyay wrote:
>> > > > Enable DPTX0 and DPTX1 along with their corresponding PHYs for
>> > > > sa8775p-ride platform.
>> > > > > Signed-off-by: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
>> > > > ---
>> > > >  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 80 ++++++++++++++++++++++
>> > > >  1 file changed, 80 insertions(+)
>> > > > > diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
>> > > b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
>> > > > index adb71aeff339..4847e4942386 100644
>> > > > --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
>> > > > +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
>> > > > @@ -27,6 +27,30 @@
>> > > >      chosen {
>> > > >          stdout-path = "serial0:115200n8";
>> > > >      };
>> > > > +
>> > > > +    dp0-connector {
>> > > > +        compatible = "dp-connector";
>> > > > +        label = "DP0";
>> > > > > Thundercomm's SA8775p RIDE platform doesn't show such a connector. At
>> > > least not on a device advertised on the web pages.
>> > > > Are you referring to this product in the Thundercomm web page : SA8225P and
>> > SA8775P
>> > Ride SX 4.0 Automotive Development Platform ?
>>
>> Yes
>>
>> > For this particular product we
>> > can see
>> > eDP 0/1/2/3 serving as the dp connectors.
>>
>> Please correct the labels then. And also please mention why eDP2/3 are
>> not included / tested.
> 
> 
> Sure, we will update the labels in the upcoming patchset.
> edp 0/1 corresponds to mdss0_dptx0 and mdss0_dptx1. We have validated only these.
> edp 2/3 corresponds to mdss1_dptx0 and mdss1_dptx1, and these are not validated,
> as already mentioned during the driver changes for the same.
> Should we mention the same in the commit message for the upcoming patchset ?

So the box on the store page has these 4 ports next to each other..
Please take the additional 2 minutes and plug in a monitor to the
other two ones as well.

Konrad

