Return-Path: <linux-kernel+bounces-364711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A090899D83E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C399F1C2025B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ED314C5AE;
	Mon, 14 Oct 2024 20:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ofueiZdB"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2AD1474D9;
	Mon, 14 Oct 2024 20:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937931; cv=fail; b=mzzCSq+R3Mc+U+9V6XdWJNWqfz9gA4ZPs4SvSW0lKjhvwPr08JbSDeTQBF1aFxdU0J9N5IZi+qcyFsSxv3U9lxDSvSb+TNRUrr9Sb4F+N7JyBligvY4sbc3Mh4WfRWdSfpJ7LjgSAGVms3pJ6BwxGWyGppALYI+/niPHPfJpXxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937931; c=relaxed/simple;
	bh=7HrwurUuy/BMPDQwX90smSuf1t2WY5uUhpDaGgXD6Dw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rpxFg8fgFkDK0FTTz3zXWbOLFg8jhIr3CVoogbWtYkXWTCI5meXQ3+952GR5NNAAAz/HWjpv9pTHeModG5DJ/yZa4wxcw/hAvvc1OtFgMFDCo143csdL/rRBwDiJ7oxWfbFX9ky+XJB7AFAF08a9OkOD6S8r20K1CX7gaCjahSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ofueiZdB; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXrEQ2ZyUJttauOOdr921UenMxXzoBsJrXuofR5oVqxQiwur7L9WVQspoBFV8TZEkNtH3Qn4rW3iX8m4qrELchQivTwYt4ktWUkJuG0O3lUYVToBGH7QagZs8XYLFrUUitJpynLQ/rgVP/LbX74NwqoYth6aaWFnC6i5qbX4lp1C2Xm+MgyRxp1tUJwxgDQ3RP2cyffDLRRmDJ8QYjTxt7LcRpX6kzko3G4RlRTk/xQG7XlYngEjaPa8H5LvdPijgHVSlytcl3MBF+LaeER5phvqXnoVjKp3c//PtlnTL26Kvm9Nv9MdiCwia/sqqTKJfh+kJ3SlkugBTJH9wt9LEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exw/hiyl6WFbwoa0IMYL/GJ5WzG9+0naVK28AarJ9RI=;
 b=X0oweYnSxwynr97jX+nxMjhXIAjCA9JFA4gIoH8XGIryp+KCET1aBHO4OSk2IBL9zXB56GCa8MTz+MsAMrrl2NJrRt6YBJOqTVcqH635xdKuN3K34OfD4lbrKJQ1LAqYAhq+16o2hBtiEQjCCtbLCoLwJ17ybFvj0GT8Hf1nM+ZY1RyMivZF4M2h6VH6gZ0ZYYwi2xrdOJuUBWNKuHJT8wOD1sNMfVgLeit5vWL7XS09bviNk0a0/9n7Cu0KEw4G6jmQdnVl0WqaDBYE7nWivz2YMSXE0vtLR5YB5dekYf8sKd58GYPFK/q7EwJ1DCJoSop5Z5uTH18/e0fw2Q/q3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exw/hiyl6WFbwoa0IMYL/GJ5WzG9+0naVK28AarJ9RI=;
 b=ofueiZdBRXyU0KyVaahalVNbC1RfsJJcpG6AEBWsXtpu49nYrWjikIl+GBds5gj5JqPvjTkV6Q4OOIzSdn+zlS9Xd4GWZqSWZzK1Qw7JMKVUvg6r5NxhC5POlgf1Iwxed8hb7PFTkjWDtE6f0Fbdi3mSsl59So+w7V6yN3vicbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 20:32:06 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 20:32:06 +0000
