Return-Path: <linux-kernel+bounces-228113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B33915B10
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE219283D86
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E37C171A7;
	Tue, 25 Jun 2024 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3O02es4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A335E14F90
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719275990; cv=fail; b=rTkEnGvWkgiVUGstTP5ETZLnGbRsXX3KZ+GnlAzrULMD+RldlNGZsT/i/sNSBwbAxs66aSyyVmeALHIBDQl34bpvDrvbiO2To2TnMQEVFB8KuoTRdi99rGYeN/xSe8sP2EJzgnoOlfqHb9+ILuGkvYw1qZnryno2Xz1sT/kx+SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719275990; c=relaxed/simple;
	bh=ZD9pyX5X1lJ0DWtcXSXJv1ufz+xmtP8YM9qCLwsnZak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gqJ0I4P9OheCXw13gvF0RPnmJrScSKdiC6Hiosm1bifgUulKb72sucxEsKMso/SFRoTe6KWaYfDw2eOlI3wBQC18dZoSMV9isMHVAwDeYYh6zL4Tfz1LexHgT7hUv9oMjKz9AhZe3qugHFvkFITaoOXzT0sv5jQ1AX0RVZ096oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3O02es4; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719275989; x=1750811989;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZD9pyX5X1lJ0DWtcXSXJv1ufz+xmtP8YM9qCLwsnZak=;
  b=d3O02es41D51ADUPZam6AFXUCP6aC15EXh1XVznRI/A0umvUm1xkTKUk
   75Q1VSl1+FMuG97n7fPiCLfRnnJ9FK0+LwAkaVqfvjea0QKStUV8w08VW
   Qaq786Hk5BffhfaXKtDbv4PayUgqRRhZddls4FHkgkgWYv8p3QWo7lYd7
   FOchBgccYjXWbEAAlDLo0kj7NFY/5ToUPKFynfEy2qWnsMeAQoXCj7lss
   gjiBbde5gsT/7TT8oa7Qex5HMvO3U6airtt/PlyOn1tqTKPDacc/sEvYy
   Zhdcc4iOfnXX+UmOx9+9qOYwDPGo3s19QS1XQM+dmheLj1yNvsOCWAiR6
   g==;
X-CSE-ConnectionGUID: 8IOdzeLyRva4lqJPhAoYQg==
X-CSE-MsgGUID: VzYPOFS4TW+fJQgzsTp8gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="26959745"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="26959745"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 17:39:48 -0700
X-CSE-ConnectionGUID: 0cu8WNrVQbOLz4sRX3mBlA==
X-CSE-MsgGUID: 1fE0qMEIQV+KA1W+Tv2mlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="48421666"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 17:39:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 17:39:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 17:39:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 17:39:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrKBUjJXEyYuJuHC/ecqfC/5tgUi728AunbaihT7MzDsyaJBkMxuino1mcVO+uBqLWYq+s8bXn+TGdsfakqXh5sBRjs1OehrmCOAc09K497xptCsIGFyLFRAcIp/060esMJybziX/akzg7BmzyGDWnIseq2OApCY3pixr4LP8NBr8w7SjeVEDLuO85Fh+zcDhy+v/3q4lz/7dVW/KcKJu75tGOhth/4gzNt1pLbbOugHIY86SMlQeEQFA+Juh0EEPa9zowVVAXoqnUpMPKZyGhhpapLZpESslKUR/fXOnTdAsekr5BWMYaxGOvAm3GqrJI4rNyhmyASxUqYd2ilUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZD9pyX5X1lJ0DWtcXSXJv1ufz+xmtP8YM9qCLwsnZak=;
 b=FS1ChpFp4Sq1NzOWDrw90e8KvkgNMg8VLaaE+T1dP5pvhVh9SwX5n3P5T4bx0stzOYJ7f5w9Pr6Bc0VbFqhXdVm/jlY51HK/1bMzDwxhyjXuEm7TliaAuq7gaOavwxByhNJsnEziRnQIrvZbJubtG1vt5fwLV4IdntPz11ASL6vQ0uIqWSmPLziwR3+I8vAgezmGHZR57elonC+rEVHyrGrr84Rc4MdbpB8xww0gzP0fOTBAzfXrHErdofzYgu+ueY/nLuaunQxXOygNeSjnLLwjP/elYidvqPnaE3kHbhXvgzBhsCNFt1Cx4R4ikINzG2G6usBbEJkFOlStwx0wYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7)
 by SJ0PR11MB5055.namprd11.prod.outlook.com (2603:10b6:a03:2d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Tue, 25 Jun
 2024 00:39:40 +0000
Received: from MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::20f8:8626:d842:9ba3]) by MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::20f8:8626:d842:9ba3%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 00:39:39 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>, "Winkler,
 Tomas" <tomas.winkler@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Chen, Jason Z" <jason.z.chen@intel.com>
