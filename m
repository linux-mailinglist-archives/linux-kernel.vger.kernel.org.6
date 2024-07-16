Return-Path: <linux-kernel+bounces-253302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A47931F49
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD571C21169
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFFD13FF9;
	Tue, 16 Jul 2024 03:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="YmxABWPJ"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D14133C7;
	Tue, 16 Jul 2024 03:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721100671; cv=fail; b=q4Eb9ve4P8ZJb05+a0qod4h4AO37mQeFAPMhMMqh0egnzuNnwtZE9BXomij54vVUmKcIBwYUcoNpDwS50o8/MZ0CoxSmZ3dFqVC/eVQ70BGEonzhwSNrVu88tAr0i3WUg3gAMBcEHdshSebgSI5tal1yQZR7B7BXT6s5jQtcpWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721100671; c=relaxed/simple;
	bh=Q/J7pwrHzUOlTtm1uwzfg6csijRTVnqiRIXWfFTrDO4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fS2F1fEuceo+435wV1etEWCE/JXltn02iJwMpuNU2XbX9o4keZj7X/rI6/0qDFL2a/4lRfMmB+Du4dEikcb439wLQJYeqs9Cv5z8Y3lYxUvu5yX0sIGRen2VL5d0/MZ8Np7ZVB/y+cTR7zluRYPFL2t28C3hrSvlzC4vyxjjQG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=YmxABWPJ; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FJcdjf031360;
	Mon, 15 Jul 2024 20:30:44 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40c9p5wy7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 20:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfxCii7hcOkjt2ws6mYCO8lQC8E2BCPMF1UyT2OAZ7e/bAnX+OFxjQvwyKl6LocY6VUzbGsQa65eJ+JNiz8fc2J3LW+aZTnrUtPdRXLImWI+DWzSJsAdwhi2jfeGfXY7RYCxnH6myXTNAr0tpBdAo2OJWA66uw0z9ZZeGQUWVA23uFkBtujusAaw9TdPqeWcFjvks//kLZBpFDCwtEmtBpXOuGyGstR67rbvYsoWw2DNvT9fJVUki+5J2B4lJujNKW3CR/9r0Kk/Vt3FJU/4dsvTK8EnGNYV6S/I76eEYtWqmC0Kjwa+bDoPJt1dC3Bm++y9BOLQlVSJZpBvK3qgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6biwH3WYw8nSk7Q5PaVdkGEe+qReVmBl5Om2qokwh1U=;
 b=vL01C1b6fsXwb+vTpB0al9erliQC5KIdtZJeDt6UoaYMXdJ+rMbvxCaqtxpEK9w38pHeDzkGja+Z+MD0O7d8zIRwfzXk53dM1srEWYfn788QMtMt/YuW6NTQPMbVd7wbtImrPgqvJAvwsCXQZFo99KGbFrvMbDQpp7ZJFvVlhIzPNKxy2NSM71I965c3Ic8R49Rvu0l7V9hb6Kuzbj1hkJ7/jyFDp4MBZVGXhsUxKclvOdOK0TMwtonNEOY+bnF1s/4dauNpPbSsAR0NkDtoHI+MUYQDbzS4R0KIv+GMbMwAuvmBC9G4e2Fu+yP403Hq/Iu81Vzw+pmNPwnhaRAKyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6biwH3WYw8nSk7Q5PaVdkGEe+qReVmBl5Om2qokwh1U=;
 b=YmxABWPJhyt8f648oMC8UETl0lvMBkOAGcjlaX/Kl0mHMhmnS+dqKmN1wi2hllLpO5i1KpeuhuTzXVMMxPpGd8G/dMdIQz81pdwA0fdayCog1rds20/pAy+qA+u9CXRbk0AuYOliU2jOyNul8RSkayI9ft4dAYCuLXqDXPObnis=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by CH4PR18MB6264.namprd18.prod.outlook.com (2603:10b6:610:22f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 03:30:40 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%6]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 03:30:39 +0000
