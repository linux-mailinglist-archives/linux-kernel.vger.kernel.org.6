Return-Path: <linux-kernel+bounces-175823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4438C25B5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74CE1C21E62
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B77512C481;
	Fri, 10 May 2024 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sD2LSul0"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2050.outbound.protection.outlook.com [40.107.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577B5339E;
	Fri, 10 May 2024 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347802; cv=fail; b=jDB+IGfs+bIbGS8rZ9B096UQVCDOqJkKJbJP4pllJvIm16qRg5dRvhI86E3TIwutb0z4eBZB6oKT8R7Aj9T7TFtNiBTgrBIlnajhB6uWlWHIDi1PAKR+YNOTrzUc+wYucHspID9wsrcJkIMEvFJolpquZtOrvOUKji3eoT9TNTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347802; c=relaxed/simple;
	bh=f2ac9QRAicm5VDNnBecL5v4PUcq/Egt4zE6wms3i1gA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=u3AxLMO+Flug6hYYxJ8TBpsxLecncW0OTE766sSF4dAhsZSEW1UrTE5WQiWCHIFhGLS22Bfm4SxY+SQSAED6x65j2bJHH63hbr+7LXgmCnwCGjW9r1XwleSzyyrFP4rfujv8NPZVI6sxd39o1+P3wBcSLfXOXUBLgxKchT9RoTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sD2LSul0; arc=fail smtp.client-ip=40.107.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNwDUt9WXyqxaPk91R+3R7fLacG2fqb7AAR7/HfS/DDlhkfYUYTfwCXe8E1IKZQQMKB6gTyIX+wzqOXOyqLl9YKSK2wpAx/Fu1u7VIOvMoXuAFQnZ+ur4GgvMNn1M8fPTwamUS7uwiOm9dTJ6LTsljhGNKPcsqhaXDXaLL4lHDDLrqck0WWy22FCAXShoesF8fardGcpiYXDHlcjvIbRuGv5JMuIfOtFMVL8w1j7hOBGQi6p7yepsPs0/OrAGFrAZknGG62Nc5znn4KuExEejSCWa2sJAVz4CE1cZZFtAzgPayMuYnFn0DbUpgErof6uC2TqQJrUAsWYDfflZaHK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0rhxtrNBYZA/9j2JxNXzPtum/qEOv6Nkz5UlpI0iJc=;
 b=gFL6N30WZGt3WuK7AO7JdffNIb0LeuRDqgGa3loXWk8ubgMytZ9xDqoyiNc6xHZdmPopg1tg64IamzmFIETVDiH++/+X1p5v59OGk8PYYluzd/sLzuJ8IhKOyrewry7JnNPRuLWy8B9hNn1JDQALLeBcXkRKzL3NQnpOCNadPEQctha2FgUPhk7o+L7hdukYsU1OaOmnt7yWFYxoxLjbpcXKnrx6OWvZK5juwde6udncYRN0pLoXQ6v2xoBMGiDfFpM5WFfB7Rw20Ceqof+iEsRXQFx/71YB5fDH/Z2KVoHo/kUDCf7DuGjLi6cdIL99lJ2MLL89m8s29VYDkXtwYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0rhxtrNBYZA/9j2JxNXzPtum/qEOv6Nkz5UlpI0iJc=;
 b=sD2LSul0x8mYcy+jBjNG8rPT7fuXVXKzumkRas0fo43m00UJJIA8pGPwfCAMs1cRQ3hUrRw6CDSGeeBVuNH4rYkIjwq+jWOZOr3b20zpGR5LuQKlhmCkArn9+fyPg+uDtaseRS2Qh0rPUIu0zbX8YHaFq+XyirwHziKhAzuOouk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS5PR04MB10041.eurprd04.prod.outlook.com (2603:10a6:20b:67c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 13:29:57 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 13:29:57 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH 0/4] Communication Interface to NXP secure-enclave HW IP
 like Edgelock Enclave
