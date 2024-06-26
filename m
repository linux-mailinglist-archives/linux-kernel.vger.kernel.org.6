Return-Path: <linux-kernel+bounces-231230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7959187EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A5D282537
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ED718F2FB;
	Wed, 26 Jun 2024 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dmbUAg5k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LZoKv35f"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C1C1F94C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420735; cv=fail; b=U9pRsmC46lkZINfmHDDWQiR6Szf+Yijg7kK8u5WCzmp2Q3NXSP6tBxM6Ry4ZUsXPyXKRpc651aVknWLr4rt8CbwScNWPbptzX5djNquoZ2rU2ukpYjEheWukjIlC09XUl4AyJXoYUaMjCzZC+9c+NbqqI18IwGxfLARQqk2rET8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420735; c=relaxed/simple;
	bh=AKdGP1FahkuUSG3KOzM12uImWFglObJ2zooJldONZC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Urd8iUcEN56k/Tih+6XSGY1Wwu1YTQSwrrPV1DQwfDY+TfuoxHn5MB4IveLKWD9o9isnEzwhMugKSGkycMaQcLpPeJRAkvrNFSlkZVXL3u+4HvzOIQfZMPhyOWwJPjNCqsH51CT+TOxz8tF+17hpbwyeM2Mb1SjEH1cu0W+fzjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dmbUAg5k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LZoKv35f; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QEtW7u029506;
	Wed, 26 Jun 2024 16:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=AKdGP1FahkuUSG3KOzM12uImWFglObJ2zooJldONZ
	C8=; b=dmbUAg5kSGyeP/ufeR6v8o4H+0WcWbg1cb5L3Sfcs+me4v1rlFsVfvKWn
	o44XcWnZI/Gmapcdyth2rCzM1HbKozk3+qH44MCctbj+20w498ROGXk2jwKulaCf
	HiKPzYOYHSZgZ6jxQT6vW2dLCvZ7OfbeEtckfNlW+bs4UhOpozB4sZP2cToS7E33
	MN1Nv4ps+MKjMWMeprHSTPmSYt1DcA3INRYK2bVblCa6I3UQViMb5IPoylnJxlhT
	k/FIrK8TCA+aoLDBvcBPkXsVcY4S0BD6AS0ZvQVE0FVGCO5iwZEjnQF2H7Sk0VTM
	vziOEVTrT72oLgIrYBBoQmdKdUF0Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnd2kw08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 16:51:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45QFNj5b023425;
	Wed, 26 Jun 2024 16:51:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2fth0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 16:51:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MY3zF609hP4HQLvK7Z28L09EUOeMSso8o7mt/g58OnMIonBmDOBYHR0xtrJgS4YZHCCBtCoLi5QbYvBQ3aMaCGSOm0V/qG70CgqTKD+Uc99oRWl+n+apBF3TMbkGihL27kmeRm0bxjp/n5VT5+5OxJ9PrZh/P7r3H+CNmT2BnFnjOMkUJtb93kfaRT/h/44M0dDFNOpQc1Tlgr/mkCgV0BYjVnjaFkonIXbDlwOq2ufNBbbhT5cUvYFhiaXhEEyBgImS35FuyWoywA+TND6ANKIXgqyLciD3jrtc+b6APONe0nrA51lkVBV8lQOTMToYwCdYSctcN//b2ufwrehJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKdGP1FahkuUSG3KOzM12uImWFglObJ2zooJldONZC8=;
 b=O0SAABW8fFMS0XzafgqV92bsOdQKWJjq+qcPwZ3nr62LhcUCGHbMwHqWe8Rr9oa8fhveOIvytt3i7Dl76pZmhshXhm6Ud/Zojn3iufH8cPvUSe2oxx2YCed8DT4hdtrwKmCasCBU5LFWF7Q0zwOg4Vw9kDsU958Y2b86lVFsiDvxuOtilLdr312j2j6EDnArzQoQ0ZHi66VMMuCIn9Di67iJl/yxew/OUSWczSt2tXcxN90SsEakXzaNT9oGjFwHuP/97oDlRKzCD8ioxg5lcBpLu+WYTRzpNRT8y08fTLSpy+HGs1m/RtFhx/hUjEeQiRfXEULmgYNjPX5eRXKjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKdGP1FahkuUSG3KOzM12uImWFglObJ2zooJldONZC8=;
 b=LZoKv35fu/GR/I+DQ2YbEfmVThOLLhjjRgUmgw2lpPGp46hAXrJTcfCj6b3hHfCzdstelVodXdRnHeKdsB32kXoWyohJqU9AJI2geG3J0YixDjB+fz31E+A7okCVXtmTwhv4p5tNGD3yv3ILcMto7Cvvdq/YhGeN9bkJk3e5UvY=
