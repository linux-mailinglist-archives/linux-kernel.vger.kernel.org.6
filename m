Return-Path: <linux-kernel+bounces-372444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5641E9A4897
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8326A1C22C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CDC212626;
	Fri, 18 Oct 2024 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TfRJmjOB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2267320E02B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284830; cv=none; b=kyqQBK9DblBT86aA+PhhgiNKV2TPm/gs+kxSLFrBPXnX7jreAA5k5p5gd3ZyAVnQA0FKBOuTgPvysO9q9ymjoXLE8jsAyq0pNOtfw9QyoU/L1cb5R3xjKCTmNpB4WHrP3awRC3+oMR/K8DOLsAA9zwd4VNksgrIcdZOzLiRwfVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284830; c=relaxed/simple;
	bh=1omYHFJrcCKMkSTGJVBpkmsDl02hRngAfIC+yfdxAk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rthcS8ct+rWN1VdMwj3CKuyYj8S37nyiYzOdSC5SOPHRZGcfez9JOUo5VQGVrzDoPvJzHUS9oDP0s/uKxPoH+FohjikAqM1MdfAUK125EeBt9kJycGCbFae6VFzSmrtShlkcNlkDhbJxhZGBSoF0G75hDdc8rWk7Lst8I2gC180=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TfRJmjOB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IAMjeS018286;
	Fri, 18 Oct 2024 20:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xs8IRlAIv1w9/0UDEOWIqVd9oeiDRwLJhdPRxrGB0EI=; b=TfRJmjOBUKEHBKnA
	4nNM2yY08xInfPVmnXD32ezEiWAPwRa3Xt0pwokM0CPZkiJ6n7Kr0AsHo3HOEVqx
	yO8st/2Pk25ZIj2V4rUMeANrtiboZa0J42/E50ngi+UeS4zb1YIqBFCXWdt1uYYE
	63ECNhVexkudRahH0BsCylM2T1zqs6obJYFripUASUq6qC7+qSC11L7RCO0PC47Q
	ZrEH5b60kc5OFEr8sL3NNYTOH8E6SXQB5Nb6Gh9Xmnjxh8G+SZhXhJ3YD87x02cj
	731ff7PDyJg6osrJuvYW4njPchVvPeVmGrMtkZFCZ5VJR1BNXc4LB45wW9WmmsRl
	eTwFFQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42b0rx5bgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 20:53:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49IKre4A030328
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 20:53:41 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 18 Oct
 2024 13:53:40 -0700
Message-ID: <b7fc7b06-3e6d-8a05-9dd4-8aa39a4e80fd@quicinc.com>
Date: Fri, 18 Oct 2024 14:53:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V4 08/10] accel/amdxdna: Add suspend and resume
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>,
        Narendra Gutta
	<VenkataNarendraKumar.Gutta@amd.com>,
        Xiaoming Ren <xiaoming.ren@amd.com>
References: <20241011231244.3182625-1-lizhi.hou@amd.com>
 <20241011231244.3182625-9-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241011231244.3182625-9-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dyyquR6pZxiLZO2CWCE2j90n_ttcbLnN
X-Proofpoint-ORIG-GUID: dyyquR6pZxiLZO2CWCE2j90n_ttcbLnN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=702 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180133

On 10/11/2024 5:12 PM, Lizhi Hou wrote:
> Implement PCI power management suspend and resume callbacks.
> 
> Co-developed-by: Narendra Gutta<VenkataNarendraKumar.Gutta@amd.com>
> Signed-off-by: Narendra Gutta<VenkataNarendraKumar.Gutta@amd.com>
> Co-developed-by: Xiaoming Ren<xiaoming.ren@amd.com>
> Signed-off-by: Xiaoming Ren<xiaoming.ren@amd.com>
> Co-developed-by: Min Ma<min.ma@amd.com>
> Signed-off-by: Min Ma<min.ma@amd.com>
> Signed-off-by: Lizhi Hou<lizhi.hou@amd.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

