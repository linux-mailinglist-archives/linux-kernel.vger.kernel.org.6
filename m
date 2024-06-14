Return-Path: <linux-kernel+bounces-214475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DE3908542
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0541F26D9F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC1014A097;
	Fri, 14 Jun 2024 07:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YjXCypjF"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2070.outbound.protection.outlook.com [40.107.13.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1344038C;
	Fri, 14 Jun 2024 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718351084; cv=fail; b=s6tjmKAr4/Gdd1N4J0ikFqPSspi34SI095fxGVYMMjVbwBqPsCegcztMDDeobVuU8qPt16uz7hXj/+N2PmMFf85kyybLVaLBWqlCDT9tu9W1+WwpyFEA7HAAWLAmrra4NB1eL8ew4Db/VANGXcvyRHCUgLZtK1MGSXyCDMMjkTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718351084; c=relaxed/simple;
	bh=YZH++VoXu6Fr4IhITOsjw1G0Vfz7TDmJr7b+NZWN04Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VvQo6jCEjUAsSPg1Oe20a1e+U9eztazskbGRLiOtETOoLbpzFAzX7MW14dh/KqkOnRYoqI64Za2maxo3HC8tI7W7raxTjUw29b8VhxeRxWtTl8Erhkv93aireDLtBqN6AMe71dIm4nZl6v2HAjCi18xI+qXKBEw3a1R/7FobgkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YjXCypjF; arc=fail smtp.client-ip=40.107.13.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gssYB1geAlKB//AoMCjtTvwVic1XXagJ5tg02ohxUG033MCBD3uGTnNMFoMBbr8b/XarMYJB+XLC9uncuR17hgdAMElKX0AOp0vmjkpRN5tKLNvXPN1cUjbDkgCghc55ZJqP3daAeCI7cqJnTwPJeJGcUg2gyXAS4hESWzzV1sQGScOWygN/mST3yMsOfJNgHSbTmPiKBSW84EdIFpuvzjcRiHENLVcfeUTd+tFRhpcwMcsueQ4B+/wagBKxxf8vrwP5yu4yKC7mLFVUF7eC2sPv/ywB8eYVHEmZzmxtO6/PHEkwp8izgkJvcDOSx/pZX97bQvZq2eqY9f48kaG7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/o8SuX399z0MCYChd1iREvJ5oEGFd1qjSZ1jodeqHv8=;
 b=RB/juLSngQ7Rn12dOVxzYlyuVu9L84WG8ZYgOMq5AUrwP1+LvlmirZWjhuYXqvvSjDMrk3n1tKqSCGets+zLPqoyJz0RqBAO8go6A/csnPL2M2CxXyZikutv3UP4zJIH/4Sd7Ni0jxRK9fO5VUwLIG8ttEbKGWLk2w5srlYVtTCCDV5uUqOXcRZXBr5oVH2F6BAd/4uPEPwqbd+b6eq/LMRf+atoTB76ILEVufG+WtXVjp2cRzH1G3VLZQzCgKmJr0YiWj2hjjUCKtMOCHhHzR7bYePFKs9EL5Z3lz0lHo/ZnDsWvDLfnjf1ASRud8oczmSnkDYHNT3SJLyG/J2qQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/o8SuX399z0MCYChd1iREvJ5oEGFd1qjSZ1jodeqHv8=;
 b=YjXCypjFGvS15Ja6roNPvGBOa+ijTZcHweBLZcvg+Z9vO5a06ayxJWyrqJtoYpDavEtzWHSptYajhcU+y2ix24VdF8JSuia4K40suYh3FEw0LV+zB+IOhGONKMECAZQl5WM6pZZkNB/dDxjnArZesm7UnQRJtF0hvnqzseimMMTW2oD6yuvGbMT+MnCHYQbkWkx9+ndZ9/0MrCQfSAy8G1ysZkmGPxHza0fNQrFhP/OH66ikNf7u5ND9TqxhGQXpuwgQ1o9bJrpB3SDaqOjhtLib0dNroa0Zegdf6YGjeenXqUEpj1hoJ2tOhkOip2ia2k4VJlA6q6u1v091qljbXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8718.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 07:44:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 07:44:37 +0000
