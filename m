Return-Path: <linux-kernel+bounces-355162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5B9994898
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1CF2830C0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 12:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B7D1DE8B0;
	Tue,  8 Oct 2024 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FvGa0XqE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B99F1DACBE
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389677; cv=none; b=UQMfC2mC//lHsgcgP5TvtAYUwnQe3YVipULtXSzZ+8+EUG412kGATi+erKMSI6DnoJjFYFT0K7YpQf3nvmyJHdO5dr/ZK1/lfTwps1Or0geS+cNbWoJ3LyS3s6t+EVm/6biDl2YUFzbGkQ6JL6IzKzg+xStlunIdCIJkACupYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389677; c=relaxed/simple;
	bh=+2VanDmZsX/1yYxJQI8Wjh0NWyEA0p46uc7xzMyY2e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kewp95KN1k0Y0fC9nTTjK0waVtVPF+G8/i5a87dM+fpyFyb4eQ9HZ0tEUqMXZrmgk4EvNldtz0n44d77llJHpjvI7xW1c20uei0o/1wBFKNT+H95r1NkUyLRuyMcua40EQrO8NiKXOaVWZ2vOib638iHPDx/+vKCwMRPP25sX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FvGa0XqE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4986W1Y4029556
	for <linux-kernel@vger.kernel.org>; Tue, 8 Oct 2024 12:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+e7pWoWMmarmd3axfCh/tbJg1p8KI6s4PoduEnyjbzs=; b=FvGa0XqEwog+sMkC
	iZK96wUTvXwIDjlANYhJNO4m8E2nJcXvoMJjzC66WOmqdflHKoLuAZquIhNKU8+7
	NKsrWT2lb3bYtxvAHTv2iGqLFSGnSTIAN96bWKarS0VN0ksQH+7CyLwGyWJPUACE
	K8qfotOOfvokwKFHpgw+dCXM9PVeftdoxeAR2USsx4+1wmIuQLWGs/dPwbZrqhhS
	kPWwHVIT3/9HwiYb2df1FUkCsC7MDK5LwNnnc01vRAMc9GIzaq5bAB6QPEE0tNC9
	ObJbN6cmeDFwWepcDLuP/ibkUFbUmgQSkbqdEZcqabn+esoNw7oPPfNF9FbURGV3
	8RmGWA==
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424yj01013-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 12:14:34 +0000 (GMT)
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4305655acd9so505825e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 05:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728389656; x=1728994456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+e7pWoWMmarmd3axfCh/tbJg1p8KI6s4PoduEnyjbzs=;
        b=kmRY5xYi/+Ded3WQe4EkFg0gH2RXWX/BInx+fuPFpjtW9S28LKhCXvfljjZ+bk/FQb
         GpGwa9XbNiXbckwxZPc6fF7smG95YEs0zua8N6o2YKD80abig5wrwNfDYeM00siRt2Oo
         q2BARiV8ADiTcDmL52Er7w97jVIHgfoVcuNY/d84oWFapr4nmh5XxejhfMZBBoD5rVsh
         Ihd0jTVyotha9IndJbqgmbiTuUiCrx96zc/ycC0JpWTkFrgYruGV+a0Qi4P7BaRhTRKO
         4kdW9Ri3tpX4H3ZHNo60sEfYQEJrMStA8YYpOZLoIhhKg10gLKYVjGnZlBkhQPbEdEEc
         VoQw==
X-Forwarded-Encrypted: i=1; AJvYcCWNYWg0obIQgerIWOP1aF/KqcrxeHM2SSF/4ea9DfsK3A51IlipbM8koLhKgUa+n9WqY5ZUwBlu58/4Cd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0hnQakHzzsY71Mb5WaFSqjTIAWOOmejJ61wQQKqW73SxMuauI
	wYkzmT0mUJ5Uw1B6UdMwmmBSTsj1VxvFRGkelmsCb9slVMvU+utrauyZ4yoCHZ/0OTUjbNwam7Q
	mPvtUqxFIdu/BijuuoFIVYzbftEeatI6grtVT2MV30jRrmFEN6m8fu5+xj0nxUFQ=
X-Received: by 2002:a5d:5f88:0:b0:378:c6f5:9e61 with SMTP id ffacd0b85a97d-37d0e77f6femr4074307f8f.2.1728389656188;
        Tue, 08 Oct 2024 05:14:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMmMN0wLU0M13Eqkk4PWvHy4b2jFXwqirYx0hgOpjsYbs2+gAOzZ88joL7DG4GzwiP1ewyfg==
X-Received: by 2002:a5d:5f88:0:b0:378:c6f5:9e61 with SMTP id ffacd0b85a97d-37d0e77f6femr4074291f8f.2.1728389655701;
        Tue, 08 Oct 2024 05:14:15 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994b0bd738sm345483066b.51.2024.10.08.05.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 05:14:15 -0700 (PDT)
Message-ID: <c8c6f8da-d7d2-40b1-a3e2-08e8270b833c@oss.qualcomm.com>
Date: Tue, 8 Oct 2024 14:14:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: Allow packing uncompressed images into distro
 packages
To: Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>
References: <20240910-uncompressed-distro-packages-v2-1-51538434787f@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20240910-uncompressed-distro-packages-v2-1-51538434787f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SpEHdZVZqxuZD5XcBz31qGKPsUBb5jFt
X-Proofpoint-ORIG-GUID: SpEHdZVZqxuZD5XcBz31qGKPsUBb5jFt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080077

On 11.09.2024 4:53 AM, Bjorn Andersson wrote:
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> The distro packages (deb-pkg, pacman-pkg, rpm-pkg) are generated using
> the compressed kernel image, which means that the kernel once installed
> can not be booted with systemd-boot.
> 
> This differs from the packages generated by the distros themselves,
> which uses the uncompressed image.
> 
> Use the newly introduced CONFIG_COMPRESSED_INSTALL option to allow
> selection of which version of the kernel image should be packaged into
> the distro packages.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

