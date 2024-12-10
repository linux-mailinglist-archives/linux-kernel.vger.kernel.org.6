Return-Path: <linux-kernel+bounces-438940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 220D69EA874
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC72169ADA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29D022ACF3;
	Tue, 10 Dec 2024 06:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C9u5KqNo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FEC1D5CDB
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810705; cv=none; b=utAp4qtTty/7Yo2JTOsvbddy0qbTNlGaNJDni8Ih3EvETt3SXwB4JkHmIUvW0tkrit9CtZQW/fpw7WGMOPV6dB3KefaV93BxoGqMyHOX7bJNz68n1Irk3s7qcRFh/vFvqqqKWu/waEmvH9MS8Q1+5Wqh8PZBeckrqvP5fggrwZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810705; c=relaxed/simple;
	bh=/TzYjSJMFsOexNuvmKmRRmEuckGKb+afohwudQiPAcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCMnM9XCWJ7GzduhIM/0RnE8DJYIIY+wB4TWUrxh8y8E32xES5L4YDWTWZKBooxoL/ipLXCEZqFWu0yDq0mDMh0AgYPXfTeNVmnyBuQLEgSpDJYB6rndz27jLxwYO4qYWoF5PO1mDGpihKc7TfiU7+Db0adHUd+PKHaKX+JnVo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C9u5KqNo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9GpRgL005177
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zuT7sexJqrl+drwkywE4TpkVkXimVN+YkzX3PdE2lPg=; b=C9u5KqNovIKxiPE2
	Qx2IobVsWgK8/w96zZlTOUPmZjO4xax5pIBkg0Y5VXOLYkkdLjVnCihubtdfOptL
	LHcjG6wt/+JiFBVWQ4JPaBr7TmjtjWKtFR+dwBGiIMHrHBlMjNVeaLp7Z9CYwEHF
	H77cFovjkCQb01XxrMmhzZODerO0F91hHYtlWCUMkpulGNfResW+ZtfTnHCg1kb5
	212HZYD//h8JUOz+1BmOnVZKjRpPWbc1RLPSIY3cTIMhTTxoynaoqMgwJYwbosH3
	Kr2kwaq+pt/4+T+eKVe9Ib+27OcXkqebzGGwi3tRWS6lz5ZJCjZusFRFvWufK4go
	huJydg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cdpgqbg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:05:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21640607349so26043455ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 22:05:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733810701; x=1734415501;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zuT7sexJqrl+drwkywE4TpkVkXimVN+YkzX3PdE2lPg=;
        b=DOKCg6NegvGw2kwUPSxPp5mCP5bWqLah9WsIF8I7Vd+pGiHCo+ZmqjEC6lziO+aiRD
         2rHadNPRWRnNmo/gSQt2ne0HMIie9w3At8Yw/93Hz20vWbTwhqZCYtcOWk/5Qg9cXePY
         miRRPjKLnf+2hKwecrWBNEQaNilsE4WaTxU6xRgJ4ozqVTBXUhYjmeplnjmLy+47czpZ
         WVk/JgBTgtEJatB2WfEEhIn7YeSAVx03Xlrm/rNbRv9zhZiW/80Hdl+1ncPsPNdRa/Mh
         SeYG2yH7nnEtMzMA7L8UHe00c7nVSMd8FI5e1Pa32z1kkkMHVzCpEwwgMjutUGGSafKH
         A6Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXQJGbNKP+CYnQmzYB5egD2LFPhUTLArOEhl2c6SgmcaippqaFn1XaO+bvg/LDfKTd8jBVurWpktZa/UqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgMsP8Z/DJwJKRNzFygQsVXT2Ekpxe4rPJqzBDjVY+htlZia9h
	NvT71sQAN4uR3RcyS646IwPPNdF9weBHryP6+XSiQ0U+fKNKbBrzQBctSptC/cQhfOhDUgBj3xY
	aMiwcQxCcNJuEWddHrQr31j9wNDQfxFz4R3YG9bWnoDItUhJT7jwg3hj4PLDMJMM=
X-Gm-Gg: ASbGncumZkUpmREnT+3X9IeVo7qJcawqcZMNKaxEuL5I6rCin+EklbCCexSbHNwQUCT
	B7uUrT+d9+DVDYAWGjN1ZL/+kdhCV5eRBElQYF24rHBlxEOmJTbFMmD1AlxHrbIlFBXjs88xjne
	qz3ugQOm71yq+rIXfTUWJ6/eg7WE0mgs368+W14wu18dCHCjYZ9XvCNEZ5QfVl4+Fcbwn37AvZY
	nuEHdn8hnPfez6UAQMLSzO3L+eaSBwzreq8QwU3uzVhXcGgtYech+h4OJUVe+BJhnInThzqT8KN
	9LIVXm7ZOAFZfJo9kx/KUbvTuohBnd7VphnFfA6INlgy/zA=
X-Received: by 2002:a17:902:eccc:b0:216:49b1:fadc with SMTP id d9443c01a7336-21649b1fd08mr106886795ad.42.1733810700976;
        Mon, 09 Dec 2024 22:05:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdZTBCMs7H1WTg5zLzKGDgofWMITKz9UCc3WUTnRaIn+Lttr79ry9IlBjhjDkydSu0LKbL1w==
X-Received: by 2002:a17:902:eccc:b0:216:49b1:fadc with SMTP id d9443c01a7336-21649b1fd08mr106886535ad.42.1733810700587;
        Mon, 09 Dec 2024 22:05:00 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21618d9beafsm64535765ad.6.2024.12.09.22.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 22:05:00 -0800 (PST)
Message-ID: <fc745e1c-cfad-4ccf-aa9c-77cb76c2f23d@oss.qualcomm.com>
Date: Mon, 9 Dec 2024 22:04:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix read pointer after free in
 ath12k_mac_assign_vif_to_vdev()
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Cc: Kalle Valo <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241210-read_after_free-v1-1-969f69c7d66c@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241210-read_after_free-v1-1-969f69c7d66c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: U0PoLsSkhlgKQxtPiBQvl4qE9KBeghL8
X-Proofpoint-ORIG-GUID: U0PoLsSkhlgKQxtPiBQvl4qE9KBeghL8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=750 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100043

On 12/9/2024 9:26 PM, Aditya Kumar Singh wrote:
> In ath12k_mac_assign_vif_to_vdev(), if arvif is created on a different
> radio, it gets deleted from that radio through a call to
> ath12k_mac_unassign_link_vif(). This action frees the arvif pointer.
> Subsequently, there is a check involving arvif, which will result in a
> read-after-free scenario.
> 
> Fix this by moving this check after arvif is again assigned via call to
> ath12k_mac_assign_link_vif().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Closes: https://scan5.scan.coverity.com/#/project-view/63541/10063?selectedIssue=1636423
> Fixes: b5068bc9180d ("wifi: ath12k: Cache vdev configs before vdev create")
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


