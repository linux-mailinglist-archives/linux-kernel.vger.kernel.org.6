Return-Path: <linux-kernel+bounces-186223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732348CC145
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7AE2B24809
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB5A13D886;
	Wed, 22 May 2024 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GXqNTD3H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jz6YnKHE"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0188A13D62B;
	Wed, 22 May 2024 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716380954; cv=fail; b=BXHvyUcUKEst/eM8kGNP8YBeb5xP3gWF0U7KSxw+rXDF7DPST35DvWTmHWA1SAvnPRssSVFcQzlzaccVncswPN5Du45m/lI90yIMMtvPP93e46Abchs3Xipd3bCJ4XfXXnS0AymtrjY+tcenkG/Xam+9cGgMrLbis2Z9oSllkWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716380954; c=relaxed/simple;
	bh=RYF9LjykgDVc3b1yHkamh+60DpZE4eGK26Cxm/Uteuk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=MKnjeZ4EydPB/BMVmpLUvt+R0cJGZ11imWD2Afbg5vNQ7FQo2BZ8UtZz6PhJzcH8glF42WXSc4LF0+bClHTAHz8flb/M3/gAvvEoJ+tm4EwepANgg66uxDf1ROGhn2gPT8q43KEYmHPsLrxJR5FLXaYDhJdrneWmkIVPRshwCVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GXqNTD3H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jz6YnKHE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MB4525008301;
	Wed, 22 May 2024 12:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : content-type : mime-version;
 s=corp-2023-11-20; bh=RYF9LjykgDVc3b1yHkamh+60DpZE4eGK26Cxm/Uteuk=;
 b=GXqNTD3HMXb68zVsgvWRPM9JYPgt7wdEknK/60LxJFdA8y/HSzZrGIvFP9sv4+XLdBQK
 d8LvRhh22jbirg+iKTlABRZHlR70nduReCtaYYFvayGQxL3bH9b8UnTKuHCCoAZnfxrb
 odYcARwDvxzlBrWKrBRIwG5MJ5+lks9z2zHNfrfogmrnYtQsooYgR89RhZxHkw7iruzb
 RPVKIDk3u+rhqgSd6E976pD/UwstKdnqTdXh4iZvSDZ7pwp0E46SPJfR4nZDfr3JItUB
 JZeL3TZ+LjiHb2cWza7MZAU5k1CYanqlqKpSc1xRXMbNngMfI+gByQnuFcr4ukdLXZLl 0w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mcdym5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 12:29:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MC4Kw0018194;
	Wed, 22 May 2024 12:29:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js942cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 12:29:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtloN81XvLxIu/CHVVLDgoVIJwIKzEEOk8oYj1WuqNhV6B+tOon802QQSCx1N0GmIE401Jr0UEcRspS7ZosNq9+HVAOjlKWJc17nDg3TJpWq031UNRUXsE/ycTDDSyBGRBnHuKMYuFXfDHKObO5n1AWGJEhfbt62AiFJZnWYav3BXZmbPiYkebdliycHW7gWYuGW5qiyU39y2xIbmDZI+zjtzu8bBepaoX8WFu3BLmM8X/aLvNjkNyniSmL7rL83IWMG8Hr3FRTGseTZsHn9ppZNEbiy8yWzA/2qkLdhYctfFgwJwQJEY2kWG2GQQVESGfGLtWZPvImttgAynlJmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYF9LjykgDVc3b1yHkamh+60DpZE4eGK26Cxm/Uteuk=;
 b=cnef6BrMHmDSX+0ezV1pRSEtMAT8S7V3vJiNOP/LTtY1m1npYcZIRJ8eeI188lhh0UrcRYNriNOTdW6JAusVwLkfa39UgDjC0LuDSp/58TF4QaRjJ7eoiPz/JLrvduGuluBDWEHikOTpWdSNPIif3eyVCCF4OCyWpGZi6MmXoPzRp+L9iW0eTGeg5uBIHC/Arlr1TCTj2EybEC/+3NrL+bNsXhRYeXHZPNWd6Nifnf9MT8gB7xDZ6ntQh6tUK8cef6GXatZgZtQji7bOBhHnM3mcOGAFi+DvqJ9A5KG1pygg4njGy8jzHl4s6YBdRaKipm9jkyLrQnwnMSm3rubQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYF9LjykgDVc3b1yHkamh+60DpZE4eGK26Cxm/Uteuk=;
 b=Jz6YnKHEyeBUqJXCprvnX8CsS/OUM7cvsr0s0iibcwhFKVDC6iMyHzVVCk/USajqwBGV5R7uDqin8pZs2g7YcVUo3OCnXRfiRIFNAvuPTLVfl6JqiocghyZL00b0lTp5R7uF9FSHtZm/ZPIebLuiY/IRPxFfo47nKGDvaJ8+qxA=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by DM6PR10MB4185.namprd10.prod.outlook.com (2603:10b6:5:217::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 12:28:59 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%6]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 12:28:59 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "cve@kernel.org" <cve@kernel.org>,
        "linux-cve-announce@vger.kernel.org"
	<linux-cve-announce@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: CVE-2024-27410: wifi: nl80211: reject iftype change with mesh ID
 change
