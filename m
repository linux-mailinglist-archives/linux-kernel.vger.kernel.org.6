Return-Path: <linux-kernel+bounces-229363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31200916EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40502812C1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0998176AA9;
	Tue, 25 Jun 2024 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OaBPfN2X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D732816FF59
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335292; cv=fail; b=WwUcjuwKeF5+qDgSBK7wXBy6x6GgFqpWvJqhsDLRFH+Ckhle73eczTVtYdzOKO9GHlPAS1NNQHaEHPoAsO32y/eKkoIr4Ktem+RNjz2zGEPeHc480qDhm7akLqOpga+OBvCRQshiySR0FbWhTRkUY/dCvA1EVs/UtQNwqWNoWt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335292; c=relaxed/simple;
	bh=Ak0/4exJZAr9HaoOaQJFjmPEcvxCFmEIj2G23RzvM7Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nGJ1QzB3rz2ExO69fe2L4CDjFQ4rADtcmXL3Dd9G1/uhXuvf9b7TKAr1T71NMumK+N5ufbaor10korGaF6b8HC16mLpzjoE1HKXHTaUo4zqbO/eCPa1HQdMOTFl596aaJzBBzs+evKp4pYGZCz1dbfX5M6rV1WLV/45sIphSNwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OaBPfN2X; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719335291; x=1750871291;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ak0/4exJZAr9HaoOaQJFjmPEcvxCFmEIj2G23RzvM7Q=;
  b=OaBPfN2X+XEo8Ssbca7LroybRHkUtpvdqElxebRv5Y1DhAnup+pMfNaB
   IkK6LRELOn/R7OEGK+Z3YjI+jXkB2886Hjdoesr9XQKvJ8wekq6KTeA11
   ahpNphzqEPXGdqwNv4GzhRheQexhx2+dwFncalFpHXRGtB8fvDHTT6rXK
   wgrIzM6pk6dJu4vDfrGeg/S2tpfmCBI/07pkdWGK9Cfh4UZRfdjIHRXVW
   gv89QpwdVYB8GWBbbckiO02rQD1RlbLK7y+w+KegQJTiXkr5W1J85Khkk
   KQDqkFtCHLOGf+fQnI4aAlFvDduEwYPsJVRNWnuqiPJ6JuGonSVy1BlxU
   A==;
X-CSE-ConnectionGUID: YVn7oQxjRK2meAjNWukqTA==
X-CSE-MsgGUID: a03rd07pSuO6MpcK3iPSog==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="20180473"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="20180473"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 10:08:09 -0700
X-CSE-ConnectionGUID: crnfiIJpSHS8SkII4a6Jjw==
X-CSE-MsgGUID: aHznCw+LTeaovjaXScaRMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48106537"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 10:08:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 10:08:08 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 10:08:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 10:08:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 10:08:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFDQOWA0wyOghiKzMVy8I2c7e5y/qWkwDauFQbMBBn6RI8/fj/A3pVMzP5h0jrQEd8nQJ5NF/aIxCffamddup/F2WFU0H53Jv/jOfKhebYXgnCYnQHlIudyeBkk6ZnHT0d2LrtXfzl43L1PgGkY9CPyHodAaRsyab5ACuVtHK6kexKXCboqLAuWICXnDvWYs9DE27XO/OgWnv5ENpljWdAoLmN9TWUFbyFBVikhfAGdKVLAhYGQ/frdViCbV1TXrsl0xp1ITJvYYZXHTq3gPDGFSULIAR2FBq9b19E4WCiIwXFgBuh3/AipbVIiXn/7lwjr1Dpr2JfS+/00ot2S64Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wi3dO/RbKQzaXZJB23JjvP1fcsi5q9HNyftDcdr3yFE=;
 b=cMccM4mud3KZFhCFN5ggfGEUdKGTBme8q4SuNQsQoUj1TRRHNW/7//eGo3+j+TeT0DIioewrdCN/4NRaJrcDiwo8SXsXsXUcU86PW8rZ6OKhN7DZkQpuChRuKVwgnZjX8IM8EnqfOEYi6465/L8Rtwwp2ZiTKp4C3/N1xODbR+gDFIpX9BRVJmG2HZH7Dz5Hs7SLR7xqrcFyRGVjBYeloUwTp6K4wk7hNEE5zY1YoeG1kgKrzAYS7js86RBZndfMny9pwg9/7uSVztQIBeSUg8rWUL/qYkkimG+JQpLEClZ7xT0jvm7WCPfFiQ80IL0tDGAwjPafY98467rb1oaHdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by MW3PR11MB4762.namprd11.prod.outlook.com (2603:10b6:303:5d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 17:08:04 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::fcf6:46d6:f050:8a8c%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 17:08:04 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Xin Li <xin@zytor.com>, Hou Wenlong
	<houwenlong.hwl@antgroup.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Lai Jiangshan <jiangshan.ljs@antgroup.com>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Paolo Bonzini
	<pbonzini@redhat.com>
