Return-Path: <linux-kernel+bounces-283936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA1E94FAA5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 02:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA87B22269
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6E1EDF;
	Tue, 13 Aug 2024 00:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K6hkYQWs"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2068.outbound.protection.outlook.com [40.107.104.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CA480B;
	Tue, 13 Aug 2024 00:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723508806; cv=fail; b=dIXkRT5P1PQZbY/sQbIqNT38/2dalJ1/1C5bczFOmpMDWAOEfC6WWusF6K0hUfuZ3HrJy3ef1HLHlbzpbN2Tqu5IfFa6Hk8Ybel7JhmOaIFt+0FmkMlHRYRAM984MFTwtHYKwlsPVJS6/bI2i1ddKoiW31rrNvGGkMzCucqHQ04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723508806; c=relaxed/simple;
	bh=1lbn2mxx0QkLFwV8AeEe9bo/4iOM9hB86IGFfzuldN8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sh3XgLCjGmRiNZzOJ2ywYNaIr6KI9klRNimIReCquCrTBR11saek0E3tzzCArYluGG0mAwgGysloiKhAt9DMno2uIn+/weXH3oUmhHW0lGqnfUdV/nl+dR5IUFHDh93nuBjY+8PPeoaLCpvBsVriigevXSUinjMEEgDmSsOakxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K6hkYQWs; arc=fail smtp.client-ip=40.107.104.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOiAOirJCluNXxLysydfnxQggdxAOSIAz4//0AnzTASlSbBI0/0H1Gn6Ir+B/wJh4FL9QFqG87eVx4F0uz2LFi5gcJgSrD++Z7fi0gl5WLspwcWRexYJ07wLQBMhmvHkeKW6wxvT/N4uC2Dt8p7nwE0Tx/QsWczOSyyFxBEmRqOOnaH94CX3BE8tiXfUT99H8DtPR2zktRjslRpeB1OxLktiGxFw735SZF/OVo5VYYqMqU/pQ1PDNXwBI4U5L9OSQ8a6mIWJJUFSgRfI8EpECE8xpepR5zXnl+bAln3bSzhJEL2yG359SFfhK/kRu4hyYao+HodmZ0ZsFY4W4wOOfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8FNRKLulcXqtVv0V8j3ljn6K8wkAD3qKDz6lLkoN+8=;
 b=LI5h78axCj5zDdnurLM3foM61AU/fUV6hHjUTED0PEo22ly4jvS5YE584YEta3vbbKOuoP0jUSQEQIJLsrmpv70lMo8im17Q54ALSOSyENXqfOomJbhwOmIKYvmUUkXeiXHl7xrvO6kZiBXQ7QbuEmAPdBIo0pWmZLkzm1Dg5Z8sXRD9WKRG9GCKe+bZX0iNi0EkqfGJgSuPhz5W18TCa8lCZ4pxNAM9Zsla92k4dWoHvvIiitHEJFJQnr7JXPX6tuH3SEsl4+XkXGjM5+54KT9oMYDz1FSErn2RKKZqJHnszoqTtO00NnqmkHlu70n8QmcvGXfAES5WJu73Q8/Cig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8FNRKLulcXqtVv0V8j3ljn6K8wkAD3qKDz6lLkoN+8=;
 b=K6hkYQWsA4lZIdUZOGWFQ+zhe18kWkZZDjAd/cQwMXeIqOdx4Id6v+kGU5ozk7a2q38UJHt6FHpICrsB59GyUk8zIwZFm5OZVV0V+yg818VcAT8MMGlxIw6OwHEd0frV88TXOY8dHnQVLMXnNvhrqT+wTDyui8wezBbp/KgOpek+QBhudV16Z3HhQFrnBOQ4xfCCHuOBlfwIVEGDlgtPxkO+rq8Y5nnBK30h13SnT9NKFUEAOXGI+XpaHCRaFNS/fhq0eAgq58cYWLb2nST3r3mvBZWErbORvAgLAlvgJVKX7Kne4nSRRnAYyHlPsRSebuuIVIj1b05zrNU/qQqy/A==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10396.eurprd04.prod.outlook.com (2603:10a6:150:1c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 00:26:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 00:26:40 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>, "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>, "saravanak@google.com" <saravanak@google.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
Subject: RE: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode for scmi
 cpufreq
Thread-Topic: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode for scmi
 cpufreq
Thread-Index: AQHa4YQqp/DPlb92g0GK3FOKE5oYXbIka7VQ
Date: Tue, 13 Aug 2024 00:26:40 +0000
Message-ID:
 <PAXPR04MB84594531A13411940EDE6D2F88862@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240729070325.2065286-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240729070325.2065286-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB10396:EE_
x-ms-office365-filtering-correlation-id: b1c0561c-16ed-47b6-904c-08dcbb2e99ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?F1hyOOtpIpvgWlt6eQMv6A0SprZzn6+YquVAHJ6W3ODVJwzC0cuiSi5r6CZ0?=
 =?us-ascii?Q?KA7pXJ/Dm0g8oDoX9e3EryKTGtTkl58wmBzJbvtb+NsXb83oC7Xd82oHXMyT?=
 =?us-ascii?Q?o2fDggy/pCgXGFiS6KwGkczuyiPfOu/p6UvX+ARhhV5Z0qNhWZqewv5SrzPM?=
 =?us-ascii?Q?5iDx2Ei+l4GYn19E2DgZpe7eIhY801UxBq/5ogabt+jd6jHHvZVJ/qUE8N6O?=
 =?us-ascii?Q?SJ+IimKbTjEOWA5T4J7lvvLQq62Q52vq8CZqmONMH5YU8m+i+9vja6JEzP4u?=
 =?us-ascii?Q?bjyD3pb4ape96oDNRlA5yBYJnIUDfftjljtoAzKmM+T0Yw4ng4/rd4FpE/lh?=
 =?us-ascii?Q?bsv5peQjssw8hAVRAUrP6jAX7nM1s1zEPoJcghBNiEE7AgubBKUKAy8121rl?=
 =?us-ascii?Q?vsIdPoOlqSUMbtn1/DLZpSjin1+pyp0FQfevKhj7Q1CRG90OaoCySfFUfx35?=
 =?us-ascii?Q?DIalvq3JutA7ygkXKHPoS9gGTtLDQGL+A8nFiMCbqzYnCv4GBYXpRcRDE5ug?=
 =?us-ascii?Q?8qJVxDw3YHNIj4ESxM3Y7QxVIGZOYPfX0IliqggeSH8RdYkYsPI4KwFQVCYX?=
 =?us-ascii?Q?sJ6PbV5/5+GgYzCDow2mAXY82PERHB1iy/G+SZQ8APE6AcnrOQ4u33YUnanX?=
 =?us-ascii?Q?BkrAzJAn1iuRRRzgEv51iiv8jqJhUct+SlE8czwRG0tYv0wYxg9PhuS34pXr?=
 =?us-ascii?Q?1Y1/VjPm6kFdN5upvAvNhTczOYrncxZXz4vCZJDmwqsmWFNibchVnCN4QmUL?=
 =?us-ascii?Q?zeQ3cvFiYPj1jIqlGyioznlnrz+5gIPpZqauo7Y2qmUVSlKoq8rZIrMPMJlm?=
 =?us-ascii?Q?eGQt3ixqCSG8KH6CwkWZIzWREXpDblxJqWiLYkd3dC21Tjuki7+/eUUuSg01?=
 =?us-ascii?Q?KVaMeKZN9Zb6MDOelBVZQ1y2K65U3CEQbcbUhhcci4w4iwD3/T4E/7GRLTfM?=
 =?us-ascii?Q?u3JpfJktxs6MY/VtKc/KaU+tkAUFGO7dctMX+qw/znRBwKqyJZsD4vjEjMaD?=
 =?us-ascii?Q?+1AH2KnHVRffcTI5DkdhE1/jzTU1Bmr3LVujWCvAfCJmgqZZgNZQLnQ4aVRR?=
 =?us-ascii?Q?F7mO84Pz0XO31r/GV6ATIb08akqOf12GAM/PmBhu4Hle44xKn2k6Ed9qhKwD?=
 =?us-ascii?Q?IPE1BRz3MDgbfSHVvT/zQsPM1Z/DaQeE0jQqfOCWK7wCric3NfdLJLulkagm?=
 =?us-ascii?Q?K0/8v3gyc3r5rKD3CLN3oVTUJqh7JFD5NV6tOCKvTXL5Ynmed/XliQAN9Tky?=
 =?us-ascii?Q?xXK/YljiQqDvOhfvbDKuWllRWaDkPRpdiGrr/MZ8OpTOS2ZVpspYEZKKMhWo?=
 =?us-ascii?Q?GXG4rZELKizbu5kxQe2HR8CEtmzWrxzwvmF1uNuk9liorXJ5G9D5Zv8KXWsn?=
 =?us-ascii?Q?NsrNFsc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JAoVxCkp8RJOBrBakvZqsQK/OVBIY9I0ieMblU8MAiM3NIFPZBDjDH5EbM1l?=
 =?us-ascii?Q?fY0+qBxrn3xuQl9mXAw4dtsJ7XgWAKEXWeOSpmJHyXUtmOrGvSHrYBeZDeOC?=
 =?us-ascii?Q?IDUGRhvoDzAI/wj73+m3kEPiLwiM2M5879ciE7HqhYeVTL0/PQBi4+Q4GFss?=
 =?us-ascii?Q?PTGHWSPZzXku2xYElWJKEQHdjkaOiQcbYSrYAhTm0jXo2aJoV4pwXxwF3qEr?=
 =?us-ascii?Q?CDu+88ydqw9P0fIwp01Qe225pRcEELB6A79Joa+eqst4yQYWF538BTvngeJB?=
 =?us-ascii?Q?GgHoBXLYIXFzKKC18VBG5VQCUU+TT2e0Q/A8Kfhk3eFra7DyPJGtXx3+F9wk?=
 =?us-ascii?Q?3Ou86sTq2yqMjD2z2+EdJe7rePIInrJgYAtBRALJZmssKVOYPBSHAvnOd0a3?=
 =?us-ascii?Q?wSuZJOMp1nXHGd0L5DUcRkTQPJMi04fIu7eu1vlzYmXZntKXa9GCeyMmkzKj?=
 =?us-ascii?Q?u2UAYGTHCJndCLIEbu+jM4eB0ZhVZHvldkzP3MEFvGHaws2qIw0rq3gBV8f2?=
 =?us-ascii?Q?GWTwhNSKDNlXFAmJNMBkUJWy5R+yKJFu6ewUWqRGdVTHA5utFFskGvoraxfZ?=
 =?us-ascii?Q?8qrT+sDB4xeyUdBlOgSWw/aw7clBiRnqcoSgWpdPsyw6d0cFDc/I4G+vvotZ?=
 =?us-ascii?Q?bE626voogtyL+g3C6LbyS03rZJpyXNqRWqW0UA1/MV4KfAfHLrwlbJwzwYKf?=
 =?us-ascii?Q?Fvb1YckwsazmhuSi0iwVJ0zMc2CUWzXRZXYm/rwzGSv/UfOjVoTpALMBrk6p?=
 =?us-ascii?Q?XQaq0SGztM4cUgVvUzplmtv6+eK/lGqoEHLNXH1OEtW6vC2JEi6bIeXdg8F4?=
 =?us-ascii?Q?TP+nHwvWJc5PDJmVgMgQJImV+yDypFDSiGOdYuU7zNBykHtpbcHwImxGVZ9K?=
 =?us-ascii?Q?pP3+R+cb02nHLylWJwavdgFkqGj+9KyOMinJ38N892fIqtlFv5Gl/cMUSv/c?=
 =?us-ascii?Q?ApzmS2BeISOLwStxNiGufDc226dqSOUp3gQ8xPzcwu66fmxgqZqAMy4FvvTm?=
 =?us-ascii?Q?MV3w6TT+vithczgFwNSbYCs+TSiAMYo63vZJ+oC5TuYgzoizF9DuX6CCovjW?=
 =?us-ascii?Q?BDt+WMOk+Ko+/QzQxp/1QabW2aFJ5OEkbnOjQohQUQwxtslXYBlre1xu4n3L?=
 =?us-ascii?Q?4NLLp4Et11QY7+Xzq5PcvDTlIuTyQcwsGbp+LTx7gW+WIPEyMj2eO6ZMbk14?=
 =?us-ascii?Q?px/Hp3rTCMvCke5/Cj1BASaAx8eLwzXFM02bi44nOucUZzrwHCdzUaQqhq7v?=
 =?us-ascii?Q?UKcCB8CgE/BikazId7lZCWFsotxqZkI9nGBqF2j44+zA0/7ojcJV2uXvud4j?=
 =?us-ascii?Q?dLNzidYUW+0SQL3nLqWH7zPJhMeyFCSZL1XLxcsyyBb4sFBu14etYpO4EPrf?=
 =?us-ascii?Q?ty7fpzjkz695ww3aLpqxG+IZqgsvSmpXInMPFmuky5VyCnlcxw1FraJ5gwr/?=
 =?us-ascii?Q?vyNrLVmg2eWkXGmjaPkFSuUa5j899a/wNYFO/9SlRMJEAtnLUXvkqTAU0DOm?=
 =?us-ascii?Q?UaJx9Gwa47658/rf3qXOD73fuloGt5voZ2Fb/VZRyNNwtXiGemeSdRTOgoVR?=
 =?us-ascii?Q?MsJxOQ90VBWJPSwf574=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c0561c-16ed-47b6-904c-08dcbb2e99ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 00:26:40.2646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eL8Jp2XeLluT+EP7SP6Ifwy3mdJgki4M08P92zuzzpdnpPhZ2tmBT5dYREUlUX5vapqOMyj5fvx46hDhjb0pTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10396

> Subject: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode for
> scmi cpufreq

Any comments?

Thanks,
Peng.
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Two drivers scmi_cpufreq.c and scmi_perf_domain.c both use
> SCMI_PROTCOL_PERF protocol, but with different name, so two scmi
> devices will be created. But the fwnode->dev could only point to one
> device.
>=20
> If scmi cpufreq device created earlier, the fwnode->dev will point to the
> scmi cpufreq device. Then the fw_devlink will link performance domain
> user device(consumer) to the scmi cpufreq device(supplier).
> But actually the performance domain user device, such as GPU, should
> use the scmi perf device as supplier. Also if 'cpufreq.off=3D1' in bootar=
gs,
> the GPU driver will defer probe always, because of the scmi cpufreq
> device not ready.
>=20
> Because for cpufreq, no need use fw_devlink. So bypass setting fwnode
> for scmi cpufreq device.
>=20
> Fixes: 96da4a99ce50 ("firmware: arm_scmi: Set fwnode for the
> scmi_device")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> V2:
>  Use A!=3DB to replace !(A =3D=3D B)
>  Add fixes tag
>  This might be a workaround, but since this is a fix, it is simple for
> backporting.
>=20
> V1:
>  https://lore.kernel.org/all/20240717093515.327647-1-
> peng.fan@oss.nxp.com/
>=20
>  drivers/firmware/arm_scmi/bus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/firmware/arm_scmi/bus.c
> b/drivers/firmware/arm_scmi/bus.c index
> 96b2e5f9a8ef..be91a82e0cda 100644
> --- a/drivers/firmware/arm_scmi/bus.c
> +++ b/drivers/firmware/arm_scmi/bus.c
> @@ -395,7 +395,8 @@ __scmi_device_create(struct device_node *np,
> struct device *parent,
>  	scmi_dev->id =3D id;
>  	scmi_dev->protocol_id =3D protocol;
>  	scmi_dev->dev.parent =3D parent;
> -	device_set_node(&scmi_dev->dev, of_fwnode_handle(np));
> +	if ((protocol !=3D SCMI_PROTOCOL_PERF) || strcmp(name,
> "cpufreq"))
> +		device_set_node(&scmi_dev->dev,
> of_fwnode_handle(np));
>  	scmi_dev->dev.bus =3D &scmi_bus_type;
>  	scmi_dev->dev.release =3D scmi_device_release;
>  	dev_set_name(&scmi_dev->dev, "scmi_dev.%d", id);
> --
> 2.37.1


