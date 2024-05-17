Return-Path: <linux-kernel+bounces-182421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6688C8B11
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642D928402A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B14313DDBA;
	Fri, 17 May 2024 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="r6c2i1+w"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2114.outbound.protection.outlook.com [40.107.102.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE1413DDB0
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967334; cv=fail; b=pvPDCaxKx3qNakRKsIOhHBEfLVjinbTkuBlyVEJkWniQibl307zW+Ylh/UDxGMwGvLGgnAi3ZctMJImHcrUVzF9ZpbaT+aUXANAd6dUee1DJd63FhLHRqzyIQF3cdCE+m0XmSeniv4vFw8yf3vxYAf/8AgaRBtzgLBg7A2jJF0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967334; c=relaxed/simple;
	bh=1I9kl8WP7fV6nCSavxN2vGbS3OvU05I2v13BDHydp18=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fKonVbp35N9OB32hJSUzGCu/X3DpoIoMuPONn6ELiuNxa6+o6rLX5pkS3Ktk6OTcO5K5eIdXFU5KUMTpMcdtIfeXqlVn4NBTJjCqcKEwbsLrZoDdG0/1/s8mQOPQrdVkVjHQ6fIS0QLBdiIa5rJbsSoTGvKGfuQ49QeUQD/y86Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=r6c2i1+w; arc=fail smtp.client-ip=40.107.102.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MT9aiJyTFnggksZaHmqyqGMMREyhmAp1SSShpaGX/DiC1lY1lhbsvuhhPPtoFOZodMo6h9FO0o57ItaSoJLGM2ReUW6VUCzTVkgU4CAyRA8dLwsmtD3rw3WGn5ezSnRevdQ8IcbPdlrsxXbEYORLeAt13wtSYYdTg3S3BQ/wfNA7VIs9m+z5+u34ObhVd8HAyg4dU5L7IlhrEPFTlxmUEVxuBiAxKSTmXw9GImiDrrwsVqCIj+uCcX+PCdwbAE/zb2uhz8P5SWCLU18SEicgyeVirM7KuVe6kev5dH7QmmxdiNSYv58k31bEqbpI7+noCSVqboZvAyVUEKbg6X3xjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjxvKcx9S4jmgEU6UTIhbaqPTa9K9j/cS6fufL7+FHg=;
 b=dg17KIshnPU7LsvlPRbusNHmBTU6lANRoj/ENKyCqNGAUT4NCIljKf69MVWmRequDfu4uDlWsq37f/r/dKWlL4G+xUcDezq4wsuSb5BgFdOJWSUkDQlioW66ByL471FTmT9IV3jcroMdT7rJdyg8EbCEY4ILaqG45wVZA4BySfR4yDLPnZJ4S4xtkTz5/jxJNc1p5PH6W7PT03D/P9hr2urRjtoPrUbsbLHyey+J1eo7r3Hfo4AiN6oZfEq2KJTr5scuAgbs6ys1VrdVnlK+7QT3yq7Z7qqAA6lKXGmksBqmz+A8bohDx89EEpc7amVjCtfWglRyrEAs5Icvt1cZMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjxvKcx9S4jmgEU6UTIhbaqPTa9K9j/cS6fufL7+FHg=;
 b=r6c2i1+wKfd62y3VDZwM4lgaj6wQxeGwbvNL4PJQF8MGZKW6E2ZIQwXPPRUHnJobHcaio7+zXYQGLfHhxyIM5b9vCN2Nh2aa3eXUG7qPN/J//SFEgxNkYUszRCsFaw1XrIW+q6YwzZuDbAIiqi51anYLGKLtXdzsxp5Ooy390RE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 BL1PR01MB7867.prod.exchangelabs.com (2603:10b6:208:39e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.30; Fri, 17 May 2024 17:35:19 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%4]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 17:35:19 +0000
Message-ID: <85ecd9c7-8fae-4265-a240-88db54b88602@os.amperecomputing.com>
Date: Fri, 17 May 2024 10:35:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: force write fault for atomic RMW instructions
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: peterx@redhat.com, will@kernel.org, scott@os.amperecomputing.com,
 cl@gentwo.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240507223558.3039562-1-yang@os.amperecomputing.com>
 <Zj4O8q9-bliXE435@arm.com>
 <6066e0da-f00a-40fd-a5e2-d4d78786c227@os.amperecomputing.com>
 <ZkM_WXxEQo51mrK5@arm.com>
 <570c686c-6aa1-43f0-ba31-3597a329e037@os.amperecomputing.com>
 <ZkeTFiF_OOy80stO@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <ZkeTFiF_OOy80stO@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0015.namprd18.prod.outlook.com
 (2603:10b6:610:4f::25) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|BL1PR01MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: 1175b2bc-3a52-4a07-edd4-08dc7697b8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGhTd2REOGVqTmdlLzFSNEx1bzdhSktqUjc3cFppQ3ZiYVVYRW9PWUJqd3pW?=
 =?utf-8?B?U1JZWWJUcHlPZHBSZERJbDVQOUFnTEg1d1NvTFd0SXh3cXpQTWtSSW4xV3pr?=
 =?utf-8?B?V1ZJd044TDhxTm9OVzFqNnNPRWdOaHhxc1gwTFBXb1R6V1AzR0FtZlB4ZUJG?=
 =?utf-8?B?MGErdTVjU25peTcyTE9RWWFTYStSYUJoNGVORTdnWWJOSkNReGZqbENEM0N5?=
 =?utf-8?B?a1pUMEQ5aDQ3VnJ0N1JxMkc0VVNaYlN0SzNnY3k2S1FJL1c1Qk9BM1J3RzRj?=
 =?utf-8?B?YlE1anM1TGF0bGpGSjhBTk0vclpYWUZHdUdzT3Y2YlRBVmYrZDdFckhFWk5F?=
 =?utf-8?B?anZBSUw5Yk5jby82YTc3dG90RmdIKzRSMGZjVlRORk0zWDBrUEhGZDdOc0VZ?=
 =?utf-8?B?MGFIUXVKTzJHeXdOM0IyY2tVZzFiVkhaLzNnTEJlajJwSDkrQ2NwS2lJMzNO?=
 =?utf-8?B?RmU2MHBzRkFVT2JOQy9SWjFmNTJrZEFsWGdpMXN5N0JaZUxSTWZhODVSb2Qv?=
 =?utf-8?B?WTdYUC9ZdDRYL00xOWc4R0d5a2VLd2htMjBYVmJYOWtWTHUxUVg4a2NTNklY?=
 =?utf-8?B?Z2dLd0lRbXVDdHNUQktoY3BZSWtYSEpxaWdtSzcxUERmWGpVVHd2Y01LWXdP?=
 =?utf-8?B?WU9MV3VGV1VETEVXb0FNMStrRGdEWXJ5Qm55aXE3N0xMdG52dXF5T2RHRnVq?=
 =?utf-8?B?OEdSYUpTSW15QXljTGQzY2Z0K3lPSFhzVU5xcCtTZDI2ZllmTFBXdE1xVUxw?=
 =?utf-8?B?VFk4WnA3Q0hNZ283Ly9BcDJlbkZKTEZxd1g2ZW50VXV1N2t2OEJDTkw0bitl?=
 =?utf-8?B?RnFtQlF1YWh0U0tVL01Scm8rekRnd0tvc1kzeEtJNll2amdxUW9wYTN0Tmp3?=
 =?utf-8?B?SGUrVFZ1bHNUS0VhMEk5YzFxUXgwamJMb3BHRkd1RisyZk9USkx6UUtwdy9P?=
 =?utf-8?B?bVIxUUIyWHBGV3cwVDhBWmI2ZUh2eGxxazFmbDQ3TGVxMVpVQy9OQm9Dak5L?=
 =?utf-8?B?TFUxOWVVZ2NBdG1qcHJ4dVlJT1VDYlpiYi9FMHowTTVxdmgxMnBSQVY4SWl0?=
 =?utf-8?B?MDNoVVQweWVrdlFJZ0JSRW9uYTE1QXZqVTVraFpSalA1L2FrUyt4QVluK1Vm?=
 =?utf-8?B?QXJpUVQ5UktvbUhtN3hsL1NhLzFXdnBiTUoxeVNINzdPdElZZWJWVVJaSzR6?=
 =?utf-8?B?dmJQYnBObXVDVDgva3p5ZTFtdHJGU3dJdmdTS05YSUw2bXhya1BNODZmQThs?=
 =?utf-8?B?OGR0R2FHY1ozTTgzUjJWOWpyNDNLR3dXOTRKTDJDOW43NEFWUC84TTJJMDFT?=
 =?utf-8?B?M2FJdnFXT1RqaHJoS2ZiWTNvcUhrckNmWlczRVE2eGNBOVlQUU1OTnQveG4x?=
 =?utf-8?B?djZUbEhmQmZoVit2ZHRDRFdOcERENnArMkowdkdWcGo0dHBhMHA1NFNxMStP?=
 =?utf-8?B?aEd0eHE4RmlUQXVPakluK2M1djlsU0U5OFRhd2JNV3cyTWx5MWdRM2ttMUo4?=
 =?utf-8?B?RmZZTnh1Sm9yR2xCWVNmaXJxSVBIcFFBRWs2S2s2djRzMXFCN0hEdkRwQUhy?=
 =?utf-8?B?Z1VvWUFEYUxSZng3VlVqak90YjBJaXVWaVRSTU85SzQrdjhyS1REd1VQMTJO?=
 =?utf-8?B?RmY4NGRhcndKMTZhVi9qVmh3SUNqRVY3VUVpaDFYb1ZmcW1WTFRjUlhGcHd2?=
 =?utf-8?B?R1lVZnpWbi9kU3ozUWU0UjJnaC85dEZsNXFjdkNmV2dGR3BBL2gwM2ZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkdHWC9YQ2NqdmVrb3JZNUFNZVJWa3NTRGJ1TnpQd2Rkc2lWUFU4dEZEUE40?=
 =?utf-8?B?ZGNBZmdKNHBiUHUyRjdtUkZkbXRnVzlvSklVSzR5UTE0eGpNaFRHc0ZaMmtv?=
 =?utf-8?B?Z3JuYnM2UVVaYjRtNTEwNEZ5M1VaSkFvZ3pwZDZOMjVhcE5rYXpkK3MxSGpp?=
 =?utf-8?B?bklSRU52TVdBNVpPd3Y3ZERGQjlndXgxOGx3MlhQVU93VDdmNkNOeVdnU09t?=
 =?utf-8?B?eDlLWFJQZnZ3cFNOY1NzM3I4Nkd3bW5OcVdKN29uTGx5ajBGTnBhZDFiVit5?=
 =?utf-8?B?L3lTdjlWc3NJK1lzU3VaNEpiemJEa2Ivbkw0OUR4SjBGc3dRdUxmbE1qZkQr?=
 =?utf-8?B?M2hOOWVMNDZvNkpGNEwvM1N6Y1Z6enJ6a01SMEZhVkdKaHhjUUlKZ3RhNkV6?=
 =?utf-8?B?NVQ3bUFUVjJ6YTBhU2tnaUFpemx5YUlJeCtsS0ZTbTlRSDF0cjBzekJUYmRQ?=
 =?utf-8?B?QnpSZkM5U0dTV3VNRGhOVXVYVW5kSFJ4dTBYWkNiZUlQNWdsdzJQd1ltdGNv?=
 =?utf-8?B?UkdSdGUxUDFNMkNXSXhjQVhHMFNCUWtiY0pOYjRYOGQ0ZjgzKzNRZGQ4K2FV?=
 =?utf-8?B?RnppbEptTG5ueHAvRHlzZ3Bkd3NsdzZJYnlObWhPTFVzUUFoV1Y4MUsxSGpB?=
 =?utf-8?B?bVlySHNGZjNKeFhxd1dPZVdYd2ZtWTRYc0hzZytrTUJrOGt3TWFEbHV5bVBx?=
 =?utf-8?B?WDlrRzlld3NyOE9jdk5nMGZJOWNKYlg4RnVqRDRuK0xQb1dyNGQzNVJrRzhn?=
 =?utf-8?B?TmtaOFVkL2xOS3premJtdXpYWlN2S0RkZUtOK2taOVVCRGg2T1U5RGcyc0sr?=
 =?utf-8?B?UlJwSDdVQmE1TDF0dWNudTl4K09NRVNYZEwraXZPRHlCY2tBWkN2ODBBQ2ZD?=
 =?utf-8?B?cU8wUlIxZVVlVFB0Wm1ZOWlVR1J4V200cWpSbTNuZHBlYTVWMFNOZDVheWNE?=
 =?utf-8?B?c01nRDQvSnZUTHZ6aVprZk1DakI4aXNTdnJLeElEQUZUSTliQkw4U1FaN3Jr?=
 =?utf-8?B?UFdrY0E3UGY0ZTVMd1hjR0UyR25Rbm01V0hxc2hyZUhkOUVKaWJNWVJVTXdh?=
 =?utf-8?B?VXZVOGVYb1hsb0MrNDhPQnczdEJZUUNUUDlMRTdSQ2tpS3g0M0Q1MVo2MWwv?=
 =?utf-8?B?Wm9WYUEvdVBpVmtSb3RXMXI4SlJJc0hHZnMyM21TdjFWVHQwa3ltNjB4eGNL?=
 =?utf-8?B?NTdQTFFlakd6L0FKWW0rUXh0MVVId2RrUEJ3UmpaekpWRmtuQW9oODNoRzRi?=
 =?utf-8?B?b29xL0c1TEhPRGUxQTNEVm44aExUUVg2aFJreTUzU2NWOXk3RExLY1FQMUJm?=
 =?utf-8?B?WEtKaEgyMkdYTGg1VS9lSGxCc2xpcHZrVHlodVdXdUdWVkRZUTFzWUtHUVdC?=
 =?utf-8?B?UmZDTjNYa1dNR2lwM2poNjVpOG1SODlZM250MzZTcUV1K09KdUJocE9pZ3lP?=
 =?utf-8?B?UWEvS0o3aUVMeTdmdjk5S2krYWsza0l1YVBMTkxmbWx3Yk5uKzUyMkJNYy83?=
 =?utf-8?B?N2FEVzdpbnFibk1FRnQyTlJSeFQxQXRablZtNWMyb1cyVGJCUmJxMEo4TlVP?=
 =?utf-8?B?blc1ZTUzQVdYYnR4WkF0ay93VzJETmltTlFyNVVUaXIrNHVwTlhNdnI2U1hh?=
 =?utf-8?B?KzhWNnFNOFRSUlUzK0FCZnprdTllTStFWFlNajdEYUt2akdWNU1yNW5ZRitY?=
 =?utf-8?B?eklTZDZhUjE4R2tqcUw1Si9YWkMwcHdyWmRNWmdLWitIQW5RejVNZVlXWkxr?=
 =?utf-8?B?YzYxS3dkMFJjNWU2cWlYd1Z3ay82OExRVVR3c3RRekhsZlB2VUJRNC9idU5C?=
 =?utf-8?B?Y3dDcFk2ZWNwZjgyR3ZJZmNYRENDZGNZR2JkZmIwM1lnZEJxcEcxcko4L254?=
 =?utf-8?B?QXUvSzRFVkx0UktGRmlvMkhZZ1NlRW8vdHFDVHk1ZnQ5SFd0dzdSa1Y2aVBy?=
 =?utf-8?B?RWduWEFYSnRXWWh4TkxzeVQ3VnIzYXpaU1VPczZlU0NjYVJ2NHphQ2oyWWpF?=
 =?utf-8?B?Sy9CSkxwQi9KVWsrU0ozK0NpVDVHYnhqczVFSDBzd2ZXR01VSU1QbkN3Nytq?=
 =?utf-8?B?VStZZmlidjlzK2dzcnVQWFJPT0lmODlGMjJYb2M3bGxiYjVXb3hQN2M5UlNy?=
 =?utf-8?B?ZmRiczJIWFk2QUZSbkRpeU9oMkJxWFdicmpMd1k3T2wwRWprdHMxOTZWNEZL?=
 =?utf-8?Q?KEp1+yceBOvjpIpq2c/ZC7A=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1175b2bc-3a52-4a07-edd4-08dc7697b8b8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 17:35:19.2215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YabW6kqQe9GPszLtGOaQ3m+W9spEKeaypC6QHyiYJUIO/ylrbtjOUHS7rz1dGMvImqvFKiQsV4AnQnwzI+DTLUhcNRKRCbTuUyPO/TURPjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7867



On 5/17/24 10:25 AM, Catalin Marinas wrote:
> On Fri, May 17, 2024 at 09:30:23AM -0700, Yang Shi wrote:
>> On 5/14/24 3:39 AM, Catalin Marinas wrote:
>>> It would be good to understand why openjdk is doing this instead of a
>>> plain write. Is it because it may be racing with some other threads
>>> already using the heap? That would be a valid pattern.
>> Yes, you are right. I think I quoted the JVM justification in earlier email,
>> anyway they said "permit use of memory concurrently with pretouch".
> Ah, sorry, I missed that. This seems like a valid reason.

I should have articulated this in the commit log. Will add this in v2.

>
>>> A point Will raised was on potential ABI changes introduced by this
>>> patch. The ESR_EL1 reported to user remains the same as per the hardware
>>> spec (read-only), so from a SIGSEGV we may have some slight behaviour
>>> changes:
>>>
>>> 1. PTE invalid:
>>>
>>>      a) vma is VM_READ && !VM_WRITE permission - SIGSEGV reported with
>>>         ESR_EL1.WnR == 0 in sigcontext with your patch. Without this
>>>         patch, the PTE is mapped as PTE_RDONLY first and a subsequent
>>>         fault will report SIGSEGV with ESR_EL1.WnR == 1.
>> I think I can do something like the below conceptually:
>>
>> if is_el0_atomic_instr && !is_write_abort
>>      force_write = true
>>
>> if VM_READ && !VM_WRITE && force_write == true
> Nit: write implies read, so you only need to check !write.
>
>>      vm_flags = VM_READ
>>      mm_flags ~= FAULT_FLAG_WRITE
>>
>> Then we just fallback to read fault. The following write fault will trigger
>> SIGSEGV with consistent ABI.
> I think this should work. So instead of reporting the write fault
> directly in case of a read-only vma, we let the core code handle the
> read fault and first and we retry the atomic instruction.

