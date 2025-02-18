Return-Path: <linux-kernel+bounces-518699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDD9A3936D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F381690B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D0F1AF0CB;
	Tue, 18 Feb 2025 06:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWHQ/sXn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A934C749C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 06:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739860245; cv=fail; b=D0XfHvYgIv7Lt8ucmyzP8asLS6e/tL+CALDxJ8XWpbTtdZTDHgqBZw2SoimOb4rlEBbcQNmdIdatY166DjzY+8dTB76GfZJ1h8+reYiOZK2FYyFIAlY+casNjo+1BaNZNyu7m/OG17hGH62wMBF1mrrZ4icwwDBIom/hfKKB1uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739860245; c=relaxed/simple;
	bh=K0c3h9uoka4L5gKGvFUQ5aLhjEU6TQL9Qqam08CQctA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QgvI0G0YzSpDr7o9qCCHaCLucAw71YOpYXQhjlDC0Hw5PeOv/XRfAa3FRWilgiZdetH1azQoSnKvz04HKaek/otib8hse8Ao4MKAkFtb4g+fPZv+JT6GUW6mrW/EgqNDb1H5iu7GEzKq0ETcWxM2aUsdNDOYm0rrsQtqYWfKF9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWHQ/sXn; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739860241; x=1771396241;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=K0c3h9uoka4L5gKGvFUQ5aLhjEU6TQL9Qqam08CQctA=;
  b=iWHQ/sXnvZFZiNu0ujH0HMbE4Ig6Pk/XlrrJfD913g2tzxfl526eYNAE
   L9q2T2CNrnzUZOP/7bcHm3F7BOQj/BCn/gZzvFHvTZ2oH0BGVtQNifQu+
   g7UfGSJwGT7YRnkeaHJtrL1TnXWrgKpU73H3vOmbp2vYxRtAM4YTgRZOV
   v71GDcnxP8bv9iHi2zjxwX6Lho3cCux9Q2O9TAExi7eqgbQLFudO8LAx/
   j1U44t/IbnyP6wUTw3Sz26pR1vZCHKAvOk9wWDkFdHAgT9fHWLv6Ennnk
   TjsqSBlmqvDtdp1XFk5HIsspy7rSQaKfo6xyKai3uuckQfph2ut8VamMl
   A==;
X-CSE-ConnectionGUID: Ug6mjv/4SJWyckJ/jFV3JQ==
X-CSE-MsgGUID: xEPqv3RQTEOMgadrlq31Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40722611"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40722611"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 22:30:40 -0800
X-CSE-ConnectionGUID: qlN/flSmQ0a8eVhPxxRDxA==
X-CSE-MsgGUID: iCEGyGOLRm6WCsNnw/uLrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="145213402"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2025 22:30:40 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 22:30:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Feb 2025 22:30:38 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 22:30:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=argeMgCtiZYNF8rJLm24NZ7A9ZYKkyJRzLA9WMKdm9vGsooYmtpTw4+1dxPk9x/3elI7TS+953w19RHl9r3nzsnWsF2JkOO6B4xT/NqMxRp2Ri4RdUKIJMX/cZDduYB4WX2N738tCJ2z8abr9IfL7AOgTXS1F+2G2MOhu/f3NlPOPxIQ4/4ZN7/yhqbZFjVYK1rlFFWERFnBA3RGwA+PJYdqqLGi79DXpgbgeb+LO3EyKlAtbKAx7/ABidDzhYtALCZzaXbz8einyRZbjgrMpZs2L5Sn4gMh9c7ZIc3WkEBv8YtL4MDqB38h0AHz1xL8iv0EmSExGGqFg18KEF9AXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8B5K0hy5X7wPRZp+XZvY2a82wd4G7tz6cAj9B79lT+s=;
 b=pVnPid4SA2COZ57GRLZgsnJ17Jo5ssyClrNs1p94qOaK8ASC+1TUY0KOicbMLLiEfPs7UJGuCUILbdam6kroTymDFYTUpM7BtyTUZ9LewStF0PyzaGPEu8718irjldNmXsuKYB5/8031zJA2szR1ZQxrJ67BoN/QNw8RxSJa53gtHjkx3LhY1rfNHE0019oKGWIb4xDT0hBeOYUEyfjRH3QE3pS2nDDROjX5n98EuTQN08ciZYqREzzLvBYRO7vlKEweXgpOWcKW2td5ZQCK8GIXNp0AdIEBPW5HakqlMq5hA9BW92k68GRrkm5nymo9s94J3hkCEp01QVuFYbQDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB8514.namprd11.prod.outlook.com (2603:10b6:a03:56b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 06:30:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 06:30:33 +0000
Date: Tue, 18 Feb 2025 14:30:22 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Yang Shi <yang@os.amperecomputing.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<arnd@arndb.de>, <gregkh@linuxfoundation.org>, <Liam.Howlett@oracle.com>,
	<lorenzo.stoakes@oracle.com>, <vbabka@suse.cz>, <jannh@google.com>,
	<willy@infradead.org>, <liushixin2@huawei.com>, <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH] /dev/zero: make private mapping full anonymous mapping
