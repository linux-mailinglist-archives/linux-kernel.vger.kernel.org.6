Return-Path: <linux-kernel+bounces-240333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7C9926C4B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8853B22A1C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9D7194C76;
	Wed,  3 Jul 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LOsf03ws"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A1E194A63;
	Wed,  3 Jul 2024 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720048037; cv=fail; b=Wzf8Ysz/ME4uz8HQxAnuYdABdpaxL9c6lpWorObdv8/tV4ZQ8tCik0wMbk4+yCK3I8R9u1ggwJpKNrig3FjWyzsr2CR+As9Tf1LP404cQQ3P7TvC6RA/dAPf9gq5d1UUWd60hlCzuADOGcWxMj6ookUwBsdf9MlMi81mSHd2nEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720048037; c=relaxed/simple;
	bh=5vDtFx+DHm0zcA/PSNjCFY/eT+9JJyq2x5sDuYfTuPU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Joi9i07xE62oXOevVsAo0EVVHrYW0N3/ZJ5kFDHI9rl5629rfA6yWAesCV/nzl690q2/a2yoXL4s4fxT10QVIVVmO3btmHnKGX7wyIlVu0UoyugMYZqjYwzNBYDxtHWtYDcK8iAgRvPLfilGWKnYHM6iUfdxZBwKAbuLo2wAa4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LOsf03ws; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4ykgN/gO9EVJ5oNon7V1PmxF2zQZHQHKIKooJy/FG8jmZkUnnkHQYrp5p4Yag2XViikH16zjLWwDEpsHmQVmlydQDBFjV5/nRMEDgm6gAJQkTiNxlN8PKFnE6HzO5pn1TRAQrxWZiOoDkJeui5QmaWPCmov2Nl8MZ0G9rsIxTSftA3IGeoweBxGYKdrLd1pSzh27HlsgZbnJaJ/iIDjSOv156Uk/LYn/7oUt9/XrZrsxipLSkULY4Sd33ObbBIoCZip/5dDYYvPp5Oht/3XjMj3tynf4AJTbx7Gu8nlHHWwHrhri+6+emWBJETVUoe54JK34NplXD1i+uNGyYo0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIQZ1yc+TDEWgVs047rPbtzCpYfhSM9I8sBhfLfdcDU=;
 b=QBJhKqXFvbKimBsobCvRdCCM8d8typd9sPgzsywoAgmkmq7FWFYJiWfBEzd9HP3wfWMGk+GVsZE4w0hZRITMfnBwrMfOFFmpIWlYP2Z44Ou9f9nsSR0WGzCKJCYQOVZks9rQG3hh09aOZzbsWimMVvPqx+Yr40M9pnohZEvM3s0ByLXnFNZ+flkETWaujzxez/podno7LO07Uj3pqIaJ4ts9EoV/6K2vL8X6Aoof07OfrxPt1YewJuyj116ckFrx69K1/08K9GhsxzfCwcZP8zbWyWkg364hUcdTQV2JppBfJy4rUdVgA3+xRDnGW0RL/ppPhCfUg4ahpND0mn/V6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIQZ1yc+TDEWgVs047rPbtzCpYfhSM9I8sBhfLfdcDU=;
 b=LOsf03wsjYZ74AYpvAAoOx1GyHLLMgM0hgGe04AheZYcBl8VGTo2WvgB3MIB5kCo0DnYsJUA3wfLTnnRNJ1Lc2avh5AvzP6w/p9sI7YwgqfNfYRy6H9TM9IKo4gCOWgssS1tSTWBP/AVkSMEUr7OWwqbprG8r5npTWHhLnDsEyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7242.eurprd04.prod.outlook.com (2603:10a6:102:91::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Wed, 3 Jul
 2024 23:07:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 23:07:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 03 Jul 2024 19:06:54 -0400
Subject: [PATCH 1/2] dt-bindings: usb: Add chip-specific compatible string
 'fsl,ls-dwc3'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-dwc-v1-1-9cbc93d49180@nxp.com>
References: <20240703-dwc-v1-0-9cbc93d49180@nxp.com>
In-Reply-To: <20240703-dwc-v1-0-9cbc93d49180@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Ran Wang <ran.wang_1@nxp.com>, 
 Jun Li <jun.li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720048027; l=1070;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Qx0Xwnto5tNKVQ0wUZ1MY1jw88Cu2FPkEttaCr0AIrc=;
 b=i6ELFCMV1xIKg+0DJx8d3wFL29xY6bGJUKu3hC2+73QkdRRrTn/6+f/upBE5oIjO5BRg/RVGu
 XyRNY1t47IeCvBGr24toFpUuKtH22a96VvfaEMysWwLMOq3C4boomN/
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:a03:331::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 07db3fd7-7af8-490f-7fa0-08dc9bb4e012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2I0TnZua0NpRG1VeVQyQUNqd3FYaGJmM1paMHV0aWZJZTBld3lvSytET21U?=
 =?utf-8?B?NkEzRGkwamUwbzdoN3R4V0Z6MlhmTndJT0lVR24ybytFVmRBaFFPSmFxN0tW?=
 =?utf-8?B?L1RBVnI3dU5tajEwY0NUKzArNFA5US9xbGpyd0prdHJSUjBPMWVUb3NZL09z?=
 =?utf-8?B?Tk1PTEVXaUZYZ2didmU1RHpSclVFN2NZOVEzR1hucGNLa242YlFZaXVicFIx?=
 =?utf-8?B?bXZpVWNvV25NR1ZzZTJ4OFI1WEVOalZWUUcwRnBVZjcxVld3QjUzcU5CemQy?=
 =?utf-8?B?K2RLSnpQR1V2K2V3L0RjUkhMWSs0aEk1YWlJQ0V2dTFPOHA3NE9CSXpuZkNE?=
 =?utf-8?B?ZVJUTkZLeXBKUDUwdFpqMVd0amhaWmtGOXBEOStrc002UlhZKzlVYmtxT2Ri?=
 =?utf-8?B?QmorK3kzZE0rUGY3Ynl3VVQzcVBnZjBWOWszVDBIR1BFc1l0bzVtTjA4c0sw?=
 =?utf-8?B?UE1EeXdzMjBabGJOVlBKUVRXVjlZS0dLVDUzVDZ3SjFJWkdNV0VQejBSekEz?=
 =?utf-8?B?MndkaGdtMy90Vng5dTVINy9ONlZ3dG9aRnV0Sy9PMnJpQ3NMNHNrbHh5ZjB4?=
 =?utf-8?B?S1U1TFpHS09RVWxZK05QdXhDK1lpTmhCMFFnNjVEd3FNZUs4NFRGT01vZTlx?=
 =?utf-8?B?RWNDQ2YySmJBN1dST2JHbXRucXlMNHlQWnlrQ1V6TkJmQUo0T2pQQ1RyZ1k1?=
 =?utf-8?B?ek5hRXFjUmU4eWt3VHR5c2VGaXhOZXlHK2loU1pDNW5NZEhCVWRha3Jjc25N?=
 =?utf-8?B?NklmU0tpbW9JVDNSVVNta3FncmlxcU91VlphNCtQQXFja3NtanNrNVduNXlq?=
 =?utf-8?B?Y2UxYjBVNTVxUmlmNDBnYnhCdUtEU095SU5mdjJmUGw2VU51bTNUcmYrRzB5?=
 =?utf-8?B?eHdXcVpsWUFIRVVYNGp5V29UcThzczQveDQrd0FYZnAxRXFkUmEvMngwK2tR?=
 =?utf-8?B?U3RmdnVrb242azgwa1VDWVFDZzBjc3hFTE85MnplZjlHVmNNQmdFNnVKMXlw?=
 =?utf-8?B?QnBTQ3RDbWduOVAvNjVYb0NsYUFZNkpVZUQxWFlOL3c3TSsva2l1MGZiaE94?=
 =?utf-8?B?RW5lTXkza3FwT21WaFVaYXJ5L3JQak0vWGFxN2VqTnlwQjdLVVdSVnM2eDB4?=
 =?utf-8?B?REFDTHZ0RytvZ3kxM3cxamVLVXg5ZUhJQ0hqczdYVDUrdWcrUlIxZFAzVTA0?=
 =?utf-8?B?SWVGZW1SUU9ZQnlWRm14VFBJSDFqTTlLNm5jeW5QbkRUNFFqbUlBN1ZhNWNo?=
 =?utf-8?B?N3k3TGhpQ3RMZENDOGdUVHhZR21FL21hdm5CbG1oTGdtTTRhWEVEYzJJRXgx?=
 =?utf-8?B?akNHRGFRTzl4cHlLUXdseTZQSGJncFUydWdCTFdQUHN1MDhRMzQ4ZEs3NGFJ?=
 =?utf-8?B?MytreUlsT2phMVFkajB0YnEyYnVvdlR0SFFIVnBWMDd0SjRKL1NaNm9RM0hX?=
 =?utf-8?B?NzBwTnQrdnN4WE9NQWRFb00wVWhYOTJCdjYxVkorZlpDbnRWS01yRXBQTUVK?=
 =?utf-8?B?RXlRd3FYRU5kQ3NwTUJpYko3Q0hFMUMvTWM3UklDU3NiUFoxVlEyeXBKeXBt?=
 =?utf-8?B?RVhwSkFWanFhR1lpM2ZydlNqYjYzRHAzeU1zaGpkSkt1UVo4Q3QyNVZMVHZy?=
 =?utf-8?B?czFjYi8rQ0FzMkI0bUNDelFLL1hkS0g5S3IrcUJLL2dXOXpSZzhEeDBrMkFq?=
 =?utf-8?B?a0xuSzhMRlhnRVl3UUFmeHJYa2x0K0ZyZnVWNEhwNG9LV1FwditQZCtQUWVC?=
 =?utf-8?B?TG5EWUcxek9yYVMxVHk2ekNaRkNzaEh4cWEreEhrVVFPbCtoVi84cUc3VjhR?=
 =?utf-8?B?d3htcWt1aEtvMDlLaUtjampqQVkrc1A3OWpGUzl3N05wdHhHYTJVTjhZYUNr?=
 =?utf-8?B?d0hsRDlGeHNrY0JvMGorYlFRTHAwdDdaWFJFeXlyL1dCREE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVBON2Vyd3NKaHljTnlHMnhwZzNkQUhJMWs3MUtzWGJGZWZINVlQWDVMWlh5?=
 =?utf-8?B?cC81L0xrQy9seUgyUG92RExCc1ZTMmgzdVJ6WnNCQldycU94SU13RExtVHdZ?=
 =?utf-8?B?Q3lUVVJweVczelliVnk4NWhBR0R2N2d4bEN1c1BRcmNxRHFTVHFDVWZ3eURk?=
 =?utf-8?B?M3VKSTZLL05OcldXVzdMbEdBVUdzODg5OThqbkZrVVlkTGRPU3Fiay9KY1Z6?=
 =?utf-8?B?R0t0WGNsZmNRV3hUN01IUXNRdzdtKzU4V0h6bmMxTW5Vdnk0dWtTUUFad2lW?=
 =?utf-8?B?K1NLampaZmJrbGZUVnBtYVVtaFpQS0Uvd1ZKZlZ0N3poV0YvRk56bURwMnF6?=
 =?utf-8?B?cTFiUFlPbGl5V3gxcFNtZjFpaHgwdERzRXk4b0RtK29BRUhNSkZaS2lrc3Zq?=
 =?utf-8?B?SHFkbVVoN1F5T3djdEVNVGpIK1BHZnQwSnJKRUVTVlV5V0RlbkxIZUpaSTlw?=
 =?utf-8?B?b2FmcTQ0RDRWaU5rTFo0ZzYvaFVsNnM1NFZNamp4TUg3eDc4UjVXQ2hpWW00?=
 =?utf-8?B?ZmdMUllFbFR3OGtLVHQ3SUFldTZUVnM4SFNlMnlzaUQ3UTU0OW5JZ2daM3Rx?=
 =?utf-8?B?aHROajRjZ2JyU3dhRFFXdzY1RUJGdkFQMU1ON2NKVWZCcnl5cW1hRDllWWZw?=
 =?utf-8?B?OCtuUE53cUtqTnlEMVhsMVdTV1VQV0lXQ0NvMHVhRS9vUGx4bVQyRTZGVHFS?=
 =?utf-8?B?QkNpSXRTUGljUytOQUNJUlgxYlNkcjI2VytKdDFqV1dIOVhOdmJYbkgrSS83?=
 =?utf-8?B?RTVHQzJaY0Z0SlozVGhJVTFzbXJWalJBQXhCVkwvWTY1WmNnbklobXI5d3pJ?=
 =?utf-8?B?R3JPOXdJTmtpMEhCRFhyZ3psaG9ib0tsSU9TNFN5WXJNMDlMMVdERHBwWFNC?=
 =?utf-8?B?OG1VaTE2YUVqOHRhdFBEOUNMQVVrcEtFcitPOGtRTllib1Q2YVIxNHM3cklQ?=
 =?utf-8?B?OE9RR2tybk5vdmtWK3JUU0s1WWhBakJ6WWVHMWd0NWhRc2sweG1SUTk4MmhN?=
 =?utf-8?B?VnNXVVJMSzZEZ3lWT2VEbGlCN3ZuYlloY0grKy9KNE4wS2x6YVNuQkZHT2hQ?=
 =?utf-8?B?MGtuaTMwNGNickNQamNReVpDdTd5TElBUDlUUC8yZnNXVUR5MEx2OG9xdnlh?=
 =?utf-8?B?ditXcEJEWmhlUVoveXR3WllWMVEzM3RRaTd0ZTd0VUZkZlBpcmMvMEc5NHZI?=
 =?utf-8?B?bExCL3kxSFcrNUZKV0NFdkh2cGt5VVpOb3I3aWw1YTIvaWNhUDRQeGs3V3k5?=
 =?utf-8?B?ZnpSQ3FBK3Y2QXZtM2pDN25JemgrVE5WUWJNZnRiWnBoYnhNUDY4QStMRVdE?=
 =?utf-8?B?Sk1HVGY2TnpGN1NPNFJjM2dZRnJsby9CKzJqZ2lMb3hFZWcrbkFiV0w1QXNk?=
 =?utf-8?B?dHBiRHl3TE5oZG1jaWRUR0RtUkxDQktqd21vZWFGWkcxUjVVc3p0N1JwL3Ny?=
 =?utf-8?B?UzREbTZkUzRNclNaWERlYVBHMXRVTFBRd05IUGlIVUM1RU9VWVk2MExLa3NF?=
 =?utf-8?B?N2x0ZzJTcFZBWDYxeGwzalBLYjYrRlNIN0FNNVplRVc3M3BNQXYxVTdFQ2NL?=
 =?utf-8?B?MEF6OFV2ZmszeTlOcy9nWWdKdnJ5VnBJUXpsOGhrTUxjckdFTE9yWU1nMEpa?=
 =?utf-8?B?OGtpZG8yQXFTcW5yZDE2cVhOUWdFSHZQQ0JYOVBwVUpsZ1pxNVFEMHM3V09N?=
 =?utf-8?B?OVRYeUd4QW5HMjJmbkZrRzNBTDQwSWV1QzkwODFJc1dhbEE3WmozVmtoK0Zt?=
 =?utf-8?B?YnJRdlN4OG5WdTY4MVpvZDFiYUhjSFJSaGQ4bmxRTVA4S2I4aXNERjd5ZStl?=
 =?utf-8?B?dTMwM1NRZnU4cS8wN0t6d3JHV0hxa3IrQ0dSTTRMMjQzNkRZYk5ja1ZNVHRS?=
 =?utf-8?B?V00rOW1YeDVnd09oTTVVUHlUN1E5V1BKSmRZczk0UEpaYkhnR01YQ3BVckxI?=
 =?utf-8?B?dytOVHE0M3oyZmtEK2lobUE4MmMrQ0RISU0wNFRHdzk4UGNhU2lKdHV4bFVW?=
 =?utf-8?B?YzRXUFFOQWF0QkRqZndNR2tSL2ZtM2wra1NGQ0IzUjJReitwTExXbW9TYVRp?=
 =?utf-8?B?aFdxTFhUbGdWUXVJR1RxZUhOY0cyWXF0SmdNdURuMWJrUzgzWjQ3ZTFnTWxq?=
 =?utf-8?Q?VBulDlsAopFK4lYx3ysywNkvW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07db3fd7-7af8-490f-7fa0-08dc9bb4e012
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 23:07:13.6424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3QSCR4yUyJ1O8TtENx16l+/E6NvS4s6hWeF8WEWCy1tYOAGWxhowduGQNow3Ttpq/6P6OLiqabQXri3LunZxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7242

From: Ran Wang <ran.wang_1@nxp.com>

Some Layerscape paltforms (such as LS1088A, LS2088A, etc) require update HW
default cache type configuration to fix DWC3 init failure when applying
property dma-coherent.

The cache type configuration is actually native feature of DWC3, not
additional desgin (or glue layer) coming from SoC, so add compatible string
'fsl,ls-dwc3'.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 1cd0ca90127d9..02cb986d0fd32 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -32,6 +32,7 @@ properties:
   compatible:
     contains:
       oneOf:
+        - const: fsl,ls-dwc3
         - const: snps,dwc3
         - const: synopsys,dwc3
           deprecated: true

-- 
2.34.1


