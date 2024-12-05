Return-Path: <linux-kernel+bounces-433454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6FC9E5892
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940BB281D69
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1782D219A9F;
	Thu,  5 Dec 2024 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="XP+NNqkV"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E475149C64;
	Thu,  5 Dec 2024 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409342; cv=fail; b=PYE6nU3u2Uq/Mdis8gnnOAQfyQSF6Y5sC03EMlnK5S3KfKey/LuEX4mBhdHqDWkeWQsmpyt0dc/jKDs7+zabquYZXoCA+w+lCo5nd/3V3J6kjYMGJDaRTzOD7i8KVxgjGBrFl8HcPxPxHZQnYnJ0fEyg6RYOgxGqI0yHrTIdY4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409342; c=relaxed/simple;
	bh=WPCZpVlf88O0Ls2Pe0wiOHD4jpUGkDbnv7x60nG/zMw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jMs9tOVInCYNHKxkcKd9MtLmqWpWeF/cJzsIevlOPbU54YePM6njAYm7Fqa3SfOcWrzDfUBxjIC4fdZJOs3incXuG+Hatvqim2D9w1EBfxGXzNtmSliU31v1vKDkDgsjveYSFn3+/YvlDW4DIu1p5NmLaowUCnMMppql/hu5800=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=XP+NNqkV; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5Dt1Ko027577;
	Thu, 5 Dec 2024 14:35:19 GMT
Received: from ma0pr01cu012.outbound.protection.outlook.com (mail-southindiaazlp17011031.outbound.protection.outlook.com [40.93.131.31])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 437rwvtb0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 14:35:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8joWuzbMRe6GofNCnr/IaaE3RD5OaevovOdJxghe7HZAA9l1U8McVr5l262imqN2As6j245LuO4xPpSGI/X1PYF+1tRNQUrcLNx8L0dYVuysyM1dXMwTkD4lJnPi6D7UYnRND6i+Klk7gpnsvbNmOmMq/XjsmZIk7Ev0Wq9cCBXQMPuIPVEBhkFtzS9VNY2D1Do7nf7OkcuH65PUO0jUtNxTxyEgMKJ7AUUZO5uOGxVZ6yWIyrYKONVc5RjXignZ3oRX531ZII3ZOpv6B1lCQsfkabDB4Ct4xZjHCDYrElntl7cWHKRX1nxQlTJ7QGu8dyoMVpeKxBJdaUpXWho5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjvN4BijjzPeDBuqphRyCrttzwjAIXARm4a6Qm4FV7I=;
 b=amrFWukcmNBFP3Cb3tW+n+/6NLyJwIqkp5390gqyK788uvjlzdxOIcQOT4ZCzbywqy2vRjeVDIRKLP7jcqJxuXf8ioTPKIaOIoMsM02iNWfLhqpC5DVxmyGod7ZB+kJ9t09m/Dgs2n+XWyQvUfIRDnn9nC7DusgnWbzJU3i+JYCGSqOHTlYHF8Ixq6mJn2RoYNFdEwsnDuM/dwSoXQr6GoUV4TOSMZSia5iAb+5AiqwEvQ08IcdUIgAQzKwZugIoMBnkJ4AHHhM1XaXi5HHeySj0LonC3cARsAVaX0H6t6rCK0+70w3rXKM0KhzZP4Dwb5PD3JP7KOZkbx/Zd/bckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjvN4BijjzPeDBuqphRyCrttzwjAIXARm4a6Qm4FV7I=;
 b=XP+NNqkVy2jW1jLuKU0G9EA1JegdZYKwjGI4KIAcpjCs8oGGlr2dGSHYM+o9T2QWKuGVjFTFPM4el6LVpWE+ZrdqWDNwCa8qPiJ+4C9gi5iBLcBTA/tAFBx2Ozrw/zKRaUu9LfNdMaid5sfYB2Bk6ISLcCGKjSb+be5kEbooyM8=
