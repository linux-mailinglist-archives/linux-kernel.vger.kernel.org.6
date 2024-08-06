Return-Path: <linux-kernel+bounces-275780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07E69489B2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E901F2515E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DD515B11E;
	Tue,  6 Aug 2024 07:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ss0MNRK5"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020123.outbound.protection.outlook.com [52.101.61.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F13B663
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722927767; cv=fail; b=FiVCSlTzNm0jwrf+App9reuRP+QQ0owYRUFADt69Y/6YU365VZnnIqBiakIpmONbTTCwBkD2ibssMFUPg9ZZvk8FGWKxr2HqyjHhU54HnIisFImymJvLPdYYExwIfpMdLxKqlLdtqslLncXy52zKWlDzJgZEf7kjveNtjTOpl5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722927767; c=relaxed/simple;
	bh=WAd1O46UH8FzRZ0FXftSA76EW0PxQO12/I9b0uL7qRA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p9Qx/ixPEQvskBqLKEb99pp6QlGBratXh7yHhkn5ClQy7N3udzF2hxPLRkrzSKFSYASsGbhEy/buxfEvwol6SppGrPICtcoSvYGE2uuSWiHSCDQNi8q+ygFeyhAd29uDKH+pQKoiy0Lj3JiV8SzxsLa842YBtHVg7Np9G/NBnUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ss0MNRK5; arc=fail smtp.client-ip=52.101.61.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFKfsbE1IdKm0ZDhex0bQ5ChTTI9+ILemwSkrf99N82tkMV8+B4oD7FnAZ4gn0Hyhy0Ryr6798LW89Xit6O0bjflHWbyffBMz2LkIZXiwdr9e9hWiW4iJY14znQ0zUac+PR39S1MSoZHW+Qaqgv0uFFCSOhhxx15OtdOCqQQOvMB/6VxjzhV4SaIOYRNXmPWZy0RzqmZaY9vlU2/vBZ8HThz2nabc62vrMNWz5oUC5NvHSNXwXPEDEEzq2YEYHWQhPlWwP/oUoEQmBobWOlZdsbXNxEP1oLPZcGEbVxESyZmlyk+v0+0jIT6craEAA7og+ElsNFI+l1rizUCgf0mmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1xarYh6++5i3YE+F2QB4QsIPA8AcLhPUENIE1zvEic=;
 b=qgHpsLC+0Xk0kv13wTT3e4b58Snu6GXa/yoNJi3xbTyk8gryvzrWCzdM9PSK7BCPCpEld7sSavUI9ONqLVVFAXhsd8LLwR4CIsgloyoncNyjlisByc9VQW8Zx7JjpUJn6UtPkWFM5XX9hDKDDOBvoGgHaPmJYs48LaSyt9kIY0+NdIDONwtwxVTgMkjVACXbUKQE5yczadM8Mdru+5lW6MGjBook3GZT5bbxpK5W/M19khkN2Fhpm/pJNUjjMuFUDzZ8Psd+m6KGhOMcCg+sY0WQVw//5+dRTXMHvyLv6EUzHNgM+dkBdAviF5tCkcLP3rC/Y5uHRFu/oEoeFqcvCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1xarYh6++5i3YE+F2QB4QsIPA8AcLhPUENIE1zvEic=;
 b=ss0MNRK5MpfkI3S3FtZsb3kuHEedauQvbCnWl4PpX9CNbG7NweHL60mhopluY4vrmjVmPIsFwQZAeGiMV/b8mkgCNtnCifb90ZEUycKMp2hLRFz9qV+zbg/pkgsTYjrhwj2HgdaEsR7Jvq5XbC27nfZ34Hitt0p486gqjZCFpSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 CO1PR01MB6647.prod.exchangelabs.com (2603:10b6:303:f9::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.23; Tue, 6 Aug 2024 07:02:41 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%3]) with mapi id 15.20.7828.021; Tue, 6 Aug 2024
 07:02:40 +0000
