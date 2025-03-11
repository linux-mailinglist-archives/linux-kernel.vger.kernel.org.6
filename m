Return-Path: <linux-kernel+bounces-555894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55150A5BDF6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16838171DFE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661C023875A;
	Tue, 11 Mar 2025 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LyKk3UnV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21AF1EDA3A;
	Tue, 11 Mar 2025 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689279; cv=fail; b=OYHKRefE7gxsxo+vGQegUwhmuGuWWRGULqTYQlT0XPjQezPnW694ZKOmSOjOGTz+I/IyMnVa0wplIYpsADywxx6CbYFWxME2i1RUQQqL+DtTWAl0Fm11AzhSI+/vmgVPuvNL3QHWNUf6KCKgbzAr2xQzCSOKh/xXQP3IZPZdo+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689279; c=relaxed/simple;
	bh=42VTHdIJxGlg9b5Tp6hN6Ffi1hqa2I3JlLJyRnLV+PI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i41AQN5WWXb7vE/XPveLQqBfKnFTh4EuxSvkdVDgoTRAJs0/ktFhbhjOAgX878oXlALxOUFI82LY3QElHYvDqSUiDtzNDvYCbJUwdlhnMWmKgckHnLXyfMhKvJX9PdVgl9XlIHuWKgrRC3Ct5x1SN++wO29O8Jc8MyWACJJuRg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LyKk3UnV; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741689277; x=1773225277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=42VTHdIJxGlg9b5Tp6hN6Ffi1hqa2I3JlLJyRnLV+PI=;
  b=LyKk3UnVghdoREebsQWbLcuZEmAJ3iLcu1KWoleeBO+iF3bQA6mMCips
   de4bbA58AImXOdj88Ah6ZPZ14E0ei2UIEw2ErMGDvkTLekGmEWl8Yt3mx
   38FY5WtRjPTujQt3Fd8a1fBLeA8SF3cV7+KgY86DahBlWm7h3jjU8Hur2
   yb+HcjOsvv0l9OA7IeM+BRtfRJVaZ5V+l5g8Ve0gefEuPYqrBVIJa1Jc1
   TCogebAna+YWZQL1KRs95uIr8tLv7SPrp8F1zTVAXOT5pExW112N+ICGW
   W9H4kvXcwkFCq4V7S5S/9nAaEXrZk71pQbeY5DPUlUU2Di8UQ/SUt/yb5
   w==;
