Return-Path: <linux-kernel+bounces-412366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88FE9D081F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 04:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897142814E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 03:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A9C4DA03;
	Mon, 18 Nov 2024 03:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qGqB1ALo"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013057.outbound.protection.outlook.com [40.107.44.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055D62110E;
	Mon, 18 Nov 2024 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731899583; cv=fail; b=qyiR6e/ms7xFvKnxYmzeVcjI4UafD66SsotD1N3NjVKir1udn9apd8IZf39jzujMPUfxQttII7/arcOqz6gwdpASySXhJR6+eS+PLY8EVoiaqNEA67i/ZSweAVZkVwsHwMI2Kmqs487VqN//tMiKl1+UEdrQ0kLnFq+gkYglx8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731899583; c=relaxed/simple;
	bh=XxKyxSvONLbTqk6AgaKx+MOzbGV5bIA42g7k7d8BrCs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tTu7DI7q8Ma8HxOeU2C0geTd9Yz2j/8Y13Hi2o2d4vzxdKzaNGhg2KmdBzqy/n0Ts/85G0d+H2UIzJM/Hp+jXNBrQ5LSOIU/gZZONDXIzFdR+OI8t/7s/WjJ1kbx7YFcfL/KR9H8vnu7694RFJfxZZGWFx0GwfLznNWhiXlT9oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qGqB1ALo; arc=fail smtp.client-ip=40.107.44.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/Kn5e8Z4OAut6+wo/qmwvCt5AITqlXUmmDrXVa4XSxnTV5yNYDh5Rz5mz/Uk7h1kjWLJseLdo4XGSuuztT+987hBvdx6wPA49LMydrml6tHUYDqQ7y721ym2FktkO0k4SbC46Q0THBAII2CPlJtJa8tKqJu8xEcF01aWO9K70NyV+p3J/e8482J7qqGqlHGw3gb9hN/XPOR7J7uaJaw1O6pwzJ5dVApMKuurG5w6OIJI/IsxfIDuoclvF0veWP8qwaP+GsI44LmSueEI1PqdYnXziH5zqHrfl16xWYWmxOXH+Pqj6I8awtKbvJDsWgRpy85wwFHGzG8eQJukKFSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxKyxSvONLbTqk6AgaKx+MOzbGV5bIA42g7k7d8BrCs=;
 b=jfTrMNz69CsfiR6ClwmKRq4QP2cxq8uVFv2IuF6YU/Qmn/usZ1S2om3kk021UfKsaut2TcndhyGdxPwDfZkjxoc2vC1c/+GJrS9FvDOkBgbkK3vDthqa7Ye/fW80pOPkKdAbVFRepG/fT4dNA6DJq9BIsmsnJkisekcnHpfntbB/7gfKIr2DE/TQeJ0A+p0OsKoIhgCh1UKFGBUzJaU9crPRhQmCHF2tHvttAESBhMjoiP91wUSQrbVHJawN1za1OV02gQI65K9cmrd7flW/RzzpTVxXVbplyh7JwX1va5sBSuNgKzFoh75yzKxn5X01ZwtZnlk7RxE8jTTa8cWMpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxKyxSvONLbTqk6AgaKx+MOzbGV5bIA42g7k7d8BrCs=;
 b=qGqB1ALoz4J6naARwLQyKYaKCeyqyDRLf+ZMRRjWjG8azYqlB+SOPKkwlcmgYoz6tlCnmn0TrTpCEq93mZJ0vxxoiEFnt5FC+jIelsUHcug3GnhCm5v0Gibo6H0R3wVaGH+gtpjsI3N5lUTCSGhaociEn5j0iEdywTNnjMsAeu4/VKYLI5VODxDCnS42M29YGRoGG/ApaoaZmoYTjv8cD8fsy7spV/3o8W4FwRuZ1zc2jwTkaWrX2jYrhQIyvcBWMAsazADx6VQh7dQIpjDZo0H5o58p+tmVMxmrB4vvLeBbMXPv4bCLgbkZushANbRtsSPmaq/2tXd2tbHokX+fJw==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by KL1PR06MB6845.apcprd06.prod.outlook.com (2603:1096:820:10d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.11; Mon, 18 Nov
 2024 03:12:54 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%6]) with mapi id 15.20.8182.011; Mon, 18 Nov 2024
 03:12:54 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>, "mwalle@kernel.org"
	<mwalle@kernel.org>, Prashanth K <quic_prashk@quicinc.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, =?gb2312?B?uvrBrMfa?=
	<hulianqin@vivo.com>
