Return-Path: <linux-kernel+bounces-575575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F9FA70454
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA2E16AC90
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1420E25B678;
	Tue, 25 Mar 2025 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FanOVWdv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1584625A322
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914375; cv=none; b=GQ5bzNOT6UsaXGrf5xyghzBwryRIEbBYh+n+OIPwe6VNh2FPKvSj+uTGuJ/pmiUWaWJOU8tcems0eb5ahXOz7m0eSS+IF4j0z3dO+b8hbf7KQRB50a3uvUrZk8Yb4bj9BRLsei1lyjVXG2k04CP3GIryoL25p96NCGrFz0CDiok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914375; c=relaxed/simple;
	bh=d+kKsfl2TTj9vTCfKwIjZehCx6egu08uzHV5hFpXi0c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m7eGB/jfI3CCHJk8xsVsbiT1eQdmshA9RuuY3rdoGYh1c3+BkgssB5mFmsoWEj5DWNnf23SaXiiGSG9pwTOXCZtUYkvio0e59R5Ak3dKcfdxTZiC/dMDz39wMrf4SNBZX9l8leUU4BPMdfUv24lPUajPIgVXXmtCSMZAqwm25+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FanOVWdv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PDM6et028569
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ftcTynJFhZf6Ou+y+dlXrXlxZij+fB0u3WfPkqUsG4U=; b=FanOVWdvToSN62/b
	eW6+fkKgH4vKcZ3veFc7yfEXb+Rr3khkkdMVXH6U1UngLzagHNH6F8cDVe+5QzUK
	GEvsefQhWHyPGgxoycMaKSqp+uUa6FGNvQZ6eSYptJYBVpOi85dAdcMVii6iAUXc
	LoOCgBP8f7ATs6TwAo/cdvn7fRcI6yjQnfoSX9CGGUaMtKcLokmDSv8xqbg9kCdy
	vpbXnUN47r/V4Je8/mPr7Jhi7ZQqrxHnzUzYZ038VEyzPTsGi218JIhRl2LdkxDa
	QAGGMHQt75IEy/E8WGqNpY4yWgv6z1Rzur4ltIHdTVSgOjkLLjQ7TALPvrckcWg/
	6KjDZg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hnyjg2yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:52:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff6af1e264so16287587a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742914371; x=1743519171;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftcTynJFhZf6Ou+y+dlXrXlxZij+fB0u3WfPkqUsG4U=;
        b=O5EydZ0Q02TCg2IpzWvK94bPSIhlCX0LqQ/i4Zv1O9UG6OrH8NA+jwZPwKcF5sqO/y
         DMPha0lsyElEJnkESEOcucS3m42vswQiyeFvqU8y/XfNgendQ9wYPE4kS+8HV4UU60Md
         R8jLV0AxbZIQDN/NHnMNUSrXAVEj5MfNEBAkecIJq7Mrog7NZx5+mqfadiai4OemvmSr
         k0LYCsJlG+CEOAMhkl5+eNCwvNa+KjPxgicJet7eiePFprvzuw93jixJLhWZ3Mpl3snr
         u4ttfWMHQERwwjMr4TPrMnM0g+hCanQbvcyMJJzBJIW32tCT9mMXqxT04WSwGVkcJTIM
         hyng==
X-Forwarded-Encrypted: i=1; AJvYcCUllEmBgR3ekETvKcjJdCuadF1BlYs/q8/YsNn3XThb8+3eJEyduI7/hwqIbNfM4KJu97o5JozpOs//gCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcH6SRUEgEsEvGcc9CufJS0wSxOy3WZIxL+XOD5wqUkrISxYcP
	CRCzPEnIZuWfeChXbxG5lSjN6q/AqpsoEQ6hih7EQlxYAF6/1qxfaS1VAUKdzrp1F7OaA344xbt
	YVTj/relTyZeI+YvTKmS3vupf8nsnQ1cI0RPorUixw6GWCv7KWc3gRSLoxV0FErGwoz1wcqA=
X-Gm-Gg: ASbGncsQTBfKfOSOWaKdwxbGfaxXdfgaKZWgISyodJrjMpzs+6t13e2WGRo+DcED1rC
	J6KusbXiR9Em5wSHwjUiYmvk9ALHOxclxoOGOcC5jaKXecLzvV6oLbRVE3rmluD9pVcWdKn6tex
	G/LvBgYMOgGYj+V5qUv93sehax8D5Jq3OlT6q112MW33fyX+4LP2BSW80q2XrXCeByORazh+OrB
	2Xi/36XwBSLqCFgnR8EtTbQzzmb9elOK9/IiijCSSHWl3tJsFCRqksWNZJCeLN5LIimTcF/a8Vs
	sOwfQ5LW3KNPaJ14NES2fp/ZxwJClqfJJzz3yeHDe2hA9scynQHM
X-Received: by 2002:a17:90b:4a44:b0:2f4:4003:f3d4 with SMTP id 98e67ed59e1d1-3030ff08e4amr25846270a91.30.1742914371014;
        Tue, 25 Mar 2025 07:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGq37xgRTdz1JPqWrLC0RaHjS1VYwIHPt1R/tO8cE0n4o8nk/6ax8nuzgtSl/hVZJ/IF/xkg==
X-Received: by 2002:a17:90b:4a44:b0:2f4:4003:f3d4 with SMTP id 98e67ed59e1d1-3030ff08e4amr25846235a91.30.1742914370543;
        Tue, 25 Mar 2025 07:52:50 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3036c973cf0sm1136656a91.1.2025.03.25.07.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 07:52:50 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
In-Reply-To: <20250321-ath12k-dont-put-chanctx-in-arvif-v1-1-c8e93061952b@quicinc.com>
References: <20250321-ath12k-dont-put-chanctx-in-arvif-v1-1-c8e93061952b@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: don't put
 ieee80211_chanctx_conf struct in ath12k_link_vif
Message-Id: <174291436978.1215324.3680053989987464544.b4-ty@oss.qualcomm.com>
Date: Tue, 25 Mar 2025 07:52:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=Ybu95xRf c=1 sm=1 tr=0 ts=67e2c344 cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=2YHuQJzV6Ps-Yg4M2TkA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 1aJXVD5wLJBO40kU5wDeLf6mRgnlYNcz
X-Proofpoint-ORIG-GUID: 1aJXVD5wLJBO40kU5wDeLf6mRgnlYNcz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_06,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=777 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250104


On Fri, 21 Mar 2025 09:45:53 +0800, Baochen Qiang wrote:
> ieee80211_chanctx_conf struct is not put at the end of ath12k_link_vif.
> Note ieee80211_chanctx_conf has flexible array member inside it, causing
> below warning with GCC-14:
> 
> drivers/net/wireless/ath/ath12k/core.h:298:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Although there is no issue for now since the array is not getting used,
> this should be fixed to avoid any potential data corruption issue in the
> future.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: don't put ieee80211_chanctx_conf struct in ath12k_link_vif
      commit: ce0779378c62758a0c503bf85e643c6d8f343703

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


