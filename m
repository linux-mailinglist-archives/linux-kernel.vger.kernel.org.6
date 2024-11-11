Return-Path: <linux-kernel+bounces-403637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C82519C3860
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586F41F22036
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 06:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25C015533B;
	Mon, 11 Nov 2024 06:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AygZ7RE4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD1B13BC02;
	Mon, 11 Nov 2024 06:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731306715; cv=fail; b=h2fkxmXS00vpiUIHMxoMpJ2/qzdxUNNBkqDgGTODxnzXpbg55I/NVRhVP0FGkQxIcrchdKN5eJufMKxEUp1tyuDcl2zoW0v3Rh7YO7KcnFOcmVPw21wM7prHlC0EECFxTtD7ekNIBzCLEnmigaQhN5tQ2/N+BLTM+s/pDZsrig8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731306715; c=relaxed/simple;
	bh=lA5Wqox7d5AJ4z4qp0ZgCkm9PT8HRzqm2y/9ai1FOEU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eT7fvZiChKMh1OL2H61UaZZGdRhWjrJkuPrEuDw9VJ+vv2iMY9Bfx/FOTSsnKOZr9Jjki21pRprbU2p/lsClaHrgGFEEbvlEetxQnbOHZHuKLiHQ5o2bQLGL1FgOZLkZsnHGY3iAW68UQmnBzqk7x5rXxOm2lxPpgmG4QzZVuLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AygZ7RE4; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731306714; x=1762842714;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lA5Wqox7d5AJ4z4qp0ZgCkm9PT8HRzqm2y/9ai1FOEU=;
  b=AygZ7RE4E9728sfizIKJ+Zzobxi5fClijIuG41SCf8xx4LPCsQbncPYA
   y2k6GzI7EleJ7GHuBhTJBWbHrAFaEWeFcNwOhnpZYYkg0C6X+KVpkxNDo
   TDVM53hZesPkkldX0sCEsbRglY5ZMEk8xz7lvrPcr+dwD+BRDXmnY6pB/
   L+3vRw4e2vodxRSaPqdDqKpXFARFebFz4nRwZHRzTqD+DkcOQXnYVqJmJ
   lpADFFxWtqNOn24SKbkmtHA1z0NRZL7c0Vr1Hl2b/41MIoxNVmUdAg3GO
   e2DkYmPQRSUBPwPtOvlV1K5Tr7esu0exnH9lvwrRcvWUufduH9bBAw6ob
   g==;
X-CSE-ConnectionGUID: K7OvShFJRwCd2EdGJYC7TQ==
X-CSE-MsgGUID: ADa+zzPpQeyrztrIHMbv1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41664255"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41664255"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:31:54 -0800
X-CSE-ConnectionGUID: FleAWCP+RqaSJIO+p1xjZQ==
X-CSE-MsgGUID: PpIRFOL8RPiC08WY92efyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="86505690"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Nov 2024 22:31:53 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 10 Nov 2024 22:31:52 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 10 Nov 2024 22:31:52 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 10 Nov 2024 22:31:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KA62KnJ31wRiS/cDy1SPkhhLFR3AkX3yCyXxLxtrdU2Pq1jShFn0gcEKz9dscFHDvYZM6ZzgI6vdEkNEenZEV3gI606Iud3rgZ4VBF1aOZ/X1ZL19aA6EN9UvWvN1l1irKacNIhcQPZJakn4o1Y+hmMd5wVv9uXQFpTq90p1mhT4eLkaqnarVB+hmAtYcja4y/iSNobu3maN5Q4bC2AzQCONsRPpFTcrbM1g/U3BbMnG/HPKHw+kZ4tR/yZuFQGkBeUd6kKP1EIcCdfXXALeUKp5YoR1zN8oH/xSk5VxnGHt5ZZf0FyDz51rrxsgKAGNO1XgbgngKHWrqkGjDuUu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lA5Wqox7d5AJ4z4qp0ZgCkm9PT8HRzqm2y/9ai1FOEU=;
 b=jDsncaZDkM3g/HL1Y41vna3JK8Xx2qQ7u6BRGdQIcX2LFje1TVWbS6MQdDUQ7H99SJG18y4+SPfM9n4Ogc775tFALKpBg2oIdegp9/lP04i2IbXeFqWmz2ahLoWUZUDzDkeC984PQgPF7MdMXI/wRRlsOnPeQ06iF8rakmklzxHFN3FeEc5Qj+ffTVZFe95JgRSJm9/3yECIsVJ/PxE0xMsEryxs9f/uuFwkZlLTAyBFNXAqMESITPvyoxDTUsdQsZ43UByx2cnK6++6iblAC2OOe59j+AUnhs2SzbRsuROLu/nzapEl6pwePlu3Sh+u6UMoNzQZNUXA3Y0b+FtF/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by PH7PR11MB7552.namprd11.prod.outlook.com (2603:10b6:510:26a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 06:31:49 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::cbbd:ed55:576c:fd55]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::cbbd:ed55:576c:fd55%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 06:31:49 +0000
