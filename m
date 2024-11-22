Return-Path: <linux-kernel+bounces-418251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C2B9D5F56
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DD12821D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82A91DE4C4;
	Fri, 22 Nov 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BJr8FhGu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39591DE2B9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732280182; cv=none; b=Nyqn8R7I+4ex0YJ3fL+BDAgOC5OtbATBoYZdmifHeKHArWliXSqXBYPfOCGxhIox8EBWjlIFlDqJ7OV/qXR3SdGNaWVhSMJWE4ya4G/UE2uweQaaYPs1uWbhABCIN3ukO3AQM5MHwlP5lqSUcFXql0etEQ/5G/eSkxFV/VZ0tPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732280182; c=relaxed/simple;
	bh=OO5oVuYnc2B3ODhcqc01drbOppw1jE/67j9F715EyJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNvlGVcao5vChtoiNvCg9rCDOMVNeYoOnDO5dOFT5HyYgxuKnXTyi8OLRlZApSlAuG+1IhqgJyQeOU0kSgCVo5OCqOoYQ9UR4Awzw+eCEFciSjO+DZQrjuUyjZQcor1qFkTUkAGK0gqksfnjZZtpPq3KS9w54gNPgygUBk/TxiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BJr8FhGu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMAGmpM025802
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tUW1JtHByRPvJW3av3yXvdSnDSeT0Wq/tBStqi3Mqhk=; b=BJr8FhGuZpvWhucl
	5S4DJ53D8opMhrDATMHKsaoJlru1mf5X6WoHhqRyA8oj91xbWY560QD0RJLSdBLq
	nGVvh/YTUdN5L8UdqrIzSBk9v25tLmIcqs7FaLp+Cmo6mcpO93XkYxx2QMwY+YnF
	TTFBTuQnRTJPlrMnTfaJa3+yDbvJCTqnYsvc6x0pWLmGHCBXZVD1kb/DscD6YQ4A
	Z1SR8nXTWDKQ1rxJxE4RQvqPdR/3cP41EVZRgNg3RGvebngcpfwzCBX0UKHbIPQD
	d1k9/zvVoA68/VBfLdR9zeJkhR+5s6IZG+xfTVPfo+HNuxo9A4QRauR/YTTEbXSZ
	ORQOmg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 432d5b1yhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:56:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-460aca6d5e9so4684991cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 04:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732280173; x=1732884973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUW1JtHByRPvJW3av3yXvdSnDSeT0Wq/tBStqi3Mqhk=;
        b=bz8oeFZj86CcsTHBfZKNHSJdZkQOr/xDrpwsr8utpUloZUyxFLbV6j2xBI+YS0BktT
         8Cfudpg7kg6cFn72XSVnjcXoRnrL9Ro0fciCQlRNUV19E+GMDUwpSAZxYPq+JBCfXWtI
         uhy8P6iDsuW5FCEoblrB9IoKvvPIacOuQFrffvs7LyG856uY7rFcdgoP52YSSuhdIRpl
         1r1vVcuRhSRolKA/cqVFDhDarrL09b9hHJ1YQQ/xGBeyOoN72sk7oJVKAQ+/yNFmNocC
         6sTjtXHwa13EBodAtzuixse7SBzD06pH9k4HJ5SYTa0UngmiyUJpg1aG55R0a3oHg4+v
         c/3A==
X-Forwarded-Encrypted: i=1; AJvYcCV01npbPM8WNepAa3NIhzlJ039t6cFUoQRkuck4XiDtpKM0frWcGEg4cO9H4GkuVqgGFNAU651P6rVuUBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxewNQxTXtA7lDjw9ZF05RlOvXLPNxf2uhHwlv/bgRi5D6ZHHO2
	nhYY6tE/X83Od88WJqma1SvG6YOeqGarNiQmLDeiJZMXRpnT4FgxBS/lU/eiwzB9nMK/VacPWqE
	4fkmq7AHiYzQURk416ILFfRJroR6u5py2zllHH+v+DYxclmldZCCpe8VXHgR6qOc=
X-Gm-Gg: ASbGncu1hkGTS4xaq/4ho8ftFVw+vmY1VgQpftxpySjzo5MVXe5gzCyCJLOFe4ysgXI
	rK0dhszsrHhmLpupL0YfzjpV/wgGQHVlsv2OSFTpxf9ePyfFd6sq5/oUkCOG46sUQcbc+cYqxMq
	6oHtu05whxAa1QfwpUZ6H4P7xIk3XARzLI68MpxoMF6zmaJhtXokaQ/9aTWVrbuAoFEZzJ4zes5
	AcZG2R5HJiIsT9CmmE0JiV2AVFlO52kLRvpO6+xvw/9pgeL0qwBxmbqQxLWo4Do71V6/knJw5Nu
	EEH09Er7TWxnpIQ1U82ksafwegb3sTQ=
X-Received: by 2002:ac8:7d49:0:b0:461:3cd2:390 with SMTP id d75a77b69052e-4653d6207ebmr18354541cf.12.1732280173689;
        Fri, 22 Nov 2024 04:56:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXp5AlSiVdDRiJeviQopjOcYQO2cIs6n/WiIeQPHdV9fV3//vnc5hbPIVnUu+s0vmPw9sPYg==
X-Received: by 2002:ac8:7d49:0:b0:461:3cd2:390 with SMTP id d75a77b69052e-4653d6207ebmr18354171cf.12.1732280173259;
        Fri, 22 Nov 2024 04:56:13 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3a3bfdsm897816a12.5.2024.11.22.04.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 04:56:12 -0800 (PST)
Message-ID: <e107da7e-cc12-405d-b5d8-589959df072c@oss.qualcomm.com>
Date: Fri, 22 Nov 2024 13:56:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] dt-bindings: PCI: qcom: Document the QCS615 PCIe
 Controller
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org, quic_shashim@quicinc.com,
        kernel@quicinc.com, quic_tdas@quicinc.com, quic_aiquny@quicinc.com,
        quic_qianyu@quicinc.com, quic_tingweiz@quicinc.com,
        neil.armstrong@linaro.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, kishon@kernel.org,
        manivannan.sadhasivam@linaro.org, kw@linux.com, lpieralisi@kernel.org,
        bhelgaas@google.com, linux-phy@lists.infradead.org,
        conor+dt@kernel.org, konradybcio@kernel.org,
        Krishna chaitanya chundru
 <quic_krichai@quicinc.com>,
        vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        quic_kaushalk@quicinc.com
References: <20241118082619.177201-1-quic_ziyuzhan@quicinc.com>
 <20241118082619.177201-4-quic_ziyuzhan@quicinc.com>
 <173192264707.1449621.6365585789543415603.robh@kernel.org>
 <4226d136-034f-4b7f-a82b-e370ef265958@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <4226d136-034f-4b7f-a82b-e370ef265958@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: K_TPLjjN77SKq5JjEto5qpfXUOBIS0BN
X-Proofpoint-ORIG-GUID: K_TPLjjN77SKq5JjEto5qpfXUOBIS0BN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=701 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220110

On 21.11.2024 8:22 AM, Ziyue Zhang wrote:
> The dependency is missing, I will update in coverletter
> 
> On 11/18/2024 5:37 PM, Rob Herring (Arm) wrote:
>> My bot found errors running 'make dt_binding_check' on your patch:


Please don't top-post

https://lore.kernel.org/lkml/YH%2FfM%2FTsbmcZzwnX@kroah.com/

Konrad

