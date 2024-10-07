Return-Path: <linux-kernel+bounces-353467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9088992E3F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFD21C22D46
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED731D6193;
	Mon,  7 Oct 2024 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZGoltumU"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2F31D5CF5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309880; cv=none; b=nKHDjmy/i/+1StbIPHMPwJDIq3O5o/sKSL33BrQvcAGpCIbi0HGWF9qXnD2yA5h7GdskvrVlUFGsVxNgQK2ciTY4OlK4TFVN7TwjLL27ZWiFHiiRVm0nbQThzAinYEfKinsPal/csv/2KKxmokFVwS2DggFecxPapNPcB9d3ANM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309880; c=relaxed/simple;
	bh=hUhowv7m31c85WtlRmRKOnqRZkXLALFHwc0bKpC1mP8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=BJ/Z6u45C3ViFaHQKswsOp9WQRTwkVtacrhJZFcZ7MBWrBlx8hGiyU0cVJm9KzOtNqTWxJ9F6oeG0gIX0Xk/MCopLo20tgyLgi+Qz91onOQl44cYDUPSp8kvIQonVXC/g0PdR0JP6cp4g+8cgnRt6GSNpjlV8awddoQ4qrZZoVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZGoltumU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4978uIqR012899;
	Mon, 7 Oct 2024 14:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:to:from:subject:content-type
	:content-transfer-encoding; s=pp1; bh=/E19CWU7cb//DBL3ykesiPGj9b
	dVsZVr61rb7yI53cc=; b=ZGoltumUj4pUE58EXtq7eWhn74v6PmJUYvEDRfQaTa
	WSDLvtTLuZr3B9te2oRseuMW6erqX3bZ4ax0/q6dQ4wOP7zhmL8IZIYeRoWUA/aO
	2lT+k3ilflFKcl/jbqCo/2Ho2FrADYPVr7cDTnMbtetrS/AnLzf3J/7lKSE/z9jb
	Fr/QGSp3Vv50IxTew0qDB1RfI6XlLhesNeMDH3YBSWYdY2aavZmoPW7hzfI/VuEy
	yWfgDKYtwT8u/TAwpQaA9osENnZBaUNPuy7iQwocepStdou2qW5EMsYup+eMTxmR
	dqZUYynvPdL816SyaPqYkqDfORn7qIdL/DsED8dy2Aag==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424cjm1ru5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 14:04:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497DUXbF013807;
	Mon, 7 Oct 2024 14:04:24 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fsry5pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 14:04:24 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 497E4NLr19006010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Oct 2024 14:04:23 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 022E558062;
	Mon,  7 Oct 2024 14:04:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 655955805C;
	Mon,  7 Oct 2024 14:04:20 +0000 (GMT)
Received: from [9.61.255.162] (unknown [9.61.255.162])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Oct 2024 14:04:20 +0000 (GMT)
Message-ID: <ae6217b4-7b62-4722-9afe-f8379201cc9e@linux.vnet.ibm.com>
Date: Mon, 7 Oct 2024 19:34:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, hch@lst.de,
        brauner@kernel.org, sfr@canb.auug.org.au
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Subject: [linux-next][20241004]BUG: KFENCE: memory corruption in
 xfs_iext_remove+0x288/0x2c8 [xfs]
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hfbFJV53YFazxx5dLpgVmROvkWCtGbJh
X-Proofpoint-ORIG-GUID: hfbFJV53YFazxx5dLpgVmROvkWCtGbJh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_05,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=581 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410070098

Greetings!!!


Observing Kfence errors, while running fsstress test on Power PC platform


