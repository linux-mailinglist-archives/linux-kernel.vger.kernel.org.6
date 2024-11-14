Return-Path: <linux-kernel+bounces-409497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299EF9C8D97
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7892850F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B76139CFF;
	Thu, 14 Nov 2024 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D4E2pfep"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B162D2C859
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596895; cv=fail; b=qR8ndltOsuQLCht7nq2go/cAYhuE5lHYyQsjd+bWHYQ++vW0EdPAuPvJ4R/QowLMC3BnK2v9Kt3vRMNulryPst0KVFRHD+7I8Ob8DoLOAsLpIa/j96oRmcLlnxye6pcps8Dnmt7ZGGFVrPJ7yfWp6R7fG/83VnUJRfKh84eBcxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596895; c=relaxed/simple;
	bh=t9P15GnLwoUI9oglJ6cTXHDFdNmAZ5IIsVHP3wvsa5U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ByRDfTAU/T1Mw+RihxqUdTuvfYGKkahz5qGcH92hPosEpPBasZVcTlpIjpZXHLPO63ur0djMwkEO7RNzcD9HzyY+riRhyeRchCefAH+7YnurRoHlLt06/HVTcvp0D0V14j6Siajif9XvGhkNCPAqeLhwQj+Mk2vg0wk/ktUTEUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D4E2pfep; arc=fail smtp.client-ip=40.107.101.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N++NK9RVbjlX5k1LGemPWjDdKYHAILpIPYZBIKcASTviT0jDNjBsUHJ54twnfGbeec/Fmy92oK6UM1sCHqZ++6qkLJKNeLwBoLgUggZY8vzX0rjIo+Od7lU5KL2r+iJihqsjXTAcBbWQwaASto0f9fOu534YEZI+ccsjGWhxgQkyUnw0qFHrirpODUFz5vx6v9cb1Pmmp7jbvhkXzNn/mqnRNGG6AzKrGaoEt762VWM0Y2nWA5ZV0nxC94V0RDZ5tshvNdc25qCkRbUEj8IDh4U5LCYS/i1FrjZ1Wi7Z1bmGHzrXwwdp1Tg22KvWbgPMBcpL7gI6ftnWydVFdHADRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESqtbeBcTAwRnxnuQoIrpeVJk50ao6DhzwblGxO4hMo=;
 b=gRAmeRF+cwgwR7LQ26PYn+izNV/7T7m+GmBu9+OIVhPXB/ZHC7WTM0cUNcJFIjFNt+PP/M1Q3001o55Ys7QnWLbWBGngzD1LJQPacMgzYh9kw5N5lOKoW1yN/POevIUC/kjcC9JjkidCui54aFFE9UrxjEGo3Ka/mSCXUSbsyFiwGBL2pQT1rujAIxl+dBH3URtb2qGr5eMn1E//L02dPuct3FpzWpT+Q3B4+SCqVsWJ7mpvAqmwmn5G6cjfS68ax5tTPed2xpq5jUqGL1QX8dsYu+yCG1dJPnrprQD27axDBsZ9QS0gsJy/uRG8nGD98I142cBePXDxDX0vp09/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESqtbeBcTAwRnxnuQoIrpeVJk50ao6DhzwblGxO4hMo=;
 b=D4E2pfepwBmBwUlssnUlmIzpEJ40xINEGZXtqb+pYwCQnLA58lZCvTZCY4MBOy64Xbq1xNS9iHfPVq/75iHDpxcwp4U/rjUYmWqepMZ1h3e3Yh49IWF6cB9NCgdvxPV1a1V0ep2cBJvTL+rSPetmUFGrzTDzRgZi3eIWiHABtu8=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 15:08:07 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%6]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 15:08:05 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 05/35] x86/bugs: Restructure taa mitigation
Thread-Topic: [PATCH v2 05/35] x86/bugs: Restructure taa mitigation
Thread-Index: AQHbNk/HfUR2tVdlUUmDw7OGibp+FLK24UnA
Date: Thu, 14 Nov 2024 15:08:05 +0000
Message-ID:
 <LV3PR12MB926557791369E71F0A2BE84F945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-6-david.kaplan@amd.com>
 <20241114044317.22i2vlekf7zimt4d@desk>
