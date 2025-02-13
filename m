Return-Path: <linux-kernel+bounces-513241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293F6A34569
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E2116ECF3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADD215539A;
	Thu, 13 Feb 2025 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y1R5GFSp"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FDA26B087
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459062; cv=none; b=Km5ILSVL1N6nvevQpJSpTNx0DusHTfQjJLrdOJDMzmmNYtDSYRNRzvjM6X5IixSNdLdSuFgn2sHyZ3ZdTl1vi0m1Tj7oYnwI57b/FkXJRoHD+E1xLHvh604nmFPVcyMZuDEwtcDf8B2eWLEtnqFQuqy/yGS52ilpiOILtsoI/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459062; c=relaxed/simple;
	bh=MDJFa426xk/Ppp9WGfIjSz/czZXmuJgOHlWi/zDydcA=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=PybFpzscm+T8mUhnXDepc/6UOj+ZwfRD0KYtHCu63aGBqsAi/HLJeSUhCvmOBONW0SY2YuNDvZnaHwOrA/zXiVx1cquOCd3z1yBRNWt66fzLbhPJUf/ql1hvOSlMY5ogrYaFb6sv95roPxcFcorctXu2hOo+7OsGdmCT6oee1cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y1R5GFSp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D7WxUo014718;
	Thu, 13 Feb 2025 15:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=9sn/0W+u2m5UU6jPKFLpLTgarS3M
	TBh1n7M7FWMc4JM=; b=Y1R5GFSpjSwCdLCgzTuSSf6NVJzjllcJ/1+7VftuvxZP
	UvJUPSvOYkESaRidAKys+BO1JhnHQVP8uZDcm+jckRGLIrZETwYcHXt60pcR1XSs
	wMe/Z8lDeM5bwlMr0fyCAEjkj/M7APcKTB9P8FNrHO2Ehb0Eigg6QqBQ/AN9Xuny
	VTJpM5Zv13gCruWzCVyAuJ/myD8YbZ97c8fmsMzSKRQjKH+GjEG1A7eL6Lr8zlwq
	M2co3RNMXufbZjnZjVVfZKzvtAnKNvz+116mvuOTO/kOJigqVxzhNgEslzzbqn8U
	bQBaECZoI1l0DT2iGXofAPLRCbC15/NiSxJgcRLoJA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44sceq27xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 15:04:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51DDxMjh028716;
	Thu, 13 Feb 2025 15:04:11 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pma1xbm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 15:04:11 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51DF49me19071714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 15:04:10 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 976D858058;
	Thu, 13 Feb 2025 15:04:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 915BB58057;
	Thu, 13 Feb 2025 15:04:08 +0000 (GMT)
Received: from [9.61.255.185] (unknown [9.61.255.185])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Feb 2025 15:04:08 +0000 (GMT)
Message-ID: <8e73069b-5987-4a08-b13d-13fe691092ad@linux.vnet.ibm.com>
Date: Thu, 13 Feb 2025 20:34:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [linux-next-20250212] syscall kexec_file_load not available
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ax8z4eh8gHPKYoV9oViK3KDvDxpM0D-S
X-Proofpoint-ORIG-GUID: ax8z4eh8gHPKYoV9oViK3KDvDxpM0D-S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxlogscore=514
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130112

Greetings!!!

 From kernel next-20250210, I am observing syscall kexec_file_load not 
available, there by kdump service is failing to start.


Logs:

[root@ltc-zzci-1 ~]# kexec -p 
--initrd=/boot/initramfs-6.14.0-rc2-next-20250212kdump.img 
/boot/vmlinuz-6.14.0-rc2-next-20250212 -c
Warning: append= option is not passed. Using the first kernel root partition
Modified cmdline: elfcorehdr=311424K 
root=UUID=b5b1f89c-d479-48b3-90e2-744a2fd05667
[root@ltc-zzci-1 ~]# kexec -p 
--initrd=/boot/initramfs-6.14.0-rc2-next-20250212kdump.img 
/boot/vmlinuz-6.14.0-rc2-next-20250212 -s
syscall kexec_file_load not available.
[root@ltc-zzci-1 ~]# kexec -v
kexec-tools 2.0.27
[root@ltc-zzci-1 ~]# uname -r
6.14.0-rc2-next-20250212


Regards,

Venkat.


