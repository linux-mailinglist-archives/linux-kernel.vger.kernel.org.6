Return-Path: <linux-kernel+bounces-371035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8289A356D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 071FDB2127E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60AB17B4FC;
	Fri, 18 Oct 2024 06:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xfIqD4z0"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2E915CD78
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233134; cv=fail; b=V+scIPmLz+sj0j2+3apQLFknBHOnKLVNsmMWoGJnyF42jZHNNcWQeVJDbW9FdJz6yKSlTrBwu2juZfGYtwGm18knVSUaKYN8+Z6fz4S/8stqCJ6gEqVC29q+VBvLEqlWElknFKvrxLVYXsX/7nMHzTuC0TX4UwfOvtEdfHjOYHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233134; c=relaxed/simple;
	bh=tkOyGqHGkpRPL48MHHtsRSAV9xkCAKAox79VezDPaWQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AyshP0EgcKqdAbmsVfZvpHv3v3VgWgrB1Ze3FDLxcleg2Gt81dOTD6xW1KvvG7ADL+3tz5E/wXMbKCzS+8GDMBSO+wlYqfWc5GbFFyj9zS8twF6MrTpcI4t/sAyk2jqKFLFyERZmZi84OfXaN6zYOwz+D7evlLYkjOdC9cEzDPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xfIqD4z0; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXhnz/y6lUABba+vMdh69prruEMxXipsPk/cuN6BsrUqh8oVaPLFMBfLkZGlY6u+BWQXcKsDvBus6Zz1r5uFA0wT3PDZnrDqjSW/OSl8K0l9e7WdZhtZ95ivjXslyiYYoRqGRU9ikn219Ix7VZqOv75OXBoiLAwWQ4waQOBLImzcy1pD3jK1BkvIubTkQpUxRRKhKct9o2JRlRJiyV396K3BPgrGWlxazTv7vCy2kfCgPkhIKzuBI4LSfV2MDU9eUEAIvDK32I33uNftzzcuV6JYQa4jL38u3LoUvSCToSiLpRFE20j032Dz6EH5PxNorNEGEz67l92vDM1nqN+Grg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NurHBv2CHX8lmIZ3yyyWeSh37pVcgxdMMLi1uyRNsV8=;
 b=VPLYv/PJYX2yrgXRTGvT/qMrY9zJ3V0euoEYjlFn3oWDXV6lpVUrMQh3UgzTl+HmgUEk05wcOhLk0/f8VkSKJKBuw3UWbZQYFh2ni02ULn1zW2CY5vO+6oRwK1/ZYddgBT9a6Ve2bzy7TgELaQOc46iGHdrUjjpH+E7J53OuUVJpQgCq1Kg9EtCQn1nrMU0JOnzxMpdYuwgRd4yOPJCYW+wFzJp9+X5WeKpADURoBG28s7MHUMc67/1EMx0Ls3LkUSsDaPJpSGFQuV2WD7uj7wZYnKsoaBunUe3J79d87O7/ryMt5t7x4d7lLpOlOLdF6mkMN0L7mcEis9Q1pTymsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NurHBv2CHX8lmIZ3yyyWeSh37pVcgxdMMLi1uyRNsV8=;
 b=xfIqD4z03zbGNUPnktVajLyZypEfVkRJmyAZiIPaCt4VOmMVCH+C1d/JHF/Ft/RpH0RxkU1C6Eiv5OYo0xAPDriITms6tCFIGZ7NAEf9HQcAEFSxSfTnPVGX1LNTIKAEHFM3B/uCoZ+4UJ8TAahtA0Vr2T/t//CEInYBTxSCdrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 06:32:09 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 06:32:09 +0000
