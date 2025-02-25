Return-Path: <linux-kernel+bounces-531879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB324A44625
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4558A1658B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B52F1946DA;
	Tue, 25 Feb 2025 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wud3T+Dj"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013035.outbound.protection.outlook.com [52.101.67.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC7917E015;
	Tue, 25 Feb 2025 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501180; cv=fail; b=kdTHphwWuVEIak0NKq/5jskOwWtABRcCrmex2PN1XH+YHZCJcPApyufGW+Bo1smk9R0+VP36C2a/lKZtd2RbwYdbq6neqsi6fbXqs62XgJOqO+jTzi4Bo5vn+o0HfCdxi9yeuAcSjZMHp9mOiQrfnslk+3bRmH6pYa4OLv4ksSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501180; c=relaxed/simple;
	bh=yIB/AA+Ez43vUkYASNMhlHQOKGhGkOzU3APN6R+xynk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nJEGkrSyqlp9VC5e0t1uLPBHhuRf6ui2+MwUiHh1eS5me9jBouTBT8itOemn/ATfh/Il3TO8MKsPSq3Wfw/PYsesiHoJyb1lRGgMtIBUq7a6maUaL3gL3umACmBjjyv2ITr2KlYN/MQyYuX6jcsKeD4jeAo0YoVunXZ8da/YTt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wud3T+Dj; arc=fail smtp.client-ip=52.101.67.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYG1SbEIusw8FBz0EkCvKpb/8PFWqaQgBEakNERk0ksmpNvrivq1mcNPPaKLRHLK7+Lf4kriOisasFioGra8i0mUQlylRoNIh8kS3marIMImJLY5nRY0Du0v/UllnuKW2m2+FXi/FEF4qyyRTs3dX31C2XWl8MIXZZvM67xufZQYouGptiJBs8n1QuWoUx0VG4yEkq8FWSGdpvh0k0hw7Oe3TQ6N7HTdQTJK2oEvqrv9zjWS6ammSvj8epBCRUxo2WPw+D//W3JD/R2UrQV5fCtKzu0UCR03DSYUeqVdPzVdVrmlm5NlFm6+sasMLzc22Lr7Qsc/Es7taEk6iZH6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmLr5GAlwztOR+sKIaiTxfdJvxb67yG5kycEVa7Sxkg=;
 b=pqy0mwx8k3qQKVE5FbqRAMmDBZulVHm3mwSbjOF2Q63C7oe8lfj9wkrsGB/ZjQ4dvWXiTUMjqzH+gsdTEo8jwhV4HTxuMwsAFHmiTq2J9Nr5lAvtm3NQr33RlwoKvq0GE2RnmED26eDutdQN1PUGnovyT69AVx+KgRWghLxhKipQax1bG3KsMSPvUa8fQE/sB3/u5DkHD/0gE7W9l4j8ADkbYgXVugbXOWa5J9wnnL78XQka5OiPzLMO+LLNE+GjrhAsCiNUJDKFoHn/Qx8stZ/oirMPJItJCdUO3tsFJ2qvGCYPK2xtorkmQL35KWJqU3r6wCDnJruINIpIAr1Xbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmLr5GAlwztOR+sKIaiTxfdJvxb67yG5kycEVa7Sxkg=;
 b=Wud3T+Djrnm4EenRBhasIOY59R34PGUWK9GMAXGU3vja3KaMESTKfL33hKPocfpyy8GlLh97g6r8nP2oXqxrvVdMkMzEjmBD6T+dKZFPoGt1LfN/1/QvKTZZelXJv34ICgCtv7k45IDtRVH2rssDW6Hb08F1trblcFtpVAhWrWvHKUYhi1MOlPsAVugXqN3eTJmaShT5QmXGL/wwHIA+/jB3M30TXoJIFFkI69P1TDbEeg/PhbGdOE9tsTLZXEFBx/oFnwgdzqDwZYF1BdSOuhtQzlZfj/CSpYWBGWvCl+HStEcXOxMrrizXGKuAUei5K0HrBl7fIsB6CnX9SgPtcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10586.eurprd04.prod.outlook.com (2603:10a6:150:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 16:32:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 16:32:53 +0000
Date: Tue, 25 Feb 2025 11:32:47 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v4 3/5] i3c: master: svc: Fix npcm845 FIFO empty issue
Message-ID: <Z73wr/6Or6SWOQD8@lizhi-Precision-Tower-5810>
References: <20250224083908.1880383-1-yschu@nuvoton.com>
 <20250224083908.1880383-4-yschu@nuvoton.com>
 <Z7yfEunAWuR8jchq@lizhi-Precision-Tower-5810>
 <CAPwEoQNZef_CeeCDNFGG4oJHCiM3MN9-juq+xX3hB5DKp4vorQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPwEoQNZef_CeeCDNFGG4oJHCiM3MN9-juq+xX3hB5DKp4vorQ@mail.gmail.com>
