Return-Path: <linux-kernel+bounces-210955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97132904B18
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26953282FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F625381C4;
	Wed, 12 Jun 2024 05:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XB4gnQzf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCFD36AF8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 05:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718171731; cv=fail; b=A1E239irERQFf4ht60BA/2Z3oDGTEYFXXz6cfrGe9q4qlTiYTaEaYZZYtBessYhPmg3uhzjZ0bq03aGT8Yn6RkJl8sH+20cl9pPaDq5LR6Wq7CY1laDEXNYrb1XxGdBFgmq7pqBhpF5KkMK9eJ2s6TZ9gA7y+95gXspDjvQAvh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718171731; c=relaxed/simple;
	bh=wCO0jOVRrExt/tkEhs9bPpRpZTsfHQbPhReibER2kZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TpNs/bIi27UR4kjD9AsiyaQLSXjJ/00MdbSP87RCQbbMyQ9LSHUG5ashJ4D0JDP8itjLXubyjfmedEnByuqhUejJd8thNIb4LkOw8vzQAuEPo9ej315A6abbXa/jjRX+AunTTE06P+gqxPdGyqSCf6b9xyzmc8L9yiHMeMvXPGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XB4gnQzf; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718171729; x=1749707729;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wCO0jOVRrExt/tkEhs9bPpRpZTsfHQbPhReibER2kZk=;
  b=XB4gnQzf28Rp8v/0L4h66cOyJIVd+akHpf6ACA5xa7I21wiaQQIoDCsD
   jQpm5jdqUpA+E3vnqcoYkEpFM08OsExk0AkNcytBwFD4cxe38+Auu5/b9
   Xdwd+nRGvuX02wqaGhcwfvWHBcrn75wAW4KDntbwMq3STFbY0QHP22yV4
   N3/AIajp34fwFG2oTxEAqraeUdJp2n5g7LXvPK9ndqdVnJ4g/i0t7B+LL
   qEvwTP70umy3LpdwKdGBFpaCyu/bXJJVuZCmiDJluo6jAO3USY9NDz5cl
   QMv59/iouWr06TeiVSSV13EVk+QKj+wzwBdVwfXnfZJusNqMxZY9M69v4
   Q==;
X-CSE-ConnectionGUID: SmWFGRSvSRSileHvqOU1Fw==
X-CSE-MsgGUID: kSfdVREdRO+jZqE7txdfSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="40323933"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="40323933"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 22:55:28 -0700
X-CSE-ConnectionGUID: tbNY11T9R0SBaA4F+5duzg==
X-CSE-MsgGUID: onyDd5QES9mztS7v7WdSUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39642232"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 22:55:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 22:55:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 22:55:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 22:55:27 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 22:55:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Av9VACy+1Ep7uae0qQR9xM4VbJtHWcdvRG4Vu23xXEWtHnB90iD+XVvMDY+wc3qEFlR4D8W6l3LkqXJ14/wRTBXPvCqrVh8BoZSK6BYmejD9Q5S+e3AwA4rrF6+BJfF+zy1KPm22Irvy42NnkQhCwkNtkvy8wpbWpVlR7VXV8M6I+pMu03y4fkkwL8wR/LkWqJSsy88E6WAg2z+xEbeFZl6SIReN8DZJ3JDxgbp0jBbZeJYWxrvausfLIuOboNQLrD9YHhVyegotFbhHvqyWhAvWTjxCRC5OLxrfWdka//xGTPf6WZ/+KkbngZDCmbSQBMcEVeAgmB8qn0tyDXH+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk4cssBkr5lBbKOnmWtEEUGsEgJvme64T3lgDRMkVFg=;
 b=m8yHMIkfmjMrXpdphn27NVHrk5LlYcl20eL+5EEAl13+LB/b5lAZ9k5dcxuiPtDdouc47eY6nYUxx5wlmZoxg8PJse5katZ56ZyHL/mYSOCJEVIIkRFH5XL8rM9WdpikVpR8nqoBX58+RyWuEgFl40efaB4g9OrQvV6usXfsOXt/PNJUo8FVzWbZ7tdG8pkpUioraLfyZD5xvjM6G07DAEKqBX+0fDS3amIp1iDv9xfU5P/Mr6WwaVVX0HpnyD+PKN8IpDHQuY6p+yvf17khMofXme8oZzYC9kGIpZQhonUa3LsSSGSagWTrQ+ALjsH1yLBoTx1rWoZMeyVSQTnnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SA3PR11MB7462.namprd11.prod.outlook.com (2603:10b6:806:31d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 05:55:20 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%6]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 05:55:20 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Oscar Salvador <osalvador@suse.de>, Andrew Morton
	<akpm@linux-foundation.org>
