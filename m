Return-Path: <linux-kernel+bounces-319414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D0396FC4F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC5D1F268CC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268AC1D5CF2;
	Fri,  6 Sep 2024 19:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sLze2iWS"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6011B85E5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 19:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652023; cv=fail; b=bPqLSxCUnovypFgBYojktgbOGDPS8/uWOUgAfdbPTy9LU44LR1m8LK7GGoKRhwG+DUvYIaT47jnsVH+belIx0CxH9pxvAdC8bga5qA1CeFL8BFd2MCvBAxFwuwZEzjMmDnXKNUjnoeAEeOuc17A+r4KBansIAR7hAH3nYd5Iip8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652023; c=relaxed/simple;
	bh=9J59WB4zjSFa23CbowVcc5u+DDQYOhk99XEB0yl4GMs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SYh08/c7979qIO55CUz+iEyd+Mp79YkRVxI599IXnyGIuqNz4xoS6CX/dmUeExVZnHNXLRfmLHp9/yTFxfw1//Cj0Hgcb22dWhaM5qmgX/d707BSlYSxaB/IpekPXYFCnfcwOMgI8ic+nRyvY6tBEKJSKZMOZwRxL72Vm8bQ2zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sLze2iWS; arc=fail smtp.client-ip=40.107.100.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ki0IeeWNkv6n2MIbJvCRGWCh8YSE25bdNa/pTiPDRsU6khoUKWrKiMLpHb49MqjbbIytq5FuCeAzvMxWLPa9tQOJBI0cmJ3VFJ3700sC1CfY1T1SAs2THw/Z60/q8rElz1nQimtkdffaaVhVWD+onOycJt1RivXtmKV/FaXBOJWjiIgjJEtDBqCr81VaI0C0OFurr0S5bnuBdWlMHpduIxNfyfznzpf1d1QA1eASr96qLhU79ou6G3tppshBDqlEAUcQOGqAG/dQyaeWb4B6ABxAJuKWcayKXIUq+dcXX+kxd5b2XsunMs6QCdsQUoJdWRTetc9XPkLHBE441bKhtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX6gHiH7tP5GbkHJ7eVxYQTLwTsuh1Fd0bfZcCmvOp4=;
 b=bWVSa0FSAexrVDN2uBsg/8b6LNJWHTF4q9l5s6PoZzPpHlUe/3sSQPdkbhbHp4e/ufpM23UZ3anZht8upUKNyZPLuabQy9MQCXu4rr+UmfoO+ToAyNrgAUpiT70xtM8kCaGmY02cVBcAkAWZqe4qkmrysuVQA2/J524QjJVO20BnVMmenvvzJMtBwqiug5S536JBJaAteteuNM0rrQgwMf5C5iqV9EVFUAH9i7w8dAWVGPXTM3qsTuMjgKPcXoK+jBlZoR2pToFMDXNnYMp7rsleXnHpZXw9+l3OLZot1NIJc/C5funx8cQ5TKL4I8px4wFY8hzu3BkFrkTI+2DHvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX6gHiH7tP5GbkHJ7eVxYQTLwTsuh1Fd0bfZcCmvOp4=;
 b=sLze2iWSoWuc76ZozOaXVx84EXXNNl38+15t7HA/rYS14tCKAjIk9OkOAf5oTHEnOJXNOo4nxSizvs49EX9hXILHFKvXMmgdm9ApV97xPXw56ZRb/NDmo6NgrNIoRTmKuYeNYRqSU1HYpvMajsRX5R8ivX2sD+VuhS3MKwNOYMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Fri, 6 Sep 2024 19:46:58 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 19:46:58 +0000