Yes, just undo the force write when vma flags don't allow it.

>
>>>      b) vma is !VM_READ && !VM_WRITE permission - SIGSEGV reported with
>>>         ESR_EL1.WnR == 0, so no change from current behaviour, unless we
>>>         fix the patch for (1.a) to fake the WnR bit which would change the
>>>         current expectations.
>>>
>>> 2. PTE valid with PTE_RDONLY - we get a normal writeable fault in
>>>      hardware, no need to fix ESR_EL1 up.
>>>
>>> The patch would have to address (1) above but faking the ESR_EL1.WnR bit
>>> based on the vma flags looks a bit fragile.
>> I think we don't need to fake the ESR_EL1.WnR bit with the fallback.
> I agree, with your approach above we don't need to fake WnR.
>
>>> Similarly, we have userfaultfd that reports the fault to user. I think
>>> in scenario (1) the kernel will report UFFD_PAGEFAULT_FLAG_WRITE with
>>> your patch but no UFFD_PAGEFAULT_FLAG_WP. Without this patch, there are
>>> indeed two faults, with the second having both UFFD_PAGEFAULT_FLAG_WP
>>> and UFFD_PAGEFAULT_FLAG_WRITE set.
>> I don't quite get what the problem is. IIUC, uffd just needs a signal from
>> kernel to tell this area will be written. It seems not break the semantic.
>> Added Peter Xu in this loop, who is the uffd developer. He may shed some
>> light.
> Not really familiar with uffd but just looking at the code, if a handler
> is registered for both MODE_MISSING and MODE_WP, currently the atomic
> instruction signals a user fault without UFFD_PAGEFAULT_FLAG_WRITE (the
> do_anonymous_page() path). If the page is mapped by the uffd handler as
> the zero page, a restart of the instruction would signal
> UFFD_PAGEFAULT_FLAG_WRITE and UFFD_PAGEFAULT_FLAG_WP (the do_wp_page()
> path).
>
> With your patch, we get the equivalent of UFFD_PAGEFAULT_FLAG_WRITE on
> the first attempt, just like having a STR instruction instead of
> separate LDR + STR (as the atomics behave from a fault perspective).
>
> However, I don't think that's a problem, the uffd handler should cope
> with an STR anyway, so it's not some unexpected combination of flags.

Yes, this is what I thought.

>


