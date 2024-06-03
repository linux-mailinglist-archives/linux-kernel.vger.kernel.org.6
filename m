Return-Path: <linux-kernel+bounces-198976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB3F8D7FFB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2BD28623D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B172C82D6D;
	Mon,  3 Jun 2024 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NnCqOyCb"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2679881AC7;
	Mon,  3 Jun 2024 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410596; cv=fail; b=Ov+xZC047indFhCQKKAL1SSvUPGaO8smtVPYrE52noa4QgsSJg+lVGroD3WW1i/gECIq9SpFxnYzWQhSpUY6Af+e+5ohaterFSHl9eUrPJRFxD6hNvctogN1lLzpeybKTwLSSL8WnKsPHc0LuJmVc2TcqGcWeYkM1Tej0COSguA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410596; c=relaxed/simple;
	bh=jotlZ6i/lPWnXpPca+pHZCAgmIsgWQTLtVaGPIV5MWc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ej6sRoFMlI9AAl4VX8axdAp4l1mt+u831ZYooUS8xaohwFVIttIZSCBtyXkkXt0KJ1AJ3VPEvlVej1IO3OIiu0DMSlwxB8NDyhIScnMzInkcjmvrnb2aa3YCbI/aSQZ5F3Bnmtc51wTc/8rrrvg1W45EzgE4g85QKpwjf3zOKv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NnCqOyCb; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DX5ErCPXESM6oPVtGcwG+Omk7bprc8NwZrIZtmkE73rRq3g7NMmMwSfqLGSU0mkuQB/Dit9salnIl1bSDbBuMYx8iO8IVDQMu7UbPCfA2NTMOUgWirlOEiLUxz0q3XC6vxjTdUrPMhFFaPasPQquWc4HhPRAZEvJFhFiPf2kNS4WusEJJ7KiV/fQSHC6tTHs4lOQUJqF7Hes7M2Q/xIe05Dkfte47XS4mCb4PcM3pnZG9RmyzdPLtQ6yjGmpQqv3QKQCxwU3Ow5drR0kXjDx165MBDIBXC8SQoSXvGnCXf6q5n9D/Yb/D6kDz0cOyY+MLLUgnt/3/HUzogcLCkWBkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jotlZ6i/lPWnXpPca+pHZCAgmIsgWQTLtVaGPIV5MWc=;
 b=U4hrzXkTkulYIvr+1e5D+PW1mVcAzIYDq4stzat4gQQGs/oCfoXA5H5B8iH7u+nphfC9+W6AJLD50hR+hW1V0D+LXYX+hFA2hLPLLnHf0S+WkMpN8g2XNSMlX18DG9YrPsyLs+t6CjaiwJa/ymFJSTpL0IMx4/Z/qMvQq39sdYAx9WRxJFt+SZ5FyE+KwINaUoWtGgyTZ3oNBtd4dsgmJF4EyjczgplN1aszCMHHWHKi9p4adzx+Q/5OEODtS4lixtYEaMWsrPPqhQCRDYBAEhhZQgM/rPgYkgQpdhL7Tytt8JmH2cqN5vDZtT0iglBF5pr9ONqmO19P22aBCmrBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jotlZ6i/lPWnXpPca+pHZCAgmIsgWQTLtVaGPIV5MWc=;
 b=NnCqOyCbsyezfoozUoGT3433k4j5QegKjIR3aEuoaweIsDEpxnpY5aQ1kuX0bD1lOGnqUxMwZVBpBkWpLEBPIQaA8q9WjagIv4hp6YRrm3WkmdpY0d9C8nZv3zsAsJQEwqOzV1oei66Q8YkmqqEAph6iLlU7U9lgDHWiPpNr8OkJGl81rs7OfgQIxiNVRAxEojgujLX8CgJSWGwdAgKZ7DRhfUoXmiNvfCRcdcniBoDoGAqHljMVgge+WWfBjDFVtO9T4cB3slHP0ok+U7lVIyTeS9kVfHO7W0H+Vkyn29BuYXu2PjGItoydgPopXjXkexCXU7zKRmgjsLNplMO4Hw==
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 10:29:50 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 10:29:50 +0000
From: Shravan Ramani <shravankr@nvidia.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>,
	David Thompson <davthompson@nvidia.com>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] platform/mellanox: mlxbf-pmc: Add support for
 64-bit counters and cycle count
