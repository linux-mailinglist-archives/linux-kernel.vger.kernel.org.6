Return-Path: <linux-kernel+bounces-257576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1810937C10
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10BE41C218E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2301487E1;
	Fri, 19 Jul 2024 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fezrGU08"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767941487C1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412463; cv=fail; b=Lb5PFhVb7daDVlsHEe1D3doSHf9Dg9usOpiB9oCqrmBhu2tY3ehxehkjfbq8QB2Hf6Yp748bH91BPvrYp3gPf/viTszU1VtbWgx0DqTabZ7Rrw+9ruJ2eQ7KsuSvYTu/bpLNvJ93zmHLEuiG8V6xcRvlxvm0xsoG2j3pnJMGF+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412463; c=relaxed/simple;
	bh=v0mEYwUd2DR/MrI1ZOjVLV4QY5t791MekodYI1EvJbE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Fs/5XQunSksWv6oKgmTGagGkf5FVf3MonBYtduPDKXsRt6kSzHFnwyhtTNpNc03yhqcniwjYow0cRleWR95FMU/ip+ftNRiWvlAlCkWiGLmCP0dlAnhwT4UV21eB3FSaAhdmwmhDu/5ZLiEJq7viPilBDDX9oHaj1WFm+yW9NPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fezrGU08; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721412461; x=1752948461;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=v0mEYwUd2DR/MrI1ZOjVLV4QY5t791MekodYI1EvJbE=;
  b=fezrGU08Ub+FTYqHfjTLxsPkJNY+41JXeRhlxxWUGD262KGT9tTEc3yG
   0er1yPk7PvO84rScOOfiu8tpQ3nPnyFAMBQOjGJsCaXV4RL4SsjG6EOnJ
   nK9Q8Jp/W3L9jxUUbnybq4eqwaus0BbEbHqCETmL5dVR9q9S0wyLccFLS
   IDqLT3anBjfXnyxpep9C5/ZaqE+RtgA9d1e7GJCUTyCe2dA1ORXqH0i8c
   SSshao4VilLPb7Nk6q9YS8A5w7nTnvJujVLNkvPLjxamEq6bqItc0d8n3
   LweI0TW67ftvefyPt2ioUviZOibsgl807ZTY3SLkBP+uc/4AUyfgU+JaQ
   g==;
