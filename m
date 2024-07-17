Return-Path: <linux-kernel+bounces-255159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AEA933CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F3A1F24459
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAC517FABD;
	Wed, 17 Jul 2024 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="CzRHiFZ6"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C566511CA1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721218643; cv=fail; b=qufzBVz6O5iPm6UKDg6ZqmKn2bgw+FvINpzMEL3DRb05i5bl/LYaKGaI0SACuHtoLCPmnbgvREoWiNbWL0umW1TgmvAaLVi2ScQSarZW8QwtglvF2fusbBMWnNjKi+V6XsS13HWQx7lecS3gwN6wRdq1HYP2zxcp92uO8gV27x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721218643; c=relaxed/simple;
	bh=rngWdunGAqhgfJ4RicXS4UpYMtYptPcaEGkGmfxcnho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Q1+knDlaRZZ1ga4V9vleZl8s2PMsbASCn9hyUnVgstC80IHWwryYTbLbFWdYlB4hR6vfTlUWsPbv+kosPkZ8WI35dktf+haHbC7q4NWY0tMiPSk/E4WBUcyRyO6uhmztCVCB8NbLY/wHumiXLjoqGZz9tqaEjKqs80Ajh96dj5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=CzRHiFZ6 reason="signature verification failed"; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HADGX8023688;
	Wed, 17 Jul 2024 05:17:11 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40ec0b0axp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 05:17:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIZcX5hhGWvrfZ55eUs02DtrGNnfZc/h48WvHihBURKKbunKISaOweSANH0t46A9QkHuc8JOSnOCeYErMbrdm5tpp0juEAk0kaZ5cs8aUGdjiZGtCIBfYG6DZCMK66Gto8qqR7wm0VVitQB5nvB75g8/WhlS/k9Llw0dByByRigTZvUOGDF6g7lPacFQEpjlE9qyfTEod1lGE31TKtNF5/Tjbw4zX+w3xybd8A/u6v85LDg/dADrCv4t89Du3XICX5MjZpIkdriCYpI3f88TTxyebS7aBmbtlh74YWczhmffVBcE5uxHH+QkehJaoeU2rugM5yW5P1APJPhgnQwlXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/7B65q5EdzOX6Kqzy5hF39sd0BZVGGUK6tbVDgucAA=;
 b=BLtqS9YS47FpI2xQhePiXkPhGOvUtcQPoPGTAib25t+23WSoTwRg/mHSDFxHYMHKbxxxEwpKSPQdZ4L44K4NQtZqNUU8cOrS8h4uG9LqjugCvucK3OX9tiuKXqmHLWgTcF1hEgs9BmFwy/Q3kDPEvQtSdLX7QB8zRJ+nE23Pl2t4bApbJ1/3IQaHFsAMg+Zzdn5ro4xb0YqKpGwxENFL9pXhlrkGT7urhnqJu9bn651dZ8Pr0t8Mjy19MH/MEF1A+qcNzfjtSKgPAFVF0WIlyNAtg759u0QBlVNqCu9Jt9KeC5G98v63WRIGrXQSzw/ErLux21Zixk+deEx2DFGx9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/7B65q5EdzOX6Kqzy5hF39sd0BZVGGUK6tbVDgucAA=;
 b=CzRHiFZ6Ya3bCBnF8fw6aV7m0AKTr7dftt0IXdUkDM9NWbxLfNgYmGQom3q22ofwtsL+22DL/lp9Xq+WBOxedLLjwa2QM60y/bmFaOqRtotEBmMohE8gvYFSmqxquj6EOXDFyA65MbOyLVkGJQQ2bEj2jGqPiR3P4nuLAFSNzdw=
