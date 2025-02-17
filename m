Return-Path: <linux-kernel+bounces-516729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AFFA3764E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 18:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B72188D41C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 17:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FA119D08F;
	Sun, 16 Feb 2025 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mlkPZ6XX"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78483A27B
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739727338; cv=none; b=LsGXQb+DNlgcGRAqf3CcE/QmRYP3N8Z/IWvtiFZn95NJFDDek0Wa3++4ZsWTU6nZ8DB9ru5uUMQWWDcoox2IQUCRKe54QSDry903mUnQKHMIl7WLyR5qmNUrWtbGttmeEJ4DO2LkTY5L/PQ8+uAenssWkkceVEG3pkjn/RVDmJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739727338; c=relaxed/simple;
	bh=EYe1SfC1IWyRmbzmJMcHdl89lzy41J+dSyaI2EdtS7A=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=kuzRET6PwAhvPtGevMv1GVkJB7G5KlyhvavaFEKZN0Lr4cm42pNVYbRFOW/rbZRbSRuwSd8AOkcd8v5LN/C13gYrzcoKUcQeWuNWSaC4DU1Zx3qiuNsjH/hGLXZY9lJ53rLOUTi+igOv++r4svJMnh+eTqcE/GGA8e0UMI6Uxfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mlkPZ6XX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51G3jCH4012576;
	Sun, 16 Feb 2025 17:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=T7gWHUBJJfvgHtAzclPJDUhe/kij
	S/EZdBP7327saFk=; b=mlkPZ6XXJt1xsULIYdHIFjclYeaBfB6RQjTH/hHZHNTU
	VaINFZbN2bJMQ/xRhtFMLc4NveTve0PV4tf0bWlclcoVWXZVoUf+EWZgpQRS1we8
	8pDicpL2unRvdT8XXQFTidxHM8lDsRtK4KhE2DwhkjmCOCk7y7IaA8HAfwgRoDMw
	8fPqD6s1Iwllq7ISPe9LSp/u7Vv+Xoq+J1ZdxSAvF8j+poWvM7ZLjpCM2veDWPf7
	uhvFPzSq52ErSwQRD14EsVba64qxSZ5nWkQW8XDCy/TygtBB7fcirjNLII9Tf3Td
	6qZGXILbHY6/QKtZMk535Pec9mUDEQXxpAQWGFRVJA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44u639apha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Feb 2025 17:35:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51GCpJ67032320;
	Sun, 16 Feb 2025 17:35:10 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u6rkjhf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Feb 2025 17:35:10 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51GHZACm34537762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 16 Feb 2025 17:35:10 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D40758045;
	Sun, 16 Feb 2025 17:35:10 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EAFA58054;
	Sun, 16 Feb 2025 17:35:08 +0000 (GMT)
Received: from [9.61.242.32] (unknown [9.61.242.32])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 16 Feb 2025 17:35:07 +0000 (GMT)
Message-ID: <05d7e0d6-d96a-404c-b872-d5501c475780@linux.vnet.ibm.com>
Date: Sun, 16 Feb 2025 23:05:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>, sfr@canb.auug.org.au,
        neilb@suse.de, brauner@kernel.org
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Subject: [linux-next-20250214]Kernel OOPs while running LTP test readahead02
 on 6.14.0-rc2-next-20250214
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fGG7-vrFoT-1hEX6FtIyDDfDwX0XHqX8
X-Proofpoint-GUID: fGG7-vrFoT-1hEX6FtIyDDfDwX0XHqX8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-16_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502160159

Greetings!!!


I am observing kernel oops on IBM Power system while running LTP test 
readahead02 on 6.14.0-rc2-next-20250214 kernel.


By Reverting the below patch, issue is not seen.

     Revert "VFS: add common error checks to lookup_one_qstr_excl()"

     This reverts commit 22d9d5e93d0eaf7e8662602713b24e9b6171759f


Please help to fix this issue and request to add the below tag.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>


Traces:

[ 2154.427377] BUG: Unable to handle kernel data access at 
0xffffffffffffffdc
[ 2154.427390] Faulting instruction address: 0xc00000000062a560
[ 2154.427397] Oops: Kernel access of bad area, sig: 11 [#1]
[ 2154.427402] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=8192 NUMA pSeries
[ 2154.427410] Modules linked in: dns_resolver(E) tun(E) brd(E) 
overlay(E) exfat(E) vfat(E) fat(E) loop(E) sctp(E) ip6_udp_tunnel(E) 
udp_tunnel(E) ext4(E) mbcache(E) jbd2(E) dm_mod(E) bonding(E) tls(E) 
nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) 
nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) 
nft_ct(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) 
nf_defrag_ipv4(E) ip_set(E) rfkill(E) nf_tables(E) nfnetlink(E) hvcs(E) 
pseries_rng(E) hvcserver(E) vmx_crypto(E) drm(E) 
drm_panel_orientation_quirks(E) xfs(E) sr_mod(E) cdrom(E) sd_mod(E) 
lpfc(E) sg(E) nvmet_fc(E) nvmet(E) ibmvscsi(E) scsi_transport_srp(E) 
ibmveth(E) nvme_fc(E) nvme_fabrics(E) bnx2x(E) nvme_core(E) be2net(E) 
mdio(E) scsi_transport_fc(E) fuse(E) [last unloaded: hwpoison_inject(E)]
[ 2154.427514] CPU: 30 UID: 0 PID: 784383 Comm: rename10 Tainted: 
G           OE      6.14.0-rc2-next-20250214 #1
[ 2154.427524] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[ 2154.427528] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 
0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
[ 2154.427534] NIP:  c00000000062a560 LR: c00000000062a618 CTR: 
c00800000dbb4a10
[ 2154.427540] REGS: c00000054af579b0 TRAP: 0380   Tainted: G           
OE       (6.14.0-rc2-next-20250214)
[ 2154.427547] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
2802222f  XER: 20040000
[ 2154.427561] CFAR: c00000000062a61c IRQMASK: 0
[ 2154.427561] GPR00: c00000000062a618 c00000054af57c50 c000000001677600 
0000000000000000
[ 2154.427561] GPR04: c0000003c48560b0 00000000000a0000 0000000000000000 
c000000002cfaa88
[ 2154.427561] GPR08: 0000000000002710 0000000000000000 0000000000000000 
6161616161616161
[ 2154.427561] GPR12: c00800000dbb4a10 c00000000f75af00 0000000000000000 
0000000000000000
[ 2154.427561] GPR16: 0000000000000000 00000000000a0000 0000000000000000 
0000000000000000
[ 2154.427561] GPR20: 0000000000100000 0000000000000002 00000000000a0000 
0000000000000000
[ 2154.427561] GPR24: fffffffffffff000 ffffffffffffff9c ffffffffffffff9c 
c0000005488e1c28
[ 2154.427561] GPR28: c00000054af57d08 c0000005484eae00 00000000000a0000 
ffffffffffffffdc
[ 2154.427627] NIP [c00000000062a560] lookup_one_qstr_excl+0x50/0x148
[ 2154.427639] LR [c00000000062a618] lookup_one_qstr_excl+0x108/0x148
[ 2154.427646] Call Trace:
[ 2154.427649] [c00000054af57c50] [c00000000062a618] 
lookup_one_qstr_excl+0x108/0x148 (unreliable)
[ 2154.427659] [c00000054af57ca0] [c00000000063510c] 
do_renameat2+0x360/0x63c
[ 2154.427666] [c00000054af57de0] [c000000000635570] sys_rename+0x5c/0x74
[ 2154.427672] [c00000054af57e10] [c000000000033638] 
system_call_exception+0x138/0x330
[ 2154.427681] [c00000054af57e50] [c00000000000d05c] 
system_call_vectored_common+0x15c/0x2ec
[ 2154.427690] --- interrupt: 3000 at 0x7fffa1580804
[ 2154.427697] NIP:  00007fffa1580804 LR: 00007fffa1580804 CTR: 
0000000000000000
[ 2154.427702] REGS: c00000054af57e80 TRAP: 3000   Tainted: G           
OE       (6.14.0-rc2-next-20250214)
[ 2154.427708] MSR:  800000000280f033 
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44002228  XER: 00000000
[ 2154.427725] IRQMASK: 0
[ 2154.427725] GPR00: 0000000000000026 00007ffff0fb00d0 00007fffa1757200 
000000001002df18
[ 2154.427725] GPR04: 0000000010051698 0000000000000047 0000000000000000 
0000000000000000
[ 2154.427725] GPR08: 0000000010012b3c 0000000000000000 0000000000000000 
0000000000000000
[ 2154.427725] GPR12: 0000000000000000 00007fffa181a560 0000000000000000 
0000000010032300
[ 2154.427725] GPR16: 0000000010032a70 0000000010033100 0000000010033104 
0000000010032a98
[ 2154.427725] GPR20: 00000000100328c8 0000000010032f70 0000000010031a00 
0000000000000000
[ 2154.427725] GPR24: 0000000010052830 0000000010053cac 0000000010054544 
0000000010050690
[ 2154.427725] GPR28: 0000000010053cb0 0000000000000000 000000001002df48 
00007fffa1813570
[ 2154.427786] NIP [00007fffa1580804] 0x7fffa1580804
[ 2154.427790] LR [00007fffa1580804] 0x7fffa1580804
[ 2154.427794] --- interrupt: 3000
[ 2154.427798] Code: fbc1fff0 fbe1fff8 7c9d2378 7c7c1b78 7cbe2b78 
f8010010 f821ffb1 f8410018 4bfffee9 eb7d0030 7c7f1b79 41820064 
<813f0000> 75290038 40820038 77de0002
[ 2154.427820] ---[ end trace 0000000000000000 ]---
[ 2154.591618] pstore: backend (nvram) writing error (-1)


Regards,

Venkat.


