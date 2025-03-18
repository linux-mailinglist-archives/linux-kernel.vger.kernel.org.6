Return-Path: <linux-kernel+bounces-565411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68A1A667A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2EA9189C882
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6AE1DE4C9;
	Tue, 18 Mar 2025 03:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPsHcO8p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB21A8409
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269339; cv=fail; b=R0DJxZYNiNp89h2kN5ZiLoDsCa8czwCWaGvfoiFzUx19m7YeQRa2Qev9D+bctperMbrHAyAy0NXmNGvNjxWYKfFDBey50o8cQyVSp3BrCBmnV80FWLUMDt239Cutuqz4uyndY2kA+QG9wtWbomTHPdhCaV3r6O4i0xnGv5xi/Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269339; c=relaxed/simple;
	bh=V6FSxywCcBv/pw9DrZ3tPHoJIogWr8iPE3XoSJzTdCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i4MC6IkROIDJfxDueSG8iubgf4t2ZAcd7ffbOfn03aHcGlXCM0cCPbj/kmW9EnKhpZAocTkw798HxHlj7E/zSI+PI2GJy/qyzM3trYRsjSoaD3Mld8zwKNQZ7FiBpluygDJL0D80IHW7QAUh2CcYPOr1hX8NpFKJFoFpZo8GP2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPsHcO8p; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742269337; x=1773805337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V6FSxywCcBv/pw9DrZ3tPHoJIogWr8iPE3XoSJzTdCs=;
  b=YPsHcO8pcRIa07x1HGvtfHoxSthZiD+HUrM9xIJy0KVpjt9SKV6reOP/
   G8dZaQ4Tbs5EqOTWQ0v7ZxgJKjpTAK1rO5+Myo3pzS29mghGl8I2JiMcM
   /PEuyYKRTAqD0pXLOBF+ZRlrIw8pCb44juxH6hW0/yp0Gzy9EX7XeW67H
   AMEZA3OHUjUQPwO1C4dqgUW134BAOgA4eyv6xZ2h1SQHUaYBaU4cVZfuD
   wZ3F3BoqajHEObP1NPD8JQrVG7GvrDG3mI5/+2u7uOWWvNiJzROROxDUF
   QRY+WvNDLaAXbP6Qj7AFfWPW82btvgPZ5wLDbcerJxh7cDqv4fzYpziYf
   g==;
