Return-Path: <linux-kernel+bounces-346957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F72498CB70
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C770EB229EA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32193FC12;
	Wed,  2 Oct 2024 03:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QKhsXioz"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3D41078F;
	Wed,  2 Oct 2024 03:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727838755; cv=none; b=nCyMJboCJLuT78etK4lbMfUIYf5yd7Ha+6Vt1/Dr9a8OhfY9UWSrMoUJAKtcHne/7ugA9PzhVZQnoA6q18hwilvt2wLdg4LC5wMqttBtB8y79mEjpqQqiyNW10sanTWXHAIuV4Bm0ITo+WAUF/XdjIQC7XTvVT0Aw3DpbcVBrrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727838755; c=relaxed/simple;
	bh=t0z7urD/AXYiPPPIdP9KUab28YPvgRAqMocixPVFPM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BuUyc7ciLqA8sBHSs/26/ZZH084K/fu7Of2WgsW6MATOxW1LeoDK6FfGARI+sDeMraCpOAKPPVLQaedfIKc4mmzTyLuQ2m08Zcdnh1ZzMwbtBivfAhGPJKZ49VvZFNlRh7dwzu3i+gYxyB3RZCcye+7g/duU1VKtvhc0OaFazsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QKhsXioz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4921KXLE011400;
	Wed, 2 Oct 2024 03:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=d
	7Rx5CCMQGs48tFUBEGYyiO5Kb2I0+qYUHWXtMohil0=; b=QKhsXiozlFyDrVpmK
	stxEdSlYd1bq7Kga6pWLyZioPup/3RCvUziMew831EnxZ9cYbiY2OT006CXKj3IB
	/VM/wqzFYLJ1AEXKkBPdGKa8QLGGu3g/sqh2y5/ESlhSA9lr7PBHaQtKi/SLGNPz
	j+HuN8Qt9uZ8Z/g8S961ZNyjcMcWJn1UJlsH83NJCN67vqOCIx7Z4iuDhl4TG4mM
	ckXCRo5HBolSDbXZGZ6gczPmaZXa7fhPftdCEGSbWaKT93rlrdTPWpAKZt2KBoBY
	39elmBALhPWFIpBw5ANM7fS4X35h69t46EeyHTCsmAWN7vyG4y3DVP5ieLNy3Kvb
	SPGNA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420ve009v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 03:12:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491Mj108014098;
	Wed, 2 Oct 2024 03:12:11 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xwmk7tfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 03:12:11 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4923CBpl25821716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Oct 2024 03:12:11 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E2A658055;
	Wed,  2 Oct 2024 03:12:11 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C90F85804E;
	Wed,  2 Oct 2024 03:12:10 +0000 (GMT)
Received: from [9.61.120.47] (unknown [9.61.120.47])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Oct 2024 03:12:10 +0000 (GMT)
Message-ID: <434b4a7c-59ca-47c2-a90f-b4fb994bccac@linux.ibm.com>
Date: Tue, 1 Oct 2024 22:12:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] Device tree changes for system1 BMC
To: Andrew Jeffery <andrew@codeconstruct.com.au>, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
        eajames@linux.ibm.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20241001191756.234096-1-ninad@linux.ibm.com>
 <172782880678.751051.14871757116202304815.b4-ty@codeconstruct.com.au>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <172782880678.751051.14871757116202304815.b4-ty@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -dI_X3iO1Me1Sx9TiS99svVMYyO1_SW2
X-Proofpoint-GUID: -dI_X3iO1Me1Sx9TiS99svVMYyO1_SW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_02,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxlogscore=795 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410020022

Hi Andrew,

On 10/1/24 19:26, Andrew Jeffery wrote:
> On Tue, 01 Oct 2024 14:17:47 -0500, Ninad Palsule wrote:
>> Please review the device tree changes for BMC for system1 machine.
>>
>> Ninad Palsule (3):
>>    ARM: dts: aspeed: system1: Bump up i2c busses freq
>>    ARM: dts: aspeed: system1: Enable serial gpio0
>>    ARM: dts: aspeed: system1: Add GPIO line names
>>
>> [...]
> Thanks, I've applied this to be picked up through the BMC tree.
Thank you!
>
> --
> Andrew Jeffery <andrew@codeconstruct.com.au>
>

