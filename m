Return-Path: <linux-kernel+bounces-203918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4458FE1FB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2AD1F27B33
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234321422AA;
	Thu,  6 Jun 2024 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="pBhJ4X4m"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA60A13C909
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664324; cv=fail; b=rMz/OIV/MfbkX+Up1qmdFmxZHNcBu+AgB5vxQph9L0Kkv9l/OkfQZKoLORQQRVbvWNizj3SDdvm3CmoGkK7VIA/+Z1zGgRPpf5ypqskaNZa7hXWJ6WSZISCucyJwMNIw8uXzH1K3bqrVpk8HsKz41ffQR3YHRflTN4p4VyUgMwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664324; c=relaxed/simple;
	bh=HBEuetvlHFHIY0Yc/hU917LWTpcGmmsGoiSSmTSlBTs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ali/ObfeYzUFTrTU4pCN5BlgiYpPtJYbZGQosAZvx5MC8DESdm7uX3D0R1lBN5UP+1Eal+jUlwuT/XhZKeytkA/ejsJwYZ2ZzrcT3yOx2aU450G87qlvM2/MjJQjX84DKB2hKFva/imCFxYnqCw0XGMyDvqheUBDH+zAfibaiZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=pBhJ4X4m; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4567v5sH002137;
	Thu, 6 Jun 2024 01:58:38 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yk96386ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 01:58:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INpglqkpaUUCuWX3RJ1Wx6t80NnGnNEDs5uF6znTtXI9tmrsVb7ZdlRnDRRIkoyfEp7HwfuBWeOftmE6MoEYWIwWfeU5P8cfsOQuEkXVM362aRvQ0BZ9uI8uszO2R7pSvmyM9WQQ0TGRGWfqLAQNFHWfUDahficqUqY/Y7a+ANwiWZwPt3q3i2/nBcBscqEzWvp0QlMQvCPuYmRhmNJnBGnzNxBSVGTNeF/v/ILt5f38rJ8LlfdEzsITxdESE/h2bwjkq2Bxd83HKD7XGa3Z+6Iz1SWf0cx5zrXc9Adzr1NbHnRqfX/A8PB0RwSEVXKUvtfksGtlujcaS82ym4JJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRifVYm5yuHKe90bgoJD5kV+kcHtU8mdgSRtSJAjUoQ=;
 b=O0S7oMU1NkKxwcosqNrYdxDoeA10u2MvmfkocEdvYvHlFDsqRCuD93O+SoEe+LyaOVI+GOjhqOEYMKnn+TDywfRy8rMPLgltjlK6CgsqUgWr2iEjKzPgGAEeHjGMLKzekj4ZGkuh2zUHysWig2JgI7JnyeJAnBKvU1cXm6AyPmktVjn+MGA3bPNCM69wFOHFQIQpMwmNqM3D938MQ1nUOD24bRa2mJnyi29lOvaBoziL3W4mHrcj4+x42UkVZve7cRUDAkNZy+Z3DwUNB5JmzBAixmVumXcUtFAJSC2GDQEsoLGfuz8NbymQZlMCps4vc7nDHiwfEvqnaEe95yaVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRifVYm5yuHKe90bgoJD5kV+kcHtU8mdgSRtSJAjUoQ=;
 b=pBhJ4X4mI5LGlmx9yYg4Htj19SLSpLVEwMtC+15OM9gP5vBgTYIH86usei46lDa2lVyh7hWyoiMdZWWjztDWR1juqDXNE3TDDmADYieJoRm+h/xMHF+en+aVCp7/nSAaolC79bHhIpprdjYhQEjMR7Z8y4nNgqh3dJiQ1vKAO8E=
