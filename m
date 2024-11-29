Return-Path: <linux-kernel+bounces-425640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79C59DE843
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598AF163091
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A61A1A00EE;
	Fri, 29 Nov 2024 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="C6EgoGdI"
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF0419D8A9
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732889401; cv=fail; b=pgyY9HhOhaQqwzvGjqhO3GUbTUXTAW8cxZL6ePhTwHK/Lj/TMj06NPAuTZl3XANDNWJp6YEn9Ia+DnLiYQxdBjjegCu4IWC2XhVjOJhb9T9DKfiNAinphoWljrh5lSaZpOCla2kfG97jJRncFze9KD1QQmHm2H2fPV2P8btmajs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732889401; c=relaxed/simple;
	bh=I6JR+mlcbuRQEh5jctfzwEv3K75yFc5+G3Zf6vKpNH8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WaX345jxgIkmBLyWNenZndXWLoqK0Qlda5TS1TtG56bTlU/52GFXtjYDKDzn5By2z1t8i1GUtciyN/25uKKiUo0zSO2oH5o0qtQ/J80nPSNkPl7vEJbU9OimNSsakiln+DGvUKoFjSQAne7+pwFEwMQSyJbUJ3vjM5wfp9VDEEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=C6EgoGdI; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATCqwqH016557;
	Fri, 29 Nov 2024 06:09:45 -0800
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 437b8ggd14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 06:09:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkJSMaICVTYEASQt6BdoDWO1z77Kqy374JvlsvTJrEteL6VSom6/SxVCd+rG+Mk3dDdmolTKJQpGAomCAfXKGwK/xQK4JN9QYvhvfd1i1A3Iq7vFv3/rCMAEns7MMNKts3esgpiv+GUxsjT0VHs23UK6ogF/DNraZomo4RDwFMWAISsewcIC/8s1lvBDtUZpAhh33OIZ+FxsYwL5g79yY3mGQkgOv/tVFXpPNk585Ep4RIzh7P4iDVFes+SypHhhfzXQghTwlrEg7ubrec0OlVKHQbz2j5PBKZGWabJp6bPKY1mxjPB+GU1Y5NH/2w35EBVhJ6hdZN8BczQk1CXr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNzTjTNm6WL+ws+pWfCXEdVcQAOHGhzyjOkeFT/kdsY=;
 b=KpGE06j/sUWQiMYH9Xdb9x4V3XTtKHCLi5inHq//v1G2JnhNcXIsR31IzD9Ec7Vg1OQRTR0qaZuTiQ76xA4Pe2tLT0Sd1u2m3vZy+1yMGXo/Oz7ifmVwJhv4u1pSYIVTnWmhnZOnmQ0X55iSgKvJdOOAKrdjznqfDayNnaQWw7yXVwqV2rkhqVh3E2qw2ddIJDPFa9NhZRWgmqzSSscBFazOAZcvTp5eBgYFecjyu8A89vxs4vZ6BfTkHfSHpdpeOzgkeskmyHqh3jlgkNUQUO1RUZwQ7hUwVbo56Wte6P8t1fXgq/7m8MMgsm/GgNYcilrjVBO9O15Ed9IKZOIA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNzTjTNm6WL+ws+pWfCXEdVcQAOHGhzyjOkeFT/kdsY=;
 b=C6EgoGdIGU18BBvhgmrVQqzmdXixHRPD9y0iEhaUD/+HqWOBXYCh4t1s9T35k0bdKaFzSA4MoOToO2RIjybXScmhOwJK4bBOBcs/hQfbTQWGHQ5agyMZ2dBFFf6PeOQ3yz8Uvs66JtfS2AUt4oybTKE5XTS1RdvJh9wXzm1GRO8=