X-CSE-ConnectionGUID: 0hHKSwF1RGKFKBL6VQ3Mbg==
X-CSE-MsgGUID: 1awno05vSTi0nhMrd7oFbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42848419"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="42848419"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 03:34:36 -0700
X-CSE-ConnectionGUID: yxRTqv/pS2S4sx9tvv8H7w==
X-CSE-MsgGUID: ru5E/XhiRGymfjMH+hVabQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="125329850"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 03:34:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 03:34:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 03:34:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 03:34:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TR0DPm/DZEoV/Fh5ye5MsAYIT2aaFa/65vJlwWRr0qtLBFWBp8mGz38DZFPlqVFtMlhonMRFFSJwMyaPkWRymH3EigeLEd6s1R5ceRXUEBLILVg9lkpgEn+CmsGoUyOwgaehfvi5sVgzADg7KZiw7gAHv9vk5NICjuQlASne6VmTkpqawwCzvTwd1YNJSYRaSqhTeOgjXqpbF0wISmloF9cLZLrofDWkkVtGlYX2nhO2X5mfMAU5ARhtgHAveRLxacWOQbnWOOhsnnMBVPeF3cUABLdbVQKeGMeuTUp5rhXNHXwgXxP55k6tPDiU0/D2qACWXV1uT+Mzy0zazaI8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42VTHdIJxGlg9b5Tp6hN6Ffi1hqa2I3JlLJyRnLV+PI=;
 b=tQFS+NoxMY9BUJrIyCewCCha1dTA+1vHK6ap/ctcM1Bi9qV3do90jFqrYKkzeOQt773WOImDH5BOgn5BhbcEaRO0fwfn7jQLpAtVXQE5siPabRObJYXCJqPushjEk1EPphxINpfM/CQxBS5dlWZQJwWaSxb3YAb78HEMFrev2aaqbLy7PXeuCO/08GFcHelCrGM+OaAeEcP0+q1N83ra2BH7oxP5ZuIXqo2DJDDYJx/z8A46IP3fB6B9VbY1fsiMqQhZJ3suei0ASl+sBKwMIDWCfegosnEg2Rk0qM/Pe6J4MJPHv4ektEfy8TBLGOnw3jZ5uG66uQ08NRu21Y8+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 SJ0PR11MB5815.namprd11.prod.outlook.com (2603:10b6:a03:426::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Tue, 11 Mar 2025 10:34:34 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 10:34:34 +0000
From: "Ng, Boon Khai" <boon.khai.ng@intel.com>
To: Johan Hovold <johan@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb
	<linux-usb@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Boon Khai Ng <boon.khai.ng@altera.com>, Tien Sung Ang
	<tien.sung.ang@altera.com>
Subject: RE: [PATCH v2] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Topic: [PATCH v2] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Index: AQHbj3fR7rxGNFLiLEuxz/BjkbEixrNtl7IAgAAmBoA=
Date: Tue, 11 Mar 2025 10:34:33 +0000
Message-ID: <DM8PR11MB5751B33EF33ED26FD8E63508C1D12@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20250307154355.30772-1-boon.khai.ng@intel.com>
 <Z8_tDGssqs9DBaPU@hovoldconsulting.com>
In-Reply-To: <Z8_tDGssqs9DBaPU@hovoldconsulting.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|SJ0PR11MB5815:EE_
x-ms-office365-filtering-correlation-id: 857bfa57-de6c-4a0d-1946-08dd6088508e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?gdB37FdpMP28eKXPexL+mj9tcrBOAlAzcEcRTLl3YpWtsUzi96S59XYFluVF?=
 =?us-ascii?Q?GBKQsTkgZy5gp8ZlN/3nCYoEYU0BubLUQ40UijJI5i+IE/RUnaALiJsRZHvZ?=
 =?us-ascii?Q?O1ZbEEGLjUwd28/+qLMBwtoLIt7WCGY9MUiIb+V3HkANYRHbaI/loX1Suek1?=
 =?us-ascii?Q?M/NAM/QKM0BrmXSxGUeMJdgy927KQo4PXzV9QRsfaT8XCcbPcUhWXuY7PEFe?=
 =?us-ascii?Q?QmjxSSC2zikSKMxV3+rruoNINB7aX10SapTOzXgPTNllue4gE0yAVqnnd1zU?=
 =?us-ascii?Q?ClPEzA9DyRdiv0jkxrrmmf7uuApUNaR4OKTz00CUPgTJYH78F7gMEr1oCkQe?=
 =?us-ascii?Q?nvaK25cQqbmSDtPbNg7VATeaIcB6ClFHaH5e6YsSQYI2keYLdZzGROG6u+MS?=
 =?us-ascii?Q?RovPO38T9f1SJYFqCllLHov+LPUd3gNMc5ZI6zn70zh6SYj11nj+IP60USaS?=
 =?us-ascii?Q?hCy9LJu/E/5pb+EE17/BWWtHuwDPLmVXwAFoU9uxgHQJ44nFdEi3JMRpJLvW?=
 =?us-ascii?Q?5Uc0AvW+hg4PbcGe6C1XkPej85b3cMw3VJSlD0KlXQjE20KOZe3znEzQTKcG?=
 =?us-ascii?Q?Ef8tPOFlC9K3AAeN1nV46wxesf55Af5swo70WmhwgzvE2Q4DOMlBRW/ZrqEr?=
 =?us-ascii?Q?K+u7M5QxZfTL9GSgS7lvT7hqc8vBrSBVca8D/KBM/Cs983Vs8xOgHpLUH5mu?=
 =?us-ascii?Q?H7TQGj3tocyC1fqqh97sTZSzeAl16+Tk6HNoONC4+X8Gvmf4lx/5iyFnNbCP?=
 =?us-ascii?Q?yT+EoT4BCVh83YfYEEZ5t2/+PQYw9IImeaCYnZVkUe2xwlMZbC6GL2YTF4ZT?=
 =?us-ascii?Q?nMe9/UiwhmRgppLIiWYaK0w6zWjT7byXwBvI4LhFKbPWTost9sCsyf8aTr2a?=
 =?us-ascii?Q?F9awnksAwXbysmAphgjzIPv2eloV8fwY7tT9c/OywvBa3KxbwDROLZQKDs5i?=
 =?us-ascii?Q?HmKEQmfqfyRbwZI5LF0gLLg3QlvfT+BXkl+tMGLE/UWg7vP4l6bOgZU/Fyaq?=
 =?us-ascii?Q?Pvu2FGYRK9riyYmlgA9oevtKSmo7fXttUSAB4VmKrvnMgrYiAcnXNkl945AU?=
 =?us-ascii?Q?lTVHqXsaXWcZyPQ+NtX9Hb/ARZER0FBROMGVD7Wxihfswt0mc/47CQ7kzasx?=
 =?us-ascii?Q?MlGuXVzifg285+OhedQPiV/v28ocT2OTUGbbDvwcyvKM3wNad3AcBBk1o9rs?=
 =?us-ascii?Q?n4y1lU8FXkHfWHhknkKROZrgD06UNua1xqjF9VfzuPzOGOYz49ujvAVp11yq?=
 =?us-ascii?Q?fQwLBJ0mQ6oYy+UnSDC23t34JtaIUTlmrPJW2yu+PLPmGv1RCU/oOBL13/K+?=
 =?us-ascii?Q?4p7CdVtHWG46JucUKwl1xrr+E0UhAJj8glmyj3iPzQ/oFWZgaOaJquiT7FZk?=
 =?us-ascii?Q?iplOZPsMBKwh3IAJAUcUVOuZlZMF9hMc201yqMn4AnKJs4oD9OJvYvhHKNTB?=
 =?us-ascii?Q?TKlKzqo3z9JYxjZQfPdUy98x0W6wYglw?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?glpfrNPxNsGChNf99yVzOaNOPRv/ZxaDqYbQPR5ONhye/tqRqvjvMOLZ0hyT?=
 =?us-ascii?Q?ar0NJ5xSXuu8hCxR0zM/1q1jMPJk9rIO6krjaTghwWqOfIAFOwCT/79B9lor?=
 =?us-ascii?Q?vLFgbFSlXnisod8Im5zV/9kNsFdZqhMvhMwWv2QxOD5edve+p1g72dYkRwK5?=
 =?us-ascii?Q?A90l50dqJNWh0RAKhR0M2lH5QXgNYpR7jCTrFCIOSw5FJ3zrU6jpj/znE2qT?=
 =?us-ascii?Q?cxo2jzvUXkd4UqH+Dhvi6h2yoNDaDYcD9p8k4YZxZXW/b4StM4Mow7n48gQI?=
 =?us-ascii?Q?0wpYdhniahWLqQ0UfX2IVi50R+XfVaAiBsTNQQvH9c4aUpVLoqaBsGacH5nY?=
 =?us-ascii?Q?jbce9WSiadHVkQ3bQ9y4u3Er77VDID3xWl4vqmTD+nVsyFwtKh8nqOUl3wTG?=
 =?us-ascii?Q?OwtVFp90z/wXAXPV8y00M7kWAQ5d5Nf1fKYQBnOXtAAAH40A4aNAXMQg2Xrm?=
 =?us-ascii?Q?P3MUif9Z8A0TWfA8oa7Xpcq6ugPaDWKePUkEHXmGZ2iaaFYjWeqAwf+NXyXq?=
 =?us-ascii?Q?qGs6aJzKt1J7LshcTT2XVK2n1svSjwyR7FlxJByef7n74mXC3FUGFu5qOYz+?=
 =?us-ascii?Q?uh9+lWloaTK6y+/3W3wu5iGe8KWv6JvLKQDv1A0PBlkfXhQvPwqPtRsj0C3+?=
 =?us-ascii?Q?Uy0OLQ7/xSh89u2VdqH/tbWfHGqeg47bDoKNMx0e+X4gdOTA2qgnX9ZgjMLP?=
 =?us-ascii?Q?F1Q8pzrtEIPrx0LnrAWx7EFq4ZocTEm5kS6z2UAG4Ew+jrWXF82aUFdBgh84?=
 =?us-ascii?Q?XXuNjTbM3LdHVEw4Agyl7gSjkBIJJXew7ATjY7b74KM8efrTDhaFThwXKB4e?=
 =?us-ascii?Q?C3TobdyWsYwZwjSrIsrZ1GZqBO+VkNsxQVYJANGGR/+Fdb36wkT8VgW/u+Rs?=
 =?us-ascii?Q?BQahD7yHCyE8WHnb/C1mWZx+N6mVPlj7pnVRXAHiNzum2Z86/RBgOln+/lUi?=
 =?us-ascii?Q?d2r5+iMGszhBiQwdDw4YjlZa/PrW7MqZjA4t8b2VvfLo2l3aaySJagfr3iD7?=
 =?us-ascii?Q?/mnm7/GkkjtkhEKl9YI/AV/S+pof3gP74Yum2MrZgDKlZIBLjoXbLGp7cHjW?=
 =?us-ascii?Q?KpA3qtAj4t0s2wVAQ1GS3WPWGf+v9InugQ4OxVgfCfP9UhqWMQlviErNwatH?=
 =?us-ascii?Q?xP3AzhS8xdMpVBqnJ1+NsPSZdMHHOjnvO/f9OSC9Jdx2/gdBDnrVTTWBlGbW?=
 =?us-ascii?Q?Jq05AZiqrcaG1h4OrSK8s+IVdsf64QzjKlkgLx77Ao+qSDiiIsnnlaKW9Yo1?=
 =?us-ascii?Q?WQ8kh0qEIlvIR55fTkOGIzw4UJDbFmxZbqx7agJdCXfIKIY867x4g9+ebBof?=
 =?us-ascii?Q?0R519o3YP6PDQzfJRugiG8EsWuYZ0/NeydIhlCfizgC9v8fXnGITBQf2aAxH?=
 =?us-ascii?Q?Kd+Vj0OdrQnBUW3YD7GZyfC8xnYoNsThBq7yvGJF4zQICtf6gka5iH9HpgoG?=
 =?us-ascii?Q?FXrh/0VmWRlsI70NF9I0zMCDGv1OJZLxOPBDbekaFJCJNQmFkzJ0KSJ9Q/Mq?=
 =?us-ascii?Q?EFQkFSeEfdKoOoaH0ICr3AhP8KvtkJ+YYVmL8fSLbXpbKvyaAx3IIq9AYNg9?=
 =?us-ascii?Q?vRdSQ3A1bIPyEzm5Yzfrb8HAja4U8x4nxATB788b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857bfa57-de6c-4a0d-1946-08dd6088508e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 10:34:33.9173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0jwZJ4/TP8e4pBpGaFBsBfcbkUg0yjS+8F3i1qdcsRbj2JALPkTJYQnO0KzB6SK4DO1UgB5kH5zebCOSsG8CjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5815
X-OriginatorOrg: intel.com


> But for your future contributions, remember to put a short changelog here
> under the cut-off (---) line when revising patches.

My apology will include that next time.

>=20
> These configurations were not mentioned in the commit message. Are they
> also used for embedded designs?

Looks like the table I provided in the commit message is mismatched with=20
the one that I intended to check in for upstream.

Let me correct this, the one that I published for upstream was the actual t=
ested
code, whereby we want the UART to be exposed to the ftdi_sio driver.

Below is the updated table,=20
1) PID 0x6022, FT2232, 1 JTAG port(Port A) + Port B as UART
2) PID 0x6025, FT4232, 1 JTAG port(Port A) + Port C as UART
3) PID 0x6026, FT4232, 1 JTAG port(Port A) + Port C, D as UART
4) PID 0x6029, FT4232, 1 JTAG port(Port B) + Port C as UART
5) PID 0x602a, FT4232, 1 JTAG port(Port B) + Port C, D as UART
6) PID 0x602c, FT4232, 1 JTAG port(Port A) + Port B as UART
7) PID 0x602d, FT4232, 1 JTAG port(Port A) + Port B, C as UART
8) PID 0x602e, FT4232, 1 JTAG port(Port A) + Port B, C, D as UART

Since we need UART to be exposed to the ftdi_sio driver and the cable USB B=
laster
does not support UART, will reword that on the commit message to remove the=
=20
cable USB Blaster and left only the on-board USB Blaster.

Will submit a v3 on this, with the reworded commit message plus the change =
log.

