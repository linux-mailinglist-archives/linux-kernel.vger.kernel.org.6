Return-Path: <linux-kernel+bounces-448796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB719F4597
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D3516CD12
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B651D86F6;
	Tue, 17 Dec 2024 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jeqaYK8A"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2081.outbound.protection.outlook.com [40.107.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F74A29;
	Tue, 17 Dec 2024 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422333; cv=fail; b=kQFi0DHruHoqjX7t/eYcXOnj3cu+kNqU5s/0LLDcgdpmrwHToCS2RiQbqs1PaIOH7wmQP/TpJLw5l4z6qzrjJ0dRDkn3YGAkonz1iyrDEfv7OW0sV/qPKmjcEGBxRssSexciwjyTmBgD7LPq2THE5jS78EE0XEnU6xiiCe4LCkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422333; c=relaxed/simple;
	bh=3wcSnRRZELF3fJKPH1lIhnRy/mM2LvyaExyO+sootHo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HlKG+AFTDZjyfARZWvpI/N2UIO3yFm2Bs/zT+GZnM0/wJZiyln2dpCNeDWf7lFfCNykkzDhV+YqIy953IGpSv7BsQTE5uiJBFU53MQCuEjy+EAmUcfqp9tw8AgGa4iNzLASCvGzfc/peA6rjLe9dBdcL+a3Y2rhHtriUuu79U5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jeqaYK8A; arc=fail smtp.client-ip=40.107.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWLNX4Cc3z9dDP29r5DaZqCToN1lGKTbtK4S8+7sGk1/mmwAPeTNR1JroZhZnHiW5mPb/8HjxMrFGlOVAV1MJFcrhiZfFe+Fq7pXcNgaL/kaQmI9HuhdAb8NMKqA+V8tWG6K0Z5N1mDjt3bYlqb+RruipIAHi6GZioqIdUpxPHEu964ezgqSPGsglzgTecvY2HnjLAlg/727XhCOteVUHxCHOS/umDDsCTBLzZ76MTc32cA1NFDym2Dwtrdb7BS5XmHTleQUA0i0p/lYgLef9v5pYrHFqJhHLbqmGGpIdEIH37Fq17b/Pm93iOQQg1VNp7+H76pO3W2PhMPIcR0MUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wcSnRRZELF3fJKPH1lIhnRy/mM2LvyaExyO+sootHo=;
 b=cvjzL1LWJaVF65wR19z2ZN+ilS6RBSHOyxWGihuaPvHHNSGN+luuV9mlBvC1ZqzxFq63xar5aTE1OWoeMWazx9abNTv9LcCgJ6BPJVrhWD5Ovpgg/Ub4N+CkHrom11RZZf05auucWjd5akORoSd2Uv/MHmWT71trP7Oqs3g4z7vSF1grT+q46c5aqGA4Neg57VaPtvL+vE/rcBLgH9Gc3h8nva3I/MeZtcTZj4akDQF8pwReEcKH6qBBDysxIq2SWLO952O0no4M/lx7w3ADKud/oSMJUG3hj3PD0JcdrrN8hJYBN00N/X9TX8+Y2MCbelxXuj2gPGhqOAbotEVB2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wcSnRRZELF3fJKPH1lIhnRy/mM2LvyaExyO+sootHo=;
 b=jeqaYK8AEnA2cUm6wnshQcFV6CCjadeMtf9HPsSJoCrRTrTrgF+lPc/8YGi+DCFabXBDuoNBvX+VrtBvt/RfXKjpsLR7vR5gXpAS5RP4oudFtBJ/DbJkCdqIBln1vWnfPAaLkOyu4/lH5m1LTDGTJyNSKd1E1Zy1qsEiugVmPFlb6r1n7Wl6F/8pii7ClOZE1O2+RFxt+TipNEY4Q0eKwscEC2KdMDJxeVzaqxBNOLcVH8zrPK0CmBWbHg1qrY0OK8tTV1O5BABbsu9AyfPo8x0A0YomJHVX5vSwzEfu/awhhgOefGVvJOaP2sxzP4dkYjhamkbjD3X9PIpkmCabVg==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by PUZPR06MB5517.apcprd06.prod.outlook.com (2603:1096:301:fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.11; Tue, 17 Dec
 2024 07:58:44 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%6]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 07:58:44 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Prashanth K
	<quic_prashk@quicinc.com>, "mwalle@kernel.org" <mwalle@kernel.org>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>, David Brownell
	<dbrownell@users.sourceforge.net>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>, opensource.kernel
	<opensource.kernel@vivo.com>
