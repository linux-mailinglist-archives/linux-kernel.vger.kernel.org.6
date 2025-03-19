Return-Path: <linux-kernel+bounces-568599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E820EA69826
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5201242675C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E87320B1F4;
	Wed, 19 Mar 2025 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3eXJk7R"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76A81E2834;
	Wed, 19 Mar 2025 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409444; cv=fail; b=GTwBg9tn7LlGw0rSRplW8aXtG1sB+wy1KloQ4vJDOVtktG8Z4o41aYABLGTu+FVltTGV/JGI3YJctfzQ3S9kP8F8ju8qJabaK+R1ggXGeSH4MWpOZNlMao82k5XKi8u3K5UihAPGWpl9cWcBx5/8n55Ndtr6KELHGZzRVKNGeoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409444; c=relaxed/simple;
	bh=qvX1Yax/9+lXUB0DvaOdiJor/5uKH2p6mHvkX6RXhTI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QAKqc5WeMX6Tr//6MCL98zxY9fYo4YczZ+eHJ3Coku+lYEGR+c4vrmvN2eOSfaiMbqafwELAUk8ka+WhRDaNsdcEg6+fMMgTHzO53C1rm+Vri5+NUVK1dtr2kqYXtbium+Pm3BeBpjRc3npbGAZrGZmy3Bkw43wPaoWebkotTPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3eXJk7R; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742409442; x=1773945442;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qvX1Yax/9+lXUB0DvaOdiJor/5uKH2p6mHvkX6RXhTI=;
  b=X3eXJk7RWn4u88c5R3+QQmEbh6We7BKsQoQEyjym4LkjzRq4dfG34hl1
   +PYFf5dK/B1Xm6guKoRUJrChVple9RWFpWWtiflaDueGGbQavND4iSs6n
   1HwaKxrM7yCporJzLb4QvNF2A/XGbYoxhLniWhMfh7DTQs6SEjS34ZNMD
   70HpcnRc/9e8dkJ1x5PQw1ww4AYU8hdu8bKqz7d7VlO4A05OkKcF5F+sb
   /L1xHZ/QuNet/qyNc5YMWJxZhvj4hY1Ou3EHaYWSQTQJ2VopVjnuSp2ok
   QqFDwfgJ+tYGZjwR95PGXXahYTO8/AtmxBcHzr24VxxO7Er+6TX72XRO6
   Q==;
