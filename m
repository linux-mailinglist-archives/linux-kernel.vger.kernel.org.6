Return-Path: <linux-kernel+bounces-382509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5805F9B0F26
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6841F23EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A6620EA3C;
	Fri, 25 Oct 2024 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PHxh82ns"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4C70815
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884923; cv=none; b=llxbPbu5N+RkWkfTeLyZp+/FlffmXnoErbkU4QKTp+dKHSCFB+MBgfwo0yEVQb03bZWi0I+HP21lS6NB60JvoCNtyFcjh0TIC8mtDC5fsAl5CAmDfnkGCILn4EvZVfjbNBA8vlAeLdVUipJGiVQzBPFbFwWkKAgDBQrOV5QM3FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884923; c=relaxed/simple;
	bh=MjYYIbu4CdOV+Xade2TJCEKI/ve2curOpWtnYnTrocQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8IEsYb06cg1QBSio+QY4HLQVHieApzWF35hAjUTYAP7XM7CfnpRbW7pufriPj1EHBeH1iSrWyMPhqrlRtrHRIcf7cXn0K/hzZR7D2c3dPOtxYP/9kKpEpMeSkomUFB0BjbV37ie45wAlGC3tdlFL9oEtFdWzqUKmKLqRRvYNAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PHxh82ns; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PAo6ZZ006742
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 19:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mGwB7O8RLHd/LeUThaZXaRKs2dFV0KVqPujCZ+uA/K0=; b=PHxh82nsP9TbaQ8r
	LSi8VNT3jg9o+k3BgPz2+Ujlw+aIedX1rnyr6AaGvCsUp/lL4XeYXCpj2ZqB46Ng
	fxEvxuJfWl6SjKSjV2NFua7d+uHn6Q89mAJc85H+17NG3kh4R74p3MSuBoQat0a9
	JhQltUcC8wkbnr5kIaArS/LaQFFSaLJvYXJzmY7aFK5gYnBw2ZLwJJES2WQvbJId
	bhXkY9kqVFPbP1wOEPaD3h7tzCZN0Eu7/i9yMibf6nG1j0soI4MnO5touj9FVjVR
	gB+s6ZW7KOU7dIZssZJmYwnqTnRb3omaLd6kk5WkwTb0oyJnOjSWbQlGnWsAf5IF
	eOShcQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42g9x6hh8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 19:35:20 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbe149b1cfso6755286d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729884920; x=1730489720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGwB7O8RLHd/LeUThaZXaRKs2dFV0KVqPujCZ+uA/K0=;
        b=u3rNEy+CxWcO3Ni+nyVMAsUvYTDkMQ71HVG6tlzbDsQQ76fWWpLtp3R9mmvur7oWeB
         udJtbJksgFUBbs1K42zSqVJi4zHSl7b/KNAOj3nY94Q3MCksQSrjmPLzjILd1lOOYMkf
         7hdPW/4jbrvwZRp6OH/9SFo28HGqgJx9igoL/81eq7Z1MSCPEWd3Yrtd++KY3/I3sTdQ
         cx2Bz0n4uSfvPeSFXPPl7vIXnaz3OHQB2ZXhCS8AToAa+Dpp2tAlAOi5+aMM6sTf/j5W
         OAGg5Hj7L7FF4Dt2TkU0wK2GJu7h0/2GXERR6ihXYz4xo6nEWt3xQtnn1ZRVcXU+YOWJ
         8mow==
X-Forwarded-Encrypted: i=1; AJvYcCXr3PrhcFZoSRBm3t/47IFbawWPMJRy8CQIgbxg9dRS4cuJis8QBQ1Y4wmA9EJdacqE4vntv/eg6UGBC/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YytdvrbCT9FGJwhGbQhrZ41Sdpx6OqFqXrP+DzzXhepD+0V7ymh
	YMsupXCXEo2Xfs3IT3WYCzYSm+XSHYaZuxe9WIonpZHljwJg1IHiNdPeGivHdDQs2Ik/JoTXLtJ
	aQrK0zkeEZZPDMAqQbU6MoUZV8uf4FIPbDpznWl3Oq+/uj3n7ttzp80dfDLPXt7w=
X-Received: by 2002:a05:6214:268a:b0:6cb:e610:f8 with SMTP id 6a1803df08f44-6d1858894f6mr3385206d6.12.1729884919793;
        Fri, 25 Oct 2024 12:35:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/w5yswzs8jxTChYCD+bkYl6ES8YP5c43lh88NwGSKrze6+hX30nsXuDTgvfnONAQuxo3QnQ==
X-Received: by 2002:a05:6214:268a:b0:6cb:e610:f8 with SMTP id 6a1803df08f44-6d1858894f6mr3385016d6.12.1729884919430;
        Fri, 25 Oct 2024 12:35:19 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a084b10sm100517166b.195.2024.10.25.12.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 12:35:19 -0700 (PDT)
Message-ID: <e7752043-29b5-4307-9dc2-45cdf504f0be@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 21:35:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] arm64: dts: qcom: qcs615-ride: Enable UFS node
To: Xin Liu <quic_liuxin@quicinc.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, quic_jiegan@quicinc.com,
        quic_aiquny@quicinc.com, quic_tingweiz@quicinc.com,
        quic_sayalil@quicinc.com
References: <20241017042300.872963-1-quic_liuxin@quicinc.com>
 <20241017042300.872963-5-quic_liuxin@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241017042300.872963-5-quic_liuxin@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: aHh2ywCFwM5NeUtZjn9Nf83LfQE_PaWR
X-Proofpoint-ORIG-GUID: aHh2ywCFwM5NeUtZjn9Nf83LfQE_PaWR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 mlxscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=780 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250150

On 17.10.2024 6:23 AM, Xin Liu wrote:
> From: Sayali Lokhande <quic_sayalil@quicinc.com>	
> 	
> Enable UFS on the Qualcomm QCS615 Ride platform.
> 
> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
> Co-developed-by: Xin Liu <quic_liuxin@quicinc.com>
> Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