Subject: [PATCH v3] usb: gadget: u_serial: Disable ep before setting port to
 null to fix the crash caused by port being null
Thread-Topic: [PATCH v3] usb: gadget: u_serial: Disable ep before setting port
 to null to fix the crash caused by port being null
Thread-Index: AdtQVu3p636G49OMSa2yDMmE+bdUDg==
Date: Tue, 17 Dec 2024 07:58:44 +0000
Message-ID:
 <TYUPR06MB621733B5AC690DBDF80A0DCCD2042@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|PUZPR06MB5517:EE_
x-ms-office365-filtering-correlation-id: 67914c1d-a921-46e7-b7b2-08dd1e70a11a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?QWpBZXV4c2xLVWNuT3dYMm5SZXVKaThkK1BmWVQ1a0tja1U0a01yMDRsZWIr?=
 =?gb2312?B?YnVqQ0ZyaC9WVkdDcVVveHBoUnU3UHBwVVc3dmVxd0hQTHpzNVdXU1I1eGlG?=
 =?gb2312?B?V3BqcXY3ZjRnUE0xKzNKdlEyaGlkeVpVbzFlTjFpUEZ3RUpiYWZnbDFJL0hQ?=
 =?gb2312?B?VFBLclFkcTRNSDdSWUYvMGdSckIwd3BEL2kwcEM5eG5xOWVwcUZFa1FEZTJN?=
 =?gb2312?B?WlozWEQrVGFxOGVvSG1mQ05tNFJXc1J3UWtRK1B4d1V1SGZaNGRyTkJQU2ho?=
 =?gb2312?B?d1ZnMCtSWGhKcXFNMlVLY3hyTEJHcllQOFVIdlN5aXhVMzZhbWlYaXlJQnJu?=
 =?gb2312?B?Tno1dEYzUFF4SExKUEErNERrTmFiQk5UOS9BUnVDRW1MNHFQdWpINGQwNGda?=
 =?gb2312?B?eHNyeTJNbEgwVG9NektLeEdQeEJJNld4SVpBNTIvL25aakk4akwzcTN2NFFC?=
 =?gb2312?B?MXBHZE8vOGdXbmd5cjNEZVRwNThWbnE2dFJudGVMRHQ2UVZlOHBMWEFpQzlo?=
 =?gb2312?B?ZGxkMlM1Y2JCVzNEaGdtZXVQY09YYVM5YmxYWWV4VTJXYkV2WnpCT3drSTVj?=
 =?gb2312?B?ajBZQ3ViSFRHSmVLd3dFT3gxSy9tZjkxU3BCb0xYNTdzUXFIMkxYL0xtN2pB?=
 =?gb2312?B?cDZZaDltd2tOZGEwcFQyMnVpTWM1SGJqbUc0a3lNcEFFQnlUYlA4K0dnSG5r?=
 =?gb2312?B?WGNDWndTazNxMHByM2w2TjNEemR5YjREZ3J0N2Y5UXpqTWsyUDJaMHo1bkw4?=
 =?gb2312?B?aW0zVVRSNCtFME9IMFo3eVBhVzdHYys1NWhwd2NSb0xJTnMzamdmSFV5emxi?=
 =?gb2312?B?U0tFSXExVUZCd2ZmS0RTaEFHRUJuVzN5VXhKbTlRbjc4RDdLeFAyWUpiVWkr?=
 =?gb2312?B?ZW9FcFJUK1JvZmEwd1BEQStTaGJOTFRqUXA5QWdtdUQ2TmsvSjhmUnM3OWJu?=
 =?gb2312?B?bjRWK1RQSXcyWmVkWVVieUxFZ29MUWIzTEVQYXQ5N0FRODZCQUROWlhlY2tX?=
 =?gb2312?B?N2VRbXRUdUY2YkN1d3k1OWJHd2x1SWxiWHExTWpVdFVMY1M2RjhCd2J4Vmp0?=
 =?gb2312?B?UUlmZWtwM2pCRDRFU0ZRMEl1eEgzeGs3dWdLZ1pEUDg1Zlc0K0pVV3JmR2Uz?=
 =?gb2312?B?K0ZqNFpmeTJQNkpWRStkTWVzMm9XWWhOUExDUytXMDhrNE5kby9wWFdnZ2w5?=
 =?gb2312?B?SnNLTFBRYUdlRE5oY05tT2dqb3BCN0pUNkNTckZ4OGYxdEtuaC96RkdybGhW?=
 =?gb2312?B?ODROdXArclhxdjBsWkxtSWgwQ1p4YUFTK1JOTmVOM3hvbmJQS2ZiMTRHSWYx?=
 =?gb2312?B?NUFHblJwajd6NXBDZEN3LzFXbmMrWEdiQkI2SWNaZW8zdzZ6RlV5VEFjdm1Q?=
 =?gb2312?B?aG9oOEJ0bWlsMFZoRWM5Q1VyWVg5MzY3SDg4TWxxMlA3WThDcTlmVTNGU0hs?=
 =?gb2312?B?MEdCY3h0OWMzZzF1NGJpMzF3QnU3WHpYeDVhaGRNTWc4Z0ZTek1POVFudCt3?=
 =?gb2312?B?bnhOQ2tGbVN1dFRUMUllZXRFclo3b1VyNStmY1lHZzM0OUNHZ044bTJGeDlB?=
 =?gb2312?B?aE9mY2Y4b0VSTk1CTGpVc2hJQkE2aitpZHlZOWRkUm5WQUZEZUxueThyUndn?=
 =?gb2312?B?aG10VXI4SlJBZ25DN1RMRFE3WmxsWGd5VFBTOC94dU51SEN6cTFHMEtZV3FS?=
 =?gb2312?B?OGFOc3VENzcwS3pKcUoyTnZmY0lRRHVWL3BxN1ZXWTZ1WmJubUFtd2lHdFZU?=
 =?gb2312?B?ZlFjK3RRVFBGTTM3ZFgxUlVYU0hSUVd5andUMXpoNllsQXdPVTVuUWRFNDRt?=
 =?gb2312?B?L1BPZEpXeE5xT2RzVXhUY3VHQlgzWnNUMFNsb1JzRTdDR3UxSHU2TW14M0Iw?=
 =?gb2312?B?TTBUWldRZTQvb29SbTJ5NFVwU0I3TlVqb3FyY0VtT1pGU0o4bE1DbFZwUUN1?=
 =?gb2312?Q?gQgmxylvX3pHewsHB1m9zsegTxl20+mv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bjBsSkhrNytIeDVabktJVnoyMFVaYVRkZ3NBOGdjRHNkTlc5VE85KzkwNWMr?=
 =?gb2312?B?eG00dDZjU0FEYnk2ZmZseFhHMlBsMm0yb0NESkRNMkVFZkRsZ1htS25LOGsz?=
 =?gb2312?B?Mk9oUmtmek9BaW9NR1J6QjZGU3Nua25LQjlldXpYT3UwV2ZhUHpqclkzazBk?=
 =?gb2312?B?bEk3ZDVwUjJHMTJrSWJwQ1BlSVRDVUp0UmNkb2pzV1huVEw1MjRlT3JjWFhi?=
 =?gb2312?B?cnFUa0pqd0c5UlpvNlZlNjA4UUVFbm5nZjBtWlVnclVoNzRxekJkckxuOVNs?=
 =?gb2312?B?bnpKZHF2eHhUUWtRcFZ2MmsvQTk1RGtZdDBrTkZTOUREVFVKdEFFVHdDMDNv?=
 =?gb2312?B?akx4dDFOU0ZzZEZJL2N6Zjh2REVVWkJGd09qaFA1N1RPams1ZFBsWmF3WUE4?=
 =?gb2312?B?UDJiNVB1dFllNjNQOTMySUxsM1hiNTU2NFY0UW93aUVZYnNFRi93MVhqOC9t?=
 =?gb2312?B?UDlYcW85Wmk5Q3lrWjBDMUp0eDU5dG5CYkg3alU1S1UzL1VaR1dLd29CNzJ6?=
 =?gb2312?B?cnZ0T1lwOXZIbVd2aytmNjJPNjdRVUwxc3lsN1ZFR09zQkw5MXhFY254TFJ3?=
 =?gb2312?B?QWdDR0RETHJHK1hnclJMSUFwZ0UxUjNSTVl1N3ZWSVRJbFhVWnpYbHpRb0hR?=
 =?gb2312?B?bDJJYnprS3lqcUdCMXl2TWlzRHUxZlVKK1ZROFNjWXRBOS9wa2NTWEpydWVu?=
 =?gb2312?B?eEZZRjdPK0VJcVltU3I1WHVOSHJVTDVLVUYxaEhORnY3clgwU2JwVEQ3Vk9U?=
 =?gb2312?B?dFNtK3l2OXhOU1lnQjZVdGRIdFZDalQ3aEx2ZkQ5Q0VHUTFDTTRialVaM1c2?=
 =?gb2312?B?YmVGN29uR2Q1T3pnR21aMUlQVEx3TUIycE5YRnN5cWNuZUNmcTdYUzZ5dC9M?=
 =?gb2312?B?YUdLRk5nY2tmVkRzcFZkSW9RRFZ2YnN1azlFdGEvQTl5TTlBZjcrMysyOUJU?=
 =?gb2312?B?ekNYMk9XZHRoSDF6NGhZMDRFUmdUQjdMT3BkKytpNlB0MTRPWFloc0tQTDUv?=
 =?gb2312?B?OXFQOGNJNHZsTzBDckRxbEsrZnRwUkc0V0hQZ3J4SEhmOVllMVV3WmlNenNG?=
 =?gb2312?B?ZmZSVHFMUGxvZ0hqVGdBb1p4N0hMYjFUNGdVblJzVEowZzgxaUR2MWVudG9t?=
 =?gb2312?B?TTRhZlZCOUwzc0VFZjFxY3R1T3RzRThwbnlQUlNiUktibjFFQ1VHamtMK2lv?=
 =?gb2312?B?cnYrRGZwMmw3WmZLTmh1RXhZb09kdEdUcWQ0eVlQS3ErRnBiOHBPNW5WUVdH?=
 =?gb2312?B?cW1NbG1WbU5KYzRpd0o0aFg4RlV4Yk12czArSU9zRldaM1IwVkordVhrcmw4?=
 =?gb2312?B?SEYybEJ4WmxIcGJSQ1gwYmlDNmN6VlZiZng3d1VOWnlWaVQyek4zQ2svMVV5?=
 =?gb2312?B?ZHdJWDc2UU5CNTQwUGQzMmE4YzVnekRDc1lnbnp2OG82OUZFdUd3Q1VHZlE5?=
 =?gb2312?B?empMaXE4aTNDZ0trK0hDTUVJSE1oZWxCYXB0L3h1V0R2UWtKOGhBcyt3MTU2?=
 =?gb2312?B?eXdkbmlpblRCVjVmNVRXUjFiTTZxcHJFV0o2cnlmdWV3bURkdVIydkpOQmor?=
 =?gb2312?B?Uk5aVDlFZllFQnNWb3NBL0FpL3BsSkQ2UnVDWGNURDQreFI0d1Jsajh0Y2xS?=
 =?gb2312?B?TDRRYWE1N3pEN096T2V4L1lrbG1LRWtFSXdqaTJQblFIejFIdzVRZ2EzRjAz?=
 =?gb2312?B?bHo4VGNsbWh5b3RHVnB6VkxKak01NFd0R0dHMldiZGQ1TWNUNzlFSWJpSEU2?=
 =?gb2312?B?SjRPNTR1a0lzUWdjb0ZXQjU3ZmVCT3M4T244NklsdFFxQis3bkhZb3B4M0pY?=
 =?gb2312?B?UFh3TTlOQVZCT2hjNktpSXIzZXg1VlM1dldPSmZwZUpJbnhvUmJvZkNUZVJM?=
 =?gb2312?B?clN3dE5JYTIxdkhKQ0Z0RGVjZEMwYjZPeGlWSU9hR0JDcjhOQ0R6Wnl2SkhX?=
 =?gb2312?B?dEd2eUYraHd3TS9yOHNzZTdjOXV4eFBEUGtIS1FtMTdzYzVvU2FvWGdybFpl?=
 =?gb2312?B?ZVk0RTJRQmNLaGVUdjNBRm5ZSEc2eEYwenlTNmR4OWtYWDFHVkpiSHdxWmcz?=
 =?gb2312?B?a2cwbkl1dCtQcGxzNE4xeGVsOVJBalNHSWZzREVCV3B0U1BoK291QmNlSnFL?=
 =?gb2312?Q?Kn9M=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67914c1d-a921-46e7-b7b2-08dd1e70a11a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 07:58:44.3914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tWB1dFMvPLJ5PdULwhl0d6aHFqV7f4XkXLTv/xIvJACWD3o1RecXHHDoZ08xsz3/ZrP+xq8+E5RsJlHqGf1xRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5517

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpDb25zaWRlcmluZyB0aGF0
IGluIHNvbWUgZXh0cmVtZSBjYXNlcywgd2hlbiBwZXJmb3JtaW5nIHRoZQ0KdW5iaW5kaW5nIG9w
ZXJhdGlvbiwgZ3NlcmlhbF9kaXNjb25uZWN0IGhhcyBjbGVhcmVkIGdzZXItPmlvcG9ydCwNCndo
aWNoIHRyaWdnZXJzIGdhZGdldCByZWNvbmZpZ3VyYXRpb24sIGFuZCB0aGVuIGNhbGxzIGdzX3Jl
YWRfY29tcGxldGUsDQpyZXN1bHRpbmcgaW4gYWNjZXNzIHRvIGEgbnVsbCBwb2ludGVyLiBUaGVy
ZWZvcmUsIGVwIGlzIGRpc2FibGVkIGJlZm9yZQ0KZ3NlcmlhbF9kaXNjb25uZWN0IHNldHMgcG9y
dCB0byBudWxsIHRvIHByZXZlbnQgdGhpcyBmcm9tIGhhcHBlbmluZy4NCg0KQ2FsbCB0cmFjZToN
CiBnc19yZWFkX2NvbXBsZXRlKzB4NTgvMHgyNDANCiB1c2JfZ2FkZ2V0X2dpdmViYWNrX3JlcXVl
c3QrMHg0MC8weDE2MA0KIGR3YzNfcmVtb3ZlX3JlcXVlc3RzKzB4MTcwLzB4NDg0DQogZHdjM19l
cDBfb3V0X3N0YXJ0KzB4YjAvMHgxZDQNCiBfX2R3YzNfZ2FkZ2V0X3N0YXJ0KzB4MjVjLzB4NzIw
DQoga3JldHByb2JlX3RyYW1wb2xpbmUuY2ZpX2p0KzB4MC8weDgNCiBrcmV0cHJvYmVfdHJhbXBv
bGluZS5jZmlfanQrMHgwLzB4OA0KIHVkY19iaW5kX3RvX2RyaXZlcisweDFkOC8weDMwMA0KIHVz
Yl9nYWRnZXRfcHJvYmVfZHJpdmVyKzB4YTgvMHgxZGMNCiBnYWRnZXRfZGV2X2Rlc2NfVURDX3N0
b3JlKzB4MTNjLzB4MTg4DQogY29uZmlnZnNfd3JpdGVfaXRlcisweDE2MC8weDFmNA0KIHZmc193
cml0ZSsweDJkMC8weDQwYw0KIGtzeXNfd3JpdGUrMHg3Yy8weGYwDQogX19hcm02NF9zeXNfd3Jp
dGUrMHgyMC8weDMwDQogaW52b2tlX3N5c2NhbGwrMHg2MC8weDE1MA0KIGVsMF9zdmNfY29tbW9u
KzB4OGMvMHhmOA0KIGRvX2VsMF9zdmMrMHgyOC8weGEwDQogZWwwX3N2YysweDI0LzB4ODQNCg0K
Rml4ZXM6IGMxZGNhNTYyYmU4YSAoInVzYiBnYWRnZXQ6IHNwbGl0IG91dCBzZXJpYWwgY29yZSIp
DQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KU3VnZ2VzdGVkLWJ5OiBHcmVnIEtyb2FoLUhh
cnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KU2lnbmVkLW9mZi1ieTogTGlhbnFp
biBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KLS0tDQoNCkNoYW5nZXMgaW4gdjM6DQogLSBBZGQg
LS0tIGxpbmUgYWJvdmUgdGhlIHZlcnNpb24gdGFnIGluZm9ybWF0aW9uDQogLSBSZW1vdmUgZXh0
cmEgYmxhbmsgbGluZXMgaW4gY29tbWl0IG1lc3NhZ2VzDQogLSBWZXJzaW9uIHRhZyBpbmZvcm1h
dGlvbiBmcm9tIHYyIHRvIGNoYW5nZXMgaW4gdjINCiAtIExpbmsgdG8gdjI6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC9UWVVQUjA2TUI2MjE3REFBMDk1QTk4NjNENEI1OEQ1N0NEMjNCMkBU
WVVQUjA2TUI2MjE3LmFwY3ByZDA2LnByb2Qub3V0bG9vay5jb20vDQoNCkNoYW5nZXMgaW4gdjI6
DQogLSBSZW1vdmUgc29tZSBhZGRyZXNzIGluZm9ybWF0aW9uIGZyb20gcGF0Y2ggZGVzY3JpcHRp
b25zDQogLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvVFlVUFIwNk1C
NjIxNzYzQUI4MTU5ODkxNjFGNDAzM0FGRDI3NjJAVFlVUFIwNk1CNjIxNy5hcGNwcmQwNi5wcm9k
Lm91dGxvb2suY29tLw0KIC0gTGluayB0byBzdWdnZXN0aW9uczogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsL1RZVVBSMDZNQjYyMTdERTI4MDEyRkZFQzVFODA4REQ2NEQyOTYyQFRZVVBSMDZN
QjYyMTcuYXBjcHJkMDYucHJvZC5vdXRsb29rLmNvbS8NCg0KIGRyaXZlcnMvdXNiL2dhZGdldC9m
dW5jdGlvbi91X3NlcmlhbC5jIHwgOCArKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRn
ZXQvZnVuY3Rpb24vdV9zZXJpYWwuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3Nl
cmlhbC5jDQppbmRleCA1M2Q5ZmM0MWFjYzUuLmJjMTQzYTg2YzJkZCAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQorKysgYi9kcml2ZXJzL3VzYi9n
YWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KQEAgLTE0MjAsNiArMTQyMCwxMCBAQCB2b2lkIGdz
ZXJpYWxfZGlzY29ubmVjdChzdHJ1Y3QgZ3NlcmlhbCAqZ3NlcikNCiAJLyogUkVWSVNJVCBhcyBh
Ym92ZTogaG93IGJlc3QgdG8gdHJhY2sgdGhpcz8gKi8NCiAJcG9ydC0+cG9ydF9saW5lX2NvZGlu
ZyA9IGdzZXItPnBvcnRfbGluZV9jb2Rpbmc7DQogDQorCS8qIGRpc2FibGUgZW5kcG9pbnRzLCBh
Ym9ydGluZyBkb3duIGFueSBhY3RpdmUgSS9PICovDQorCXVzYl9lcF9kaXNhYmxlKGdzZXItPm91
dCk7DQorCXVzYl9lcF9kaXNhYmxlKGdzZXItPmluKTsNCisNCiAJcG9ydC0+cG9ydF91c2IgPSBO
VUxMOw0KIAlnc2VyLT5pb3BvcnQgPSBOVUxMOw0KIAlpZiAocG9ydC0+cG9ydC5jb3VudCA+IDAp
IHsNCkBAIC0xNDMxLDEwICsxNDM1LDYgQEAgdm9pZCBnc2VyaWFsX2Rpc2Nvbm5lY3Qoc3RydWN0
IGdzZXJpYWwgKmdzZXIpDQogCXNwaW5fdW5sb2NrKCZwb3J0LT5wb3J0X2xvY2spOw0KIAlzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZzZXJpYWxfcG9ydF9sb2NrLCBmbGFncyk7DQogDQotCS8qIGRp
c2FibGUgZW5kcG9pbnRzLCBhYm9ydGluZyBkb3duIGFueSBhY3RpdmUgSS9PICovDQotCXVzYl9l
cF9kaXNhYmxlKGdzZXItPm91dCk7DQotCXVzYl9lcF9kaXNhYmxlKGdzZXItPmluKTsNCi0NCiAJ
LyogZmluYWxseSwgZnJlZSBhbnkgdW51c2VkL3VudXNhYmxlIEkvTyBidWZmZXJzICovDQogCXNw
aW5fbG9ja19pcnFzYXZlKCZwb3J0LT5wb3J0X2xvY2ssIGZsYWdzKTsNCiAJaWYgKHBvcnQtPnBv
cnQuY291bnQgPT0gMCkNCi0tIA0KMi4zOS4wDQoNCg==