From: "Xu, Even" <even.xu@intel.com>
To: "Aaron, Ma" <aaron.ma@canonical.com>
CC: "bentiss@kernel.org" <bentiss@kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "jikos@kernel.org" <jikos@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-input@vger.kernel.or" <linux-input@vger.kernel.or>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui1"
	<rui1.zhang@intel.com>, "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "Sun, Xinpeng" <xinpeng.sun@intel.com>
Subject: RE: [PATCH v1 04/22] HID: intel-thc-hid: intel-thc: Add THC PIO
 operation APIs
Thread-Topic: [PATCH v1 04/22] HID: intel-thc-hid: intel-thc: Add THC PIO
 operation APIs
Thread-Index: AQHbJexOlqStX2GM7kymeEIvMWZKNLKxt2GAgAACx0A=
Date: Mon, 11 Nov 2024 06:31:48 +0000
Message-ID: <IA1PR11MB6098D581A332E576528FD30DF4582@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20241024081023.1468951-5-even.xu@intel.com>
 <da650a93-6d21-444b-adb7-045566f53d5a@canonical.com>
In-Reply-To: <da650a93-6d21-444b-adb7-045566f53d5a@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|PH7PR11MB7552:EE_
x-ms-office365-filtering-correlation-id: c957c745-cdcc-4ac3-f8c6-08dd021a8593
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZU1hMWtxNGxjRzViWGZnYk9EV0prQnBrWkpjdEVZQkVGaHR5aHY2Wlc1MVhX?=
 =?utf-8?B?SWF2anpCbmVJbjM4NEJVQk9JZDNQMUJPODEza2h3Wm5kSXdnaHI0ODBlRG93?=
 =?utf-8?B?UHRERUlVNnBUaFk1N1YwYnJDRFJSaXliME40WjVKMURaOVk2WUtBR0N0MG9S?=
 =?utf-8?B?dCtWRi9NaG1CZGZ0dzlETWZuT2thbEZxUDNHYzdkTVRNREJrOUs1dXVpRFc5?=
 =?utf-8?B?TFEyVmZhbElUM3F5UkI2dkhSNnZtYm9pNFl2TENRTDRFazN1SU5hcmFkNFVB?=
 =?utf-8?B?TW1lUkI5VFhHVE9WRWF2bkZuT25VTFFreVV5b292U0VkQkpPaklCZzdoaXkw?=
 =?utf-8?B?QWZ1RzI4Tld5ellYaVZOL05VanI2Yk0rb1BIaFc0OHFod1NDSVB5dzNUellL?=
 =?utf-8?B?LzZJTzhtNjYvMXRJU3dlQVF1SXJlNU5WaGUzUGNlUVNSbFpsWTRGNmhXRHNU?=
 =?utf-8?B?cmQvcFV5TS9hbkI5U0RLVVNzNXh5RVI0NEdPNUUzUk9sbnU0eFZGZldOckpI?=
 =?utf-8?B?OUswS2VuTHd2Z2krZTk1eEMwV2Vkc3lzbFFiK3RaYXVtMXdBTkVldHE1dUFH?=
 =?utf-8?B?UTFiUnNuMDVsSERGeTNkc3lTZGJrTlRlanpRc0RuVGQ0emQ3aXRsdThSVGpN?=
 =?utf-8?B?K21qejFHZ0VkWnRZZkZ2OUNqaDJoVG1YR25GR0V0N2NnWG1uN1Vvc0lPaFlE?=
 =?utf-8?B?RXRCeStkSUgzbi91R2duYU5UWnl3a0s3dGVpWStscDNjOTgzYmN6NTR1ZGM3?=
 =?utf-8?B?QmNlR21pL3grSTd1RXk2c2Q2OWQ3T0lGWlNDVnJmdVdhZ0wzV2hKR1ljeFJJ?=
 =?utf-8?B?UE1GTVg2SUx1eTdkN1JNaDg0SmMwM25ZTFQ2T25VdUpsa2p5WGIzYUViMmdi?=
 =?utf-8?B?MDMwZGRvNTl1MFd1UTkrKyt0MktWWjNKdnk2ZEFSdUdqVFBNQVZZT1dQbXRJ?=
 =?utf-8?B?aEE1dXNlem5SUFBQN3ZRMmNONDV3STV3Sm1UU29kZnJQK0F1ZFNyRmZlY3FZ?=
 =?utf-8?B?V3gvVWtpSWdvbVYvdzJwM3cwVXVoZ2lFWG9NWlRoQ01VTndXZVNoVmRwZ3F5?=
 =?utf-8?B?c2xyRUdLd3gzQ1owTGlRN2IyRGdWcXVoc1dBNGZyU3JXeHVFaVI1b3BjWDJq?=
 =?utf-8?B?RCswSEpWR3V6TEZqQVFHeFUxdzlnWm1iYnI0TEZER1RVY0w5eUZiTzEzMktQ?=
 =?utf-8?B?TllLdXJOSSt0ckhqVkxXTG9OeGp4SnVaYTlDbUxuQmh4cXJBcmRQbDBTbVg2?=
 =?utf-8?B?N1JLZXdkTDVMQVZqcmhUem9zcStXVU9GcElSNGh4UGZ0b0o0RUM5UERlK0FF?=
 =?utf-8?B?cGFHaVpDanR5K3NoS283SHdrSmU2OE5STG9Rb28zZWY3K0ZVbFpNRGZLZXQ3?=
 =?utf-8?B?Q3NVeURjSlNVelFWWkN3VStycTJGdmxkTlVvVHNDMkFsOWFFNXF0MHkvM2Y3?=
 =?utf-8?B?Slo5ejByMVM3NWlrVFV4dEZCb3RKVzlUK2Vtd2VmR3NoaSs3RllUSkpjbGc1?=
 =?utf-8?B?YkF5dUIzVkRlZWtpWmNVcUlaQVFFRnF3MWVTK1NjeHF2M1dQL0grSnVpN0Iz?=
 =?utf-8?B?dnVLNFY3dWJzaU1nVk1ENEZtNHBWSkQ3UDZRRGNZNWc5YmNXZENyQWdDbk10?=
 =?utf-8?B?Y2xkaVFEU3dMZUJneEM3a1R6akxxa21xUU9mUG5mLzMvYzRQQittZmVOMnB4?=
 =?utf-8?B?Sm12TmFRU2k3SzFuYjl4VDBPa09UTnZQOWZKWjlTODNqSXRWZ3dFL2ZpdVFv?=
 =?utf-8?B?eURuTFdKbk9BODhGbFBPdHE3N3lmL3d4TE0vSzk1QURVVGdPS01NOGNwaTdu?=
 =?utf-8?Q?Gy0kiodqIJJFMbsxnaqFR3ML3IgrwOzrU/Sk0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFhjVmhiU29pVHI3Um9Xb2s5OVhCUlkrSVBJZlJ1c3N4NUJRUFBQRW1DY0Ja?=
 =?utf-8?B?VTJsT1VKS1phT24xV2plV0laNy9SYUI3cklyVGx5ZTREZE5LS1Y5R3ZqcVF0?=
 =?utf-8?B?RzNlNU01cnU2YUVUYnpjQnlZVTB1SUYvemZ0SnhWcVBUcDVmRmYycEEvODJ4?=
 =?utf-8?B?Y0pEUUdkcmNBMVVoYXBnbDdBMzByaXRNWk9FenZhMkVsZTBHVTVNNWNZVEpn?=
 =?utf-8?B?cStId1RBQ0hnMTBjY3k2TzhVZnkveU1YYmVpR3J4NEhIeDE1MW5rQ1ZyT2lj?=
 =?utf-8?B?RlR6bEUvcXI4SmVKenh2WHM2WUtsQ3FyR0VyZ1pWR2RVcVREVWFnczFTUEhp?=
 =?utf-8?B?OTZ3dmNLWUdTUDllSTRuNElVR3o5WkpJT0YzWkx1MDkxUXJnWm94TUsrWnow?=
 =?utf-8?B?RHIyWTJqL2JGMmNIY2lkakpEY1hGL1BZbzZRNXZ3c1Y2elNXenVVNG5XWVo1?=
 =?utf-8?B?WDVYRmNma2hNMEtTUmV1OHNpK1BXa1dhdTRTQURGRkJ1NUhTRFU4QWxMaGdY?=
 =?utf-8?B?ckFUalVING40Y0J0UHRVRUR1YUVlUVBTSkMwNzJIUXBpKzViSmxKM2hzTktT?=
 =?utf-8?B?eHM4ZThjMjRWZE55U0Z4aGdkK25zNW9JY0d5U2ZrekJyOWxOanU0L1pRV2hS?=
 =?utf-8?B?RVArWnNVUVdMMStNZFRzKys4WTh2Z0RCbG1FM1VFZmJ2ck11Q2ZDQ0oyOTl5?=
 =?utf-8?B?eDRwRXoxeEtrVUtWN3k4OE1uWFc3QWZ3ZDl6d1N2c2JmK0FIYjVFUmJPRGFT?=
 =?utf-8?B?ckU3UGVtVUVHTkJuQlNkTkkyb09ZTkVCd2xyRFR3WlVrR1dqSjBvUWVERkw0?=
 =?utf-8?B?N3lpMkNOTmFaeVp1MG1jUFlheHhwL1E0YjFqRVhvVlhvL25Hd25UNkJhVDhD?=
 =?utf-8?B?TldUUDdIZkFiTzFDaDIyUnRhbWVRdHl1cWhNck9NamlLUXR2Ym1JRjlKR1hZ?=
 =?utf-8?B?c0RURjdHSjNuMUxKMlF6anZ0NzZwZVcrdFFxckdhYTZ0bE9lZkVxVEZzbGtP?=
 =?utf-8?B?ZDgzZncrQkUvRHI2V0hZMHk3MEY4blZFM3RkKy9YWHRELzhIOXVUdFNKVDlm?=
 =?utf-8?B?aGpNUG1YTFo1RmNpcTA0dVVTQVlVZ1lDWVRTcEtYOFdoRDN5STlKTHVvNWtt?=
 =?utf-8?B?TStjaGo3TnVNbVZtVDd2UE9zejJ5Y29VSTdaZDArZmtUQjk4SFVjcDJVUFVs?=
 =?utf-8?B?Y05uZGtpSGZ4K0N0aWkyd2M5TG45Yk4rWjNPazhmaS96ejRUOHVSRWRJeFFW?=
 =?utf-8?B?Y09yb1FHNklQTi9EalhJRzJEVTRzRlNlckh6QnFwS2U0a0FadW9EbFd2WVFL?=
 =?utf-8?B?NG00a0ZNZldGRVNEeG43V2Z1amJYV2RmWHhxTmNUTDZFQytQQ2lUdnkzV0RP?=
 =?utf-8?B?SXNDUWkxcFpxMWR3QjJvK3VScVVjclBRZ3BtU0Z6WXlJQk5salpkbWZ3SHRM?=
 =?utf-8?B?Q0wwNjh4SkwyWk1CSGR2RGVIRE5ya2NFaXlSUDZUVWxVZ085c3loVGh1ejBO?=
 =?utf-8?B?OERaYVB0VElVNUdLQVY1UzVpd3ZvcHVaUnVIQ3lFSnBCTkxUd3M2dEpyT1JE?=
 =?utf-8?B?VCsyc1BzQUY4YVFadk85OE95ZmM4dXFQWStYaThTZ0xNV1FYeURxMGR1QWFs?=
 =?utf-8?B?cHdJUlhGa0E2aWpXSXZoMnBzUkc4L011U01ZdXllblZXTmxJREl0M0FUYkN5?=
 =?utf-8?B?SGx0U3dob08zYkU0Y3owbGkzT3AxZHdiRHdBSWdKUkc2ZXk0Z2RESnRnbDRS?=
 =?utf-8?B?MmtIQnZyVDZ1Rm5yTjRKNXZOZkNDbjMwcTNMbThVbSttNDRtK0JOZVVBN09S?=
 =?utf-8?B?dVg2L01TWFgyTmFUU3QxTlZtN1FDRmxVTXZ1SFRsLyszby9ieng5bzFkVmpn?=
 =?utf-8?B?YjdRYnpYNTc5KzZqU0YrREpzTEtyYm80NDREQ1ZtQU12ZUdoYU9oOS9SQWlH?=
 =?utf-8?B?NUtaczV6YUpLVXJTcGtpTDdUdDhLU3RXQzMwdzF1NjNTbzUrbGh5MFlmbnBF?=
 =?utf-8?B?b0c2VWpxV0dzSDY3ZzZnN3FSTFM4dFU0eXlOOVpSMjNyZi9zZVozajgwMjRr?=
 =?utf-8?B?TXlYVnBXYmdDaXVoVThqK0FwcG1WSWFuZTh0ckJMbDZHYnZHWmpKN3dZanNn?=
 =?utf-8?Q?V1uQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c957c745-cdcc-4ac3-f8c6-08dd021a8593
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 06:31:48.9656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xNdUd4VSXBs/yRRRwKr9LBxy3RnyQMxkuyy/0jikvW3TP2JqNfQVHxLfe6+crP1SRQamatGS6m7pFatOF+3R9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7552
X-OriginatorOrg: intel.com

