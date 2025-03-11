Return-Path: <linux-kernel+bounces-556762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B015A5CE28
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C53719C11FA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73A0263F23;
	Tue, 11 Mar 2025 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="eKbeCi5p"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012025.outbound.protection.outlook.com [52.101.71.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB46B262D0B;
	Tue, 11 Mar 2025 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718759; cv=fail; b=TovduzsYs5vAgGh6Hbxvz95hSK/wlapCms2GweJKnI/oRbrUAKlJsYo6mQGaK87HbBnsAN7tdzWWb3B8dWo1ZAA0VDESYfmRCdHJwGYpAth0itwyR8xT4LTJHC/q2XNgnR5t/8Y+FmPvAD/y/3vL4kDVgx0sUhEP1f2j0kNAwLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718759; c=relaxed/simple;
	bh=adfwccVGisREiNKcTNX/4tY2jHyxgpITGdgyybx11JM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BODmxShUehZDbgMIxqvUX5I2j0os1Rj9YMOHIf8ychna5iLgCi818G6hC70ZyquDOqGX3kHFEf+655TkxwbFUrdbc6xj2wmoyfgwcX2WttPh1SvDHW+5/Q8AYtTKZobTEwdIFEIexBdoXfwYuh5FzsyzUk6QKSInZJrYGULQWAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=eKbeCi5p; arc=fail smtp.client-ip=52.101.71.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9RpN4jjVct/mYJY7NZzqgpE6RuzLYdoV7fcPk0YO6a0ef26g4zIQ79OIPesFm2KY/0p+0s6AXaaS1SJSzXIAM5iqQzCkrxQJ7Qw68d02Z950lmJVPu2NGnfejo5STmwn9iEfWm7C4/KdSCZM09XjLAzyHT7MWR3oKZB0gDx6fD46VARkHAM95MwZAiK3p6CbLCFH4jqKS8nNSoVKldGiG7lrSu07Vxmw2qiJFW4LnCovjaPjVQcGokdXeXXUbEhU8DEwFRY3H8ge6E9e/Q26XSR4MJ/WCm4rLz/o2SUtbkQTzzrkBBU2mvvADFvbQp5ZwytJt1UBNeUhCu9QWx5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adfwccVGisREiNKcTNX/4tY2jHyxgpITGdgyybx11JM=;
 b=jsFIhmdNiK4fRsXLrKX05mygqku3B6C12bBNvNzQN4Y2BKrdDDRp3wJZyqVKk69tebcYTcplkn0HeV7kn+SjWQwdLcrMCwk7N4UA+mY4TiVNKS/4u2j53EUkDt//CyOPHP/MLvKwUrYrfEQOY3BRs05ZsVERkA2BW2eCjGqzMi3g89f7LvMF+TFaknQ0vePRdfO1C8QyCf9pnZRw8t6JQI3lZ5jK22w6QSLro1rL2pQ/B8eo1zf5QzhswHnMOJEoe9PVz0OHsXiJ6CSah8RZQPSvm84U9Q+bfPE3ALWj6IRevDKe8NrziIb/8b/PBBkv5Si0AzTzoNut6lEBipIvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adfwccVGisREiNKcTNX/4tY2jHyxgpITGdgyybx11JM=;
 b=eKbeCi5pM+IjxL5G4ZKjj5DH7sQHVN28CfpJMB0nkZLX+KK9arTzrqCN54IRop6PVBKTqci4hnshFLq4c7J4tBYPp9n+2Xeqj+GxN+0pA9Nj1NYzl2ZlYE/bL9qnCNys52jWWL5XEbXRhezmJTaz7tL7XoR5o8DzVZeWe9pNz7f0oL9+/oR5A8nMV+JasMhO8xYwqJCVzsOSPkQwtooJjSpI5lrV6X0Cd3RZoRKhnj1S4ZJxG+i20cOEbLWVjW4p2uW6c+dUcaN2SoXyQmNcj2uhRnREwuOXQn2cRekkIWAXK/1NWfqCXBJ3/e33Z+hplrfv9e5Eg1zmN5uDFvhY5Q==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB9PR10MB5642.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 18:45:54 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 18:45:53 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "robh@kernel.org" <robh@kernel.org>
CC: "saravanak@google.com" <saravanak@google.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] of/irq: Refuse to of_irq_parse_one() more than one IRQ if
 #interrupt-cells = <0>
