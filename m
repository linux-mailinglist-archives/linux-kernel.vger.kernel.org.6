Return-Path: <linux-kernel+bounces-395025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8558D9BB749
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76021C21EDB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D15C111AD;
	Mon,  4 Nov 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U1HnT3jP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59A2249E5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729720; cv=none; b=ZB9gxnNbWjC/u9CFRpoz2OSQSPwZ/ZlqCn2hIdRpmVJeyLnE58EhMseE0YAawo7btMM/PcKmzSjMUvrRVqE6iGgZpoChfwQeXBJT8jz2b3aZRQWxL78kblfFT+EqyKs5lULK1S2o5yJXohCCZi/9u0nnYK5tVe1GqmEcHr3W2wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729720; c=relaxed/simple;
	bh=WmBXEupmtM8Q9AltIoqywvW+F90VNzrMzVzsJOELilY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ect5zas1y6/tc3Vuxh526riTuiZ4mknaRCPegf2ByHpZ/J3rT721qBR50DP3YLFOcP5MNLE6dnqdgf2/Dwj8wOUmzEVLDMNX7GNPqi9bWKgxLg2Ilg9eTNnoUgIH3qDSj6HmgEhlb+v+55Z5eNyMRFWBwbnKAODNXwaBs2++JsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U1HnT3jP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4Bj2dl026158
	for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2024 14:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IqoIwtujkhfAAOgoHLEE0EEhIIqjSy1D+L10XQtFSJE=; b=U1HnT3jPJYbw5MKd
	xLgj6q6tl3OrWQMptHzUjv8goCH2O0MVPnrTEPnFQ2cBgp1p7ZdWDgUsdIreLBiw
	rXFoapPNKtbX45Bau3eTNT5lmVPfgZivkD8XsO6NH/G56xSn14Kf/UvwrDar2isF
	bPui32bxVYUkzt9eubMDyCqWzclUYnZoNuyV9nVxD1WM3hopTEwH+yk5V3nTGZlz
	+KHBPE6yZHteT5dDPYoSHQ7yr6vIYZQdFAiiJCukK2N5+5bpIjyaNmzuFgLF3t4N
	gE4BAuj6h2k7Rb1TsiX04bez5kx9SOPSEkcrMU/BokeY0g+cboO/POWGsDpmTP0s
	Yxdbrw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd1fmgqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 14:15:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4609c883bb6so10570521cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 06:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730729716; x=1731334516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqoIwtujkhfAAOgoHLEE0EEhIIqjSy1D+L10XQtFSJE=;
        b=kPfyx7Eq1qh7PZuphQ3RgczTi/O/YvvrgHp4+7yaL62aLeyOANnVhOnzFOzEw4fDXE
         UvKcehEyYHOX0HMWCKHmqSU6Vl85kNTlhuYfbjQ2M6UFPRdU3p3zizhre+NookTE5IbV
         xyAx1O5sWtpVGr8tDDy8K+1E+AlZvf6GFTSIM+sT4a7Qv/kUAMbS7JjYsKP4caAs3FUM
         2l4jZ78Ci1bx6DTo/gPEzEbLiMqdPc7XeIaDCP7vc0QVJgqXyHxjRABjZuPYfo3l/ihG
         vX5ZQuqqRCMrLojO9Sh7TZKfgGlOWppVTkwdD/j5lLn0RYbKqYOrNitdZe3Ht/lfeQcB
         w6KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQmijsDFbXAZOKWZLRBIRa514ABPxkYIaX4CpTDxEKx3wG86cPJDFnr9cra0NTRnaUngjJMMQe4xfLH7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH/rv5YdLOFFNSmm+lDV0GAefjOfaSaNvXNsG2F9/7ywDqQxAW
	lCG+GLIJ/xkURTNOgXRYER8Ul30dICNgTIUVR53LR//B0xglzryBqoQSLzFzhyWysI31EUlBUKq
	l6cO6y+3kVphfkUReorJGZq7kC54GCmh8t1QEPTYls1gnukFQtdtS7GRjqKaYXYgq85YT31Q=
X-Received: by 2002:a05:622a:156:b0:461:2416:13c3 with SMTP id d75a77b69052e-4613c1e51bfmr193819951cf.15.1730729716338;
        Mon, 04 Nov 2024 06:15:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDOSOCG2LFj9NXKlT9QQjwge9d2l8AqzVkV1gSOkX9wHMuy75okXlhwq7d5WmBKF+L/3Olfg==
X-Received: by 2002:a05:622a:156:b0:461:2416:13c3 with SMTP id d75a77b69052e-4613c1e51bfmr193819681cf.15.1730729716047;
        Mon, 04 Nov 2024 06:15:16 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac789bf2sm4244956a12.45.2024.11.04.06.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 06:15:14 -0800 (PST)
Message-ID: <ee668cbf-54e0-4c0a-b690-8606cb3785b7@oss.qualcomm.com>
Date: Mon, 4 Nov 2024 15:15:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/12] arm64: dts: qcom: sdm845-starqltechn: add
 display PMIC
To: Dzmitry Sankouski <dsankouski@gmail.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241008-starqltechn_integration_upstream-v6-0-5445365d3052@gmail.com>
 <20241008-starqltechn_integration_upstream-v6-8-5445365d3052@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241008-starqltechn_integration_upstream-v6-8-5445365d3052@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Nar82sQxYgKaTXlrXgotOZEHLTW8xMan
X-Proofpoint-ORIG-GUID: Nar82sQxYgKaTXlrXgotOZEHLTW8xMan
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=868 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040124

On 8.10.2024 6:51 PM, Dzmitry Sankouski wrote:
> Add support for s2dos05 display / touchscreen PMIC
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> Changes in v6:
> - refactor: s/starqltechn/sdm845-starqltechn in subject
> - refactor: 'i' < 'm', so put tlmm i2c node before motor*

Now you have 'i'2c21 before 'g'pio-regulator :/

> 
> Changes in v5:
> - simplify regulator names
> - remove single buck index
> ---

[...]

>  
> +	i2c21 {
> +		compatible = "i2c-gpio";

I'm not sure this has been asked before - is the GENI SE for I2C21
disabled? Or are there reasons to use i2c-gpio instead?

Konrad