Message-ID: <b65b99c4-ff77-4615-abbe-eed1a9b627da@marvell.com>
Date: Tue, 16 Jul 2024 09:00:29 +0530
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 5/5] firmware: imx: adds miscdev
To: Pankaj Gupta <pankaj.gupta@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240712-imx-se-if-v5-0-66a79903a872@nxp.com>
 <20240712-imx-se-if-v5-5-66a79903a872@nxp.com>
 <90430412-438a-4403-95cd-3e8553122282@marvell.com>
 <AM9PR04MB86044615E8346EE5B244B5A495A12@AM9PR04MB8604.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <AM9PR04MB86044615E8346EE5B244B5A495A12@AM9PR04MB8604.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::6) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|CH4PR18MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: cd714eff-213e-49de-39f5-08dca547a9fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MXRPWFk0ZCtIMjFxYld1Vzc4blZ2MFJQcXR4a01XdVMxb1JOTUxRVWlOb29k?=
 =?utf-8?B?T041Q1N5KzNHbG5wcEExNXRPWXYyREVTOUF5bEdDWldUZThQYmh3UEErMmhM?=
 =?utf-8?B?TUNBUzhFRTEyNCtDUEo0bmJ2S0tCY1RQZ3pMdDdvamFxU0xUcDI1eGFDaDdC?=
 =?utf-8?B?ODl0TTZ5Qkp3dG9ud0JvOWFvWER5QzVDUUExcncwWmlLcVUydVdqeWxJNm5q?=
 =?utf-8?B?aVVwVVc3TGt4OGtZb2psRGd5ZDN1ekJFaWF1ZTYxeno1d3hIYWNoRmpieFho?=
 =?utf-8?B?aCtuNksxU0NHS1dEUldYYW1XcHFDZWp4UnRndWlaR0N3UDRGNitmbTVzbVl3?=
 =?utf-8?B?OTFLRnpKeUdBQ3lTMnpnTDJUOFA5NUk3TEJnSS9hKzJhZGR4ei9UWHUzWXNo?=
 =?utf-8?B?NU5PU2RmaEhtRUVxL01FdEFjcGpPMktoVnJicEU0eU5XL1RPc0tMZTZLN3Js?=
 =?utf-8?B?clBUVXpJYzVXRmJZTUY2anI5UG94c1ZKdWdwcFJTdEVYKzNhWGlZbjJlZGo1?=
 =?utf-8?B?TEFHNnZtZjZaMUlXLzd0MEo3NGhRMDFLQXhOajkzdkJLTGREaWxTQWhZbm1P?=
 =?utf-8?B?eStMMjkyeUhtWjZKQ2lGUTJUeVNsVWtycUgxOGYrL1VyTngzWG9JdUVoV2Rv?=
 =?utf-8?B?MVhaVmZORllRUzlWeGhNS1BMOTBrWEg2KzJRRCtFYmJ5QWQzb09xVTVudVdM?=
 =?utf-8?B?QXVocWE3cUFhblhUTXkxY1dlc1NsUWEzVmhocUl4YXIwcmR2VVBqdGNWbmNH?=
 =?utf-8?B?c2ZNWHV0cVo3dFJjQkRleWZqb0hwZzFEWlRCZHFURmRHay9IMzV4a2F3UitT?=
 =?utf-8?B?bHlWV2Y4Wnc1ZGYveEJ5UmZzTUh0dy9xc3pnRm1MQWpKQnFmcytkaWMvbFBj?=
 =?utf-8?B?Y2QzQlU4T05tU1JQMmpJV2xJbGt2S1FRaG4zbzRnS0lhNnA3L01GbWdSVEs4?=
 =?utf-8?B?MHV5dEdoMVRSZVBPT2tmTDQ5cHdXVHVSRDJvbkx6MHlucjFZcTlZNkUra28x?=
 =?utf-8?B?Ukt1WUpiU2N1dFZhbi9wam14WTRqMC9QWHVGSm9Mc3dsVFRnYUVVaHRlUnlJ?=
 =?utf-8?B?RjgwUndZSk1jZ0xhRGpCeWV4V1dIODVpU1BRMnM4NCtIeU93OUVMOVhOb0Ny?=
 =?utf-8?B?UVI0ZWJBQy9EeWVyMEZnMUtMSjRlOTZlTGZhZXd3bmdhckRrLy93WkFqRWpn?=
 =?utf-8?B?bDc4V1NPcVp2a2NVMlpkNDJlOWN6YzJoOThwdndGUDgrNzNmaDB1ZGZHbkEz?=
 =?utf-8?B?N25uamg0MTJMOFppeTZNYlZmN3FwWEJxcFdnOUpJMWk1UDlLZ1pNL0RGTHJQ?=
 =?utf-8?B?a25XWlh5YjJ4Z0tiVXV6WTlsV09JQm9OY0gwaHZJbnNQSW5xVUcrS3oxNldw?=
 =?utf-8?B?Q0FzNVl4V2ZzZldpa0JJNXpWK2t3anAybnVzeUNwaWRDSExGYUpnZFhvaTA4?=
 =?utf-8?B?aG9RZFZoV3k1ODIyVWJDNTh1Z1ZFQWtBb3RNOHgxdlZnQlJra0IzcEVBQzRl?=
 =?utf-8?B?YUQ1Y1hzbGlacjlrWnVHS3ZLTVNOVmVrZjVwcWFYZzZSSzJjR0RBdHdGS3Nk?=
 =?utf-8?B?akJaWTlGSHI5bCtFT3dSUU5ha2dUTENvaWwxVWxkSGY5SzQxazdIMjJENk5i?=
 =?utf-8?B?K0tvR1pCS0JzVXk0WHR1Q014TjhqSlRQelVLc0ZVeTMvK1ZkRkc5SnZGM3pY?=
 =?utf-8?B?akcwelZCdm9ob28wWFJydTY2a21HRUg5SU5sSUlzK1NUK3hNWnBWL1FvU1Iw?=
 =?utf-8?B?amJHcnZhWnA1c2JlWkxXQS9xOXBweVZGR1RQTC9mTGZZK3AzeWtPZEIydmR3?=
 =?utf-8?B?RDFZcHNUbWpzRHB2bk5idG9hZHltTHVIM2UwSjdEcjVRU1NmdGd4cTlGSks1?=
 =?utf-8?Q?iIVN6HkgKKYFn?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MjY3c0tkUjVnTDdzZ3AvTzFQSHBobXhrbjEvZmRPeWlEalY0eFNkeDZ0dmxX?=
 =?utf-8?B?U0dkdE00SUJEYmt1c21QMGlvL09MWnhEem9odG1UdUlEVGxjaG01d0NjSnJm?=
 =?utf-8?B?M2ZCcUtvZG9yMm1uRUhZRW84TFFpVXcxU29ld1RYdGExL1JiVElKV3I0QXJD?=
 =?utf-8?B?dU5qaFFkTDJsWUV5bmFveWc3VlVMS1NIMWtyREdqcWRya3Vtb2FoTnI0MS9Q?=
 =?utf-8?B?dUJLV1BURUJUdERBVGVmZ3BFeHREYzRtOE5NRkYyUGhTMVUvSWRKWGFuUmR6?=
 =?utf-8?B?T3g5TGVWblhnbHBDY1A5UnhqdERsdVZidDVmOCsvRlpDdTdJT3lHMy8waURO?=
 =?utf-8?B?cVRzcHpqV3FoMXVSVk0xcU9vaWUwUlp1Y0xpM3hJdHI0MDFpOHpTcHVmaWRo?=
 =?utf-8?B?S1gxYnR2TUw2V0k4dDlJaEh3endTUE02QS9CVkxhR3JHYno4YWs1MVo2eFR1?=
 =?utf-8?B?VHN0RTFoUjRYT0R6cDF6N1hzeGRWOTV2WFJkT29ZcW9rem5BYkVwa3I2bTc3?=
 =?utf-8?B?VUxIRy9SWThPcTRjR3VHOWQ0ZTFGQStEVDR5V3pwSklzdWw3dmFrblgxa1Bm?=
 =?utf-8?B?M0svbVFERmljcldHUzZNWVUrVDhxcnoxbHFWRHNGWkkyeWN3WU95VzVpbWto?=
 =?utf-8?B?QXN2K2dOdWdYb015ZGVRT0MwSHRrYUVZRWFmdWVhemw0RHdFZjdYL05OT2wx?=
 =?utf-8?B?elo0NlhKTFJBMWsvNUNzK1dKNG9jMFRmK0J1aEQ2THN3b1MzK1U2QTdtM0VD?=
 =?utf-8?B?QmZ4alRIeVRJMENzZ2UyQkllQlArRDZFUEFrSDFQc2lEdlI5eklyRm9JSll3?=
 =?utf-8?B?RUMyZHg2U2dhZmtIZGpUS0FhQlRYcDRLZkEwOThqZHJnVGlRV3J5WExBZTFU?=
 =?utf-8?B?Y2xxZE9uVDlKQVZCb3d6NkU1dVVDNlcvN2dKNndQSDFrdUh4UWhjQlFWTmth?=
 =?utf-8?B?MmtCaUVjK0drZ1loMy9aYVlsb0hxZVQrQnhwSGlYZFBDMWsyMXhnWTlEaGZT?=
 =?utf-8?B?OGV6QjNYVUJJNDFuUzRDVGFlS2t2WVFmV0JNeTNyMjA2VitZdW1aYWZsWUJi?=
 =?utf-8?B?S3lYQ1RVcUZhcXBDQ2xnRjZtdE1aN21qeklnbmpOdGpNVkVvaWJDZVRSVC9B?=
 =?utf-8?B?NFBxRjhRNlFOdTVaeHZxL3dUYVpXeFpWdzBBZ2tPTTUxQnBDRjBWdFlOVmZk?=
 =?utf-8?B?YSttelJPbG9pVXQ1WTFQaWxnaXMvMjNyVjl0b2JUcUYzUVZGUWFxQXZ0M1Ew?=
 =?utf-8?B?VUFoUWkyN3g1N3VpMDJkYklCeVFHN0M1dzBGVDJJSEhlNnp0ZW5BT3BBR3Fy?=
 =?utf-8?B?dnpRVURTVU0zRXhXTlIwNndXd0dyaHo4ZkJoYXNEMDM1MENNUnNuU3JSenF4?=
 =?utf-8?B?YVNRckUrVzJWOE1jemYzaDd2ODRpbXNiUkgvOUp0UG4wU2l3VWVlT0UwcEVq?=
 =?utf-8?B?RjM2cEVCUFRGWmtIekRpYlpRdHlIVUI3MmxxVis4ekhZbEtYVXZXVkkyOER5?=
 =?utf-8?B?MkJhZWw4ekk0L0NxdDBaTzRNWHBNUkovRnNnZGdLZnlvTTFhWHZoMlhLTUdF?=
 =?utf-8?B?QlNEeEM5bFc4dmVRWGc0ZEFrZVVZbUZ1NWsxb1Jtc3BkVGc3alU0WUYxRjg1?=
 =?utf-8?B?SWN5Q0wrQjJtWlhFUjFuZUpDeFVoNEhXdDhZK3NqSUxYbE9pd1NyaHE2N0hG?=
 =?utf-8?B?TTZiMm1hWkhPNUhRd0ozUHFCVStoZ09wY1RJYXB3dnM4RGxrd3B6Y01EQnph?=
 =?utf-8?B?Z1BpNnMvZHpJSVUxemMvMERtb3lwV1NFM3NSVm9ZeDBVTGpNUktQOWd6QXBz?=
 =?utf-8?B?YTNYcGVXQ3Zsa0RzNnhDU0RPVUNMTWtmVEVKK0xxUXRmMXFKbHhYSStDR0pL?=
 =?utf-8?B?NEszZytSd0hRa3lqby9xYlBsdkpiNysxZ28zVFp0RytxRDNmRHB4WmwvTkcz?=
 =?utf-8?B?NFR5a3FUL1Uzam52NE44SUtaYm5xclJULzl2dnk5ZGlOU3cwZW9sSDBnN0Q0?=
 =?utf-8?B?UXcyZHdGeEo4UERJQjZjQVpUSHlTUTlnRDhPemJEQnBoQkRNekl6M2JqcER6?=
 =?utf-8?B?ZVJVcVU1SVpmckZVazMwNlpiN2lzazhRSGtYRWpGc0JvTmsvNm8vTXFNZEZ3?=
 =?utf-8?Q?j+F+CJG0ITj6PTJcxnzcGYFAr?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd714eff-213e-49de-39f5-08dca547a9fa
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 03:30:39.5866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbJaoDjW/vvXGpCRtppVv5yL8ArmmTbRje8NgK2avg5bOd20nmNtvGfju3lt9zurwarNmTS9v3M9v6Yt/sRb9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR18MB6264
X-Proofpoint-GUID: N8MDnx5DYxdIfvDn79tql4Y0SJos2DsR
X-Proofpoint-ORIG-GUID: N8MDnx5DYxdIfvDn79tql4Y0SJos2DsR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-11_01,2024-05-17_01

