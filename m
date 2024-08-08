Return-Path: <linux-kernel+bounces-279865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A14394C2C6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08DE28150B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE6918FC8F;
	Thu,  8 Aug 2024 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPll0NoE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1088F143723
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134734; cv=fail; b=H048Q/4YnWIHqpzsFcahjjAFnRqdLyWOG9/cnTSyyxcwBfm56pQdYY4Hd8VMn9iwnVJXf6fl7YgevWZ0g8YKyYhCdeW5iGjcHQyQ7/lTGJifwHN4/V55FHZUaBiJHjbQxqfMOpk9wxAyokL2nLPiPslCdCh63Z/urFyR/wjSkQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134734; c=relaxed/simple;
	bh=JoAFE7mvj90mOvLcYGyxLCqU5LJ+ANdjKJ8ruhjiDUc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vFDsepL/zF6HxFBblHyurqVM2lNL5ST5wBdEu3kxdwwaTJS7wWKBDXGKwtiqk0UuEYYU8i9lprkPCEsoaF+o+doMP2eh0BTR29LEiuHZVaDoQu58n2+Qta3K9DIepZNvatl8SKvaQsrJ6jJbJoK3eVlslM4TacVQvzD3enBKLw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPll0NoE; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723134733; x=1754670733;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JoAFE7mvj90mOvLcYGyxLCqU5LJ+ANdjKJ8ruhjiDUc=;
  b=PPll0NoE3B/p62/OXrMl5vrYUsfAWhkyut5gYKxL7dgZG3gqU0q+wk8p
   rStFO7bRllo2SzpmDcfXQyFie0anK1EWlsjYBZJIg3MI8r8afykrx9Ta3
   h8zr7KhLu/xVLJtm9wqA8L68h+3yEF4lIMPYuWrmp9bU51fay6y5VInyi
   Zzb/cb6WuyHtZm9YP1U8sNW85rF3CCFygrrs/a7KyIvtxzFizg4kCf+ve
   UV1yRz0pLWN1AqRt6payIFDPJBXh1a08EmT/f7OoQjZQbqg4MnZgPP8st
   NhcourXRM2f9Augynxbh3uF1Ki1yhhDLxq+Iy0fcCqmpF0CAbEUB0DvTo
   g==;
