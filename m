Return-Path: <linux-kernel+bounces-271829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BBA9453A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270D11C232A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5975128379;
	Thu,  1 Aug 2024 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IoSuaIty";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zuuLmU1v"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFFC14AD3B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 20:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722543309; cv=fail; b=BIyxmeBbeBmg/4hBTU3Sq1XTvoktExnFBRv+9TiEpxldY9D3TeFubL/J6FMd7AAv5LHcsoeSeMx0V9VWFQjnoaMDb1Zn3E/SNn8sFQRO+9s4AThf7KAFTcxqei2yzk5vB/FntzoaOijk3TXbYiwKbiLIqFhJi27eoLAp2o5Xc8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722543309; c=relaxed/simple;
	bh=X/xPazs+85rrrZQ37FN8lO1oUQ/YKktCnB8Ddn+LOTQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HV8BaLViwl2AgK7lFv0gl+jDDqONIOWEimk95L2MbhQhgaJ4AIVdKqITOm59mVoolZBlo/EfZ/67oHWruyuL5v32HRcLRYaClGz/gZK6Jds3sM5c1jR0KlVcQy5vygC4KgKwES9VliI+k96fvjNnlnElfUA90dPlvZlINC0ahxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IoSuaIty; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zuuLmU1v; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471JfW9w029890;
	Thu, 1 Aug 2024 20:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=X/xPazs+85rrrZQ37FN8lO1oUQ/YKktCnB8Ddn+LO
	TQ=; b=IoSuaIty1QiBR6Ccq9ws69+ogsTcIMjjXc01kY9gYiXU9rM0ySu9Mcip0
	s8SVUns0e6APUAkWMsaVVseH8msqJkEjN7ham4Pkwby1hxIcEXLGlTSjfV0WwE/d
	4jO/6s669hMpOX7i9lcjxlrgGpIGSke5Fgudvp8fp86x3bbTkj7q3T2RT50Rks+D
	RSZYO8KAUyxiHLm9TSPD6KcLtq6AQH3WUF1rF450ZMU3SJMgTpD07G2MPdDCxb5+
	AvNOSstr+GNLyz+UxfS3/R1PRcscESLV131k4vIz/aCLdB60BVmhylsvCWSfXOWk
	hVrnPCEcNAOt0ayI93Hp1nUur4Iiw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40msestmyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 20:14:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 471JlHav035611;
	Thu, 1 Aug 2024 20:14:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvp0qap0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 20:14:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHdxtnbdsET3HX9ArzYT9BaRbtkJtTcN4Ml9w+9v5wQrLp01txov3oFsZ7UykMvcVlgGl7RAw0+pFtF101N5jiom4TiW4DfRnILYiIMBCVSyGqc1GX+YS/DgibF5mba0H6X85rZQNWMlQjJWBoRimui22aG4aKNLsUNkSu7A2IIdAVQ2tqlOCbcpQfiGRmf4VRx0BM5dhhgvLLnYwIoqJfLBqHm6y9RF5NoaFEKos5IVjgRgiRKnkbqatfw6EdFncJ+sUImc4OAjWw4evAxMvSU2OiNHVFOyGmzxGVOoaIL43vv+Z4B/ODwdNFnJiOTIpkEE2C9MhLrR+n9XABBhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/xPazs+85rrrZQ37FN8lO1oUQ/YKktCnB8Ddn+LOTQ=;
 b=eUin7M/V1XcrtTP+oI0QzXv4rBq5DUbHQt+J0vOx5z5pmOMSL/xVYsn6uoWK0F6FSWzT3vkkLkp+ULd49O334uGOPLZi3rN2SHKCrrwNqhVMH9mkh7MnfStOPJAQxS+YntOD1ER5L5FkmowMPtG80+KoQqMrkWK7nQmQUOkgn1Ng5jG0PL+8DrMdsiawIICWkD8vEiRXK3IrV9zDaeCVjHg5bOV6naDZhka4XGJySA1+wsWSdxRg0hcKcbS9hHEu9hjmOfm9FGxmjjdHnK4tJXmK4BchYnl6HFZ+SRpn3SLaDXylYTAXsW6yjxtMympbqRxER7zuq5ygz50R9T2Dpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/xPazs+85rrrZQ37FN8lO1oUQ/YKktCnB8Ddn+LOTQ=;
 b=zuuLmU1vX4PLPW+kYaNY4gXdB+aCo/m2r5Le4wN1eqA5T2XY66m5JQymqamgWvvVdVTC/yj92TajCMZCNkypyfVlnmIsU9q6h6yusWI8HepC/Y/Mldf+PgEQ/goUfzBS+y2nX0pX9VKGIMATyGduWbz66mh7i9NLtpU0tcu4bzw=
