Return-Path: <linux-kernel+bounces-291662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD54956553
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401531F23057
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF0B15B130;
	Mon, 19 Aug 2024 08:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yh08iOAZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25F015AADA;
	Mon, 19 Aug 2024 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055223; cv=fail; b=J1VUwlyp9Wsqq9EYPOuVMepp1S1rS+IRJsE1AslwFCDtX/28rjlJEJG1gXc5oZ+i16PA+Z10G8eI11MiwN3X7Cm8R5GQDgEfqAoBxnEW38zF0prgxZfPk7hBtfiLKginbOlWWkB9t9vZhD+kvxGWjUtpnYvXdytkCpbs2iDhekU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055223; c=relaxed/simple;
	bh=cs2qG/50w2biZwCf2PsKgqTvykf+GPeGNl09hItheBc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hlYQzoooZ5jXQcvftRgdXJZackmRdkl8JO0ykVUk28dsnSUMFpWQyH5UR/ws8Oifg33L+fOyJQzoWSDAoVnE3aF/IykflFbJl9SD5ZPw/Mayot1+dwKhdkmsm5pop8Je4LfCUtpzi3BCB3msrLDz0Z2ePiryD1XbzkYaAZmMRB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yh08iOAZ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724055222; x=1755591222;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cs2qG/50w2biZwCf2PsKgqTvykf+GPeGNl09hItheBc=;
  b=Yh08iOAZIKKlOf9DpCvAD51diP5kfYnSE6PYO+wWZ8AB4QKEfD98Y9a5
   nowVZfzQr1UeLpvZSkfCKOTqGQy5R1F+fEW+HiPwjXviYfnug2jtcaUyG
   klSXCBvMRr04CbbzHWJNljXiLA1EMQOs09ueSHXDt+fDvQynNO+dmAITM
   pXw91TCrQIjZoT1vIksZnx7Va7flS2OoUnjSjxOZ3816V1GvNBSf4RQI1
   fP9kkMUOdNt0EQs0WxbUqhArENy7MOUiGHqxUP0bLoa7rJD506Adpk1ME
   XQ3mxIw7VYvEi4uG+VPygKAVcccUZbbYSmd9RxGRdzh3qfD6hA7iPmqbr
   w==;
X-CSE-ConnectionGUID: eAFB0IKzRkWxMiy8hku5NA==
X-CSE-MsgGUID: ok/f2C71SIGAnmgwsJipHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="39801973"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="39801973"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:13:41 -0700
X-CSE-ConnectionGUID: KBJuNs2+T1aXuekX9vEI6A==
X-CSE-MsgGUID: qTWVQWnWQgGIAnje5+NM0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60865187"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 01:13:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 01:13:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 01:13:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 01:13:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 01:13:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNrLfNLKRd7FYPFhjb2WRRynppoJ2O4yMiKhSKPOZ1xlNyn0hByNa/1sA0t/U/6r0epggxxhG21Vbl+vJrsN7gU33YsKSCbz7r5tXbI+30xm9E5QpoGYOBLreg9qqP5v8oWKDYWFGaRfotoZ68Q+w2AIbpTcnYjbBF69m7SaCmx07VYUTJUcBl31eXz/u0hoaZhsgodYIAb0Or43i4jlgs1Yo9sqcO9ZPkvkC2ZX6O8+DIEgbIz6dg7bi9ebUo+9nuok9zDCYwJ1HDXniLoutdX9dWVW6k9w1zrUehwzS2Q7BY3cNKRWIDnEjRJpMZSJXuYB4hVDv7VobFn5nMFGRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAwER+tZSbULVVhINUG9JX3DfHR8+mEjowpTHxhw5hE=;
 b=glJb7hWUCYmupQc6mEHFXx7mJ/J7d0m0JvucOI3kllQG8+J+K1wEgsdkvWwa66yCpsGpVi30y2DHclpOb8NHhOGXBdk78YgdSdCTeK3+P0zyCe6ClDN4G3r0GgYxKXbjKvTgrh/3tm74+hXjbtRUObFceadg2IyDJlY7kzUfCz8czUCs5et+PskkUfq3BQXYuLk1/XAmYIbgR4oYogZGwIwbzEv6jpoOvBs5609Y4uQsAJbIDRoQpo3H8xPUIlbR1zNZC/6zUZeO1T6ixW1pqa44qmznCNmeCGYvgCFjgC09MjJuBYUxLKLJEJHFpn+eRB1gE+8ERHETXZCpl3qRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10)
 by DS7PR11MB6103.namprd11.prod.outlook.com (2603:10b6:8:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 08:13:37 +0000
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::4053:18a0:f95:3b9c]) by SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::4053:18a0:f95:3b9c%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 08:13:37 +0000
From: "Liao, Bard" <bard.liao@intel.com>
To: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
CC: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
Subject: RE: [PATCH] soundwire: intel_auxdevice: add kernel parameter for mclk
 divider
