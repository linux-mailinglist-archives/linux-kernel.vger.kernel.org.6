Return-Path: <linux-kernel+bounces-345039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046CB98B15E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F2B1C213F2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F55928F1;
	Tue,  1 Oct 2024 00:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vSmOwG2z"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8C8173;
	Tue,  1 Oct 2024 00:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727741937; cv=fail; b=R1xEVUcuqiK4bUN6Ngy7MyQod5+hOxJULe+yIFg8fvISwALF5eF52Tm6CEB+MAf+MD7G5L77paQtJTWXD9WKhLd/bbUCVbn96PbM1XBsCuoySwqkkociAqefi3L1IQ8lZ660/0CGNE3+buWEADu29ipPpF7I5y0dtjl4oZMZ8SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727741937; c=relaxed/simple;
	bh=TxWaIvxp0xVnVh2OKfVF8SyhohHp9gisklMEpwv0m54=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xq+z8wIobcsOdIcXQ4ZDB0ucW2Ya9Mt/UDBZnpNV/5jn5zFCHDw0zOH5AvfC7ZprAgXUhH9qpafDCFPqDMoe01BWyBw/tArzUcawlwEKdrhcXieXNRXIYMqRlGxOacmSrjkjGPeT9HFU1T5f/dW52H0qgHmHo1i8v+VHvlOJD7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vSmOwG2z; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZC7gzily4BP2w801aCn2T73dV+GpZb3xKO6fB8G3wB8BYlLT1nHmPMQhwT7BJf9EpK9yKiqun6oxAy6Fn9eWY3XTZ/lSZvB0IZwAO2pyD49wUzcUwVCkBnnEAsAgBuJxe5NKCiGhO1SVtN5QDOG98m1vgYKBvcsuV0yDTR2QsQYlAvtEb3guvz9qVJMA+IwEezWDDg2guLFr8FnqorjJFnA7TTKKdNn5LeWARpZmH75fw1Jhix2yV7TnKnQWfKTIGP6RLz6Mf+tFT0kyBfwvze63Evwo5dJDazW9/CBuSdHaBKRPjt+VNWFLg3YeQMmiBeSPCwuIZn+oHcOFhPN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vr0KY01M4D+KZ4hyENUHA3Rkm/dArEOexyO8TmQG00s=;
 b=s0gtiwd4Aeuijq7aMbhe7UjBArSWGUWBjBRC63bt78u4T74syncaKh7W7bV9TE2Epw9f6LAQ/G5gmAg11++rTv8ACV4hV4p7A/MeSyfp5NrnCvjcxmafns9CZ1nKabvYrVTk+yOP0DV2fWRacGVtJmUKOdNzpnE3cym9QJng/Tlq2M17984USq+Qr4A3Ji8ZUdSkL/Ljwl9LGIUGod/1BDHE6xKYJ/3LjEhewvSw/GPSDnZmNAuyUlJ6p/iQCnJGNAXZjTHx5AIyhuDKUbswWQDRcJu+loNCLQz2YpprPuBduOfJMcL/UteM5bj4YiXU5RECePbyK5LJAh98vs/p0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vr0KY01M4D+KZ4hyENUHA3Rkm/dArEOexyO8TmQG00s=;
 b=vSmOwG2zz8qsw4Fk4GMwBUP3TVaRgo/7Wossws2j/ekOC40W1eSYvNWYqQ0UheVibpWcmynAs2zWri4Lnh/qi7JJeRgrxOmStioiDmChBBrasWpId+XrkP01IPc9Pv9tuGKLZyJKIx5WLnt08sSwveYWm6uz8f6fUYYtWg7nj18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 00:18:54 +0000
Received: from SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2]) by SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2%5]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 00:18:54 +0000
Message-ID: <eab55c58-77a0-f993-a447-45af1cca6d0e@amd.com>
Date: Mon, 30 Sep 2024 19:18:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 0/2] nosnp sev command line support
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Eric Van Tassell <Eric.VanTassell@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paluri, PavanKumar (Pavan Kumar)" <pavankumar.paluri@amd.com>
References: <20240930231102.123403-1-papaluri@amd.com>
 <f751ffe7-9900-4d91-9e7a-e560777725e1@intel.com>
 <90493ac2-e1c5-f03e-9428-f6a147f37088@amd.com>
 <c5cac60d-b3ef-4408-9a52-4d61fe8f77fe@intel.com>
