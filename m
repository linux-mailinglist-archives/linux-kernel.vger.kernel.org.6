Return-Path: <linux-kernel+bounces-208973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336CC902B39
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492081C2139B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C7C14F13D;
	Mon, 10 Jun 2024 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJHMScjM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69A914D6FF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056836; cv=fail; b=PVpBmyXUP1JJKXmn8cBRat7PC/TxrLcqPcwDf0IMsumGBkq5AWxBtwc1c6g8vYctxrYYWGJ1mNNeQVp0MjDOkWtvZSp6EqtZufilOXKmZvKfPx++rpBei42k9wpFZHLKkjwy4Qg3ATO07pyTImRmoZYYqQd+LHfWnjUm0xc/Jfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056836; c=relaxed/simple;
	bh=oRewLqH5eIMW6lDbf6VF35QHIIp4lLHuuRbVs1M61XQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wmh1PFmc9wyZodrEhsbjEP512ggfnYz0odJDRf/X1h1ZJqoL+gOLR5tn/WHTHLLHXf9cCOhO1gSsi1+K5p8gBr+/781wPoENnBgsvb5MZyLOKtoK0soyPTk90PunM61kASN4QUnQSK02m7BvaPUUtdwbs9KzmTvdd2khCJXttQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJHMScjM; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718056834; x=1749592834;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=oRewLqH5eIMW6lDbf6VF35QHIIp4lLHuuRbVs1M61XQ=;
  b=PJHMScjMWj0ph1NmVD5vYboRw+ORqr5GRs9RmyNdJDQeFvTEiheZb3y0
   vq5ScTXo4cJ6agRKsD5Zv8bIFs1fbHZ9bGYRdeT+HJ5T+zEPmndxXQ9OP
   sDDOOZVursRTN/gHiOQI+I0Yo8B7DNRVD0/kRFW6LXh6dfF6DwwUeH0Kx
   xOoo95sDsv/TEFrzouDjHAGv1YkHaeCp62Hp3zzt16PKkGacjoR/eCE2l
   1SAl/ycYsSFrGb7/uy4H/bBT8ywXntoFzPvHn4P9dpBhXHYXKtmmsP+VX
   uJiUOpBFy4nYVewGX94okqQU1/Efcwob+c8nKOMyRc8U9vhSFiUCg7EUm
   A==;
X-CSE-ConnectionGUID: KnPvD+QxTCGe+ibcKG5lVA==
X-CSE-MsgGUID: rwWxQpgBRsCnePhXCT24tg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="25857359"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="25857359"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 15:00:34 -0700
X-CSE-ConnectionGUID: jPW0SJtLTIOIOTf0Z9vu1A==
X-CSE-MsgGUID: 77zqDLwGTKGUID4vNwmHyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="44335717"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jun 2024 15:00:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 15:00:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 15:00:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 15:00:32 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 15:00:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXTf+R5C+YErjdasok+oQ9iB0pM8nVxPuLX+w8uRC+9YOPHw+uIv26pPLsj2MUa+Mo5w+M9J5eLOTT4iqJFEegVHNliOn+/YdgNHND/7pOo/qNPzoVPGroSbUYupUwWiFTpazgq1R/cNmjZGnUhWFAhGlLA32FM7Z6J05Q/YoJhJCraZegD5ljhbACe5jJrL4m4MvlAz9Ef+wMhIp6LG4YBctgHlVVHZxzpQWWx0peRIBPeX8206ta8ASgXw84aalaZzLBRDYrSoMKd2EK1CIDLlqFJJPUz0CvsdLYyAz78qaXysx/rbZVUMJ1nOjovBVroPnrMPy3//bgDkEbNW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvWKMgtwz0iQOSVKnYMoUl59PnUxKlgYWP/6ZHQJJs4=;
 b=L9ZL9LzaYLfdWFE8k3lJZ56beA17BjfjMJ8Bibz3jol/NDRyNseyw04bswEbMqFV2nuiE7IlwxAGAkfmx68lq2VOGS1KF6nhlnm/OIpWTcj7GSgjdikP6b+R8f1EG0e3nfXYiTU9AnB0mGHtjUiQ/1GquDjrJvzvljphxZEIupyk5CfgScKoiYIlIZg207VapuzRpZDr8lhKNhwnIxj2sPoFqwEK0P6Xmm9vLHDsSmcYCXwxsBWiG6puGYM9kyCAWtY4for9p08LfQ+gPc6sH0rT4pvTafjlYI8shaMDesYTPnIhnrnINfrrAsqE/ZSjML9vsgJbqkXscdl8KS7zYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2854.namprd11.prod.outlook.com (2603:10b6:a02:c9::12)
 by CH3PR11MB7250.namprd11.prod.outlook.com (2603:10b6:610:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 22:00:24 +0000
Received: from BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42]) by BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42%5]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 22:00:24 +0000
Date: Mon, 10 Jun 2024 18:00:21 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Souza, Jose" <jose.souza@intel.com>
CC: "Cavitt, Jonathan" <jonathan.cavitt@intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"quic_mojha@quicinc.com" <quic_mojha@quicinc.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] devcoredump: Add dev_coredumpm_timeout()
Message-ID: <Zmd3SdVjfjBo-KnL@intel.com>
References: <20240610161133.156566-1-jose.souza@intel.com>
 <ZmdfCDCQSZIsAWOQ@intel.com>
 <CH0PR11MB5444A6196C5AC7D3AE960FD3E5C62@CH0PR11MB5444.namprd11.prod.outlook.com>
 <f40ea3ddb5434715335b4634f38011ccd79e870c.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f40ea3ddb5434715335b4634f38011ccd79e870c.camel@intel.com>
