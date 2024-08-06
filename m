Return-Path: <linux-kernel+bounces-275755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0A694896C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CB54B23A24
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA32015E5BA;
	Tue,  6 Aug 2024 06:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7TsmX3u"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C1D7710F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 06:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722926041; cv=fail; b=H821MLL9vc1RwsuZAd7jMPFUYdGkS4nu7emC/5hCbOxREZTlEaRb78074PmU5cGZ+3O3Go9GBEEpMM0DHtUAgf/WsNUhtXfvtjlvfQ+CifiuHefuYBAbcMuw5LhoJGwIPjojQexleyQ3R1iZSeChvMS0+Dz6GXj0Dr8dmPlXO2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722926041; c=relaxed/simple;
	bh=YJ5HpsiZcUkgTMo9rdzBNccMwIzXw8Kn4V5XsQK40zg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iRUhr3drOllRihM8ouOA2U3sY2d5yQ4PbDGdLM41XNoDESYZBpoCOh01LnnsqZ1q02XJzGnt+rZsrl4XyETGguotctkIMjzYXLesPHTXP67Ti/ww1JI22SgvMReV2qI+N1cTsRYjzr8CfrufMtZ+xVMlY5eS3hjrOTfSjPRNqeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7TsmX3u; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722926039; x=1754462039;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YJ5HpsiZcUkgTMo9rdzBNccMwIzXw8Kn4V5XsQK40zg=;
  b=g7TsmX3uqHbSGgUoAXjpPHv+y7OcIU7AjxNAa3abTrY3b4fBT+DVsIJX
   srLGufGdySr8svevbUvu3x65eSVUeBa6qaldo8Jt4aBlUvxZhB93ERtgJ
   FDTuSR4G+5ItWdcpchMCP6ZtWe2YRe/QfOvD9dGwRwEaib8AbUWimS5HM
   LgnMxIETv8Jle7R48CBKu1KjDKwJHZxDIkikrKja/P5wvK7fisyh682JU
   6ShOT6o39oKAge3nqD8YQTbAOAvPfOL5GxqpQTn8Lc4xbQaNE6a9YnZU2
   oBP+ba0gImPclHBO4dExteKcz25JVcw2jYieG31fpwyZCWPi9d/mT/Sq6
   g==;
