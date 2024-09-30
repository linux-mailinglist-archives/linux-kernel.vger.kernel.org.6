Return-Path: <linux-kernel+bounces-344280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA4C98A7BF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A971F2470A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A441917F1;
	Mon, 30 Sep 2024 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HlO3WTsC"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F55191F6B;
	Mon, 30 Sep 2024 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707746; cv=fail; b=rdHsQbplXHneAxswoUEauwW2lbpQDSGGu8Ux7Uc0Cnd/ohaE5ZysoY+x9O7bXwUP4UnYRuyIkv7r9PQSmKLQD8LPaJFgjWD3UWLWAJVKuupNg/KFMyXGkmGr5ZTEMXOqMmpHo20M9V2RnkCaSNfynkIjXFEwZtUhTEUqqHKDry4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707746; c=relaxed/simple;
	bh=CqKYlsc5UXC6JzFDwnuW8uQSiaV1Rp1Xe1F3ssqdytk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KxN9+5477uJfu6ehLLNdpAixTblQrSS8H5VdJzW+DSgCrxHScY/5DD/3W/qm3jTCM5E5q1CFOE0F4htIgM0jseozcAJDOh+nRi/OrBa9i989H6iJfqQMsUhHqgNf4GdsFR7gCrXz/Pknig37Lhie+0zNDMH+Fq0Mtx1kTY6RBq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HlO3WTsC; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPe4DT0wcXpBgaYKgKRjcuaQKPX6T4sn+kIXp/xqJftrY1hwxaNsLq0lCXyWDSZhykycPgAcwifo8xNou+SiO8QGRbiUDHzvTCnRc7yjb7U65jMtlhbxsVHk8/mLIwtK5rTUrh64InZER8xNij2GcVsj8Mzkjjyj5+TmdGrxB+2nGD7hnzWEg3G0goO5i9GDrnHHtxzSPNILlALgDm6D8fBZokM4pInuAQdCNk9DeBG5GvMGMtM26etY5VVpq4OGuaiR1GYveGwpiwwrvpe4uz2p6kfM1pFim1YrLKPH6n48QYEkw2jahAGOIJn49bZMLY3kwe21BukLes04m1yLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYkOkQEUli5NnB1W2QHi3nza45sHld5wReY2INWLzMA=;
 b=GLuCWS84B0O++WnQt6QOhhPAIlXMpOGbtp3xjcrmM7qi0kNhfnD1IP67MRtVMnlrtpsgpDMIDzPimq/A9R9blNgsgSis2WCb6oJxZvTj4Gqz5QIj509FzxcnNWNk/pGVSWnvVX3EU8NwBlcJRuU77pJR2b24aYQi50nJeGeRAnzJZpiMCQTufhPA67LCFFYE6/+2NFNr62r9VDBeTx+nFiEHc+v0BQSHv3qD52Yu7vA6Za0jtokd+vyn+MYMEw194OzKVJdxHqE0oHhGaim4vnLyksyiGxHsSlN49sXyunYgFHg26qq46bwGvWFTl9hmW3Afmcy6HmeIHkbQ76uhUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYkOkQEUli5NnB1W2QHi3nza45sHld5wReY2INWLzMA=;
 b=HlO3WTsC6yCMoOPWTSrXBN4Iy7duCQPRVOHTZru/ShXxJu2c05GqjXkn/E+e248S5sGbwtjb0M8+ACA9HJgMSr52iOLm4APMNQgNsTwQQcdYP+nuqpcKwK402+57YKvRuydez0oK1Z+ZdxCZAQHG0WltF+M4DsMJPVLtdc/4Kkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 14:49:00 +0000
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::65b2:12d5:96ba:dd44]) by SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::65b2:12d5:96ba:dd44%7]) with mapi id 15.20.7982.022; Mon, 30 Sep 2024
 14:48:59 +0000
