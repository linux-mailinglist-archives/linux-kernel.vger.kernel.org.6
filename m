Return-Path: <linux-kernel+bounces-288868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1DD953FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA251C22153
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E57A482E2;
	Fri, 16 Aug 2024 02:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MczmcbZx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5632C1C14
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723776389; cv=fail; b=to/LTc3jWeNnjVBAo6HzQ7WPNyuL+1ubO4CoJ0OHPvGW5A3viuz55y7xNE5cKieknWlKJleEVjSdwYvi+1Cy8YsFjGXeElQiVdQwU+diPrZWNdvncqtDF4pKwZ7Fa0ScCA0TJGsswyiaYNjyeglxN0nVZDYxmjKLh97q69AoG+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723776389; c=relaxed/simple;
	bh=xTbs3oq/1Hmb/YS3Ojz8cRvyNv+UtJiTJ50iAsP+4+E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F1twvilBZQSnUHAA3imhby71G+UEtG/+V8FpRbVGOlg0AHN1GeprapGL5OeI4aHHGjuU1dbhM0VOekNdWQUkfhMWXlNf/YEeJBXpyaN587oPQJ1/AudtAcnIZ+/wwtQx21lOiea2Wd2qliCkCdd6dBwkDnjNRUflC22TVk4E6g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MczmcbZx; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723776387; x=1755312387;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xTbs3oq/1Hmb/YS3Ojz8cRvyNv+UtJiTJ50iAsP+4+E=;
  b=MczmcbZxcalHyZgbVu6kBH0LLMRXe5Ut/r64wiyjiIxnnLQdwORXfsz5
   4ThjM1cBm9120B9MS4dWwOj/TrpTxKnEzjI6WqvJeCp4dlFsqIB7JzsrZ
   xcH0dPGAlIX0qncAdeumsIUk3o7B6nrsorTtskWyX/ho96JhIuv0K03Nl
   bl1/oVgSjJQdqgeWOJpyDrzIniHjdC/z7MZF42pihgIkKQZmtmAvPtjoD
   tb5ifDTTx7ZkW9+f6Kx8KDfjZwkGDk8IWw9z52g56YP4GrepHfRTlJ5rO
   toPalszG6I5Ewm/79UgEnaMt2s+PKQbP9RBLKmbo4geRJhD2CPDmr8yr0
   Q==;