X-CSE-ConnectionGUID: hAZMBABrTDu9flU4oARuAA==
X-CSE-MsgGUID: Vpxm3/EjQDaxZ3RkGVQcig==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="24687108"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="24687108"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 23:33:58 -0700
X-CSE-ConnectionGUID: 0ESNAVOQR/KyY0fmgb+P9Q==
X-CSE-MsgGUID: mxkqee6FSauFZYapuvPX/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="57103193"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 23:33:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 23:33:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 23:33:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 23:33:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/QQibQOSwjU5sFGLPgBqSwj6daKsiZH8P6lDyS76aBTMVzdm1zG/AydO4dJj6+wWVya8MrWDRBVgqq4F8aSyeQtm/uFv1UJrrTvnXJzBVJCByBYBe1QHZsXhu+S72lD1eW+wUaFBSc1Q0gcrNkPwcxG1kYkeVBqu0J3r78/89MtPbcEXzX5xkT0b/ExSQtmBU754eqx8x3P+CI53plkjeAfRTO/hlGg3vvxOMpq18TTR/DyFA5ML13gk9GQ7WTIIKVqgHpSd6YU2IE35sVdzuovbo3kV/t7Ap01ACcY4kCH6NS+EyZgz5Ywx0qubouB2xQmqnWOs9aBxbC7yvZ0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oo62nTqg8cvBLQI3nsynGSbEoZD+ZFf41GFqWKuLovI=;
 b=qAe9xRbibq648utFA3L0iNMXdHph7GU6l4tr0pF6cSCZqX/PV9b90S/fivdJGiJrNOchVNkVVYFAbtIedt2V7L3iIEcZDSMewZZbLtBCFjMAfhuha6dkw8sGktGW01LxLy1/0bUBzKPje2WDMiDktX30D6/lUk0IwdnbIZIoNPRL8llEGpmo1V1hNGBIB4W+iLWYG4kVrNUPj7GQevJAaNz69zUScBtDW4xBLxUF8rnC8YC36CIiErmdLOHuNC8rdQLo/khDum3nHuqlWdBo0FGW6BWgvqQOW3eN8O3nUjBTbng2DF0CxnjBfAijLkgcezNsa2stwMVEQG3YdW7G2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by SA2PR11MB5097.namprd11.prod.outlook.com (2603:10b6:806:11a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Tue, 6 Aug
 2024 06:33:52 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 06:33:52 +0000
Date: Tue, 6 Aug 2024 14:33:43 +0800
From: Philip Li <philip.li@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: kernel test robot <lkp@intel.com>, Kees Cook <kees@kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: include/linux/slab.h:663:78: error: subscripted value is neither
 array nor pointer nor vector
Message-ID: <ZrHDx5A68ZLo8vet@rli9-mobl>
References: <202408032258.ShUXX4qU-lkp@intel.com>
 <d27f3355-66d3-4fad-b3e0-45b61f560c47@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d27f3355-66d3-4fad-b3e0-45b61f560c47@suse.cz>
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|SA2PR11MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd5f4e6-7cd1-4e6a-0837-08dcb5e1bcd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VbTgjzcEqIALYlNEk0DRtuvPuur5qh4QziHxF/8ndNxkm8T/hkt6qo/7KP00?=
 =?us-ascii?Q?vd+eCZ2ZnR5oSYxjHxZ+NotawH19gFbciURpjvFFebWp5/515tOLHd6Vr3hv?=
 =?us-ascii?Q?6B/dRzIv1GeXOcb96+G0lHv8AID+xdU0kjKbCRJiSIIXKBMnxHA5jnPZ5nOu?=
 =?us-ascii?Q?o9zvg9qxjqRaTcj+b6rcN7g0rA5bR1fcWWGiiK0eQ5hGE+ti4UphT9kdVfK8?=
 =?us-ascii?Q?skQTJD2MkjbLJxlU0yyw24HS/JM3c6I5JGDRMxPPdXdliL/ljZzBJxpmSGSe?=
 =?us-ascii?Q?zebFo6kkfJw4BZySX0/5pKcHrA+nv2+iIEi6bmXupS6VAp16nIC1y5MX4KH9?=
 =?us-ascii?Q?ASukUC1BsKuqPp0i44Yp+mmCDSXqpD+u1Nuq7mGDHCEks8IPGJCKe9htKrlv?=
 =?us-ascii?Q?B0MdK+FmgovYtKtRxFSOKBjkhyiwIHYVVZ/SHESAF30zefVB0NV/ER+vCFOm?=
 =?us-ascii?Q?RurJMoyvyANckxCM27hVJHxWadQk9HoJ/sPkIbSzEriSZzHvoHp4JR9OSXyT?=
 =?us-ascii?Q?RBhyzGnDcG3zYJnBB8h2An7Z+Zm5TD8seBBofaubn82HFxmpf1Je4Dub/AiS?=
 =?us-ascii?Q?K5QYPSbbhDsGi0zdy8tMeOOZYvC6ltiHKZW/XPBSaCpkfDT/w7m5nlXkBzz0?=
 =?us-ascii?Q?78cZ0H7idAISSk7wro0wUreinRfH4h95eagokjWXBKYCbH7vEwCva3ErYeZr?=
 =?us-ascii?Q?A1PMbY1DI0jocK+M7PkCFLRbfq3L7EUw7FvKGhXdLFd3XgKxzQPiYyDCN/mS?=
 =?us-ascii?Q?No4NrmS86FNN6EnWUdyUqtLdGDfOl/uZYzHwNqcNNNcPIRuwgRBQ7JT0F1SI?=
 =?us-ascii?Q?UxMJo5uL09UHhMFqRbHwuGH0OGP5rcI3ITJOD60VlK2ZSQElHZmj+tLf5J5J?=
 =?us-ascii?Q?or46XN9HBDWzFNNNM554AbhpQ6rV5vslgnC9f1cjVwMstQspS0JY/UApUAp0?=
 =?us-ascii?Q?3a0UY9lY+Ss4yY2Xm4x26UDAZo/746qUzhT7n1vWabx3XZyUnAOe800R/gno?=
 =?us-ascii?Q?ie3+mR04cRmdV+SNCSSf7L64qIBUMvvsDI4eYAENczVQ+d5kOpIB6qWVD6Cj?=
 =?us-ascii?Q?XcrEe91OH/k2+uJPDSBeiqZjqK7yP0O5YWrPT3rwEYyxvgUlTZ4j6TanZIIT?=
 =?us-ascii?Q?P0Q0bIu74+8pdIiTNihaxUOGuvj5j3xfSc7oGYgrCh3uNzsDVd6xT71uO/rC?=
 =?us-ascii?Q?WpF/k9mX+RNzuAB4g/Sctq4oOyE/Lcs3XarPkOUb0dZ3PJHzmLTZPN3rqXh5?=
 =?us-ascii?Q?9o/KxnsjEvIjOqFvU2T3bLaLPZyaRjfQlVKyu/9qszwuoX0rFXWt3aeitPtC?=
 =?us-ascii?Q?47BfVOrJd/0KxkYzD3hLCgsu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4XFeb/TH9W58oXLyhTEnriY1QgNpKlSoIqcIp1Mo5siqHOUkQr5nZHXHIQjx?=
 =?us-ascii?Q?lYB+5RiiSh7MljJYcHSBIHx1b7GT2+kjosB/oJ9GoJNqKuagmeduDjofzeQ/?=
 =?us-ascii?Q?ju3q7G3cH8ynFIS3rlWP+i45Fa6tWAY4EpscmbjwSMgQzYjwY3J/OWZxfgo0?=
 =?us-ascii?Q?v6qSfHWwNxt/l7WV/iBPnGxb3SZOzeDmNl8/p/QvDobsvqf9ubTbLrjT4CTP?=
 =?us-ascii?Q?X+gNHveOcsuDJvgK9uKjl7e6pfAblx4OuuVoYAdSPGR/XRsQ1QevkMhDMNvR?=
 =?us-ascii?Q?NWca5P+lLwJuuUykQtwkNrJS72StJ2rWS9rrlovvtqd6KGtOCH7j/XQa/ZfO?=
 =?us-ascii?Q?PWnnahpFp9JA9pb+CQt/pkkfJ3DcObFug4xM9FGrUmgttw6yAdpufGf5lMcU?=
 =?us-ascii?Q?gwC0Ima12KZsWGTFbOfvTV5lclJvp+J/flU9ZVU4RyPW3iRf5AhmcoaUHvqy?=
 =?us-ascii?Q?iPRqBH5LWXvUdWQ4rPSD3T+Fvs54JOLlpRk2Dg8tEGjM2GMM41ArgpDA8JLx?=
 =?us-ascii?Q?C4WH7HbO6vCMsxZN9AAIsr1Dex2CqJ9kNJJgOCFCoetTiAPEkizqFSyBFXgf?=
 =?us-ascii?Q?osHQVMV/ibir8granw9JCc9Q6nKKjeAr0uDd8Djc4VnG98fLZJ0rSIT6oysH?=
 =?us-ascii?Q?YF1d0Gz9qFgJ9SdMANGMOLGi0E0Xg6q+I8QxObao9iiMZAU/IZqN05nJvdUr?=
 =?us-ascii?Q?a6jM32fmiTyaMLhM9f3dQgbtXxP4TB1T+XyaEL0KnZAdaQ+3r4PO2GXmdtMb?=
 =?us-ascii?Q?vrlLHs57y8qLJ5TrzSfcdJyBWj/x6Qxl+Y8QxnEWWAbFBMw7rk9d+v0R1kMk?=
 =?us-ascii?Q?qyNXXs/HjvMWsCnJlW0Da6H4XhF7UZaLrEmer4wLHFAFE2PtZC3M6EPGe5Lj?=
 =?us-ascii?Q?Z0X3mVrD65IWOUYp+VSOaloj80dGBfe3ttfkKoPWDG756bZhcALZ1odzO7Js?=
 =?us-ascii?Q?vx6VHrmD0GdwkQMpWo42NjwUIvzOkkyIXNd2VPsTeEiCem/2xEkKl4k5OpDe?=
 =?us-ascii?Q?z1hdq19bgx2tybqaQ9sALe7rj4XlKq4HcnlyTfNdih3Xgf8dwtxjCFmY9QMR?=
 =?us-ascii?Q?KvfqHw68lpUEueUO3Krac0JUtrWA35PqZmmpUcxQ1ZmKKzt3AmK5/6hDiXLU?=
 =?us-ascii?Q?PtXZSulFsu4xI36AdxRIc8z5uezCs0l/oU2epQtnO0FLXUrEygU7m4XLLY88?=
 =?us-ascii?Q?5g+QED7T7uY9IcKAj16ghOJgvbgNZ0VavTUvHGWslF9yphjsrQe/8qrmb4ZN?=
 =?us-ascii?Q?mZUfOEKg0uDT8pGt5gvPmMoAAZ4vlUyQDTeF82gIF1GcAJysdkqhxghAcege?=
 =?us-ascii?Q?vCILKZ+eoWu4LQppEIBmNWdVyHPxGXB3k3RHeeedr1iIYMln4lLwU49UJxiS?=
 =?us-ascii?Q?IRrQSwjF1fPV3Gpv9vlZqqFX2GFmQbUcpgvl4olbH3ZKneJlw+D0bzzRtm1A?=
 =?us-ascii?Q?x+rct2BxK7nKqTGNDzKkPJNJFOnyp7v1FqDkqjvS6+N8EI5CCqtLeqOX+6ov?=
 =?us-ascii?Q?a611TTzn/AbULZLHqSichooowVSAkVwhU+BS1mGwRwDYqMuuiUo5GQI298S4?=
 =?us-ascii?Q?DACK48d+P4abSR03vOqph6Ol8EjdfrZO0xbtw5Vi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd5f4e6-7cd1-4e6a-0837-08dcb5e1bcd8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 06:33:52.2018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlhYV8maz6pc2crVJ04FeYiGZgv4Af7p0ziJQWbgICrvUKvTesikhM3gNrt8yKzxSUVrUi8bFg98qmcPfYNY/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5097
X-OriginatorOrg: intel.com

On Mon, Aug 05, 2024 at 11:10:16AM +0200, Vlastimil Babka wrote:
> On 8/3/24 17:04, kernel test robot wrote:
> > Hi Kees,
> > 
> > FYI, the error/warning still remains.
> 
> But it's also still misattributed to this commit?

Sorry, we will avoid reporting against this commit in future.

> 
> https://lore.kernel.org/all/CAMuHMdWMSpv1BbvCqf0Abfxf0sGp+5it-m1GtFR2nGuQ5-ZCAg@mail.gmail.com/
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   17712b7ea0756799635ba159cc773082230ed028
> > commit: 72e0fe2241ce113cbba339ca8c2450b167774530 mm/slab: Introduce kmem_buckets typedef
> > date:   4 weeks ago
> > config: m68k-alldefconfig (https://download.01.org/0day-ci/archive/20240803/202408032258.ShUXX4qU-lkp@intel.com/config)
> > compiler: m68k-linux-gcc (GCC) 14.1.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240803/202408032258.ShUXX4qU-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202408032258.ShUXX4qU-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' undeclared here (not in a function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
> >       10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
> >          |                         ^~~~~~~~~~~~~~~~~
> >    arch/m68k/include/asm/page.h:11:40: note: in expansion of macro 'PAGE_SHIFT'
> >       11 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
> >          |                                        ^~~~~~~~~~
> >    arch/m68k/include/asm/thread_info.h:23:26: note: in expansion of macro 'PAGE_SIZE'
> >       23 | #define THREAD_SIZE     (PAGE_SIZE << THREAD_SIZE_ORDER)
> >          |                          ^~~~~~~~~
> >    include/linux/sched.h:1851:29: note: in expansion of macro 'THREAD_SIZE'
> >     1851 |         unsigned long stack[THREAD_SIZE/sizeof(long)];
> >          |                             ^~~~~~~~~~~
> >    arch/m68k/include/asm/page.h:10:25: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
> >       10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
> >          |                         ^~~~~~~~~~~~~~~~~
> >    arch/m68k/include/asm/page.h:11:40: note: in expansion of macro 'PAGE_SHIFT'
> >       11 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
> >          |                                        ^~~~~~~~~~
> >    include/linux/mm_types.h:531:6: note: in expansion of macro 'PAGE_SIZE'
> >      531 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >          |      ^~~~~~~~~
> >    In file included from include/vdso/const.h:5,
> >                     from include/linux/const.h:4,
> >                     from include/linux/bits.h:5,
> >                     from include/linux/ratelimit_types.h:5,
> >                     from include/linux/printk.h:9,
> >                     from include/asm-generic/bug.h:22,
> >                     from arch/m68k/include/asm/bug.h:32,
> >                     from include/linux/bug.h:5,
> >                     from include/linux/thread_info.h:13:
> >    arch/m68k/include/asm/page.h:10:25: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
> >       10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
> >          |                         ^~~~~~~~~~~~~~~~~
> >    include/uapi/linux/const.h:32:50: note: in definition of macro '__ALIGN_KERNEL_MASK'
> >       32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
> >          |                                                  ^~~~
> >    include/linux/mm_types.h:508:41: note: in expansion of macro '__ALIGN_MASK'
> >      508 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
> >          |                                         ^~~~~~~~~~~~
> >    arch/m68k/include/asm/page.h:11:40: note: in expansion of macro 'PAGE_SHIFT'
> >       11 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
> >          |                                        ^~~~~~~~~~
> >    arch/m68k/include/asm/page.h:12:28: note: in expansion of macro 'PAGE_SIZE'
> >       12 | #define PAGE_MASK       (~(PAGE_SIZE-1))
> >          |                            ^~~~~~~~~
> >    include/linux/mm_types.h:508:62: note: in expansion of macro 'PAGE_MASK'
> >      508 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
> >          |                                                              ^~~~~~~~~
> >    include/linux/mm_types.h:531:18: note: in expansion of macro 'PAGE_FRAG_CACHE_MAX_SIZE'
> >      531 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >          |                  ^~~~~~~~~~~~~~~~~~~~~~~~
> >    arch/m68k/include/asm/page.h:10:25: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
> >       10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
> >          |                         ^~~~~~~~~~~~~~~~~
> >    include/uapi/linux/const.h:32:61: note: in definition of macro '__ALIGN_KERNEL_MASK'
> >       32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
> >          |                                                             ^~~~
> >    include/linux/mm_types.h:508:41: note: in expansion of macro '__ALIGN_MASK'
> >      508 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
> >          |                                         ^~~~~~~~~~~~
> >    arch/m68k/include/asm/page.h:11:40: note: in expansion of macro 'PAGE_SHIFT'
> >       11 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
> >          |                                        ^~~~~~~~~~
> >    arch/m68k/include/asm/page.h:12:28: note: in expansion of macro 'PAGE_SIZE'
> >       12 | #define PAGE_MASK       (~(PAGE_SIZE-1))
> >          |                            ^~~~~~~~~
> >    include/linux/mm_types.h:508:62: note: in expansion of macro 'PAGE_MASK'
> >      508 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
> >          |                                                              ^~~~~~~~~
> >    include/linux/mm_types.h:531:18: note: in expansion of macro 'PAGE_FRAG_CACHE_MAX_SIZE'
> >      531 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >          |                  ^~~~~~~~~~~~~~~~~~~~~~~~
> >    In file included from include/linux/init.h:5,
> >                     from include/linux/printk.h:6:
> >    arch/m68k/include/asm/page.h:10:25: error: expression in static assertion is not an integer
> >       10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
> >          |                         ^~~~~~~~~~~~~~~~~
> >    include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
> >       78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
> >          |                                                        ^~~~
> >    include/linux/slab.h:527:1: note: in expansion of macro 'static_assert'
> >      527 | static_assert(PAGE_SHIFT <= 20);
> >          | ^~~~~~~~~~~~~
> >    include/linux/slab.h:527:15: note: in expansion of macro 'PAGE_SHIFT'
> >      527 | static_assert(PAGE_SHIFT <= 20);
> >          |               ^~~~~~~~~~
> >    In file included from include/linux/irq.h:21,
> >                     from include/asm-generic/hardirq.h:17,
> >                     from ./arch/m68k/include/generated/asm/hardirq.h:1,
> >                     from include/linux/hardirq.h:11,
> >                     from include/linux/interrupt.h:11,
> >                     from include/linux/kernel_stat.h:9,
> >                     from arch/m68k/kernel/asm-offsets.c:16:
> >    include/linux/slab.h:593:33: warning: 'assume_aligned' attribute argument <erroneous-expression> is not an integer constant [-Wattributes]
> >      593 |                                 __assume_page_alignment __alloc_size(1);
> >          |                                 ^~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/slab.h:596:33: warning: 'assume_aligned' attribute argument <erroneous-expression> is not an integer constant [-Wattributes]
> >      596 |                                 __assume_page_alignment __alloc_size(1);
> >          |                                 ^~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/slab.h: In function 'kmalloc_noprof':
> >>> include/linux/slab.h:663:78: error: subscripted value is neither array nor pointer nor vector
> >      663 |                                 kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
> >          |                                                                              ^
> >    include/linux/slab.h:656:30: warning: variable 'index' set but not used [-Wunused-but-set-variable]
> >      656 |                 unsigned int index;
> >          |                              ^~~~~
> >    include/linux/slab.h: In function 'kmalloc_node_noprof':
> >    include/linux/slab.h:680:78: error: subscripted value is neither array nor pointer nor vector
> >      680 |                                 kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
> >          |                                                                              ^
> >    include/linux/slab.h:673:30: warning: variable 'index' set but not used [-Wunused-but-set-variable]
> >      673 |                 unsigned int index;
> >          |                              ^~~~~
> >    make[3]: *** [scripts/Makefile.build:117: arch/m68k/kernel/asm-offsets.s] Error 1
> >    make[3]: Target 'prepare' not remade because of errors.
> >    make[2]: *** [Makefile:1208: prepare0] Error 2
> >    make[2]: Target 'prepare' not remade because of errors.
> >    make[1]: *** [Makefile:240: __sub-make] Error 2
> >    make[1]: Target 'prepare' not remade because of errors.
> >    make: *** [Makefile:240: __sub-make] Error 2
> >    make: Target 'prepare' not remade because of errors.
> > 
> > 
> > vim +663 include/linux/slab.h
> > 
> > f1b6eb6e6be149 Christoph Lameter     2013-09-04  572  
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  573  /*
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  574   * The following functions are not to be used directly and are intended only
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  575   * for internal use from kmalloc() and kmalloc_node()
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  576   * with the exception of kunit tests
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  577   */
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  578  
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  579  void *__kmalloc_noprof(size_t size, gfp_t flags)
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  580  				__assume_kmalloc_alignment __alloc_size(1);
> > f1b6eb6e6be149 Christoph Lameter     2013-09-04  581  
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  582  void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node)
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  583  				__assume_kmalloc_alignment __alloc_size(1);
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  584  
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  585  void *__kmalloc_cache_noprof(struct kmem_cache *s, gfp_t flags, size_t size)
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  586  				__assume_kmalloc_alignment __alloc_size(3);
> > 7bd230a26648ac Suren Baghdasaryan    2024-03-21  587  
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  588  void *__kmalloc_cache_node_noprof(struct kmem_cache *s, gfp_t gfpflags,
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  589  				  int node, size_t size)
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  590  				__assume_kmalloc_alignment __alloc_size(4);
> > 7bd230a26648ac Suren Baghdasaryan    2024-03-21  591  
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  592  void *__kmalloc_large_noprof(size_t size, gfp_t flags)
> > a0a44d9175b349 Vlastimil Babka       2024-05-27 @593  				__assume_page_alignment __alloc_size(1);
> > a0c3b940023eef Hyeonggon Yoo         2022-08-17  594  
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  595  void *__kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  596  				__assume_page_alignment __alloc_size(1);
> > a0c3b940023eef Hyeonggon Yoo         2022-08-17  597  
> > f1b6eb6e6be149 Christoph Lameter     2013-09-04  598  /**
> > 838de63b101147 Vlastimil Babka       2022-11-10  599   * kmalloc - allocate kernel memory
> > f1b6eb6e6be149 Christoph Lameter     2013-09-04  600   * @size: how many bytes of memory are required.
> > 838de63b101147 Vlastimil Babka       2022-11-10  601   * @flags: describe the allocation context
> > f1b6eb6e6be149 Christoph Lameter     2013-09-04  602   *
> > f1b6eb6e6be149 Christoph Lameter     2013-09-04  603   * kmalloc is the normal method of allocating memory
> > f1b6eb6e6be149 Christoph Lameter     2013-09-04  604   * for objects smaller than page size in the kernel.
> > 7e3528c3660a2e Randy Dunlap          2013-11-22  605   *
> > 59bb47985c1db2 Vlastimil Babka       2019-10-06  606   * The allocated object address is aligned to at least ARCH_KMALLOC_MINALIGN
> > 59bb47985c1db2 Vlastimil Babka       2019-10-06  607   * bytes. For @size of power of two bytes, the alignment is also guaranteed
> > ad59baa3169591 Vlastimil Babka       2024-07-03  608   * to be at least to the size. For other sizes, the alignment is guaranteed to
> > ad59baa3169591 Vlastimil Babka       2024-07-03  609   * be at least the largest power-of-two divisor of @size.
> > 59bb47985c1db2 Vlastimil Babka       2019-10-06  610   *
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  611   * The @flags argument may be one of the GFP flags defined at
> > e9d198f2be851f Thorsten Scherer      2023-03-12  612   * include/linux/gfp_types.h and described at
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  613   * :ref:`Documentation/core-api/mm-api.rst <mm-api-gfp-flags>`
> > 7e3528c3660a2e Randy Dunlap          2013-11-22  614   *
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  615   * The recommended usage of the @flags is described at
> > 2370ae4b1d5aa7 Mauro Carvalho Chehab 2020-04-10  616   * :ref:`Documentation/core-api/memory-allocation.rst <memory_allocation>`
> > 7e3528c3660a2e Randy Dunlap          2013-11-22  617   *
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  618   * Below is a brief outline of the most useful GFP flags
> > 7e3528c3660a2e Randy Dunlap          2013-11-22  619   *
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  620   * %GFP_KERNEL
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  621   *	Allocate normal kernel ram. May sleep.
> > 7e3528c3660a2e Randy Dunlap          2013-11-22  622   *
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  623   * %GFP_NOWAIT
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  624   *	Allocation will not sleep.
> > 7e3528c3660a2e Randy Dunlap          2013-11-22  625   *
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  626   * %GFP_ATOMIC
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  627   *	Allocation will not sleep.  May use emergency pools.
> > 7e3528c3660a2e Randy Dunlap          2013-11-22  628   *
> > 7e3528c3660a2e Randy Dunlap          2013-11-22  629   * Also it is possible to set different flags by OR'ing
> > 7e3528c3660a2e Randy Dunlap          2013-11-22  630   * in one or more of the following additional @flags:
> > 7e3528c3660a2e Randy Dunlap          2013-11-22  631   *
> > 838de63b101147 Vlastimil Babka       2022-11-10  632   * %__GFP_ZERO
> > 838de63b101147 Vlastimil Babka       2022-11-10  633   *	Zero the allocated memory before returning. Also see kzalloc().
> > 838de63b101147 Vlastimil Babka       2022-11-10  634   *
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  635   * %__GFP_HIGH
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  636   *	This allocation has high priority and may use emergency pools.
> > 7e3528c3660a2e Randy Dunlap          2013-11-22  637   *
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  638   * %__GFP_NOFAIL
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  639   *	Indicate that this allocation is in no way allowed to fail
> > 7e3528c3660a2e Randy Dunlap          2013-11-22  640   *	(think twice before using).
> > 7e3528c3660a2e Randy Dunlap          2013-11-22  641   *
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  642   * %__GFP_NORETRY
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  643   *	If memory is not immediately available,
> > 7e3528c3660a2e Randy Dunlap          2013-11-22  644   *	then give up at once.
> > 7e3528c3660a2e Randy Dunlap          2013-11-22  645   *
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  646   * %__GFP_NOWARN
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  647   *	If allocation fails, don't issue any warnings.
> > 7e3528c3660a2e Randy Dunlap          2013-11-22  648   *
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  649   * %__GFP_RETRY_MAYFAIL
> > 01598ba6b1a863 Mike Rapoport         2018-11-11  650   *	Try really hard to succeed the allocation but fail
> > dcda9b04713c3f Michal Hocko          2017-07-12  651   *	eventually.
> > f1b6eb6e6be149 Christoph Lameter     2013-09-04  652   */
> > 7bd230a26648ac Suren Baghdasaryan    2024-03-21  653  static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t flags)
> > f1b6eb6e6be149 Christoph Lameter     2013-09-04  654  {
> > 6fa57d78aa7f21 Kees Cook             2022-11-17  655  	if (__builtin_constant_p(size) && size) {
> > cc252eae85e095 Vlastimil Babka       2018-10-26  656  		unsigned int index;
> > 3bf019334fbbb5 Kees Cook             2022-11-17  657  
> > f1b6eb6e6be149 Christoph Lameter     2013-09-04  658  		if (size > KMALLOC_MAX_CACHE_SIZE)
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  659  			return __kmalloc_large_noprof(size, flags);
> > f1b6eb6e6be149 Christoph Lameter     2013-09-04  660  
> > cc252eae85e095 Vlastimil Babka       2018-10-26  661  		index = kmalloc_index(size);
> > a0a44d9175b349 Vlastimil Babka       2024-05-27  662  		return __kmalloc_cache_noprof(
> > 3c615294058429 GONG, Ruiqi           2023-07-14 @663  				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
> > f1b6eb6e6be149 Christoph Lameter     2013-09-04  664  				flags, size);
> > f1b6eb6e6be149 Christoph Lameter     2013-09-04  665  	}
> > 7bd230a26648ac Suren Baghdasaryan    2024-03-21  666  	return __kmalloc_noprof(size, flags);
> > f1b6eb6e6be149 Christoph Lameter     2013-09-04  667  }
> > 7bd230a26648ac Suren Baghdasaryan    2024-03-21  668  #define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
> > ce6a50263d4dde Christoph Lameter     2013-01-10  669  
> > 
> > :::::: The code at line 663 was first introduced by commit
> > :::::: 3c6152940584290668b35fa0800026f6a1ae05fe Randomized slab caches for kmalloc()
> > 
> > :::::: TO: GONG, Ruiqi <gongruiqi@huaweicloud.com>
> > :::::: CC: Vlastimil Babka <vbabka@suse.cz>
> > 
> 
> 

