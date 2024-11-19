Return-Path: <linux-kernel+bounces-414874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9E09D2E92
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CDEDB2FBC9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFD21D172E;
	Tue, 19 Nov 2024 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="r5TT768q"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01olkn2082.outbound.protection.outlook.com [40.92.53.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34702200CB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732043342; cv=fail; b=u2pnmE/pRcY7kmqBvuC2rshV3j9u8FKHgBZBv8k+QTAKrfEu1xZl1bMwespHlNbXxmWtMcMshEuyzQPocEVsXj+hQsGv7vZR5jr0uO90RBWCujjE0UQCPxZ51tEXyGz/eD2Dp5wNL1IF6FECTQqyBrxfOqitMHYT9FyKJPAAla8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732043342; c=relaxed/simple;
	bh=uiRmDjGFAqW9hsbNOsj6PpMf/+GEKIFkng3LidgTNZI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XWwd/bcHh1i8yHZn95f9zOY+mVA11fyu6t3QFikvUEzMhRwtsiDj2nnGrTe+ovjNIcwSPQWqtzdWr5k/5UnSlx0EXUqog1P1swnwa789uDza76fsBYZEaIZpa3Z1g+66F0CqyrCwqDMU0is4qa+6J/1KlUteHYdgDO9sb2jw5G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=r5TT768q; arc=fail smtp.client-ip=40.92.53.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOdaDQr4hHOk2V2bus58DIzzur6s8ge+0UA+M9C30Xt4852ImGazZZ7+sFGU5Qcj7UdksL2ODcprRsLXXrnqB4H9erZArARm4Uob0YHT3WP6X1rYS0laxeNzDJ0Bb4fLjKT4QEoOSemRLJTgEEpUbO1577Jp/9xZoFjSTlLRqqB/Vz2/9W7J/XDOkTXalJVxScaQCtblJq3fzfxxLF34kTtqGml7H9ZQMLtNSMQqAxd09rrAvNuwiAl2gDmUzyCP+d0fJ1lNmLXymQqacX1coP82fN9ibgVN91izeVyaEhjcLzfAaRGrPlxAaHdj9vh55iiEVyNX/Wz30ZkP3WRsnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiRmDjGFAqW9hsbNOsj6PpMf/+GEKIFkng3LidgTNZI=;
 b=Vvjg5XTenWdJ6qRnqss08QxcgnwejMKoAjSuHt92mXjw96j9EP6CGB+kO7wEUElMQgk54IjQ7EK5ZHz1/IcWGiG3fwXPAzVfqo0gAQoBSugeHB9rKax6PeMEYKpscp0/B2K/+nS5HFOntR7HtXh/zLDtX15sLPloORJEIOSSB+OyoMXUGdU3DULy301Vnl9rpD2nvq93AwzeM/khiM5GmqU7ZPJe/wlOq58s4tW85jcdAu2QEdaLepYcn9Gusn+Yr5BXbFa9fEIQMqMXp8rUIbQQ9t6RfmgQ7nf0G+wRRWpFs3p74k2tWHQ6xLBi4px/MjVIzX4vu/cqRPjPXBHVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiRmDjGFAqW9hsbNOsj6PpMf/+GEKIFkng3LidgTNZI=;
 b=r5TT768qJmRZ60b/IbBvwfLYS2C1CCIXkgxQRe4qUalh0npuC/P+9OB+5TpMJQ+7PgpcKwQXx0sGI3rEcLbeR4RRBZgVskurt/fTyxccbL7m4/G48GBU6lC39enDjctx+WhD6Zfsi+JBp7zvzFLWfk19RpzRyzASRPoRbIclH67BerHo+2QoLWNRZgFTTjZY4oWqHjhqgmGD1T7xL3PkUYTIGagjOA90ZAdv2SdUg0R65OdBH4Iq7qIC1BdA4+WrpCWhNj/HLUvc9RHNgSVDF+ZcjZIEhIkZrso+GLlIz16LwkzYx6yvSqaiQbIXf+fgSei3eq4GacNeCESvwSVWtw==
Received: from TYZPR01MB4209.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c6::12) by OSNPR01MB7745.apcprd01.prod.exchangelabs.com
 (2603:1096:604:31c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Tue, 19 Nov
 2024 19:08:57 +0000
Received: from TYZPR01MB4209.apcprd01.prod.exchangelabs.com
 ([fe80::8f93:1206:1c13:f5d2]) by TYZPR01MB4209.apcprd01.prod.exchangelabs.com
 ([fe80::8f93:1206:1c13:f5d2%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 19:08:57 +0000
From: Rachel Taylor <rachel.apolloleads@outlook.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Taking a look at the NRF Retail Show 2025
Thread-Topic: Taking a look at the NRF Retail Show 2025
Thread-Index: Ads6qYX0u1P3By/8S/Sm1YbjbgHE6A==
Disposition-Notification-To: Rachel Taylor <rachel.apolloleads@outlook.com>
Date: Tue, 19 Nov 2024 19:08:57 +0000
Message-ID:
 <TYZPR01MB42096D1E5DB5976BFC6968678D202@TYZPR01MB4209.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR01MB4209:EE_|OSNPR01MB7745:EE_
x-ms-office365-filtering-correlation-id: f223c031-c1ed-4e3a-90e6-08dd08cd9e38
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|7042599007|15080799006|8062599003|8060799006|19110799003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nmtjsP1sy0tuIWvMt8rQKZHoJEfi+4Jg7/SvJPZpcqfRT/kXDUJ+LPQhftZt?=
 =?us-ascii?Q?p6TLhgRc2F+368cfq8oJW3t/hhAAYcLw+GitJZa+czEGL8tpvh0/t4oUYwZi?=
 =?us-ascii?Q?9t8x1eiHgpxySxk0IzJhJgrfDkGZtGGU5Va+oI/dSn9Lo9nr3fu7BschYxrE?=
 =?us-ascii?Q?LpN7raGkvoLFBiDUT7CJhw7DY+Zs2Vz+eUi4vgLl29PVitERM/9dL7JPlbin?=
 =?us-ascii?Q?KN344tqCbMlCCJWi84HEPb/+WzaOLui3msy1eqI/r6ShiVHYFcaIH+6yDOog?=
 =?us-ascii?Q?nTQZ0EyXPHzhIYWsc+u5lLULO2GH8mGwSOboMzdSyu68leERRfBrE1+hETw/?=
 =?us-ascii?Q?qnw1OkA65SDV6GG6EQfqPFW1Hld0Y8tOtFIQp05LG3FyQ7d6KMs7ExeGHWih?=
 =?us-ascii?Q?N/3m6uD9qL4aFoa6ONeHYSysZuFYAfr1TmtP3kG5KnpXPycNq+Mih25dEH6o?=
 =?us-ascii?Q?iJvbX5DogZDwiUVelSRBlEaRYpnxKyR5sRPhCcvQlV09UPswN9XTlu0hF/tU?=
 =?us-ascii?Q?sloLfqjzYjsP1o34w0kpSFN0WHSQJWhZep+A0IgtFM6BPiXQCsNPC9eLQY9P?=
 =?us-ascii?Q?/bidca0Qhr8sMCoorssoDLQdLhJR0n6QftuO5Kj0m93NHtSoQ+cPptw+icle?=
 =?us-ascii?Q?fsuzSIGfjjE/7GkUNrZcuZLI7uqVWspyzanYofJpa33pcjGUr+HWakGSOFfR?=
 =?us-ascii?Q?VTzzdybbded2CnBQLOxmcKSuybcnxZENDcKPqSZMv/in596vrlqsGIOG7Mmz?=
 =?us-ascii?Q?mvk6IzOAti5mm7LI+vUEsATdIu+JDgRjqQPO6ngpXayBpe2F2gwYPWbzT9yE?=
 =?us-ascii?Q?i2PtFTjj/XyxTfYtLDBSGfFb0lGnex95YH6AToIRL59Mnf9Kr9Ct5UG6FPd6?=
 =?us-ascii?Q?gr/+B9FkvqexU8zm1ZN/N6ifPmI3PhaP9G9AzVEbg785cE1QFkhiJENCeGCL?=
 =?us-ascii?Q?gIyD4KjBwfDoUoaaQ39inLmY+1xr7+68KR5dSb6lMad5qAQoM8Zzt9An6gA/?=
 =?us-ascii?Q?s6OKnx71Txru9fTQx4FIErSSPfuJi/LbytydaX8VGlg+ZpE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3yKwBjuDddRGSqyxVTDgY+V6i2eRy0wftsIJyLjV5s8DTwPSkEwtIjbvv6jO?=
 =?us-ascii?Q?nUv2VW6JfcL5H5qiK8PIXQCtin8x/2buJafI7HCYNuqvfr1feTItahHADCqM?=
 =?us-ascii?Q?PmpMUkI+ffwLkOlIdoCz5ppvBgwfgrvYPDVX8yhDgezWPCQSI35pIYYMdqMi?=
 =?us-ascii?Q?oiruRgoF7c7m7A9BGuL8NyzMTPkgPGH0dm7pAxQLCunajWhfnlxjJLa7X6wN?=
 =?us-ascii?Q?rpWUzxu4RtZVSDRvRCMFPZPJD4sv7BcjQS4lNGNo3QVIKY4gI3yKy0DECud7?=
 =?us-ascii?Q?IGx6y2whUAqwDeeUMHOdKoMhqew3tkyNV1GiW2VVDI27FlBnILfowmEejKkx?=
 =?us-ascii?Q?RwdlkBNKX6zGrXhmo28N1C6KarGDnx72d2sEZqzfPhYCtVvyzePVtXkmTwQ1?=
 =?us-ascii?Q?1iuxIJNi1LUOEtJsSdJP5El8nwJqDIBIAFUiDcY98hNR+mWvcim82sKkTC88?=
 =?us-ascii?Q?vFPOZyuJLrWxNuPnKwHdP3ZPtHzVBN1PubV4OxKRU5UAYFBKLeS+TKNKeoUH?=
 =?us-ascii?Q?RvOGDsFmSxAczlRldXC5Jn5jXFCBqKXJwWzZFGiW3Lk0uLQmMcQDqj7eC7iU?=
 =?us-ascii?Q?CrSUOl9XvND6d/mh+iV9K9hv/OLBuEJ77hflDjXM/WrSY8MnHL8t95Gb1pmk?=
 =?us-ascii?Q?FcFDKvbGoz3YKX87ZT2PT3qtD9OolHG7Tifz1P90byBKlel7QhsR1bG/LMB/?=
 =?us-ascii?Q?HzNY2nOaZ2RVUASSwd1EhGeNilHme1w3g/h6ipK0mHjj0ytx+YFOVRq/OcXB?=
 =?us-ascii?Q?6+yMbjTCrbQewrBLTv0DTLo4gpWO7GU9t6IyHCw14rZhfwSz8dfWqKm78imH?=
 =?us-ascii?Q?agMY6zZn8hbkfifvPE6XB62fKBFDYR925mTJ4dO3mTivwkAenUe0Ima7ryXb?=
 =?us-ascii?Q?UbK7POxmY58uNGSNwrHkW4YsfxvDPfM3MRONznXe+piQp4QXplvSTYL18lg3?=
 =?us-ascii?Q?GW1d6QjTh9TYGuxpPnY0w7rvYLnrAjQtoyrmjY+RE1GutWe8HPB2OBaFmJCL?=
 =?us-ascii?Q?rKmgEdG6McqAxe44FA8g+S2pDvn00A4FGGqff8cwthWSGLXpPdJU0cz+iSQ8?=
 =?us-ascii?Q?ebuW1g8xAYdBNHrgBVVdWOzSMkl99PxBkg6gwhq1jvvMy+Z/jYjyeuFTfcuf?=
 =?us-ascii?Q?7kOIrGdK9hdxMt1fQcsr6BiCqfZ0NBxAkDb3OBDpI8hzWMtsgySnOPdrGDDV?=
 =?us-ascii?Q?ciMTa6JTaYXgB+VEMZNR3gJh01Bqcci0tGYlPhBsEAyOS34WFm3wARBMNw9D?=
 =?us-ascii?Q?YY14PX2QBLLZt3ol1JiJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB4209.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f223c031-c1ed-4e3a-90e6-08dd08cd9e38
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 19:08:57.1846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR01MB7745

Hi ,

Hope this email finds you well

I am reaching out to let you know that we have a list of attendees in NRF 2=
025 Retail's Big Show=20

Attendees count: 20,000 Leads

Contact Information: Company Name, Web URL, Contact Name, Title, Direct Ema=
il, Phone Number, FAX Number, Mailing Address, Industry, Employee Size, Ann=
ual Sales.

Please let me know if you are interested in acquiring this list, I can shar=
e pricing information for you review

I would like to thank you for never keeping me waiting for your reply

Regards
Rachel Taylor
Demand Generation Manager
Apollo Leads Hub Inc.,

Please reply with REMOVE if you don't wish to receive further emails


