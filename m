Return-Path: <linux-kernel+bounces-182225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 571478C884B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E072285CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B11761691;
	Fri, 17 May 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a9JWwxBb"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640931A2C24
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957178; cv=fail; b=No9rCf8rg60w2n0rMiOuRCcwcEgIgOEagQmccBetFG8TsLrDWeEopDmWA2bxV2oRO+w7D3Sev8YYaLrNUtpL3TMIMrrPlWxtWv40GsS6eZFST1PrJRwMzxy7cBAaHCJnbJ9Yuq2jHG4YQO46IwdnDlvhksF+eO3W7bnWukKyQMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957178; c=relaxed/simple;
	bh=U12wrrJQ2rtqdy5zKtDiGEWcLpEKQ1XTnpfGcRl8dAU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GGV5scKsyzhvoWRDRI/avnEawDKqb4UTYxHAymFqHCrgxhc0MzLVxaXuu2wAibnbQqYERFy5ndqg+6vhl1hcmC3ha1WYshkho9WJ1hB9iJ5wb0IFMzDX+jO26c+HjkUqNwmR6ZHKtm9+m4C+EEqkyjsQvqSCF0jsKxVJdLAx9CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a9JWwxBb; arc=fail smtp.client-ip=40.107.212.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhhJdLWDV3CqcEkoquw0BzT/4qYJjUTuheNhjBAI17AMOFCYDb+9g89y6M7CZvpOwN6D89tplOF+oGVuD+MfyPBNGOUb2+zR83hpJXECYWJpYcTCJQZDko3ihzT+9EOA+izkU10gOzzSPpTyHIP14QWD5l4OgV1nVnmOZljprLv9NYovj3OoyR7MMO0qMtGxcZ/Kt+rK+ytrd4Csx+94rUIi0DCZjdV32djXAxUinvA7SB/kPlG79Ns0dArEbdbRC87mvifinCH2cNgo8uEK3jNUnfqlUN2mKJFybXwEVn5d5/V9tHJp4RkOWTLkuAMM7auerXjIHVPqE5WeyubXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0WlRxZXvZFeu4lxpoP6QaRkWCUN3gFYsxGxOhocHuA=;
 b=AkPOIlHR23HhO/QqSA8AhLzB/sclyyn6RM+8a5vFtGYxvbI+596f/Vwa8APfDQOLNwsHXjbN4hTImyEKYvy0mmBYctn6tCtZwQCP0EcAbhgmxZABglP0Sfmoyr5BFT4qZMzuy+Q0oBsNh67vI7+T9TmLcdOoTKaR0/PDKiUyz6p5P1NBOTrm4pt0CmEh/KqUy9T1osKJrsIG3D175EIPGdyHVwvS7TJWHO5MvVe7Nechmn+9tNRLptutBx70nJrSiTSf2zF420atTXXYoLTUaJa7IQcZyylFFMwZsPRgr++C8itC45LV3XLry6vhyOF3/4mzU3JrA21roFt8IQPIPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0WlRxZXvZFeu4lxpoP6QaRkWCUN3gFYsxGxOhocHuA=;
 b=a9JWwxBb8f96I+gxYQUHcV28V2DNlA8sFXpZqDjbYq/dG4xtuvs2iQBXjfHrDDhyPFiwnHkSZh+eYpBOxUZYvYNa4q2u4NS3vyMBkEnC1txqSnx0TXihqsmBYSgGFSk3u+eod8iMu8N4sio3dciYS8HNmkPgfKfQYfQAX8ucB5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 14:46:10 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3%6]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 14:46:10 +0000
Message-ID: <f3c2fafc-dd31-40a4-8585-4a5dfd26e68b@amd.com>
Date: Fri, 17 May 2024 20:16:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: 6.10/regression/bisected - commit a68c7eaa7a8f cause *ERROR*
 Trying to clear memory with ring turned off in amdgpu_fill_buffer.
