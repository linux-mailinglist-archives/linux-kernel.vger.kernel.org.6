Return-Path: <linux-kernel+bounces-445539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E359F1789
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C19188C369
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0729191F6C;
	Fri, 13 Dec 2024 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KmIEsdeo"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D515A3207;
	Fri, 13 Dec 2024 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734122787; cv=fail; b=syA+qa82PMFiS6gMsbs2yyoCYMSrSwb9mW62KR6dbbQY1YXv/I4yD697PSQ5xEPD++zJI/2kq2tIYK4kI68caGrQyl+cT052YMHfZIfh14Q48LPh3YqBtTqQ+i/IvsPkYYHxUTz3VU5KaxOCilr9zMxbxMd4LqLNT61uhF/TNzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734122787; c=relaxed/simple;
	bh=MZKJo8FjS2t3VfdKde5Rv/sprxb/2ZIrZrzzARfp1xQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=oVQjvScO6wahwUw+qWeNGycV3c5e50hYnb/8pg2q7jZAebf+G80ewvIyMm7nOkO4TmEQK0H+X1f8QD446L32mupL4ZTERU7L5rVpeH+saHNBtLJbdj0WZnt0MP+YOWjhIIO8BfBigQ8o5gTX/ws3D2dL7dkDUok8LfxsO7NbZnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KmIEsdeo; arc=fail smtp.client-ip=40.107.22.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMttqP8Gae8kwgvwwib7HeFKQI+YFAa9FCd7NynzOc1v6aQjWM4UTdiJ4icYP9xWDyi59FQU23PLGM93isurBuSpNjpywv0VVa4ZJ1JhVnDKLT6tjhKbX5dMPbyUKUciv8uJo9s+D3tJ24xwfo5x3NeOIH6jWPP/6z8XrATKktuAfrL5vG4ZGK5EPpNrP5WytpJ4vYLNrPiBITRBLGtgBWvT8XXnikeAJJX5ssDKc56+l670tU8HLn/9yWqrIRuNN7k9g6ZVwRpmIEmA5ZSIqPzOxCrQKnbT+mzQW/6Q0iBrfPVfhj4dK4kqNjDoj8vIVbiOwZxA8SBp4+/O1Vcu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Elql48jI3pUJdQn7+6qk1eAEu240zHA1NWivOSiBHDU=;
 b=CPbF6os1Su54ZpRmu/5xGXINYNZyG0UlGhpzk8W5GEiJavrFUjfzJpwygkUZFfx+QxKQxp2d1JFQjeGJx/0FS2cXcmRmZmfE0iEJAJou3dyRQ0Y2BABhKg9VllSSuwAAL3iicRR0AYd1bFaY3+R+YTqZ0Yz0mLIX6hJtDhCv1Jgd/OITUpuKuOfwBbFD66bG9M56aFdchTYqEzErqcsZjjFxa6tbzIfAZxK1+a0ldVDGTBW9oeujf1y1AdsoTk6OSXszvlvWvWExhgx5JS9xVfw9fQ+iDAMyWzydDL8RU3aKr3vuH7ZKFzPCZGtg8ocs7J6IWnnNh/dYhSaNM+0KHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Elql48jI3pUJdQn7+6qk1eAEu240zHA1NWivOSiBHDU=;
 b=KmIEsdeoZY9NsGMFRi7RY8EVtl2Ur1B/OnyMPiNbTqlCNx1pLI5iFG1MTAM+vBJWILWQNl6rS9Z2LqlzD5S9IS0PfA9RwJE1v8PGSvGdGbky3C7rHrjiokWMkQJ2jAlt3qRqAzBNodA+BFGrs5QG4vbMM/oydYyiwtI9tG1AjRpnjNGvsTw1w503MVzum2iPbU1drggjeM329UW5PH0elQCt5kcRfwpbQ6s8jDfbjORMi3lm3g2dYYWE3KT5Qg/lIg8mvw03z661TT6+jgUD2qlYgZov0Bbq8hn3iFyAs67r0JXj/qNSDElksWmK5Vy+2NTCktNNNvzw2UMr8N4jOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10215.eurprd04.prod.outlook.com (2603:10a6:102:409::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 20:46:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 20:46:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/2] regulator: add new PMIC PF9453 support
