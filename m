Return-Path: <linux-kernel+bounces-549919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EABA55897
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8AA1898E09
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5721207E15;
	Thu,  6 Mar 2025 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a9bnj96y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F96206F2C;
	Thu,  6 Mar 2025 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295895; cv=fail; b=F2YmkRuN7Oq8FnoKqMg3upa/RHDeFUTlsDrB6GozE03pMVVeue14y8V4LtwB64DIV4fXnhvyqoMaDf33taazAQEKr6/W3YekX6AQGWpo5eijySVrMKuoi44ZwSBbOdQC0h9oseyhodANSEUyEA0cl7FZEz88EW+U2Pw1DfkkBQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295895; c=relaxed/simple;
	bh=Dur7iocYJtAlaLooZPmHNcV0v3GILgyBzNj6zFEyJwU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uidUP0ZNIP8gjqCtt7SeJh4wW9HGe+T1CkuIzCzvLFG6AD8hbYxEb+lfYueTW4KbzGOgCZZRh6BpMWhOqhxrNUtL08zscyhUfng9rwJfjxID7CQ2yKta2blpOy4vtBbSl9iFCC+0Cmu/gP3Z7J+ycduU4yVp2fy0JuwXnuU4EBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a9bnj96y; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741295892; x=1772831892;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Dur7iocYJtAlaLooZPmHNcV0v3GILgyBzNj6zFEyJwU=;
  b=a9bnj96yATLmM85KGUQeePq6hhMXeZO69fEYdLPLTbsocDpnQ2pWGYTI
   N7+UimOTGATAoIZJtrptDAqn4s6I8O5KlFVfHC3ul0HvVJQ9mdlYrCY5a
   XJ0XSSOxc3EO4aaIw2j2ZPvqoqnrBFyxOpxKuRc9ag35LMPtSTKJunXu2
   JsZAUAdasLCuyucwATdYmeKnN8II1yaqN7HQAYw8EYUqb9bT3Eejsly/q
   UF3t0/O5gH/staYQ8KoEr/hIPHJTd1BqHyPROrY5qktxkWcqIDj6+06V6
   OcKA9+QUpQMtFv3oEBErp060bcOQ5kUuDLjMP8iWwcd9at0i4o5aj1Bbs
   w==;
X-CSE-ConnectionGUID: msNE93xcQQWguIig3h1rFg==
X-CSE-MsgGUID: Ia+OD00rTd62XKAVGFQX8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42244968"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42244968"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:18:11 -0800
X-CSE-ConnectionGUID: j0/iaNHbQpSMkrE/ujmV7w==
X-CSE-MsgGUID: 7/EGbjZFQ220NueyQeEG8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="124229900"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2025 13:18:11 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Mar 2025 13:18:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 13:18:10 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 13:18:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xL51FbL3bWFZ/C4I+DYefWbQIyPVji+rdI9Ku4pO+yqGd1/0Deyd/NdSRbB+5oi/JmqdMu+uC/qjoG8WMnjlqdMTCz/fX2vI3riqQ1AgZ6n4SBt5RU3TkwcDxeTKb+edWiVW78AfxGLuqmAjIBKnBqiFozyClbopQj+qkeMUDEGxqWNkfzor5FNAiCE3DoKxMP7RXA8eCe2GeWDWMvn9ogKpbmCBm25p1tdcb8XPDmBzdbthdKzSMzVBDsHXKNnXfjG5ZPu6SAm+kTLiRfO7ofPw/x6LzxCT3ttesL8qfmopahWJvYabsc6UvhpjmheFBjL8V9FAhkMyo1hiEo5a3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDppp6FPg/2WDHhreHBMg1XLDR4tUl/z2FXFCR4ISIs=;
 b=r/lWKOXrLzVyiGB2InFzbXaM0biL7J6m5X+GMEbgrTZvSO/Oid/lsqxZt5UVRxO/w9WCMWxnh8Berk5oYaW5x4tRJP+xdkHWTI1XEBhI6ZYMEj4VY5AKsXF3O2TAv6eLryg967Neo8C5r9XiJPsbnBlQGITyItdvtPpiDtP0kJBZb9tDxgd4Fqx7+7pIBht0s7xl7LAsYw2hVAVCFyU4WjSjd0PJYfHgZAXico4SpYu9QYWP7jMv9fSrk5N9B/UXpnh9XBgTtjyLPOp7wTPw7PP5ctiixA6vOajcODgwadu1MAqqYYF4CgIsV8ENvm3sBuVXvcwU14NdWfmgB/vvjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB8022.namprd11.prod.outlook.com (2603:10b6:806:2fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 21:18:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:18:07 +0000
Date: Thu, 6 Mar 2025 13:18:04 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Shuah Khan <shuah@kernel.org>, <gregkh@linuxfoundation.org>,
	<corbet@lwn.net>
CC: Shuah Khan <shuah@kernel.org>, <workflows@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<conduct@kernel.org>, <tab@lists.linux.dev>, Miguel Ojeda <ojeda@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] Documentation/CoC: Spell out the TAB role in
 enforcement decisions
