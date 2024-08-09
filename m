Return-Path: <linux-kernel+bounces-280614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E88A94CCD2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93939B214CF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F2C18F2DB;
	Fri,  9 Aug 2024 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="AziLc0sz"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AEDC8D1;
	Fri,  9 Aug 2024 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194104; cv=fail; b=Ee3f8KQVi4qDbOhmMWpOouklJM0tWRAM5FGJzaUZEjo78LinN/IFCIA0luVCJS8L97MKaYh2P8Qb+6k53rmEf2Fsftxam6Sdd+Pazm6UURHFGzsAFW0Pv/rJr9/57zeQP5cc8e37ah6gT4YdL6RlpGAJAT8oQtwWzgTe86HY4ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194104; c=relaxed/simple;
	bh=yP6imWv3KaG1w+w66fS1QKTsaVDh2EtiLTwr7g8RPtw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qh4Yc8YlQpfhxiJvjbyD1nozX7tLDm1RfAXv8YU2MqwUQ3hRLEYeyUCOLkA+RkU/Bxdpt7GKJ3GBel7/padTcBVpVLUGPkZYpAdnr8nmIY6wG7NdHrzoFMAuDBov5iJiCTyHC7pa2NOgBz9g9+uL+rXM0xkP4idGhaOpC+fo0rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=AziLc0sz; arc=fail smtp.client-ip=40.107.22.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAlWAAm3WzumSQpTVymoqo9O/N9l0ZaINFeqB+U6/G37rOwVcNaxQF7UgAAPya1CrobRTnpAdcvh5rjZ1INneW3SIQg8DS+O4i/BJF11AYJGA+xTP3Bo+sHEbSS8Jvdl2oPszh8FFgkcBsaGK21greuBBrH9/2/rShNH5MN/+HHZ6+fQv+f+S1VqtzJz30qWl5fnS4NU5+2abIz7zSd8+1LjQcIRuE7yXCUNjtQE9ELyU+mXNF79nI9jA/2HbCyTtxuYfXPbmQRMIkmwBjJ2Vn7DpuPI0Xff+GSnIuUN3LqTD7FzYqLaRLGcGrF9J+Ty5UiU8UF3ae3mnXtzJHyiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yP6imWv3KaG1w+w66fS1QKTsaVDh2EtiLTwr7g8RPtw=;
 b=VXywM1fJ656gAbwXZE/nQpjBqkLnjL8GLPPC4yokUBGKzMkVbn+2fApOt6D6nu6LhUNUoKgns3ju+5d2et9+8FeZRFrrwS2hMwTwGVNLDXwDHFO0WDAWWtvMJ2kb+QeCpy/Mw0kGvOsvcL8qsfPGErqhetEhLVpcp6pUBmqRuEGRsju4+xE9PDEKlFg6NpcPeJR5P9/dolRWZq+KTJ2oVDgzcL7bpGNnj4WTwTIHxBplb5OsARqzcLExJN3VWe93bHrIuh0EJ7dZ+sKxYRuxaacM6OC7fBgZ5dH4G+cBAv8Bm1CGgkV8fSpVA3Y42ijCNBUzsuM+n2o4pHq3jdr6/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP6imWv3KaG1w+w66fS1QKTsaVDh2EtiLTwr7g8RPtw=;
 b=AziLc0szFA5ZEOPe6p8IFfSRKDUK97P6WT/SvdrDF4QrclEnNwgwHz4jYfqOl5dYodZOpS3asoTDML+5ay0Zam/2k48QiB/7p54WEJ9BGh7BPE1a2xrWekfa05sj4/1awWFILbg6vlraHNWCIc1NvqyxBnf/euOwrkrXappD0wyvCMDj8BV+cr/1zl49a00mtu92EKU02k3B8g6fv5HFpRWQCgcecpKKfOV5MiATdWqcAQG0RhXGsWOZ/TeLlRFn9SNUKaF/XMqY99Bl2ARV52GHG0Qa0KtEKFlxgLbvVgt9TuanJNThk5SU9PIB62PdfEKsRp/ILME0jzmVIKo2kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DB9PR07MB9173.eurprd07.prod.outlook.com (2603:10a6:10:3d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 09:01:40 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%5]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 09:01:40 +0000
