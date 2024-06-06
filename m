Return-Path: <linux-kernel+bounces-204912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 713B28FF4EB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90001F276EF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAC873468;
	Thu,  6 Jun 2024 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gMMpBZwS"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1520502B2;
	Thu,  6 Jun 2024 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699653; cv=fail; b=oKnsLtTvpw0rCf+rn0j5ugJCHb5525r8K6QCppZg45UzRMXp3HHqLbTjGvbqxGeCidzrqMibM0jCbmPfH1eY/ILYYNdheSF7OF47y8RtS6E/SYKeQnUwdycJNins4O+5e05n+4aIEJIF5OvlHyM1MOBLkYR3YvolBzb60gHutog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699653; c=relaxed/simple;
	bh=SUocZhLP81ANYJN86/fq6QRIzHiSvWBbXNaYPOaTcSw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Mb5CJAG3s+f73CBW3IxOkpqJs9pt+6sLtVXhctKZjb8yr+EiqhNBtfFGHib+LEE1DaLbBs+Bz6RR4h18DEFNhXTMhipYFAzhtr0LWWkW4/TdRTE7L/PyRQATjF7upCVwQcxJV/4mfA5gMMZC/cQnqOxE2gvUVcOUsCsajgjNk1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gMMpBZwS; arc=fail smtp.client-ip=40.107.21.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMumwUc6okFscvGOw/FQ8kzuaVCBMNm8ILVtlJcX9XjC5KooXyXpwl2vOiOJbeSj4PEEzViRykEUvZrMX8le8MFY+y8v0KkEf8vk1LoZSXGsKUdlbPGUY4d6Xv8DF9Yd2Q0Ie9o9dvz2gx9vv6SmNbLJUMUhVPpGIQxPEr3fUtUOEQdYhffd3UnfavQoOhwa8d/pC7cwr7LlNJRzxY2b/2wINQRfh/hk2u1UfXX9EPJY7kyleoACwUmsaXlOorMijQG5aiOseJW4FX0gUGeZBsmyzMNZYArGaN9QHpya0nIRAdnkYNpznP1dUpT9+elxYW7RAgx5CoeiLJPuwpV2Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ju9pL/yf82r3xO39ZfP2YCzLsAFbGQzwl6W58evDDs=;
 b=NjzAn3+O+gisNLOieV3RVxZslpL45+fldWdBPzqOKoPH57kLqGhLgvZmPR8w0VOzK1r4ayYWUWHWMbwTUnAKGymer1KTqpKJfrW1KHAglz9l1Ctg9PN53VzZ+TJpOXzD5XPk/8t6i29nP1CNQcvgTZkq3qntqjLyLl+Pd3pVCCeTKzEFtAD9XbGUJKbSpK4xmn0h2iPzr+1VZLNmeeCym4X4/tlkNY/mbKdu/Ogg1MpT+Dm4kDilr0o06wxyrGzY+wy9ATho9hzg/hcarMAPFVBejpZl34x8UXyOHbIPT9MJXsa6BAQozzzAhWWBBK/NY+mXmR53e9U9S+IZKJ6Arw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ju9pL/yf82r3xO39ZfP2YCzLsAFbGQzwl6W58evDDs=;
 b=gMMpBZwSVLmZ0O9tDEejOCvqYcgBZY56KxTYpQ5uqOemxrwRqV2qdFpfM5X9Kubrz7Yo1raFm8uHhmPB0KFY4ToV9A0v/lBnahTs2+dXelTFf49ADP33a1/mQ2LcPIbe9oOrQ9usZwbF5RVafNHh3WIbxoO/xx17qPIXKdFECyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB11069.eurprd04.prod.outlook.com (2603:10a6:800:266::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 18:47:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 18:47:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 06 Jun 2024 14:46:58 -0400
Subject: [PATCH 4/7] arm64: dts: imx8qm-mek: add pwm and i2c in lvds
 subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-imx8qm-dts-usb-v1-4-565721b64f25@nxp.com>
References: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
In-Reply-To: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717699632; l=3505;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=SUocZhLP81ANYJN86/fq6QRIzHiSvWBbXNaYPOaTcSw=;
 b=4vt3leCJZin5Gv204ys/BSq24tkLii/do+5RgjjzKTq/Ky0PqeHuKcga7K19cQPUM361i3YNl
 5Tm28/4tBUoDGBvQ57p1Wlsrvo2mLDLGsW9YhU6uqHHD4ayAPhgOH+p
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0178.namprd05.prod.outlook.com
 (2603:10b6:a03:339::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB11069:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbc3d44-ae86-4a79-349c-08dc86591d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SW1JQVBzaWpPcUJLYVdPVE9TclEzeGVMdXY5dk4ycW5hUk1VUzFIUUJWNHpF?=
 =?utf-8?B?d1l6S2EwWTE3V1k3QktUekVWVjRCZGo4cWI5aE5OQnpudEJibWIxSk5IOWhs?=
 =?utf-8?B?eFpONDZHK3kybWFGVVJ1NHhjNzdxRmtUQ0NwK1NtVGN4RU5KSWk1bElNaUZU?=
 =?utf-8?B?djVxUXBEUStIVlhaNmJaYTZIK3g3RGRGdVozblBNR3RsM29iaFNNdzVjek56?=
 =?utf-8?B?bkVQdjRuNmpWZ0pEL29HY1lVMXhXdjUzTjhEU04xa3FneGVpdnJFdGlhS2s2?=
 =?utf-8?B?N0xsd0xaVUZwZmw4aHovNmlmMUoxcXdZZGtGZ3ZNMHRxYlgyS3RJMkE3eFZ1?=
 =?utf-8?B?NG85YVhnWTZSOTF5ZzVFeUZUN2R5UlNKWnhWbC9icFVNT3BTYkFycE1oazMy?=
 =?utf-8?B?RkJSNGpvNUlma1JLWkp5UDBxSWhoaG5RU2RkZDFPNWVubzM1OXdDZmU1OXdq?=
 =?utf-8?B?UXdUc1dkaG9yYURQSVFMNUlKc0g5b0xQVFZjUy9ScFNHNGpZeW9CS0x4czJt?=
 =?utf-8?B?ZHdpQ0NCcVdtMEdvazBnRi9VWUNMdUJzd3lqVFBiOTgyWEdBc3RwVEdibnVK?=
 =?utf-8?B?S1lvbXhFUzY0TzlPRS9CM0ZzY2RibUppUElVcUVPSnk0T00yeW83OExpWGVt?=
 =?utf-8?B?VllveDlSVi9GbS9zODlyY3dGS29lWDc0WGlXQ09NWU9CNXA1QVpZdHJQTGVi?=
 =?utf-8?B?WGlGNzJaTzlKczRmdlZkVUZOMlpNTmwwUDE5Y2xvWkxVQ242dGtNSEk0TWJP?=
 =?utf-8?B?Wml2bWQ5V29ZREJVQXZpMkd6cEJiaThyN0c3c0pYTFdBRzRpQ3FDSnZiYWZk?=
 =?utf-8?B?ejNjYU5xUXZKUUsrZXVFMmR3aWhpbDBucW1wekZTb3FqdzBhYjIyR0ZJR1lS?=
 =?utf-8?B?cFlyUEYyaEtvcGV2YlZkVlcvYzNTbFBHZ2hsVzBDTEtxNTQ5RFhUS1JhZExr?=
 =?utf-8?B?RnJBYnBwTmVsWms2eWdhUy82MFhZR0FIaGI2dEZCbldCWVdPcEdDQUd4OFBt?=
 =?utf-8?B?cWo3YnA4bWxXMTFVbGgrYTNhemM5RE5XWDRBTGIrWVJLcXRDZVlWalA4TXhl?=
 =?utf-8?B?UG5pb2s1NklpbS9iU1hOVmdaZGh3RC9hMjBHVGhjWmE2b1FGbHRJM2N2R2lx?=
 =?utf-8?B?d2JRNGQ5WlphWmlCMkRnR2lhUTE2MzQ3bytIbFc5Zno3QkhOV1ZXYlZKY0h1?=
 =?utf-8?B?dkhlTFArbSsrZW9MbmVwUk1sdEhHdFRXWlgyVndSckJSTDB3Y3o3QmxGWU1W?=
 =?utf-8?B?d05aSGRqS0s3c1J6MXM5UDJjM1dRVG13aGEvZ1ZpZkp2dDBudENabytnaVph?=
 =?utf-8?B?U0t5VGhERSsrN29Hbzh0SGpVV0lnK2hnTC83OHRHQ2xEUEVMTWhRcGR6eXlh?=
 =?utf-8?B?SEo0OElsZ29BTXFJLzlhWmphSC9DUnZXK1ZIRHVVdTB5clNVckFFcmZWSUs4?=
 =?utf-8?B?S2NEUVFtRVo5VjFySWplQUI0Yk1MakJXRHFGcW0yZnorTHBseTNha2dta21j?=
 =?utf-8?B?T2U1TjNxa21yNVlYc3NnYUxrYnpOTk5LbTFIdjJKUUZnMUNxQ3NuWXpZQzJl?=
 =?utf-8?B?QTMxKzFFcUJlT0h1ay9lZ1Bad2hLTW02WTJPTTBNV3lMTEEvdi9NSUNYT3BM?=
 =?utf-8?B?V1AwbkNLYi9McHcvSGh3Si82blM3eG9JM3ZrRWV1cnc3V1FobUxIY3NvRXNi?=
 =?utf-8?B?Y2loajBBc05xWittTTlFMGF3MTVqZlJLVS9SRTRILzI1UFh5RnF1TWFkSndK?=
 =?utf-8?B?ZUlsWmRmb1BxZWtJNjdPdFFqTDZNaUFCdkJnejU2dTErSUNHSldaL0M4S1o0?=
 =?utf-8?Q?9qvuXRS7Bpa4t3HcjPQl9o9iPPccSG2a8VANA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWN3QlVrZXYyUTUrSXZPM2kwZ2E3dThTZzZ4WFFYR3NrWnYxN0ozVjNRU0pS?=
 =?utf-8?B?amZWYkgycjY5M2FOL3BlVkxsYVZDTTdvdXc0UzhJQXUwN2RDWG42OCtEMUg2?=
 =?utf-8?B?NFh5WiszTmgyYnJxTDQrcDZjUk5MQkFGZ0VvdC9qL0ZMSkVIS2xidEsrSHgz?=
 =?utf-8?B?ZTduVUJBaTJhQy95UzNCVG4ybzBIT1JBVEVPWHY3Zi9td0FXSDMxYk0vYm8v?=
 =?utf-8?B?UDNkcVNjNFUzMVhlWXRJUzJFQ0VoU1JhOTEwMUI1bDVKS2tpNkx2UnIzc0pL?=
 =?utf-8?B?VVZrRW1wNGJ3TXFiT1VyOTdwVUhnQ29tSWc3bDhPakR0Y1FXbzBVS2tDSWpq?=
 =?utf-8?B?dWN4WFIwekg1MUhhRGhvaTRWZ3ZlZ2J0TVZHUDFyb3FuVVhXdHNrSWRjaDdI?=
 =?utf-8?B?d2lHNFo4SHh0c3J6U1hYY2JWVWlqTWdzdzdaaXdRdmFZN2Y2OThLZVZ0MmRI?=
 =?utf-8?B?MzcwTHlrdW8xYUtRRFgrOElIQkhITUpWdnJGN1hYNW5JUE5KN3BJdWkyMVRo?=
 =?utf-8?B?VmxsdTgxZXZFd3RESlo4NDZ6TUlhYm9reGNkalJPMFpCTVBNTkEzL0lJSzZH?=
 =?utf-8?B?enBkTkIrTFY4UmpsVFM5ZWdDT3BabVNBb01MejQva1BxNVU5YmxtMVdSVDNO?=
 =?utf-8?B?VTZkUWI4ZE1iTXpsVWNTMTBQMHNibWkvWmxEenl0TzEvaHJCVGZUb25oZ2VD?=
 =?utf-8?B?Nm02NUUyVk1EUXVwRXNtR294cS9TMWh5K3JrTVNwK3B3aDd2NmRPcmNkTEVl?=
 =?utf-8?B?ZExkYmlldU9MaXNRMFF6MVpNTmtyZWthbWJCTkhkeERUWHYvdkEzNW9KQjV0?=
 =?utf-8?B?akdVc2ZncEpJWHJuUWRUeTlUWUFaZGFuVXhOdnYxa2JMMlFvdjVBWTFmejgw?=
 =?utf-8?B?aElaTGxDTnlBem5Tc0luaFU0eFVoL0NZdk9hMU1GcFByZU90dlVVc1lVMTJz?=
 =?utf-8?B?ck9PUHM5bzJnT2JRS0xOUWFReTNzaE9XUUpUdDQ1c21KRVMzWW0xTEJGc2cx?=
 =?utf-8?B?bGVNZ2Fya3pscFh6ejczdUtBaHJocTNIOFNUd0g4UEl4Ukh6ZUNEK3QzVWZl?=
 =?utf-8?B?eWx1OEFYQjNaZVIrTFp1eFk1NDhsekdsUXlOMk84c1VzOXpVQkc2bkpBVVFS?=
 =?utf-8?B?dUVMb2xzdmNhNjU2bTNDRHN3OWoyL3B3Q0d2TWtudlB4R014dlFGNXZTRk9u?=
 =?utf-8?B?MmdmVFk0VVgxdzBEaHl0b1pWbm9IcHdOZFpRaDVVTVgzcVcvYWVGRlRvbzBU?=
 =?utf-8?B?Sll5WXcxRlRNNzhFcFFKQUVBSWgwZktsTVZoaVlwUmlBdjBPby9BaXErTW1y?=
 =?utf-8?B?L0E0SHViYXdzZFpMd2lJcDJWTDFUVm5GOWNLZWtMQm4wY1V2ZUd2K1ltazg2?=
 =?utf-8?B?ZXZ1R3hRQktDdXRabkQvaXM2ZnJDSFB5c2NKUmJZNmM2V2JsY3ZsTDU3RDQw?=
 =?utf-8?B?cHlIUWIvVW96SytGM1ozd1NDODcwd2pyYllkc2J4Ri9ES1Npd0xRSHFRc2NX?=
 =?utf-8?B?WGVjS1Rtejk3NGV6QXZ5cDB6bTNqeG1UaythL1lPZjBURm9zWXRJWE9XS2lk?=
 =?utf-8?B?bHY2ZEk0a1RjeEZyWTZIMkRsWFE4QkxSZTZFblJHMDVTWEZGSzc0SzY0Q0tG?=
 =?utf-8?B?a1E0SVdmK0VPOGRWK2lTd0l4ZDVKTmZuMTRCWTBVSkorQkY4QWdQR3RhbVFo?=
 =?utf-8?B?OWVUU1NIelhZRHJnVnlMbUhRSzRmbjRiaXUwL2htamE0UEZEVXdpTERkUlhH?=
 =?utf-8?B?WlQ4NTFWcTdXMitFdXNLT09Ya2p6aVVFZmZhWCtTdDVkRVdqZW9FTDhzMXEw?=
 =?utf-8?B?ayt0ZW1uRHl1dnNwbzAzdG1IaVgxUmFiM2tZcU5LakNtS0pIQXRrNGJiNzFY?=
 =?utf-8?B?OVVtcnNKdFVsUUxvcGhTUnZ3VDI4SU5BdHhoeTR1Si9HMUx2OFRtMkg2S0Ni?=
 =?utf-8?B?cEdyMlg2MHorbnNwQ29iQkJWdXZRRExQclhGNkxJWTJUL1pIMWJ3b3p6bTBG?=
 =?utf-8?B?aGY4c2dWYk42bGJwc0h5SDRWNzhtUFpVV2tLUTJpR2Iwa1NuT3Z1V1drRzFI?=
 =?utf-8?B?VlZKV09TZjZ0citsNGtXTkx2b0pGRWhmc0ZyVWJSVDFwV3A4NzBFdGpvL1hT?=
 =?utf-8?Q?x5JoyJyxe/ONy2dDKv46+bMp0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbc3d44-ae86-4a79-349c-08dc86591d8f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 18:47:28.6755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARwi8LBIeiYmZ20+T3Z5qX80z8eK69UxJKQLstq/oMyYmBeQBanC6a9JvW6Mcj7XLlD3G2IBWR5xhuIlH+b8rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11069

Add pwm[0,1] and i2c[0,1] in lvds subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 92 ++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index dbd478af2e474..80cb834d56bc2 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -93,6 +93,42 @@ rsc_table1: memory@901ff000 {
 		};
 	};
 
+	lvds_backlight0: backlight-lvds0 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm_lvds0 0 100000 0>;
+
+		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
+				     10 11 12 13 14 15 16 17 18 19
+				     20 21 22 23 24 25 26 27 28 29
+				     30 31 32 33 34 35 36 37 38 39
+				     40 41 42 43 44 45 46 47 48 49
+				     50 51 52 53 54 55 56 57 58 59
+				     60 61 62 63 64 65 66 67 68 69
+				     70 71 72 73 74 75 76 77 78 79
+				     80 81 82 83 84 85 86 87 88 89
+				     90 91 92 93 94 95 96 97 98 99
+				    100>;
+		default-brightness-level = <80>;
+	};
+
+	lvds_backlight1: backlight-lvds1 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm_lvds1 0 100000 0>;
+
+		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
+				     10 11 12 13 14 15 16 17 18 19
+				     20 21 22 23 24 25 26 27 28 29
+				     30 31 32 33 34 35 36 37 38 39
+				     40 41 42 43 44 45 46 47 48 49
+				     50 51 52 53 54 55 56 57 58 59
+				     60 61 62 63 64 65 66 67 68 69
+				     70 71 72 73 74 75 76 77 78 79
+				     80 81 82 83 84 85 86 87 88 89
+				     90 91 92 93 94 95 96 97 98 99
+				    100>;
+		default-brightness-level = <80>;
+	};
+
 	reg_usdhc2_vmmc: usdhc2-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "SD1_SPWR";
