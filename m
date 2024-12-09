Return-Path: <linux-kernel+bounces-437156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B6C9E8FC3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589641883BCE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC98216E26;
	Mon,  9 Dec 2024 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HjKK0gBK"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0D0216616
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739005; cv=fail; b=rCpWA9SGflRwdvTGI/9DJscEmiOVdgmnvFgrR+a86At2gvgcfO8mhbnCiZDd7Mjo0RmavIV0QaAnXWMzGV19Fu0TvMhyFwFQ2uNCDouNwotzGf0u51g7c/P4C4phQTFpwK5d/csL2D5bv2OrBu/onzB8u0fgxS7DRCO4g0ttkhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739005; c=relaxed/simple;
	bh=fGB1wZsxx/xiuyq27a5LMbB7JmviqJ5YRtvptr5aArM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R8QSPtJJcRY+R69cMie4L+NWnXBQ6G94vgrf4XN3/jpNURPb3q8a5MkzzBEtdDsZzkoyxRn7gcBbHNl/77gv8cV3Ez+wa5NCZu3IHpmoTEmuO0C1l8YpvMCoW6oQVXbTQTnysleOE7fFQKLgOInAIMGWkyPa12jXr33yKKPhkL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HjKK0gBK; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6sWYQi8W4CpMkHNT5kocgfgetFcItm41tsCuk5QBBw2oI+Rs0sYD6Y0kczzFw4GTu2gVGEhh7FxN++pIDvKmcA7T6A8wKlrxEngYBcZ0bRT3lXn4PheiGftZczM3qPES0u1MHZdc32hEMA9y++OYjVMoop3Zpd+P41MpUe64STG6V/6Ey/cXDVtihuGxGsxnMRVzAjVyhVT0gAk82Nrq7vTOp4nqsLv0RA+yuxAx97LCpcJ2QMGlkbRyoduLSfZZN5CkOBwWZEqFNeL76h/V6yM0EvzXcg5OHylez3K9L73L3mjBvjvpoW6yGkUgOVaPosiI9n5vLKfA/1xkcA3bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGB1wZsxx/xiuyq27a5LMbB7JmviqJ5YRtvptr5aArM=;
 b=yqntq8R4bjThIKk/z1Kq13Umld9RTSF4VTZgoNEjd22eYaMyZa4WGcbxZPzzhn8TNiNYYRL4VpbqI1XRdHRCUCOANPj9lTR7jHRbqfCYURaoi3CBXj2LgTRWoDVxJl1Ho7Qu3cUGko3OUSt427lpMGyQnh1Yh1lPz32WtXtarhzjMWDl5dhEubQbB5uBHx0I8mndcW/5eVZwxDiTDsm2FhwjX6RjZdiR2AqFailGaYUdQO/fT2Ke702+Z9caT0osqWlKIESEVWErmCizEqjzI84IOFTgH2C7lomy6ilY20JMdzK+AYAzam6YR1dTNIQKfJe4bw70ru0LmSULX8we4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGB1wZsxx/xiuyq27a5LMbB7JmviqJ5YRtvptr5aArM=;
 b=HjKK0gBKkkcukC6Jp7SpHXICOPZtAcXyepxy2frzzxCOGo6ddMj4RelY3o7/jub83ciSpJir5AEeWajLIkBLZFUWkfWL/3BrJb/hRgLdKRfZoBwePfyjVZ9Vcqvs97s0PVly23vOE7V31Qn+QR3P4QWqLO7EdbEfUj23zDquhaSKX2IxPRz1LRaSxCTmm+D8hcccQBQgRxv3P5J0PafUAWga3mFP6r0axCKLfY+o9NUelDAIPuEQ+kmH3tVQ24NCNDG+iHw16BlftNXnxwKgflBw8QoCMz+PUgByoOJi7o5EfLKBr/ykW+IP/XLvLEqG1NZnK8V49YU2tpntya4k+A==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.25; Mon, 9 Dec
 2024 10:09:59 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 10:09:59 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"oe-kbuild@lists.linux.dev" <oe-kbuild@lists.linux.dev>
CC: Tariq Toukan <tariqt@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lkp@intel.com" <lkp@intel.com>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c:173
 mlx5_fc_stats_query_all_counters() error: uninitialized symbol
 'bulk_query_time'.
Thread-Topic: drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c:173
 mlx5_fc_stats_query_all_counters() error: uninitialized symbol
 'bulk_query_time'.