Thread-Topic: CVE-2024-27410: wifi: nl80211: reject iftype change with mesh ID
 change
Thread-Index: AQHarEOf0ZTx+SdZD06FPnSsziWaGw==
Date: Wed, 22 May 2024 12:28:59 +0000
Message-ID: <42c2fa68c360d05dcf798bc783078270e8fe8314.camel@oracle.com>
In-Reply-To: <2024051701-CVE-2024-27410-874a@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5563:EE_|DM6PR10MB4185:EE_
x-ms-office365-filtering-correlation-id: fe2f7587-04bf-41bd-fc4f-08dc7a5ac1ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SiszVTY1eDk5a3QwaUlLSHpDcGNaVVBxSHprQ0V6b3RtT3JFOFY5Mm5TcG1D?=
 =?utf-8?B?aU5PWXRKUjZWYmFTS2R5WGRHcHFvdmNGd1F2dTA4cEFIdVQ0VjJnT3J1cjM0?=
 =?utf-8?B?K3BLd1o4a2hGNkFBd1h6WVVxQXZwZVh6UVhrdGVVTmhKNERvdENRV3dzaU5O?=
 =?utf-8?B?bmlTQ1lmeTF1SWZlYm1RcnpXaDlpZlV2Sk9GSE5qM3hyOWlkZDF2STgyN0Jm?=
 =?utf-8?B?dnc1WFZpL2dCaDNQd3E5enJkSzdtZk5qY3pXR0Q3UjRyc0ZPck5qVTRaNmxs?=
 =?utf-8?B?UStVbEJwK0U3REd3bkQrRzR0eDJrWjhtQ3VVVUk5blZ0YWpNekliQTEyLzE1?=
 =?utf-8?B?NjJEaXRobUs5MWpsVUdkUHRndVJtR2ZQTkV1aUZHenpSTEF0SW1EWFNaa1Vq?=
 =?utf-8?B?aVV0L0I1RVFlVGFTYnY2YWc2VGFzSC90RVF4M3JoUzNZaUVnMEQ0amt4N0J1?=
 =?utf-8?B?WHlyYWY4b0srQ25PL3M2OE5YY1BCMDdyZWtlelB0cG1PR1JJYlFrRE9jM3k2?=
 =?utf-8?B?K3A4bTduTm0zcnZyYURBb2o0MDdIZ2Q0eG1XSjNMRVcwSTY4UVA2ZEg0b0Zp?=
 =?utf-8?B?VW5vcnFmQVZnOW1MdVJYSmpxZ2NKWXkyTmJhbXZGanZrSStzcGdnVXhZeWJU?=
 =?utf-8?B?MVRFMUVNbk9JYS80ZTB3YXNqZTJHd21QRTRDZy83QjV0czN4ZTZoN3lJMDNn?=
 =?utf-8?B?SXVhT09UNi9aaXZEK3BJY3h3eER2L2JNNDhRRHhmQlZsSFZWRExlajcyQUVl?=
 =?utf-8?B?RS8xM1UvdkdlQUxsQmMrS0ttTy9UVUxVUVg3ZE1YZGdFaUhlVVNVUEFiTzJH?=
 =?utf-8?B?YTBzTm9qT2ZWUUJtZUkydEpCdWg1TDVjSXp0ZmxVY01OemhoT0JaWjlNbisw?=
 =?utf-8?B?cFlHTWw1ekxyZ05Wd2YxU25jc3BZWVBoOU84bDZmb0IwMHJxODBLbHFSYk1p?=
 =?utf-8?B?SXFIRVpGMjgxanVsRmtHK1ZyL1FBRVFyaXhSSUNIajJtNE9JQ2R6YjA0QVpV?=
 =?utf-8?B?N3o5Z01MbFkwRllkTWFGdDZVUVQ1SnY4Ymw3dFJwb3VTYitPOXY2MWRiN3lH?=
 =?utf-8?B?TVdGanZRQ1Z5cTdYZzBFeWxEWVB0cEpsSklXNEg5dmlZY011bHBqNk1wQnMr?=
 =?utf-8?B?Q0VGTU5qZ2RTbFgwRkJXK01hSndxZDgxSXk2cTFIWkZ0Sk8xa29JdExWWUk4?=
 =?utf-8?B?Qk5sYTdKS29RM0h1bHFWZFBXdldrVWVyOUp5Yk5OS1BTSW1zd05aVUFLejgv?=
 =?utf-8?B?VStwOFpnSysreGN3aU45Z0dwakRGZW8zOHJpWUZPRXFWclU3WVRPTVhFRFB2?=
 =?utf-8?B?dE84ampacGt1RWdDeWEveEk0SWlvZjZ4N3gwaE5UTkd0T3V3TkNSZGdCTEox?=
 =?utf-8?B?bWFDc0hWQ0NUQU9ibStqMjRHekpBN25OTGhtNHFPMXVUQlNmd0IzWTFHcEpR?=
 =?utf-8?B?cXZxU1hoVzlFS2hwYlNMK0J3aFlCMlI1OWo5WWR1UVdUZ2RUUHBNWnl0MGxi?=
 =?utf-8?B?RW8zWk1PemFYOE9rREtUSE5jaVcxaXE0V1Q1UURGNWtVZ1RnU2RNc3RzaGVy?=
 =?utf-8?B?UnI0UElxMS9NYlBOdks3b0NpTEhtcmhmdUozQmRnSDY1MVF1WEFFdUt4YS9E?=
 =?utf-8?B?RElHRlNoL294d2U1Zi9xWEdQQUo5alFUUjByeE1zNnhtMTVMTkpBMjk5Z1Ny?=
 =?utf-8?B?NXREeC8zTTVEME5KTWd1UlI1V3I1SE9UZllHb1V6MzQrOTlwcW9BbFRSSEt3?=
 =?utf-8?B?YkFVZnF2U3llOVM4anlPREQ2VHhqem81OVdkZVRqZXYzUVgwVzN2Uks1L211?=
 =?utf-8?B?Vit1aVBEVFI5eisyeVAwdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Nm9vTUd4UXFtek1sL3V1WTFIOWxMUUt2MUtWdjByd3ByYTVUMTR2UGtodGRq?=
 =?utf-8?B?aGE2dE9DemVGTzUyNVExVHdYWWllWUFaQW9aVzVlS2diY0kvM2FNUU4ySXAy?=
 =?utf-8?B?RXVIbVA0aGZDcTlNOENQVERuRDFwaG9zZDJpLytRdjFkWkdvLzNGUS9XSVhI?=
 =?utf-8?B?VHo3d2R3a1ZjbHhRVTQ3UWMyOTVDcGNpSXBvVk8yVXpzVEE2K05JMVBUZUth?=
 =?utf-8?B?NUhidmI5Rmc0ZHExUjYxVU1sR0RZaldEQW91MkhUWmdVb01nVWRVREoyVExL?=
 =?utf-8?B?RGJyc3RDaitiemN4L2ZEaUpuRlk3ZE96dHc1WlcxVDNqLzdWQzVyazdFcDlV?=
 =?utf-8?B?RDlxREtHSlByekVSRVZQVmQxbnpHcE5ndkNhTm9FZVZBREJyOSs3UlFGMEVt?=
 =?utf-8?B?aVF0aXliamhzZU9LbTlzVjZRNmIvQUhpY29pK04vY3RTeW5icDNYbm82aFdI?=
 =?utf-8?B?dnBHVllMVVhFOVBvZDVudGxhK2k4aFR4K05lMGtmbGFkSjB5SVJ1cUVKQ2cw?=
 =?utf-8?B?dmxIeVMzK0lwSk5rQzJ3emtZREY2UE1SVzcxUDRITDVlaVk2STdoWXcwY2RV?=
 =?utf-8?B?NmYrMFZ0cDJ4M2xQaWJyNm1wN0kxdFkyR29QY2NPK3V1Q0Z4MWFGZHFkd2g2?=
 =?utf-8?B?MTB3MjlaR0Urb1BhQWdLQ1JmUzRJRGI2SEVtZ1ZXVHEzWHEyZ3R4dlRKVHB2?=
 =?utf-8?B?bHlUa2FnenRsZy9qRytsUmxLdlZDVWhTUkppUHp4QUk4dHhYNmxNcGZ3Q1oy?=
 =?utf-8?B?Rkh3SkZjNVNudkVpenk5Z21Kd0hoMkNYeXp1b1B4b0ZBcElmS0kvblVYWFVy?=
 =?utf-8?B?SmJzdm5COEZ1S2pTT2J0ZnBOcFl0RzdpS0l6djVtYUdzVHd1Y0Q5V1A4MXl2?=
 =?utf-8?B?a2g5bDJ4Njdab0t3QjVBb0U4M2lROVVkNW1IMHlQMDBrTWVZeHNYQXo0YVU4?=
 =?utf-8?B?WVg1SDFtaEJGZTlWT0lGVHVyTGdHWTVnbEpQbTg0MVRheitONDIwQlNaY1lv?=
 =?utf-8?B?OExOak50OUpTdUdncDVEN1NYOE13NXJxb0gxazdQRFoxMVhxREsxazdIMTJk?=
 =?utf-8?B?Ri9iQVc4cUdoSmZNMUhjek4zQlRTL0V4L1MrelU1bWFSUEVSUmtkeWFFQVV2?=
 =?utf-8?B?S3RQUzN5L1hCVEtRWExWcjdHa1JlTWdzZlk5eDA5TWJLak9HRVhKRkhoVytz?=
 =?utf-8?B?WjJDSG9ZYWExakZsZmVnUDRuWVkyYk1YR2Ixa1hkSEo0VWk5bmlYRTVKS2lm?=
 =?utf-8?B?YUZldmRBTWpNYWRZY2Q4ZXQxWFJTT1hLNHU3TkNzVXJWY080RnI1YU0wSkRR?=
 =?utf-8?B?SW5FZVY2dVJXWkdhSW9JTWtwcTdNbThlQjlvWHRYbmFiVmQrK01uNkJ5YThi?=
 =?utf-8?B?Skx6NEZiUEtKamlOYms5dE5JYWN4MTVlMW85b0tVcDBMdEs1dWNFM0tBQXFn?=
 =?utf-8?B?bzVlakJ6b0FQV2ZZbjlyaWZzdFQrTFF6bC9aTEJvbnltOWQwZ2RPeTdZL2o5?=
 =?utf-8?B?VGhMS241ZGJmZ1hwSjlSU3VZZzlDQ0xLWklOaGJoa0VUN21VSjJwNnRiZnIz?=
 =?utf-8?B?ZEMyaXUyTUFjV042TnFUZUlJMytRd3I0ckRubTVYM1M1dVFKT2hDVHlKTVc0?=
 =?utf-8?B?d1RjOW9GZHdxU1JSV2VJUnNYcnowdHV1Y1ZNRG1idDk2TWc1Y25wQkdEU0RR?=
 =?utf-8?B?VE9vNFh5UG84Z2xpZEVJYjJOYk8zZ0JoMnhFUzJQNEdYbGtxT3F3a3V0OElu?=
 =?utf-8?B?dCtadTI3WncvZGxZRzNPT0JIOFRQZnpISlErWk5hdjJzUUlLYkFWYUp5TXkz?=
 =?utf-8?B?ZzlZSERnMHJZL29WUDBjcFUxMlJjeUVwbmhsNEcrTlMrTW11SmdLdzBYRlR5?=
 =?utf-8?B?OTh0Z1U5VjhEZ0tuZ2pEeXg0bndQT1lEcGZQcEpIR0xDeklxTGxFRE9CSW5r?=
 =?utf-8?B?T3A5TVhCRmllZkV4UjRQY05SVTJXUHl0Q3psWVZYeUpWZjR3Zm8rN1hBS3BB?=
 =?utf-8?B?UWQyMEltOWNZa0tZQkwrS1RlUDFKbWV2eFUxcDdQRTNzMmZpTU1jN1Z3c3hv?=
 =?utf-8?B?T09RN2RTZzhKYkRrVmtzMFhnaVAzTU52TTE4Z1d4V3dvVXRCV0FDbDhOckJL?=
 =?utf-8?B?azh3bW1kWHEzY0t0UmlHSDFaN2dsQ0srSlRZL0I2SmczalRreXNtM0NlSDJD?=
 =?utf-8?Q?Qm3sXOOkmIh/raUNrKwH1cKvXG3MRTVIVgNcjsv0k+Q1?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-mc28AfLEfVUZO+gxaMFp"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5O8w/eAFheSuKR/ZrO0prUyksOIkDy89qL3hWVGEkZ8WHgJbm7qCOMgLI9B7UL8TNQv6dWOhKXvz3Ij2VQMd+7TDBIVjXAsrbxYYec2NwiMWOuap/daN4D02rADCs6dcM+sPlu+ZN2QQsm2q8/yQE9CJ0+9u/zME9AkjSBXmHVKaU+tlSw5THjuSvER3ct6vbu7iz/C10pMZZTnrKX4VDeCKiVtivMvNAayLW4u1GV4S2U1FbdPL0+LrJYeFWpdQwbIUhzIZtWEKUtT0Y+9d2PRe+VGGLLy0a0SCiE35yo5nEQ70q55HuNxNbGfvq225NW1mAU4de+CmSTbEZMTitA7sB188XbXEfY8G/ZhJIAOCDzt1Pqx0DiMCoWFZsqCBZwP38qqePuQGTN2WcvD/ZCBZBwLN0aeDZEgP4xS+DdCRKod9ARYRHiHxScuoAvkzxLWoI+0ivgx85QK1xtEmDL7vjUZzLrQmrzJ/hhDzfTYGHT+P6LEhNa7QHBcUTk/pHoEbOsgur946hFqHEId8aZNh7+90M7gXvYanyll3Mw/k3ZPwhRDPeHU1PVccmvLgRTlKMiPDQRKcQeliGeo0MGm2KDLC94qtGwfdK7dUa6c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2f7587-04bf-41bd-fc4f-08dc7a5ac1ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 12:28:59.4640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxMFtDxwxac+eU2HZbejj/lAaK0VYJcgqk0EwFSjBBqt7A+GMUIqfyICpjqwDDksYjspJz4OtVQLXa8NgQKAbj5oRmFy5JgE8wgBksPiZJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_05,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220083