Thread-Topic: [PATCH v2 2/4] platform/mellanox: mlxbf-pmc: Add support for
 64-bit counters and cycle count
Thread-Index: AQHaqqzUCe6HwhimrEuniPTiRFYZCLGq/5cAgArnmkg=
Date: Mon, 3 Jun 2024 10:29:50 +0000
Message-ID:
 <DM4PR12MB513695D2BE98AA46A95B4C60C0FF2@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <cover.1716205838.git.shravankr@nvidia.com>
 <ce077a0db5d4afdbcc63a635fece9793aaae055f.1716205838.git.shravankr@nvidia.com>
 <70d3c0af-8bf6-2e33-074d-5b1719a5674f@linux.intel.com>
In-Reply-To: <70d3c0af-8bf6-2e33-074d-5b1719a5674f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5136:EE_|BY5PR12MB4065:EE_
x-ms-office365-filtering-correlation-id: 73061f76-5ab6-4fd4-5940-08dc83b8194a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?yTvjo6WvvDYXD4xQsej8ejqwBP+a3baO4UoE7zK2nsEROWJxWTvpgBcedu?=
 =?iso-8859-1?Q?DEwkW2m40yxnTP/MRVnqb+SbVsOFQuP2oCNTV5itiWa1bbbs4QYpWhnVXc?=
 =?iso-8859-1?Q?TPskIU2Adwf2SIif0O9xP7bDmU8y7b0HEU10WCN/tONbZwtpWjGsDnuwEg?=
 =?iso-8859-1?Q?+2zsa7e8idQTqw4VuT2+/Jd0BgxMXNlyruNbpEZKvWFcxqUPq3uxby3EZj?=
 =?iso-8859-1?Q?P74WfxaTk5kYWGFcRwsVlMvjm92Vzp2rTL4xIz4g6X0txdjE/h9uGTDU4e?=
 =?iso-8859-1?Q?w20DuRQWE8rRTWTW0VIZRAOUv6KPYl57V+YzDrs0CmxEVpe5aCLuvLhSXc?=
 =?iso-8859-1?Q?uQSlS8cvXmoNf1g3ohz1gMq1Jz/Tg/fxRJjFV9M6dX3x0T63UAf/4tif0n?=
 =?iso-8859-1?Q?bSF5cczEMJnW8E/zAFOndRhdBR/L/Hxxaf+LF3vuplgs6QecZLVcRF3Rk+?=
 =?iso-8859-1?Q?xKx0sLjZSAYQZPVJ8Zq/IScs7oM8NqnZtVYzTeBRZskGVAuMnk+afKkAx4?=
 =?iso-8859-1?Q?JpALkypdrh6ppbvLKiMNNNktnbwYKSswG+ULDPIpBftQ/taR9mlJVV9ghv?=
 =?iso-8859-1?Q?uT+hoII3DefEFqXPraS7mUqjSg17SPKhH3QsA0oC0d+YObElQd/3cVutS0?=
 =?iso-8859-1?Q?XVdPi1/A8ssj+oR5HRtEzDuBb8MUwhOjJDA4lHF+wdnJXpqhr7/GBUlvxr?=
 =?iso-8859-1?Q?r1jHgsTEWDNYRevTe/UNpIGVaLhKInURmjV8ZlPkptuECLoFdsl4Ua3xd4?=
 =?iso-8859-1?Q?Zqw3/k8Cd1Qx+5hS2DPNXIKQCS19KIXOKSXxiKwpV7Ql/FJXUmHFg7SrB1?=
 =?iso-8859-1?Q?cP+loEuiGpE6hxFK3rITYr2CWX3g8wt/j375qHP3tKg3TH0/6sHcBraYN/?=
 =?iso-8859-1?Q?Vo4GRY0yb5f+kZJhd7NaKCmWYqgpbtGgfNauMwbdiusQYs8ZGdNw6DPLIa?=
 =?iso-8859-1?Q?9m230oMaU8eNTjKlUMSNpYr5HMaKOvK/5HjiCFREZYvkx449Z0tMH/lr9E?=
 =?iso-8859-1?Q?GT54MposuYWs3QvZW5tjwjXbWC+zE5RmYF6wL08vEsOYaPzBvsV4gJ745h?=
 =?iso-8859-1?Q?//68xa3Oa3e6GLHqjEchYSV93xdqojF1sCgyX4a/QffaFKrh32Gq+9SyTf?=
 =?iso-8859-1?Q?12wAQcxqZqM/lXadE8M+uekJUOctDwZJAZhk926aGdytyRxcVes+caqOUg?=
 =?iso-8859-1?Q?f7dulqzUbN+DrZHIFTTi/J255g7tLhsRBC/C9tIOtv82CwV+FOYb1rCvQc?=
 =?iso-8859-1?Q?iQz7dEp9EAIPXsAjQ+Q4QJVzDzwRhFzbvPjVmSXXfa5TYXVIZMcv3ocVGm?=
 =?iso-8859-1?Q?zmSkyk5tVSWfkrcQ6D/XWf8PMAe9f0VZbgbB8LUH+vL+sKcEPRxLC71I5J?=
 =?iso-8859-1?Q?yUbx3dBY9YRnZ1xeiul3GttmEru77MKw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2awbda9SUBuuDlU+UNqxHYNwjNxvca42btFsCkhZ85u9E1PeSzb1M42U1E?=
 =?iso-8859-1?Q?ceNAbGLkgk6KPrsIbEk2gxb0/7rpVttX3Vc66UwAsVUTJEm3PfUqIHgULi?=
 =?iso-8859-1?Q?KDfK3233oy9Hw2chpRkTZCIX/Cj4B0duD2Ol4UBTNE5LUnasUERNd/hYgm?=
 =?iso-8859-1?Q?Pcooh3pSrVdHuXbo70nHF34wZBGck66oahC/mnip4qSd1ML9uisTaDiuib?=
 =?iso-8859-1?Q?GiDkCW/pTuUuy5Gj5oDGXZ8bQAOIRpcx+3D4RS5cx3G0ILSnAVgHKTZg0Y?=
 =?iso-8859-1?Q?x86TWXf/ppE4grgNauGCjL/CQ/NWGodzpICISIrWtP1AbcovmccikovTad?=
 =?iso-8859-1?Q?82hMECnyR23/DMrrWfrtdNPrpzZvKKzxX4mfolshWloh0tgtV9GmEQcMF/?=
 =?iso-8859-1?Q?K8Ni4jqC/xGb3QEXJp04/Wv5JODj2j9xhtOH4mpooIwI3aELzQuQOyoylC?=
 =?iso-8859-1?Q?wbdBvxSTpEbV4LvMSent3bIBe6dN6dnpRBCAGQnDkbZLsKD35YXdoOqtI6?=
 =?iso-8859-1?Q?GXa3Gv9GFHEifKLwMmEkzNx9Hnxt8cM3zxSJbZzymoXDHMYIoaNYdIjrC5?=
 =?iso-8859-1?Q?5MVvyhu1G/zCCtgQstc62cm4fvyMXwS2ITXGBjQ2N3ohHrMAiiNAzBmgAB?=
 =?iso-8859-1?Q?jrM71Vl0wrYnVAsOjf1HLNzKMl3IbaM645LVlHqn1sQ6t6DiEuR9n714++?=
 =?iso-8859-1?Q?jxSwT5Lla/aaC8VjMpFNaFHq9xZCf62+tXpxz02BZwsQcZdzM7EpJcm/yR?=
 =?iso-8859-1?Q?8aBcXXJ/6clfjWgfALFG1NODkdFjAcHkbK1MaLx1m0x1/xaU3Qlz8M3cpo?=
 =?iso-8859-1?Q?11FBYRvrMiQAIgfOnW2e2ltebfkA7KcN3hv6XP4qagAPybpyeFkFq8LjOE?=
 =?iso-8859-1?Q?+5SVFEXEMPAtnIc6ivdnu1DANZg6AvYkXEGwgOd6yh8P7gQ0jFVGixAcXr?=
 =?iso-8859-1?Q?Uqs8hCuJOCkQrE19tt+dMsXUZbAaQQyXP6XoHEkKddIq7hUm3TRYQxo961?=
 =?iso-8859-1?Q?WRsv549irT4XdVIGxnlOazpz1/6ux/ai9o3GfMt5Md/60ZmDMKr1H6NrWl?=
 =?iso-8859-1?Q?UfRMpgiLrF4Q0vh8F6OFE+4/BcG1QIYbr3dujDVv0uiIS7aOz5dHC60Da5?=
 =?iso-8859-1?Q?bHPMz/vh29OQKjkVFBEqqPKygBtJI40FiSp6oXUdroj0NlOqAXCKs/Y8Ws?=
 =?iso-8859-1?Q?9usFbJpw9D7jkyg+BlbHwvVGw0R+zLZPrnyZTofTwF5fcML1UnWRils3uq?=
 =?iso-8859-1?Q?5mRQ1B7hCht+GSpvBNW+yf6ZNxb6/uDgiRpkXmDCq7rp7FhGFFhBNHMCjH?=
 =?iso-8859-1?Q?xdNa9iDzzO5IjCmqYmJxFkf5ESbe4YmSyHZ7Fe2Gnk9Va6yp69DF5HVJTj?=
 =?iso-8859-1?Q?UpEsIGizW+SnrhBxPYh+NGOdqohQhoKTQ6d7x5Kt+uGwI257SJvXqzZsx/?=
 =?iso-8859-1?Q?sue4Rtkpqtp1qflEtxKVo4phl8INdMA3gw4Qh3NTYPsmJ9orlI8mFonXli?=
 =?iso-8859-1?Q?1W2LNRRZZ+zQ5i33BxiqFIwd9DAYlL8kot6MheHQ2hK7ssxzR0AeEBLDZt?=
 =?iso-8859-1?Q?k6H/Iu/YEsVQyjS+R2ef+IFI2aKn14IcLJ5ubwle0AdXc9QIU6BEjAuXM3?=
 =?iso-8859-1?Q?3xf4luyPBXQPc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73061f76-5ab6-4fd4-5940-08dc83b8194a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 10:29:50.0816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DPFrjTZGu6WWttyxE3rii8NKH6S+jp4/esEW1KBMCM9XwryQOcFK+UK6rLQBg8jxTocnyaQHn55xl/8iaCufvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065

