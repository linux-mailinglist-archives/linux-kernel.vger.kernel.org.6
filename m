Return-Path: <linux-kernel+bounces-307695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EE596519A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430551F249AA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0999818CBE1;
	Thu, 29 Aug 2024 21:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YoFSExIQ"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0381B653D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966105; cv=fail; b=WzgF8oGay6A9WVTWkNyLzzWh9m8KLlLHqPJnAnSFsZDLBNamkuX4GEFSiz5wkdMagmaVveODIWuMD3D8jTZINpeEpgEJp1CebANKFwUD/lQxFH/Wxz2sYX6X1A4guM0uwKjCKiCEomDxu3YIXJW9QmWnh2mrbnLupDA+GfDlad0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966105; c=relaxed/simple;
	bh=HWDamdLNANEwk6vCRoWBJpLPEb6ZbVWcj6qlnnkj070=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VMB0E3naSSCEP0fDCnngEVOhPiifPtZBZdvqbo3iuE++JljUnvPzNDniEkJr6FlhGDyMwx2ubNJLGljI5WjcdmySGO+1RLmidgSY3Xk9tJtAcfy8cfnXaWjY2K0Zf0AKxtv2CSV8ujomi7Gx+jf1CvhBVko9K5iMyjkNSTWu4wE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YoFSExIQ; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWyZqWR/n+pCqmGpo1QwzXREaVS9Slf/BadmgHiyyBWfg8oWEj5u1bwhEvFEba/TEzE1cDTY7a8X9kdsdmQYhVBh46Hrb1caw7+xTtQRRfR3oNfKKHuoCtLrhG8ENR94ubDydkYJn48fiucTA9FJDfDTIoC6lVW33gJiTLZceENifbD7soAEpnIdLQ6dW27GgCA3arDxvIQ5F7obX7eSvXKsOCBUSj1gjedckwpft2Wb7mBi1EsLEf2VZD9Sof/3GzMfw1v/CQipN3RxNMtXI5fddNopF5tJUdZvEQsrGJqr2Qcwqpd9e8rvfse1bmoC5F8t2XBOX7zq8940FrI9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqVyPCbPTJ3sdEA/27481SZaESH46IwUHMWlvgoCoX0=;
 b=DExqCNgTS7YjaUgh6ZnJ+e3yo9HCvS+hNtv5CgaK6yV0KIdNXOf9HFoqwfWzQ1h2bTBNoUWvloSPHyMmRBZUmrkx2SjDHJ85hz/buK4MZle+wcgJ04nPsgcvNPHrt+cCCs6pmaVUAgcKfhcv9Oxi/IDEGPFEs5IcnoknvBGh3DtgC0CAabnsRhb4bRDdp1RZB6dIZmU4mg+0hb7/kOXhJiNHLrA3qfwze5Cu0YLYxg6q6HRhYDS9E21xpRHpjGeGSDdO9pfZnQAHZ6f6jHxgzzQ9HnuNQ04XzCvqztp0BIbRnIm/MxDS3CMsVgmoEkOLk7zUgKKp1OHeT9yOr7Vm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqVyPCbPTJ3sdEA/27481SZaESH46IwUHMWlvgoCoX0=;
 b=YoFSExIQDco130ynxt+gMFv2VSjM9Vfi6c9wbQA2+2Eai72+16S7LkCI6Kdw1kpL1NzqP+0xqeRH4ii8rnIJlmBT8kCVamyPOivFsXoSAC1zMul0VgrkhYnPKQonrCr1jsm3Hv9sJaTXJAv4Iu9orgIs3OcH7RgiW6N9YFyWt8kRmz1Vb7+h3ANbh2J1SQz/FYuDri6OA8nz6Zy8Nq/6zyw2SQa+p9AUECw201J8toQsykJDhtSiN8mbzlKIWeJLeU3eUykwOkfRouKWKMPg+5T86wdwRw285GiN46T6NDIJoCLFy1cLwoV+JCBXDmo5IfdlFwK0akcbO2+7HOHtMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7560.eurprd04.prod.outlook.com (2603:10a6:20b:29d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 21:14:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 21:14:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 29 Aug 2024 17:14:00 -0400
Subject: [PATCH v4 03/11] i3c: master: Extend address status bit to 4 and
 add I3C_ADDR_SLOT_EXT_INIT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240829-i3c_fix-v4-3-ebcbd5efceba@nxp.com>
References: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
In-Reply-To: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724966082; l=9448;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HWDamdLNANEwk6vCRoWBJpLPEb6ZbVWcj6qlnnkj070=;
 b=o0DTeRjMQ2dHAzjUlY0ZhP29WKNDnfr5q/pYpbfcM3XVaeFQCVQZm9JJ6DyOp4kOlPEjNdu2p
 VBYLZjNuE2lA5gtbes8bZXaeKOEK0cVKIcc8YyQkyKhjDP+auXwdBQZ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a45bccb-e3f9-46c2-7689-08dcc86fa1a7
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OTlsY0tNbWwxbEVLUnM5Wm9TbHc3ODMrNlN6QmVqekdNK3RXY2czQURrc3I4?=
 =?utf-8?B?N2xER0t2RlZySFYvdUJDbzUzc09JL1BISGZHK2FDTnh3L1M4Z29hOHlOVDM0?=
 =?utf-8?B?WVYzTzJPdGRsaUxsSFhEU0YrdVFtRWJBVFpjQnFldkUzVVdPWlpoenBmMElu?=
 =?utf-8?B?V3BrWnBLbWF4U1RDUHN2dTIyVEp0dDBrYVdxUmdXYkU5WklXYVZ0OUM4WlZ1?=
 =?utf-8?B?MCtkSFIxYll5dlVOVEUyWU53Ti9jSFV6V1VCeDlMTGxRR3ZKRFYrUmE3Ujhy?=
 =?utf-8?B?TG51NGJqVnlWL2VudmdBSDY2dVJ6cTRDUGQrak5mVk9PUXhoL0FvWHFIT3BC?=
 =?utf-8?B?U1hoeFkvZW03bzJkcHdyUkczLzltWWMyU2tubGJoTDVXZk9lakMrY2hvaDNu?=
 =?utf-8?B?TjZqYlBxZ1prQmF0ZWkySXNFdGhuQXBBc0tXZXp5M29BdUluQ3Fsa0JOY0ZR?=
 =?utf-8?B?T1FiamJja0E4cktmbDliYTY4dWtjeWlKdCtpMVdZOUhTNEIranJaWTNTQ20v?=
 =?utf-8?B?aWp5c1F1Q0JDTE5KMmpQRmEwOE5kN3ZsTTlhZEtkRW5ROGlHOWlzWGlFckV6?=
 =?utf-8?B?NzBLcVhscHAweE9FbUova2U2OWFqTUJxL01mOGJ0b1k4UWI0UEpiWVBKc0NB?=
 =?utf-8?B?bDZjbTJhaGYrbWppWEQ1U29xS3NWbzBHUDlIanJnV1lQRC9WdmZxU1dLd2d4?=
 =?utf-8?B?ZWZmZWFQaURMRWE4aVc1N2diMUg2VWN3T2FkemhVRTJ2Mnk5VmRvaGN3VVhW?=
 =?utf-8?B?YWpYVjgrR29lUmZtSHI3UHlvWkdQTC8zcVZpdy9KWElwNy9SUGRxSkVwaWFz?=
 =?utf-8?B?a09nNm1pOUViY2Vacm9tZnk3V3RLQTZESFpRR2FTTE5MT1dxTDBWaG82eGZt?=
 =?utf-8?B?NnBNT2FEODQwSlcrbFFPR3lzUDVSVGgzNk93ODJXaGY1VXloR0hRZko3MC8x?=
 =?utf-8?B?LzlxRmhhTlBTNUtmNmtDQk9hbERKbGVyL280aXk5NEIzNys3YkNxd3RyaCtC?=
 =?utf-8?B?K1hLVDZ2aU8xQWlJejRjQTVTS2tWbms1cG1KMUxSZkZkQXNKcVZVOVdDWG5Q?=
 =?utf-8?B?UHJZMDBjNDZJV05UQk9jRlhPSGcwZEtiVVIxUjArQ0hKVlEvVW5TOXhkMlls?=
 =?utf-8?B?UzhYN1A5bG1xSzRtNzk3aWcvWCswL3hlSW5saTJhbE4zN3l2Q2xkQ0gvN3hB?=
 =?utf-8?B?alNvTVNRakE2ZWdSZHhYdlVKZVY0UVV5b2pxOFl6MEhwdDVCR3o5M2czS0tS?=
 =?utf-8?B?SEp4UzVIZHY0ajhMdnNJYnB2UzNtdjUxRnQrYkd5MVlIeDJuclR2OStsc01y?=
 =?utf-8?B?a2VwR1BjSXpOeUVSTFpZM1VmYjJMS2tPVWx6MVRRWS9VVXl6WTVXMDF3OUZo?=
 =?utf-8?B?L0c0S2Q5a2pKcEd1TFRnOGFJRElwcUlhSHN0SWo0UGxFRFBXSGhvS1lFQ1NF?=
 =?utf-8?B?cXZiZlVvQW5qazh0ei95QnFTNkpqTnRjc2NhTmhqSjd6M3N0RDZ4Um1kTG1z?=
 =?utf-8?B?akFQckEyRVZ4QnRSUmliUG5tbHplY3VaU1Y4UHNKOWRHaU9sUGlEbW05a3RU?=
 =?utf-8?B?OTJsczhEQWxzRWdJTVl1dEo3SXF4Q3dmN1ludHlLeUF4ZnF0NFU1YisraFVC?=
 =?utf-8?B?Q2JqaVJnTlVjZGZkR3FUNW5paUhSdnZJdFpTV0cxUmt6bG9kczVWRDdqZlVa?=
 =?utf-8?B?UXdTVm9LWmVMNEVwRkNYMDZDWmF3TnNuN09ST0JhOTg2bjhIVWd0VTBleGl4?=
 =?utf-8?B?TTQvRjlob2h0a0F4RFFzS1NGMUFBSEdVeW9pTUcvS0JyNS9yc2lMbDVFZDE0?=
 =?utf-8?B?ODM3OUhOY09GZ00xejRua1ROMk9kZEhyRXZsNXB3WDh3WEc2aGtpek9pNldC?=
 =?utf-8?B?RHluUk5HSTE0S2hOc0xmbmk3K3daaU9qc1BFY3dpTHd3VVE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZFdjbTQvSXBrTVhDV1JnaEVVSkQwZE95T0hZNmowWGxZVWZVRnk5NGlXbDZT?=
 =?utf-8?B?TnN6T2NJYVhFNmowa1BpVHNISHZOVVZHNVk4N3dXOUlqaFpPTXdzbFBQSTFi?=
 =?utf-8?B?N1NIRFozZmNiOEtTNnMzejM2ak1hTk5EWkpuajJ6d3d5bTErME41TXRZWDZO?=
 =?utf-8?B?TEJQTG5iUXl3S1JhN2JWemlpYmhSNmFIMGtoRVM5elg0M3hLOWhrOUVScmY1?=
 =?utf-8?B?dmdjZThaUnNWOXdLelNQZGxaRDZRVFBEU2NmOUJDMDRKY3g1NE1ac0I5V2h4?=
 =?utf-8?B?Y3ZaSUdYeHRZd2pOUUtSZXJsMEllMENzSDVJWGgzamZZcDdkL2VGbVIzQ1BD?=
 =?utf-8?B?UTkwQjJRbE0zQytYcnNweUNKeWQvUjFxNzhGUEJXS2JkSkM4UHh3VWNZc2hU?=
 =?utf-8?B?RzBUWVpUaFN1c1YxRTlJaUxXeVRCM0sxS2dRK3ZUMnZycXE3R0UxZWF1VlF5?=
 =?utf-8?B?VUluMXMyTHZETC8yZWZMeGlEOFEyQWJFb1F0TEZNRnVYY1k2OC9OMHlSSGkz?=
 =?utf-8?B?aXpsYjBhQm12WUMxajdORnVxV0tBK2UvWnpSTktHNTFGYUdSaHJIUUVJWVpt?=
 =?utf-8?B?SGF5dE1paE5qekVCanZGRzA2YTdZdGliMXgvcTRtckN5YTBreVpHQlhmOFZs?=
 =?utf-8?B?NnFsVHBMS3Jod1Zqc2hsemoxTTFXK0FJWHNHcVlNUzYyeTNQSUtPNDZ1OUdV?=
 =?utf-8?B?YWxxczNZT1R0WFYvVVJveHdtY3JMT3FOd3Y0MHlNWGgvRWIra0F6Y1daSWs2?=
 =?utf-8?B?b3gzMGtyLzlDSGtuNm8zR2hmNDFlcVR3eDBPZUVFeVVWSzJudnFubisyRWxW?=
 =?utf-8?B?eDlrSjBNUGRBRUxtTjE4SUEra3d4cjhYRHBKQnZab0NzcVhyVnloeWMzRnMv?=
 =?utf-8?B?RlNvMGs2citaUkJ5ZWFGU290azRSNFZSSnpENVUzYWw3cVQ5NzROaThqc0VM?=
 =?utf-8?B?MjNXWThuM3A1cDZaM0VVcml6QTF5aUxxY2JGMWR1ZWE5ZS9SUFBIMnFKNmNF?=
 =?utf-8?B?R3hBWTVyZ3FXNTVqbENIYXZ3S3JIRXVRSFArd0pxdDM5ZU51ZldEblRQL2Rq?=
 =?utf-8?B?UVpFYUdCY2ZpRnd4dm9tWWZBUnU2RXFVTzlGZVVOdUJsR3dsYlpDcVoxNk9r?=
 =?utf-8?B?S0dRcW1QSCtraGZXS25FajE2dlFmMThEcjNiOVkveWpoVlNieExoUlZ1Slhv?=
 =?utf-8?B?T3RjbnNzTzN6eEFkQVQwUVpMMlM3MHA1TXR3bCs2cisyZjJvN3NBSEpYUUxk?=
 =?utf-8?B?TEF0dURZUlJQS2tLYjRmRGllQnY4TXRpVWpVQjh3OTRJSFRNbXVsMjFLWUVT?=
 =?utf-8?B?RmpyU0EvYWlCWmVWNmdJQkprMzNINjJycUg0TXRjV0Rtb2dNZ2pVRkRtWGZE?=
 =?utf-8?B?WmJ2T3BFdVcvZ3RXNk5QWndZbmc2NGJRVXRHWTlpaFlnOEVkaEZOMzFMMzJh?=
 =?utf-8?B?SWtzdjYxSTBhWVpNTjdwbmVUZUtvNzVrajV2OS9wMDF0Yi9PMHNnNFpEcDJa?=
 =?utf-8?B?OVRjMFYvbUhjNlJ0RSt5b1lYMTQwWG5oYXk0cGpHbEVnZTFlRDlYTnpXQW9w?=
 =?utf-8?B?OEFzVWFTU3RnOUlVdkFoSGNXWjRNSzlsb1NoVzBJUDdFUCtPVnU4YTE3S0Uv?=
 =?utf-8?B?UUc4TVpYckgzelAzR1h2dTh2WXRzTWNtNDdWbEppYXRSZ3hyZ2lMalFWSVBO?=
 =?utf-8?B?RVdySnhaY1JZN0owSjRmaThEVHZlcmhLaDYwbGtMQWQ1TTNoL2NtWUgwc3Br?=
 =?utf-8?B?NVIrdzEvcjNncnUzZmRlQlYzUlR2NGhLNHpmY0tFV2g5WCtvV3c3TEFhZTlI?=
 =?utf-8?B?L0JRSzJZNlE5TmJoaVlRcGRJTWlqbngvS3pWM0pyZ0I0N0hpM2ZvU1BDVllK?=
 =?utf-8?B?Rms0aENsQ0U2aW5FRks1UUs3eFFPZkpqakwxdnZnTW14UDB3N0RsMk5Vd3Nv?=
 =?utf-8?B?d3lORFM4aWlRdzlrcG1WUVE4bXo0ekFlZkNJd09mc1dVSU5SYjJEdnFVbWsy?=
 =?utf-8?B?REJWeTJ1M2todUpUZEVKcnNIT0RDVElyQmtQZXJhNjIzOC9PdTZUT0tXY2Vt?=
 =?utf-8?B?YU1uMmtjMXI3Q3RuRkJFOVRSN1FSZGNMaGVTY2JpamE4YWptdUhEb2hCbzFH?=
 =?utf-8?Q?MhUmtI/9lS65OAnsT6dWKn3ej?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a45bccb-e3f9-46c2-7689-08dcc86fa1a7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:14:55.9928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mny6fsAQNVodahvUWN5sdpCFTNSygTUZS7xwupHNuElMyJTxJQ8OBqMhXLbHK+ERX4Te3rR+KFdLzV/IZ0HXcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7560

Extend the address status bit to 4 and introduce the I3C_ADDR_SLOT_EXT_INIT
macro to indicate that a device prefers a specific address. This is
generally set by the 'assigned-address' in the device tree source (dts)
file.

 ┌────┬─────────────┬───┬─────────┬───┐
 │S/Sr│ 7'h7E RnW=0 │ACK│ ENTDAA  │ T ├────┐
 └────┴─────────────┴───┴─────────┴───┘    │
 ┌─────────────────────────────────────────┘
 │  ┌──┬─────────────┬───┬─────────────────┬────────────────┬───┬─────────┐
 └─►│Sr│7'h7E RnW=1  │ACK│48bit UID BCR DCR│Assign 7bit Addr│PAR│ ACK/NACK│
    └──┴─────────────┴───┴─────────────────┴────────────────┴───┴─────────┘

Some master controllers (such as HCI) need to prepare the entire above
transaction before sending it out to the I3C bus. This means that a 7-bit
dynamic address needs to be allocated before knowing the target device's
UID information.

However, some I3C targets want a specific address (called as
"init_dyn_addr"), which is typically specified by the DT's assigned-address
property. (Lower addresses have higher IBI priority, and the target can
adjust this by using the assigned-address property if using DT). The
function i3c_master_add_i3c_dev_locked() will switch to this
"init_dyn_addr" if it is not in use.

Therefore, i3c_bus_get_free_addr() should return a free address that has
not been claimed by any target devices as "init_dyn_addr" (indicated by
I3C_ADDR_SLOT_EXT_INIT). This allows the device with the "init_dyn_addr"
to switch to its "init_dyn_addr" when it hot-joins the I3C bus. Otherwise,
if the "init_dyn_addr" is already in use by another I3C device, the target
device will not be able to switch to its desired address.

If all of above address are already used, i3c_bus_get_free_addr() return
one from the claimed as init_dyn_addr and free address slot. This ensures
support devices as much as possible.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v4
- rewrite commit message and comment for i3c_bus_get_free_addr()
---
 drivers/i3c/master.c       | 68 ++++++++++++++++++++++++++++++++++++++++------
 include/linux/i3c/master.h |  7 +++--
 2 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 2c9d45486ed8b..1dad727e28435 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -345,7 +345,7 @@ const struct bus_type i3c_bus_type = {
 EXPORT_SYMBOL_GPL(i3c_bus_type);
 
 static enum i3c_addr_slot_status
-i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
+i3c_bus_get_addr_slot_status_ext(struct i3c_bus *bus, u16 addr)
 {
 	unsigned long status;
 	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
@@ -356,11 +356,17 @@ i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 	status = bus->addrslots[bitpos / BITS_PER_LONG];
 	status >>= bitpos % BITS_PER_LONG;
 
-	return status & I3C_ADDR_SLOT_STATUS_MASK;
+	return status & I3C_ADDR_SLOT_EXT_STATUS_MASK;
 }
 
-static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
-					 enum i3c_addr_slot_status status)
+static enum i3c_addr_slot_status
+i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
+{
+	return i3c_bus_get_addr_slot_status_ext(bus, addr) & I3C_ADDR_SLOT_STATUS_MASK;
+}
+
+static void i3c_bus_set_addr_slot_status_mask(struct i3c_bus *bus, u16 addr,
+					      enum i3c_addr_slot_status status, int mask)
 {
 	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
 	unsigned long *ptr;
@@ -369,11 +375,22 @@ static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
 		return;
 
 	ptr = bus->addrslots + (bitpos / BITS_PER_LONG);
-	*ptr &= ~((unsigned long)I3C_ADDR_SLOT_STATUS_MASK <<
-						(bitpos % BITS_PER_LONG));
+	*ptr &= ~((unsigned long)mask << (bitpos % BITS_PER_LONG));
 	*ptr |= (unsigned long)status << (bitpos % BITS_PER_LONG);
 }
 
+static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
+					 enum i3c_addr_slot_status status)
+{
+	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_STATUS_MASK);
+}
+
+static void i3c_bus_set_addr_slot_status_ext(struct i3c_bus *bus, u16 addr,
+					     enum i3c_addr_slot_status status)
+{
+	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_EXT_STATUS_MASK);
+}
+
 static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
 {
 	enum i3c_addr_slot_status status;
@@ -383,11 +400,44 @@ static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
 	return status == I3C_ADDR_SLOT_FREE;
 }
 
