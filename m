Return-Path: <linux-kernel+bounces-229603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA6791713B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEB81C2273B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BDA17C9FC;
	Tue, 25 Jun 2024 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="AL+eHedB"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05357144315;
	Tue, 25 Jun 2024 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719344814; cv=fail; b=U6pnpE+LOPO6UiNsCUt4Ahn222GC1bs9UE9jFTwHqFjrGCYpYVcN9i2bJdNf182G4XIcaiUj2ci4pabSkByZEPFthv5t5OrsP2jgyqYcvmxcJCWuHejqWzwvRclzO7tkZxTmk3si02lLnypUtwDa8lEVRP9r5W0BoOZocYuOCHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719344814; c=relaxed/simple;
	bh=sCsGSe0SvCdxgvZF0B7SrSqDmKRn89PdhFkAsAgh6n4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JFvcEQp+n7mFueJSEA1I5enRBNna6g6eB5F4W+rMDskKX3TyTV+zUfmrpT0pYhehoe9zFuNcFIybOqnpHkLnYMarfGWwrVS+qDHvUyhcGafg7oQP3CBWRP78iIJ6uQexHbirCI5Wb/4Wzo7mlsCqm5yv9w7c/RA+5KoNrmn0YWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=AL+eHedB; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxnoaFvvDwAUcMGqMkYP0TDUdZws9oYB/nVQOFe1966LH88SUY9w6JVH7UqKd8LQnnqiJFOMCdXLoqy49go+V5DW7yB4hVlvDQ/k9rXGFIhaYouH8A/F6GJvj/wnBnEodU+RINQFZOotpYcrQourS0wjE94EIXeESquOY2qQk5l62WbqhjvZDUzfmLozvdOiJo9TBL07vJ/tsd/w7pT501Z71fYWCo3BjLL6xE3LnT7QKQr6EHTcmxq5ePoK5uDs1hubEvYaL33bQ5SqJrDLvVuDKVZ+H0sejJkERo4KhaEzrhIzenlaHJcFM+aoilhi9bvQHSZK7ZmwnyyI3mMTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5Asz/2OB510XD2vKVTAjCTkdK//yA4P6gsqCHMqt54=;
 b=X8YBlqfcntSEsCNFDorpiEQLwZgcV1UIeiWUSIBTILXX11GO5Wi7fTnjTi7Pr24qhSTpuMEUgrz5WQAnh3UYNbyXHQPoddA1mcp/5IrVr0kh8P0G8+//ZZ6DaknyKIzRe4zYWoIR8jwnpCIbaVgzAjMrrdO3m+Z14KPK82+k3nxDHCZzY/v58JJ3Gg0alNdGRZWCNfVLGMh+xLa8Y5L+lcXs/TK8n9fHqCFIF1FQ7Cpa77U8rmCjtNK9/ToqiyO21qYUv+sDzNFzlvT7++xfP5B5NknryfwUBWZOwV4P6GsVos6dzjZpxktSstG2sDSwRgRWRM/0hblcBLJcrabB5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5Asz/2OB510XD2vKVTAjCTkdK//yA4P6gsqCHMqt54=;
 b=AL+eHedBCcyR5H9ECieEkDFxBDBddqMYciSOfqp/eUwj/H2b2ZrjkhN0H9wldL0cqeJh0mb1Xua1dEq4E7QVCYjIMAdyofaIKQ7h06HLCBlYJMtLV1Xm+HK9eCAxbRDcXp5BAdj2v5J6Yboo3RL+ZNHXIgcTnxl1U5ThrMKe749ZwjhHS5lMyPf1vu+bK96Xut/D5BIMnWzkFxoZIG6uHz6/tpITZbjx62ubcIroWUMSHASUkXSC2OPL5ywHRj+jwS4pwNVTSFj7br0BdTQN1hA11WCkB055yS1Cj2wgGF6a5vXjRCUXj8L4MnTqSqQbHaC380mzusuCLUgB3bA73A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7256.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:617::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 19:46:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 19:46:49 +0000
Message-ID: <7fbb62b3-cc71-4fa8-a0c4-fca558292c75@siemens.com>
Date: Tue, 25 Jun 2024 21:46:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: am654-serdes-ctrl: Add
 simple-mfd to compatible items
