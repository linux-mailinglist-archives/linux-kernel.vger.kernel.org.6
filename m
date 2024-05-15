Return-Path: <linux-kernel+bounces-179627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D11B18C6284
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A298B229F4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF784CB5B;
	Wed, 15 May 2024 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1uPgqte"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1EF48CCD
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715760426; cv=fail; b=LH8UWFyNbd/Y0omUNwECrAwjcKWhj5mF9x6oX3Fe02hNs9GSA94QrW6+eFI2vt3CvKEom8z2x3XXcImZAoOFlksh1CvyqMNgrmjdF2BsOJOoFn7Ar/SQ69Ws6TGZXFt9TjB/iounME/3tVOpUfhl45cVIH75jse9Qrdzzc18pmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715760426; c=relaxed/simple;
	bh=dBfMrB+dt/Ar6tbdrAOnYiGoIbvj3iB9aoq09KtXgew=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PiDXs8AG0LBq6EKDUs8pTAnw9y7h+IG1uVaNATD5puOl7xFFaOIW0oIKDSNbb4WmqaqU5XokDKfvSLfHYHE2R0bEleNcW4yRIkrSv4Kk8I1uJXVLkpdUKdtJVY42Cx7kK357lOC2Ah309WgHVjx/BRmmsNO3ukJ7DA5jrpfcYuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1uPgqte; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715760425; x=1747296425;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=dBfMrB+dt/Ar6tbdrAOnYiGoIbvj3iB9aoq09KtXgew=;
  b=h1uPgqteXrQye34o/BtyYcGuUoGrv6pQfs2T50uvZc9ESLhPPLPoihfD
   lKNyIWvPaG3G2vLB6uc9QBrkgsejqOFabyjlUofdv6m1Mj8D1h46sAUS6
   71HMoCnnqdA8Y7FazZlvawUbZDIVgvB3/Ly99kU+Cyy6IU19IcC4yCS/s
   5EIUZzh76jlKSrpF10v87znGsq/aBorFY3d6PJ1rs0bAp0k2VSVVFVtOV
   lLLCBKpQ+wtdJQkbMpAhJ9Wa9iSm9jyRtDSldGWc+pR6QWiVrRr/fccA8
   8p+DQASQ0z2G7aX82W5tlnIUl0UwYDG4GCcHerYbA1tGdtqqGm5aeS9R5
   A==;
