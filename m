Return-Path: <linux-kernel+bounces-549028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFA5A54C4E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01CE816CCBF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2C820D4E8;
	Thu,  6 Mar 2025 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="HT175AES"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2125.outbound.protection.outlook.com [40.107.105.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FEA946C;
	Thu,  6 Mar 2025 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268162; cv=fail; b=sh9fR4n2mPrMZVTH4YuZ7VIdEoMsKXt/uhSbVRj0h+WY3NtURGGSG93yqDDucYgTM1s9OzIw+TbUTczQLdWdu2AXFz6HJE1cHwndZfynGhUQAl8HgAktEWYvpgxPoyKFYKJeMRsXHWTGgUa5IBMO/i27QcO8ZwGc3RH/uMzZmkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268162; c=relaxed/simple;
	bh=aiRdZ24lfSx35FtLzNYrhTpv8l85NBQ1FNoErD53mCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dz1kW4GmhAv0f8alnjw38Dv35VGounXa4r51C1XozJwK4gns0LfTT+5jPPJmPs9yEG3QrdHmZqOGtD6aWWpCXpFcA9AZgnkxGqg79q6i/oykSN93zUMMvpp3QTMDPcKGJ0Mdp25LjbPeCW27zUeH2CvuKPQ+jOcTZQgL2ghbDN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=HT175AES; arc=fail smtp.client-ip=40.107.105.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4YW8z3bSCBP0ypbMdbhylCA8SVFvhkTgqUVqdbSXFhOiIlQcet7q+BF9/EDPkyh2y7n7BlOfpdw8/pdvL5Vv+NBjxBi/FizZWr/n0lRi1GgFN+PW0UYOUsY00ltDcCiQ9wX5QdtVw/FjqYz3K1tPCGbGIaG5Xj6ynmzKbKgNQffTrjewCwmVjGP0Srk2QQFTHRijpOI2Bs3kx2XHOTBd4j8YPQOqX0/3L4Mmf40PE+8Mwk0g/WmsaKwDettsou3VRszJXTO1m2qeLzjxdqizNSOvuk2kPf404CwyMFr2qmNrQoqYe92y/IbYT/cLeKLlounhVYmuabN/EC2D11w+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiRdZ24lfSx35FtLzNYrhTpv8l85NBQ1FNoErD53mCo=;
 b=jtq6O+l2rqLXLVrRvq236wSh8HPbYVc9wErP1mmGp/PP51mtKP+pnpqVN8ItcpbHa5Qg5OqEFzQ6IZVBfKVPmWPqwMlLtW2cEH1H/IyTM6NabFPttjhAMgDX36zB11Tktmiz68gO/Xhd3ef026c2lUQPfkhehHy1nZo4I25XunC4vcyJNYyOmbaW5zyL6tF/92YBQwgrlw+zWwKd3cZAJfpSc9/WzoQVn2gQaIqgugkKmzN27OyILj59L7HneMOmd3KVH6/v0AHBWZi0boso7W1JM1R+esjbk1u1+95Cc85G3ykTUNptZa0nMbc2MkhhJlpomRpQWNZQxSVhDqO70w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiRdZ24lfSx35FtLzNYrhTpv8l85NBQ1FNoErD53mCo=;
 b=HT175AES0kgttIdtlYh0unOT/zq5mzwgbfnZha3OkPhqowtPxYakORNUoQv3nM031eL6YUi7dqZDiRueg7CX8FTYt96b1+jXSsx8nrjbU4HfyfGR9fGb/hM3pmWsiO53uvstIGTbApfP6cyvqH9Sb/1fHSzgif38/2lvtQgLLp+mN2xtqTATuYdj9M5hhH7DSX05iTACcqEUQ/VaTMb/d5WQBAJlNDvkTFzk1qiFdl043Fp/3noHclht6FMMKS6j89zk/kdz4OrjPXYXPvkpR9HKUVnecRuxj9SlFt9JpcAVOsV/Yl/zWp3Le24R5b4uSAyHTIt/Eo5Z557VvhqhoA==
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by PAXPR04MB8368.eurprd04.prod.outlook.com (2603:10a6:102:1bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 13:35:54 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 13:35:54 +0000
From: Maud Spierings | GOcontroll <maudspierings@gocontroll.com>
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon: (ntc_thermistor) return error instead of clipping
 on OOB
Thread-Topic: [PATCH] hwmon: (ntc_thermistor) return error instead of clipping
 on OOB
Thread-Index: AQHbjQ80gIy/KOs+DUmX/lelgz8IR7NjEzgAgAAA5dU=
Date: Thu, 6 Mar 2025 13:35:53 +0000
Message-ID:
 <PA4PR04MB763051DCED9E30B9640BCDD0C5C82@PA4PR04MB7630.eurprd04.prod.outlook.com>
References: <20250304-ntc_oob-v1-1-600d8992478d@gocontroll.com>
 <184d5217-149f-4f6a-b4a6-f897a8391873@roeck-us.net>
In-Reply-To: <184d5217-149f-4f6a-b4a6-f897a8391873@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB7630:EE_|PAXPR04MB8368:EE_
x-ms-office365-filtering-correlation-id: b646b1db-f630-404d-0524-08dd5cb3d175
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?xi7x8mmqzMNJ38e6Dj3noVmBm7frI+IkPb5XrTDIzvUMxQk1hW0udhTy//?=
 =?iso-8859-1?Q?AVgZe0fweSuUNxUrsxJm3OWytw8hokVReGMxIGMaUPjgVJTxevzsk9LXtM?=
 =?iso-8859-1?Q?Y9IiIzwSe3Gk05NaGVFA1zT2ornHj7CNXEsPZrqSEbhkmtcaBpe2awCtcP?=
 =?iso-8859-1?Q?bogwhOIbFKty1e28toshcFmXQzsg1IEFAQwwCH43VCLOOXa3CeQu+q3iGi?=
 =?iso-8859-1?Q?tCMiCobL04bUBYd5J1dM+YM7pMQT0cMT4V3u4nnAKNilGkNfD2pymWHmOL?=
 =?iso-8859-1?Q?Awlnz/1PPrMwTDGuXaAh2cI6eXSfC/D4wcGjQtU8SXSXtYhIwCdrP0SnJx?=
 =?iso-8859-1?Q?boafLAL3S+Fr+8ZfXv2Rz55l9pOagDeLMz1uoXi3B+Kc6oEqnv1fo6V1Lw?=
 =?iso-8859-1?Q?e6ewGclcH2ALElTGH4aKiPwrIA2Ac1Zi3A2oVeLAC3+SJr7JUdcE8VsOtO?=
 =?iso-8859-1?Q?dwDnIrBQOB6TG1WxVqYfPZixCBsIyzUPxcE3iXdWGcfP9j1yttJVo1SMwt?=
 =?iso-8859-1?Q?sHL8tvRGYZ1CX2yPJbCSwJsQB/7rUO4tmefnHPUsscUMI4Nb7Ny3RzVRec?=
 =?iso-8859-1?Q?i9pWJULv9ODARWDDGCWjkEjaolCAEd4T8kiartBtBVI8nJArxjnCq9Q9Pc?=
 =?iso-8859-1?Q?4a635OG9ExyEmZwGj4z4xAen9T5B0yptpWi2voErxSX0+QlneLwqOrPJH7?=
 =?iso-8859-1?Q?UDtJwd8ux/O2E/8HsEBwVDpGY3blJTGLqk+U7YyAZxGjXj4/Q3yu3d+1Ft?=
 =?iso-8859-1?Q?D2qc4SqbLR8OTquOeTj09/Mfr86VvTj9MXKn5IPMtwvAoh3hAzEx7DAVAR?=
 =?iso-8859-1?Q?GmKYIDcgbR/yjA/RE8heuRVYkID6AccCXWYw5fWUV07kWrKpaJV9hG76IW?=
 =?iso-8859-1?Q?RXFIFWc/lK/Pnbdq5r862yZzRjQes8N7kz2jjP4/+9J2adC7Ri6OWKkGWy?=
 =?iso-8859-1?Q?yG11A8pf5I9uPWQFBvJI0Id9ykUB2cEVwFogl8L1DJRVhjlV/RhZuFdNXt?=
 =?iso-8859-1?Q?hB6b4uwaP3o9AqQTCBXtj4PU2rkZOtQnwgn7jFriivey10DaKyFeiG+3ws?=
 =?iso-8859-1?Q?Yjq989iMtGRVYVtnDjqI3pY8cWkqvWwsgM5dEMLm1U8H+SaglD8FqHRxXX?=
 =?iso-8859-1?Q?Tta0pJLUYk+1UCeWksDNUb9ucngIx3p3cFjAcjnmoaTF65w6xy0OKxLIk6?=
 =?iso-8859-1?Q?NtuIsUllI+TOm8DT360LlemHKbdsXyFWckWGqslw40dXZ0/SnH+IfJ4AIo?=
 =?iso-8859-1?Q?xSgnmujN7gt1uTD5pQvlBSDRVIQLuB3KygbPdt+tQx9apzmJjMTyrB1iCn?=
 =?iso-8859-1?Q?+EVLxuhnlsAc4g7FjZTY6rpc9Rqw3siBbF3t//Tyz198y3Zsmi3c/knvK6?=
 =?iso-8859-1?Q?GgvpjD+lP/Nte46k7M9PG6twaZ4HtJFKyj9LdUvqEk7wqYNd0zLBk3es1Q?=
 =?iso-8859-1?Q?QPoaSJYm3tk46l143fntbYcOfbZOvB7H1V8ktBzMD+4z4l/lxgCFG4ovYW?=
 =?iso-8859-1?Q?Z/i+LevQS1W+eB5WcJ+lIi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vM7g7oupqxkyF8hEaU/wtARe2c2N20GZmXjPE+YIp8PbH71n1vaNDB4Oqe?=
 =?iso-8859-1?Q?4k+Ms78HSrSYjBSdrbDaAI/xuBzqJmbXIhI1leb2SdswGtulzENdsZvXnm?=
 =?iso-8859-1?Q?HXBpxIilhfY5I1GrxiAZAFYcNOxVwY2UdGXqCYOIeerYp1LtHA4Q6lZ5HM?=
 =?iso-8859-1?Q?oTJHwFN1oVB8K/elm15+WWt34fTd2W/k09bab2UCw/dDsqkn+IwVRgCA1G?=
 =?iso-8859-1?Q?/QcgasNBCc55B7lUkdT5EWbxRx8lKB5Tf+NYKqJPA4C9eKzCsQ+tHxBZma?=
 =?iso-8859-1?Q?s4aNdB5wagGvDeTqz/m+k0n9yjPAN1ZuHXo2twDWBvAc48OH5ZEGcy6f4M?=
 =?iso-8859-1?Q?OVzhakJarc2e12iZmsZE+HxQFUf0AEP+g9vRNCUq2+rmv67JfKetd26r7M?=
 =?iso-8859-1?Q?oeXo0MKXNjCDV2iWyMczMsA4IC8wqD6zclbQaDYhmZa4TVB8d6t7HOlZfF?=
 =?iso-8859-1?Q?wmhjtLzqK4imAuKYYtlvVtv0qpmPR1LGfBQBoDBeD3YzAGy4RIqC3EdNlO?=
 =?iso-8859-1?Q?SAaAQuis/CiugWBJxCDx5VQ4O1vgchpEihyMHA+bKF7Ky7pW2TMT/SqdDS?=
 =?iso-8859-1?Q?BZELVs0xhLh6bD9QvD/HhsUuCITDvtP+ZH+9lIUe/JoLdbwJXECVBDGcCH?=
 =?iso-8859-1?Q?FMBz4bBP1NPAsJjlaIaN2NrpCM4IODrjRJX9aUL+Ady+SGxd+Lz3/N3QUL?=
 =?iso-8859-1?Q?LXGETOd6B+PqKQIw6ThablY6kn3DiSIpT89yHoi13Hw8jeXcTd0qhB9XAN?=
 =?iso-8859-1?Q?padJCRPrUi64JqQMvIwyGfPdQWphEO71kwuZ0XqvAqudxd+3kdgDB4wrDR?=
 =?iso-8859-1?Q?YSbfeZhpvM68WGIeEc2pr8qSusnFWiLV/+lht3lqe1mzn42e2sQ2kbhqoH?=
 =?iso-8859-1?Q?ok1mDDvk3ofk3zhECUnFZj4ptID3WCO3AOK/vc7THiQt0u9mrZ7/g4dH8b?=
 =?iso-8859-1?Q?3Yd1DOYkMqf60I5TV2JHLKjeN+LEn/2fm6u6fYK4/zAA72ZQo84OJpVMV1?=
 =?iso-8859-1?Q?VgavOeklNuWaxv53mfslbTdqudb9Tl5q8EABpTj46K+7orhZkRwKuu7vXm?=
 =?iso-8859-1?Q?eawOuoQ8C6+/dG59kMCzdsLMf1uGoiOiVRvyGegAuWivbNNicHZJ6oocA2?=
 =?iso-8859-1?Q?wuEGWZKqlUXXBPDeJcWajv8gisNTjBaPiToOqlmOplXlWQRIahCslmjBpy?=
 =?iso-8859-1?Q?A5UenLmxLAdSk1O3JTl9lbsgdTwv2a1pV5H6fB/I6eN0i3UkOix2cX8D+b?=
 =?iso-8859-1?Q?iy/LMRSR25ccX8zyvIpb5OBpzZVmnkxlM8EFzFRnEu2fI7WDgvtHyaXfwJ?=
 =?iso-8859-1?Q?hwBQ5JjOpLQQs1X4E6/2qU2SvkxTppGy+wm/dYElOlxvC8ZR0cysACRIGt?=
 =?iso-8859-1?Q?uw6LEXJuccLViyL1MODOL5qCKyZXQaSg1qJVvW9ssQRPOevmYHz9dJT9sI?=
 =?iso-8859-1?Q?msoCRHvVexRFPrV7p3xoRSiBal1aAy1FvAi1YdWDRmah5sOzRqtrhwvoGH?=
 =?iso-8859-1?Q?AZ5eIcppSSCpc4QwmF+NCEmfsFAE6cN8t45EWM/EyfKCk6l99PK/5aWyVx?=
 =?iso-8859-1?Q?sy/M2WMa5nKeSx4WXoUFhOOaG9MUZcO62QGkCaHDykMHWZeslZY1P7kOpi?=
 =?iso-8859-1?Q?H1ijsAsh6d0ki8qMttA4kUJEF5KqMbezB1m90N3C+sMd+HFCw3eFDj0feI?=
 =?iso-8859-1?Q?brgUJWbfd45Cnu3tuvfHvimbuapqrrEnO7xE4IzOm2LdFdJcyEuzNYctus?=
 =?iso-8859-1?Q?c4Zg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b646b1db-f630-404d-0524-08dd5cb3d175
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 13:35:53.9186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrHXOjBwc0NdnowQ74Wh85USE7k1FFtfPH4nYdvMXyYx2Xeb1IReadFfO1cn8pSws9tL7zmfLN8mA2tvn5TmZZX32SZx7nfn0K+/rflkSkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8368

From:=A0Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck <linux=
@roeck-us.net>=0A=
Sent:=A0Tuesday, March 4, 2025 4:04 PM=0A=
=A0=0A=
>On 3/4/25 06:10, Maud Spierings via B4 Relay wrote:=0A=
>> From: Maud Spierings <maudspierings@gocontroll.com>=0A=
>>=0A=
>> When the ntc is reading Out Of Bounds instead of clipping to the nearest=
=0A=
>> limit (min/max) return -ENODATA. This prevents malfunctioning sensors=0A=
>> from sending a device into a shutdown loop due to a critical trip.=0A=
>>=0A=
>> This implementation will only work for ntc type thermistors if a ptc=0A=
>> type is to be implemented the min/max ohm calculation must be adjusted=
=0A=
>> to take that into account.=0A=
>>=0A=
>> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>=0A=
>> ---=0A=
>> This patch is a continuation of another discussion [1]. I felt like it=
=0A=
>> should be a new patch, not a v2 as this is a very different change.=0A=
thoughts about the theoretic code comment here.=0A=
>> I have left the clamping of n to INT_MAX in the code with a comment, but=
=0A=
>> it may be possible to find a better solution to it. One I thought of is=
=0A=
>> to make the ohm field of the ntc_compensation struct a signed int as=0A=
>> well. It would get rid of this weird edge case, but it doesn't make=0A=
>> sense to allow for negative resistances to be entered into the sensor=0A=
>> table.=0A=
>>=0A=
>> Currently the only feedback this provides to the user is when they=0A=
>> manually try to read the temperature and it returns the error. I have=0A=
>> added a simple printk to these error points to see how spammy it gets=0A=
>> and this is the result:=0A=
>>=0A=
>> dmesg | grep hwmon=0A=
>> [=A0=A0=A0 4.982682] hwmon: sensor out of bounds=0A=
>> [=A0=A0=A0 5.249758] hwmon: sensor out of bounds=0A=
>> [=A0=A0=A0 5.633729] hwmon: sensor out of bounds=0A=
>> [=A0=A0=A0 6.215285] hwmon: sensor out of bounds=0A=
>> [=A0=A0=A0 7.073882] hwmon: sensor out of bounds=0A=
>> [=A0=A0=A0 7.486620] hwmon: sensor out of bounds=0A=
>> [=A0=A0=A0 8.833765] hwmon: sensor out of bounds=0A=
>> [=A0=A0 10.785969] hwmon: sensor out of bounds=0A=
>> [=A0=A0 13.793722] hwmon: sensor out of bounds=0A=
>> [=A0=A0 16.761124] hwmon: sensor out of bounds=0A=
>> [=A0=A0 17.889706] hwmon: sensor out of bounds=0A=
>> [=A0=A0 25.057715] hwmon: sensor out of bounds=0A=
>> [=A0=A0 35.041725] hwmon: sensor out of bounds=0A=
>> [=A0=A0 50.110346] hwmon: sensor out of bounds=0A=
>> [=A0=A0 72.945283] hwmon: sensor out of bounds=0A=
>> [=A0 105.712619] hwmon: sensor out of bounds=0A=
>> [=A0 154.863976] hwmon: sensor out of bounds=0A=
>> [=A0 164.937104] hwmon: sensor out of bounds=0A=
>> [=A0 228.590909] hwmon: sensor out of bounds=0A=
>> [=A0 315.365777] hwmon: sensor out of bounds=0A=
>> [=A0 464.718403] hwmon: sensor out of bounds=0A=
>> [=A0 615.079123] hwmon: sensor out of bounds=0A=
>> [=A0 764.496780] hwmon: sensor out of bounds=0A=
>>=0A=
>> This is with polling-delay set to 1000, it seems to rate-limit itself?=
=0A=
>> But I feel there should be a better way to communicate the potential=0A=
>> sensor failure to the user, but I can't think of anything.=0A=
>>=0A=
>=0A=
>Hmm ... we could add "fault" attributes and report a sensor fault=0A=
>if uv =3D=3D 0 or uv >=3D puv, together with the -ENODATA temperature read=
ing.=0A=
>That could distinguish the fault from the "resistor value out of range" ca=
se.=0A=
=0A=
I've done some working around that fault attribute, but I can't seem to=0A=
find a satisfactory way to implement it. This fault also is not triggered=
=0A=
if anything is disconnected, maybe the 0 case but I can't even get that.=0A=
=0A=
I think leaving it at this current solution is good for now.=0A=
=0A=
>> [1]: https://lore.kernel.org/all/20250304-ntc_min_max-v1-1-b08e70e56459@=
gocontroll.com/=0A=
>=0A=
>Most of the above should be after "---" since it is irrelevant for the com=
mit log.=0A=
=0A=
I believe my cover letter seperated it correctly after my signed-off-by=0A=
tag.=0A=
=0A=
>> ---=0A=
>>=A0=A0 drivers/hwmon/ntc_thermistor.c | 19 +++++++++++++------=0A=
>>=A0=A0 1 file changed, 13 insertions(+), 6 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermist=
or.c=0A=
>> index 0d29c8f97ba7c2f264588b6309b91ca494012ad6..311a60498d409ea068a18590=
415b2d5b43e73eb1 100644=0A=
>> --- a/drivers/hwmon/ntc_thermistor.c=0A=
>> +++ b/drivers/hwmon/ntc_thermistor.c=0A=
>> @@ -387,12 +387,9 @@ static int get_ohm_of_thermistor(struct ntc_data *d=
ata, unsigned int uv)=0A=
>>=A0=A0=A0=A0=A0=A0=A0 puo =3D data->pullup_ohm;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 pdo =3D data->pulldown_ohm;=0A=
>>=A0=A0=0A=
>> -=A0=A0=A0=A0 if (uv =3D=3D 0)=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return (data->connect =3D=3D NTC_C=
ONNECTED_POSITIVE) ?=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INT_MAX : =
0;=0A=
>> -=A0=A0=A0=A0 if (uv >=3D puv)=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return (data->connect =3D=3D NTC_C=
ONNECTED_POSITIVE) ?=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 : INT_MA=
X;=0A=
>> +=A0=A0=A0=A0 /* faulty adc value */=0A=
>> +=A0=A0=A0=A0 if (uv =3D=3D 0 || uv >=3D puv)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODATA;=0A=
>>=A0=A0=0A=
>>=A0=A0=A0=A0=A0=A0=A0 if (data->connect =3D=3D NTC_CONNECTED_POSITIVE && =
puo =3D=3D 0)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n =3D div_u64(pdo * (puv - =
uv), uv);=0A=
>> @@ -404,6 +401,16 @@ static int get_ohm_of_thermistor(struct ntc_data *d=
ata, unsigned int uv)=0A=
>>=A0=A0=A0=A0=A0=A0=A0 else=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n =3D div64_u64_safe(pdo * =
puo * uv, pdo * (puv - uv) - puo * uv);=0A=
>>=A0=A0=0A=
>> +=A0=A0=A0=A0 /* sensor out of bounds */=0A=
>> +=A0=A0=A0=A0 if (n > data->comp[0].ohm || n < data->comp[data->n_comp-1=
].ohm)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODATA;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 /*=0A=
>> +=A0=A0=A0=A0=A0 * theoretically data->comp[0].ohm can be greater than I=
NT_MAX as it is an=0A=
>> +=A0=A0=A0=A0=A0 * unsigned integer, but it doesn't make any sense for i=
t to be so as the=0A=
>> +=A0=A0=A0=A0=A0 * maximum return value of this function is INT_MAX, so =
it will never be=0A=
>> +=A0=A0=A0=A0=A0 * able to properly calculate that temperature.=0A=
>> +=A0=A0=A0=A0=A0 */=0A=
>>=A0=A0=A0=A0=A0=A0=A0 if (n > INT_MAX)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n =3D INT_MAX;=0A=
>=0A=
>I am not a friend of theoretic code or comments like this. Please drop.=0A=
>The original code was intended to catch out-of-bounds values which would=
=0A=
>otherwise have been reported as error, not to catch unrealistic resistor=
=0A=
>values in the compensation tables.=0A=
=0A=
So, drop the check and comment? Or just drop the comment? I was thinking=0A=
to fully remove that check in an earlier comment in my cover letter.=0A=
=0A=
Kind regards,=0A=
Maud=0A=

