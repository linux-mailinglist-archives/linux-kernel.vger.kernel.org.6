Return-Path: <linux-kernel+bounces-312323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 793449694F7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CC71F25BC4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057D11D678C;
	Tue,  3 Sep 2024 07:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cCbry+63"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2046.outbound.protection.outlook.com [40.107.117.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A161D61A2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347664; cv=fail; b=VVFWFeaBn4PMaKoluORic9SWevZRysVAciCVA6DD3FXcW5Fhdu+MHR5LrMvx9h0LDa13GLW8te5Zp+Mg5yr55Duy9bHV4V58VCmnlmUI8HViBaXxPFrEmx9eEZc0LaYevy4xYzyOU/SgEgMBASXs4/p3CoYBhdP0spAUX0yqMkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347664; c=relaxed/simple;
	bh=xO0upMYjYAtMLTiaH6g7+PTrpWT+mgL+IfEJqz4DV8U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J3+zwGaT5WvmN/VL0+lucCw/dtFETm+EVWd8C1NqEWA8nriL3wjej+SmMF8cIItcPV4UYwHPMP2aFQokviOFunoXJlMEboK9cUjnhzF+8Jmd28oMi2BFJQCahARsjVfHuRybaglJOf6TqOH59pMJ00e7Gm+tPHoFRWNvfZlVY/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cCbry+63; arc=fail smtp.client-ip=40.107.117.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7eUVO4ENL4QBKLm1WLIPwkA2Ss54zRv8IIX5yFIjcl/fzp0n0Awv6zYxP6eVlEW2IUg5JMJ+awWZclN43cPyBgHgE4l0iEUO6umK1//DtnUrGBg/rjLWy3AfN+2TzDo+AlqaZluBH/gdoMfbkTMmi+YeksYpoY9ZXYCSRvAV4JYw/3o6gSIvadg+riAFZvceRgPoeWg7qBbW2wfbKlQBWLWKb+7dagWyq9KJLt8oOHWW4nRj4Zi+81gSJ2lK3mI4hnv4LNXlYYUiqwvp/kS9pqsUSC6Ba/lsKSJOefApKhLqOLdhlfdrbMdZNjXUcVM6l0SkPAHEQf8dvx5RhZ5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdeMdR/Z/zWUBwjOXKbK52ZSw2MlZm51UmrVbGyr40w=;
 b=pmZ6LWKUMRrfaz+yiee4OH1dj+LPPcSy/nVCDUmcyzVKAQ0QABEH+LSqCD926HTesjjzJIUdXPzYEhK7+LazAZZOMkcNe8b4Q5i9QbaGPOQOGjZ7mX83O76zrKxFFpDgUz0JlFvEV9JVzve5zL2IQNyntNqrBaSZxCnpRdWhKJp8drrSvrKAaTXKHmD3F9+DtPQ6GXJpsiLPQn3RDTM8jNiC6ZJ8otvczhyP5uRGSywoyZtu2HkMWe0bYHGqZhV0FRNJFlsSfmxlyoRrZ1RDSPbdVpza/Er3fVc6xjauid1GvvSs0vLVjZMSaUfdOTwbJ9gLzzfgBPyVODuPzcjEwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdeMdR/Z/zWUBwjOXKbK52ZSw2MlZm51UmrVbGyr40w=;
 b=cCbry+63RLDGJ6g/H2njtBS+SZOBR7QHu79ERD7z7MsOVjZiLVQlEFDJG3H/LukyTga2fkPeoCZZ6LjJfB84LwECqNntgW8y+hkrw7wjIjYap3DRr6+25wSJD6rG9XD8mLPGi7ULlyMYMUcC5ANWQimGDM0TvvdMp2qxjkpvUBnq+3EiqoSQ+1fNOKnkELbTs88CvwpXyPKTe9RhNlRKidA8xbyq5wxpzhOhZ1wAe/inxMHI1T7FwJeiLkTW18zrYiL6GX3/1w/Sc2qrBbtlLaI7Sz4isaQMlke09bPH9kokl9LHlIaFA5i+Kyz14cqo2lofXFuIfZ3ITePWXEqdjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 JH0PR06MB6584.apcprd06.prod.outlook.com (2603:1096:990:34::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Tue, 3 Sep 2024 07:14:18 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 07:14:17 +0000
Message-ID: <c4ec57e5-49e1-413f-a1e2-e258c628c55f@vivo.com>
Date: Tue, 3 Sep 2024 15:14:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Skip the reserved bootmem for compaction
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: opensource.kernel@vivo.com, Rong Qianfeng <rongqianfeng@vivo.com>,
 vbabka@suse.cz, mgorman@techsingularity.net,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240902122445.11805-1-rongqianfeng@vivo.com>
 <3b8994a6-cbe5-46be-86eb-b78198c31ef8@redhat.com>
From: Rong Qianfeng <11065417@vivo.com>
In-Reply-To: <3b8994a6-cbe5-46be-86eb-b78198c31ef8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|JH0PR06MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: 2566c40f-8c31-4e61-ffa7-08dccbe8062a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUszeEhOOHk2TWFhaTk5K0FnQ0xOdUxQcE02eDFnN2JWUmpRUktwT2ZzeUFZ?=
 =?utf-8?B?c2NUQXY3aStOMjFOc2R6b0l6WTNpRzkrQ2ZDVEx1YW9ZdEdKb1YzanVPMCtY?=
 =?utf-8?B?ejdudlYrNEVYNlI3M3Rra3BxTDNsUVROTHluWEM3aWpzUWdldnNaWGdHUGk5?=
 =?utf-8?B?VEI0ZFlLOWx2RStGWmh0Zm1oMnAydUVueWhqQitZb3paeVpDdEZvMFZ6bjFQ?=
 =?utf-8?B?dFZZSUVRSVFCVWRCelNtNThCUmFmYlVCWlpBTC83WkhxZE1wdDRrVlM0RHBh?=
 =?utf-8?B?WVBKeVVJQjVsckVCRjY1RGtKTUJ4QXFpYWg1aEVDaHkrY0pwWGNISTBJVGl6?=
 =?utf-8?B?WFUyYWNzRWhlbC9QaDNGcDNlOVlUT3B2SEFGdFgxZEkxYm1jRjllK3djYWdS?=
 =?utf-8?B?amF6dmJBNFBGYkRLdkI5OExiQU9zbVZqT0RSWk56RW0wM2lnU3BKSzhiR1Ev?=
 =?utf-8?B?UUo3b3RkdU9LVkdhL1FYVE5iWlJ5SkRGeVNFZ3Q4K1RFYlovaE5OZ3pUNVRx?=
 =?utf-8?B?MlVaNnhOU1lRZSt3VDROajhucFhFUWozdlJRR0J3MGdBRDAxaDd5eFNsYVl3?=
 =?utf-8?B?bi8yakdQb21yZ01GeWk2NFh5L2I5V2xHWG43cDY5eTB6Z3JaTVlRNW5RdnBr?=
 =?utf-8?B?ZnV6Q3EzSkpNTDArWW15RlNvWlFtT094YitHWXNOeEEyRWV3YnBMc2hHc25x?=
 =?utf-8?B?NDBjMXBCQVkwbVVEMU9IOG4rd1VoQWFrcUlXN1hCT21Mb0V2a1UzYklTTFFm?=
 =?utf-8?B?a3lONW9xM3BQSGI1a0htakxIbTdWcTgxWXkycjhKSXp6Rk1BNloxU0dqOVNV?=
 =?utf-8?B?ek1TMWlCaUFHdGhNMmxTYUEraU5hTW8wT2F0NDRjL2hKM09BWEdGa0lFeGV6?=
 =?utf-8?B?WXVLWjh0cS94VWR1Q2xOZkpxRnowRVVQa1JjTXR3NmFiZXFpSGV6RGlFK0Vk?=
 =?utf-8?B?cUhsdUFxaW1mKzJ3cFRqN3QvaFpTOVcvRzdReWlJRk1Hb0RxK3J2Vkp4cy9a?=
 =?utf-8?B?YkVGZGxrbW1tNlZkRGJIQmZTdFBJRWVGM0R3QnVEaUFTNTZRdDJnRDczL29R?=
 =?utf-8?B?MFkxYWNmTGFPWVZIOFJHZ0haVnR2MktuQ3R0NDRrZGRVVDJBOTFXMDFRUzBE?=
 =?utf-8?B?RlJLZ2FETlcraU94dlR5V1YyUm1MbExxRTBKd0pBcWE2ZE1DQ2VsUGFlZ243?=
 =?utf-8?B?djZneGo4SHhoM1pkWC9oMWxGVVhBZEI1ZHdTM2phUWhwNHZCNVNkVmxHOHFJ?=
 =?utf-8?B?ZnJIdytwMStMMHJENUN0d091NmtEeDZMMzNBUW5wZkN2b3M0RTU2aXhRb2s3?=
 =?utf-8?B?cjB6MUJXd3FZQitRRjVvY3pFazVzUG9OY3JkT25xdFV0TVZwVFJFWC9PbWM5?=
 =?utf-8?B?QW1xMFpuYnkwZTBjY0l0U0c1SVRyTkwvcXkzNmtMM2RlYlBVdXJ2bnIzczV3?=
 =?utf-8?B?MWFHNVU0RVI4S3QybngwNTk1ODRlbFNFODdGblhXbUwrZjlLWENUdTV5QzB0?=
 =?utf-8?B?S0Rtd1pZaVlMYkMxS3U0WmljMXZvc1Fyd0c3S2pUbTY4NXRHMTVGdERCUUtk?=
 =?utf-8?B?MVVVaWkwUDBQVjV0N2R5bDd2dHBXZWhCajlFOWVTMnMzT3VyMFRkcWEvblND?=
 =?utf-8?B?bHRtMFFmNXlPeWFFWjVsZFgvOUE3RGhtdHRrWmJzYStLellFN1hyTjlOME1z?=
 =?utf-8?B?cndiMDFQcXpFLzBUVnpiZ09WTWFGQkMyOGk2cy9CNWhBOHhERzdoQkRVT2VH?=
 =?utf-8?B?a0pvalFLRFJSN1Y2anRYYzAzMEtUdWRWVURvRmVTS2xSQjJab042ZVlVaEZa?=
 =?utf-8?B?c3B1ZVVsUEt0MTBLbzhEVHNYRSswMkw1MWhtQjE5Ni82cStiOUxrbDV6VDdq?=
 =?utf-8?B?cFF2aHlyTjUwYVcwUFNwa25UZ1VDUldXM2tNOE94ekQwZ3BnYmN1Z1VYVmJX?=
 =?utf-8?Q?fNdam4Hhlwo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TERrTFFXV0lhZ2xVZVQ4RXlRSjFiT08vMmVBbXI4bEFtSE00cU5jVjZrdVJM?=
 =?utf-8?B?NTd1c2QvdEw0NXhxOFd3QWFnVW5VZHdwbVBqeVBsdVhVYmZaelZyL094RE1V?=
 =?utf-8?B?MGNzczRMRHg0SElBV0Y3WTE5UFExcEdjQXNPa0lka0VGaEN5dXZpR0RhUjZD?=
 =?utf-8?B?aDRnczZHZ3pYTlRoblpRVFhsUndvMm1UK0ZNSU1rQlZ1dnhVWEN5WVE0MlNG?=
 =?utf-8?B?L2JnTVVCcnF5V3RIc05JU3cvQzFSYjVBS0Y1aTRzdXA0bmZ1Zy9LMHhiZlNp?=
 =?utf-8?B?TmdzbzU4V2hJL1Foc1UzTDArZENpQXhRS20yMmptY2ZGNkZSRWoyNjdML3p1?=
 =?utf-8?B?N1FHbkJzNjJ2Y2lWVFhqMkFneVdmbG54WU9OaXVPT3AxWFRHMXpNQUlETERj?=
 =?utf-8?B?RUZPWnphd0k2ekUraEF5TUt1ZkdHcDJweHZUZloycHJESEVianMxTGpUNUNl?=
 =?utf-8?B?bHNTY1ROWWZlZHdMV2luNVc4QUx5QnJqQzdNNzhsMWorKzNXM2c3UUhld3hx?=
 =?utf-8?B?N0N3a0N3YnQ4cis1UGNJMWhHN1lmVndtN2ZiYlROS2UxVTRmVERnN0M5Y3FE?=
 =?utf-8?B?V0tUbDVEdEhWMlhocWJrdGdJY25ORmczZ0JabWhSOEQvQktjNUJYOEx4KzJ4?=
 =?utf-8?B?TGdTVFQvaWFDZnh5R28xQzRXZzhwcHh6MkJUSVpqK3FwQmlRaUQ3US9iQmJC?=
 =?utf-8?B?QzN6WFJoSWVaOFlXQ21pcVFwb1A0SVlRQzVNcHV2QXBHYjRxNTdXNWtoWmZC?=
 =?utf-8?B?MmJWRFhhREpYdWl6ajQ5SWQxU25IVCtyZGdkVEZQUks0Y0h4UWxMdXNmWXEv?=
 =?utf-8?B?cldLMDZvdCtFTUFVeGtKV1hDRGFsYmE4WjJ2bk5tUTNUa2IveFh6Q2d4Smgw?=
 =?utf-8?B?UGRFVkx2ckZzSE5hTlJkNG80VDBEUERWeEhxMGVPVkJnZmo1ZHMrZzVKMlVF?=
 =?utf-8?B?N2tpc2VHS0hYcXJERG9YazBqZzNXUnVMcGNlcEN5amh1TUdCQlcxTU9iUnFZ?=
 =?utf-8?B?aEk0ck8vV0UvWWVIWWxsby9qWEZ3aGczVHdianlkM3BnU3c2b1JTZEFCcTlu?=
 =?utf-8?B?emE2dHZHS3pITmI4VXlJamwrR2dOUmUyRnpDc2k0TWEyUG9yMFM3QVBHbjdp?=
 =?utf-8?B?K0I5YzFlcHZBYWorS0F5blovanFobkxzT3QrbGVsN1FHWVF5Z21Cd05rYWZa?=
 =?utf-8?B?dzhxR0xGMm5pSFhjdkhVU1BLWXFYeGpKZys0VFBpR0dwTEVNL1dJSk1WWjg3?=
 =?utf-8?B?b1B3T3k4eDNzZ2dReVUweU8xbm81YUIzNDR2b0dtSU1ZSnk1UkxKQ29Bb0N6?=
 =?utf-8?B?TmtoM085NmtMcnNWZ3VlbW1wNjBvbEpzK1c5T3Q3ZHNnOElVWHhMTWVBV3Nx?=
 =?utf-8?B?dDJqTTg0SENvaVFvRCtXT3lXbE1WMHdBSFRGT1k2cGoxakdUM29QNUFxYzND?=
 =?utf-8?B?L0JkaWFNeXJRSnJHTDVTM09weGkvTjRXVllyaGJiZEE0aVVhSHhWTTBnSnhz?=
 =?utf-8?B?bE4ySTFHcjJnNFRjYzhidnNRR3RKdnpaZncvQkYvS3g0NDlSVFRkclg2eHN2?=
 =?utf-8?B?Z2t2YVJidDVpYkc4dEhvS1ZBZTlYbi8vS0E4MEpqUHZobzg3ZlVlWVAyZ0hX?=
 =?utf-8?B?N2J2djAyWW9pc1kvZzJtcnczdHZJMU5IT2VZSVZYY1F4b3pYVmMzQy8wblFV?=
 =?utf-8?B?Y3drRWVKVGp3U2pBT1BQZStSUWpQUGJrNkxnU3Zya1Z4cVhYU0w4YnVwejhl?=
 =?utf-8?B?UDRvUHd1eG5NU1Z2dWZZTWV4MzZSelhkOG5KbTY4L2FJK0s5R09Bam93ZWNo?=
 =?utf-8?B?UUJQRUlGSHVmK0J5V3ZJaFlIekl5eVI2aC9vdGJKbkIvbThBQUhYZWVkWGZU?=
 =?utf-8?B?SWlGMklqY1lHV0dQWDVrSC8zc091bm8vUSs3clhzRENlTW9YZDN0NThBUWk4?=
 =?utf-8?B?NG9qWXpicmExU3pBM1B6SXVJZGpycWlBV29VaDVYV0RvdGxiWldEMmUvSElY?=
 =?utf-8?B?NFpRWnJ6RjJ3dnE4MHFKRmJuTFhuM24yY3RYMGZXMzJqS1lsWE9BekErK1g0?=
 =?utf-8?B?MFlvVjdCU1I0QUhlL2pJVzg5b0xWTlpNVXlHZzMwdDdwRE5rcWIyNEdpamh6?=
 =?utf-8?Q?a1YvEJgPzbxKH3TRuqDRQnL4T?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2566c40f-8c31-4e61-ffa7-08dccbe8062a
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 07:14:17.8959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bx7aJqdkLppd1M0RLsBTd9yKw1iJep0BXNYkKncnqfo4ro5ESN23ZINioYY15jedAc6YjFLrabq5ZIVY6tFLYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6584

Hi David,

Thanks very much for the detailed comments and explanations!

在 2024/9/2 21:45, David Hildenbrand 写道:
> On 02.09.24 14:24, Rong Qianfeng wrote:
>> Reserved pages are basically non-lru pages. This kind of memory can't be
>> used as migration sources and targets, skip it can bring some 
>> performance
>> benefits.
>
> Any numbers? :)

