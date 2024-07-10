Return-Path: <linux-kernel+bounces-246855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C702892C80B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583A5283D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B8C5680;
	Wed, 10 Jul 2024 01:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JR60qzRS"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2083.outbound.protection.outlook.com [40.107.117.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123043D62
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720576015; cv=fail; b=HqRL3MCbCp6rzjICtbm+rNP+NwAswTZYgsQCdRyFirMu7fJ/Gty89t7Pq/B0w/3Mng0sixWUOCIZtHH9R+a6cSWgDplZ7EOtfXO1oIiNtd7jDb2bxiW7YORYYnlpzWnntp2bFaOWhVijJlVEJLrM4nRwht5Wu/ceNZIAx49x/vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720576015; c=relaxed/simple;
	bh=Cf006/jkxWUnVlt9+SfEJestXyuzYFVdfb6rxVnFneY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jv6tjNU/YlnJtFjiRxzkKX1LYfjx98ET7tTsfgp2lcH45gsFobQau+iALH5ckUIj15MlahhShBl2BtKhbukYwdbe8qUvALd6nlTVwgfJ/1yGi0oAR4o1JeBmJas3HsgvNMRxmqmXUpJ4YgtwlypG5CSBJjIk3463NaYxZI8uziM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JR60qzRS; arc=fail smtp.client-ip=40.107.117.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAk0hGnMjtutRCkJvdhnUUiGQOFUzn7uzvjd2plfaagEYab0AokZivwK8G6f53uPPbNs0UjcUSY0Tjk4GyE9a8tCyVigTRLlmF3BY2xQKsrWQ+vv6VgfIXvtTMY5uoPIHygunHECY79amL6Jwx0ayCYQETMH2Ge0+pzdu8YmlaEvEoNiNqjCrSZp8xoUeTXG17PIexJbFDlAwI6ohv2W+toMf+dsiIktn19XsUIJIlF5oXx14jW+oaY1QpdWXUH0sHri+KtABIFFl1MQJ60IjjFi1pn4OOHb84Ox/OyCeMw0+d7meUAxWl5sb4cXOfeQI3FHlw7ycF54QE8SfguW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E406nukCGtXb9p6GrS4AqYBq9xFBETEkTPz6l84F7Bw=;
 b=gQCM4jzcBGAFuFXkmLZY+0a4vq5vnH96X1O7IzJCWkLe2+aRKoWPZ7R/qLUxTckB7pzF7jRpjtCegO7RMWbVwz3O29cB3NWv13qsjiuGoC0phN7KXUWwwKms/o7tMU4EvB1MiD21gr+n7xUXqqHP2aX7kx2SRBCRZjC8jVJeWRJ6A7oclwQvn3LCPggRKGz/UNSpBGZ8Y3ER9bqAY2HabDM2amCNRRmHphjuyyLWvdcbAJv5Ytc+tWqwDH3bmEUJeFRyPGhIx0S6L0GzyYV9HKrFUuNTTqkZH50w83rUvfrcZfNygjZIHqrXTDIl60Hjst/ReYuaDDeIMZKQyoK7Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E406nukCGtXb9p6GrS4AqYBq9xFBETEkTPz6l84F7Bw=;
 b=JR60qzRSGAmd2Z6sAhb1EQ6sKnJNDXi9VZ58r3+/v7WVR+YGz/ziEfiZxnhbjaQ627b1PZ2ML7VID5yTAuxNan/xE3xsr8kXCZh/rQ9RJ9I9omWuC/nkyg07dwKYoAC9XZmMO+UuRePXoqH3XKjK9z4S3sR+66+DUdh/d4DbyiAwxsRHW0qkq81TVnyYLo9VmJ4SoMqgtoANUc7BHVTXIfxpzA8b6NHCL1D23aq+THzwyt3IWHaCr8wclVo4WFlvcIX+2ZW/hFoXosr64Zkrm7EcJa+U6w63VDa2L35bNb6BA/Gy2UeMejePUaSsehgUwtg+XEX832gb+NpwUEk0hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEYPR06MB5400.apcprd06.prod.outlook.com (2603:1096:101:8d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 01:46:46 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 01:46:46 +0000
Message-ID: <863b2400-5def-4bd2-8195-d71ce91f1c99@vivo.com>
Date: Wed, 10 Jul 2024 09:46:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] mm: shrink skip folio mapped by an exiting process
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, opensource.kernel@vivo.com
References: <20240709123115.117-1-justinjiang@vivo.com>
 <CAGsJ_4x1+T9+=WydkjsQmetGFOqzkOvhqQim5UOzytof5XHQ_g@mail.gmail.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <CAGsJ_4x1+T9+=WydkjsQmetGFOqzkOvhqQim5UOzytof5XHQ_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0053.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::20) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEYPR06MB5400:EE_
