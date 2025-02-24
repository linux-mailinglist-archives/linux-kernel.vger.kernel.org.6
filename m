Return-Path: <linux-kernel+bounces-529907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D22A42C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F0A3AAA76
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A68D1EDA24;
	Mon, 24 Feb 2025 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ie63vOzC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD98F2571B6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424148; cv=none; b=Dc5Z34IqTuM0+rO67MopDXplP34qOcatNVS3FaVxaY8X+GFD4izrUx1HlAatsBMnsZqu6/RlJK4ppWEZMJdhLlu/weVLeOSEItZYpnD4ZSrRgjWllfGqHL8c9Qczt1FWKcQX2up4g9DIKjRP785tEldSMfbt9jnyZjaTvSsOc68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424148; c=relaxed/simple;
	bh=bCr8vR9eIpvmjDP2ky0jg3Mz8hl842I/M1iMYHRf9/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGHhVCgDPLDeQ/fctKlrEaSs3ahNWLSN4u8FA1g1opx1XZ+Z46e5QC0piETZk+FtiW3hS2ULsFRmqiODzMZLpVjrDXrBxZ92dogbBLqL/61XIhCoo1glV+21Bzy+yU6BQ3KpDLg2TlQY6WcslN/bpyg9xBNnObZt6M9u0H1/fX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ie63vOzC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OCv1Nx012736
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zavfbH1zR/1Hpjz69wllzxoWL+BaXWGYetefdcl5eoY=; b=ie63vOzCZ1O5web1
	y34A/gcZOBLTWM7sX+71F1kllAlZ/z9IBPx1gEE0nLWuvnv8vjJH2wrkJAk3SXJY
	vkqLeaCz3/GQQWxWF1WflBTpyX+ajBn/b3R/ihGAKumaf3ANILsmYDFwWmQLYxqc
	TJnu9gMPKHHur543bb/rKNJLGaYLmQGhZgDsiizpcFkGwOdHszHoKBkWMEApGuAw
	23z5lAGZ5J59dC98p/fOdPs0BAmYeQRIxMjQdKnj3uxrcntScJOHS5MXWzYq2HCF
	6xGV5bfp2Z7AzkRjGMXzU6swerVk9rTx6Ax4j6FyZOUmhNTivqSyor/nayogqNLA
	1oKpCA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 450kqg2fhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:09:05 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-221063a808dso90249195ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740424145; x=1741028945;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zavfbH1zR/1Hpjz69wllzxoWL+BaXWGYetefdcl5eoY=;
        b=i6nnzt17Bw/qbbOckMOCTcZA8A1rwK5TUU0GJzEzBn4j3zxJPGRQ57gyWn2y5nFMBM
         e3OJqcQalSjOOYYWxoTP5m68bnsigz8uU9QRFBu+2vfh8nLZbUiUUE9ahehYufT2JnYN
         3kpfnSRfnnx6Wq0EvLxYAZR99e/WpgFnF5O8nmk9LEOI/fL+JwXiQZEwLExsiIk6tZ36
         IR1pF+NYqTOcTQnTdvmFBJ2Va0QXNykKtFy4N9KtqQiyNHhjokfc8NdyX33IGvsbf3XY
         pvf0ot07iWdY9FNXX+rAjw2ovdKhe1/Y81dEy98hSLJndebcx4mkFuJJrE7o1B7Pa++m
         mAvA==
X-Gm-Message-State: AOJu0YwQnca3K2o2IL9eiixY9oZFMwXENhLrZc6ndO5sqFoMbUU9B2ol
	dUUsXHH4qmSmCsAoEXBU3DsJ12WdMTD9xP+M6axBcbPK6HEisCh8cGo2JoXbI8Pld9afqXJVoXN
	ZMdQNUzx/HXU74eIvt7OmwTpcuwFIPU5YvD1BmSJfmJKFh3KeErS+JSzplqjbLX4=