Message-ID: <Z7Qo/ijUeRcJM91j@xsang-OptiPlex-9020>
References: <202501281038.617c6b60-lkp@intel.com>
 <01b5c112-480f-40dd-892f-5eb7c53e2f68@os.amperecomputing.com>
 <Z6RshwXCWhAGoMOK@xsang-OptiPlex-9020>
 <eb5896c7-c269-42a8-8fa9-e5e7c23812c4@os.amperecomputing.com>
 <Z61TL9jivJ5U1Ek3@xsang-OptiPlex-9020>
 <6f110208-eca3-42fa-aa7b-7d93f61ef750@os.amperecomputing.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f110208-eca3-42fa-aa7b-7d93f61ef750@os.amperecomputing.com>
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 8714836a-1457-47e6-d5da-08dd4fe5bf62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXRmaStmV0FVYUhFeURiV3BERlN4QVZEODRQcFpOeXd0enpUS25TeTlVeUJJ?=
 =?utf-8?B?VlBSRnFFcE9OZEx4RDNCWmVxU2lGcmZCdlh2enJiTWhyT3pVdDZ2bWhqZ2Zr?=
 =?utf-8?B?OC9GVzVMUndVeWE0RTlqMnl6clh2aThCSys5WWpaQkcyVzFpMUZYck9mL1FS?=
 =?utf-8?B?SEJNMElpTVhEV0h2RG1QY3R6UndoekhGN2ZXTU9HeEhjTitjOHVEaXZ6U1I0?=
 =?utf-8?B?ZE16ZmFTVld4VTgwWDAxeFZJZUw1OVV0MUdVSDY0WGQrcEVSaHBWUlBuZWdn?=
 =?utf-8?B?V0VBemlQVk84ZlFvUFVjTHhIR2pKUXE3bm50dzZDd21vWWFreElNN01yMHZu?=
 =?utf-8?B?dEQzMXZzNmlBQUNybndXdUdHNW42VVYzNUxKcGtBbS93VkxIQ2ZlZmV6R0Y2?=
 =?utf-8?B?WjR6SWVPV0Z6bzVGb0VjSkxOUWQ1WDBBWHEyTiswY09jRFRKSVE1cEorZ2Ju?=
 =?utf-8?B?cWRodlJML3RzeUdSK1hoUThWaitSRThFQ0Z4ZXR2OXNGRlkwZnBqT3lHVjNH?=
 =?utf-8?B?MlpGTkJueFhNdzdFOW13eHVidnB3aWd5UktZSlJ1d3Iva3NoVUFjVlh1c0VS?=
 =?utf-8?B?b0hJNzZiOG5ybTh0c25aZ3JWNjBmUUlqME1nTkZmZU9QdTlRMUpLUUFOTmZM?=
 =?utf-8?B?bWNpdkF3R3h0bU94YWhOekxTdWhlSkExZXB3NGVMeXdSY0RFYVh3bU8wV0Zr?=
 =?utf-8?B?QWVhdHNJVHR6dy9mRjFmRUZFRlIyUi9FUzVFdHUraldhdGoyNkNLeCtBN1Ny?=
 =?utf-8?B?RFdLc3o1bWVqd00vdTFEWEplSVdzVDIxeXpDK2djUWUvVUw5QzRYREttdmNv?=
 =?utf-8?B?b0VYU25aMmhpeTRYL2NtdzYwb2FJdzhTUjVZYXl1NlZXdEJwdlozUURXM1Vx?=
 =?utf-8?B?d2tYeWNXY2xZUXZPTUJwWHErUDdJc2NzdzdJOWtiaGhYS29zQ3hTaVBWQkln?=
 =?utf-8?B?b2k1d0hJa3ZDUWZqaEhCZWpMUmxtQzIxYWlGNUttZ0N1blo1RExjNVljSXV0?=
 =?utf-8?B?d2NIYlVCUTd1bE9zeVo3S1lVUzRZRDNvTGN6T2FQRXV3ZWFnMldPZTRsY1Fp?=
 =?utf-8?B?NjY0TzFMWUNsck12RTVaNUZPYkZWVHBVbFpvajZQL00xTjdhTjJJOHpwRkVv?=
 =?utf-8?B?SCtabC9KVjg2dHJWR2I4TngwdnpEZzRkTC8rbVE2NTFkbExIQXVLZVBUYWR1?=
 =?utf-8?B?czZhS0h3bmxGQ2NLZ1hrdytDc09qU0RPL1RXV1AvUmtVajErZ1VCbFVkMExW?=
 =?utf-8?B?bFN3TTlhQkJTWDFPMk9NUWlGSm5mQWdRSit1QzVQQ3hzTnhlWWxQcEJib014?=
 =?utf-8?B?dWpxc1oyTFZSRzFTYjBQODJPUVZWcktBM2JkVVJmOUNtdjdNNlNRK3dCWjYr?=
 =?utf-8?B?dE1Na283UFJiR25LUVh5STdvZmdPQzNzNlhFR1F2MWpCbWFuZXA5MlFiTE1L?=
 =?utf-8?B?WVRPTURQWnovRHdjblhwVXIyZ2ZpcnUrSVltVGhiazQyZ0R2YTNuS1hJdzZy?=
 =?utf-8?B?dE8wWVNvYUpnNjVLR29nT001UFZnNkFrRUZoTFJ1Y0RaUWl5UU4yU0RhVDUr?=
 =?utf-8?B?YXdsWjdTY2tLU255NmpIbnJ5U3dvaDZzemJhUXlqak8rajFiQjNZM0NNVjJI?=
 =?utf-8?B?bmdYR3JuK1hBVkhVWGNtVm5FN1VhL2xoK0daUjFRRkJIOEVnYlJ3dGlkZGtx?=
 =?utf-8?B?WWRYQjY1eUpZcTU5bXF1ZjFPU3AyQ3pheEp0S096V1p1U2t6Rm5TYmFtQnIv?=
 =?utf-8?B?dTZuVm0xcGQzbndnSHMxMlJJL0MzRnc3NXd5QkYzejJOT0lpUnZncGw5ODQy?=
 =?utf-8?B?cmhFejVBNE81UHJ4L3QwZ3NBWlZMTlBWcGQ1VHFlYjVOZjQ1R3NQeC9rRDNs?=
 =?utf-8?Q?YGoovx+ATy7df?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rzg5NS85UzBQWWJRbks0K29keHJNU3VUS0VhN0JpNWtZK2VmYW5MNlZiU1Qw?=
 =?utf-8?B?Z1RVQUtUV3hCdElxbHBPY29BSXM5eTdVNEcwZWtGckE4NDgyYzVuaEEzV3lw?=
 =?utf-8?B?S0F4U0R0YWpLR2I5VDFhVnBYUS82N1VZeFVFaFlkdVEzaTU5dms0eHlGMnEv?=
 =?utf-8?B?STFleUw3WU80cEgzWlNGZXhpY1A2dGxoYm1sUUxtNEY3NlFwK3V6Tys5V1kr?=
 =?utf-8?B?azZrVHNpaWcwc2dzQXE3SkhMSkVwdEZySk1vRXI3NXl4NE1SREhEOFlURjZC?=
 =?utf-8?B?R1FDakc2VGY0SllPenpJWlVySFRPWnhrTWFvQ1NyYzVQR3YyZzlOdzRuTXVy?=
 =?utf-8?B?aG5mQjdmMHpXN2RObmVFVVFwTzRCSUltamp6U2JFaUs2d25sYmtwZXpSNmxC?=
 =?utf-8?B?NEdRKzgvc1QwTTU4N2U3aFhzL3dJTm1oemlHUm04TXRPNkhhQmpnS1lGVTdr?=
 =?utf-8?B?TDljR3hPVHdTdkZ5M2plNnIyYVhUaytOWmdJak1zb0VlSjN4Wm1MTkdtdFUz?=
 =?utf-8?B?bVl1Z0taZTVEQmhoUiszL1JGNko4N0NMVG4vbWh3N0pORW05YUJ5eU12cVdH?=
 =?utf-8?B?VDc3clJrTVZFb0tudTRFYlRiVjhkbmUzbldRR3VVa2FiUVA5d1RBOW12MmdD?=
 =?utf-8?B?NkkvVmVBeUh5V0V0NlVBSVZYWHVDNDJ5eTI5c0p3eTJHanNnclN2TjVPSHg5?=
 =?utf-8?B?eE13TGoxNkhLMWNpZkVRSzFCQ0o4SzhDcGNCeHdRdTcvd1NLVlFOWUN6bWRB?=
 =?utf-8?B?WDFOS0RVWWoyQ2ZBZHMvNWZZWjB5NDRwUUJCbnowZCtXWmtLdjZsTHByRm80?=
 =?utf-8?B?MGduakFOSnVNN3RpN0xaeGNMVUVaalVKRG5qbDFSZDBiNWsrOEtXYlNoUUpK?=
 =?utf-8?B?dXZvT011V1NpanJwRXIwSG0xaXhqbXd0NzlXQTFUVU92WkxHeXRlME5rVVBx?=
 =?utf-8?B?R2lnaHpGbmNGV1BWNFBBTUIzR28rODZOWWtIY2NETmMwUThFT3BZeml6em1G?=
 =?utf-8?B?aHlidG02U3ZmZUtVMFZSNGs0MzhFTTJGMk0vQWg3bnhOLytKWmJqSnJ5cWhF?=
 =?utf-8?B?eURleEI3bTJYLzBXbldIWS9rcTliQTNPSy8yRWVaWkZRbUJLWXdqeGFqRVJw?=
 =?utf-8?B?bEtTbkNTV0Q5KzI1QjZGQ2U2VytuWHdZWkppZnZtU1ZZRFZlNDRoNi9nMTJl?=
 =?utf-8?B?Q2pjc2YvSUJBL0krWVFwTkM1VXlFN2pjMHJRMG9pVVJ0NWl6eEt5U3J4M0FK?=
 =?utf-8?B?TlVKTEpkWWk3azl1U0k5dEJwb3A3aDlkQTNSV1pRa0RXYWR2cmtMU0VpUWtQ?=
 =?utf-8?B?b3UvRHJBTGEwUldKWlRpZysyRHJtL3VuQkhuYmhXc2EyNE13UndBY3JOTDEy?=
 =?utf-8?B?Y0RhdXpBL01mOGpuMjhhN3RQNU93dHpnS1h0c3NPd2VFZWRwM3ZHdUNYeE5P?=
 =?utf-8?B?QkM2Q1N6dXVxdmhpR2tJRVIxM2Q1TmtHUTNBVmMybkxYSUlWRDJPRnRBK2o4?=
 =?utf-8?B?VW56eENPZGFZUUtBeU5VRGdqMkEyd3BaNzFjMnI1QTV6SE93MTExSEhYT0Er?=
 =?utf-8?B?T3NLVTQvRkpYVXF3dnNUNm1GV0JYV0FNUDZSUU9PM0l4c3h6RjJzajE1bWhC?=
 =?utf-8?B?QmxvWDNPQjFGUCtjTHQ3YlE2WE1BcW5iOVNISklHOCtVYjRlV3dXb0tOaWpo?=
 =?utf-8?B?QWVOZjdjNHpsUmpwT2N1cFZ5VHRkV0YrMTJjZXBvekZrSHpmV0YvRlIwNG01?=
 =?utf-8?B?THFlVlp2Z2JIck01aSs1NzliaDl1Q2t0YzRnazFsN3Z1N2VQQTJuUHBDR3lI?=
 =?utf-8?B?dENsL3VVRkRPTEZ0Ym80UmR3RVAxbzlocW5PVWNvQk1URURjVTQxWGtoaUp3?=
 =?utf-8?B?bzY2SW1wVno4eXhJSEhCc2NpenFFdUQzaEtGSjhOcnlXSlMzQWcyVlVKL1Zy?=
 =?utf-8?B?Z1FvMjZRNjBFbWlCZ05VT1ZnN2tjWU16Tyt6U2M2RnRYVG9lcTB6RllyODIv?=
 =?utf-8?B?RTU4TjAyc2VLZjdVbmhQMzRxVy85dWx5MW9PUDk2cjQzVnV0Q3ZadjRTRmNv?=
 =?utf-8?B?b1VxWHh1NU9LcVZkUGFTQnJuYzdZTGc3T3pFK3ovdFRNRWFvd0c0L1REamZK?=
 =?utf-8?B?NjhtN2hwWDlUTzlUcFZUUWxFZXhBTngxRHNWQlB4cE93R3VnR1lrWWJ0MnA5?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8714836a-1457-47e6-d5da-08dd4fe5bf62
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 06:30:33.9041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abCb4xCGT7VtKVWvSmA3G5M5FkvGZgcFe88fjM18brPr2cfHyOo24R/E1c69o7IRa29UXygmDDyElHtWHD1Kwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8514
X-OriginatorOrg: intel.com

