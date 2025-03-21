Return-Path: <linux-kernel+bounces-570716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9DCA6B3D6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA423AEF17
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 04:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306A11E3793;
	Fri, 21 Mar 2025 04:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gDiN2GQZ"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B23C2AD0C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742532961; cv=fail; b=m59zbqXHlfQWnECXHFeGTUTvucBSEMjJKlzeQJMjiKDXCYbgXZYjvxqicI9u0+Nn/IPbBiXBW0fZVG6yAuxwmSshNXA0YTrtylx9DeE9Wbx/52dgN/t9KlQOhgm9YzTPg8Jrg97sUeemD3xCnygY4sfCRZ3SV6KXNrJL7/9DTsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742532961; c=relaxed/simple;
	bh=YZHaHKRoPn2XrPx+S1ee+qNzPI2t03IE6IwwUD5nYNY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NOe7xe1gT89WUDLghaSeLOU1IdrHLiBzrqT0D+h+UvLXLFtsMrXhPkBsO1Gi68ot1G9aL0xuwEC+3VN0vM9cr5A/2MwwZTXwHsqK5T5fkGdol+YdkXYCFrw+H8syYmDzvTOriIMcVt+xFYQ0x/YTecDHW35cS7kugy7If3MgrW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gDiN2GQZ; arc=fail smtp.client-ip=40.107.100.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izPX4IbkB7MepT56Wy0GfWXllP101gJHsu57NBa+pDKbn9Z2uLkc0k0nR46A0DuNYrWcXmfRY+8L7Tpv6KCMdnhxa+ImCyHUnmbMNo/jJeigIDm4kZvIBxUyS6XMfXPrzkdHKN4Kq7bPva3wrYUGPjbD8eM7w3Z38mRLIS/BraOE7tuOwghH9Tt92hCIBXTAdMZmvMhFwDbONaX1qPiU1us4JLKuJSt5TQCXdamtZteuqSgr1jpsgFBaYqLU6jzAOV7KgS3pTklz66YSc8H46TkiC7/ISvMkLb3kfsZbR4YSI9Ob96zMaqJHMYMnCJInJUsmUwemPH+LLZUexJi5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDTPDGCdy4L13wX691xQ1nOWdCrizDC2iADWZvJX9aY=;
 b=hZ9ViAMCRRU2zqf8SZWH3IXoLylpuOdBYyiODajWS6pEkn6jh7Xy5u8uQDKTKQXQtwKbN2NKIDl2LY6bdegWWZkjXC3sGlPIPNXTv2aschDD/3KmIJu6wNolGH4xhFs3ojT2N+cDwhLl+K6qDfPAXRdY3LBnJiVwATzOXoHqJ14cNoOjEyCJHyeqvSZdZ9uAPbbZScwESI9t0+7y8hMWHAw3cRm/4O1WeoZptHBmafnvRpgHGlnk8W/sk3oaIHb+LNQ3XquGbzgK/5pIbPA1tiJNNNJmB8Gid0mVvUDNQuQUNgiiBgbgqCNjcs+Wq+iafmWjbqjsiDupoiU+PYpqlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDTPDGCdy4L13wX691xQ1nOWdCrizDC2iADWZvJX9aY=;
 b=gDiN2GQZODsK0VBWHnWOVl/jXQ4Vx2XWzdVVhQjh05NEIB2guqIOzh2dy+3OSM0wFtXCGt7c3oc9OcN9HNUS7WSKaQMBONrJ0b4z4cZ7MHDnwV+1CACtRN4eZWQtp9SLiV0fYYvrzJ9zf0gXo9BJ/78ITZK2CX3MfsYT7JJau/RIbP1bg3ErKvQYMhFQCFBRIRmA5hszo6XjPhjLtgEB+AUA106wiIH8kX7LG1PwHKuS93H/KR1sbNKgU0L5bH8Kg4dwxRKc+MXmbbRtkvCssjChHLl8eIwy6eZg6znWuwQqpxT12tmtUAE0jjlYQNxeaBqZMM/StH6Xr+ORFwFCrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by BL1PR12MB5948.namprd12.prod.outlook.com (2603:10b6:208:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 04:55:55 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 04:55:55 +0000
Message-ID: <d3580fa0-df0c-49ce-aa4e-e8c945172939@nvidia.com>
Date: Fri, 21 Mar 2025 15:55:49 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Bert Karwatzki <spasswolf@web.de>, Alex Deucher <alexdeucher@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20250310112206.4168-1-spasswolf@web.de>
 <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
 <12d950ee-4152-4ad6-b93e-7c5b75804b1a@nvidia.com>
 <705e95cec3dc5181ca2aa73722e6b84f63f3e91d.camel@web.de>
 <20b5823e-247a-456a-bb55-d50f212a9f5a@nvidia.com>
 <a34a1ae0b1d226b1bac7d73daa24da8e5899cb3e.camel@web.de>
 <c7bb0bd1-529d-466d-9cce-abbac4b480ab@nvidia.com>
 <146277bb0ecbb392d490683c424b8ae0dfa82838.camel@web.de>
 <b63b1de8-7eec-4235-b61e-e654e78543ba@nvidia.com>
 <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
 <7866593f-0322-4fb3-9729-82366940fc85@nvidia.com>
 <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
 <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
 <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
 <CADnq5_Pvmxa10dJWYjajwxG-0Y_oxhL6wS6NsG2F0dmcJS6o8A@mail.gmail.com>
 <9be36dfab79b17e108f71d51a6ebf39073e110c6.camel@web.de>
 <b5d80ef2-fd5a-41cc-9184-6c82226c330a@nvidia.com>
 <841287f296579671dcd91329a49feed97186bcd3.camel@web.de>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <841287f296579671dcd91329a49feed97186bcd3.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::30) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|BL1PR12MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: 767c5d1f-dae7-482e-59d7-08dd6834a963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWk5bm1lcCt4eGQ5QlBUN25JZDNVeXhoOUdleHVQK3BGYU9GOWdxdUR4L3Z3?=
 =?utf-8?B?NkI3T1BMcElibTVSUnVXeEdMcy95dDNsalVQcmFhb3lvb2drd1VjcWpLUTZj?=
 =?utf-8?B?U2M2NlN6d3piazhPajlLYWdMRmRsN2NWNnVBdWVGRC9HOW4vSVNyaW1RNzU5?=
 =?utf-8?B?cnZiVW5CWHNoM2xqRFhmcmE1V3RSVUNMbHczSkEyNitJckpsb2IzWVF0QmVT?=
 =?utf-8?B?VTFlcW5iV0dxOG1ZYlZ5ZFFCY1NGV09Pa3FJYWdMNy9FZTgwZ0x2RnFQcFpj?=
 =?utf-8?B?VS92cHdyMjlHT0FDeWpLeDdhWnhCcVJhdmZncllsazZOelZyMExPU0xWUUNJ?=
 =?utf-8?B?MlNVOW52VjA1eE1lU2VOYXdaOHkzb3FOOVNjYnlDcHUwMTJkSDJldkxrc2pY?=
 =?utf-8?B?QVVsY1p3R1NJRnBEeE42OTJnOFRNYm5YWFdheHN2T0hUWGczekJEZnN6YlN4?=
 =?utf-8?B?QXk5cWhabjBaMC84djlidEV5Tm5abkJBWndFY3I0U1ZjaUpzeThsYjllaDJW?=
 =?utf-8?B?S1BCQW9JRkJsbm1NUHU0MXl2NkpTdjZYekpDRmd2V0ZHaG9TU012QWVNOVpG?=
 =?utf-8?B?bXlTT09oYzk0WHZCSVpidFpvVEZPZDRtZXgxd0tZUmRMTEI2ZUlRS0xjVTlw?=
 =?utf-8?B?RW04dUxlQjVWMzhyQm1VdlcrTStPNXVmK05ycTRKc1RubWMxTnZ3aDhxVk5N?=
 =?utf-8?B?L3dWQnllS3VNNENHamhDNzA2ZWx0T3o5NlBScm8xRWFRR3ZIRE54NXpEVFhw?=
 =?utf-8?B?V3Q4RFJxa2thcGJER1h3bFM1RkYwMDMrQkNTK0IweGxtYjY1WXhpUTNWZDNK?=
 =?utf-8?B?WHpxWEZ5N3FZMUVhSDVKYzhxNUJXUEFNN2FzZXFFcXBKamxQbVFKWUNQYnZu?=
 =?utf-8?B?N0FMcFVieWJyQ3pIWFFpcFNWbUQxOXdFeUlFMThTZVE1U1djaGRpSWdyM2Rm?=
 =?utf-8?B?WG1LdkRHU0lNcWUvT3hKZFp0OGthbVYwODRmaW5pOHJjUXIvOXZFT1ZXZmtT?=
 =?utf-8?B?aWhrRTBwS1dwTXpvczVvT0NDdGZmblpCK2hmR2tnaEJXVjc2WXZobGZEMyty?=
 =?utf-8?B?ekdERjgzYlhlTnEvaUkzakVRVTJiVFJYNTNFZEJaUm1pRmVKRnEzM0lEYmNT?=
 =?utf-8?B?Mzd5aFFpNFc0NGR3MFJzMGtZLytXaEdubktaaFVLenBQQXVXYXpQSVlpeE9h?=
 =?utf-8?B?bVN0Qzh5Y0tPQ2E4OGtucUhDT2NDRFFrRm1pQXRsZDVseHFEbzhQWk1VTDM0?=
 =?utf-8?B?Y1h4VlEzbktFQS9MWk1Vc2JCa2FZWjlyeWxXYnNHcjJNK3liV3FPUzQ1UzIz?=
 =?utf-8?B?djJHNjFBeVBENmR5dFJaRnlGVGc5ZHJVeFA4cDQ1Y1VkdkdKWDQyM2YwOThj?=
 =?utf-8?B?WjhHaE5YNmlMRDVQL1RPTDBYTWJLQ2xldENLVWswL1JDbnY2cENGbVIzSjhw?=
 =?utf-8?B?SFQ0MU5YOHNaMlhVcnVtVkorQUZuWVUrZnNadU9QVFJRbU9GWjAydUFZekFr?=
 =?utf-8?B?WU5sTU5QeWlxblBtVUFQMEs1UEpqdGcyakhKVWorR2dwY0RwQWo3c0lIamFV?=
 =?utf-8?B?NzB5MmNuaG5qcUkwN3JpRnFiZ3RmZ1RUSWVrdWJncm1OVFpacVplWDlWMU1G?=
 =?utf-8?B?TXA4Mlh3V2JHSm85Vi9oblUxK05tdjNhMG9sYkdTbTRVVmMvaFlsSlVvSmt1?=
 =?utf-8?B?VGxKaTIwWFBMSzJ2dEEwYVA3eGx6YlFKTnk0TzZwMldFalFmNzUwdXRxQ3E5?=
 =?utf-8?B?RlJBelJLK1F2SFVMOXFaeWlGM1NGKzgrRjVGdnJSaWdEemZQNGRKOFd3ZFU1?=
 =?utf-8?B?MXArdTVydnBOTHlRcnNyMlZHRFdVQjZkWVRucWdydW1MeGNGZXJIMFBOdW9i?=
 =?utf-8?Q?AoicvV22dCod9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0doaHVHL2tYalZ5cEh6LzBabWF1QWdPUVVaR2d5djhlZm8ydmxmL1JlQUx5?=
 =?utf-8?B?RGsyQytZaW5iamp5VVNDU2hRVTFKMmVYSTNVRnF1N2xIRW9XbjRSUStMcjNY?=
 =?utf-8?B?ZzQyWjgrUXRYT2p2VndUQ1dqRlQ3NHNGYU95eVp3cy9JTXR4YXRLQzR6em1m?=
 =?utf-8?B?UFNLTDJlWWVJV09YT2l0aWFuU0V2UG03Z0JnbHNEYVduYkp4b2dIYXpYVUtx?=
 =?utf-8?B?RXdraXFHTFZQNnlCUzZQZDJSNERSdE1vVU4wVVNFcFkwWmgxWUU4NUxlMWhL?=
 =?utf-8?B?Vk05QUNudFVJZTZZMzBvVWxnSktrSGhOZXUycUJ6VTZPRGFRQ1NTYUp2MmR0?=
 =?utf-8?B?L21KRTRTL000akRmUWZQRFowSXJYYURyUkFMcTNFYXBZaGlaVXd2UUc4SWRX?=
 =?utf-8?B?dmZveE1haWRGbWlLK0c4RE1SRnZWYzBhWUtRL2hHZXZ1Z0IzbkRPeFZuWmw0?=
 =?utf-8?B?WHpHUFVsaU5VY2VhYlVCZWdBUmpua2p2MEl4TGZ1cEpnOTE1eFB3UGJDSjN0?=
 =?utf-8?B?Z2xOZGFaaWIxakFFNStOWDlraSt1dVNSc0c4VURNeW1QK2JFdGpnaWROSklB?=
 =?utf-8?B?QmQxN2ZTZmNWL2t0RHdnVTdtZ3VzbWpiNHFhdSt4bVROZnN0NlpldDFkZ1Fo?=
 =?utf-8?B?NkVTQ3Z0a25FSkxabkV3eTMzZGdwbmdVeExEVlU2djRxaW1OaG5sRGxaUXFn?=
 =?utf-8?B?dUxJL0ZFUGpMWVVUeDFrOU9kQS9BcHo3TjlBOXMzWjdRdGFIdC9DTUpaM1g0?=
 =?utf-8?B?MlBLeVdsK215SytvSG9YdStJL3hwRUlZQlFTZDdla1FMQmoyeXQ0dlZmMklZ?=
 =?utf-8?B?K3F2cFNlUzdTekE1M1RqOTBVekJ2a29UdUFZdFpGRlNudG1qOVNSRTZXSmRV?=
 =?utf-8?B?UEJKaGM1VVovNkU2bW43TFgyd2NyMXJlODBUbUJOR0RnVUpkYzFwZitlb3lz?=
 =?utf-8?B?WHNLMUZpR0M3OXdhVFhZQU1FdmpZRlMvcnFncEtkS3VHU3BHRWhEUkEyU1kv?=
 =?utf-8?B?MFVzbFFXblJFU1lxeVVkeHdYRlc0OUg4bzZhdjNYY3BDUzFIcHE1ZmJpR1ox?=
 =?utf-8?B?VEZ0VGNRNWM0MWNDbmQ3UHM5Wks1NlJkNzk4NUROUWdra1dpTmJSWWFTTnJF?=
 =?utf-8?B?MTlJYVpXQ1pSZ0YraHlVV2dlRC8zSllLR0JlcGhyMGMwYTVpVlJMSmtoYndn?=
 =?utf-8?B?SWlnZVJtUkJpWXUxZ091YU8xNmxwUE1jZnlERHRJREJ0NzdUK00zbVV6T0tt?=
 =?utf-8?B?Qm83ZE1JRWtmWVhuYlJ6dzhnYVhwL21kMmczdm9aa3d5WjZRWHQ4NUZ2eXFi?=
 =?utf-8?B?cjd6SnQ3dEZwcGpyNUV4OEZldCt6bzF4MFUyaVM3SklvaGViYlNLOVlJMmdC?=
 =?utf-8?B?ellKZ2I3cGJaKzZCVDhUTHo3dU4veWVtL3Jsc0xybW1zYjdkS3kvejkrNGM5?=
 =?utf-8?B?cHJzRnVBQ29scllkM3NJTXYyWE5mbFZkSCt6MVIzek1abVVzekRNeWRpWWVp?=
 =?utf-8?B?L1NVUkZFMjVRQ2pSOWZUUmJidHNwN3FWUWlHU1Jjbk5QOTcrZmg2TGRDclgw?=
 =?utf-8?B?S1BVRVZxTmxyY0hSUVBjTGJGODl5YnRhM3dCSFNlT0dNUGJWMWppQVB4TUg1?=
 =?utf-8?B?WkJ2QnlSR3JkUDFPdURBYmN2WXJtLzlpRUhYa0I1ODBnTlliVmVqV3BvL01p?=
 =?utf-8?B?TVBGN2YwNVJkRExtZS9WeDFjM3lyYzV1RXlMb2E1d29pMzRtSG9Gc1hhWEdJ?=
 =?utf-8?B?TVdHSHdHa3dsMG1BWEptTEE0c2dUVXJUVC9Nek4rajRySjIxUTZiUHRIT05I?=
 =?utf-8?B?Wk9xRzl0YVVtQ0NobDl2L2U2NitJYng2RldJZlJwck91YnJ3K1dyYTl2SUdS?=
 =?utf-8?B?akVmbndCZGowd0NISDJ4OUdtL0RrYUZsVXYwRmtFS09OQVF1YUthaUxDQ1Bx?=
 =?utf-8?B?b0pSSE5BRFYydUxRekI4L1U2VU1XQlFaejlmbzNOU3p5K2Y0NUFVMm81WkZM?=
 =?utf-8?B?VUYvWElRSHgrRVRId0RQdDNUbHUzU0pkbTcwYkdBcDkzRjVwSHZ1QldEeHg1?=
 =?utf-8?B?c1draS9kYWlReTF4UjcyQjdTbUJHSEdUVG1DalVQUWpZbUFzVVhWQ2dhb2Fx?=
 =?utf-8?Q?NjfKg5Zs8jyC8VBsBHuRC2sHV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767c5d1f-dae7-482e-59d7-08dd6834a963
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 04:55:54.9272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SumzsUQ8C0eJLCD//a4A0+jZJT2onuALOeeYq+Le0KVddHFLxrwgdoaIyfWpyV5v8LYJOHd2VrHHC8Ui09K7vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5948

