Return-Path: <linux-kernel+bounces-511555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A305EA32C92
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CEA16393D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F7A1DEFDD;
	Wed, 12 Feb 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NU8DpwJ8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB0C253B40
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379286; cv=none; b=MhEdpV1tGcrxWLKsNgbVCAP4H4V7xj9JD63MprBGp4LBZitt5Vei4QQ3DJ9eFS9MgYSx+cRooHc52jpgc5pub04M+mNmnhpAM13MjbBpInOtu1Yp98Eaa6j51sYsO11EbqA1NmeMz1m5GXEOu12K9N84c6Y+ne5iDYsxmIUufxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379286; c=relaxed/simple;
	bh=wkaUg1DENSD4yHymFSi2ejg0prL/M/EWygSMyN+dkvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJ7ZJZxDFkMQTJxHrSTghmF47or9BANpeuzgvqNedFiZs6stmT/pKcHhLIn7SQRm7PYHhIe1ulYD66Zw3CoJaeCtmgVtcfba6cGj7HUS9GhHZZNHtQCw2ItO1Ytv228f4JqM12AmOU6+WHebyft2tr7WPaBJJyKoxCAloSCwNW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NU8DpwJ8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C91wgD001378
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nfbHxXfLDJVGtgNZIgeGSymwLVT6zSrgg/aja6UrOP4=; b=NU8DpwJ8CmbsbmiF
	lsoXBD4n34MNA4ARVp5HzKP90RqInNXWXXHBR6njz5YKZcuXQmpkdHwq6ZNR1OzB
	YZWT9Cq4eZ/FnRIwA4iR2QTNWR2ZK25uc3VlqYxFj8tKQVGL1b+Zl640Jg/jvW1C
	0YNKYpwu5zgJBpM+8klt+0MB9jKIsq6vrVMCA39oKNVjfD9/sOlbS6C5MsA/n6O8
	d1UyD0gybZQ23wBSGlZ7fLXagn8/iUwKRuZVqcIvtC1Ke5MT1hizU0FynsgNpHw+
	vD9lcahJnutDSOTbmbtqgqXt4dA+M/4oSRj7oXhGnt34EPQCXuI12jST2hYEecO+
	tZqHiA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rrnfs76w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:54:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fbfa786a1aso2850118a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379282; x=1739984082;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfbHxXfLDJVGtgNZIgeGSymwLVT6zSrgg/aja6UrOP4=;
        b=xUQw9doOmSoi6Cf/t+vMyKRCEXpoT6g98gOV49uMb/GiBiOxzIgRDSGGeDyF1MwZ+0
         Rgw1w/Ad6PY8gUauqh/t6zNVBy75f684DeNvI8uyUpY7EDpa3Z2+1W7cAE7uPb705rQL
         lCwIztlAx6jB0vn3xwG4Z682HToYapm1I98jj6NsNwpQBxk222FFWV6q3bjGia5eFeDG
         /hR9O+u8TvIBb/tDQ1uWWv2sJ24X3W1idSSoEnfTx0qjITw/ZcdUk6ACu77usqhIk0vL
         K80VlPnBXeTWUcy2SWAeWfWXBBY9DAo0uwyj6bL/IcJ//DBjFNAHQAJwwL6CE1jKjcef
         JmAw==
X-Forwarded-Encrypted: i=1; AJvYcCUUYNj3o48cOMI5mAMxTL+E1SmUv2PWy7SMfVRFQRJMbSfFYz9RZr9mjchZtnWobd7gSI44Sbih4m3Jzkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3f4v309S061BKdDFvbiwMMIAsFEDYmhB4HmnPsjVb5UV/pOaZ
	D43c+m371rfG6ihrn85KcGSXYHCoyT3/4vuJZpgfC825hQUT1dvM6pj0/o1UtHGk0NaFPkqzu5m
	ve0fokEeZ2WfoqaNAopOrSbZnI+aDkNKpOcs921RltnfbZwrZHOSfit4Yqbtmxf0qEvg5Sbk=
X-Gm-Gg: ASbGnctqOqnHCVV30HIVpK2b2BN+YOXEzDtrvuf5YyrMyhJ5i/Oa2YJ8nlFd/AIoZgi
	wtRY5vQHRz/7SeSY+7vwdJUei8mwRU59jvnAG1ql0LBbScSEHvQlybERjzOg86Is6G18dHw5dq6
	4U+AU+o46baojjAArRg+6x9iw30LH0zYvKWwOA/DlnUQfxtRedP/bhcrrJPmcihb2VoRDuvZhr0
	AoETEfDCQ8t1wEMTW4K9ovsuXcVozlFjOuTJEjpGA+JcvlPpCQXhJWydswKB9tGHguOAZpzkXJI
	8AsXbEtE4N2GK/2Q2s2EnF6qePwVx3c9Vp64Ymz2XdfTvvng3vHD16bZ6hS9
X-Received: by 2002:a17:90b:134f:b0:2ea:83a0:47a5 with SMTP id 98e67ed59e1d1-2fbf5bb5735mr6133331a91.4.1739379282023;
        Wed, 12 Feb 2025 08:54:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGx+CWks0nvoqMOT5wEtwjJQXwKdPFly96tXraDduozSmPBMM+3wmzaLt6FvkicFgrTncPtIg==
X-Received: by 2002:a17:90b:134f:b0:2ea:83a0:47a5 with SMTP id 98e67ed59e1d1-2fbf5bb5735mr6133297a91.4.1739379281639;
        Wed, 12 Feb 2025 08:54:41 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf989bdcfsm1721378a91.3.2025.02.12.08.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 08:54:41 -0800 (PST)
Message-ID: <509cb1aa-a0d9-4444-9a54-0edc0b181d61@oss.qualcomm.com>
Date: Wed, 12 Feb 2025 08:54:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: cleanup ath12k_mac_mlo_ready()
To: Ethan Carter Edwards <ethan@ethancedwards.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Kalle Valo
 <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20250210-ath12k-uninit-v2-1-3596f28dd380@ethancedwards.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250210-ath12k-uninit-v2-1-3596f28dd380@ethancedwards.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MdBXMSZlM1GTwpoQndhkNGxicLgp_L7k
X-Proofpoint-ORIG-GUID: MdBXMSZlM1GTwpoQndhkNGxicLgp_L7k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=710 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120124

On 2/10/2025 6:49 PM, Ethan Carter Edwards wrote:
> There is a possibility for an uninitialized *ret* variable to be
> returned in some code paths.
> 
> This explicitly returns 0 without an error. Also removes goto that
> returned *ret* and simply returns in place.
> 
> Closes: https://scan5.scan.coverity.com/#/project-view/63541/10063?selectedIssue=1642337
> Fixes: b716a10d99a28 ("wifi: ath12k: enable MLO setup and teardown from core")

In the pending branch I changed this to:
Fixes: b716a10d99a2 ("wifi: ath12k: enable MLO setup and teardown from core")

To fix the checkpatch issue:
WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: b716a10d99a2 ("wifi: ath12k: enable MLO setup and teardown from core")'

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=c2f7ae223cd3d781c69337dc804f1fae95789cdd


