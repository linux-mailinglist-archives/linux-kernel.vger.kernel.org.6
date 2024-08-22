Return-Path: <linux-kernel+bounces-296616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5D895ACD3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFF228392D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDC23B79C;
	Thu, 22 Aug 2024 05:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="h16Lp1f4"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2062.outbound.protection.outlook.com [40.107.247.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE26E29A5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 05:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724304335; cv=fail; b=GqAogSiTdc4RW+q+xF7YtJSlqtGOKPClpOQzJgrLATKSuju+Sd8vRtIVUpG5pMcTeym//3suhOxou+FYBktPrrY/YSdjjXT5AAgLsEOIJeFvUjKkFJtk4aKUyF9QYU5PCevbXy3f+eI08IWHd2bx0XF1/3hhgcnJv8Z8fBHXPQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724304335; c=relaxed/simple;
	bh=yYErt+5u9AQhfTzjtHytdDqU0ZI7ybRWuaputinRokQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BVOcomBMXTbbPZua96BYC2wBlpCRTjOmrpCd3tcDnN0pq40BeCNBWcR8ROUuo+A5xzKT3+LAeU0OtjkhSzl4RakJuWjD2DC7XaXnIDTtY2ifWDDxtPwB6kAe/i7+cJrSOFZ7ILv2X6oPJTPevXkjw1L9md7cN47gApKvtVB3e6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=h16Lp1f4; arc=fail smtp.client-ip=40.107.247.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HH3lVKfcxxE/TtXJpG5Zw/+d+2MDSHmDODT4g9cgICgvy6KO/De63xZzwJfNp2z7hABO3xN/nsOxf1BeO7D3fPr2R23IlPI191W8x+ozQhfj4H1P9dHqgpFW9ZjazIycJIwcxY49dL0CyeYuX2anAoNBIXdNepLfG+nEdMtAwQxrEKrBd12DzFnLb22IHAlz0hrRRuw+FR2efv1yOb8GRvkJvKDcKuEJnXnrkiGwqwd/HE4WhYl7h6Jsneie4a6sASF+moBri4dlgkFT4TafHE/z/mEDsSdvzkNEq1swwCDtLGP3Rp4vAYWUlncj10q7XcdM9nxKDpNEOaOOE05Ywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYErt+5u9AQhfTzjtHytdDqU0ZI7ybRWuaputinRokQ=;
 b=jMHthD8EElEXb4jjQEKBl/mxt9zFjYjne52iaRCd00TJPSpT8/pvB7DMLIWZj1aY3Rp8H9pVpnHJaKhYmzqegT9Rx91MTA3Ilag2nz6wTU8IN8zBghERZj4Dj5Bo72gb1rLFMoqt/Sgt7Lqx0cS+1m2n01NbLYOeH+5ShN73Z56xJy0edDPIlnkDuYXlNY3gz97ZIrZP1uPHFQ8ZZZPSmgpTS638EtELBtGI+vrsg/y/p7LrgyTOL0UrzfFkN6sZMj9tVLvlZtiWl8Y+YiyrU/ToC6OKNg5101XO0HNkLphAft8+WNAg4DWIs4DUo/YkBHzBbsMm6KrTjz0ewnbVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYErt+5u9AQhfTzjtHytdDqU0ZI7ybRWuaputinRokQ=;
 b=h16Lp1f4O3ZUEO/h/QlmFmqmCvNmN7GqCtciiM2uwrA9RaQRxNIUz2uL2oYmcI4d/yFeX84CcmszPKZgwfbirzdCC0FxxQT6YjMQ1Cn4n1nPF/Q+9bAyy1hxytDN2A4K0OgJYn+e0CLhdnPNbcMrAA/O+FlfwMIM3YoMVpUIEFBUBKNeF0t+V5oEcNt9e+FOueXpPjxhsp26YW1Mbk1TX6Sdwgga7kD4hQuK18Kp3IuS1LCc07lqdqlcevkvj1pHuIr+ywXJNYsssieiK9FzX+Dx22aj9AcAADxRTLHKebYtCcU+nkxCrLMw3Xc/8jHKo3sumKx3sVM8qZmtFvJhTQ==
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com (2603:10a6:208:f3::19)
 by DB8PR07MB6235.eurprd07.prod.outlook.com (2603:10a6:10:139::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 05:25:10 +0000
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2]) by AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2%4]) with mapi id 15.20.7875.023; Thu, 22 Aug 2024
 05:25:10 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Stan Johnson
	<userm57@yahoo.com>, Finn Thain <fthain@linux-m68k.org>, Christoph Hellwig
	<hch@lst.de>