X-CSE-ConnectionGUID: WtFqkm6URvmd1DMhejBNuQ==
X-CSE-MsgGUID: zhYvk2fBR2mnFOEPdlKLIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22205030"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="22205030"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 19:46:27 -0700
X-CSE-ConnectionGUID: ++R5wiM9RbaZqVIJNq+W/w==
X-CSE-MsgGUID: OJQdMXtiRbqtVHcL8GkVFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="59383342"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 19:46:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 19:46:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 19:46:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 19:46:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 19:46:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUH76/Bo7nQBtoIs4qVxCGFjiMoHXccDyCLZae1Swa2fxDMY8G9A4yfCd9faM/7FMMXGJJzTXPcQC+mWZ1jk/f3/BVvgLTpmsWziVID4f3Y6DZRVaw6qDDsccG1NVfLRloeHFL3/kLY9eZvyQpEcDF2o9BbUN9RYS7JdW3bTquJtt7i58QpU/Zr0ZIIDk1vqA/Z2Zc7s8iEuJudkY8LCl0anI7bp6v4qFPSqpfZ0aAuwCmfcvJQ8h/sK8ujx8cPKXkWXGveAN/L4hZ3Z/0n6ZLhjotXB52uG6Urn84dk34N2u7FdktUCMlkfDivqX+kfleqCt0qWiB3+FjC/WRAojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWbPVAXJ82SDfq/0JJK0+BM5NUvTRrPZgdhPP1Zfk5s=;
 b=CsV7pnfF6o2G9m3l4/TA3ffERsbSWN+2EkCxEVl5EglM3fUlCbevgOrcgEltMUn2szZYTnHq39jYUbtcqetkDi4BkyJ0yNO/J7PTZae6VkUA4mWuw4conNMP7zXa7W89DzRUeSf20sjnxWijNNsQek/GDKwkVUytFUJHXVcQ7JKQNK1jRgH/nHZID/zQd9QdxkktCCIWf4vH/KmKKAqDc+nGyRJmu7ir6/GgeN42MYY6ocALOENgoNaxIV4MmZfdYTZTERQHNb8TkxLeyryTCEoCDcgvu2b32oNVFevqxc/BeElam+fFjNoSDCvZhmQSaSqVjdcpael6gOmA9FpHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH7PR11MB6953.namprd11.prod.outlook.com (2603:10b6:510:204::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Fri, 16 Aug
 2024 02:46:21 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 02:46:21 +0000
Date: Fri, 16 Aug 2024 02:45:20 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: fix null-ptr-deref on __alloc_workqueue()
 error
Message-ID: <Zr69QOysEfYXkMwb@DUT025-TGLU.fm.intel.com>
References: <20240815070339.346160-1-senozhatsky@chromium.org>
 <20240815070900.GB12106@google.com>
 <20240815072427.GC12106@google.com>
 <Zr4lN63t25Og5/0G@DUT025-TGLU.fm.intel.com>
 <Zr4rosIiK2a0sGhc@DUT025-TGLU.fm.intel.com>
 <20240816023831.GD12106@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240816023831.GD12106@google.com>
X-ClientProxiedBy: SJ0PR05CA0146.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::31) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH7PR11MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f86971-7c06-437c-dee2-08dcbd9d9c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WsCMQiNwosLBb+UoJB4Znt+N4fj/OIRbVeE48ZXdjysgpKt2iuQP7k4YhJpY?=
 =?us-ascii?Q?bk7zp6O/JZh1N/Se8FBMlTGK8xmxrFG1fQ+jTQbN1lFYBXTigEgLJald8Blh?=
 =?us-ascii?Q?5XyHIBKkq/RHl8HFthObCeAzwC5mNqOgb+U9tnY9ZnbDivh5HygfQ4o+wvv8?=
 =?us-ascii?Q?qR4J9dHcOsfJBV0Uft8WoLf3xeTT0WmbTKGc8n0KDny/1E8vGXD8027Mk9sW?=
 =?us-ascii?Q?i0QC7I8iM0p+06yyivWfqU2MSF6hVEQqW7VDiJ8TEHMt2nAqwCX/FZe3t8Or?=
 =?us-ascii?Q?DIG09hDSbO3CkjOTdPJ7lRjJ3DMx889nMlMeJiLCWvb3WqHtUTWwQK3lEr3C?=
 =?us-ascii?Q?Wi5tnfTekNb4Y5ncbAa9OHyqJLrMkYB/TD7Cx4OMTU5ig53sz2+jqwR1v2yr?=
 =?us-ascii?Q?1qwEfbLr+Rz3VhfuUy2zO5aZOAUNeyg7vjCwYlSeiBVDC9ekSopJpsx5IGBf?=
 =?us-ascii?Q?9XEKXDWuGW5o/9nF1mYQ/OgLSxQcxijOyl3MpAZOxXPMb2jJLCySaKz9H4kq?=
 =?us-ascii?Q?7DwvNPkHAU9EjyRETVEYzKHS3nvn1wOW5AlBxnURkMqKl4CsExY5PTWjL8Rx?=
 =?us-ascii?Q?MeKkTFR/Zp2Qm3tXTCyMNaQSo3N+wsUeY0LfL9c208Cqw2HvE2jbSspi7fOt?=
 =?us-ascii?Q?xJi3n7T5TZTCPHU3k76eAIGqIdveDtH3lift5Ag8wotnqXe/WnkrCWAJ9LBS?=
 =?us-ascii?Q?tQ3h74IccSNmvKNh/9FrZOoY30r+Ua21WkM8pMGyVfY4pTC+BSAwKUghsfu2?=
 =?us-ascii?Q?G742QMAg+tIdhJlFx8kQCShnGTBFz7pgvWWl577Z+AK9uFSOWFTm1nAPHt9l?=
 =?us-ascii?Q?pXqKDM75l2FRA7/Xj+ccDji4ZFVGVxRMR5VqNvdp0xZdCBT0Zw2iz0Zkukso?=
 =?us-ascii?Q?5VWaHo2NX45Y6MWpbd7nu2SoXWSyE3weelW/XexC0hktpghkJKyBlxWXDi3Z?=
 =?us-ascii?Q?9nGhmkDMzlwzn2ljjfFci0kZvnffSgkdt+XgTCVSAxjenDeqdACtuz2s8YS4?=
 =?us-ascii?Q?WA4tj2PBzv+5CPoXi0AZWClx3PdYow+vE8Xl71NcqIf02q7g2FRFrvZtwBC6?=
 =?us-ascii?Q?TFsxD/yyZkap+PgTBuZsb2Cz3Ls6btH+K74G74FZyMk40pD2ar+g5GyEKT8O?=
 =?us-ascii?Q?eQuJtkX0k62k3cesSZo4jMXE+3TY2aD9AulicUQAI3oo6jFoN/m2CEGwgecK?=
 =?us-ascii?Q?JylIreELXcxweKuKBOWXOuOmjdm28YLfKvLySIuEXc5Qd8MdIDnEJGfGmTRZ?=
 =?us-ascii?Q?FVtOQKaYZ1DW79Z8y7SDHFr4af6K6+K5FiLz4t5G75S786oxSL9GKN6rvKAd?=
 =?us-ascii?Q?SHasDNHPWsmI7PTM6tOIsqK4w0VFWSqe+skMplaHQxxCDg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2pPs6P4IFAyVPkvmqGhjs4w/BHZy4WqNA45MvsMywRJepbe20q9PfvlThv0X?=
 =?us-ascii?Q?Dhh7GKGayOEea18sOaRD/N4OmtaYxj9SBmOFbfV0+41G5dQGbeNJdH5xRaQu?=
 =?us-ascii?Q?tKuhEfTkGr/y2Lu51GCzd35EsTdmbe12eb1IljFnFEjgYbTQh9kBwdze0Q5m?=
 =?us-ascii?Q?bXjTIItJ4nX4MKh3Eigiv9zBTmY7Q0t48CY4RsPqmFXUdRUIv0+cb/QGG4D4?=
 =?us-ascii?Q?6s/lFif660rNa7dlpbSc/faJpHTg/EdCFBD5wBy7VYHzeLY5wDCzzLd1Clzs?=
 =?us-ascii?Q?wHtQbwZSvz3+/Waib4tWFj3dMbE/oNCA9+AXB5aMpk2Dc5RLgRNKcoWiIUP+?=
 =?us-ascii?Q?DTuFVKCaCOsRhDROpCsQoZjrmN1KynB7AjQXlY/IToLAv5I1ietc00e8gb2y?=
 =?us-ascii?Q?MD4u4aSvH1Zhsg0ug6Asm4dVU3CV5/1GS4nYpX4KNojiYq/2omB5+q6trczt?=
 =?us-ascii?Q?xrQQ1tqvOA5ZJqTb1aaRw0MegxFPakVHK6IdC84wIBITNWj43XIRS1w+x599?=
 =?us-ascii?Q?9hPkgaTv+EV7Qb/KzRjBr7FC2Do00WP6IhUNRR7zaA0imoZo6TCdUTy0FcpJ?=
 =?us-ascii?Q?Z0jUw7/50eGzQhIn0OKz6JoD9lQqD+P1UEIi6nvpqdQiAXWiLdS9ixSvXPkL?=
 =?us-ascii?Q?11O9AT3GIKMkyiaYbn+/fgSnLG3yk1IoZAF3WrNUwKdDkvGiXHqhFIQGvanx?=
 =?us-ascii?Q?cTL8BF6rMD7KxuWWSH5GBH414m0Q9h/xbqz7M2gywUFQHj6daUy2Z6YngpeH?=
 =?us-ascii?Q?i/wN8XsAYqKZ30u6mSjO19797SkVrrLZR4CvKiDuOpmB+c4HO5qjEBr/74pR?=
 =?us-ascii?Q?DnxaMELZokSJuqY0S96KO8OiGBHvHVi1FPi1hI9TYYOV7zRkeFP1UnaKUFJb?=
 =?us-ascii?Q?ebEJasHHi3VJODstdOxnrGadQqXB6JoPjgHlnwdcmM2cB4XqJYpnJgKUbEGv?=
 =?us-ascii?Q?v6AjfJ9VdE4SnesPetmiI9Y7Ftehqc6T6aGomPlGNb33Mb1Zf5KBbp8HFg1G?=
 =?us-ascii?Q?2V45kvQdtdUKQsXorapfRVRLBGuvNQZveKjivBbJCs92qr4V4FA0gMog3a9D?=
 =?us-ascii?Q?oMrakjGusPHF6XbSUg7IObWelwb5XfXOnqE/5LdyElcfMMxcJ99MVP+db3uk?=
 =?us-ascii?Q?Dl/i5Fn4scdkf5ZmuV3y/PVHUbk2rQf3O9xskc7T3ANxJteWbwxqg7qTEbAN?=
 =?us-ascii?Q?em9unCwySBFShJrqfjSVjM6pjICl4s/oIZ46pwvYWeIvw+Ju5JrSolqnnJPV?=
 =?us-ascii?Q?BpasK+bNjfL9XGWWiSQ5+34exGJ/4vj54W+EgjKonMZCvrcGWbPAXELp8Oga?=
 =?us-ascii?Q?YdLCh+Asf0ByXEPmVitRHt7XjrjJPPfSSCJKvpMJnoX3p8AXTSQnpqtzHATI?=
 =?us-ascii?Q?cCawOu8cjn+GnSCUbAG5B0X371u9IT2efdFnwdOwWw6qd4Ggknt4WJsd2wTf?=
 =?us-ascii?Q?kv4G3BcJ8HjmWXVYbhvjyRHJGVjb7hHsP1yjF7bcQtlH0YbyzUww1Kk59e/i?=
 =?us-ascii?Q?0HOC54CvOXrGYo0M/zJHaOkK4EngHjnFBABoR2yN1C1ovyAnboet7MOttj1y?=
 =?us-ascii?Q?0glG0RSMZ6M7wPjbyOP9m4itoCxRYzbQcwhFyvwkAqcSOVDcx6MN80pvfitA?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f86971-7c06-437c-dee2-08dcbd9d9c4b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 02:46:21.0527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nedG+vcPcxTHw2/H9YW1tuh7/08bXdeJCg3vyvQ/Ndd50ValDjLOG5KzMIlvKhK8tZBdH0fzW1o2200UZFzf3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6953
