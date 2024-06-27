Return-Path: <linux-kernel+bounces-232000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA2391A160
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE7A1C21D28
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6A17BB14;
	Thu, 27 Jun 2024 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqmIUJtR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E23878C60
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719476774; cv=fail; b=BAW51wojYUv5+T3n9BIuKsH1utvdnhDHUgW+pDbtvhadFq9BiHCSXEk16iu7EWSKU4DzWcusL1kf4yGhUzKBGLPMA0Rga2KyB7Gp0NqPSQTS1ORKFyXAuF9V7P62RG0Y8ujkl+vkf6d4X/u+s7RkeR6Vk7VZvEMlI+S8tK6nukQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719476774; c=relaxed/simple;
	bh=quu7Ynu49/X0mT0QSCO9mfZidcoqTqosJoMNumYNWzI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=afwjSvpD1Uk1Pkf6MO7+8KRIAu8unQ8Fuu1Vf9NOwCH5s5Eryh1IO8Rq/NnY7fkmRsbDqxc3cMr0Of74Y6ZV2qpjIC8+DM88di4tjw78I4/TRqkY2/EUH9183lqOdGT9xQ62ULlOd4vGfqAL5R3xu1yblhktlX/HK0TkItFBeWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqmIUJtR; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719476773; x=1751012773;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=quu7Ynu49/X0mT0QSCO9mfZidcoqTqosJoMNumYNWzI=;
  b=VqmIUJtRLe/rEo9yW3iLYDQgrCnG2UWoznJ6LcUCTJC0T8gOydfyebKE
   INJNuBG7t6Qr3TP0LB0aj5YZ2Ib8hUV9iNK9X9g8QnR6z4pKK+iFTRbNz
   xmqmElbRoZDa+wS8ZaCnbOabjW+ekFWMvuBg2oJQXN2xx4b/cMpkVHz6h
   ezVY6Xq2e8qCbPzAsRnrP1aTAhfhAlMJ6CBryDDV2szNl7Gdmln2P/7YL
   azbxOaMwPti+MHOdJrG5iqbOtYnovcrL7AoZ0c5p4/teVU3+c+L40OEnX
   qqGKkd1T5+nJmcVSjjCwYD1GnDvymKVOjcO89rVPlbXwv4bbvIjZItWTX
   g==;
X-CSE-ConnectionGUID: KYx6EiWnQDCLGsKqkd6bWw==
X-CSE-MsgGUID: pcnApFqDQkm+TDyYSEChjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27275327"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="27275327"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 01:26:13 -0700
X-CSE-ConnectionGUID: PnqR4p6DQ+mVxNNFjBOAYw==
X-CSE-MsgGUID: 52dpeF7wSIGeC7KXiukGcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="49236439"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 01:26:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 01:26:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 01:26:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 01:26:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtE+QWe6ZAPtl91T6rS7clAXox+LgjCSZgF5Hlk6eS5HrmRXDahxzOcUFseZk3dUGRprnEjiTux/nqemUOcwPAKmie4acW9sMWnbs1YhDFzGbVlGNbiTO4tupEDJNI8k9vgwiNFy84qz7JO/fp8yI8fLiNDD2SnEGVFV5CpCQnNbVsS9yC2aaBr/0AuA8LRB3mkrIUleHX89QxAnzfbhFo0JpefedEYSIEufP31d6qtFfvkA6yod4dLY9HuD1nRmyze1drYdAJL3y/NliwgD7mlxbxvZWYLs1FAZII6ftJWLjVJpyQ9gn7mgJQtT9G4cJDHbRPj2tVF+SMMW0+5W/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1AwGxCy0vvm++h9Wt/gsBevqmbKtqksXYPMzKjtB9I=;
 b=GOnu5iVkL7Ootf1MrrEhnRzHNvzZtq5nsHSm8zzji1ks/xx2LIcv1kXgf3B48ikoc5qXW8gxNsnYgg/CyEoN75zqfT7kuNI6R1xM9+lbwmgXJxCFDeZOz5wsg0Z63z/LEvwqE7UGUUJfE8xrnETvbrrfeY6Hm7xqGkK2IrtCrTpjzF7XnUokv286h2xljK6WZprKzdpvcdVwRalFXc5xP67QsIxgSURMXWy5G9cuGq6ggiv0eFo1+T/pQJopdvFcRj9evUml3Or/x5kTcLjz2OiQ3m9ebjFvs3hO8AzAFJFafW7x4XPkT76WpyLFjEGNb7uxJ7Vq45pTB29oY+uLPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by SA0PR11MB4656.namprd11.prod.outlook.com (2603:10b6:806:96::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 08:26:10 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50%7]) with mapi id 15.20.7677.030; Thu, 27 Jun 2024
 08:26:10 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: "Wu, Wentong" <wentong.wu@intel.com>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chen,
 Jason Z" <jason.z.chen@intel.com>
