Return-Path: <linux-kernel+bounces-355316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B1899508D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC101F2359B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0177F1DED7A;
	Tue,  8 Oct 2024 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tPrE2wuq"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F69613959D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395197; cv=fail; b=nXOuV/2x6+hhyFvbC/CICMdako5CA1GrbuLKZvTwpbEBSWREAu31z9liyTdOj0dcxP9kaJSlcNGrYoMWC9remrMW2aU51sClD/RlwMXirRTOUnMD79IbY9uuMlWbmh2S1Pe0Un6XMfUrnufabTSyvG9n1pCp3YjVHZXlHVCoAK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395197; c=relaxed/simple;
	bh=5PODx+1Na2bsrpuVYDMWrRLbbfVNraksg5HlLe0DkIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TrJ/A7EueT/LSGEwrIJ/B2A23Drj9j4Jg4QZZSawOHrtys2s+AicZ66vopr96TwUmFE56+3gS7A9K0el95SPmEwoxVZ++xMCFU65/xkCikihlEjaYjLQ87+7rshM0SeN+p3Tv/r7CnmDgPlw5/cL6669+sx68meip6uwYdGHIV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tPrE2wuq; arc=fail smtp.client-ip=40.107.212.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtjGqsZ7ZkGsCVbd9Df2tkl6cWwEKOtTVj4hN0zTEP2jiMYiQgir/BBc+y8PA+n2yNi32sNHBipNMC8SC1H5/PQGITm+K/46DDVZsWcGENpJbMXpRgTjDGLbkd3SRO1xS3XS+XQgDg3YKxo1V1KJphh6tlJcFTNOptZO974+lLQdTGyS7nIwIQMp2v1k3EvNQBNtKcC9IhfxBwjG40Mwc179YKRYgniBDbtxYGFrOHqd+qcXm07V/wlBlDDQaBBXPDP1L11XTQVFJwckmIJYggHI/swvXGZrcWSGQF/hCyn8tNt/c4Rl/ZVq7ME2uqDSzwJnXOaP7VvOBkM425Ecww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+KWyGQpopArhTV/6GSYDYMlP1qaCPF86SQo2JFEK9Y=;
 b=oBvJ9loIyuoEWVR0myB07otGkWVBpWIC6vH3LX4Ku7KCIWyb4QVWpt1A3bdFcCBPhn+3QN9zisLOqCsf0FjsrqiJG4VNaGq4NPIlUl4wisknacU1Fi6MkSMOPa3PrmLoy/1mVdQqBcW0iFZlKjxWWZFRa9VPHTKA9MyTEvTybUybf9iC+wFVzEs3TOnFdH8jiWmmV0lncVJUmXc0zGvRgnvpQeqEQWU87Muxlpas/mgZ3fB2sKd9PpOI7rsQ48ynGmGsIPg2V4gXCwNORPFwcNuacb29zedQS9q3OG3Gpg1dkz8jessH1pTiRC8YhNPm3PJ2SgBZwvVbngUWNrgHdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+KWyGQpopArhTV/6GSYDYMlP1qaCPF86SQo2JFEK9Y=;
 b=tPrE2wuqECNf2izR6A19fCm8OGI2Zzu6/zuKjE676nGlm7gtLT00lY5Fn4OtGxMNrO1kgvcvI+g0y0xBWU4Yb9ktEZDLrprvKE+94Fo+Ji/pnFD7yiLR+zWM0mSaN0mBQ4aXdb3P/PgMEgBzw2xHdZMJULWOdZ2D8Mya35xPszHZ+pLsTIZTwXsXoRrOYTKtwclhvv/aKb6DpxHTBso1pq8FoTkFbd7uFSNQQOTqIVMtjg1Bh4hk70f3tbzTb9Ja1hJCTfUbNMW6t/2FAZVxoBFNK8oZHzZxYqy9AfzTo1x2j0SmuurmDU6gLybrsEuc65NWXsltw98sbc/Mrs7Y3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) by
 IA0PR12MB9010.namprd12.prod.outlook.com (2603:10b6:208:48e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 13:46:31 +0000
Received: from DS7PR12MB8324.namprd12.prod.outlook.com
 ([fe80::c45e:51b0:e1ec:1a32]) by DS7PR12MB8324.namprd12.prod.outlook.com
 ([fe80::c45e:51b0:e1ec:1a32%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 13:46:31 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Alexander Potapenko <glider@google.com>,
 Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [RFC PATCH] mm: avoid clearing user movable page twice with
 init_on_alloc=1
Date: Tue, 08 Oct 2024 09:46:28 -0400
X-Mailer: MailMate (1.14r6065)
Message-ID: <7C05C178-AE68-4899-BC4B-CE83C17A5BF0@nvidia.com>
In-Reply-To: <b8272cb4-aee8-45ad-8dff-353444b3fa74@redhat.com>
References: <20241007182315.401167-1-ziy@nvidia.com>
 <9e4e3094-00a2-43bc-996f-af15c3168e3a@redhat.com>
 <84D24C40-AC10-4FF7-B5F6-63FADD523297@nvidia.com>
 <be1a1c1b-4630-41e2-a79a-57447851017d@suse.cz>
 <b8272cb4-aee8-45ad-8dff-353444b3fa74@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_5AA9C52F-3C17-4BAB-8ABC-EE01248E817D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BN8PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:408:d4::32) To DS7PR12MB8324.namprd12.prod.outlook.com
 (2603:10b6:8:ec::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8324:EE_|IA0PR12MB9010:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0951e3-6907-4f7e-371e-08dce79f9db9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTlLTUc1OFNiMlB1TmNuYU5hMllLY0JhL2pQWXJkUDN4c1puODJJRHZzSDNQ?=
 =?utf-8?B?ZHQ0ZERiZlVrYnJMcGErK2NNd0gveXZrMHo2OW85RzcrV283MkFvalVJWkhv?=
 =?utf-8?B?SlJSbWoveVJ5dzZKQmkwRFhWZjhwMUxTWE1BUGhaVWswL3piRWs4bUp2WHk1?=
 =?utf-8?B?bEtpcnJhWUI2RnJMeHkwUzJEVWVEa09VTXdqYzQ2WHRDcnBBcjdablcvR0lH?=
 =?utf-8?B?Y1dTbE1zMlJ5cTMyS04vZEdzbHBqQm1pQkU2aWJhYkJXODJVTjROZ2ZFRnVh?=
 =?utf-8?B?MDRWenJnV3V3R0N3OW95QmpTVkM2cjhqREhzTE5aZzFqcHNscE15LzVwWHlq?=
 =?utf-8?B?RmlTT29BdWFoWStUamNXaVZUQUlVTnNIRGJQNUFGTFZBL0xHZ1pNNXI1M2Rq?=
 =?utf-8?B?cTBYM1U1d2ZQS001a1dtZDRya3R4TG5UekdCYmVmK0diemFYaDdrRVhoYS8w?=
 =?utf-8?B?MmxvRk1mV0o1NEgxeWtiRGxrUlZiTGc2VzF0dW5jNzJLWFZ6RXdWT2h4b05P?=
 =?utf-8?B?VzZsMFR2K0hLUE03dllnY1pnblUvL1dvL0VrSEhuaFVOaHYyL25pRnFyWStx?=
 =?utf-8?B?bDdrSTh3enRKdTRFMkdTWEtxQTE5NmJwR09DdEtic040eVZhMWd2V0J5T1V1?=
 =?utf-8?B?M0t6RUtaT21zdzRsTVgwYk05ZzNWK25OYUtDeWJqK2FBSU5MRWxIMkNESzc1?=
 =?utf-8?B?Y1d4eXczNFJodEJoVktnYVBEZDA2aWNudGtYK3VQRGM3YWVrL01PK2doUUVx?=
 =?utf-8?B?NFkrdGF1MXRnaXBicU94SlJwVXVndnY3YnA5YkdRckFTMmZjSkpHUXBuaDIw?=
 =?utf-8?B?ZVZQRkV4Q2hDRUlmVUVBK2dMYjA5WDdzdHh6K2lwckxzd3dUWnp4OUxsazEr?=
 =?utf-8?B?ZXZXK3pwVUxnUjdSUzBwdzVWckhXaFdtYzdjUEpzbmlNYW0zaTZta3hNN1Y0?=
 =?utf-8?B?Ym4zcWhRMEFndGhKNXlsejZRUWkwYmdOOVNCWHJEN3E0bDFmY1ZFY1BFQTFs?=
 =?utf-8?B?Q1YwZFlod0JUR2w2RUp4ZmdQY1RXUUdUdlAzdFlybzNxUWZHQy9Bd2x6WExE?=
 =?utf-8?B?aCtHK0Vrais5QzViWXd0VUROSHQya3ZwMFFwYjBBUEVGQnJmb0hjcGVzNTVX?=
 =?utf-8?B?Skt2SDJlT2FJY0NzRWFnc0hiZzdUT0l6WG8rOGZpK3UxUWZjNUxkWFNyWjJ6?=
 =?utf-8?B?V0FGUmRYeTF4bElURHZNTjVBTk95Sm9UaUVqY2VGbTRXN1hhT2FaMlUyRkhW?=
 =?utf-8?B?S1NacGVGS1JuM05DMmNuU3RtM1ZaTUtzS3RaTi8vVHJMdXlPcU5wVUpXUE40?=
 =?utf-8?B?Qnp5czVBTXpDdlVOaG1EdjhDYmZvdGlxVEluWXB0RU5YM0p4RnlZZFZPSDhR?=
 =?utf-8?B?dE8xQTJySHkydFJtaGxSUnNUeUxpR0JUSDhoOVRlUXMweXE4NVhVVENVZzNF?=
 =?utf-8?B?M1VHc3BTQ2R1MC9mWGo5MVBQQjhxeVZPQUdLY2JNSDVxMFlPWWpaY0dja2pR?=
 =?utf-8?B?dWJYK3I1VDQyRUR2UTd3UGZ0S1hULzRRSGdSVGlzOXZyRGltMmlVVHlmUHFF?=
 =?utf-8?B?bUxUM3FtMnFEK21CSFFlMXE0MElJTEt0ZDNOWEYvTjVsSml1eXZkQTZKQnpr?=
 =?utf-8?B?c2UvQys3N2draUlUeVFnQXVwd2REKyt1Z29TMkM2bW9rYTFWMjE5WlJyZ0ow?=
 =?utf-8?B?NjRqenR5QytNWENhWTJicFRFMWowdGFzY1BWelVYMktSMXcrajJVMVR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8324.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1RaWWk3eEFPN0xkUzFCbkF2YTltbU1xYjlpckgvd2IxZXQreU8waXUySUp6?=
 =?utf-8?B?Nk5WeVZsQVhwM05PRTNzS2VBS1BMSE14T0VvRm45a3EzWW1LSXpqaEtGRmp5?=
 =?utf-8?B?TlBkejVhZkttUXFxb2F0UVBQRHBiZWlsUklYWFcvbHhGbDVtbENSUENGenEv?=
 =?utf-8?B?MzVYSmRuVjdHMG9GS0RwdlZYWUFQTUwxU0Q1cG1TYjlFQzQ1cnNLMGFHbGh6?=
 =?utf-8?B?cXlNN3d5dlQzZmVJSzBPQXdVNStIUENwTnoxUTA5V1A4Ni9OY0lYVUkyMEg4?=
 =?utf-8?B?cTVxRURtVjJPcStqdGEwbnJHaDR0ZGJFUWRjN3FqVnppSUZBaG92VUs1ejlC?=
 =?utf-8?B?bDlmRHpaamc3VXZJQ2NORW1vTHY3cmg3QldXdEJ5bGpEbjg0V2NqT21Ycmlp?=
 =?utf-8?B?bnM3TFRHRmJkWE41YnNVWXRUYVFTYXM3MUxzajlkbWpvR3NmWG41Ui9PV3FJ?=
 =?utf-8?B?MUNjcGRYczZTQUdEcHlSeHgvOVFSdlloNmlzengxK2x2STI0cDZobDZJWGZp?=
 =?utf-8?B?TG9TcFA1Y2g5d0d3dlc5RGpDRms0U0lOd1M1Sm9IcTJjQzk1bzdydlc0bmJw?=
 =?utf-8?B?dDRXYnJkZnhMeVc5eitHa2VLczczSXMzTTFPajViZmtBV3JUdEtCSEpLRGdK?=
 =?utf-8?B?YkdEbTFqcTliVmJ1RkNpZkhBMVVWNVVON251R2licExtdHBGVUF2N09MNTg2?=
 =?utf-8?B?dGh1Y2xGRVR5WmN2eGZ0NVIybHNtOHp5VDlHOGZTTlAyOFdPejRhUlp5TlhD?=
 =?utf-8?B?NjZiM1J2WU5xMDNVYzl6SFh2YXBTRTFLa0ZrcnVDYUpjeGhoV3ZhWU02QW11?=
 =?utf-8?B?ZEJuakhrdURDcnJ0d1VHQXNQMWd3RUcxL1lOU2VlamJzZ3o5ZW43MU5BNnNi?=
 =?utf-8?B?R2xQcC9acStCUXF4RXlzeWtpT1hlaXFOSmtEMzBFSVpKeEdKeXF2SWpPUUpx?=
 =?utf-8?B?SGhmazY2SjJ4bHcvVU92WFFablZpQXpXQjdsTTNpRG80dkI3ZFZjTWxqQWJo?=
 =?utf-8?B?YTRaMnpBWERoY004V0s1R0hHOE90a2xqU2pvMlZ6YnZtSnZxZ3NHSU5IUzE0?=
 =?utf-8?B?emIwdVNqNmdicmhXOWlZLzQvbTdyb3RaNFhxMGJzVzVXTVRtYXdzb2lNeG5n?=
 =?utf-8?B?bTVPWnBqeUl5QWYyQ0FLWmtEekZTQXlPcHhwS1poMnRiYmR2OW9NaHJCVnBU?=
 =?utf-8?B?NFhrR2R3ZXgzK1JUUVFFVW53alMwVHQ0WXV3dnhhYXoxZ2FDdFA5TGlvY0pR?=
 =?utf-8?B?V3c5Y0RJaFgwL1Ryd3hJazdoR3dBMFBWVDR1bnZMWUhGUlBITDN6WlNzcGFu?=
 =?utf-8?B?aThhZFdmai96ZDV4RVVSRVRzV1MzdXZFNUpuYjdjYVNuemFmZUFvZkdZRjVY?=
 =?utf-8?B?cElUZVhwVkp4b2ZnWTNQdTR2OEVtQjRXSkg0VWpGL3NYQkZ3Zmw0a1N4N2F4?=
 =?utf-8?B?VlZ2aVIyQWxNbEVPVzVXQ2dibzEvQnpycitVS0xpYjMzVm0zOWdZcUJkcVRx?=
 =?utf-8?B?eFhpYU5jaXlQRlllQ2tKK1l3Qkp6TXYzUk80WmZJcFZKcmIycllBbGZqTFZa?=
 =?utf-8?B?blBzajZtaFhvNEZoSmFhUE9wUEh0L2hRWDNLOWkxSzR1c0pOZ3JxSkJZU3F3?=
 =?utf-8?B?RnBabFNubGt4c2lCVEc4YUtPbW54cm10U1k3TzN0aURzSlJFWWpjQkNZVFJR?=
 =?utf-8?B?YlE1Qm4waDB2VUlWWkdlZURyUXZaQVA2bTE4TkN6dmRhRWdWa3ZwSGpVK2VK?=
 =?utf-8?B?OGhINHlQc2hmOURNTzRSbUQyUUN3L2hhVjBSWEcvaDFWay9UbmpicEliQXFx?=
 =?utf-8?B?QkVLQXVDSi9qZVV1dVg4RXJPemNPWkE5NkFST21vT2xWUGtrWnllS2lvUHVZ?=
 =?utf-8?B?emFDbmpWYjZudWpRallqUzdNMnIvZUlDayt0NDJvUDJJU2N6OTJ4SFVITDg0?=
 =?utf-8?B?eUJ6Y1FIZUovNWtKMmE3VDc5Z3B5Q3VUWGRVNzZ2YnlzMVV1dUNqV1ZyTG1I?=
 =?utf-8?B?QVNMTm9tS2FVdnVIZU1HVGFwT2QrcGJIRVQydnphZWNVaEFmbTlmVjFZQ0pE?=
 =?utf-8?B?UENmM0dRYzB6MlIrY0FscGdTd3EwNmJpK0QwM1dOTm9NdjVpcW9XV2N2cytO?=
 =?utf-8?Q?Z9C+YHviint2ugMIcNknKPPxV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0951e3-6907-4f7e-371e-08dce79f9db9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 13:46:31.3476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1RbQDEhO6BCpN6VYSqf3AmfRCg2kM6cPngzAM3xbGUOvRzuY+v7ngJhFi87nWqE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9010

--=_MailMate_5AA9C52F-3C17-4BAB-8ABC-EE01248E817D_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 8 Oct 2024, at 9:06, David Hildenbrand wrote:

> On 08.10.24 14:57, Vlastimil Babka wrote:
>> On 10/8/24 13:52, Zi Yan wrote:
>>> On 8 Oct 2024, at 4:26, David Hildenbrand wrote:
>>>
>>>>
>>>> I remember we discussed that in the past and that we do *not* want t=
o sprinkle these CONFIG_INIT_ON_ALLOC_DEFAULT_ON checks all over the kern=
el.
>>>>
>>>> Ideally, we'd use GFP_ZERO and have the buddy just do that for us? T=
here is the slight chance that we zero-out when we're not going to use th=
e allocated folio, but ... that can happen either way even with the curre=
nt code?
>>>
>>> I agree that putting CONFIG_INIT_ON_ALLOC_DEFAULT_ON here is not idea=
l, but
>>
>> Create some nice inline wrapper for the test and it will look less ugl=
y? :)

something like?

static inline bool alloc_zeroed()
{
	return static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
			&init_on_alloc);
}


I missed another folio_zero_user() caller in alloc_anon_folio() for mTHP.=

So both PMD THP and mTHP are zeroed twice for all arch.

Adding Ryan for mTHP.

>>
>>> folio_zero_user() uses vmf->address to improve cache performance by c=
hanging
>>> subpage clearing order. See commit c79b57e462b5 ("mm: hugetlb: clear =
target
>>> sub-page last when clearing huge page=E2=80=9D). If we use GFP_ZERO, =
we lose this
>>> optimization. To keep it, vmf->address will need to be passed to allo=
cation
>>> code. Maybe that is acceptable?
>>
>> I'd rather not change the page allocation code for this...
>
> Although I'm curious if that optimization from 2017 is still valuable :=
)

