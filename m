Return-Path: <linux-kernel+bounces-561789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55402A61643
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31E518987E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D86202F8F;
	Fri, 14 Mar 2025 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YN0gPXCH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7646E60B8A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741969748; cv=fail; b=A9c1H8ybwPjindDeotFEyD3vwU6QXnPg+iGYApGOrjXgKcYVAbnKIOBeEpyrpRIR1qUFaYTkcX0EnxeeneHOr/fMntpSnYfdz/jERIrUhuzE1Pk9aiomUImFSjMPhu3OrDUonKggY/KwSYs7yDV02kwi08vFBErk6Skx6Y7zT+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741969748; c=relaxed/simple;
	bh=hDDjy3uQlV9l6uRAu7IB1kscsP8bx0y+afivjb6R6nM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JOsw/FYOgZNQQAjdKez10OSzdGnyQb5DHTxSXt9SSCYHGfqsQhsPFEc0tduTVhavAodKZxYixDUXeY5SYAMmPxc22liCcaIsxwSOG+G/2uxzBKi6eaoOIL5zNsP54Zx49jjAhiNMUxH+Q26W4r+jWhSynnvJe09FsyhpDTyl8/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YN0gPXCH; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741969747; x=1773505747;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hDDjy3uQlV9l6uRAu7IB1kscsP8bx0y+afivjb6R6nM=;
  b=YN0gPXCHs2NPeHJ9FJfvYq31L5fFGLo8jXWVY1GAJXHbPhDGn6W839S8
   w7edINBshxGSHcITIm+2S2FBcedk0AVEf95Bl8HmosjgxY00sNHB5YPNn
   b3MqNCxMDpcpSsvYYCEHOoAobVVXYtH6eQAY08+KJXDUYNkPdBWDjCPV2
   xyNdAMmH9UwkDrA7cvmV2d3WGeDNEkgWOiZhsX3YPOOaOR9nktKSH8mFJ
   q6TESpRJy3LdDSslg1Ii36CpW/1sbtnsixNXmmLQgm9wXMpB7Vd+yODym
   nNmJLdnA3qDfwv8MYyzrwz2El7TS5WmJ4fpSR+CjfrlqWi3IoBPiGFwFg
   A==;