X-Proofpoint-ORIG-GUID: itvHzVjm6YoiGGmVwiH9z6hiksogHx1c
X-Proofpoint-GUID: itvHzVjm6YoiGGmVwiH9z6hiksogHx1c

--=-mc28AfLEfVUZO+gxaMFp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 17 May 2024 13:52:02 +0200, Greg Kroah-Hartman wrote:
> In the Linux kernel, the following vulnerability has been resolved:
>=20
> wifi: nl80211: reject iftype change with mesh ID change
>=20
> It's currently possible to change the mesh ID when the
> interface isn't yet in mesh mode, at the same time as
> changing it into mesh mode. This leads to an overwrite
> of data in the wdev->u union for the interface type it
> currently has, causing cfg80211_change_iface() to do
> wrong things when switching.
>=20
> [...]
>=20
> The Linux kernel CVE team has assigned CVE-2024-27410 to this issue.

This does not apply to versions below 6.0, as the union was not backported.
The fix commit mentioned is incorrect, it should be 7b0a0e3c3a88.

Thanks,
Siddh

--=-mc28AfLEfVUZO+gxaMFp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmZN5QIACgkQBwq/MEwk
8iqrBhAAgisD+BIpr9WVY/BPEqIQytfV1wdYZGYIevm9qZqzEyPfzN05SXv2J4JA
AkTyAuQH/j2m3it06HubaIfe+vsy6fgza5Gq7TsnSC6T7cap3ZG2NXjqD3RKr4I1
38LkFPpsTx3cKxAiVvYDD3kY9FEPhuak1zBEEHRhkWd0V+Qqp7SRUEsgSrFbyisG
P4xS11WBtmCW66mzVkC4CnM1074jvLNHGDTbiU36G+S0K+Mq9i+G+zHw27Q1zh+I
CLBE0YpIjbCGa6CSbb5HyimMEjZgvH9qp9hyF/ouW5le70BJPldgQwZjQ6gdDZiG
n1fDi9lmP0o5PxpcN4T8WbHVyzGndDbBANssEDD0cwMxwFDQzSYUoCOT7uRW+oTP
EwhxqN1A6Esf0S8I73+vu1XYH8ajRVe7dh1AddO+DLVk+rKs2BYSYtpY+f/TswzQ
P44Igt4J/UCbLyd0IoxANEyLW0Dj3cxO0Jah/Q7oMlYiFEZ8P3w/Jp7osIDvIi3h
TZC/2ea6KKpWPqY5Q7RSsd2YO+p3mc4PCH4/+j1VMsbQDyGmeZ5rAn2g0Bv4l/k5
HeBsYWTvqzzmbht3SdzG/5MfgMXI90NvExpErI+ceAxV8UxHpfT8RECpnKEqZzo5
wd5+qSL4ACtD0xi+WGOrFcbSUotAyYc4IE1t/q2gwD/w/LxD4Hc=
=QApe
-----END PGP SIGNATURE-----

--=-mc28AfLEfVUZO+gxaMFp--

