Return-Path: <linux-kernel+bounces-364894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EC199DAAB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3C01C20398
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A661EC5;
	Tue, 15 Oct 2024 00:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HUHOWLOh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232EFE545
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728952005; cv=none; b=pCDxzKzmWRYBhY5jv8fM2S9fzrC6g/aIeVTD+ZPV2+Sap338x0YQhGwdUNwZP+BklyU/Ej0U+FUfIz0doYiN7jsn5spWuOuW1vlmxc5UuI+EolCi+L0cObl5SwYh5n7A3WPT4ksX3a62erxZFeZT9uif4Hx6QNphzjK0ahQ4RxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728952005; c=relaxed/simple;
	bh=l4zLxvDJsAVS/At3mKrydveMz39oTLBR5MChkTaUs60=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WPypebdUtTPrToUC5gtF+AQzu/QhgvAKjgbTQ+NqMQNBwt2wuW51p0NjCrw7VvjuKtbeHAK2Kp5nBVbExuSZqyEsjn1mehKZ66wJ96OgCCXRroqgWhJfL14RolHUnfwJMEJ/V7a6Q/6vH6pfDMIpvl0JEMgVGmG6QuZKWyc6/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HUHOWLOh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ELo3Np017312;
	Tue, 15 Oct 2024 00:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l4zLxvDJsAVS/At3mKrydveMz39oTLBR5MChkTaUs60=; b=HUHOWLOh/95XhD05
	H0VywCiBYUtc3dkwYOtv5SxmQ0V6g6v+YqrcxINeeTKEgduwYhTtLNv1BiSj0Zau
	oxMCNUC/L0B8yv2D95+895mUgIBqb+MrCYF+CZw9xQEvfbyZMN7PGSxJpvXGIBGg
	wNZQ9A5jLUJUHhXW/ANWwFTUetTmfkEVPHYIArPUxm5oVWYQSHmBjE5IgsP1W5us
	SECekHtlVx6sHcwh8fR+kRvbP0H9PO7xr17KVvy68QTOjLXxlVge8Sic9wTUM17K
	ks2/1N6roF7T6bSg5Pe79p7S4FWaZ65zEgCBVgr6tX1Fr5zKNN1zndVn7e3qvHyd
	rLWgTQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427hvfwsg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 00:26:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49F0QKDk014433
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 00:26:20 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 14 Oct
 2024 17:26:19 -0700
Message-ID: <1ad917db-6039-4269-8f59-a6d03557d27c@quicinc.com>
Date: Mon, 14 Oct 2024 17:26:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] perf: Add dummy pmu module
To: Lucas De Marchi <lucas.demarchi@intel.com>, <linux-kernel@vger.kernel.org>
CC: <dri-devel@lists.freedesktop.org>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        Ian Rogers
	<irogers@google.com>,
        Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20241008183501.1354695-1-lucas.demarchi@intel.com>
 <20241008183501.1354695-2-lucas.demarchi@intel.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241008183501.1354695-2-lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: myxkk0DnE2wv0ZQXmPwC3wSJAQDLWDBK
X-Proofpoint-ORIG-GUID: myxkk0DnE2wv0ZQXmPwC3wSJAQDLWDBK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 bulkscore=0 mlxlogscore=927 malwarescore=0 mlxscore=0
 clxscore=1011 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150001

On 10/8/24 11:34, Lucas De Marchi wrote:
...
> +module_init(dummy_init);
> +module_exit(dummy_exit);
> +
> +MODULE_AUTHOR("Lucas De Marchi <lucas.demarchi@intel.com>");
> +MODULE_LICENSE("GPL");

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning when built with make W=1. Recently, multiple
developers have been eradicating these warnings treewide, and very few
(if any) are left, so please don't introduce a new one :)

Please add the missing MODULE_DESCRIPTION()


