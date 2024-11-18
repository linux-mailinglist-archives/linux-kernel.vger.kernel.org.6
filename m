Return-Path: <linux-kernel+bounces-412833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4469D0FC1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15741F22CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E210194A7C;
	Mon, 18 Nov 2024 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TrE00wDD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cSv7owmG"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D813D279
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731929473; cv=fail; b=oSrYho4m2fGsNYvbD8UoNTJVvzdoFdBzaosZkE4Pu2h8S1++496u9hatfFLvjvHeM+EsxuptQ+2dPce3dsRHGo2UaHVsfSU5CGVAh700Ulwcphg57ytc+72OGaG8V6N6WvH/szvA1ubPUc7MNg+2mcES3oFQqQRx3/jni9z0ylw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731929473; c=relaxed/simple;
	bh=49tPXjD8dPM1kHoMptwcbU2UJ2xrYOpMg6DRTkvCK2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZAtHnBHuru3LR4TQP0oAum5v6/9X/4jy6gVl8PBlDNnT/icRRfsENMgL9DgddKSL2Wp4G5REwjMFfr6Pdl59v0jwDtPpAhYCxJLQHb1oKBEmjVE60Z0MyT7ZwSMALgRBho55guojn/HWDIH7+Peu/gcjLSdZNFWD9u5DdWrqdi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TrE00wDD; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cSv7owmG; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731929470; x=1763465470;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=49tPXjD8dPM1kHoMptwcbU2UJ2xrYOpMg6DRTkvCK2w=;
  b=TrE00wDD2SswsIOBkORsry5NR2FN/W3ZhKykFpTEHAf4xu4JHRF4e/Ze
   TSmrNfV6P+VxhZ8xNbm4DHdZgELMbGwg3EuOgmEA2d3nccyLIJqeDPGDr
   mVVst1Zy1XMvn4fbuB4zyn5r3LJ240bSmB5mXBB08yh21w5Fiqiu72Yyc
   eyVCZ2F+XB10wAD9YZrHaRFMaXbxjv8gY/eZdQUSB4ZUZwTnd0SBY8c7d
   9j1v978s+Gg50YrHHJCHnj15iXB4BHuo1Y5ZhN1OnhfAU4qXOX2ID2+XD
   PcabkSUvg7B0SeZYO5Ns4FgDagzG5332FttCw0Lbvwfwmqqf1IYakiIj7
   g==;
X-CSE-ConnectionGUID: e1Yo5MxZQbeCTQPoWSUCKA==
X-CSE-MsgGUID: L5Kn9+OCSpqCTm5wPUvj0w==
X-IronPort-AV: E=Sophos;i="6.12,163,1728921600"; 
   d="scan'208";a="32741770"
