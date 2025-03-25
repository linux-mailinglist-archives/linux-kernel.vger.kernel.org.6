Return-Path: <linux-kernel+bounces-574765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924EAA6E99F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC65A7A4DBC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B5C1F584D;
	Tue, 25 Mar 2025 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ncg2En6Q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B246918FDB2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742884343; cv=fail; b=QWSAVaOuDiwRS+rfzOOF7A0GEiBRzPeSfJqVPzZHWncELS00i+wWAv4HizOnspjyunJEW2+NJfLyutqJ0jU/UfdL/0qOOxOoeZy6rlF2xcUASNBp1ybw7fnxo85X+2wVGYAHTA1wTn/7gSEZfjqMjpzL9I6VkKalnaRf2PCwhFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742884343; c=relaxed/simple;
	bh=9vVpFKDD8OKR0nKyCKi+UHKeOz+PAe3/qzLbAHm7EHI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bXHwH7oM9uniwNgEErE/u18/CYK0hIpP/+m9vpKxhbh30s+5cPA/JkzOzfLTRMT9QVYD6c6zA8KCvPO8FKzjxed4pNSzhq3AeIFRrxBiQjEEZtGY82MxD0Ha+Ej+7DIk3eFbf+1ylcaOgUT44viwbgBpO8x9JrD/K3I4O/WqIos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ncg2En6Q; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742884342; x=1774420342;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9vVpFKDD8OKR0nKyCKi+UHKeOz+PAe3/qzLbAHm7EHI=;
  b=Ncg2En6Q4JBughdydY06ELIiAYCmO+TI4D6CiNKsK2d1VopReCLNy2gn
   /9NHLmEFFRJyO9eBrtt8vQzfS99sBfqcKkRRNxDvr8voOsT0UAI3H4V52
   OaGQR5n7qWvGVVBggoYyNM3h+GOvXL7ucRMocH3YsVNTeXFikSjHPcNXa
   9PTgSWdqLyQAEwGvSdNumR4O62ACQp00QGpEjfB5+5Odb+7HJrSgF4AEV
   y5tDgEhCJBljaGZ0qie8QOONmqMHzNJjJro9ilub7wcIJrpfxK6VDEn8N
   IVlcDStKG5Xi7J5HW1NkOY2Hbnbj9ZqvxnUke4xjLAq0pWANL+w4XRaRF
   w==;
