Return-Path: <linux-kernel+bounces-524900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B40A3E887
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC1519C4D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991D3267718;
	Thu, 20 Feb 2025 23:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KeT1LNiG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28E2638BC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094242; cv=fail; b=aHiBFwye61aWgvCFAWCK0nCrLrCYOZ3R5CjLsTJftrTV9OHII8YFdQvFz6oVZDEOfVbzK6bY916+Rg4IQ1UopLnjJpRcvRMQWMMRGXXt1VaILBX4XbPN/x8kF8WY1YPWbXxWetzwzKmlUfYR2oSshL3fRt0ycFF5AP4vxzXjBvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094242; c=relaxed/simple;
	bh=JDWQM2lWDFkUUfaAruD9427d4AwSjeR6cON9cc/X6rY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JJLwJHUxLbXN675ieQiobZKUOmroyF+IJFPaYcvKWGDN2MF61Kt4G88XHZTT/QAkhY+Ff7UoY92cZ5ThIrk4bgz9karxg7mZArst5yVrfngI3F9PzPzezGXWmy/V6dHafx7BU7wtu83JsZ2ndHxmVxNe5EajqJFHzfOKpC8sQKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KeT1LNiG; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740094241; x=1771630241;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=JDWQM2lWDFkUUfaAruD9427d4AwSjeR6cON9cc/X6rY=;
  b=KeT1LNiGQqBHReafPiTXAjmPOCBl39uEFkIePCwgIummu5rdharZpQhB
   pbcYeNd9PNgI+7h9jiFytQFeJLm2iK6QKaZx6vUJvqpbv7vR+d06JBJor
   fqTlTwKmHE5BzspsWdOu2yJVD7ZOtBX6iq/C8h4sh/XsxJFxL9hHjC0ud
   7c5O+JE7P6Mgswzdj+2AjHomyj08jxsnToekaKyM9R967KieBRFDoRSFF
   mB7lcMoZvzWBGSnPK+gaeYNiClHyoOhjk8N+NUtWYlzcOezgeVwgHGLbv
   z8WW6EhHQVwmpvPvOxZy7DF7lEyGST5bgwxfYn2HMSMbPF4HaPei4kdMW
   w==;
