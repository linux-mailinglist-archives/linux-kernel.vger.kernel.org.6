Return-Path: <linux-kernel+bounces-519268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2A1A39AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D3818938CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ABF23C8A0;
	Tue, 18 Feb 2025 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XBj5Lvng"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55D11B21B7;
	Tue, 18 Feb 2025 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877935; cv=fail; b=M2G/uja71B7eFmqrD6kLrSOIR566akj4mmaeafo77l96IwZitrbY/oHNkyWR2xVzEo0aHVxd147hvyMXyf3cetON132r2j2hvaJ7pFtpSTN3eZr4VzZN/o4edx+jxF8dB390VsbuCjpw7KgRFiROY+LuM3L3H8Ob6DsG7ryM260=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877935; c=relaxed/simple;
	bh=DFDT8VO2yRoqFtj5sN301xR2L9HPJPVsvCCx6/P5mPQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MRIWQDpT7THMl6CMtz47ucYh32NghX/UM8ZcOGdcwlWqghBOXwLoMq4Xf4XUOO5IP3Vs0eOG9odSmzuIdCZv/jIXXRVwcGx9IFPOPMJvUgDTw9gfxVXr2XQYP5KT7SObk1kjVaH5eoBBhaGdmp2g3kJgIyNC6i5vHpbFll4MMlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XBj5Lvng; arc=fail smtp.client-ip=40.107.20.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieuN+RiluLUyBV3LMP3bEtZ2AXcambIRNpCRPpJASkVphlQmwra1sYUGyabmtgT+Z0Tog7Pnejx93RsfvcT5THD0vpyhJIc3wF3I+OyVs/Qg9k2z0zHbz3lcWv8TUB3XterPNSa4NaExc0W0f0U6MeLiGXkhXMqpmoTcjx5Lh9EQ90QGwrqVsJT02eVUG8p5UPrMqkxEFZpYyZm73KSUA7GUPHUye/MPJABssQ8gadzHr1bfKXnbxyvmkpfaAt3+3z77jZGmVlh5SI06sFE4jB/vDQOuYU99fyVPmLkId7pN51GpXj49NPShjcyco9w4CHLsvBmeFcCcclchWS5mdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNawVRHIb9fm6Fz1GGpn+x3UEFqqIJ/ty3pZtik8MSI=;
 b=OouNheTA/nxoBoHsGtJFcvHRLDcwEem8vBIYzmIgyo2M24NAKS1gZj/Aq1nFC01+4uJfU6G4CGFqQ6d8YACQ7ZLTMdm+KStxVWLDI7pzQG8gbOdkwq17jDswEJtuLmrI/gSGbCHKSDUvevf+fUKhF1+nmQpQrG+zksIhzJIJrTnZJ5UD5Qw85QjofQG+nMXij78pQsK+Fhg+FkuyeuqQhb0YEx8NXjxpD9GGJDXQBdbq9bxWFWJCPgnLK8XL2BJWrs2s9YuF9ya/lWUZNhfFHKdjoRIV57qDG6/iTDjkIFCtMl+mDKg64H7UczDNlSVju9Ur6O/cvwkYKPYegvQOFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNawVRHIb9fm6Fz1GGpn+x3UEFqqIJ/ty3pZtik8MSI=;
 b=XBj5LvngH6VjFaQ3SJxh5At6hQGLw6cNutv09b8F5Rcq1sOX27Omdh/kmPx1lkK1ZnmO8SG88058/mSJjVq/cuUpq6sn52qafJrEaTVQ3OxY/T5GiOGyj2o2Ry6Oj0dt7v7xrYWvnETZfN4m4jCApQnQ61iYkExbBJB6EG1GXKXh5SAYefzfVP4PSLxs00jXggy31/uascmzSTG9I9H5BtF00/CJ7+HkzFkq1gn8IWFU5asyV9iFAAQIw/G7pkPrFDRHd0e+8YQh02eFh6IpAj2TxHPuw2S5qiXpHKIHJaKHOJqymlN4RoxZ9eUnYiC6u7YVVGef/62gibRg+yMNHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8781.eurprd04.prod.outlook.com (2603:10a6:102:20c::22)
 by AS1PR04MB9383.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 11:25:30 +0000