+/*
+ * ┌────┬─────────────┬───┬─────────┬───┐
+ * │S/Sr│ 7'h7E RnW=0 │ACK│ ENTDAA  │ T ├────┐
+ * └────┴─────────────┴───┴─────────┴───┘    │
+ * ┌─────────────────────────────────────────┘
+ * │  ┌──┬─────────────┬───┬─────────────────┬────────────────┬───┬─────────┐
+ * └─►│Sr│7'h7E RnW=1  │ACK│48bit UID BCR DCR│Assign 7bit Addr│PAR│ ACK/NACK│
+ *    └──┴─────────────┴───┴─────────────────┴────────────────┴───┴─────────┘
+ * Some master controllers (such as HCI) need to prepare the entire above transaction before
+ * sending it out to the I3C bus. This means that a 7-bit dynamic address needs to be allocated
+ * before knowing the target device's UID information.
+ *
+ * However, some I3C targets want a specific address (called as "init_dyn_addr"), which is
+ * typically specified by the DT's assigned-address property. (Lower addresses have higher IBI
+ * priority, and the target can adjust this by using the assigned-address property if using DT).
+ * The function i3c_master_add_i3c_dev_locked() will switch to this "init_dyn_addr" if it is not
+ * in use.
+ *
+ * Therefore, i3c_bus_get_free_addr() should return a free address that has not been claimed by any
+ * target devices as "init_dyn_addr". This allows the device with the "init_dyn_addr" to switch to
+ * its "init_dyn_addr" when it hot-joins the I3C bus. Otherwise, if the "init_dyn_addr" is already
+ * in use by another I3C device, the target device will not be able to switch to its desired
+ * address.
+ *
+ * If all of above address are already used, i3c_bus_get_free_addr() return one from the claimed as
+ * init_dyn_addr and free address slot. This ensures support devices as much as possible.
+ */
 static int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
 {
 	enum i3c_addr_slot_status status;
 	u8 addr;
 
+	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
+		status = i3c_bus_get_addr_slot_status_ext(bus, addr);
+		if (status == I3C_ADDR_SLOT_FREE)
+			return addr;
+	}
+
 	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
 		status = i3c_bus_get_addr_slot_status(bus, addr);
 		if (status == I3C_ADDR_SLOT_FREE)
