Return-Path: <linux-kernel+bounces-339672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9BD9868CA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45521F2535B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6C215B12F;
	Wed, 25 Sep 2024 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l32XX6IF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F2C4C91;
	Wed, 25 Sep 2024 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301356; cv=fail; b=s2EiqmGAi01o5HLkEOW41th6tCP4C7NNwh/nlXhy0XNe6+UoJ6wp6mPZl37HzBHgG25jWLu9qDYW8LIo7fvdfprWFQKeZj0RkdVVY4ehfZcHmSodDMZVCqm7UgBZB+vPKwpKXeVcPSobMa6svaKUDfomlRuzrwUywLZf7hu1XHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301356; c=relaxed/simple;
	bh=Ql5biwTmmN8R+ic/vHsF2lg30xVwIVnRIg8HHid66Y0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qYWSEDmPtmhUu9xnzHZHz72w9LufYywWUEOnxrEZGYCf979whXygoEkKrvRRR+47T55M3wrVOuPRfQtFARISB+m1bgxbvdbxG8qM3+joetIUf/hNam6N6Q0gtwHPGKqfd6lknd3OdWl09tBWj4I6FgRm6tKl2AGV+gNwLX5T3Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l32XX6IF; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727301355; x=1758837355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ql5biwTmmN8R+ic/vHsF2lg30xVwIVnRIg8HHid66Y0=;
  b=l32XX6IFwez8r+IvOVQjO5LUSpHvrFkWzBkIE5jRH+EMePWSf74NWtRd
   +ordGR6xwf6LZSX5NyW4wgqZaF/soXRYuHzBXUagAkkvZ5JWzGfDT189m
   v5dQfMTWOcQF7kPCzhKp1m06ozfjHBZzVaEM/aD7EVlEoDSTvDVk+JU2G
   /dusfFSw0mKNWRgXRTpy/XDp8dWzfeiJCN7LzwbBLJ8gjgMulVTBWoyDI
   fTvbMD3bRoCLi5jf06pdMTe8AECtdeqqYlE7o8XgHOFmkBrgegY8lEmBb
   c/TaO1sZ0SKnoNs+yZabqwcd3qQ00n8NafeFffp585pn6qhfmycp40ueZ
   w==;
