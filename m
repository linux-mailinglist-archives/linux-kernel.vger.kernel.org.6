Return-Path: <linux-kernel+bounces-203377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C638FDA18
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E80F1C21090
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341BE15FD1E;
	Wed,  5 Jun 2024 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ah9qhaj4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9082429AF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717628053; cv=fail; b=f0oxarwWd2vAIXnII40R82S8I7/GwWa3zY/UD8w9j9lDg1zQvI53yABD402G/QHxttd70AkZKXQWnS1/fNcBs5pme3YznilxfliOLI32WlaAoClO2E+W5s+c+iQUZOPIkFiWxBjfv1Phka9Stp4lWAm3+YbBWQ4uaLy9GbvEeaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717628053; c=relaxed/simple;
	bh=B/lIcdMR1IyKYmPjY/PoM/x/FcotlYTuZ/qfcHInJKs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mqs9FYo3ilhwOMFfvtS9BQ0pO5+hr+jkSWXeBzX5aVNWg8jV7iXhX8crA16slKSc93PLwLfl2Z1Nr0OujG3HPr6HJqiu3PMIz/PlaCXHpmM85oyBt7B1BHgrgCNDCMK2dhCCGLuZhdJjdjyvUhnjV5sc/8dpKnJPYh8lyzPXtyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ah9qhaj4; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717628051; x=1749164051;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B/lIcdMR1IyKYmPjY/PoM/x/FcotlYTuZ/qfcHInJKs=;
  b=ah9qhaj4HvxXeuWhEcMxiFBrjqdGr687N3UfQR4LOoPKdyLZgpKFaHrb
   2+QEdAGU1W2l+TQGXPODKdAexPB4pNVFZ3qOJEp2irQ99lQIHAnGZz2NQ
   hJgxFK174p1+bO0zmB/JHu6DiibbqGs0mRd+am8uGeHONA6A0BhFMSui0
   hcS7ui8K1vKW8AhL3e5hWoZWQmOh98kW2gXZkPHfCvp7sYhHFttzs3kJ4
   NQxUq4LOenfUJpnNnRkxNM3BLjgd73OYJF7qBM/MNLsStpBH1XqCqePg1
   I7sCD/foUpkNPAFKsywfdozvLl8CMKpM8NA4K+/pmdNEEJG2S/73HEwzj
   Q==;
