Return-Path: <linux-kernel+bounces-211710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D479E9055DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41141B23D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F5F17F51D;
	Wed, 12 Jun 2024 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7hJErHn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C3017F517
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204056; cv=fail; b=VDeeAnt15KJ9U0AKGFeupWCifl34fchuzLZSfKgqW2r1krNXdOrQFjOt5cVde1CbFKC7Juxg7QMhwXvuJ4CodbO56gxeTagLMsPDfiwuxDvwN90HgjXWKn4t+icGdqzcP5miZK6OYRwsHkIo3Q8pqPrhV3XxAHS5Rzfcz7KDY7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204056; c=relaxed/simple;
	bh=xpOAM+6QR9187BV5FHwUkwng1SoC7LcI+e/OjmpszRI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wxp31ehOW5aZAyRnjfoGY5S5xx/T5i3ZLKm0lI3QIAdcRbDZx1IUSs42POYFGHukgl1UFfVE/A+z9Ll4PqPfwl+ndWwXdPZWY3GKvzWAR1i441ajF8O8Rgcrjv1x2Oddp/90dS5qpmHiOzYFKwjQNJTLpYi2DrnuzuB8ube5xMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q7hJErHn; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718204054; x=1749740054;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=xpOAM+6QR9187BV5FHwUkwng1SoC7LcI+e/OjmpszRI=;
  b=Q7hJErHnNazVfNKfWmg9iZhl+5M+f3DgpUWAXubhxwHn/os5h9fG+NQ9
   sYNLW5yZ5titWoAzVq3TW8pX3tD34ZdEJ28l/bdjndvVFqBB8HaJ7x3PD
   mglzHC9IJ/GhtKdogQtqq25GzxK7Cv6Gijx59kiJgBdIEJqmga39K3QoL
   7WW9r9lJ7MxQEwdMDewBwvGpqTgG2WsAhQzd98H/pQbqSxNQXWTWcy7ll
   Xw1h9UUGDV4Gm/J0AsSckAZXmOD7GCl7sd+aI2pRg2huq2Bxv8W6yFM+r
   2T2h/TlIeQ+2EZt/2GPnWSd3v6Q61qvIX9R9rKUDf/lcfv6p5yIYY0Yuk
   A==;
X-CSE-ConnectionGUID: uVCthMXARv2M1VADt8PP2A==
X-CSE-MsgGUID: MZBG/hUQSQSpGH7gHC62NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="37491961"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="37491961"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 07:54:12 -0700
X-CSE-ConnectionGUID: wGjt9/abT3i15XthRdrxMw==
X-CSE-MsgGUID: TG7YomPwScWhqidieWVEnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="70621196"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jun 2024 07:54:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 07:54:11 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 07:54:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 07:54:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 07:54:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIMJXlSdsuWrQoGZUmFNSqB8bBzxJq9qJXH0yDo4Sxiqy5IXilDtx52uFaNZRroWeVYVSa1D6+2MCv1Gi+PgrQDGhxYpYED3iY0NJvwdTlE8+SnsUCU+QCf33ry2/2ZBLj1jaj3Ftj88U0mqGQYeUqHrYisLXTcrdhnpjaWeeEGl45B86Os33279bviS3ZpoiimLxZg1ras64+8pYAKlvgBxcs+ils476IL+5MI3mWC/x0p/9aA2+gUw4ahpR/YOOsYlT04tLcJdH3zpKyb5PV97DUNs0C2tpFCcGfGlGeuScKMSHQVhNkR5AmJeaQUpsn2j1+ip5GrWJ8CWNqEzRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgzhfaV29Prqb+VEU7LEU+enuzXTrVav9Sv4eC6GFEk=;
 b=Qg2pkvYpKAvQ+WH+WI/gUpx6S9+0m1HxL/NJ95367UdniB7Koncj7W/WDN7QJl1DdWpb8nqf2UgD9AblQknsJCqUInna6AYALQpqZV5BZdJxEbkH3jqBxy88kZgva2xfcVK9qF1SsV98mOKT9dMuaJRBk3IfbizMqeNyD3z6b9Ry61qs+lsHtYQv6o+Q9gFE7mvB67wqpO1Tw9+AJBW1UTplm4MqkrWVhTQ6HjG7ogXa9iDw0aVYBoLRu2zsW4qYTopdDVTZefdsq5czo+jXmtwEVI2lpLgJfO0We9pHXBY+Ao202Hsr3pgEpc+JelMBaqIgCRSgsvaWITI1Xsb66w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2854.namprd11.prod.outlook.com (2603:10b6:a02:c9::12)
 by SJ0PR11MB5006.namprd11.prod.outlook.com (2603:10b6:a03:2db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 14:54:07 +0000
Received: from BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42]) by BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42%5]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 14:54:06 +0000
Date: Wed, 12 Jun 2024 10:54:04 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: =?iso-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>,
	<linux-kernel@vger.kernel.org>, <intel-xe@lists.freedesktop.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Mukesh Ojha
	<quic_mojha@quicinc.com>, Jonathan Cavitt <jonathan.cavitt@intel.com>
