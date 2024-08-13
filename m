Return-Path: <linux-kernel+bounces-284102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EFB94FCE9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514451F21AAC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1F21514E4;
	Tue, 13 Aug 2024 04:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EglQ5kIm"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2043.outbound.protection.outlook.com [40.107.105.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5313C3D3;
	Tue, 13 Aug 2024 04:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523769; cv=fail; b=E1FKDYslTWmEclC2r1g9gTofGuKfH3hMtJi8z/TPyKH8guIoXGKjIveTGO2UmPqIUpRBpnELQWUJ3T5NrLiWkB9/KFrP4b9fsK7FqPCAuGpx9CHYXvyywTu3hLWCzY+npNygUza1uni7l71BMlmc/2M6HuUUKnVSKojbYFI0pdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523769; c=relaxed/simple;
	bh=HUSyjtjzjb+ee4VCylv963jLyyT4RVJqAGr9rxkfecE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=c7buqjIDEHWyrPTlj1BySc/tRbIfLTd/o+3QmZwhfJeVyOgfHSXdC/hpLDFmtrjkd6La4jSwcgZbCn7dNvqJA5RszBTutN3QHsNDV/IlxUQmmm7vDtJKhLafN6qfmv2ZTDklY9GDsLZA2LahLX/dZtgwXATSbY043oFmVf1IWWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EglQ5kIm; arc=fail smtp.client-ip=40.107.105.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGyRrMcTzKPSieXyRYJvxxueDjfpknGVrB6Qkr4XR/nA5Gng6X2Q2rqpV6/uU+49gw2a2IVJUEK21iz0+7pdWy1N7fvBHpE1Cy6RqMRmQPVbRzu+b10klzpmlCZ6aKZvz3xhI++gnORGUtXCI2mD9FM1jgt1yfd/iH2wUqLLO9FPyzEKTNnd3toqYcixfQ8XOl/ztc1JTN9lSSVf2yTSeACjnUZCoZ6xte6c0GUCgLGvdBK46J/gcpifU0bK3Y+X5Psl8n2EIF361bXhhuBX3vc54H+F2OykOOLUZbXpdRcsf3KEtTl2KC0xD/5WUZvYPAY4yG7Sp1xJFgzeLB+aPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+ovfP+TQyhKpt0LxW10IbAfrSZ7m95SUPCIVzwSkgw=;
 b=GgXZaYFao5tUohUdKGTVP0h+7VVfIO501C9kd+Ne3lpiKoXI93ImwdEWOGRg9wdnhqiT4/GqPtHWv0oILMm8tqmW67N6U4RxdXFsl4noz0VAuXpT9S/qvuCYNK0joHmb+VgaZZdanEmR737+JsV++9zPwMTjOnW7ghlh0UJS7rFr9fZdj1f1o7ewMBRo8gTgrn8D3+N41WpBmvwNwOIse8mXl/VpnGf8H3B3Dbf6zT7dsF0Yq2cibcZ4x63v0CFkdQMgBaK0VA4JRwQ4vnDULKgv5BaERLD661STHxUpjK1dfDYyJc9mS/DAuWWHzc1A17jZwwpnlfaegvVvchCZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+ovfP+TQyhKpt0LxW10IbAfrSZ7m95SUPCIVzwSkgw=;
 b=EglQ5kIms9/gAyR6N5Jzm9chbDeegq+i7R7CKeILky5nZlN9xv20nv1eoRx5kRBMBcNv/A0mcZZ6dbqWnDRi0aF36S2SGwY+NLm7gUUOTYbItzmAaKFaIRqaPJBcLwz63dYvqIwzOXBkARSyB//Eh2jk+m8fvAiEs5+qvYDgDCg4x+hMvy7YgRkPcjwMNtmM1lHURRvjQIvWRcKWP6xIQLbRgzpsACTLqnWpmf+AsP/7msSMLPqGrxaiuPVwPgzyHjXPEoqt3ppaUSSBwRuhBiFNaPpTOSJqf/aFltQb4RNyNxPT3honjB6WXR64t26lML9UWOlkacL/SxVhflFjKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB10066.eurprd04.prod.outlook.com (2603:10a6:10:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:36:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:36:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 00:35:10 -0400
Subject: [PATCH 15/17] arm64: dts: imx93-tqma9352-mba93xxla: rename hub to
 usb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-imx_warning-v1-15-3494426aea09@nxp.com>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