Message-ID: <d20e0333-4710-9153-a687-05b708769616@amd.com>
Date: Fri, 18 Oct 2024 12:02:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
From: "Nikunj A. Dadhania" <nikunj@amd.com>
Subject: Re: [PATCH v3 7/8] x86/sev: Add full support for a segmented RMP
 table
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <333a437e6412a27ee666e10c2aca568985868ed9.1727709735.git.thomas.lendacky@amd.com>
X-Mozilla-News-Host: news://54.189.247.149
In-Reply-To: <333a437e6412a27ee666e10c2aca568985868ed9.1727709735.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::17) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6109f2-4e46-4f9f-3612-08dcef3e976c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SERneG92NmhHTFphMHBnRUx2VStqaWRQTkpXZDFQM1dpbzcvc0JHaTJsYWly?=
 =?utf-8?B?Vll2T1VuSGJJRlpEQU5mWThaVUJvbWZNdE04d2dSNVEzcWk0OFA2cG51QlZi?=
 =?utf-8?B?UGhOVThkdHM3Slg0RFFlRFpvcTVYZFZUV1hhVjlTOEJ0QVpFS2Z1d3RyTHBa?=
 =?utf-8?B?eG5vaHRxTTR4SDZ6TjJ1bU9aTllVZ3BITEpROHEwZjhPWDRYb3k5K3NiRk0v?=
 =?utf-8?B?VEpvT0N6SzQyYTNRVVdpYnpzYmhRTmt6MnYwcldCZUxqWWVoT040RzVzR0Ix?=
 =?utf-8?B?VFNYNUpYVUtCakwxUFF3dFhreXFiRTFjRmdOSlVwL2x4bnN1UU9mOHRXcG94?=
 =?utf-8?B?YkNDRDlGcFhFaytZYVNpbzUvampBcmVTYzFDYkxVVTllZTNxdXVmZWZWZXFu?=
 =?utf-8?B?ZmJGVkluU2ZvRnErUnU3Qm1aTXNZaFZzVksxZDFHWHdhSTR0ZW1aUi93SGV2?=
 =?utf-8?B?dVlZV3FYaWViWk5qazljTWZzUzY1djFkaFZiU1lwZDM1QmhxZy9oaEQvL01L?=
 =?utf-8?B?clcvdnpYc2RlR1ZhQ0llVWN5bmVCZFExTjJqWG9rV3BZdEcxYmdOZWFtL2Zp?=
 =?utf-8?B?NGdjSTVMVFVCeFBZMjVObjhEcUF0QTIvQWxRLzh3dFFieWkrUVhLYm9ZQ2xX?=
 =?utf-8?B?RDNPSDNjUUd6UTRpWG5PcnpCTXBNNEhNb0I5TWlQK2xFdms3S3pNYk9YRlcv?=
 =?utf-8?B?OTVOenRKS2VDZ2pXN0hHM01pS0NnNTFTVkNMb1ByL09GcCtrMEwvTU5EMm41?=
 =?utf-8?B?WTl3cmpNaVJZbkJTRWJNSVFGaVI3eUR5bkRlcmVGQkQrZ0lGcVAzVnRWNE9J?=
 =?utf-8?B?c1BmM2htbElhc29saHFFdHQ4eHdBYVd5L1VVbm03cngrTW5EbktnbDNneWpE?=
 =?utf-8?B?R08xMlhUT2d1TkplazY2YTFOMlNSTTcvMFhIRmZWbEhTT1I3dGt0dkEyVFJK?=
 =?utf-8?B?TW9oUmVKdDNnNjdJRWJrKzZUaWZqak9lcXNvR1FyYVB1TUk2RUl5U29YajNy?=
 =?utf-8?B?ZndEQlpIaUdPQXpoNkhtVlhsQVVIMlBzUlNXem0zRUl3bW1zZDNibTV2N1ky?=
 =?utf-8?B?MDJ6ZG1EYytQQVNSQzBZM0paejIrNGdPT3FpUGxOOEZtSERKRldQemRnUWJ4?=
 =?utf-8?B?RkcvSTBiVDNqZDM1ZWVlajM3d3VrWUp1THZGRXpLK2huUmxVT3lMeUlndnBG?=
 =?utf-8?B?VFFwc1hqVElHV3Vwcml0UWhUcU03bDBPektrMzBNK1VFV3FmY1V2Z3ZyS3BS?=
 =?utf-8?B?bXczdTJrN2NFNERJci9DYWwvU04yTzRTMWd0N0ZpVXpndWMvTW1Kdy9ZbWpa?=
 =?utf-8?B?RUpVRjJHZnhSZ09tUnpYMzBuUUczZi9NR1MrSzBVRnltZmVLZDVJWFNTZVIz?=
 =?utf-8?B?aWs4V21MZGk0dTk3cXlFTVFiS0NidXNZLzlTdWV6MUZaOHczNDlaR1Jrb3Rv?=
 =?utf-8?B?R21RWitxcWhxQ0U1R0dSenhkZ1UzOHVpbmllZ09LR3lIRnpCcWZ1bTljTzZP?=
 =?utf-8?B?Q2VqVHhINk9pekZlcnBEcFNvYm5wQkpCTmh6d2VCRFRSS0RTZTU4MGxMTjda?=
 =?utf-8?B?d3Jva2hJcFlvcmVRNit0bEZyVit3dGFycnlxbFg3SDBCQzdQQVRYd3BKVTdJ?=
 =?utf-8?B?bVcrVklqZENVdndWVmVzOWg4L3lwUmZ2Y2lORlZQS3RObHBZdWliLy9QeEx5?=
 =?utf-8?B?NXJJWm9jRE5qRkRCMXZlY21WaFpMalY3K3NTOW0rVzl5QjZwODduOTNwdEFh?=
 =?utf-8?Q?Lm0Y5vHbPPLT5yhP7QTTSgMFD7aQkmPvi+fhWUF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzJIUFc3MWtrNEpYdjhUTjV6cVp0VFI0OTdvRVVTTlEyZnV6NnlMeHpGa0tr?=
 =?utf-8?B?NkdzcStRLzNNSnM1bDhQSGo3T21ORzFtTXU1TzRGTklLUlZQS1IzQk5Jempo?=
 =?utf-8?B?a1hrTEhQUktrbk5VaDBNOTRrWFpHQ3dTai9ZeUtacGVPeElBblBRem52M1BD?=
 =?utf-8?B?eXVOSnZyem1rRmc4RnJPZkhTUHY2YUlMdlNoSkF5TXdMZWYveFJTWDNLK1hH?=
 =?utf-8?B?VWVIQlFZNzM5ZFJFb0wyMm9hUmErczVuZ1l4MFBVTi9rQ25iOUNyZElUczBU?=
 =?utf-8?B?NzBleThmZFFhZnVHVzFPTERJMit5eFdmNGM3VmtWRVB6amhJcWI0b0NVbFhI?=
 =?utf-8?B?QWg2TmhVYWR0dTJrK3M0YmRlSm9wRlU0K29KODZPRllBYy90VzFtYlZ0QWlm?=
 =?utf-8?B?N1pqaVBJd043MDFZcm9mN3RmOFJuN3NHZjhFQzNYRTNCWVg0WEUrLzhwdzJ5?=
 =?utf-8?B?QUl0RFhhWXdrM0hQTFh4S01TOEE3aUwzWHJNS1I0V2NzeUFwNHo4SjZ3QVZp?=
 =?utf-8?B?aUswYlpXRUJJZWRyM054eGtmSVd6UmI1MUN4dXJYenRPUHBsYnNFdU1Jem1a?=
 =?utf-8?B?Z2FOL0w0cWx5YzZLbXd0VFhwUyt5Ky9jdlpGZXRibXNMUGcwU05PU3hIUlBI?=
 =?utf-8?B?a0hWTkUxbTU2TTc4R0hNYWlDemVHTEdnRi9zUERzR2RFVFNDQlFxdmVkd1pJ?=
 =?utf-8?B?OGxKcnJNSlhrUXRLZWR0WWxoUWs3S3FzTTNzd3RYVHkzNllMcUx4SEtBUnJ0?=
 =?utf-8?B?ZkNna0Q1SlowcHZwUjUya0VNa3lHVmt2WVpxa1NDUWplbHNnT3VmQkZhYnhD?=
 =?utf-8?B?R0J5ZU5Qc1FiNHRlVWFFTFNyT09zTFJCTGFyYzhuYUdxNG53WjZ6VDN6RjZN?=
 =?utf-8?B?TkdhSUtUVVcwZHFteGRia1BhNWtUS0RkQ3VBOStacjlycndrK1JrN1EzWlA4?=
 =?utf-8?B?cTlnMVRwY0x3NmxjdFVGMit3WGpQVmlBdGhqSGlvRWYvZ3lMMUNWL3UyR3Vo?=
 =?utf-8?B?aWgzTEx5NDBVV2ZYdHI2SndFaGdReG42aVdMeUdPRlU2Z2kzSU1OZnNzRjdo?=
 =?utf-8?B?OGEwZ0duM3dnaVkrRERzYWZNd2F5SGpwbUpScm16STFFMitEYVFZeXZ1bTJ2?=
 =?utf-8?B?YzBucnhtT09FNW8zZFNPMXE2Qk9rT1FUZ2J1djMrWUFkWk4yK09XTWF3YWNC?=
 =?utf-8?B?Mm1lVTZUd3ZpMVUySjBjRVNseVhMQUpjWE1zQVpLQ051SFNyZTVnaDB1ejZ6?=
 =?utf-8?B?V0srVTkyeEtwN2dnL2FwZ1pVZmt0R0NDK0RrdWFHWDYxdC91TlM0Zm53T1Ex?=
 =?utf-8?B?dmcrZkl2OHBSQ3FHK09FL1ZsZkN6QmI5ZitkcUtXaHJEa3pnZW9MeTU4Qy83?=
 =?utf-8?B?Q3lQeGpNR3lFZk01VS9KOXM5Zks5RHB4c1A0TWxQMnVuL2VTUzQ2N096eUh6?=
 =?utf-8?B?bm1VTWNWR0N6cjl2d200TTI0eWJwNWxZMkJWUGN3c2lJN0ZYU21tOExLSERB?=
 =?utf-8?B?N3A2T0VoZERyWXVlY1NuZDM3NXhERTBxR1B2bUJwYk5xMDd5QUF3STFSSTlG?=
 =?utf-8?B?OXRpb0dtTitFYkJMSS9YcFB2Y1BjTTd5aHZmT05nM2laL0lacjJLUkhvbjM2?=
 =?utf-8?B?cnJ2VjdueUFQdUgwaWlJUDNOSWlCa1VWTEVWMUpiNlVDeUI0NUR0S3ByQkF2?=
 =?utf-8?B?cjNLRThKcFpCZjVQS2lRbEpxVnNrbS9qSnplbE9UY29leDRBUmx5MHB5QmhC?=
 =?utf-8?B?ZEowTVlvNXFSZHV2aExzYnZiN0c4VjRUOUpyMHJYQWt0Zzd2a3pleUdJU0Ro?=
 =?utf-8?B?d0RCSkcrRFY3bE42OWFYV1dmZVgyWEJQT3AwN1pYUGR6T3h5ZVlWdnRONDc1?=
 =?utf-8?B?TzlhY0pLY2Q4Z092T3RBZHk4dVl2SklzZHkrc2tRd2hSSlp3SUVud1VnelpJ?=
 =?utf-8?B?TlFGVzZCdXloNGhXQU5sNGpubkJET0hpVjVvU0NMSXZTM1NIbWt3WkhUeTlW?=
 =?utf-8?B?VnUzbStnMXFFOTZtbVhnb2NCQWU4akl3Q01aaE4ydktMUVY4aUVOK093eTBx?=
 =?utf-8?B?QWdyV1FJUXJjcVhSeXJabFd4cVpvSGo3aG1wUVMzYUtyYktsbEpYWTJXMGZm?=
 =?utf-8?Q?u4voHZiOemkz8VeNhcw8pEKfj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6109f2-4e46-4f9f-3612-08dcef3e976c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 06:32:09.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otI3NBWlnA4KmTvPD0SICfiTXwSv8iqiD9k4O+7pUKeTseYrCVOHIOV2wLOw1Avf11LB2CUZ4zaRvqc544CLgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706