Thread-Topic: [PATCH] soundwire: intel_auxdevice: add kernel parameter for
 mclk divider
Thread-Index: AQHa59wdejhVxPfvbECwQzKoR60bA7Isr1YAgAGdkiA=
Date: Mon, 19 Aug 2024 08:13:37 +0000
Message-ID: <SJ2PR11MB84245A5FAA3672471928C26CFF8C2@SJ2PR11MB8424.namprd11.prod.outlook.com>
References: <20240806083840.24094-1-yung-chuan.liao@linux.intel.com>
 <ZsGhdFm8nYkm5Y5w@vaman>
In-Reply-To: <ZsGhdFm8nYkm5Y5w@vaman>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8424:EE_|DS7PR11MB6103:EE_
x-ms-office365-filtering-correlation-id: 5838fd76-0a7c-4ac8-5de0-08dcc026d3a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RirIaDZSNGfHHbIz9O4sFHxk9q6+01tcaqR5L+arv1oZ481wYQmY1uRPpjIw?=
 =?us-ascii?Q?bnh9pEjTqwLfYIeyyC9pDm204kPhISyjioQS4156WiQjt7Xdz6ZCPRxs/InO?=
 =?us-ascii?Q?+0f7UhEVaS8gjD20RPYuDpaLTXtU0m90oq1pThEtkThXF+FN/yiCy8GJVYGu?=
 =?us-ascii?Q?lmwnqW1dQeq0jmZ1B3zJ6itoagbrnr8kT8bIW80ImQSJxJR3cJk4mxmZeNPP?=
 =?us-ascii?Q?EUvfXap3X/8YdRW1EpMG6Hw9bi3GlOyZvKxQgPiUwkdCoktdNYRE9JvyztpN?=
 =?us-ascii?Q?FSEAKbASqe7wifu/JClkfZTNQsfSRKaxxjuQsMi7vqcH/chLhQWMtxYRdznv?=
 =?us-ascii?Q?Rk5SqrMFoIwnXa6E4FTpzHf/wQkvMUA5BM3Xo18XKvwZ9JnvTCzlG6tKEa2f?=
 =?us-ascii?Q?8YYIwA2RPSAyhz8d474I+5MmJtNTVSoXzrWJ/nIB7s88KTvDbbfNaJmV8LUG?=
 =?us-ascii?Q?jr9n52PaIm3OX9+hcL/rsm5TEynOQGL1xsU7U0OCiEfeNDiuAVCzHj8w4i+i?=
 =?us-ascii?Q?GpCPv8t9hrHKdcMSqrtdV5V8CmOZkaSP7JLcypiomYYNFsabUvzd1MMPY0V7?=
 =?us-ascii?Q?a7wDq6jriMZuJssurRtt/spUzw8JPUQDs/ekixNF03pN6/fhWD7wKLTXlCLZ?=
 =?us-ascii?Q?5tDVlOGt/sS7Fuo3lRtLSrOo88O07ccQxeorsU/NKUP9wuvpt3kj+64BsDmQ?=
 =?us-ascii?Q?dsyF+8uZn1aQ8iuIZ6Q3V5G6fZeRb485vZCD9AdbOXq3RyfRo61aOmE1mtLh?=
 =?us-ascii?Q?wwTA1IezXT4mxZMp6lAlg9hgh4kMsF06jYrTz6EulUjgr2IP06rjCQpTgU7Z?=
 =?us-ascii?Q?qh7+Rxy8f/lT0d6hlIZpu9Y+KjA1UuFYjkk40SSUY692MhnkSAB37NryiHrV?=
 =?us-ascii?Q?CjH04yNbxDBs89Qn5IDelwlcV5W11ikStqbs15kZ+GD70Dc+TJO/g6R0B2Dv?=
 =?us-ascii?Q?kyRipkxgVQQ7rRl7wPDJQX3WQYpyd4W76THGpwEq0nFpXWm0chno55P8hTT5?=
 =?us-ascii?Q?XigRKqc1mFJDUX7q4iJ+E8FcWSGD9UkTu5SerO6tLibxclD467p7OaEHGTv8?=
 =?us-ascii?Q?LokIMEf6FA6ZXDrdyMqIbR8hTqAZguXCIW2eSAvIoD5699xYfeFotAbChWOp?=
 =?us-ascii?Q?jg+CsdNLjIGxRfksNMeM8hz1GxbWvdl8q3x13WMkrQ41Rj1ubl/CSpWjh2zM?=
 =?us-ascii?Q?7FXyhZfB6XWq8RE0lWKub2GGkWRT+wRYIs4GeLPph1O++F7mZmhQK7zbbvDd?=
 =?us-ascii?Q?LY6cXbhvYcuj/s0KJF36XRgSwitmdRS2f6T8QbqdHx+S2qDUqrm4IQa0QasC?=
 =?us-ascii?Q?a12W5onzOAq2cqsABSDThYKAHo+2jYOn2BgEBksjliCKvN7+XJs1ZZqClYUA?=
 =?us-ascii?Q?QzUcmXI0QGdSpzO+BRM9IH4qlX0jOmqQI/z2iyw7SjJdcFYvIA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vVoFlugkMdjxXFv1vjb09UCPlaWpwa4d+s95y7qsVQm2zdyHqzp+c7aK15bs?=
 =?us-ascii?Q?YA01xbgM2Le7siJSddACrdzB9AHhwly4j+vF0sXzb/YNExUqLsVUFr+vTkMD?=
 =?us-ascii?Q?zpYg7KYiOf5U2VXIAYFhEbcE4kam3+Ch8qfTY32hfpOg7MezxlRowpBFALka?=
 =?us-ascii?Q?9QzCLK+iihjFNjXP0rYon4OlZHe6ZZyR8tP7Mu/JeD5EwFMN8WEKygkonKKO?=
 =?us-ascii?Q?tixoxs0A0Cwg7cZVEPtyEklaZZmWGzaQjikS5QeYymk9oJd3PLnPujv0eO4F?=
 =?us-ascii?Q?lKWAFxfnRZSSjTqn4mHv8tRNpJ2CWGAt0RDuEaufx+IMnoodqmooWAorqF/2?=
 =?us-ascii?Q?dvCM8hSe+5HQew5JDYJc4ld5+vY98YabLl11vjNr18kNj6G/xAr4oZme2Ot4?=
 =?us-ascii?Q?AWSPoDA46HZW1MOuhQBLnUNiNBQ/6csXQjQCoQuu7YNg9reA5IKU8oE90CpT?=
 =?us-ascii?Q?S+WRDhuQHQE+nvbPA5UOJ9wRLURjAD8bFkZ6karAkfgOdfanjyBg3olK9Agb?=
 =?us-ascii?Q?SQqhTHfheJMEDoHBOs5ywoGMd/wnhr57figqP9I7YLsO5PuF0WpYxYjszmvj?=
 =?us-ascii?Q?NkndcOo/+jpU81r6gA7syIdCF97dbmjgspyRTyzIQ7EOkzwBrTFc9+jUoDbn?=
 =?us-ascii?Q?U8LBzYw2hrHLta0fBk46nKB/g8auFebgvrbP/6CO57dk1OY3zbivo1ZD2BU+?=
 =?us-ascii?Q?sEuLFCkQdQBsvsxSqWDbCgf5UFALq61GFlcF2+Q3khGdko3pLUh6P0ZU1f0J?=
 =?us-ascii?Q?WqFVpMxg1cydGXuovdd+iLEvJzuy2GxF028sBY5SuiIWZmI2HNWcsiyFpqis?=
 =?us-ascii?Q?9yQnw7l9wnfV1WNJskWTSVOHaUsGhVGIctL4B8B2bEHNq1UP9GerPuBEDAJ3?=
 =?us-ascii?Q?bsvhkgRLnfR+GqYJYOXwKiNJNUhucaXzmIyaLIqtaQeNzYqxSvmM8cr4uxCz?=
 =?us-ascii?Q?v8v6gyUc5vbhiC9mzZd3OHom4wXibsedhtuJiy7krWYMLRCFGEBki3yLoaNn?=
 =?us-ascii?Q?5swY5C08/UhoiUZLmj7qu5GeyrslGdsCZ9ZN9gSWFAi1/fMdipK8QBun2sL7?=
 =?us-ascii?Q?wE1OH0envXyM7926fxMXapyhELR3Y7+t1vX4wdxuGmNEyQLGsXUWSUBy8i/x?=
 =?us-ascii?Q?43PAkVax1ByqsZRXud9Ez6fLXs7VDzZmGwIBfyM6iqzEJGGWKdIDkTVMaBAr?=
 =?us-ascii?Q?R4sUPkyhRpJON2NFA7+tzcmuFtedqFcqxvAi9BxfQVk4c/+6PjvhBrJXwsP7?=
 =?us-ascii?Q?u1AW2fzrGv/SnOV7fIaG1drIN+o8y34n4AeWGdu/zLWz9JY/a8McbShyCVP+?=
 =?us-ascii?Q?+8cOCfhXhJTeUcKvysdSlU/Hn5BYLcnRrlGqTSeAWleKczmlIFHObmSDbbzn?=
 =?us-ascii?Q?dtczkgsYOWud1/59p10xM5rIA4r4u+msIiQLkolLo3d1suxBshtDAsFmN8bm?=
 =?us-ascii?Q?6SRbanoVHkN1hChvVRCzNw8ARVU2e99XFOYyUy4E7qDHSPZrRqbFPddBNKRW?=
 =?us-ascii?Q?xxaoDPxyi6on140CljC1mHStWCS/nX/4Tdlznsxhusb7i82/CvMoj50XOBDf?=
 =?us-ascii?Q?gC/cDRO5gwTnL+Wj8LE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5838fd76-0a7c-4ac8-5de0-08dcc026d3a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 08:13:37.1422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fjmslH1Y/h2YEbOsOWXCXM5AdSjY1cdFrysHu2VAYscsDEzf79h7qJ1JRI9GrXJWcBjPUUtAykgNVVXqhB1glw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6103
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Sunday, August 18, 2024 3:24 PM
> To: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: linux-sound@vger.kernel.org; linux-kernel@vger.kernel.org; pierre-
> louis.bossart@linux.intel.com; Liao, Bard <bard.liao@intel.com>
> Subject: Re: [PATCH] soundwire: intel_auxdevice: add kernel parameter for
> mclk divider
>=20
> On 06-08-24, 16:38, Bard Liao wrote:
> > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >
> > Add a kernel parameter to work-around discrepancies between hardware
> > and platform firmware, it's not unusual to see e.g. 38.4MHz listed in
> > _DSD properties as the SoundWire clock source, but the hardware may be
> > based on a 19.2 MHz mclk source.
>=20
> I think this should be documented in kernel-parameters.txt?

