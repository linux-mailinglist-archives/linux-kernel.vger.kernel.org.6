Return-Path: <linux-kernel+bounces-308315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F43E965A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A373C1C222E6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAD316BE2C;
	Fri, 30 Aug 2024 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mhIMKhcZ"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2070.outbound.protection.outlook.com [40.107.117.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB4B14D294
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006341; cv=fail; b=aVfrAFU/z93uANTEVDTzgGItvmwPnVmO8if02jAnfI7/6uLM1y4klNzmGiGhcSj+QPb59afhKAzpERZ/wvAZqLySh0CpI2rNG1ugGE6BbA88yIH2z3XITYYg8cT5rMFt/CEVkKpzBOy7rEskC8YZChD3i5s5mwOOe9LX4pxotYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006341; c=relaxed/simple;
	bh=c4tz3IulqtiIihO1xHCkMGI4vE7pLdamKojFRM3DJMg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HD+zx3vampQgPXJrPQn9opD1993I6ESztei2vCQoHuYjX9/xlKy2HsAzkBzfcM45Uo829UG4vKjlroqDv0UYDv1PkFI9Zmq+HC/15QgvmRpOesqSfkjrcSndvXtTttiPmej4bOZ2gbd9RQ/ZtZo8RbQcUkRDrtZOoNPKdpsknAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mhIMKhcZ; arc=fail smtp.client-ip=40.107.117.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADcvMCCpBB2+JHBzyFRN0SXoQNe5Rer53tQYZgZy6OZUXzqrdDzJW+6jx6wowvEuPrCztqL+zwecOozrJfF/uRTSAVE+aaeju3xrCXrVHd4p3woTg7dzeCz0uvSm44g+QuvFQtLsFkIyG0txE5w4cha6sxI68+Zu7Ne6udb4bkwTgJTUj6wYleueM4wQLpMim2FDQIPidtYt32KdZiHeBysxzIust2rMXDM/93UYRLOK8nUKvOrW2UORoFWz0KlNTkBrLFt7mY47KKRL6iDa6KNilw+KExlCrcZHobMDCWXRwm2cZ7wWmgY6GUnMmJpHdosH0VUxMviKJHdQX6bvvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pwt8d6Ss9V8Js0fXhUSfvTJMQ/A4SUJtX7fMSeakS2s=;
 b=ABsqLvFmXfQtLon8mq5ByyNWoGHGBmXqoOX7R3f1Sidpy3EuJsWONtDSkBjFkZBzn55neHBXBFFuiF4TXnj05yI9Erv/xrtMnRo4eLsbPFCK3mBsRbDKGpu5wS2bqUgndMZklx83n2vo8qaGWiOszN0L9DE5Mk++C3WegwYeh16Azjjo7qq8Ep7mVpTDI7JRF4toJLTrBCaiG5ECQTjaOHxUMZKJaWYqxX2CD3D/WrOIeYIPdW/fOjps2uDG7gEaElw7aDMR5Cn2YS7cDPgeFD+jOMCkb6x1cJdxknWxiBBntZbITw/TIUOHXg1vdcT/ID3nIrVf5zDngEGCGP3e/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pwt8d6Ss9V8Js0fXhUSfvTJMQ/A4SUJtX7fMSeakS2s=;
 b=mhIMKhcZD4BJ8+TLPhjn0+Z4uTJG5nV2ts8ClDDb7MxPk/fIYjZA3yDtYNX9XFl2dfHLaHM9HbQq7QHr13ucDGaL11Zv6vkQeOCNLlsZ1Rd9n3T2rCSucWm3QFvr/mNBgjCgqjkXmWAOBGe2AW9ZhBPbnBQfDqY2udmwFpxq2QcK7zSlAHWrwvHnj2SC2w6jFB7wxURChXtxDdhK6cMMbYfDPMHmPKi83/cN5UMYcpP3y9knBOO83cOEdD21Ozak1n3ZCbMtWqjZwhoRYV0gCZi63oFkx5g7XNPVgaRbHQpzdwVKdhstQP6V0IlgluB2wx1zQ9t1PjkivZmAOVvASw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB6062.apcprd06.prod.outlook.com (2603:1096:101:d4::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Fri, 30 Aug 2024 08:25:33 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%6]) with mapi id 15.20.7897.021; Fri, 30 Aug 2024
 08:25:33 +0000
Message-ID: <5bf1f2f7-07b6-436e-a5b6-68fa63103858@vivo.com>
Date: Fri, 30 Aug 2024 16:25:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Delete __init region from memblock.reserved
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Petr Tesarik <ptesarik@suse.com>, Baruch Siach <baruch@tkos.co.il>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com, Rong Qianfeng <rongqianfeng@vivo.com>
References: <20240830080020.33666-1-rongqianfeng@vivo.com>
 <CAMj1kXGhiz5SHxABi5UwZvd_Lx-EpvfQ2_isPu-X7jmi3dogdg@mail.gmail.com>