Subject: Re: [PATCH v6 1/2] devcoredump: Add dev_coredumpm_timeout()
Message-ID: <Zmm2jC2nx6gZ2WOn@intel.com>
References: <20240611174716.72660-1-jose.souza@intel.com>
 <49c2fbdc91d128c5249d50d016d97c8e5162f7b7.camel@sipsolutions.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49c2fbdc91d128c5249d50d016d97c8e5162f7b7.camel@sipsolutions.net>
X-ClientProxiedBy: BYAPR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:a03:100::17) To BYAPR11MB2854.namprd11.prod.outlook.com
 (2603:10b6:a02:c9::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2854:EE_|SJ0PR11MB5006:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b4289c-7636-4066-0b47-08dc8aef823c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?FrCVwJ7ZbCsWjbjvL2zr0nL2T81BKAv/k4Fq+mbyvQPjYSPQ2JC7od/dHb?=
 =?iso-8859-1?Q?Qe7Wd1SDZKl05Dh/cJTEeSkukS1yGoreJE9GEg1/RckOMgXi2EwyrQf1it?=
 =?iso-8859-1?Q?z8tUgWWUBo0efot97OPcoeT4l5Ly59lJ5fDj6BXfgZfP71arOhO555+yK0?=
 =?iso-8859-1?Q?wjj6vz8qmnKLLCVRGiF6SqwfMN4SdbbN4dIQ2Th4CGy29IPomkfpayAowI?=
 =?iso-8859-1?Q?tgdU6HoRw3yHZYnXeBOzeTe12pNnwWxfqnLI9GXp6l0U18jzGJDdIlm+hc?=
 =?iso-8859-1?Q?xBUHGuk/hfRu5rFhXQpQwIj/7AQ4z8gWqcgukxGRkZwnNJoT5VrcAv1aut?=
 =?iso-8859-1?Q?ziwdEW25yGLNY+4TVd12VL/6s5gQsC+axbw9OvEK6nhfw5r1NhxlpJR9ZA?=
 =?iso-8859-1?Q?yr5MWK0uDLGv8firG3/nTVssXWa7UjrtSiKP5UjxH+Cey6QgcnpGlpl9q9?=
 =?iso-8859-1?Q?jB0U0kAPUTQekD5PAJkFPVejPFGjpHEASNW/gs6DCLPdw4kNGpAKCHzVBI?=
 =?iso-8859-1?Q?FqHOyoMGVES5VTTe0s+s7b6oa/b2MpyOJHgtFXGA3bB7BS+XjGoJYjb4Pf?=
 =?iso-8859-1?Q?Ct3/b2s9BeZvKplGhRDxLx3KsYn5WvPI6Zog62X+csAH5JGwxXXNkmSWaA?=
 =?iso-8859-1?Q?dJ+uXFQgtHpWaMAOcgwTXlD998cy/h5PYZjGueog5x7AB7pBdiF1EoMarR?=
 =?iso-8859-1?Q?9Y5bp41mlqOYont7pTZRzHiHFC1VV+HsyVaJGbl7tJHyHIXnkuTAmfZ0Ry?=
 =?iso-8859-1?Q?Da6jMp1WA+DGsylh9Eii3yrG6HTpJq41u+2pq6N+D0Jr3yWs+yeMc4YJ+n?=
 =?iso-8859-1?Q?RlwrISbhlRLgz/WlIO75RkhSP9Cq+VUbXlYwzfOpmUaMKPv0WEXV2lMhPo?=
 =?iso-8859-1?Q?4H9Qy/3AKx74OUfd+XUa8jGc9jZL0lWUwWHCHkBCMv+169pj3vTebNDEEA?=
 =?iso-8859-1?Q?1zK4H6N7qSUjQLPpWYTtOKZBkppoH47ijXJRuEiuOJZ8mSYXPpvyG3jzdo?=
 =?iso-8859-1?Q?p9o70gNQ1oRFGXstgoBQ23AE0vTN75sTiV93Spu7KoEzujva8vLcx2Ff64?=
 =?iso-8859-1?Q?GEV8HByRiT/TLkmUZDThhdJuSXEOe9diGkcIub1x4U5O+MW3vRGRKB1siu?=
 =?iso-8859-1?Q?ioLg1rmDy5riwbQN7ZopX9qtgHzUlxdWJ/mLJzOLrvbnUwwTdEOsypw9Kk?=
 =?iso-8859-1?Q?YWZ4XG01B0/SDg1o9xePIRe2W5d8UhYyTkA+Gx8BAILXzjt+eBbvxFr4wG?=
 =?iso-8859-1?Q?QafLLA1hwMGMf5mtv97oIiAf9rUHtEMQ0+28a8FIe3yKWrdnN58f2tE3Pm?=
 =?iso-8859-1?Q?QbHfy70UjxR5lhz/Azf84+Qq/v4fHkaUJs3ry9pyJ0PjnhpQ9XfyLJpyue?=
 =?iso-8859-1?Q?vGzvoCaFSV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2854.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?iKXhzV15X9V6WMoOfyp16fcywUfe5XHpxpILq+sJkkEXNWwfzjAJkvGFBF?=
 =?iso-8859-1?Q?tGMdIFOgREQ72JYWu0FCNepG3Yp+S7bj2LmFeFd1gZBoctrx8k55FMu4XR?=
 =?iso-8859-1?Q?LFKo++U4qkjnMmRv822pZ2UU4/cZnmRHN6yf9pBwPcW9Z0qNcSr7mVtXEY?=
 =?iso-8859-1?Q?3s6Q6VQR0V5UFvLsONCpztyLai7FjmmvD4qSF9gg0+NSEYQVGoRblBOUsP?=
 =?iso-8859-1?Q?EaVmQz1CD9Ia1QoZRlDMbxKZGe5lz0GR4enIJCKfBNRylMbG9AwFClDJTN?=
 =?iso-8859-1?Q?HRWwvTGiGkHBzDaC9u2uIG7TM7UpPxew7JWaXbHFXHgyv59tJOHlT7kouU?=
 =?iso-8859-1?Q?mTcGCrP84RnJyvCcnw+aTmNx0PdYe8vBAdWKOpbk27oO1ARVUN8p0tFSkC?=
 =?iso-8859-1?Q?WBj/vanhqTlUZSgYLdFBGQkX4DRH8c2QFWAtRryf8Z0kFftQ9sdSdMONX6?=
 =?iso-8859-1?Q?KR51EfOTE9mZch7huTPWK67jXEYhB6WYeouwGYmL2rmOQNGwDL/GcabvFV?=
 =?iso-8859-1?Q?bPHaEGLn/T/uwtZI4eayrJuKskMC7WoTLTI6XkrzKj4DfYhBtXcW3xSvYa?=
 =?iso-8859-1?Q?OdndH8Kvyn+GLqNFUnC8WXBwqeIddqnKFCclYLfE8KpwrQhlvFdihZr6/K?=
 =?iso-8859-1?Q?bT5JRUtagmJWn8BSikBl9itZerkYK/eYTCADMICKf5tNfSHtn6kBom+4bl?=
 =?iso-8859-1?Q?R8dUf3A/Z2TanBj3pWQhB7zXQrS7qjQbGNucftZgv7K709cNJkNePcnppm?=
 =?iso-8859-1?Q?Nr/m0BASYL4zRaEEhkExJt7MjogHbUtrWyRx5G3K19JKeVdd7hhhY/7qZQ?=
 =?iso-8859-1?Q?1C7N5un3LYQWb4lkUZ4+Z6jNhcVr3uEGksGdLYZ+/rY7UaEgZwAojDz0+z?=
 =?iso-8859-1?Q?dKH1i4DstKUfkO/AMKhxVqMQ5B4yQTFyRnHlT305l+UbaloCzs9deSuCPX?=
 =?iso-8859-1?Q?vPJk7pcd0NFm+oatXYLSUhCoX7dGuPmtAiZRBRIgHgKZb6M5zj1qKaMTjJ?=
 =?iso-8859-1?Q?I2zwSgxMJWC1zSGvaJOengwb8oLlANVbCtoubAP0BMNdHki1to9a7et4Uy?=
 =?iso-8859-1?Q?emBiq7jTRD4gU3MPLrAD9ee7TCOhuyW3DZwFOldg8AMybrhWlljr7BzhOg?=
 =?iso-8859-1?Q?PQ4iIktuaHn2RUwM1NhRGMFAks5U6JPuV/SeAHVtWq6sclcJZaqOBAgUCT?=
 =?iso-8859-1?Q?GG+Msb0eZWM/v91lGJLtXAWizRujvx4GwgH4UKjCey1dyrKjItuV2dKKPf?=
 =?iso-8859-1?Q?zGRHocg/pXvZcpVqLhQbHjfVNCNc6lHReFUY8JhKQO/Q0mSIVQb0VlPe1X?=
 =?iso-8859-1?Q?QFgPwHc564kO5efYK8WoXpIa4Iuy3pi9+FoExZplFmR/4QzPb8y7G3kVHa?=
 =?iso-8859-1?Q?DUNmlN1M7CMIJdmm/e3xo+5bgeUpRXS6+SAy/kUSF95yC7/9naa60Vo4r8?=
 =?iso-8859-1?Q?0yZj54szfLfndv7WQ40WEFyUK4fwHcRAGAYnKYb16sOabZ2YtdmGTlIoaH?=
 =?iso-8859-1?Q?vwJ8eh+MKs0RXmcQfGhLKOpwxFLiIbq8+R88SFiAE37STh7UGJiryTGlQE?=
 =?iso-8859-1?Q?WoBVOKSurSF65RuMtlzGUKFIlTub2uzatw1lupFUMBRfglpZlbgwiBuz8O?=
 =?iso-8859-1?Q?Yc6Fd2CTYGGvJfQLfc02fFYQQ8UPntrjxg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b4289c-7636-4066-0b47-08dc8aef823c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2854.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 14:54:06.9526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLyq27WYmGxf0Fi8ZMl1nCxXA3cx1whbVSbF4oY9CIBj9rdzIQwUFmaEpei63dTegfESnnIdYZDkyHMOleLjZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5006
X-OriginatorOrg: intel.com

On Wed, Jun 12, 2024 at 02:02:37PM +0200, Johannes Berg wrote:
> On Tue, 2024-06-11 at 10:47 -0700, José Roberto de Souza wrote:
> > Add function to set a custom coredump timeout.
> > 
> > For Xe driver usage, current 5 minutes timeout may be too short for
> > users to search and understand what needs to be done to capture
> > coredump to report bugs.
> > 
> > We have plans to automate(distribute a udev script) it but at the end
> > will be up to distros and users to pack it so having a option to
> > increase the timeout is a safer option.
> > 
> > v2:
> > - replace dev_coredump_timeout_set() by dev_coredumpm_timeout() (Mukesh)
> > 
> > v3:
> > - make dev_coredumpm() static inline (Johannes)
> > 
> > v5:
> > - rename DEVCOREDUMP_TIMEOUT -> DEVCD_TIMEOUT to avoid redefinition
> > in include/net/bluetooth/coredump.h
> > 
> > v6:
> > - fix definition of dev_coredumpm_timeout() when CONFIG_DEV_COREDUMP
> > is disabled
> 
> Got to v6, heh.
> 
> I still don't think this is _right_, but I guess I'm OK with giving you
> rope to hang yourself ;-)

I do see your point. But with the udev in place, 5 min or 1 hour it shouldn't
matter right? But for users without the udev script then a long time is better
to react and learn how to capture the very first GPU hang information.

> 
> Acked-by: Johannes Berg <johannes@sipsolutions.net>

Thank you

> 
> Seems like you really should've CC'ed Greg though since these things
> usually went through his tree, so if you want to take them through yours
> he really should be at least aware ...

Indeed

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Greg, ack on getting it through drm?

> 
> johannes
> 

