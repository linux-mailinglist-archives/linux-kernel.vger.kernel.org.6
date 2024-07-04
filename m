Return-Path: <linux-kernel+bounces-241111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E70927722
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4B92825C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4635F1AED28;
	Thu,  4 Jul 2024 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BckgiDIK"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5851E7E9;
	Thu,  4 Jul 2024 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099536; cv=fail; b=nRi2AoAaDLeslfWN4Pdw4L2YkrmtyCg43qV0FONRVK+iuZRsGeJiqKmIzLL9TxZdQ6tmwczS0sz1ckEcAg0pY426RSdaC3/GmteyIZoAMJdEtBBkq8S9yvA5Y1dWGODuCwNnEgef+OThntlB4k0cFYf+T2rgHF2/AaEuewPvqGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099536; c=relaxed/simple;
	bh=v8V+H7r+DGw4wyy1bQzlmJdNeelrrl2u5k3pLUzpSOY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SYIPCQmUMiHqQ1zPsqDT9ZmbAlt5wRSNwXBusUhVexVmVr0d4UzGnDEapYA/Kwr3H9eHobDy+cVDiF74/nZc+XKIyc82UCDH/k7Hnq2YpbqUeBeeCd54jKqOIZYo7MJ4LGrzo8kbyV+h3I7lgym7AblOA2FCIua7gZs6zDM4bZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BckgiDIK; arc=fail smtp.client-ip=40.107.21.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQlZf+ukaXzdxc6Fte6ZY6pirBB8EiRlSG6PyeGAEThPtlTQqZq3P1YgNDl9WuoaqPOO0t2fkQ7xyi3JVanKKA/Jom5heEU4kssgokSBcSTMPyFSxXb3jEUHFRvzfeD4rbB7vIX3FiL7YYePBykAVCnGpF0ZnQOPYYqfM1xmyt0q+aLSGqkKXPp3oH4pAGf1HKOtgg3zfQjJuwK4kwpyR14VLdrt7YtYcpOJzmCJ1L3RbOo4YivCGYHwFaZBadtWHX28eLbQVnAt+z5+ZGaWvFBOnlw6z6r/9sOwRD10lB0EgeD+6uU9ZcIdHqplXh2N9CMynGCaH/vkkEJtBRQ3gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPh92FQtJtDJmFW2Qdoi8F4GXKoWtpfTRQwretaogrs=;
 b=B4ok4AX0NEodTMMdZ/kelY83bFLXLVW1RGQn0asRqZDXRQ15V0YcINyje9ddY195HoxMK9TlS+imuDkzDNBbVe9Y9MxtM5wn+89wUgUxBM+es7shdZDY1Kdp1f3YFbbysVRKoCWhFZyXdNVT3gK1MALMCfy5paeMGYObLn+PdbSRGlG+8fmAMpDOlrPgoOMOIfzNBfKEepkZsPmF3eq/nA1pIm/f4K8Ki6ytvhndNIcn5aTBf26zdvbf83aYFuPXzGQPQMf+skkAYAGvKEAARaTiX8CVNZfvtjYfhxoGlFJpve2qRGQZG6teGwyhTLT3JNuMjkuVfBtHNroP4kIfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPh92FQtJtDJmFW2Qdoi8F4GXKoWtpfTRQwretaogrs=;
 b=BckgiDIKgxMGv+voL2O1OuOZs70z9RE7KUlQ9a8J/Rzt8yZxB5Hed08X+eQUIhz90earjt98AIwz4s+OFceg5p1vzbRv7PMwKm5AinASxszMakgfm5LobsCqes2jn4Y7FrRy/5lyB8i0OfwV/UzyIdng6UnHRcQcUnrixADPt7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA1PR04MB10818.eurprd04.prod.outlook.com (2603:10a6:102:48d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Thu, 4 Jul
 2024 13:25:31 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 13:25:30 +0000
Message-ID: <236cfab6-6f5a-43c3-98f2-43a8d66af60c@oss.nxp.com>
Date: Thu, 4 Jul 2024 16:25:09 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: s32g: Disable usdhc write-protect
To: Fabio Estevam <festevam@gmail.com>
Cc: Chester Lin <chester62515@gmail.com>, Matthias Brugger
 <mbrugger@suse.com>, Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, s32@nxp.com
References: <20240704120300.2849264-1-ciprianmarian.costea@oss.nxp.com>
 <CAOMZO5BVS71UWS2u15EvbNLohSqRz8DamvXBQzRxFSNTobJG=Q@mail.gmail.com>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <CAOMZO5BVS71UWS2u15EvbNLohSqRz8DamvXBQzRxFSNTobJG=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::19) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA1PR04MB10818:EE_