X-CSE-ConnectionGUID: cz0LCy/sT9GIfYBnug9jmg==
X-CSE-MsgGUID: U95epky+TSu81QBVf2/2rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21431908"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="21431908"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 09:32:12 -0700
X-CSE-ConnectionGUID: +GGRNJw5RGiHadvW24S7Zg==
X-CSE-MsgGUID: vkxgKakRQX+Q0kxapO5bTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="62142313"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 09:32:12 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 09:32:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 09:32:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 09:32:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIfw26hoxssf3FQkJrCfbaiJ5Lyz8yClOtT5Jn2bgP4cL/1xpfamOGHj5KslteTtRfVT9mN0dyfEUooN/DgUIOcRM3pS2EcKJm9eB33m6IRKa+wnsdB15tqrkjEZ5K/hu6xiSHCdTqPULn+pkd56rX+aR2oxrp/aHUH+2BCh8hsE/xdfrHQtMZJNhOueHjS+T333nRzXQ71a58Kb122qQSXD1OwTk8Nxe9zkd6y9BAhQsKaqrtRlHS40q715t0Yx58qz7ghHoyAl7OfEp4xnt2Mg+R6ge6M89ta1jzzT1OTlmXAhluPDJJYxVvD47qq095pRa0iw6pKofNLRV1uLHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3g+2j59YN+8LGTjh2c1bw0OVNSSuB4T59kuUPM5Tzc=;
 b=Jso3MqeL94X1jzMkCn6CKYtHrrwiK4QJdhcoI2FkDYKOYGKzBtS48zH31jLAsa4hDX7rGew0Fu13i/BHqBG+CZcA85ggJhj61UTLSRylQmK+4PBnbkzQbCkECiNoRXUmgjDoGJR9wkAjzIUqrroczb58jcmiP6AEvsiKCCrORoYssJFmVAQ50PKJMWwRrK0T9CVaiFalvJ34q2FxXVbbyKcwYQ1YV6yvwd9gEjCQ6B4SvO3zBtRc81ecwh7Xh8KoX3Btpq8Exsb6kczj/Tjsm5qb4VdgeJU7La1yjnukqWu6g04vDpMcKM1a6VVtluXhJ7SHWDyRmILEj/o1XORzmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6279.namprd11.prod.outlook.com (2603:10b6:208:3c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30; Thu, 8 Aug
 2024 16:32:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Thu, 8 Aug 2024
 16:32:08 +0000
Date: Thu, 8 Aug 2024 09:32:06 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Dan Williams
	<dan.j.williams@intel.com>, Max Ramanouski <max8rr8@gmail.com>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>
CC: <max8rr8@gmail.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	"Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
Message-ID: <66b4f305eb227_c144829443@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230810100011.14552-1-max8rr8@gmail.com>
 <87le17yu5y.ffs@tglx>
 <66b4eb2a62f6_c1448294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <877ccryor7.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <877ccryor7.ffs@tglx>
X-ClientProxiedBy: MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: eefa866c-e51d-413e-3fc5-08dcb7c7a57a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FAf8URlTeUcaUo6cdOMicTjxsIbXw3ycxUklGiF3lpBmiy+Hy27OXjk9wvJH?=
 =?us-ascii?Q?nRjKPotGGDMjgr20mNh1Dq0W/otZPoZWsscnNRDW0gW6aiaDL6MIMveOvvZu?=
 =?us-ascii?Q?Yn9mHF2uj37V6E3u4K1FwF1xminTo5DERWiuksQG58ubT99hydqnW25yAwC7?=
 =?us-ascii?Q?erlUjm4YfgND22m6n1gA4w8c2TMp0f+xtCHpEZ7MiO6JiL8KOHA1/5pJruwe?=
 =?us-ascii?Q?muXFCixpp4ZA8p+sU7uyoLnk5lEcJFSXrAp14MNkML3A4kMRm+QlhTrWa0yz?=
 =?us-ascii?Q?T1jzJ1PTtMe7qrCl46gInmNocqWhBHGDJWyl/k6mNR2ahV7j8vkC491412Vr?=
 =?us-ascii?Q?KgOP0oKEg9G0TdR+QPuX5RaHoZ3oXtR7vdZV/WgsNdnrEKAbTzQzJqhu8Inu?=
 =?us-ascii?Q?ijxwM0dsBxSRVEUCIBzgM0LlVcPGsVooMDM5Gy28nErNgKBbtwG1/RY9o0ri?=
 =?us-ascii?Q?hRXcOaTx6FEprCc9dKYp+q24eTry9zMMei6ylfN3/E5PH0a5auCrbOWRuOo9?=
 =?us-ascii?Q?z7v69JB4L5S+u/fz2d0ChADEniCx3qxQwbkwR191zlBJKRMXIWHuWtAsVhlv?=
 =?us-ascii?Q?nfgVNmkmaQFuYrHre75hn8Nax7a3aOi/XtG/ELP9v5oLkjnHrcoumFATED1q?=
 =?us-ascii?Q?tnHxf/jIjAr1K1vJ0/KQzPHfXZtOxY4gk5Ge10dbQedXxSTnyIsD9S1/eZEO?=
 =?us-ascii?Q?ZQhtnhvSXIBZ04pYMuAI2WF0sydqzAm9ozHJRKwUgNTUuyi5aC3mcDfq1PHD?=
 =?us-ascii?Q?7OYkb33QSIWVFcHJmOpjqWpGSnIfOYHnQE6d58RydXiuSlyS0F9XJhoi+rml?=
 =?us-ascii?Q?PyHmjP9noKp2tHr+JIDO5BOPBQOHT/a72C9hc1T8UXZnVFgBU0DHjeHL3vG0?=
 =?us-ascii?Q?f/XxPRRZyRm3y4OVqDjibWNP2PlodnOaj/m/RHuP0W80B+Z89d18mMQccKae?=
 =?us-ascii?Q?kysPq7zH1MICDIMr2gM8N+AY1/RkzVdPm45Oaov4upwusTtY7HUhryPdEKOl?=
 =?us-ascii?Q?UsYaredNgFP3yf+69WDD3KF0K5trZ58/pUM8JFNg9rnFX2ZHdwckgSMMTCYt?=
 =?us-ascii?Q?bJdMVgWTIV0CFXyEz4fJfSXaFlLjjkkZCPq4MFhF9q+2pY585i8/6cvVc1/m?=
 =?us-ascii?Q?6n2S5zEnNOoSJkavvb4MpD5DpqnUrHtG4Pt+bxjt/MPl5sE6m5awlm3cCQtB?=
 =?us-ascii?Q?VcuFZFMtgg2tleMN4Nh0hSpA9nLUnoGw7IBn150KkVxU/PCFVB+ZSPMHo8im?=
 =?us-ascii?Q?siv6SizGKvJnY9azKu9qtxRDfs0fnVH9/qr7rL1mcbwD7y0culr8gQfOA9DN?=
 =?us-ascii?Q?ORbFmvsjpWmsaWlkc4BWhyV1vopxR6Y07ZzGgY1O6WywYg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zbq87nR/TvdGK46C+sZJm4Y/6P8Vvcb2YlKvNV6w42SWUzAIlwxJPgG6ZA5T?=
 =?us-ascii?Q?DTU5p+8ntILGmJ42Te/8P5krKb3WF+2E1hrTbZK7c+8wJBDTo376occocs3C?=
 =?us-ascii?Q?WsnFCC13NtkKyi5JcZkIFqHcV9A9ckZq8TkWZ8r6fQ8869JBD1pIOE7eRnB6?=
 =?us-ascii?Q?WiqrqHEVYFBh3R25+7XkULpI5GihIBX3LoogJQt33x7UPbImyfGcIQ8xQcn0?=
 =?us-ascii?Q?IpTcMkCyVzlu7LafMy2IAb2yERA0HkkQ5SzDJEFBAemuThI2rtFkSu76uUdX?=
 =?us-ascii?Q?iszrfjeeeruePOjjUQuyXMM7ErK+7Dfgi+n8oBUyvj+cH8U9LrT/1Rklr7od?=
 =?us-ascii?Q?J0Pgx4dt8oeKMJxIiwS6b9nESCrAyHfN8CETRC5BSsMfZlGJX2MPwOtxphtO?=
 =?us-ascii?Q?ZcTD4O7vw6hq04vDgwP/ZnLkK7t8Tjv66d9Ao9QeKsx587RxIGgGU5Zn5+rF?=
 =?us-ascii?Q?EwGqZTL5+cFePS8g5lAfuDEb+0o8RosLWILUoD/3asEbcp2HMZrgMe0cBPl4?=
 =?us-ascii?Q?DVOTy7byRszhwWx8jPtcRmUQ4I5BQLKOZ+X9fc2uRZV4vzisMidwD7FHk5ju?=
 =?us-ascii?Q?gmbelqDJzovpptEXwaORKew52VHPNi1eQv9jarylERgZek3FjvzW9zE9Iyd8?=
 =?us-ascii?Q?coIqfBmg83hIj16LvkVtTwSCHGMnlKMggYaVF/XniuYViRBe88Sa4FPpUsoN?=
 =?us-ascii?Q?LXVcprrFkAR2XpgGI/O7uVHuZCr3rJssuDvkjaFz5fP4xsfs1ZIQIC3FAbfe?=
 =?us-ascii?Q?3Xu93PopYJvAARBWBhxktHnPsft+blbA3eOGSVBQf2XdtjwFJepx65NbnYEx?=
 =?us-ascii?Q?jj6/n8bMrFd3pnXxI6msCDDfE5Obk6j5rGumrvclgr9gfv+YvfFeREgjwKLW?=
 =?us-ascii?Q?GmdJmtrb7XJf/ACFTHMDNWWEPsIA4cMsmvJ9pD+jYZpd8FJEfAgyyHCXN4he?=
 =?us-ascii?Q?0Bi6CAi25rpY2/zOYNjDnsw/AyGlisy5b2mBUtfqI59UMKSf5N1shwrxTLCp?=
 =?us-ascii?Q?Q9zXiTJSt5Qk2OUqHrF4JjXHkvZmsH0Oj3jbp//G89g6+ar/STxAe3n3a+f0?=
 =?us-ascii?Q?gEeDukoZ/QZyj4FJUyCqo4YfAXtD+lbT+CeEmp+IF4K7T9oawYPk7feO6Q7i?=
 =?us-ascii?Q?fqGD7qjdTydEKJ6EDm2hvUBs2DFrFZQ1+T3uUImSGtMNBpgo+7LCxQ4WwVHW?=
 =?us-ascii?Q?+eGTNuuuQvzXK/GPmN7Z+sifuFziJI3htG8Nu+UVI969ixQxo4Zdn3ZHlWBN?=
 =?us-ascii?Q?3ZkFu3bboBa2KwQq/EqZ+9yfnDNPj3a/sAqjv3S+8x5+13HSH+EJd8pLGAas?=
 =?us-ascii?Q?kAp1DG88CjOHiMkPtck2GblXhQtRaCxm47bLEF2CbUirQt3KiaiXP3iG/X20?=
 =?us-ascii?Q?ZwntMr3IL+ZRE/gwZrBql3NyMx27C9WqoI9za3EP0ia1hFSIEMkemSAv+UjL?=
 =?us-ascii?Q?eStQ3KF375sxXRYWL9Y7EZ/WH3PLzY/8SygV9RYHt2GUA0NCn66WY1vYRqTY?=
 =?us-ascii?Q?BSXUgyffIN8R+XlrPK3r+CYE6ZUb5tM4qJ1M1R/FqKQRU3o4NQZED/r3qrKl?=
 =?us-ascii?Q?6pfDLAe7YT8bVg/xJMsdvGkSVlt+yZUeFfAqIWQsXnRsuymkEguM9bQIflCC?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eefa866c-e51d-413e-3fc5-08dcb7c7a57a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 16:32:08.3616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvr4Hka2qFLDGc/hFBCrM3GIx3+4dTVur2Q9lok8+Y4qpf+vf6UK1D6SoCII+6+eB3xl7tGVum/7NNcsrJGRRPM7xhVR2rY7Ly20Q0p+UO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6279
X-OriginatorOrg: intel.com

Thomas Gleixner wrote:
> On Thu, Aug 08 2024 at 08:58, Dan Williams wrote:
> > Thomas Gleixner wrote:
> >> On Thu, Aug 10 2023 at 13:00, Max Ramanouski wrote:
> >> 
> >> > On systems that use HMM (most notably amdgpu driver)
> >> > high_memory can jump over VMALLOC_START. That causes
> >> > some iounmap to exit early. This in addition to leaking,
> >> > causes problems with rebinding devices to vfio_pci from
> >> > other drivers with error of conflicting memtypes,
> >> > as they aren't freed in iounmap.
> >> >
> >> > Replace comparison against high_memory with is_vmalloc_addr to
> >> > fix the issue and make x86 iounmap implementation more similar
> >> > to generic one, it also uses is_vmalloc_addr to validate pointer.
> >> 
> >> So this lacks a Fixes tag and some deep analysis of similar potential
> >> problems. While at it please use func() notation for functions. In the
> >> middle of a sentence iounmap does not immediately stand out, but
> >> iounmap() does. It's documented ...
> >> 
> >> This add_pages() hackery in pagemap_range() is really nasty as it ends
> >> up violating historical assumptions about max_pfn and high_memory.
> >> 
> >> Dan, who did the analysis of this when the device private memory muck
> >> was added?
> >
> > So that plain add_pages() usage originated here:
> >
> >     4ef589dc9b10 mm/hmm/devmem: device memory hotplug using ZONE_DEVICE
> >
> > The original memremap_pages() only ever used arch_add_memory()
> >
> >     41e94a851304 add devm_memremap_pages
> >
> > When HMM merged into memremap_pages() I indeed did not pick up on the
> > nuance that HMM was wrong to use add_pages() instead of
> > arch_add_memory() which updates the high_memory variable:
> >
> >     69324b8f4833 mm, devm_memremap_pages: add MEMORY_DEVICE_PRIVATE support
> 
> arch_add_memory() calls add_pages() ...

Apologies was trying to quickly reverse engineer how private memory
might be different than typical memremap_pages(), but it is indeed the
same in this aspect.

So the real difference is that the private memory case tries to
allocate physical memory by searching for holes in the iomem_resource
starting from U64_MAX. That might explain why only the private memory
case is violating assumptions with respect to high_memory spilling into
vmalloc space.

