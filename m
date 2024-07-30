Return-Path: <linux-kernel+bounces-266778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A569406B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776821C22681
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2171168C33;
	Tue, 30 Jul 2024 05:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jlLsEqQ7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907791361
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722315638; cv=fail; b=qVwGhhdptW0wGMQzaNsxeEr2FB+wruPLXWVfg2LMX2eVNIvzq57dAEy6ehq97qKUvKaUAys+c1kLnCczp87wKKXYmjTeoulvxYtTRCLzqBTixvgqOohDBeZqw6dd9KlsPGTHpJD8sbPmwCFzEGP3IIWeHb1VbaNwwJujyYImt2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722315638; c=relaxed/simple;
	bh=7agjSOjxMumj5sbcjwCe1oM1dtKpSK0JqxP3M90noGo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=SOer7kz/LSREkdGbmIUmFW8Dc7soaM8+0eB+19gP+UZKj4U18ZzExty1AID2wMgRxfnHlIAOuQtux1I7wClO4lCbiW8EVePN38MK+dPXLAqiyefrUBQ4WzDRhlShsWmQWVfqDXi6ZjgBHr6gmwv03EUctnneGC61RhXFWhTuy3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jlLsEqQ7; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722315636; x=1753851636;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=7agjSOjxMumj5sbcjwCe1oM1dtKpSK0JqxP3M90noGo=;
  b=jlLsEqQ7phLpsZ42PFbLjepk5MyPMn7b2XfJWjjBPf/ugfVfbO/oCgRS
   VKN9YADXSWUEJnPnIO3rqFqiPDTcFqxm66+F7t0ktEJVKAdN6K4dAakL9
   GbSl6TVS0IdFAKsRcezmmdlHXu0ECLAAybZDS/LVcerR8RIOrobmRzoyK
   L5wzhVlEjFJfk+unresNXWMhSuaJRekWMELX5r/BRbjwYlR3jCx50w4g7
   hGvpUq5xshGUnl9/phmzd/bS8niYRXZAPt5CzGKqOy7H6JD92T8JBVHgI
   2URxVAyN+t5EIqKNhhYMBXHcC4U59ld35EeiMjOeuUanUiL3PWCarLOzY
   g==;
