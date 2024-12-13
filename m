Return-Path: <linux-kernel+bounces-444796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C409F0CA2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2471889E21
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9317F1DFE23;
	Fri, 13 Dec 2024 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="niipu787"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC981DFE04
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093909; cv=none; b=YumBgGoPc/avUQsJ8cooZQ+AOTz9XeWnii2IyJgzfB37ta339ooLZNogD82Kr5C64286BvSMl/XmEiv94jnaN8iuwbDPvbXHUFpjTNFqTcrwTUhlXTaOgZ4ESaVz0hYrnS7HjgZI114HneuMX8/UujMeNctYbFMPYjz3nlXv/ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093909; c=relaxed/simple;
	bh=JYpFD2JTyAPHJh0LcGmkihjMxrYJLIJGHzffjuy4Oh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flFo3SU9TOjS9y0dgQa0qmOVi95s/yxI66ADxagWniF2xXSD+17cXqgBjabUtzm3CoYECAYvVHv1eN+q0EY5+wgBovvMXLXu2ho6Gm7osx2j+qZRcIJUY76M7nyYLCsraJrouBmDfClQd3Lrc6X48XXd59oEbooklRneBHYxXRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=niipu787; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDABdPW006448
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+py4yuAWBmdgeW1jPtgIlP3H1NVXLVQsrI1tZ7iOqmo=; b=niipu787Rs0b8dCX
	0NQOz72fcxoh6msFFF4aZASD9R/vn6eKHtZU9OmNgmgH53G/UoLz2BfjNGuHZ5Cq
	PL2c8YOumVhZ31YOCMIxeUsDrEAf+ny/8rf30IatXI/oijdsQT8Nlw7bX6WTTHpc
	z+Kfds7klzn+OSscqid69ObgI4nylWOYkmkSlgTv0SZ6LLJAKzo8uBgqG+VexCOn
	dcWFUvJWBBcCK516Md7HACL/ePoU7Q6u+orZw7YJ8EG7CHSRBUVQTOhq5gUT6gWE
	jo/+dhxCsqRCMrpnnm0gl/7oy2as+TyZ1MWTm0c5LRpClYkudCnkv4LhbaqkU7L+
	/3ygMQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f6tffkxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:45:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4678aa83043so4315201cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734093905; x=1734698705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+py4yuAWBmdgeW1jPtgIlP3H1NVXLVQsrI1tZ7iOqmo=;
        b=h9jZTgGd3Y7LjkQwKJ2cxipsaZRovGx/pIMbvXxwPHKXZ2kmJef/GN0IcrsvG6sKpG
         V/BXtSre2kVqSrZzwyZ/sKaAyP0fmrWHHfAC6oKRxW+InxhzHUPcOs78ZpzJ6z4QIEH4
         UZjdzgWqvzO6NxVX+Ibl+TmQO8oQyG9X2sCGVA46WQ+tYAFyFq1j+xjby9LDlEsMLCwT
         DZJHarH3LRw4H0fbSH3L1ZpImIQRls/WkvRjcuhf3RUipSzT/vT7Nq8T+sMRZUEsnAJu
         w5bnA+ZZ7r+i71ZwKnK0YOOt/1ulAqSmi8GKkCd8yOTZidVBsZ9HXSCn3zBp3wnjUwT7
         vnmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX25PtlsVgNOgDfGoc5EjI0HRY4unTKCm1N7G5Guo+71j9/zUbItYUF2LJb6XvwXOC24usrGxg0YWQkpvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEDM8GISghA/I4uDIJWY1YU1m6Yhm0teDkKiNq/LRuKQi90Fcv
	9NN+ewCvO6Ad4kSPIQflISlwxOmFuhZOKy54/6XyjZ55V6oz/+4JQrhSXUpIWmHsOAFUHKoPuci
	DBJHD+dvsOCfJK87NjO19Aek9UmrNqQbchWE46rYdJ5Zth7mk0Jqz/Ji/z96/3hQ=
X-Gm-Gg: ASbGncvWrrSgd4XE2fo4iIVwroycBUzzsTjgYp0QcGW5pmS8EvQinPEc9nSJ+BMmZK5
	IBl4NfcuckCTXe4xryL/Z8oZnyl9de5TowxzMrtsEXDfveJrRi0JvHnPWEVegzjng3qyqJfguwk
	T/cJtz19dZkNUKPtVCtmHX7+Iqi+y+U4wwF+O+x3EojJsLFOcx9upEheK2O48CfUdWJxpoq0G3Q
	E2EUJk+6clvF1XgiO0sJUu9X+3igLyZbbLB8ymhF0uKXbzzBBHuHGlgy2mXvJBTyrcMfxs7TW6M
	bdcWzedyKoKOjeCUzjDSRxLZ4OgGrbA5fzA4
X-Received: by 2002:ac8:5dd4:0:b0:464:af83:ba34 with SMTP id d75a77b69052e-467a580084dmr15701021cf.10.1734093905508;
        Fri, 13 Dec 2024 04:45:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWpBo8jDKAUGFcsAt5h3utlrt4X9Lyu++J7Nctz8IrQCa+saJdAY2YnvB6PCnanR2c4n+x3Q==
X-Received: by 2002:ac8:5dd4:0:b0:464:af83:ba34 with SMTP id d75a77b69052e-467a580084dmr15700481cf.10.1734093904269;
        Fri, 13 Dec 2024 04:45:04 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa699487854sm592175166b.13.2024.12.13.04.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 04:45:03 -0800 (PST)
Message-ID: <3d54859a-0f10-4e67-a05d-be5546a949f0@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 13:45:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sdm845-xiaomi-beryllium-common:
 add touchscreen related nodes
To: Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Joel Selvaraj <foss@joelselvaraj.com>
References: <20241208-pocof1-touchscreen-support-v2-0-5a6e7739ef45@joelselvaraj.com>
 <20241208-pocof1-touchscreen-support-v2-2-5a6e7739ef45@joelselvaraj.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241208-pocof1-touchscreen-support-v2-2-5a6e7739ef45@joelselvaraj.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HvJJSY94o3XGd7hBtszb07Qf3yQR8x_d
X-Proofpoint-ORIG-GUID: HvJJSY94o3XGd7hBtszb07Qf3yQR8x_d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=772 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130089

On 8.12.2024 4:23 PM, Joel Selvaraj wrote:
> From: Joel Selvaraj <joelselvaraj.oss@gmail.com>
> 
> Enable qupv3_id_1 and gpi_dma1 as they are required for configuring
> touchscreen. Also add pinctrl configurations needed for touchscreen.
> These are common for both the tianma and ebbg touchscreen variant.
> In the subsequent patches, we will enable support for the Novatek NT36672a
> touchscreen and FocalTech FT8719 touchscreen that are used in the Poco F1
> Tianma and EBBG panel variant respectively. This is done in preparation
> for that.
> 
> Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