Received: from SJ0PR18MB5246.namprd18.prod.outlook.com (2603:10b6:a03:443::6)
 by SA1PR18MB4536.namprd18.prod.outlook.com (2603:10b6:806:1e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 12:17:08 +0000
Received: from SJ0PR18MB5246.namprd18.prod.outlook.com
 ([fe80::5a7c:1cb2:fcc8:8966]) by SJ0PR18MB5246.namprd18.prod.outlook.com
 ([fe80::5a7c:1cb2:fcc8:8966%5]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 12:17:08 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nathan
 Chancellor <nathan@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: RE: [EXTERNAL] Re: [PATCH] misc: mrvl-cn10k-dpi: resolve compilation
 issues on 32-bit ARM
Thread-Topic: [EXTERNAL] Re: [PATCH] misc: mrvl-cn10k-dpi: resolve compilation
 issues on 32-bit ARM
Thread-Index: 
 AQHa2AUlZI50MZOoe0yWhZWePjzeErH6YQQAgAACIRCAAARUgIAAY0ZAgAAEAQCAAASqYA==
Date: Wed, 17 Jul 2024 12:17:08 +0000
Message-ID: 
 <SJ0PR18MB52463B1A7393F36673548989A6A32@SJ0PR18MB5246.namprd18.prod.outlook.com>
References: <20240717045225.138799-1-vattunuru@marvell.com>
 <2024071709-nephew-scooter-5c6b@gregkh>
 <MW4PR18MB5244DBBC231E986EDBEDD5BEA6A32@MW4PR18MB5244.namprd18.prod.outlook.com>
 <22bf9a24-b4db-4017-b5a9-1b03e6f20bff@app.fastmail.com>
 <SJ0PR18MB524672A30BAE8A7163FABECCA6A32@SJ0PR18MB5246.namprd18.prod.outlook.com>
 <024d85a1-6a4e-4552-a5dd-adebfb195be8@app.fastmail.com>
In-Reply-To: <024d85a1-6a4e-4552-a5dd-adebfb195be8@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5246:EE_|SA1PR18MB4536:EE_
x-ms-office365-filtering-correlation-id: 2708f479-1aa8-4155-555c-08dca65a60f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RE9NMVZnL2NTelA2TkZyRG5VdWcvWUVUYWpqUGR1MDczdEJxb3ZQRS9UcmMz?=
 =?utf-8?B?ZllURUdaU0RUQXB5emN3c2tJVFZiaDM5MXlaTllaUFNXTXRGbDlGVkgvWUhM?=
 =?utf-8?B?NjhObmcxVHo3emZTQ2l1b3FoT3RkeDRoY240dlQxZURSWWNrVHpnL3BoZ0tr?=
 =?utf-8?B?aFZLYlo4Y0xpQjFrZC9LU0UxbUdSemprcldyZWtrdTRneEVBK2RVZUVHWjlO?=
 =?utf-8?B?LzBLRnV2REh4cStMQ0JBbXNYRjI2VDlqZlVqNHN6bm56UjNSRjFXcnNONndU?=
 =?utf-8?B?WjBtRHVsZ1l0cXRIZ0ZkRE05VGZyUVhxYTlqMUF3SGFuNUlNVjFOelBoRm5K?=
 =?utf-8?B?M1JkRVUwQUFDMWEzK0k0ejdEVkZwdC95T0RGeUUyelVyUlRNQk9NaVRaTnoy?=
 =?utf-8?B?MGNvaUxBaHFqbVJLRysxSnNIK3NpTHg5YWtPUGNkUkgxMDNlNGtyWW5md0hI?=
 =?utf-8?B?TlRTa2FxMy96NnFtaTIzcjJCZWJRcDJsNGkzR2lDUjAvQ0VWaFJVcCtlRDk4?=
 =?utf-8?B?MHlQemRRRkl6NzZVZndPQ2dOc2tyWGZTR2NUQTJlUm1xYUVjbW1CQlpDbE0w?=
 =?utf-8?B?ZjVyWkNWNVBmR3pZYjhPd01Ua3Q2dTRPWjdBYmQ5VmM1T0dxekVWaHpwdXo1?=
 =?utf-8?B?WXRLb0ZMTUJTMGk0VFMzdFZUTXdCRHVVVDRnY2k1cjZqdklOUWNJSjQvN29N?=
 =?utf-8?B?NXNtYTVRZjZZcFhSaGtvTENMZkV3WkRjamEwM3VuRkZaemJjVE1CMk1WS1Z2?=
 =?utf-8?B?RTJhNGx6U1k3Yk5IWWs4bE1Ydnc0dGNDNWRlN2R3YnROUDdqb1V1OEJnaW1W?=
 =?utf-8?B?L1M0dmlJekFjYUlFQWRiYXcxRmVsQWVJYmNRQXk0ektZcXp2K0FCU3ZpNENU?=
 =?utf-8?B?NWlEaWtTdEh1OVJvT2hMRjYwOFFLV2JyVE56d2d4RFdPakxGNmo2enRha3Jx?=
 =?utf-8?B?bFlGdnM0WFNMaURVaTB3VUlGNGZ5TEhGZ1pBUXo0NWxlRzU3L0dVNFZhSk1K?=
 =?utf-8?B?MURSY3dVVCsyb3psMDB2Y28ralNUajR1KytwNFBlOEFXOTNzdkVLQURXNUw1?=
 =?utf-8?B?amF0NXdsblNyQjZEN2tFMEdZQWRMcTh3bXIrbVJwWlpQalNyc2djK2UwWFlq?=
 =?utf-8?B?WHcvcTMzdFRGMTBqdVJEalpIVC9PU255VW9TM2MrSUFYaWhid0pZK1pmVmtr?=
 =?utf-8?B?MktuVy9qRCs1MTBraWFNVGNGeHRkbVpHZktNdHo2R3gzOW5RZmFKQXhaSHA5?=
 =?utf-8?B?SGd0ZVFmZGo3SkowM3Q0N0xGTzNWeE8xaFNtUXNzYXZUajBEeVB6RFB3Yzdz?=
 =?utf-8?B?UlhLWmlYN0szZDZkUVAvMW1NZFhHSGJGWVR0OXJNekQwNGkwWm1wcXZXeUs5?=
 =?utf-8?B?U2dONlNSK3ZQemlRLy9PTitYSTNpNFZXVmZxckJqSzhNSlpvK3I2cDZuMU1W?=
 =?utf-8?B?RGlhbW5WVnlWL2NnTWE5bno4N0tISnJxak4vR0lpMmxZUStiUVZBNDhKTEZt?=
 =?utf-8?B?ZnJBcTFsdTZKN3lMa2pHSlFrdnBSVzQweGFNR0ZvSGpYYXVVOWFiT0VLWnRS?=
 =?utf-8?B?NGdNNzRDaC9kMzJLTnlrRitLanhnYWRac3BOSHl6Wmx2bGlWMVNrei9qZzR5?=
 =?utf-8?B?VG1JY01jWVk5STFKWkVOVC95OUNkU0h5NkVld1RuMnVwQlVGaVRHV0dhbmd3?=
 =?utf-8?B?NHNTS1BTak9Va3RqeVVXMnVsRXd0TktlTU9mZzY3bWxDWWhwU1lvMjg0QlMv?=
 =?utf-8?B?cHk0ejlheXN4NmUyeVNzR0w3cHJGK3FTUFpWaHlSUWR0NXdhV29CYTZzZGVL?=
 =?utf-8?B?OHBDQ3JQa3h0TUdreUYrWUxIbFI1ZU5Tbi91T1U0ZC9JNm04dWxlaHlldXJw?=
 =?utf-8?B?N2huckYzZHJDUFVuV1FVdER5R1VrTEZleDc5blhPOW4zMmc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5246.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?enE0RFlhLzB0OFNkQlNYQUtxOERqNHNrVDdENHY1MWtnWHhLOUJGcGoxMlRV?=
 =?utf-8?B?a3IzRHo5ZWU5dXpzNXg5bnltU2pkVkU3WWFZRndnOVlWYUZNNjRCVUVLMFVl?=
 =?utf-8?B?UzZyMGRGeGU0dHZ1d1M0T0xqVlJhMk1Nb0kyaXpPZWdsUTF5U21NRnpoOHkz?=
 =?utf-8?B?M0xEMzNQOEZqdHpEaENCSlNSVDNSMVZWbmdBVUVjM0QvbmlUR1V5MnhGUlNj?=
 =?utf-8?B?WWtGam81T0ZKK1RqR1JlekVwdXgwcEhCOFhkcnBTRlBORUI5cVhmVnJKMWo3?=
 =?utf-8?B?c2R5QlExc1FVcnErMVFyLzM3UDdYYlBpRE9pUDdQUVNJVm1rckl4ZDgvRThs?=
 =?utf-8?B?UllaUExxaUI5ZFZ6S2RJZzhWSnhXdU9DZDVRb2xoL3ZJVXR5L04vcnpUd3lN?=
 =?utf-8?B?dWRGTzZMSzYzQVlNcTRLQVEveTBqTmhabDV1YzMySkU0R05sMGNyY0RoUGxv?=
 =?utf-8?B?Mm8rVng2UDhGRmhOUUlTR3F2QmNmbWd3SzVtbHJjZjZqa2F3eUFlcWExSTN5?=
 =?utf-8?B?V3UrZTNWMC8vYlJvMXVJaHpuelloNHVMckxXVEE3SVFIQWZZTHVVdkoyQ0dt?=
 =?utf-8?B?czB0dnVYZW02L21HMEhlWVVESllBdlZKMVhEL2lRQi8xVlNnUW5EaTQzRmVs?=
 =?utf-8?B?VUpMeW5xSnB2dThpOGtIK2pWbEszSEpPSzd2UitiUlp1cWlIV3lrR29jWGVm?=
 =?utf-8?B?WjBmYzlOYXpyWUZGb3BSeWw4WkkzdnZmQVlXL3duRmFUS3g4aEdWVXlrTm5j?=
 =?utf-8?B?bm4zM3NnUlRZcTlKSUovbXJlMXhOSUhORmdaWlhPRU5LdUR4MkNvS2cyMERa?=
 =?utf-8?B?OGZyOFAxNDBDcUl0MURVU2dKVDlXM1lldFErNlNJR2VlbzBPSDZueWxuTVdn?=
 =?utf-8?B?RmszZFY3ZW5zdGtnQ0hIdDA0RXR3NlpMZkdtVDN3QkNra1FLRWhQOHh3dUtB?=
 =?utf-8?B?UDFjaUkzUlpTWVY5OEd5L0ZzVFNjaHplck1xUkZiTjNFNys4WnNMeURJZCt1?=
 =?utf-8?B?RDJ4eFBQSTZCRlhEUW5lSkRhRXNYMnZ6SElPNC9DY1V1QVcrUU4xbUNSYjdy?=
 =?utf-8?B?MjFpejRtdEY3bjgvNHVLcHZ2SHFZMFN1aDR1LzZVMDBHRXRRaElEK0V5VHc5?=
 =?utf-8?B?K0J2d0dmRWx2SVZrcldBQ0c5SVlnL3l0M2Q2UkM2V3d4TloxTHZiV0k3aitX?=
 =?utf-8?B?b1RGWXlOSitSakdQWVB4NFNHa0ZBNHdTYTFNV3gwK2RXaEZwWmZ4MEhuVUpS?=
 =?utf-8?B?WmNqbGkvU0JtRXJXWENoTGQ2UFpzdWlka3hzQ3lqZ3drc2pKWDJkaDlZdWxO?=
 =?utf-8?B?NG1lSHkzRDgycVNoQTZFa0g0ZElRMFpIQlEwaDFtUVBIR3NoV2tETHJrVVR1?=
 =?utf-8?B?aFpQYmVPeGdIelRQRkRONlZjdEZuSjVpUUwyU0xZV05LWmJCMEprRVhHbnIr?=
 =?utf-8?B?WDloZ28xUEdmd29aQnBTYjI4RHcxcDg4RVlaYlQrdGZzVjYxaG1NeVF2S1Bk?=
 =?utf-8?B?UUdOUGpkSHVDUVZrN3NNZHhIVnFqRmRnRDRJNFA3VTI3d09XTGM5b056bXBy?=
 =?utf-8?B?Y3ltS1R4UmZqcElDTnNIZkh5VU05S2QwR215UElCcm1ZMk1OM29CQ21uMFZ5?=
 =?utf-8?B?Y3N3VGYrVk1PM2VDZVliUEIvZ2RleTNGNDdLTExvZ1pKU2hoYm1Mem8yaVZN?=
 =?utf-8?B?RGpWdkplam1ud1p1aTNRK0daRTVFQ2diK0lteTM2eC82MXdDMnpkUVB0QTdx?=
 =?utf-8?B?QkJHMEZjNnpsYnlDbms1VnFuUlpNbjRoNmdRbW9HOVRBNFVjSU5vb2hiNHNN?=
 =?utf-8?B?ZkFFazhnNm16TU5yYmU2TllPSzgrN0ZEbDhtSmcycnlncHFjZUZCdXhVWlZU?=
 =?utf-8?B?Q09xd3FHZ0VhZjNQRmUvZGRsQkREU3dFNy9qUVlyMEFHeU5RdlJmOGtSSHpj?=
 =?utf-8?B?N0dHaFJ2Tk1XODliQWVzR0lBcGJrNFNTQzVYZE5iN0pBaStMNXVuMzYvMjlH?=
 =?utf-8?B?UnhyM0U2clFMbklDT2poU0NuZk93MmRWSWhpakxHQi9jMFVqNmNtajN0Q1pW?=
 =?utf-8?B?a3h6RVVPZ0pGYnVVNWw5eVpuSU92OUg3UG16QW5XV3lub2pHY2E1YWFETVpu?=
 =?utf-8?Q?eay3sJKA7LoiIAHYUGuWwyJ0U?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5246.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2708f479-1aa8-4155-555c-08dca65a60f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 12:17:08.3091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3jycHysvD2NZDcE21CRxVBCJ0aC09/9jisi2xPMDN7vOItD2v35NOR1NZx2N3NNvNhlz24UlU2zLSYYiuEyDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4536
X-Proofpoint-GUID: F9iBs7wWHhvhAAjtC1OGz0BjU-db04FC
X-Proofpoint-ORIG-GUID: F9iBs7wWHhvhAAjtC1OGz0BjU-db04FC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_08,2024-07-17_01,2024-05-17_01



>-----Original Message-----
>From: Arnd Bergmann <arnd@arndb.de>
>Sent: Wednesday, July 17, 2024 5:20 PM
>To: Vamsi Krishna Attunuru <vattunuru@marvell.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>
>Cc: linux-kernel@vger.kernel.org; Nathan Chancellor <nathan@kernel.org>;
>Jeff Johnson <quic_jjohnson@quicinc.com>
>Subject: Re: [EXTERNAL] Re: [PATCH] misc: mrvl-cn10k-dpi: resolve
>compilation issues on 32-bit ARM
>
>On Wed, Jul 17, 2024, at 13:=E2=80=8A45, Vamsi Krishna Attunuru wrote: > >=
 Neither of
>them worked in our case, HW folks also confirmed that only > 64bit access
>work correctly. > I will just include the header that address the compilat=
ion
>
>On Wed, Jul 17, 2024, at 13:45, Vamsi Krishna Attunuru wrote:
>>
>> Neither of them worked in our case, HW folks also confirmed that only
>> 64bit access work correctly.
>> I will just include the header that address the compilation errors
>> with ARCH=3Darm, anyways nobody will use this driver on 32-bit kernel.
>
>Please just use a Kconfig dependency then. If the device requires 64-bit
>register access, then the driver should not use the fallback.

Ack, since it needs to skip compilation on 32-bit platforms, can you please
confirm below change is suffice or not.

--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -588,7 +588,7 @@ config NSM
 config MARVELL_CN10K_DPI
        tristate "Octeon CN10K DPI driver"
        depends on PCI
-       depends on ARCH_THUNDER || COMPILE_TEST
+       depends on (ARCH_THUNDER || COMPILE_TEST) && 64BIT
        help

Regards
Vamsi
>
>     Arnd

