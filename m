Return-Path: <linux-kernel+bounces-525080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3050FA3EA87
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B732A700AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0556B1CF7AF;
	Fri, 21 Feb 2025 02:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLyxtYhp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648C52AD0F;
	Fri, 21 Feb 2025 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740103642; cv=fail; b=h2WzYLbLI2aL6895tANM4gMLA5/PVJSEkWvwl7P+HGu+n/YcbT8PNauvh9v995zbqpO6nZtOjx1e0Ohs1bZyErrP4ygbNuQP9MPU2TVG+iA8cRMwvbQxPDP1nvsjQruvj3A+cxj8eIVdn0HeRo6Rar3xHQw0HK4npdXIYMFXshg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740103642; c=relaxed/simple;
	bh=x42mYxVdQ5jpHCBsKsIrmk3VUqTc5GvzB/r6csHiybE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QU6h2rIEu5yfdENUXor4cR0vF8gha3xRR2wqIYhhllGqCiD6La/MbqY1rS8BCk9brQNBEKtpLGfmumPTZDCK3rcuPx6ZmMfN0bz0E9RlA3atWxxLCXTJcJLnjF0wJ06IlTHy9WFenOBRQ84NjOUOH2iHyw5kl4F6N0+TLM+luWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLyxtYhp; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740103640; x=1771639640;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x42mYxVdQ5jpHCBsKsIrmk3VUqTc5GvzB/r6csHiybE=;
  b=eLyxtYhpwSqXrMjWFrMsIks6tx3u4ZhXApDQlZepY2SuAK/hSwpoMlr5
   x3BV3dVixvrOpwemlfgzOz8Z0PbPM0RMnFwOxsds/SsaQgmUoWEmrzyf6
   xlqM1FzJyBFWhKEGDTta2K918QPeLhAFMypXzi/wJASwmmsklJagEWHzm
   BvKpIBvONMetIhLc1ikdMAyEHJLWnx7W60Tl0RDFiCc+ixSwKECj6sVsm
   sti8KlOITOFJ45tl2TCAwp1NzIx5m+JS5y4KmkLeYt3DykbsMpSGlG96T
   pBeT3M+NEKqD3KJxGcMpwHpYm6rrlM1e4N82EL96fSJW+8CiamGo/A50Z
   w==;
X-CSE-ConnectionGUID: oZ3EpUq1T/uCPZMno6IIkw==
X-CSE-MsgGUID: w5lBS3dJQ9iGetkP87TyfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="66270459"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="66270459"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 18:07:18 -0800
X-CSE-ConnectionGUID: RvCyAQIjRTmT/5a2nDk2PQ==
X-CSE-MsgGUID: B68z985YTB2b2yXzy6BaaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="120340645"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 18:07:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 18:07:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 18:07:17 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 18:07:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyN4Pyta+1sYh4G/0REiuJlvn9CLgCY+Y1CCkGZ4AJEzgBdgYf4//wfvCIDhDJOU+ShWDXzPnMkffzrhaEBUHCcFzOsVujze2bEAvTp3tg8C6Xoy28r8Lm0hL7oq8wEXj0hhnU2Ulzi4biHGMYYk+0Ic8yb0qoY7Nzf4kWiH4OPu+jV9HvtJPqA5dQPTPcr4pMbnjFkJAp70ewh7xflmV6KsmMJ220vFhCrG4QAOZ/FQG7IaK2+QZCvR9V9GtX0H8wobhElVT5KCDf7jiibolFIqhyoL8gBv26DYj1sj4yQRI0nqmE5Vp8FwXIpWAyog2GZ4fvOrEFGs08CJZIo64g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x42mYxVdQ5jpHCBsKsIrmk3VUqTc5GvzB/r6csHiybE=;
 b=tMLXNCztuSru1YcougAXcUgkGV3/X7/zQfRYBgF1QOKGMvyl+v4EMjf/mKVdLltmT4dUmYwRmjxy5gBdB/E/bQLM1ja66ckVJvn40G0VKNrxayox7tX/ghqDTalM99JtwTSrukDJd0oNi1xIBwIFvnr/xNIhnjOSRc3d+V3W+gOx+mLOoSfAqbfIZmycaYD8HT5RSdw6qiQyVhwOGkZhpMo/4riiPzsRCErALWCX/Mkio5Iz1/BligKomhlAuktW9zQtCFTKjwfMjmw5+E6pJFaYHQn2zV4o5kbW518d9rm1cvkZ2V8wwoAeiKecG+r/IfPCxedJLknJAFLcniCmVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10)
 by MW4PR11MB6689.namprd11.prod.outlook.com (2603:10b6:303:1e9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.23; Fri, 21 Feb
 2025 02:06:32 +0000
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::4053:18a0:f95:3b9c]) by SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::4053:18a0:f95:3b9c%5]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 02:06:32 +0000
From: "Liao, Bard" <bard.liao@intel.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>
CC: "vinod.koul@linaro.org" <vinod.koul@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pierre-louis.bossart@linux.dev" <pierre-louis.bossart@linux.dev>
Subject: RE: [PATCH 11/16] ASoC: SOF: Intel: hda-sdw-bpt: add helpers for
 SoundWire BPT DMA