Content-Language: en-US
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 felix.kuehling@amd.com, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <CABXGCsN6j9GMTx+f_pYShOpLKL5b6kmJ3w-FeYHHw9nUWYjyHg@mail.gmail.com>
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <CABXGCsN6j9GMTx+f_pYShOpLKL5b6kmJ3w-FeYHHw9nUWYjyHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::27) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: dafcaa33-9042-4a2e-3aca-08dc768017ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1FGRkszY3huVDlBTWZUaVJMY29jWSs2M3UvSDhyWUpGbHZzRVozZk9jN1JX?=
 =?utf-8?B?UlFoZk1vY2RtbjRaWlFKbU4wVSt3ZEVkU1A5Z3BqcGFPUXpVeFZvNUFwSHI0?=
 =?utf-8?B?SUIwdE5UdS9DSGsrNyt0bExqVUVoYWRuY2FCSWw4ZzZtemc3WVo5eEVuSWdC?=
 =?utf-8?B?WlE5bGlzOFpWNHFCZWJtOXBRWE1wM1FQQlhIUnJXQ3pHU3Y5dSs4NXB0aThE?=
 =?utf-8?B?STdRSGUwbG0vK3hXSjQzV2RhVmhkWGh6SDR1WG9wQjJvNHU5Y09idGpTZW1M?=
 =?utf-8?B?TXkwamJjMHBCMVBBMWlNZXFNcnZBMEZmMlo0Wnl3T3BQckdtVEc0ZWpDV0ts?=
 =?utf-8?B?TCs2S2hjaExhYlpWOE5tbzJtdkQ0N3VKV0xLY0xXNzk3djdKTzZJSm41UVd5?=
 =?utf-8?B?UHlDMnRZWEhVQXJrYStaS1dKaHMzakp6Y0JxK2QyZCtNRGdYajJQM0txeTN5?=
 =?utf-8?B?dUpaa2JvK1BRNFhQL0lGMEhvU29MSS8rVUZiZnVQMW85MXJpMDg1TkhVbUIr?=
 =?utf-8?B?V2xhcUhtSVY2Y05xYzhkT3dMeGpERE5LNmhFTm44WHhLZW5WeHo4Rk5LNDRu?=
 =?utf-8?B?elVvTlVzNkY5R2RET1VncGNPSE1DUWJFNElNQ1kwbkZOVkJxWDZIL0tkS0tY?=
 =?utf-8?B?TUVkQkZUTVRMQ1VuT0haY00ySkRTWStncHZ1QnlsZDhDeDVGN3JORlNQbXZs?=
 =?utf-8?B?WStmdnJEV00yZXVMRXJHUlpHRmd6U2drMHR0bEErQmxvWFFuK2tMTVRURFBr?=
 =?utf-8?B?NFZmVm1yOG5hTCtqcU5XZjNZY1l6QjYrSzE3bFF0Y1dPVmNuWjY5WWVPNElJ?=
 =?utf-8?B?L3ZoM3pJWnpvdGVGMTZqWXJ3RFhLOHMrNXhOMGlrS2Q0RVU5cVhneHJHZ3R5?=
 =?utf-8?B?VnBaOCtpOFZyZmFlZ3NzUURKYS9SSzZDT0Y4V3pHTlZzd1NYUm9KSFk2ald4?=
 =?utf-8?B?cVpJdFJLSitoK0NIVWZSL2tDT3VITW81OFVTaG84TkdKQkE0Vzk2NForR0Z1?=
 =?utf-8?B?ek9KVFJtY2k2ZkhES0NESk1DREh1Z3l1QUVObmhpT1ZDSURPZWRpZS9odFlF?=
 =?utf-8?B?RWlGK0lvL3oxaXJwZm5uRDBOcWphVEplOTVRb3pyRGNMZEQwOFNHRDdOM1lP?=
 =?utf-8?B?RWE1dkgvKzJDbStJYno0SE9EdG9RUlljWDFBVVBmZzFXZG9KNm9iRzUzOTFO?=
 =?utf-8?B?N0NBakhlTUlVeUp2QWJJa3pnaXVIeC9Yb0hmek9NQlpqWVNPK0Z6RkVJNUlh?=
 =?utf-8?B?d0pYMG82ZnBJTDU3S3Q2RjhDM1VVRWFMUHNqUnFXZkxVcENRSVcxUUdJSUJC?=
 =?utf-8?B?YmpUTms1V1IxY1lUMVB6OG9PWkc1UFdxb2ZLZnlScG9UbXg1eENrempPWlVC?=
 =?utf-8?B?a0hkcGRqTXh5S0NVYUtteFAxNURxUHpWU0pqZ0M5U1IzSmlERzNEZnZyOTlQ?=
 =?utf-8?B?TU1oK24zdVMzTHhlb2lHbkE0VGNOeHIzLzNTSzlMalJBeVQ2bTZ4L2t2QWQ1?=
 =?utf-8?B?Q1I2UExsWVp6Y1hraGlLRHU3Y1FPQ081bklFQXEzTnhqWTR5UWlkMUU5ck9J?=
 =?utf-8?B?MGt0OWZnTFNEVFpYeGVyRCtEZytwRm5kcXdIcmplTjRTZG5UTlZxc2FDUExu?=
 =?utf-8?Q?/Z8kO8l41j/OOhQiYkHUZp+ghBvDwbUvGER/Jinxqmos=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4342.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEJ0dG5DcVhqWnQ3em14cnRFNFB2UGdJOGgwMXlrd1pIdUtiRVNoQkIwVWtR?=
 =?utf-8?B?RzFGVGxkWU14cjJsYUdhOXZwUUlTVlhLVldpTEIrNnVHNkNXZ3Y1Mk1QVHZ2?=
 =?utf-8?B?YVVUSTZaV3FQNm5iMWkxTVQ1UGJuKzY1YkVISVNZaCtUZjhHWGR4UmdQeWNw?=
 =?utf-8?B?NEZPZU9qZ1FaVG1yWVV2VlBhd21pZmYwQm9tVTJqT3o3Z3V5L1l5OWJMMFlY?=
 =?utf-8?B?cFNkdHFYWVNSUjNueFJtUTRTS1NuSzFUL0dWQ1p2c2xFVWY5TTV6K0ZXNHF2?=
 =?utf-8?B?WHR2YlNqU1NRWXRQZHdQR3ZwL0dSNXFpbGdMQ3VCY2ZVZHhWb2dKWkpndDAw?=
 =?utf-8?B?UGFNVTl3V09ReFlhdThPbDNJZTlTY1Fpc3NldlpYVFpKV3pVbWI0NzhYa202?=
 =?utf-8?B?NEJtNVFldjVQWUFCZUFlNWgvL1R0K3gvczZpRVgwdjZxQ1gvTkUrWWpmdmhJ?=
 =?utf-8?B?eUdMK0QyN205U1Z3WFl1R2lLUXVXZFpKZG9uNE9PeVJ2YnhWMGpBbkR0NjAx?=
 =?utf-8?B?TGtmUW1wei9uaXdheGd6dVNnREFRSWlkQnkzbmZCWEgrYTFERnJ1TlpMbnBL?=
 =?utf-8?B?eFM3T0RiNWdVNjFOelQ1UmswMjl5aGVSNzMvZzV6TVluZHdxblh6blFXTGNi?=
 =?utf-8?B?WXNsVWhkTlhOZ0t5MkRLMXhueFpuOThIb0wwVWhhcmk5cWtGNzlnRUlhc3BC?=
 =?utf-8?B?ZHlUajlaOE51dTJ6VkhsR2FPeHdvR1Fva2hFVmhxeENKWll0RXZObFJxVS9k?=
 =?utf-8?B?V2dOWWVTSHdLUU5qYTl3bU1qa2Q5NDNJMnRObzA1blB5Zkh1a1pBcGZ1cC9C?=
 =?utf-8?B?dXRaeHV0SXdIWW9DSDFnWGJvbWVvKzFXYlBrdEZUNFkrcnlKejNjMnBTbGtv?=
 =?utf-8?B?T0Fic3BDVFBRdlhLbGFmanBad2UwQ0xFaWw5NUVZeHUxdmk1V3N4VEIvSW5G?=
 =?utf-8?B?SC9sSzhOS1lESE9oNVZHUmNockRsaTAyL2QyYnQzeEtWWXVEd3lWc2ZPYWpZ?=
 =?utf-8?B?NG9qa01OVVZab3RldHNpTm1jL0luTGNpZlRBU251cTZSbXNEVGUrRisxekwy?=
 =?utf-8?B?cTQxczVWQjVyMTFZV3FBL2Y0VmJYc0EzUUVUNlE1WFc5NEVlc1h1M0dqMFp1?=
 =?utf-8?B?V3pMbEtvSTk0YXFtQ0RRRXVnaUdlWWhvTmlNR1pJc3JzVTJBT1dRaHhwNkZ6?=
 =?utf-8?B?SUIrbVVkV0ZmUEFnM0hxTUdYc1NRY3IxKzVVTHl0SDhzeExMT1l4NWE5aXhR?=
 =?utf-8?B?NGxyOC9oNFZ1SkF3VG9BTkhKbWNsT0VNN1dxTWxPN1VYTHhGV1FEekgyS3Qx?=
 =?utf-8?B?R1JoOE5jalVNekczcVVJbWt2L1VQNUhlTmNIYjBHdFBielVydFF1OHFBWXJZ?=
 =?utf-8?B?UGZSR0ptZFJrN1ZtV3ZVanVHT0wreWx2aThHcmpJRDFRY0g1blNybGFLYjIz?=
 =?utf-8?B?aGIvdnpDb2llNko5LzdsOUxGSG96ekRxcWVvaldaaGhQVHE5RUkxSzc2WjJz?=
 =?utf-8?B?TEV4Q0F6bTRET0FGU0x6VStMRE53UTZTZnFKSTNud0l4RUJieGY2WUFpQUcv?=
 =?utf-8?B?cFJkUUFlL1AxcG9qdTB5dFo1TnNLNWJnYU1rcDZJYmJ4MlFZYU1iM0NPUWdk?=
 =?utf-8?B?bDVVakRYMWN0YktCU2FWcTN0VHFhaEZBeTVRVTd6MVBMVm0rbmJyMC90Tlg4?=
 =?utf-8?B?Kzl4OUEwQ3R6RVFoUDNLQUg5UGhCTGlObXlYRHlidFU1WjF0MnAvMytVT25y?=
 =?utf-8?B?bzZTWklrRVBPaU5GSXM3NVNwaGsxM1JrTXVZS2lvaHA3bzlTVGg5NEMwbjBP?=
 =?utf-8?B?djQxTlFUV0J1UjJETkFBZGNqd0QwbUE3bjlsVkJldnpRakxBdlYyak03N0Zt?=
 =?utf-8?B?SnVMUzViZXZieHFqWVVBVVExOTh5TG94cHplUThaNWJJUzJvWW9IM0swVlVH?=
 =?utf-8?B?cEtPeFpVcmp4MVh5SG5EZGlWN1JPV1F1NFowbDJxWkh3ZUdoTEdzWkNTbDVI?=
 =?utf-8?B?c2Y4RTF3VC83U0cwaU5zR2wyc3JQN0t0OG0wZTlpV2NVYzduSnRQbTBDdnNI?=
 =?utf-8?B?OG9LSlpYZ1ZKU296a2NWeFVkWUNJV0QxNEs0ZXRML3NPam0vekJkWXFPODZU?=
 =?utf-8?Q?Zgh/gjGeEo3J4x4p0Hu3XEPQ6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dafcaa33-9042-4a2e-3aca-08dc768017ad
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 14:46:10.8085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqVPdBObSACMVgWLdKphuEWlj+3TlLfVGNAUgwqru/nfFzs99ambxf16a6KvbGF00fn9VZ1kQIjl3VFqRxDVvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932