Received: from PAXPR04MB8781.eurprd04.prod.outlook.com
 ([fe80::f8eb:f1e7:abe0:d3e0]) by PAXPR04MB8781.eurprd04.prod.outlook.com
 ([fe80::f8eb:f1e7:abe0:d3e0%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 11:25:30 +0000
Message-ID: <a3be91a8-e959-4dea-959f-aa884a163d1e@nxp.com>
Date: Tue, 18 Feb 2025 13:25:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] clk: imx8mp: fix parents of AUDIOMIX DSP/OCRAM_A
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>,
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
 Stephen Boyd <sboyd@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-clk@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250217165718.74619-1-laurentiumihalcea111@gmail.com>
Content-Language: en-US
From: Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20250217165718.74619-1-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0122.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::19) To PAXPR04MB8781.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8781:EE_|AS1PR04MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: 75da4ede-2768-4761-6eab-08dd500ef37a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3A2MllzbkY0ZnVtQTg4cHB0RkNzcjI3azRraVlLN2IwTUFVck1UcGluYXB1?=
 =?utf-8?B?RER5Q1puNkNYSUdEQlM3cUtqNFN0VHBDYVhrZUUrc25tRDk0bmFYM3ZTYUwr?=
 =?utf-8?B?bUFHVXBRSW5VYTNtS01xYjRzakRMZGZ6ak9BeGZKWVVSWE5RS1VlSW9XRFE5?=
 =?utf-8?B?YVFZT2xTRllFM0VuMXZFcENvQ3J6WFVaUXlwTmhOWHNuR3EvR25vRHM2S1Fq?=
 =?utf-8?B?K0laK25kaE05ZGxPS2RtaE5vZXRxU3V5NXJpMTFzaHRjNzRvWlplcUs2RTNR?=
 =?utf-8?B?STliYTRMR1RNTURqSjBrNi9VeGl5UXZGZkxTWDdabWRzWEs2MEZYOUdQNTFP?=
 =?utf-8?B?K0YwZWJ3cHo0MmZ2TGlDdEdmbU01T2JXSXJkai8wYi8zenVteUJZL1VER0V4?=
 =?utf-8?B?N3NlSlFENWFvRHd4OVQ4dUR4bWdGL292L1VnUWhUQWtWcTRtc0F4T0crY25u?=
 =?utf-8?B?UVZKL0pGZ2NGSk9NL3RlWlVDSXo3WjNSNnlycklzcURlZUhuY01PK0lGSmxv?=
 =?utf-8?B?d2lpTVBaRzhDbitUdXp3bTVmbHRBdGhteVltZkJNRVM0MmI4NGlCSEJIVlZT?=
 =?utf-8?B?QnEza0xjYU1FRjR5QWoxbVRMUXhCcGNWY2xKUGo2NzRTU2JaUCtPQkNQVity?=
 =?utf-8?B?c3pOTTJZekg2V0NzS0NKQ3BLdWVCYkNhMU40czdrbGhYa3ozVUcyeWJHUjR0?=
 =?utf-8?B?TU53T0l4RGhZWFI5Y2I0akM0am9GeURPSUg4N05NVDIyNzNYb3dZaWhIMHlp?=
 =?utf-8?B?MHFTYzRQd0lzV2Fwd09yMkNSdE9ZMjNDeFFNSXpNNXBDbjNMV3V6dEN3alRY?=
 =?utf-8?B?RGN5OVBEVDVlR0V4OGRJRFR1bmdUODdFNGU4VW5HV3JscTE3WnlBdlhsZnc2?=
 =?utf-8?B?OHBZV04ycnRtOWNTL2wyci9FYmJWTWhmQk5ERmxOMnJPSVdLSElOR05ZbnBa?=
 =?utf-8?B?VVhUcEg0Uk4vTUNicHRPQmxNMi9XdUE3c0MrZ2xNeVFzT21kLzgzdHpvcW1z?=
 =?utf-8?B?L2NNT09TclpyelRLUlV3OTNXaHBiN2p4NjVxU2FuVlRtOUREa1FJbUNMUStQ?=
 =?utf-8?B?b0JqZ2l0VWlSQk5RYVJCMmJIaUpUaURHMWxlODFTcSt2UzE4LzVUczdnYlhK?=
 =?utf-8?B?K1VERmc2d20xNzdNZW9mZWFpdXpnL0JnMG41aVFrS2d3aXZtZTdiRk41ZVFu?=
 =?utf-8?B?R1BOK1JCa1Vzc3RZcTBMTFlSaHVCK0NTUU1ucThXSFNETlc4Z1ZwcHV1bTRi?=
 =?utf-8?B?UytRY1VRemlneEQrMmhiSnIzMHNFQVFiRFdKYXFUUjFaY0FSMVRiVUtBbmU1?=
 =?utf-8?B?cjkrZU9POVhzZTE0NGg4T01sRnRvb2dibWc2eE13blJjMVpXYTNuZ1ZVRVVJ?=
 =?utf-8?B?YlFJQURYaEE2bFIzdDdPVUhlRDFMeDVyWUs0dzBOa3QrcVpsOHVsU1VmR2ha?=
 =?utf-8?B?UjBXS21Razg3M3FodXRaT1FkaCtHcTdhSTZtcXBrNHN4TDZ2SFF3OUJ6ekdJ?=
 =?utf-8?B?TTdUcEdVWTAzSjA0Z3U2a2E3NGdySTU0ZEpPNGNEaytod1F5MVE4c2pqQXNH?=
 =?utf-8?B?am9UM2NEZEthbGd2YkZsODRCUlZLcVF0NldHRjEwT2paYmVCUmhwL1VvMEg1?=
 =?utf-8?B?cGxMaXFZdU1FNVBlT254Tkp6NjJCL3pZUDFuNlN3c2dCWk5KNVRDc0FiL2xm?=
 =?utf-8?B?Y3RjYzFjTy9YMkFVZjN5UUFyYml1SnQvTW5JRFMrVlBsa3ovZ1pHY2QzWSsw?=
 =?utf-8?B?UzhOZWgzRXBHOHJZNlNrdUZQYSs2VWJlVmErRFdObjM1OEE5MVlUd3I4bGx2?=
 =?utf-8?B?aXIycEo5QWRvL2lYOTBXbmFLeTlPMitqc1J0NVk2TFhYMkdGUXVoa09NeEpt?=
 =?utf-8?Q?Opx8SP7PqxMXu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8781.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjJnTStIbjVvSVcrRjE4ZDl6OXJYOGIzSEo4MjFpdS9pSStTUjFBdmIxeXpU?=
 =?utf-8?B?dzFXSGtORTQ0WXVzWkRUaWh0WlVmU1dsQnlYckp3MGhUWWJFSzVabGwrYXNn?=
 =?utf-8?B?aUxkNjdTNmZCdzdlK3lOUzNQQ0ZjUS82QkVlMmVLb1BrN2N5Z2N2L1hFSG9i?=
 =?utf-8?B?WUZkcXdZYnFKSFlPWXRocFNVRFh5S2dLTW8rL2N2bEdmTnZGMlhKMkVKblZL?=
 =?utf-8?B?eWNrNnU0c2ZCSFlYZ2ErWHJlUkJFNUo3ZVRlNkNRRHBwbmhSOXVRNk00RHo4?=
 =?utf-8?B?SHlUZWswTjRmSGpPNllteE5mUFRSRkdnM29GZmtPRndhcWJ1TDNZVk40MTRk?=
 =?utf-8?B?eE81U3k3bzJWSEU3UHlxUTJwSUZCczBTdGwvUXgrTE5ycy8vZ0JaVHAybGpM?=
 =?utf-8?B?cms2WFdMWStEZ2w0bGE2RmNwWUxLY1psSDREaHFsQm5sdDMzQkw3WTlPb1gz?=
 =?utf-8?B?K2dIcCtPK0pQWk5iZ25LWklsOXpqQldqUVc4WUdueFhGR01VZ21hN2FIVGwr?=
 =?utf-8?B?NXpaaVg1Qm8vZTUvTndib0dCTGJpSytaY2tYazgzbk8wNVVzSUo4eG9KSDZE?=
 =?utf-8?B?MnExKzBGQjNHcjV0RmFpT0tRWkVqZHBsZmpMUFlNY2c4TTBrSWZkNmpEZS9h?=
 =?utf-8?B?VlRPK2hDKys1MTlmUi94M1lyckVOR013YjR2UWdzc05NTWtXOFFYZmRKOHBy?=
 =?utf-8?B?WE4zeGZFZGVINkVlbVhtLzBlVFdUN2FGRU90RHNMdHFJYjBrcTNWM2FOVGpw?=
 =?utf-8?B?MnZ0bjlIbGdBNVhSMnRzZGZBVlVyVmpQWlRZTmYyRmNaVk5FZDBxZ3A3NEtk?=
 =?utf-8?B?ZVE2eFBOT1U4WkFibUpqdVFWWTEzcklIUW9SeG13STUrTWhwS01RVVFpNC8x?=
 =?utf-8?B?U0ZocEErS3hSY1doSzdUVkR0Y2hlQmFVVU1sWjZQMGpmekhBbEd0T2NhdFF2?=
 =?utf-8?B?NWJVOFAwMGtjeGorZ1QyVjEzbU0wMVFtWitERGxCbDJjd0QvbDFMeUx2N2ho?=
 =?utf-8?B?aEJFeU0zTUNFTzZWTDZQTWFWTi8yOFNieFpXa3FtK0U3QUVFU0JqTDA0YzUw?=
 =?utf-8?B?aVp4YmNSZkxsajIxZTFFNDREZzRvRzBSNHpJOEpkSVlDblFmU1pWN0U4ZEtN?=
 =?utf-8?B?WWt3SnlhNmhzY1JZZGswMVBqOTBhbEpTWkxqSUlEbDV4TDl3S3dTKzdueFh1?=
 =?utf-8?B?dldBeEZHTFQxTEtoM0VjMVVGK2JtVDBEcFJnVFFXV1pxSE9NYWcrakFKSk4w?=
 =?utf-8?B?dFRlVE1POHBEVVJXTE1NaGF4cXp5OXFENEtLby9lQjNEM0pTRTN1QVY4Q01Q?=
 =?utf-8?B?VnNSVXpGNjBKSnJXUEV5T1VwQkUydFRvL3pLRVNhRUs0MjRoSGJ3eW1ibGJu?=
 =?utf-8?B?RkZqc2lERkg5UURmYzc1YmtCREJPYm9rVU1PaUVWcXdyUkdpOW5aazZCcW5L?=
 =?utf-8?B?UWVBTDduYUFHOHNjUzNsN0NkeGI4VlNUdVYyTzRhenVyQXFOVHpOdVRQMVNW?=
 =?utf-8?B?NTJKRG5Tc1U0L09WTW5meUo3UCs5d0hOcG1lSXgvMnYrY2lWdlhuWjNJZE4v?=
 =?utf-8?B?UFZvenpUSGlmWXJ0SVhZanlNb3lWMVcyV1Z6a0RaZG5vd3cxM2d0ZkpVUnd2?=
 =?utf-8?B?NTdPYWV5TERWd0Z0Z3d0bjZMY0twVTkvZVluWlJoU2JpT0Z1b0Z5NTlyTmFO?=
 =?utf-8?B?ZGFoR1JGZ3ZmRG41clpIc2lnVGp6dFNyRUFxNjdwZnR3K0g2Y2s2VkkrcmhX?=
 =?utf-8?B?ZldLaG1VNXMwcGkwdmMvc2g1dHZSTFIvTE1ZaFBTR2hSN3FZbVBnWm5mMUR3?=
 =?utf-8?B?VmVXOEhsR0lINmx4aUZxSndzR0lvaEQ1Ti9zUnk3eXBIV2k5SXlLN0pOZGJX?=
 =?utf-8?B?K243NHhPVzRteXdsV0EvVWlWbTFITFVBZnVDdnQwV3dCQVVQWjVlNHE0MVdk?=
 =?utf-8?B?T0FENkxMVHBkTVVXZXU0a1F4UXNpejd2aCtpaUI0UHZQcFBOMnM1aE4xeEZz?=
 =?utf-8?B?SXlWeU5POVphZFptZUowZ2R2aExBYXFrQU9kMlM5ZlVMcUJYZHVqaXFHTmRt?=
 =?utf-8?B?V3gvSmpjRVBUT3VXNTRpY000TDlJYU9pNFZubWdMQlNFYjB1Z21EcFgyU250?=
 =?utf-8?Q?ULzUfldukBE+dY5ZmnhivfDuM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75da4ede-2768-4761-6eab-08dd500ef37a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8781.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:25:30.6545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdIgKHl9XLKmdKsl8QVNG4LxlgD7BHJ+1Om67rTj8eid9dnJXe6WkEahwMLYPzoILaV2oMEqknoa/3kMH/h+Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9383

On 2/17/2025 6:57 PM, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Correct the parent of the AUDIOMIX DSP and OCRAM_A clock gates by setting
> it to AUDIO_AXI_CLK_ROOT, instead of AUDIO_AHB_CLK_ROOT. Additionally, set
> the frequency of AUDIO_AXI_CLK_ROOT to 800MHz instead of the current
> 400MHz.
>
> Laurentiu Mihalcea (4):
>    dt-bindings: clock: imx8mp: add axi clock
>    clk: clk-imx8mp-audiomix: fix dsp/ocram_a clock parents
>    arm64: dts: imx8mp: add AUDIO_AXI_CLK_ROOT to AUDIOMIX block
>    arm64: dts: imx8mp: change AUDIO_AXI_CLK_ROOT freq. to 800MHz
>
>   .../devicetree/bindings/clock/imx8mp-audiomix.yaml     | 10 ++++++----
>   arch/arm64/boot/dts/freescale/imx8mp.dtsi              |  7 ++++---
>   drivers/clk/imx/clk-imx8mp-audiomix.c                  |  6 +++---
>   3 files changed, 13 insertions(+), 10 deletions(-)

For the series:
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Thanks,
Iulia


