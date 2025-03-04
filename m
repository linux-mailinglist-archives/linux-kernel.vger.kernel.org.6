Return-Path: <linux-kernel+bounces-545675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BD3A4F008
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847463AAF5E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB3D24EAAA;
	Tue,  4 Mar 2025 22:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="aQiWPhqB"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020105.outbound.protection.outlook.com [52.101.85.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A081FC103
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126849; cv=fail; b=I/M3HGIBpSSp5Zw7uzIunWwt24K+wIm8q5067zs926oejuhf4f6I08R2osUzGyTz6U4C/VJknCLGDhkIUH5KdQ3Mab525n6Re2S+gMJLXR5XDQVdVxit21BwflzfSCnDUIvbwFE4C/9Y91qqxAFcDX13Ny47zVTlcLKSJpCuyQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126849; c=relaxed/simple;
	bh=EJJrxPVsBwMQKFcPdyNuAz4kijiw/YpMLXq6vdBlJ5A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RRaPGiJ1bbd3q++EfRGw/QYq9vSOIxiRPCSCccnH87D9Dfpd5X5qVkTldS+63JLZy3VChPEuI7kMwECuHU9H0ahXyOpmoj/XhsHS9fAz5dxB0Sd658fz8bofanJRG1awhQvHnKqIMdC3GLOgx64juiDOhbEa17v2PP1QG+o3Xhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=aQiWPhqB; arc=fail smtp.client-ip=52.101.85.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qptUxtuiyliB0IHBf+YgkI0MorLTDfBnXcTi82Z+W0DMV9Poh+gCuKfrr56sP+69coO8m6qjlRd0oczKtBXR++WvhJb62KJjQI9U6upgZ0aJCgCVz0xxvP8xAu/SoQtNNnYhb6yaNpejMvRu4m4jI/0lP4Gz70hxjd8KG9w2mzZOITsm5ohEcFrxjHuEUgVChZaIi6q/p0iCr8pQyzap3gn0ng0s1ZVX3h2fOzru7vFyMjnErqwvjeRnGP81Qm1uccuH8o1JvM0VITeCdPJ/qCX4ukFGOQcmKJ1vzAQ+7c5gnJvevSR3/mT75WUQqiVw+YldzlLYRzvk5ouJF3HYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYou3N35PhCOYtx4Ld/uaGKFWQt98y/q2GbA/qZ/5Is=;
 b=fYXGteuZaPGnfu04u59sHqTDgV0e52KgdkoLtq1JVCrAjs3sACJ9GeEea7+nMJr9jqEpYBJ37voXZY0HXPOssl2rp4lAfJXl0phfmuZ2kGuYUziBB5mbSKNXn1AufqdQtnACyPiiLtcj4U+16awZDV4U67EkZ4R3N8XYoVVGVq5vMaFALXwi7OzDbD+4V4zqMsuPurw7t+6cCK3RJrLL6GcJBbf25+RhVOmgkDwvW2gRyCyeJxzxN33asiV+pWDrxwR9JtxGi7BXB7qEOi8LqQWJ+KbN8vKmCNNCTqpZbDdleoJJkXoPSTACPCA/vJepfZn1rnyMjtq8hpTvF6W7UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYou3N35PhCOYtx4Ld/uaGKFWQt98y/q2GbA/qZ/5Is=;
 b=aQiWPhqB7AZXPnFz5t5hUBIL6z8QEAbER2ovwVWMPDt4GNukONNpBNtZoc4GxWC2s9aL6P9AK2TsRCsrhPZT+QYCtZWQe6AvZXIQyEqaHkwHqrxZB0shT8IEizi9Hn/VggemNitoKE87eACitXbpuuCuvZjex5dCmRLAjZmY0Xc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH7PR01MB7931.prod.exchangelabs.com (2603:10b6:510:275::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.26; Tue, 4 Mar 2025 22:20:44 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 22:20:44 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: ryan.roberts@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	Miko.Lenczewski@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [v3 PATCH 0/6] arm64: support FEAT_BBM level 2 and large block mapping when rodata=full
Date: Tue,  4 Mar 2025 14:19:25 -0800
Message-ID: <20250304222018.615808-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::8) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH7PR01MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d43395-a70e-4b3f-d089-08dd5b6ace58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emNmYUkwNER3L0FDdm1wazdsa3lZTXQ5WG9EY3pKdnI3VWpqd0V2L3NqY2Nn?=
 =?utf-8?B?eU5vNUcxUHppaVpNV0cvN3lWZFJsSWFoK1o1WTJqUmR4a2toeTA3WVBkVEpo?=
 =?utf-8?B?dS8yN24yUFhPK0Nmb05Wc01vNUlQUEdaK1JhMHNwNEY1RUJSMzZSWHhQWWFm?=
 =?utf-8?B?RUdBTDcrYTBxSW1OMFQxSnlETGpCYTZDSVczM0NnanBPMDRHSGh1dEwxOWFH?=
 =?utf-8?B?L2RIb0FUa3pxcGxhK0ErM3V0Rjh3dzlnaFl4cEpzQy9VZHBJWFdzWXdBWUVn?=
 =?utf-8?B?VmNIY3hZOUZJZjAxNjRMbGQwME56bkRPdGJiTGRVWUZuMFdUaHZHOUQ0dHVZ?=
 =?utf-8?B?YTlPdDJmTWJDdHJqN2kzK2Y2MVJtejFlbFJBMS8wMXg5NEIrYjBhdzR1b2I3?=
 =?utf-8?B?Mk9iaGFkcEcwdSt2TU51OGFrQXYzaW9vUjlMb3BTR0J0VU4rTzAwOFZ4M0p6?=
 =?utf-8?B?M3p0SHBGd3dodzhHT3dkaFVJcTNTT1JuUFBheWNhc1FubUJCOFREbTUydVlI?=
 =?utf-8?B?UlplQlA0MFVhZUtud0Vud05mRDRPbW1EVXIwOTRQcS8yVmZZVGJiNDltV2Ra?=
 =?utf-8?B?MlNzN1hVelIwZlRqYnZwK1ZhUDhveFV2dFZORUZMTEdWd2pCck5HbWlFR1po?=
 =?utf-8?B?djNKTVpwMVlIQmRPYXVHbEFtbTVCUTRVS1FOKzdmaTE0RHJ2Q215ZXVseUZ1?=
 =?utf-8?B?dTUySUdyRDhnVk9jeGVacTFPOGhycGVBaE1rYWp0ZzNJRDdqeVV5WDRJZjd2?=
 =?utf-8?B?cTRydEVxN0tyZHNkb3Mxd243ampPUVJHb2lTaE9tdXQwdE5wU1Vpc3BpL1Rw?=
 =?utf-8?B?RXVFSURUNmUyNFQ4aTZZKzBkZFlteHVQTXpycktqQXNYYXJmaVZKSy9HNkNx?=
 =?utf-8?B?eUo3M3dZMjJvMC9oQnlmbzJmdE13MjNFV1hGbS9kRXF3QVkxclZFTkVvd0tr?=
 =?utf-8?B?TXo0TUo4cGdGN1dUUDVWamtyZy9xa1U1SUR6WlhxOUJQUFlZYm1aaU9yV3dS?=
 =?utf-8?B?NFNNVDR0Zk85dWZWb0FYd3NFcUZ1RDF5THFKSHlZdHhVemN4NzkySjU4eDFC?=
 =?utf-8?B?TGpzeEloOWhvS0R6RW8yUVI1SUxQUWVwR0FtRGIzOXpyMXdpQzUxWG9iRGZ4?=
 =?utf-8?B?YnpKT3dXZmJBdE8yRGc5REtqU2R5S3RzWFRGM1ZKZWFtaWM0RkMrek5ZYTk5?=
 =?utf-8?B?NUgwTVpRTWhFbDU5N245NnFBekY1d3BWZmxvSStpa0R0ZWJObm1IY3VGYW9x?=
 =?utf-8?B?SUhiVE9IWW9BeXA2elovRlNyTHRhM3dHYVhNREpsVnd6Skg4YUZXVnZmck9F?=
 =?utf-8?B?ZUhtdGVmdllBVGZ0NmRlT0h0QTRYc3NRMERqRmRIZEdmdnp3M2xZTVNBQXBp?=
 =?utf-8?B?SThkSnBrNTE3SitpM2RFdW5GUm5UaVAyanFhaUZYekNIRDhqYllqMGoyTlpn?=
 =?utf-8?B?dHhaaDZxMlUwemkybVE1V2F5RXdZZnQ3R1NIRDhadUZDWTJTM0ZEVkorRGtC?=
 =?utf-8?B?NDIvTHZmV0ZpVU81TVplYk9yeTNOMjZGYXBSTHZFY1p5anRoWENmenMrQmdF?=
 =?utf-8?B?VTN6dTBaeG94b0xRa3ZkeFJvTUgzK2wxSWtjUmpwZk11aG1BZHZUTnpFN3Ir?=
 =?utf-8?B?MW5jZTQ0eWpYOUpIbFFxN0k1NTgwK21IbVJicEFzREkyWHZjTG9UNHlFTmYw?=
 =?utf-8?B?ZEtqNnVMbXZ0Y2RRRTVVWG8yMUZFUVJNQ3hDMUJxdlBwMGxVWTlWT3NGYWlJ?=
 =?utf-8?B?d2RzdlNDaDF3MEVMbDhVdnBId1dleWVSeXFGcU0xNmtkOU5ieC9KMkdpeXE2?=
 =?utf-8?B?OUI3anEvNFJkaGhJQlV2UmVqWGxwSXY2TUh3NDV6eEZWYjhiSWJrd0wvWEFk?=
 =?utf-8?B?ZXh5bjM1Tlg1Nm91SHhNbW4wWFpxaUMyR2F3cEVvTFdySmJwMVJEcHVYY2NF?=
 =?utf-8?Q?tONoScrIdM+qhFLdS6/xQf4djidrUtb+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cER5OUx0bXd3TWpaZWUzMy9yak91NC94YVlOc0xtYzhTRmxIQ3RqbHF0dWRW?=
 =?utf-8?B?ZUhOcklmTTRwbnBPbW52RXlZNjkvNTlOaVFNQkZVQzZSQnRBdGZVbHA0K2wv?=
 =?utf-8?B?YjN3V0tnY0lxVVhHRi9TMERORVlNblBhNEdOdUNXbnROdzk5dkdtek9uQkhj?=
 =?utf-8?B?L2Zna1VubjBYNUxaODJucUhTWllZaFB4aEdRSzMrVHh2YnYybkxPM0YrWWs0?=
 =?utf-8?B?TXlKc25KMjYvdlRVV3RDZnVEZGt0R29kMitSWFNpSlBKR21wNEx4OGliOEF4?=
 =?utf-8?B?WC9kM0Z6d0JodmpxOEU4OG12SmFLSFZpa0xjYkc4anZybFJxSUtsdU1lcy85?=
 =?utf-8?B?bmY4QnZXa1VsRDI5TEhGTGVodUtkYnFmY0dwVnMzODNlbFV0SGh4OHZnVGd5?=
 =?utf-8?B?Z3M5VFBhaTRoOHhXQkNQNmt4ZS9iRlpiT2hqeE13amo1UUNYUFFxcU9xR1RI?=
 =?utf-8?B?U1plYVVGMDR1eEk4aitnYWV5UEMxTExNcjA2dmlIQkY2RUlwTGI5ZmprQ2FU?=
 =?utf-8?B?TWRjMUFFSFZhL1VQTm5TVlY3TUY4UmxpM3R2QnlwRG5JVVB5dHhET1B3VUZI?=
 =?utf-8?B?anlBRmFJend3dkhrNS9XUGNUdkRjSjFFS1BrODB0WThuam5lMGpPdnp2Y1lJ?=
 =?utf-8?B?WkxQcUpVaUd4cHNvYXRrdVNHVWJBMm9oRmh0VERKY3Rpbys1L1RFOHAzZi9o?=
 =?utf-8?B?YW5TOE81Y1dkSWxWY05pZzk0U01vbmNQMWs4L0FyYUVFL1loemVYS2lSTDlk?=
 =?utf-8?B?dFBOSDBUUXNTbnpxanU4NmhJb09sN1pMZzJXVzdzWlVnUXhMc1dDRVoyQlZK?=
 =?utf-8?B?czJXcmlFOGtmWUJUTHhrYlovOGpONndkRUZEc2d2RWY1Q0wwQlZCKytwSXJU?=
 =?utf-8?B?dDJiOW1TUnIvdUtQbUVQaWxWM09vQ2RlMmp6WTI4ZnNxTEhIdmNZQTE4VGRo?=
 =?utf-8?B?U01ieUlINC82UjZaV3A5alAzaFp1OWc5S29JaUo2Syt1WXQvYWM1U2h2ZWVk?=
 =?utf-8?B?YXVPbis0cXZpZzFNM0xObDBSRm9xZ3U0cUJsYUpHWEsvazdnVThiL0JFOUxv?=
 =?utf-8?B?Ty9ybXVEZE8xK1VhamkrNUpqWEFDci9sQjhKWVVqcCs4cm1HMk56dUJ4bitq?=
 =?utf-8?B?LzUya04xb2hZLzFQcmVsSU15a3J4ckdFaU4zajhmL1ByTW5XZVZMZUY0Vngz?=
 =?utf-8?B?V0JEKzFhQ3p6NWowSVo2clIyV29EQzJhQmNDVlJobkZ6VkZCUTV2R3Z3MEts?=
 =?utf-8?B?R0plaTlBSEY0a0tlN0VwcEswY3phVndESmFpdUNWY0IxSDdjajdrQ3d5clpk?=
 =?utf-8?B?UGhqOGdLT21Kdmt1SVJFdnQ1Q0dWeDE5UGYwcmVnUzF2VmlFbkxDdWRFM1VT?=
 =?utf-8?B?TGFqbGxmVEZJaFpxZStydFRXWlhGeTZtU202ZlYyR29DQWFxVDc2SW9wenNm?=
 =?utf-8?B?emJwTFZkRXhYWDdoQWZjT1E3dnFpVGVJbGE4SWxNVk5TOCtRMkNKMEplTlRm?=
 =?utf-8?B?UWljdVR2dnBDZmpLaVF3L1E4Z2J4SjJ1ZWU0VmVuUWR5cGh3dkVSYkhsZmVU?=
 =?utf-8?B?azZYdFhCMTlKYWVKa05wOXRGN2ozQlhvQlRHVHJUaC9kK2d4SnltcThWU0wy?=
 =?utf-8?B?b3ZpMlpDTFU5ako0b2NrR2orc3FPYW14ZzRPVXk1RU5UWEZNbmtSaFVoZE9E?=
 =?utf-8?B?bjBHSDdpY1FYdXR2QmR6U2xab0kycFF2WGJ1Z2NhdFZXZ0Nsd3ljcG1IWEN5?=
 =?utf-8?B?V29SVFg5KzFkc1J1emZMNGxnYnF2M09XdFBHcDR2Wmd1Nm9ncFVaUzRhS3h3?=
 =?utf-8?B?WCtmVWRHK1RYK2RlbytFQS9BS2lIMHhUV0x5Tlhja3RyUGZ1cS96VU1IMU9v?=
 =?utf-8?B?Ynh1Vk9GTGtxemhHaGs4TkJyV29vWHZKNm1nY05lWE5NbllGZHZ1bFh6S1ZP?=
 =?utf-8?B?UDlDbXlzcE1zUER1M2VWNTdWNnZYcTBFamRPMFZ5d3hhVlhTN3pzNE8xeTVk?=
 =?utf-8?B?ZXp5TmhxSitPV0tMbVRBcDlzVktobTlsUCtxd1FEdXVOTnhlU29pM0VtZDB2?=
 =?utf-8?B?SjhTWW9YMU5Da2t6MDZvZ3dkeVV2Z3NZL3JRNlBlUEE5aVRzQ0JHbEl1Ylhv?=
 =?utf-8?B?cDRleVBHTmxqRFF4TWZSd2x6R045L3NGdFdGeDY2L2ZLUDJ6ZWkwdkp5YnJJ?=
 =?utf-8?Q?KnPPGrHadVOUdNxV0lpBXgo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d43395-a70e-4b3f-d089-08dd5b6ace58
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 22:20:44.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMbtdK7EqzfsqT1AfHgaHoFvjjRRyhauTqVglsOAY6A7FhrHxptbTFM9gsnigyX0XSeMRSb22ipxv+pa8it7PsbOlCgEEdNr531b/FR/aRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7931


Changelog
=========
v3:
  * Rebased to v6.14-rc4.
  * Based on Miko's BBML2 cpufeature patch (https://lore.kernel.org/linux-arm-kernel/20250228182403.6269-3-miko.lenczewski@arm.com/).
    Also included in this series in order to have the complete patchset.
  * Enhanced __create_pgd_mapping() to handle split as well per Ryan.
  * Supported CONT mappings per Ryan.
  * Supported asymmetric system by splitting kernel linear mapping if such
    system is detected per Ryan. I don't have such system to test, so the
    testing is done by hacking kernel to call linear mapping repainting
    unconditionally. The linear mapping doesn't have any block and cont
    mappings after booting.

RFC v2:
  * Used allowlist to advertise BBM lv2 on the CPUs which can handle TLB
    conflict gracefully per Will Deacon
  * Rebased onto v6.13-rc5
  * https://lore.kernel.org/linux-arm-kernel/20250103011822.1257189-1-yang@os.amperecomputing.com/

RFC v1: https://lore.kernel.org/lkml/20241118181711.962576-1-yang@os.amperecomputing.com/

Description
===========
When rodata=full kernel linear mapping is mapped by PTE due to arm's
break-before-make rule.

A number of performance issues arise when the kernel linear map is using
PTE entries due to arm's break-before-make rule:
  - performance degradation
  - more TLB pressure
  - memory waste for kernel page table

These issues can be avoided by specifying rodata=on the kernel command
line but this disables the alias checks on page table permissions and
therefore compromises security somewhat.

With FEAT_BBM level 2 support it is no longer necessary to invalidate the
page table entry when changing page sizes.  This allows the kernel to
split large mappings after boot is complete.

This patch adds support for splitting large mappings when FEAT_BBM level 2
is available and rodata=full is used. This functionality will be used
when modifying page permissions for individual page frames.

Without FEAT_BBM level 2 we will keep the kernel linear map using PTEs
only.

If the system is asymmetric, the kernel linear mapping may be repainted once
the BBML2 capability is finalized on all CPUs.  See patch #6 for more details.

We saw significant performance increases in some benchmarks with
rodata=full without compromising the security features of the kernel.

Testing
=======
The test was done on AmpereOne machine (192 cores, 1P) with 256GB memory and
4K page size + 48 bit VA.

Function test (4K/16K/64K page size)
  - Kernel boot.  Kernel needs change kernel linear mapping permission at
    boot stage, if the patch didn't work, kernel typically didn't boot.
  - Module stress from stress-ng. Kernel module load change permission for
    linear mapping.
  - A test kernel module which allocates 80% of total memory via vmalloc(),
    then change the vmalloc area permission to RO, this also change linear
    mapping permission to RO, then change it back before vfree(). Then launch
    a VM which consumes almost all physical memory.
  - VM with the patchset applied in guest kernel too.
  - Kernel build in VM with guest kernel which has this series applied.
  - rodata=on. Make sure other rodata mode is not broken.
  - Boot on the machine which doesn't support BBML2.

Performance
===========
Memory consumption
Before:
MemTotal:       258988984 kB
MemFree:        254821700 kB

After:
MemTotal:       259505132 kB
MemFree:        255410264 kB

Around 500MB more memory are free to use.  The larger the machine, the
more memory saved.

Performance benchmarking
* Memcached
We saw performance degradation when running Memcached benchmark with
rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
With this patchset we saw ops/sec is increased by around 3.5%, P99
latency is reduced by around 9.6%.
The gain mainly came from reduced kernel TLB misses.  The kernel TLB
MPKI is reduced by 28.5%.

The benchmark data is now on par with rodata=on too.

* Disk encryption (dm-crypt) benchmark
Ran fio benchmark with the below command on a 128G ramdisk (ext4) with disk
encryption (by dm-crypt).
fio --directory=/data --random_generator=lfsr --norandommap --randrepeat 1 \
    --status-interval=999 --rw=write --bs=4k --loops=1 --ioengine=sync \
    --iodepth=1 --numjobs=1 --fsync_on_close=1 --group_reporting --thread \
    --name=iops-test-job --eta-newline=1 --size 100G

The IOPS is increased by 90% - 150% (the variance is high, but the worst
number of good case is around 90% more than the best number of bad case).
The bandwidth is increased and the avg clat is reduced proportionally.

* Sequential file read
Read 100G file sequentially on XFS (xfs_io read with page cache populated).
The bandwidth is increased by 150%.


Mikołaj Lenczewski (1):
      arm64: Add BBM Level 2 cpu feature

Yang Shi (5):
      arm64: cpufeature: add AmpereOne to BBML2 allow list
      arm64: mm: make __create_pgd_mapping() and helpers non-void
      arm64: mm: support large block mapping when rodata=full
      arm64: mm: support split CONT mappings
      arm64: mm: split linear mapping if BBML2 is not supported on secondary CPUs

 arch/arm64/Kconfig                  |  11 +++++
 arch/arm64/include/asm/cpucaps.h    |   2 +
 arch/arm64/include/asm/cpufeature.h |  15 ++++++
 arch/arm64/include/asm/mmu.h        |   4 ++
 arch/arm64/include/asm/pgtable.h    |  12 ++++-
 arch/arm64/kernel/cpufeature.c      |  95 +++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/mmu.c                 | 397 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------
 arch/arm64/mm/pageattr.c            |  37 ++++++++++++---
 arch/arm64/tools/cpucaps            |   1 +
 9 files changed, 518 insertions(+), 56 deletions(-)