Received: from CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7)
 by IA3PR10MB8065.namprd10.prod.outlook.com (2603:10b6:208:50f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 20:14:29 +0000
Received: from CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199]) by CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 20:14:29 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Keith Lucas
	<keith.lucas@oracle.com>, Jeff Xu <jeffxu@chromium.org>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        Jorge Lucangeli
 Obes <jorgelo@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        "sroettger@google.com" <sroettger@google.com>,
        "jannh@google.com"
	<jannh@google.com>
Subject: Re: [PATCH  v7 2/5] x86/pkeys: Add helper functions to update PKRU on
 the sigframe
Thread-Topic: [PATCH  v7 2/5] x86/pkeys: Add helper functions to update PKRU
 on the sigframe
Thread-Index: AQHa4983rBfTLdtqEE6owYveMaxx07ISGe6AgAC9FwA=
Date: Thu, 1 Aug 2024 20:14:29 +0000
Message-ID: <BB4AA839-1CF6-4C48-B3ED-24F9E425837D@oracle.com>
References: <20240801065116.2088582-1-aruna.ramakrishna@oracle.com>
 <20240801065116.2088582-3-aruna.ramakrishna@oracle.com> <874j844o3q.ffs@tglx>
In-Reply-To: <874j844o3q.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6708:EE_|IA3PR10MB8065:EE_
x-ms-office365-filtering-correlation-id: ca5bab6e-e127-4ffc-4042-08dcb2668cc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R2M4SmVHS3Z2cGVHelBmTmtEVVNsK0o2ZEtsQWppeGs4Y3UvUDRHQVY2c1NE?=
 =?utf-8?B?SmMxSnNqUTFrVHpPYURpU25NYjhsb1V2VERiaU5VV1dIN1JkTC85djRWKzQ4?=
 =?utf-8?B?ODFZTTBMSFRoQk5QaDF6cEhOb1JKWElndElVaHVyZ0VnVVVRaTJMOHRJbGRF?=
 =?utf-8?B?WnpiTDlJd2x0TktvUThLZkhiLzFOTFhWRSt5a0E3K0dxNVdaMk9jTmhUZFgv?=
 =?utf-8?B?dDFMYTNjcDIwRDBaMXhWODhxYTNTZU1qcXR4MHVFRHhtUC9PcWZ2VENOQ2Yw?=
 =?utf-8?B?MVFmdDJXRUwxNFYrdldpemV2R3g0NjVEYTQ5eVMzV0tVYXB1THdQeklGQ3RQ?=
 =?utf-8?B?OGQyZ2R0cVp4eUQ3bm9ackdZVkthMGFlVmVwL1UwN2tQNTh3VDRaYm1aVjlj?=
 =?utf-8?B?R0M3Sno2MjMySDdjVVJyNzNuSVVCQjE2Nk1yYXBncThQMXdoamdHOHltcEx4?=
 =?utf-8?B?QTV2R05PZTgxalN0WDJLNXJyQ0l2a05vWnZQdUMrNWhpRXdycU5EV3ZzMjB1?=
 =?utf-8?B?bzlmVGhvOERsWmEzdkkyeHFjOTJlZXZVUWYrUzY5UUkyUC9CVDUxQkhEMlF0?=
 =?utf-8?B?ZXlxc1Q1dk1Ub3MzQUtBRmhWdTVha1lRYVEwUHlDRjZEajk3Q2xjUWlRekh5?=
 =?utf-8?B?UmJPUzQ4RzhwenVNcjIyT1VjbE1yY2tGNnZZN2JkRWYwOERIbHErMWlZOEx5?=
 =?utf-8?B?dVQyWm9ueldMNTg4U3pnZmxmMkRCTEd3ODZYUDd0eEZRRE0wSEdRdmxCMWRI?=
 =?utf-8?B?NWpQeTFtNGVIeGlDajNYWHNuRjBBVW9CT2JWZ3ZueTNzWUdFMWV5d2tJR3E2?=
 =?utf-8?B?UXlWTGVmaHZ1TE9SbHFXc1Q1d0xCVEQxTnBDUGxzc3ZlYnRjVHVEdzlHVS9C?=
 =?utf-8?B?V0svVTFOalZHZnhEMllGQ1k4UTg2bWVvSlY3TU02bkRRSG9oM2pXOEQ1ZE1P?=
 =?utf-8?B?TXdvSGtqLzRLRlVLdi9MWVRxcFpnbyt6U2tSRmFnRXhma3c4VFF5aU1xOUVy?=
 =?utf-8?B?MnI0R1pqTjRvNXNzMTZHZ3JUa0NzVHpycXlYenNiYlV4NjdiZlZ0RWd5SzJy?=
 =?utf-8?B?K2NPUFFCbmN4VTFZNnVKYlJsbEhIeEsxcFQxYUkraENXOG1QOVIyTmM0d1NR?=
 =?utf-8?B?YUhnNHM5R1dCc1FlODZXeVRqemxEOGdBVVY0blpqRU9ua3VZaVRsVlluVURQ?=
 =?utf-8?B?d1FPUnRSV3RxYys2bUZScnQrTWhsaEFkYXlQZ0M3d0hUSHFycnNPTEhYM2Js?=
 =?utf-8?B?Z21pOEFsRU1yTGhhWmVIOWJDZ0pRdUZrUmx3eUxYUWVLbWVGWTJhbFd4Tnk4?=
 =?utf-8?B?MDBnZkcvQnRhZVJZb3poOVk3Q1N1SkxLSnRpcEJxNnczdmNiTkU0aWd0S2Zp?=
 =?utf-8?B?Myt0anpJQUJ3aUNDS2J3eEQwS0tiQmwxT2d0WXl1NWhNa3BQNkJ5SWpydHdY?=
 =?utf-8?B?QTJoRWFveCtTRVhaQlMydWRQM1VUYTJyQzJKc3c2M2RrVWhXODRlNlg4Myth?=
 =?utf-8?B?MGVGUTlxVlBQUVdtWW5teXZaY1pvcGVjZTJpdmFoS2VHSlFGSlFpQ3ltU2NS?=
 =?utf-8?B?T1huNWdHNHRXOGZ0Z0dLU0hrbWhTVzNBdldUczY2amtmMStHU2U1cTl0K2JD?=
 =?utf-8?B?YmpKclZXV0x5aDFKb1lkRUtOSTdYdFRuS1pGYlBKTHJMTWdkbDJyemMyMkZo?=
 =?utf-8?B?MkFaT0dYMCtra1VLRWczVmpNbU8rK3RDaVJwdGxSZkh2L3RMUmdJUnIvRE9v?=
 =?utf-8?B?TkFvQngxOUJNRGZQaHYvK0d1aWxOYWdhc0dheEtPZDAvTEVnZ0VQaDN3WkVj?=
 =?utf-8?B?RENzeDU2ZU5ob3dGZFhZdllzUjF6VDlEMHZXYmNBTzM5N1RKVGJMa25iWTJN?=
 =?utf-8?B?ZE5meVE1TXVEeEFUYmFUY05IYXNQWjhsbjF5ODVPajh2R3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6708.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZlFmb0FyTmhXWG1uZEJYODc5TjFtNDRrdTJZR1FNeG8rMUZLVGNtR1RrVk5z?=
 =?utf-8?B?dnZCMkFMVUVSRU9FT05MTmpZeFNpQTZjMFpUU1pEeWFXTWFhTWx2Y1c4WmM3?=
 =?utf-8?B?OHlGUEVnbnR0WmpWbEFPM2hpUzlPbEFnaGNvRmhjTnp6cElHcGJOa3lOM1RK?=
 =?utf-8?B?OXhQaWE5ck5TK0VvejF4UUR0Yk1YaDRMS3orcGtvR3VDSTV1aU4vRlhkcDRs?=
 =?utf-8?B?V0c4OVlLeEgrZ3J1SGF1SDIxWGM3bG0wam5vOVFZREMySGxpNmhxTnE3S2NP?=
 =?utf-8?B?cUFvREJOYTdzVk5QdjVXNndKRk8rNU9raUxYQXFENUlTa2Jxb0ZvNERHeHZS?=
 =?utf-8?B?Nm1DeFdxRmhOYldHdDF4ZGIybkpWK3dpeDFqd293ZjNMVDIxcmpubmJoOU1M?=
 =?utf-8?B?L0krY1B6a1lyZ3RJQkVDU2FWZXNHbXl1Ty9vT1FrV0plRE50LzRCaEZQdm5y?=
 =?utf-8?B?N2dQSE1acEQrNVNPdUxSbzhlQlpWNEZBK1NGVUFTT2J1ejRDb25QU0xNNnV0?=
 =?utf-8?B?b2d2K3hNTjRpMi9OQVZyUU45VVJTczdad2ZheS9mSDFJVUdha2RGQ2JkdnBH?=
 =?utf-8?B?L1N0d2x0UWtNaE9yei8weDlLTTBncTRPcTYrbUFLSkNzdnJFejlEV0FCUGFR?=
 =?utf-8?B?TGpGNDd6NVZNOW1GbXFuSUVCemdVdFpWSFZkczhkVDhpK0RkcnNiRUhGcUE4?=
 =?utf-8?B?bytkNnp4NU84RkliUnhHUW9idkR5SkFxdit5T0hjajF2K2ZDSFZFaXdaR0pN?=
 =?utf-8?B?cnA1emxMSmJHbHJockJ5aE1NazFza1pnTldlOUZiM09iSEFXYjhhbVg5NDM2?=
 =?utf-8?B?ZFo0dWZuWXFGSnN6eEFNeWZxSWdGKzluckEvdWRkcm03aisrd3Vka25LLzBE?=
 =?utf-8?B?cEVqMy9XY24vemxPaVgyQ3gxVk41UTNibDdOc3BIM1pmY3JxTTdEcDB3cDhl?=
 =?utf-8?B?TjhHcUlKUWI5ayttR3BPVDFmdXpoeDR5Zi8rOVVDd2F0SHRzdHFNbXhCSjBk?=
 =?utf-8?B?dm1SQytwakNPbVdxc2tmQVdPNFNXMzFFK2ZMMktUQ2MyRXlhcUEzaWgzK3Vx?=
 =?utf-8?B?WllWRVlXZXE2UytiYW43WGo4MDJDZmxKQlBWUERzeVV4U21sZEsvR1ZHT0sw?=
 =?utf-8?B?WlBNb2MrQXY5UDRXYUV6WWt0YjJjcHQ4cDJLMGlhUDlPWnF6bk9tRkcyOFFU?=
 =?utf-8?B?WVVsK2lROEZObDdEYlVJQ2l4clpPcmp2eExhbEx4aHNGQXlaT0M1Rm1ReUpo?=
 =?utf-8?B?ei83LzR1em52eDUzdmdQRWlMS2lQNGtiTEw5c1ZHRTlkcklYb1U4eEdYY0RI?=
 =?utf-8?B?OTBSMEZSNThNRXlqeXZiNFpqK3d6SkJpNzlDU0gwOU1yb0c2U3JiTFEreTkx?=
 =?utf-8?B?TGdoekZvQmhqbWlvcmUyVXArcUtocFJOWTgyUFkwSi8vRlJMa2ZRVEROenlv?=
 =?utf-8?B?RUtCMmhKOGlhdDM5Q3FMdWR6dklsZ0RzWGlNTmpZRnBRK2c1Ukxvc05WWEdv?=
 =?utf-8?B?OEN2VStQYThPc1NQaGxlZVVzWVJWdVhDU1B1dWN0TkNXTXE3TDl5SzAvOWFF?=
 =?utf-8?B?SS83anFIWTdkcUljZzVtK21FYVJkb29VWkMvcEp3STJVeWpSVkZqQUxSQWJK?=
 =?utf-8?B?Wk9VSWRvYS9FL2RabWZJS3BjY1lZNUVGMExLcmgwdnBpdzNvNmhOU3NpdFE1?=
 =?utf-8?B?R2xROS9Ccy85WmY5d3BsQThFZ0tGd3ZYMjFEL2UyQ09LZFd2WjEvWm44NXVT?=
 =?utf-8?B?NHBEOFZNVkZDbldtcWIvWjFuUjFQK05JVmdMRkl5QWJnTmRocHJ0L3A4RWRT?=
 =?utf-8?B?U3Zmb2FhR21KWnkvTGpEbzZKbTBOK1JLNTJMbkFsZWFkVjh6Q0NISGhuZm5p?=
 =?utf-8?B?N2tjL1lYbUZlYmFZc05DN3M0d2RRVjhsOWU1TjIrY3BkdC9pTkpKTUFnZHhT?=
 =?utf-8?B?UUJmZVVWblFabVFIaTVOOUovWUZmcDM2b1Vibm00bDhIWUFHb1YrL0tlaE42?=
 =?utf-8?B?TmlQR2hCbWNReHJEbGNSdnlBR2xRbUxoenV4UFVIMmt0Z3YzMkdKaVRiZmdi?=
 =?utf-8?B?cUx3ZURqRU9JMk5hQnd6Q3E5cnJlSkpkR1BIZjA2YzJ1UDM4N2djNTlFRVE5?=
 =?utf-8?B?QjdONkI2NC9sTlBab1B4ZFQzSGs1WkVWTkVCMlFFckM3TGM0VVFsT0VlVEE3?=
 =?utf-8?Q?MMHYnRtkjL4qmFahgfqwBYCOp5tyr7PhK9wEGDK2U8Ym?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2581679A0A239D4BADBEACD7115362C5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U0H9O66+TTz6h8D4EuViX999NStNwJ3nsEMUHYIrpMFWV2P0W4Qcp/iLe6nZWT3RDG3YWDiX5isKVBvpjlXKwDW7aE8EVHmy0wununOugnWvt0kD1GhmBcI3ZmGQZpb7H51fcAgEBEWAmjwS5siUUc8N+VLnin0DCPnwn9M6KY4XBPG86dIBF077K8i8/7MdsL9EhstPA33/FNZ1QW64zeBVOGUN50+Q0zWjrTa4UTF8T5+XFzA+5CWG/wEzpZRlfEVAKgzswSnH5lAfaojhxoF4F1baAWhqVKszddYVDpHruEfcD/U7kQzPUWQF+kEXNxKRU8ek7nfI2w5Y2jtR7MwKocVQrGiON6LYSfidY+4elwuZRG6TTy2B+ziHYA2frXMFORvAdnc3wbZ1Cay02gMgv9gD9z9suqk6gLyAr/zvoqUQpsQwBIif+KIdjrzBP58u8UUZlXXYMcDwCmaD9D3ef5/DKcF6l0D0FDyT9hCLzAcX0m8DT80302wZs0miu0tU/kvIl+PcgpLW/w7jdnZfCHfoRGZHikdtyoo0zX3vvg+sXJeQXbkQBvOnn0YWnhUBQeTLZJMf/WxQaWMmqq+9/IGOc7zbaDVSa3ouPFs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6708.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5bab6e-e127-4ffc-4042-08dcb2668cc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 20:14:29.7658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +o4ayhXxWJJPAdwctQMYwXEo7E5Z3nf6jROeT27AKeyDoi77BQ8/ZqV/BX/pOIO0BecyBNujOGlWcmAPKoUYdr2l76TBH/z6/5XilfBQzp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_18,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408010134