On 5/17/2024 6:56 PM, Mikhail Gavrilov wrote:
> Hi,
> I am continuing to test unstable kernels.
> Yesterday at Fedora Rawhide arrived the new kernel
> 20240516git3c999d1ae3c7 and I spotted in kernel log new error message:
> [   13.676117] [drm] Seamless boot condition check passed
> [   13.676996] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to
> clear memory with ring turned off.
> [   13.677404] ------------[ cut here ]------------
> [   13.677422] WARNING: CPU: 24 PID: 746 at
> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1382
> amdgpu_bo_release_notify+0x4ed/0x5e0 [amdgpu]
> [   13.677711] Modules linked in: amdgpu(+) crct10dif_pclmul
> crc32_pclmul crc32c_intel polyval_clmulni polyval_generic amdxcp
> i2c_algo_bit drm_ttm_helper ttm drm_exec gpu_sched ghash_clmulni_intel
> drm_suballoc_helper sha512_ssse3 drm_buddy sha256_ssse3
> drm_display_helper ccp sha1_ssse3 r8169 nvme sp5100_tco realtek
> nvme_core nvme_auth video wmi ip6_tables ip_tables fuse
> [   13.677749] CPU: 24 PID: 746 Comm: (udev-worker) Tainted: G
> W    L    -------  ---
> 6.10.0-0.rc0.20240516git3c999d1ae3c7.5.fc41.x86_64+debug #1
> [   13.677752] Hardware name: ASRock B650I Lightning WiFi/B650I
> Lightning WiFi, BIOS 2.10 03/20/2024
> [   13.677753] RIP: 0010:amdgpu_bo_release_notify+0x4ed/0x5e0 [amdgpu]
> [   13.678005] Code: ff ff ff ff ff ff 7f 31 f6 4c 89 ef e8 2c 96 9c
> e0 e9 45 ff ff ff 4c 89 ef e8 8f 7d 9c e0 e9 71 ff ff ff 0f 0b e9 f9
> fb ff ff <0f> 0b e9 63 ff ff ff be 03 00 00 00 4c 89 ef e8 2f 06 f9 df
> e9 51
> [   13.678007] RSP: 0018:ffffc9000469ea08 EFLAGS: 00010282
> [   13.678010] RAX: 00000000ffffffea RBX: ffff888270d1c048 RCX: 0000000000000000
> [   13.678011] RDX: 00000000ffffffea RSI: fffff520008d3d1a RDI: fffff520008d3cde
> [   13.678013] RBP: 1ffff920008d3d42 R08: 0000000000000001 R09: ffff888270d1c298
> [   13.678014] R10: ffffc9000469e51f R11: 0000000000000000 R12: ffff888257047b80
> [   13.678015] R13: ffff888273610200 R14: ffff888270d1c000 R15: ffff888270d1c180
> [   13.678017] FS:  00007f22a16fce00(0000) GS:ffff888dfde00000(0000)
> knlGS:0000000000000000
> [   13.678018] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   13.678020] CR2: 00007f229f349000 CR3: 00000001453d4000 CR4: 0000000000f50ef0
> [   13.678021] PKRU: 55555554
> [   13.678022] Call Trace:
> [   13.678023]  <TASK>
> [   13.678025]  ? __warn.cold+0x5b/0x1af
> [   13.678030]  ? amdgpu_bo_release_notify+0x4ed/0x5e0 [amdgpu]
> [   13.686810]  ? report_bug+0x1fc/0x3d0
> [   13.686817]  ? handle_bug+0x3c/0x80
> [   13.686821]  ? exc_invalid_op+0x17/0x40
> [   13.686824]  ? asm_exc_invalid_op+0x1a/0x20
> [   13.686833]  ? amdgpu_bo_release_notify+0x4ed/0x5e0 [amdgpu]
> [   13.694852]  ? amdgpu_bo_release_notify+0x37e/0x5e0 [amdgpu]
> [   13.695094]  ? __pfx_amdgpu_bo_release_notify+0x10/0x10 [amdgpu]
> [   13.695332]  ? __pfx_lock_release+0x10/0x10
> [   13.695342]  ttm_bo_release+0x266/0xa50 [ttm]
> [   13.695351]  ? __pfx_ttm_bo_release+0x10/0x10 [ttm]
> [   13.695363]  amdgpu_bo_free_kernel+0x269/0x3c0 [amdgpu]
> [   13.695613]  dm_helpers_free_gpu_mem+0xbf/0x250 [amdgpu]
> [   13.695925]  dcn315_clk_mgr_construct+0x630/0x3a20 [amdgpu]
> [   13.696235]  ? __pfx_dcn315_clk_mgr_construct+0x10/0x10 [amdgpu]
> [   13.696535]  dc_clk_mgr_create+0x34e/0xf10 [amdgpu]
> [   13.696821]  ? dc_create_resource_pool+0x67e/0x810 [amdgpu]
> [   13.697103]  dc_create+0x939/0x1d20 [amdgpu]
> [   13.697374]  ? _printk+0xcc/0x102
> [   13.697378]  ? __pfx__printk+0x10/0x10
> [   13.697382]  ? __pfx_dc_create+0x10/0x10 [amdgpu]
> [   13.697658]  ? dmi_matches+0xe6/0x350
> [   13.697664]  amdgpu_dm_init.isra.0+0x8c5/0x5970 [amdgpu]
> [   13.697958]  ? __pfx_amdgpu_dm_init.isra.0+0x10/0x10 [amdgpu]
> [   13.698237]  ? __pfx_dev_printk_emit+0x10/0x10
> [   13.698243]  ? rcu_is_watching+0x12/0xc0
> [   13.698246]  ? amdgpu_device_wreg+0x15f/0x1b0 [amdgpu]
> [   13.698487]  ? smu_hw_init.cold+0x110/0x1e2 [amdgpu]
> [   13.727854]  ? __pfx_smu_hw_init+0x10/0x10 [amdgpu]
> [   13.728138]  dm_hw_init+0x12/0x30 [amdgpu]
> [   13.728417]  amdgpu_device_init.cold+0x4157/0x5a27 [amdgpu]
> [   13.728714]  ? __pfx_pci_bus_read_config_word+0x10/0x10
> [   13.728718]  ? __pfx_amdgpu_device_init+0x10/0x10 [amdgpu]
> [   13.728958]  ? do_pci_enable_device+0x200/0x2a0
> [   13.728961]  ? __pfx_do_pci_enable_device+0x10/0x10
> [   13.728965]  ? _raw_spin_unlock_irqrestore+0x66/0x80
> [   13.728968]  ? lockdep_hardirqs_on+0x7c/0x100
> [   13.728971]  ? __kasan_check_byte+0x13/0x50
> [   13.728977]  amdgpu_driver_load_kms+0x19/0xa0 [amdgpu]
> [   13.729209]  amdgpu_pci_probe+0x310/0xc20 [amdgpu]
> [   13.729441]  ? _raw_spin_unlock_irqrestore+0x4f/0x80
> [   13.729444]  ? __pfx_amdgpu_pci_probe+0x10/0x10 [amdgpu]
> [   13.729683]  local_pci_probe+0xdc/0x180
> [   13.729687]  pci_device_probe+0x23c/0x810
> [   13.729689]  ? kernfs_add_one+0x3ab/0x4a0
> [   13.729692]  ? kernfs_new_node+0x13d/0x240
> [   13.729694]  ? __pfx_pci_device_probe+0x10/0x10
> [   13.729698]  ? kernfs_create_link+0x16e/0x240
> [   13.729701]  ? kernfs_put+0x1c/0x40
> [   13.729704]  ? sysfs_do_create_link_sd+0x8e/0x100
> [   13.729709]  really_probe+0x1e0/0x8a0
> [   13.729714]  __driver_probe_device+0x18c/0x370
> [   13.729718]  driver_probe_device+0x4a/0x120
> [   13.729721]  __driver_attach+0x194/0x4a0
> [   13.729724]  ? __pfx___driver_attach+0x10/0x10
> [   13.729726]  bus_for_each_dev+0x106/0x190
> [   13.729730]  ? __pfx_bus_for_each_dev+0x10/0x10
> [   13.729737]  bus_add_driver+0x2ff/0x530
> [   13.729742]  driver_register+0x1a5/0x360
> [   13.729745]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
> [   13.729976]  do_one_initcall+0xd6/0x460
> [   13.729980]  ? __pfx_do_one_initcall+0x10/0x10
> [   13.729987]  ? kasan_unpoison+0x44/0x70
> [   13.729992]  do_init_module+0x296/0x7c0
> [   13.729999]  load_module+0x576d/0x7480
> [   13.730013]  ? __pfx_load_module+0x10/0x10
> [   13.730019]  ? __might_fault+0x9d/0x120
> [   13.730022]  ? local_clock_noinstr+0xd/0x100
> [   13.730032]  ? ima_post_load_data+0x68/0x80
> [   13.730038]  ? __do_sys_init_module+0x1ef/0x220
> [   13.730040]  __do_sys_init_module+0x1ef/0x220
> [   13.730042]  ? __pfx___do_sys_init_module+0x10/0x10
> [   13.730054]  do_syscall_64+0x97/0x190
> [   13.730057]  ? __lock_acquire+0xf65/0x5c70
> [   13.730061]  ? __pfx___lock_acquire+0x10/0x10
> [   13.730067]  ? do_user_addr_fault+0x4d5/0xbc0
> [   13.730071]  ? reacquire_held_locks+0x219/0x4f0
> [   13.730073]  ? do_user_addr_fault+0x4d5/0xbc0
> [   13.730079]  ? do_user_addr_fault+0x558/0xbc0
> [   13.730081]  ? local_clock_noinstr+0xd/0x100
> [   13.730086]  ? __pfx_lock_release+0x10/0x10
> [   13.730090]  ? handle_mm_fault+0x47d/0x8d0
> [   13.730099]  ? lockdep_hardirqs_on_prepare+0x171/0x400
> [   13.730103]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   13.730106] RIP: 0033:0x7f22a1fbc5ae
> [   13.730113] Code: 48 8b 0d 85 a8 0c 00 f7 d8 64 89 01 48 83 c8 ff
> c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 52 a8 0c 00 f7 d8 64 89
> 01 48
> [   13.730115] RSP: 002b:00007ffce615c888 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000af
> [   13.730118] RAX: ffffffffffffffda RBX: 000055f90368f520 RCX: 00007f22a1fbc5ae
> [   13.730119] RDX: 000055f9036c2e40 RSI: 0000000005749496 RDI: 00007f2299c00010
> [   13.730120] RBP: 00007ffce615c940 R08: 000055f903645010 R09: 0000000000000007
> [   13.730122] R10: 0000000000000006 R11: 0000000000000246 R12: 000055f9036c2e40
> [   13.730123] R13: 0000000000020000 R14: 000055f9036b3560 R15: 000055f9036d2f70
> [   13.730131]  </TASK>
> [   13.730132] irq event stamp: 2745383
> [   13.730134] hardirqs last  enabled at (2745389):
> [<ffffffff9f44680a>] vprintk_emit.part.0+0x44a/0x4b0
> [   13.730136] hardirqs last disabled at (2745394):
> [<ffffffff9f4467bd>] vprintk_emit.part.0+0x3fd/0x4b0
> [   13.730138] softirqs last  enabled at (2744940):
> [<ffffffff9f27025b>] __irq_exit_rcu+0xbb/0x1c0
> [   13.730141] softirqs last disabled at (2744929):
> [<ffffffff9f27025b>] __irq_exit_rcu+0xbb/0x1c0
> [   13.730143] ---[ end trace 0000000000000000 ]---
> [   13.730605] [drm] Display Core v3.2.281 initialized on DCN 3.1.5
>
> Of course, I immediately wanted to find the first bad commit.
> And bad commit it has already been found:
> a68c7eaa7a8ffdec9287ba1561a668d674c20a13 is the first bad commit
> commit a68c7eaa7a8ffdec9287ba1561a668d674c20a13 (HEAD)
> Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Date:   Fri Apr 19 12:05:37 2024 +0530
>
>      drm/amdgpu: Enable clear page functionality
>
>      Add clear page support in vram memory region.
>
>      v1(Christian):
>        - Dont handle clear page as TTM flag since when moving the BO back
>          in from GTT again we don't need that.
>        - Make a specialized version of amdgpu_fill_buffer() which only
>          clears the VRAM areas which are not already cleared
>        - Drop the TTM_PL_FLAG_WIPE_ON_RELEASE check in
>          amdgpu_object.c
>
>      v2:
>        - Modify the function name amdgpu_ttm_* (Alex)
>        - Drop the delayed parameter (Christian)
>        - handle amdgpu_res_cleared(&cursor) just above the size
>          calculation (Christian)
>        - Use AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE for clearing the buffers
>          in the free path to properly wait for fences etc.. (Christian)
>
>      v3(Christian):
>        - Remove buffer clear code in VRAM manager instead change the
>          AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE handling to set
>          the DRM_BUDDY_CLEARED flag.
>        - Remove ! from amdgpu_res_cleared(&cursor) check.
>
>      v4(Christian):
>        - vres flag setting move to vram manager file
>        - use dma_fence_get_stub in amdgpu_ttm_clear_buffer function
>        - make fence a mandatory parameter and drop the if and the get/put dance
>
>      Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>      Suggested-by: Christian König <christian.koenig@amd.com>
>      Acked-by: Felix Kuehling <felix.kuehling@amd.com>
>      Link: https://patchwork.freedesktop.org/patch/msgid/20240419063538.11957-2-Arunpravin.PaneerSelvam@amd.com
>      Signed-off-by: Christian König <christian.koenig@amd.com>
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c     |  9 +++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h | 25 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c        | 70
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h        |  5 +++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c   |  6 +++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h   | 10 ++++++++++
>   6 files changed, 116 insertions(+), 9 deletions(-)
>
>
> Unfortunately the kernel failed to build after reverting commit a68c7eaa7a8f.
> Due to follow errors:
> drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c: In function ‘amdgpu_vram_mgr_new’:
> drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:471:13: error: ‘bo’
> undeclared (first use in this function); did you mean ‘tbo’?
>    471 |         if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
>        |             ^~
>        |             tbo
> drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:471:13: note: each
> undeclared identifier is reported only once for each function it
> appears in
>    CC [M]  drivers/usb/storage/shuttle_usbat.o
>    CC [M]  net/rxrpc/security.o
>    CC [M]  drivers/gpu/drm/i915/gt/gen8_ppgtt.o
>    CC [M]  net/sunrpc/auth_gss/auth_gss.o
>    CC [M]  net/sunrpc/xprtrdma/transport.o
>    CC [M]  net/sunrpc/auth_gss/gss_generic_token.o
> make[6]: *** [scripts/Makefile.build:244:
> drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.o] Error 1
> make[5]: *** [scripts/Makefile.build:485: drivers/gpu/drm/amd/amdgpu] Error 2
> make[5]: *** Waiting for unfinished jobs....
>
>
> I also attach here a full kernel log and build config.
>
> My hardware specs: https://linux-hardware.org/?probe=06fc2ef32e
>
> Paneer Selvam or anyone else from the AMD team can you look please.
Please check if the below patch link helps. I am working on Christian's 
review
comments. I will post the next version.

https://patchwork.freedesktop.org/patch/592823/?series=133239&rev=1

Regards,
Arun.
>