Received: from SJ0PR18MB5246.namprd18.prod.outlook.com (2603:10b6:a03:443::6)
 by SA3PR18MB5371.namprd18.prod.outlook.com (2603:10b6:806:302::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 08:58:36 +0000
Received: from SJ0PR18MB5246.namprd18.prod.outlook.com
 ([fe80::5a7c:1cb2:fcc8:8966]) by SJ0PR18MB5246.namprd18.prod.outlook.com
 ([fe80::5a7c:1cb2:fcc8:8966%5]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 08:58:36 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Jerin Jacob <jerinj@marvell.com>, Srujana Challa <schalla@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v7 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Topic: [EXTERNAL] Re: [PATCH v7 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Index: AQHaqqXUeJduCBvv+0e3+QVunpJsgbG32TAAgAAF9zCAAUqAgIABXmcQ
Date: Thu, 6 Jun 2024 08:58:36 +0000
Message-ID: 
 <SJ0PR18MB5246ECDF962BD0AFE138E38AA6FA2@SJ0PR18MB5246.namprd18.prod.outlook.com>
References: <2024042950-refurbish-duckbill-77b4@gregkh>
 <20240520110630.2568767-1-vattunuru@marvell.com>
 <2024060412-amulet-unflawed-f37a@gregkh>
 <SJ0PR18MB52462AA2A9F15103D5198CC5A6F82@SJ0PR18MB5246.namprd18.prod.outlook.com>
 <93cf15d9-6709-4f64-880b-efb178b7bf01@app.fastmail.com>
In-Reply-To: <93cf15d9-6709-4f64-880b-efb178b7bf01@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5246:EE_|SA3PR18MB5371:EE_
x-ms-office365-filtering-correlation-id: 4f58abd2-53d2-4dd2-07dc-08dc8606d9cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?YLVZXr4fdEOw+Pq4Ovm9lWMmtYkiWlgxJ+C4/USkBi7O6HiQI4HzZDjM9Krr?=
 =?us-ascii?Q?7VbpH7xCqd48q7Fo1eV685b64yqjxXJHbei1USlCwPi4L7Pso5rxyLrU8UCE?=
 =?us-ascii?Q?SC3mgbAe8WCfgUUQqkIf1aqhr+cGesQxzk1+xooWTvpwxbouTwlOPRcLDE9O?=
 =?us-ascii?Q?Ru+IY9sLZPvMIh5dE3PvlByp5vj6V9JPDgEYQc5P2GkYslrfKgDYp/6on3KR?=
 =?us-ascii?Q?c4mhyUopDuVFfUIMh3gMk7RBq3hee9VLcVoq6JfERm76bgTfkV30BM2PL5an?=
 =?us-ascii?Q?lheaJcz3S9LPJnTfEUFRf3pSfQLdjO6yd3iY7jKWGtDYexJ1Vankt5dkQgmg?=
 =?us-ascii?Q?lFyej7G4VPFiN310WkqQD5yMGDAbfsVQ0SKmbQZN5YrA9om/3U0giSf1X9zM?=
 =?us-ascii?Q?kxIjndTHJWnwCn20Otg7IoEVLU/+7xR9OV9KkHj414UPz9ckWswoWnkmMRGw?=
 =?us-ascii?Q?cvU9d0D1RyL+LSo/EbWVPNvF/y36JHqX7A7RHY+xzXEY0nn189+W+S1tELvk?=
 =?us-ascii?Q?D/m8ZWMQRGvB4ANIb3ZKK4S0JheOSbHYHUGvcilsvk3cirMBNGEeCUMSy7bo?=
 =?us-ascii?Q?qPb6sz/V9d/jtKvp87QAowJrA8rCU0kQIM3bEQL/W30qRTqz0iAxV7Vhj+Ak?=
 =?us-ascii?Q?vv3AJL+g03ZDdrFiipe+zIqhneftewVi3devzZW+wwYLOUfxBtsTiNux5AaM?=
 =?us-ascii?Q?zp+9t6DywGe3SwTgz77iZWk18jFRWo+sO1q2Ff45TerI+pltcb++HYSZrUub?=
 =?us-ascii?Q?exwMDRXSty0p+L77/MNcs2SM2lQpu6wLoQCvd8lxECW5eY7dxwcyAc9TchNd?=
 =?us-ascii?Q?XHHyNu0icmeFNb0gHRR/V6O2rGDSqgj7lHzpc6ynv1qD5fY5CpXST+K2ZG5k?=
 =?us-ascii?Q?I9oHYW7fWwSIBMjKDphMnNtWLDPdVVBUMKtBeihAeTPiSOCLIXvwg5CO8qlb?=
 =?us-ascii?Q?PmUzAXwhbZJ3ZzCBGaFEjR9JKjspeaNn4yBfMAWNr1n0qDO1EAxazQIA/W6H?=
 =?us-ascii?Q?v0OmsnfDsOZsXSmlj4Wkk7x+idLZkxtSAS1ho3uTIlv9qlwsMSmBkAG1ePLP?=
 =?us-ascii?Q?eirLHjmnBqf9cV7uEZ7lK1N2+Amk0hJG+dgDEJR5Y5sWhkaGQPBd27ozoj4H?=
 =?us-ascii?Q?3Sfg/dW+T2muLRGB/hIEpQVvCmGwBucTf5oKjW3rG5HPLfePA/35IKNEqeBB?=
 =?us-ascii?Q?iEDkztvGIO6V8ZUI+cfJu+lAogsJM6kwit42AMhlAuj4lSwlIoqhLRRMy8D4?=
 =?us-ascii?Q?zH5X1M5gYUIsahURwbI/RUcNG0dkWLuh7CLh9Y7iOV2DzYuhNnqeCTb4jc33?=
 =?us-ascii?Q?lSiNSHZ5f+BX3Pk0XnZzbF46PfyPqSXUZ7QOABPrbuonlwYncamitJY8+5c4?=
 =?us-ascii?Q?YK7Wsuc=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5246.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?PUKRTaylaTC8SL9LfBE9S0HsSBrAVCGy8BRcpul9/fBkjPRt3xk9Fg+8q34B?=
 =?us-ascii?Q?czyi075bKmXuHg4ywjfdCzK1WUKfRiXypepfLkG8cZOP6Fcxz10Re9SemcYM?=
 =?us-ascii?Q?AyF1PzCaH3BztfN01YEUgAotWrkbz6LEFOBeMOc1oLfJwG/6gMcY91iMFfY8?=
 =?us-ascii?Q?P4TEwahDgPmG12nOUhCl6pNc53zHuXJ91Hjt1KkIwMq3LUADKlTh3B4YXyHL?=
 =?us-ascii?Q?Xh9sqt9rKlbmB0AlQwwapaVP51SSIjj7HsVPa9rEnnJ1JCI4rz8iHj/m/VHm?=
 =?us-ascii?Q?JdjAyborHPNY+Rq8Zap55M4hXUHIHlBvNtqc76PhH1O+peutrquhajedOE+v?=
 =?us-ascii?Q?HKMffJ+9h47vO0y1cFxc7YYNOdQz7kSSdoD3yWTAxyUlsiqaSXlGuTEqm2ib?=
 =?us-ascii?Q?6aZ1WHBVv8vBSY3yR+MBFeHeEApxFL65MmK9cWMoMWMlCfoLY+899GZOqEFl?=
 =?us-ascii?Q?8jEtBv7azJVSmp/CVEd/imGzJksZKMpf1CS3N4qCB86/u9dBOKKg/2Bto4a2?=
 =?us-ascii?Q?ILnsAK9MuFKZ3FkYme9DQMC4iHt3xBTVoAatu6lqA7/Ge+cMUnRcwHHDaRJ3?=
 =?us-ascii?Q?dzOitZxEczN1DtyHW7TmGAJ7M1j4mnYLyjBnJ3NGGH8vWA19JzDQQGYTZD37?=
 =?us-ascii?Q?DvqdT+kdmXZYWN2IfPFX6xutC7//Hogmn+k7499oD8MIMRl20DQpdeMIJ4p2?=
 =?us-ascii?Q?6MgxPzpYMIzO/xl+EdFOfwfiis4sQrvYiRow4Dfh169I8Da7HHWHZlC8swtZ?=
 =?us-ascii?Q?GEyZvcJpTK0YO0ea6fKjIQuExZiqqfzcEn2H7JGNPC46LaTq4RnzbzJgm9iF?=
 =?us-ascii?Q?slKoOINTiZW7Z5R5Y9o7GtIDdvOVkdkG3dkHh74ABsFfdhW1/s4dRBdKIoT3?=
 =?us-ascii?Q?REihXfwy5nXW07PRbmpxjjQBk/miaB9n3cYxotLFVxkXNkrS9Et28xKRps/w?=
 =?us-ascii?Q?j7zudw8ByKgs68VSIjQ2WJG/Y1yvIs1JqSp6qRAM36KFB9Mz8EpnIrbBjxmr?=
 =?us-ascii?Q?XZXY/nhxas5b/QKAiaC4IIo4eLQFM8hYWvuQythxdtWqj09BLZyPf1vLW6Q1?=
 =?us-ascii?Q?KE1+mKPoWOamQ9PBYYXN7OdnUWMs/emDLzjwISrzzgrJxHAx8ukcfWLAFjsh?=
 =?us-ascii?Q?Gq9byqGGqUXkhWq/W9hgWEPS5Vq9KjiieNpsrOyyp0l0uQhbftbS2uGhuOE8?=
 =?us-ascii?Q?P/kBfNTzI48YNirNXqifcB7/tB9JpRqceyav5p2APTK+yTDArmFxfv3DRbNg?=
 =?us-ascii?Q?WZjQf6QvLtyXqH59r3jJvamVGA4MqVMlBPv0DLyIYO8EEgUlP8ZNqQIKfw3m?=
 =?us-ascii?Q?/mN1tna2oW3e/ncUmiUaW4/VfycxKh9iP8S+m5EWrAa+LwHUgOMXYd8zjwPA?=
 =?us-ascii?Q?hVh9EjkESmdFxtTXRiCm80XoW7K3X4fPEyPz1j167ge71ndLdJ8q3XZoV9eW?=
 =?us-ascii?Q?jbTLdGWtdyf3uUzOaXmqPxl4LfeiKd22n+2gmLmtG7KOR2316S+vP+z9S9vv?=
 =?us-ascii?Q?P7UPHNjZdE9U3MJTguFu2Pd8rfq+HXRIwA63pn654HO1VJmqEO4hPzbZshGA?=
 =?us-ascii?Q?689POL1UZ4AR6SIl2ruMilXE/hVY4T2XLalEt1Za?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5246.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f58abd2-53d2-4dd2-07dc-08dc8606d9cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 08:58:36.1284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRHKFQD1YeDH2w2Ild1O81nlxTfmNu3zKJP7rkPMR8guhDB3O/3OQjiHFl7wPGPxslfQLG03uO0wnMm/5uHqiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5371
X-Proofpoint-ORIG-GUID: HbI-eY69Lk7n31V25tBo3_giY-64R5Fc
X-Proofpoint-GUID: HbI-eY69Lk7n31V25tBo3_giY-64R5Fc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01



> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Wednesday, June 5, 2024 5:27 PM
> To: Vamsi Krishna Attunuru <vattunuru@marvell.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>
> Cc: Jerin Jacob <jerinj@marvell.com>; Srujana Challa <schalla@marvell.com=
>;
> linux-kernel@vger.kernel.org
> Subject: Re: [EXTERNAL] Re: [PATCH v7 1/1] misc: mrvl-cn10k-dpi: add
> Octeon CN10K DPI administrative driver
>=20
> On Tue, Jun 4, 2024, at 18:21, Vamsi Krishna Attunuru wrote:
> >> From: Greg KH <gregkh@linuxfoundation.org>
>=20
> >> > +static inline void dpi_reg_write(struct dpipf *dpi, u64 offset,
> >> > +u64
> >> > +val) {
> >> > +	writeq(val, dpi->reg_base + offset);
> >>
> >> No read needed after a write to ensure the write made it to the
> >> hardware properly?
> >
> > Yes, as it's an onboard PCIe device, writes will happen properly. I
> > will modify it as write followed by a write barrier to avoid any
> > reordering.
>=20
> I don't think a write barrier after the I/O is what you want here, they d=
on't
> just make I/O finish before the next instruction or unlock.
>=20
> When you have like
>=20
> 	mutex_lock(&mbox->lock);
> 	msg.word[0] =3D readq(mbox->vf_pf_data_reg); ...
> 	writeq(DPI_MBOX_TYPE_RSP_ACK, mbox->pf_vf_data_reg);
> 	mutex_unlock(&mbox->lock);
>=20
> there is no guarantee that the writeq() completes before the
> mutex_unlock(), regardless of what barriers you put after it:
> even if the device is synchronous, the CPU itself does not wait for the s=
tore
> on device memory to complete.
>=20
> If you actually need the writeq() to be serialized with the lock, a dummy
> readq() is usually the safe option, though for arm64 specific code, you c=
an
> use ioremap_np() in place of ioremap() to turn the readq() into a non-pos=
ted
> store.

Writeq() & readq() are already having the barriers internally (arch/arm64/i=
nclude/asm/io.h). Below commit describes the requirement.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D22ec71615d824f4f11d38d0e55a88d8956b7e45f

If the driver needs to make sure writes are done then driver can read back =
at appropriate places.

>=20
>      Arnd

