Return-Path: <linux-kernel+bounces-408251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEA89C7C94
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA2928177D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BB9205AD0;
	Wed, 13 Nov 2024 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D6jAED3x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XvoTMhts"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543E3205E10
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528304; cv=fail; b=hZrHx252ITgH75OgZ2eiCq+5/ExV8e4oB6gj6EI3YNhOfOuvx0uP1PwvrrmLQZMV9WzYY0Mth3hsovXrGRWTFwzX3fwcMSZI0znoU9wzDsuRjGxR2MwoWcJcXAZeZ5T59Uo7DaZgBSJ/q/E5bhODM5T/ohMC0bp7nekWTKthFeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528304; c=relaxed/simple;
	bh=koLY1tkzErFSGi6TcuElerGOEcl7FA5rjAFFLc+SOxE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uHsd2iQZTQecLdnWzVstyjlzkzPzg22KBuXk8I1kkgE7V/1goCuQBfl1jZBKIQCfJNHbqaZ9XslfuMFSxaFhI86d25fTWUbS9F+8tK9AunJ6IcR0aytxa88ViyAgoCSbh4J+hzLaDKtJd9DbDKPGCLl+q68R9O/B1t1x5FmqqBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D6jAED3x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XvoTMhts; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIBWu2024490;
	Wed, 13 Nov 2024 20:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=koLY1tkzErFSGi6TcuElerGOEcl7FA5rjAFFLc+SOxE=; b=
	D6jAED3x0KMuTlJJJ2niNJAp0r5eLijj6g7tyNBtzWm7LYwHLs8kkWxDPvgrW5IF
	MpJGIOa+5wHsfK2vxuo+lm6hx9TzdZFKa8lVbiD6v52xwaZPvAktr1RTZegZdT0w
	aOItAGYeMVwfzRw8ajVwZu2YV9DKr9x7pxmYCXcsSE+uSCgQuvNEEMkJsQHudyhu
	jpdQycqHKOTrbCKJaM+yx8DIMZUpeYKvphJi21UK39Pb1Xgg+ZjBWS0Z39C38lxD
	OYaP+Tx41deWOSR+39GEgRBwyLaqr4nEoxGmcgiGoIYS8ZEt+2fS8LJcLQ5KBH8o
	696jwySCT7bZyiMTPWS5mw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k27put-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 20:04:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADId7vO000494;
	Wed, 13 Nov 2024 20:04:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbp96ahf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 20:04:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQOe8euKH8oHgG6HTsEfzf2EqzCJ02dciyxxC0GFeAsmI4ioyP4B+qlxpOydE3bCvgbqXa88/w0IbIdgrfpCDzlaOzdHS3/XslUA4KBtOaseWeoP/QHKX3mMK7GZNtJCqV994gtbRrUruI5c7/iZ6GQIN/JUEmW0ZCu+QBOwbM7i2g4AJM3w7h3sTRL6dvpJk6X7kN9WdWLvTrC4mj5RNUX8OBsodu753IjvL1ipWitTRoNv+5eOMQMdgryEdSoR65e54uskWaSKnwasPqsStxLs8vCpx42wCgz4PIqO9aHpf/Umq7Z62yl+Qe2yiMagxLikhthtRMsw561++/OcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koLY1tkzErFSGi6TcuElerGOEcl7FA5rjAFFLc+SOxE=;
 b=o3owcCn+m+vppl3E4pt4rTVUsRkJZRmJnD/h9xx2LywiQZb6v7sDckpAlbckuMz4CieQH1HeYXRKCy9Z9GlLmLOhYtUPXDLAIhLslsJaagzLCZRpyPd6/5Lgx4i4icNwWnBnVpuy1W9ev1MLBPoLnUrxyoulooo4fesxIK/YK9RSdT75Xul+CHw9FbrmLNlLqgSg731odMhFONWKjV3rGmQaNauYmuOJ8nWW9p0Leke8rDcMRsXYZiIIeBN2sXduQsEvadQveYybYZjr7jyCQK5MUC1mqHwdF7h6A4Blf56YE/fhEZyCuKOqaaEAhs7YmAa6uERb8Atklge/o9pIxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koLY1tkzErFSGi6TcuElerGOEcl7FA5rjAFFLc+SOxE=;
 b=XvoTMhtswER47NKzak82HJJtIja67B0I5HNSXJi8rruwghvynMZRC5Lclk/n7uXpImvpf+Av7wva75Um3SAq70VEF4Vj+9XqHDOP+0euasHDRPYD57f6uKV569XN7u5L2NhC4J8Vpm8C1M35LBYHtp4/opqd2748ZsJXJT5cocU=