X-CSE-ConnectionGUID: CmehEKHpTXK28rYLWhpS2Q==
X-CSE-MsgGUID: G6yFDa0bQOO2YcWV9ab9aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43581601"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="43581601"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 20:42:14 -0700
X-CSE-ConnectionGUID: czLAu8ETQRKVifW9jRzI9g==
X-CSE-MsgGUID: Yi+yYX/0TWqYRI+/8uebSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="122152819"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 20:42:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 20:42:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 20:42:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 20:42:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnhJqpJ+ZdnHhk8V41HaShgCub1MS2O5Rak+t0mPd0+GrP9y6mhl5AdaXXyfmlf35QATvdH2YokGQVZFEsjhgBmhdjojVoeZa1Y2njYo+uv8k9GD/0UezekRCSLTTzLCSy+7ubiC3fQAQP7A86nhYGmafW5h/09fJimfJMh4JB6zO1LVKqngAnxrMpCTMrSiz6vI4saIQHgCRTseBsvztbLYuOriKvN+Wwgi2D4Uv2KM+3FEB/92oXIstQrStPWU2uL6LlUr3SexgVytVd1iUYRldjOaZOSKWo0NCLm4UwwEDi1IgnyXUPj+T7BifgpXVgvQhZUx1Q6hG6itMQKDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6FSxywCcBv/pw9DrZ3tPHoJIogWr8iPE3XoSJzTdCs=;
 b=xHpT2BWUofkaNpiyh7s55pQMPSOxyePeMKJo4XouBlelgUgImj6hwQeYI7UAueBTAJxqJb8oL/ftDU3R5mMlzkQowfEAeDRnInJTSDrOze3Az+8rAoqSYagot5jpC6mrv0rElDed4uyfOS0po0ByCwvpSoq+1Mij1EI+lr24EOAh4PWIxS9YLd4r4ooHSzlvXH/OeIE2CLEr28wMAh9fq4JZC6R4+OIpFins4ciFK+eAKw6m+2VCBfHS6yX4a4pwOfnoFbawfPfZsLALfq6+BAPPYxkMsA+Is8JZo6PTUYWNZB0zJhE7t1lusCi1JcBt81qDuC8SKFJcxuOf+N1yRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CO1PR11MB5106.namprd11.prod.outlook.com (2603:10b6:303:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 03:41:56 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 03:41:56 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Huang, Kai" <kai.huang@intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "ashish.kalra@amd.com" <ashish.kalra@amd.com>, "dyoung@redhat.com"
	<dyoung@redhat.com>, "seanjc@google.com" <seanjc@google.com>,
	"x86@kernel.org" <x86@kernel.org>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>
Subject: Re: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Thread-Topic: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for
 bare-metal in stop_this_cpu()
Thread-Index: AQHbk0LE9xNDz/BUxUyAtvW7JgE+xLNxaCeAgAW7TQCAASVkgA==
Date: Tue, 18 Mar 2025 03:41:56 +0000
Message-ID: <23c990b979a5b46a5436279126565198ea985889.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
	 <e9ee3c7ffc3ba6feb97247faa40789684e39ffd0.1741778537.git.kai.huang@intel.com>
	 <e0d9a3d599025c92fce5e159e8acc1af32844912.camel@intel.com>
	 <324a342417a1455633d4646b4be199aa6d85509d.camel@intel.com>
In-Reply-To: <324a342417a1455633d4646b4be199aa6d85509d.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CO1PR11MB5106:EE_
x-ms-office365-filtering-correlation-id: 2da37351-e236-4817-9765-08dd65ced4ae
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MDhVNU91OUlwV1M2azE1SUhrTGg5MmFpL0dja095QllQN0pmc2luQUsyM3hC?=
 =?utf-8?B?NU1MSTN3Z0dsMzJ3OE1tQTl1Y2pzNzhkTFVBemRIdkVoeDN4dmhTd3A4Y1dy?=
 =?utf-8?B?NFVHWlBJWTZadFRPZnpCeDB6c2VJMFk4RnQ3Q0xKcUtGaUtkWFdqdnpTVUhw?=
 =?utf-8?B?OWZSekNwMUxhRHQybXdLWXZNTUx0d201dmtkU2pOdzdScUpiUjFRRGI0U3Q1?=
 =?utf-8?B?dmw5elBIM3RJRGZRM0JxR1I0NmdNaEU5WmlTSytHVEtydVd0OWtBVWJ4OWo2?=
 =?utf-8?B?RXlQVStPQ3p4akVNaUl2K2Zya251UVNnbFNNcjk2S1JvbG50cHdGdGhEMURE?=
 =?utf-8?B?ZkhjZ2lqQktKVnd1ckI3elNDbXkvRXlRQ1JkRTR4MGdLMGZVMlZ3ckJhS3Az?=
 =?utf-8?B?eWM2V0RSS1JhdjJybUU2Q0p3SlZEM2YrSTVOcWJoRHYzTythZGlMdVFScER4?=
 =?utf-8?B?LzNwSTZiQmVkb0ZXbVdtVEZxeFhGQzhQYmQ0VGE5aGZuRzBqUUNDanFIWWFs?=
 =?utf-8?B?bVhEQm43TTF6MUE4VHhFNGpNeTUwRXQ2aFFvMXFzeDJSc09aUjlZMW5hVUhh?=
 =?utf-8?B?N3RNTUhzK1F2QlA5bUx1OE9Ra0JQb3V4cWsxUWV6T0dNWlhkeFZ0SG1zRGhB?=
 =?utf-8?B?aytQN0d2cEk1ZzUwVzFVZ0ZOZWRKaVM0NGRreUt0c3J3UDlScUE1VUs1eVVH?=
 =?utf-8?B?aEROTVBlbFVhb2RmcUNGM3FXbUNOVlZVTlJ5WFJMMWJiZEZxN05lWVRoNVNF?=
 =?utf-8?B?K01vYWdDcVNYRW1IMXhjc01XZzEySHZ0VDAvT0c5TlNWSlp0S05SVmlhdG1D?=
 =?utf-8?B?U2g4OUNHajhyU3VFTE1TZVFmMU5Eb2h1RTRaMjd5N0lRUzJaSjRVak1oQkJN?=
 =?utf-8?B?aU5mWUF2c1Q5a241Mytkc1JaVGVNZ0x3bmpwYXVBK2VIdXIzYXNDbUJDTWlS?=
 =?utf-8?B?WTFIZUMwRlZ6UkxhTThGM2JWTktxRmh4Y0ZodUs2czdLcHZmYmhaMEswUUlE?=
 =?utf-8?B?d080MGNCeDZmeitkVnVqanpIWlh3ZGtmZ3QyckpMMGV0Z003QTVTZkQvcHM1?=
 =?utf-8?B?ckNrekZxZHNMRGxQZTA5NmNtUFplVTlSL2ZsbHpOaDBxMGFRZ2tINUVGN05Q?=
 =?utf-8?B?dFVlOEVzd29laWF4OVNWOXAzUmsxT0NuTnkzcFYzODV0QnNsMlQwMUhMVjVM?=
 =?utf-8?B?UU1oL0ZXQ25rdFhuRCtBdk8yb0FpdW1OTFhPTHUzM3hZT09EWDErYkFjSlRt?=
 =?utf-8?B?YlFFSFZCSW5TRDBrYVIvWDZ5RUhqTkJMN2EvYVZLSzIwYitrbkxPMW9qdysr?=
 =?utf-8?B?ZUV1U0h4WXlzcncvVTV1emxyNkNPZW1PNGliRXBJSEx2QUkyM1Uyb2dnZVl2?=
 =?utf-8?B?M1lGZ1BJbEEwamxmWitDbUxWdjdNbEZTY0lXbDdhTnJGSERXVjlOUlNkbmhp?=
 =?utf-8?B?NXh4QUtwMllHdFBCSGlxbnJBQmdpajdJclp3d1VjSjI4Z3oxK0Z5T1U1QWph?=
 =?utf-8?B?TWc1Q0oyejc0Zlk4MXpYR1Y5endvWU1XZm1hWDJNZkI0UDVUcmNZMkFwSWo3?=
 =?utf-8?B?TS9rMTEvUzNTTGQ5N01LaWxIbGFSVDdJMncrd2ozaFFSOUdrVHV0T1pZVlo5?=
 =?utf-8?B?ait3ZHNIRkRmM2IxRysyQW0xOUIzTXBwNFI1Y3FzZWZYOFVKbVl4akJWdlZs?=
 =?utf-8?B?U293bVozSDJzZER6QldDZlFYZmpjeGtqZU5tK2NsQ1VlZThielE0QWhxckp2?=
 =?utf-8?B?enFOZ3lvSW9yczZqQ0FmZC91L0VydkRheThwWk4reTN4WVM4VWNzYkJtQ1hr?=
 =?utf-8?B?RTNwUG15T29pSTZaU1VraG5UYkJIOTlNYmluQTBMY0VRRUF6VEJoNDNQUHdt?=
 =?utf-8?B?SzNwK1hUUnNrOE1ZN01mejFBVFROcW5JcHMrU3JtenNKdUQwQnVmamZDdlRO?=
 =?utf-8?B?WTRabU5QL29BbjRkdG5xSGJQR1EzdG1CV1A1RWp3b0xUa0NYNUZ4d3hPQkpl?=
 =?utf-8?B?L1RDakZWSEJ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEM2aWRuZWZYVmRURSt6bStiaDN2SGdzZ05mekRiUUdlVHdnRHpDMWJpdWNx?=
 =?utf-8?B?RjdpSWRrRGh4bW1FT2RMbTAvb0Y2bmlVZW5YSHpvd3FPRnJOYktCKzkxaXhh?=
 =?utf-8?B?djhSNVFYckt0ZURvZWZaSkljdXAwZ0pjb2lrOVR0VE9YMDRZOVBmVExZMWtx?=
 =?utf-8?B?Y3E0U25vQ2ZVNng2bW5UYVV6UnNhVnp3VTFXaDR0UXlOMW5haERjVEtpcXAw?=
 =?utf-8?B?L29EWTMycENYQ1BuQkp6RXlOTEpEYU9sVGRwbXRQQ2o1QkZ3cG9MdU85a09P?=
 =?utf-8?B?RitKNzBKRkxpclNnRjBVaUpLakpHYXNMSDU5SjNmeTR1ckM4dUxMaFdJWFdQ?=
 =?utf-8?B?YXZuakprQW1tYW4vTHBHaHJNbS9rK3Vzem9IdjcxbW8xQlFCYjRlOHdoZERy?=
 =?utf-8?B?emQxczFqZTJqRE1iQnZBNTJ6UVJZVHBWQ2xxYmJSTjdiUVU2ZUxmaFNrQTBo?=
 =?utf-8?B?ajkwb2ZrL0RKazRiMUFabFJueVc4eGo5VHU3aFgyS1RITVFSUTA3N001dC9l?=
 =?utf-8?B?cDBZREFUN2ZTcUVvWm9TSE5KaFJNNUZhNVZXOUhTTHBleWpRVWdZWW1HdTZr?=
 =?utf-8?B?dThFZG9rbGt0UGthME1QQW1JNVBJVnNGdzZkOXQ0RU5QTU1pdkx5ZFBqSnkx?=
 =?utf-8?B?TmtpSVpyZzFROVcrL0t2RnIvUWxaMW02dFk1MnlNalBzWHNDSzF3dE8vRi9I?=
 =?utf-8?B?ZktQYUV3cWVwWmlUZ3NSMkl3MjdMQ0pKcitOcnMrRnZTRm1DVGlXTEorenBI?=
 =?utf-8?B?bHcvUVJWZHNWb1pMZVUxdjJhTDVmTXdWbkt3SVZxSXdndlVObUJJS2N0dXJi?=
 =?utf-8?B?Qkh6WGdDandZdFpjR296U0VWN2hyOTg3NTZ4Zm5pY2FwTU1DeUVmZWVBUGpS?=
 =?utf-8?B?cXJlbmdUdzBKbElEd2tFUVRJalA4bS92eEFWWUVCSDltM0w2ZHFWLzVRSTRJ?=
 =?utf-8?B?QS9ocmJHVGRLNGpZOG5oMS9qb0thcjNQZ0JDTE1TYzIyS055RUVvNTlCVGFn?=
 =?utf-8?B?eU1LSnZ2QWtNNWtXL2NIaWNNK3JVTUJQa3BTSXlUdXBXYjRFeDRsRVR6c3Rx?=
 =?utf-8?B?SlR6YVkzMGdoeG85M05KeDlHNkF4aFdrazcvOXA2VGVyZDR0V0VwWG8vYzV0?=
 =?utf-8?B?QXlNVGJiTFNuYUtRZFVZbnlFWkhGR1MzMlMwYkR2RkFJQzh3YkNobUxrUlk2?=
 =?utf-8?B?OS8vU2RBTjI3VTl1OVc5czVrdTZYTlJYWkw5cWtYMHA5WHQrQW5ublNxWjlH?=
 =?utf-8?B?QmJKWk5GTG1QaC9XVDFDVEQrVmo3eDBmMlk0WGs1L3lnc3VlNG5qNWtzbERV?=
 =?utf-8?B?Y2ExN3JzQXBiUUdNZWcycVgxTnlLL2JxZmRmY1BwRnVGM1dGZFhJWlZCeXl6?=
 =?utf-8?B?ckk4M2dBSFZhOFRjKzlmMzE2aTBudE1XdVI4VXczRzhxSi9ManUvUC9XZlAz?=
 =?utf-8?B?eUMvR3BZRExxR0JhNFF4REU3SUVEeWJ2WTk2NzVyeEFWTWplRGZJaGhPWnVr?=
 =?utf-8?B?S2FhYjExbGlUbmhxamdEMWN5WlJveGltdU9QbWdRYWxZK3loMklBMldoTGdL?=
 =?utf-8?B?SllBNjZacW1vYjB0Ny9qYXN2Y0xLT3UySkV0R1RwSmdMZ0hnNTRqdUEvcVhv?=
 =?utf-8?B?NVlHUnU2ejlKaU5TZi9kNENyNGw2SlV6a0JGeTFsVXhzMHhPd3k3RXNrZzEy?=
 =?utf-8?B?N3hPM3BCYUFZbWFEdXBwZVh0UHNpbUEzQURua29yRFdXQ09MUHR6L3RhcXBB?=
 =?utf-8?B?T2pUUWVwaWxKSkxBcHIxS3lhMHJVNHpDQkpKVTBYU3phQWVCSGZRem5Jb0NP?=
 =?utf-8?B?aElNSk05d0FmdGQ3b1Z4U1hhVGZEbEFCNTUzdUpaRjJmaWM3OHJ1U25NUkd3?=
 =?utf-8?B?S1FjeVg4WldkZHJndFVnWFlSaktDanZVTzFxa3BTL2dlYW1UMEhSbUFRUTVS?=
 =?utf-8?B?MGFLSFZURkdCUDhsVnVvUDdiMU1KWnd1aG0xbGxQZHlCSm84SGpnQ3JJV3BN?=
 =?utf-8?B?QTB2akdOUjNNNCtKN1lHOWdIbGdLWDRWRTRNaG9Tb1ExZjNPbTJHL0l3clVl?=
 =?utf-8?B?Y2RZKzVobW5uOVdPRGNNaGc2NnBoRlRFN1ZUYUpZa3pGY2JxL0RNcVUyVHlY?=
 =?utf-8?B?UjdLYXRLZVVqVUR0MDNrVkZUTEp2L3dWd1JOOUQ4WmdXT0MzUGNBd1I2akhi?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <693617FE5EF8804D8E24E62029752C04@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da37351-e236-4817-9765-08dd65ced4ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 03:41:56.2262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rnc0EAdCgt0pRqDYz/LL4NbIHMMMGKbVr+XlL3Fx2q/tJ+RzAyfCM75UN9uX8MUq/ZJRiUHBvhZii1ZWirA8RRegnWC8fv1SXoqXOHPvDiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5106
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTAzLTE3IGF0IDEwOjExICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBUaHUsIDIwMjUtMDMtMTMgYXQgMTg6NDAgKzAwMDAsIEVkZ2Vjb21iZSwgUmljayBQIHdyb3Rl
Og0KPiA+IE9uIFRodSwgMjAyNS0wMy0xMyBhdCAwMDozNCArMTMwMCwgS2FpIEh1YW5nIHdyb3Rl
Og0KPiA+ID4gVEw7RFI6DQo+ID4gPiANCj4gPiA+IENoYW5nZSB0byBkbyB1bmNvbmRpdGlvbmFs
IFdCSU5WRCBpbiBzdG9wX3RoaXNfY3B1KCkgZm9yIGJhcmUgbWV0YWwgdG8NCj4gPiA+IGNvdmVy
IGtleGVjIHN1cHBvcnQgZm9yIGJvdGggQU1EIFNNRSBhbmQgSW50ZWwgVERYLsKgIFByZXZpb3Vz
bHkgdGhlcmUNCj4gPiA+IF93YXNfIHNvbWUgaXNzdWUgcHJldmVudGluZyBmcm9tIGRvaW5nIHNv
IGJ1dCBub3cgaXQgaGFzIGJlZW4gZml4ZWQuDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBeIEFkZGluZyAidGhlIGtlcm5lbCIg
aGVyZSB3b3VsZCByZWFkIGEgbGl0dGxlDQo+ID4gY2xlYW5lciB0byBtZS4NCj4gDQo+IE9LLg0K
PiANCj4gPiANCj4gPiANCj4gPiBXaGVuIEkgcmVhZCAic29tZSBpc3N1ZSIgSSBzdGFydCBhc3N1
bWluZyBpdCB3YXNuJ3QgZnVsbHkgZGVidWdnZWQgYW5kIGl0IGlzDQo+ID4gInNvbWUgaXNzdWUi
IHRoYXQgbm8gb25lIGtub3dzLiBCdXQgYmVsb3cgaXQgc291bmRzIGxpa2UgaXQgd2FzIHJvb3Qg
Y2F1c2VkLg0KPiANCj4gSSBhbSBub3Qgc3VyZSB3aGF0J3Mgd3Jvbmcgd2l0aCAic29tZSBpc3N1
ZSIuwqAgSSB1c2VkICJfd2FzXyIgdG8gY29udmV5IHRoaXMNCj4gaXNzdWUgd2FzIGZpeGVkICh0
aHVzIHJvb3QgY2F1c2VkKS7CoCBQZXJoYXBzIHRoZSAicm9vdCBjYXVzZWQiIHBhcnQgaXNuJ3Qg
Y2xlYXI/DQo+IEkgY2FuIGV4cGxpY2l0bHkgY2FsbCBpdCBvdXQuDQo+IA0KPiDCoCBQcmV2aW91
c2x5IHRoZXJlIF93YXNfIHNvbWUgaXNzdWUgcHJldmVudGluZyB0aGUga2VybmVsIGZyb20gZG9p
bmcgc28gYnV0wqANCj4gwqAgbm93wqBpdCBoYXMgYmVlbiByb290IGNhdXNlZCBhbmQgZml4ZWQu
IA0KDQpUaGUgcHJvYmxlbSBpcyB0aGUgcGhyYXNlICJzb21lIGlzc3VlIiBzb3VuZHMgbGlrZSB0
aGUgaXNzdWUgaXMgbm90IHVuZGVyc3Rvb2QuDQpZb3UgY291bGQganVzdCBjaGFuZ2UgaXQgdG8g
ImFuIGlzc3VlIi4gSSBkb24ndCBldmVuIHRoaW5rIHlvdSBuZWVkIHRoZSAiXyINCmFyb3VuZCAi
X3dhc18iLiBKdXN0ICJQcmV2aW91c2x5IHRoZXJlIHdhcyBhbiBpc3N1ZSBwcmV2ZW50aW5nIHRo
ZSBrZXJuZWwuLi4iIGlzDQptb3JlIHJlYXNzdXJpbmcuDQoNCg0KW3NuaXBdDQoNCj4gPiANCj4g
PiBJbnN0ZWFkIG9mIGEgcGxheS1ieS1wbGF5LCBpdCBtaWdodCBiZSBtb3JlIGluZm9ybWF0aXZl
IHRvIHN1bW1hcml6ZSB0aGUgZWRnZXMNCj4gPiBjb3ZlcmVkIGluIHRoaXMgaGlzdG9yeToNCj4g
DQo+IEkgdGhpbmsgdGhlIGFib3ZlIGlzIGFsc28gaW5mb3JtYXRpdmUuwqAgQm9yaXMgc3VnZ2Vz
dGVkIHRvIGtlZXAgdGhlIGRpc2N1c3Npb24NCj4gYXJvdW5kIHRob3NlIHJlbGV2YW50IGNvbW1p
dHMgaW4gdGhlIGNoYW5nZWxvZzoNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LWtlcm5lbC8yMDI0MDIyODExMDIwNy5HQ1pkOFNyOG1YSEEyS1RpTHpAZmF0X2NyYXRlLmxvY2Fs
Lw0KDQpTdW1tYXJ5OiBLaXJpbGwgc2F5cyBpdCdzIHRvbyB2ZXJib3NlLCBjYW4gYmUgZHJvcHBl
ZC4NCg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1rZXJuZWwvMjAyNDA0MTUxNzU5
MTIuR0FaaDFxOEdncFkzdHBKajVhQGZhdF9jcmF0ZS5sb2NhbC8NCg0KU3VtbWFyeTogQm9yaXMg
c2F5cyBub3QgdG8gZHJvcCBpdCBhbmQgaXQncyBvayB0byBiZSB2ZXJib3NlLg0KDQpCdXQgd2hh
dCBJJ20gc2F5aW5nIGlzIHRoYXQgdGhlIHNlY3Rpb24gZG9lc24ndCBzdW1tYXJpemUgdGhlIGlz
c3VlIHdlbGwuIEl0DQpqdXN0IGxpbmtzIHRvIGEgYnVuY2ggb2YgY29tbWl0cyBmb3IgdGhlIHJl
dmlld2VyIHRvIGdvIGZpZ3VyZSBpdCBvdXQNCnRoZW1zZWx2ZXMuIFNvIEkgdGhpbmsgZXhwbGFp
bmluZyB0aGUgdGFrZWF3YXlzIGluc3RlYWQgb2Ygb25seSBsaW5raW5nIHRvDQp0aHJlYWRzIHdv
dWxkbid0IGJlIG9iamVjdGlvbmFibGUuIFlvdSBkb24ndCBuZWVkIHRvIGRyb3AgdGhlIGNvbW1p
dCByZWZlcmVuY2VzLA0KanVzdCBkb24ndCBsZWF2ZSBzbyBtdWNoIGhvbWV3b3JrIGZvciB0aGUg
cmVhZGVyLg0KDQo+IA0KPiA+IMKgIC0gRG9uJ3QgZG8gYW55dGhpbmcgdGhhdCB3cml0ZXMgbWVt
b3J5IGJldHdlZW4gd2JpbnZkIGFuZCBuYXRpdmVfaGFsdCgpLiBUaGlzDQo+ID4gaW5jbHVkZXMg
ZnVuY3Rpb24gY2FsbHMgdGhhdCB0b3VjaCB0aGUgc3RhY2suDQo+IA0KPiBUaGlzIGlzIGEgcmVx
dWlyZW1lbnQgdG8gU01FLCBidXQgY2hhbmdpbmcgdG8gdW5jb25kaXRpb25hbCBXQklOVkQgb24g
YmFyZS1tZXRhbA0KPiBkb2Vzbid0IGNoYW5nZSB0aGlzIGJlaGF2aW91ci7CoCBXaGF0J3MgdGhl
IHB1cnBvc2Ugb2YgbWVudGlvbmluZyBoZXJlPw0KDQpUaGUgcHVycG9zZSBpcyB0byBoZWxwIHRo
ZSByZXZpZXdlciB1bmRlcnN0YW5kIHRoZSBkZWxpY2F0ZSBkZXNpZ24gb2YgdGhpcw0KZnVuY3Rp
b24gc28gdGhhdCB0aGV5IGNhbiBldmFsdWF0ZSB3aGV0aGVyIHRoZSBjaGFuZ2VzIHVwc2V0IGl0
Lg0KDQo+IA0KPiA+IMKgIC0gQXZvaWQgaXNzdWluZyB3YmludmQgb24gbXVsdGlwbGUgQ1BVcyBh
dCB0aGUgc2FtZSB0aW1lLiBBcyB0Z2x4IGltcGxpZXMgaXQgaXMNCj4gPiB0b28gZXhwZW5zaXZl
Lg0KPiANCj4gQm9yaXMgc3VnZ2VzdGVkIHRvIGRvIHVuY29uZGl0aW9uYWwgV0JJTlZELsKgIFRo
ZSB0ZXN0IGJ5IERhdmUgWW91bmcgYWxzbw0KPiBjb25maXJtcyB0aGVyZSB3YXMgbm8gaXNzdWUg
b24gdGhlIG9uY2UtcHJvYmxlbWF0aWMgcGxhdGZvcm1zOg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC9DQUx1K0FvU1prcTFrei14anZIa2t1SjNDNzFkMFNNNWliRUp1cmRnbWta
cVp2TnAyZFFAbWFpbC5nbWFpbC5jb20vDQoNCkknbSBub3Qgc3VyZSB3aGF0IHlvdXIgcG9pbnQg
aXMgaGVyZS4gVGhhdCB0aGVyZSBpcyBubyBpc3N1ZT8gVGhpcyBsb2cgcG9pbnRzIHRvDQphIGNv
bW1pdCB0aGF0IGNvbnRyYWRpY3RzIHRoZSBhc3NlcnRpb25zIGl0IGlzIG1ha2luZy4gRXNwZWNp
YWxseSBzaW5jZSB0bw0KdW5kZXJzdGFuZCB0aGlzIHBhcnQgb2YgdGhlIGxvZywgdGhlIHJldmll
d2VyIGlzIGdvaW5nIHRvIGhhdmUgdG8gcmVhZCB0aG9zZQ0KcmVmZXJlbmNlZCBjb21taXRzLCBk
b24ndCB5b3UgdGhpbmsgaXQncyBhIHByb2JsZW0/IEl0IGlzIG9wZW5pbmcgbmV3IGRvdWJ0cy4N
Cg0KPiANCj4gPiDCoCAtIERvbid0IHJhY2UgcmVib290IGJ5IHdhdGNoaW5nIGNwdW1hc2sgaW5z
dGVhZCBvZiBudW1fb25saW5lX2NwdXMoKS4gQnV0IHRoZXJlDQo+ID4gaXMgYSByYWNlIHN0aWxs
Lg0KPiA+IA0KPiA+IEhtbSwgb24gdGhlIGxhc3Qgb25lIHRnbHggc2F5czoNCj4gPiDCoMKgwqDC
oCBUaGUgY3B1bWFzayBjYW5ub3QgcGx1ZyBhbGwgaG9sZXMgZWl0aGVyLCBidXQgaXQncyBiZXR0
ZXIgdGhhbiBhIHJhdw0KPiA+IMKgwqDCoMKgIGNvdW50ZXIgYW5kIGFsbG93cyB0byByZXN0cmlj
dCB0aGUgTk1JIGZhbGxiYWNrIElQSSB0byBiZSBzZW50IG9ubHkgdGhlDQo+ID4gwqDCoMKgwqAg
Q1BVcyB3aGljaCBoYXZlIG5vdCByZXBvcnRlZCB3aXRoaW4gdGhlIHRpbWVvdXQgd2luZG93DQo+
ID4gDQo+ID4gQXJlIHdlIG9wZW5pbmcgdXAgbW9yZSBwbGF0Zm9ybXMgdG8gYSByYWNlIGJ5IHVu
Y29uZGl0aW9uYWxseSBkb2luZyB0aGUgd2JpbnZkPw0KPiA+IENhbiB3ZSBiZSBjbGFyaWZ5IHRo
YXQgbm90aGluZyBiYWQgaGFwcGVucyBpZiB3ZSBsb3NlIHRoZSByYWNlPyAoYW5kIGlzIGl0DQo+
ID4gdHJ1ZT8pDQo+IA0KPiBJSVVDIGluIG1vc3QgY2FzZXMgdGhlIFJFQk9PVCB2ZWN0b3Igd2ls
bCBqdXN0IGRvIHRoZSBqb2IsIHN0b3Bfb3RoZXJfY3B1cygpDQo+IHdvbid0IG5lZWQgdG8gc2Vu
ZCBOTUlzIHRodXMgSSBiZWxpZXZlIGluIG1vc3QgY2FzZXMgdGhpcyBzaG91bGRuJ3QgaW5jcmVh
c2UNCj4gcmFjZS4gwqANCj4gDQo+IEkgZG9uJ3Qga25vdyB3aGF0IGtpbmRhIHBsYXRmb3JtIHdp
bGwgbmVlZCBOTUkgdG8gc3RvcCByZW1vdGUgQ1BVcy7CoCBGb3INCj4gaW5zdGFuY2UsIEFGQUlD
VCBteSBTUFIgbWFjaGluZSB3aXRoIDE5MiBDUFVzIG5ldmVyIG5lZWRlZCB0byBzZW5kIE5NSSBp
biBteQ0KPiB0ZXN0aW5ncy4NCj4gDQo+IERhdmUgWW9uZyB0ZXN0ZWQgb24gdGhvc2Ugb25jZS1w
cm9ibGVtYXRpYyBwbGF0Zm9ybXMgYW5kIGRvaW5nIHVuY29uZGl0aW9uYWwNCj4gd2JpbnZkIHdh
cyBmaW5lLsKgIFRoaXMgcGF0Y2hzZXQgKGFsYmVpdCBub3QgdXBzdHJlYW1lZCkgaGFzIGFsc28g
YmVlbiB0ZXN0ZWQgYnkNCj4gY3VzdG9tZXJzIGluIHRoZWlyIGVudmlyb25tZW50LsKgIEkgYmVs
aWV2ZSBkb2luZyB1bmNvbmRpdGlvbmFsIFdCSU5WRCBpcyBmaW5lLg0KDQpTb3VuZHMgdG9vIG11
Y2ggbGlrZTogIlNvbWVvbmUgdGVzdGVkIGl0IG9uIGEgcGxhdGZvcm0gdGhhdCB1c2VkIHRvIGhh
dmUgYQ0KcHJvYmxlbSBhbmQgYXQgbGVhc3QgdGhhdCBvbmUgaXMgZml4ZWQsIGJ1dCB3ZSByZWFs
bHkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHRoZQ0KaXNzdWUgaXMiLg0KDQpJIGhhdmVuJ3QgdHJp
ZWQgdG8gdW5kZXJzdGFuZCB3aGF0IHJhY2UgdGdseCB3YXMgc2VlaW5nLCBvciB3aGF0IHRoZSBj
b25zZXF1ZW5jZQ0KaXMuIEkgdGhpbmsgd2Ugc2hvdWxkIHVuZGVyc3RhbmQgYW5kIGV4cGxhaW4g
d2h5IGl0J3MgaGFybWxlc3MsIGVzcGVjaWFsbHkgc2luY2UNCnRoaXMgYnJpbmcgaXQgdXAgYnkg
bGlua2luZyB0aGUgbG9nIHRoYXQgcmVmZXJlbmNlcyBpdC4NCg0KDQo=