Received: from PN2PPF1CBE88495.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04:1::18c) by PN3PR01MB5660.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:7c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 14:35:13 +0000
Received: from PN2PPF1CBE88495.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::73d:2f7:b113:d6ff]) by PN2PPF1CBE88495.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::73d:2f7:b113:d6ff%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 14:35:13 +0000
Message-ID: <3229b92c-0e0c-4661-8524-3f0f6e1ad87f@blaize.com>
Date: Thu, 5 Dec 2024 14:35:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] MAINTAINER: Add entry for Blaize SoC
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matt Redfearn
 <matt.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@lists.linux.dev
References: <20241204-blaize-blzp1600_init_board_support-v5-0-b642bcc49307@blaize.com>
 <20241204-blaize-blzp1600_init_board_support-v5-6-b642bcc49307@blaize.com>
 <h5awakp52e6pxnnfrclhtlhhs3i66twvmqwlf5vmnfwk2xhbwr@marp6wti72ti>
From: James Cowgill <james.cowgill@blaize.com>
Content-Language: en-US
In-Reply-To: <h5awakp52e6pxnnfrclhtlhhs3i66twvmqwlf5vmnfwk2xhbwr@marp6wti72ti>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0650.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::20) To PN2PPF1CBE88495.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04:1::18c)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPF1CBE88495:EE_|PN3PR01MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d110ba3-b333-412a-7163-08dd153a075e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2FNZGN2ejJsakMrREhHTUZ3eTcrejJ4VUxJcGVnRUF1UWphelNXQjlTanhE?=
 =?utf-8?B?UnNnRUw5U0Q3SnRYK0hXVWxzbndWTG5ncFlmVXdKWWFWOXhTT0xJanpGUk9M?=
 =?utf-8?B?T3pVR0pVeGN3SlVXWWZ5TWV0NVBtVXluVTU5MzNQMlNkcjBQOHd3ZHhxK3ls?=
 =?utf-8?B?WmFFUHFJTTFMYzc1ZnFsL0EzOHJKc3VXaHRCdUQwSW9MdTZSeUFNS09wUGJx?=
 =?utf-8?B?Zm1yUGNPbytTN2xQanozVHRVL29CS1ZPeVNqMCtuVTE2Sk14K1RtUzR6dzVR?=
 =?utf-8?B?eUhUcE9oKytha1pqY2xKbVNneFVvZE85bHVHOEZuOXN4WjVZWHEyWERRWnh0?=
 =?utf-8?B?WUVac2EvY2FOUVRyQXR2UGpyWU9QZ1J4SDNqTFp0MGtLem44ZjBUUWZ0VlJL?=
 =?utf-8?B?bzByMUhyVi9ULzlERnJoK2diajRwR2svN1QwZjk0ZjFCeVprT1gxWnJnUGRT?=
 =?utf-8?B?QzVaSmpFTHAvckJSekJYWS84YzFVVWdKQngrWEdwSHJKN2R1aTdmZmhETlF2?=
 =?utf-8?B?bzJzdFRNU25xcHFPQ09mZ2JlRHoyR2dWUkJrNHk4Q2pSZWxPdVNiTWExZ1ZL?=
 =?utf-8?B?S0pqTnlmczNBTS85Tm1kbTZpekdvV1dvMmFTMnU1YmljWDh1NHpzeVd2Mm9v?=
 =?utf-8?B?MEFQV1NKeVVjWVJQc04yMkJEOFFmQ3ltK1B5NHVVa0VrVDlHUkdzT21DKzh2?=
 =?utf-8?B?OERmQTNIb3A5ai93cTZZZk1UbTlPdHJkZVNrVmhvSzJaSjM3UkZqU3JjUlla?=
 =?utf-8?B?YVMvYkVsMHJZemlWSDZwVGI1Q1ZJZ256d3FrQVF6NXJrVlRYRGNnUDg0U24z?=
 =?utf-8?B?U2ttOUt5WjJQakxPVDA1MTd0MitrODJaMDRydW5IV2lNSTZybE4xZTlIMWNx?=
 =?utf-8?B?eWlCb1dLMGIzS0RRQ3YwV1ZkeEo5UUZ6QkRSM2VjaFYrb08yVFV2VWM5ZmJR?=
 =?utf-8?B?Qm1zTTlIZkhlV1JEQktBMVZlczFsaEZQUmVjTXFEdE1BNThNOW1oVHhlZVFG?=
 =?utf-8?B?SlJNMTErRmx0Q3RoQ042aTlWSzJ6R1R3NVY0RGQzOVpra0NJV21ucUxLSDJS?=
 =?utf-8?B?dFhYb0d1Lys5N3BvUE1KWHlPQmRWOCtiaEVLZkFZSkZJc1BrQVZCa0QzeHd6?=
 =?utf-8?B?ZkZaaDVWZzg4T2s0MkwwN3Q2MVUvdk9rSFV2cWJFZ0NXbldTeEFjZXZZWHIw?=
 =?utf-8?B?NGpYR1E4Z1NlYVNQaGE5QlM5SWJiY1JJU2E1VzZOclJpRUI2a3EyeEVLVGN0?=
 =?utf-8?B?WWsvclppYVVSOHBHVksrbUlDK2llVUErQVpKSURPUHAzOFRJM0RON0dxaGVN?=
 =?utf-8?B?K2FvZlEzTVg4QlNJVENaTGtDTmNFZUVuUWtoSnFVNjVPY2VlWDlSSlNYN2dt?=
 =?utf-8?B?YlFQdE9ZWGNCMDNyMnBqQmhSUDdUdUdwMHpibVlQTm5TUW4rZWxoRFhYSW53?=
 =?utf-8?B?QnFXeFFUUThHenBFc1NJWDlrdFRodXU1eC9mS2hQRzZ6aEh6SXBrd1EwR0cz?=
 =?utf-8?B?SzJBalBWNjJnQVg0Q2lnRnFhWWdFcmlNaEM4YWVOZHVwV0VTd1A4TVl2N1dv?=
 =?utf-8?B?Skl2bjJoRCtIdkN4VFRFOUNQWTRtRGZtV2FyeEJ2a2xJd2h1L0F2dkRZMkp4?=
 =?utf-8?B?NXNXTXYxSVE3elMzOFlFN1EvUW0weHBML24rZFN3cG90UFJsOXBFUFRtTE1F?=
 =?utf-8?B?SForSVppeUMxeUVWQm9BMVU1UFZzYzlsYTBUQ0NPRjA5WnJkRlJKU3dnand0?=
 =?utf-8?B?bDJRanRCUE5pcXloM3lXamF6NTlNekt4c0liMTByeTI4d3NvY2FpY3M3WHhN?=
 =?utf-8?B?ZkE3dnJtQ2hRWWhRZVYwQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPF1CBE88495.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnVnUjF2cUI5UmtrVlBTNkF5RW1yenR0RzJBZ0w5amRhckd2Q0dvSzZJUWdZ?=
 =?utf-8?B?SzRCTEtVYXI4TGRZUFZUWlZMUVN2NlA1aDRMRXBMWUcrMWdhQ0l6QTRyWkpC?=
 =?utf-8?B?eUhDSVlkY1VGNUluSGZwRk1TdTJRU3lPR092ZlNmU2pjL25kN3dTZGIvRmx3?=
 =?utf-8?B?STEzc3lDL0tHYjlyelpYZlc2V0FnM05Wa3FoSUlLcU52UUNFZm5yWkVSSkJQ?=
 =?utf-8?B?cS9uWlMyS2lqZXFDZmE3YXNRbDEycngybVZ4TVlZN0pBK1ovTXRJQkphdm0r?=
 =?utf-8?B?cnRaZWxoR2djUDZOa2RUdUlDdThMbldVaXFUTkd1ZWUwU3ZrRDB3Y0tDeXFk?=
 =?utf-8?B?UWgrL3JyaVZwWk85cGVpc2lMOUo1TGNhN2lqRXAzbG5nTFBEZk1IWGVZemlN?=
 =?utf-8?B?bVJjWmlENktBci91aDNQbnZTSkRaa3NGZlNCWVRzSFBPdnRhbWhMOCtid1gz?=
 =?utf-8?B?c3FkR3QzTVZrUkVhZmxiSm5meWR4TTZTT3dzZ3FiWm5yRjlwb0RkeGJDWjQ3?=
 =?utf-8?B?ZFV3UTlEVDIrUWhCRzVZblBGeEdOdWJJc0dFRVQ0Yi9HTGFidnMzdVNaYWhG?=
 =?utf-8?B?YThMTEJEcHVqTlRiTG9sRTFFS3NnSUpTRWtYc2lQV054YjMvWkJrMmw2SStD?=
 =?utf-8?B?a2N5NXBCVm1TRUpvZ2Ywb1F5K0h6em5xamNWTHpsdktmRDJ6aGt4cEF3amI0?=
 =?utf-8?B?YUZWb3VvZ3BTQU02b2tHRkF5VUM4RmJzeWdwb3FTMFZjY3kzM1BoZlY5NnpT?=
 =?utf-8?B?NndYSXhIYklnUGdSZktpelFkUHpkU1B0RkNpMThrdmlCeExJQkhtaldveXBh?=
 =?utf-8?B?cmdZNXp6WUlibUtrNUFXcElOaUwydVNvRnFVS3JrcHJ3V2FxUGs3b0krWHY5?=
 =?utf-8?B?cHBvZGs5NWhLNW5uLzU0RFZHMDlzaXUyK3pDZzQ5bHFhZTFEU0tjQmFSNHhp?=
 =?utf-8?B?eHJvbnhBeFkrc0MyaC9WZ095MDRKV0lUa3dSVzhhT05CaU56MndhQTNUUHQr?=
 =?utf-8?B?eDFFYWk1RWt1anJ6Zm1JWjUzb3NiMmlhbFpRdGp1alBRMnlLU1NpdHVsM3Nq?=
 =?utf-8?B?T2Y2VllGTDhaOEtBRy82d005eWV2Y2pHRS9kNTJ5ZXhid0crd2UxNVdobEpS?=
 =?utf-8?B?cVRrUWx3dzExOGc1cTJSYVlDZU1iSkFQUFk0SmtnQU8yMjJhbHNRS1BtbEE5?=
 =?utf-8?B?Y2JBdDZKLy9iSmdmajlEZDhXV1RneXR1K0d1VXBlb3Fjc1JIMFdUV3UxN2xl?=
 =?utf-8?B?dU0yUHZ2diszTlFLZU0wdE9NN1BGRFRKSmtvcmorTFRhbTdvNThvblE5eFFt?=
 =?utf-8?B?ZDBwR0xZUlcydUl4T3RLRDk4M2NlbW80Yk1kdmxacWVvY0x0UlZzUlVZNnFl?=
 =?utf-8?B?YlBSNzRnTTFxWXRDNEE0N2x3M09VWWZHRG9iOWR4ajVlOGZXUmRTcjNrdnNB?=
 =?utf-8?B?VG5aMjVscDkxVU1wSWRmNFl4bVJCT1hjWkVOb0JLbkcxdUR5cHpTWlRxdzls?=
 =?utf-8?B?bnJlV29aN2dOM1p6YW9mRXpvRzR5SnZlWEMreUVKd3UzYmlkWCtXa3lmRjRh?=
 =?utf-8?B?Qm1sVnk5NmJPdVpvK1JpR1pEdWVIZndRTXpUWDV1ejlSRlhWTDczYkRwczFV?=
 =?utf-8?B?ZlFuWExET3E0Z1FsR0tCMTk0aFc3T0Frdm9iMGVONUdjVFcwWllTZXZ5VXZF?=
 =?utf-8?B?TWxDSzc1N2REQ1FjRzZnMEJLWE1ETGM3djd5L05Rb0RiQndkVWY5NzloK0c0?=
 =?utf-8?B?dFQ5WG5RZTVtbzUyMmpCNGptTDdsOS9nTS9Cdm9zLzI2WmdMWUNrOVA3RHB0?=
 =?utf-8?B?UlJYUnNldFh1L0JIb0pkSnFFbFdtT1RvcUcycUpNcVkyaDlmVmt0VTYzaVl1?=
 =?utf-8?B?eFhSbnl5UDdJRDh1Z3hlS1VDVE5xUXZqQlZJT1UzaDVwMDdYd1k0U1RRL0VF?=
 =?utf-8?B?MHFhb1oyL1A2eE9sR3NxNUZRemlobnpodDFMM2RIMmgrZ2tzSElKalZpWVow?=
 =?utf-8?B?WkhGdldZUzA5ZnpmQ1BpYlN0TDBKa21wZ25TQWNQTGhBeUFGYWNuODJrSVJZ?=
 =?utf-8?B?VHlWdDF2aDFlQUV2djJFeW5WbnlzVHhaSkwzYjhoTU9UcHc5R3JwKzcxK3Z5?=
 =?utf-8?B?cjBVMXF0T2xZUU55eVRkV3pLZ0psQ3hrdHpLanNUS043eklRY0pZczFpSlJx?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d110ba3-b333-412a-7163-08dd153a075e
