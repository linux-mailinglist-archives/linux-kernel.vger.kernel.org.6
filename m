Return-Path: <linux-kernel+bounces-428180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDF69E0BC6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF8F6B6212C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC7B1DE2A7;
	Mon,  2 Dec 2024 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="llfNUBAr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EVqXo6SR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADCE1DDC32
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164453; cv=fail; b=qOOCqp1ZE83VXEUAUSYjZzjd3eqbNz6Zzljj1EXRdpdem8d2I+duswAU/rkh3ZREwtvSrhMSodY7y1kOzR6Wf07A5hC2/+V8mElKgY1h5W2TEew/lHY5+Tmg+7Zrk92+mbN/zcnsIS578bvdyEpJpqGTBJK9Ak/cUNunY8HXFdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164453; c=relaxed/simple;
	bh=xppyLAtJ1jYBF4Vzhjl1Yv6yQJWTsB4L1PmRijAb8Lo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oJsePw3cbpy2BakTQ0PV+zSDQW9A9BsDNgYb5qt/gZ8oL9pbBeUWXDZD2JLDKLNd0okAQjweSELmmn8YwRUX48bdTHYDWtTDiwgGQ0U9KYP7TUkH/kiVtBU15Lb7BK2+hZDE9iagTex3Z5p0uhxfi6kiwon1Poy6guDsZWa+xAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=llfNUBAr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EVqXo6SR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2HfjI5007340;
	Mon, 2 Dec 2024 18:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xppyLAtJ1jYBF4Vzhjl1Yv6yQJWTsB4L1PmRijAb8Lo=; b=
	llfNUBArSf1iBlUiHT/Ibjrg98rJUPhLHKuFpsDd/s+262eZAUnV6GzDcl9M6srR
	Wj6tGTb3Ww6FX1Ouh0I5tRQtMjuPOCasfn3UZBKzXGZNaN8ao3Vj53AvHNi86Amo
	5maFJsI1rsveHfufe1gf2LO+2WsZOdcxcGakKSC5Op+Eh3vPwKweI5dSTRlm9cm2
	hwRCOvgNoCJFTqEA8dTeRs52vSftKuy+Ah9oNlmvhehJG5WEG3Z7Oo5nWeERo+Wk
	UOS+dc45FKi9yQAKmIfDPMvOTKQ+ZW877c5nshMiHnpZQa9Qgt/DV4fHl/p7h5Tx
	3D+mv9hzi/eRJNV8aLl2Qw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437smac9q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 18:34:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2IJ0BA039065;
	Mon, 2 Dec 2024 18:34:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s56y231-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 18:34:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhkI58XatHMfQv/k2Bly5JU3u+F+1bOLOgSMBpU3FL1Nz9xSV9j3fcbJDI2+6+S/fSXE0wNu4ywDYk9LEQA3GqZjIAZ2YNtYYKi4ApuCBJhraa2zhwoquiaU51vh5RhfGsxyxTv0Ekh2hzm0JzrBTNRn12imh1LCOvR35KgLCovavOn7N7R3Ja2YUUdO+uuQ7rjqAUrx5TRojw/mQtqImVK34CbHHtX/jY9ib8Yrzc5mSD4o/NqkVhkgJGtJH8D8HiS5ZJQcVs0g2yGZU5Ry4mliEUtAfPbrHtQEWdahOuSuGHNYYolAJPKdvHcIEHqbRvMypX9J6NILC3JDjUyOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xppyLAtJ1jYBF4Vzhjl1Yv6yQJWTsB4L1PmRijAb8Lo=;
 b=Nxd1d9StVmRB1IAyoIoeohNZuHWdJfwQswMeHJTW2F+3k6py+VxXO70eKOB3qp0Xr9dUvwMQpvxhKNjZs9rfZQ4oi9t+BdkctKVBu26T8igMCyHuIJnOadZjGZ5Ng5reQ37CdMTFzwMlIyHWkZdZg2wdgl6Klg9eJz+1NSFHBPtOR8pwCqV5CbGbDC545LVKQ4TTPZtpJEtCw9wQptFXA75yvU3vIzsNY6NFIxQo5iNNXrGFS1+8TmfqZyVHfbZiBXkQyWI6iSyP56hWZ+sgYjBnIC2Zyhriuf63Y6fq5gxDIuvVZj2Zs9KIBX/7FnCfr5Y3w93qfb5X30LYBdqCKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xppyLAtJ1jYBF4Vzhjl1Yv6yQJWTsB4L1PmRijAb8Lo=;
 b=EVqXo6SRuJ6iDfZk+fwybeK4rDk79QpM0PHBYiDedAdIzrcO31WXYufzqDAxAYeH3YYQWvNeUyutGJZqba2fuRQSnsr+OPKivGBSMpq4ua6BL8n6WjIInFEaZ4lbVWKChozx0GXOkN/h+El4FnD/yg7qHAkWzZIwIuJpVyrA9MI=