X-ClientProxiedBy: SA9P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10586:EE_
X-MS-Office365-Filtering-Correlation-Id: 958f8bb7-e963-46cc-266f-08dd55ba0d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEhjR1dIUElmbjFlYXZ4VlhEMGxqTGQ5d1N6VjdWTFFHY1BnbzA1YjFnUTlj?=
 =?utf-8?B?WDE3UVpGMXNvQWtUTm1WZDVSRG1rUzZCU1U2YjBVLzY4VEdTRSt2UllRV1pI?=
 =?utf-8?B?TnNWZmpzZzlwaFNINEEzZFBvYitZYjJFUkRPTVpSZ01XQ2tYUFpRWFhScnNB?=
 =?utf-8?B?WXVPb042LzRlNFVDcnd6T1hCdG8ybjhIRUhaeS9xYnZDTVptM0JNV0tYdG1l?=
 =?utf-8?B?UzFaU1RBMUNHUExJemZ0RGVCTi9POU5rRU5maGFSTEpqVkJQUmw5UWJaRVlk?=
 =?utf-8?B?NThsYXlnQUpFcHdjaE81cFNkcUwySENTaUpKR2IrdmYwb1pYWHpmc253eGtj?=
 =?utf-8?B?MVRTR1Y1N292RlJKMURxL2xGWGdzQU9NRExBZm1PTVNtd0lGT2VxeG5EZTFX?=
 =?utf-8?B?bzhJQ1dGT1R0VXhld2xkTFhodWVYKy9iVjRRVTlnazUwUnViZFF1dEc1d1pz?=
 =?utf-8?B?MnhKSlRSVTh1VTAvRjJMbU9FKzVkM24wQ3JNSlVSYkUwV2JLemVHZHdINE02?=
 =?utf-8?B?eU5UN0QxanVNT3lxRXgvVUNjaFlwMzhWYW9GU0E5NkJ1UXJMenV6OXRmazhN?=
 =?utf-8?B?NDJUODg3RkhJR3lSamJYc21VbG1wT1MwdFJLeHV0a21NeEh4L0ovUkxsYUpQ?=
 =?utf-8?B?RGtrcC9YbHh5KzVzZEUrY1RpZkNVRldqU1hrb3JZOENmOHJBUU5sWUx4L0Nh?=
 =?utf-8?B?dWR0YTZ1c3ZGV1FwRU51U0k3MWVGQkthUXR5L2I4K0J3MHlmQUZpZWQ3Z0Vs?=
 =?utf-8?B?MkVBdllOTkNUMEdFSUd5SG9VdUg4MFhYMmQ5WjFlMXlxNGZWTmd2UUFKaWxI?=
 =?utf-8?B?NnoxY2NhRWlNL2tIemQ1ZVQ5Z2d4dk94UjZveHZ3QTlEOEFoUVRNdS8rZ1Q4?=
 =?utf-8?B?K0FMc0ZxMTMvNEVsd3kveU1VZFhhWGlIaklxZDZPK0RjS3R4YXVDTmVSZlpV?=
 =?utf-8?B?Z3JpRkRySnIvN1AweTN0QmRNYm1pVndEVnY2dk5PaG9VMVRjQ25YMmVQTnls?=
 =?utf-8?B?RjdFY3JYZzZtbjF3YVFjQ2krWHg2Zm1tTlFqRUtsVHZnSmZaNVREZkh2NU9S?=
 =?utf-8?B?SXo0L2VKRGgxRlFhSnJyZ2FXVmNNMjc1QnZPb3dLd2o4cS9yZVFzOGdhOWxV?=
 =?utf-8?B?T2dOcXRFaTRpcEFlVFhwZDJNQmw5M0RwRklIcHVGZmd0aVhLYUtEZmZpN040?=
 =?utf-8?B?VXRPSkpiNk1mQ3IzQWp3S1FQVituOVZqNVdTZEYwZ01yOHJhenM0cGxlWURB?=
 =?utf-8?B?K2U0a2M5NXRVYlhhUU1LT3Rna3I4MUFKSW4xZ1pSZEhzSHZoM2p0WkRhQWEz?=
 =?utf-8?B?dzl5ODU4UExZMWJ2SVViNWFxaFVQYlVBL0dPUU9acjZzdTJua0lSc0dPOTNq?=
 =?utf-8?B?SEdYZ2lQWk5YRDM1aE5UMVdTOGJlUVBUY3M0WmsrOUFiekoyR1pLY3pHVkRs?=
 =?utf-8?B?VDYwWlpSN1FCaVZqazVmWlpJS05INXUzNlk3OGZlUmxKeXQreXdTOHFHa2Vl?=
 =?utf-8?B?enZ6QkxvaHJBZFpEWGlVVXBneUJuVEV3cWdyM21aTWNwdEEySklyZWIxM1hH?=
 =?utf-8?B?U0sxVE4vRXhSY1pzWkxxcWtoS1p5eE5kRXhKelZaWURhUkNYWTl5OFRGcXhv?=
 =?utf-8?B?T1F4SEljZEMvaDRWdEJ5OTZmRForMVdDajhzQnl0Ti9JY2FuT1RKQ1I5b2ND?=
 =?utf-8?B?NG1mWTJOeXhlTE4zb2xsdEMxbWtTVWliYWl5TDZEajByQmVCRXlCUWhGS1B2?=
 =?utf-8?B?U3lnbktsZE1TWThpSWMwNmlDRjlxQ0k0RUJNdUgvWmM3NW4vYWhZVzNaTXZC?=
 =?utf-8?B?enBkNFByZHVXVnA2VHhWRlV5dUZqbWhGdWJVTDBHcy9tQ01ma3ordC81S2to?=
 =?utf-8?B?aDY3cGxiUEFEWklWMGdmOWlwdDEyVHUwd3g4b0ZWNFlZQUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVFqcVdQQ0cyei9rem43T290bnRBUnF3THBOaDNMRUp2OGVNZXl3KzlETXpE?=
 =?utf-8?B?UTNITlB4TW11d2VyR1owTWpadGpDakRJKzZrNmU1eXc3STJ1N3J3b3htWmhL?=
 =?utf-8?B?b2IxMm9tSzdXQTAzbEEzaThqUUEzKytkSUd2WVpvOGt2R3h5UXVYenlXRUIr?=
 =?utf-8?B?ckhNS21XMVlzUkJyOUJaRmtiMVN4R09UOTRDbXZZUlNucTFnWDQ5UzFNMlRQ?=
 =?utf-8?B?a05OSE54MnJjckc0NFRiNkJ3TzNGQko2WnNQc2xjUmg5eTZVVGtURmJOUVc4?=
 =?utf-8?B?L3lYYlNVWmQ3eVJOb1YxM3lNR0F5TkpzS2VzRFlvVU56U1IyU251dFpGcGVT?=
 =?utf-8?B?Zy8wVnk2dW9qcTl1QStjUG8xZjZoRjVmeTFDSHVHM3VCNUZXNVBjNktPZ3dD?=
 =?utf-8?B?MVJtZm5rcjRkeE13ajZwYXM5Z2JSdDFiT0xmbkF1ampNQzQ2Qm1SbmNwRTdX?=
 =?utf-8?B?amxBZ0wzVWdvODQ0ZkRaL1J4LzNTR1IwNnZPQy9sMjl3S2dXRkJMZUk4RWhU?=
 =?utf-8?B?aXdqajRtWHowTFltVjBDY25ZS0hwWkhLTlVKcUZQdTRSNUdsbG5KRnBCYURp?=
 =?utf-8?B?d1FwQVFvTVNGdk5YK1EyR1djRWY3RmkzaWllNC9ZSTBTRm9ielQ5QjNZdGNm?=
 =?utf-8?B?ZzIza1pBd1VxbnJac3dpRTdlenhNSlBsYkJmYmlodjdnTFBaYWdjMHgzNEkx?=
 =?utf-8?B?Z3ZDWno5ZlNyUUdxVHhQWFd2T1V0bHFHRGtCNkZwK2NucnRXbmZLSTFYZXhN?=
 =?utf-8?B?RFk4eGVVc3FBdTN1bGw0UUNaaTZrcCtpWkZtNkhFdU9ocDJhRzNIcFJxSWZY?=
 =?utf-8?B?TzNTQS9sMHlIbXpjOWdTWlpOU0wzeXNEdkZvSDdMSEFzODJ4M3lEdDZYNkQy?=
 =?utf-8?B?NDdDUnZLSXQ4OGJ2UzJkcnM4U3NIb09iVXlwUUd6UEtUUmFWYWQyVGEvR1J6?=
 =?utf-8?B?c29CeVRabVJHMlJVd1labjZCY3VOb2thcVJUUkNESC8yRU1yOGF1amd2S1JK?=
 =?utf-8?B?VTJJVjlMaWMza3hqYWpDQXIwdnJXSDRXeGNFQ0IydUxPUDFRblYvOFpCc2do?=
 =?utf-8?B?UDNteE5FMkEzY0p5TDVaOGNBWTJMMUw2N2FLQkpJTlpOVHRzQUpqS1VLRitG?=
 =?utf-8?B?blJJcWIzS2hYQ0xWUVNaVlMvYnVXQzV3NURuZmxDU2JlQkFHbUVuZ3pBdEt0?=
 =?utf-8?B?UUNiR21yQjQwMFpDRUNPTkllQVJNcWhlTzFWend0TmdISmZNVTV5elp3SGxr?=
 =?utf-8?B?bk1EWURjTG5iSzRGS2J5L1pUUlB1Tmp6Z0EvYytSK1QxVU1oTDBKRmhQV2JY?=
 =?utf-8?B?MDhZTndQVnhUdVViNTY0cjRscU8wQk00RnZUb0FPdytMOVR2SVY5Y2s5bXpv?=
 =?utf-8?B?ZWhrZTdVczE1citGZFBENHBhWjZVdWJ6S2h4ZW5UREMzM1JJb0Q3bEN1ZmhI?=
 =?utf-8?B?Tlh2M1piZVJCS2JGY3JTNXZucDBqUjdJcFVjVWpCa2toZmtEaFlpajFqVVF6?=
 =?utf-8?B?VTBLalVzOGxCNzVHcHhMZmtKa2Q4aXBLOFY1MlYyU2RLSDNVUEIraXZER1pk?=
 =?utf-8?B?aFNtM3VoQ09uZ1pwUGhIYVhxV1lpWGZnbXBoVUtRamxhWFIyTlkrUmVqQkVG?=
 =?utf-8?B?OGszQmd6RTVyMHBWKzFPNnJiVExMcTBaeTltUy9GZVNxcDRZb21yWkJDa1da?=
 =?utf-8?B?d3VHanZjanROaERMd2wvU2pyVnUzZVBMTTdVOVc0VnJrTFQ4bHo5R2llMGhs?=
 =?utf-8?B?ZmtBeXNJVm1PSnd4YTZKd3pQZ09NaUc2WlRPOVdCaG0xOG0vWjNJMytJUUx1?=
 =?utf-8?B?a2tYRmFLazNkaUw1a1hIV2JEUmp3ajJ3SllKQ0hHcWRLVmVRTWx0Z2VhOW1D?=
 =?utf-8?B?MUF6U3VRQnBvcjZDZzBSMDFONFFhdVBpalRIdVQ0RWRYWlRUbWpuWEMwTkxk?=
 =?utf-8?B?RHUzZ3QyTVhoQTdIZW85bnJxSTRJUmR2R1dtaVJTekw3NWhaaS9oRUtIeWFk?=
 =?utf-8?B?WFk2MUlLc1JuU0hxQTdzQUQ0OGgvUDZJbjQ2Nk9IWlhaNWpIRVhRcVk5RVM2?=
 =?utf-8?B?Y3RGTmdwMk94NVhyYm5UMytDdnNjbzdSWWIrTE1LcmJydU1DSGMrT0R4eXli?=
 =?utf-8?Q?9BXoA5BrmKlBS4k0kHq3i2xPf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958f8bb7-e963-46cc-266f-08dd55ba0d30
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:32:53.1468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsgTca4iNhdFcOLYwcJdA9XJtXnYT805ooWqKpudkPnrT+h3UHX2RULb1/PncOhCDZg/oJ0/HcWw8CkqlNhpWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10586

