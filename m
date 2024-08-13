Return-Path: <linux-kernel+bounces-285251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1A3950B37
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290AB1F21937
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388571A0700;
	Tue, 13 Aug 2024 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ClqelxUV"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2119.outbound.protection.outlook.com [40.107.220.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C8D26AC6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568951; cv=fail; b=r1MvXpWhd1gNS53uBVgsgdYHO0XUT1LWbm/cT1pIizSRIcjTUYDHQO+CrHYQzFgovYoy90mHSJ63QAtxDtmT4HQKBRNDVujy3mnP25bfW8KPmS4rkzGe2U6YNKijzHivbwHsr4gMJN4nlt8EkaUPxLzDnE57F6pdiT3TaPyK4QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568951; c=relaxed/simple;
	bh=GtysTqcVTaFuSKJeXL18MCYidSC/A4kYJx+fPyM3H1U=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y6nqhjgy/juZCX1Ox18sfDI3qg5S+IE7brUhqYlCfmJCv3rFokjs0bQHYQi2ewKvBepb6975XzQdo8mwOCVw9m5VXAXfKAkWlZGUwXPz4DwJKI27BaAIOZSoSypFvANRR3LQ6uZYh1g/+Mzel+Jm1OiQ89bhC7HcomKUO/mLBZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ClqelxUV; arc=fail smtp.client-ip=40.107.220.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRN+nrJTe+NIEFzzfW5niNV63PVcIHTyVa83u/PihsVRYfqfKwQpoe1Sp4aEaBKLRNqKFEZNfqFG4ZQ9pdQCaHhNaCmujfmTndu7ao9OYHcOCRCQn0ltUVMY55YB0hK6VBA048j0x5tpQ7LKRKv8tap6uz+MzuOcd+QHtSfi2bP1EO1agX6EFBIaXRDr9NDqABh2t6bqnZcu56zF21LZNqtR2VmXuP4CA/YACEcUrQRd9rBEy/RiDpqtNrfo+lTRmBm9zkbkFkoMEERI1OjXFdoPlFyxIIH8HM1TiqaUwSUNvQAtNlRhWf0qZ6eHuQ+819310bQ8aW+PzM7swVcnfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B44A5dyrkp6kPbgSVu2INnCCxAygjQNTHgq9KhlDnZk=;
 b=bwU/hxv91MwsFY80w7znxSTyk/rEHSxR4P3f4NUvYu44N59D5vqa54BjfchmIVkhRlfv3WaGBNVbsnewuLL0f2sCCrslTdgo2N4PoYSKlpfvBSP8kU7bDuPqr3zN76vKF8jlY98HspGrDTy3EJPWHa1mOx6A+9hALvIa8BXr/Z948VSOW8A/00n6r8lGu/9MmZbvx0tboVuXEWbMe0JMkFgglsXpi/ZFQMtcwWL4PsSX8/7XWEa3spGpRZH0Y2W1qWdNQWfv8dbQuIZkT+KGXPGPvzbBCk/hAQm06gvMRpd4VGzWmLSk6LkdceNJxiGGPz5CGyqgGXZYcHQYLGNX3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B44A5dyrkp6kPbgSVu2INnCCxAygjQNTHgq9KhlDnZk=;
 b=ClqelxUVO+Qw6+79iAVpM6MBq2DLPmJlJ3SjfriZ2bb+2+JyAOTLCf6T3ocRRTiFDy2qZuoOHNZWnPaXELE15+jwVlRzlCi2wsh78NB+fKgCCeG4U3+3OR4HooQAct999PsZW57l/Ipaguxoy1oYezmstJtTYPf7BVGWVq3UWGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 IA0PR01MB8238.prod.exchangelabs.com (2603:10b6:208:490::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.22; Tue, 13 Aug 2024 17:09:07 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 17:09:07 +0000
Message-ID: <e8497b6b-c85a-4b11-9c0f-01528c82cb92@os.amperecomputing.com>
Date: Tue, 13 Aug 2024 10:09:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
From: Yang Shi <yang@os.amperecomputing.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, will@kernel.org,
 anshuman.khandual@arm.com, david@redhat.com, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <Zn7xs6OYZz4dyA8a@arm.com>
 <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com>
 <ZoMG6n4hQp5XMhUN@arm.com>
 <1689cd26-514a-4d72-a1bd-b67357aab3e0@os.amperecomputing.com>
 <ZoZzhf9gGQxADLFM@arm.com>
 <35f70ba6-5305-4268-b7ba-81545cacd83f@os.amperecomputing.com>
 <Zo2C4eXr5_9kifyO@arm.com>
 <cb0bd817-6948-4944-ab09-4ec2aba41cfa@os.amperecomputing.com>
 <Zo5S1JE8B912SHya@arm.com>
 <6167c4ce-fef0-4af4-a6a1-9fe7b2eb023d@os.amperecomputing.com>
 <ZpAZ39VQhxfNepWT@arm.com>
 <cf0777ce-52ed-46e4-b666-50a04d5025e0@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <cf0777ce-52ed-46e4-b666-50a04d5025e0@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::31) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|IA0PR01MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ea2f52-47eb-4a5e-a5a1-08dcbbbaa3e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blVxaXFETi9Bckl2bFJyUlhKV0FOUWw2bnFtL2dsUFp2OHcvUys5eUtaUXpO?=
 =?utf-8?B?c1FXRVlxU0RwenhsZjQxNkhhczNCM0dsdzhvRmR5NnRSZGFNVUtsV3BqMXll?=
 =?utf-8?B?OTJQcDVVVG0wM3luL29weExML05EUng3WnhWditrUmt3VWxJWWkxaUMyOEJD?=
 =?utf-8?B?dm9UNXc2Nzd4cHlQWEhIa2swcmNtU3FITm9CTEcveGY4Q3ZGVTVETERLdkM1?=
 =?utf-8?B?YnJHc201TTRJcjV1UWkwVk1PY21RK25LSnFwTWRobGY1OEcyTlp4TmdBbVRy?=
 =?utf-8?B?NmdHK2JwMHl0T1ZLR2F5T0NLclV3VUtKVGVROFNmOWdsRktDZ0VjYk9wMUg5?=
 =?utf-8?B?bkZNbHNkU2RrMU9ObDQrdElFRnF4QkVlanZjbDArOTNyczNHY2FOUjZ2RUtw?=
 =?utf-8?B?R3dJd1hNVnVqZmNiSGg0akwzY3ZwV2FXam5MeE5jSUR1Qm1ENUxicjRKZk5p?=
 =?utf-8?B?WXVPeDZBTmNEN3JaRkxIZlJUZEZkaXkrbFBVeVg3QkM2aE5YZDJuZ3NVNzZa?=
 =?utf-8?B?akozU0FoUGw5NEdPWEtnQkJjbUwrK2lGY3ozT3RnN2tLclREcW55L3hMNGV2?=
 =?utf-8?B?VG9iUEhGNVJTWndtcmRSMzRNS1Uyck1mc0w1TWl5U1hTOXlqR09EK0FIT0pJ?=
 =?utf-8?B?TWUyekhwRUNEVEZzSUFNWDNGb29YcmJNSWtsZksrc1lHM1dxTnUyemMvVkZU?=
 =?utf-8?B?QVd3S3NLUS8rSmxLNlhERVNsUi95QVgyeStMNTZzaVlrT0hxNUk0eXpOOVNM?=
 =?utf-8?B?cjRINzBCQ3lKRkY5YU5sR2NlaWFyaXpGcFlSTUlieFpNeVM3KzFZWXhEWCsr?=
 =?utf-8?B?YVhZa3BtUW5RSmlWTmJEVXQ3SXJhTWh6ZCtyQkN3OUNqWDQxQnphM2JRMDNY?=
 =?utf-8?B?QTRtNFBqVmhjN0tUL1ZtcHRTVEc4OTBFNkVYaCszYnowSEUrUFRHcnU2TWtl?=
 =?utf-8?B?aDhYc3NldGc1UCtUVlRxc2pUNmt3SXVMTVpLbUR0YmlvSks1NUNnUzhrLzhZ?=
 =?utf-8?B?NW1qdW5BV1EvR3BqSm8xZWtaK3hHbzQ4VkpSdG9QYWNOR3F0dkdna3lJcVN6?=
 =?utf-8?B?cjhSeHpZanY4MnVTM3BJSU90clJXTDhHdVMwNmdta2J2ZHVRSkJ6R3dqVkkw?=
 =?utf-8?B?RExaa2tsZzY3bEpNMkRPYXFjVHdxTWs0UmlKOEh5Yk1KMnIyOW44d3E4ejBU?=
 =?utf-8?B?Qm1mUHh6cmZvWC9pVCszWE14czlBa3dIMDlXR3RlbjF5dEpSWGwyT3kzeFBG?=
 =?utf-8?B?NlQ2RUlGM1Qrd2QxREVHcE1qWnBTYUEyQlFFVkgrdUhsZ1h3aWFhZGhNUzhE?=
 =?utf-8?B?YVBLU1BmWDFFZzlPWUZ2L085OVNpb1M5SDdCdUgwNEhlTHNkc2tZQW1Fa29j?=
 =?utf-8?B?cXpSOW1wbWpiZ1ZlZytoR2ZOOTdHR0FoQXJzZS9xSXlyOC83WjljWXIzRVYv?=
 =?utf-8?B?YWVSaUVQLzhGZ1NxZ3hzT3RHQnpra3VJOVNkUTJBdXE4bys3bStxVk0xMzEz?=
 =?utf-8?B?cjk2V2N1SXpzWDYrQnBYL1h1Q2YyZ1FLVTFuSjdUQndHYjBXZTUzQkVaOFk2?=
 =?utf-8?B?bkVNeWlxQ1oxams0ekwxRll1WDV4WnZ4bzdZQ3hrY1ZuTGhUUW5ZM3dTSjJT?=
 =?utf-8?B?NUVHVENIV3U3eHdVbG1CZjA2VGNtSVZzdnI4MkljRlR5ZHFkQ3Q0blliR0VL?=
 =?utf-8?B?YUMzbm9CZjBvTFVWdDkwYWZWWnd0cDZVbUJyYnQwbndwMzcwakhGRWJMOHdr?=
 =?utf-8?Q?MJDh9KMFn9W6N3xkak=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjk0V2Z2dkY1Y3pDVXVTWDRrTDZiWmZNRWhQcjBiUTcyQUdUN3JFQnRzSW5t?=
 =?utf-8?B?cEs3dlN6YUpkQ2hLZncyd2Q3eFIxeUFQVW1ySFRIZWF4dUorSk9QTTJoUlZR?=
 =?utf-8?B?ZFlXVkZpN2wvREwyUisycmRwc1dYYUJ3VXg0cTFHNmkrdmxMWU4yZUV4cmNJ?=
 =?utf-8?B?R1kwdXY3bmtWNGxFY3FqNGIvN2p5VnczUi9nZmVjNU9sKzJWNkU1MTNJRWJw?=
 =?utf-8?B?U0R0cmhYS2N6ZHV6MndvZEhLVHQ2Q2twaUtBM0NRSzZWWkNRTk9yVkpmcDFT?=
 =?utf-8?B?emRCU016VGZsYmNwSERmY29ma1hrNTZQYmdVSEJCdmNiQlRrakJUSWQ4Qno4?=
 =?utf-8?B?dHVaL0tTWVR6Y2ZNOHU0Tm92clVvZmYwUEIzKys3d3A5VEZTL2xaK0Z0bVdP?=
 =?utf-8?B?dFNMbGZ5NDlONVNpeVZBRW1qZ0JDcE50bHhYd0JsR1dMVmhyNEt4dDB5S3ly?=
 =?utf-8?B?NFBXaHdNdWh0ZzB1RUxWZzg1WjBvSHYvZ1JsQTdPSUJ0SGM0b3d0SGNtYnJR?=
 =?utf-8?B?dVRFc2RYeVdCbEExZFVUTXNGcVZFTXplOFBPWFpLbUJ3cWo0RFFXdVQ3UnQ4?=
 =?utf-8?B?OTk2UDBhT29jZTJIUmVuVVQrSStxNkRRQzNGMUM3QSt0aThxdytWVitMclBE?=
 =?utf-8?B?Y01iS00rS1RwZnU5bDhNRUZMdmFnak9CMjNQVG16d3d0cEhOZE0rbVFVcFor?=
 =?utf-8?B?OTI5OHpJYW5PU3IweS9YT0c3UTJwdUE0Nkx5UGlpaWhJQkxHdE1VWmdPbURr?=
 =?utf-8?B?VTBaN051T1c4VWNyakZuUFExUkNHY2NhUEMxNEJ6dkRPb040cE5GRzNHWktj?=
 =?utf-8?B?d0kxWmFqdEpZdjVDTzk5bUNDdkIwOExWWmk2VWxQQ3h4QTZtNEg0enczckVM?=
 =?utf-8?B?M1pDd0hoNnpvZDdVb2lOVUlrR2MvazZtb1hCNGthMXV2NlZYT242UkVIYUxz?=
 =?utf-8?B?L1gwSEFlVk56WmR1dFJ6NG9lUXlZYzRwdU96MGRzaG5XL3RYMnZYZlgzRVFi?=
 =?utf-8?B?QVVvVkRxYnN4TCtJSzZOUFdjSUxnYUtzVGM4TkkwY3c4RzdUNUdkUy8rMGx3?=
 =?utf-8?B?NXJsUmc4QzloajdJRjJibUtGTEY0NDB4TmZzLzVmck9DakRZYnU0aEdUcXg5?=
 =?utf-8?B?YW9FL2U1bGtvT0ZxaUdZUFJ4ZTB0dXZBMkNDa004dGx1YStVb2VZL0xlbmg1?=
 =?utf-8?B?cGU4RnVvcXozMFh5VzBYTG9vOW56dC9obVIwTHkvMTFkZ0RBTWhJcmNuYzgv?=
 =?utf-8?B?ZlNVb1JzQ0wyODdHdGRFalJLeng0eFlaM2Y2aUFhWHBaOE92VDBSNTh0ajJS?=
 =?utf-8?B?cENsQzVUMnBmUGlTN2NnWXNFQVpEQ01RaE11MGFxTHpkdTMzRHZNL29QMVo2?=
 =?utf-8?B?RHNXRHM4cUEvY1NUNzhHdHpvM1FxYzNqTElUQzFxTUdXaHlWRFlCN1lJNkdl?=
 =?utf-8?B?NVNFNEtZZEphd09yUzVGckVBamNRYVI0MXFDblZ1OFhyWVUxQ3JvRlZadkRI?=
 =?utf-8?B?QVFnWU9lOHcwMmJqb01iZUY1U21xdi9SRjV6QU1NZlBIdGlLSCtqTVpRbkpp?=
 =?utf-8?B?ck1JL2dHNzJXeVM2KzZEbDZVRWRTaTdvRDk1TE9wZUltakhPblhxd0xzeFlI?=
 =?utf-8?B?OVdjY2VWOC96cVVTUFY2UUJ6dFdVbTcxY3pYMXMxNjY1QTVmRDFnZU8vaEZv?=
 =?utf-8?B?OWd1YlFuSFUwcTg4NHBBakZTZnpzTFRQSTJOdFVmREZCUDlrMTFwQ1JmUGtv?=
 =?utf-8?B?NmN6SjRQSElKTU95S1Z1S2I5V0hVN0J1S1dFVi94aVNnYUFiYjJwL1JZQlpr?=
 =?utf-8?B?dnB2N2VnRFhQUFVrazg1Z3NUL2FZS1RvejhyZ0NHbDlRRVBHd0NIN3JHbGhE?=
 =?utf-8?B?Mnc3K0tjRmxHNlYzYjBVSkN5cUpacTdmeHlhaW5pY04xYTZ0czM1ZGFsRWww?=
 =?utf-8?B?bmhMZWpBdlZIa0s3TERqVEttRGhaRDNFcHEzUmVvY3lTektYUjA4UkpxcEt6?=
 =?utf-8?B?M0xiK2RKMlYzOXRUWE5IVHdEL2Rud1BUaDU1RkkzbTZjTks3Wm96R1p3VWJy?=
 =?utf-8?B?VWpIU1lUbDZvN0pRczZQeG9EcHBaY2FiNTZReG5yZXM1NFE5am1ZVzVVa3gx?=
 =?utf-8?B?N1BzS2NuTEpNb3BWN3NNUUJYN0RGeG1DNjlzM1dzTVVKOG9MUHpRTWNTN3d4?=
 =?utf-8?Q?+9+wXQ5HY5kVifTvcL6aTHM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ea2f52-47eb-4a5e-a5a1-08dcbbbaa3e4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 17:09:06.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcA2qcmC1WVGFwrgFOU645fA31EWLMkQJ6s+Pm+iAo4FSVbAyeefVhRVro+pf/LhsCVFoBebRw7hSFz52GR8XOENqAvdl4P2uQdC1ui6bMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8238



