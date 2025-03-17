Return-Path: <linux-kernel+bounces-564055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E8AA64CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB441660D7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E8523371D;
	Mon, 17 Mar 2025 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BptCu5eU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9A61474DA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211333; cv=none; b=tbFV/svqZ/br/mw6bEc0TxXaqrdzEFDN4FMJiYdaQyP3ExHsqF+384MG7RrVkZfc6CFC4tiZbQfWVvK1I7ko3V7gmi2hYot7Ep+ADERcO4ka1N7NyABKeErPf4CVCJd/ma+WJUzkZCC1mP0wKfAAC7WUEKGNCeoqsDebVo1QdG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211333; c=relaxed/simple;
	bh=hhnKo1koZ9MWYz+6WoOpfnqo17O1obC3mtDDYd+spyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCZ3xfvPyQbC1Sr8lSolFHmuzC30lztfBn4IWcHQWZEMro5xk7IlE6AsxeLff+CDsoXgRVUUrXDdjY4vpdCXFMAVdIRh0m025ROlnMdXqd2M1W7gQjIkcS7ph9IlK175hCYcpAliDQzGSij6CXC9xROQBp6WjdEB2+mopPtHeOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BptCu5eU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HA8RLm012987
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YeZNlDAPrPyW/cf3xKhRAbVY
	fLxCK2qS+SxQ2C/Ihu4=; b=BptCu5eUymlmh53PK+qVflr5BKD4O+VGHRMWbfD7
	OScxgW1oiy1sHIp3DG0v3lFTzeGmuABGbMRDZszUlCw6Z2Q2a1DnUmkEj/krUjfg
	LaOnWtSEkdsHQ9fqSIVQ7mpZ3nsAXS5N/6eAc3O69Gv/PRfPjcogCQUi9dccOQ4k
	3pBVt7YwNR/oXjQfwD+fULRVqX1/ua8CfhAG5Hq+bbDzThLgZYp96DMIHtluI0hy
	sg/WaYMYQcMqpSSsc/M8HB0VgI4n8MG0JzNESZq0KLTTmU6FFnideJHzXnN4tHr6
	kebfVYXLVgGm9g16VVj88otOgIVyyWY0B3qkwNIJrDCD5g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1utvgwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:35:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c57f80d258so610264885a.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 04:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742211329; x=1742816129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeZNlDAPrPyW/cf3xKhRAbVYfLxCK2qS+SxQ2C/Ihu4=;
        b=sKed7EX4uLjEqa1407+kh/0pWkzxtV57kJrSbwv7q0EpsFsjO98yR21NrNsryhE+Tz
         xMKsvgmwAIHghfjbOI/3ZjI1q1+TKKBbUFcYvYkUC+hYhjW+2KDcePF+TgWz89AbePDr
         vALFuFDpdUhitirpt+F9gNQJeXKICwMlD2ZM8XoZsNrCM1qwjq2aiBrhhBUE0a2b0PQZ
         JnFwYakscgKBe+Nc1/Y6xpGYjkteq69kZM/EBGNnR1XdJq/mu9cCIaPiPhCWa14WKzyG
         AJCuaYWgjTcmHuYRTNfcsQl4XtuJ5lHexly6Lgej9aocj+yydwe9tbt8HStEGJS/C6sK
         Gqrw==
X-Forwarded-Encrypted: i=1; AJvYcCUj4m4q26BALiqm0NVOj6i4cO4oC+Vu8PQV4Aa2Zgymoz56ijLumXnQTLEuSZJC+lZ/ttlagWrg1eLryiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqNbbkBw/o6afNSm2ID6wN274bjwR7mdeFSOleOd7m42FpSrpW
	wqVyLym1wJANZyK4uJSb6sCxBTqqYOnhyb4en7MJzC8sRT+44yR8wqJrp/gfT1GV/LDlaidZefM
	7pBIMQwpH4edHbFTE1M381T5tn72rhQaVmHknNFBaBa7Pg/lc5zmaejDVwtz5Of1MNzY+75o=