Thread-Index: AQHbSgKCd/A852LYLEC/09w0+sNf4rLdsPkA
Date: Mon, 9 Dec 2024 10:09:59 +0000
Message-ID: <59b9f96ace8fe9b6fc1de39ff060e4deeb712ff6.camel@nvidia.com>
References: <1ce44712-7b81-4ace-aae8-7284974b11f1@stanley.mountain>
In-Reply-To: <1ce44712-7b81-4ace-aae8-7284974b11f1@stanley.mountain>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|PH7PR12MB8122:EE_
x-ms-office365-filtering-correlation-id: 9800c5c6-190b-48c0-c059-08dd1839a37d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cDFDTUxxNCthN1RWdkpLbDBBdU9SRDhCb3E3WGUyYTBCL2FDSFhOU0Z0Q25o?=
 =?utf-8?B?cVJUYVR6aGxEdjR5ZnBvTHJ6UUhQNkdpbU05VEpnZjB1ZFNGTDRqNTJuSlZV?=
 =?utf-8?B?eEpSSG1vU3V6NWowM0JNT1diaG4wZll1OHZHWTVqVTJJM2NUOWNWamQyeGxR?=
 =?utf-8?B?cUg3bjlLcTRUWTNKa2hkYnZMSmpqZGhkeTUwTEFDdFRBZnhGNkcxSXhLSmJZ?=
 =?utf-8?B?enpkZ2lhWE8yYTIzQTc2RFlUTVRNYmtqYjQxSDgra2Z1SGV2VHhnNUlvWlQw?=
 =?utf-8?B?cS9veStVSFhibjFINmZhYVRqYVhhQlg4N1YwNG45NXM4b3JmV0tzQ0M2Si9h?=
 =?utf-8?B?MDl6bGhMNkY4YjVYY2xNYVN1QzFIRkQwSEE2ZFBPYTlFSEpIUUJiT0xZRWZk?=
 =?utf-8?B?bXFxZk5iWnVTZDBHUTlqd3E5eVltMXhxY0hHTXdydG1zcWFzVWJoU2k4bFEw?=
 =?utf-8?B?RE91US9lSFp5QStBTzdOK01Jd0JMSkFNSFErdFVvanNObFdLSW1lUEVZQXQy?=
 =?utf-8?B?bm9hUnJlTEJjM29wSGV3WEUyYnVFTkE3bGIyUTlsRkxjL1dTano3S3V6dURD?=
 =?utf-8?B?V2g4WUU2MVJ4cWxPZ3dzbW9VU2V2dU1HaXB3Y041dXNteXk5RWc1a0VKWEd6?=
 =?utf-8?B?RkZ1cGFMLyt5bjNVN0tpOTRWVXp5RXkvRUZVQjRXUkxQMU9DY1FaWXIrRnYw?=
 =?utf-8?B?MVJPbDQxcGQ1Z0w0L0ZoYzdXRnBBcVpPdVpjZDZlakd0QTFWdk1weEpQQ3Vi?=
 =?utf-8?B?STMybTNFZmdVS2JZWHB2Uko0U25KZVBBWDJkWEVyeG9WUXVqL0tkS0tXc3hl?=
 =?utf-8?B?cHk0Qis1d1kza0ROeFp4OFFmYTJrak9iQmliMlR5LzdZY2xHd2c5SkkxekFM?=
 =?utf-8?B?b0R4N1J4RHJBWnRKcGRZZzdjRzVLREhVZC84N05Rd2FrUHJTbU1WWTVuMDll?=
 =?utf-8?B?QTRwbjhzTW1oL3liT3Q1aTgxTWwwSEpoVmtXdGJseG12elE0Z2IvTi9MNGVu?=
 =?utf-8?B?c1hhMTlBV2ZxQ0RaWDgrdVU5TGc4MWQ2VU41UnZ0RmpoR0ZMaEhCZDBINnRw?=
 =?utf-8?B?N2hnRHBhTEd1R0t1R3lXTHgwVlhnTXZ5Qy82YmorT1NkWStZVzFjT3NEK1U1?=
 =?utf-8?B?NmNQOGpGcnVmRmFxdDhKaThHb3ZsMXFWRkM4ZHR3N0trMEVtQ3VvakFqV0J6?=
 =?utf-8?B?TTZjY1VyNU5ROEFmSnNrbWlWY012UEtWaTBjcmk5c05sMU9OVDdHa1N3bnlN?=
 =?utf-8?B?Mk9RZ1g3MlBXb3Rqdmg5anc0a1FrSXN3dE81M0lWWTRzQW01K1VjUkxTK0sw?=
 =?utf-8?B?UDhjR1ZjdzFJd3hZMForT3JRQkFuWGpEcktoS0Q3MjhjdmhUZWJzNjlKMDRH?=
 =?utf-8?B?b3ZIREx0MEo5VmQ1OEprVG1qV2lEVXY0RXN2c2Nja1RjOFU4Vmx1dDhTKzBZ?=
 =?utf-8?B?SHhpSndHb3JsWjArUkZNOEpqNTh6YU53RzVCdTA0ZU9kZjlJa3JxQ3gwbkMy?=
 =?utf-8?B?MEkwaktpMjUwSjJMbXQwNG9IdXYwV3ZQV2JRbnhCYTc5cU84ME1wbnA5TmVl?=
 =?utf-8?B?bERzTFRDTSsvU3k2Y3p1V2hnSm1HNkRwRVB1Zm9HRWRBM1cxdGhYZjJuRmtM?=
 =?utf-8?B?cnBHYTBiMWtSbWk2M0E4bTJ5WW5ub2pOUnNIQjVuUnlBcTBMT3VKeUk4V2Qr?=
 =?utf-8?B?NG56TVF3VS94S1JkRm8rS1o1czRKaisvLzdWQlBpVHgyVzZVV3l5RW95VUUw?=
 =?utf-8?B?cHEvWDk4VDRlWmwvUkN5V1Y5eTNZVGJ6VytFTXcvV0NDOUhJSDRwajJ3ck44?=
 =?utf-8?B?b1RpTXFuWkRwSXRSanY0RmlNTFM5dStCYWZVZzNuekdVazVvanE5eE9zNUJk?=
 =?utf-8?B?MHZaOEs4VWhEVkhzOExOUDMzR01UUnROMm1pRlV4enRuM3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVI4NzlKOE5jeTM2cFFBVWFjRW56ckVCaGFOa01xa1ZTU2ZPbFFtbjM2UmN3?=
 =?utf-8?B?dVE5QWVIcEtFdkhrTUsydTRsVlc5bStZOStHenQybmVxdlp3b2RaOVVjd2xZ?=
 =?utf-8?B?NVJCUFFSZy9ySldST0tlb2JXbFlzUHRGaGZOTDAxb2hLeUNsbGtIaDU2c1R1?=
 =?utf-8?B?ajk3U1ZteTI5clIwUWtRT28rSTRqRG43cS9FNkVodGVBNGs0OHlqTm9jaXYy?=
 =?utf-8?B?TG1jWnkxNlAzcEtZWERTSzg2K2lSVHlFQ3VwRnF3aTA3a2RuR0FWcjZzZStk?=
 =?utf-8?B?eGRnbWE1YkN0eFlKNHNnOVJxbytYSndmNkc0UXRGM1NLZ2tUaVEwN3JxQ0pJ?=
 =?utf-8?B?ZmVKTnhzUi90RlJNbHFBaHFrMUpTdEtVcXhsbEZhVm9UeFp6Rll3bCs3TVcy?=
 =?utf-8?B?N01mSTBUd0xsZHVwUGx0QnYvTkhWSzRBM0grU0hCL3o5WHA5OUlCeUxmVklB?=
 =?utf-8?B?TXVNQlpvY3gyczBrMkFTZ04za2tkdm5EeXVTY2RnODlZbVFBUldFOXo2R29w?=
 =?utf-8?B?NlBmQVFhNVE1R1hvQ1RJR1E2RDJORHhxVGxJUDE0SG1qeFArUTJDUUxZS1RU?=
 =?utf-8?B?cTVqVVNhRkJLTnBJcnZjSGdSUjdvU1gveGZXZGxUZXlwWVcwcHp0NFpKWmRU?=
 =?utf-8?B?QWx2L05XUXN2ZGxFMlFzMVRabVA3UmFuRDJHZWlTRktpT0ExMlNUMVFKVkdK?=
 =?utf-8?B?Uk5wdU5udTZVMkN2bTVIVUtPOEl5WGxRRDQyNDQ0bWNXTUtnQ2pGcmpHWUFu?=
 =?utf-8?B?aEJ2T2lWUUZKdWJRRzlHbms5ZVk2UzJOQngzUEo4TkpKUXU4ck14UTJiVFgw?=
 =?utf-8?B?dktFVm9GWTM1MHIySytnSmdIRGxqUi9tWTN0cVhSTUVsTStXTk83S3lNdTNr?=
 =?utf-8?B?dC9iRjh0cWZKZkUrNjVxRmo2eEdQbVJaN2lTMnB4UmJ6Yk9JdEFqM0xYUkE0?=
 =?utf-8?B?NVhpQ1E5UVNXdDhIbitERnFWNHBkRitZVkZPVGFVMnBHMUw0emxEa0ZGSEFR?=
 =?utf-8?B?QnhpdFJObHQzZDJKTGtKVU9VSmltSlQrRU1RcHU5a09Ddlc5RzZBQmZpYjFZ?=
 =?utf-8?B?MmhSREt0cXF4UWZDbTBzTmVXcXdwZC9FcmtqeFNKUW5aa3hZdWhCT2cyTGhN?=
 =?utf-8?B?UHE3SUQrakpuRko5WHVpQysvai9XZVI2akVxSDhaUmNPRDdPNDhub0NES0J6?=
 =?utf-8?B?SmwyYzFBUmozeEIzWTdhQjVrZGROeFZEcGFnWmtXdU1NekNVWVovaTFzak1n?=
 =?utf-8?B?R1ZXaS9aeTRjWDgrdHdVcDllcWZhRGEwTEpQSWJVUmlqZWoxSUZMOWlWM1kr?=
 =?utf-8?B?OGZ5eExwc3kzdTRQNW5KVU9vL0FkR1Y5OHBseEsrTEVlanlJbVN0ZnkwRTV6?=
 =?utf-8?B?OVdJWG43QjdMQXpYWGYzTDdCVTR5bGIwRU1wejh2K3lmQWNVSTVJbEg2aVpX?=
 =?utf-8?B?MXBObUV6SklGWlo4VU5wLy9GUFo1dVZKRksxZUd1aEliTnhxRWxSb2VDSFJR?=
 =?utf-8?B?b2xHR1NFUmRvNEJLNDVWU09FdDFLUmZrQkF1dFBJTXNhSGFOb291TE9DbjNU?=
 =?utf-8?B?bnFqSmE5UnJTUFNJR2NhY2dNR0ZIYjA2UWRFRnZjSFFBVitPb2ZUK25tdlZq?=
 =?utf-8?B?MCsxUkRYaStHZmxWZERpZ1JEcGlKU3d5VHJ5UDA4aE1vYjlnNy8yZ0R3UFI5?=
 =?utf-8?B?Q09lczJuSEJLY1JrYWFKck9mZEZJa25LVHYzUHFTQ2xJN2xUTlBVRVZhTkh3?=
 =?utf-8?B?NVV4NHJjRU9LcjJUZnVpYkpJVi9pazRUMnBsSlN1OU5rT1o2VXdwWHRXTDUr?=
 =?utf-8?B?MmxDeXBmU1MyQ281WkJyUHF1bDZEcmZCMzZuTzJtb3d6VG94VGFwTWg5bHFM?=
 =?utf-8?B?TWNIWS9sa2h6YkFTYUlqUTFsd2VYUytqRFJWYzI2RU1zZHR4Z0FhZUxLR2ZO?=
 =?utf-8?B?Rkk4RjFMUnRpbWE4N3lkUDJNWEl4V3ZjWUR3cU1oTFFFS0IxemMxTTVoMTVY?=
 =?utf-8?B?d2I0ME45NTBtYnN0MWNnaWV2M2doR21vVjJQbUxneWl2MFJQamwyOStsbW5w?=
 =?utf-8?B?YXZvNHpuZENCNHc4TTAvMEduNU9JQUtQQ1p3enh4ZE40ZW55aHM1b1UwdWxh?=
 =?utf-8?Q?N14qLUep4jgQtw8Eo65OtZzOq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E152E9308C62F4F8CEBE4D2943E9C37@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9800c5c6-190b-48c0-c059-08dd1839a37d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 10:09:59.1590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDgXO9Vo6AHgkh/OuXnAXv7sD1wd04rrBZgbELvn8D41b0LSSLwrZFtvwnmor8RkfCCPkAg8OphkMLkViTle5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122

