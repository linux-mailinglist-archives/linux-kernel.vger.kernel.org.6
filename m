Return-Path: <linux-kernel+bounces-544034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4655DA4DCA5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0D53AB209
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EB71FFC4C;
	Tue,  4 Mar 2025 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="nc/23kYE"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2092.outbound.protection.outlook.com [40.107.20.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64741F76C0;
	Tue,  4 Mar 2025 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088012; cv=fail; b=o739Ae3Oo7ySd7byP3gtnrzcdeS5jdsqslYidws3ccVs4E01bIejmXB8bMegtbdK/OOGw6O8NjkgPaWDf3K2XrF9xk3167RqBtOeNMw6E4nmiIt2jSksLP4vB/mrjvQ6iA2nnBZJRDETztg/OQ5kgFzcxXU1f+hItF7n7laYrZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088012; c=relaxed/simple;
	bh=gWNra89NcobKT0HIBrDptsDmrMvz+1vjjLIqH0xcazk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gvuZJ+hlBQvT0qPZ8QUV54PtMiBiTgyLSXTTG+Sls4RgiZ+GpdUwN1G6+RsfBHmJ4KGj9IAzDC83nKZ0CUCRyxx7WiwQcN2/zGqk7b52P3RB4kb+zQL+IdAl5CvOoPWukuDqkksqbAOeNgvDps35whNlsxSkCvxftDaM3rIdhgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=nc/23kYE; arc=fail smtp.client-ip=40.107.20.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yN+aDCROxZB0VfcLNULNM6qqM8Tf4TAtEI1MJoEiHJE9kR7D5nI4LioQDI0Q9nEDyhmT44Kc6F9Yc3HcBWFN2WKplzNFGMqleKlJrU+hiSBwydxYlg3DK8U4FQtAcG/pUj6D4tDWnhStdKHDbSc/zoeg3L7vAxqC28Van7WFvtBoKmCnOl2MAnWy5m1JVId749+/ic6DqPBULh1fsnOKDTswAuy5tfOZifubLHqQILUWdi+kRtYc8Her7qZNYP+7kiBmbxj1Ddq+DrmxQJvuZ45jQN82CjbIza0/AhH9i0GMeneiJI0wd+HIQLfZi4QDzJb1RH8+3L2vM2zZpqObpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWNra89NcobKT0HIBrDptsDmrMvz+1vjjLIqH0xcazk=;
 b=KqX8K3b3dgzpCC7BrI1tTxPl1ytVQODEgnbaX7irmzW7iMGwixMXXbuwFT8XOVfKg2Ydi9/9jWOkjbao7RDg+vGy98JBF/I7DFB12IL/0fpCLwejhs+9zNUJlqbGm6Os6vrTeZpT8cbPJYidDYmWvVmW+9tay0gEqFyFWlqN73q+yfB2s4720mo1HBVcBMBB/g934mGSUIcO8HXXp/lscJFpo9AlE33ZMzYSFKPdOV0Mo9TsmYNqXxaEXqT3cR7o19zbWTKhJQybu0pKzF77NH6viWySnc5IG3LHTw/0R+kqPqMq0bynT7UtN5zCBvk6udi+nTqntZYY9ozbwS+r3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWNra89NcobKT0HIBrDptsDmrMvz+1vjjLIqH0xcazk=;
 b=nc/23kYE5qAH2zlXM8xQnjJDAyi+39MJ+lwomm0ApJkyiXJ3GtD85tm5l4wIspPbF61SpkoUyOXDy641mEORIzAwp0VwEuJ/1KZajRiRWGvmbV+Io0SQ//WRZiIH/xTWbXifOGR4md6vwmUrP5o7cHmVmQv9VskzIN+5CmfCt56DB3MPSGwByw83jHXYhpQOaXPKGrVgNOrmUL8zsNvfwJu/T9QgcpohGpRnu0p/4z+pUNlAD2oXwAYNmtkPRe0v4y5Q26HhoNfCFmdJ293nkBlNJV1mAJGl0RfImqQnH3P92eD8ItvknqmDQoCGzQqlGWv2+xcM1RgQ4KykireKYA==
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by DBBPR04MB7659.eurprd04.prod.outlook.com (2603:10a6:10:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 11:33:24 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 11:33:23 +0000
From: Maud Spierings | GOcontroll <maudspierings@gocontroll.com>
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon: (ntc_thermistor) Add min and max temperature
 attributes
Thread-Topic: [PATCH] hwmon: (ntc_thermistor) Add min and max temperature
 attributes
Thread-Index: AQHbjN7lsSOLtLm4Y0CUYz9ZultBILNi0tcAgAABdp8=
Date: Tue, 4 Mar 2025 11:33:23 +0000
Message-ID:
 <PA4PR04MB7630FFDEE9AF8E1458DBA6B0C5C82@PA4PR04MB7630.eurprd04.prod.outlook.com>
References: <20250304-ntc_min_max-v1-1-b08e70e56459@gocontroll.com>
 <f2b58aab-6664-4968-86d9-1e761a41b065@roeck-us.net>
In-Reply-To: <f2b58aab-6664-4968-86d9-1e761a41b065@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB7630:EE_|DBBPR04MB7659:EE_
x-ms-office365-filtering-correlation-id: 5a641e49-6320-4f71-1ab2-08dd5b105fa1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?y5oQ2zkc2GPNJe/mKRZNYQgFLcf4qImmO9CNn0+/Rtf5KuQ3UxQxLuSgKq?=
 =?iso-8859-1?Q?yWW5Bjv5q29ooZCOYwskjMs+WD55aJ0u5mfA63UwggY4ahGidlUQPSJQjX?=
 =?iso-8859-1?Q?hcL1qXyCgayP30+y7IzRM/i+lFP4vxoicPfKMs8tvmCWyET7RW081gBclc?=
 =?iso-8859-1?Q?qXIkHg3L6PQgon+j94ftNdmnJ/Oep7/914CwmH0SrIQBasKdfRvxquwJsU?=
 =?iso-8859-1?Q?aHcLTJq/TjIj5LJ7y/5EFWajOuO8qozqU132qaFgSABJHlrdKP7Hrp1pJq?=
 =?iso-8859-1?Q?JdemOUNEh8u4DKql+Ldjs13Unh8BJ4wyL6s8rkvFFWqcQREgcz/tR+4XLJ?=
 =?iso-8859-1?Q?ES+dT78jKX5DvwJUq60BpPNL6Bv9OVIR2raZmlI4/HNTCX6SkciXLLFZE6?=
 =?iso-8859-1?Q?KG0dbca5Z5y0CsEuIYDfrswCnZ+bdmiuFDdF3EyfVfzgOSpg5KHtz6HP3i?=
 =?iso-8859-1?Q?O3Os7b1vxgIfTaGKQ4krkU4GtUdhyA7Y5tQflQ/NOuqn5Ea2vD+TPgk7OE?=
 =?iso-8859-1?Q?6nBXK8ycXzxrSie+oN8C+SK/aZxXrrhDQ+5Lp/zTVrHkC1Tqus5xszNbdN?=
 =?iso-8859-1?Q?s8glSXTacNheGP9lrjuiHUFMw0l5XLSv0PpLDyqAC6RWTa2GbqP+o7vhM9?=
 =?iso-8859-1?Q?8MeS36kf7/ymV77uCt1TJgYT6fWOcYZvXuLTbVHmkZwUSVt1ruuJU7HLAv?=
 =?iso-8859-1?Q?L2LZr+Fv+ClJ0U5xq8ycs+JmZbYLqMcCRjkga51rIRjd0XqJIZBcjPRYTN?=
 =?iso-8859-1?Q?+vNpwMutnXLbQ+/htJkm3+tw0WxxWD12JdjTbOTHFcoEZuwxlMf0x4HVfu?=
 =?iso-8859-1?Q?CY4arxSkYcIJ7uzt9KOfy1+Vzaq1Rqumq6Mpk/KyJk79TPREG59kKP+Ztf?=
 =?iso-8859-1?Q?0xBMWv9ndB3wXFBEdVDZCT6zdco6gbECm59SufKiwucmyhVP+hhrQZm4ui?=
 =?iso-8859-1?Q?pKtIAv+KIFARJRYkkkm/arEgH1ge6/e1xT0p7OD7XyMkzJpTnzmWAzVXOB?=
 =?iso-8859-1?Q?Bc8OwpuwYTXpTLBL4fZIb5fLx+DyBcNRunBiESHiia7I+HVeb9ec8DxrvS?=
 =?iso-8859-1?Q?8oEp9qKqSnN0Iu44fQWL/COZwO8TIYyelsI/8rNirz5LaQeikkBCTGCY03?=
 =?iso-8859-1?Q?qE4u1pGit/bs7xaBo3XoCsdFXqIOhOKk77c7+Ry/kh3MFOf7u2DUq5IPhf?=
 =?iso-8859-1?Q?5ezYF0YA6Mb0G1PwHnPW4bVwRI3vysl0ndt4Gf8FjznKRKcpZ+hRljX6nA?=
 =?iso-8859-1?Q?MBn5w2h/kq3PvL5Z5OprfTS2Lt2BtB6zF0UHnXGZFAMuMxKqcdibPksFLe?=
 =?iso-8859-1?Q?ZiTpVEAvxb4X3mwQLl4hZosS2r48UrqrLrsEZIdSCWkRFVsslysyp6hTvR?=
 =?iso-8859-1?Q?XPL5kGIXcnZC8tr6TYwET1RoewpI8k2Ej5xHsW1JsC6K5/T5zVbBB6kpAW?=
 =?iso-8859-1?Q?0AL8ezvIjLLR7FUqAszGshx2uANaYIyXXwHNP8CvxszmOJwr4Lb3mnhCSM?=
 =?iso-8859-1?Q?aKkukF4gakL3PeXwG97vHL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mt/dk6McmnEjCi6eJd97BsPSYngbvEYty1Gz/a8Wv2hCzm3mSETh+qv/4C?=
 =?iso-8859-1?Q?R6fvqxO7uB7m3dFN+lH6w5ePv9ZoCtOVHnhYaTl3KI44SUNPKO69mMhrD+?=
 =?iso-8859-1?Q?nwgTZMNdBG84vPCuu7yWzvoBNNSkmEKVrB026FjQSngvvDGJESoC/L2xY9?=
 =?iso-8859-1?Q?hG4B1Zh9wWjZEMCmPo9XKgmkbVy+/CjQJ9ISNAkb8oqADe/xCEu6s3jgpL?=
 =?iso-8859-1?Q?W0wTm6jAmmIqiDU+ZPcwYffxJ/WYoAdavOjeIfu6WrQq5XuWed7WZa6Htt?=
 =?iso-8859-1?Q?/XNcyHZlxH/1b1DZXEK52Bz8f2rDNvrXo40BGba+sXlnOEQricKAU1r9rz?=
 =?iso-8859-1?Q?9RDtgqJnuv+/PYvqnU/FlPnsox5eAPtyrAmHfXakrlW4b1BOkYdfwwR6vI?=
 =?iso-8859-1?Q?SiALkNPeqLuJj7xmTsfpdP/TGYQpQBvZxFgs8W1pBARAzD4jBHH7ufTMVn?=
 =?iso-8859-1?Q?2jE+V1ZIx9CeRpu3JmoC8/bIjWircOKQLuwNU55iK8EVgz3mBTmLXz4/5M?=
 =?iso-8859-1?Q?KjBHI0AKTP0ArusQqgAkKKcpauRc9CHGs5PM5sIHBbt2K4vjMSQvd9BYku?=
 =?iso-8859-1?Q?TuOjjhUHIr4TLVIVr9uyF4pWIGTOt7eRPe7/cLqa1dEytucx9UPy98FeIh?=
 =?iso-8859-1?Q?xTCs5IBhIxT/0us1cCfcNDAUqeX6PE24ikF7Rc6Ds6WyQjVEiBMX478xZL?=
 =?iso-8859-1?Q?PJ3WHLyE3ONNI5QaL8MA+SbVhMHfvO1VvVHZAZKdiCkaG4LVpdhgXUynTN?=
 =?iso-8859-1?Q?4fNlCCwhU5s7pmxF+nEQGFnlm5dLxNlSGm6cjIqmMYUViEPpGVk78Y8FnF?=
 =?iso-8859-1?Q?8vtnbSvRzqseDWOVLDC9hpQ+4orMRRZNFjAFQBypA7DacxIMIEnujjBXut?=
 =?iso-8859-1?Q?5oDgUtYpEvMaRju0a0/DQqE82x0wA160+57xjFVz1rrNkP06P2uUqkm0xf?=
 =?iso-8859-1?Q?ZQgvnV6SNoyRON/vHT613szztxxBSWnd0543OWltwuhaeNZNNPnleogRwJ?=
 =?iso-8859-1?Q?L1zz1VzLfvAtBk4m/LI71u09g8HiejoLePWfmYOsWSDNxgY9Uz+S8/Zj1c?=
 =?iso-8859-1?Q?FZiPszl9FNAH4LIKq7k+UNZ6wtJcJ/uVVHjjBSrIHlKu6B9ku9R/tn5U+h?=
 =?iso-8859-1?Q?KYILLOcNPrgYWb7Dx+Mx7A0npzVtaeHApu2NFkUDD9RiEhj5ZlBDAwkIBU?=
 =?iso-8859-1?Q?CsywicHOfR6BZvBQ0WcSA22m3pD2mFVhCo4ITyU2FaMobX86MF88col+Hl?=
 =?iso-8859-1?Q?rGxxMSylcWMHc4Uj3k7kkwMEKQTheLXMNDGGCfrUbrIJA7ge5ai1EAL+Wz?=
 =?iso-8859-1?Q?Ga2u1QLeRfznaW4QlnzsWhzCnY31DwSzCjAlbzYKcxeaq8fOoLRQQPEG1g?=
 =?iso-8859-1?Q?0bssNVWz7B8vroIoa0kxIGIJd/hOykB4K/VrgIXChKjDB5Gqn0IwG9+dvP?=
 =?iso-8859-1?Q?LATt1JbiP+AVJycBuSSiNmgIRoCgqFw61GH+Dib2QkrotiQKvJ/Xwk4leF?=
 =?iso-8859-1?Q?tG+Pn1eRIG2h00eHeV6EvzcLVG9c4a94DI4tbytRpY5OYaM/IaSQx7vFKi?=
 =?iso-8859-1?Q?FO/SWhisc31mlTzDapcNOPiotSK4x350lwO7UBKzkzBD/vBaEOk1URsd3w?=
 =?iso-8859-1?Q?XKeuL6bHe2+6FZL2egHhLgEtzRepQ4qrUNCJLPpHmiAJEodTI/hn25RJU7?=
 =?iso-8859-1?Q?FvZwPlgQxtNANvvBSbEcS9wvYO54ZEw1h+3jW8ngsO35tr9knnWBotQcSJ?=
 =?iso-8859-1?Q?9MKg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a641e49-6320-4f71-1ab2-08dd5b105fa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 11:33:23.8324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /woX4pHO+JcMHmfHZmWke6yI6E4LitTlpBH5a23RU6CSeSFVy6sVR88e2cHemcYuC8BYqqmI89zSf7VEGQ940EGtKflk0dXk7gRR1xvrhNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7659

From:=A0Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck <linux=
@roeck-us.net>=0A=
Sent:=A0Tuesday, March 4, 2025 12:12 PM=0A=
=A0=0A=
>On 3/4/25 00:24, Maud Spierings via B4 Relay wrote:=0A=
>> From: Maud Spierings <maudspierings@gocontroll.com>=0A=
>>=0A=
>> Add the min and max temperature attributes as it is trivial for this=0A=
>> driver.=0A=
>>=0A=
>> This can help with detecting implausible readings and indicates to users=
=0A=
>> which range they can actually measure, so they will not set a trip point=
=0A=
>> at a temperature higher than max or lower than min.=0A=
>>=0A=
>Unless I misunderstand the driver code, readings outside the table values=
=0A=
>are never reported. Also, min/max are supposed to be alarm temperatures.=
=0A=
>The reported values for min/max would be between -55 and +155 degrees C,=
=0A=
>which does not make sense and has zero value for trip point usage.=0A=
=0A=
Regarding the driver not reporting values outside the table values:=0A=
=0A=
That does seem to be true and is good in my opinion, however currently=0A=
125 can mean 125 or something higher, with an indication of a max=0A=
measurable temperature it can be determined that this is a max value and=0A=
thus might have extra considerations.=0A=
=0A=
Regarding the meaning of attribues:=0A=
=0A=
It is difficult that the attributes do not have descriptions in=0A=
include/linux/hwmon.h=0A=
=0A=
Is there an attribute that should be used to indicate this maximum =0A=
measurable value to userspace? HWMON_T_HIGHEST/LOWEST?=0A=
HWMON_T_RATED_MIN/MAX?=0A=
=0A=
Some extra ramblings:=0A=
=0A=
I want to have some indication of what the lowest and highest=0A=
temperatures that the sensor can measure are. Imagine I set my trip point=
=0A=
at 140 degrees, but the sensor can only measure up to 125, I would like=0A=
there to be some feedback that this trip point can never be measured.=0A=
=0A=
Some kind of plausibility check may also be interesting. For example I=0A=
have an ntc in an lvds display, if this display is disconnected it shuts=0A=
down because the ADC reads zero, which means temp=3D=3Dtemp_max.=0A=
=0A=
>NACK.=0A=
>=0A=
>Guenter=0A=
=0A=
Kind regards,=0A=
Maud=0A=
=0A=

