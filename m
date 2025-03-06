Return-Path: <linux-kernel+bounces-550045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7C9A55AA8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8066117224F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759CC27D762;
	Thu,  6 Mar 2025 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ed/O+DP1"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013011.outbound.protection.outlook.com [52.101.67.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB69D200B95;
	Thu,  6 Mar 2025 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302416; cv=fail; b=t/TvVaErfwpfbFcY8jXE3xY7eqFTmrNPXwSJufL/Ku/zggHXXGI20TU49sbVOyTAhsN/X1G3LXK1f8rNlM5S4EwUJS3+A0lxcMm/Z+rc7b6iXIv0gNHvP0VuvjFHbEwOqciwNNobXIJflixk5b3xRnlZiiz0aQfl9tTJnui6UR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302416; c=relaxed/simple;
	bh=4Oz5GqNTCLY0rT4kksJM+ByTrIoG2WmxLrpn86Zrh/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TfsSpQtzzgLRgPby97aUlZCwuPhWfqfhOLXeZcjAJfNHWKLHh+/qgCcm5koA9dDcDq50rzEpzAMOpHNwwxjYlxaQrDHC4kXdX5XhSIwCznVg/reQxgy7Puulk6G4nHctQQDdR/546SQzBym1ETgttg0cuGaACOx77rqRQz/EKzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ed/O+DP1; arc=fail smtp.client-ip=52.101.67.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLRIIAPczTmwBVN3Az8Q30qUbAht/dIwLTBLA3kzIU1h2Jbr1dkli7NeTbJqM+cIuB4fuh8eTnEFqRgNu/l15KmehkFOYPQNpxof59qpFert3VqtkD/90l64bE7zDhz+dNjwHioSMm628/d9mL7X+ruTvWxAHchTkRyZ5Vu8+JgqWSJU4jWaAKSWbY0hNsh4/XrO/m+ZUSmvjk3GNTE74+MyMv8rhu3fbHRSALxvn+9OkWkaUD801sReSxYnvCFKNc5Md4+/NgsWM1ZtW8+OKIT3Tq4gEThllKbLCn948UYcS4lVMnY6hguLM/sc7ZSdg1F3mP0aOQF8y0Qdf+OMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onr0T4Lfngs3FOJj6Xd+l/OP0mMcAfV0hFGyWuoX5QQ=;
 b=VMYcBDspNaLe+3ZAPZ3fIlrN0txfNdnXLw8D59r/TZL/b0GGWnyQ2m2dczBIKnJSZ2p8FpgXG1+0DHJUMUIjY+ZnnRQri4qQQuZ7ngwY0fRUaPqqGBUN0dmzrEkL7Q3RLl877LoTsaAuEBIWb2R+bGhyOzVpFOhMN8gcSrPPMU+5fAWos2czpVbZNPEDCgcJiyBRfUWhgvaiBxSs4xrOjxOepvFCbbIo1tPOh/BF6r6oqKYZ9+jrGVHc4PHxW6x6o/m7hgNsUI7c4gI4SBYae3lCZsI4shN4aNRlM2CS0yOo0wAu2K7Dii5IHz8TZ7XOFwuzsLKuqRzEWNrx9BZaeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onr0T4Lfngs3FOJj6Xd+l/OP0mMcAfV0hFGyWuoX5QQ=;
 b=ed/O+DP10PN9OXEcASmt4T5Y+Sh2Y9OvCAKRjhakVHn3evGBhzkRUxEKl5obTs2fXKuRH0OMA1CUogI5BjnVZhltfUVvH2UpCH5dR9wgFvfTvidd/uN32aVMb8l7EuYxbEO682uJOSVcJWJllkhYUOG8/y+3rPU+w6JmI+Q1aNyJuY+vnZrpNgUCWGiIeevC4SkrMzoJCRXfM693/SKDKwkv9lMJ4FBgEvWqSjXy0kNbCaVfw2QBLFAt91TztS2j28RM5XP1q3NXtyXARJnWEgtfrZtaW8G0MYsOW6izee967ioEOarTt2uc0ee/SMws2w0e18p9+MYWUqe3HB2KCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8872.eurprd04.prod.outlook.com (2603:10a6:10:2e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 23:06:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 23:06:51 +0000
Date: Thu, 6 Mar 2025 18:06:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM64: dts: imx8mp-evk: add ecspi2 support
Message-ID: <Z8oqhGmVOBCPlJUI@lizhi-Precision-Tower-5810>
References: <20250306222359.797855-1-Frank.Li@nxp.com>
 <CAOMZO5CL-qQSHuSoCtb+f_mqNG8vu4tTVDi-ThoHq+m9SeagxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5CL-qQSHuSoCtb+f_mqNG8vu4tTVDi-ThoHq+m9SeagxA@mail.gmail.com>
X-ClientProxiedBy: BYAPR08CA0033.namprd08.prod.outlook.com
 (2603:10b6:a03:100::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa1c5f2-fc4a-4fb7-4fc2-08dd5d0394b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmVBU2xOamk0RVZEK2UzZVQ1Uk92SmpobmdFNHY2MXpzYnlJTm81L3M5ejI1?=
 =?utf-8?B?NHNPc3M0TVZ2TWNCaER0RHBNa2RRWnI1OTdpaFdTK1pmOFl4S0F2YnB3djN5?=
 =?utf-8?B?YUhySjdOa2tZNXQ3VXBYZityNzZvdFBLaDM4TDBTbXB1WklHdTAwMjdwbnVJ?=
 =?utf-8?B?bVk1ZTdQRjJMZ3d2VE1XVGV1TjJtUVZiOWZrQklWcmZDRHQvVG91am04ZXNk?=
 =?utf-8?B?b2JVejY0YTc0TmdOMGlrUDFMY1ZCY0NyUUNpTTNGMmkrSkt2VFBRTXJkYzNs?=
 =?utf-8?B?cFRtQlNROXJicU9MTTBoT1FPdmQwdTZxMTJ6V1pwKzVKaldJeENTeEJmcSt6?=
 =?utf-8?B?cFdrNWdLK1FKV2F5eXl0UmxjNnU5bW1qVHJXS0w1UVZhYTZ4WFdzc2xreStM?=
 =?utf-8?B?dWZ6QWdhd3JaYTVacGM4SlJpY25TdXczOGtaODRyZlZ1bFJBY3dWcWVjUkZh?=
 =?utf-8?B?UmVjQUtLUmNNL25mSWZGVTN6cVc0UEhTZExnbUMyNlVSVHE4WTIwMkxKZm5i?=
 =?utf-8?B?cVAxZXhOejh5U2ZRQWNLZmVEKy9ZdDQ4MzlpS2JPYWhVOTF4VVpFcDlsMDFp?=
 =?utf-8?B?K0xSZEhWamtaUFFvQVFXWHpMdDJENVJqTVdlSEt6OFpYWm9XaTNJMHNmTDg0?=
 =?utf-8?B?TzJUNGhqQXVob3pYZUtkS29ES0FaN1BXcUkvTmdQZytxVUM0SmxjQ2ZDNWlM?=
 =?utf-8?B?Y1B2VzZiZVNtVUtzS1RGSmZYc0xzWFR6UGNPY29ORWhkbHVrem1nZlFNQU1w?=
 =?utf-8?B?TkRGMStWdTlrTG5HTFRCcFM3TlZPRzF3bVA0MThaS25YL3lUL1U0Z0ZZNEJV?=
 =?utf-8?B?OFdlWkZWUHE4K2ZBdSs5Vk5sR0VCaXdlcGF5b2JjbTdCRUlXdFIwdEJyQVBx?=
 =?utf-8?B?dlJ4L0h5aHZqTXg1R0lyR3ZObFhyZjkxenIzb09iRWw5LzRNVnBiam1UL1V5?=
 =?utf-8?B?SzJSeStlaHlZNFdheW1USXhaaVNYejVJRytmVDJFQTFia2pMWG9nazhzV252?=
 =?utf-8?B?NGp0UGYzbWhZM0dLYjI3TE1sdC9EcWdSR0tSUGpvcGFLUkRLSkpXVDRFMUFP?=
 =?utf-8?B?b1NtWTVOYzNpRU10c0VJQVdQUThDVEJMZXRHYXRDeDU4alh2QnhxV2tMaWRR?=
 =?utf-8?B?ejh5emhuMFVpdnFzd2dYZTRGQlN3NmZnWVU2VGNGb09YTEE0Yk5KWkZPVWg0?=
 =?utf-8?B?STkva2xwNzFKWHR6cHkxNExucTZNVEdYc0J6dVF2L1RkYU55bmJMZ2xJZTN5?=
 =?utf-8?B?TUV3VXlOcE5GRnNLaVdPQThjVThlaG1sQ3VnZlpoMDRnd0szeC9UbWhGYTBk?=
 =?utf-8?B?R2FOUWQ1b25ZamZpSWx2V2drZk5wbGkvcy84akVzTUhPRDAxNUlQOXJGZGJV?=
 =?utf-8?B?TXN1TzNod05SbTJXejIzMDRiNWpSdnFPd2QwSVZET2hKRXIzRFhFRHdWZ3gw?=
 =?utf-8?B?K2pXaDByWVRwY1huUUE0UHB4UG5BdmNCeG9CclVEY1hxUE1sUXZyUWlrWUc3?=
 =?utf-8?B?RXpjb09PVWpQUzhWRGVjNmRvMkJDVkw5dlFqSGR0T1JqTEpPaUU5S0JIT1Bx?=
 =?utf-8?B?S2hSMzY4VU4vSmY4ZmRna2FXRUtOcjdxeHZRSC9rZnFIaXU3NkZxSDVOT1Iz?=
 =?utf-8?B?VmNTNGRaK2V1ODhQVWowbTdEUGpqbm5vZzFOS0EwV1dHckFKYzFJRUREQitV?=
 =?utf-8?B?bkdvTzlYR2M1bGZ6SWkwMmV4QTJqVENIMHZJallnUjluU1hHZkRESlRjdkVt?=
 =?utf-8?B?SlBYUDdoY2R1UzVEWWkzSis3MzhrTG5KTHhROXRacVlvNGJJSUFOaEZ6UWFT?=
 =?utf-8?B?RGYwd3JpN21ndG02WnNRaExiNUp5Ukd6NXBaRzFLMEtLV3Y4bURFQU5ZUUg2?=
 =?utf-8?B?WERnWkZLWFEzb2hhRW5jcy9uZnRvL2FJWkZ1QkJwQTlPR2Fja21LejFpRXQ1?=
 =?utf-8?Q?hHcp3OGuPcfXz5NiA1Bxc/xPZFQYEG6u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXlQREFIUGpTdkVqZ05NN0lVNGQxRUNWUDF2OWFnSW5FYkhsb2pnLzFrdUZB?=
 =?utf-8?B?REQvSUJJZ3B3TTBvOERIcGkxNzlLKzJURUNyQXlqNzJ5NUcya2xnRTRVeUNk?=
 =?utf-8?B?bEFRNEhFWnRMd3BnQ2tndUVxKzZLY0l1Wno5ejBvUnI1MGNsWW4rNXEwQXJQ?=
 =?utf-8?B?alJiQWN5REdzckI5NWVlTUpSSUhrT25jTGRvVzRJYTVJQ0pwMGVsUHNjYXIx?=
 =?utf-8?B?eGVUUFFsbWxkYVByblhWZnMrK2Y5bWR4K004NlkvSnFaakVoUWxValdrRHBh?=
 =?utf-8?B?R0VWUENYMmxRaktTMjRKMFhiN21RcmR1bHd6b3VoWXMyUVY4VWRmeEVvbzlB?=
 =?utf-8?B?UjJLYzBaWExYc201WGhYYng0RUNEbTFnRHQ5QW9yWXlNb2I3RC9mT2hITXJ1?=
 =?utf-8?B?UEtlOWF1NmxvWnYvRGVNS0RBSHdNVW1aa1YzOHYxQ1RUMEdpcHdCYXIyT0xv?=
 =?utf-8?B?NHJiNW1KL3ZmTHhDNGtJejQ2SWZYbG5FWDZGNlpnV0U1OHVEZG5sS0JoNG5Q?=
 =?utf-8?B?bkt3Q2tsSVArMmJTVWlFT2Z1TnAwMnU1QmxQZGVHYUE3MVpESzYwbFR5Rk4z?=
 =?utf-8?B?dnFrR1BNMlkzSGQ1R0F0RWc2VEY1VkhFWWpOZCtMYlFsNjlOYUUvWHZlcFp0?=
 =?utf-8?B?ekxIZmI2ZUROQ2dRcTBlajlMR3k5YnpOQVczVUFPdVcwenZOR0FwZHpxenIz?=
 =?utf-8?B?K2thZ3p5cXJiMkk1WFMyZEJsb0k5NkNlVWlkeHgrT29ITUxxTnhVWDJQVTVE?=
 =?utf-8?B?VDQvOENrSnE1bjhKaFZlSGdNNDlVb1hSeGpmUklVUnBQay90eXZjWkZ4QnhQ?=
 =?utf-8?B?Y09QWkNWLzFMcXBzZVJmenFnT01lazJpN1AvQzdXZk9tSW5PVlRnRStRbmR2?=
 =?utf-8?B?SWRZK1B4RElaS3p0YjNDTHJCWUY2QVErdmhGYmFzWHJQZDhmVW5nUWx4TlAw?=
 =?utf-8?B?dlZoYnIyOUxKdStTRVg1RkxlZTJxSTA1aldIWVZPcUZyaTJ1RThpS0plUFo3?=
 =?utf-8?B?VVBXNVlRaWU1MFQ1MEI1L2t0OUpRQktSeWZXZktYNGNuVXVET2FCdGZraVZO?=
 =?utf-8?B?Z2l1a0FMSWlpSXV5ejRxdlBSZEdxRHdCbDJWOWZlcUlIVFVzcjJsMVdyMDRw?=
 =?utf-8?B?R0lhaTJpNUVsemlqRHNETU5Md21JQ2ZjaHZmYStuRmNaSWk5QkRaY041aW1D?=
 =?utf-8?B?QWYwN3RLODF0NEk3Q0hiT2Y3N1BTeERkdFVJSEd6UVNkV3ZQbE5NcUV4Zm1o?=
 =?utf-8?B?Ynk0a2p3Rmp3cENIME5IZlk3SWEza2FGTkVlcVNVQWhHR09nT1haYW42b2pU?=
 =?utf-8?B?bGljaHI3YTE4K09WLzhiYU0xNHZjejk5UkxVdTZLRmRlYmgvQktsd01IRzh6?=
 =?utf-8?B?TGhmU2liZEt1VzJHeERXVHI3MUdIdnVERG5BSHhvaXBjR0FIeWdYZmJNbVBK?=
 =?utf-8?B?akd0dDFPNTZPczdPRGVmTGdCWHRIbVU1dXAveDM5OEp6TTNkTlRFTE1WVXEy?=
 =?utf-8?B?eFpXN3lCbTY4N25ZMlowWVRlYTFCM0w1T3NyS1BtaUhoS3RxeURNZEJDR0Ez?=
 =?utf-8?B?QjVRMlR5NjFBcTNEZCtCYnVUVnBWdG9EbEFnT3hISEN2RGs4WlQzZHlmMzg2?=
 =?utf-8?B?dEFnd0VNRlgzZ1NLRmJNVXY5TitmTjNYc3l0RjNHYnZ3a00vR3hTRjFrZ0FR?=
 =?utf-8?B?cjNvc0dKbHRWR2M3ejhzTGtOVWJucm5KYzYxMnVLQUpKclpnVTQyU3BlRERX?=
 =?utf-8?B?T1FySzZ2d0xKdUtmS01JK24zWi8vMm1ieXJBeExaMTFWWjIrQkt0T012b1gy?=
 =?utf-8?B?SlFJeUxaRE11ak5nNGVNL3ZSV3NwWnozaTU2ZTZQSDRjY0xlVTBhM1lqNkZD?=
 =?utf-8?B?cW00MHlOUGRoV2tJM2tUc1pLNkltQVlCb1RVZTZsa0l1MG5JUGlZcXdWNzRB?=
 =?utf-8?B?QUNWY1hRQmFneHA5SDhxalF1NUxIZExQWWMzeGpLWXhEbHRpUGFmSVdhRzhi?=
 =?utf-8?B?NWVTUHhLUm9WSGFuNXNGTkR5UzdZSFJxN1hKb3RhbGpaM3ljRkVOZ1V3aTZv?=
 =?utf-8?B?SUtEV0hUUmh1c0Y3QlBLeGtod2NRYVlKcitqL0MrWDZoMm51Zm5GQ0lYRDVN?=
 =?utf-8?Q?jE88/NUrdt4BGcigw/lwpF5hz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa1c5f2-fc4a-4fb7-4fc2-08dd5d0394b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 23:06:51.8440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJabLkKyVRyS8xhFlwsEUx7UhlyBfnK6alN4Ri3seOdyGiRDVis/k3WR2Mmo0cPvfuJqBNt7eC1LJlPBm2ePFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8872

On Thu, Mar 06, 2025 at 07:55:36PM -0300, Fabio Estevam wrote:
> On Thu, Mar 6, 2025 at 7:24 PM Frank Li <Frank.Li@nxp.com> wrote:
>
> > +&ecspi2 {
> > +       #address-cells = <1>;
> > +       #size-cells = <0>;
> > +       num-cs = <1>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_ecspi2 &pinctrl_ecspi2_cs>;
> > +       cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> > +       status = "okay";
> > +
> > +       spidev1: spi@0 {
> > +               compatible = "rohm,dh2228fv";
>
> That's not a correct description of the hardware.
>
> Conor's effort was to clean up the abuses of using "rohm,dh2228fv" to
> get spidev support.
>
> Please check:
>
> fc28d1c1fe3b3 ("spi: spidev: add correct compatible for Rohm BH2228FV")

Thanks! It is actually to get spidev. From commit message, I don't know
what next steps should be did, use "rohm,bh2228fv" or other method to
support spidev?

Frank