X-Gm-Gg: ASbGnctFlXyp7R84Jjl5srtfnaslP4xskI5FGM/pDM5egEId0nUQBx8YW/cKjazd6D5
	laIOfKnXBw4Es8eEkKPICc2qFuZxonr2KTR+KmNnDgX1yRwJHsLSdMVNaCGIrjGFX1dG6WImMN5
	bI8JT4hXogV6Nh8+p68VykW07jO6eQI6ghOuDWquhhU5fLPFfh2x/SujsuVIA9u1Nvx9BH01zYO
	plhGf8lviiRLO9/QurosARLmCqY6UUwsGWFZb6FWjH5hD3ai+sEBYRsWHRXgfks2b8Jx2iuWTr9
	x72/7uoNbh1Mxk6OgBKH6krhhVn89PH/LRJvnuDSizHo35/Tuei1qsPjwaAkLppbweDpt3QkNDe
	QjHY=
X-Received: by 2002:ac8:5802:0:b0:476:7e72:3538 with SMTP id d75a77b69052e-476c81d8e94mr233422831cf.50.1742211329578;
        Mon, 17 Mar 2025 04:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8Ff7NRDjIixgDbZiIssqIub1yFfmbmAPPXmx/TewABw8oOTS3ubLjWwHKqWclRI5IHUlYvA==
X-Received: by 2002:a05:6214:2626:b0:6d4:dae:6250 with SMTP id 6a1803df08f44-6eaeaad4dd7mr216862326d6.34.1742210994322;
        Mon, 17 Mar 2025 04:29:54 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1da7eesm15708061fa.100.2025.03.17.04.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 04:29:52 -0700 (PDT)
Date: Mon, 17 Mar 2025 13:29:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sa8775p: add support for video node
Message-ID: <vkwdmy4xabipnmetypzuem4xr2fijxb763hu5liohumtkfit7u@drhlzuo57y2w>
References: <20250311-dtbinding-v1-0-5c807d33f7ae@quicinc.com>
 <20250311-dtbinding-v1-3-5c807d33f7ae@quicinc.com>
 <3ec71075-b1ef-4366-b595-80fe41cd1e13@oss.qualcomm.com>
 <5qfe4gnjnttnpezj36rdsdbomghnz5ytj3hiecoingj7622o5a@h4tq4tzliwz4>
 <b9743d3a-d0bb-385f-f21e-6b0c0be37fae@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9743d3a-d0bb-385f-f21e-6b0c0be37fae@quicinc.com>
X-Authority-Analysis: v=2.4 cv=H8Pbw/Yi c=1 sm=1 tr=0 ts=67d80902 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=xle-qd2Ai3CaSUjEJ3AA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: HhlQAJm6uN7zt6r3wSCK-90xHLTJ8aY7
X-Proofpoint-ORIG-GUID: HhlQAJm6uN7zt6r3wSCK-90xHLTJ8aY7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_04,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170084

On Mon, Mar 17, 2025 at 11:30:16AM +0530, Vikash Garodia wrote:
> 
> On 3/16/2025 12:02 AM, Dmitry Baryshkov wrote:
> > On Sat, Mar 15, 2025 at 02:43:30PM +0100, Konrad Dybcio wrote:
> >> On 3/11/25 1:03 PM, Vikash Garodia wrote:
> >>> Video node enables video on Qualcomm SA8775P platform.
> >>>
> >>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 67 +++++++++++++++++++++++++++++++++++
> >>>  1 file changed, 67 insertions(+)
> >>>


> >>
> >>> +					<&mmss_noc MASTER_VIDEO_P0 QCOM_ICC_TAG_ALWAYS
> >>> +					&mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> >>> +			interconnect-names = "cpu-cfg",
> >>> +					     "video-mem";
> >>> +
> >>> +			firmware-name = "qcom/vpu/vpu30_p4_s6.mbn";
> > 
> > Firmware-name should be a part of the board DT file rather than the SoC
> > DT.
> Given that video ip is independent of any board, remains same for any board
> variant of SA8775p, and again for the same reason, PIL, aspects of video driver
> was made out of probe, i would prefer to keep it in SOC. Again, this can be
> overridden in board specific variant DT, if any case arise, incase.

This file is also board-specific and will not be accepted by a board
fused to work with a particular set of CA keys. So, no. This needs to
go to the board DT file.


-- 
With best wishes
Dmitry

