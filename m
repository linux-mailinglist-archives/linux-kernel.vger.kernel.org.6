Return-Path: <linux-kernel+bounces-245329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D6C92B15A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF8B9B20FEF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47217144D11;
	Tue,  9 Jul 2024 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWBVG0Ci"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC0A142E7C;
	Tue,  9 Jul 2024 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510825; cv=fail; b=UYv38+sNtdnk4mlK/ZTMPJv2U3MO1ks4TOxz5Oi8AvG1efaeiBBvo0NvXsCPTKhsQXiBZ8VBCyieYI98HFqZT5vn0Xe6sissn1XtalkTBvB84ZFSgn2okqeL3oJq0yXM8JcYvMfCKXiN78dCAXowXZdjWHt9fd7eg1jEZo48PJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510825; c=relaxed/simple;
	bh=wj+OJX5hoUIcaJUFnJlm+GaYI1Nr/asUbx79zkJKIls=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=bAW2tabLJxxbk1GoM2JcqZLpnGostBnvtDbfLKzBKKXbPsbxN2CBH4dTCf2PcVKFVKDpi5A86ccmnRo6h1ljdPO6sbY6qbWBsZRiXtuFEnmUBDrN1494M6a8g95wwU5Gy9q4s0gRryDMjI83huUeKlYBc1vpunp5QxXYbR+KbDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWBVG0Ci; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720510823; x=1752046823;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wj+OJX5hoUIcaJUFnJlm+GaYI1Nr/asUbx79zkJKIls=;
  b=fWBVG0Ci/QGlwf4bRW3mN9PuPo5TRPTOsMXhcLRJQ2zcabjuhz9bMqBs
   2v0F0HFOogI333bHXjZ/xoV3nlFeM2Dm13aB2MwviPm/LUbTLARvJk7ah
   nccDxb7eXIFdbGDU/piMDc3fGTfTv1YrsM5blEBEdYNGcv0E6JHTHryLo
   vny3+1cYiXOXJ8ctXgHbpyoO18I8FkcIPVjn+Vyv1csMNymREN5AKt1SF
   qGXVOR51E5r/IDA+84Hxy91yhekUFbDqaxTS3f8ZiEaCWD05e3lM/DRlg
   WH5s+dsS6xo21VY2ra6fDvVFXtOx+XizW+QWn+QnC5cz8nBUV+N5pUczv
   Q==;
