Return-Path: <linux-kernel+bounces-535334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77684A4716D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34BCE16E6D3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C940017A306;
	Thu, 27 Feb 2025 01:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZqz+WJA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2824A16F8E5
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619584; cv=fail; b=mJH/h7in9nIpLrURSposI/GviRH695L/MOWL0/1UjuqKRNUTvvyq1uSs55efIeqFQlywlrZP4oo6bPPPuktkcGc3/g4v2NbLdw9zHdXCoQEfFrm+orAU6GHR/gxe2dl6dIcnzsZnwv23a1unTR4iI1OtzpgnZ3iBcRXHrgmwPUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619584; c=relaxed/simple;
	bh=Tpg7wLts89nLFa5+eUQmmMdEwVIqjB25YN9e/oTlxx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4y9EN8jqPh1JL5ijf9zBp+6+oZM1/je+NKWD8JUHpIUGy4KPIBWVgkEcw8vsLQOagDAl0tDmdKWdRrwm6mkcds8OlGXcLEaFEwL6lk3bw2bCx7OgEcWcbNewN+iqHX4VzXvDPT6GXbRkRkW8kMX7TE3q24Kic844u6v91P8h3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZqz+WJA; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740619582; x=1772155582;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tpg7wLts89nLFa5+eUQmmMdEwVIqjB25YN9e/oTlxx4=;
  b=BZqz+WJA88ez/MxDIGcNcWGjhfhlQxqIABhM4OlKuyCl7YOKRy3hoI1d
   7VItcHgk952wQGfLBIxpAtMJKfEXW+poSEuwIcqCzN2cpqgjIrqke0EzI
   SBteUWRYlA4mmcwezkqzq09iVdsm+cm4JoXENQRKAX/1SpKzOUUZvO2XJ
   g5MmQOCGkA2013kJAbqJy8nvFpvDZQcPTMItIkZhmSqW6zuGVqgNSgUQj
   /8fUYxJinzEiwcgTEySthx4CsPfHrV8S6haxT5qIvLJ9nKGdYP2LhpysU
   VT0iZlMXbyssq+sL7V4uDRp8aemA11dBz7IhJe+rpBILLduNZjt5N3K28
   g==;
