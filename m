Return-Path: <linux-kernel+bounces-577289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE29A71B02
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11E43A7597
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89831F63E8;
	Wed, 26 Mar 2025 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gp7O5FyI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986361F3B98
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003676; cv=none; b=ZprmN2HH+L+4mOaomNULNMcH8HeJbQZV2XSB/rEaMeBMaUXcndP2QWmqWCTG+wDfHjIQf5p8wAPzETpEpCWopz1xKFM5mIS1IXoIWhR01IhY/p0FbxaLVofyjofD+k9UPiqDavnwpZE4x4Ykfxf9urrNtXdzZsJw3XAw7VIXq/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003676; c=relaxed/simple;
	bh=fzfdMlKqaXubyatVU2YdthyvsoU12xFxPbIEjhB7qs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXQ4cSb45Jv4kSIOS74eRkvN0KyZojJn/hR3BvilwB8/loixaQt2y7ry7Hfxi/meYz1ogr+NvB8qd0LcZXGO5RfSb7gSHEIKEjVuo7OBje3L3WhcxyaV9z9xFS1vBvLGMexzEZflqZemEha4EdSfgJybv7W4KpQLbjuuNUJ7uoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gp7O5FyI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QF0I0w006142
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JaWfJx73MJITf1MAGS+5QLKh97/YhkXy5JoIZnID5V8=; b=Gp7O5FyIP6Gqz6dK
	XVI+I/XaMl9cTBDvfK0wKvYyDmMMIkTtSTeUzl/P3Bl9Qh7L1zj03mkKwcoXFUpD
	NmEVHWYNLJHMYegZxYq6WEDINGJENLMuismtDGr3N63n7P9xXWY+UDX70RzFVIqQ
	+MiwpFYLdCIHPiO7IZMY50Bqi6tudbCWYhz2x4/dfB3hyiKDtUum5S+l+Gi80A3o
	SnZ4ZOFRAnn8BE73B9PhxILIFE87L6VSFebsefNbmNKB5D/5JY/CPR2W6x3S9kcu
	Lgdw2TeGwTVQOWZ40qF2TrMUQKozY/krpsjszkUIplomuimXknS+P94Omak1/q/o
	X+IHGw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45manj1umg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:41:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2241ae15dcbso516765ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743003672; x=1743608472;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JaWfJx73MJITf1MAGS+5QLKh97/YhkXy5JoIZnID5V8=;
        b=XiLEKLs7rAG2UPPw8ONaAJXBd9BQnIfk9dZ6cv6hyIoDZRuhFyQBoGlcbnuu7V2Ckk
         PlF2hsTphlmc2yuq9pQfYGJe1lF353udMJb848uYrL6SgoRAbx2Q53iPvxC/3IZAOGnH
         e+7s/Whw18iF1PN6t7OLE6L8EnMm0HrC2dqtMnlAiMG9RKizMi/QqcOCZUY/OgKJblpn
         mSHPeJ5ZW4MXQViKgtQcrUAsVNDNrzLy7OgdVXZ/Dxs1cc/Di4MWwBs7wBlLtdJJWz0y
         Yg2Ssg2mhocFh4qB1451HbqsKktdLuEuiYrinb3Zl6CsiKiFWHpcYvvRRw8uAylUqeDR
         euTA==
X-Forwarded-Encrypted: i=1; AJvYcCXo23QxE4rgLKHeHAkSweQ3XrH4ATpdJGFQGkvSk5dBaQwne+F+w5CyPIuBBFZ1aqM3TRD25vLwA7nqmMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpvGdHwcVf6K6jpq15I2Jk1+DnIEjtZnCbjDUCaflI7DuvE+TX
	xNFjGOuZ3qc1lhHbszbwLcMsjW4lKHWwRGYuYZG/QrxU249BsIZcMxWI7CGXpfhBSo3NJ+rUfWn
	E7Z01tiWPBBMqt92Bq03zEOJ/odFcyiPKXeagEwpDM/smgnQX/0bWjnLEiwVkblA=
X-Gm-Gg: ASbGncsq8vwAgMcihEmX+/JP5A2rQGCV6oPh84xLMq5Wx/IMdFPO/SgB706eDGE2AS3
	n1QIcaX3faP23PjG9mxRGBJ9VuTrdk4HwHgFBEpJS9I2Q0Gx/RpoNyC1fjavOSPlrzmIL2jFbT2
	HfnKVVhfutprzzF+tX32VVWV7PgR5bHltglfntdXuMMViFSwatTh7lwPbnt4f2vA4ZmW9kdKMDu
	QivQ8H7N5MVANc/Mix/+ofak/0uDlV7pO+w2QS4K1wwfREBS8yhoTIl05bTppsHv62QdxgqL9Pg
	iGg7sdwY3SyEkYbyow/bjT16tkCXAD2Nv4jGSnvpLduCyQOlIa6ICh8jTSCqp4wJrjtu+MA=
X-Received: by 2002:a17:902:f646:b0:21f:6c81:f63 with SMTP id d9443c01a7336-228048551b5mr595415ad.16.1743003671660;
        Wed, 26 Mar 2025 08:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnH5u4MzTNZ2itV/SZImEzCKgZzaGZ6mk6zIodOEC2MvXI64y3FpBAUpsvlQ360/Koa9EetQ==
X-Received: by 2002:a17:902:f646:b0:21f:6c81:f63 with SMTP id d9443c01a7336-228048551b5mr594745ad.16.1743003671066;
        Wed, 26 Mar 2025 08:41:11 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da347sm111163645ad.161.2025.03.26.08.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 08:41:10 -0700 (PDT)
Message-ID: <f922860a-e4a5-416a-bfe4-e22a8653ad8c@oss.qualcomm.com>
Date: Wed, 26 Mar 2025 08:41:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: extend dma mask to 36 bits
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250321162331.19507-1-johan+linaro@kernel.org>
 <8edf77d9-1afd-402a-b966-d1b3e5b4ba1b@oss.qualcomm.com>
 <Z-QaMwB215vTKSTq@hovoldconsulting.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <Z-QaMwB215vTKSTq@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bTIOO5qcEpj9aloJyX481iyyK1NY8uLI
X-Proofpoint-ORIG-GUID: bTIOO5qcEpj9aloJyX481iyyK1NY8uLI
X-Authority-Analysis: v=2.4 cv=KvJN2XWN c=1 sm=1 tr=0 ts=67e42019 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=wpi7UN2eRMKIAmbdDfcA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_07,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=655
 malwarescore=0 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260095

On 3/26/2025 8:16 AM, Johan Hovold wrote:
> On Wed, Mar 26, 2025 at 08:11:11AM -0700, Jeff Johnson wrote:
>> On 3/21/2025 9:23 AM, Johan Hovold wrote:
>>> Extend the DMA mask to 36 bits to avoid using bounce buffers on machines
>>> without an iommu (under OS control) similar to what was done for ath11k
>>> in commit dbd73acb22d8 ("wifi: ath11k: enable 36 bit mask for stream
>>> DMA").
>>>
>>> This specifically avoids using bounce buffers on Qualcomm Snapdragon X
>>> Elite machines like the Lenovo ThinkPad T14s when running at EL1.
>>>
>>> Note that the mask could possibly be extended further but unresolved DMA
>>> issues with 64 GiB X Elite machines currently prevents that from being
>>> tested.
>>>
>>> Also note that the driver is limited to 32 bits for coherent
>>> allocations and that there is no need to check for errors when setting
>>> masks larger than 32 bits.
>>>
>>> Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>
>> Please make sure to include linux-wireless for all ath.git patches so that
>> they are processed by patchwork.kernel.org
> 
> Ok, I'll try to remember that, but it seems you need to update
> MAINTAINERS to include that list:
> 
> 	$ scripts/get_maintainer.pl 0001-wifi-ath12k-extend-dma-mask-to-36-bits.patch 
> 	Jeff Johnson <jjohnson@kernel.org> (supporter:QUALCOMM ATH12K WIRELESS DRIVER)
> 	ath12k@lists.infradead.org (open list:QUALCOMM ATH12K WIRELESS DRIVER)
> 	linux-kernel@vger.kernel.org (open list)
> 
> Do you want me to resend?

no need to resend -- I already picked it up in my 'pending' branch

Let me open a separate thread on the MAINTAINERS issue.

/jeff


