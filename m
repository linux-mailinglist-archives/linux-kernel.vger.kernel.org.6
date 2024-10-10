Return-Path: <linux-kernel+bounces-359450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 060E2998D62
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A16B2F11C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC891CDFAC;
	Thu, 10 Oct 2024 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hXQfNISe"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CF61CCEE0;
	Thu, 10 Oct 2024 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574243; cv=fail; b=Kj8fr+zImo4rxxVSgjPg89QZRbC+4XYJiQp6fPxxayErfl2pS+h5imBEKyUyTRtMv2tOArejevmwp11DozQRIWeY3gBWdHknKxQxdr8gGvgzsLs4cQdizMF/NcGMm1y2nYDtGVY2P04TyxviZj7rZKoFH6/uHPph4IjDm7CJ3t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574243; c=relaxed/simple;
	bh=HFkh6oTB3uD8m5qqvTGedZ8Nv1YCBswT/iaRDB4y/V4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dO34TS7Ek0hu3SQMWoru23rYTMaQ4yZTXnl/ic7rTZxVdHThF69Ac5gstWNeMu1/2Qkc+j2rlmZWNDnCC+GEX+teMaJDtOaN2LPn3c1QqPyu/ILX9LnqkWuJtrR5KlXm2/f2cgguy/nvdOSfP45ZNsMHeHLEwa6LupbSOgpTBkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hXQfNISe; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jy3c5CGK/Uw9t18Z9EPGngDtq7ffHbRiJiv47c/5hJyK5fs0zsbXN39fCoP729oI4QbtJkq01WcUFAxDwPQhE1CRvimFAd+ZmxzlTZTiEFmjGiQXWKVB5osoVzLeujO3zxq+zh+MEVYesQYLUg83o5/eN+QfW3SfAZXi2jAU1ULwVL00bTn/IR3Eryi4OjnDh8KVI5MSUdhng0N8yOMNIGAUFrpNWXt25DyNO3L0odobZve+Vjnny9NZBgGd68Njf1a8cTZSJoT5K8OyQ4pr8OaAn35KzQL4mgPzdjPrEpiYzSqrT8C9HbRdAx4d5K05CQVbcIsuJ76VHWGIcYhvyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8qsBjIzwEKG6mMO+kmAVIiGo/7AFcrpU/KlPxubTcg=;
 b=Z11JQAVj4nmSfBcrGWNGNaA6VXtpQGs5RmYmsbw67vqlJlBgJyxUxH1K4ahOZNQmcttksr3hsgjP8bPslncBbYbDUkuAJ67UNp7nHcQwTgM5MR/VMA7xWd9eY4SumhZcCxKa5XoLeNtNRogz0kbIp8ke/0Q6D61XZBaC3HX9UY+M5NQ4K2ZDLKYRXa0ROcPdqXZyFdZ9UM2mM5CAs1XnZjAwE7etHGJVpRGkGu9RZ74mrRYyTf5pZMKVPsoxyeOGYnlfcTIeqIYYMqHFTkH6jJw9mBEPvqyLc8zDTLuW4e+ptMMPdfhIzFMDUAS4AzbKM1oz+4Q25+tremqHgjfsrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8qsBjIzwEKG6mMO+kmAVIiGo/7AFcrpU/KlPxubTcg=;
 b=hXQfNISe/jrAHKxhHgS3fQUAsZAgX1/EH+r9fqwXGCRA0wvzzAMhMstJfnjOZ3ViU9ektJ83Vg1qPyyv3S1qxUaYWUVups6xcuuysTNvxYiZ5mCaInhu7EAHZ/jynOi6GdTT7U7ZV1Qa9P4v3wIi+W6d4C9k3QFXnMXdfqJ5J8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 15:30:38 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 15:30:38 +0000