Thread-Topic: [PATCH 11/16] ASoC: SOF: Intel: hda-sdw-bpt: add helpers for
 SoundWire BPT DMA
Thread-Index: AQHbd6pl9VF0beLHp02QvDcO73qvZ7NQmkgAgACAtmA=
Date: Fri, 21 Feb 2025 02:06:32 +0000
Message-ID: <SJ2PR11MB842468F6D1CFA80726817B15FFC72@SJ2PR11MB8424.namprd11.prod.outlook.com>
References: <20250205084531.158763-1-yung-chuan.liao@linux.intel.com>
 <20250205084531.158763-12-yung-chuan.liao@linux.intel.com>
 <14f2dbb2-0f8c-4b07-9d9c-17688691a189@oss.qualcomm.com>
In-Reply-To: <14f2dbb2-0f8c-4b07-9d9c-17688691a189@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8424:EE_|MW4PR11MB6689:EE_
x-ms-office365-filtering-correlation-id: 510464ae-c7be-4a20-1c76-08dd521c5cd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M0JPSVQ5K0pXL0plS1VCZmlpRzZSaGlvYmdGRDZKYVZIb0FUSHA5YWs0cHgy?=
 =?utf-8?B?MW5ZZks0TWRSM1pCV0JCQkZVakZlNnQzdnBRMDNaR2c3eW85ekd4R1d5UmQ1?=
 =?utf-8?B?WllvS3V3Sk9ROFlYb0lvVUIxekFDOE9hWCsyaTF0Q0VycDdKNGZheGgxQng4?=
 =?utf-8?B?TmJKZW8yWEo3QlRWMEo4M2ZEZTRMeFQvVjViSWJ2Smd2YXhIbVJyYXVuZVJU?=
 =?utf-8?B?NmNhTU9TckQveFp0djlyalhYNUJMMTRBMGhJdVU4SlRtbzNaaE1KRXNNVnNp?=
 =?utf-8?B?WHlBU3pJYURrR1ZQdThETnFXRiswM3Q0VDFxTjY3bG1rYVZvWlErTUZqalFx?=
 =?utf-8?B?dThyMkF4V1RJNW9HY1NUbkFFRDRMelNSL3pCalhKellyYlJBT1lya0R1eG9I?=
 =?utf-8?B?WTg1ZHJKQU9iUWx5MThaSTNtOVZpV2FHT3dObWQ4SXlOMk5TRktaOHYwZ05C?=
 =?utf-8?B?aWNEbVUrb3RjbnhIZzBTem03K1lwK21kdmQwc1ZSdmxtdFBweDZVMFdPY2VN?=
 =?utf-8?B?dGxIZzlrT0h1NnN5K3pNUEYybUdOaDkwSERtWGtWNzRFL1p1SnBpMmtYclV2?=
 =?utf-8?B?VGtOSkEvZE1Hdm9XM0NOUHB4WlYvUDZoZ2FpV21BNi9UZm9Td2pXNHBYQ3Bn?=
 =?utf-8?B?VUJGOTJaNFlsSnowMWptc2wyczlNaWc5cEF2anJFL0RlTXZzbUFybVRmeW5j?=
 =?utf-8?B?MitLWUhGVUpoaXFHdFJnbDlOR0pZcVNtaDJiV3VYK0FUWlg2eUN6TlkrLzE4?=
 =?utf-8?B?ZThENTRndWxxM2VPRjVWbHhubXE0cUZIZGZCaitueFhsUHBEdXBXK0YrWXFW?=
 =?utf-8?B?V21zVFc3Z1BBenJRcEpTalNyQTMzdk9WZnlTN2F5bWdFNmt4OGkxYnpvR1FU?=
 =?utf-8?B?bW5LSit1OGwzQmNOSDdCa2VkQVdwRE9EMGdsRmhEZFJHSlc0TWRVTUFtdXox?=
 =?utf-8?B?RC85VWllMUJKYW9PS2JuYTB4a3k5NGFwTUpJaWF3VU12TzFJVFVNRmFUc0lG?=
 =?utf-8?B?UHdRbVV0UVdHaFBWd09QaVk5eUtjVC8zM2VCS1RnRGpLby9BcSsxYTNYbEta?=
 =?utf-8?B?c3pFSFVPNkJYTHovQmwrRnJpRGpYRWJldGNFWExwdGZyWUNSRngwZ1ZGTDdm?=
 =?utf-8?B?WFJOeUhoWDdRc2tXeTlLNEl0VDRCOXhDd0Fsc3R2UnFLUUdxS2pMSHdHdys0?=
 =?utf-8?B?M2dncFRjbnp2b0R4NjRHaFJ5UEdkR0tpOHNQQUV4VU93amsxREJQVldCNndq?=
 =?utf-8?B?Q21hbHlsaDZiZ1BycGdDSTdpVXFhUm9wc0VoRE8zV1dMZnpwNFBpT29JeGRX?=
 =?utf-8?B?VE92V2lzT2tyazU3UmF6blNpeUZLL0h1OEpyVzJsRURvbHhzV1EyUXdzSXNB?=
 =?utf-8?B?T01rM2FvWG8ybzA5cVdWREVEZVhrTHdwM3YrVm1uZGhUNTU1Wm16YnJ0cU1h?=
 =?utf-8?B?RzZ0Vi9CRElHKytETWIyYktyL1RHdWZVNjJUdS9DdXlKNzViejFFYVQ1a1ly?=
 =?utf-8?B?Ky9WcWR1azY5M21LS1VKQWRHQ0graWJZSXpLZ1dDZUF4cVU0TDdXd2NSRjVV?=
 =?utf-8?B?RXNCa0VzK0ZUcitRLzliVVl4UW9scWVMMG1wdWo3S3BNUC9UeERNRjZBR2hI?=
 =?utf-8?B?VFpsNGRiQi96M3FKMzE3V3o2RTBGMzdLTFkyTGQvaWNzaE9GTU9Cblg4Y3E0?=
 =?utf-8?B?blo3RSsyMTNXR2tqUi94cC9OT1cxYytZYkFBL09RZVVjWnp0Sm5lSkhaS09l?=
 =?utf-8?B?OXQrWHRra3lkeDBPdzQ0cmMxamgrNlRxQjRjcHZwVk84ZllZT1JteEYzK2JD?=
 =?utf-8?B?aFJ0MFdSNUtsSnFNOThvRmR4SzhHTHpkZUZGbGlEbUFBTzhxNld1Q3VIQldS?=
 =?utf-8?B?OHp5Y1lSdWcvZHBXWElxYkcxNXlVeFJaSzZzdmphc3p0VDQ1UlNabFh4amky?=
 =?utf-8?Q?RJ/Z9jE0fr+w1aL9qnTvj2AohHX7wrrG?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zm41SjY1V1g3aEVLV2Q1WU02RmhRVnhqa2JTejBPRjRGUU9mUnN5eGhrMjgz?=
 =?utf-8?B?MUJUOUUzYzNSMUVCbnA2NFJVZFpzN0NTWVRaaS9qa2NibWd4UDc4VzY1d1Ev?=
 =?utf-8?B?NHhKbng5YjM3M2tjY2RhSzAwS3JJc0dJYmtRa2FPTEFOd0Q3VDQ1bEVsZnho?=
 =?utf-8?B?bEYxcEZqVlR6NEhiQzdpV1Z4WDhoZEVBMlcrMFRrVHNkMitPK2xaYkxOWFM0?=
 =?utf-8?B?NzBDN1c5cHgvV2N0b2ppVGZPTWxNbms1cGpZUk10RHIwSFloQ2QraWNvcVJN?=
 =?utf-8?B?YjZraTZNT0l1elB0ZjZhNGlFS0w1blpscU9PSVplTUJydVNXS1hEcUV0dDA0?=
 =?utf-8?B?VGlrZ3dtTmpJVnNEdWlCbCtycTQ5OEh1YlJ0djdtOWR4ZzQ2OUFCdUIzc1Jh?=
 =?utf-8?B?NlJKZ0hpQkhqNTdKN3dzWVc2a3RBVW1jUFFaLzlrRzdybDV3Y3ZaV0pSNjkz?=
 =?utf-8?B?dFRrNnZJVFlPWXVTZkRQcWQ2TTNzRWtraG5BelNkZ0YwVGc2Rk1CTFhXQVhj?=
 =?utf-8?B?Z1kyTGdKTGwzWHhiTndUTDhuK3k1eUdPNVdIWTZrN05qWTVjVzRvOGVsZFdj?=
 =?utf-8?B?bStjMGdIZ1R2aDF5NWxpTGljenpDd0hiR2QzVEZ4T2dxQS9EcnhhUE1EVUFT?=
 =?utf-8?B?VlNhZXN4ODBoNWgvZlN1azk3WUFReVFBQTd5OHArR2Y2K0pwZFpLZWpxdW5w?=
 =?utf-8?B?TUdQQlJYRmNsM3FRQTNlaDEyK1FZVzBieHpsR3hpS0F4QUE3djAxSHVUYlZP?=
 =?utf-8?B?OE5FclpVL25RcmxqNTNhMzYwV2hmMy9GaHVpT3hydU5scEk4SjBJeDRPQjZZ?=
 =?utf-8?B?Sy84cXF4d09OZTJMcUhWUlJOeDUvYjFEL2MyNTZGd2ljaFRvVVpQKzkxaTVa?=
 =?utf-8?B?OVdGUkVlSXErd0lhdUoxV2tqZ05JK0owMi92VnpVVXB0Q2F1c1pHZjg4QWYy?=
 =?utf-8?B?SGprSlFUSWc2YnlEMm9uaHRINTA2NmZOUjhBUXNaZEFFZndlbjRtNGYwdVpJ?=
 =?utf-8?B?SDlNU2NSQUI1ZXRGUEppZkRDcVFEeXNrQU9vR3VUbW41aXU3MUk0YVh4SC9Y?=
 =?utf-8?B?SzRXcTFLTUp2a1dPMlJjd1V2TytJdHNVbU5PZ3diTVc2bkp1N3R3YWhId1NF?=
 =?utf-8?B?UHNMcVBPRm5vb3UyRG1uY21uK203aWVmNXdackFBY21BRTNxUlZJQUlpNGc5?=
 =?utf-8?B?cTRjWXJ4cUxqeUZTY0JpdVFuQjNYUHVmV3ZLTGZtb05TcjRFVjFEZHk3NkZ4?=
 =?utf-8?B?Ti85UE1rUUhGY3NjOHVwSDNGck1KSkhIaTAxUnNmRE1WSGk1Z2x2bVY2VW9n?=
 =?utf-8?B?YXpLOE9jNzc0TVFJZ1pXdEVkam1vVjJ4YVlrbEhPWTh3Qm5mRVRaTllTZEwv?=
 =?utf-8?B?L0pVbFZYaDdsclp1VTJKNFAxODdSeS8xQlNiM3cybUx2eVhUTkVjTmp1amFr?=
 =?utf-8?B?SUoxL3VpQklld09Jb2cvcllxci9lcEdySjkvTjExSTZ1OG53a0NMMXhTRmxD?=
 =?utf-8?B?S1ZvWndoKzhxUDIxZXQ0dXRTUDBhMVdkVjI1Rkh6SEhPa1hoQjRhWjNkNnJn?=
 =?utf-8?B?eWNPY094UVVnY0NaZ1lYYU56ZnBRRHNUL0RJRFZQSE5ZZ09QR2YwUk4yZllm?=
 =?utf-8?B?ZmZmeEJCUjc0ZGlyL3hOUUI4dXRHUkQ5WlpKOVNVWlU1cmpYZ3g0aTZHZGVZ?=
 =?utf-8?B?UEVEcjNFdXNOalozSFU4Q1d0cjVPOU9XL09KdXpiKy9mRGVvNk81QWYwZ0E2?=
 =?utf-8?B?MWRFcjdmVlZGazVIOUc1TmNyeUZQN3VVSnR1eWM0Yk5EdVNORjhVV05xRXIw?=
 =?utf-8?B?SVhLei8rU1lleHVkNCszTzErYVpzV21reWdSWHFrNVprRUZTU1NXZ1p6b0Za?=
 =?utf-8?B?N3pqbnBva1RHSytGMGkrcnZ0MkdmM2x6S1dQdnQzQ2FnMGs0bEtHT1pyMUR2?=
 =?utf-8?B?SThBeWd6Mmw1UEFteGwzSUdkcDV5dkJHUnV6NmhqTU8wRHd1aTVESFVxQlN0?=
 =?utf-8?B?VjNWZUREQ0pQWWoxbXFFUHgyN29ncXlObGE2RkhMZ2pRazFuOXdkNXU5c1dG?=
 =?utf-8?B?ZmF0RVQwb3lDak8rc0pSUUlQb0NkanJ4QUl0RmtRL0lxRWdLOGhJZmw2V3dx?=
 =?utf-8?Q?OerA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510464ae-c7be-4a20-1c76-08dd521c5cd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 02:06:32.6319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PlrIK56WL/Gu450aT0jvnZaUFW7wEOfx8UoGZd1n4NTz3aRtiQ8BYi4IZIWtcpQvoPGW9V+xPWtmMtqnlHrTgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6689
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVmZiBKb2huc29uIDxq
ZWZmLmpvaG5zb25Ab3NzLnF1YWxjb21tLmNvbT4NCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAy
MSwgMjAyNSAyOjI1IEFNDQo+IFRvOiBCYXJkIExpYW8gPHl1bmctY2h1YW4ubGlhb0BsaW51eC5p
bnRlbC5jb20+OyBsaW51eC1zb3VuZEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHZrb3VsQGtlcm5lbC5v
cmcNCj4gQ2M6IHZpbm9kLmtvdWxAbGluYXJvLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgcGllcnJlLQ0KPiBsb3Vpcy5ib3NzYXJ0QGxpbnV4LmRldjsgTGlhbywgQmFyZCA8YmFy
ZC5saWFvQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxMS8xNl0gQVNvQzogU09G
OiBJbnRlbDogaGRhLXNkdy1icHQ6IGFkZCBoZWxwZXJzIGZvcg0KPiBTb3VuZFdpcmUgQlBUIERN
QQ0KPiANCj4gT24gMi81LzI1IDAwOjQ1LCBCYXJkIExpYW8gd3JvdGU6DQo+ID4gRnJvbTogUGll
cnJlLUxvdWlzIEJvc3NhcnQgPHBpZXJyZS1sb3Vpcy5ib3NzYXJ0QGxpbnV4LmRldj4NCj4gLi4u
DQo+ID4gK01PRFVMRV9MSUNFTlNFKCJEdWFsIEJTRC9HUEwiKTsNCj4gPiArTU9EVUxFX0lNUE9S
VF9OUygiU05EX1NPQ19TT0ZfSU5URUxfSERBX0NPTU1PTiIpOw0KPiA+ICtNT0RVTEVfSU1QT1JU
X05TKCJTTkRfU09DX1NPRl9IREFfTUxJTksiKTsNCj4gDQo+IFNpbmNlIGNvbW1pdCAxZmZmZTdh
MzRjODkgKCJzY3JpcHQ6IG1vZHBvc3Q6IGVtaXQgYSB3YXJuaW5nIHdoZW4gdGhlDQo+IGRlc2Ny
aXB0aW9uIGlzIG1pc3NpbmciKSwgYSBtb2R1bGUgd2l0aG91dCBhIE1PRFVMRV9ERVNDUklQVElP
TigpIHdpbGwNCj4gcmVzdWx0IGluIGEgd2FybmluZyB3aXRoIG1ha2UgVz0xLiBQbGVhc2UgYWRk
IGEgTU9EVUxFX0RFU0NSSVBUSU9OKCkNCj4gdG8gYXZvaWQgdGhpcyB3YXJuaW5nLg0KDQpUaGFu
a3MgZm9yIHBvc3RpbmcgdGhpcyBvdXQuIEkgd2lsbCBmaXggaXQuDQoNCg==

