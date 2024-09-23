Return-Path: <linux-kernel+bounces-335460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5393297E60F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138902810B2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E579179BF;
	Mon, 23 Sep 2024 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lqTBEH4u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uAt8e0yr"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E61C1FBA
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727073349; cv=fail; b=O4D0ccfKT7wRP5BJtvH7iQGxwz3C7muSnNimrmew1xw8d6chUn8PofP4iJLgQwYRrlGslKdFdlp+gq/ggHLrNLUuoBZsnXm8MH5KCOOMN653h2DKDMo7hRQsiWly5ym2nQa0FwjB86IHDZLVeXzGgttJ9jd9at0wcCbhfh/3pFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727073349; c=relaxed/simple;
	bh=j4H7F1avzfUaI4tsSjcAF7ohBgGq3CNDPrWgVFKIPiE=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=gxaByVpIahopfEA3Qw7MrNANoxeNUgX0MgWHtr/KpuDmoonPza88U/xwUzrHqpN42Kyn1gEXagxCHT1kx4yL/aDCvelvdVVRmVKBy00b7zVjA1MlrsLM+x9++Ssjmh0T13lfVRk0tF3LeOuHryAvz+xtyFciiYUpTM7oItJx5gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lqTBEH4u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uAt8e0yr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48MNiat7030462;
	Mon, 23 Sep 2024 06:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	references:from:to:cc:subject:in-reply-to:date:message-id
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=vf4xeVUMGTbqCf15Y27Som/T8hGNDYJStlSvChkDdWs=; b=
	lqTBEH4uvgQ7hi0TzbYhiQi+ES4bvg3DQE/9BA7olc7REru2I69rxNMqlD7j7O31
	xLZna/agjl06q2uRNn7mA414bBrBeOmL7tGA4btu0u0iSWsGKmGKHyMwvcjk08i6
	tL8+u0XU8LbxKvhrOlV9qvw+R513mZrfA66bBCADTYKzjudQs9nECQXG+6Eyuga6
	LhQ/itxtRi7RlnNaYIGp3b4/8cXJXyb3VJnZF+n8skken6HQdnqt4aHNvtmNE1eA
	XPrXQMps1gxk5vqrfj3tUUavyF9xX798E5S+aqe1ISstaQykZtmm7+2sVPub/3Fi
	Yp7/Lu8i3Tlc5BiBr93ASA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41snrt1bjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 06:35:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48N5PIIv038771;
	Mon, 23 Sep 2024 06:35:15 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41tkc3yqc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 06:35:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQ3ul1E+WNaBWfE9kfs5xX+P7mDh3iVN2YrjZmlB+BYzuTTIG82SGqjq4SWBQObr2HzjoGO76IlIP9Zqvlc4Y7uej5NXRtub4GavMHDHks9AmIhJBL4I/h8QksIGzR+xAdmHm1jjY9Qr1yGPKfOv8B68whLI2jTx1ngh7jZmdF4MgfgGvq8ZqpZx+hQXpQYHSFoGUN2fuNM3AQHu3+7G4kM8xmJbcsEEQcbFCiVbrMZWDEWarih6GB4wf6PQeucsC+PywQSQX8bIOcfCoRhtSlUMjeX9+IstVd+wx/Uvb1LjVVNq0PAlsSHLZzgDplmnAC2N7zHlXON/pcm24YJMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vf4xeVUMGTbqCf15Y27Som/T8hGNDYJStlSvChkDdWs=;
 b=ZQ5mgDVd071S+mN3uxPmUs0A2SRgUgv2cn1j+zywhJpgGRjLKTBfiTObh/VGjrqgfgHZErQF6MKcPn6eEzn6FJ/NQ7wggpE4FXC350Z9d1vl6dXumWSSACWuSquLhNHhdxc/wbO01TN4A1lIB8zm1k/QO6e4O6lezg8sGbEQ9uXVc+s38RVrDoNBuZzbZ6NlnN8FpSLudxJ33DVKmZ2YYuQOE0vsN6BoBtXtMA8JSDJcVC/rbJuGHP8FFkmZ6z/50GThwNa2kyjGyYqx2MMOibM8k8s22ZmnY58sBQu9RCVzr1gNtma/XaU5qGq9EopH6JWQwPE6AudCRhEM+YPj6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf4xeVUMGTbqCf15Y27Som/T8hGNDYJStlSvChkDdWs=;
 b=uAt8e0yr8o6WngHdiWtij45w08zz2CBo+My9mqMN/JcATk1c5wC6BaxnM2QPLdUX4eevyxzHIE7RsXKNMKcCIYqxMsO8rHWC39W7l22RIkhUEji3XYU8MgyvuUF9VCd2rJUR4dGYA4oUzzEghF72ax8SN+rNkMDxEeGH9Zbc8Ck=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA2PR10MB4492.namprd10.prod.outlook.com (2603:10b6:806:11f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Mon, 23 Sep
 2024 06:35:13 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 06:35:13 +0000
References: <87ikurhvf1.fsf@oracle.com>
 <LV3P223MB1042D6E8F26C131780375218F76C2@LV3P223MB1042.NAMP223.PROD.OUTLOOK.COM>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Steven Davis <goldside000@outlook.com>
Cc: akpm@linux-foundation.org, frederic@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de
Subject: Re: [PATCH] irq_work: Replace wait loop with rcuwait_wait_event
In-reply-to: <LV3P223MB1042D6E8F26C131780375218F76C2@LV3P223MB1042.NAMP223.PROD.OUTLOOK.COM>
Date: Sun, 22 Sep 2024 23:35:11 -0700
Message-ID: <87a5fyj2sg.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA2PR10MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f4abf8-8eb5-428e-a5bf-08dcdb99e12e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXdISnBrTW9YcjNJNmw2Q2oyb0RkSDBIaklwL2NJaGp2T2wrSGFxZmJkVmhW?=
 =?utf-8?B?Rk9jczZOdmtMT2RwQm44WEtIdFN5SkZyekFXdEFjRGM2NGU1cjNsVzRpVmlD?=
 =?utf-8?B?cms1cHJxYXYwREFTMUpjTzdZaHhHaU1hSXlPS3VXakF0KzF4Z3FhZW5QaytZ?=
 =?utf-8?B?c3ZlaFY3YWxFUThPV2orVDc5YzMvUlBOU0s5VXhralphYXAvUmRsdHpFcnlt?=
 =?utf-8?B?VXZNUnpoNURTNENwaE1QbFdzSm9id3hRMVRYYTRINEtvL3VScE1abm5ScE96?=
 =?utf-8?B?NzhxdjA1bUE1bWppcUJaZTRYVFZvQjM5L0F1T28zbWJxUTJXZXZLTUxHZXgv?=
 =?utf-8?B?S0wyUnFRc3JaeVFqRi9oWCthM3AxZHU0QXpsb05TYmpvZmxpc2lsYnU1dk5v?=
 =?utf-8?B?Y05oakpReUxFeFlDTms4T3UwY0UxMHRTTXVXd28zLzg5bll0M1EzaG5IWDE1?=
 =?utf-8?B?ZGZHUEducnd0VTlxTnRWWGJxVnNMa3BGN2xQVmtGV2pPdzUwYnROd05XaXBQ?=
 =?utf-8?B?dkNpQm5lNzdFTVJoa0ZDYXVJZWdTb1NTeXRuU1lGYVE3TmNYWENGQmNlUHow?=
 =?utf-8?B?dnVnV3JVbEdub2xyRGFFdU9JTy95OVFpMFNIQ1BJZzdKalVLYk9yeWFRMnU0?=
 =?utf-8?B?c2VkUEJzVWpicnZWMUgrTSt6QXl4Y0JUZ2xoN2Q4ekhnNmdPbjF6MlhMNFRI?=
 =?utf-8?B?K2tWczExbi9od3R5RjhzektuTGhpQzlnTjdYS1AzNHI5aHFuU2Z4RjBGQnNN?=
 =?utf-8?B?VXNUbmVvU3Avb2l5b2hJK1FKanRZajZ2d3ZVNnk1OXZTQTZET2JLeDlhMUNG?=
 =?utf-8?B?Qm10RUNWWXZReGdRNEhScXNZbDYwMUErSGlXWjgyM3JiVm43TU5jdXhmQndC?=
 =?utf-8?B?VDl0V01DYVJuZGhCeTFUc3JVK0VTbStQMENEeEdkZ0xlaWZPdFI5L3c5RzZC?=
 =?utf-8?B?NVhEVFd6VHZGSnNvcnppSzVwTW9UYnVyczdjK3J3UklabjVSOTl0cDNXbnhv?=
 =?utf-8?B?Wmxtbm1QMktsQXQ4RWZ1U3NLdGVlS1pHSUNycVl6aGhic00waHJXa1V2YUxC?=
 =?utf-8?B?MUt5cnFFd2hBYWhDSy9uYTFqMDFrbkg5UzIzNk9YMC9hMjEvNDJtT3kyMUhK?=
 =?utf-8?B?RlBDdG1Ua1BlZlBRYkVZMWhIYTgxbCtZKzNyeHMzaXVRcDZpZnBrakNoRHhr?=
 =?utf-8?B?aXdwNmxPTWY2b1ZjdmxGc3UyUERhY3hveS9OWDUvaFRmUElHRzFBL3pLQzMr?=
 =?utf-8?B?RHJoVTExc2xpMTRrekk0c0lPRHJ4OWFGOWpzWGRsNDFsYVlrcEFZZ0NSZDFx?=
 =?utf-8?B?eTFZNmo0TnIxY2hqUmZmRDVQTEs2SUFOcE16eGZuRFExYlRsR3F3RThTM3Jw?=
 =?utf-8?B?djUyZW1uc0ovZHhDRHpjNExJektPQUp3WDVsWXRlRXB3SUNHRVFZa2o4aXpa?=
 =?utf-8?B?bFZGb29ISVNJQlNPZ2RPaGlFOGJSOUFkblZMckNQMUp6VlBnU016aG8wdFlB?=
 =?utf-8?B?aExXUTF1bnM0cDJWK0dHVk1ab3d1MGF1enh5TjltSUhvTFlrcVJ0OTU2Vkg2?=
 =?utf-8?B?S0tvelBHZi9aaHl1cVBHZm9RZXZoT05FRWlXRytGSjVEdWVWK1ZJa2M2OFh3?=
 =?utf-8?B?MDg0Nk5DcjB4ZktNYkFwZHdBdWo3M1Ezc01SekJtVGFoNW4yajRDSzNiM1o2?=
 =?utf-8?B?cjIvMHlMVzRXN2RNaitiVHV5V21RcUVtZGM0Z05QbityMUM3cEJ3NUxDQ3RX?=
 =?utf-8?B?em9JR25rUGNFYXBtRDBFYmgwejA5T0todnQ2cndad0FNMzVsZFpFTjRiSXVk?=
 =?utf-8?B?dlcwcGJjeXlVaDN4aVlhZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGcyajJjeTBZaUdZNmc2QnVYWWw1UkFzYVZtaDFwUEJkaTdXWDFET3ViOUJZ?=
 =?utf-8?B?bHV2Y28ranhUcDAyNzMxYThzUXI3aHNkTUFSS3ZkdWJwV0NyamRoVUZUOTRs?=
 =?utf-8?B?Yk9jNkJnOHl5cWw4cGJ0VDltQnZhQzRQc2xlNjlvTnhzcmgzVmFtUWVqQTNZ?=
 =?utf-8?B?RmxPSEtPWVRVVG1lQjFpMmxNbUh2QVNIbUJaYlYrbEl6Z0UrRmNlQktCWWJq?=
 =?utf-8?B?ZTdWMDFpOGxDWElCOFlpeGQ4Z0RpcHNFOWk4d2FKMUFqeUdEaDhEeGh4YzIy?=
 =?utf-8?B?WTlYVktHSkFmQmw1eGhSWjNBc1QvMU81MEFWa1p6NmpkYkhoa1FLQTNsekdh?=
 =?utf-8?B?bDBVaUpQTVZwdm96YmpEU3hNL1l2djJrZ2E0TWhYVkEwVENWdHlaR09Nd3N1?=
 =?utf-8?B?dGN2WEVpVHBzcThoYmw2R251Vmt0M25ub29hQndxLy9tNjFZVkd4ODh4UDlU?=
 =?utf-8?B?ZUZnRmcwVk5MTWtCZTNWWlRVQnNHUHVZZUJUYndkRWU5ZTZHTERXT0xmQUsv?=
 =?utf-8?B?a3N5cnpyeTlPQTlYYU9KN2M5Tkl4dHJIRGRMcnRnTHEydjVvQzNBdjI2M1Qz?=
 =?utf-8?B?Z0lWMGh2Z2hTZ0pBemRUZ3ZNYUNaQmlOOG1pN1FHelFyR3dmTmFMaTllQkF3?=
 =?utf-8?B?RGFHVWtUcm9jdVhrd205WlpqOVF5RGZ4UVNjdDJsTzdpUDFERDBGN0EvZDBO?=
 =?utf-8?B?SHY5T0VWRmlrOHJlTnN0Z3g2QUVMMitUdUJEcUwyQTBUa2ZMNUpqVkJ3UzhT?=
 =?utf-8?B?RzFPdkdocitxdVlUR05INVl2ZlRBeXpwZDJQNFBYMXdDYmVCRmN4UXA4SjlV?=
 =?utf-8?B?UnZZTVhUMm1iTFZ1MHAycmUyT2FhZXVzQ0NES0tNbzhoRk9XTXdYdGJOZUVh?=
 =?utf-8?B?cGVNb08yVHp6cmVtd1Z4MFZnRUsrUERDc3VBUkJ1YU9DZ3ZyWHpKVWpOT0Jt?=
 =?utf-8?B?akNvaDRPODJFR1hzZUNyYS8zeSs4aUZKVWdUb1JnazRBQTNwN0FkS3RnM0pu?=
 =?utf-8?B?c0ZkVVlaVzNDd3pOZUVORms2MkswaG5aTXdNOVdKKzNpT3J5aTIwSE12UkF3?=
 =?utf-8?B?UE01U3dvS1pQMjRYVG1kMTQyeThyTE1LZ2FOQTJvRE1XVWJDV2FvTmR5ZzBW?=
 =?utf-8?B?czdpRmVzTXphNkx3UlRiWTA1MDgveVdqdDhJSGJDajZyWktuL0w1bW1HcHp0?=
 =?utf-8?B?VVkxM3Z0cDFZZWI5Z1VnTHd2UUlhcmNRWFp5eFV2ZzVhcE8vZWNSckQrekMv?=
 =?utf-8?B?NHJ0Rlp2QnVxczhSckVpb0k4NDRtWVFBbUdiL21WcjRQTW1TdlRUNzhPa1ZJ?=
 =?utf-8?B?L0pPTW9VWHVWRUxNTW9jSWZrQ2Z1OGJsbER1K1VPUzlYOWp3enMrRnNOMklS?=
 =?utf-8?B?emxpU244a2hYZFRPU0VyK1kxb2RHdmRzS2tySG9CVGs5VE41VWJjUUJEeW9n?=
 =?utf-8?B?WUl1YmI1Y1dhTWRibVB1bnN4ZC8vK2pXRDBPWFNQSFhIRXBxTHF3UEkrL2M0?=
 =?utf-8?B?a2YwcjM3SnBPQkpIOEhsVEM4V1RPRXMzN3hmSE5CWStRTzEyV1d3amZ1MmJS?=
 =?utf-8?B?bXQrY093U0MxYlNwUGlCTWdMQS9hZHVZejNMQTdlU2M5TkFxNUJLWHlic0hG?=
 =?utf-8?B?Z3ZISnd0NUxTVS9DcllQSnJQM1dZSkZCUGxYV2tzRHVSQ1hWbHVIU3Z0UUx2?=
 =?utf-8?B?WVZWWHlrSmd4ODRRUC9jcCtpRDBUOXczRTNhRWRyNFM0WTJjdzJrK21Nb3N6?=
 =?utf-8?B?cUpRQmZ4WDMwMTIrVWl2VXk4TkZveFgwUkpLQ2RnODdzOWp3SjByTGJCQkpx?=
 =?utf-8?B?WFNuTEJmRWQ1UTEwakRrS0RHMms5VmZVT1dFeDEzakwweUUzdjFZUXpJOElG?=
 =?utf-8?B?MmpkcTNGVFEvVlk3bXptZ2kvQ2VmRzJHWHdWTEtZWEtwMGcyYnFMUWsvU09W?=
 =?utf-8?B?eGxXOGlLcmcwRi8yeVNmRWpyME5hdndud01hQkdHWlVzZHZ6bHNaUDg4K0tO?=
 =?utf-8?B?cmdnZVFKQ1BSR0daVnk4azljdkxRcmhlSjIrajJjekFyVnNYMUZ1ZkRxc29I?=
 =?utf-8?B?N2xXN25McmNPK1F4c0VSNmFZUHNLVHdkV1lSVWNFSlI5RUtSZjBTMFlrOFNS?=
 =?utf-8?Q?sgr44xqTES9I98Het8l9S7lnq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y7YzXLQw6WJDZH6JZ2Ot4o0LNp1y9MFrmOj9Dt3H5O/tMgmtRooYSif/TBZ2oG58TqKPytISYPXLTegFQ8fUhWU9zijrpEDZn0VI13gjyQP0uQqKK6qpmkatK4o5Ry4elOkqhaYRXUBO6zEUz1Lp+Ao04WZjqjo41+Ef4mClY4D9bEwFO/i8wdeavQZ8bbJH64AlvmetjwGaOLGMIxgUPFvQB3Oxa2hb/yMQ2H0EPGd5j8mCWSJnWT8oInFOfpKyLuiIwWh0H7Fx50iQ5r/tfxYdOTUIfIQnE2Kb6BxGUmJs8cnCfh9ViVhQWQXbVLvbO3EzFMUT4xRmlJH2H6dYzMT2SGGD/yt9cf2lGtxXcDLdo2klVrgrVEjqUx+h+leqzrAh4xjGPJ5JE+k3rAMc+D/RArBkv331z0J7SzWebP4/wCtexzH1a+Kv4A21KCOZYMWRbpQUDa92LBGR8q/Oru109WDAgvOQH1wwfY1KuzpoRequKprDZYOf1Wi0RpGk1hjnXjMO/YfB/NYZyoOZFn+1R4o6xNMbo9tuARNM4IPh5VGG06n6eqwIXfgFg9IBdAKgD/WHjCkh/f7QoeXqYTQiUUlCetYhAJneYx8lMrM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f4abf8-8eb5-428e-a5bf-08dcdb99e12e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 06:35:13.7857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOyL5mOSY5ofeUHEqaitJYR2AssGif+SfyhgsL2Zl1fW86q9S5rLU3LSSWBMXcyTR247C1lx/iqCvNmlyF89IjwGK7AqRuYReCefTcejSQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4492
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_03,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=430
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409230046
X-Proofpoint-GUID: DrLara-3WgVylfo4lYG-ujfI7ccSV4Tj
X-Proofpoint-ORIG-GUID: DrLara-3WgVylfo4lYG-ujfI7ccSV4Tj


Steven Davis <goldside000@outlook.com> writes:

> On Thu, 19 Sep 2024 at 20:10:42 -0700, Ankur Arora wrote:
>> Frederic Weisbecker <frederic@kernel.org> writes:
>>
>>> Le Thu, Sep 19, 2024 at 11:43:26AM -0400, Steven Davis a =C3=A9crit :
>>>> The previous implementation of irq_work_sync used a busy-wait
>>>> loop with cpu_relax() to check the status of IRQ work. This
>>>> approach, while functional, could lead to inefficiencies in
>>>> CPU usage.
>>>>
>>>> This commit replaces the busy-wait loop with the rcuwait_wait_event
>>>> mechanism. This change leverages the RCU wait mechanism to handle
>>>> waiting for IRQ work completion more efficiently, improving CPU
>>>> responsiveness and reducing unnecessary CPU usage.
>>>>
>>>> Signed-off-by: Steven Davis <goldside000@outlook.com>
>>>> ---
>>>>  kernel/irq_work.c | 3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
>>>> index 2f4fb336dda1..2b092a1d07a9 100644
>>>> --- a/kernel/irq_work.c
>>>> +++ b/kernel/irq_work.c
>>>> @@ -295,8 +295,7 @@ void irq_work_sync(struct irq_work *work)
>>>>  		return;
>>>>  	}
>>>>
>>>> -	while (irq_work_is_busy(work))
>>>> -		cpu_relax();
>>>> +	rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work), TASK_UNI=
NTERRUPTIBLE);
>>>
>>> Dan Carpenter brought to my attention this a few weeks ago for another =
problem.:
>>>
>>> perf_remove_from_context() <- disables preempt
>>> __perf_event_exit_context() <- disables preempt
>>> -> __perf_remove_from_context()
>>>    -> perf_group_detach()
>>>       -> perf_put_aux_event()
>>>          -> put_event()
>>>             -> _free_event()
>>>                -> irq_work_sync()
>>
>> irq_work_sync() is also annotated with might_sleep() (probably how Dan
>> saw it) so in principle the rcuwait_wait_event() isn't wrong there.
>
> The might_sleep() annotation does seem to indicate a preempt context.

Yeah, and that is one of the problems with might_sleep(), cond_resched()
etc. They can get out of sync with the surrounding code or code paths.

In this case, this could might mean that maybe the annotation is wrong
and should be removed. So, it might be worth looking at the calling
paths a bit closer to see if calling schedule() is really safe in all
of these contexts.

And, if all the other contexts are safe, then it would be a good idea
to fix the perf_remove_from_context() since with this patch, we might
end up scheduling in spinlock context.

--
ankur