X-MS-Office365-Filtering-Correlation-Id: ffee864b-9140-4d23-03c0-08dc9c2cc6cf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHF3b1dXQlUxamp0bGtNZ0RXanhaRUtFdmUzVys1RllIZHQ3VW9FTEF4S1Fu?=
 =?utf-8?B?czZpMGNib0dNeXI1Unc1VldJSmxnbEJ6azczNU5TQTRrcUhJTkNXdU1JckRp?=
 =?utf-8?B?UFp3ZGFVUHZrWGlUQ0grRjBZVGE1Q0dmeW5KWS9xWC9zSm1aWmlKejFzcFlq?=
 =?utf-8?B?V1d5LzE2WlZrQjlQYTByL2h6cFIzS1RWREp5dnlSZXE5YnlGNTM2d2l1ajNo?=
 =?utf-8?B?N1B6aFpMTG1RdjBtZnlqVnp5VDRVSnV2ZUlCd0dQbnJENkpSMU1vcUZ6ait0?=
 =?utf-8?B?eFNLZm44ZW1OWHJUcEh6RDB5aFE3WGROYmpaaGJXWXNFL3dsamlrZE9iQUlo?=
 =?utf-8?B?TlkxNXVpWFlBMFhJcGRFV3dqK2lTaXhGNnUwQ21Selc2ZGVyeS83aVZkdW5G?=
 =?utf-8?B?bHhNMFBmV3l5cGxTTzFaR2hQUjlqY0V4VHBOdWpwcm45T1dZQXNrSExsUHVL?=
 =?utf-8?B?OWxKMmErampKTytuN3ZWVEFQR2dNMTRVa3dFR2hYaU9vKzd0aGZGdmtWV2hZ?=
 =?utf-8?B?WGdnSCtOUHhzbVFDR1ZndVQ0WHZlMTFvcjgzVER0ZzRKTzBCRzF1NXFJaUhX?=
 =?utf-8?B?bUlJSnpJU3NBYXdocXdrZmhUVzZEVmRNYS9mU0dVK1N0U0s4cjBWNlE4NTNs?=
 =?utf-8?B?NDJpb081VkdXQUx3YmRUcFQySGRBaC92ZDk2U3hDSWNPZ0hFREh0d0FhQWs2?=
 =?utf-8?B?b2k0a0xVVFpFTDhBbVpZOTB4bXd5RFFrS05sZ1VWRTk2MzFKSzRUZWEvRjQ1?=
 =?utf-8?B?T0N2c0N5c1VqUzk4QW9kWHN0QlBWRmVmRW9FWVhVbEZIMm9PcTQ1L3V3K0hh?=
 =?utf-8?B?ZTl6bDIxYk1KVWJ5NGhIaFEreEVsZHoyL1BjU3MrM3VRTDd4WXB2WVp5UnZO?=
 =?utf-8?B?Z0d0OWNrY3ZlemVaT0RSVEpLMlA1ZTN6WnhacEt1eWJKcXBMR1c0b0JWWjZy?=
 =?utf-8?B?Wkd2OThhWStIL1QyKzNKb1g0enpUUEEyTVhabU1JaEYwbW9QNnU5L0lhcngv?=
 =?utf-8?B?c1drRzZhdXNMVndVMG1oSXZhZXBnRDdzOEpxVjNuZDVRMW9LcE5TK0pnVVVq?=
 =?utf-8?B?MXJHNkVmUzcxV0ZTTFJqNzM0TzVMbGhyL1BsQWZzUlFIbStWWk9IWE41a3VZ?=
 =?utf-8?B?OUF1OFY3akdQak5mUFNya1VKU3NPZjNVVFRSUlZVZDZhRXhyTlpaenNnbmla?=
 =?utf-8?B?TWJBSGtWUFhZZXFESW4yclRRRnYxUk5qQ0taOFF1aTZHa05veXhyeUJQZnEx?=
 =?utf-8?B?Ym43TXpib1NMZVFBZWprRytTQTZ6dGtGMEk0T3VLcVdGNjF1MnlkR1FtSmpJ?=
 =?utf-8?B?NHV1N3R1MTFZYXN2L1YrYXFGaGljRHFvRkxiWmQ1Z2JMdmNBN2dFZ0ZDZjBZ?=
 =?utf-8?B?YkFpZU8rR3EyN3JFNSt4WXVUMmZScUNXMUx1aTB6UGd6YmtWYVJ6QTJFWGkz?=
 =?utf-8?B?REpOTU5CUjZZQis0bzNCSUJXY2p0VEFPVFBwUlIxZ2JUQzhiUTZPQit5N2JH?=
 =?utf-8?B?UUhLandob1ZIZi9reDlDY3VsWTFHcFZZRU1xV3lBbWc4akdnLzlUY1ZLYnVY?=
 =?utf-8?B?NmZjUTg1UmR0ajlkeFpjdFQ1bWMxMGZEZDFRMVdoWUxhOUJ6ZTlBTTRFdTlt?=
 =?utf-8?B?T0V0WURCZE5wYkZ6N3c4QXEzMFdMTzJTMmtYOEFQTVJrYW5ic2tGTTk2V3VS?=
 =?utf-8?B?b3B1VkJxWDB3TWE5aFhsdUVnWVZuMUduWTc3a05aNTQ4RUtpWTFGQU9LL1pB?=
 =?utf-8?B?RW1JUUIwUHcxREM4aHpEYm1YYzVBWmkrWHhVbk8yeFBGOU1aeVBjMWtFL1hY?=
 =?utf-8?B?QzduU1pHK0Z1eWtOMkN3Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEtLSnNXZElkK1hPVmFBbjJTOW85bUlQVENWYWkyYllndldMNmVLRmthNGox?=
 =?utf-8?B?U2lIZHBNNmQ3ZUYvRXR3YjZwOXdCNFk3WnJvY1dtWHcvSGRBR1JYWVhDT1Ix?=
 =?utf-8?B?OUhyVVF5V1EwamlxSU92ZyszdE9FeCtNVUVlWk5nU2ZrV0VybmFKQnc3U3hx?=
 =?utf-8?B?cmsreWlKTm84ZXhMUTJHR0VJR09pb3lKVGlqQnRNckhHUis0aEJXVHdUdjYz?=
 =?utf-8?B?R25MZm5BOE16U2szN0FpcCsvZmJNSnJkSmFGZDloUzZ0OExZck9QUm5ibmFI?=
 =?utf-8?B?ODhXVFVsVXFtWWt5bm5ReVBQbk9TbEJOK2JKZzZ5UUwyNHN1ZWZUN3RYeWxp?=
 =?utf-8?B?YngwTTRoaTVUaFNWS1ZsS3hRazRTem9wU3cydk1aNU9kZnRxeFFYQmNaV0k0?=
 =?utf-8?B?Z1BWdEovMithQWFTcjh6L2M4TkhEOHRKc0VMb3BhaVJFeDJkam1WTzY2d2xB?=
 =?utf-8?B?dnFOeEFFLzNlclNIOUF1dGZhS2lNQ2xNVStKYVpHd2k5WnlUSWVaa2d3SEJF?=
 =?utf-8?B?eFlQZHpTNm1WZDRTeTkwaTlqN0dxWlF3eE1iNWRFSUNBV09mREZsVXdaV2JJ?=
 =?utf-8?B?amkrZUQ5S0thYXJQRk1yOEk5VTR0eWQwZlpQeHJTZS9uMXVOaTZ5Z2Flb1FC?=
 =?utf-8?B?b0syR0NRZnM1OEZKa1VLNGIvMG1ORU9tTlJnTGJ6cXpPUXhaQkQ3Z21YUTk5?=
 =?utf-8?B?VmZldk1wREczRjBMVXQxc2J0TjhBeE44ejN2b0J2VTdZNVZ1YXFweFkrQXFC?=
 =?utf-8?B?bk8zdUxvSloxcWRjaU42NWNURnhXYTkvSGlXdUZPdHU5c29BaEszU1lCMHRR?=
 =?utf-8?B?UnFSeS9QQ0t0eHljanFxblRvUEFkcEJBazhmUWFjTktTYVcvTXZRNkVQT3Mw?=
 =?utf-8?B?NUkxc1pGbzNPQ3diYVIzWVZoWFBiMmJEZVJjRGY5TzUzMzJKblFac2h1THQ1?=
 =?utf-8?B?WjhSUTJoMS9ZMXYwQjhWZTN1aDZjdzhnc1Zab2VUTFVoOHlqVXVrU1lYekI3?=
 =?utf-8?B?VnE3VHZONkJmMmlyWksxaXRhK3c4NlY4VjFYNHh3S25xK05laUhsQmFVeFV1?=
 =?utf-8?B?L1BiU3lOazlDMHBuT3g5aWFlSDhMSThGYXB1WXBZSFRydDIyL21xM2FiNDN3?=
 =?utf-8?B?a0hTemNtWGQyNDJudDI2bnB5QVBOYW9TVU1ySGxVZ1FUeDhiOTNSSktTdUNi?=
 =?utf-8?B?WlJBMFB3MUZDL0QxUVlFTGcwcWJQZTBMS0FoUkJqNklOQVhlQ1lXSGhoWmJl?=
 =?utf-8?B?YllmUUpRSWN3Yzh2ajlZMzU1MlhMSGlLN3llWmxac0JRVXN5UE9uTzEwdGxP?=
 =?utf-8?B?Zk4rWHpkL3BFWFFqSEM5N2lvUVdhcC9nRVRiWnMyMjNFSE4vWTJHUFFuc09q?=
 =?utf-8?B?OUQzYW13eDdhdVpERWh0eWJydFpwNUFSdSsrNWZ2MVpPTlM3V1F6WlRZNEhx?=
 =?utf-8?B?WmN5Ym5mV1FzOW9WR0g2MkxsU3ZoTlJ1Y3lQVDFpUnFxMEZ2K2k3UHg4Z0xl?=
 =?utf-8?B?aU15L0hCU29lSCs1cm15bUdzc3o2UzUwcnlnK2ltTDNweGJyRTU5TFB5MTdM?=
 =?utf-8?B?QjEvUzRhbHFmNUM5UGMzTG5CSUZIS2I2Zjd6ZjdNNTAyVnI4M2YxTlRqQmhV?=
 =?utf-8?B?Wno2bHJidTg5UEdrNFBPWEkrenp6cmxoTHdzeHVtblh2VlBERDE1bVcrRXNM?=
 =?utf-8?B?WjhOUFJmSm9Fc202Q1VUTGZPQnExcEFPNDl6WXg1QjJXbHl4bWdZbTB0c3U4?=
 =?utf-8?B?aUdMa0hSREtlS0ppeFlPOTd0VldoWnVweWZ5dXk4dXVRdzZzUmVhNGlqZktK?=
 =?utf-8?B?WGJkL215MUZ2eU9FenNuYTh6WFlUc3IrZWpRTHIvOE80YTZlQnFja1ZUWUxR?=
 =?utf-8?B?NHljMUtkUGVybG81NUtnTUhwSW13bkxVdkpuTzNXUVBRbDRYcXIwMDgvWmw4?=
 =?utf-8?B?MGlTVTdXREx5V3hYdjZIUWhGU3Nyb3VmU2hPRGVHN2QrV0czU3dzR2NGMmlm?=
 =?utf-8?B?cnI5Ujg1cFB2Z0NKeStzVldHcHUzeWFTRjQ4TTUxRDZrVjhVZzJxVUh5d0E3?=
 =?utf-8?B?OGh4WW16QTZrTmM4ZmtsdzdjMmt2MXI2U0xGa2JpOW9RR0tqRGlZdS9oOVB6?=
 =?utf-8?B?aE9BdkFWbmovekNNUU53RFVyR3B1T1U0TS9vZ0h3TmFwRitGdi9KQmdQekRJ?=
 =?utf-8?Q?qTBveMMi4z3UUJNlDXEI0/g=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffee864b-9140-4d23-03c0-08dc9c2cc6cf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 13:25:30.8929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUMGZDC0VzcBWC+lWydQUDeLgJ6IdyAQjzoSI0fH4ZgVqPPcokb2+z09Rd/pcRh1UhbP+gz2ZZt3/rt2iZoBrwzDrHC5uU/+Li3vifdllFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10818

On 7/4/2024 4:13 PM, Fabio Estevam wrote:
> Hi Ciprian,
> 
> On Thu, Jul 4, 2024 at 9:03 AM Ciprian Costea
> <ciprianmarian.costea@oss.nxp.com> wrote:
> 
>> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
>> @@ -145,6 +145,7 @@ usdhc0: mmc@402f0000 {
>>                          clocks = <&clks 32>, <&clks 31>, <&clks 33>;
>>                          clock-names = "ipg", "ahb", "per";
>>                          bus-width = <8>;
>> +                       disable-wp;
> 
> This should be better placed on the board dts instead of describing it
> in the SoC dtsi.
> 
> Some boards may use a GPIO to describe the write protect pin via the
> 'wp-gpios' property.

Hello Fabio,

Thanks for your suggestion. I will update accordingly in version 2 of 
this patch.

Best Regards,
Ciprian