In-Reply-To: <20241114044317.22i2vlekf7zimt4d@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=07e3c047-55f7-4872-8e04-176c65bce89e;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-14T15:07:42Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|SJ0PR12MB8616:EE_
x-ms-office365-filtering-correlation-id: 6da5ee24-e6ec-4756-8985-08dd04be2421
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OUwDwk9cHx2oWM7CJEpI3Ya85mVrclv64di9gwfzKax6sUJJOsGPnWENbHIk?=
 =?us-ascii?Q?G1/7IaMnl/O0BrlqaZljz3tCRwH4N5/MSQI/Vb8JqvTAWGxzjm0jPWTyK4Ju?=
 =?us-ascii?Q?zV9SpOb5o+zXeqZqDU8QngfJUoDGsYM4hVRXInrYpDRV4N54mr2Gw0wa0Q5t?=
 =?us-ascii?Q?cTVrVylUNu5H50TyLN0Rob23zTXZQZ3qfvhpXfLrqTGd8IQHMemqAwfYrJUj?=
 =?us-ascii?Q?mQRQTx6mRT/ofbBfcsWEfh4s95FBQL52nvuDJxpGMJhmXOOUsUq3IAX2lvd3?=
 =?us-ascii?Q?HuMvi8sZG01vA2OT/jPH4p0jmJItiBmP/zqWaFNirroNY0Crio9dXm6+I2UJ?=
 =?us-ascii?Q?D2+RRfdijB3EHEkIleYTdTDMeCSqdBFAbtGNLTWt/PjW54Fryt/Lpv7yzfQD?=
 =?us-ascii?Q?JRVUb+3RXH+5pP4FhL1Sfvy6qvW19p4GlAuAts/SgTs0bBP8860YopDjfo9/?=
 =?us-ascii?Q?jAMVvXAYgzhh2o2c1uMdZioYqafiLG/vZv+qxEz89muwv/w6a/l/DnchGoJk?=
 =?us-ascii?Q?rUwLvUPX6MZLTjuIdl4+Xt+Nn0WbmQ7889W9DZY0VDPePzrSOCQIHVH47Df2?=
 =?us-ascii?Q?prt+9Ax7YNR5CS+LSWJy2AooDQXSk3Lu68KFeyQ8rOsRUZL0GBRKAYz03gAz?=
 =?us-ascii?Q?p0vtF4PZi/ngJY9HTk8ZNUEWmng27BoYy+/UjtZnAaQ2mqo5efH3Di5hL5Hp?=
 =?us-ascii?Q?fMgdJqqtqFZG0ZXnDMOxheCvCgbe1cRm5/H7x24o16uiibM4cSrPBYtu4YHR?=
 =?us-ascii?Q?jVcPi6CAoRha3u+oTGh7OqggpSTXXlWmTCS4dEwEpYwz/TaVdUPn3yt3uGeT?=
 =?us-ascii?Q?QW0Tzuz//phoZe4cuvWBuDu7QzAxWP/E59ymWIQIo7eScAt9JUFufg/5hilU?=
 =?us-ascii?Q?O9V/r3t2w/svEivA/p9NVI5UM4lFSRnZeLlkyGijRen3kAiC2PW3dnGJvZFo?=
 =?us-ascii?Q?goQgBWs/kIDtIY0LAb6m2j01wMIFtEp41IiE3IIWmG83GpQe224z91hrZ/ao?=
 =?us-ascii?Q?psl5bDdT3KEvZAQEOghU9dXuGf2sCGKxQWLktMXj9FPb1QHy8uLtWQXXsdr1?=
 =?us-ascii?Q?jg75Z7PndNYw2Iq0gYyLsI3eo8mftP4ktcMXa96WY1HvN5Bs6OArB8NzJNaU?=
 =?us-ascii?Q?F8VbIBQ1ThpY2Jq2cp1QfKu2xDZaEgiAWJ0XDFefHEcXMHR9S7cK0WvjZ2w/?=
 =?us-ascii?Q?96FE8wGAz+xku58BdOiiaYoqzc0WkhNnMSkKhcMpFBG3nv4Jz/9MnpeMvhXT?=
 =?us-ascii?Q?oSly8yQgIx83vjw2Ry7f44KbxByl2dEBo5a8ez9pjTAbsztPEenqItQD62ZD?=
 =?us-ascii?Q?2gMlsNMoevTrnz34JFkkv8gfDqnjrOZ633MGnsDKLK4Hq9Mtuqq3Lvr3oZzB?=
 =?us-ascii?Q?u0ttZqI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mEk11PeaO38LD7ilCOQbnM/Zzfuv0w7JTJU/ZHXfxGCnW9sUVw0EpvVd43di?=
 =?us-ascii?Q?EhlafntcpxSZLc6ipKZhUCZfpPu7MuY2QGRPjBvzcOH5q+3fFmcmC2EWJ0qi?=
 =?us-ascii?Q?sjU0Y9NQsAAVlTdp7iIqQGEh1DvzqWvXgb2C4O0p8lUNaVwQHvM9JsIFJuIo?=
 =?us-ascii?Q?qdRn+aKmJZC+1FT7hX++QVQMvQX7oEY3slw4rtKZvBlSzxdvGMFjXBWlpCMc?=
 =?us-ascii?Q?iUhDd+VKod8b1O0TCL7HHSDI6siOFQjZhR2rn4ey/M2n5fEDXuUcHZde95Sy?=
 =?us-ascii?Q?c+dB3q06NI8MaNfKgcBAH1bnc7rAT4DIAXTJtBbfqdUu1VqqodEGPs+A4SPz?=
 =?us-ascii?Q?LFn15lk7M0W52VnLU84wCGCDU8kByXFC/vpx13My0rsf+oSd+ZCba56/TrNp?=
 =?us-ascii?Q?rGocxFHM313OL32MRU4ea6RWcGcipGiHMIJ34WgsmrVRBZGQT8ai7l9UoqFp?=
 =?us-ascii?Q?6iwx5uhne9l1zYE05YACdjyBjxpeCIYD4L8JZltvus5XEUKBJN/ayvShL4TE?=
 =?us-ascii?Q?SyDeJABTSm5vZOZwSaBgpKxZ8srQ0mIT2PKc38J55Udb0IWymaryLOypHjrb?=
 =?us-ascii?Q?8WRb4MqrN++on7bvyyNWrTUMdM71VSY+ebrNCl176FaLvBJ21wQmg2Te+C0e?=
 =?us-ascii?Q?/Q34+ttgpehGUFDTjcbeK9Sy6iIupyw5wlg9Sn7Fcv+QLDGyZB9F7aR/0+8R?=
 =?us-ascii?Q?h81Mys/EVmqEpTAPm1NWHhnJg7jKWWOPOH5Ioa9t+faRbsgDbFoDDUKDcRAW?=
 =?us-ascii?Q?5f0pFXY+49XU1AAtsNM5IvISpVoZ7zcrHFEg6j4UqoqFBpKWrYZwdBQBPUDJ?=
 =?us-ascii?Q?DMyve3dSGrAp8XV2QCinbNlgf9NqzA5VpSQRrbkuBrZ3oQm4pl6nvFerNAx1?=
 =?us-ascii?Q?PCxad5D880GrhqyVhg9oFfiLyrsEUUtx4JehV45/3sV1MJ27o3xLGDucU+N5?=
 =?us-ascii?Q?5QwFK8iT3t/wmqCrDepWlUkOU7EjDX6ECHxGHepVWdK5OPgFG5rgkycUNEPc?=
 =?us-ascii?Q?S5w8vFZpZPRctmg0ADKljoG1MWmsuDAY+0IFmmrCH8DtE05ttWMc+VJxWxvZ?=
 =?us-ascii?Q?meEp0dECCJp6cV+U+DoJfvRZBmCK2BxvhPH/vggqD2Nnnl6iBNG+0khyZqco?=
 =?us-ascii?Q?FyqMWHVu2tFDbwwdzQf/H6oR4k1JrbbBn9fDbsxQ/21/qYyZDBzRodN1zG8p?=
 =?us-ascii?Q?fW8dOtsZ2WL5gLWiY6cf3BUOhB0NWQHQbFfSPjgMceglrFw0EQB1Ldvf1kpr?=
 =?us-ascii?Q?MaQEDDGHIaG9eGPxHkgMDBGWl1+jHSAkPJvq4Vou11rTAlgHRYa0Uv+eGmZ5?=
 =?us-ascii?Q?k0XYXeEktnV09eMQ04mY1B7cXmy5H159GWBe8shQo1dKx0BwayE+mMp2AfTX?=
 =?us-ascii?Q?wmnSMQdVw724bp10Bw2KxFf6woJX1NMHRM9By291TWbYvL3k+BznoACj8qKl?=
 =?us-ascii?Q?PNDg3ygAMSvqvuXlMNO266+rF6lv47XzvrNmhtBrNW3JyfiM4GdtIO+GMp/e?=
 =?us-ascii?Q?NsoxYJIZ8IsY3SM/YsqimsRyPCasHBNeDJNCqU7TriEZcZ8hN0yp/KpKRthl?=
 =?us-ascii?Q?ey247+uiK1sP2wk2/+U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da5ee24-e6ec-4756-8985-08dd04be2421
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 15:08:05.2892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kbzt2VPqBLtB4XlyVZ1sv6YYW7a38SB7C8fMcdDs3QEuEve0nQfEjL5CP4TJ4lF3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Sent: Wednesday, November 13, 2024 10:43 PM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>;=
 Peter
> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; In=
go
> Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; linux-kernel@vger.kernel=
.org
> Subject: Re: [PATCH v2 05/35] x86/bugs: Restructure taa mitigation
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Tue, Nov 05, 2024 at 03:54:25PM -0600, David Kaplan wrote:
> > +static void __init taa_update_mitigation(void) {
> > +     if (!boot_cpu_has_bug(X86_BUG_TAA))
> > +             return;
> > +
> > +     if (mitigate_any_verw())
> > +             taa_mitigation =3D TAA_MITIGATION_VERW;
>
> This isn't right, TAA_MITIGATION_UCODE_NEEDED can never get set
> irrespective of microcode.
>
> The UCODE_NEEDED checks in taa_select_mitigation() actually belongs here.

Ah, I see your point.  I'll fix this, and for mmio/rfds too.

Thanks --David Kaplan

