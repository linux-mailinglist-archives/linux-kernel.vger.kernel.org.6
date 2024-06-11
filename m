Return-Path: <linux-kernel+bounces-209971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC1F903D87
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD3EF1C23395
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2386917D376;
	Tue, 11 Jun 2024 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tgsJxTSI"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D41317D34F;
	Tue, 11 Jun 2024 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112879; cv=fail; b=QrEg4nJwjg+3W1xsE2V6nqmLO7EYIWShqwbERzbYL/1FjRgn+gTsvVUv//jtImjGJo4HBwXIE3gMbq7gnerwmOjIxgk3rlDJNsw/slq4+ytF13zr31DuEBrAVhqDr/uZ0sQyGU0oTV151BIJcqdHp07TSiNlUNELfj5phRb2BnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112879; c=relaxed/simple;
	bh=cqgLrUXwT4KoD6aZhH7nc2trAobt8s/LG75BmOrqPWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ssYnjjbkOo07AxakABfLWPIZevAylw4vZwr2jR5U0/tgzj4kYHmekvWOnj4dMZtPxB8TV7bRw7MIfd3EC/D37Y/A0oTrGIN9hvyOSmC3cIJAXIvkrDBpC62g31Vg7PMEQ8ViLXmVzVp6H45rgUOiI6fUZ6a0+RY0ZZ/vr/7jwCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tgsJxTSI; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PX26t0Mt4DAmxj3V6sMj/beAiQWcO1uxX9/LlK3rPQ5j7zxXVdKPUsdTPH3g/X9Fanfw3RkfTX03L+AC31inTqPt4KhElRwPJ2s+vx4r3Pfs4a2t9pDRy3RXaxfVGmqhWZUr4cfY3OOJpwQrzrHrKgSAH6s9rkLuEw7/EAdXMixxnm8W+CIYUBiokHceFMJuCYCRY3wQgvtv1w1U4eGcTqtNY3p//86Yj3tEBTo86FBQPI6mLwAg0NBQ3QfdvxmlxVAtc1fymy03kyxoxiv3WI4BeanWSR7b7rVCFf8XYcG6IDNc7aJOFL18NRzHZCjJVZnUvOKcXmJuy3NcxvedvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqgLrUXwT4KoD6aZhH7nc2trAobt8s/LG75BmOrqPWU=;
 b=XCKyEvfPnvauj59Q73TsBzvmxX6XyGotc2Z/MlGvqaBfvCfUif+vaZEYYV0TWH3Oq75cEn+68l8ut/NSsI12nRMi+s3AQGQ1N93jI63r3Ybt+DGoUSrtUyTv1d3ur8i7FaOmD5BmAN/SPtDsB4A2nARTOwi2MdIb3HAbv9NvnJWdTWpLHKs8jxEOavlfHJokhzFUJG0cysKZf5C4HtZ/wh+57e5/DyzBSDOwcpJQFrcyx+jKxEwlCTLNqJ2HLUVULnHq2TFaWLhXvROaM0Km2WDeVmJnz439XCRQ86fbXEVHi9p7AmrWWWjfhBKr3Oj13ZOzooYq9E2y+LFR9LgWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqgLrUXwT4KoD6aZhH7nc2trAobt8s/LG75BmOrqPWU=;
 b=tgsJxTSIqFWntqUKJHxNFU3W32CY2RDEPOho7r9KIhir40Fput/8wOO0+QaWAZpbZujxZkMOjN6BTYgAwfNfPgkktXi98o8x73JY4lcu4T68UVlE4owJ/hWtkGvbWJMhEqn3G7mbEy6CpLK9LSN63IH+tXOz2lBVbOAckEPd8FXK9Bxw+RQ2uZzlh/v81Arpkv0HjX6KCwIE/q4Xr9fEeuOmlpzUcJpZUeIbsbEcmoJqEqLLfIySirLX00VHnWihH7Mt6N10tHr0cDdqLeQRJOdUPAwR25qbIabyMhxTR7q4mBHT1FV1ghApqikKCaBzfc7NYphwkTjIlJ/edSLU3A==
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 13:34:35 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a%5]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 13:34:35 +0000
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
Thread-Index: AQHaqqzUCe6HwhimrEuniPTiRFYZCLGq/5cAgArnmkiADGGYgIAAY9rN
Date: Tue, 11 Jun 2024 13:34:35 +0000
Message-ID:
 <DM4PR12MB5136EAD83A50869388E96FF3C0C72@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <cover.1716205838.git.shravankr@nvidia.com>
 <ce077a0db5d4afdbcc63a635fece9793aaae055f.1716205838.git.shravankr@nvidia.com>
 <70d3c0af-8bf6-2e33-074d-5b1719a5674f@linux.intel.com>
 <DM4PR12MB513695D2BE98AA46A95B4C60C0FF2@DM4PR12MB5136.namprd12.prod.outlook.com>
 <33f25d4f-386c-6df6-344d-8b7aa011e69c@linux.intel.com>
