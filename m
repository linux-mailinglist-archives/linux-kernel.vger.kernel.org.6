Return-Path: <linux-kernel+bounces-358559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2865C9980DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF9B1F25224
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410321C1723;
	Thu, 10 Oct 2024 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x3TM0OSe"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081901C0DF5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549673; cv=fail; b=CPJDX0J9h06FseBfn5oq9fpF67AmcNt8HenxLq88MfiHAtZhC+rRr2Ziubgd3HhlpeRxA9JHUjmdsAYcQpWlVRrH9spzQQXWSvl/ZHrAhLiXB3DK6rjzha1OYERYdbKKeJJ0d6b+qdUWxtooWI4wuZlIgAQPRUnirJwVBWTuZlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549673; c=relaxed/simple;
	bh=PhBDf3vHu8rUMg2W448j2unl0TvArG1OigPEEj10Mwg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QO8Xa6YEgdTKoLOYjAyBP0mdc57uHZ5xceA5uA7uMXVmpLeAZi5Yu3OK4xH4wifPjiqMZ+WpF0hlVJRGJrhD+9EwJAV0hyAjWosc7pJMctboOz+a7QiNjKJFx5CR19Irw0cZU/6LkPmC/5TY3yZ4w6X77xSZRihIdv0sVE8Fg5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x3TM0OSe; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYmIST2+zVl7POHU/TB8rEBaT/p48d5aJ+Z2NORcTc0y7fYuuG3/pknNGB7BlCDdLcu4K7VvJ3CXrthuo9fwWjzqLb49CZrx0eifBGRXhXdlFEdERfpfAFUfZKHOpRxDh2viLO+qVkwlvMtv1kpxr9cSplMuEvaLsjUPyrQptMZ4xo194UC9Q+Z087GnBSQuOLd34WzwA8yfDgNn3GFfKwBsIt6OeyWQ4WVRpVpxXb0ErmUULbQ32X4UOAIUHG4VeKYYQhC1lcaoMLM+eN2Chn3Gb3BOGgyFznqgZXtdUae80fu24OoySsYBTCvAn3U+08jlYlpoyFhxzy3kQyFInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pg6wvMKY4j5BZkgnHX7n7GYoZI23XClvF+KHkBr8r1E=;
 b=uuQG3HwA0kxVWJZJkzpNl+z6Txh3chKkAfQrlxaEMSu7XiGrcR7KFbElTVFpOA1W/47fd+FMF6TOMFFzdXJi1AbLmadD1RgOcvBu3kCTyxkJGz7uFkRJQmv6PqajNNtIkpWv340HcL4MvrXgqCemq6ktsyz/m88xPScchHgWsU4zmY7rRwoNTKaa4M+0LY6i+ZZIQLxUMu5/1SwFs1IPwSQPWTQM1jB4t80QoXMhUibGOqmiRGhqLaRuFkHrzcSdoTU9dh39PSgXLvwkSmJ2dDOHzBzbpUnQNVETMsQnfuBOUmxvnGxj8Ii1DKtgARa3XZM5eZTpvUQZQ7l6wp598A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg6wvMKY4j5BZkgnHX7n7GYoZI23XClvF+KHkBr8r1E=;
 b=x3TM0OSe4a0a4reNMGw8jz9nWEUCNLXr9uQOn5YS/R4FoBb1ud0wSWC/E5TnUZwsCLpQGSjCD99x9dLN327FtX0k6VtVwSS0ybQZYRCuTp2fPMXiFZjrtU/FLsZfUHuN1uMNSoJu/6AMcs/+OAir8E1vSerkH/4sCH0SbtSwitE=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 08:41:09 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%4]) with mapi id 15.20.8026.020; Thu, 10 Oct 2024
 08:41:09 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Jan Beulich <jbeulich@suse.com>
CC: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?iso-8859-1?Q?Marek_Marczykowski-G=F3recki?=
	<marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>, Stefano
 Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [PATCH v2] xen: Remove dependency between pciback and privcmd
