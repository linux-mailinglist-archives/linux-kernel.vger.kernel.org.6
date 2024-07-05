Return-Path: <linux-kernel+bounces-242136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0A7928422
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE111C22937
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48D2145FF4;
	Fri,  5 Jul 2024 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hISs1PKi"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2124.outbound.protection.outlook.com [40.107.117.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661BF60DFA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169489; cv=fail; b=UqonC8h/9czVePB1W/O1tZ4BZVMXMEEe6P04Hv3aaPNT/fCGI4T+OXwZmjzHodmh49APMouBpJLXgSE2MMREgYIoxo8TrNx/8z/iai8cS+M/LAsfk8BlxXdKaHzMd9SGSArs1lHkfpbexdDK0THMNetqsIx7MgKXTyOP5Vm7498=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169489; c=relaxed/simple;
	bh=2Dh55+juroCC+uzXpCQeAG6TX1BulzBfY8Vk01x3i98=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rT35BZwWPC9DfGPmRPxHyw8D60U8uvrIvODhmVOfWl47OHaS2ggE5mDf3QkuCRikjyn40osbOrXk01uNABLVVn+88rxN9hSTlTvJSXx5Yhm9wX30RUPisDuNC0/Hr+GRUXvCliUdTrmUn0u1OaSpoxbL+LvPV9iIxJpWv+4ysPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=hISs1PKi; arc=fail smtp.client-ip=40.107.117.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMTe+sQ1P49zmP2DKTkUA5yhSPqyifkDuaYvtp0dnFK1MOnW2x/wrGBm3NH8mDUX8YxjssPhUEBhWNhbc0884xMXwKG7QgmL6MbGccuwnRvAOcKnv7Fizcq01qe2sJjgW4Cc6q36oYiiI0aL0/modrIajKm2CBc6i/4nEcHcvV+oFveBwnUwQBTHN5+FZsD1PA79+c3aCSea7cjKintY3bThzZMxSYHaWYN0RIazW3JOgTPzbI7sLrvVzieaFbuaKDPH0JeLSX/lbUjKu0ReKwzzlKHkc0u0dG6nrQCjpVQ1ULcY1xIqf5q+LeK/AqNtcEI/VXi5H/3bKkVxnJWCjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Dh55+juroCC+uzXpCQeAG6TX1BulzBfY8Vk01x3i98=;
 b=xYppGRJHTbEyCjSBoNmp5pA3gqTFD/bpEiTo+r0RDKx4cMy4UkQHUjBC79gBaG953y23uKwScp4xqID5qydTux5T4mEg6piOYjQHwkR5xwa0y9lTfZrZ57VWWg2PlhxnAAjURyaCIYM4nfrKgXtMeVDQiRgbR7C3gw3r/Dbz4wS+sM5UC8qJ3KPYDwoOjhiv/CFTk2J282WiaKl3PUB1cpFAO+GXU+3NBwmvneEtEmvuCG1jgCpB0nHtIxrqLPVNU65+yozsmn6qB+trN1+MCdMxfeb1E8mXK5dx9Sk+LP7oLmDyAoT4wr4nBg7viiN7OyMnJz5BtvW2RzFdA0PfeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Dh55+juroCC+uzXpCQeAG6TX1BulzBfY8Vk01x3i98=;
 b=hISs1PKiPgSQGmnWDFqBS95JPBjOjnZNLijgohfcTu7efCRILZGxRVLj4QpjYZwibaDgFcmmJwDUlBwTsMLr8U+xF4GbQQps2WdWLLfgx7UXR1vHCZIBXz6Cg8dB2opi4MQsCij9QS3jSjeBy07poKnpI2DagpM89nspOhTsh9Q=
