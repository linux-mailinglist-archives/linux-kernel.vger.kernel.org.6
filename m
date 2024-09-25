Return-Path: <linux-kernel+bounces-338385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018D4985728
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 12:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243DB1C2190A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8129418308A;
	Wed, 25 Sep 2024 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UhNi6OHh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96C212D758
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727260217; cv=fail; b=feZ38c2ZTeEiF++S+uF3i2gzprN22RPAqHIksI5jc03ovb9Sj+W3mkE63Che4HI7iRztv7DMLGoLEA/eZVydZVGDpTZlGMTl4wiqaqLgjbAVQgBz0sDKC0lmRGfgDmeqSX0U+EMCfcXuNYfX95EvKBhNMiWTYx6HrmC2isnXv1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727260217; c=relaxed/simple;
	bh=mewiInsjcEQ8l3JO/PGzxY6ZE3li/sjPCcp90DZLJEA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UM85H7/qnEUAuaSa9eZvar1T7cHEGCQ+ek5CZx3Zw/Ha861R96JiKMI6yIYeHe9O51U7KcJ5DndOrd57ff2VC/u/36xClTNu3YWjqCIyGXLlFainT2ssO0A0ewfRYuq07MxS3zUnYT2INhk4+t0QoWJO7/95maAC5Uy6LGOWM5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UhNi6OHh; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727260217; x=1758796217;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mewiInsjcEQ8l3JO/PGzxY6ZE3li/sjPCcp90DZLJEA=;
  b=UhNi6OHh7TOtIvV3Qne3Dw8c6WX1tuUQzjfmdby7gPtZi084m0nUR4RH
   tqeGDr9I8A4mthYITX3iNXkTizN5dxCzFlRn5DfDi3qDGma0du++I7sxR
   LZQcA+ANoq+Fi39CXOGcOKw+KWaz6vUY1qmHbewpeN28otpL2q5Q/B/Yq
   lxgBWZn+sAk5fz3jhUqTW1k/Fhsjg1V9YeqcGfdMiOG+24gOFw1iUMIl/
   r6nH9+tEVgws7U+3tQQsCupPDaV+FS+4k8imgZsYYqsTtbuy9ev5Yl6op
   CoPnNrKXMtyu8xij4IUOEoZTjGRLIuaRgE8s5KvJ47Fp6RKHb1PXtkFId
   Q==;
