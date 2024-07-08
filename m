Return-Path: <linux-kernel+bounces-244087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D239929F00
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840B91C21CAE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062CC55892;
	Mon,  8 Jul 2024 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PRKFAlYd"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2082.outbound.protection.outlook.com [40.107.117.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F483D0AD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430763; cv=fail; b=ByjyzUXzk8MfXCTqan21Nbo8eVV1VD+nXVbTNizwqDiVzRJLn1g5sQ7TdocdfZWxqxvXxmzHZqhKki8LtbwSAQKyC4Vy1+RbpuZFBJilAeeDbOyiVaa7dJLQuc09iPwfDVjqhd5EVF+fG6e04WqCVp6NHn9Z+/UgPPEhEJsAExo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430763; c=relaxed/simple;
	bh=PDsS2TxMDmpjHNhrQRhp6eKi2XM/affKjWeXqKcf/hY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sjv2zLGtffYJBF8YXjBgxLKMWHdEX88e6ZBgvSvYqqWjVHLNFWhuSiYq/6vtsdm0jSYhBtEt8CKqqV2F2dUlE+l6naiOIowgMX1fD3d4xehBpQpkSJx4S41CcsXmkFf1pg8juJA0Pv0MqnTxSNKk3lHgxyOuFunFR/xLCLekuWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PRKFAlYd; arc=fail smtp.client-ip=40.107.117.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2/wmspdvEPV3JlbmBsgdq9u2GMLHwXUc3z63lB9Tcj0LODlPOstb1M8ZgBVKh8J+asnF8nN6pT3rb+kyvOrMpsjLpWdYXpSq+bedeZN92l/1qIiPk9Xb76t5LMtiP4K3gFfJ/DM6p0b61m9xWYy9dmKfov/bKGkPOy/hvWR6kDkWQhlS3Q86llUfQe4lBMPTqJzvFmpTLZEBLu1K9pOSvyylI2h2ykdb87Q49rZpse8ADT+Ua/GnRyhljlzkiuiNiYsobWW9fC2+PPomrwaLIKkfsYWcuMGT86D3p0YjntFZzVptJ+y3DsztpP+GJ3U6OX6Q1swofOEP+Os53rCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daJB2raanN1awiLdNnA/UrS/DcnhfgY2ynV2tENEUfI=;
 b=XauUxLQZI6evjuX40bAfxlQZZYpQxrIumd90f7+gdzAzyDzs7QLVwLKoEynCFnk997l8YPyBlGi0s4xjacbB9dpvXZQXo/ALkE1Fmu3OsJRA1rVc0bSIBqzbB6pRLoUBb0JQfKDQ+Z1HcDe29d6S4JYDNgnDfuuUSIbxT8gSh0rkfCoLDtp7Z1llV6qEIMqfuhTn93dagyTEHBr83OfsXHvAmAAsX++Ua0Fs8DBVHkVNw4p1PDoC1urVuM0m5hrUSeZYo+F5HHW+JTuPfyljPxkLvDazTQqIEiFxLycNT9XLaBRDtmD6+gTkhezgbChP5N0sGFoScQzm/G77ElK35A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daJB2raanN1awiLdNnA/UrS/DcnhfgY2ynV2tENEUfI=;
 b=PRKFAlYd+MQrh0yUwfSc7hPpwJeXe5m4wfNlCDPn6mlymC16mJA7BJRYHYICU72CQCR6z6PIEOSKR9/uMcaTgVBGU0wjevhcIjADlFr3OO+G4KO8PH3j8Ts3N3xHnGHLT+CWY28gh8IZJLLjveBGDvc6uphQJWI7UgO5S8alKnnrkURfW8+oUQUCLBXOizv7UZUnj8XbEMGHttUxWMnuddS+4d0ZqKQOUlyzU6FCoV+vcgl9e5T54xamkidicIW4TSiLIoz8AaRYy6RO+FuFeeEkvWSopSbyvkjRZJlF4VUB43MyYEMSHRdGjK2QcJgemon4Y4iSTWRvmgwHUzkMVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Mon, 8 Jul
 2024 09:25:58 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 09:25:58 +0000
Message-ID: <016ce193-9b19-4621-817b-782fd3dd6449@vivo.com>
Date: Mon, 8 Jul 2024 17:25:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: shrink skip folio mapped by an exiting task
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <baohua@kernel.org>,
 opensource.kernel@vivo.com,
 Qianfeng Rong <rongqianfeng@vivo.corp-partner.google.com>
