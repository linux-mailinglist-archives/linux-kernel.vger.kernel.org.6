Return-Path: <linux-kernel+bounces-209158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A5E902E04
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392B41C212F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3DAA934;
	Tue, 11 Jun 2024 01:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XdIFwWBl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB148F5A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718070124; cv=fail; b=QNWZPXS71a9pFC9aTQw2kpO0/9qiP9+BJ6vssZ7MCXucaNoVBjMhujAWbIZNhZDUbaJEnIzkNalADG4g1qEv5ItBBIy64WhI2G51DYVV7Eh9y+LwfhTcy5STbfv9GNhdZ2xiN5bDN58B9EZc31XGqJ3V2Pb8sJc5lXMyLFPFEAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718070124; c=relaxed/simple;
	bh=4TzyDCOB6Ql+0YDD3XUwFlP93K7QLlsJueRFX4l8AhQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uHzKTZAoraQS1dLdfNJ6vfJ/ozhgXF8cVCN+5G2MaQtkEAg/Bkr5wbBdfEwIS1Zai1MjDqDj1oCqAkI2TPCz/RP4+UilSxkieuxDMHuXsDk60NQl2juquh4bXadIsh+yZeNiDjyDhn26pdlCeC9tYkao92R2fiFSHljMb2oSxJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XdIFwWBl; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718070122; x=1749606122;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=4TzyDCOB6Ql+0YDD3XUwFlP93K7QLlsJueRFX4l8AhQ=;
  b=XdIFwWBlrcXTW6FrHf2ptNg1ZRVqTH44Oo+yMzrObvCUbLIGa1AXPolS
   kexXA1b6IUidclqbnAOrlsYenVT41vzV+3RXsqnrHl9z4im+HdLK0GFiE
   3uRLI3J9xqzW9JjYSHaZxuHuhBn4FqZi86BYzBU+Ebg9LJlbUQPyMmSQk
   3tbek8IHE+xiy02GEBLJLUYj2LvaEx6keBw34h4wEljwACTF0YdmOTDcK
   dg86ewJzMV6u3V8QIrg7oa5EwfOuUI2Gd5xtqEIRoUMGyAgBabiMQb89Y
   8nEGB8ToypmCrhR3mse8uyN6rcqyS8vNmUfg5Ad4bt+ikNKiInJtKcis1
   g==;
X-CSE-ConnectionGUID: DR1Xe/VNS12vE+GAQg3X0g==
X-CSE-MsgGUID: 8Z5UNOgRSoKKipr70Wup7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14553968"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14553968"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 18:42:02 -0700
X-CSE-ConnectionGUID: CgFdmukqTxSI+N6tAWqI9w==
X-CSE-MsgGUID: 2seDu8hOThmXS8Sr5RnFxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39711694"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jun 2024 18:42:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 18:42:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 18:42:01 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 18:42:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu9ZKxajAWo9dGJvpncpnkOWIdIZDWzV++fc6LB3QsMJDt1aylm8IaOlCKkMYIbS4hFOC+gN2xo3TxMkU46wqlwGzM5N8anTotzZ+5vbtIeWNvSNwI3Qb9H/BXl9MO94DxIEKSB1Mgcb5X0/gxwDWhd2FlfsIg3ofSsT9cD/rpiWXfNuDtcbXeVT2az7YDcBRhRtrjHqehAiZONpCNtU+NcWk3AVtd7bwDqj7lk+EZ03EYPI12NagY+5r0jx0sYHXjlMDfNymRtsMXgi7ab3x2qAnoI7UE8jVQqHUX995Ge2pedrWZcTChgzjciLtE/G3ax4LlBlJst3nYHnEdZxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ne51uAYcXCKgoB/F83s+TU1J0IX1cAEY0MYJcqKneb4=;
 b=kIAVU8Yj6u0dSSVGg8m5bxPczbg68+LyKRz3mg1esnf/cj1MiA2Eop41cEHY1MerCL1LUKm3YcTLuXT4WWgbcNhBtdAaBMk9vcVrufTXFKHHCf7UwC6qXjXGhof0XTWoTyB2wzpdPYCuZJZIohLCWEo6VUfn1ClGKboJkUTvUOnJ4x59mHoy+1WTUycnWtDawN9UUAVKxm8QHsEzoVPmEXcPEoPGZeL9OSHz9LIER+B2Dt0eZ1ccusYhLFoUtFWsds/VdtP64MhltCYH8sO9HD9i3TuKYvi9KxHPhG/nsoXJWSM4iJElKth/BlK4/pETz6kQ5SR3p5T4IY8SPNIYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 PH0PR11MB7633.namprd11.prod.outlook.com (2603:10b6:510:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 01:41:59 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%6]) with mapi id 15.20.7633.021; Tue, 11 Jun 2024
 01:41:59 +0000