On 7/11/24 11:17 AM, Yang Shi wrote:
>
>
> On 7/11/24 10:43 AM, Catalin Marinas wrote:
>> On Wed, Jul 10, 2024 at 11:43:18AM -0700, Yang Shi wrote:
>>> On 7/10/24 2:22 AM, Catalin Marinas wrote:
>>>>> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
>>>>> index 642bdf908b22..d30265d424e4 100644
>>>>> --- a/arch/arm64/mm/mmap.c
>>>>> +++ b/arch/arm64/mm/mmap.c
>>>>> @@ -19,7 +19,7 @@ static pgprot_t protection_map[16] 
>>>>> __ro_after_init = {
>>>>>           [VM_WRITE] = PAGE_READONLY,
>>>>>           [VM_WRITE | VM_READ] = PAGE_READONLY,
>>>>>           /* PAGE_EXECONLY if Enhanced PAN */
>>>>> -        [VM_EXEC]                                       = 
>>>>> PAGE_READONLY_EXEC,
>>>>> +        [VM_EXEC]                                       = 
>>>>> PAGE_EXECONLY,
>>>>>           [VM_EXEC | VM_READ] = PAGE_READONLY_EXEC,
>>>>>           [VM_EXEC | VM_WRITE] = PAGE_READONLY_EXEC,
>>>>>           [VM_EXEC | VM_WRITE | VM_READ] = PAGE_READONLY_EXEC,
>>>> In theory you'd need to change the VM_SHARED | VM_EXEC entry as well.
>>>> Otherwise it looks fine.
>>> Thanks. I just ran the same benchmark. Ran the modified 
>>> page_fault1_thread
>>> (trigger read fault) in 100 iterations with 160 threads on 160 
>>> cores. This
>>> should be the worst contention case and collected the max data (worst
>>> latency). It shows the patch may incur ~30% overhead for exec-only 
>>> case. The
>>> overhead should just come from the permission fault.
>>>
>>>      N           Min           Max        Median           Avg Stddev
>>> x 100        163840        219083        184471        183262 12593.229
>>> + 100        211198        285947        233608     238819.98 15253.967
>>> Difference at 95.0% confidence
>>>      55558 +/- 3877
>>>      30.3161% +/- 2.11555%
>>>
>>> This is a very extreme benchmark, I don't think any real life 
>>> workload will
>>> spend that much time (sys vs user) in page fault, particularly read 
>>> fault.
>>>
>>> With my atomic fault benchmark (populate 1G memory with atomic 
>>> instruction
>>> then manipulate the value stored in the memory in 100 iterations so 
>>> the user
>>> time is much longer than sys time), I saw around 13% overhead on sys 
>>> time
>>> due to the permission fault, but no noticeable change for user and real
>>> time.
>> Thanks for running these tests.
>>
>>> So the permission fault does incur noticeable overhead for read 
>>> fault on
>>> exec-only, but it may be not that bad for real life workloads.
>> So you are saying 3 faults is not that bad for real life workloads but
>> the 2 faults behaviour we have currently is problematic for OpenJDK. For
>> the OpenJDK case, I don't think the faulting is the main issue affecting
>> run-time performance but, over a longer run (or with more iterations in
>> this benchmark after the faulting in), you'd notice the breaking up of
>> the initial THP pages.

Gently ping...

>
> I meant the extra permission fault for exec-only should be ok since 
> the current implementation can't force write fault for exec-only 
> anyway. It does incur noticeable overhead for read fault, but I'm not 
> aware of any real life workloads are sensitive to read fault. The 
> benchmark is for a very extreme worst case.
>
>>
>> Do you have any OpenJDK benchmarks that show the problem? It might be
>> worth running them with this patch:
>>
>> https://lore.kernel.org/r/rjudrmg7nkkwfgviqeqluuww6wu6fdrgdsfimtmpjee7lkz2ej@iosd2f6pk4f7 
>>
>>
>> Or, if not, do you see any difference in the user time in your benchmark
>> with the above mm patch? In subsequent iterations, linear accesses are
>> not ideal for testing. Better to have some random accesses this 1GB of
>> memory (after the initial touching). That would mimic heap accesses a
>> bit better.
>
> I didn't try that patch. I think we discussed this before. This patch 
> can remove the THP shattering, we should be able to see some 
> improvement, but TBLI is still needed and its cost should be still 
> noticeable because the write protection fault still happens.
>
>>
>> Anyway, as it stands, I don't think we should merge this patch since it
>> does incur an additional penalty with exec-only mappings and it would
>> make things even worse for OpenJDK if distros change their default
>> toolchain flags at some point to generate exec-only ELF text sections.
>> While we could work around this by allowing the kernel to read the
>> exec-only user mapping with a new flavour of get_user() (toggling PAN as
>> well), I don't think it's worth it. Especially with the above mm change,
>> I think the benefits of this patch aren't justified. Longer term, I hope
>> that customers upgrade to OpenJDK v22 or, for proprietary tools, they
>> either follow the madvise() approach or wait for the Arm architects to
>> change the hardware behaviour.
>
> If the overhead for exec-only is a concern, I think we can just skip 
> exec-only segment for now, right? The exec-only is not that popular 
> yet. And if the users prefer security, typically they may be not that 
> sensitive to performance.
>
>>
>


