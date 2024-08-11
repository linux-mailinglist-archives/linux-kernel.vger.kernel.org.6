Return-Path: <linux-kernel+bounces-282181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AA894E084
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 10:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12721F215E9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 08:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C95F22615;
	Sun, 11 Aug 2024 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="k4JkKJnc"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2079.outbound.protection.outlook.com [40.107.215.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FCF4C79;
	Sun, 11 Aug 2024 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723365021; cv=fail; b=q1OS80YXSo2/1kvVw51q6A0um/8YpSizPO+abgIkj9zNN0TEdRojKMcyu23hkJ4KaZ//LS9eINuqgoWzwnEN1TQYXZW9eip/addZIMHfXrPBmw35uCZ0y3GSyR4I15NxBeMdkOM1pRKKqx7+OgWm2FMOwPL77kPeWytukaCag3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723365021; c=relaxed/simple;
	bh=x1sk4/F2OHx3krvmtPDaQ8VvsipFXAIK5Z9JOx8EN90=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qe+Lx/wdBatvnufsi4w5YKKjLRROnsejuBM3kX6Ha8KXmUGOhFYLYsTp+st+4/MqPYOLUocyuqcZX4hYT29jgduhB3dvS5qBs60CVsHhAITKQBz/+uRIEWkQU2ebpLgKZkGqiPoQOfGOSmBr0esNcE//PW0xQBCwU5WKDjWidK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=k4JkKJnc; arc=fail smtp.client-ip=40.107.215.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVO62mJSM7MipLtPYjnY41tPksqDLDAju0+xRtTcJxpddxY/U3NtocAZgshT03gjTO0a2AnkjaaGeckZ3dJUp7wjF+s6d6MnI6nDgGT9DvonWlxnn03ho15oYA4u+XEFGAzp0nVYkzfGM0g/EGKoKKH+4F/dEDiHu/SS2cM6hbRda09z+je9VQ4EBKluE1oPN3DNwEY9JjzpXatDbAtYepw5/Bjb7Qv3BdWnpUmtAwz2DcPnGKcob6sXA8udfX2//Sqh6OIR9Vbp7pPVIG/H2LYwo8N8sDoKZ4RXXpvLRZ53KwYJTukjV0h4yjiiMdI2JSade11NpDn0z0RcUbETpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1sk4/F2OHx3krvmtPDaQ8VvsipFXAIK5Z9JOx8EN90=;
 b=uZi//8iPA5eYppgeUHNlaKPYM2dE+C/CORv9pprB7grRE+1Od4Pv1fcSuD9NR1CAzj8J2z1mOLKSbdRes9MqJs+UEs8+8KY+W3lX3ZLnd3dS6KAILMdAZSGwmxql+bi0y4N2ZsYSoGd53r+XDhS+RsoB9Ua9XhXeSbxcVXFrZBz4M1O+IBL/bo1DPwIpa2iCFZRZZeN6o0XErA1PirQJciZ2bX3ruxfc0sxgp9aHmsZScLFe3yCVKra9z2keQSCfUopz9a/6p3Drtf1VboJqMJAZF3lBmcD+K3CctEK0Coxan04rNRRtHXlZdXIfYtTgZgOc/NVF7q5S1uz+etTp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1sk4/F2OHx3krvmtPDaQ8VvsipFXAIK5Z9JOx8EN90=;
 b=k4JkKJncIZ4Ety3mUHqr+aqZOOArAEyB5ahnKPxkqXxt07R1RGH3dGSsTZGxIihkiK7/JBM6ZgeMxiiNVOeAj/xnAd7wY1kfa4Fbwdchll/LuxQsuqoM7zGxv4Jzi0ADrGeogveo72/2wEf6Xqa60e4znWNzbF+DPzY/SQrdw2pkAH2ihPD7I4sRscnP1GZbFZ9i4QIewguQDKoCDCrRq3TyTVpcU59yL9rbAV+3TmgJmr2AcBXctq45uhImZ1QpOQt5VTBqVEkm7PO9nztDoVrYqnsHncuwEBDBFCx4X4ANjMdOpZnB95+j4M5O25YC7/bhESB/1hzwUZD59ap1XQ==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SG2PR06MB5033.apcprd06.prod.outlook.com (2603:1096:4:1c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Sun, 11 Aug
 2024 08:30:11 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7849.015; Sun, 11 Aug 2024
 08:30:11 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
	"mbarriolinares@gmail.com" <mbarriolinares@gmail.com>,
	"wangdicheng@kylinos.cn" <wangdicheng@kylinos.cn>, "sean@mess.org"
	<sean@mess.org>, "alexander@tsoy.me" <alexander@tsoy.me>,
	"xristos.thes@gmail.com" <xristos.thes@gmail.com>, "knuesel@gmail.com"
	<knuesel@gmail.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: opensource.kernel <opensource.kernel@vivo.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: [PATCH v1] ALSA: usb-audio: Add delay quirk for VIVO USB-C-XE710
 HEADSET
Thread-Topic: [PATCH v1] ALSA: usb-audio: Add delay quirk for VIVO USB-C-XE710
 HEADSET
Thread-Index: Adrrx/rSceiZRtvLTQCEDDgbMy1KKg==
Date: Sun, 11 Aug 2024 08:30:11 +0000
Message-ID:
 <TYUPR06MB6217FF67076AF3E49E12C877D2842@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SG2PR06MB5033:EE_
x-ms-office365-filtering-correlation-id: d5ef3653-fd39-4464-405f-08dcb9dfd10c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?YUllcXhNVkpOT09kb0RCRkF5ZVlPNlQySEZRVGh3SWErOGFWZ1Rpd1loZDF0?=
 =?gb2312?B?VC9ZTGxoaFlSRUhTRkltQk9sd2p0UHRFUWpIbHJFYkVLT3FJelErSldVVTY2?=
 =?gb2312?B?LzA3MW1HSE9JdUhPaVBJTFhsaVh6R1lsK20waGJaNm84RFhLbys5YWlHRXVI?=
 =?gb2312?B?SFFhdWNHdjIzUGJlcGdqeUVLZlcxR3p4TkpQSkxrYVlwcVQ0a01TWXRWRmhH?=
 =?gb2312?B?d1lPaGY1bUZReVJNVkNXSklQTnRQRC96MUpaSW43M2U4QXB2M3dvVkJCN3Rs?=
 =?gb2312?B?REw3eGZQOWNFckVFMzNFRzBPaGk4RmhIblZxNUt2N0ZYUitEQXQ1dWhIeHJv?=
 =?gb2312?B?Z2JRZXhRaVk3eCtzR3BpMVBzdzMxU21jVDlDY0MyV0RkZWdPdU9lT05XRWRm?=
 =?gb2312?B?ckZjSGo2QlJENUlQRE96bHFud3pTTy8ydlFEKysya1NBeFlDcWh1ZXFDSkc2?=
 =?gb2312?B?Znpmei9lUzF3T1FtM2xKb1hoYjAxS2RnN2g2ZnpHRHRQL0FFWFA3VUIvSVZj?=
 =?gb2312?B?anBaZmFHU3NZM0E0SDNjRDBvVVUxbFpHWHVZREx0T1RweDkwU1lkUlJLK2ZF?=
 =?gb2312?B?ZTlJczFUdGlMY2JiTStCTktRTWdFTWJmekIwL1NjSTdpTy9TNjdRc3ZSSnd1?=
 =?gb2312?B?QlZuZmp0VzBPYWhodzRRMGdlaGNSRy8yU0llUGZ1QVJwTytCUmVPRlBlVFVL?=
 =?gb2312?B?T3k3Q2xBelF0cHJtbkEvRlp6ZFp4YkIyQzM5Ris3UGIwS09od0dvcTY1aFVM?=
 =?gb2312?B?dHg2NktObEs5SmlQKzdsZjZSbGdDdG1ZbS82Wld4NVZ4ZjBpTHZTK2hxQmdJ?=
 =?gb2312?B?alJUNk5jakpYMktvOG9NK2ZHMjFDZXB5dHZnVlFPelBaM0s4dFBLM1VOYWp3?=
 =?gb2312?B?dklrbHdQU0plaStXTlU1V0lWOXB1ZVhvcmlMQjdVcldSTiswNjlnTjVTc3ov?=
 =?gb2312?B?d20yOTFQOGlZamh2UXRpc0Y3RnRpbVA3UVBjUzE0MG9WRXpIMjhxYkVoY0Jj?=
 =?gb2312?B?dWZjWGhVUCt0dTRaVUhMbkdKaE10TUVhOFBhUThNOFhUN1hROGxRc0M4Nzd2?=
 =?gb2312?B?TDR6Y0NrdVkzSUFTVGhCOGI5UlptNVNmNVJYclYzK0NNVngxTit5VW5oVWE4?=
 =?gb2312?B?a2d2Q1RxZ1F5ZlQ3d2RTSTNTc2UzRDdXLzFpalQ4ZU9WTElLdUdvQVU4TjA1?=
 =?gb2312?B?N3NOU0prYmVBN1BJT0htRTFmcnJDVW9SUTNhVm1FaGJIY2FXdCtmNU1mUlR4?=
 =?gb2312?B?YnRsYkQ3Lys3dlBlc2t5RDZHeTdiRjJFWGhreTJHbDdZR2hzYWM5dEIveUhI?=
 =?gb2312?B?S0lQbmMrWnJFTGkzQW5TeUVPcHhjaGtXQ1E4ZUtsZk1pU2IxUEYyWnZkMWNz?=
 =?gb2312?B?Qml3OExidkNvRHVIM3RpVFozTTFDZitzZFlDdXl1dEZvdnFwRDJFLzVMUXVy?=
 =?gb2312?B?VlBmUndBdm8wdzM4ZGgraUFYSDlzQzByQ3BnVEdJeitvMGJzQkZ5L0c4NlMw?=
 =?gb2312?B?bTBIbnF3ZWhEUzZCQ2ZvKy9YYTBZWW1xMkRPSmR1eXNKZUNGWTAzMzhBS2gv?=
 =?gb2312?B?b1VmMWZUcW5ic3N3d1ZoTnZIOXQwYm9vQUwxN1Z5TXg3M3lpZFZtYTBxNUE1?=
 =?gb2312?B?VXdjNHE4aVFaWEFRMDcwelZGNlRPMzNWRTVIMUE5TmFxNmEwUnhER08ybTVh?=
 =?gb2312?B?V2tzUHNPckZBUTQyUVAxRnE5OHVHZ2RSUS9hV24vVkRzZTlqNzAydTNGVDVZ?=
 =?gb2312?B?bmpydWJYWndnc1lMbXZ3eXQwOVBTRHBKMjNFZWsyZHFpK3gvU1ErNExoVHFu?=
 =?gb2312?B?VGs4SFgxOGpwRjFDMDdSbWNqV2NZbXI5ODBKZjh5anVFQmZxeElxQUM1Y1pH?=
 =?gb2312?B?MldLaXdaVElub1Q2bWo1ZmZGcS8zY0trSmxWMnpNNThHRnk4VzBmUDB2d3d3?=
 =?gb2312?Q?RQZh+Na63Bo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bzh0MTlzV1pHV3kyU21YTENVb3hMQ3pkdUxRWDNGZTN6ZU9kd0V6VUQxWjZH?=
 =?gb2312?B?VEZHaFo2VjEyc1dWVVREZEZRZmYrdEp1c2w5akFaa2JFY05ydVZ4ekJZd1Ez?=
 =?gb2312?B?RUF4WlJSSEZNb2Y5akVlVmtkZTI0NVRZVzhDUGtwbUZYQzRkVDBYbHJKdWVI?=
 =?gb2312?B?MklOKzExRWhwTDdJV0Nud1gvTGs1RStINUtRYzJtSDUrUHltbmJGWDRFKzMr?=
 =?gb2312?B?K1hyaEduNnkyenQ5c3hSTjg1ZU5DUy90QnA3TVBKUnUvWGgwUjdyQUNwVnlK?=
 =?gb2312?B?TmJVRWowUmpVVGZlWFR0TGVvWjN1aWRuUTdpMWNMOGduMlMweUFmRy9qVmV2?=
 =?gb2312?B?VVFtRG1JNyszSU1RNCtrMCs4bkpQVWRLWm95YWZ5MDRENngxaU9ERDJmZFUx?=
 =?gb2312?B?YU1qQ2hVVmZnU0VRVVlWaUdQNnpWYTVJanJMNEpuYVBHL2N3UVJ4K3N0emdk?=
 =?gb2312?B?UG9kZU9UM0VDZ1N3UUVTSUkxN0Rjam11SGlDRTNKZU1HbXRSYWZXS1pGeG1H?=
 =?gb2312?B?MkZDd0l2YWNJd2Z5OFg3eWdSZm9sV3kzbWsyY3l2b1czRFZWU1ZEbE5odUxx?=
 =?gb2312?B?KzdZdkUva0x6Zlc3MndlZFVkRGJheDliaXF5TXl6TXhwcDdkZzZEcWNoZGNI?=
 =?gb2312?B?QkpLc2pGME9WMnI3SnllU3lsVUxoczJINXlBZGZwVXp5ZjZWZHpoVGVqVFJK?=
 =?gb2312?B?b0VPRFo0Qy9scksxYUlHRXhTR2tnNEI0QzBNMkc3bUdXclhyMkpqc3pUbVdz?=
 =?gb2312?B?cnhaSjdDYU4vTFZ0YjRQNmdkdGkvL3U3UGpNZW5URmtSYytQK2tBMDlqVWdm?=
 =?gb2312?B?QXpmSGxMbHdPNkhmQWVXVFVHU2RUWE5kTmU0NmE0enpwUGNhb0NuSlFERTM5?=
 =?gb2312?B?M1JuczBJTVNvSktmRjBEWjZvRkNhdjd4N0xBSFViRmQ1UkRSWk41bUc1eTBj?=
 =?gb2312?B?eWxodWlDbkFFbFNJemVETTF6TjZ6NnlqNkFBM3k4VldKQW5HNW9LUG5LdFBU?=
 =?gb2312?B?cDkwOUIzL1dxbm1EWnBIdEhkUjJiQ1Z5WG1kZWpqR3BuTjdlbDl3RzIxRlIw?=
 =?gb2312?B?L2JVZzdIRkxPMUp2ZEgrODB5VHFCVjBKSlAwRW40ZDNYK0VyVG1hVVE3dzN5?=
 =?gb2312?B?cmFIZlY1bktaTGhUbHZvaE8zWkVmQ2pXcDVsSlBOekppeW0zWVhHaDZXZm43?=
 =?gb2312?B?dWlyQXpvOHpLL2R1OTR2ck9aTTFuL0pIVFF1dzJPZE1NMUdySjNrVVpHcksw?=
 =?gb2312?B?czZCU1pHK0NiVHRMOUVUQWxoTzJJY1F0OVhzWE42Tnhodk9FWUxrQndmM3Yz?=
 =?gb2312?B?dGJteWFjYXJqN25xdjhwMndXK3M2SzN3NU83RENLTDRvOGdtS1IyY2JiNTNq?=
 =?gb2312?B?azdCeStQVWswVWNseUp4bWtpK0swOXY5czJ6RURvREI0UjBscFVHOGliMVZK?=
 =?gb2312?B?RUdjWDU1Z1FDRjluSDF1YzBFUVJyS2VCNzA2YXlXYmZzeFpkNE1zcUJIQmhP?=
 =?gb2312?B?N0hzc3lMTWZLdHg0NGZlTTA2T01ZN2lpbWZGOWcwRzc0c3FNclFldDFmUGVo?=
 =?gb2312?B?Zi9PNEZpNERGN0lGenliVlZxcGhIVlBDSUNyUEVLRFhBM2RTYjJWWnRKWmZT?=
 =?gb2312?B?eGhUTjJ2YWNldGNJaHpGdUJvYnNNdUZOaVU5S2tCaG5NRWFJRUN4VnF4eGNu?=
 =?gb2312?B?MUZrdytEVDRxVUhqcWJBQ3pac1M4bDhQdUhpK1NXRWMyNlNJbjB5ZmU5eCtr?=
 =?gb2312?B?WEZPRS9HM2VGNXJHNm9lRmwyWHNtYWFmc2huWlg5RElSN1RkcXQ0RVNDRzIv?=
 =?gb2312?B?ZlBDQy82QitENnh6dXVPRGxST0Q1U0lYM3ZsaXFJakgrYjNvSnB3aTRkb2h3?=
 =?gb2312?B?Yy9PR1RZQmxOUmcxMGJTOWFxZWxucFdPSlAwdkt2Vlhqa0NaMWY2YlRFZXEz?=
 =?gb2312?B?TmpPbFFRSW5EcGtBUXYzRllublFCMk9QdG1oNG1xRlVlVW9nSFZMdHIreko5?=
 =?gb2312?B?YWNFbTdTMDdRTFNxdkIxVTlLY3E3WXFIM3BtZDYvVW5ZeCtYbFppMUtFM1Bl?=
 =?gb2312?B?WHp6YjZYY2cyMHgvNmpRdDZReHp0U0JnWXpkZGZWQU9RaDh6dDlIalNRUE5Y?=
 =?gb2312?Q?xCUI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ef3653-fd39-4464-405f-08dcb9dfd10c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2024 08:30:11.5253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZgRB1a1/C+RtMUDAYdy0GTydngv/ZxH8pGnwL80gnuZ0sYKrVF4I6zzZl71nInxMP/QRJtNj5bhwcI7cdAy6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5033

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpBdWRpbyBjb250cm9sIHJl
cXVlc3RzIHRoYXQgc2V0cyBzYW1wbGluZyBmcmVxdWVuY3kgc29tZXRpbWVzIGZhaWwgb24NCnRo
aXMgY2FyZC4gQWRkaW5nIGRlbGF5IGJldHdlZW4gY29udHJvbCBtZXNzYWdlcyBlbGltaW5hdGVz
IHRoYXQgcHJvYmxlbS4NCg0KU2lnbmVkLW9mZi1ieTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZp
dm8uY29tPg0KLS0tDQp2MToNCiAgLSBNb2RpZnkgdGhlIGNvZGUgcG9zaXRpb24gYW5kIHNvcnQg
YnkgSUQNCi0tLQ0KIHNvdW5kL3VzYi9xdWlya3MuYyB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9zb3VuZC91c2IvcXVpcmtzLmMgYi9zb3Vu
ZC91c2IvcXVpcmtzLmMNCmluZGV4IGVhMDYzYTE0Y2RkOC4uZTdiNjhjNjc4NTJlIDEwMDY0NA0K
LS0tIGEvc291bmQvdXNiL3F1aXJrcy5jDQorKysgYi9zb3VuZC91c2IvcXVpcmtzLmMNCkBAIC0y
MjIxLDYgKzIyMjEsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHVzYl9hdWRpb19xdWlya19mbGFn
c190YWJsZSBxdWlya19mbGFnc190YWJsZVtdID0gew0KIAkJICAgUVVJUktfRkxBR19HRU5FUklD
X0lNUExJQ0lUX0ZCKSwNCiAJREVWSUNFX0ZMRygweDJiNTMsIDB4MDAzMSwgLyogRmllcm8gU0Mt
MDEgKGZpcm13YXJlIHYxLjEuMCkgKi8NCiAJCSAgIFFVSVJLX0ZMQUdfR0VORVJJQ19JTVBMSUNJ
VF9GQiksDQorCURFVklDRV9GTEcoMHgyZDk1LCAweDgwMjEsIC8qIFZJVk8gVVNCLUMtWEU3MTAg
SEVBRFNFVCAqLw0KKwkJICAgUVVJUktfRkxBR19DVExfTVNHX0RFTEFZXzFNKSwNCiAJREVWSUNF
X0ZMRygweDMwYmUsIDB4MDEwMSwgLyogU2NoaWl0IEhlbCAqLw0KIAkJICAgUVVJUktfRkxBR19J
R05PUkVfQ1RMX0VSUk9SKSwNCiAJREVWSUNFX0ZMRygweDQxM2MsIDB4YTUwNiwgLyogRGVsbCBB
RTUxNSBzb3VuZCBiYXIgKi8NCi0tIA0KMi4zOS4wDQoNCg==

