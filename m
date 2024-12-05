Return-Path: <linux-kernel+bounces-433682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD989E5B9B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89D1166608
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B1121D5B4;
	Thu,  5 Dec 2024 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ix/GHlMD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B723192B63
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416823; cv=none; b=rsl0m98ZAyqg7Tj3ktVw+A7fjVl7SozIzwfq2fWNOL+U9I19UWyv0wcTJ8LB0k4MCeDxg2v0IsZPb3/dSt2aN+x/m4+42GdrQzzdgfJn8CIVek9f8h5OkRMZ6TxopZiJi19YYBw+moECb97uDCQXcU0Km3KV/a8cfTC/oHLNM3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416823; c=relaxed/simple;
	bh=O/rZrRQu475vd7ZMflZJoDlOQhu1aGuLBhIqoLYN0sI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BASXNL93G0jMaOhhNVfBniJJXmD3SqGNZUXDbj41KMRkXxKdexmIDlSyVWgZ8Lszuw42u2ZymmLzpyM8qnNEn57/QDp5ZPavcrvjbO+mvdZrLJV9ym80gS1wlYcx4FSpBE6ynzLz3CV/zEA1Oyg5dgl3mKHD0Eu9FWvIokM2/x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ix/GHlMD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5ABJ1P031664
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 16:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aLw29Pi7z7qUWfxhLPSPGB8n/z1YvzoWA9mAxcNsR00=; b=Ix/GHlMDJO3GphmL
	0kssS+ysRF1FXwcUqysgaOG59L1dsLB+SnhVEesECmxDmsngOXD/aqlEcjpo9h8J
	608+KDEiyX0yqmbUi7mjbEgLN/WOAJJy+Q8LfRXnE5h1iGTMqsVQ4rFpmmZnXtB6
	n/wKN4wWpiG1offZU8IaAKTTN+oJ5I6NGSpppjUq6c/B8/J8HsU6+eW2JQV45yZ0
	AF8RWTPw0bOEc6sI2kev7EeteMfL0j8cwtwekdYc1tj3Gta0fQvYhCYy0TV/uh7M
	wJumsAvk+3VTA01InyV6dk8XUWzm5IdRmzzgUTFV8pxz0VuDQczWrZHUUFiWYYjt
	e2gWJg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ayemankp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:40:21 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8a3cb9dbfso2840466d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733416820; x=1734021620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLw29Pi7z7qUWfxhLPSPGB8n/z1YvzoWA9mAxcNsR00=;
        b=jjhD0Y1Cx++Ktyoo9OeGhxoL3SGeqBdetKNVPOdXp39aQyPx0IIy76fc6vpG/rKnUU
         XbhtYg1AnxNcmGdIy6CJyWwHiQ0osAhk/9MPHs8VKuQ7NPKL9xQmZ6Lq8xqmQixNFzZR
         Wv8RIJc/XYrkwNBhx4jcEaenfnqzwlxmvJPtrtcunZ/0svqk0HxRUTd5WxmPOil9V8Vi
         NvY/9eV3jeE1SBhB4PBNArdzwyU93E5HQ0USFfHp4/WLG4QW47lzaPtRqAmDucqiciJv
         BsOq2ywM102xWk0lJXanWANIXrOptTPSzqbpVb75+P5R7e9uPz4xUbcDqmEI8yfxWpaS
         vh6A==
X-Forwarded-Encrypted: i=1; AJvYcCWM9tONfw65L2mX8KeMsUzmPVgnFk6wKSdprbNlGVlaRY8DEwYExvvTBZ8LeiOjadcU8RXNsGCO5E8Ui24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaqcbf73JM9tYmIp7/J2yDinUJLouOLtaKgiDwYcHaOOqn8QP4
	CSCQoApff460PolD+nSg+1vJV8dA0Akhmy5J5knUod3I+eyOxPeHUXTDxBfE8zdriyUs4updNl/
	4glf65kH3ATqocV/3UKNNd5FD4OgAZ+R1lBnlcQrPp1LfElbC+X6uT+3CUXM9ThU=
X-Gm-Gg: ASbGnct4aTLb3GewMYDz0xItdIfaxyM2fI5VSEToPq/SdU1yYmoNplVJI29C1FtRXkJ
	7uI6uFcn60iF9/xmtm7wlWO9d6VtUNpvbIwtlAlz3HAgpKay05bMEROBtsP5gG/u91hn390sfDJ
	Grz09suW4KjJWmdHFRdWIMFc6R97S5MZWQ2yxWEhLT5yanZHkYyS8maF+bXhAYPapqxTGRoroxh
	B9i0MB/qZCVkdRwd6FCldChUmNGd99aXCxSIcKm2hehikN1H89dMuLtD85CJOuswlIbNZyWmzvn
	6MtTTga0gPFJ61cMyokY/b53+PtF1bo=
X-Received: by 2002:ad4:576c:0:b0:6d8:a67e:b2ff with SMTP id 6a1803df08f44-6d8bb81ffdamr62000376d6.8.1733416819935;
        Thu, 05 Dec 2024 08:40:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQx8n0UgIEsXZ8s+AlTdnCo2VrzHdMoxFqa+DhiPMk0FP4LFAb01Hav3JtSk0XoXhGnAOfHA==
