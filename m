Return-Path: <linux-kernel+bounces-420996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 432B09D8563
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D806B162552
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CD519CC37;
	Mon, 25 Nov 2024 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UNLquEGo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AECE17A597
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732537362; cv=none; b=NkmBGqbGhENuVsegL1otzrfYVdTYqDp1at7DVHH8ON7to/ztXqUPLlznPeEu2ZPvHv/DlKCWT4JTENRSMHgfMfcdAV8Xy8P5pC8UZADkv+KU8YT3SAgDg1gClmdrnKDu0k91dvYl49RROd0YcZS2rSc0qtndy19GFOVUoIRoFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732537362; c=relaxed/simple;
	bh=bf/hjz99DiiGbSoXbH318dR4pv+yRnk7jBkL5BZdmrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaP7hEWDA4pS+rjSqu7NoHFnrbql32Es0o3G/SRYrD+5i2OeroDGHazb11I9Gq1d6YQBNSeQmO2ALTCUR+CMSiLBUkoeAaNHvR0KCU2p1vt2oTvBlsDOaa3sZLicjXGmTkOmdGHRnnQV7R6sb4ObczOpBmR38OzugCLeqiu/LDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UNLquEGo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APAWq3k027381
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lGsgBh8DX/jnU4tUYXMAAVV50pnLwHeeReg1oTVAlu4=; b=UNLquEGoHdX7qF5a
	BpFSsqJ0XeN5kVIEySitp2WQ9UBVp/BFZX9eUrU5HbMPs+f8dg1HLl71sO6yqajS
	ZvfA3cjoGkb5KdooWlqkZ64kMSAN9RH8D8gBuL/9w0MB/cyTBHGIUoKmyI20GLJl
	y7N4Yeo2gzdb8ymmnm/yWLCVhmOWMwlR0enKkSDvcTAIz78g8eAb1OA4J8kdCSk7
	syajxlatH9wixOkEooQOSW//s7etUl4LjZdypeXozwqG4UoQgmbXD7wB6+BxqI4x
	afHIR6A0S5/tdwqL/QIE9HhhpKh8zCtSdO9TcL9lLU5KC5VhzDBZdM6cJxgthWHf
	at2fdw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4334dmvwa1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:22:39 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-46680667b3aso2698501cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 04:22:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732537359; x=1733142159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGsgBh8DX/jnU4tUYXMAAVV50pnLwHeeReg1oTVAlu4=;
        b=TGb5LZGI9rIdeW6dZPLY/twkK5BJOjpTzpQKz9r/o7udYcMsuDv30JyHa8Mo70HUzc
         dWpOcF2fEx2k1POCWUia3Bx66oT7ZEGw37pvxAJvBZBd51geHL9yHImZgty5c6IpZPc8
         jzCssG8ybJrsYy9kgrfy1Exm1C9CavmAiuS/O5+NC66VsX7dPcJAcKVU56rNgsb9MHxy
         gVPtMnrHfeUd7vagbVPcPo0RwrWCwFYRj/hQz7YEciuJKbpCHDKsEGQjWhMR7AYaRD9L
         Spw77bZhvCBKxqry5tqzxO03MsPppBXiqqIKTwrXqqwzErSSpt7CgZSb/pSZycqrm6r0
         Uqog==
X-Forwarded-Encrypted: i=1; AJvYcCWLG1bJmWaFGPExAp8/cRDzmXB8uzLfAV/5+AWrji9RzUGwlbf8/rnNVTJLR8yFE+rd2v5cl+BqI91UyBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXpxkKIO5OMRTLuJnSSdNBLOx+1Cx4QVvSoVL5MMQ+UPbJa0dq
	PN7GQC2BsQAbpZO+UawDbhYsyXY+vHQQElHzRIu+Rj+BgWdX6o2EEXuccPYz9b/oYxwdtAt78Kw
	bJNBPqYVQNjW7EVsW1wCCGDfmFeImJ/jQ0ilGmFVaMSZdRX4snpiasKRHgwJg3+o=
X-Gm-Gg: ASbGncuF6wtH1s8y0T6tZgj9yNWsj8N9O0bsIoSkPrVGcqpAMx9K9O5PPoi1R3zgRqg
	ob04aAkPl3ok+8ErH9BNHehRht6CB8+M+CSBDXYegoo7yQWFE9PeeIejeY+m8px7EFh0PHh5tZk
	Xf5cyRHrDLMfuUzR7gUraWTFDFnPMh6ndPc+TGO4uuNLQnNPFOh6vAVL2wX2C/09uh++5DqZt4h
	9jOzsBWRWsMAL11fZc5zo9i+QwVr8ZDbWS4o/TOIXe7ya19RnLs6yiWi64rM+2qpWPxZLhPX0zi
	ECKuJJrdXrlKYMeZoimEkpFE+qHLReU=
X-Received: by 2002:ac8:1246:0:b0:466:88ba:2031 with SMTP id d75a77b69052e-46688ba2359mr24593491cf.13.1732537359007;
        Mon, 25 Nov 2024 04:22:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp3cHKk6o39VMe0fU98GsfCHedykBDk3Eeru+jtD6QzHbQvQ5UtCYJJftsXO/hkoFpN8NJWQ==
X-Received: by 2002:ac8:1246:0:b0:466:88ba:2031 with SMTP id d75a77b69052e-46688ba2359mr24593201cf.13.1732537358419;
        Mon, 25 Nov 2024 04:22:38 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d41ae1fsm4042118a12.79.2024.11.25.04.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 04:22:38 -0800 (PST)
Message-ID: <b13f35be-eeb8-4e29-965e-a7ac3cc4d3bc@oss.qualcomm.com>
Date: Mon, 25 Nov 2024 13:22:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: x1e80100-vivobook-s15: Add lid
 switch
To: maud_spierings@hotmail.com, Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Douglas Anderson
 <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241124-asus_qcom_display-v3-0-002b723b1920@hotmail.com>
 <20241124-asus_qcom_display-v3-3-002b723b1920@hotmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241124-asus_qcom_display-v3-3-002b723b1920@hotmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1TXM_-H9ke9SQzSMBCtNWhImYP2Q_e1o
X-Proofpoint-ORIG-GUID: 1TXM_-H9ke9SQzSMBCtNWhImYP2Q_e1o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxlogscore=745 phishscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411250106

On 24.11.2024 11:00 AM, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maud_spierings@hotmail.com>
> 
> Add the lid switch for the Asus vivobook s15
> 
> Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