hi, Yang Shi,

On Fri, Feb 14, 2025 at 02:53:37PM -0800, Yang Shi wrote:
> 
> On 2/12/25 6:04 PM, Oliver Sang wrote:
> > hi, Yang Shi,
> > 
> > On Fri, Feb 07, 2025 at 10:10:37AM -0800, Yang Shi wrote:
> > > On 2/6/25 12:02 AM, Oliver Sang wrote:
> > [...]
> > 
> > > > since we applied your "/dev/zero: make private mapping full anonymous mapping"
> > > > patch upon a68d3cbfad like below:
> > > > 
> > > > * 7143ee2391f1e /dev/zero: make private mapping full anonymous mapping
> > > > * a68d3cbfade64 memstick: core: fix kernel-doc notation
> > > > 
> > > > so I applied below patch also upon a68d3cbfad.
> > > > 
> > > > we saw big improvement but not that big.
> > > > 
> > > > =========================================================================================
> > > > compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase:
> > > >     gcc-12/performance/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/300s/lkp-cpl-4sp2/small-allocs/vm-scalability
> > > > 
> > > > commit:
> > > >     a68d3cbfad ("memstick: core: fix kernel-doc notation")
> > > >     52ec85cb99  <--- your patch
> > > > 
> > > > 
> > > > a68d3cbfade64392 52ec85cb99e9b31dc304eae965a
> > > > ---------------- ---------------------------
> > > >            %stddev     %change         %stddev
> > > >                \          |                \
> > > >     14364828 ±  4%    +410.6%   73349239 ±  3%  vm-scalability.throughput
> > > > 
> > > > full comparison as below [1] just FYI.
> > > Thanks for the update. I stared at the profiling report for a whole day, but
> > > I didn't figure out where that 400% lost. I just saw the number of page
> > > faults was fewer. And it seems like the reduction of page faults match the
> > > 400% loss. So I did more trace and profiling.
> > > 
> > > The test case did the below stuff in a tight loop:
> > >    mmap 40K memory from /dev/zero (read only)
> > >    read the area
> > > 
> > > So two major factors to the performance: mmap and page fault. The
> > > alternative patch did reduce the overhead of mmap to the same level as the
> > > original patch.
> > > 
> > > The further perf profiling showed the cost of page fault is higher than the
> > > original patch. But the profiling of page fault was interesting:
> > > 
> > > -   44.87%     0.01%  usemem [kernel.kallsyms]                   [k]
> > > do_translation_fault
> > >     - 44.86% do_translation_fault
> > >        - 44.83% do_page_fault
> > >           - 44.53% handle_mm_fault
> > >                9.04% __handle_mm_fault
> > > 
> > > Page fault consumed 40% of cpu time in handle_mm_fault, but
> > > __handle_mm_fault just consumed 9%, I expected it should be the major
> > > consumer.
> > > 
> > > So I annotated handle_mm_fault, then found the most time was consumed by
> > > lru_gen_enter_fault() -> vma_has_recency() (my kernel has multi-gen LRU
> > > enabled):
> > > 
> > >        │     if (vma->vm_file && (vma->vm_file->f_mode & FMODE_NOREUSE))
> > >         │     ↓ cbz     x1, b4
> > >    0.00 │       ldr     w0, [x1, #12]
> > >   99.59 │       eor     x0, x0, #0x800000
> > >    0.00 │       ubfx    w0, w0, #23, #1
> > >         │     current->in_lru_fault = vma_has_recency(vma);
> > >    0.00 │ b4:   ldrh    w1, [x2, #1992]
> > >    0.01 │       bfi     w1, w0, #5, #1
> > >    0.00 │       strh    w1, [x2, #1992]
> > > 
> > > 
> > > vma_has_recency() read vma->vm_file->f_mode if vma->vm_file is not NULL. But
> > > that load took a long time. So I inspected struct file and saw:
> > > 
> > > struct file {
> > >      file_ref_t            f_ref;
> > >      spinlock_t            f_lock;
> > >      fmode_t                f_mode;
> > >      const struct file_operations    *f_op;
> > >      ...
> > > }
> > > 
> > > The f_mode is in the same cache line with f_ref (my kernel does NOT have
> > > spin lock debug enabled). The test case mmap /dev/zero in a tight loop, so
> > > the refcount is modified (fget/fput) very frequently, this resulted in
> > > somehow false sharing.
> > > 
> > > So I tried the below patch on top of the alternative patch:
> > > 
> > > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > > index f9157a0c42a5..ba11dc0b1c7c 100644
> > > --- a/include/linux/mm_inline.h
> > > +++ b/include/linux/mm_inline.h
> > > @@ -608,6 +608,9 @@ static inline bool vma_has_recency(struct vm_area_struct
> > > *vma)
> > >          if (vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))
> > >                  return false;
> > > 
> > > +       if (vma_is_anonymous(vma))
> > > +               return true;
> > > +
> > >          if (vma->vm_file && (vma->vm_file->f_mode & FMODE_NOREUSE))
> > >                  return false;
> > > 
> > > This made the profiling of page fault look normal:
> > > 
> > >                          - 1.90% do_translation_fault
> > >                             - 1.87% do_page_fault
> > >                                - 1.49% handle_mm_fault
> > >                                   - 1.36% __handle_mm_fault
> > > 
> > > Please try this in your test.
> > > 
> > > But AFAICT I have never seen performance issue reported due to the false
> > > sharing of refcount and other fields in struct file. This benchmark stressed
> > > this quite badly.
> > I applied your above patch upon alternative patch last time, then saw more
> > improvement (+445.2% vs a68d3cbfad), but still not that big as in our original
> > report.
> 
> Thanks for the update. It looks like the problem is still in page faults. I
> did my test on arm64 machine. I also noticed struct file has
> "__randomize_layout", so it may have different layout on x86 than arm64?
> 
> The page fault handler may also access other fields of struct file that may
> cause false sharing, for example, accessing f_mapping to read gfp flags.
> This may not be a problem on my machine, but may be more costly on yours
> depending on the real layout of struct file on the machines,
> 
> Can you please try the below patch on top of the current patches? Thank you
> so much for your patience.

you are welcome!

now has more improvements. I just list "a68d3cbfad + 3 patches so far" vs
a68d3cbfad below, if you want more data, please let me know.

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/300s/lkp-cpl-4sp2/small-allocs/vm-scalability

commit:
  a68d3cbfad ("memstick: core: fix kernel-doc notation")
  edc84ea79f  <--- a68d3cbfad + 3 patches so far
  
a68d3cbfade64392 edc84ea79f8dc11853076b96ad5
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
  14364828 ±  4%    +685.6%  1.129e+08 ±  5%  vm-scalability.throughput

full data is as below [1] FYI.

> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 539c0f7c6d54..1fa9dbce0f66 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3214,6 +3214,9 @@ static gfp_t __get_fault_gfp_mask(struct
> vm_area_struct *vma)
>  {
>         struct file *vm_file = vma->vm_file;
> 
> +       if (vma_is_anonymous(vma))
> +               return GFP_KERNEL;
> +
>         if (vm_file)
>                 return mapping_gfp_mask(vm_file->f_mapping) | __GFP_FS |
> __GFP_IO;
> 

[1]
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/300s/lkp-cpl-4sp2/small-allocs/vm-scalability

commit:
  a68d3cbfad ("memstick: core: fix kernel-doc notation")
  edc84ea79f  <--- a68d3cbfad + 3 patches so far
  
a68d3cbfade64392 edc84ea79f8dc11853076b96ad5
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
 5.262e+09 ±  3%     -59.8%  2.114e+09 ±  2%  cpuidle..time
   7924008 ±  3%     -83.9%    1275131 ±  5%  cpuidle..usage
   1871164 ±  4%     -16.8%    1557233 ±  8%  numa-numastat.node3.local_node
   1952164 ±  3%     -14.8%    1663189 ±  7%  numa-numastat.node3.numa_hit
    399.52           -75.0%      99.77 ±  2%  uptime.boot
     14507           -22.1%      11296        uptime.idle
      3408 ±  5%     -99.8%       7.25 ± 46%  perf-c2c.DRAM.local
     18076 ±  3%     -99.8%      43.00 ±100%  perf-c2c.DRAM.remote
      8082 ±  5%     -99.8%      12.50 ± 63%  perf-c2c.HITM.local
      6544 ±  6%     -99.7%      22.88 ±151%  perf-c2c.HITM.remote
     14627 ±  4%     -99.8%      35.38 ±114%  perf-c2c.HITM.total
      6.99 ±  3%    +177.6%      19.41 ±  3%  vmstat.cpu.id
     91.35           -28.5%      65.31        vmstat.cpu.sy
      1.71          +793.1%      15.25 ±  4%  vmstat.cpu.us
     34204 ±  5%     -64.1%      12271 ±  9%  vmstat.system.cs
    266575           -21.2%     210049        vmstat.system.in
      6.49 ±  3%     +10.0       16.46 ±  3%  mpstat.cpu.all.idle%
      0.63            -0.3        0.34 ±  3%  mpstat.cpu.all.irq%
      0.03 ±  2%      +0.3        0.31 ±  4%  mpstat.cpu.all.soft%
     91.17           -24.1       67.09        mpstat.cpu.all.sys%
      1.68 ±  2%     +14.1       15.80 ±  4%  mpstat.cpu.all.usr%
    337.33           -98.7%       4.25 ± 10%  mpstat.max_utilization.seconds
    352.76           -84.7%      53.95 ±  4%  time.elapsed_time
    352.76           -84.7%      53.95 ±  4%  time.elapsed_time.max
    225965 ±  7%     -17.1%     187329 ± 12%  time.involuntary_context_switches
 9.592e+08 ±  4%     +11.9%  1.074e+09        time.minor_page_faults
     20852           -10.0%      18761        time.percent_of_cpu_this_job_got
     72302           -88.6%       8227 ±  6%  time.system_time
      1260 ±  3%     +50.7%       1899        time.user_time
   5393707 ±  5%     -98.8%      66895 ± 21%  time.voluntary_context_switches
   1609925           -50.7%     793216        meminfo.Active
   1609925           -50.7%     793216        meminfo.Active(anon)
    160837 ± 33%     -72.5%      44155 ±  9%  meminfo.AnonHugePages
   4435665           -18.7%    3608195        meminfo.Cached
   1775547           -44.2%     990889        meminfo.Committed_AS
    148539           -47.4%      78096        meminfo.Mapped
   4245538 ±  4%     -24.6%    3202495        meminfo.PageTables
    929777           -88.9%     102759        meminfo.Shmem
  25676018 ±  3%     +14.3%   29335678        meminfo.max_used_kB
     64129 ±  4%    +706.8%     517389 ±  7%  vm-scalability.median
     45.40 ±  5%   +2248.9        2294 ±  2%  vm-scalability.stddev%
  14364828 ±  4%    +685.6%  1.129e+08 ±  5%  vm-scalability.throughput
    352.76           -84.7%      53.95 ±  4%  vm-scalability.time.elapsed_time
    352.76           -84.7%      53.95 ±  4%  vm-scalability.time.elapsed_time.max
    225965 ±  7%     -17.1%     187329 ± 12%  vm-scalability.time.involuntary_context_switches
 9.592e+08 ±  4%     +11.9%  1.074e+09        vm-scalability.time.minor_page_faults
     20852           -10.0%      18761        vm-scalability.time.percent_of_cpu_this_job_got
     72302           -88.6%       8227 ±  6%  vm-scalability.time.system_time
      1260 ±  3%     +50.7%       1899        vm-scalability.time.user_time
   5393707 ±  5%     -98.8%      66895 ± 21%  vm-scalability.time.voluntary_context_switches
 4.316e+09 ±  4%     +11.9%  4.832e+09        vm-scalability.workload
   1063552 ±  4%     -24.9%     799008 ±  3%  numa-meminfo.node0.PageTables
    125455 ±106%     -85.5%      18164 ±165%  numa-meminfo.node0.Shmem
   1062709 ±  4%     -25.7%     789746 ±  4%  numa-meminfo.node1.PageTables
    176171 ± 71%     -92.4%      13303 ±230%  numa-meminfo.node1.Shmem
     35515 ± 91%     -97.3%     976.55 ± 59%  numa-meminfo.node2.Mapped
   1058901 ±  4%     -25.3%     791392 ±  4%  numa-meminfo.node2.PageTables
    770405 ± 30%     -79.2%     160245 ±101%  numa-meminfo.node3.Active
    770405 ± 30%     -79.2%     160245 ±101%  numa-meminfo.node3.Active(anon)
    380096 ± 50%     -62.5%     142513 ± 98%  numa-meminfo.node3.AnonPages.max
   1146977 ±108%     -92.8%      82894 ± 60%  numa-meminfo.node3.FilePages
     52663 ± 47%     -97.2%       1488 ± 39%  numa-meminfo.node3.Mapped
   1058539 ±  4%     -22.3%     821992 ±  3%  numa-meminfo.node3.PageTables
    558943 ± 14%     -93.7%      35227 ±124%  numa-meminfo.node3.Shmem
    265763 ±  4%     -24.9%     199601 ±  3%  numa-vmstat.node0.nr_page_table_pages
     31364 ±106%     -85.5%       4539 ±165%  numa-vmstat.node0.nr_shmem
    265546 ±  4%     -25.5%     197854 ±  5%  numa-vmstat.node1.nr_page_table_pages
     44052 ± 71%     -92.5%       3323 ±230%  numa-vmstat.node1.nr_shmem
      8961 ± 91%     -97.3%     244.02 ± 59%  numa-vmstat.node2.nr_mapped
    264589 ±  4%     -25.2%     197920 ±  3%  numa-vmstat.node2.nr_page_table_pages
    192683 ± 30%     -79.2%      40126 ±101%  numa-vmstat.node3.nr_active_anon
    286819 ±108%     -92.8%      20761 ± 60%  numa-vmstat.node3.nr_file_pages
     13124 ± 49%     -97.2%     372.02 ± 39%  numa-vmstat.node3.nr_mapped
    264499 ±  4%     -22.4%     205376 ±  3%  numa-vmstat.node3.nr_page_table_pages
    139810 ± 14%     -93.7%       8844 ±124%  numa-vmstat.node3.nr_shmem
    192683 ± 30%     -79.2%      40126 ±101%  numa-vmstat.node3.nr_zone_active_anon
   1951359 ±  3%     -14.9%    1661427 ±  7%  numa-vmstat.node3.numa_hit
   1870359 ±  4%     -16.8%    1555470 ±  8%  numa-vmstat.node3.numa_local
    402515           -50.7%     198246        proc-vmstat.nr_active_anon
    170568            +1.8%     173591        proc-vmstat.nr_anon_pages
   1109246           -18.7%     902238        proc-vmstat.nr_file_pages
     37525           -47.3%      19768        proc-vmstat.nr_mapped
   1059932 ±  4%     -24.2%     803105 ±  2%  proc-vmstat.nr_page_table_pages
    232507           -89.0%      25623        proc-vmstat.nr_shmem
     37297            -5.4%      35299        proc-vmstat.nr_slab_reclaimable
    402515           -50.7%     198246        proc-vmstat.nr_zone_active_anon
     61931 ±  8%     -83.9%       9948 ± 59%  proc-vmstat.numa_hint_faults
     15755 ± 21%     -96.6%     541.38 ± 36%  proc-vmstat.numa_hint_faults_local
   6916516 ±  3%      -8.0%    6360040        proc-vmstat.numa_hit
   6568542 ±  3%      -8.5%    6012265        proc-vmstat.numa_local
    293942 ±  3%     -68.8%      91724 ± 48%  proc-vmstat.numa_pte_updates
 9.608e+08 ±  4%     +11.8%  1.074e+09        proc-vmstat.pgfault
     55981 ±  2%     -68.7%      17541 ±  2%  proc-vmstat.pgreuse
      0.82 ±  4%     -51.0%       0.40 ±  8%  perf-stat.i.MPKI
 2.714e+10 ±  2%    +378.3%  1.298e+11 ±  9%  perf-stat.i.branch-instructions
      0.11 ±  3%      +0.1        0.24 ±  8%  perf-stat.i.branch-miss-rate%
  24932893          +306.8%  1.014e+08 ±  9%  perf-stat.i.branch-misses
     64.93            -7.5       57.48        perf-stat.i.cache-miss-rate%
  88563288 ±  3%     +35.0%  1.196e+08 ±  7%  perf-stat.i.cache-misses
 1.369e+08 ±  3%     +43.7%  1.968e+08 ±  7%  perf-stat.i.cache-references
     34508 ±  4%     -47.3%      18199 ±  9%  perf-stat.i.context-switches
      7.67           -75.7%       1.87 ±  3%  perf-stat.i.cpi
    224605           +22.5%     275084 ±  6%  perf-stat.i.cpu-clock
    696.35 ±  2%     -53.5%     323.77 ±  2%  perf-stat.i.cpu-migrations
     10834 ±  4%     -24.1%       8224 ± 11%  perf-stat.i.cycles-between-cache-misses
 1.102e+11          +282.2%  4.212e+11 ±  9%  perf-stat.i.instructions
      0.14          +334.6%       0.62 ±  5%  perf-stat.i.ipc
     24.25 ±  3%    +626.9%     176.25 ±  4%  perf-stat.i.metric.K/sec
   2722043 ±  3%    +803.8%   24600740 ±  9%  perf-stat.i.minor-faults
   2722043 ±  3%    +803.8%   24600739 ±  9%  perf-stat.i.page-faults
    224605           +22.5%     275084 ±  6%  perf-stat.i.task-clock
      0.81 ±  3%     -62.2%       0.31 ± 11%  perf-stat.overall.MPKI
      0.09            -0.0        0.08 ±  2%  perf-stat.overall.branch-miss-rate%
     64.81            -2.4       62.37        perf-stat.overall.cache-miss-rate%
      7.24           -70.7%       2.12 ±  5%  perf-stat.overall.cpi
      8933 ±  4%     -21.9%       6978 ±  7%  perf-stat.overall.cycles-between-cache-misses
      0.14          +242.2%       0.47 ±  5%  perf-stat.overall.ipc
      9012 ±  2%     -57.8%       3806        perf-stat.overall.path-length
 2.701e+10 ±  2%    +285.4%  1.041e+11 ±  5%  perf-stat.ps.branch-instructions
  24708939          +215.8%   78042343 ±  4%  perf-stat.ps.branch-misses
  89032538 ±  3%     +15.9%  1.032e+08 ±  8%  perf-stat.ps.cache-misses
 1.374e+08 ±  3%     +20.6%  1.656e+08 ±  9%  perf-stat.ps.cache-references
     34266 ±  5%     -66.2%      11570 ± 10%  perf-stat.ps.context-switches
    223334            -1.6%     219861        perf-stat.ps.cpu-clock
 7.941e+11            -9.9%  7.157e+11        perf-stat.ps.cpu-cycles
    693.54 ±  2%     -67.2%     227.38 ±  4%  perf-stat.ps.cpu-migrations
 1.097e+11          +208.3%  3.381e+11 ±  5%  perf-stat.ps.instructions
   2710577 ±  3%    +626.7%   19698901 ±  5%  perf-stat.ps.minor-faults
   2710577 ±  3%    +626.7%   19698902 ±  5%  perf-stat.ps.page-faults
    223334            -1.6%     219861        perf-stat.ps.task-clock
 3.886e+13 ±  2%     -52.7%  1.839e+13        perf-stat.total.instructions
  64052898 ±  5%     -99.9%      81213 ± 23%  sched_debug.cfs_rq:/.avg_vruntime.avg
  95701822 ±  7%     -96.4%    3425672 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.max
  43098762 ±  6%    -100.0%     153.42 ± 36%  sched_debug.cfs_rq:/.avg_vruntime.min
   9223270 ±  9%     -95.9%     380347 ± 16%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.00 ± 22%    -100.0%       0.00        sched_debug.cfs_rq:/.h_nr_delayed.avg
      0.69 ±  8%    -100.0%       0.00        sched_debug.cfs_rq:/.h_nr_delayed.max
      0.05 ± 12%    -100.0%       0.00        sched_debug.cfs_rq:/.h_nr_delayed.stddev
      0.78 ±  2%     -94.5%       0.04 ± 21%  sched_debug.cfs_rq:/.h_nr_running.avg
      1.97 ±  5%     -49.3%       1.00        sched_debug.cfs_rq:/.h_nr_running.max
      0.28 ±  7%     -29.1%       0.20 ± 10%  sched_debug.cfs_rq:/.h_nr_running.stddev
    411536 ± 58%    -100.0%       1.15 ±182%  sched_debug.cfs_rq:/.left_deadline.avg
  43049468 ± 22%    -100.0%     258.27 ±182%  sched_debug.cfs_rq:/.left_deadline.max
   3836405 ± 37%    -100.0%      17.22 ±182%  sched_debug.cfs_rq:/.left_deadline.stddev
    411536 ± 58%    -100.0%       1.06 ±191%  sched_debug.cfs_rq:/.left_vruntime.avg
  43049467 ± 22%    -100.0%     236.56 ±191%  sched_debug.cfs_rq:/.left_vruntime.max
   3836405 ± 37%    -100.0%      15.77 ±191%  sched_debug.cfs_rq:/.left_vruntime.stddev
  64052901 ±  5%     -99.9%      81213 ± 23%  sched_debug.cfs_rq:/.min_vruntime.avg
  95701822 ±  7%     -96.4%    3425672 ±  7%  sched_debug.cfs_rq:/.min_vruntime.max
  43098762 ±  6%    -100.0%     153.42 ± 36%  sched_debug.cfs_rq:/.min_vruntime.min
   9223270 ±  9%     -95.9%     380347 ± 16%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.77 ±  2%     -94.4%       0.04 ± 21%  sched_debug.cfs_rq:/.nr_running.avg
      1.50 ±  9%     -33.3%       1.00        sched_debug.cfs_rq:/.nr_running.max
      0.26 ± 10%     -22.7%       0.20 ± 10%  sched_debug.cfs_rq:/.nr_running.stddev
      1.61 ± 24%    +413.4%       8.24 ± 60%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     86.69          +508.6%     527.62 ±  4%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     11.14 ± 13%    +428.4%      58.87 ± 32%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      1.61 ± 24%    +413.3%       8.24 ± 60%  sched_debug.cfs_rq:/.removed.util_avg.avg
     86.69          +508.6%     527.62 ±  4%  sched_debug.cfs_rq:/.removed.util_avg.max
     11.14 ± 13%    +428.4%      58.87 ± 32%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    411536 ± 58%    -100.0%       1.06 ±191%  sched_debug.cfs_rq:/.right_vruntime.avg
  43049467 ± 22%    -100.0%     236.56 ±191%  sched_debug.cfs_rq:/.right_vruntime.max
   3836405 ± 37%    -100.0%      15.77 ±191%  sched_debug.cfs_rq:/.right_vruntime.stddev
    769.03           -84.7%     117.79 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
      1621 ±  5%     -32.7%       1092 ± 16%  sched_debug.cfs_rq:/.util_avg.max
    159.12 ±  8%     +33.2%     211.88 ±  7%  sched_debug.cfs_rq:/.util_avg.stddev
    724.17 ±  2%     -98.6%      10.41 ± 32%  sched_debug.cfs_rq:/.util_est.avg
      1360 ± 15%     -51.5%     659.38 ± 10%  sched_debug.cfs_rq:/.util_est.max
    234.34 ±  9%     -68.2%      74.43 ± 18%  sched_debug.cfs_rq:/.util_est.stddev
    766944 ±  3%     +18.9%     912012        sched_debug.cpu.avg_idle.avg
   1067639 ±  5%     +25.5%    1339736 ±  9%  sched_debug.cpu.avg_idle.max
      3799 ±  7%     -38.3%       2346 ± 23%  sched_debug.cpu.avg_idle.min
    321459 ±  2%     -36.6%     203909 ±  7%  sched_debug.cpu.avg_idle.stddev
    195573           -76.9%      45144        sched_debug.cpu.clock.avg
    195596           -76.9%      45160        sched_debug.cpu.clock.max
    195548           -76.9%      45123        sched_debug.cpu.clock.min
     13.79 ±  3%     -36.0%       8.83 ±  2%  sched_debug.cpu.clock.stddev
    194424           -76.8%      45019        sched_debug.cpu.clock_task.avg
    194608           -76.8%      45145        sched_debug.cpu.clock_task.max
    181834           -82.1%      32559        sched_debug.cpu.clock_task.min
      4241 ±  2%     -96.8%     136.38 ± 21%  sched_debug.cpu.curr->pid.avg
      9799 ±  2%     -59.8%       3934        sched_debug.cpu.curr->pid.max
      1365 ± 10%     -49.1%     695.11 ± 10%  sched_debug.cpu.curr->pid.stddev
    537665 ±  4%     +28.3%     690006 ±  6%  sched_debug.cpu.max_idle_balance_cost.max
      3119 ± 56%    +479.5%      18078 ± 29%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ± 12%     -68.3%       0.00 ± 17%  sched_debug.cpu.next_balance.stddev
      0.78 ±  2%     -95.3%       0.04 ± 20%  sched_debug.cpu.nr_running.avg
      2.17 ±  8%     -53.8%       1.00        sched_debug.cpu.nr_running.max
      0.29 ±  8%     -35.4%       0.19 ±  9%  sched_debug.cpu.nr_running.stddev
     25773 ±  5%     -97.0%     764.82 ±  3%  sched_debug.cpu.nr_switches.avg
     48669 ± 10%     -77.2%      11080 ± 12%  sched_debug.cpu.nr_switches.max
     19006 ±  7%     -99.2%     151.12 ± 15%  sched_debug.cpu.nr_switches.min
      4142 ±  8%     -69.5%       1264 ±  6%  sched_debug.cpu.nr_switches.stddev
      0.07 ± 23%     -93.3%       0.01 ± 53%  sched_debug.cpu.nr_uninterruptible.avg
    240.19 ± 16%     -80.2%      47.50 ± 44%  sched_debug.cpu.nr_uninterruptible.max
    -77.92           -88.1%      -9.25        sched_debug.cpu.nr_uninterruptible.min
     37.87 ±  5%     -84.7%       5.78 ± 13%  sched_debug.cpu.nr_uninterruptible.stddev
    195549           -76.9%      45130        sched_debug.cpu_clk
    194699           -77.3%      44280        sched_debug.ktime
      0.00          -100.0%       0.00        sched_debug.rt_rq:.rt_nr_running.avg
      0.17          -100.0%       0.00        sched_debug.rt_rq:.rt_nr_running.max
      0.01          -100.0%       0.00        sched_debug.rt_rq:.rt_nr_running.stddev
    196368           -76.6%      45975        sched_debug.sched_clk
     95.59           -95.6        0.00        perf-profile.calltrace.cycles-pp.__mmap
     95.54           -95.5        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     95.54           -95.5        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
     94.54           -94.5        0.00        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     94.46           -94.4        0.07 ±264%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     94.45           -94.0        0.41 ±158%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     94.14           -93.9        0.29 ±134%  perf-profile.calltrace.cycles-pp.__mmap_new_vma.__mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
     94.25           -93.8        0.41 ±158%  perf-profile.calltrace.cycles-pp.__mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
     93.79           -93.7        0.07 ±264%  perf-profile.calltrace.cycles-pp.vma_link_file.__mmap_new_vma.__mmap_region.do_mmap.vm_mmap_pgoff
     93.44           -93.4        0.00        perf-profile.calltrace.cycles-pp.down_write.vma_link_file.__mmap_new_vma.__mmap_region.do_mmap
     93.40           -93.4        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_link_file.__mmap_new_vma.__mmap_region
     93.33           -93.3        0.00        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_link_file.__mmap_new_vma
     92.89           -92.9        0.00        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_link_file
      0.00            +1.7        1.69 ± 65%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.00            +1.9        1.90 ± 55%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      0.00            +1.9        1.90 ± 55%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.00            +1.9        1.93 ± 53%  perf-profile.calltrace.cycles-pp.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.9        1.93 ± 53%  perf-profile.calltrace.cycles-pp.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64
      0.00            +2.0        1.99 ± 53%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.0        2.02 ± 64%  perf-profile.calltrace.cycles-pp.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +2.3        2.27 ± 56%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      0.00            +2.3        2.27 ± 56%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      0.00            +2.3        2.27 ± 56%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
      0.00            +2.3        2.27 ± 56%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      0.00            +2.4        2.45 ± 53%  perf-profile.calltrace.cycles-pp._Fork
      0.00            +2.5        2.51 ± 52%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.5        2.51 ± 52%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64
      0.00            +2.5        2.51 ± 52%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.5        2.51 ± 52%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +3.2        3.17 ± 42%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +3.3        3.28 ± 52%  perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin
      0.00            +3.3        3.28 ± 52%  perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin.handle_internal_command
      0.00            +4.1        4.10 ± 45%  perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.run_builtin.handle_internal_command.main
      0.00            +4.1        4.10 ± 45%  perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.handle_internal_command.main
      0.00            +4.8        4.80 ± 61%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter
      0.00            +5.0        4.98 ± 69%  perf-profile.calltrace.cycles-pp.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64
      0.00            +5.1        5.07 ± 71%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.writen.record__pushfn
      0.00            +5.1        5.07 ± 71%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write.writen.record__pushfn.perf_mmap__push
      0.00            +5.1        5.07 ± 71%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.writen
      0.00            +5.1        5.07 ± 71%  perf-profile.calltrace.cycles-pp.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +5.1        5.07 ± 71%  perf-profile.calltrace.cycles-pp.write.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist
      0.00            +5.1        5.07 ± 71%  perf-profile.calltrace.cycles-pp.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      0.00            +5.1        5.11 ± 47%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      0.00            +5.1        5.12 ± 70%  perf-profile.calltrace.cycles-pp.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
      0.00            +6.1        6.08 ± 50%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.00            +7.8        7.84 ± 21%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +7.9        7.88 ± 20%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +7.9        7.88 ± 20%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      0.00            +7.9        7.88 ± 20%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +7.9        7.88 ± 20%  perf-profile.calltrace.cycles-pp.read
      0.00           +11.1       11.10 ± 41%  perf-profile.calltrace.cycles-pp.handle_internal_command.main
      0.00           +11.1       11.10 ± 41%  perf-profile.calltrace.cycles-pp.main
      0.00           +11.1       11.10 ± 41%  perf-profile.calltrace.cycles-pp.run_builtin.handle_internal_command.main
      0.00           +11.2       11.18 ± 73%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00           +15.9       15.94 ± 41%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +15.9       15.94 ± 41%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00           +19.5       19.54 ± 41%  perf-profile.calltrace.cycles-pp.asm_sysvec_reschedule_ipi.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state
      1.21 ±  3%     +36.7       37.86 ±  7%  perf-profile.calltrace.cycles-pp.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.21 ±  3%     +36.7       37.86 ±  7%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.21 ±  3%     +37.0       38.24 ±  7%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.21 ±  3%     +37.2       38.41 ±  7%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.21 ±  3%     +37.4       38.57 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.22 ±  3%     +38.5       39.67 ±  7%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      1.22 ±  3%     +38.5       39.67 ±  7%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.22 ±  3%     +38.5       39.67 ±  7%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      1.22 ±  3%     +38.9       40.09 ±  6%  perf-profile.calltrace.cycles-pp.common_startup_64
      2.19 ±  3%     +45.2       47.41 ± 14%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state
     95.60           -95.4        0.22 ±135%  perf-profile.children.cycles-pp.__mmap
     94.55           -93.9        0.60 ±103%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
     94.14           -93.7        0.44 ±112%  perf-profile.children.cycles-pp.__mmap_new_vma
     93.79           -93.7        0.10 ±264%  perf-profile.children.cycles-pp.vma_link_file
     94.46           -93.5        0.96 ± 76%  perf-profile.children.cycles-pp.vm_mmap_pgoff
     94.45           -93.5        0.96 ± 76%  perf-profile.children.cycles-pp.do_mmap
     94.25           -93.4        0.86 ± 87%  perf-profile.children.cycles-pp.__mmap_region
     93.40           -93.4        0.00        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     93.33           -93.3        0.00        perf-profile.children.cycles-pp.rwsem_optimistic_spin
     93.44           -93.2        0.22 ±149%  perf-profile.children.cycles-pp.down_write
     92.91           -92.9        0.00        perf-profile.children.cycles-pp.osq_lock
     95.58           -45.4       50.16 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     95.58           -45.4       50.16 ±  8%  perf-profile.children.cycles-pp.do_syscall_64
      0.00            +1.1        1.12 ± 74%  perf-profile.children.cycles-pp.filemap_map_pages
      0.00            +1.1        1.12 ± 76%  perf-profile.children.cycles-pp.vfs_fstatat
      0.00            +1.2        1.19 ± 35%  perf-profile.children.cycles-pp.vsnprintf
      0.00            +1.2        1.20 ± 46%  perf-profile.children.cycles-pp.seq_printf
      0.00            +1.3        1.28 ± 78%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.00            +1.5        1.54 ± 75%  perf-profile.children.cycles-pp.folios_put_refs
      0.00            +1.6        1.56 ± 52%  perf-profile.children.cycles-pp.__cond_resched
      0.00            +1.6        1.60 ± 32%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.00            +1.7        1.69 ± 65%  perf-profile.children.cycles-pp.dup_mm
      0.00            +1.9        1.93 ± 53%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.00            +2.0        1.99 ± 53%  perf-profile.children.cycles-pp.copy_process
      0.00            +2.1        2.06 ± 51%  perf-profile.children.cycles-pp.__x64_sys_ioctl
      0.00            +2.1        2.08 ± 45%  perf-profile.children.cycles-pp.proc_single_show
      0.00            +2.1        2.14 ± 45%  perf-profile.children.cycles-pp.seq_read
      0.00            +2.2        2.16 ± 47%  perf-profile.children.cycles-pp.ioctl
      0.00            +2.2        2.17 ± 33%  perf-profile.children.cycles-pp.schedule
      0.00            +2.2        2.20 ± 28%  perf-profile.children.cycles-pp.__pick_next_task
      0.00            +2.2        2.21 ± 47%  perf-profile.children.cycles-pp.perf_evsel__run_ioctl
      0.00            +2.3        2.26 ± 58%  perf-profile.children.cycles-pp.do_read_fault
      0.00            +2.3        2.27 ± 56%  perf-profile.children.cycles-pp.__do_sys_clone
      0.00            +2.3        2.27 ± 56%  perf-profile.children.cycles-pp.kernel_clone
      0.00            +2.4        2.37 ± 58%  perf-profile.children.cycles-pp.zap_present_ptes
      0.00            +2.4        2.45 ± 53%  perf-profile.children.cycles-pp._Fork
      0.00            +2.6        2.59 ± 53%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.00            +2.6        2.59 ± 53%  perf-profile.children.cycles-pp.x64_sys_call
      0.00            +2.6        2.64 ± 44%  perf-profile.children.cycles-pp.do_pte_missing
      0.00            +3.1        3.13 ± 59%  perf-profile.children.cycles-pp.zap_pte_range
      0.00            +3.2        3.21 ± 58%  perf-profile.children.cycles-pp.zap_pmd_range
      0.00            +3.4        3.40 ± 56%  perf-profile.children.cycles-pp.unmap_page_range
      0.00            +3.4        3.43 ± 55%  perf-profile.children.cycles-pp.unmap_vmas
      0.19 ± 23%      +3.9        4.06 ± 45%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.51 ±  6%      +4.0        4.49 ± 38%  perf-profile.children.cycles-pp.handle_mm_fault
      0.04 ± 44%      +4.0        4.04 ± 28%  perf-profile.children.cycles-pp.__schedule
      0.77 ±  3%      +4.4        5.18 ± 39%  perf-profile.children.cycles-pp.exc_page_fault
      0.76 ±  3%      +4.4        5.18 ± 39%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.58 ±  2%      +4.7        5.26 ± 53%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.00            +5.1        5.07 ± 71%  perf-profile.children.cycles-pp.writen
      0.00            +5.1        5.07 ± 69%  perf-profile.children.cycles-pp.generic_perform_write
      0.00            +5.1        5.12 ± 47%  perf-profile.children.cycles-pp.exit_mm
      0.00            +5.1        5.12 ± 70%  perf-profile.children.cycles-pp.record__pushfn
      0.00            +5.1        5.12 ± 70%  perf-profile.children.cycles-pp.shmem_file_write_iter
      1.18            +5.5        6.69 ± 33%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.00            +6.2        6.24 ± 43%  perf-profile.children.cycles-pp.__mmput
      0.00            +6.2        6.24 ± 43%  perf-profile.children.cycles-pp.exit_mmap
      0.00            +7.0        7.00 ± 51%  perf-profile.children.cycles-pp.perf_mmap__push
      0.00            +7.0        7.00 ± 51%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.00            +7.2        7.25 ± 52%  perf-profile.children.cycles-pp.__fput
      0.00            +7.3        7.35 ± 20%  perf-profile.children.cycles-pp.seq_read_iter
      0.00            +7.8        7.84 ± 21%  perf-profile.children.cycles-pp.vfs_read
      0.00            +7.9        7.88 ± 20%  perf-profile.children.cycles-pp.ksys_read
      0.00            +7.9        7.88 ± 20%  perf-profile.children.cycles-pp.read
      0.00            +9.9        9.93 ± 41%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.02 ±141%     +11.1       11.10 ± 41%  perf-profile.children.cycles-pp.__cmd_record
      0.02 ±141%     +11.1       11.10 ± 41%  perf-profile.children.cycles-pp.cmd_record
      0.02 ±141%     +11.1       11.10 ± 41%  perf-profile.children.cycles-pp.handle_internal_command
      0.02 ±141%     +11.1       11.10 ± 41%  perf-profile.children.cycles-pp.main
      0.02 ±141%     +11.1       11.10 ± 41%  perf-profile.children.cycles-pp.run_builtin
      0.00           +11.2       11.18 ± 73%  perf-profile.children.cycles-pp.vfs_write
      0.00           +11.2       11.23 ± 73%  perf-profile.children.cycles-pp.ksys_write
      0.00           +11.2       11.23 ± 73%  perf-profile.children.cycles-pp.write
      0.00           +13.6       13.61 ± 44%  perf-profile.children.cycles-pp.do_exit
      0.00           +13.6       13.61 ± 44%  perf-profile.children.cycles-pp.do_group_exit
      1.70 ±  2%     +25.0       26.72 ± 15%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.21 ±  3%     +36.6       37.81 ±  7%  perf-profile.children.cycles-pp.acpi_safe_halt
      1.21 ±  3%     +36.6       37.86 ±  7%  perf-profile.children.cycles-pp.acpi_idle_do_entry
      1.21 ±  3%     +36.6       37.86 ±  7%  perf-profile.children.cycles-pp.acpi_idle_enter
      1.21 ±  3%     +37.4       38.57 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter_state
      1.21 ±  3%     +37.4       38.66 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter
      1.22 ±  3%     +37.6       38.82 ±  6%  perf-profile.children.cycles-pp.cpuidle_idle_call
      1.22 ±  3%     +38.5       39.67 ±  7%  perf-profile.children.cycles-pp.start_secondary
      1.22 ±  3%     +38.9       40.09 ±  6%  perf-profile.children.cycles-pp.common_startup_64
      1.22 ±  3%     +38.9       40.09 ±  6%  perf-profile.children.cycles-pp.cpu_startup_entry
      1.22 ±  3%     +38.9       40.09 ±  6%  perf-profile.children.cycles-pp.do_idle
     92.37           -92.4        0.00        perf-profile.self.cycles-pp.osq_lock
      1.19 ±  3%     +30.7       31.90 ±  7%  perf-profile.self.cycles-pp.acpi_safe_halt
      0.17 ±142%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
      0.19 ± 34%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      0.14 ± 55%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      0.14 ± 73%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      0.10 ± 66%     -99.9%       0.00 ±264%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__mmap_new_vma.__mmap_region.do_mmap
      0.11 ± 59%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_link_file.__mmap_new_vma.__mmap_region
      0.04 ±132%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.07 ±101%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.02 ± 31%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.02 ±143%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
      0.10 ± 44%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      0.12 ±145%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.04 ± 55%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.25 ± 41%     -98.5%       0.00 ±105%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      0.11 ± 59%     -97.1%       0.00 ± 61%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.40 ± 50%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.32 ±104%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ± 12%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.08 ± 28%     -99.5%       0.00 ±264%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.18 ± 57%     -96.8%       0.01 ±193%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.03 ± 83%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.01 ± 20%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      0.02 ± 65%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.32 ± 47%     -98.2%       0.01 ± 42%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      0.19 ±185%     -96.5%       0.01 ± 33%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.07 ± 20%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_link_file
      0.26 ± 17%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.02 ± 60%     -94.2%       0.00 ±264%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ±128%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      1.00 ±151%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
     25.45 ± 94%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      4.56 ± 67%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      3.55 ± 97%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      2.13 ± 67%    -100.0%       0.00 ±264%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.__mmap_new_vma.__mmap_region.do_mmap
      3.16 ± 78%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_link_file.__mmap_new_vma.__mmap_region
      0.30 ±159%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      1.61 ±100%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.03 ± 86%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.20 ±182%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
      3.51 ± 21%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      0.83 ±160%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.09 ± 31%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.59 ± 11%     -99.9%       0.00 ±105%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      1.60 ± 69%     -99.6%       0.01 ±129%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.81 ± 43%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.02 ± 88%    -100.0%       0.00        perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.02 ±  7%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      9.68 ± 32%    -100.0%       0.00 ±264%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     12.26 ±109%    -100.0%       0.01 ±193%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      5.60 ±139%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.03 ±106%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      2.11 ± 61%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      3.67 ± 25%     -99.8%       0.01 ± 16%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      1.65 ±187%     -99.3%       0.01 ± 23%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     37.84 ± 47%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_link_file
      4.68 ± 36%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.21 ±169%     -99.6%       0.00 ±264%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      7.92 ±131%     -99.2%       0.06 ± 92%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.36 ±186%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     33.45 ±  3%     -91.6%       2.81 ± 90%  perf-sched.total_wait_and_delay.average.ms
     97903 ±  4%     -98.2%       1776 ± 28%  perf-sched.total_wait_and_delay.count.ms
      2942 ± 23%     -95.2%     141.09 ± 36%  perf-sched.total_wait_and_delay.max.ms
     33.37 ±  3%     -91.9%       2.69 ± 95%  perf-sched.total_wait_time.average.ms
      2942 ± 23%     -96.7%      97.14 ± 19%  perf-sched.total_wait_time.max.ms
      3.97 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      3.08 ±  4%     -94.3%       0.18 ± 92%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    119.91 ± 38%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    433.73 ± 41%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    302.41 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.48 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     23.24 ± 25%     -96.7%       0.76 ± 27%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    327.16 ±  9%     -99.8%       0.76 ±188%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
    369.37 ±  2%     -98.9%       4.03 ±204%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.96 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_link_file
    453.60          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    187.66           -96.7%       6.11 ±109%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.37 ± 29%     -99.6%       0.01 ±264%  perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    750.07           -99.3%       5.10 ± 84%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1831 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      1269 ±  8%     -45.8%     688.12 ± 21%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      6.17 ± 45%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      5.00          -100.0%       0.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     14.33 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.count.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
    810.00 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      3112 ± 24%     -97.9%      65.75 ±106%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     40.50 ±  8%     -98.8%       0.50 ±173%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
     73021 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_link_file
     40.00          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
      1122           -99.0%      10.88 ± 98%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     11323 ±  3%     -93.6%     722.25 ± 20%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1887 ± 45%    -100.0%       0.88 ±264%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1238           -93.9%      75.62 ± 79%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     35.19 ± 57%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      1002           -91.0%      89.82 ± 93%  perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    318.48 ± 65%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1000          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    966.90 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
     20.79 ± 19%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      1043           -98.4%      16.64 ±214%  perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1240 ± 20%     -99.9%       1.52 ±188%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
    500.34           -96.9%      15.38 ±232%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     58.83 ± 39%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_link_file
    505.17          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     19.77 ± 55%     -62.8%       7.36 ± 85%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1237 ± 34%     -91.7%     102.88 ± 33%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1001          -100.0%       0.05 ±264%  perf-sched.wait_and_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2794 ± 24%     -97.9%      59.20 ± 61%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     49.27 ±119%    -100.0%       0.01 ±264%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
     58.17 ±187%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
      3.78 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      2.99 ±  4%     -97.0%       0.09 ± 91%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      3.92 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      4.71 ±  8%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      1.67 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.__mmap_new_vma.__mmap_region.do_mmap
      2.10 ± 27%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_link_file.__mmap_new_vma.__mmap_region
      0.01 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      1.67 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.04 ±133%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
     67.14 ± 73%     -99.5%       0.32 ±177%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      1.65 ± 67%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
      2.30 ± 14%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
     42.44 ±200%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
    152.73 ±152%    -100.0%       0.06 ±249%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
    119.87 ± 38%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.80 ± 18%     -99.9%       0.00 ±105%  perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
    433.32 ± 41%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    250.23 ±107%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     29.19 ±  5%     -99.2%       0.25 ± 24%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
    302.40 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.40 ±  6%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      4.03 ±  8%     -99.9%       0.01 ±193%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     35.38 ±192%    -100.0%       0.00 ±264%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.05 ± 40%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.72 ±220%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      1.00 ±120%     -99.9%       0.00 ±264%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     23.07 ± 24%     -97.1%       0.67 ± 10%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    326.84 ±  9%     -99.6%       1.19 ±108%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
    369.18 ±  2%     -98.7%       4.72 ±167%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.89 ±  6%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_link_file
      1.17 ± 16%     -99.7%       0.00 ±264%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    453.58          -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      4.42           -25.4%       3.30 ± 17%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    187.58           -96.8%       6.05 ±110%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.36 ± 29%     -99.1%       0.02 ± 84%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ±156%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
    750.01           -99.5%       3.45 ±141%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    340.69 ±135%    -100.0%       0.01 ±264%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
    535.09 ±128%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
     22.04 ± 32%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      1001           -95.5%      44.91 ± 93%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     13.57 ± 17%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
     13.54 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
     10.17 ± 19%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.__mmap_new_vma.__mmap_region.do_mmap
     11.35 ± 25%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_link_file.__mmap_new_vma.__mmap_region
      0.01 ± 32%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
     10.62 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.20 ±199%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      1559 ± 64%    -100.0%       0.44 ±167%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      6.93 ± 53%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
     14.42 ± 22%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
    159.10 ±148%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
    391.02 ±171%    -100.0%       0.12 ±256%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
    318.43 ± 65%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     13.14 ± 21%    -100.0%       0.00 ±105%  perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      1000          -100.0%       0.00        perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    500.84 ± 99%    -100.0%       0.00        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    641.50 ± 23%     -99.2%       5.27 ± 76%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     10.75 ± 98%     -89.8%       1.10 ± 78%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    966.89 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
     15.80 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     16.69 ± 10%    -100.0%       0.01 ±193%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     41.71 ±158%    -100.0%       0.00 ±264%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     11.64 ± 61%    -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      2.94 ±213%    -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
    175.70 ±210%    -100.0%       0.00 ±264%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      1043           -99.6%       4.46 ±105%  perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1240 ± 20%     -99.8%       2.37 ±108%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
    500.11           -96.5%      17.32 ±201%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     32.65 ± 33%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_link_file
     22.94 ± 56%    -100.0%       0.00 ±264%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    505.00          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     12.20 ± 43%     -59.2%       4.98        perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1237 ± 34%     -92.5%      92.94 ± 20%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1000          -100.0%       0.09 ±111%  perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.36 ±190%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      2794 ± 24%     -98.9%      30.12 ±114%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm

