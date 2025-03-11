Return-Path: <linux-kernel+bounces-556552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B312AA5CBA5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF4A27AB922
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF7226280E;
	Tue, 11 Mar 2025 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fr9Y2VbK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C211A2620FB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712733; cv=none; b=o+N/eMQqKUhM6VjOg/ga82Cu117BLDh3tIU906RJaIsT3Lb5GF8sH+M3At1Wc3UFoKdcu8eQZDhB5pZaxSiRxA5oDh6CjltpxrgjeLfQB2DpwXEpStES4Z+mitXtDYldlG6FWf7HgvCWpjqXIpaTGTFGM76sZYpXW0xCKWpVVJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712733; c=relaxed/simple;
	bh=695GR/KZLkHZ1WKu8d8I3wFJq7e0VRh8DjOiryU8o1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4WM/apEud9wGdyAYlqoceTrOCVWWn27XPkPxoS4YgC/peDA8GgQ2aHKWv6D1uaANsm16UCaqTWux2p//5itYafOaljjakR5j6W23rrDpC2+rEvH8f9SL37CQX3Eeq5C0vaBRDlcmKxqCKG4ptjvAUZvXNQLcaZlUjowDFlW0ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fr9Y2VbK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BG2dKa013087
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	695GR/KZLkHZ1WKu8d8I3wFJq7e0VRh8DjOiryU8o1I=; b=Fr9Y2VbKb77uybHC
	SsjKJrzPBcGaari0g6jOfZG9ym0t8sY6Dqvh83l8nq/eF2482GASQmd3zklKQudH
	u7WehTizAFyh9I/RbYG6LgLtlKB5SCa1lNKiXIMMdBAESZ1JwKmpWsd0rsUB4WRT
	vSP0eCnRheAANu6kzK6gvxYn/47JdM/ioIcE9mC3iE9G25z5No4yKhCnt3RHQbrR
	pzDCn/kuBNvf6gLtK8gULvirstcFrX52MzSG5toVSLxJJG/MRJPRUb7jcpdZ0TrR
	ri4JjGtu7dNZ0sZknlLIWi3zaWeKZHb3gC+O7Suh7OulvYjpYGtEwn1GUd24ALeR
	49I/jg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eyuhctm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:05:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-223477ba158so148667215ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741712729; x=1742317529;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=695GR/KZLkHZ1WKu8d8I3wFJq7e0VRh8DjOiryU8o1I=;
        b=iT4vKbe+6Yy0jGYQ5QP1QnDoP3/JtiEOmAzsAvBZlS2RwLUiuCAp40OYBypMc1Yr+j
         q1rBLAlgCKQ3n5f8+lK8f4iFGC+gS2IQ/QZ8sV/3OVzlcbUvXk7t3rgIEP8zp8zJE5yN
         ZCG/LSVPA3h+cijFOufFCQa3AnKhKkoNhu2RCYhv9ce3/rywFMwNKyDeW6qnLmg11JqV
         Ba/t/FWl1NjDhZh/HYFqLP5IifBWoaFNU8vCnljr5yvVztaFI59jfAokfxxBUWmHgaQC
         D5iM/r+JJoaE8DTe257eSrcRGMePbpEDEsw2f3XWn//Q1CtqZaO/4eMy3QkEkK7wCbh3
         E6Bw==
X-Forwarded-Encrypted: i=1; AJvYcCV9JLns46c0NEUFboc5lSNpXCNT9utuWlab+jpT1jYKNn63wkdbYtxOqZCIuwpO/De4OHwbIfJT/Ndpa+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaOJzQbQSXHmFF7P5hNAFTpL7JxMtORLZo1bg0yrtdssx1CzDy
	BilD/HN4wBj4yaEfeJmdIKD1kV8pcPOqZaZRdgYZen4gMV+lv8mChQd7H4BbuV4kvJKcY26X/N+
	SoVv39q7WCR9UzEnem6ODuK1iqAluMN6suT5OaaY9IltwWqWIjl+cPOvD78IhZ8w=
X-Gm-Gg: ASbGncvjGtgsJc1Z97ybNf1AXK4Wg9UqtTnOzu7e6iZJd0/8GxgoJVvTbS9A3yvpdi+
	dom6kzPrw1BRfkaWCV8FxOwEzjaptxESMNcDv+pOOtNg9qXZ411tiqhc26CvlvEVSQ9MWMI85+s
	sTGwR9RYMem5JAha3dQPFhC3NHo3ct4ou3Cku9IbDFcyrAKGVAH6SmRDdH7zJDwhwe8wJSVKAMs
	1kWxwtt/I/XJaoRUqTf2zJf0/wB7H3BvKd9ICyiVKrRqfwRfR7QeaSt0veHvVHNjEJOwRDHOx3p
	o7/Engn2vE21cTAD3c6zhuxMouwTRadHG14OYoiuLd+LLHgI6t0C
X-Received: by 2002:a17:902:ce8f:b0:224:1c41:a4bc with SMTP id d9443c01a7336-224288951edmr291368215ad.12.1741712729218;
        Tue, 11 Mar 2025 10:05:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNmYfTMSW/XGFFejAsebRCu/XXSDKUCbe/u23gMVpwPCacZeb0zlctyyAvyI50SfrBGmgbZg==
X-Received: by 2002:a17:902:ce8f:b0:224:1c41:a4bc with SMTP id d9443c01a7336-224288951edmr291367805ad.12.1741712728800;
        Tue, 11 Mar 2025 10:05:28 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410abb088sm100321875ad.256.2025.03.11.10.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 10:05:28 -0700 (PDT)
Message-ID: <7dc00288-1e12-4524-97e7-a427ee24d984@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 10:05:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/26] clk: mediatek: Add MT8196 apmixedsys clock support
To: Guangjie Song <guangjie.song@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250307032942.10447-1-guangjie.song@mediatek.com>
 <20250307032942.10447-8-guangjie.song@mediatek.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250307032942.10447-8-guangjie.song@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cbIormDM c=1 sm=1 tr=0 ts=67d06d5a cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=xSbqf6NU4cea1KmgExsA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: J1Fw_q3rMUndjPpVOb-EsgJp3Ejgdevk
X-Proofpoint-GUID: J1Fw_q3rMUndjPpVOb-EsgJp3Ejgdevk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=943
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110108

On 3/6/25 19:27, Guangjie Song wrote:
> +module_platform_driver(clk_mt8196_apmixed_drv);
> +MODULE_LICENSE("GPL");

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning with make W=1. Please add a MODULE_DESCRIPTION()
to avoid this warning.

This is a canned review based upon finding a MODULE_LICENSE without a
MODULE_DESCRIPTION.

Note this issue appears in multiple patches in this series, so please
fix all instances.