X-CSE-ConnectionGUID: BCL5mkTYQMW+en7UpvNDjg==
X-CSE-MsgGUID: dQnP1L/fQAWQgXpp1sdy+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="43775381"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="43775381"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 03:30:11 -0700
X-CSE-ConnectionGUID: /AzihHeoTBekgpIqv3+VVw==
X-CSE-MsgGUID: R/HjttDxRUmVVc4j9ARyWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="95055016"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 03:30:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 03:30:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 03:30:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 03:30:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 03:30:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3Muuc6tQSMC85CHUdpNJsy+xUXsp1rZxFleiKM7595ZEZG1qhkswfQ0f5TBL4LNLl0IlxErQyB5mdeInDh2J/WeTDXpJUtqVcXYQy7/AOY656DOvOBdBgm1XQqhRvBXoE6VGTc09z6/q/0qpSHaelNePEWBaliJm6Q1K86vxaUDpRFLoNu295RV7JYyH4xJnpgAx+cYIvQ5rbFWl+TgRVA/JRG3vRw1dtdr1WsB80cG8nQWLM/0VdihY1KbCbV15xfNoBTJ+xYgCJ+wgJUvV86UKMD1RJH3b0E+DwlDOvWyfhyHtu4N+MTcRslSFglArPqpGpTaVNk4U0xIiHvkwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mewiInsjcEQ8l3JO/PGzxY6ZE3li/sjPCcp90DZLJEA=;
 b=EyZPwH+FlZNgkm6wU04+TJJ1/HYNeZVexCFsINYsb/bdQbz7uBFMsv8bCRe2yArquefJ7qq1bkDtR7XZ3ZfiPyX6FcCdEujBKdREg8L9pyCyAC+RzrJ6ooJaQ6IvIWpXanVjOC+pFnufo48qGwmSSH013QxojvOCCPz7wk7Dc7ZQUm4zVRkaCU/uhLJHVQ2Ni9XupHNQR7PymOxIdF8pCoZGDugrj5KHZP2SIPU3FdbsB+37w8XOs3ZB41BYW5mPUqKjWDeEKz+r4pQcPq6JH8N7cWHEfqYor4fM3DA/619AYqKNiwVK/p5WSb6xYuBbHiKudv5WME6MoMh3gIk6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by PH7PR11MB5914.namprd11.prod.outlook.com (2603:10b6:510:138::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Wed, 25 Sep
 2024 10:30:03 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 10:30:03 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Rohit Agarwal <rohiagar@chromium.org>, "Winkler, Tomas"
	<tomas.winkler@intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lubart,
 Vitaly" <vitaly.lubart@intel.com>
Subject: RE: [RFC] Order 4 allocation failures in the MEI client driver
Thread-Topic: [RFC] Order 4 allocation failures in the MEI client driver
Thread-Index: AQHa7V087DCPK9soEEeGNq7wh9SvYLIumSEAgAKfx4CAAGPmAIAAAN0ggAHra4CAAEfKkIAy3lSAgAAVciA=
Date: Wed, 25 Sep 2024 10:30:03 +0000
Message-ID: <CY5PR11MB63665172F7608BD64E8BCF27ED692@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20240813084542.2921300-1-rohiagar@chromium.org>
 <75f758e5-a26f-4f41-8009-288ca2a4d182@app.fastmail.com>
 <4d6f3331-5a9c-46f2-8e27-3484ba6f6eab@chromium.org>
 <25e56199-7af1-4235-8973-cbc351325b8c@app.fastmail.com>
 <PH7PR11MB76050864E8DC9F7389314BF2E58F2@PH7PR11MB7605.namprd11.prod.outlook.com>
 <4a66eea2-c23b-4c34-a5c6-508bf2a6fc47@app.fastmail.com>
 <PH7PR11MB7605F68E96E24CEF6C92F8AAE58F2@PH7PR11MB7605.namprd11.prod.outlook.com>
 <6ff0dd7c-0548-4d59-8a32-747b4869e7b9@chromium.org>
In-Reply-To: <6ff0dd7c-0548-4d59-8a32-747b4869e7b9@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|PH7PR11MB5914:EE_
x-ms-office365-filtering-correlation-id: 51ae2808-f201-44f7-5ce3-08dcdd4d0439
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dXlZeUxERWpPci9JQUtNcGRQdEpIcCs1bnBLRkpSSjNuZUZDNHJCVW40eStm?=
 =?utf-8?B?ZGtlY1FtbmFSL3dMSzQwd29uYlBoQVZ1MXlzbUdMTGRXZzNOWFNMbHptTUNL?=
 =?utf-8?B?bkVjT3IraTFaMUZGK0syK0p1bm5ERXJjbDRiUzc0aWFRVE95dDBBYXo3QTcy?=
 =?utf-8?B?K2ord215TlhmM3JtcGF1dFBkL1ZYT1R3d0FlYSttaHE2UzdjSmRCNjI3SEYr?=
 =?utf-8?B?YUlqcHcwNnJBWk9pd1pqRC9RTmZmT3h6SHZaNWV2QTAraFJLZzB4NWk4VEZi?=
 =?utf-8?B?MzB5bFVqQ2JXNUZhNG02TUhaaC9xSURKdW41N2h6YUpGem4wNmppZllRWTRE?=
 =?utf-8?B?cHRCSnVuMmoyUHo1Nmd1b2drVE96WEpsN2VOS1MwRWhrY2kwRmVIU3ZLdkIy?=
 =?utf-8?B?dFJLODFIT3N6emx6eFkrSXlROHM4MHJLcmVnUTRidWN6QlU2Z2lmOXg5UUx5?=
 =?utf-8?B?Qk9aNE1sYlU1OEQ2OVd6RU15QloxVzAwejFrM3BSdDlrQmd3M1pEQ2ZLUSs2?=
 =?utf-8?B?VjNYUjZhQVg3MFE4amZRdmxTTmZ3WnBoSFhOcklyMHlWVjcvcjhRdDd3WW9t?=
 =?utf-8?B?RkdQTXF3WkpMVFR6c0dDZWdDMW1NeEovMThaV245Sk85SUpUbUY4MkFDOUxL?=
 =?utf-8?B?d3pzcll6Uk1IRlM2UzhCQUFWZTIra1BGWmJKNGlTRnJWQUgwbUkvYlVsb1F3?=
 =?utf-8?B?S2RzTW9Qc0YwaS9nN3V3eXZpSk5wbW1DejZiNWlObWtLa29Cbk9EVkRIUi9R?=
 =?utf-8?B?a1pUYW5pQ09kb3VFOTgxZ2t3bkZYUVZiMmJ3Q2pSaHJDNTNOVDhyMG1wMEpM?=
 =?utf-8?B?dm5oVFIycGdieEVSZHFaR2t4akxjUi9xRUM5c0ZOYTMrNkJrSktWUXV3ejZZ?=
 =?utf-8?B?MXpsR3owOG5SeXdrK2doZTBZdzJ4Z1hHL2dxbDNSbGMwbXYyMXNnbEVsOWFR?=
 =?utf-8?B?eDBZREdSY0tDTWVqeFppNFhnYk4rUEtQQzUyRElMMkdQVWdXbTlpTGh2MXRr?=
 =?utf-8?B?WngraXVzNnpya2NabzN4MGIrQ25TcFVycVB1NnZOUSt0ZllxbEtrdk9qUG1q?=
 =?utf-8?B?SGMxZTArSlVVMzByNnNnU2RPOFBER0NHdFRua01nU3I3SmJkblJ0TFhmbkN6?=
 =?utf-8?B?N08xRkcwT2NDa2tRdjBTNmxvR0xHWVVWVzQvZVJlZGdndjFhL1grUDg2M2Vn?=
 =?utf-8?B?c2tWRk9QbDdoa0VjNWVWY0JMbFNoK1paWUVGWTZDeSsrZXpXazhFZmtHUEpY?=
 =?utf-8?B?NWVSVklReEQrdzl5aXBqSDg5YXVJaWpuZHE3U0p2bE1LZGhUM2ZZRXY4anFm?=
 =?utf-8?B?amhkaEJXM3JGS096d0NQQ3oweW9sNmptaFhXaXgwUjRnSmJEZEJGa1FXZWZP?=
 =?utf-8?B?MUZPKzVoQXRHOHZGMFU3TFBaTTAzS09yQStpVDNzNjJ0S2Q0dE1uVW5sNlpZ?=
 =?utf-8?B?aXJKcVFnd0liRjJjSmh6OXJPMXVrWGdNSDlPYmZRWUVvblNKc1pwL0JVSk5I?=
 =?utf-8?B?ZmVZNnVvclhIQUtHbVEwZXpVRTcrdEVwM3NNT21nY0gyNVZMV1RjL3hCM2do?=
 =?utf-8?B?TllObWtDdjBKVVN3dHJib0N4dy83MTJEcUU5VlRKb0dwWi9NaEhmczdUekRY?=
 =?utf-8?B?QldCRkNSSUFSUkZFQTRmQ1FsVzB4YWcrZG16bmlldE5IZEFFQzliKyt0N2Ez?=
 =?utf-8?B?czBqWU43enhUbExoZFVuWXJDWDBkL3pIV2R6MFkxZmdRak52dGJJWWlIaVdN?=
 =?utf-8?B?NWd6K2lUQWVLNkZwZy83SE5jRU9FbnVQQ2huUS9zYzNTamlHUmlTckg4NmJz?=
 =?utf-8?B?ek5kbnUvb1lQQzJjV08vdjNTOFVxK3Mzdko5UHJrZ1BsZE1Ba3N5SVMwRXJu?=
 =?utf-8?B?RmhqWWxnWlRZL2ZZQ2NkUTRZTFBTQ0c4cy81blNqRXllNmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkliOWFZQnR3clNaQjFaMUk3dmlPOUwwbDc5TmVhL282SGhWcEswbE9YMWR1?=
 =?utf-8?B?VEo5MVRHc0ZkRFNONjEvR1JFSU05M1NGOUsvNXBHalNPNm9rS0l6WXhVa3cv?=
 =?utf-8?B?SHE2NERNakJqc2NrekdYaGF3ZWFudncyTXdMc3lSd2Z4N3dLYVFjQ2Eyamk1?=
 =?utf-8?B?ZzA5d0xNajRqQ0ZtZ2N2SS8wU0o0akpxcm1iQWY0eEVmRG02N1ViT3dxa2xx?=
 =?utf-8?B?cWhQWWh5L2FUY3lWMk1PYVp5MTZjaGJURjhGb0kzUTVmSDlCZElnN0pmM0V2?=
 =?utf-8?B?cERhdjRpUFZLTlNKTVNxRk0wSXFkeEQ0bnpncUxOZ0doOGN5UXh6dkQ1Ynd4?=
 =?utf-8?B?MTlMNUZKdkI3R0VXTHp5UFdnb1ArQ2g3NW5xUlA2NmlObmlmNUVveVkxeWlx?=
 =?utf-8?B?WDdqQUwwRE1hMHN4RkswQmRJYWVmaWNVdXFSOFVVMXJyWFFyRGpKWlFHOGpQ?=
 =?utf-8?B?VW5sWXUzT2JPaGczd1BWRG11dFFqbVB2MElwY1p0SFdON2hGUlZOUFJoZlJi?=
 =?utf-8?B?QjlTWVZjaFN5OFN5VzdUcThUbDBDS250UmtydUkvcnYzaEJUQlByOHBXajhz?=
 =?utf-8?B?cFovekljVEZrT3BUMHJkcmRKcmRtWmdYdnJoTk5iR1AzVW1aK0MrVEcxMjMr?=
 =?utf-8?B?eTBTUlRESUFRd3VmNjhTTWF4cVhRWWlrRExTRUZoRTN1eGtHd1J5VFRvTTRM?=
 =?utf-8?B?bVZFOG5xeUd2NW1ONkFGSjhJbVBUT0ZpNUdoZWRQSVRybExVV3NiVEUzOVlu?=
 =?utf-8?B?TmdLRG9uM2xBbE5QRmlObVdiR2didWdEWHpyczB4eS9BdEVsdVhaY3I1VVZl?=
 =?utf-8?B?ajJsWmFoa3JJWkNBenc3R2k4N1lEeHJuS3QvcTVzandQbkhSbU5QMXFzSXF4?=
 =?utf-8?B?MDJESEFpanBwMWtvWkZsOEM1aDNIT0c1NjRWTHZzeUp3QmRBNjd2bjZmQ1A4?=
 =?utf-8?B?dlFTQnM4ZWJmbFB4b1o5OFJ1T1hRWkRUekhRbGx4bXl4cWFwUDR3V1RmQ2NT?=
 =?utf-8?B?UnJXc0NCbzdjaDFJVUlkWVpXVE4zVlY0QlEvYWRhWXUrdDFmTkEvZDlOemQ0?=
 =?utf-8?B?OFJzcmw5Ly9RWDhXLzVZNnhsVkV2UWJkZWI2OHRJMThvOWNEczd6OXlocWYv?=
 =?utf-8?B?L1VOWGprbGl1SXFXRUc2OFM4U1BNY3N5UENvQ2dYRzBjMkZEMlI4ZHVOZDBm?=
 =?utf-8?B?d0gyVWZqZFJScWNvZjI5U2tTN09zK1NiZkk1Z0pLNzFTa3YzZ29QTzlZN0Nx?=
 =?utf-8?B?cHJoY3hTNTh2bVJUc05rQm1HS242d0VUZndBQWE5MStQVktWUjdFSmhzOUdo?=
 =?utf-8?B?eXZqbXp6Ykhkak1ZTnEzMmJpK05sQWN4TWZBTitma2F6Qm1PMXV4NjFQQ1R4?=
 =?utf-8?B?YmtnV1UxYWVTOXVpa2syOUxmNU9ubStySlRzRnFwajdZbGR4WTRXWnIxeE1u?=
 =?utf-8?B?QlFJM2VMUDJ6Z2hUNHFwa2prRFExL016bVM0U2p5KzNyL1lhTWJUSTNhRkhT?=
 =?utf-8?B?NjlXN01mM3d1V3hGZHY2dFNPa2ZxRkgzbklwYW85MHYzYS9yZjVHcE9IVEFl?=
 =?utf-8?B?a3pYOG9mL0ErMWlSc0VsMFNqbUxrb1pDWG4yc2FTN3I2UlZ4NDQvR0pQdGxY?=
 =?utf-8?B?dkdhZVJmakVGQkxkTFg3T0U5SkNIWHh0dWtIc0dmdVRwMmp4S2RLWnJGUUVl?=
 =?utf-8?B?YmN0KzN2dHR0M0Y4Uk9uUno4bldMZ3h6REZFSzJaVUNpR00rejJ2WjZtTmlw?=
 =?utf-8?B?TmZDcTBXZHQ4d0QrNUg5SWxuZy9qUW80ZER0NFVWaTVSelBGa2pKS1dXa3dZ?=
 =?utf-8?B?dGxXQnl6cnhmNU1sZjZJbG92Z0FRNDBBMElSMUV6MlJzUlRqWGF4OENhODZl?=
 =?utf-8?B?d1FwWExNbDFwT3NFVi82MCtQVHJnQ3lFdmNlQlZqZGExTFFxb2ZrK2JCL01O?=
 =?utf-8?B?RFhibktvaHg4NDJEZ0Zrc2ZTdmpCYm9FQldqS0R3N0E1Vm5lUHVvcG5Gc0dm?=
 =?utf-8?B?Y2ZsaGtYNjV4SDJ5K2pTRTVrZWhCYS93YmdibzlORlhSZ2hmcCt3SFVqTWl1?=
 =?utf-8?B?aTNYOXgvLzJ3SXhCbEtlT0crVXJYMEtweFJKRzNqQlNiMzhuVTc2VFY5dWVs?=
 =?utf-8?B?NGRhSXBCVEFPSlpZOG1wZENFZXZBeVFZYjNPcEN6Ym45MkFnblRtUittNk9S?=
 =?utf-8?B?eGNjbm5iREZJZXpaN1NZRzBEd0JoK2lVWkFVeGVnUDUvRFQ3cFAydUwrMDBW?=
 =?utf-8?B?UHJOTnA0VVZQVVhObnM1c2ZnNU1BPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ae2808-f201-44f7-5ce3-08dcdd4d0439
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 10:30:03.2518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8rj3ZEKazznDOqSa26aeoYPKC55A8Xun6APcXqUQAoWp2QB7p/u/audnNyKKjKBcxiHp6rMspSzo9lurTDLk4O6t2YnkS0inz+9AfWOKrUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5914
X-OriginatorOrg: intel.com

PiBPbiAyMy8wOC8yNCAyOjMwIEFNLCBXaW5rbGVyLCBUb21hcyB3cm90ZToNCj4gPj4+PiBPbiBX
ZWQsIEF1ZyAyMSwgMjAyNCwgYXQgMDU6MjAsIFJvaGl0IEFnYXJ3YWwgd3JvdGU6DQo+ID4+Pj4+
IE9uIDE5LzA4LzI0IDY6NDUgUE0sIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+ID4+Pj4+PiBPbiBU
dWUsIEF1ZyAxMywgMjAyNCwgYXQgMTA6NDUsIFJvaGl0IEFnYXJ3YWwgd3JvdGU6DQo+ID4+Pj4+
Pg0KPiA+Pj4+Pj4gV2hhdCBpcyB0aGUgY2FsbCBjaGFpbiB5b3Ugc2VlIGluIHRoZSBrZXJuZWwg
bWVzc2FnZXM/IElzIGl0DQo+ID4+Pj4+PiBhbHdheXMgdGhlIHNhbWU/DQo+ID4+Pj4+IFllcyB0
aGUgY2FsbCBzdGFjayBpcyBzYW1lIGV2ZXJ5dGltZS4gVGhpcyBpcyB0aGUgY2FsbCBzdGFjaw0K
PiA+Pj4+Pg0KPiA+Pj4+PiA8ND5bIDIwMTkuMTAxMzUyXSBkdW1wX3N0YWNrX2x2bCsweDY5LzB4
YTAgPDQ+WyAyMDE5LjEwMTM1OV0NCj4gPj4+Pj4gd2Fybl9hbGxvYysweDEwZC8weDE4MCA8ND5b
IDIwMTkuMTAxMzYzXQ0KPiA+Pj4+PiBfX2FsbG9jX3BhZ2VzX3Nsb3dwYXRoKzB4ZTNkLzB4ZTgw
DQo+ID4+Pj4+IDw0PlsgMjAxOS4xMDEzNjZdIF9fYWxsb2NfcGFnZXMrMHgyMmYvMHgyYjAgPDQ+
WyAyMDE5LjEwMTM2OV0NCj4gPj4+Pj4gX19rbWFsbG9jX2xhcmdlX25vZGUrMHg5ZC8weDEyMCA8
ND5bIDIwMTkuMTAxMzczXSA/DQo+ID4+Pj4+IG1laV9jbF9hbGxvY19jYisweDM0LzB4YTAgPDQ+
WyAyMDE5LjEwMTM3N10gPw0KPiA+Pj4+PiBtZWlfY2xfYWxsb2NfY2IrMHg3NC8weGEwIDw0Plsg
MjAxOS4xMDEzNzldIF9fa21hbGxvYysweDg2LzB4MTMwDQo+ID4+Pj4+IDw0PlsgMjAxOS4xMDEz
ODJdIG1laV9jbF9hbGxvY19jYisweDc0LzB4YTAgPDQ+WyAyMDE5LjEwMTM4NV0NCj4gPj4+Pj4g
bWVpX2NsX2VucXVldWVfY3RybF93cl9jYisweDM4LzB4OTANCj4gPj4+PiBPaywgc28gdGhpcyBt
aWdodCBiZSBhIHJlc3VsdCBvZiBtZWlfY2xfZW5xdWV1ZV9jdHJsX3dyX2NiKCkgZG9pbmcNCj4g
Pj4+Pg0KPiA+Pj4+ICAgICAgICAgIC8qIGZvciBSWCBhbHdheXMgYWxsb2NhdGUgYXQgbGVhc3Qg
Y2xpZW50J3MgbXR1ICovDQo+ID4+Pj4gICAgICAgICAgaWYgKGxlbmd0aCkNCj4gPj4+PiAgICAg
ICAgICAgICAgICAgIGxlbmd0aCA9IG1heF90KHNpemVfdCwgbGVuZ3RoLCBtZWlfY2xfbXR1KGNs
KSk7DQo+ID4+Pj4NCj4gPj4+PiB3aGljaCB3YXMgYWRkZWQgaW4gMzAzMGRjMDU2NDU5ICgibWVp
OiBhZGQgd3JhcHBlciBmb3IgcXVldWluZw0KPiA+Pj4+IGNvbnRyb2wgY29tbWFuZHMuIikuIEFs
bCB0aGUgY2FsbGVycyBzZWVtIHRvIGJlIHBhc3NpbmcgYSBzaG9ydA0KPiA+Pj4+ICJsZW5ndGgi
IG9mIGp1c3QgYSBmZXcgYnl0ZXMsIGJ1dCB0aGlzIHdvdWxkIGFsd2F5cyBleHRlbmQgaXQgdG8N
Cj4gPj4+PiBjbC0+bWVfY2wtPnByb3BzLm1heF9tc2dfbGVuZ3RoIGluIG1laV9jbF9tdHUoKS4N
Cj4gPj4+Pg0KPiA+Pj4+IE5vdCBzdXJlIHdoZXJlIHRoYXQgcGFydCBpcyBzZXQuDQo+ID4+PiBJ
dCdzIGFsbG9jYXRpbmcgbWF4aW11bSBoZWFkZXIgZm9yIHJlY2VpdmluZyBidWZmZXIgc28gaXQg
Y2FuDQo+ID4+PiBhY2NvbW1vZGF0ZSBhbnkgcmVzcG9uc2UuDQo+ID4+PiBMb29rcyBsaWtlIHRo
aXMgcGFydCBjYW4gYmUgb3B0aW1pemVkIHdpdGggcHJlIGFsbG9jYXRlZCBidWZmZXIgcG9vbC4N
Cj4gPj4gSSB1bmRlcnN0YW5kIHRoYXQgaXQncyBhbHdheXMgdHJ5aW5nIHRvIGFsbG9jYXRlIHRo
ZSBtYXhpbXVtLCB0aGUgcXVlc3Rpb24NCj4gaXMNCj4gPj4gd2hldGhlciB0aGVyZSBpcyBldmVy
IGEgbmVlZCB0byBzZXQgdGhlIG1heGltdW0gdG8gbW9yZSB0aGFuIGEgcGFnZS4NCj4gUHJlLQ0K
PiA+PiBhbGxvY2F0aW5nIGEgYnVmZmVyIGF0IHByb2JlIHRpbWUgd291bGQgYWxzbyBhZGRyZXNz
IHRoZSBpc3N1ZSwgYnV0IGlmIGl0J3MNCj4gPj4gcG9zc2libGUgdG8ganVzdCBtYWtlIHRoYXQg
YnVmZmVyIHNtYWxsZXIsIGl0IHdvdWxkbid0IGJlIG5lZWRlZC4NCj4gPj4NCj4gPj4gSXMgdGhl
IDY0S0IgYnVmZmVyIHNpemUgcGFydCBvZiB0aGUgQ2hyb21lIHNwZWNpZmljIGludGVyZmFjZSBh
cyB3ZWxsLCBvciBpcw0KPiB0aGF0DQo+ID4+IHBhcnQgb2YgdGhlIHVwc3RyZWFtIGtlcm5lbCBp
bXBsZW1lbnRhdGlvbj8NCj4gPiBUaGUgdXBzdHJlYW0gc29sdXRpb24gaXMgZm9yIG5ld2VyIGdy
YXBoaWNzIGNhcmRzIGFuZCBvdmVyYWxsDQo+IGltcGxlbWVudGF0aW9uIGlzIGRpZmZlcmVudC4N
Cj4gPiBJJ20gdHJ5aW5nIHRvIGNvbGxlY3QgbW9yZSBpbmZvcm1hdGlvbiBteXNlbGYsIGl0J3Mg
c3VtbWVyIHZhY2F0aW9uIHRpbWUsIHNvDQo+IGl0IHdpbGwgdGFrZSBmZXcgZGF5cy4NCj4gPiBU
aGFua3MNCj4gPiBUb21hcw0KPiA+DQo+IEEgZ2VudGxlIHJlbWluZGVyLg0KPiANCj4gVGhhbmtz
LA0KPiBSb2hpdC4NCg0KVGhlIEZXIGd1eSBzYXkgdGhhdCB0aGUgYmlnZ2VzdCBidWZmZXIgdGhl
cmUgaXMgMzNLLCBhbmQgdGhpcyBpcyBhbHJlYWR5IG9yZGVyIDQgYWxsb2NhdGlvbi4NClRodXMs
IHRoZSBNVFUgc2l6ZSBjYW4ndCBiZSByZWR1Y2VkLg0KVGhlIG9ubHkgdGhpbmcgdGhhdCB3ZSBj
YW4gZG8gaXMgdG8gYXNrIHB4cCB0byBzZW5kIHRvIG1laSBleHBlY3RlZCBtZXNzYWdlIHNpemUg
YW5kDQptZWkgd2lsbCBhbGxvY2F0ZSBvbmx5IHRoYXQgc2l6ZS4gVGhpcyBjYW4gbGVhZCB0byB1
bmV4cGVjdGVkIGJlaGF2aW91ciBpbiBkcml2ZXINCndoZW4gRlcgc2VuZHMgbW9yZSBkYXRhIHRo
ZW4gZXhwZWN0ZWQgYnkgcHhwLg0KVGhpcyBzdGlsbCBtYXkgZmFpbCBvbiBiaWcgYnVmZmVyIHJl
cXVlc3RlZCBieSBweHAsIG5vdCBzdXJlIHdoYXQgaXMgdGhlIHJlYWwgbWVzc2FnZQ0KdGhhdCBM
aW51eCBweHAgbW9kdWxlIGlzIHVzaW5nLg0KDQpJcyB0aGlzIGVycm9yIGNhbiBiZSBlbGltaW5h
dGVkIGJ5IHJldHJ5IGZyb20gUFhQIHNpZGU/IA0KDQoNCi0tIA0KQWxleGFuZGVyIChTYXNoYSkg
VXN5c2tpbg0KDQpDU0UgRlcgRGV2IOKAkyBIb3N0IFNXDQpJbnRlbCBJc3JhZWwgKDc0KSBMaW1p
dGVkDQoNCg0K