Received: from PH0PR18MB3864.namprd18.prod.outlook.com (2603:10b6:510:26::6)
 by LV8PR18MB6232.namprd18.prod.outlook.com (2603:10b6:408:265::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 14:09:42 +0000
Received: from PH0PR18MB3864.namprd18.prod.outlook.com
 ([fe80::311f:66eb:cd27:1d1c]) by PH0PR18MB3864.namprd18.prod.outlook.com
 ([fe80::311f:66eb:cd27:1d1c%4]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 14:09:41 +0000
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: "will@kernel.org" <will@kernel.org>
CC: Bharat Bhushan <bbhushan2@marvell.com>,
        George Cherian
	<gcherian@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 0/5] Marvell Odyssey uncore performance monitor
 support
Thread-Topic: [PATCH v10 0/5] Marvell Odyssey uncore performance monitor
 support
Thread-Index: AQHbMZOVwknHVC08cE+I9U8yEclQ5rLOYy4w
Date: Fri, 29 Nov 2024 14:09:41 +0000
Message-ID:
 <PH0PR18MB386461FF310584F05087C0A9DB2A2@PH0PR18MB3864.namprd18.prod.outlook.com>
References: <20241108040619.753343-1-gthiagarajan@marvell.com>
In-Reply-To: <20241108040619.753343-1-gthiagarajan@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB3864:EE_|LV8PR18MB6232:EE_
x-ms-office365-filtering-correlation-id: 0db1067f-ed00-4fc1-5c77-08dd107f77be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8oksC8G8bnWEt4SZyBMB2dox4bfP3EnOQ3H+Ql05ldrMKsMthFjF5+5G+51S?=
 =?us-ascii?Q?UElTxKfZZZ6hlt+2D4paJYIo3PCDwTlqknOxZ6AvK7GKrVKYW6+lcCRY1j8M?=
 =?us-ascii?Q?Y1b6I1WeGduRNVYEEyiAouPuXo3mLaCMAR3wkA1c9EV0+PZjfXK/oJUTtd0X?=
 =?us-ascii?Q?TNxAV+kAIZ0aqWYQjrUAbztmElyFktEktMEXM/LZku97EMRGttHReiOSUHlV?=
 =?us-ascii?Q?aQxIYpNHR2iZDfc5wYNJv4KA+bCViHi3igzTIa/K9jfE0jyGMpsH+HFaARo3?=
 =?us-ascii?Q?Id77Rb6t8vG4yKHzNKsSqZ8+wUEO8IXaQmPEBrb0cWZ+E+D3WwkgMJmLRgak?=
 =?us-ascii?Q?nvVk4l52L/FHg0rTRgU7TR6M4YpFA1ARVnDXbb1liacliCqXhXlVrlQXNZKX?=
 =?us-ascii?Q?NXkb3G6MMu8J1wLQLATXmQxLRxTV8f7DqMBHOYH3u7gS3CcQG2LqXPkLam1W?=
 =?us-ascii?Q?RI+gElD7FVXYkjxIbbV18nYoG1Z50a7Gh/WoMVYDLEglmCOaQxJf5QlL+kSy?=
 =?us-ascii?Q?PX3apqxOEFGXJAc4eic4svyjYTC65WY4k0Q7guveuMrs4Eq9N4hBaHH35Xxi?=
 =?us-ascii?Q?cF6WGkIShm5Hh0h7lEG015+3vov27z4kGRzmB2NvL33oBYWXIpw241KwlsPI?=
 =?us-ascii?Q?F8oR8A+LgqY8UtlXPF8cf8iokhV6ykarL1qP79eNClMNhV3zwofJxZXVOCR2?=
 =?us-ascii?Q?DX68ivDGe29etlK9l32anneaOagPZNNJtWmNcwB3tex/EZOk3uVcwGt2Y64L?=
 =?us-ascii?Q?u+AXzi5ee11Lh8IdLc5LkGdlF1Byb3ENZPGVCZrCGhvf31Ce+U0FPLLLArnc?=
 =?us-ascii?Q?jJyAuPWY1yOq/p5/xxZe7GCwniAhQyBR9UeLYCyNI+DvyVeTsYB8Xwro7Uxx?=
 =?us-ascii?Q?hUmoLRJJzDRqF6LaxNZJSlzXqugv/U2JVQR8PO+WSbkUmRwh0cB7BoMm39Ej?=
 =?us-ascii?Q?zdGEsAGlNCG7dZcvsfHvn7lb/lKW7ljpSzDyhFsZ+BYh9vZBLorPiuq4WF8y?=
 =?us-ascii?Q?jFOAiT471OGxUTrAyp/mS3nIxht63KSYGSG2+2tzyB+pVfCCMYDFu9pOWF3+?=
 =?us-ascii?Q?9mZlAeH/Tobc7L7OxMSoFtoOZG3QpmY/A6X82tNrv6vZBiyEUwx/M+f7PKyr?=
 =?us-ascii?Q?ht46w5CiKaiLbBHOsG44+y8R3v1gI3BDGMfasi+naDfrAwnTGF2z2L2nVXsz?=
 =?us-ascii?Q?doJ4is6px/Is8OmpSVFHLHjLggCStP7TpYsDtUKiy6+nW1Oca5Q8Qld4+XDs?=
 =?us-ascii?Q?QPHKv622eDNYOKluq67PUgn0Vg2zdt+oDMltec9ljN+cC/4eGf7SNQDhb8QK?=
 =?us-ascii?Q?KA/bHYrM9Asadplt+Esyqhyo0UONo9+Sgam0KRcOOuxoSZyspYZ3uGint5P5?=
 =?us-ascii?Q?DoWjdr5o4IUQBENolaQ0SrM+SUg6feF41/n6q2O4AaGSfD9jiw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB3864.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mWrCBcDTNmQbNCTHbpTuNOA8OPKzt8ykwqo9f2u64eXZa1Eeazj7j3XRENhE?=
 =?us-ascii?Q?3Cn5xjtjoUEFstUbxXTRITYepXq3nKvwQBL8c8GroVlIi9YG5I8uNNXbn1sW?=
 =?us-ascii?Q?GGcmNtA7DKPTAMFEJZniVw59P8DMxY/TzJ0UuCkW3y9BLIgAeiANJWcTk3zn?=
 =?us-ascii?Q?cahA86aEEIZxew6qnSdFSzpwVGy6dXRV5K3x48UT+MvHrFpL3/8Z1j9KgHww?=
 =?us-ascii?Q?DAqx+c7Y0FgzMWbkMF8mQloi0K1rR7MUQl5gA5Ym+VSL1Vb0EZPZBdH8Cq9b?=
 =?us-ascii?Q?Ao3WNojzO8CdPzuLS4ae8S5oX0wx72MiqY2TiZ0gsqm6y+xRfa3oZf5q98Hf?=
 =?us-ascii?Q?7ashZV33j/eqfvW+mIhLJazy/uW2cxoBQZwFGPqwUDkhz+wsTCsVbjm9Qzt7?=
 =?us-ascii?Q?NYtYtlQwM+zMCjCl62MA1HGTgWgyQnY1glOHpWT5ZYfsaBXjWDa2k4aAZJZH?=
 =?us-ascii?Q?TrcX9MqYwROa4sqtYKvZwPyvDnQ8TMoxP7rUFJwU1Ar5EY0EiJlTXPep3YBc?=
 =?us-ascii?Q?W3MKVzFTy7W2s4G3W4/QwiUIr/nNl6l2G5sy1KTSLfJ/JBM7YfpmlAC1NEHU?=
 =?us-ascii?Q?glZt2yfEY0G6Nunv5mIHtfKp5YDVbO826hwc0ISkIZ9mLYXRDRC6XLsahMPR?=
 =?us-ascii?Q?Ly9ReHWH85grjYI3lUFVsgMYF9UCtfYtAscuXgotzvgEr/sfoDBldH/lWWg3?=
 =?us-ascii?Q?bzxPJ4wKbd6yB7nacIHBA1QSiPRDRW+anaAG82he9QxhmPkdt/BP2uDhIfU9?=
 =?us-ascii?Q?DFKoerOOm7KAvOi2uTVEHCKP31todSAUTJfYz9Lu//Wa4febv2Nu/GisywgS?=
 =?us-ascii?Q?HrpA//xug0QhkftGAHONYbaurCi+NcUMWH81DZgRdyiauUTYf2AWl2iCYT7X?=
 =?us-ascii?Q?YrKOoitrYf/idPL1K5kQ50jxcD3c0Ys6ISKHVx29Dc6J1NSZFm01zbTZ/hnZ?=
 =?us-ascii?Q?jpaAKwGQzfFGXJJRzrjAEZ7kTduGVFvclAHtxUOn2BdSKWaNR2KJ8MWxy7sq?=
 =?us-ascii?Q?E5/QBs7qVho++w8fqRS1eY3/NpGQbAvR9JwnHjOI036s0DQlmhaUOGj3ZCH2?=
 =?us-ascii?Q?pZcb/y6KqMrIIO8lItePuKaJIb8A2+5kfBeuvTVgCS2b6g9yNMCNq4raQ4mF?=
 =?us-ascii?Q?Wj6OaAA8LFXe4IvWtuFJOm5HVRGf4IPzh+embZnMe/DwBxgOrtahie9Drt9p?=
 =?us-ascii?Q?KiVV6O88CuEKVm48OIwUMKFaUldlNoX04sduhpAuolYXuiGz0h/1QNXZQv5f?=
 =?us-ascii?Q?3cMumC4qRG2wV7uivw5yFWoDEFP8gkoa4kBbAChN0CRyB7nwdMl7+oUuTw5W?=
 =?us-ascii?Q?tNIM1Ow3HpD6w2BfnB0jFu2fXIsnXQLA/dzNk7HJVTnIck+hwdCjFMWjWHYi?=
 =?us-ascii?Q?ocsgJZAGPK7kvZR8NCKP/I7pcfx3WIImSXj8cSA66DnTJMlWjV5ml7O0vqpt?=
 =?us-ascii?Q?Oay297kK6+eTVBW7hYTohjlFaiACcSJl8Ygu4xFX4a5ac9Z0qXWlkpxI5iVq?=
 =?us-ascii?Q?5gqpztUMijxb9kPVOO5xtf3qne7BG1+X8PlQVpSi2z0AAK++zWcQJOt8aDRn?=
 =?us-ascii?Q?oruaNCh+9DXxo/braC1I8oYa+0FNTekveJssb6Q5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB3864.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db1067f-ed00-4fc1-5c77-08dd107f77be
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 14:09:41.2239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bk4kJMPNLyLCg3fLuI9f2rC8Fx25f36pNa8qywncVWPWdX9Zz9UBdC+KkVIx9DCrbdGjwN8WDjvoklEf2nG3FxtaiqLDuFfXy8J9jxB3++s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6232
X-Proofpoint-ORIG-GUID: uLyl_W16XPUDf3ZG3aVRb5nUX5owkzjs
X-Proofpoint-GUID: uLyl_W16XPUDf3ZG3aVRb5nUX5owkzjs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Hi Will,

Do you have any feedback on this series of patch? All comments have been ad=
dressed.=20

Thanks,
Gowthami

> -----Original Message-----
> From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> Sent: Friday, November 8, 2024 9:36 AM
> To: will@kernel.org; mark.rutland@arm.com; linux-arm-kernel@lists.infrade=
ad.org; linux-
> kernel@vger.kernel.org
> Cc: Bharat Bhushan <bbhushan2@marvell.com>; George Cherian <gcherian@marv=
ell.com>; Sunil Kovvuri
> Goutham <sgoutham@marvell.com>; jonathan.cameron@huawei.com; Gowthami Thi=
agarajan
> <gthiagarajan@marvell.com>
> Subject: [PATCH v10 0/5] Marvell Odyssey uncore performance monitor suppo=
rt
>=20
> Odyssey is a 64 bit ARM based SoC with multiple performance monitor
> units for various blocks.
>=20
> This series of patches introduces support for uncore performance monitor
> units (PMUs) on the Marvell Odyssey platform. The PMUs covered in this
> series include the DDR PMU and LLC-TAD PMU.
>=20
> v9->v10:
> - Minor code rearrangement based on the feedback
> - Typo fix
> - Updated commit description
> - Added RB tag to one of the patches
>=20
> v8->v9:
> - Addressed the review comments.
> - Added platform specific flag in DDR PMU driver instead of version
>   as there is already a platform specific data.
>=20
> Gowthami Thiagarajan (5):
>   perf/marvell: Refactor to extract platform data - no functional change
>   perf/marvell: Refactor to extract PMU operations
>   perf/marvell: Odyssey DDR Performance monitor support
>   perf/marvell : Refactor to extract platform data - no functional
>     change
>   perf/marvell : Odyssey LLC-TAD performance monitor support
>=20
>  Documentation/admin-guide/perf/index.rst      |   2 +
>  .../admin-guide/perf/mrvl-odyssey-ddr-pmu.rst |  80 +++
>  .../admin-guide/perf/mrvl-odyssey-tad-pmu.rst |  37 ++
>  drivers/perf/marvell_cn10k_ddr_pmu.c          | 530 +++++++++++++++---
>  drivers/perf/marvell_cn10k_tad_pmu.c          |  66 ++-
>  5 files changed, 641 insertions(+), 74 deletions(-)
>  create mode 100644 Documentation/admin-guide/perf/mrvl-odyssey-ddr-pmu.r=
st
>  create mode 100644 Documentation/admin-guide/perf/mrvl-odyssey-tad-pmu.r=
st
>=20
> --
> 2.25.1


