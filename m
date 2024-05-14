Return-Path: <linux-kernel+bounces-178279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7D98C4B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C34281242
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854A31CA92;
	Tue, 14 May 2024 02:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z9E369+8"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E251CD2B;
	Tue, 14 May 2024 02:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655195; cv=fail; b=BB+NrZ3UBjMyo1hIE2qAWcosxQGHeONPbyT59GtqtSY0iWXyogzZqUASYOqh6AX//bWDmzI0T0DbSKwOXwM65xBvl9t5Tbtt18O8K4fONWW1yphq+xFZmLxlZw0UXVoq8qgpk5jjtjljgLeUle07ShmeoRRbv0XQu9VPmVi5x3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655195; c=relaxed/simple;
	bh=DxaPOmQqCPZ4YEkE86X3qM3J7PvJvkfckve5yw6dSXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b2ZTIUnKqGrMz/3vFRzFhpt1LytSiETmzHMfWnjFURn56Igca8SjQQadJsWpCb6LiAw/jT2d2aYJeBtHg2vpKTc81sLQKZU2kl/eBXEVW0tMWg/2fcf0LEO2BdwStvSA1DwhjUlShuPikOjsO0/o/IPwFX1HVdTkumqpblFi5WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z9E369+8; arc=fail smtp.client-ip=40.107.7.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdnujDWMbIiUEWn6VsLmje6/72psqOfnS8vpw9vJD0tMfgpsrU+3U5q7U18s2CLJWvLmq/YFW4xLsK3/6gvcQzf7Q/wQu3xhcYoGM52sy1imyPZHN1HpdZ6APz5+U0bsWlA8u3UhBJ2RbIWN+rDbuUhIa0vOgL3aJqOO1h4l65hlcTDqSpRvEoJaQ5EMehKWcSwmq+IM7kyKIc86gg+c2c7ox14SxYOX0dfxjhJdX07ybF0BnFbHdoMomAyCqmTORXo3PqAKaApXCZq5ANAhBc82Fms3DRpzfLWWCTogJPNOx09c5Ih2Tq4H+I6bYZFU0/msNoECY60g5EqwL9V5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJcT7rH+g7mFhto3uv9dw4tblF+am7as6L62JDX5NDw=;
 b=kHDB5HjyRRy7Qn8znoNiCVsi4tZtm/y5duC72B9exDG31yUYXC/Iar8ocBdG2RjCOMi6zYmAwpO2cfKsaecPqEaQngDQLtTx+T297/DBot3pd1rbfm5TA/ijpS02IN528nyWaybGPkiyZZRFMm/ynWMTQek1vAlImhPmVk3Jivdmjd9Y8LYfGEdw5W+gXn3VTFoDWeTUt6sNup8WmLGY758TO9RuxWIBsPYQHxCxRJxSg5hoZMOAs4IxXhJm9my+RncrHR+WolDx5R+vfKKnu7NP60e6oL5L2Em7BSpy2wO1Mnxt9lRE/3D88U/t+73s/MwQNfyl9BmhEtPWjF+NKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJcT7rH+g7mFhto3uv9dw4tblF+am7as6L62JDX5NDw=;
 b=Z9E369+89jD2U3ET2lRG7emNtvJnfzkExQjAh7xxeHJdXRbKWa6Lrs3J8di0GAwFIlwuzveNPjfiDv3wdFLv7RafTRyHxeOYT/XFe8vIT0h4rfkkgG7EFps3Labr9DFBGYYtR0gO08hpm2qMuBqPbvO1NLELi6tAHO4f3QoM6WQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8115.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 02:53:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 02:53:10 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, Guenter Roeck
	<linux@roeck-us.net>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "groeck7@gmail.com"
	<groeck7@gmail.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"jdelvare@suse.com" <jdelvare@suse.com>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3] hwmon: scmi-hwmon: implement change_mode for thermal
 zones
Thread-Topic: [PATCH V3] hwmon: scmi-hwmon: implement change_mode for thermal
 zones
Thread-Index:
 AQHaT1lW79cmzSPKCUytPMAjATcCq7DqF+KAgAAAz2CAAH0qAIAAHRkAgAACIICAAAtxAICr84uw