Subject: RE: [PATCH 1/2] x86/fred: Always install system interrupt handler
 into IDT
Thread-Topic: [PATCH 1/2] x86/fred: Always install system interrupt handler
 into IDT
Thread-Index: AQHaw9ywKKsEcOAR1EeeZBfhkJX/R7HYOcsAgAA1lwCAAELugIAACIyAgAAA4sA=
Date: Tue, 25 Jun 2024 17:08:03 +0000
Message-ID: <SA1PR11MB6734FA6BBDD1BCD3086A51FCA8D52@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <cover.1718972598.git.houwenlong.hwl@antgroup.com>
 <2f632ef59c8c9cc27c3702bc2d286496ed298d65.1718972598.git.houwenlong.hwl@antgroup.com>
 <dca1635b-1e08-4dbb-9dbb-335cbdcf9b9d@zytor.com> <87jzid5hmb.ffs@tglx>
 <49c53a1a-55b2-441e-8ec2-1a2d87a3ccc4@zytor.com> <871q4l5542.ffs@tglx>
In-Reply-To: <871q4l5542.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|MW3PR11MB4762:EE_
x-ms-office365-filtering-correlation-id: e14dca05-cd82-443a-8e3c-08dc9539603d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|1800799022|366014|7416012|376012|38070700016;
x-microsoft-antispam-message-info: =?us-ascii?Q?pWa15Q1hFFAxPq1jMybxprIN0jOq5R7Oa/HZVWRc5SP9P9XPDiFB7bBOlwGh?=
 =?us-ascii?Q?V3GtnbJMYA9+R8lA7lVdjKbLVs9AqIA895QNe2kew5qF9vpVPDzgKH7xr9Ms?=
 =?us-ascii?Q?s7ebpY2EFEdjz4iGHT0MiQ5s1neAaz8qnTqo3ZiMwcrpZRpCGGa4vWFVQLGy?=
 =?us-ascii?Q?dwDGBIrnh7EzfPKgdbzqGz7HOs8mbuMnGGW3Ru0e3h90RJwzyjql4TKKrjvq?=
 =?us-ascii?Q?1s9bzydP+F7f3FNzuYqaKs/zNdcf66pBQe1W63TZvIbEiAZsYsfmsIvBi4mP?=
 =?us-ascii?Q?vURBR7fLSZWRKzoVnvo/u2mAgEie1w4o4f0myWZyM1Eki5Iw7w9zKIMn4BIE?=
 =?us-ascii?Q?9HsOPUcAWhZWXQezt/HyGgutu3JzcwSztqJZ3XbPf0tmx6dCIAyo4/nYPGwb?=
 =?us-ascii?Q?gXmC7OBVY+a27W9R0Vy7fwxQcHPKyeJy04S3SGx9pJ/2QdU1D/h5zcQ0IA8u?=
 =?us-ascii?Q?TmddD7t1s5MXTAymZObCiXNsBYqB00RERrdSzNe+6/nKEEgwKh7P39DriNS4?=
 =?us-ascii?Q?AZhn5BV0D6I3SDda/GVkQL7ZLgTv4RiPutRX7M0AmPZPnBcP+scy+8kTo0QK?=
 =?us-ascii?Q?+gxdFDnZ0/SOCwx06F1n3DFTMAfKtNP+wqXtBtgckZKCtOHhyg50p4FxyUr9?=
 =?us-ascii?Q?YgtqBGJylyY630TDmKstxdY26ovDxTpH3Bputl0j1cuaGvYbzHdI3kkahZEj?=
 =?us-ascii?Q?RPyl2SLgVYphc66Mmpxq5YS2xzxpGTtcXex3E2pZgOriz4QqLI6UnZNQxWEJ?=
 =?us-ascii?Q?RLgSxcMh/ByPL+laQAP4x8RV50TZboOe95/CNQxMEQB0qD2dvF/csHoKiy86?=
 =?us-ascii?Q?m31oFc5QAUIL4dQQlvQ82dyshder1URZ7yieaz5WMxSkqkfL133Yt9FUhjgE?=
 =?us-ascii?Q?biH+v1gI0cf+W2bp29VBr2W01o6FsETPNlBut2i8MIdglKB1AC7RoaR6eWP2?=
 =?us-ascii?Q?Ldm7VRmM5Fg6XJqR8pxzjBvmsSVDxTwUd3fhyPV5BkBb4sHzvqw9sOyuj7uE?=
 =?us-ascii?Q?CxX+QIjroHzirS3NEdB/W0zWFf3zrRuz75pitplIwis+7CK8+govdFtV6BUQ?=
 =?us-ascii?Q?33sOJzOOKiJ6uiDqTJwSfREF4R0gyCTC9moFWS0XuSpOyRsBU7eVGjP2D7Yc?=
 =?us-ascii?Q?+NkmF1mrGCaK7T4eDre6loabEUWd6qeRXJJqDDlUX2hkhuN86ZmoiDHe+9aZ?=
 =?us-ascii?Q?85QivZ+HpXNRvv1W77/6By3gdbbSfJ34vKdVXZCFwTSARO9JVQ5ylY1UIhES?=
 =?us-ascii?Q?VrBiht8cDqr/bnD0YmnplFbTdJHUvmMEAeh8nGFfdbhy6adqA0vLsv7Y1Gji?=
 =?us-ascii?Q?EoWWLDZgf5xoHXC0Xiw+GePO03x2Iee0SgP+ROHBTilED98StS1GWTz7+Efr?=
 =?us-ascii?Q?bVrrGQa4N1jIOk/nLK1EZtk4h9+DwpRCqsfF35SiVEHV4O88Lg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+WpuZKH2/r1gqpkWDQwvi+LHj/roT/l7UY3iuAX9vL4ZdmEg6JPRibP3kCOZ?=
 =?us-ascii?Q?i5gSBPqv2zFmU7BzbCvz1VW0kCULCTgISIbq302N3TVR30Oy5Kix2KbWpwK+?=
 =?us-ascii?Q?dWzAg2PIf2YC9Lu20bScnegiYv3fnEZXQYmmmZ/BzxU8aCr1wq8wOlXCrHzd?=
 =?us-ascii?Q?ZC20FdFdQM2QvMuvvt91H85PryJ6KjAMCTLTnxOZ+1c6nzKdDnwWyjrKtz41?=
 =?us-ascii?Q?oq1gazvvCx917P3Ym8QinjkHNpgFjXS1LrKw+qQPmtJhwMSjoJZa1zk+QpCk?=
 =?us-ascii?Q?1igIvcKsQNt5DkyvnEQo25kigfdhZxKajmBZ48bZINaKoJ8kf9mftxQIAOje?=
 =?us-ascii?Q?jUro85QFIg95SArrrVWl7c7piT6HGiRS/gUsU8ajnLq/Th6MOZEwlJSjlYek?=
 =?us-ascii?Q?VJgwtbkyfrPrYcObAtzAIItO4tdjgRmOaDU5y3tVFL6yLSR8Sw2uLRF9egCA?=
 =?us-ascii?Q?CGTE4e8urdDgEMZK6UTGrjNT39iDA03eAbtsmm2ak+H/tpgPjqIMEXnHLYT5?=
 =?us-ascii?Q?v1GsbPVs9cBoEw7BALELKIq71j0zK34UZ4w6F8HRs/LabS7NtFtvg8L0TOOo?=
 =?us-ascii?Q?3ML5L4j2h+OZBU6PAJMvn9vtkKRe7aLlG1aOL1LBmbV/I1v/hYkFr5RV6gwi?=
 =?us-ascii?Q?gTn5SyXnmwevEIELW0I8kH+IMPYyBAx/KINj+YEH34BtWb2ZgAfSv9yTw9f3?=
 =?us-ascii?Q?g/tCJAEsFrwCB9L5OisoAqz/xfYI4OBrzPVuRRuYSbM65/JhB5+eLF3BR9Zm?=
 =?us-ascii?Q?r6ZGLAsxvksi7ZDLvu/0C/+Ql235T9UMmyJv3/KgEvhwQjq57FlhvoPGR3M/?=
 =?us-ascii?Q?YyDg+t9pgC/7aGhkZWoNWfc4ERIg0FEISlGgb0m62pTUPT7G5whi5LLV6hYy?=
 =?us-ascii?Q?B+okjn72dFyA01ZOm3MP+Fp43k/7n7tLS+Lek21k7AYKO4S0enoU+8yOtm/W?=
 =?us-ascii?Q?QkY1N7X0q3EsjAsy8/Zw1KSxgFTe2YIR7V/mpkTQQ0XEmLRnNX2pSSvVwgrK?=
 =?us-ascii?Q?A+IBpOLuxTtgGnlcAqTH2o9rXjPucoNlgYS1p7c9R/Qemnige9cGbUf8cP38?=
 =?us-ascii?Q?i99f1Y7ECcF3z5ZrYQBNcbwVglXFT1mKTpRO4PjWftyRQfwsvCfs59/HJAkW?=
 =?us-ascii?Q?xKR2D8n4j2cobE8njGjbOpX48A28GLmUHWq7lJ9wa+AVXri+vDa18yfdidKI?=
 =?us-ascii?Q?ydr3zIa306Q5W4Nkyx15/qXatF5jGraI68krhC9hFNw6FK9VQIfQULKtYKUW?=
 =?us-ascii?Q?hQK6Tejg+s5XWnvB4DbSYiplGKMQxbsTpYUkTxUBR6NpMQDpL1QhTpAirISB?=
 =?us-ascii?Q?Q0egr35nPvz1UT2zlVYWZujsn0uU0kNuuAvIkZuoNEpNHDi/RasqLgF5xE9n?=
 =?us-ascii?Q?fMTKhi2/G0ANLt4apEPd+tMdmOjwacYuPN/jyf6Tel89nA6FSsyT4jtdTZ2s?=
 =?us-ascii?Q?fa057PbfYoVfS7qpu5ii4BivDmBhGqXi3d34XFhmXuk18VJz1QVM3Xhwo4XM?=
 =?us-ascii?Q?L/aDewRcYHGj8s/KUH1iQWZo7Q0aTgFLyM2tIA3A7mOvwHUm2lDDfXbdwL0q?=
 =?us-ascii?Q?4FYzPWG8IWAGzzKUpiA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14dca05-cd82-443a-8e3c-08dc9539603d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 17:08:03.9735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QiZqM9vFFdJm7StTK8I+bUeRWPDjzwaSb2hr2GZSkhfSzigkXPWW451J0Evqeu87f4XUV97Aofj0g0NGx+MmPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4762
X-OriginatorOrg: intel.com

> >>> And please put a comment here to explain why this is unconditionally
> >>> done for IDT.
> >>
> >> Wait. If we need this during early boot, then why don't we enable
> >> FRED earlier?
> >
> > Unconditionally call idt_install_sysvec() is still needed, right?
>=20
> Not when we enable FRED early enough.
>=20

What if FRED is disabled in the kernel command line?

"fred=3Doff" gets parsed in a later stage of the kernel initialization sequ=
ence.

Thanks!
    Xin