X-MS-Office365-Filtering-Correlation-Id: 1245805d-d19f-4f74-8977-08dca0822813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmE2bzc1SThWVHkxNDRDVjR2K3NLOGlRak5ZOTcreGVJREk1UmowZWNOR0My?=
 =?utf-8?B?bXRoRHRoWDFlbmo1ckdLU0lETTFmNXFOaTZNcHFkbXpWdjRSMWhMZlBiMWVy?=
 =?utf-8?B?WGVsc01tcyttMUhMbjdMUUVUVlJFY0N2ZDhHZWx5L2pnM0RDN05oSll4cjRW?=
 =?utf-8?B?TEh4djQ1aXI0dnBJQ24vZTFrWm9DZEJlNHVwcVpJdFJKbzJVRzlJZFpvZFd5?=
 =?utf-8?B?bXdBNlByMFhpMFNiMVNYLzJ0OFdoemJmVklya0NaaENyNGFwL0o3V2VJbVZQ?=
 =?utf-8?B?ZXZWUFJ1Q24zeFdmdzRMellKd1VONjhRV3ozUUpKVm5DYWVaRkNvQnVTY2pJ?=
 =?utf-8?B?VFRjRnNsZm1JVGxwWkxtQkN0c2Y1Q29uaEhIaDBicjZRaW1HaEVFMXdNSnBt?=
 =?utf-8?B?cHNaZFlrT2pQYXk3N0NvRjZhNUdmZXlRVndNMFJnYk9yWXdDay9PcXFRaXd4?=
 =?utf-8?B?dHZEZ2JHSnp2YzE3QW5pNGZYZkV6ZzlJQmFldjVRWkVxMnNMd2RNblRsZllI?=
 =?utf-8?B?b3FZckNNQkhoQ01aSDU0d1M0TTloeS85SE8xcmdxK1lMbE5Ba1diWFhnKzUy?=
 =?utf-8?B?czMzM1BCVVlmbWRDTWhWVVVMM2JGakliYUEweXo5UzNabjlUUzR5dFE0K01m?=
 =?utf-8?B?bm5hSHJKbUJBZUtKYTZJd2FDRXJORDlGWUNDdlN1RGdISDV3d3hGT0VGNmox?=
 =?utf-8?B?aExycEJQS0JQR0dzSWtMZEl1ZTdXcWV5dStyQWNIUFNZeDlvRytXZnRpNkFZ?=
 =?utf-8?B?Ykc2bXZ6UVlnUEZFZW1BbDdtMnZoMDZUbkpzM045UExoQ2hTVEgvdWV5bWZJ?=
 =?utf-8?B?c2pLYjVycXNHakFQTFFpNW9welNIblRwSlh4TkZGMjcvUnhCQUM2SENpRTNW?=
 =?utf-8?B?cjVPS25pQXdKRWNaaVdwRlJlUERCWWRxMjJVbFE3WnNaRGxmclhkYTlKbEJW?=
 =?utf-8?B?YzFuNkI5NWR4SWpwaXVCL0pUSnVYcWdIV2dsazRwdlZFSVhndjIyaWFBU015?=
 =?utf-8?B?RTZreHdQNVhNZlRKc3F0RHdjNkppOTBIMVl3N3pFc0JzWHE5S2l1bzcvbTNW?=
 =?utf-8?B?YTZzM1RNUnhjdzZBWmFZdXdjNFppSktoR1FMaHIvSnN5ZnJraE1rNk1EZ1Qr?=
 =?utf-8?B?bWQ5b3Q1Y2R4bElIdmdHNkNQdDd5YmJNbW9Nek1PVFFBTDlQQ1RlVTQvOWJ1?=
 =?utf-8?B?NlZqZUxCMm9LWllhaTBETDhaVXh5YUp1UTQzZU1mVHpZQTA2N2t0SlIza0tQ?=
 =?utf-8?B?U1l3a1EyWXIwUHFoTkdLTDVJZDExOUdlamdRc1c5c1JTYXFGbEJud3pna2tl?=
 =?utf-8?B?dmRMZnZ5RUh5WW5iblh0cTU0NlRZSHJMbGtseFV5LzkwdVRLSi9ZVkRRK1dm?=
 =?utf-8?B?TmtUZzVPb2FRTG0wVmEwUzBSb1c3Z2M0UmV2L3RadFdqWlc4U0g0TFN5aWFZ?=
 =?utf-8?B?VzZKa0R5R0tRK2lES3JFNFZkNW51UGYrUVhDeDBKSWtlSzkvNThrTW1sVy9Z?=
 =?utf-8?B?ckxvWm5Ld2dXYlViQjFZNDkvWHFsdEljajlQTS9pN25TR0w2NFc1UG5yTHNk?=
 =?utf-8?B?bmhDa3JUalhORVBFYW02bkxtaE5BR2I0UGFseDVDamxFdWR5SEsvSlU4cEZa?=
 =?utf-8?B?RTdDMXVxaWo1Yzl5TmxFRkdReHNIOEdZNW5VZWt4ZnNwclpLSXVQM3lCV3BW?=
 =?utf-8?B?ZHF2SDlvNEVtenQ2RVJtdjlObzg5ZDlKNHhEcU13S1VnWHhNeDFLVHQ1bXZX?=
 =?utf-8?B?MDY2OUx0YTdUS0FXdVg2YkUvazAwVXBoeW5Mei8zaDhsalg2Wnk3V2ViUHdn?=
 =?utf-8?B?eEFad3hVaVYwWlZOZHN1Ym11SzFiUHRNMC85dlBTazBnZWROUm11N0lxMU9Y?=
 =?utf-8?Q?v8AIeXmoGgqDI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjRxa3RPaTdjSGFtK2pGVHhoeU1IYy9WZmFZTDBEcEV0K3dhWk1lRDdXbElQ?=
 =?utf-8?B?cFNqSExYOWFTdVNkVmlsSVZPem94aTRHamRoUGhKeGJ5NVFaeW8yYWJCdGdM?=
 =?utf-8?B?WFFSZS9yKzB1YmtSdXp4UlF0V01yMVlTVHpCRElVdndPaHFoRTlZNHhMWEF6?=
 =?utf-8?B?ejdpVGlScW40ZkVnYUZEMEJMdVFZUng2MU14d1paWlA1N0lkMUtTcnEvZzZ2?=
 =?utf-8?B?K1BEakZkYytidmZuR3Y0dmpqb3hiaTRPMWFXdDlzRzBDTHU1RStqNnpCZytF?=
 =?utf-8?B?MDJyYkdlV0Z5UkpTYnRBb2hhWWVGb05pYTlPREZiK0xMUmwxQ1lSVXJkRUFs?=
 =?utf-8?B?N1l2RHVUbGRvcjFpNVZHUVVoOVl5M2J1aXg3dFNYWWZjTDFTcE83Q052bjA4?=
 =?utf-8?B?cFFYckxKRXVNWmJQdnNpbDhtenQ2N2lOTHo2SmpvNGRlZGpxRSsySjB2WTJI?=
 =?utf-8?B?V0hmN1hjV04wSUhRWXVaVW5WMW1hc2VtNUY1eG9jUlBhVWk4dVRWOUZXclU3?=
 =?utf-8?B?dUR6MnYrMFdUZG9vYitvUGI0dXlvOExaNnBVOTAvclBtVGhTRkhOQWs5ejBC?=
 =?utf-8?B?SFFhOXEvcnp0aTNHbGJhc21OV0NtU3A5c3pUd2hMeFRMS0FnWmxYOUdNWmtP?=
 =?utf-8?B?amtGUm9mRDc0M1ZXM2RaUVVwSWpPYzAxeUxZd2UvSDNrd1ltUml2OGhHc0lB?=
 =?utf-8?B?Ym5kbWI0RlFvRjJWamlpQjFKM1NMMGladGRFSlFXbWtVUjdWNW5VRFJDQUpQ?=
 =?utf-8?B?RUxUbEtvTThxTUdTN0dDOGgwWnJqU09mWGhmdERQejR5Wm1xWTh3SHdJbm9N?=
 =?utf-8?B?RUtuSUd5dEYzcHNXSjNnQW1QTit2UE5sZ1VFVWo4QVpNVzlwN20wc1ZSL0Y0?=
 =?utf-8?B?dStrTktOamJKam4rbTdPOEVxNHJpQ3lvT0JtSHhqbHI3emR1YW1hb0FZNGtu?=
 =?utf-8?B?REV1Zk5NWS8ycDU4OTVlZEhSZWxFbUdXYlZLZ3huZEJXQzhLR2xBNHFPcWx5?=
 =?utf-8?B?LzZoQUVOWU94ajM0T0hFYzRibkFHWlFxVkEzbXZWQi9UM3F6Nm92R3cyYUgw?=
 =?utf-8?B?N1hXaFlXWnFrbDRHcjdhQVhhdDlKdENybjIvNUJjL3N0Um81WklVOHdsWFkw?=
 =?utf-8?B?VENieCt0VW9oemxEakhQNmtRN21CeUs5dWozaG1QcjkvZ2RwWGkzQXc5cHVW?=
 =?utf-8?B?TUpSUzlNZW1SMVdaaEtzMENUU0xvc0lqUnBMSFVNVFhUenRGUWd1dlZhdGNZ?=
 =?utf-8?B?TjFwOE1WYVI4N3RVU1QwSlZVNE9IM1JjRjhYTlpJSnZ0eG9MWFJuQmFvZDJ3?=
 =?utf-8?B?S1Ayek5lVm0yT0FFT2tYT2IwL3BsVXJ1VXFWVElId1ZQRjZvN01zLzlITnZ4?=
 =?utf-8?B?Um42bFpTUXl4NWhmRnVmZ3VEUFdaWUxmN1c1dHRVMnNOczF1TzNxWi92ZnJK?=
 =?utf-8?B?K1lPMWphbklCSldnK2lOTUx5YmZtbXRHMmhiQ3lsL3RZaWhtQW9EbkY1N3hU?=
 =?utf-8?B?akFFcFM5U2tING1nZ0pMa1Q1dndBUTR1WGR5SDhVK3BYUnZzcW9EekpHeVVO?=
 =?utf-8?B?eGFpTGY5UVB0TyszYkNwaERkcU05OXBUMXRvbXk1UUR4Z012T055T2c3MTRh?=
 =?utf-8?B?WmowdmExOCt3TUZRa3Mrd2JrRFJXUFYwREd4NU50TEZpVVd6aGlFWFBuRVVS?=
 =?utf-8?B?SmFLWjNJazY4R2l0UnhHbFF1aHB0SW5vd3VjRjE1UHQ3S2FtcmNUT1kyaENm?=
 =?utf-8?B?NDVaZnpXeGMxdnU3VTUzd0ozc2Z6VjZtUit0bFlJaVV3cE5oM2daYkozeS9P?=
 =?utf-8?B?QUhjQ2d2enJzRjB4eUlHZ0wzdGFMV2lrTEYyTkpFRzIra0pOWEJNOU1tMEsw?=
 =?utf-8?B?WnBhc0ZHR1NiRm5YdlZxQW93cnRGSEp6L2YyQml4QXJZVnlKVE1PNGVnR1VW?=
 =?utf-8?B?S3llS1F4MndvTzlNL01hL3h0NzFFWTNiUVgrU01YZmFlMnNwSEFva0RVcEt1?=
 =?utf-8?B?OXZmK3lMeG1jdmFybVdWVEhJUWFya0l6UkF1ekFWZWV3eDUrRklkdEJBZkFD?=
 =?utf-8?B?WklpTHEwMWZQOWhuTldoQUhYZWVaQ3dnRUlrQ0w4SUFWdE1PTFpJcnFpZ1BD?=
 =?utf-8?Q?xM1Ji+tnpPilr4Se/4l5d/pyD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1245805d-d19f-4f74-8977-08dca0822813
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 01:46:46.0029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPgbIN4xW5hkMy4lDNpMj89Skv2d5rl3eO9QcUYWfOFdA7iLp5k9bK+RBje6TsWtl6OK0EruCe2rQe6H81BJIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5400