X-ClientProxiedBy: BY3PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::19) To BYAPR11MB2854.namprd11.prod.outlook.com
 (2603:10b6:a02:c9::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2854:EE_|CH3PR11MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 92087ba0-9cb5-4367-97f9-08dc8998bac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?T5NF8cNRYsr6JumF73yKhRvZ4xu3wfwcoHzFrmbzaQQfpGJtMlTtTrQt4n?=
 =?iso-8859-1?Q?pkjLRpkpJ36QKMRtUNLwEP4tWhtmA3XPJ705u/RbreHGcZeq+DHTVpxsNO?=
 =?iso-8859-1?Q?+NYiYmLWje8nPwtQUhz6MCW+scEpHp4pgNVN/+q2o2uTVLU+BNsfVRqg0i?=
 =?iso-8859-1?Q?PlekukAyGwPGdqSXFYzqCJcZ1I7Xog2WcDB2pP7lw/NVOem268hSurwzXE?=
 =?iso-8859-1?Q?N1MJ7g2eGEw8ci9X3M6Knkq+AwUUue9QG9pNAwrLW2b3o3m3uaM6FzhW3C?=
 =?iso-8859-1?Q?wi0uNMh1+hQHV1fCVKKl3nvFFml+E8wTlGsXujnOcLDRWWrXqfrdorOIuT?=
 =?iso-8859-1?Q?L/w3nFsfgQs6H0lDkK/7ImOcjkoX2kWWbrpWK7HAskN6lAjTzfZruM1lgD?=
 =?iso-8859-1?Q?1u9wvZmNTp6Er+nLu82hLg6hO4NxFC4PkTyUk6SsupL4XCgken6iHfQdRV?=
 =?iso-8859-1?Q?iqRIyZkDCWJvGjlBue1+2jdekHkl4XB0hdp1nMMDTzbqFPffkbE6XiLSzG?=
 =?iso-8859-1?Q?mHkmeoYy7WqO3GBTuTtngg3w3luBhJ+YxBCPb7FWRvCqnGRNl2+/okkZBr?=
 =?iso-8859-1?Q?mlp8VXk6vYN1VtXrUKTk91/IJGl/C8nQfeNL2wZ2R7A4tepRNalaImmXYT?=
 =?iso-8859-1?Q?cAtRkrvmEYKiITvBPJNvq7vnAn67+lafX55h/F1ZRFrI/bnFNB4wXXAjEX?=
 =?iso-8859-1?Q?lP8MgxU2TAkqOoQ9i06IG0/gQoqxlvLsGEiNDzsGtnyUcyzuSghevobhIH?=
 =?iso-8859-1?Q?+TxlQzQHsnlN+hcM2072s/dXnPapAX/4i+t+stw3NnwW5M3Ys7qxlhiRtY?=
 =?iso-8859-1?Q?IuhyGhlsLIRl8pIE7JKM9chwMEFuMHYF0pjpiq+kPrm0F6xIjpjG2woTiN?=
 =?iso-8859-1?Q?GcU7/g02q7NZ3S05Dq8036WccRcslJv5OzlIeRaKMIMveIh1x4JE1aYwZv?=
 =?iso-8859-1?Q?cqrYGWLeMkrDxxPlUi+IRqmySLYZdytLQnnG9mn84kHt4HlDGUcotm7dm0?=
 =?iso-8859-1?Q?94zVY4+lRxjw/tK8poj+LiViFMMk9rqO1OQilqHUijHB+7uP4q9rxUjPZ8?=
 =?iso-8859-1?Q?sGhQqdYYozQXojxq8t8zlw7E2oJbGVl91liUZ+oN1IF3GJ+E6S+a7EbknT?=
 =?iso-8859-1?Q?caNmri0+1NZJ2zzOEGzlT0/3EJlaR4CLmN0KUhch8Ut338igN6HXIQMCOL?=
 =?iso-8859-1?Q?wQkVJGBJ4osVqvfj4lyRyL/66KANgfEqrYXgQSjRhq6schzBLrCP5WWOrW?=
 =?iso-8859-1?Q?pIxbnSeQett+IVNihymLmgNKaDSNkpLIYZuitcnj1Z4kNJyID5nrsgnpra?=
 =?iso-8859-1?Q?3ZUhO2vT76mXFfy3VUmuICCb99LciZvwHDnCyJ4pIzRg8LMY8ds5qYBpDd?=
 =?iso-8859-1?Q?OYWPSgMqdL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2854.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+T1+txu7fGtD8VcaqiQ4nUk0RMl/qFQJEl/cmB8Hnmzhl4gnFN17wPlK/5?=
 =?iso-8859-1?Q?Z8G9NMvgzy8tHo609fqX4IetntmHfIYm7Hko4NuKjzVvrvpzRnNexeYPIJ?=
 =?iso-8859-1?Q?VdmfQYsM2FWOyRl8MGUCZlU/Tjiyti2Hzr1j5DqLn4GuANc+sr6CcsAHkU?=
 =?iso-8859-1?Q?y2GfaybvKR7Bd0s/tpoZ5APiCsuYiVnvTAW0hVEaVSa8djoOdiKofbWDQO?=
 =?iso-8859-1?Q?DFbgUhu59d/puGD+WnzU/zmEnFHEKDOiV3Nc1GJlZJpoBIXmIb5nTf0MVD?=
 =?iso-8859-1?Q?7SVnVUVDwnHOw6FGzaRtrPgqa9VCyCsWtQaOlMsnUcTXcvlLHXiKy3pbLH?=
 =?iso-8859-1?Q?NBg6s/aTPdlpx0gLhHCyEVigyh5pyNPWWQ5yJw1Xn2K+V4sV2BjjryZAoN?=
 =?iso-8859-1?Q?S7keAZngFNRxjnv8P9rdKZs+96zs5sk/YW2a7BUQKc2vZiJFcDnsQETBOD?=
 =?iso-8859-1?Q?geF7arSpQEc1xF/4WrIkk2KCwWLkjlilPK46VOSP1hvThHrpqPeCDe1S9R?=
 =?iso-8859-1?Q?ycVIoM6nvxPD2iPs9Ik8Z8zydKnOruIHmh1PXjPssfK1gKCqKbPrrBIGaI?=
 =?iso-8859-1?Q?oJ0lnfhEQNyvMWt3tlIYQHtP6idIaZLe7iIMkIWfwuIew42d38kU7opfUQ?=
 =?iso-8859-1?Q?K5QyJH7BQ6hGRAsyzz9Ql114BPXb4PyD2YK6uKcU9qJBW++WcXIBWC2BCK?=
 =?iso-8859-1?Q?XVwMmewBTCgThi5B5IQOsK7DrhFBaIOVFN3oPHnzcfkRT6EJGphUOJgvYI?=
 =?iso-8859-1?Q?sWlUapbfmqmwHRsZpMzOiHX8kXRsEXGu+uKt5wtiA6qYzbjCB/xNufCrK8?=
 =?iso-8859-1?Q?PHOj7P+ZqR7zD/gTBgIPOghMF3gsBkRBM67IF7ZTWYe5ynhyCiFtfcXtqK?=
 =?iso-8859-1?Q?2eZc9Qi84DKgYQm6PrQ6A2HDL0197AVLxH91jD/7/zszYx2bZuiPJ/GpW3?=
 =?iso-8859-1?Q?jxsEKPpSrpAwngPD4dkc6dZOvB4lZJfdFEPiHSX64vqn7tG/FYZe6a8ULd?=
 =?iso-8859-1?Q?xUWCKTbliGijwqPQVHUSkdBOV8WJbeKthytxQDYmKo4AoM4mhajfuA0gRd?=
 =?iso-8859-1?Q?oGoZFJph17dFIEiQV4X8cAFufr/dXHXA2kOLo6sUkv6pcpXzYybp/hM6Rl?=
 =?iso-8859-1?Q?CBhTQtt6QsVqDBP22YwMlOO+xder9Oiv+QsjvHabepMH63S+/ea5BHcH/5?=
 =?iso-8859-1?Q?KBcR4RobHpQAN236vWmpmSrZQBh8+LBQzqTQ2bfCJujz22/yPYn9DXdF5f?=
 =?iso-8859-1?Q?Jd2udKFZDaDBkbtawo5C6ZBqTktQ8ooNsEgpPDcGjeaRMtfCKeD1/TjysD?=
 =?iso-8859-1?Q?3DEtCZDBcBWFCqnaQN4DrXC52tQcm9P8P2BoSskyG1Xb3h1sx637qHkncG?=
 =?iso-8859-1?Q?uJw6gRA4YpDBuHjAwZ+T9fxdMq/nkCRUp57cJHcMsXhHywZRgYiF/5qpbN?=
 =?iso-8859-1?Q?VHx/1eZ4UD74gW5DQn04vIdX8Z6i9RCdP0K3/bP+OHrgzKcvrOj3xo/5QU?=
 =?iso-8859-1?Q?Tp+QTcsel6m+2JJL9T9ugG5bQPRhAzDPgthlEK6WiMd1hhQyJJV4gJ5ZMq?=
 =?iso-8859-1?Q?/yFe/JpTgv7GxXYQfGCJzROxg1SouCiP4sOOlJLF09VUL3UD/djGXCXGB4?=
 =?iso-8859-1?Q?nMrA4rH16Vi5Gy5YpeMAZRUrFLaryx2fJznnIUMWQJeYXTBGfENFR3iA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92087ba0-9cb5-4367-97f9-08dc8998bac9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2854.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 22:00:24.3769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saGOhMnP7GB3z5CG23ulVhAbgvZNgdGe6G1GhAGBR7rJTkQ/YqYgOPbpznQScmmek/I4SSUsB9BTEwlYnkBvJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7250
X-OriginatorOrg: intel.com

On Mon, Jun 10, 2024 at 04:52:11PM -0400, Souza, Jose wrote:
> On Mon, 2024-06-10 at 20:42 +0000, Cavitt, Jonathan wrote:
> > -----Original Message-----
> > From: Vivi, Rodrigo <rodrigo.vivi@intel.com> 
> > Sent: Monday, June 10, 2024 1:16 PM
> > To: Souza, Jose <jose.souza@intel.com>
> > Cc: linux-kernel@vger.kernel.org; intel-xe@lists.freedesktop.org; Mukesh Ojha <quic_mojha@quicinc.com>; Johannes Berg <johannes@sipsolutions.net>; Cavitt, Jonathan <jonathan.cavitt@intel.com>
> > Subject: Re: [PATCH v5 1/2] devcoredump: Add dev_coredumpm_timeout()
> > > 
> > > On Mon, Jun 10, 2024 at 09:11:32AM -0700, José Roberto de Souza wrote:
> > > > Add function to set a custom coredump timeout.
> > > > 
> > > > For Xe driver usage, current 5 minutes timeout may be too short for
> > > > users to search and understand what needs to be done to capture
> > > > coredump to report bugs.
> > > > 
> > > > We have plans to automate(distribute a udev script) it but at the end
> > > > will be up to distros and users to pack it so having a option to
> > > > increase the timeout is a safer option.
> > > > 
> > > > v2:
> > > > - replace dev_coredump_timeout_set() by dev_coredumpm_timeout() (Mukesh)
> > > > 
> > > > v3:
> > > > - make dev_coredumpm() static inline (Johannes)
> > > > 
> > > > v5:
> > > > - rename DEVCOREDUMP_TIMEOUT -> DEVCD_TIMEOUT to avoid redefinition
> > > > in include/net/bluetooth/coredump.h
> > > > 
> > > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > 
> > > Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > 
> > > > Cc: Mukesh Ojha <quic_mojha@quicinc.com>
> > > > Cc: Johannes Berg <johannes@sipsolutions.net>
> > > > Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > > > Acked-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > > 
> > > Jonathan, also ack to merge this through drm-next flow?
> > 
> > Ack clear for drm-next flow.  Actually, you can upgrade that to a
> > Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > I provided the Ack back before I knew I was allowed to provide
> > Reviewed-bys, or that they were different from Acks even in my
> > case.  I trust that my past-self who originally reviewed this meant
> > for the Ack to be a stand-in as a non-committal RB.
> 
> 
> Thanks you both but I think we need wait for an ack from Johannes or Mukesh to merge this devcoredump patch.
> On my other devcoredump patch already merged we also ask from a Greg's ack to merge it through drm-next.

My bad. I'm sorry.
Of course I meant to ask ack from Johannes there. I though he had acked this
approach already.

> 
> 
> > 
> > -Jonathan Cavitt
> > 
> > > 
> > > > Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
> > > > ---
> > > >  drivers/base/devcoredump.c  | 23 ++++++++--------
> > > >  include/linux/devcoredump.h | 54 ++++++++++++++++++++++++++++---------
> > > >  2 files changed, 54 insertions(+), 23 deletions(-)
> > > > 
> > > > diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> > > > index 82aeb09b3d1b5..c795edad1b969 100644
> > > > --- a/drivers/base/devcoredump.c
> > > > +++ b/drivers/base/devcoredump.c
> > > > @@ -18,9 +18,6 @@ static struct class devcd_class;
> > > >  /* global disable flag, for security purposes */
> > > >  static bool devcd_disabled;
> > > >  
> > > > -/* if data isn't read by userspace after 5 minutes then delete it */
> > > > -#define DEVCD_TIMEOUT	(HZ * 60 * 5)
> > > > -
> > > >  struct devcd_entry {
> > > >  	struct device devcd_dev;
> > > >  	void *data;
> > > > @@ -328,7 +325,8 @@ void dev_coredump_put(struct device *dev)
> > > >  EXPORT_SYMBOL_GPL(dev_coredump_put);
> > > >  
> > > >  /**
> > > > - * dev_coredumpm - create device coredump with read/free methods
> > > > + * dev_coredumpm_timeout - create device coredump with read/free methods with a
> > > > + * custom timeout.
> > > >   * @dev: the struct device for the crashed device
> > > >   * @owner: the module that contains the read/free functions, use %THIS_MODULE
> > > >   * @data: data cookie for the @read/@free functions
> > > > @@ -336,17 +334,20 @@ EXPORT_SYMBOL_GPL(dev_coredump_put);
> > > >   * @gfp: allocation flags
> > > >   * @read: function to read from the given buffer
> > > >   * @free: function to free the given buffer
> > > > + * @timeout: time in jiffies to remove coredump
> > > >   *
> > > >   * Creates a new device coredump for the given device. If a previous one hasn't
> > > >   * been read yet, the new coredump is discarded. The data lifetime is determined
> > > >   * by the device coredump framework and when it is no longer needed the @free
> > > >   * function will be called to free the data.
> > > >   */
> > > > -void dev_coredumpm(struct device *dev, struct module *owner,
> > > > -		   void *data, size_t datalen, gfp_t gfp,
> > > > -		   ssize_t (*read)(char *buffer, loff_t offset, size_t count,
> > > > -				   void *data, size_t datalen),
> > > > -		   void (*free)(void *data))
> > > > +void dev_coredumpm_timeout(struct device *dev, struct module *owner,
> > > > +			   void *data, size_t datalen, gfp_t gfp,
> > > > +			   ssize_t (*read)(char *buffer, loff_t offset,
> > > > +					   size_t count, void *data,
> > > > +					   size_t datalen),
> > > > +			   void (*free)(void *data),
> > > > +			   unsigned long timeout)
> > > >  {
> > > >  	static atomic_t devcd_count = ATOMIC_INIT(0);
> > > >  	struct devcd_entry *devcd;
> > > > @@ -403,7 +404,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
> > > >  	dev_set_uevent_suppress(&devcd->devcd_dev, false);
> > > >  	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
> > > >  	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
> > > > -	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
> > > > +	schedule_delayed_work(&devcd->del_wk, timeout);
> > > >  	mutex_unlock(&devcd->mutex);
> > > >  	return;
> > > >   put_device:
> > > > @@ -414,7 +415,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
> > > >   free:
> > > >  	free(data);
> > > >  }
> > > > -EXPORT_SYMBOL_GPL(dev_coredumpm);
> > > > +EXPORT_SYMBOL_GPL(dev_coredumpm_timeout);
> > > >  
> > > >  /**
> > > >   * dev_coredumpsg - create device coredump that uses scatterlist as data
> > > > diff --git a/include/linux/devcoredump.h b/include/linux/devcoredump.h
> > > > index c8f7eb6cc1915..e3de1e545a4a5 100644
> > > > --- a/include/linux/devcoredump.h
> > > > +++ b/include/linux/devcoredump.h
> > > > @@ -12,6 +12,9 @@
> > > >  #include <linux/scatterlist.h>
> > > >  #include <linux/slab.h>
> > > >  
> > > > +/* if data isn't read by userspace after 5 minutes then delete it */
> > > > +#define DEVCD_TIMEOUT	(HZ * 60 * 5)
> > > > +
> > > >  /*
> > > >   * _devcd_free_sgtable - free all the memory of the given scatterlist table
> > > >   * (i.e. both pages and scatterlist instances)
> > > > @@ -50,16 +53,17 @@ static inline void _devcd_free_sgtable(struct scatterlist *table)
> > > >  	kfree(delete_iter);
> > > >  }
> > > >  
> > > > -
> > > >  #ifdef CONFIG_DEV_COREDUMP
> > > >  void dev_coredumpv(struct device *dev, void *data, size_t datalen,
> > > >  		   gfp_t gfp);
> > > >  
> > > > -void dev_coredumpm(struct device *dev, struct module *owner,
> > > > -		   void *data, size_t datalen, gfp_t gfp,
> > > > -		   ssize_t (*read)(char *buffer, loff_t offset, size_t count,
> > > > -				   void *data, size_t datalen),
> > > > -		   void (*free)(void *data));
> > > > +void dev_coredumpm_timeout(struct device *dev, struct module *owner,
> > > > +			   void *data, size_t datalen, gfp_t gfp,
> > > > +			   ssize_t (*read)(char *buffer, loff_t offset,
> > > > +					   size_t count, void *data,
> > > > +					   size_t datalen),
> > > > +			   void (*free)(void *data),
> > > > +			   unsigned long timeout);
> > > >  
> > > >  void dev_coredumpsg(struct device *dev, struct scatterlist *table,
> > > >  		    size_t datalen, gfp_t gfp);
> > > > @@ -72,12 +76,13 @@ static inline void dev_coredumpv(struct device *dev, void *data,
> > > >  	vfree(data);
> > > >  }
> > > >  
> > > > -static inline void
> > > > -dev_coredumpm(struct device *dev, struct module *owner,
> > > > -	      void *data, size_t datalen, gfp_t gfp,
> > > > -	      ssize_t (*read)(char *buffer, loff_t offset, size_t count,
> > > > -			      void *data, size_t datalen),
> > > > -	      void (*free)(void *data))
> > > > +void dev_coredumpm_timeout(struct device *dev, struct module *owner,
> > > > +			   void *data, size_t datalen, gfp_t gfp,
> > > > +			   ssize_t (*read)(char *buffer, loff_t offset,
> > > > +					   size_t count, void *data,
> > > > +					   size_t datalen),
> > > > +			   void (*free)(void *data),
> > > > +			   unsigned long timeout)
> > > >  {
> > > >  	free(data);
> > > >  }
> > > > @@ -92,4 +97,29 @@ static inline void dev_coredump_put(struct device *dev)
> > > >  }
> > > >  #endif /* CONFIG_DEV_COREDUMP */
> > > >  
> > > > +/**
> > > > + * dev_coredumpm - create device coredump with read/free methods
> > > > + * @dev: the struct device for the crashed device
> > > > + * @owner: the module that contains the read/free functions, use %THIS_MODULE
> > > > + * @data: data cookie for the @read/@free functions
> > > > + * @datalen: length of the data
> > > > + * @gfp: allocation flags
> > > > + * @read: function to read from the given buffer
> > > > + * @free: function to free the given buffer
> > > > + *
> > > > + * Creates a new device coredump for the given device. If a previous one hasn't
> > > > + * been read yet, the new coredump is discarded. The data lifetime is determined
> > > > + * by the device coredump framework and when it is no longer needed the @free
> > > > + * function will be called to free the data.
> > > > + */
> > > > +static inline void dev_coredumpm(struct device *dev, struct module *owner,
> > > > +				 void *data, size_t datalen, gfp_t gfp,
> > > > +				 ssize_t (*read)(char *buffer, loff_t offset, size_t count,
> > > > +						 void *data, size_t datalen),
> > > > +				void (*free)(void *data))
> > > > +{
> > > > +	dev_coredumpm_timeout(dev, owner, data, datalen, gfp, read, free,
> > > > +			      DEVCD_TIMEOUT);
> > > > +}
> > > > +
> > > >  #endif /* __DEVCOREDUMP_H */
> > > > -- 
> > > > 2.45.2
> > > > 
> > > 
> 

