Return-Path: <linux-kernel+bounces-332014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB9E97B443
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 21:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD82AB2813C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B4C18BC04;
	Tue, 17 Sep 2024 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EA68B9P1"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E330165F13;
	Tue, 17 Sep 2024 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726600046; cv=fail; b=lCtRkpJh/V5xaIStigSB3n5tl/zIJGftSSI/H/y4uFDA9e0VSeB1AOrf88cOMI/LS5h9I8ExJWDYT28nK8POkaZTY68wNwsFglHXlzqZNQcFIpVBgY4w1fwZnEbPJ8JwlIfOkFhJv4I+BfFHCHOUNYm5iIdlmwhl2Myx8k8U9Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726600046; c=relaxed/simple;
	bh=W7yygunhbudgwkYbZ2iTOOYv1M8O0sGozZSAkwV4jRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W9kpXGIpLQSDzmp0rG/79Ms/SvSyMUHguUerVOW2bgTLIoSPcUiVYMxgTxdpocNxOyJ1/AHW3SuA3A3qysY0vKsbBSpRosArV8LT43e3CQNNlhjjn+0nmLleL6NQs64SEvR1SqVHDT9k2UQ88rd2hZnGjS1mTB+EoXVqXACkV9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EA68B9P1; arc=fail smtp.client-ip=52.101.69.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4FB8Tz8aKMuS3Kt/1VYSWmjRXtQEtIjXzRxZPjzLLj3ybUkczkmt2ZLdhPgE+CgeKEUg7W5Ju4JFYn6Y++wXBPOJWEqyfV/jzt4zOw43AamQjsbejitnwbiYLL/Xo6IS42pJsCxGgE+/O8qeecbDyXDGq760vDSCPACyADGzCCcYc3CFzHNYMDLbbaSmxwiwTt+6b8QkKUiYS9PI9NgRp6SLTJ9wUepJAcbSU5orZRbzJOiUGvuEAelQHTfvOaiuMeF942mBr8/HuZMK2nxKdlXYiR+1WIBANPOKDJOci0Mv4wJW1HjnuIk8qu7b+5E2XImB6I1syPEi0fVW/fkSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXN6q0z6VIuqzoaX4W7k3NPzwBvRrFsTSMiyRMzoPRw=;
 b=FWF2168mWCwdq2m4oLStpmBRsru5GfxGQxjygrkEqLJqDu+zp/y82qhISwN0P/6Bnc3IFFwuV/Tli8nMsgEWE55p936uDw2wPS0rkNHuqAtKEIwbpvk5UTkUQSMltwOAuRMtwD8xFjky50pEa1f/ayOclKfa9qvjgSFZuPPuXI0Iri+cTag1reZboDCmjeGIw4n7gDfyP9jw5T5i+EFUhTJHrxXYSgNq1Mp9uEpR/uFqGJcto2wv+Y/vNocjteiDfL6kq8W0F27QTDzWDZw/bfW0DW4tqsLVNPzfU/3uymKoaQ1Rw8Ggl0s8li36DHOL1iXBkd/7P6P7kfttRvkVvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXN6q0z6VIuqzoaX4W7k3NPzwBvRrFsTSMiyRMzoPRw=;
 b=EA68B9P12LFwE3/zAsstJswHrHhq7dXi7Q39F/FthVgKRFRfL36/5Z11prlQAa8RSEOgUm/cMupi6Oa1xV12sWoiPqw0kPURb/D4eH5cgkYIOYbaNXniaCAWDiGy+zwYVyBYvdlxgxlW6DRORGp2zt2mrYVYE1KCpy129aF39/1zfXRp4SC4vBEAKpa/0z7yKygWayb2AYQwsVoYijWBlhpxYL6B8I0swbB/S6akHvIssDsChXdT3UIlX7iyvjANcHetzkM+dfN0l7PnQiPW1YfraJCwK8pJ4cs8dG/4vWePRp3+3HoRUfGzLoV8T4XW5IXN681CEl3TPAwcDUe/dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7066.eurprd04.prod.outlook.com (2603:10a6:10:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Tue, 17 Sep
 2024 19:07:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 19:07:17 +0000
Date: Tue, 17 Sep 2024 15:07:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>, Petr Benes <petr.benes@ysoft.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Michael Walle <mwalle@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] arm64: dts: imx: Add imx8mp-iota2-lumpy board
Message-ID: <ZunTWqY6oLZibZXj@lizhi-Precision-Tower-5810>
References: <20240917151001.1289399-1-michal.vokac@ysoft.com>
 <20240917151001.1289399-3-michal.vokac@ysoft.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240917151001.1289399-3-michal.vokac@ysoft.com>
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc16dce-9a58-41ee-c907-08dcd74bf26b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekR5dTNMU25QNmN0N2JETXNnVTNLSGo5c3RmMUh0elY1NnVKdDBsQS9JUXB3?=
 =?utf-8?B?VkZtZzF2bi9TWXpyZUF1eWd4UG9OY1hOMWFhaEFtb0k4M1E2aEg5Z2NmdGlI?=
 =?utf-8?B?RHE3SklBeWYrSHlGcnF2RERacXVjMktsUjBKaGxpVndPU0o5MmlNTU81eHll?=
 =?utf-8?B?d1F5NlVnTTV5cHViLzM0R3gwK0QwUDB1WFlSYmxCNHRuc09CY2RjSDRnYWhU?=
 =?utf-8?B?d1I0eENiUFFmOGtERHVhWmZDaVd3a1dqU0RTRUVadjQzVFZtOEt1MDdibWJN?=
 =?utf-8?B?VUlvWEtlYlYrYXgrbXZwc1h5Smx1b3huazdhaHRFVW1XZFVvTU1yb2JicmVJ?=
 =?utf-8?B?eVZOVU9QQ1daRUJNekFWek91MkV0b3Y0RjBmN3FEdlRJZmdOeDB3SGRmdG9a?=
 =?utf-8?B?RTN1S1RkV2Uwc3RoeEcxWVhHd0VYTnZ5TVMxOFBKMFhiWGFyTHpXVWZiSGk4?=
 =?utf-8?B?c3A3UTE1MUhBL25DTjBJQllSME1KZmEvYjdyb3d0Ukc1SUZQNFErNE0rWmxr?=
 =?utf-8?B?dEdWT3lpbnFLcDVqZDcvZ1JhZEpHdHJ2N0MwNmsyb2pPN3VQYThFemQ2Sldm?=
 =?utf-8?B?ZEFvVHJoRVZaVTNDR3FHV3E4Nlc2N0l0a2NpOWpSR1hmWDhrL2xyOWhCSWhE?=
 =?utf-8?B?ODJjcTIzV2xCL2NuUmZrQW1tRW4vVnBzeVdrbHNaY3lxOGFuUm1ZS2tQRkpM?=
 =?utf-8?B?MVNvbzF2YmQ3QktOV0ZKY1JrMFRCSm5rUWRJTEh3d2VKMUJLUnBENDNtckV5?=
 =?utf-8?B?TnBOck5hQkE0SEI4eHhPMHBuNzJPTXFpbjdQZENlaXZUK1ZzMWEzSWltaDhE?=
 =?utf-8?B?TGc0YWNBQVNUdXB0cVBrbkpWNzUxMEM4clNlSklOZ2h3SHJmRnZzZTFZMjNR?=
 =?utf-8?B?MEdXTHlnRmJnWlFlN25zZXkzSTFwQURmaGdpV1F5NWdUSit2eVMzaFVFZC96?=
 =?utf-8?B?eUZIMHVVUHlDc3dNOUkzMGQvTFlWdW44akxnZzBWUDlMRVR5RHA0S1UxejZn?=
 =?utf-8?B?UC9CR0Fmdzk1dkZNUTcvbEdMNDBQQTV3a0hsaFg0d3JSd2d5Qy9KeVBFQWtD?=
 =?utf-8?B?dTRyUDhZTmdFek1jdWdkblB2dk55TGZyakNGV2g2R0hBQXM1SXVJWmtUKytD?=
 =?utf-8?B?L1FTM0dPSkVIUmJaVzRPWmFjS1dBdThCajFLd1VnVEdLdGVVaDhBdnJwbGtl?=
 =?utf-8?B?Sy9ZTjRYUFBOVldSVVFwV045TDU4YTJuUFNFVjltRWNTSkdwbjdHcy9TcldR?=
 =?utf-8?B?TmlCRitkaG9yWHl6ZkZHLzcrOCswZUoyb2EydEZaN3QxRG9rRDJWUE9telp1?=
 =?utf-8?B?VkRDUHZ3N1UzMVJtNDZaRDZvYkVMUGc2TmpVQWFYMzBPcTZvRkFOeVVVdERx?=
 =?utf-8?B?NHVvZXZ2R0tDWFA2RXpCLzhTWmpBaWYvWmpvOVFPTkVJVXdZcHdtOFh2WWtt?=
 =?utf-8?B?QVdqNmdlS09KNlBKOWpNWWFXZjFpaTdSSU51Ym5ucE1jbHExOVk2ZTdtV1BR?=
 =?utf-8?B?SzdTRklKVnNEQjZndElpZGdzYkV2THRxZ2EvdlFnN1Jkc2ZuL09EdjFtODdC?=
 =?utf-8?B?LzlnWmV4VU9rRUdaL3pDUmJMb1p2VHJFWkdhMldOcGNsQVFKNmo4OWVyakJl?=
 =?utf-8?B?UjVUNkh5REw1U3UzakhRYUpjSHZaU2trQkptL0JpN3dQUnVjT0hwdjByL0FM?=
 =?utf-8?B?M0tXRG1MMUk1MERxdy9UOHZ6TEc2VkM3ckpSZlJNaDJlZzUvYUpBRy9Tajhp?=
 =?utf-8?B?dHFlMHdXTnh4NkVBVGNSb1RJN3J5MGF3OGNVUVBtUXRCSFZpWksxc3JzWThW?=
 =?utf-8?B?UEdLTm8xL2hCbUErLy9wNDV2VlFHZ0RjalBtYUMxeitzY1VoSHNISFVvdDJM?=
 =?utf-8?B?WVBLbHRaUnh2Z0ZMVkg3ekFZRzBpekpYSC9mQ3hGajV0cFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUdaQVl5NGU4SXdEbTFyY0YxK2FSNHlTdTAvTDZLSEZZUkVzN1JKdWFrN21N?=
 =?utf-8?B?c3VUY25jMVNNMWh4c25mTUZDRTIwcXJzSm1IbXJOMGlTNy9aendsa25WcVc5?=
 =?utf-8?B?aVNUV01OYUJFL3ljYUgrSHAzQXF4M2x5K1Ntb2srOHVVaG9zTmI4NGF0Mm1x?=
 =?utf-8?B?NU5GOW1nZG1lcndwSzQ4K3ZxNi9JeGg5czUzWE91Y3krY2hRMjZBR0NjSnh0?=
 =?utf-8?B?dE9wZ0NlL0xKNHB5Si9sWEZoamdSU0RNR2RqbC9SeHRPMkJSaGtnUjFBMzQw?=
 =?utf-8?B?QnFIVEpST256bjl2d2paeVB6dEQ3dTQ2K2p2YmF4UVg5RkJSWnU0OEw5ekE1?=
 =?utf-8?B?UFk1bHl2S2xTaWkweTdTaStWNUdWWXJEbkE5MUxPT3dHNjlHSkdobW0yUTdR?=
 =?utf-8?B?T3labXhBQUY0bDRPcVRiUTFWam1SRDYxc1VDMWI4ckpFTHBnRzlrWVdUY1Vy?=
 =?utf-8?B?WWIxd0J2TEprQ0tia0dvMVdacC85VE1UMmtqdEt0TGErRHVYc3hHQ0M3Vk9h?=
 =?utf-8?B?SVZpZnFZR01LdzRNZ3NqR0Q2ZE84bE9SV1lYTm9vNDUrSkhHcmpOUmVrMGlM?=
 =?utf-8?B?OHlVSUF1YjE2V3MwWkdSTlpMU1ovcXcvWXhyc0VQbCtoNmlQY0MrODhtcG93?=
 =?utf-8?B?KzRYK3FBVGVlVXlqSXVrYklVci9jTDZUbjBDOWtLQ2lqTkFlNDhWZUt6Mklk?=
 =?utf-8?B?Mm85bEduR2k1SXZYMVA4YUhvRzVYdVFmNVZoZk1YRnZVRHVIT2FOb2UxU2Rw?=
 =?utf-8?B?aSs3T0FQOWdyVTFaU2NIajdGZ055b2ZPY2pZQmxUQjRyUnhBRDlOTDJJdmRE?=
 =?utf-8?B?UFB2bW9pNnFwRkluNkJQWk04SkcvMmV4R2NtN0JhSE94QmpNTkc2WjM2UjJy?=
 =?utf-8?B?ZUlYcXZQV29LdlhnOWl1cUFXbGlHN2F6Ky9JU1Rla09xejlxZFkrM1V4RHln?=
 =?utf-8?B?K3gyOVdGWnVqTThkNlM2VWtSUHRibmR5UGNHVlRrb29LWENzYXdWR1ZidGph?=
 =?utf-8?B?Y0RBV1BqUlpuaU5PeXNyTkpTck1WdU1uRVZ0MlJYc0Iza2l1SXFyQUdvbEw3?=
 =?utf-8?B?OTkzZkdJOEVSbVc2aVdTR3pQaVMwdkFvUE9kbk9BL1RmQ0xid1lzSHJhMUtV?=
 =?utf-8?B?dkw0NDUvZ2RkbSt5REFuV2Zoa0t0Z0dtTEMxRi95cW5RU0RuK3E5VFE5SXZS?=
 =?utf-8?B?elplek1GU3FyaFhFZmhaN25kY0RGWWV6STQ0c2gxY29GZWV5dHhBS2dOYi9k?=
 =?utf-8?B?OFNVOWlsM0N6aHY2NzR6bHZhMFY4Sis1MFZyK1d4cUpPNEIvcnVWNG45anZM?=
 =?utf-8?B?Mys2RnBlZFhtM0k0T0VUMys2dk5FZ2prZzdkY0NmcjhXTzIxaW03SGkzeWha?=
 =?utf-8?B?aUN4UFVNUVRmV2czenpmL0hJMklkdXAxaUlZM2NzOGtlL2NtMzRyYVNIeENy?=
 =?utf-8?B?UjJEWnlIZjI4dktWaDUxaWpZNFVZcnhwRWFiWGdwc083cG9hSkR0YVN5enFs?=
 =?utf-8?B?NGFFL1IxeEg3dWl3NVlOekVxcHlsVVNKc3RSRjNMZmtESG9BZTBRNGNWaktt?=
 =?utf-8?B?c1laVmkwNGx1M2VhYVA2SHdoU3ljTHJqZWtSamVxRmxrdDVFcHVlZE9BcGJ2?=
 =?utf-8?B?SWpxMjdzeWdEcFJTYnk0dWZ5ODc1cUdDU2RzclUvZUhUSGdUYUZhUW4xQkNH?=
 =?utf-8?B?TzRJcU9EYyttZ29yV3dlZUNaYldnekVkWDc2WG8wOXFORmJUSFkwSjl4dFZF?=
 =?utf-8?B?Nktvd0xkUHNMZHluaWMyTWlVTzR4N2M3WjJBVEtqa2VVaW14bG1hcmpNdXBI?=
 =?utf-8?B?UlVmQjA5L0p5TllDKzgzOStaTFgzYjFxenZXVnRyQ1FIQ2dvdkwxT2tyNy9t?=
 =?utf-8?B?M0dYcElCY1ZhZ1U4czBiTExBWnN2SFJaYTl4QThsM2NkYTRHMzh2T2IyU3ZC?=
 =?utf-8?B?VzVCUE42enJETjBvalRGSVRERmpzRHlLc0MxOGZNK2pSRHVxWkdaMXZONllh?=
 =?utf-8?B?bVNaSzVTVGZRcW1UaUcwd1dDRUIwTjYyYWdiaXlENVRLMW9DK3RRRHVMdnpR?=
 =?utf-8?B?QTVoZlkvaUFDek5acXN5bGxxRm5OMDN3WS9OWlJBNVlOdmlGaUZUVjNYamtY?=
 =?utf-8?Q?9vFx+qwD4cO1DCFkxEGSi5Gn1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc16dce-9a58-41ee-c907-08dcd74bf26b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 19:07:17.1840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRGyDJVepIgzvI4L4zmop2juvgV28jju8MjpwYmEHFKKEimQl4pUxaS5BgZgHNgbPis6aeTTWdEB/GZquAVd5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7066