Thread-Topic: [PATCH] of/irq: Refuse to of_irq_parse_one() more than one IRQ
 if #interrupt-cells = <0>
Thread-Index: AQHbj2hMNgJEH6lYNE+F+m2Mpyhyh7NuPsAAgAAOEAA=
Date: Tue, 11 Mar 2025 18:45:53 +0000
Message-ID: <8bac8f2826f38f1d8f051c85c779482b47f4a388.camel@siemens.com>
References: <20250307135231.4080272-1-alexander.sverdlin@siemens.com>
	 <20250311175532.GA3869198-robh@kernel.org>
In-Reply-To: <20250311175532.GA3869198-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB9PR10MB5642:EE_
x-ms-office365-filtering-correlation-id: ce80c03d-f2d3-4e35-1616-08dd60ccf3de
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OU9rcDFUa1NabklpYTE0VHd3UHB3WWpwSkN0TWxxa2NsbnFCZmZHcW5WM3V6?=
 =?utf-8?B?TlZ0bk1Kd0JYL3JzQTV4Y3hMMVE0Y09ucVhNYkVEd01jdGhXSVdYYU5Td0NH?=
 =?utf-8?B?ZzVHOXBoaXNuQ3N5aUJ5cno0Zm5McEtlbkJxMkhjcFdDRXBtOCs5MEFwSkEz?=
 =?utf-8?B?ODR3ZlRtYm1BL213aHM0SVVYcVZYM2ErNWJ1UE4wU2h0a0JuMEhhR2I5Rndl?=
 =?utf-8?B?akQzb2dhZjZzQ0l1U3FGUTJYWjdDTzVjcnVFYjhFaGQ1OVNuOGhpc2hpeWpX?=
 =?utf-8?B?bFhlbUNqbTNTN2praGdLRHZnZGlGSmF1bzg0TjFQVDljRVdncG1OVHRWV3c2?=
 =?utf-8?B?UnpjR0JXbmhSZ3FxK0tiN3l3T2p3ZXNEcUlsd0NDcGZvOVFucGRjQ1YyYnZh?=
 =?utf-8?B?SEJHWXV5Yzc3M3h3YnBBWHVWZndoOWp6YnJaWm5GU1ozd0hkTnBGcENXSU5O?=
 =?utf-8?B?TGdJd2JPdC83Z3paQk9MSzUwWHlhY2VDMnNFVklUSWFVdXZJVXdWNHRTVXZV?=
 =?utf-8?B?MDNySVVuMzkwZGpaWmh4MERZeWtLRy9Bc25RRTVsMkNDVjNWQUN1cVpva3lP?=
 =?utf-8?B?UitRb3JLQlNwK3QrNkVpQk9IQmczTVNUeVBuQ1ltS09jNWxZZlZqdTRwYVJG?=
 =?utf-8?B?d2dKM2VKZmxtbG5WMkh0N1NBRWxtMXZZQjZPQkVRU2JDak9xVVBFbi82NmhG?=
 =?utf-8?B?VDgwYWhFVHFjRFgxOGIxcVFKNFNkVElrNFoxczhyWWx6dS92QURpWXo3NnlM?=
 =?utf-8?B?a0JIV1JrY1h2SFpoWEswMXhRUkNwb2RVS3o3WEsweHRjcFJXbS9tNzZ3UWl1?=
 =?utf-8?B?VG5yaXBicmI4OWJWVDRySXVNL3h5Y1NjK2xPQVhncStjeWsxT2xrR0VJRVNj?=
 =?utf-8?B?RThGM2xudE1OS2M4SStreDdjTHE0Vk9mT2sxTUt0U0owWStGRWQvMWJPUVhp?=
 =?utf-8?B?d1lHU25yQS9Cd0VoSzRIWjk4V0d5YWF4Y2d4TVVvNlZKbWFWUHB5QThPQk1R?=
 =?utf-8?B?N01UV1JZQUhkaWNOYmJGTFJVRE5pMU1iYTVPdEd4U2xzMWlISTBndmNwUWFt?=
 =?utf-8?B?QXRDdGVyY2YzZ0JnWUVlR0dRQ2l1V01ZT00vRXZiWk5VWE1BaU5FMXUvd2lT?=
 =?utf-8?B?ZmlBTVRrOWdhV3V2dmt0N1BZVjBqN1oycUdYS1FnT2lJVDJ1RFoxTGxEYWRG?=
 =?utf-8?B?UEI3czU2UUdsWEFDMDVPcHFWbThvR1h5VllFTWI3clBjcXhFRjFPa1ZIU2dJ?=
 =?utf-8?B?M0o1QnBVemV6OTdKV01WbTE2aGRwVEVZTEVsNEttU1l1NlI1Wnl6ZFB4dGFh?=
 =?utf-8?B?MDA3cm9uRm85ZktoWTNIYjdXUzlpaVo3bGxKT0l6M0lPYnNMRGQ2a3QwekdS?=
 =?utf-8?B?NCtYMkpMd3RvOWswY3JVNXluVmZUNldhclVYVFU4RW5lbmJETGg4RTYzaFRH?=
 =?utf-8?B?T0xOaFRzN25rR2FUckR2d0V3T1F5bm91U29HR3dWRUlBamxxd0x4Vk9kQ3E1?=
 =?utf-8?B?c3oySEg2TmkrMHAxTWhxOU1yNjZLZGk5K0R5RzR1cWNGc1FjTk5aMEhPVXpK?=
 =?utf-8?B?SjVaNkthMzA1c0h4NWE1Vm40L3owVWlHcGhoT2VUVi94VGg2cHZPU21YeWFi?=
 =?utf-8?B?RHV5SXQ4ZWJMME56MHRUa0FvbEN4clhIbzRPcnlaZG1NdmJkM0tmM0xRTWk1?=
 =?utf-8?B?UUcza1RMNzRkSklSdjRtWkROVHI5Nnc5UlBvK0wxTFJGVDMrbkRyQWt1UTJX?=
 =?utf-8?B?UExHRG9MbTlSb1lXb1cweGVpL29wbWFkZTBhT1dZb0JNditWU1J4SHlFWmph?=
 =?utf-8?B?SndJc3daUW9sb0tPb3FsUks4c29iMW1jOHVHVG04amFIWmtTbzc1VmhkVVhO?=
 =?utf-8?Q?A8+SrzRNTrPDt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEZzSGlMR1ZybVdIaVBnZXl0c3RaS1VjUkdzVzU0VndOZzJ5YTBBTzJDYXJP?=
 =?utf-8?B?amhCSVpseVlDWFZuV0s0WVlzUzFXSk9LMUFLLzkvNUcwTyszYWxvblIrRnJu?=
 =?utf-8?B?aGh4ZTdWM3ByK25nQ21mbXdrSUF3UzZxNUJmQlZKaE9EQXU5U2YvQjdBQWZE?=
 =?utf-8?B?VC9VdncrajBwOFh4YjR1b282QWZuSFpEUnQybkVydzMyOVNQcWZrZkYxbnNs?=
 =?utf-8?B?c3hEeXFPZ0NBOThQQlZGcG05dk5UWTdwdWRSRjRuM0Jra1B6bWN4RnZyVGVh?=
 =?utf-8?B?OHdKV2p5RVhPNUw3VXlwQjA1WUMwZ2x0WS8ycFU2aXFrOHdLL1cxcGQxRUxx?=
 =?utf-8?B?Um1pU2tzUmVSTzkwWkVxT2N5QTI4YXBkTExlclNwTms0QjFHdzE3L0ttazFC?=
 =?utf-8?B?di9oNFpvaTlieS9lU1grNmZZRjlwQURQNGQyTHJ0YWdUY0lKK2RheEtMa3Mv?=
 =?utf-8?B?cWRsT0E3bW5iRTlyWkJYd2ZoN1lFdHQ3VTdGcjZDNVg2bHpOZ1djU0xUUHpq?=
 =?utf-8?B?RjBMSGY1enRJYS9kTUpKRG5OOHV0dEFuMkF1clMzU1drdm9hOS9SVmVXalUy?=
 =?utf-8?B?d28rOWhjSGord0FVSTZmMmFrcTdlSUxPbjVrUHFNWDR6anJyL3RrQjA2SUYr?=
 =?utf-8?B?c2ZQYlhoN1ljZzNrTFZSWTZtd1FVYnZnVHJWeTM5b1N4dE9FRkk1aGJSc2Np?=
 =?utf-8?B?RXpJYWxjWlA4OFlmY2VkN2Q4cVZ3RnpHUGdmcCtJQkpwczQ3bUM1VUlKVE5n?=
 =?utf-8?B?ZU5XSG93SGsyT1JGWmFGVEQxYU9FTTV2TklZeDlKb0xuRlc0czFnTWovVXFw?=
 =?utf-8?B?L0QzMmVtUlJzOS80MFN6UGF0OXU3N05oZEJHRVRVbTlRR1lHUnVlaFVEZytn?=
 =?utf-8?B?dWZQTGhsSEk1cGdhNTA0MnpMbnp3bzRzS2gxc2FtUXN5bXMvQ2Q5UjlENHgz?=
 =?utf-8?B?ajNWMW1QU1N4SEEvSGUwWnFSUkV5eVVJQStXcXZHc3BML1ZtWldha3JFcUkr?=
 =?utf-8?B?eHBhK0FoM05YWWRjUFJtaWR2YktVK050UXJoQnl6OGVCU3JGeDVzc1Q3TWpl?=
 =?utf-8?B?M25KK0dhVm9Nd2FubDUza2NEQ3FMRUQ2NlRRTURnQ2ZJbkxHS0RBSlIxRVBQ?=
 =?utf-8?B?K2xlYzFsZk1vSWo3U0MxQkdaNnVNcndYV2s2SWIxeERXSGl0cVM4NUJNankr?=
 =?utf-8?B?NmpNY1NPOEx1Wm45NVdSTjZreG91bnBkbm5aYlBIKzJpNEJMYTdzYmJDTUN2?=
 =?utf-8?B?WjlyUUpxMzVoVkg3amt6dWx5NFV3SWZ6c1BrbUhlUi9HcXdTSVN6QWJnbXZi?=
 =?utf-8?B?SE56dVpJeEdNbXczTTBGcHZOSmlhQ2IwUTBHY0xVZjlOSm44Uk1PZXBXS0VG?=
 =?utf-8?B?eHVWeFp0bGhKbWV2RGRUTHYzNnRsTGtrMkZEeVQvcGhldEdFcFVDL0pZZlpN?=
 =?utf-8?B?bDIwaHkwMlpsa3VRaUJPdTNBWDVVZnJkMmplU3JrSVRZV1U0aFZrK09uYklm?=
 =?utf-8?B?Q1kwMnhsTnBkRWpBZ0VNSDFubEdPdXVhRE42b2RxeThCOWdNMFo0Q0Frc1R6?=
 =?utf-8?B?NkF1MFdjQXlTa2djSWpGQmlCSVFBYURTTXc1ZHRtSCsxNlFwZnhSUzZyTXlY?=
 =?utf-8?B?TE5PZ0trNXBpREV2Sm9FakhNZzhhR1A4Q2ZmaC9sdE5reHdTSDFLeDlQbTFG?=
 =?utf-8?B?WEJ1UEw0VXVoRHZJVmtGbDNlU08vVEdnK3liUVFvWVppRnk0Tmd1bXdEUVEx?=
 =?utf-8?B?OGNsMDcxSGphblNvWlZQN3JMcVpWOTlxa0JCc1BvSU9QdjBVMFFRNUNjaEtJ?=
 =?utf-8?B?Skw2RDhRaC9sQUpTZ3FZRmRRNHA2bkpHdjZQbWFZZFpzWmMycDVBNG1xYVo3?=
 =?utf-8?B?VEh3Y3RPNmcyQlJ6M0JIK1QrbkYzT3pTWWE0WWRoclU5Q2poRWJELzkvVXRN?=
 =?utf-8?B?Vm4rRmJvMWIxSG9YcTZMTW1RZitHbm1uaFZsb1hWdGE3bXNQUWNxNUsyWEFZ?=
 =?utf-8?B?RjlEYWlISkdZZlg3d1drOU1jdWZjcWNFNVErRTdPMkp6NEh4T0F3d0hxZGlO?=
 =?utf-8?B?Y0xEVGp2U3BpUFZMeFpmK0dCekMzV0prb2ZnN01sTGt3dEZMSnRPLzRqU3Jl?=
 =?utf-8?B?RjFIYVhpWGxISytxYjEreDNMdTFaU3NXTjRCdDZObmlVRWdRNjZEQTFRc0tZ?=
 =?utf-8?Q?H/A+zH0gnl7O3ijUFxjNzos=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B433A5924FFBA449C66EB14C6A380EA@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ce80c03d-f2d3-4e35-1616-08dd60ccf3de
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 18:45:53.7102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UeF9tiGxiO1uGasIEY64s5GOArWTN7RbBJ32KCRDSGlpReHVOB1236COmZJhaKlMODTB3h4a9EnvIujf85j+M0Ws6PND6mVnL1hnt2pjUEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5642