X-Proofpoint-ORIG-GUID: CsqyLl_VVrOjXcS_Afz6MyViAx8mlIDp
X-Proofpoint-GUID: CsqyLl_VVrOjXcS_Afz6MyViAx8mlIDp

DQo+IE9uIEF1ZyAxLCAyMDI0LCBhdCAxOjU34oCvQU0sIFRob21hcyBHbGVpeG5lciA8dGdseEBs
aW51dHJvbml4LmRlPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgQXVnIDAxIDIwMjQgYXQgMDY6NTEs
IEFydW5hIFJhbWFrcmlzaG5hIHdyb3RlOg0KPj4gDQo+PiArZXh0ZXJuIHZvaWQgX191c2VyICpn
ZXRfeHNhdmVfYWRkcl91c2VyKHN0cnVjdCB4cmVnc19zdGF0ZSAqeHNhdmUsIGludCB4ZmVhdHVy
ZV9ucik7DQo+IA0KPiAgKnhzYXZlIGxhY2tzIF9fdXNlcg0KPiANCj4gVGhhbmtzLA0KPiANCj4g
ICAgICAgIHRnbHgNCg0KVGhvbWFzLA0KDQpTb3JyeSwgdGhhdOKAmXMgYW4gb3ZlcnNpZ2h0LiBJ
4oCZbGwgYWRkIHRoYXQuDQoNCkRpZCB5b3UgZ2V0IGEgY2hhbmNlIHRvIHJldmlldyB0aGUgcmVz
dCBvZiB0aGUgcGF0Y2hzZXQ/IElmIHlvdSBoYXZlIGFueQ0KYWRkaXRpb25hbCBjb21tZW50cy9z
dWdnZXN0aW9ucywgSSBjYW4gYmF0Y2ggdGhvc2UgZml4ZXMgaW50byB2OC4NCg0KVGhhbmtzIQ0K
QXJ1bmENCg0K