Received: from mail-centralusazlp17010000.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.0])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2024 19:31:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxNfndYKcoEtOVbH2IPHZfxCadK6jnt4Wh+9tZadwHardSZqDbv0psD0HTDkLTS7LID6KGD/gY8g6m4oNL/cLG1NMfjAq66UQ4NZjlALn1+LnSQA1bf6M57hbRYynNB6Ev8fxtstOv55bJGw9+F2nt3DHy9vMIea3HdWWrcu+xowl4KfP/sVzMulF1IFPwETHRQHRIpqGNODMMZkmp2Mq+2EymOHkR50/Dd/tkq9GSxYASPlrXpdoyFs+dp2R/xPUf73YAlu2i+xFPIhx8X0eBmNQBOuWHA9x+jKd1D8l2RIyyMEp5ABlqsq2XWidnlV+OH6B6JdNRbXtysXbsxzrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49tPXjD8dPM1kHoMptwcbU2UJ2xrYOpMg6DRTkvCK2w=;
 b=f/zvzFtF1vqDlgnRrP4F9maoa4zCrHzKx/Afi1k01z/cvIHyH7l1zV6u4lPpfWM9/zz0tyqPeVARUB0ioOqnJpq2EMymaD4d1aBqryYLSIt2LWT94iREUXQxNcXYR9FL821sLMTC1fjs4TqcM+4gZ0azKUFqlk3yBIhqs0JVXyD394AHXb58kdCRdw8yQ5FivFMw6ZlK7dq2TXsRsbmAw6rgUnjbaQy8F7eS+QPyupc7th93wkEVWQGqEgLokhH/2/AA+fTFp9qqgrugdpYlSa+vCWpI04UDn9wFgfGfkYUDKKcDef4WxepUbTYY/DA9804zsgu0aQw1+Snpysr4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49tPXjD8dPM1kHoMptwcbU2UJ2xrYOpMg6DRTkvCK2w=;
 b=cSv7owmGILbo13n+fn2Up5THMjlAG6tlzf1PIXhh9mjgngFPCTnMen8BDIapdfKUlILBhT0Orrzj3k8AmuAKkE0yBNs8FcOhqfJ3zgNl88Mi4jzGLb8hxHa+gXdDpvvxTu8s/YwKPI/j2vZ9KZdgsrA5AqDsHkdK86j4sXt5o0U=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN0PR04MB7919.namprd04.prod.outlook.com (2603:10b6:408:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 11:30:59 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 11:30:59 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "Daniel Walker (danielwa)" <danielwa@cisco.com>
CC: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, =?utf-8?B?SWxwbyBK77+9cnZpbmVu?=
	<ilpo.jarvinen@linux.intel.com>, Klara Modin <klarasmodin@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Danil Rybakov
	<danilrybakov249@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "xe-linux-external(mailer list)"
	<xe-linux-external@cisco.com>
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Topic: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Index:
 AQHbNeKxizzLej0qw02u6pHMIY1jfLK1ZTYAgAACnYCAAAitAIAACmiAgAAOz4CAAq+GAIAAOFOAgAR9VwA=
Date: Mon, 18 Nov 2024 11:30:59 +0000
Message-ID: <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
References: <ZzTI+biIUTvFT6NC@goliath>
 <cd1cedcc-c9b8-4f3c-ac83-4b0c0ba52a82@redhat.com>
 <82ab3d06-40e6-41dd-bb43-9179d4497313@redhat.com>
 <2c828592-dbdd-4cd4-b366-70797d63329d@redhat.com> <ZzTk5kyPa5kUxA+f@goliath>
 <a5bafe87-e8f6-40d9-a5d8-34cf6aa576a4@redhat.com>
 <wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7li@pdvthto4jf47>
 <ZzdhTsuRNk1YWg8p@goliath>
In-Reply-To: <ZzdhTsuRNk1YWg8p@goliath>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN0PR04MB7919:EE_
x-ms-office365-filtering-correlation-id: 087df62c-f247-44ad-a601-08dd07c479f3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SXhxcUtNbE5vaG05azJqbE90aVFDcEh0ZlhlSWQ3b1cyUEVzQUxBeWh6cVRl?=
 =?utf-8?B?NTdOdDk3TCt1Z2lLWDd3OHdOeVpJYzhxMFMwUGFrZkZyand6WWJoT0orUFlB?=
 =?utf-8?B?VXhrOU9QSTEvbTY0VmZjaFhPOGtHRXV2VkU0L214YVZMUmtBUDgvZ3BubWZC?=
 =?utf-8?B?R3E0TXhwek51MDh0OU1BQ2NOTzVsM2pMMHpXYUZVZ3MrUEFsYjBFWlF3QVNC?=
 =?utf-8?B?N0NMUEd4VS9CNzVNR1ZOZC84c1QwOFErQmszc0x2b01oMllKLzRLdU5rV0pp?=
 =?utf-8?B?ajJsVENoMVM5QkNCN3BHb0xyZi9BMkwyOTZIc0xmSUxTT1BhaVVoaGJIUnQ3?=
 =?utf-8?B?a05oMjVXL01rSVdORnd5WWZ0UjlCSEtZV3N6VVVHRlVRSGJmZTY2cEFnT0lI?=
 =?utf-8?B?RDRVOWxieTllS3Y4b1E5TC8yQ2c3ZkdhakhLcFY3R1R3NGpkODlubk9aUXZu?=
 =?utf-8?B?Y28yUmRPcXNqaTZ1WjFXNW5VWWVRRVEzMFo4USt1dGY0ZVR5V3BHNUVGdWVB?=
 =?utf-8?B?Qnc1NmNhQnpYeFRMZDMxREkwOHFsVS9XbTJocXpaaVkxR01pSVJmTm8wUFBq?=
 =?utf-8?B?WjQ0bW9VZ0lTM3kyVE1uSGpoM1FwaWwybFJJZWl6eWZ2d29kc0kya3V3a1ZB?=
 =?utf-8?B?S1E4SWg2RDJkUlp5RmhTWFAvOEZlaTc2aGNkK29UWGVuVXFQaHN4UlZ0Yk10?=
 =?utf-8?B?YnVwVU43ajY4MGNrWDk5cTkvRGlnM0VRYy9PY2laSGFmMzBvcmF4cm1HTU9o?=
 =?utf-8?B?ZDNqQ2dqd3FaOTk3UEhucU1UbGdKdlE2QTJ2SWlCaHlqNnUvbGR3SHZoSjdE?=
 =?utf-8?B?aHhWdFVCb0NxN2RkdWV5VnFydm5DTkpTVUxLT2xwVGVZQjFWY1ZLTm95aTdz?=
 =?utf-8?B?ekkwbVpPZVhmWlo4QUQzRkV5ZVdCV25BSWxBQ2pUL3k5czJxclZHank3MEl3?=
 =?utf-8?B?Skx4K1M5WEEvbmZrdEZwWUpCcS9PS1VCcXFyMGNXZUFOcDJWYUpXRTRlQlZo?=
 =?utf-8?B?ZjdnTU9Bc0p2a0V5d3ZNMkU5U3FBM1JKS2tMYWl5VXRnVmZ3UUJBRWhCczRK?=
 =?utf-8?B?UnZLMVlXTU91dUJ2V3g0MldEaHorNlV4QWd6ZnpzdGs1VHpTS3VuYlU1WjVj?=
 =?utf-8?B?a01NQlUrN29rYnpVeHo2OFpOUUY1RW84OFlta2xvUXlxZnY3Z3orMzI1dURG?=
 =?utf-8?B?Vk1Udi9Mai8zcm94S3QybjRjSk4vOTlIeE0xNm1qeDJGQU9qWnFYcEs3RlNq?=
 =?utf-8?B?YjNBMVRUZ3d5ckVxSGdKQlV4OXExOE14TCtZVU9zR0dVUCt1TW02ZU1KQmNG?=
 =?utf-8?B?Rk9MY294QWZnMGU5R3lHV1RSaDJqcC94dWtNN09razRKSCs3Z3Z4cGtBNWk5?=
 =?utf-8?B?emJUakxGZnNXRWZRa0FoOVdSSVJ2WjFkZi9JMU1FUzdUMHNhNzJjU29RVHhW?=
 =?utf-8?B?VWd2OWVNLzVzVmlPeVpsSVZLcm5TVmVwbXVKaWxXUjV3RGc3UGtMVUZ5Tmpu?=
 =?utf-8?B?VHQycnNnTnRBWFQ3Yml4dVZTNHdqMm5iZlA4MlNPTTB0MVdQT0sySU9uWDVi?=
 =?utf-8?B?THZrQ2piVDJ4blBwRHVIVDZld2RlRVNHZUovN21US0NhMWp3NDU3TGdXVjRO?=
 =?utf-8?B?aFlCMGcvVGtHRzRzNzNjc0FOVjVwZnpRWjlUejlrcGlST1EwczJ1R05odDVG?=
 =?utf-8?B?T3RJNENTZk5VVTB5bkhvVEZXL21Vd0p0Y3UzQU5lVU1RVjhyZ2xGMEhWVHc4?=
 =?utf-8?B?aDZEa2JpS1Q0R21KOFZ5ck5IN1Zad0tjaWRNS0NuK1lIMEJqNVh2RWlRNFlL?=
 =?utf-8?Q?+xHgihgOjKo6xTehCPCiEsx4gsqfXgBHQC+VE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NW1KUnJwOTJqemJkRnZSQ2twd3lmYzRJeW1ScmJOZTNHRkxwODFjTVFLY1FN?=
 =?utf-8?B?MjRmek1EVlgxaVQxOEVtekRHZVQyVjZ5TEpGQjRvVG5BdUVoSFZUK2xHZStt?=
 =?utf-8?B?bk5GQUJmZHBWQUNrZ0lmTDF1YmN6ZUZ0WFJzeVRmbjBFeGwxWENRa3ZXNXIv?=
 =?utf-8?B?SllEYVlsUkNhSDUvZmV1ejQwek1SOFZSaUJweXhNbFlsY2xUQ1UwcmJaY0h0?=
 =?utf-8?B?VTN6NEsyWVZXL0xDMEhwVVJUOUdqUlA1UHY2WmM4SnEwSzRPV3hpVCtSRTNi?=
 =?utf-8?B?VmRVVktVSjBUYzhFVXkzSUN5MStzRXdjN09veG1sd2VKaDQrS2hGQ1NrR252?=
 =?utf-8?B?SzBKdkVGeU1CUllWQ0dkZTIySFFhUnFFKzhjbms4cnJVQXdrVkN5VUJVeUxV?=
 =?utf-8?B?VWx1TmNaVTVneXd5dG13ZytaT0ZaVUdLWHBRNkJEbVVrTjJ3U2dsL25KVWJu?=
 =?utf-8?B?L1JJNlJERWh3bmo0aFFlc2JIT1BkK2JrVGZTcTlEL3pJcU9jVWhPV0lubzZs?=
 =?utf-8?B?YVNxMGpBMm51MjRKelpKMUN1VmwrN1lPNjAvdUZ3VmJWRU01eFV1QXVIeEl5?=
 =?utf-8?B?OXNNdG5BVURQN0IyWUR0cmxyQW41TnZIWlFMK0EzVUFYdXRlL2FyOFovdnhp?=
 =?utf-8?B?OHMrMVV1RWtpUS9kbngvWEVjL2VubjVDN3pmcnFNNDJoZDlIQjk1YjNySFZz?=
 =?utf-8?B?Q0ttTFlycG5uVlRpbUF1dllmMkFES0syc3BUajI2SkpYMW1sdmpxSk1kdkgx?=
 =?utf-8?B?Z0REaUN0MVhhQkgyOCtROXBnekZrK0hDMCsyRVNIR2xkRzBJN3hQaFBIaDIx?=
 =?utf-8?B?OUhDd3doQmsxc0hvQUJrUnltMFpTWWhqNDFReDRGMkRsaUtERU41ZlZHODd6?=
 =?utf-8?B?cExtVlR0YWNmQXNFWjN4REl5VFNnaSs2K3YxeXlUaVRoZDZFMWZyaXhKRU8v?=
 =?utf-8?B?TjF3SVdCdGNoaDZyS3p2Y0Z5bkp0dys1aFBYNVNxMmlHcjFSM1crakpYcnJL?=
 =?utf-8?B?eXJFdlU5bi83dkE1L3VxRFh4azJwZHlhWFhTWmdXNm5vVWJxbFR1Z1oxSzNM?=
 =?utf-8?B?Z29PSWNKRUN1d3NseWhSL1U1bWZsU3BOaFlwcUhHUzAxa1doR0VoR0h3L1Yv?=
 =?utf-8?B?YVZ5OWo0clZ1TUt1eHlxQXZVT2MyQU1kZ1hpSmt1VktTUmlPV2lSNEdwYW5X?=
 =?utf-8?B?L3ZobzRXS1U0N3RsUmxPenNXazNpQ0tkRTJMVFZ4R1VsYUJEUVNGRWNPRHVD?=
 =?utf-8?B?bTNTVERvOE0zam4zOHpzNHhVbFE4Q0dxWEN2MmZ2OGVuenhkdStERjRGUi9Y?=
 =?utf-8?B?a1BJMHdEWWc0QU1jcjlBYUU2VUhhNjU3blFnUUZtWVNvWDIrR1BSNURZYmVF?=
 =?utf-8?B?Q3RFUndiL3Jqbm4vaWFobVpZOHZjdXlYRFZvUUMrT2xtRmZtS3hIcVAwUkM1?=
 =?utf-8?B?Rnl4RngvZDZJSXFBTWZyazErYmM4ZC9oZzZTNUU2KzN6ajhqQ0VnMzlIZ3BP?=
 =?utf-8?B?Zzl0cmNjV3VuaFgzYTc1WUxKays0S3pxZVJpdkZvazNOVGZHaEFIenM3Q1Ft?=
 =?utf-8?B?RjZJMVVVbzNxTWl1R1FRWWFUT1N5ZDlmZHZNT3BFZklIa1ZVclkwakFJK3lh?=
 =?utf-8?B?U2hOQnFUbmlXK0V1MDNxNjVDT3B1MTB4UEdjU2hsYWF0T1NBR2Z6bThmVXNB?=
 =?utf-8?B?WmxPTjJ0NURGb0c3QXhlOXZKOFh4VTlGbTQzSW0vVGNPWC9odUdKV2VpWFNr?=
 =?utf-8?B?b25OYkVKdWdsL1ppbUhWbGdkUWNLNlZXR2tON0JSL0lGSUUyNXdHTVMyMEVi?=
 =?utf-8?B?aGJ5QUFkVXFud0dEWGtDdy85U0xWWTZObnlPQWxzQjZnckZhVGZJckVFQ1Zi?=
 =?utf-8?B?dHRFZy83VHptMzUrR3pNQ1REcHVqajZUYzlNWEIvaitOa01GQkZueFNxMnln?=
 =?utf-8?B?VXg0OTNxZk8vN0pCVC9lNTNpcHgzUFpQSmZRN1IvQURsRGJKazZqK0ZTK091?=
 =?utf-8?B?ZUZmZjZjL1M1aHBRWE14QkRLN3B0V29KMmY1U2dzNldqV2dRd2NrUUN2VzdK?=
 =?utf-8?B?Vi84N3REay9mUDN0N3R5NHgyNkNtQ3pEcStvcC8zaHg2Q2xYd0h0cnBiWG5p?=
 =?utf-8?B?Rjd0QmNpWnNVSUh5NzBwZkU0NzY1RUZ6TUttMko3T0w3TTRVWjRqWjNlUk9T?=
 =?utf-8?Q?zTNW4W/5N0ykSKzaXTw6Vvg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61F101362F7B9149820FE9BC62A21E84@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qAQuWD7PLa9MDPN9Mq3H2tOPbPZOJE6JU5Y8s2c6kP7AUS4Pp6NGnd09KUcaVasQHAtv52apQd+Rlr4+b3EhiaqaZa6c1uN1Sjg3cfWZ1uxTlkAPyt195DsuSt92BQa9iZvRi561nyWT5VuDqh9BJRU4PP52HktEriLx8NyRfs6N9xnMY7+P7VG8xab3BOXYajNJav/u7gFcSyHZn7hH1ZC+OfkXbb1tFOdaBKTOrHhSmZDKMdbfOjNCG8xQGUIntzJhgFPsDrUu5AT1x4lfSLY1EiJl1vYo5moekax+bWDDIsb7rAaum2JoZvNZiEmPS6xYvV4JlAyNdVZNcwYRJ6Tmt/8hyXgdBJOQUdGwTzepf97nJHlT9eVM+LoYwC97ULZmvGQoOiQ3L+KKsp5eBO2KSI5XGQTxAkQlAdjfPpb3dnnkl67TmldPgvj06vbfhaGcr8pAavhVaNSVPkBGkZsuKMjyi2F68+Gl9aTZkwiqjF4mNjdhaEBPby+HSj3JHWXaOQ+xm4+QIu+FhXyr3L9uASrBZsypbx2F9QiyujzL3ncWHrhEnV+noc6bY/dqVZBydjOMsWJ5ayiEGASnCWIAfoFTClaAnjFzi3zaRhl5WXo9X+t8C7VOJbAzqDUK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087df62c-f247-44ad-a601-08dd07c479f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 11:30:59.7058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6TWQSF+q0nHBI/3qzn//lb3A55pbRDXeLf8kk+64TH5nd1w9KqR8qrKTFgQQr5BQcj680gtIb3H3fjuyzT5Mqqq4qErrmNQp4YyfTQpj3fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7919

T24gTm92IDE1LCAyMDI0IC8gMTQ6NTcsIERhbmllbCBXYWxrZXIgKGRhbmllbHdhKSB3cm90ZToN
Cj4gT24gRnJpLCBOb3YgMTUsIDIwMjQgYXQgMTE6MzU6NDZBTSArMDAwMCwgU2hpbmljaGlybyBL
YXdhc2FraSB3cm90ZToNCj4gPiBPbiBOb3YgMTMsIDIwMjQgLyAxOTozNCwgSGFucyBkZSBHb2Vk
ZSB3cm90ZToNCj4gPiA+IEhpLA0KPiA+ID4gDQo+ID4gPiBPbiAxMy1Ob3YtMjQgNjo0MSBQTSwg
RGFuaWVsIFdhbGtlciAoZGFuaWVsd2EpIHdyb3RlOg0KPiA+ID4gPiBPbiBXZWQsIE5vdiAxMywg
MjAyNCBhdCAwNjowNDo0NFBNICswMTAwLCBIYW5zIGRlIEdvZWRlIHdyb3RlOg0KPiA+ID4gPj4g
SGksDQo+ID4gPiA+Pg0KPiA+ID4gPj4gT24gMTMtTm92LTI0IDU6MzMgUE0sIEhhbnMgZGUgR29l
ZGUgd3JvdGU6DQo+ID4gPiA+Pj4gSGksDQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiBPbiAxMy1Ob3Yt
MjQgNToyNCBQTSwgSGFucyBkZSBHb2VkZSB3cm90ZToNCj4gPiBbLi4uXQ0KPiA+ID4gPj4+IEl0
IHByb2JhYmx5IGhhcyBzb21ldGhpbmcgdG8gZG8gd2l0aCB0aGVzZSAyIG1lc3NhZ2VzOg0KPiA+
ID4gPj4+DQo+ID4gPiA+Pj4gcGNpIDAwMDA6MDA6MWYuMTogQkFSIDAgW21lbSAweGZkMDAwMDAw
LTB4ZmRmZmZmZmYgNjRiaXRdOiBjYW4ndCBjbGFpbTsgbm8gY29tcGF0aWJsZSBicmlkZ2Ugd2lu
ZG93DQo+ID4gPiA+Pj4gcGNpIDAwMDA6MDA6MWYuMTogQkFSIDAgW21lbSAweDI4MDAwMDAwMC0w
eDI4MGZmZmZmZiA2NGJpdF06IGFzc2lnbmVkDQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiBJJ20gZ3Vl
c3NpbmcgdGhhdCB0aGlzIHJlLWFzc2lnbm1lbnQgaXMgbWVzc2luZyB1cA0KPiA+ID4gPj4+IHRo
ZSBwMnNiIEJBUiBjYWNoaW5nLCBhZnRlciB3aGljaCB0aGluZ3MgZ28gd3JvbmcuDQo+ID4gPiA+
Pg0KPiA+ID4gPj4gSG1tLCBidXQgdGhhdCBzaG91bGQgYmUgZml4ZWQgYnkgMmM2MzcwZTY2MDc2
ICgicGxhdGZvcm0veDg2OiBwMnNiOiBEb24ndCBpbml0IHVudGlsIHVuYXNzaWduZWQgcmVzb3Vy
Y2VzIGhhdmUgYmVlbiBhc3NpZ25lZCIpDQo+ID4gPiA+Pg0KPiA+ID4gPj4gYW5kIHlvdSBhcmUg
c2VlaW5nIHRoaXMgd2l0aCA2LjEyLCB3aGljaCBoYXMgdGhhdC4NCj4gPiA+ID4+DQo+ID4gPiA+
PiBDYW4geW91IHRyeSBhZGRpbmcgYSBwcl9pbmZvKCkgdG8gdGhlIHRvcCBvZiBwMnNiX2NhY2hl
X3Jlc291cmNlcygpDQo+ID4gPiA+PiB3aXRoIDYuMTIgYW5kIHRoZW4gY29sbGVjIGEgbmV3IGRt
ZXNnID8NCj4gPiA+ID4+DQo+ID4gPiA+PiBJZiB0aGF0IHByX2luZm8oKSBpcyBkb25lIGFmdGVy
IHRoZToNCj4gPiA+ID4+DQo+ID4gPiA+PiBwY2kgMDAwMDowMDoxZi4xOiBCQVIgMCBbbWVtIDB4
MjgwMDAwMDAwLTB4MjgwZmZmZmZmIDY0Yml0XTogYXNzaWduZWQNCj4gPiA+ID4+DQo+ID4gPiA+
PiBtZXNzYWdlIHRoZW4gdGhhdCBkb2VzIG5vdCBleHBsYWluIHRoaW5ncy4NCj4gPiA+ID4+DQo+
ID4gPiA+IA0KPiA+ID4gPiBJIGhhdmVuJ3QgdGVzdGluZyBhZGRpbmcgYSBwcl9pbmZvKCkgYnV0
IHRoZSBtZXNzYWdlcyBzZWVtIHRvIGhhcHBlbiBpbiB0aGUgc2FtZQ0KPiA+ID4gPiBvcmRlciBp
biBib3RoIHdvcmtpbmcgYW5kIG5vbi13b3JraW5nIGNhc2VzLg0KPiA+ID4gPiANCj4gPiA+ID4g
RG9lcyB0aGF0IG1hdHRlcj8NCj4gPiA+IA0KPiA+ID4gVGhlIHdvcmtpbmcgY2FzZSBkb2VzIG5v
dCBkbyB0aGUgYmFyIGNhY2hpbmcsIHdlIHdhbnQgdG8ga25vdyBpZiB0aGUNCj4gPiA+IGJhciBj
YWNoaW5nIGluIHRoZSBub24gd29ya2luZyBjYXNlIGhhcHBlbnMgYmVmb3JlIG9yIGFmdGVyIHRo
ZSBhc3NpZ25tZW50Og0KPiA+ID4gDQo+ID4gPiBwY2kgMDAwMDowMDoxZi4xOiBCQVIgMCBbbWVt
IDB4MjgwMDAwMDAwLTB4MjgwZmZmZmZmIDY0Yml0XTogYXNzaWduZWQNCj4gPiA+IA0KPiA+ID4g
SXQgc2hvdWxkIGhhcHBlbiBhZnRlciB0aGUgYXNzaWdubWVudC4NCj4gPiANCj4gPiBIZWxsbyBE
YW5pZWwsDQo+ID4gDQo+ID4gSXQncyBteSBzb3Jyb3cgdGhhdCB0aGUgY2hhbmdlIGNhdXNlIHRo
aXMgdHJvdWJsZS4gSSBoYXZlIGNyZWF0ZWQgYSBkZWJ1ZyBwYXRjaA0KPiA+IGZvciB0aGUga2Vy
bmVsIGFuZCBhdHRhY2hlZCB0byB0aGlzIGUtbWFpbC4gSXQgYWRkcyBzb21lIHByX2luZm8oKSB0
byBhbnN3ZXINCj4gPiB0aGUgcXVlc3Rpb24gZnJvbSBIYW5zLiBJdCB3aWxsIGFsc28gc2hvdyB1
cyBhIGJpdCBtb3JlIHRoaW5ncy4gQ291bGQgeW91IHRyeSBpdA0KPiA+IG9uIHlvdXIgc3lzdGVt
PyBJdCBzaG91bGQgYXBwbHkgdG8gdjYuMTItcmNYIGtlcm5lbHMgd2l0aG91dCBjb25mbGljdHMu
DQo+ID4gDQo+IA0KPiBPay4uIFRoZSBkbWVzZyB3aXRoIHRoZSBwYXRjaCBhcHBsaWVkIGlzIGF0
dGFjaGVkLg0KDQpUaGFuayB5b3UuIEhlcmUgSSBxdW90ZSB0aGUgcmVsZXZhbnQgcGFydCBvZiB0
aGUgZGVidWcgbG9nLg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KLi4uDQpwY2kgMDAwMDow
MDoxZi4wOiBbODA4NjoxOWRjXSB0eXBlIDAwIGNsYXNzIDB4MDYwMTAwIGNvbnZlbnRpb25hbCBQ
Q0kgZW5kcG9pbnQNCnBjaSAwMDAwOjAwOjFmLjE6IFs4MDg2OjE5ZGRdIHR5cGUgMDAgY2xhc3Mg
MHgwNTgwMDAgY29udmVudGlvbmFsIFBDSSBlbmRwb2ludCAuLi4gW0FdDQpwY2kgMDAwMDowMDox
Zi4xOiBCQVIgMCBbbWVtIDB4ZmQwMDAwMDAtMHhmZGZmZmZmZiA2NGJpdF0NCnBjaSAwMDAwOjAw
OjFmLjI6IFs4MDg2OjE5ZGVdIHR5cGUgMDAgY2xhc3MgMHgwNTgwMDAgY29udmVudGlvbmFsIFBD
SSBlbmRwb2ludA0KcGNpIDAwMDA6MDA6MWYuMjogQkFSIDAgW21lbSAweDg4YzAwMDAwLTB4ODhj
MDNmZmZdDQouLi4NClBDSTogVXNpbmcgQUNQSSBmb3IgSVJRIHJvdXRpbmcNCnBjaSAwMDAwOjAw
OjFmLjE6IEJBUiAwIFttZW0gMHhmZDAwMDAwMC0weGZkZmZmZmZmIDY0Yml0XTogY2FuJ3QgY2xh
aW07IG5vIGNvbXBhdGlibGUgYnJpZGdlIHdpbmRvdyAuLi4gW0JdDQpocGV0MDogYXQgTU1JTyAw
eGZlZDAwMDAwLCBJUlFzIDIsIDgsIDAsIDAsIDAsIDAsIDAsIDANCi4uLg0KTkVUOiBSZWdpc3Rl
cmVkIFBGX1hEUCBwcm90b2NvbCBmYW1pbHkNCnBjaSAwMDAwOjAwOjFmLjE6IEJBUiAwIFttZW0g
MHgyODAwMDAwMDAtMHgyODBmZmZmZmYgNjRiaXRdOiBhc3NpZ25lZCAuLi4gW0NdDQpwY2kgMDAw
MDowMDowOS4wOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDEtMDZdDQouLi4NClBDSTogQ0xTIDY0IGJ5
dGVzLCBkZWZhdWx0IDY0DQpwMnNiX2NhY2hlX3Jlc291cmNlcw0KcDJzYl9jYWNoZV9yZXNvdXJj
ZXM6IFAyU0JDX0hJREU9MCAgLi4uIFtEXQ0KcDJzYl9zY2FuX2FuZF9jYWNoZV9kZXZmbjogZGV2
Zm49MWYuMQ0KcDJzYl9zY2FuX2FuZF9jYWNoZV9kZXZmbjogMjgwMDAwMDAwLTI4MGZmZmZmZjog
MTQwMjA0IC4uLiBbRV0NClBDSS1ETUE6IFVzaW5nIHNvZnR3YXJlIGJvdW5jZSBidWZmZXJpbmcg
Zm9yIElPIChTV0lPVExCKQ0KLi4uDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpBbHNvLCBo
ZXJlIEkgbGlzdCBteSBvYnNlcnZhdGlvbnMuDQoNCltBXSBUaGUgUDJTQiBkZXZpY2Ugd2FzIGRl
dGVjdGVkIHdpdGggREVWRk4gMWYuMSwgYW5kIGRldmljZSBpZCA4MDg2OjE5ZGQNCltCXSBGYWls
ZWQgdG8gY2xhaW0gaXRzIHJlc291cmNlDQpbQ10gQXNzaWduZWQgbmV3IHJlc291cmNlDQpbRF0g
cDJzYl9jYWNoZV9yZXNvdXJjZSgpIHdhcyBjYWxsZWQgYWZ0ZXIgdGhlIG5ldyByZXNvdXJjZSBh
c3NpZ25tZW50Lg0KICAgIFAyU0JDX0hJREUgYml0IGlzIG5vdCBzZXQuDQpbRV0gVGhlIG5ldyBy
ZXNvdXJjZSB3YXMgY2FjaGVkLiBJT1JFU09VUkNFIGZsYWdzOiBNRU1fNjQsU0laRV9BTElHTixN
RU0uDQoNClNvIGl0IHdhcyBjb25maXJtZWQgdGhhdCB0aGUgcDJzYl9jYWNoZV9yZXNvdXJjZSgp
IHdhcyBjYWxsZWQgYWZ0ZXIgdGhlIG5ldw0KcmVzb3VyY2UgYXNzaWdubWVudCwgYnV0IEhhbnMg
YW5kIEFuZHkgZGlzY3VzcyB0aGF0IHRoaXMgb3JkZXIgaXMgbm90IHRoZQ0KcHJvYmxlbSBjYXVz
ZSwgcHJvYmFibHkuDQoNCk9uZSB0aGluZyBJIG5vdGljZWQgaXMgdGhhdCBwMnNiX2JhcigpIGNh
bGwgaXMgbm90IHJlY29yZGVkIGluIHRoZSBsb2cuIE15DQp1bmRlcnN0YW5kaW5nIGlzIHRoYXQg
YWxsIGRldmljZSBkcml2ZXJzIHdoaWNoIHVzZSBQMlNCIHJlc291cmNlIHNob3VsZWQgY2FsbA0K
cDJzYl9iYXIoKS4gRGFuaWVsLCB5b3Ugbm90ZWQgdGhhdCAiYSBjdXN0b20gZ3BpbyBkZXZpY2Ui
IGRpc2FwcGVhcmVkLiBEb2VzIGl0cw0KZGV2aWNlIGRyaXZlciBjYWxsIHAyc2JfYmFyKCk/DQoN
Ck9uIHRoZSBvdGhlciBoYW5kLCBEYW5pZWwgbm90ZWQgdGhhdCwNCg0KICAiVGhlIHZlbmRvciBh
bmQgZGV2aWNlIGRldGFpbHMgZm9yIHRoZSBwY2kgZGV2aWNlIGFyZSA4MDg2OjE5ZGQuIg0KDQpJ
IHRoaW5rIDgwODY6MTlkZCBpcyB0aGUgUDJTQiBkZXZpY2UgaXRzZWxmLiBXaGVuIHAyc2JfY2Fj
aGVfcmVzb3VyY2UoKSBpcw0KY2FsbGVkLCBwY2lfc3RvcF9hbmRfcmVtb3ZlX2J1c19kZXZpY2Uo
KSBpcyBjYWxsZWQgZm9yIGl0LCBzbyBJIGd1ZXNzIGl0IGlzDQpleHBlY3RlZCB0aGUgZGV2aWNl
IDgwODY6MTlkZCBkaXNhcHBlYXJzLiBCZWZvcmUgYXBwbHlpbmcgdGhlIGNvbW1pdA0KNTkxMzMy
MGViMGIzLCB0aGlzIHBjaV9zdG9wX2FuZF9yZW1vdmVfYnVzX2RldmljZSgpIGNhbGwgaGFwcGVu
ZWQgd2hlbg0KcDJzYl9iYXIoKSB3YXMgY2FsbGVkLiBTbywgbXkgbWVyZSBndWVzcyBpcyB0aGF0
IERhbmllbCdzIHN5c3RlbSdzIGRyaXZlcnMgZG8NCm5vdCBjYWxsIHAyc2JfYmFyKCkgZHVyaW5n
IHRoZSBib290IHByb2Nlc3MsIHRoZW4gdGhlIDgwODY6MTlkZCBQMlNCIGRldmljZSB3YXMNCnN0
aWxsIHZpc2libGUgYWZ0ZXIgYm9vdC4=

