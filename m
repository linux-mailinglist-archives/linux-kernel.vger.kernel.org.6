Return-Path: <linux-kernel+bounces-241656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD248927DA9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A58FB22372
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D39137748;
	Thu,  4 Jul 2024 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yKyzvvVO"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ABA2E403;
	Thu,  4 Jul 2024 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720120538; cv=fail; b=AqOA8SsXU3t1gBUIlzDuW+Hmj7m7dXwIhgVwVj6MCoaXzlzc2QOhvlKFk3c6IRKYez55JXwKYW4HgANCKNUahZZaA3Z0oEUih+V+RP4RZG2Y/D8m7vk7QqvjXQOdftajurSOizZfM4sQfVxH2N57Fe1M8Mh1+v5tR0pmF8A1MH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720120538; c=relaxed/simple;
	bh=Twb8b0VoUB+QYLqcjG/6gqvrXDeEMWlNnqXGYFWBQJc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FJP9Ni64Hi2Tk07CehOF0GohmftHQ1/P+O9bCWyw0N2SJ0Maz0ySey3e6ODmrIr1z+xR0V0Y5a74hBgyQtpAk9aybSfO+ZmBriYgGKFc8W9bvZwz1ov9BhQd88hkFL+yXvWpIgSAdRvmfUc0g9m6qtnU7rGHLFZjbVw7WTJMGvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yKyzvvVO; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPyBYvVbmYeQYQ+bMI3hdZuRGPw78wlp0+CFhf3JOqp6RzMXWTtEbcH+9Zb41xaYZvlfU9Cp8vT7gavqx67IzegZl2ihie+lalJQJeIwB4YGWR87d801kMf8+lK1kTN8ewPjI/n/OO6RNUnx7l/MsoH0I0A7LusoyNx1NfA8vl9PjmfCX5u26X7mX4VpNVCe8io8xJs0rMYShnn8D09uwHO+X6rOb6gehfB7M8mrtcXtLPF8LwNB+Q0gSCLYisB0SCNl97UKUGjmBrTeErWyIXIkMq6c6WbrGxTBHGxVj57vJq3tvAsRsBZBCeS6gwVFIypnDsqDaECrLR10iQfAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3k0PA+nG4ofwk5k36iXADVnjlR/kUlcG0CqmojhwPaY=;
 b=lr22XDlSBz7KUd+WuN3JUmWxi4bqXcIkACFl9V/wV2yckubFGnt84kkLQOoOrTxY/j7jLwcf5QuYKZPDMlOP9bUVY9drVkyBR1MKzmcFzTue4f7RAl2D9OHAXcAVgVeAOaCZvjaAYsw1LMUifMHtsQ0ZqW76Wx877512jCusTvIqX5aIkGiDMOoixsgNgIYUHdDXxXkydw9feu3mU1lHXVjPIdc0SsUvTELoM+hGvLs9xXfQx/n2Plv6uWuvGF1uaawdx/pNT0/gLy3mNBZ+GjgdC8PJvryuI57UOk2CrrCHQVsWcYX7+iw/3U58zI5RAnQtRuAsbWA7mtA+CHfpjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3k0PA+nG4ofwk5k36iXADVnjlR/kUlcG0CqmojhwPaY=;
 b=yKyzvvVOvWol4cZ34bJdBw2DQITRJtV6ltSUOCQbrxLUIJWHbCpbrV1wGCkMfg6lz1uWnreQUdlHKiDsSwvNwz0ljP8m7cZi1Tmafgv6JJMWaYGgb/rsp70wHJNK093QPu9TBQgexZsw/2g/Vy7WqKs1QwPAOwuWi192S3cZSmU=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 4 Jul
 2024 19:15:31 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%7]) with mapi id 15.20.7741.029; Thu, 4 Jul 2024
 19:15:29 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Simek, Michal"
	<michal.simek@amd.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v3] usb: dwc3: enable CCI support for AMD-xilinx DWC3
 controller
Thread-Topic: [PATCH v3] usb: dwc3: enable CCI support for AMD-xilinx DWC3
 controller
Thread-Index: AQHat99n/ZMgYQqPckOoH/M+uK1ZbLHm59WAgAA06LA=
Date: Thu, 4 Jul 2024 19:15:29 +0000
Message-ID:
 <MN0PR12MB59532C807BC5FB1F184118ADB7DE2@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1717657279-2631757-1-git-send-email-radhey.shyam.pandey@amd.com>
 <ZobH8x/ikM/yafxb@lizhi-Precision-Tower-5810>
