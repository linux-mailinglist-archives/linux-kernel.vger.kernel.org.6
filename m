Return-Path: <linux-kernel+bounces-576352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F15A70E2B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A17116E13B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73463D6F;
	Wed, 26 Mar 2025 00:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vx4Z2QF5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9F7539A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742948517; cv=none; b=kCdZY/MWtVstFW3bORzEA9PabsNBfdg3taUhJ3h++dVFxlk6VwBO6T0b0/39/WB/KVLzyZFTk0ImboXErz16OG5Mi3CcNx0O0zttpnedxWnTo8YPMbtTWMLdE/M6qeKDh0Ae5COwQ+LqavjRNUszWNfCcMB0fPH2KPYc3HCLGgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742948517; c=relaxed/simple;
	bh=8GP4IzSOCGS6nnfKIL0+g3kJ16Co9iuSGr213dDwyYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVTlvFr+woiOCq07xRSl2Rqi50y+0yo84fpkPmCBmUu50rv4fBSHSMabzhBd7Cgn3MdtUbGNhjGlrR4OebWIYyl5wrbRFlxn5WcfU/m2soh96DKbbfKH6rLlqbJu8cNnEnVwyxnHJ1bz1fvgCSVAket5vLLyF1i3M8pT7IN2Qo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vx4Z2QF5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGalJv017282
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RfhzzQpQZQ+16YcL/C6rQJz9
	e7WatbDp8WM0fqCpczo=; b=Vx4Z2QF5wXrLoZG39SR2F7mKOuLdtoYkXcLpZhhe
	QvDQ7CFzntnKcdMEVQl4poQsezmWXAEh9z39FmFH5YdZ76R4YugXIFVDjz8FvBzR
	RafPodOvYOKt3bFl+YcLCa15EAim0tN+Fm7ZG3rc08xT+okf+otT/pXn/SiqV5tx
	Fk/26yJa5XQi11jYccfXzqa1YU5lbkFRYqBqw3JwqcxB/7vsQ+khTD0vKtlR04EC
	rPcmYdIOjSk6FLvMnszGxgR1MY/svTHPWhECVmo0U6aaKI6/+qnUCo1wJz7iYD8D
	o4wnIon08y+gpxVYfoywgW8ny9PeBDmDy0ZRDTggerNgLQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hnk8sh5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:21:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4770594a277so7096531cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742948513; x=1743553313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfhzzQpQZQ+16YcL/C6rQJz9e7WatbDp8WM0fqCpczo=;
        b=lH/JbHuWrWB2vsl54XcihghSreOJ6sUW0/T3ufFdn+qIPw0XVFyVsuNf+KUaVcUZjU
         Lgp1p5TIn04VRurk2ihJFoOVTBRK1loMy5KinT201DmgT8Nkk6TWpuCbegNk7x0QNuNx
         zLegzOe24d4I1NAxE3VxNiiZ9qCe5Rcx4aLq6cFIkKB3S4TuNIQC0L2zUEemrPf4xs8y
         LvbGLrnSn65J17ST+A5MIO+ytiPPEF/onch5SvZ/bCqBJZliBd4v44/Ah+mw0LoJa5zg
         hbkk1bRmE5fmdUAfk0puJ3RbDlF3Sh/dL7Pw2g0m47kgy23L4+AUHGtMiSLrR+xyFk8C
         N1Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWdE/yBKxtisrmFkIoWHllh15YIGHrW+E/m+FNxlWXZk7JZDnFF+NPNq8zUHXELxi8r5KAhiduNTNCsV+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2OtUGzJtOYFV5j8Af09Jr18tpdiklpe7EcsfR5xGe0/R+vQsZ
	hDzw4vC4SlafifhlD5cD6EDwc2XXgN3uohNZH4dV8lwSxGWwAewTBIGEr/DtrUd+mxBc2jgJxIR
	4hRK0MnZxCIaiB1OEEEkuTUeKyKy+umypone8SF4V/FNxsp6L2uNE6eWsmnhqkAw=
X-Gm-Gg: ASbGncsO/Yu7DIIxCiz/1K/VtNY0sLyB8JY7FM7WoJJgLxBy0FQcXNDVKhesffnCO7I
	7VzMxgFkeeYNOPe9xb0T3bKx0A20LNMFnuZTinrF6GLYHHeQ+0FUzipSbY2STUMUqs5qWaBCLSU
	SSrIrDHAlarFw18vVwynLXhvvdJBiU9qeWBjFThKTcnB371d1IH1MK6gi5j93hueAEHwHL2AleX
	Md0GbFlZrze4PqZL5GxN1Ne4SSnSJLc+ydJksPd3hYewQYAb/KTQqyQhP8C3nrLS3XWdKBLXuBB
	hnw6qxVpPFSacLjuw8cfd4JepP/2VO7jGDBfcwYZhmw8Pi4oGNyWI0u0nbpHdbCehN5cvmcOLIw
	yAMI=