Received: from CH3PR10MB7762.namprd10.prod.outlook.com (2603:10b6:610:1ae::7)
 by PH8PR10MB6314.namprd10.prod.outlook.com (2603:10b6:510:1cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.31; Wed, 26 Jun
 2024 16:51:53 +0000
Received: from CH3PR10MB7762.namprd10.prod.outlook.com
 ([fe80::136:7fd2:6a9f:b3d9]) by CH3PR10MB7762.namprd10.prod.outlook.com
 ([fe80::136:7fd2:6a9f:b3d9%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 16:51:53 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@kernel.org>,
        Keith Lucas <keith.lucas@oracle.com>
Subject: Re: [PATCH v5 0/5] x86/pkeys: update PKRU to enable pkey 0 before
 XSAVE
Thread-Topic: [PATCH v5 0/5] x86/pkeys: update PKRU to enable pkey 0 before
 XSAVE
Thread-Index: AQHauGKOedEStc1YT0CValas/nCQLrHaYXgA
Date: Wed, 26 Jun 2024 16:51:53 +0000
Message-ID: <E5E808E2-3A20-4EC7-B638-9088991BF852@oracle.com>
References: <20240606224035.3238985-1-aruna.ramakrishna@oracle.com>
In-Reply-To: <20240606224035.3238985-1-aruna.ramakrishna@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7762:EE_|PH8PR10MB6314:EE_
x-ms-office365-filtering-correlation-id: 966c2e05-805b-40b3-a095-08dc9600480a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|376012|1800799022|38070700016;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VWs0dldybjRrWXlDTmM4TTcvWU1uVy91aWZDeGt6a2g3d2NQTUZtcURtU3A4?=
 =?utf-8?B?QjkwNU5HZGVwMDA2NG5GNDgwaTZSbWVmajFpL28xWU9aWmZxZkpRVXFVWTlu?=
 =?utf-8?B?VFhad2VSRU5iNHVmWG5OK3ZPcUcvek44bFpBRUFoa3dPM3BORXh6S2hUczdY?=
 =?utf-8?B?RG53bFJHS0k1Qm16VDdXd29uZUJ5R21pNU1ZLy9WMEtjSDhMS25INkQ4NFUw?=
 =?utf-8?B?bjZ4SjBaVk1PTUREb3RZZzAyc1lKd2MwZnhyUkdIMXMrVEhsZnJObVFtV2VW?=
 =?utf-8?B?RG9UUUFUeitjbTZsMVZOUDBON1BmSEhVWHNqc3JxZW5uT1VmdWZFUFBQbkRy?=
 =?utf-8?B?MmtvRk55WEJXUytlNE9WRlBBN3NtVUI5am9MSEtFSWRJS1hwZ0ZxNDBCYnVl?=
 =?utf-8?B?R3Bhd2pRU1R6NEN5TXdOdG9RMDB2QTd3QThVS1VxSUp6c0FDK0RNZHlHRWk0?=
 =?utf-8?B?bHl0eS9VM3V4NWNGaEFqUVlxZFF6YmF3YUZ3Uk5HZDArNTNOWmZIMnJvUDNW?=
 =?utf-8?B?Zy9FdzZWcUVoS1RDaWNONXdpSUl5aUF6N0pjQ3preGlqT3hVTEEwcU1LZWhu?=
 =?utf-8?B?UkJScnB4THdydWlTWFpLVjdtUVJqd3BYb2JGK3h0LzZhK0hXUE9iQTBQZVFS?=
 =?utf-8?B?eXdVbjZYbytEeGtmbWphRFZPY3AxNDU2STd5TnV4Q3ZNbVFqYm1mb0pJOHZi?=
 =?utf-8?B?TW9keVRtOU44UTZlck00aXVZd2djUURBQTBQUzNaNVExa2pFRDVaWnhUZkE1?=
 =?utf-8?B?SlpXSzFZVmlhYUVKNXZYNFpnc0tKUER4WDZ4ZUwxU21nS0FmTFhtYzlDOEU3?=
 =?utf-8?B?MVFjT3lwdENmK3RHODJLbEVJcnlyN1Y1eXlwVjZON3dkMDRtd3lFc2JQQ01T?=
 =?utf-8?B?Ry85R3lpUFFLL21mWDFsNi9sT2NXbytUTHRMRWdHalpHZVI3c0ZiekczMGJ1?=
 =?utf-8?B?VEdMelhhL0xFeFJDREpVTEVDb0JLZlFiMlZEaVg1M2Rya0lpT1R6K3pkb09R?=
 =?utf-8?B?MWY3Tk05TzdvWjJXcnFKekNxZEVDQmdOM04yaExXT09sbURFaHh0Nk1jMWZC?=
 =?utf-8?B?K1JKR0E2dVV0dHZqYlVEc2M4NTgvYWdLVXJMMGNCUnZzc2tvRGJPUWVaRmYx?=
 =?utf-8?B?U2dLbk5Cck1sRWxMU0FnQnZSU3NsN3pvcVJOQXVoMzZGT1V0ZTFHWEd2Vkdi?=
 =?utf-8?B?WHBMMEQrdjBSZDZMR01sTzNadkZnanhDaHN6NWdiT2N4MDA5SGJvZm9xV3U2?=
 =?utf-8?B?bFJLeXVFamxoRW9YcGlSc2grQzFORjFXYTJzMFpIYTQ4NHo2ei9DNzBTSzJi?=
 =?utf-8?B?Z0JnTWVveC9NQnIyMEpkSzB5SEt0Zi9CTG5mUXBKVXM2L2hYYUQwWkFOSy9T?=
 =?utf-8?B?RUVFNUFGYmEza1hYbmJKcHVJdHpxVWdyamhjQU10Z05ycEhhZmROSm9YSGd1?=
 =?utf-8?B?SEUxaWRSRUR2V3JmTlNCNjUwWStibDNqMUkySDVvQXB1T0RMWTlyL0ZWMmF2?=
 =?utf-8?B?OEVPNHdycWFJalBWV241WVJuU1RUNU1obVM5YzIzNUR6U3BkRkhsUExJYXZX?=
 =?utf-8?B?WUlmMmtSa3ZKbWpoelljL0hvVEEzMXN2ZnNFejRvRStjQ0s4QUhyMG1SN1JJ?=
 =?utf-8?B?QldUZDJYalFZamMxNzZweHZJL1lpamlzdUxHM0VyRXd4c256ZzUwaGcxbWhL?=
 =?utf-8?B?MkxIZ0YvcFRleUkrQUo2b3JYdUxIR2wyNGlPY0JkZEpxTnFqeE9QNXZUbkhG?=
 =?utf-8?B?TVJ6cStydWViVm9tODJiNHVQYWdlNDkwRjNBUFJGRHBlUnk3QmxVU0dZcURC?=
 =?utf-8?B?dFpxd2E3WDNuYjlDUGU1Y25VaWNtR2NaVG9aOENSVGQ2bXFVM0tTMlVQb1Vr?=
 =?utf-8?B?b0hISzE1czB6bDBmOGY5aEYveXdzeG9aVFg4bVRYUmRoaWc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7762.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MnVYamZlY3JIYUo5LzV1UmVpcFVBOGtGNFFwbVlFeU9ZVXlCY29BS1ZnTG5N?=
 =?utf-8?B?VEZLZFVCcGdOcmlaaDJrcm85c01RWnhPZmlZY1E5ZTh6RkZINWdLNXkwSWd2?=
 =?utf-8?B?MDRwUmw3eWJldXB3Vkx1Z3BVa1lreHk2ejF3ZHYyWENJV2xqcHBtN1dudXZn?=
 =?utf-8?B?a0Q3UFZhVFJBM3pLVzZPdm9mbFg4bGovSVlueVNncXAwVWxYM3NzOFhubU9u?=
 =?utf-8?B?bkRyYmtNOVMxNGtKZmhyUk9EWVpTRlFMMmQwQ2FPRUdhWU90dFo3aHMzRWNR?=
 =?utf-8?B?eVNqQXNyVWZhWnZjeCtIZTVUNDBWdFk1ZjhsNitVNy9nSkQzRFVPbGZWYWt4?=
 =?utf-8?B?Ry8xTHIxNXZkamJVWW9NOElIUXN1YWNGT0tMOC9sNG9OSWw5VjMvSmFTNEY1?=
 =?utf-8?B?TXhqVk9HYWNDKzBSRnVUbFdkZ0NWMzB0OVN0K2VNQXpqSmh5RjArdXVXUmFr?=
 =?utf-8?B?ank5WWlFMm1jMEtDRC8wWWpwd3ljK3crcFFyQzF3eW5WdFVzOHJMQlNyRDU1?=
 =?utf-8?B?SCsxaUk5dHBUOVYrRmJ1RHQ1TDhia3dsTjg4YWwxNFA3anF2Z21KY1IySEdq?=
 =?utf-8?B?bWdrSG9nKzBxdEFhT29XaW5nbEswZFJydlJkRC9BSXFUc3FIQ2FCb0RTYlJT?=
 =?utf-8?B?ZytZQVJjQkd2N09FUlVSY09Xa1NqNE9OY0lMc1AwYVEyVmVaTS9ua0E3WGl0?=
 =?utf-8?B?NWNHRTU2RWlXbEI4UWh6K0ZqWlRDOWpUVXk0dng1aWRGRlNiSk9USFBQV3NC?=
 =?utf-8?B?NDJiNlAySkFMSWpwZ0lTOFN5QXRncmgzTzdxSDh0LzYzajRIL2hyZ3BscS9W?=
 =?utf-8?B?ZmFZM1Q4K3BLZlliZlB0aXMvNitnT3NKSnRsRUxoN2FPMHlpa0xPQkRmZ1VT?=
 =?utf-8?B?dnJoY2FDR3BoVjBtN0RaYVpBK1B3YzdocHlLdzRhNlJvNGgwd3BVTU8rcmE4?=
 =?utf-8?B?ai9ZMHpMekxiZHVLUmtsOHRDaU1DY2lVcEh5UGlxTUtwMmxtUDJtZ1RGaExU?=
 =?utf-8?B?eG9NSnhGWWFCTVEwSHhSelNZcks4SmY2TVIveDRQNEtnTlczdC95Z0pDN21n?=
 =?utf-8?B?N3NVUFpzME4zT0gyMjlQS3pGSS81ai85SnphRG5mMU9Vck53RlZuNU42clJG?=
 =?utf-8?B?V0NyUXFQWUViYU16eWJmbSthMU83Q3pteWMzOEFEcmNLakFqdjFpL05jS1Jj?=
 =?utf-8?B?K1Azd2J5TTZ5a0c1WHZMVGZjUlRRVlI5N2xyUUkvcXVZZVdpTUs2bEtCazVq?=
 =?utf-8?B?bTFybkxWamowdy9CNm03RFBHNEF5d3ZGVkIxOVhhd1BmR1kwNmpwWkt3UGpm?=
 =?utf-8?B?Q0tFeUhlYXBVUWRrak5xMkRQOXIvQ0JzZTMxTDB2UERIbUdjQXBTRTZ0TTFM?=
 =?utf-8?B?d3gyUjI4cE9ZZnczRDZrTVBWRi9VY3FSVVBoeG94WHdGL1RHcnZXMVM4NmI4?=
 =?utf-8?B?OEJHOGtJdVZYUzNhbExQdWY4d2J6aHB6YXFKdXVjRVdXK0U4eWtQdm5qcmRr?=
 =?utf-8?B?UDI3NWxraDRhdEJRT1ZXVkxkQ2F5bEllYTVuRmtyd0dhUUdEb1p6K3lZRGtD?=
 =?utf-8?B?UmNuMUFnZlh0OE1OMjhOcSsxTFFKMGVJamtzZDJiNUlKVFVWRnJJK3lyaERB?=
 =?utf-8?B?UFEvQUNQVmYvZzhiRzYwYWlrVjh0SDN6V3BFejZNTWY2Q2MraERBMWZIYmZR?=
 =?utf-8?B?a0pmcUZYN1R2ZDhYZjR2YUg1VEV1Njh0bkMxcmx5QzVYdVpmWDFpcjdyTS9X?=
 =?utf-8?B?MDRJNlphUDdveU1QejNsUFVhOHJtTWN6TjdFaEhONndOdWFEM3pwclNxc1Ji?=
 =?utf-8?B?MnVqakJtUU5jQ3BWbXNiUExoNU9VbldZSnRSNk5xZ2lRZzhyUW5HeTgySnBW?=
 =?utf-8?B?SkdXUGxNc3MxZ1FNTG1XU3pmQnBZQlRPeS81UTIzYmlVY1JmUXFpS2hQSGhy?=
 =?utf-8?B?Z254TUVhL0w0V3lTQkxiV0JqYnlNcWlPQlYwaGNyUFkwNTFNQzNiYWlMM2RF?=
 =?utf-8?B?cFZlVExMSDFWbUdER3E5L3ViSzkxR011TEpPeEZHeHIxdFhhQkN1WHJwaTVD?=
 =?utf-8?B?NThzZThyc3VJcE5MSTFWNzJuWUJxZnBCRjdwbGhHT0RsMHNlRTMvVWFsV043?=
 =?utf-8?B?cUxWRm54dHZKa3FrWVIwNkFhai9yOG1USGwwbXhsSmtJanFTTTBzZWJiQ08x?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24702460A05E394482F1568C0E11240F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	n9e953EfjdAUuvuShL4d7CbPd+LsI5Y2n5dhqFj0IRmloG9gUjn3Q6/PLtItEUfumREEb99mDvrFjFovBaxSY9skvIXDcK+5Go/7vJmjAHF84TSqZbMV6kNN20IHzT2/toT29QsnD4HUzGmWJyRpxhmkxQYxbq1a2ATG+Ub4wfdn6z1IZnWEObdCAN/Iq0lGeyxqn4oeBkS6VhYJ3TpjybUCfK/e6lQixc7vNZpMeZJF3ZuYybFDrvyIHy1b6rdz8wzsSOy3QuWhQ0KeRi0IuIL5Yr0tJ+LFNKnDZWQtcikwwIwi1tBmR6kyOzK3hjppjedW8UTxVMliNQeHsF/hT1Gqqi9mVJD9bUc+YQZYZGaBcdflcFyxtXS1fYcimOvN/qremFMiHVO7Aq2Cn/RlI5YLy7ql7eX9B6w4EmxpxjbvyR99q7EH+7bUdrkFbMtUlephSom/G4CMsZT5YInkHtMYxXJnzo3QJgWDuSTSbI0qaI26eiQos/5aGkmGKcKDQINLt2thTcFmoUQFIl9H5D9KIuvYU9NE1XwU1nQVCCAy0p4lllQCqZ2sgtwv5ik1xP/Xdj89LiR0o2T+Jw4K3bhToqMbnsYOypVTW0C+Trs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7762.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966c2e05-805b-40b3-a095-08dc9600480a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 16:51:53.2272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X4zlKYoZf5Y3eyFn+tC/lZrdly6304jXvlc9RIZNkVW9DoZCPDyqaBZtvmL0vYztIH7kmXGRzIvoUUNz93t3eCOF7Rp17iUTcqkHaw0URs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_08,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406260123
X-Proofpoint-ORIG-GUID: L0T5X2e6xEfKc3IyE-U5q4nVG5KFlwnR
X-Proofpoint-GUID: L0T5X2e6xEfKc3IyE-U5q4nVG5KFlwnR

DQoNCj4gT24gSnVuIDYsIDIwMjQsIGF0IDM6NDDigK9QTSwgQXJ1bmEgUmFtYWtyaXNobmEgPGFy
dW5hLnJhbWFrcmlzaG5hQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gdjUgdXBkYXRlczoNCj4g
LSBObyBtYWpvciBjaGFuZ2VzLCBtb3N0bHkgYSByZXNlbmQgb2YgdjQgLSBleGNlcHQgZm9yIHVw
ZGF0aW5nIHRoZQ0KPiAgY29tbWl0IGRlc2NyaXB0aW9uIGZvciBwYXRjaCA1LzUNCj4gDQo+IHY0
IHVwZGF0ZXMgKGJhc2VkIG9uIHJldmlldyBmZWVkYmFjayBmcm9tIFRob21hcyBHbGVpeG5lcik6
DQo+IC0gU2ltcGxpZmllZCB1cGRhdGVfcGtydV9pbl9zaWdmcmFtZSgpDQo+IC0gQ2hhbmdlZCBz
aWdwa3J1IHRvIGVuYWJsZSBtaW5pbWFsbHkgcmVxdWlyZWQga2V5cyAoaW5pdF9wa3J1IGFuZA0K
PiAgY3VycmVudA0KPiAgcGtydSkNCj4gLSBNb2RpZmllZCBwa2V5X3NpZ2hhbmRsZXJfdGVzdHMu
YyB0byB1c2Uga3NlbGZ0dGVzdCBmcmFtZXdvcmsNCj4gLSBGaXhlZCBjb21taXQgZGVzY3JpcHRp
b25zDQo+IC0gRml4ZWQgc2lncmV0dXJuIHVzZSBjYXNlIChwb2ludGVkIG91dCBieSBKZWZmIFh1
KQ0KPiAtIEFkZGVkIGEgbmV3IHNpZ3JldHVybiB0ZXN0IGNhc2UNCj4gDQo+IHYzIHVwZGF0ZXMg
KGJhc2VkIG9uIHJldmlldyBmZWVkYmFjayBmcm9tIEluZ28gTW9sbmFyIGFuZCBEYXZlIEhhbnNl
bik6DQo+IC0gU3BsaXQgdGhlIG9yaWdpbmFsIHBhdGNoIGludG8gMzoNCj4gICAgICAgIC0gZnVu
Y3Rpb24gaW50ZXJmYWNlIGNoYW5nZXMNCj4gICAgICAgIC0gaGVscGVyIGZ1bmN0aW9ucw0KPiAg
ICAgICAgLSBmdW5jdGlvbmFsIGNoYW5nZSB0byB3cml0ZSBwa3J1IG9uIHNpZ2ZyYW1lDQo+IC0g
RW5hYmxlZCBhbGwgcGtleXMgYmVmb3JlIFhTQVZFIC0gaS5lLiB3cnBrcnUoMCksIHJhdGhlciB0
aGFuIGFzc3VtaW5nDQo+IHRoYXQgdGhlIGFsdCBzaWcgc3RhY2sgaXMgYWx3YXlzIHByb3RlY3Rl
ZCBieSBwa2V5IDAuDQo+IC0gQWRkZWQgYSBmZXcgdGVzdCBjYXNlcyBpbiBwa2V5X3NpZ2hhbmRs
ZXJfdGVzdHMuYy4NCj4gDQo+IEkgaGFkIHNvbWUgdHJvdWJsZSBhZGRpbmcgdGhlc2UgdGVzdHMg
dG8NCj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vcHJvdGVjdGlvbl9rZXlzLmMsIHNvIHRo
ZXkncmUgaW4gYSBzZXBhcmF0ZQ0KPiBmaWxlLg0KPiANCj4gQXJ1bmEgUmFtYWtyaXNobmEgKDQp
Og0KPiAgeDg2L3BrZXlzOiBBZGQgUEtSVSBhcyBhIHBhcmFtZXRlciBpbiBzaWduYWwgaGFuZGxp
bmcgZnVuY3Rpb25zDQo+ICB4ODYvcGtleXM6IEFkZCBoZWxwZXIgZnVuY3Rpb25zIHRvIHVwZGF0
ZSBQS1JVIG9uIHNpZ2ZyYW1lDQo+ICB4ODYvcGtleXM6IFVwZGF0ZSBQS1JVIHRvIGVuYWJsZSBt
aW5pbWFsbHkgcmVxdWlyZWQgcGtleXMgYmVmb3JlIFhTQVZFDQo+ICB4ODYvcGtleXM6IFJlc3Rv
cmUgYWx0c3RhY2sgYmVmb3JlIHNpZ2NvbnRleHQNCj4gDQo+IEtlaXRoIEx1Y2FzICgxKToNCj4g
IHNlbGZ0ZXN0cy9tbTogQWRkIG5ldyB0ZXN0Y2FzZXMgZm9yIHBrZXlzDQo+IA0KPiBhcmNoL3g4
Ni9pbmNsdWRlL2FzbS9mcHUvc2lnbmFsLmggICAgICAgICAgICAgfCAgIDIgKy0NCj4gYXJjaC94
ODYvaW5jbHVkZS9hc20vc2lnaGFuZGxpbmcuaCAgICAgICAgICAgIHwgIDEwICstDQo+IGFyY2gv
eDg2L2tlcm5lbC9mcHUvc2lnbmFsLmMgICAgICAgICAgICAgICAgICB8ICAyNyArLQ0KPiBhcmNo
L3g4Ni9rZXJuZWwvZnB1L3hzdGF0ZS5jICAgICAgICAgICAgICAgICAgfCAgMTMgKw0KPiBhcmNo
L3g4Ni9rZXJuZWwvZnB1L3hzdGF0ZS5oICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiBhcmNo
L3g4Ni9rZXJuZWwvc2lnbmFsLmMgICAgICAgICAgICAgICAgICAgICAgfCAgNDIgKy0NCj4gYXJj
aC94ODYva2VybmVsL3NpZ25hbF8zMi5jICAgICAgICAgICAgICAgICAgIHwgIDEyICstDQo+IGFy
Y2gveDg2L2tlcm5lbC9zaWduYWxfNjQuYyAgICAgICAgICAgICAgICAgICB8ICAxNCArLQ0KPiB0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9NYWtlZmlsZSAgICAgICAgICAgfCAgIDUgKy0NCj4g
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vcGtleS1oZWxwZXJzLmggICAgIHwgIDExICstDQo+
IC4uLi9zZWxmdGVzdHMvbW0vcGtleV9zaWdoYW5kbGVyX3Rlc3RzLmMgICAgICB8IDQ3OSArKysr
KysrKysrKysrKysrKysNCj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vcHJvdGVjdGlvbl9r
ZXlzLmMgIHwgIDEwIC0NCj4gMTIgZmlsZXMgY2hhbmdlZCwgNTgxIGluc2VydGlvbnMoKyksIDQ1
IGRlbGV0aW9ucygtKQ0KPiBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvbW0vcGtleV9zaWdoYW5kbGVyX3Rlc3RzLmMNCj4gDQo+IA0KPiBiYXNlLWNvbW1pdDogYTM4
Mjk3ZTNmYjAxMmRkZmE3Y2UwMzIxYTdlNWE4ZGFlYjE4NzJiNg0KPiBwcmVyZXF1aXNpdGUtcGF0
Y2gtaWQ6IGQ4NDQzOTMwMWI0NGMwM2RmMjU1NWQzNzIyZWM1MTIwMDFhZTUyZjINCj4gLS0gDQo+
IDIuMzkuMw0KPiANCg0KDQpUaG9tYXMvSW5nby9EYXZlLA0KDQpDb3VsZCB5b3UgcGxlYXNlIHJl
dmlldyB0aGlzIHBhdGNoIGFuZCBnaXZlIG1lIHlvdXIgZmVlZGJhY2s/IEplZmYgWHUgaGFzIG1h
ZGUgYSBjb3VwbGUgc3VnZ2VzdGlvbnMgKHRoZSBtYWluIG9uZSBpcyBhYm91dCBlbmFibGluZyBh
bGwgcGtleXMgYmVmb3JlIFhTQVZFKSBhbmQgSSB3YXMgd29uZGVyaW5nIGlmIHlvdSBoYWQgYW55
IHN1Z2dlc3Rpb25zL2NvbW1lbnRzIGJlZm9yZSBJIHNlbmQgb3V0IGEgdjYuDQoNClRoYW5rcyB2
ZXJ5IG11Y2ggZm9yIHlvdXIgdGltZSwNCkFydW5h