To: Andrew Davis <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240625164528.183107-1-afd@ti.com>
 <6ebc89dc-fbb3-4073-8b1b-cd413907ebf8@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6ebc89dc-fbb3-4073-8b1b-cd413907ebf8@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 174d036c-b9b6-4b94-2f17-08dc954f8da5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|376012|1800799022|366014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L21kQjdLeGR2ZkY5WUtjN1djVFpuK0pPTHhYQlliUGlMaERTS1pUL3NibnZh?=
 =?utf-8?B?Y3VuTGo2OExEdDE1KzB6cHgxVFdkbEQrbG5ZdFZwTVpmMUR0b0E5L2poUHhW?=
 =?utf-8?B?Y3BZYU9zN2pHNE13emFrWlpRcG83dTcyVk5ueVFUUEVBcENXRWxGeUpFUS8z?=
 =?utf-8?B?R1JDUDFaa1k4MjJkVXZEbTJrTFFwNTFKVlp2R25ldk44TmhyYzVnY3prbkN1?=
 =?utf-8?B?NzJ2YmhUejNqU0FaVHdXT2doRkxEYzlVc0J5ajJTMUpGREZpY1JFR3FKRTM1?=
 =?utf-8?B?ZlV4TU5YY2FpNkFvdWQ3UTN3QzkzUkJmb0V4dWJpQWhhNkZWVGdwV200MWtB?=
 =?utf-8?B?cXFldFUvQmZvR0NLZ3NnQ0hOYUIxd0ZuVkZXclRHMGlvSld6TitXN1RYcFNX?=
 =?utf-8?B?dWt6OENSeVdqKzJYOXZQQnNnQXRwaVBXczNRanJMMGdLMlgwMnN1RjQrbllQ?=
 =?utf-8?B?ejNqNm1yVDFBU0Fodld6eW0wM1h1RkpqZFhlMzArTyszeElXaVdVcWcybGhY?=
 =?utf-8?B?YUVMSDh2eG5LRjE0aUtIZys4UmZRUVpLanJnNDhiRzgxNU5lMnplMEliQXJo?=
 =?utf-8?B?cXp2TStsWUM1QmtQTURUck8wZUNmUkhIK1Z4MWczRVdvQjZwZTJ2RzZSLzZt?=
 =?utf-8?B?TCtTL0l5NGFzckNhWE1GdkFDY2RUdm0vMkFNUkk2ZkV3VUdHNVdTdDBGNGFj?=
 =?utf-8?B?dk1TNExxaEJCczZ1dXZSSE5wVkxhUXQvVXdremdIdTFsM2pJS1BETVVtR05O?=
 =?utf-8?B?S0h5MUtFVWMxS0hMbVhhY25yeTBFeEo4VVZqelJLYjNFbG5tVC9BekdPV1g0?=
 =?utf-8?B?QXVRcGg5azJWbER0Ynp2cEFMOXdCeHFuU1ZVbzQ5MFNDRkkyc0dhbFpLaTB4?=
 =?utf-8?B?biszUllMUTQzdE15K3FZKzhGOHlYYWtYdE1KSVBDa3hhVkIxbk4ycmF3YTQx?=
 =?utf-8?B?L3A1Y25WWSt0RUYwV1VzSVAxaHFWYmZTWTYrVGU5TEFsc2ZpWDRJcG9PZkZq?=
 =?utf-8?B?QzV5dG44NHRvTWZyUno0VllDSjY5VkhDRzB2aXI4ZVQ1ajFraEkxOXhVRDFT?=
 =?utf-8?B?SGxycHM5cWd3S1pzd2RLSVhNdjJ4OWdJM1RrS1JUZk4zN0hZbXRiU3NlVHZV?=
 =?utf-8?B?dVBhYVpKTnpkN0ExMVV3a0RGK3lHc0g2ZFVMSDNRR0hUQ3VVNjB2YndIMldC?=
 =?utf-8?B?b080NFMvNjBiZVBMOWtFcGpwZS9kelhuaHdML3ZHYkdQQ2RYVS9DY1NqcEpO?=
 =?utf-8?B?VTRNRW1aNXJZQXNBd2RQNk9EWWVuSnZSN1NoMDlpcGtabkJYTGw1UkZIWk85?=
 =?utf-8?B?QTFsMUVmZDNacEFseUxXOWdTQXRvbCtnbTBxbFRaTVZTMnhyM05hS25zSS9s?=
 =?utf-8?B?SUVHSHo1eGdocThDQmJ4MXNPSmJCSHBRclpJazFaSTVLT2s5UHA0U0ExKzhJ?=
 =?utf-8?B?VlFpZWsxckxrcnJOMnNPRXMrdnQyZWhwcDZpcFdVM2RMenJNcDFuNXBkUWRE?=
 =?utf-8?B?cisyWXlZblFVVXNXY2Q1YWU2aURRRjlXd1h3dG1IcG9KTnphSGJ0MmtYUFNt?=
 =?utf-8?B?OHRWWTFFdTg1dUlVNGd5YTFsNWxXYk80N0ZjaW9aeGYrcURmYTM4bGhhVXVm?=
 =?utf-8?B?bXczL240MFZkNmZ3QnRuRVJnRW1wS0F6bm5UMksvNVB3TUJ1V3ZaY0dpUUhk?=
 =?utf-8?Q?qdAwzcyxBoOg3SflwQPA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230038)(376012)(1800799022)(366014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3llK1gwbkp6eTZPV0pYYThWMFZOSWlZR2VkYmkzOEt3OFRDNTFSTXFoVjFQ?=
 =?utf-8?B?eGhuNmVVaWJLMTIxbUd5ZkJEeHp1dXN0b01lZ01MemJIbHg0UTErelhKYStl?=
 =?utf-8?B?UFQrY0h0U3g2cU4zaXkweGhkYkswanJqRHhjU0pkZ3JOYVg4NC9xSWZJZURr?=
 =?utf-8?B?V1dmcTRQUG9wRVBna2VPUmpMUms3dGNyWHRIanJNZmZZY1M1a0NZT2o4eXlD?=
 =?utf-8?B?VmE2MDhMOWVtM25RMktMTkd5WnBQWDdEcGxFMzY3UHRUSHVEREVlNy9HcGFq?=
 =?utf-8?B?cnFneEwyV0hSa1F3Zmg3WG96cElueVhHY2h5cnIwdnBWUWZYT2F2cWRkVmNm?=
 =?utf-8?B?MnJQNjZhZENmUzEzeGszQVA4UGRGZmJGRm80S25nODRhM0RWYTlyMVBMNFVj?=
 =?utf-8?B?ZEE4U2hhZ0hyWGRpNFNESmUzOVVIWnpEajNISFl6d29Ua3BTT0t5eTVBSW1x?=
 =?utf-8?B?aVhBd1YxZ2pleE1mSUorYmhWYThqZzFRVkd1Vll5VU5jVXJiQXlwTFRoRytX?=
 =?utf-8?B?c0l2Rk1PTkdHdEwzRkJXRGJJR2VCRmsrcnVrRlpaWnN5K2J1Y2UyZmlLc2hB?=
 =?utf-8?B?VXQydkovR1VWQ29KN3JvS3N0SjEwSDM0dDluTE9EMVlGVDBvbFhLN3BLT2lx?=
 =?utf-8?B?b2Y5WnJXNTR1SEpSM3BIYW96eWJ0OXl4YmdWZWVHblp1UFNtbHc3MDZocUVk?=
 =?utf-8?B?SWJiM3FBUFFpL1BhNlBCMGpuL1ZIb2NPQ2hwSWxHVXNpdnRDL1JEK24vWHdM?=
 =?utf-8?B?bmNSaUNDcktiSXd1WGo3VUY1UnFON1M1aUw0MERKNTVKRGpyeG02MnZUUE5C?=
 =?utf-8?B?bUZUUkZLaTlJeC95UFFtMmxxOU51NWg2emtMK3QwaFFPK3VhZ3dXMHZLcnow?=
 =?utf-8?B?TmE1cXJIczc5N1lFMUNsMzY3QU84Sy9jS1dkR3pNdFpRL1NJSGlNQTV5QzBQ?=
 =?utf-8?B?NU1WNGh1aGhOeURkVUczY1BPUm5QOHU4dW1kUVJsQ2xIdjZ2eHZaTmxKWmtw?=
 =?utf-8?B?bU13WTM3S2diUFZKSXhwaEhIS0JkSDFzVS9EbXZneTlUU09kZFh3eURkdWhm?=
 =?utf-8?B?THdFd2w5Zm5kb0VFeFNGbkNoMGN6TFdSaERYUWxKdTFiUzh3MEk5dUV4MFhn?=
 =?utf-8?B?WkM1WldIMkUyWmloTnVkRkZ0SE8xemFoTmY3RVplOWRjbnVjU0sxVmdyQjEz?=
 =?utf-8?B?M0tPWWRvWWhEQk5CV2ZWV09VWWNQQ2pYU2FSYndvbjRwYnY3R2haSE5HV2cx?=
 =?utf-8?B?NDB2RFdaTGxzY2ZhSjl5dmlRSmh3YzU4Z0N2YSs2bEVzdkIzMFZEYTBiam5k?=
 =?utf-8?B?WWY0cXNXVzczWlgwNkQzSnBBQ1B0MWJRb2JaeW80ZnBWZ3phYlU2VmpKZjhK?=
 =?utf-8?B?M29tWVF3bDQ5aFl0dldMbnZTa0p5eUpUa01wd1lDSmNJM3kzYWgzMWlJZi9D?=
 =?utf-8?B?bzlzYk94REhtUG5ReXhYNHVTMGFVSjNQT0NPRGJBRXZOd2lRZFZnWlJWV29h?=
 =?utf-8?B?d3NzSlJubTJMazcyc29QelIxN0lYdHFaM3dpdnFBMXZuTDJ4bXB4RGphbEh0?=
 =?utf-8?B?UmhhYm1MVU82QThKY2FYTVppOHVhMnkxNnYxaGR1bEVIRFdPS29QaUZuWFk3?=
 =?utf-8?B?ckNzdUZDVERGRGJ1dE9WaDZpa3MxaTg4TUtZS0NJNTVFRTNoVkhTL2hnQzMx?=
 =?utf-8?B?ei94b3J3UTk2RlVnSGxoMXZ0VzBiWG5oUHVJalZaM09uT2dnREY4ejJ1c2tM?=
 =?utf-8?B?TEpSQjJwVC9KVTRWL3BHNlVsOVR0TDNsTlpid3crQTdCejdtcStJL3FkelVW?=
 =?utf-8?B?QThESmthbE1LeWRBM2plclV5aDJVMUd6bU5rOFYxb3JUWVB5dEErVDdNRk9P?=
 =?utf-8?B?WjlCcTNTU0twZWxhNDBTaFpzUnNNQWJZVitpblBOWTJqMGtRMlZvdmRzMG43?=
 =?utf-8?B?NnJNL1Zjekd0ZHY0dGZwV1BDYzRoRzl2bURYWlFxVDN5djdnVEt4amt6Tndi?=
 =?utf-8?B?QVI1anF0R2lGQXNOZGdiYUlJR0lyT1JVWU02cVZZQnBybCswNllRaU5jbkdW?=
 =?utf-8?B?K0xUbTAyaGd0VjVQVHJieU9kb0diVGwzZHdibjFpNkZzREFQRVZrdmt2QXB5?=
 =?utf-8?Q?cquGC5crznubgJi226zC39cAh?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174d036c-b9b6-4b94-2f17-08dc954f8da5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:46:49.2183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfmIdOPWmXirvRB6I1tAjFuT2L3NzZKSbmaxyz+z8oDaAGn1NxTBLAWaCa02UELwObV+MZoDCtPocpl4OArDLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7256

On 25.06.24 18:49, Andrew Davis wrote:
> On 6/25/24 11:45 AM, Andrew Davis wrote:
>> This node contains a child which is only probed if simple-mfd is in the
>> compatible list. Add this here.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
> 
> This patch depends on https://www.spinics.net/lists/kernel/msg5253666.html
> 

But is that patch already scheduled for 6.10 as well?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


