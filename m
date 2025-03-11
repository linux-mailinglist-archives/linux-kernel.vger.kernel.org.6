Return-Path: <linux-kernel+bounces-556538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BE6A5CB81
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F03D67AB457
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB144260A39;
	Tue, 11 Mar 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pEp+tjY2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3195132122
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712447; cv=none; b=TP2UmxYEPtMUomL8iDgAWczf04ZdIJWwfadXIiiJFyQvqCNs1SysPlDHiZphAXzxyUl2QX/PBR7OA6TYQnruD75+HEo6B7IUFh6VbDrBmUwpOTfift70HitfPHmGm+4CLjCms8GO8IEA6O9sz3+GvdF/d9+Vo2p7bWXpQ2BH7Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712447; c=relaxed/simple;
	bh=5GwssAcNle8ZV7b/8kUztDA7RONE/QrQ6gtsT9kVp7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+BCdSgfc3eOLu0gW4DK4Fs5YGgjEf6Bw+PsZmYdcWterQLUjoeT5TTVBEQP+YL4HaqBqhEiPm4nkSkFyZzSKf0txun2Q6KYaqVAzQWU8TtI413aaddIRrpc8h0TJjeRSrg+VjUxtFL5JyGcsZibFpLqoib/we06f6favanBty4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pEp+tjY2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BGCHho025277
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5GwssAcNle8ZV7b/8kUztDA7RONE/QrQ6gtsT9kVp7A=; b=pEp+tjY2F8DILMga
	8ZZklicFl9r0RW2KRjXLtXf4eCD+uP7Qid0wCYekiP0arVIGg/FSip+y4KhzAYvP
	0r7N67RWdAuDfnFWSRroLgazrNmgYswzTgBG/uYH+zqefdxEqbB76CMmJlFnqDuQ
	MVxq2XS+SOqtavVIYtRlYoGCl4x3srOPX0YjD2M76xlUCqOYqhOyWF6yjejmgoP3
	E3/7+feEcNZkeSChxy7nhpoLLespEsPQDUGVuhET0RUimLynuVU0ZIF4QxG9Xmhj
	m9Sf3hPubZKSoXBGXwS96T/XD3ZMfF6Q1tVz6DvdGigiHjcZFd1RlsTJfxGb8vCO
	j52P0w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ah4t1qj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:00:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff68033070so9070955a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741712443; x=1742317243;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GwssAcNle8ZV7b/8kUztDA7RONE/QrQ6gtsT9kVp7A=;
        b=Eb89ySpCVMoh3cAI8KnAJ7HhJoQg5EUXNUTC1SZb+H3r+jloyzzJ/PJezjRSg+Hcp7
         3sf/ksXAqWoeJVP8WMnP/UkHfcqG5XHigIUgzanx3magn7rotM+3MpVPtCiYEnTSCbVA
         JOO5O1EfBI5fF/y62Gv0zreOWJPv52jIifY0ISAjr63rggytx95diWX4yfI8rWoKgH1X
         Xy1SuVEgqHeKt/nSXvqqqyCriqBHRkldDAsrVq+E6rW/CO74RaWBd7qFNRWjihN/uyyj
         cNqVDTZPua0XPMkGYaHhIJQFhy3SMNwJUbptFXn6dPBbQhEuvdlDz+Ks0XCv9pDU2w81
         d7sQ==
X-Gm-Message-State: AOJu0Yw0GtkqzbRJTzgEwZzKC1GusScMPjFzwK3QXs0ruGvW/6ksv9pP
	2/kH3cKAiktUZdYmJM7gMfwbl1Oecgpes+k/eQZ1shvIAdhyjvx5jK66HRhhMTSfzrBU3xB0qZl
	yfrQhfR073StR0S5uebuPjUaiPjps1dZnAaDqdV/0qsL18Qxjgm/Euk8vdEenIz0=
X-Gm-Gg: ASbGnctWntFmUSik5/TA/WOKu4EgpVio4vzPrC03F2cIpJgbZhQ+9L94YUZBuznsRJE
	nADaS3o7TwlFgSsE+5Zytls4YFLkojD1x/8SuZLx6OtT28jIiWzMiU4KwFZDQrZ1z/IqzBSLSQR
	ozxjV8mUDCuy2QQDch2EIINrXvbD+TEay8ruJNg5DcXjvBX8FD+i2k73CKr3r2YyHYKwvFMgcrK
	QkzoEMFVQ9uNh6Rcht4sxI97p//dGeQOAe38hFhRL8mOY2Vhf+39gvVsHGT4IZgptnqW5j/kWOi
	k367KCuKmqipYdU3My+v8UxdH2YxIidy+eFYeb7VcKGOShgIGxQv
X-Received: by 2002:a17:90b:5444:b0:2fe:8f9f:e5f0 with SMTP id 98e67ed59e1d1-300ff105567mr5556762a91.19.1741712443309;
        Tue, 11 Mar 2025 10:00:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH16QI9JbZiKmf+GDjkOBI9/PP3Qmbwf2Cp1oZzNLjA2AZTLn3eSzQZsEwdObauWQSbzDwOQA==
X-Received: by 2002:a17:90b:5444:b0:2fe:8f9f:e5f0 with SMTP id 98e67ed59e1d1-300ff105567mr5556716a91.19.1741712442759;
        Tue, 11 Mar 2025 10:00:42 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff6935350bsm10162768a91.20.2025.03.11.10.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 10:00:42 -0700 (PDT)
Message-ID: <7af90d36-028c-4f82-8ef0-d86252dd1342@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 10:00:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: hsr: Add KUnit test for PRP
To: Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Lukasz Majewski <lukma@denx.de>, MD Danish Anwar <danishanwar@ti.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
References: <20250221101023.91915-1-jkarrenpalo@gmail.com>
 <20250221101023.91915-2-jkarrenpalo@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250221101023.91915-2-jkarrenpalo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GbRznN8O1k5XNYoz0Uw8HXXhhyzS9dPH
X-Authority-Analysis: v=2.4 cv=fZ9Xy1QF c=1 sm=1 tr=0 ts=67d06c3c cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=YKuAYAPzx-kjt0xx0wUA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: GbRznN8O1k5XNYoz0Uw8HXXhhyzS9dPH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=790 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110108

On 2/21/25 02:10, Jaakko Karrenpalo wrote:
...
> +MODULE_LICENSE("GPL");

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning with make W=1. Please add a MODULE_DESCRIPTION()
to avoid this warning.

This is a canned review based upon finding a MODULE_LICENSE without a
MODULE_DESCRIPTION.

/jeff