On 9/30/2024 8:52 PM, Tom Lendacky wrote:
> A segmented RMP table allows for improved locality of reference between
> the memory protected by the RMP and the RMP entries themselves.
> 
> Add support to detect and initialize a segmented RMP table with multiple
> segments as configured by the system BIOS. While the RMPREAD instruction
> will be used to read an RMP entry in a segmented RMP, initialization and
> debugging capabilities will require the mapping of the segments.
> 
> The RMP_CFG MSR indicates if segmented RMP support is enabled and, if
> enabled, the amount of memory that an RMP segment covers. When segmented
> RMP support is enabled, the RMP_BASE MSR points to the start of the RMP
> bookkeeping area, which is 16K in size. The RMP Segment Table (RST) is
> located immediately after the bookkeeping area and is 4K in size. The RST
> contains up to 512 8-byte entries that identify the location of the RMP
> segment and amount of memory mapped by the segment (which must be less
> than or equal to the configured segment size). The physical address that
> is covered by a segment is based on the segment size and the index of the
> segment in the RST. The RMP entry for a physical address is based on the
> offset within the segment.
> 
>   For example, if the segment size is 64GB (0x1000000000 or 1 << 36), then
>   physical address 0x9000800000 is RST entry 9 (0x9000800000 >> 36) and
>   RST entry 9 covers physical memory 0x9000000000 to 0x9FFFFFFFFF.
> 
>   The RMP entry index within the RMP segment is the physical address
>   AND-ed with the segment mask, 64GB - 1 (0xFFFFFFFFF), and then
>   right-shifted 12 bits or PHYS_PFN(0x9000800000 & 0xFFFFFFFFF), which
>   is 0x800.
> 
> CPUID 0x80000025_EBX[9:0] describes the number of RMP segments that can
> be cached by the hardware. Additionally, if CPUID 0x80000025_EBX[10] is
> set, then the number of actual RMP segments defined cannot exceed the
> number of RMP segments that can be cached and can be used as a maximum
> RST index.