Message-ID: <ee0352c2-1869-44ab-94e0-a6e81fce9b4e@amd.com>
Date: Mon, 14 Oct 2024 15:32:02 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
To: Reinette Chatre <reinette.chatre@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
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
References: <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
 <SJ1PR11MB6083FFA19F9387F21C058A09FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <d1986f3f-9db7-4ac9-9fea-56878548ad61@amd.com>
 <SJ1PR11MB608382EB9F40FBDC19DF71C4FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <1baa07f6-0ccc-4365-b7b8-09fe985963cd@amd.com>
 <Zwlj5TQxZphcuDSR@agluck-desk3.sc.intel.com>
 <8af0ce3a-1327-3ffc-ac5c-e495f9cdf5d0@amd.com>
 <ZwmadFbK--Qb8qWP@agluck-desk3.sc.intel.com>
 <ee7771e4-3768-456c-9990-fcd59b4f74af@intel.com>
 <0ee2e67d-c1dd-489e-beef-1f255c5629d6@amd.com>
 <SJ1PR11MB60833A1571413763DE36B538FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <23b5a3d2-91ac-4467-9db0-3de483cfacf9@amd.com>
 <SJ1PR11MB6083583A24FA3B3B7C2DCD64FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <799f514f-b06e-46d9-bfe7-dfd986aef166@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <799f514f-b06e-46d9-bfe7-dfd986aef166@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:805:66::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 684deb36-2a40-44ce-1f69-08dcec8f44fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkxiUHZVVC9jTlZkQ2d2S1Myc3ZjeTRrYmNXRlorcHlJc0U2bkxCOVQ5MFlC?=
 =?utf-8?B?bU1FSmt5U2pkZzl5bmlZd2dOdDJWb3YrMkdyTUxyZUtsTktWMFdSamhYSWpH?=
 =?utf-8?B?U0dlSzRDS0RnSFhsa0JkVHBIdzlENFJaamtnQU1zYmFCc25kaWl1a0tOT2J3?=
 =?utf-8?B?d1B4MzVkcTVacSs2dmVkdyszL2lmRW56ZHAvZWZMOW9DSzdSdHVLU0xjMlJO?=
 =?utf-8?B?UFlyQXFLOGU1RkpqVmxYMWRIUEFIRmpkb1FzSlYwQmdaWWNnRUFBNXpNcldQ?=
 =?utf-8?B?NHp3Mk1uZ3I2TldnYlpkb3dIMDBNaFBISkVyUTBSYTBhOXhVZTFPVWhCYW5E?=
 =?utf-8?B?dmJpU0hBb1ZDMGdFYkJNUlB2eXhTOVAzVWZNdUwvaklJWDUvazZsYzZ2Z1Ey?=
 =?utf-8?B?dkNEYnM1d2ZwZjFtTzhCSDFzV3RDb2sxY2RWSWQ1MVJEd3ZjSVExazdRcEhW?=
 =?utf-8?B?elNnOER2Q05keGxZUGlGcVFtM3JiWmlzZVRlNm0wMTBDMzdHa3JVWkVlQVhX?=
 =?utf-8?B?elFEL2RHUVlqUndHVitZbmFJeUpVQ1V5TEJyVGtsd2Fqb0U3Nk5KVWtlT0hs?=
 =?utf-8?B?bktFd3NOdzY5bXFEUUM4UHhGamJ2aExJYTB0VUN4L1d1NEtCanZCYUZpKzZa?=
 =?utf-8?B?MnNzVW1zTmw0dEtyRHBkS1NYOS9vODZXTzlyYzVzYndMN1RGSnc0TW9TWnNk?=
 =?utf-8?B?VWtaZHRKRFAySFNjSitJYVN6T3l3MkhLS2tkeHJtNmNPSHFKZTB2d0pqK2pj?=
 =?utf-8?B?OUJ0azFFeXRCSUcvSTdBdng0cW44aDI3N090OGNBeU9aclc2UFIvNzJDTlJG?=
 =?utf-8?B?ZXNMRG5RQWJ1SE1kdnNaQXNsam1rY2lWNXF0TDVYQlV0NUhDM0RocVhpQXNs?=
 =?utf-8?B?aTlON3JEUmtObDhRNnpMbDE5RXhRcDFYUmZtcjhOV1ZYODNDRFBYWUJaalNG?=
 =?utf-8?B?dFp4MmIrQkdVaG9nTW5FVjhIUnFEQmsrNW1ieDNoRVk5ZlpVS1duSnBEYndO?=
 =?utf-8?B?VWorMEJ6WVZPQ0pIZWtTODVYZ1BjaWhYT083Z1hObTRXZU1Nb1YvNWFIc2tG?=
 =?utf-8?B?eXJmM1V3dlJUSDVLU3QwQjVndksrS3gvTU1OQjd4djNYdW9RTy8wcHVWSVV5?=
 =?utf-8?B?bDZCeXAzS0hhTVovODQ3NUJiNjFOcnBKZS8vbUpQRjZ5MkNkSGNDL3Baa3ZW?=
 =?utf-8?B?N1FuTzZpQ0RvamEyTXQyZ0srOGV0RmJ0QXFhWnZYMHREQk1vWnh2SktBS0Nz?=
 =?utf-8?B?a3p1YWlCYkloN012YzdQRTB3NW42MldNUWpqQVlIOXVBMldzT2R5ZXoydStN?=
 =?utf-8?B?QmJmbXdsTXQxR3hzcFdlSXNVdWoraDYrV2o1OTU5Z2xxeEtJOFVlaG1wVGVG?=
 =?utf-8?B?NUNxN3NUU3pOY3NLakN2VGVzc0l5U3Q2dkdOTnZsVW1jUFc4bFpvazMvb2dB?=
 =?utf-8?B?aE9xSVZMYlhFTE5Sc2d4Mlh4eDlNNHpNa05MTHREWUtQeTFLRE9IbjN6akhF?=
 =?utf-8?B?NDRlQ3Mzc0ptTzcvU3dhUmo5ME5pU1BwcHNtYnJ2VWl5VVd5UktzWEZuR1FJ?=
 =?utf-8?B?YlBOYTVyeE1PZ1JHb1pOSFIvc2UwUDFWOU5TYXJwZ2FXckwxSDhvVXFYc2cv?=
 =?utf-8?B?amErRWE5dDkzY3Q4Q3NnSUlNK1VBVmhRemZtTHdzMDZMcERSUk5FQXlsek9k?=
 =?utf-8?B?Rm1uWWZEbWFCUTdxa21nbCtKN2cwcUliZU1lVWU0RGN3SUFzS0FHa1RBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnRBZnJkMXpkeERTb1ZIS3RXcE5rSStXaGhVQVRNelFQOU9wNStWNXNmYktX?=
 =?utf-8?B?Y1NYU1JvNEJqbjBiQ2JVTjd6bEZyUXFpNUFpREJ3YjlHais4Z0hNZVJlQVhX?=
 =?utf-8?B?UWpOdXVrKzB2OHRJTEdMYklnNzRJTkdnRGRSaks0KzFSRlNWeUJ4M1gyUU5a?=
 =?utf-8?B?OVBpdE5MVnpzYW4yT3BiQWhacEZlRWlHZWp5cGUxVTg3MTdFeVVpb29CY1Jm?=
 =?utf-8?B?dkNhWGF1WVhSYitBTTR3VXlyMTlvZm9pcms0d2hFVys4VzRiNXVjY0FtOG9G?=
 =?utf-8?B?MzFNSjRmQ0VHUkc0VlBHODRSVGcraEtjYzFZTjZ0YWF2MmhaSmh2T0JSaytQ?=
 =?utf-8?B?Zzl0Nkx5V1lQOTFvUHRzMTJBRWhkSlpPL2NBNW1WbGs3R1NQcnBORjdWdS9G?=
 =?utf-8?B?ZGYwcDdmT2N3ZWVvdEI4OEZaQ3VwVGg1QzBybFhzSk1ja0hud1lnUW9pUkVx?=
 =?utf-8?B?WVU4bmhZVTlIbDJ0ZlRwUnd0TytNTFRkVWVQeC8zUDlxbm05anFNbVhEWTF0?=
 =?utf-8?B?TzYyUGp1NGlYcHhSbU5SMGZPWmp3R09pMWtqaEw0UHZQcDIrSDQrZHpXR284?=
 =?utf-8?B?aStscjBqV1p2WDU5UkYvT2JyaUVuVDZXalZmSHJqdFRDTnZXVC9MeHk4ZzNr?=
 =?utf-8?B?RFBOMll5RzFHa0V5RVlwam9pL1dQSHFZRWZ1Z1VCcStjcHl2aGhXcGdOL0oz?=
 =?utf-8?B?RFpZRjF3Yi9YTGxnVTJTelpTNk9PL211TkpEc1RZVEJ3Y3FqVDZwSWRodWJv?=
 =?utf-8?B?WnVPQlNxOG5VNVFENGsvZTJmaVRWY3p5SC9oUGRYY2ljbzZiaUIzaXRIeXcv?=
 =?utf-8?B?bGlLSjNPalpmalVaTTBidytwc05MTXBVQmtMWHlnckpxK05Xa295QVMwSnZm?=
 =?utf-8?B?K3YwM3BENGtob0FRRVIzVk5FMzNaM3NWUnRGWEl0bEJlZGx2VThOY29XQXhG?=
 =?utf-8?B?Z2VmckIyQktJankxbUt2Ti82Z05RbWhDV1hIOWk3cHl2TVlKYUtFZld6alNl?=
 =?utf-8?B?bnQrWFAzQW1CVzZyZ25pbytSRjlKd09qRk5raGVIcEJGMGgrdXhKU3FsK2p6?=
 =?utf-8?B?SzhRcmd0ZGl5WFdlbHJ2MWZRSjMyNkNzRDZKU2tuVVNGMEdZM2ZtajdIR0Nu?=
 =?utf-8?B?T1A0TTZBSXJUVndqR2dXTWhjQ01jZ1hEQnVLbU5vVmF3SEQ1aHBqazBvc3Jz?=
 =?utf-8?B?RVZPRXF1TXFtWVZDRitRVHpJamJCWkgrMlNDM1FWZnEwc3lqREw0RTBHdHNW?=
 =?utf-8?B?V21kaTcxM3dEeVpiS0lEWmg2NnJUaXJHVTdpMkNwb3MvVW1ZR3QzcENoR2xm?=
 =?utf-8?B?YXlvcnkxbFBnV28rQk92RnY0ZnBzZk9qS3U5dVdJZ1pEUWRuL01zWWoxK3Mv?=
 =?utf-8?B?Z0ppY2VnMXhERzBrdDZsK0ZhL2VBbHNnQlBEaVRQQWpEL3FXa0d5Q1NqSmNi?=
 =?utf-8?B?cE1MaGhJMW5wYmFwd0thK3R5dmlDcFRtWXdlaGwyYlJZUldhSmdkTll2REtq?=
 =?utf-8?B?MHZDMzEwYWtrd3dGdU9GVDliY1RwMU8zakZENC9RVWVUbVE5RmQvL2gxSzVJ?=
 =?utf-8?B?VyttcEEvWVVuT3NEMUZ1cmJhMHAxZE1uVXphd2VDK2NndXZDYVkvVDNPY2lx?=
 =?utf-8?B?R0tXMWZqUTZsZWVXOTdPMm1EQkVGN1M5SEJhcGtNZnVBNm1GQlNzRmtDTWx1?=
 =?utf-8?B?bVVDSkhmSXhBd21TWDdSeWFQWDBTTk43Z1FMem01dVJlNVh3Uyt4WGwxVmdV?=
 =?utf-8?B?ZzFHWnZrVGcxSWlUeHcvb1pHTlAwTUo2UWxKRGQvZ0ozSjJJWEQvV3RmOHBj?=
 =?utf-8?B?bTJ6dkMweXRLMCtXNGd1OWhpalJGMm01eHhZT3NUbk5idzdnOEU1TGY3eXpB?=
 =?utf-8?B?dkJlNjNpb0pzSjZ6NllNdHVMYkNOMmxtZnQ1RElTb1pGUWF4ZVlVTDVxZGVm?=
 =?utf-8?B?RmRzeVJ1VnNOMXdLV2FGZm12SGk0bVEwWkhTOVVaZVdHd0lIcnhWaXR2NlVk?=
 =?utf-8?B?bS82c1hkQ0R0alNGbXZTRVZoUGJCaWlNOFpNSjNrMWdPeVJPaVdrZjllWnNB?=
 =?utf-8?B?ZFFBRTJCS1FaalNKLytRRE5yeVRyUmMzUWl3Vlkza1g3ZnlaMm43QWNtMTk5?=
 =?utf-8?Q?i2pc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684deb36-2a40-44ce-1f69-08dcec8f44fa
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:32:06.3037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wnzojQYWgLIUug1UUoP5MZjxSyJGOuzEbAZVyrfJcfQzsFEDPdNECmwkermkD82
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116

