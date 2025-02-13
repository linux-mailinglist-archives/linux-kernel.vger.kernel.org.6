Return-Path: <linux-kernel+bounces-512403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F97A338DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F10E162223
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7603207E1D;
	Thu, 13 Feb 2025 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R/0rMqmW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD931FC0FD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431854; cv=none; b=AMF/lip2SdDGozRwSxip/rVohiNfwlx+wERYMm1JxMEfWyTmmlioJeREk/YMoQ16smzs3qEdtYdlrqj9r0duWeLukeE9sji+BXValAliuX9Qz8/EuOWFXxOxQpQ8eTZKReXnDXcRfAnQuSK4Ya76ycCF7/A7OHHNTfgWoYASRdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431854; c=relaxed/simple;
	bh=aN3Lr6wUibYnqI/f3UR3bxnxRH352lurFdPMDr3wGpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/o79kLmilq+QTQPhv6h7WOre2jAHvJ94ppiBWaPUovPzPd1cQ3mdzK1g+4UIv2bhdQVZlt0j83J3lk5MiZcwqluz5CnS2uGiVdJWDzI67BG2A45AJJ7XgW/6U59Meyv39+KbzPBd6gW6t4UHvlz8OsiNHQ2lj701MoT8e1GxE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R/0rMqmW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CJdejQ001528
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QCNYViztWzNyVGjuZcYvR8osCseZOp+c2iM9vCmfw4k=; b=R/0rMqmW1RSHmyyH
	u2b1USDPdJ7aSlC531/4GzTs9XfBdPWtR3glJ0GOnjt/hqL99dF5hdHaKgfyYI0R
	FzdVsIXTqwX0crKqRCYUBJEb16DE4Q4W5akBHjTElbDrllPIe9zXQiWJZUyUXyJG
	CfCbinO4n0UO4N8++jttlWeufVwsM6Q//Wfpb7F+rkJBheQFrz1kr91/Mez21jgI
	Ltqk/KlhfDKNTGMg0gvGwDRBkKuFDXEsVljF+UTf69DZ+t3471NYtdm3UH0evOy7
	499pHdPdtYHmPjAfF3cd/29wFyICf9SfBHP63nt55WI9c6EbnAzp5DT204Dl7e3K
	vXiC2Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rrnfu1w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:30:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21f6cd48c56so9858065ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:30:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739431850; x=1740036650;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCNYViztWzNyVGjuZcYvR8osCseZOp+c2iM9vCmfw4k=;
        b=gbrZxu9QnMbO4+VkFwXsMrqv+AHmJkaGAd3kddIZzluDm6yIPvPY1LTXtc6ggguJDN
         nQj68I4W7x6Nl/XwSPVk7yWMKC3r84o8jxecWNLhSJSYnibzLBPd1vEjfZK+RMnAToo3
         vybk7voQoagVmCM70K4Q0q0JWK4kn7PLjfBPc6OphPwOHZv/m1x7ZSoVSdfjVYKsOLeF
         5Se/MHHfaNDDsAsUu5+EZ0GJ1F+Bk35681haLAclklkDZsohnuUYCjFjk1jiVFDyWk96
         VOqxvzhufT8sXWuf0OU2FjmhhH6oox546JsXZYV7mdm4eU00RSPw6yQu/d15A5iPoZYa
         2E/g==
X-Gm-Message-State: AOJu0YzjZLiYAbqs6WYkpOmQkaN4WE8QnPHkbJI2ilufrUo63f6Pfy+u
	IzR9USQyD27ziqZtLHrGRVEoUNjbcZ1exvolEUGX+bDYhVq5gwJjiMeAH+bpwkT2k9WFVyqyjuc
	nErU54Qg9GsmyWZWqmSu0QwqKTgazOORj2eHM26bJsmYU+Jq+gK5+oyam6d+7RyA=
X-Gm-Gg: ASbGncsw6kbhSd7qvVZpyAeD9T/GFlumBEymklWj1MaQDIRlSKrFVKD6dqUQ3d/OfhO
	j5gFcjYvzW5PGmdiXNQI0/c2Goeven/zc+7TzvufDGW3+JAkgwnBC/OkDJ7bY4gZqFD6XC3cVe1
	pxF/FtITbGYVaVY75S3YYBMt93Vy617HCPCJuY9R9ASMxKEvIsFNrm120OR1v/dDifqJMMUcFWL
	dSwTDD6m9JaMef8rgXccB5mvCEApZamewOGHjuH6S7t1JTlnR/yHZQw+nOyw9sOBskh/pHM6gZu
	7LQ0iCC+IO5ls4Z9yUsKVQODB01aQo19Ax4Vromcu7+FWkKc/IxAJBMmZQ0twcmjqSI+2Ol0NA=
	=
X-Received: by 2002:a17:902:e946:b0:215:9379:4650 with SMTP id d9443c01a7336-220bbc8bc56mr100108545ad.42.1739431849916;
        Wed, 12 Feb 2025 23:30:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXJWllrpEsU7pxBlVyMLO/Rybu/ihb4r1/egz6PdTfhq0gEYZa9CuRi0M1qC1i4D6yi6/26Q==
X-Received: by 2002:a17:902:e946:b0:215:9379:4650 with SMTP id d9443c01a7336-220bbc8bc56mr100108175ad.42.1739431849521;
        Wed, 12 Feb 2025 23:30:49 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d621sm6361875ad.136.2025.02.12.23.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 23:30:49 -0800 (PST)
Message-ID: <85a035e7-fb06-434c-ba26-f813fc4f3200@oss.qualcomm.com>
Date: Wed, 12 Feb 2025 23:30:48 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kbuild: fix linux-headers package build when $(CC)
 cannot link userspace
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
References: <20250213062645.325632-1-masahiroy@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250213062645.325632-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YUCkZglDs8mIO8NDt7ohrL_fKZuTPo28
X-Proofpoint-ORIG-GUID: YUCkZglDs8mIO8NDt7ohrL_fKZuTPo28
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_02,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130056

On 2/12/2025 10:26 PM, Masahiro Yamada wrote:
> Since commit 5f73e7d0386d ("kbuild: refactor cross-compiling
> linux-headers package"), the linux-headers Debian package fails to
> build when $(CC) cannot build userspace applications, for example,
> when using toolchains installed by the 0day bot.
> 
> The host programs in the linux-headers package should be rebuilt using
> the disto's cross-compiler, ${DEB_HOST_GNU_TYPE}-gcc instead of $(CC).
> Hence, the variable 'CC' must be expanded in this shell script instead
> of in the top-level Makefile.
> 
> Commit f354fc88a72a ("kbuild: install-extmod-build: add missing
> quotation marks for CC variable") was not a correct fix because
> CC="ccache gcc" should be unrelated when rebuilding userspace tools.
> 
> Fixes: 5f73e7d0386d ("kbuild: refactor cross-compiling linux-headers package")
> Reported-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> Closes: https://lore.kernel.org/linux-kbuild/CAK7LNARb3xO3ptBWOMpwKcyf3=zkfhMey5H2KnB1dOmUwM79dA@mail.gmail.com/T/#t
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the quick fix!

Tested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