T24gTW9uLCAyMDI0LTEyLTA5IGF0IDA5OjIwICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiB0cmVlOsKgwqANCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdG9ydmFsZHMvbGludXguZ2l0wqBtYQ0KPiBzdGVyDQo+IGhlYWQ6wqDCoCBiNWYyMTcw
ODRhYjNkZGQ0YmRkMDNjZDQzN2Y4ZTNiN2UyZDFmNWI2DQo+IGNvbW1pdDogOTE4YWYwMjE5YTRk
NmE4OWNmMDI4MzkwMDVlZGUyNGU5MWYxM2JmNiBuZXQvbWx4NTogaHcNCj4gY291bnRlcnM6IFJl
cGxhY2UgSURSK2xpc3RzIHdpdGggeGFycmF5DQo+IGNvbmZpZzogb3BlbnJpc2MtcmFuZGNvbmZp
Zy1yMDcyLTIwMjQxMjA2DQo+IChodHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5LWNpL2FyY2hp
dmUvMjAyNDEyMDcvMjAyNDEyMDcxMzEyLm9ORm55VA0KPiA5Zi1sa3BAaW50ZWwuY29tL2NvbmZp
ZykNCj4gY29tcGlsZXI6IG9yMWstbGludXgtZ2NjIChHQ0MpIDE0LjIuMA0KPiANCj4gSWYgeW91
IGZpeCB0aGUgaXNzdWUgaW4gYSBzZXBhcmF0ZSBwYXRjaC9jb21taXQgKGkuZS4gbm90IGp1c3Qg
YSBuZXcNCj4gdmVyc2lvbiBvZg0KPiB0aGUgc2FtZSBwYXRjaC9jb21taXQpLCBraW5kbHkgYWRk
IGZvbGxvd2luZyB0YWdzDQo+ID4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BA
aW50ZWwuY29tPg0KPiA+IFJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVy
QGxpbmFyby5vcmc+DQo+ID4gQ2xvc2VzOg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Iv
MjAyNDEyMDcxMzEyLm9ORm55VDlmLWxrcEBpbnRlbC5jb20vDQo+IA0KPiBzbWF0Y2ggd2Fybmlu
Z3M6DQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9mc19jb3VudGVy
cy5jOjE3Mw0KPiBtbHg1X2ZjX3N0YXRzX3F1ZXJ5X2FsbF9jb3VudGVycygpIGVycm9yOiB1bmlu
aXRpYWxpemVkIHN5bWJvbA0KPiAnYnVsa19xdWVyeV90aW1lJy4NCj4gZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2ZzX2NvdW50ZXJzLmM6MTc0DQo+IG1seDVfZmNfc3Rh
dHNfcXVlcnlfYWxsX2NvdW50ZXJzKCkgZXJyb3I6IHVuaW5pdGlhbGl6ZWQgc3ltYm9sDQo+ICdi
dWxrX2Jhc2VfaWQnLg0KPiANCj4gdmltICsvYnVsa19xdWVyeV90aW1lICsxNzMNCj4gZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2ZzX2NvdW50ZXJzLmMNCj4gDQo+IDkx
OGFmMDIxOWE0ZDZhOCBDb3NtaW4gUmF0aXUgMjAyNC0xMC0wMcKgIDEzOMKgIHN0YXRpYyB2b2lk
DQo+IG1seDVfZmNfc3RhdHNfcXVlcnlfYWxsX2NvdW50ZXJzKHN0cnVjdCBtbHg1X2NvcmVfZGV2
ICpkZXYpDQo+IGEzNTFhMWIwM2JmMTY5ZiBBbWlyIFZhZGFpwqDCoCAyMDE2LTA3LTE0wqAgMTM5
wqAgew0KPiA1YWNkOTU3YTk4NmMxNjcgQ29zbWluIFJhdGl1IDIwMjQtMTAtMDHCoCAxNDDCoMKg
CXN0cnVjdCBtbHg1X2ZjX3N0YXRzDQo+ICpmY19zdGF0cyA9IGRldi0+cHJpdi5mY19zdGF0czsN
Cj4gOTE4YWYwMjE5YTRkNmE4IENvc21pbiBSYXRpdSAyMDI0LTEwLTAxwqAgMTQxwqDCoAl1MzIg
YnVsa19sZW4gPQ0KPiBmY19zdGF0cy0+YnVsa19xdWVyeV9sZW47DQo+IDkxOGFmMDIxOWE0ZDZh
OCBDb3NtaW4gUmF0aXUgMjAyNC0xMC0wMcKgIDE0MsKgwqAJWEFfU1RBVEUoeGFzLA0KPiAmZmNf
c3RhdHMtPmNvdW50ZXJzLCAwKTsNCj4gNmYwNmUwNGI2N2JhYTFjIEdhdmkgVGVpdHrCoMKgIDIw
MTktMDctMjnCoCAxNDPCoMKgCXUzMiAqZGF0YSA9DQo+IGZjX3N0YXRzLT5idWxrX3F1ZXJ5X291
dDsNCj4gOTE4YWYwMjE5YTRkNmE4IENvc21pbiBSYXRpdSAyMDI0LTEwLTAxwqAgMTQ0wqDCoAlz
dHJ1Y3QgbWx4NV9mYw0KPiAqY291bnRlcjsNCj4gOTE4YWYwMjE5YTRkNmE4IENvc21pbiBSYXRp
dSAyMDI0LTEwLTAxwqAgMTQ1wqDCoAl1MzIgbGFzdF9idWxrX2lkID0NCj4gMDsNCj4gOTE4YWYw
MjE5YTRkNmE4IENvc21pbiBSYXRpdSAyMDI0LTEwLTAxwqAgMTQ2wqDCoAl1NjQgYnVsa19xdWVy
eV90aW1lOw0KPiA2ZjA2ZTA0YjY3YmFhMWMgR2F2aSBUZWl0esKgwqAgMjAxOS0wNy0yOcKgIDE0
N8KgwqAJdTMyIGJ1bGtfYmFzZV9pZDsNCj4gYTM1MWExYjAzYmYxNjlmIEFtaXIgVmFkYWnCoMKg
IDIwMTYtMDctMTTCoCAxNDjCoMKgCWludCBlcnI7DQo+IGE4ZmZjYzc0MWFjYjNjNyBSYWJpZSBM
b3Vsb3UgMjAxNy0wNy0wOcKgIDE0OcKgIA0KPiA5MThhZjAyMTlhNGQ2YTggQ29zbWluIFJhdGl1
IDIwMjQtMTAtMDHCoCAxNTDCoMKgCXhhc19sb2NrKCZ4YXMpOw0KPiA5MThhZjAyMTlhNGQ2YTgg
Q29zbWluIFJhdGl1IDIwMjQtMTAtMDHCoCAxNTHCoMKgCXhhc19mb3JfZWFjaCgmeGFzLA0KPiBj
b3VudGVyLCBVMzJfTUFYKSB7DQo+IDkxOGFmMDIxOWE0ZDZhOCBDb3NtaW4gUmF0aXUgMjAyNC0x
MC0wMcKgIDE1MsKgwqAJCWlmDQo+ICh4YXNfcmV0cnkoJnhhcywgY291bnRlcikpDQo+IDkxOGFm
MDIxOWE0ZDZhOCBDb3NtaW4gUmF0aXUgMjAyNC0xMC0wMcKgDQo+IDE1M8KgwqAJCQljb250aW51
ZTsNCj4gOTE4YWYwMjE5YTRkNmE4IENvc21pbiBSYXRpdSAyMDI0LTEwLTAxwqAgMTU0wqDCoAkJ
aWYNCj4gKHVubGlrZWx5KGNvdW50ZXItPmlkID49IGxhc3RfYnVsa19pZCkpIHsNCj4gOTE4YWYw
MjE5YTRkNmE4IENvc21pbiBSYXRpdSAyMDI0LTEwLTAxwqAgMTU1wqDCoAkJCS8qDQo+IFN0YXJ0
IG5ldyBidWxrIHF1ZXJ5LiAqLw0KPiA5MThhZjAyMTlhNGQ2YTggQ29zbWluIFJhdGl1IDIwMjQt
MTAtMDHCoCAxNTbCoMKgCQkJLyoNCj4gRmlyc3QgaWQgbXVzdCBiZSBhbGlnbmVkIHRvIDQgd2hl
biB1c2luZyBidWxrIHF1ZXJ5LiAqLw0KPiA2ZjA2ZTA0YjY3YmFhMWMgR2F2aSBUZWl0esKgwqAg
MjAxOS0wNy0yOcKgDQo+IDE1N8KgwqAJCQlidWxrX2Jhc2VfaWQgPSBjb3VudGVyLT5pZCAmIH4w
eDM7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoA0KPiBeXl5eXl5eXl5eXl4NCj4gDQo+IDkxOGFmMDIxOWE0ZDZh
OCBDb3NtaW4gUmF0aXUgMjAyNC0xMC0wMcKgDQo+IDE1OMKgwqAJCQlsYXN0X2J1bGtfaWQgPSBi
dWxrX2Jhc2VfaWQgKyBidWxrX2xlbjsNCj4gOTE4YWYwMjE5YTRkNmE4IENvc21pbiBSYXRpdSAy
MDI0LTEwLTAxwqAgMTU5wqDCoAkJCS8qDQo+IFRoZSBsb2NrIGlzIHJlbGVhc2VkIHdoaWxlIHF1
ZXJ5aW5nIHRoZSBodyBhbmQgcmVhY3F1aXJlZCBhZnRlci4gKi8NCj4gOTE4YWYwMjE5YTRkNmE4
IENvc21pbiBSYXRpdSAyMDI0LTEwLTAxwqANCj4gMTYwwqDCoAkJCXhhc191bmxvY2soJnhhcyk7
DQo+IDkxOGFmMDIxOWE0ZDZhOCBDb3NtaW4gUmF0aXUgMjAyNC0xMC0wMcKgIDE2McKgwqAJCQkv
Kg0KPiBUaGUgc2FtZSBpZCBuZWVkcyB0byBiZSBwcm9jZXNzZWQgYWdhaW4gaW4gdGhlIG5leHQg
bG9vcCBpdGVyYXRpb24uDQo+ICovDQo+IDkxOGFmMDIxOWE0ZDZhOCBDb3NtaW4gUmF0aXUgMjAy
NC0xMC0wMcKgDQo+IDE2MsKgwqAJCQl4YXNfcmVzZXQoJnhhcyk7DQo+IDkxOGFmMDIxOWE0ZDZh
OCBDb3NtaW4gUmF0aXUgMjAyNC0xMC0wMcKgDQo+IDE2M8KgwqAJCQlidWxrX3F1ZXJ5X3RpbWUg
PSBqaWZmaWVzOw0KPiANCj4gYnVsa19xdWVyeV90aW1lIGlzIG9ubHkgaW5pdGlhbGl6ZWQgb24g
dGhpcyBwYXRoIHdoaWNoIGlzIG1hcmtlZCBhcw0KPiB1bmxpa2VseSgpDQo+IGFuZCBub3QgaW5p
dGlhbGl6ZWQgb24gdGhlIGVsc2Ugc3RhdGVtZW50Lg0KPiANCj4gOTE4YWYwMjE5YTRkNmE4IENv
c21pbiBSYXRpdSAyMDI0LTEwLTAxwqAgMTY0wqDCoAkJCWVycg0KPiA9IG1seDVfY21kX2ZjX2J1
bGtfcXVlcnkoZGV2LCBidWxrX2Jhc2VfaWQsIGJ1bGtfbGVuLCBkYXRhKTsNCj4gYTM1MWExYjAz
YmYxNjlmIEFtaXIgVmFkYWnCoMKgIDIwMTYtMDctMTTCoCAxNjXCoMKgCQkJaWYNCj4gKGVycikg
ew0KPiBhMzUxYTFiMDNiZjE2OWYgQW1pciBWYWRhacKgwqAgMjAxNi0wNy0xNMKgDQo+IDE2NsKg
wqAJCQkJbWx4NV9jb3JlX2VycihkZXYsICJFcnJvciBkb2luZyBidWxrIHF1ZXJ5OiAlZFxuIiwg
ZXJyKTsNCj4gNmYwNmUwNGI2N2JhYTFjIEdhdmkgVGVpdHrCoMKgIDIwMTktMDctMjnCoA0KPiAx
NjfCoMKgCQkJCXJldHVybjsNCj4gYTM1MWExYjAzYmYxNjlmIEFtaXIgVmFkYWnCoMKgIDIwMTYt
MDctMTTCoCAxNjjCoMKgCQkJfQ0KPiA5MThhZjAyMTlhNGQ2YTggQ29zbWluIFJhdGl1IDIwMjQt
MTAtMDHCoA0KPiAxNjnCoMKgCQkJeGFzX2xvY2soJnhhcyk7DQo+IDkxOGFmMDIxOWE0ZDZhOCBD
b3NtaW4gUmF0aXUgMjAyNC0xMC0wMcKgDQo+IDE3MMKgwqAJCQljb250aW51ZTsNCj4gNmYwNmUw
NGI2N2JhYTFjIEdhdmkgVGVpdHrCoMKgIDIwMTktMDctMjnCoCAxNzHCoMKgCQl9DQo+IDkxOGFm
MDIxOWE0ZDZhOCBDb3NtaW4gUmF0aXUgMjAyNC0xMC0wMcKgIDE3MsKgwqAJCS8qIERvIG5vdA0K
PiB1cGRhdGUgY291bnRlcnMgYWRkZWQgYWZ0ZXIgYnVsayBxdWVyeSB3YXMgc3RhcnRlZC4gKi8N
Cj4gOTE4YWYwMjE5YTRkNmE4IENvc21pbiBSYXRpdSAyMDI0LTEwLTAxIEAxNzPCoMKgCQlpZg0K
PiAodGltZV9hZnRlcjY0KGJ1bGtfcXVlcnlfdGltZSwgY291bnRlci0+Y2FjaGUubGFzdHVzZSkp
DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0KPiDCoMKgwqAgXl5eXl5eXl5eXl5eXl5eDQo+
IA0KPiA5MThhZjAyMTlhNGQ2YTggQ29zbWluIFJhdGl1IDIwMjQtMTAtMDENCj4gQDE3NMKgwqAJ
CQl1cGRhdGVfY291bnRlcl9jYWNoZShjb3VudGVyLT5pZCAtIGJ1bGtfYmFzZV9pZCwgZGF0YSwN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXl5eXl5eXl5eXl5eDQo+IA0KPiA5MThh
ZjAyMTlhNGQ2YTggQ29zbWluIFJhdGl1IDIwMjQtMTAtMDHCoA0KPiAxNzXCoMKgCQkJCQnCoMKg
wqDCoCAmY291bnRlci0+Y2FjaGUpOw0KPiBhMzUxYTFiMDNiZjE2OWYgQW1pciBWYWRhacKgwqAg
MjAxNi0wNy0xNMKgIDE3NsKgwqAJfQ0KPiA5MThhZjAyMTlhNGQ2YTggQ29zbWluIFJhdGl1IDIw
MjQtMTAtMDHCoCAxNzfCoMKgCXhhc191bmxvY2soJnhhcyk7DQo+IGEzNTFhMWIwM2JmMTY5ZiBB
bWlyIFZhZGFpwqDCoCAyMDE2LTA3LTE0wqAgMTc4wqAgfQ0KPiANCg0KSGkgRGFuLA0KDQpUaGFu
a3MgZm9yIHRoZSByZXBvcnQuIEJ1dCB0aGlzIGNhbWUgdXAgZHVyaW5nIHRoZSBzdWJtaXNzaW9u
IGFuZCB0aGUNCmNvbmNsdXNpb24gd2FzIHRoYXQgdGhpcyBpcyBhIGZhbHNlIHBvc2l0aXZlIGZy
b20gU21hdGNoLg0KU2VlIHRoZSBkaXNjdXNzaW9uczoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L25ldGRldi8wZGNlMmMxZDJmOGFkY2NiZmJmZjM5MTE4YWY5Nzk2ZDg0NDA0YTY3LmNhbWVsQG52
aWRpYS5jb20vDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvNjZjY2JiODQxNzk0Yzk4
YjkxZDllOGFiYTQ4YjkwYzYzY2FhNDVlNy5jYW1lbEBudmlkaWEuY29tLw0KWW91IHdlcmUgYWxz
byBwYXJ0IG9mIHRoYXQgdGhyZWFkIGFuZCB5b3UgcmVwb3J0ZWQgbm8gaXNzdWUgb24geW91cg0K
c2lkZSBiYWNrIHRoZW46DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvZmNlY2IxOGEt
MWEzMC00MDBkLWI4ZWMtMTgwNmQ4NTZkMTQ1QHN0YW5sZXkubW91bnRhaW4vDQoNCkkgYW0gbm90
IHN1cmUgd2hhdCB0aGUgY29uY2x1c2lvbiB3YXMgb24gdGhlIFNtYXRjaCBzaWRlLCB3aGV0aGVy
IHRoZXJlDQp3ZXJlIHBsYW5uZWQgZml4ZXMgb3IgdGhlIHdob2xlIHRoaW5nIHdhcyBqdXN0IGZv
cmdvdHRlbi4NCg0KQ29zbWluLg0K