@@ -334,6 +370,24 @@ wm8960: audio-codec@1a {
 	};
 };
 
+&i2c1_lvds0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lvds0_lpi2c1>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&i2c1_lvds1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lvds1_lpi2c1>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
 &flexcan1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan1>;
@@ -449,6 +503,18 @@ &fec2 {
 	status = "okay";
 };
 
+&pwm_lvds0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_lvds0>;
+	status = "okay";
+};
+
+&pwm_lvds1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_lvds1>;
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -675,6 +741,32 @@ IMX8QM_M41_GPIO0_01_DMA_UART3_TX			0x06000020
 		>;
 	};
 
+	pinctrl_lvds0_lpi2c1: lvds0lpi2c1grp {
+		fsl,pins = <
+			IMX8QM_LVDS0_I2C1_SCL_LVDS0_I2C1_SCL	0xc600004c
+			IMX8QM_LVDS0_I2C1_SDA_LVDS0_I2C1_SDA	0xc600004c
+		>;
+	};
+
+	pinctrl_lvds1_lpi2c1: lvds1lpi2c1grp {
+		fsl,pins = <
+			IMX8QM_LVDS1_I2C1_SCL_LVDS1_I2C1_SCL	0xc600004c
+			IMX8QM_LVDS1_I2C1_SDA_LVDS1_I2C1_SDA	0xc600004c
+		>;
+	};
+
+	pinctrl_pwm_lvds0: pwmlvds0grp {
+		fsl,pins = <
+			IMX8QM_LVDS0_GPIO00_LVDS0_PWM0_OUT		0x00000020
+		>;
+	};
+
+	pinctrl_pwm_lvds1: pwmlvds1grp {
+		fsl,pins = <
+			IMX8QM_LVDS1_GPIO00_LVDS1_PWM0_OUT		0x00000020
+		>;
+	};
+
 	pinctrl_sai0: sai0grp {
 		fsl,pins = <
 			IMX8QM_SPI0_CS1_AUD_SAI0_TXC				0x0600004c

-- 
2.34.1


