Return-Path: <linux-kernel+bounces-512478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0B9A339C5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36423A74D4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BDE20011B;
	Thu, 13 Feb 2025 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFXKBrxK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5AB13B29B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739434626; cv=fail; b=rCa7nMP4x3HCBwIgkONzlB9tDZtDEDbfmKy3+mGerXK2QO5FMeX+MgcAJCHuOvoe3whNwQKXTd4klp0qnZefHqOpBSYFYPqzA5+/CTPU3xCzEFVHBB3HkYSF3mzo9ju08GOuvXulLQFRtI+M41g8UFj+8hsotK5pb+vp4MQDPWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739434626; c=relaxed/simple;
	bh=ikQ9xtRBua+Nt0AUhWDT0JV2DshPvd7dvT72bMzbGwY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=gp9BeN6WhJmp2P0oylkb5CZtypfC6oz2QSbQqMjZ6XM5nXjBMo92UwNlFdL4TkVoGv+iTLXYADG0Q9WQuS4LAlPz31oGJ0Itn+dGsb5CiEfGuX9HIFBu1tbzdGbizckC09qveD5MGhhEivF1VwNbcFeJvKAOdmLzzjarqORslzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFXKBrxK; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739434625; x=1770970625;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ikQ9xtRBua+Nt0AUhWDT0JV2DshPvd7dvT72bMzbGwY=;
  b=dFXKBrxKz7MHrx5+lxiR/xr84akK9I1xc6b+H6U/6Q/6urJX1zmhvZS/
   YBuTOtQVn6ssV709xbO38y1sjRIAPAIflEFdn2bgOG2zpjJqW6qGjiGM2
   96wHPWg+NLz/QzDaXgcGdARAqaL7J/SUeD08n4PgVVFeEo35mWq5aZnPG
   uEVfsreeRfchsVA8UZKhYHMGzVdx7BuZKjr/eCzU5n6AcJ7/Zoe0ZK8kM
   D1dDB57/qP6dGDQRj2Ofvs57gtLojGGv7BBi9NV/emonlGuZqWfu3wLvO
   DX74/oAcAck2OzDOvZG3MldZTT46r0AhQAfEtX5ckek+vMako/LKr3qh7
   Q==;