Maybe Ying can give some insight on this.


Do we need some general guidance on who is responsible for zeroing alloca=
ted
folios? Should people use GFP_ZERO instead of zeroing by themselves if po=
ssible?


Best Regards,
Yan, Zi

--=_MailMate_5AA9C52F-3C17-4BAB-8ABC-EE01248E817D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmcFN7QPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKrxQP/3P24uVMN6E67bbuZCRTeBXHbLDcJDCqhYGb
6loGgfyfPkolxsES9BhBR9rvexe/bdXShconru/gKx6TszjNZJ328sMeTLBi+DY2
UMjbZamSPfOBqMNDCEhq46GaCDmD8fz+9aL3PqifPMv+rnrhs0YRnfQ4EnGxGGds
z6M5GFQORaX/tjtpHY4kTG/VO6Er7+WQwyZ8WcxPIT/uVWST+Werx7UbgbRPRFlo
YnTa2Hf6Kcz2E50L6VoNiz7XHUGcurS4lRU1pwds12joaaQvwmaK6JK3dzXZy6Ls
CYcMMfGHTWEsL5Sjb8zlffrNCdb/4CI1bHrjPGW6MpxMynh/u1uQRtRoTfymLqod
/6x7ocX1W/ldyie2cVQyWUd9fVKj9cOoDKk8m8r66igCBW0Urxqs2fAm7a6RuKIc
o3cjl6t5Jb6SYFn7/iW2I7vevY5tVrKs5yKLJ0EZ5iRowcQNOlH9o+GbTy8ynoaj
Lu7uW7wr5JAhdO0yB4mImbbBIVxcE8bIvJkVpdzb+NLYvEuTCRA5N99uoqdSI6IR
cuFjQfYqHYqSAaNuOa7ALQhbzKT8f5LPmA6r50U1KzmkePYqpgMIbJDZuujwckXd
QExvWb4te/ROsvlWfRaUaKwqiw2NxI83UQhU8WxYDn+Fzdzbcdu6cgd/ry/jHDzL
gY6Krycw
=sQIt
-----END PGP SIGNATURE-----

--=_MailMate_5AA9C52F-3C17-4BAB-8ABC-EE01248E817D_=--

