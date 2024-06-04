Return-Path: <linux-kernel+bounces-200069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A6A8FAA20
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E32286556
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB0913D602;
	Tue,  4 Jun 2024 05:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BEsOjRGR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7443837C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 05:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717479963; cv=fail; b=RUMJPoGqLFDD+8+uk//k4JLYJX4JrjwUcyoNnQlHUrDVEW3P+Q/qjAxlfg8CDiLaLWr21I2Ayh6CRDcqw4tR6RW4kzMq0HwGb/3eS2oGB7bVy/7WBWqDjrel7vhkNiKfGovdnwLxs7LKdAKzgOh05eOBRFHEDQjHBPuqFpzSssI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717479963; c=relaxed/simple;
	bh=KH3tN8Ah+aZhpxtgNtpQUQiwNHvHs/w6TEUDM7YSRm0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GObwudCK+VFShvLiLIbVNlD3s65gKzL5dIrIl5wCem9B4+1S5qiEok9pbqC/EbDnTlMiAsp9n+pWLYpcsrQgn2cbC/8BL7HCrUZYtox46+adHm8OgnZniqZG/Je8VMj7s4XQJ1yWiOyjfclChmBktAfqlNBHRHMOuj0p4VkoZVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BEsOjRGR; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717479960; x=1749015960;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KH3tN8Ah+aZhpxtgNtpQUQiwNHvHs/w6TEUDM7YSRm0=;
  b=BEsOjRGR16YtGKwRYhcMAddsq4EaO23PYLtGV4pscZTJI/A/3VA3mpQX
   E6wjAZmlyuoQbZaL469IKZ7LSjqDOvM3iLYllCNEhRoJd6b+6pZuyMnCa
   OqAm+3h2bBMX06RVcBc/OXOLgXcO2xZbLnoRaN4qA8oAPUUvlEkauJhSJ
   rhTCau31PBzu04w08JZIly8cnHJk7WL2iK4RjUjvcEotAMWPzPOVwn48S
   VDcqJPlXobkOCC3ilRlDiGOZiEEFb172Cwd8QuwI1BxljWnh2tQ93hMzL
   f9Wc3vcAFnU0ik9oWO0ixpZziijwwMakak3uuuMJfP4wm9BKzXQBlDIcY
   A==;
X-CSE-ConnectionGUID: T+jgpOzySx6Nj50tmWw4ag==
X-CSE-MsgGUID: Xena1efLQIW9pjKO9kN4lg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24578177"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="24578177"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 22:45:59 -0700
X-CSE-ConnectionGUID: KTT2t0SwSCOlPh6CX/ZVMA==
X-CSE-MsgGUID: 06xpnzHgSn2ofe6JB6XUuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="41549928"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 22:46:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 22:45:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 22:45:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 22:45:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 22:45:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAHfdztJyfOfsB4sGXXqgSC1ITB0By+mmnn1W84RWjmkgULs8dpI44wJoppc6QFFkrQw0zmxTv9eft2O4Rgy/710NJSpAD+uR/chZ6fs59jlMf8Xj7IvyaoT2JvL/QWVv3bspW9Pv3mCO5bLZdocSoFG1uh5cMmjmyi/UZCUfQLY2ziHLBtTRRKu+V50/0equx3SRprzveRxe9en46Mi1mHXOjK12NLepBWOAFS3iQLhfp8DTjxUq+LHjxZMqdDWgFpQCM9vNg+k48jb9ohyv8LS6aFD4dJ6RJKt4+a9VO0lpIHYO6Zz980idlb4mrail+YrJas69FbEKF8lEuIaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4c3qNEj/9D/BOUzOOV16wjiAAps8tbknpdMiRICddAM=;
 b=GI+H34d4JpUqjmi2zOdyKYqfQZqkoSjmvYYxL7EqEK1ZRwaFFe3H8EoA4AzdIujx42VS1F9Qp/AnT9DUTz8x+ZqAKKr9pkV0LdmBeUof/MgVmIRTwwc5C6KSmT1O7fP+fJ9EnX12QW5vrlFixGwg+0XrAXhyU2QTgdWDQP6fx/l4OQx2JNtvuDBy+fIvMjKUgZTCWU9uno01nW0I/yhtTSgVItiQxim4KwRFRSgQ+HVOk6eBL3EckL9gaVLdkcC9Ob4qDFfnKmKuqiW/wOv1PSEnQ/rnXlQQuFvqCaCPWorEeb/p+TJyKekP6eR8yWzIiAvutXQOtuQguIHeSZeAyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by SA0PR11MB4656.namprd11.prod.outlook.com (2603:10b6:806:96::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 05:45:56 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50%7]) with mapi id 15.20.7611.030; Tue, 4 Jun 2024
 05:45:56 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>, "Lubart, Vitaly"
	<vitaly.lubart@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next] mei: me: release irq in mei_me_pci_resume error
 path
Thread-Topic: [char-misc-next] mei: me: release irq in mei_me_pci_resume error
 path
