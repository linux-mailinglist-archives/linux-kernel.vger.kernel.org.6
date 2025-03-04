Return-Path: <linux-kernel+bounces-543217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8C9A4D2E0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40468189437F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FF01F4603;
	Tue,  4 Mar 2025 05:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g16eaa5V"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3127BB640
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 05:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741065195; cv=none; b=dBGhaAJSo3v1Fi+n+3gi8Hjv0kiKpFXtYJCqL66QxVoTuHZ2oxG9LHsigddwLkeJ9tt7keJWHgcEngRd9/quq8Fsf8RWWp8vVUnoEa16+gHhv3Mf6oyFDvwlQPTqdE3vLOGcvmNNyzlCwXbPT46Eb+bkL8inHxxKyhx3Az2Ai5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741065195; c=relaxed/simple;
	bh=ixV/irBYsj5kD0A3DPg8XUO3zDn+UUi6pH8Smc19dJI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=FqMhU6dx108vwMBVn2xyTitRuIL0WM//gKoeLf+QMuACnQ36wY3tG8z1FmnWDa3qFB49aaJ1gzNyBuLAONLMvlf5M5l5M+BoIGTkgjodCleQ+JQB/vsUTR7gaOHCl+isTTlYtm39UDjMqI1NXeOaBpeGmhty6XP6Ybst7Vn8Aq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g16eaa5V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523KdBpv018728;
	Tue, 4 Mar 2025 05:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=9Mmxx9BzLSCgjqzCorficye9fmMy
	UXlLEOjHsrOeSiY=; b=g16eaa5VXsPfyR8a9N/tpQBxemJzGX5TOyAex9daLsWp
	XMzFXvXWgxmnJydzG4z1mTr6uWYaiqqcv4h2Q3Gs+rY9iV848qEC5aQHzG9E6DnS
	J+LkGXybHX+3sipx3GeZqjdeKYwAEL/AzH2vw4PLB3S8kbAEbox+nTFoSTcAVDcK
	eexxw09zI+EW6Lt8CcKNspLGy45VS486tyg1+Drc13PE6owjkfqq2RP0QtRipgXi
	g1TU6HVbLePrEWCYeojQZN1m6FavDOyHpsZ9kskK5gGSrZXBzEq0vsEA9BgJULYC
	VSMKqwiNn021PbMGtP8dNQuAwuuQGN/oyGHZMK9EjQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455kmyht38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 05:12:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52458YFS020800;
	Tue, 4 Mar 2025 05:12:57 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esjudtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 05:12:57 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5245CvqG43385172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 05:12:57 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 082615805E;
	Tue,  4 Mar 2025 05:12:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F04D58052;
	Tue,  4 Mar 2025 05:12:55 +0000 (GMT)
Received: from [9.204.204.161] (unknown [9.204.204.161])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 05:12:55 +0000 (GMT)
Message-ID: <8c4c3fc2-2bd7-4148-af68-2f504d6119e0@linux.ibm.com>
Date: Tue, 4 Mar 2025 10:42:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>, maddy@linux.ibm.com
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Build Warnings at arch/powerpc/
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _zp1hdzXtHLw7rMRdaRt4D898Jo2Zhi-
X-Proofpoint-GUID: _zp1hdzXtHLw7rMRdaRt4D898Jo2Zhi-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_02,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=746
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040039

Greetings!!


Observing build warnings with linux-next and powerpc repo's. Issue is 
currently not seen on mainline yet.

PPC Repo: 
https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git merge 
branch

PPC Kernel Version: 6.14.0-rc4-g1304f486dbf1
next Repo: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 
master branch

next Kernel Version: 6.14.0-rc5-next-20250303


On linux-next kernel issue got introduced b/w next-20250227 and 
next-20250303


Build Warnings:

arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0xe84: 
intra_function_call not a direct call
arch/powerpc/crypto/ghashp8-ppc.o: warning: objtool: .text+0x22c: 
unannotated intra-function call
arch/powerpc/kernel/switch.o: warning: objtool: .text+0x4: 
intra_function_call not a direct call


If you fix this issue, please add below tag.


Reported-By: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>


Regards,

Venkat.


