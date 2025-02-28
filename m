Return-Path: <linux-kernel+bounces-538602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D16A49AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64843BC70E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3295D26D5C5;
	Fri, 28 Feb 2025 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OFVvvKO5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129F726BD9C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750086; cv=none; b=KE8V3/5PVVxlBNG/aVU/7LgHW/ZkBh4pH+CVUpHaSy06I+W5XJ+f4LDpp4VeGklKqGj8I/opw+K3fsAeD2FY4iw+ysIsNOCC3Md7EEpWDisldS52BZA5a32rUV0HhnUyW1sS2uMx3ZSWp6GywRl7nSiL6aBcMSp+qHvUsF8LSbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750086; c=relaxed/simple;
	bh=Ax5JUoU3RcHfeYyH++6cTU4Zxvsp74d7jkQ5i9Jdaqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VxgpuqqVlYuohgM9Wl3V0Es+6Dkvr11xuMqQenVXQeHA64e3BiN7sFUjnmzg0Bzz/7H5xoQWdr27BnTPL6dyQhKX9yrxgEqqZORc5F3try8lvjN8NpA8PU8n8D+hGJXOoJMhAUKo6TIH0ZDYgGQiNrKKUGQDhBgPQNFqiv42ejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OFVvvKO5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAXIHN008994
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nxMCwl4XpxYnWA6xmBkQbDigvX+AcrDze/AyDFhTQLo=; b=OFVvvKO50iAK6F4O
	7oBdGSE93x+vZbkODA6AyP+uDUwURPPWquO3ElfzXrZ6xUagG/WUH23epzsHHELG
	k4Brn0xhLfkPJ75YDEpFQmLXPCGbUJBbMELT7aXfoL/hxROIaXGa6IjQb8QOilaP
	NYfDrJauA0CtPVZwBTCg1zoLaiD/Fc/fMTOsLScChCS9Vgjmoqy2xZ0jUOCHV061
	gMbgZvOhWFk8wfGQZMTV6eY4yn7EIiRUuF+88oY143hoD0u3vxktCcB+IzVVjmdo
	XX8OCjgmNFJX/SFyamIU4OveawDJPN6xvv1nGXUWe9mJe77RaI0NIClIZjYtac/0
	4QKIfw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 452be6p5eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:41:24 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e88b3d5d8bso4228666d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740750083; x=1741354883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxMCwl4XpxYnWA6xmBkQbDigvX+AcrDze/AyDFhTQLo=;
        b=X9/Yr700QkzSd2L+o6CHY6BMEWUF7hTMciGCCEbw2s3DgO6KzqmyH1yTuA2QGEQeN3
         ArJMmbV5qeCjW5wNp7NM7txtKl0l3KVQSBzLkAJ4Q7BXuFUrnK1NvQnpTel1iWavSLwQ
         mbUe22295x0OTdzkKn7q3Phz4ZM9/3bnRvByVSeKmitjMH18DXeycrGT0787GbD4v3qO
         5/O55e2pqajKyeCdwaWHQ0d9WkD3YZ++DXYndUPKlnslFMXJrSFlcVTLyUBPpepRc36M
         lsqO5cszLNxFqJlAPsSw1v9t/ThvE/p7I2XaUS5TelV431hWfe3uX1JHZ3L7gRxH7q96
         7HEg==
X-Forwarded-Encrypted: i=1; AJvYcCWO/SWz4dtA68QDMcelEdZ2kRdYNJZNtxoKeLCRJzC9QnAGoNZ/4/sMRBlwfESej5DE4ovkOk51tpYU3As=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXGBCl8GfsWEduBOgvXTRl8ZOhucQR5x4msqfzTxHeOTpDvGPR
	5WI39wdD3w3+M5Hiw7b8NuFouQHKqhlbgYHuLUdmCPErN1+8DZgY1Bp7pLrZ4+v6cbZHr3YNNlg
	N3sPyHGC6lHKT16aZOw7PVPbBqCJE4wmRxBfoWvRWEc7S41CSW1uqqRDYNWYBNHA=
X-Gm-Gg: ASbGncvfWgyqEGdJuKcWuUzpI4iyAw2AXgyQBv7WbEF+fEz4ydenfpWBot9pcIsnxpL
	2ntpGxD84ayp50FIXn0H26BMXQKiVo0k0NTIjs9Q9hqfntq4NSGbhcD9yhVOR73Cv4EuxdaZwWf
	qqABeZo4GYLwQB7pJLegJhLyzYveqPKfMT0MMVCfGJVonevF8OrBv+BadSJlhJdz+70E9k+m/8T
	o9vwDTghvC8yWu9wVVunD8mIM4DBEEeYzZeNLCHfnaqKJzlGgOfkBnXMgJ+WSJTsZFVH5Q7RZ0e
	rhQ9oPFnteWAl6H1ACmkztmKoovTLFilg8q5hPerzAwlUAkXzB0V0OeaTCbK1vyEBZKsmw==
X-Received: by 2002:ad4:5f87:0:b0:6e6:5d99:d1a5 with SMTP id 6a1803df08f44-6e8a0ace905mr19202346d6.0.1740750082898;
        Fri, 28 Feb 2025 05:41:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjQWfIes2GbLXuXvq0DgihsoT/bAGgb6fDqf/KTL8rxJT7bL7aWTL0JdWW7i7ONoFuTU1Q7A==
X-Received: by 2002:ad4:5f87:0:b0:6e6:5d99:d1a5 with SMTP id 6a1803df08f44-6e8a0ace905mr19202076d6.0.1740750082389;
        Fri, 28 Feb 2025 05:41:22 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf42c16af2sm30308466b.116.2025.02.28.05.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 05:41:21 -0800 (PST)
Message-ID: <9325e4cf-425d-4fca-a458-20cdee6e4111@oss.qualcomm.com>
Date: Fri, 28 Feb 2025 14:41:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/msm/dpu: remove DSC feature bit for PINGPONG on
 SDM630
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250228-dpu-fix-catalog-v1-0-b05d22fbc2b4@linaro.org>
 <20250228-dpu-fix-catalog-v1-4-b05d22fbc2b4@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250228-dpu-fix-catalog-v1-4-b05d22fbc2b4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Zegq5IdMPdgivJUjVVjpJ9DaNiESg7P6
X-Proofpoint-ORIG-GUID: Zegq5IdMPdgivJUjVVjpJ9DaNiESg7P6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_03,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=888 phishscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502280099

On 28.02.2025 3:40 AM, Dmitry Baryshkov wrote:
> The MSM8937 platform doesn't have DSC blocks nor does have it DSC
      ^
in all patches

Konrad