Subject: [PATCH] usb: gadget: u_serial: Fix the issue that gs_start_io crashed
 due to accessing null pointer
Thread-Topic: [PATCH] usb: gadget: u_serial: Fix the issue that gs_start_io
 crashed due to accessing null pointer
Thread-Index: Ads5Z1bjTgbcKYBiSvSmNoAzjrMY+A==
Date: Mon, 18 Nov 2024 03:12:54 +0000
Message-ID:
 <TYUPR06MB621737D16F68B5ABD6CF5772D2272@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|KL1PR06MB6845:EE_
x-ms-office365-filtering-correlation-id: c2626aa1-177a-48ea-fa0c-08dd077ee4e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?OE9yUnV1RTlCRVdQaUs5R2crM3BIVmoxbXlYaFF5Zk5pY3Y3bTZwQXhkNTZ1?=
 =?gb2312?B?K0ZyM0RLc3ZrQXM3amNteFFnczhoWFVFY0h0MXV5OXFsQzgvZGtjajNJYUt1?=
 =?gb2312?B?aGtxUVhjeExxSkNJaWRoNExjVkN6WGZCbXJzdkNoRW94QUtzOXo0UzNaaERt?=
 =?gb2312?B?Q3hkNEFwUHRBM2Z1SEVzd242d201VjExelZIL0lBTkZBNkZwV2hzem1kalQv?=
 =?gb2312?B?MnFLWVR6WkNCblhIRGpnd242U2NzYlBsQUgyUXloUVFJdEhrQkgvditDTCsy?=
 =?gb2312?B?TXRyc0lFT3lsdzFROVNXdjNRb1FqQS9VRFo0MHN3Y3RIMTlYU0llTHcvblJ3?=
 =?gb2312?B?cDU2dkpkUHFSWGpmN21RUTl2M0FoRHNIVGhUb2hHZjU2VEZremhIcFFBLzVR?=
 =?gb2312?B?OFZmOTBTelF6WHlWRmxLTmJoWjhPbGp4U0VOVWRVdHZpVFlBSXBmeEN1L1ps?=
 =?gb2312?B?WDh0UlFKdVA0M1hqV01jdnVBM2ZmRFlxZ3VhbmZWbzdyNTB1S0xISldnZDB3?=
 =?gb2312?B?RGFxc1B3NEs5b2JIUkdiRVRiV3plejhzanBNUXRtK2l5bWVZeGJkaVNLVE1u?=
 =?gb2312?B?Y2E5Z0JWYk45QnhSbHMxVFc3U0I1c3Rzc3RoencvNXpCTXR5dlFQSCszK0dF?=
 =?gb2312?B?cXdXaFFuNHYwa0pqWFhsSlplWnpNY0UxVnZiZ1JydUtma2IreThJYVZRdHhF?=
 =?gb2312?B?QmV4VjAzSE56VHRUM3ZRbmg2NG9WWnZmcnBwQTZnVS96SGJFbmcvU3loNmpI?=
 =?gb2312?B?d01jTUd5VURIQm1oalBhc1c2d2xyZmd0ZHM0RERxbWpIWGNHY2pPUEhPNWxT?=
 =?gb2312?B?TGRwdFZselRLUm5HbUVQRGJ5TnE1bTZndjBRQ01kQ3RVZ1BodVZ0SjI1MTYx?=
 =?gb2312?B?Ym1sTTFJTlJjNHdJcE91Y0IraU12aDFMVWxnZDRRVDgzOWhOQ1JOZlkwMmpC?=
 =?gb2312?B?Nlc0OWN2em1JMS9md2F0Z0l6Zk9UTm0wUDFPNTlZb0ZralF0clE5Nk93QTZX?=
 =?gb2312?B?clV1TnVOdTN3dVdrcEl3Y01iZ0Z3ZjBMNUZkSGtSUnQ5ZXZtYms4RnN5OVVI?=
 =?gb2312?B?T2xhV2dHQy9PS1FOUHdrRzZuK1JCd285WDQ0RnZWUnUybllpYUtTMW1DK2Nq?=
 =?gb2312?B?S1kzRmlmR0VGaGJVd1RFTFdybVRJUytZLzhQMnNpVmVjSUZCQk9zQkVDVHpF?=
 =?gb2312?B?YlY4eTRwYUJsbG1vWnFvTUZMRXpzTVUwSC9VSEIwbUdXRGFmVzZRdXN3UWJX?=
 =?gb2312?B?bDJ1YXFsbWUrN2wydG04N3BJUjBSU2o5YXRSdHk3WWx0VlJTeXRLckthcXpU?=
 =?gb2312?B?c1hxcTNTMU1JR3VHR2swRDJtSjd3MjgzQmZGcVZxMVluYmhlR0RCZDAzaUVC?=
 =?gb2312?B?MXZyQ3pyV2dleWJrTUgzcW4yUHpCTEo1UUFMSU90YW1TbFNxdk9aMFFmSUNT?=
 =?gb2312?B?d20wcVFSZ3hVbStpaS9zV2tiRjR5NGIyaHZHZUcrVGFTMmpDaU1pVzZYLzFU?=
 =?gb2312?B?RXIwNlZuTnphMFhaTk9NSThZeHE5OU9xMG9RQXl6ZHJRcVEzZDRYcStFNEVu?=
 =?gb2312?B?alJqR2FXRmZDQzNoRDBGaFlZUDFmQTd6cFRqTnpQdkcvTjJ2ZDRiUGFleFlM?=
 =?gb2312?B?MkEvZjBEV3hYMFJOU0N0ekFMTkhHVlM2R29ZVitkcHVvbTdUZmZ2U1FIQ3pv?=
 =?gb2312?B?bkU2eXArbVJtcWFWT1pIdlF2K3NyWVFtUkFFMGwrd2s3TGxDZFlyNlhzd0Rz?=
 =?gb2312?B?elllSk5jMTRDM1dEZ1VKSEtSZlg1bW9rV3lOTy9vZ1N3T1VMbVlJOE12NHpC?=
 =?gb2312?Q?3vV6vCiG0MueheGjUnQ8YftVNnWnmmkrF9UHQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dDFkMFYvVzlMc2FiQlM1ZWwyMDlJNUpPK0dhTWFmbnpFWVF6azZRdlA5bi9j?=
 =?gb2312?B?bmZ6RFFkcTJSYmRPS004MUV0US9PWGU1bXN6Y0w4aFYvMGZCdzU0SDZOR0ZR?=
 =?gb2312?B?ZEVGekh2VkV6TjREaUNhVWpQTmhzQ1VTZlZURHozbG4wSkV1UHRoRjNrQ1A0?=
 =?gb2312?B?bGMzTmhBc01VTkc2UUxpa0NTY0s0bmRNT1VLNlQ0cGJEVlpRRjN5TjFBcy9o?=
 =?gb2312?B?TDZFcEFSNitMcko3dFhjL2dhSVp1WDl3UnVUSyt4a1NQK3pKVEUzTEk4MWkx?=
 =?gb2312?B?ZlhOUkpsa2h2ZDZLT2dzQ1ExTVF1ZkhvQjloK2cvN2ZmY3JYRldRUlcwRlRl?=
 =?gb2312?B?UXdheWJlTyt6dmpRMGRSSlo4djhTbXZCOGk2NnFUVFp0MkZLZ2ZWQjhERE8z?=
 =?gb2312?B?eDJ6ZVFZc3NyZGxWSTVzdlcxaGIyeW5UK0ZXbm1UNWVjRHYxOHFnWUF3SHNE?=
 =?gb2312?B?MTM0a21Gc05aTEI3b2t3azBCTExJL0hKTEdEWVBvTE5TeUxiOTZRdUlTRU9C?=
 =?gb2312?B?MHdjS2dabmpoejl3L2FGRURjck1kbXliRGcyWGJiV0ZaK09nTk4rSzdvYUxV?=
 =?gb2312?B?UXpJc0Y4bjh2Q0I1N0twUWRadStqckttWURsUERkUG9helR1NGhZallzY2R0?=
 =?gb2312?B?WEVJeGg2S1lKKzVvbmVPZm1qSXVWbnA0dGRicE9WVTREa2dNTzFFT2dCdDdM?=
 =?gb2312?B?M0dhdG5BK2lnZ0M1YnBEcEtBcXArcXpQS0FWMU8rYTBIZFRiQUFkNk1VTmd1?=
 =?gb2312?B?SExZais5ak16OGg0T1RiS29kd2hlQTBPM01kdC9sc2E4elRBeXlWWWFSV3Bw?=
 =?gb2312?B?b2NiTERHUHJNaFh0RHU0a1YvUHMvNFkxMkJpRy9XbGlMbm9hQXpVb0VCczdy?=
 =?gb2312?B?WXB3SG9BMEpMU1krbEJML1R4RWxtSEl1S21ZVHRwcm1JTkx4bVVxYVBhRW5q?=
 =?gb2312?B?S1pZb2c4Q3gxcFV1dlBWUThhUVM2S3BhemtPZDJCTGRZYTRRZndwTVg0eGVD?=
 =?gb2312?B?VUtTZERQMm5KRWNjRjRUT2JYMHdrR1A1aHZWYVhzdUU4UGYwSkgvQkNPSHZ3?=
 =?gb2312?B?cU50anRNUWpheXBZV1ltM3hUVEdkMGIrc3NuZTFiZDVVenBac0lWSCszNXV6?=
 =?gb2312?B?RmRNME1EbFBDakc0Q2Ewczl4R1Z3ZlBBZTBNK1FpNXBxMmxJRUQvbXJpbU5C?=
 =?gb2312?B?RU45QjJlODFsL0hhN2ZVK29raHcxTFJabjZDZ2lTTlRTYitQV1luaGh3amVs?=
 =?gb2312?B?M3dQRy8vMmFoN1Q4cFZBTzE5SzJnT0w2RVBkTFIybGZSMnBHSFhZMThuYWtQ?=
 =?gb2312?B?UzdvY1BxOFlqcU5MYXlzSVV5M0xLVFY1YlVNcnRxeTJVSFFWQXdmeGs3Y054?=
 =?gb2312?B?NGZBRjNabGM2ZUJobmthYmxaZS9jemNBcXB0dzNyV0JRQ2tCMTRyQ0FZbkZo?=
 =?gb2312?B?My9zUUUzS2w1RUI5SWg2QTh2R0ZlY3ozbWlqRFRwY1dOaHp3OTUrYTJES3RI?=
 =?gb2312?B?OGt3NEpXYWkyRmh5bjFnTGl1VmlCV0ZtNWtWNmMzNTZFZGF0Z0I3czZJdUJT?=
 =?gb2312?B?d08xK1hUMS9FckowOHpPYkdtZGFyVDNzYkVsRjl5elNIMmozUlJrdkJjWWZG?=
 =?gb2312?B?d2VxbWR6WC9hTEY3c0wrTVFaYXFEdit6eTJZT0tHeTF2V1hLUDNMdVJBR0hY?=
 =?gb2312?B?UTBmL25Zak5kaVlLQkNzK3BGem5CbEx3TTB0R0RMS2NEK0ZPckt6di9zdUgw?=
 =?gb2312?B?TUR4MGhNWHN3SkNIT1dKbmF0VnhjNXVITkg2ZUIzU0JPVEw2TGpiVGdrN0M5?=
 =?gb2312?B?bEllMFZoQ1BrckpRRXdXSWljWVdoTkpTV3BYNVFQeUZnZ2NBbVQ3RVdTWHJC?=
 =?gb2312?B?b3ZDNURQdFE0dkIwb0NXdFEvSXU1VVFESEMvMXFQbGpsUGVNeFFyRzh4c0F3?=
 =?gb2312?B?SFJESnFkU2RvYVFQN0JpZXFJRGIzanpzSEs3aXlJSWNZRFV3UjFqQ0RBOEt2?=
 =?gb2312?B?UzNrV2E3c29aZVhFVndkYUlhRG9kbXNZdUN5U3JaZ2RGeEFHeU5rYXlDdDUv?=
 =?gb2312?B?a1V6V3JGT21iN2xvQS9BL0dtR2JoSGIvQjArRGo0VnpPU2JPaW03a0orbHJm?=
 =?gb2312?Q?EvaU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c2626aa1-177a-48ea-fa0c-08dd077ee4e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 03:12:54.3869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +YtjMYaEoTP0wAsBliUGRTfSQ68eQAfpDjJcwm930sJQIreJNH/6MTnirWbE3tJZidrHpH3mM07PAISLibMHVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6845

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpDb25zaWRlcmluZyB0aGF0
IGluIHNvbWUgZXh0cmVtZSBjYXNlcywNCndoZW4gdV9zZXJpYWwgZHJpdmVyIGlzIGFjY2Vzc2Vk
IGJ5IG11bHRpcGxlIHRocmVhZHMsDQpUaHJlYWQgQSBpcyBleGVjdXRpbmcgdGhlIG9wZW4gb3Bl
cmF0aW9uIGFuZCBjYWxsaW5nIHRoZSBnc19vcGVuLA0KVGhyZWFkIEIgaXMgZXhlY3V0aW5nIHRo
ZSBkaXNjb25uZWN0IG9wZXJhdGlvbiBhbmQgY2FsbGluZyB0aGUNCmdzZXJpYWxfZGlzY29ubmVj
dCBmdW5jdGlvbixUaGUgcG9ydC0+cG9ydF91c2IgcG9pbnRlciB3aWxsIGJlIHNldCB0byBOVUxM
Lg0KDQpFLmcuDQogICAgVGhyZWFkIEEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBU
aHJlYWQgQg0KDQogICAgZ3Nfb3BlbigpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBn
YWRnZXRfdW5iaW5kX2RyaXZlcigpDQoNCiAgICBnc19zdGFydF9pbygpICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbXBvc2l0ZV9kaXNjb25uZWN0KCkNCg0KICAgIGdzX3N0YXJ0X3J4KCkg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZ3NlcmlhbF9kaXNjb25uZWN0KCkNCiAgICAuLi4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4uLg0KICAgIHNwaW5fdW5sb2Nr
KCZwb3J0LT5wb3J0X2xvY2spDQogICAgc3RhdHVzID0gdXNiX2VwX3F1ZXVlKCkgICAgICAgICAg
ICAgICAgICBzcGluX2xvY2soJnBvcnQtPnBvcnRfbG9jaykNCiAgICBzcGluX2xvY2soJnBvcnQt
PnBvcnRfbG9jaykgICAgICAgICAgICAgIHBvcnQtPnBvcnRfdXNiID0gTlVMTA0KICAgIGdzX2Zy
ZWVfcmVxdWVzdHMocG9ydC0+cG9ydF91c2ItPmluKSAgICAgc3Bpbl91bmxvY2soJnBvcnQtPnBv
cnRfbG9jaykNCiAgICBDcmFzaA0KDQpUaGlzIGNhdXNlcyB0aHJlYWQgQSB0byBhY2Nlc3MgYSBu
dWxsIHBvaW50ZXIgKHBvcnQtPnBvcnRfdXNiIGlzIG51bGwpDQp3aGVuIGNhbGxpbmcgdGhlIGdz
X2ZyZWVfcmVxdWVzdHMgZnVuY3Rpb24sIGNhdXNpbmcgYSBjcmFzaC4NCg0KVG8gc29sdmUgdGhp
cyBwcm9ibGVtLCBhZGQgdGhlIHJlYWRfYnVzeSBmbGFnLCBiZWZvcmUgc2V0dGluZyBwb3J0X3Vz
Yg0KdG8gbnVsbCBpbiBnc2VyaWFsX2Rpc2Nvbm5lY3QsIGFkZCB0aGUgcmVhZF9idXN5IGZsYWcg
anVkZ21lbnQuDQoNClVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVy
ZW5jZSBhdA0KdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAwMDAwMDAwZTgNCnBjIDogZ3Nfc3RhcnRf
aW8rMHgxNjQvMHgyNWMNCmxyIDogZ3Nfc3RhcnRfaW8rMHgyMzgvMHgyNWMNCnNwIDogZmZmZmZm
YzA4Yjc1YmEwMA0KeDI5OiBmZmZmZmZjMDhiNzViYTAwIHgyODogZmZmZmZmZWQ4YmEwMTAwMCB4
Mjc6IDAwMDAwMDAwMDAwMjA5MDINCngyNjogZGVhZDAwMDAwMDAwMDEwMCB4MjU6IGZmZmZmZjg5
OWY0M2E0MDAgeDI0OiBmZmZmZmY4ODYyMzI1NDAwDQp4MjM6IGZmZmZmZjg4NjIzMjU2YTQgeDIy
OiBmZmZmZmY4ODYyMzI1NjkwIHgyMTogZmZmZmZmODg2MjMyNTVlYw0KeDIwOiBmZmZmZmY4ODYy
MzI1NWQ4IHgxOTogZmZmZmZmODg1ZTE5ZDcwMCB4MTg6IGZmZmZmZmVkOGM0NWFlNDANCngxNzog
MDAwMDAwMDBkNDhkMzBhZCB4MTY6IDAwMDAwMDAwZDQ4ZDMwYWQgeDE1OiAwMDEwMDAwMDAwMDAw
MDAxDQp4MTQ6IGZmZmZmZmVkOGM1MGZjYzAgeDEzOiAwMDAwMDAwMDQwMDAwMDAwIHgxMjogMDAw
MDAwMDAwMDAwMDAwMQ0KeDExOiAwMDAwMDAwMDgwMjAwMDEyIHgxMDogMDAwMDAwMDA4MDIwMDAx
MiB4OSA6IGZmZmZmZjg4NjIzMjU1ZDgNCng4IDogMDAwMDAwMDAwMDAwMDAwMCB4NyA6IDAwMDAw
MDAwMDAwMDAwMDAgeDYgOiAwMDAwMDAwMDAwMDAwMDNmDQp4NSA6IGZmZmZmZmVkOGFlMGI5YTQg
eDQgOiBmZmZmZmZmZTI2N2QwZWEwIHgzIDogMDAwMDAwMDA4MDIwMDAxMg0KeDIgOiBmZmZmZmY4
OTlmNDNhNDAwIHgxIDogMDAwMDAwMDA4MDIwMDAxMyB4MCA6IGZmZmZmZjg5OWY0M2IxMDANCkNh
bGwgdHJhY2U6DQogZ3Nfc3RhcnRfaW8rMHgxNjQvMHgyNWMNCiBnc19vcGVuKzB4MTA4LzB4MTNj
DQogdHR5X29wZW4rMHgzMTQvMHg2MzgNCiBjaHJkZXZfb3BlbisweDFiOC8weDI1OA0KIGRvX2Rl
bnRyeV9vcGVuKzB4MmM0LzB4NzAwDQogdmZzX29wZW4rMHgyYy8weDNjDQogcGF0aF9vcGVuYXQr
MHhhNjQvMHhjNjANCiBkb19maWxwX29wZW4rMHhiOC8weDE2NA0KIGRvX3N5c19vcGVuYXQyKzB4
ODQvMHhmMA0KIF9fYXJtNjRfc3lzX29wZW5hdCsweDcwLzB4OWMNCiBpbnZva2Vfc3lzY2FsbCsw
eDU4LzB4MTE0DQogZWwwX3N2Y19jb21tb24rMHg4MC8weGUwDQogZG9fZWwwX3N2YysweDFjLzB4
MjgNCiBlbDBfc3ZjKzB4MzgvMHg2OA0KIGVsMHRfNjRfc3luY19oYW5kbGVyKzB4NjgvMHhiYw0K
IGVsMHRfNjRfc3luYysweDFhOC8weDFhYw0KQ29kZTogZjJmYmQ1YmEgZWIxNDAxM2YgNTQwMDA0
YTEgZjk0MGU3MDggKGY5NDA3NTEzKQ0KLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBd
LS0tDQoNClNpZ25lZC1vZmYtYnk6IExpYW5xaW4gSHUgPGh1bGlhbnFpbkB2aXZvLmNvbT4NCi0t
LQ0KIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jIHwgMjUgKysrKysrKysr
KysrKysrLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxMCBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91
X3NlcmlhbC5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCmluZGV4
IDBhOGMwNWIyNzQ2Yi4uOWFiMmRiZWQ2MGE4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2Fk
Z2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlv
bi91X3NlcmlhbC5jDQpAQCAtMTI0LDYgKzEyNCw3IEBAIHN0cnVjdCBnc19wb3J0IHsNCiAJc3Ry
dWN0IGtmaWZvCQlwb3J0X3dyaXRlX2J1ZjsNCiAJd2FpdF9xdWV1ZV9oZWFkX3QJZHJhaW5fd2Fp
dDsJLyogd2FpdCB3aGlsZSB3cml0ZXMgZHJhaW4gKi8NCiAJYm9vbCAgICAgICAgICAgICAgICAg
ICAgd3JpdGVfYnVzeTsNCisJYm9vbCAgICAgICAgICAgICAgICAgICAgcmVhZF9idXN5Ow0KIAl3
YWl0X3F1ZXVlX2hlYWRfdAljbG9zZV93YWl0Ow0KIAlib29sCQkJc3VzcGVuZGVkOwkvKiBwb3J0
IHN1c3BlbmRlZCAqLw0KIAlib29sCQkJc3RhcnRfZGVsYXllZDsJLyogZGVsYXkgc3RhcnQgd2hl
biBzdXNwZW5kZWQgKi8NCkBAIC0zMzEsOSArMzMyLDExIEBAIF9fYWNxdWlyZXMoJnBvcnQtPnBv
cnRfbG9jaykNCiAJCS8qIGRyb3AgbG9jayB3aGlsZSB3ZSBjYWxsIG91dDsgdGhlIGNvbnRyb2xs
ZXIgZHJpdmVyDQogCQkgKiBtYXkgbmVlZCB0byBjYWxsIHVzIGJhY2sgKGUuZy4gZm9yIGRpc2Nv
bm5lY3QpDQogCQkgKi8NCisJCXBvcnQtPnJlYWRfYnVzeSA9IHRydWU7DQogCQlzcGluX3VubG9j
aygmcG9ydC0+cG9ydF9sb2NrKTsNCiAJCXN0YXR1cyA9IHVzYl9lcF9xdWV1ZShvdXQsIHJlcSwg
R0ZQX0FUT01JQyk7DQogCQlzcGluX2xvY2soJnBvcnQtPnBvcnRfbG9jayk7DQorCQlwb3J0LT5y
ZWFkX2J1c3kgPSBmYWxzZTsNCiANCiAJCWlmIChzdGF0dXMpIHsNCiAJCQlwcl9kZWJ1ZygiJXM6
ICVzICVzIGVyciAlZFxuIiwNCkBAIC0xNDEyLDE5ICsxNDE1LDIxIEBAIHZvaWQgZ3NlcmlhbF9k
aXNjb25uZWN0KHN0cnVjdCBnc2VyaWFsICpnc2VyKQ0KIAkvKiB0ZWxsIHRoZSBUVFkgZ2x1ZSBu
b3QgdG8gZG8gSS9PIGhlcmUgYW55IG1vcmUgKi8NCiAJc3Bpbl9sb2NrKCZwb3J0LT5wb3J0X2xv
Y2spOw0KIA0KLQlnc19jb25zb2xlX2Rpc2Nvbm5lY3QocG9ydCk7DQorCWlmICghcG9ydC0+cmVh
ZF9idXN5KSB7DQorCQlnc19jb25zb2xlX2Rpc2Nvbm5lY3QocG9ydCk7DQogDQotCS8qIFJFVklT
SVQgYXMgYWJvdmU6IGhvdyBiZXN0IHRvIHRyYWNrIHRoaXM/ICovDQotCXBvcnQtPnBvcnRfbGlu
ZV9jb2RpbmcgPSBnc2VyLT5wb3J0X2xpbmVfY29kaW5nOw0KKwkJLyogUkVWSVNJVCBhcyBhYm92
ZTogaG93IGJlc3QgdG8gdHJhY2sgdGhpcz8gKi8NCisJCXBvcnQtPnBvcnRfbGluZV9jb2Rpbmcg
PSBnc2VyLT5wb3J0X2xpbmVfY29kaW5nOw0KIA0KLQlwb3J0LT5wb3J0X3VzYiA9IE5VTEw7DQot
CWdzZXItPmlvcG9ydCA9IE5VTEw7DQotCWlmIChwb3J0LT5wb3J0LmNvdW50ID4gMCkgew0KLQkJ
d2FrZV91cF9pbnRlcnJ1cHRpYmxlKCZwb3J0LT5kcmFpbl93YWl0KTsNCi0JCWlmIChwb3J0LT5w
b3J0LnR0eSkNCi0JCQl0dHlfaGFuZ3VwKHBvcnQtPnBvcnQudHR5KTsNCisJCXBvcnQtPnBvcnRf
dXNiID0gTlVMTDsNCisJCWdzZXItPmlvcG9ydCA9IE5VTEw7DQorCQlpZiAocG9ydC0+cG9ydC5j
b3VudCA+IDApIHsNCisJCQl3YWtlX3VwX2ludGVycnVwdGlibGUoJnBvcnQtPmRyYWluX3dhaXQp
Ow0KKwkJCWlmIChwb3J0LT5wb3J0LnR0eSkNCisJCQkJdHR5X2hhbmd1cChwb3J0LT5wb3J0LnR0
eSk7DQorCQl9DQorCQlwb3J0LT5zdXNwZW5kZWQgPSBmYWxzZTsNCiAJfQ0KLQlwb3J0LT5zdXNw
ZW5kZWQgPSBmYWxzZTsNCiAJc3Bpbl91bmxvY2soJnBvcnQtPnBvcnRfbG9jayk7DQogCXNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJnNlcmlhbF9wb3J0X2xvY2ssIGZsYWdzKTsNCiANCi0tIA0KMi4z
OS4wDQoNCg==