Received: from CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7)
 by SN4PR10MB5656.namprd10.prod.outlook.com (2603:10b6:806:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 20:04:51 +0000
Received: from CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199]) by CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199%5]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 20:04:51 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@kernel.org>,
        Rudi Horn <rudi.horn@oracle.com>, Joe Jin
	<joe.jin@oracle.com>
Subject: Re: [PATCH 2/2] x86/pkeys: Set XINUSE[PKRU] to 1 so that PKRU is
 XRSTOR'd correctly
Thread-Topic: [PATCH 2/2] x86/pkeys: Set XINUSE[PKRU] to 1 so that PKRU is
 XRSTOR'd correctly
Thread-Index: AQHbNf+qUIXHJpmd5kCs67B09p2QY7K1ooqA
Date: Wed, 13 Nov 2024 20:04:51 +0000
Message-ID: <0522A1EE-211A-45E1-BAAD-002ABF47D0ED@oracle.com>
References: <20241113181436.3518359-1-aruna.ramakrishna@oracle.com>
 <20241113181436.3518359-2-aruna.ramakrishna@oracle.com>
 <5a98b9bf-8004-47e0-82e6-77da49419e0b@intel.com>
In-Reply-To: <5a98b9bf-8004-47e0-82e6-77da49419e0b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6708:EE_|SN4PR10MB5656:EE_
x-ms-office365-filtering-correlation-id: b62f1825-eae2-43a3-7fd2-08dd041e6f29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3kxQktDaWlKaDEwaDFiTUM0NGJiYWpjMEFUNW1Oa2xQMGY5TTZtN3V0Q1ZQ?=
 =?utf-8?B?aklZdHZoZk5KamZKcW96VFd2T0p1c3BtRDdueTNjekxGcVRRNEV2d1hHN1gy?=
 =?utf-8?B?QWhNQWlIR1JDT21qVDMrdjBRbWZmUU8rM2VXeDZvb1RYbm12cy9QYWZPdEFC?=
 =?utf-8?B?Nk95YVlwS0tPVkhwN2Y2R09sZEF6UlpGVkRjOEFTU1FsVEMzRGVIVUxjVlVM?=
 =?utf-8?B?aFdJeGFpN0s2cWwyOWlqY1ViSTdjUzR1MVgyVWNFVTVGekpVcFVRZWtEeDgv?=
 =?utf-8?B?b0x4OURCZHBIQ2JBT0E2dkVEdFEzb0pVenFuRHI5OWlZMEcyVzJGSXh6ZWxH?=
 =?utf-8?B?TFFKcWxoQS9nQ2dVZUxnbTI0eElKVkd5cUdhb1BaV1FuNkE1RVRxeW5NamNY?=
 =?utf-8?B?K3h3eTZlR1Biam05b1pnMitqKys4VDhaTTV6U21JWXI0Rkl5UTZ3eUljYnZB?=
 =?utf-8?B?UkFWWFZ5andFdTBrdU5xOHNaN0VxQ2IrczhtRm9rYmtmZUprMHNSS0p1MDBV?=
 =?utf-8?B?amJpbW5sQmJScmo4UWZiYUJpa3BnQ1JEbnY3MFdaTmVRWHdGWElLTVI3dFRo?=
 =?utf-8?B?cmlWNXpTbHVQU2xKYnpxTVdPVHcweEJNSjFENS9sYmV6VEhYM2lYSmNZTHRU?=
 =?utf-8?B?YWtvRkY0RXFQdEtmNnZBWitUL1RyVThjejNkbktRQzYxN3B2emN5azhVM3RD?=
 =?utf-8?B?ck1nbnBXUHVLdnVrckcyaUtYb2Y1S3NSdVNIc1NsZ3RjUXQ3TGJ4d3NFWTQ3?=
 =?utf-8?B?dUgvVkNQUGVaSGNzcEs0dGNUVkQyc1pxb09GY3A1VXVSZGJCcEMzejlqayt1?=
 =?utf-8?B?QlVnSXpqTTQxVTZ0RXFzbFhQbkJUM0hML1RST0FzUWpxQWEwYW5jaE9UQ0E5?=
 =?utf-8?B?OUl1N2lBc0RqSi9WYmxsUkFqSUlrMEljL0ZyaFY1bHUvZ1lCdHVxc0syTlJs?=
 =?utf-8?B?bHFCWVdBSEl2U0h4c3B5K0pYVGJUSDFSSm1yNWwxNUp3LzZuL0dGQnBnb2pl?=
 =?utf-8?B?SzFtZkNQcFN4eDd0L1ZMKzAzbWpCa1poeDVBTlIzVXdOSm1TUHBqSmovUUpH?=
 =?utf-8?B?MGRvYnZvYUZmTHErNm9QSHlEclJrdFI1NU5xNEZFRWc1WFQrS0J1WmJGU0pU?=
 =?utf-8?B?cmljS3R5bnVic21RcmtOaFdkRG5SQk8xdjRGVjl1ejZXTTIrbmp3eWtEWmI3?=
 =?utf-8?B?VjF2NDQvU0pYQk05Y3BSS2d4a3MzTDk5ZmVQZjRETG9RT25WOFFjOVB6a0Uz?=
 =?utf-8?B?UlJWQmxBZHg3Z2RscVN4QXcrQjBOK0JpUjYyL0tkMGVuSWVDMjUrN3l5VVlz?=
 =?utf-8?B?K2lnOUR1VjRNZVJvZUd4ajhmQys0TGUxakx6NUFxYy9HdE1FWUZzSkdWNlkx?=
 =?utf-8?B?T3pXOEdwREJiRVU5Wi9FYlJVNXErNFVqWGIrQkg2SzZLZTQzQ296TnpHYjZV?=
 =?utf-8?B?SG5WdGI2QUZ2NittRnJSL0NIaWJwd0VYWXl1Q0MxbGFBMzZ1SlNWbHdiY1pL?=
 =?utf-8?B?cm1TNHNYbEFVVVNZNHpGeW4vakFubjMvZFZhUlVxb3g3QytobmFNVWVVdkgv?=
 =?utf-8?B?Mk5sb2xnS0U5NWgySW9WRGxmaWFjbzAzMkU1dUhhSUxHamhFY096WEJ3M01y?=
 =?utf-8?B?RXZJYnJRU3ZCSEczTzVXSGN3Mmd1ekY2c1BmRmNGaTkzZGxodU9MajB1bW02?=
 =?utf-8?B?bVMyTEVJNXNvbFZYUjZqUURRQ2pJK01GaVJZeU8rdDRNOEZHOUNHK215ZUxO?=
 =?utf-8?B?YU1IeVRjOEViMGdTOEs2b2xFNzdsc2k2bC83R2JtSGtpM3gzNDNidC94V1RI?=
 =?utf-8?Q?xPqVUzW2vkjawFCbrGHgA0+QqZI6xg3FznY/4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6708.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXBSZlJNbEEvOTcwZ2lndkV0VWUxeVpLMEZXOS9vRTJOWWVnWCs0ekxwZ3Fv?=
 =?utf-8?B?aHMvcGt6V1k0YmdlRnBTM09tWjRkMTJaVERLUDZnbXVSMGl3Mmt6TFhwMFVK?=
 =?utf-8?B?U1lEb3RMSnE2UHk2QlMxdlFWcG1KWHNxYlNNd2FIOFBzY3oxVmNSQUJTWVIx?=
 =?utf-8?B?NkVmQVBDVzhuQ3IxRGgzRFNQb3QyYVAvc0VKYUsrNHJ4NGhETFg3TWhBSVY5?=
 =?utf-8?B?Q292MEF6ejk2UHpTSGh3OGVjNzhaOXBUR2xNZVRzTWNCdjhzblZ0K0JpQjR4?=
 =?utf-8?B?UVIyRk01S0NFZERZbE1wTHkzQ0RsUi9NQ3dRRHRRMU9Od1VCc1VtVW1BMlN6?=
 =?utf-8?B?YzYrWUNRTVkyUGVHTHNYMkt0VkVLWG5BS3ZWeGt1WCtzQkhmZVJsRU4ySjRR?=
 =?utf-8?B?Qkt0a2FKbE9oamcyMEhuSE1PVmNGdTJ6UVBSSExMR3lLUlFGT2V5Tk42RUcr?=
 =?utf-8?B?S1diZkcrNWFIV1ErTU5YNjc2TldyS094NHdXSUpMMzVrKzZWeE5PY0hiQnNS?=
 =?utf-8?B?VituQ2x0R24zajl5eVR4TFFCNllxV2FhK0MxdUpsOHUwSEpqOG9QeTh5R0VO?=
 =?utf-8?B?QWVJamZRSVdYa3Rzcm9UYldDYWpPS2ZHZ0VPQ0h4a045RzBldi8yZjhqQXlQ?=
 =?utf-8?B?L0s1d3NrTGVRSzZpWmxzSWJPdWxEbGlhRDFDazhVdWZ3WXRFek1KQ09GSWFj?=
 =?utf-8?B?VE85a3JIWDhaS3paVUc1cnRqdGkrT3dqemUwMWVYejA4ZUx0bGptdGtkMFIx?=
 =?utf-8?B?Y1hFc3NzdmxYbnRVNTF1RkprOTBpcksvSm4xNnozbXZ2eFQ2L3dERktxcU9T?=
 =?utf-8?B?MXlXS05iYzFHWXhwMTJjMHB4Tk5QOW5HN2F5VmpsYXV6UUlzTHhnRUtYRUc5?=
 =?utf-8?B?WUhCUmRrWWI4QVdsNG9lUTVxU3BEcHp6c3RLRGxRVHZHOFc0NW9WWjZHcUFs?=
 =?utf-8?B?Y1pnMFcrejV3ZDQ4b0ZMeFd2OW9vNlYrejk3aDJCRzFPdDcybnJQa1h6bWJa?=
 =?utf-8?B?SHBKMEt0ZkJmUzFCQUdGR29zSXQyL3hjTCs2ZFo4VDJKYW5ETy9vRklUQWFm?=
 =?utf-8?B?elNnOXBaaUNyUG5SWUVXU0RxeGs2QUlnaW4rZTNvTWNucWNMZWNzdWJlRXpY?=
 =?utf-8?B?OXp5Um80NC9LSHFSQmVaeGE0aE9tcmp5TXYvTUVEcHBNWnlzTDVSSm40MHVx?=
 =?utf-8?B?SFhIVjkzVGFUbVRlQnBDcTNkaVd5amFvbTF1K3pmQ2FxdjZ1V0lNQ1pRTE1S?=
 =?utf-8?B?RVJ3YnovRFRaMisrSlpJamtLV2V6RkZGMVdueGRKN2k3bHRvRDY3NkNaS0hu?=
 =?utf-8?B?MG14WGdJamNqRUVuQmFac2Nmc0JDWi8waWx1V3hvdERUd29xWjBBS2xGeCtV?=
 =?utf-8?B?NHhyMTZNY05oSW04Wkd5dytCZFd6OFJ1MWRtb1FIMVVCQTZ4ZXZHMlJlZWpm?=
 =?utf-8?B?YldpT0xqS2pZT0hPaTRFVlhZZjlOMXJ1bngzSzUzNVlhcHlDMytTVCtycExG?=
 =?utf-8?B?NVozbjcyVzdCVmRLZktMYzdYeVRtWVh5bTlDbUdPbmdWL0lJd004dHRPVEZ0?=
 =?utf-8?B?ZVVyRVQvYURjTCt1ZXdwc1RHM3J5TEgvVjkxOXRhN0V6ZU9sS2ZsMEUyclQ5?=
 =?utf-8?B?UDEybFdmVTYyR2R0VmVNWkY2SDdzSkhxWjgwenN5bnFrU2hYZHUxZm94WkE3?=
 =?utf-8?B?MVl4QVpOekl4REdwVnBOeEZWNFlNZkpTOGtZZU1pbU4vQ0lLSklNMDU2RnRK?=
 =?utf-8?B?Nm52V0hta21KWjdFZWNsOUdyelN3eTV6akRrZG5ZWTdURDVBdlZEM1NlR01O?=
 =?utf-8?B?QjR1eXUyODJsT3VrMVlSTUZiUEEzb010UHNRQ0JWN2xuVVVtclFsS2tDQzl4?=
 =?utf-8?B?b3ExL2NFMXpDSm91QjdGYjNQejVETWlIRnBDZW5ZaUJOUkUzcU1BNytTYjdT?=
 =?utf-8?B?b1c3amt5TFVQQjRBOE85L09mZUp1SUg0VnJDYmJ5ejRlc2IyUzY5elh5VVJW?=
 =?utf-8?B?cTlLQ21jaVBNcDlpVFIrN040WmtvRE9VU1RzSit5a0NMYmFuYWtTc0M0TmpN?=
 =?utf-8?B?UUFrNWR3bFNwYUJKbE42eHhRU28rZjVFSFdYY3NZTmZNUUtsWW1GbmZPSWpo?=
 =?utf-8?B?WG03RWdhMUphUTlGbGZGQXFRa2FjQWxadDdFT0FMOFNoZS9ZbC8zaTFKa1FL?=
 =?utf-8?Q?QEuX2kzpwDiqDvLiIjG9lycsZJE0LAQXArix9LNzZq94?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <366B66CEC365D243B172F4FC64D5938D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Uxh7ctUXIQwOhjZy65oYYfVxNwCjKb6nbVoJNbTVYIu12pAo/NsYO5jK009orfLBOiuDeL16HSjqVV8sUvCIM0TUEUhX/Bb5X9M/qtklpdp0EC9S5lXuoqM546X9ZTrQXbKP1rdhtaM93Mzomjh+4DM3ncPOzXHZNZddFIOCWaA6Qg7MeYk95uKx3LDSG9YIGxZI5cARfM/hD36zskR/ri71kphO5s9Sx9Dk8rAeuHguM6X1qNQIyoJkSYYTS+Rjmoz4Os1vvFfwfpe4X3PgifDC5pEsn/l4HG7o9ykRtpiwlGN/jgUfRmoO1ELXZqcyPDS2ov+Nr9QXYY2qJtySRbttHaEnJkzfbznSAMiPWCDdRO8u5J2rJSd+CK0MF/7HyHeF/M8BS5n+Y2CN98OICqQKixFbmJIenqwcN3GOBiCPyS5YhUfEJcrTJR9pcq+Tp0dRHFK8C1MJ9ETxPPXnYnOcUQrzVNSRt+6gR52tDBUe7wlGWfjB3AgAKlyKrMP5D0qBbAwLHPPALcJQqLVPU89VRbRZRkN0B3iQ76/qCFzBdttvUa2qK02gaHG8BASZQc6/qJVZuJgkeAhvWERExrFzNVJFlfgAXFvRpmCqZNY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6708.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62f1825-eae2-43a3-7fd2-08dd041e6f29
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 20:04:51.6669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89Y1gV+EWX7CRHHjSBqn2LD4N6HjI8FDE6T6F4wvl46xEEkbR9XFlXtTVCoSAVmbjFLMR+A0VLU+8oSxbXB2lS1tVOftjWiptT4QgsDf4HU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_12,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=855 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130165
X-Proofpoint-ORIG-GUID: NFq7kB8bL1KTV8bOSmgWMtqk5Dzae-t0
X-Proofpoint-GUID: NFq7kB8bL1KTV8bOSmgWMtqk5Dzae-t0