Date: Fri, 13 Dec 2024 15:46:07 -0500
Message-Id: <20241213-pf9453-v3-0-5587c1693155@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA+dXGcC/02MQQ6CMBBFr0JmbU1naCt15T2MC6SDdCGQ1jQYw
 t0tJKjL9/PfmyFy8BzhXMwQOPnohz5DeSig6er+wcK7zECSFJLUYmyt0qWwkit3d7U2VEM+j4F
 bP22h6y1z5+NrCO+tm3Bd94TZEwmFFMjKVBpR0Qkv/TQem+EJayDRn4T0lShLrbaOGmlNqc1PW
 pblAy5EOB/PAAAA
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734122778; l=1316;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=MZKJo8FjS2t3VfdKde5Rv/sprxb/2ZIrZrzzARfp1xQ=;
 b=SgcvV+ZKXsN1MvgVphKH01gFhoAoUi+mawNDFsYMR0k0XeqXypz1P0IpM4Lpo5MkquQBeRPOF
 OnHov5CuEEKDMoxqDcIIQmqrkHag9IXKgRI1nBId6PtxQnXaDqGYccJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:a03:333::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10215:EE_
X-MS-Office365-Filtering-Correlation-Id: fe208e75-f8e3-401a-842d-08dd1bb73389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEQwN0pJbkJvVUFzdnhkYy9tOGpjdzIxMXpwVTJEbWc1eVpFeW5meElFTGxU?=
 =?utf-8?B?dUs1M0VxOTJRNHNmak9CMktyUEZwOHY3WEhGaHBMeVVTUE5pSTZqeUtKWHFF?=
 =?utf-8?B?OVE1dlEyVFdNMWtoYkhOSUg5UVVJSWh0UFVBQWdmQm9rclpiOENEK0s4aGJw?=
 =?utf-8?B?cHJqcFVQSE1PbW02eTI0d2l3c2tjQmllUU9Na0hxYUw3R084TGhKOCtEelpI?=
 =?utf-8?B?ejNpaVJhWG51ajJwNjViWko1eVRORmFXaUtsSTRrUktMU2ZLVm5pMjVObitP?=
 =?utf-8?B?bVFmUEsxNEgwY2RBb3VJeGlyTGtzQjF5THVKODNIM2Q1ZEtTWHo1dWU0dzc1?=
 =?utf-8?B?SDBJNExQdzFrbFVpMExpSytGUENuMEM4OFVjcFd1OVdsU045WjdyamQyS3gx?=
 =?utf-8?B?amd2T0J5dHFLcHIrSmtuRytQUnlseG5VRzZsQWMzT0dMZWN6UjNibjNNZzdG?=
 =?utf-8?B?MTVhOGdXU0JOaDdIT1ZPVUtjYjg3MFZZT01kbVB5Y3crbXZ0L2drSXR5NmpT?=
 =?utf-8?B?bm8yeDFzNTVhZXBiaXQrS3ZLRm5FNmJPT1kwYjBQNW1MRm1VeGh0dFBkQ0tH?=
 =?utf-8?B?N2N2T3FzVlhRTVdhNjhZTEFCOUJ2eWJiYnRObGExNk9mYmxDVjVPdFJiRVo2?=
 =?utf-8?B?TG5zbmVxUjNNQWdEMmR1RFkxeVMxakN4U1dMZ0d2Zjc0MmY5dkMrSUN5MWt1?=
 =?utf-8?B?Qkx6Q25Jc1k0RGxhU29vZURhVFI1OUI5WFhzWTUxKzA1L2szalJHRzkxQmgy?=
 =?utf-8?B?d0svUU9SSFVkUytIR0J4S3ZiZ0loKzhxNk5TMzdmenNwL2xIV1hyWXVmUDBI?=
 =?utf-8?B?Z1puRSt0bGU3cE9OWXZPUmZuNFJWWjFZQiswRXVLaGFUUjFoN1h6UTdjR1dz?=
 =?utf-8?B?RTdUcEtKVFFDd29EY1piZDV0MCt6VmhiLzAyRkUyMkRsbjZvSzJRbzMvZUNl?=
 =?utf-8?B?TU93cTRTbW5mUzcrVWhzOFdGaGxWd2EvN1ZKVlIzd2NQQWs0UStqNGhFLys5?=
 =?utf-8?B?a1FpT1pRZ1RVK3pDeTdtcXNNZjR4V081T3hiTWsrbytJUXh2SFhKdVBpSzZl?=
 =?utf-8?B?TU9POWczeE44c0xraFhjenR6SlpobGF6eDRUNUgvSGpxM0w2eXNPb2lWdTVO?=
 =?utf-8?B?RnhGU1dpWU82WTFER1BsWVNXMlo1eHBzN0l3NmhrNlU1WE96cTZnRG1xZWVy?=
 =?utf-8?B?UkN2WFh4SGdlaFBtQ24vSkZlOUltdlBiOXB4dE5qOXo1Vi9IOExhM0lmRG44?=
 =?utf-8?B?djFxWG9BRVFIRUhMNXdSN3Ntc1p5WjZoWFZJanVSRzlQQUV4RE1COEM4cG1h?=
 =?utf-8?B?bkZEYWxibC9meS9EWE4rdFlJZnhzLytCV1ZuNEg0RXBFME5zY2hPTUVHQ1lt?=
 =?utf-8?B?b0ZuZ1RCWjhxZmdoRnEvZVlMR2hTUjh0THFHMkkwank0U29hbFBiVzJNbTZT?=
 =?utf-8?B?bnJPd09FRWRHQ25YYy8wMGs1UVRBMkFjbmtqS3JyMXkzR3pRclVQYXJJWEtl?=
 =?utf-8?B?T1ZoeUowdnJxRThvNU80dk91WVY4RDlpUzFZRTBtMlB1dU15Q2ErUUFoRDRo?=
 =?utf-8?B?aTJXTkQ1d0w0Uk0vbmZ1bG9xakFvTHpLUzU5SzNHMTAvdjlhVURuS2pkVXgy?=
 =?utf-8?B?ZWtiQlF5d2VnRXA0NHE1UFViNGQ3ZW82a255VUZEeVFEUVNVTE1xV2tsVjND?=
 =?utf-8?B?NkVNYWl5MFM5ZTdmcFQ2bjhIL2w0R21LWjZkK2llVWhOUksyWEJvNW9ERllB?=
 =?utf-8?B?WnJVT2xsdzZWL240a0RTVnV3QTc3R1lkZFVEOXZHcHJJampHbGJGSFFBZ01R?=
 =?utf-8?B?Tk51QStrNENDamlyS2ZWOVFBSURqZDV4SzJaRXBVNm1NSnA5cFUydFFIZjAw?=
 =?utf-8?B?RSsxSWIvb2NsWjEwWFA4ejRoUUUwSVI5TXRYeDduMVZLK0Q2VTNObjlmRlVl?=
 =?utf-8?Q?axIw8g6c7O4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SS9oYmF4MjFhREdlcTFZWlgrakVWb0VLMG5UeWUvd3lvN2hHUjVkR3o0TGx2?=
 =?utf-8?B?MFBuZHlVakFRYkZHUXM0K0ltcWNxZ3BaR2pwRE94L2NXbG9zYjBrZGlMQVJG?=
 =?utf-8?B?T21yaTI1YVNsQmZ3d0ZuZVd3WUtWa2RaL3NyN2VhMG5NSGM4VWFpL0d2SXBx?=
 =?utf-8?B?ZVFBOUpaRUgzZVMzZG9FUGdTZlMva1k4UzNuVUZQRWNUQUgwWmZNdXdRWjRC?=
 =?utf-8?B?MlE5RzJEUUg0MEVBZ0JYbFR6anRKREdEVVNCbDhLNTVGZWFRV3pSb013WXJI?=
 =?utf-8?B?K0JUT0xpZXhUaXd5UVJCK3Y5TCtGa2JKK1hENlVta3V5SFNZakxsczRGd3o3?=
 =?utf-8?B?MWZTVi9zWFVNQXVOMjNIN1ExcmVCcHZmaVlSakU3M1AwYyt3bXpIdE9Scm1s?=
 =?utf-8?B?akZjeEtDNzc5c05LSEMyWG5oK3NIZHByYXhja2lIdVVYRXBFWXZaWVJCemNK?=
 =?utf-8?B?L212Y3RpR3g0VVZoMDdFQTJ5bFlncDFobCtzV3hzUUYxVG41Y1h4Y2VPWnVU?=
 =?utf-8?B?LysrYXdmV1Z0TnBsWjYxUm13blRNNFkwWWl3RWpQWXcyWTIxVmpzVmVlL3VG?=
 =?utf-8?B?QmhTeHNsU2pLSVRZeWJQK2ZBTnRRaHo2eDk5MkdEZjdMNGZ3ZDZwckhnOC9y?=
 =?utf-8?B?dlVPMmlxVkJkeklrZjVrNHpsc21GNnNPK040UHJmVFBLTUVPRXpKSERoTWVF?=
 =?utf-8?B?MzRqQXVhOUphMVFHSHN2SndmbGtwamJ0c1RjNmswT1JCa0M0UHJZOGxxTWhj?=
 =?utf-8?B?YzNtNGZNVXJwQW5Dc2hUMTROSG5hRVVxR2RQUmRHMnpYajl2eklXTU1QL3Br?=
 =?utf-8?B?UC9UcjJOdWNacGc1QjBJSWhYQWNsTWlEdEdNTmxrQ1plTjJ2VThnU1ZQN2Mv?=
 =?utf-8?B?ZzF3djc4MDR0VVlscHYrVmUyUG5vdW1BY0x0b1dGVEUvNHZWWFh1aER4Q2JM?=
 =?utf-8?B?UTE3RktnYjVEbFZ0M1ZoN1VmOEd3cDQ5azh2Mllpb3J3YjBQSDUxQnNnYmVJ?=
 =?utf-8?B?ayt3eU9uaWFOQzVHUnRRc3o5aHM1Q3crVEJCQkJDeUtQWFVvbVNWU1U3Mmdk?=
 =?utf-8?B?VG51VWtleVNuM25uQXIzSnBQbS9pN3A1RkR4YlJwcXQyd2ZRK1preDk2U0or?=
 =?utf-8?B?cDdMQ3kzeGFPVDlYKzBuZHJtc2YvRlJMdkdWS0FOS1RwK3cybnA1VlF2NG9L?=
 =?utf-8?B?Y0J5ak0yQjk5OXYvMDVvSTBidHBueVVuNThPZ0pWY0h1NWNKUGR4eFE0L1Fp?=
 =?utf-8?B?eVJQeWROL0pld2NIWW8xL092b1YwMXRKaVF2N2kyV0d1UXpYWHg0TDZuSm5F?=
 =?utf-8?B?ZGxVNU0xeWRLV015ME1GYVhac3AwcFkrQjBPcTlocG94cU94dElQaWVZdk1D?=
 =?utf-8?B?R1VaZHRtVUdNdW5MbUxSVUtmRm4yMWtUWVk4MVB5N21abGZWTS93WlZMR1hF?=
 =?utf-8?B?NnU1b0hEL3lONEQ2NlVGUE8vSzAyS3RscTZPbEVvVGFCNFRaMlRrT2JvbkZ1?=
 =?utf-8?B?b2lEL0cwWnNBUnlRK1BjdVkwV2hyUTNydDlaUTVUeFBxakJ2dk9XUVM2OE9F?=
 =?utf-8?B?bUhXMWYyR2RzZ0pEcC9hcUw1enRpUlUzTnFISW9yVmVZeE1CRWlHb2lOdWFM?=
 =?utf-8?B?NDRLRW1BTmZxLzAzcExSOHB4YUFBdGRhWWlGS2tkbFM0VXV2M0x1YnpZdkN2?=
 =?utf-8?B?VU1LdUMxY05FQ1FWbTVDenpySUV5NWlQdGJ4SUxLOU1sWGU4MTVTLzErZzRq?=
 =?utf-8?B?eHZkMlMrdG94S1lSV2lkSkpWS0tDbkVoYzhnTnorVmJLUHFMbEs0ODlQSlFx?=
 =?utf-8?B?ODZMcmkwb3RwMS8vd1Y4QlNKOGxoVTVzNFdtemp3dFUzSUVSbm5HazA1bGxj?=
 =?utf-8?B?Q1ZnTHNmS2llWEVzKzV5cTdiMiswNlZDZ01CM3lwTTJBZTdRWGk2SDZMTE5G?=
 =?utf-8?B?eWpBdHBPRUVCdmwrZ2t1OHB2MlRMNGk1eFdUR2QvaEs3NllERy96Y3J6VVZv?=
 =?utf-8?B?cnFPRWthWEVITVJkZldsZVdleUJVMmhNdjlFU3pXQ1MxeHVwVzIzS2F0SGhR?=
 =?utf-8?B?VGJCbDN0c2c0SVE4YTFycEVtSmp6MFFGWFZndVU0U1V4SVBvcFdmODN1V0R4?=
 =?utf-8?Q?cjRkL7VqQeFEClZ65FmxTQWym?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe208e75-f8e3-401a-842d-08dd1bb73389
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 20:46:21.5316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyTYqtChpbVhs9HS3p8Q+wDJKjzwvnRkN1h76hrZzG50r0A0bWa71FzeUTomp5VKSh9gbwwWqrJeTYCC657ZSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10215