Subject: RE: [PATCH v3 5/5] mei: vsc: Fix spelling error
Thread-Topic: [PATCH v3 5/5] mei: vsc: Fix spelling error
Thread-Index: AQHaxjql7o2xf4P0VU+LUOPPf/uiWbHW+fIAgACpziA=
Date: Tue, 25 Jun 2024 00:39:39 +0000
Message-ID: <MW5PR11MB57872CB3A9D85D7D899896458DD52@MW5PR11MB5787.namprd11.prod.outlook.com>
References: <20240624132849.4174494-1-wentong.wu@intel.com>
 <20240624132849.4174494-6-wentong.wu@intel.com>
 <2024062415-system-stuck-6836@gregkh>
In-Reply-To: <2024062415-system-stuck-6836@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5787:EE_|SJ0PR11MB5055:EE_
x-ms-office365-filtering-correlation-id: 95f4192a-0c80-41db-4d2c-08dc94af4c45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?0xpG8TWz3ggB8o1xZl9mLFRXOYgfpiCF7iqO3AOKBfeB7oJea/Hg4duX8Hk0?=
 =?us-ascii?Q?RiZTiakw9PQ75Yi1biSdmGcjkKLVcPCt5WKkkAm0PVXuK+Jk5YKBd2OYG/tj?=
 =?us-ascii?Q?J7gwlDHo8prQKMGPRNz/sdDXqDALdbcTwV4nOr0rPwOreIJJhUeLFTp4j95B?=
 =?us-ascii?Q?iUFBR51R90PQTM66KZtz3ccCoRUxIeNQMXyGfo1ZVLzfAocMzVq+DXzJp9Xo?=
 =?us-ascii?Q?4qoKNu/76LGJfKobHIdRM6BEF1RqxjiiaxZsGG2VEMyj4y6Ck5mtpi9tdOQP?=
 =?us-ascii?Q?gyISV9CGSsotNpbLFb1+v5EvJtloHn29ze9C5sRDxA/tvInmqREL2bIS8Fn5?=
 =?us-ascii?Q?JXlfGA5YpVLjghA9JeYQrrzWuNV81gchBMm++h20WmwOF+KHeix9oA2KQB7j?=
 =?us-ascii?Q?UimGvcaTafyNY++CCqJzazudN6ba3s0op37lQvrNEZkveJjRvy6ItG/fNKpc?=
 =?us-ascii?Q?dpuqlnFoqozBPA2Gs5i8p32G7MANsLCxTjxo7KJX2AX8WJmuO3vxruYiqmx3?=
 =?us-ascii?Q?Rmn+CyLrsEu/FuM+AfjGEJDzKTae/hfJeHsLeDj2msl4ueDtwiryukiHT/uZ?=
 =?us-ascii?Q?ae+hTkFKGUUXnA32GoqtAjMdqsQTm+XRcuHcP86NrVyBfwx1/0uZ9iwfxVzz?=
 =?us-ascii?Q?hwl5wgyh1RKEN1T6aLtOlyrZCCwwLYH9asJJJDAyVnWUosdQNo+Pe2TOEsLL?=
 =?us-ascii?Q?TI0OtVh8IIhHLG0mh002X9PKu89w2SslKPxbQaEapmTcbG/6a5qOGWAKVJv/?=
 =?us-ascii?Q?tXZ6Ohphl2nX6iXgc5zq62xhLootB8qSkc8gEzY6JmglhggyHg4uKGptJd9h?=
 =?us-ascii?Q?Hy9Y/CBMHvzlOw+kFx+o2+unLdML02OOi3fRGngEpYEwV2GPU1/9GRZhQEqP?=
 =?us-ascii?Q?773kUa8yH5OfGlGOTix6kbX+GxYn9/D9in259lel0w2qyW1ddm0S9qNdoIHA?=
 =?us-ascii?Q?/EYuVOpgS25V9q4D5FqeMsAC5zvtYyM0y5DkFOgF0DwHwpR1YIqsPZLhGjZG?=
 =?us-ascii?Q?P8siPb9Jc4MtQWl8sjtiR0tFp+44HU0sV4kg1ZpbxpNf5C4nuO9FBFvIIGT+?=
 =?us-ascii?Q?weWYxiz5434l8i7qC1Iid9Hz5IqVIqhGjGHpPueaJ2y+h/LlA67QdAesjQTy?=
 =?us-ascii?Q?AFn9legPUgxlR3aa0DA+mXiFRhAbJe7WH8phaQLQxGV5kNhjHyCUceTiG5Fg?=
 =?us-ascii?Q?yohPuBWr/PBcr1SHHl17yWVDeIiJIDdjxk2JfF9B/6BSZxKJa5Pf4jNRdrcK?=
 =?us-ascii?Q?Cl4ftvnWfYOMkoxlVF+fXvK3LXHA5dprVGraCB8kv+zJ/aTlUmbIwtVY7cZ5?=
 =?us-ascii?Q?h7D7YeGPePp+6ZRWz6RjC3FxUxVz/twzMYpku3q6W1yvL1Tonq0bTZfeRtGF?=
 =?us-ascii?Q?eFeAM3U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JcwisRSnsNv14R/ubFt1g9T8/PlohGrYR8In4bWnNDHk5Z6914E2oO3UXAdN?=
 =?us-ascii?Q?TeFcK+cxH/0nizWvHaEXa0HXAH/IST8sbK8H1khFvHEa1dR3Y+Jq5YsGf/fY?=
 =?us-ascii?Q?w69JQOwCfSqmc4NA1LcLt3MwXQN5pCdq6Dl9QUiW4vJmbVx4ovHa5JE/oiNB?=
 =?us-ascii?Q?ohnzU6BMdRj7pnSgOU5k+RirlzaPaIiEIENsgVU5cV7s3ZDWXSa8zgtA+0sA?=
 =?us-ascii?Q?iUlCjqhDDzTFPMrTIealsKuUnP/XdvhjZRzwJ4dWBWIESz3ZHS/FedgjP/E0?=
 =?us-ascii?Q?RFiRA7ksCsRzRAwHBYoa+zERuhJnl8vxyL8uRqUdtg95vBCZO0tPyYRBVqA0?=
 =?us-ascii?Q?G4z1l28VZBnR6xzQTvSRxD2I/W2ARN6w4VmtS21MiDoMAsn+uK8oAzGl/U9Q?=
 =?us-ascii?Q?U3l6CFEnkVp5H7mRlLErQvwUdWX0qkZjn8s/x3ZZjN8df/0Q1faSBP6dNJ3E?=
 =?us-ascii?Q?QnF2262YUSaBMgNy2PqhgSxU2ySFYmrwtsZDwjmBqqL6Mi++/6f/J5JM4kkI?=
 =?us-ascii?Q?qqMd1vGkVmYXNmq/xB1GWJ9DmTiZepef9IU8WaSbeuydO3y/UZN0DpUCJ5At?=
 =?us-ascii?Q?6iPwOg0PnGSn/Ih4Ebv4VOncEuNX29RLzmycs5hZV+ibE/+sjwk9zj/AVEHU?=
 =?us-ascii?Q?dw5MXaxA2jczZBWEg43WO9UC5ejSfsQZLM2WXtRix2g+guzuj0ZTsLTaM9FK?=
 =?us-ascii?Q?E8d6FjL+p3i6gE4Zf1ptRUjzetiBixNsp5KUTVQRXUR3q1TM/LnCftnYjPln?=
 =?us-ascii?Q?KW5WSEwqgQKpL2yEo53WULaddNDCqEXMAZrbpnbRB1G31i5hqxErym/mX91g?=
 =?us-ascii?Q?muTJU5OtVPPKCmIqc4Ib6Fh56XufPaMtgte6IPZIqWmLuedWHVwzg4BD1RV2?=
 =?us-ascii?Q?Us/1ERlQzD57GHYKKlWWnaMJZtYRAbKE+RaacyXPk6ARIKt2vC5rETBdsA/r?=
 =?us-ascii?Q?4hju/kiyN8HsVt2WkDuNThlyjymLStL6tflBKyooSWfXGTKRwqLm9h2bYkm2?=
 =?us-ascii?Q?ZY9sWFSNhtd7HDYU+Ga+D0NGWgcbdJgT5OTfN4b0ATc9Ld9Y0bQCGMSpKsyn?=
 =?us-ascii?Q?TfU/npZKJ5XPlZXDnAqwNgfluqUUEJSMK/4k2bi6kFK9w/holEyyx2r4XF9q?=
 =?us-ascii?Q?uzQ7uK9IoMWnQrdu8dNY1GZVDcqUKxWJhwp4areJ2DqFn1vdFZOGMEazRs9K?=
 =?us-ascii?Q?5Ta6TovSNVAkv9NJTmNMvofNHXBWccChPcgJnQ5onRKCo422Vle4g6TIctk8?=
 =?us-ascii?Q?iPLSsHBDWJtEzsrKELdp3EoHjaSsd4wW7jrERwVw+psEa1QrRJNbWPX4eVwc?=
 =?us-ascii?Q?fd1Ft+TzXcrWHalgkK3yKS7c6mY49b/DE3Fh83spUvGZQeSEGGA1RqKG6PCU?=
 =?us-ascii?Q?CddH0qJ6MozqXc0a1TQNunpBxwy1VWPjp6AeS8zLr7nQN2TIgzPVxfaJqGIE?=
 =?us-ascii?Q?xA8xWxVJsIVSi4JU1+VENosddvECAOnIOmqRunOFJpCVj2lxMCwiNj1R0ZVF?=
 =?us-ascii?Q?HSd+aHkGVyj+Qv8t21Srfgpefn0ahEQ9i5pbr/7ue3a7Y/NlPYdMMN1gXsDN?=
 =?us-ascii?Q?9XyOrcsO9Jw4N4dtzBNG6vhDrviJvRAB768wqijx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f4192a-0c80-41db-4d2c-08dc94af4c45
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 00:39:39.9435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kFaF9+haFLBRBEt7kH/NzRecE57BNZwsPmBH/XWcKeSWwfVKwullyEsKRcLUzjJdGUJjf91VewZr12de5J6bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5055
X-OriginatorOrg: intel.com

> From: Greg KH <gregkh@linuxfoundation.org>
>=20
> On Mon, Jun 24, 2024 at 09:28:49PM +0800, Wentong Wu wrote:
> > Fix a spelling error in a comment.
> >
> > Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
>=20
> comment spelling fixes do not deserve a "Fixes:" tag, sorry.

Ack, thanks

BR,
Wentong


