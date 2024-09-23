Return-Path: <linux-kernel+bounces-336348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4760D983A0B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1C9282451
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843F385283;
	Mon, 23 Sep 2024 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZgjwUmoV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A662907;
	Mon, 23 Sep 2024 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130628; cv=fail; b=CsuQMJRW6CNK7kVig8GtH/M3rPx/dh7ngbxcrmO1lDGkYlxk6NYys2fNuw3RPAT8rL2hNa2tBcvz+zxN3VsBw/jI8ROyhOADoaidcVYLbG62CGi3nWf1LQxanNYaNxvw+tZhwxdfErHluFjeSuVLL887CxiN0imXuN3nCFA6qDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130628; c=relaxed/simple;
	bh=vEbu3BJVp1oeIqxCwJ8Vp1OwKFl2htTZs0kSUAGX1kQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JPav6M10fZ3SKBtRXGY4Pv8K/O5zuNLbdg/F4FPG9XiiXsttYamWeph0GLFX9H4Qs0RIV7QRYq+plcbG50XddofXFs4blWySzL5KRPck7cKSERaiaAFR+utSrYAWjfY/WPqGqHfHKKT39ipKUnV13PtEqmZpxJlifOMls0vKGvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZgjwUmoV; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727130627; x=1758666627;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vEbu3BJVp1oeIqxCwJ8Vp1OwKFl2htTZs0kSUAGX1kQ=;
  b=ZgjwUmoVYFPt3/t+XAigWP/nWu1C4wH+bcQdWg/wL/6oqpjgRarqpZ+h
   6Cd4ZC4T2cEBYTBtmi9tPWWEmq4d5xffzYBjNr6nCWcf8UQHRDl7MWxmI
   9sAFGQJ7X4O4MHKq4WB3pPXzxa4esaX2tnU4QlVBSem/x5yD4+0jrC4Sd
   QJQWyvQ6eNScUW2lA4zIwM9r/UN4Mvn6py9sI2+n6BRX91hQ2IwggDXuG
   0nNdoYjKn7625y5bxWH/YrsFV4cBbnsskliBMXJoAdCKBSnPlw5z02qI/
   dTZDJMYvrHOBAXM76kQXc6RdKm+JkuPe/mjhwFsxgjoboGq8f7+eKDobZ
   Q==;