Received: from CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7)
 by IA0PR10MB7181.namprd10.prod.outlook.com (2603:10b6:208:400::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 18:34:00 +0000
Received: from CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199]) by CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199%3]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 18:34:00 +0000
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
Subject: Re: [PATCH v3 2/2] x86/pkeys: Set XSTATE_BV[PKRU] to 1 so that PKRU
 is XRSTOR'd correctly
Thread-Topic: [PATCH v3 2/2] x86/pkeys: Set XSTATE_BV[PKRU] to 1 so that PKRU
 is XRSTOR'd correctly
Thread-Index: AQHbOqrRY/PX79H54kuavaeRTOSAsLLEAuwAgA9ZM4A=
Date: Mon, 2 Dec 2024 18:33:59 +0000
Message-ID: <B3A7B8D8-E59F-412F-9228-3F92F050AC69@oracle.com>
References: <20241119174520.3987538-1-aruna.ramakrishna@oracle.com>
 <20241119174520.3987538-3-aruna.ramakrishna@oracle.com>
 <cc87a7ae-4022-45fb-9ec9-c75c65d886c1@intel.com>
In-Reply-To: <cc87a7ae-4022-45fb-9ec9-c75c65d886c1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6708:EE_|IA0PR10MB7181:EE_
x-ms-office365-filtering-correlation-id: cad1e96d-1378-4e2a-d5c2-08dd12ffe385
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VXZ1cHVRQnNnTDB2SHJFMkIwOUJLdy9QcVRaTW9vOFFER1g3ei9QcVZqOGpD?=
 =?utf-8?B?NXRzWHpiZHdOZUxhcC9LWmNlMXBBKzdoNG11ajRpRy9MNlR6dWNHeVpxeWhJ?=
 =?utf-8?B?RG5EVjhzUDNlZ0g5d3NYN0lZS1lCZ1VsSlZHWis5akZUZ0lFaG8reDh1NE9G?=
 =?utf-8?B?ejNFL2d4amF1QzE3TzE3WU4rcHY3ZXdZcXBUSTRuM2tvVW9QYUJINE95Vjkw?=
 =?utf-8?B?YTFoVWdGcGpKK20wcTdESXY4b0tkTHIzMDVEeGpmRjBqdUpnQTBNUVU0djNt?=
 =?utf-8?B?SzF1UiswV2xtUDJYZzFoWUZBWTI0ZThpU1pNLzAzS29ZZm5BeFlraUtCMDFy?=
 =?utf-8?B?eEppT2VaaW1DMk1wVC85NFF4am1NN04wWUxpRmhyWm9sUjNXNUMreExLOEhO?=
 =?utf-8?B?SVZOTEFNamFzSFFEUzBmQkhxMFhlekpYMWlZMWM1YjEzRDc1aVpzTk9jRUJ1?=
 =?utf-8?B?SUx0OVNZRkMzRTlHdmwvdDhZQi8xc0FxQytXbjNVNU1weGlMZ1laMFJKUHFT?=
 =?utf-8?B?aTk1c3RkQTNieVo0MExQcUhMWXQxbW5ON3RERmprbGNQQnluS3hhWUQvUFNz?=
 =?utf-8?B?aVJZVnR1UFZUbkEvdFVIcFhZWG1xNWN5cEU0OEJmdVNDREVEa1FtRC95Z0JM?=
 =?utf-8?B?eFBYdVZwQkkxWGhHa0w0S1lDa3pKWEpGa2M5SDlkeUtXaTUyRVQ3MStneExO?=
 =?utf-8?B?S2xVajdHSnZEY2k1QWNpWlYvRldFNnNRckM5QUpvYms2YTl1c3FidGJGM2M5?=
 =?utf-8?B?L2FHcE15MGJ1RlFQL2xvc2dqQWFrWEs1ajh4SUVMSHpubFM2bXVsQ0NDK0Ez?=
 =?utf-8?B?bXlidmlMNjk1U2FacHBCU2Q1Z1pyeWFHc01PUUVEY0FJK3pRMzE5WE9iVHRM?=
 =?utf-8?B?Mmk1aHlHR21CbFQ2MGdGRlIwa3NPNHBGSHZ2dzM2bmJWTklsWHYwZUczM0VJ?=
 =?utf-8?B?ayt3SWlWTFpaWi90QXNNV2tyOWFJeTFXU2l2djRveXJ5S3Fka3N1Tnlkd21O?=
 =?utf-8?B?TjJuR2t2RHlJRVh4MXBLNVJXejVGYng0WXlIem00Vmg0T1dobzgvMG9MT2hw?=
 =?utf-8?B?K1lmOXBYakExMHZSZHNRa0dNSVl2VkRpQkJZWHNjNy9nc0poQ3J0OUJVRmpm?=
 =?utf-8?B?RE1uTG8rTTU3VE0rMlBmcTBhcUF3djJnaUVCWW9JUzJvaWlsVXJCNnVDb0Ny?=
 =?utf-8?B?ak45UTkwMlp4WGVtdlZ5VVk5eHpwWWJuWEdGQVQrYTA5bVVDbko0cUtrQnpu?=
 =?utf-8?B?bXViMFlkTkhSVzIwUVpSKzQ5eGZmeVR2aXlIRUpqTWRjOFB2YXV3QVpqNWZC?=
 =?utf-8?B?ajh0WmN0bVRsS25FWGZIdnJ3M2cxYjZlK21iOVFlYVJnSWNlUlViYkQ1T21B?=
 =?utf-8?B?YVhFdmFURmtCWEw0SHRpUUkzUEpIWHVmcTVtTjhWejFWdWhNeUhWWXdSTktx?=
 =?utf-8?B?dmNlejlLT1E2RnNoNkJqUTljSTZNbk94cWdYTUpIUXNTNHZ1empEMUJMM2Mw?=
 =?utf-8?B?YWRibnp1aUZxdlhjc21rR2ZWam11TnQzS2NRMks4VFhxc0RhQ3VhSFVIOTdS?=
 =?utf-8?B?eHY3emlPaXJpRHpxR3o3NnNzRmpVeUdtdUFYY1lBZkNhK04wbm5nZStwbDFz?=
 =?utf-8?B?YVNXYVM2KzBLSlNOVXRtV2JFVzd0L0FsRWFRa0ZZTjcrVFpoeEo1K0VtVE16?=
 =?utf-8?B?MHV4VG82TGN2djVBTDF0UVp5TUZ3M0QrTkVpanM1elhjdkQxNi9BblM4Q0ZK?=
 =?utf-8?B?WW5FSGxZTGVQbTVJMnh5OFJiRW9rWFVMb1Jmc1ZFMmw5aVhtaDFpWHp6SWhH?=
 =?utf-8?B?eHJsdEg4VDJzeG4vazRtQkVTRlVqOGZWbnAxYmorUmtCQlI2ZUxHUTE2WG15?=
 =?utf-8?B?a2hOMDFyY0UzektTYjhnQ0dEdXYwd2VqVGFQYnprUzdrb0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6708.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?LzlsRkpjSW1CeWtxVGt0SXFudG9xNjZSbmZZaW1odURFZXVmTXZvTGNvUzZm?=
 =?utf-8?B?NGFQWDRMWGl0cTJBcHM0RkpWNDB1WWhnRVlaSjVKcnZIOWtjQUM1VW9peXQ0?=
 =?utf-8?B?dFR5Qjd0blhpZFh3eG5yZEc2bFlqcVBldHp1YjJxVEUrbStxNzN1UnhEWU00?=
 =?utf-8?B?enArcll2Yi9hdmRnT2I0dmR6eXN4OXdnVWNWakhxWlQ0TS9XL09VMjFFTnp4?=
 =?utf-8?B?U3htM1NvbFJST2NMcmZnWEdkQ295d2ZESVBaK3I3R1RaYUJSL1krVHF2U01Z?=
 =?utf-8?B?bk54NVpOcHZNTVZNcWZ6TFhwa0JTbDZZY2JGOG1WTS90Uk5Pc25ob042NnI0?=
 =?utf-8?B?YU4rRGdpaHRMY2ZUMDdna3Uvai9WQnFSV2g0UzRmeEdDWThPMzRFQllRRFo3?=
 =?utf-8?B?bUJNS2lCNkdPNHA4ME1oR2RlUmJLWDBYQTZzTGpTNjNXMWNIOEdJeWhrSW1R?=
 =?utf-8?B?K09JczJQdFBWZU5kNXhLYUhHNXJwV2hXekpNZ0ltUzFwZGhrOFJ5YkhzYmxm?=
 =?utf-8?B?R21tTkNRWW9DVmM0N3RpS1VnNjhYdytWSGlxTEhnMHJCR1d3TDVGUGdCREFU?=
 =?utf-8?B?YkxCcUpNekpid20wK2VBbERDTmVRaUc2Q2s0TzV3UklLOThsd0tlSDZUVTBz?=
 =?utf-8?B?VlBTZm5FMit6NnVHUlFQZDNaMkEwMklZMEtrQW5ManFSMlg3NzdwVnlGSjhN?=
 =?utf-8?B?eTFvSzFkRmxmUWdKeTBJbXM5bWh3dHRKWTRDUEd4dzFVb2RleU4rNjg5UWRh?=
 =?utf-8?B?SmJ5amM0a3ZQdGY0RGhOUGdqeU56RnZyamk0UlFxZm9WdU84STVybFAvOCsz?=
 =?utf-8?B?YU5PcE51VFJnQ1ZvR05kaFN2ZFZlU3NjQ2xGdmlhNVpUam1KdzJZU2xkL3V1?=
 =?utf-8?B?QnVnL0JvU0Fwc05SU2NSWjRQdVFyR2w0VCtoNFJKK2xaVm5NT3lsUWtwcUd0?=
 =?utf-8?B?bmR2WC9aQXQxTC9mVHNHY2p0MUt1RnV3NEtaQkVtMEpHVFFYMXM3Q2JQSi9t?=
 =?utf-8?B?SU83UmFOWmF2NlpBUmVhMnkvdytJbDltRUl4K3dCQkYwOUJpNm93czRDSEdo?=
 =?utf-8?B?YzJzS2VINFRvZHNwUkNIb1dqb3BDQXQrWXFmbkdrSURpemRPaWtoYys4dFc5?=
 =?utf-8?B?a0FDZlZmbjY3eE9uNUdDeUxMSGFGWFhKbU1ocE5XU3BQaE82SG9iUlA2VU9t?=
 =?utf-8?B?eXZBT25UQWpCN2VzYmN2cEs3eStCUkJncjdNbndld1U2ZkJ3N0FjNUJpbzVs?=
 =?utf-8?B?Q3JDbHVQaXFTVXVaYldvSCtERGRGejl3MVlhYzNaMnZIVU5CZkVZVkx1Yzht?=
 =?utf-8?B?UzNjdm5WcldwWXRseTlzaUhnTUh1V2RDR0MxdXN1TUE0KzUyY1BDRmhBcDNs?=
 =?utf-8?B?REhmSVFDMWx6ZmE0dGY2dHF3VTIxMkNJbThjSVpXWFgxc3B1NHFTTm1JdWJq?=
 =?utf-8?B?aTZoN0R6N25pK05JY2FyTlpocFdsYTFNbjdHekVub3RoT1hWOWpXNHVOZGdR?=
 =?utf-8?B?RkN1Y3FwNXlmdVRxU3VQYzlVQ1VmL3h3dnZ2MkM1dU40VzVORkNTR2VSSFB6?=
 =?utf-8?B?RXBZbEVQazhQVkoyeEJRM1ZRamRkdm9Vdk5Nd2VEWTFzbzVra09FYVIxYTFW?=
 =?utf-8?B?a0Y5a0ZqVk1YZTNUcFBDMVorM2pWTVpHVmRiT1RyUDJacERYT1pMaUoxaXNX?=
 =?utf-8?B?SHExeUFHNXk5Q05tRTNoMjhyVk4wd0hnVUpGWEdMU2ZXWjc2MEx0M015Rm8y?=
 =?utf-8?B?TGhUZ1VTY2U3bUxqUTFNWDFPWXRSS0IxOHdSM0xJbnRxbkwyTEhnalQzUlhn?=
 =?utf-8?B?V1g5WmYxeVdFT1gvbzZKVFlPeDQ1eVZJV1RQZzBjaHVUV2FGSEEwVXgyTE9o?=
 =?utf-8?B?Um9VNGozM1dVWW44dXpJenBRVWhWZHZUR2V0Q21iUHlyQ0FLOVJqVEpMUlZ1?=
 =?utf-8?B?Nko2Tk5TaW1nV0tJRFZBdysvSFkrQmtOMUI1SGliOW5hQmp1YlBWcFIvSXE3?=
 =?utf-8?B?cHI0Zk5uZW45QXRTODBaYWoyU2NmLzdDdVJXZDBnbmhudXdIaEh6UThhcnRU?=
 =?utf-8?B?OXAvS0doVmJwY3FaMFpIZUxTQUFOR2N2MmVXbXU5YnZSV2g2Z0hXaUYxYUVy?=
 =?utf-8?B?c0VBRzRyTEVPUGZLT0VqbHNsQm84WGp1SmxuOFJJOXJMS2JVbFRpaHhyTnU3?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D877460583FE24E9701E272E60F5DFC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kTnIjdtsnTyhfRQoQ/o7dibk40/ukrJa8AVvGmZNJeOQITbuwxvLFnfDje+rlBLiok8ZJ9+eno0YOOgeuicXBVPVq5e2XRXPIi/vdwTxSQFxY33pjzfLIFRigCyv6aFvLaJ2imW4TxS23EugdyWXcs+j+EfEEvDWxq+Vhzyv5B/dqwijCNsxGbf5NlZlbR77pX6Zg2SJJYVkQMTw+hVas71VnbThOpZszElEXAp9Zv6X+FguqX1YCF7/ZU79eGB1CUyni0Jr6Dn6Z0/26c8qVKG3Mn+oqiiflhikLSXTThMPgk5EyXSegEI5sO0WLODZKrdpX6ItoevUQjfZbi6S7RFEjbYnWlVT3JuGj80IyjvTWqAlCZWIfMx3JgDmWjhW6xc7N0tznU4dNGg5O70YHCz9pF/dQd/MVyCVr2KMwoa2rsgH8uLeAxoqxEsb4BVCVpz5FER5ftC33HKz8fNVdbEILraKNnNR+Q2QURgQP7vpDQc5eOQjXGjN9ZawRl8utU8gZYqhiGQPdbvqBuGuPXZ7s9DA5KaRhW7Nw1wSKK33pcoOCh87wKYkpZ7jLRqVUaiVlFWpUZ8j3Ht0teXdmHqP+y7vJvzUoaofoWhQ0/4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6708.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad1e96d-1378-4e2a-d5c2-08dd12ffe385
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 18:33:59.9052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0sSAgCbiq9lNQvUOxSNP03/lhWStY/QUHTbVDTI7C+Ns9QfTspupA0rxlEOSTZCmlcHZmhpS/C8u7vEd9loGLvcl3G/vNVn9G0ua9zhvxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_13,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020157
X-Proofpoint-ORIG-GUID: LxRiuGjY3X98vimNZ2XrP1mxJ70KAKY2
X-Proofpoint-GUID: LxRiuGjY3X98vimNZ2XrP1mxJ70KAKY2