SGkgUm9iIQ0KDQpPbiBUdWUsIDIwMjUtMDMtMTEgYXQgMTI6NTUgLTA1MDAsIFJvYiBIZXJyaW5n
IHdyb3RlOg0KPiA+IEFuICNpbnRlcnJ1cHQtY2VsbHMgPSA8MD4gcHJvcGVydHkgbWF5IGFyZ3Vh
Ymx5IGJlIGEgcmlnaHQgYW5zd2VyIGZvciBhbg0KPiA+IGludGVycnVwdCBjb250cm9sbGVyIGhh
dmluZyBqdXN0IG9uZSBpbnRlcnJ1cHQgYW5kIG5vIG9wdGlvbnMgdG8gY29uZmlndXJlLg0KPiA+
IFRoZXJlIGFyZSBhbnl3YXkgYWxyZWFkeSBleGlzdGluZyBleGFtcGxlcyBpbiB0aGUgdHJlZSwg
Ym90aCBpbiBEVHMgYW5kIGluDQo+ID4gdGhlIGJpbmRpbmdzLg0KPiANCj4gVGhlIGV4aXN0aW5n
IGV4YW1wbGVzIGFyZSBicm9rZW4gYW5kIGhhY2tzIHRvIHRha2UgYWR2YW50YWdlIG9mIExpbnV4
IA0KPiBpbXBsZW1lbnRhdGlvbiBkZXRhaWxzIChJUlFDSElQX0RFQ0xBUkUoKSkuDQo+IA0KPiBB
bmQgI2ludGVycnVwdC1jZWxscz09MCBjYW4ndCB3b3JrIHdpdGggJ2ludGVycnVwdHMnLg0KDQpJ
IGFncmVlLg0KDQo+ID4gTm93IHRoZSBwcm9ibGVtIGlzIHRoYXQgb2ZfaXJxX2NvdW50KCkgY2Fs
bGVkIG9uIGFuIGludGVycnVwdCBnZW5lcmF0aW5nDQo+ID4gZGV2aWNlIGhhdmluZyBvbmUgb2Yg
dGhlIGZvcm1lciBjb250cm9sbGVycyBhcyBwYXJlbnQgd291bGQgcmVzdWx0IGluIGFuDQo+ID4g
ZW5kbGVzcyBsb29wLiBJdCdzIGVzcGVjaWFsbHkgdW5wbGVhc2FudCBpbiB0aGUgc3RhcnR1cCB3
aGVyZQ0KPiA+IG9mX2lycV9jb3VudCgpIDw9IC4uLiA8PSBvZl9wbGF0Zm9ybV9kZWZhdWx0X3Bv
cHVsYXRlX2luaXQoKSB3aWxsIHNpbGVudGx5DQo+ID4gaGFuZyBmb3JldmVyICh1bmxlc3MgYSB3
YXRjaGRvZyBiaXRlcykuDQo+ID4gDQo+ID4gUHJldmVudCBvdGhlcnMgZnJvbSBzcGVuZGluZyB0
aGUgc2FtZSB0aW1lIG9uIGRlYnVnZ2luZyB0aGlzIGJ5IHJlZnVzaW5nIHRvDQo+ID4gcGFyc2Ug
bW9yZSB0aGFuIG9uZSBJUlEgZm9yIHN1Y2ggY29udHJvbGxlcnMuDQo+IA0KPiBJJ2xsIGhhcHBp
bHkgdGFrZSBhIGR0c2NoZW1hIHBhdGNoIHRvIHdhcm4gb24gMCBjZWxscy4gVGhlbiB5b3UgY2Fu
IGZpbmQgDQo+IHRoZSBwcm9ibGVtIGF0IGJ1aWxkIHRpbWUuIEkgZ2VuZXJhbGx5IGRvbid0IHRo
aW5rIGl0J3MgdGhlIGtlcm5lbCdzIGpvYiANCj4gdG8gdmFsaWRhdGUgYSBEVCwgYnV0IGlmIHRo
ZSBjb2RlIGNhbiBoYW5kbGUgc29tZXRoaW5nIGxpa2UgdGhpcyB0aGVuIA0KPiB0aGF0J3MgZ29v
ZC4NCj4gDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4
YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQo+ID4gLS0tDQo+ID4gwqAgZHJpdmVycy9vZi9p
cnEuYyB8IDcgKysrKysrKw0KPiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9vZi9pcnEuYyBiL2RyaXZlcnMvb2YvaXJx
LmMNCj4gPiBpbmRleCA2Yzg0M2Q1NGViYjExLi5iM2EzNTljNzY0MWQzIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvb2YvaXJxLmMNCj4gPiArKysgYi9kcml2ZXJzL29mL2lycS5jDQo+ID4gQEAg
LTM4MSw2ICszODEsMTMgQEAgaW50IG9mX2lycV9wYXJzZV9vbmUoc3RydWN0IGRldmljZV9ub2Rl
ICpkZXZpY2UsIGludCBpbmRleCwgc3RydWN0IG9mX3BoYW5kbGVfYXINCj4gPiDCoMKgCQlnb3Rv
IG91dDsNCj4gPiDCoMKgCX0NCj4gPiDCoCANCj4gPiArCWlmICghaW50c2l6ZSAmJiBpbmRleCkg
ew0KPiANCj4gV2h5IGFyZSB5b3UgY2hlY2tpbmcgaW5kZXg/DQoNClRoaXMgd2F5IG9mX2lycV9j
b3VudCgpIGdpdmVzICIxIiBvbiB0aGUgY29ycmVzcG9uZGluZyBub2Rlcy4NCkRvIHlvdSB0aGlu
ayB0aGF0IHJldHVybmluZyAiLUVJTlZBTCIgImlmICghaW50c2l6ZSkiIHdvdWxkDQptYWtlIG1v
cmUgc2Vuc2U/IEknbSBjb25jZXJuZWQgYWJvdXQgdGhpcyBwbGFjZSBiZWNhdXNlIHRoZQ0KY29k
ZSBkb2Vzbid0IGV2ZW4gY3Jhc2gsIGJ1dCByYXRoZXIgaGFuZ3MgdW50aWwgd2F0Y2hkb2cgY29t
ZXMsDQp3aGljaCBtZWFucywgdGhlcmUgaXMgbm8gYmFja3RyYWNlLCBub3RoaW5nLg0KDQo+ID4g
KwkJcHJfZGVidWcoIiVwT0YgdHJ5aW5nIHRvIG1hcCBJUlEgJWQgaW4gJXBPRiBoYXZpbmcgI2lu
dGVycnVwdC1jZWxscyA9IDwwPlxuIiwNCj4gPiArCQkJIGRldmljZSwgaW5kZXgsIHApOw0KPiA+
ICsJCXJlcyA9IC1FSU5WQUw7DQo+ID4gKwkJZ290byBvdXQ7DQo+ID4gKwl9DQo+ID4gKw0KPiA+
IMKgwqAJcHJfZGVidWcoIiBwYXJlbnQ9JXBPRiwgaW50c2l6ZT0lZFxuIiwgcCwgaW50c2l6ZSk7
DQo+ID4gwqAgDQo+ID4gwqDCoAkvKiBDb3B5IGludHNwZWMgaW50byBpcnEgc3RydWN0dXJlICov
DQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20N
Cg==