On 3/21/25 10:43, Bert Karwatzki wrote:
> I did some monitoring using this patch (on top of 6.12.18):
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 0760e70402ec..ccd0c9058cee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -121,6 +121,8 @@ static int amdgpu_gtt_mgr_new(struct ttm_resource_manager
> *man,
>  	int r;
> 
>  	node = kzalloc(struct_size(node, mm_nodes, 1), GFP_KERNEL);
> +	if (!strcmp(get_current()->comm, "stellaris"))
> +		printk(KERN_INFO "%s: node = %px\n", __func__, node);
>  	if (!node)
>  		return -ENOMEM;
> 
> @@ -142,10 +144,16 @@ static int amdgpu_gtt_mgr_new(struct ttm_resource_manager
> *man,
>  			goto err_free;
> 
>  		node->base.start = node->mm_nodes[0].start;
> +		if (!strcmp(get_current()->comm, "stellaris"))
> +			printk(KERN_INFO "%s %d: node->base.start = 0x%lx node-
>> base.size = 0x%lx\n",
> +				__func__, __LINE__, node->base.start, node-
>> base.size);
>  	} else {
>  		node->mm_nodes[0].start = 0;
>  		node->mm_nodes[0].size = PFN_UP(node->base.size);
>  		node->base.start = AMDGPU_BO_INVALID_OFFSET;
> +		if (!strcmp(get_current()->comm, "stellaris"))
> +			printk(KERN_INFO "%s %d: node->base.start = 0x%lx node-
>> base.size = 0x%lx\n",
> +				__func__, __LINE__, node->base.start, node-
>> base.size);
>  	}
> 
>  	*res = &node->base;
> @@ -170,6 +178,8 @@ static void amdgpu_gtt_mgr_del(struct ttm_resource_manager
> *man,
>  {
>  	struct ttm_range_mgr_node *node = to_ttm_range_mgr_node(res);
>  	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
> +	if (!strcmp(get_current()->comm, "stellaris"))
> +		printk(KERN_INFO "%s: node = %px\n", __func__, node);
> 
>  	spin_lock(&mgr->lock);
>  	if (drm_mm_node_allocated(&node->mm_nodes[0]))
> @@ -217,7 +227,11 @@ static bool amdgpu_gtt_mgr_intersects(struct
> ttm_resource_manager *man,
>  				      const struct ttm_place *place,
>  				      size_t size)
>  {
> -	return !place->lpfn || amdgpu_gtt_mgr_has_gart_addr(res);
> +	bool ret;
> +	ret = !place->lpfn || amdgpu_gtt_mgr_has_gart_addr(res);
> +	if (!strcmp(get_current()->comm, "stellaris"))
> +		printk(KERN_INFO, "%s: returning ret = %d", __func__, ret);
> +	return ret;
>  }
> 
>  /**
> @@ -235,7 +249,11 @@ static bool amdgpu_gtt_mgr_compatible(struct
> ttm_resource_manager *man,
>  				      const struct ttm_place *place,
>  				      size_t size)
>  {
> -	return !place->lpfn || amdgpu_gtt_mgr_has_gart_addr(res);
> +	bool ret;
> +	ret = !place->lpfn || amdgpu_gtt_mgr_has_gart_addr(res);
> +	if (!strcmp(get_current()->comm, "stellaris"))
> +		printk(KERN_INFO, "%s: returning ret = %d", __func__, ret);
> +	return ret;
>  }
> 
>  /**
> @@ -288,6 +306,8 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t
> gtt_size)
>  	drm_mm_init(&mgr->mm, start, size);
>  	spin_lock_init(&mgr->lock);
> 
> +	dev_info(adev->dev, "%s: start = 0x%llx size = 0x%llx\n", __func__,
> start, size);
> +
>  	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_TT, &mgr->manager);
>  	ttm_resource_manager_set_used(man, true);
>  	return 0;
> diff --git a/drivers/gpu/drm/drm_mm.c b/drivers/gpu/drm/drm_mm.c
> index 1ed68d3cd80b..e525a1276304 100644
> --- a/drivers/gpu/drm/drm_mm.c
> +++ b/drivers/gpu/drm/drm_mm.c
> @@ -223,6 +223,13 @@ static void insert_hole_size(struct rb_root_cached *root,
>  	struct rb_node **link = &root->rb_root.rb_node, *rb = NULL;
>  	u64 x = node->hole_size;
>  	bool first = true;
> +	int count = 0;
> +
> +	if (!strcmp(get_current()->comm, "stellaris")) {
> +		for(struct rb_node *first = rb_first_cached(root); first; first
> = rb_next(first))
> +			count++;
> +		printk(KERN_INFO "%s: RB count = %d\n", __func__, count);
> +	}
> 
>  	while (*link) {
>  		rb = *link;
> @@ -247,6 +254,13 @@ static void insert_hole_addr(struct rb_root *root, struct
> drm_mm_node *node)
>  	struct rb_node **link = &root->rb_node, *rb_parent = NULL;
>  	u64 start = HOLE_ADDR(node), subtree_max_hole = node->subtree_max_hole;
>  	struct drm_mm_node *parent;
> +	int count = 0;
> +
> +	if (!strcmp(get_current()->comm, "stellaris")) {
> +		for(struct rb_node *first = rb_first(root); first; first =
> rb_next(first))
> +			count++;
> +		printk(KERN_INFO "%s: RB count = %d\n", __func__, count);
> +	}
> 
>  	while (*link) {
>  		rb_parent = *link;
> 
> 
> With this I ran stellaris (just opening the game the closing it again from the
> game menu)
> 
> The findings are:
> (a) The size of the RB tree is the same in the working and non-working case (50-
> 60)
> (b) The number of calls to amdgpu_gtt_mgr_new() is ~2000 in both cases
> (c) In the non-working case amdgpu_gtt_mgr_del() is called far more often then
> in the working case:
> Non-working case (cmdline: nokaslr) 834 calls to amdgpu_gtt_mgt_del()
> Working case (cmdline: nokaslr amdgpu.vramlimit=512) 51 calls to
> amdgpu_gtt_mgr_del()
> Working case (cmdline: no additional arguments) 44 calls to amdgpu_gtt_mgr_del()
> 

I am not an expert in amdgpu or gtt_mgr, but I wonder if some of the deletes are coming
from forceful eviction  of memory during allocation?

Have you filed a bug report for the nokaslr case?

Balbir Singh