Add binding doc and driver.

DTS part wait for
https://lore.kernel.org/imx/Z04W5chGq5TitB9f@lizhi-Precision-Tower-5810/

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:

binding part
- Change to LDO-SNVS from LDO_SNVS

driver part
- remove pf9453.h
- remove double space
- use low case hex value
- remove , after terminate
- use GEMASK
- change to LDO-SNVS
- Link to v2: https://lore.kernel.org/r/20241212-pf9453-v2-0-f59d2c096356@nxp.com

Changes in v2:
- Reuse nxp,pca9450-regulator.yaml. Add nxp,pf9453 in nxp,pca9450-regulator.yaml
instead of create new one.
- Link to v1: https://lore.kernel.org/r/20241206-pf9453-v1-0-1e4685114271@nxp.com

---
Frank Li (1):
      regulator: dt-bindings: pca9450: Add nxp,pf9453 compatible string

Joy Zou (1):
      regulator: pf9453: add PMIC PF9453 support

 .../bindings/regulator/nxp,pca9450-regulator.yaml  |  24 +-
 drivers/regulator/Kconfig                          |   7 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/pf9453-regulator.c               | 879 +++++++++++++++++++++
 4 files changed, 910 insertions(+), 1 deletion(-)
---
base-commit: 0768222687cbdbe7c300c4428f0c0c6b153386e3
change-id: 20241205-pf9453-90e8dbda562a

Best regards,
---
Frank Li <Frank.Li@nxp.com>