在 2024/7/9 21:02, Barry Song 写道:
> On Tue, Jul 9, 2024 at 8:31 PM Zhiguo Jiang <justinjiang@vivo.com> wrote:
>> The releasing process of the non-shared anonymous folio mapped solely by
>> an exiting process may go through two flows: 1) the anonymous folio is
>> firstly is swaped-out into swapspace and transformed into a swp_entry
>> in shrink_folio_list; 2) then the swp_entry is released in the process
>> exiting flow. This will result in the high cpu load of releasing a
>> non-shared anonymous folio mapped solely by an exiting process.
>>
>> When the low system memory and the exiting process exist at the same
>> time, it will be likely to happen, because the non-shared anonymous
>> folio mapped solely by an exiting process may be reclaimed by
>> shrink_folio_list.
>>
>> This patch is that shrink skips the non-shared anonymous folio solely
>> mapped by an exting process and this folio is only released directly in
>> the process exiting flow, which will save swap-out time and alleviate
>> the load of the process exiting.
>>
>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> You should have collected tags such as reviewed-by, acked-by you got in v6
> while sending v7.
>
> Again,
> Acked-by: Barry Song <baohua@kernel.org>
Yes, it is alreadly included in patch v7.

Thanks
Zhiguo
>
>> ---
>>
>> Change log:
>> v6->v7:
>> 1.Modify tab indentation to space indentation of the continuation
>> lines of the condition.
>> v5->v6:
>> 1.Move folio_likely_mapped_shared() under the PTL.
>> 2.Add check_stable_address_space() to replace MMF_OOM_SKIP.
>> 3.Remove folio_test_anon(folio).
>> v4->v5:
>> 1.Further modify to skip non-shared anonymous folio only.
>> 2.Update comments for pra->referenced = -1.
>> v3->v4:
>> 1.Modify to skip only the non-shared anonymous folio mapped solely
>> by an exiting process.
>> v2->v3:
>> Nothing.
>> v1->v2:
>> 1.The VM_EXITING added in v1 patch is removed, because it will fail
>> to compile in 32-bit system.
>>
>>
>> Comments from participants and my responses:
>> [v6->v7]:
>> 1.Matthew Wilcox <willy@infradead.org>
>> You told me you'd fix the indentation.  You cannot indent both the
>> continuation lines of the condition and the body of the if by one tab
>> each!
>> -->
>> Modify tab indentation to space indentation of the continuation
>> lines of the condition.
>>
>> [v5->v6]:
>> 1.David Hildenbrand <david@redhat.com>
>> I'm currently working on moving all folio_likely_mapped_shared() under
>> the PTL, where we are then sure that the folio is actually mapped by
>> this process (e.g., no concurrent unmapping poisslbe). Can we do the
>> same here directly?
>> -->
>> You are right. we might use page_vma_mapped_walk_done() to bail out.
>> (Barry Song)
>>
>> 2.Barry Song <baohua@kernel.org>
>> By the way, I am not convinced that using test_bit(MMF_OOM_SKIP,
>> &vma->vm_mm->flags) is correct (I think it is wrong). And exit_mmap()
>> automatically has MMF_OOM_SKIP. What is the purpose of this check?
>> Is there a better way to determine if a process is an OOM target?
>> What about check_stable_address_space() ?
>> -->
>> Sorry, I overlook the situation with if (is_global_init(p)),
>> MMF_OOM_SKIP is indeed not suitable. It seems feasible for
>> check_stable_address_space() replacing MMF_OOM_SKIP.
>> check_stable_address_space() can indicate oom kill, and
>> !atomic_read(&vma->vm_mm->mm_users) can indicate the normal
>> process exiting.
>>
>> I also think we actually can remove "folio_test_anon(folio)".
>> -->
>> Yes, update in patch v6.
>>
>> [v4->v5]:
>> 1.Barry Song <baohua@kernel.org>
>> I don't think this is correct. folio_likely_mapped_shared() is almost
>> "correct" but not always.
>> Please explain why you set  pra->referenced =  -1. Please address all
>> comments before you send a new version.
>> -->
>> Update in patch v5.
>>
>> 2.Matthew Wilcox <willy@infradead.org>
>> How is the file folio similar?  File folios are never written to swap,
>> and they'll be written back from the page cache whenever the filesystem
>> decides it's a good time to do so.
>> -->
>> What do you mean is that the file folio will not have any relevant
>> identifier left in memory after it is reclamed in the shrink flow,
>> and it will not be released again during an exiting process? If that's
>> the case, I think we only need the anon folio is skipped here.
>>
>> [v3->v4]:
>> 1.Barry Song <baohua@kernel.org>
>> This is clearly version 3, as you previously sent version 2, correct?
>> -->
>> Yes.
>>
>> Could you please describe the specific impact on users, including user
>> experience and power consumption? How serious is this problem?
>> -->
>> At present, I do not have a suitable method to accurately measure the
>> optimization benefit datas of this modifications, but I believe it
>> theoretically has some benefits.
>> Launching large memory app (for example, starting the camera) in multiple
>> backend scenes may result in the high cpu load of the exiting processes.
>>
>> Applications?
>> -->
>> Yes, when system is low memory, it more likely to occur.
>>
>> I'm not completely convinced this patch is correct, but it appears to be
>> heading in the right direction. Therefore, I expect to see new versions
>> rather than it being dead.
>> You changed the file mode to 755, which is incorrect.
>> -->
>> Solved.
>>
>> Why use -1? Is this meant to simulate lock contention to keep the folio
>> without activating it? Please do have some comments to explain why.
>> I'm not convinced this change is appropriate for shared folios. It seems
>> more suitable for exclusive folios used solely by the exiting process.
>> -->
>> The skiped folios are FOLIOREF_KEEP and added into inactive lru, beacase
>> the folios will be freed soon in the exiting process flow.
>> Yes, the shared folios can not be simply skipped. I have made relevant
>> modifications in patch v4 and please help to further review.
>> https://lore.kernel.org/linux-mm/20240708031517.856-1-justinjiang@vivo.com/
>>
>> 2.David Hildenbrand <david@redhat.com>
>> but what if it is shared among multiple processes and only one of them
>> is exiting?
>> -->
>> Modify to skip only the non-shared anonymous folio mapped solely
>> by an exiting process in next version v4.
>>
>> [v2->v3:]
>> Nothing.
>>
>> [v1->v2]:
>> 1.Matthew Wilcox <willy@infradead.org>
>> What testing have you done of this patch?  How often does it happen?
>> Are there particular workloads that benefit from this?  (I'm not sure
>> what "mutil backed-applications" are?)
>> And I do mean specifically of this patch, because to my eyes it
>> shouldn't even compile. Except on 32-bit where it'll say "warning:
>> integer constant out of range".
>> -->
>> Yes, I have tested. When the low system memory and the exiting process
>> exist at the same time, it will happen. This modification can alleviate
>> the load of the exiting process.
>> "mutil backed-applications" means that there are a large number of
>> the backend applications in the system.
>> The VM_EXITING added in v1 patch is removed, because it will fail
>> to compile in 32-bit system.
>>
>>   mm/rmap.c   | 14 ++++++++++++++
>>   mm/vmscan.c |  7 ++++++-
>>   2 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 88156deb46a6..bb9954773cce 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -877,6 +877,20 @@ static bool folio_referenced_one(struct folio *folio,
>>                          continue;
>>                  }
>>
>> +               /*
>> +                * Skip the non-shared swapbacked folio mapped solely by
>> +                * the exiting or OOM-reaped process. This avoids redundant
>> +                * swap-out followed by an immediate unmap.
>> +                */
>> +               if ((!atomic_read(&vma->vm_mm->mm_users) ||
>> +                   check_stable_address_space(vma->vm_mm)) &&
>> +                   folio_test_swapbacked(folio) &&
>> +                   !folio_likely_mapped_shared(folio)) {
>> +                       pra->referenced = -1;
>> +                       page_vma_mapped_walk_done(&pvmw);
>> +                       return false;
>> +               }
>> +
>>                  if (pvmw.pte) {
>>                          if (lru_gen_enabled() &&
>>                              pte_young(ptep_get(pvmw.pte))) {
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 80f9a486cf27..1d5f78a3dbeb 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -863,7 +863,12 @@ static enum folio_references folio_check_references(struct folio *folio,
>>          if (vm_flags & VM_LOCKED)
>>                  return FOLIOREF_ACTIVATE;
>>
>> -       /* rmap lock contention: rotate */
>> +       /*
>> +        * There are two cases to consider.
>> +        * 1) Rmap lock contention: rotate.
>> +        * 2) Skip the non-shared swapbacked folio mapped solely by
>> +        *    the exiting or OOM-reaped process.
>> +        */
>>          if (referenced_ptes == -1)
>>                  return FOLIOREF_KEEP;
>>
>> --
>> 2.39.0
>>


