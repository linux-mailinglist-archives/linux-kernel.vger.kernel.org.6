Return-Path: <linux-kernel+bounces-537819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F27FBA4917D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D05016D145
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A301C3C0F;
	Fri, 28 Feb 2025 06:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZbddBfmb"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33AB1BD9C6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740723582; cv=none; b=CWPGR+hk+7FfmHfRsrDeU+OcRkXzhmeSquPG6oBqvKHZA8oqQFLqcqw/WEJXuMa6wVinzmLYPc6KDPreCXNDhW1dwaUKCRzjHTizigguHtvodMnVCLyPp6pZMxdO8YAEizpqwLD9CtuBcCoF1eIm87WIQUsEkeHGArPQBNnHu50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740723582; c=relaxed/simple;
	bh=7uy8ZWJ2ejzmx7wHoZQPfVJOQ/DoGefQ5L8YUItx9p4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=pz6LBDcwHbDWbT0mvt1I/j/6ZP5i3ilbkRQ7xf4lPoA4exizK9G2PZLwbxuHcuJrKBafFaiTRIM5qiePNZVnv3FadZVucEwebX4algZzENrhHEtCRAKkWICdjkrSLDgupI6E7XlYvyq5IknDmxFyl1epPXhw8BTob63hThKN0E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZbddBfmb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RMnkEn015316;
	Fri, 28 Feb 2025 06:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=fr1vg76RcX2p/Mitf7IfH33i4E78
	sqtU6R5wxK3K63o=; b=ZbddBfmbodFDx8aFhnRx+kzuKktCnGjGMN+zW5cSjtYy
	eU3KPHmGBg8oD7/ZVYi4Q8yuCnehhmlohMdyBB3whcN10n7ovqF+qnqcRTjBjOFy
	d4lcbSzJvZ9mXk8lTWj1AScmJwzUS4HEBXlTJTmwgvgJFL8ZXQ+9jWefm7ZtNoPz
	UBRrFfWsakTh1a21rmNmydD0JHaAEj7cryzjPPlFhV/tgNPx4IKhax+8tlIzyQqX
	IMtve6HE7ZeMHp7RLW2onDJK/o9whYev2uMzBxWOB6BbxNvr4j8fsdL41DhmxvIu
	RzZDOyprwZVcwfnvjFqNzIo/m4FFaJZIszqrxV7LfA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45316a9mjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 06:19:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51S33mcb027479;
	Fri, 28 Feb 2025 06:19:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdkvvkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 06:19:22 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51S6JLQv30736976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 06:19:21 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 955425804B;
	Fri, 28 Feb 2025 06:19:21 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C3FA58055;
	Fri, 28 Feb 2025 06:19:20 +0000 (GMT)
Received: from [9.61.250.132] (unknown [9.61.250.132])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Feb 2025 06:19:19 +0000 (GMT)
Message-ID: <ed12ee41-5b7c-496d-801f-8c7e3699ab31@linux.vnet.ibm.com>
Date: Fri, 28 Feb 2025 11:49:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>, maddy@linux.ibm.com
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Subject: [linux-ppc]Memory Hotpulg self test is failing
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z_Or5vXI3Ire9qFOV_2kXAI00PZ79HAB
X-Proofpoint-GUID: z_Or5vXI3Ire9qFOV_2kXAI00PZ79HAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280041

Greetings!!


I am seeing memory hot plug self test is failing on power-pc kernel on 
IBM P11 system.

Kernel Version: 6.14.0-rc4-g09a81ff40389

Logs:

[stdlog] TAP version 13
[stdlog] 1..1
[stdlog] # timeout set to 45
[stdlog] # selftests: memory-hotplug: mem-on-off-test.sh
[stdlog] # Test scope: 2% hotplug memory
[stdlog] #    online all hot-pluggable memory in offline state:
[stdlog] #        SKIPPED - no hot-pluggable memory in offline state
[stdlog] #    offline 2% hot-pluggable memory in online state
[stdlog] #    trying to offline 2 out of 60 memory block(s):
[stdlog] # online->offline memory0
[stdlog] # -> Failure
[stdlog] # online->offline memory1
[stdlog] # -> Failure
[stdlog] # online->offline memory10
[stdlog] # -> Success
[stdlog] # online->offline memory11
[stdlog] #
[stdlog] not ok 1 selftests: memory-hotplug: mem-on-off-test.sh # 
TIMEOUT 45 seconds


Unfortunately I do have previous passed data, hence git bisect is not done.


If you happen to fix this issue, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>


Regards,

Venkat.


