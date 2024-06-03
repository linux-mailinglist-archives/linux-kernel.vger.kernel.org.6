Return-Path: <linux-kernel+bounces-199263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA00C8D848D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904CB2884F8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEBF12C47A;
	Mon,  3 Jun 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SakutXld"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B1222075
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423359; cv=fail; b=Xhnd6MPnP+PR1iZAl8Pzu55CZxcpspNZ4+iBsTE12P/eGeT+mNSQW9Fj7woV8Hf9G5URcI92W4NONFgLIbW1J8Ci3Xf4/kR8aUGbMg+d+VDsGgvtehVJMjuYlxHTl3XaghmsUC+F8FymcfKcPhTAyQmb8+rnDuQMhisSi2eZtng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423359; c=relaxed/simple;
	bh=IJ8i+l49UiG+YwjFwJlO21XAaxyalzSe2Uhv2QwYqZg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GbZlf7LKuOCw/DFtmyxNDgJauMJXnopE/azgZeqGtKhqA4eyu+EVzRquFOCCDlV8aNQS8o2MDvsg6nRrgGNjvmZ2NwWNx433AsirABBux6N5x/rRvpse0Wsa6sJz1WFqF8usu1IlFrPkrhAiNUTj07K+moNrHdSJAAv6SdMRtjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SakutXld; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717423358; x=1748959358;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IJ8i+l49UiG+YwjFwJlO21XAaxyalzSe2Uhv2QwYqZg=;
  b=SakutXldAxw21+6MYPhdW8lLGGYHG2ST5HXrcwedwptJt+m9f8s3BN3+
   0E7BDBhS8U2gdhN+5qupY7pE3UlIuCAEr0kzYUmis9BDZp4k4zlXfqmim
   Nfwv1H5d4uGlnFqaMYqOj1QdLWxVWdS9k9iY2i1BgNG1CbQRTlTtgV2ki
   4YDCXxzs53SUowTah16RCzOnjsb7z1T6Dx0MMljuMhnC1UlPdavBP7rF1
   4F+7j54eqoVVIFRCwWPg2phXzG2RSo2MaA2ThihV6ojFAsw3c6961X8mb
   CEaLJ44SHDtBiwbycfhDV9yiYER+ZLYbk7OtRbMhUipfvOIompzIwvcja
   g==;