X-CSE-ConnectionGUID: KudEfw/sTvq63wNarZ1lxA==
X-CSE-MsgGUID: Bi6TqOk8Q/+0OLRgT/2i7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43036809"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43036809"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 09:29:06 -0700
X-CSE-ConnectionGUID: xupDY22jSFyLI6SkLBb0Pw==
X-CSE-MsgGUID: FrvBGngjSPywGLne9zG8gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121819480"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2025 09:29:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Mar 2025 09:29:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 09:29:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 09:29:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLwAJWrXqKU8jekd4CLwJCz0axL2CrR8ODlOT6zo94OYjB1VS+0N2Eo6jKlqN5+qlnrq+AU00GUDGKKKzTwLGnBWaA/OjFrUBJOeRAeeEFWVGh74iIVd+DJ9pbgomTCwniGoRis3reI62ZL7D+rqR4NxfLrWIqMJJlFIfSJdP7+j5LJ0zvEieIanU83N7Y2Y20AU1ytn8h26IYZQTFBcskDdW3vyQVDqQKpRssZ/2QbExVWbRWEe7wR4suyE/jSI28O0iMrWG0zjczD+2wWT3zcWP5qbXnYLF9cMdW1nB/3WT2ZCkQmENlqK/rn1hJMh+oqB1j5M+XygC6E7edD/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDDjy3uQlV9l6uRAu7IB1kscsP8bx0y+afivjb6R6nM=;
 b=Wo5yxEWSDHsDdKFCTePjCremaLdVjv2xNLC53bIpIZ5/2uRTig9r69ChJpK3rySdbz1f/6sbR/Zr0uJjJuTwG34elp/oHj1Efv24nM2+nJcvrnydjREFloiMQWbqW/HX3tl7ijV+pMRrTICkm628zfUR1tILqSnfhourzziKxskNqKnuEzo313zpF7Y1A7DWWe8yeTsU0u3V/2/X+6Qaz+O5Gck9evKdc5ZY3ot/yZ2kdYgq/WTxE090ggTC0XmIr/Ct0F1uoHlhG8JH56qvXaQ7AG9/aEK9af4IUG0haEqJH3Nlj1++5i3L0BaZGOEem7K1G0a2QUL1+edXF3dXLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by LV1PR11MB8818.namprd11.prod.outlook.com (2603:10b6:408:2b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 16:28:18 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 16:28:18 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "Huang, Kai"
	<kai.huang@intel.com>, "bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "dyoung@redhat.com" <dyoung@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sagis@google.com" <sagis@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "bhe@redhat.com"
	<bhe@redhat.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "ashish.kalra@amd.com"
	<ashish.kalra@amd.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"Yamahata, Isaku" <isaku.yamahata@intel.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Thread-Topic: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for
 bare-metal in stop_this_cpu()
Thread-Index: AQHbk0LE9xNDz/BUxUyAtvW7JgE+xLNxaCeAgAFYMICAABVLAA==
Date: Fri, 14 Mar 2025 16:28:17 +0000
Message-ID: <d7805e17b7f09b08384406168571d1bfd019b77b.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
	 <e9ee3c7ffc3ba6feb97247faa40789684e39ffd0.1741778537.git.kai.huang@intel.com>
	 <e0d9a3d599025c92fce5e159e8acc1af32844912.camel@intel.com>
	 <e7adcb16-ff6c-d901-155b-866be4de2d40@amd.com>
In-Reply-To: <e7adcb16-ff6c-d901-155b-866be4de2d40@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|LV1PR11MB8818:EE_
x-ms-office365-filtering-correlation-id: e36080fb-3886-4658-7f02-08dd63153a44
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OGM3VVkyYTRWbUVkWFNYbXQ1dkZQZ2lJNTJ1eHdVZzdnM0drajlRaTJPVTJs?=
 =?utf-8?B?RmZ4Y3dUa3BaZlBkQ0JQMXhVNEYwYWJmV3ptMys4ajhaUE1xUlIraEpQWnZx?=
 =?utf-8?B?UkgxZzk5bHVZeTVvUTkxWlR1SEozWTdFakw2b21HL3ZQUFVIMU5BQm1IT0Rt?=
 =?utf-8?B?N1lZdlhVaDVFUHVQZ2JpcFcxVnJNS2lSeHhkblRYdklJaERMN3dzQnFacXJ2?=
 =?utf-8?B?SFVwRGIrejB6SjNkS0pURXRlUlNZZUNPNXlyT0pENVVHZHJVb21zdnBFeWhV?=
 =?utf-8?B?MEd1MzNweTBNNzlCaGhNVlNlbC9ydk9GTmRCMDFFVVcrTm01TUl4Zm5wajg5?=
 =?utf-8?B?Ujd1N202UmRYZmhOQVZBQndpdGNNdXBkNTNUcXpGRWFMTCtJeTB3UHYyZlZ5?=
 =?utf-8?B?QWExQmpHWlVkVlQ4aTVaQVhrcnZmL09NR2pmRDZENE85WGtqUnFySkRxQS9s?=
 =?utf-8?B?eE1ZYnQwWVRYSkxqLzJDZEtwVit6VG1jRmhXbGZRQjh3Wi9kSWtXTTBTMWJL?=
 =?utf-8?B?bmVnb1dXRzJwcVk0VTJLL1ZUbS9wZ1QvK2VnWkpLWGhGekJjWStBRVFJZitD?=
 =?utf-8?B?MnM5akcvM0tBRUdhTU5JanJtaTdCRmtncEx4QmZXdG1objU1eGlVRU5TT0oy?=
 =?utf-8?B?M25hOWRQRm1yMGpBWGZ5YnYrdjRZc3ZyS09pY2oweUdBZGJ6Si9vNE5VM3M0?=
 =?utf-8?B?V2YxM2phMXkxdnZweUhETE02dlNrZ2hVMGZXUy9aR21pb2g0NjNMVk1ISyti?=
 =?utf-8?B?WWNmZjZSQlBLK0N5L1RnbUZHcjRqRDJkYkN6UUJVSi9NOWJCemMrZ1BWWGdD?=
 =?utf-8?B?bzk5TFB6b05mZXBQYjFwdGFqYlVvOVdvbHc5amUwc3YzSi9kY2phRUhyZStM?=
 =?utf-8?B?OC9lYWVTQ2puUXJVdzMwYStMU1ljZTBkMjFoSTJBS0Q5Y2ozajdwNERYODFz?=
 =?utf-8?B?SjJWOW11MVZMejRORjJ4djNmRDAvdi9hdWpldDBHd04yWHB6R09SVVpGTTFI?=
 =?utf-8?B?YXBCYkQ1T25MNmJCbDVpSTBOSkpwc2JEN1YyMnNKR0pKWGNBYnBFcDl3K2tY?=
 =?utf-8?B?dmtKQWNyRWxVWk1zR3EzbTR3Skd1cjdJS3JvNDlib2hBczB4a0NKQnA4N1JX?=
 =?utf-8?B?NTlOb3VCVFVvbzRyU2ZCbU9leFVVSlVWWjNiSHViTU56Y1lTemhSa3ZpSUZD?=
 =?utf-8?B?M3E4Mk1sV1RTc25LOHdJOWZUZ1RQNkxZeUJBNkhNb2gwR2FsMFRtLzB0eVMr?=
 =?utf-8?B?WU54OVdNbFpGb0hTMlZIejNqZ2xnOWNZZjRDVENFeWtWQ0RXY1NqdUcwalox?=
 =?utf-8?B?cmRueXloVis5cE4zVFpZSTUxdDU5a2JPeWRzU3hWN25tNVE2dTh2ZGl4a0t5?=
 =?utf-8?B?RFUrRXdMOGZZSjgyOWhKVXlNUStqWlEybnpud3NVTXlFWkRGZ2NSS29uMU1t?=
 =?utf-8?B?cEJLOFJ1M0ppTjNNZTVWcTJJWWZjODVvQmlGQUN4U2FpcHRkZ2lncG85TXd1?=
 =?utf-8?B?TGJoamU1VGFCRmdpUXd3Q0pFNVBiVDFObU5SQml4anVHMFI0WVV4KzZXT2xs?=
 =?utf-8?B?Z3N3VHI2bzQ2S09VZ3pRdVE0OHRiSTkzNW94U1VjWlhQSWJRNDE4blp6YWN2?=
 =?utf-8?B?b3I1YTVTZU1OY2JOV1hzMVJLbUZlVHd4TnF1OWdIMHNodkZSVG15amRDSG5P?=
 =?utf-8?B?TUh1dkdsVnRaSHI0ZFVWYnBrQVRvbW45TittK1dyYm01VlZhUCtlaXJFQzJK?=
 =?utf-8?B?TzJyL3M2WXpHd1lMb3JrT1pGVzlpNGxNdHprQ25jYzJDN0Y3N2ZWa001bFlR?=
 =?utf-8?B?M3ZKSkk5RU5EVjN2NjEvQUpWaHVFSXZVbnNLWGRLNWRjTFpKYkthUHF0Sjcv?=
 =?utf-8?B?SnBjOTFXRCtjVmJUQ1o1bDhXTkxyeC9yZ0JVR2QrWEw2c0FaQWNQbVRuVFVV?=
 =?utf-8?B?c1p4dVpOdWhmK0s4THNEdUhkQ2J3UnNTaFFFUVloVFNvNG1PMkNHUXVQZDNS?=
 =?utf-8?B?WTRmb0JDZFBRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWo2VkMyVzRMdm9LODdiejVTK1VVWUFCa254Y3B5VDRGdXBIamlQSExQVDRJ?=
 =?utf-8?B?NkIyWmlZNWdqczFVT0xDTHg1dTdTdW9mSlVLZWFTY0tpK0JHOGRHWnVCNWti?=
 =?utf-8?B?RTRpdHRtdCt3ZGlNZ3ZYWHg1dFZZWVFEWE13c0tIVk9CL1RTeE5SYzZoR1Iz?=
 =?utf-8?B?TUpiYWFXeWZwZHhPL2FpbnpBM0Z3aXU2Y01PSG83ZFI2RzJEbWwxK2FTaEZr?=
 =?utf-8?B?NVN4ZFdjM3lzU3FHYVZLYk1nNExZbTcxV05KTlRCRWdFMlZqSmhScExucFhm?=
 =?utf-8?B?U0tqNVd3ZWpCcGljR2xPS2ZGWE9Xb1BrM1dVem8vYlQzYzUzOFQyT29MWVg1?=
 =?utf-8?B?Rk1iRS9mZ0tBMDB2UmwvSzR2Z2hkSnVIVVltSXpTZWxDRXNpN08xQ0J4cTRC?=
 =?utf-8?B?Y1l5WnVLZzdWeFUvc0F6STZ6Q1RncFZzN09lSE5wRnFPTEdleUp2RGdmbkps?=
 =?utf-8?B?UEZKWHpXeThVQVVIS0VRdXUrL3RTT1lDei8vYUE5eFYzNnlZY1Z1VnZJeUhS?=
 =?utf-8?B?NnFuWUJzVXlHYk1Kd1d5ZFlnb1Y0ellzNHVOdis2T0FoWGlhNGc5RExQVXc5?=
 =?utf-8?B?VmN3QWIxZnY2OXNIUld4TTFERjJFZ0c4eFJDR0c3VDNrdloyME9MUUlWeXUx?=
 =?utf-8?B?Vk92eDRuQzVLazFaSHVCSXcvemF1bDV1R2J3dFBubzdRQ2paeXdxc2ovMGpC?=
 =?utf-8?B?alQ5VWpDMmluekNMZTBIZEZPbHdwTVd3eTk5eU1tY1BoZ1JpMnRyM3hEKzQx?=
 =?utf-8?B?ZUhlMGpUQlQ3ZkxkbzZZczNWSGdiRTlTL1dMVjNScjRXNEh3UkpMdUROU2dC?=
 =?utf-8?B?dzN5WWptSjB6dFgzcDJiNkFWaENnVWVJUUJJODFhWFV5UzI1VWdnR1J5R011?=
 =?utf-8?B?QjJNUGs0TGpWbk1PQVRkY0JKUlh5czRpeUJmeUJUUHczV20ySWR6dllJZ09Z?=
 =?utf-8?B?Q3pIcks3dTNwMGd1UjhnSDNqcVhFbzJQUFRoaTNNSUI4RWFTTXM4dXRPV1JU?=
 =?utf-8?B?bHhhVWRTYm15Umk2dU1SMVEvalE1aHFKVjNaMFZ5RUpwcWVRdkVsYTg2TW0v?=
 =?utf-8?B?OXR3bjI1WFdES0hVOHZ3SEhjY1pKL2ZiY2ZSWmFCbnI2OFNyc2ttWmJDVVJO?=
 =?utf-8?B?ckd3amMwL2lCZjQ2cXdyOGUrYmVUNzlKR1B6R3F5VVRzWUhCV21Sd1NWTVVH?=
 =?utf-8?B?YlMweTlEbjlFT0dJOTZUak4wWFlMVUhVb3o4ZncyMzFPYWZyd1NldURDNVVz?=
 =?utf-8?B?enh5bUJhZUhVSjhsNkNIeVFwY05xelV1TW5XODdjUTA2RVJ5ckFHRDFtSk01?=
 =?utf-8?B?SVhBTll0Y2RsL0ljdUdWVW1xR2R1VndYeGtOc3hTV1pnRWh5QVhGTVpWL1Ry?=
 =?utf-8?B?bHlYZjdxeGpnVDRzRHJjaUtoVFk0dGZyRlVtaTBGUVRpL2NrejZmam1hZDB6?=
 =?utf-8?B?dC9OQnV2SGFyUUtzOGxHWWRHTUpqTGNaTEdPNUROUzVURHBRNzFBMUFiOXFy?=
 =?utf-8?B?ZmNFVUNRRHFYOTlNMXlNYUhyZmp6dnBjNHIxL1c2bk8wV2ZZSnkyVmxoclhF?=
 =?utf-8?B?cDFXT1Bwbktmd205T05nakYwWFpqcFBwTFJpMW1uQ0ZLWVdWQ0wwQ3A5ZWFl?=
 =?utf-8?B?SGtYSzFxYzBiTmRuMWV2b3NoN1hvSjByejR2VjFPYjMzVWp3d2dhQWZwZ0tS?=
 =?utf-8?B?WUFtTVNvQWtpM2hWajNSQXRRenlEdFpkb3MrYUUxVzRGR0JOeitCcnJORG1M?=
 =?utf-8?B?VlRsVS9aVmVTRkxEeVp6eXR1T3BaSjRnYTZ2eVFPNGFJMWpYNEsrczJGVkFX?=
 =?utf-8?B?aTkxd0ljdFZKL1BvYVgvQXFodDFHSGRzNGtrbWZvRXhiZ05PWE1aOU9zKzBP?=
 =?utf-8?B?d2dZSVhVbWs0dy9QYnhENkJFdU1YRnFNeW9WaTU5cW1mSmhFbjlLRG1iQ29R?=
 =?utf-8?B?YjlZQ1NXSUhuc3d5QVZEb2RDN05KNlR6LzNOUUl5b2tnaXVuQmM2SjEvOVcx?=
 =?utf-8?B?N1d4TVZ0czl3aHlPSytaekJCSEIwNzl3NWpBa0g2OXBnKzhWeHBTQU1NN1RX?=
 =?utf-8?B?TUtmZ0dWT3NKUlhNMGJmdEJQdFhUUGNuU0dWUitxK2ZoVTdRWlNtVGt1R25H?=
 =?utf-8?B?amVmYUJPQ3hBaEhMK1RGVWhRUFJYVUVPd3JrRGpvclJJalJCQUZNOFFPSzFh?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91AAD22DDD39194F8611F0864524AA91@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36080fb-3886-4658-7f02-08dd63153a44
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 16:28:17.9182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjr0oyk3+GF71lrVCbkDvZbaeEiXVJ1wP/GKTSE1loqxqxK8oETzlEPfrsAxzHPV9E9H5FczmHyLgTS9BUdYsFA2F2kL6XVix5W5AB0YujQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8818
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTAzLTE0IGF0IDEwOjExIC0wNTAwLCBUb20gTGVuZGFja3kgd3JvdGU6DQo+
ID4gSSBzZWUgdGhhdCB0aGlzIGFscmVhZHkgaGFzIFRvbSdzIFJCLCBidXQgSSdtIG5vdCBzdXJl
IGhvdyB0aGlzIHdvcmtzIGZvcg0KPiA+IEFNRC4NCj4gPiBUaGUgb3JpZ2luYWwgU01FIHBhdGNo
IHRyaWVkIHRvIGF2b2lkIHdyaXRpbmcgdG8gbWVtb3J5IGJ5IHB1dHRpbmcgdGhlDQo+ID4gd2Jp
bnZkDQo+ID4gaW1tZWRpYXRlbHkgYmVmb3JlIHRoZSBoYWx0LCBidXQgdG9kYXkgaXQgaXMgZnVy
dGhlciBhd2F5LiBCZWxvdyB0aGlzIGh1bmsNCj4gPiB0aGVyZQ0KPiA+IGFyZSBtb3JlIGluc3Ry
dWN0aW9ucyB0aGF0IGNvdWxkIGRpcnR5IG1lbW9yeSBiZWZvcmUgdGhlIGhhbHQuIMKgT2hoLi4u
IGl0J3MNCj4gPiBuZXcuDQo+ID4gOSBtb250aHMgYWdvIDI2YmE3MzUzY2FhYSAoIng4Ni9zbXA6
IEFkZCBzbXBfb3BzLnN0b3BfdGhpc19jcHUoKSBjYWxsYmFjayIpDQo+ID4gYWRkcw0KPiA+IGEg
ZnVuY3Rpb24gY2FsbCB0aGF0IHdvdWxkIHRvdWNoIHRoZSBzdGFjay4gSSB0aGluayBpdCdzIHdy
b25nPyBBbmQgcHJvYmFibHkNCj4gPiBpbnRyb2R1Y2VkIGFmdGVyIHRoaXMgcGF0Y2ggd2FzIG9y
aWdpbmFsbHkgd3JpdHRlbi4NCj4gPiANCj4gPiBUaGVuIHRoZSBjcHVpZF9lYXgoKSBjb3VsZCBi
ZSBub24taW5saW5lZCwgYnV0IHByb2JhYmx5IG5vdC4gQnV0IHRoZQ0KPiA+IGJvb3RfY3B1X2hh
cygpIGFkZGVkIGluIHRoaXMgcGF0Y2ggY291bGQgY2FsbCBvdXQgdG8ga2FzYW4gYW5kIGRpcnR5
IHRoZQ0KPiA+IHN0YWNrLg0KPiA+IA0KPiA+IFNvIEkgdGhpbmsgdGhlIGV4aXN0aW5nIFNNRSBj
YXNlIG1pZ2h0IGJlIHRoZW9yZXRpY2FsbHkgaW5jb3JyZWN0LCBhbmQgaWYgc28NCj4gPiB0aGlz
IG1ha2VzIHRoaW5ncyB2ZXJ5IHNsaWdodGx5IHdvcnNlLg0KPiANCj4gQnV0IHRoZSB3YmludmQo
KSBpcyBwZXJmb3JtZWQgYWZ0ZXIgdGhvc2UgY2hlY2tzLCBzbyBldmVyeXRoaW5nIGdldHMgZmx1
c2hlZC4NCg0KT2gsIHJpZ2h0LCBkdWguIFRoYW5rcyBmb3IgY2hlY2tpbmcuIFllYSB0aG9zZSBz
aG91bGRuJ3QgbWF0dGVyLg0KDQpEb2VzIHRoZSBzdG9wX3RoaXNfY3B1KCkgcGFydCBuZXZlciBj
b21lIGludG8gcGxheSBmb3IgU01FIGVpdGhlcj8gSXQgbG9va3MgbGlrZQ0KaXQgd2FzIGFkZGVk
IGZvciBURFggZ3Vlc3Qga2V4ZWMsIGJ1dCBpcyBhIGdlbmVyYWwgQUNQSSB0aGluZy4NCg0KUmVn
YXJkaW5nIHRoZSBrYXNhbiB0aGluZywgSSB3YXMgbG9va2luZyBhdCB0aGlzIHRvbzoNCndiaW52
ZCgpDQpjcHVtYXNrX2NsZWFyX2NwdSgpDQogIGNsZWFyX2JpdCgpDQogICAgaW5zdHJ1bWVudF9h
dG9taWNfd3JpdGUoKQ0KICAgICAga2FzYW5fY2hlY2tfd3JpdGUoKQ0KICAgICAgICBfX2thc2Fu
X2NoZWNrX3dyaXRlKCkgPC0gbm9uLWlubGluZQ0KDQo=

