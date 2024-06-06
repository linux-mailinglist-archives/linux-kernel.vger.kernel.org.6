Return-Path: <linux-kernel+bounces-203529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D08648FDC9F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 04:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B02A285B0F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA40C18037;
	Thu,  6 Jun 2024 02:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AoN6iesA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420F0440C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 02:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717640175; cv=fail; b=s/n0F9M/rGUlms+anWgOKTszwTgaUgPSI/vtxmxnVuFFkKmUuDunybZ7lRtrR0x9hi1qWK4oOGg8Y9p9p4V2xJeqY732KeKhDCQ/GflmYzqt+hRRqnySfCdHj9e3dULjcXBWcpBrZG9udSO8GCxI/3bxhu/xTwnjroyOSwC5yzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717640175; c=relaxed/simple;
	bh=5iKr25wk0xMATXOGGVyzSbJtqJ2OoyHx44j8qEMwrlE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s3nsMNo/VNCPeAzGblsJUH7qsZCmXfhyNk6GAuXn/HAhrTNwLNltTveOeM3jHaBC/6y+UyFx5dY18u6ngW1jlAJ3wUd9s7GmTdCUU2+Gz8JwoA+uDJrArxAQ7qIlPNwr/3bwtHcTZdKYJX0OhdHAd3HcbDZKl9TTPKOqEFbQJMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AoN6iesA; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717640174; x=1749176174;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5iKr25wk0xMATXOGGVyzSbJtqJ2OoyHx44j8qEMwrlE=;
  b=AoN6iesAfguXiPvcXpkr7C9M0GAV9CsTAwZNBZVGs9BrT9hF1mKeZcdN
   awRE4HmYo/yo0HF37eCqYVt7UEbbnAnRWxNeIMjFbyFNg0WZNXzNI6p2s
   IIcP8OwmUAn18AgTj+6GKzqi4u6Opetc+hpYQu4TxGWPcPxph/n2wqz1e
   HsYRCpK5Jg5XcZOFC9Nb3sATI2rkLHep7wqK59TDRbEVo3r3AV6MbqRt7
   Ln7wBlURk+g3wWb7kwmsJ//idR/Gqm/vHlEpxZdIHhLFMajW/Ur/DhW5H
   k3crU/GHxhP4DGhljsb0nfsQH1cIlmQ8UmxWTUbVK78swYPRITLmrczU2
   A==;