X-Received: by 2002:a05:622a:2615:b0:476:9763:2fd3 with SMTP id d75a77b69052e-4775f313c5emr28141161cf.14.1742948513218;
        Tue, 25 Mar 2025 17:21:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0YdvvHUlkDEyAPMb+g5ms+1NrLHTgcb+KKkKkHlmUnjl3OR6fK6cClq0k4439q/Sg4ttffg==
X-Received: by 2002:a05:622a:2615:b0:476:9763:2fd3 with SMTP id d75a77b69052e-4775f313c5emr28140731cf.14.1742948512762;
        Tue, 25 Mar 2025 17:21:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64687e5sm1643472e87.18.2025.03.25.17.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 17:21:51 -0700 (PDT)
Date: Wed, 26 Mar 2025 02:21:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Prashanth K <prashanth.k@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] Add snps,dis_u3_susphy_quirk for some QC targets
Message-ID: <gyeppjlzfpmazj5seohhab75mbhv5kyzdbxh7iqddd33dnah3n@w2tpd5gme2rq>
References: <20250325123019.597976-1-prashanth.k@oss.qualcomm.com>
 <ee0848ea-7a06-4f4e-9115-5e3c0ab8bf95@oss.qualcomm.com>
 <7029a455-47be-475d-b429-98031d227653@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7029a455-47be-475d-b429-98031d227653@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: UaNyXEbXM3uat4lorubuatjJvg_oWKfN
X-Authority-Analysis: v=2.4 cv=KMlaDEFo c=1 sm=1 tr=0 ts=67e348a2 cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=ZqfHA1wz_kCA0izwLYQA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: UaNyXEbXM3uat4lorubuatjJvg_oWKfN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=985
 bulkscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260000

On Tue, Mar 25, 2025 at 08:31:55PM +0530, Prashanth K wrote:
> 
> 
> On 25-03-25 08:11 pm, Konrad Dybcio wrote:
> > On 3/25/25 1:30 PM, Prashanth K wrote:
> >> During device mode initialization on certain QC targets, before the
> >> runstop bit is set, sometimes it's observed that the GEVNTADR{LO/HI}
> >> register write fails. As a result, GEVTADDR registers are still 0x0.
> >> Upon setting runstop bit, DWC3 controller attempts to write the new
> >> events to address 0x0, causing an SMMU fault and system crash. More
> >> info about the crash at [1].
> >>
> >> This was initially observed on SM8450 and later reported on few
> >> other targets as well. As suggested by Qualcomm HW team, clearing
> >> the GUSB3PIPECTL.SUSPHY bit resolves the issue by preventing register
> >> write failures. Address this by setting the snps,dis_u3_susphy_quirk
> >> to keep the GUSB3PIPECTL.SUSPHY bit cleared. This change was tested
> >> on multiple targets (SM8350, SM8450 QCS615 etc.) for over an year
> >> and hasn't exhibited any side effects.
> >>
> >> [1]: https://lore.kernel.org/all/fa94cbc9-e637-ba9b-8ec8-67c6955eca98@quicinc.com/
> >>
> >> Prashanth K (3):
> >>   arm64: dts: qcom: sm8150: Add snps,dis_u3_susphy_quirk
> >>   arm64: dts: qcom: sm8350: Add snps,dis_u3_susphy_quirk
> >>   arm64: dts: qcom: sm8450: Add snps,dis_u3_susphy_quirk

It is hard to belive that this quirk is to be set for SM8150, SM8350,
SM8450, but not SM8250.

> >>
> >> Pratham Pratap (2):
> >>   arm64: dts: qcom: qcs615: Add snps,dis_u3_susphy_quirk
> >>   arm64: dts: qcom: qdu1000: Add snps,dis_u3_susphy_quirk
> > 
> > Are there more targets affected, from the list of the ones currently
> > supported upstream?
> > 
> > Konrad
> 
> My initial plan was to add it for all the QC platforms, but wasn't
> confident enough about it. Because we have seen the issue only on these
> targets and hence tested only on these.
> 
> Regards,
> Prashanth K

-- 
With best wishes
Dmitry