Date: Tue, 14 May 2024 02:53:10 +0000
Message-ID:
 <DU0PR04MB94172D2602D32AF757A72CAF88E32@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240125064422.347002-1-peng.fan@oss.nxp.com>
 <b839f83f-c8c7-4fa8-8597-bdde1b40168a@roeck-us.net>
 <DU0PR04MB9417DAD2DBB8820344FEFB07887A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <540cf4b3-ebf6-4a85-84c4-c012a69db416@roeck-us.net> <ZbKHpFRGoaQpWX16@pluto>
 <da42560b-32b2-49c6-9aeb-b7fbd5b5577c@roeck-us.net> <ZbKTBmt_BP6JRLBj@pluto>
In-Reply-To: <ZbKTBmt_BP6JRLBj@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8115:EE_
x-ms-office365-filtering-correlation-id: 7479d026-48c6-4db6-08eb-08dc73c0fd66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ae028JHcNRVCmT2PfuIGt4adxukIredk1EhpHql4hNFPNjgWTprReBFadyBD?=
 =?us-ascii?Q?YHbwXHjHt7pwesuWNjtl2AT5OFRWJch1fyqpwFLNA1A1DL2mimRHqqKokW5R?=
 =?us-ascii?Q?2AjXRjd5Gd4mkTf6ri8LBZNi6kxC1gJnS/MvapT35W5Qxg0zezSE3eFUCKpQ?=
 =?us-ascii?Q?9vZrByWLoBBfty5m0dJWlxLMxJ7YWdpk8QECZroOqqwHP0sz823gqpN2kB61?=
 =?us-ascii?Q?b9S5WzU3jFDwo4NvWdydq60NsL2g6bn9xUo04SuV+h9h4ghw5VfbgTLwJNn5?=
 =?us-ascii?Q?e8XshxkUOLkIDrXLs1JGls36OuTKMVuI32I5lEiCLIbbCGBPx/K4ravy8Vcw?=
 =?us-ascii?Q?HfrqlGxIzoMxWtr4Po8ujhe1hv+yO+hELL79IdhDcmmNOBV1qWVz8Glugxll?=
 =?us-ascii?Q?+Pqv2N9CYR4FVCV703I5AGQecOhTF1xo+EYxGpFMd+wJfOYNH/c55L04C6+n?=
 =?us-ascii?Q?uI4iubde7xbrCyIoCzHEVerbD71ORbmDtVEkcl5L2VONiN2NvfSuPLeXPSVx?=
 =?us-ascii?Q?GIPCsaBoEcTF8cnVbDGX41pD8t/rHcSW4iZMRpgp35ZOuOZKKRVpQiBWZZWC?=
 =?us-ascii?Q?OCFA/88d9E5wA7wRpxi96MVjPzzGOX5mLzgkferYKkcGQj9+l6VBQS8w9FgD?=
 =?us-ascii?Q?o9r2NNyjTbwPmhErDBKuJKBoLIwFNLh6bs3RxUlvtlrEYMCxQzG8LngzltLj?=
 =?us-ascii?Q?wTiMBizi/AQgOPSsSRvc9i2l6yZwyXcME/YjTLVRUkym659+QuHMQaEJd1Fo?=
 =?us-ascii?Q?0F2oipTHeGuBT2vC41FL6J1dqm+QvZx9HAYalilnCIvJWqje9dgscOArYq5G?=
 =?us-ascii?Q?56leb7lGSrSAQYW6J140u1HmeUKgtNwPBxJY1ABPMTIPzKAXhQWf8Fbboqtg?=
 =?us-ascii?Q?JLYw6/5FGEqjfhUn5Wp7vvDLvjkrkAp5kypwnRhwpFpVbVYozMdW07Z0LdTt?=
 =?us-ascii?Q?xOpffN3rfue7QRH+rsUn4R8Wgk6GJJZLQampuJU0kl8FKVnb5YZvKzh/Wpk5?=
 =?us-ascii?Q?jGvcruQ7KxRFt7yToLF1Hz7h/qUOH0z0CcxZiHWOfAVZxp5OdMcIicn25pmy?=
 =?us-ascii?Q?GYwxPQ+ZBmfLK1424o5Lq5tr9wYR0LB8Aft93dk4qMiqlS34imDnZW/fcrXW?=
 =?us-ascii?Q?qe2+aI12V+hA1YAHCod8NRDn2zRt3pHHcB+3kWx1wd05L0rYX1GPCNLDIg9Y?=
 =?us-ascii?Q?ryFyL+VSAVjh3G5uLxjnlGhRq+I9jDF9iiqSu4ktpXheWoYUtiJWEBp1bGUb?=
 =?us-ascii?Q?f2Zn9T0Vhw+6rOXIh0BBWIpTF/SkZ1USPgSSUUZJD6SXOE7Q1Q/4b5H40ol8?=
 =?us-ascii?Q?vvfGse18qCdRXVmnRfQcPHKit3NJXERPdkYyZaW9BbQEtw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dr5PWF7yFB3+norYy849DZOhVSywvnw7E3Y7gyJfYA9qNd+NL4JUH168KFQj?=
 =?us-ascii?Q?qCJMXzs5L2tKPya53QymOPD8sf3bbmmhSt7zmOprgFZW3dTdFPiEnOO1b/pX?=
 =?us-ascii?Q?uRZlxQWHdS8QaGNXYDunonqGD3hnr8EHbHr3oYxQc3ViD5Tiw5VNacUEtx/T?=
 =?us-ascii?Q?swVBgzcKGoqWvfO2MpDa6r2YBBiZT6ESdbx8c83IhJmJ+6P8Pt4PK9d+TL66?=
 =?us-ascii?Q?Zh6KX4DBJywKFutbLdj0vG+ZC1kd7ZdEu95l4O8ZLW1LBIVFb3VZckuMSbWM?=
 =?us-ascii?Q?Onn2rjM/QK3DtYLJDn4xi/JBvXbeqPNYgvEf1hZlkCCRG0MKdUmrmmEx47vu?=
 =?us-ascii?Q?i+QtV036sbogPOUV2eoioJmeQc+i4CNLqvjw2+uMCk4xqI608idlEtaS0lkq?=
 =?us-ascii?Q?iPjMOsUKUWfmVF3hYvhtOd2JPgEDqTUoUJVh2a7GeSXKt4BcwFvz+8lrgtpu?=
 =?us-ascii?Q?J4V0ugIl2PPkckn08rkGlG1zP9XfsNSkYKEyj4DgH1u4LVeidmmV1LB2Uei3?=
 =?us-ascii?Q?9r1gSabwOyNeD6i0W0pDwbq+Vo0gLGCftydk5UVsqJjzNG4zqMbucZKdiyCl?=
 =?us-ascii?Q?Xn06JmA1Ril/wocO5Jn+Xha4azrWXvmh7FgwXuR1+7WuBLQsPzWQI1AT0qrf?=
 =?us-ascii?Q?4EEop0ExY1DKU5pD5tpn3FFEbJQ59XK0CgZPwewq5RFgTHbPhxNc0bHUfc/5?=
 =?us-ascii?Q?jJrKc7N32xUFwTVLeVbmPFJhdozJ+1msxcYVmw+/jR81Bn+5qhg3fkCwSjHK?=
 =?us-ascii?Q?WY1aIFVBwGl5Fr56JH2//DiAZ3ZcFocHjNpAWbExJX9vF6KF2PYRFiWpUWpF?=
 =?us-ascii?Q?HhEEKVRdwqO2gXW4kHYgAhMcamkUrkXToj1Cwh+Z6R1wQbfOclCOF7pMCYCU?=
 =?us-ascii?Q?YaKzXG0cZNqE0e0Zp2plRj+G/aOtVVQ+d2F9bExZm8uXtWCB55VsjlJjsTcg?=
 =?us-ascii?Q?IaZU6+nIDUOyZ0JwRU5sTrLdqmnGpLC1s/3ipVLx9ezHAsXmlWVfWOplD5Zq?=
 =?us-ascii?Q?goZijF8etfFzHtRXKAfovTj9SQQXVZc0QtZDdXqP0VZv5mU3R1ms4UoWWH5S?=
 =?us-ascii?Q?WUZzTwRnT0/wUa+ceAWs7BkPFkaaOTry36W4WWqjZITUx6TCCKsGAP4HAq0e?=
 =?us-ascii?Q?Uxk6s+gFIESD5DDZrfgKYAFvhc+VZF3h89WNqcF5PIVyk0dgUekP60PyEWOK?=
 =?us-ascii?Q?CZUWBVAGL4gFeJpuZjcOrrC8kJF5sk9BXoeI3+llxHTGudkxdVDm4tH4q+N7?=
 =?us-ascii?Q?fM/MZgIH3n6tbah+1GyzJKLRwrSeD4VavuanC+MNTyNZhxg7baYHIWaS85oh?=
 =?us-ascii?Q?ZHXzk52aYu/ND2QZPLpurUKyWbeYa41quFYXfILzK4/HocD+WRaoo2xldwiw?=
 =?us-ascii?Q?D2OtA2Ll/ssEyUvK5p91zFkT44G0DljJOUx626TuAw2z6K/Wkz4kCFnuIQ+a?=
 =?us-ascii?Q?LbCQr5ItXDZr1ESr9tMbqQyxCnsZ5cqFvONbcnVPfZormQRdZQQekx8FUx3E?=
 =?us-ascii?Q?1JuV4N/tdOtRpuK5KL+eKNljwZ2fPLeuRAIb82kvDC5man8BYIaBRemS3vpE?=
 =?us-ascii?Q?jZsxSUb29uUF1yerPJo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7479d026-48c6-4db6-08eb-08dc73c0fd66
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 02:53:10.1845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K2H8daHNsQyirVkACOre8I0XspZF67yAeVmCEYekue1nTXiNTXiEw50vypolpEwwacpNt6O3MnBIRP4nvNUWvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8115

