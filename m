Return-Path: <linux-kernel+bounces-555462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB60A5B7F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 05:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D60E3AE701
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4DB1E1A17;
	Tue, 11 Mar 2025 04:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sYGR64IX"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DC01EB182
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 04:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741667031; cv=none; b=eHavRpgrF4aoNDPSJ39HQ4K9548fISuG68+t20f9GPDMNbuuKQEhy+67eHn7jiUv5iUBlvsYRzQrMMb71eTHEoRYmhZet+M+vsuTWh7U744wg24bDoFb2YP6g7kR2inxe4NNjAPqgyf7D7mm9uiMjtUxykUd3N6ot2pe1bRiCu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741667031; c=relaxed/simple;
	bh=7MI1tGVzm3T+v/Jo2Dckz7PNF/i1uRJUyYwwjMxcRPo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=VlBUXf9Xlx1HXmoScv3dht3rorPOONG6YHV4r+qaAZ9pu8dwsz0UXMo8vHDzr9EkEPbAhP6BUomyeLgZFamogLEWMT4lsDCh7Bb4opiWRoJlfMMmJES5vB8StIzk7sf/wMzm/W2BHbsuDIQXZS6lj4uTa6HTWx122V4BiDRgRiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sYGR64IX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B3kAvq002047;
	Tue, 11 Mar 2025 04:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2sFMT/
	OdFkBmM6SRLuEe3CsOlj5Z36F3ouTNqeEiRDY=; b=sYGR64IXHYFan1/GD1YUAT
	Sdl48G7SQl9hePRi3K+9OKRYsNPV9FOeblSzbbN3Gi8VAAKNQ0M4CPTteLRtwwbj
	jPrWKsnY3f4ZsNAJDSXCEzHJ5f0pKyOOzvzRZGMLKI4cvzZXVhHsCuzr2dtmoSs9
	/HlNn4dH4dxlghk3ldfzjk93kKtnH3GUdC70gVAKUsrZ9PVqpwCXOToNqob88mZL
	k1qTZ0gIiejpucWJmOIKXwRm2D1wntuNRG0Irsrrsv6aq7ci/0Sekb3fSsWXAjj+
	qZImE/AfUBSYgaq/n3jQC9xfC/MBWbuvEXm7ztFuMgCWFM+VZLCIrNOKhdbZ98Vw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45adjb03nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 04:23:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52B2EPsM027566;
	Tue, 11 Mar 2025 04:23:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4591qkj42u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 04:23:27 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52B4NREV24314544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 04:23:27 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39DB658064;
	Tue, 11 Mar 2025 04:23:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7414F58057;
	Tue, 11 Mar 2025 04:23:24 +0000 (GMT)
Received: from [9.204.204.161] (unknown [9.204.204.161])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Mar 2025 04:23:24 +0000 (GMT)
Message-ID: <25306d01-db9d-42aa-9c26-2e18dfc30241@linux.ibm.com>
Date: Tue, 11 Mar 2025 09:53:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next-20250307] Build Failure
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
        heiko@sntech.de, srinivas.kandagatla@linaro.org,
        nicolas.frattaroli@collabora.com
References: <70ba4e80-53c4-4583-82f3-2851e0829aa6@linux.ibm.com>
In-Reply-To: <70ba4e80-53c4-4583-82f3-2851e0829aa6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SkzSaid52IzM1svozZYcGsQPUODjGEY2
X-Proofpoint-GUID: SkzSaid52IzM1svozZYcGsQPUODjGEY2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=981
 spamscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110025

Git Bisect is poinitng to commit: 
3e081aa132bbefe31ac95dd6dfc8d787ffa83d0b as first bad commit.


Git bisect log:

git bisect start
# status: waiting for both good and bad commits
# bad: [0a2f889128969dab41861b6e40111aa03dc57014] Add linux-next 
specific files for 20250307
git bisect bad 0a2f889128969dab41861b6e40111aa03dc57014
# status: waiting for good commit(s), bad commit known
# good: [7eb172143d5508b4da468ed59ee857c6e5e01da6] Linux 6.14-rc5
git bisect good 7eb172143d5508b4da468ed59ee857c6e5e01da6
# good: [7eb172143d5508b4da468ed59ee857c6e5e01da6] Linux 6.14-rc5
git bisect good 7eb172143d5508b4da468ed59ee857c6e5e01da6
# good: [80ec13b98c6378cbf9b29d7ee7d3db930ddbd858] Merge branch 'master' 
of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git
git bisect good 80ec13b98c6378cbf9b29d7ee7d3db930ddbd858
# good: [6c60220c45270869a7c5f791f6e0197b1f0d0388] Merge branch 
'driver-core-next' of 
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
git bisect good 6c60220c45270869a7c5f791f6e0197b1f0d0388
# good: [187734f508b0a9a00ccaaf7d8ba05874b624ac73] Merge branch 
'for-next' of 
git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git
git bisect good 187734f508b0a9a00ccaaf7d8ba05874b624ac73
# good: [316ff3a28679b82eb2bf17c02dbca970e7433182] Merge branch 
'for-next/seccomp' of 
git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
git bisect good 316ff3a28679b82eb2bf17c02dbca970e7433182
# bad: [69759c9d8dd7df716dcca3601b82e5618332cef7] Merge branch 
'rust-next' of https://github.com/Rust-for-Linux/linux.git
git bisect bad 69759c9d8dd7df716dcca3601b82e5618332cef7
# bad: [1e4eee5176c91b00e73cee90712a995668020a9c] Merge branch 
'mhi-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
git bisect bad 1e4eee5176c91b00e73cee90712a995668020a9c
# bad: [962bc2aae4f4295314d4a5f5c59a465f97f8b59a] Merge branch 
'for-next' of 
git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay.git
git bisect bad 962bc2aae4f4295314d4a5f5c59a465f97f8b59a
# bad: [612fd001319aae2b514fc234939806cf3294dbba] Merge branch 'main' of 
git://git.infradead.org/users/willy/xarray.git
git bisect bad 612fd001319aae2b514fc234939806cf3294dbba
# bad: [f5175dd69428ab517c8d68e772c4d287b6570d8e] dt-bindings: nvmem: 
fixed-cell: increase bits start value to 31
git bisect bad f5175dd69428ab517c8d68e772c4d287b6570d8e
# bad: [8c94337ebbfb840944574f82df0cbe35930d8df8] dt-bindings: nvmem: 
rockchip,otp: Add compatible for RK3576
git bisect bad 8c94337ebbfb840944574f82df0cbe35930d8df8
# bad: [024e21343f3cbcde0343473fcaf094d2c19cc7bf] nvmem: rockchip-otp: 
Move read-offset into variant-data
git bisect bad 024e21343f3cbcde0343473fcaf094d2c19cc7bf
# bad: [3e081aa132bbefe31ac95dd6dfc8d787ffa83d0b] clk: rockchip: rk3576: 
define clk_otp_phy_g
git bisect bad 3e081aa132bbefe31ac95dd6dfc8d787ffa83d0b
# first bad commit: [3e081aa132bbefe31ac95dd6dfc8d787ffa83d0b] clk: 
rockchip: rk3576: define clk_otp_phy_g

On 09/03/25 6:08 pm, Venkat Rao Bagalkote wrote:
> Greetings!!,
>
> I see linux-next-20250307 fails to build on IBM Power9 and Power10 
> servers.
>
>
> Errors:
>
> In file included from ^[[01m^[[K<command-line>^[[m^[[K:
> ^[[01m^[[K./usr/include/cxl/features.h:11:10:^[[m^[[K 
> ^[[01;31m^[[Kfatal error: ^[[m^[[Kuuid/uuid.h: No such file or directory
>    11 | #include ^[[01;31m^[[K<uuid/uuid.h>^[[m^[[K
>       |          ^[[01;31m^[[K^~~~~~~~~~~~~^[[m^[[K
> compilation terminated.
> make[4]: *** [usr/include/Makefile:85: 
> usr/include/cxl/features.hdrtest] Error 1
> make[3]: *** [scripts/Makefile.build:461: usr/include] Error 2
> make[2]: *** [scripts/Makefile.build:461: usr] Error 2
> make[2]: *** Waiting for unfinished jobs....
> arch/powerpc/kernel/switch.o: warning: objtool: .text+0x4: 
> intra_function_call not a direct call
> arch/powerpc/crypto/ghashp8-ppc.o: warning: objtool: .text+0x22c: 
> unannotated intra-function call
> arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: 
> .text+0xe84: intra_function_call not a direct call
> make[1]: *** [/home/linux_src/linux/Makefile:1997: .] Error 2
> make: *** [Makefile:251: __sub-make] Error 2
>
> Please add below tag, if you happen to fix this issue.
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
>
> Regards,
>
> Venkat.
>