[ 6726.655519] 
==================================================================
[ 6726.655540] BUG: KFENCE: memory corruption in 
xfs_iext_remove+0x288/0x2c8 [xfs]
[ 6726.655540]
[ 6726.655746] Corrupted memory at 0x00000000b8747239 [ ! ! ! ! ! ! ! ! 
! ! ! ! ! ! ! ! ] (in kfence-#97):
[ 6726.655789]  xfs_iext_remove+0x288/0x2c8 [xfs]
[ 6726.655970]  xfs_bmap_del_extent_real+0x34c/0x8ec [xfs]
[ 6726.656159]  __xfs_bunmapi+0x538/0xb28 [xfs]
[ 6726.656352]  xfs_bunmapi_range+0xbc/0x138 [xfs]
[ 6726.656548]  xfs_itruncate_extents_flags+0x1bc/0x2f0 [xfs]
[ 6726.656748]  xfs_inactive_truncate+0xec/0x134 [xfs]
[ 6726.656890]  xfs_inactive+0x2fc/0x41c [xfs]
[ 6726.657019]  xfs_inodegc_worker+0x134/0x240 [xfs]
[ 6726.657129]  process_one_work+0x1fc/0x4dc
[ 6726.657136]  worker_thread+0x340/0x504
[ 6726.657142]  kthread+0x138/0x140
[ 6726.657147]  start_kernel_thread+0x14/0x18
[ 6726.657152]
[ 6726.657155] kfence-#97: 0x000000001b23b51e-0x0000000088873dcf, 
size=208, cache=kmalloc-256
[ 6726.657155]
[ 6726.657162] allocated by task 187091 on cpu 4 at 6323.430277s 
(403.226884s ago):
[ 6726.657170]  krealloc_noprof+0x18c/0x38c
[ 6726.657176]  xfs_iext_insert_raw+0x3c8/0x434 [xfs]
[ 6726.657265]  xfs_iext_insert+0x58/0xec [xfs]
[ 6726.657354] xfs_bmap_add_extent_hole_delay.constprop.0+0x130/0x4c8 [xfs]
[ 6726.657439]  xfs_bmapi_reserve_delalloc+0x234/0x4c8 [xfs]
[ 6726.657525]  xfs_buffered_write_iomap_begin+0x490/0x9e4 [xfs]
[ 6726.657619]  iomap_iter+0xf0/0x188
[ 6726.657624]  iomap_file_buffered_write+0xbc/0x11c
[ 6726.657629]  xfs_file_buffered_write+0xbc/0x388 [xfs]
[ 6726.657722]  vfs_write+0x38c/0x488
[ 6726.657727]  ksys_write+0x84/0x140
[ 6726.657732]  system_call_exception+0x138/0x330
[ 6726.657738]  system_call_vectored_common+0x15c/0x2ec
[ 6726.657745]
[ 6726.657747] freed by task 192236 on cpu 0 at 6726.655507s (0.002239s 
ago):
[ 6726.657755]  xfs_iext_remove+0x288/0x2c8 [xfs]
[ 6726.657844]  xfs_bmap_del_extent_real+0x34c/0x8ec [xfs]
[ 6726.657929]  __xfs_bunmapi+0x538/0xb28 [xfs]
[ 6726.658013]  xfs_bunmapi_range+0xbc/0x138 [xfs]
[ 6726.658097]  xfs_itruncate_extents_flags+0x1bc/0x2f0 [xfs]
[ 6726.658187]  xfs_inactive_truncate+0xec/0x134 [xfs]
[ 6726.658278]  xfs_inactive+0x2fc/0x41c [xfs]
[ 6726.658368]  xfs_inodegc_worker+0x134/0x240 [xfs]
[ 6726.658458]  process_one_work+0x1fc/0x4dc
[ 6726.658464]  worker_thread+0x340/0x504
[ 6726.658470]  kthread+0x138/0x140
[ 6726.658475]  start_kernel_thread+0x14/0x18
[ 6726.658479]
[ 6726.658483] CPU: 0 UID: 0 PID: 192236 Comm: kworker/0:2 Kdump: loaded 
Tainted: G    B              6.12.0-rc1-next-20241004-auto #1
[ 6726.658492] Tainted: [B]=BAD_PAGE
[ 6726.658495] Hardware name: IBM,9009-42A POWER9 (architected) 0x4e0202 
0xf000005 of:IBM,FW950.A0 (VL950_141) hv:phyp pSeries
[ 6726.658501] Workqueue: xfs-inodegc/sda3 xfs_inodegc_worker [xfs]
[ 6726.658593] 
==================================================================


Regards,

Venkat.


