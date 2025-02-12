Return-Path: <linux-kernel+bounces-511350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6693A329D8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60AB51886DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85562116EE;
	Wed, 12 Feb 2025 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KDNs/pCE"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C444E1D5176;
	Wed, 12 Feb 2025 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373825; cv=fail; b=Q1RO+oSmYuM0GEouFZrZtzvpE321+DgChLVJRcuApdlfa/JpbhvSj/Oeg2NUYGCkyUt8Zd1rAwkeWPJ7PsdcI82l8dlwd3+mw70daa6ZUysCXOeKdSHHVZW6Qmw07UReLUwzUnFuvK902okOoFTKt2xfJcBg37k7O5WZXTp1oPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373825; c=relaxed/simple;
	bh=6IXj8ekPz7sn0/H4qf8T6MVRoCOBf4LUTCfCdQPik8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JVPjlF6ug1yTU9NjnnXXozRftftbWTRhyQ/0EjhxWe011Fl9/bDDIiR30A96/XVE+ahfr3IxRstZfVq7T3VU5E2TEJJipat26/+zo8KpgWMyHIZJbiU+aX1/CVyxj9/7/Eyq/FVrn8JGH7r7w5rPo1Pjqwxj+64+fTPYrNLVs7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KDNs/pCE; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CscaezITUFe2C/m+x/A1YkHugOTS6imFzoZHVXO1y3WxcEnEoaXLOc8ksrIIzzKHArao6oBAS0Kp44aaDwcLBFnMS7WuUJvmL57hem1xxeaMguNPodjXv80zRH34lX1Z/rjRvxkpDOLxNexjf3UHsW2YioDPSSjwDZlrcsUrbgdeak/AMYRM2S45ixQYMEgEfNMYfEtMbuu7fNRBq3kq9c0jg+eyicL5WVjKZrDZa7LC0KNzsDgp/MhTWS+T9DgGxqd08h9m9gZJvD7gC7k9GynnMF49/OktT61GmWA4pXeCRDX4RV2skXh+z2QBroTAT7Yn9Ano62iGa8gWSUw01Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS4kBGgLsWLc6mLv3rvLLJcdQ9LwKsqBWtsrT9w6dYU=;
 b=fOMqA51YkNRa1KbeRAbUQF+BhaIbAq5Yjx/jQnk1wRZ10q0QXRUmewpxLvXx8eCyLMceVUZw2ewtbjfNKUSHojcfB6KC0PkRknV3sYTw3b9xaLNpX+ZqUzE+rpHsoB4NH/HnAehNm5tCqJop4qWdHOq5ir83fVYFQvvVVD5HZI0QNX16QCkgel33zKct4fCzRqDSLIDkTqRojzolvABZ1N3cim5vN7dcN8INFbLtbvYMBOb3KNbmsbgLNh0amZY6bav3WAzOxZ/UikpQcoC/SbslZHquIXgI+AGOpG4dFuERfoQK0aCFQMaMsdHCqIMAp8bQ26UTsLLEOVGh7OSnxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS4kBGgLsWLc6mLv3rvLLJcdQ9LwKsqBWtsrT9w6dYU=;
 b=KDNs/pCEqsVFzL+mPKgucZy3kRTBFIJT8FcQuFS9XyyufE/YfKe/RxLr5a3+UUyDskyUQfx7u2y5mbHXnEOL2oJ8tMZxJY7f7WsYgojXvmyXqXtUXXRERlIytSrIShpNk3PFz2Yu8r73cjDVgZC/cX0HY6dvn0n0q2a76eu3Lm2fG+kYmoFYdGr4ojUL7Sxsq0MsM00T8yomV4qRrbvPhUXZVJ7A77t9VKedPwTN4m5+gf1KxXrWAaQpjk/jVKXIsmNpK6SlV6CpnrKPya7xJub6lQFJ2kXW9+1EIEXQlCDQX9ts6RAj4h/q2sjXb7y2a1ooW8WpEkAnqcdlNbkMHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by PH0PR12MB7838.namprd12.prod.outlook.com (2603:10b6:510:287::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 15:23:38 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 15:23:38 +0000
Date: Wed, 12 Feb 2025 11:23:36 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 05/14] kexec: Add Kexec HandOver (KHO) generation
 helpers