In-Reply-To: <33f25d4f-386c-6df6-344d-8b7aa011e69c@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5136:EE_|BY5PR12MB4130:EE_
x-ms-office365-filtering-correlation-id: f4b14245-272a-4efd-91d0-08dc8a1b3bce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?NkJAlb7qNl6l97NNF35XNbLC5ziTVGz9wAoKmbe1ZIilUmjGx9VM+Jidg4?=
 =?iso-8859-1?Q?lEsqwqxuEkREMWnzXuKAd9Y/or6PyMyyMgWr8A2SStyIHS2Znd77GHj+UX?=
 =?iso-8859-1?Q?xPDh4PRC0xylIklgVCDIuZFyCZCP1uqU1Ljddyv1m/kEfgBr4fXkZ0AdHj?=
 =?iso-8859-1?Q?RalvQwA+u0QnLR1F80aYDlNOth4CDnq9jy6NeamJuORDuY+6uTkIz/hvPi?=
 =?iso-8859-1?Q?30+dI32BYWl1WShFVyAmOsi3B7q53LDDFdi8LLwJkV/Y6dW7OfbKKYrwLm?=
 =?iso-8859-1?Q?CqoZVUEMEd2itSh9ZHcsoIpsKBPneFzb44lAy67sYassaly2X7c2Jmraw3?=
 =?iso-8859-1?Q?k7UsiuLhsPPh2AAJPuYhw8d9Tbs+8FTbZknvjUdpxESo38BAoa2pGBXg19?=
 =?iso-8859-1?Q?K7LIk6On36pVlHHCYv09xnNICcf0VA2tRod0BD7Z1MtR6sBoEZFwVAJS+H?=
 =?iso-8859-1?Q?uiczedlcZ7N7qPbKkPDABvqK0tlfjJalWAbCAvFSTZmfBv/LiMZPPKdXPF?=
 =?iso-8859-1?Q?iSHCKSQCF4tmqYTPm4zcHeUVdz/SFe1d/Ey7Znz1In0XcSjdOK1CAtUiec?=
 =?iso-8859-1?Q?CVwqzr6HjDTr0YT8qINDah6WsOApHH2eIUOU45Dd3FJYGS95WgqcHIlGur?=
 =?iso-8859-1?Q?bpi1vcp/0O4bNGadyLMJkZX/7hb0Wfu0DvroTEshlyGlIlcAv+btbjy/0z?=
 =?iso-8859-1?Q?6om2aDD1i+I1k65iKCmn3NkUUcfwHMB/R2I2sLQKwHOowOoyYyb/KLphz1?=
 =?iso-8859-1?Q?NFJi6eYVxgW3PL9twBA4jXLJlsWK7gLAQuvm1EU9ELUh5v4Hsh92z2TWJI?=
 =?iso-8859-1?Q?ulCxx7433zWOHOCIH6n065pL8Vn3ZjzFbxZq9v1u9e6yvOrRucsTGwopTR?=
 =?iso-8859-1?Q?JAUX0lmhlSZC+ueF1WyZR1UEvAb/TAjlRtllBUZtw2FuWJwH55S1/RSsNy?=
 =?iso-8859-1?Q?9/5EKP4sPtiY2k+UBltJej+UpMt+2HGxjKv+tBtx6asAh28er2pCjTg6tE?=
 =?iso-8859-1?Q?EhFm6Qe5r8Ii8ydC2BpFa8tQwUYFOQYGvGHdx8gUNUitage1dHb4bz0HTJ?=
 =?iso-8859-1?Q?6HDSirQTGfRL+zJ+o8Gpq8iVkNeYxcHKPmmVGddBZKBMU/kTwxnXUwRRg5?=
 =?iso-8859-1?Q?hSHucd2kFh5rFhBtvDKT/u8IDuQhLfFa3nAIYEMrUnCnUoappQLfPlav5F?=
 =?iso-8859-1?Q?HpGYskWmdqJBoHT3GWtZCN91s9xbiBvLCptXboroV+f10/JRVqDzV1Pk1B?=
 =?iso-8859-1?Q?9GZ2UdTW5zsAiyZd0zo3nQPEvgwGaJ2sqB2s/fV9W3+obqgRgx+4+a2N2V?=
 =?iso-8859-1?Q?XzfEZ6CV/gt+tYChV1F7BVBdaQe1KWoTUZjQ6CzKWGaZSZJkiaV+FMrqe3?=
 =?iso-8859-1?Q?jryQGcGPintkwUqq2O64pxPTwAae9hPZsIa/KqlNN8W9QDr/NtJ+4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bD56vUqm41sMlxwXa+8J8+IYblZ/pNx8e3XBOyLaBSVM4YCAiMlEbXMu1N?=
 =?iso-8859-1?Q?hspwPCT73bTUKQQKPlgogo2NI7F4A4wE/q5H/klllcDWkPu5xLOqoWi6lE?=
 =?iso-8859-1?Q?Nqq9wjmmAJA3cMXcZT2i2KCoR+t+a15S/fNm1+9eCQUk+zp5vY8+8Uvwi7?=
 =?iso-8859-1?Q?LiRczz5Hj/K0QoZ+ubnok1B/E9yprPbh2sLLiLtVjZMj3DIIZnnROYr7HB?=
 =?iso-8859-1?Q?Rzr2BZPJeHyNBnbEDNinFnllzN0dWNGJiPHtB5z0XlC1wmq31bqelOMnbu?=
 =?iso-8859-1?Q?qc+joRpcB6tqw/XtdLW6JutipqQ/daoFeKtT9b3SH56syMB92pYd+rn7jW?=
 =?iso-8859-1?Q?JCy9W6BRlXdUO0O62NziL0pzUV7D/EILmGJ7uLOajSj+A9l25X5jZagDbm?=
 =?iso-8859-1?Q?lJArfq+8aNlZqd6yvH19O6gIT0mDlrTBEXH1kbRt/of88DubTCI2BlaVzX?=
 =?iso-8859-1?Q?HQFPrQdFVRUeXL1uBD1ds8UtWNVUWVDmpwaYlcFCinpnM3jvpXBX7020Iz?=
 =?iso-8859-1?Q?ahupmjzLEa04JPytphq9XmvLnp50QkzJewAPTm2wc9H6muUBYo2dL+7cZd?=
 =?iso-8859-1?Q?KLrLHJcW4iWpD3EU45kLP0Q2BF5Xe+SD42Hj/3nZmtTkxX98xT49cEr++l?=
 =?iso-8859-1?Q?C5gNwflgMGm7MoSUe4ek3unojlR951lNUXEHMG0YDV5FLXSn955AaTL1zZ?=
 =?iso-8859-1?Q?03Ee//pmFBJ2fok4HKQACezXRh9rPyhU4e3c1lDlLrrn2YJZxoLXdMLwvy?=
 =?iso-8859-1?Q?+S5aClGvRC1TsaQLTJ2QzizTYM1kHH132bEbu/PEvk+eF7ivD0tFDC7A/p?=
 =?iso-8859-1?Q?/14PgHJL0hHHHrfh9LOXFNS9K4iMZbhAM4uWANqNApNMcOCFN3Unjjd3r/?=
 =?iso-8859-1?Q?lYh8Js+RdIFi8hdpEe9Rirj1AQXKdYcHwafAxuaz2TkogYhznjY18MmVJ2?=
 =?iso-8859-1?Q?CZcuYZdswJK/jFMxFUlGApjI2QZbd7PbayysDBOR3SWnUKUuE8uzpB+7Pi?=
 =?iso-8859-1?Q?X4ld5qyqfhAiG2rZfVkWg7pG2K0S6A6HRjWI0fwKSyJqTsidGksuGVKo4U?=
 =?iso-8859-1?Q?ilfqbNtGrlxKSZiZdNLae3W5kscgtnyl7BO4Vxfrv1QpEGVjc3jo6CNGdz?=
 =?iso-8859-1?Q?21XIQBLjtrSbx4MXhDuqENrGBGonjxIoSzEX70ia/Hb8iBVWH/nUJzgeh0?=
 =?iso-8859-1?Q?7r3KKYWZbrfV5N9OTZWclhl6DLtQp2T5O+KerEaWg/SQoI3sgZyWYlIOkx?=
 =?iso-8859-1?Q?IanuLb85CAmUEzQKBlOxX1t/uPr1juAFr9nhl+IHEfQwIKIB65bvT8/hbV?=
 =?iso-8859-1?Q?okYhgk0mlHwx3rLlW5OJ+mXGqo8PH4zrPFQtd5HSJSBodSsStaoYA2mU9i?=
 =?iso-8859-1?Q?386KkcAKMue7GLiFwKBoF8yghO/NMtTC3x2u2d9HxOv7hncIriRWlLozUE?=
 =?iso-8859-1?Q?onfglqSXDtkfkxl6IBXmdA6pi1gcA5/98K/8VcXc3hm8g+UYrvkjdlsA7t?=
 =?iso-8859-1?Q?8XR1ScCGh+nj6QcAxIfrXqpgM1f+PkRgr8k1+5MCGh+5MyykAl7hN6/t9p?=
 =?iso-8859-1?Q?EERMHydKlJeQ9gt650ATuC9qBf0iMQZCJEzU789bfBw5nkACgPcAx0ozv6?=
 =?iso-8859-1?Q?5H3cVgCCrwSvnsLyBE/qA7bGOTKAn5mnI+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b14245-272a-4efd-91d0-08dc8a1b3bce
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 13:34:35.1460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: isuEa6FKF28eEmvr6f53NFFjs53+HSuYg4+R90Kdgnf9scCqTzBc327kOcZD2/uMdVVd1N5njx5emLp6q49Fqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130