References: <20240708031517.856-1-justinjiang@vivo.com>
 <ZoteOYap1M4kxWV8@casper.infradead.org>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <ZoteOYap1M4kxWV8@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2cd722-2c0f-48ec-e19f-08dc9f2ff995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlU5WmhQZ1JCQXB1cFIyNVFiSGRFZGxJajAyQ21oakxDZWZEQjVBbmhFNHhx?=
 =?utf-8?B?UmNaTElVZnAyVmRsdFd3VDJkQ1BKeVhHMTlvaEs5VjR2VC92anZxZFlCUkFs?=
 =?utf-8?B?b3I2Sll4SkNpZnEybkdnUFRXRGFBMUxldjZQaWdoRlE4R0pUZDE3eDJlbkhs?=
 =?utf-8?B?M0ZBaWdXQ0RUVjhrOU0yN25QdE5XVS9zbUpiajMvZ3h4VjNUeDJmMG4wb01o?=
 =?utf-8?B?TFdNUE43dzd2YzhBWTdvMk5lQlk0eDkyNjkzU0N4bldUWkUzWjBwY1d4V25w?=
 =?utf-8?B?TktUbmJmdFB2MXp5b2swQzFlYXNTRkJndDY3V2R2S1NRQlAxL1dHdUZFcmRo?=
 =?utf-8?B?WVNHVFhLME5nOS9PcTBtcTNFOXd6L1RtM0ZYNzlYWWxia3Y0WURaenJzV0Jo?=
 =?utf-8?B?U3hIdFZJRzE1ZWRaelIrN0pldEhzY1VoaWU3Z0ZpUmtzRG4xQ1VsUksrT29U?=
 =?utf-8?B?NGRqa2JsU0dlQ2dLWkxXQmRUbW4rekFKd3A5UjBZSC9Ed3lhZm43NlpBMEFs?=
 =?utf-8?B?TWZmWEgrNnVjZUozQzY0cjdtdjFsNUxUakpUTEE0alg0QkZHM2pLNlE5SnJW?=
 =?utf-8?B?RzBUVzlMNFRjRDJlN2FQakhuZ1NmaUpFT3FaalgwN1llYkNrZC9KdWhCUEQx?=
 =?utf-8?B?d2xPZU90R3BFMEt2SHJhQm1PUXNCdE5MRWhtVUptQ0M4VGlJaTM1dnVZNkZZ?=
 =?utf-8?B?cUJva1V0RHE5UDZKaUNkckM5YTZKTDA5YkVqbEJsenFWbkEwSHhVYXpZMTlV?=
 =?utf-8?B?UHZCbHNpdzR2MXllcjJLbTdSYjlWeVAwdG1mY0FpVjllS2NnRTYxd2owVmdG?=
 =?utf-8?B?RFNKTEdmQmVjT3Rna0l0ZkIvYlNERWZGNEZncmFEaVpQWXUrY3A0L2RYc3h4?=
 =?utf-8?B?L1hLQ0ZWR3F2Y1VudEw5MGZZemlpQUxuSVlMelVqbi96REhhT3NBL1FGb1VP?=
 =?utf-8?B?ak1BUUNDWWwzZDU0MFJ5emlOQitLblR0MjE0YWswOXFrYTUrZUthVm5oU004?=
 =?utf-8?B?N1VsaGNBTDhsaWtFRU4wZGVXeEs2OENCY0Q2dFQ0aWd6VEx4a2xVeTQ3MDVG?=
 =?utf-8?B?anlVRnBrazUvalJpZWRVcEt0MkN3dllKUVVDMCtaWVlTbGZoNzhnQW9Pc2x6?=
 =?utf-8?B?M2pFZEp0Si9IM05jNG5hblNmN2hLSHNXVisrVi9EcXA1MDMxd01qSzhPTzRs?=
 =?utf-8?B?WmFOTVRTdEdtc0JSN0FlWHBzNEFjb1UwNTkyU3RiSDlkV3RlSUlmS3VWOWE2?=
 =?utf-8?B?TDI0U1pWM0xtWEtxSDJlK28xUWdLNlMwbjdWczVGZXRmYUNuY1pqSE1Fb2Zi?=
 =?utf-8?B?SEJjcTFDa0gycjlQQmNlNkhUL1JESWxGcTN0d1RibGxJSkl3ajJBcUF6SnVY?=
 =?utf-8?B?QWVQSUtZNEpHNi9ZSVRGcmlrSGd3cGJKZHJTN3I1L1ZSa2w1ZnpwRkZVNTJX?=
 =?utf-8?B?TUlIT3J1MWlQRk1uR0tWWVA2MEt1V2hDNkMzSC8reGd5eFRoOGxRR0pDaXVu?=
 =?utf-8?B?MVZ3a0VJS0FVQXY4RE9TSkJmWnRaK1VXeUNGTWY4UjRNNnFOSjdPbHJQNmNi?=
 =?utf-8?B?NHFwTDhqdkhSN29wckVudDN0QkJ3cGZwN2pRelVyeUlCNU5uakxnaWNMS3N6?=
 =?utf-8?B?YXFsdldEdWxlbmFCbkZSNERaQjhEUmpXTWlObFlhVjN2Wm9hRVJOem1IRUZk?=
 =?utf-8?B?MlRMaFVJcXZ0Y0dOZUxmZjJjYjh0bGNMdVlpa0xUSVQ0MlMzYUNLU0gzWWpV?=
 =?utf-8?B?MmtOamhvRWloenFEMEdXSEU0YzZYZjRGMkhTVTlTcHEvMUlOQ1EzTGozVmdx?=
 =?utf-8?B?LzhOcTV2QzdMa0R5TFVjYXJiOGxiczU1WDhnWUYrYk1UY1Y0Y0JxZG5nUEV0?=
 =?utf-8?Q?h4AzHt+xtlmHp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDVoQ3UzRmpvVVpGdDYxS21NRFdpcWlYMm4xU2w1VG93R1NwangzblBMSTlI?=
 =?utf-8?B?dnQwUkd4d3kwMTk5Nm90akFoQTBVTGJPQTFPN2hheExZcnlMbEM1QVJTWElL?=
 =?utf-8?B?eEZseTJOZ214MjFuNTUvT1JsdS9LYlFhczJiSTJCclVZK1pXRk5oQ0o2aTdx?=
 =?utf-8?B?VTZHUHFMY2FiUGpDdXdXRHpyblFIWG5LMk5xUWNjNVMrdDR0TnJEbkxtOFJH?=
 =?utf-8?B?UDc4OUFIOURpeHI3U1o2dkVsdjh3Z3RUaVZUZWtpSHhKWTl4eU0rNEkwa2Y5?=
 =?utf-8?B?S1Z1S2V4RzQ1bDZ4ZWRiSng4cmZQY1ZFanZiK3l5NHZBODJkYmJPbTJBOUN0?=
 =?utf-8?B?M2E1VklIc3hNS2J4VnJ6TjBLb210T21UcGI5QldYWGE2WjBqdXNjWU5hY2RP?=
 =?utf-8?B?MlJpdFhMOGhpclpsckVLV1ByQnhVWVhKZVNCV0pUZHRQOWlacmFNNkw5T2lF?=
 =?utf-8?B?L3BRRmJkcUlVQ1JxL2U5dmVWZlhLdUZlaUVhb2J4aDlzaVkyQTRweWY5U3Uz?=
 =?utf-8?B?OWNVUjZENHNUQ2t4MDJRSFpuV1dJN2puTk10RGtOdFN2QW4wcksxK3VGYk5U?=
 =?utf-8?B?K21LNjMyMHZrZlcvbUNlTXVrQ3lQWVlHaXFmYVFGeUFtcExUTW9nSFVOd0l0?=
 =?utf-8?B?VG4ySkZ4NVFkN0txblN6dVZsQkdseG4xVFFTaHVPajR3amxUOVBpUFY0V1RN?=
 =?utf-8?B?WWwyVlFMUVhNMjBrZ3JhZ0QwMWMxWGFkbHdncmM3NUV6b0ZlS2lCUnhEWlRy?=
 =?utf-8?B?bGR1K1VvL0lXMGtsSlBGYkJnUk5OblZaTlVuZ0VyS1pFQlFiV2FXdVBVYzRr?=
 =?utf-8?B?MUR2aXlUa2ZQcnIrT201enpLRTZ5UkdDVmZpa0s3OUtJekxvK3IwdTJaNmpQ?=
 =?utf-8?B?TDcySWhyZUpXTXBreFFOWnkwRXcvelhhZExtZTF3ZVNHckVPMnhOdVlHMGRL?=
 =?utf-8?B?aDFhWWdkcTcrUzI0QzgraEx5TnFCQ210KzR5YU5LYStLdGJNN0pTeGV3R05O?=
 =?utf-8?B?ZzVTUEUyamQ5N3Q5T3N4cTh2QXZPajlBS1dPWDZFcDJuY05ES09uSE41NnhG?=
 =?utf-8?B?OExNZTAwc3NEY29qUWh5MTNSRlNxWHNGVmNCWkIvQnVoaTA2OEZBbjl5cC94?=
 =?utf-8?B?ZWI2cWxFYWZkMytYV3lsOHVhTEw5TkVHZGVIRnRHRkxxSkl1YjcrYmRYUmNE?=
 =?utf-8?B?eWNFd3ljT2lMRk95MFRiTTNFVDdOQmtpQUhxNTRGK2Z2SnUxNWVLQWIvZUVj?=
 =?utf-8?B?bjVnMElicks3emloY3dUQmhtT2psQ2FjZzdib3d1WHdYSE1TS013MWZka2ov?=
 =?utf-8?B?UWdrdk93NkxNS25qdkdISlJIZ2RjZCtDTVhOSWgvV0dJZHRkcklIaHhpMmV1?=
 =?utf-8?B?RjJaYzFXNGlwUWI0eitORUk2U3NCR3RLWHZHMzVwMWJld3F2ci8rTGVQUDBk?=
 =?utf-8?B?ajRxRGw0alBucDhlQ3JoQkVJZ3RyRE9EZ3gyckhyY3drNXBHa1FqL20vUEl5?=
 =?utf-8?B?M0N1Vzd6ZVpid0RTbUk3WWt1RTNuNjc3NHRUS1dPOGs0UHAxVDVZelE2NFUr?=
 =?utf-8?B?QXB3djZrVGNFZFp4WnlnUElDK1JsbHkvTEdDcmllMis5QktBZU1yMzBlQUxj?=
 =?utf-8?B?M1NUSktRRGRmRnJvcDNzbjl0cXJhaHNtWVI3d0Zkanl6ejdTZ1hUNE9wQlRF?=
 =?utf-8?B?bFdWZDM1SHgvTStxdVBBOTlsY2V0a2VxdXJDY2F3QkgwdkE2dFF5UFd3QzRi?=
 =?utf-8?B?MmwwbHhCc1ROWU1wcmFNNTlCUXNIUURBQ2xKZW1qSUN1S0FiR0RrUFZPWG43?=
 =?utf-8?B?MGluUXFIM0FvK2kyYk1KUk94Zy9kNUpoM0lnVCt5UWliUE9MckFHbHBsNzdz?=
 =?utf-8?B?TncvOEw1S1B0NWI2NGtpcXVnTCtvNTViY2R5UEdqNU9PWWtFVEJmcmthazFC?=
 =?utf-8?B?eFZ5blE1V1BzeDRoQmNYcnczSUZNUVA1cGNwV1BmREVBUXljb1R0SWdkeFY2?=
 =?utf-8?B?Rjk1dHpkdHIrWTdKTzRoclJmMnJNbktjdVNPNGpZRklOUXhmeHhxcnRXbDRq?=
 =?utf-8?B?NnR0enVCcElmeWg0dkNoMHEyVHExWTNNNVVpbThQVnlrUlpPYjAvQnRyQWhz?=
 =?utf-8?Q?wM6mSCmZq1cpluoU9NRW6E9PL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2cd722-2c0f-48ec-e19f-08dc9f2ff995
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 09:25:58.0190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyTV2rmMFMurcVqAlcmson3MrzpAAcV7ZlsNDac+sYuiRBQFzOYTdcvI7K4CcDMYrfuYu+iGHlHJNMXoCzTBJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253