In-Reply-To: <ZobH8x/ikM/yafxb@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DM4PR12MB5770:EE_
x-ms-office365-filtering-correlation-id: ccfadaef-3255-4c81-b11a-08dc9c5daadf
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?th60QmvqtNKLFyBXtbBNB+wRkP3T5AX465PBzi4fB92765Lbb1axYWpZbWem?=
 =?us-ascii?Q?hLi/sbLcCETFUuU1wPgrC10tbzfQWkIoC40/wuoiuPrTv7VwFnaJr76cUs/4?=
 =?us-ascii?Q?9zxxcHE7WA1lykES2CWwHYK3IS6BIe2hgLipQ6ZxA8FFSlwhdKyH1wIuSl9p?=
 =?us-ascii?Q?xTpQbodQu36E6q/GtG33Xy/YqvRnCfDlQd9wap0yH+cf669JAF9zWFKcBLQv?=
 =?us-ascii?Q?VBVDteuC7GK1mbK+rgGOSWSogLzGeHao6YS8/zHUKvq9790A1qrVfZm4KfVs?=
 =?us-ascii?Q?2PBykTo+0pNUyONi4E4iTUslZzPJrbM3uKekoD3nsRLnGjPLmp33vrObJ3g5?=
 =?us-ascii?Q?ZRr+6gDl4qB5sqUVaiFStOTAA6E97mrLIzHPv4aHRDfHLQg9+0YlBo0f+uNL?=
 =?us-ascii?Q?lP2kOgpv8ZEIViHr+JXaZaRATbQabP1Fhnx9XvyOzKseI/MoXZk3fIpcfF4O?=
 =?us-ascii?Q?ppygrUK4WI3282IuPoIHD51VRwYC/tHtpwy26S4id3qhCAfzHOqxfFqzXYPO?=
 =?us-ascii?Q?n+zhFK4vMzd6rTArTeRPPHCyxHn7sgpYyxEiOk0xaHktZn26fHjFil4LJxhw?=
 =?us-ascii?Q?k7k8dwyk8pA2z5rmw2B/rrrzYcz0x7Qk93PmJcqduN5aZI5H7rIi4Gw+dizJ?=
 =?us-ascii?Q?Aga/csqH+bRryKNLfIn7oCTPRYyhEccUQQeKcBZYEAC8fbbuAui5BVzsBToN?=
 =?us-ascii?Q?7DASYVaiJ0rcRFbwHAdbYy1Lmg4lC+brniBIBZwk66gBd5Io/SX3pBeZuv5A?=
 =?us-ascii?Q?4gaZ+jcKnLRquQyxXkQU+y9vZvrz6Ly07yQ4usfgyeyR0NReOgbkemg9O34m?=
 =?us-ascii?Q?g8vKMICCIEqcu2C1Fr/EWO3tjAQEWQ+L/BoIQ4C6FerPcvQZTdU3e/8heQ9+?=
 =?us-ascii?Q?Qw5oM2usl4AjCdxKY5vTxQYIjRw+Y+653yKfp/7NuhlKeVk1zPEXsRbN5xk1?=
 =?us-ascii?Q?CH46k4qATM5qRpqstWsoNRIT83VcaV2NGgbqrCLEjzzNW4+RHLY03xlXjQlo?=
 =?us-ascii?Q?MuuJ0U0paMPbxEEfStpdeMH0TMQAyi0koGI5M9D/bA88Q8YIqGJK24+5d4Pw?=
 =?us-ascii?Q?2dF47u7xUJz6zsEB0raHYVapfXG/cgmcBikbijMGmhwxCFiQQcxUcbGdTjhU?=
 =?us-ascii?Q?CfNGphDi5bcSGn5y9cviwGGPWuUKrc0JHmoeXSbTr+5G9c/loQjwNmV8bHEY?=
 =?us-ascii?Q?296eocIXTCGHKKyb6FR9Nzz2MEu0rjEPpakgQpRFDAAXAh0ERI06/cYJwF4j?=
 =?us-ascii?Q?0DstPFjWeINAWhzjkCKKZMbyE4wB/t/WWOzv+A66dS08E16wBAw8LToda4Tj?=
 =?us-ascii?Q?sOsPTEIV1NHZTVqed7pV4/dRagCMcrZXPP0qbJcV/6i9HYAT0A5nfDSpiT+e?=
 =?us-ascii?Q?9w8TBVA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Y/+I++U9iAXN0pHq0mmseKEgx6QjeiWYefLIidUURcgZFi0zTNUVz5DRdQ7B?=
 =?us-ascii?Q?yYa7X/rl/H1kfR0AcQhT9rDAyL+gX8zwt2ZyTOhLFmHFMZMj3oYWOwL7cQPP?=
 =?us-ascii?Q?iEoDMVUYViyRNlga+TJmcxdL/s3FwKscT6VlR/h65OhVl56V7yG8NXYtDGI3?=
 =?us-ascii?Q?ird4metYQh936svck2Y5/mNkBdOmmf50c1pe904oMQCbAnK/tJGG+5Z8ty/m?=
 =?us-ascii?Q?urXgnxD7940l4KXuSIjyIXi/Kt0EAZH6yc1O75d2j7lRp9pb+QyUHmafw4r3?=
 =?us-ascii?Q?8tgllWy+FaXTlcPAerpyzZvez5EOjpTQQD8u2SxHntEZdzIsPD5YxG6U6EtZ?=
 =?us-ascii?Q?sxyt+E20fct/0HbUK7iQKqtKKttoyYj8tYVM4FaFl53dSHGbeVSESl9/YLZs?=
 =?us-ascii?Q?vQVe9/HJHnRethjlzKRia+XVUsPsAJOX2hyg39KuDxl8PqScHOwrHae3QcQ1?=
 =?us-ascii?Q?vPlCOoQk/H9T7gY/fjxwLc0fsSTw/iBQ3ZQ1JpumWASXgStfohX0gWIx69MC?=
 =?us-ascii?Q?t+GGBDL0SM7Vtoomu6fumO6ZoXD+hIafwz/AkofHY1q8up1Y33dGCvcjbJ/Q?=
 =?us-ascii?Q?yGnYADfFzbR9sdnFdE9QeKPBw2DCZOiC+ehAFf9ReJLKHG35woxER3IeYr/g?=
 =?us-ascii?Q?rWtiOQB+q6HUw2VDwTx8WAd3xTUGgg00lDRYBEwqMsXXoXDlNfpOdxYvQchw?=
 =?us-ascii?Q?pvgoBESI+b5OaBOqhjCvXpuWdbQA5gvZ6mDreCn/JAss6t2zP8p9qIzXlsIg?=
 =?us-ascii?Q?D4LilZhSePUg34b0Yp73wSQjyUSJXskgleYM5xIYdQtb3rTbDCVusheNukEC?=
 =?us-ascii?Q?4fqQBoykfS9L0MSv2ogPZ/6oud6D0IOk1tH2lRwakfR79x8CMNoWd8fFvDoQ?=
 =?us-ascii?Q?lIDHkRvCKnKmuBEm7XbyO63I1Ui80D+NxOHPgAf/wecu9GqFU30LFoVZuNni?=
 =?us-ascii?Q?cFdv5w4yr03HM/WCz6Yia65LQElSVsp31lX8B/hUMNeeKtu95BAJ+s9mwSeA?=
 =?us-ascii?Q?DD8uEPZBFjdBYyU0tcH4c588GLJNZvUDLdqQUNKVLBsDWc1AjMwYTcXsZJ6u?=
 =?us-ascii?Q?XhiMWCZfDYq1IGCEmIEYIK0nARzpM6fTxSrTpEUQwTsYDgpvLyL//XjZBjJO?=
 =?us-ascii?Q?7G9HsMt4EtYsApBA3mqiPuDqNCjE9V2jBb93GzNj4T12uAy3MuC7MQKfvFtu?=
 =?us-ascii?Q?vuLkIQ3/xSOnqiQ+266fG7/Al31Ik0H0Y3oIyBX9tEHD03CCKQ26Iw0P5DHJ?=
 =?us-ascii?Q?qiUUnAtNx3UKiSx2mJ9BnXDXq7RysoiExUdp8gyIcbJYASYDDqmJSY2Y5Rav?=
 =?us-ascii?Q?j/rV/Xe9I0A5H0tGG4Y0iiGKXDu2DkH6supGLpA6KxWJ9okFLDA6kM2McMgo?=
 =?us-ascii?Q?BiBkUfe/I5pPFsBKK6eySV2GbG7uDlDqss8C4ME+Wdz5UKT/30tkn9t3ZhwZ?=
 =?us-ascii?Q?AdN3uXN2dDmFRMdR0OCXjrMlIya3zpWwx2tXUgSQH0X1utneScevFmWXt5va?=
 =?us-ascii?Q?5p2FE1dvemI6wPq/gCplXIPrtlmYbgN737NVyLCA+fsMCAno51FWpUGsCdTp?=
 =?us-ascii?Q?F2nI5eIgGPgQJ7PcAk8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfadaef-3255-4c81-b11a-08dc9c5daadf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 19:15:29.2056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gzLj8O4O55UQX53BBrKWTDRZ/OEuOx1XssxsjGngoMwQpd8PcsnDlOvewGp0pyI4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Thursday, July 4, 2024 9:34 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: Thinh.Nguyen@synopsys.com; gregkh@linuxfoundation.org; Simek,