Date: Tue, 11 Jun 2024 09:40:59 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <linux-kernel@vger.kernel.org>,
	Xiangfei Ma <xiangfeix.ma@intel.com>
Subject: Re: [PATCH 1/2] nVMX: Ensure host's PAT is loaded at the end of all
 VMX tests
Message-ID: <ZmerKzEHlIwne5ka@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20240605224527.2907272-1-seanjc@google.com>
 <20240605224527.2907272-2-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240605224527.2907272-2-seanjc@google.com>
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|PH0PR11MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c783f71-be91-4d67-fc48-08dc89b7af08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lR9Wb0G4vdiD1JboItQEkVBYK/GwhnP9CsGCzc2d+ZmfS09DXTn+f3o6hk3O?=
 =?us-ascii?Q?cqWWPJMoWAMJXTtMGoDCudNYQA2MYoCM8fjeA46YC8iTgvjt8UYMf1u/LM3C?=
 =?us-ascii?Q?fUFUdWsqXTK1WTLsYATKWCh3zXU5w4bR86RUia1dHv74IAnw8DxI4GS02r6/?=
 =?us-ascii?Q?Xe9vzEUNaF9ReZQPttuj6Z19xcNbeU7QqluV4dyIdEG0Qc0ZSAYHiUl0IJuL?=
 =?us-ascii?Q?r/trNkCqS4BKpozLIJv1KS0UkMvKA/ryVHkL3K1cYyQq2reiSc1ZmaUBfYls?=
 =?us-ascii?Q?fD/Nr9N+rcnbVm7EOiicnSWIcAnY4a8VXUTJ7q4mCcYczKQnwYPt7XfjRDaq?=
 =?us-ascii?Q?L3fUR/CyxiVub80v0KOdmOtWIkhAaXLKlas7GnLWyP0ssTne7NrojHoiouKZ?=
 =?us-ascii?Q?EiKuQzW92gRS0nA83W9DVBTaT9uyh7fyry/8mZiKqSNtnMG3iwAtxpma/Vpq?=
 =?us-ascii?Q?P0pKrj1D/jUrQGUnMKEv8XbWKlhjU67WWaa83gRNtmPuygsAWot/pOOgAfav?=
 =?us-ascii?Q?8JBuKlEZJLPYTx0Ob6AUcxw+gOVbyhfdpjNzimrWx9Z56TryHx2KG3d2p42z?=
 =?us-ascii?Q?/KV36MZIO7U10Oq7KjD2P0ADQ+6g2oOQkipoANcVEyZ29drERuw0wRJduFJb?=
 =?us-ascii?Q?hJ0coXVqNeA2dRxa9KEm20iSS/PjA+fVNVQjPfflZHOUkgSp2tAmZjDouCrF?=
 =?us-ascii?Q?KOtQQfevnsz8gx45iDc7G+01IRzexLUpynq9NfcqUUCsC6zFwhsvoekOEN6Z?=
 =?us-ascii?Q?OSM3jkjIJoNTslnwhJVd5n2/CvaYxPrkSUWFobnMWVXehovy1Nbal2zLShBk?=
 =?us-ascii?Q?Zulgslyt7UhWBV6RgK9bGShv3iyGvF5ANfsNSrK38IrWbf2SeQkDbsohIdeT?=
 =?us-ascii?Q?D71mEcjZHDhpzIZciUW64HuNQVS8PNrXS0uGdJ1EoC7YR7xlRW00IeQ8LNDa?=
 =?us-ascii?Q?WrlMckQx8qJ6kIVyTz/4/JohatWFR8cQ8eeHGyDfr4ioMnlXIvIckHPOE6l8?=
 =?us-ascii?Q?QCmL5oDFYPDE6DIPmAHxzftYhxQ8DdFrcX7BTKr1yPuZnRMBtsJp+iIJXEY+?=
 =?us-ascii?Q?4wJ8b4cPCSeFUiXPsirWKPd9SeY/HOs933wMiYOqzZPjKpcnlEmsjAeerkcr?=
 =?us-ascii?Q?VdXPQ+iXE2TO/AOapO7h3nahfFJyHXo/PyaXrSNHD9SWdJLOk2qmLoRfn9YF?=
 =?us-ascii?Q?7GOdLw5jAuLvymkYhM1cv0odokl1bXOErxEHK1Ugj3Jlo+tmKzwPln/nTojV?=
 =?us-ascii?Q?CIS+JCCUJdf2H6sNNvBZ2akegN4d8PV0i3f3b9HzDnNs38xUACH1Ke5kQ1Xn?=
 =?us-ascii?Q?BWI8m0SNUaFYxn7dOgwX3TBt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6+e+SRCHwBgTBtcZ45UsGYENApQROk5QqeRQqZh3EUdO0nNA5IXgMtAHhR5k?=
 =?us-ascii?Q?KclM4OnW0VpHCUeAYMFw8FFS9OJ0rbsl76Ywmue3M0dMs4WGVhahBYr2i/z8?=
 =?us-ascii?Q?RECQg8r04ahV2IPbo7PRPJ+Rc1dPbx7thdM/O38HBC7uxuLOvShXpgHo4FsG?=
 =?us-ascii?Q?5IkvQg+f6GI7qRTXfUdHi7kpmjA67Oiq+wMequ6HxqpBv8icCHWATysKnGBU?=
 =?us-ascii?Q?U7x1pFFx0EuHNr3FE2QkRuNOI4qMDZBZ8R0SUNa4EUvfo6ysl0E7/TT6D3ba?=
 =?us-ascii?Q?+fkw/egdrfgLOgk2wZNqCgZ9SAJSIpO2umkSqiDhH04rS6hiXxx8Iq/LwwM+?=
 =?us-ascii?Q?j3+Qvfam0az60elQ8GZzSFKq3yLsvuWMvvEthb52AqWdxNlAtZd2cIBtivzW?=
 =?us-ascii?Q?k7R/2KYDTfSV5EjuySo4sp7ldNDU81FHqv6hjQsoKeRuOwQY808hlyeQ/sBq?=
 =?us-ascii?Q?h+duQiS8ffwJms1wENtFFn0rbB1EqrxvC3pZejjVqvpRaIVceAQRZ7mMTJbp?=
 =?us-ascii?Q?+PrNvM4HcJuZEP9UElxNtmHzpGjiWZxUG/z4CbNBoabmKGB4Edwda6WMLO+4?=
 =?us-ascii?Q?OeQBePsDTGriYkwWDTOzVGnLa8oPt0Po3LbY8y2OQRNRP/hizZzRS+te4JvH?=
 =?us-ascii?Q?zKpF4d9Q9CZNiktRDqkjo9ha8B5liaR20pa/k044pmsw2ZKkQ878slMYaqm6?=
 =?us-ascii?Q?KqY0hZf9DJuKiiklQZ21MWm6N5b20frNbokgtYvaNvF+JEx3INAiz2DNVvWv?=
 =?us-ascii?Q?ZY6s/VTlCcO03e9iNTYZIw4XP8Ie/T3Cpk9jukYFX2t8LXMlRBdaUVY04Wp9?=
 =?us-ascii?Q?SNo0KYV+DhkOsktFveJSaBqDmnqzev9k3Ij2/83uPfyrGCyhHmjajuMx0Hf2?=
 =?us-ascii?Q?VO36YPMQT7aj8Cd8BjlPmPUl9tP8fOG+qnhiRjonba2LKq24lK/K2yc5HRj2?=
 =?us-ascii?Q?hQrZ7piyvQLXLYboFBNYlMTAAYQ0Wp3i/0g6PPpjvF3QSoqOK4uQlVBx8e1p?=
 =?us-ascii?Q?FgfZuvyit9VZAMMoeGccv/qQSJmMYCNCZPdQVRC+mPUiJOR0l1+TBzvqVDVB?=
 =?us-ascii?Q?2xAHmzi0+d8gldcoseA5676ektUuSAske9X/+KqYeMfL7rT+Kui4MysBZllF?=
 =?us-ascii?Q?P8YrW5SoVXXIyW1kyNSks+lYyNMIwkrujx3MfIGLdgWIQXUxuzGoxBofGY+C?=
 =?us-ascii?Q?3Ma2bzEibugrKN9TeFWddcPJqUFnBtg5JOVgqjFE4aWVCgkgFurY5hKtyuxT?=
 =?us-ascii?Q?0M6IiYjtBP/I4h88ubFEoj/ORySPAWWm7V2xgTIwGnsuN3hFLzSom3Lu2iY+?=
 =?us-ascii?Q?2bH2wQFKsxukUfeM/l9+ShTZ+4zMALR52SZee0pGyu7q8hyhp48rrSzXWT7k?=
 =?us-ascii?Q?8Yp7L8kHoXZ5IKnBClNO6Ge6BY42Ua+U79EGhzNY7TwkAddjVUoB5e3YKgul?=
 =?us-ascii?Q?zOCnRynUH2/2OHTdW1M2PttA8a9SiXNOmxAg9M8tvlpRGjpiJrQhj4Preden?=
 =?us-ascii?Q?onTj5D+yhdpOBWheiYkv0xgDA3dFP4WmHIZykKq7sKpr+XN/dhSwVb5hryXC?=
 =?us-ascii?Q?e6qkTL9IKX3u18107Cx5GOm3C+MBZvn5CXCR/P8C?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c783f71-be91-4d67-fc48-08dc89b7af08
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 01:41:59.0038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIBOFHvKm+HPpBfoKHFqTvk3PFaGcTTXrtfXxnwtA/Kuf+67SfggJa59dDotRI0+U6AVnUTDs0WYzPN7PEhnFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7633
X-OriginatorOrg: intel.com