X-CSE-ConnectionGUID: S3Gdky3sRV+Kh7UXusnsMA==
X-CSE-MsgGUID: yiVL7TVCQ/OSgo2WFBaGJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="24839949"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="24839949"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 15:54:11 -0700
X-CSE-ConnectionGUID: 65MMu0d+S6SRGRVEvSWkFA==
X-CSE-MsgGUID: 8Ebgx0JfTya/IequFw/b4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37857407"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 15:54:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 15:54:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 15:54:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 15:54:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLQZ4U5BU+Nghv5ygPiWshqZ3HSXvO3C99qXcaMwgKyfznlewxWWkn5SAKMvKicDQxrJSyYY7npq4ZizmvhQOsuI4nCvJS+LlVXpxut6TzNqEAVb8NeEkZ4F8rqhJau14ggQeu2klTuQIrznwzLT4x4owWuZxrEAQGyxNKqQJcD//jDJw8H04C5+lGBab3G3HI0rztmw7DkG33rPl3okFGut9PIVpggQa/R6L+Ne4/v1AWxVo8UBNWmoCoh+N9/++U9sTn7sod78LlrSP6Hd3LK4VTQQS3jYhvF+laIqVXvdXNNi6oFhTuXhSZXxXOOTYVtMhObITZveHdWApAdPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtFzizEp2HUL1pn5sB7L2l/wV591URj5r0zaD9+7i94=;
 b=Vq2rRyiSqkUuq0d8F+fBwNhQ9l/rXAipWM4MDlSeNc9TXiLe3ojChL8henjXGGXJxoEYklfnipds4+lDsqOn5QSRWw0M4JNc/zq26TZRjIIM6tWZnQarhi6MfA1F2u7JOKjL+bSwMLOsRElPGWoA9lYyAZl8mxCfhkjctVDLf+ibIKM/yTEKzs+Kmp3PP6bYRxW+pQcS9i8SQH4J1AYq3dzm1SNVfrrBjwb+tnCFlCdZGBgw2u9v/CFzzAe6eCNYBGnzuhXDrQzagxFQrieTf/6GP823RP9LCWUJNPX4OeQAabiJ3BMlC0+UmPEPvbsg7EaOg40HU/+I0ym+N53MgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7403.namprd11.prod.outlook.com (2603:10b6:208:431::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 22:54:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 22:54:03 +0000
Date: Wed, 5 Jun 2024 15:54:00 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <peterx@redhat.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm/page_table_check: Fix crash on ZONE_DEVICE
Message-ID: <6660ec883d31c_1ad63294f4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240605212146.994486-1-peterx@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240605212146.994486-1-peterx@redhat.com>
X-ClientProxiedBy: MW4PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:303:8e::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: d446a6be-69ad-40a5-21bd-08dc85b2654e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7jrBQEO44jBbuV8V7rKSUOejMmDx3PAEc19cJeELInvnjExEoGF6mwxYnJUN?=
 =?us-ascii?Q?+lap/Cvh/778kfD7p3NiJTqnaWNmIygoTLRkjHFLl5v5li4Z+casdwGKpW3m?=
 =?us-ascii?Q?EjMdslJsL3i3PBelG30ZPEtcAZlCjClg135kLO2UAU3rImXUD6BvZUYvMOvd?=
 =?us-ascii?Q?6fLmkK37sGuuHRwDbQEWEGJfU8qzxc9Sfk7ZrQE2AhzvNpkxJcHWMQwkDQfZ?=
 =?us-ascii?Q?AAY0gGXLiZzViTohmthX2J7VThTUbv02c6rIgpdER/jvejKTazKl1obD20Qh?=
 =?us-ascii?Q?0Louy6yvlfahgB+6gOxk3bntR80Po9uadWpMGg4SGG3xVZIxKn+xBwhCHUgW?=
 =?us-ascii?Q?46IrM3rBOeuhIjkUtT64F1urqgx19QIm/ZQIiK2AfoTCp+8huxzk/hYk/GQi?=
 =?us-ascii?Q?/ZAlV+da0rDqDqxQabOKyl5hh4tpBaIXxtYsi991g7UomWnq36j79tvhUH4F?=
 =?us-ascii?Q?xSiVM4WBuh1z/G3kLoBxe8gxv22X6eVaVs7+aIax49mQJLY6gPOWfL0pyZOY?=
 =?us-ascii?Q?jwUUX1/EKbtbIlP2PU9B6EkuKkSzCXEKMnMbDrJJFA7FPh1g7ni2wr3Qs/LN?=
 =?us-ascii?Q?5et1kO62T/ncsEGsEfGcQxlzjWGsEhvR+aPVOGh/hBgMo7e1KYh0JAFA6/a/?=
 =?us-ascii?Q?MiE0uUrdlKHdxuucQ9uaS+91yotQYFxcPUaTaoFMzCebrUbb4CuSfwnfJV5W?=
 =?us-ascii?Q?0xwX9/MUUinxZJ5jLxCIyJb5V4LPbl/AsIXTEEQWrFyMQaepeB0xXTT30f4r?=
 =?us-ascii?Q?PTgfwtN6UXefQuE4fut9qvf+ZClSHn86mlLn1nN5wxZhaO9jxM5+oAvvcEdb?=
 =?us-ascii?Q?EChlhghJz5R+0NMTH2gG8I9LaczUJygamYfoNddVWZS9L30rkevlw+cvKw6A?=
 =?us-ascii?Q?UIZC4frTCU6BG+rMdw2TUJ2xxuXx96qY9bZvEMGyA5WRuSKw99pmv7ThLwGA?=
 =?us-ascii?Q?3Y4QSV/jW5B0aR4WWwkuIWNJruX5g90+XZLk4eXpIJyM3ezqnM8Ce403YUmB?=
 =?us-ascii?Q?v4NNrnuRzBqohsqusmGQTkziRKVhhLcDXTRLLyLED7Kjj54whxyeS6R8oFJ3?=
 =?us-ascii?Q?ie/qXkvKnSKgiAi+GRlu+WmbiEpHGr9piOTb0yN57cd4x2RR4eRKud94DnIR?=
 =?us-ascii?Q?tco+6GeGwjKojFbrbOwLwXCm7hXrmUBn4xQw9SdGsZFNnAO9+Rt6CqepNWAg?=
 =?us-ascii?Q?zo9JLQ4Wf9ADoj7cUltK0nMB/Rn6u2SfhhiYkoVY3GROyQ8MpySI8v4uBha7?=
 =?us-ascii?Q?AK/l2L20rLAvYL7JUwNf7GFNBRrIqU4r7bNTOYLkltTwA0EtB19oKTe2KDjp?=
 =?us-ascii?Q?gVP4SnOYtJ44yFzliSjOyF5+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TujPF7K2v/aIkKuBWY7WOzXnK/o/fZlgZ3G60JsfVnQUGEbE+kFZOCS7sBHZ?=
 =?us-ascii?Q?An6Yj3O4XD5iAp7Rh++LjQpgfoiyi0gE25WogDHD60LEY0LVG+hzDVZd/ZZs?=
 =?us-ascii?Q?ImSoNk1cyST4EtO+C5bpXigLJmfOOKo/DVcSyDILCn/ZTHH0s7PFiHkUpKnP?=
 =?us-ascii?Q?FIjuR4eQhv+GPWtHVeOLQWyrDDvWcF3Hgw9BRyKPpNzSyadDESz7B4jcu0re?=
 =?us-ascii?Q?oWw+LyDSKxWqtzGZ07ZQLLbM9hNCuQndR2ApOr+2vBnBQ7nx+d/hICK9dxDJ?=
 =?us-ascii?Q?JrDngl87qdnmqLUtWuygoqsqwl9LfP6GtpDYAJIhJBFPu1AjARmAJkIwm7qm?=
 =?us-ascii?Q?mfEECAkyK+2DMeSPZPCkUnKjWteNlB44EmQiiNgfviXrcMGp8mIjYS6gjlvf?=
 =?us-ascii?Q?RtiS8z+KI2aYBjfUuge+o15jcEZTmYwK5vzPtBegzA12EFpPghVg+jCQdPIO?=
 =?us-ascii?Q?8roYkxByEvfey2Eh3H0aZRnBA73Dl8bJs3gOU6Stl885iHlLGJWc4pau/lpk?=
 =?us-ascii?Q?xSfhv1vIDTDI90GhSVjGNqfePENECIdZQa8ERmoMxmrXiAPS9ZEYBXGJdRTs?=
 =?us-ascii?Q?gRMg+6o4vHBjd6jHHJG6Ujl+lYeqBptGWuUM1kTZDW3pnbVDjYvzDk7lJh3u?=
 =?us-ascii?Q?7mSnbUsw94soeRirAytYdM6Ca7c2ytCjXB5FPN9JBKRNQ6qO2qkKnQLP3c89?=
 =?us-ascii?Q?yYJnmZVkUwPBVNg4ifVUhMIGVrhn24Bq2B0HYppUWyCEGO0DVoU/hmsOjFhs?=
 =?us-ascii?Q?u6cXHXSewUxuj3bYuB6obRtOmhLjmK3zaJ/wD9T0R8jbeyoZUTPMtLFE80bB?=
 =?us-ascii?Q?oNh5kt3f7XdlOOopPZDcvFmjw6zyT2y9BlUoszB2kzvMnd8z/U0VjhldTntV?=
 =?us-ascii?Q?b6UiNGY1UcvPlJm5eyp1gPltYMGR6umwncytD96YZt1K5ruCr03+vkWqQtDZ?=
 =?us-ascii?Q?Zxj291gPh5eixqG9SOzt0MyN/Ry7J16qNqZ+ZahtMhkAEzMQq2w9tRCv8Wpv?=
 =?us-ascii?Q?N/vZFHZeuObLyrGI3q2xFmz75iJssepfoF2Wx217q5GXcn2aX/+02qAfWo0H?=
 =?us-ascii?Q?akYXBygGY7r7rZlRVBx4Sbu/8L10TLqmNUoA24hTxa8IS7tZCbfV11oUnr+z?=
 =?us-ascii?Q?iKNFgUYBolRap15N6pSPII5TeF31T1Qqw3l13QRykbDjTu6BXRoguMr1aNZM?=
 =?us-ascii?Q?SiIuZM3pyJyxxU68NIGgXJEwgOl4UeENIxaWro3z614B17pHpnCo6/JNpRjp?=
 =?us-ascii?Q?eNbVDGkbPnZeFH5Cb/uDNrTAHtC+uUx6VsfXEY9I0OFq4gLVipwiXd13YOnE?=
 =?us-ascii?Q?f8ud1ZghWk9fpyNdziQybUAjgyLVVf5ODNNnK9SvHwycmeZBHY6h2WH/vRmy?=
 =?us-ascii?Q?F8Y+mGZNbrWAjkuu7jGRkO8VheGM1EmY/Uf9CMLZNyiLBzSBMNbcVsYK1W0h?=
 =?us-ascii?Q?5GYQ7qiK0hMSFovACS7mOnQHTX9jvodZzamXWaX6mqvtq5QR/tuFLu7WIIRQ?=
 =?us-ascii?Q?k8XCdOYeSGHp+4gd1GdbTbC98zaLxWSJCe1KBMe6sPY9/tqpQs0S/wINZoh/?=
 =?us-ascii?Q?bPIwhvuulO/HJfQNUs1MlXutm64BHMf1ZbFbk95Yp0UDbtFB64HHxJiytVWH?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d446a6be-69ad-40a5-21bd-08dc85b2654e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 22:54:03.1426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ns2hlHu9uUR6mSFj4fjEbCcBZUQRKxjd5MYz0AzUBsO9dvBwUtkxRsbD2YyqO9TW4tk4lcAkEPKUS3eUQ3EDwu3SKe0l5hhK9qhu/VSgAJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7403
X-OriginatorOrg: intel.com

[ add Alistair ]

Peter Xu wrote:
> Not all pages may apply to pgtable check.  One example is ZONE_DEVICE
> pages: they map PFNs directly, and they don't allocate page_ext at all even
> if there's struct page around.  One may reference devm_memremap_pages().
> 
> When both ZONE_DEVICE and page-table-check enabled, then try to map some
> dax memories, one can trigger kernel bug constantly now when the kernel was
> trying to inject some pfn maps on the dax device:
> 
>  kernel BUG at mm/page_table_check.c:55!
> 
> While it's pretty legal to use set_pxx_at() for ZONE_DEVICE pages for page
> fault resolutions, skip all the checks if page_ext doesn't even exist in
> pgtable checker, which applies to ZONE_DEVICE but maybe more.

This looks correct to me, and needed in the near term. You can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

In the long term, the page_ext check may not be needed. I.e. the reason
I added Alistair was in case his work to make DAX pages behave like
typical pages for reference counting would also make them behave the
same for the presence of page_ext.

