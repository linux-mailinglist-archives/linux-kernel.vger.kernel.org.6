Return-Path: <linux-kernel+bounces-355500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E2099532F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFA61F2679F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419B41E0483;
	Tue,  8 Oct 2024 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aDHwHjT6"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFA31E0081
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400733; cv=fail; b=rt+O5Nz302HmQ3pS6QuP9zGDoB54QiB2ThgbWPa79MkkEhn56PuMLNsbxHylFgBBBqejn6EekQhCYTtPWB07ix/PJDrxO4GuYQUd2xdzOVdU88Ppfd9ovmlLoQDf6VrsE/lPHyOkOmNEN8Rae/1Zk0LAR7FwF35coK8MA12Zsbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400733; c=relaxed/simple;
	bh=mJQ2NVwjODXELkcDKNUIEYw/DZI0LGJGAQy+lGen7bE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LDOR8qeqr0IzxFkJSxSrw3iv1/fWiN+s9D/bqiPge79thF1Q+3PbvVh5RWxNfs6qmpEbX8MxADk9keC8zZW92QK6tX4Yq9tylEDnE78aRNfgZBvvJ1g4cgBnckHEcGhfTyd31CnJbGrK1PVZQYjeseCG87Xz4XCYan+O3d1Srbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aDHwHjT6; arc=fail smtp.client-ip=52.101.70.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2V2LYdcjEA0jgBTzCYfg8KcJF2zvjpDwo2mVgvhaSmCZKlUMQ0etZ2QyeZnexMjkKgmPUboBIiRKg/w1jsMAjXRMSM2ksreHo83yhMI3wpedEPsOeqRzaux6E3YkacWhEeQPKljlPz86VnSOPaRS1T7lf7gosqnoKxNkuSGhd3nswLwR3wXUokHk4p1dWSnJwt39H6xrB3WPLmU5Jk7x5wIsDMoQ9wqMB2VWmmFNDQFk/TxchVQqJYERSgvubPthgDQPLanL/T6xKG7w8awbp+qQdo8Yp/Vj5vEONm+EOtvKTceLRsQZ2NcBJa+Gqz6qPFGXuE8ueYIF9vvA/qVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtrMS8OXbe0qcYxmNRu2SlrZq9vhMYyZCg5B65vBMeY=;
 b=soocErKvx1hSo5ye/7oSqx8Y+s6/UooqD4cj5i35hKZSTz/a3KB9YZo62cQTGShfOjSyFcx+57tuh2TAjLUfHZyr8yuVeVCNoMPwirporRDydLcyxxl4qzJzwtDmDQ//WPnhRg7bRo+++TZAt9FZVXNydQU0udEySLUpbilqKU04GaagRN8yHqdmFMPOtkrmeOpMvcKNi6EQwhTAigFJvvZD1Y+PGVJvkfLBp9SOQAL/F5AvnSAQ/ZaANad6BoF4wZleZYrSM8k7hdMLXRwE2Eo0TjlJ4eRz+StH6M7qMxnvNWSVPFiJtdIoRvlyaOUTgyqBmGcfZCjXjTUClKI0MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtrMS8OXbe0qcYxmNRu2SlrZq9vhMYyZCg5B65vBMeY=;
 b=aDHwHjT6R3oBw8A2rX3nt/STBxD1aODnZtXarkBNXrJnYeR7w1serANqLxLcPPqcngJgJXUI4lqXfgFEkiFM9GL/rt1tUOYWSsM7BiM0E2Y4VRGLpAn0OhpgF2WBXlUsFtXGI9ZiRD1+IQcMjhkcI3bp/ZOVgQ02DyYJYOuKXTsWjjeuh5jcucUePo9kf+L+CyjPI8auPAmqUucyjQjGwC3NgZBkfWtP87l4+Z150taaSsnPeY3EuOZHX0R9euH4TsCBqz5HTgVYqcMZQFx6oGh91u5JS9+tj1TGBvYzYoLdG6FZT/o9Qq58dUFNvkEHMgxbySHwgv1ZmZ8+5GIt7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB8PR04MB7194.eurprd04.prod.outlook.com (2603:10a6:10:127::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 15:18:47 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 15:18:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 08 Oct 2024 11:18:24 -0400
Subject: [PATCH v7 1/3] i3c: master: Replace hard code 2 with macro
 I3C_ADDR_SLOT_STATUS_BITS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-i3c_dts_assign-v7-1-96ec93d1f34c@nxp.com>
References: <20241008-i3c_dts_assign-v7-0-96ec93d1f34c@nxp.com>
In-Reply-To: <20241008-i3c_dts_assign-v7-0-96ec93d1f34c@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com, 
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev, 
 miquel.raynal@bootlin.com, pthombar@cadence.com, 
 ravindra.yashvant.shinde@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728400720; l=2178;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mJQ2NVwjODXELkcDKNUIEYw/DZI0LGJGAQy+lGen7bE=;
 b=UnbOBSsYXxfymZwvnMKhf6Sj/J6XWt0gN36MJyZunF41KlP0gmWvL/QhEQ82FL183JmvlROKG
 00ALDPU/NVyAP0Zf4eLkR/JyXjkaQxwKyAF7afIoDtL2fERVCQmqUcR
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0101.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::42) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB8PR04MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3c7333-6db8-4aa6-61d0-08dce7ac8156
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YmgxYk5jays4cWFad0t5Z0laTUxERHBqL2ZmVGxRMXRublZ2ejkyN0V4czlT?=
 =?utf-8?B?ZHM5dVZCRFB4Q1hwMmQ1ODlZMEZySEptRjA3ZkdiYmRsbnBsN0hvZkh4cVRU?=
 =?utf-8?B?eHlJNHloOGhza1M4WktRSVZxTHZJRHFaM2xZM0VxRDJ1MEptMnJaVng3ck9F?=
 =?utf-8?B?eXU0T2oxQm5uK3FJZnk3SnpXQjdoTmFQMkJJUlJMNkZBNVdUcGdoU0Vic3NW?=
 =?utf-8?B?ZmRLODRvbm80NzR6cFBsSk9XdFVXait5eU9rWTlCazdleE5sTnlIMXE4VlVm?=
 =?utf-8?B?V0hoNDhnbTFsNGtuVS85ZzRYSGczVUhUUWRKQ0ZnSGlUcHkyVUFLQmpoTXgr?=
 =?utf-8?B?WUlIQnJDR3I2eWJOUk1BdHVzNmhvTVg5eGN0bGZadWY1ZjAvQngyYnZPZDFp?=
 =?utf-8?B?MkhWSEw5NEozbzN1NExSWWc3cGwrY0RmR3pXVjVJUHZzNTdiOTZEVW56eTlN?=
 =?utf-8?B?b2NMWXVSSk01aEppUWJaaXJlSUt1L0RHS2d2d3dMbHFoMWludjZEYWVYR3o1?=
 =?utf-8?B?clNrcEhPblpvK08rL1djMXc0REl2dW1rb2RTTHJaSXpMdFZZVldsQkh2dGto?=
 =?utf-8?B?OXJDK1YyYXQyWmlQclNiUWRqWStQUnhTMEdKQmFHQWFjNktzQzZuRmlHNDJI?=
 =?utf-8?B?SzZTazRidE82WEd1dUdsdWFTQWtud3hXNHBZaTJ1M214VThwYVdBYWVQN0dv?=
 =?utf-8?B?RkVPMEFBdlduZk5HNzJxa1NsblNHZ1NNNDZzSldJdnlyYldWcHE2WE91dzdN?=
 =?utf-8?B?dFBsS0R3R1lKcVRiZU1OcGZQZktpb0tsbksweUtCWkFEZTNGVlVOTlhrU0xu?=
 =?utf-8?B?QjFwVWRLZ0ZrMnhBS0ZmZnBORHBxZE93NEkyZEZkTTBXLzFhMWVjbGVZUWt0?=
 =?utf-8?B?NEFQODJYVGJpNWg2cEVSa3ZNTmRKM1ppblkzSzg1SUdzL1ZPSTcrZFdDb0Vp?=
 =?utf-8?B?cXcrUG9JZkxkaXMvdVJzb3E4L1YvaVA5UUs1c0REU3IwSENIVytDS0ZmU2R0?=
 =?utf-8?B?akw4SEZSamNraWlkYlpFZ1dpTitZaVU1dmV3VmdrejRyTE5lZG1EVlZpUEdE?=
 =?utf-8?B?VTZsSkQyV2pDVC9WM1BUYU9uSmhpU0Y1SXhBWFdzQnYwc0x4ejJIL3g1TjBX?=
 =?utf-8?B?UDdwaWY1QWh5L0c2L1NDMVdKOEpJdi9uVGJRZ3ZVWFlJVy9VbnhIcHA2NElD?=
 =?utf-8?B?M29FSXNJRnNiNVFZZHkrdXl5eEF5TCt4c2xTd0NpQ3VUUDQwbXQ3L1F1Qkk3?=
 =?utf-8?B?eWl5Si9Nd3RWRlhMQWplNmNnNGVhcE9iUVJ2NFVFeS8yVGZTdTFZdldYa3Zh?=
 =?utf-8?B?Qklla0wyUXZJREIyaityQUNOK055bkJBaldwekpkdjJjcm9OTHlyeSt5NzNU?=
 =?utf-8?B?OVB5ZVB6RlA4dUQ4Yzd6c1BlRlpBaGh3Yy94bFQyczFKSDc2RDZ6UGZzd0Er?=
 =?utf-8?B?bGxrbm1BS3lnS01ldXNuMStNTFgvWDg2QjZyNk1rWmwwZjJKWDhJNG5xbzFM?=
 =?utf-8?B?cWxjOTZwVkpablJNb0djd1VHditWRXlRV0FUK2h5WEZvQy83aWw5T2F0TitY?=
 =?utf-8?B?dTNtWVdvcVFjZEMreU1VYkNUYUVCaTcxOXJDNzYzMVI2YkgzN3pYblo0ZFht?=
 =?utf-8?B?UC9BcHZpV1B4YXpzNjkyUlVRTU5zcG5BcHZtZkNSNGlmSzBQaDI1WUJ4Uis1?=
 =?utf-8?B?bDJEcUNMT05aL2crdElFR2ErVVRCdlZrczRDNHZ2L2paeWpweGcyUUMwMTNk?=
 =?utf-8?B?dlhQMmNaRUJSZXZZWHBvUFpMMHd4OE8xM1NORnZaSWZtdWI0OThucGFXdlpr?=
 =?utf-8?B?dDVGR3VpQjdtYW1Jd1Y3UT09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TlY2M3ZWUCtmQmlpcVM0Q3BzWDFvY2s2ekViU2xQTk1FODVLZHFEaEpXaUoz?=
 =?utf-8?B?cTIxaG1YUUE1aC9lb2Z1ZmRYL3cxY2Qwck5WYlJmN1U4bzhJOTEwQmgzN1Ez?=
 =?utf-8?B?VWVuYmFYMWlOYUVnNEFIN2M5czRSUmYrUGY5T1lFTTlrWTg0OUlEMENpMXFR?=
 =?utf-8?B?WVNZR3lWNjdkb1R4NGtUMmJvUjZ3L1l2ajdxdVA0S3BjUE1FdXZRSm52UFpQ?=
 =?utf-8?B?ZkpodU9VKzkzTW1iWTJOOUlxT2NBNldEVzZyMjNydDlNUUZMWGpGZFhBRndj?=
 =?utf-8?B?ZWNRRVJ0UlhESHVMTTVzV0VnbHRCSUxQY0J6MXUxVTJUaDdzVy9NVGxHcjlK?=
 =?utf-8?B?MGlNRFZOeFNNTnZ3YWh0VitqTks0RjRqMTIyZ25RRmQyYlNvRnBxdWNtbjdS?=
 =?utf-8?B?emdaMjlOeDBBM1B2UkJDaU1oQXFLWWhuZzNiTk1lQ0FMYVJPRTM3YWVVVm9I?=
 =?utf-8?B?Ym80TXMveFpZdGd3Q0FOWENtT25aUW1qWjVQWk43YnhDQ3ZmZDlYOVRWOGhx?=
 =?utf-8?B?VlI5MHNZQzlPcFd0dDJnbFJjZ3ZLVDYxS1I5cHZmT3krVjl5Ky9UTG9QY1d1?=
 =?utf-8?B?anNac09RbkZ5Tmh3VFg3aXJHaVdvaWN2OGY2MVVXWVZOYW9UdWhKYXVzVllK?=
 =?utf-8?B?NVNFMVJUS0lwY01wb1N5eFJQTDVTN2JaODV6bHdoZ01mbHNmcnpJU0xGNWx6?=
 =?utf-8?B?QkhoN1JZM09CVjRNNU1yV1BvZ2Q5U2grN25PUTNPbWlvcDJjNEppU2dxRCsr?=
 =?utf-8?B?QWhjcWtEWFhORmNZazZQSzdidmluTzk3NnNYVmZtRUNuOUx0Q2lYNzZBcGVL?=
 =?utf-8?B?Z1JsS0R0cFE5LzRmVWE0dFBpb0EvYUpFRk41Tm5kdUJ1YmlpeEhUWDYzMEla?=
 =?utf-8?B?YWszSUtjSnhidkhsWFpPYnF5SXBWajRZS3YzU2lTQWNtREF3NzdTWi9oTW0v?=
 =?utf-8?B?YUd1Y0tydzR0Y0JmQ2Z3bHVPVk82NHAzRFhZQXV3N3U5dDUySkw3eXhxemRk?=
 =?utf-8?B?RGFIQXo3WDdOU3V1eEYxRTU0Zkpqb3RPTFM4N211cDFoMXNyazNPSGd0YU9V?=
 =?utf-8?B?L3VIZXdiMmtORWswcDBrclRlSVYvdXBJK1QrMkhCclR0bVdZN2xWV29ob1JT?=
 =?utf-8?B?cXpiT1NOUmNFb1JRTkRRVzljSk5ITWlxTDVXRlVyRFpaQzlZQ0Q3S3dSdDY1?=
 =?utf-8?B?MDc1T2NQU2x6dnJrZC9YM083VUEzYkJ1M2RrbzEwMHlaVEpCenJZZ0dqK3Uv?=
 =?utf-8?B?dEhyL2lZa2dVc1ZwTTQvR3hSemY5dnBTWGFpaFNBUUIwY3ZuSVBoYTc0Rm1n?=
 =?utf-8?B?ZGMwaklCNGI2RnM1eGR3UWdjTmhVbHNuME4ycUlWaXF3dDd2N292TEFRd0hi?=
 =?utf-8?B?dVdMcytJcVdmdEd0L1RNZGJMUTRIUzE3K2srTU9xZWQzbnNSWGtMUHRRMFlv?=
 =?utf-8?B?SG5jZVdteTQ1ZWdBbFl0WlBIMVE4YXorbnNWVUFtZS9RenlFcW13a0d6b1Rn?=
 =?utf-8?B?c0RtUFhKYTRXUjVZOElKN1JJd3IzL0RjRDdZR3RQZ3o1NlFqOFNMSlBWN0Ix?=
 =?utf-8?B?WjZpSm1Wc2pPYmNyM1lRcGtnSzlZcThDZmdGWnQvQ0V0MGpFeU4rb0JFTjRh?=
 =?utf-8?B?eUp5eWNXaGZ2Z2dBblJDZklMby9Ic013dk1iek1Pbmk3MERKeGdvTUZwVjJn?=
 =?utf-8?B?Vjh6d050K0VvWFZ3YTJHK3VhZ0MveWJEZ0JGSUpnNnY1aGF0WUpxbVcxcTVL?=
 =?utf-8?B?T3hxakdIcnJjQm4yNlpoeGNKMVVwYWhMWTFPTnVQSzhlQ1ZpNmJ4UTBycFFC?=
 =?utf-8?B?ejRnR0xvZWRDVkxXbjZiYkY4NjRWU0tPNzJvUlZmNU1MVklxT1dhK3NpRVl4?=
 =?utf-8?B?cCtuY3h0ZlBvM056VVdVUW5OTXU5a2k3ZGZRTmU4V096UHZYUEVTRmVCeFow?=
 =?utf-8?B?a1hOS2UyS0pHQjk1aE82TEFsNjZxMmkyWjdFcW1EcDNUZXpqWXZQdmltdGM2?=
 =?utf-8?B?ejF4V0toSVk3clE2MSs4Rml1THJ2Z1lLVytzZm56OUI5eU81MURPWTdicWtN?=
 =?utf-8?B?ZlNrRHQ3aUJGK010VXpCQlpDTExGZXl3amxlZk50UkZuWEtIalN0R0xOcXlk?=
 =?utf-8?Q?ob74=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3c7333-6db8-4aa6-61d0-08dce7ac8156
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:18:47.1137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Yj42lLtg32gIdIQBoCSe6mwHyiSIugfzpGMYfpN7YT3u338H8Io7SMOIX4AiIQigdtMLWmi9PfWTfcuWLz9KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7194

