Return-Path: <linux-kernel+bounces-512269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD7AA336B9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 05:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE673166CE1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 04:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45865205AD2;
	Thu, 13 Feb 2025 04:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bV971nQ2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46127204F82
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 04:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739420063; cv=fail; b=h2l7AaMXtRo+RoGBTBJ0XoO/dFnTlATOmJAqDhUUMgFj6fd2KEZnTflp+hQL3YSyxAUJW8bukKvmTjgrBecasIEofNyxROjouaUsdzGjtYvXuRwelpXz1L6bM0u1bSk3bt8i1eJERWnoLiql8CJVUJV+biSbzFpDhEqLgHXUqsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739420063; c=relaxed/simple;
	bh=9xhF0ipa20xLjul0uE5DBuv+hvKq8ZmO9ja1L4QN5zI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=WoXbuwwHLdRFvi+Zm/uXw9aY3myR0/oyqs1CWywdXitk5sCMYKwcQLUh36m5RsfTESepKmXkZvHQeeA96jGb+X3HLiu6VxXGwLWhRtLJkhtpgOIGUaC4L7fuSUQpeqUj1Be66F4WocVI0+nz+n7ZS+ke29hJNrUKgFXiTfnhu7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bV971nQ2; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739420060; x=1770956060;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9xhF0ipa20xLjul0uE5DBuv+hvKq8ZmO9ja1L4QN5zI=;
  b=bV971nQ2JXD5lbH7E55uNvVe2qHNFSADfeoK+donLVF453813yWmvaUQ
   dhT+16J+L9DAo7TjCN6J7ifBnjTjmS2yj5x5b6e7EJ/rFhgEsQxPOnZ4I
   KeF537p2zmIgPpuiJu4qyXmW6pPLYJwP2ExPIOeG0YkbDFJMdBgU0np07
   c0IytiCDdWQNS5BxdNMhaGp0mtv8WUFTdIGCe3ReC+hOIdfxXH6lrmbhb
   18xphaf+THPmrpLgaNHoYk62iCCSKHYcHPiJEpR2R1PQIJGb4Hbo0x6et
   iMmbOFReQVGrLElhAWdDBJ55Rf6UOHbT694EcWICyJKER/lbegwL5aKEg
   Q==;
