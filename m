Return-Path: <linux-kernel+bounces-575587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD20A70481
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20193AB8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69886258CD6;
	Tue, 25 Mar 2025 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y97GqSXP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862CE1EDA3E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914990; cv=none; b=BJF3mttRq2yOr5KE4ZkAzxSRjty1H+rs0T1EalfUmfwW1eueOshEtZY5EDr4M0m22gJQki5evLe+RgJKG8XBX4BfeySiGp2+y7cvSts5UIDiKyG6yqN0V5eYaLTAc9tXBcCCgvgirk/5VwD1vGR/DF5ouVfvsQ2fG7BIJA6cVso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914990; c=relaxed/simple;
	bh=7A7ZDiOqHnUbfvAS9wZIZIbSODMZmjd4GPAjhIJ24S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkW9ypXRh0P8Kza0dZxXdAK/SmGdXNyX+A18aZU50AsfYY1h2pdVepxn+aF4B4cz0ncT+SAt6DxUoeQuRp5AM+9lZ19vlL42S6yy5f8k75tylLeTSl+Gsqn3qbHpx+YvCEvJ1eT0b3YAMWRMBgnizQgEyullffiWL9iYcboVN4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y97GqSXP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PDBxmG024734
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7A7ZDiOqHnUbfvAS9wZIZIbSODMZmjd4GPAjhIJ24S4=; b=Y97GqSXPdHOVcFGc
	0ivk+KFR4Ltol1b4CCpfZF3wLEVhwNUrenO/s5RdyH9G0ESURNCgpO+744YI4c/b
	1IWILmWtm1kMKeCVW4te/1m/uxOfHlIJ6sPwJKAF8VJGSrlwW2WIvwxV3uBhsn5S
	fMiPEm82erfCBSgK1aLt+7JYIAQQAcZ+RUp+UNAtKdncbSs6LAqXL3qkgAjR4Qug
	WHISKlpYZqtW90PSRsDrRMMewxgdUP1aU23FC3J4+qOAGlcrL/ArGr06oh0EKeHc
	Cv/KQIIY15Ryk+MWor0yRdGMHwdpRjDq10xevjmRxku5twq7ZPkP09U0DwZ7JRt6
	Q0wESQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45k7qjbxsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:03:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22412127fd7so72326415ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742914988; x=1743519788;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7A7ZDiOqHnUbfvAS9wZIZIbSODMZmjd4GPAjhIJ24S4=;
        b=wfy7rW63goQ9vtPvYcioldhyZZQm8PyHhKgLxo0U6xFupY9/DxJ8q36govQDsV4N1y
         P0qnB5jt0jh9MM2vGbBO0XfFcQa3QkIEVZrLTJAUQgK1ZVwRoGI2NpdKo+BDkgzQ31IL
         wnrLKNXi3VvkF/Sivk23CKLv98l9WpE4CWR0CuJP4ua1ZIIruKouAS3w/LdyhLGzvhYt
         gZ1MdqWYwyHGPP1xczNP9TzqCjMn64/BMegHyL7G7sxsuezhzgAUy6duqP52hCKvZNBV
         kcXrDsiAr26K0zhAPHJMSy1sDHTd1af8NpJnobNCOiipe/ssQCQGH6sVd/cZ21/+KnJt
         FOlA==
X-Forwarded-Encrypted: i=1; AJvYcCVouIDlXDiM3u7O8AeBSVGoTTgI6rSKDuaPVbLz8l76FCd4zCUkFp1uZG+Tk3HMT/7eWCDaHxb9dDGJUZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqOUsdehMdz+C2Ok5gP1GYFOWc0kWQfD47fOjp5J5dQ93fh/dq
	i9JtGH/eXfYmoev6GJy0hl9H85WNMfDvgzOXQElW/EcEpQ+T1otzbYdkkk2fLMtONJAYAii+LrS
	v04E/lY3mAcvLW+uVRYN46feSolnJXNQgI2s8R8yk1t1Os1aVGoD49fY2XGli1ks=
X-Gm-Gg: ASbGncvHeTX6GJQlT5adWUk3qn1DFc/p5XAyTYCR1aqc2eySPUHqt84XPxiynz+5fSj
	FCpaDDis4hCO7w2X7cgp4gCB1dSFyFl0pKMGvCdERR9SeI/goRbxwKbawL1q/GT1yc9VZ4EPLaM
	KlPV874oDGpQQF7qmneTIEr4EKeovhRUev6YEu7HsFNVHYo68l7mBqj7ZPIG6CGF2s4oCsRM3iV
	l8mOimWoRHbsjbo9EcoL4dUzxQd+vx/THkgz+ue3+dXsXWFXUEC81OSmR/sF/CArJhhUegcRoE9
	gh4faLUDVDCElPGuzPq72UT8s5/13LuRe6V1kwY4PulI34Yfnl1BcCGuvabCz6arYwNrHWI=
X-Received: by 2002:a17:902:f54a:b0:220:cb1a:da5 with SMTP id d9443c01a7336-22780e1a937mr232137355ad.40.1742914987432;
        Tue, 25 Mar 2025 08:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj0G17oKrsRqQ34Kky25D17MpTcUUHpiNy95lIxkySWp/0bWIokIF4DIpzUQhqilnLyTxDeg==
X-Received: by 2002:a17:902:f54a:b0:220:cb1a:da5 with SMTP id d9443c01a7336-22780e1a937mr232136605ad.40.1742914986741;
        Tue, 25 Mar 2025 08:03:06 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811d9f1bsm91378175ad.166.2025.03.25.08.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 08:03:06 -0700 (PDT)
Message-ID: <978e72a6-0da4-4eb2-9c18-5b42db543160@oss.qualcomm.com>
Date: Tue, 25 Mar 2025 08:03:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] samples/livepatch: add module descriptions
To: Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Josh Poimboeuf
 <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Joe Lawrence <joe.lawrence@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Easwar Hariharan <eahariha@linux.microsoft.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324173242.1501003-1-arnd@kernel.org>
 <20250324173242.1501003-3-arnd@kernel.org> <Z-J--iv8LzgArWAX@pathway.suse.cz>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <Z-J--iv8LzgArWAX@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: X2uyGlueOjjACooFLkHLKkGwmcoBLdTz
X-Proofpoint-GUID: X2uyGlueOjjACooFLkHLKkGwmcoBLdTz
X-Authority-Analysis: v=2.4 cv=feOty1QF c=1 sm=1 tr=0 ts=67e2c5ac cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=qSXTfUft287E2HETxpAA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_06,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=934 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250106

On 3/25/2025 3:01 AM, Petr Mladek wrote:
> Arnd, should I push this via the livepatch tree or would you prefer to push
> the entire patchset together? Both ways work for me.

My past experience was to let individual maintainers take the ones that apply
to their trees, and then Andrew can pick up the stragglers.

/jeff

