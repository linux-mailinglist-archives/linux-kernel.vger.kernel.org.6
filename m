Return-Path: <linux-kernel+bounces-174412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DFA8C0E62
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6D9B22E19
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98FA131199;
	Thu,  9 May 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="FbrSYGo/"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2134.outbound.protection.outlook.com [40.107.13.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDD512FF88;
	Thu,  9 May 2024 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251581; cv=fail; b=mGBHedzdr1v7V9aIZ3QmFPlHgOrsS5oYzrzerVpVUsU9LhatzRdOFuoZJiH6J/5TpN8fsA+pqxEqWKyG5/Yc2WSL1ceOyrPaqQ03HxblJWXWZl42kd5T+XQMTMJvbJ3z7Ji8iQj7T6H+FbjLY0gtxdUUgK/5zPz+Ld8acea/CwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251581; c=relaxed/simple;
	bh=mQWroSb7kMnehyNzCCHX6s2dTYjFnSgTfg/7QjZ2uJY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=huaTL2BKvDdtrm0ppz3Zt6Rrhje6Y/qxoT8X/vas54RW/LxOIL6QuaYlE9y2UrBoWMjKXRK34dTgzsjB+vUz+rhRj63LrtftcvGwWJfYeS3snEieoKXEC0xJdQR0ejoRSZ6F5zPWZfOoE1IiBnAgxO5HmLKkHcV7v8b6OL+gcnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=FbrSYGo/; arc=fail smtp.client-ip=40.107.13.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nym2uaho1FLqOOrHnyBUAKBaNh1eHp5dbZ5VnTTynp5mExUIzjIhyvIj3YiBQg8tgZQ8Q6KDYRXzK756rVm3UVuMwOiTcomw59g6jDUjKEJiypkkChkvsfZp4KOdbHOqvt8EtclTQkne0BqCmn+VkZLvWt/+3nXC3BO48DVEzVZqxD5ZBYyf7ld0Es9zzsnkKiwhcKM1Q/E9h1ZdYj+W91h7RCf2s28Gvf5owfbT5UwUa/UG52vMONq4h6qY9j0+kv9wP/ZPqCHgSrwxMU8JA++k00fzSCa96lRahH4Wz8oI6c6yihKWvTfU13MABoXsNz7OnMOZ3+3QqscdxcpVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlQy4rBk6ixkdbPr4GAxyRHBN7NhXDroHp6p2aHDx64=;
 b=XxJX5md7Z6jGe/gtKs8bOcXZvPbaDLYk+4vMkIUD6FYjDbTtnMM5chX3/cwHdtSLgaY3nGHxuaNytfeMvb9N9UmJgAcTTZqYM+rNzgZbzwB08e7fi92M71+LFGW/GMWhLOYL42YGFtWjQwobyXeS0sXU2rbxnlV2V4zAkI1/RouGZAByQy5dqD9Xd5Z2t7dmAttCevj1EzP+sfF4WdemsEHwD8qkS4UukWuHPSuB28mSNWYFRslhOD9JZeavIdUNzTWjhNRSntLBEkXWD8gduyHdKxcn2Q6JcLPy5C3yva5OmTM04gPhzW4ETQH0jvTbY/wXs0C6WNUNSoytWuF/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlQy4rBk6ixkdbPr4GAxyRHBN7NhXDroHp6p2aHDx64=;
 b=FbrSYGo/YqUV7zyxsXOFPqjJtc3hQMyIp1hm0I7MdSfErsBohZtz7e6knKR5JK5Q+9fB4pfDBypnEh5tp372mmpx0mEgfLXmelLlftuMUWgnx2zjfmJxb3pNMDONOG9/ZGwVEjqS92cxJdNFi7hnvh5x2O+QRsc524rYjgaCWDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 10:46:11 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7544.045; Thu, 9 May 2024
 10:46:11 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 09 May 2024 12:46:06 +0200
Subject: [PATCH v5 2/4] dt-bindings: arm64: marvell: add solidrun cn9132
 CEX-7 evaluation board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-cn9130-som-v5-2-95493eb5c79d@solid-run.com>
References: <20240509-cn9130-som-v5-0-95493eb5c79d@solid-run.com>
In-Reply-To: <20240509-cn9130-som-v5-0-95493eb5c79d@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::13) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: f27a3384-8606-42c0-db78-08dc70153d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|7416005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3c3ZUxhSnVNcXRNRlUxaVNWNlZSTmtNblFNZkpHcHBpdXF5dmhxUVBWZTdy?=
 =?utf-8?B?RGpZSVl4S1B0Nit0c1JOcm5sYk03ZHhDNXFJeGZCZVdGbmxZb1dVdDc3eWwr?=
 =?utf-8?B?VW91bTQ1OEJwQVBUSWVsa1lLVUxobU1yQXNPeFJod1JQWnFKeTJzdjhpdlpm?=
 =?utf-8?B?dHg4MmJHb2NLUEVMK0QveTlreXNrMFQzeXdvYlhTdFJFWUR4ZWk4aGt2UkdC?=
 =?utf-8?B?VzF0RU90ZHZUa0ExeE1VbUhUR1RYOHJDUWlSa1ZyeXNqOUJweElnMXppS1ZS?=
 =?utf-8?B?V2FTUXBUcHpabko3U1p2Q1ZseURWRk04TWl2YU5EVy8ybVlmWVBOY3pGcDky?=
 =?utf-8?B?eXJFMUlpcWFtRXNvSXQ4bWQveXQvOFB2U0JkVnlwZmJPdEsvK0FmVDVBVmJt?=
 =?utf-8?B?TWVvZHJvNlo4VFBGT3NtNHIxZEdqMXJVVjhzRUg5YU5wUlNMaDBGQnkwNE51?=
 =?utf-8?B?WnVSdVZ2ZG1IamNnbHpObzA1Mnk2TnJ3bnQ4cTVCR3VKeTZVM3JUVFJlSy81?=
 =?utf-8?B?UUdBTmVBV3FWa0prYjN6TWppWXg0ck5RT2ZSUC9WWi91UVBRem9UZjNCSjM0?=
 =?utf-8?B?SDBnalZCdDlwSEZjT0VIVHJXSDNRVlhrczE4czRRdHRzcVBYcjVESUFrZXFF?=
 =?utf-8?B?d1libUtJNndMbnB3a3Q1bmVPVzBBSG52dy9IVXZwZ3pUaHFoMkgrL0dDK3FI?=
 =?utf-8?B?UzAwWXRIWmpzWTI5Tlo1dnhJNVJtTVVhUEhhOUZRSmpZbEl2THdEWU5oS1or?=
 =?utf-8?B?ZEVoU05PLytTQjBZZGhsMTNMOGpLTHVEVWNYejdHZkxrY1ltSlcvMnB1dS9U?=
 =?utf-8?B?WUJNVmp2RTIydmwvVERZbzV1aUtYTjlUSWRoUlV1MGVuV2hTL2tqSHNBRHhN?=
 =?utf-8?B?VWMyTFdSUlJjc0ZJVXFEMEVNRDN3c2pyQkh3M244V1dUdVlzV2swUWZHdXdO?=
 =?utf-8?B?Y09JazZsdSs2c21MbE5nZ3NGcU1tQ0ZPTzZndDhhL2tMMlMrelpYeHJSYit5?=
 =?utf-8?B?TkkxYTJseGFrMk8rUlpBczVldGZObGZvWnk5VUllMXFLL09WM282Tkt3em1P?=
 =?utf-8?B?L0xxSDRwR09aclRLOUZlN0d0K0E0VlN4NGNacVhkdmhaRk14K0cvWC9IeWRo?=
 =?utf-8?B?UjlocjdjclVHc0VsS3NWVXZyak05Z1pjKzhFSjhIZU1RTWw1YTFXd0JmZHZF?=
 =?utf-8?B?KzRic3J5Wm5lQ2s4dHVsSzgxYXNyVEtMNmw1RHBaRVZtWDJWcXkzbDFrZ0tE?=
 =?utf-8?B?SHhCenBLb2FSeUREUWUrY0NQWllVSVVBdzI3VUl0SFQ5Wm5udGRwczEzMVJi?=
 =?utf-8?B?a2NsRW9iOXZtUnZuM2IxRTM2MW0zTXBqUDhMSEdDZERSdEt2UzBGVTR0d1Bz?=
 =?utf-8?B?ZXFDMTFvWkcrWGFFYklzU2xNZ0dCL1o3QjhScmltakVPUU5zSWpzS1JUUWcw?=
 =?utf-8?B?ck1KVVJWSHV4TEtKUzNvcjI5V2VoNlBhSkFnT3JoNzIyV01yVGQ4bzNsaC9i?=
 =?utf-8?B?bjZwVmM2Vy9BVkR2QUJtcnB6M1RFRE1pSWhPWVA5K1NBZ1pwbnN6WFRpQW13?=
 =?utf-8?B?ZUlRb1l5TW10bXUyTU1CVHNBVDNjdm1WT2tjeDg3azBlUXdIOThTTFlUSVMz?=
 =?utf-8?B?SGZQZFM2RjFsZWpBdkJsbmNhMnpQWVBucXJJN1B5dGZLZVAwQnY2T0I4U3Ar?=
 =?utf-8?B?eVhyeGkzNjZHaTJ0eGd1M2EyVVRCNExlWHZTWHlra1RkTndreTdhMTZZRWZa?=
 =?utf-8?B?WDFsMVc1bXdKcCtPN0RRTFB0SlY0M2dIVXJsR2o3WHY4VGxTN2h1aC9ZeHgv?=
 =?utf-8?B?c1BrRmFxNTNLREJOZ2g0QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW55NG9KdE90VGF0WlAwbFJTRkg5aGtHUkQ3aVRKblN6QmZiWUR3QUgwN0Fq?=
 =?utf-8?B?VFRFWkhHNnd4T1FIeU84VTBoaS9qaHhDSXp6TWNoazYzb0JGN1Btc3UrbzEz?=
 =?utf-8?B?dkQzV2xRTWM1TW9HeFl4TUROckpPeHp2aDQySFhyU2JtdndydG8yWnJJS2ho?=
 =?utf-8?B?N1hELzVvUkMzQmRrZ2hKM2RFTityZzlXcHh3cm02ZlhuTm5rSXNJZUV2THRu?=
 =?utf-8?B?ZC9FczVuK3RrazFOQTZwNFludFR4RjVsclNtZiswdlI5aVZZN2lQV3ArVWtX?=
 =?utf-8?B?OUZnRDJDV3NqNHovS2lpM1JXbUZaa1Jna0xDamluUHdJaytBSGpZRGt6YmZ0?=
 =?utf-8?B?bUN4OE9sNGY2bVRjc09SQWxZS0VtbDBEeUlqeG1La1lHMk5TcnpRdGdOVXNj?=
 =?utf-8?B?ZlJWeGVtbXhWOFhRRFRhb2NPVG4zNjlERlhZYWk1TWVYNEpoNktJRVdYQ2xh?=
 =?utf-8?B?RHc1MmhQYUtSYU11V0lCMUJOVGRZTXJwTWhJRmhoOWd0SlBIcEgwWDMxZ0lq?=
 =?utf-8?B?aWhFRmIxUGR3anZ6SEFnZ1Nzd1Z5Z016ZDFCMkNiZDAwVU03VFlWYmpCaXJi?=
 =?utf-8?B?d0RCcUczRGVXTzdhM0FwQ3Q2ZkZaK3JuYzAzOW1OampzcXB2L1BoM1BCMldZ?=
 =?utf-8?B?dEZvNXFJL2pSL0puQTVXSU8vbERNZWhpNzBReW9SSEpQNFNiM2ZqOEVueC9F?=
 =?utf-8?B?RHNMWHRDZzFQUFhhbWVVaU5MZEs3T0ZoMStUSkE1RURKVk1HTEIycllxbnRH?=
 =?utf-8?B?Y3phc0JTTDNtYkg3SmRBdDRBekZhb2NlT1l1dGcwVUwvZHR1KzZVVHhha0VP?=
 =?utf-8?B?ajNnQ2YvYVY3U295YldDU1BESGxDK1lQNEFiUG1Wd1hPanZMZUxUaXRLS3RU?=
 =?utf-8?B?ODhXQm9QV2NDNzJkZGxWa2NqZ2hZSVBQSXMzTTgxdGk3MUFXcjkrL3dSeXVj?=
 =?utf-8?B?WVJVZ2tLMFFyMGQ1UGRGeWRCeEJIaVpoME1sK0wyQlBrQXkvRVVOVUZGRGtT?=
 =?utf-8?B?RyswaS9sMEhxYlk2K1RydHFubkFwVldFWGV1SmFUaUdybDNudHZ3RUp1S1NR?=
 =?utf-8?B?L2hsZjJuaW9rUE1IdUxwZC9iOUtlOEJRSjA0ODJBNVpUNTQ5a2lzR1dXakM3?=
 =?utf-8?B?TUErclAwcDZJRi9VZnVsMzc1RGRVQW1jeFNETUF5b0hOWTg4bWx5YldCTUVk?=
 =?utf-8?B?WmVtbmtZR0pkQzlXKzBlaEQvOUN0Z3V5Ny9Xb1ovV0hyTUhOYVBRdWZvZHNm?=
 =?utf-8?B?aG1scjZDbUgrNDZTbW95TjYxYXRWSWhFWnI2NW1ueEVyR3BVUEZxdWFOWWNS?=
 =?utf-8?B?WFRXWEJZQzVYcVBYWEpWcTRQd2dkclhrWGZCeU5rVkF6NmFzZW9Fb1MzZDFR?=
 =?utf-8?B?WE43elhLUmJET242anVYUHZjVFkxZHM1dUFHRHZmczM3UFpWa291ZlRDV24v?=
 =?utf-8?B?d2g3YXJGTTVvdHl1d1NGWVU5MlV4QzhUQ00vQ0VlZURSRm43YStNeUwrbGVa?=
 =?utf-8?B?R1BPcDlWRXQwbEpuRysvUVpNckQ2ZVB6RnJydXVieXBMcXlNdkd4bm0venIr?=
 =?utf-8?B?ckhJV1lzekpHa0FueDhDNWFid0IxME5RR1VUa3poYmlxYjE3d2oxREF5eG1p?=
 =?utf-8?B?aUhFR0FuM3VSeTk4NHRveFQ4M0JuUG1HS091TVR5b2dOSk5kaWdMUW9zNk1H?=
 =?utf-8?B?bjB6NXlvWEVRUnVWaEsxQWlhUDFzTDhXOHJRVHlPaDlmN3B4RkhvVE1yVHV4?=
 =?utf-8?B?MWhhNEVsVm5FY0N1WkJKS2lLWWh1bjM2TDJVeVJjeGpEL2JvSVVpNFhhMXhK?=
 =?utf-8?B?cG5oZE13cWlWYjBqK0Yvb3gvMnpRTnRNQ09YdDE1dzc4dmlkYlRUVGo0cFJR?=
 =?utf-8?B?R2ZrOUV4Y1ppaVBGTSt5ek14NFhqWWxqaVRKK3FIL3RkMXFaaU9VelorMXMy?=
 =?utf-8?B?Q0x0SFhiVFlGTllaM3d1UEtMZzBkNG0vTnhuTnJpYUsrbzRkQkRZbmtJbFpr?=
 =?utf-8?B?dFNpVUswazJ5bXFRU2d3ZFRPT0JSeWNHOG1USUpCUmJFWFNpeUx6ME85ZUty?=
 =?utf-8?B?aW9GcDhFd2lhZmhjanJkV3F6QkN1SXNGanJTNnlKMnRyZWZ4UlFHb3V0RWJl?=
 =?utf-8?Q?TWTjWTOXbYtF5YAYW+qMZs+oU?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27a3384-8606-42c0-db78-08dc70153d94
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 10:46:11.0486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmhCyQppXqf9i35M4j9VFOTLKinsdAEjfdB3lgRdZweOM9gpzDxSENIPFLuNWj5PZ/VFuxDw7tpnlcFe698wTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

Add bindings for the SolidRun CN9132 COM-Express Type 7 evaluation board.
The CEX is based on CN9130 SoC and includes two southbridges.

Because CN9132 and 9131 are just names for different designs around the
same SoC, no soc compatibles beside marvell,cn9130 are needed.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
index 74d935ea279c..538d91be8857 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
@@ -92,4 +92,12 @@ properties:
           - const: solidrun,cn9130-sr-som
           - const: marvell,cn9130
 
+      - description:
+          SolidRun CN9132 COM-Express Type 7 based single-board computers
+        items:
+          - enum:
+              - solidrun,cn9132-clearfog
+          - const: solidrun,cn9132-sr-cex7
+          - const: marvell,cn9130
+
 additionalProperties: true

-- 
2.35.3