Thread-Index: AQHatbobyzfTphZxekum+Xc9D3M8TrG3CJcAgAAQEgA=
Date: Tue, 4 Jun 2024 05:45:56 +0000
Message-ID: <PH7PR11MB760572C6EC68727B2F1B1BF1E5F82@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240603132928.977787-1-tomas.winkler@intel.com>
 <2024060419-stoneware-staff-b840@gregkh>
In-Reply-To: <2024060419-stoneware-staff-b840@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|SA0PR11MB4656:EE_
x-ms-office365-filtering-correlation-id: ce1d5e89-86a3-4173-010e-08dc84599aad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?GmHzzhffWlYfe5OZfJCdXJ8tvWKBZ4ovEMnHfItWmtvV1qVHZeFMlDAfhZur?=
 =?us-ascii?Q?bYkQYxfyQhv4WEml1DjBPlWRrBMpaZ8jJpC9wLU5mbKn4eZEQlulnEtD6yQt?=
 =?us-ascii?Q?6d7NwaTntTNRnC5BqeZw+t2LIHnSpCBaC+R4xI5DnMcOPvu0yyF9k4OM+p9Z?=
 =?us-ascii?Q?1HQyRYt8XMGI8KbxxqTeIlTV/q4P2aDdGwQ7eADIHNmeMFNc2GTc7SHHT9DF?=
 =?us-ascii?Q?KC+EdoIOr/lXEwCM8b8IpxyfitK2tFAevPP4Uj7XOnC9XIOGBrvsjtHFeQbP?=
 =?us-ascii?Q?PUWOxQ2TJhyzd41P5mcRx2MimRV/1cDq6jot5ZTQR2P85QB4DvyTmGBUthlL?=
 =?us-ascii?Q?WYxV4AGPXvzTaYKW2ckjOMXF83dSc2BfGUZeKcAc6LTwqxkAgKfPsgZNzrQN?=
 =?us-ascii?Q?aeTAfOnzzRzLKqUE1pO6690mxtMQcuBOBs8i8q01OhPE0ANoREszkrtwoTCf?=
 =?us-ascii?Q?mpj6sia4qZB/SVQAKFtVxTPPd7D7d2pSl0MIPLzaCRcyubiIZfu0FPOKSdaU?=
 =?us-ascii?Q?E2HxbbUvJrSAnv3Tmkuu3V0rbfcTqEiw0VLpmElSFYh9T2k4JQnsJ927PBH7?=
 =?us-ascii?Q?/PBIkiGFpC+33G+yNEMCjQfuqfFoN3maS8ztgACKf3L9BEkyG+SEtHW7rZ1c?=
 =?us-ascii?Q?76sXE6psho0wrJnQ8hS23iD9Dr/KVHjWv72AkDaz28Pd6jN7UJ9qXKN8bXFO?=
 =?us-ascii?Q?MK2fj4hAx7XRIsvClfsZhPbaiLaAu5CB2mpJM7noebdP6xvMOFDYcK7O9YUI?=
 =?us-ascii?Q?8uiHK8PuLgIsFi+5ZPEhH21rLzYRv3YtqqB2U7YkxBhx25gyigVCzXei4FgC?=
 =?us-ascii?Q?c20djXCmcCP4lA4CPivZmUKllmkhvyUdzRbQsvboG1GoU9BH6wEsqpBh2MTs?=
 =?us-ascii?Q?yr/GQGecw2ma5e6L9iqBDiMYVeiz4ujazWC6uSiQfAcwAuIqx6gZzpZGiD5G?=
 =?us-ascii?Q?c/X4NyirfU674snC3/JbgCBHYLno0EMI0K17Aq2wmmzXZuG+Lm6D7rTtIPpo?=
 =?us-ascii?Q?oa/dvFqp7OvcVAILSylS9Qu/rXbSfqwBDnU7w32uesig3YepWpFouO/rlVcQ?=
 =?us-ascii?Q?jJXGvOhcL0CVlotUl4xqquh52YLb6ueTp4oXbh6lFkguaqOQ2YPxPe74PRTq?=
 =?us-ascii?Q?lL7x3cjX4HPwVe5B/cVQTdSIBNutqHsmQspLJTDo9ZWLQsj/qkzVmejhRbyA?=
 =?us-ascii?Q?pOze+DidaJnBY078BqctEb/goQrMBcqTeWQ6HHEXQksfqgQGdCDqIB2EqRsk?=
 =?us-ascii?Q?lubk2MZvkTnS7FKp4/40opwImbvI5o4YHhHhUzGCf8qjP6mTaLFsOdj3O+ow?=
 =?us-ascii?Q?q36LuS82PpZLh9OdcPYEN8vBz7/3TKmFI0YVueeD5Fu9+g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WHNCeyXlGzUhfeDjpC6EcIr146CXGukZI1ZoPm7etTWbqyDQU7qiEJE7V9p/?=
 =?us-ascii?Q?PBsTlOsiFxT89iFEVWG20SL4J3vtbTUNb0AyAY8KTh6TRVOz2GgsZoiFEE97?=
 =?us-ascii?Q?4qffCE+8GV1WZBGVjdtUXdGAvMeaQK075KPgHDdlFgcgQVbXpt2hDm9K5ZXk?=
 =?us-ascii?Q?qNsBTpjQC5okxU8FQYTUjUC31TUzrFMdN62u0uVBIDil+ExRRe2NtUrxHe6l?=
 =?us-ascii?Q?4+aKEWWRQEXCw2AYtMBezseZHON/t76fxg3QmpAEJjujqv4hZc/HsRhBqcrg?=
 =?us-ascii?Q?u/gd1oGrvI5CQ8PKkOij/BdIs0S8xg0BM+qIgdieZGe04JMKHbmkK7WimQE7?=
 =?us-ascii?Q?xD6TZDcQdEPE+m24tnjhb3EPC+Nz2i++xi1YcpMimisPwZ7QRq++k+soVtpJ?=
 =?us-ascii?Q?MPsVBz9pK+rsWkq+Gd0WTKh6RXNojHDRMlffxq3gS0tHLKPzkFX7lTKjffj2?=
 =?us-ascii?Q?hN0h9AGllpt/GETaOjb7n58xdF3LTe2fm/VaI8QpSfUP8vjW+Smj2yt2XCSR?=
 =?us-ascii?Q?eItKfWuK+oTacuJZwe/NkKDRc3Yja6nmaDD2RKXUdiTQ6fXgwa5UoT/8A4LQ?=
 =?us-ascii?Q?vLxX0GvSRRG20qcX4zr3I4NkQv07maQyoIEFV3Gk3eBQ1hMe03wCBLaplIFX?=
 =?us-ascii?Q?WoLglqkuaGsmE8ZTcqBa1JuPFbZiTq2tr4xtqAzUIKnHxVHb+iwz7cngG4Mu?=
 =?us-ascii?Q?go2ZQP9/IRDvYCJl7ZkR3ZsWT8gDGhQXE2VfIrZ2/SwKCxwW0zrc+d/pizOR?=
 =?us-ascii?Q?jnl48qYzvq2qbGTuEsQGSePPa1r3+i+aiRDVO53/vZVL1wRODKbjMZZkdc3X?=
 =?us-ascii?Q?Bj6QJVHQtBEtu2uU5U6jzQVwigYSYRhHNIGR+7W8N8UXaLKWNwcZvbEzt3iZ?=
 =?us-ascii?Q?dvVB6toyvr7X1xMxGj8WI0eqLHr4gSsh6W7WaAqFOY7vGcHF5kdxhoiNi21x?=
 =?us-ascii?Q?7Qs+vi8QiR12duiJB7eioFC9rwGro4gJQKcKCx9QaMnk1lqGfYjWICnh9zaH?=
 =?us-ascii?Q?DHT9hRKxh66/lKkPc3ZCeX/hbhkst2h6w8iC6FRPK+Blnp/+M7olX03W/qWt?=
 =?us-ascii?Q?xZthqVCMcOVUdTvONitMIqV6nbB527Xu6mLuahK2L5mEHC8HTiBRtDfhsMwR?=
 =?us-ascii?Q?uLKLejOSqadRzE4gsG8SVWoYD3PpGq/33mGuN2RivzmPlGdgUtsG7sRNHrkF?=
 =?us-ascii?Q?0VoWavNvlsD92GmPXAUySqViwvO1aCpEo7GhW6fjbN1nItTHfTgLaWwAs0B/?=
 =?us-ascii?Q?hh3d5VBAJcZbL21jJhCQg233aEvAyI2Ib/JyeLsqu+K61CxrQI1XjoSr5HZz?=
 =?us-ascii?Q?Dv1jhIIqJKR5wsxOGTj8ertWCBoKpI6kYGmdanVyFWPcO6Sri0mlk1b7mSqJ?=
 =?us-ascii?Q?4SyehgSqjpAcFH8X0GbkHsC+lsCrIZStq1WadJ2uYchEeKN5tPCNGdBywQps?=
 =?us-ascii?Q?i0h+xC0gMy+L6sLp34N7cCOT4egffU34uESAGBPLTC8ZkJU9RwCLzlAYB8/+?=
 =?us-ascii?Q?2Z2Z671x9ZYajbEKn3MmVZ21sVZDLLrjrwubYeLSYayovSRkQwVzfNfWl4yl?=
 =?us-ascii?Q?ORUnIn0Nw036Aa7TGsu1wzecgttOvtY37g6qjKe6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1d5e89-86a3-4173-010e-08dc84599aad
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 05:45:56.1712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFukpYsnK2Z1E1uMtTAjHMumjdhODCJ+y/5tWyr7EkHWX83ThaTHUmNZ4E89owWGp6NvYB6jSHnUkzwLZezj5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4656
X-OriginatorOrg: intel.com

>=20
> On Mon, Jun 03, 2024 at 04:29:28PM +0300, Tomas Winkler wrote:
> > The mei_me_pci_resume doesn't release irq on the error path, in case
> > mei_start() fails.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > ---
> >  drivers/misc/mei/pci-me.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> What commit does this fix?

I would say 33ec0826314734fc4f3c9bf37 , kernel version 3.13, it's very old.=
 I can respin with the comment, if you wish.

Thanks
Tomas