X-Received: by 2002:ad4:576c:0:b0:6d8:a67e:b2ff with SMTP id 6a1803df08f44-6d8bb81ffdamr62000196d6.8.1733416819528;
        Thu, 05 Dec 2024 08:40:19 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4db6csm114422066b.39.2024.12.05.08.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 08:40:18 -0800 (PST)
Message-ID: <710aa948-d27f-49f6-a4a8-73f6208502c3@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 17:40:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] phy: qcom: Introduce PCIe UNIPHY 28LP driver
To: Varadarajan Narayanan <quic_varada@quicinc.com>, lpieralisi@kernel.org,
        kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
        bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, p.zabel@pengutronix.de,
        quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20241204113329.3195627-1-quic_varada@quicinc.com>
 <20241204113329.3195627-3-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241204113329.3195627-3-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 49cBHjS-TPfY6mj8WTb_71kaohBzuEpY
X-Proofpoint-ORIG-GUID: 49cBHjS-TPfY6mj8WTb_71kaohBzuEpY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050121

On 4.12.2024 12:33 PM, Varadarajan Narayanan wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Add Qualcomm PCIe UNIPHY 28LP driver support present
> in Qualcomm IPQ5332 SoC and the phy init sequence.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

[...]

> +struct qcom_uniphy_pcie_regs {
> +	unsigned int offset;
> +	unsigned int val;

u32

> +};
> +
> +struct qcom_uniphy_pcie_data {
> +	int lanes;
> +	/* 2nd lane offset */
> +	int lane_offset;

'lanes', 'lane_offset' and '2nd lane' together imply one of:

- there can be more lines, all at an equal offset
- there can only ever be two lines

Please specify which one is the case

> +	unsigned int phy_type;
> +	const struct qcom_uniphy_pcie_regs *init_seq;
> +	unsigned int init_seq_num;
> +	unsigned int pipe_clk_rate;
> +};
> +
> +struct qcom_uniphy_pcie {
> +	struct phy phy;
> +	struct device *dev;
> +	const struct qcom_uniphy_pcie_data *data;
> +	struct clk_bulk_data *clks;
> +	int num_clks;
> +	struct reset_control *resets;
> +	void __iomem *base;
> +};
> +
> +#define	phy_to_dw_phy(x)	container_of((x), struct qca_uni_pcie_phy, phy)

A space after #define, please

> +
> +static const struct qcom_uniphy_pcie_regs ipq5332_regs[] = {
> +	{
> +		.offset = PHY_CFG_PLLCFG,
> +		.val = 0x30,
> +	}, {
> +		.offset = PHY_CFG_EIOS_DTCT_REG,
> +		.val = 0x53ef,
> +	}, {
> +		.offset = PHY_CFG_GEN3_ALIGN_HOLDOFF_TIME,
> +		.val = 0xCf,

mixed case hex.. please make it lowercase

> +	},
> +};
> +
> +static const struct qcom_uniphy_pcie_data ipq5332_x1_data = {
> +	.lanes		= 1,
> +	.phy_type	= PHY_TYPE_PCIE_GEN3,
> +	.init_seq	= ipq5332_regs,
> +	.init_seq_num	= ARRAY_SIZE(ipq5332_regs),
> +	.pipe_clk_rate	= 250000000,
> +};
> +
> +static const struct qcom_uniphy_pcie_data ipq5332_x2_data = {
> +	.lanes		= 2,
> +	.lane_offset	= 0x800,
> +	.phy_type	= PHY_TYPE_PCIE_GEN3,
> +	.init_seq	= ipq5332_regs,
> +	.init_seq_num	= ARRAY_SIZE(ipq5332_regs),
> +	.pipe_clk_rate	= 250000000,
> +};

Are there going to be more UNIPHY-equipped SoCs?


> +
> +static void qcom_uniphy_pcie_init(struct qcom_uniphy_pcie *phy)
> +{
> +	const struct qcom_uniphy_pcie_data *data = phy->data;
> +	const struct qcom_uniphy_pcie_regs *init_seq;
> +	void __iomem *base = phy->base;
> +	int lane, i;
> +
> +	for (lane = 0; lane != data->lanes; lane++) {

while effectively the same, < would be less eyebrow-raising

> +		init_seq = data->init_seq;
> +
> +		for (i = 0; i < data->init_seq_num; i++, init_seq++)
> +			writel(init_seq->val, base + init_seq->offset);

writel(init_seq[i].val, ...)

> +
> +		base += data->lane_offset;
> +	}
> +}
> +
> +static int qcom_uniphy_pcie_power_off(struct phy *x)
> +{
> +	struct qcom_uniphy_pcie *phy = phy_get_drvdata(x);
> +
> +	clk_bulk_disable_unprepare(phy->num_clks, phy->clks);
> +
> +	reset_control_assert(phy->resets);

This can fail, return it instead of zero

[...]

> +MODULE_LICENSE("Dual BSD/GPL");

I think this is too vague, there are many BSD variants

Konrad

