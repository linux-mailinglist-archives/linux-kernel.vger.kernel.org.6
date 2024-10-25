Return-Path: <linux-kernel+bounces-382046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177469B086A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F5B0B270F9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA6113B58B;
	Fri, 25 Oct 2024 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IHkpxnC7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821CF13632B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870214; cv=none; b=bGkxdIfA/oVX0AOAtMYy7NXiRmw+otS0KO4JbiHlWJp50UNFuYls48q8/a/aWbtQQwm+sNfq8D9jonMd3gi1aakUGmiuFGTQyq6abK7gJZMeR10/uSmrDGQ+nUwu3wqqg0KLkED5Sc2ZZWZfsCrSxpZC9nrvNC8lfHKQMypdP2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870214; c=relaxed/simple;
	bh=8xm2+voDPiKuWqjHP04zsocJEewGkAibeaf+j+ZIqAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5gZJQA4yEaZsphtN/PwKf/x4yGs9N+CAJDZlu+cwW6OaW46y8Hzp8hmu6dsp6wBB5RPycjZ6b4UUerpk5fJjvBBA+gvGQATt21MhTn3hb/gDFmUUmo/eB93P7BSrL1JaOcrjM4I65zlbmbCKIo0gdkpOaqGJytLnGNuR+Z026s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IHkpxnC7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PCJhdJ026346
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oxQDiRendUtZbpNXv2gz63FMfIBDq8Ao3KkaY8zNodE=; b=IHkpxnC7CqL8P30+
	xwCoXmRGOrg9eP3OVi2NyK8RhKNRcBK1W9thJdRIGNpkx+AL1NgFHbANhiBjnvKI
	BnoIEtDbwFU3n601F3oBlIzpMscEcGHPsHpXdEe3ErYNgHSgs21r+CXVLvnPdQYi
	EUJrfj8xXc7MYVBD08QdfFOmfNx3QJIadSfIH28Seb1hIxsJC3KJC2l7lyXpoFMO
	1F7ZRXCB3Ebw+rb1SXMlg8wdcClRdS2LDJDPUmgWxwjqisU9B8U2GPmf44S8IkmU
	ojz0n6EFjtUMsg+wEtyZHWsvEiQm7/vrVE7h4AXR6b8QSyYA/kFCLjEaq5GbJTwf
	F5N6Jw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3wsq4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:30:10 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-71841b0ee34so275565a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729870210; x=1730475010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxQDiRendUtZbpNXv2gz63FMfIBDq8Ao3KkaY8zNodE=;
        b=u2Kwiz2WOiaYwqD8S3V0UTRkVQ4odeOw9SttfzVZ3uNLx53EUEP40VRYcQQuaD9FgL
         T+YOy9BPtUcWa3YWfQyxQGTGMTXesZHXwxqvgGQVnaSqZXMpnO8NckDjOC5hR/7Ou7KT
         VPhb2lYO6E/leTRVSBvdYFdARAGUm55SoYnHdzcBOkU0CvTyfVOLDr/RziJ1530FtOOE
         PHtRnhmthO4J5KJSJbo7J9hdboMHDI0VLAy1aq8tjnp1nE1gIKId3Jy4ROj+KCpBDnsW
         9BU4fEdP5BN1q/Cp+S7B3FkaVf6KotlqJ7YOcUuuIxD1/HRvdgL5DW7L1Zqao8QHIfiz
         rU4A==
X-Forwarded-Encrypted: i=1; AJvYcCX1wY5ODP6NFS3colrGGUEBAiQOhPeWtrJoYwVMv6Y9G/wRa1KLzeG3fiRbhdlp2J+inArBTOocfT0jGcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVaR5IpfA8HB9NcH68x+s/bXk9MUsuOeo5LGF8tGDIGnq1eOYJ
	4WNKqCi54jRZkQezziXCFC0NdK9aPogFmbjZSMktS2ZjAdm1mv+s5Yxf8dzGbF0eHoOGS5XRyEL
	1PpK8XJG5bo936qY7FdvUarIE8TX3i7uH2dHp/1dwHXrz5CorVaNVlPiyAAWB8/M=
X-Received: by 2002:a05:6830:410d:b0:710:f408:bd54 with SMTP id 46e09a7af769-71863d5ccf5mr506933a34.2.1729870209615;
        Fri, 25 Oct 2024 08:30:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7XbilQJu9FD6jaLp/3NeXoBbqPifFUOCb3VAKss/uYt9A40EYWhxDcJonOImwVjjWdw0z2A==
X-Received: by 2002:a05:6830:410d:b0:710:f408:bd54 with SMTP id 46e09a7af769-71863d5ccf5mr506913a34.2.1729870209237;
        Fri, 25 Oct 2024 08:30:09 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f298ef6sm82309966b.136.2024.10.25.08.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 08:30:07 -0700 (PDT)
Message-ID: <0fac5de3-3f35-4fc2-bbdc-411dc1018a85@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 17:30:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Force NVME_QUIRK_SIMPLE_SUSPEND on Qualcomm
 hosts
To: Christoph Hellwig <hch@lst.de>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>
 <20241025113520.GA19521@lst.de>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241025113520.GA19521@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VVYtIu5BCRQNIONtkSwa8xq2SK9Z1nVN
X-Proofpoint-ORIG-GUID: VVYtIu5BCRQNIONtkSwa8xq2SK9Z1nVN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250120

On 25.10.2024 1:35 PM, Christoph Hellwig wrote:
> On Thu, Oct 24, 2024 at 07:33:07PM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> The Qualcomm SC8280XP SoC requires that all PCIe hosts are powered down
>> before the platform can reach S3-like sleep states. This is very much
>> similar in nature to the issue described in [1].
>>
>> Other Qualcomm platforms we support upstream require more complex code
>> additions across both the PCIe RC driver and other platform-specific
>> ones, before the link can be sustained in suspend. Hence, they
>> effectively need the same treatment for now.
>>
>> Force NVME_QUIRK_SIMPLE_SUSPEND on all Qualcomm platforms (as
>> identified by the upstream bridge having a Qualcomm VID) to address
>> that. Once the aforementioned issues on non-SC8280XP platforms are
>> addressed, the condition will be made more specific, with a PID check
>> limiting it to only the platform(s) that require it due to HW design.
> 
> The NVMe driver is the wrong place for this, it needs to happen in the
> core by making acpi_storage_d3() evaluate to true.  Preferably by
> actually setting the right ACPI attributes because a check for 
> PCI vendor ID absolutely will never do the right thing in the long run.

(Un?)fortunately, said platforms use FDT, so we can't fix that in ACPI.

We also considered a DT property to indicate this, but:

a) PCIe devices are discoverable and it's really really really
   discouraged to hardcode devices that are likely to be present
   on the bus (and this wouldn't work if a NVMe device showed up
   on a different-than-usual RC)

b) Adding such a property to the PCIe host node sounds a bit
   saner, but the NVMe code isn't aware of the RC. We could add
   something like:


struct pci_bus *pbus = pdev->bus;

while (!(pci_is_root_bus(pbus)))
	pbus = pbus->parent;

if (of_property_present(pbus->dev.of_node, "broken-sleep-foo-bar"))
	return NVME_QUIRK_SIMPLE_SUSPEND;


..but that implies we have to set that quirk in DT on all platforms
which only require an equivalent workaround temporarily. That in turn
is later much harder to undo than a simple driver change (e.g. if your
FDT is provided by the firmware).

In general, I don't think we can at all rely on firmware updates for
devices that are already on the market.

Konrad