I am still thinking about how to design test cases. If you have any good
suggestions,  please tell me. Thank you very much.

>> +
>> +extern void set_pageblock_skip_range(unsigned long start_pfn,
>> +                                  unsigned long end_pfn);
>
> two tabs indentation on the second line please. Applies to all others as
> well.

Got it. Will do in the next version.

>>
>> +     /*
>> +      * We set the PB_migrate_skip in
>> +      * reserve_bootmem_region() for cma
>> +      * memory, clear it now.
>
> You can fit this easily into less lines

Will do in the next version. Thanks.

>>
>> +     /*
>> +      * Clear PB_migrate_skip if the memory have released
>> +      * to the buddy system.
>> +      */
>
> ... after freeing the memory to the buddy."
>
> And maybe
>
> if (pages) {
>        if (s)
>                pr_info("Freeing %s memory: %ldK\n", s, K(pages));
>        clear_pageblock_skip_range(...)
> }
>
>> + clear_pageblock_skip_range(page_to_pfn(virt_to_page(start)),
>> + page_to_pfn(virt_to_page(end)));
>> +
>
> PHYS_PFN(virt_to_phys(start)) might look a bit nicer, not need to
> get pages involved. virt_to_pfn might be even better(), but it's
> not available on all archs I think.

You are right, I tried to use virt_to_pfn, but later found out that it 
is not
supported on x86.

>
>
> What about free_reserved_page() ? There might be more, though
> (kimage_free_pages()). You have to take a look at all functions where we
> clear PageReserved.

Thanks for your reminder, I found that I missed a lot of functions.
Maybe a better choice is to clear PB_migrate_skip in free_reserved_page()
to reduce the amount of modification.

Best Regards,
Qianfeng

