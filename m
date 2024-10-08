Return-Path: <linux-kernel+bounces-354322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA919993BC3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC53C1C229D6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 00:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D22B8BEE;
	Tue,  8 Oct 2024 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ll8gzpxS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE346AA1
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 00:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728347225; cv=fail; b=Pn1hpFWss7QytHFnyOXXPM/ZYJLWz1PZ0NP1z/JKuqljcocrmiWK9XZW7t02bGZQI+Kh2xhcGbbJUz8xU+gcEXag5vDHJ4Q6a9J3QyJeXXMCQh5JB0SGmorWjmlei92SeBdgHfccDPy1xikr5h1zmSjPbLRthE0h9bGXjeJ+PLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728347225; c=relaxed/simple;
	bh=1el+78Geh9HFq303rE1i9nh64K5Y/s803HYl8yQFzUg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EFbVIysLiz1RANJ8qDBoI8ytPxcfGRvN3CiBSqkCFoQcp9/MjLJds5BfyNY7aANVd2oNt58Rh2wmMtpfyJoJ3FAugAo7CTtxoExmpMwWhaHakZOUiSLntMUVmqoxyrIbxwOf3mV8BTI6lsXPB5DTgwq02MTX+AYalizPkiXM/qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ll8gzpxS; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728347224; x=1759883224;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1el+78Geh9HFq303rE1i9nh64K5Y/s803HYl8yQFzUg=;
  b=Ll8gzpxSutoqgN/NCqc1JTsrigYpnd+BEoxVBK7Ud+YBMhhFl+ZgCfv7
   31bPhIRF5wlqt7YNFvm7ao/pv14I78+0jejYM8LxXDfn45maKdS6ywRX5
   25gm1UXIhSjTC8ZeFYpGRe+t5m1L65JpMTi+LSdTF3IA9i9E0c6EnmKfe
   thY02qQxSIKjqewaNZqCsKytqz6YwRf5gRO8xha8MkCRTDOy1CjvfOrXB
   o2/13xZUyx+Zg8BZ7KVlUyiw3x9rBOWjIB1jcEb0YMiy2PzgEAlAk/d7H
   WSkC5ae5PaosQa4X/2lowdJuAchHsd2IDtGaV+VfO7hpTMJGnHiZmQgDg
   A==;
