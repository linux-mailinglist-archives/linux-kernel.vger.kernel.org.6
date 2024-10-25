Return-Path: <linux-kernel+bounces-382080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 944A89B08D1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2069B22C97
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301041632D0;
	Fri, 25 Oct 2024 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g4+dJ/Ly";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G1PeO699"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21A570834;
	Fri, 25 Oct 2024 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729871233; cv=fail; b=annxM6RCgXf3dSJLQBGmh8jExbf0TcHARD0/4SSLXujzo5LmWfaI6kDsU65/RYZgnDfXttIURdvZRnM67nK7GxGv2tvPdwLbWmmhEqh0Svjxt7s6M/W12A+/wfiiacA2wnm2ujqdp9vkY7V9Q8cCUKB5Al3I88T0VRkk5T2NwWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729871233; c=relaxed/simple;
	bh=L1bDDi5xQb2n9FiED71lXSv5vcSQNex486f3ir3fzd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gIKgmwz7VrjDKS/MZyIPeIeHAVdf2ji5baBA8FW5gEV8PKpgvoE3WSghuNBHyjPhL5LGKdmPzoJX1igCOtHsl4owuKtEly9wgKfJdjLjIWUs2HPg/so63B0Brj/u8b9sJgOQVHH3dtaG9ymgCNlrO5gkXMsH6/qobInNZUNyr9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g4+dJ/Ly; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G1PeO699; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PFfbLx018454;
	Fri, 25 Oct 2024 15:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4G8RoUqgkf1RlnkAzpc99yQyfnZgXbxtvwAoCnhHYUI=; b=
	g4+dJ/LyDZKN7cJfMjCerZj5L3x6GA82L9c3skIn9kpgnBN7QBNCJK0wWOfOKZwY
	KfyCVBjhMRDp9V51OiCdx8+7h0sUMprGia6/+w5ySFZPkw8+Nq0hhBNOz8X5CUkB
	wFzuY7dGAdL6trPLsvBKgj947wRTa+Q7uzk3G75MeAVIjaJ8+5cqyF22p15g9JvW
	wQSaG09RzIaueoJFsrPP+5q6DS6GVHkbL6579iTjR2dcCL6IBnI2dxvFayE8/pvn
	3Yl86uYnAiKVRfUc/XqmoGD8kVLoQ8H6Fqe/RusP2E7qLB8pKGpciV+fuCa2LiIo
	VZhYgoWlWZSgLVGVAW7s+A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qn8j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 15:47:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PFiMfD021028;
	Fri, 25 Oct 2024 15:47:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhnhm8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 15:47:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NERB2G6csgj86NQnAuxwxwTapYYp5srntFO72nOdxtkSh6ZYdGNVwdpncQs0JW1E2vEUZn2lLvlq3eUVpCzkOvlOh0CEPy9tq8FHLdgihaygtVlzZ62MerJ5+InQ5cdWatl30Kc1A+dmBg44w3wtd8cFIV4b/Pal8ZW9lBcvLJREiBFeV+RSecevUFMJToMEN0mXvJVtwpFnnO+C30+Ejvmn++l+vHixwlU4ttUbioLCFWkMQMBjd7R7fpq5glrGR26vBeedyqKXkYrUjV7TVdk99HaqZu0GOu+iyGjKmP2twccpgAviP7kCPuhAWp4KzLNR6+xOuRTZb5tJTx5vAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4G8RoUqgkf1RlnkAzpc99yQyfnZgXbxtvwAoCnhHYUI=;
 b=jxnNkcGdujA2R8PkJLIDvMp7m0EiXNuS/wuNC/s7IbGTt/cWoJ8IZAyyI5a2qZg6DK7n1t6mXN7qbukr58vLgCtOh0xMcaYiPCxpFVpoTLHpfVpZdRGqugLwSJbQZusZ5BArL2sPmm02a0DRE3LIMZ33YqFCeZkASt54rVQco4676N1IHCoBlZ55Ya3T7y9MOMZFY+X+9SFXntHV5Q1QgHjLpZMz9QxYPVu6gFpFsvu1dXXMo4Khuyp/NUSDHCUkg1yyA7rfXYaZ3jOoK/nATqNT2znHerEKeOA/KMxapPI/nSLL2/LWwlq7JqGIwjqv4Oy/4oIRU6H/QIMEIIJvKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G8RoUqgkf1RlnkAzpc99yQyfnZgXbxtvwAoCnhHYUI=;
 b=G1PeO699ftEGVQUjtv8+gj9puZhUtzVVzoKc4ig5R3cTPYmyyLrzCeX1uerofZejUiRusFekPI7A3FjvvehN3mieYQhTCcRl6bPpOgcS5SA3auCQW/E+1SYJRBoAAiGCYko/xY6szbFWWggTpzm9dAYs/HZJ7SbkxEqz30OQsnQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM6PR10MB4219.namprd10.prod.outlook.com (2603:10b6:5:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 15:46:57 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 15:46:57 +0000
Date: Fri, 25 Oct 2024 16:46:54 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: syzbot <syzbot+0ca979b86eaec7337a89@syzkaller.appspotmail.com>,
        Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        vbabka@suse.cz, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in
 vms_complete_munmap_vmas
Message-ID: <9ebc4798-9889-4245-9cc6-f3192d00cfdc@lucifer.local>
References: <671b7fb2.050a0220.2e773.0000.GAE@google.com>
 <832afb0c-98b7-4d29-8436-1ff6a65133b8@lucifer.local>
 <CAG48ez3c=KS68hnLu26mw2qwkaT8__4cvFw8vdzK=R3QHv7XeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3c=KS68hnLu26mw2qwkaT8__4cvFw8vdzK=R3QHv7XeQ@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0067.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::31) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM6PR10MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: 708acfc2-75a4-4873-ce5c-08dcf50c41cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ems5S2Q5czJkT3NpeXdranNJUnNVOVlMcGV0aVFLelRHUjJVOWJHaVNCYmpy?=
 =?utf-8?B?R0pmKzFxWWVua1JUNHJkbHJhSlhiZ1R4ZHJYcHN1b2Z4bHVTbG1ybVNQMXNE?=
 =?utf-8?B?ZkZXVFFudW52WnRZTkwxZk5OcU9SQXlxZTVET1NSdlBxOHFXeTNJdWIyV0hn?=
 =?utf-8?B?czQrUGE4bDZrdHE4RGZ5K20wdHVvZjZhOFhoNjFXcU9JWnNCaHp3TjR1d0FO?=
 =?utf-8?B?SnV3bWltVzNpUVhsMWp5UmE2cnJBcE9XTEFOckhDSmJKNWU1b0EwWUkzcG93?=
 =?utf-8?B?aUNyZjBxS0pWeDhtc0VXK21sV0d1cHdaQ3RYRFRvZlVyL2tkcWtpWXlxTFBt?=
 =?utf-8?B?RUU0TWpwaW5jUEJ2cHExMnFDWXE5clRtR0hON0MrVEttYzJjdlRiYUFLMDFT?=
 =?utf-8?B?VW1zRk8wSnU0RWxoWUU0Vmt5R3dhK3RicEFsdW5IRXJOR3JJMy9mUTJENkRa?=
 =?utf-8?B?ZmlYbWRGV29YK1htSjF4WEpnREM0YmxvbnovR3JhWXRyRTI1UXZGSlFXdEQr?=
 =?utf-8?B?d0NHbFlzOVRPcTF2TlQyc0VMdk93WXowY3ZaQ3R6NFpUZmRKRWxjUkZrTmZZ?=
 =?utf-8?B?VzdoeExJazBaREhNSzFVaW9pOHdjVWwvK2Mrd3phZzZRajJJc3ROaU40c0Jr?=
 =?utf-8?B?c0prblZDL1pFWEkwbzZVd0lWYlU1NVFjNWp4ZHlzQWZnL2dFeU9mMXFGWFVR?=
 =?utf-8?B?MzFXSlFHSUlqcWlYYWFQbVRUV1NBWmFWTm5XeTJJNDhicTZuWllqTHZtWHFv?=
 =?utf-8?B?Z21GV2VlUjNSMzY1RkRwM3hwU2ZtT25wanBnVk9Kbjk5VElhcnFDZnJKbWV4?=
 =?utf-8?B?UjZwaElrQlJxMUdSWjFrWDZYRmdsN0k2NW5zQzlmdmc0czRZbGx4SFpGVnkx?=
 =?utf-8?B?Qys0ZUtQaldaUXFuZGpWcWpDaUNSWEpMZ0tKRXJ3UGVoRkFGMmlCRXpiZUt4?=
 =?utf-8?B?Y1FUS3NnSzNaTkZMdUdIaXRBR1FiMmdXKzFvTndIOWxtTE9YdTNvdkFmQWxy?=
 =?utf-8?B?cVh0M2d1MTlhY01PaVlsT2Yva3liWnJHMVU4eWRGRUZ3ZkZGVldiUEZra2Rq?=
 =?utf-8?B?TWErT085NzJ6K29RYUtsLzJEUis3Q0tPSTdUMHVYeURmMHpTWEpCWXgvSkFu?=
 =?utf-8?B?WTZpZnlGeEMzYkJIYmtNc1IycjZ6akVkM1dhVjJ0N20rNkcwc0ZUMzNFOWNL?=
 =?utf-8?B?TVZpaFlHWE5CS3hac3UwcWZ1OEdpbElTN2RDU2tVRDBRemdOSXBUamppTVEv?=
 =?utf-8?B?MUNtakdzd25QWFk2SlpCVmg5UHlBQi96b0ZtaGovdkRDT2h3UDZXckFKR1ZP?=
 =?utf-8?B?NjhNRFVNRWZzbWZYZU9lNmZVNFdkeU56MlJLYzhJcUoyUHZoWTZHK3lvUmJC?=
 =?utf-8?B?RGpheUpxdW9Jb1FkYUZ5WUdUVHBraGlrSnRLM0E3SnRqbUFLOEN3SS9vOE9F?=
 =?utf-8?B?QmtFczlUU3FlUURMYzVWWEd6RmVIUGt1bmdqcklYcmFsa0xmSlplTFhnY2pU?=
 =?utf-8?B?TU1FZlJYQUM3a2VTc0pDVmU5aXovVEpDT2thNzJrd2p6KzFWeEIxZ2doZXBr?=
 =?utf-8?B?aUdNdHc1bkZYQXBGWEFLRDJGQ25vWFBJRWExVU5WZWo2S09tY0ZIclBLMERE?=
 =?utf-8?B?SVlqQTd1V1pDam94QVNNSDdXNStseWNtL2VJQ0labTdJYmJMQmowTUJzUFdp?=
 =?utf-8?B?ZGlZN3N0Vm5MT25uWXN6V3JaZndRMkVGMGs4L2VyNVZ6SHEwZGZWdWJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RktjWlY0VmYwaXkxNGE1SmFoNWxYbmUxV1pDOWtlNWxTMElzTTdaeU5qZnJW?=
 =?utf-8?B?R3d5ck9zeG1PUUZ3eXBFREtGaUs4WTR0Z0IzZUVwdy9pNUFFRjlOcVMzQmRP?=
 =?utf-8?B?U1prSzJUbTgzUHVQdXNHQUJJYzBmUjZpS0lXNXZyNzJ6SFBmaEVFbHFUZzkx?=
 =?utf-8?B?bStnNU5zSjl5QWwxekFqay82RlgzSEFVUXlTNTJMd0lsd29qVXlXdTlNMHdS?=
 =?utf-8?B?Y3h0aGZCc05vM3VnQTAvSFU0NnVoMjhmcDFucUxPczBSeTY4MUttaGRFRUlG?=
 =?utf-8?B?eEdZeUhIL0prMzlNZHRqakd1aUR2Q1UwMkxFdVJQSWMzSkViU1A4aFlrdkFo?=
 =?utf-8?B?S1RIZm40L1YzK0Fxak5GcWl2Ymg3UFRyVm9YM0lXaGlhVTJ2NmtlM3g4ek54?=
 =?utf-8?B?QlF1Q1BCVTVIeE1nbkFqdkJrTDZqQjdWNnlpQjN6dm1tOXE1TEp0QjYxZ2tR?=
 =?utf-8?B?UGxzWDlFY2p5S3d5V05yODVyMFQvY1FmRVEyZzc1RmU1QnpDZThIWDNrdWtO?=
 =?utf-8?B?UlJWd0pDcDJPbUNzUG9KdWkvMnNsNFVpeFRmY1IrVmxxcjJjd0hqcm5tTnhQ?=
 =?utf-8?B?TUFFTExtZThwb25vR3RnQTRvMEs0VTVQUVo5WG00QzNrWldBblpJVmxCZmRG?=
 =?utf-8?B?dnhDTTh6ZG8raEZzOFo5bU9GMWhZZFpFMXFtRzdYWVM4dzlMOEE0TUpkZEQv?=
 =?utf-8?B?L202bENDc0ZEa3lnNlYyWXpsdnhxc1BRVWI5RUNYejNidlZKcnpnUHZXZkFs?=
 =?utf-8?B?ZUh0YXdLKzJyNUtxVG5JOFdMSFBOT1VuWks5NWxsaCs3YlhTUkpudGJkNTBX?=
 =?utf-8?B?bW1pUGFTdmlsUENMZTBFQUFXUHBreHdNRStqWk90WkFRUHFzdkFielNxQ3JM?=
 =?utf-8?B?SjB5S1ZMNmxLUjU1MlhSNmNQU1g0TzRSR01VNGlOdW1YcGxqVWlaWWFJVkxt?=
 =?utf-8?B?bktkSktBK0hHYUl4ZHVLMVV3UWVGNndmMmVXUk53Tkp2bXJSVlJ5ZXBtVXJi?=
 =?utf-8?B?L3h6akRtcW5keGZYU3puaWYxWmh0Z2g2ZzExT3RrQVZ3NkhKTXNtdnROdTVV?=
 =?utf-8?B?aXQwTGZqYUFCTGtubDFEYmJPM21YbDBKSHZDdFFrbXhwQ0RiUjBLOWJ6VUR0?=
 =?utf-8?B?SU5wMGE0eXBJZGVzcGZyYVdNN2pLT25EZXJ6NElZOVFoLzBNTUNEaWR4clM0?=
 =?utf-8?B?ZzFXeG1UNXUyUy9pbzA2QjV6cDB2REpUZE1wN2d5UVR3cEpadWQvN1NUUVlQ?=
 =?utf-8?B?UTFBNnV1b2F4WkwvdElsTlAreFZ5VUZFSUZiT3dqbVVnRVdGaVhlUzlrSVlU?=
 =?utf-8?B?eFZqdkxReVV5c0I0NThGUTR4aTBjVmwyMzNrYXdVemh3aGxrTGlKWmE2NTBV?=
 =?utf-8?B?VXpzRDNBZ0NkVFh5NUl2QmpSc1JXNXJmd3dPWS95K2VaT2tVVHB1ZDlNVzBo?=
 =?utf-8?B?b0NzdXB0a0tOMmJKK3ZNT2hMODJIN2s3SzJwVXZGT1dFSWVwa3FIWEptYzhW?=
 =?utf-8?B?U2FxMHJUV0FZckY2eEVFMTBnNjRaQXg3MmRrWUI2MFlGajJieHJpQkVPNEN6?=
 =?utf-8?B?RWFGNTlrQ1NOWWpHbHBiUjFPZGFUMmRkSHJ0R3BDS0ZvSyt6c3dZa1NxcWlN?=
 =?utf-8?B?ZkdzYkxmK096VmtWbTE0YS9QUGcrallHdkVJTWIyY0hnZXRsNkVNdGdESmpU?=
 =?utf-8?B?NjRMSW5YM3J5M3pyblRPOElMZzUzK3dZQVlsVWQ4cWd0b1JIYTRUYmdvcTdB?=
 =?utf-8?B?bkJ4eldTd0tFRGdLUkdnVVdHTWplOS9tTjJTckxNZkEyejVMdGNORjdSVGZk?=
 =?utf-8?B?czZ2L3RkWGN4NmZBUW40TnJpc0ZQOXlJZHc0RytvUkZsbURNaEQycm9hdnlp?=
 =?utf-8?B?dlZhZ0VDRVNHZ0FmbnoxNDlPUVlDN0ZDdi9VUlFLbWpVL3g4ajhGYzVzYkZ2?=
 =?utf-8?B?cUVsVzQ5TUFEeUd4V1RiekdJRjBjZWlFdXBoWlRsV2NzTUxuT0xJbjVvWGxK?=
 =?utf-8?B?VzFpVmQwMUJQQmttaThjSSt2THlZSFZIYnYyV05OS0dKWjhzcExZRStSSVY5?=
 =?utf-8?B?RzNOZFVDZzlUQ0pwRzhBTzRUNUd4dU1FL3hYTXhmVEltampFdWc1aDNJL3Nh?=
 =?utf-8?B?M2xYZEtWcGcxdG1YTUFIL0NOcTMwaU1SWkpZcEE0NGhDZ2JnWUNiNG10VENJ?=
 =?utf-8?B?TENTS25PWmhUK0VjQUtqZE52YnpINXp6NGVnaktTVFMvY1MyNm9hMHF3SDU2?=
 =?utf-8?B?MmxoSUNjL1BpRnROMWsrTEcxenJnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c5Y2FEhFpjgfRqBN59Me/F3QVUNUN8vFttSl3Cy8HgXvgU4yV3FGJoxZNKWO8TKhEgd0ODV4p29irb/03W/5QbIBQmhKIAY5IdyBMFkIBn4N0W+82QJfR784+4myEvSAYHaMwW9JAE1BzADHrwLlwmOAreyLuu7GUKaXpdEMfFX56dkPQRn8GUDNrwiNqiu4IBJgq7XPYSR/Ac9YD8xelOx18t5HLi01jloiWim5Mp9d0j0hlEwBEVZ3fxA9KS7J11/Bj8OkakEzW7V61JmkLmVVqqLwdE4k6YUD68pHgytOyzPHRJujYaCCbhRg84OErYI+48SUXahKlD5DuLTXXSGQgnwwxvNViRa5wwercUnTwwucXAkSeJ5VGLJJJ7tsNMuxKQHHvJEL/VM0HiqEzgY9EAfpSoQExPMXjoOY2oBvA2uIIr8yHu8332Mgp4TS238heFafI+msl47QD4C9FTrB5lm9bT0CVrWOpcJUpKYrd+Hx9Vh5BzCdhMOvFvW1+Jw2KddZObFRucM0TRAx1pmTLA17nlbD2bN3V11TbSe8DmxGraIG11oiWcOzUCfRCxsHPhwJdFhaICiYxPX+ypr0TGtRyNcW/iVc/wrH4jU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708acfc2-75a4-4873-ce5c-08dcf50c41cb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 15:46:57.4525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6o5SfhRIKceRs/TuyJ9q6U8+Rm8di06YXuq2v3ACEzxvYEtDlDFfhhG4qdrE6+QpWZ0O+x5j2HNksNsBMfCG5Gt/rnSQyc/ltmhcIPWd9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4219
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250122
X-Proofpoint-ORIG-GUID: Q48KCW0u5nQB4bfN1rj-okCZ1pyjHIV2
X-Proofpoint-GUID: Q48KCW0u5nQB4bfN1rj-okCZ1pyjHIV2