X-CSE-ConnectionGUID: wSG4rvAmSTKyp6F/r0dQXQ==
X-CSE-MsgGUID: kVsVb0dvQf2q1L81v+pPBQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="18107127"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="18107127"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 19:16:14 -0700
X-CSE-ConnectionGUID: W7TPrtu0TriuCvIN+np1ew==
X-CSE-MsgGUID: N/quGPtCRDCUtFiTYj0XPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="42371394"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 19:16:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 19:16:13 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 19:16:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 19:16:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 19:16:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJZ/s0+/3R5BKvA2QJzT9WJwVV4L4pzkcEZnv6rEZZ4AsB6Nq1yTlZuoFNEvNIO+Fj5Vl/1ocnDc6EJmpbmJRovlBZbjp60zgWmoWlpun/yX2Nz1HDgs4dYtgw0TwG1gmD3l7wUayAq/IzCJ+0LmnfzjhvfblCRHG0SKOOYWKq4u5VhTcMADlUOePn+i7ovcile+wKEyr12Sir6prELGd2wsjnWmHF/FPKNEHE8UEgrwVRgKSEVQr1t/DFDUNKWix/TaDVhpUGU9dTfyqYjz3YuRNuLtFE23nZ8pCQFytS/9+Q6qYsgv4wBSYSHqK2SXMeydpQjXs4atRqVu1MOU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fk7szV6SjNLqEDclwy8iJCHNjMmZhTiTrQjKN4SmVOc=;
 b=lxvH89pltLZV9QoIwuNwW3LdVft/FH5OfxLL1qXR4cr+jOGTI7ULkweDFBgjemXI+hznOxOSft3ugTIvYhl317ubY7M7fWYXn81TXQjkAltvXFf00+INNcjFls9hoR9A2i/BrrRbWWQ+3PczQ4xbdaGetdfdM9VPyRT3k+u2tJhB1GGSt2xuD/znLkgCBAiymU71OuZItKRHv0P0qYgGB+uSCQAT3HBE+pP8W3a0aOhub0bNdI45q4rJpzKt0fUishdyhi85E93/LRJHKtcj4OrM/bTxTYI+cOiwi+wSTzeq7/w/M7vfXmFOKIiicvkrrIekFIKPucvbIWXnhXlT3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB7601.namprd11.prod.outlook.com (2603:10b6:806:34a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 6 Jun
 2024 02:16:10 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 02:16:03 +0000
Date: Thu, 6 Jun 2024 10:15:54 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Yang Shi <shy828301@gmail.com>
CC: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, Rik
 van Riel <riel@surriel.com>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, Christopher Lameter <cl@linux.com>,
	<linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [mm] efa7df3e3b:
 kernel_BUG_at_include/linux/page_ref.h
Message-ID: <ZmEb2mdAbBQ/9PMP@xsang-OptiPlex-9020>
References: <CAHbLzkqphyX473LBCXXf8rWEr-8m2PB--CT0cwCax3mUyZPGhA@mail.gmail.com>
 <CAHbLzkqG=9VmAcOgFr-50ZdZtf7xj2PqpfD3UHUsMX3jR=+snw@mail.gmail.com>
 <f4599bd2-72af-4e8d-a0fe-153b69816133@redhat.com>
 <CAHbLzkrOspjVuQw=BN2+RZmV_Ydpz_50yY7FEakJw8Zm14Y9-Q@mail.gmail.com>
 <a088b5cf-503e-4ed7-b427-f17a9ec5d1a8@redhat.com>
 <CAHbLzkpnDPYWq=HnaJcKhKnppdNikX4YG+1Ysu8Z+XJCoKK4SQ@mail.gmail.com>
 <CAHbLzkr5K=4Shiyb5KgPTQ20jE2Zo08wK=mT3Ez9ADEdJe0Z9A@mail.gmail.com>
 <Zl3M7iniPQaPFDrW@xsang-OptiPlex-9020>
 <CAHbLzkrOTAaYahG4JYMNrJDhQNZZxW9u+2n71J=v1XYJEVpUdw@mail.gmail.com>
 <CAHbLzkr16YZ80ES5U4BEWJ+ueL22nDJtgH=eOztdHfy080diPw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkr16YZ80ES5U4BEWJ+ueL22nDJtgH=eOztdHfy080diPw@mail.gmail.com>
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 585808d7-dae2-435f-d3ce-08dc85ce9db9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1VnK1RjbFpiaUhNM3ltVkt4ZHloMC9DR1FLcGxwaVEzWUtEZUlsTFIvaXpL?=
 =?utf-8?B?c1RrNmZmWXV3MktOcmxueGxlMlpXR2R3ekpGQjkxd21XQS9TTlMrSW1OcGs1?=
 =?utf-8?B?YStyN3dXLzByL3QxUFZXRU50WmRCQ3hxV3lTTkJGUmdwV1RnWHhCUzJXM1Rr?=
 =?utf-8?B?TC9YZ1RjK21rRHdmOTE1WlN4WFQ1aGxYT3pzY0JJZHhvSWtjb3dtNlduK2xk?=
 =?utf-8?B?aHhheGNDZWovV1NCaThSK09LWVNVdFYyeVZKMVdwendSd1lDOXp4ZUxOQ3B0?=
 =?utf-8?B?RWZ5RHJvbmw4U21VczlvWEFYYzFVZE85U0x0Z1FPSG83MVN2NmdxZTdWaTZ6?=
 =?utf-8?B?OXFieDNzWlFXaVNrK1lPckEwN3Bic25oVEhya2xyUGNVcVk3ZkVRMXVJWXB1?=
 =?utf-8?B?bUhlcVAzUk1heFZjNGlJanRvaWttKzR1RmFhOWpxYldnakw2aGQxd25YUlBn?=
 =?utf-8?B?a1dwNFRkSW9pYnZLVWhGS09KRVJWSnFaM3dpODNhM0JZc2hZMmppQ00zc3Uv?=
 =?utf-8?B?VTd0Z2lkMUxGeTJ2WEN2bmY2SGZKWnB1VnBwVUlURnplRVlGNEdaZE9wNWRZ?=
 =?utf-8?B?STZ6UWhQSE9SYnFmYklxVGg0OVl0aEk5bUp4Z242V0YvUFNibldqRStGNXZE?=
 =?utf-8?B?blNYWHdUZ3pRaVBiamhlNm0vNGNnU0hqaWVMNE03VXdxRklhQ0tGd01VUXVD?=
 =?utf-8?B?U2Y2WEJJdWc4akM3N3h5WXI2YzZFSDRDWFRFRnpGU2J0ZWtmY1BKQ3UxVTdL?=
 =?utf-8?B?NCtzUElwbkliSHFhYkpOZVlaNThtYlU0dkNjS0UyLzFqQWo4SHpkbFJ4WVlB?=
 =?utf-8?B?YVBqNWpmSnpIdlV4VERLNU4vNDBHRktqNFl3VTk2MktIY0k0MlhmY2JoYTBB?=
 =?utf-8?B?dGlKK2lkUU1aYjdNOFQ4TzlQL3A3alU5REJTeDhwRFBWVzMxeWtwY3lUcXpa?=
 =?utf-8?B?aS9iblBERUhwYUJma09mSEJvdEQ5ZDRqVmRtaFlMRXZQdU9GU0Z6eHdBV2lo?=
 =?utf-8?B?Yll2clNRZGNNdEU4bnFaY1Vxb3A5WkpOK09RU1JSMVl2SFY4Q2d6TUR6YzNP?=
 =?utf-8?B?TjhQNUc0Mk0wRGlNWjdpMDhyNldaa3kzeVZqeSs0T0VDd0c0MkNBdHBLejFi?=
 =?utf-8?B?OUdxcnNONExuNTI0SEZCdVVJL1o3WGpxYmpKM3I4VWk2WkswdFppYUgxbjdk?=
 =?utf-8?B?RTVUVFAvdzlpemtETXFteDl2bEFpNy9JYStPb201eFNncmFweE5ia2VEVVJ2?=
 =?utf-8?B?MTZkMlpndDFpR0xtTlU2anUyTmIvb0NaWDEvTnpaVXNzb1JWZ0RZTDc1M24z?=
 =?utf-8?B?MmhsbjhiZ0krMXpGTEcySUZudGFzRVZKbjZ3NFE0bm11NEZUQm5HMDhwOWdU?=
 =?utf-8?B?ZWxSVTJWSE1lN1Nnc0M1dXB4cEYxS2hqOTNXby94ejdrd2dLc2pLQm9JM09X?=
 =?utf-8?B?eFliYlVmZ1FrOUtzZFEvZk9sZlhsYXdDRlZqMG9BaUc2Y0FlR0dMcnRuajh2?=
 =?utf-8?B?dDBDbnQ1SlN2K1NWOE1qWE53WEpZRGlWUisrWVFGdU5sWmNCay9mZXhBTUx6?=
 =?utf-8?B?bXFhWnhEYSsrREF4OUI1Tmk0SWFxeFB5WkRrUDJ6bG00UDQ4NVdvbGtEMXRN?=
 =?utf-8?B?eHdBVVQzZ1JCZTlXSWVua0dwUTBtM2tzTU5MeWVBRHgxVEd3LzZIUmRxeFJK?=
 =?utf-8?B?QXhrQTdDQ1dNNWRxdVZ4UXp2SW1HRGQzOFIyUDkwY3ZiL3craCtKTTZ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVIrU3N1L0hpR2ZxbG5OdXJsaXZURktHYzRTNmU0MEtnTDBIVGozMkZHbTgx?=
 =?utf-8?B?KzRYaytMQTVDUTRlalVLVnFURnJQMkwwRzdPdDlrUUQyNzdvV1RtN2JIZFBx?=
 =?utf-8?B?VTdKbzBBMVFUaTZBanplL0RlWGxMVERzUG80TEJBeklWWk9sUTBRVzFGRE4y?=
 =?utf-8?B?S1JWMThqdHFtOFRRTWtwYTh5NHQxdDNBVUhYODF4aHNLS2xEMW1iVTdhVFZI?=
 =?utf-8?B?RGkzQUR5VTY2TThtbmlmSElncDlrS0ZWYTczaG1xdDNoald1ank2UlJnTGtR?=
 =?utf-8?B?NjhYNzhPdENyenp5b2xjZUZKdTFpcXlZT0hVQU1tZ05GK0hiUDJHOXh4bXQ5?=
 =?utf-8?B?R1grcC9XdURLSmlpR3VUcGxlMWZQVnVNVE1yVzFvTFY4SVFibnU1WXlkT0Zx?=
 =?utf-8?B?QmkzQlE5MTdOK285ZE5WSTh6U2hvOXdxRjdRT3NBNnFMSlRnU3RwdzU0b29H?=
 =?utf-8?B?eWNoRm81T0NpQnpLcEE3RUdaOFBKc01ldmxHL1MyMzJUY3Z3L0VlLzNnQzNr?=
 =?utf-8?B?YmY1OS94TVhHZ2hIbld1ZEh4SlN2c3JUOXR0dEkycnlpSmJCQkVLeTdEZDV3?=
 =?utf-8?B?T01FbXQvNFl4ZnhyVGRYcnhQZUJ6SlZ4UUI3aUgrdzVJY2s2ZWFHT3RCajh4?=
 =?utf-8?B?dDNqeGNmNVRZbzhudW9JVDluTzFNSFhxS3RBMDAwMGxhYUVmOThSSzNLblo1?=
 =?utf-8?B?NklDaXRoZ1BIcThpeDNMSFhEaHArUkFIbkZSNUdiQWxMc1ZoS09Ub0hUUzVu?=
 =?utf-8?B?OEVYMXIvWk1ZYkNabFJOWHQrdXZBdDNxUk93SjRSUHZkQ0pDbjJwS3d2NmF4?=
 =?utf-8?B?Y3Z1TUxEMnI3ZDR4bG9RYVBCaGNwaFhXUlprcnlxL2dZRm93WVNUdmlJa2tm?=
 =?utf-8?B?aG16WldwYTRvYjBtSEZYdHdmczBZRkY4WE9lSHhnWUJWTkZiS2ZTd3dGaHRq?=
 =?utf-8?B?aU5lRnVIL0tYWTJ1WmNqbU5oZlNRU0JQUDA4SmZqTlZxSzdDMkphRUNYTkta?=
 =?utf-8?B?Wk1YZHEwSExnd01PU3Y0K2paaGVZZTZGREFhWWh4NWM2UDdJeGtMSjlNS3gr?=
 =?utf-8?B?U1dJVVdQNnVKM2p4RTVteXVrU2VNdFFsclpOVHpnSmpuSXhXQ3lDK2l0MUNL?=
 =?utf-8?B?WkJuR0VGMEE1a2FRMEo5Y2UxWlNHczNways1M0FKRU5FQUg4WFhTUEpUU0lD?=
 =?utf-8?B?eHBYRjVNZHRzOUU1RUYwaFJZZHcyRzVaSCtZaFVtSkNoTjNaODA4Q3pzSzhX?=
 =?utf-8?B?MXZLa01mLzJ0Rk16L3BwQThCSVM5dXJxTTlUTG81aFQxU1hERHEzVEFTcDNn?=
 =?utf-8?B?U0RVZmJSKzJha0hJYzFPNmNjVGh5RzNmWmhDR2FRS2d1SCtuM3JzRzFsTk1i?=
 =?utf-8?B?OXcwUTlFV3VtRHBYblkycDFqZ2ZWOWhkSWg0dmtITXhhbURnZE1BU1E4L0hE?=
 =?utf-8?B?Kzl6RFJ0Y3JWa2xHem9PYzl3bFI0OWx4c00zNjlCWklnUjZheWl1aFdLMmpK?=
 =?utf-8?B?dG1PSlNESE9OMkwvMVZsZVcyWUFtVFdHQk8yd09TYkgvenUxeUlOckJHcnFj?=
 =?utf-8?B?ZVJVaTlPZ3hVTHd0TnVrTHE1NVlHMDNVTTdGdis1VUdnSFNKZ25DV3pxZXdW?=
 =?utf-8?B?RDdWQmIrZmRxekZsY2N0K2x5RXZpQXdWRDNLR3BVYi9TZjhqbDFKd2p6enpz?=
 =?utf-8?B?S1VTOGFyTG1CRXVOdGZjU2ZhWHRxOTE1c2hrV1FzaXBmU01uVFVzMjQ4TVpi?=
 =?utf-8?B?dEhFSzJPN2d2SkVaU2xBZU1hU2ZQVmgweExneVlXTWhka3YxMC9QL2IxVHhn?=
 =?utf-8?B?cUJ2bXdONU9nZXNUeTJRSFQxR2laMUZZVzVsTHVoN3pkNlFRU2Z0azdrR1FK?=
 =?utf-8?B?MzlnakpZdFdON1NsSWFoL0tCeE5saEFIMVIrM1pzdTJJaC9WYWtQTHhWdXF5?=
 =?utf-8?B?d1BvcC9WelFhN1R3bHp2ZFVQa2JIK0h4UXI2SDBtbi9ncHlnUUxrWlF3R3la?=
 =?utf-8?B?WlpYUmlibnlFRHRGU3J4dG9qZUNaazYrSGkrbDJIWGFaZGdlNlpOVTBkdHgr?=
 =?utf-8?B?WlA2NzhEUlJSN05XMTNtc1Y4RTBuV1loR3F1dFlseWw3aXRiMEVmTU9paGMy?=
 =?utf-8?B?RjRsckF0WVduOFNYWG0rUk9lYXZIWUlYRDlLTkNPd1VDYUNpUkZTejVvYkFS?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 585808d7-dae2-435f-d3ce-08dc85ce9db9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 02:16:03.6766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsRn+JFfsFjzHix2a78mfJQk1gOikrF6qxAlnYsgAV+orkloQ0y/02DC0Tu71D75iqBBebr3SpHqRcyoBWuOgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7601
X-OriginatorOrg: intel.com

hi, Yang Shi,

On Tue, Jun 04, 2024 at 04:53:56PM -0700, Yang Shi wrote:
> On Mon, Jun 3, 2024 at 9:54 AM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Mon, Jun 3, 2024 at 7:02 AM Oliver Sang <oliver.sang@intel.com> wrote:
> > >
> > > hi, Yang Shi,
> > >
> > > On Fri, May 31, 2024 at 01:57:06PM -0700, Yang Shi wrote:
> > > > Hi Oliver,
> > > >
> > > > I just came up with a quick patch (just build test) per the discussion
> > > > and attached, can you please to give it a try? Once it is verified, I
> > > > will refine the patch and submit for review.
> > >
> > > what's the base of this patch? I tried to apply it upon efa7df3e3b or
> > > v6.10-rc2. both failed.
> >
> > Its base is mm-unstable. The head commit is 8e06d6b9274d ("mm: add
> > swappiness= arg to memory.reclaim"). Sorry for the confusion, I should
> > have mentioned this.
> 
> I just figured out a bug in the patch. Anyway, we are going to take a
> different approach to fix the issue per the discussion. I already sent
> the series to the mailing list. Please refer to
> https://lore.kernel.org/linux-mm/20240604234858.948986-1-yang@os.amperecomputing.com/

got it. seems you will submit v2? should we wait v2 to do the tests?

sorry that due to resource constraint, we cannot respond test request very
quickly now.

> 
> >
> > >
> > > >
> > > > Thanks,
> > > > Yang
> > > >
> > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Cheers,
> > > > > >
> > > > > > David / dhildenb
> > > > > >
> > >
> > >
> 