From: "Paluri, PavanKumar" <papaluri@amd.com>
In-Reply-To: <c5cac60d-b3ef-4408-9a52-4d61fe8f77fe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0197.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::6) To SA0PR12MB4447.namprd12.prod.outlook.com
 (2603:10b6:806:9b::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:EE_|MW3PR12MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: a526861b-884f-4a61-28b9-08dce1aea20d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGc4RStaNFhuTFkwbHNVWWI2M2wzc2hVNWxHcG1rODJRcGRoa3c0TTVOM0lY?=
 =?utf-8?B?UjZtWktscnV2KzdiSGJEWEhQUFhsclNJT2N3NDhnT0tzQlYwcExKbU9LY2p2?=
 =?utf-8?B?enpvdEg4SjF5RXU2bW9SNFM1VVh2d0E2Z1Uyb2sveWMvWWdQOUhOVm5YcWlp?=
 =?utf-8?B?SSt0aGhDa1pXYmFLN25hOTFwU3Y0T3VDS3hLbncvT1ZUcHhqVkpwcmpmVGtu?=
 =?utf-8?B?RmlTOFRxNjM5RnhHN0pyUWE5UU5iSElQc2kxNGlMYTA1YkE2WmtFY0J6bE9C?=
 =?utf-8?B?WlZmZVJ2YkdsSFYzcEpzamZRdzNFUVVNYXpkSjdYUTlsNHhlcGlsQTZxVzI0?=
 =?utf-8?B?aGhtUjJvcFFzeUU1KzJJWFhRSjVYcFBoMmE1elhiY2RDMjR0eStnMzkrL1pY?=
 =?utf-8?B?UENPSXVlemRFKzFkQzRIVEJrR3ZsOSt1ay90S1VKZjNZWnVhb0RaT0RRS29x?=
 =?utf-8?B?VXBtNlJhWU5mYlI1bTFPNGF2Rms5RElYelQ5ak54WlZ3dUxMRnlkenlIT1Qv?=
 =?utf-8?B?NEpTREtHeTNsVU94bkUwcWJFNWdhODN6MVFkNzYwMW80bVMxczRmcG94aUxD?=
 =?utf-8?B?L1RqVkxYT2UxUmFVSnBDQ1BIUTBHRnpVT1V0bWxzYzRRRHp2d1JzQ3plbmt0?=
 =?utf-8?B?VW12Q0dUSEZNNFVZU0xJU2dub3B0bWZMNXpFeHRKT0k2T0VaRjhoYkJXSjNl?=
 =?utf-8?B?a09rcU5CV3YrbVVuNEtTanB6MmpRbU1LVng2cGpUUnZydkFFcXZ4K0J2RG5P?=
 =?utf-8?B?V0JRNzl4U2FpQ1BiS0wzZmNoZ1lZR0JkZGhacG9IUXFlQmt1aDQ3U2lCRVFN?=
 =?utf-8?B?WG5lZTZzWTZPYThtZEZiMlpFc2FSUEpIdW5Kek52OFV1YytsUzZidytCcHFH?=
 =?utf-8?B?N0Z5WmxCS2RtTGN1UXI5SWpOYVMxdDJKK1htQm9PYWVGbTFTS1ZCZXlVZ3BH?=
 =?utf-8?B?cmtNb1liS2tZM1NQK1ZvTFZzNzM2eFpvdEFCU09xSjU2TXljKzN2Z3o1VEha?=
 =?utf-8?B?b3dBb041eU1HNUp0S0MxVTQ5a0ZqZy8yNXNVNUJ4aWFxN1lScDdGS0IzaTZH?=
 =?utf-8?B?enJKQnpyVGtabldSTjJKdnZsUlFFQnowL1pYbE15MzdTWFc0OFFaYmhwOEVr?=
 =?utf-8?B?QXRBQVVWZEtLMThCaUVnbHdPNDFucHc1MDAyYVRQM29mQU5MY1UweVdvQmtN?=
 =?utf-8?B?MW9KSXI4ZDVaR0tvcjBYUmRuRzJ1YlhJMlFhbGRndmlLUXo4b09MVXVuOUk1?=
 =?utf-8?B?R3NGcXZOZVFyUlFQaDhvS2kycXk3ZVJjMWd0eXNqN3IwY1BLVTZ1UFpwVUpl?=
 =?utf-8?B?Nm43MUhoazRuNnJkT0xrTi9rOWNWVGV3bEhXZEMxckltOFAydDJEWE9SdGJi?=
 =?utf-8?B?V3pPSE1OY2J4TjJmMllQVUVweVI2aGhjNXdyTko1U1U4S3kvQzdQeFcwcVdv?=
 =?utf-8?B?RmtSVXpQeSs2N3lHS0htNDhzRysreWJMY3BnSEMvSi9HVkxGanpLRnIrbE5D?=
 =?utf-8?B?TnZOSVhsYlJGaHM0SjhnYndmeVJWeTNhOE9LanJDS3p6MGZteFptb28yWnNk?=
 =?utf-8?B?aHk2cmV0VjVIejlsSjBIS3R0U1prR3FybVlXdzgxZzVpMUdBZlZkaGNYODdK?=
 =?utf-8?B?TlFsRHFoT0xpU1U4c3ljWHk3RE9LLzNpVWZKOXVPZDBFVTkrNEpNNFhWN3l6?=
 =?utf-8?B?Z3RPSHhLeXVmbGNnbTE4YzdISEExYm9DcVBqNldGRTlKN3JNbmxEYWl0OHZu?=
 =?utf-8?B?cE9lTzF5QWFEK1g4eVhjU3p5YTEyaUtxYndqbWFia0JoQy9JV25KVVF3RVp6?=
 =?utf-8?B?NGN1YUdvK0NpN0lnM083UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDZFOHIzTXJlcW9uT3I3My9BUnBMYnRaTDNzYTNIRDNJclQwbUR4KzNzWlN1?=
 =?utf-8?B?RXpQRXh0QTdtY2lkdU9aN1lsUFhaSzJxb0hKNUYxOTVjVDBLeWlZZSt2b0ls?=
 =?utf-8?B?dHV4RU51RGcrSEs2dSt4K0Qra2R0d2ZwVFpXL3BMYjBhTUFPOHZoNHVxRU13?=
 =?utf-8?B?RVVkeWw4bTF1d0ordEVNaWEzVDR2TkkrZktTUUwyUHBNVmxsRjZiYVkvdkRQ?=
 =?utf-8?B?ZHJSeC9tWEsxeDNSRElRR255b0ZhWDFwNmY3OW5pY3VhTGkwTDhnZWJjeTZO?=
 =?utf-8?B?RkhXM2wzQ2xOYVYwWkdqT2x2RFZrd2VYcWpvcWdjQURnOVc4UGFtMHlUSDgy?=
 =?utf-8?B?NmpwUk9YL1E3U2R5eWNZczRwUGFKM3hpeHRZanBrK2hrUEFUVkY0QnVDVDVS?=
 =?utf-8?B?SVlVT0w3Wll0N2Rtb2ZSRHZaZGZ2blJ1RWlRQ1VMTlQyVFlRMCtwbGhWYVFz?=
 =?utf-8?B?RHBtYWdta0I4K2h5QkZCcFphbEl1ak9PdkxlTUZxOGNlZnE5cmlWVmE2dFQ0?=
 =?utf-8?B?aXVCa3dpVjhrTXl0WXFMa1BlanBJdnRZMFlVNkFqMVZoY3k3cEpWZk5TdzQz?=
 =?utf-8?B?NHVnRXJLanY4ejFVMWtEWFptcnRyZCtLQ2VVSnRNVmZ2aG1kVDBHbXdZWlZx?=
 =?utf-8?B?RVJtaFZQaTFLOFZINU1HQUk3bnlhTTdXRFVYeVdlWE4zLytNM1FIeUhRQmlP?=
 =?utf-8?B?Wkwrb1ZqTVZyaTJKNmovYUVYZW5QZm1mbEVEL3NDUStaWEtqaE1uWFF6QVpU?=
 =?utf-8?B?ZTA2MVRJc2E4R3RsTFR0VGVOWlk5TDZBQVFYcUs1RS9rSDVsdE8rNEtFUzhy?=
 =?utf-8?B?bmtYWXM3K2N4cEJiWkUvWkw3TzFsZ2M0VWdlMHpNMno1N1ozeVp2clFzU0x0?=
 =?utf-8?B?NEVCb3ZqaVppMjNFdnZqOVZRaE5uWXVYajh3eW4zUkREQlVFa1RXejRNVXJO?=
 =?utf-8?B?aXk0N1RnczNRYThmMUprbmdjNHFXWGR1a24veVZyd25kbjBlNjI2NlVGNTZ4?=
 =?utf-8?B?Vm4yeVRPYTYvaFd6Y0Q0dVNBWmxGaW9KZ1JmcWprajEyQnMxekc1T0JQazFv?=
 =?utf-8?B?Sm5mUGZwR1U1WHRFWHRRQXFhSzU1K3V6MmFzTmRjdnVVMHpzS2o5VnYwRVh2?=
 =?utf-8?B?cWY3WHk5dGVXc3ZydTFGa2FyaGRNdnJIeHpRV2VxMWdJQS9ieU1jWnQ3dEMr?=
 =?utf-8?B?eHZvVFJlM2tRRXVTeXQrM09scnpmZE5WYUhJTnJxQVBzbU1PZ1VQYXQ2T1E0?=
 =?utf-8?B?QkRnZjhRMDBtdklYWXU1MmJmaWZOZms0cC80RTkrSlNpRDVRbEp6RDZBS2N3?=
 =?utf-8?B?dWxVaDJTNXAxUzk5amF1VzhLMzZyQWtwamlKQnZIcjVQMVhISFg2MWErL1I3?=
 =?utf-8?B?bHB6K1p3K29IK2ZlZmhra040NlhWSHFieVpTWkpXeTlDRHViYmtxUFY1Yktl?=
 =?utf-8?B?MU5CaVp0NC96ZEVaMHZoeE8rT2tzblR3RUtIbjZhdkVySitVeDNGWG5PNk55?=
 =?utf-8?B?Nm8rbzloMHl0Nm5NWWMrUG00UzY5aU04ekJEUWdySlMyV1pVejRuN0wxMWdC?=
 =?utf-8?B?RWwyOWdNcVdia3pua1NPNURncHpIalVBUUVyOGlUclZ4cDhsNHEwSEFJcXhE?=
 =?utf-8?B?a280VHYxQVh6VTJLOUp4ZlNoYWRhSnZSbXBkV0lRKzUraFJqL3N3T3l4U2dt?=
 =?utf-8?B?VXZsU0ZnaG9mMTZlc2M3dTYxc0N5dTBreGJCNExZWWtXT0w5cTF6RkF3Y1dx?=
 =?utf-8?B?MHpMKzJ2aU5ieDU4ZGhiWERDVjVPTmdLSy9xUGxWaDVmdktycFY1VERpTlRU?=
 =?utf-8?B?QXdKVG90ME1IYXEwWThkS2tMRmcyMGRaclBTdWZLQkMzUUQ3QUdHa09OQ0hw?=
 =?utf-8?B?a2htSjhaUHNGSGVLNnVDaVRiK3Z6RUZOdWZScENuQ3NzZHlwNlFGWWNGN1JJ?=
 =?utf-8?B?TkdRdWhiYURzNmRJWFViT1JBWSs3OEdScjk1azlUNVBkNU55K3NNN1ZoSUV6?=
 =?utf-8?B?aFFscjA2S0lBV1pMSGtuN05MeTR1aCtXUmtRVzVLZURLZ1BURllkM0xSRmNl?=
 =?utf-8?B?S3dYNXcxSk5NRzVHWG1jcElCRGxJT3NNUGZPRlFPMlZjemwzaEhYYXVHR2Nq?=
 =?utf-8?Q?QP+4ySvZdVYa0LhkA2Il6k0py?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a526861b-884f-4a61-28b9-08dce1aea20d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 00:18:54.0148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXS2MzN05tAfuHwOjiGXODDmyarGQdg9zcc6k977z65OVoybXCxMiwsS+xUsgjjOYAwOwwmDCh0EEJpabFoeBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377



On 9/30/2024 7:14 PM, Dave Hansen wrote:
> On 9/30/24 17:09, Paluri, PavanKumar wrote:
>> I will include this information in the cover-letter.
> 
> ... and the documentation for the command-line, please

Sure.

Thanks,
Pavan