Message-ID: <20250212152336.GA3848889@nvidia.com>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-6-rppt@kernel.org>
 <20250210202220.GC3765641@nvidia.com>
 <CA+CK2bBBX+HgD0HLj-AyTScM59F2wXq11BEPgejPMHoEwqj+_Q@mail.gmail.com>
 <20250211124943.GC3754072@nvidia.com>
 <CA+CK2bAEnaPUJmd3LxFwCRa9xWrSJ478c4xisvD4pwvNMiTCgA@mail.gmail.com>
 <20250211163720.GH3754072@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211163720.GH3754072@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0303.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::8) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|PH0PR12MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1adb2b-b545-49aa-b5e8-08dd4b79398f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4r6B+LlKtbfYogL+ZfFaeoTILB3a12Hhb1BkGIjQ1BGr8Ju3R1Xr/cHKWA5A?=
 =?us-ascii?Q?n17IgOcsEgG9g5q7xMP8aXR69gYqD/G71LPLLnqEXXphi/hhKqU7UXN1teVA?=
 =?us-ascii?Q?K2Uf1DzX+ZZ7sGK3tfe0abQarkFdbeW+GWqIlU340unnPwtyLNpdEc64sf+S?=
 =?us-ascii?Q?j3uEFF66MJli8O5TOjhL2uXXxvlrmqNKaIJTUJAqsEzR0geYpVPB7LC9ZKZI?=
 =?us-ascii?Q?fYORl0RIlrKVeimLsgloEnmMLlfBVf382FU5Ky2iHwQ0vG2hyfOXulNrugkj?=
 =?us-ascii?Q?XhSImHSVwdfooRhVGOmeQn49u7pQ6FPZ7G4U4EkU2sWTYlHGpgrQq6GpjbIx?=
 =?us-ascii?Q?SwCVSdgBGsMGQrgs2hkG8Pw/MowiMMCw+ezvIVekqCcaIi470BLslnbuHiRc?=
 =?us-ascii?Q?lKG4NRLASwhqBPKyB99MQ8WOjCSfHS35k8m7fk1Sg6Xv/T4vFApHyNtUzl8f?=
 =?us-ascii?Q?9bVQkhGSRku0Bw/u+BlmqsHx5sm/D37vbhwac6Vedw/nUCEz+xG78Ks0z4MN?=
 =?us-ascii?Q?uZVMZdxYddw5LAVm/pctw+QPqnbU5ei3/OFTr/38R64+R/F1HEOFt9S1WVAC?=
 =?us-ascii?Q?Y2ljUJ1hiXyivi8WCrl4++8x03wpO1jDFOEB5oShhYZHhdZnNS3XqywM2lHa?=
 =?us-ascii?Q?jyRKEVDRL5rUDaJ6LPjZ2MCjuysgfWvrYH1RdauT4519AlBVVbbdd6xJ89qr?=
 =?us-ascii?Q?O6j8Yv7lJJw6jWyyvRm8ojsLPqDeec83yT6r4SE+kmhXz9VL0OgOKXs8dLQ2?=
 =?us-ascii?Q?MkW1y9Jh1vaXtp9OS/olOZ1v+FxkiKk7wFU4BayT44XdGS2ZyEX8mwKJ6/U2?=
 =?us-ascii?Q?MsSKUGv1yQ0wfWHFC7cjQrJaHAwf8jVWRfqkbJcOOMjKJilhPA0Yv3E+NOkW?=
 =?us-ascii?Q?rDUrGGJ3TbVq3j35I3BrSTnboTZNqKLYx3nY0LChblv0gGJBz/nEVxwHf75+?=
 =?us-ascii?Q?V+rOVk10GDYuLL5QiInO+3tW1UU53gEWNvjQZ90Jyk5G6YMXlRBxMh4WbPGC?=
 =?us-ascii?Q?nfHErFDtybSirV1CXQVJwsOJkJhbRa0Vwatt1w1ZdHHZXQxmrwSygcg1pMNa?=
 =?us-ascii?Q?6srHnJa7/yZgEfFKHC62c9MKJyzJN+crw9NuKbcqt8XCNcTvtEd5ojQrwEiS?=
 =?us-ascii?Q?FvlioIr6CkCZpbyapSc8pb2lMLRbnMCUT10ISzy6F6OBc5TfGYXmdHnLOhhD?=
 =?us-ascii?Q?gtvTNvegQUNTFurXw0d/W/SgkA6Hes10Cb/KGZ9Pip7eeJdHPsFmwBC+bCMD?=
 =?us-ascii?Q?S2W6Z1HKAhRticJUH62/nLx0k/HbNP+uSSBchGBkUdKfBoxw1gK0PUP1SUVG?=
 =?us-ascii?Q?x+Ay6Y0uYOl27nUdXnIu2cfKkxg1FLgxNgQjx1yI5sib4wPEIvaDBZULmXtS?=
 =?us-ascii?Q?9wcsUXWdT3GBleHIBoQunStrd0hv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6zG97Ny/NhkvT+DrgpRZ6S8HhSZcRruwbxceshPdoKYIqy98+y7XyybHQzR/?=
 =?us-ascii?Q?Kx3jbeOnx5WuYkSVhTZvOROOBdLPi5sC6+L6vT4gPiQ4M3WphtpapVE8YqsE?=
 =?us-ascii?Q?jym5dSl40QEKo2nbh7R7nT05tfKSyfkMZr3BQODE0PONXAnRLq0yJheNaKci?=
 =?us-ascii?Q?bop0V+EXjPGUk4Q0UFXPiit4TFKq3qQPUhnYtq+5mRLD8srPdA3SVd+/EwQt?=
 =?us-ascii?Q?iCmzyILMuSGZtgQDX485VvQ02wSKj/vh6Duhye76o8ScbSNtgktpcZndvmj3?=
 =?us-ascii?Q?X/wlqwrKH93bMFyxHz/HpjJlFnsvCmHgC7Ydbv11GzvRBnbfi83cr9nNCQex?=
 =?us-ascii?Q?IyPQ6RIEyfWgmbQa+mlDH8JX+rHOPEZirlKUF5DyX2oqFMAkHzJPc2Y07LV0?=
 =?us-ascii?Q?vMQP2lOmudEZIHLuXC0qJnyQQdgFnDixOmXrGylk91epd719742OvGKNzwID?=
 =?us-ascii?Q?aiW6XZ6VCC7tJmFCXgXLT37hbkfg6EQ+Cc520WwQ1emqR3hFzj96dHAaVOkY?=
 =?us-ascii?Q?YJyZvhbm8PNqdDbKU6TYUOhqXwpkKxWsX6uzj62dXPsZ1jXH/JOe2/pai7ys?=
 =?us-ascii?Q?HdIBhued8bM8+XzE277ClD1bYjBmb8lDU/24Y+AyXF13xETf0yEC9OEKWnad?=
 =?us-ascii?Q?lTZL+3lVd0tTF6kNVQgPsj6U4I8sh/bp2J1eIvCaVmZg2zIwIKs/qOa+4ybM?=
 =?us-ascii?Q?cS4TM0/znPoByrQSkXDsjeQ4Pi8QNghBOSAg1XLWURCb5SdSWMvP3h73euod?=
 =?us-ascii?Q?kpzZVnH7vHjxp2HeYBNV9xOPMqBqraevyhncOsfhKaFYjl38eATVrxkRMnCk?=
 =?us-ascii?Q?7GVWXqG1SMMMjHXU/9fp0g+UHPbsKuT2lFB5FskFlMBmOpJFciIzasiol0cC?=
 =?us-ascii?Q?TW+TZXcu7pk65fF8CTtD/RHG59Q3q9yCiIMebXXzGqt19kSqyglS8wcU85oX?=
 =?us-ascii?Q?UUXNIwdyyfn6kGUKI+AQ32PvYFzA7vVhOKhEkx8vR8465nZz5HnBm2umyv72?=
 =?us-ascii?Q?LGs/w53NYgJOImdpx8XwZCVeThmnY2ko7cN9kfuB/ZHdm1EePb4qHy3HOBGC?=
 =?us-ascii?Q?joU+gkltwY/H4oPKGMxSbe1YBBXNkXnaULqvg7ymRFSV0QF+qlGCuvLiOnDX?=
 =?us-ascii?Q?IZ5S1SPqGYV05L8SoiPLPgBZUpLiCBS9RaXo/sv2eKjZO0eTUPXFn91yx5zZ?=
 =?us-ascii?Q?bCyfMkV170VkaHCf1p2m5Ll7nqEe3FBy/fwF2B3nGnPSyS4KGXN35b1Sd7z6?=
 =?us-ascii?Q?uW58Une0RiHRkZjdz5GiClOTw1+rnd9bVzxH1cNoNC9hCI3mnTWw9IcCkkqB?=
 =?us-ascii?Q?hzdE7OzTeK6PdNfVeFA9rPmLavhIKyKwhSWwxY/DJjv1Ozpy3cMJGM5jxH+f?=
 =?us-ascii?Q?StpG4WT+pOLkQcYSLENamdJKnzNwdQnu7+ntXfbmrvPrSUBPmMuZKqTrKUA3?=
 =?us-ascii?Q?JT/BsK3eGvYMzLk+bmSp97dh3UVpg5DDbwZmDI/7p1PZsy7vIWLOBvMOzMcB?=
 =?us-ascii?Q?wKFOLpCdkEk0XLyd8lKmvXWkzqNRCAxIDiTSQ5QezbwNlDfsoDMd6TxNMd7O?=
 =?us-ascii?Q?riA76Pd8PSSWuzawOg8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1adb2b-b545-49aa-b5e8-08dd4b79398f
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 15:23:38.8210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQc344HRnWLI//BxrMm/7uXzCAy94KJvhtiSQuYTmPaKDwDBU7ud4HX4yU+W1ecf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7838