X-CSE-ConnectionGUID: amFGtzvNRtaZyD/ogmADKA==
X-CSE-MsgGUID: 9Bq3twkQSY6qwqX2WkG9rA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11959477"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="11959477"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 01:07:04 -0700
X-CSE-ConnectionGUID: zyhs/daXRBOUlrI7rrspzw==
X-CSE-MsgGUID: lfl2+38rQRK3JJpbKYMn4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="68426139"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 01:07:04 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 01:07:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 15 May 2024 01:07:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 01:07:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7Vqqv0qX1TE+Dasyol6hu8mCZpj1Kr+V6HHeInYs6AYyCFQrGe1tG+Nycx92bsbr2NE8g5lZkCFoNUqZvmxlvrmy9Dz/xneqMa8zk5dU1Zne7ykxCP6z1k0SUdCTkDphyFQkZKWtivQdWMfs4xjtSEWVm/+xolyv7bD9Wzpajvrbr3rzNU9OGiQf2xZAQRwZKEFUVcOJE6yCDg7zY92nIQV7wbnek5NJ0oTgeoKHBtFhBrboPCdoNJC+2Qr4mdI5PxzqK3PlYiL52II+8o+cM5n8l7WxIl1SbTGho3coCCRH044HEXiz5xkZfYC6X7ri1Uxtd+PMhdzBRp3j07OAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyKGCa4DLHpKXSlWy8SmL+q+Z8b6t1itVQ9yBvMdK7Y=;
 b=fV01RiZ+ebyH1xRMGsveQTSNLIvJsRYHKL4NRKKh5plYxrbYHEyiFX5yPN+eqG0cp8tM8L0N/WMg5AUFioBl0/Yqf7a37t+aKrPum0yt2iTPK0dFilumlsWBReqYBUSjtaKvqt4Hl0u/2k7x9EOBju4OamN+kjucdfSY5C5waPZW34QqExHWKbHw4L0iMGcMiRt3WpRv2gn0/Zz6073F6J+ww9E8jpzeJS8aO4V4sJxrXJP3dSAcPi9IoElhs8PLD9xNLyYmyrCUdyp5MMeILidjw8bLVp1h9bqdKmQ3owKd4Z7I89aPyOKfSXtkDFyUenG9MPYu0cWO4rf2PLt9cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB8122.namprd11.prod.outlook.com (2603:10b6:510:235::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 08:07:01 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 08:07:01 +0000
Date: Wed, 15 May 2024 16:06:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Frederic Weisbecker <frederic@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen
	<anna-maria@linutronix.de>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [timers/migration]  61f7fdf8fd:
 netperf.Throughput_Mbps 2.7% improvement
Message-ID: <202405151553.6423572f-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: a490d4d7-fae1-4a1a-9774-08dc74b5ff9e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?kOZryVj32vdiYc91BBHSvyw1JJKWH5GS9rlTY7HhNS5Gafsfyh5K4j4Fpd?=
 =?iso-8859-1?Q?/eXoeybUA8+06tvIBs2M2nJWs/1aaw9S0B0rSvcbMuF9obe3UYMBVJ6Ple?=
 =?iso-8859-1?Q?hKTY61jeC/l2M2fMAslp/wjUjMXHMVxmu8OJaWA4np/Srbh3v0ZvEx9SoO?=
 =?iso-8859-1?Q?4tLlwSO7oF4qqb9lTPcgWPIgHioHxOePLKoGoLL+5o+AEEDTeqF1P9k7Zq?=
 =?iso-8859-1?Q?qrUMTA+X/ZWt5hQjvxqJZt779EXyCbxsZtcN9cnG8ABA28HSjrMJWCCMex?=
 =?iso-8859-1?Q?daFcmCT9OMVrg5bUf25LZiOW4gVcE/YL3n5JlM4/UOMsI2IbJaeGDlr0YD?=
 =?iso-8859-1?Q?Hv17de1ZviOUUqIxQI/7lt9kniT8tnlCaiB+rdSH7N1gnl4mHGHDCs+Ypc?=
 =?iso-8859-1?Q?bMxs8v1gevjIxn0MoONOcc9+n5EFhTWaUtOMg1NgX8BtFG5h2hWwj5fLcM?=
 =?iso-8859-1?Q?kAbH9O33aX6uYoZxNHwNCwvrH+3ADWKN7258iSolfNXNRt/VLSHFjvGaO8?=
 =?iso-8859-1?Q?WAoWcu0+a2H82kf7YS4+eZJpACuRVY3XkZZdh/FYolchUTmpKWVhVB6R55?=
 =?iso-8859-1?Q?fT0sNX9PWzD1hVHrOyfmjwD0jVyoontaTiL3fItFyHHGKPoF2Xi2yeQC5g?=
 =?iso-8859-1?Q?dww9nYaXsFS9kbihN+Aj9jh7F+rONqL5m1aNKpC0ff1K0mA4AK/DaCIXU4?=
 =?iso-8859-1?Q?ZkZIO3E442VvN0F+MAuP+S7+PBqPVEqn8avbDUw1R2A7rbsRM4xiu6hK/W?=
 =?iso-8859-1?Q?E2slGCgpFVqG4Z4Ymw65ztT7QURoBb6oACW1uw/mfEkf391UIOfk17NLAG?=
 =?iso-8859-1?Q?yFFcmbhmJeUsyW4oXT8kA1sexPjCbJV0qPXVIMiPnFlLxsZHwlUf5sfNpt?=
 =?iso-8859-1?Q?r0krgxU7iHYiE3lma1UoKCb+QrxWOnW3mtDXwIXFYkPR8KSyOBIyMMQ6pD?=
 =?iso-8859-1?Q?AKoXRGfCz+M7E/pmh1UUlDNsaZTQNSy/wAPTSdko+9xAZkNPwnioTHSc9H?=
 =?iso-8859-1?Q?HHAwnDOdXqtPHn+ElUas6Y3Ux2ehd28G3Vz4XvY4ymhN3bQ/ev0cH36geZ?=
 =?iso-8859-1?Q?mfcJqiX1m3PXc6AcpgSB0okxXuJi9u2rCzuhofJGLKScMY969SolY3hIBS?=
 =?iso-8859-1?Q?Gr6p+wLFEZMGs6WZ97d2z4Hsqz3f90Dyiq8E9lhtTviLYT8r7r6UaSxzOW?=
 =?iso-8859-1?Q?AW9a8zTex10Vn7PFt9p68YtnLIvh1VgosFeigwIApTrbjEX1GBfaNlJocU?=
 =?iso-8859-1?Q?xx/NxX+4HZGwrcqMsVG52woWxwcXADHa/CyYmm7RY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?l2QEGrQT6ZlcLRz6JqYiwh1Q1EE5PY1NrPRu2G88G5bfH8c4BO50Mq20uC?=
 =?iso-8859-1?Q?52Gs2rFlhooWgfDk2sfhBXnrZWsRo5SGW05HI3NO3XBTMx4BML+Kh/1w7z?=
 =?iso-8859-1?Q?Zka6E+CSkSM7bzPH8W1aGS2O7PPwQ/kOfNscRJKSmrNKRRiI4E50I5B5mZ?=
 =?iso-8859-1?Q?IcXY1CWd/LXevXCswsJP3GkEBJN2d6Jwlg0Z/lzKl4F/kOsF9FhicsYM47?=
 =?iso-8859-1?Q?uk+16lC4+2zO+o3WbOMEJ8HiJm58hHaSfNzEBUaGf5LTKNbjkQB5AykZ9r?=
 =?iso-8859-1?Q?H2jY9EsnLIXyUyDUA++r5nCGiE0dUkhlstvw4oepA/HWLXxf4M+5HiY/RI?=
 =?iso-8859-1?Q?TOL6c2q2A/okaKa2DOZgi3fcY9yabkTiNxecNl2o/dfdmjO4PgQMTeFUOG?=
 =?iso-8859-1?Q?jDYh/l1l4oamSgheubeTdCZLBQtAjkialzOsZyjD+Jxuu3IMzp7NNU/9Ur?=
 =?iso-8859-1?Q?9Y2fF2izdaLHP91SExPguIzCyVd2XWid4hrj87XMdAX+d2TGTCsVRVUej0?=
 =?iso-8859-1?Q?YUfLmjcpk4IenOflpdTt/WyytXMlhYEYkvF9ivEHOmx5VQyslAwDM51rjg?=
 =?iso-8859-1?Q?CyopOe5/xE/NghB9lBxXvi6Z59XON6yiVA/tE1vsBot7EigmNhxNUeihO0?=
 =?iso-8859-1?Q?nIfkTxkba20+dR7V7eg7+JM/i21TcZ5fqWU831knZEFWvzKFDJM242i3Ij?=
 =?iso-8859-1?Q?HGClDrYWdkKWOd5XL8XUfbWrUEmP7YnFxZg11jZd4p14VG6rck5EUEcTb3?=
 =?iso-8859-1?Q?FR7YOiSekY/ea2RMLzm8TSqO8KC+kjabVaDBtANeRnYTq1ID0jkZJCqbpY?=
 =?iso-8859-1?Q?6H8SJ4xDFa2pfGfJZwyeBuPdYWT4XkbLv5O8Ug4bCIdmpBhMilurNFkDnj?=
 =?iso-8859-1?Q?HDHyHYxNvtDAD3V236MvY/cAW7k+lLucqqVD9GhWFzSKDbsrSejxMqOcXv?=
 =?iso-8859-1?Q?/JyLCie26SHNlL0TgWb4wNP7r8t2mTMDd2ZlKZNe5xyMDPJcv2gX5/craN?=
 =?iso-8859-1?Q?58T/iC55BxXSDk7rM7A1vICI+7mHnRvFtGcJCyVbKpAoqJnJ8ziJWq6IiJ?=
 =?iso-8859-1?Q?HEpyk99V1hyePUmY+kNRJZL9Ywd2hTtLxrIHkYxg0RAQlagvqOppd6aIO6?=
 =?iso-8859-1?Q?wXAGXGcFjMJzXXBIPfuSj9hbNFTjNbN0YPOdC5pNaFO6UbBsTUqgqwnCIj?=
 =?iso-8859-1?Q?HXcg0VVwHA96rRwq/Jna7SMHxfaH9ijCun2rUMyMULr6SN2Mkooq5igslD?=
 =?iso-8859-1?Q?61M/pj7dSaf+eKODPBGTzxjTRskSELGZD2sLU/x8HJk0Ka7fF1PZLp5Sjw?=
 =?iso-8859-1?Q?n0g20bizGGqiEzzxzkdNszsXStPJ0OaFcxV6MVivhhL6A7jK6Ww/CQX0Ly?=
 =?iso-8859-1?Q?Igr7U7oEdZul5tOVPXPe9nvjBXhgB4dQ9GSR6sxdw4TKrsCFllALej0v0s?=
 =?iso-8859-1?Q?Xym4h0x8VK/BDan6NcdrVla+Rfq8P7mlaqcJEE3oANACs5O2CFA7oqfFBJ?=
 =?iso-8859-1?Q?M4tpWZ8hyRVXcdBRkjl7pnGHmZT0yOvEp8j8CMuCxrwUQv+zUY1tuU8ZkR?=
 =?iso-8859-1?Q?898qvqu5T0jnZxwSJgVFcHv/rYAo3ZJk7N7DBdGfoK29A0m5dpnbtpLDhA?=
 =?iso-8859-1?Q?VriY7oDO03dlftLl8eKnp8TrSDtXm9TiANES0CypQWHqt8ewS3RVj4+A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a490d4d7-fae1-4a1a-9774-08dc74b5ff9e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 08:07:00.9575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BEXw/11G+i6si8e1tPKutCBFIb5q7GzqOOTWOVc4SuuNqZYtpKgiNyTJ2scIVRkU4sjj+X8tpHWSUkGXVSizg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8122
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 2.7% improvement of netperf.Throughput_Mbps on:


commit: 61f7fdf8fd00ce33d30ca3fae8d643c0850ce945 ("timers/migration: Fix ignored event due to missing CPU update")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: netperf
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 50%
	cluster: cs-localhost
	test: SCTP_STREAM
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+--------------------------------------------------------------------------------------------+
| testcase: change | netperf: netperf.Throughput_Mbps 1.1% improvement                                          |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory |
| test parameters  | cluster=cs-localhost                                                                       |
|                  | cpufreq_governor=performance                                                               |
|                  | ip=ipv4                                                                                    |
|                  | nr_threads=200%                                                                            |
|                  | runtime=300s                                                                               |
|                  | test=SCTP_STREAM                                                                           |
+------------------+--------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240515/202405151553.6423572f-oliver.sang@intel.com

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-13/performance/ipv4/x86_64-rhel-8.3/50%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/SCTP_STREAM/netperf

commit: 
  cffaefd15a ("vdso: Use CONFIG_PAGE_SHIFT in vdso/datapage.h")
  61f7fdf8fd ("timers/migration: Fix ignored event due to missing CPU update")

cffaefd15a8f423c 61f7fdf8fd00ce33d30ca3fae8d 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    205059 ± 27%     -57.6%      87009 ±102%  numa-meminfo.node1.AnonHugePages
    100.03 ± 27%     -57.6%      42.42 ±102%  numa-vmstat.node1.nr_anon_transparent_hugepages
      0.01            +0.0        0.01        mpstat.cpu.all.soft%
      0.03 ±  3%      -0.0        0.03 ±  2%  mpstat.cpu.all.sys%
   1319042            +0.9%    1330457        proc-vmstat.numa_local
  15112424            +2.3%   15464529        proc-vmstat.pgalloc_normal
  15078290            +2.2%   15416220        proc-vmstat.pgfree
      3.99            +2.7%       4.10        netperf.ThroughputBoth_Mbps
    255.41            +2.7%     262.40        netperf.ThroughputBoth_total_Mbps
      3.99            +2.7%       4.10        netperf.Throughput_Mbps
    255.41            +2.7%     262.40        netperf.Throughput_total_Mbps
     45617            +2.5%      46775        netperf.time.voluntary_context_switches
     45152            +2.4%      46223        netperf.workload
      3.72 ±  4%     +65.0%       6.14 ±  5%  perf-stat.i.MPKI
      9.45 ±  3%      +5.2       14.60 ±  4%  perf-stat.i.cache-miss-rate%
    771280 ±  3%     +47.1%    1134581 ±  3%  perf-stat.i.cache-misses
      1.25            +2.4%       1.28        perf-stat.i.cpi
    547.23 ±  4%     -31.1%     376.90 ±  4%  perf-stat.i.cycles-between-cache-misses
      0.86            -2.2%       0.84        perf-stat.i.ipc
      1.07 ±  3%     +46.2%       1.56 ±  3%  perf-stat.overall.MPKI
     10.15 ±  3%      +4.7       14.81 ±  3%  perf-stat.overall.cache-miss-rate%
    785.35 ±  3%     -31.3%     539.92 ±  3%  perf-stat.overall.cycles-between-cache-misses
    769379 ±  3%     +47.0%    1131341 ±  3%  perf-stat.ps.cache-misses
      0.99 ±180%    +799.5%       8.94 ± 54%  sched_debug.cfs_rq:/.left_deadline.avg
     83.53 ±163%   +1106.3%       1007 ± 58%  sched_debug.cfs_rq:/.left_deadline.max
      8.56 ±169%    +962.5%      90.94 ± 56%  sched_debug.cfs_rq:/.left_deadline.stddev
      0.99 ±180%    +792.4%       8.85 ± 55%  sched_debug.cfs_rq:/.left_vruntime.avg
     83.35 ±163%   +1095.6%     996.57 ± 58%  sched_debug.cfs_rq:/.left_vruntime.max
      8.54 ±169%    +953.5%      89.97 ± 56%  sched_debug.cfs_rq:/.left_vruntime.stddev
      0.99 ±180%    +795.3%       8.88 ± 55%  sched_debug.cfs_rq:/.right_vruntime.avg
     83.35 ±163%   +1095.6%     996.57 ± 58%  sched_debug.cfs_rq:/.right_vruntime.max
      8.54 ±169%    +954.2%      90.03 ± 56%  sched_debug.cfs_rq:/.right_vruntime.stddev
      4.83 ±  8%     +24.3%       6.01 ±  9%  sched_debug.cpu.nr_uninterruptible.stddev
      0.82 ± 12%      -0.4        0.43 ± 71%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      0.82 ± 12%      -0.4        0.43 ± 71%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      0.82 ± 12%      -0.4        0.43 ± 71%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
      0.82 ± 12%      -0.4        0.43 ± 71%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      0.86 ± 17%      -0.3        0.60 ± 46%  perf-profile.calltrace.cycles-pp.__kmalloc_large_node.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb._sctp_make_chunk
      0.98 ± 15%      -0.3        0.73 ± 14%  perf-profile.calltrace.cycles-pp._Fork
      0.92 ± 23%      +0.4        1.33 ± 15%  perf-profile.calltrace.cycles-pp.__memcpy.skb_copy_bits.skb_copy.sctp_make_reassembled_event.sctp_ulpq_partial_delivery
      0.92 ± 23%      +0.4        1.33 ± 15%  perf-profile.calltrace.cycles-pp.skb_copy_bits.skb_copy.sctp_make_reassembled_event.sctp_ulpq_partial_delivery.sctp_cmd_interpreter
     13.20 ±  7%      +2.1       15.35 ±  3%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
     13.12 ±  7%      +2.2       15.28 ±  4%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      8.72 ± 14%      +2.5       11.20 ±  8%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      8.71 ± 14%      +2.5       11.20 ±  8%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.irq_exit_rcu
      8.72 ± 14%      +2.5       11.21 ±  8%  perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.82 ± 12%      -0.3        0.56 ± 22%  perf-profile.children.cycles-pp.__do_sys_clone
      1.00 ± 13%      -0.2        0.75 ± 16%  perf-profile.children.cycles-pp._Fork
      0.69 ± 17%      -0.2        0.45 ± 22%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.54 ±  8%      -0.2        0.30 ± 45%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.45 ± 15%      -0.2        0.24 ± 49%  perf-profile.children.cycles-pp.dup_mmap
      0.40 ± 28%      -0.2        0.23 ± 38%  perf-profile.children.cycles-pp.create_elf_tables
      0.29 ± 31%      -0.2        0.13 ± 58%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.23 ± 27%      -0.1        0.08 ± 70%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.22 ± 33%      -0.1        0.07 ± 91%  perf-profile.children.cycles-pp.lru_add_drain
      0.22 ± 27%      -0.1        0.10 ± 58%  perf-profile.children.cycles-pp.aa_sk_perm
      0.23 ± 38%      +0.2        0.40 ± 20%  perf-profile.children.cycles-pp.quiet_vmstat
      0.20 ± 45%      +0.2        0.40 ± 20%  perf-profile.children.cycles-pp.need_update
     16.11 ±  6%      +2.0       18.08 ±  5%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.18 ± 41%      -0.1        0.05 ± 44%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.03 ±100%      +0.1        0.12 ±  6%  perf-profile.self.cycles-pp.perf_iterate_sb
      0.17 ± 63%      +0.2        0.36 ± 25%  perf-profile.self.cycles-pp.__schedule
      0.29 ± 42%      +0.2        0.53 ± 28%  perf-profile.self.cycles-pp.__free_pages_ok


***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-13/performance/ipv4/x86_64-rhel-8.3/200%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/SCTP_STREAM/netperf

commit: 
  cffaefd15a ("vdso: Use CONFIG_PAGE_SHIFT in vdso/datapage.h")
  61f7fdf8fd ("timers/migration: Fix ignored event due to missing CPU update")

cffaefd15a8f423c 61f7fdf8fd00ce33d30ca3fae8d 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.08 ±  2%      -0.0        0.05 ±  6%  mpstat.cpu.all.sys%
    107327            -1.4%     105800        proc-vmstat.nr_slab_unreclaimable
    136.33 ±  8%     +47.3%     200.83 ±  6%  perf-c2c.DRAM.remote
     15.67 ± 14%    +210.6%      48.67 ± 10%  perf-c2c.HITM.remote
    143276 ±  5%     -23.3%     109924 ±  6%  sched_debug.cpu.avg_idle.stddev
      3791 ±  9%     -61.3%       1467 ± 40%  sched_debug.cpu.nr_switches.min
      4.05            +1.1%       4.10        netperf.ThroughputBoth_Mbps
      1037            +1.1%       1049        netperf.ThroughputBoth_total_Mbps
      4.05            +1.1%       4.10        netperf.Throughput_Mbps
      1037            +1.1%       1049        netperf.Throughput_total_Mbps
      1000 ±  3%     -79.5%     205.17 ± 25%  netperf.time.involuntary_context_switches
     10.06           -58.5%       4.18 ± 14%  netperf.time.system_time
     18.49           +13.8%      21.04        perf-stat.i.MPKI
 1.736e+08            -1.4%  1.711e+08        perf-stat.i.branch-instructions
     21.87            +3.0       24.84        perf-stat.i.cache-miss-rate%
   4862812           +10.9%    5394912        perf-stat.i.cache-misses
  22488461            -2.3%   21975605        perf-stat.i.cache-references
 9.721e+08            -2.5%  9.482e+08        perf-stat.i.cpu-cycles
    464.99 ±  2%     -44.1%     260.00 ±  5%  perf-stat.i.cpu-migrations
    181.26 ±  2%     -14.3%     155.42        perf-stat.i.cycles-between-cache-misses
 8.602e+08            -1.5%   8.47e+08        perf-stat.i.instructions
      5.64           +12.7%       6.36        perf-stat.overall.MPKI
     21.61            +2.9       24.54        perf-stat.overall.cache-miss-rate%
    200.48           -12.1%     176.18        perf-stat.overall.cycles-between-cache-misses
   1423522            -2.7%    1385059        perf-stat.overall.path-length
 1.734e+08            -1.4%  1.709e+08        perf-stat.ps.branch-instructions
   4847041           +11.0%    5377964        perf-stat.ps.cache-misses
  22424436            -2.3%   21912803        perf-stat.ps.cache-references
 9.717e+08            -2.5%  9.475e+08        perf-stat.ps.cpu-cycles
    463.38 ±  2%     -44.1%     259.19 ±  5%  perf-stat.ps.cpu-migrations
 8.594e+08            -1.5%  8.462e+08        perf-stat.ps.instructions
 2.611e+11            -1.9%  2.561e+11        perf-stat.total.instructions
     12.30 ±  4%      -7.1        5.15 ± 13%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     12.30 ±  4%      -7.1        5.15 ± 13%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     12.30 ±  4%      -7.1        5.15 ± 13%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     10.50 ±  7%      -6.9        3.63 ± 15%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      9.62 ±  7%      -6.8        2.79 ± 20%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      9.62 ±  7%      -6.8        2.79 ± 20%  perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      9.56 ±  7%      -6.8        2.76 ± 20%  perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
      9.55 ±  7%      -6.8        2.76 ± 20%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.run_ksoftirqd
      9.55 ±  7%      -6.8        2.76 ± 20%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.run_ksoftirqd.smpboot_thread_fn
      3.63 ± 11%      -1.2        2.46 ±  9%  perf-profile.calltrace.cycles-pp.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      2.78 ± 15%      -1.1        1.70 ± 14%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      2.78 ± 15%      -1.1        1.70 ± 14%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations
      2.78 ± 15%      -1.1        1.70 ± 14%  perf-profile.calltrace.cycles-pp.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      2.78 ± 15%      -1.1        1.70 ± 14%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      2.78 ± 15%      -1.1        1.70 ± 14%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.common_startup_64
      2.78 ± 15%      -1.1        1.70 ± 14%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      2.74 ± 15%      -1.1        1.66 ± 15%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.start_kernel
      2.69 ± 15%      -1.1        1.64 ± 15%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      6.25 ±  2%      -1.0        5.28 ±  5%  perf-profile.calltrace.cycles-pp.skb_copy.sctp_make_reassembled_event.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm
      6.40 ±  2%      -1.0        5.42 ±  5%  perf-profile.calltrace.cycles-pp.sctp_make_reassembled_event.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      2.19 ± 14%      -0.9        1.27 ± 25%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.__do_softirq.irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single
      2.19 ± 14%      -0.9        1.28 ± 25%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      2.19 ± 14%      -0.9        1.28 ± 25%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      6.96 ±  3%      -0.9        6.05 ±  5%  perf-profile.calltrace.cycles-pp.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      4.27 ±  6%      -0.8        3.43 ± 13%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      5.07 ±  4%      -0.7        4.36 ±  3%  perf-profile.calltrace.cycles-pp.skb_copy_bits.skb_copy.sctp_make_reassembled_event.sctp_ulpq_tail_data.sctp_cmd_interpreter
      5.05 ±  4%      -0.7        4.36 ±  3%  perf-profile.calltrace.cycles-pp.__memcpy.skb_copy_bits.skb_copy.sctp_make_reassembled_event.sctp_ulpq_tail_data
      3.52 ±  8%      -0.6        2.94 ±  7%  perf-profile.calltrace.cycles-pp.sctp_packet_transmit_chunk.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      3.48 ±  9%      -0.6        2.92 ±  8%  perf-profile.calltrace.cycles-pp.sctp_packet_transmit.sctp_packet_transmit_chunk.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter
      1.59 ±  7%      -0.6        1.04 ± 11%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_bh.lock_sock_nested.sctp_skb_recv_datagram.sctp_recvmsg
      1.63 ±  8%      -0.5        1.11 ± 13%  perf-profile.calltrace.cycles-pp._raw_spin_lock_bh.lock_sock_nested.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg
      1.65 ±  8%      -0.5        1.12 ± 13%  perf-profile.calltrace.cycles-pp.lock_sock_nested.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      1.50 ± 12%      -0.4        1.05 ± 11%  perf-profile.calltrace.cycles-pp.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      1.47 ± 11%      -0.4        1.03 ± 11%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg
      1.46 ± 12%      -0.4        1.03 ± 12%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg
      1.79 ± 14%      -0.4        1.40 ± 12%  perf-profile.calltrace.cycles-pp.consume_skb.sctp_chunk_put.sctp_datamsg_put.sctp_chunk_free.sctp_outq_sack
      1.01 ± 19%      -0.4        0.62 ± 10%  perf-profile.calltrace.cycles-pp.__free_pages_ok.skb_release_data.consume_skb.sctp_chunk_put.sctp_ulpevent_free
      1.30 ± 18%      -0.4        0.92 ± 23%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.__kmalloc_large_node.__kmalloc_node_track_caller.kmalloc_reserve
      3.96 ±  6%      -0.4        3.58 ±  6%  perf-profile.calltrace.cycles-pp.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND
      0.95 ±  8%      -0.2        0.74 ± 10%  perf-profile.calltrace.cycles-pp.skb_release_data.kfree_skb_reason.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      1.16 ±  5%      -0.2        1.00 ± 10%  perf-profile.calltrace.cycles-pp.kfree_skb_reason.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      0.66 ± 10%      +0.2        0.86 ± 18%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      0.67 ± 10%      +0.2        0.88 ± 18%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      0.67 ± 10%      +0.2        0.88 ± 20%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.74 ± 16%      +0.4        1.11 ± 13%  perf-profile.calltrace.cycles-pp.sctp_generate_timeout_event.call_timer_fn.__run_timers.timer_expire_remote.tmigr_handle_remote_cpu
      0.55 ± 47%      +0.4        0.96 ± 13%  perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_generate_timeout_event.call_timer_fn.__run_timers
      0.85 ± 15%      +0.4        1.27 ± 13%  perf-profile.calltrace.cycles-pp.__run_timers.timer_expire_remote.tmigr_handle_remote_cpu.tmigr_handle_remote_up.tmigr_handle_remote
      0.85 ± 16%      +0.4        1.28 ± 13%  perf-profile.calltrace.cycles-pp.timer_expire_remote.tmigr_handle_remote_cpu.tmigr_handle_remote_up.tmigr_handle_remote.__do_softirq
      1.49 ± 11%      +0.5        1.98 ± 11%  perf-profile.calltrace.cycles-pp.tmigr_handle_remote_up.tmigr_handle_remote.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      1.51 ± 11%      +0.5        2.01 ± 12%  perf-profile.calltrace.cycles-pp.tmigr_handle_remote.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.27 ± 10%      +0.5        1.77 ± 11%  perf-profile.calltrace.cycles-pp.tmigr_handle_remote_cpu.tmigr_handle_remote_up.tmigr_handle_remote.__do_softirq.irq_exit_rcu
      0.00            +0.6        0.63 ± 13%  perf-profile.calltrace.cycles-pp._raw_spin_lock.raw_spin_rq_lock_nested._nohz_idle_balance.do_idle.cpu_startup_entry
      0.00            +0.6        0.63 ± 14%  perf-profile.calltrace.cycles-pp.raw_spin_rq_lock_nested._nohz_idle_balance.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.8        0.75 ± 17%  perf-profile.calltrace.cycles-pp.update_blocked_averages._nohz_idle_balance.do_idle.cpu_startup_entry.start_secondary
      8.46 ±  4%      +0.9        9.41 ±  3%  perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg
      8.71 ±  4%      +1.0        9.67 ±  2%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      8.70 ±  4%      +1.0        9.67 ±  2%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      0.80 ± 21%      +1.2        2.02 ±  4%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     12.15 ±  3%      +6.4       18.54 ±  5%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
     12.15 ±  3%      +6.4       18.55 ±  5%  perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
     12.14 ±  3%      +6.4       18.54 ±  5%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.irq_exit_rcu
     21.77            +6.5       28.25 ±  3%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     14.95 ±  3%      +6.8       21.71 ±  4%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
     14.98 ±  3%      +6.8       21.74 ±  4%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
     26.76 ±  2%      +6.8       33.55 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     26.47 ±  2%      +6.8       33.31 ±  2%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     16.26 ±  4%      +7.1       23.40 ±  4%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
     19.50 ±  3%      +7.6       27.06 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     24.14 ±  2%      +7.8       31.96 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     26.39 ±  2%      +7.9       34.26 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     31.94 ±  2%      +8.0       39.97        perf-profile.calltrace.cycles-pp.common_startup_64
     29.16 ±  2%      +9.1       38.26 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     29.13 ±  2%      +9.1       38.24 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     29.16 ±  2%      +9.1       38.27 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     12.40 ±  4%      -7.2        5.22 ± 12%  perf-profile.children.cycles-pp.ret_from_fork_asm
     12.30 ±  4%      -7.1        5.15 ± 13%  perf-profile.children.cycles-pp.kthread
     12.36 ±  4%      -7.1        5.21 ± 12%  perf-profile.children.cycles-pp.ret_from_fork
     10.50 ±  7%      -6.9        3.63 ± 15%  perf-profile.children.cycles-pp.smpboot_thread_fn
      9.62 ±  7%      -6.8        2.79 ± 20%  perf-profile.children.cycles-pp.run_ksoftirqd
     31.94            -1.5       30.44        perf-profile.children.cycles-pp.__do_softirq
      5.16 ± 10%      -1.4        3.72 ± 11%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      3.68 ± 11%      -1.3        2.36 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      3.33 ±  8%      -1.2        2.12 ± 15%  perf-profile.children.cycles-pp.load_balance
     17.33 ±  2%      -1.2       16.12 ±  3%  perf-profile.children.cycles-pp.__memcpy
      2.88 ±  9%      -1.2        1.70 ±  8%  perf-profile.children.cycles-pp.find_busiest_group
      3.63 ± 11%      -1.2        2.46 ±  9%  perf-profile.children.cycles-pp.sctp_skb_recv_datagram
      2.85 ±  9%      -1.2        1.68 ±  8%  perf-profile.children.cycles-pp.update_sd_lb_stats
      2.78 ± 15%      -1.1        1.70 ± 14%  perf-profile.children.cycles-pp.rest_init
      2.78 ± 15%      -1.1        1.70 ± 14%  perf-profile.children.cycles-pp.start_kernel
      2.78 ± 15%      -1.1        1.70 ± 14%  perf-profile.children.cycles-pp.x86_64_start_kernel
      2.78 ± 15%      -1.1        1.70 ± 14%  perf-profile.children.cycles-pp.x86_64_start_reservations
      2.61 ± 10%      -1.1        1.53 ±  8%  perf-profile.children.cycles-pp.update_sg_lb_stats
      7.41 ±  2%      -1.0        6.42 ±  4%  perf-profile.children.cycles-pp.sctp_ulpq_tail_data
     16.46 ±  2%      -1.0       15.46 ±  3%  perf-profile.children.cycles-pp.sctp_packet_transmit
      3.51 ±  5%      -0.9        2.58 ±  9%  perf-profile.children.cycles-pp.kmalloc_reserve
      3.42 ±  5%      -0.9        2.49 ± 10%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
     50.46            -0.9       49.53        perf-profile.children.cycles-pp.do_syscall_64
     50.52            -0.9       49.60        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.19 ±  5%      -0.9        1.27 ± 17%  perf-profile.children.cycles-pp.rmqueue
      3.37 ±  5%      -0.9        2.46 ± 10%  perf-profile.children.cycles-pp.__kmalloc_large_node
      3.96 ±  3%      -0.9        3.06 ±  8%  perf-profile.children.cycles-pp.__alloc_skb
      4.38 ±  6%      -0.9        3.48 ±  4%  perf-profile.children.cycles-pp.__schedule
      3.21 ±  4%      -0.9        2.34 ± 13%  perf-profile.children.cycles-pp.__alloc_pages
      3.04 ±  4%      -0.9        2.17 ± 14%  perf-profile.children.cycles-pp.get_page_from_freelist
      4.32 ±  6%      -0.9        3.46 ± 13%  perf-profile.children.cycles-pp.sysvec_call_function_single
      2.59 ± 17%      -0.8        1.77 ±  5%  perf-profile.children.cycles-pp.__free_pages_ok
      9.60 ±  2%      -0.8        8.78 ±  4%  perf-profile.children.cycles-pp.sctp_make_reassembled_event
      9.34 ±  2%      -0.8        8.54 ±  4%  perf-profile.children.cycles-pp.skb_copy
      1.69 ± 20%      -0.8        0.90 ± 14%  perf-profile.children.cycles-pp.pick_next_task_fair
      3.32 ±  9%      -0.8        2.54 ±  5%  perf-profile.children.cycles-pp.schedule
      2.05 ± 15%      -0.8        1.28 ± 10%  perf-profile.children.cycles-pp.newidle_balance
      1.47 ± 21%      -0.8        0.71 ± 10%  perf-profile.children.cycles-pp.free_one_page
      3.71 ± 14%      -0.6        3.07 ±  6%  perf-profile.children.cycles-pp.skb_release_data
      2.37 ±  9%      -0.6        1.73 ±  6%  perf-profile.children.cycles-pp.schedule_timeout
      2.04 ±  9%      -0.5        1.50 ± 12%  perf-profile.children.cycles-pp.lock_sock_nested
      2.06 ±  8%      -0.5        1.52 ± 13%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      0.50 ± 47%      -0.2        0.26 ± 18%  perf-profile.children.cycles-pp.cpu_util
      0.27 ± 23%      -0.2        0.10 ± 40%  perf-profile.children.cycles-pp.task_work_run
      0.23 ± 19%      -0.2        0.06 ± 52%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.26 ± 24%      -0.1        0.14 ± 17%  perf-profile.children.cycles-pp._find_next_and_bit
      0.16 ± 27%      -0.1        0.08 ± 35%  perf-profile.children.cycles-pp.rw_verify_area
      0.15 ±  9%      +0.0        0.18 ± 14%  perf-profile.children.cycles-pp.__cmd_record
      0.15 ±  9%      +0.0        0.18 ± 14%  perf-profile.children.cycles-pp.cmd_record
      0.05 ± 75%      +0.1        0.14 ± 19%  perf-profile.children.cycles-pp.call_cpuidle
      0.31 ± 16%      +0.1        0.41 ± 13%  perf-profile.children.cycles-pp.write
      0.12 ± 35%      +0.1        0.24 ± 34%  perf-profile.children.cycles-pp.tick_do_update_jiffies64
      0.08 ± 19%      +0.1        0.19 ± 21%  perf-profile.children.cycles-pp.sctp_backlog_rcv
      0.22 ± 33%      +0.1        0.35 ± 13%  perf-profile.children.cycles-pp.perf_read
      0.08 ± 19%      +0.1        0.22 ± 25%  perf-profile.children.cycles-pp.__release_sock
      0.14 ± 19%      +0.2        0.30 ± 14%  perf-profile.children.cycles-pp.release_sock
      0.31 ± 11%      +0.2        0.48 ± 37%  perf-profile.children.cycles-pp.zap_pte_range
      0.34 ± 19%      +0.2        0.52 ± 32%  perf-profile.children.cycles-pp.unmap_page_range
      0.31 ± 14%      +0.2        0.50 ± 35%  perf-profile.children.cycles-pp.zap_pmd_range
      0.44 ± 15%      +0.2        0.64 ± 15%  perf-profile.children.cycles-pp.__rhashtable_lookup
      0.68 ±  9%      +0.2        0.90 ± 19%  perf-profile.children.cycles-pp.exit_mm
      0.86 ±  4%      +0.2        1.10 ± 18%  perf-profile.children.cycles-pp.exit_mmap
      0.86 ±  4%      +0.3        1.12 ± 17%  perf-profile.children.cycles-pp.__mmput
      1.48 ± 11%      +0.3        1.77 ±  9%  perf-profile.children.cycles-pp.__run_timers
      0.64 ± 15%      +0.3        0.99 ± 34%  perf-profile.children.cycles-pp.__sctp_rcv_lookup
      0.63 ± 15%      +0.4        0.98 ± 34%  perf-profile.children.cycles-pp.sctp_addrs_lookup_transport
      0.88 ± 15%      +0.4        1.32 ± 13%  perf-profile.children.cycles-pp.timer_expire_remote
      1.53 ± 10%      +0.5        2.03 ± 11%  perf-profile.children.cycles-pp.tmigr_handle_remote_up
      1.55 ± 10%      +0.5        2.07 ± 11%  perf-profile.children.cycles-pp.tmigr_handle_remote
      1.31 ±  9%      +0.5        1.83 ± 11%  perf-profile.children.cycles-pp.tmigr_handle_remote_cpu
      0.50 ± 14%      +0.5        1.03 ±  9%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      8.71 ±  4%      +1.0        9.67 ±  2%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      8.52 ±  4%      +1.0        9.48 ±  2%  perf-profile.children.cycles-pp._copy_to_iter
      8.70 ±  4%      +1.0        9.67 ±  2%  perf-profile.children.cycles-pp.__skb_datagram_iter
      1.79 ± 12%      +1.0        2.80 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
     17.97 ±  3%      +5.6       23.57 ±  4%  perf-profile.children.cycles-pp.irq_exit_rcu
     26.84 ±  2%      +6.8       33.60 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
     29.13 ±  2%      +6.8       35.92 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
     26.77 ±  2%      +6.8       33.56 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
     26.45 ±  2%      +6.8       33.28 ±  2%  perf-profile.children.cycles-pp.acpi_safe_halt
     17.04 ±  3%      +6.8       23.88 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     26.47 ±  2%      +6.8       33.31 ±  2%  perf-profile.children.cycles-pp.acpi_idle_enter
     18.83 ±  3%      +7.0       25.78 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     31.93 ±  2%      +8.0       39.96        perf-profile.children.cycles-pp.do_idle
     31.94 ±  2%      +8.0       39.97        perf-profile.children.cycles-pp.common_startup_64
     31.94 ±  2%      +8.0       39.97        perf-profile.children.cycles-pp.cpu_startup_entry
     29.16 ±  2%      +9.1       38.27 ±  2%  perf-profile.children.cycles-pp.start_secondary
      5.14 ± 10%      -1.4        3.71 ± 11%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
     16.85 ±  2%      -0.9       15.98 ±  2%  perf-profile.self.cycles-pp.__memcpy
      1.83 ± 10%      -0.7        1.09 ±  9%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.20 ± 24%      -0.2        0.05 ± 74%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.35 ± 25%      -0.1        0.21 ± 16%  perf-profile.self.cycles-pp.cpu_util
      0.23 ± 24%      -0.1        0.13 ± 21%  perf-profile.self.cycles-pp._find_next_and_bit
      0.02 ±141%      +0.1        0.08 ± 22%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.02 ±141%      +0.1        0.08 ± 38%  perf-profile.self.cycles-pp.__run_timers
      0.05 ± 75%      +0.1        0.13 ± 18%  perf-profile.self.cycles-pp.call_cpuidle
      0.03 ±150%      +0.1        0.12 ± 35%  perf-profile.self.cycles-pp.update_blocked_averages
      0.18 ± 33%      +0.1        0.32 ± 22%  perf-profile.self.cycles-pp.sctp_packet_config
      1.29 ± 11%      +0.4        1.66 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock
      8.42 ±  4%      +1.0        9.45 ±  2%  perf-profile.self.cycles-pp._copy_to_iter





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


