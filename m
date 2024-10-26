Return-Path: <linux-kernel+bounces-383056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525679B16D2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A012AB2190F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC6F1D1E91;
	Sat, 26 Oct 2024 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iRvFE9Sy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9781B21B1
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729937134; cv=none; b=goFbW5VotE2NkDUWydNcZPRYNZYHh7s1U/xds9uncqZfIjw5H5x0QH9bmfA1/B+lwh5F89nY2gFmi5aBGG0WTODACKPrupY/+lTqY4ara8hcjtPch2HzLhOwKWrRhjNIMlDm9yl0QHMT0FCJE4E1d/ddHniGrHif93ypfW69WAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729937134; c=relaxed/simple;
	bh=JRDq1eouqRQ6dVU3EFp5yS+KoReTI1aJZRgZao2+yYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CitBDJSTI1UIDPPo7FPqohlUloFUAPBfMRnUfg333RmUBSKa2w0XxHKBGfN23qBYKNkdG7POb85zbeDyHRAFvLTk6Yg5Bm9z+uopRqe+xxq463g3F86R9NW0GwoL7EJraSQGkmqq8PxxbNezcDi2ERU4GLoCX4tV1pA6sJizmQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iRvFE9Sy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q4qqwv013037
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HmnLmB7Z58PVjAcP88scYZXyrOOFTxtAMnjFZSQFAfc=; b=iRvFE9Syyhxp53Jb
	uovXq/qGC49O65tQ43cSVpkm/EfgNtQ0tfzcLevyK9sngwYGzi6oh8x1R+ze27eD
	ADUSEq893IjDyMM3u5q6zd340pDoBU6pYzTvvC9wesEj/DYVpe/0QITVDf/6tt84
	aqFU95EQiTPdYem566SoGf/YZyqY7MvTZ0GeOZl0eBOazQKemKcOO6OYYL68io6S
	z3x5ZcwqE2nVHglNlMCssFQ8TOqaOh/Uszl4qrtDZlzv4MxwX2VheSVBEtAT8m3f
	Zs2uc1B6/+NqNBTF8P1uyFfLA9L6+XHYhuFUSBGsirAbuDaE/gCuVEKFw62gja8L
	96h+4A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grn4rpkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:05:25 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbf4770c18so8663566d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 03:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729937125; x=1730541925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmnLmB7Z58PVjAcP88scYZXyrOOFTxtAMnjFZSQFAfc=;
        b=KX9fMhydFTWtF6WV8EDHaj41KAQ5vpyY+4oyJYtIWMj/2GTGH31gDguAUEngHmLxTv
         URiJuE4fnH8c6xQW1GQjt2Jwf3g8vOak7qsvtAYgFoJ84/3tGMTUuTn0aDymTfkMloCY
         tnCeQxz6CLpB9/Hg2qQU4ZJLdGHO2NuceoklPkTdvzREUO4a+z6OsQwLDGJUtTZMf99J
         wR30lZjKpLj2qBMaER6iRHocnjJXR+YXdrGSOtoWXZGCJ77T+v/EPStdQn0JNo40ZPG1
         x6rY4/kD5hIPQ5m4M4I7lDIbHBaWYPyuxSst0mJAMornYNbrhTdJZcmgdXIRnXiUVgBB
         qhcw==
X-Forwarded-Encrypted: i=1; AJvYcCU9DwlcEhiEBuHdD6JUMeT921vqzXfsSym++l3zBz9R245Ov0cGN9n8dwBbas9WyORk773WyMckArPoeVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeE/YCIGnvZHP4e7GaNFtuIe6y4MYD5KP1/s/y7G4EutJK7mTF
	vSH1Xi53HrdXpbdtZVcQvnFubktkWwtdcWkOXl9Mr6uvIlefIj34QHpFKbkVtKpH6r5tU3kyQjG
	5UP6z09VxGvroWGC+9ueSDGrVGytKfh651xVr5A04oWLu6NKwwqWG7Xk1PU5MuQs=
X-Received: by 2002:a05:6214:19c1:b0:6cb:e7e8:9e88 with SMTP id 6a1803df08f44-6d185885e9fmr16414496d6.10.1729937124663;
        Sat, 26 Oct 2024 03:05:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEapbGj3Sfdlc6h7mBBc6DRy9QbRrJtdmLohS8bgyDq5d6FfQeVz9TdD9OYLquQ7Ttuo89WlA==
X-Received: by 2002:a05:6214:19c1:b0:6cb:e7e8:9e88 with SMTP id 6a1803df08f44-6d185885e9fmr16414176d6.10.1729937124194;
        Sat, 26 Oct 2024 03:05:24 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b307b5375sm158967966b.155.2024.10.26.03.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 03:05:23 -0700 (PDT)
Message-ID: <ca0137a6-3ffa-46ad-a970-7420520f09ae@oss.qualcomm.com>
Date: Sat, 26 Oct 2024 12:05:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/7] arm64: dts: qcom: ipq9574: Add nsscc node
To: kernel test robot <lkp@intel.com>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, geert+renesas@glider.be,
        dmitry.baryshkov@linaro.org, angelogioacchino.delregno@collabora.com,
        neil.armstrong@linaro.org, arnd@arndb.de, nfraprado@collabora.com,
        quic_anusha@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, quic_srichara@quicinc.com,
        quic_varada@quicinc.com
References: <20241025035520.1841792-7-quic_mmanikan@quicinc.com>
 <202410260742.a9vvkaEz-lkp@intel.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <202410260742.a9vvkaEz-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UP0AB4znYEU6Q6D8NYXn6zHCfge6MeGy
X-Proofpoint-ORIG-GUID: UP0AB4znYEU6Q6D8NYXn6zHCfge6MeGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410260084

On 26.10.2024 1:31 AM, kernel test robot wrote:
> Hi Manikanta,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on clk/clk-next]
> [also build test ERROR on robh/for-next arm64/for-next/core linus/master v6.12-rc4 next-20241025]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Manikanta-Mylavarapu/clk-qcom-clk-alpha-pll-Add-NSS-HUAYRA-ALPHA-PLL-support-for-ipq9574/20241025-121244
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> patch link:    https://lore.kernel.org/r/20241025035520.1841792-7-quic_mmanikan%40quicinc.com
> patch subject: [PATCH v8 6/7] arm64: dts: qcom: ipq9574: Add nsscc node
> config: arm64-randconfig-001-20241026 (https://download.01.org/0day-ci/archive/20241026/202410260742.a9vvkaEz-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241026/202410260742.a9vvkaEz-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410260742.a9vvkaEz-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> Error: arch/arm64/boot/dts/qcom/ipq9574.dtsi:766.16-17 syntax error
>    FATAL ERROR: Unable to parse input tree

I believe you also need to include <dt-bindings/clock/qcom,ipq-cmn-pll.h>

Konrad