DQoNCj4gT24gTm92IDIyLCAyMDI0LCBhdCA0OjEw4oCvUE0sIERhdmUgSGFuc2VuIDxkYXZlLmhh
bnNlbkBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gT24gMTEvMTkvMjQgMDk6NDUsIEFydW5hIFJh
bWFrcmlzaG5hIHdyb3RlOg0KPj4gUEtSVSB2YWx1ZSBpcyBub3QgWFJTVE9SJ2QgZnJvbSB0aGUg
WFNBVkUgYXJlYSBpZiB0aGUgY29ycmVzcG9uZGluZw0KPj4gWFNUQVRFX0JWW2ldIGJpdCBpcyAw
LiBBIHdycGtydSgwKSBzZXRzIFhTVEFURV9CVltQS1JVXSB0byAwIG9uIEFNRA0KPj4gc3lzdGVt
cywgd2hpY2ggbWVhbnMgdGhlIFBLUlUgdmFsdWUgdXBkYXRlZCBvbiB0aGUgc2lnZnJhbWUgbGF0
ZXIgb24sDQo+PiBpbiB1cGRhdGVfcGtydV9pbl9zaWdmcmFtZSgpLCBpcyBpZ25vcmVkLg0KPj4g
DQo+PiBUbyBtYWtlIHRoaXMgYmVoYXZpb3IgY29uc2lzdGVudCBhY3Jvc3MgSW50ZWwgYW5kIEFN
RCBzeXN0ZW1zLCBhbmQgdG8NCj4+IGVuc3VyZSB0aGF0IHRoZSBQS1JVIHZhbHVlIHVwZGF0ZWQg
b24gdGhlIHNpZ2ZyYW1lIGlzIGFsd2F5cyByZXN0b3JlZA0KPj4gY29ycmVjdGx5LCBleHBsaWNp
dGx5IHNldCBYU1RBVEVfQlZbUEtSVV0gdG8gMS4NCj4+IA0KPj4gRml4ZXM6IDcwMDQ0ZGYyNTBk
MCAoIng4Ni9wa2V5czogVXBkYXRlIFBLUlUgdG8gZW5hYmxlIGFsbCBwa2V5cyBiZWZvcmUgWFNB
VkUiKQ0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBBcnVuYSBSYW1ha3Jpc2huYSA8YXJ1bmEucmFt
YWtyaXNobmFAb3JhY2xlLmNvbT4NCj4+IFN1Z2dlc3RlZC1ieTogUnVkaSBIb3JuIDxydWRpLmhv
cm5Ab3JhY2xlLmNvbT4NCj4gDQo+IEkgc3RpbGwgdGhpbmsgdGhpcyBjaGFuZ2Vsb2cgbmVlZHMg
cXVpdGUgYSBiaXQgb2Ygd29yayBmb3Igc29tZW9uZSB0bw0KPiBtYWtlIHNlbnNlIG9mIHRoaXMg
aWYgdGhleSByZWFkIGl0IGluIGEgeWVhci4gIFBlcmhhcHM6DQo+IA0KPiAtLQ0KPiANCj4gV2hl
biBYU1RBVEVfQlZbaV0gaXMgMCwgYW5kIFhSU1RPUiBhdHRlbXB0cyB0byByZXN0b3JlIHN0YXRl
IGNvbXBvbmVudA0KPiAnaScgaXQgaWdub3JlcyBhbnkgdmFsdWUgaW4gdGhlIFhTQVZFIGJ1ZmZl
ciBhbmQgaW5zdGVhZCByZXN0b3JlcyB0aGUNCj4gc3RhdGUgY29tcG9uZW50J3MgaW5pdCB2YWx1
ZS4NCj4gDQo+IFRoaXMgbWVhbnMgdGhhdCBpZiBYU0FWRSB3cml0ZXMgWFNUQVRFX0JWW1BLUlVd
PTAgdGhlbiBYUlNUT1Igd2lsbA0KPiBpZ25vcmUgdGhlIHZhbHVlIHRoYXQgdXBkYXRlX3BrcnVf
aW5fc2lnZnJhbWUoKSB3cml0ZXMgdG8gdGhlIFhTQVZFIGJ1ZmZlci4NCj4gDQo+IFhTVEFURV9C
VltQS1JVXSBvbmx5IGdldHMgd3JpdHRlbiBhcyAwIGlmIFBLUlUgaXMgaW4gaXRzIGluaXQgc3Rh
dGUuIE9uDQo+IEludGVsIENQVXMsIGJhc2ljYWxseSBuZXZlciBoYXBwZW5zIGJlY2F1c2UgdGhl
IGtlcm5lbCB1c3VhbGx5DQo+IG92ZXJ3cml0ZXMgdGhlIGluaXQgdmFsdWUgKGFzaWRlOiB0aGlz
IGlzIHdoeSB3ZSBkaWRuJ3Qgbm90aWNlIHRoaXMgYnVnDQo+IHVudGlsIG5vdykuIEJ1dCBvbiBB
TUQsIHRoZSBpbml0IHRyYWNrZXIgaXMgbW9yZSBhZ2dyZXNzaXZlIGFuZCB3aWxsDQo+IHRyYWNr
IFBLUlUgYXMgYmVpbmcgaW4gaXRzIGluaXQgc3RhdGUgdXBvbiBhbnkgd3Jwa3J1KDB4MCkuDQo+
IFVuZm9ydHVuYXRlbHksIHNpZ19wcmVwYXJlX3BrcnUoKSBkb2VzIGp1c3QgdGhhdDogd3Jwa3J1
KDB4MCkuDQo+IA0KPiBUbyBmaXggdGhpcywgYWx3YXlzIG92ZXJ3cml0ZSB0aGUgc2lnZnJhbWUg
WFNUQVRFX0JWIHdpdGggYSB2YWx1ZSB0aGF0DQo+IGhhcyBYU1RBVEVfQlZbUEtSVV09PTEuICBU
aGlzIGVuc3VyZXMgdGhhdCBYUlNUT1Igd2lsbCBub3QgaWdub3JlIHdoYXQNCj4gdXBkYXRlX3Br
cnVfaW5fc2lnZnJhbWUoKSB3cm90ZS4NCj4gDQo+IFRoZSBwcm9ibGVtYXRpYyBzZXF1ZW5jZSBv
ZiBldmVudHMgaXMgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4gDQo+IFVzZXJzcGFjZSBkb2VzOg0K
PiAqIHdycGtydSgweGZmZmYwMDAwKSAob3Igd2hhdGV2ZXIpDQo+ICogSGFyZHdhcmUgc2V0czog
WElOVVNFW1BLUlVdPTENCj4gU2lnbmFsIGhhcHBlbnMsIGtlcm5lbCBpcyBlbnRlcmVkOg0KPiAq
IHNpZ19wcmVwYXJlX3BrcnUoKSA9PiB3cnBrcnUoMHgwMDAwMDAwMCkNCj4gKiBIYXJkd2FyZSBz
ZXRzOiBYSU5VU0VbUEtSVV09MCAoYWdncmVzc2l2ZSBBTUQgaW5pdCB0cmFja2VyKQ0KPiAqIFhT
QVZFIHdyaXRlcyBtb3N0IG9mIFhTQVZFIGJ1ZmZlciwgaW5jbHVkaW5nDQo+ICBYU1RBVEVfQlZb
UEtSVV09WElOVVNFW1BLUlVdPTANCj4gKiB1cGRhdGVfcGtydV9pbl9zaWdmcmFtZSgpIG92ZXJ3
cml0ZSBQS1JVIGluIFhTQVZFIGJ1ZmZlcg0KPiAuLi4gc2lnbmFsIGhhbmRsaW5nDQo+ICogWFJT
VE9SIHNlZXMgWFNUQVRFX0JWW1BLUlVdPT0wLCBpZ25vcmVzIGp1c3Qtd3JpdHRlbiB2YWx1ZQ0K
PiAgZnJvbSB1cGRhdGVfcGtydV9pbl9zaWdmcmFtZSgpDQo+IA0KPiBCdXQgb3RoZXJ3aXNlLCBJ
IHRoaW5rIHRoZSBjb2RlIGlzIGZpbmU6DQo+IA0KPiBBY2tlZC1ieTogRGF2ZSBIYW5zZW4gPGRh
dmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCj4gDQo+IEkgY2FuIGZpeCB1cCB0aGUgY2hhbmdl
bG9nIGF0IGFwcGxpY2F0aW9uIHRpbWUgaWYgZXZlcnlvbmUgaXMgT0sgd2l0aCBpdC4NCg0KVGhh
bmsgeW91IERhdmUuIEkgYWdyZWUsIHRoaXMgcmVhZHMgYmV0dGVyLg0KDQpJ4oCZbSBhIGxpdHRs
ZSB1bmNsZWFyIGlmIEkgc2hvdWxkIHNlbmQgb3V0IGEgdjQgd2l0aCB0aGUgdXBkYXRlZCBjaGFu
Z2Vsb2cuDQoNClRoYW5rcywNCkFydW5hDQoNCg0K

