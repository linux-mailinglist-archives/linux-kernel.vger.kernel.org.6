Return-Path: <linux-kernel+bounces-577470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B541A71D83
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B1E18875E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F72323E331;
	Wed, 26 Mar 2025 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fexh2oru"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DF623E25D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010910; cv=none; b=S812GRo2tr+5TtesVKAoO+ipxq4Hb9jA9UAudtmPoUGllP6iZ8dPT+BnFfQnmEf091LTvjbrwIbFuKbcgReZyfUVPGYTepawygTLsnWrpJ8JqeX2JYcDeNKdpb+DFe3HYkzYSPaNcCTXeU/gtYBDyLrcdX8oY64YRqbtCiiBPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010910; c=relaxed/simple;
	bh=VbMAnTpopdjLkmZXesRjVC8mZ8m6kPoSqNU934M0L50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+xWRN8K7Rw3dHQ928xWm8xvAUbUUK5OZtQ+wAj6LAiSf7eZt6QxSiYRo+E7FupEXWIZd/FO99YppTyfvRdWlkboKboevF2V62yCrCYlOPkPkIgjyDvN3FioTZUYQ7d4NWuvxH1VEWDn1dSpnQtG7abF1ADqyTSMBCT6d5KQ/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fexh2oru; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QFMHkg028951
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=AtUnXSz/pPSjd1StFFw///pe
	5D57Ql36lWJoHWVv3Fg=; b=Fexh2oruYqA7AuiHnh2DEl9WXCEYdshYebDWjZlc
	JGNFGWH5RHBhLhbjlQw/2B9zVe90qF3/7SCwNH67i4/Pr0glrp8WrUils6l08CMq
	5RouYJWoF6vaRSWO2odAH2W7iPx0PxJEv4sOPcl/psulIyAU6+o1Jp1yjapiPr1L
	KwkhCvR+ykjSReuDroCi5U5OmaemfZgZScRN01peHqUTVvGS5iBelFE5gOkQRzc9
	khDybEE2Ju7HQykeZVdshjfPwV3XkJjcemmh11uDcgQ2me7XnO7OeO2QgM7svRT0
	uCxlWmmwFe2GER1K0LgQBdPGeilrUGE0/eYqiMO5dUq5bA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ktencntr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:41:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c0a3ff7e81so20906185a.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010907; x=1743615707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtUnXSz/pPSjd1StFFw///pe5D57Ql36lWJoHWVv3Fg=;
        b=LnDTdHvD66G9nwHvYZPYHOr3YC6Fv6YDtSKSRtR5Ou+xhcyC6WhRyZuCkJfEoouxi6
         fCU+yzAt1gqGbylx8kJCFSjygnoOioGccvA74AX4gQb4qpSvGGbnxhUS9hjKrCqBLJSK
         fxBEzjplbqaRilJ4BcWiRPFqEfj0g/HXa7OMd0WrfzAwfwgleg+Lu8TBMMed3rITxyjV
         OI0G/CGadUslc0rhGoHFuPINBRFLS7IV0Cv4K/gdiGkbZN7k9my6zaFgleQKKsY7mzk2
         IXGvLsao/zlGrTdmWSzBsAENxHg0Kue70BiCvqtDmzIsDp4i5ETkwiGvJoD0iT8a2GpQ
         RC2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVu7X0hcrDU+uvTeW7SkNfxtnYodI/3/Mk8qHU7AbfsDu+Lc/VrQnvnCcYx05maPu3WUjexv1JVml3Spx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6+HpBl3k6EhL4vV/A7ZyMavyeuaxJbnrd4Wa53Zq0xjsXmQkJ
	jXJOoflz5FgGLWqD1gpcUXIFPBkzgeR3CVbwy0rCPyFxhricd6sylRwI1GxqBJR43Wyl6gL6+bB
	M8s40+XmU4cbofyzXY9fnoXlim3tERxunLD3uoFq+i26fbnr7LCQ9rypyQ4H5FZw=
X-Gm-Gg: ASbGncvrXPpuPFS/kxXso4rXH1Lhwv2vxpvDqbUcHd5Wbz+YXcGyLXc9OPmsY0xqEKQ
	THrokTFHjqVCI893rgSaoE3ccxt2ORfCt4fxJs8KOofCbzchP9dOPIZP9NDy8ZimM1dXk11yIFk
	t66E+/+31+Zxt+7gpLp9RuZE6IaQZPYmLicPwfblmu9K5jhoeWUi3zMhAH063fVF/nqDVPrxBf2
	Ncka27G/unyLPptU2ziAlSBo55hcqM2J6ArEHwCscWx6ijeuhp+fkn6AZamGnV+nI827vqJa1Lo
	j4t1ulad4C3+PMNckUtro1OC6Qp+12deUKn1ZYwE2EcG8TSj6hMc1f4nJGZrN1COipsAg8yC3mo
	LNc0=
X-Received: by 2002:a05:620a:17a9:b0:7c3:c111:8c3d with SMTP id af79cd13be357-7c5eda91760mr82460585a.49.1743010906949;
        Wed, 26 Mar 2025 10:41:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuqcfnhkzb0FRV+B6Fzo8Va+R5lmfJZjN21TrvUtVriwmR9+t0F3bAporcIBSfQDBEa+GQUw==
X-Received: by 2002:a05:620a:17a9:b0:7c3:c111:8c3d with SMTP id af79cd13be357-7c5eda91760mr82455185a.49.1743010906411;
        Wed, 26 Mar 2025 10:41:46 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7e0ebbsm22090901fa.34.2025.03.26.10.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:41:45 -0700 (PDT)
Date: Wed, 26 Mar 2025 19:41:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 5/7] interconnect: qcom: sa8775p: Add dynamic icc
 node id support
Message-ID: <bpjjnvw4mkjieidi7ooukt7f3bgxig5ezyuhp4tjmufr77eoel@bwj75fjd3mxs>
References: <20250324183203.30127-1-quic_rlaggysh@quicinc.com>
 <20250324183203.30127-6-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324183203.30127-6-quic_rlaggysh@quicinc.com>
X-Authority-Analysis: v=2.4 cv=TuvmhCXh c=1 sm=1 tr=0 ts=67e43c5b cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=oKCiNua1F0BOgjzGbBIA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: k73HTQLKiditnqwIFsS6Qbah0rAtaQom
X-Proofpoint-ORIG-GUID: k73HTQLKiditnqwIFsS6Qbah0rAtaQom
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_08,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=818
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260109

On Mon, Mar 24, 2025 at 06:32:01PM +0000, Raviteja Laggyshetty wrote:
> To facilitate dynamic id allocation, discard the static IDs
> from node data and set alloc_dyn_id in descriptor structure
> to indicate dynamic ID allocation. Update the topology to use
> node pointers for links instead of static IDs and forward declare
> the node pointer to avoid undefined references.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  drivers/interconnect/qcom/sa8775p.c | 952 ++++++++++------------------
>  1 file changed, 347 insertions(+), 605 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