Replace the hardcoded value 2, which indicates 2 bits for I3C address
status, with the predefined macro I3C_ADDR_SLOT_STATUS_BITS.

Improve maintainability and extensibility of the code.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v6 to v7
- none

Change from v5 to v6
- fix version, should start from v5
- add Miquel's review tag

Change from v3 to v4
- rename to I3C_ADDR_SLOT_STATUS_BITS
---
 drivers/i3c/master.c       | 4 ++--
 include/linux/i3c/master.h | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 6f3eb710a75d6..dcf8d23c5941a 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -348,7 +348,7 @@ static enum i3c_addr_slot_status
 i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 {
 	unsigned long status;
-	int bitpos = addr * 2;
+	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
 
 	if (addr > I2C_MAX_ADDR)
 		return I3C_ADDR_SLOT_RSVD;
@@ -362,7 +362,7 @@ i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
 					 enum i3c_addr_slot_status status)
 {
-	int bitpos = addr * 2;
+	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
 	unsigned long *ptr;
 
 	if (addr > I2C_MAX_ADDR)
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 2a1ed05d5782a..2100547b2d8d2 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -313,6 +313,8 @@ enum i3c_addr_slot_status {
 	I3C_ADDR_SLOT_STATUS_MASK = 3,
 };
 
+#define I3C_ADDR_SLOT_STATUS_BITS 2
+
 /**
  * struct i3c_bus - I3C bus object
  * @cur_master: I3C master currently driving the bus. Since I3C is multi-master
@@ -354,7 +356,7 @@ enum i3c_addr_slot_status {
 struct i3c_bus {
 	struct i3c_dev_desc *cur_master;
 	int id;
-	unsigned long addrslots[((I2C_MAX_ADDR + 1) * 2) / BITS_PER_LONG];
+	unsigned long addrslots[((I2C_MAX_ADDR + 1) * I3C_ADDR_SLOT_STATUS_BITS) / BITS_PER_LONG];
 	enum i3c_bus_mode mode;
 	struct {
 		unsigned long i3c;

-- 
2.34.1