Message-ID: <71c79023-d39c-43e7-abc7-057864508edc@amd.com>
Date: Thu, 10 Oct 2024 10:30:33 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 07/25] x86/resctrl: Introduce the interface to display
 monitor mode
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "tj@kernel.org" <tj@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "yanjiewtw@gmail.com" <yanjiewtw@gmail.com>,
 "kim.phillips@amd.com" <kim.phillips@amd.com>,
 "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "jmattson@google.com" <jmattson@google.com>,
 "leitao@debian.org" <leitao@debian.org>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "Joseph, Jithu" <jithu.joseph@intel.com>, "Huang, Kai"
 <kai.huang@intel.com>, "kan.liang@linux.intel.com"
 <kan.liang@linux.intel.com>,
 "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Eranian, Stephane" <eranian@google.com>,
 "james.morse@arm.com" <james.morse@arm.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <dc8ffd9074123320ceeecdc8e0b36d1ac0780e02.1728495588.git.babu.moger@amd.com>
 <ZwcG2e90vXHlIVan@agluck-desk3.sc.intel.com>
 <4da658fa-3cea-4388-86f4-d4b0fb5f0903@amd.com>
 <SJ1PR11MB6083410D8FF053823F0BF884FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <SJ1PR11MB6083410D8FF053823F0BF884FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::12) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: ca91beb7-bb38-4e75-1461-08dce9407dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajJtclNJLzk4R0t3YzB5SFpmUlc1R1N5V1FEbmlwcHh2eXBFNG16S1NqOVhH?=
 =?utf-8?B?bXhxdjhZaG9Sc2R3RjlwZVRoNWlIRkMzUVFRMG81Q3ZEVzZjSWhiaXQwV1JP?=
 =?utf-8?B?bExEdk9yaXVOZHVzODYrSGJCR2xSYlJoMjlEdkpueVo0T0UwUzhHYTNyOHpS?=
 =?utf-8?B?OHBoRlhLNGxFTEFMaG9YT1hueXRDM2pmTmlKaHZSS3pmcHpUZFg3SGp6bFQ2?=
 =?utf-8?B?eE4xZDRTdU1QZUpQUWs2UUN1QjBMMDFGVjVsZHBrZUxZS0h3NTdlbDdrc3RI?=
 =?utf-8?B?elA1WUpSbDhsc3ZiZVBNT1dZby9jOW0rcUNhM3V6WWtpQmJwTU5XMWdvN3A0?=
 =?utf-8?B?V1hqdEZiQVdLU2hxYW9aam5lM0ZOR2NLV0hzSHU2QmJYM0NNcUl0bm02YVVI?=
 =?utf-8?B?Q2hKaHBuSitwd1NpR2VQTGFSZWFUTjNCc0d2aTkxWjN0dXhhSkdYOS9XYURW?=
 =?utf-8?B?T1lBSk9ST3A3UDdSSThyME16bTF1ZDRuZW5rL0lzNnQ1UWlWUS9Rd1BnWkxD?=
 =?utf-8?B?eGUvNUNMWWozYkM5c2ZQMmtQb0QzT0lRQWhlajlEYi93UGx3WWUvZFVNM0di?=
 =?utf-8?B?cnBxYlNlRzFoWVkvamQ1RDhtWENvNjRteWtHNjYwYTEyRnFURkxpdWhVdWZK?=
 =?utf-8?B?bU5QUnBSVnpUMmY0eFVmTTIrbFJJVGlNSFpBcmY5WXgvcU9lWUxDODVDTUVM?=
 =?utf-8?B?SUNjMkcxcm9kWEZESzdIUkVPRzRpdVB6V2IyNFBEVVlORlJNeHlNc2ZPcjZ3?=
 =?utf-8?B?NUhPRTFIcFhwYWdKRHhYOWxtY0lMaWdJTTVZMkpFMFJhd1ZSVWRBOGNXMW5k?=
 =?utf-8?B?amswR2lmdXBSRGZ0YlhrdllOUjNwRENkMjJqbE5CaUx4WjNNdk16T1VndUNP?=
 =?utf-8?B?WTRrbjNTMzk0ajArUFV3c0cvdDRRRldMVldQYTJYNmpyejYydStJdjdkNGhD?=
 =?utf-8?B?a1NaS1V6Z2lGMzE1cjNjUjN2elBMN0F0MVNZaEUvSHdZOHBjUXdrUEk4cjky?=
 =?utf-8?B?VWJYeVZGOEtWdHFtY3c1QjZ0NUF0Q0hJRDBlOVEvVkswTUV1MVA3SWpkTDhv?=
 =?utf-8?B?cldsSXFaczhFalJCR1BhMGZUbkJJUm81Z1dZdi9OYzFUallsc1JnbnBIQ0V0?=
 =?utf-8?B?MXVTeGNkL01CZWc4djYxbStVK1dCWDBPU2ZqQmE0NVJoYVoxelJuOUszVC9G?=
 =?utf-8?B?Y3pyMXJ2WDNkSk1uc1czV1lURE5OUEV0K3IwMmhSTWlyeERsRG15OWkzS0My?=
 =?utf-8?B?eGxuNnRwUHUrc2dwNndOcERSWjUxRFNQSGhKSXR1YytUWExqT2pGRXBpWU54?=
 =?utf-8?B?eWhWS1JYd1I0ZHJwNWh3YlJ2K0NUQS8zMkV1VVVyWUYwRGRsQi9LdmppR3k2?=
 =?utf-8?B?a2RwcWMxTmkxODFGSFFDOVp6QmpibXQxZUdOTkZMc0xZM1VIMG5SUVFocERO?=
 =?utf-8?B?eHlONzFldXBaN0NRcmo5djJXOEc3cElBZjcwNkJpSGRnL0ZGa3RXUDdkcDdt?=
 =?utf-8?B?d2NkWE1sbjdCbjF2K2pvNUkxc1BXU1V5RjhzQTJxdTRkNnBuWEh2QjdoNDVS?=
 =?utf-8?B?eGdHcW5yVG5BYmw3ZTR5SjE1SWtVcjdlUmZTVmszWkxkVTl0bU0yQUJ5d0Nm?=
 =?utf-8?B?VGhFeFhJWHZtV2IrSno4K1VFQzdkNnRoVWZOVGh1YXBkS2xZZ1JtZnFVNHEw?=
 =?utf-8?B?OC9RZlBHaHFDM0c5azZVUXgxUGN4ZlZHaDBTVFRWWmlVZDFxNW9Ua3NnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjVUNFF6VGdyREJEOFl4VmNaSXJiMDIwQVlyQjFJMENkY0hBalc0dTdvczBo?=
 =?utf-8?B?V2FsTHNHV2NBNzdleGZmTEpHT0l6N0c5bE9qa2xWT0QrV1ZTTXRLeEc2KzZW?=
 =?utf-8?B?KzBMQVlsa1pPSzh5ZmcwSzNmcmJBbVVGYTh6WnZScTJFNlM5R1ArUExtL0FH?=
 =?utf-8?B?TXd3QjcyRzRhWFR0aWtIL1VZblh5VXhBTThMaWtUQUg2YzVCZlIxNkZDNkU1?=
 =?utf-8?B?dXJyUTUrUHFPTDJWVkJQVzRLOEhQOTdCSnNBd3h4dy9tbTdjcGRpSVBTUlN1?=
 =?utf-8?B?MVU5MDVlTmVYSmtTcXRWbnFCaVJidGFHQm9YWFFpZUFxZ0ZjU083S3RSQ3Zm?=
 =?utf-8?B?aXdqU1JmUGY4RVBlQlJ5VGFJSkorT25jV05lLzFnT1IvVjMwbUJmVGRFY1Rt?=
 =?utf-8?B?cTc3K2NSTGhVVWtmV01rYUhiZU9jcmZNbUp2QnJiM0NDRzN4OW1pNExkSWpP?=
 =?utf-8?B?WDFTRllPT2ROeDl6bitRbElQM1ArNVlGMGdUQWlxcUFCWFQ0K3gvK1FURVJR?=
 =?utf-8?B?Sit4eGFtd2JnVCszOUJacnI1MExoSkErZk5IbndIK09tcGZFcFg0SUo5Qkt1?=
 =?utf-8?B?M2NMYUhZWDVkQ3lVUmgrcEdyTTVmZHJFNmt0SndsSUhIbmNEVjVRZlIvb2Qy?=
 =?utf-8?B?UEp5d1llWDM1WFI2d3hPdDl2TGtSdjlwaUxmRVJpcE14Q3ZWV0NtYngrM0hx?=
 =?utf-8?B?bCtlUEU1a0pRVklydFV4UEVBaXVlWHpzenF0b2dYTmNGdGxHWHhCdmszV2Nq?=
 =?utf-8?B?L1k3WTZmMm91ZDN5OFI1YTZ0ZTB5TmxIMGF0R1RKMWl1UkRGM2NYSy95Wkc2?=
 =?utf-8?B?ZlNWeHUreEFiWTgydFhuUzdoRVJEL00reVNHbWJxNmVGUTlGMlNJaWtySnM5?=
 =?utf-8?B?Nlp6UU1vZzRzSXdNOUV2Q3RIWDgxUVlIME9iYXRva0RhVXlhTXVDb00zaHkw?=
 =?utf-8?B?NTVPNitWdXd5YVM4UzRndjltUzdaZVphbGJhYWJucTlTRW9XYTF3Qm9JYXpB?=
 =?utf-8?B?S21EdmRqUGdja3UrNmF4eWVIb2ZZRlJOdmZycXFyOUtueFkrNTF0WDlHckVa?=
 =?utf-8?B?R1JETkJMMmJhTzZBQVlmdXY5R1NPYUEyRmlpWE9scVNzTGpjSS94NnZDUGl2?=
 =?utf-8?B?WVZlMGFGbDJmYS9oa0xIbUN0NEhrMEFmKzYrOW5Ddk4rL2RMM1l3QmpTVDZm?=
 =?utf-8?B?L0l3TEZzVFdwU3UzRkQ0aHZ0VkRaeUQrM1c3d1oxQXY2ckFuaUF5dzZmY1R6?=
 =?utf-8?B?Sk50U2dyNFZHK2RKMlJ2d29VbUh2d2tGUHB6a204Tk5uMGZhRlpYaktyUVNw?=
 =?utf-8?B?OGNVbStQcXNIUzRUT1ZYRjY5ODdlOXZRWWZkdThqeTRZUXFuWm56U3ZZeFpC?=
 =?utf-8?B?L20raFA5eE8zMDlMZlJmRllObUpsSlMvZVBvKy9CVXRzazRyUDI4eGRSb2hX?=
 =?utf-8?B?NXNWQkhITWdsQ1RjUXJOMEdrS1BFTkJPV1BYL1pvVmlBcjRpMjhkOFdBV1dO?=
 =?utf-8?B?eXVrVG9WMk1FQUUyMU9HL3NEZVkrK1JCYWk2eUcvYVFSTXNRWjVyNjFmekxB?=
 =?utf-8?B?cnMrMXUyK3AvS2UxRzNwa1puWGFlMUwzNzF0TWtUVEYwblJqVFNOQm0xRDVK?=
 =?utf-8?B?UFlHQVBaai9Id2ozTDBCZmY3ME1uUXZ2UWtNTHREUGVJVmlLbjI4Wkl1cWdQ?=
 =?utf-8?B?Ky9pMFNKOWFDdHR3Tzd0RUwzQ2ErVno2MlYwWkZxdTAvaEdWL0xJMjN2MmRy?=
 =?utf-8?B?TXEvWVlUU21Ja0pLVkxnU3ZYbGNBektsd1dTbUozMzY4dlRVVVhCZjI4a21V?=
 =?utf-8?B?eUFDemg5OTc0cXJ4bGZIbWFCUHBKdjBLVDVGRk4wRTd2OWNLK3E5QzJlWXM1?=
 =?utf-8?B?VC9xMFNZSGxMZ1lHYkZKMi9sODVUcHRNOHZwN1p0YnlHQ29sM2JFbTFIV2lv?=
 =?utf-8?B?L3pGWWMramo3bzJzUU1NMGlLYzZBRHlLeEc3VTFKSG92N2R3RG0yOFhCSDVE?=
 =?utf-8?B?WFd4QmFkZjIzb0U4U3RwZmdCSWFsLzhVdGRkNjErY2txVmcrVmZhdjQrV0N2?=
 =?utf-8?B?RDhWQUN5cTR6OTZ0enpCMHh5VEh6Y0hoTDdoOEpzd28raG92elRPeTJnNGZ1?=
 =?utf-8?Q?1bdw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca91beb7-bb38-4e75-1461-08dce9407dfc
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 15:30:38.2016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHNX5kfDdBM9AhHQVvApzYzoyBGjl4SVelD1ROvT1PhwwVtoNd0rBZtEH12Reat+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242

Hi Tony,

On 10/10/24 10:07, Luck, Tony wrote:
>>>> +  By default resctrl assumes each control and monitor group has a hardware
>>>> +  counter. Hardware that does not support 'mbm_cntr_assign' mode will still
>>>> +  allow more control or monitor groups than 'num_rmids' to be created. In
>>>
>>> Should that be s/num_rmids/num_mbm_cntrs/ ?
>>
>> It is actually num_rmids here as in default mode, num_rmid_cntrs are not
>> available.
> 
> Babu,
> 
> The code isn't working that way for me. I built & booted. Since I'm on
> an Intel machine without ABMC I'm in "default" mode. But I can't make
> more monitor groups that num_rmids.
> 

That is correct. We will have to change the text. How about?

"default":
By default resctrl assumes each control and monitor group has a hardware
counter. Hardware that does not support 'mbm_cntr_assign' mode will still
allow to create control or monitor groups up to num_rmids supported. In
that case reading the mbm_total_bytes and mbm_local_bytes may report
'Unavailable' if there is no counter associated with that group.

-- 
Thanks
Babu Moger

