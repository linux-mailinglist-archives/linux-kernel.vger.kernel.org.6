Return-Path: <linux-kernel+bounces-420587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB1C9D7CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368E01636C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2192018C924;
	Mon, 25 Nov 2024 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Yal3NpDN"
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D796187FFA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523517; cv=fail; b=kFsCjkCabKAT23ZSRjMKM2A35dJXD0XkEVCJiSYWg4SWdX131c3vtFY2Q78oOB+K0KNxO2MicV/XFpgLo6OdIOWtgdooEeCAcjRod+Bf4eqfSTXT7abUNdj7l7iXq8j/a5trOtm7sjXp1nSuhylyC/TttOlSKHD+ko5e+KnexMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523517; c=relaxed/simple;
	bh=Li0pIpUhhINhss2bbHZSEHI2o85oUKmIw+DoVcTXpqs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nSLcVjZEKTPwZebVn/LzZnPzzF5K8XkWGDiIbLhJEp5n2UlP0wVJOEZ4CF7cFSrILVa24Eal7iNaoyUvyQo9UAYZFZuZT7R4gA+jZToHRbPJgv/8CPIvw0H6pSm8uustH6wZQShZx9F+UCeecletsW7qJKhw/WXSxeSMhyg1SOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Yal3NpDN; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1732523514; x=1764059514;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Li0pIpUhhINhss2bbHZSEHI2o85oUKmIw+DoVcTXpqs=;
  b=Yal3NpDN0kLLURUZQIpi6qt6jK8O+VmEPapI738b4Itctj/gin0EjZSI
   AfigHmy/DVjXdS580j0G5cJVzvRBXd7GoDFcmCF3AzZlwv4CDVVQYPnEW
   hH49jvuvcB6l2RvtsLSJPsQBrrwukCCrmXGxgHoCak2Ol3msdXa5uF4aB
   vg5orjGWT4G8jO3CpXlhadaxuJzZS6qilRFnR+ZeOt4CecHGix1VlSGu6
   cK1MAl7bh4B7+7v771+v7ifHsTm+zlUs0ue2BciCg5Rhcpov24bX9wMm/
   OKLBV4Ed32N684yJ3NVxhXeCwI2+jdb19gGgYsU5CpD+753xtEWF/2DM3
   g==;
X-CSE-ConnectionGUID: buECG3IfSMqji2GoNiHT1Q==
X-CSE-MsgGUID: Uox0Eln2SV206VT3tWlxdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="49265848"
X-IronPort-AV: E=Sophos;i="6.12,182,1728918000"; 
   d="scan'208";a="49265848"