X-CSE-ConnectionGUID: h9XziSwlTk+M6tPxcBkmGA==
X-CSE-MsgGUID: O6R4Fr+4Te6lFjiguQ5Tmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="29703518"
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="29703518"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 11:07:32 -0700
X-CSE-ConnectionGUID: Z8vaq9eLQn2mI6q7FlrHWg==
X-CSE-MsgGUID: FSQ/i+eURSqlDgRu3QnsuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="51092188"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jul 2024 11:07:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 19 Jul 2024 11:07:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 19 Jul 2024 11:07:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 19 Jul 2024 11:07:31 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 11:07:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZR/GixCU562k8S0OkN+/ri25p668Py3wr41QEdYYb5u62kFoVqvMGWytBjKKcxmfV2yVilTDLA1Agcs+0oK2SFMlIegow+eH281eX4ZqdQkaFy7QhKpokACNzM+HvPQXLjZGPjui17AS3qcvHyCjQT85BVJfSSMVy4ppCUaaF4L2jeR2l1oDuEnMycDkM5oIW9xeDMCm4sQ2ThJVfESE5R8NE8Q7aRZIsT8pcjuDofmwxVgxVC4p59HBeUmUwDOi9YoIZk+MtdMA2+qnteVEN3E0QOEsjm79YU5uSQA0odJz0CkkimC5zqsHL3gyMUWxJ3zoG+I4yxKVz7LSTKLeGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLg+okIL06DzEz5FTkykO+hT4NRO1/PwV880QW8VbZA=;
 b=EmDbe6cdH5of8gR+0eux/SQrv510nz4I38ImM2d3yuZB+Pn6LuJuiSHvkJvqoxmrMqhS5g+j1BBPRY9aBvbU7VZsj0RFaUy4nhlq3n7EUa3ms5/x7fg6DgPS2pK1jnQLlsvQlrJftZfv70aTd0JDEwWBlMTqqCWWQl9ro7Xz60o93lgSIC3koVSzhQ1LJRMHpPatsmFJc2WVzObTLaj8VHTKbdIUJYTfH8JD4u/PiejNGSPoXx90POwFACKap7Jq4EK9VvY6B9QwjsmReMFNhTbzJQ4V9Vs8Q/0Xx2wg+OHukwnI0ZaHr2kqZoa87+DEoCNWZj1ARJwCellPBruuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6523.namprd11.prod.outlook.com (2603:10b6:510:211::10)
 by SJ0PR11MB5152.namprd11.prod.outlook.com (2603:10b6:a03:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 19 Jul
 2024 18:07:28 +0000
Received: from PH7PR11MB6523.namprd11.prod.outlook.com
 ([fe80::fffc:36ac:37ac:1547]) by PH7PR11MB6523.namprd11.prod.outlook.com
 ([fe80::fffc:36ac:37ac:1547%5]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 18:07:28 +0000
From: "Preble, Adam C" <adam.c.preble@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: What is an objtool recipe to solve the unpatched kernel thunk
 warnings in out-of-tree modules?
Thread-Topic: What is an objtool recipe to solve the unpatched kernel thunk
 warnings in out-of-tree modules?
Thread-Index: AdraBPI7Dz/1rUhsSB2UPBYKCwz34g==
Date: Fri, 19 Jul 2024 18:07:28 +0000
Message-ID: <PH7PR11MB6523524C9B34ACA312FB0148A9AD2@PH7PR11MB6523.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6523:EE_|SJ0PR11MB5152:EE_
x-ms-office365-filtering-correlation-id: 0d1b58d1-63b8-4db1-cefa-08dca81da6c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rXzFFvHwpYYLcRPZTEjL3+fdXhJgU8Uc9ktCKf22m0c53GDDGKMDw1ZJgLb7?=
 =?us-ascii?Q?hJQ7eImoczCCUmugz9VH4xbrQvjnQFhBDEaXQm7ApymWYsLtYH6C0HCdGENQ?=
 =?us-ascii?Q?e5UYQD0lyOZ4SZRN+XhQLSwrbfjbbGoYxpPKn9sPdf+wSeSVesD54578UIte?=
 =?us-ascii?Q?ILHewzLZ24/repy6PBCyTNTehlXmgK3lyy9NRY46KeNVBcrPsz/Vr1Esjj2w?=
 =?us-ascii?Q?gRvkQ19qwwbSt+fU5UnHJjAM3YxgyWjPSd+TB6UJw0ZZpuIbp9q4R7b/n1n7?=
 =?us-ascii?Q?OECZHL8o5dZJLme4pHiGYtYEw4p46EI9yaU179w2SHKhcSR04lGb2z/9zn+5?=
 =?us-ascii?Q?h31It0d/on3I3Oj4aQs3AiACEgFxNOwzeNSFVtpws6j1oqdryUtVjsO2f7Ma?=
 =?us-ascii?Q?t9UNjVusi8PXZQM+26o6XS9qMalbW4ysWrBkdSKnZrK+VfInIJfU2GIPZxpp?=
 =?us-ascii?Q?po/IP4OZCLJbkD5tqxX0Uyy6M2Aal+hjMeR6o16ua5NhrUTr05EFpIXZaLz6?=
 =?us-ascii?Q?ZAelGCVd2OgKqNEGAwKAwKi5oMwpjkr8yYInP9tc/jXRksr/mUfjieQNlmFb?=
 =?us-ascii?Q?uPNshLw4ez/cttpl7nX+mTzpWz40KwNhRQSVp0BD/ht6PDAv8ddwKeJOCSk1?=
 =?us-ascii?Q?ioV3va8DbZBvc1KfTBq5vyhj1YTodfnaa8oRmps9/oLunGnBekmE3NhRBiQQ?=
 =?us-ascii?Q?2O2kfplgUYDXeYzpM0iusoDgZbpRx30tJDg0S3fc23xGm/3cXjDZQBGzVRFU?=
 =?us-ascii?Q?KYyRkLn6xbYdcfM9wQb7hmeDhKZZdHGl9zvr0k1JtRGVkefZkhveXEpuTNwZ?=
 =?us-ascii?Q?G5A39N9SPaDEwfBKalUsnjSUnShqDVHcJKk3glZjYhk6iDTx9M88uPhwScBQ?=
 =?us-ascii?Q?JqcZlqn35/pSU0OiX4HFX0M/W4CK1iRVAPF3BzZS2djk8NAbrFjq+cslJ6PT?=
 =?us-ascii?Q?aF8/yG8X62F832W1L+jbo/Cbui3moacG/SSz/Jgd2VFZ58VcN1ocsazG2joQ?=
 =?us-ascii?Q?60Id25OKbIbVD1iONw8Hslq6k/Kp1Bi56ljL294fzjdomeY9YHhf/Q/skTPL?=
 =?us-ascii?Q?RS4zrbfiEqHYWENf8b1r0peZaYlOOD1pLyB/jjuiswOPv/2pBW4Up1ov0Idv?=
 =?us-ascii?Q?yq+gV23gtcf1UdQx1MAmyL5c0c/62pcxlOUkv8epPf+Kjl5l8UolWj0y17AT?=
 =?us-ascii?Q?jtOVz5t63r9b4/etglFhbiL12sx/HrCTolsP+y/X+FqlpYxsO7NwxjqczaP3?=
 =?us-ascii?Q?+VnzXggqZ+P0kPWSW7SQvY54mZBf8rfknuN1NERM2F5i6MFJsSX/kjW8HvOS?=
 =?us-ascii?Q?wsKeDZBRSyFWMC3NP5RyYqQUyZRck5Rp/FlGkd+DVhh92EimsphlRR+FqLdx?=
 =?us-ascii?Q?/WXWkef+X/zyxiPV4pNe4JOvepLsemgMwS3ixtqSwv4dX+4rnQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6523.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j5sNxsgApnR1DewpBw4jq++TG1HS3aBLwaYfcgpqUU48k8fT/zWSnUl0WMtb?=
 =?us-ascii?Q?x0A7ReWZG6H5FLrTJ4oe9Z1QNHKz3WOIOHb3a9ZnZMBDcCLAHsNNpev717Vf?=
 =?us-ascii?Q?kXkL4Hn9w56h5TDsTIj7qZ5PfcY974kBLwyoTGxcvAZaeK+pWIAqiQntdy0w?=
 =?us-ascii?Q?mjoEedZCTTIcPf5IXX7j2y0NT3RPLLCaGGFnr5ijWU6+1drEj0XNNKjJa6Y7?=
 =?us-ascii?Q?C2ng55PVnvK8bbQjibhG9rQN8PKsS25H5vCOL0f96b6WBs5wbNspfmcD4Cz/?=
 =?us-ascii?Q?tQpcnrU2OuhIY6AqbrTc89yUYMXvFclhzEVjEytX3nLQAmY2K0peKOHyXisU?=
 =?us-ascii?Q?3ekOarW8K1taBOeZETI6fCRsDS5D2VhDRHBAYPouif4MUoPKDA1T1oIRjVe1?=
 =?us-ascii?Q?CGlyDFx2nxy2WXVDyE31F0cnLe1RvBu+TylbadpXA3hj7pVBk58LJx1Mt99H?=
 =?us-ascii?Q?QozjA4tuhl4U042DhzWZ+SHMK8xjCxQOpVOuxaJ6j/VnjQArtiWXINf5DCGF?=
 =?us-ascii?Q?SyIYmpz98pe+2zrsLEEuIDuiuSdsLtiuBcmg38i7ZpTNnWb5IxZ0lkSaDYKv?=
 =?us-ascii?Q?RJ1WWzq+lNi90hhJjsWb0sHzKufZFfTcXv4yPgkWJaDHygq0icBgkB8JMr5W?=
 =?us-ascii?Q?SCMXoMpkgenloKPbEdyPSzI5QH+hqfzo6sTtD/RFFjvpbu08oP2pPMUhgsId?=
 =?us-ascii?Q?BFu/pAtfEUJ1SUDBWpLZhkbpJsnCGMLIeZJ6b8gSq1aN9B1G2hx9rf7uWRKd?=
 =?us-ascii?Q?xm9jsAedNFUa7E3TmSV6CMO6xs8bEkFBYhNu4hf6Ya4OZlofs9yDI4A5zkcR?=
 =?us-ascii?Q?yEu7+1zKcZPpUytx0r+ibPBKYGIuOTPHgGl3ZWwek6fs3qdFn8j30CcJFyZP?=
 =?us-ascii?Q?6Zm370EZmV9x9PwZ/Ft/qv27btnEQVjH24eZRlaw/H33LAO5ViDFXPrhAc5x?=
 =?us-ascii?Q?8z75m/YvsIIBMDs7c1No+SvuHv5Y/JcZbIvJM1JrJDIE7Xw9+2EOtYxVuHZV?=
 =?us-ascii?Q?5ePeT0GHyJADkKBfP0QCgSF2p7ndkKHuWDT8N+asnyGj7eIUTU+YIpJ/TCFa?=
 =?us-ascii?Q?t49E72WF8Ds1dXEmapTSdOrvoFqeVgTO5LsWCbCJp30j/P1rVt/Nl4NSJTde?=
 =?us-ascii?Q?Rb8EzDABmvfZ06IFwqLGZCVPnYl/UyaHrZBn+s81nswtY2qfEbQb+rJda+BF?=
 =?us-ascii?Q?OSzB+5XRoz3yjozhQRQPHgcG7QH0aooMsrYfjnfJPbMtN7QILo4cYFTvIzmx?=
 =?us-ascii?Q?lByP0vjIdtlK9/1ZX/RHUdKMCBw2xdJVI/UdujpzZT5VW/GDsZObpvTq4bax?=
 =?us-ascii?Q?1S13dcV5yYfpiwq5wUCMwEQYSpGJ+XcQfdqiQ5f9R6hVoALGzpssjJ2A4Xib?=
 =?us-ascii?Q?/Qit3l9m8xaAtmccQCFn0vXEu+kHhZIs3fabv6W9pYr5+fYQC66VVEYiUi3o?=
 =?us-ascii?Q?w55z0xWM7MWZhfeXwcIG7WKKxYjopo8xuxZiR/hXg50zqmfhabxls0O1O49C?=
 =?us-ascii?Q?AlYcp2mfMurdXPEq607TPkaKNAsgBGI3qNWs/GtU5ZvIJJn+bwSDZ4xSMVWG?=
 =?us-ascii?Q?S1YuluAcIzLnPS58xPh2mHaJdCPXCVyW28xC8tPB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6523.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1b58d1-63b8-4db1-cefa-08dca81da6c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 18:07:28.5008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghCQ84ERknUoPgy13R1MxkSSgIEtqI5m3Np59Vo7nIIOM6aPYKs4uJNqBRSExtaopPe+eLjTX3hubkeqo0PxDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5152
X-OriginatorOrg: intel.com

We've seen some of those "Unpatched return thunk in use. This should not ha=
ppen!" warnings in some out-of-tree code and I'm trying to figure out how t=
o modify the binaries instead of just disabling CONFIG_MITIGATIONS_RETHUNK.=
 I've looked at a few recent commits going back to April where some fixes w=
ere done in-tree and followed some of the QEMU conversations over the same =
warning. It sounds like I need to look at how objtool is munging my generat=
ed code.

A common fix I've seen was to strip OBJECT_FILES_NON_STANDARD_[some object =
here] clauses from Makefiles. As I understand it, their existence suppresse=
s objtool from running on the files. I could set OBJECT_FILES_NON_STANDARD =
to 'y' and just completely shut off objtool, but I want the opposite. I did=
n't have any of those in the first place. For giggles, I tried setting it t=
o 'n' explicitly, but that didn't help. I'm not surprised since I expect th=
at's the default.

Failing having anything else I've explicitly done, I figure I should just p=
aste what objtool currently is doing with each module:

./tools/objtool/objtool --hacks=3Djump_label --hacks=3Dnoinstr --hacks=3Dsk=
ylake --retpoline --rethunk --stackval --static-call --uaccess --prefix=3D1=
6   --module [path to .o here]

Does anything look amiss?

There could be an X-instead-of-Y here with my objtool fascination. Other th=
reads seemed to steer this way. I'd rather be specific, find out that was a=
 misunderstanding, and perish that thought first instead of going a few rou=
nds over a more general approach where objtool nags at me.

[PS I'd also gobble up any summaries on all of these workarounds for variou=
s side-channel speculation attacks because they bite me from time to time a=
nd I need to level up on them]