X-CSE-ConnectionGUID: zrWnUDtwTBWIpadSPe/d5A==
X-CSE-MsgGUID: DB4oOBTBTXOa7+AJld7lwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="44682506"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="44682506"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 15:30:40 -0800
X-CSE-ConnectionGUID: Rfajk9qHQlWWKTVI4z2k0g==
X-CSE-MsgGUID: 6E9c6ALOQrqSgS/EIWkOWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="119826521"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 15:30:39 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 20 Feb 2025 15:30:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 20 Feb 2025 15:30:38 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 15:30:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUv1mGF6Qhpj2j5oeDecuJt9J4nc5RNbyw68nK7qc98eYr44tCU2qMlfeSGnmy7aw+W6y8UE3ak2P2CQyilcAmJxYlCDj1vJMEY4ZCQeEZH2gwoUWmyvimFdM7BmzBnrbkGLXf1n5NcPhxdeft3PwC+SRcMlc/xTxnUje0W5lfDd/yeNa0363YTxKTS7Koernwan4f9bnCvEtptsF24khOHfJxGtJcERG8dvyHnG6XvlSzEz30iBe4lE8I4UCzCEQ2PkiT5UiUf2zhpzPaKmsUmKUs4QP/V5sr3dFJoR7mxDxVBNGaFJRcN3IviADWcWVPzEXJL2d2z/tCfVIFvbKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jxIaku7aa0cAyDdW6QTzq2hXEfWAzlemTL1W4aqmrc=;
 b=x/s6+APq0OTTIBhNFI6xoYipZcupqvdv9gRmER3lEEIWlUDxcZw32uljltOCQ7rwhP/5Xp5fgsq6bXoZ0hM0QSPp8nObJKZzcoZHar5iyaGPn4HhUZkL2dYvtvHfM8ioAdEG1hT8sswL2VNcN+4mKenRajNsdiSb8GFGNdL6/37EsuvpvIE4Y2mYvEHJFrqTUzAn89LO8ElT6jgQpQicPI4VmE0epdOuUIsWeVumFMBcKF6YElx+9wS0axGSUna368SIZIge+KB4fKHfya/zKU6Tmi5nTGBH+e2TJZCaeQXANvyyK7exWHXLklbTBPqcIpLa1iWS36cv8nf9myQ52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4827.namprd11.prod.outlook.com (2603:10b6:806:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 20 Feb
 2025 23:30:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 23:30:36 +0000
Message-ID: <48d2ad7f-0f4b-473c-8344-6fe13567cff1@intel.com>
Date: Thu, 20 Feb 2025 15:30:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Change maintainer for RDT
To: Dave Hansen <dave.hansen@intel.com>, Tony Luck <tony.luck@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H
 Peter Anvin" <hpa@zytor.com>, x86 <x86@kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>
References: <20250131190731.3981085-1-fenghua.yu@intel.com>
 <a6286d1a-33c1-4d36-a93d-94afbaf9cbfe@intel.com>
 <464cd44d-b443-4e00-a72a-e78e1bed437e@intel.com>
 <a411727b-f6f4-45bb-9513-577ebefccddd@intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <a411727b-f6f4-45bb-9513-577ebefccddd@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0177.namprd04.prod.outlook.com
 (2603:10b6:303:85::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4827:EE_
X-MS-Office365-Filtering-Correlation-Id: 3569348b-a4ee-405b-d141-08dd520693c3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2FBMFVKcVUreVJBckxuYUwxWldnSURUM3lvSEhYa0RGWjZRZzNyR0dXSVh3?=
 =?utf-8?B?alFocUdpN3dheTVIaHRyU1pwR0hmTHZRQnZMMkt6ZDhtbmtmOGlwTlliSXBo?=
 =?utf-8?B?T0dtN210OUJlcGxGTS9KYUtJN25RQyt3Z0YzZUJFWE4rcXVUeVg3QkxEa3RO?=
 =?utf-8?B?Ukw4NEsweEJHQ0E1REVBUkVJVytOdFcvY1RTV2dieFg3UnlSRDg5U3F0Zmd5?=
 =?utf-8?B?eE14Qjlmb1E2VWdwaEZCQUYwcU1UMVM4aHZERE5VaW8vOFhtWmY4SkJ0Ykty?=
 =?utf-8?B?TkdWejBDM0t5RmxZWUJWUmpWY2d2VjNueHVySkE0RWxYQ2svTHhpMzAzQmp0?=
 =?utf-8?B?VmhEZDRIQnlhR2lCN05pRkJjUWQzbmsweWovZlNHbnhCbVBXRTdzRTV1TnhE?=
 =?utf-8?B?RDZEYnQyU1IvVGY4N3dibWZ3K0QzdHdMeE00MGttR1ZURm8vSGpzVXJiQklU?=
 =?utf-8?B?M0dPODk1eWJESHM0T2NpbmJOOEpSdkh6Q24wMkc5VTlHZURIdkpDV3ZvbWN2?=
 =?utf-8?B?dTg1emtPSnBaZjNNRUlGaGxFRDk0VjlQUE9NMW9LM1ltaENiVU0vR2xqek1q?=
 =?utf-8?B?QXU3UmVxUUtabFk3R3BOSWNEQlNkRHd5WUdyUjRtb21OZU1WWXp3MnNQSHpK?=
 =?utf-8?B?MCtjQzhkYVhLVWQzTUJwZm82dW53ejVuaG1JeE9mRk1aMDUyN0J2anE2c0R1?=
 =?utf-8?B?bEZtVGMrOWZJVzNDZDhHblNya2dwTmNJalo0ZUc2dEM1VndmSUF5VXdHSW9t?=
 =?utf-8?B?NWE3cFhlZ3BraGE1VzFBQXVLVWh3QWFQdUE5aDdSazkzOFkxek9MWC9aY1V5?=
 =?utf-8?B?U0VDUGhuRitMd1hVemlCbkxrZnRVUitrbWJDUGdkM29kbS9jcG5pUnF5VmFU?=
 =?utf-8?B?Z3JPUUNZeW9PS3A1UGR6SVhQSVJHOTZMQWRpQVJkNmhCWFJWaE42NzR1Q2Jh?=
 =?utf-8?B?ajJTc3VKZGZkQ2hsQ0x5Mm1tUlR4eG8zcXpIMWF1NjhNVEtSWVBGNzZTYzZL?=
 =?utf-8?B?Zkw2dzNPUDNJc3VNS1N4L2dkdW5BU3VjcnJQejJ0QndIVEw1NGo1RWdDSTlB?=
 =?utf-8?B?QUFTQWgvZWlWMjV3NWF3L1JxY1NVNTlZTXkzTWRuOWllMldyMkg0eHB4eG1a?=
 =?utf-8?B?Wkc3REd2bTAwcThZVXVydDJnRytObjRZeEpkOTJGaXY1YVh5TCtVdTAreFU3?=
 =?utf-8?B?OWNtSnUwZVhmMDZrUjlyQlp5K2d6VytIWGVGR1k1WDB4ZTIxTUk3UE5QcHZq?=
 =?utf-8?B?OXFoaEF3ZUdNdHJWTWo0b2NsUTF5MUtGeXoveTEvbHhvdjdEL1lzdGRGVHBD?=
 =?utf-8?B?R2lPMXBMdSsvQlc0RGdEbVZ5TDh4UDlzdEQ3Q0RIUldxNWhKbEtaNW1LSGhw?=
 =?utf-8?B?cnJqQkJkb3FDbkFJVHFxN1piM1UyZTV2RUJPamRZZDVCdGk0dkJQc2NIYjQ5?=
 =?utf-8?B?Wm12TXFDZTUxMGV6VTB2cXFlRHBSK2k3ZXBrT1JwR0pORGFnbWlBM1RRbHg1?=
 =?utf-8?B?T2daRGdudG02T2NHWU5Dc0V3VTRraFExWk5hOS9renFTUVlFSHA5NTBpbFhZ?=
 =?utf-8?B?LzNvUE9ZVDljbEkyeExCWmVteGo5eURwTGZFZHI0Mi9OYk1CY09XdVN5OXVx?=
 =?utf-8?B?N2pvVkNEMXdHK0U0OUUwanFFa1pIV0ZkRTFqTU9DUnA0Zno5cmJTOFptZk8w?=
 =?utf-8?B?NUtJckhQZ0RGQTFwQTZ3VThzc2krR0JmRkN2eG9IdTRJc0pwTjNvc2d1eWxk?=
 =?utf-8?B?aDBUZFpGRkNxbEZTWkFveFRqenE5M1o4MFVPZ1ZycHNHWVBnWlVkeE9KYjNB?=
 =?utf-8?B?c0wxYWZ4Y3JXZnAxekQ3TFA0YnBneXN5OU01VDNMWEs0VjFmNUlLcFh5Q3ZY?=
 =?utf-8?Q?YG5MB68bhVWtY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFNPQkZCLzVMR1Y4RTZLU21IRUc3SG5NTWR5bWpyZWE2c3hrWDBqK25oZEFq?=
 =?utf-8?B?MEVuRFNxdSt0ajVnREhiMjJRWmJJNFdCZUJWcUcwVVN0VVdaVHgzYkxqQzlP?=
 =?utf-8?B?bnE2V1NXR1NrLzJFaG9DakI3WldSVS82dWY5T09tN09GTkF2MitHZDlHai9J?=
 =?utf-8?B?OFlLblc4bmZ6d1FXSDFyb3pDTGVXcWlqeDJjUmNTclY0NFRGcGhuMkhuWkRC?=
 =?utf-8?B?ZGgrZCtvaVB1TVQ5SnhHbHVFUTdReWowNVVJdldBbk1NQXZvWWo4Y1NDalVO?=
 =?utf-8?B?TjdmTUlnL2FJTFNSRmNXbEloMHFGSHFqTHBKZ3hHNDhHbVNpWG9jSVV4c0dl?=
 =?utf-8?B?V3NlZkIwcDlhWXVlTFhZQXQyV2NFQ2txVlhjL0E5RU1xVDdVUTVhamlGYWxB?=
 =?utf-8?B?RjRSQW4vNGdBSnMvaThremY4NExOeUxzbkU2OVoxUFBEakE0dWE0Y3RpQmov?=
 =?utf-8?B?WkpjYVVJUmgvOWRoREFtd1hZdXdIZHVkcTY0aWVtVklzVDltZkdRVkFZMnN6?=
 =?utf-8?B?WXpPMzhSckRPMG4rTkVuK3Vaczk3dzBLUU53c2JESFlrTVFpOWlZRTBFL1Bo?=
 =?utf-8?B?KytpTXUrSkhLcFVGSis0d0FkTEh1ZUNlTDRUdTlTL0NJQndsUStTbWE5OExw?=
 =?utf-8?B?ZStIZzFWS2ZCa25sYkg3b3d2bDYvMXFiQWt0RHVLazNBRVQrQUdYVEFZYy9L?=
 =?utf-8?B?NFRKNmFqMWI0WjBtMnR6Rk52U0FuRmtOTHdwWWdQYXN4bldLT2Q3R2VQQXFS?=
 =?utf-8?B?OHJaMXNRMzlJR2gwblh3MzlvSTQyMjkyYWZXTm9maUN1RTNKb05ja2QvdDlp?=
 =?utf-8?B?NDZ6aHozOW1ZbzFvbncvK2dwVlVrby8yNW5HNGVMS01UMkxWS1NQNkhENmlV?=
 =?utf-8?B?S1VoWGt2VWlHbFJzYlZUUGxoQkYxck9KVUorMUlkMWF6RThTVjhBcTVXWDY2?=
 =?utf-8?B?YlRKZWtxYTh1MDRGRW9HVEVhTjRkK1Z2WUpuT20xZ0c4TFp5WlNyaFpCaDNR?=
 =?utf-8?B?ZjI2RWxHZmJpd0MxSVlLQng1dlJoQm5aY1BDTmlQY0FWQzNtRFRyNHRnSWhI?=
 =?utf-8?B?L0ZWS0JuODhBeVVZQjFtUzZtRU8ydmtOalEzSUxzSitrSHpDU2tIUk96OTht?=
 =?utf-8?B?clY1RElHTWI3dmN3S1IrQVV6NnRtZWEvcFlYMHdWbktPSGtMNXF1YmpBL2FO?=
 =?utf-8?B?MmpUOVhoTVlWak9pL3NjclR2SzBDWHBvS1JKR3pZaWk1Rm5GYW1oOTRFMndv?=
 =?utf-8?B?dWRjdEdUMGI3d2pYUXdYRUQ4LysvWC9BZkwvVWs1d2F4cGJZY1Z5Wlh2aUdC?=
 =?utf-8?B?ejhHalVLSmR2bkdxT3dNSUFoSm92WFNsVGZ3RjZuQ044c3gzbDluUHA2dVBp?=
 =?utf-8?B?cHRkcFVsLzZxYk9ja0JxOHA1dGdnQzd6Z3I0bklHQ2JSdDRFTXowN0YrZ3Jt?=
 =?utf-8?B?THMwdTZJdmw4N3JUcW5Gb3ZYK0NrRnY5Y2o5QWl2QmE4STRUVHRXN2FEeVpq?=
 =?utf-8?B?dVAzM2hMWkYwS2tVRzR2eGVEcEY5cWlEdWtCQndmb1M0KzhjcG8vY3BDbXZO?=
 =?utf-8?B?Z1hZLzZFL3E0T1BvMEcvYWc2bjlvd2ZnMGJqZGZWRHQ1QXZnTk9GQVhrK3pw?=
 =?utf-8?B?b1F2cExXT3VVNTFheTUzWnNHZHlReTVGbnRERFZMRDVPMC81eVlaQi9sWExK?=
 =?utf-8?B?cWZjc1BaejdiNFJUWjMreTlnSjRFMDNGbUgwK05kVXd6aW1SZ3ZzR1JKazdp?=
 =?utf-8?B?VWg2dlgrdk9hdFdpdEhJcE1LdWZZelZJUFd2RmxFaE1DaCsvSHVuRWE0VmIy?=
 =?utf-8?B?YkRjMWpuSnBtUFFZVHlLR05VNS9SdFJ3MGhlVXlSeFdQWDB0VFBxQzA1VitK?=
 =?utf-8?B?NFphclpqdGZsZXJGTnVaaEcwZGtQL0dEYm4rd29KWVdlY3JoLzRHYjZWbTlE?=
 =?utf-8?B?YzAvUG9JN0Mzek1kQUpRS0dDVTB5Y0VBOWJMR3lZNFYyRFhBZmR2NzI0V0tI?=
 =?utf-8?B?Sk1CVzJBcUt1eHRNTEJHdENNeU9IdnBzdFcweVJvQjZqRWFPUnNpSVBOZFl0?=
 =?utf-8?B?KzBWT1RvNmNFSkU4bXhDTURCa1A0amZaNlY0VWRoNGpUTlY3dFJpUXMrYUF6?=
 =?utf-8?B?TXN2eVVrZ0hOQndHUlg3UTUrTm52MStScVh5YUZUQm1PMFNDcVdoOWp5OWdq?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3569348b-a4ee-405b-d141-08dd520693c3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 23:30:36.1253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTyXC2kv01D12pwdqXyabveZIgB/FWQGZUHfh2NoEnM2Bi76N0xFhUjf053idKU45b4/MZPlPhB6YrPD/VQ/56HrRNQwgAPnL/BNm3rA6bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4827
X-OriginatorOrg: intel.com



On 2/20/25 3:21 PM, Dave Hansen wrote:
> On 2/20/25 15:19, Reinette Chatre wrote:
>> Could you please consider this patch for inclusion? Fenghua's
>> email address in MAINTAINERS file does not work anymore.
> 
> Sure, I'll pull it into the urgent pile. Thanks for the reminder.

Thank you very much Dave.

Reinette