在 2024/7/8 11:34, Matthew Wilcox 写道:
> On Mon, Jul 08, 2024 at 11:15:17AM +0800, Zhiguo Jiang wrote:
>> If an anon folio reclaimed by shrink_inactive_list is mapped by an
>> exiting task, this anon folio will be firstly swaped-out into
>> swapspace in shrink flow and then this swap folio is freed in task
>> exit flow. But if this folio mapped by an exiting task can skip
>> shrink and be freed directly in task exiting flow, which will save
>> swap-out time and alleviate the load of the tasks exiting process.
>> The file folio is also similar.
> How is the file folio similar?  File folios are never written to swap,
> and they'll be written back from the page cache whenever the filesystem
> decides it's a good time to do so.
>
>>   mm/rmap.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>   mode change 100644 => 100755 mm/rmap.c
> Uh, what?  Why would you make this file executable?
>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 26806b49a86f..16b7ed04bcbe
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -843,6 +843,16 @@ static bool folio_referenced_one(struct folio *folio,
>>   	int referenced = 0;
>>   	unsigned long start = address, ptes = 0;
>>   
>> +	/* Skip the unshared folios mapped only by the single
>> +	 * exiting process.
>> +	 */
> Comments start with a /* on a line by itself.
>
>> +	if ((!atomic_read(&vma->vm_mm->mm_users) ||
>> +		test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags)) &&
>> +		!test_bit(VM_SHARED, &vma->vm_flags)) {
>> +		pra->referenced = -1;
>> +		return false;
> This indentation is unreadable.  Follow the style used in the rest of
> the file.
Update in patch v5.
https://lore.kernel.org/linux-mm/20240708090413.888-1-justinjiang@vivo.com/
Thanks
>