Content-Language: en-US
From: Rong Qianfeng <11065417@vivo.com>
In-Reply-To: <CAMj1kXGhiz5SHxABi5UwZvd_Lx-EpvfQ2_isPu-X7jmi3dogdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0027.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::9) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: eec6f251-0e60-49f4-165d-08dcc8cd513b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0pLZm9zU0FCQ0JWVDBLMnY0aTQ4bUt4WlkwY1ROQnRNejBoV2VmNVh2WFNP?=
 =?utf-8?B?VUlhdGJEVU1IZElBR2JpVWhJVEhuTUxLVGlYVzB5VjdCQUdLQkZnODRTL0V0?=
 =?utf-8?B?ZTYrVFhuSWxxc3hLOExXZGJzdkpJYXM3a2FJZXFwUzFIUzhFRDM5VmtCYWxu?=
 =?utf-8?B?TmxIMTF6WVo0dFR1MnlFRDBYWk1UZU5jOElqMXlXNDhDSE5kZUx1anBBMVRk?=
 =?utf-8?B?VkpBeUNlTjZMbHFrNjNtZkFiTXBnc3h3bks5czg1Qk04bFRvSEhhKzAxbUhh?=
 =?utf-8?B?YkZCU1hiUmFZcVEvSHRNRjQ5MmI2MGluelZqRzA2UjY0UHRobG5VSzE2RTRY?=
 =?utf-8?B?MFl2Qlk3UkUrMFRRRDFXTzNOTnhEVWprZ2h0NTZYQ1FzaHBqYnMraHRkbUxI?=
 =?utf-8?B?NHBPOU9PWmhwa1UxaTdiWm91amJxM0poZHlVOFYzemFkUEdoZytrL3pKaGIw?=
 =?utf-8?B?elhBM1R5N0xsRVJIUmVneVY5QzFXMmovK05HZlFnbHV1SmJ1WFdTUjhPbElO?=
 =?utf-8?B?M3Y4SkppYlpuTGdzKzJmQ20xTWcrWlo0M2poT0hEZk1qTE1QcW11a3JGWmhW?=
 =?utf-8?B?eHR6N2kzaGd2dlE5SXR5cTdseHhlazJzQXBEWUt1bDRuZUt6eXlIbzdQMVBG?=
 =?utf-8?B?NnU1V0tONnYrOVZHQ2RWZHA4VVFwWnhtWFQ5aGUzdWlqU3IxbENZL1dVamk0?=
 =?utf-8?B?azh6Tk1lS25mZjhXSFJHT0VDMDhodGZCOUNHQ3RCaS9lTStYOTFWbmQyeU80?=
 =?utf-8?B?emU5RnJ6aVhEZThVc29OejJ4cGErUnVmaFdPOHZ3aU4wZFJoYlFEemtkN0JQ?=
 =?utf-8?B?T2FoVzJYaml1ejNqakFDMjc3QnNsYUJYanN4b2lsdzhnSEF6Z3hmaHpCNTZ1?=
 =?utf-8?B?NEtVY1pnd3ppTmFjM0Rzd292RHZGYUVZMmVvRTRIY0trZlZqR0dRdXRtbWNL?=
 =?utf-8?B?R1ZneWFvNm1qcUI4RTlPS0lUdmxLRmQ0Vzk4ZnVIV3gyU2dveFl0Ri9xTGlP?=
 =?utf-8?B?dHczdkF5TXdVRWhjaS95OHRVMUUvL09qUCtneU9lQzRsRGN1ekZKaWJpdEJx?=
 =?utf-8?B?eC9NTitiZTZqZnFxV3V4U2s4RW1jYm50dDhqdTVlNjZhUkpjYzVKcGx2cG9B?=
 =?utf-8?B?RVYrc0NTMmljRlVJampNUHE3WjkvNTlEL1FnODVuTUhVRlhxYnRsTVQ3MkRr?=
 =?utf-8?B?UXc1WkJSQzFKNlM0NDdZSmxCTlVDcUU1cExEdjVFdzcxNDlsQTFWbGYwQWk3?=
 =?utf-8?B?VkR6TEh1ZGNIWXdRTzUwTVFVbzFKaWpuemZOR3FCZ0swY0FEeWNSMmtuc2h5?=
 =?utf-8?B?MWRmZFNHSVhwOWFYdjdnbGhDTzV3Uk15SUVXeW5uanVpenV1VmpnUUkwL2lZ?=
 =?utf-8?B?QTQ4Ti90MFlDaTZqUVVQZmpCV1dIa3BBb2pYdlZsL3BOTnRPY1ZVQ01Yc2xY?=
 =?utf-8?B?Nm1icFJjOUlqR0VVcHBFR2dmMllEaStUcC9iN1ZJRlpES2RuWk1sMjJ2OWxJ?=
 =?utf-8?B?WVRRZHhRNytHdHBRWGNidDQ4ekxEVE0wcHBtVUFIa1R6Ylh2QTJTNytTUzNn?=
 =?utf-8?B?cmFsY3RTY0JQZlR3UzlKNVhsdWJ1WFN0RzVFVVNPeFpNeFBOOExsb2dqYlpi?=
 =?utf-8?B?c1VPTkhGdDc4d01LSGhFdHZTOG1FeW9zS2NreVRpektYSkFsb0VsZ2hNaUx1?=
 =?utf-8?B?OVNUT1FHUEx3TldrUjFZeS9xR1hiVnFoRzdrYmR0SkwrNy84cHZ6dHZaV2tH?=
 =?utf-8?B?MVh3VlhaMzdiNHdzVVlYdjdlT3hpTTUwR0ZOZ1lUNFZMcWpFQkRqMWJOR0V1?=
 =?utf-8?B?cnJhaEpDYWRIUnRnekFnSDl2bS9vOENzSEpMSTJwanB1UkpocmZjN1FacnFo?=
 =?utf-8?B?c2pPSzE2NTkyUnhqWnc3MHg5WW1FYVY4Qm9rckl6cHpNYVRxTzNEL0JNOFNs?=
 =?utf-8?Q?JmhogWItQmo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGxtMDVvUlIxWXU4SW55aC83VFVZNnR4ZDRwaFRUU2VqUENLVEl4QVNhSktU?=
 =?utf-8?B?QWV3aDlpWEpFd29YKzNzcVVPRURQVUhkSDRUTmVjMlNXVG0veFNQLzFISmJQ?=
 =?utf-8?B?anZuemk4NGxWcWgrT2ZGQ29VNytjYUQ1aWRVaC85Y0dPRnNFWjBUVFFBSGRC?=
 =?utf-8?B?NlhvanJYbGdNMGFvSHRhQTRuUzl4bGpwNEkwSG56YURXYm5QSVY4clhGTXJW?=
 =?utf-8?B?UlZwWkNzMHpOT0dCZTBQQUthN1FrVGptdWZJd0Q2b0svU0JJVlpVdGg2Z0hZ?=
 =?utf-8?B?Mzl5QndZU0ZNbUdWOXl6UnE0dmg4cEZKczNHQjMzN1A1R3BxYUxjRkRocjJS?=
 =?utf-8?B?SFZDcE1HT05ZMWptQW1UVlQwTSsyUFFuNE81Y2RNSThSYjdqWlNLWGErbEtn?=
 =?utf-8?B?U29MN213UnZmU3NSRkVyVkJZMkRORFBNWjhoYVFnNmhPK0RMQ3lyS0hMKzBU?=
 =?utf-8?B?SURlTmpDNDBidXFieE5JcG05dm9DUGZNVjFjYkJTZm5qVWtOZGhYcklkRCt5?=
 =?utf-8?B?UUFXR0h1UnhyTllnaUZsSVBnSE0yN2ZwSHk0NUxlUWNTUVc4ckl1WGpaTmYz?=
 =?utf-8?B?cU9YeC82MVFXTURKc2FnMS9hNTZaYjRvSWpLTGIvMElWMCtxYis4K0JCaSsy?=
 =?utf-8?B?WURBR2FseHRUUyttUE9Ra0tIZWZDSStaVm9PYVd6UUNXOTlFZ3FlaFFtcXJn?=
 =?utf-8?B?UFREZUszZERaem5aZFNXdjArWWIyM3lGcWRVQ1BEVFEyMjBUVnFFVWxvMjFL?=
 =?utf-8?B?ZDZtQUd2bGlpbGNGelBmT2tiNEJ5SEZRaGp5bUpya0ZldUgxejBZZDFnUHhZ?=
 =?utf-8?B?N2lDL2p4QTNmQjhWa3BQVjJNbVJEcG9JM3ByRmRleGVYb1kyNXR3WTRybTdG?=
 =?utf-8?B?dmtKRUJkcS9kRURDU1NNYzk3NHo1SzRCYWRDQjFIR3lGakwvQ0txWWNOQWcw?=
 =?utf-8?B?Tm1wbzdFRFFqTDlyZ05JMkZneXR1MTVKK0RNV3lqZzA1MHFDMjdnQUIvWUF1?=
 =?utf-8?B?RDAwSlBWcWYyKzhXaVExUjQ0d3hYZlArZVF1cTBnL0tvVW02Y1E0cEgyTC9m?=
 =?utf-8?B?UThSNHQ5ejJJbEFXMXZWSXRQbEovZUVUWXJOa2JieWFvTzM4NFM1cm5GY3RK?=
 =?utf-8?B?Mjl0bFZiVVFLVUExL1lUaHRXUVJHYlFDTDhPTjdCVjljMEtJaVFBL0paU0xp?=
 =?utf-8?B?OU0zYmdUMXJoKzdMVUlzSzR2d1ROQW5PeFJFWnppN2g3ZG1zc1cya0p6TEll?=
 =?utf-8?B?YkFXVUJXUmRHK3NEeHNUNmVPM1dZL1diNjVQVkRUcVg3WEZibmlHb3pvOTda?=
 =?utf-8?B?Tjc2aWFhMzRHOWl2cmFDc0Ria21FenJ6WHhhQk1ENzNYS3QrRFNpQVBtTHNB?=
 =?utf-8?B?d1UxZ2NGOXR0TjVKZ1BrN0JpR1pxQ3d6bjhxZWxxSkN1U1M2RWEwd1g1cTNT?=
 =?utf-8?B?aHN3RDZSN0NqQmNmckx6MUplbktTc1NjNjcxL3cvSXQzQmM4L0J5UmpCT0Rm?=
 =?utf-8?B?bEpIVllYN2FscnNDT1NuNkg5L2daaDl4WnNnem0zSG1ZU09TYjdZcFFzQTV1?=
 =?utf-8?B?dE45blVGMjA2M2NnQ2RqcGR0TWc5c2ZNb0FPU0lPbUhkYTRrbGdCL3Q1UEZ5?=
 =?utf-8?B?aUtQdmFkUFo0ZlRuaGpydUhMaWw3aVhBWld3cVRzUmtzTEVWeDdQWGUrQzFt?=
 =?utf-8?B?akY3TlA3eHVQb2ZBUGo0R2FOeDRzZ3VoNXhkQnQxd21qeUR4d3FwTWFXS0Nr?=
 =?utf-8?B?UkZaczN2dDgwa0pka0ZkREViQnd6ZXo4RDhTTmhyOXVhK3grdG5rYWtGaDBF?=
 =?utf-8?B?V2pXRzl2R2sxdjczRkZzaWVQM1VQVXJOZUN0bzV5Zks4dDlSSGhxZHhuaTdn?=
 =?utf-8?B?VEc3am91VnRqR1lYYjV6MERTcXU2QWJna05TRUM3UG9Ha2c3bDRleFB6M2hZ?=
 =?utf-8?B?bGFvQmdtUlZSdWFEZUljSnY3MG9ZOTZsd0lXS012MHdRM2xDQmdQTml1S2ha?=
 =?utf-8?B?RlU1ZGYwN3B3a3NRdS92dkJpMXF2NmlIeUtFcHZLZUxOQkk0WFFBZVBjYzNa?=
 =?utf-8?B?RVVMT0loa2VWR3ZaR1JZamtxWTNYMDJHaEV1K1QzYWlldFovaGU3WXJIR1Uz?=
 =?utf-8?Q?2v8l72k+1emrhCqVeUiEQIfu8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec6f251-0e60-49f4-165d-08dcc8cd513b
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 08:25:33.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uO+D8sMxRQayyvrooqq1wPaCJoHg9krm2LOPGX9BkVTJA5viMcq5ajsTAuBrDJKw2pN+sRw1MAKBPGGHO77b5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6062


