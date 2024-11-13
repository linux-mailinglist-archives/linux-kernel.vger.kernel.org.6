Return-Path: <linux-kernel+bounces-407013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8399C676C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C98DB2A41C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F249B1422D4;
	Wed, 13 Nov 2024 02:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFPY2ulN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A69715AAD9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731465643; cv=fail; b=JDPLex2rNQcw7gjRzok9NZ1I5/Adbrq7yJ1S3UcSxLKNvCTuCFmnr0vIQRLZg6IzF3dzubBDNXjA+xmHpQYEydG7MJUs/kMLvsBxXKWSrthYU7INx4b1GvpBNx6qa7VvPP8QrATNmiQRF69Alh4Ci2r2b403H8kKMRnxWTb8Z+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731465643; c=relaxed/simple;
	bh=ung4sgWCRuYj88Fw7JtImpUd4QaOkgHF+/4+S3NbsWk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PCa8y0DqnFomh1NW1t6Tl0LnuNhx4plQHyL3TpvNYZ08AM9XWcvn0Y13YAsI0LiAPr44UU7AwddaMO572cNUc8z9NbA5hbNmFs5Pd+GjEGeOmzJXqRNXZhPcx/TxaCb7WsqIdlJdpmTlJ7cJ+EKLexpTYXARhBH9/pnelBVEKYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFPY2ulN; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731465641; x=1763001641;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ung4sgWCRuYj88Fw7JtImpUd4QaOkgHF+/4+S3NbsWk=;
  b=JFPY2ulNe/zl6snl9bJEpGNJD/Avbd151a7ssjaMAzT4tZRgr++77kiL
   B5TnNduq8PQu2McEMB8qxdCOhuNxQ+rlyh0mwmd/AV+YbzpL6Zv8KVsKh
   AFKRp1h6VNFa+vmYvxgbKsEBYrSnFoPckQM+nV5kxaxaLXDymI4xhdhup
   Vln/XSvsVxC5xO86jI/JN3qelX+1oeu+5WDfBS9LCmeId4+1fbK7LUHUm
   ZBXmZtVmV3zPSOysh28JWtWqhwgSL6Vj35Tl7LX7ItPoJzbCDx5OPJuYu
   bdVprq3aA9WyK1bhCd+RRhmwOqyvukgvjymfkX0pndaR14odoEkc71MKI
   w==;
X-CSE-ConnectionGUID: COH4PtxZTWC9SFwVwwTG1A==
X-CSE-MsgGUID: Qu8ndMZoQ9mTiI9cNDFhKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="35264656"
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="35264656"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 18:40:41 -0800
X-CSE-ConnectionGUID: TOFmwvWXTIijintpMyEFBQ==
X-CSE-MsgGUID: MYO6bRRuS92lBwvKsPos9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="92795574"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 18:40:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 18:40:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 18:40:40 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 18:40:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvILyx3IBqYunT3O/PB8JHii12RolbQYSJoIk0Gp1uVdusrujK/nsFqYXINVrwDUKtE/w8fhkz2vuT6R24GzohojqwuAvRw0yrbPGpdAGbyrRja7K3yKXLbw/ljeiQKkni9dwa0OygIJ+V+GdSRGDquay3EhgE3/+N662Eqq6KRJwyfZr7PDrBf9bdFAdSXjF5lIadqbmRBR61uCtNLcx8q1KI1uFrPoiFtsUip6TFkekWae2y9vb+kUhVJxXrGpoHbOCUABsdKiCKrIGlygdsOmSvNb7EHy/iowMpOrXozqacQO4Gllt3uRJbaz5mVNSTqRJIWqs/j3AVnq4jC0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dxq7Tcz8QSXbL9MQ6CeSzY/T08ZcsMfzSvLqxvwtxn0=;
 b=I2AkIfM4iScrpV74hwFuR2LcE5c1NzolYuKk94g9vGfE9fVm4ZJrCg5kDoBja5kuLNV66R+iYNp7IsBOobMS+kwPOL5HUCrDSuNe7IYKkBMCQULSsftem7BQh7q997UlX34bQZ/DTN+02QOwEmLqWWzeF5i38oBUJ5mxYlwFpfb5Kv3EGCK2NP3Ey0U4KEpcpneFf0b59B0kjWGSv/iToP2HuSd+ITuyetgBg5xhZxcPooeiVtow6YJUBRV9TDo+dlfHp/qu+Dk+YgO4I7D2G1xF4twAvggHHbzbqWFOOdAqUFb4D3uQuvGH5P0J+jejJUQHz+tE66EhzCbjN5Wn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7741.namprd11.prod.outlook.com (2603:10b6:208:400::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 02:40:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 02:40:31 +0000
Date: Tue, 12 Nov 2024 18:40:28 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dionna Glaze <dionnaglaze@google.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
	<russ.weight@linux.dev>, Danilo Krummrich <dakr@redhat.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>
CC: <linux-coco@lists.linux.dev>, Dionna Glaze <dionnaglaze@google.com>, "Sean
 Christopherson" <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Michael Roth <michael.roth@amd.com>,
	Alexey Kardashevskiy <aik@amd.com>, Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v6 3/8] firmware_loader: Move module refcounts to allow
 unloading