X-CSE-ConnectionGUID: PeSMMOevR2ynT0DWVjEH5w==
X-CSE-MsgGUID: SK8e5tuoRwCEklaHS3RkAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="66573334"
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="66573334"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 23:32:21 -0700
X-CSE-ConnectionGUID: V5VNPdMJR2i+1PXUk1vWug==
X-CSE-MsgGUID: MlevDWTmTQeqvukbN9vYEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="124805366"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 23:32:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Mar 2025 23:32:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Mar 2025 23:32:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Mar 2025 23:32:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uv/ZFPwFrOC6taPZ3yeSjwR7TUv1dbjNhwxjSUS5i/cwnfiWWWZBiJbsU9VG4ooUn8IggY1XQSR977bAkXzwz2YNVgzi7FVkcvUwFPe8/iuijogPL5p+utVr89SFFqxTiPjiFgfdeII+oZVybXC7/asq1ilhPsfPAuy2mG+4ERQGsrYKmR9Ek/9kX2jzWB8zI/ax2G3PbrhJA/1vmtWJU7MArNTMJl7RjiEML3odOZAO0qhLjp52eoBl5u3fmSoLpuMzouoDRxBHRBI5+HTzm8ZjiP/P6Su3be+bd14wJv4qGvy8Ydv2Bxc6qVZ+rfhwt/tzigc0vkIYhU2Wp8gKAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vVpFKDD8OKR0nKyCKi+UHKeOz+PAe3/qzLbAHm7EHI=;
 b=LEbmT3ZmpsxGyF+q2we4yyQ0J3inW74l1bhYwsWgwsQEhhprqZCW4EuQ5+c/3Tk/n6XNbJ8o9i8uWGnSx3M+pv8QEGL7g5OwBr9sp2hIfT18nBsD8f/KYEdSCdS+8q95Dh8FbnY4XXdG05YmtrOgwkz107PK8QKTXNBX1OcYGZpDT2kXizKBmluDFoeGoj0lkFJcWhIYVh7jEJGqzq2nVxU3bxj/0GwqI2hu+Vvhx3tBMoM9x08oUkuvlItj0XHRU582clJNJ34AohkNQZdTc4wpgNR3H+6krAE4s0zARr2OLGKf6/9sFcH+O2V1d4o4yHTGrMWO3A8tjQZkAUpyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH8PR11MB6777.namprd11.prod.outlook.com (2603:10b6:510:1c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 06:32:18 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 06:32:18 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Huan Yang <link@vivo.com>, Hillf Danton <hdanton@sina.com>, "Christoph
 Hellwig" <hch@lst.de>
CC: "bingbu.cao@linux.intel.com" <bingbu.cao@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "opensource.kernel@vivo.com"
	<opensource.kernel@vivo.com>, "urezki@gmail.com" <urezki@gmail.com>
Subject: RE: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
Thread-Topic: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
Thread-Index: AQHbkxY+HILoU9IAJUSnMFDe4wG37LNvBwAAgAeW2gCAADb4gIAABrQAgAAegYCAAYMzgIAAGcKAgAADsgCAAAG5AIAAAXWAgAABrgCAAVLqgIAAM6uAgAA3UICAB0DwgIAB06rw
Date: Tue, 25 Mar 2025 06:32:18 +0000
Message-ID: <IA0PR11MB71851C5EF8BC5BADFD5A5D79F8A72@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250317055304.GB26662@lst.de>
 <5a12454c-16a1-4400-a764-f49293d8dece@vivo.com>
 <20250318064805.GA16121@lst.de>
 <5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com>
 <20250318083330.GB18902@lst.de>
 <bcbbc2e9-858f-46ed-909e-1d911dd614f0@vivo.com>
 <20250318084453.GB19274@lst.de> <20250319050359.3484-1-hdanton@sina.com>
 <20250319112651.3502-1-hdanton@sina.com>
 <752e606b-640d-46d1-a8e0-fa714b29a7b6@vivo.com>
In-Reply-To: <752e606b-640d-46d1-a8e0-fa714b29a7b6@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH8PR11MB6777:EE_
x-ms-office365-filtering-correlation-id: 75b1ca87-a6de-4697-609d-08dd6b66ca7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-2022-jp?B?cDVrUjRmNXlSVVgwbU43REhoTlJPM0VFZ0xoU0JNc1JqVER1L2xyMW5J?=
 =?iso-2022-jp?B?VXVmY1JJUlhBRmVGMmQ5dkJ3UXk5NkV2NTVTNjAxVTBvUER3MTNYaFZl?=
 =?iso-2022-jp?B?T0NYYldZNU5XVEJSVGYwTVlVZ1Q1dVg3YklOb0QrQjZOQXk0eVJwdTI2?=
 =?iso-2022-jp?B?Q0tCdG85MUw3dEdvWGI0TzN6TlhDZVNITG5LOHY3OVZ0YVF6c3BOWVlP?=
 =?iso-2022-jp?B?WDBtMXRPVE16MnVTNk9paDFZVmV6S0R3T1BUOW05a3dLdWYrNDhaS2lr?=
 =?iso-2022-jp?B?VnZwbUE2K05SNi9EeU1EdWp1NEplOExpbkJQM2xqd0dpQ1pSODlnU24w?=
 =?iso-2022-jp?B?Z09KTmRvRGQrb3pWaGNyNlkwTmZUakYweEdFRktCMnNKSjA4VnZMb3Iw?=
 =?iso-2022-jp?B?cnJ6Uk8xMUl2OEtObUZEWlU2dFF2a3dWMHkvTkxkRUJ6Q2FQRytDelFw?=
 =?iso-2022-jp?B?WFliK21STzFyL1pxN2xkNVZkMW1RYjdMZUVYcUxvVllLNG5FMTZTZXdr?=
 =?iso-2022-jp?B?ekExblgxQWNrbDB3Z0hDZzNCNDlNSU1SYWxkTHNFN0VmdGFFMndxSlJ1?=
 =?iso-2022-jp?B?WWRvd2pVRjFRd3JoZUo2Q1NOTk9KT0RKM0lvSktEcXF2eDhVSkdIazdw?=
 =?iso-2022-jp?B?bVdTUjZIdmFTbmwyei83ak1SamVoUXVweU1OcSs4cGJqcWg5T3MzakFB?=
 =?iso-2022-jp?B?RTg0L3RUK1pROHEzbnBWMEphV01QNFg0cW4yblBBMlJOd2xBczV1ZjdW?=
 =?iso-2022-jp?B?cGMrZ0xFYnljTkQvOTd6SlBqeTkwMk9rWGZoZUV5bTBDVFpSNEIyeDQr?=
 =?iso-2022-jp?B?Ri9neW9zeVpiTDdOa0lLaTFIUXUyRXpnMmo3Tm1POUQ3K2dIVjN6VTJ0?=
 =?iso-2022-jp?B?MnB1YW5Xd3ZRa0FtdXFZRmZIeURDeGN0S2dueCtkcWlqY1o4b1J2Tm9r?=
 =?iso-2022-jp?B?S0t4NUswYi82RHpYbEJrL0oyaFQwUUI1MitRK1Rkd0VUUHVoWjFaTEl5?=
 =?iso-2022-jp?B?VVROejVHRmlTMzBYUXZXRU93UTJuYkRYSUJOVWJFclRodExsRExMeng5?=
 =?iso-2022-jp?B?aHhmYVAvbDVOWlJRYStFQi9BRm9yZ0VBc0UvVUVETWYreFBRZXR2SnZN?=
 =?iso-2022-jp?B?dzJLM3hNN09KZWpWMGZrTFQwaDczeEpIdzluZVRwTStrUmZMT05LOFVD?=
 =?iso-2022-jp?B?dkE5aXNEZ2UvZ0VWSEozZTdmMW5uZ0Q5R0U0WEJHcFNTWm5UUzlaZEU5?=
 =?iso-2022-jp?B?dTVsZGtLcFlqc3hRdXZNdDdrNGxzdUFaZFBpREtIMG5lMzJvSlJKYzVK?=
 =?iso-2022-jp?B?eExiRVZ4MmhvU1BmL203K1NjeGJHRjlYWUlvZzE1MUJualNBUUtUMGsy?=
 =?iso-2022-jp?B?Mi9aZE0rWFhPSyt5V3dVUTV2Rnl5ODEvQWhtNzh0eWtEcHRON05BcE1K?=
 =?iso-2022-jp?B?VFpVazB4VFE2OFdHemJRZmUvL1Z6SWM2eWl1a2pNMFh6bWYxa1NWa3V0?=
 =?iso-2022-jp?B?SlJjWFFiMzNndHd3MTlVQ0hUQm4zb21GT2JpK0wzZ08rdERpNmRXTVRq?=
 =?iso-2022-jp?B?MHFjVHZIYmxOb1NHcHIyb054WGtocGtDbHIxaDBaVy92Yy9QelZKR2Z1?=
 =?iso-2022-jp?B?NG13YXJ3alAwQ0gyR1ZaZkptMDcrdG00L0tRN1dqaEcyeUVmUEhxSmYy?=
 =?iso-2022-jp?B?NU5BdWNWVlR3Tnd2Z1lid3hDQVc4WmQ0dFltVDdUMFFMMFF5M0xmRGRC?=
 =?iso-2022-jp?B?N2N1OEZHakM4aE9qR3d6VCszM3ZDbXM0K3dPeVZtb21rMGg1cklmWmhw?=
 =?iso-2022-jp?B?N1EvL0RZQ0JRSGszRjZEWUVSOStWemFUaGMrUXlLNDZzaGVmNS94MFZO?=
 =?iso-2022-jp?B?M3JHQ2ZxTDdOU2d5SzdneFZJaExEMWRlVHRXT1p6YnlRa3BDbzcxMHdo?=
 =?iso-2022-jp?B?bTdBNnhUSkpnZVltTFZSVXd2NElIUi9ZcTNuYUJ0TGRCNXlHd0h0OUZR?=
 =?iso-2022-jp?B?OW5IWGhrTnJKZGhuZXFJK1N0UHMybWkybERiblJObG5lZmI4aUF5M2p5?=
 =?iso-2022-jp?B?YW14S2ZYU1l2ZVlQQTVBUWFhYjE0aUJmeFIybE9hV01wL2gyRmo1cGZ5?=
 =?iso-2022-jp?B?VEk=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?YjJUbVlHeCtYcUtLdkRtWlNYeTRuUW5jYTRYU05YMHFvdk1CTGdTQzR4?=
 =?iso-2022-jp?B?RFU1U0thMmVyK0d0cWdjZkZieEZ3SVhJRktINHZVR0t1R0tGWTRETGRZ?=
 =?iso-2022-jp?B?WExma0JLRjBEdW1VYVY1YVZZbHZxSm5TZnFPalJzWU5pdlFlRzZaQ2Zr?=
 =?iso-2022-jp?B?ZzEwb3VJeGhMeHVvbXZoTzlNQk1JT2xJQm9vL1JQZDVtNkhkSTRjZ3pM?=
 =?iso-2022-jp?B?NWkyZkI4VUduRmRuTi85NzBZZE1IVlc5Y0ZUTnN4bU1INEMzZXQ2UTY1?=
 =?iso-2022-jp?B?aHJXRTJ6TVR4MWFvNWNjNEFnN2d4T3ZWeG5NeTdFWkJFRWQrODh4TThn?=
 =?iso-2022-jp?B?RjEyOFpwUEgxNkdCOEZpdEEvbVlVSldpcmtXMzdvb1p4eHB4RGUwaldT?=
 =?iso-2022-jp?B?QlhaZ1ZsSnhDeDRpOVgxbjgySW4zUzAySGk0aFp2UUQyRm1IdEpSRlNn?=
 =?iso-2022-jp?B?WXowOXcxd1VDVkdMblhZZDJTZ2gvaHJiWFByZzdMT1h4ZTlETHM0N3lz?=
 =?iso-2022-jp?B?aysvdzVGWityVFlZSCtNdzkrTkVSN3hndGhXbXRNMndBR2JvY2t6T0cw?=
 =?iso-2022-jp?B?aHJkS0prU29HU0FjT1BHWVZvZ3NKdlRFNzNlL0VNc00rVktob2V6Smw2?=
 =?iso-2022-jp?B?NzJvTnhGbDVXWkJIQTg4UkczN25xMTlTcjZPLzJpMVFHZ3hsSDhDS0VH?=
 =?iso-2022-jp?B?bm9QU2JWdzFMUWJzWkZOR2htZmxPMGtzZ1VUQ3QvR0x4N3VIU2ttZTlz?=
 =?iso-2022-jp?B?ckh4Z1lLYkhrTVdZN1lUYVg2alRBUGNqRmRYdUl0WmUyR0JFWWxNVS9U?=
 =?iso-2022-jp?B?YlFra3J6SlBKUUt6WjV2ZGZpNE1uNTYvV2U5L3NXUEhBU203QnIwbDBl?=
 =?iso-2022-jp?B?cmk0VHNnSGl5QVpLNkpjSmxmaVJWUGhlN0pHVHdGZ2dTVFdZcW1BT29M?=
 =?iso-2022-jp?B?RWJCTXpiZ0VLdDlHaUI0SVlNbjd2SThYV3VmMi9aTVB3TythZ0ZNZnpZ?=
 =?iso-2022-jp?B?cENHbHR0R0JYaVVmbXROWmxZNVFrM21UZUNHZEtJdEpZc2NtT0tnSDU0?=
 =?iso-2022-jp?B?SGpYUjdSbUdoMVkwaU1Db3BOUkE5dzgzVHVxa25PVjRoRUYzZUlEZTAr?=
 =?iso-2022-jp?B?YzhETmhVZU04MDEzRHhTVW5oRUkyWlZqRjF5QVFJQmFod3RPK2xmNG8r?=
 =?iso-2022-jp?B?Q0ltRUttb0QxQm0wNHk4ZFlsSDNxS1dlUGRKa2pEbTExNmxpMElYRVg4?=
 =?iso-2022-jp?B?STFlZUVFOFZtWGhMUjJEVTlZdkRmOE5zbFRZV2VJZXlqcjZyLzBoSFhu?=
 =?iso-2022-jp?B?VXljWkppdEkxRXFGdU9KeUtoaHAzWFZqQ1p3eFpQN0dCQmpReVFRWERH?=
 =?iso-2022-jp?B?UE1veDU1MWxIeFBKbk5EWXdRUVp5WDNnOWx4aDYwZTE0N05oaG1DK3dO?=
 =?iso-2022-jp?B?QldQM0pTN0dDSk1QOUFvUEZWYzNMU2lNS2hiaHVTbXlrUHZ6Vno1QkV2?=
 =?iso-2022-jp?B?eGdINmZEL1RyVFNwMDMxRGRpOGY1V09SZjMyZWNpU203dzRSOFROb2Y0?=
 =?iso-2022-jp?B?b3ZpLytVdlV5d1o3c2ZwN0FLOTlkSUQwZGdZbCtxbU5BMkQ4T1ZVUkt2?=
 =?iso-2022-jp?B?UW1TMEthVWp3VUI3bllJeVVyU3FnUHNLWFpEdzg4aG1QU2pOdUdMQXVt?=
 =?iso-2022-jp?B?RW5IbzF0NURKTFcvODc1bTFhMk51VEw0S0F5RVJvMUhZc2pSNk5QUU1I?=
 =?iso-2022-jp?B?UkxrN09xT0dZVHhPOHp3YU92R2VrSUVBS0VFOVU4SmgwMGpZQ2pjVi9W?=
 =?iso-2022-jp?B?cGtkbVhjeTJzOUk4T1QvcmEvY2IxYU5iazdpZGZVVHV6NTlza1cvL2h6?=
 =?iso-2022-jp?B?WlhsM1prSzJVZDlnTm1Zc2RSeGllYTNaV2ZhU2JvV200LzM4QUlsU3dJ?=
 =?iso-2022-jp?B?S0duVWxFU2MrL3pFQTh3d2ZFeWxtOUdaaEN2aGJQdE5aZXUyVTRYUEJP?=
 =?iso-2022-jp?B?WDV6TEYyWFk2RzMxbXBJdTZ0bU44WUpiSkwra3RLT1BTZGhETGZJWWxK?=
 =?iso-2022-jp?B?cWtzOTJpdklvSFl2NzBUcnFER3NoeFBHUjJCUmxDU01IUllmakxoZlhs?=
 =?iso-2022-jp?B?dWhJMldpUk50VTlCUXdqSThsOUQwdGhxUzFxTE9ZODZMbE9LZkp2Zjlk?=
 =?iso-2022-jp?B?UklJV3ZqVk1lNnJBbkVUcUo2WjZqU3RrMERrcTcyVDl1b2NmUERyVklT?=
 =?iso-2022-jp?B?bnRHNkp1R2UvUXlEVUhubDgzR1BOMUF5N01MaUF6NzVTY0xYcTRDOGQx?=
 =?iso-2022-jp?B?WnJMVA==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b1ca87-a6de-4697-609d-08dd6b66ca7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 06:32:18.4260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iY+HKtC6+9LIMSn6htSsR6MPRfx/MGIPkd+N8adUomvTttTAFAmZ2wipUTr1g24/DttoGSsHQdU3Uva8Mzyr/a3pim1qUjWKUbr3pBVqH7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6777
X-OriginatorOrg: intel.com

Hi Huan,

> Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
>=20
> HI Hillf,
>=20
> Thanks fo your suggestion.
>=20
> =1B$B:_=1B(B 2025/3/19 19:26, Hillf Danton =1B$B<LF;=1B(B:
> > On Wed, 19 Mar 2025 09:08:51 +0100 Christoph Hellwig wrote:
> >> On Wed, Mar 19, 2025 at 01:03:55PM +0800, Hillf Danton wrote:
> >>> A quick fix is to add a vmap_pfn variant to walk around the pfn
> >>> check in question, like the following diff (just for idea show).
> >> No.
> >>
> > Patient to see your fix, given no low hanging peach left for Mr Folio
> > in case of HVO, (feel free to ignore, who is likely about 2.6-mile
> > less tough than you could be).
>=20
> I now believe there are two way to resolve the HVO folio can't vmap in
> udmabuf.
>=20
> 1. simple copy vmap_pfn code, don't bother common vmap_pfn, use by itself
> and remove pfn_valid check.
>=20
> 2. implement folio array based vmap(vmap_folios), which can given a range=
 of
> each folio(offset, nr_pages), so can suit HVO folio's vmap.
>=20
> 1 is simple and can fast fix this issue, but may not too good. I need dis=
cuss with
> bot Christoph and udmabuf's maintainer.
>=20
> 2 is hard, but may worth to research, which I also will try to do. :)
Another option is to just limit udmabuf's vmap() to only shmem folios but I=
 guess
it may not work as expected if THP is also enabled.=20
Bingbu, what exactly is your use-case? Could you please describe the scenar=
io that
requires you to use udmabuf's vmap()?

Thanks,
Vivek

>=20