X-CSE-ConnectionGUID: lkeNjjkhTB6RB0vf6XFf+w==
X-CSE-MsgGUID: FdwMgtzPSh2v9Le56BCS8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="51701640"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="51701640"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 17:26:20 -0800
X-CSE-ConnectionGUID: w/l7EPhkQHSe5LaLBzes2g==
X-CSE-MsgGUID: KrY4rL0HRWWIEkODmXh5Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="117359661"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2025 17:26:20 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Feb 2025 17:26:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 17:26:19 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 17:26:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/vYZL95XYynSUeMnvMrtFvkeA+OGSAqc8SHhwD1nWyHnkvCAukQbtnkVC8RdGbq1A3PV3f/+OkVcSqbZd/fD/qV//xQ0XRApxtCpUsjsR/yWRnxqr2vj6TQzBaVDXIb0KueY+Q5IYfcirDwueJZtLnCOUuCQ9uaAovp163Bm/PVCtsGZV6AXdS3U4eZdGCi/rV8nUIM0DwxaJGJpQdovWFQrpwOzavazZ4s/zG70wiP9qRqQrheyWrxRLjZkwlTr6K850CpJBUjDwOTbuQep8FKKkCYiwCuBt0gGlsQM4tDJTe9DOWaERRYIw7UPNxXDDCelDa2jS28lhF9R4Jz0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nMnhXQYT9twqXFFyJ4HY2RKNjijDJNYgbKaGs6yOfM=;
 b=ULN/ATkFEGtp5b8bnYSMMVzgQsGqFqTs/qw+TD9RAYK83S2HWvwyfKLwMxP7OFhSaaopQ94RqIxslBlX5P/DlHV3PXWGLn6dNQemcVMIEoIiJyfAp+Tein+3y+MjpPxtwA0hck0zaNpARWXxoo+OR6fcrqqzmza7xSBfg0CLAymRoaGi0OI/50tbRoN7xY1nAEY/TsWZAukpGJ04rsI72VPvgvw6ATfwzwgO2NHHAkEVneUZd0ipXcj/XjCyny6zFRdpbP3U/hHtGMYvOwGNJseXS0qCoeaKQlwFrI3g0tl5LX4vkmlP0CvuBpLKl55zTN/BjKup4tpAOgwuIkOM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5995.namprd11.prod.outlook.com (2603:10b6:8:5e::11) by
 PH7PR11MB8453.namprd11.prod.outlook.com (2603:10b6:510:308::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.21; Thu, 27 Feb 2025 01:26:04 +0000
Received: from DM4PR11MB5995.namprd11.prod.outlook.com
 ([fe80::654c:a738:ac8:7908]) by DM4PR11MB5995.namprd11.prod.outlook.com
 ([fe80::654c:a738:ac8:7908%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 01:26:03 +0000
From: "Zhang, Lixu" <lixu.zhang@intel.com>
To: "wentongw@amazon.com" <wentongw@amazon.com>, Stanislaw Gruszka
	<stanislaw.gruszka@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "brgl@bgdev.pl"
	<brgl@bgdev.pl>, "andi.shyti@kernel.org" <andi.shyti@kernel.org>,
	"broonie@kernel.org" <broonie@kernel.org>, "Wang, Zhifeng"
	<zhifeng.wang@intel.com>
Subject: RE: [PATCH] MAINTAINERS: Update Intel LJCA maintainer
Thread-Topic: [PATCH] MAINTAINERS: Update Intel LJCA maintainer
Thread-Index: AQHbhEQbktrAP2Ov+k+5TsSlB7BYu7NRgbOAgAjidnA=
Date: Thu, 27 Feb 2025 01:26:03 +0000
Message-ID: <DM4PR11MB59950B45B309F5A10301440793CD2@DM4PR11MB5995.namprd11.prod.outlook.com>
References: <20250221083713.25947-1-lixu.zhang@intel.com>
 <2025022134-storewide-greedy-8d4d@gregkh> <Z7hK2ZYt4K30ACc1@linux.intel.com>
In-Reply-To: <Z7hK2ZYt4K30ACc1@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5995:EE_|PH7PR11MB8453:EE_
x-ms-office365-filtering-correlation-id: b2913227-69fc-4872-9491-08dd56cdb38f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zuUBI0/b5Ndr+TW+JQdv2kto3blmyYaIwLkSd/qxDVvjWZd3pbn/bfkkO8Js?=
 =?us-ascii?Q?0XUX2T/Fsnz+4w6qrN+v61uv0h+CgjB4ewRwP74MvUDNXcA9lDm3p1zZCJ0x?=
 =?us-ascii?Q?HHt0I8a+gcz7ArLi42SMChapqrF7VXsJsGCDaLO3aDEaKoT0vRBvBu5AKYv/?=
 =?us-ascii?Q?QOf0+aglqah96Je7DvEI7gveNYFXYnKr/ad7Es2c3Cu+JK+Dmrk8hfvjkK0j?=
 =?us-ascii?Q?eKHSSihOQuICUVt4O5lwQE0L7G+cX5WV8CLwBYXCX6agltS0gkoG5+9E3YGL?=
 =?us-ascii?Q?MGLV6HjxuwFWMFVjfE8TRIy/QTAEb5qxGmi/0A8b+z9WMeFvRfn4S1h/U/Hy?=
 =?us-ascii?Q?GdFOIPeSJvubvK8mvRsQGlL0GUqSQhfORceg5g1F4YXhZKfFGY7I+Ghha0lW?=
 =?us-ascii?Q?TGRdOX1evElBcaCZ5a+Kknu89cVX/NGA2Zg3RHinYfRzsW3MXtE8p6/bJTix?=
 =?us-ascii?Q?hINSxVB5HFTbidvgOfmIqzamfIoROxN2lUH6tQNXtRmf/MkrukThLmxvwNlp?=
 =?us-ascii?Q?12qQGfey5oR8NRC8yo/Gl62rr9AaNYtbHyZEkUfq1I5u5xWa+MEBXiJ6UjHC?=
 =?us-ascii?Q?AIJd4DD7xxuMXWQ6tre1Xwn4K4S0q9TNIbIJW61x/onCHEKQpMsjjM93x1Cq?=
 =?us-ascii?Q?Jxf6h21pab/Qr/pRd5+43B0F99aKVhDuU1Pc+8xHFa0MCpxirPXbp31ttFmf?=
 =?us-ascii?Q?AFLwTf644b6Q5T+5oHMuWDZN+oeZNLDjJ3SoNIfNpJ4XzG/Tn+cIvNH2IgvQ?=
 =?us-ascii?Q?gdrLyeuQxL9kGnBtHlYKbKCYr9SGmeLpT2imvY98hWh9U58oGfQF8W7F96vQ?=
 =?us-ascii?Q?ZXiryVa/O9XO9YiiyXnTLnatC1W/GKrXnawm/WT4mb06rzAmBEuh/UyhGaU3?=
 =?us-ascii?Q?MdttDSljo0mPIXiuWmcPeqoQm+tTVqR/lipzNRSXU+T6A4AZBAQXw/G8YFoz?=
 =?us-ascii?Q?F1i8NZSd4d1ufgWiMZlD6UstOJYoxrC+fhxy8d2eFtm2v57RV53GNox7TMxc?=
 =?us-ascii?Q?YpFH5x2wZOrV+FXowuszGnvkIXKngZM7JHPtKEUdlnMX22cleb0II5gpsQ2l?=
 =?us-ascii?Q?tfCx0xV6tKxphaypzaQi/pFthz5lhrkIABh8ldu7cIK6Fis+7KbZuXkjSrCc?=
 =?us-ascii?Q?VonNuIUeMrklG/127RWDUXit3eLHeuP3BrIHxlEz+JDedGHbAjpvFdCedYoC?=
 =?us-ascii?Q?aTdX3yNg8m7LnlXblyhNxlilBEaNP/Es2V8M1ipixLAeh2mGBmwJlUu8QnxI?=
 =?us-ascii?Q?a532zYkhYjXhGWkIrzTAY9VcIp+iZVm6QcARXFjxU0PvI6iL2b0oNuZmqKcj?=
 =?us-ascii?Q?xM6Re1aF7I4+8B8wfyvffiB7iD5/o/MHTTHdj0qjbFl/J7hEn+ZnINXB/f8F?=
 =?us-ascii?Q?z86eFo5L+wqb4/LWiqJOkR6Y5sBDadreafSNGB+BIkIO0HjHStavILgFfJN7?=
 =?us-ascii?Q?3OEJi62JNWveTygjDcGprKf3DgkOUrK/?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xvLeXXNoMsQ9E4puOeVf+g6KWMX5V3lqqvVEa+2dU4zwkIFrW8Vi9/wVI6E/?=
 =?us-ascii?Q?NEUCNFW9bKYEPP2mHkbsVtthAMhpi1WZSJz2mKTgl+YNwIZdh5dJEqFE39uF?=
 =?us-ascii?Q?nVq/0E8B9u4YQ568UHWrLaZY8ygmQ9LScP1Yh0HMt4Q89qiMwreA55fkLAFb?=
 =?us-ascii?Q?jmWtZyHsPkdDCKt9iSU1VI5YwQu6KY/WaBu1uAEfGtSQ7XlEbyzHuNBbUNRl?=
 =?us-ascii?Q?k6gHgs+CyIflVwuTpfirUFswgc7f9SuTd5UcKSztA5cvlY/wpzw5bHV6vPDa?=
 =?us-ascii?Q?fuphSzISctn6d8Sr3UDDq17L34X4CZCzvRaf7PAklQKMoeHYyb1NyAhVrYND?=
 =?us-ascii?Q?Yga8nJeJrxqdVrRHc8zfUDhA+MVKCOf8yjdp0K4yDwQ1eVj5hP9dEZtx3Oc0?=
 =?us-ascii?Q?P1Gu2XYMxwnsFqiD/KiONn5p23uPOQgiQp5mV71Zrcrt4JOgcCAuEefGdQ34?=
 =?us-ascii?Q?Yk5cbkvgtMIwccXTLCoWUf0v3uhdLYCioAr5GE3Mh20UaMHAkQRs4ZSf9uKR?=
 =?us-ascii?Q?q9dwTXrtksfOY0Oy+94qJ4Vt/fXeo1Kr8MX/3PkEf7JnGIHIUWlR6j0AUKW6?=
 =?us-ascii?Q?StVocchCBBhAFDiupxFk+MCbe61UG1yC9TiVPdDeOtjwun2mJa6IiRdL0i0W?=
 =?us-ascii?Q?HpyorkHdm/qKkFUDMIAZiHlukg5lk2suRVmxrjs8v/jRIN059hXavaOIkuh4?=
 =?us-ascii?Q?pHzh+smnYyFrWpKzhxcf41HqkWCjLNrp97D6fat5wohVdYDM7e7t0H21dizD?=
 =?us-ascii?Q?B2iMexFleLiawAx2gxTaoz89ukgaOxbnbRkP3r1qx73uR8eRK+T6duKdcWad?=
 =?us-ascii?Q?U/lCwBfTgdYiEYZPdqpiqsewZNPoqYcjpPrPHvm5S1JrlAWBfAALaCyStums?=
 =?us-ascii?Q?vUIvPU5biRWYP3if9oVWaw7ewfeI1tSyc24yvfnvqVZbFHGOnrljtDhNL6th?=
 =?us-ascii?Q?DziWvGwk66V4dXgJTLMe+9Op7lk8Rf+1jIlo6jCSKYocIlegKU5cMNPtLGVR?=
 =?us-ascii?Q?bb8r7GJyhSWWIUkjsJZC7QPpfsf9W0ftcW1ZtP/5mKg8iJpH/p4WogqasbW7?=
 =?us-ascii?Q?ELHdZxvK2K9x2rEt7SsoZX+sX9wmxZrlIN3gJT1rD6PX9ds11lTjVvjc/PLp?=
 =?us-ascii?Q?7T8ikl3sPQGE1M6BS6XcN6pDAY1vVM1v0f+p+hC/3QvPdu5Db/oxFKu9DyKi?=
 =?us-ascii?Q?mZiKy50lr/OnCS11kidWeG1l2cyFcsEnyjPKYDJzp+Np8zUsk/hY4X0YywI2?=
 =?us-ascii?Q?3XpS9aOLFOs0FjHSow9zRLTcfIirZTsD3fO9zwG8DR68XxP+OxXPKyQHIhL0?=
 =?us-ascii?Q?RVA/8jxagOxbQ0Msm14gIyJHf9JYRdvULa+XQ84p08W/Ip+CPg1D08Y4FwA2?=
 =?us-ascii?Q?QdtpxvgkJCGdsFcEjO2WQD6g7QUFXBq/NLJ1e0nKykJ9Z3CCduAtYK2rqKHc?=
 =?us-ascii?Q?yA6ZlbdKyb/0gbJCi5H8eD/HdMFh4NaDI8IxKB326af+ApJ8lJiBq4CgmwYv?=
 =?us-ascii?Q?ni+CCLu3cDVwlJNQINybN8vtdZBtddBQJwEF++oAR2xY7ftvKnC+24wM3KvH?=
 =?us-ascii?Q?GESax3Ukr1o60yO6Y9BVh7gdibbBRU9DMaAtayvY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2913227-69fc-4872-9491-08dd56cdb38f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 01:26:03.7124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tcLTvwy00KTVDfA08zFz5eluYm1w9cNocGSMMwN2wx/cqBluk3fKi8XciiN2XJqaeefqpv/JAopIc6pzNK89xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8453
X-OriginatorOrg: intel.com

Hi Wentong,

Could you please ack this patch? Thanks.

Best regards,
Lixu

>-----Original Message-----
>From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
>Sent: Friday, February 21, 2025 5:44 PM
>To: Greg KH <gregkh@linuxfoundation.org>
>Cc: Zhang, Lixu <lixu.zhang@intel.com>; linux-kernel@vger.kernel.org;
>sakari.ailus@linux.intel.com; linus.walleij@linaro.org; brgl@bgdev.pl;
>andi.shyti@kernel.org; broonie@kernel.org; Wang, Zhifeng
><zhifeng.wang@intel.com>; Wentong Wu <wentong.wu@intel.com>
>Subject: Re: [PATCH] MAINTAINERS: Update Intel LJCA maintainer
>
>On Fri, Feb 21, 2025 at 10:36:02AM +0100, Greg KH wrote:
>> On Fri, Feb 21, 2025 at 04:37:12PM +0800, Zhang Lixu wrote:
>> > Wentong is no longer with Intel, I will take over as the maintainer
>> > of the Intel LJCA driver.
>> >
>> > Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
>> > Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
>> > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>> > ---
>> >  MAINTAINERS | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS index
>> > d9fd56f205c0..da09f84a87b1 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -11818,7 +11818,7 @@ F:	drivers/crypto/intel/keembay/ocs-
>hcu.c
>> >  F:	drivers/crypto/intel/keembay/ocs-hcu.h
>> >
>> >  INTEL LA JOLLA COVE ADAPTER (LJCA) USB I/O EXPANDER DRIVERS
>> > -M:	Wentong Wu <wentong.wu@intel.com>
>> > +M:	Lixu Zhang <lixu.zhang@intel.com>
>>
>> Wentong also needs to ack this, just because someone leaves a company
>> does not mean they automatically loose maintainership.
>
>Not sure how to conntact him, his intel email is bouncing now and he did n=
ot
>provide alternative email before he left.
>
>Regards
>Stanislaw