Subject: Re: [PATCH v2] powerpc: warn on emulation of dcbz instruction in
 kernel mode
Thread-Topic: [PATCH v2] powerpc: warn on emulation of dcbz instruction in
 kernel mode
Thread-Index: AQHa9Br4BDSvPR8oAEC/NyES9AV4E7IyvxcA
Date: Thu, 22 Aug 2024 05:25:10 +0000
Message-ID: <9dbf73fe-a459-4956-8dbc-e919d9728f5e@cs-soprasteria.com>
References:
 <2e3acfe63d289c6fba366e16973c9ab8369e8b75.1631803922.git.christophe.leroy@csgroup.eu>
 <17fa6450-6613-4c34-804b-e47246e7b39c@isd.uni-stuttgart.de>
In-Reply-To: <17fa6450-6613-4c34-804b-e47246e7b39c@isd.uni-stuttgart.de>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB4962:EE_|DB8PR07MB6235:EE_
x-ms-office365-filtering-correlation-id: eafbea1c-72c4-4330-d2de-08dcc26acaba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WGlGQVN3TmhHQWpGTjFjZnhMeUpscHpEeEpRdXgzNVpjT2ZnVUkwNXVuUXI3?=
 =?utf-8?B?T3drcnY0VW9HY1FHWHVDSzNMMm12WkV3MUVMMHVlT3hzR05lV0FqTWdIWkxN?=
 =?utf-8?B?MmlCb1dtalA3ZnBVRC9FYnJmK2l1WEZPZXJDYnVRejBCTFMxc0tRY2VObjZG?=
 =?utf-8?B?d0VZdmRvTHJWdkxubUZ1R0NzOUlIbzdqZCtySE41ZTV2WVhVWGNTMC9RK3BG?=
 =?utf-8?B?YVYyc0szMklkMEtyWWpoWWI5RFpFK0VHUjlVam5NdnpxZVhxcnB4SERPWjFE?=
 =?utf-8?B?WVNKY21wSk1UMHRkOXlMdmZYNEJVdlI1TXFCU2cwMzYyQ1JNaUo3bHZxT0JL?=
 =?utf-8?B?bldENlNYUDRZSlhPUG1KcEpwbnZGeWxYbmtveTgzTG9NMzhEVEo4bXB2aTZw?=
 =?utf-8?B?enpwUHBTb0VwZ2tLUVpTOUtMbVE3ZklBanJWb0dGN3N4cUNlNUovRDhvRlRr?=
 =?utf-8?B?UDZZajBzWG4zUzhrUWw2RG5ycnd6VjVXRzBwQTFBUW82Rk82SmJ2Ti96NVZ4?=
 =?utf-8?B?S2VSdXBHK0krUEQ0V2YvSk1ZL011a3ZuRDAyN1RlL2p3SHkwOXpsYnFNYW1a?=
 =?utf-8?B?bmswL2JmQis1eko0VXA1THM5R3l1RndGaThsYytyS1c4RUR3UXNhcFIvV01U?=
 =?utf-8?B?djVXa1hhODJEMnVuYUVoTUtOMVQ4NUNseDlvVm9JY2hoK01WNmFTQURnV0V3?=
 =?utf-8?B?T0VDY3NhMVo5RldLbzhQeDRyVjBEOW9iMjVDUmhVdzZ3M2lhMkhNVnhIZFpU?=
 =?utf-8?B?eEltd3Z6ZU1ON3N1YWlwajdETzM2Nkx2M3NONURjc0RLaFRxOXNFd3lJekJK?=
 =?utf-8?B?UW8xME95SS9MdFFkcHcwbmREZmp3bDZPZVY5UE1zd2o4amlQUkozZGk3UGxn?=
 =?utf-8?B?NCtTWFFDVmVmQXY0QmxVays5dDArYWh4eWJlOTcydCtKRW56L0xtWkZ6NWZo?=
 =?utf-8?B?QW40d1k0bk44ekpITzB6Ry9yUHNSekhsWW5ybVBMMVZENHVOU2RNVmU3Qk1D?=
 =?utf-8?B?N2ptMmpMYU5SbVdEYndHTWNiemZyU3ArdlVpMExHL0RkT3Vucll0NHVtQXY4?=
 =?utf-8?B?bUtYNXlMV09Rbm1RVUNaM0gzYmVvZDN5TVBEdTFITzBiTThmNzUvZTlqMklJ?=
 =?utf-8?B?R3ozMHFXOHVZZHZLKzZPZ1lrTFgrZGp0UHNaUEdiMzN1a2NRazVtWVlEU2Vm?=
 =?utf-8?B?em4xenErcXNZTE5yR1RRTlZ4YlNrUHFhdnBjOVZ5VmVzUWpKWnJxcCtsQUEw?=
 =?utf-8?B?SWpNVXYyQUtvR29RWUdYN0xxazdLdS96N2pBSlVoeXVMODFCVmdPNjdlOW03?=
 =?utf-8?B?cU9aclp2RGVoN2hJWVlUNlNSSGVzSXk2b2VZUXZFTGxuOHlSZmNRdDREQ1hW?=
 =?utf-8?B?UC9RQXZtclJ6NGJsM20yaFEwRlprM004cWxmUVpKenh0My9QVlp0TmxXZzZV?=
 =?utf-8?B?VnNRRWx4MXM0V3JRQkxKN0pDMnVNcHlIOU1lRWxaeG12VWs5cmI1T1N2enhT?=
 =?utf-8?B?YjR3dW1YVmE4L2NyQ3pUbDMvbmcxVHJDZmVMSUNpS2VGNzdlWVZUZ3ZYczZD?=
 =?utf-8?B?NnpVTkN2WkZUZUlpbEhZNDdoTHNITUo0eks0TmhQMVU2ZzB5WGFURTMxQXha?=
 =?utf-8?B?RjlhS3A1UmkxWU9BOVZQVHFzZGhnRktmdEZnNGVTWk84cnVDYkUvcGl6MER5?=
 =?utf-8?B?N09PTVcyamIwd251ZjFuSm9EeGFhM3Yxa3YxdDFybEZ5bTZRZHYwL3Y5eC96?=
 =?utf-8?B?ZFlNTHZWTTZPVVQvRGtzRWEwOCtmOEtXdUxtUDF4UlR1bVU4R2J5TC90ZEc3?=
 =?utf-8?Q?DFgn6K1dvD/bqXU5XsJ0ERo8pjGMDFKww1A0s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4962.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzJSb0pmWWlrL04xTVA4c2IzZ3RmZFFjcDdTMXRpOU9DdzBGRkFzSEZiWCt3?=
 =?utf-8?B?WGVtQ0hGVklLZnZqVUlUWnFETzk1a1VCSGdBRW0vZ3Q1bVNkUnkwYmszLzFj?=
 =?utf-8?B?WHFTZ2RlQVFmZ3RDYTA3YWZZeWJrbU4yM1lUdzlhbmUrbmJxM25KOEVJaUVW?=
 =?utf-8?B?VE82WjdrSVNCbDRlS08xL00zZHVCTTM5d0dIcm5vcTVNdG04cFpGc2E1VVV6?=
 =?utf-8?B?Uy9jVkh2TW5uWCtOeE4ybHd6OHlkZU9EV3V4QnBzcmM3Y0pmUVB6TXBVOEVU?=
 =?utf-8?B?WERPTjVOMDVQbk1lZ1VCSTBJajNqY2dIbjgxVWRmdnZyRHBDeWxMLytob3FF?=
 =?utf-8?B?Y1pjaHlDajR5YnVYTHk3ZXRwdWZaWS9iRVFicVhSRFBMRHlob09GaStYMklT?=
 =?utf-8?B?dXkxRko4Wjdxei8vN1N1QVQyR2xOUHpCZmdUZFZObitsOGtwY1lnOG9Xd1Vo?=
 =?utf-8?B?OHNzQmpVQzBhNE1MaUhHWFltNG5sTkVkWDQzSEVRVUhTSlZ6dDRnTStXOXlF?=
 =?utf-8?B?QnNHL3VuZWhIYklMdThiQ3JkUHBGUzZMY3ZxMmFTRnpCNVlPd0dobkZsS0k0?=
 =?utf-8?B?aXl2ZlFHMkxUOG5HMk44bXd0VGxDdXhvNlRWbllwdUkyQmxRT05wcGZXWDds?=
 =?utf-8?B?WmpQR2xjOXdNdFJ2bFlsTUljMm1Wd2Q2eDVtZXBvSXQweEJYSElVMHlwOExw?=
 =?utf-8?B?eDlORllMTUUrSFdIT3hSbCtlMXp2dXorSmljZ3NMdm45MEdDR01rT2crWWgr?=
 =?utf-8?B?WmZaNm9wYmlPcDlSRExOTE83QnhsaWdmYVNQb1djZ0xSOFNNTHlLSXpVblEx?=
 =?utf-8?B?NllpOUhhWkVPcGZhaUlySTB0VTJ2OUp2R1BjTVZJNmJqc3JVZERYTnVWN1cr?=
 =?utf-8?B?bmZZYUVQQ0NTMGI1cm1ENmNXR09lQ0M2dDVVMDhtQVBwVEljVFczcEJ0MnJk?=
 =?utf-8?B?SzJJdlVWTEhnRmRsVVVwNTZlNzFjdHZCRUViY3ZtRkpIQ1dCS0huLy9NK0Zz?=
 =?utf-8?B?bFgzTDhadXdnYWRVNW83WFJhQTdHTzRiT3licUZMTVRJV0plOGpFRlE0eGN6?=
 =?utf-8?B?Z0psRlF4OTFTTHRDRnZpb1JHQWZUSFZ4VCtjYVgrMDdPeTJZdFRtdlRiZURK?=
 =?utf-8?B?VTh6NkxOVXZQVWQ5SERDbWJGdmtkd1JRTzNtcHRERzVUSVJoUFhRQWdkVW1p?=
 =?utf-8?B?TjlobzlOdmp6TFFsOUhyMXZyTmRXcGhoKzhjZnN0UW1ETWxhWUxvY1JOTVBz?=
 =?utf-8?B?c09EUXZXM1lpNUxvbTZiZ0hHY1FCWmlkTmcySnlZSXFrenB5ajNGZnoyUXNr?=
 =?utf-8?B?OEFMS0FWM1hXS0N4ZWVna0VkdWtlanBJQWR2UFNTMkpKdTF2bmp3cGFIWW1B?=
 =?utf-8?B?dnMrTm1xc3lBblZMdHZVYlpnbjA1bXFSRGFhai9jeGpCckxKK3hjdVR3MzVI?=
 =?utf-8?B?VFdYMWZKSGNBZmVnQk01bjlTSEFHWjNIQkVZY1E5cHFoVjMrWktmdnNOTUlH?=
 =?utf-8?B?Z2NRa2dRQXBWR0FWdStFWkNmM0ZmRXZkRVQ3U3RwYzZpcmEyeUl3TTZXU1kw?=
 =?utf-8?B?NWo0TDJLRThqazBVSUY3eVY5UUdhQ2swSDArdGNISGVNTzZ6WGl0SjJoaDQw?=
 =?utf-8?B?am9EMkVONnU0aklkTGZKN3ZON2ZvNUFyM3RhVkdabEQ2OUhGNG8rb0xYVFF6?=
 =?utf-8?B?aW9XT0M3c09VQjY3WW9hTE5saHhCNDlXbXdrY0dZQmw5aXo3T3ltcEZMOWJW?=
 =?utf-8?B?NThMRlBjeXNsalB6dm5GZ0hjK3NzNkJRVkl6Q2VCUEJVemYrM2h4UE9EQml4?=
 =?utf-8?B?eDIzVHJ4TU1ndk5MUHhlVXppakJuSGRJb001Tk0rZm0yU2NsQ3ZoMyt6amZv?=
 =?utf-8?B?Z0phWUNScEVmY015YkZDRVFkZ3F5MkY2L0JMdFF0TllDZXlTa3YyRytOMk16?=
 =?utf-8?B?VndLbUZjaGpuNmRkVGFuSlFlcDF6NFUzdE50cDI2VW1PZlVLcUxxV01ITXZ0?=
 =?utf-8?B?VmgzM0UxVmFEWGZwT1N3eHlTMHlNcmxZbytYMW9RaU9QeXNHcGs4MnpMSW5i?=
 =?utf-8?B?MEJhY2VZUjVRZ3h6MUtjeU9WMFFOUHdkU3VINjRBSXJCU0ZWSVhqNGdrWFFD?=
 =?utf-8?B?Wmo4OGFmYm00d202ZnhMa2VqQTJyR3RPWkxkVGpxMXg4TmJyYzlJcERqOFU1?=
 =?utf-8?Q?6ZGvEHwpeoRkxjaY5ViP2F8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50317A2C2AFD5944BA75F024DD3F69DA@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eafbea1c-72c4-4330-d2de-08dcc26acaba
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 05:25:10.3039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q3pw3S7TmINDWrwS+wyMvBaSFxUjrZsxPGY+whpVQKbkRnQ+pN8chisgxVbibWbuHM548tEmKpKSLz4tFZALzoA5QvZN1E7t1w6xYO7Z+ILS7GhSLJkcVPsVBGkEVAfx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6235
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 88.124.70.171
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: DB8PR07MB6235.eurprd07.prod.outlook.com