On Tue, Feb 25, 2025 at 05:28:48PM +0800, Stanley Chu wrote:
> On Tue, Feb 25, 2025 at 12:32 AM Frank Li <Frank.li@nxp.com> wrote:
> >
> > On Mon, Feb 24, 2025 at 04:39:06PM +0800, Stanley Chu wrote:
> > > From: Stanley Chu <yschu@nuvoton.com>
> > >
> > > I3C HW stalls the write transfer if the transmit FIFO becomes empty,
> > > when new data is written to FIFO, I3C HW resumes the transfer but the
> > > first transmitted data bit may have the wrong value.
> > > Fill the FIFO in advance to prevent FIFO from becoming empty.
> > >
> > > Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> > > ---
> > >  drivers/i3c/master/svc-i3c-master.c | 44 ++++++++++++++++++++---------
> > >  1 file changed, 31 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> > > index 8834f87a4767..07506ae0f914 100644
> > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > @@ -942,7 +942,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
> > >                                       u8 *addrs, unsigned int *count)
> > >  {
> > >       u64 prov_id[SVC_I3C_MAX_DEVS] = {}, nacking_prov_id = 0;
> > > -     unsigned int dev_nb = 0, last_addr = 0;
> > > +     unsigned int dev_nb = 0, last_addr = 0, dyn_addr;
> > >       u32 reg;
> > >       int ret, i;
> > >
> > > @@ -985,6 +985,17 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
> > >               if (SVC_I3C_MSTATUS_RXPEND(reg)) {
> > >                       u8 data[6];
> > >
> > > +                     /*
> > > +                      * One slave sends its ID to request for address assignment,
> > > +                      * pre-filling the dynamic address can reduce SCL clock stalls
> > > +                      * and also fix the SVC_I3C_QUIRK_FIFO_EMPTY quirk.
> > > +                      */
> > > +                     dyn_addr = i3c_master_get_free_addr(&master->base, last_addr + 1);
> > > +                     if (dyn_addr < 0)
> > > +                             return -ENOSPC;
> > > +
> > > +                     writel(dyn_addr, master->regs + SVC_I3C_MWDATAB);
> > > +
> >
> > Although there is 64 clock time after issue do_daa, it is still better if
> > prefill dyn_addr before sent do daa command?
> >
> > If add a debug message before i3c_master_get_free_addr(), does it trigger
> > hardware issue?
> >
> > Frank
>
> Ideally, prefilling before the processDAA command is better. However,
> it requires an additional check to write the dyn_addr at the right time
> because the driver needs to write the processDAA command twice for one
> assignment
>
> Prefilling here is safe and efficient because the FIFO starts filling
> within a few hundred nanoseconds on the npcm845, which is significantly
> faster compared to the 64 SCL clock cycles.

Okay, please this to comments.

>
>
> >
> > >                       /*
> > >                        * We only care about the 48-bit provisioned ID yet to
> > >                        * be sure a device does not nack an address twice.
> > > @@ -1063,21 +1074,16 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
> > >               if (ret)
> > >                       break;
> > >
> > > -             /* Give the slave device a suitable dynamic address */
> > > -             ret = i3c_master_get_free_addr(&master->base, last_addr + 1);
> > > -             if (ret < 0)
> > > -                     break;
> > > -
> > > -             addrs[dev_nb] = ret;
> > > +             addrs[dev_nb] = dyn_addr;
> > >               dev_dbg(master->dev, "DAA: device %d assigned to 0x%02x\n",
> > >                       dev_nb, addrs[dev_nb]);
> > > -
> > > -             writel(addrs[dev_nb], master->regs + SVC_I3C_MWDATAB);
> > >               last_addr = addrs[dev_nb++];
> > >       }
> > >
> > >       /* Need manual issue STOP except for Complete condition */
> > >       svc_i3c_master_emit_stop(master);
> > > +     svc_i3c_master_flush_fifo(master);
> > > +
> > >       return ret;
> > >  }
> > >
> > > @@ -1225,8 +1231,8 @@ static int svc_i3c_master_read(struct svc_i3c_master *master,
> > >       return offset;
> > >  }
> > >
> > > -static int svc_i3c_master_write(struct svc_i3c_master *master,
> > > -                             const u8 *out, unsigned int len)
> > > +static int svc_i3c_master_write(struct svc_i3c_master *master, const u8 *out,
> > > +                             unsigned int len, bool last)
> > >  {
> > >       int offset = 0, ret;
> > >       u32 mdctrl;
> > > @@ -1243,7 +1249,7 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
> > >                * The last byte to be sent over the bus must either have the
> > >                * "end" bit set or be written in MWDATABE.
> > >                */
> > > -             if (likely(offset < (len - 1)))
> > > +             if (likely(offset < (len - 1)) || !last)
> > >                       writel(out[offset++], master->regs + SVC_I3C_MWDATAB);
> > >               else
> > >                       writel(out[offset++], master->regs + SVC_I3C_MWDATABE);
> > > @@ -1274,6 +1280,17 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
> > >                      SVC_I3C_MCTRL_RDTERM(*actual_len),
> > >                      master->regs + SVC_I3C_MCTRL);
> > >
> > > +             if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) && !rnw && xfer_len) {
> > > +                     u32 len = min_t(u32, xfer_len, SVC_I3C_FIFO_SIZE);
> > > +
> > > +                     ret = svc_i3c_master_write(master, out, len,
> > > +                                                xfer_len <= SVC_I3C_FIFO_SIZE);
> > > +                     if (ret < 0)
> > > +                             goto emit_stop;
> > > +                     xfer_len -= len;
> > > +                     out += len;
> > > +             }
> > > +
> >
> > The same here, you prefill data after issue sent out address, timing still
> > tight, only 9 SCL clock time. should it prefill before issue address?
> >
> > Frank
>
> The entire transaction can consist of multiple read and write
> transfers. In the case
> of S+7E/W+Sr+dyn_addr/W+data+P, If the data is prefilled before Sr, it
> will be emitted

