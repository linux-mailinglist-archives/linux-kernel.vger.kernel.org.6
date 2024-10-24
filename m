Return-Path: <linux-kernel+bounces-379165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF6D9ADAEA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0DB32833B9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E0816DC36;
	Thu, 24 Oct 2024 04:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="gTODFOYV"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020097.outbound.protection.outlook.com [52.101.51.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0E6157A59;
	Thu, 24 Oct 2024 04:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729744198; cv=fail; b=VeuoGo35WzcaN7oCm0pmTIVzhNV3MWMMwhFXWJf3LZbPTKlMiJ+x5SzCTYZ34CNwfnAz6RW0SpMKBLfLGSSuP1cJ/9FZ1ks/Zg3i7whlqVO+p5IYgthIjj3HxOicz37UUIJeQOL8c3foTweoXAOyu3IL0vAPXqM68cIiqs9bKNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729744198; c=relaxed/simple;
	bh=MAJY4PtuGIvg7mFRAbOkxD5uU8HlZYLp/6TRWcyZZe0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nq7s1aRkLeHCPTFnp/EtoIkwYwXCY7VrepUpIt3KpE8d9y2oiyVYpCWi/42SOyzvkm9nxB0mwULkVaLozMOFZbU1n+wPeEf4Om76Gf+6ny5qX8boLLVolqmgeGhGmHtP/C8o4yz/jWWdBoOg5OIngEZ94LMB+jSiYaecwBQCwsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=gTODFOYV; arc=fail smtp.client-ip=52.101.51.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ov4F1Ho7Izy4BY7hCr/QpFPVohmnbm+N5Eu6qnX5BGnn7awT06Y8bM/0sACcC3HsU6yjBkHYbSVQk86HLr9fZCv2zP+DhBKAJcTtaK9V07gC/WLMNe9V2C00UzNbu5xBs7d9tVJi7YdD95kYnf9knsanUFUelOLg1qjCTwtMzfzVHkwdZrZ7ghy7Me2MF4Z5WTIoK1sxofuhd4nmFtutinPLtEhGY4VMdcFd2THXtpz2NtUtpJnrJKvGrI7AFSEjXUkEtbrQITYGLoKZF2K0ILmzJeGy5GN7QJRhBx6/GLf/y4ZrgDMmMCVnxczQYGEyGCCg0yXb77gipKfkcFYrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nl1BworvqpEcpHNx/vneDgJ4RxfCHtitOgsAtm5VH/g=;
 b=k4f6GUVjUPJQzMrVnfWbiAFYnFyqe2ZL36dmb78BijBfZkB5K+n+P7K4iVX22VzUdxxlisppr8vExRGfQ0S+c8XKuz1aG8JiG9uVbB+Vt9PPHYtuEXdMPxxPrImXkAzQtQPLcGbF87/5oATP7SHDH7TncAxWlPZbf5TdIEZtbLDaJsxiYgqJDiOCuWGYgEilnpFZ22DhykCXPbaqwVixXgbQtYh9603XbicI9MUJ9CudYs1s9scK65LXX6AfdRwTBjwIoyNScz9ul8VQm2971CxEhYLf7F73RWTcrCKoTDtnlsnA7uxETODTRh3UDszHzy/E2y8DbsL51ermqzdEUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nl1BworvqpEcpHNx/vneDgJ4RxfCHtitOgsAtm5VH/g=;
 b=gTODFOYVwJNfwwWih/4//OLhOlIsG6oBJ8VPloyzePay1XpdnmM9dgmfIkirxKiJ6jaEcx6Sxfm5Umkwen2HIWmuOrrN1NevK/LKX3qegymoQi4GfBTFd/0wjT0CXWjqxo2HFUYuew/g9Vr5G8F41efmgSjjBy23qI0RdH0Evq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8193.prod.exchangelabs.com (2603:10b6:a03:4f6::15) by
 SN4PR01MB7438.prod.exchangelabs.com (2603:10b6:806:1e9::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.32; Thu, 24 Oct 2024 04:29:52 +0000
Received: from SJ2PR01MB8193.prod.exchangelabs.com
 ([fe80::4167:3f60:16af:411d]) by SJ2PR01MB8193.prod.exchangelabs.com
 ([fe80::4167:3f60:16af:411d%5]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 04:29:52 +0000
Message-ID: <434333fb-5703-449e-83f2-46e85f34fd23@os.amperecomputing.com>
Date: Thu, 24 Oct 2024 11:29:42 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ipmi: ssif_bmc: add GPIO-based alert mechanism
To: Potin Lai <potin.lai.pt@gmail.com>, Corey Minyard <minyard@acm.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Patrick Williams <patrick@stwcx.xyz>
Cc: openipmi-developer@lists.sourceforge.net, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>,
 Potin Lai <potin.lai@quantatw.com>, Cosmo Chou <chou.cosmo@gmail.com>
References: <20241022-ssif-alert-gpios-v2-0-c7dd6dd17a7e@gmail.com>
 <20241022-ssif-alert-gpios-v2-2-c7dd6dd17a7e@gmail.com>
Content-Language: en-CA
From: Quan Nguyen <quan@os.amperecomputing.com>
In-Reply-To: <20241022-ssif-alert-gpios-v2-2-c7dd6dd17a7e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To SJ2PR01MB8193.prod.exchangelabs.com
 (2603:10b6:a03:4f6::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8193:EE_|SN4PR01MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc11a78-180c-40f4-d507-08dcf3e4812c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVNrM3JSNEZiWkJrdTRqcnA0M3pxN3FjL2xFMkczS2hiUVVNeG1Mdk4vWlVs?=
 =?utf-8?B?d2FjazdibFhiRVNnc0NBRGRCNmwzMTZGcWxaOUdodDJaVXV1UjRXWWx5R25p?=
 =?utf-8?B?NEpmek1waW5UZ1RHVHhtVXhCUWhjTDlTT0E1dzV6b0FIT3BXVHVrL2tGTkhn?=
 =?utf-8?B?cnpqM1VaVkNVOSs4aEZSVXJrcjFKNWM1TUg2S3orVTdqVkhUL3VuN2RmNWt4?=
 =?utf-8?B?bTdjSHhPYXJxcExURFEya3AwNVFzT3hZM09FRmVFajJ6UGpRY0d2cDh3dHFS?=
 =?utf-8?B?cjBvYndjUzVFMnJWSnBRNFczbGg5WVlKY3g0YlNpN1pzWEZkSnRtVDIrRzZS?=
 =?utf-8?B?cjlUbmhJK1k3clQ4aC8zQlc3bTdYeTR4WFRlVUlXQ0d1Mmg3ZzkyZmZvd3Fx?=
 =?utf-8?B?eUVKV3A5RWZNdmoxZ0x5bnl3eGlhYkRQcDd2bDkvb2lwYUUvUlVjeEJpL3hQ?=
 =?utf-8?B?UlVlMDA2Zk9SdldycmVpL2VlMXRqbGozQW0rNmVGNXlxV1ptOFFuVzd6ay9G?=
 =?utf-8?B?N2VTNENlZzFSREZxbUxMd1U1d0x2ejJaOENnMXE2eE9TYUYyOFA3cGUwNWYw?=
 =?utf-8?B?Q3pVVXQ3RlVVY3BwcFN3Tll1Z0FjbWlmT2liWHVzY2dxckpobjlkMEVlM21E?=
 =?utf-8?B?SHdVQnBsMkpaU1diSk0yZHpEdll3ZkdUVjZkcU5rNWx6V0dvYWhtOC9Uc1pz?=
 =?utf-8?B?c0ZmL1BoTGhJYm1QbUZZUGJicHNJMGxQOXVWWEVNZFk4VGRnQTBBR1UreThs?=
 =?utf-8?B?clJxK2UvOUdvWVRlZ0tTWWgrS01zSWw2cUUyOVcyc3lxS2tTZkpEUTJLU3NC?=
 =?utf-8?B?OUhpdGRkRmJySWFudDhFY1Y1VzU1NmlLUk5Ob3dTa3IyeWhuT2lXeWtXS0tq?=
 =?utf-8?B?Z1BMcnBVMXhKRzA4eGdYdWJnMkg0NTViZzhGL0dRc3kzcDJMQjFzckJtTVJ5?=
 =?utf-8?B?b3ZlZlIxTGlRd3Y4STZWM2piODZiRFUvVXZUd1h6dmVyekRkNytGbjQya2tM?=
 =?utf-8?B?WWlrM2hqRWhkb1VFMDB0UXZxUmF6OGVONzJDV1dzTWhwYkhVVW05Z1p1M0d6?=
 =?utf-8?B?NE9rSWVnVmUwdzhmeVhtY05xK0JFZlM0SnBER2dQUEZoUXA4N1ZtakY2Mm8y?=
 =?utf-8?B?bFNkOGttajE5d2JTTENYSFRGTHhHcnVqUC85MytSdGkrcVB6M3JPM3EyYUwr?=
 =?utf-8?B?QmtBT0wyUjFUUndCbDFUQUVhWFJPYVc4M3AyeW5OT0NBR2tPcTlFN000RitN?=
 =?utf-8?B?eERZbXZZQVFiMGtrSkpZSG9rTmVNYlpVSzJwUWhZWFRCSEJaYlRlNmhlWTVh?=
 =?utf-8?B?aGpiVnRCRnRyT1RSdFY2VUJkZVZPeFMrY2FCcEt2RTZUeVdiNEcrVytkbldr?=
 =?utf-8?B?dGFmSUdnMnAyeHRtMXloaDNLTnQ0cHBFMEFqZ25uODBNNUhUUWJvcWt5YmI3?=
 =?utf-8?B?enA2WEQ3OFI0VWhUU21qbHFScjdDb3djSElDVGJpeE5RazdyMGdUc0JQVXZl?=
 =?utf-8?B?bG9xaXEvU1pHaWtza3JzdDFIRlYrUDZMSzFzcXkzMzhFdEN4Qml0bFdFUFQ5?=
 =?utf-8?B?MzUwQlFwMG93WkEva3NpK28zSDVUNzN4SnMvQjVnU0RucEFGYVcwK2pvWS9j?=
 =?utf-8?B?bjlQeE91UitnUGhTRVJYenYyZU9Rc1FvakltQWdsc2VDRW02VTF0QnRYdWlV?=
 =?utf-8?B?M0l0YjVDaWUwY0RWQVc3djVmUHNhUWtub1RldklkSi9ESUhYMmlwRlRDcWRx?=
 =?utf-8?Q?XcAulra9i9+q0/fQwo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8193.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkVOTW5aekdJMDBIUS96TnpsbnpUZnkyeXRkOGs3eE9PTHJKVExKYmJhWm51?=
 =?utf-8?B?M0o4S0s2TmJIOHZ6NW5hanlxcG05UWFVTzVuZHJTTVFnYzl0ZEZ0TDE0Mi85?=
 =?utf-8?B?a2RLcTZFN0dBZHdPZUNHME80TnVraUYzb0dUdWtHT1lHU3Q5d1RIeVExc3Rq?=
 =?utf-8?B?b0hTeU9VQ2lXVkxqN3pxVXR0NXkzcHAzQzJ3T0hYZzR4S05QVVZkUWV1Q1Ex?=
 =?utf-8?B?bGJ6SGNGNVhNNVBwSEtqeXZ2OGhKTlVhQUNnNWlnQmczbzVZS1QvVGRnUDEv?=
 =?utf-8?B?UjFyZWI2bmRqQnczWGFEYmFWS0gva3FwZmJsamZXSkUrcDRaNWtpUmxwMy9m?=
 =?utf-8?B?bFcwTk12SUV1ZWxHSXF6NHRxRXZiUVBweW1ia1hUZEsvN3N4UE9nd2U3akJr?=
 =?utf-8?B?OTVNOU1QcFM0WGNmQUZDWlZTNFFSSmFubDlOL2FnSU56NmRJbkRjT0FqWEMv?=
 =?utf-8?B?SFJmZ1FaenhuLzFwNUZxMlREZ1Zab1dRbVRvTUkvdWZOckZMcnI2UDhhOVVz?=
 =?utf-8?B?ZVBZNmZNWHgwa3EydmhDZUcrazlERlRFUjNiOC9aMW9iSlQ4aHBCdTlqblJS?=
 =?utf-8?B?NU16WCtwY2hrY2F5akMyQjc4cnA1bTlXK3RDMzluYU1ySmk1QVZXZW82bjRH?=
 =?utf-8?B?NXNybHYwVjBjRHd5WGx6QXRSVTVFbUYzUSt6ZzNlYU0zTVJCdVE3TTBCc2NN?=
 =?utf-8?B?aEtjVFN2em9wclI2VUNWV25pRklkWjBvZ2hJR3BiVGFjbGx3TnF2emdTU3p3?=
 =?utf-8?B?QU13d0F4QjNGelltdzh5bW1vQmNHN3Y2M1VoOERvTHRhYVV2aXZpQ1Z0VmZZ?=
 =?utf-8?B?MXBmQm1LTllSZHgrRmJIMStFL1pMWE5EZE1PQzJhQjB5Qi9yejZzMHJCWE14?=
 =?utf-8?B?NGhSbFVuNE83Mng1VEt2SmhweExFeTlobTJHRkFmWU9JemFSOWkyeDQrcDAx?=
 =?utf-8?B?S3ljMURoK0JlK1BkYWE3bGZxL1hjc3BHMSt5T0hzUS92MHpETkNHTGxwSmNB?=
 =?utf-8?B?TVQzQ0tPYURWbXBjbDFLYzdyV3BGTG4wY1hjRXFDN0xheWlJa0VYVlo4OFBs?=
 =?utf-8?B?UURzTU50QU9ldkUwTGRyWXNBQ3ZBb2EzMGRqY2FnTU82WUlqbnovNkx0c3FC?=
 =?utf-8?B?RCtLTjg1TGZhSVFkS1MzVHpVZ0p1ZlZDRlJjZUVpTGhPaEluaW9zYWo3bDV2?=
 =?utf-8?B?V0hDNnJpekE1eExRbVRpMHdQam1WZjFFOUxSVXFPT05BdlFYeGNqTXV5Rzhy?=
 =?utf-8?B?eDJ5R2lqUFBGVE1odVdzNEFQZndXZFFsS3NtcDBQOVI5OFdqbkJqVnZaQTM0?=
 =?utf-8?B?NjJCUXoyRHAySlBrMmpVR3RBNUZaeVRlWis5akpsdVNjR2F6ZFhKNGxSem51?=
 =?utf-8?B?elpkUDVoaDVYdkpUSnpwVFpId0hacUdTcUlvZlVudzc3TEtLLy9XcjNyTVNo?=
 =?utf-8?B?SjVaTHhUVHZNTUV2VTNpbkNUb3d2Nmd2eWsvcWRjOHprd1dMMzZ6S1VnWmVv?=
 =?utf-8?B?cVE2MmRMWHdkYTlUdmlrQUprTlp4Wlc0c055ZW9LK082Qlo2VEQvZ2traUFn?=
 =?utf-8?B?V2JyVEJkRkdxbytqUGJmdDcxSjNwajdFTXRqZUtUd05oRlZxanVjVDZBbndr?=
 =?utf-8?B?TDY1K05xWHREUi92Q0xjcXJKbEE5K2tGS29BRFFydmdycnRBWm52RW90Zm5v?=
 =?utf-8?B?Szd0UEhqNTZadDllNDR4cGFNM21MYmx3SnMyVTJNTDRiMENVNXlhTzhQUy9s?=
 =?utf-8?B?Z01adVY2UXFJTnhPZkpLMi93SG84REc0MVV2d0tYSWhxL3hDb044bWlGcXVu?=
 =?utf-8?B?NndsRi9vQ1pWak1uc2xhei90YVphVEJrOTRwMDNnSnJXWjdpYkxLNGNJcTdH?=
 =?utf-8?B?UDJRY0IxanhPWm12ZnZ0SmZrdHhPVmJIRHhoZStDY0JESitxQlNUd0xqaHhT?=
 =?utf-8?B?T04vaVV4aVVoeGV0aG1FYS9yU25nL2RHWWVmV0lnSlpFRjYvRjltTDRvQktH?=
 =?utf-8?B?cldOSnR1b055MlUwSStHTnRXaEMwT0NGcmo0K1pFdFMzODhYTEVXa0VoR253?=
 =?utf-8?B?WWM1V0d5OTZyQm03YTVlY2p4RjM3RGZwVE9vc3B1c2tXWmF3bndqWU5US2FM?=
 =?utf-8?B?b05KdDZnRnVNWUpkWFpUMVgzd3Rkb0FFNWliSHgyL1hSSWFsWjhzbDc0UWV5?=
 =?utf-8?Q?NuhdNprWQ24tC7JGJzBcVTs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc11a78-180c-40f4-d507-08dcf3e4812c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8193.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 04:29:52.7694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rI5DbMS62yrzS2PKPX6dW+OwNz0s/TtKCdiYHvh5reXm1Pwx5heHv5etxsxbUIZ87JENMPHJWfR0ce9Zo+gQw7ft0Vb4r/Jh5KSBU5Empfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7438



On 22/10/2024 08:20, Potin Lai wrote:
> From: Cosmo Chou <chou.cosmo@gmail.com>
> 
> Implement GPIO-based alert mechanism in the SSIF BMC driver to notify
> the host when a response is ready.
> 
> This improves host-BMC communication efficiency by providing immediate
> notification, potentially reducing host polling overhead.
> 
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> ---
>   drivers/char/ipmi/ssif_bmc.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 

Thanks for adding feature to this driver, the code looks good to me.

Reviewed-by: Quan Nguyen <quan@os.amperecomputing.com>

I'm just have a bit of curious on how the ipmi_ssif in host side to work 
with this mechanism? Will there be patches for ipmi_ssif to use this 
feature followed?

Thanks and Best regards,
- Quan