X-CSE-ConnectionGUID: pzX9ScFpRDW6WXCGoWe0pg==
X-CSE-MsgGUID: 2tFYWxcERGKWT8qDCqF1Mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="54998911"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="54998911"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 11:37:21 -0700
X-CSE-ConnectionGUID: EwWZ3ClTSiycsGhNVtqcbw==
X-CSE-MsgGUID: FxqoQ7uaQOqLZosv5pM6iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="127946318"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 11:37:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 11:37:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 11:37:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 11:37:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7jEFJ3cnOEsDGVhT8WhsY0Eea7SNJ+HokFN3Rk+LGFzNNPP8bpg1TP3tpaGmH1UKOr3t7PyMmSAWlSfPyLCZivRD5Qim01uCcBZCwufkeTl+f69xbJHTKXJo3bRgwIBEmb6idT2xcUw7hHB5nCb5V5dbnVtQZe9fETj+isAnEqLS4gX1Th6SLsIuiAqC7Nec3UPn6VMhodPB8gY7lmiAW5kuDW2kjKZ9YISqu48ttdlTIkY8M6XN8a5kxBkvAjSKYXvU/1ohHoj4XJ1FNed4sAtBVTE/T3OrhBD8OujurxLi25DHk6Y3VJvLapH30I7lPTc5u6HxKAVPdH2L7GldQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avaH9n0kTKu3x2rAPMYzP6QclRTES+JhRYbfWi/Jf6k=;
 b=Czc2C5UJ4cywjDTeV5dJgLGbCVh5n/d6IL/3Pmz+833IvhrimGPGgS1AxmAjMCE6C1jgwZcaAO5StvRI2QDMzCRasnmj+LA5hgx1JAs4VpOSHO7dDvpuw3uFfE/c1nUADa+U6bRGt8XRPzxMa/fK3FMZalqEW7wKHStI99kdsk2XFVXS7lqqUhfZXHYZfwnq9OWqWnCZ7lXFjCnMo2HKl8yXJb2dub87alrHQUgXT+TdqWJLKguBD26mP59FH5u7+fg0fJ+NfkCqjLuFU+xvQpHiZc5R+72pJs6GxRSAyVPgI0m7PHlWvNiC+lNkBmOrn5IDkdGzTwC2yCSfa8OlKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8464.namprd11.prod.outlook.com (2603:10b6:408:1e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 18:36:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 18:36:56 +0000
Message-ID: <0cecd52d-253c-4b2d-9841-a86870d5945e@intel.com>
Date: Wed, 19 Mar 2025 11:36:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: "Moger, Babu" <bmoger@amd.com>, <babu.moger@amd.com>, "Luck, Tony"
	<tony.luck@intel.com>
CC: Peter Newman <peternewman@google.com>, Dave Martin <Dave.Martin@arm.com>,
	<corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<xin3.li@intel.com>, <andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
References: <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
 <f1744c45-9edf-4012-89bc-47393b4c53fc@amd.com>
 <CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com>
 <d1ca9220-1ab7-4a39-819a-03a6069b7ac4@amd.com>
 <CALPaoChLL8p49eANYgQ0dJiFs7G=223fGae+LJyx3DwEhNeR8A@mail.gmail.com>
 <a4ab53b5-03be-4299-8853-e86270d46f2e@amd.com>
 <c1c0a99a-a467-4ae6-80ee-04b6a9cdb6e5@amd.com>
 <Z890Q2GoP6GecwW4@agluck-desk3>
 <04e47d0e-6447-451e-98e4-7ea65187d370@amd.com>
 <6508cf67-3263-432e-892c-9b502b3c6cd4@intel.com>
 <f8a20ed8-6e30-4cff-a96b-8df89a605081@amd.com>
 <d07a70f5-b1ca-4766-a1d9-53988dd9164f@intel.com>
 <14c14b11-5b45-4810-8e46-019c8a67fc90@amd.com>
 <1db8ad73-5194-4821-844a-8fd7cac72ad4@intel.com>
 <9b8653a3-c6fd-4748-a4b5-94d5598d180f@amd.com>
 <20ec195a-c4dd-48d9-89f6-4d48fd438fe8@intel.com>
 <be6d23c8-3e93-4bdc-8b33-d3af7df7cc94@amd.com>
 <7f54f9aa-1102-49ed-b830-6facb6f48366@intel.com>
 <c840cb69-41fe-49a8-a7a8-d75f68e1d84c@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <c840cb69-41fe-49a8-a7a8-d75f68e1d84c@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:303:8e::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd2b717-1d5c-4838-3a18-08dd671506a5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFNEZ1FsaVc2Y2Qza3kwWXNSaUJKaE1Dc0ZLaFpTV2dFYnVPeU1vQ2RZeUpj?=
 =?utf-8?B?NHo1WXdvbEQ1dm9aOTRBTU1ITVhDL3k3YmFQY2VmRUNqcm90MVlJb1lqb1Jt?=
 =?utf-8?B?TmZtbDZDMjN5VVpFaVJpa3FpdGZGQm9QRDQwbGFlS3M5NFdiL0h2M0VIV1B3?=
 =?utf-8?B?bkpHa00xbTd0NDkzQmkrOHFRZjJFQ3M1TFJ4NkMybmYwYk0zZFNvY0UxaFZO?=
 =?utf-8?B?aDkzWlNybTVSUExTVzN6Y0tBUVVLcnhaYjlaeGZCRThOVWFNeWFSMmFrZHo4?=
 =?utf-8?B?Qm1sQU9hc0JVdmgxZWZLRGhjTmZ1alpiMDNXUWIxaUMyZWdaSW9kRDcxWUlN?=
 =?utf-8?B?d01hYzRPRlZYalJpeWtVTHh3TFZBWEdUUXcrSGVyaG9EZjBoR0J5TUdKZ0N0?=
 =?utf-8?B?NkpSZmxxdm02YWVRd3lMNzdlajd3citBRFpCb1ZBcktGZ0I2cGk5TXRwNVZl?=
 =?utf-8?B?U2dPR0pGR2lKbHMxRUJXZVBNOFNpK01nUGtLdmE5OWl5eXNWL2E5SUkzYlU3?=
 =?utf-8?B?bnVoS0lyWUZwVk9uT0dZdnhJL3RmY0J1VnhraEphVk03bGJVaFFPUE94cUNt?=
 =?utf-8?B?MDZ5TkxCMitERmhYZkpuZzVpbXI0ZmhBYUVVVDAwN0xjNHFHcUVCMWpqNlRK?=
 =?utf-8?B?MGR5djl1ZFFhSkI3dVNVekI0OStBUlo1RXdnQ21JclBmcmU4NktMUlN3dGFz?=
 =?utf-8?B?VWsrS0VTTHk4dGMwNUxhbVBzSHllTjhIekFnWGdqL0FuWHZXTmdvN1c2K3dC?=
 =?utf-8?B?ZXFlNXluOXJ0bCt5d1M2UERNSU0rS1FZWnNGNHRySWVvbFNTY1E2ZGhqaFg1?=
 =?utf-8?B?NFBjZGxHaDNqV3pSaGZidlI5UWYyVklzUFYwbFJHUG1JbGJkcmx3dnpiRzNo?=
 =?utf-8?B?N2hQVHNxK01mbUc5dnVkWTBoQXZDNk10YTVJR2kzRXNGdkhMeFo5QVhkRFBk?=
 =?utf-8?B?bno2S2Z5eVR0NXQrVmNObmZ3eVNhSm5pc080aWV2alNadHVzUlZQMTh3UEZp?=
 =?utf-8?B?TmJybEV2Wlh4eGtTQmgzZlVPZ3FpNjJxV0s1RkRYeWNRSEN3ZE1FUGxxVDh2?=
 =?utf-8?B?ZTJmMmowR0doOHM0d0Y2MHU0aTRsTUlCNDdzdkxGdFVDZXRxd2RwTDh0WDZ2?=
 =?utf-8?B?alZBVlVjNVlGNEMyVjJDTlRQNmtVWTI4bWhmQzBseVpDUElyWmZRallRRW5F?=
 =?utf-8?B?SS9oanNoRlVLazZKeDBxUDV3L2IxWlBPNVh3TVVHZ1pMSzJZZmhJWnN1bG4v?=
 =?utf-8?B?UStybkplcG1vYVlUNi8ybEgrYXVhNEEyOVJhYlBySjB5MXRPTjdTL3VtTjU0?=
 =?utf-8?B?OVVLUWhHd05mM3JmNFFKUGFUMFB1WEVWSlVwaUs3RUlqTkpWUldVM1B2UEd3?=
 =?utf-8?B?bEdEbjEvNUozVHZyQVNWZGxVdXNwdStIRnlReXNSbmpRcXpobldiSnd4bGJQ?=
 =?utf-8?B?SW04akRvRTJNcXBDSXhwWWVjdlUxOVZlK3lBUTVuaHZDRUp6anFVYmxBYW1h?=
 =?utf-8?B?cGxKSzBlOWNoZG8wSGErTm9Qby85b0F3K29MNG5IYnBhckhnSVVjUjEyWnZi?=
 =?utf-8?B?ZGs5aWVvVE1xY0F0SHQyT09nNER0VXF0b0o1WUlZZ2kwaWlTVEsyTEJBKzl1?=
 =?utf-8?B?SUd6ZFFLNER0bkRhSzNUUzNSeWh2OXB5cmRrUmxzRktLYzQ4QlU3b1VVaWhp?=
 =?utf-8?B?a3ZKRTlTREw5b1dwWXhlQ0xjMmdra2lXQ0dIM2lQWjhjUjUyb0o0R0QvanNK?=
 =?utf-8?B?eUlrbTVqZjNZS3RvMGFjaC9oakJvclFxWkhNZE5FWFlTWlFWYnQ1RkVnamN3?=
 =?utf-8?B?cll1TnNSZHo2RmNkbmljc0tmUXZDRUZ3U3d1by9BR2laeFZqSTNkb2J3dlJu?=
 =?utf-8?B?elMyOHU0WlNtYzFhT0Z6WEhHQmJOclFjNnZWdm51S1VNc0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE84RVRyNEdGRUJURXJTRC9zNzZyWlkxdWtudUhOZW90WFBtSnVIbkVBR2dF?=
 =?utf-8?B?Z3lMRFJDSkFmZGVuaXFSSDhQM2h0eEJEalA5UzZaQXBaK1UrSGYyMm1QN0xG?=
 =?utf-8?B?SzhISjhvVTFwa3BvSDNuWi9TaDlWdFYzWVl4bU1vRUtkQnNhU1RtVE9BaGVI?=
 =?utf-8?B?VHZxOEhPT1NEMm1IZkFiN1dIWjBFYTVnc2h1bnlORW43azQvRTF1VWx6bkNC?=
 =?utf-8?B?TFdiZWdhUVBTNUtNekFMczVHWWZkZHo4TXZNRXFUc0REdFBjckRpRWlHTmU4?=
 =?utf-8?B?Tm5ab3FEZVR5UXBzTGRXaGVtQnFZWHVWTzYvK2RyU0c0TU9BRFAzNzJ5Qnph?=
 =?utf-8?B?RXdkdlBoWWdERzlUVSthVlhaMzlYZVFCT0R6TXlFQUg3VUtQa2R0bnlSTi90?=
 =?utf-8?B?cDNwSXBXaVRUekxZR0t1OTJmSHpZaXhPQWxYdmpuTXNKOGp6ekhiUmhTd0NM?=
 =?utf-8?B?aElIZnhxUm4vR0ttT09McTlydlZTd2E0eVVsSkVRSDhteWdDM2F1ekIvK2V0?=
 =?utf-8?B?UFRaODJiSEkrcWJjbEtRKzVSVnJ6RlRwUFhQK09xSWxsQldJT2tUd2NFZ042?=
 =?utf-8?B?cExDTVdBVHIvNlBEZnEvR25TMWI5b3NZQUdSdFBaa01QNWtzcE9qcTBTSUtr?=
 =?utf-8?B?bkxGSUxlOE9ZVjU0eXp3cXhvTWdwVDlDTGhLRmpyWTNaN3JPa2hWUmc2YW9z?=
 =?utf-8?B?TG9TYXIzZjVBbVJ0RDJMWE9qcjNWQnhRUWxoUUJZRXpzOUFqTDRXVWNsUldH?=
 =?utf-8?B?azhDODQyK3p5OG1WcUJSSFpiaEovTTVrN2ZCRGo3WG96RW54Vkp3cnMrZWFn?=
 =?utf-8?B?eEQxQ25oSHY3T1R6TnY4TWVJditoZmE2TVN0QzNpK3ZIeUI5Q25SQkJwMzdo?=
 =?utf-8?B?c3FtMEdnUFRYRCtXdnRkdzhJenR3S0RTdGh1NTNBZktPdHJra0JtNkQ0Z0Fs?=
 =?utf-8?B?NiswSGYxNTFXVDRnVmxNL3k1ck9Ba3FpMDFramlBaHZiaDl1amlRN1Y1RmxP?=
 =?utf-8?B?SnJzZG5pei8zTFRLVk5HRWM5QzBoQXZJK1QxNFBVZWxVWFRZSGtmTGxLL0pZ?=
 =?utf-8?B?UXRmTlErQ1JWaEdRM2dWOUQzRWcrbFk4dzJ4U1RoU0txcllYV0d4RUlwTStZ?=
 =?utf-8?B?b2RaSVFNLzVJT3pTWktBakNGVWpJT1FSZW1Fdk5HOWlWTjByQjhzUTh2WVdC?=
 =?utf-8?B?WlpMcFlxM1pEWVh1SEpkRGQ0NVhETVoxczRPcGxqKytyNExQa3lDbFF4U0J3?=
 =?utf-8?B?ZHZaVWU0Q0hHUld1RUNTT0VEMkMzN3c2M2hZRHh3YmtrOXVvVWZyL2dKYXhF?=
 =?utf-8?B?OE13a3BFcUdqd3NFUVArZU5IL1BMUEhkc1B1Q2p0Sm5DRm9oMFhoMHlJRDNK?=
 =?utf-8?B?KzRuYVhQclhrMHRSNXY5WHp3VFJhWWE2dTNLcDBOa1BJZ3BENnRqQ293QUdM?=
 =?utf-8?B?TEJaQzRDaHZETUdFVEh2NTg5ZGowWjh1eWkycjg0ZVAwMlozRlg5VXJUNzds?=
 =?utf-8?B?eXdiYm55VWxHY04zSmNxa0d4OEk0Z0owWEpNckdxT2UwUUM4T2JnRmk0a0hJ?=
 =?utf-8?B?R3N5bXpsS1lpcE5YVlV4WGRiSnhJN2JlZXBSbjYzZ1J5Q1FKRjQzTUh4cFJJ?=
 =?utf-8?B?elhBa2hiUWN5dXhDVjV5bU1MU1B2VTc4UFAxUWpqTHZzQ2grZ2FQNFlweWVt?=
 =?utf-8?B?NkRvSWJibFRiVDA0dlZOS2VPYko0SGZqM1hJN1VhakJERXNmN2daRUxwTTVt?=
 =?utf-8?B?VHkyaWd3K2ZxNnRTdTRFZFA5ejNOeGgyMERjbHpiYm9lSnlQU3ZWakppLzBY?=
 =?utf-8?B?aEtTbDVJenpjTmw0V3lYRnp1Z1JHdWFkVng4Qkk3L2xSOVJ1RnVuVC8ybEd1?=
 =?utf-8?B?RlBxZFNKUnR3dmxCQWREbmd0M0FkUG81aHhyYlVlWVQrQ2FlcUtMQnhaMlR6?=
 =?utf-8?B?K0o4LzhaTXk3TnRUb2RzclIxR1hIWklwT3FNYVIxWFZXeTdaZnhIQlViMGZK?=
 =?utf-8?B?NGU3cjF3VzVGdHpwWFd5eEsyTFFnc01nUnBPdEgzMzFIVjNHdloxUVNuL1RU?=
 =?utf-8?B?SENabGFFaVpEZTh2eGlGb3FVMkJLaVNkM1J2YnhpU0NabXQ4M3Jia3pwZExG?=
 =?utf-8?B?cndvbGY4TjMvZGlTMmNnL1VCRnFnMFdCTmFUTXJkVlpZYkFkVEpOcGJQdHFY?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd2b717-1d5c-4838-3a18-08dd671506a5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 18:36:56.1583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M78pDtw/ajTEBJ90ouZN5L4xN+Ahpdy3vnCDXkzZbbc0k1Gj8AtXRrNKBiRJ0zjpTWTGbQ/6l9nmP2uwKK95PW7lhYItzt0Sf5e2N3S/GhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8464
X-OriginatorOrg: intel.com

Hi Babu,

On 3/14/25 9:18 AM, Moger, Babu wrote:
> On 3/13/2025 4:21 PM, Reinette Chatre wrote:
>> On 3/13/25 1:13 PM, Moger, Babu wrote:
>>> On 3/13/25 11:08, Reinette Chatre wrote:
>>>> On 3/12/25 11:14 AM, Moger, Babu wrote:
>>>>> On 3/12/25 12:14, Reinette Chatre wrote:
>>>>>> On 3/12/25 9:03 AM, Moger, Babu wrote:
>>>>>>> On 3/12/25 10:07, Reinette Chatre wrote:
>>
>>
>>> Here are the steps. Just copying steps from Peters proposal.
>>> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/
>>
>> Thank you very much for detailing the steps. It is starting the fall into place
>> for me.
>>
>>>
>>>
>>> 1. Mount the resctrl
>>>     mount -t resctrl resctrl /sys/fs/resctrl
>>
>> I assume that on ABMC system the plan remains to have ABMC enabled by default, which
>> will continue to depend on BMEC.
> 
> Yes. ABMC will be enabled by default. ABMC will use the configurations from info/L3_MON/counter_configs. ABMC will not depend on BMEC.

I see. The previous dependency was thus just something enforced by OS to support the
chosen implementation? 
Looks like the two features share some registers.

> 
>> How would the existing BMEC implementation be impacted in this case?
> 
> BMEC will only work with pre-ABMC(or default) mode.

ok. Does this mean that if a user boots kernel with "rdt=!bmec" then ABMC will keep working?


>> Without any changes to BMEC support the mbm_total_bytes_config and mbm_local_bytes_config
>> files will remain and user space may continue to use them to change the event
>> configurations with confusing expecations/results on an ABMC system.
>>
>> One possibility may be that a user may see below on ABMC system even if BMEC is supported:
>> # cat /sys/fs/resctrl/info/L3_MON/mon_features
>> llc_occupancy
>> mbm_total_bytes
>> mbm_local_bytes
>>
>> With the above a user cannot be expected to want to interact with mbm_total_bytes_config
>> and mbm_local_bytes_config, which may be the simplest to do.
> 
> yes.
> 
>>
>> To follow that, we should also consider how "mon_features" will change with this
>> implementation.
> 
> May be
> 
> # cat /sys/fs/resctrl/info/L3_MON/mon_features
>  llc_occupancy
>  mbm_total_bytes
>  mbm_local_bytes
>  counter_configs/mbm_total_bytes/event_filter
>  counter_configs/mbm_local_bytes/event_filter
> 

I read the docs again to understand what kind of flexibility we have here. As I interpret it
the "mon_features" is associated with "events" and there is a clear documented association
between the "events" listed in this file and which files a user can expect to exist in the
"mon_data" directory. Considering this I think it may be helpful to provide the
counter configurations in this file. This matches well with mbm_total_bytes/mbm_local_bytes
being treated as "counter configurations".

Whether counter configuration is supported could be determined by existence of
the "counter_configs" directory?

For example,
# cat /sys/fs/resctrl/info/L3_MON/mon_features
 llc_occupancy
 mbm_total_bytes
 mbm_local_bytes

# mkdir /sys/fs/resctrl/info/L3_MON/counter_configs/only_read_fills

# cat /sys/fs/resctrl/info/L3_MON/mon_features
 llc_occupancy
 mbm_total_bytes
 mbm_local_bytes
 only_read_fills

This could possibly be a way to support user interface when configuring the
counter. For example, a user may easily create a new counter configuration
by creating a directory, but there may be some requirements wrt its configuration
that need to be met before that configuration/event may appear in the
"mon_features" file.

>>> 2. When ABMC is supported two default configurations will be created.
>>>
>>>    a. info/L3_MON/counter_configs/mbm_total_bytes/event_filter
>>>    b. info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>
>>>    These files will be populated with default total and local events
>>>    # cat info/L3_MON/counter_configs/mbm_total_bytes/event_filter
>>>      VictimBW
>>>      RmtSlowFill
>>>      RmtNTWr
>>>      RmtFill
>>>      LclFill
>>>      LclNTWr
>>>      LclSlowFill
>>
>> Looks good. Here we could perhaps start nitpicking about naming and line separation.
>> I think it may be easier if the fields are separated by comma, but more on that
>> below ...
>>
>>>
>>>    # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>     LclFill,
>>>     LclNTWr
>>>     LclSlowFill
>>>
>>> 3. Users will have options to update the event configuration.
>>>     echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>
>> We need to be clear on how user space interacts with this file. For example,
>> can user space "append" configurations? Specifically, if the file has
>> contents like your earlier example:
>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>   LclFill
>>   LclNTWr
>>   LclSlowFill
>>
>> Should above be created with (note "append" needed for second and third):
>> echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>> echo LclNTWr >> info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>> echo LclSlowFill >> info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>
>> Is it possible to set multiple configurations in one write like below?
>> echo "LclFill,LclNTWr,LclSlowFill" > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> 
> Yes. We should support that.

Reading Peter's response (https://lore.kernel.org/lkml/CALPaoCj7aSVxHisQTdKQ5KN0-aNzN8rRkRPVc7pjGMLSxfPvrA@mail.gmail.com/)
it sounds as though this part is now in the fine-tuning phase.
If there are other formats that is more convenient for user space then we should surely
consider that.

> 
>>
>> (note above where it may be easier for user space to use comma (or some other field separator)
>> when providing multiple configurations at a time, with this, to match, having output in
>> commas may be easier since it makes user interface copy&paste easier)
>>
>> If file has content like:
>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>   LclNTWr
>>   LclSlowFill
>>
>> What is impact of the following:
>> echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>
>> Is it (append):
>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>   LclFill
>>   LclNTWr
>>   LclSlowFill
>>
>> or (overwrite):
>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>   LclFill
>>
>> I do think the interface will be more intuitive it if follows regular file
>> operations wrt "append" and such. I have not looked into how kernfs supports
>> "append".
> 
> Just searching quickly, I have not seen any append operations on kernfs.
> 
> 
>> As alternative, we can try to work the previous mbm_assign_control syntax in here (use + and -).
>>
>> For example:
>>
>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>> LclNTWr
>> # echo "+LclFill,-LclNTWr,+LclSlowFill" > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>> LclFill,LclSlowFill
>>
>> With something like above resctrl just deals with file writes as before.
> 
> Or without complicating much we can just support basic operations.
> 
> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>   LclFill, LclNTWr, LclSlowFill
> 
> # echo "LclFill, LclNTWr, LclSlowFill, VictimBW" > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> 
> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>   LclFill, LclNTWr, LclSlowFill, VictimBW
> 
> # echo "LclFill, LclNTWr" > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> 
> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>   LclFill, LclNTWr
> 

Looks good to me. As I see it this could be expanded to support "append" if needed.

>>
>>
>>>
>>> 4. As usual the events can be read from the mon_data directories.
>>>     #mkdir /sys/fs/resctrl/test
>>>     #cd   /sys/fs/resctr/test
>>>     #cat  test/mon_data/mon_data/mon_L3_00/mbm_tota_bytes
>>>     101010
>>>     #cat   test/mon_data/mon_data/mon_L3_00/mbm_local_bytes
>>>     32323
>>>
>>> 5. There will be 3 files created in each group's mon_data directory when
>>> ABMC is supported.
>>>
>>>     a. test/mon_data/mon_L3_00/assign_exclusive
>>>     b. test/mon_data/mon_L3_00/assign_shared
>>>     c. test/mon_data/mon_L3_00/unassign
>>>
>>>
>>> 6. Events can be assigned/unassigned by these commands
>>>
>>>   # echo mbm_total_bytes > test/mon_data/mon_L3_00/assign_exclusive
>>>   # echo mbm_local_bytes > test/mon_data/mon_L3_01/assign_exclusive
>>>   # echo mbm_local_bytes > test/mon_data/mon_L3_01/unassign
>>>
>>>
>>> Note:
>>> I feel 3 files are excessive here. We can probably achieve everything in
>>> just one file.
>>
>> Could you please elaborate what your concern is? You mention that it is
>> excessive but it is not clear to me what issues may arise by
>> having three files instead of one.
> 
> All these 3 properties are mutually exclusive. Only one can true at a time. Example:
> #cat assign_exclusive
> 0
> #cat assign_shared
> 0
> #cat uassigned
> 1
> 
> Three operations to find out the assign state.

ah - good point.

> 
> Instead of that
> #cat mon_l3_assignments
> unassigned
> 
> 
>>
>> I do think, and Peter also mentioned [1] this, that it may be useful,
>> to "put a group/resource-scoped assign_* file higher in the hierarchy
>> to make it easier for users who want to configure all domains the
>> same for a group."
>>
>> Placing *additional* files higher in hierarchy (used to manage counters in all
>> domains) may be more useful that trying to provide the shared/exclusive/unassign
>> in one file per domain.
> 
> Yea. To make it better we can add "mon_l3_assignments" in groups main directory. We can do all the operation in just one file.
> 
> https://lore.kernel.org/lkml/efb5293f-b0ef-4c94-bf10-9ca7ebb3b53f@amd.com/

I am hesitant to respond to that message considering the corporate preamble that
sneaked in so I'll just add some thoughts here:

Having the file higher in hierarchy does seem more useful. It may be useful to reduce
amount of parsing to get to needed information. Compare with below two examples that can
be used to convey the same information:

# cat /sys/fs/resctrl/test/mon_L3_assignments
mbm_total_bytes: 0=unassigned; 1=unassigned
mbm_local_bytes: 0=unassigned; 1=unassigned

#cat /sys/fs/resctrl/test/mon_L3_assignments
0=_; 1=_

We need to take care that it is always clear what "0" or "1" means ...
Tony has been mentioning a lot of interesting things about scope
changes. I assume the "L3" in mon_L3_assignments will dictate the scope?

With a syntax like above the needed information can be presented in one line.
For example,

#cat /sys/fs/resctrl/test/mon_L3_assignments
0=mbm_total_bytes; 1=mbm_local_bytes

The caveat is that is only for assigned counters, not shared, so this needs
to change.

To support shared assignment ...  I wonder if it will be useful to users to
get the information on which other monitor groups the counter is shared _with_?

Some examples:

a) Just indicate whether a counter is shared or dedicated. (Introduce flags).
#cat /sys/fs/resctrl/test/mon_L3_assignments
0=mbm_total_bytes:s; 1=mbm_local_bytes:d

b) Indicate which groups a counter is shared with:
#cat /sys/fs/resctrl/testA/mon_L3_assignments
0=mbm_total_bytes:s(testB); 1=mbm_local_bytes:d(not needed but perhaps empty for consistent interface?)
#cat /sys/fs/resctrl/testB/mon_L3_assignments
0=mbm_total_bytes:s(testA); 1=mbm_local_bytes:d(?)

... (b) may just be overkill and we should instead follow Tony's
guideline (see https://lore.kernel.org/lkml/Z9CiwLrhuTODruCj@agluck-desk3/ )
that users should be able to keep track themselves.

Reinette

