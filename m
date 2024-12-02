Return-Path: <linux-kernel+bounces-427759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88DE9E059A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 836E5B4238D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D6D209F26;
	Mon,  2 Dec 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fg0Lbud1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052B4204F6D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150069; cv=none; b=dcnU8yt6TyxJAIIP8LX+89lVE3Vz2Zg7fy3YqK1Twk1mkbwiRspwGfOnZCuON5rNbQowfdCyCz+OqPJcoWyP115byEv30UxPukAwzvfiwrDtmiSvoNzGV5UZu4ZQ9Nf5VIPH0xUtMpYgeTHkYg0C/fXpVgn+cCFCLCXaCAc6usQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150069; c=relaxed/simple;
	bh=W32B34bbwL9JbtycBuovG4MawYuqGMzUQhFPk3Po0Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZvk9lXyf9V9RnSDmIavbOhB1SLI0Hk5d7sOeCNPpGrLfOhTg0m6YM11pqnsBYVEd5ATNYSxKggqM/7iYywzRCuJeLcdDxQh/sRB6AxSDr8l56fZFatxFVu0K+ZoitJ6rAIkHTM4sUEnsjMlNoOahSPnqOG6hfGsZ2408cz0Go8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fg0Lbud1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2A29hl011392
	for <linux-kernel@vger.kernel.org>; Mon, 2 Dec 2024 14:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	80/5sgkMsINlYr/kXPQp6J8zNYaokD4TB0hvENF9JR4=; b=Fg0Lbud1/BEDue7B
	gB+H1MLQnjL8IbCgVI21PYWkyWnH2LsMaEaICvbP+kEm0+JfYx2v9gErZUBFyRoK
	JZc6ZbHD3ypvfFJsCoVVoSWtBJZXYK/QjW3+W6W8jcHLWd4ORmDui/nV/fK8wj74
	qGJzzLFkJQL0w053rS6EoVUk1UYiqOfnm9w4I/vCHaPkFX0qg10bPk8XbdRHnXvm
	ms8j1QDk2vvuNT6C8cljGAjZ3Cz56YqdqIB9vA3oCyPVKWVOiBuaatvPNpl8h6iR
	W6E2LaLFXywqNzD33+XmG/nveykanu6tEU3vYI+H75VIwgJrqm0AW42w5X8HUyzb
	2mhYow==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4393mpa0ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 14:34:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4668f2d0e50so6415011cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:34:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733150066; x=1733754866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80/5sgkMsINlYr/kXPQp6J8zNYaokD4TB0hvENF9JR4=;
        b=v0jVyQK4MFAbPeRtx0qx/ZYPhWdfp2J3syIMIrxZOfMwEemLUSvMbiRLUHytGv8MoO
         X2cgSt/kwiX106pH395MVL0M9Hg3tQnnI0bxO/0AWxqn0Pd0FKw59Ud2DyibTLgzsJ/z
         MryzMfH4SZPKLVlArNti2z8MM2ugOSCPmQjQF5H1elAybIL+FaIRFh1kbF1iq2gQf6Mx
         Hk3kTmZ7mkd5HBz19SBh7UBrhzZmiLGPIRXhK8N5ZicWKjKIpWdql/cHF37SR2jTYyFf
         j9OrRkn0d60SrPCd0XxY5/+zr+RT6+6H2UMoLbt9Fex3L19PGAiwhxFw6ijHOISSHkph
         WIEw==
X-Forwarded-Encrypted: i=1; AJvYcCV1e955Nlrodz4GVhLUHHYZ0ZiaEMQm8TMestk6MIhKBk9uE/t/IBFd3C4c8jk1d0jfsODSHq1vxqOCY20=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi0ZUZp+B6QtEPQymG/OW67veZrqKkFcG4jiG5sphXRTkPaP7D
	fO4lmdZVDYeOZiCkOoRnrKxsWYPepH8TbUcHeEFR/VXj1v9RH43Tb5RD132T9Yk0yRfj/u3aTtQ
	Km4JGxYRK0G+LH4cJIpmkHBLzZPZwKDAFNGJOE1nHA91AvCYJKPj6dt/0i15TxRENRnuXHtY=
X-Gm-Gg: ASbGnctrfE+iZ8Aj7uKD3bbucNRyDLxKa+1TvZ/M7KuKBYBxPpQitcf2E6DZvr3TyTM
	vwlM+Y7wB05FuVYhU4/E8X3FGRikzccL1WkHVggnurrqCHPVCqLHzKaQeBJBapyWvUbwQsg2hok
	0bEifjQc9EILBSOPcFPgxq7+zi+rlicPCZANOpE31yiOZ4wcTSB+sOw18yCpyOH2QBO/H76Prgj
	50wP1MM9I44WI1WJgxlayS2IVxdmzMtrD1ReuFFit39W1Reovibpe68VG1gKGwxTVxKAJPMsfrp
	z1LwoURXx1fGWjiS3sGKKCBbY0LtJwc=
X-Received: by 2002:a05:622a:5cf:b0:463:16ee:bd7 with SMTP id d75a77b69052e-466b357ee1amr140651761cf.9.1733150065756;
        Mon, 02 Dec 2024 06:34:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENRJvQcWCDQ4WzAAHZoOdr8etB/4bHLv5UFvCLr0Y2e9/702b7mvH2WM36qkWsenLYrX5Mbw==
X-Received: by 2002:a05:622a:5cf:b0:463:16ee:bd7 with SMTP id d75a77b69052e-466b357ee1amr140651581cf.9.1733150065359;
        Mon, 02 Dec 2024 06:34:25 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996d8bbesm516662166b.43.2024.12.02.06.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 06:34:24 -0800 (PST)
Message-ID: <a7ed4962-9355-4751-8936-b8cb9d5bf2d2@oss.qualcomm.com>
Date: Mon, 2 Dec 2024 15:34:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcm2290: Add uart3 node
To: Wojciech Slenska <wojciech.slenska@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241112124651.215537-1-wojciech.slenska@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241112124651.215537-1-wojciech.slenska@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8V7czkcfqtTRrIpS-5Vk6BCcJQj19wcq
X-Proofpoint-GUID: 8V7czkcfqtTRrIpS-5Vk6BCcJQj19wcq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=733
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020125

On 12.11.2024 1:46 PM, Wojciech Slenska wrote:
> Add node to support uart3.
> 
> Signed-off-by: Wojciech Slenska <wojciech.slenska@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