The parameter is only needed when a BIOS provides a MCLK rate which
does not match the actual rate. It is not a normal case and it happens rare=
ly.
Is it really necessary to be documented in kernel-parameters.txt?

>=20
> >
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.c=
om>
> > Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > ---
> >  drivers/soundwire/intel_auxdevice.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/soundwire/intel_auxdevice.c
> b/drivers/soundwire/intel_auxdevice.c
> > index dff49c5ce5b3..e372195b07b3 100644
> > --- a/drivers/soundwire/intel_auxdevice.c
> > +++ b/drivers/soundwire/intel_auxdevice.c
> > @@ -41,6 +41,10 @@ static int md_flags;
> >  module_param_named(sdw_md_flags, md_flags, int, 0444);
> >  MODULE_PARM_DESC(sdw_md_flags, "SoundWire Intel Master device flags
> (0x0 all off)");
> >
> > +static int mclk_divider;
> > +module_param_named(sdw_mclk_divider, mclk_divider, int, 0444);
> > +MODULE_PARM_DESC(sdw_mclk_divider, "SoundWire Intel mclk divider");
> > +
> >  struct wake_capable_part {
> >  	const u16 mfg_id;
> >  	const u16 part_id;
> > @@ -142,8 +146,12 @@ static int sdw_master_read_intel_prop(struct
> sdw_bus *bus)
> >  				 "intel-sdw-ip-clock",
> >  				 &prop->mclk_freq);
> >
> > -	/* the values reported by BIOS are the 2x clock, not the bus clock */
> > -	prop->mclk_freq /=3D 2;
> > +	if (mclk_divider)
> > +		/* use kernel parameter for BIOS or board work-arounds */
> > +		prop->mclk_freq /=3D mclk_divider;
> > +	else
> > +		/* the values reported by BIOS are the 2x clock, not the bus
> clock */
> > +		prop->mclk_freq /=3D 2;
> >
> >  	fwnode_property_read_u32(link,
> >  				 "intel-quirk-mask",
> > --
> > 2.43.0
>=20
> --
> ~Vinod