Message-ID: <04d3755d-f295-46d7-b35d-008b888b39ae@amd.com>
Date: Fri, 6 Sep 2024 15:46:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: 6.11/regression/bisected - after commit 1b04dcca4fb1, launching
 some RenPy games causes computer hang
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, zaeem.mohamed@amd.com,
 pekka.paalanen@collabora.com, "Wheeler, Daniel" <daniel.wheeler@amd.com>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <CABXGCsNgx6gQCqBq-L2P15ydaN_66sM9CgGa9GQYNzQsaa6Dkg@mail.gmail.com>
 <CABXGCsNztS8MLteq5=fcddwuQ1TCzeOM8TdVtpJ3crK=sV5PTQ@mail.gmail.com>
 <CABXGCsMdxHJ-MLkS0pm51Sk8g0PTghsuZxmowvj5t44bVN4ndA@mail.gmail.com>
 <ffd2c40c-1c2e-4465-b26f-88d5e08a80d9@amd.com>
 <CABXGCsOoL5vD0+FRALFQFr3ZBpb2z5mpGKzAD5RHoW9_sb5yaQ@mail.gmail.com>
 <f68020a3-c413-482d-beb2-5432d98a1d3e@amd.com>
 <CABXGCsMSTsBFW=OirDszPFVOiNgyOBSh3qyzAw-Coi-McnicAQ@mail.gmail.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <CABXGCsMSTsBFW=OirDszPFVOiNgyOBSh3qyzAw-Coi-McnicAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::14) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8e9afc-91e3-47ec-776c-08dcceacab0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWl6aGtCeE53bnNiclFXaGQwaWZVRDRONHFGLy84K2xxa3BLOFVNVUlsU3J4?=
 =?utf-8?B?c0lHV1g0aFBKQ2VvZGIwWWg3WVdOeUR4a2RzbXMyR0loK05SOFpUL0VvTDJQ?=
 =?utf-8?B?MWRvMjBZaURtVnpPQWhwdFF3dFRBd1UwTDBtUGpXelJtNVhMWUhrUzNjTk5y?=
 =?utf-8?B?UHpxc1ZNYnlrT2ZEVHR3anhQRFRDYTh5YnJWeEY3QjFieU1xSTMrSUl2Unlq?=
 =?utf-8?B?UGwwS3hFQ2YxY01JRGJ0NDBrODVzZ0R3YmhTdW53YjZnak14bk96ODNxUCtL?=
 =?utf-8?B?RERvNzhCa0ZaQm5QV0hEQndscEMxV3Uwbmh4QTVTQ200azYxN2FUOVZqa1RT?=
 =?utf-8?B?cmhNWGplb3RVTUgzbjV0ZUwxYVRCYlZlZGlkTjdQRVV1WTk1bUV1VHRLb0ZZ?=
 =?utf-8?B?NGdlYzZrRVdzd2tJWnQwVzJWNk10TFp0MDh0OFFQOUk5WHY1aVoxUzVqWTg0?=
 =?utf-8?B?cXlDMkFCaEk1YW5md3ZORjVuR1ZjbTVtNDY0K2h3Z0NkK2JwOGtnTnA4ZjZU?=
 =?utf-8?B?SDlHQUs5ZGZsSGVkdUJWbXY5S1NDY0U4WEtPbzFSWnRpcUNuUGRPa3M3NGFv?=
 =?utf-8?B?c1FyaDFyMEkwczhuTUl6U082T3ljZHorNllQZEJTUElZL21XQk1vMVl6a3A5?=
 =?utf-8?B?ZStXRXM4T1doUTU3MldNRzN4N3hjZ3FjNkU2bEo4NFJQVjQ0NGlNVjN3SHQr?=
 =?utf-8?B?d3lRNzBWcHBxOXNpMVpnN2g0YVAvNXlUb3Y3YVpLSVpsai9QMGVrQnlFMU11?=
 =?utf-8?B?ZjFyRkJKSWRLbURTYTVEY2FLV0NDVHhkT1FZRWZBbk5kUnpCTTJvSlhNS3BL?=
 =?utf-8?B?SS9zaFNuekFvQWtyMGd2WFdLaFhiWThJV0ZLZm5zaGtMWVpubzVYaDhublMx?=
 =?utf-8?B?ZUtZOGJFWlRtNEgvYXB2c3JuY0pJS1pCaStMVUtOTTNKaFAzVXVod0xXbTVn?=
 =?utf-8?B?Z1hwc0FWOENrYlpqNmhwaGF6YlpHVGgvRXBaTnlWNm5MWUpoNDJVTlRBZ3R3?=
 =?utf-8?B?TDNNNmIyR1o5Q25KK3pXUVRlVmRVV0RWWllyKytzSHBqVWk4TE01aDhGaXpC?=
 =?utf-8?B?TzVkVGRIWXNjdmZJTno5U0R6aW9BYUc4ZzM2eDdLdjdkOU0vUTdNTkhKZ1pW?=
 =?utf-8?B?UDIvSnpiS2lVLzE4YmNhNENuZHFrb2I5MmNSN0pQN1N3NlFueGVaNzkrL21G?=
 =?utf-8?B?OXU3emZVRTYreGo0aDRIY0NST0JKcXJEYVAzQzByaWtPc1NNNG1KbmFjRUdM?=
 =?utf-8?B?Um94eXpqZ0VWbFlaQ3hCR2FPNDlSSkFFbWQwNTRnRm9PUVYvSVZSWERhOFZj?=
 =?utf-8?B?bUtlVTFEY3NUaE1lcWpBdDhkZldtZHFiandOeVFwTnNGVmtmb0Zxb0xaeUY1?=
 =?utf-8?B?a2ZhVlJyajlSTlNHVTlJdFkzVk4vblBCbFhITVVLRHRSdHpqZHNZLzhrQUVF?=
 =?utf-8?B?QXI5cWRYYjl0eGN4aUlpek5QemtqOWdEbVpYb1VnckxnNXNHcGpuVWc2Z2tW?=
 =?utf-8?B?NGRHdTJHc3dNVUtQV1hmdXJ6cjA1a2VxdlpZQXh5eXVkL3BIWkY2LzJzbTBT?=
 =?utf-8?B?WEtxYitVQ1pVellHZ3g1dFg5Uno2RFJoZkxHVVFYL3loeUJEZ05vL0NRWExL?=
 =?utf-8?B?QWJSV2xWS3hCU2FjMjljemdiaUxOWWxEVzlZd0s2cVZwRW96dlJyd2dMLytO?=
 =?utf-8?B?YnpuM0wxemZ1SVdSOGVCMDRBYnNIVzBNVHRud3A0Z3JXREJOTHFFYjZNK05R?=
 =?utf-8?Q?/q/ZPwQPP9+94hC9wg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5311.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T29rbDJnN053b01qcmx3Z1ZDQ0ZMMVkxTVRHQXpWNXp2N3dYK2g5dU1VY0VL?=
 =?utf-8?B?cE84VEUxQUU3VXBtMEFhdFhnZ0d1ZDl3UVFZeVRoaW9MYnNTYnF1NUpyT3Bn?=
 =?utf-8?B?T3Y0cko0RVpWT2tKRjZxa3dsdHViaEl3bVArODFFZjdTOE1IenBvRmVvTXJO?=
 =?utf-8?B?WXhDbkxlSFlkTkF1MVBXdjJaeU5HWHNncHJZdVlYeHRvRFRlbkdxcGFUUEFZ?=
 =?utf-8?B?ZzNrUEJSWEZJNUJ6STA5MHhrbld4aXNRU1EzNTFUSzVmNFQycFZHZmxGcC8x?=
 =?utf-8?B?R0RDbWlQa2MyNkgrWXhNUXFFTldPSm92V25ZMXFLQks2d1kxOExRK3BzQUdL?=
 =?utf-8?B?QzlhZ294M3JPc2w0alJ0N1RiYTdQK3BGZ0trOVRGazlGZ08vRU1Gb1hDaUJB?=
 =?utf-8?B?QTM1VC9leU5weFlzaDNva1gyd0ZFT1NvVThZcGUxaTJIU2lXT1RBY0p3T1NS?=
 =?utf-8?B?WnpTSWdUaEN3bVc0d0c0a2Q1SUQ1UmNFbkFzZVVhWmdzUHl5S2NveGxkMGN6?=
 =?utf-8?B?clc0cXc1TzFIci9XTXlGdEVyYi9Xakp4K1lHaTg0TVdxakpwaWgvSCtkN245?=
 =?utf-8?B?QlRsSDk1MmFYSndpRi9HUG1pL25EQytnN24wSTB6Und5M0wyUGQyNlpCMFJW?=
 =?utf-8?B?eTNDTlNNemFYa0ExYWpsemlWRlRZYzBiOGtKL0pNWkdhSzVyNWV1Q1oyTVdo?=
 =?utf-8?B?d1pJMFQrVkphWXBIdHk1NjYvWlkyNzh6ZFRNRU5EWTNqd0xEWnZhTFBDOG8y?=
 =?utf-8?B?ZXhsa2wxNnBxVmowNmtUelMwWnYwTXpaT0VVUmdrNlByZWZvVzhqbU1jbEV4?=
 =?utf-8?B?b1lsM3UrRUR2MkhqZDZDUXdnNzZvdjM3RnQyTEhRY2l1S0JKTVJCWHp2aEhj?=
 =?utf-8?B?WG9hbHMyQ2tLK3dmWUZCR3VQZENINXY2eXk1a0dwWS9UR3FubGpXR1N3cWt1?=
 =?utf-8?B?cEhwVSsyY1AyK2dKWnRHcWcwc2NIWStVODVSQU9GUmFaaXVBUjNTblJUVS9q?=
 =?utf-8?B?TTN0NXFqWEh1dUErOTRmUUZoN2psaDdPZUpONHZhTVVra04vRVR1WDBFdWZL?=
 =?utf-8?B?ajU3MENQQVJvRzgrZXh6bmZIK2FnQW1qd1crQXZFQS9paHlNQ21jTEtOdHgv?=
 =?utf-8?B?MDdSUWp2ckdyVHhSRFBCRGxxNSs3dHE3NTdlNi9NWVZhZHdMdkZ3TllINGpN?=
 =?utf-8?B?bi9rRGVicjBvVWV0dUUxTTZMak5ydDlXVExpRldXNWNpSnVqM0YwR3FWV2xO?=
 =?utf-8?B?ZHFaT3JkSDJEOE1nVUUrOGV5RnNTMkthdjAvSHpkOWt1eDhPRjZPeUpsL3cy?=
 =?utf-8?B?K1BQM2YycUE5ZnU3RWlRYkdEUGttYmVGdkVlUHNkdmdiRmhrRXJhREhMbnBj?=
 =?utf-8?B?ZE1uRFhMVFlPdUtYTzBTOVh4aTBuMmZ5cnVKOS9MK0ZteS9vcklmamg4Zmk5?=
 =?utf-8?B?ZHI4QUFsZ1FKV28yK21HaGk1L2RGOGR3aGhxTG5YRnpRbytpREhMTGJhVjIx?=
 =?utf-8?B?a1pXOFdJSStxVlF0bmU3QWFZTDZzTjM1dUxUZlVUVGVBbjhIRDZyRUQxWFBj?=
 =?utf-8?B?WmVsalVCNW9JbFZua0dOUnlxenZIUnJ2N1ljVW9MeHpqek8zbWIwSnhWanQ5?=
 =?utf-8?B?Z2pkVUZUSXdmWFo3a1FuS1dXTzBVOTFFNDZkeVc0My9hY0RmOWx2aFo1ZDk1?=
 =?utf-8?B?N0JjY3hEenNWYVpqbmFvL05BbWx1SllTV0RmZWVNYlBsdnVlczc2Y0V5czhS?=
 =?utf-8?B?U1l4eFVVSWhZQm5JcGd6QmRoek5iRWxNNnhDYzNDRk9NbmpYbGpKelJzdWQz?=
 =?utf-8?B?ekY5VlM2N1ZicDFwaGJMVktFUXlLUlR2NUZIb1htRVZ5dWNXTWlIOFp1V0xG?=
 =?utf-8?B?ZmptcWRXeEFEQ1Jjd3BQZ0Fmc3hLVjlnWmFhVjIwTGUxcDhHYVhwRXZGVmFi?=
 =?utf-8?B?aGRBWkRZRnhYK3BUNkNVaEdKTWNQTFBRck5oNnI4bEhIZ2NtM1pDc2RKWjB4?=
 =?utf-8?B?VVlpU2txNHlXcVA3SFFidUtjZmQvdzNJa2lER0E2ZUR4QnUwdVdCdEJmc28r?=
 =?utf-8?B?MG90N0I1MUFyNEJiYko3bU42VU5USkNHbWJkY0pnYTVVQnVoZ2hXMU1VZnd2?=
 =?utf-8?Q?h8LtFSUh71haJAKn2eM4/lpXK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8e9afc-91e3-47ec-776c-08dcceacab0f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 19:46:58.1694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aP/c5L4fUbDRdWP5LREJJgcNSxQVpVBk2kDt7rPeVtVCGzq+FYzWYrh1ovd16l/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243


