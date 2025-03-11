Return-Path: <linux-kernel+bounces-556894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EEDA5CFFB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CB5189EFD4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB001262819;
	Tue, 11 Mar 2025 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lGefwrkS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EAA222562
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722854; cv=none; b=APGJEETa3lwwMC7E6YHLC+CCrmBLf28CheDrI7YEWnbr5O7CKLOmcTSsv8mtu4A+C6Nt/DitZTi3JQSWiJhIstcil2lyBJjDXp2d45y83sWyXyNhcZ0sIOmlRSp76oad0z+KhXkFyaCfzotrDn6+Vc1GyUkYAkxHz9d2wSSmhZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722854; c=relaxed/simple;
	bh=Entolay+VAXdxyC0CH6yST+s5QzAg2i+syp/vkY4tBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/qZjbPyG59lt+dFmiX9/rMKiIagZsTaAqIyPKmYPVmj27m9gsmw9h4dLHqSo6DxfYBnpwr+xtCYekCMBgbqsLkR+pi/M6kEpnfdVwXhbzcAU1/M1c2qwJYkYNjK/ftnxMfKKBMgag2iDzD689E+3E/bxbL/dTuZtk0FUiapxeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lGefwrkS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BJ8CF4017358
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8LvrzCoyRcnokqfWsWAyaCE8ZZEx0wnVjTTpDK4H0Gs=; b=lGefwrkSrMT01Brn
	MZPMWKB8cKXXo3GtRDh6P4ksGFvg0+vM91zxHe2ejzoLIQ03OrGGYOrGTYG/LuHS
	XRQmUWfMIO/5X6ZNzfR1UonNp49hShVkog6q0ihPi6b/xC68d71qlggu6/HKL9Go
	jWmQPP/jOxvFTSQmPbzMvUo6yqJGzJWSoEYtZ+aMYHZy6hLlG/z94gJL/TwKHdra
	cG5xCs5+g/zUA6y43JSRH8SSkn0zxdgnANDYTc9TpcPBPCMJ2AwpZBRpLGJ2g2CI
	mhQZm6QBX5k67g25JcXceB+gWsvg7kW680D32oVJJolxqZQOlY6cKfsRBi3fqJ9b
	UTXn6w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2p03eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:54:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2240a7aceeaso104543535ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741722850; x=1742327650;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LvrzCoyRcnokqfWsWAyaCE8ZZEx0wnVjTTpDK4H0Gs=;
        b=qGZyl5skKO2eMLyrl/8lFJKyOLUtPyxUpuhX9kdjuvY70n0AiS8URomsA86jcOLf4M
         SCzSpiCNHqmOAKmKiXWtyCAb/4pwu/C0RjRI/UTOI68n98Sde/YeCBxn2eeayhjVZiLG
         Ow00YfyWHQcmzEx0ph/JzxuNOzhyJRUQYGvuxqpaxKmHwulde7aotNTtzCD4T5OGZtPN
         N7H8zwdV4TRh8TfWsV5EmfUP5dKGPSdcqnC1xeA+wIV+Ixn2GcMb1schgTvuntrPGMK/
         Ja30/aJVRKd9ljJ2FFnAcN9v7Zd7unoj1nE7mWlz2yvwPzI2t8F8Z3uwVpVOYYpw/Ww2
         3ruQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJXe8oXN4j4M8fftxTHn2axvARlSHqucnZxWqyk0YrSgafDnWFnPvBzhfdTcNmWqUxPFKl2FVUS7DJyGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHaTWGuaiWMYvWkiwLm6J81WvnQ1tVEJV9hq3MjIilXCSW59oL
	oVXzBF1EPCdfvBX1mWJEJtdY1bpUBrCZn0UMmdP6hA07PcKiuzUJ38oaw1Wk7dw4/urhzlhEgre
	ronfgOWV6Gu0HsKLoFVMAgW2RK1DT8xCy6/dcLKh72TA6SbHhopJ2w8bHvJdEgaM=
X-Gm-Gg: ASbGnctVr07Zn9jdOV29DThnyJe5s7DNZl+mC56TvYxbFpvRYF5vfylQHaVVkMaGqby
	pttqFZM+7MESn+TOFAVQbM8pKTU88foefgto2gRx34pUtkWL/Ws8C+vzv1mPEHr3uzQ2G93y+Ub
	kFznFUH8H6hBoZ9JSaIhEruuk5bZtPWtNJ8PNK3dp7V6iwy6Jrr0UE/uZwv/LToJK76kPwxMl1R
	t130h+XvoDpIxLSJEdtiz7REkSDRTRUjAhCPoImJBt2oEQDFMKALebJ+QEoOShRoVyrx8uJO3PF
	FkrrRZWyU7tvz99sqqCHnaFxVu+sOYx0RnY87AqBkqmfIIJdn3p9DomnTuiM081kZwwOzpU=
X-Received: by 2002:a17:903:40cb:b0:224:10b9:357a with SMTP id d9443c01a7336-22428c05724mr298846865ad.32.1741722850019;
        Tue, 11 Mar 2025 12:54:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECJkBAlenpxOBydMU08uTw8PQlAnpehdDmaEUFLZl6XGgFg92N2EQoE2/07x+B2J6JCPdWJQ==
X-Received: by 2002:a17:903:40cb:b0:224:10b9:357a with SMTP id d9443c01a7336-22428c05724mr298846635ad.32.1741722849669;
        Tue, 11 Mar 2025 12:54:09 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa5cdbsm101668195ad.230.2025.03.11.12.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 12:54:09 -0700 (PDT)
Message-ID: <ffa8d0d4-269a-4bae-9dea-adc221819b17@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 12:54:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] script: modpost: require a MODULE_DESCRIPTION()
To: Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Arnd Bergmann <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250311-moddesc-error-v1-1-79adedf48d0e@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250311-moddesc-error-v1-1-79adedf48d0e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HP/DFptv c=1 sm=1 tr=0 ts=67d094e3 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=s7k5bkaZ1l7C4rbi0KoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: HZIv3tTE_aFYY3eQuiSIWT4XnR3Xcn-r
X-Proofpoint-GUID: HZIv3tTE_aFYY3eQuiSIWT4XnR3Xcn-r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503110128

On 3/11/2025 12:49 PM, Jeff Johnson wrote:
> Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
> description is missing"), a module without a MODULE_DESCRIPTION() has
> resulted in a warning with make W=1. Since that time, all known
> instances of this issue have been fixed. Therefore, now make it an
> error if a MODULE_DESCRIPTION() is not present.
> 
> Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> ---
> did my treewide cleanup for v6.11, Arnd had a few more stragglers that
> he was going to fix. I hope that by posting, some of the 0-day bots
> will pick it up and hopefully provide some feedback.
> 
> Note: I'm not really sure if *all* of these have been fixed. After I

guess I should have done another 'b4 send --reflect' after I modified my cover
letter <blush>

Pretend this line is immediately after the cut