Message-ID: <67ca110c9ce4b_1a7729493@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250306211231.13154-1-shuah@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306211231.13154-1-shuah@kernel.org>
X-ClientProxiedBy: MW4PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:303:b9::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 137b579b-a3df-4aad-d364-08dd5cf46394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v3A7oKa9klpkRA4UCbNNj7KPIR501Ro8lTyntjx5ERV7BU0RwKp944UzRQq+?=
 =?us-ascii?Q?gh1nhKax5S2G7ivseahzaZvohZ0/s0AxcDGIZUtdOaL10IoWilsiYAnR0hA6?=
 =?us-ascii?Q?t86pEQl/D9WHuiMHEecVIpc+5JnH4lf2/ULp8yJDz4hc0Nt1ghNXYmUPejgr?=
 =?us-ascii?Q?AfVKwlkuDtZydscr34Am5H9i+2V6sIdK8zjPGCwjfhPXDJNH1C417XSQEndx?=
 =?us-ascii?Q?JrBM701fz/mLcVdoHKOZasWT9HbKmrNBOBCA+qH4C0Wa/IAa8LFI6QTi5QHB?=
 =?us-ascii?Q?EX/wODP08osdFoxiErAnDA5BoKVEJtBN9ysETGN0C5H13jSRSmBQVA1D/571?=
 =?us-ascii?Q?2bbChk+Qn7ng2DFnKGfshzJy06LkiIc0SCm5HLZD4sJ9tgph41awbN6cvK34?=
 =?us-ascii?Q?JnFmqh7aKdQruiS4ceEjVY0ST8o21tkdFL4sliMdrXGPsk4Ix0tO432k3C2N?=
 =?us-ascii?Q?4aXiEaDrzmE5wHDp5yzGLTU2LbxDXXU5sZbHYD6fX82fva4Y1vTKLazfW333?=
 =?us-ascii?Q?T/X9tdxV35BdTIVirvv8d9qjdBhekOBqLVs/R216dJiULNtwLJK9E1jddH+Y?=
 =?us-ascii?Q?J5WVGYPtndWwEhEOjRAoliQ4Ang7RrJjvF63V3ajW7FuR7rPphgjNCTMgV5r?=
 =?us-ascii?Q?C4b7PrQVgoDe7PF5t9Tnb8jqRmzj1PZCLozWEdu501lt+yFwZxmFVzG0CXwm?=
 =?us-ascii?Q?xtqSWsB2aG01caWpLCJA7XcGmiRAS6BNLtqmFxFT71dwJWx9hETBizTnP7pv?=
 =?us-ascii?Q?6ifI82AdLCGwgCJWEYluEKfI4MBa8LMlMD0XLV16YmZ3Y+WuSESvT1LNkl+g?=
 =?us-ascii?Q?Uwnu/hBg0VMB0jM/gVVtWqu29oOY8EMwJ9KIWC8XQHk5gWSBYMtf/Web9VPg?=
 =?us-ascii?Q?wF02tGtEC1zC8sDwghcCqCu5JHbfHiCZY+gWk2JCS4XgGYLFQPW4me6myxVF?=
 =?us-ascii?Q?C4cN398BbQr04VJkgbjL/05FW/+5rW1M5TsgPEnfQLsk5TU7Jd/BUbKbFz+6?=
 =?us-ascii?Q?uQSmjkBdYnOfUbEOsx+3AlYRFvu5lWP4VRAPrfx1+sk9sN4XsnLH1haDpRWW?=
 =?us-ascii?Q?5nk+e8cQgtoSTFpqbSiHaf241QFY2h5QCQjdKPwV2dxW7ZoMGcTjAF/fw71u?=
 =?us-ascii?Q?dEIkEGyn6JkYwTAONHSDjbTb6xtfgqOIneDVwLkW1IuNOovbqQfSOfDY9h9v?=
 =?us-ascii?Q?nHA8Zod8g/kcvSMK80PhN354jBzAlzk+yPTfkIVHbck3dYgutD9HuSzF9fT+?=
 =?us-ascii?Q?pu9MkcTDiZ5aoAWfEBxUQexf80Ibz/Yw9MV1a/iRS7ZmCxx0QH0vvVIJPFY5?=
 =?us-ascii?Q?gIHTtSzt+mfHKfbLaHdxqxuFfLia5a1HTPXv7IIh4fSlSwxKNXxjqUfbSNrC?=
 =?us-ascii?Q?olQnPwS0YjxBN7GohQVJDdBGVo6T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f+eLIXggFq+AbKXXsgYiBdtFrp/V7UTJm1dhqCkrlbw4nqI/M7hUGlaKaYa2?=
 =?us-ascii?Q?/ZfgBubaIAohgbnoYRGU7qRm6iAxIcPnmnO3esMMiHD8rbn/NAwv/09X4vWz?=
 =?us-ascii?Q?HHUOlSTEGXrgqOgLzcZ8SuYwFt52Ieg/QcWtmg97mkt7a98zbagoKHc9EMz0?=
 =?us-ascii?Q?fENmSAnfVf5YN7icLopgZOqypu3ZWKokXfeELtZ6mQRYRHtiodhhqwO5ZIR/?=
 =?us-ascii?Q?g36MBU/S5l0tVDxl5c7grkLEVaTUCy5APJFNh1ZmG15HaQI1ZjNqxe0oJjsI?=
 =?us-ascii?Q?dk0SYAB7GoGh03w0eurg7K7XMWVeF7KO3ZY+rxYjhdp4YtJR+R36ekC6zkRt?=
 =?us-ascii?Q?TueW3gBL5k1BTSIpUSRFBUpx1rHtouyP7vmQtP82O/OmIYMsV4ijsWjymuTo?=
 =?us-ascii?Q?Xcg9b7V+ScWAlhREhq/sdrOkr5dGW+zBKX9Qp+AYNLhwaIFAITbsuqiVPk9r?=
 =?us-ascii?Q?EtzlW4O5v/tA/EP9E8aMCOJd8Y/X1DtQjZ2ys/zfgzfSo0cN/V4F3ELtSZBZ?=
 =?us-ascii?Q?aAmDrd1XZphHD517lJkvL0bFjaPR7iyGF5W+GTHCjdSNqJfA6AUQF2FVn6CR?=
 =?us-ascii?Q?zWwVD7iYctV6WfCfHC98PxA7CztEK2LyxGqloeT+6EA+tqufY6bJurrqRLS5?=
 =?us-ascii?Q?Nayw6SW4Dsen+O4pIP4eWWTJAkjlbJWrWn1QRpkZgXKn4ot7nFxTgcr6ipA+?=
 =?us-ascii?Q?AgBeZRaWsXRxQ6d5A30v9gxU/Imx4eckeMOfxGQkRJcPy+evvSK/qp8ofodw?=
 =?us-ascii?Q?a6YNBBhbMgTVExu44wRPc+ryrYhBx6jpT57GgjhGqnyq5dkKPFaxpyr+OG95?=
 =?us-ascii?Q?WZLQYPmGVtD099gGBetEO/ydDII8x6Xr6cavCB/1iXIzO3KCxdtOvualrL8l?=
 =?us-ascii?Q?0noR0ecAEWmFZujcoM4VvrMWIfjHOcmRgRa8HHhRVCRCa9rAgFfHt6q+GXSn?=
 =?us-ascii?Q?/KH4yPRhrWCI/TnKZ2M3VodwkVQne3pF04eNrqs03k0d3kF2KLD2Yfcyr4va?=
 =?us-ascii?Q?2+ocYIc7Z2cofyIqhSQKyCn3rwGh2QZeueIMalrjZ7xZ2HmV1vm3h9r3TRTR?=
 =?us-ascii?Q?1X61GNrjODHyS+fmNx8JkjjwgNpVEIN3I5V/upwxAqEqthxssHCcyig6jrjx?=
 =?us-ascii?Q?Z3NbmMNrZuDJ5hN3DSAjHf7kFs4CnOz2CHVNsIUdw+XXLyN6sUxSvaG4v1Vj?=
 =?us-ascii?Q?KmCkL7UnBsDbMzg+8WVysR4uHtDqtGJD6fA9vQte3wv+RAzTsob+/RYcg+ku?=
 =?us-ascii?Q?aR+amQ8UJKLV5g1k+2gyEmQVB2Kr+hcRzT+UlYI+JpJN2iCehbMVnVPH0oV1?=
 =?us-ascii?Q?cKIR7j+JhWkOelnTTHPB8gVbCInqa4HirAn24rkKweW8WZwxPbtRGzV6sDs+?=
 =?us-ascii?Q?VE+Rcct4Ld2BK7N61rzfd+SuyLo/9oNWOUCWHP0WDOd6WJKM5C5Pd1/K3BxP?=
 =?us-ascii?Q?fhqDlTyeZ3R+MuBR4QQZktjYM/r4ksCOacBgZDYig6JdvrTYmdmcnR1Iv6Kg?=
 =?us-ascii?Q?Au2eRtlz7jcJ2f0RWyHzf8Mi9r78ntvaInUDQ4dkVktbW7GX5bbL/IySfXuE?=
 =?us-ascii?Q?GySmb8GffvofYoPeGISFP39r0jNSoRnHc4qq8xNu7YALD5ZAaG6wlcFJ7ZoQ?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 137b579b-a3df-4aad-d364-08dd5cf46394
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:18:07.0140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msjTiH+rPLVUIXO/5tTQC0EdLpK6FyKt4ooyp6K4CLCL+q5QqvyB9KttILC9SzTmAY8+FR2iRgp09DTihwSyFK+PnCz/Yho9BH/skAFOtds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8022
X-OriginatorOrg: intel.com

Shuah Khan wrote:
> Updates the document to clearly describe the scope and role the TAB plays
> in making decisions on unresolved violations. If and when the CoC has to
> make a call on instituting a ban, it doesn't act without the TAB's approval
> and only when the TAB approves it with 2/3 vote in favor of the measure.
> 
> These changes ensure that the TAB role and its oversight on CoC measures
> is consistently described throughout the document.
> 
> Fixes: c818d5c64c9a8cc1 ("Documentation/CoC: spell out enforcement for unacceptable behaviors")
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
> Acked-by: Jonathan Corbet <corbet@lwn.net>

Acked-by: Dan Williams <dan.j.williams@intel.com>