CC: syzbot <syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "muchun.song@linux.dev"
	<muchun.song@linux.dev>, "syzkaller-bugs@googlegroups.com"
	<syzkaller-bugs@googlegroups.com>
Subject: RE: [syzbot] [mm?] general protection fault in
 dequeue_hugetlb_folio_nodemask (2)
Thread-Topic: [syzbot] [mm?] general protection fault in
 dequeue_hugetlb_folio_nodemask (2)
Thread-Index: AQHau+sDpqX17lR0T02oz/+gUJzVurHC0iiAgAAEmoCAAAGNAIAAvfWAgAAGEsA=
Date: Wed, 12 Jun 2024 05:55:20 +0000
Message-ID: <IA0PR11MB71857839BD4488371CAC4E9BF8C02@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <0000000000004f12bb061a9acf07@google.com>
 <20240611103005.ae4170608bd15d63adee2492@linux-foundation.org>
 <ZmiNeTL5cZYmCbNf@localhost.localdomain>
 <ZmiOxhiWU-CE2ilg@localhost.localdomain>
 <ZmkuH8R2XJZEvJwh@localhost.localdomain>
In-Reply-To: <ZmkuH8R2XJZEvJwh@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SA3PR11MB7462:EE_
x-ms-office365-filtering-correlation-id: 4cb22e25-7f36-4484-021a-08dc8aa43e53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230032|376006|366008|1800799016|38070700010;
x-microsoft-antispam-message-info: =?us-ascii?Q?GAPpkLiHlPdqHPj64PdzyPVI0UhPc7V2LXX1BXHXri80T2ykTLWgpB5mGxNx?=
 =?us-ascii?Q?XrVkM9wC63SDQViCkzkcV0LwT+I6gwOmiT9HxCvtRrxYF7JnBqB8UZ2H5WaY?=
 =?us-ascii?Q?SwIJZD6w40R4x53OpT6zHl+bWYuunFr++uyFzC8DIY3vGYWPhaBBjQ0uiS0M?=
 =?us-ascii?Q?JAABTc4/eZS/o5O0Z0HDKINBwCLd2joHHmsbOyQSegOvwH/xEnzd9ZZxMp+x?=
 =?us-ascii?Q?NXauXh+Bk7pMocuJ7Bs/AUrSNSywZC6Jw1oHY9cKQIk5JqkFOXNNA7YXoLLy?=
 =?us-ascii?Q?1E+pE3rmR5sUdBPLyffmFLibPejZQSPaFuOEsQnMq6A+hyJcIW+lZMOr1/F8?=
 =?us-ascii?Q?XYM9z8pw05o5noqc+MNmCmrmD0Nx+4AuszgqapBONfYN+GdkuQ7BNElSeP8p?=
 =?us-ascii?Q?K1jsstAXFPC6lQhJA85sUgVHluiPAu7MzX2gnuauxJiu4Q5ICaDpJsd6lo/d?=
 =?us-ascii?Q?UjksSwSMUItKE+acFWX6vFF/huZiVCOPXRDWgzAb+N5ErwclYGWoOdM9vniu?=
 =?us-ascii?Q?cLZaTh6Cz3aqHuoRZZdWhzzZRr+vi++QV44t6uvLDqKm2U5ZiLt0TIyH9uZm?=
 =?us-ascii?Q?kC1YTGoK4INBZxNpYjO/lWHTKTq2+DNtHf8bmiljitffzlFr3xKio7EVjIe0?=
 =?us-ascii?Q?/j+CMKSRprGWKNS9p+lgK8TjhnNS+0MoAag/iKVDGxUePUN4AExGxPcvT07t?=
 =?us-ascii?Q?+NjuAbYLwNHqDKY5noAGqvvevklZIYQEd0+Fc2V9rh5YaTiFuDEf15sfjIoo?=
 =?us-ascii?Q?FzVAmnXDhqgDZsblYe48xHVNazvQrwiXp7oCi7DfHTG7Yn1zj/wZ/pDnUB8v?=
 =?us-ascii?Q?V/SwGvMQynF4YaBbLUiGFYti3st7NylMyKzMetc8ICUnI9RxIWQDIH30bIol?=
 =?us-ascii?Q?vnwSmOr0a3O4QWLCqmNBWIRD0BOKnKqzHpnJjrdN2j5epm9TU2DLEf47EjLg?=
 =?us-ascii?Q?jVvS1wug6Ipr3uWZ01xYBi8gXhEYP8dGZIqFKG4+1Bi8kaLk7KYzy/P90TLa?=
 =?us-ascii?Q?GGvOIMQFBoAbnIqm6Gz2eAfoxaOggnj40k1XmswDwqRVol/GAdWNIHkd+/WP?=
 =?us-ascii?Q?xDZIaOV2T5kbXPpX/lRXLCl6TkrkMF3LzQtnGf6dIDKogWJFNZpS67moJF/v?=
 =?us-ascii?Q?PXZXEuX3M000yiUqXt7m9/AryMJA93oYlUYS7XH1VewLCOI5Z/OdONeN2ctH?=
 =?us-ascii?Q?iNtsNvvTwmWDmm2NgYjboyX3IahkzR7vXJCQZcKNXKvJGuhYqKL5xQkl14xX?=
 =?us-ascii?Q?EcdXkL2k46eKPESmTu0kcvZP/VAlX5KVvygqZCT8bs1TJ/5ZZChOHNCpE5OD?=
 =?us-ascii?Q?s1rtAeUCCbLKTohUgA9aJIhSiZ/Z8o6jKRkVK1P+YYWe8Xch/zY/LwgKMIp+?=
 =?us-ascii?Q?CwQvgvA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016)(38070700010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MqF4IOQfC+zh5LHfeAUEfIx5oC7a+UswGVU1cDBw/5VFRR3eKZUfDluz+T5V?=
 =?us-ascii?Q?1TRT2P6iquAAu4gD+G4taP7Kl4RJAdcUuMYr17O12yBays0PGONoXCMp4lHr?=
 =?us-ascii?Q?qC8p4hKD406wX3ZK2fOZnrNRyj4QzfcM55C72u65FhZrSdLhn+D5+oAiELO1?=
 =?us-ascii?Q?i4dZB1HlvdtuJORKNljnKmo0XW9DyzHyTn0LuSO5JKeK40gQd6qAFeE9zxBW?=
 =?us-ascii?Q?4cR8/+eJS052pLxsXpg3+o2/J4NJrxvSqb+P2lBPABt/jauyPTdtqIYqmUGi?=
 =?us-ascii?Q?5ELTIRBVRq8gKmX8goyBDgtiX/9hETAE48e52nA1oiHmA2Mxhs9pp6acZKcK?=
 =?us-ascii?Q?Jj+vuBHB7XWK5Nv9rOS5z71/7GSN8n3pqDJAXpJjSoC4SX5Cr2pElyH7Q+MD?=
 =?us-ascii?Q?12luaqx1OIxVL7od0962n0/afRZNzeFdPPo56GH4+3ymLy9C5xVzGGroKMwH?=
 =?us-ascii?Q?dLt2TRWN/VMu2GOt1guK/eD5bZ3NaQVWJREv0cuahbYDtv8qWMamBKJsNTe6?=
 =?us-ascii?Q?2P3KoVHoDAyWAjVPlBJ6Ys2cIPT+1bpQXGVwyxywbJ8dLfKKEgdX/AqU+gIf?=
 =?us-ascii?Q?UJentjJ6tf4bA87jmo54J1pdJjT2tkeL7sNjPs54V/AAx/MVs2iACml1oVay?=
 =?us-ascii?Q?Pf8LZIb9VSKp8zCwuzqLAK0z1NpZWqCmxTcV3w5Euh9LdTG8iMeSJ06NmYcN?=
 =?us-ascii?Q?ZorMQ97b5ihNl92Fu8yDd4IeUxE3waywL0BL6KdZwf1E0/8C+miWXFcSYWKJ?=
 =?us-ascii?Q?hH5B4j8iOkkE2Uj3ocV2haCMQLEDbjFssm1iOY12Lx8w5/5kcVqpaNJdbfF7?=
 =?us-ascii?Q?qi4YEYK52dQROeyhaOgBBYRBRyxJQm4DtcDFuVb1frSJ1zD/4nfy9yLJ7+UR?=
 =?us-ascii?Q?yYc12WqRhn33QKub1fh0OhIQV4Kq2rcnPds6GMBuhBnERIylYPR5URcB9tiR?=
 =?us-ascii?Q?5SZQ5bC4IPP7GPNV0sifP+yUKFZrVt5h2C7n9+lXgx4UQIzZhdCnpgrE4YmJ?=
 =?us-ascii?Q?07E6kYllA3FCWOnFdT/AqiZ7XjJV1ExHVAx15C4SfQoVXrot6kSr1eQMwepZ?=
 =?us-ascii?Q?6cR0qWPFHCKKp8DtoABm268mivrUgeoL+RG7s/NwTjZczS+BdhSjPV8RQSBX?=
 =?us-ascii?Q?gY/VMtHvSXXp67rsfa3y/9kbLVzGN9kKEO9gh5SPnDP7K2imrKWjIw9wyOT2?=
 =?us-ascii?Q?RMfdryjSM4sZ2JxNl6nYHLo1RAI3xEgrQbWLU2jUaowcyvUqF/9bXfM+OBpG?=
 =?us-ascii?Q?BIi9h+nha7U2dTgKNp4Jy/X2ocaFORLPeCWZmbQYmo0TuxF2MgD6IBqTE+cn?=
 =?us-ascii?Q?hNo0sj/2+BO+im5hBfF61PkpnGi4AAy5w7AZy45Yp0BJDMuMs5DNb0OayQqc?=
 =?us-ascii?Q?mF+NuWGUoaFeLQtDdxjuPf+TYAc2ajGQsnvXvKq8CbIA2md/ob6p/Vmb2hqp?=
 =?us-ascii?Q?+GlU9LNnpnPmxA05kZ/DR84Vk0Lzm9MfaqIQXUNLjVKANNN6rF17fFZB3MyE?=
 =?us-ascii?Q?Tc/OzrrI3PUDs9ZYSnODM9Bg/1xDncW0mwrjO1Fz4vAz6anBAMSOQTLlota7?=
 =?us-ascii?Q?T0iXNsbAlHb4+51rjSOeBYTy9WgpPQZmEHJmDWIP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb22e25-7f36-4484-021a-08dc8aa43e53
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 05:55:20.4423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8pCLLynrjfHiclE1R52j1kizbxnhL4JNw+e9DyEVkXcBj2gXs2Jk0hEB0ZR+kq25cprnqEQc5cZgyQakRQAkwil+eX3HHzqXZS/nO3QWsp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7462
X-OriginatorOrg: intel.com

Hi Oscar,

>=20
> On Tue, Jun 11, 2024 at 07:52:06PM +0200, Oscar Salvador wrote:
> > On Tue, Jun 11, 2024 at 07:46:33PM +0200, Oscar Salvador wrote:
> > > On Tue, Jun 11, 2024 at 10:30:05AM -0700, Andrew Morton wrote:
> > > > On Tue, 11 Jun 2024 03:34:25 -0700 syzbot
> <syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com> wrote:
> > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > >
> > > > Thanks.
> > > >
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  alloc_hugetlb_folio_nodemask+0xae/0x3f0 mm/hugetlb.c:2603
> > > > >  memfd_alloc_folio+0x15e/0x390 mm/memfd.c:75
> > > > >  memfd_pin_folios+0x1066/0x1720 mm/gup.c:3864
> > > > >  udmabuf_create+0x658/0x11c0 drivers/dma-buf/udmabuf.c:353
> > > > >  udmabuf_ioctl_create drivers/dma-buf/udmabuf.c:420 [inline]
> > > > >  udmabuf_ioctl+0x304/0x4f0 drivers/dma-buf/udmabuf.c:451
> > > > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > > > >  __do_sys_ioctl fs/ioctl.c:907 [inline]
> > > > >  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
> > > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > > >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > >
> > > > I think we can pretty confidently point at the series "mm/gup:
> > > > Introduce memfd_pin_folios() for pinning memfd folios".  I'll drop =
the
> > > > v14 series.
> > >
> > > jfyi: I am trying to reproduce this locally.
> >
> > Actually, should not memfd_alloc_folio() pass htlb_alloc_mask() instead
> > of GFP_USER to alloc_hugetlb_folio_nodemask? Or at least do
> > GFP_HIGHUSER.
>=20
> Ok, I spot the issue.
> memfd_alloc_folio() was calling alloc_hugetlb_folio_nodemask with
> preferred_nid being NUMA_NO_NODE, but that is bad as
> dequeue_hugetlb_folio_nodemask will do:
>=20
> zonelist =3D node_zonelist(nid, gfp_mask)
>=20
> which will try to get node_zonelists from nid, but since nid is -1, heh.
>=20
> The below patch fixes the issue for me, but I think that the right place
> to fix this up would be alloc_hugetlb_folio_nodemask(), so we can place
> the numa_node_id() if preferred_nid =3D NUMA_NO_NODE in there as a safety
> net.
> This way we catch this before exploding in case the user was not careful
> enough.
>=20
> I will cook up a patch shortly.
Thank you for fixing this issue!

>=20
> Another thing is why memfd_alloc_folio uses GFP_USER instead of
> GFP_HIGHUSER, but that maybe because I see that memfd_pin_folios() is
> used by some DMA driver which might not have access to HIGH_MEMORY.
Right, memfd_pin_folios() is used by udmabuf driver for DMA but the reason
why GFP_USER is chosen is because I was following this code in gup.c:
                struct migration_target_control mtc =3D {
                        .nid =3D NUMA_NO_NODE,
                        .gfp_mask =3D GFP_USER | __GFP_NOWARN,
                        .reason =3D MR_LONGTERM_PIN,
                };

                if (migrate_pages(movable_folio_list, alloc_migration_targe=
t,
                                  NULL, (unsigned long)&mtc, MIGRATE_SYNC,
                                  MR_LONGTERM_PIN, NULL)) {

where, alloc_migration_target() does the following to allocate a hugetlb fo=
lio:
        if (folio_test_hugetlb(src)) {
                struct hstate *h =3D folio_hstate(src);

                gfp_mask =3D htlb_modify_alloc_mask(h, gfp_mask);
                return alloc_hugetlb_folio_nodemask(h, nid,
                                                mtc->nmask, gfp_mask,
                                                htlb_allow_alloc_fallback(m=
tc->reason));

but I somehow missed the early check in alloc_migration_target() where it d=
oes:
        if (nid =3D=3D NUMA_NO_NODE)
                nid =3D folio_nid(src);

Thanks,
Vivek

>=20
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 8035c6325e3c..2692f0298adc 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -68,12 +68,13 @@ static void memfd_tag_pins(struct xa_state *xas)
>  struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
>  {
>  #ifdef CONFIG_HUGETLB_PAGE
> +	int nid =3D numa_node_id();
>  	struct folio *folio;
>  	int err;
>=20
>  	if (is_file_hugepages(memfd)) {
>  		folio =3D alloc_hugetlb_folio_nodemask(hstate_file(memfd),
> -						     NUMA_NO_NODE,
> +						     nid,
>  						     NULL,
>  						     GFP_USER,
>  						     false);
>=20
> >
> >
> > --
> > Oscar Salvador
> > SUSE Labs
> >
>=20
> --
> Oscar Salvador
> SUSE Labs