Message-ID: <6734119c1c9a7_10bb729471@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241112232253.3379178-1-dionnaglaze@google.com>
 <20241112232253.3379178-4-dionnaglaze@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241112232253.3379178-4-dionnaglaze@google.com>
X-ClientProxiedBy: MW4PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:303:b5::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5c56ab-5e6f-43de-ef1a-08dd038c8a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IHx4CsGOb8ZBjCmVnqYp9oyCLZ9JR8mS/YqN8dFjDYdzhjnrWc7sqYgA00i7?=
 =?us-ascii?Q?RPdl/ohv/YrZzivR7W4Y63kbWZJ5KspGvywmtek5O2khF3mJaJyo+IE2qEpk?=
 =?us-ascii?Q?WfIInn+wNi9HGCvU9y4Xhx52hrqHnlN0TweW82PxTsCQh899bkyb/nqFH3Un?=
 =?us-ascii?Q?IMr5hHcdM/rpgG6lg9nZI4ikMej9q8Vz9ZrcI15JAJzhDhP6wnggDNmiPzWw?=
 =?us-ascii?Q?zA6S4lmHa3L7vJxzM9UTZVquZfHiZWIrPSdKxQAMWePE8+OcIpIggfMa1Eye?=
 =?us-ascii?Q?F4KBbOUvq6UcfiH6Ys0zlR3FomINJwEJlk8UHq/kqTHo2o3YijKvs1ewLemb?=
 =?us-ascii?Q?etepqSskPVwxYytNGQI3GR05/eX+S+wpeHeyg8GW9T85zoxMXWv6Cipvaq6B?=
 =?us-ascii?Q?inl6B/tnfBA+0hpCFv0JoBl5KpIJwQdzSqaJD7wBg0GtMblhm5UVcGFhuBV6?=
 =?us-ascii?Q?mN3HeKrVXfqdzkacfjjPw829ji2I5/sxDg2yhMOhHkY+ydqHNKKm2mVOGbz3?=
 =?us-ascii?Q?S+vKFPBzJBc6fGXx84BZZtqNzMAxLG6uyCsz3gw0aIIjUHTYd6t/1Z1Jt5eQ?=
 =?us-ascii?Q?Z5Tj4YMelRRl/7Pqz/M7XmVBpWD4voctXMiVKN3Dc5oV0zJhio56gRQaCKFX?=
 =?us-ascii?Q?if41rPJuNZbRUG+ntN7hS+QS8gmNb5Trrn3xWNfauMTUZVw2nbrobW6krpha?=
 =?us-ascii?Q?S6F50wXBlipOXGIuEl28UXLXiDNA5gzJXMKcirk7VqweSijfJ54K1emDQCEx?=
 =?us-ascii?Q?lGQfJaUuKpayG/x1NUuAx70zfNCK/DW66nc45AxpbBErjq6zT3BbMe3kdvE/?=
 =?us-ascii?Q?T86motlWcn28W8kiGFOEKHQjmAbChvM34rhk5uOlNQ/16tHKzVK+EbwdPIgF?=
 =?us-ascii?Q?X9aw46jEfB5I2PwqQSkvESWCszh1fek3KqvTUz4Bhy5oyw7dH3JKRvyTervG?=
 =?us-ascii?Q?ZDRgp2U3IkxI4JQ+UleVWe+6KdrvLtbHJOSTTmU4AehDvozQAtHzrkkfmN4s?=
 =?us-ascii?Q?nnQH12uVJByj2hY6YtJyT6LimCGM9mqyVwu29a3nMCwxVklyTR2zVYHez/59?=
 =?us-ascii?Q?XV+KEw1yrSJpCSagqeeHBHF2Zw/WmMz30rsf9ucGmWj/meoL+VhudQfd8UFr?=
 =?us-ascii?Q?xSTDTPOSyKNLKtXdIqfcIgREuuzeOD36eVHlelkUtmZjk5Vcr/CiKcx5F0iS?=
 =?us-ascii?Q?GXOAYxCdcCPCILtweN91yKylefJy1bybppZ6ST0xEHZDwEqMTQEmaUfhNB6q?=
 =?us-ascii?Q?py4KchcjhVG0FBVxOvzstcjI0R/rI82qcbPRey4ObCttbxIdBrw2OzgwH/0b?=
 =?us-ascii?Q?IH0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FToO3WMKnJGqeukxWjk/4V9Z/akb2tgnv4PInZs9lcsXBNybbM5oqJn+2RpO?=
 =?us-ascii?Q?E/r9qfj+d9L7Yqieto4b/rxDdg7y6sCCtSrb8dMkQaKPWFg9kisZfBDzFFc7?=
 =?us-ascii?Q?j8ob3feNurYTRiU4zdFWVfDjs602PfiPexrTNITaaxIeuXNK/2WDOkNaKas3?=
 =?us-ascii?Q?QTZXU9rya7CEH8s8zO3tVHZb6CS3ZbkYbgts7hs91TlYL3V8c6SZiWEDm0NH?=
 =?us-ascii?Q?rqNOLZrCSO+KEKmuyqeaS6u4oSWXAbmgB/lRV+Yp6rdtX8pYegOKiZGsJiLJ?=
 =?us-ascii?Q?mIcQXZqlIFJaub7qoumY8jZ2iKFg+5Cgw4njyffnb7s8RPT82ha1prWITh06?=
 =?us-ascii?Q?fACvDD3CS1QtXQmLlhepa7Vgn9AZ/OiKOcVCVlMQzuDr+pwVxhIeMM9V5WNK?=
 =?us-ascii?Q?tLdP7oPe1fb2bPp0WlqcWMXPplxBWYi5f8a6zhumLNP9p3rDLKVMOUR1N5SR?=
 =?us-ascii?Q?PoHrC+el2xGHkA7wM48tvqIYjVrN7ut5SQwrGdqXZpC1qtYm1/T/9bW5xWnF?=
 =?us-ascii?Q?V7ZNsurp/RjHg2ztFbF4tdJnD5XarsFqsQOP7HnaYf+HBJGYON7Qj5yZZfR+?=
 =?us-ascii?Q?ouG1u/KYO+OXIdr+un08V5Sh/DY6+YVqRz34RadmVaWMJOcc7PQ0DpP4i7Oi?=
 =?us-ascii?Q?rtHy04OWi6DRX1zTyXJJvXZ+GMbFtbFMsQ3NF2wz8qfOBzTvthOINCEk4LVg?=
 =?us-ascii?Q?IBePrEP4kilbEQ3ZQJJRUJAJxqrB39xWnUpC9+Y+ZfbZlThS6m6jF2Os+mZR?=
 =?us-ascii?Q?u8ziQcLDA6+hDL6QDTfS5TavM6AKmvbQha1MfwA2Bau923E1Jyiix8nW7b5f?=
 =?us-ascii?Q?gnEewt4lia0Mehnchh92qVdcoAvtn2Pr7XPmDmksKTJl1d7ywCZMefH2khUr?=
 =?us-ascii?Q?7ijbKbFgRQXuG19sL3fPENKfGzHSSkuB/q2dbk6Xp66yZuQGheNnaoUMgnmC?=
 =?us-ascii?Q?v07l7dXI/b9Ojt2afBtUFCzjn/kzu2NREQTBiZUFU2Np98vMoO8YaUGg4UUW?=
 =?us-ascii?Q?QyLYDD48+PxxXF1iBDzkGYXJGcPp6afBdTGqmJyq5Xvr4KsBBTxkg0G8FnvC?=
 =?us-ascii?Q?+EnSdxpQwobtmtcHt1XTael+hz3p5/QqTvt2ZuOxfr/AWo71iZOU+XgYAtVP?=
 =?us-ascii?Q?85e8pjxPKFqos6eDT7iFHR7xzcIlHoDoK7r90ruEJYWdnHmCJQ8rqXonWjXu?=
 =?us-ascii?Q?goWfH6V1/6k0HHIC4pg8h0Ejnm+FTiRWkfyx3N6hX7nf1sj5qjiRCQRNthOa?=
 =?us-ascii?Q?SUkcwit6bjwxYeCiNkhxZEhj/OIQyM54fAfwpIfvs/FAQeXwqqn2g/NLXUJA?=
 =?us-ascii?Q?LAJp9F65fuDmLcKMo639h3EBDcnofWXUc9djghpBhYadDhjmxnDEO0NYmE5d?=
 =?us-ascii?Q?FTY3QnIH74HAiC9JouVaJ+T93GiQVAus1hlS1Q1rmG7F5AjugXXzFcs2UPRq?=
 =?us-ascii?Q?Q9Cuz4Q6MVnuO67CgVZ3aV1gHeDdTQvL889mu593lXb956Xdzits6ZorBbuD?=
 =?us-ascii?Q?M8iodY53IBHsK/6emlzEKmaKNehp31uEgtPjVsJcp3iJxeA/B389rcTdx76a?=
 =?us-ascii?Q?TBlI+8XEK0MQGHl5xRLYwHO9RQZb2Pg8efY8YAzJOG/7eqYnNR5b+lXUGr8Q?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5c56ab-5e6f-43de-ef1a-08dd038c8a9b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 02:40:31.3830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqx+vQSW6RINlY6cKOBCBRMN8vBbpVqvAwqrgNikDV8bMRewuDGQG0I2DkXw0fnHSThIwrf4plphQh5/J7VAWzO0xmvEfUlNvr7i6TH5sgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7741
X-OriginatorOrg: intel.com

Dionna Glaze wrote:
> If a kernel module registers a firmware upload API ops set, then it's
> unable to be moved due to effectively a cyclic reference that the module
> depends on the upload which depends on the module.
> 
> Instead, only require the try_module_get when an upload is requested to
> disallow unloading a module only while the upload is in progress.

Oh, interesting, I wondered why CXL did not uncover this loop in its
usage only to realize that CXL calls firmware registration from the
cxl_pci module, but the @module paramter passed to
firmware_upload_register() is the cxl_core module. I.e. we are
accidentally avoiding the problem. I assume other CONFIG_FW_UPLOAD users
simply do not test module removal.

However, I think the fix is simply to remove all module reference taking
by the firmware_loader core. It is the consumer's responsibility to call
firmware_upload_unregister() in its module removal path and that should
flush any and all future usage of the passed in ops structure.