> Michal <michal.simek@amd.com>; robh+dt@kernel.org;
> krzysztof.kozlowski@linaro.org; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git (AMD-
> Xilinx) <git@amd.com>
> Subject: Re: [PATCH v3] usb: dwc3: enable CCI support for AMD-xilinx DWC3
> controller
>=20
> On Thu, Jun 06, 2024 at 12:31:19PM +0530, Radhey Shyam Pandey wrote:
> > The GSBUSCFG0 register bits [31:16] are used to configure the cache
> > type settings of the descriptor and data write/read transfers
> > (Cacheable, Bufferable/Posted). When CCI is enabled in the design,
> > DWC3 core GSBUSCFG0 cache bits must be updated to support CCI enabled
> transfers in USB.
> >
> > To program GSBUSCFG0 cache bits create a software node property in
> > AMD-xilinx dwc3 glue driver and pass it to dwc3 core. The core then
> > reads this property value and configures it in dwc3_core_init()
> > sequence.
> >
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > ---
>=20
> Radhey:
>=20
> 	Do you have plan to continue work on this? We met similar case with
> this. If you have not time, I can help core.h and core.c part.

Frank: I have done the suggested changes , will test and send out in some t=
ime today.

Thanks,
Radhey=20
>=20
> Frank
>=20
> > Changes for v3:
> > In v2 review as suggested by Thinh Nguyen, switch to swnode
> > implementation for passing GSBUSCFG0 cache bits from AMD-xilinx dwc3
> > glue driver to core driver.
> >
> > Changes for v2:
> > Make GSBUSCFG0 configuration specific to AMD-xilinx platform.
> > Taken reference from existing commit ec5eb43813a4 ("usb: dwc3: core:
> > add support for realtek SoCs custom's global register start address")
> >
> > v1 link:
> > https://lore.kernel.org/all/20231013053448.11056-1-
> piyush.mehta@amd.co
> > m
> > ---
> >  drivers/usb/dwc3/core.c        | 24 ++++++++++++++++++++++++
> >  drivers/usb/dwc3/core.h        |  8 ++++++++
> >  drivers/usb/dwc3/dwc3-xilinx.c | 18 +++++++++++++++++-
> >  3 files changed, 49 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c index
> > 7ee61a89520b..159d21b25629 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/of.h>
> > +#include <linux/of_address.h>
> >  #include <linux/of_graph.h>
> >  #include <linux/acpi.h>
> >  #include <linux/pinctrl/consumer.h>
> > @@ -599,6 +600,19 @@ static void dwc3_cache_hwparams(struct dwc3
> *dwc)
> >  		parms->hwparams9 =3D dwc3_readl(dwc->regs,
> DWC3_GHWPARAMS9);  }
> >
> > +static void dwc3_config_soc_bus(struct dwc3 *dwc) {
> > +	if (of_dma_is_coherent(dwc->dev->of_node)) {
> > +		u32 reg;
> > +
> > +		reg =3D dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
> > +		reg &=3D
> ~DWC3_GSBUSCFG0_DAT_DES_RD_WR_REQINFO_MASK;
> > +		reg |=3D (dwc->acache_data_rd_wr_info <<
> > +
> 	DWC3_GSBUSCFG0_DAT_DES_RD_WR_REQINFO_SHIFT);
> > +		dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, reg);
> > +	}
> > +}
> > +
> >  static int dwc3_core_ulpi_init(struct dwc3 *dwc)  {
> >  	int intf;
> > @@ -1320,6 +1334,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
> >
> >  	dwc3_set_incr_burst_type(dwc);
> >
> > +	dwc3_config_soc_bus(dwc);
> > +
> >  	ret =3D dwc3_phy_power_on(dwc);
> >  	if (ret)
> >  		goto err_exit_phy;
> > @@ -1574,6 +1590,7 @@ static void dwc3_get_properties(struct dwc3
> *dwc)
> >  	u8			tx_max_burst_prd =3D 0;
> >  	u8			tx_fifo_resize_max_num;
> >  	const char		*usb_psy_name;
> > +	struct device		*tmpdev;
> >  	int			ret;
> >
> >  	/* default to highest possible threshold */ @@ -1716,6 +1733,13
> @@
> > static void dwc3_get_properties(struct dwc3 *dwc)
> >  	dwc->dis_split_quirk =3D device_property_read_bool(dev,
> >  				"snps,dis-split-quirk");
> >
> > +	/* Iterate over all parent nodes for finding swnode properties */
> > +	for (tmpdev =3D dwc->dev; tmpdev; tmpdev =3D tmpdev->parent) {
> > +		device_property_read_u16(tmpdev,
> > +					 "snps,acache-data-rd-wr-info",
> > +					  &dwc->acache_data_rd_wr_info);
> > +	}
> > +
> >  	dwc->lpm_nyet_threshold =3D lpm_nyet_threshold;
> >  	dwc->tx_de_emphasis =3D tx_de_emphasis;
> >
> > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h index
> > 3781c736c1a1..57b3cb739353 100644
> > --- a/drivers/usb/dwc3/core.h
> > +++ b/drivers/usb/dwc3/core.h
> > @@ -194,6 +194,10 @@
> >  #define DWC3_GSBUSCFG0_INCRBRSTENA	(1 << 0) /* undefined length
> enable */
> >  #define DWC3_GSBUSCFG0_INCRBRST_MASK	0xff
> >
> > +/* Global SoC Bus Configuration Register: AHB-prot/AXI-cache/OCP-
> ReqInfo */
> > +#define DWC3_GSBUSCFG0_DAT_DES_RD_WR_REQINFO_MASK
> 	GENMASK(31, 16)
> > +#define DWC3_GSBUSCFG0_DAT_DES_RD_WR_REQINFO_SHIFT	16
> > +
> >  /* Global Debug LSP MUX Select */
> >  #define DWC3_GDBGLSPMUX_ENDBC		BIT(15)	/* Host only
> */
> >  #define DWC3_GDBGLSPMUX_HOSTSELECT(n)	((n) & 0x3fff)
> > @@ -1153,6 +1157,9 @@ struct dwc3_scratchpad_array {
> >   * @num_ep_resized: carries the current number endpoints which have
> had its tx
> >   *		    fifo resized.
> >   * @debug_root: root debugfs directory for this device to put its file=
s in.
> > + * @acache_data_rd_wr_info: store GSBUSCFG0.DATRDREQINFO,
> DESRDREQINFO,
> > + *                          DATWRREQINFO, and DESWRREQINFO value passe=
d from
> > + *                          glue driver.
> >   */
> >  struct dwc3 {
> >  	struct work_struct	drd_work;
> > @@ -1380,6 +1387,7 @@ struct dwc3 {
> >  	int			last_fifo_depth;
> >  	int			num_ep_resized;
> >  	struct dentry		*debug_root;
> > +	u16			acache_data_rd_wr_info;
> >  };
> >
> >  #define INCRX_BURST_MODE 0
> > diff --git a/drivers/usb/dwc3/dwc3-xilinx.c
> > b/drivers/usb/dwc3/dwc3-xilinx.c index 6095f4dee6ce..f3757bfbd650
> > 100644
> > --- a/drivers/usb/dwc3/dwc3-xilinx.c
> > +++ b/drivers/usb/dwc3/dwc3-xilinx.c
> > @@ -47,6 +47,15 @@ struct dwc3_xlnx {
> >  	struct phy			*usb3_phy;
> >  };
> >
> > +static const struct property_entry dwc3_xilinx_properties[] =3D {
> > +	PROPERTY_ENTRY_U16("snps,acache-data-rd-wr-info", 0xffff),
> > +	{},
> > +};
> > +
> > +static const struct software_node dwc3_xilinx_swnode =3D {
> > +	.properties =3D dwc3_xilinx_properties, };
> > +
> >  static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool
> > mask)  {
> >  	u32 reg;
> > @@ -288,10 +297,14 @@ static int dwc3_xlnx_probe(struct
> platform_device *pdev)
> >  	if (ret)
> >  		goto err_clk_put;
> >
> > -	ret =3D of_platform_populate(np, NULL, NULL, dev);
> > +	ret =3D device_add_software_node(dev, &dwc3_xilinx_swnode);
> >  	if (ret)
> >  		goto err_clk_put;
> >
> > +	ret =3D of_platform_populate(np, NULL, NULL, dev);
> > +	if (ret)
> > +		goto err_remove_swnode;
> > +
> >  	pm_runtime_set_active(dev);
> >  	ret =3D devm_pm_runtime_enable(dev);
> >  	if (ret < 0)
> > @@ -303,6 +316,9 @@ static int dwc3_xlnx_probe(struct platform_device
> > *pdev)
> >  err_pm_set_suspended:
> >  	pm_runtime_set_suspended(dev);
> >
> > +err_remove_swnode:
> > +	device_remove_software_node(dev);
> > +
> >  err_clk_put:
> >  	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data-
> >clks);
> >
> > --
> > 2.34.1
> >