@@ -1906,9 +1956,9 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 			goto err_rstdaa;
 		}
 
-		i3c_bus_set_addr_slot_status(&master->bus,
-					     i3cboardinfo->init_dyn_addr,
-					     I3C_ADDR_SLOT_I3C_DEV);
+		i3c_bus_set_addr_slot_status_ext(&master->bus,
+						 i3cboardinfo->init_dyn_addr,
+						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_INIT);
 
 		/*
 		 * Only try to create/attach devices that have a static
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 2fac4a45ec600..2c826d17eb571 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -284,7 +284,8 @@ enum i3c_bus_mode {
  * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
  * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
  * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
- *
+ * @I3C_ADDR_SLOT_EXT_INIT: the bitmask represents addresses that are preferred by some devices,
+ *			    such as the "assigned-address" property in a device tree source (DTS).
  * On an I3C bus, addresses are assigned dynamically, and we need to know which
  * addresses are free to use and which ones are already assigned.
  *
@@ -297,9 +298,11 @@ enum i3c_addr_slot_status {
 	I3C_ADDR_SLOT_I2C_DEV,
 	I3C_ADDR_SLOT_I3C_DEV,
 	I3C_ADDR_SLOT_STATUS_MASK = 3,
+	I3C_ADDR_SLOT_EXT_STATUS_MASK = 7,
+	I3C_ADDR_SLOT_EXT_INIT = BIT(2),
 };
 
-#define I3C_ADDR_SLOT_STATUS_BITS 2
+#define I3C_ADDR_SLOT_STATUS_BITS 4
 
 /**
  * struct i3c_bus - I3C bus object

-- 
2.34.1