Date: Fri, 10 May 2024 18:57:26 +0530
Message-Id: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL4gPmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwNz3czcCt1ioGiabqKJgYGpqYGlcUqymRJQfUFRalpmBdis6NjaWgA
 Vk2ItWwAAAA==
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Pankaj Gupta <pankaj.gupta@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|AS5PR04MB10041:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e4ffe6-5ccb-41ce-fb63-08dc70f548d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|7416005|376005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2hSajE4ZklEc1Q1WkdEUFdvdURFZHN1M0hEWlZPdTlRNjRMU0pRcnp4TDgw?=
 =?utf-8?B?aEgyR2s2aXNpN0M5aG0wcVZXaldoY0NhQllXTzZUcXJTd1ZEemoyNEJVYWp3?=
 =?utf-8?B?ZXFMekszSXRLdmY1dmVDQUVick5PMkFjTFRZVVpoT2VmM25rMmx0RTJUZkpo?=
 =?utf-8?B?OGRmYndOczFoQjdlN0EwM3VEWWkwWlZFSytFOHpSaTlHbStNUWxySElLcTAv?=
 =?utf-8?B?ZUZHSW5aMVVERGdhZ3oyUUVTNThVWm91N3ZNRVpvSzJvdTUybTV5dlNRakZD?=
 =?utf-8?B?OG5udDJnWUFBaTJ0MjlQd0xCOVFndlhzTmFCTnFwZkhYUmZidU95VEt5T29I?=
 =?utf-8?B?NmdwckZub0lFYmtQaVBHMnQvWHByRTFPc0dwdXdDTEJyazdyc2pKaGJPUFFR?=
 =?utf-8?B?dVo3eWhUMmVkZFl0aXNiQldtNXhzNzFSQ1NTWk0xTzNPMG1MR0VVNDZUa2Nv?=
 =?utf-8?B?RFRMZ2p6UVZ1MksrK21FZU5nd1VaVFdESGdtUjl5cEFqU29wbkJ6TWcrQUVi?=
 =?utf-8?B?bUU5aXBTUmkrTk8rL2NKMXBOazBETzdRZzQxM0E0UnNQK05QOFdpVWFtUGpp?=
 =?utf-8?B?b29MeXNSTXVBN2xMWFE3SVVZL0EvL0hhNjQycUVpREV3QWF2WFVJcXdPWWcx?=
 =?utf-8?B?UWhuU3BuMjVva1d0SUdNWnVvczVadGcraUZXempjdlZoazdjdStWQjJmRjZW?=
 =?utf-8?B?TkZxb1B2R21haUZpRHIwa1djVWdUTjlLRCtZRDBoelZ6Rm4rMkRneUFpbTFD?=
 =?utf-8?B?YlZ6dWFiL2dWajV0Szc4UTRjVVRMZXJZU0ZpZ3BnN1MrRjFQSGhicGVRZUtm?=
 =?utf-8?B?U1UrdGNVbzVRVFY2dS9MRCtUNzJuSjJFRkl2ZXFIbndveVNlbE1sb3ordFdP?=
 =?utf-8?B?MDNyN2dWanZhS3V6em9QMGpnZGs4TjVieWpzQ2V2d1lIaEEzSzdyNzRNcWVV?=
 =?utf-8?B?TDBkbjhLNE5oSE52a1ZQbTZHOStCYkphU2hoWHF0T1pqVnlmMncvQklNSnA5?=
 =?utf-8?B?QnBydzZoRUZZcHdsZk56Z3UvTU9nSmpiSzdTcFNEM24yUmowUkg5ZXFFQWRK?=
 =?utf-8?B?YklGK21yb3ZMWm54dzk5L1A4dHB0N3ZCSk4xWjcvRXNEcVkzNy90STh5aSsy?=
 =?utf-8?B?OGZ3RlFIankrS1FCOWk4ZVRQeksxVDNlSmxaMXdSL29KV2pFbStyakRNa2Nt?=
 =?utf-8?B?Sjl6RERkbWl5eDFOZDAzZFM0d3NTZElPNDdvR0VnT08wWHFLeFVqV0gvbTF6?=
 =?utf-8?B?SlJ4cWlFZG1YeFFUL2JodWxoaGdnY3ZVUWJUVEZEdDBpR3o3RDFsQXhGR2Fm?=
 =?utf-8?B?cGhBUGRGcWZ1emY0Y2k0NVlack1DbDZ4bWRsMnEvclhvNUs4ME5FYW5iUExL?=
 =?utf-8?B?TEhpaHBTeWZkS0x6RG9aNUJFSHdUY1FNN0JmSUUwcUd2THFtT2R6YklRdTVX?=
 =?utf-8?B?cVY0T2dWRjVEK0VhdFJ2VTBLa2lQTVV4WklmQ2tZZmhHY0ZOeE5GbWRqM2xG?=
 =?utf-8?B?ek5kb29ZVlRYRWxqWjJ5eGRwazN5YXJBNCs0aTA5ZVRxMnh3SStsT3dkWUx4?=
 =?utf-8?B?eGVCbEI5aUpRNHk5dVNzclZGWUF0RklaYjdmTmR1MWVuQk9MN1VRWmtVKzdk?=
 =?utf-8?B?SGdWaU8yUGpzNEFjRHhIOVpDckNhQ3NpUC9tZzhoMGRtQjJ0WTBzNXNjUXBR?=
 =?utf-8?B?V2lQNFhDOTgzQ0tUeFp2bmZRS204L2Q3VEh5M0o2YnlMOUtXbklVa09LTTZy?=
 =?utf-8?B?b3ZvaHhzMk5HODJaeFBOQUU0b1RXY1RYQVBLYmgzNU9Qa3BOVHJvV1ljaGMr?=
 =?utf-8?B?bk5NZXJNQm5MV1prb1ZjZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2FlNEdTeVF4L0ZueHNKY3pxRVRBYmtZY0NRcEppNE0xbGJXMXBCOXMvclV1?=
 =?utf-8?B?N1o2SzFnekpOR2NuY2xQUWJSYklEWWRTRGJFOEJkSytjMTRtZFNMWCtiSDdP?=
 =?utf-8?B?ajJRcDJsVVhpSmJvclRsWGxSWG92aTF0U0ZEbzFKY1RxZTBLamJ0UmxqZFBF?=
 =?utf-8?B?dFdpc2dLQzhNV1Vsd2htbjV2TXFTWXNaUk1aZU9MMm9JcmhpY3k1SlZjelNI?=
 =?utf-8?B?ak1BUW14KzRCTU92QmxwODQ5MXA0KzdicVN6ZmRwUGJLTnVPVWRSeUhZSFhG?=
 =?utf-8?B?WU01c0Rwckg5ZVlFbG5hK0d4NDkvK1NaMUxJT29FNndLSzZWMmNweC9DQjNI?=
 =?utf-8?B?dGF1MjVFRXgvMjYyVHFxWUpwMlVmdFZJVjBEL1pucDM3K28vTDB1RURzajFj?=
 =?utf-8?B?d3pWVVdXMm1CSGVvUU1CL0l2Ymo5cVNId0haZnlFdDVBVFY1T0F2KzkxQnBj?=
 =?utf-8?B?RVN4NjRyaGovOVNjZ0czUWpCNkpMQ1dIb3A5NFYrb2hBT3NQQzVpaHlZZ3RC?=
 =?utf-8?B?clJJQ1U2b1RvQlNuQmoyb3lkTU9GZXdVQ3RMUGliUHhIYlkrdHhDelY4T0Vq?=
 =?utf-8?B?aXZrbkJhVUE5UUNIQm4rK2RNL3FHQnU2SFNJckxrWmVDdktMMVNuOXFRSEhO?=
 =?utf-8?B?M1J0ZHFvS2pIeUFwVUNwTFkwRkpRZzZ4Nm5BSDZEbThDSWNERHFFOCs0bjU3?=
 =?utf-8?B?dWJHam90QkFETUVjU2trM241cUM2QnRzbXFjSzBrcHVVWnBORC91dkxweW5H?=
 =?utf-8?B?TWRwMTRGeVdmb1dyamZLVDQ2L2NEZXJuN0U5ZGtvQlJCUkw4T2xtUlpkakI4?=
 =?utf-8?B?aXBuR0ZRdVFHc0VvUHM1WW5qZFk1dkkxZGRFajllbDdRc3Y0SEgyWFhxSXlq?=
 =?utf-8?B?REQyY0JUdU8zT2F0SEdsMWZPNXBBdThBc3NGYjF1UEpXSGRwOHJRRjFyb0xX?=
 =?utf-8?B?dHJqZWJJUFMxVmR4Slo2V0twYmJGUTAzSkdKekoxZmlFeFdjNE8yQkdpUHAr?=
 =?utf-8?B?ci8yanZYSXpzRzBlc0IrRU4xcE9OZG5Pb3NzTi9UR0NESkpDS1phZDJLSEh4?=
 =?utf-8?B?eFVIZmRFenZZY1dlL1pVMTVJcmlsUWU5b095ZGlUaGM5dmYydlZMRW1IcU1B?=
 =?utf-8?B?UHAxN0RmTjV1bkZjUm93TElQOWtKbHlLNDZJenFGaXBPNS96VWRTK2REMVJs?=
 =?utf-8?B?dkhuTWtMV1o1MFpZTGNjdkZvVG5NQWdpeHBWYWtuNTd3SU0xZGNvM2EycStP?=
 =?utf-8?B?MExacmJtWDJlU2Z5b1BwdHJkcUtvUUhBb0FmNWg2eE1qblNsVEc3MlFpeFRL?=
 =?utf-8?B?MHVpc1M3a1Z6d1FCUUxlWGFFOVVKNmF6aWxpMzBlU2t4Z2pVNXl6R2tqU1Jk?=
 =?utf-8?B?NC81OWs2bnZONjVpLzVQZmVGVWNOY1Q1endYZnpCM3pVUnlSSHFiTTVaL0w0?=
 =?utf-8?B?UUtTdzJ5SlhFSnZFeCtYeGc5aUowL1RCNHhucUQvUWNvTWFsYTRqdVhpeTBD?=
 =?utf-8?B?TWwvclNlVHMzRlBXM3lrdEw1NlhueGttVjZ3bno4aFhlNitlcW5GMlNjRGUv?=
 =?utf-8?B?bGE1d1RBODBrRCtTb2FEUHZ0WVhlUm84WHc5eWJ2SnErSlU5Y3NHTE51RzhG?=
 =?utf-8?B?R2c0UGhDcnpzRVJEcElwYm84TzYzM3Y2YTA0MDFoNEtEMjZCY2hqaGlBZllT?=
 =?utf-8?B?MFhHakhhYUoyOHBaMGROOStuaXNTMmh4MWN4aEY0ZUFLMC8vOUVHTllQcFcw?=
 =?utf-8?B?dU1EaFFKZEtUTGdORUxHS1gwWVNoeEVTM2NRYTg3SUg5eGFBa21pcE1nMjBB?=
 =?utf-8?B?LzRidGY3R3dMK3ArL09tbExHS1Vua3RsYVhuVnZWR1czY1E1Z0I5VVRyMVZs?=
 =?utf-8?B?V3RhVERMZ0kxRmhuQVlsZ3RSdi9ZU0pVM3h3cUk3M1R4K3l0Nlg0Vk0xOFpk?=
 =?utf-8?B?M2tncW1YcTJHK3I3VWNKSC9ZbktnTm5hNDN5aUZVZW9BRmxkUmhPMTkrd21K?=
 =?utf-8?B?am9lQjQvVzNPTTRHNmhJYVlNeXMxbk5OeFVodG5vdXZhSHV3cENmSWhqeVA2?=
 =?utf-8?B?M3VzckRwcTVRTzdQQmczL0IrTHd6Lys2NnV2WXNqSVNqNnBVRWZaMERkbFZF?=
 =?utf-8?Q?Jh5dJIGA1jAum3UjRZizuJiu8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e4ffe6-5ccb-41ce-fb63-08dc70f548d8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 13:29:57.2321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNhcbg4xuE9KVK5CWEQAZA3oDl7d9e25szDIzlSvaNSNhbZfpsA3sSr2L32HXTuiQ/6AkiliL88urfEHm0eajg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10041