On Wed, Jun 05, 2024 at 03:45:26PM -0700, Sean Christopherson wrote:
> Load the host's original PAT on VM-Exit by default in all VMX tests, and
> manually write PAT with the original value in the test that verifies all
> legal PAT values can be loaded via HOST_PAT.  Failure to (re)load the
> correct host PAT results in all tests that run after test_load_host_pat()
> using UC memtype for all memory.
> 
> Opportunistically fix a message goof for the ENT_LOAD_PAT=0 case.
> 
> Reported-by: Xiangfei Ma <xiangfeix.ma@intel.com>
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  x86/vmx.c       | 4 +++-
>  x86/vmx_tests.c | 5 ++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/x86/vmx.c b/x86/vmx.c
> index 9f08c096..c803eaa6 100644
> --- a/x86/vmx.c
> +++ b/x86/vmx.c
> @@ -1126,6 +1126,8 @@ static void init_vmcs_host(void)
>  	vmcs_write(HOST_CR4, read_cr4());
>  	vmcs_write(HOST_SYSENTER_EIP, (u64)(&entry_sysenter));
>  	vmcs_write(HOST_SYSENTER_CS,  KERNEL_CS);
> +	if (ctrl_exit_rev.clr & EXI_LOAD_PAT)
> +		vmcs_write(HOST_PAT, rdmsr(MSR_IA32_CR_PAT));
>  
>  	/* 26.2.3 */
>  	vmcs_write(HOST_SEL_CS, KERNEL_CS);
> @@ -1247,7 +1249,7 @@ int init_vmcs(struct vmcs **vmcs)
>  	/* All settings to pin/exit/enter/cpu
>  	   control fields should be placed here */
>  	ctrl_pin |= PIN_EXTINT | PIN_NMI | PIN_VIRT_NMI;
> -	ctrl_exit = EXI_LOAD_EFER | EXI_HOST_64;
> +	ctrl_exit = EXI_LOAD_EFER | EXI_HOST_64 | EXI_LOAD_PAT;
>  	ctrl_enter = (ENT_LOAD_EFER | ENT_GUEST_64);
>  	/* DIsable IO instruction VMEXIT now */
>  	ctrl_cpu[0] &= (~(CPU_IO | CPU_IO_BITMAP));
> diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
> index 22e8812a..8a17dd90 100644
> --- a/x86/vmx_tests.c
> +++ b/x86/vmx_tests.c
> @@ -7233,6 +7233,7 @@ static void test_guest_efer(void)
>  static void test_pat(u32 field, const char * field_name, u32 ctrl_field,
>  		     u64 ctrl_bit)
>  {
> +	u64 pat_msr_saved = rdmsr(MSR_IA32_CR_PAT);
>  	u32 ctrl_saved = vmcs_read(ctrl_field);
>  	u64 pat_saved = vmcs_read(field);
>  	u64 i, val;
> @@ -7252,7 +7253,7 @@ static void test_pat(u32 field, const char * field_name, u32 ctrl_field,
>  				report_prefix_pop();
>  
>  			} else {	// GUEST_PAT
> -				test_guest_state("ENT_LOAD_PAT enabled", false,
> +				test_guest_state("ENT_LOAD_PAT disabled", false,
>  						 val, "GUEST_PAT");
>  			}
>  		}
> @@ -7274,6 +7275,8 @@ static void test_pat(u32 field, const char * field_name, u32 ctrl_field,
>  					error = 0;
>  
>  				test_vmx_vmlaunch(error);
> +				wrmsr(MSR_IA32_CR_PAT, pat_msr_saved);
> +
>  				report_prefix_pop();
>  
>  			} else {	// GUEST_PAT

Is it possible that ENT_LOAD_PAT of GUEST_PAT is tested when there's no support of
EXI_LOAD_PAT of HOST_PAT?
Then
	wrmsr(MSR_IA32_CR_PAT, pat_msr_saved);
is also required in this case?

> -- 
> 2.45.1.467.gbab1589fc0-goog
> 

