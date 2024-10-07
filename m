Return-Path: <linux-kernel+bounces-353328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88E4992C4B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B0D9B23988
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E08E1D2B0D;
	Mon,  7 Oct 2024 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PrE2Txgy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01C31D2B0F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728305090; cv=none; b=Uf+4el12fZaHosDIdkbfTiQl1SXM4MQhFEM9ARAD1QuXGBhahYEb+cnU8HrwTg8nlRC8Sia6Zhy0cuiWNoYwWy57gnXPb8wMBEY98VkNtZd9LFHV7mKtHD1h4BtcVKeKOENWh2Hohe75TVXGwJgDj4uVqu5/glbtsE4DLA2Cvig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728305090; c=relaxed/simple;
	bh=Rl4liUaRxBnouuBBvvdQT4+sWNCg42lUfKgcu3cLD94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJbsKpTHNYzji10+82QXJspBr4Lu2PqIk2/DT6mbdOvkhYprio/Oqu82+O4hyhBICTj1OeGSbOAvEw5Yn8nlOG4sjFZz/zI8GtAojp8RqnDF8SS1U/a+XWvwXgLbHG+gVehd01CVhNK9mH/G0QGQDlTNG6QJD9is2HXlf7FKunk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PrE2Txgy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4974Sqfq019049
	for <linux-kernel@vger.kernel.org>; Mon, 7 Oct 2024 12:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xsTKeE4kFG92QsawTQvpbz6F1lqWQVaJIVgDGfIY4DA=; b=PrE2Txgyttu6ZGXv
	GbQnczqCZJy+IL/g3I2PFTk8wq/PlzFaRX4RgeCx82nKAPbYMbRDM0OBeqbibVZ5
	qzQqqMkQKWl85s2sfILsvTjUPTNItRlkrIh8+nBiW7sBek07a9HE3rosZhKfda/Z
	28ZrH8NiUikdvvBWbwOjZ8fOFDV8pcn86yS5qIJhHxfQtLUM1YkiLStD6jxfK+S8
	bkc+n9C5iLOTi7DAOiOfOG56O1k5yxZq3lxU713OSKgyTDQTExn8hpbqUsQ0dogT
	wmOEFxX8FYGOMMQ2jF48yyOzrwadpcZWYqssqn9QMkzAseEzUQGk+vzCeucg+cCW
	mHJMNw==
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xsn446m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 12:13:47 +0000 (GMT)
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c8828b03a3so524875a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 05:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728303226; x=1728908026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsTKeE4kFG92QsawTQvpbz6F1lqWQVaJIVgDGfIY4DA=;
        b=mlew2SFZ/tY6zLKOKA31PoKdC6/T04/BkhbLbbeWYBSb3YDafokKmN4CFPk7rddYkO
         l8ALLOKFQq96hEX1k2mUaJHsXj/bxXssSR4WstywvKkzgU5DvRdYA0xm8VEOPdnjM/EZ
         kyedHnVgJPbpjVFCd5K+3u90XNImo7DNQ3LB9NXtAYdrv6ZKs/CdFBxZH+SlrMtOI/R3
         UAxc8al8h0PLSJkC4Co5JPpuL05PeP0zTLPbXa4Hwr0iNyZMR0uMzu6fFSieK6zXZ7w2
         GIPY4KanzDt5qZuKCK0R/SYnEbX6wmKJ4V7ldS6e8+zM/7yUOHvjCQ+cjeBcguybWjME
         dBvA==
X-Forwarded-Encrypted: i=1; AJvYcCU+kvuHcHpMV9iOPHy5YJ4iIEiUSmWyd5Rpqj/S1MvvzrfoKpAEt/wFTzxV4zgcqw7Yrl6kNZL05oeGHDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5t9By6CbmjO1TaLd0pHVbOsfv31AEXqVXx3Xn0UYYaQD9I9C4
	ElD56JEQp1l0FknV5OJJ08MeFjc0oyvl/xZ15xpD79THol8GCP4UdP/madGDdCpO1VxKFGwR/c1
	L5iIwokS+MKzHAnybYpXN1QdbYUebmBBc0mGRROwDatoV5zyNs9vOVL6a6KV9nIQ=
X-Received: by 2002:a05:6402:3593:b0:5c3:ca96:3cb1 with SMTP id 4fb4d7f45d1cf-5c8d2e98986mr4454210a12.6.1728303226165;
        Mon, 07 Oct 2024 05:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEUHy1e1GVRjag7W+sF/FYdwN1bMc8bFNqWZQqVx29m/yszefcmjKsr1aF9Spv+mpfIt4T5g==
X-Received: by 2002:a05:6402:3593:b0:5c3:ca96:3cb1 with SMTP id 4fb4d7f45d1cf-5c8d2e98986mr4454190a12.6.1728303225414;
        Mon, 07 Oct 2024 05:13:45 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eba16sm3140682a12.77.2024.10.07.05.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 05:13:45 -0700 (PDT)
Message-ID: <55d1a79b-0220-4b13-b1dd-0b34eb1ddb94@oss.qualcomm.com>
Date: Mon, 7 Oct 2024 14:13:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8450 fix PIPE clock specification for
 pcie1
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241006-fix-sm8450-pcie1-v1-1-4f227c9082ed@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241006-fix-sm8450-pcie1-v1-1-4f227c9082ed@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: d3h99DnTl1qWjiooSfzC3bh_Q_GEelGP
X-Proofpoint-GUID: d3h99DnTl1qWjiooSfzC3bh_Q_GEelGP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410070086

On 6.10.2024 6:47 PM, Dmitry Baryshkov wrote:
> For historical reasons on SM8450 the second PCIe host (pcie1) also keeps
> a reference to the PIPE clock coming from the PHY. Commit e76862840660
> ("arm64: dts: qcom: sm8450: correct pcie1 phy clocks inputs to gcc") has
> updated the PHY to use #clock-cells = <1>, making just <&pcie1_phy>
> clock specification invalid. Update corresponding clock entry in the
> PCIe1 host node.
> 
>  /soc@0/pcie@1c08000: Failed to get clk index: 2 ret: -22
>  qcom-pcie 1c08000.pcie: Failed to get clocks
>  qcom-pcie 1c08000.pcie: probe with driver qcom-pcie failed with error -22
> 
> Fixes: e76862840660 ("arm64: dts: qcom: sm8450: correct pcie1 phy clocks inputs to gcc")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