In-Reply-To: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723523705; l=1507;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HUSyjtjzjb+ee4VCylv963jLyyT4RVJqAGr9rxkfecE=;
 b=AledlYx7Zi7nny/ziIDaG6K2/9ZsZWfsHf/Zb6Hvza5EBX1xhdcgbdqBSqSx8YaE6SKKSTBVd
 mJ+X4IXRC82BN7y27PYXqHqEoTdDz5GHgbfef9B8n0+AMtvIjVn/d/Z
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB10066:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4d4dc7-8230-4d5e-8376-08dcbb5171ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3NubkJlLzhQdFg4aU9nbnBaZ1JUcnNFVm03WkhaYUt3VTY0MHptZm1wbG85?=
 =?utf-8?B?WW52NHl4U2Q3RzRIVTVDVGtGRTFVTEZtZWU4Z1pIemNKb1NGRjg0WUovd29U?=
 =?utf-8?B?Z2t5MVNLWUZxSHJZcDE0K25kdkVNZ21BTms4ZGJhbEJhdWpCTmw5RTRkeDZG?=
 =?utf-8?B?N2JlQ3VURkxNZUlkWEwvZ1YzVGNQSjF0cjJuUzRvSTg5MmZBMjVqTUJZeXM0?=
 =?utf-8?B?WVArL3NWSWRwL1VIZ2pMemZWVkVTeGk0YUNiS1o3cW1kU3FHcmRscmRwNkxq?=
 =?utf-8?B?aENOQklhWHloRGVLNWY0TlZmZ3RjUDc2NllRQTE4WFVEZkFteGNPd0RtcDRp?=
 =?utf-8?B?SHlXQ00wL3pBMkJWd2s0cUhFRHgvQW10T3Q5OHRhakhwUWFSZE9nRStlM3o0?=
 =?utf-8?B?cFNtOGF4MDhvK0pVNlNocWVmWE8yNlNsY3EzM0NjSXYxbHlXc09EQmN1L2d1?=
 =?utf-8?B?a1c0bTYxZVdCaytIeVczNlFyQ1lNSlQvOW5rQUJSU2t6ZG1MbkxmSWVndlRW?=
 =?utf-8?B?M015RWN4ZmxoUWhZblo0RDZ1QTJsOXExQ1N3dVZDREhwTGpvckRJUkdWZnFV?=
 =?utf-8?B?R1FqcHFlcTlVYThsazZWK2Nrd05xQ0MzZVhVbnBzZW1oQVIxZWhRWkx4dzlo?=
 =?utf-8?B?QUFOaWRrR21HTXdYMm94djBiVlJ6RFRNSTZHUVd0RXBnTTdjNU1lMVpIbFY5?=
 =?utf-8?B?VzhwaUpzZWZuR3YzZ3dVVy9mTHJZdU1OYW5lTGZZNEs3OG1idTFoanpYa1lW?=
 =?utf-8?B?a1J4WXYxbDhRVmcydUt6WXlpVVlmZGlrYTN0VmNySDZxcklaWTBSN285OFJp?=
 =?utf-8?B?V3VBU1dDeWorVjFjdU1yWjUrdEgrVUdMRnhsMlZhbzM1aFV4V1J3WVAzV2hO?=
 =?utf-8?B?N1pSSk5hT2VpUkl4dFZBK1FNaHdMNkRQYmUvRUV5THVpN29xM0R5OEw4ZGhm?=
 =?utf-8?B?Q2xGcitEZVo4OGtDMk04NzQvbkxxd25Oa3o0cXNrMGxaTVJCL2tzMlNPUGJx?=
 =?utf-8?B?SG1VbDZ4aElhemxjZCtwY2VFNjY3SWlCQldGZHFMUmpYZ3VLMlNUUktvRnRk?=
 =?utf-8?B?anE3QThqcG1MZ1F4d0dMMWhWVEZUVTlnNEF0MjhVcFVkQ2draHJ0Sjl5czVs?=
 =?utf-8?B?SDRUcHJ5YlI3ZExwNDNGNStWdHBqeHBWdit6dmZVNFFuMjlRQjZld0F2OEl4?=
 =?utf-8?B?UjRsUGFIS2ordlE4SDFuNVVMSTZKWEUyZCtMVVNvUVY2NE9Kd3JhS0VmNmV2?=
 =?utf-8?B?UmlIUkVyc1hKWk44aHloYjYzM2NkcitqbEl6VE81MlE5ZGtMenhTQlhLSm1o?=
 =?utf-8?B?SVZZTGhFeDZRZTVVOEUwQmZEeVhjMGRmSDZJMlhZSytWeE1oSnpWb1dtK2dk?=
 =?utf-8?B?bTArZDUrbjM1eVozVmlQejIwaHBGbGNESy8xN2gyb3RDZnJ5OGVuRFlCNDlF?=
 =?utf-8?B?cDlzZWxsVTZ1UEtWYlhoZGYvNUo0Y2Q2NkRMUjFvZGROa3hRaHpBWFhtdnpk?=
 =?utf-8?B?SU00QVZlZXRyekE5SXdxSUVxZHNJUWxEZFJ5K0ZaOWV0TTYzNk9XN0lVdWdM?=
 =?utf-8?B?M3ZnRklOUmEySWpYcG1xVFFIb0xHLzVuUHVieGUrU3Y2VmZ2NDFXS1orVHM2?=
 =?utf-8?B?UXhRWXQ0RUxTNWVhbExFRG1oRzhSazQwVENMZ0tsZUtQajlPQ012QWxzVUtk?=
 =?utf-8?B?R2NWTXBQNHhVdFkrNzAxLzgvTVl4Z21sbGRESVhNenNrQkxJRkJUUytIbnp6?=
 =?utf-8?B?ZXhIZkxkTDc3eUtMM3JmL3ZVeHdsalZuYWZsK21uRTJxdFRqbHY4Q3U0U3do?=
 =?utf-8?B?UzI3WGxNdjBIVmc2OGk0eUVNS3Nubk5QME9hVmxrMHMzYkk1d3huaEl5OWdH?=
 =?utf-8?B?b3V0Z1JkNnpweElmOVAvWXVlTUNQd2VJNmpyTGpOZXlKS0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGRqZ0p4ZXRKZXltaE15U3lxckZNRCtScDJEZzZIcTZhTlBWdVNCNnNHaWx4?=
 =?utf-8?B?ZXhyQUY5RGZjYXFIOGJQK3BlV25DNmtpZmtXR1F1U0trTFM3bjRvMU1kLytt?=
 =?utf-8?B?NVJaVkV0cTQyOWRTbXpyQ05YL3NaSnhkSHRHcExZeGVlZDlTVTcwUVMvNldp?=
 =?utf-8?B?S3B0dHdXYm9EZ01VRnB2SHVUN1AyUXBuWURhbC9TaHE0aVY4YmxxZnRkQSt2?=
 =?utf-8?B?bTVkOUlBQTNQQlgyUDAwVThZYWg4N0NFanFBTjJsUkhSQWE0Wk8yeVI2T2cz?=
 =?utf-8?B?OVdjYnlEeGd1ZzBPR3dYMnBkRXMycWJUelFabXdlYjJ5bm05YmNGNTBsbmVw?=
 =?utf-8?B?ck1xQkU4V3N1OFFDeDI3UEZaemNHNGx4QUIrNGF6MGwzaTFHckc5UXdxQUVy?=
 =?utf-8?B?MGdmYUFCMUs5RisvajFCajN0cEk0bUFkc2NHWXIrMjRxTFRYT3ZxK251dVRJ?=
 =?utf-8?B?ZWc5K0VpMVNJbEszRGdWUE9HOTVoRVFhczNlMHJCN0dmSEJRckMwOE5vMU9J?=
 =?utf-8?B?Z1BINlA1dkF4NEhteGdVcENsdzk4V2kraURVbDBDN0YzOG5hSkIvUEtsZnNj?=
 =?utf-8?B?TjZJZnRDVGx0bmpsM3lUZHdOdG9GSGlkZVp1Ylg1NVRaNzQzRi9sSno4eTE5?=
 =?utf-8?B?UVViRlpTRnFrKzlQTGVvSit3V1JNa2xaNlpMd2N6VlpFY29wQnFlTWkxOWlV?=
 =?utf-8?B?dFVNcHJRU1UycVBPOEN6ZmJxMnlDNDJlbjQxRVg0eVpsMCsrZFA0WTVOYTAv?=
 =?utf-8?B?NDNFNWF3K3oxdmhHM3hrd0NuUmp4WDI2ZGk4YS9PTmpJTXNNVDd5ZjY5d2FF?=
 =?utf-8?B?YWMrcHlONkZFbzVuNmtTWFJjZ2VOaUNhdmUybDhTT0N3aXh2NWJBalFVV1dQ?=
 =?utf-8?B?V0xhU041eUIwQm0vZDhUUXZXa2kwRjhTcE8xaURHdHBROWgwUmRmOU8xYkR3?=
 =?utf-8?B?eS9sWG43YmpqQ3NmZm1QYzFwNDRCUlNrZ0NsTFIrU1hsK2haRjNRa0hHTUti?=
 =?utf-8?B?K2ZYZDB1UGhjMUppSGJteHlsZTdObGh0Q2gzQWxIbDlYZml1ZFlFbGZzcllp?=
 =?utf-8?B?Y2tVTjk5bTdLN0JoM3c1d0k5ZEVYUmFEbi9ZdVpodzBESXJXTEI4NzF2YzZJ?=
 =?utf-8?B?MUEzR05jaU1QWGVXQXJ3NTB3RUpKd1NZNzhPSW9yOUIvTDQ4ZUVSZ0IrNlFV?=
 =?utf-8?B?L3dlZXcwL1hwY2tLU2dlbmVZWE1peUo0OG5zcjhuTjJwS3JXTGFnS0c5VUFm?=
 =?utf-8?B?Unp1WGNUaGlEa1NZQlQ2K2wrcjNZeWlsRUc5cHB0NW9zSkF0WDdVQmNBMG5K?=
 =?utf-8?B?N1gzbCtQS0FhU0cyTEJTa0VyajRVWG43MGhkK1JRWUk2Yk1nZUt5a3Nwbklz?=
 =?utf-8?B?MHNPTkxBRkdLSUd1UnVhK09DVjZENkVkbXlobllwdGI2czlLR2F5NERQN2lw?=
 =?utf-8?B?a205RkVkcFlkc3E5TG92VHo0R3lXa3ZpNVhkRzhJRTR6Qm1JaFVSV1M2ZDhI?=
 =?utf-8?B?czhTc0s4bm9HL3ZrY2RqYWpVL0k0aFp5Z3h6YStsck8rYTNWcEtROHd1L2Rq?=
 =?utf-8?B?aStTVjQvenVQbHhEbjVWU1hUTUNCL3R5YjdBVEE2RThoc0cyQys2dG1GdDd1?=
 =?utf-8?B?VWZuVHRya2pHR1h4MktJYU1lQ29zTzdLbXV3STc1TC8vOVQ3UmxFeGFEN1FB?=
 =?utf-8?B?UGdhRVg5N1hYbUtXd1BzT0VqeDl5cVdDdXZ0Ly9sZWJCQjdPZlU3Vk5xL1o0?=
 =?utf-8?B?NW9lcFRVeFd1aXErUEFMNHVkM01oZ2NJUWtlUkdtb0ljQzVESnlDWi9KVzhF?=
 =?utf-8?B?bWQ1SmoyM3MvYnhZVC9LM3RxUWxrNmxqQjRkWTdmY2VWUVdWL3ZkUVZwQS82?=
 =?utf-8?B?REFiWEhqNmFPNy9KZlQzTUJTR0JPNlZLcGxqVVVGa0ZybnM2YUtEVlo0WCtD?=
 =?utf-8?B?K0w1MW4xMXZxdElUNFNJSXpmV1p6a21aWno2SXdxdHRxQWNNN1BjSDlnSjls?=
 =?utf-8?B?WGFVSkRqV1FHbklNdHIwamJqcHFvQU8vNStpeGNkTmlFWWhTV1o0RE9nOEhp?=
 =?utf-8?B?dUE5Ryt1UDc0aEZqRXBJcHZFc1o4dUFQMUdZU1pVOXhPNVg2OTBuYlYxK2Zx?=
 =?utf-8?Q?Q2t+Q7NpGB+lrlkAL84/G/3Bz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4d4dc7-8230-4d5e-8376-08dcbb5171ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:36:05.4901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTE/aOFgzoLqd/I3WyZZ2fcQ68R9nZsXdCi5+O4cNStB09FUJ5Sjdnq7VwLry0YUyVVFusWLQfnVSm7lzYSPeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10066

Rename hub to usb to fix below warning:
arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dtb: hub@1: $nodename:0: 'hub@1' does not match '^usb(@.*)?'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts | 2 +-
 arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
index 852dd3d2eac74..325d8097bf7fc 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
@@ -533,7 +533,7 @@ &usbotg2 {
 	samsung,picophy-dc-vol-level-adjust = <7>;
 	status = "okay";
 
-	hub_2_0: hub@1 {
+	hub_2_0: usb@1 {
 		compatible = "usb424,2517";
 		reg = <1>;
 		reset-gpios = <&expander1 2 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
index da8f19a646a98..b1fcbc12bd882 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
@@ -486,7 +486,7 @@ &usbotg2 {
 	samsung,picophy-dc-vol-level-adjust = <7>;
 	status = "okay";
 
-	hub_2_0: hub@1 {
+	hub_2_0: usb@1 {
 		compatible = "usb424,2517";
 		reg = <1>;
 		reset-gpios = <&expander1 2 GPIO_ACTIVE_LOW>;

-- 
2.34.1