On Fri, Oct 25, 2024 at 05:20:52PM +0200, Jann Horn wrote:
> On Fri, Oct 25, 2024 at 1:37 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Fri, Oct 25, 2024 at 04:23:30AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    c6d9e43954bf Merge 6.12-rc4 into usb-next
> > > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=139f225f980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=4a2bb21f91d75c65
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=0ca979b86eaec7337a89
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179f225f980000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/3bf4a453ec2f/disk-c6d9e439.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/e4a2db2a5d95/vmlinux-c6d9e439.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/8eb8e481b288/bzImage-c6d9e439.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+0ca979b86eaec7337a89@syzkaller.appspotmail.com
> > >
> >
> > Isn't this just the same thing as [0]?
> >
> > Again I think we're just happening to hit a stall in the unmap logic rather than
> > this being an mm thing.
> >
> > We retried that one a few times and it didn't hit any mm code after the
> > first time.
>
> Random side comment: It would be nice if the kernel was able to report
> hangs in two steps; somehow scan and mark the stack in a first pass,
> then wait another minute or so, then scan the stack again to see which
> functions we haven't returned out of within that minute, or something
> along those lines...

Yeah that'd be nice!

You'd get more information that way, though of course one stalled task might
hold a lock another actually in theory unstalled task might need thus
deadlocking it... :)

But at least you'd see that, and the lock splat there helps obviously.