Message-ID: <a15da17a-f196-4356-a744-5c8e1104e7c0@siemens.com>
Date: Fri, 14 Jun 2024 09:44:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am65: Move SerDes mux nodes under
 the control node
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240326185627.29852-1-afd@ti.com>
 <20240326185627.29852-2-afd@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240326185627.29852-2-afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c25db51-7ed1-454e-3daf-08dc8c45d712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|7416009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0NYL0tCenlLT20vQ3k2ajU3TlYxVWpDYWdXSHRXQkx6aEtIQ3BGY0paZURr?=
 =?utf-8?B?ejZMdUI0cWNaRGViRlFXZGZ2aGc5blFVOXZONTRHd0N0WEFpOEw5NUVXQi9z?=
 =?utf-8?B?MTdwbjRPQ3h0YlU1bmI0UHAyYWhoSFNrQnRRMVo0cUNsanBlRHdaNERmclFr?=
 =?utf-8?B?Yk41cWE2NVpQNEYvS01MdFBQNUdwS3lSNDB3OVJzd3g4bGRhc1ZGeGNEQ1Bi?=
 =?utf-8?B?SlRhOGkzbVBWajBoUkV5SkZGUWlwc3Fnc1VJSitiSmE4aTF5VlpwYUJBR1BD?=
 =?utf-8?B?c2ZiN2k2NDQwMnZhaWlNaHlGdWZlallCeXlBL0tVNFdjUlRobnlHd1YvbjN6?=
 =?utf-8?B?czFtTXZGRDA1dlhaSmVvdjhYRHliN2lzZzBKRlgySWtRODVMdFJtK3drd0pu?=
 =?utf-8?B?eWo5em1XcjRRTXU3TnRyL01Dd0kwaHRUMkp0cWNpUTZTQUk0T2RsdUpGZWJz?=
 =?utf-8?B?YWE0K0FNVkFpbkI5aDZ4L3JzeURPZkVOOWJWZHI3bDNFUGd2dWxGRmswRFpk?=
 =?utf-8?B?bHArcGhscjJUZk5CelJ1WkJ2dHA0NU5EaStndU5wODVZWndHbVZiY2dEY3gw?=
 =?utf-8?B?Rnd2L09CVkFEcytsdk1wK0NJSGJuYWFjZ1A0M1ZVRXdMdnBTVnFsWXl0b1p5?=
 =?utf-8?B?UEJza1ZKaWlBZU5tZWdmenA1MFRHblM0TCsvRE5yRlRUeEFCVk9sRkx5Lzdu?=
 =?utf-8?B?ejhPUXBua2JOVEdsNmtkUDc5K29YbGNKOTJjaVFJYmVWalFRR0FQczhIQmNO?=
 =?utf-8?B?SktLSVFReDdTeEJXVDdWZ3oyN2U1M0JkY1ZUTWNrcGlwOU1VWmV1YVY5WHB5?=
 =?utf-8?B?c09lcVJ1R3BJcUpJNTd1UUw4QlhYelRIaGE3NDFwVmJYaGRtWU1oSHRqYm51?=
 =?utf-8?B?Vmh4L0RKa2lTTCtDOHlRb0Z2cFZnQ1Z5STFsOENaaUdWOUtrNVF5V1M3MTBI?=
 =?utf-8?B?dEpSNktlSFdzckJzZ2RKSjYvNlVqYXRBM2xlUm1oWDIxU1RjQWxpZ0Vnck41?=
 =?utf-8?B?R05Md2pwamh6ZlNEUGJpY2FrT0pab2NEL1FSTHN1ajc3OWZ1QUVFRHNDRkVD?=
 =?utf-8?B?QU9LSFB4NDYrTUxBUGhDN3Z1Nm1FOUdWeFZIbHB0dENZRkN0bVpncmxSVG0x?=
 =?utf-8?B?L1Jhb3ltSEdSUk9mSFZUSk16eDRTRHpkV3VKQ3h2MTJKQ3FFTC9JMnlFSlhS?=
 =?utf-8?B?WDloOFlxREFWLzF6U3Z6eHNZejErNGNKVVBOVitXTnJFeVdlNmE0RDh3MSt0?=
 =?utf-8?B?dlE3N1BwWlBBcVY2TmE4MklJL0M3bE1laUgrVEYyYTVmNWVqYnJZdDRlM1E3?=
 =?utf-8?B?RjRUdzQrUVRDSkpSUzgxL0lDbjQ0bUZPaW8zSm9EczZCUkNMVmJGTVRMY2JP?=
 =?utf-8?B?eW1rYkJLdXkwUWt1bDBDaWF5SjNJZUdsUUdQZFNKQmdRak5pbms4MEM4TkRo?=
 =?utf-8?B?ZVRjZmRzRktpUXR2ZlN3ZGlTTFJHQzRGYmxoZitjYXk4YUFzZ084V3VFZUhq?=
 =?utf-8?B?TStYaWJvekx2czRlVHQrVDlYQ1VuZHZMWWlGb0srN1hSb2c1YzM1Tndxa2xu?=
 =?utf-8?B?SGZLSXFZMHdIYkJFeUtyY1B2SjdaWVVPaHM5Y3NqNTE3S3RzOTZKN0VUVW1P?=
 =?utf-8?B?bUYzaXhDODh6VUpiSVc5ODV6VFp2RFY2alhpUFVxNHVYRHVmdk1rUUp4V3oz?=
 =?utf-8?B?aUxCYjhQMk02RzRBQndrSXhsaHdHTEcybkl5NmRvc3AwOFBlTFFTU3E4NUNz?=
 =?utf-8?Q?09mqpiq/+hHBfR2uNw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE5tYlJybG9FeW1nbVN1Y3NIb3pyMkl3NG5WeWFWZWRTbE95dy9uNGxXZSsx?=
 =?utf-8?B?WHlpWlhwczBwOEQrMlIxcDlFTVZQZFpXTVAxeHczc2JZOVArbm5MblRGNmVp?=
 =?utf-8?B?eEhabzZKT3BTb0lmRWF6K0ovNU41dzhiNHdoWFRBSDJmUW00eDdFZ1NNUDJj?=
 =?utf-8?B?N3d4UlNvYzViZC9zK2F6WVE5TWdTLzV1czU5R2hZUlVacVE3bEFIbHFFVnND?=
 =?utf-8?B?N01RSkJrSjRRUWNZdFFlWDB4ZVJtSXVkSVEvM04vaytaelNYaVc0NERycEd1?=
 =?utf-8?B?dFk1MXBSeGI3NlFlSGJBQ2FKdkEzZU40ZXdhaVpNZnNhM3ZDTDVBamRXUDB2?=
 =?utf-8?B?MS9hNm52Uk5iKzlmbDIvYW5TVDlHbWc3ZDgwQTYvOEZGNlZIakgyeW84MHNa?=
 =?utf-8?B?QjcvTnlFWHFaY2Y2SUdoQml4UzE1RmZSc0V1bzZjcTNlOVdhVTFuTWJsdWp1?=
 =?utf-8?B?VnpkV0E5VjZ6c2pON3ZvQTZyVzVOSlpWMDBPTDNPOE8ycFFrTTI4UnM4YXZk?=
 =?utf-8?B?Vk9WZDFQUDFpQ0hpYk1ndk9keEtjeDJ3VzYrRVozWllta2pUNkRRV2dXckpo?=
 =?utf-8?B?T0o1Wm9IaDY5Mi9YR0F1dXhLYXAyZUlHdmxvT08vc0VWdGFSTnUvT0N0VHk0?=
 =?utf-8?B?bmozNXYyeTgvcDFCM293MzhuOXFkekp3aStzMU5sK0NlUkROR2REM0tWZ21u?=
 =?utf-8?B?V1pYRnhFejRtYUhUUnorR0hzZ0xVakNkRFdDRU4wclU0U0lWRURLUGZmNXJX?=
 =?utf-8?B?aW1DNURIS1VURTRnNWFGQk1IVlF5MFNNUWVvU241MXdXWDlQZ1R6NVJHZHBF?=
 =?utf-8?B?WHRUcHVoRXZweUd2QXZncnd2QlhaV3QwcWNNZXdSY3ZqbXJ0WVMyQm9aUk1I?=
 =?utf-8?B?bzJyRktSSHh0TU1lcEhhOTBXanEySnlBaW9lQjJMaFhLVmJwdlZkK0lqWWVL?=
 =?utf-8?B?QzI5cURqVm1peEdQTFJPMDNCVGg3NWJxWDJlU0NpZngzNE1ERVBHR3NpM3Yr?=
 =?utf-8?B?VUZ4L2FVdGRIUTk1cWpNZDlsOUt5OFdEVFVjdXpsZ3dTSVpLLzBhbHdpZnZ0?=
 =?utf-8?B?YnlUVk5iKzdHVmZZaWtzNTNYQTBmQ253WHVtcVlVd0RJT2djMkN0cDdtYUU4?=
 =?utf-8?B?YW8rZGpqdEkzNGNUNURyUDR1aUxLZ2IvaVoweVA3UytjZ3M2RkhJcTFhTFhC?=
 =?utf-8?B?UmZKTjRWS2Q0TUpUazllaUxEbDY1TkdVd1J4S21JQ3NETHdlNnV0ZzlZZ2cx?=
 =?utf-8?B?UTAxYkFEZHAzVjBBYy9US2pORGFpUnd3Rzg3dmRwT3ZNbzUvc29YT2JQU1Aw?=
 =?utf-8?B?T040R3RYN1RFTXBuU2cwZmpaU3UwQW1Qek5Lc0JicjFRYmkwMkZIRVRoR1lI?=
 =?utf-8?B?ei9XYWN6RVFoRHRJZWZUSW15RURBRUpzT1lueFVkNk9zdXhUUFdPVW1veThH?=
 =?utf-8?B?SFBWUWhMbHd4d2dkcXlla1BCUzc1SUc5MVoreUx2cVFiSWhJb0s0Um9DQ2Ir?=
 =?utf-8?B?Y2NIcGwwTDV4ckV1S1UrSjVzUVpHZi9GdkZWcU9pQm9aOXpWR1VwY0dvNlJN?=
 =?utf-8?B?b256V1llTzd4SEszMkdYd0ZMajFIODBWaUdIdW0vaUJUMngxUFBySXIyWDBu?=
 =?utf-8?B?S3lSYXNlUjdHZVpVVUhEVThabkJncmJOVDVXZ2hOMnhZRDc4YW0xTWkyeEFR?=
 =?utf-8?B?TFIwQVlSMzAvUU5FT3F1d0MzckFXT1g5bGQrd2ljT3dCaXVoeHVlTGVzV1VI?=
 =?utf-8?B?YkdTMHBzaHU4cUtpd2plUFUvOTQ4RW92aXdmc013NUZXbnc2bzJhQk94Qzk3?=
 =?utf-8?B?RUgzSlJZOUpHQzdQeE1hbFlsL2FSS09aN3J0S213VGlCOVZZczhaRDJ0Z0l1?=
 =?utf-8?B?TGFYNlNCdVZlNU9hbzRBV3VtRkFKeURHUVN6OFZEU0RlN2xxZythalljRkF0?=
 =?utf-8?B?N1o2R3ZiV3ZkVkRRa3NWNTh1aTRBZzd1UjlZNDRxQ09TeUJ2S2x4cjNudlF0?=
 =?utf-8?B?ZTVabWxCUzBtZ1lZUkd6Q2FGdXpMOGZudmZza0ZGTGNPR2FBdE4xUEtCUFIr?=
 =?utf-8?B?N1ZIaXhkQ0JHN0RxVVM0aTVWbmRRN1FxQlVJRVdqTlpTM0YzUDVveGltUUd2?=
 =?utf-8?B?MnI2VEU3bFpwOEFCZ1FSVHV6bklTSElwWTV6VmFPUngyR0tmVjZ5ZTFuVk9u?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c25db51-7ed1-454e-3daf-08dc8c45d712
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 07:44:37.0497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72yr9zulkqW/OnGWvPKu+4BiJ2vfo0R9rhUQTbjmBZnhE5MiyQhjxVj6eyLRGKSdhcj+8Q7pHV+TbsoDp7ekmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8718

