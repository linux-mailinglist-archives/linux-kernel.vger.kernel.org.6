Return-Path: <linux-kernel+bounces-531472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D21A440E8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35CF189C92A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AEA269891;
	Tue, 25 Feb 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WtvwuQgZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5AD268FF8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490249; cv=none; b=FnsIgxt4UUajpnA4ZC4POBAKCNdWo2vjfY7S+wYyfgoJWd/ELfS3Uyxg3DQ0ok0lYldhZfKYzpzl1tNbQ2KSmqoW3LPpxPPzaaBZU0H/Dg110xJ7+j4jTvsHEhxvlXdqdKa/kEY4zUGl+XiSsI5fo8fCyEzoxw63OsH91nTMB+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490249; c=relaxed/simple;
	bh=wuAI4vGUijPnTtk+36Nugk8Q7ab8WJXds5NIWN/WtzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mN0Rxwwpa2YlYC8gcXx9Wocl1pH7Myoe1J28vbhNtC3abN/6HTLxIUU2AKiyecN4iEtHaUwH+NAXMtJ70AGgauo4E1WndXJPZmC5p4WS5OiHp5D9XXbkdSPJN/48l4C0bSndH+uyQ7jKTTJzeba81pg11bwcNV1jAqEHKZI92TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WtvwuQgZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PAUp3T030657
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bc2n7N6LrsSsfLdU3/CSzOVYKaVednS4e8P74t418mI=; b=WtvwuQgZGtD64t41
	mgEe4Tqxw7EW+UyAISwxO0LXyEOLQG5xtf+9F6+xkYBeY6idvcooff0a3abOENmt
	deyGZ+hdIInNWPx8bljVYuJnRx+kk6nn504F2cYtB48X60cxeo4XMOtZLA+Ttm1I
	R6JaLz84dpH4ANeZzgOdr4JSpWNQZj7XSsuJuQaFoavAQWx1przf6Er+h4v8Q5wK
	Sre9sEx0JwQN4t2S0Hmi1WgsvOOu/w+os5RYn0ZIoFz05jCJ5s54odgy1gN6uXXD
	UH2PkyYp0BiVCXwrpRIdxm2oOWqUhh0nuZMpmR5Xj0v78O6oTEm+sLeTNJ3pXu0p
	S76wjQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 450kqg566f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:30:46 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e66e017ea4so7154256d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740490245; x=1741095045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bc2n7N6LrsSsfLdU3/CSzOVYKaVednS4e8P74t418mI=;
        b=U5FNUJN9+Fg4ZrpPGQDfiWiEJWHNBsIhgSsNrYaxvHRrCmdobF5+i64x/LBDZxxnw4
         ZVHANamGXpcFCF2UqT+FQGzARyguw9e2MhmSFf0nnZcUIxWfH+/kTf4Z45eVLmiKQAUG
         wnxCP1BnZyR8a3ejvHce95biqvwIWGImuB0rvj7aI8eUWNLXiMsfLnAiUuZdIPtcOi9O
         6rzTrslVMFUPnw2wyI8Fpjij48Gw3HM416OD0iNWd9W4UjPUhJ0sUPnmlm9xMUoGPkvs
         94GAaEHKaX4XQxIxi6hh+g3PTy+sN7bAcFAbcZOHd+zoVu3qrWqm8KsHLhEVJoBYutHK
         w28A==
X-Forwarded-Encrypted: i=1; AJvYcCVMsdERYbha1kNxyEgL2hiFsRMIRerkor7WSMI89hnUNoC858xm2usa1t1nRWmm/PpC3mAXcrm2+6SoMP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs/+2aYeRsgdNQXn/KXIGSmw6Xuj4fMGI9tR9onoHa6Cw/34ot
	B/IDGctv8FbQ2iNZZ0+j+6adOkMIDOJc+i7Y8upXOTstSoROurkmy4EDTeahZpuLVAuMoNSRXji
	YdwiU6uMgnW/8b83xbsfQOxWIcwnRCLLeOiqs6QaUBJ/BbRnIQtAv6mNg4GLVSaM=
X-Gm-Gg: ASbGncvWNyLa20SSsnvS/FcJ0p8+cKRmH0cwwa1XmsJlab2xqQDMe0U0/BGarebTo6+
	uzjF2sLIZEr6IDXQC3EbnyPGE2gK1igoaXY4nfhNqrR5HStw7iwOsNIrDk1uIYDIUzfs3TxswWU
	j3m4z7PCKF6GLjTYOer2Gxm0+XL/DJl5BXLiOdNDmB/zVIwbHZFC9lfibq1qcGAedCbPpz9bjeV
	xrd4P3ynq2h3KAB2ukXK2WE06dp0kFz2Odm5BzQ11Mvsy1OIwtj8K39P8+InDHxFooPmaJhv4x4
	9znu8dhUI3EwhygOCa7VLjdHDBpEK7sq80moNA36hU9vh6NhEgVL1uTC/nGUosJJHOqcwQ==
X-Received: by 2002:a05:6214:c4b:b0:6e4:3caf:c9aa with SMTP id 6a1803df08f44-6e6ae80129amr87622526d6.3.1740490244850;
        Tue, 25 Feb 2025 05:30:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlvs30Bcej2ehUoX5uYBPU/0u/U41vnUBagzU9ehas+iea8IpGY9brXOMrEMFxTREYhyjkBg==
X-Received: by 2002:a05:6214:c4b:b0:6e4:3caf:c9aa with SMTP id 6a1803df08f44-6e6ae80129amr87621916d6.3.1740490243814;
        Tue, 25 Feb 2025 05:30:43 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2054d7esm141970366b.136.2025.02.25.05.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 05:30:43 -0800 (PST)
Message-ID: <b81fb350-f680-4e50-8cab-89c93f733bfc@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 14:30:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sm8650: add OSM L3 node
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250211-topic-sm8650-ddr-bw-scaling-v2-0-a0c950540e68@linaro.org>
 <20250211-topic-sm8650-ddr-bw-scaling-v2-1-a0c950540e68@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250211-topic-sm8650-ddr-bw-scaling-v2-1-a0c950540e68@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cO6-lUWWGXElNAjD4c6R7wK4iilQ-Myy
X-Proofpoint-ORIG-GUID: cO6-lUWWGXElNAjD4c6R7wK4iilQ-Myy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 spamscore=0 clxscore=1015 mlxlogscore=793
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250092

On 11.02.2025 1:56 PM, Neil Armstrong wrote:
> Add the OSC L3 Cache controller node.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

