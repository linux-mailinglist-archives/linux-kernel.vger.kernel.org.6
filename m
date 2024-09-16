Return-Path: <linux-kernel+bounces-330789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ADB97A44F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B0E1F2301A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69240158216;
	Mon, 16 Sep 2024 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Agr/oit0"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90D015699D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726497656; cv=none; b=du3aGaAA7JbRWIyEyvhIH3BZloV+IdH9YF477vGBEK2lq1zpyubkTw5b8ulmhznRlC02Z7fQl01vgSl3K6pTuBfwZZmg42eKI+G6IYGGoAaQ64HciJvkpt/NORyrZTGemC7Id+Mdp2UIjrryJLrPkbeRTtawSXABeh6b5Gsg+bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726497656; c=relaxed/simple;
	bh=0+LfZKsnxa1uPbMa6VF6ZtYTzNeMhfwoldMW/TwADvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZ//517Qw9qGaDvlh8ymMmhWnsBGbyh3djYiWDkgRjg1HouYwLrVEVUZS0fV0L+3++h8xSCZiHZ4GOfCVytwLhKpZZYByGbfzdZjUxRJH6QRuGrIxhFJ/3zLOQ9KBxjNYnXhATw+qsblwACrjb4V16b8yBsWiEaa7jJ4sAngxvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Agr/oit0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GCb3Eg031030;
	Mon, 16 Sep 2024 14:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=0
	+LfZKsnxa1uPbMa6VF6ZtYTzNeMhfwoldMW/TwADvc=; b=Agr/oit0rObVmdh4A
	7Dp7ELC39MqQL8y8BZDrvasA/znyRbQImtkioB8ajOnKllDdMza9aa0sW96GEvKf
	ScyXBDhVA0TUmeJ5U03pvzPz4CC8HmdHZau/syo/2ieCUH4MQkD/GaxNhDvuHZT9
	cX7XYtBM70BdNLAH29X0LIpaSuxkMAyq8w7u8PUognYfSSEOk2u+og7VRMwXHFyi
	lLV1bHxO+fad+2R1blRFI346ORiQ9QIoqZ3gvjXhCRe7YlSbR3xu48biMkNsDxzp
	7rJTUqB9jWPWu32UVV0ttNOPWVI4tGyBhBaaB1F+z6a2yf3Nb03k0mWvC/GbKg6C
	oYvBQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3uj2m0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 14:40:39 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48GEed49017778;
	Mon, 16 Sep 2024 14:40:39 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3uj2m0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 14:40:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48GC9ajr024637;
	Mon, 16 Sep 2024 14:40:38 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nq1mqqj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 14:40:38 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48GEebMv14156366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 14:40:37 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC3615805A;
	Mon, 16 Sep 2024 14:40:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E829058052;
	Mon, 16 Sep 2024 14:40:35 +0000 (GMT)
Received: from [9.61.251.169] (unknown [9.61.251.169])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Sep 2024 14:40:35 +0000 (GMT)
Message-ID: <f4cc885a-33af-4af5-85b2-72142fe83c87@linux.vnet.ibm.com>
Date: Mon, 16 Sep 2024 20:10:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PowerPC][Linux-next][6.11.0-rc4-next-20240820] OOPs while
 running LTP FS Stress
Content-Language: en-GB
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        vschneid@redhat.com, mingo@kernel.org, sfr@canb.auug.org.au
References: <82b9c434-a0fd-4488-95be-a45b8cd4b6e6@linux.vnet.ibm.com>
 <20240916113030.GZ4723@noisy.programming.kicks-ass.net>
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
In-Reply-To: <20240916113030.GZ4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GM2-HkX9HUnakcrXoUa9fjOaJNwzyoSy
X-Proofpoint-GUID: 4qxLe0pjbSlgDfJTDO_3AjSrdeYW7n-w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=860 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409160094

Yes, Issue is still seen. Latest seen was on 6.11.0-rc7-next-20240910.

I am re-attempting Git Bisect. Will update the results, once I am done.

On 16/09/24 5:00 pm, Peter Zijlstra wrote:
> On Mon, Sep 16, 2024 at 12:00:52PM +0530, Venkat Rao Bagalkote wrote:
>
>> I am seeing below kernel crash from 6.11.0-rc4-next-20240820.
> 0820 is almost a month old by now, did you verify if the same happens on
> a recent kernel? We did fix a bunch of issues around this.
>