Hi Mikhail,

I've tried to align my system with yours as best as I can, but so far, I've had
no luck reproducing the hang. A video of what I'm doing:
https://youtu.be/VeD-LPCnfWM?si=b2baF8MyDBuU4jRH
(Under the hood, the W7900 and 7900xt should be the same)

I have a few suggestions:

First, can you also open an issue on the amd gitlab tracker? It gives more
visibility to others, and makes working together a bit easier:
https://gitlab.freedesktop.org/drm/amd/-/issues

Second, can you try adding "amdgpu.dcdebugmask=0x40" to your kernel cmdline at
boot, and see if you can still repro the hang?

This setting disables hw planes. If it resolves the hang, then it's quite
interesting, because it suggests that gnome may be using direct-scanout via hw
planes. We may need to align our gnome configuration in that case, since I don't
see any additional hw planes being used on my setup.

Third, in case these two issues are related, can you give the attached patch on
this issue thread a try as well?
https://gitlab.freedesktop.org/drm/amd/-/issues/3569#note_2558359

Thanks,
Leo

On 2024-09-05 02:06, Mikhail Gavrilov wrote:
> On Thu, Sep 5, 2024 at 4:06 AM Leo Li <sunpeng.li@amd.com> wrote:
>>
>> Can you delete ", new_cursor_state" on that line and try again? Seems to be a
>> unused variable warning being elevated to an error.
>>
> 
> Thanks, I applied both patches and can confirm that this solved the issue.
> The first patch was definitely not enough.
> 
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> 

