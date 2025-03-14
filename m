Return-Path: <linux-kernel+bounces-560624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ADAA60767
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226121686A8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 02:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3C039FD9;
	Fri, 14 Mar 2025 02:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="qGaL6OH+"
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11011013.outbound.protection.outlook.com [40.93.199.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D1F17588;
	Fri, 14 Mar 2025 02:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741918491; cv=fail; b=WC2yCcpmop5Be2e++oFTnt0/gMpAiosFuuIwYPpzmcqjAe3C0K7/5btqSHHVnhbOc3gXoQkodhaGYwKJM+xOGLQDWRacvwNSDxbxeHGwf7zS7obII3Eoy+L6quC8ARKDkCbu+N5Axpv5sRkuUHEIf5X4/r5EBb/qSc22sZDjPaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741918491; c=relaxed/simple;
	bh=KA2sFMqyYgkPW46IHLoH26tnlxXVOSgttodity3ZMTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c4WxTvT4+tMZETtsOWlE3kvN9xNAs3MaguCvMWGbDHCvxh62oKNUDoyA9wa61QnxAThSheVEs1UuKd/uJH2/7pZatADmayHzBkiD9+OyB4ZCOKAdgC4DZBffzf90yI32flFcqSc6tE8uH5bmzYbF0nSordPVKau0jDQzstC6O5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=qGaL6OH+; arc=fail smtp.client-ip=40.93.199.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkiTN+2lNGc9we3QnCctMoDQn5y5DRqwur2bbu9+xXNn6TwB495LJVOEEckk45rgIG3SnzwEbJbSOkQBduEQY5KTuexnlaHtTh8I9IbxoVgjsdCEtQleiOfUAMQKKkSFxBmUF/Sv79TAhkqp9uhJGBu5UmPXuuBvAZIRPs15k+4OO1cXxwr3hzb4wZsKmgFAnXFHvPKm9rZVG0xdlpMhoNf8DIFEnLgoLHN+OQAdWmmZULZbnRJ6oHww9/0vZFm9cSw+kbd79nOTb9I2Vzc5yARdJskKK544SRZBRuM+P1ZqUehMAhJETK97zhqgpTAR10RVYE+ic3yR5d9XzAwvLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KA2sFMqyYgkPW46IHLoH26tnlxXVOSgttodity3ZMTc=;
 b=Z6cTOTKVE4jO0seVHISeLUCquzbEuP5hcS/EblIHFu8WvZ7s3DywRwJi+RXgHbvu2KFriBt1+bpkx/vXIgszl4fMsNu+C/wyZa0yHnixCweFecWZtFoOhD6fnRrBlknDbKvVE4DcBnLcOMCsxFhS4d9cLcGobo2S+Z/bacO8ce6uegQurf3LboI1ziBp07oJPOVATGZsruS+vY0Er0lD+kttBwt2V28UaoPilVzbpeGZTwORgVb/TblPvo5koGKmdqtPNvtUfH6chmp644AwErDxv+zuw15peZxsaScUDmj4/xTpkiF/vz6ReXI7/AJ2tBQFVBBp02MbeZWjmi0sdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KA2sFMqyYgkPW46IHLoH26tnlxXVOSgttodity3ZMTc=;
 b=qGaL6OH+2xzb+F853NIjEm7zwZpM/U4JVI/eUxMjxpCfv19olCBhAQg+yHLkMdTrtznqqtpYwLf4rYN+R2LTWiRR1WG/UbYeSXtMW8s8HD0vbpY/yDDr+XFOOjWHPUU7tvLNmB2DmtZTGPQ6+QeaIgX1HxNSG1Zj4SIAxro//njJZRzfPvcAcxMA85WyPUU7675Tw42psagYIaFVwxXG+S1sSvyjXlA7qGSw97DBRDmP5c3AAIDU1Ccmr18NbYklEA496uw3pRR/5qwY5FpzeRLgtCMq0b8VuTcKPVhDz/v/V4BdNg8BfodM0d6OI6LjoZId8eJ1yJlcFImzRt1fpg==
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by CH2PR03MB5334.namprd03.prod.outlook.com (2603:10b6:610:92::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 02:14:48 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%6]) with mapi id 15.20.8534.028; Fri, 14 Mar 2025
 02:14:48 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Johan Hovold <johan@kernel.org>, Boon Khai Ng <boon.khai.ng@intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb
	<linux-usb@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	"Ang, Tien Sung" <tien.sung.ang@altera.com>
Subject: RE: [PATCH v3] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Topic: [PATCH v3] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Index: AQHbkvvMHRAvtJ8/p06DGMF0FbVNoLNvubiAgAItpwA=
Date: Fri, 14 Mar 2025 02:14:47 +0000
Message-ID:
 <BN8PR03MB507362B42C47E2D3FF7C2D7CB4D22@BN8PR03MB5073.namprd03.prod.outlook.com>
References: <20250312030544.4967-1-boon.khai.ng@intel.com>
 <Z9G8-66NI_5TLSY-@hovoldconsulting.com>
In-Reply-To: <Z9G8-66NI_5TLSY-@hovoldconsulting.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR03MB5073:EE_|CH2PR03MB5334:EE_
x-ms-office365-filtering-correlation-id: 78ace3b7-c254-47fb-d1f4-08dd629dfec8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1nD12y80bD78begMDZcy2uNzmF9eReHH5FpLSndBJBWhT1RSIJB0sptE6OOW?=
 =?us-ascii?Q?6IEql2CPU7bKTOG08C/UzlZNgZIDXxzZmhA8cfnlyhK7E25CuBneQOkK8YW0?=
 =?us-ascii?Q?psKw62ZfRJIURBDMI3vp2vIUr7ApEAyEbnLhp2zwEjHWDpm1GVODRxBWgNT0?=
 =?us-ascii?Q?atJaC+FSV8Jo8P4p60dzOjQJirsL62+5P9OsWXtd2m/oY+z2vp+X/unU0jwj?=
 =?us-ascii?Q?FCrpROauuDyOjlT0WPCbq66fJnWG1qwfQ42b19bJFW0Yb/qVl4FClfBQJhkE?=
 =?us-ascii?Q?MMWCy0d9bEwOxezNT3+P7X1/xpTm7wioOCMvlguahN+vREqG54upRjD9r2mz?=
 =?us-ascii?Q?0A0ZXKH7DmEyGi+h9Qahwcw3tPwSwtZKPcTzZuyo/SCbrrJoaabcGKkVIY7T?=
 =?us-ascii?Q?joanrf2u4dAInTv0v2qyXjklCLy4Euwb7/FE2XHFlJLKJyYlBX7fhpcsJTjJ?=
 =?us-ascii?Q?EVQBWvukvR0wQ4cL5busZa9ayRG/hQHsPlV2TGG0VbtgX/BafedWTPDp4RwC?=
 =?us-ascii?Q?Nh4K3KER1lFB9loNOAfi7TC5NhhtCqB2bJK5v5GG25tIibXuV2BLnUE5v+XC?=
 =?us-ascii?Q?Y1IELINRoB8Nq4u7GfghVQYykpIEOya3k619hBW2ptNA/+LHN4v4vhBixZOc?=
 =?us-ascii?Q?AwJpjwa9sMOqEr+hxLF/TbrhKH41T9ITJycFns07LWPRs3uxfuXQh1eQLhXW?=
 =?us-ascii?Q?3HksAE4KyUKH1Kd77PWZhhvqShhaAg4ZeYL23uWUPIrOwGt1MP7Em+sNX7ip?=
 =?us-ascii?Q?y1LVUemdRi2PkPWr9ka3nRZ18zx4p7ysi6B68tEHKW+I33Rg2HhWx9c9tZ64?=
 =?us-ascii?Q?mEe52cxrT+mLqCrwd2acxGWHFWSfe2QAP/4n7/njjDIa532y1nQBR/0EAfCo?=
 =?us-ascii?Q?FegoY+Qtv3Zu0gMBwrg2kij+glk6ebgf/lpPss4rEyR2dlMQj2xt6dYQYj+p?=
 =?us-ascii?Q?J4hnvLmW3evkvDGz8CXA8s592CMO1KrrisOSstsva1Ml6dQ/wn/EMXb4D71z?=
 =?us-ascii?Q?hSpTlXMNTkQmcsGw6RNtwSCXlFwV8z3AirbpDAXpImrKKM2y5s7P3EJn9Js4?=
 =?us-ascii?Q?zzphm6EGml3kqf4yjYsUl4jJVjE7zKTxIrvlGrxgcWyCQPWULNMRye0pM5H8?=
 =?us-ascii?Q?+5UsFTszJLSiRTBpUzYc1AZxG9quwbCf3Avt1E5nN6IyQkv6tpCgt0QFhs9p?=
 =?us-ascii?Q?2KHGSCs9NhjRshcDYcFREKXUVB9sNgD0Py58/2pHCMGln25rJIWDuLqGpG42?=
 =?us-ascii?Q?ZUvGWGiZ9ixMAnJmsXyvxNSh+khHRyMU9L+jqLwi8NPw974149O47/rplh04?=
 =?us-ascii?Q?9titOpwJGbz6xe2zL/Tun5JZaCOi6paqQlQpHhHYGAA3fF89360BnOdNcnTf?=
 =?us-ascii?Q?sJS7gB8/W+CEJZH9eRG/A76sVk2H6Ioa4SEOEO4Z5DHboSX9llTij8gAU2ED?=
 =?us-ascii?Q?zZKrqgcgOQNVNv36hAkb6uzJ73QJ5uoR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB5073.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?R2oKM2op7fN/U+eqn96V07lPRV5NJocue65jOd1Jj7Ah2lZf6c2jq0bxkvl3?=
 =?us-ascii?Q?cPrls5cRgJr084vgOfai7SB+S9Jj44oVrZMVVrjuIIFBsXvDiaL7edj7Apv0?=
 =?us-ascii?Q?w8m7LqwmHDcnt+X2N4fIefDxv0TdKvN6m+oXZo1Bh3zsJqNBqxQT51OD2n+c?=
 =?us-ascii?Q?3OqT+7l/AM9hnP3vCQTs22R4CD1Y7Xg9FxhLzIjSDPEAVSnrpJw6PJRVc/kx?=
 =?us-ascii?Q?GCrw9ZfdaxQuy9bT/rM3Ba6Yfg8UhnI7CS4f/S/VKofCCpeFpOagYWibICpM?=
 =?us-ascii?Q?oLPloBcp538jK81rO2JmTAN+NHNh5RvAjZy7EQN9ExykWbdNZHY+2yVYiIjc?=
 =?us-ascii?Q?apV5gwiBW0qD8pt/91nCSypjHlmxQmhk9bCAaZIUrBp2x67wx7CUcUysGwTK?=
 =?us-ascii?Q?7+uViOFiGAv4b8cW0s79pjWbXzpg4ifbQtvcvK0VGUGunbt1cyiGwVYqkWeB?=
 =?us-ascii?Q?sinaSFSxvvv7jzJ8aaGqEgo6bvhORYLxj3wmSrgpwcTJdjmjN0qXg0t3eMX7?=
 =?us-ascii?Q?hwnlGTrW85PV6kESEMBqXxuMSk/HFoKxZJk1c10UptMIlNJtyx4+SiNCQrFe?=
 =?us-ascii?Q?Dtzs0wmey+EiDXt33yelbrr3mUS6OoaMO2gAuE57lmVKvZg/D/ZdWOz8f8Sh?=
 =?us-ascii?Q?t7ESIYD6dIMJPgoo3VVZGe0JqmnOTCi5Y3MBnpAtiO4QX/b2NDQgQAeZEH9c?=
 =?us-ascii?Q?OksHqzqPXX1MKZqdzrsIzvkh6FCV31pfwVJLLbciGDFzGE2nlEsyYPUEiBAC?=
 =?us-ascii?Q?T/Tf3qoSZNRfOfKmS9/4AaKZq5YfmAvCTSfsZ9h8YLxKwxzC0K3dznbWXH3q?=
 =?us-ascii?Q?NdpW4rOD+83Ji239dCyDQPV90AOoT1I9AiJ8+IPktxLCYsdpwCzYIrEeQa9F?=
 =?us-ascii?Q?FOJaauoznbidodJSF9MsPPSWRNXRoSYd0049MK3jAgI8rh/Va+K4ouMSzs/F?=
 =?us-ascii?Q?9lMUmdg9Thifh2J2Ge+LQ886Y50oo+UokgV8TatsAc3wjl81wQ6DyCfYAgD8?=
 =?us-ascii?Q?jODRbmvcPh492GdIPQV5F6lQobFPwb8OW8ZdasQ4L6FXGLHi3adFTdgW61J1?=
 =?us-ascii?Q?2jX8JTrofLF9ar+8L54Dcmlc9omz+13GVposbz4bhPLPq7M9nF/Blr3gENw4?=
 =?us-ascii?Q?QSquX1U5ZCFX+u9gYF1CUNyQ5VOktXN0Y3ARuqO8phkQ4nWjF8OSVx8iGDRG?=
 =?us-ascii?Q?TyGnmbuQl38ipC7SPnGXydiKcleCoXXIWHofGZLHO+2CW5GWj6G/m8fQHOqy?=
 =?us-ascii?Q?HCmz8FLF4RaqWHFWY4lI67dG4OrVsNaXzkUj505LGiSLAhupY5WvdSvMuWEk?=
 =?us-ascii?Q?M1h4WANzgoX0OzB95Ty8GClUyfkS6YMxKmvKAGZSvlVzw5FyJ7woN55nOXjt?=
 =?us-ascii?Q?u9fIJTUUWsdnKda0AqJp4sJtCuqqbi+j9AlhJDbX4SjJNz7hZ/IQJRcQjEI0?=
 =?us-ascii?Q?e5l4glE7iHO6omnzEAhI5IGVRTqTO3cCxGLEFST0kLi3XwARvoMltrm80xRg?=
 =?us-ascii?Q?kUj6w8s2rYu08TETlHXQrJUZZBc3+oFbAGxpIigaHlNzlCFU+8d85wQiO3qE?=
 =?us-ascii?Q?11fv/F0GAxUxnGQX/p80ixp0n+HmBxnsQllS4HRt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ace3b7-c254-47fb-d1f4-08dd629dfec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 02:14:48.0105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3qjSGj6BMoSLSakGctuwWj5P2GrR7R3vQmOD/a3upVn+xBW+g/Si+wAc5IbXuc3B/pqg+Gia1aQcvFBz3aLX0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5334

> Thanks for the update, now applied.
>=20
> Next time, remember to put your SoB above the (first) cut-off line (---) =
so that
> it is included in the commit message when your patch is applied.
> I fixed that up manually this time.
>=20

Thank you for your feedback and for applying the update.
I apologize for the misunderstanding regarding the placement of the SoB.=20
I mistakenly thought I needed to create the cut-off line myself in the=20
commit message.=20

I now understand that I should generate the patch first and then
manually add the change log under the first cut-off line that
appears below the sign-off.

I appreciate your kindness in manually editing the changelog
this time. Thank you for your guidance and support.

Regards,
Boon Khai.