Message-ID: <8b53a424-19f7-4042-a2db-e1c5d051f9cc@os.amperecomputing.com>
Date: Tue, 6 Aug 2024 12:32:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: James Clark <james.clark@linaro.org>
Cc: acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, scclevenger@os.amperecomputing.com,
 james.clark@arm.com, suzuki.poulose@arm.com, Leo Yan <leo.yan@arm.com>,
 Al.Grant@arm.com, Mike Leach <mike.leach@linaro.org>
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <7302367c-311f-4655-9a83-3c4034c50086@linaro.org>
 <6920de94-a9c8-47f4-840f-391d1ec85c0c@os.amperecomputing.com>
 <8f6f221b-4c9a-42e1-b8ce-1f492caee184@linaro.org>
 <0a697a54-5dd8-4351-a651-991724690db2@os.amperecomputing.com>
 <ce4af204-874f-404c-a7aa-42dc6693d072@linaro.org>
 <a197123a-be59-4052-9615-cac79ffa357a@os.amperecomputing.com>
 <543813f6-cb1f-4759-b26f-75246750814d@linaro.org>
 <f72038a0-c6b5-4245-8515-3b735ca38cbb@linaro.org>
 <ae1b2d8c-588a-4f0a-b3c9-c869f8dd0f25@os.amperecomputing.com>
 <00fac24c-d664-4ebb-8c60-f4697b7f76c1@linaro.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <00fac24c-d664-4ebb-8c60-f4697b7f76c1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::20) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|CO1PR01MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b3f98c-5274-48f1-758f-08dcb5e5c2da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejljd2g1anVGYnpSaW95dmZyNUQ5bEw1UGlSZjBqbzBEYzBSS2lVb3AwU1NG?=
 =?utf-8?B?bHFHdHVmV1oxMEs3MGNuOHk1cVlaeTM3ajkvRkZRaUl1VnJreFNEUTJyTU5j?=
 =?utf-8?B?c1c1V25WcTRsOUM5ZGJDSVJpYXJ0N1FyQlZheCtyZ0tTNGkvZUtCTTBQbjdi?=
 =?utf-8?B?Mk1DUzliZlpxM1dteUNiRjRFNnVSYXFXZjNCUjgyb3M1LzY3bXBHVDFzZzhn?=
 =?utf-8?B?SjN3bWwyQTBUQllMSGhSN2U3eWlwVGJ1a2dGeU5oNC9NQ0QxT1hiVGp6anFi?=
 =?utf-8?B?cUpmclY0R05ydVY0NjhuaktkSmN0aWVJK3R4alowbFd2MFUwUUc1eGZQY3Zp?=
 =?utf-8?B?eEhNVzJ2cnlYdDBKdXE1Yjc5OG9FWXN0bExzamVJdFhWUXF6ek42WmpQV2N5?=
 =?utf-8?B?aENPRThlQWw0Uk13N3NPL0dyZ3NXUGVUcldScE9Za1I3SEdRTjZrZ0dSc3dv?=
 =?utf-8?B?djlncnhlOFkyR0hQeUVrVitzUlJYUkJFYUFpQ2tncWN1SXd0K1JZcjRyK1Rt?=
 =?utf-8?B?NXlIT1N6VDlWT200Q2tMTmFkeDJhdUtwS2hGdGlnYVlyOTNkV3Rsd2NqN1d5?=
 =?utf-8?B?aE5LVmdKdFVuTU9kampEN0RCMG9TOGxXb001aWVYODBXc2ZDSzZldnlKZlFa?=
 =?utf-8?B?ZU5Kc3RVMExEZ3VYZit3NUdackpZUHExbjhzeVBJSk9NTUpYUnQvbDM0WGh6?=
 =?utf-8?B?cmd5YWlQQmZtenBnWHM4M3JBMUN0anpwRXBrdEF2YnZiSlhxQmhVai9yYkdk?=
 =?utf-8?B?SHVOQzdlSVM3TzcxaGM2SGhPNnhOeWRjc2FmNXNWNUpld2l0REtjemgzdkN4?=
 =?utf-8?B?aFlrd3FlN2lwbkhtdUVpdk9oREdrbEdYaDZaajJPV0lmWUlsRmpVU1o3T3Fv?=
 =?utf-8?B?cDFXZWFPY0lDRlpxSCtkU2xvWVVvMHowM3BNTnBjRk10MlNqSlI1NGJ2d0Zi?=
 =?utf-8?B?cGxlbXZqbVREdVdtYXpXdTBiZXVVcXBXTjNXVWVNd0VsclpZNFQ1ZlpNVVJ5?=
 =?utf-8?B?YVI4V2lZRkF0QUtvb1pBU3V1V2kra3NNakkwc0ExaWIwZko5c1FpSG4rUitZ?=
 =?utf-8?B?SG1STitOdkVhVXpmUUxjOXMrbFhRMi9xSDFtWkticjEyVGhMQWk2d2xHVXlw?=
 =?utf-8?B?L1VBVnBOSjZnNVQ0YlJDUXY0SE0rTXQyUXZEWkN2NHdlR2p2WEoyWWtWZDcr?=
 =?utf-8?B?K2pFN2pwR0xGY1pHNmdtbmg3RGVyTU1wbEIxSlFVbUdUNms0QnRQZ0hZSnF4?=
 =?utf-8?B?bFRjM3FQOVBGQUdjZjFteGVkNk9GVEd2bVAyUEtQZU9RODFzSTdqanVsZ0dh?=
 =?utf-8?B?YTd3NHBSdUJ0K0FLdDFxT1hWSUZZMGE2bEh5M0VHSW5FOFIzV2YzeFhSSm9T?=
 =?utf-8?B?b1FKOTNMdFN2OUR4UHV1eHhLOTI3d28vYjg5TGhyWmtyTW56aGdJeUlVdGVw?=
 =?utf-8?B?c00yZDU3Z09WeXlXRmwyWGFaRC9CaXlBQUhvOHp2NU92dFhxT24vbVFDWThj?=
 =?utf-8?B?WGpIZXJUWURJRjgzSGNzS1BSS3hhTkRGc2NWQVJmbnE2aHJ6MnZxams5MWVV?=
 =?utf-8?B?c3ErVHhoVXFyU1ozR29Gd3hVSjduT1JQWm9uNzhMbnhOMFZrdGZVcGl2dDJZ?=
 =?utf-8?B?dGhFa0FWdjlFcnd4YVRheDN1TDFwVVI0RjdPUkZMSHMxNlhJOC9hczR6dWY0?=
 =?utf-8?B?Y081YlVoOG1CWUk2aUdtVFRTRW5IV0NzdGc4MHVrOW5JbTVhMjYrUmU0T0xj?=
 =?utf-8?B?WmN5VUx5bjZGVEhsTndDTi9JQ0dIV21YUkluZHIwS2loRTNISHloZXRUTnpk?=
 =?utf-8?B?dzY2TDQ5dEhiak42Uy9hdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjZKdnRielpmMk5LSnpZYzJ5dTc4eERHMHdrNFkxZ0FNQVNXK1puTzZsYitV?=
 =?utf-8?B?c0h5RnlEMDBKM3FxRWlqRlBMRU5FYlVBcE1lb0k5SFdWODVMOVp3NFNXYmdH?=
 =?utf-8?B?V01kNWp2TUtQSGd0S3RBU3NTVXBEYzlNWFFKWnZ1ek9Ra01DVTFlbjBvRE0x?=
 =?utf-8?B?YWNQWlFsNUlZN2RWQzc2ODNiV0wwVUxtaDFGUFJMMEQ4UjUxUmpwVFBxNmlB?=
 =?utf-8?B?ZW92b0dZNk0zQ21SQlgvQXlQNGhGUnVITXBRcnhKYlVDaXZXRDM1MUtVNjJI?=
 =?utf-8?B?QXRiQmpITjNXL3FrdHdaVGh6TGdNTm5QYXJ5NkxraERBakNnRU9ZY09WdkQy?=
 =?utf-8?B?U3J2Uzc2WUZIRHd4d3dGL0pLN0N2eXk1djZITUxmamEybGhPRURmZ20wUDc3?=
 =?utf-8?B?WmZYbVdVd3pweDJFdmdsMjBObHEvWldDQ3h2MnVveEVLcEYrTzlSYUdYcGRw?=
 =?utf-8?B?M1Vxd01EQWFCU3VTOG9rMDZlVEZTSkxnVFVuaHVvRGlLR2NlWUhvRU9lVkF1?=
 =?utf-8?B?cW9VY1NkUzlTclRZSzcrUGtxRFN0MHVEbVl6K09POURxSVFKQnI2OElxMlJn?=
 =?utf-8?B?dTdFLzBkM2hLNjN5VkxMSHhha1YyUE43RmZsWmk1Y1lLWkpJS1NsekRoWkY4?=
 =?utf-8?B?dTdvOUwrb1E3c01hYzZXVmtLMGM4QjhEaXIxYUlHNjRhTnZacUJMYzhRM1lS?=
 =?utf-8?B?TjBtVUJ3UWFXY3Z5aU94ejQreU9mS2dFdEdCWk9hKzhYSjlPYWwzOVY5MS9k?=
 =?utf-8?B?SEd6ZUxPbWUxSHQ3YlA3WmNLWWpOaEp4bngrbzBOZndxNEQrZjJOcHV3eHcz?=
 =?utf-8?B?b2VtYmY2bitmWnVIV2FaMVErb1R6QTNZZE54a0RnK0xJY2hkQVdwTWhvWURC?=
 =?utf-8?B?UFI4NjZyWVlLb0RHVnRSaC91dzZ4ZUluTUFaUFpGRHRCNHJFZDE4RjN0a3RO?=
 =?utf-8?B?UHJEemtFd2M1Z1RPMEtQaDZmY0JzQStGcnQ2YmdkbTNHUFBXcXNHSkJRQm1T?=
 =?utf-8?B?eWdyN1MwUllNdHBHZEJQUjNQT3FBYmtvSnBlYjlGc3RodXZmbHlDek9aWlMy?=
 =?utf-8?B?WGlhRXVlaTFHcHVtWmZ4QWJVMC9FRTl0WjJjMmxIQ1dKN0JFVC9uK2VURjZp?=
 =?utf-8?B?SWRkcmN5Qm1ZMHNoVm4vUXlzK2tKTEdZU0ozWDJFUFUvaFY1STBBS1lBMjkr?=
 =?utf-8?B?TWQxSiswbXJzS1l1OXJQVTM5dk5NKzBTcjlkeWM2RFRxWE8xQnBDdFRkUGlk?=
 =?utf-8?B?MmhiNURoMmFUay9TZ3haVFNVQloyUzg0RWpsNGUyc1lqSnlEcEVMb3hIVDdS?=
 =?utf-8?B?WGhDWUFJemFRWEhzdUhPRXJ3WnI3Wll6cGl4c0xydldRMmJrUlljWDVYVEFH?=
 =?utf-8?B?a0hMYUNYc0pqbWxqK3lCMnd5Zm0yUXF0S29BY1VKODA2cXEzTVczK2ViaVJv?=
 =?utf-8?B?aTU3TVAzZ2JIWU13bHA3ai9aVFlUSG9DZE9QUmV2Zko2dFNNc1pwL2xvUE0x?=
 =?utf-8?B?ZllxbURlbXRsOTRmZEh5WTRuTW5SRWROUnNCSnRQUkxlTzdsNmdCK29odEw2?=
 =?utf-8?B?ZEY5cmxSak04YnVucDBXK2tWRWZOL0NvNWpTUTU5bWdacnpYYi8weThuUE8r?=
 =?utf-8?B?Y2lWTTFPT0pwSHl3K0FvT01PT0c0MkphWXdsMFdaVTZVZWZtQy8wcFZnSVps?=
 =?utf-8?B?aVU1cThqeGRoR1h5M083bEN2ZHdIREFobXVNdzdEV09zR2MrZTZaVm5wU3JB?=
 =?utf-8?B?N1p6RnNUVWxrVmJybDhEWWduR0FTRXVUQ3Vxc29XN0thK0FvUVNaNFh2TTFx?=
 =?utf-8?B?aTJNUkRRMHE0b2xwYVlVSDVhQ1NsZSs5ZmZIbmkwMnRmaHltd0VaTyt4a2Zq?=
 =?utf-8?B?M242UEZzUWFpODNnOVpEcWU2UzI4RlFEOTFoZmZXMFRxckNNTnVmU3kzQUlx?=
 =?utf-8?B?ckRGcDFLdkV4YzR3TG1xR3VCTUVJVEsxQWZBZjY3U2pZSHY0MnNyck5Mb3BX?=
 =?utf-8?B?aUxQbWNaVlVySm8vSjA5Si8wdjd6TjB5QUhjYXZxQUUrM2pPTXpXY1c4V2RN?=
 =?utf-8?B?UUROWTQwTEw3VHcwZTF0bW81OWFQeWpRTlQxREs2SWlobk1wYjdKSS9JdTE4?=
 =?utf-8?B?dlhobzVvQWR3QVJnZmsyakFRUXROYm1QemFuUmxGeGh0dEJqTko3dlg4WDZP?=
 =?utf-8?Q?is1la9XBdX4VuuQnUdz6OSs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b3f98c-5274-48f1-758f-08dcb5e5c2da
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 07:02:40.4071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Do2goZwPc6KvU1NJfnNJ32waiODFsJHzkxCCNFgpnjPzjft0KmYF5vwyDRywWXRW4Ytw725vg5/X6oHgLMOuV9GaD4jopNWdi4rviccwO0dfKp7fU2tDTpmu9akweki
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6647