Subject: RE: [PATCH v4 4/5] mei: vsc: Enhance SPI transfer of IVSC ROM
Thread-Topic: [PATCH v4 4/5] mei: vsc: Enhance SPI transfer of IVSC ROM
Thread-Index: AQHaxtde4MSjxvDabUevy0rw48oj27HbSWtg
Date: Thu, 27 Jun 2024 08:26:09 +0000
Message-ID: <PH7PR11MB760539800F3086911CC14DE9E5D72@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240625081047.4178494-1-wentong.wu@intel.com>
 <20240625081047.4178494-5-wentong.wu@intel.com>
In-Reply-To: <20240625081047.4178494-5-wentong.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|SA0PR11MB4656:EE_
x-ms-office365-filtering-correlation-id: eb3d851a-7503-4671-e445-08dc9682cc77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?33qZI3q3QnQWTpBIBm93G+bhS+HYaK5tQqEde5lIu5YzWJMmMsO8glpY15O5?=
 =?us-ascii?Q?V6K0UQuMU13XK9Ou0yU7KhPvJRRc1BscRjsDs1Zvn7/Ey9lb8yf4bBzI8YgQ?=
 =?us-ascii?Q?qjLugaky24LDeMSnnyWr7QGrdkTOTG6eb5twi+1y1ihg7I2wWNx4me6yRDPQ?=
 =?us-ascii?Q?hfRJxPd+L2RA9M7pThWCnvv5fU8uPyAGLI8C8FGr7Rim/pZKL85Gw27LhfN2?=
 =?us-ascii?Q?Co9OsMy4n4Sq4pXsLp4MzR1DWgivlOOjbc4kxEI9kGaNsNzzIsgDtqgOyAq2?=
 =?us-ascii?Q?ZefVJBlmYuPLgFCxTXfVifeVx2nITDfjXzGgJNqtObMWN7DvroJ5Exh0zdYc?=
 =?us-ascii?Q?4Hqid3Fm0BPmbKIn1xKk7kJBtzSIDbvSEvHo45yBHFrYSyaKj9xWjRO9mfZE?=
 =?us-ascii?Q?XKR0GEgdEWNhsKYS3OnwoV5XrVtuW/8r7hRLp42KPvWe/mygWZKJcENfKA3H?=
 =?us-ascii?Q?Z+h6kbWyxudCeoA66D8eLrrsrMyGmLEo+GhTfa3Gbk+JPs8k+M3V7XtO0Qkn?=
 =?us-ascii?Q?jDkpEeAUU9QnARLqf/nmaq+Jeh7aZ+fquQ5vD9ikap6X0bjcBe36+3yIDlR/?=
 =?us-ascii?Q?OIHedCI/GVP4C1G/Z3YT4FTe1pCtv38L872fFtgChxsS/0LKiV3WGNnrEpjK?=
 =?us-ascii?Q?E5OzU9UAnBuRRRjD7S1/ABrH/A8SUhiLcNl0OCVtN5oiDc0/p85HckBzu49v?=
 =?us-ascii?Q?iwMhhFpUGUAcIYPLwRQd2sTSvAM54FbXP3SJlxc4NMocRbcic5W3xYKS0+mj?=
 =?us-ascii?Q?ZcKZFmCG4Ev7LGZADm3GlkVd5iVn5ugxaLZYaRLBvWHzhEEqW1J27/AunyvB?=
 =?us-ascii?Q?n++78pSYEBH2rNs5FOU1wmUVBSXJ0xvAlsK/JmIfNtDKJvn9ngVFAnCnkjBI?=
 =?us-ascii?Q?B/yyBTOUyTAro0vX1twPtNjVA97jxfNtBbAqaf/Rg+w40IU7aK40EjnnBpo9?=
 =?us-ascii?Q?aRlGWjqEWmmOLOVMGLivLOver0vQj1WkdmdrJRCiwhHD73zCfGvZx8swBBUS?=
 =?us-ascii?Q?hUV/Q0Vpi9YbKLvfMHs1VlerC7F6lLDrBluJcxuc4FGyq2qp713jNfpr2iyF?=
 =?us-ascii?Q?HxVqRQrSb4NoRwLJg2fK1nz2ZiDw35hsrMYqMQdbxic3CDNQlDmV9BZL2XID?=
 =?us-ascii?Q?fSE6qm3spkq4ZrS5+EyeGnS1TCcn1/f/U7ZwAkl99ovQ+hd8bDlTAFco+BTe?=
 =?us-ascii?Q?FwdgAoU5e+2MmTpw2m8fwewz6DkPZ+doVuN2fON8ZcQhY2OYtkOIfHxgbde2?=
 =?us-ascii?Q?ccZr47BN8QROQguI/m7yJw/jIaHGbjeCjwaZjJNZ68uZikQvYFxyK5bkR20k?=
 =?us-ascii?Q?wXWvVHOV4gBxx++qRSc2kyWMbEueXZUEBUh1jIpwWaMh39Fd2kazlZIpkxA8?=
 =?us-ascii?Q?XAFDUH79X91gsaCzGcjf2FpFH4/chWROLO/C4e6L5ptR72JBDQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eFgxJfs04QeLwLfawYQ9XkCJA6XuZ5z+mgyK40LHvud0h1JZdb0R0RAo8YZe?=
 =?us-ascii?Q?h4tMxK4lVsu3b53nnFY9q9r1lI2AIX2FPHyfi3TXj7fY6cD6T5w+mjCN+GwN?=
 =?us-ascii?Q?ud+bbzhQoXqIGN57zquylGLZB789r0s6FjEj5RFG2imQdOC8RFCOir94NwSt?=
 =?us-ascii?Q?yhx4sQxbt/aK+b4LzEX5yBxk04KUEDYYJ3kixgp2zObi1Zq8UKRDq1quk6VP?=
 =?us-ascii?Q?WvgUOsmcIkB07Uj+lIJTb0ok+HUdVJXLJXA2HAbgJTjtawQnUW7tBMEXReZn?=
 =?us-ascii?Q?kA58vOeDgtPyY0uqmlllKXBOjhQNHe1tspj1uLCEyKBtduCgzkUD+agYaTdY?=
 =?us-ascii?Q?sIttBsUEXwEJ3KZKEP5LT26KMiab5X4IfLl1bnQVfplrC01lMhsEsGxl+N8F?=
 =?us-ascii?Q?/mtM/iJhr9W6lush251WvfmVuO14Q/teH828kAdS25SSCsscdtPxTgbCdvQu?=
 =?us-ascii?Q?pSmNqX5fBFXe0uBUlaAiUIo8hCj7P66OHEvMJ6trgQWCcBeFRiv/hxIzvW24?=
 =?us-ascii?Q?I/KCqueqdhxsdjxGbpeYpD/d5JAGnMoli6gH5WUmenMleG2kkI/q++bRYWuR?=
 =?us-ascii?Q?aShZ+VHh53BZc7duITUkeENsg4YnE0AlgXNGvYvJYvPbTsZrG+7aZuI3EkqQ?=
 =?us-ascii?Q?RfSh4GhfZ+HundndtmG5/Hi+eCTZ7H6VobEddQON1cWSClToNyA+34xkw/fT?=
 =?us-ascii?Q?goaULsEzDLF1NrMfWqzXWAiRfpnKWzkzk+PjBVumQdnF7l7bKeTehXqthtNW?=
 =?us-ascii?Q?7f6uTTpgYm+AB/mWOu1MxWGW0w/bAEGI2QiNlC4Y8F9owfRk93aygmV2ts20?=
 =?us-ascii?Q?/3JWzrFR+FB7PRjywMRABaYg57X+1xntrvOL5TS/LB2v40ycnp21/bzbAYmT?=
 =?us-ascii?Q?IpwSt+W1z1z1g/OOSWa7xvWnVTxeLLq0sZnFk1q3Y7AY43/YnqeymRCt8KSx?=
 =?us-ascii?Q?45/OXgUVAr2vZHhr/I9EfOSuNBbGjZc/dl633+AkhVaGJ2S+29XyyNshhE1u?=
 =?us-ascii?Q?2Tplh/5Hw9PhpI3rZ7LlPjmzTrLQ9jqWxfMrdxgWejcsVTOY45Hu4ZMqYCWo?=
 =?us-ascii?Q?g2vZSA8gw2HeMD72xwe6AEn8kWv6HDSt8qFNd3tCa6wnBxBuzqMmN3qiQxcA?=
 =?us-ascii?Q?qDy51E5hG+XAyK1x4vvLnX8C7WbZmyS0c3Hs3L6n4VrlX/x1qk9OHolF4s31?=
 =?us-ascii?Q?hK5THhs0zj0vF6lMkOt6O8JJKcBYXR1BTEvFlvAnUDJYQ/zNAdT7x9luRXDg?=
 =?us-ascii?Q?r5SLPIn8fKEY6LhFlnm8SHVS30VbnANtEkw36xvjk6P5b4JgF3U4W6diJwqR?=
 =?us-ascii?Q?oczl8RJ5cGZf95nGrmZYrGAEB3dwlxlR/xmJs2XqDRdJhnmLkIVY0w7dxCk8?=
 =?us-ascii?Q?GTnTPjKECk7aSqoTP5Cn5hfs0JXK4FpmM7/aTvRCTlFsuKb7SmC76d7ln+Pq?=
 =?us-ascii?Q?mPqA+Nszff+W0M3QMtL0uRzA/COYPtVf7FU+RlF5vCkIr4i+daxt5q3hMs08?=
 =?us-ascii?Q?S/LNscqnMnVgBd7iWNy0z4sleBDaCuA2KKBHV3MWDt3FEHRsd77N3eOX0HwO?=
 =?us-ascii?Q?5K3FMbFevxYVcSakZoipaAYOuWzqfsQugPzbsitK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3d851a-7503-4671-e445-08dc9682cc77
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 08:26:09.9814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C9azvJsUzHXTX0kqEI4GuYwTRLWBADmUJ0XScNDdFECNR217pNyWz+r4uLZb3jUqmdFqUb9pkvknu6Vaia7/iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4656
X-OriginatorOrg: intel.com


>=20
> Before downloading firmware, a command response is required to identify
> the silicon. However, when downloading IVSC firmware, reading data from
> the SPI transfers with the IVSC ROM is not necessary. Therefore, the rx
> buffer of SPI transfer command is determined based on the specific reques=
t
> of the caller.
>=20
> Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> Tested-by: Jason Chen <jason.z.chen@intel.com>

Acked-by: Tomas Winker <tomas.winker@intel.com>=20

> ---
>  drivers/misc/mei/vsc-tp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c index
> 876330474444..1618cca9a731 100644
> --- a/drivers/misc/mei/vsc-tp.c
> +++ b/drivers/misc/mei/vsc-tp.c
> @@ -331,7 +331,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, const void
> *obuf, void *ibuf, size_t len)
>  		return ret;
>  	}
>=20
> -	ret =3D vsc_tp_dev_xfer(tp, tp->tx_buf, tp->rx_buf, len);
> +	ret =3D vsc_tp_dev_xfer(tp, tp->tx_buf, ibuf ? tp->rx_buf : NULL, len);
>  	if (ret)
>  		return ret;
>=20
> --
> 2.34.1