On Tue, Feb 11, 2025 at 12:37:20PM -0400, Jason Gunthorpe wrote:

> To do that you need to preserve folios as the basic primitive.

I made a small sketch of what I suggest.

I imagine the FDT schema for this would look something like this:

/dts-v1/;
/ {
  compatible = "linux-kho,v1";
  phys-addr-size = 64;
  void-p-size = 64;
  preserved-folio-map = <phys_addr>;

  // The per "driver" storage
  instance@1 {..};
  instance@2 {..};
};

I think this is alot better than what is in this series. It uses much
less memory when there are alot of allocation, it supports any order
folios, it is efficient for 1G guestmemfd folios, and it only needs a
few bytes in the FDT. It could preserve and restore the high order
folio struct page folding (HVO).

The use cases I'm imagining for drivers would be pushing gigabytes of
memory into this preservation mechanism. It needs to be scalable!

This also illustrates my point that I don't think FDT is a good
representation to use exclusively. This in-memory structure is much
better and faster than trying to represent the same information
embedded directly into the FDT. I imagine this to be the general
pattern that drivers will want to use. A few bytes in the FDT pointing
at a scalable in-memory structure for the bulk of the data.

/*
 * Keep track of folio memory that is to be preserved across KHO.
 *
 * This is designed with the idea that the system will have alot of memory, eg
 * 1TB, and the majority of it will be ~1G folios assigned to a hugetlb/etc
 * being used to back guest memory. This would leave a smaller amount of memory,
 * eg 16G, reserved for the hypervisor to use. The pages to preserve across KHO
 * would be randomly distributed over the hypervisor memory. The hypervisor
 * memory is not required to be contiguous.
 *
 * This approach is fully incremental, as the serialization progresses folios
 * can continue be aggregated to the tracker. The final step, immediately prior
 * to kexec would serialize the xarray information into a linked list for the
 * successor kernel to parse.
 *
 * The serializing side uses two levels of xarrays to manage chunks of per-order
 * 512 byte bitmaps. For instance the entire 1G order of a 1TB system would fit
 * inside a single 512 byte bitmap. For order 0 allocations each bitmap will
 * cover 16M of address space. Thus, for 16G of hypervisor memory at most 512K
 * of bitmap memory will be needed for order 0.
 */