X-OriginatorOrg: intel.com

On Fri, Aug 16, 2024 at 11:38:31AM +0900, Sergey Senozhatsky wrote:
> Hi Matthew,
> 
> On (24/08/15 16:24), Matthew Brost wrote:
> [..]
> > diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> > index 8ccbf510880b..5e818eae092d 100644
> > --- a/include/linux/workqueue.h
> > +++ b/include/linux/workqueue.h
> > @@ -534,7 +534,7 @@ alloc_workqueue_lockdep_map(const char *fmt, unsigned int flags, int max_active,
> >   * @fmt: printf format for the name of the workqueue
> >   * @flags: WQ_* flags (only WQ_FREEZABLE and WQ_MEM_RECLAIM are meaningful)
> >   * @lockdep_map: user-defined lockdep_map
> > - * @args: args for @fmt
> > + * @...: args for @fmt
> >   *
> >   * Same as alloc_ordered_workqueue but with the a user-define lockdep_map.
> >   * Useful for workqueues created with the same purpose and to avoid leaking a
> > @@ -543,20 +543,9 @@ alloc_workqueue_lockdep_map(const char *fmt, unsigned int flags, int max_active,
> >   * RETURNS:
> >   * Pointer to the allocated workqueue on success, %NULL on failure.
> >   */
> > -__printf(1, 4) static inline struct workqueue_struct *
> > -alloc_ordered_workqueue_lockdep_map(const char *fmt, unsigned int flags,
> > -                                   struct lockdep_map *lockdep_map, ...)
> > -{
> > -       struct workqueue_struct *wq;
> > -       va_list args;
> > -
> > -       va_start(args, lockdep_map);
> > -       wq = alloc_workqueue_lockdep_map(fmt, WQ_UNBOUND | __WQ_ORDERED | flags,
> > -                                        1, lockdep_map, args);
> > -       va_end(args);
> > +#define alloc_ordered_workqueue_lockdep_map(fmt, flags, lockdep_map, args...)  \
> > +       alloc_workqueue_lockdep_map(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, lockdep_map, ##args)
> > 
> > -       return wq;
> > -}
> >  #endif
> 
> Oh, I haven't checked the workqueue header.  Yes, you are right.
> A macro should work.
> 

To be clear we your change to __alloc_workqueue in workqueue.c AND my
change to a macro in workqueue.h. In both cases a call chain of
multiple va_start / va_end happens which from what I read up on is not
allowed or undefined behavior depending on the compiler / platform
target.

> 
> Tejun, how do you plan to handle this?  Would it be possible to
> drop current series from your tree so that Matthew can send an
> updated version (with all the fixes squashed)?

Tejun, yes let me know how to move forward with this as it is highly
desired for Intel Xe team to get this into 6.12.

Matt