I think S+7E/W should be xfer[0]
        Sr+dyn_addr/W + data + P should be xfer[1]

this function only handle one xfer each call. xfer[0]'s size is 0, no
pre fill data.

Only have prefill data at xfer[1].

> immediately and become part of the previous transfer.
>
> It is not a problem to fill FIFO here, the reason is the same as above.
> I will also modify the code as below to make it efficient and keep
> svc_i3c_master_write unchanged.

no issue to modify svc_i3c_master_write(). I consider prefill data before
actually.

This hardware is not prefect.  Although it aleady in spin lock, it may run
some secuity firmware in secuity domain.  There are 100us timeout. If a
hypervisor manage firmware interrupt transfer, one timeout may happen.

If prefill data before send address,  it was safe at least for lenght less
than FIFO case.

Frank

>
>                 if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) &&
> !rnw && xfer_len) {
>                         u32 len = min_t(u32, xfer_len, SVC_I3C_FIFO_SIZE);
>
>                         while (len--) {
>                                 if (xfer_len == 1)
>                                         writel(out[0], master->regs +
> SVC_I3C_MWDATABE);
>                                 else
>                                         writel(out[0], master->regs +
> SVC_I3C_MWDATAB);
>                                 xfer_len--;
>                                 out++;
>                         }
>                 }
>
>
> >
> > >               ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> > >                                SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
> > >               if (ret)
> > > @@ -1335,7 +1352,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
> > >       if (rnw)
> > >               ret = svc_i3c_master_read(master, in, xfer_len);
> > >       else
> > > -             ret = svc_i3c_master_write(master, out, xfer_len);
> > > +             ret = svc_i3c_master_write(master, out, xfer_len, true);
> > >       if (ret < 0)
> > >               goto emit_stop;
> > >
> > > @@ -1362,6 +1379,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
> > >  emit_stop:
> > >       svc_i3c_master_emit_stop(master);
> > >       svc_i3c_master_clear_merrwarn(master);
> > > +     svc_i3c_master_flush_fifo(master);
> > >
> > >       return ret;
> > >  }
> > > --
> > > 2.34.1
> > >
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