> > When 2 32-bit counters are coupled to form a 64-bit counter using this =
setting,=0A=
> > one counter will hold the lower 32 bits while the other will hold the u=
pper 32.=0A=
> > So the other counter (or syses corresponding to it) also needs to be ac=
cessed.=0A=
> >=0A=
> > > For 64-bit counter, I suppose the userspace is expected to read the f=
ull=0A=
> > > counter from two sysfs files and combine the value (your documentatio=
n=0A=
> > > doesn't explain this)? That seems non-optimal, why cannot kernel just=
=0A=
> > > return the full combined 64-value directly in kernel?=0A=
> > =0A=
> > I will add more clear comments for this.=0A=
> > While it is true that the driver could combine the 2 fields and present=
 a=0A=
> > 64-bit value via one of the sysfs, the reason for the current approach =
is that=0A=
> > there are other interfaces which expose the same counters for our platf=
orm=0A=
> > and there are tools that are expected to work on top of both interfaces=
 for=0A=
> > the purpose of collecting performance stats.=0A=
>=0A=
> > The other interfaces follow this=0A=
> > approach of having lower and upper 32-bits separately in each counter, =
and=0A=
> > the tools expect the same. Hence the driver follows this approach to ke=
ep=0A=
> > things consistent across the BlueField platform.=0A=
>=0A=
> Hi,=0A=
>=0A=
> I went to look through the existing arrays in mlxbf-pmc.c but did not fin=
d=0A=
> any entries that would have clearly indicated the counters being hi/lo=0A=
> parts of the same counter. There were a few 0/1 ones which could be the=
=0A=
> same counter although I suspect even they are not parts of the same=0A=
> counter but two separate entities called 0 and 1 having the same counter.=
=0A=
>=0A=
> Could you please elaborate further what you meant with the note about=0A=
> other interfaces above so I can better assess the claim?=0A=
=0A=
When combining 2 counters using the "use_odd_counter" setting, the mechanis=
m=0A=
of joining them or assigning upper or lower 32 bits to a counter is handled=
 in HW=0A=
and not by the driver. For example, if bit0 of "use_odd_counter" is set, co=
unter0=0A=
and counter1 (which were originally separate counters) automatically become=
=0A=
the lower and upper bits of one 64-bit value. The user needs to read both t=
hese=0A=
sysfs separately to get the full 64-bit value. The driver does not do any s=
pecial=0A=
handling for such cases, merely provides access to both counter0 and counte=
r1.=0A=
=0A=
Since the events supported by the blocks are quite HW centric and low-level=
 in=0A=
nature, the driver is generally used alongside various tools which work on =
top of=0A=
this driver to collect telemetry info and provide more readable statistics =
to the=0A=
end-user. Similar to this driver, there are other FW interfaces providing a=
ccess to=0A=
these counters (same and other additional ones as well that belong to other=
 HW=0A=
blocks). For the sake of consistency and to allow the tools to be compatibl=
e with=0A=
all interfaces, the counter data needs to be accessible in the same way, ie=
, as 32-bit=0A=
upper and lower values in counter0 and counter1 sysfs as in the above case.=
=0A=
=0A=
Thanks,=0A=
Shravan=