On 05-08-2024 07:29 pm, James Clark wrote:
> 
> 
> On 05/08/2024 1:22 pm, Ganapatrao Kulkarni wrote:
>>
>>
>> On 01-08-2024 03:30 pm, James Clark wrote:
>>>
>>>
>>> On 24/07/2024 3:45 pm, James Clark wrote:
>>>>
>>>>
>>>> On 24/07/2024 7:38 am, Ganapatrao Kulkarni wrote:
>>>>>
>>>>>
>>>>> On 23-07-2024 09:16 pm, James Clark wrote:
>>>>>>
>>>>>>
>>>>>> On 23/07/2024 4:26 pm, Ganapatrao Kulkarni wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 23-07-2024 06:40 pm, James Clark wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 22/07/2024 11:02 am, Ganapatrao Kulkarni wrote:
>>>>>>>>>
>>>>>>>>> Hi James,
>>>>>>>>>
>>>>>>>>> On 19-07-2024 08:09 pm, James Clark wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 19/07/2024 10:26 am, Ganapatrao Kulkarni wrote:
>>>>>>>>>>> To generate the instruction tracing, script uses 2 contiguous 
>>>>>>>>>>> packets
>>>>>>>>>>> address range. If there a continuity brake due to 
>>>>>>>>>>> discontiguous branch
>>>>>>>>>>> address, it is required to reset the tracing and start 
>>>>>>>>>>> tracing with the
>>>>>>>>>>> new set of contiguous packets.
>>>>>>>>>>>
>>>>>>>>>>> Adding change to identify the break and complete the 
>>>>>>>>>>> remaining tracing
>>>>>>>>>>> of current packets and restart tracing from new set of 
>>>>>>>>>>> packets, if
>>>>>>>>>>> continuity is established.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Hi Ganapatrao,
>>>>>>>>>>
>>>>>>>>>> Can you add a before and after example of what's changed to 
>>>>>>>>>> the commit message? It wasn't immediately obvious to me if 
>>>>>>>>>> this is adding missing output, or it was correcting the tail 
>>>>>>>>>> end of the output that was previously wrong.
>>>>>>>>>
>>>>>>>>> It is adding tail end of the trace as well avoiding the 
>>>>>>>>> segfault of the perf application. With out this change the perf 
>>>>>>>>> segfaults with as below log
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> ./perf script 
>>>>>>>>> --script=python:./scripts/python/arm-cs-trace-disasm.py -- -d 
>>>>>>>>> objdump -k ../../vmlinux -v $* > dump
>>>>>>>>> objdump: error: the stop address should be after the start address
>>>>>>>>> Traceback (most recent call last):
>>>>>>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 271, in 
>>>>>>>>> process_event
>>>>>>>>>      print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
>>>>>>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 105, in 
>>>>>>>>> print_disam
>>>>>>>>>      for line in read_disam(dso_fname, dso_start, start_addr, 
>>>>>>>>> stop_addr):
>>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 99, in 
>>>>>>>>> read_disam
>>>>>>>>>      disasm_output = 
>>>>>>>>> check_output(disasm).decode('utf-8').split('\n')
>>>>>>>>>                      ^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>    File "/usr/lib64/python3.12/subprocess.py", line 466, in 
>>>>>>>>> check_output
>>>>>>>>>      return run(*popenargs, stdout=PIPE, timeout=timeout, 
>>>>>>>>> check=True,
>>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>    File "/usr/lib64/python3.12/subprocess.py", line 571, in run
>>>>>>>>>      raise CalledProcessError(retcode, process.args,
>>>>>>>>> subprocess.CalledProcessError: Command '['objdump', '-d', '-z', 
>>>>>>>>> '--start-address=0xffff80008125b758', 
>>>>>>>>> '--stop-address=0xffff80008125a934', '../../vmlinux']' returned 
>>>>>>>>> non-zero exit status 1.
>>>>>>>>> Fatal Python error: handler_call_die: problem in Python trace 
>>>>>>>>> event handler
>>>>>>>>> Python runtime state: initialized
>>>>>>>>>
>>>>>>>>> Current thread 0x0000ffffb05054e0 (most recent call first):
>>>>>>>>>    <no Python frame>
>>>>>>>>>
>>>>>>>>> Extension modules: perf_trace_context, systemd._journal, 
>>>>>>>>> systemd._reader, systemd.id128, report._py3report, 
>>>>>>>>> _dbus_bindings, problem._py3abrt (total: 7)
>>>>>>>>> Aborted (core dumped)
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Ganapatrao Kulkarni 
>>>>>>>>>>> <gankulkarni@os.amperecomputing.com>
>>>>>>>>>>> ---
>>>>>>>>>>>   tools/perf/scripts/python/arm-cs-trace-disasm.py | 10 
>>>>>>>>>>> ++++++++++
>>>>>>>>>>>   1 file changed, 10 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py 
>>>>>>>>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>> index d973c2baed1c..ad10cee2c35e 100755
>>>>>>>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>> @@ -198,6 +198,10 @@ def process_event(param_dict):
>>>>>>>>>>>           cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>>>>           return
>>>>>>>>>>> +    if (cpu_data.get(str(cpu) + 'ip') == None):
>>>>>>>>>>> +        cpu_data[str(cpu) + 'ip'] = ip
>>>>>>>>>>> +
>>>>>>>>>>
>>>>>>>>>> Do you need to write into the global cpu_data here? Doesn't it 
>>>>>>>>>> get overwritten after you load it back into 'prev_ip'
>>>>>>>>>
>>>>>>>>> No, the logic is same as holding the addr of previous packet.
>>>>>>>>> Saving the previous packet saved ip in to prev_ip before 
>>>>>>>>> overwriting with the current packet.
>>>>>>>>
>>>>>>>> It's not exactly the same logic as holding the addr of the 
>>>>>>>> previous sample. For addr, we return on the first None, with 
>>>>>>>> your change we now "pretend" that the second one is also the 
>>>>>>>> previous one:
>>>>>>>>
>>>>>>>>    if (cpu_data.get(str(cpu) + 'addr') == None):
>>>>>>>>      cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>      return  <----------------------------sample 0 return
>>>>>>>>
>>>>>>>>    if (cpu_data.get(str(cpu) + 'ip') == None):
>>>>>>>>        cpu_data[str(cpu) + 'ip'] = ip <---- sample 1 save but no 
>>>>>>>> return
>>>>>>>>
>>>>>>>> Then for sample 1 'prev_ip' is actually now the 'current' IP:
>>>>>>>
>>>>>>> Yes, it is dummy for first packet. Added anticipating that we 
>>>>>>> wont hit the discontinuity for the first packet itself.
>>>>>>>
>>>>>>> Can this be changed to more intuitive like below?
>>>>>>>
>>>>>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py 
>>>>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>> index d973c2baed1c..d49f5090059f 100755
>>>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>> @@ -198,6 +198,8 @@ def process_event(param_dict):
>>>>>>>                  cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>                  return
>>>>>>>
>>>>>>> +       if (cpu_data.get(str(cpu) + 'ip') != None):
>>>>>>> +               prev_ip = cpu_data[str(cpu) + 'ip']
>>>>>>>
>>>>>>>          if (options.verbose == True):
>>>>>>>                  print("Event type: %s" % name)
>>>>>>> @@ -243,12 +245,18 @@ def process_event(param_dict):
>>>>>>>
>>>>>>>          # Record for previous sample packet
>>>>>>>          cpu_data[str(cpu) + 'addr'] = addr
>>>>>>> +       cpu_data[str(cpu) + 'ip'] = stop_addr
>>>>>>>
>>>>>>>          # Handle CS_ETM_TRACE_ON packet if start_addr=0 and 
>>>>>>> stop_addr=4
>>>>>>>          if (start_addr == 0 and stop_addr == 4):
>>>>>>>                  print("CPU%d: CS_ETM_TRACE_ON packet is 
>>>>>>> inserted" % cpu)
>>>>>>>                  return
>>>>>>>
>>>>>>> +       if (stop_addr < start_addr and prev_ip != 0):
>>>>>>> +               # Continuity of the Packets broken, set 
>>>>>>> start_addr to previous
>>>>>>> +               # packet ip to complete the remaining tracing of 
>>>>>>> the address range.
>>>>>>> +               start_addr = prev_ip
>>>>>>> +
>>>>>>>          if (start_addr < int(dso_start) or start_addr > 
>>>>>>> int(dso_end)):
>>>>>>>                  print("Start address 0x%x is out of range [ 0x%x 
>>>>>>> .. 0x%x ] for dso %s" % (start_addr, int(dso_start), 
>>>>>>> int(dso_end), dso))
>>>>>>>                  return
>>>>>>>
>>>>>>> Without this patch below is the failure log(with segfault) for 
>>>>>>> reference.
>>>>>>>
>>>>>>> [root@sut01sys-r214 perf]# timeout 4s ./perf record -e cs_etm// 
>>>>>>> -C 1 dd if=/dev/zero of=/dev/null
>>>>>>> [ perf record: Woken up 1 times to write data ]
>>>>>>> [ perf record: Captured and wrote 1.087 MB perf.data ]
>>>>>>> [root@sut01sys-r214 perf]# ./perf script 
>>>>>>> --script=python:./scripts/python/arm-cs-trace-disasm.py -- -d 
>>>>>>> objdump -k ../../vmlinux -v $* > dump
>>>>>>> objdump: error: the stop address should be after the start address
>>>>>>> Traceback (most recent call last):
>>>>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 271, in 
>>>>>>> process_event
>>>>>>>      print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
>>>>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 105, in 
>>>>>>> print_disam
>>>>>>>      for line in read_disam(dso_fname, dso_start, start_addr, 
>>>>>>> stop_addr):
>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 99, in 
>>>>>>> read_disam
>>>>>>>      disasm_output = 
>>>>>>> check_output(disasm).decode('utf-8').split('\n')
>>>>>>>                      ^^^^^^^^^^^^^^^^^^^^
>>>>>>>    File "/usr/lib64/python3.12/subprocess.py", line 466, in 
>>>>>>> check_output
>>>>>>>      return run(*popenargs, stdout=PIPE, timeout=timeout, 
>>>>>>> check=True,
>>>>>>>             
>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>    File "/usr/lib64/python3.12/subprocess.py", line 571, in run
>>>>>>>      raise CalledProcessError(retcode, process.args,
>>>>>>> subprocess.CalledProcessError: Command '['objdump', '-d', '-z', 
>>>>>>> '--start-address=0xffff80008125b758', 
>>>>>>> '--stop-address=0xffff80008125a934', '../../vmlinux']' returned 
>>>>>>> non-zero exit status 1.
>>>>>>> Fatal Python error: handler_call_die: problem in Python trace 
>>>>>>> event handler
>>>>>>> Python runtime state: initialized
>>>>>>>
>>>>>>> Current thread 0x0000ffffb90d54e0 (most recent call first):
>>>>>>>    <no Python frame>
>>>>>>>
>>>>>>> Extension modules: perf_trace_context, systemd._journal, 
>>>>>>> systemd._reader, systemd.id128, report._py3report, 
>>>>>>> _dbus_bindings, problem._py3abrt (total: 7)
>>>>>>> Aborted (core dumped)
>>>>>>>
>>>>>>>
>>>>>>> dump snippet:
>>>>>>> ============
>>>>>>> Event type: branches
>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr: 
>>>>>>> 0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid: 12720 
>>>>>>> period: 1 time: 5986372298040 }
>>>>>>>          ffff800080313f04 <__perf_event_header__init_id+0x4c>:
>>>>>>>          ffff800080313f04:       36100094        tbz     w20, #2, 
>>>>>>> ffff800080313f14 <__perf_event_header__init_id+0x5c>
>>>>>>>          ffff800080313f08:       f941e6a0        ldr     x0, 
>>>>>>> [x21, #968]
>>>>>>>          ffff800080313f0c:       d63f0000        blr     x0
>>>>>>>              perf 12720/12720 [0001]      5986.372298040 
>>>>>>> __perf_event_header__init_id+0x54 
>>>>>>> .../coresight/linux/kernel/events/core.c  586         return 
>>>>>>> event->clock();
>>>>>>> Event type: branches
>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr: 
>>>>>>> 0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid: 12720 
>>>>>>> period: 1 time: 5986372298040 }
>>>>>>>          ffff80008030cb00 <local_clock>:
>>>>>>>          ffff80008030cb00:       d503233f        paciasp
>>>>>>>          ffff80008030cb04:       a9bf7bfd        stp     x29, 
>>>>>>> x30, [sp, #-16]!
>>>>>>>          ffff80008030cb08:       910003fd        mov     x29, sp
>>>>>>>          ffff80008030cb0c:       97faba67        bl 
>>>>>>> ffff8000801bb4a8 <sched_clock>
>>>>>>>              perf 12720/12720 [0001]      5986.372298040 
>>>>>>> local_clock+0xc ...t/linux/./include/linux/sched/clock.h   64 
>>>>>>> return sched_clock();
>>>>>>> Event type: branches
>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr: 
>>>>>>> 0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid: 12720 
>>>>>>> period: 1 time: 5986372298040 }
>>>>>>>          ffff8000801bb4a8 <sched_clock>:
>>>>>>>          ffff8000801bb4a8:       d503233f        paciasp
>>>>>>>          ffff8000801bb4ac:       a9be7bfd        stp     x29, 
>>>>>>> x30, [sp, #-32]!
>>>>>>>          ffff8000801bb4b0:       910003fd        mov     x29, sp
>>>>>>>          ffff8000801bb4b4:       a90153f3        stp     x19, 
>>>>>>> x20, [sp, #16]
>>>>>>>          ffff8000801bb4b8:       d5384113        mrs     x19, sp_el0
>>>>>>>          ffff8000801bb4bc:       b9401260        ldr     w0, 
>>>>>>> [x19, #16]
>>>>>>>          ffff8000801bb4c0:       11000400        add     w0, w0, 
>>>>>>> #0x1
>>>>>>>          ffff8000801bb4c4:       b9001260        str     w0, 
>>>>>>> [x19, #16]
>>>>>>>          ffff8000801bb4c8:       94427cf8        bl 
>>>>>>> ffff80008125a8a8 <sched_clock_noinstr>
>>>>>>>              perf 12720/12720 [0001]      5986.372298040 
>>>>>>> sched_clock+0x20 ...sight/linux/kernel/time/sched_clock.c  105 ns 
>>>>>>> = sched_clock_noinstr();
>>>>>>> Event type: branches
>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr: 
>>>>>>> 0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid: 12720 
>>>>>>> period: 1 time: 5986372298040 }
>>>>>>>          ffff80008125a8a8 <sched_clock_noinstr>:
>>>>>>>          ffff80008125a8a8:       d503233f        paciasp
>>>>>>>          ffff80008125a8ac:       a9bc7bfd        stp     x29, 
>>>>>>> x30, [sp, #-64]!
>>>>>>>          ffff80008125a8b0:       910003fd        mov     x29, sp
>>>>>>>          ffff80008125a8b4:       a90153f3        stp     x19, 
>>>>>>> x20, [sp, #16]
>>>>>>>          ffff80008125a8b8:       b000e354        adrp    x20, 
>>>>>>> ffff800082ec3000 <tick_bc_dev+0x140>
>>>>>>>          ffff80008125a8bc:       910d0294        add     x20, 
>>>>>>> x20, #0x340
>>>>>>>          ffff80008125a8c0:       a90363f7        stp     x23, 
>>>>>>> x24, [sp, #48]
>>>>>>>          ffff80008125a8c4:       91002297        add     x23, 
>>>>>>> x20, #0x8
>>>>>>>          ffff80008125a8c8:       52800518        mov     w24, 
>>>>>>> #0x28                  // #40
>>>>>>>          ffff80008125a8cc:       a9025bf5        stp     x21, 
>>>>>>> x22, [sp, #32]
>>>>>>>          ffff80008125a8d0:       b9400296        ldr     w22, [x20]
>>>>>>>          ffff80008125a8d4:       120002d5        and     w21, 
>>>>>>> w22, #0x1
>>>>>>>          ffff80008125a8d8:       9bb87eb5        umull   x21, 
>>>>>>> w21, w24
>>>>>>>          ffff80008125a8dc:       8b1502f3        add     x19, 
>>>>>>> x23, x21
>>>>>>>          ffff80008125a8e0:       f9400e60        ldr     x0, 
>>>>>>> [x19, #24]
>>>>>>>          ffff80008125a8e4:       d63f0000        blr     x0
>>>>>>>              perf 12720/12720 [0001]      5986.372298040 
>>>>>>> sched_clock_noinstr+0x3c ...sight/linux/kernel/time/sched_clock.c 
>>>>>>> 93                 cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
>>>>>>> Event type: branches
>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr: 
>>>>>>> 0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid: 12720 
>>>>>>> period: 1 time: 5986372298040 }
>>>>>>>
>>>>>>>
>>>>>>> With fix:
>>>>>>> =========
>>>>>>>
>>>>>>> Event type: branches
>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr: 
>>>>>>> 0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid: 12720 
>>>>>>> period: 1 time: 5986372298040 }
>>>>>>>          ffff800080313f04 <__perf_event_header__init_id+0x4c>:
>>>>>>>          ffff800080313f04:       36100094        tbz     w20, #2, 
>>>>>>> ffff800080313f14 <__perf_event_header__init_id+0x5c>
>>>>>>>          ffff800080313f08:       f941e6a0        ldr     x0, 
>>>>>>> [x21, #968]
>>>>>>>          ffff800080313f0c:       d63f0000        blr     x0
>>>>>>>              perf 12720/12720 [0001]      5986.372298040 
>>>>>>> __perf_event_header__init_id+0x54 
>>>>>>> .../coresight/linux/kernel/events/core.c  586         return 
>>>>>>> event->clock();
>>>>>>> Event type: branches
>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr: 
>>>>>>> 0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid: 12720 
>>>>>>> period: 1 time: 5986372298040 }
>>>>>>>          ffff80008030cb00 <local_clock>:
>>>>>>>          ffff80008030cb00:       d503233f        paciasp
>>>>>>>          ffff80008030cb04:       a9bf7bfd        stp     x29, 
>>>>>>> x30, [sp, #-16]!
>>>>>>>          ffff80008030cb08:       910003fd        mov     x29, sp
>>>>>>>          ffff80008030cb0c:       97faba67        bl 
>>>>>>> ffff8000801bb4a8 <sched_clock>
>>>>>>>              perf 12720/12720 [0001]      5986.372298040 
>>>>>>> local_clock+0xc ...t/linux/./include/linux/sched/clock.h   64 
>>>>>>> return sched_clock();
>>>>>>> Event type: branches
>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr: 
>>>>>>> 0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid: 12720 
>>>>>>> period: 1 time: 5986372298040 }
>>>>>>>          ffff8000801bb4a8 <sched_clock>:
>>>>>>>          ffff8000801bb4a8:       d503233f        paciasp
>>>>>>>          ffff8000801bb4ac:       a9be7bfd        stp     x29, 
>>>>>>> x30, [sp, #-32]!
>>>>>>>          ffff8000801bb4b0:       910003fd        mov     x29, sp
>>>>>>>          ffff8000801bb4b4:       a90153f3        stp     x19, 
>>>>>>> x20, [sp, #16]
>>>>>>>          ffff8000801bb4b8:       d5384113        mrs     x19, sp_el0
>>>>>>>          ffff8000801bb4bc:       b9401260        ldr     w0, 
>>>>>>> [x19, #16]
>>>>>>>          ffff8000801bb4c0:       11000400        add     w0, w0, 
>>>>>>> #0x1
>>>>>>>          ffff8000801bb4c4:       b9001260        str     w0, 
>>>>>>> [x19, #16]
>>>>>>>          ffff8000801bb4c8:       94427cf8        bl 
>>>>>>> ffff80008125a8a8 <sched_clock_noinstr>
>>>>>>>              perf 12720/12720 [0001]      5986.372298040 
>>>>>>> sched_clock+0x20 ...sight/linux/kernel/time/sched_clock.c  105 ns 
>>>>>>> = sched_clock_noinstr();
>>>>>>> Event type: branches
>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr: 
>>>>>>> 0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid: 12720 
>>>>>>> period: 1 time: 5986372298040 }
>>>>>>>          ffff80008125a8a8 <sched_clock_noinstr>:
>>>>>>>          ffff80008125a8a8:       d503233f        paciasp
>>>>>>>          ffff80008125a8ac:       a9bc7bfd        stp     x29, 
>>>>>>> x30, [sp, #-64]!
>>>>>>>          ffff80008125a8b0:       910003fd        mov     x29, sp
>>>>>>>          ffff80008125a8b4:       a90153f3        stp     x19, 
>>>>>>> x20, [sp, #16]
>>>>>>>          ffff80008125a8b8:       b000e354        adrp    x20, 
>>>>>>> ffff800082ec3000 <tick_bc_dev+0x140>
>>>>>>>          ffff80008125a8bc:       910d0294        add     x20, 
>>>>>>> x20, #0x340
>>>>>>>          ffff80008125a8c0:       a90363f7        stp     x23, 
>>>>>>> x24, [sp, #48]
>>>>>>>          ffff80008125a8c4:       91002297        add     x23, 
>>>>>>> x20, #0x8
>>>>>>>          ffff80008125a8c8:       52800518        mov     w24, 
>>>>>>> #0x28                  // #40
>>>>>>>          ffff80008125a8cc:       a9025bf5        stp     x21, 
>>>>>>> x22, [sp, #32]
>>>>>>>          ffff80008125a8d0:       b9400296        ldr     w22, [x20]
>>>>>>>          ffff80008125a8d4:       120002d5        and     w21, 
>>>>>>> w22, #0x1
>>>>>>>          ffff80008125a8d8:       9bb87eb5        umull   x21, 
>>>>>>> w21, w24
>>>>>>>          ffff80008125a8dc:       8b1502f3        add     x19, 
>>>>>>> x23, x21
>>>>>>>          ffff80008125a8e0:       f9400e60        ldr     x0, 
>>>>>>> [x19, #24]
>>>>>>>          ffff80008125a8e4:       d63f0000        blr     x0
>>>>>>
>>>>>> It looks like the disassembly now assumes this BLR wasn't taken. 
>>>>>> We go from ffff80008125a8e4 straight through to ...
>>>>>>
>>>>>>>              perf 12720/12720 [0001]      5986.372298040 
>>>>>>> sched_clock_noinstr+0x3c ...sight/linux/kernel/time/sched_clock.c 
>>>>>>> 93                 cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
>>>>>>> Event type: branches
>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr: 
>>>>>>> 0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid: 12720 
>>>>>>> period: 1 time: 5986372298040 }
>>>>>>>          ffff80008125a8e8 <sched_clock_noinstr+0x40>:
>>>>>>>          ffff80008125a8e8:       f8756ae3        ldr     x3, 
>>>>>>> [x23, x21]
>>>>>>
>>>>>> ffff80008125a8e4 which is just the previous one +4. Isn't your 
>>>>>> issue actually a decode issue in Perf itself? Why is there a 
>>>>>> discontinuity without branch samples being generated where either 
>>>>>> the source or destination address is 0?
>>>>>>
>>>>>> What are your record options to create this issue? As I mentioned 
>>>>>> in the previous reply I haven't been able to reproduce it.
>>>>>
>>>>> I am using below perf record command.
>>>>>
>>>>> timeout 4s ./perf record -e cs_etm// -C 1 dd if=/dev/zero of=/dev/null
>>>>>
>>>>
>>>> Thanks I managed to reproduce it. I'll take a look to see if I think 
>>>> the issue is somewhere else.
>>>>
>>>
>>> At least for the failures I encountered, the issue is due to the 
>>> alternatives runtime instruction patching mechanism. vmlinux ends up 
>>> being the wrong image to decode with because a load of branches are 
>>> actually turned into nops.
>>>
>>> Can you confirm if you use --kcore instead of vmlinux that you still 
>>> get failures:
>>>
>>>    sudo perf record -e cs_etm// -C 1 --kcore -o <output-folder.data> 
>>> -- \
>>>      dd if=/dev/zero of=/dev/null
>>>
>>>     perf script -i <output-folder.data> \
>>>      tools/perf/scripts/python/arm-cs-trace-disasm.py -d llvm-objdump \
>>>      -k <output-folder.data>/kcore_dir/kcore
>>>
>>
>> With below command combination with kcore also the issue is seen, as 
>> reported in this email chain.
>>
>> timeout 8s ./perf record -e cs_etm// -C 1 --kcore -o kcore \
>> dd if=/dev/zero of=/dev/null
>>
>> ./perf script -i kcore/data \
>> --script=python:./scripts/python/arm-cs-trace-disasm.py -- \
>> -d objdump -k kcore/kcore_dir/kcore
>>
>>
>> However, with below sequence(same as your command) the issue is *not* 
>> seen.
>>
>> timeout 8s ./perf record -e cs_etm// -C 1 --kcore -o kcore \
>> dd if=/dev/zero of=/dev/null
>>
>> ./perf script -i kcore/data ./scripts/python/arm-cs-trace-disasm.py \
>> -- -d objdump -k kcore/kcore_dir/kcore
>>
>> Do you see any issue with the command, which is showing the problem?
>> Also the output log produced by these both commands is different.
>>
> 
> Double check the command I gave. "-i" needs to be the same as "-o" (it's 
> the folder, not the data file). I think this could be causing your 
> issue. Unless you give it the folder it doesn't open kcore along with 
> the data file.
> 

As per 'perf script --help'

        -i, --input=
            Input file name. (default: perf.data unless stdin is a fifo)

Also tried just giving dir as you suggested and still the same.

./perf script -i kcore 
--script=python:./scripts/python/arm-cs-trace-disasm.py -- -d objdump -k 
kcore/kcore_dir/kcore

>> The below diff that you have shared has no effect on the failing case.
>>
>>> But I still think bad decode detection should be moved as much as 
>>> possible into OpenCSD and Perf rather than this script. Otherwise 
>>> every tool will have to re-implement it, and OpenCSD has a lot more 
>>> info to make decisions with.
>>>
>>> One change we can make is to desynchronize when an N atom is an 
>>> unconditional branch:
>>>
>>>   diff --git a/decoder/source/etmv4/trc_pkt_decode_etmv4i.cpp 
>>> b/decoder/source/etmv4/trc_pkt_decode_etmv4i.cpp
>>> index c557998..3eefd5d 100644
>>> --- a/decoder/source/etmv4/trc_pkt_decode_etmv4i.cpp
>>> +++ b/decoder/source/etmv4/trc_pkt_decode_etmv4i.cpp
>>> @@ -1341,6 +1341,14 @@ ocsd_err_t 
>>> TrcPktDecodeEtmV4I::processAtom(const ocsd_atm_val atom)
>>>           //  save recorded next instuction address
>>>           ocsd_vaddr_t nextAddr = m_instr_info.instr_addr;
>>>
>>> +        // must have lost sync if an unconditional branch wasn't taken
>>> +        if (atom == ATOM_N && !m_instr_info.is_conditional) {
>>> +             m_need_addr = true;
>>> +             m_out_elem.addElemType(m_index_curr_pkt, 
>>> OCSD_GEN_TRC_ELEM_NO_SYNC);
>>> +             // wait for next address
>>> +             return OCSD_OK;
>>> +        }
>>> +
>>>
>>> Another one we can spot is when a new address comes that is before 
>>> the current decode address (basically the backwards check that you 
>>> added).
>>>
>>> There are probably others that can be spotted like an address 
>>> appearing after a direct branch that doesn't match the branch target.
>>>
>>> I think at that point, desynchronising should cause the disassembly 
>>> script to throw away the last bit, rather than force it to be printed 
>>> as in this patch. As I mentioned above in the thread, it leads to 
>>> printing disassembly that's implausible and misleading (where an 
>>> unconditional branch wasn't taken).
>>

Thanks,
Ganapat