X-CSE-ConnectionGUID: AA9NaF+yQXW2VDyKvXQDmw==
X-CSE-MsgGUID: xvaB/jDETKioOFvekiGAGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="39318854"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="39318854"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 07:02:35 -0700
X-CSE-ConnectionGUID: d6QeHp+6SHGhl+cAc2RHeQ==
X-CSE-MsgGUID: uwpXBjE7QPuR9giabw2Ulg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="36963969"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 07:02:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 07:02:35 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 07:02:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 07:02:34 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 07:02:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wk0UI0sQ6TyLAmgYgc1WYtTHqQSoLFXsUg64O/ZbjCyH+u/hQjiuDvsphBi17yrlYpqHmWn1zHDZKI4v6seH5y1tJ/T24xWQdTFmnLB3UxZwhKQEu3M+lmOlXUM3KRc/xyVvcjP6tSETWv7qop5w5nIwdqqZ+bxb+eWIDtSaKYTrKbbQArfBjRFqHgT2GhwvE/aNhaxLLOL4lvZN2ppNyNZnFxAjDUvPru51BXPPjB2DytPylJ96hY0MSjYbh/FQYQ92EvWcNghBXrWgOUCny1xKLUN2Uxicyestj3UxKXTyeBb2vu5HonIpWR+isEcFYGtfkzJaxJl2hvuSldgMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9FC94G7B8Oow3wVe1Jph2EuIv1UwLlrlBrzy7HGIEU=;
 b=jAeNvbjDDnL5YhUeTx3PFaCOWlAAnKzOjjF+FrWc+b8dIlT/lOk84iwJ58WCeddIfjL+Kj1Zc23mZiakTkaJGPpXopFFkmTg+pP76eetAC/R7LCv9+yjhmlHkql/gIT1TKJj5UPrkjGzop2oFopW/doPVn/J/8Ic3b5PPw+ddFnqfhoDX9rflRYfJKg54PQ2lAcle0bfru+AP2MVmglUf2tfpQDbxBxOIZk6610B3pzg+vgvZ86o84xRaUA4CIROdQqobqudVk9fB7TD+WpMXPw5shZpP/UTGLFd6hsPW1qUsvBbW1y612jhowcGAk5RfWsqZlBjI9Wsk/xHe3bXZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7877.namprd11.prod.outlook.com (2603:10b6:8:f4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.27; Mon, 3 Jun 2024 14:02:32 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 14:02:32 +0000
Date: Mon, 3 Jun 2024 22:02:22 +0800
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
Message-ID: <Zl3M7iniPQaPFDrW@xsang-OptiPlex-9020>
References: <202405311534.86cd4043-lkp@intel.com>
 <CAHbLzkpMhEuGkQDGWrK1LhvZ-ZxTJkV1xjmn-nRGZMH4U+F5ZA@mail.gmail.com>
 <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com>
 <CAHbLzkqphyX473LBCXXf8rWEr-8m2PB--CT0cwCax3mUyZPGhA@mail.gmail.com>
 <CAHbLzkqG=9VmAcOgFr-50ZdZtf7xj2PqpfD3UHUsMX3jR=+snw@mail.gmail.com>
 <f4599bd2-72af-4e8d-a0fe-153b69816133@redhat.com>
 <CAHbLzkrOspjVuQw=BN2+RZmV_Ydpz_50yY7FEakJw8Zm14Y9-Q@mail.gmail.com>
 <a088b5cf-503e-4ed7-b427-f17a9ec5d1a8@redhat.com>
 <CAHbLzkpnDPYWq=HnaJcKhKnppdNikX4YG+1Ysu8Z+XJCoKK4SQ@mail.gmail.com>
 <CAHbLzkr5K=4Shiyb5KgPTQ20jE2Zo08wK=mT3Ez9ADEdJe0Z9A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHbLzkr5K=4Shiyb5KgPTQ20jE2Zo08wK=mT3Ez9ADEdJe0Z9A@mail.gmail.com>
X-ClientProxiedBy: SG2PR01CA0121.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::25) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c85725-66bb-40eb-5353-08dc83d5d028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?svEqeJTacbmXI6Z98OhKo9d8kcr3JUitP9Q8O216agIccjVPEIT/DwhNq6YI?=
 =?us-ascii?Q?sM8AsBGGKpl2H7JRzK0DasrSSSpfCR8z74Rxh0ihgkX/atdT1hN4CocZghrt?=
 =?us-ascii?Q?sq10Z784XPmii9Upkhqp4GqGtCRaNTfcMy2zG1S7XougrVrsw/3JMSl9c7XG?=
 =?us-ascii?Q?6rX2UpciAPwdLmNuF1+hKP5XigSn02cyGC1fdOmBupX2eVzs0lf8hjKmhH5O?=
 =?us-ascii?Q?DJLKkqazikk73VLYLcj1UCRMFXgjesHG4jjgvBc3k2PG1qskYA0+aczRtWpW?=
 =?us-ascii?Q?wRYSnUO4s1L9X7HMxI4tL0CuKew7bbqltxm+NgMpElrSJjcTc4n2nEBGDEev?=
 =?us-ascii?Q?iQLnNL+FPTBWZ3FvWqTqCtF0fMIlMpd9i98p3VUPCOx9D/4kONj2qtaJDEzy?=
 =?us-ascii?Q?PfLxb3f8h4V8dMMO3Q2V8a6f94nzT3M78KIaEqBdziwJQHLLyGY4/0fXMCeP?=
 =?us-ascii?Q?/+/6GU4OsmBmL4ht2gbPVX88BbRDwQ3z4j927UnKoNR6gwoCeeRuKRGVORmx?=
 =?us-ascii?Q?piQdAFi9lV5O36zpBanRaEd0KMTnslbI3o8tAm3Pn0vtkBO6keNJyU6Bas2u?=
 =?us-ascii?Q?/kAC7EdNgwuF0ZUYK5f2Ewsmnj5JtHkuRws5AXJJo0+OLR+FVUFJHJe7V2o1?=
 =?us-ascii?Q?kmKSRSuYGtsSNX1f2Ogj9JiFcAzqqYrOSVyLbT22Oc/w8o/KzRSLrxhS2C4Q?=
 =?us-ascii?Q?L5c6othxwMGxjtsdzRG+OD7tZeQjd+B3ImhvSecRxgVunnxLOXUdg77+MN6q?=
 =?us-ascii?Q?ncyw/Y1q2EI7g0Ett6+66mafSE65gqXWky/+X/D0CuyykAZaYfTxslJO2oxl?=
 =?us-ascii?Q?1ty7zA2Es/pyRQ7MjnScf3XEYSnFhefsAPCBCvz4CBpOp0qDFhYGWoTh/iYT?=
 =?us-ascii?Q?7hKobhdCSSx4EH9j2BK+1+A0FEcEncBP0REGMVRH8E240DMdel57B5kHB2rF?=
 =?us-ascii?Q?gndfmkQ4QqPN2gyxdM2qbEd1scc7ufYpHKND2i6myvLa0ThtpVYyeCOhXd5d?=
 =?us-ascii?Q?Hl6JWG/+Stwy7x2KiJTd7gAHb2EkOlxj4XwqlhYCGwyP8J9TZoKAd36KlwS9?=
 =?us-ascii?Q?8npPfuJgROodms08yVgRklmbPZLcwsxk350l5wca9pR4gErXvzUQ/sdh2k3P?=
 =?us-ascii?Q?HnxDWPnFmV/2ntwX7YBUW5zhYN7i1ITLCmhSov4cBXpRBfCpC0mGkM/x27DG?=
 =?us-ascii?Q?iDFcqIr0WooiGiOyVEBEyEthmkBOEtF7/iJtjDItE5h/BG8MINO08pToTWm4?=
 =?us-ascii?Q?qGmxqxOnr+qwUDYdjYg408IdwH4uVJ1t+t2ITIgjlw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EeMGwbJrcVDUcMxkf6xX6Birx5WO8389tqB/5zQ64DNr+/JoIn1Kb0JC/6t7?=
 =?us-ascii?Q?fukbkRXZtphOaKcV8YCI9gRB2AWKdtjFU5xvt4UNsHn7/hctzi5TWaze1yLe?=
 =?us-ascii?Q?biWnTN2Kyk7/05TnnWKhTyWVHy3YUjPc4vuFXUO+wHBAdsw0MxuHoghHusLx?=
 =?us-ascii?Q?ysEfteVMXr8b5F5LL0ZQDLSst5I5JSzR9NJbiuNrqOqyV+OJ3+LWPydNS4g/?=
 =?us-ascii?Q?b880M2v4HJxiG+qMB0jC9ipH5GlNB/ryMOiBhb1zkkK0DTjewmirHwWRL96m?=
 =?us-ascii?Q?uwuvZgIkQHfOwSFtlMRmkJHjQAEANSjzBirUJWcsogvcHgFZIRbVwl3se6in?=
 =?us-ascii?Q?AMx+UYgru3HPWhUZyQrSjbX+JR3ogwXi80eDFCwUC5C3tV1vvTJDKvExuexI?=
 =?us-ascii?Q?IM6g4fIUGahbj65X9seQB0e08rkAYkS26katX2sGgULTlgK4N9e/4Tm1JCx/?=
 =?us-ascii?Q?W1C5qeMzcElVEiLoF3luEVW9iLQIeJ3wYQ7vs7AeaGp1l0ZCLehlTOWmYfBj?=
 =?us-ascii?Q?ZavcqA+IKcnw/RXbW2g5ofQFuquTm0IlEZ0P8ZP0ghr/CApZG4NAt9EV12pa?=
 =?us-ascii?Q?TsKbiE+0GWl3z0F4JbbZp2TfVS/HvMZm1DSW1Z6d3IsL5VC/vE7nvWq/zfKw?=
 =?us-ascii?Q?Xf394MB+dJ4yke2UPDN16dsBovcX0xXq4s9iVUihim0gqsbKe2UQIVt/TEk2?=
 =?us-ascii?Q?Srp3ofS4MGx3XZ18+mmkF5hRysQIdoQogg6kW4rfup0OT/7bCvzLxX5a57qL?=
 =?us-ascii?Q?PLIn2m6SAcFSDW9ycuUrsIl61FxsYFK25snUjVmW6b8noq37hSbLNdzg/1gH?=
 =?us-ascii?Q?h4sYUMJVLNVhqRGhhoGLBUS8BFoQiMxdzVe/DUGkQPe0oXWHS3XHS/JQE3no?=
 =?us-ascii?Q?Poz186DrZZ2fxva0lOwdEA8yKQKEPXnWBvboTqUSRJynyIrWRan0gfzr1OJN?=
 =?us-ascii?Q?iH+X6FvPVrQKbyuthjT846bq9Fs0qoHN9eTZcpnFYkMJ7nsviUbOeA5zeuE2?=
 =?us-ascii?Q?1WnW9G1bGDhHtRqW4oG9I/xDck1IsJzVX1XplI6827NfikEO1VmPNQweaFNp?=
 =?us-ascii?Q?jfPtBxANyGE17o0nXKS6JDT/JpeOcgmqAJF03R6S3reIa9qi3AM1bBEg+PZr?=
 =?us-ascii?Q?ZzF02zUUmFaJ6b8GN3K/18GfhJvykuF7L/5LzGtUXouo2LsHUUMFYAVe7Y8F?=
 =?us-ascii?Q?L7sFRmUoBdgBg5kcp8Ywzor+usLQmqMpHiJDt12+A4o0SIO7RrdEaIOrI5wt?=
 =?us-ascii?Q?RQVSYTc6oJWM8La/IjoroHyq7EtZSI2vJJJMocOv66UUUYmDjP1fyC19Lb4k?=
 =?us-ascii?Q?Z4GvklnjI6qD19BkxsjynN515aJL3+wt3jOfdvs34IXG3TUeOCTj4n64LF5I?=
 =?us-ascii?Q?PklMAHncBwieUYys4kOcF8ft7ZBqnIv0VJfMPBqmDyAM/Kb+ZE9Zq2vme3VY?=
 =?us-ascii?Q?BfYx2m0MG+Wbs+70nsfA3EhGBYk3ekdtksNyQu9BDwe6WopSQ5mMdVWR1/H1?=
 =?us-ascii?Q?wXbsAJJ6CSezVANo9un23obvTm6sqBVuO0ML0jHF+zitEmbNA1epEgwsi8gk?=
 =?us-ascii?Q?BGMvuFtOOm97YJDyzSe0mnUr5lyB3h0r6my2pSYA64uOPHr3LPnaTZ/Hnfrq?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c85725-66bb-40eb-5353-08dc83d5d028
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 14:02:32.4465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpfqMnAJO5A024Fex3DOtOORu0qVA65SK2F0deq99UsBxs+nG+3cXM8GJNCe/XogEiTbPwMxIbIZv40byB+acw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7877
X-OriginatorOrg: intel.com

hi, Yang Shi,

On Fri, May 31, 2024 at 01:57:06PM -0700, Yang Shi wrote:
> Hi Oliver,
> 
> I just came up with a quick patch (just build test) per the discussion
> and attached, can you please to give it a try? Once it is verified, I
> will refine the patch and submit for review.

what's the base of this patch? I tried to apply it upon efa7df3e3b or
v6.10-rc2. both failed.

> 
> Thanks,
> Yang
> 
> >
> > >
> > >
> > > --
> > > Cheers,
> > >
> > > David / dhildenb
> > >