X-CSE-ConnectionGUID: dppQ14JRS/2Xm5xCjyu4gg==
X-CSE-MsgGUID: 6vIFUqzcQUyP0Gx/ZQ9G0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="30169588"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="30169588"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 14:55:53 -0700
X-CSE-ConnectionGUID: UL2sPrIPRxWwsl8xyKEbzw==
X-CSE-MsgGUID: 4cU6AKSvQOiPlFnofXOHyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="102678049"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 14:55:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 14:55:52 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 14:55:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 14:55:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 14:55:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1bD1LvMhVzG5udKiOXdONWMaZcOzbPG0Z+5tgmoCg+jL7ZXjexibiJWSlVMtnxvbY+Nw8Zh+vMyY+F1q8WlY5oEC5uGbR+phx/HVmL6PvyEQfPFjMTHTrTiroV4GSJM9gAa3hEQQvfPFLhN6SDh/Vsz38z/iRIHA+mbDSvWK2O9/L5vWMv0h/c6o3IOK6rHif0/gGQbITP7PdH90JMydOfRjSdorcfXXnq47FPVY8coc+mo3Q7x8fSJwbFytAX8D6STTvq3vK5xbM+/mODdECsePqVd+16vF+yJ15IbxrSc3eucFiLN2HyzaCticYVEqUOEsAjlViuBkrGbW8EH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ql5biwTmmN8R+ic/vHsF2lg30xVwIVnRIg8HHid66Y0=;
 b=GnQescIilXcglL8gvNf6VOG7OnV31n9gQVLrNtUlr+ffAl/fTem9dR2a2nbT9HpmbuK0Fmg+2n5te9HIYg7us6qVRVmKAk0gGANw1w1feTRhEXB/gg+ycZdHEtqQPEOxAA0de/nrd9bNDYVRZVm00xk9DWvx+cJ8X64SsD/2Jlm5zUfQu7U5xvjlRMZxFv9ONyismAiHuq1Z4nFi1dHMtd/1OGIBrvay8G2bazVAfreUFuIdh1BRHL8q0toK+ZQgo2qyBIiCeGPYkXtvgpIoWCjqfkKwjmxy+hoSZCQjedm4iHqjrl91YCIwl9B+S0bm9XArhKFiTQXOcoFVFPZpmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6978.namprd11.prod.outlook.com (2603:10b6:510:206::12)
 by SN7PR11MB7510.namprd11.prod.outlook.com (2603:10b6:806:349::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 21:55:49 +0000
Received: from PH7PR11MB6978.namprd11.prod.outlook.com
 ([fe80::3f47:ba18:44ff:4e42]) by PH7PR11MB6978.namprd11.prod.outlook.com
 ([fe80::3f47:ba18:44ff:4e42%7]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 21:55:49 +0000
From: "Hall, Christopher S" <christopher.s.hall@intel.com>
To: Rodolfo Giometti <giometti@enneenne.com>
CC: "Mohan, Subramanian" <subramanian.mohan@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"Dong, Eddie" <eddie.dong@intel.com>, "N, Pandith" <pandith.n@intel.com>, "T
 R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>, "Zage, David"
	<david.zage@intel.com>, "Chinnadurai, Srinivasan"
	<srinivasan.chinnadurai@intel.com>, Greg KH <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v12 2/3] Documentation: driver-api: pps: Add Intel Timed
 I/O PPS generator
Thread-Topic: [PATCH v12 2/3] Documentation: driver-api: pps: Add Intel Timed
 I/O PPS generator
Thread-Index: AQHa9SpbL2VeOEvxAEylbkrThcuyVLI1rmAAgAVr7YCACtKKAIAjUuPw
Date: Wed, 25 Sep 2024 21:55:49 +0000
Message-ID: <PH7PR11MB69787046B1F9CDA610523FE5C2692@PH7PR11MB6978.namprd11.prod.outlook.com>
References: <20240823070109.27815-1-subramanian.mohan@intel.com>
 <20240823070109.27815-3-subramanian.mohan@intel.com>
 <2024082456-kitchen-astride-7892@gregkh>
 <801c7a93-667b-4c23-9493-4cbe979847a2@enneenne.com>
 <2024090304-viewing-lavish-c05e@gregkh>
In-Reply-To: <2024090304-viewing-lavish-c05e@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6978:EE_|SN7PR11MB7510:EE_
x-ms-office365-filtering-correlation-id: 950d06fc-47f2-45a5-ab8d-08dcddacd113
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?CQ88ZK6EuKbRR3Xc1pJkimR0jZFSGxNQDhaI66aJ+WQ2DzqZt/Zbplo1ahHu?=
 =?us-ascii?Q?NLZC1ZYzOeTzupkgs7HpKQbSkTG3WmQc44xalpfRVbZhdRbyuYlARegn3uLM?=
 =?us-ascii?Q?gMK1hAo7dH+Er0nQkXVPVfslmULrFcx5VFS0enVvvSpUTrcLcBc2Lj+TpVir?=
 =?us-ascii?Q?4yekIA8tAQ2bGz0DKoKAcevzHzJFI/LWpDd4yroKAGrCu2bPQ5Lh1saVR9Uw?=
 =?us-ascii?Q?jjiC0Bo1aGe4jIzyZcG5T+lUUVtbrHjhUvX2wJj1R3o5VcQV7m5wVWCPYOJT?=
 =?us-ascii?Q?T1ZDvRos3j24ERs8qeDCs+EQ9A46VLBK2B0v/C9kNht9izSFtQNyPQUYyz9h?=
 =?us-ascii?Q?K4w3fpkblXTX6eTyQOp1OuZarucQy7kqh4qGUHzhsJ0ht8QbMTDAl2QVMajk?=
 =?us-ascii?Q?zzDqjSjsxd1PGRYq17mmy2nls2Ev2bP/b0K4Me8SGqUH7X95Gd8+3UU3+2nL?=
 =?us-ascii?Q?2e2PJYxWM5YccD5K6uUUDzpyKlYU0XE3+KQdj+9XQJ14Fh+gdLLQtjJYNxmH?=
 =?us-ascii?Q?SOu/anlqfEEJRIJkPJZLSrjlSPzkfBHCkZO60e8mp+0NEZRILgMXzuwDKk/7?=
 =?us-ascii?Q?pS8Lb7SlpnrSGo3aFhfrPU/CteZ3945juNsQgv/RVbQY4TmTIavyJWS/7CvK?=
 =?us-ascii?Q?OHv5vO7xQJjSdV5LY56YBiZfP6dPWnCN3vCHKJj6BEEzJGHjfFka4ZhzU/79?=
 =?us-ascii?Q?H6UPKXtKA7ZaqwdB7wojxEs2B38ZLFVC08CwrbN7DvM0FtXUqWXX+L1Ka0b/?=
 =?us-ascii?Q?DKxezBtHmxTNX59VczurV68MwaiNttPwhG50byE80IKcLg3/bfXoIUIgKlJd?=
 =?us-ascii?Q?8RO0wvrMs85gT64zr1jmrSHCN6EQ7dr5aeJpXwkGVFlm7QRtuMpgRihokgLG?=
 =?us-ascii?Q?mPRchR+1Dl6vxzLC52gNd8+OrVAR0OExMzXnwb2/TFng5mADeDV0zHdsBj+S?=
 =?us-ascii?Q?3d1FRSo/XeKCcNJS5Cqt+yt0myIdF3Al9C5s2kvAWiVmUdrmf7KSTz85UciA?=
 =?us-ascii?Q?DQ/4LKXJMjJR1YnFCn5xkGmWm33dUpQGGFdFniteTivLEu7hJB6LcNhu5y8a?=
 =?us-ascii?Q?iqTln4zSdyVkWPCb4aSMK3hhk2dxZPrX0pyL3JVlLKR+I2LCvBPsy+hFMxKm?=
 =?us-ascii?Q?qthhaBxK8GrotLiEBmBxIJGcPLfCbnFpdFotfaL2CtG6WRp4sdtTt2YktlAr?=
 =?us-ascii?Q?Bs7Uznq8WwA74MPZhnH8zrfwOlCPAYMkpnzOv7mfSzt09HqxGZngAmfNAZ+h?=
 =?us-ascii?Q?rj/UJ1BhnyReQKNgKOSHeEyQDJ82j3EBew0pLOQf4Bv7mlJAKqPStWfue7P0?=
 =?us-ascii?Q?bk0JBHXVRPPVXK0pOdfe1oo1SivX+V+Quru5EM1QNcvpyVPDGZSuDOgCVSJ+?=
 =?us-ascii?Q?Y1aLakqzA/UTIasLW4aQ7EaTQsxOsJW2eBvAh/pkcLZ9tPNT9A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4c7HP441TbqSdQGXk3XbjIvat4MVyrzotuudD7v51X3PG4MvwlLmK7XuM8wP?=
 =?us-ascii?Q?K9xbPhP5CKZOLbbjc2jDUBzNQ5+GBCfwDpUwkYZ3qM7jpFq1SXuJQgviPGqS?=
 =?us-ascii?Q?+zqUIGlQm8zSZgW8/UlK160SBS0oCnpmC9aYto2zq20M6ViYGcTns7rAcbo9?=
 =?us-ascii?Q?ApLAq5t/88ZbO8l4BCr2KEqjWfrNdMdWs59G04DGZ17G5Sfb4UnlIfqNAedZ?=
 =?us-ascii?Q?gm5r42YJJHw8oH3oddLUk7BPl2aUr5fASo1MFAN7ToretEsekHZmP2rCC2am?=
 =?us-ascii?Q?BqDgUghItpfJrr4tQkhliGwQfSwiHFqca7UwsiocR8d32kD55npu/uRbud3k?=
 =?us-ascii?Q?KK+fcjbhleIygfya2zN6czsohq9+D0NZRvKiFlcs2I7uWhNm+Phga0wGSibH?=
 =?us-ascii?Q?vvyIEZeNTNgWAuN+J0zGf7IRY3u3v2uvYkNzjWYiZli5Tr7zyMekVHSrFVv0?=
 =?us-ascii?Q?H4K72pmEMoNexrMwPJ17NQigT6fAdRRbf8o9qxBYojqmZecAWRRQ4Q5ewRle?=
 =?us-ascii?Q?YocvXhntUbO2jmvxCO8/k9ePNB/LKF8Kbs7Vtj7hR6izvoSx+s+Hg9wFBEMJ?=
 =?us-ascii?Q?kPNNBGpSplp8+N4L48Qf19VQfK8XqkeqXhzN0FtovT0KwPLK44h0dxUk6ggC?=
 =?us-ascii?Q?CSZjICozFZZ8VuRa36HMYZY75VUzBtdvgUXwEiVT1x236AxXeO2z0lnJdmok?=
 =?us-ascii?Q?211q2rl50eiEfqxaxKkyLa/9B0Yrixb+I1U6qS0IdyGlJ9h/IjNTQGT5pUhs?=
 =?us-ascii?Q?G2ApQU+Qi+ZxT/vXcaOQZmbyWv0pLExwdCmlOYCVI05V5O919XC7gi3s15uE?=
 =?us-ascii?Q?88lDLzt/WWVqeF7T0rT9YUFhvuI1crIcjKGynEKTWSgEy0G2kbr9vH5NkQCl?=
 =?us-ascii?Q?j9xRrvB4cSxmnpkhXU5ZhVVixhxoU1fDtcY5KfYzmMEjQoVdZq5zKoCQ+X8p?=
 =?us-ascii?Q?zH+wEnis6OAytVAIh+9pUfcnifcgV/Qd8g8rlzKE8srMI7iMZbEj/c+6MJBP?=
 =?us-ascii?Q?V0efm9dfDe9vgmSAAqIAQnZBlqY8LUdcc2swem6hHLkEf1F/JaxWtYBNSlhi?=
 =?us-ascii?Q?WrVbqessDPu70u/uKqy6/UVfl6YutDIdPDHldk0VloLL5g2bc4mL1xmuF32Y?=
 =?us-ascii?Q?NV1tZdNFnpGh/RqS+ic4MvhsXY0/eIgPjgeMSIzpAWWkt/1TJ8TLXHfIClqI?=
 =?us-ascii?Q?RM+gIonaII+YP+sBGiuQgk8Qmkqfusqkz6BN8kuJpZhxKwgfabEf0dQjwmUw?=
 =?us-ascii?Q?gRBevbM918j7tAM84ismZHtW1xjOto9iA/hFHzbd1lpAqaEtZw5DHRBZOT4z?=
 =?us-ascii?Q?ElEv8yv96pQClcK/mafbZP/45LrIdBpp8kx+/iYB1xgizzqLH1aIB4YLoZ5f?=
 =?us-ascii?Q?jlgQLwyTygRoSAMgmZwr6ZfhnhY7aCCFY0Cz5n0D8XsigKfiUn8jIhyuLKqT?=
 =?us-ascii?Q?W6RkUfAVrcAzH8wYy5u1f0cxC0h/ofLM20ZoUfDhhQ60LLadP0XCWPAYqMc6?=
 =?us-ascii?Q?0pPAYawTvOiF95XsJBkCLdMXSf4kKD22L93D2nvWDJDx7DY4/cATP0mBjcko?=
 =?us-ascii?Q?hbg3jruRA3jZ2516W5h+MwEeKcc8Q21OSI9CzWMuo8HA21UFa1ExmQxZlzgr?=
 =?us-ascii?Q?ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950d06fc-47f2-45a5-ab8d-08dcddacd113
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 21:55:49.1294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NRc88QZZplQYIjlNX1kTTs6deFn/d3tIbszlcKCgmJ0oRXV7GWGdORdjaqQmodwGV/uyPrRXRpDK1mkLOJ5e/qYgleICzk8lq1dGojDfzcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7510
X-OriginatorOrg: intel.com

Hi Rodolfo,

> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, September 03, 2024 3:25 AM
> To: Rodolfo Giometti <giometti@enneenne.com>

> Subject: Re: [PATCH v12 2/3] Documentation: driver-api: pps: Add Intel Ti=
med
> I/O PPS generator
>=20

> > If you are willing to stop the inclusion due this fact maybe its time t=
o add
> > such PPS generators interface... on the other hand, if you agree for
> > inclusion we can do this job as soon as the code has been included, in =
order
> > to fix this anomalous status.
>=20
> Please make a generic pps subsystem for this, it would make it simpler
> for everyone.

What is required to move this? We can certainly test the code and do some
of this work, but I would look to you to define the interface.

Thanks,
Chris