On 26.03.24 19:56, Andrew Davis wrote:
> These SerDes lane select muxes use bits from the same register as
> the SerDes clock select mux. Make the lane select mux a child
> of the SerDes control node.
> 
> This removes one more requirement on scm-conf being a syscon node
> which will later be converted to fix a couple DTS check warnings.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 738c5c4acbcd2..5ce67e6a33600 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -66,7 +66,7 @@ serdes0: serdes@900000 {
>  		assigned-clock-parents = <&k3_clks 153 8>, <&k3_clks 153 4>;
>  		ti,serdes-clk = <&serdes0_clk>;
>  		#clock-cells = <1>;
> -		mux-controls = <&serdes_mux 0>;
> +		mux-controls = <&serdes0_mux 0>;
>  	};
>  
>  	serdes1: serdes@910000 {
> @@ -81,7 +81,7 @@ serdes1: serdes@910000 {
>  		assigned-clock-parents = <&k3_clks 154 9>, <&k3_clks 154 5>;
>  		ti,serdes-clk = <&serdes1_clk>;
>  		#clock-cells = <1>;
> -		mux-controls = <&serdes_mux 1>;
> +		mux-controls = <&serdes1_mux 0>;
>  	};
>  
>  	main_uart0: serial@2800000 {
> @@ -485,18 +485,23 @@ scm_conf: scm-conf@100000 {
>  		serdes0_clk: clock@4080 {
>  			compatible = "ti,am654-serdes-ctrl", "syscon";
>  			reg = <0x4080 0x4>;
> +
> +			serdes0_mux: mux-controller {
> +				compatible = "mmio-mux";
> +				#mux-control-cells = <1>;
> +				mux-reg-masks = <0x0 0x3>; /* lane select */
> +			};
>  		};
>  
>  		serdes1_clk: clock@4090 {
>  			compatible = "ti,am654-serdes-ctrl", "syscon";
>  			reg = <0x4090 0x4>;
> -		};
>  
> -		serdes_mux: mux-controller {
> -			compatible = "mmio-mux";
> -			#mux-control-cells = <1>;
> -			mux-reg-masks = <0x4080 0x3>, /* SERDES0 lane select */
> -					<0x4090 0x3>; /* SERDES1 lane select */
> +			serdes1_mux: mux-controller {
> +				compatible = "mmio-mux";
> +				#mux-control-cells = <1>;
> +				mux-reg-masks = <0x0 0x3>; /* lane select */
> +			};
>  		};
>  
>  		dss_oldi_io_ctrl: dss-oldi-io-ctrl@41e0 {

This change breaks serdes setup on the IOT2050 SM (k3-am6548-iot2050-
advanced-sm.dts), possibly on more of our devices as well:

platform 5500000.pcie: deferred probe pending: platform: supplier 900000.serdes not ready
platform 900000.serdes: deferred probe pending: (reason unknown)

And PCI remains unavailable. Digging a bit into it, it seems the change 
is causing a circular consumer/provider dependency between serdes0 and 
serdes1:

root@iot2050-debian:~# ls -l /sys/bus/platform/devices/900000.serdes/
total 0
lrwxrwxrwx 1 root root    0 Jun 14 07:10 consumer:platform:5500000.pcie -> ../../../virtual/devlink/platform:900000.serdes--platform:5500000.pcie
lrwxrwxrwx 1 root root    0 Jun 14 07:10 consumer:platform:910000.serdes -> ../../../virtual/devlink/platform:900000.serdes--platform:910000.serdes
-rw-r--r-- 1 root root 4096 Jun 14 07:10 driver_override
-r--r--r-- 1 root root 4096 Jun 14 07:10 modalias
lrwxrwxrwx 1 root root    0 Jun 14 07:10 of_node -> ../../../../firmware/devicetree/base/bus@100000/serdes@900000
drwxr-xr-x 2 root root    0 Jun 14 07:10 power
lrwxrwxrwx 1 root root    0 Jun 14 07:00 subsystem -> ../../../../bus/platform
lrwxrwxrwx 1 root root    0 Jun 14 07:10 supplier:platform:44083000.system-controller:clock-controller -> ../../../virtual/devlink/platform:44083000.system-controller:clock-controller--platform:900000.serdes
lrwxrwxrwx 1 root root    0 Jun 14 07:10 supplier:platform:44083000.system-controller:power-controller -> ../../../virtual/devlink/platform:44083000.system-controller:power-controller--platform:900000.serdes
lrwxrwxrwx 1 root root    0 Jun 14 07:10 supplier:platform:910000.serdes -> ../../../virtual/devlink/platform:910000.serdes--platform:900000.serdes
-rw-r--r-- 1 root root 4096 Jun 14 07:00 uevent
-r--r--r-- 1 root root 4096 Jun 14 07:10 waiting_for_supplier
root@iot2050-debian:~# ls -l /sys/bus/platform/devices/910000.serdes/
total 0
lrwxrwxrwx 1 root root    0 Jun 14 07:14 consumer:platform:900000.serdes -> ../../../virtual/devlink/platform:910000.serdes--platform:900000.serdes
-rw-r--r-- 1 root root 4096 Jun 14 07:14 driver_override
-r--r--r-- 1 root root 4096 Jun 14 07:14 modalias
lrwxrwxrwx 1 root root    0 Jun 14 07:14 of_node -> ../../../../firmware/devicetree/base/bus@100000/serdes@910000
drwxr-xr-x 2 root root    0 Jun 14 07:14 power
lrwxrwxrwx 1 root root    0 Jun 14 07:00 subsystem -> ../../../../bus/platform
lrwxrwxrwx 1 root root    0 Jun 14 07:14 supplier:platform:44083000.system-controller:clock-controller -> ../../../virtual/devlink/platform:44083000.system-controller:clock-controller--platform:910000.serdes
lrwxrwxrwx 1 root root    0 Jun 14 07:14 supplier:platform:44083000.system-controller:power-controller -> ../../../virtual/devlink/platform:44083000.system-controller:power-controller--platform:910000.serdes
lrwxrwxrwx 1 root root    0 Jun 14 07:14 supplier:platform:900000.serdes -> ../../../virtual/devlink/platform:900000.serdes--platform:910000.serdes
-rw-r--r-- 1 root root 4096 Jun 14 07:00 uevent
-r--r--r-- 1 root root 4096 Jun 14 07:14 waiting_for_supplier

Note that we normally disable serdes1 on this device as it was not 
required so far. Enabling the node does not solve the issue, though:

platform 5500000.pcie: deferred probe pending: platform: supplier 900000.serdes not ready
platform 900000.serdes: deferred probe pending: (reason unknown)
platform 910000.serdes: deferred probe pending: (reason unknown)

Jan

-- 
Siemens AG, Technology
Linux Expert Center


