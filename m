Return-Path: <linux-kernel+bounces-364145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEEB99CBAD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6DC1C221A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92E31AA7AA;
	Mon, 14 Oct 2024 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bevjQFGe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B480A1AA78D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728913145; cv=none; b=tkXvoWXb47S3iGhkJSzP0qaCS1vgtIXYwBwJpgoCQ30WaIoYLbJSeU+Yd4e/VDfX1Kxo4YqgI7uherisato2sQbcINmLZzopOJxySYZzoizVS+U6XgiVsFKOFVxmWSJqQOhdO93I+kZS/RgQFzg4h1okvVwwyFUK9q9Z0EXCg+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728913145; c=relaxed/simple;
	bh=CjUVBn/S4Q+F72+zjF5DYNpx7ZIySgxJCRYcbF6CNTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Thy+Kk+54H2WhUwfju51wrIDI1/WQDgMyhveqASh4I3qOyvoBoERqlGCoBbO9fTIFH7gBlSCZDaFvxNjn8rSxk8xsv6DqpcL8RdevgFGDKg1yuyqaPSQhWY6bTYqXTPaAOlIEykGADMz/fFQR12FJ8ySa6i7JVAZ1qie3YWURnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bevjQFGe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EAYids030609;
	Mon, 14 Oct 2024 13:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CjUVBn/S4Q+F72+zjF5DYNpx7ZIySgxJCRYcbF6CNTw=; b=bevjQFGe9IYePFtP
	uYzLq+WW3cjecND6B5nPb/MSYgXPLIdP9w0i6oz4B26EDM03eIOW8JSSMXtj2t0g
	5x9HUSLPNz0qFN05RmDKVh61tFLlJ0HAcSXR1lBFXoVWZsfIN11mlWEKtn3Yc5tT
	VG9h+t+YEA2IbeEXC3EEQIsFAjPY5/jp9UpirDiSjyDiNkhqRkCZ0eTDugh54eoQ
	Gz4GHbYwGKBp46Uff7CwUHuZIVVgFkIh27gHJDDiSQgM2OjsK+Y1/40/9IVeGEiJ
	YFV+kbtqR8nJHp0oXJDfw67xg0lpPzVzGhEaoSvInZRBCwOGdLAKpAb34JLpWwuA
	tp3Jxw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427hvfvdeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 13:38:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49EDcWt2010094
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 13:38:32 GMT
Received: from [10.48.241.50] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 14 Oct
 2024 06:38:31 -0700
Message-ID: <ba72f359-2bb1-4ec9-80e9-5787483d6ec4@quicinc.com>
Date: Mon, 14 Oct 2024 06:38:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/ttm/tests: Fix memory leak in
 ttm_tt_simple_create()
To: Jinjie Ruan <ruanjinjie@huawei.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <simona@ffwll.ch>, <christian.koenig@amd.com>, <ray.huang@amd.com>,
        <dmitry.baryshkov@linaro.org>, <dave.stevenson@raspberrypi.com>,
        <mcanal@igalia.com>, <skhan@linuxfoundation.org>,
        <davidgow@google.com>, <karolina.stolarek@intel.com>,
        <Arunpravin.PaneerSelvam@amd.com>, <thomas.hellstrom@linux.intel.com>,
        <asomalap@amd.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20241014125204.1294934-1-ruanjinjie@huawei.com>
 <20241014125204.1294934-4-ruanjinjie@huawei.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241014125204.1294934-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AissHuSG7Z1Cn_b0jGsmpTJnFArTyppY
X-Proofpoint-ORIG-GUID: AissHuSG7Z1Cn_b0jGsmpTJnFArTyppY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 bulkscore=0 mlxlogscore=776 malwarescore=0 mlxscore=0
 clxscore=1011 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140099

On 10/14/2024 5:52 AM, Jinjie Ruan wrote:
> modprobe ttm_device_test and then rmmod ttm_device_test, the fllowing

nit: s/fllowing/following/

> memory leaks occurs:


