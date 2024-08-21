Return-Path: <linux-kernel+bounces-296039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A90BB95A4BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DF22843C6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EFD1B3B32;
	Wed, 21 Aug 2024 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QNoD0Z97"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884691D131A;
	Wed, 21 Aug 2024 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724265138; cv=fail; b=l3XJzQI++xXp+IFoHzSKiAcjjWZ93byFZVEeGYAInhPlchawLrY65pzKh8olP+3NVTwo7soYlRKszFQxytOt40RX3kOasjABIWfBNnuwA/CjI/EYGGOK4AWcckp5mq5+gU6I+Tvtx6thju7Cy9yujJaeLDMvOQLtf7T6CtyHXMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724265138; c=relaxed/simple;
	bh=Us4qh8cxpb3BTDIVn0Q/4UT7GeUgz8XE0h3Qg/YDAGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=njLyjpj2H5nGHyP09VbJKvQVzq0AwrZog6N3/BAeOzoZ7oGIlKsU3P1+V+y/Scie58xUwved1dyZXWVTHH4vyWG9SjluZP1oLnwPkRBtdDmSfwH6qB49caYYr94HY4UDxxjlPolNx8pFfYMIyS3gsHbR5IPizj3ZOk7wH+ARICg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QNoD0Z97; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3kMaqmk2IT0a08N0b9jqH6djzXj8cIGCEfHNk8YfSPGBSkJoN7RO/hRd1hKN27eSsLfT5OHY32NrzUmoX/KDXERdApKRZ0GJM5KaahMhOyrENptYFapRhjNFBN16QivO0espAnh9E1f2dTA37efPFqIca/EDRwRFC+wD/msPc07c7gUTpbmvKbq3Y98VGSTo4Z4kPYS8T8AaMth/Kt1LxMimpzDf0BgwVF8J1soQ2j7//dDIWhs/9zR1QrmQXVWEyTVfO6ysjD9KVvAR8NX6Zq1Ky02vhEiBJugs6Phv1A30Oh8EzcRGI3GP5q72JSpGr96xiqGLwBD4DOkrKY0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lugTN0goczwfLqyw8cke+i3z52hH0HqLRtdNnyjF4Ds=;
 b=bSxd6mB5N7bqUi4fSgr9H3IzoZNFm0Irk/zmTwCs6+/J1HqCeKJlPJPQDitzCdvlByopuJ2dZ8OIwcgibk1raDImrrVWvllredSMX/+NB6DtT3LOIe1uJSh8nbXMuH0u0xwIjKR7yfLWGu4Kg8p2soDt2WD85fBFTP3j/SFZdygPDlGrIZ5R5nWahiWoFWxhSlMsqboNSyc3NR3+VV6Fly/9ExWCMtM8EauGb7yCk5pVhg7tSnVvNpiL7GsTvpySQ/8id4VEgievBLc/IFrWjIOI/Z9mSxiuLnRusvq4G3//S2Wrx9W6HWoZXQR5wun9Kj9mgk4V0xxc9S2blekghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lugTN0goczwfLqyw8cke+i3z52hH0HqLRtdNnyjF4Ds=;
 b=QNoD0Z97DzNLFzl5Xsx/lPNc/Vcy29JV4HGvOPdqnZO4IHmq62j9kYGBl6eOcY6NY5wcGaInkmhIxY/nubTeNVG8Mw+2DBRAFBLXVaIL54vZPrz/jh7XsrrA7jSFKCCNmh6JHlZCuE5t2nhxgaSG0kytqcGThIB5RIqC7lTEjro=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DS0PR12MB8017.namprd12.prod.outlook.com (2603:10b6:8:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 18:32:13 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%5]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 18:32:13 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "mka@chromium.org" <mka@chromium.org>, "javier.carrasco@wolfvision.net"
	<javier.carrasco@wolfvision.net>, "macpaul.lin@mediatek.com"
	<macpaul.lin@mediatek.com>, "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
	"stefan.eichenberger@toradex.com" <stefan.eichenberger@toradex.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "git
 (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v3 1/2] usb: misc: onboard_dev: extend platform data to
 add power on delay field
Thread-Topic: [PATCH v3 1/2] usb: misc: onboard_dev: extend platform data to
 add power on delay field
Thread-Index: AQHa42BOY2AeUS9f40qbc15/HkSu1LIbpoAAgBaBDcA=
Date: Wed, 21 Aug 2024 18:32:13 +0000
Message-ID:
 <MN0PR12MB595385EF839377E650B47274B78E2@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1722440548-107682-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1722440548-107682-2-git-send-email-radhey.shyam.pandey@amd.com>
 <2024080751-mule-ladder-cc99@gregkh>
In-Reply-To: <2024080751-mule-ladder-cc99@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DS0PR12MB8017:EE_
x-ms-office365-filtering-correlation-id: d81daaf0-b1f8-4e32-19ae-08dcc20f9370
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JdwoZdbNsCiUaobb0EzYWZ16+cGkKDmsWkY/fWA7MMByF2Wygaq1wGxM9IP3?=
 =?us-ascii?Q?rBffEx8+ETQTLz6L11DWGC9Q3QEqwN6n+Eo0LBI4DgXHXRm+/UQ0pAH+QkqT?=
 =?us-ascii?Q?IjgNUG5O1ArtMUquX3QnoEVaPuOFZX9idznDrvmhqKwKRHXqvs1ZsEn+xUBE?=
 =?us-ascii?Q?804Y40xgTiURFscUH2YIapng2CFlT2dUtTKyEuwxilBtUY+MGsK/a4aiIHc2?=
 =?us-ascii?Q?YYTrJq79XQ6D6rsw+7zLAVslfyKNfYFqwJ3ZQ7LEZm+kWKmjzn59xqn0nGZi?=
 =?us-ascii?Q?j0652Mo1q/OFDM7DdP+ZWezytiXjmmjE3fzXNS750g9URUqhJ4qhpqXyvN3q?=
 =?us-ascii?Q?lN1PIn6iOM9Y0XwDQsu9FD6N2q0MLbc3VK2CTE/RJ/JXwvarSFp6cgHS2sMS?=
 =?us-ascii?Q?L9ERbqyaJttia/LeC3H4gXJKe0IKxswuDUK0st4bDNsvMETJ9wMDsYn8Diiv?=
 =?us-ascii?Q?lmFS8XcCj/uIiXzA43m5PSf/UsnzcX36jy4bdt7qMWRsoHCHhPkjzech/AAQ?=
 =?us-ascii?Q?H5ex21a5fRVFU/YSeL+aHDBh+tWCLxNXUwS3ZyTzM2NL3m78ZXlGeKHOHlnH?=
 =?us-ascii?Q?9wyWzP8E4OYsOoSQDn/REJVuOJGSMlyXn948Mv37uE2xxBPsHOMrFbl4d5lB?=
 =?us-ascii?Q?HxgP1UKiV/QTg899jouRgHj91w7sCVu7rhAKXetUzaAZK7ATGykIdLHkw8oI?=
 =?us-ascii?Q?1tDfoIlpHYqFbHcCvN3AptEn2dX9hNGx1gyJ6RUs/nw2Y8bk2ojuXqYgCTAz?=
 =?us-ascii?Q?ePFhXV+LqC0DmkfMzKs/pFuqR9eFLZsI05urc0jp/g4YHxNbJ87C2GGS1yBs?=
 =?us-ascii?Q?63u3dYoCooGqffXLZehezjiFdqBKEjZ5tPzNLCeM1pYXnG4CdZpIEu5RfPzK?=
 =?us-ascii?Q?nrTqyMclf5c76GHJAIyNJAAIm9K454RIgGdwGF8a8x1GRcm2UCbewbISQ180?=
 =?us-ascii?Q?FKndhBudWYH6dFOARd6FffUfINf5ZL4VPsCx8Pa+UPGbU/ceLoVQKsKXsJ/8?=
 =?us-ascii?Q?5bYWSiM1CPFjj/zY4op0doYynG4Ur+AB+YLLLQdtc1QP9p9g5yZB4waqJ+TE?=
 =?us-ascii?Q?CeNprC6jJfKr8XEqv4RcZnRdPo5P5veLikmVnyiaFu016ssrinjY2WM7El9w?=
 =?us-ascii?Q?UoG5WnU6XG32R311/qEzoVcBGMnbjx66X3AfrBfUWkzTFuQl68TWRYCEpQP0?=
 =?us-ascii?Q?M12Nbhp7mD/MggPiFVXT8qQ5jexut7gc/HJODv3eAO/fYPlkLobRyn731tLx?=
 =?us-ascii?Q?U3nn6KkriTbYPsh7FXfSMLc2q8ZRNwymy/SB20rZPK7F0MIHLjJHOtnUSYiw?=
 =?us-ascii?Q?9nauPw15SLLNKUstgqfqVw/rfGpSQUUcwNEzqCepUDLfHAJ1+QIGZ+xhrR5S?=
 =?us-ascii?Q?hhuChuTwuFOSV6anbfmZMMNez2ieMQHlFYq04fbJD1RFxNycag=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pQW1rgiGnbDTf+ziiTsLcSrh3jwQHPdVGlsZpguhQNRv+GSInyXc7XA9GkSS?=
 =?us-ascii?Q?tAMrgYAOIy30BWR1Rx3nnQnMP3+RpWoDPt40hMPA4tX39kxRt/wAI61V5eYy?=
 =?us-ascii?Q?kZiir3gOocKW+pOuihtuQmoBpicvPrL6ci970gvBP5I7bQf6lVBV10M595Re?=
 =?us-ascii?Q?y/4ra9tureKu/lkgimNSY0UGd+MBGcJSMiHLWrPJm3MrB0yrdo09uW/BAWOr?=
 =?us-ascii?Q?pAoJtF25Emwcd31PGg/I8ImfWbuoPa+/TQDclrWbAOebnBseG9xUHZWNupUo?=
 =?us-ascii?Q?9Ry2AYLL7Y8yRYNeuzWSAMWQr3WqKqxBd/DCANdESbsbg61RslP0lxck8gOU?=
 =?us-ascii?Q?dXyiXUfbeoDL7yoP7yAAMJe5vbkk70f7IRh1x46JtuVWx97PMHBKBfcQFSVP?=
 =?us-ascii?Q?L6SOGwLwYSlxFvNWCuKwlQb0Xz4RG4Awbx8ieQNMQmWUkCCt8y+nFg9fA10M?=
 =?us-ascii?Q?AycG1YXXijuqwQCRoBVnZ8xaM1RcUtZ1eMTWWxgeI52lWvPhpcV4xKNwbVt2?=
 =?us-ascii?Q?+GgAghHDbatVz93ej0JCstLBbhdouAYqCBj5JkyahqSiOBc5cEPJcQ2Pqi/K?=
 =?us-ascii?Q?SSruF5qwFcXMMUrdQl198QOBpF1jGiBuCDIrY91bf+mTEQIU0/18nS5BxtJv?=
 =?us-ascii?Q?y7EuvkXUK+yd7CJL0Ohhmu9XHpKT+3vgTikirzBYruXBV8tKqvV4fhz91tIL?=
 =?us-ascii?Q?sQlBV0DEiyX7yTi3wQOkjd0kZIhk5q2JchNNXMLDo9zHarMIEQFzrbCU5ILC?=
 =?us-ascii?Q?weaikWUwPJJSkd27npqP5b8fbnU2/sjL0603Fk2DbSWI/3G3Mpqv6gSQWUft?=
 =?us-ascii?Q?bMZsaZ78VYdVoeguQ1a14knhrtn30FpJsgXWH5qrCsa4UXjBUa2rU3QJ1Pe9?=
 =?us-ascii?Q?Isk2kULZ33/tKb+MJ4wIVeT/pSNVPCJeO0FUY9dy3Y960dBj1V3C2d+8EFPP?=
 =?us-ascii?Q?/AYmXDzpFFo+Ch2nd/q5DnL2e/mCbXdJ6fn+9CF0qG/sFc4eLXLKFNN9BGE7?=
 =?us-ascii?Q?RQugkFBjsvnoYQHsBWtasgMmQJWb70ePbUOpALVtaT1B+mecNRfCjMWbKdcQ?=
 =?us-ascii?Q?McoqDPJ++hsKWhChi/Dbt/MUqofT92xhEkgarXt4fiDl4QMuI33NIfUTrZTY?=
 =?us-ascii?Q?+2kJ3S5OQr4dg1CBpZQaJKFVdo+ev3eStFqgVBXJCUsvycW6W/kxjoocilM7?=
 =?us-ascii?Q?knHv5dcNXL6S4hpbamxurAnr4q8wsgny78sYs0TqTaNBMM9TUx6etS5qanN0?=
 =?us-ascii?Q?DrrN1EAt4CtNwhplJBFgM8xxUSWlZsWnXRsmofWVuhwmfxLrEE6xrKBRJlPj?=
 =?us-ascii?Q?/C3ua6iM3kn3VTKbnBUJiKsSIs7JsR7VCNYK9G1HoWVQsZ9vWp6QixW4wyA/?=
 =?us-ascii?Q?3KMX+MLkyn/DxKYplLWqyhw3/5E36rEEpA/86+KQo2xrMqJQaSiMdr8WA5pP?=
 =?us-ascii?Q?IZUEx1E438Do39KdPFO8s5YwUKDtmyVNxEA7Vbs9fHNLa2XKgzJBnaQ2XECm?=
 =?us-ascii?Q?huIz9KdvadLr/KJONJaEnrXcnRsutKEyHK26E1nawKMVoncu7e4DquBpgXQv?=
 =?us-ascii?Q?RQJvESAvKTLc8ooCoUM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d81daaf0-b1f8-4e32-19ae-08dcc20f9370
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 18:32:13.3244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mYnS3nNYShdvimQxGN3uCypsjORr+WNQ3sA21An65wEYvRenIa8SfqkcTHGWnb6M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8017

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, August 7, 2024 4:13 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: mka@chromium.org; javier.carrasco@wolfvision.net;
> macpaul.lin@mediatek.com; jbrunet@baylibre.com;
> stefan.eichenberger@toradex.com; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH v3 1/2] usb: misc: onboard_dev: extend platform data =
to
> add power on delay field
>=20
> On Wed, Jul 31, 2024 at 09:12:27PM +0530, Radhey Shyam Pandey wrote:
> > Introduce dedicated field 'power_on_delay_us' in onboard platform data
> > and update its delay for USB5744 configuration. Hub itself requires som=
e
> > delay after reset to get to state where configuration data is going to
> > be accepted. Without delay upcoming support for configuration via SMBUS
> > is reporting a failure on the first SMBus write.
> >
> > i2c 2-002d: error -ENXIO: BYPASS_UDC_SUSPEND bit configuration failed
> >
> > Similar delay is likely also required for default configuration but
> > because there is enough time (code execution) between reset and usage
> > of the hub any issue is not visible but it doesn't mean delay shouldn't
> > be reflected.
> >
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > Suggested-by: Matthias Kaehlcke <mka@chromium.org>
>=20
> This constant addition of "platform data" seems to be duplicating what
> we did before with device tree, right?  Why can't this information be
> there instead?
>=20

Yes, similar to existing 'reset_us' field i extended platform data=20
to add 'power_on_delay_us' field. I can move it to device tree but=20
think there could be question on why we need to add a new binding
just for this property and not do it compatible based platform=20
data considering this power_on_delay_us delay is fixed for USB5744?

Thanks,
Radhey