X-CSE-ConnectionGUID: HZIFKS94RNi0tZ20e36Ksw==
X-CSE-MsgGUID: zdywa52fRdC6LWkxqhVn9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27655700"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27655700"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 17:27:03 -0700
X-CSE-ConnectionGUID: F4YmivOPTKep6gOhc3U7kw==
X-CSE-MsgGUID: E1WKrtY+SeeJlSOeU2UeOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80439882"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 17:27:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 17:27:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 17:27:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 17:27:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZB56KxMDks6SY/WnJY3u18rfcTsJDSBq+0ibnHD04E+N553BZSXaOhiG3TC79JAwaUf0iozGuCu9RnSoq5rW64+zUQV7nuKqiWtmEzEWt9ikfPh/hBtSwOCaQ4pQj0Mm1Wg7IOLN2jIMPdOBPTwM4ldkMahoOaztLUj2HZGRuPBR+uOorGjqsD0xxjbySCtnR366zwnvEe+zYd59lVs3wt0chpETqmP6f7FV6Mz25oMt6Y5JK9O9+LJ0bz0bqFJXIRzjtcP+K10sdZFzWp0BexQ+oqcJilaN5/G+6Zpla6yzVY4429jU4f4EstC17mIxHYHrs/fWSLrIeMknxv/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2ZsflOhjw8WU31IDlWFRRcnWhmVKm87M0XOxWzE9bE=;
 b=YLpSf1RN6S6Umrp79RkrKTHVIFeJFN7z+wW+VxEc/xIaIf5MLGbJ4wKywX4h5LvLqWliiSBmVgThyVRm0Ctm8AQhez4CMF5RByGv9VTyF/CpkOqN+TlRNATyH92VHm+V+jPXEEjkySr7N3BdsotM2pUxvBrxH0CpeSUUo6Kwar1Aexf4GikZeoqJ/GcglVzjZRKuVqa552kQE0RyErOGHPpIZlvmUTVV94uHEC3IkwTQ9bYBR/AvOfuLXimYKpMo7TPC9ZyW2Q0j5qBklqPIeVkObukUITDFvEXUWAtbS6cg9z+769QEijfvg1Ke069uxKtfZHsYOG5xW4xy63Kqhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6258.namprd11.prod.outlook.com (2603:10b6:930:25::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 00:27:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 00:27:00 +0000
Date: Mon, 7 Oct 2024 17:26:57 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>
CC: <rafael.j.wysocki@intel.com>, <tj@kernel.org>,
	<linux-kernel@vger.kernel.org>, <regressions@lists.linux.dev>
Subject: Re: [PATCH v2] driver core: Fix userspace expectations of
 uevent_show() as a probe barrier
Message-ID: <67047c516045d_964fe294b1@dwillia2-xfh.jf.intel.com.notmuch>
References: <172790598832.1168608.4519484276671503678.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <172790598832.1168608.4519484276671503678.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4PR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:303:8c::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 879826b1-8bb7-42bb-6dc8-08dce72fecce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WrtIjROtJKMvf0tG+dr+gB/NIpX+PxW3wYg04iEV0Ur2T3Xrphfc1EK3lKMb?=
 =?us-ascii?Q?AsAz3pl0pWX4AFphhj3lJDC4vugfXlhp9Q+2wGShCCPs/ucvEh4hWUdQD3wA?=
 =?us-ascii?Q?65NExd8tfs1QkX39aRK3y9r4CPRUQfeCtsEYplhHO8FgssPdgtdy7sLFTC04?=
 =?us-ascii?Q?nYDTT/Lso5fD9pDH1Aj1gBYD6iFaR+c6sVENVfB088/SoJp3Szxm1Op8JOpi?=
 =?us-ascii?Q?hujBGn8V0sfqsscbw14vKQ955nx5oHNGBjA/ytPfwKkpatTYeF6llUXLm7Zg?=
 =?us-ascii?Q?2FsbZXfmx5lp8VvZf8LJCcummcb9Z0tM11fAtuiA5kHhnCWnRWtIvxtMadoY?=
 =?us-ascii?Q?2iYXeIwxJLj+ZFdnzAXCkfW+0hxaAE0tNa7eshQvaHzkT6GknfY3HYSBf38J?=
 =?us-ascii?Q?G+2cVhuPhq8uAfNNv2C0Hc3/+Z95nO7CVXOcaep1ri4UBune9ahwPbYCMnB5?=
 =?us-ascii?Q?6t56/7311yV1CZDdce5F0olOWUDQnFU/dyJhDDVQEXekfeCISuM/SRNYII0X?=
 =?us-ascii?Q?eNNrYlMM1I99ukgqpY53Q0koeEMcjpi04Lb5vBqzjM3b6Apf8hYXso5pc2Qw?=
 =?us-ascii?Q?2NRUYOnYhPI+KUE1Wq+i3ENOK0PogNmVualaeEWNSjl0/UOpS81vg9zbCQqd?=
 =?us-ascii?Q?cUh2yqrOhtyRzZpU69EwvYyyyNaoJz/k8nPKvfxzT9Da813GCJ4Ezbo0Rl18?=
 =?us-ascii?Q?V4IrLDRtIY4K5/89cuGnVGSw0Axa3h5Mh5k3ccy1/KriSjwyHrk+WBedMfWY?=
 =?us-ascii?Q?vXf/V9x25TjC6pJmnh+R7VW7/YOM61SLBfr3/kbqTi4Lmwl3R2BOsXlU0i2i?=
 =?us-ascii?Q?bJd+kq0cIHJfL06E6vTBgUNzhpu0oHGqb0wWhcbT0xHIdFjbktAX1RBGD0uR?=
 =?us-ascii?Q?HaRDJTyh/gzCq3vGt4Ifir2l34qWEo44qichNtKu/s9OA/JLgCqr5IP3SMsv?=
 =?us-ascii?Q?TQLAhvIlSFlEaYrZAy/eRtUvNw8Gs1lZxlQfdMCC7b0PlVxnbKszmIg6ksk3?=
 =?us-ascii?Q?uq6SHIooD3DorXnp7zJ+hItZVLOKGpb169FSKSqdv2oGm8P+4gicCe8vYAxi?=
 =?us-ascii?Q?ZoahvpVPEZgczysDQkUCG29u2IiGHtTbzAep4PPhfHqMw12xbK7lBZXFZ1FT?=
 =?us-ascii?Q?4GtJfEyY07+ASQOKZCUnh+60J1BoixGt58+H+8RTIbRwYnq1X8RY1G1IHrdW?=
 =?us-ascii?Q?iYtKdSqpbEtBplFQoLPXLho20BXaLGMZCWTqUbxTaHtgovMqv3GBORWjUDDr?=
 =?us-ascii?Q?4LXA1QDeVDUaZeiBUtqTndTlJD789qPFOaf7EoAm7w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MAMxq0W3CHHQ0ZbevD6SH25tfopGiaohQ5jx5GtkQmwGyZZFDxx94NAP2QAu?=
 =?us-ascii?Q?vAMo62tUX2kK/YD6k4LNwsj+MpsgNnyQhnVCEX8KmDA05hmg6qEC50rn9jjB?=
 =?us-ascii?Q?TvVpkwW6N+NPzRzE8Bs2jmGsPxGW+dPtXPs7mt8aVW1g58fSbmD5LM5EJxMh?=
 =?us-ascii?Q?dc5aiOBb6ezllLSXtsqJmiJCUiLWSJFPH8wKrsGWxlzuUH8alGSuPJ6YRrKG?=
 =?us-ascii?Q?gkqlqDS2RgrZUjZWRAPeWCdMr6Ybv0AmbjkaUznwnhSgSKbjJ2FnlB5x4e26?=
 =?us-ascii?Q?aTvZZ47jIVxZ3+sc2goBVUBu+akewrD4yLjKeJ905hr6EKoPSVeybu8uhgiX?=
 =?us-ascii?Q?lpNn86qxfOJ7TBKF7X5WLJA6Nf6FN8Dsf9jurxGnvUAUM9AAjLLQakJdMCiD?=
 =?us-ascii?Q?PGMBn47L6qA3J9CC0Mep/NUlBv1vwQ7NxZJN7uUNX9TvwHFmS/DigB4rIV49?=
 =?us-ascii?Q?F0c2HBvD+fGZ+C0PdBUf5YPS2NWfOJF9mjdjwrOr27rMqEDB9Yqq91Psw0vF?=
 =?us-ascii?Q?uQ21n8PaWrrE0FWyCIuu5ayiNE6UqvSV05RMFRUcftR3GdPAWwJTA1BaxHBW?=
 =?us-ascii?Q?/gtGrCe+A8VG8YXMXU4xeNOSVxexRNu7X6BIzrkJTSzab+GaIy18WO4fQqXt?=
 =?us-ascii?Q?UIocUzOMVem0o+XECK8JOVBluwTNn+4+nJ5oTathL5r5XS+Iachr29MOuy3a?=
 =?us-ascii?Q?8u6T6u6R4k+UYUWaYt5Cp1OdkPMrMUlKnXLsX8hyMX55PPbhpmbXuBgccIqy?=
 =?us-ascii?Q?hDJDu1TFBk9dvwtakM4JR4gzZ6Ni2sZwAwMEuFbUMtHqy7d35KtsJExzk8Nl?=
 =?us-ascii?Q?b0soIjl91dIZ2sddGj4dHxCeEQFB8zXX+MlanZuX8mv9X2PWb8IAjETHBsRQ?=
 =?us-ascii?Q?MQnb/S3+qksVFVQpO5iybyiTmEdrx2cIo1VrUFkMSo+BzGGBWwQk6PNNE/3a?=
 =?us-ascii?Q?tOwUtS8yeR7hUbvhHUi89xV8i7+zn+2fHpbseXBoHhQzZLGSeYz0JrKCvYpy?=
 =?us-ascii?Q?UuotLtZkYfJCuNFX0rbPw3r/DfQx1JHBFGaAebdNU0K7RyT7hEmQpxiObiuo?=
 =?us-ascii?Q?LucR+02PEOMB0ia6m0bGOGAkGlqD4OZhK3i1GmtO0FM2kAaR0RtWgp1VMzFp?=
 =?us-ascii?Q?ClsTpVNSDUqmC9BjKsk7Juk0J3H/bg071XChRPvogmCp1ZYfHMoU65q9Iafg?=
 =?us-ascii?Q?EZTQQNfMh4HcbxkdL+liDr+IE2Nran5bY40e2nw/rHtUoIz/sy5/p9DmwF69?=
 =?us-ascii?Q?tMnmgEUJaakXjeD1ts7bsfG70/ZdJYMLANS9SrpKG2XLqXIg7aus+jexByy3?=
 =?us-ascii?Q?r1Ge0dDS1itK6l747Qs60MRpzzoOykOIvPY6Z4NQbhyeBw8r2RjuBoOI2kQc?=
 =?us-ascii?Q?gLszZ4DoYvhqn7M8QHAfE2LSVVaK9D/i/8DKaRE7AsMuNBWU96Hr7TWAeuv3?=
 =?us-ascii?Q?6pZSnms05U+O5RgD44esTwPuN6ZTrx484ImQ432iT8qfmEfX6InuVubq93AA?=
 =?us-ascii?Q?HETsUCETyNvnadaksch5xSqTSKkKSrWIHbiMQQ6dHwzm8/OAgMxvw3orvVSC?=
 =?us-ascii?Q?nAk/E+pXcMr473fxEOmYRohrBgFmMm7sdNKxA4JwUpKsOtdEN+x0Q7WZVooj?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 879826b1-8bb7-42bb-6dc8-08dce72fecce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 00:27:00.3292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqcA+LdLdmCIkWmJthuxi14tmj/pTbudrUZt0mtQ4cvn5hXdEu2nrIcSqp+mQYp/ajut+UoW2mQouJ2ZIQNJd8A2ICsqyQYMTtH6oBqs2+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6258
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Changes since v1 [1]:
> - Move the new "locked" infrastructure to private header files to make
>   it clear it is not approved for general usage (Greg)

Greg, per the 0day report and further testing I am missing something
subtle in using kernfs open files to pin device objects. So hold off on
this for now until I can get that root caused. If someone else can spot
what I missed feel free to chime in, but otherwise I will circle back.

If I don't get back to this before -rc6 I think the theoretical deadlock
that would be re-introduced by a revert of 15fffc6a5624 would be
preferable to this reported regression. I am not aware of any reports of
that deadlock triggering in practice.

