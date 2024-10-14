Return-Path: <linux-kernel+bounces-364130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A1799CB71
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFBA1F2331B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1D31B85E4;
	Mon, 14 Oct 2024 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgXVpobJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72C91B85D0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911815; cv=fail; b=d0XeSof2DxB5W5ERMnQOgMFZDKDyEO9lRiCoSE1j8JehEepRD5lXX/W5xG5DvKMGyUmO9d09hfWWEV75z1+GnS9ksaaiW2xG5IgEslZriFHIyA4s89HuaQmlO7ex4CY2G0mZkNL9R2pehPFELf3BbWbbPsdYDO56TRvVdZ/rCbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911815; c=relaxed/simple;
	bh=zWMOE+iry6OLZpEIidB5F0pkzeSrnn6xPVrEekL08yQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rlYE8s1lrYugfBqW80NArX5RVRIBqpJ4XrNVUAFBZMqodTpJI/tJ5d41uXu0/jK+swYfIqDZf5M420bt1/0WQGwyaqRWuhsw4Qvbxh3v/1OCkfdaEKG7wKmOBen+u3RB9+9esRGi4+tIfJTE4vKl1ce4vbOR3ifX9ivlcgBvuAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgXVpobJ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728911814; x=1760447814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zWMOE+iry6OLZpEIidB5F0pkzeSrnn6xPVrEekL08yQ=;
  b=DgXVpobJf791cJevNGUzxj5xls4YuVlWa2Tew/ha2gSUiLwjcQeN6+4C
   QOqK+cDyhs9fJEKub7QFD+jotcphXu7lne1eb48b2vOYDkdxtFBnnURRU
   09Ser89M7hRbH55HI9cclJkEqUNQma8GBaNn5izB59poJ0KrBjixvQPcV
   Ef6jP0AzQdXvbDkh62rGlpP+Nc851GeX1OYUEWX4tK/4s9GHbnNoKeRjt
   KOfqhodsvvUZ5UvE0rWaeLIWF7ZMVwniprTeBL526XyBoavSNkH/k1tdK
   GkloSS4BvJdl9U1pzoTsKAlTEF3xEmkL7Wt/u5PmyZILQwk1hnDlfYQYB
   Q==;
X-CSE-ConnectionGUID: AGaN/KX6SHWK4o7ImS/GNA==
X-CSE-MsgGUID: AqmGEGc4RWG+n7+vnvhstA==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="53679564"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="53679564"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 06:15:53 -0700
X-CSE-ConnectionGUID: uRQsg3xDSumqO5ex0T6/Yg==
X-CSE-MsgGUID: hVt1WknkRe2F736UY5LPLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="82195576"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 06:15:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 06:15:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 06:15:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 06:15:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 06:15:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8tvKbd/yywIEdY/vY5ZhR3BDh4vWjaLfCTwEGBuQi05wm7zOHWW1Y3YUSdrie7FszPB567QZXbaLkdCzbdxDlwCJrI5D3LB3RG/xalKPuomwgzdUKvq8OCiKeQnErtkJPBkFgzcEinEzYuH4m8wB+zDxxz0r6hS0hkU1Yb89lzOQq4C+IiEtsqeU9Ner/7w3ldr5zxHRzxt4CF559xPRdgKVUB2W43oBlmwVPlYww39j/1cF1Ea5oBKR4kr8Ay4x124HQ1iajOVtkm5SVPoKM0qCE+XSf9rKNOrSnpLHLTaWUM2csrr/zuW29MGwUqDbkbhFyQG3RklkgXV5Xtm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWMOE+iry6OLZpEIidB5F0pkzeSrnn6xPVrEekL08yQ=;
 b=UGrYEtPfj7xHtiZXRIwGC8eHtNgM7W7Wfyz3Sp0h08TV0XSItq5lSwdwqoFCmc6NRaKfxikCf1HE7SeiFNeSQc3QBiqOzOUMcFCnNt+rnOje13/oIGkAvHG1qjGSRb4cYygKHC0ct9A6Jf37pt9nFxskUaaTM2YiNe/hUrH7p+qgZmCHmRwtmk8DYnsL7SytUKuKuxS+inERva5h3FbdNitQmeyPfGQcVn87GQe11q7yXPxxQOxSmT47g7Og5cXwiohpso7JsXyROZVUqm/s1jzaFMRBwAKOHlNswc0qCn/kOIYTWGgt+SW189DUM1qC+5n4ymI1RM9jqe6xkchyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by CH0PR11MB8235.namprd11.prod.outlook.com (2603:10b6:610:187::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 13:15:49 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 13:15:49 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Weil, Oren jer" <oren.jer.weil@intel.com>, Tomas Winkler
	<tomasw@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next] mei: use kvmalloc for read buffer
