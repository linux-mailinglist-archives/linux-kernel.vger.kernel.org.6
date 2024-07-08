Return-Path: <linux-kernel+bounces-244118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9E9929F69
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1BA4B27693
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105FF763EE;
	Mon,  8 Jul 2024 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eTmcX0WS"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E13876025
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431615; cv=none; b=Yv/lNIePADUSHVjw51Af+nGG5rMURvdiBUQh+kz1fWWvtv6zeBzuCFnHZAUu5nPgjELjowGDLzezXOU805bhDvM6hXFupayjdSfORffHxPeb/YLytqVawKKpoYUrGmiC6qr+dM4X0sSR325+PsXaG8sQbEJShI2CMnqhm/7vzos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431615; c=relaxed/simple;
	bh=suXz/NsjcdZU6H3RmQm5y4wRdmCitTcoLdgCGwfC1f0=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=TCt5NTP3oal6pCGNQ9Nk9i1B/sI6mflcpFBkbPiYO/keLHC4pJE+lVuUVVip4mVl7BaGDT0VnLboYoC0rpu8tk1tShRF4M9ouK4Gkr8RN3Mb5x9Gt84CW4Yr2PcRuqO3If9eESXqx1ngG87LsuuPf9eCYXKHMd6uH3t4+iHMGeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eTmcX0WS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4688umSk030051;
	Mon, 8 Jul 2024 09:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:from:to:subject:content-type
	:content-transfer-encoding; s=pp1; bh=mEJlI5Bf+3K/cfy+Ncf2vAs5Yf
	tIu8M7Bcq8Iy0mOAE=; b=eTmcX0WSgmEsbdD4bEMA8nDvHTc7zmltSx7o1Sbe5B
	gMqYJo4hvH/sd3AK6nLF7M21dOe3BHkGnRW+91tocvAzbfrDDgpRwbRk+8JYKBbh
	LzPUbiTOeTc7iXX5Sqw1IDRZDlSHlZUYrHpVSHUY2sdgdRaMFgIhwQyaCw1K+BrK
	kTavAYpJHnUoutAzn3oLN/NDlIQJn8qWP/wuQ6OGFSOCFdP5bC6YkBc0LHVNAdm+
	GT8nHVfabYZf5QMbQLIpCETUb4Xnb6hGRtcQJpIPIC0neisyG3ZLkxCkglYSsKYs
	DdJRpv8lLoN5ngT0CEfceZDAfbMH2bowxS2cGiuu8UzQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407jpyjrby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 09:40:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46894Igc013976;
	Mon, 8 Jul 2024 09:40:00 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407h8peaeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 09:40:00 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4689dw2356099082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jul 2024 09:40:00 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BD585805B;
	Mon,  8 Jul 2024 09:39:58 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 209D85806A;
	Mon,  8 Jul 2024 09:39:52 +0000 (GMT)
Received: from [9.43.100.214] (unknown [9.43.100.214])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jul 2024 09:39:51 +0000 (GMT)
Message-ID: <a70e4064-a040-447b-8556-1fd02f19383d@linux.vnet.ibm.com>
Date: Mon, 8 Jul 2024 15:09:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
To: jgowans@amazon.com, rppt@kernel.org, akpm@linux-foundation.org,
        graf@amazon.de, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
        linux-mm@vger.kernel.org
Subject: [linux-next-6.10-rc6-20240703] Warning at mm/memblock.c:1447
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: euGzHWSm8h8AbhphUckCF1aqZIzcRU-x
X-Proofpoint-GUID: euGzHWSm8h8AbhphUckCF1aqZIzcRU-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_04,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=356 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080073

Greetings!!!


Observing below warning while booting, when fadump is configured with nocam.


[    0.061329] ------------[ cut here ]------------
[    0.061332] WARNING: CPU: 0 PID: 1 at mm/memblock.c:1447 
memblock_alloc_range_nid+0x24c/0x278
[    0.061337] Modules linked in:
[    0.061339] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
6.10.0-rc6-next-20240703-auto #1
[    0.061341] Hardware name: IBM,9080-HEX POWER10 (architected) 
0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_016) hv:phyp pSeries
[    0.061342] NIP:  c000000002061610 LR: c000000002061424 CTR: 
0000000000000000
[    0.061344] REGS: c000000004d2f780 TRAP: 0700   Not tainted 
(6.10.0-rc6-next-20240703-auto)
[    0.061345] MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 
44000242  XER: 20040010
[    0.061350] CFAR: c00000000206142c IRQMASK: 0
[    0.061350] GPR00: c000000002061424 c000000004d2fa20 c0000000015a3d00 
0000000000000001
[    0.061350] GPR04: 0000000000000800 00000012c0000000 0000002580000000 
ffffffffffffffff
[    0.061350] GPR08: 0000000000000000 0000000000000002 c000000002f58c08 
0000000024000242
[    0.061350] GPR12: c000000000454408 c000000003010000 c0000000000112ac 
0000000000000000
[    0.061350] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[    0.061350] GPR20: 0000000000000000 0000000000000000 0000000000000000 
c00000000149d390
[    0.061350] GPR24: c00000000200466c ffffffffffffffff 0000002580000000 
00000012c0000000
[    0.061350] GPR28: 0000000000000800 0000000000000005 0000000000000000 
0000000000000000
[    0.061365] NIP [c000000002061610] memblock_alloc_range_nid+0x24c/0x278
[    0.061368] LR [c000000002061424] memblock_alloc_range_nid+0x60/0x278
[    0.061370] Call Trace:
[    0.061371] [c000000004d2fa20] [c000000004d2fa60] 0xc000000004d2fa60 
(unreliable)
[    0.061373] [c000000004d2fae0] [c00000000206178c] 
memblock_phys_alloc_range+0x60/0xe4
[    0.061376] [c000000004d2fb60] [c000000002017a60] 
setup_fadump+0x114/0x244
[    0.061379] [c000000004d2fbe0] [c000000000010e78] 
do_one_initcall+0x60/0x398
[    0.061381] [c000000004d2fcc0] [c000000002006b5c] 
do_initcalls+0x12c/0x218
[    0.061383] [c000000004d2fd70] [c000000002006f28] 
kernel_init_freeable+0x238/0x370
[    0.061386] [c000000004d2fde0] [c0000000000112d8] kernel_init+0x34/0x26c
[    0.061388] [c000000004d2fe50] [c00000000000df7c] 
ret_from_kernel_user_thread+0x14/0x1c
[    0.061389] --- interrupt: 0 at 0x0
[    0.061390] Code: eb81ffe0 ebc1fff0 ebe1fff8 7c0803a6 7d710120 
7d708120 4e800020 60000000 4afbf219 60000000 3b800080 4bfffe40 
<0fe00000> e8610068 7f26cb78 38a02900
[    0.061396] ---[ end trace 0000000000000000 ]---


cat /proc/cmdline
BOOT_IMAGE=(ieee1275//vdevice/vfc-client@300000d4/disk@50050768101535e5,msdos3)/boot/vmlinuz-6.10.0-rc6-next-20240703 
root=UUID=2c90ab47-3389-4017-9f06-0c94534fd9cb ro 
crashkernel=2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G 
fadump=nocma


Reverting the below commit, issue is not seen.


Commit ID: 0fa4ac6722127f4aae2ea9813ba246ce2bec8326


Regards,

Venkat.


