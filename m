Return-Path: <linux-kernel+bounces-248683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6C092E094
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DF86B21244
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A99D130487;
	Thu, 11 Jul 2024 07:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="NnwLRG0H";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="687BiGV6"
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A776212F385
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720681863; cv=fail; b=Yvf84cWkkmPMUduMCE9w28+1EXY9AOVBEp8qzCG8AvcRT62M8zyctCQ4VOjDXpmOknrbC8nGgaBAmVGMwGKwis/ONtV99BTZbtN27bo1dmxKz8QamimaGe0T645UlmkukO8CKY+oFfcxI7YkoG9pwR3hboYFwopS+bpEWqHAWzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720681863; c=relaxed/simple;
	bh=LBGP2nIjDeDRvt98WxJrlvwc8e+73Jbv/yk80ngrmv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CDov6lfB+fy2o3wAakSmZDr9BZ3heX3oUJh6veV1Y0kBsDau5gbUMpoBjQ30uNTT5lduLIzC3k+EasU49YnHShkx4yqlYuu4un+JxXg9T/oFz2Yy4sHohlTpPQcG4i53VGUplzwr6XNoYU0VqVzl2HRv9kxmw+Y39Y1gyN2U91A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=NnwLRG0H; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=687BiGV6; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AKQYfp026688;
	Wed, 10 Jul 2024 23:43:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=XvQxHKR7bVhXAiIo+UNMXvhonp/Zod6K8e/8LZ2wW2k=; b=NnwLRG0HtJBr
	ii+g4wEJrJIhaVRGrt18wc9leJD30bjcbHnDmCtrP9pkpH/2b1Oczs95VnCB3BL9
	1eDyhtsjL/oVeo8TxcqaqX5m7fB74eO+oIpAW1l5shd9mIeJI8GLIGg8n3oHKFw9
	vdmtLatx8qRUGxPjTYlSiD1PVE7w4RCDtUq1dMkoZKPDQS8wy8bGFCXpwDKBgK7y
	MRqlY/yY2tGP1PosPdbP3sDbXDv/ISo1gp+LmPj7WJj5o14qGHUNLpRHXL+waEQZ
	l8DXkA3fJrnO20UqPOt8FTgay6j54FnopewIwAw0pfPduapqW5IQZbl2TkmwWZ0B
	L0ukI1TwRA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 4071gugm4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 23:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjrMkTgQol9XD9HpN+yS0Y/i23EVr+Sp4G68Lfu1WDQnnNW+jK4pPH9Qi4LOgvv1/i43FqboWqCD5gTll82VBgd2G0ucV+J+z9MxHGiE0Dj8mrdaOH/ksxBLYK4MZIEWPjd39GPtXw4aZ+0+74+78jU9VugiLwktsCDU5OVNMgCwCBVjXDglLLIGFw8SUEDFnrcZa3RIF/6+BzcL13UoJfN/3HVCS7Cz/JF90nuBPSr/HDMPpnzKmJJlmltdEHF/BrbKwXhKnFMPIj65OcirptaLzA3MUiEg6RBZRnNE/cdF7T125yQEDsMNHHPaibFRRfb0epFD15LEcKA4EPBByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvQxHKR7bVhXAiIo+UNMXvhonp/Zod6K8e/8LZ2wW2k=;
 b=jYejkoGuS+2dJJCB3QfBLC9Xh4qWVfvjj03Z0kdHJoDYvzTNxZ+9C0AS6gIjAMV9hh0bVp5McTEjhfqE2RNKXbh6/MPsavzJeNkyBe2yUYhwlab2jFROPopWyaCW0n1pP7eoIfySxFo24dPPGDSx5qd17mT79W8sU9P2cGq4Ts6gELKvPYYCJdHr7Yon9Nw/1p1hop8Fa+r4tb68DaTb6XnD93hZnUp+/zapyZ7wlhX2kiF/4p2NKmUAm16RiJKyPJcdYhHAm93+V3sw4Gxvk9quOAG6bUydyympRHpj7/fXwj6BeSnpaZCIu2c/W2mhSBskx2YhyljItZ5f1w76pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvQxHKR7bVhXAiIo+UNMXvhonp/Zod6K8e/8LZ2wW2k=;
 b=687BiGV6e9JkWHl1wBhFFxtAtscUhs7g2WIQM66SjJL8kNKNZMhhLs8dXk0nO838y0OnOBf9r9azzVeouJvp8Jge5wvKLxfYUpSWApSYscsZaT2ZQAzanjbT97MSu/b03pa6prJIon3tHCAmjl0c3PipFaYPwHbN990uzvKA8EY=
