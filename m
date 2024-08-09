Return-Path: <linux-kernel+bounces-281131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C15D94D372
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD0F1C2234E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DFA198845;
	Fri,  9 Aug 2024 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ep6/PmNJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F93194C62
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217183; cv=none; b=mVvvW/l0lMYsrUEq816bsqjX9B1+w0/WctZXTPQrzkiMfJqO7fBZygn/+v8ngjGmVsm8IuGoSKB2Xsht8aXEY8H/mHh/A0yKNJAZTqe6SiA84ETpBNxV6Z+9oDrcDfl7EhnJAduIbqH1hDMXbX4/hBd9Nky5zpAd9CUbrpZoPXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217183; c=relaxed/simple;
	bh=1P3Kt7aV9TM7gZlqGhc918Q499e0F9QQ19kqY9CgIYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eMIiHfPkl9CBMXoh96Uf2ZgUuKKXYkgv8Xw0EQa0tvyeLN3DuLjIz6ypE3xtSyvwD+NozESooyOlWvyMrPeyO6wL+R/hlojcygL6u48nrSAfRd4pj0z9hExNK4MZqsECMvhr+jfMtAwabtcKB5Bgmd6I5Mhu4pZw1HxoYEtCVWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ep6/PmNJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479AZl1P005930;
	Fri, 9 Aug 2024 15:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WEE1u6wKV3bHN18KOlGlYnK+mukJ0upSUse2duvGIzE=; b=Ep6/PmNJc57UbSMZ
	9k2o+lB9P+IHivJ4Gqq/+GO8q6oPpX0/Sl5pq+jfqAlZmcxw+piyrFpHGLId9uVc
	zRBqr+Q2OaVJxvZampvgstsF+J17VRRJ5VwvsHC9aXpB+xQiKn4dskJj+d2mSNIg
	domqqSkO+Jt1zZIrCzOpJVKhiDavZugaO/KJurU49deMwa88ru9FBpYQjlRJc1Mo
	nolPKn8yyzEtszXaThrADiqnEuTEHsV4wGs1zyouRVDmTeQTY19TgFtQLdmgPix9
	kn0eHFPtxpFuLSoFhEHsUQG/2Rnp5hrQGEe2F7PpJwr0o9KJyCgTK9h3WD9pF3zL
	w02wOw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40whg38q6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 15:26:15 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 479FQERr018731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Aug 2024 15:26:14 GMT
Received: from [10.110.23.148] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 9 Aug 2024
 08:26:14 -0700
Message-ID: <e0d52479-5341-4807-93e5-2e7e1a3f4774@quicinc.com>
Date: Fri, 9 Aug 2024 08:26:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel: drm_accel: remove incorrect comments
To: bajing <bajing@cmss.chinamobile.com>, <ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240731064253.24523-1-bajing@cmss.chinamobile.com>
Content-Language: en-US
From: Carl Vanderlip <quic_carlv@quicinc.com>
In-Reply-To: <20240731064253.24523-1-bajing@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eOhudyCWcoYQxgM7IG_A0UuefW5QWYrf
X-Proofpoint-GUID: eOhudyCWcoYQxgM7IG_A0UuefW5QWYrf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_12,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=912 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090112

On 7/30/2024 11:42 PM, bajing wrote:
 > accel_minor_replace is of type void, so remove the explanation of the 
return value in the comments.
 >
 > Signed-off-by: bajing <bajing@cmss.chinamobile.com>

Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>