X-CSE-ConnectionGUID: SCG/LfcrTJe+P/LOC3RZig==
X-CSE-MsgGUID: 6uTnuuU9RnOZtpvkuHyqgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="40255283"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="40255283"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 00:40:19 -0700
X-CSE-ConnectionGUID: ukj83bdCRseclElsfFdGBw==
X-CSE-MsgGUID: mH2SUpwkTMia+WNnOqrGdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="78502307"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 00:40:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 00:40:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 00:40:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 00:40:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 00:40:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bxo5bGo16EK11fS+aF0QYRVL/ZmqvNI6i+imMtzXiZPo3CRaPwUbh1OjNNdAiHRXU2uCisuf1E87M2S3AOAxDTaGk8O/9M79OA6rqfKgxdTiwpINS1w0urAT48YZdLetoGR4rVVN/vBAz921VwAC+T3WRuCFHOtXHJ+kaPvl9p9azIQcefhrmG31pUgZN80UknZp1F1z8+2/cMOpZVZdeY/BlH5u+tfvaqDhfSNp33p3ivH0XgZ9U4xOv/iERSBDEGB7n6epSZbGKZY03PAhYWo5+RqQH095JbbXZ1GojphMPcJK6JVXssjtdv7KTRJNPl5Uu5I4r0O0jDqmECTheQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8quClF7gWucU+eATTmPfkQl07gtvobtlPEMS2ImdoU=;
 b=mBVc3w6KxN0VKsI+XmrfNp4+e9vted9etJbKWoYzL/YtDaoxpEO0kZRFwBT+rRT+HpafkeVtyyQeNMuYmy/Obb3CII6Wc8+UZHUEL5NbxdToNMkSqJqywKw1n8qkG9SdaCC9Ur8bEsLqM9PRnXoFgI75NfZT6EQhglj9YT4U4SdplWKhn5FitRYydjkJnQ7PJbgZ6zuXx6FBrVa/3s2HUlkFxzBYZCJd4MineejXXNe2ZXaVDZmz2jjPehXQGbZViDSZMUwlqmZg2Qd5J9tOWwqbqjFOtngi+PsFm7gzVU7VK+rOS1fit7xclAoa+NyjTFPetzpyicdVGg2kiEIRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7025.namprd11.prod.outlook.com (2603:10b6:510:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 07:40:15 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 07:40:15 +0000
Date: Tue, 9 Jul 2024 15:40:04 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Armin Wolf <W_Armin@gmx.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Hans de Goede <hdegoede@redhat.com>, kemal <kmal@cock.li>,
	<platform-driver-x86@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [platform/x86]  e527a61272:
 UBSAN:array-index-out-of-bounds_in_drivers/firmware/dmi_scan.c
Message-ID: <202407091536.8b116b3d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: a95acbee-d451-4ddf-5a59-08dc9fea5f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LaJQPZBqq7V5QUjlZTq5PbIAEg9BFYUbUvES1Mky99+z9ojCX8LGZPyD9r28?=
 =?us-ascii?Q?Eh8Ju+grhJzyt0IWLd+e8DyKOO/11Pbpgi5Zc4OnDaHIgPVMNiLK0H2w7O/V?=
 =?us-ascii?Q?5vvIWsT0hNrkmt6E77moIOY01VRx91u0WRhMJazeRXfJPDW6JmG5Cly8l1S+?=
 =?us-ascii?Q?tMTyu3YgbpGsaB+ZTJRrnMsctNKkWp3cj1C3IONphQAON/EAJXCauDUxQ1Mm?=
 =?us-ascii?Q?ZXt7nReicYumEp/d4V9yFSZTlf0SB1d0YD+gk4KxbiuKpR1llpqj0VcgdkqG?=
 =?us-ascii?Q?2/3imKUfr4iNOJsG/Xr1kqei2npyTfLplkposvNve9+2KRUUOBXTYXCoIG0t?=
 =?us-ascii?Q?lvhnomXNGdN8P69m5AMxP3wo24OWVsqNmWtx4oZ/TNiW1FyDF0UDY3saKtvs?=
 =?us-ascii?Q?U2oIyDNrpzZ+eu/XrP3JnlCvus4Jo168JWMx77bm7uhS5ISDo3etKHKlqOdI?=
 =?us-ascii?Q?xJBvn44ZBGdD+iAziVeNp9PH6S762a6Xs7oyheiToMlycwplGT5+1unxml+y?=
 =?us-ascii?Q?m0h+zt/BJDq8JZ6dT2HTX8tXb7hoRz/yikGipyiXM2cIGLRKoIErEoblN8AT?=
 =?us-ascii?Q?b/NUYN0w846xHw1AxVS57c+hpYJ6j0MbWjs62jLkeDi3UGEX7L5G/jq7iRQp?=
 =?us-ascii?Q?o5GJTrzWcm7adiyNbPiY5jBN4KNZ/2Xg4vgxbctBOj1IiiMYKbbded75VOPG?=
 =?us-ascii?Q?ldelrO5CMbuTOzRBsKF3IHSlqfzruIc9egk65MewSVmblInIL6KNsuyk1HEZ?=
 =?us-ascii?Q?pE5XYCL4+lT4C+0k4o/46bbFvBHbcB+gEUtT0neaKPqQKdyqQrW/6tfeu0l9?=
 =?us-ascii?Q?dvyDVGkDorqJErUZXkBwrRa4GbBgYguSzx9Ue5TX9k1swqRXrh0Sv/nL7sRN?=
 =?us-ascii?Q?SyGg7Wxkd5IxU7kAt+/KOqpf0QU/nzMfkT5040jEdVqHiyZ3hysuLh/P7ks+?=
 =?us-ascii?Q?E8jtB2tSXM5bj64C5A0pXFnmZrM4cFavs2EmaAciPzdC7Gt4IUoUWRmtZP4V?=
 =?us-ascii?Q?Z+TrgDj9ZfEqM61vNuJ/krFDjZ26tclrzrrRqBNPt+aa3T5vZd8aWX44/dPa?=
 =?us-ascii?Q?wdv0aE15XviQG2XhUDeQmWw9L8XQ4Jp/PFsneoptXuRnRmEUpz33FPROqeOJ?=
 =?us-ascii?Q?FTnFSrp3kvhr3b8ymBJZnaA1PCNWbTUHBavxpNXnq/NL5MjLzHaOzSU9vxv7?=
 =?us-ascii?Q?T0rUjzY0FOVEKK0ZcVPgFiPp7XtZd+LDtefOK7IcwyIwSc8gPBrWwB79oWB9?=
 =?us-ascii?Q?7K1SOnC+fNRAftMQ3ZJhEMPRJLyulqd38vAF6N2PU0bZor4Ivatp2oSAruq/?=
 =?us-ascii?Q?3f4qlXUe3fsw4EoX8mC+mSMB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c0hcoWf4OhSivsggJLxG7qXd6+k6t6hkqhWvf+k1t0PQdYzvK/0xyLZYsRc9?=
 =?us-ascii?Q?oKAzHe9wewJKPFVuOvb+w19A8ugSH+eDPDR443+nkNZmRbbNLgb2ze+gtrOs?=
 =?us-ascii?Q?gQO387pICNtBkh5MQOxo5obHj8qTmGUo2Ah5vnxNfDDVV887GwEgPliW8C6w?=
 =?us-ascii?Q?3idp9wJoCRWQQcoudRZ3nQpnIe9NkJS5lN8vmeWs3dZOdJTL4Kbe/y3A64de?=
 =?us-ascii?Q?hMEm/L4BOba010/x2CqBO6dYJxN69Pa9IzKGjIaXDhYzxQ9ukvP8aqQwfkVI?=
 =?us-ascii?Q?pdkqUAL9OIT7WtNzXABHQZYQ2ye04sd1T8KrJsNjp/+4IXVZmSTE+ncip8Nu?=
 =?us-ascii?Q?Ei31DCwehuUrchYTnfzLsVMQi9x9CDyzjDXRbwmEZ/OcUdtbDSKalyZK2VIr?=
 =?us-ascii?Q?sqoHxLl4x6NnxQZfxhSZb7l37nbMcbZmJk5+xgnS/MqlJhKdMW3TWw3obZUB?=
 =?us-ascii?Q?taJ9hXZpfN5+VTRDmbv0QzAxSlmMPVQWgCm5HE1682sVfZXjs8zdtbTREn5P?=
 =?us-ascii?Q?TAjGX0y/5D0k986H5ZSfFfoX8xynKS/MX/G910u6hU7ZBrMKNxSA0YjIDus4?=
 =?us-ascii?Q?9huVBL4vJGfW17QO0EkiHHYikvfJsfatApNCF9n+ZE5iqm4epA7EQPMA3d6n?=
 =?us-ascii?Q?l5hBBcuk7+IacyoHUI7C/7v/p9vYne7DIGSh+rpIKa41okRKB3pqfB0aYyAw?=
 =?us-ascii?Q?LNyiN9hljeO4rER05vcaYB8k2tl5CkCXFfXU+SqR2mxiCe8J1p9+0jtn/GHE?=
 =?us-ascii?Q?hVW3xByFH/eNCJRZTyC+XAbqNGGvKUcNpPpHElt6boJRgPR04M7sgyQ/FGZz?=
 =?us-ascii?Q?GVgt/Aa1yfJeTWndZkBHsuc2kGqpF2fuelokPwk4dAVUMP1+aREURV41qAw2?=
 =?us-ascii?Q?gFkJfPpOQ+d2wu1NwWDlu3lY0BadpFJQZ2E35nSkcDp5iAfznPpusJVgi+ST?=
 =?us-ascii?Q?mOUukzd3aHtyl39zpflZ927eD4UrXGe97/ZNAZPugwO/fCS1wHalfMlV+TQl?=
 =?us-ascii?Q?FYaLCRPPd9apC/Qj5H4WtUQiRRlcCZI6N3LIjtyg/sTpWeFdTwfIaTJKf04K?=
 =?us-ascii?Q?T5b/c3MGEwSxPVZdyh6l3FBmM4gc6u+NQBaZXkPvA6L4t1Kn6l9Vtp1qz53h?=
 =?us-ascii?Q?x/jirjoy9DZUYFuH2W+omAbQqK29dqakDDhdRbek4luGoVcHmA/7RU5Jdmrf?=
 =?us-ascii?Q?jaHAMfNlOHLfATb+f/y4/F5KrcMmH/CVxmZ+E4ykluYfYKw1jg4imsxO7KF8?=
 =?us-ascii?Q?F70gQmz9ysZmsJ8jSonkIK6inUDBEXi1gyeV36JiJKqvMcJeeCwtL6p9A0DQ?=
 =?us-ascii?Q?KMu/LPL1hDi4BMf66goViW+r8AjEZQHKA2gzGXWt6JQTagNUefOnYov0P0JW?=
 =?us-ascii?Q?qMUZP8c/UYL6gT3/x36dOox16Xz/ddXE4w0iouGNH7ciHpHfl+T3QWpD4Rcn?=
 =?us-ascii?Q?1Ac81SYDAqEt2R78ILNhHGfKe0D434ZZgxshV4ciS37TqP6mdSQYoMPRav7M?=
 =?us-ascii?Q?26gd/CvTTDXC9AyPTEsz37wG1ZjfkOOpBbSmManATJcChnPTo6PAnJ+SiEdC?=
 =?us-ascii?Q?ZfR06pXHSWkIrwWzJqbmZQOQ5LqAuCvYok0pG2RAu37sMFRaBgu+AWsjwCnD?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a95acbee-d451-4ddf-5a59-08dc9fea5f71
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 07:40:15.3124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkJrMn93CdtizjQZMe5FZ81bl1M3ew1V4dNO9guNZDT9cC+8djorJ1QqkeDBAqa8MVcF11qNo/pbflOYDFhncw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7025
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "UBSAN:array-index-out-of-bounds_in_drivers/firmware/dmi_scan.c" on:

commit: e527a6127223b644e0a27b44f4b16e16eb6c7f0a ("platform/x86: toshiba_acpi: Fix quickstart quirk handling")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      1dd28064d4164a4dc9096fd1a7990d2de15f2bb6]
[test failed on linux-next/master 0b58e108042b0ed28a71cd7edf5175999955b233]

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: default
	torture_type: tasks



compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------------------+------------+------------+
|                                                                | 7add1ee346 | e527a61272 |
+----------------------------------------------------------------+------------+------------+
| UBSAN:array-index-out-of-bounds_in_drivers/firmware/dmi_scan.c | 0          | 12         |
+----------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407091536.8b116b3d-lkp@intel.com


[   29.706379][    T1] ------------[ cut here ]------------
[   29.707252][    T1] UBSAN: array-index-out-of-bounds in drivers/firmware/dmi_scan.c:859:23
[   29.708541][    T1] index 116 is out of range for type 'char *[23]'
[   29.709456][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 6.10.0-rc1-00022-ge527a6127223 #1 ab67a70a695d4c6254fd8ecc241ff23c9c365cc4
[   29.711170][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   29.711230][    T1] Call Trace:
[   29.711230][    T1]  <TASK>
[ 29.711230][ T1] dump_stack_lvl (lib/dump_stack.c:117 (discriminator 1)) 
[ 29.711230][ T1] dump_stack (lib/dump_stack.c:124) 
[ 29.711230][ T1] ubsan_epilogue (lib/ubsan.c:232) 
[ 29.711230][ T1] __ubsan_handle_out_of_bounds (lib/ubsan.c:429) 
[ 29.711230][ T1] dmi_matches (drivers/firmware/dmi_scan.c:859) 
[ 29.711230][ T1] dmi_first_match (drivers/firmware/dmi_scan.c:936 (discriminator 1)) 
[ 29.711230][ T1] toshiba_acpi_init (drivers/platform/x86/toshiba_acpi.c:3615 drivers/platform/x86/toshiba_acpi.c:3629) 
[ 29.711230][ T1] ? toshiba_wmi_init (drivers/platform/x86/toshiba_acpi.c:3626) 
[ 29.711230][ T1] do_one_initcall (init/main.c:1267) 
[ 29.711230][ T1] ? trace_event_raw_event_initcall_level (init/main.c:1258) 
[ 29.711230][ T1] ? do_initcalls (include/linux/slab.h:664 include/linux/slab.h:778 init/main.c:1338) 
[ 29.711230][ T1] do_initcalls (init/main.c:1328 (discriminator 1) init/main.c:1345 (discriminator 1)) 
[ 29.711230][ T1] kernel_init_freeable (init/main.c:1580) 
[ 29.711230][ T1] ? rest_init (init/main.c:1459) 
[ 29.711230][ T1] kernel_init (init/main.c:1469) 
[ 29.711230][ T1] ? __switch_to (arch/x86/kernel/process_64.c:713) 
[ 29.711230][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 29.711230][ T1] ? rest_init (init/main.c:1459) 
[ 29.711230][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   29.711230][    T1]  </TASK>
[   29.726986][    T1] ---[ end trace ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240709/202407091536.8b116b3d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