Hardware interface of the NXP Secure Enclave  HW IP(s) like EdgeLock Enclave,
V2X, SHE etc, is based on the Messaging Unit module that enables processing
elements like ARMv8 core, RISC V core, within the SoC to communicate and
coordinate by passing messages (e.g., data, status and control) through 
these interfaces.

The NXP i.MX secure enclaves hardware interface kernel driver, is specifically
targeted for use between application core and NXP secure-enclave(s) HW. It allows
to send/receive messages to/from the secure-enclave.

Patch-set adds the kernel driver for communication interface to secure-enclave,
for exchanging messages with NXP secure enclave HW IP(s) like EdgeLock Enclave,
both from:
- User-Space Applications via character driver.
- Kernel-space, used by kernel management layers like DM-Crypt.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
Pankaj Gupta (4):
      Documentation/firmware: add imx/se to other_interfaces
      dt-bindings: arm: fsl: add imx-se-fw binding doc
      arm64: dts: imx8ulp-evk: add nxp secure enclave firmware
      firmware: imx: add driver for NXP EdgeLock Enclave

 Documentation/ABI/testing/se-cdev                  |   42 +
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   |  186 +++
 .../driver-api/firmware/other_interfaces.rst       |  126 ++
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts      |   17 +-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         |   18 +-
 drivers/firmware/imx/Kconfig                       |   12 +
 drivers/firmware/imx/Makefile                      |    2 +
 drivers/firmware/imx/ele_base_msg.c                |  287 +++++
 drivers/firmware/imx/ele_base_msg.h                |   70 +
 drivers/firmware/imx/ele_common.c                  |  341 +++++
 drivers/firmware/imx/ele_common.h                  |   43 +
 drivers/firmware/imx/se_ctrl.c                     | 1339 ++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h                     |  151 +++
 include/linux/firmware/imx/se_api.h                |   14 +
 include/uapi/linux/se_ioctl.h                      |   88 ++
 15 files changed, 2733 insertions(+), 3 deletions(-)
---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240507-imx-se-if-a40055093dc6

Best regards,
-- 
Pankaj Gupta <pankaj.gupta@nxp.com>