X-MS-Exchange-CrossTenant-AuthSource: PN2PPF1CBE88495.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 14:35:13.5649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EehLMr8QMfKo3iFQQALtiBaf/vpaRNOPqksNCickGtuZHMDLpPim5sW/Pzu0trgOVeMgEpvkKkqWUbZEe7Xf3fA/cvaWOsSwDDj7hEBgp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB5660
X-Proofpoint-ORIG-GUID: WB4CNA3KXFtJ24voakqLAR7tsCUKRjen
X-Authority-Analysis: v=2.4 cv=cZQormDM c=1 sm=1 tr=0 ts=6751ba27 cx=c_pps a=eu+VrafKqrkYN/YfGA+BZQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=4MthsM0t3ikA:10
 a=-5LYVjoNHPMA:10 a=SrsycIMJAAAA:8 a=KKAkSRfTAAAA:8 a=JGrr_fRlCiheIX6WwVYA:9 a=QEXdDO2ut3YA:10 a=zapPnUM7SFj2ezx6rUw-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: WB4CNA3KXFtJ24voakqLAR7tsCUKRjen
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_12,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Reason: orgsafe

On 05/12/2024 08:16, Krzysztof Kozlowski wrote:
> On Wed, Dec 04, 2024 at 04:05:29PM +0000, Nikolaos Pasaloukos wrote:
>> Add MAINTAINERS entry for Blaize SoC platform with a list of
>> maintainers.
>>
>> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
>> ---
>>  MAINTAINERS | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 273a84483b74543b510de7b08804bbd1f6514358..43846a23f9d990ae9fe066e65ed2bdd36376e327 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2238,6 +2238,15 @@ F:	arch/arm64/boot/dts/bitmain/
>>  F:	drivers/clk/clk-bm1880.c
>>  F:	drivers/pinctrl/pinctrl-bm1880.c
>>  
>> +ARM/BLAIZE ARCHITECTURE
>> +M:	James Cowgill <james.cowgill@blaize.com>
>> +M:	Matt Redfearn <matt.redfearn@blaize.com>
>> +M:	Neil Jones <neil.jones@blaize.com>
>> +M:	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> 
> Just to be clear: this is list of active maintainers, so all above are
> supposed to perform reviews or maintainer duties. This is not
> credits/managers/I-need-to-please-someone list.
> 
> With the assumption these are active maintainers:
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> They should also ack it to confirm they understand the burden.

Acked-by: James Cowgill <james.cowgill@blaize.com>

James