Message-ID: <2e87176d-5c12-4043-9b83-f3d42bc8671c@nokia.com>
Date: Fri, 9 Aug 2024 11:01:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of/irq: Consider device address size in interrupt map
 walk
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240807120153.1208858-2-stefan.wiehler@nokia.com>
 <CAL_JsqLciDTxfeKwuNNWEOZjrUDFp9g7ZAzTuY4nQ1GCwPmaow@mail.gmail.com>
 <9d19cec9-3e40-471c-8c76-8842a5d86973@nokia.com>
 <20240808174953.GA1670999-robh@kernel.org>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <20240808174953.GA1670999-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::8) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DB9PR07MB9173:EE_
X-MS-Office365-Filtering-Correlation-Id: f754d79b-dc69-4c37-1d85-08dcb851e1ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXBDUmR3eWZpS2JqcXBwUVZ0MUNpYjdJdURnMHY3QVV1azVLa2Y2SWsvUVda?=
 =?utf-8?B?akxxSmplclJTYTFWNEFWaW9yaS9McEFXS2o3cG1WcU9wZVpsNHBrVDd4QU5X?=
 =?utf-8?B?amlyTEE5WUo2WHRBWDV1SzJEUy9ZV0lNV21nYWdvQ2JHMmQ2REdFTXA1NTJq?=
 =?utf-8?B?ZTNjTzVxVEphWnRKZVNMMlo0QzFDZlY5VW0rWkt2Ynh1RWNXQ0FOZVBmSTdX?=
 =?utf-8?B?QnF6N1RtemRHeWRzaFdlMTYwVUxxZUJGM1RRRGJ1WFd0c01xeU9WNmFpTjg2?=
 =?utf-8?B?OU0wTGFHVXJhejFwcWJScW5FSGRJUkg3ZVpuMEZVK2lneERhMzlMSlhNS0Qv?=
 =?utf-8?B?cXM2NHRQZnFSVnZMUlBBSEFaVUhJMzJWN2prZ1Ivdjlza2FWOWcwaXJHZVVi?=
 =?utf-8?B?L2p5cWsrZ244a2t6Y3ZPdUttRW5VRUhCbmRVOWhJUlpCMk54QkJia1NTYzUz?=
 =?utf-8?B?cUxSaktudEtldzVqRXNiamNja0xBYmFGYUR5YzZkT1NNQmhpM2xhRWpSSkRV?=
 =?utf-8?B?aStBMndKSXZqVGFvLzFTaUN5RUc0VDIyaDdSN0d6cVlMT0Y5SWoxa0dya3Nz?=
 =?utf-8?B?SVROYWsxV29lc2RONElsR085QkRaVXRMMnBsbFlRdmJGTDhENE5nanRNaHlY?=
 =?utf-8?B?aHlKTXZRYTh3eDQxSGU5alo4N2dXK1JoMW00aGdtMUhCNHBlMFMzNm5XQjMx?=
 =?utf-8?B?bmdicWo2YWJubm5Hc3BXN3h2ODJFU0JJYXJJcGFmQnhiVFh4SFFyc1hiUklM?=
 =?utf-8?B?OFgvOGNGeE5oNkZVWlI0d1hMeWU3K1BiTlZHTEZhZ0FXVEhRVE9sM3BkZ040?=
 =?utf-8?B?WWJBVGJNU0N0bWZZVzlkb25TMWRNSnc5eTU2a2ZFY1lDODVZd0ZaOHNZWHhF?=
 =?utf-8?B?ZktOREc4S29SVWRsMU4xUWV1K2FtZHZqazJDazNMWTY1MCtTQzUzNnBZVDFi?=
 =?utf-8?B?ait6SWc4Sk0wTk0vbU5Ya0thc2JBQjY2VTc0Ui9OSXlUc0o2QnhpM3Y1Y0hz?=
 =?utf-8?B?a3d1MkNHaDgwV0Y2elMwMTUyN2RlU0pFVWJ2cmFQYkVlNmFzb1JlMjVPeDB5?=
 =?utf-8?B?VG04RVQ0cHZyQ1BkN1VXcWZlYWVMajgraFMyN3pGbmZKL0llRnpBSytvZXQ4?=
 =?utf-8?B?RHlwVUhHdUxENUQ2YU9Sd3Nzdnd2emRrbGRlVXk1Mm40OE5HZUpuNnBpQmJO?=
 =?utf-8?B?TUwwOEdwS3NaS0JCL1l2ZklYM0E1Tk9lNy9DQ2JkTzJESm11Z3d1K1BJRGhw?=
 =?utf-8?B?bmFFeWlMZ3pqWFRPQ3QxdndEMlJtdGtrSHg4Mms4dkx3TElJamtVWU1kUmRR?=
 =?utf-8?B?Z1d1UVBiUkVOZHdxVTM1d0lLYkxoWFpQa1ZCV1IyMDJuWkNRMTJENUI2Q0NG?=
 =?utf-8?B?V2JFSWVkc3JGTnBGL3l2SFpsRThyWWhkeWUyZ0ttRGoycm5XN0dTU3FWZXFZ?=
 =?utf-8?B?UDgwS3JFbzZSMVViajFwOUowTEkwd3lZb3U3QjVnNHdieUVWYlZiMlBWbTFN?=
 =?utf-8?B?WnhrSC9ZdC9GR1NubDZqaGhaVEx3TlJwZHE2eVRhaFUvb0laMUVZT1NjTHdt?=
 =?utf-8?B?NTNPcFpKZmJiYzYzdGF2QjJBUXR0Z3o5RUlheUF2R2MyWW9TUDZxTllmVTZY?=
 =?utf-8?B?VkFNQ3dUZVZxZnZ6REpuMXJ5Z2hZaS9OakJuVk9URTN5dW9QeFl4TG5ndkVL?=
 =?utf-8?B?dS9aOEttQTBRdlYvdWxWVVVVV0hlUGJjWmp4R0o1Rk93TUoxOTRMRGdTSDJ0?=
 =?utf-8?Q?udbLyfHsy4MiWI3/7dJgsIPuVlSR2+11XSaZ6h7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2NlelZvVFgwdjJoMGJ6c2xYUHZ1emNUNllWOEFwZDNlZlhORG55SUUwQjNL?=
 =?utf-8?B?RjNsOXR4UmFIZ0N1YS9XNllYaUhMYzJRQ2ZYUG1XQ2ZaMWJuTzRGdFcwR3Yy?=
 =?utf-8?B?NEhwVjE3clpqU0o5MGNnUnVac3hoa2EzN3pTVjdGOGFvSnliY0F6Y3pIaU1U?=
 =?utf-8?B?eXVrWE16RWVPdEdwaFUydHlpU080d29yZ0h3dUtxYVliblgrcXRhOXAyUXB6?=
 =?utf-8?B?Q2RLeXhsakZMQ0U1bWNjMDJ4TU5idXUyZDV6cHpwUTkxL0thY2JUV2VLQjM1?=
 =?utf-8?B?aDlEblVHOGNQNU9CWjdZV25ZWDc0dENFdDBtNFZObGZ2SHhBajlteDQ1UUl1?=
 =?utf-8?B?S3YxSXhnb2cvUFhjdThBTHJoVVlPNFFIemdJRGhldmZtQ3BUeXdHRTJtWkNo?=
 =?utf-8?B?U2xFYUdMdUxqRm5ubGhSNnpSMWVmNmRmbndhQnVZZ2wzVXFxbG1URGZEa3BS?=
 =?utf-8?B?cnlnQjR3ZjFKNDdIVVBFd2lNdEpFZDhEcTdEUGhiNHgzZ004c2RDNUMzY3RW?=
 =?utf-8?B?cFpjUUFXMGRXTHZ3Y09RUkhGbUJNMzRNZDR0Q3pqNUtBdjQrWUlYMnozUXZJ?=
 =?utf-8?B?V1NnakxRb1dkQXBaL2pDY1VIcVFFN3pKVXNSNVhqMjBsZmhjZnR5T1MyV2tY?=
 =?utf-8?B?QjJ0dWNxRnJHSDlranBKTk12VCtKakRTMm9QZkE1L1h0NE1FcmZsbjEyRzRa?=
 =?utf-8?B?bHQ1bndGT2pBTUFIN1oyVUVZc2FNZGZoSzYvTDhiY1Jac1ZDNW5zbTlzdnVk?=
 =?utf-8?B?NlVtd2srdkd2SWw2emVsVWRYMVNOSTltK3NNMFNvMHg2WjU2NytGNkxwdExs?=
 =?utf-8?B?UUd4Vit6RVoxb1NqelphRXY2WUl1QTJYcDZZTFdwZkU2NEU2aEpPcUovZ3NI?=
 =?utf-8?B?RERWMndmc0YzUnJvY3lzQStWckduTHE0WDRGd1ZkanNJK1d4V2VTWUpYMEd4?=
 =?utf-8?B?S0NzWFkxYXFEc2Q0ckVrLzUyY1o2VUNsNEZjQTNQVTJPeXpVbVhNbVB5SnZa?=
 =?utf-8?B?enNyV1J6QzNhTExna1dIRGNOVnpyVHJsN2txS3JlaDlwOTUxNHpRYm5DMnc0?=
 =?utf-8?B?NDBCbUtvaDJkNWZsbGFRYzZJeHVhRmJDd1FkUW50ZjRXUW9xM0NmVytDQzMr?=
 =?utf-8?B?TkpaREF3TnoraTVYZHRVY3UzRFd4alY3QVE4anZSNUtaYVM3bVh3bHA4dnEv?=
 =?utf-8?B?NzVkdnBxUWd1cTlGSHREc3JxWlRsc0xJdWwzWUNiY3RLcTRxc0JsMUxXK3lB?=
 =?utf-8?B?bjFvY2x2T0ZWOWpXaG5HanVMdkROTTRVZm5lV2tuakRuaUZTWEJ5S29JS1BS?=
 =?utf-8?B?QllkK0RVL3BwWFBrZFVkTFhJZEpyRWtXbGxxS3dkdk9RQi9rdU1ZQzZBRFVp?=
 =?utf-8?B?TFI3azZ6WGx2K291TEdSYlNEd0FXRFlpNW1vSW1zT1NleHdFdHJCYU1tdVFr?=
 =?utf-8?B?V1V6ZlZQVy9mRXN3L1BsbnVIQ3FselVmSGtyQTE5b2hFaVFBSnlDS21HdjM5?=
 =?utf-8?B?YmRYZFludGFtanB3Y3FKRXFJNWdxQ2tQNDlGMjE0TGlkVTdxNnJBUDJtVU5w?=
 =?utf-8?B?bVowaVVVTE5yTENpTnBBeE9ycG8xVmZ0SUYrZWFhMTBhZXNmOXN6ZHlwb1Ns?=
 =?utf-8?B?RGs1aFowbTBOdjFiQWtWRjRIQWNXUHRSQ3Z4RWk3bHVNTW5nbjFjTWxMSUxM?=
 =?utf-8?B?S2x1STJ4STdIQjhrYjJ4d2NGNFZCQWF3RjhnbHFuRURCQXVxclhpYzN3Ukgz?=
 =?utf-8?B?RS8wTmgyeFN0eUhwTDNQYlh2Z01oL3dJYXM0NzA2L1A4dHdPd05wQndWM0hK?=
 =?utf-8?B?MGFtTGJRRnNpQW9hTjBhcWNmTHNSMlp4anlzdlFTOW4xeEptS0orRTIwQncw?=
 =?utf-8?B?aXhFZjV6SksvTmYxSm1kT3Bwd2laeHRVUFdIL0lRa3Y3RGVsUEswVkFxRzZ4?=
 =?utf-8?B?a3dROEJiaEJxYTlnRUJBb1hxYzhjbFdNeDBZcVFzVEF5bHhIMlpCcEVLMWE4?=
 =?utf-8?B?NTNNanozRXQvcVUycmRPWWpzZ1JyL0JKejV3OUF0TUpZOGYvNUtyYzFNdUlR?=
 =?utf-8?B?Y0xFS0VJM0JObDg5SGhTK0IyLzArUlU4K2FMdmFWczA4dUM1K0kwSndSVmZu?=
 =?utf-8?B?VHVLM0VFaDlYTlhrUW51L2MvZklTdXdRblFkdGR6eWJpVUhvTTlPTVFxRWNz?=
 =?utf-8?B?ZFA4TDlvbjJUb3pmcHVQNE9uUVY0UGtkY3dvQzhscE5zRm9ZRUl5cWZMRys4?=
 =?utf-8?B?NDNOWElIc2pNTjF3ZlJFZzNxQUlBPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f754d79b-dc69-4c37-1d85-08dcb851e1ce
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:01:40.0996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBOzpCSEtrmwS3CtTs4PchcpiOigxyedc4rv+YQR2hy479/KS0I9QdPee8jFI38LE/0GECQgE/AfjTw2TdasNSyj7IyxSdjJXxVMkzFqxcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9173

> There is simply no supported case of more than 3 address-cells. If
> someone has 4, then their address translation is not going to work and
> we won't even get to worrying about interrupts...

Oh yes, I was thinking too theoretically... New patch version is out.

Kind regards,

Stefan