Received: from TYZP153MB0796.APCP153.PROD.OUTLOOK.COM (2603:1096:400:28d::11)
 by JH0P153MB1064.APCP153.PROD.OUTLOOK.COM (2603:1096:990:b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.6; Fri, 5 Jul
 2024 08:51:23 +0000
Received: from TYZP153MB0796.APCP153.PROD.OUTLOOK.COM
 ([fe80::143f:5418:d4c5:3326]) by TYZP153MB0796.APCP153.PROD.OUTLOOK.COM
 ([fe80::143f:5418:d4c5:3326%6]) with mapi id 15.20.7762.007; Fri, 5 Jul 2024
 08:51:23 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: RE: [PATCH v2] tools: hv: suppress the invalid warning for packed
 member alignment
Thread-Topic: [PATCH v2] tools: hv: suppress the invalid warning for packed
 member alignment
Thread-Index: AQHazrf0N4Bx8pBL0UK/w7632TBHIrHn01Xg
Date: Fri, 5 Jul 2024 08:51:23 +0000
Message-ID:
 <TYZP153MB0796618AF46037251E9D6A9FBEDF2@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
References: <1720169227-20465-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1720169227-20465-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6e0d7bae-4727-4bea-bae8-700652b1127f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-05T08:50:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZP153MB0796:EE_|JH0P153MB1064:EE_
x-ms-office365-filtering-correlation-id: 1d057c1c-d420-478a-35e5-08dc9ccfa5c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OJX4HuyKzS9kZ84Ky7yJ0+4Getj8UfIaNB1+u7Z6rmu/K88FLlyu1pUNXJGg?=
 =?us-ascii?Q?A11nl8a9rV9Yk5FwVuaYLuZqIFK2+VPH1DwyzAKausLcK8iI7eQh/ddSj+Ia?=
 =?us-ascii?Q?Td0LC1bvHR2wXMvBx1wxqU0wcGEOq7FpePc30NTFT/7lYr2ps8CH+Ud95lHd?=
 =?us-ascii?Q?ezFgb6UZ3ZPlUfJPQsUCDyEcGXDWj89LX72DGyGjgBcPy8xR6x9TBsG8htpv?=
 =?us-ascii?Q?akZCAbYGqNhjivEN5weoYcL3Mao9JE29ir1PW/cw9COtYzIEN2799KaZYJZH?=
 =?us-ascii?Q?o+WF9+Y40ukvDLBKiYYp8G0PqsOPAFuULptN9Sj/d05rOH79w0m14M28aDez?=
 =?us-ascii?Q?eFcuEF26b2GntXKEuYkESTCXIOLFUt22FTLZvIkNNn+8v2i70wWsucxV6tZk?=
 =?us-ascii?Q?CqylhHJqgM+DFfCj9nN6qqViM484bJy4qaEkGH83DqSUDwYCHTlX6DXegViy?=
 =?us-ascii?Q?ZMzYj/L3IG71I2T1cTCFhh8udJaLcgT45CV70SWZ5Lj+/Wst0Y1W53OJSZsI?=
 =?us-ascii?Q?xjnjFvs1GXOav+olp4LtTyFHvPrnao0eolq/64mosMUJ4QiozaNPB4V1eXfy?=
 =?us-ascii?Q?MysQ0vmXaIM7Y5ua5QSKMTiMoKAlBwxu+gyM28AffZQVSlvVZKAXHnPb7a8Y?=
 =?us-ascii?Q?D5QK41iqyhbY1wM6exBTU+9rRXAcBWT7SsRuIoO0payuE6TjYFclSYihWg9z?=
 =?us-ascii?Q?RJztROSfXteHwkj/GEdKdP5Gmf8t5OAtLJXq4Xn90h05K3T/7Swoqt2OTUA3?=
 =?us-ascii?Q?Sqi5q8hBjLewkTfH4liCBbAuCKLTIQ+PxnNXZMDbBbwvXIz7pXslow9PIlzq?=
 =?us-ascii?Q?P6nlMAOwM05d0ilBB1VF38i/gs+5sxM+ngkigL8+2SxJGM4+2WCNlf1ykPDS?=
 =?us-ascii?Q?rG6vb8kbm4QiFyf+auDMYx7b6Ug7s+fMSg1UDgPLqxbOeYUVZcMJx5DWm9Rr?=
 =?us-ascii?Q?P26Pe8iX+tcjWJyUOSvcwhZlQNtG+QQQ8ZIZHgMtU5nQueJR2PAOagQSe4lr?=
 =?us-ascii?Q?p4Ei0LwT2rsrbLmuBeW403GzXkozFuM/BUySr55zdHqI8MhBs0jekaM2lOHl?=
 =?us-ascii?Q?whUeQ5NQ+5INc16qJkSnqEqDfOFd6sgfRP7d233k9upmWSDXXmB6wmp0sC36?=
 =?us-ascii?Q?bcegplVMewe3/8SpfBMIrF3W0nbw79B1APTrgwzxG1wJVbiySh9ABmWsFRS9?=
 =?us-ascii?Q?yxgNac9Kde1b/4Ok/XDO2K/oyeU1IJstKBjJH2xfUpRCo3oMiajvNfHSl2e+?=
 =?us-ascii?Q?B8B8pk/CjME1aXJXQ3JlGCix9rzz8+NNYoBd3UJ6DU28Gg5cTqWwoboU7c4h?=
 =?us-ascii?Q?20EWblXpBZMGg/CvFZt8TI8QzPwhtXzvJa5uXc972ezqqCIixdqknkMfi0xs?=
 =?us-ascii?Q?AUD/k54OV7vMuBF8bPTaD0J46DomOc6cIyDFXE0nfIxNbmMceQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZP153MB0796.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eeRhmfGm95gwf1rWF0bw9WqE7Frfvp5DXbLi/WPsxOmiqkpWEDyXQALKH2M+?=
 =?us-ascii?Q?ShnjyhrGadSo3Bx9BQsUGWcvB9aRaHwgmcVWQ7dZjks0HY51bV76EBqfjXUw?=
 =?us-ascii?Q?KI/wWDoI2x1VK9a7RfcbF5A30t53YW2k2luA1LzVo85Id4o8pUUdrz46L43Q?=
 =?us-ascii?Q?asWSCgHBlDHEGtc22rBXRWk19gzSCmxLvO3egw97vVjWkuoN1OZJBupY2jr4?=
 =?us-ascii?Q?fcg+9yKk0/zgyOpjNk9w/JJNKyt6CnEXYvqXgEGtyHdywurlNOfLZ1+DM6n/?=
 =?us-ascii?Q?5Qi/zlEvvEnWnbXFWVzG295K6aS1IopCIzl52sLp2hvfCl5qNh04P1l8UjFb?=
 =?us-ascii?Q?oKQFBpntTevXei8womgJcCxgwcHB+gcPGDOAqP0t/6u8qj2mIkfQuSfMWI+7?=
 =?us-ascii?Q?5KyJ36q88CvrznytvcQu2gpXdLlOtOJhTo5sOsU/sXD7Mmn1+0fJQoCHKi7M?=
 =?us-ascii?Q?daSd6HjM8UI0Ih9K6Ko7kFQCrpMDr/Kkeut2wiTfckT82euBv9ZTX0fLO5D9?=
 =?us-ascii?Q?DjTnWyxARMZgisB3SK5isc00mzETFHSBl2UUE7e2AdYQZQHnYip5Yg71imBu?=
 =?us-ascii?Q?SLUNH8mYsFpPVpJZB4Cwr4SIygD14CHvpZpstzVy065mxf8yiqieAUe8Xb1K?=
 =?us-ascii?Q?P74s2cnSaXqVZzW555SxybWuzh3sesVKAbmCFOytcyYXCBUq4FnI69T855rS?=
 =?us-ascii?Q?++WhddX74Nbn/eAJh+Nt5IkI5EZswm5XTLCaMYS6+Vk2mxMsRmbkivu40H7e?=
 =?us-ascii?Q?MHxccvkPu1p4im3aoPYbk2vfIpfcyh9o/nA4ywPfZk4ox/To6xR/+yr536a3?=
 =?us-ascii?Q?opsu6MDFqRKcX6ySWUPZfubFOwXyc945uDD/a42U7R4g0vFnCWMPj/GJKNaN?=
 =?us-ascii?Q?sca/pP+E35RJ/Ym/0JHsEluaYsmfReUa08bu4DkK3rMWd1fCIXLWQ7s7vtNn?=
 =?us-ascii?Q?qbBYysMpSTRk2IQbWrJuVSQHrcHI1fiPZAwsE7LDCSobb7KbVO/wYZVWpcCd?=
 =?us-ascii?Q?9GraF0K2jsgOhFi7L5mu91YAk4iCDFsekeBKjwwPND6U49v4mqLYb+n/lGL2?=
 =?us-ascii?Q?Fs9QI4tg4N6uZTO90uOrmQumOdmAKvR06D3b0tgVi8DKMIW40zlQrxogHnSA?=
 =?us-ascii?Q?/4zUz7tOL4CaQLM5m0rQoa+EOF3d0WwBV1jSPPts3VIWxZbzFo1pMYVlUemg?=
 =?us-ascii?Q?42e7vaC71GHYY3fiqjLJtAbeRedWytmem1Ld1ei89GAdWleKtm22bi/A2flN?=
 =?us-ascii?Q?a9muwOhP1pUKGcGRr3BzqGQC3lMGDV7AZqmigaHYoi9W32o2a2/iLoNfVatm?=
 =?us-ascii?Q?cbVg/D4eXLCeRE12HPUVLbHY6ar/Esf3hwj9nSWiSmTt1T2v62flzZ/EUW+D?=
 =?us-ascii?Q?cFTAfdqW6owVV1bl9osh9cAnNL9Azz/UL5omxgVpFU6xMvF1FEZUZrWvQBWb?=
 =?us-ascii?Q?9g0Wsbkii9CH1jBfVxdDGS6vWeqVeQH8mubSg5ggGv2fWIh12pFJfhdqT1ra?=
 =?us-ascii?Q?OXUpYfls1D2ZsBQu5klwIH61FqmeCRf7Rp+pN/nmQRYWH8E5GYwxNu2/q8p0?=
 =?us-ascii?Q?6MI0+f8T2Oa4ZSRHzG1I/v/wPtgrYDXpYDXKfafR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZP153MB0796.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d057c1c-d420-478a-35e5-08dc9ccfa5c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 08:51:23.2671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lr3rfKKLiXUHochKsh619fKMDvscZxTUa+WNjQY9t2DwPccfFAORy09Ktt6mI/O/Lh4J+NWbF0INZhi9fApERg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0P153MB1064


> -----Original Message-----
> From: Saurabh Sengar <ssengar@linux.microsoft.com>
> Sent: Friday, July 5, 2024 2:17 PM
> To: akpm@linux-foundation.org; linux-mm@kvack.org; linux-
> kernel@vger.kernel.org
> Cc: Saurabh Singh Sengar <ssengar@microsoft.com>; wei.liu@kernel.org
> Subject: [PATCH v2] tools: hv: suppress the invalid warning for packed
> member alignment
>=20


Please disregard this email, sent by mistake.