X-Gm-Gg: ASbGnctqE0I3iUkWhfL4tZtnogYEdDP1b5TgHerB3bGw/KkZZOwggz4V+UfBYGrraRf
	c99mPOhlhV7Bxicrqd2V4ASP7glkxcLBL51Ahn6kf2BWiAb5R9Rdr8520EcZHSOI44ufmRLklZM
	CKOWxgmXPph7vfWUqPfiF6yQ2IqmucbBqiIU6JfPRjAYqgimiTohwBRFNTKm5ysYe4yRg/seGJG
	dkgDCw/i99hbkqlBfyGiyBcYmVC24nr8x8aPat14ZCqquvAodHpPFjpBEIJ8lh4YF7e5+7bVyFd
	9P7nipv0rXcMP7jU5y4J+tHeIb3T53NyxnbEWziQW4Eq5xrhQx6AZ113Rs1oiObQw8YEbgI+MBl
	eqyKYIADg
X-Received: by 2002:a17:902:d485:b0:216:4c88:d939 with SMTP id d9443c01a7336-221a001566bmr251110675ad.38.1740424144814;
        Mon, 24 Feb 2025 11:09:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcdxrqY3Lyk9CkgTZBMPvmDZreZBBgsyz9s8m4CzkH23FajmfKJsLRld5cYoHmaSFvTzGfDw==
X-Received: by 2002:a17:902:d485:b0:216:4c88:d939 with SMTP id d9443c01a7336-221a001566bmr251110365ad.38.1740424144434;
        Mon, 24 Feb 2025 11:09:04 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d6fa9b75sm181348775ad.199.2025.02.24.11.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 11:09:04 -0800 (PST)
Message-ID: <763bd905-6f1a-42a9-9f81-acecd98131a4@oss.qualcomm.com>
Date: Mon, 24 Feb 2025 11:09:02 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] checkpatch: Add support for checkpatch-ignore note
To: Brendan Jackman <jackmanb@google.com>, Andy Whitcroft
 <apw@canonical.com>,
        Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20250115-checkpatch-ignore-v2-0-8467750bf713@google.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250115-checkpatch-ignore-v2-0-8467750bf713@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bom59ekuXQGi0GWltqT1rqv1EUBhuZKP
X-Proofpoint-ORIG-GUID: bom59ekuXQGi0GWltqT1rqv1EUBhuZKP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240124

On 1/15/2025 7:33 AM, Brendan Jackman wrote:
> Checkpatch sometimes has false positives. This makes it less useful for
> automatic usage: tools like b4 [0] can run checkpatch on all of your
> patches and give you a quick overview. When iterating on a branch, it's
> tiresome to manually re-check that any errors are known false positives.
> 
> This patch adds a feature to record in the patch "graveyard" (after the
> "---" that a patch might produce a certain checkpatch error, and that
> this is an expected false positive.
> 
> Note, for Git users this will require some configuration changes to
> adopt (see documentation patch), and not all tools that wrap Checkpatch
> will automatically be able to take advantage. Changes are required for
> `b4 prep --check` to work [0], I'll send that separately if this patch
> is accepted.
> 
> [0] https://github.com/bjackman/b4/tree/checkpatch-ignore

While this addresses one issue with checkpatch, it doesn't solve what I
consider to be a bigger issue, namely to have a way for checkpatch to ignore
false positives (or deliberate use of non-compliant code) when run with the -f
flag.

I don't know how many times I've seen new kernel contributors try to "fix"
checkpatch issues as their first commit, and contribute broken code in the
process. This is especially true when trying to "fix" macros.

So IMO what would be more useful is to have some way to document these
overrides in the tree so that they could be honored both when processing
patches as well as when processing files.

Note that thanks to Kalle's work, the wireless/ath drivers have their own way
of doing this, but of course that only works if you run the scripts.
checkpatch run normally would still flag the issues.

more surgical:
<https://github.com/qca/qca-swiss-army-knife/blob/master/tools/scripts/ath12k/ath12k-check>

less surgical:
<https://github.com/qca/qca-swiss-army-knife/blob/master/tools/scripts/ath11k/ath11k-check>
<https://github.com/qca/qca-swiss-army-knife/blob/master/tools/scripts/ath10k/ath10k-check>

/jeff