On 7/15/2024 2:33 PM, Pankaj Gupta wrote:
>> >
>> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
>> > ---
>> >    Documentation/ABI/testing/se-cdev |  43 +++
>> >    drivers/firmware/imx/ele_common.c | 192 ++++++++++-
>> >    drivers/firmware/imx/ele_common.h |   4 +
>> >    drivers/firmware/imx/se_ctrl.c    | 697
>> ++++++++++++++++++++++++++++++++++++++
>> >    drivers/firmware/imx/se_ctrl.h    |  49 +++
>> >    include/uapi/linux/se_ioctl.h     |  94 +++++
>> >    6 files changed, 1076 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/Documentation/ABI/testing/se-cdev
>> b/Documentation/ABI/testing/se-cdev
>> > new file mode 100644
>> > index 000000000000..3451c909ccc4
>> > --- /dev/null
>> > +++ b/Documentation/ABI/testing/se-cdev
>> > @@ -0,0 +1,43 @@
>> > +What:                /dev/<se>_mu[0-9]+_ch[0-9]+
>> > +Date:                May 2024
>> > +KernelVersion:       6.8
>> > +Contact:     linux-imx@nxp.com, pankaj.gupta@nxp.com
>> > +Description:
>> > +             NXP offers multiple hardware IP(s) for secure enclaves like EdgeLock-
>> > +             Enclave(ELE), SECO. The character device file descriptors
>> > +             /dev/<se>_mu*_ch* are the interface between userspace NXP's
>> secure-
>> > +             enclave shared library and the kernel driver.
>> > +
>> > +             The ioctl(2)-based ABI is defined and documented in
>> > +             [include]<linux/firmware/imx/ele_mu_ioctl.h>.
>> > +             ioctl(s) are used primarily for:
>> > +                     - shared memory management
>> > +                     - allocation of I/O buffers
>> > +                     - getting mu info
>> > +                     - setting a dev-ctx as receiver to receive all the commands from
>> FW
>> > +                     - getting SoC info
>> > +                     - send command and receive command response
>> > +
>> > +             The following file operations are supported:
>> > +
>> > +             open(2)
>> > +               Currently the only useful flags are O_RDWR.
>> > +
>> > +             read(2)
>> > +               Every read() from the opened character device context is waiting on
>> > +               wait_event_interruptible, that gets set by the registered mailbox
>> callback
>> > +               function, indicating a message received from the firmware on
>> message-
>> > +               unit.
>> > +
>> > +             write(2)
>> > +               Every write() to the opened character device context needs to
>> acquire
>> > +               mailbox_lock before sending message on to the message unit.
>> > +
>> > +             close(2)
>> > +               Stops and frees up the I/O contexts that were associated
>> > +               with the file descriptor.
>> > +
>> > +Users:
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__eur01.safelinks.protection.outlook.com_-3Furl-3Dhttps-253A-252F-252Furldef&d=DwIFAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=irs9uaMkZhrBGwocSQHnF3oPtWbcHMxKGUrMqKRCEPlpxSwXEjtvRG6tSZIgZpdP&s=tlWEfCGEI9rQKPNa6Hqtp12aeU3xAt52L_W8G0a_gns&e=  <https://urldefense.proofpoint.com/v2/url?u=https-3A__eur01.safelinks.protection.outlook.com_-3Furl-3Dhttps-253A-252F-252Furldef&d=DwIFAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=irs9uaMkZhrBGwocSQHnF3oPtWbcHMxKGUrMqKRCEPlpxSwXEjtvRG6tSZIgZpdP&s=tlWEfCGEI9rQKPNa6Hqtp12aeU3xAt52L_W8G0a_gns&e=>
>> ense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-3A__github.com_nxp-
>> 2Dimx_imx-2Dsecure-
>> 2Denclave.git%26d%3DDwICaQ%26c%3DnKjWec2b6R0mOyPaz7xtfQ%26r%
>> 3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU%26m%3D3B5Yr-
>> 4HUlH7ooyxfcf-
>> aduiDYoo4kM4RS1h04NEzdn8QxoJjMviHugQtMh04YXm%26s%3DA4zE7ce-
>> kjpGZKtsRrqZiqW7asUowcGapT0QWWzWW3k%26e%3D&data=05%7C02%7
>> Cpankaj.gupta%40nxp.com%7C209a9f8fa717476622e308dca49f4664%7C6
>> 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63856625120882519
>> 7%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz
>> IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=%2F%2FHN
>> V%2F%2FlYkPyoKDXFYvd47oIeKHTR7rnwtgz%2FYm4Szg%3D&reserved=0
>> <https://urldefense.proofpoint.com/v2/url?u=https-3A__eur01.safelinks.protection.outlook.com_-3Furl-3Dhttps-253A-252F-252Furld&d=DwIFAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=irs9uaMkZhrBGwocSQHnF3oPtWbcHMxKGUrMqKRCEPlpxSwXEjtvRG6tSZIgZpdP&s=5yRhH69PhbqhbDOL5Ob4suOtQm4EnfbilespsbVU0cU&e=  <https://urldefense.proofpoint.com/v2/url?u=https-3A__eur01.safelinks.protection.outlook.com_-3Furl-3Dhttps-253A-252F-252Furld&d=DwIFAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=irs9uaMkZhrBGwocSQHnF3oPtWbcHMxKGUrMqKRCEPlpxSwXEjtvRG6tSZIgZpdP&s=5yRhH69PhbqhbDOL5Ob4suOtQm4EnfbilespsbVU0cU&e=>
>> efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-3A__github.com_nxp-
>> 2Dimx_imx-2Dsecure-
>> 2Denclave.git%26d%3DDwICaQ%26c%3DnKjWec2b6R0mOyPaz7xtfQ%26r%
>> 3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU%26m%3D3B5Yr-
>> 4HUlH7ooyxfcf-
>> aduiDYoo4kM4RS1h04NEzdn8QxoJjMviHugQtMh04YXm%26s%3DA4zE7ce-
>> kjpGZKtsRrqZiqW7asUowcGapT0QWWzWW3k%26e%3D&data=05%7C02%7
>> Cpankaj.gupta%40nxp.com%7C209a9f8fa717476622e308dca49f4664%7C6
>> 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63856625120882963
>> 1%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz
>> IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=Qyd5KBGqb
>> 78IHjvFQmAyJlq5YSbbViboRTLl0IyGxzg%3D&reserved=0>,
>> > +
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__eur01.safelinks.protection.outlook.com_-3Furl-3Dhttps-253A-252F-252Furldef&d=DwIFAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=irs9uaMkZhrBGwocSQHnF3oPtWbcHMxKGUrMqKRCEPlpxSwXEjtvRG6tSZIgZpdP&s=tlWEfCGEI9rQKPNa6Hqtp12aeU3xAt52L_W8G0a_gns&e=  <https://urldefense.proofpoint.com/v2/url?u=https-3A__eur01.safelinks.protection.outlook.com_-3Furl-3Dhttps-253A-252F-252Furldef&d=DwIFAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=irs9uaMkZhrBGwocSQHnF3oPtWbcHMxKGUrMqKRCEPlpxSwXEjtvRG6tSZIgZpdP&s=tlWEfCGEI9rQKPNa6Hqtp12aeU3xAt52L_W8G0a_gns&e=>
>> ense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-3A__github.com_nxp-
>> 2Dimx_imx-
>> 2Dsmw.git%26d%3DDwICaQ%26c%3DnKjWec2b6R0mOyPaz7xtfQ%26r%3D
>> V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU%26m%3D3B5Yr-
>> 4HUlH7ooyxfcf-
>> aduiDYoo4kM4RS1h04NEzdn8QxoJjMviHugQtMh04YXm%26s%3DT2WGFwK
>> VpY19AaCUWWaSX7SllYLFZ6bFKZspKqc2Nuw%26e%3D&data=05%7C02%7
>> Cpankaj.gupta%40nxp.com%7C209a9f8fa717476622e308dca49f4664%7C6
>> 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63856625120883392
>> 8%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz
>> IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=%2FzaGw%
>> 2BcCV%2F%2FMUA1tdxVNhwE0avSM18wIriqH1%2FMoohQ%3D&reserved=
>> 0
>> <https://urldefense.proofpoint.com/v2/url?u=https-3A__eur01.safelinks.protection.outlook.com_-3Furl-3Dhttps-253A-252F-252Furld&d=DwIFAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=irs9uaMkZhrBGwocSQHnF3oPtWbcHMxKGUrMqKRCEPlpxSwXEjtvRG6tSZIgZpdP&s=5yRhH69PhbqhbDOL5Ob4suOtQm4EnfbilespsbVU0cU&e=  <https://urldefense.proofpoint.com/v2/url?u=https-3A__eur01.safelinks.protection.outlook.com_-3Furl-3Dhttps-253A-252F-252Furld&d=DwIFAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=irs9uaMkZhrBGwocSQHnF3oPtWbcHMxKGUrMqKRCEPlpxSwXEjtvRG6tSZIgZpdP&s=5yRhH69PhbqhbDOL5Ob4suOtQm4EnfbilespsbVU0cU&e=>
>> efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-3A__github.com_nxp-
>> 2Dimx_imx-
>> 2Dsmw.git%26d%3DDwICaQ%26c%3DnKjWec2b6R0mOyPaz7xtfQ%26r%3D
>> V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU%26m%3D3B5Yr-
>> 4HUlH7ooyxfcf-
>> aduiDYoo4kM4RS1h04NEzdn8QxoJjMviHugQtMh04YXm%26s%3DT2WGFwK
>> VpY19AaCUWWaSX7SllYLFZ6bFKZspKqc2Nuw%26e%3D&data=05%7C02%7
>> Cpankaj.gupta%40nxp.com%7C209a9f8fa717476622e308dca49f4664%7C6
>> 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63856625120883820
>> 8%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz
>> IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=7EHPHbB5Y
>> XpDKVGIjHAyj8X1Kr1Gjba%2FcrwQPYgvP2k%3D&reserved=0>
>> > +             crypto/skcipher,
>> > +             drivers/nvmem/imx-ocotp-ele.c
>> > diff --git a/drivers/firmware/imx/ele_common.c
>> b/drivers/firmware/imx/ele_common.c
>> > index b2be32550e9b..88169cd8f369 100644
>> > --- a/drivers/firmware/imx/ele_common.c
>> > +++ b/drivers/firmware/imx/ele_common.c
>> > @@ -78,6 +78,149 @@ int ele_msg_send_rcv(struct se_if_priv *priv, void
>> *tx_msg, void *rx_msg)
>> >       return err;
>> >    }
>> >
>> > +int ele_miscdev_msg_rcv(struct se_if_device_ctx *dev_ctx,
>> > +                     void *rx_buf,
>> > +                     int rx_buf_sz)
>> > +{
>> > +     struct se_msg_hdr *header;
>> > +     int err;
>> > +
>> > +     err = wait_event_interruptible(dev_ctx->wq, dev_ctx->pending_hdr != 0);
>> > +     if (err) {
>> > +             dev_err(dev_ctx->dev,
>> > +                     "%s: Err[0x%x]:Interrupted by signal.\n",
>> > +                     dev_ctx->miscdev.name, err);
>> > +             goto exit;
>> > +     }
>> > +
>> > +     header = (struct se_msg_hdr *) dev_ctx->temp_resp;
>> > +
>> > +     if (header->tag == dev_ctx->priv->rsp_tag) {
>> > +             if (dev_ctx->priv->waiting_rsp_dev && dev_ctx->priv-
>> >waiting_rsp_dev != dev_ctx) {
>> > +                     dev_warn(dev_ctx->dev,
>> > +                     "Dev-ctx waiting for response mismatch (%s != %s).\n",
>> > +                     dev_ctx->miscdev.name, dev_ctx->priv->waiting_rsp_dev-
>> >miscdev.name);
>> > +                     err = -EPERM;
>> > +                     goto exit;
>> > +             }
>> > +     }
>> > +
>> > +     dev_dbg(dev_ctx->dev,
>> > +             "%s: %s %s\n",
>> > +             dev_ctx->miscdev.name,
>> > +             __func__,
>> > +             "message received, start transmit to user");
>> > +
>> > +     /*
>> > +      * Check that the size passed as argument is larger than
>> > +      * the one carried in the message.
>> > +      *
>> > +      * In case of US-command/response, the dev_ctx->temp_resp_size
>> > +      * is set before sending the command.
>> > +      *
>> > +      * In case of NVM Slave-command/response, the dev_ctx-
>> >temp_resp_size
>> > +      * is set after receing the message from mailbox.
>> > +      */
>> > +     if (dev_ctx->temp_resp_size > rx_buf_sz) {
>> > +             dev_err(dev_ctx->dev,
>> > +                     "%s: User buffer too small (%d < %d)\n",
>> > +                     dev_ctx->miscdev.name,
>> > +                     rx_buf_sz, dev_ctx->temp_resp_size);
>> > +              dev_ctx->temp_resp_size = rx_buf_sz;
>> > +     }
>> > +
>> > +     /* We may need to copy the output data to user before
>> > +      * delivering the completion message.
>> > +      */
>> > +     err = se_dev_ctx_cpy_out_data(dev_ctx, true);
>> > +     if (err < 0)
>> > +             goto exit;
>> > +
>> > +     /* Copy data from the buffer */
>> > +     print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
>> > +                          dev_ctx->temp_resp, dev_ctx->temp_resp_size, false);
>> > +     if (copy_to_user(rx_buf, dev_ctx->temp_resp, dev_ctx-
>> >temp_resp_size)) {
>> > +             dev_err(dev_ctx->dev,
>> > +                     "%s: Failed to copy to user\n",
>> > +                     dev_ctx->miscdev.name);
>> > +             err = -EFAULT;
>> > +             goto exit;
>> > +     }
>> > +
>> > +     err = dev_ctx->temp_resp_size;
>> > +exit:
>> > +     if (err < 0)
>> > +             se_dev_ctx_cpy_out_data(dev_ctx, false);
>> > +
>> > +     /* free memory allocated on the shared buffers. */
>> > +     dev_ctx->secure_mem.pos = 0;
>> > +     dev_ctx->non_secure_mem.pos = 0;
>> > +
>> > +     dev_ctx->pending_hdr = 0;
>> > +     se_dev_ctx_shared_mem_cleanup(dev_ctx);
>> > +
>> > +     return err;
>> > +}
>> > +
>> > +int ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
>> > +                      void *tx_msg, int tx_msg_sz)
>> > +{
>> > +     struct se_if_priv *priv = dev_ctx->priv;
>> > +     struct se_msg_hdr *header;
>> > +     u32 size_to_send;
>> > +     int err;
>> > +
>> > +     header = (struct se_msg_hdr *) tx_msg;
>> > +
>> > +     /*
>> > +      * Check that the size passed as argument matches the size
>> > +      * carried in the message.
>> > +      */
>> > +     size_to_send = header->size << 2;
>> > +
>> > +     if (size_to_send != tx_msg_sz) {
>> > +             err = -EINVAL;
>> > +             dev_err(priv->dev,
>> > +                     "%s: User buf hdr(0x%x) sz mismatced with input-sz
>> (%d != %d).\n",
>> > +                     dev_ctx->miscdev.name, *(u32 *)header, size_to_send,
>> tx_msg_sz);
>> > +             goto exit;
>> > +     }
>> > +
>> > +     /* Check the message is valid according to tags */
>> > +     if (header->tag == priv->rsp_tag) {
>> > +             /* Check the device context can send the command */
>> > +             if (dev_ctx != priv->cmd_receiver_dev) {
>> > +                     dev_err(priv->dev,
>> > +                             "%s: Channel not configured to send resp to FW.",
>> > +                             dev_ctx->miscdev.name);
>> > +                     err = -EPERM;
>> > +                     goto exit;
>> > +             }
>> > +     } else if (header->tag == priv->cmd_tag) {
>> > +             if (priv->waiting_rsp_dev != dev_ctx) {
>> > +                     dev_err(priv->dev,
>> > +                             "%s: Channel not configured to send cmd to FW.",
>> > +                             dev_ctx->miscdev.name);
>> > +                     err = -EPERM;
>> > +                     goto exit;
>> > +             }
>> > +             lockdep_assert_held(&priv->se_if_cmd_lock);
>> 
>> nit: Placement of this call is bit unusual (or do have some reason to
>> it), it might be better to place it at the beginning of the function.
> 
> The command lock is taken only in the case of command-message. Hence it placed under check for command message.
I thought lockdep_assert_held was used to ensure that 
ele_miscdev_msg_send is called while holding a lock, but I'm still not 
clear on why it's placed here.
> 
>> 
>> > +     } else {
>> > +             dev_err(priv->dev,
>> > +                     "%s: The message does not have a valid TAG\n",
>> > +                     dev_ctx->miscdev.name);
>> > +             err = -EINVAL;
>> > +             goto exit;
>> > +     }
>> > +     err = ele_msg_send(priv, tx_msg);
>> > +     if (err < 0)
>> > +             goto exit;
>> > +
>> > +     err = size_to_send;
>> > +exit:
>> > +     return err;
>> > +}
>> > +
>> >    static bool exception_for_size(struct se_if_priv *priv,
>> >                               struct se_msg_hdr *header)
>> >    {
>> > @@ -99,6 +242,7 @@ static bool exception_for_size(struct se_if_priv *priv,
>> >    void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
>> >    {
>> >       struct device *dev = mbox_cl->dev;
>> > +     struct se_if_device_ctx *dev_ctx;
>> >       struct se_if_priv *priv;
>> >       struct se_msg_hdr *header;
>> >       u32 rx_msg_sz;
>> > @@ -114,8 +258,50 @@ void se_if_rx_callback(struct mbox_client
>> *mbox_cl, void *msg)
>> >       header = msg;
>> >       rx_msg_sz = header->size << 2;
>> >
>> > -     if (header->tag == priv->rsp_tag) {
>> > -             if (!priv->waiting_rsp_dev) {
>> > +     /* Incoming command: wake up the receiver if any. */
>> > +     if (header->tag == priv->cmd_tag) {
>> > +             dev_dbg(dev, "Selecting cmd receiver\n");
>> > +             dev_ctx = priv->cmd_receiver_dev;
>> > +             /* Pre-allocated buffer of MAX_NVM_MSG_LEN
>> > +              * as the NVM command are initiated by FW.
>> > +              * Size is revealed as part of this call function.
>> > +              */
>> > +             if (rx_msg_sz > MAX_NVM_MSG_LEN) {
>> > +                     dev_err(dev,
>> > +                             "%s: Msg recvd hdr(0x%x) with greater[%d] than allocated
>> buf-sz.\n",
>> > +                             dev_ctx->miscdev.name,
>> > +                             *(u32 *) header,
>> > +                             rx_msg_sz);
>> > +             } else
>> > +                     memcpy(dev_ctx->temp_resp, msg, rx_msg_sz);
>> > +
>> > +             /* NVM buffer size are not known prior receiving it from FW.
>> > +              */
>> > +             dev_ctx->temp_resp_size = rx_msg_sz;
>> > +
>> > +             /* Allow user to read */
>> > +             dev_ctx->pending_hdr = 1;
>> > +             wake_up_interruptible(&dev_ctx->wq);
>> > +
>> > +             return;
>> > +     } else if (header->tag == priv->rsp_tag) {
>> > +             if (priv->waiting_rsp_dev) {
>> > +                     dev_dbg(dev, "Selecting rsp waiter\n");
>> > +                     dev_ctx = priv->waiting_rsp_dev;
>> > +                     if (rx_msg_sz != dev_ctx->temp_resp_size
>> > +                             && !exception_for_size(priv, header))
>> > +                             dev_err(dev,
>> > +                                     "%s: Msg RSP hdr(0x%x) with different sz(%d != %d).\n",
>> > +                                     dev_ctx->miscdev.name,
>> > +                                     *(u32 *) header,
>> > +                                     rx_msg_sz, dev_ctx->temp_resp_size);
>> > +                     else
>> > +                             memcpy(dev_ctx->temp_resp, msg, rx_msg_sz);
>> > +
>> > +                     /* Allow user to read */
>> > +                     dev_ctx->pending_hdr = 1;
>> > +                     wake_up_interruptible(&dev_ctx->wq);
>> > +             } else {
>> >                       /*
>> >                        * Reading the EdgeLock Enclave response
>> >                        * to the command, sent by other
>> > @@ -132,8 +318,8 @@ void se_if_rx_callback(struct mbox_client *mbox_cl,
>> void *msg)
>> >
>> >                       complete(&priv->done);
>> >                       spin_unlock(&priv->lock);
>> > -                     return;
>> >               }
>> > +             return;
>> >       }
>> >
>> >       dev_err(dev, "Failed to select a device for message: %.8x\n",
>> > diff --git a/drivers/firmware/imx/ele_common.h
>> b/drivers/firmware/imx/ele_common.h
>> > index 5ef775a42ab3..7b1c6bfc138b 100644
>> > --- a/drivers/firmware/imx/ele_common.h
>> > +++ b/drivers/firmware/imx/ele_common.h
>> > @@ -17,6 +17,10 @@ uint32_t se_add_msg_crc(uint32_t *msg, uint32_t
>> msg_len);
>> >    int ele_msg_rcv(struct se_if_priv *priv);
>> >    int ele_msg_send(struct se_if_priv *priv, void *tx_msg);
>> >    int ele_msg_send_rcv(struct se_if_priv *priv, void *tx_msg, void *rx_msg);
>> > +int ele_miscdev_msg_rcv(struct se_if_device_ctx *dev_ctx,
>> > +                     void *rx_msg, int rx_msg_sz);
>> > +int ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
>> > +                      void *tx_msg, int tx_msg_sz);
>> >    void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg);
>> >    int se_val_rsp_hdr_n_status(struct se_if_priv *priv,
>> >                           struct se_msg_hdr *header,
>> > diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
>> > index a844794d2b39..8fb2af0f0dd3 100644
>> > --- a/drivers/firmware/imx/se_ctrl.c
>> > +++ b/drivers/firmware/imx/se_ctrl.c
>> > @@ -23,6 +23,7 @@
>> >    #include <linux/slab.h>
>> >    #include <linux/string.h>
>> >    #include <linux/sys_soc.h>
>> > +#include <uapi/linux/se_ioctl.h>
>> >
>> >    #include "ele_base_msg.h"
>> >    #include "ele_common.h"
>> > @@ -196,6 +197,608 @@ static int se_soc_info(struct se_if_priv *priv,
>> >       return 0;
>> >    }
>> >
>> > +static int se_ioctl_cmd_snd_rcv_rsp_handler(struct se_if_device_ctx
>> *dev_ctx,
>> > +                                         u64 arg)
>> > +{
>> > +     struct se_if_priv *priv = dev_get_drvdata(dev_ctx->dev);
>> > +     struct se_ioctl_cmd_snd_rcv_rsp_info cmd_snd_rcv_rsp_info;
>> > +     struct se_api_msg *tx_msg __free(kfree) = NULL;
>> > +     struct se_api_msg *rx_msg __free(kfree) = NULL;
>> > +     int err = 0;
>> > +
>> > +     if (copy_from_user(&cmd_snd_rcv_rsp_info, (u8 *)arg,
>> > +                        sizeof(cmd_snd_rcv_rsp_info))) {
>> > +             dev_err(dev_ctx->priv->dev,
>> > +                     "%s: Failed to copy cmd_snd_rcv_rsp_info from user\n",
>> > +                     dev_ctx->miscdev.name);
>> > +             err = -EFAULT;
>> > +             goto exit;
>> > +     }
>> > +
>> > +     if (cmd_snd_rcv_rsp_info.tx_buf_sz < SE_MU_HDR_SZ) {
>> > +             dev_err(dev_ctx->priv->dev,
>> > +                     "%s: User buffer too small(%d < %d)\n",
>> > +                     dev_ctx->miscdev.name,
>> > +                     cmd_snd_rcv_rsp_info.tx_buf_sz,
>> > +                     SE_MU_HDR_SZ);
>> > +             err = -ENOSPC;
>> > +             goto exit;
>> > +     }
>> > +
>> > +     rx_msg = kzalloc(cmd_snd_rcv_rsp_info.rx_buf_sz, GFP_KERNEL);
>> > +     if (!rx_msg) {
>> > +             err = -ENOMEM;
>> > +             goto exit;
>> > +     }
>> > +
>> > +     tx_msg = memdup_user(cmd_snd_rcv_rsp_info.tx_buf,
>> > +                          cmd_snd_rcv_rsp_info.tx_buf_sz);
>> > +     if (IS_ERR(tx_msg)) {
>> > +             err = PTR_ERR(tx_msg);
>> > +             goto exit;
>> > +     }
>> > +
>> > +     if (tx_msg->header.tag != priv->cmd_tag) {
>> > +             err = -EINVAL;
>> > +             goto exit;
>> > +     }
>> > +
>> > +     scoped_guard(mutex, &priv->se_if_cmd_lock);
>> > +     priv->waiting_rsp_dev = dev_ctx;
>> > +     dev_ctx->temp_resp_size = cmd_snd_rcv_rsp_info.rx_buf_sz;
>> > +
>> > +     /* Device Context that is assigned to be a
>> > +      * FW's command receiver, has pre-allocated buffer.
>> > +      */
>> > +     if (dev_ctx != priv->cmd_receiver_dev)
>> > +             dev_ctx->temp_resp = rx_msg;
>> > +
>> > +     err = ele_miscdev_msg_send(dev_ctx,
>> > +                                tx_msg,
>> > +                                cmd_snd_rcv_rsp_info.tx_buf_sz);
>> > +     if (err < 0)
>> > +             goto exit;
>> > +
>> > +     cmd_snd_rcv_rsp_info.tx_buf_sz = err;
>> > +
>> > +     err = ele_miscdev_msg_rcv(dev_ctx,
>> > +                               cmd_snd_rcv_rsp_info.rx_buf,
>> > +                               cmd_snd_rcv_rsp_info.rx_buf_sz);
>> > +
>> > +     if (err < 0)
>> > +             goto exit;
>> > +
>> > +     cmd_snd_rcv_rsp_info.rx_buf_sz = err;
>> > +
>> > +exit:
>> > +     dev_ctx->temp_resp_size = 0;
>> > +     priv->waiting_rsp_dev = NULL;
>> > +     if (dev_ctx != priv->cmd_receiver_dev)
>> > +             dev_ctx->temp_resp = NULL;
>> > +
>> > +     if (copy_to_user((void *)arg, &cmd_snd_rcv_rsp_info,
>> > +                      sizeof(cmd_snd_rcv_rsp_info))) {
>> > +             dev_err(dev_ctx->priv->dev,
>> > +                     "%s: Failed to copy cmd_snd_rcv_rsp_info from user\n",
>> > +                     dev_ctx->miscdev.name);
>> > +             err = -EFAULT;
>> > +     }
>> > +     return err;
>> > +}
>> > +
>> > +/*
>> > + * File operations for user-space
>> > + */
>> > +
>> > +/* Write a message to the MU. */
>> > +static ssize_t se_if_fops_write(struct file *fp, const char __user *buf,
>> > +                             size_t size, loff_t *ppos)
>> > +{
>> > +     struct se_api_msg *tx_msg __free(kfree) = NULL;
>> > +     struct se_if_device_ctx *dev_ctx;
>> > +     struct se_if_priv *priv;
>> > +     int err;
>> > +
>> > +     dev_ctx = container_of(fp->private_data,
>> > +                            struct se_if_device_ctx,
>> > +                            miscdev);
>> > +     priv = dev_ctx->priv;
>> > +     dev_dbg(priv->dev,
>> > +             "%s: write from buf (%p)%zu, ppos=%lld\n",
>> > +                     dev_ctx->miscdev.name,
>> > +                     buf, size, ((ppos) ? *ppos : 0));
>> > +
>> > +     if (down_interruptible(&dev_ctx->fops_lock))
>> > +             return -EBUSY;
>> > +
>> > +     if (dev_ctx->status != SE_IF_CTX_OPENED) {
>> > +             err = -EINVAL;
>> > +             goto exit;
>> > +     }
>> > +
>> > +     if (size < SE_MU_HDR_SZ) {
>> > +             dev_err(priv->dev,
>> > +                     "%s: User buffer too small(%zu < %d)\n",
>> > +                             dev_ctx->miscdev.name,
>> > +                             size, SE_MU_HDR_SZ);
>> > +             err = -ENOSPC;
>> > +             goto exit;
>> > +     }
>> > +     tx_msg = memdup_user(buf, size);
>> > +     if (IS_ERR(tx_msg)) {
>> > +             err = PTR_ERR(tx_msg);
>> > +             goto exit;
>> > +     }
>> > +
>> > +     print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
>> > +                          tx_msg, size, false);
>> > +
>> > +     err = ele_miscdev_msg_send(dev_ctx, tx_msg, size);
>> > +
>> > +exit:
>> > +     up(&dev_ctx->fops_lock);
>> > +     return err;
>> > +}
>> > +
>> > +/*
>> > + * Read a message from the MU.
>> > + * Blocking until a message is available.
>> > + */
>> > +static ssize_t se_if_fops_read(struct file *fp, char __user *buf,
>> > +                            size_t size, loff_t *ppos)
>> > +{
>> > +     struct se_if_device_ctx *dev_ctx;
>> > +     struct se_if_priv *priv;
>> > +     int err;
>> > +
>> > +     dev_ctx = container_of(fp->private_data,
>> > +                            struct se_if_device_ctx,
>> > +                            miscdev);
>> > +     priv = dev_ctx->priv;
>> > +     dev_dbg(priv->dev,
>> > +             "%s: read to buf %p(%zu), ppos=%lld\n",
>> > +                     dev_ctx->miscdev.name,
>> > +                     buf, size, ((ppos) ? *ppos : 0));
>> > +
>> > +     if (down_interruptible(&dev_ctx->fops_lock))
>> > +             return -EBUSY;
>> > +
>> > +     if (dev_ctx->status != SE_IF_CTX_OPENED) {
>> > +             err = -EINVAL;
>> > +             goto exit;
>> > +     }
>> > +
>> > +     err = ele_miscdev_msg_rcv(dev_ctx, buf, size);
>> > +
>> > +exit:
>> > +     up(&dev_ctx->fops_lock);
>> > +     return err;
>> > +}
>> > +
>> > +static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
>> > +                             u64 arg)
>> > +{
>> > +     struct se_if_priv *priv = dev_get_drvdata(dev_ctx->dev);
>> > +     struct se_if_node_info *if_node_info;
>> > +     struct se_ioctl_get_if_info info;
>> > +     int err = 0;
>> > +
>> > +     if_node_info = (struct se_if_node_info *)priv->info;
>> > +
>> > +     info.se_if_id = if_node_info->se_if_id;
>> > +     info.interrupt_idx = 0;
>> > +     info.tz = 0;
>> > +     info.did = if_node_info->se_if_did;
>> > +     info.cmd_tag = if_node_info->cmd_tag;
>> > +     info.rsp_tag = if_node_info->rsp_tag;
>> > +     info.success_tag = if_node_info->success_tag;
>> > +     info.base_api_ver = if_node_info->base_api_ver;
>> > +     info.fw_api_ver = if_node_info->fw_api_ver;
>> > +
>> > +     dev_dbg(priv->dev,
>> > +             "%s: info [se_if_id: %d, irq_idx: %d, tz: 0x%x, did: 0x%x]\n",
>> > +                     dev_ctx->miscdev.name,
>> > +                     info.se_if_id, info.interrupt_idx, info.tz, info.did);
>> > +
>> > +     if (copy_to_user((u8 *)arg, &info, sizeof(info))) {
>> > +             dev_err(dev_ctx->priv->dev,
>> > +                     "%s: Failed to copy mu info to user\n",
>> > +                             dev_ctx->miscdev.name);
>> > +             err = -EFAULT;
>> > +             goto exit;
>> > +     }
>> > +
>> > +exit:
>> > +     return err;
>> > +}
>> > +
>> > +/* Need to copy the output data to user-device context.
>> > + */
>> > +int se_dev_ctx_cpy_out_data(struct se_if_device_ctx *dev_ctx, bool
>> do_cpy)
>> > +{
>> > +     struct se_buf_desc *b_desc, *temp;
>> > +
>> > +     list_for_each_entry_safe(b_desc, temp, &dev_ctx->pending_out, link) {
>> > +             if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr && do_cpy) {
>> > +
>> > +                     dev_dbg(dev_ctx->dev,
>> > +                             "%s: Copy output data to user\n",
>> > +                             dev_ctx->miscdev.name);
>> > +                     if (copy_to_user(b_desc->usr_buf_ptr,
>> > +                                      b_desc->shared_buf_ptr,
>> > +                                      b_desc->size)) {
>> > +                             dev_err(dev_ctx->dev,
>> > +                                     "%s: Failure copying output data to user.",
>> > +                                     dev_ctx->miscdev.name);
>> > +                             return -EFAULT;
>> > +                     }
>> > +             }
>> > +
>> > +             if (b_desc->shared_buf_ptr)
>> > +                     memset(b_desc->shared_buf_ptr, 0, b_desc->size);
>> > +
>> > +             list_del(&b_desc->link);
>> > +             kfree(b_desc);
>> > +     }
>> > +     return 0;
>> > +}
>> > +
>> > +/*
>> > + * Clean the used Shared Memory space,
>> > + * whether its Input Data copied from user buffers, or
>> > + * Data received from FW.
>> > + */
>> > +void se_dev_ctx_shared_mem_cleanup(struct se_if_device_ctx *dev_ctx)
>> > +{
>> > +     struct list_head *dev_ctx_lists[] = {&dev_ctx->pending_in,
>> > +                                              &dev_ctx->pending_out};
>> > +     struct se_buf_desc *b_desc, *temp;
>> > +     int i;
>> > +
>> > +     for (i = 0; i < 2; i++) {
>> > +             list_for_each_entry_safe(b_desc, temp,
>> > +                                      dev_ctx_lists[i], link) {
>> > +
>> > +                     if (b_desc->shared_buf_ptr)
>> > +                             memset(b_desc->shared_buf_ptr, 0, b_desc->size);
>> > +
>> > +                     list_del(&b_desc->link);
>> > +                     kfree(b_desc);
>> > +             }
>> > +     }
>> > +}
>> > +
>> > +/*
>> > + * Copy a buffer of data to/from the user and return the address to use in
>> > + * messages
>> > + */
>> > +static int se_ioctl_setup_iobuf_handler(struct se_if_device_ctx *dev_ctx,
>> > +                                         u64 arg)
>> > +{
>> > +     struct se_shared_mem *shared_mem = NULL;
>> > +     struct se_ioctl_setup_iobuf io = {0};
>> > +     struct se_buf_desc *b_desc = NULL;
>> > +     int err = 0;
>> > +     u32 pos;
>> > +
>> > +     if (copy_from_user(&io, (u8 *)arg, sizeof(io))) {
>> > +             dev_err(dev_ctx->priv->dev,
>> > +                     "%s: Failed copy iobuf config from user\n",
>> > +                             dev_ctx->miscdev.name);
>> > +             err = -EFAULT;
>> > +             goto exit;
>> > +     }
>> > +
>> > +     dev_dbg(dev_ctx->priv->dev,
>> > +                     "%s: io [buf: %p(%d) flag: %x]\n",
>> > +                     dev_ctx->miscdev.name,
>> > +                     io.user_buf, io.length, io.flags);
>> > +
>> > +     if (io.length == 0 || !io.user_buf) {
>> > +             /*
>> > +              * Accept NULL pointers since some buffers are optional
>> > +              * in FW commands. In this case we should return 0 as
>> > +              * pointer to be embedded into the message.
>> > +              * Skip all data copy part of code below.
>> > +              */
>> > +             io.ele_addr = 0;
>> > +             goto copy;
>> > +     }
>> > +
>> > +     /* Select the shared memory to be used for this buffer. */
>> > +     if (io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) {
>> > +             /* App requires to use secure memory for this buffer.*/
>> > +             dev_err(dev_ctx->priv->dev,
>> > +                     "%s: Failed allocate SEC MEM memory\n",
>> > +                             dev_ctx->miscdev.name);
>> > +             err = -EFAULT;
>> > +             goto exit;
>> > +     } else {
>> > +             /* No specific requirement for this buffer. */
>> > +             shared_mem = &dev_ctx->non_secure_mem;
>> > +     }
>> > +
>> > +     /* Check there is enough space in the shared memory. */
>> > +     if (shared_mem->size < shared_mem->pos ||
>> > +             round_up(io.length, 8u) >= (shared_mem->size - shared_mem-
>> >pos)) {
>> > +             dev_err(dev_ctx->priv->dev,
>> > +                     "%s: Not enough space in shared memory\n",
>> > +                             dev_ctx->miscdev.name);
>> > +             err = -ENOMEM;
>> > +             goto exit;
>> > +     }
>> > +
>> > +     /* Allocate space in shared memory. 8 bytes aligned. */
>> > +     pos = shared_mem->pos;
>> > +     shared_mem->pos += round_up(io.length, 8u);
>> > +     io.ele_addr = (u64)shared_mem->dma_addr + pos;
>> > +
>> > +     if ((io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) &&
>> > +         !(io.flags & SE_MU_IO_FLAGS_USE_SHORT_ADDR)) {
>> > +             /*Add base address to get full address.*/
>> > +             dev_err(dev_ctx->priv->dev,
>> > +                     "%s: Failed allocate SEC MEM memory\n",
>> > +                             dev_ctx->miscdev.name);
>> > +             err = -EFAULT;
>> > +             goto exit;
>> > +     }
>> > +
>> > +     memset(shared_mem->ptr + pos, 0, io.length);
>> > +     if ((io.flags & SE_IO_BUF_FLAGS_IS_INPUT) ||
>> > +         (io.flags & SE_IO_BUF_FLAGS_IS_IN_OUT)) {
>> > +             /*
>> > +              * buffer is input:
>> > +              * copy data from user space to this allocated buffer.
>> > +              */
>> > +             if (copy_from_user(shared_mem->ptr + pos, io.user_buf,
>> > +                                io.length)) {
>> > +                     dev_err(dev_ctx->priv->dev,
>> > +                             "%s: Failed copy data to shared memory\n",
>> > +                             dev_ctx->miscdev.name);
>> > +                     err = -EFAULT;
>> > +                     goto exit;
>> > +             }
>> > +     }
>> > +
>> > +     b_desc = kzalloc(sizeof(*b_desc), GFP_KERNEL);
>> > +     if (!b_desc) {
>> > +             err = -ENOMEM;
>> > +             goto exit;
>> > +     }
>> > +
>> > +copy:
>> > +     /* Provide the EdgeLock Enclave address to user space only if success.*/
>> > +     if (copy_to_user((u8 *)arg, &io, sizeof(io))) {
>> > +             dev_err(dev_ctx->priv->dev,
>> > +                     "%s: Failed to copy iobuff setup to user\n",
>> > +                             dev_ctx->miscdev.name);
>> > +             kfree(b_desc);
>> > +             err = -EFAULT;
>> > +             goto exit;
>> > +     }
>> > +
>> > +     if (b_desc) {
>> > +             b_desc->shared_buf_ptr = shared_mem->ptr + pos;
>> > +             b_desc->usr_buf_ptr = io.user_buf;
>> > +             b_desc->size = io.length;
>> > +
>> > +             if (io.flags & SE_IO_BUF_FLAGS_IS_INPUT) {
>> > +                     /*
>> > +                      * buffer is input:
>> > +                      * add an entry in the "pending input buffers" list so
>> > +                      * that copied data can be cleaned from shared memory
>> > +                      * later.
>> > +                      */
>> > +                     list_add_tail(&b_desc->link, &dev_ctx->pending_in);
>> > +             } else {
>> > +                     /*
>> > +                      * buffer is output:
>> > +                      * add an entry in the "pending out buffers" list so data
>> > +                      * can be copied to user space when receiving Secure-Enclave
>> > +                      * response.
>> > +                      */
>> > +                     list_add_tail(&b_desc->link, &dev_ctx->pending_out);
>> > +             }
>> > +     }
>> > +
>> > +exit:
>> > +     return err;
>> > +}
>> > +
>> > +/* IOCTL to provide SoC information */
>> > +static int se_ioctl_get_se_soc_info_handler(struct se_if_device_ctx
>> *dev_ctx,
>> > +                                          u64 arg)
>> > +{
>> > +     const struct se_if_node_info_list *info_list;
>> > +     struct se_ioctl_get_soc_info soc_info;
>> > +     int err = -EINVAL;
>> > +
>> > +     info_list = device_get_match_data(dev_ctx->priv->dev);
>> > +     if (!info_list)
>> > +             goto exit;
>> > +
>> > +     soc_info.soc_id = info_list->soc_id;
>> > +     soc_info.soc_rev = dev_ctx->priv->soc_rev;
>> > +
>> > +     err = (int)copy_to_user((u8 *)arg, (u8 *)(&soc_info), sizeof(soc_info));
>> > +     if (err) {
>> > +             dev_err(dev_ctx->priv->dev,
>> > +                     "%s: Failed to copy soc info to user\n",
>> > +                     dev_ctx->miscdev.name);
>> > +             err = -EFAULT;
>> > +             goto exit;
>> > +     }
>> > +
>> > +exit:
>> > +     return err;
>> > +}
>> > +
>> > +/* Open a character device. */
>> > +static int se_if_fops_open(struct inode *nd, struct file *fp)
>> > +{
>> > +     struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
>> > +                                                     struct se_if_device_ctx,
>> > +                                                     miscdev);
>> > +     int err = 0;
>> > +
>> > +     /* Avoid race if opened at the same time */
>> > +     if (down_trylock(&dev_ctx->fops_lock))
>> > +             return -EBUSY;
>> > +
>> > +     /* Authorize only 1 instance. */
>> > +     if (dev_ctx->status != SE_IF_CTX_FREE) {
>> > +             err = -EBUSY;
>> > +             goto exit;
>> > +     }
>> > +
>> > +     /*
>> > +      * Allocate some memory for data exchanges with S40x.
>> > +      * This will be used for data not requiring secure memory.
>> > +      */
>> > +     dev_ctx->non_secure_mem.ptr = dmam_alloc_coherent(dev_ctx->dev,
>> > +                                     MAX_DATA_SIZE_PER_USER,
>> > +                                     &dev_ctx->non_secure_mem.dma_addr,
>> > +                                     GFP_KERNEL);
>> > +     if (!dev_ctx->non_secure_mem.ptr) {
>> > +             err = -ENOMEM;
>> > +             goto exit;
>> > +     }
>> > +
>> > +     dev_ctx->non_secure_mem.size = MAX_DATA_SIZE_PER_USER;
>> > +     dev_ctx->non_secure_mem.pos = 0;
>> > +     dev_ctx->status = SE_IF_CTX_OPENED;
>> > +
>> > +     dev_ctx->pending_hdr = 0;
>> > +
>> > +     goto exit;
>> > +
>> > +     dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
>> > +                        dev_ctx->non_secure_mem.ptr,
>> > +                        dev_ctx->non_secure_mem.dma_addr);
>> > +
>> > +exit:
>> > +     up(&dev_ctx->fops_lock);
>> > +     return err;
>> > +}
>> > +
>> > +/* Close a character device. */
>> > +static int se_if_fops_close(struct inode *nd, struct file *fp)
>> > +{
>> > +     struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
>> > +                                                     struct se_if_device_ctx,
>> > +                                                     miscdev);
>> > +     struct se_if_priv *priv = dev_ctx->priv;
>> > +
>> > +     /* Avoid race if closed at the same time */
>> > +     if (down_trylock(&dev_ctx->fops_lock))
>> > +             return -EBUSY;
>> > +
>> > +     /* The device context has not been opened */
>> > +     if (dev_ctx->status != SE_IF_CTX_OPENED)
>> > +             goto exit;
>> > +
>> > +     /* check if this device was registered as command receiver. */
>> > +     if (priv->cmd_receiver_dev == dev_ctx) {
>> > +             priv->cmd_receiver_dev = NULL;
>> > +             kfree(dev_ctx->temp_resp);
>> > +     }
>> > +
>> > +     /* check if this device was registered as waiting response. */
>> > +     if (priv->waiting_rsp_dev == dev_ctx) {
>> > +             priv->waiting_rsp_dev = NULL;
>> > +             mutex_unlock(&priv->se_if_cmd_lock);
>> > +     }
>> > +
>> > +     /* Unmap secure memory shared buffer. */
>> > +     if (dev_ctx->secure_mem.ptr)
>> > +             devm_iounmap(dev_ctx->dev, dev_ctx->secure_mem.ptr);
>> > +
>> > +     dev_ctx->secure_mem.ptr = NULL;
>> > +     dev_ctx->secure_mem.dma_addr = 0;
>> > +     dev_ctx->secure_mem.size = 0;
>> > +     dev_ctx->secure_mem.pos = 0;
>> > +
>> > +     /* Free non-secure shared buffer. */
>> > +     dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
>> > +                        dev_ctx->non_secure_mem.ptr,
>> > +                        dev_ctx->non_secure_mem.dma_addr);
>> > +
>> > +     dev_ctx->non_secure_mem.ptr = NULL;
>> > +     dev_ctx->non_secure_mem.dma_addr = 0;
>> > +     dev_ctx->non_secure_mem.size = 0;
>> > +     dev_ctx->non_secure_mem.pos = 0;
>> > +     se_dev_ctx_shared_mem_cleanup(dev_ctx);
>> > +     dev_ctx->status = SE_IF_CTX_FREE;
>> > +
>> > +exit:
>> > +     up(&dev_ctx->fops_lock);
>> > +     return 0;
>> > +}
>> > +
>> > +/* IOCTL entry point of a character device */
>> > +static long se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
>> > +{
>> > +     struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
>> > +                                                     struct se_if_device_ctx,
>> > +                                                     miscdev);
>> > +     struct se_if_priv *se_if_priv = dev_ctx->priv;
>> > +     int err = -EINVAL;
>> > +
>> > +     /* Prevent race during change of device context */
>> > +     if (down_interruptible(&dev_ctx->fops_lock))
>> > +             return -EBUSY;
>> > +
>> > +     switch (cmd) {
>> > +     case SE_IOCTL_ENABLE_CMD_RCV:
>> > +             if (!se_if_priv->cmd_receiver_dev) {
>> > +                     err = 0;
>> > +                     se_if_priv->cmd_receiver_dev = dev_ctx;
>> > +                     dev_ctx->temp_resp = kzalloc(MAX_NVM_MSG_LEN,
>> GFP_KERNEL);
>> > +                     if (!dev_ctx->temp_resp)
>> > +                             err = -ENOMEM;
>> > +             }
>> > +             break;
>> > +     case SE_IOCTL_GET_MU_INFO:
>> > +             err = se_ioctl_get_mu_info(dev_ctx, arg);
>> > +             break;
>> > +     case SE_IOCTL_SETUP_IOBUF:
>> > +             err = se_ioctl_setup_iobuf_handler(dev_ctx, arg);
>> > +             break;
>> > +     case SE_IOCTL_GET_SOC_INFO:
>> > +             err = se_ioctl_get_se_soc_info_handler(dev_ctx, arg);
>> > +             break;
>> > +     case SE_IOCTL_CMD_SEND_RCV_RSP:
>> > +             err = se_ioctl_cmd_snd_rcv_rsp_handler(dev_ctx, arg);
>> > +             break;
>> > +
>> > +     default:
>> > +             err = -EINVAL;
>> > +             dev_dbg(se_if_priv->dev,
>> > +                     "%s: IOCTL %.8x not supported\n",
>> > +                             dev_ctx->miscdev.name,
>> > +                             cmd);
>> > +     }
>> > +
>> > +     up(&dev_ctx->fops_lock);
>> > +     return (long)err;
>> > +}
>> > +
>> > +/* Char driver setup */
>> > +static const struct file_operations se_if_fops = {
>> > +     .open           = se_if_fops_open,
>> > +     .owner          = THIS_MODULE,
>> > +     .release        = se_if_fops_close,
>> > +     .unlocked_ioctl = se_ioctl,
>> > +     .read           = se_if_fops_read,
>> > +     .write          = se_if_fops_write,
>> > +};
>> > +
>> > +/* interface for managed res to unregister a character device */
>> > +static void if_misc_deregister(void *miscdevice)
>> > +{
>> > +     misc_deregister(miscdevice);
>> > +}
>> > +
>> >    /* interface for managed res to free a mailbox channel */
>> >    static void if_mbox_free_channel(void *mbox_chan)
>> >    {
>> > @@ -233,6 +836,7 @@ static void se_if_probe_cleanup(struct
>> platform_device *pdev)
>> >    {
>> >       struct device *dev = &pdev->dev;
>> >       struct se_if_priv *priv;
>> > +     int i;
>> >
>> >       priv = dev_get_drvdata(dev);
>> >
>> > @@ -252,6 +856,17 @@ static void se_if_probe_cleanup(struct
>> platform_device *pdev)
>> >               priv->imem.buf = NULL;
>> >       }
>> >
>> > +     if (priv->ctxs) {
>> > +             for (i = 0; i < priv->max_dev_ctx; i++) {
>> > +                     if (priv->ctxs[i]) {
>> > +                             devm_remove_action(dev,
>> > +                                                if_misc_deregister,
>> > +                                                &priv->ctxs[i]->miscdev);
>> > +                             misc_deregister(&priv->ctxs[i]->miscdev);
>> > +                     }
>> > +             }
>> > +     }
>> > +
>> >       /* No need to check, if reserved memory is allocated
>> >        * before calling for its release. Or clearing the
>> >        * un-set bit.
>> > @@ -259,6 +874,74 @@ static void se_if_probe_cleanup(struct
>> platform_device *pdev)
>> >       of_reserved_mem_device_release(dev);
>> >    }
>> >
>> > +static int init_device_context(struct se_if_priv *priv)
>> > +{
>> > +     const struct se_if_node_info *info = priv->info;
>> > +     struct se_if_device_ctx *dev_ctx;
>> > +     u8 *devname;
>> > +     int ret = 0;
>> > +     int i;
>> > +
>> > +     priv->ctxs = devm_kzalloc(priv->dev, sizeof(dev_ctx) * priv-
>> >max_dev_ctx,
>> > +                               GFP_KERNEL);
>> > +
>> > +     if (!priv->ctxs) {
>> > +             ret = -ENOMEM;
>> > +             return ret;
>> > +     }
>> > +
>> > +     /* Create users */
>> > +     for (i = 0; i < priv->max_dev_ctx; i++) {
>> > +             dev_ctx = devm_kzalloc(priv->dev, sizeof(*dev_ctx), GFP_KERNEL);
>> > +             if (!dev_ctx) {
>> > +                     ret = -ENOMEM;
>> > +                     return ret;
>> > +             }
>> > +
>> > +             dev_ctx->dev = priv->dev;
>> > +             dev_ctx->status = SE_IF_CTX_FREE;
>> > +             dev_ctx->priv = priv;
>> > +
>> > +             priv->ctxs[i] = dev_ctx;
>> > +
>> > +             /* Default value invalid for an header. */
>> > +             init_waitqueue_head(&dev_ctx->wq);
>> > +
>> > +             INIT_LIST_HEAD(&dev_ctx->pending_out);
>> > +             INIT_LIST_HEAD(&dev_ctx->pending_in);
>> > +             sema_init(&dev_ctx->fops_lock, 1);
>> > +
>> > +             devname = devm_kasprintf(priv->dev, GFP_KERNEL, "%s_ch%d",
>> > +                                      info->se_name, i);
>> > +             if (!devname) {
>> > +                     ret = -ENOMEM;
>> > +                     return ret;
>> > +             }
>> > +
>> > +             dev_ctx->miscdev.name = devname;
>> > +             dev_ctx->miscdev.minor = MISC_DYNAMIC_MINOR;
>> > +             dev_ctx->miscdev.fops = &se_if_fops;
>> > +             dev_ctx->miscdev.parent = priv->dev;
>> > +             ret = misc_register(&dev_ctx->miscdev);
>> > +             if (ret) {
>> > +                     dev_err(priv->dev, "failed to register misc device %d\n",
>> > +                             ret);
>> > +                     return ret;
>> > +             }
>> > +
>> > +             ret = devm_add_action(priv->dev, if_misc_deregister,
>> > +                                   &dev_ctx->miscdev);
>> > +             if (ret) {
>> > +                     dev_err(priv->dev,
>> > +                             "failed[%d] to add action to the misc-dev\n",
>> > +                             ret);
>> > +                     return ret;
>> > +             }
>> > +     }
>> > +
>> > +     return ret;
>> > +}
>> > +
>> >    static void se_load_firmware(const struct firmware *fw, void *context)
>> >    {
>> >       struct se_if_priv *priv = (struct se_if_priv *) context;
>> > @@ -427,6 +1110,16 @@ static int se_if_probe(struct platform_device
>> *pdev)
>> >               ret = 0;
>> >       }
>> >
>> > +     if (info->max_dev_ctx) {
>> > +             ret = init_device_context(priv);
>> > +             if (ret) {
>> > +                     dev_err(dev,
>> > +                             "Failed[0x%x] to create device contexts.\n",
>> > +                             ret);
>> > +                     goto exit;
>> > +             }
>> > +     }
>> > +
>> >       dev_info(dev, "i.MX secure-enclave: %s interface to firmware,
>> configured.\n",
>> >                info->se_name);
>> >       return ret;
>> > @@ -467,6 +1160,10 @@ static int se_resume(struct device *dev)
>> >    {
>> >       struct se_if_priv *priv = dev_get_drvdata(dev);
>> >       const struct se_if_node_info *info = priv->info;
>> > +     int i;
>> > +
>> > +     for (i = 0; i < priv->max_dev_ctx; i++)
>> > +             wake_up_interruptible(&priv->ctxs[i]->wq);
>> >
>> >       if (info && info->imem_mgmt)
>> >               se_restore_imem_state(priv);
>> > diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
>> > index 4be2235d2170..b49346372746 100644
>> > --- a/drivers/firmware/imx/se_ctrl.h
>> > +++ b/drivers/firmware/imx/se_ctrl.h
>> > @@ -13,15 +13,62 @@
>> >    #define MAX_FW_LOAD_RETRIES                50
>> >
>> >    #define RES_STATUS(x)                      FIELD_GET(0x000000ff, x)
>> > +#define MAX_DATA_SIZE_PER_USER               (65 * 1024)
>> > +#define MAX_NVM_MSG_LEN                      (256)
>> >    #define MESSAGING_VERSION_6                0x6
>> >    #define MESSAGING_VERSION_7                0x7
>> >
>> > +#define SE_MU_IO_FLAGS_USE_SEC_MEM   (0x02u)
>> > +#define SE_MU_IO_FLAGS_USE_SHORT_ADDR        (0x04u)
>> > +
>> >    struct se_imem_buf {
>> >       u8 *buf;
>> >       phys_addr_t phyaddr;
>> >       u32 size;
>> >    };
>> >
>> > +struct se_buf_desc {
>> > +     u8 *shared_buf_ptr;
>> > +     u8 *usr_buf_ptr;
>> > +     u32 size;
>> > +     struct list_head link;
>> > +};
>> > +
>> > +/* Status of a char device */
>> > +enum se_if_dev_ctx_status_t {
>> > +     SE_IF_CTX_FREE,
>> > +     SE_IF_CTX_OPENED
>> > +};
>> > +
>> > +struct se_shared_mem {
>> > +     dma_addr_t dma_addr;
>> > +     u32 size;
>> > +     u32 pos;
>> > +     u8 *ptr;
>> > +};
>> > +
>> > +/* Private struct for each char device instance. */
>> > +struct se_if_device_ctx {
>> > +     struct device *dev;
>> > +     struct se_if_priv *priv;
>> > +     struct miscdevice miscdev;
>> > +
>> > +     enum se_if_dev_ctx_status_t status;
>> > +     wait_queue_head_t wq;
>> > +     struct semaphore fops_lock;
>> > +
>> > +     u32 pending_hdr;
>> > +     struct list_head pending_in;
>> > +     struct list_head pending_out;
>> > +
>> > +     struct se_shared_mem secure_mem;
>> > +     struct se_shared_mem non_secure_mem;
>> > +
>> > +     struct se_api_msg *temp_resp;
>> > +     u32 temp_resp_size;
>> > +     struct notifier_block se_notify;
>> > +};
>> > +
>> >    /* Header of the messages exchange with the EdgeLock Enclave */
>> >    struct se_msg_hdr {
>> >       u8 ver;
>> > @@ -80,4 +127,6 @@ struct se_if_priv {
>> >       struct se_imem_buf imem;
>> >    };
>> >
>> > +int se_dev_ctx_cpy_out_data(struct se_if_device_ctx *dev_ctx, bool
>> do_cpy);
>> > +void se_dev_ctx_shared_mem_cleanup(struct se_if_device_ctx *dev_ctx);
>> >    #endif
>> > diff --git a/include/uapi/linux/se_ioctl.h b/include/uapi/linux/se_ioctl.h
>> > new file mode 100644
>> > index 000000000000..c2d0a92ef626
>> > --- /dev/null
>> > +++ b/include/uapi/linux/se_ioctl.h
>> > @@ -0,0 +1,94 @@
>> > +/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-
>> Clause*/
>> > +/*
>> > + * Copyright 2024 NXP
>> > + */
>> > +
>> > +#ifndef SE_IOCTL_H
>> > +#define SE_IOCTL_H
>> > +
>> > +/* IOCTL definitions. */
>> > +
>> > +struct se_ioctl_setup_iobuf {
>> > +     u8 *user_buf;
>> > +     u32 length;
>> > +     u32 flags;
>> > +     u64 ele_addr;
>> > +};
>> > +
>> > +struct se_ioctl_shared_mem_cfg {
>> > +     u32 base_offset;
>> > +     u32 size;
>> > +};
>> > +
>> > +struct se_ioctl_get_if_info {
>> > +     u8 se_if_id;
>> > +     u8 interrupt_idx;
>> > +     u8 tz;
>> > +     u8 did;
>> > +     u8 cmd_tag;
>> > +     u8 rsp_tag;
>> > +     u8 success_tag;
>> > +     u8 base_api_ver;
>> > +     u8 fw_api_ver;
>> > +};
>> > +
>> > +struct se_ioctl_cmd_snd_rcv_rsp_info {
>> > +     u32 *tx_buf;
>> > +     int tx_buf_sz;
>> > +     u32 *rx_buf;
>> > +     int rx_buf_sz;
>> > +};
>> > +
>> > +struct se_ioctl_get_soc_info {
>> > +     u16 soc_id;
>> > +     u16 soc_rev;
>> > +};
>> > +
>> > +/* IO Buffer Flags */
>> > +#define SE_IO_BUF_FLAGS_IS_OUTPUT    (0x00u)
>> > +#define SE_IO_BUF_FLAGS_IS_INPUT     (0x01u)
>> > +#define SE_IO_BUF_FLAGS_USE_SEC_MEM  (0x02u)
>> > +#define SE_IO_BUF_FLAGS_USE_SHORT_ADDR       (0x04u)
>> > +#define SE_IO_BUF_FLAGS_IS_IN_OUT    (0x10u)
>> > +
>> > +/* IOCTLS */
>> > +#define SE_IOCTL                     0x0A /* like MISC_MAJOR. */
>> > +
>> > +/*
>> > + * ioctl to designated the current fd as logical-reciever.
>> > + * This is ioctl is send when the nvm-daemon, a slave to the
>> > + * firmware is started by the user.
>> > + */
>> > +#define SE_IOCTL_ENABLE_CMD_RCV      _IO(SE_IOCTL, 0x01)
>> > +
>> > +/*
>> > + * ioctl to get the buffer allocated from the memory, which is shared
>> > + * between kernel and FW.
>> > + * Post allocation, the kernel tagged the allocated memory with:
>> > + *  Output
>> > + *  Input
>> > + *  Input-Output
>> > + *  Short address
>> > + *  Secure-memory
>> > + */
>> > +#define SE_IOCTL_SETUP_IOBUF _IOWR(SE_IOCTL, 0x03, \
>> > +                                     struct se_ioctl_setup_iobuf)
>> > +
>> > +/*
>> > + * ioctl to get the mu information, that is used to exchange message
>> > + * with FW, from user-spaced.
>> > + */
>> > +#define SE_IOCTL_GET_MU_INFO _IOR(SE_IOCTL, 0x04, \
>> > +                                     struct se_ioctl_get_if_info)
>> > +/*
>> > + * ioctl to get SoC Info from user-space.
>> > + */
>> > +#define SE_IOCTL_GET_SOC_INFO      _IOR(SE_IOCTL, 0x06, \
>> > +                                     struct se_ioctl_get_soc_info)
>> > +
>> > +/*
>> > + * ioctl to send command and receive response from user-space.
>> > + */
>> > +#define SE_IOCTL_CMD_SEND_RCV_RSP _IOWR(SE_IOCTL, 0x07, \
>> > +                                     struct se_ioctl_cmd_snd_rcv_rsp_info)
>> > +#endif
>> >
>> > --
>> > 2.34.1
>> >
>> >
> 