在 2024/8/30 16:14, Ard Biesheuvel 写道:
> Hi Rong,
>
> On Fri, 30 Aug 2024 at 10:00, Rong Qianfeng <rongqianfeng@vivo.com> wrote:
>> If CONFIG_ARCH_KEEP_MEMBLOCK is enabled, the memory information in
>> memblock will be retained. We release the __init memory here, and
>> we should also delete the corresponding region in memblock.reserved.
>>
>> Signed-off-by: Rong Qianfeng <rongqianfeng@vivo.com>
>> ---
>>   arch/arm64/mm/init.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index bfb10969cbf0..99cfa217e905 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -402,6 +402,13 @@ void __init mem_init(void)
>>
>>   void free_initmem(void)
>>   {
>> +       if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
> This is always true on arm64
>
>> +               unsigned long aligned_begin = ALIGN_DOWN((u64)__init_begin, PAGE_SIZE);
>> +               unsigned long aligned_end = ALIGN((u64)__init_end, PAGE_SIZE);
>> +
>> +               memblock_free((void *)aligned_begin, aligned_end - aligned_begin);
>> +       }
>> +
> What does this achieve? The memory is already being reused by the page
> allocator (due to free_reserved_area()), and the memblock allocator is
> no longer usable at this point anyway.
If not,  incorrect information will be visible in
/sys/kernel/debug/memblock/reserved.

Best Regards,
Qianfeng
>
>>          free_reserved_area(lm_alias(__init_begin),
>>                             lm_alias(__init_end),
>>                             POISON_FREE_INITMEM, "unused kernel");