In case EBX[10] is not set, we will need to iterate over all the 512 segment
entries?

> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h |   1 +
>  arch/x86/include/asm/msr-index.h   |   9 +-
>  arch/x86/virt/svm/sev.c            | 231 ++++++++++++++++++++++++++---
>  3 files changed, 218 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 93620a4c5b15..417cdc636a12 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -448,6 +448,7 @@
>  #define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
>  #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
>  #define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
> +#define X86_FEATURE_SEGMENTED_RMP	(19*32+23) /* Segmented RMP support */
>  #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
>  
>  /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 3ae84c3b8e6d..8b57c4d1098f 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -682,11 +682,14 @@
>  #define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
>  #define MSR_AMD64_SNP_RESV_BIT		18
>  #define MSR_AMD64_SNP_RESERVED_MASK	GENMASK_ULL(63, MSR_AMD64_SNP_RESV_BIT)

> -
> -#define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
> -

Moved accidentally?

>  #define MSR_AMD64_RMP_BASE		0xc0010132
>  #define MSR_AMD64_RMP_END		0xc0010133
> +#define MSR_AMD64_RMP_CFG		0xc0010136
> +#define MSR_AMD64_SEG_RMP_ENABLED_BIT	0
> +#define MSR_AMD64_SEG_RMP_ENABLED	BIT_ULL(MSR_AMD64_SEG_RMP_ENABLED_BIT)
> +#define MSR_AMD64_RMP_SEGMENT_SHIFT(x)	(((x) & GENMASK_ULL(13, 8)) >> 8)
> +
> +#define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
>  
>  #define MSR_SVSM_CAA			0xc001f000
>  
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index ebfb924652f8..2f83772d3daa 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -97,6 +97,10 @@ struct rmp_segment_desc {
>   *     a specific portion of memory. There can be up to 512 8-byte entries,
>   *     one pages worth.
>   */
> +#define RST_ENTRY_MAPPED_SIZE(x)	((x) & GENMASK_ULL(19, 0))
> +#define RST_ENTRY_SEGMENT_BASE(x)	((x) & GENMASK_ULL(51, 20))
> +
> +#define RMP_SEGMENT_TABLE_SIZE	SZ_4K
>  static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
>  static unsigned int rst_max_index __ro_after_init = 512;
>  
> @@ -107,6 +111,9 @@ static unsigned long rmp_segment_coverage_mask;
>  #define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_coverage_shift)
>  #define RMP_ENTRY_INDEX(x)	PHYS_PFN((x) & rmp_segment_coverage_mask)
>  
> +static u64 rmp_cfg;
> +#define RMP_IS_SEGMENTED(x)	((x) & MSR_AMD64_SEG_RMP_ENABLED)
> +
>  /* Mask to apply to a PFN to get the first PFN of a 2MB page */
>  #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
>  

> @@ -196,7 +203,42 @@ static void __init __snp_fixup_e820_tables(u64 pa)

<skipped the e820 bits>

> @@ -302,24 +344,12 @@ static bool __init alloc_rmp_segment_table(void)
>  	return true;
>  }
>  
> -/*
> - * Do the necessary preparations which are verified by the firmware as
> - * described in the SNP_INIT_EX firmware command description in the SNP
> - * firmware ABI spec.
> - */
> -static int __init snp_rmptable_init(void)
> +static bool __init contiguous_rmptable_setup(void)
>  {
> -	u64 max_rmp_pfn, calc_rmp_sz, rmptable_segment, rmptable_size, rmp_end, val;
> -	unsigned int i;
> -
> -	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> -		return 0;
> -
> -	if (!amd_iommu_snp_en)
> -		goto nosnp;
> +	u64 max_rmp_pfn, calc_rmp_sz, rmptable_segment, rmptable_size, rmp_end;
>  
>  	if (!probed_rmp_size)
> -		goto nosnp;
> +		return false;
>  
>  	rmp_end = probed_rmp_base + probed_rmp_size - 1;
>  

If you dont mind, please fold the below comment update in contiguous_rmptable_setup()
found during review. If required, I can send a separate patch.

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 2f83772d3daa..d5a9f8164672 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -354,7 +354,7 @@ static bool __init contiguous_rmptable_setup(void)
 	rmp_end = probed_rmp_base + probed_rmp_size - 1;
 
 	/*
-	 * Calculate the amount the memory that must be reserved by the BIOS to
+	 * Calculate the amount of memory that must be reserved by the BIOS to
 	 * address the whole RAM, including the bookkeeping area. The RMP itself
 	 * must also be covered.
 	 */


> @@ -336,11 +366,11 @@ static int __init snp_rmptable_init(void)
>  	if (calc_rmp_sz > probed_rmp_size) {
>  		pr_err("Memory reserved for the RMP table does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
>  		       calc_rmp_sz, probed_rmp_size);
> -		goto nosnp;
> +		return false;
>  	}
>  
>  	if (!alloc_rmp_segment_table())
> -		goto nosnp;
> +		return false;
>  
>  	/* Map only the RMP entries */
>  	rmptable_segment = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
> @@ -348,9 +378,116 @@ static int __init snp_rmptable_init(void)
>  
>  	if (!alloc_rmp_segment_desc(rmptable_segment, rmptable_size, 0)) {
>  		free_rmp_segment_table();
> -		goto nosnp;
> +		return false;
>  	}
>  
> +	return true;
> +}
> +
> +static bool __init segmented_rmptable_setup(void)
> +{
> +	u64 rst_pa, *rst, pa, ram_pa_end, ram_pa_max;
> +	unsigned int i, max_index;
> +
> +	if (!probed_rmp_base)
> +		return false;
> +
> +	if (!alloc_rmp_segment_table())
> +		return false;
> +
> +	/* Map the RMP Segment Table */
> +	rst_pa = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
> +	rst = memremap(rst_pa, RMP_SEGMENT_TABLE_SIZE, MEMREMAP_WB);
> +	if (!rst) {
> +		pr_err("Failed to map RMP segment table addr %#llx\n", rst_pa);
> +		goto e_free;
> +	}
> +
> +	/* Get the address for the end of system RAM */
> +	ram_pa_max = max_pfn << PAGE_SHIFT;
> +
> +	/* Process each RMP segment */
> +	max_index = 0;
> +	ram_pa_end = 0;
> +	for (i = 0; i < rst_max_index; i++) {
> +		u64 rmp_segment, rmp_size, mapped_size;
> +
> +		mapped_size = RST_ENTRY_MAPPED_SIZE(rst[i]);
> +		if (!mapped_size)
> +			continue;
> +
> +		max_index = i;
> +
> +		/* Mapped size in GB */
> +		mapped_size *= (1ULL << 30);
> +		if (mapped_size > rmp_segment_coverage_size)
> +			mapped_size = rmp_segment_coverage_size;

This seems to be an error in BIOS RST programming, probably a print/warning
would help during debug. 

> +
> +		rmp_segment = RST_ENTRY_SEGMENT_BASE(rst[i]);
> +
> +		rmp_size = PHYS_PFN(mapped_size);
> +		rmp_size <<= 4;

A comment above this will help, as you are calculating 16 bytes/page.

> +		pa = (u64)i << rmp_segment_coverage_shift;
> +
> +		/* Some segments may be for MMIO mapped above system RAM */

Why will RST have MMIO mapped entries ? 

> +		if (pa < ram_pa_max)
> +			ram_pa_end = pa + mapped_size;
> +
> +		if (!alloc_rmp_segment_desc(rmp_segment, rmp_size, pa))
> +			goto e_unmap;
> +
> +		pr_info("RMP segment %u physical address [%#llx - %#llx] covering [%#llx - %#llx]\n",
> +			i, rmp_segment, rmp_segment + rmp_size - 1, pa, pa + mapped_size - 1);
> +	}
> +
> +	if (ram_pa_max > ram_pa_end) {
> +		pr_err("Segmented RMP does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
> +		       ram_pa_max, ram_pa_end);
> +		goto e_unmap;
> +	}
> +
> +	/* Adjust the maximum index based on the found segments */
> +	rst_max_index = max_index + 1;
> +
> +	memunmap(rst);
> +
> +	return true;
> +
> +e_unmap:
> +	memunmap(rst);
> +
> +e_free:
> +	free_rmp_segment_table();
> +
> +	return false;
> +}
> +
> +static bool __init rmptable_setup(void)
> +{
> +	return RMP_IS_SEGMENTED(rmp_cfg) ? segmented_rmptable_setup()
> +					 : contiguous_rmptable_setup();
> +}
> +
> +/*
> + * Do the necessary preparations which are verified by the firmware as
> + * described in the SNP_INIT_EX firmware command description in the SNP
> + * firmware ABI spec.
> + */
> +static int __init snp_rmptable_init(void)
> +{
> +	unsigned int i;
> +	u64 val;
> +
> +	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> +		return 0;
> +
> +	if (!amd_iommu_snp_en)
> +		goto nosnp;
> +
> +	if (!rmptable_setup())
> +		goto nosnp;
> +
>  	/*
>  	 * Check if SEV-SNP is already enabled, this can happen in case of
>  	 * kexec boot.
> @@ -418,7 +555,7 @@ static void set_rmp_segment_info(unsigned int segment_shift)
>  
>  #define RMP_ADDR_MASK GENMASK_ULL(51, 13)
>  
> -bool snp_probe_rmptable_info(void)
> +static bool probe_contiguous_rmptable_info(void)
>  {
>  	u64 rmp_sz, rmp_base, rmp_end;
>  
> @@ -451,6 +588,60 @@ bool snp_probe_rmptable_info(void)
>  	return true;
>  }
>  
> +static bool probe_segmented_rmptable_info(void)
> +{
> +	unsigned int eax, ebx, segment_shift, segment_shift_min, segment_shift_max;
> +	u64 rmp_base, rmp_end;
> +
> +	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
> +	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
> +
> +	if (!(rmp_base & RMP_ADDR_MASK)) {
> +		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
> +		return false;
> +	}
> +
> +	WARN_ONCE(rmp_end & RMP_ADDR_MASK,
> +		  "Segmented RMP enabled but RMP_END MSR is non-zero\n");
> +
> +	/* Obtain the min and max supported RMP segment size */
> +	eax = cpuid_eax(0x80000025);
> +	segment_shift_min = eax & GENMASK(5, 0);
> +	segment_shift_max = (eax & GENMASK(11, 6)) >> 6;
> +
> +	/* Verify the segment size is within the supported limits */
> +	segment_shift = MSR_AMD64_RMP_SEGMENT_SHIFT(rmp_cfg);
> +	if (segment_shift > segment_shift_max || segment_shift < segment_shift_min) {
> +		pr_err("RMP segment size (%u) is not within advertised bounds (min=%u, max=%u)\n",
> +		       segment_shift, segment_shift_min, segment_shift_max);
> +		return false;
> +	}
> +
> +	/* Override the max supported RST index if a hardware limit exists */
> +	ebx = cpuid_ebx(0x80000025);
> +	if (ebx & BIT(10))
> +		rst_max_index = ebx & GENMASK(9, 0);
> +
> +	set_rmp_segment_info(segment_shift);
> +
> +	probed_rmp_base = rmp_base;
> +	probed_rmp_size = 0;
> +
> +	pr_info("RMP segment table physical address [0x%016llx - 0x%016llx]\n",
> +		rmp_base, rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ + RMP_SEGMENT_TABLE_SIZE);
> +
> +	return true;
> +}
> +
> +bool snp_probe_rmptable_info(void)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_SEGMENTED_RMP))
> +		rdmsrl(MSR_AMD64_RMP_CFG, rmp_cfg);
> +
> +	return RMP_IS_SEGMENTED(rmp_cfg) ? probe_segmented_rmptable_info()
> +					 : probe_contiguous_rmptable_info();
> +}
> +
>  static struct rmpentry_raw *__get_rmpentry(unsigned long pfn)
>  {
>  	struct rmp_segment_desc *desc;