Thread-Topic: [PATCH v2] xen: Remove dependency between pciback and privcmd
Thread-Index: AQHbGupfp7VkZjmg5kywfP9O2WdcyLJ/o+wAgACL5oA=
Date: Thu, 10 Oct 2024 08:41:09 +0000
Message-ID:
 <BL1PR12MB5849298F820763B42CA7A34CE7782@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20241010075848.1002891-1-Jiqian.Chen@amd.com>
 <e6d4912a-d6d0-41f8-a3e6-fe3eec6c6807@suse.com>
In-Reply-To: <e6d4912a-d6d0-41f8-a3e6-fe3eec6c6807@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.8026.020)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|CH3PR12MB9196:EE_
x-ms-office365-filtering-correlation-id: 8a29f465-d556-4a54-e2b5-08dce90749ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?pSPXk9SvvmJGwVGhuE2cy+d3xke4Klx0iXaq7CVQyjiKLKX2SZcwFOe1EG?=
 =?iso-8859-1?Q?V1CyLYN2qis4fr+wfiLVU3rIJSL17/nh+R+WQdJx8LlknaBi3O5N7eM7rI?=
 =?iso-8859-1?Q?g9sru1+lbR3RTr/1K0ZO5InXLn1I/ub6WUyIUPftecyJqkCIt+pIAVQJuo?=
 =?iso-8859-1?Q?f+WGhubQHxqv/TcETrYE/2npRcmKwBtkG4sRFrdkc9eQjgaWwBD3+t6iTW?=
 =?iso-8859-1?Q?cjFjh1kGNERkmDarq2gHccdLtvkB9+S3OFLV64mo4RZ8gxm4JXDtJyBF8y?=
 =?iso-8859-1?Q?KOsEKDhp7AEtLusCRQGNBifiyVMFHYzqQ4tJ98IFvz5Dea3q+mANjVTNrh?=
 =?iso-8859-1?Q?a6yGtk9OLLxHmnrdlhxS49nJMk/PZVKQfXRiTp8JOZF54Zlp8apBZW0wb6?=
 =?iso-8859-1?Q?FBXbFC1wlQGnzVXSeOJ9qd0IJGSOIsq0I9mIZW6WiBGHVtmc/WfSCpFCMs?=
 =?iso-8859-1?Q?+Quo7vCmXmgCuId2c5pW/H62Z6fs5KoaC9yQKVfij1qqTEbQxy1/IEBHT9?=
 =?iso-8859-1?Q?TkBrQ/Bzd6xasSWCw+2IuW4YA5TRtRAf3Do1839/UT9fSI56GVT80Axked?=
 =?iso-8859-1?Q?g+aQ8KWybb0w7R+Uq/S4rU9+bwmKWCGfZ/wntYNZGqRZ9PpkU3urTtBNpl?=
 =?iso-8859-1?Q?FfVuv3QvQsNlzHKWcRxxwdlJ3q9ah30BAhupKeyYJMVNYkVfm21L+vjZsS?=
 =?iso-8859-1?Q?LD2LgAw8qgcd9jOkstKUbTFJvnNohLsK8RQJSk92qPEktJ8I0Pk3dI+LzL?=
 =?iso-8859-1?Q?dq+jy3zpRjLfQ13+gvBIdpzqxg80GWHUBE+sasi2d2pfJ3tUyTvysLD87p?=
 =?iso-8859-1?Q?5sTQXbWM1/HbzcJVw7mTuEIVyMIQsZH2JJ75yWxS/I0olgCPju/8iLiedK?=
 =?iso-8859-1?Q?5P+T+ssLS2Mf74uzgQMAh7/G6kvh4urIN5amgZdDVvlaMbI954v31euk3f?=
 =?iso-8859-1?Q?LXYPcpwJeQ56Jrc7XJXIGbUxwCj12vpQ38HVJtTRaEo9+bJqfN8cMSo+n9?=
 =?iso-8859-1?Q?EVN5LElCnhZrGe8271Mw5QjAsUMkowG6zDHJPxjn5LIMQiZt8j+vT56hCM?=
 =?iso-8859-1?Q?uPloJXy0422w0ItaAzDe9TsWkBPbZBMSB9iQYPDggJV6eSqVaYGltMT7Sn?=
 =?iso-8859-1?Q?P2UYw4JBP1ELerOggsMOuCrpCRPTTZOhpgXelGqCzunXJed7bnm+hnOMUE?=
 =?iso-8859-1?Q?JHoHl91JzClUUySfKSERTOdj7ZwHRd0NVdech7SLC4OIDRwrPD8oujXB90?=
 =?iso-8859-1?Q?K3KTSXZSfA245b2hjGCXLpDndB5o6+YAtrxrNk4idFuGwJAfIvV0rjpN6o?=
 =?iso-8859-1?Q?TL0IWIUcB40+1+So/zf/zlKVCZLdItEzGmpp5xmcEKw5yptAzBwY0oT3Yo?=
 =?iso-8859-1?Q?bB4MjSD2BUSSe5f8+FAptKqdWyLGhryQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?33VpxohqwM7VyH8H/JJ4TXY77RBZXuijAkvaLcIzgqiUMUABPGPb4lzPG5?=
 =?iso-8859-1?Q?US8KtSpZQWR4Xb4MrQSdK6/8gnRsYWlGulaeQQ3cRLEI23hC3JHUBCG6bB?=
 =?iso-8859-1?Q?7WG/i/Utlf/sMUx9YG8Libho5SCT/9OWbyT8YSSW7BtFmB79ASlYI8j/XI?=
 =?iso-8859-1?Q?y9NgW5T2B7JKc1neks0/EAWwMHzZK6XIO9AGnewx2N7pInaEmctCYBlvDl?=
 =?iso-8859-1?Q?w7GCQ7vVvH9RwW1avVH0LUkaiZdaUwVOksxH1BF13o/oFAgVHxIkuJCTvN?=
 =?iso-8859-1?Q?w/V2eWTJB/lGG3S67cjbmtXYO2AeSD8yDwTKZsUcvM0+zDnkWV9b+ynpEv?=
 =?iso-8859-1?Q?ruIwkIKg7u+hcy/CV4BgHxnXXvWJ/y39mFk9QZXCJpYIWGKeANDZIHM4CZ?=
 =?iso-8859-1?Q?ZJrIGlzfpUfa8Uzk6VvxYgp9+IJWDHI5XS3Opr6uCBS+7Za7QSfrtpXsNT?=
 =?iso-8859-1?Q?978r7rc60jLqI6ZER98zTRb254pbI0OPlquktxF55Zke41JkDCU7qx7P+G?=
 =?iso-8859-1?Q?IxOHik9aiNm4843qxwrnCd+ea66ISwU1I7VHQ0WsuD73u8h9DDzZwYe1Ds?=
 =?iso-8859-1?Q?ua4tSwz7eCv+IOXG2GdEHLNVojFLvEjduQahr2JZ09Zp3BiiEPfh5/5YKs?=
 =?iso-8859-1?Q?DAC4f84cCDyjiYkxmti6lT8vAafYgY+VK+0urIFwQ5lVAlkWqgFfvfQoWR?=
 =?iso-8859-1?Q?GnjbJvNgLbAxnGS01DERIrV+Wy7mX36jneMHJpr8mE+L4hocSdviMufRT7?=
 =?iso-8859-1?Q?ZJ57wE43F/v0tQbEHAljfFheb/EThcR3NGjnz75Mgd1ARlSoeFN7eq7luh?=
 =?iso-8859-1?Q?XQEKJuUBM1VxPTdnf9Hs4A97MnBByllb3e73LM3yH2cbQ+lIumzWIXBIa9?=
 =?iso-8859-1?Q?pB32Do2+z7Fk8+RtNbac4TpHID0Y7pVQy3MmK0+rdQM55aE10U7C49CfA5?=
 =?iso-8859-1?Q?fP6R2GwexmJquMpIGIc+s2AeLee882fCQaZUzcVbpUAXOUtHVdp5yEWHfE?=
 =?iso-8859-1?Q?ga55f2g/7+4O/p4YIOxdPFHwT4bBE6lHp53DFKQtLXpLmwMHagj2IKYqpF?=
 =?iso-8859-1?Q?87nGSNrpA+/Bw2MebNi+G8d7VsRByNqHaIZhtHDBsjwozDsnLnqDKcSEdo?=
 =?iso-8859-1?Q?PeTE9CQYQYxZK2TZvDiwQLK9v2g6R4UTzxmssmOwFdOewQ5YkJljwmZRoV?=
 =?iso-8859-1?Q?phZHT77wcA3saUA/z6Gqywd0GV1Fly56drECO3wq0+O2YVQk+t8x5H3PM3?=
 =?iso-8859-1?Q?tIhjtCJMrcTp7MSQ9FoBxHaJLuXMNq/P/qxc+UjbTn7vrlVv32pWks3Spt?=
 =?iso-8859-1?Q?O472EaS0Fm/xy0SbUnGXxPZz7vd8QXnx+Rz98zPR+E+gJg5vO3mYPkXYql?=
 =?iso-8859-1?Q?+CrBD4Kfvxs9AVsYCYpBhVpgEOWKtCUHl19TV8lqcWMlqnqXlpb2Lo1Nb/?=
 =?iso-8859-1?Q?3Ox7CsGmA0DkmGLznxXN4JpZPHEThM/Uvj3+ni8HXa22GbBVJlQzM7qCNW?=
 =?iso-8859-1?Q?IKjSlOzfKAfS2jzLpOrPomOyPa8VCxpvDxQUy+IpWiVZgxJMbOLC4TX2jC?=
 =?iso-8859-1?Q?EdqyLYNKscJi9+MuBvWXra+3iqDbArmNn1Eu0M2G7aZahCPuus7agSbdep?=
 =?iso-8859-1?Q?hBq+0kg0v9vZ0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <09914401FA8EE045BC0AD9EDD702C95F@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a29f465-d556-4a54-e2b5-08dce90749ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 08:41:09.3923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: frsHIZnQf7ulRzta/e2lAnTewcEvPThJ+PnLoWS6SDG4BQZ1S79bY33wseBcdZuKppvIYiRGKtT7g7H6xWM+iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196