> Subject: Re: [PATCH V3] hwmon: scmi-hwmon: implement change_mode for
> thermal zones
>=20
> On Thu, Jan 25, 2024 at 08:16:45AM -0800, Guenter Roeck wrote:
> > On 1/25/24 08:09, Cristian Marussi wrote:
> >
> > > Agreed, but it seems that indeed here the attempt is to make sure
> > > that an accidentally disabled sensor is turned on.
> > >
> >
> > From the patch:
> >
> > +static int scmi_hwmon_thermal_change_mode(struct
> thermal_zone_device *tz,
> > +					  enum thermal_device_mode
> new_mode) {
> > ...
> > +	if (new_mode =3D=3D THERMAL_DEVICE_ENABLED)
> > +		config |=3D SCMI_SENS_CFG_SENSOR_ENABLED_MASK;
> > +	else
> > +		config &=3D ~SCMI_SENS_CFG_SENSOR_ENABLED_MASK;
> >
> > This clearly contradicts your statement. It leaves the sensor in full
> > control by the thermal subsystem. If the thermal subsystem decides to
> > turn it off, it is turned off.
>=20
> Yes, indeed, and this is wrong as you explained; what I meant is that it =
seems
> to me now after this discussion, and from the commit message, that the
> reason (and the aim of this patch) is different from how it achieves it (=
as a
> side effect)
>=20
> "The thermal sensors maybe disabled before kernel boot, so add
> change_mode  for thermal zones to support configuring the thermal sensor =
to
> enabled  state. If reading the temperature when the sensor is disabled, t=
here
> will  be error reported."
>=20
> So when I said:
>=20
> > > Agreed, but it seems that indeed here the attempt is to make sure
> > > that an accidentally disabled sensor is turned on.
>=20
> and
>=20
> >> In this case seems like the sensor is NOT supposed to be ever
> >>disabled  (not even temporarily), it it just that you want to ensure
> >>that is enabled, so I would say @Peng, should not that be done in the
> >>fw  SCMI server ? (i.e. to turn on, early on, all those resources that
> >>are
> >>  exposed to the agent and meant to be always on)
>=20
> I implied to drop this patch and instead make sure the visible-and-always=
-
> enabled sensor is default-enabled by the SCMI server running in the firmw=
are,
> given that there won't be any need to ever disable it, from the hwmon
> interface NOR from the thermal subsystem.
>=20
> Sorry if I have not been clear (but I maybe still well-wrong anyway :D)

Sorry to bring back this old topic.

The tempsensor is disabled at boot, I will check with FW owner to enable it
by default. But the tempsensor will consume some power, if leaving
it always enabled.

Do we need to export a HWMON_T_ENABLE to temperature sensor if
leaving thermal framework only reading temp?

Thanks,
Peng.
>=20
> Thanks,
> Cristian
>=20


