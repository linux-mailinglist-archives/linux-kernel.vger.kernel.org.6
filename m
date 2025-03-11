Return-Path: <linux-kernel+bounces-556395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF05A5C641
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7801817C1B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CE125F960;
	Tue, 11 Mar 2025 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GbHtfjoQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C7A25DAF8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706439; cv=none; b=oqdBSPk4WCZLmD8ABeC+cASnmOitacGwchQulewWilM83sTnIj5Aw+Gw3Ly+mQlB8ANrwfMDVn7Y/nvGa1OJad8d5o9pJp+barfdE4yJewx2B9BAp8uaC7gUc+ZPrCqywZqf549/4ZTs4Rgkkp8KmbOXRraIwyKUkJHlOFAR4is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706439; c=relaxed/simple;
	bh=xbIYcltamSKWajOA9SFxU6mIAIXWX9r9mUII+sBAL+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hm2/9AW9nQRqt2TNIOyd80SDimj60saBNnyg2+3IvRTW+dxz3kgThXMZlhRw3cXR/1/L57EJtjth2kl1+ZjrUGTTOBuiEc7xBUygQiF+xN8pCQl9QMtO7niKwYN45Qbl4KQI3Zp8GlqHEDv5bjUnDodvKIIXe7oZOpygetuDmy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GbHtfjoQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B7p6D6028491
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6S5ygg+RCYgkDd953aVyRkTurt13EX9y7F3QCMrgVgc=; b=GbHtfjoQB8/5XvFF
	odcnZMfVHt9SVzgJg/4yZpWld8MBehRt5ngEDpzvqPbdvBVv0FasRnsUNlt7DAEj
	Bq9QWng0NYKs1Zq6UfnJfZN8L6lKXpibvCmDJQg3Ak9t7vDwMh9/p+z+g1oGZxFU
	3+U5hXKvq3eGcIn9BKRPJkBUsL34ZZWhSqchlXo+e5bf6KO0dLU0F1Jy16FHZqab
	HwYtuK/AxSfHTrnLMbOLPx5UuYky3AtcTQNA8aN0EW+qsIaXFjw3MKtTk/dCgZDX
	uqRcyOOguS42t6cdUaL/78FJ6SH/feS2H0/fTGJFgALxT1zA1H37K89XbKhcaziI
	5xBHXw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ah529dax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:20:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-223a2770b75so99046985ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741706435; x=1742311235;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6S5ygg+RCYgkDd953aVyRkTurt13EX9y7F3QCMrgVgc=;
        b=qB3mf6JKpxzro89zW6qi5rPMa64DXCgdZFzU8VR7ZLPEL63SPnkwJCXTcMM/scuzRY
         Om791+nFiWQWQ1Phb5yYvvAAsbKCviV/cHt0nl8JuE2s1yPLtxYAVO1vNpEL7F7Da/Kr
         x1Tg/Iq9hsLnm9xnqV/EFANE/52uhFo6Hq29Wolge0mtn9pqyDJuHDlggeEkJGX88VNl
         evYSMtTU31HW6hRBtGzlFWCbvBeck0rfPm5PFXzaCwD8/pLjcLNRy6KRbFzoENsMTE5g
         hHMzJjh614Rlnv3xDE4a4I4T4dyFMKZDX/1zIvjJN5AT6OxJgzag8Zhh2Z1SdGWvptYV
         pv/w==
X-Forwarded-Encrypted: i=1; AJvYcCUuHh/3aejLpl/cyKOlbvYmZ9HGDfsNFlZvfSAQWoDL2C7U4CDROp8JrrFU23XZ8HYPcBgC7yuqFci7YTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkrrKpx+h8bJXVDjDm7mszkvmLgdP9wcAEOwnN6p84AmyKrTuq
	a9WqEF2lAaIAc74qtX65P7jhu1N/UnKFMjhOLPbgOxVZ8m2aQTDdQx8r98baYPCO32zPGO739pV
	4ODe8+VRAsikc1onY3nPocJ+vHkJWLo0wi69ngH1jC+Lfj+89ulpKnwQhPCrcCk0=
