Return-Path: <linux-kernel+bounces-551384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E93A56BC5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07913B5069
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000B821D3E4;
	Fri,  7 Mar 2025 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GDOaH9v/"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1F21A92F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360783; cv=none; b=unJSnBcKopPX5WYXXLh/ReXltVZg7JAUiC6Gpsb0Shh2X5JCnnzzz3tx55dQiipjRHyx1xVKK8/j2g54k09XNVfG6Ip/1fmXCchIMtO+SmS8fR93p46CJcTg+I2FdO+IHtpCHQteIuPZEj7sw/2wZxDRL0xWXu7Q/ZHYJ5SX8B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360783; c=relaxed/simple;
	bh=4I6iSscz3B5uoux7s7C+/CPGopWi54IbOyIS2dFilxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGPSLyEKsCQH1bXoGueQUw0R3Lrg86TsvzfEDwSKH0hIR/PLGiidiPTgDq00T6w9YJMncaRzNSPiggOgm56Vaq92h5TfHFiXJi8gn0dB5SmBIA5w8Iphj7Nmz2L9XAXBc+LCCzwluidhAet9/CfdlU6uiHPLd6Xqmwe3ezHHgAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GDOaH9v/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527Dq1bH018284;
	Fri, 7 Mar 2025 15:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZyFn+r
	1eFLX1116kt0khVRZJApepYRHlTPrywKyMS0g=; b=GDOaH9v/wTN+xgMoHyEwyT
	uu4UmmCEo38Dxn1DemsYtqF3Pjnv5lTP07zQZl4SRWGLhRrsqHFnA6Qfp/GA6IVl
	d4CmvFXthmN2/IhiwDD5/ZPgu8wlVnaJZTM3ZMTr4PHv/vBeYSAMYWY7CGGV/4P/
	+f0q9U8qDjp5o9oZhQvh9p2MKjQqZNBEVipI73ZbeCeiNAMipllkLHglUOS0mhTg
	GYaLNJLIL7PDYD11lVJwl2Ot5iYUwmO+V5VPh1CUbqcEpSS2wzaXFLSV3YKJKq0X
	l6fkxqvLAoWlsPRYswVhwZwk5kzlKX5qp/LywkQ/xCEbMpfyfg2qJ1y2sR2czzng
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457s6a366y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 15:19:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 527EcuAV025012;
	Fri, 7 Mar 2025 15:19:16 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 454f92f12u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 15:19:16 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 527FJF9R10617392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 15:19:16 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE85858043;
	Fri,  7 Mar 2025 15:19:15 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD4F558055;
	Fri,  7 Mar 2025 15:19:11 +0000 (GMT)
Received: from [9.61.11.159] (unknown [9.61.11.159])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Mar 2025 15:19:11 +0000 (GMT)
Message-ID: <b2c9df64-0afc-46cd-9e8d-6a3f41a4f1c7@linux.ibm.com>
Date: Fri, 7 Mar 2025 20:49:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
        Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
        axboe@kernel.dk
References: <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
 <20250305141554.GA18065@lst.de> <Z8hrJ5JVqi7TgFCn@kbusch-mbp>
 <20250305235119.GB896@lst.de> <Z8jk-D3EjEdyBIU5@kbusch-mbp>
 <20250306000348.GA1233@lst.de> <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de>
 <20250306141837.GA21353@lst.de> <Z8m4vzE36UHWjwep@kbusch-mbp>
 <20250306151654.GA22810@lst.de> <Z8pB9jQALxMN6WaA@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z8pB9jQALxMN6WaA@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F8oRERkOXie4hKo3gKGqA87w2iHGMcmB
X-Proofpoint-ORIG-GUID: F8oRERkOXie4hKo3gKGqA87w2iHGMcmB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=871 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503070111



On 3/7/25 6:16 AM, Keith Busch wrote:
> On Thu, Mar 06, 2025 at 04:16:54PM +0100, Christoph Hellwig wrote:
>> On Thu, Mar 06, 2025 at 08:01:19AM -0700, Keith Busch wrote:
>>
>>> Or consider a true multiport PCIe where each port connects to a
>>> different host. Each host sees a single port so they're not using
>>> multipath capabilities, and the admin wants the MD behavior that removes
>>> a disk on hot plug. Or even if one host sees both paths of a multiport
>>> PCIe, they still might want that hot plug behavior. The module parameter
>>> makes that possible, so some equivalent should be available before
>>> removing it.
>>
>> A module-wide parameter is absolutely the wrong way to configure it.
>> You'd ad best want it per-controller or even per-namespace.  One
>> tradeoff would be to disable the multipath code for private namespaces,
>> although that would cause problems when rescanning changes the flag.
> 
> It's not really about private vs. shared namespaces, though. There
> really is no programatic way for the driver to know what behavior the
> admin needs out of their system without user input. If you don't want a
> module parameter, then the driver will just have to default to
> something, then the user will have to do something to change it later.
> Not very pleasant compared to a simple one time boot parameter.
> 
I think always creating multipath head node even for the disk which doesn't 
have CMIC/NMIC capability should be useful. That way, we may then be able 
to remove multipath module parameter? In fact, you already mentioned about
it in one of your previous message. I see two approaches (one of them you 
proposed and another one Christoph proposed: 
https://lore.kernel.org/linux-nvme/Y+1aKcQgbskA2tra@kbusch-mbp.dhcp.thefacebook.com/). 

Maybe in first cut we should create multipath head disk node always for 
single/multi ported NVMe disk. Later we may enhance it and allow pinning the 
head node for hotplug events so that head node dev name remains consistent 
across disk add/remove hotplug events.

Thanks,
--Nilay