X-CSE-ConnectionGUID: J24orO5LSLaYqVvfmDsGlA==
X-CSE-MsgGUID: PFwzv9OWRrOQuLbEuSTHSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="19708627"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="19708627"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 22:00:35 -0700
X-CSE-ConnectionGUID: vJPdOpcBRbukQKzT8vcM/g==
X-CSE-MsgGUID: f0vP6W4+SJirrZo5lrUTqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="58819951"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jul 2024 22:00:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 22:00:33 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 22:00:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 29 Jul 2024 22:00:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 22:00:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bhm01ssX1rLdcfr/3QHQuzYR8uwPe0Rs54LRkOneW+S2xwaWeFoUY0bI4yCbnpcdroFRVtiqyir/2Jv8G7hvCVSYd849v8sn7gHl06bbHM19QFAgFkCAUz5/h7da6NFoeJE79j+dTMjeEzP+D68FoprjPkGEcd09KbNXTrGF5uifgkEcAgi3X+fXsIIw43m+FJpUKiNxYqrYm8HuBuNZKp2NaIw067xbau5e+aAPhm5FDWmw/dEts2bg1sCp+tK0NXi1oPUSgNz0thYYcZn0lSf8Hij9/CNwYYwOaxhG0SICLUjSNdE8lNzSNIvOrYb9uDFALIo4OZfD9wQAYSBlyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMk2nv8nZBwhOMb7nvwNv4PfgZSPxZuxsfp0aOXXn5k=;
 b=ySiI31yjoqMb2JMvz6Ie9lbxDl88tw12NsvRoSFlmzqU6U44deI2lXJFELKlOQexTClKK6r8oo4RsqUw7OndQ9f8mH6MI8WVat0ZP+IPtJgA9jU1e5ZfRaWL194QlPAY0blJeOi6lq4rLgOG1ea4d1yQYY6Oeguu0EWYMWMcJ4fGAjNPa+6LCsaXiW+5tDH8aY/cCaeHJ1cPSYqjLJZCBcd/TdwQy6LIfmslPre1TQCdqPuMa5oDMAEq3bLg3HesrNE9l9PNbtWzwAjtodozvmB5c0Fvg5vtsnajLjXTHzTU6u3OPAZ4GoDnJTZmWoprUaROt/mnVwX+9cU/dCG0Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6333.namprd11.prod.outlook.com (2603:10b6:8:b4::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.28; Tue, 30 Jul 2024 05:00:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 05:00:30 +0000
Date: Tue, 30 Jul 2024 13:00:17 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Nathan Chancellor
	<nathan@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, WANG Xuerui
	<kernel@xen0n.name>, <linux-mm@kvack.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [mm]  c0bff412e6:  stress-ng.clone.ops_per_sec -2.9%
 regression
Message-ID: <202407301049.5051dc19-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0de374-882b-4633-da2e-08dcb05488f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?tG+dcBwZm/5c7szqcnx2zV4tMJ4azZ4ibV1uKHus1HufbhiXVhqkB9c6e0?=
 =?iso-8859-1?Q?XKGKU1C9rLaISe1TG97+57j4Kb1dPxYhY5ptUt3tKzyDm222EKk4N7ZLzi?=
 =?iso-8859-1?Q?hzGK9IdBqvyf3WHf398ifYpE+voy2+gvPLLZ42sgQwiW/uPGTok8wi+jQ3?=
 =?iso-8859-1?Q?JBSr9fk/HNlUpxa7/b/w4j8wDr792CIitEQF8VI/5ZJHT7zoZMqPXvBuG4?=
 =?iso-8859-1?Q?1GsjwqtnubG3HO3UyWW3OwpdUa1yYFcJ9yyzy/oeNZkR1sjkHIwPJEJllD?=
 =?iso-8859-1?Q?7iLnbk9TdbWotWd082/utYwFtsMDsssnDbu5sr/5Cw69a32KhsKeOQ09cE?=
 =?iso-8859-1?Q?s7nZjrKtkU3hGT988Ei+YYdlvAf+Yavj5KmdAgFndgQ3R6VAfOdIcQWLka?=
 =?iso-8859-1?Q?lrwzVaESVtot2b7i2jW9mrU/iQjoJw2Xdu1qTEsvTi0doPM+wadX5UBqOF?=
 =?iso-8859-1?Q?anbbn2E5Ompr9WZ9uzNyOzSrM94tQbfqfeV+tiEwe2tbr3/HX+YTRGFKSu?=
 =?iso-8859-1?Q?CqL1qNGbXRtELyS2L6T6V2OEbD/LXsNKz023CwAp6zYiIRDLkKCKZ7xcdx?=
 =?iso-8859-1?Q?ZQO2Dikj2WE0zvvOxq8teWcBKfwhIdJyp8apvwWH/Sewu3pPnlObTOWRY0?=
 =?iso-8859-1?Q?qhGnOObXb7CjZBQeODC2Cut35jm9SIaTa7QQbuiMQtNQxadRb3MXnzyP+D?=
 =?iso-8859-1?Q?QrY3nE5FJxHCMzi5t6oHyW4yK+OHPlc9/wymgnIXHT7CLzKLI601SjcQ5j?=
 =?iso-8859-1?Q?aMlNvNU9IuIdKkxAZwQClA6taXmqpiZRfB2nwvzUZ+ntgEil4SaLcgoJ5x?=
 =?iso-8859-1?Q?MrgXirs2VcmnlDnE+KLMCSvXTEqUxnv9fG5zEYUOKfShvyMG7Gr8i/43hW?=
 =?iso-8859-1?Q?GGNRNsBlwVz/FHSUwYxqnTzZkynytGaZZycQhPc+Du//ncy1xtLyedRVL2?=
 =?iso-8859-1?Q?423ISFGy/L19QYZxBlQ3SNnGWCVTyPUcV1bDo16uQUMlvXmzF9K6WLtV7G?=
 =?iso-8859-1?Q?aczmOyBrCRT9RndeoaKbMvFRP5W1+E8U6P5bfDTDGzJLyOnMMjAzJ3c5Fs?=
 =?iso-8859-1?Q?5P/AizWwV9X8xkq7zoLXN0ReOmvyPFtKi4/VEJU1r+A8mip+A4yBmQq9j8?=
 =?iso-8859-1?Q?3iKTh4FVvqnL696cKJ/pze27uoO9II3//JvIEHEvxdQnMhnNsY64492MGD?=
 =?iso-8859-1?Q?YlALi/F0oAtusmAwkiP8RqQf1DkqB+sn+itHsQuZ11ws7x+No5frejNHB2?=
 =?iso-8859-1?Q?NtPI4evDvgM7gFmTgnYQXwGqEjC9lrsmKDYgRud2RkDNubt1Lzd6MxNQ/s?=
 =?iso-8859-1?Q?J3G1+tryF4dcaqLEluG8i2xGLJNtPLAvGf+ekGPihN/h1Phs/ZWTN2dsrF?=
 =?iso-8859-1?Q?4GikDaMFEa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?mOSd+bi3fVPJaDmxC+RCWn9EvbaKktv2QgIqHsCQw1r02aml1XZXB5n00/?=
 =?iso-8859-1?Q?IOLMHPWhT8jxt5kc0A18KKvzJx5fjU59QP+wjgqvCMTQBsY0iZwNDHrsYH?=
 =?iso-8859-1?Q?JjobEhDL8YxyfrhW1zmE/qNRn4Xfy5g2+bZkyzcOkqnUvkEgZmn0sxjiOP?=
 =?iso-8859-1?Q?/HZ9TatwvJuZSv7POGtSZ0pBckeOZHBpocNI2O651UEUkeKdCRNL+VC1lD?=
 =?iso-8859-1?Q?K4GUmLefCRmsOFFkokKQGN5OplS0jvx0/MAGeDRaBTRnXntBIMiibf91Cz?=
 =?iso-8859-1?Q?YqahRIcXfnkNB9Afgmzy0NfcVULo3La6RHytrminEm1tQd0BNapfiiLkDK?=
 =?iso-8859-1?Q?4NWlfuCkeOOx53FlrmUDeI3Vfv8l/H2ZH2D3VFP0IMmH6opx4YVRr+k/JG?=
 =?iso-8859-1?Q?+fqRY5usXFjCPDccj4gNV0miNOLFkMGNJfg0NQb8tKXaTufy/EhZ8ZFTPX?=
 =?iso-8859-1?Q?ZVC3MQMGZgGXBWoG0S5re2PgMxto70RPBWfKpruzImZ4rhiO9xd34+0Cdk?=
 =?iso-8859-1?Q?22Qg4jkB4YoA8k/Nsil8aZXkbgpp1nfodzUpteYHBqLZCLcnJbXXzLm69k?=
 =?iso-8859-1?Q?PvxU4MB4Yt7r5mG2ALZWxJkB6yEyLMaq+6CO/RpmD+zSErosbl5Wc7koCk?=
 =?iso-8859-1?Q?HE3R9Fq1yyBAvqj8fctCezehCDBR2ALK7KCL0YFNRgr5OUeeL01Oms5qRT?=
 =?iso-8859-1?Q?o856a6D+eVExpt6o64e7Mdp7H6zwxCNaBmnvqG0UTZ93GsSP5xGWW6GcLt?=
 =?iso-8859-1?Q?lOj9Yj1mg8XAummYLLMy1I7RvbecE59GVqWtpD8HmNNYxSshRwfNikByGB?=
 =?iso-8859-1?Q?kZ4e+C4f5KHntKcB6Rqt3rnpRzNmUAa663Z6bVrsI3lhTv2lRcmbF3tPMN?=
 =?iso-8859-1?Q?4GhiOiwGDm/pPLhNYzAwQeQmeG7aet/UZGRY4I7y9/nBMq41JMimQfaAxl?=
 =?iso-8859-1?Q?k3PV/rdFwidDcbsnRRu9RaXfSojmHWTdHddWfhKbD0xYxNHC0wd7WyMYis?=
 =?iso-8859-1?Q?kRMGF8vWO62NYoTHkf5qkV1GcS8bQS7ycKW1L8/QWgNPLcA99R/0CROsdk?=
 =?iso-8859-1?Q?BiraOIx20gojhZdBOcFCawuZvvR6+hG2xkqRntBGVNpQgg1qYn2YFlUP7+?=
 =?iso-8859-1?Q?5SklggKe5KLPaZO/qxWnc45QXr7lGBVi9RqbMnkKF4V21OZQnlCnhOI97l?=
 =?iso-8859-1?Q?xuXzT820qsYQH1pPfsphmrd7Yy5PjC3t3iCyHUVfYcBNSjiD7ZFLHJtgjf?=
 =?iso-8859-1?Q?ijhkKd7+2o+2mZT8cAc5n16E/mfQ2Ykg6d9rZvqA7jb3725qEHKdqwZCcl?=
 =?iso-8859-1?Q?akudRjiEyOBqYqlFvQ2VZnLKLezv+ofGn31pzg8S7BIEt0aD06aQbiiuDl?=
 =?iso-8859-1?Q?Ov35ZujyD+CKktcKTjutddK/aNo3c2QUJ/FJIVc55wUvvzKuaPWK2D2L+V?=
 =?iso-8859-1?Q?tfarCNVmbYb5NacnSimys4vnfLDLsPjfE3FL41Yz2OfPeuRc9gCufpE/q7?=
 =?iso-8859-1?Q?yJDtEQMg340o1ep/qV6jxIewoZ3PPm9sxuGjnZ3gA/rZI3RHoHrpahtEht?=
 =?iso-8859-1?Q?zdjXDA4zc6bOnEJqCkvVv5AdwkPkoNOKLiy5c0mKwUkPd7J1iN6ya+CBgM?=
 =?iso-8859-1?Q?jrUSow4O77gkKZdcXQU+tmIjE0Yrlx5YY/2W2oD7HHiNfWSx3QFKRr1A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0de374-882b-4633-da2e-08dcb05488f8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 05:00:30.5234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTHD3OzEi501Ij5bRHfSJ7cvaLSF5N1jGlGvBa7cqdXSpABcvaIpAXXEwG8UT18184A3Blc2nfcCZOdliXEO6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6333
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -2.9% regression of stress-ng.clone.ops_per_sec on:


commit: c0bff412e67b781d761e330ff9578aa9ed2be79e ("mm: allow anon exclusive check over hugetlb tail pages")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: clone
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407301049.5051dc19-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240730/202407301049.5051dc19-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/clone/stress-ng/60s

commit: 
  9cb28da546 ("mm/gup: handle hugetlb in the generic follow_page_mask code")
  c0bff412e6 ("mm: allow anon exclusive check over hugetlb tail pages")

9cb28da54643ad46 c0bff412e67b781d761e330ff95 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     37842            -3.4%      36554        vmstat.system.cs
      0.00 ± 17%     -86.4%       0.00 ±223%  sched_debug.rt_rq:.rt_time.avg
      0.19 ± 17%     -86.4%       0.03 ±223%  sched_debug.rt_rq:.rt_time.max
      0.02 ± 17%     -86.4%       0.00 ±223%  sched_debug.rt_rq:.rt_time.stddev
     24081            -3.7%      23200        proc-vmstat.nr_page_table_pages
    399380            -2.3%     390288        proc-vmstat.nr_slab_reclaimable
   1625589            -2.4%    1585989        proc-vmstat.nr_slab_unreclaimable
 1.019e+08            -3.8%   98035999        proc-vmstat.numa_hit
 1.018e+08            -3.9%   97870705        proc-vmstat.numa_local
 1.092e+08            -3.8%   1.05e+08        proc-vmstat.pgalloc_normal
  1.06e+08            -3.8%  1.019e+08        proc-vmstat.pgfree
   2659199            -2.3%    2597978        proc-vmstat.pgreuse
      2910            +3.4%       3010        stress-ng.clone.microsecs_per_clone
    562874            -2.9%     546587        stress-ng.clone.ops
      9298            -2.9%       9031        stress-ng.clone.ops_per_sec
    686858            -2.8%     667416        stress-ng.time.involuntary_context_switches
   9091031            -3.9%    8734352        stress-ng.time.minor_page_faults
      4200            +2.4%       4299        stress-ng.time.percent_of_cpu_this_job_got
      2543            +2.4%       2603        stress-ng.time.system_time
    342849            -2.8%     333189        stress-ng.time.voluntary_context_switches
      6.67            -6.1%       6.26        perf-stat.i.MPKI
 6.388e+08            -5.4%  6.045e+08        perf-stat.i.cache-misses
 1.558e+09            -4.6%  1.487e+09        perf-stat.i.cache-references
     40791            -3.6%      39330        perf-stat.i.context-switches
    353.55            +5.4%     372.76        perf-stat.i.cycles-between-cache-misses
      7.95 ±  3%      -6.5%       7.43 ±  3%  perf-stat.i.metric.K/sec
    251389 ±  3%      -6.5%     235029 ±  3%  perf-stat.i.minor-faults
    251423 ±  3%      -6.5%     235064 ±  3%  perf-stat.i.page-faults
      6.75            -6.1%       6.33        perf-stat.overall.MPKI
      0.38            -0.0        0.37        perf-stat.overall.branch-miss-rate%
    350.09            +5.8%     370.24        perf-stat.overall.cycles-between-cache-misses
  68503488            -1.2%   67660585        perf-stat.ps.branch-misses
  6.33e+08            -5.4%  5.987e+08        perf-stat.ps.cache-misses
 1.518e+09            -4.6%  1.449e+09        perf-stat.ps.cache-references
     38819            -3.3%      37542        perf-stat.ps.context-switches
      3637            +1.2%       3680        perf-stat.ps.cpu-migrations
    235473 ±  3%      -6.3%     220601 ±  3%  perf-stat.ps.minor-faults
    235504 ±  3%      -6.3%     220632 ±  3%  perf-stat.ps.page-faults
     45.55            -2.5       43.04        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
     44.86            -2.5       42.37        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
     44.42            -2.1       42.37        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     44.42            -2.1       42.37        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     44.41            -2.1       42.36        perf-profile.calltrace.cycles-pp.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
     44.41            -2.1       42.36        perf-profile.calltrace.cycles-pp.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
     39.08            -1.7       37.34        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
     38.96            -1.7       37.22        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.__x64_sys_exit
     38.97            -1.7       37.24        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.__x64_sys_exit.do_syscall_64
     36.16            -1.6       34.57        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
     35.99            -1.6       34.40        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
     32.17            -1.5       30.62        perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     12.49            -1.0       11.52        perf-profile.calltrace.cycles-pp._compound_head.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      9.66            -0.9        8.74        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.copy_process.kernel_clone
      9.61            -0.9        8.69        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.copy_process
     10.71            -0.9        9.84        perf-profile.calltrace.cycles-pp.__mmput.copy_process.kernel_clone.__do_sys_clone3.do_syscall_64
     10.70            -0.9        9.84        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.copy_process.kernel_clone.__do_sys_clone3
     10.41            -0.8        9.58        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range
     10.42            -0.8        9.59        perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     10.21            -0.8        9.40        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
      5.47            -0.4        5.04        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range
      1.11            -0.3        0.79 ± 33%  perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
     14.18            -0.3       13.87        perf-profile.calltrace.cycles-pp.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      5.17            -0.3        4.86        perf-profile.calltrace.cycles-pp.put_files_struct.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.80            -0.3        4.53        perf-profile.calltrace.cycles-pp.filp_close.put_files_struct.do_exit.__x64_sys_exit.do_syscall_64
      4.40            -0.3        4.14        perf-profile.calltrace.cycles-pp.filp_flush.filp_close.put_files_struct.do_exit.__x64_sys_exit
      2.74            -0.2        2.58        perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
      2.25            -0.1        2.11        perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
      1.47            -0.1        1.34        perf-profile.calltrace.cycles-pp.put_files_struct.copy_process.kernel_clone.__do_sys_clone3.do_syscall_64
      1.87            -0.1        1.76        perf-profile.calltrace.cycles-pp.dnotify_flush.filp_flush.filp_close.put_files_struct.do_exit
      1.98            -0.1        1.88        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
      1.28            -0.1        1.18        perf-profile.calltrace.cycles-pp.filp_close.put_files_struct.copy_process.kernel_clone.__do_sys_clone3
      1.19            -0.1        1.09        perf-profile.calltrace.cycles-pp.filp_flush.filp_close.put_files_struct.copy_process.kernel_clone
      1.31 ±  2%      -0.1        1.25        perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput.exit_mm
      0.58            -0.0        0.55        perf-profile.calltrace.cycles-pp.vm_normal_page.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
     33.54            +0.6       34.10        perf-profile.calltrace.cycles-pp.syscall
     33.45            +0.6       34.01        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     33.45            +0.6       34.01        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
     33.35            +0.6       33.90        perf-profile.calltrace.cycles-pp.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     33.34            +0.6       33.90        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     33.30            +0.6       33.86        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.63            +1.6       22.21        perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone3.do_syscall_64
     20.55            +1.6       22.14        perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone3
     19.40            +1.8       21.19        perf-profile.calltrace.cycles-pp.__clone
     19.24            +1.8       21.04        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
     19.24            +1.8       21.04        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__clone
     19.14            +1.8       20.94        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
     19.14            +1.8       20.94        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
     19.05            +1.8       20.85        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.74            +1.8       20.56        perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
     18.67            +1.8       20.49        perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
     12.24            +3.1       15.35        perf-profile.calltrace.cycles-pp._compound_head.copy_present_ptes.copy_pte_range.copy_p4d_range.copy_page_range
     34.37            +3.7       38.02        perf-profile.calltrace.cycles-pp.copy_page_range.dup_mmap.dup_mm.copy_process.kernel_clone
     34.34            +3.7       38.00        perf-profile.calltrace.cycles-pp.copy_p4d_range.copy_page_range.dup_mmap.dup_mm.copy_process
     30.99            +3.7       34.69        perf-profile.calltrace.cycles-pp.copy_present_ptes.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
     33.16            +3.7       36.88        perf-profile.calltrace.cycles-pp.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap.dup_mm
      0.00            +3.9        3.90        perf-profile.calltrace.cycles-pp.folio_try_dup_anon_rmap_ptes.copy_present_ptes.copy_pte_range.copy_p4d_range.copy_page_range
     49.67            -2.6       47.07        perf-profile.children.cycles-pp.exit_mmap
     49.69            -2.6       47.08        perf-profile.children.cycles-pp.__mmput
     45.84            -2.5       43.32        perf-profile.children.cycles-pp.unmap_vmas
     45.56            -2.5       43.05        perf-profile.children.cycles-pp.zap_pmd_range
     45.61            -2.5       43.10        perf-profile.children.cycles-pp.unmap_page_range
     44.98            -2.5       42.48        perf-profile.children.cycles-pp.zap_pte_range
     44.53            -2.1       42.48        perf-profile.children.cycles-pp.__x64_sys_exit
     44.54            -2.1       42.48        perf-profile.children.cycles-pp.do_exit
     39.10            -1.7       37.36        perf-profile.children.cycles-pp.exit_mm
     32.99            -1.6       31.41        perf-profile.children.cycles-pp.zap_present_ptes
     10.53            -0.8        9.71        perf-profile.children.cycles-pp.tlb_flush_mmu
     10.91            -0.7       10.19        perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
     10.88            -0.7       10.16        perf-profile.children.cycles-pp.free_pages_and_swap_cache
      6.64            -0.4        6.22        perf-profile.children.cycles-pp.put_files_struct
      5.76            -0.4        5.38        perf-profile.children.cycles-pp.folios_put_refs
      6.11            -0.4        5.73        perf-profile.children.cycles-pp.filp_close
      5.62            -0.4        5.25        perf-profile.children.cycles-pp.filp_flush
     14.28            -0.3       13.97        perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      2.75            -0.2        2.58        perf-profile.children.cycles-pp.anon_vma_fork
      2.38            -0.2        2.22        perf-profile.children.cycles-pp.dnotify_flush
      2.50            -0.1        2.36        perf-profile.children.cycles-pp.free_pgtables
      2.25            -0.1        2.11        perf-profile.children.cycles-pp.anon_vma_clone
      0.20 ± 33%      -0.1        0.08 ± 58%  perf-profile.children.cycles-pp.ordered_events__queue
      0.20 ± 33%      -0.1        0.08 ± 58%  perf-profile.children.cycles-pp.queue_event
      1.24 ±  4%      -0.1        1.14        perf-profile.children.cycles-pp.down_write
      1.67 ±  2%      -0.1        1.58        perf-profile.children.cycles-pp.unlink_anon_vmas
      1.59            -0.1        1.50        perf-profile.children.cycles-pp.__alloc_pages_noprof
      1.55            -0.1        1.46        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      1.58            -0.1        1.50        perf-profile.children.cycles-pp.vm_normal_page
      1.11            -0.1        1.04        perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      1.33            -0.1        1.26 ±  2%  perf-profile.children.cycles-pp.pte_alloc_one
      0.47 ± 11%      -0.1        0.40 ±  4%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.45 ± 11%      -0.1        0.38 ±  4%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      1.00            -0.1        0.94 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      1.36            -0.1        1.31        perf-profile.children.cycles-pp.kmem_cache_free
      1.08            -0.0        1.04        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.62            -0.0        0.58 ±  2%  perf-profile.children.cycles-pp.dup_fd
      0.63            -0.0        0.59 ±  3%  perf-profile.children.cycles-pp.__pte_alloc
      0.73            -0.0        0.69        perf-profile.children.cycles-pp.__tlb_remove_folio_pages_size
      0.58            -0.0        0.54        perf-profile.children.cycles-pp.locks_remove_posix
      0.90            -0.0        0.86        perf-profile.children.cycles-pp.copy_huge_pmd
      0.54            -0.0        0.51        perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.76            -0.0        0.72        perf-profile.children.cycles-pp.vm_area_dup
      0.31 ±  2%      -0.0        0.28 ±  3%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.50            -0.0        0.47        perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      0.53            -0.0        0.50        perf-profile.children.cycles-pp.clear_page_erms
      0.49            -0.0        0.46        perf-profile.children.cycles-pp.free_swap_cache
      0.72            -0.0        0.69        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.37 ±  2%      -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.unlink_file_vma
      0.62            -0.0        0.60        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.42            -0.0        0.40 ±  2%  perf-profile.children.cycles-pp.rmqueue
      0.37            -0.0        0.35 ±  2%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.28            -0.0        0.25        perf-profile.children.cycles-pp.__rb_insert_augmented
      0.35            -0.0        0.33 ±  2%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.56            -0.0        0.54        perf-profile.children.cycles-pp.fput
      0.48            -0.0        0.46        perf-profile.children.cycles-pp._raw_spin_lock
      0.51            -0.0        0.50        perf-profile.children.cycles-pp.free_unref_page
      0.45            -0.0        0.43        perf-profile.children.cycles-pp.__x64_sys_unshare
      0.44            -0.0        0.42        perf-profile.children.cycles-pp.free_unref_page_commit
      0.45            -0.0        0.43        perf-profile.children.cycles-pp.ksys_unshare
      0.31            -0.0        0.30        perf-profile.children.cycles-pp.memcg_account_kmem
      0.27            -0.0        0.26        perf-profile.children.cycles-pp.__mod_memcg_state
      0.44            -0.0        0.43        perf-profile.children.cycles-pp.__slab_free
      0.28            -0.0        0.26        perf-profile.children.cycles-pp.__vm_area_free
      0.22 ±  2%      -0.0        0.21        perf-profile.children.cycles-pp.___slab_alloc
      0.21            -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.__tlb_remove_folio_pages
      0.13            -0.0        0.12        perf-profile.children.cycles-pp.__rb_erase_color
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.find_idlest_cpu
      0.09            -0.0        0.08        perf-profile.children.cycles-pp.wake_up_new_task
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.kfree
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.11            -0.0        0.10        perf-profile.children.cycles-pp.allocate_slab
      0.44 ±  2%      +0.1        0.53 ±  2%  perf-profile.children.cycles-pp.tlb_finish_mmu
     98.24            +0.2       98.46        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     98.24            +0.2       98.46        perf-profile.children.cycles-pp.do_syscall_64
     33.55            +0.6       34.10        perf-profile.children.cycles-pp.syscall
     33.35            +0.6       33.90        perf-profile.children.cycles-pp.__do_sys_clone3
     19.41            +1.8       21.20        perf-profile.children.cycles-pp.__clone
     19.14            +1.8       20.94        perf-profile.children.cycles-pp.__do_sys_clone
     24.94            +2.1       27.07        perf-profile.children.cycles-pp._compound_head
     52.48            +2.4       54.84        perf-profile.children.cycles-pp.kernel_clone
     52.36            +2.4       54.72        perf-profile.children.cycles-pp.copy_process
     39.38            +3.4       42.77        perf-profile.children.cycles-pp.dup_mm
     39.24            +3.4       42.64        perf-profile.children.cycles-pp.dup_mmap
     34.34            +3.7       38.00        perf-profile.children.cycles-pp.copy_p4d_range
     34.37            +3.7       38.03        perf-profile.children.cycles-pp.copy_page_range
     33.28            +3.7       36.98        perf-profile.children.cycles-pp.copy_pte_range
     31.41            +3.8       35.18        perf-profile.children.cycles-pp.copy_present_ptes
      0.00            +4.0        4.01        perf-profile.children.cycles-pp.folio_try_dup_anon_rmap_ptes
     18.44            -3.2       15.24        perf-profile.self.cycles-pp.copy_present_ptes
      5.66            -0.4        5.28        perf-profile.self.cycles-pp.folios_put_refs
      4.78            -0.3        4.46        perf-profile.self.cycles-pp.free_pages_and_swap_cache
     14.11            -0.3       13.80        perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      4.82            -0.2        4.59        perf-profile.self.cycles-pp.zap_present_ptes
      2.66            -0.2        2.49        perf-profile.self.cycles-pp.filp_flush
      2.36            -0.2        2.20        perf-profile.self.cycles-pp.dnotify_flush
      0.20 ± 32%      -0.1        0.08 ± 58%  perf-profile.self.cycles-pp.queue_event
      1.44            -0.1        1.36        perf-profile.self.cycles-pp.zap_pte_range
      1.11            -0.1        1.03        perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      1.26            -0.1        1.20        perf-profile.self.cycles-pp.vm_normal_page
      0.56            -0.0        0.52 ±  2%  perf-profile.self.cycles-pp.dup_fd
      0.56            -0.0        0.53        perf-profile.self.cycles-pp.locks_remove_posix
      0.31            -0.0        0.28        perf-profile.self.cycles-pp.put_files_struct
      0.58            -0.0        0.55        perf-profile.self.cycles-pp.__tlb_remove_folio_pages_size
      0.49            -0.0        0.46 ±  2%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      0.30 ±  3%      -0.0        0.28 ±  3%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.52            -0.0        0.49 ±  2%  perf-profile.self.cycles-pp.clear_page_erms
      0.31            -0.0        0.29        perf-profile.self.cycles-pp.free_swap_cache
      0.33            -0.0        0.31        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.45            -0.0        0.43        perf-profile.self.cycles-pp._raw_spin_lock
      0.55            -0.0        0.53        perf-profile.self.cycles-pp.fput
      0.38            -0.0        0.36        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.47            -0.0        0.45        perf-profile.self.cycles-pp.up_write
      0.26            -0.0        0.24        perf-profile.self.cycles-pp.__rb_insert_augmented
      0.33            -0.0        0.32        perf-profile.self.cycles-pp.mod_objcg_state
      0.31            -0.0        0.30        perf-profile.self.cycles-pp.__free_one_page
      0.09            -0.0        0.08        perf-profile.self.cycles-pp.___slab_alloc
     24.40            +2.1       26.55        perf-profile.self.cycles-pp._compound_head
      0.00            +3.9        3.89        perf-profile.self.cycles-pp.folio_try_dup_anon_rmap_ptes




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