X-CSE-ConnectionGUID: hetSimhtSPyfU/4g/QBmAw==
X-CSE-MsgGUID: +PG2gZE0SkGUJQ7x4EAu5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="51518355"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="51518355"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 00:17:04 -0800
X-CSE-ConnectionGUID: 3/Q7d/FKSEGXHERWgcdXRA==
X-CSE-MsgGUID: OzBlL2j0RJC8eThgQLjVtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118262579"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 00:17:05 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Feb 2025 00:17:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 00:17:03 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 00:17:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyjwUAmaTxM/kRKWWi7cyeQYcf4vIP/hpgJ6+TQdPVrkUxWbveN3euMhuJAJQbUtV+mlLeKFh7CSEzHlFzj8MzkpbnsBhWxOuVWhWvINpFDR+Am1S69nVOOnjxYF6roEFBk96MfyxKmj5p+oMB1cjMklLSyNDlf5wBUMH+zqkJKW6ss+KzyMjU7tWKqJOX43Lp7Wyf7YziXLPDgGjSyO4zhnIDUVXSbI/+4GO7OoS2eXL86YlKjfzSyYp83lAp5Xx7c/A7ykYhPFbHnq9EE74dzJBDSiZwXlDpYdG/tzB6J4uvdaWiFSTaB6GsiCmPZuHdRhpRysAkfbPdi0Z+E0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJHTuclRKXSambAVnndw4IWAbAyHUae+0a6QaO1QAe4=;
 b=XdnZRNZHpARJ3uo0e2TYq8cRhzHU5Ew1URfSqRFNLk2uT7vnkFUogKAyFIvoXCeEeehZmMpbDb8lp7Cy+0xhjfIL2R4Q3lY2GHDVmzRlCsFnaZWE3Y05XeZ9FpGYTxhHOVmr8AVfKbkwiEsHlMk8FLGNfmSXy9p6wA7KFFCnbzmjzeVrgU99cxGeWfgRnrV42cHzkvkgJvHi0sza4NbcWQwZ7ZwxMNd6rOwvLcWW1Zw3Qf8Ve5Hh7HXcMjo4FmK5WfqqCGMNc2W1laJbKMQwWiq7bRksp6EDbD9wHXEYhok4r8amiXhasHq45GFzuor1s8+kMfQKN1vuiCsek7ivWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by MW4PR11MB6911.namprd11.prod.outlook.com (2603:10b6:303:22d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 08:16:59 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 08:16:59 +0000
Date: Thu, 13 Feb 2025 16:16:51 +0800
From: kernel test robot <lkp@intel.com>
To: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Richard
 Weinberger" <richard@nod.at>
Subject: drivers/iio/light/opt4001.c:215:9: error: call to
 '__compiletime_assert_324' declared with 'error' attribute: FIELD_PREP:
 value too large for the field
Message-ID: <Z62qc3wSqzopCURa@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|MW4PR11MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: e02d2ab7-9df0-4d44-a36f-08dd4c06c942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Rpg6dfXwcyUlRin2YrtrkiRSSt8S7pNNuDoKj+CcMRAn8EMxwH9h3OR0NpFS?=
 =?us-ascii?Q?BdFhFRtP3GIE2K1ohl6D4+8sPmIFSHM7ewqgZAFCwCHW079kSv0JFHrUYiUk?=
 =?us-ascii?Q?z4XFjrrRy6cxkjEYliLsHvKJa8RfH9jI/tM428FlmL32yw7/Uf/lSqJpNlnA?=
 =?us-ascii?Q?tnNkR8HyAJEzZdr4iBBHN/AD+S33+UpQ8ed2icV/ERJHO+X7XmjKWcBCDa/C?=
 =?us-ascii?Q?mpz6I/zEtRM5G7lri775t+PGHiCB1ehLpvZgWHEMki1/7a/s2TvAd7GK8Ixu?=
 =?us-ascii?Q?Xq7kOqCJbmz01MmyEnT+zHoUD0kHoXxUN/K8lDtFov2bi72RdyPheTQ/A2eg?=
 =?us-ascii?Q?EOpCgSLALJNtN8j9nz5+OFv/pkdqMicn+XIKJHbDawpGnPIqrRauTB0YLY5e?=
 =?us-ascii?Q?D4KQaa5f8rin3pHXiJCvYXh6l8KjtJF5TyHfl4QAAeNdyk5TFpX3bXJE8yRY?=
 =?us-ascii?Q?711elmFltRqKHUGyESJMB62RcnCK4orkvM23HAsN2uYuIDgWY0XoBgvhFyqh?=
 =?us-ascii?Q?SAqiAdAe+Kpz4FkZuSIeskJzjm50vJEgJXKSinFOU0ZQkQZcVvcr7GU1stmi?=
 =?us-ascii?Q?mejNAzBUMYBKMq2Y1Qhjeg20uawpHTwocNlfxij338Lr8FGgA0RZ+DWWwqBE?=
 =?us-ascii?Q?Lc/ksLM9EqvFNOCf7N4ug4yqvFnD/dyWj0ssa+uZVLHNrRHjOjCmPEOTb18h?=
 =?us-ascii?Q?V1RE6W0RlrTxt2AbwcNyK7QfYvRdDqFhqDrjmSuvMTYS2V0X1SlQhustlQq/?=
 =?us-ascii?Q?EMs2O6rv1f+V11iaJICOMAJPaiU4/IR4qa6DCTzjEa+wAvBGg4McyCLcp+Yt?=
 =?us-ascii?Q?lBXwJB2mRGY0EgQtKY5s2yp74hNBY+1CLsb7hRlBnQ9yjUS3Gj4TLTjzVISL?=
 =?us-ascii?Q?YwWAFm51b9G7Q57SveNvfEyROECcB0S7CPw8nkOrBLoSUf3DabynFXLfwlPk?=
 =?us-ascii?Q?KagLJCHqDiDukuyR7pyrnOA0inpPSCmRd8rAB/B4ErPBoC1eqJ8QAdpFfc2P?=
 =?us-ascii?Q?ngyyyoKomvt814Dhs26sqRFxbyK+mjVxhRLfo0ib0WEq0MqAoCDo8kIbNNkT?=
 =?us-ascii?Q?Iy6MPbv4dU2hJgI1F9FQfTxh8Fs/0do6YpJe+RepDt+kG66eiLHio6wfuJSF?=
 =?us-ascii?Q?0DZ1vFsOk6IiTP9+0Azcp1FoX5ODsqq99ZAaLw/Y6LhpfnerdL7Z1X8TXQ92?=
 =?us-ascii?Q?90eXzS+1WGLra2RppdDqKCzSeBILfkV3Er69pWMEgon5n76U3JQSnJu5HEe2?=
 =?us-ascii?Q?bH2KcUIcXFPSAxDKSTPFbtHtfwaxRtqfPL+IrgGcJqWAtvZkYgR7hf05oYpx?=
 =?us-ascii?Q?WNqzgnFbFXIKlBA/xX7bj+zOtmzwCpmpesWNsyF+1FcXYQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YlziFqOLr3jO7VqN3i6fBIDp7snGuhp84Uv62d6BdwvPise64aKiFJrPHOGs?=
 =?us-ascii?Q?sDgodqgOy5GlBWcWZbEoee9m6xILG+OyahjYCPAJfvVbBN18c6s1cOThiPsb?=
 =?us-ascii?Q?CfOZt/1iphBqLY+1b01aOWZE+sCvrO3iuMv4SLTao7CUOIEwt2b07rw8mREQ?=
 =?us-ascii?Q?EynOD+djR1usDXgpPwYHquk9oZcWJoENh39XOjA+CnVI4YPZrQLvC/lzyg4N?=
 =?us-ascii?Q?r4EhAcRC858kXZU0O9mMFsm9EQmbdY+VRLh/su5lRqNuGCKwV/cM1Bq9t6qu?=
 =?us-ascii?Q?uBpiX667Q9C3GdRIeA1ck9oFxbjQyks26o12xRaZS98Et+jzcZNwbzYmANNR?=
 =?us-ascii?Q?raA5otR5XdhvWB7Pq3iEnMOal8u1O9nInA+ezdPMXansQ4Mz50hniskV4298?=
 =?us-ascii?Q?aDqA74UR9zc3Lp//i3x2cRf1NRoMimpWItrtuKfNIABT9dy4M8yQGo7gkOUg?=
 =?us-ascii?Q?ORySbU3sAUJYi4a3PhWDyhhRLeA1X2gfcMgR/YR3HuKTPphgYBc7S+2MZxB2?=
 =?us-ascii?Q?7WcoxAguBiCr7JqGe/C+Q317TOXJGpX856F4bW5/2tk4Ny2/Ggd1Ppt3PGPN?=
 =?us-ascii?Q?Oy+ZESTG3ARl2GKUCHbQHT1blOYwgstPSJDaFn8bMnaTnNkfWOQJ7R6qyTd0?=
 =?us-ascii?Q?xBbEbRSsNR/j1J7aqcTvCK46zRRRznK0M44ncxpLvGLTjxI5c5vEFeNjdYcz?=
 =?us-ascii?Q?sokRgVA5HIhuarqMZA4AoGVeorF6KNYwU0cPOsUlGlQqkL5JGoQ+PfgiJtML?=
 =?us-ascii?Q?O94yU3jefb7p4UocyE+K0ru0yXND/VJGbE4vtJnkZ23kongNChI+sWc9lR0N?=
 =?us-ascii?Q?82udONUoPI7v131suK6tNEpz6W9ReVpj4AWns6ApfsV06QuTAvgrhtuYwmVE?=
 =?us-ascii?Q?jWl2+G2RucqyLdA7GZS2qx2PFV0L5Nlwgla8QkDQ+gZjP+0FTmcUERJXeUJZ?=
 =?us-ascii?Q?yOsgb+xeKMKt2oUW//0m4cyXANsk+ilzj70EskqpAWhd8K6Mr1qU+w0DI0W0?=
 =?us-ascii?Q?Bck7sakq0y2xXUm6Wy5IMb7c2Er/uYV+9Z/2KSSX4ZHLUgdqtZxFVNZKIkM/?=
 =?us-ascii?Q?mlc7EkS/7Q8dqbQqzT8Jjxxmnjl0JhdxSkQ4c4KMYwhjAY24N/3gcwc7S1bG?=
 =?us-ascii?Q?ohpPARUu1ucV+XrvuSxI373HFgS5olFzF0psy22V2eTy9djKrnGp+63WX6aF?=
 =?us-ascii?Q?rXe5SHCpIN7hV1yus4TVECXhdU2RJM7FsYhzckWcWEFMV1Q8JGsYHvZTphd2?=
 =?us-ascii?Q?vVtlPRwGvJp9WXylL8Cna2ECpGyKHpuQZexN0X5O7zkrN5sWA0zyVVT+Wraz?=
 =?us-ascii?Q?YRA3qUlHOIaaF7aL9lpu8paRXCnJGBqCf8CUjaVS4VUSTAfG9rJwrYjVWBD7?=
 =?us-ascii?Q?AGFogL5BdSO/H9I2aABpvYmBk2fnXrDzQgUvUDyLYRlwISeKqCxz3xEMGrx9?=
 =?us-ascii?Q?WZxPQUwP2uVEd48ehMIWSjV8V428GL7J+7ifQ6wUhzylU/K9pGsxkihPWRgc?=
 =?us-ascii?Q?JRF5wRV/s6LS0C4USY0ZDR9s0W7oKsqB5D3aE7HOJt+qJJiZzbYgA2q+h75n?=
 =?us-ascii?Q?iPZvDKesuIWmHlj9J/il9kFToJkkGSkTCPSyt4aCLE0Tatyz3XFlTZSWYrIA?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e02d2ab7-9df0-4d44-a36f-08dd4c06c942
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 08:16:58.9892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/QzxulKgAYGXvMpbjliioQ+p/PWbfazIkv++sgyV8XbdcdqW4pvEeEuA2++SWlS6DizcS8nyrpF8HHA8M54Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6911
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fda5e3f284002ea55dac1c98c1498d6dd684046e
commit: 32a84cfc6caf830431375c5182391284986d4066 arch: um: Add Clang coverage support
date:   1 year ago
:::::: branch date: 5 hours ago
:::::: commit date: 1 year ago
config: um-randconfig-r112-20250119 (https://download.01.org/0day-ci/archive/20250119/202501191017.4tkmOnIt-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project c23f2417dc5f6dc371afb07af5627ec2a9d373a0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250119/202501191017.4tkmOnIt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202501191017.4tkmOnIt-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iio/light/opt4001.c:11:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/iio/light/opt4001.c:11:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/iio/light/opt4001.c:11:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from drivers/iio/light/opt4001.c:11:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:2177:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/iio/light/opt4001.c:215:9: error: call to '__compiletime_assert_324' declared with 'error' attribute: FIELD_PREP: value too large for the field
     215 |         reg |= FIELD_PREP(OPT4001_CTRL_CONV_TIME_MASK, chip->int_time);
         |                ^
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
     114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^
   include/linux/bitfield.h:68:3: note: expanded from macro '__BF_FIELD_CHECK'
      68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:423:2: note: expanded from macro '_compiletime_assert'
     423 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:416:4: note: expanded from macro '__compiletime_assert'
     416 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:55:1: note: expanded from here
      55 | __compiletime_assert_324
         | ^
   13 warnings and 1 error generated.


vim +215 drivers/iio/light/opt4001.c

9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  207  
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  208  static int opt4001_set_conf(struct opt4001_chip *chip)
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  209  {
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  210  	struct device *dev = &chip->client->dev;
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  211  	u16 reg;
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  212  	int ret;
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  213  
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  214  	reg = FIELD_PREP(OPT4001_CTRL_RANGE_MASK, OPT4001_CTRL_LIGHT_SCALE_AUTO);
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26 @215  	reg |= FIELD_PREP(OPT4001_CTRL_CONV_TIME_MASK, chip->int_time);
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  216  	reg |= FIELD_PREP(OPT4001_CTRL_OPER_MODE_MASK, OPT4001_CTRL_OPER_MODE_CONTINUOUS);
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  217  
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  218  	ret = regmap_write(chip->regmap, OPT4001_CTRL, reg);
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  219  	if (ret)
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  220  		dev_err(dev, "Failed to set configuration\n");
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  221  
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  222  	return ret;
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  223  }
9a9608418292bb Stefan Windfeldt-Prytz 2023-04-26  224  

:::::: The code at line 215 was first introduced by commit
:::::: 9a9608418292bb8733805c3f3123dfe0454fadac iio: light: Add support for TI OPT4001 light sensor

:::::: TO: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
:::::: CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


