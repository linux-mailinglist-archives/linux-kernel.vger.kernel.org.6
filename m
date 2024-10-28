Return-Path: <linux-kernel+bounces-385018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F0B9B3171
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A42C1C2174B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C951D63E0;
	Mon, 28 Oct 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HVfRUUaA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2F61D1F7E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121328; cv=none; b=UNN1wSATvAPEwrPROid72LH9OoLgLywtyx8lEpu7lhjA0sbSbrH/yOCfdsdUt/E7StzoZ8v7ZhJHTQnAHpUqEWnoCZDQLHkdOcC0Wkp4JjhVxfsDOc6bZGYlakKjhu+w6km53f5FNFY3O2kwyZ9nU93ma7yF9Wfm2Tg7UMyqesM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121328; c=relaxed/simple;
	bh=8BuMB1TKcWI/20zu7NxoUkK4rhT8314UTgNtlaGx6fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pv4qYwzk9cGi4G/XtiBBFr5h3+sJzLhGK+FAjC6RKeH+vh4Rc6rfp6IKr7k6XxcY/NwBKdxAA6Iupg0+UYRycWXmll4YdoJbCOEflBujZ3op6wYp/oVGszqjiMBGTZRjhU6w7EAChVdZS+UYQ7N5d2inIK6Sb3KK7bKHuAVlLmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HVfRUUaA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SBV20K028094
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ifb8zjw3v2iBatpJle5WTa1xRKVueOsAKKz6U+K/pxM=; b=HVfRUUaAZtUyPMO8
	SzlObd9QDGRiCSNY2fFnql7Fyr1JGIrg3jPWV+S/Nx/lPG7oZWwVX/KV8yz94UvR
	U0/9g2BXiRkIK20UZlcG1TzTmSy8oCG5OPUeM9dBfZJZbZwbGFytvVZMxfSdByKV
	2VUgezFZB/wOJtAkfbZsF8VSjNA1nV3uXpe2/pXThSFCBbbSHsTXEiVjMuZ9yXRq
	YqJIMd6xxM8VdEyFNTHSWEB+tEvN4GqTto7b1CZvPM+Hgk2/FH2Q50AEbsCdxlO/
	TniQdOc4wdn+YHtRJaXoyoNR9nsJxj6r/WEimklmD819146srIXBcqJUPMop/+qa
	6BvhWA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grt6vxjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:15:25 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cb9afcecb9so15266406d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730121325; x=1730726125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifb8zjw3v2iBatpJle5WTa1xRKVueOsAKKz6U+K/pxM=;
        b=bsS5yDKvtEiiY++1wUb61LW5lX4ZpWTqXA5RrOPiESRdcg3CzYYG72ugcP/7zbGMAt
         ts7LBr9uo+08xh3I4msRmm+2G6K3LGoIBEXZO5CU8IxEsHOZoCq8XHQOLeuHcHaPLqYL
         UP+hmsz4W8OTDasZb1bqZLYOiMuWs4x1UgbuK93/TtF+8e1Xi1Hq+HcVuIv6eipnEhMg
         5lNz8H+DMJfmZBjk4uj9Wf70Zul3rQ9aJ+RrzJoclxrvdcuRUTYkLJsy8XotRdIAiIrk
         e5YIjjhevIO7otyPQE+mQ19yNn7xjJl1WsT+xtIJifi/D0MFbMatkDu2d6hy55WaHZl4
         P5ew==
X-Forwarded-Encrypted: i=1; AJvYcCV47MXLVcc8zALK+y1P8ZM648KANnmjnWEIfTkbRjIV4ZM+Hg781sOwsmmRTKa01NWlkfLZs3F/+GCHp1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjVSPuq4USgBksQ44hzasiG691t0AtvCMxIQ7VQ2hXIkk/kZ2l
	KqY+V5A2EAm9KMNsfbu4zo0eLY8Jxc4sIYch3JLGTo8fBVdCgnqIJUKxpWLmICrkPMmc4/q8eEH
	vGLFJtGh4Jht3Hx2d/c06dGYE3ll3f6U+8ztTInqrtuw+QIkGNch9wCmLHrgGRvs=
X-Received: by 2002:a05:6214:234d:b0:6c5:3338:2503 with SMTP id 6a1803df08f44-6d1858886d8mr66301926d6.11.1730121324811;
        Mon, 28 Oct 2024 06:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPp3HhrkQM++wgb9tbT0Thc9Kg53phrLc+8j4bVo16zKwnqWsHZentYg3L81uv1ieo8RIaGA==
X-Received: by 2002:a05:6214:234d:b0:6c5:3338:2503 with SMTP id 6a1803df08f44-6d1858886d8mr66301566d6.11.1730121324269;
        Mon, 28 Oct 2024 06:15:24 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f296c66sm375804566b.109.2024.10.28.06.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 06:15:23 -0700 (PDT)
Message-ID: <0b5d01b6-988c-4d3c-b4dd-ee0afc288166@oss.qualcomm.com>
Date: Mon, 28 Oct 2024 14:15:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Force NVME_QUIRK_SIMPLE_SUSPEND on Qualcomm
 hosts
To: Christoph Hellwig <hch@lst.de>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>
 <20241025113520.GA19521@lst.de>
 <0fac5de3-3f35-4fc2-bbdc-411dc1018a85@oss.qualcomm.com>
 <20241028091941.GA29461@lst.de>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241028091941.GA29461@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KF-IgiU6cpV75ecNvs9iMe7NrB1jxQ7Q
X-Proofpoint-GUID: KF-IgiU6cpV75ecNvs9iMe7NrB1jxQ7Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=669
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410280107

On 28.10.2024 10:19 AM, Christoph Hellwig wrote:
> On Fri, Oct 25, 2024 at 05:30:05PM +0200, Konrad Dybcio wrote:
>> (Un?)fortunately, said platforms use FDT, so we can't fix that in ACPI.
> 
> Then generalize the acpi helper to a generic one checking ACPI and
> DT and specify a proper DT binding.
> 
> If th requirement to put all devices into D3 is a plaform propery
> a specific driver is always the wrong place for it.
> 
>> b) Adding such a property to the PCIe host node sounds a bit
>>    saner, but the NVMe code isn't aware of the RC. We could add
>>    something like:
> 
> Again, this all belongs into core code.  The nvme driver is just
> a consumer of this information, just like for example the AHCI
> driver.

Alright, I'll try to pursue that angle instead,

Konrad