struct kho_mem_track
{
	/* Points to kho_mem_phys, each order gets its own bitmap tree */
	struct xarray orders;
};

struct kho_mem_phys
{
	/*
	 * Points to kho_mem_phys_bits, a sparse bitmap array. Each bit is sized
	 * to order.
	 */
	struct xarray phys_bits;
};

#define PRESERVE_BITS (512 * 8)
struct kho_mem_phys_bits
{
	DECLARE_BITMAP(preserve, PRESERVE_BITS)
};

static void *
xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t elmsz)
{
	void *elm;
	void *res;

	elm = xa_load(xa, index);
	if (elm)
		return elm;

	elm = kzalloc(elmsz, GFP_KERNEL);
	if (!elm)
		return ERR_PTR(-ENOMEM);
	res = xa_cmpxchg(xa, elmsz, NULL, elm, GFP_KERNEL);
	if (xa_is_err(res)) {
		kfree(elm);
		return ERR_PTR(xa_err(res));
	};
	if (res != NULL) {
		kfree(elm);
		return res;
	}
	return elm;
}

/*
 * Record that the entire folio under virt is preserved across KHO. virt must
 * have come from alloc_pages/folio_alloc or similar and point to the first page
 * of the folio. The order will be preserved as well.
 */
int kho_preserve_folio(struct kho_mem_track *tracker, void *virt)
{
	struct folio *folio = virt_to_folio(virt);
	unsigned int order = folio_order(folio);
	phys_addr_t phys = virt_to_phys(virt);
	struct kho_mem_phys_bits *bits;
	struct kho_mem_phys *physxa;

	might_sleep();

	physxa = xa_load_or_alloc(&tracker->orders, order, sizeof(*physxa));
	if (IS_ERR(physxa))
		return PTR_ERR(physxa);

	phys >>= PAGE_SHIFT + order;
	static_assert(sizeof(phys_addr_t) <= sizeof(unsigned long));
	bits = xa_load_or_alloc(&physxa->phys_bits, phys / PRESERVE_BITS,
				sizeof(*bits));

	set_bit(phys % PRESERVE_BITS, bits->preserve);
	return 0;
}