X-CSE-ConnectionGUID: 1hmsSFGkSbmWGuikDwkkpg==
X-CSE-MsgGUID: mqqDtSlmT5+6zrTlv/E6PQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="29986778"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="29986778"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 15:30:25 -0700
X-CSE-ConnectionGUID: PgOCYhNBQy6qSb2MNVnpmw==
X-CSE-MsgGUID: mlkcAw25TRejxJwXktdGJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="94557223"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2024 15:30:25 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 15:30:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 15:30:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 15:30:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 15:30:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 15:30:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmV8UbetDyw4ryH6ytuuinPUeEHhn6zJLZ6UAheHBeHoMEMKcKMY7o4lmpSMzSDJlAWlrwQx1U7bEt04pvbm1gDFvG9mFCMswPDndi8kWjCyur/wVYtWW9365u6xBxH20L6ce0vGweN5rRtkCaKPFw4FvkdU6fl6QXW1BRbFT+8Fv33Le+g0Yxzsdq8ZcreZnPzrxTswOKeJzLjevzq4BJxtCvW5Pk2IecpGpUllsH9cyRC7HKyk7TQ6e1HiR6IGdx+RtfaKBg8aCFud/EmSw//QTnGJKtBbte4vls82h42FJaUeWz8VUBOHchPEAZWUVa724EhFh/99F5TJDwcUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtsmGm/YRame4hgpjYS67/2rTDkUMI6TemofDpjhCrQ=;
 b=eknSGMaD03VSaUL951sVmViILpG7QUkHKABzPrlKMY7VoG0sKmvgHrUk/U+YcQFTqqWT3s3SsxQyC5ZeCPCi7kfCyHqNXB3eYyN8AqiowlE8y8nq9qguwHQvyLkrOal74j6vPdrarfIH726NQenJsEmaGgwgzqCFzLkmbmzF7bp0+CEVRgTgIuDl9NwNdqJcVuelqby6L0n7aHMcvap/XOA7RVyjgzxCbgPjg1bnCktBgbyL0pGvKDzav3H7mF6AEdyO1p08MXXC/N68HcrEtYNPu80XkNPDDaF/WmTKe7lwlKwkTaI/FCrrTYDs33IyaorZ9pPDsTipQ4gT5DKKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB5277.namprd11.prod.outlook.com (2603:10b6:5:388::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 22:30:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 22:30:08 +0000
Message-ID: <5093395d-d8b7-482c-825a-5b87df7aecfa@intel.com>
Date: Mon, 23 Sep 2024 15:30:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/24] x86/resctrl: Add data structures and definitions
 for ABMC assignment
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1725488488.git.babu.moger@amd.com>
 <e0520492d3417df6f708c7ff7b9163b64843fc77.1725488488.git.babu.moger@amd.com>
 <02f1a542-f642-4efd-898a-a604e3a741f9@intel.com>
 <520817d3-6521-4320-b6a2-d0695a5d3699@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <520817d3-6521-4320-b6a2-d0695a5d3699@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0213.namprd04.prod.outlook.com
 (2603:10b6:303:87::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB5277:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d8064d7-8011-450b-2715-08dcdc1f47aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXlSaGxwTW1Oamx5R1VmMlJKemRtaEZ3a0htdmpCOVM3U3gxbUtzbU8vRWR6?=
 =?utf-8?B?WUJSYnMvQVo4TmtJeExzYlcrblA5dXNLS1NRUnV0cGljOEVzWnRyRmdmMkNX?=
 =?utf-8?B?dEZnOUJTZjNoaU5FZTRuVjZleWppT2FhUkZpQlVSYVFRSzdXUkViam0wbUxI?=
 =?utf-8?B?dEd6NEZydUM0UE85SUpHWk8yYUEwcTU0ckhQUnRFRHNUaUhUcENpc00wbjR0?=
 =?utf-8?B?aUtRSDVTeTcwU2hJL2x1cnVFU1ZmZE9LMlc3ejI2R1lJS2VjNE00QThmS3Zt?=
 =?utf-8?B?SG5Dd3FLMFIydmZUbWovOEhLbGVSRzQ4WW0xV2Fac01td2dyZHZhQWZlUVFy?=
 =?utf-8?B?M1k0UWp6OS96WlNsT2J6T0ZPTjZXeWN2Qjd4aStNUzBGVmgveWtQNUIvb21R?=
 =?utf-8?B?Rlk1OTliRndkaW4wSjAvNTBQSkU5YlFLdFFibGpkdHlRSGhEUVlMSUh1UTJP?=
 =?utf-8?B?RkZLNWVDMmdlZ2NjaTBwcWRoYWpud3NIbmJzZ2xuNmhSaEM1ODdjRlNOT3Rw?=
 =?utf-8?B?VzFILzlySFFiZG5rVzNCbEo5Q1pjdGYydnpkTlRueGQvTWxhKy9nb0JKZDJ5?=
 =?utf-8?B?cFFzYWkwOWMwRldrd3lDNnJVaTA0NHo1ZjR1M0NCSXp0bFY4ZVhMR3JvQWpJ?=
 =?utf-8?B?NEsvZ0c2d2l4eDZRRXBUcFA5VnFFN0dMOTV3bUR1YjhaTEJmMTliWDB3Zyt6?=
 =?utf-8?B?ck1SMnpJaGJtbVFZcHloK3VxWjVLS2N6MUpPTG93RXNWa1FVcWltUmFpMHBn?=
 =?utf-8?B?TDhwV2JsSWp4Qm1LY3loM0RrVkxKMzNybFhJOStlaWkzWm9OZzZqbGRER2Vy?=
 =?utf-8?B?Y1NqU2hkYXNJdHlJbzZBYlNxOGt4TURjU1ZkTUlyQkc3R0dVMUE5TmhZbHdh?=
 =?utf-8?B?eVRMTExIaEdQSW8vS1MzTEVma2NPMGY1WFFyekdMNFdaL1crT1ppZ0o5NVdi?=
 =?utf-8?B?Ri9KVEVzRWZsalBpZUhlWUIvMkhFSS9tK3BPVjlJd29qREpRMmxzbFlDdnla?=
 =?utf-8?B?TUFtTWprYmcwdytYa1FUMHhBLzRsb01vT1NQSDJOU1FvYjJZUHU3OTQ0NW1q?=
 =?utf-8?B?M0lXVFJ0WHh4a29OU0RuNnV5UDlLR2ZGOFJNQUtHY3JFSnNLcy9aQnVpU2t4?=
 =?utf-8?B?VnlFZkpSQzB3dXhiSXcrQ21JdytJSElmZlM2RUVZSlVUTXVsaDNsTHFNWi9T?=
 =?utf-8?B?Ylg1eTc4MUpEYXdBM1lLbDlIUG9SM2RWejVrV0VJR2FzeTlNdExCbDIvWjAv?=
 =?utf-8?B?N3ZNUEN4YVJCZURybENTbS82RlFaZENnaVcwcmxRS1k1VnhrMDB5MDBhN2M3?=
 =?utf-8?B?NStCdElRRi9laVI0d3p1YUZEMFlCcDByLzdnVTBxMG5Yd3UwUXVKWXBpSTVX?=
 =?utf-8?B?Z0RJSThiZkJWZnJDSGVNNzhiSGEvVnJpeXVyTU5ZdFp6NnkyTEpvMzdxSFJl?=
 =?utf-8?B?YzZGUmFrMHJ0bHZrRmRoZURGbFZGNk80SzY5ZXRlcitHN0VJRlNRWS95d0Jp?=
 =?utf-8?B?Y2RjZ2ljTkl5M1c3ZzZuVm1ma016YTd4c3J5dHowS3FkdUhyUG9xYi9QOTV0?=
 =?utf-8?B?MXFBUjlDRWtyYlpJMmxjc29JY28rLzRPL2FXdkQ0dDAwOUtrTUZHTVdFUlZQ?=
 =?utf-8?B?NFZSeGJlN3hDYlY1T21jVGdqYU1aanFLZU1iQ1JPYkJBZkhvSU04SElCY25Z?=
 =?utf-8?B?SjdzaTNCc2svbzVTdEw5NWVlS3hPUXIvcGlIZURqY015TTVvUEp4SUhxb2hZ?=
 =?utf-8?B?KzJRWVBsQkFZMXZub2tjZkRMWTNsUW9DK3VQbGJ3K3VudUZLTTZaMEkvcENT?=
 =?utf-8?B?czFFWjdzZFo3UGFsa2NLQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUpFcm5KcXBrUTZNaHVLZXh3V09SNktpZHRUdW42L3dCOTFhWG5aWHdDMzlB?=
 =?utf-8?B?emZISytjMVhwbUVoUFFpc1NFblB6MVI1U05vRTNGL3BnWnBhVDAyUE9pb2Uv?=
 =?utf-8?B?ZU8zOWRhNTYwRUczSFp6eEh0RFNoK0pkMDNvbHg3Q08wQ2h0N2hITHdmNXB4?=
 =?utf-8?B?M0trbUE1cUlCdHlUbzlQWnA3cE10alh4c3BWbjV3ZDBDYzByVDhSWWhrQVRl?=
 =?utf-8?B?c21CRWh1ODRWMlFLUVRNczNGUE9BS1dYK2c0dFI2bFE2VmhMM2R6T0xVYWNO?=
 =?utf-8?B?SEZ0UlIyd3VhVEVQL0VpSTJBSGlSOWpyRGF1K1ZXaHNtdThMZnNGc2R5d0dH?=
 =?utf-8?B?QWpFdDVuaEo0VjZWeVRqd1ZLK3BKYllZY082dm5kbXRGNHVWbS9XUGpDbng5?=
 =?utf-8?B?Q1FsdEI4c1VwaHI0a3BkUW1PeS90NHNtTTBHeUx0bHJWck9hTTR3RDRGNE95?=
 =?utf-8?B?d2w2RnRUaldkcExSaFE3bGpHdjc2SUkyQ1cwbmFSRGJ6MnNmcDFpaVVxc21o?=
 =?utf-8?B?SjVMWCtSMHo0ZmN0NFd3ZVg5TGtPRnNoZWhBT2VabXhEd25CajVHUkNYbTJZ?=
 =?utf-8?B?QllSSytrOW9ERm8zNGdJSlg3ZCtOSGpXUlR0WHA0RUZZWkJUamlSOWlyREs0?=
 =?utf-8?B?UXZFcE1YT2N4RjF4cFVLRURIZHgvd1VqM0I4OXNsZUVzV0tLaEJBcytCQkt6?=
 =?utf-8?B?a2RNcmhNK3llQkRSanFqekFCTFdIaTluSzhTSVgvZjhSdVBxTTBsUGNGVFU5?=
 =?utf-8?B?bDRUTXZuUDIxMUFpME82aG1hWktITFp3QlhrRzNJZXJwVndmdmlnMEJpUVVV?=
 =?utf-8?B?YVZKVkJQZUhPby9YRUJnd2g5aXYwY3hsRWdZcGEyRkM5bE5aemU3emlZTU5x?=
 =?utf-8?B?cGZPbTV2QW5hUUlydWd1bTlRaStwaDQxL1J2VDF1ODkramIyWThXZ3lyVG5t?=
 =?utf-8?B?UkJQcTJrYXVyRzNFZ01TN2x3UTVmVE1zZGNpdklwT2xwT1BIRUtGOU1XSGZs?=
 =?utf-8?B?RnlwT0NtbXN2SmZwS1RONEJyQVFJRmwzRVhsMytNK3dMSVh3K1Z3Q2pXN1Rr?=
 =?utf-8?B?WGV2YXVpbTJWN2VlR1VTRllUZ3ZSdzg5SXZnbXVtZk5sb0xWZnlQK3lwUnVK?=
 =?utf-8?B?enN4Z2cwYWVUaGE0WTdHOXFiNXRpNkpTZVJnWDNMSWdCY01NUnJ6OTZ0MlRJ?=
 =?utf-8?B?eGlaMTRBUUdVSTd5Vi95MjFycDFWTitjSTAyUC9meDVvY1dsRjJLWCttdFRj?=
 =?utf-8?B?eEUwZVFndjVQZGtWek5IY0lST3lKd1U1c0hkKy81WXZkRDlCTm5LbW04dWFF?=
 =?utf-8?B?cG40c0FCNjdsempEbjVzZjRVVmE1MHdmTWVMbWx1bmhTQkNFSnVyRVJaaFE1?=
 =?utf-8?B?TEtCZHF2aXJNZmt6bFhBcktzSEFKTlJORHJHL0cxcy9OcUQyLzg4Z25wNVB4?=
 =?utf-8?B?cmZtVC85cWVUb1dlQTJyd1M1Nm1qTG4xS1UzOU0yK0N3SEZGcUp2ODBsVjJO?=
 =?utf-8?B?OEJ2ZGRwNnllY2lUSnhMblRjOVhkR29FSXhXWmdueVQzeXVLUlZLTDZtQ0Na?=
 =?utf-8?B?N1JYK0tLZDRoTldqQTQrV09PRWdWZkJSRHI3ZFpSVkptYXZkbjZtZ01XWmxa?=
 =?utf-8?B?NjZ6SjM4K3hHR2RST3VtQVZKL3lNNjNWcHh1emppRmVXQkNNWE12dTA2djFr?=
 =?utf-8?B?NUlxaWZ6aTlvdW1GZ3FpN2F5ZXM5c0hTWEMxMk91YktYM2MwaWJKS3dMbERm?=
 =?utf-8?B?S0trUEhueEp0STZhdG02S3FLL3llUDZlMTdRRytndlFqbEtlenlnQXJOdnVB?=
 =?utf-8?B?T291cXBwRVZWSit6Wm5kVEhTVG9DSTJFY2hxT01Vd3FLWmRzSFBhaXVNR1R6?=
 =?utf-8?B?WjJOcDZsc0k5YU5KNkdmY01aeUozQy9tVktxQ1lpYUNBZ2pXQXBMd0M3NHVU?=
 =?utf-8?B?cmV2cnRMOHRUQ3BYdXBHVWZobEJubGJyS2hlb2dmc2ZFY29sMTlRS2J4RnpK?=
 =?utf-8?B?NUNZbXpGYm11cDdzYitSbVBUNmhjM0VxOW5ma3VmRitzcEdReS82bUFYTHUv?=
 =?utf-8?B?aW1IUTBxQ2QrcjRqU3JBTmNTcDZ3NlJZK3NqblVZUHRsUkpVTXByTzR1VHkr?=
 =?utf-8?B?cGxPKzdXZFE3RkdaVkVLWmdnLy8yTDZzTWdGTnRxbTRPWFhBWkVNTU43WkFu?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8064d7-8011-450b-2715-08dcdc1f47aa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 22:30:08.5335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOkAJzTQ0z30lroXq59HbyUo//5R903YLqvBoe2Yd5mRGp50kC0PrOCvOJMhhhtqVPOPJagHolxfnAu9uQxaZSD+PifFTd6/idVK4Wgid6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5277
X-OriginatorOrg: intel.com

Hi Babu,

On 9/23/24 1:21 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 9/19/24 12:08, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>> +/*
>>> + * ABMC counters can be configured by writing to L3_QOS_ABMC_CFG.
>>> + * @bw_type		: Bandwidth configuration(supported by BMEC)
>>> + *			  tracked by the @cntr_id.
>>> + * @bw_src		: Bandwidth source (RMID or CLOSID).
>>> + * @reserved1		: Reserved.
>>> + * @is_clos		: @bw_src field is a CLOSID (not an RMID).
>>> + * @cntr_id		: Counter identifier.
>>> + * @reserved		: Reserved.
>>> + * @cntr_en		: Tracking enable bit.
>>> + * @cfg_en		: Configuration enable bit.
>>> + *
>>> + * Configuration and tracking:
>>> + * CfgEn=1,CtrEn=0 : Configure CtrID and but no tracking the events yet.
>>> + * CfgEn=1,CtrEn=1 : Configure CtrID and start tracking events.
>>
>> Thanks for moving the text ... could it now be made to match the new (outside
>> AMD arch document) destination? For example, "CfgEn" becomes "@cfg_en",
> 
> Sure. Will do.
> 
>> "CtrID" becomes "@cntr_id" etc. Also please fix language, for example
>> what does "and but no tracking the events yet" mean? So far this work
>> has focused on "counting" vs "not counting" events and it is not
> 
> I will change the text to "not counting".  Hope this will clarify here.
> 
>> clear how this "tracking" fits it ... this seems to be the hardware
>> view that means "tracking the RMID to which @cntr_id is assigned"?
>> Please help readers to understand how the implementation is supported
>> by the hardware.
> 
> I have checked with hw team on this.
> CfgEn: This corresponds counter assignment.

To be specific this corresponds to *hardware* counter assignment? This is
because software sets CfgEn to 1 whether it is assigned from kernel perspective
or not.

Actually ... when I look at the AMD spec it becomes more clear to me. If I
understand the spec correctly the CfgEn bit is used to coordinate changes
between OS and HW. Seems like OS can leisurely write to any fields of
L3_QOS_ABMC_CFG, but only when CfgEn bit is set will the actual hardware
configuration be performed.

> CtrEn: This is to start or stop counting.
>        We always set this to 1 to start counting.

Understood. Now that I read this portion of AMD spec it is more clear to me
and I understand why CfgEn is set in both counter assign and unassign.

Reinette