On Tue, Sep 17, 2024 at 05:09:59PM +0200, Michal Vokáč wrote:
> The IOTA2 Lumpy board is based on the i.MX8MPlus EVK.
>
> Basic features are:
> - 4GB LPDDR4
> - 64GB eMMC
> - 2x 1GB Ethernet
> - USB 3.0 Type-C dual role port, without power delivery
> - USB 3.0 Type-A host port
> - RGB LED - PWM driven
> - speaker - PWM driven
> - RTC with super capacitor backup
>
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---

Suggest you try tools https://github.com/lznuaa/dt-format
to make sure nodes sorted.

Any issue let me know.

Frank


>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/imx8mp-iota2-lumpy.dts | 425 ++++++++++++++++++
>  2 files changed, 426 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index f04c22b7de72..421c36c5ae68 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -171,6 +171,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk3.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-iota2-lumpy.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-navqp.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
> new file mode 100644
> index 000000000000..21d0899cabd5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
> @@ -0,0 +1,425 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2023 Y Soft
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mp.dtsi"
> +
> +/ {
> +	model = "Y Soft i.MX8MPlus IOTA2 Lumpy board";
> +	compatible = "ysoft,imx8mp-iota2-lumpy", "fsl,imx8mp";
> +
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +
> +	beeper {
> +		compatible = "pwm-beeper";
> +		pwms = <&pwm4 0 500000 0>;
> +	};
> +
> +	gpio_keys: gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_keys>;
> +
> +		button-reset {
> +			label = "Factory RESET";
> +			linux,code = <BTN_0>;
> +			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000 0 0x80000000>,
> +		      <0x1 0x00000000 0 0x80000000>;
> +	};
> +
> +	reg_usb_host: regulator-usb-host {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usb_host_vbus>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-name = "usb-host";
> +	};
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&reg_arm>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&reg_arm>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&reg_arm>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&reg_arm>;
> +};
> +
> +&eqos {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_eqos>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy0>;
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@0 {
> +			pinctrl-0 = <&pinctrl_ethphy0>;
> +			pinctrl-names = "default";
> +			reg = <0>;
> +			interrupt-parent = <&gpio3>;
> +			interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> +			micrel,led-mode = <0>;
> +			reset-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <1000>;
> +			reset-deassert-us = <1000>;
> +		};
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy1>;
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy1: ethernet-phy@0 {
> +			pinctrl-0 = <&pinctrl_ethphy1>;
> +			pinctrl-names = "default";
> +			reg = <0>;
> +			interrupt-parent = <&gpio3>;
> +			interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
> +			micrel,led-mode = <0>;
> +			reset-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <1000>;
> +			reset-deassert-us = <1000>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pmic@25 {
> +		compatible = "nxp,pca9450c";
> +		reg = <0x25>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +
> +		regulators {
> +			BUCK1 {
> +				regulator-name = "BUCK1";
> +				regulator-min-microvolt = <720000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			reg_arm: BUCK2 {
> +				regulator-name = "BUCK2";
> +				regulator-min-microvolt = <720000>;
> +				regulator-max-microvolt = <1025000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +				nxp,dvs-run-voltage = <950000>;
> +				nxp,dvs-standby-voltage = <850000>;
> +			};
> +
> +			BUCK4 {
> +				regulator-name = "BUCK4";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			BUCK5 {
> +				regulator-name = "BUCK5";
> +				regulator-min-microvolt = <1650000>;
> +				regulator-max-microvolt = <1950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			BUCK6 {
> +				regulator-name = "BUCK6";
> +				regulator-min-microvolt = <1045000>;
> +				regulator-max-microvolt = <1155000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <1650000>;
> +				regulator-max-microvolt = <1950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			LDO3 {
> +				regulator-name = "LDO3";
> +				regulator-min-microvolt = <1710000>;
> +				regulator-max-microvolt = <1890000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			LDO4 {
> +				regulator-name = "LDO4";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			LDO5 {
> +				regulator-name = "LDO5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	rtc: rtc@68 {
> +		compatible = "dallas,ds1341";
> +		reg = <0x68>;
> +	};
> +};
> +
> +&pwm4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm4>;
> +	pwm-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +&usb3_phy1 {
> +	vbus-supply = <&reg_usb_host>;
> +	status = "okay";
> +};
> +
> +&usb3_1 {
> +	status = "okay";
> +};
> +
> +&usb_dwc3_1 {
> +	pinctrl-names = "default";
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
> +	assigned-clock-rates = <400000000>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_eqos: eqosgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC		0x2
> +			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO		0x2
> +			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0	0x90
> +			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1	0x90
> +			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2	0x90
> +			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3	0x90
> +			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x90
> +			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x90
> +			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0	0x16
> +			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1	0x16
> +			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2	0x16
> +			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3	0x16
> +			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL	0x16
> +			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x16
> +		>;
> +	};
> +
> +	pinctrl_ethphy0: ethphy0grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21		0x10
> +			MX8MP_IOMUXC_SAI5_RXD1__GPIO3_IO22		0x10
> +		>;
> +	};
> +
> +	pinctrl_ethphy1: ethphy1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI5_RXFS__GPIO3_IO19		0x10
> +			MX8MP_IOMUXC_SAI5_RXC__GPIO3_IO20		0x10
> +		>;
> +	};
> +
> +	pinctrl_fec: fecgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x2
> +			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x2
> +			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0		0x90
> +			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1		0x90
> +			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2		0x90
> +			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3		0x90
> +			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x90
> +			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x90
> +			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0		0x16
> +			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1		0x16
> +			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2		0x16
> +			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3		0x16
> +			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x16
> +			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC		0x16
> +		>;
> +	};
> +
> +	pinctrl_gpio_keys: gpiokeysgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07	0x80
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c2
> +			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c2
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c2
> +			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c2
> +		>;
> +	};
> +
> +	pinctrl_pmic: pmicgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03	0x1c0
> +		>;
> +	};
> +
> +	pinctrl_pwm4: pwm4grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI3_MCLK__PWM4_OUT	0x102
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x0
> +			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x0
> +		>;
> +	};
> +
> +	pinctrl_usb_host_vbus: usb1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR	0x0
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x190
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d4
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d4
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d4
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d4
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d4
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x194
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x196
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d6
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d6
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d6
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d6
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d6
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x196
> +		>;
> +	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B	0x166
> +		>;
> +	};
> +};
> --
> 2.43.0
>

