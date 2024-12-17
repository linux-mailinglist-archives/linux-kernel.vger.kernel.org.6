Return-Path: <linux-kernel+bounces-449062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3738C9F4935
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DE81891AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBBA1E3784;
	Tue, 17 Dec 2024 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VHkv2Yqr"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557312E628;
	Tue, 17 Dec 2024 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432598; cv=none; b=q+Zwnwj5HOuBZ860UGQjd1caVgnkH4Wx1Bd5A8D2HE6Qnejb1L+Cq/nEgdp5TDkXPDAVz9PCFhhAWKm1EESIpaVFB42ph9ZF99Db8Vjiob55TEYGs5dt4OY6SR1qUIb/ZV3Ix3uIA5O8nJO7BBrj8EG8ruLQZCbdpCFZXjVbtFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432598; c=relaxed/simple;
	bh=ix+mpO3BmaedFzsbZxxfCXtEg5mY2SHYpaZKeEYxTXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bDYn8egXdDcbFHytJVPk6W7yRNQ/w0TszvRcNV0CXoik9Jhg1Jfi4RjrILmawjUqz8sPxYxKqfGSLiXgF8l6ARneyjAx802tSmHfSzej3faLYjGQHVgl3PPFlbS8B/1F8PaGFWUelw6IwXT76FvBecK72cyPLdVI6lbKNVAyvbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=VHkv2Yqr; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH59Km0017522;
	Tue, 17 Dec 2024 04:49:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=pcb5W3nIMaVDYzwdDIvRaurJpaHr0+xOszlrHLQxg9U=; b=
	VHkv2YqrBUTfMxrCYxe9l8k3sG5CW7Gy6wn3eVmluOvSImC6aGjP5WSG2v1zfj2P
	uQioHxwITURbTFJqA+ol7DVEXt/EJUVkMstzD1Qd7mJ2FJq5qNXprIX32zYpUb/x
	8nisktI+FzURt+o1Cjo/qadk2Ecb0Hl7l0fVNfwtwRKZGFi3ICCLaV/cyWpkPEW5
	XMM1LOrkn8nTkqZzG9/aU/drRLuNBah8YiDfJHLAaBcCHbMe9T9/nt5AIbZWoxFL
	v5dOcyhj9cCQbOdILVMM1Bc39V883Mb0ivc4b+uezhOl4cqk/B/rke+RLNBxzdX8
	m+rAeySoGAI/WM5Aa4B+xQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 43h8a2386t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 04:49:44 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Tue, 17 Dec
 2024 10:49:41 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Tue, 17 Dec 2024 10:49:41 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id D273A820248;
	Tue, 17 Dec 2024 10:49:41 +0000 (UTC)
Message-ID: <da4a16f1-0bf6-4597-b1de-55386db85254@opensource.cirrus.com>
Date: Tue, 17 Dec 2024 10:49:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: intel_auxdevice: Don't disable IRQs before
 removing children
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Charles Keepax
	<ckeepax@opensource.cirrus.com>, <vkoul@kernel.org>
CC: <peter.ujfalusi@linux.intel.com>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20241212110221.1509163-1-ckeepax@opensource.cirrus.com>
 <3eb98099-75da-4464-97d1-9e8538375e34@linux.dev>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <3eb98099-75da-4464-97d1-9e8538375e34@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xxW_z3gi1wsroHy5Cgt1Z6Kowj_QwnVs
X-Proofpoint-GUID: xxW_z3gi1wsroHy5Cgt1Z6Kowj_QwnVs
X-Proofpoint-Spam-Reason: safe

On 16/12/2024 5:35 pm, Pierre-Louis Bossart wrote:
> On 12/12/24 5:02 AM, Charles Keepax wrote:
>> Currently the auxiliary device for the link disables IRQs before it
>> calls sdw_bus_master_delete(). This has the side effect that
>> none of the devices on the link can access their own registers whilst
>> their remove functions run, because the IRQs are required for bus
>> transactions to function. Obviously, devices should be able to access
>> their own registers during disable to park the device suitably.
> 
> What does 'park the device suitably' mean really? That sounds scary. What happens if the manager abruptly ceases to operate and yanks the power? Does the device catch on fire? On a related note, the manager should *never* expect to find the device in a 'suitable' state but always proceed with complete re-initialization.
> 
> It would be good to expand on the issue, introducing new locks is one of those "no good deed goes unpunished" situations.
> 
>> It would appear the reason for the disabling of the IRQs is that the IRQ
>> handler iterates through a linked list of all the links, once a link is
>> removed the memory pointed at by this linked list is freed, but not
>> removed from the linked_list itself. Add a list_del() for the linked
>> list item, note whilst the list itself is contained in the intel_init
>> portion of the code, the list remove needs to be attached to the
>> auxiliary device for the link, since that owns the memory that the list
>> points at. Locking is also required to ensure the IRQ handler runs
>> before or after any additions/removals from the list.
> 
> that sounds very detailed but the initial reason for all this is still unclear.
> 
For example, if the bus driver module is unloaded, the kernel will call
remove() on all the child drivers. The bus should remain functional
while the child drivers deal with this unexpected unload. This could
for example be writing some registers to put the peripheral into a
low-power state. On ACPI systems the drivers don't have control of
regulators so can't just pull power from the peripheral.