X-CSE-ConnectionGUID: NzsAkjbOQM2n9pO3YPQtLw==
X-CSE-MsgGUID: bCjluFrmRxOJVETsb6k/CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="43877223"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="43877223"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 20:14:16 -0800
X-CSE-ConnectionGUID: ngN3Otf7Rd6tXHWW0X6zAQ==
X-CSE-MsgGUID: hyzbccQ9SWiP6hp6xNLo9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="113217348"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 20:14:15 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 12 Feb 2025 20:14:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 20:14:15 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 20:14:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2MHVmdwCDnonsyMziNFqwRPtVami8n2uX1nbQcdOf6YYZQyBI0Zni5fz9vaHqvSdq8MYKzFukBEyGKk8D8giG1uBaP+19oxeZJkjTFzX648M7i4l1AE16TZ5tFS67F19LRIKt7swq/ZiV1TABwEHSx35LbLUGmXgv3pH7GsA4zFwoC3RyWLlUlcyLj92bOBsmpLpAyb7Y3PN5RIKmjxzDjJAuTzy/zPYkgQdPyrpVdFQbOASTG/O11mqzx3D1u9n2lfA+Cnf+oG93+Od9ds7oP8S+NoLPpkeZkB1vfHh1To61TKJjw+yfjYM0wCjwvW5nDBwGJWy36x37Qa1RH45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKCLjVUJYrVhbmvpItXBDtladXjOu03E2n7EF7RX3AI=;
 b=TcJ68Idl6mFvwIHFnHRHjV1l8gZAnc4YSi+pSTLvm6hOjyU7KPbEDGp8HS+F26cteiVER27w5QuDXwwaFqaVxYHjFFT5wQsobD8N/eomRIIyIrkYAF0kf90rdTov/I4OtDEJpsEcp4qMhKLs2+TFoRmWShVM6nFTroZI+w1GrGD5mqTJvBKFQTusdDM1OjKWrPx/E/ZNGdq0yxVV5keCUTTNQyINH0ppJfTzRWZhusr71ufJbkar/W25PtnhsI0x2uy1j32XCX+f+19TyUtOp7bNtNLO86Vz6PriEcfPA9e59e41eiKEYo/d0ua8qKoaHpsJxcUL5twHPWG6KnJR1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by MW4PR11MB6809.namprd11.prod.outlook.com (2603:10b6:303:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 04:13:44 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 04:13:44 +0000
Date: Thu, 13 Feb 2025 12:13:36 +0800
From: kernel test robot <lkp@intel.com>
To: Joel Stanley <joel@jms.id.au>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi:157.18-164.6: Warning
 (unit_address_vs_reg): /ahb/apb/fsi@1e79b000/cfam@0,0/sbefifo@2400/occ: node
 has a reg or ranges property, but no unit name
Message-ID: <Z61xcI1tiVM/mpAr@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|MW4PR11MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 583654c0-db53-4045-63f6-08dd4be4ce08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|220923002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wyJAT8vbVfi1xd0YmODnAt+ZYEItVWgrmFI94iwI7oR4xpZpiphtjECyMkDO?=
 =?us-ascii?Q?KWB9ScWDfIM0TG7tXPQ+sVfMkZKvXPiJvuUC2lbJrk5C4HYX4I4pVAC09Bwe?=
 =?us-ascii?Q?VpqI9IJXeunLkf3K+UeoSrvugSxOPYRj/n7QCs+M2CNDmb2OEH4Y+m/8Dv6w?=
 =?us-ascii?Q?4HZ/Hbv9E5+iSEix9na1vN7cVJr4c3/tH+FygVMW7P+mO4PP/toa0A67REq2?=
 =?us-ascii?Q?oEVODjA7LzystbeFP5DUxuCi9ZPtdeOKms4K1vrpWwVMJzMUHhACM8ux75YT?=
 =?us-ascii?Q?p/IfdoPAWguMxYZ5W6tmutnhDRwFW8HpalnZwTiJpexVg1zif3v7MyLo7Knc?=
 =?us-ascii?Q?tVd6Zm8GMVzmuesUlyrMQnr9eVmzZqfyrukkhl/zMYokVWEf/FPykdwSKWbK?=
 =?us-ascii?Q?qVGrwL/P/gIpGeEDuujGgc3XlTD3qr14aCXP4dF0K+iatl0M0pz3cD6vdafd?=
 =?us-ascii?Q?o4PLtFIXr0oN7haZ/WIDZjvdNs1v7hM0vP0+WclKCSTFbghYCfSUcbfrzC4N?=
 =?us-ascii?Q?+MzreEBKDiqbsODu6e9r0Oeq7Vb3bGxZZNWAByrNdUa18iJ+NS0TxbdQFNl1?=
 =?us-ascii?Q?f3jq0Yk128yJPVr0xblRYk2fhkjo0GWhaR91RtPkXJY4xROytmhbfa2GylnV?=
 =?us-ascii?Q?CA3g8yO1TjXl1qcHApVdYy9yQoCry1wDfPaWnOkzneroyA0CAyFBR4+zIaQu?=
 =?us-ascii?Q?1zeOByDsrBpqFZA0dZG2wSF9u/XxVnsHR8EG5pZ7RufnU9hyqsd7J3iim0fM?=
 =?us-ascii?Q?JXBBS/eZuNF9k36VZh+l9sTwkx2q7qIr9bmpPod3ki/XWI3F8GUpzAwkP3rU?=
 =?us-ascii?Q?0LegKXDbwJHwhjA924RAdlKInwa0Wd9Q75yCiP7kwILbOoalz3hg1K3yg3wr?=
 =?us-ascii?Q?j+GbwaSkpCN26vTRrt4HLxHwHPYr27YiyyTM+IaDua6Ic/viWpVky1l1HNyA?=
 =?us-ascii?Q?JkzWjnbktl28ChaXHtuGKHQNqEW4wN1TFfeflww44pIXFv+8v0yukIUU/9Dv?=
 =?us-ascii?Q?i3VkjNe4cFQ1Vr3OVmEqqhH6A8giKYztwlPqYTkdcUTgomPb43vwckzsW3yi?=
 =?us-ascii?Q?JzI2eiiVUOxyehIvYL8v9Qx38RoR/P2Ks6uCqG60qFjMVd75BDDa+28uWeaT?=
 =?us-ascii?Q?jnoKHqu9CUlxcnap5wbEMBDQ62hiidQyXngPn1vNszAKWlaNWPWE1YWAseWx?=
 =?us-ascii?Q?J/vedSTLJaKMJa7Tjvgt7fonqtSGxphPHbzYoZsnmyWXQKzoVki58Hd0Y6Zi?=
 =?us-ascii?Q?2SfEGNUGfbfagwe6+wL81WBl4FHjYjEow5uqhMzayIcfaUF00xT1u+oHlMJ/?=
 =?us-ascii?Q?GUyJZO8NEllzFTff2WuYcOMatW8/iU44ibyQr/PU6hWybkE3HnFP14VO4lMo?=
 =?us-ascii?Q?wpBqDqaVMHc937O//CCumX72bBWC821d/FgBP9mg9gZo2pINyw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wMFyFPDL+F1xdYNPajdb9qH7ekO1e2by87tqhBTt4nrnjIKg6wV8gVIx4lGZ?=
 =?us-ascii?Q?CtI+fhmZcFfdf844nb8ppGygM/yZNExrNxK9W3vf8XTpi2GlkewOVkw0fKVV?=
 =?us-ascii?Q?kSfaqQhR86qH2VmEPJy+fJVjES7g3UUEAwE2XOEqgaZXJCQPRQ4x6nPTNMgc?=
 =?us-ascii?Q?O9/YthMNfRCvcrse2Y6VtYqGmqdgl3/8X4UM9Or3GMj2adCgK2rOqObxjVdn?=
 =?us-ascii?Q?KhQORCTBDsa0Ac1QBkg8uQz2gw3JlfTUsvUe9/B+eywNLUUA6WExbPnqqXCQ?=
 =?us-ascii?Q?NLkILx0S2gxnEgvTd0YCj4WpbUlXn3E3sxmd3hkJYrTCxq4voP6thtKzZp1t?=
 =?us-ascii?Q?B3InIr4/qXkX0bb7uqAW/5LQJvDmWxe18epAE5bcGmShHfwo30DFE2NEzaNd?=
 =?us-ascii?Q?qp9o3OO6XqpHkG9qqNa9PXc8rkaLGotZC4QLhogQcqdivsRHrz+W4VGF5oLU?=
 =?us-ascii?Q?VCL7L8EVAHM4LbW/7mnBhwCVABUAjYx4qRYID56RBJagnVJfhTqbZYkW2AkS?=
 =?us-ascii?Q?yayn5dqGMPrfeKEYk7dfuAQo7VNmhtWQS7niz7DsxkuzpkitlmDdckpZEQuU?=
 =?us-ascii?Q?vXSihGoAdJEsrBzHwrL65mZcN21YlTEOKNqeAnrswPn57rpxv/SulIPo4ynD?=
 =?us-ascii?Q?SDY9O+nhHnRXZ8wa8Lp3FdLk3spirD82sQM0cRWOpfnX5IbdH4jjrZWG187C?=
 =?us-ascii?Q?S++6E2nQlY9dWyBknyUDP5XCdeWBq1/UYLVchQ5ELLXzOIylZjiXKDFWBxxw?=
 =?us-ascii?Q?hswGOkBzHnv+bB6iypkuzID6aOw0tZXsEzRwjnayjGOaZyfCieYS9tt1q+o6?=
 =?us-ascii?Q?6eQRha9k5NfRGk0OpVenfuHJLw7sJF3kTs/0KLVSW+VkzesHmLmNiXm7sjeD?=
 =?us-ascii?Q?G9PDgcZ3nzQ4YFuwXouv7wno9bJsi+unORvTKtVmBu9Qo0DONkbNQDX4wmIR?=
 =?us-ascii?Q?OLNLKoLwxoOAxuN2oZWjMyrjNx2R6yEW2TdkGuI6+9BE9/s9f6vxzc872oJS?=
 =?us-ascii?Q?LlsCXP3At4Q/H6xrs0Y4rS1UrEH/6v1+VU2ZALwNrviq9ZWihiqnExDmRJZv?=
 =?us-ascii?Q?97Pz880Bs35qh+Js8H9uJ9J1w+4boHr3Jy5PGc7hjeVPpcBMqvyhIf9vTOUn?=
 =?us-ascii?Q?ioNBpu8wQhmlDdzm63LVLVYyjFSsYLGnuIFrDy8oK413RMAweAL2PZacP1q6?=
 =?us-ascii?Q?4PtvD6VtlvSJ1ycuDMucSHC4r/ASi91KoPOrzzVTyls8Oua1aqbCKK+OIpO1?=
 =?us-ascii?Q?xCBO958/twCvqOF46Yehi2jzkZ8wdrBLMHWWptajM++VXlq2CAPFMe05Fh7e?=
 =?us-ascii?Q?zzAOo1OLXr8WLAj7+2fZ4c23cQTQMnBIRWROSET+eJUmx/f4ibkwVUOkqvBO?=
 =?us-ascii?Q?qc0P0swCpfqJVfwDObb2I1EyxV2jbgcSeaYcp6xxFqudFOeVsoxTgh/seMVS?=
 =?us-ascii?Q?bf3yOD6KkBG4c8vNnqtAsjFhF0a3ondElZn1T+vkm7dVmLgn9flfl2vIbHGr?=
 =?us-ascii?Q?Ksd8kZlWlqPJjSOg+T7aV2X9081WNg0zvxMq1fIJ2U5sml93bjKXbXPYYVBk?=
 =?us-ascii?Q?MTEwhcmi1aoI24qieFcLJBcHWhZjAm+gDsuHxSkFFKaed7Y5s1UyXcfVTGT4?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 583654c0-db53-4045-63f6-08dd4be4ce08
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 04:13:44.2220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbjoJssoK0wjuZXbGmu3L/Vczi17yBZiLKGtYoiYvKZx0IPd2i1koGYC/Xm59phVMO9xNu0VkY2Xt20yXpT92w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6809
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4dc1d1bec89864d8076e5ab314f86f46442bfb02
commit: f868aab874e863374416ecc50419d8b8afc5ea76 ARM: dts: aspeed: bonnell: Reorganise FSI description
date:   1 year, 6 months ago
:::::: branch date: 5 hours ago
:::::: commit date: 1 year, 6 months ago
config: arm-randconfig-004-20230928 (https://download.01.org/0day-ci/archive/20250213/202502131138.HHntltFM-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250213/202502131138.HHntltFM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202502131138.HHntltFM-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi:157.18-164.6: Warning (unit_address_vs_reg): /ahb/apb/fsi@1e79b000/cfam@0,0/sbefifo@2400/occ: node has a reg or ranges property, but no unit name
>> arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi:322.18-329.6: Warning (unit_address_vs_reg): /ahb/apb/fsi@1e79b000/cfam@0,0/hub@3400/cfam@1,0/sbefifo@2400/occ: node has a reg or ranges property, but no unit name
   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:81.19-98.4: Warning (avoid_unnecessary_addr_size): /gpio-keys-polled: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

vim +157 arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi

fa9d3b8be23d02f Eddie James 2023-08-09    3  
fa9d3b8be23d02f Eddie James 2023-08-09    4  &fsim0 {
fa9d3b8be23d02f Eddie James 2023-08-09    5  	status = "okay";
fa9d3b8be23d02f Eddie James 2023-08-09    6  
fa9d3b8be23d02f Eddie James 2023-08-09    7  	#address-cells = <2>;
fa9d3b8be23d02f Eddie James 2023-08-09    8  	#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09    9  
fa9d3b8be23d02f Eddie James 2023-08-09   10  	cfam-reset-gpios = <&gpio0 ASPEED_GPIO(Q, 0) GPIO_ACTIVE_HIGH>;
fa9d3b8be23d02f Eddie James 2023-08-09   11  
fa9d3b8be23d02f Eddie James 2023-08-09   12  	cfam@0,0 {
fa9d3b8be23d02f Eddie James 2023-08-09   13  		reg = <0 0>;
fa9d3b8be23d02f Eddie James 2023-08-09   14  		#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09   15  		#size-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09   16  		chip-id = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09   17  
fa9d3b8be23d02f Eddie James 2023-08-09   18  		scom@1000 {
fa9d3b8be23d02f Eddie James 2023-08-09   19  			compatible = "ibm,fsi2pib";
fa9d3b8be23d02f Eddie James 2023-08-09   20  			reg = <0x1000 0x400>;
fa9d3b8be23d02f Eddie James 2023-08-09   21  		};
fa9d3b8be23d02f Eddie James 2023-08-09   22  
fa9d3b8be23d02f Eddie James 2023-08-09   23  		i2c@1800 {
fa9d3b8be23d02f Eddie James 2023-08-09   24  			compatible = "ibm,fsi-i2c-master";
fa9d3b8be23d02f Eddie James 2023-08-09   25  			reg = <0x1800 0x400>;
fa9d3b8be23d02f Eddie James 2023-08-09   26  			#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09   27  			#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09   28  
fa9d3b8be23d02f Eddie James 2023-08-09   29  			cfam0_i2c0: i2c-bus@0 {
fa9d3b8be23d02f Eddie James 2023-08-09   30  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09   31  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09   32  				reg = <0>;	/* OMI01 */
fa9d3b8be23d02f Eddie James 2023-08-09   33  			};
fa9d3b8be23d02f Eddie James 2023-08-09   34  
fa9d3b8be23d02f Eddie James 2023-08-09   35  			cfam0_i2c1: i2c-bus@1 {
fa9d3b8be23d02f Eddie James 2023-08-09   36  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09   37  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09   38  				reg = <1>;	/* OMI23 */
fa9d3b8be23d02f Eddie James 2023-08-09   39  			};
fa9d3b8be23d02f Eddie James 2023-08-09   40  
fa9d3b8be23d02f Eddie James 2023-08-09   41  			cfam0_i2c10: i2c-bus@a {
fa9d3b8be23d02f Eddie James 2023-08-09   42  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09   43  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09   44  				reg = <10>;	/* OP3A */
fa9d3b8be23d02f Eddie James 2023-08-09   45  			};
fa9d3b8be23d02f Eddie James 2023-08-09   46  
fa9d3b8be23d02f Eddie James 2023-08-09   47  			cfam0_i2c11: i2c-bus@b {
fa9d3b8be23d02f Eddie James 2023-08-09   48  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09   49  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09   50  				reg = <11>;	/* OP3B */
fa9d3b8be23d02f Eddie James 2023-08-09   51  			};
fa9d3b8be23d02f Eddie James 2023-08-09   52  
fa9d3b8be23d02f Eddie James 2023-08-09   53  			cfam0_i2c12: i2c-bus@c {
fa9d3b8be23d02f Eddie James 2023-08-09   54  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09   55  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09   56  				reg = <12>;	/* OP4A */
fa9d3b8be23d02f Eddie James 2023-08-09   57  			};
fa9d3b8be23d02f Eddie James 2023-08-09   58  
fa9d3b8be23d02f Eddie James 2023-08-09   59  			cfam0_i2c13: i2c-bus@d {
fa9d3b8be23d02f Eddie James 2023-08-09   60  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09   61  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09   62  				reg = <13>;	/* OP4B */
fa9d3b8be23d02f Eddie James 2023-08-09   63  			};
fa9d3b8be23d02f Eddie James 2023-08-09   64  
fa9d3b8be23d02f Eddie James 2023-08-09   65  			cfam0_i2c14: i2c-bus@e {
fa9d3b8be23d02f Eddie James 2023-08-09   66  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09   67  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09   68  				reg = <14>;	/* OP5A */
fa9d3b8be23d02f Eddie James 2023-08-09   69  			};
fa9d3b8be23d02f Eddie James 2023-08-09   70  
fa9d3b8be23d02f Eddie James 2023-08-09   71  			cfam0_i2c15: i2c-bus@f {
fa9d3b8be23d02f Eddie James 2023-08-09   72  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09   73  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09   74  				reg = <15>;	/* OP5B */
fa9d3b8be23d02f Eddie James 2023-08-09   75  			};
fa9d3b8be23d02f Eddie James 2023-08-09   76  		};
fa9d3b8be23d02f Eddie James 2023-08-09   77  
fa9d3b8be23d02f Eddie James 2023-08-09   78  		fsi2spi@1c00 {
fa9d3b8be23d02f Eddie James 2023-08-09   79  			compatible = "ibm,fsi2spi";
fa9d3b8be23d02f Eddie James 2023-08-09   80  			reg = <0x1c00 0x400>;
fa9d3b8be23d02f Eddie James 2023-08-09   81  			#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09   82  			#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09   83  
fa9d3b8be23d02f Eddie James 2023-08-09   84  			cfam0_spi0: spi@0 {
fa9d3b8be23d02f Eddie James 2023-08-09   85  				reg = <0x0>;
fa9d3b8be23d02f Eddie James 2023-08-09   86  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09   87  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09   88  
fa9d3b8be23d02f Eddie James 2023-08-09   89  				eeprom@0 {
fa9d3b8be23d02f Eddie James 2023-08-09   90  					at25,byte-len = <0x80000>;
fa9d3b8be23d02f Eddie James 2023-08-09   91  					at25,addr-mode = <4>;
fa9d3b8be23d02f Eddie James 2023-08-09   92  					at25,page-size = <256>;
fa9d3b8be23d02f Eddie James 2023-08-09   93  
fa9d3b8be23d02f Eddie James 2023-08-09   94  					compatible = "atmel,at25";
fa9d3b8be23d02f Eddie James 2023-08-09   95  					reg = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09   96  					spi-max-frequency = <1000000>;
fa9d3b8be23d02f Eddie James 2023-08-09   97  				};
fa9d3b8be23d02f Eddie James 2023-08-09   98  			};
fa9d3b8be23d02f Eddie James 2023-08-09   99  
fa9d3b8be23d02f Eddie James 2023-08-09  100  			cfam0_spi1: spi@20 {
fa9d3b8be23d02f Eddie James 2023-08-09  101  				reg = <0x20>;
fa9d3b8be23d02f Eddie James 2023-08-09  102  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  103  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  104  
fa9d3b8be23d02f Eddie James 2023-08-09  105  				eeprom@0 {
fa9d3b8be23d02f Eddie James 2023-08-09  106  					at25,byte-len = <0x80000>;
fa9d3b8be23d02f Eddie James 2023-08-09  107  					at25,addr-mode = <4>;
fa9d3b8be23d02f Eddie James 2023-08-09  108  					at25,page-size = <256>;
fa9d3b8be23d02f Eddie James 2023-08-09  109  
fa9d3b8be23d02f Eddie James 2023-08-09  110  					compatible = "atmel,at25";
fa9d3b8be23d02f Eddie James 2023-08-09  111  					reg = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  112  					spi-max-frequency = <1000000>;
fa9d3b8be23d02f Eddie James 2023-08-09  113  				};
fa9d3b8be23d02f Eddie James 2023-08-09  114  			};
fa9d3b8be23d02f Eddie James 2023-08-09  115  
fa9d3b8be23d02f Eddie James 2023-08-09  116  			cfam0_spi2: spi@40 {
fa9d3b8be23d02f Eddie James 2023-08-09  117  				reg = <0x40>;
fa9d3b8be23d02f Eddie James 2023-08-09  118  				compatible =  "ibm,fsi2spi";
fa9d3b8be23d02f Eddie James 2023-08-09  119  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  120  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  121  
fa9d3b8be23d02f Eddie James 2023-08-09  122  				eeprom@0 {
fa9d3b8be23d02f Eddie James 2023-08-09  123  					at25,byte-len = <0x80000>;
fa9d3b8be23d02f Eddie James 2023-08-09  124  					at25,addr-mode = <4>;
fa9d3b8be23d02f Eddie James 2023-08-09  125  					at25,page-size = <256>;
fa9d3b8be23d02f Eddie James 2023-08-09  126  
fa9d3b8be23d02f Eddie James 2023-08-09  127  					compatible = "atmel,at25";
fa9d3b8be23d02f Eddie James 2023-08-09  128  					reg = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  129  					spi-max-frequency = <1000000>;
fa9d3b8be23d02f Eddie James 2023-08-09  130  				};
fa9d3b8be23d02f Eddie James 2023-08-09  131  			};
fa9d3b8be23d02f Eddie James 2023-08-09  132  
fa9d3b8be23d02f Eddie James 2023-08-09  133  			cfam0_spi3: spi@60 {
fa9d3b8be23d02f Eddie James 2023-08-09  134  				reg = <0x60>;
fa9d3b8be23d02f Eddie James 2023-08-09  135  				compatible =  "ibm,fsi2spi";
fa9d3b8be23d02f Eddie James 2023-08-09  136  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  137  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  138  
fa9d3b8be23d02f Eddie James 2023-08-09  139  				eeprom@0 {
fa9d3b8be23d02f Eddie James 2023-08-09  140  					at25,byte-len = <0x80000>;
fa9d3b8be23d02f Eddie James 2023-08-09  141  					at25,addr-mode = <4>;
fa9d3b8be23d02f Eddie James 2023-08-09  142  					at25,page-size = <256>;
fa9d3b8be23d02f Eddie James 2023-08-09  143  
fa9d3b8be23d02f Eddie James 2023-08-09  144  					compatible = "atmel,at25";
fa9d3b8be23d02f Eddie James 2023-08-09  145  					reg = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  146  					spi-max-frequency = <1000000>;
fa9d3b8be23d02f Eddie James 2023-08-09  147  				};
fa9d3b8be23d02f Eddie James 2023-08-09  148  			};
fa9d3b8be23d02f Eddie James 2023-08-09  149  		};
fa9d3b8be23d02f Eddie James 2023-08-09  150  
fa9d3b8be23d02f Eddie James 2023-08-09  151  		sbefifo@2400 {
fa9d3b8be23d02f Eddie James 2023-08-09  152  			compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02f Eddie James 2023-08-09  153  			reg = <0x2400 0x400>;
fa9d3b8be23d02f Eddie James 2023-08-09  154  			#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  155  			#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  156  
fa9d3b8be23d02f Eddie James 2023-08-09 @157  			fsi_occ0: occ {
fa9d3b8be23d02f Eddie James 2023-08-09  158  				compatible = "ibm,p10-occ";
fa9d3b8be23d02f Eddie James 2023-08-09  159  
fa9d3b8be23d02f Eddie James 2023-08-09  160  				occ-hwmon {
fa9d3b8be23d02f Eddie James 2023-08-09  161  					compatible = "ibm,p10-occ-hwmon";
fa9d3b8be23d02f Eddie James 2023-08-09  162  					ibm,no-poll-on-init;
fa9d3b8be23d02f Eddie James 2023-08-09  163  				};
fa9d3b8be23d02f Eddie James 2023-08-09  164  			};
fa9d3b8be23d02f Eddie James 2023-08-09  165  		};
fa9d3b8be23d02f Eddie James 2023-08-09  166  
fa9d3b8be23d02f Eddie James 2023-08-09  167  		fsi_hub0: hub@3400 {
fa9d3b8be23d02f Eddie James 2023-08-09  168  			compatible = "fsi-master-hub";
fa9d3b8be23d02f Eddie James 2023-08-09  169  			reg = <0x3400 0x400>;
fa9d3b8be23d02f Eddie James 2023-08-09  170  			#address-cells = <2>;
fa9d3b8be23d02f Eddie James 2023-08-09  171  			#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  172  		};
fa9d3b8be23d02f Eddie James 2023-08-09  173  	};
fa9d3b8be23d02f Eddie James 2023-08-09  174  };
fa9d3b8be23d02f Eddie James 2023-08-09  175  
fa9d3b8be23d02f Eddie James 2023-08-09  176  &fsi_hub0 {
fa9d3b8be23d02f Eddie James 2023-08-09  177  	cfam@1,0 {
fa9d3b8be23d02f Eddie James 2023-08-09  178  		reg = <1 0>;
fa9d3b8be23d02f Eddie James 2023-08-09  179  		#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  180  		#size-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  181  		chip-id = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  182  
fa9d3b8be23d02f Eddie James 2023-08-09  183  		scom@1000 {
fa9d3b8be23d02f Eddie James 2023-08-09  184  			compatible = "ibm,fsi2pib";
fa9d3b8be23d02f Eddie James 2023-08-09  185  			reg = <0x1000 0x400>;
fa9d3b8be23d02f Eddie James 2023-08-09  186  		};
fa9d3b8be23d02f Eddie James 2023-08-09  187  
fa9d3b8be23d02f Eddie James 2023-08-09  188  		i2c@1800 {
fa9d3b8be23d02f Eddie James 2023-08-09  189  			compatible = "ibm,fsi-i2c-master";
fa9d3b8be23d02f Eddie James 2023-08-09  190  			reg = <0x1800 0x400>;
fa9d3b8be23d02f Eddie James 2023-08-09  191  			#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  192  			#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  193  
fa9d3b8be23d02f Eddie James 2023-08-09  194  			cfam1_i2c2: i2c-bus@2 {
fa9d3b8be23d02f Eddie James 2023-08-09  195  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  196  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  197  				reg = <2>;	/* OMI45 */
fa9d3b8be23d02f Eddie James 2023-08-09  198  			};
fa9d3b8be23d02f Eddie James 2023-08-09  199  
fa9d3b8be23d02f Eddie James 2023-08-09  200  			cfam1_i2c3: i2c-bus@3 {
fa9d3b8be23d02f Eddie James 2023-08-09  201  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  202  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  203  				reg = <3>;	/* OMI67 */
fa9d3b8be23d02f Eddie James 2023-08-09  204  			};
fa9d3b8be23d02f Eddie James 2023-08-09  205  
fa9d3b8be23d02f Eddie James 2023-08-09  206  			cfam1_i2c10: i2c-bus@a {
fa9d3b8be23d02f Eddie James 2023-08-09  207  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  208  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  209  				reg = <10>;	/* OP3A */
fa9d3b8be23d02f Eddie James 2023-08-09  210  			};
fa9d3b8be23d02f Eddie James 2023-08-09  211  
fa9d3b8be23d02f Eddie James 2023-08-09  212  			cfam1_i2c11: i2c-bus@b {
fa9d3b8be23d02f Eddie James 2023-08-09  213  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  214  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  215  				reg = <11>;	/* OP3B */
fa9d3b8be23d02f Eddie James 2023-08-09  216  			};
fa9d3b8be23d02f Eddie James 2023-08-09  217  
fa9d3b8be23d02f Eddie James 2023-08-09  218  			cfam1_i2c14: i2c-bus@e {
fa9d3b8be23d02f Eddie James 2023-08-09  219  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  220  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  221  				reg = <14>;	/* OP5A */
fa9d3b8be23d02f Eddie James 2023-08-09  222  			};
fa9d3b8be23d02f Eddie James 2023-08-09  223  
fa9d3b8be23d02f Eddie James 2023-08-09  224  			cfam1_i2c15: i2c-bus@f {
fa9d3b8be23d02f Eddie James 2023-08-09  225  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  226  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  227  				reg = <15>;	/* OP5B */
fa9d3b8be23d02f Eddie James 2023-08-09  228  			};
fa9d3b8be23d02f Eddie James 2023-08-09  229  
fa9d3b8be23d02f Eddie James 2023-08-09  230  			cfam1_i2c16: i2c-bus@10 {
fa9d3b8be23d02f Eddie James 2023-08-09  231  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  232  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  233  				reg = <16>;	/* OP6A */
fa9d3b8be23d02f Eddie James 2023-08-09  234  			};
fa9d3b8be23d02f Eddie James 2023-08-09  235  
fa9d3b8be23d02f Eddie James 2023-08-09  236  			cfam1_i2c17: i2c-bus@11 {
fa9d3b8be23d02f Eddie James 2023-08-09  237  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  238  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  239  				reg = <17>;	/* OP6B */
fa9d3b8be23d02f Eddie James 2023-08-09  240  			};
fa9d3b8be23d02f Eddie James 2023-08-09  241  		};
fa9d3b8be23d02f Eddie James 2023-08-09  242  
fa9d3b8be23d02f Eddie James 2023-08-09  243  		fsi2spi@1c00 {
fa9d3b8be23d02f Eddie James 2023-08-09  244  			compatible = "ibm,fsi2spi";
fa9d3b8be23d02f Eddie James 2023-08-09  245  			reg = <0x1c00 0x400>;
fa9d3b8be23d02f Eddie James 2023-08-09  246  			#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  247  			#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  248  
fa9d3b8be23d02f Eddie James 2023-08-09  249  			cfam1_spi0: spi@0 {
fa9d3b8be23d02f Eddie James 2023-08-09  250  				reg = <0x0>;
fa9d3b8be23d02f Eddie James 2023-08-09  251  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  252  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  253  
fa9d3b8be23d02f Eddie James 2023-08-09  254  				eeprom@0 {
fa9d3b8be23d02f Eddie James 2023-08-09  255  					at25,byte-len = <0x80000>;
fa9d3b8be23d02f Eddie James 2023-08-09  256  					at25,addr-mode = <4>;
fa9d3b8be23d02f Eddie James 2023-08-09  257  					at25,page-size = <256>;
fa9d3b8be23d02f Eddie James 2023-08-09  258  
fa9d3b8be23d02f Eddie James 2023-08-09  259  					compatible = "atmel,at25";
fa9d3b8be23d02f Eddie James 2023-08-09  260  					reg = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  261  					spi-max-frequency = <1000000>;
fa9d3b8be23d02f Eddie James 2023-08-09  262  				};
fa9d3b8be23d02f Eddie James 2023-08-09  263  			};
fa9d3b8be23d02f Eddie James 2023-08-09  264  
fa9d3b8be23d02f Eddie James 2023-08-09  265  			cfam1_spi1: spi@20 {
fa9d3b8be23d02f Eddie James 2023-08-09  266  				reg = <0x20>;
fa9d3b8be23d02f Eddie James 2023-08-09  267  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  268  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  269  
fa9d3b8be23d02f Eddie James 2023-08-09  270  				eeprom@0 {
fa9d3b8be23d02f Eddie James 2023-08-09  271  					at25,byte-len = <0x80000>;
fa9d3b8be23d02f Eddie James 2023-08-09  272  					at25,addr-mode = <4>;
fa9d3b8be23d02f Eddie James 2023-08-09  273  					at25,page-size = <256>;
fa9d3b8be23d02f Eddie James 2023-08-09  274  
fa9d3b8be23d02f Eddie James 2023-08-09  275  					compatible = "atmel,at25";
fa9d3b8be23d02f Eddie James 2023-08-09  276  					reg = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  277  					spi-max-frequency = <1000000>;
fa9d3b8be23d02f Eddie James 2023-08-09  278  				};
fa9d3b8be23d02f Eddie James 2023-08-09  279  			};
fa9d3b8be23d02f Eddie James 2023-08-09  280  
fa9d3b8be23d02f Eddie James 2023-08-09  281  			cfam1_spi2: spi@40 {
fa9d3b8be23d02f Eddie James 2023-08-09  282  				reg = <0x40>;
fa9d3b8be23d02f Eddie James 2023-08-09  283  				compatible =  "ibm,fsi2spi";
fa9d3b8be23d02f Eddie James 2023-08-09  284  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  285  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  286  
fa9d3b8be23d02f Eddie James 2023-08-09  287  				eeprom@0 {
fa9d3b8be23d02f Eddie James 2023-08-09  288  					at25,byte-len = <0x80000>;
fa9d3b8be23d02f Eddie James 2023-08-09  289  					at25,addr-mode = <4>;
fa9d3b8be23d02f Eddie James 2023-08-09  290  					at25,page-size = <256>;
fa9d3b8be23d02f Eddie James 2023-08-09  291  
fa9d3b8be23d02f Eddie James 2023-08-09  292  					compatible = "atmel,at25";
fa9d3b8be23d02f Eddie James 2023-08-09  293  					reg = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  294  					spi-max-frequency = <1000000>;
fa9d3b8be23d02f Eddie James 2023-08-09  295  				};
fa9d3b8be23d02f Eddie James 2023-08-09  296  			};
fa9d3b8be23d02f Eddie James 2023-08-09  297  
fa9d3b8be23d02f Eddie James 2023-08-09  298  			cfam1_spi3: spi@60 {
fa9d3b8be23d02f Eddie James 2023-08-09  299  				reg = <0x60>;
fa9d3b8be23d02f Eddie James 2023-08-09  300  				compatible =  "ibm,fsi2spi";
fa9d3b8be23d02f Eddie James 2023-08-09  301  				#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  302  				#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  303  
fa9d3b8be23d02f Eddie James 2023-08-09  304  				eeprom@0 {
fa9d3b8be23d02f Eddie James 2023-08-09  305  					at25,byte-len = <0x80000>;
fa9d3b8be23d02f Eddie James 2023-08-09  306  					at25,addr-mode = <4>;
fa9d3b8be23d02f Eddie James 2023-08-09  307  					at25,page-size = <256>;
fa9d3b8be23d02f Eddie James 2023-08-09  308  
fa9d3b8be23d02f Eddie James 2023-08-09  309  					compatible = "atmel,at25";
fa9d3b8be23d02f Eddie James 2023-08-09  310  					reg = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  311  					spi-max-frequency = <1000000>;
fa9d3b8be23d02f Eddie James 2023-08-09  312  				};
fa9d3b8be23d02f Eddie James 2023-08-09  313  			};
fa9d3b8be23d02f Eddie James 2023-08-09  314  		};
fa9d3b8be23d02f Eddie James 2023-08-09  315  
fa9d3b8be23d02f Eddie James 2023-08-09  316  		sbefifo@2400 {
fa9d3b8be23d02f Eddie James 2023-08-09  317  			compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02f Eddie James 2023-08-09  318  			reg = <0x2400 0x400>;
fa9d3b8be23d02f Eddie James 2023-08-09  319  			#address-cells = <1>;
fa9d3b8be23d02f Eddie James 2023-08-09  320  			#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  321  
fa9d3b8be23d02f Eddie James 2023-08-09 @322  			fsi_occ1: occ {
fa9d3b8be23d02f Eddie James 2023-08-09  323  				compatible = "ibm,p10-occ";
fa9d3b8be23d02f Eddie James 2023-08-09  324  
fa9d3b8be23d02f Eddie James 2023-08-09  325  				occ-hwmon {
fa9d3b8be23d02f Eddie James 2023-08-09  326  					compatible = "ibm,p10-occ-hwmon";
fa9d3b8be23d02f Eddie James 2023-08-09  327  					ibm,no-poll-on-init;
fa9d3b8be23d02f Eddie James 2023-08-09  328  				};
fa9d3b8be23d02f Eddie James 2023-08-09  329  			};
fa9d3b8be23d02f Eddie James 2023-08-09  330  		};
fa9d3b8be23d02f Eddie James 2023-08-09  331  
fa9d3b8be23d02f Eddie James 2023-08-09  332  		fsi_hub1: hub@3400 {
fa9d3b8be23d02f Eddie James 2023-08-09  333  			compatible = "fsi-master-hub";
fa9d3b8be23d02f Eddie James 2023-08-09  334  			reg = <0x3400 0x400>;
fa9d3b8be23d02f Eddie James 2023-08-09  335  			#address-cells = <2>;
fa9d3b8be23d02f Eddie James 2023-08-09  336  			#size-cells = <0>;
fa9d3b8be23d02f Eddie James 2023-08-09  337  
fa9d3b8be23d02f Eddie James 2023-08-09  338  			no-scan-on-init;
fa9d3b8be23d02f Eddie James 2023-08-09  339  		};
fa9d3b8be23d02f Eddie James 2023-08-09  340  	};
fa9d3b8be23d02f Eddie James 2023-08-09  341  };
fa9d3b8be23d02f Eddie James 2023-08-09  342  

:::::: The code at line 157 was first introduced by commit
:::::: fa9d3b8be23d02f22f7476c2df2c7aa6e67fb115 ARM: dts: aspeed: Add P10 FSI descriptions

:::::: TO: Eddie James <eajames@linux.ibm.com>
:::::: CC: Joel Stanley <joel@jms.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