KyBDQyBDaHJpc3RvcGggSGVsbHdpZw0KDQpIaSwNCg0KTGUgMjIvMDgvMjAyNCDDoCAwMDozOSwg
Q2hyaXN0aWFuIExhbXBhcnRlciBhIMOpY3JpdCA6DQo+IFtWb3VzIG5lIHJlY2V2ZXogcGFzIHNv
dXZlbnQgZGUgY291cnJpZXJzIGRlDQo+IGNocmlzdGlhbi5sYW1wYXJ0ZXJAaXNkLnVuaS1zdHV0
dGdhcnQuZGUuIETDqWNvdXZyZXogcG91cnF1b2kgY2VjaSBlc3QNCj4gaW1wb3J0YW50IMOgIGh0
dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+DQo+IFNvcnJ5
IHRvIHdyaXRlIGEgcmVwbHkgdG8gdGhpcyBvbGQgbWFpbC4gQnV0IGFmdGVyIHllYXJzLCBJIGZp
bmFsbHkNCj4gZGVjaWRlZCB0byB0YWNrbGUgYW4gIm9sZCIgcHJvYmxlbSB0aGF0IGhhcyBjb21l
IHVwLi4uDQo+IEFuZCB1bmZvcnR1bmF0ZWx5IGl0IGlzIHJlbGF0ZWQgdG8gdGhpcyBwYXRjaC4g
QnV0IGxldCBtZSBleHBsYWluLg0KPg0KPiBPbiA5LzE2LzIxIDQ6NTIgUE0sIENocmlzdG9waGUg
TGVyb3kgd3JvdGU6DQo+PiBkY2J6IGluc3RydWN0aW9uIHNob3VsZG4ndCBiZSB1c2VkIG9uIG5v
bi1jYWNoZWQgbWVtb3J5LiBVc2luZw0KPj4gaXQgb24gbm9uLWNhY2hlZCBtZW1vcnkgY2FuIHJl
c3VsdCBpbiBhbGlnbm1lbnQgZXhjZXB0aW9uIGFuZA0KPj4gaW1wbGllcyBhIGhlYXZ5IGhhbmRs
aW5nLg0KPj4NCj4+IEluc3RlYWQgb2Ygc2lsZW50ZWx5IGVtdWxhdGluZyB0aGUgaW5zdHJ1Y3Rp
b24gYW5kIHJlc3VsdGluZyBpbiBoaWdoDQo+PiBwZXJmb3JtYW5jZSBkZWdyYWRhdGlvbiwgd2Fy
biB3aGVuZXZlciBhbiBhbGlnbm1lbnQgZXhjZXB0aW9uIGlzDQo+PiB0YWtlbiBpbiBrZXJuZWwg
bW9kZSBkdWUgdG8gZGNieiwgc28gdGhhdCB0aGUgdXNlciBpcyBtYWRlIGF3YXJlIHRoYXQNCj4+
IGRjYnogaW5zdHJ1Y3Rpb24gaGFzIGJlZW4gdXNlZCB1bmV4cGVjdGVkbHkgYnkgdGhlIGtlcm5l
bC4NCj4NCj4NCj4NCj4gVGhlIGRldmljZXMgdGhhdCBhcmUgYWZmZWN0ZWQgYXJlIEFQTTgyMXh4
OiBNeUJvb2sgTGl2ZSwgTWVyYWtpIE1YNjAsDQo+IE5ldGdlYXIgV05EUjQ3MDAsIC4uLg0KPiBB
bGwgdGhlc2UgaGF2ZSB0aGlzICJzcGxhdCIgZHVyaW5nIGJvb3Q6DQo+DQoNCi4uLg0KDQo+DQo+
IHdoYXQgaGFwcGVucyBpcyB0aGF0IHRoZSBFTUFDIChldGhlcm5ldCBkcml2ZXIpIHVzZXMgYQ0K
PiBkbWFfYWxsb2NfY29oZXJlbnQgaGVyZToNCg0KDQouLi4NCg0KPiBhbmQgdGhpcyByZXN1bHRz
IGluIGEgY2FsbCB0byBkbWFfZGlyZWN0X2FsbG9jYXRpb24oKSwgd2hpY2ggaGFzIG9uZQ0KPiBp
bm5vY2VudCBsb29raW5nIG1lbXNldCgpOg0KDQoNCm1lbXNldCgpIGNhbid0IGJlIHVzZWQgb24g
bm9uLWNhY2hlZCBtZW1vcnksIG1lbXNldF9pbygpIGhhcyB0byBiZSB1c2VkDQppbnN0ZWFkLg0K
DQouLi4NCg0KPiBBbmQgb2YgY291cnNlLCB0aGlzIHRyaWdnZXJzIHRoZSBXQVJOSU5HIGFib3Zl
LiBBcyBmb3Igd2h5IG1lbXNldCB1c2VzDQo+IHRoYXQgZGNiei4uLiB0aGlzIGlzIGV4cGxhaW5l
ZCBpbjoNCi4uLg0KDQo+DQo+IGNvdWxkIHRoaXMgV0FSTl9PTl9PTkNFIG1heWJlIGJlIGRvd25n
cmFkZWQgdG8gYSBzaW5nbGUgcHJfaW5mb19vbmNlPw0KPiBJIGRvbid0IHNlZSBob3cgdG8gdGFj
a2xlIHRoaXMgIm5lYXRseSIgaW4gYSBiZXR0ZXIgd2F5Lg0KDQpDYW4geW91IHRyeSB3aXRoIHRo
ZSBjaGFuZ2UgYmVsb3cgPw0KDQpkaWZmIC0tZ2l0IGEva2VybmVsL2RtYS9kaXJlY3QuYyBiL2tl
cm5lbC9kbWEvZGlyZWN0LmMNCmluZGV4IDQ0ODBhM2NkOTJlMC4uZTJiZWU1ZmNjMTcyIDEwMDY0
NA0KLS0tIGEva2VybmVsL2RtYS9kaXJlY3QuYw0KKysrIGIva2VybmVsL2RtYS9kaXJlY3QuYw0K
QEAgLTI4MywxMyArMjgzLDE1IEBAIHZvaWQgKmRtYV9kaXJlY3RfYWxsb2Moc3RydWN0IGRldmlj
ZSAqZGV2LCBzaXplX3QNCnNpemUsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9f
YnVpbHRpbl9yZXR1cm5fYWRkcmVzcygwKSk7DQogICAgICAgICAgICAgICAgaWYgKCFyZXQpDQog
ICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dF9mcmVlX3BhZ2VzOw0KKw0KKyAgICAgICAg
ICAgICAgIG1lbXNldF9pbyhyZXQsIDAsIHNpemUpOw0KICAgICAgICB9IGVsc2Ugew0KICAgICAg
ICAgICAgICAgIHJldCA9IHBhZ2VfYWRkcmVzcyhwYWdlKTsNCiAgICAgICAgICAgICAgICBpZiAo
ZG1hX3NldF9kZWNyeXB0ZWQoZGV2LCByZXQsIHNpemUpKQ0KICAgICAgICAgICAgICAgICAgICAg
ICAgZ290byBvdXRfbGVha19wYWdlczsNCi0gICAgICAgfQ0KDQotICAgICAgIG1lbXNldChyZXQs
IDAsIHNpemUpOw0KKyAgICAgICAgICAgICAgIG1lbXNldChyZXQsIDAsIHNpemUpOw0KKyAgICAg
ICB9DQoNCiAgICAgICAgaWYgKHNldF91bmNhY2hlZCkgew0KICAgICAgICAgICAgICAgIGFyY2hf
ZG1hX3ByZXBfY29oZXJlbnQocGFnZSwgc2l6ZSk7DQoNCg0KDQo+DQo+IEJ1Z0xpbms6DQo+IDxo
dHRwczovL2dpdGh1Yi5jb20vb3BlbndydC9vcGVud3J0L3B1bGwvMTQwMzcjaXNzdWVjb21tZW50
LTIzMDI0ODU0MTQ+DQo+DQo=