DQoNCj4gT24gTm92IDEzLCAyMDI0LCBhdCAxMToxMOKAr0FNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5o
YW5zZW5AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDExLzEzLzI0IDEwOjE0LCBBcnVuYSBS
YW1ha3Jpc2huYSB3cm90ZToNCj4+IFBLUlUgdmFsdWUgaXMgbm90IFhSU1RPUidkIGZyb20gdGhl
IFhTQVZFIGFyZWEgaWYgdGhlIGNvcnJlc3BvbmRpbmcNCj4+IFhJTlVTRVtpXSBiaXQgaXMgMC4g
V2hlbiBQS1JVIHZhbHVlIGlzIHNldCB0byAwLCBpdCBzZXRzIFhJTlVTRVtQS1JVXQ0KPj4gdG8g
MCBvbiBBTUQgc3lzdGVtcywgd2hpY2ggbWVhbnMgdGhlIHZhbHVlIHVwZGF0ZWQgb24gdGhlIHNp
Z2ZyYW1lDQo+PiBsYXRlciAoYWZ0ZXIgYSB3cnBrcnUoMCkpIGlzIGlnbm9yZWQuDQo+IA0KPiBJ
IHRoaW5rIHRoaXMgaXMgY29uZnVzaW5nIFhJTlVTRSBhbmQgWFNUQVRFX0JWLg0KPiANCj4gWElO
VVNFIGlzIHJlYWxseSBpbnRlcm5hbCB0byB0aGUgQ1BVIGFuZCBpcyBwYXJ0aWFsbHkgZXhwb3Nl
ZCBpbg0KPiB4Z2V0YnYoMSkuICBCdXQgWElOVVNFIGlzIG1vbm9saXRoaWM7IGl0IGluY2x1ZGVz
IHVzZXIgYW5kIHN1cGVydmlzb3Igc3RhdGUuDQo+IA0KPiBYU1RBVEVfQlYgaXMgdGhlIGFjdHVh
bCBtZW1vcnkgbG9jYXRpb24gaW4gdGhlIFhTQVZFIGJ1ZmZlci4NCj4gDQo+IFNvIEkgdGhpbmsg
aXQncyBpbmNvcnJlY3QgdG8gc2F5IHRoYXQgWFJTVE9SIGJlaGF2aW9yIGRlcGVuZHMgb24gWElO
VVNFLg0KPiBYUlNUT1IgYmVoYXZpb3IgZGVwZW5kcyBvbiBYU1RBVEVfQlYuDQoNCg0KWW914oCZ
cmUgcmlnaHQ7IFhTVEFURV9CVltpXSBpcyBzZXQgZHVyaW5nIFhTQVZFIGJhc2VkIG9uIFhJTlVT
RVtpXSwgYW5kIA0KWFJTVE9SIHJlc3RvcmVzIGJhc2VkIG9uIFhTVEFURV9CVi4gSSB3aWxsIHJl
d29yZCB0aGF0IChhbmQgY2hhbmdlIHRoZQ0KdmFyaWFibGUgbmFtZSBpbiB1cGRhdGVfcGtydV9p
bl9zaWdmcmFtZSgpKSBmb3IgdjIuDQoNClRoYW5rcywNCkFydW5hDQoNCg==