SGksIEFhcm9uLA0KDQpUaGFua3MgZm9yIHRoZSBpbmZvcm1hdGlvbi4NClRoZSBmaWxlICJpbnRl
bC10aGMtaHcuaCIgc2hvdWxkIGJlIHRoZXJlLCBpdCB3YXMgYWRkZWQgYnkgIltQQVRDSCB2MSAw
My8yMl0gSElEOiBpbnRlbC10aGMtaGlkOiBpbnRlbC10aGM6IEFkZCBUSEMgcmVnaXN0ZXJzIGRl
ZmluaXRpb24iLg0KSSB0ZXN0ZWQgaXQgb24gdjYuMTEuDQpBbnl3YXksIGxldCBtZSBkb3VibGUg
Y2hlY2sgd2hhdCdzIHdyb25nIGFuZCBjb21lIGJhY2sgdG8geW91Lg0KVGhhbmtzIQ0KDQpCZXN0
IFJlZ2FyZHMsDQpFdmVuIFh1IA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IEFhcm9uIE1hIDxhYXJvbi5tYUBjYW5vbmljYWwuY29tPg0KPiBTZW50OiBNb25kYXksIE5v
dmVtYmVyIDExLCAyMDI0IDI6MTkgUE0NCj4gVG86IFh1LCBFdmVuIDxldmVuLnh1QGludGVsLmNv
bT4NCj4gQ2M6IGJlbnRpc3NAa2VybmVsLm9yZzsgY29yYmV0QGx3bi5uZXQ7IGppa29zQGtlcm5l
bC5vcmc7IGxpbnV4LQ0KPiBkb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1pbnB1dEB2Z2VyLmtl
cm5lbC5vcjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gWmhhbmcsIFJ1aTEgPHJ1
aTEuemhhbmdAaW50ZWwuY29tPjsgc3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb207
IFN1biwNCj4gWGlucGVuZyA8eGlucGVuZy5zdW5AaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYxIDA0LzIyXSBISUQ6IGludGVsLXRoYy1oaWQ6IGludGVsLXRoYzogQWRkIFRIQyBQ
SU8gb3BlcmF0aW9uDQo+IEFQSXMNCj4gDQo+IEhpIEV2ZW4sDQo+IA0KPiBJdCBmYWlscyB0byBi
ZSBhcHBsaWVkIG9uIHY2LjEyLXJjNy4NCj4gDQo+IFRoZXJlIGlzIG5vIGZpbGUgaW50ZWwtdGhj
LWh3LmguDQo+IA0KPiBSZWdhcmRzLA0KPiBBYXJvbg0K