#define KHOSER_PTR(type)  union {phys_addr_t phys; type ptr;}
#define KHOSER_STORE_PTR(dest, val)                 \
	({                                          \
		(dest).phys = virt_to_phys(val);    \
		typecheck(typeof((dest).ptr), val); \
	})
#define KHOSER_LOAD_PTR(src) ((typeof((src).ptr))(phys_to_virt((src).phys)))

struct khoser_mem_bitmap_ptr {
	phys_addr_t phys_start;
	KHOSER_PTR(struct kho_mem_phys_bits *) bitmap;
};

struct khoser_mem_chunk {
	unsigned int order;
	unsigned int num_elms;
	KHOSER_PTR(struct khoser_mem_chunk *) next;
	struct khoser_mem_bitmap_ptr
		bitmaps[(PAGE_SIZE - 16) / sizeof(struct khoser_mem_bitmap_ptr)];
};
static_assert(sizeof(struct khoser_mem_chunk) == PAGE_SIZE);

static int new_chunk(struct khoser_mem_chunk **cur_chunk)
{
	struct khoser_mem_chunk *chunk;

	chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
	if (!chunk)
		return -ENOMEM;
	if (*cur_chunk)
		KHOSER_STORE_PTR((*cur_chunk)->next, chunk);
	*cur_chunk = chunk;
	return 0;
}

/*
 * Record all the bitmaps in a linked list of pages for the next kernel to
 * process. Each chunk holds bitmaps of the same order and each block of bitmaps
 * starts at a given physical address. This allows the bitmaps to be sparse. The
 * xarray is used to store them in a tree while building up the data structure,
 * but the KHO successor kernel only needs to process them once in order.
 *
 * All of this memory is normal kmalloc() memory and is not marked for
 * preservation. The successor kernel will remain isolated to the scratch space
 * until it completes processing this list. Once processed all the memory
 * storing these ranges will be marked as free.
 */
int kho_serialize(struct kho_mem_track *tracker, phys_addr_t *fdt_value)
{
	struct khoser_mem_chunk *first_chunk = NULL;
	struct khoser_mem_chunk *chunk = NULL;
	struct kho_mem_phys *physxa;
	unsigned long order;
	int ret;

	xa_for_each(&tracker->orders, order, physxa) {
		struct kho_mem_phys_bits *bits;
		unsigned long phys;

		ret = new_chunk(&chunk);
		if (ret)
			goto err_free;
		if (!first_chunk)
			first_chunk = chunk;
		chunk->order = order;

		xa_for_each(&physxa->phys_bits, phys, bits) {
			struct khoser_mem_bitmap_ptr *elm;

			if (chunk->num_elms == ARRAY_SIZE(chunk->bitmaps)) {
				ret = new_chunk(&chunk);
				if (ret)
					goto err_free;
			}

			elm = &chunk->bitmaps[chunk->num_elms];
			chunk->num_elms++;
			elm->phys_start = phys << (order + PAGE_SIZE);
			KHOSER_STORE_PTR(elm->bitmap, bits);
		}
	}
	*fdt_value = virt_to_phys(first_chunk);
	return 0;
err_free:
	chunk = first_chunk;
	while (chunk) {
		struct khoser_mem_chunk *tmp = chunk;
		chunk = KHOSER_LOAD_PTR(chunk->next);
		kfree(tmp);
	}
	return ret;
}

static void preserve_bitmap(unsigned int order,
			    struct khoser_mem_bitmap_ptr *elm)
{
	struct kho_mem_phys_bits *bitmap = KHOSER_LOAD_PTR(elm->bitmap);
	unsigned int bit;

	for_each_set_bit(bit, bitmap->preserve, PRESERVE_BITS) {
		phys_addr_t phys =
			elm->phys_start + (bit << (order +
			PAGE_SHIFT));

		// Do the struct page stuff..
	}
}

void kho_deserialize(phys_addr_t fdt_value)
{
	struct khoser_mem_chunk *chunk = phys_to_virt(fdt_value);

	while (chunk) {
		unsigned int i;

		for (i = 0; i != chunk->num_elms; i++)
			preserve_bitmap(chunk->order, chunk->bitmaps[i]);
		chunk = KHOSER_LOAD_PTR(chunk->next);
	}
}