X-Gm-Gg: ASbGncu1TI5jmYqCWvMVmI1th8msJeTsxsZiEqfh/WVspDjZOlBQwGTUEK5uwEj5cqG
	9SkTCraok6Rrt1q65OgXSMxRTwdmKX9sgV2Xb6/M3yMA5AtcnNCGU9qzWiVShPmWDzJ0m5Z4hIE
	5jaATjqvn56zTsrpkPm78yb3mBYQECsebW5Ny7TLtuV1NN8Kqp6eHKpYHhOyKis5UCDVI3+700R
	B8SunrdNQk9cumVgIN6uVnNdQLOaYRY2iQpG3Ef6smkXTRj8DauXEmJJJwaMbn/43VpKIXYclx3
	eh6bphMhHn6vP74slh88VtZ+PmSDSDQDrBWrhMdopjBw8KUa24a0h1DOoLKE5PVoD3QxJ+4=
X-Received: by 2002:a17:902:ccc5:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-22428a9d152mr264950325ad.29.1741706434947;
        Tue, 11 Mar 2025 08:20:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO6l35iZWPJ3KWFhVCy19eV0b9mYiGmLSNfasvFshbTZzRkI+5187/fK/CQbEGiBAF6eAu5w==
X-Received: by 2002:a17:902:ccc5:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-22428a9d152mr264950025ad.29.1741706434546;
        Tue, 11 Mar 2025 08:20:34 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e816csm99020365ad.54.2025.03.11.08.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 08:20:34 -0700 (PDT)
Message-ID: <c0cdcaf2-655b-4d22-a949-1519c552e6a4@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 08:20:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient
 length
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, Johan Hovold <johan@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org
References: <20250310010217.3845141-1-quic_miaoqing@quicinc.com>
 <20250310010217.3845141-3-quic_miaoqing@quicinc.com>
 <Z866cCj8SWyZjCoP@hovoldconsulting.com>
 <7b1c5e40-b11d-421b-8c8b-117a2a53298b@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <7b1c5e40-b11d-421b-8c8b-117a2a53298b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vX3G1I_clOr7gdvxahoqf725Nlc9hr2H
X-Proofpoint-ORIG-GUID: vX3G1I_clOr7gdvxahoqf725Nlc9hr2H
X-Authority-Analysis: v=2.4 cv=DfTtqutW c=1 sm=1 tr=0 ts=67d054c4 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=uOWRnoLIEoXm2GSVXJgA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 mlxlogscore=816 adultscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503110096

On 3/11/2025 1:29 AM, Miaoqing Pan wrote:
> On 3/10/2025 6:09 PM, Johan Hovold wrote:
>> I'm still waiting for feedback from one user that can reproduce the
>> ring-buffer corruption very easily, but another user mentioned seeing
>> multiple zero-length descriptor warnings over the weekend when running
>> with this patch:
>>
>> 	ath11k_pci 0006:01:00.0: rxed invalid length (nbytes 0, max 2048)
>>
>> Are there ever any valid reasons for seeing a zero-length descriptor
>> (i.e. unrelated to the race at hand)? IIUC the warning would only be
>> printed when processing such descriptors a second time (i.e. when
>> is_desc_len0 is set).
>>
> 
> That's exactly the logic, only can see the warning in a second time. For 
> the first time, ath12k_ce_completed_recv_next() returns '-EIO'.

That didn't answer Johan's first question:
Are there ever any valid reasons for seeing a zero-length descriptor?

We have an issue that there is a race condition where hardware updates the
pointer before it has filled all the data. The current solution is just to
read the data a second time. But if that second read also occurs before
hardware has updated the data, then the issue isn't fixed.

So should there be some forced delay before we read a second time?
Or should we attempt to read more times?