Received: from mail-japaneastazlp17010005.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 17:30:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ls7xJXzXcJa6WrLOpZdzlDMM3Z47Unkizy5LZJDnEBerLo43if66b4YyDaUZHj6ROwSDHyD0N9DbNsSAwfwCseOw5YlfeYWHc0bpvJPjDHzgTX/yYQhnYQmQ5VO9S1ztNc3Bf5axhCOqiR0u4ukk/Fw+GxdhC6dWEaTelDorTbWg/hmWzt7ZJsyeCqul4GhGv/VKNmsk+qafF0DO83cN6nTJKNiUWR1e4cCxwGKfUYs/ypwKyYbXKSe3FGKLgpBrFfsqs4bOZxn0FuGeSQ4/VD/CvCkmGUUb3b/EirPjaCBdrzY6l9eXf4cg03QRgwmL2pmlRIlula9lRw5iw3wUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Li0pIpUhhINhss2bbHZSEHI2o85oUKmIw+DoVcTXpqs=;
 b=MZa9GLPVDX797NWOeF2Q3NXbLZQamTSOHeDn5e3MIJ5GJJIvxTc+711huvpGwCIPjt0qVt+P7RV/QLf+qoFsWuwTZcbuEHJr/VDPuMd7vm6pKYP8iyGAZDyhZX0kd6iRsDHyc2WX+IiRmU/9E6lnuUC+pnOjYLFP8pLel0fQDly4656XhI+oLBUYA3A9iwlSWqhjs0IMuaG5ZudbMWSIS1TJ0w70NI+1Tx/HFjJozGCeSsD659v26nsDh1PZ8t03ijrajQuPlJ65nEUO/isWrgRLLtPNtHVkCMyRZVR8XLBtP5DgYLA5W9mdRzNgYfqSPro/ml9MY2/PQpRwrF9i1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYWPR01MB7233.jpnprd01.prod.outlook.com (2603:1096:400:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 08:30:38 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 08:30:38 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Masahiro Yamada <masahiroy@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Kris Van Hees <kris.van.hees@oracle.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, kernel test robot
	<lkp@intel.com>
Subject: Re: [PATCH] gitignore: Don't ignore 'tags' directory
Thread-Topic: [PATCH] gitignore: Don't ignore 'tags' directory
Thread-Index: AQHbPwrhl5BhFw4M4kGJMDmD1S/zD7LHp/QAgAACjoA=
Date: Mon, 25 Nov 2024 08:30:38 +0000
Message-ID: <2548d95e-2441-4c23-8df7-1f601a0bd8a3@fujitsu.com>
References: <20241125072308.421686-1-lizhijian@fujitsu.com>
 <CAK7LNASAfvb4Z59QF8cBgFJPLhi-dfOGYwB_J5+1GGanYTe-Aw@mail.gmail.com>
In-Reply-To:
 <CAK7LNASAfvb4Z59QF8cBgFJPLhi-dfOGYwB_J5+1GGanYTe-Aw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYWPR01MB7233:EE_
x-ms-office365-filtering-correlation-id: d3ecb36e-216d-4f11-7759-08dd0d2b7111
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eHJqenVFWFllWGxSZDh4ZmZzKzJyUE1YTkc0NER2cnVyVzFpOUcwTXU4bGdR?=
 =?utf-8?B?Q3BBWVNlK3FkTWxzL3lxWjArd2diVG1UWDl1YVhkMHBad2k2OTZxME5YM0o5?=
 =?utf-8?B?cG8ybThZQXcxRmRISUJEeC9BQzZMYm5tYXc4QnVOTXJSNzJodnN4VlhrdWsy?=
 =?utf-8?B?VzVQUndZLzhmYUlnRTVYbTdBNW5NSnErUGNYWmNrdi9zeHRQaUVRdHh6VEtr?=
 =?utf-8?B?WU1jSEhndldGTklUbTVyTG5oVlJ2SlR3VmVJaWU0ZExpbk9pTkdwdkFwZ3Na?=
 =?utf-8?B?RTVxcXdDMytqUTdqeCt0ZHlFNWRWMVJkc0xjVXRUQXVpY0hqYXExVG9uNWRO?=
 =?utf-8?B?R1o3bkZvT01ZRUUvYjhudzU3NjVUbVZsTmFXV3BFSkVGVitWMnp1WUJ6bm9L?=
 =?utf-8?B?Nmgxa2dkQklYNm41ekZCREg3ZjUwWFpwMFY5bGV4cjZuZjRMZ0xVTTZoMmhX?=
 =?utf-8?B?Um9Zell2T090bWFMRkdsRVdMeHpBSEpqNmNNRUd2MDByc1ErUkhWS3JINDd3?=
 =?utf-8?B?K3pSeEkrby9HNHY0U1RzMmQ2T2wwakZLSHIwQnk4TEZCWVgvc2FNMW9jelNV?=
 =?utf-8?B?MS8xaDBwa3pCMi9odFBXc2tWcUJKeStMZlZtV2ExVlRGOXNIamtyK2Vhengr?=
 =?utf-8?B?L2VBaTdTdXZYOWFwT2FuTThmWmxxQjBZRmo2OVUvbXNTWU94NFRGTkpQbmVL?=
 =?utf-8?B?Ti9aaTdibUlWMjFISDh5aVdsVTdDWmFyYnNZL0NOT2tJbzNHRXRqNVd1NlJR?=
 =?utf-8?B?WVVCYnVHOE5vM1A1eXlvVGRwd3gzTktNTnFibnB5U3ZBLzB3ZXdVUXRRUHVi?=
 =?utf-8?B?Q3IxOVZ0Y2xxNjNRc0hDdmtEZG92RHlvRVNSYXd4NmNScGdxMjRaU3hkOXQ2?=
 =?utf-8?B?RFFEdHdJUzVBRHcwSW9kT2dRcVRPY0lMdjJPWERsK21jK01xcmc1SmtFT25s?=
 =?utf-8?B?bVhNUTBoNjdIeUI1U21Sd00wMVM1S3ZTbW04em5kL3EwZ2hyQXZmWCtRdVFp?=
 =?utf-8?B?NDhpR2Uzc3FVMTh3WXRMTjk4azNYbUdUa21Pa2J2T3JrTWIzTW5pdzRXd1ll?=
 =?utf-8?B?RTQ2eWYrZVBXUFg5S0FtL1l0MktWZHZZWGpmMHVwOERoVkdWbDl5MGZkNlJN?=
 =?utf-8?B?eHFZd3Y5N1dZSWYyemRrdlVwZ0dyWHBqR0NMU0hacndlVW82dW1TWHR5UHNW?=
 =?utf-8?B?T0pmU1ZzTlJrcjcwZk16U2hBK2ZDMGlPYmgvOGFKMkgyZVhwR1gzYnlHZGFF?=
 =?utf-8?B?QXRMSk1JN1NnclZZeDN5dUVoZjloWThId2g1b3hieE1MVWtVT1IrQk9LOGdF?=
 =?utf-8?B?L255dngxaURjMElzUUlJSmhHSjBDNWtzenkvYXZtVGpiQ2N3UDhZeVp5ZFdT?=
 =?utf-8?B?eVNzaEVXbHRWbXZ3dm1ueGplekxqTDJsd2V1YWo4Z2pERzAzQzVkZHVnOWNN?=
 =?utf-8?B?Qndhb05jb3BDb2VGaS9WTGU2QjdodkhHcmE4d21aWHFoQVRoMklWUm0ydG8v?=
 =?utf-8?B?eTk1VjIxbGNXVzU3clZXOUNvQVFSSEk0ZjhRRWo2bVVQSkVOTThUczN1Mmdw?=
 =?utf-8?B?Y3lGMDBQQ1ZSSWMrR2luQmtPWHJnZ0ZEMlg1SFVFUlN6MkI0Q0E4Tkw5bGky?=
 =?utf-8?B?VlFrMkFCUU5wdW5wZWp5TVplUzk5YVRzd0xGQ1dmVG00K1g4bjc4Ny94Kytx?=
 =?utf-8?B?Qzh2elBxeGNqSytLR2RSTUQ5UHB5U3pPOG5qZW05eitDK3lMNzBCUlVGemNG?=
 =?utf-8?B?MElabklDMWt1dWpsVUJBVVF2aWE3VmRIeEhaK2Z6aWhoSzZEazZ4NTMvenNt?=
 =?utf-8?B?aTNKaTdxUXNCNndCeTVyK3UveEpDMEVyZlhVNWhkTE5FeUkzbi9OSC9VT09D?=
 =?utf-8?B?dFRpRTQ4bjZVMWZaTGYxMlN6QldWdWlCdTMyMW04ekRLSWhEUkV5bWpYSjIw?=
 =?utf-8?Q?DrBBPt7QFzeTdGkmBTFrccPNxApZGctS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rkl3VXJCMGxhSm5Fd3hmY1J1VC9pQlJqaFV1bXhUNmYrMldjcWxtQkRxOE85?=
 =?utf-8?B?eG4xV1dWd3BuKzVsUVoyN0Jsa2pmZjBtZ21YLzBUc1YwbnBVcDk0S2UrQ05i?=
 =?utf-8?B?czM5T1ZJbGJuYnl2bnJpZjNOVDNlZkxzVlRyb2lzYjNSendWTHVXZFJtTWs5?=
 =?utf-8?B?RkQ0ODJCS1hqVDc1N2E5NExTMndHOUVaME5PZTlWZ1hJakJSbFVUSzlEbjN5?=
 =?utf-8?B?MmhBUEdyU0t0d09ZdDF0S1JObEhWM1JnWXBOYnZrY2FhOUppc1JaTjM4UFdC?=
 =?utf-8?B?K1lFUHY5L25nSXNkTTRmYXJGL3E1VFptTGRJeTV2MUhvTk4yeHRUM2ZwSURG?=
 =?utf-8?B?cE9Jc3VjOVNFSE9TQ0RCUml2WW1GZHV0Y0hoTGZ6TzZmWWsvdE1yN0phWXBE?=
 =?utf-8?B?NXBxQXkvcmViR0pIZkZSd2lwSDV3WFpNUEo5QnVlZGowem5FMGNpK3F5ajBj?=
 =?utf-8?B?Z09pM3RMWkd4VW5ORzljem5iM2FNaGNndDNSN1dLRHNxbnBhdFJCdGdaY3E0?=
 =?utf-8?B?V2ltOEJyQ2U2RHlxbWRhUE9KdlhwTHozdkZTQW9wdVVMR0JWL2ZtYUozQWhG?=
 =?utf-8?B?OVNFaDh4ZmJ6aWZEWVRLNzZ6cDEyUEFGOVNWd1NxWHpHU1RFMU9DRVU2TEdt?=
 =?utf-8?B?c25HclJqaHVMa2NmZ2V4Q08yNyt6Q0NLRGdOWFFaYkN0VzhzNG9lOENqVE5r?=
 =?utf-8?B?b2VqZ2FUaTRsdVRpNmxwMHJMNUljK0hHN01MRS9zcWFMeXpQZWNLMHdnVUMw?=
 =?utf-8?B?dEFCeFBGdmF3eUNvVklMbGxoZVJsSWI3WGticjZva1FHRU1ETGZMQVFDMmhL?=
 =?utf-8?B?dGdwcURwRmU0anNEcXZ0c3dXMEMyZDkzOWFKdGRmMkhxT1NNb1M1V21ja0FS?=
 =?utf-8?B?ay93RzRoYmkraDcyZ25yU2U1RHdDWHd2eEtKb09qTWwrZ0ljTU9COUpQWHZl?=
 =?utf-8?B?M2p3R0ovL1pPY1BESUxuN0RrYTY4YVpYQ2ZnYXZ0MnRnL1dQcmtwbm92dWFp?=
 =?utf-8?B?dWE5cnZiQ0U5a0tiTWYwdG9zUWFwVmQxdjlZSDcvQzhQQWFlVkQwL2FncXlq?=
 =?utf-8?B?NklSbmhQTU4xa3YwTlRCSVF6d09UVUJxK3lweEtLV0ZiR3dKTGtjNW9CbnBE?=
 =?utf-8?B?c1VpOXpyS1BkWlQ0Rkl0Y0gwSSt3U0lXMSszWWx3QStaUzNmYkJ6bGFtYS9K?=
 =?utf-8?B?aFIzdGtkOUJOWHV4akFJU0VSdWNMNnNkVEllWDVGWTNSMGlqV1Y1U1FYVEk2?=
 =?utf-8?B?Q1FBSDN3YmlxVGdRaGZ0YUtMZ01mZFkxenVpR1NmZ3FNb1hYcTRXU0JtYyt0?=
 =?utf-8?B?emlsWCt2VkZkOVFJK3E4My9aOW5SQjBBVnpOeThvMmtmQzJ2WXNxTDRYY3Az?=
 =?utf-8?B?OVUzTUp2YnFIQnFlck9oaUF6QXhMRVJIUDdYK2hRUFJPU0tUV0o2VkdwRjFO?=
 =?utf-8?B?M091Q0ljcE5NY1krMDV3KzhhRERFS3JUZmlrN0RJMzdNYlRqOGdMa0ZXUjl4?=
 =?utf-8?B?UFlrVWtCUWw0eWRzbUxrVGtNNElQbUcrWHVrTXFZQjVyeDRyR2Jub0tLNnNV?=
 =?utf-8?B?VWdrejhOR25lM1R5L0lVKzFwNWNuZVNycE44WTJIajZEVTBtVEptT1Y5eHlu?=
 =?utf-8?B?b0FHU3pJVlgrYXZySkV2cEJHUHdaY2ROS2JiS3FGcUFHcDJEU0NIcDN0RkRz?=
 =?utf-8?B?ZFFqbllORTB6emsrV2tWMS8zTGVWbW5qSG9qTWMvdy94UUxSWSt2dlVrOHk2?=
 =?utf-8?B?STFob0JxWFpFU1hqZlAxYkxUdVBuQ2htR29jQy9KWXIzaUJHOVJscnFUVEpt?=
 =?utf-8?B?NTRIbHgzdUszNG8wMFUwYW16TVZoVG1URkhTcWNDdzhRWjZ2ZkYxNE15YTJV?=
 =?utf-8?B?ZFVacVVYdlhqd3R1S01sb0dDUkxLV2UzbU9zeldIdGZVVGtQVjYxUll2U3Vk?=
 =?utf-8?B?Uzc2MWRRdlBaZmNqZzVQeFVvT3JQbERocUd3elBELyswL2lkR0xxNmV6MHVF?=
 =?utf-8?B?V1pWZTltNFMvY2RXb3dFVGNTNjRzMUJWQVlVNkExQ2QwRVdzWGZmNnJ2QnNk?=
 =?utf-8?B?aER4bzgreWFZYjJrTjdXOWU3YUl4cHVQeGdVeXJZbmdOTTVDTStTVy9JUjFh?=
 =?utf-8?B?b2tqVkt6ZytlQ3hsbU5GS2t0OGUxdXViRFhZWGUzenhwV0ptYVFoQ3VUdEli?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F63F0BB6F909C2409087D84109367CD4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bP+/stTu8SVMzyCL/dzsC4bmUk7DkD1Zw4WjZtffBemrT7bM4HE35Mt+WNykym9NLLcW5B4n4F7Yxjltm9XFE80jBaBwhUmeOs06siLNbE3f1TK7ZnggymACTRjcVrlPlwqYD72FqlA3QkdrDz2F69CZyow+IvgOLDkqcOSsC2j9lXK8pd2T3vJ0Gm66eNSXblhTaq9ObX6kEuZtFfo99QxDaiyVc5sFQHFoUCAhQKo63RNVK7J8fgagl3J8YyELp3bV1Xcjrbgqgv5x2kjna6GFU/7X+ll6PXOmZfkTWEARzsi3zxxaDfrPBKYekypKwjTEUoqmImsfU/OP76Lelc2+vm5vPS3FDNj970F6e0diI5UPtptoC4bezxiYP+ytb9/5Zx1i+dxWLhJTZZzcs9JpPxQXARhxoWh6xcSNOQPstmRa0rDDo7B5wmB29UiAjPgSiwKwoLJ8EX17fl7XtGHFQIT1YJ+PS6yekjicmg4k56k526+9L4OIpG0ab+qrF61HXNtgJsWBmVgKz1BBXO4efWftu070eSxX+8/6CB+X/akVn8K105T8aknDWnVmUwyCwA0tnx2+TkgYyeqlixxatjxsCKxU6dOvF5ozgslfvbCpMQ11yTkDvLcw+XHZ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ecb36e-216d-4f11-7759-08dd0d2b7111
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 08:30:38.7868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKuKhRNbAfbvccwRpEwXOVFsA4TiuFn5IiOwG1+rXWbg+fLuUSZ6q/jxBJkeRKIfjKWCL0B+rM6f0Bk485Apzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7233

DQoNCk9uIDI1LzExLzIwMjQgMTY6MjEsIE1hc2FoaXJvIFlhbWFkYSB3cm90ZToNCj4gT24gTW9u
LCBOb3YgMjUsIDIwMjQgYXQgNDoyM+KAr1BNIExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1
LmNvbT4gd3JvdGU6DQo+Pg0KPj4gTEtQIHJlcG9ydGVkIHdhcm5pbmdzIFsxXSByZWdhcmRpbmcg
ZmlsZXMgYmVpbmcgaWdub3JlZDoNCj4+ICAgICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9hcm02
NC90YWdzLy5naXRpZ25vcmU6IHdhcm5pbmc6IGlnbm9yZWQgYnkgb25lIG9mIHRoZSAuZ2l0aWdu
b3JlIGZpbGVzDQo+PiAgICAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYXJtNjQvdGFncy9NYWtl
ZmlsZTogd2FybmluZzogaWdub3JlZCBieSBvbmUgb2YgdGhlIC5naXRpZ25vcmUgZmlsZXMNCj4+
ICAgICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9hcm02NC90YWdzL3RhZ3NfdGVzdC5jOiB3YXJu
aW5nOiBpZ25vcmVkIGJ5IG9uZSBvZiB0aGUgLmdpdGlnbm9yZSBmaWxlcw0KPj4NCj4+IFRoZXNl
IHdhcm5pbmdzIHdlcmUgZ2VuZXJhdGVkIGJ5IC4vc2NyaXB0cy9taXNjLWNoZWNrLiBBbHRob3Vn
aCB0aGVzZSBmaWxlcw0KPj4gYXJlIHRyYWNrZWQgYnkgR2l0IGFuZCB0aGUgd2FybmluZ3MgYXJl
IGZhbHNlIHBvc2l0aXZlcywgYWRqdXN0aW5nIHRoZQ0KPj4gLmdpdGlnbm9yZSBlbnRyaWVzIHdp
bGwgcHJldmVudCB0aGVzZSB3YXJuaW5ncyBhbmQgZW5zdXJlIGEgc21vb3RoZXIgc2NyaXB0DQo+
PiBleGVjdXRpb24uDQo+IA0KPiBZb3UgZG8gbm90IG5lZWQgdG8gbWVudGlvbiBhIHNwZWNpYWwg
dG9vbCBiZWNhdXNlIHlvdSBjYW4gc2VlIHRoZW0NCj4gd2hlbiBidWlsZGluZyB0aGUga2VybmVs
IHdpdGggVz0xLg0KPiANCj4gWW91IGNhbiBzYXkgIkJ1aWxkaW5nIHRoZSBrZXJuZWwgd2l0aCBX
PTEgc2hvd3MgLi4uIg0KPiANCj4gDQo+IA0KPj4NCj4+IFsxXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1rc2VsZnRlc3QvMjAyNDExMjUxMzA4LlZqbTVNelZDLWxrcEBpbnRlbC5jb20v
DQo+Pg0KPj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0K
Pj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4g
LS0tDQo+PiAgIC5naXRpZ25vcmUgfCAzICsrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhLy5naXRpZ25vcmUgYi8uZ2l0aWdub3JlDQo+
PiBpbmRleCA1Njk3MmFkYjUwMzEuLmU2M2RiYmE4MjNjZCAxMDA2NDQNCj4+IC0tLSBhLy5naXRp
Z25vcmUNCj4+ICsrKyBiLy5naXRpZ25vcmUNCj4+IEBAIC0xMzAsNiArMTMwLDkgQEAgc2VyaWVz
DQo+PiAgIHRhZ3MNCj4+ICAgVEFHUw0KPiANCj4gVW5mb3J0dW5hdGVseSwgR0lUIGRvZXMgbm90
IHN1cHBvcnQgIm9ubHkgbWF0Y2ggdG8gcmVndWxhciBmaWxlcyIsDQo+IGJ1dCB5b3UgY2FuIG1h
a2UgdGhlIGludGVudGlvbiBjbGVhcmVyOg0KPiANCj4gDQo+ICMgY3RhZ3MgZmlsZXMNCj4gdGFn
cw0KPiAhdGFncy8NCj4gVEFHUw0KPiANCj4gDQo+IA0KPiBZb3UgY2FuIGFkZCAiIXRhZ3MvIiBy
aWdodCBiZWxvdyAidGFncyIuPiBUaGVuLCB5b3VyIGNvbW1lbnQgaXMgdW5uZWNlc3NhcnkuDQoN
ClRoYW5rcyBmb3IgeW91ciBxdWlja2x5IHJldmlldywgaSB3aWxsIHVwZGF0ZSBpdCBzb29uDQoN
ClRoYW5rcw0KWmhpamlhbg0KDQo+IA0KPiA=

