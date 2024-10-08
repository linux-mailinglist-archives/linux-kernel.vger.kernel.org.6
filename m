Return-Path: <linux-kernel+bounces-354564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D66993F4B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FC4FB22A6A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72CE17C21E;
	Tue,  8 Oct 2024 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZvEF5rQg"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011065.outbound.protection.outlook.com [52.101.65.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5933313C3F6
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728369429; cv=fail; b=bcEkIFQovaqj4Pl1Xhkkrtgiw5/TCDLp2japtYgzMK+yW0n/0L16xGjV3eTfDSDoAyaAdei+OS/PMCdCyY3AYgUu/Ag/eTQJJw/h2boQUADdFQ5KUGBFokH290qaG79AKP1yBt1EwmW6ibPdlLLJMeTH8qoZma9Hr7GCIarg3CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728369429; c=relaxed/simple;
	bh=yVmbpsa9PYk4S77hmdvoa7Gf8IOPOR6Tf4nPdHoiulk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P7shg8HHEtJrQbj2a820FapnIToKhXZKxnRphhLroZoJHe/OSRHBIS/BGB4NfH++U7m4QAy3/lf6BEY2Cat+dsBvmFNu4JYAWF0KZOlIRrCgplCzCEVLtiCJrjMDaVEH5WzPsqH1J+bxkXPvnufqVQsE2RXpinYb3nPZKbnQocI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZvEF5rQg; arc=fail smtp.client-ip=52.101.65.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDwApw4/s4SMuSrLnsy8MDt2o41F8DflyhNHb+7F9TV54k4t3JwHjMgmXZBnTbsybsH52q42eHmqv2qvSHkqy523ByPFG0/BBglcuzyTtJDbbo9gk43SknpBC4LE4rhSUzFmQWaXhZoZw6TKUcvZutfBQvXwLI4qHvOv2LwCC8K/NELff57KTrbN0qTpdYv9ZBaiV+lumXJPesw4uyxc4C2BRGlmwzwdlGeQTt0/LXbkkiEiwRVxtJTCKyViPSEsHbTGk264Xt6cqQoghrfgH/zVKdbRV0Xu4brWncVXPWBluaFoxgIm2keLZFLIpEy8OmLQEWYFx7bsxHB4StqtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVmbpsa9PYk4S77hmdvoa7Gf8IOPOR6Tf4nPdHoiulk=;
 b=sosKU6JiA/7Dfed2QeGaiZwjgoh0JGOn40h3w65mG0qd5EQz6yUE3nFi03O0Au6vRu+Iyp9UGJ9RivxfvcAT2c81d9o1zI9UA3fNV2nYgnarIZnZzBIzUEDvNz4f5LqH2IIK8Kt4FnpH/zw/ZXiz/uor4ztdAD/2KW1AnJdEdfR77WxB5GCbnuwJ8+gGnec6tn8VmaPCufjkV5onCwyArAXD/RTwkTzvvSDMxDaQgqHPIXNzvgUACIPm71nywQ1cnBkuS/oSF7XHhUsmKR19S5OjurhGfL5wyVMa1SHGUtEgg42qjpO2h5XOAdmuXpqgBhXUK8Jt/EYYTUuqVNq8QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVmbpsa9PYk4S77hmdvoa7Gf8IOPOR6Tf4nPdHoiulk=;
 b=ZvEF5rQg+0jTLYTRVLddH8TxY6xl7d1NKCtl58qn4tjx+IltYgdJ/3b9+UqRD7ga5z12Kc+nG8cksDGx9tvFJ9b7Y1JPrY7AZPamkJ9t6G8F0u+CWylqkpkkkDiM6qmNVx6HNUGk6jlKaghnG9qHRz29PKtrgTDejsupmfRFhAw4Hrk5pVhUcA/IwPLG7IZXa/NxNNiUMGHX/2wt0C2J5p+Xv6cvFne5gy1eXeMK2FVhLyKEmLW8p2mIuYtfM7/1pb9ZrmywB7Us6qlb9N7H/F4mq5jUyE3Fb1jD/PSPJZeWLwYtmrCI3V3y2k9hgmiDvZgpGF5o7XANznDpM29w6w==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB7991.eurprd04.prod.outlook.com (2603:10a6:20b:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 06:37:04 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 06:37:04 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Guenter Roeck
	<linux@roeck-us.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	=?utf-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>, Paolo Abeni
	<pabeni@redhat.com>
Subject: RE: Linux 6.12-rc2
Thread-Topic: Linux 6.12-rc2
Thread-Index: AQHbGNpg71R1mGIou0+GQQvwiOKP47J7ij6AgADbkjA=
Date: Tue, 8 Oct 2024 06:37:04 +0000
Message-ID:
 <PAXPR04MB8510F4E5D06C7060665C58FB887E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References:
 <CAHk-=wgMS-TBfirwuxf+oFA3cTMWVLik=w+mA5KdT9dAvcvhTA@mail.gmail.com>
 <3016e3d6-f916-4a6e-82a5-2bfcd1f2dc2d@roeck-us.net>
 <CAHk-=wj4zK9YY1rsghi5CJHYfLypj5OBHUgtMuytXZw=Vbea_w@mail.gmail.com>
In-Reply-To:
 <CAHk-=wj4zK9YY1rsghi5CJHYfLypj5OBHUgtMuytXZw=Vbea_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB7991:EE_
x-ms-office365-filtering-correlation-id: c72569a6-1a3a-4f73-a4b1-08dce7639f66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a0NXRW5oYVZZeG9hY3FjYWJUZWw1cThBY2loZDNnQTdqMXRWSW5uZmVaSXRV?=
 =?utf-8?B?ckYxcVBlbk1FLzFYaGFtV2txNVVDVlE5Sks3ZG00eWxKcEhjcnh6cnlaVXd5?=
 =?utf-8?B?Mk1mV2xTWGlwdHNwQ2FVNnJjUDB0R0gvdFczOFh1VWU0Znp3YjlhYjhHZ240?=
 =?utf-8?B?REpQbW5NRkd3QkRvVkoyZ3U5dEJDV0pMcW9Wb25nblhuTlJGUFNHOUpOU2Vx?=
 =?utf-8?B?T2NmZGRNYzFqUEVVZnZOVm5uTlYybGQzcXNMWk9vYUhUMmZ0NTVkRG5rTGl5?=
 =?utf-8?B?SEswNkFPdldnTUlPS292b2FzWXlYdWNCbVNUS0tKek12aGxKY2lxWGI4RU16?=
 =?utf-8?B?NjlJY1EyY1psYnBPcFVsQytvVy9XNlRVNTZrRjdlYklYdnUxNmVodEhpenBV?=
 =?utf-8?B?cisrRUxBaXovZDRoWmFSUExxOHhJc0dLSFFWSklmRzU0OEVBSW85eWU1ckV2?=
 =?utf-8?B?SUk5Ui9LSUR2SWVGbGpUOEF6c2dhMWFrVngzdDJHb1pXdExmeml2MEQ5dDRk?=
 =?utf-8?B?UVJ0dld2czhFNHVtc3o5UnhKclR3MFRRQUQrQnFMUXhuUU12bzcvMCtMUFpK?=
 =?utf-8?B?Vm5RTnF1UlZDT1p3eVoxaHhPbzFXdDdIRTFFeGRUb05TZ3VrTjdZNDZBMWVD?=
 =?utf-8?B?SDEzbmd3aHpGNDlRcWVGUUZoU01tVTljYTJ6eWFHdGhKd3FSNmJVUWpqdGlV?=
 =?utf-8?B?UWRHZThFL0JWVFB0ZlBzbzg4UnJ5L2tzZ0t2aVh6U2tOR29XNnlNWlpTNXBZ?=
 =?utf-8?B?b3BMaVJCcWdTY2k1K3FlOVRISzUwc25VOVFDd2x0ZU15TGt5ODlaMWxYYzBs?=
 =?utf-8?B?Z25RZzJMOUp0Y29SRkMvTmlPNnY4VWtSbDhhc0tTdXJrQ29XaytYVUJpVll4?=
 =?utf-8?B?c1RXeG9CRE5ZZndLdnpreitRTkw4NXhEWHNyV2xIbndVZ2p2ZzErdExWdzJQ?=
 =?utf-8?B?OTZ3M1FSbTlwQnp1SXFRU3gwOEx0UXNRZWo2cUVVejNmTlRSdzJXT3o4U2lM?=
 =?utf-8?B?ajVpL1VPS2lmMWZZNC8wWE5UcXdRNkw4emEyRXJFOVZTa0U2SHVPL1F6RENY?=
 =?utf-8?B?T0hNTmx3M1l2T2xTekN0NWN2UDVKcGVSOEtkdy9pY2ZKcnYrREYrL1BwbnNv?=
 =?utf-8?B?LzRSMkxtYTdxeFhYSnBQcjNYcjJFQjVFNGlWdk55RW9rMTlPMEd0UEJvOE9D?=
 =?utf-8?B?MmphY09qakxkZ2VVRHJKNVJ5OFNoL1pQQU8yeW9oN2VKTmhEVlE3SVhOVnVF?=
 =?utf-8?B?c00rR3BqMTZVUDJGbk1ycHdOeVhXUzZtV1V1aU5xbkszS3MxcWN0Y3NPREdH?=
 =?utf-8?B?VW03cHJ6bTZpS29nMkIvNXkrQ3VDRk9Oa0JBYXpIQlRPM1htUWdpUVRDNjRx?=
 =?utf-8?B?MjZISnNjT0Z4dmgySTRQRll3NW04d3N1VjBhV1JWdGZlRlNPd0R3SkdTNEdX?=
 =?utf-8?B?L3BVU0F6OGh5VVVXVkhGa0haYjhGTStxNFJ4cXczNlFVU1FUZU9IQ3BrK0hz?=
 =?utf-8?B?Ulp2UUJlNk1WQzFkZjVES1JJelJjTldFMzIrbUI3dlpzRkU4REd3ay9hbWJ4?=
 =?utf-8?B?UHRZMWo1cm4vZ2tHVG9UYXZGd1ByOXZRZThSMmd4N01Fd1JtRDB5eXRBZWN4?=
 =?utf-8?B?UnMzY0pBTkxCbFRXUnU0QnplR0dwSk1xMHA1UldGRDAyZE5RUGJMemNtNU5m?=
 =?utf-8?B?Z2kxTkg0VFR5djZFRjFZY3hubVlaNnR2NHlBcG51aXVpN2dlTzZGTCtJZGdR?=
 =?utf-8?B?MktJL3VQMjBWbjErMVNVUVIycytuVEtPelFQQWdXNTVSNTY1QjF2dmtmRWhz?=
 =?utf-8?B?OEliMm5ZbTBpQUlrRitudz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzhuVkZNUVNHU24rUDZ6d1l1VkNSTHIxTVFBNVI2S25vVUZ5VHVjbGUzdGdi?=
 =?utf-8?B?WjM4cldFWXZtYWsvbXNTenZSMmRPQm0wWnNZb1NZQlpXajdQOE14VzhoWlEw?=
 =?utf-8?B?aXlBRlRkNE1uQ3luSitEZGtNMGtjNVZrODhid0xhRjlwaVV5ci9Oc0xBcHdv?=
 =?utf-8?B?Vm5TRUxuUHpKakNFUG10R1R0VkZNWXRDZjRnRkRsZ3lSelE2VnFFSHA2N21n?=
 =?utf-8?B?NElONmUvaE1mUm9lZ0F6TVg5RGNtSlpkaHAzcm84a1JzUzVlWEZ4NUJmV2xQ?=
 =?utf-8?B?WGhrcXNUNWlUZEdDTFhiZ1BYOUltVHNydzBsbVZHMThyUlVRdmVXdFYxS2Js?=
 =?utf-8?B?NXdmcTk3MEcwcXUydTZ1K1FFTEFjZm1GN2luVFBkQXlOSllhSnZsclczNExR?=
 =?utf-8?B?V1hlTEc1Q0d2MTJlRzQ0bXBDL0pQYm0rMm40UXhNOFFoeDdnSEpNOUhXZ055?=
 =?utf-8?B?WUZlak94OTB4SnJwSmVIS0YxajRxMnM4NEw2U090cm5HeC9HdTdTdVVTSThN?=
 =?utf-8?B?RWZaYjNKdjVoVlg4UEhaNzgxQWYwRWN6aGVMeXR5YS9OcXJETVFsUFhvQnBa?=
 =?utf-8?B?ZFZQcElJNlptT2tFRTluMU9Oc1dzMU9FRHY2Q3Z1MXZrZW9vTVJZWThDSHdh?=
 =?utf-8?B?QlN4dWV4alRxWlczeHJ4R0QxOU1QSVZqUmJ2aXJnM01VM0Z5UFlhTUhLSThS?=
 =?utf-8?B?eWhJMWxYQXlQWEd4VExEVzE3YTZNMDBOMWZkbkljMXJMM3NlQXlhMVdteEVv?=
 =?utf-8?B?TzJqWWZmMTVSWDZWOVkzRXpuV3hiT0VLcElDN1lKckgwK2lZWGNleTFSSmc1?=
 =?utf-8?B?QjJuQUh5NXVzVFlXdjMyNnovcXdDTlo2NFZjMWNjTWtCdlF1bXBjS1B3UVlM?=
 =?utf-8?B?VG1INmVLU1ZwRWpHWTVIOU5BZytETlFmaTBOVkIvc1NoeUlVT0MrSlh1b0xp?=
 =?utf-8?B?bXIxeWhiZFNQbFdqRmtibzYrM0NvaUExdm8rY3NSQ0Jvd3pDOXpQMjBpZ1hG?=
 =?utf-8?B?NUZqMlhxU2U0Q3k1SzRwZFk4U3ErUDNkeERPcHJXc1lNUzR4R3RXRzJQbGFl?=
 =?utf-8?B?YU9pZTcxWU1yV3JSTFN2RStUcDU2UE1PdEZwWDhwRjlVNnhXWERoVDVKaGlZ?=
 =?utf-8?B?TXE0TU85Wmt2VmJ5dlFTZnQ1a0NoRHE3ajNObHlnek9wejdKNXpsM2o0OWkv?=
 =?utf-8?B?cXNiWVVZVlBodDVMODBDdHFaWnNWaENKbkVsWjVFVUVqK0hLVTNvdCtpS25N?=
 =?utf-8?B?OUZPMjhGRWhIVXpJLzZsLy9kSmczS1lpbHhXN3pBZXZrVGVxeXNUTlFoMEF0?=
 =?utf-8?B?SzdUd0YyYUM4QU1zenlLb2paZGNDT0ozbmNGUExrTHRPZDJwRmVGVnE1Qkth?=
 =?utf-8?B?R201ZDhwMXE4M08vMjBmNkp0ZXdyTU1seEVVakljY3dxSzJTYU5jR1l6c0RD?=
 =?utf-8?B?TG9TdHJsR0hDNXVMRTdFV3NwdjNhUzg3NzVxMWY0ZUFZaXQwNFJGSmRnVmcr?=
 =?utf-8?B?RHFod1h2ZTRHcGg4VXM5NHBWbmxnS2FpK1pDVnhheXNTY2Q5R01kLzdPS1dL?=
 =?utf-8?B?dk5mS25ZcklUK1V2cDdDM0RyUmhsTHhuRmlPN3YrWHlWTmNwUGhBTllzVjVY?=
 =?utf-8?B?MllHU3ZmNXVXMzFwR293ZFpzZ29OMG1oTitTa3B6b1RTMTJRV2pubjErNi9P?=
 =?utf-8?B?Q2FLMGdRYXNKMHNaZUZkTndvTENaY2N0SnJreDVnUFVQdGlEU2ZpNmFRR2Y0?=
 =?utf-8?B?UkNQeVIvNDRrM2RIU3ptTzVRTVk2RS9jbmNueFFYTXpwMlY4Q2syd3N1dkUr?=
 =?utf-8?B?V29LemlPSlBBSnBDRTFKS1JCT1lQcldzWVBtSmttUHFWTHVmYmtBbmpjQWNW?=
 =?utf-8?B?OUZUK2ZQaW5uQ1NKQ2dCVWxOY2VWalRxdmZtWnNzNmdKRTFCRjdJSDBRZVFT?=
 =?utf-8?B?OVFybldERldVNmFvSFBYYVkyQmdUOW0vYUtUVWppaWUrUCt0ZzhWb0dPemVP?=
 =?utf-8?B?WURSekwxOFd6WXgrenVZWmVubWh4dkhhNFpZODl5VVRmWC94cWExR05Eam5x?=
 =?utf-8?B?amlJeHJlNzJtU2ZycnltRTlOUDYwL1FGUUNBc0dNMUtKR0FLaFZjaHhRL256?=
 =?utf-8?Q?eBDA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72569a6-1a3a-4f73-a4b1-08dce7639f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 06:37:04.1549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 57d6gqP5J7m3X07V7fXGu4aBnQGzXQl08AXACJ0aJ6nJKe6NqKfx1iotK6/4cxlqhySEPQ2vbOWPSvhIwVjP7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7991

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9y
dmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+IFNlbnQ6IDIwMjTlubQxMOaciDjml6UgMToy
Ng0KPiBUbzogR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pg0KPiBDYzogTGludXgg
S2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IENzw7Nr
w6FzLCBCZW5jZQ0KPiA8Y3Nva2FzLmJlbmNlQHByb2xhbi5odT47IFdlaSBGYW5nIDx3ZWkuZmFu
Z0BueHAuY29tPjsgUGFvbG8gQWJlbmkNCj4gPHBhYmVuaUByZWRoYXQuY29tPg0KPiBTdWJqZWN0
OiBSZTogTGludXggNi4xMi1yYzINCj4gDQo+IE9uIE1vbiwgNyBPY3QgMjAyNCBhdCAxMDowMCwg
R3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0PiB3cm90ZToNCj4gPg0KPiA+IFRoZSBm
YWlsZWQgcWVtdSB0ZXN0cyBhcmUgY3Jhc2hlcywgYmlzZWN0ZWQgdG8gY29tbWl0IGQ5MzM1ZDAy
MzJkMiAoIm5ldDoNCj4gZmVjOiBSZWxvYWQgUFRQDQo+ID4gcmVnaXN0ZXJzIGFmdGVyIGxpbmst
c3RhdGUgY2hhbmdlIikuIEkgY29waWVkIHRoZSBhdXRob3IgYW5kIHJldmlld2VycyBmb3INCj4g
ZmVlZGJhY2suDQo+IA0KPiBJdCBzZWVtcyB0byBiZSB0aGlzIGluIHRpbWVjb3VudGVyX3JlYWRf
ZGVsdGEoKSAoaW5saW5lZCBpbnRvDQo+IHRpbWVjb3VudGVyX3JlYWQoKSk6DQo+IA0KPiAgICAg
ICAgIC8qIHJlYWQgY3ljbGUgY291bnRlcjogKi8NCj4gICAgICAgICBjeWNsZV9ub3cgPSB0Yy0+
Y2MtPnJlYWQodGMtPmNjKTsNCj4gDQo+IHdoZXJlICJ0Yy0+Y2MiIGlzIE5VTEwgKGJ1dCB0aGF0
J3MganVzdCBhIGd1ZXNzIGZyb20gdGhlIGZhY3QgdGhhdCB0aGUNCj4gZXhjZXB0aW9uIGhhcHBl
bnMgdmVyeSBlYXJseSBpbiB0aW1lY291bnRlcl9yZWFkKCkpLg0KPiANCj4gU28gcHJlc3VtYWJs
eSB0aGUgdGltZWNvdW50ZXJfaW5pdCgpIGhhc24ndCBiZWVuIGNhbGxlZCB5ZXQNCj4gKGZlY19w
dHBfaW5pdCAtPiBmZWNfcHRwX3N0YXJ0X2N5Y2xlY291bnRlciAtPiB0aW1lY291bnRlcl9pbml0
KS4NCj4gDQo+IEFuZCBsb29raW5nIGFyb3VuZCwgd2UgaGF2ZSBmZWNfcHJvYmUoKSBkb2luZw0K
PiANCj4gICAgICAgICBpcnFfY250ID0gZmVjX2VuZXRfZ2V0X2lycV9jbnQocGRldik7DQo+ICAg
ICAgICAgaWYgKGZlcC0+YnVmZGVzY19leCkNCj4gICAgICAgICAgICAgICAgIGZlY19wdHBfaW5p
dChwZGV2LCBpcnFfY250KTsNCj4gDQo+IHNvIHRoZSBmZWNfcHRwX2luaXQoKSBpcyBjYWxsZWQg
Y29uZGl0aW9uYWxseSwgYnV0DQo+IGZlY19wdHBfc2F2ZV9zdGF0ZSgpIHRoYXQgZG9lcyB0aGUg
dGltZWNvdW50ZXJfcmVhZCgpIHNlZW1zIHRvIGJlDQo+IGNhbGxlZCB1bmNvbmRpdGlvbmFsbHku
DQo+IA0KPiBTbyB0aGF0IGNvbW1pdCBkOTMzNWQwMjMyZDIgbG9va3MganVzdCBicm9rZW4uIEVp
dGhlciB0aGUNCj4gdGltZWNvdW50ZXJfaW5pdCgpIG5lZWRzIHRvIGJlIGRvbmUgdW5jb25kaXRp
b25hbGx5LCBvciB0aGUNCj4gdGltZWNvdW50ZXJfcmVhZCgpIG5lZWRzIHRvIGJlIGNvbmRpdGlv
bmFsIG9uIHB0cCBiZWluZyBpbml0ZWQuDQo+IA0KDQpUaGlzIGFuYWx5c2lzIGlzIGFic29sdXRl
bHkgY29ycmVjdC4gSSBoYXZlIGNvb2tlZCB1cCBhIHBhdGNoIGZvcg0KdGhpcyBpc3N1ZS4NClRo
YW5rcyB2ZXJ5IG11Y2guDQo=