=0A=
> > Both these features are supported by BlueField-3 PMC hardware, hence=0A=
> > the required bit-fields are exposed by the driver via sysfs to allow=0A=
> > the user to configure as needed.=0A=
> =0A=
> I'm trying to understand what happens for the other counter, when the=0A=
> use_odd_counter is enabled? This change also doesn't add code that would=
=0A=
> make the other counter -EBUSY, should that be done?=0A=
=0A=
When 2 32-bit counters are coupled to form a 64-bit counter using this sett=
ing,=0A=
one counter will hold the lower 32 bits while the other will hold the upper=
 32.=0A=
So the other counter (or syses corresponding to it) also needs to be access=
ed.=0A=
=0A=
> For 64-bit counter, I suppose the userspace is expected to read the full=
=0A=
> counter from two sysfs files and combine the value (your documentation=0A=
> doesn't explain this)? That seems non-optimal, why cannot kernel just=0A=
> return the full combined 64-value directly in kernel?=0A=
=0A=
I will add more clear comments for this.=0A=
While it is true that the driver could combine the 2 fields and present a=
=0A=
64-bit value via one of the sysfs, the reason for the current approach is t=
hat=0A=
there are other interfaces which expose the same counters for our platform=
=0A=
and there are tools that are expected to work on top of both interfaces for=
=0A=
the purpose of collecting performance stats. The other interfaces follow th=
is=0A=
approach of having lower and upper 32-bits separately in each counter, and=
=0A=
the tools expect the same. Hence the driver follows this approach to keep=
=0A=
things consistent across the BlueField platform.=0A=
=0A=
> =0A=
> Similarly, are these cycle counters occupying the same space as non-cycle=
=0A=
> counters (so both can/cannot be used that the same time)? I'm asking this=
=0A=
> because you're adding a parallel interface to read the value and if it's=
=0A=
> either-or, I don't understand why the value needs to be read from=0A=
> different file depending on the counter counting in cycles or not.=0A=
=0A=
It is the same file. The count_clock sysfs exposes 16 bits, one for each co=
unter,=0A=
to allow the user to dedicate any of the 16 counters to counting cycles. On=
ce=0A=
set, the corresponding counter can no longer monitor other events, and the=
=0A=
same sysfs can be accessed to read the cycle count. Again, I will try captu=
re=0A=
this better and more elaborately in the documentation.=0A=
=0A=
Thanks,=0A=
Shravan=