On 2024/10/10 16:17, Jan Beulich wrote:
> On 10.10.2024 09:58, Jiqian Chen wrote:
>> --- a/drivers/xen/acpi.c
>> +++ b/drivers/xen/acpi.c
>> @@ -125,3 +125,20 @@ int xen_acpi_get_gsi_info(struct pci_dev *dev,
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(xen_acpi_get_gsi_info);
>> +
>> +get_gsi_from_sbdf_t get_gsi_from_sbdf =3D NULL;
>> +
>> +void xen_acpi_register_get_gsi_func(get_gsi_from_sbdf_t func)
>> +{
>> +	get_gsi_from_sbdf =3D func;
>> +}
>> +EXPORT_SYMBOL_GPL(xen_acpi_register_get_gsi_func);
>> +
>> +int xen_acpi_get_gsi_from_sbdf(u32 sbdf)
>> +{
>> +	if (get_gsi_from_sbdf)
>> +		return get_gsi_from_sbdf(sbdf);
>> +
>> +	return -EINVAL;
>=20
> Perhaps better -EOPNOTSUPP?
OK, will change.
>=20
>> +}
>> +EXPORT_SYMBOL_GPL(xen_acpi_get_gsi_from_sbdf);
>> \ No newline at end of file
>=20
> Can you please take care of this as well while touching the file? Or
> maybe you are doing so, but the diff doesn't show it properly?
Yes, will change.
>=20
>> @@ -484,6 +483,7 @@ static int pcistub_init_device(struct pcistub_device=
 *psdev)
>>  		if (err)
>>  			goto config_release;
>>  		psdev->gsi =3D gsi;
>> +		xen_acpi_register_get_gsi_func(pcistub_get_gsi_from_sbdf);
>>  	}
>>  #endif
>=20
> Why here rather than directly in xen_pcibk_init()? And why no change to
> xen_pcibk_cleanup() to remove the hook again on unload? Which will then
> raise the question of possible race conditions.
You are right, will change in next version.

>=20
> Jan

--=20
Best regards,
Jiqian Chen.

