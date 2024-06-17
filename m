Return-Path: <linux-kernel+bounces-216781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2D790A69E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA995B2A55D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437CD18C352;
	Mon, 17 Jun 2024 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N03qiexc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9AB181CE1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607806; cv=fail; b=mC6FHjKTgN9b2N9Xi1S7V56pk728D/83aJJzwtSzFdt3AmFboD0UfgqEKVOnNw3PBsCLoFtgDam0/do8gJ12Hmjwa/BddMPKd1O+pizrdtwzxY4MxpF7tHsXevoNim2nbrqLsbGUEQzvSEjUhmfqiw8u6T0ZcrrT/e4E4LBRRN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607806; c=relaxed/simple;
	bh=Lu/9TLpPhG65oZtJEbUUdelT694J+Qb9cMoyBhp7ZyM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=dMAMceDDtf1r2YrgO9iWwMTny/ZuYr8ZbHlLorBb9w4krPxYtZsbInE/K8U69Et+ExbTxza22YxZJQEgDpp6MJVyfXVmyMsh3qSgJ0j5AaCTrbM48AZKRdJmflJh4rbjSZ0sp2TxVs7ophrpiDXmHr3QwcOWkQgivY9HRChHcWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N03qiexc; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718607803; x=1750143803;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Lu/9TLpPhG65oZtJEbUUdelT694J+Qb9cMoyBhp7ZyM=;
  b=N03qiexcpbMklbNG3TpXARwIO/lEtYVBhFK3TV0FyXml2ZUBRy8LepUV
   EWKoxpFdyCo1sRfsqn1u9pPLM8pBUY0ROZ7kiX3CAAUAWQc9bEqFLzVBw
   l0uUp/+wPBAu4dsh1BBrlMank9lt/2oMdv+kqCowYz8Gex1CBXKYCBv8m
   eVCgo2uxrwe6JUb1Z5Xwua/29RzB+dgEU0twWp8hnQ4z6cry7Z7GrBsjZ
   z9ojOFA76rsUkqyf76DNgS7V/RwlrCTFjgG3isAlYVJCnEijoU6EM3udi
   0h/Q3mBEeqLgHPk20UTAYsv0wQKP3EVhCTvCd39kIoesUhpC+qGLKBP3+
   g==;
X-CSE-ConnectionGUID: oEVP/mnlS7Cd5no8hHV+oA==
X-CSE-MsgGUID: 5kptPyxzQN6OfXPNenjMUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15569736"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15569736"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 00:03:23 -0700
X-CSE-ConnectionGUID: Rssk9rhmTQu8n0Y7W6EDew==
X-CSE-MsgGUID: xiIyV2xmRJOXqWsOlPHBtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="40956327"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 00:03:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 00:03:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 00:03:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 00:03:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 00:03:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+6RxM6XDXck0SphBurXzmtq1Dfr2b7xT8zZmZ6J6UzvOWJJirtL5HWcQq0s6FhIlnLCv8hSs/B4ZtoHsW8G9K1ophp2FezNuY2twSP2vK8TBWqZ4UzgDjs2CPY1r8OU6Dp0L75BX392Jdkw9+uvmJGg9vLGdSJMnC4+uLjmg/0ozp9pBlpQMU6QRNwUJ8l+ihZlZVcqY2ACZQcm8R41JBdISRPi8EhFRQ9beBlH6Flj2qypZoRxCvpoFv+D6FipyxwcCGiCNhHJCfA8y2SFet9TywXVEImn/4I0Sy2NACoOrlJNdoDFIBelYOVgQqUXUF+xx4VF71R2vzU+3q/utA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrKhJwflGMTbR++8zBRARcP53wUshcdYA0Bz8mPbmTk=;
 b=WJKwApvCasDdf8JeFCwXE9AFIG//V4jchUjIxTcPactQU72wZoV6YpD7PtFYLdwDQRZ6R9HQHOSs6JMAope0mpeT97wC/X3TTePrCp7fsDMlmtfQeyA5veWc8jfH2zJ1zDq3JFT9ipF0FV/noFdSN+QuewOsTJku+j8LyIFhsc104ySGat9/wbqvnF/VaCrhyYSfp2g4giEyGZWe65KWF+J+b712cBDsaJd/sNS0WUNlE/jyKpcLQK1TC/bf9G/zJamqPmD1LCmCM9nF9bRvrct8S+OCz5vwyAN+YypN6tXZPhTe5bMqayWzFYzkJDasBxNcpGl5wXV6RCHw6E9PvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB6988.namprd11.prod.outlook.com (2603:10b6:930:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.28; Mon, 17 Jun
 2024 07:03:19 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 07:03:18 +0000
Date: Mon, 17 Jun 2024 15:03:08 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Zi Yan <ziy@nvidia.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Matthew Wilcox <willy@infradead.org>, Ryan
 Roberts <ryan.roberts@arm.com>, SeongJae Park <sj@kernel.org>, "Yang Shi"
	<shy828301@gmail.com>, Yin Fengwei <fengwei.yin@intel.com>,
	<linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linus:master] [mm/migrate]  7262f208ca: kernel_BUG_at_mm/migrate.c
Message-ID: <202406171436.a30c129-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac07a31-4b35-4207-5608-08dc8e9b9125
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|7416011|376011|366013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G8P1sKqJPh62ddHD4nMb6od4SH28WqK4XY22uGagOI32JcJcwcKVOvrJ48DJ?=
 =?us-ascii?Q?Ay9dbz0TeQ53hvKQ006TvBJLQ5K40bp8r44QgpVtmHt4qfYxaqL90kfAo6NL?=
 =?us-ascii?Q?K+vSqrFTrjkJFifY6EHKyWeCtW3FqvilCRtKgiexQ0X/S3VfaYm2+BNcbu5N?=
 =?us-ascii?Q?aqp3nXNGegdz6OgUflUb11UWn1DusVPmJXC0Uwdsj+4pV4IACbqRWX/pmomp?=
 =?us-ascii?Q?rzhTNShhO489BFnKzghGYEBxuLEVNXlqCHaATJ4KGZU6MxHNhn1e+U5QGKs/?=
 =?us-ascii?Q?ZoJ8BWKrwEfwfVIeN567TwNrHo7H/NkUlOC7mHd9z3uTQln/TtUfZ5NRwsh8?=
 =?us-ascii?Q?O3JAHfm1auhE2rdVSNFZT5iaFe9RGi2V6m1qHlNMT+d2aeh2xpf/LszMiVU0?=
 =?us-ascii?Q?i/8ODSjjTiMp5gx4bidAe4GV7zxw71HrJDcQ5YDIRXIOxieiiAfIRPgVQGN1?=
 =?us-ascii?Q?Jo+xQloDGlqi553mDbW0B0zhIZONH+Ug7OQXlYo0iv0FDrmeEwTa2v9BxIyg?=
 =?us-ascii?Q?Xk3iKdSgcn/F5xHLgYotk2Pmxm8VSVZkKCvRyBwAg7DszlLYNbwf1JxaeZFO?=
 =?us-ascii?Q?ZYnUNad922VQBrCOTEbA3PuD0Jhw+VhNMxcxNDHBl4fahIOy5F5eEgkmZsnD?=
 =?us-ascii?Q?crst0bNv48wn7XPX/v4qDNo2woZpSdpzRm+OO7OyFmTRRjEq8Hb+Dn+TfRW+?=
 =?us-ascii?Q?67vW33nsBaYeiIjddFwikO4ZDcfzkHlj6Q3u5au2snBxMNGAmonTxOv8dT+L?=
 =?us-ascii?Q?aZveEDDmsb1wbX9YG/wor+klHXh67qgOpcDCs1AkK4MbHNXXoCGGbMIM2aUG?=
 =?us-ascii?Q?Gfv+zcW1cr6LaHlrtHGnlbAhmibvkxiZ3NV9g5pbaJ6AOdd199FsNJMlc990?=
 =?us-ascii?Q?f0v0HAo3bPVT+qnXTwsizTHV7Hf3TFAN7w6/He4mkLoaNgGGLWtrWTyk+2cf?=
 =?us-ascii?Q?5WBhB4A2TGlHd4aMHiMZnxGSx6NtQRk2F9fp4jyF2xf9N9IUj6pXr++qYNdC?=
 =?us-ascii?Q?oe6NPLXKj5gSccKYl9QYTE4OQ/R8gqUPSY0PxtzcTU96PZcmsIp20zoQ2csh?=
 =?us-ascii?Q?00f7iKPG6Ulzxf14JX1Oz0IvpNNKv5OqYWVxUJw6P8QK7O/GqK03qsZMGW5I?=
 =?us-ascii?Q?qGi0F6RgbXxFJTlcZlgfTF4sMtS4V6kPpdCTm6fA+tqN5Plaw6r1FVIe6epa?=
 =?us-ascii?Q?gR7bfdxgDZBfguxJQ3dmH2CYsZnKQ+JeEnGbbgvK9Q0N0rWk9zwQzMtcqM72?=
 =?us-ascii?Q?k7aXv4n0syx+2W5TBzvV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k/dPUkkrFf8gYXLBG2PmOeNYtbtYKkrU0tB1RlXFZS1fmgcXDf5Rih4+vQhN?=
 =?us-ascii?Q?bI6pit8A4298o3OEPiRVpYeV7l4iG7UclYlehBDbQI9q43zVgJabO3/Bfx+3?=
 =?us-ascii?Q?QhCNBXSr4SiUiA1qQDLjFa1AlTCZepFnONmyDKGtAiaysLdhhxz8dVAOqXng?=
 =?us-ascii?Q?v2uj2T0mPUBBXarc8fCLxh71Q28pUUlGdASmOBFVI2FKo/I+PyRdcw2JQRG4?=
 =?us-ascii?Q?y9tYJn4csz9ibINqYMai283ztvJLJyY8ZbrphopUf+2SukMkAZ0eJ9TfltJA?=
 =?us-ascii?Q?KcwoBR7RFDONQLyG5lWrBCT8VnPf+Fj17hHKmK6zZcHE0m2nbkpNSR9cbMHc?=
 =?us-ascii?Q?YKh/X2bWEbszLrYHEBvCvUiPnX4GfthkIvzd5JkYt/JzUrOZ0AlkDmo6Fu7h?=
 =?us-ascii?Q?zruQp0SGA5njKtOJ753RXHOuaMKazBgxYGI89Da+27mqEunaOhRpu0DSFmg0?=
 =?us-ascii?Q?Y5xSIP+CjePhqadjrFo5F+7N4bf/lZkoiT4I5koZtj4YbvfKt70IIG9S7MoX?=
 =?us-ascii?Q?4vhe47+zOJZRYpP1Kwhedr/Z+8Cb6X4M4XJFxzCQ4I/NE8yGYOCVdAJ0+y3f?=
 =?us-ascii?Q?CFFRcHpiYeuiAPSsFO1kkUg+CJP02wjMUg7DHoCRv7pVV4w2REiU/xz1tq/3?=
 =?us-ascii?Q?tCAw7Do9YlNZUYZx5uGIUBEiKUCGOGup/mlp4WlrloCm9+Dx5ZzogLVGDG2X?=
 =?us-ascii?Q?5fq/74h8ceXtof5cS8NvnL811VoTFBE/SmxaymWeTAoD2h9OE3Bsnonmdw/B?=
 =?us-ascii?Q?ly0NQgiHfAG/PIla8HWNM53CqKxT/9JxWv1XJigiJ0Gqk2eIjbK3AONn7J3N?=
 =?us-ascii?Q?+PWzT7fkPOKgNKAbmKbUeIHEc/YwQR1YsE1kqQm5DjVtQtaM5npRcJVbNlDA?=
 =?us-ascii?Q?ZzYgGA8cgs5AkD67RJnt/AjpXSwQfr/erWxBBQ7YQh1Y4JNk3gBN1HSeTDL+?=
 =?us-ascii?Q?5anjCQ5KPpj33VhLSxd/g8Nr89I9Jlve9LiASbJ+AKmoGmga1ufhb1hYTXpI?=
 =?us-ascii?Q?/tllSdzqlOYT6qfznXW3KOkOmyiRPV2c31YB2QbZ0FA9ZwLDcpszMT3nrUma?=
 =?us-ascii?Q?qN+FFZ7ylkNzAkt8V6H0km+4mIjhodjSlvhNWtahxSuBsyT8JJPAIcvPPsWb?=
 =?us-ascii?Q?1GgFJsBI/z1RS8Q7O0kl1IUtLLQ9gkJg3CHhq3CdSwknlfTMG1649Ql+FS9u?=
 =?us-ascii?Q?ZOyweNiq6qxvaGQatlAxKLzDLNyX+hDwpR5boequNmy+KQlW5Jz8Q4BtW+kq?=
 =?us-ascii?Q?WOd/JZ0ukDKZywrIuS6SGAGsUbXIQykGovB7g4s6nuXQ1HYwd8zFIUD4Ik9H?=
 =?us-ascii?Q?YVWKXNT/kS5exX+NIbE+Yc9E21WHyaJMT74I48XmqA1HQXtchHyjJZ8WLyNK?=
 =?us-ascii?Q?k94Oiktmx6ldIR7T26BbM/lS2uP4wuMWiol+juYMxA0EjV1mUpWLQybmELCO?=
 =?us-ascii?Q?VP3prPtsVRi1XRQrMfzujckQhdqZW55dGSDvSwlFIim8213mGRfnKRil6Ohw?=
 =?us-ascii?Q?/IoS4nttg5zDbu7Q6QX3oM/Z7LWqeFA6X+O5tmU+fGo9X0TrxGOl+Y/+m16b?=
 =?us-ascii?Q?WcqaetNrtRfwuYS/xFg501Da+bZrcCz1U7jtCo19CLYYq1odmSE9LhAgWbOV?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac07a31-4b35-4207-5608-08dc8e9b9125
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:03:18.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZM+usaPJnm9b9cE8z88a6ouwskeCdRJTtCUAk4JSdb+OTu4YrU4OuchI1sEvAN4QejspM/zy4uLy3+YlHTKlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6988
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_mm/migrate.c" on:

commit: 7262f208ca681385d133844be8a58d9b4ca185f7 ("mm/migrate: split source folio if it is on deferred split list")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      32f88d65f01bf6f45476d7edbe675e44fb9e1d58]
[test failed on linux-next/master 234cb065ad82915ff8d06ce01e01c3e640b674d2]

in testcase: vm-scalability
version: vm-scalability-x86_64-6f4ef16-0_20240303
with following parameters:

	runtime: 300s
	size: 8T
	test: anon-cow-seq
	cpufreq_governor: performance



compiler: gcc-13
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406171436.a30c129-oliver.sang@intel.com


[   84.214952][ T6581] ------------[ cut here ]------------
[   84.219158][ T1289] 781916337 bytes / 1533701 usecs = 497874 KB/s
[   84.219928][ T6581] kernel BUG at mm/migrate.c:2634!
[   84.225273][ T1289]
[   84.226742][ T1289] 781916337 bytes / 1533702 usecs = 497873 KB/s
[   84.231379][ T6581] invalid opcode: 0000 [#1] SMP NOPTI
[   84.236360][ T1289]
[   84.238534][ T6581] CPU: 15 PID: 6581 Comm: usemem Tainted: G S                 6.9.0-rc4-00136-g7262f208ca68 #1
[   84.238538][ T6581] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5C620.86B.0D.01.0286.011120190816 01/11/2019
[   84.246187][ T1289] 781916337 bytes / 1533701 usecs = 497874 KB/s
[ 84.249854][ T6581] RIP: 0010:migrate_misplaced_folio (mm/migrate.c:2634 (discriminator 1)) 
[   84.252050][ T1289]
[ 84.262214][ T6581] Code: a0 b4 1b 83 e8 a8 23 f6 ff 48 89 df e8 a0 3f f5 ff 45 31 e4 8b 44 24 1c 85 c0 75 10 48 8b 44 24 20 48 39 e8 0f 84 27 fe ff ff <0f> 0b 41 89 c5 65 4c 01 2d ba 1d bf 7e 48 8b 3b 48 c1 ef 36 e8 2e
All code
========
   0:	a0 b4 1b 83 e8 a8 23 	movabs 0xfff623a8e8831bb4,%al
   7:	f6 ff 
   9:	48 89 df             	mov    %rbx,%rdi
   c:	e8 a0 3f f5 ff       	callq  0xfffffffffff53fb1
  11:	45 31 e4             	xor    %r12d,%r12d
  14:	8b 44 24 1c          	mov    0x1c(%rsp),%eax
  18:	85 c0                	test   %eax,%eax
  1a:	75 10                	jne    0x2c
  1c:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  21:	48 39 e8             	cmp    %rbp,%rax
  24:	0f 84 27 fe ff ff    	je     0xfffffffffffffe51
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	41 89 c5             	mov    %eax,%r13d
  2f:	65 4c 01 2d ba 1d bf 	add    %r13,%gs:0x7ebf1dba(%rip)        # 0x7ebf1df1
  36:	7e 
  37:	48 8b 3b             	mov    (%rbx),%rdi
  3a:	48 c1 ef 36          	shr    $0x36,%rdi
  3e:	e8                   	.byte 0xe8
  3f:	2e                   	cs

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	41 89 c5             	mov    %eax,%r13d
   5:	65 4c 01 2d ba 1d bf 	add    %r13,%gs:0x7ebf1dba(%rip)        # 0x7ebf1dc7
   c:	7e 
   d:	48 8b 3b             	mov    (%rbx),%rdi
  10:	48 c1 ef 36          	shr    $0x36,%rdi
  14:	e8                   	.byte 0xe8
  15:	2e                   	cs
[   84.262217][ T6581] RSP: 0000:ffffc9002080fd08 EFLAGS: 00010206
[   84.262221][ T6581] RAX: ffffea01487467c8 RBX: ffffea0148740000 RCX: 0000000000000000
[   84.262223][ T6581] RDX: 000000000000027f RSI: 00000000000001ff RDI: 0000000000000001
[   84.262225][ T6581] RBP: ffffc9002080fd28 R08: 0000000000000000 R09: 0000000000000001
[   84.262226][ T6581] R10: 000000000000080c R11: 0000000000000000 R12: 0000000000000001
[   84.274946][ T1289] 781916337 bytes / 1533699 usecs = 497874 KB/s
[   84.279439][ T6581] R13: 00000000000001ff R14: 0000000000000200 R15: ffff88907ffd5000
[   84.279441][ T6581] FS:  00007f1b11213740(0000) GS:ffff88903f9c0000(0000) knlGS:0000000000000000
[   84.285537][ T1289]
[   84.287725][ T6581] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.287728][ T6581] CR2: 00007f1b0fe00000 CR3: 0000005f54c9e003 CR4: 00000000007706f0
[   84.287730][ T6581] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   84.287731][ T6581] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   84.308684][ T1289] 781916337 bytes / 1533744 usecs = 497860 KB/s
[   84.313094][ T6581] PKRU: 55555554
[   84.313097][ T6581] Call Trace:
[   84.313100][ T6581]  <TASK>
[   84.320929][ T1289]
[ 84.328756][ T6581] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
[   84.337626][ T1289] 781916337 bytes / 1533702 usecs = 497873 KB/s
[ 84.344414][ T6581] ? do_trap (arch/x86/kernel/traps.c:114 arch/x86/kernel/traps.c:155) 
[   84.350509][ T1289]
[ 84.358331][ T6581] ? migrate_misplaced_folio (mm/migrate.c:2634 (discriminator 1)) 
[   84.368158][ T1289] 781916337 bytes / 1533806 usecs = 497840 KB/s
[ 84.369304][ T6581] ? do_error_trap (arch/x86/include/asm/traps.h:58 arch/x86/kernel/traps.c:176) 
[ 84.369306][ T6581] ? migrate_misplaced_folio (mm/migrate.c:2634 (discriminator 1)) 
[   84.375745][ T1289]
[ 84.383566][ T6581] ? exc_invalid_op (arch/x86/kernel/traps.c:267) 
[   84.392383][ T1289] 781916337 bytes / 1537066 usecs = 496784 KB/s
[ 84.399219][ T6581] ? migrate_misplaced_folio (mm/migrate.c:2634 (discriminator 1)) 
[ 84.399222][ T6581] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[   84.405314][ T1289]
[ 84.408718][ T6581] ? migrate_misplaced_folio (mm/migrate.c:2634 (discriminator 1)) 
[ 84.408721][ T6581] ? migrate_misplaced_folio (mm/migrate.c:2630 (discriminator 2)) 
[   84.412861][ T1289] 781916337 bytes / 1533702 usecs = 497873 KB/s
[ 84.414661][ T6581] do_huge_pmd_numa_page (mm/huge_memory.c:1759) 
[   84.416855][ T1289]
[ 84.420436][ T6581] __handle_mm_fault (mm/memory.c:5429) 
[   84.427485][ T1289] 781916337 bytes / 1545381 usecs = 494111 KB/s
[ 84.430542][ T6581] handle_mm_fault (mm/memory.c:5608) 
[   84.432735][ T1289]
[ 84.438220][ T6581] do_user_addr_fault (arch/x86/mm/fault.c:1364) 
[   84.445291][ T1289] 781916337 bytes / 1545380 usecs = 494111 KB/s
[ 84.448765][ T6581] exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1514 arch/x86/mm/fault.c:1564) 
[   84.454252][ T1289]
[ 84.456445][ T6581] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[   84.456448][ T6581] RIP: 0033:0x561f6c00dad4
[   84.461953][ T1289] 781916337 bytes / 1545382 usecs = 494110 KB/s
[ 84.467077][ T6581] Code: 01 00 00 00 e8 0d f9 ff ff 89 c7 e8 6c ff ff ff bf 00 00 00 00 e8 fc f8 ff ff 85 d2 74 08 48 8d 04 f7 48 8b 00 c3 48 8d 04 f7 <48> 89 30 b8 00 00 00 00 c3 41 54 55 53 48 85 ff 0f 84 23 01 00 00
All code
========
   0:	01 00                	add    %eax,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	e8 0d f9 ff ff       	callq  0xfffffffffffff916
   9:	89 c7                	mov    %eax,%edi
   b:	e8 6c ff ff ff       	callq  0xffffffffffffff7c
  10:	bf 00 00 00 00       	mov    $0x0,%edi
  15:	e8 fc f8 ff ff       	callq  0xfffffffffffff916
  1a:	85 d2                	test   %edx,%edx
  1c:	74 08                	je     0x26
  1e:	48 8d 04 f7          	lea    (%rdi,%rsi,8),%rax
  22:	48 8b 00             	mov    (%rax),%rax
  25:	c3                   	retq   
  26:	48 8d 04 f7          	lea    (%rdi,%rsi,8),%rax
  2a:*	48 89 30             	mov    %rsi,(%rax)		<-- trapping instruction
  2d:	b8 00 00 00 00       	mov    $0x0,%eax
  32:	c3                   	retq   
  33:	41 54                	push   %r12
  35:	55                   	push   %rbp
  36:	53                   	push   %rbx
  37:	48 85 ff             	test   %rdi,%rdi
  3a:	0f 84 23 01 00 00    	je     0x163

Code starting with the faulting instruction
===========================================
   0:	48 89 30             	mov    %rsi,(%rax)
   3:	b8 00 00 00 00       	mov    $0x0,%eax
   8:	c3                   	retq   
   9:	41 54                	push   %r12
   b:	55                   	push   %rbp
   c:	53                   	push   %rbx
   d:	48 85 ff             	test   %rdi,%rdi
  10:	0f 84 23 01 00 00    	je     0x139


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240617/202406171436.a30c129-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


