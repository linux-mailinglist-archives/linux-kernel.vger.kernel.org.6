Return-Path: <linux-kernel+bounces-181725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643928C804D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 05:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857381C211BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 03:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7F7C127;
	Fri, 17 May 2024 03:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BtcaBcZn"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE6DB669;
	Fri, 17 May 2024 03:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715918202; cv=fail; b=h62vJP80gihRRwpjAWfEVNWs7+jVfk64uI1I/jbU2V677PPDDfMn6uMx0IxAGyTh3m0OJgLhYj0fwzffGV6gI2mtrPuCOXc1O25YGZQuUT1ywp27gFNHDxMebYY9YkyI+s2VyjIEA7SzeS0pRkizqlR27uNvi97VINSX40kDvAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715918202; c=relaxed/simple;
	bh=dUuKVu67ShVmZNohXaTgjzcy08xH+1gz5xVNW2IMSIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sdoXWeTHspK3MHWMLLRyFzJevoXuH+m7O7nvVO60ENBzjlKC4nOzPuyfDqWjs/3bPoHHYGyfQ8lts4ngRGgUxq4/8BRsS8C4PLizw3V5bVOO8K1sbtKcC82ud5RFT9dnFSPf287aYYEnHkOie3wQEbEJTTeAjQ8Nk52g2tJrA+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BtcaBcZn; arc=fail smtp.client-ip=40.107.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cku4I/JgLLOwE/KigUUx3s70NLOffkyRUzS1PxnGbmsXib/S2pZlfVBQTMDIjvalsYVE+Q3nkssYPbBahutCdSF3WmC1xidNUdVCGlZl8SLdyQtqRKBpDW2pULxsB/moEWsA63plauh60UhVm78zmk2KGNXPRBQaKRTI0699Sijx3IykSfYcf7ZC/SDCmWqp5ronw36VhcaapRZmqrVDUIG84xwnGh6tFVVF/PLKAJ8XHFoIxnDkXAKs5OOLuGkY1OLqVr0ifE4Tusf0UPWv3/8HP2+GEiI89WAEZUuvaiJLNH7fBtgfCpC1yCOnEzSo6TT60h2VR5Zy5rCjWP3vOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCvh+MwBdyCcjo+WQ6BeAztZu2QNgsdYyn/PsNHhRso=;
 b=ihD3sR0hHYDKy19lBhnTeqtWOrUQTFNrK9jNemo/NKqSKzOzd43pZJjKxq3TBLqyvba4hwYfXIWJCI/xHcAg8kAlqnsM/dvJHruESRHvWw11FQfn3eZ1z3cgNHFs2Jl6XWogHlwDHo5TMoKfEYy1E7hc3WE/9KHmJcjeke9rK3fwOCjZHOg4rVeB9GU/hFomzAVw1mACdZUls7q3fVMFZWiscO60bQU08ZsoZ3iS6dS/i6+wmf4XwwST3nb0YXSOQKrQwgrg9dxbS9V+Xti/gbAnbUbIedhoC+hM8eIPopLygIOW3EJuMrtXs59JPB7joVnYoB4d5RCUI5zCHV2YHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCvh+MwBdyCcjo+WQ6BeAztZu2QNgsdYyn/PsNHhRso=;
 b=BtcaBcZnNThszuEhSopGA6W4K3wuU5T0C8zUQIMwnAj0UOXK9uJBx6g+tquUcFzIyJ1y+VjtLJ2DDnfTLkEOAzuKxCDyIX0g6q1aKv72xL4vb6pR5k4+bHbRMCyKKpQI8XzCWlvHDNcWHNnlJZWxlMpRY8sd4tDu2P/IviZqK8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8312.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 03:56:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 03:56:38 +0000
Date: Thu, 16 May 2024 23:56:27 -0400
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
	peng.fan@nxp.com, mturquette@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	marex@denx.de, linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Subject: Re: [PATCH v3 3/6] dt-bindings: clock: imx8mp: Add reset-controller
 sub-node
Message-ID: <ZkbVa5KvvbnH/tNQ@lizhi-Precision-Tower-5810>
References: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
 <1715679210-9588-4-git-send-email-shengjiu.wang@nxp.com>
 <20240514-campus-sibling-21cdf4c78366@spud>
 <b86c83a520f0c45a60249468fa92b1de.sboyd@kernel.org>
 <CAA+D8ANTdvQJVtniyMtqjnJdT4qX+LDGjVuFO6H0RSO+GDw+ng@mail.gmail.com>
 <20240515-unbundle-bubble-8623b495a4f1@spud>
 <ZkT+4yUgcUdB/i2t@lizhi-Precision-Tower-5810>
 <20240516-reversing-demeanor-def651bc82ac@spud>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516-reversing-demeanor-def651bc82ac@spud>
X-ClientProxiedBy: SJ0PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:a03:338::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: 31af53e0-7c43-4b6c-99cf-08dc76255a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|7416005|1800799015|52116005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWNwZVkzWnMrVW8yRFpocC9BYzRWVi9WSUZ2TFR0VUh3MkZMSEQ2cHgrWDls?=
 =?utf-8?B?UVpoMkVZZjZ1ZUNVSzVZaXdhbU5iQVNpdXlxVzFyY2VHWW9EYm8vSG5ZZTR5?=
 =?utf-8?B?VnBTem1jNXpVK21GenhQUmRYT09BbnhiZVh6aUN3eFB0ZHFiNHE3UCtlUHIy?=
 =?utf-8?B?UEtJV01CWDN4UWR0SWxqNlZEbzBWTGoxUXZIZ3kzRFVYZGFHNVZ4UGQ2Yldv?=
 =?utf-8?B?YjdUamJ6eGtjN01PRzF2Z3FiYXhxbXpEWFIvS1poZzdGNFhxN3JLZXZUTHNs?=
 =?utf-8?B?MTVxSjFjcnFod0NIdWpreVg2cG90MFNidXFOODdzVHFxRVVaSnVtdzkwcENu?=
 =?utf-8?B?U0hSR1liWUczUUw4WmMwMWZPcC8vcDVIWWVEQlVTblE0cE11bW9qdk03Q1RR?=
 =?utf-8?B?OXQvWC9ESkcxTi9mdDN2ZWJLK2VWV3VIRUEzZEhKblVydVZteFpjdEFXV3RW?=
 =?utf-8?B?QzNoN3prS01NVTRqU2JHYzRsejQ3MkltTXVBVXVNZlN5aWFYMmdPN3U4dVVM?=
 =?utf-8?B?aHlHeWVFUUZMY1FSWUxQeVkrVndzSlI4a1d5QmhzYVVhQlpydjk3U054UmFF?=
 =?utf-8?B?MWk0Zm5QbmpCdDRRWWE5eDlwdk9FY09rYWVVcjJqZWpDR0RkVVkwdE9SRFhU?=
 =?utf-8?B?SXFlODhnK3F5OTlhN2JZQjcvb08rK0ZXZ25qcmdUa01ZdDR0dy9OZStqaEkz?=
 =?utf-8?B?aWRDTEYvQzhZVmEwY2w5WmFHYTB3OUhlMXh0R0J3RmVpNkdtNGhMYVpPYSsv?=
 =?utf-8?B?YkQzYnRXMmM4ek95SVg2eWY0bEJtTjFwYTEyYzVHZUw0eUhRdnBqWExvYkNx?=
 =?utf-8?B?ejM4OVQxc0dpZm10UHNzYnFTMmRIR0gzek5IU2g2Zzd0Q3ZHR0k1ZXl4K01M?=
 =?utf-8?B?UEZpZUc3R1kxK0p2YnZ1dnJJUEE0Sy9idFpnMXMyeFJWWXhhTU1LMnEwbHVn?=
 =?utf-8?B?QVl0RlZYVUdudnZYUU9jbkdXVjdLWUFjMzl6K3UzN2JJb3l4VmJ5RWtVdUlH?=
 =?utf-8?B?TSt6bGlzTDYrVHJRKzd6TnJIV3BGTDAzVHp3V3dQQ1lRQzRLK1JaT0FlL0dG?=
 =?utf-8?B?SU5HSEF0aFY4QUVsNEt5S2duak5uMG90VWR1aTI4Z3hzWVZBWHNJYnlhN1Vk?=
 =?utf-8?B?NktiMFdQQ21lOXdXS3JVQnZlUzhNWWhZOFljUVlOclNEQmx4ZjIyaDcyOHZB?=
 =?utf-8?B?cDFQVFdrVTBFRnJmTUpKQlJJZFNqUXZGLzBUVVhxNk5WMVZHY1pTQ2hGcmxC?=
 =?utf-8?B?WFphdzVseGkzZkcrYWMrckNxT1cyc1pUZis3R2dvOE5kc3JDYTdnZTRHZi9V?=
 =?utf-8?B?SVF1RFB5a1VhUXRUK2Q3K042RmlwQlMyemh2STc5SUl5Z3MwUW5OVmRnbkM1?=
 =?utf-8?B?bFR5Smpnbi8rU0pUWnp1S3Y3aURRTWs5L2RMVEpIMEhjbXVrN1gyVzZ6enlT?=
 =?utf-8?B?bUNrTXBaTUxzSWU1bXlCalJaQWx6N2lNWTNhZTZNVXcxdWxES01EaWNoZ0tR?=
 =?utf-8?B?czJFeVhIcnJ6MTNkYmNXU3NQNXBCZWpJN2ZDNU80d1VqbU5sTGJ3TGJYM0Rt?=
 =?utf-8?B?V3h6YlBkMXg2UUpEOHZOWjJpRTM3WG9VZjVhZWllVS9DTWhtQkhnckhYQkhm?=
 =?utf-8?B?SVF1WmdSMDFlM3FITVprSTdBV2dFclJBT2VpUU5wWTY0aGtBN2ZmVmJKKzI5?=
 =?utf-8?B?akNiNitGdS9Zb2ZTdVlob01MTlFYTWUvaGVxOFBpTnJRa0xGa09oVlRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWNBOTNrZ0FvZVY5QW8rbE1ZRTZtN2dieGpxd3A3OG5SK21Ja1p4VDFydGJr?=
 =?utf-8?B?QXE1T3dReGpSQXFlZnN3bTA0MGRoV0NFUkMrWUxTUytWdGlEK2x1YThZSUI2?=
 =?utf-8?B?MUJSUGhHblYxOUhWc09nWFYyaGVKUUtsdlovY2hrU3pReFFxL0lEUXdQWGdN?=
 =?utf-8?B?YUtiT2FqQjB4QWtLblY3bW1CYm9mNFdYWWJnY2huYjFkdEgraUdoQWdnYjVp?=
 =?utf-8?B?VVZEY2tTVHd1MVRjc2dudTYyWThVQjZ1TFdwenNxWHhSZW5UOGtWZlJBdkhn?=
 =?utf-8?B?VU96czhWVEY4NUhOVmhMazFuZllvSS9zMnZhRGlCaUo1Q1RsL1BWUkNoaWpT?=
 =?utf-8?B?NEErb0hZclg4cEJYRDh0bFRpR29xMkJ6YWhqZHhwMG1JZENrLzVTVTBZQVRh?=
 =?utf-8?B?cXEyakJyMG5VZ2dCeHdtQ3g5L1NwU0tlQlFTNXRZRzgvL3h6UncxUkRzZEY5?=
 =?utf-8?B?dmZFRTRuU2dkc2pYYmVpNFdaclg3T3dZbUhIWUpUVjZKeEdlNVozVXlJdGdY?=
 =?utf-8?B?T3I3WFQrRXVYaUMrclQ1REtVSTRROHFRcHF0UHVuZU1Vb3FQMXFQOE96MkRs?=
 =?utf-8?B?a2ZBd1FmejBMdGdIRW9CakhtaSt5cFlSczNCTDQxTTMvNWRLMlR3cytJQ2kz?=
 =?utf-8?B?MStkd2c5b1VZVVhVZnNPNU9YMk9NWGtGdzRpd0cvaWhqSWRGeVFxRGRFN2JZ?=
 =?utf-8?B?ZlFQckpnUDVHQjA1WVB3bFVST2cvYXMxdHBKMXNQa1A5cjk5dDNyZmdPa1py?=
 =?utf-8?B?VVZMTVFKbFpraENxZElzOCtUaUE0enF6ellURXM4YzBPVkJpQWxaK2tzUXJZ?=
 =?utf-8?B?ZWFmR3YrSngvelpvTVRQSXhpQ3laTDdsU05McEFTTkVFMHJ5UFI2K2RFVFNO?=
 =?utf-8?B?S1g5ekN4d3kvcVhMQ1JtbUx4OUpuR1RKcDY5b3ZweUttaWswMkF2UElzSWxn?=
 =?utf-8?B?dU1OSkduYjlrZnROODlGZEhDT3I1eVhyend5RkdwRDYraUVsbmF0MjNxTmtk?=
 =?utf-8?B?NjM2UjAzVzY4a0xObTJoN2s0YWJaa0VWdGNvLzh1ZHl5cEV3NVhuclRFZDVG?=
 =?utf-8?B?SHB1Z2R1dUNiaE83azJIV3RzeWNWeXRXTHdGdEtQUVhXcUZSSXZ5RzhWalRD?=
 =?utf-8?B?Q28yelZOUldXald6RU8vcER5cmY1TGh1S3BHUjNTL0trM3B2bWNCUHdLRFpJ?=
 =?utf-8?B?TXl2SDY5eG5SYjVJNDNnR0l1MDlXRmdOSEllaUxzMWozZXYrT2Z6M1RmVE5Z?=
 =?utf-8?B?azdUVTRna00wS1JpQm5Vc3FIL0YxQUVXSXNjWVpOUG8xV3lkTDBkanlxTmlJ?=
 =?utf-8?B?aGJIUmRvU1VzcVZramk3ZVRhTVhieUVrT1Rqei9mSFlWcHNRV0FVU2FmdXNs?=
 =?utf-8?B?THNUalJuWjJpRGNqTThPcmxrclFsSW8zVlZ3cFBtRHhkRytIb1FEM2tvd1BK?=
 =?utf-8?B?OXliUDFlTFJpWWw2MDJpL1ZSRXBwTm5abndpblhaMDNHV0pPZUJrSThpeHRS?=
 =?utf-8?B?VTRNV3RscWdWTkVpd3p2UVVnd21RZ1FxMFAzZzZVYkxPcHRySTdYRS9HRjl0?=
 =?utf-8?B?Q2tUTWdSRFpBczdidklHZWpseGV6WFB6dXdKbXZwdEhDMjNLd3BFQm5YM0F0?=
 =?utf-8?B?dyt4eW9YTTJWTHdLamcyNUtodmJaYnNyQTl4RTdqeVRNR2w2V3ExVWlQSDlS?=
 =?utf-8?B?L1dmN2tSV21ER05RTzRrOGhOWHpmZVpkbUxEL1N2bXJVMURBZFRRWHJuS2p1?=
 =?utf-8?B?SFJ5ZGVsV0F6eDVCUjFSbWU0dy9CaXVmQ2ZiUUVIOFpMa1JmL2E5R2laZTEw?=
 =?utf-8?B?WWpsUDNCcktnSXFuc3VJbThvcDIvMGpUdXFldWoyaEYzSG9WZG9lUzF3MXYz?=
 =?utf-8?B?dmhyNlJPUHdZQ0lTSEFCcUUzby9ZdEx6TlBpNHFDdXhtcXV5WjN2b3F6c2ow?=
 =?utf-8?B?azdMZTNNczdidFc4aGoyOXR2QlR0R0tKbHpYZnhtUy92WkExUG9INGgvbElr?=
 =?utf-8?B?QTJJdDJDNktzSHErUGs0R2ViMGsxUkRrSlIrM01COWxPL1BPZmZJK0o3MHIy?=
 =?utf-8?B?dDJwenp1ZmtDNmY3YjBuSmlJRnIzMUpvZ3ZqTGxTUk9yMEpvRVcvc21GWlRL?=
 =?utf-8?Q?jkoA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31af53e0-7c43-4b6c-99cf-08dc76255a1f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 03:56:37.9380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sikdx1HgrAGWSEsQQgTGCug2oiz0678C1QuH1by0UxuspMHuYels/ageAVkKgwNE0em+RF4GIk9mOB9Vo+7Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8312

On Thu, May 16, 2024 at 06:15:18PM +0100, Conor Dooley wrote:
> On Wed, May 15, 2024 at 02:28:51PM -0400, Frank Li wrote:
> > On Wed, May 15, 2024 at 05:04:48PM +0100, Conor Dooley wrote:
> > > On Wed, May 15, 2024 at 10:47:57AM +0800, Shengjiu Wang wrote:
> > > > On Wed, May 15, 2024 at 5:09 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > >
> > > > > Quoting Conor Dooley (2024-05-14 11:06:14)
> > > > > > On Tue, May 14, 2024 at 05:33:27PM +0800, Shengjiu Wang wrote:
> > > > > > > diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > > > > > > index 0a6dc1a6e122..a403ace4d11f 100644
> > > > > > > --- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > > > > > > +++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > > > > > > @@ -15,7 +15,10 @@ description: |
> > > > > > >
> > > > > > >  properties:
> > > > > > >    compatible:
> > > > > > > -    const: fsl,imx8mp-audio-blk-ctrl
> > > > > > > +    items:
> > > > > > > +      - const: fsl,imx8mp-audio-blk-ctrl
> > > > > > > +      - const: syscon
> > > > > > > +      - const: simple-mfd
> > > > > > >
> > > > > > >    reg:
> > > > > > >      maxItems: 1
> > > > > > > @@ -44,6 +47,11 @@ properties:
> > > > > > >        ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx8mp-clock.h
> > > > > > >        for the full list of i.MX8MP IMX8MP_CLK_AUDIOMIX_ clock IDs.
> > > > > > >
> > > > > > > +  reset-controller:
> > > > > > > +    type: object
> > > > > > > +    $ref: /schemas/reset/fsl,imx8mp-audiomix-reset.yaml#
> > > > > > > +    description: The child reset devices of AudioMIX Block Control.
> > > > > >
> > > > > > Why not just set #reset-cells = <1> in the existing node? IIRC it was
> > > > > > already suggested to you to do that and use auxdev to set up the reset
> > > > > > driver.
> > > > >
> > > > > Yes, do that.
> > > > 
> > > > Can I know why sub nodes can't be used? the relationship of parent and
> > > > child devices looks better with sub nodes.
> > > 
> > > That's pretty subjective. I don't think it looks better to have a clock
> > > node that is also a syscon with a reset child node as it is rather
> > > inconsistent.
> > 
> > I think it is multi function device syscon node. it should be like
> > 
> > mfd
> > {
> > 	clock
> > 	{
> > 		...
> > 	}
> > 
> > 	reset
> > 	{
> > 		...
> > 	}
> > }
> > 
> > clock and reset are difference device node with totally difference's
> > compatible string.
> 
> Which is I suspect is gonna require a change to your clock driver,
> because the range in the existing clock nodes:
> 	audio_blk_ctrl: clock-controller@30e20000 {
> 		compatible = "fsl,imx8mp-audio-blk-ctrl";
> 		reg = <0x30e20000 0x10000>;
> 	};
> would then have to move to the mfd parent node, and your clock child
> would have a reg property that overlaps the reset region. You'd need to
> then define a new binding that splits the range in two - obviously
> doable, but significantly more work and more disruptive than using an
> auxdev.

I am new for auxdev.

according to doc: https://docs.kernel.org/driver-api/auxiliary_bus.html

"key requirement for utilizing the auxiliary bus is that there is no 
dependency on a physical bus, device, register accesses or regmap support. 
These individual devices split from the core cannot live on the platform 
bus as they are not physical devices that are controlled by DT/ACPI."
                ^^^^                                        ^^^

Look like it is easy to register auxdev "reset" devices. But I have a
problem. How to use it by DT phandle?  "reset" devices is service provider.
Some client will use it.

Generally, reset node will used by other devices nodes. like

ABC: reset {
	compatible="simple-reset";
	...
}

other node will use "reset = <&ABC 0>".  If use auxdev, how to get &ABC
in dts file.


> 
> > > > A further question is can I use the reset-ti-syscon? which is a generic reset
> > > > device for SoCs.  with it I don't even need to write a new reset device driver.
> > > > it is more simple.
> > > 
> > > That is for a TI SoC. You're working on an imx. I don't think that you
> > > should be using that...
> > 
> > I think this statement violate the linux basic reuse prinicple. If the
> > code logic are the same why need duplicate it just because it is difference
> > company. Of coures, if it is generic enough, it'd better to add a more
> > generic compatible string.
> 
> That's true, but I suspect it only works because only through (ab)use
> of the ti,reset-bits property not because you're actually compatible
> with TI's reset hardware.

Reset's implement is very simple. Most design is similar in difference
SOC. Just toggle a register bit. If regiser layout is the same, it should
be compatible. this ti driver is suitable for most case. I think call it
as simple-reset-syscon are more reasonable.

> 
> Cheers,
> Conor.