Thread-Topic: [char-misc-next] mei: use kvmalloc for read buffer
Thread-Index: AQHbHWhGw6lk2l+i/kCbXkW342aN97KEmAAAgAAeWGCAABIogIABauWA
Date: Mon, 14 Oct 2024 13:15:49 +0000
Message-ID: <CY5PR11MB636626DB1AB4507D847E21CEED442@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20241013115314.1290051-1-alexander.usyskin@intel.com>
 <2024101343-proposal-gatherer-8c43@gregkh>
 <CY5PR11MB63665F42CE8EDCD3D48D2A27ED7B2@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2024101335-turbulent-smelting-00f2@gregkh>
In-Reply-To: <2024101335-turbulent-smelting-00f2@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|CH0PR11MB8235:EE_
x-ms-office365-filtering-correlation-id: 5ccecc30-10b4-474f-d493-08dcec525245
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SnJUS1lCTWpPa3VFek10ajIwVXM4MWE2Sk5mQnZaaW1rclRGQWhQbWpsc0o1?=
 =?utf-8?B?cTM0bldXSDl1eDVuVUNSSjlyK2NpeGdwUVRKa1pBWUZaMnF1WWxGaHd0NTBN?=
 =?utf-8?B?Smh1Sms5VndycnJ5aU5oS2VNUC9JRHhPbGkzOXdrMFZNekUrY0ltVG0zRzdl?=
 =?utf-8?B?bGN0dmtlSTQ2aUhVRVh4VlBLRHNIYWszTGd1SGpBUFN6VTJXd1ZnRTNhbTY1?=
 =?utf-8?B?VUh3WXpocGhhRzZ0NUlWc1VhRit0YjJNclRSRHI2em5WdUFzUGdNSlJaaWhp?=
 =?utf-8?B?SGplelQ2b2lSeUMvSllIdWlUbzk2dDBoK0ozd2hlQk8wQlFCRHRhcHIySU5H?=
 =?utf-8?B?STdVT3REdWdDNHhCa2FscDlOOFpxblg4TEM5dm1YK3pvSEo5d1ZONk45cVJT?=
 =?utf-8?B?eGU0WHdWSWNHOXVzN1dZUkN6RFhPN2g0SGJWTVRzU3pIZlhSR2dPQTJsNkt0?=
 =?utf-8?B?a2l3SEdlZCs3Y0ZSVlNxZENTY0dUaU9vT1VlUTZoWmhCTkptT1ZJRDE2NG1I?=
 =?utf-8?B?R0kvdW1wVHVyTGZwbGIxbFlxNHpmQXp6KzMrckcwS2ZkWTFyNUgzbU54NXN5?=
 =?utf-8?B?VXlJY3BwSzAxSmRKekg2SkZpZEExSkdDZkhONzVBenhKb0tnRkhlamw2SEpB?=
 =?utf-8?B?UWRVa3pQdnQrNlFoV2dFQjE0a3FFU2tLcDNxSkRLQTZFVmUvS2k5SXJiV2hv?=
 =?utf-8?B?SjFnL3RnRHlSVVoyMFNEQzcxWEIvck81TXA0b213bXo2bnlkamMxbE9JMkVQ?=
 =?utf-8?B?NDkweEpuVk5RWG1qYXpBejdBQkh5dnR4aXZDNTQ1L3FTc3BCWnRYa1VnRWhS?=
 =?utf-8?B?eGlSam5Td21uaVlxbU1uWFNHNVF1TXQ2allDUG00VGxjSzZTVnQ0NWVlQTBh?=
 =?utf-8?B?blJVWWU1OE1TQUFLVHhST2ZZMnNrY0QzNmVWakxpL1d0Y2FpY1hpc0JrSEpX?=
 =?utf-8?B?dndrL2VQN2xUUm1NUXJEWStpYjRRZjduRm9SZi9qWHBwZHUrWVlJZzRUd3E5?=
 =?utf-8?B?WEhnZ1ZGK1I5VTBUclQ4dk9sVy9VcjNBU0QydFU2NkZxdlczbUlPVEttQkxL?=
 =?utf-8?B?dWRCR3BWODVGMDdVTWZndHd1ZmttVjFrbE9qUFF5ODhrMUcyUWdtZmFRUkF1?=
 =?utf-8?B?OTd6Z3I5M2hHK0RidU53TUwzVm9mNTV3ODIyejR1VjRtN2ExZXdBZVNaZzhI?=
 =?utf-8?B?RmFETTNYQjNBSnhDRDhDbEtrUDBXVlRNdEUwc1NSSjBwb015Smgxenh4V2pB?=
 =?utf-8?B?N2gzdkxMKzZNa1VoSmZCSktoc055dWVLMkNuZUo2SmxXYTJhc0QvQ0crWXA4?=
 =?utf-8?B?Slp2TlNreXZCNzY1RmdmeDVkOU9sV1RubG5uUVpOdTg3TEZ1UFBrc0oxd2ZU?=
 =?utf-8?B?UjVpdXY5K0J2a1c4SGY4VFBocnZHVnVVWXpiLzFrWmEzOS9ES2kxbjhycDh3?=
 =?utf-8?B?ODNzbFp2RnNqY3JNb3VLQUYxSGZ4cWNQR0RRaHN2ZmJITmpSejNsSU5IcG5x?=
 =?utf-8?B?NWs4TWpEMmdNT1gzLytUT3FkL01LbkFxTUNSRGJrU29DeFpkYkxUOHpWMG1y?=
 =?utf-8?B?SFlTaTBhRWRycGJnZWNOV1dXam5JVHZibE15aGVueEpBL2FBeEJrQjA1Y0Z2?=
 =?utf-8?B?Qzh5azIxWUx4TW92QTFwU1pYZ2xkaUNGQk9uVi9ERE1UVVU2ZElEY2IwMkx2?=
 =?utf-8?B?NnpZQXJzenJFOEJObG1RTUdEUGhhMGdtUFFiUlRZMGxiUStnd0JWZ216TVNK?=
 =?utf-8?B?djFHK0pLaWdOT0Z4SktpMDMxRWQ1Ry93eTBGQTUwUjc4SjFzN0MyRC9HK29O?=
 =?utf-8?Q?aXAWSPmlaBnZmz96kKPGZWQ0oq1bX1C/y0eL8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFpNY0p1bDdtK05XZGw0WElmV0RyMmpPNFd5bjZZTHRoUzBCQkI1am1jT3hQ?=
 =?utf-8?B?UWxhd3lnd2c2QU5MQ1QveFZYWG9DUFZ4eG1VYzZFbE16b0VjS2JFRFZwVHRi?=
 =?utf-8?B?MmVzVWJHdGlCMytVcWRybW5EOXBwOVJqMGtMNUJFalZOS2RqZzdFVDg2WmVx?=
 =?utf-8?B?RURIQVR2djhXYTVLdjlRdlZuSEZ0dWFqMzdTSkNWTm5CWjk0aWJLWjZTaVBo?=
 =?utf-8?B?NS91OTRBMjlPVUYrUUk0VldGcys4QldpMnhIRG0yd0QrZVE1VWIrV2daMkZ3?=
 =?utf-8?B?dzdRUjJ1Ni9FcjJia2M4TytkVnN3dDdMdXpEVmkrYVJ4Y29IcFBlV0ovS3po?=
 =?utf-8?B?TlROY2hpM2FwQ05jYVNOVFZyYmFWb0hNQUtIejFKaE1GcHpWRHJSUHZhUHIw?=
 =?utf-8?B?OVhkNmJvQzJwMU1sUUJHZXYwbkRENXdXWll3WEJnVlY1R1BZczRkTUVzM3pD?=
 =?utf-8?B?UVFPaDlvODFmM2ptWVFJeDh5R0lOeHYyOTJhWERBSGJxYWJuUFRFeHM0cFdR?=
 =?utf-8?B?YkVSdXBkVzhoRUc2VE04YnhDNG53QzVDc0V0SjRDQ1N6TzMvOEtHa3hGcnlH?=
 =?utf-8?B?L2dTS2JXTzNFcGVTM1E3aE04ZFdkQzM5bWhKdTV6bnBtZlp3S1VNcUU5RDJv?=
 =?utf-8?B?aTg5aUhuZUw0cC9JMmNSZ3IwdERacURlUCtqczNwWkdZcU8rRjVRZHlhRkVw?=
 =?utf-8?B?eEFuZFYrU245Y0JYN0NEempJS2c0MC81T3BvT011NTdPZTFQRGhZN0ZrOHlM?=
 =?utf-8?B?alNVU1BLc2ZoaXJqRDgwWnFaMkI3elpNeWhWVkRNQmFsaFA0QjcweDFyNTV5?=
 =?utf-8?B?ektTdy9hTkFNSUMwUFMwd01vOWVPVE5SWWpTVkRhY2g1OGlLWVp3N0s3TzB4?=
 =?utf-8?B?NjlQWVpteXZhSFJkaitYWFhyYy9NUHpRRXpoOWtPOFU0Y2NpZS8zWHo5eFNQ?=
 =?utf-8?B?cm1jMW85ZU03Y2QrNVpMVXAzbGJSeVBmUjhtaU84VU1XbmFQVHVIRzZUd2N3?=
 =?utf-8?B?TUVBdVhINmJET2JjOWNVMWJISDFZZ2FNa0cwcURoWWVzSmNDbFlKbzJGMTBs?=
 =?utf-8?B?cGxleVFiR2llakxKck5Zc2ZnWDRqZWR4SDZkd0s0LzcvTXN6OHY5Z0hsYkZC?=
 =?utf-8?B?SGpXUzAzeWVCOE9wY2tvT2prQ3l4MzAwbkd1WHU0VnRhbk1JSlZwUFgxWHM5?=
 =?utf-8?B?M3BTcDRqQkxYamtOaUJVK01ObmsxVVpYNFJBaEo1elg1ZlN4NmhVV1NDVkFi?=
 =?utf-8?B?bExPM29RRHlUbjlnbjhOd0dqWVNFSCtKMkM5MjJmRERCeGJuV1Q1MVhOcVcy?=
 =?utf-8?B?Vy9Rby9NLzR2UC9FWjlsVnZkL01iUmNtVm41aTJoMjFub1ZrYmhNS1FYSDB5?=
 =?utf-8?B?cDNDaDFWUDljWFA2ZHpROXN1OWNhZ3pVdU50UXhYaThlMVVmc085MzRJZ0tr?=
 =?utf-8?B?aFhkZTlJM0ZBZDRwVGNlRnZJUWYvMnRPRC9qclZjUm1XdmhqLzRsODJhOHpy?=
 =?utf-8?B?L3RCcmlvYVpqRkZIeXBrdDdpemNSQjNPZW1wQzNUcy9Tc3NyMHlhQUMxSmZM?=
 =?utf-8?B?T0JRWDNoMDdwaVh5OGhqcFZjMzFGQWFlU3Z2T2YwR0xqUDhNenR6ejI4ZStT?=
 =?utf-8?B?MmM2RHM0QmJ1TGtKTXJvN29XUk5kclQvbmd5WFFzYS9oR01seHFmeHpIRWVH?=
 =?utf-8?B?ZDlSN3BHengzamZYUlRRS2MzTjlxYm9EaFdYbW9CWWVzaUs1cDY1R3E0R3RV?=
 =?utf-8?B?ZEppcitjZHY0ekc3aTNuRlQxWVFsQzRKYWE2TWsxcGlPM2JXU2pKTEFVeFEx?=
 =?utf-8?B?MVhvRDhMNGkwSG5BWEhyTTJQMlFtaXBkVy9kZDZQdWw0KytlMU5mSHAxd3A2?=
 =?utf-8?B?Q3Y4azk4RktWdnVHd3ZPNW5CRU14b25TTkU3RXRuQUxobjdWZ0F6NFhHWEpG?=
 =?utf-8?B?eVpaVWtlT2xpVHFPTmNJSld1OHBHb0NxQ0xtZkFGMmdhVTg3K2VwRHpaeUdI?=
 =?utf-8?B?Nmk4c05DZlFraWNiRjNnNGQxZGE2UWVBM0hSaExLVUg0WlU5RE1sWFlZWTMr?=
 =?utf-8?B?WEZmQXpmSy82ampHaWM2RWZPMG5mdVU1TTlVUEt2MGo3SW4rOVZCdzZQLzlr?=
 =?utf-8?B?empEMy9jRG5vL0xqQ0d1UXBWNmtMdGFlUndQL2h6cCs0N2xlUEY2UkxVS0Q4?=
 =?utf-8?B?Tkl3NDQ4MndKR2MrSmloY2Z0cUJBZW5oY1NCam9MaXFaNWl2TWY5VVZ2ZFo4?=
 =?utf-8?B?azZSaWs4WTR4N055Z2xuMWo5c29RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccecc30-10b4-474f-d493-08dcec525245
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 13:15:49.1170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8L9mc5euw3n9BCBVEIn7XSPdOoO9L4ASBzL7TliK4ZbA7RZPZoZBbYaVTLSB/co85vDEGMU05ruJzSiTAGHv9TRLoAPOtKSlNvc6owNpMPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8235
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4g
PGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBTZW50OiBTdW5kYXksIE9jdG9iZXIgMTMs
IDIwMjQgNjowOCBQTQ0KPiBUbzogVXN5c2tpbiwgQWxleGFuZGVyIDxhbGV4YW5kZXIudXN5c2tp
bkBpbnRlbC5jb20+DQo+IENjOiBXZWlsLCBPcmVuIGplciA8b3Jlbi5qZXIud2VpbEBpbnRlbC5j
b20+OyBUb21hcyBXaW5rbGVyDQo+IDx0b21hc3dAZ21haWwuY29tPjsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW2NoYXItbWlzYy1uZXh0XSBtZWk6IHVzZSBr
dm1hbGxvYyBmb3IgcmVhZCBidWZmZXINCj4gDQo+IE9uIFN1biwgT2N0IDEzLCAyMDI0IGF0IDAy
OjIyOjI3UE0gKzAwMDAsIFVzeXNraW4sIEFsZXhhbmRlciB3cm90ZToNCj4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiA+ID4gU2VudDogU3VuZGF5LCBPY3RvYmVyIDEzLCAy
MDI0IDM6MTQgUE0NCj4gPiA+IFRvOiBVc3lza2luLCBBbGV4YW5kZXIgPGFsZXhhbmRlci51c3lz
a2luQGludGVsLmNvbT4NCj4gPiA+IENjOiBXZWlsLCBPcmVuIGplciA8b3Jlbi5qZXIud2VpbEBp
bnRlbC5jb20+OyBUb21hcyBXaW5rbGVyDQo+ID4gPiA8dG9tYXN3QGdtYWlsLmNvbT47IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFN1YmplY3Q6IFJlOiBbY2hhci1taXNjLW5l
eHRdIG1laTogdXNlIGt2bWFsbG9jIGZvciByZWFkIGJ1ZmZlcg0KPiA+ID4NCj4gPiA+IE9uIFN1
biwgT2N0IDEzLCAyMDI0IGF0IDAyOjUzOjE0UE0gKzAzMDAsIEFsZXhhbmRlciBVc3lza2luIHdy
b3RlOg0KPiA+ID4gPiBSZWFkIGJ1ZmZlciBpcyBhbGxvY2F0ZWQgYWNjb3JkaW5nIHRvIG1heCBt
ZXNzYWdlIHNpemUsDQo+ID4gPiA+IHJlcG9ydGVkIGJ5IHRoZSBmaXJtd2FyZSBhbmQgbWF5IHJl
YWNoIDY0SyBpbiBzeXN0ZW1zDQo+ID4gPiA+IHdpdGggcHhwIGNsaWVudC4NCj4gPiA+ID4gQ29u
dGlndW91cyA2NGsgYWxsb2NhdGlvbiBtYXkgZmFpbCB1bmRlciBtZW1vcnkgcHJlc3N1cmUuDQo+
ID4gPiA+IFJlYWQgYnVmZmVyIGlzIHVzZWQgYXMgaW4tZHJpdmVyIG1lc3NhZ2Ugc3RvcmFnZSBh
bmQNCj4gPiA+ID4gbm90IHJlcXVpcmVkIHRvIGJlIGNvbnRpZ3VvdXMuDQo+ID4gPiA+IFVzZSBr
dm1hbGxvYyB0byBhbGxvdyBrZXJuZWwgdG8gYWxsb2NhdGUgbm9uLWNvbnRpZ3VvdXMNCj4gPiA+
ID4gbWVtb3J5IGluIHRoaXMgY2FzZS4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
QWxleGFuZGVyIFVzeXNraW4gPGFsZXhhbmRlci51c3lza2luQGludGVsLmNvbT4NCj4gPiA+ID4g
LS0tDQo+ID4gPiA+ICBkcml2ZXJzL21pc2MvbWVpL2NsaWVudC5jIHwgNCArKy0tDQo+ID4gPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4N
Cj4gPiA+IFdoYXQgYWJvdXQgdGhpcyB0aHJlYWQ6DQo+ID4gPiAJaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjQwODEzMDg0NTQyLjI5MjEzMDAtMS0NCj4gPiA+IHJvaGlhZ2FyQGNocm9t
aXVtLm9yZy8NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDgxMzA4NDU0
Mi4yOTIxMzAwLTEtcm9oaWFnYXJAY2hyb21pdW0ub3JnLw0KPiA+ID4NCj4gPiA+IE5vIGF0dHJp
YnV0aW9uIGZvciB0aGUgcmVwb3J0ZXI/ICBEb2VzIGl0IHNvbHZlIHRoZWlyIHByb2JsZW0/DQo+
ID4gPg0KPiA+IFRoaXMgcGF0Y2ggaXMgYSByZXN1bHQgZnJvbSBub24tcHVibGljIGJ1ZyByZXBv
cnQgb24gQ2hyb21lT1MuDQo+IA0KPiBUaGVuIG1ha2UgdGhhdCBidWcgcmVwb3J0IHB1YmxpYyBh
cyBpdCB3YXMgZGlzY3Vzc2VkIGluIHB1YmxpYyBhbHJlYWR5IDopDQo+IA0KVW5mb3J0dW5hdGVs
eSwgaXQgaXMgbm90IG15IGNhbGwuDQpGb3Igbm93LCBJJ2xsIGFuY2hvciB0aGlzIG9uIFsxXQ0K
DQo+ID4gPiBBbHNvLCB3aGVyZSBpcyB0aGlzIG1lbW9yeSBwcmVzc3VyZSBjb21pbmcgZnJvbSwg
d2hhdCBpcyB0aGUgcm9vdCBjYXVzZQ0KPiA+ID4gYW5kIHdoYXQgY29tbWl0IGRvZXMgdGhpcyBm
aXg/ICBTdGFibGUgYmFja3BvcnRzIG5lZWRlZD8gIEFueXRoaW5nIGVsc2U/DQo+ID4gPg0KPiA+
IFRoZSBDaHJvbWVPUyBpcyBleHRyZW1lbHkgc2hvcnQgb24gbWVtb3J5IGJ5IGRlc2lnbiBhbmQg
Y2FuIHRyaWdnZXINCj4gPiB0aGlzIHNpdHVhdGlvbiB2ZXJ5IGVhc2lseS4NCj4gDQo+IFNvIG5v
cm1hbCBhbGxvY2F0aW9ucyBhcmUgZmFpbGluZz8gIFRoYXQgZmVlbHMgd3JvbmcsIHdoYXQgY2F1
c2VkIHRoaXM/DQoNCjY0SyBpcyBvcmRlciA0IGFsbG9jYXRpb24gYW5kIG1heSBmYWlsIGFjY29y
ZGluZyB0byBbMV0uDQoNCj4gPiBJIGRvIG5vdCB0aGluayB0aGF0IHRoaXMgcGF0Y2ggZml4ZXMg
YW55IGNvbW1pdCAtIHRoZSBwcm9ibGVtYXRpYyBjb2RlIGV4aXN0cw0KPiA+IGZyb20gdGhlIGVh
cmxpZXN0IHZlcnNpb25zIG9mIHRoaXMgZHJpdmVyLg0KPiA+IEFzIHRoaXMgcHJvYmxlbSByZXBy
b2R1Y2VkIG9ubHkgb24gQ2hyb21lT1MgSSBiZWxpZXZlIHRoYXQgbm8gbmVlZA0KPiA+IGluIHdp
ZGUgYmFja3BvcnQsIHRoZSBDaHJvbWVPUyBjYW4gY2hlcnJ5LXBpY2sgdGhlIHBhdGNoLg0KPiA+
IEZyb20geW91ciBleHBlcmllbmNlLCBpcyB0aGlzIHRoZSByaWdodCBzdHJhdGVneT8NCj4gDQo+
IE5vLg0KDQpTdXJlLCBJJ2xsIHVzZQ0KRml4ZXM6IDMwMzBkYzA1NjQ1OSAoIm1laTogYWRkIHdy
YXBwZXIgZm9yIHF1ZXVpbmcgY29udHJvbCBjb21tYW5kcy4iKQ0Kd2hlcmUgdGhlIGZpcnN0IHRp
bWUgc3VjaCBidWZmZXIgYWxsb2NhdGVkIGFuZCBhZGQgc3RhYmxlIGhlcmUgaW4gdjIuDQoNCi0g
LSANClRoYW5rcywNClNhc2hhDQoNCg0K