Received: from LV3PR07MB10364.namprd07.prod.outlook.com
 (2603:10b6:408:237::13) by DM8PR07MB8886.namprd07.prod.outlook.com
 (2603:10b6:8:14::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 06:43:03 +0000
Received: from LV3PR07MB10364.namprd07.prod.outlook.com
 ([fe80::1287:7d37:f51d:6103]) by LV3PR07MB10364.namprd07.prod.outlook.com
 ([fe80::1287:7d37:f51d:6103%4]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 06:43:02 +0000
From: Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
        "vkoul@kernel.org"
	<vkoul@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "rogerq@kernel.org"
	<rogerq@kernel.org>,
        "thomas.richard@bootlin.com"
	<thomas.richard@bootlin.com>,
        "theo.lebrun@bootlin.com"
	<theo.lebrun@bootlin.com>,
        "robh@kernel.org" <robh@kernel.org>
CC: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "srk@ti.com" <srk@ti.com>, Milind
 Parab <mparab@cadence.com>
Subject: RE: [PATCH v2] phy: cadence-torrent: add support for three or more
 links using 2 protocols
Thread-Topic: [PATCH v2] phy: cadence-torrent: add support for three or more
 links using 2 protocols
Thread-Index: AQHa0sA3kA4lXImb8k6CWkEEYZDi1bHxDE6Q
Date: Thu, 11 Jul 2024 06:43:01 +0000
Message-ID: 
 <LV3PR07MB1036463AB8AB5D38D003175E6C5A52@LV3PR07MB10364.namprd07.prod.outlook.com>
References: <20240710115624.3232925-1-s-vadapalli@ti.com>
In-Reply-To: <20240710115624.3232925-1-s-vadapalli@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHNqYWtoYWRlXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctY2VjOTc3YmEtM2Y1MC0xMWVmLWJjMjItY2M5NmU1YjczNTFhXGFtZS10ZXN0XGNlYzk3N2JiLTNmNTAtMTFlZi1iYzIyLWNjOTZlNWI3MzUxYWJvZHkudHh0IiBzej0iMzM0MTAiIHQ9IjEzMzY1MTUzNzc4MTQwNzg3MiIgaD0iRmZiMjRiWm1rM1JLQ1BVamI2YW1MaWIrbHlzPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR07MB10364:EE_|DM8PR07MB8886:EE_
x-ms-office365-filtering-correlation-id: 7c3a45e7-bfb5-4745-963d-08dca174b5ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?E6sARFLfX8rkkOT4C7Ofr0jUolE/QE1jpfYtxri5Xmi/cW1uKBLnyo/tmVtO?=
 =?us-ascii?Q?6otcpsFQ74BRiLeFxd6Eyz6xyh3uBm/6TY4ddl5zCi5bbfNzYga97kkC4UPt?=
 =?us-ascii?Q?tkQB7l/WH1DK5+AZOgGTkU7jqemdNaowCwqWylQvXp17wmazQl9X2vVGp/oY?=
 =?us-ascii?Q?/Jjx8hpXkVqdfTBuJT4I371XFVCwBoGJc2Uv5sSDsVLZ4uVGbIaEfHhgkKpA?=
 =?us-ascii?Q?gOekFjpM3l+ezIluG7ucbydckMyOFzWIC28jkpBkxiY44t7U47ib2mBipwWi?=
 =?us-ascii?Q?peHPbW+wuuFl7Xqv354G+ODWU9Ym5gknpLaPPzMi+XTwQ5iLnRl/85cPspkv?=
 =?us-ascii?Q?+fvdd0YO4e3IS11nXdq9ymgu2DZ9Xt4tCp6v+u/x4iIThwGYbTBRk4fPM5Dx?=
 =?us-ascii?Q?hIbzgnwsz5iBl2fNnErw5lHdcbSukZjCdyEwd8wCHfaIp5ve3/jBgKRGY9Nt?=
 =?us-ascii?Q?y7XDCpxUTNoDOA5X+lQdGT1hcjSSle4pTOdUiEJrJmZvewB2YHUu0aBygDyX?=
 =?us-ascii?Q?cIn5L4gCa0cOea6iY4Wz6A6Z/Vah44CjgDqbBqiRaR37tXFtBJ2yuqKSE9RE?=
 =?us-ascii?Q?oS55DpW40ri0Cbp+FqXbCnbq/Mz1dvI1NP+sdv8ob+1y6S4BpsccmI3ScPen?=
 =?us-ascii?Q?5xYXMdTHWdJjjB7ouSofOWm04xjXhxwqYavTS9Rgipek2WAx1ucY/U+2JSef?=
 =?us-ascii?Q?BC6FBLNEahJWvCEe2XGApDxRw0bv4X7Ts4/oVI1mzDOqv0Te+4W3SlNp8jZ5?=
 =?us-ascii?Q?B3El2AKGwwZ0+lXDoABR7c4dJbLgILsdkPkfje2C5fiU9cynZfN2+7HaZCgj?=
 =?us-ascii?Q?puXAUg5BLCHqz7KfyOVJdzpJcNZgZR+uI3bmE8hCYaZvIim/C1zagGnVbiCn?=
 =?us-ascii?Q?3vrs/YMpDGTkK4PX3jObq+iRhHhD6jsWUyckmroU/CzpyKSAMa7gOT2vhQ38?=
 =?us-ascii?Q?TF6LwH4O7BvW0/WMl+AlLg1bJFq3P/itXDv1AeZ3em+B7H5C6etDShV3o+yj?=
 =?us-ascii?Q?3JtcZtA8CDyf4PbgokysVO17CJQEe56peLdVG21niayo8aTBc/YPf2LYEC8l?=
 =?us-ascii?Q?Ya3CPAmKwF6WnEP6VzVYw8ccbaG0obQrKpDhRjAlFiMJ+vw5fX6j1SV8ZrKM?=
 =?us-ascii?Q?Yjdy4EvB+eWpUFL/9+7B6680/7YWyK40CV7VwcQgnIShsPW9Po/QU8RdqtZF?=
 =?us-ascii?Q?ycItX92NNP8SkAvhzmddTOzbyFx1QePFyIYw5naW/19zgsPQtpvhJrsQk83j?=
 =?us-ascii?Q?HeO4GXP2uhG3zaSUPzwnmFYhxY5VekJ62Vsb+dJMqS6U6xWaJY1sjpgUncgS?=
 =?us-ascii?Q?kbIKfZhpxe015Kil60ocAlgwrrK8ItCOVt1wpyPmhOgySCOmj/XWvNp1kyjo?=
 =?us-ascii?Q?yrHgMrY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR07MB10364.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?vRsHBJ/Nz1pu+PP0ymJ++lThpIpOotMFk1gyjC83IlAB32xCnMzrlY0yrP7A?=
 =?us-ascii?Q?jxU93fIjm0Hu5yIvtctoWEf4peDEj+dN3FVW4eJtkOXJgd3YBQM+XaI+i8Og?=
 =?us-ascii?Q?0H65ZYIcSYAFY8VJphyGVnNGdljWvlQ2r8tgWDxS82X4FiR48VP7ViyZnBHL?=
 =?us-ascii?Q?dyuFS9Sd0tKmNwMyyTiH87IsKqWQ9ZcKVLVbt4tiZ0kzFwDnOwP8vIb1CCk2?=
 =?us-ascii?Q?QasqDDYvGu5BKODpL+fj4jDT/v5Cca0dCZmlfTXAMONgRuBs1aai8BiHg2jn?=
 =?us-ascii?Q?BUwZ/42e3aJ0tracEPpDbd5mt7Gdn3mofFDKO1GtK1DTzg+owdGvFd1mUaLw?=
 =?us-ascii?Q?b2fsPqG937c/19NSSL99jitVQp85VFrDNLcTKNlDmGx/fX9D9W/s3G+698q1?=
 =?us-ascii?Q?9owxk4bGNfy8wDj+b3OIhnavT4D+yAbA3E8I2S3X8x/xTdjmagKsptMGk5As?=
 =?us-ascii?Q?b2QBlk52ORHLKZPd0fNUcLTc5E6bMsr2wT8I7l23zOHoEqheM6rHR1EagEXR?=
 =?us-ascii?Q?UfLN9K5WmUVkHoNDpnhvurJS4VTM02iPtbvkrdpXTldhH5WxlofCIAFQMiiB?=
 =?us-ascii?Q?7P7VzhEW8WDfjzJjz6xBcnJgNJkFgejRB5Q0VydEEx3+Uc0H9iwP4cm0iVYI?=
 =?us-ascii?Q?+UFarPrK5K+QsyGPM8YodsMgZk68W6e05/AkZJRzbOV5AFRvpuE+p3rynmpc?=
 =?us-ascii?Q?A8KUmiG42FUPVcywv0fZKqrh3rMW9sf65efNgD/qOJnIWSjRZ8/oO7xaLJdk?=
 =?us-ascii?Q?jgF9fojp5IwmlXvf8QMyqyOnwFJRbq4CIDNexgZMVbW/EvSV4wE5X4oV7IGA?=
 =?us-ascii?Q?gg7Mvl4duIJPhaBXuHFpb9Smu5Bxat6CGvN9WRdlTjkm/g51is/P7eYFAXnm?=
 =?us-ascii?Q?f6zXKd+7J4Mi/L/bVQV+2WQeBR6eSJh/gBVFAIvUOqsaxbUqc3dZ15JupJnd?=
 =?us-ascii?Q?z8GIZ7QRY0f2vpNRUM2F/ecmeOoF7DWjYu0h/+unPvYjWdnl6Y2gQZKiU9EQ?=
 =?us-ascii?Q?hiTd/a4RsrxogO8mVKMcPYl1BL6E0mtrqiGhFo7B1tax4JZ+OgBrD7ARhSI7?=
 =?us-ascii?Q?DaDZE5HVyMwpcVYzJbuAVN6rPV43Txy6uqZwSe9CuG49m37hhpGwKY4gn+JR?=
 =?us-ascii?Q?XWxRqglGKDgeBalgTepDaLuuwixwsliRcxxd+mMFe69pO+l8iW+YW5IMjkiR?=
 =?us-ascii?Q?vojPfKqwsIwxSOeKSQMh4BOZ0f64Dyb4LPyjhN8ZpkZtu12nzZQd116I6i35?=
 =?us-ascii?Q?E7TxTaxx0fnmiyBOSyNc8QKMho2v6ML3F6eMFGA4/rhFiAJBBUmfJlpj5iFr?=
 =?us-ascii?Q?V7h81fEWy3fz9WhoKN8zN+y+H2HRZs5bt8MNngdSEg41JQ6whMRErSp9XUw8?=
 =?us-ascii?Q?6a4OXEbbbk3BWXz76T2HuJXryz6/rFlETO8W/ZT2pOBF+00iipLkX6oKNRnU?=
 =?us-ascii?Q?DJkdryicfRPnh7m2ozdPlZ2qTatNN0NUWWlWesp7H4Nj1JlEK/arqkBTjezI?=
 =?us-ascii?Q?exgcAhdH5+38owsTE9tbYZT1xcDymIUp3eaiqLhl5qsBhla3X8AHW+6zcSUS?=
 =?us-ascii?Q?2TxL4p/CxIxEZcsLHozvdwLgSNi/W8qwXqr5pFGZGJK9UITcWvYZVrzotaVe?=
 =?us-ascii?Q?xQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR07MB10364.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3a45e7-bfb5-4745-963d-08dca174b5ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 06:43:02.0005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/3ODlPAV3QgriCfNNvJ+OAeQFDeg8aF7M9DBPj6Tm9w+buZXDVic8fm887TskWwQ7LascRxW1dZAMSwVwpm0lKf02BRmeLdyi0NW8Ujw0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR07MB8886
X-Proofpoint-GUID: US6TJaa5zuoZzzeMBB2gayqRLB7nSXNQ
X-Proofpoint-ORIG-GUID: US6TJaa5zuoZzzeMBB2gayqRLB7nSXNQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_03,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110044

Hi Siddharth,

> -----Original Message-----
> From: Siddharth Vadapalli <s-vadapalli@ti.com>
> Sent: Wednesday, July 10, 2024 5:26 PM
> To: vkoul@kernel.org; kishon@kernel.org; p.zabel@pengutronix.de; Swapnil
> Kashinath Jakhade <sjakhade@cadence.com>; rogerq@kernel.org;
> thomas.richard@bootlin.com; theo.lebrun@bootlin.com; robh@kernel.org
> Cc: linux-phy@lists.infradead.org; linux-kernel@vger.kernel.org; linux-ar=
m-
> kernel@lists.infradead.org; srk@ti.com; s-vadapalli@ti.com
> Subject: [PATCH v2] phy: cadence-torrent: add support for three or more l=
inks
> using 2 protocols
>=20
> EXTERNAL MAIL
>=20
>=20
> The Torrent SERDES can support at most two different protocols. This only
> mandates that the device-tree sub-nodes expressing the configuration shou=
ld
> describe links with at-most two different protocols.
>=20
> The existing implementation however imposes an artificial constraint that
> allows only two links (device-tree sub-nodes). As long as at-most two
> protocols are chosen, using more than two links to describe them in an
> alternating configuration is still a valid configuration of the Torrent
> SERDES.
>=20
> A 3-Link 2-Protocol configuration of the 4-Lane SERDES can be:
> Lane 0 =3D> Protocol 1 =3D> Link 1
> Lane 1 =3D> Protocol 1 =3D> Link 1
> Lane 2 =3D> Protocol 2 =3D> Link 2
> Lane 3 =3D> Protocol 1 =3D> Link 3
>=20
> A 4-Link 2-Protocol configuration of the 4-Lane SERDES can be:
> Lane 0 =3D> Protocol 1 =3D> Link 1
> Lane 1 =3D> Protocol 2 =3D> Link 2
> Lane 2 =3D> Protocol 1 =3D> Link 3
> Lane 3 =3D> Protocol 2 =3D> Link 4
>=20
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>=20
> Hello,
>=20
> This patch is based on linux-next tagged next-20240710.
> Patch has been sanity tested and tested for functionality in the followin=
g
> configurations with the Torrent SERDES0 on J7200-EVM:
> 1. PCIe (Lanes 0 and 1) + QSGMII (Lane 2)
>    =3D> 2 protocols, 2 links
> 2. PCIe (Lane0 as 1 Link) + PCIe (Lane 1 as 1 Link)
>    =3D> 1 protocol, 2 links
> 3. PCIe (Lanes 0 and 1) + QSGMII (Lane 2) + PCIe (Lane 3)
>    =3D> 2 protocols, 3 links
>=20
> v1:
> https://urldefense.com/v3/__https://lore.kernel.org/r/20240709120703.2716=
3
> 97-1-s-vadapalli@ti.com/__;!!EHscmS1ygiU1lA!HVLtdWbkUa1JK0NIXiJM7F-
> Db2kR5c-mgeDMtqa4i7c8-efmAsDWYAloP0KmI6OOx2NKr7v39FZx5hG8bg$
> Changes since v1:
> - A multilink configuration doesn't necessarily imply two protocols
>   since a single protocol may be split across links as follows:
>   Lane 0 =3D> Protocol 1
>   Lane 1 =3D> Unused
>   Lane 2 =3D> Protocol 1
>   Lane 3 =3D> Unused
>   which corresponds to two links and therefore two sub-nodes. In such a
>   case, treat it as two single-link configurations performed sequentially
>   which happens to be the case prior to this patch. To address this,
>   handle the case where cdns_torrent_phy_configure_multilink() can be
>   invoked for a single protocol with multiple sub-nodes (links) by
>   erroring out only when the number of protocols is strictly greater
>   than two, followed by handling the configuration similar to how it was
>   done prior to this patch.

The assumption here that "a single protocol when split across links is to b=
e
considered as single-link configurations performed sequentially" is not alw=
ays
correct.
e.g. If there are 2 PCIe links, then this is a case of 'Multilink PCIe' and=
 not 2 separate
'single link PCIe'. Multilink PCIe has different PLL configurations than fo=
r single link
PCIe resulting in different register configurations.
Also, for multi-protocol case, in cdns_torrent_phy_configure_multilink() fu=
nction,
the existing implementation considers this as multilink case of combination=
 of 2
protocols which has different register config than single link of each prot=
ocol.

>=20
> Regards,
> Siddharth.
>=20
>  drivers/phy/cadence/phy-cadence-torrent.c | 252 ++++++++++++----------
>  1 file changed, 136 insertions(+), 116 deletions(-)
>=20
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c
> b/drivers/phy/cadence/phy-cadence-torrent.c
> index 56ce82a47f88..a6d0082e448d 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -351,6 +351,7 @@ struct cdns_torrent_phy {
>  	void __iomem *sd_base; /* SD0801 registers base */
>  	u32 max_bit_rate; /* Maximum link bit rate to use (in Mbps) */
>  	u32 dp_pll;
> +	u32 protocol_bitmask;
>  	struct reset_control *phy_rst;
>  	struct reset_control *apb_rst;
>  	struct device *dev;
> @@ -2475,21 +2476,32 @@ int cdns_torrent_phy_configure_multilink(struct
> cdns_torrent_phy *cdns_phy)
>  	struct cdns_reg_pairs *reg_pairs;
>  	enum cdns_torrent_ssc_mode ssc;
>  	struct regmap *regmap;
> -	u32 num_regs;
> +	u32 num_regs, num_protocols, protocol;
>=20
> -	/* Maximum 2 links (subnodes) are supported */
> -	if (cdns_phy->nsubnodes !=3D 2)
> +	num_protocols =3D hweight32(cdns_phy->protocol_bitmask);
> +	/* Maximum 2 protocols are supported */
> +	if (num_protocols > 2) {
>  		return -EINVAL;
> -
> -	phy_t1 =3D cdns_phy->phys[0].phy_type;
> -	phy_t2 =3D cdns_phy->phys[1].phy_type;
> +	} else if (num_protocols =3D=3D 2) {
> +		phy_t1 =3D fns(cdns_phy->protocol_bitmask, 0);
> +		phy_t2 =3D fns(cdns_phy->protocol_bitmask, 1);
> +	} else {
> +		phy_t1 =3D fns(cdns_phy->protocol_bitmask, 0);
> +		/**
> +		 * For a single protocol split across multiple links,
> +		 * assign TYPE_NONE to phy_t2 for configuring each link
> +		 * identical to a single-link configuration with a single
> +		 * protocol.
> +		 */
> +		phy_t2 =3D TYPE_NONE;

As mentioned above, assuming phy_t2 =3D TYPE_NONE is not correct here.

FYI. I have shared few patches to TI earlier removing the constraint of Max=
imum 2 links (subnodes)
in the driver specifically for Multilink PCIe cases.
Please check first 4 patches in link below.
https://github.com/t-c-collab/linux/commits/ti-linux-6.1.y-torrent-multi-pc=
ie-sgmii-v1

Thanks & regards,
Swapnil

> +	}
>=20
>  	/**
>  	 * First configure the PHY for first link with phy_t1. Get the array
>  	 * values as [phy_t1][phy_t2][ssc].
>  	 */
> -	for (node =3D 0; node < cdns_phy->nsubnodes; node++) {
> -		if (node =3D=3D 1) {
> +	for (protocol =3D 0; protocol < num_protocols; protocol++) {
> +		if (protocol =3D=3D 1) {
>  			/**
>  			 * If first link with phy_t1 is configured, then
>  			 * configure the PHY for second link with phy_t2.
> @@ -2499,130 +2511,136 @@ int cdns_torrent_phy_configure_multilink(struct
> cdns_torrent_phy *cdns_phy)
>  			swap(ref_clk, ref_clk1);
>  		}
>=20
> -		mlane =3D cdns_phy->phys[node].mlane;
> -		ssc =3D cdns_phy->phys[node].ssc_mode;
> -		num_lanes =3D cdns_phy->phys[node].num_lanes;
> +		for (node =3D 0; node < cdns_phy->nsubnodes; node++) {
> +			if (cdns_phy->phys[node].phy_type !=3D phy_t1)
> +				continue;
>=20
> -		/**
> -		 * PHY configuration specific registers:
> -		 * link_cmn_vals depend on combination of PHY types being
> -		 * configured and are common for both PHY types, so array
> -		 * values should be same for [phy_t1][phy_t2][ssc] and
> -		 * [phy_t2][phy_t1][ssc].
> -		 * xcvr_diag_vals also depend on combination of PHY types
> -		 * being configured, but these can be different for particular
> -		 * PHY type and are per lane.
> -		 */
> -		link_cmn_vals =3D cdns_torrent_get_tbl_vals(&init_data-
> >link_cmn_vals_tbl,
> -							  CLK_ANY, CLK_ANY,
> -							  phy_t1, phy_t2,
> ANY_SSC);
> -		if (link_cmn_vals) {
> -			reg_pairs =3D link_cmn_vals->reg_pairs;
> -			num_regs =3D link_cmn_vals->num_regs;
> -			regmap =3D cdns_phy->regmap_common_cdb;
> +			mlane =3D cdns_phy->phys[node].mlane;
> +			ssc =3D cdns_phy->phys[node].ssc_mode;
> +			num_lanes =3D cdns_phy->phys[node].num_lanes;
>=20
>  			/**
> -			 * First array value in link_cmn_vals must be of
> -			 * PHY_PLL_CFG register
> +			 * PHY configuration specific registers:
> +			 * link_cmn_vals depend on combination of PHY types
> being
> +			 * configured and are common for both PHY types, so
> array
> +			 * values should be same for [phy_t1][phy_t2][ssc] and
> +			 * [phy_t2][phy_t1][ssc].
> +			 * xcvr_diag_vals also depend on combination of PHY
> types
> +			 * being configured, but these can be different for
> particular
> +			 * PHY type and are per lane.
>  			 */
> -			regmap_field_write(cdns_phy->phy_pll_cfg,
> -					   reg_pairs[0].val);
> +			link_cmn_vals =3D cdns_torrent_get_tbl_vals(&init_data-
> >link_cmn_vals_tbl,
> +								  CLK_ANY,
> CLK_ANY,
> +								  phy_t1,
> phy_t2, ANY_SSC);
> +			if (link_cmn_vals) {
> +				reg_pairs =3D link_cmn_vals->reg_pairs;
> +				num_regs =3D link_cmn_vals->num_regs;
> +				regmap =3D cdns_phy->regmap_common_cdb;
>=20
> -			for (i =3D 1; i < num_regs; i++)
> -				regmap_write(regmap, reg_pairs[i].off,
> -					     reg_pairs[i].val);
> -		}
> +				/**
> +				 * First array value in link_cmn_vals must be of
> +				 * PHY_PLL_CFG register
> +				 */
> +				regmap_field_write(cdns_phy->phy_pll_cfg,
> +						   reg_pairs[0].val);
>=20
> -		xcvr_diag_vals =3D cdns_torrent_get_tbl_vals(&init_data-
> >xcvr_diag_vals_tbl,
> -							   CLK_ANY, CLK_ANY,
> -							   phy_t1, phy_t2,
> ANY_SSC);
> -		if (xcvr_diag_vals) {
> -			reg_pairs =3D xcvr_diag_vals->reg_pairs;
> -			num_regs =3D xcvr_diag_vals->num_regs;
> -			for (i =3D 0; i < num_lanes; i++) {
> -				regmap =3D cdns_phy->regmap_tx_lane_cdb[i +
> mlane];
> -				for (j =3D 0; j < num_regs; j++)
> -					regmap_write(regmap,
> reg_pairs[j].off,
> -						     reg_pairs[j].val);
> +				for (i =3D 1; i < num_regs; i++)
> +					regmap_write(regmap,
> reg_pairs[i].off,
> +						     reg_pairs[i].val);
>  			}
> -		}
>=20
> -		/* PHY PCS common registers configurations */
> -		pcs_cmn_vals =3D cdns_torrent_get_tbl_vals(&init_data-
> >pcs_cmn_vals_tbl,
> -							 CLK_ANY, CLK_ANY,
> -							 phy_t1, phy_t2,
> ANY_SSC);
> -		if (pcs_cmn_vals) {
> -			reg_pairs =3D pcs_cmn_vals->reg_pairs;
> -			num_regs =3D pcs_cmn_vals->num_regs;
> -			regmap =3D cdns_phy->regmap_phy_pcs_common_cdb;
> -			for (i =3D 0; i < num_regs; i++)
> -				regmap_write(regmap, reg_pairs[i].off,
> -					     reg_pairs[i].val);
> -		}
> +			xcvr_diag_vals =3D cdns_torrent_get_tbl_vals(&init_data-
> >xcvr_diag_vals_tbl,
> +								   CLK_ANY,
> CLK_ANY,
> +								   phy_t1,
> phy_t2, ANY_SSC);
> +			if (xcvr_diag_vals) {
> +				reg_pairs =3D xcvr_diag_vals->reg_pairs;
> +				num_regs =3D xcvr_diag_vals->num_regs;
> +				for (i =3D 0; i < num_lanes; i++) {
> +					regmap =3D cdns_phy-
> >regmap_tx_lane_cdb[i + mlane];
> +					for (j =3D 0; j < num_regs; j++)
> +						regmap_write(regmap,
> reg_pairs[j].off,
> +							     reg_pairs[j].val);
> +				}
> +			}
>=20
> -		/* PHY PMA common registers configurations */
> -		phy_pma_cmn_vals =3D cdns_torrent_get_tbl_vals(&init_data-
> >phy_pma_cmn_vals_tbl,
> -							     CLK_ANY, CLK_ANY,
> -							     phy_t1, phy_t2,
> ANY_SSC);
> -		if (phy_pma_cmn_vals) {
> -			reg_pairs =3D phy_pma_cmn_vals->reg_pairs;
> -			num_regs =3D phy_pma_cmn_vals->num_regs;
> -			regmap =3D cdns_phy->regmap_phy_pma_common_cdb;
> -			for (i =3D 0; i < num_regs; i++)
> -				regmap_write(regmap, reg_pairs[i].off,
> -					     reg_pairs[i].val);
> -		}
> +			/* PHY PCS common registers configurations */
> +			pcs_cmn_vals =3D cdns_torrent_get_tbl_vals(&init_data-
> >pcs_cmn_vals_tbl,
> +								 CLK_ANY,
> CLK_ANY,
> +								 phy_t1,
> phy_t2, ANY_SSC);
> +			if (pcs_cmn_vals) {
> +				reg_pairs =3D pcs_cmn_vals->reg_pairs;
> +				num_regs =3D pcs_cmn_vals->num_regs;
> +				regmap =3D cdns_phy-
> >regmap_phy_pcs_common_cdb;
> +				for (i =3D 0; i < num_regs; i++)
> +					regmap_write(regmap,
> reg_pairs[i].off,
> +						     reg_pairs[i].val);
> +			}
>=20
> -		/* PMA common registers configurations */
> -		cmn_vals =3D cdns_torrent_get_tbl_vals(&init_data-
> >cmn_vals_tbl,
> -						     ref_clk, ref_clk1,
> -						     phy_t1, phy_t2, ssc);
> -		if (cmn_vals) {
> -			reg_pairs =3D cmn_vals->reg_pairs;
> -			num_regs =3D cmn_vals->num_regs;
> -			regmap =3D cdns_phy->regmap_common_cdb;
> -			for (i =3D 0; i < num_regs; i++)
> -				regmap_write(regmap, reg_pairs[i].off,
> -					     reg_pairs[i].val);
> -		}
> +			/* PHY PMA common registers configurations */
> +			phy_pma_cmn_vals =3D
> +				cdns_torrent_get_tbl_vals(&init_data-
> >phy_pma_cmn_vals_tbl,
> +							  CLK_ANY, CLK_ANY,
> phy_t1, phy_t2,
> +							  ANY_SSC);
> +			if (phy_pma_cmn_vals) {
> +				reg_pairs =3D phy_pma_cmn_vals->reg_pairs;
> +				num_regs =3D phy_pma_cmn_vals->num_regs;
> +				regmap =3D cdns_phy-
> >regmap_phy_pma_common_cdb;
> +				for (i =3D 0; i < num_regs; i++)
> +					regmap_write(regmap,
> reg_pairs[i].off,
> +						     reg_pairs[i].val);
> +			}
>=20
> -		/* PMA TX lane registers configurations */
> -		tx_ln_vals =3D cdns_torrent_get_tbl_vals(&init_data-
> >tx_ln_vals_tbl,
> -						       ref_clk, ref_clk1,
> -						       phy_t1, phy_t2, ssc);
> -		if (tx_ln_vals) {
> -			reg_pairs =3D tx_ln_vals->reg_pairs;
> -			num_regs =3D tx_ln_vals->num_regs;
> -			for (i =3D 0; i < num_lanes; i++) {
> -				regmap =3D cdns_phy->regmap_tx_lane_cdb[i +
> mlane];
> -				for (j =3D 0; j < num_regs; j++)
> -					regmap_write(regmap,
> reg_pairs[j].off,
> -						     reg_pairs[j].val);
> +			/* PMA common registers configurations */
> +			cmn_vals =3D cdns_torrent_get_tbl_vals(&init_data-
> >cmn_vals_tbl,
> +							     ref_clk, ref_clk1,
> +							     phy_t1, phy_t2,
> ssc);
> +			if (cmn_vals) {
> +				reg_pairs =3D cmn_vals->reg_pairs;
> +				num_regs =3D cmn_vals->num_regs;
> +				regmap =3D cdns_phy->regmap_common_cdb;
> +				for (i =3D 0; i < num_regs; i++)
> +					regmap_write(regmap,
> reg_pairs[i].off,
> +						     reg_pairs[i].val);
>  			}
> -		}
>=20
> -		/* PMA RX lane registers configurations */
> -		rx_ln_vals =3D cdns_torrent_get_tbl_vals(&init_data-
> >rx_ln_vals_tbl,
> -						       ref_clk, ref_clk1,
> -						       phy_t1, phy_t2, ssc);
> -		if (rx_ln_vals) {
> -			reg_pairs =3D rx_ln_vals->reg_pairs;
> -			num_regs =3D rx_ln_vals->num_regs;
> -			for (i =3D 0; i < num_lanes; i++) {
> -				regmap =3D cdns_phy->regmap_rx_lane_cdb[i +
> mlane];
> -				for (j =3D 0; j < num_regs; j++)
> -					regmap_write(regmap,
> reg_pairs[j].off,
> -						     reg_pairs[j].val);
> +			/* PMA TX lane registers configurations */
> +			tx_ln_vals =3D cdns_torrent_get_tbl_vals(&init_data-
> >tx_ln_vals_tbl,
> +							       ref_clk, ref_clk1,
> +							       phy_t1, phy_t2,
> ssc);
> +			if (tx_ln_vals) {
> +				reg_pairs =3D tx_ln_vals->reg_pairs;
> +				num_regs =3D tx_ln_vals->num_regs;
> +				for (i =3D 0; i < num_lanes; i++) {
> +					regmap =3D cdns_phy-
> >regmap_tx_lane_cdb[i + mlane];
> +					for (j =3D 0; j < num_regs; j++)
> +						regmap_write(regmap,
> reg_pairs[j].off,
> +							     reg_pairs[j].val);
> +				}
>  			}
> -		}
>=20
> -		if (phy_t1 =3D=3D TYPE_DP) {
> -			ret =3D cdns_torrent_dp_get_pll(cdns_phy, phy_t2);
> -			if (ret)
> -				return ret;
> -		}
> +			/* PMA RX lane registers configurations */
> +			rx_ln_vals =3D cdns_torrent_get_tbl_vals(&init_data-
> >rx_ln_vals_tbl,
> +							       ref_clk, ref_clk1,
> +							       phy_t1, phy_t2,
> ssc);
> +			if (rx_ln_vals) {
> +				reg_pairs =3D rx_ln_vals->reg_pairs;
> +				num_regs =3D rx_ln_vals->num_regs;
> +				for (i =3D 0; i < num_lanes; i++) {
> +					regmap =3D cdns_phy-
> >regmap_rx_lane_cdb[i + mlane];
> +					for (j =3D 0; j < num_regs; j++)
> +						regmap_write(regmap,
> reg_pairs[j].off,
> +							     reg_pairs[j].val);
> +				}
> +			}
>=20
> -		reset_control_deassert(cdns_phy->phys[node].lnk_rst);
> +			if (phy_t1 =3D=3D TYPE_DP) {
> +				ret =3D cdns_torrent_dp_get_pll(cdns_phy,
> phy_t2);
> +				if (ret)
> +					return ret;
> +			}
> +
> +			reset_control_deassert(cdns_phy->phys[node].lnk_rst);
> +		}
>  	}
>=20
>  	/* Take the PHY out of reset */
> @@ -2826,6 +2844,7 @@ static int cdns_torrent_phy_probe(struct
> platform_device *pdev)
>  	dev_set_drvdata(dev, cdns_phy);
>  	cdns_phy->dev =3D dev;
>  	cdns_phy->init_data =3D data;
> +	cdns_phy->protocol_bitmask =3D 0;
>=20
>  	cdns_phy->sd_base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(cdns_phy->sd_base))
> @@ -3010,6 +3029,7 @@ static int cdns_torrent_phy_probe(struct
> platform_device *pdev)
>  		}
>=20
>  		cdns_phy->phys[node].phy =3D gphy;
> +		cdns_phy->protocol_bitmask |=3D BIT(cdns_phy-
> >phys[node].phy_type);
>  		phy_set_drvdata(gphy, &cdns_phy->phys[node]);
>=20
>  		node++;
> --
> 2.40.1