Message-ID: <feb19089-a7ee-4a39-be8b-bf9e380b17b7@amd.com>
Date: Mon, 30 Sep 2024 10:48:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/35] drm/amd/display: Reorganize kerneldoc parameter
 names
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
 <20240930112121.95324-26-Julia.Lawall@inria.fr>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240930112121.95324-26-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::10) To SJ0PR12MB5438.namprd12.prod.outlook.com
 (2603:10b6:a03:3ba::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5438:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: a81576f6-eb64-4a64-4ee4-08dce15f048c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjVRaE85NHQwUCtocm1CT01JbHBqWGhxMjBCbnJ6WWdESFA3VjVEOXZIM256?=
 =?utf-8?B?Syt3N2M5WFRMSmkrZk1panBCRWludkM3T3hxOExGMCtMeDMxWDhkeU0wWWlY?=
 =?utf-8?B?WFJoWlRmMFpvNVhPR0JaVWZSZGlYN0VWdjNPZ0txU0EzVnBmQ1VKWkNQUHd1?=
 =?utf-8?B?d2poRlFXQkxHRTdERjlFazBhQ2RrZk03bk1aMEh5Qkw0N2l3bS9IOEtEWEZP?=
 =?utf-8?B?Qnk3em8rd2svM1NSY0dNbGxpNHd6MnVMa1N6R3ppcnkwZ3MycFh6MmpvbS9w?=
 =?utf-8?B?ckxoYmlLb0duQXFKY29kSXRwTmo3RWZXUnZ6M2J2RU1UenRwWHViSXgybUo4?=
 =?utf-8?B?UWcya0pRWG50eHEydXI3OW9iVXNkYWRZSENyY1FaQVMxS1krMndvTEZHMHkr?=
 =?utf-8?B?TVhwQkhUV25lU1RUQUdxb3UvVTdlcFdGU0hud2E2c0tGdnE5VXJ4V3RlNU80?=
 =?utf-8?B?ZkUyRStqL0t0cnVyK2FpWkJRMnNGanZZeitiWlBXcDhPMmJXY0U0Y0gvRXU5?=
 =?utf-8?B?UUxwL2g3VU1oOGl0QWhwMFU1RFU1WWVZZ09qNGk0N1lUWDJSQ1lXaGxHdSsr?=
 =?utf-8?B?bkphRGorZHhLbVlIM3gyTTE4R1ZZTWNKblVJU2NTNnFGODJTaEVzMlh1bWhU?=
 =?utf-8?B?ZVprVkhYNlQ5eEo4MzNKVExwTEQ5Q0RockpLT2dMZmR2bUJYb1laVmp3MUQy?=
 =?utf-8?B?U2d1V1Zpb294TDJpanFQbEJUckV1SnUvQjdoQXZRbFdKMTgrRmpJTEtWbnAx?=
 =?utf-8?B?aU41WFUrVEhrVC9kS1Nudmc5dzYzR3dZbEZGOFdwcmMyTWVOdnlHODEyM1lu?=
 =?utf-8?B?elVtb05wK1JtR2lKSmZzT3FhcTQ3ZWNNcER2NEVXUi9vZllsejNwNlBPLzNT?=
 =?utf-8?B?V3E3Y2cvWFl2MlM5Zms5U2M0VjBOTktYc3BOVDFvUmNnamVITUxxcnA0Zklw?=
 =?utf-8?B?d3RSMmxyNngybGhvWXpDb2syaUNtcFh4enRueHg1T3FwWkxSZ3ludi9nanRj?=
 =?utf-8?B?WEQxRU9BalNXWmZLS3hGdGxWYVhqaUl3bDd3VHdsVExZQjhCME91ZFowMlk4?=
 =?utf-8?B?M0IyS3Y0S2xJNWFVRms0NityS05DMGczNldGWFlYdVNqNU5JTFQ3ZXg4bm1L?=
 =?utf-8?B?ZGFxbjNWNURlS0ppWGFXYnE0Zzk1dzZlaVhHZ1QxNWhVQ2ZTNHQ3QkRKS2V2?=
 =?utf-8?B?TVdGYVhScVl4bmN6dW85dkM5TlRtcHo0VDJlQzRDZG1WMDZ3Z1Q4NzdveTlQ?=
 =?utf-8?B?dUE5RXdaNDVFZVlYbGpVVEs4MnVGVTNpVWRZQzZ4T3E5cUNKVDQ1YjZML0t0?=
 =?utf-8?B?cmNlV3lCNGlvUXEwMlRQcFUwTjdnK1pvUmlRN1pwNnZFcWt3ZUdkUlgxa284?=
 =?utf-8?B?MWF3czZXRFNXQUpVQSs0TmtjTW9JaHorMzFzYkJ0M21DaTArTHQvTFJ3YVY0?=
 =?utf-8?B?WTVVT3VjV3J3YytqWXJUNk0rcm5acGR5Z0JIQnZpenFiM0N5dWtLNFRhak51?=
 =?utf-8?B?dXpVc05ybEl3dGFEUThnWGVoSXI4NWFWUWgvL0RidDhTZVdGQUlza1VLcEZN?=
 =?utf-8?B?bkNFY2MrS1NnbGQ5ODhMOGtyVkpYenU2ZXludTJsS3d6V1orT3ZXWFIvTExo?=
 =?utf-8?B?RnpySlVLOGdGMG9tNUp5N1J1U21kUmoxRHJIemtjdGFIOWFmMDBuQXlTVHpW?=
 =?utf-8?B?OTlla0x5cWR1a05jL1JTMUV5Q0NqTklZQ2FqdWFBTE1odHQ4ZmhBNFFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5438.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUhHRUZUSWdnRnRZbU1KbXVDUUpSZEdSN2NwZ0xEYUJmOU1BanE3dGNLcERL?=
 =?utf-8?B?ZFNtWXB4alByM2ZtcG9UcEhFdk1TYUJ5TE9TcGVoMTdmdmE4cEdvZ3czZ25K?=
 =?utf-8?B?OUhoamNrdm9INmV5L1JtVlhtSklTTGhnWklnT2FLQk1EZEU2STRYQ1JVa1pr?=
 =?utf-8?B?SXZ0NjJQcEJkVWZsdnZzTG1xOXU3YUZwVlJBWWhBTmg5NHFpeTBkNFphNVov?=
 =?utf-8?B?VU05a0JtSDVKdVNoN3BpU3ZjdHlVdzJOVnZLWTRiVDlwaFFvMWczMWIvbkEw?=
 =?utf-8?B?VXplN216Qnk4TjFTMEUzeXZjUU5wM0hhbGd0M2JnVDdOM1Fic1E1cTA5SUI5?=
 =?utf-8?B?WmpOaGdYb0xQeGhIU0gzNllicTNKVENGWnkreXE0eUE0Z1hZbUVBZ3FUQ2U1?=
 =?utf-8?B?dWs2S1NWUVBUaEI5cUhINC8wS3lod2J6dWhiOU5yRlZJbStLc2ZEd2pwSFNR?=
 =?utf-8?B?UG83THNHUGx4Q2hiclZmZnZib1RmNXZTL1MrcVhLdU9KbjNEc3lyMjIvNVJU?=
 =?utf-8?B?TFRlRlYzQjZuVms5dzdRVnpPbTJPRUJoUldTK1Fpc2pGTFdNV2UrcWxObFRD?=
 =?utf-8?B?WlRMV3JtMlJhbnBSa3pCZTl6S25TVWFCVTZITE9XQlQ5ZE5yemZFWXc1TUhR?=
 =?utf-8?B?R25wL09MS0N3UkM4SjlpRS85UUVlZC9VS3BTNWQ1dTFSM3BBZCtGb1FYWUxD?=
 =?utf-8?B?M2s5bmtKenBJREVUcmRJei9LQVFwRzU4TDFxYnV4WDFkMGdCVGFsc1pqeXNN?=
 =?utf-8?B?NUIxMmp5MkUzMXFwMWp1TUFtOVNoUGpkV2h3YnRFcHpYcFh2ejZ4ZlRHTlRr?=
 =?utf-8?B?bFR1WVZ6RWt0Tk1ub1RYdUJsTmtNNmxaK05iT2t3aWxPSFdDYUw4SGV1K05P?=
 =?utf-8?B?UkdLRlVpVG95WlUyMStHRUh3TDlpdXNLdWtXb2hpb1VUZWU0U1ByS1haWk02?=
 =?utf-8?B?VzE5VXRURmpNUzJZQ0pLdnU4cWdXU3hnbEhaWHNlTTloUTZjNitNRklNeVdw?=
 =?utf-8?B?YkRnSDF1TUlQSzJ3L1pGay9rd1pMOTZDTzZmdGk2RjhtajBzeDdTRTEyTmFV?=
 =?utf-8?B?M2ozcEYwUVhTOWJ4YVZlZ3h1aU8wWUl1ZnhJTGRneXZOb1pxY1ZHRldLSG9R?=
 =?utf-8?B?K0l4ajU0eFl1QmNMOFFxZUNrY2hjNnBlZDFSalIwUEJrNmJpL2FUaDhuNFMy?=
 =?utf-8?B?UTVkL2NiMnFVazhPV0MzRXpzamh1Q1E4NEpJRUMxWXdQMmUzSGxJY3JpTmY2?=
 =?utf-8?B?Y0tEbllVdmpmalgwSHFRTnVMSm1qYWxzNmVpdjRvZ0RHSExSbDhCMkU4QXFy?=
 =?utf-8?B?eC9YbDY1UHJnQTJicithdUhxMWlRWGdGdGxCalU4K1NRM1RaYXh2b0NHd3V2?=
 =?utf-8?B?REJuRko4MGQycE04dm5oczVvMzFzanVHR2p4RmxwR1ZJazJvdWtQcjVIQ1FL?=
 =?utf-8?B?VzBZYzk5dHVISWI0WWdISUY4YkRRMG13eW0vUUJTemVWL3QxeldtNFhKdmph?=
 =?utf-8?B?TjFkcEtLbG9LY0plWXJMMi9KK29ES1NyVC8zNXdoUjlaSjVNbDRMcDNVWHpm?=
 =?utf-8?B?bDZrT29rV1djMnlCaGVVNDU5QkJISGlJZ1VVdWpNYTF2eUtsMXpnWkNRY3g2?=
 =?utf-8?B?Y1pOQ0hZWmlYQms1OXRPQ09jeW5BSEJldTlhZndLOEZzcml2NFk5UU55V3N3?=
 =?utf-8?B?K3pLWjJhTm9nOUZOZTJ3UnZ1dEh4Y24yWXFxWjlNekVzdVQrSGRDR0VGQWtL?=
 =?utf-8?B?NW5TTE9lRGljNEtjY1I4aTZEeVRrU1c2L1NET2tSem5wM2ozbWRRYWYyVzg4?=
 =?utf-8?B?cng5T3NVK1VVMzNUMmQveFhoSkFsaU9rZ3YzNlB2OUw5NVFWZ2RER2hiejlJ?=
 =?utf-8?B?d3RJWHNuY2plVDZhUlczdVlOZ2FVRkR1d21WeWkwa0ZDQUNuazNpaXJPSkR2?=
 =?utf-8?B?Yjk4Q05LckxxclN0NHpCTlo4c2tVaDQrTmlpSGk0eFpJcmZyOVBHdGFidVFQ?=
 =?utf-8?B?NFlFa21YcXFieFRmb2VyT3pDR29pVDFyWTVuMGMrT2YxWE4xOU9jamplWlc4?=
 =?utf-8?B?bXlBRXRIckcvYVFXUWNiSjU5ZzZSRjBLQWkxNXg1TjIwNEh6c1kxN0NhMEtT?=
 =?utf-8?Q?SRIv7B1rD6tM7iUtyUeefIAZP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81576f6-eb64-4a64-4ee4-08dce15f048c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5438.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 14:48:59.8043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9ytG72CxMJChKbddMqcxogUESGmWW1kC/xyhMRwRJIoNk5ltHu4AlgG6UOs7H80uRYTWV5pAN45OsUeB1cy5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459



On 2024-09-30 07:21, Julia Lawall wrote:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> Problems identified using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 5c39390ecbd5..417fe508c57f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -621,8 +621,8 @@ dc_stream_forward_crc_window(struct dc_stream_state *stream,
>   * dc_stream_configure_crc() - Configure CRC capture for the given stream.
>   * @dc: DC Object
>   * @stream: The stream to configure CRC on.
> - * @enable: Enable CRC if true, disable otherwise.
>   * @crc_window: CRC window (x/y start/end) information
> + * @enable: Enable CRC if true, disable otherwise.
>   * @continuous: Capture CRC on every frame if true. Otherwise, only capture
>   *              once.
>   *
> 