Hi Reinette/Tony,

On 10/14/24 15:05,  wrote:
> Hi Tony,
> 
> On 10/14/24 12:51 PM, Luck, Tony wrote:
>>>> What advantage does it have over skipping the per-domain list and
>>>> just providing a single value for all domains? You clearly expect this
>>>> will be a common user request since you implemented the "*" means
>>>> apply to all domains.
>>>>
>>>
>>> We started with a global assignment by applying assignment across all the
>>> domains initially.
>>>
>>> But we wanted give a generic approach which allows both the options(domain
>>> specific assignment and global assignment with '*"). It is also matches
>>> with other managements (RMID/CLOSID management) we are doing in resctrl
>>> right now. Also, there is an extra IPI for each domain if user is only
>>> interested in on domain.
>>>
>>> Some of the discussions are here.
>>> https://lore.kernel.org/lkml/f7dac996d87b4144e4c786178a7fd3d218eaebe8.1711674410.git.babu.moger@amd.com/#r
>>
>> My summary of that:
>>
>> Peter: Complex, don't need per-domain.
>> Reinette: Maybe some architecture might want per-domain.
> 
> To be specific ... we already have an architecture that supports per-domain:
> AMD's ABMC. When I considered the lifetime of user interfaces (forever?) while knowing
> that ABMC does indeed support per-domain counter assignment it seems a good
> precaution for the user interface to support that, even if the first
> implementation does not.
> 
> There are two parts to this work: (a) the new user interface
> and (b) support for ABMC. I believe that the user interface has to be
> flexible to support all ABMC features that users may want to take advantage of,
> even if the first implementation does not enable those features. In addition,
> the user interface should support future usages that we know if, "soft-ABMC"
> and MPAM.
> 
> I do not think that we should require all implementations to support everything
> made possible by user interface though. As I mentioned in that thread [1] I do
> think that the user _interface_ needs to be flexible by supporting domain level
> counter assignment, but that it may be possible that the _implementation_ only
> supports assignment to '*' domain values. 
> 
> I thus do not think we should simplify the syntax of mbm_assign_control,
> but I also do not think we should require that all implementations support all that
> the syntax makes possible. 
>  
>> Since you seem to want to keep the flexibility for a possible future
>> where per-domain is needed. The "available_mbm_cntrs" file
>> suggested in another thread would need to list available counters
>> on each domain to avoid ABI problems should that future arrive.
>>
>> $ cat num_mbm_counters
>> 32
>>
>> $ cat available_mbm_cntrs
>> 0=12;1=9
> 
> Good point.

Ok. Will add it.
Thanks
Babu Moger

