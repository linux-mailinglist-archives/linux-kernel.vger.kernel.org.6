Return-Path: <linux-kernel+bounces-444813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3211A9F0CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B5D282FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF82F1DFDA4;
	Fri, 13 Dec 2024 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DRbcDfuZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF2A1DE8BC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094938; cv=none; b=mWd1gc1y+Yvc7G5iCPBUS6EmY9Ik12GtNxcXkN0FGRdiJdPHODknkT5iKW7S97or8m5F7zgPIMDS2O+0Gyc/0XHct5I42+UkpeW4hienJXqla5Qy3FA4tU9gH8tk33Slbr0QH7XIQx1dN4Ecd/VVChJCeEv1R25J1d3cviNBZxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094938; c=relaxed/simple;
	bh=iOEfQyQsNuXaf3N32OHosNe97aGB+AUkThk0r0LsUN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jer+zOFseQo/adCcT0mxp7Ye637LuN9scMKLzZAm9m5CNIr0vLeWLlxlFUbK7JJC0G2JI7hrH2RSenMGbZYwFerasa/8zBbr07FrAyqnLiu3zYKAN8jcV6h/FCe/5otpIai6n59XDZCa501nMc18vBo+mIR7jn4qVoX6lvKwRv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DRbcDfuZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD8PQZV032215
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AyLKSkxMfzLQMuOI6wWqcI6M3kDCMcIlv74yPFOfap0=; b=DRbcDfuZMwE9goX9
	uKyxPkauLTAzUqvfJYfbwafmivCRzFtTAHaHCVyp56Wi6zVRkKemiXI6TNtNlInK
	iXSN0e3tjaiqLAtVjxz9XW71db8G4QRDjoFDUWCDPp7cM0JaQ2e76s/R+anUfUqM
	2TJX7fSVo1Hd39vR3MtQeK1utIQp3c+FxeE6n50r1sHHkDKhY0RQbgHEUUZTChLC
	kJkYjYvPaO8Y9KD/zigW9iCuK+feYMiF43+w1N7rFhc5wrtmsVzujAXxsjykVKMx
	P6XL/BgDP+GbURUzjBcGXdnCzjO9IznkmePRlBJsAc7QcSzbKDSZukZUv6cd57D3
	L2aFQg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f6tffn70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:02:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b66edf3284so14992885a.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 05:02:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734094935; x=1734699735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyLKSkxMfzLQMuOI6wWqcI6M3kDCMcIlv74yPFOfap0=;
        b=hi+7nGBLRrW+71vRGK37wfKyhAKrsNvVUG62kBK4XqiE7Efn8A6Om3hhcLiLoU2EC7
         GR26jjduFXNVjR4mC52eZ6sCTbUCT2ek+J6tk8hySEvOtaBzVBymR0GuSu+oicTF/wso
         AwV2LL/4RXkldULPsJNICHeL2hcmilV/5El+mtIb4CJ8hqET6uFx7B20jcD+DY3OqrHk
         KrPBfcnYYiyjlOLDo4dxoBfuSbPYNiroBeXO23YiHQSHZeEXD+t5Zrsa0gLNHymlStPb
         rk5u9bRJYn56Sgg+eI+MhGH2JD5NfkLcmcvmcRXNW4C/98whdLf6ij8dxkVxYXGvd3yW
         gGjg==
X-Forwarded-Encrypted: i=1; AJvYcCUdHQ5Zu7oFvNmqCnfUd/oBoFegFKguHjPTC02DoyC8eFQbANMkrL1mbJO5IfYZg2aOUpkXXDTYXGGlNKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/08bgHxEKqIaY0SzBXUn5VXjHjrBg7/GPgx5kFLg3EN8mWPWS
	X8YvD2+OhHVxQXcxKxnAGkcjV2aqIObjYH3ftHXFdo2RVpliTJlhmK8LGSDe+cujZ22zdiPL/X3
	nVnMA58twnOyP1uo32/kads1usVZV33i0nbS+au8X1PjukbYymkJCOnfbtB4gulQ=
X-Gm-Gg: ASbGnctIcuhHi8Fx5tF1ET0zdY7Dz/5acw3EYCgvJVILpBuBhsoUuWRlA0xCiUm/kL5
	BN0O3DfMvSj2OTcmlSQTu7X01GyV8PRXjrnwtR9QimD+Gc9Jqx5+04txCXw5zDU2LrvCh50fh13
	tleUeR80DaiYAaKHvj5zwRZ6P7sEunM1ttrJYtFyapRBm72nF+wwZ198fi4fNieF43ex+ZZu2Zj
	vkXNfUYTBPtFyCbcRvrnmh3gMG/oHj/KlOawUHqzlnozcRfodoWAFPwkoVsBtaUGM8UU9nxU3dF
	I5Lwij4fr1n2DniwIoZF3YTdnsEtg8PL0ysz
X-Received: by 2002:ac8:588a:0:b0:467:515e:f6cb with SMTP id d75a77b69052e-467a581d8c6mr16572071cf.13.1734094934825;
        Fri, 13 Dec 2024 05:02:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEB/qKsO2qQ9TqH35BOvKh8R+oWfZaDUjS/Hnb+D88tpTtjOAzvdxZJdhsflb5KmuYtAR8pPA==
X-Received: by 2002:ac8:588a:0:b0:467:515e:f6cb with SMTP id d75a77b69052e-467a581d8c6mr16571681cf.13.1734094934178;
        Fri, 13 Dec 2024 05:02:14 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6ab44e881sm418927966b.26.2024.12.13.05.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 05:02:13 -0800 (PST)
Message-ID: <da39ded1-8904-49a9-b58f-4d31c768bb55@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 14:02:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom: scm: Allow QSEECOM on the asus vivobook
 s15
To: Maud Spierings <maud_spierings@hotmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241116-add_asus_qcom_scm-v1-1-5aa2b0fb52bd@hotmail.com>
 <AM7P189MB10099F929FCE7AE7B348399DE33D2@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <AM7P189MB10099F929FCE7AE7B348399DE33D2@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4S8593tWvixnC1I8ANCAfJ4HCXUvpOgU
X-Proofpoint-ORIG-GUID: 4S8593tWvixnC1I8ANCAfJ4HCXUvpOgU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=845 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130092

On 10.12.2024 8:13 PM, Maud Spierings wrote:
> I fear this may have slipped through the cracks as it has not yet gotten a response.
> 
> or does it have to do with [1]?
> 
> [1]: https://lore.kernel.org/all/20241103-rework-qseecom-v1-0-1d75d4eedc1e@linaro.org/

I'm not sure, but I'd much prefer for that one to land instead of
having this list grow

Konrad

